Return-Path: <netdev+bounces-281878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILhlCKq/8GnSYAEAu9opvQ
	(envelope-from <netdev+bounces-281878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:09:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C744486954
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6CEC3349E2F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C863939AC;
	Tue, 28 Apr 2026 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CW3N0LnN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Plia3UEQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BDE28C037
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382547; cv=none; b=M03jySy3Bcm8JiS/z8NuwYfQr5HYoRIQVV9nwi/zUyZC00XVqgh3OJLym+DwX0nHamxEdroVLp+geXBREO412sIXKMAL1sUgcD6/xxnQx7blihrwW3IXgatUkL1Vmtso60c2aL7zk/a0BKe0sF138+Ybftad9KhYy2LQs9/aeLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382547; c=relaxed/simple;
	bh=2BB9SsZnD1oUi/iZNMFAyjkEk2+CmkyVl1grdupCgZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkQIgrsTxYZPq+cJ5CUVCvFB3ljkQZLV0xnGSQ2M/dyNwJMu539gHh7R8UbHEhEGcOF1gCEpQ4GgS/1NsEmEa0nx3Y1PuvDPU2rSWT6sdmx9KosCToSk6aucW3HUo505GgAeiE2sdI7i9DMgq2kONWnLHhfKixjAZzd5PadLwew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CW3N0LnN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Plia3UEQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777382544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=voE5hj3Jt4qgd9THMxCkOfk/n2r5u/BP+6aC7p7RNyk=;
	b=CW3N0LnNC6+6cOFiYMTVycjQQLjMUZWnx/xplMwsG/er5Z/2SkF5X69nObHsCV6qwPvSX3
	bfi1cAz6QIxg7I+6Ltt+Nuw6TrkU1B3+I4+Ir4TbfbOIIDUFYGd9x+hd05/Q20EXbUhJYd
	bZwZrV0Lj6a5QtPsHKZcB5/1aDrC2fU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-dNOVRw0UOIOxSVpz2Zp5iQ-1; Tue, 28 Apr 2026 09:22:22 -0400
X-MC-Unique: dNOVRw0UOIOxSVpz2Zp5iQ-1
X-Mimecast-MFC-AGG-ID: dNOVRw0UOIOxSVpz2Zp5iQ_1777382541
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-440d12a472eso8411647f8f.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 06:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777382541; x=1777987341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=voE5hj3Jt4qgd9THMxCkOfk/n2r5u/BP+6aC7p7RNyk=;
        b=Plia3UEQ4mI+kXP9VPN2wF1Qt8sFJiL6IwR59KVfHkQ9FlQ6wpFbq7vsg9BuqwcKkz
         rw3F+as7zn863kFscIDhgODcpxC8D4I/j8mEGTmb7FjWpd3z8Zh4n6XhU6llxkPNMv6W
         UpzUsyZJwgQwIuhvR8/WU7JKcvSmTd/+uRtT9ahEvyQ16wnjBS7nlOLrn4oMzl12/9e3
         V3Va78AigXvYCvLvm9w5JtSkQGvEJcZMY5lBpqKVW/cCbpjrtm5m9Zmc4sF0lg6y+N16
         byRSDtCOUcjKo3TSl94CPbDLuklnhROSMpDJOtDyht8gOtsuSBQf9vGtJ05i7EwfgA9U
         0iIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777382541; x=1777987341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voE5hj3Jt4qgd9THMxCkOfk/n2r5u/BP+6aC7p7RNyk=;
        b=iR8NbcCdsLMM8Zt0Zv0P6MWDodCBmOQ4svmmTiASE+5ZcQbufkIkvquodKZiqWSLy3
         /U0bL4nwdnZMTv2wB71HxZGeJOxHOigM8VO1ss0P8zLVhj47DaiCilStSs581EgT9Lax
         6bqaDzTA3ZskIWTUvv287PR1Cm/DztA02NBJRh871z/vUoDibVgZsTTqJKLhJ8Nwb23T
         tO64o1CorN+YG+h2PftDEQxxKcJ6tR/J0qfwZyZwTFPwpaQPRI/lv4SNhcFXwhkL5/At
         pGgbJ3kAd7nghIJNOvfUdF5pWIvR/q0rNLKelIAPMKgGyHTJa9GeS1jKH1N7jG3j+J6N
         EEUQ==
X-Forwarded-Encrypted: i=1; AFNElJ9R8dfQbb7BIIhXwTIuUNxz352bn1amg0z+xAKcW5FSjqZlSCTTGY+hfpefvFKtbUzmDv0wpJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn1zHaQCchfRp4HpZ+qNBLaSnyxWMRHby+Dyb5sUjizt7VdR2S
	7KAgthRjOiLLVDX0NYyq1NLK7Su5V5D8NwDGB8/vL0UXQG2VydGGfJM8ifmvsMh4rHVlNPq7qab
	EYibiw0XCBcSMzO/W5faVxj/dz+989zOg9Qsk5S8xmsvNd1j5OTGmuhUxBA==
X-Gm-Gg: AeBDievq8eDwpEeXVTT7+zblcFa/d004xErKc1ECCGZ+FW0sVubspI6SDOwB5lgXufV
	6e/u1mku3QLnzRUjGVoL6DgKurCnDXBl3DUi6oVEluRWAHY5amEvQ+wSTI5J3tNXZ0iEn5EOrpW
	Q1AXPlpTzGmRmVcpR0DLxHuV/J7nL3+ZFC2PxtD1Ccd+dcyw4Rcl6PM2cPQ/8VdP6bHhgjT0TiY
	q9HbQaTeNPSSCu5yVjihQ2zTWFIsIGd+fDU9SceeuJls/l4TFbY4qWvgv6xDZ1WLLE/SQ9xT55w
	06i1dwaVEUXt19CdjPj8IS/kSTLifsnwbigFb1TJqWzqsp2Cr1b+veBW+IjEaol9Z2bFIgzw2It
	DRPI9alFkDyI7KrcV726HkklZzFhH6A9MHs7cyUIz0ACz+krgHo5FwyKZ
X-Received: by 2002:a05:6000:2c01:b0:43d:773d:78ff with SMTP id ffacd0b85a97d-4464a1684bdmr5626387f8f.27.1777382540745;
        Tue, 28 Apr 2026 06:22:20 -0700 (PDT)
X-Received: by 2002:a05:6000:2c01:b0:43d:773d:78ff with SMTP id ffacd0b85a97d-4464a1684bdmr5626286f8f.27.1777382540032;
        Tue, 28 Apr 2026 06:22:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463d02f6a1sm6487599f8f.13.2026.04.28.06.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:22:18 -0700 (PDT)
Date: Tue, 28 Apr 2026 09:22:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v9 4/4] tun/tap & vhost-net: avoid ptr_ring
 tail-drop when a qdisc is present
