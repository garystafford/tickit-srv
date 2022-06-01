package com.tickit.listing;

import com.tickit.event.EventEntity;
import com.tickit.seller.SellerEntity;
import io.quarkus.hibernate.reactive.panache.PanacheEntityBase;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "listing", schema = "public", catalog = "tickit")
@NamedQueries({
        @NamedQuery(name = "ListingEntity.getByCategoryId", query = """
                select listing, event, category
                from ListingEntity as listing
                    join listing.event as event
                    join event.category as category
                where category.id = ?1"""
        ),
        @NamedQuery(name = "ListingEntity.getByVenueId", query = """
                select listing, event, venue
                from ListingEntity as listing
                    join listing.event as event
                    join event.venue as venue
                where venue.id = ?1"""
        )})
public class ListingEntity extends PanacheEntityBase {

    @Id
    @SequenceGenerator(
            name = "listingSeq",
            sequenceName = "listing_list_id_seq",
            schema = "public",
            initialValue = 250000,
            allocationSize = 1)
    @GeneratedValue(
            strategy = GenerationType.SEQUENCE,
            generator = "listingSeq")
    @Column(name = "listid", nullable = false)
    public int id;
    @Column(name = "numtickets", nullable = false)
    public short numTickets;
    @Column(name = "priceperticket", nullable = false, precision = 2)
    public BigDecimal pricePerTicket;
    @Column(name = "totalprice", nullable = false, precision = 2)
    public BigDecimal totalPrice;
    @Column(name = "listtime", nullable = false)
    public LocalDateTime listTime;
    @ManyToOne(optional = false)
    @JoinColumn(name = "sellerid", referencedColumnName = "sellerid", nullable = false)
    public SellerEntity seller;
    @ManyToOne(optional = false)
    @JoinColumn(name = "eventid", referencedColumnName = "eventid", nullable = false)
    public EventEntity event;
}
