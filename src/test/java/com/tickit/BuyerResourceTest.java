package com.tickit;

import com.tickit.buyer.BuyerEntity;
import io.quarkus.test.junit.QuarkusTest;
import io.restassured.http.ContentType;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import javax.ws.rs.core.Response;
import java.util.Random;

import static io.restassured.RestAssured.given;
import static org.hamcrest.Matchers.blankOrNullString;

@QuarkusTest
public class BuyerResourceTest {

    @BeforeAll
    static void beforeAll() {
        BuyerEntity.delete("userid >= $1", 50000);
    }

    @Test
    public void testGetBuyersWithPaginationParameters() {

        given()
                .when()
                .get("v1/buyers?page=1&size=1")
                .then()
                .statusCode(Response.Status.OK.getStatusCode());
    }

    @Test
    public void testGetBuyersWithoutPaginationParameters() {

        given()
                .when()
                .get("v1/buyers")
                .then()
                .statusCode(200);
    }

    @Test
    public void testCreateBuyer() {

        BuyerEntity userNew = given()
                .contentType(ContentType.JSON)
                .accept(ContentType.JSON)
                .body(createBuyer(1))
                .when()
                .post("v1/buyers")
                .then()
                .statusCode(Response.Status.CREATED.getStatusCode())
                .extract()
                .as(BuyerEntity.class);

        Assertions.assertEquals(userNew.username, "TESTUSR1");
    }

    @Test
    public void testUpdateBuyer() {

        BuyerEntity userOriginal = given()
                .contentType(ContentType.JSON)
                .accept(ContentType.JSON)
                .body(createBuyer(2))
                .when()
                .post("v1/buyers")
                .then()
                .statusCode(Response.Status.CREATED.getStatusCode())
                .extract()
                .as(BuyerEntity.class);

        BuyerEntity userUpdated = given()
                .contentType(ContentType.JSON)
                .accept(ContentType.JSON)
                .and()
                .body(createBuyer(3))
                .when()
                .put("v1/buyers/{id}", userOriginal.id)
                .then()
                .statusCode(Response.Status.OK.getStatusCode())
                .extract()
                .as(BuyerEntity.class);

        Assertions.assertEquals(userUpdated.username, "TESTUSR3");

    }

    @Test
    public void testDeleteBuyer() {

        BuyerEntity userNew = given()
                .contentType(ContentType.JSON)
                .accept(ContentType.JSON)
                .body(createBuyer(4))
                .when()
                .post("v1/buyers")
                .then()
                .statusCode(Response.Status.CREATED.getStatusCode())
                .extract()
                .as(BuyerEntity.class);

        given()
                .contentType(ContentType.JSON)
                .accept(ContentType.JSON)
                .when()
                .delete("v1/buyers/{id}", userNew.id)
                .then()
                .statusCode(Response.Status.NO_CONTENT.getStatusCode())
                .body(blankOrNullString());
    }

    private BuyerEntity createBuyer(int testBuyerId) {
        Random rd = new Random();

        BuyerEntity buyer = new BuyerEntity();
        buyer.username = String.format("TESTUSR%s", testBuyerId);
        buyer.firstName = "Test";
        buyer.lastName = String.format("Buyer%s", testBuyerId);
        buyer.city = String.format("TestCity%s", testBuyerId);
        buyer.state = String.format("T%s", testBuyerId);
        buyer.email = String.format("testuser%s@testdomain.com", testBuyerId);
        buyer.phone = "(123) 456-7890";
        buyer.likeSports = rd.nextBoolean();
        buyer.likeTheatre = rd.nextBoolean();
        buyer.likeConcerts = rd.nextBoolean();
        buyer.likeJazz = rd.nextBoolean();
        buyer.likeClassical = rd.nextBoolean();
        buyer.likeOpera = rd.nextBoolean();
        buyer.likeRock = rd.nextBoolean();
        buyer.likeVegas = rd.nextBoolean();
        buyer.likeBroadway = rd.nextBoolean();
        buyer.likeMusicals = rd.nextBoolean();
        return buyer;
    }

}