Message-ID: <20260428092150-mutt-send-email-mst@kernel.org>
References: <20260428123859.19578-1-simon.schippers@tu-dortmund.de>
 <20260428123859.19578-5-simon.schippers@tu-dortmund.de>
 <20260428084851-mutt-send-email-mst@kernel.org>
 <cdc3cbc8-cf6a-437c-b34c-dd8ced65d7f8@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdc3cbc8-cf6a-437c-b34c-dd8ced65d7f8@tu-dortmund.de>
X-Rspamd-Queue-Id: 6C744486954
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281878-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tu-dortmund.de:email]

On Tue, Apr 28, 2026 at 03:10:44PM +0200, Simon Schippers wrote:
> On 4/28/26 14:50, Michael S. Tsirkin wrote:
> > On Tue, Apr 28, 2026 at 02:38:59PM +0200, Simon Schippers wrote:
> >> This commit prevents tail-drop when a qdisc is present and the ptr_ring
> >> becomes full. Once an entry is successfully produced and the ptr_ring
> >> reaches capacity, the netdev queue is stopped instead of dropping
> >> subsequent packets.
> >>
> >> If producing an entry fails anyways due to a race, tun_net_xmit returns
> >> NETDEV_TX_BUSY, again avoiding a drop. Such races are expected because
> >> LLTX is enabled and the transmit path operates without the usual locking.
> >>
> >> If no qdisc is present, the previous tail-drop behavior is preserved.
> >>
> >> The existing __tun_wake_queue() function of the consumer races with the
> >> producer for waking/stopping the netdev queue: the consumer may drain
> >> the ring just as the producer stops the queue, leading to a permanent
> >> stall. To avoid this, the producer re-checks the ring after stopping
> >> and wakes the queue itself if space was just made. An
> >> smp_mb__after_atomic() is required so the re-peek of the ring sees any
> >> drain that the consumer performed.
> >> smp_mb__after_atomic() pairs with the test_and_clear_bit() inside of
> >> netif_wake_subqueue():
> >>
> >> Consumer CPU                  Producer CPU
> >> ========================      =========================
> >> __ptr_ring_consume()
> >> netif_wake_subqueue()         netif_tx_stop_queue()
> >>           /\                  smp_mb__after_atomic()
> >>           ||                  __ptr_ring_produce_peek()
> >> contains RMW operation
> >>  test_and_clear_bit()
> >>           /\
> >>           ||
> >>  "Fully ordered RMW:
> >> smp_mb() before + after"
> >>     - atomic_t.txt
> >>
> >> Benchmarks:
> >> The benchmarks show a slight regression in raw transmission performance,
> >> though no packets are lost anymore.
> > 
> > Could you include the packets received as well?
> > To demonstrate the gains/lack of loss. 
> > 
> 
> Do you mean the number of packets received by the VM?
> They should just be the same as the number sent (shown below), right?

Minus the loss? Which this is about, right?

