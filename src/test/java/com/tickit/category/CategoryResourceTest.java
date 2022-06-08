package com.tickit.category;

import io.quarkus.test.junit.QuarkusTest;
import io.restassured.common.mapper.TypeRef;
import io.restassured.http.ContentType;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import javax.ws.rs.core.Response;
import java.util.List;

import static io.restassured.RestAssured.given;
import static java.lang.Integer.parseInt;
import static org.hamcrest.Matchers.blankOrNullString;

@QuarkusTest
public
class CategoryResourceTest {

    public static final String RESOURCE_PREFIX = "v1/categories";

    @BeforeEach
    void setUp() {
    }

    @AfterEach
    void tearDown() {
    }

    @Test
    void list() {
        // Assumes test data was created using import.sql script

        int defaultPageSize = 5;

        List<CategoryEntity> category = given()
                .when()
                .get(RESOURCE_PREFIX)
                .then()
                .statusCode(Response.Status.OK.getStatusCode())
                .extract()
                .as(new TypeRef<>() {
                });

        Assertions.assertEquals(category.size(), defaultPageSize);
    }

    @Test
    void listWithQueryParamsAsc() {
        // Assumes test data was created using import.sql script

        List<CategoryEntity> category = given()
                .when()
                .get(RESOURCE_PREFIX + "?page=1&size=1&sort_by=id")
                .then()
                .statusCode(Response.Status.OK.getStatusCode())
                .extract()
                .as(new TypeRef<>() {
                });

        Assertions.assertEquals(category.size(), 1);
        Assertions.assertEquals(category.get(0).id, 1);
    }

    @Test
    void listWithQueryParamsDesc() {
        // Assumes test data was created using import.sql script

        List<CategoryEntity> category = given()
                .when()
                .get(RESOURCE_PREFIX + "?page=1&size=1&sort_by=id&order_by=desc")
                .then()
                .statusCode(Response.Status.OK.getStatusCode())
                .extract()
                .as(new TypeRef<>() {
                });

        Assertions.assertEquals(category.size(), 1);
        Assertions.assertNotEquals(category.get(0).id, 1);
    }

    @Test
    void get() {
        String testId = "GetTest";

        CategoryEntity category = given()
                .contentType(ContentType.JSON)
                .accept(ContentType.JSON)
                .body(createCategory(testId))
                .when()
                .post(RESOURCE_PREFIX)
                .then()
                .statusCode(Response.Status.CREATED.getStatusCode())
                .extract()
                .as(CategoryEntity.class);

        CategoryEntity categoryGet = given()
                .when()
                .get(RESOURCE_PREFIX + "/{id}", category.id)
                .then()
                .statusCode(Response.Status.OK.getStatusCode())
                .extract()
                .as(CategoryEntity.class);

        Assertions.assertEquals(categoryGet.name, testId);
    }

    @Test
    void create() {
        String testId = "CreateTest";

        CategoryEntity category = given()
                .contentType(ContentType.JSON)
                .accept(ContentType.JSON)
                .body(createCategory(testId))
                .when()
                .post(RESOURCE_PREFIX)
                .then()
                .statusCode(Response.Status.CREATED.getStatusCode())
                .extract()
                .as(CategoryEntity.class);

        Assertions.assertEquals(category.name, testId);
    }

    @Test
    void update() {
        String testIdOrg = "CreateTest";

        CategoryEntity categoryOriginal = given()
                .contentType(ContentType.JSON)
                .accept(ContentType.JSON)
                .body(createCategory(testIdOrg))
                .when()
                .post(RESOURCE_PREFIX)
                .then()
                .statusCode(Response.Status.CREATED.getStatusCode())
                .extract()
                .as(CategoryEntity.class);

        String testIdMod = "UpdateTest";

        CategoryEntity categoryUpdated = given()
                .contentType(ContentType.JSON)
                .accept(ContentType.JSON)
                .and()
                .body(createCategory(testIdMod))
                .when()
                .put(RESOURCE_PREFIX + "/{id}", categoryOriginal.id)
                .then()
                .statusCode(Response.Status.OK.getStatusCode())
                .extract()
                .as(CategoryEntity.class);

        Assertions.assertEquals(categoryUpdated.name, testIdMod);
    }

    @Test
    void delete() {
        String testId = "DeleteTest";

        CategoryEntity category = given()
                .contentType(ContentType.JSON)
                .accept(ContentType.JSON)
                .body(createCategory(testId))
                .when()
                .post(RESOURCE_PREFIX)
                .then()
                .statusCode(Response.Status.CREATED.getStatusCode())
                .extract()
                .as(CategoryEntity.class);

        given()
                .contentType(ContentType.JSON)
                .accept(ContentType.JSON)
                .when()
                .delete(RESOURCE_PREFIX + "/{id}", category.id)
                .then()
                .statusCode(Response.Status.NO_CONTENT.getStatusCode())
                .body(blankOrNullString());
    }

    @Test
    void count() {
        String testId = "CountTest";

        given()
                .contentType(ContentType.JSON)
                .accept(ContentType.JSON)
                .body(createCategory(testId))
                .when()
                .post(RESOURCE_PREFIX)
                .then()
                .statusCode(Response.Status.CREATED.getStatusCode());

        String categoryCount = given()
                .when()
                .get(RESOURCE_PREFIX + "/count")
                .then()
                .statusCode(Response.Status.OK.getStatusCode())
                .extract()
                .asString();

        Assertions.assertTrue(parseInt(categoryCount) > 0);
    }

    // Instantiates new CategoryEntity
    private CategoryEntity createCategory(String testId) {
        CategoryEntity category = new CategoryEntity();

        category.group = testId;
        category.name = testId;
        category.description = testId;

        return category;
    }
}