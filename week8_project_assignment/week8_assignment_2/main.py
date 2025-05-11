from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import psycopg2
from psycopg2.extras import RealDictCursor
from typing import List

app = FastAPI(title="Inventory Tracking API")

# Database connection configuration
db_config = {
    "host": "localhost",
    "database": "sampledb",
    "user": "postgres",
    "password": "alex",  
    "port": "5432"
}

# Pydantic models for request/response validation
class Category(BaseModel):
    CategoryID: int | None = None
    CategoryName: str
    Description: str | None = None

class Product(BaseModel):
    ProductID: int | None = None
    ProductName: str
    CategoryID: int
    Price: float
    StockQuantity: int

# Database connection helper
def get_db_connection():
    return psycopg2.connect(**db_config)

# CRUD Operations for Categories
@app.post("/categories/", response_model=Category)
async def create_category(category: Category):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(
            "INSERT INTO Categories (CategoryName, Description) VALUES (%s, %s) RETURNING CategoryID",
            (category.CategoryName, category.Description)
        )
        category_id = cursor.fetchone()[0]
        conn.commit()
        return {**category.dict(), "CategoryID": category_id}
    except psycopg2.Error as e:
        raise HTTPException(status_code=400, detail=str(e))
    finally:
        cursor.close()
        conn.close()

@app.get("/categories/", response_model=List[Category])
async def read_categories():
    conn = get_db_connection()
    cursor = conn.cursor(cursor_factory=RealDictCursor)
    try:
        cursor.execute("SELECT * FROM Categories")
        categories = cursor.fetchall()
        return categories
    finally:
        cursor.close()
        conn.close()

@app.get("/categories/{category_id}", response_model=Category)
async def read_category(category_id: int):
    conn = get_db_connection()
    cursor = conn.cursor(cursor_factory=RealDictCursor)
    try:
        cursor.execute("SELECT * FROM Categories WHERE CategoryID = %s", (category_id,))
        category = cursor.fetchone()
        if not category:
            raise HTTPException(status_code=404, detail="Category not found")
        return category
    finally:
        cursor.close()
        conn.close()

@app.put("/categories/{category_id}", response_model=Category)
async def update_category(category_id: int, category: Category):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(
            "UPDATE Categories SET CategoryName = %s, Description = %s WHERE CategoryID = %s",
            (category.CategoryName, category.Description, category_id)
        )
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="Category not found")
        conn.commit()
        return {**category.dict(), "CategoryID": category_id}
    except psycopg2.Error as e:
        raise HTTPException(status_code=400, detail=str(e))
    finally:
        cursor.close()
        conn.close()

@app.delete("/categories/{category_id}")
async def delete_category(category_id: int):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("DELETE FROM Categories WHERE CategoryID = %s", (category_id,))
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="Category not found")
        conn.commit()
        return {"message": "Category deleted"}
    finally:
        cursor.close()
        conn.close()

# CRUD Operations for Products
@app.post("/products/", response_model=Product)
async def create_product(product: Product):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(
            "INSERT INTO Products (ProductName, CategoryID, Price, StockQuantity) VALUES (%s, %s, %s, %s) RETURNING ProductID",
            (product.ProductName, product.CategoryID, product.Price, product.StockQuantity)
        )
        product_id = cursor.fetchone()[0]
        conn.commit()
        return {**product.dict(), "ProductID": product_id}
    except psycopg2.Error as e:
        raise HTTPException(status_code=400, detail=str(e))
    finally:
        cursor.close()
        conn.close()

@app.get("/products/", response_model=List[Product])
async def read_products():
    conn = get_db_connection()
    cursor = conn.cursor(cursor_factory=RealDictCursor)
    try:
        cursor.execute("SELECT * FROM Products")
        products = cursor.fetchall()
        return products
    finally:
        cursor.close()
        conn.close()

@app.get("/products/{product_id}", response_model=Product)
async def read_product(product_id: int):
    conn = get_db_connection()
    cursor = conn.cursor(cursor_factory=RealDictCursor)
    try:
        cursor.execute("SELECT * FROM Products WHERE ProductID = %s", (product_id,))
        product = cursor.fetchone()
        if not product:
            raise HTTPException(status_code=404, detail="Product not found")
        return product
    finally:
        cursor.close()
        conn.close()

@app.put("/products/{product_id}", response_model=Product)
async def update_product(product_id: int, product: Product):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(
            "UPDATE Products SET ProductName = %s, CategoryID = %s, Price = %s, StockQuantity = %s WHERE ProductID = %s",
            (product.ProductName, product.CategoryID, product.Price, product.StockQuantity, product_id)
        )
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="Product not found")
        conn.commit()
        return {**product.dict(), "ProductID": product_id}
    except psycopg2.Error as e:
        raise HTTPException(status_code=400, detail=str(e))
    finally:
        cursor.close()
        conn.close()

@app.delete("/products/{product_id}")
async def delete_product(product_id: int):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("DELETE FROM Products WHERE ProductID = %s", (product_id,))
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="Product not found")
        conn.commit()
        return {"message": "Product deleted"}
    finally:
        cursor.close()
        conn.close()