> I assume they would be visible as RX-DRP for TAP.
> For TAP + vhost-net I would have to rewrite the XDP drop
> program to count the number of dropped packets...
> And I would have to automate it...
> 
> >>
> >> The previously introduced threshold to only wake after the queue stopped
> >> and half of the ring was consumed showed to be a descent choice:
> >> Waking the queue whenever a consume made space in the ring strongly
> >> degrades performance for tap, while waking only when the ring is empty
> >> is too late and also hurts throughput for tap & tap+vhost-net.
> >> Other ratios (3/4, 7/8) showed similar results (not shown here), so
> >> 1/2 was chosen for the sake of simplicity for both tun/tap and
> >> tun/tap+vhost-net.
> >>
> >> Test setup:
> >> AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
> >> Average over 50 runs @ 100,000,000 packets. SRSO and spectre v2
> >> mitigations disabled.
> >>
> >> Note for tap+vhost-net:
> >> XDP drop program active in VM -> ~2.5x faster, slower for tap due to
> >> more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in perf)
> >>
> >> +--------------------------+--------------+----------------+----------+
> >> | 1 thread                 | Stock        | Patched with   | diff     |
> >> | sending                  |              | fq_codel qdisc |          |
> >> +------------+-------------+--------------+----------------+----------+
> >> | TAP        | Transmitted | 1.136 Mpps   | 1.130 Mpps     | -0.6%    |
> >> |            +-------------+--------------+----------------+----------+
> >> |            | Lost/s      | 3.758 Mpps   | 0 pps          |          |
> >> +------------+-------------+--------------+----------------+----------+
> >> | TAP        | Transmitted | 3.858 Mpps   | 3.816 Mpps     | -1.1%    |
> >> |            +-------------+--------------+----------------+----------+
> >> | +vhost-net | Lost/s      | 789.8 Kpps   | 0 pps          |          |
> >> +------------+-------------+--------------+----------------+----------+
> >>
> >> +--------------------------+--------------+----------------+----------+
> >> | 2 threads                | Stock        | Patched with   | diff     |
> >> | sending                  |              | fq_codel qdisc |          |
> >> +------------+-------------+--------------+----------------+----------+
> >> | TAP        | Transmitted | 1.117 Mpps   | 1.087 Mpps     | -2.7%    |
> >> |            +-------------+--------------+----------------+----------+
> >> |            | Lost/s      | 8.476 Mpps   | 0 pps          |          |
> >> +------------+-------------+--------------+----------------+----------+
> >> | TAP        | Transmitted | 3.679 Mpps   | 3.464 Mpps     | -5.8%    |
> >> |            +-------------+--------------+----------------+----------+
> >> | +vhost-net | Lost/s      | 5.306 Mpps   | 0 pps          |          |
> >> +------------+-------------+--------------+----------------+----------+
> >>
> >> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >> ---
> >>  drivers/net/tun.c | 30 ++++++++++++++++++++++++++++--
> >>  1 file changed, 28 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >> index efe809597622..c2a1618cc9db 100644
> >> --- a/drivers/net/tun.c
> >> +++ b/drivers/net/tun.c
> >> @@ -1011,6 +1011,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
> >>  	struct netdev_queue *queue;
> >>  	struct tun_file *tfile;
> >>  	int len = skb->len;
> >> +	bool qdisc_present;
> >> +	int ret;
> >>  
> >>  	rcu_read_lock();
> >>  	tfile = rcu_dereference(tun->tfiles[txq]);
> >> @@ -1065,13 +1067,37 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
> >>  
> >>  	nf_reset_ct(skb);
> >>  
> >> -	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> >> +	queue = netdev_get_tx_queue(dev, txq);
> >> +	qdisc_present = !qdisc_txq_has_no_queue(queue);
> >> +
> >> +	spin_lock(&tfile->tx_ring.producer_lock);
> >> +	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
> >> +	if (__ptr_ring_produce_peek(&tfile->tx_ring) && qdisc_present) {
> >> +		netif_tx_stop_queue(queue);
> >> +		/* Re-peek and wake if the consumer drained the ring
> >> +		 * concurrently in a race. smp_mb__after_atomic() pairs
> >> +		 * with the test_and_clear_bit() of netif_wake_subqueue()
> >> +		 * in __tun_wake_queue().
> >> +		 */
> >> +		smp_mb__after_atomic();
> >> +		if (!__ptr_ring_produce_peek(&tfile->tx_ring))
> >> +			netif_tx_wake_queue(queue);
> >> +	}
> >> +	spin_unlock(&tfile->tx_ring.producer_lock);
> >> +
> >> +	if (ret) {
> >> +		/* If a qdisc is attached to our virtual device,
> >> +		 * returning NETDEV_TX_BUSY is allowed.
> >> +		 */
> >> +		if (qdisc_present) {
> >> +			rcu_read_unlock();
> >> +			return NETDEV_TX_BUSY;
> >> +		}
> >>  		drop_reason = SKB_DROP_REASON_FULL_RING;
> >>  		goto drop;
> >>  	}
> >>  
> >>  	/* dev->lltx requires to do our own update of trans_start */
> >> -	queue = netdev_get_tx_queue(dev, txq);
> >>  	txq_trans_cond_update(queue);
> >>  
> >>  	/* Notify and wake up reader process */
> >> -- 
> >> 2.43.0
> > 


