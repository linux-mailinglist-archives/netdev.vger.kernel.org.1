Return-Path: <netdev+bounces-281908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOKlMYjD8GnMYQEAu9opvQ
	(envelope-from <netdev+bounces-281908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:26:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46663486E75
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9002231D2786
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632D43FD12B;
	Tue, 28 Apr 2026 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHMoLsmi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDIHizC5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C449143DA5B
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777385423; cv=none; b=ajxrc8YeF6B7klkha8sBpIxDdOtRB5vJTd6q9E00jIICrLJPkulKVM2IkbFXc9EGY2R4ywTpPH9V9vb5Y938fB+Mc3pQVEXx3H6VOy9zHpJysEv9bJC8xQxE39iFUh1hBfNpFMJhvao685K2LAUdGNzcFFjw8mtzfyVmlUt+O0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777385423; c=relaxed/simple;
	bh=aIlgWL9/0pGueQ0AKrJko6Zr82igCKUb4r8NWEDLG7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsRnOBAYuTDfkxkEZ84+u9al4gzd3IgO5YZgXT0WzLzlEtPiAsD8WBQl+Fq/+DHC0c8ZZNgA1pXG235Rot0An532rHZtqY/ushXo4VvehUhepcEkgj7IQdE3Q9tJv2fWGOR4UCE7cuyNN7UFBD3rAYRBRNn2gyA2oE3mj2y4ZHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dHMoLsmi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDIHizC5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777385420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ymlOvxmwGZ8VtNX0ef8EHtkI32hxd4KqndZm7HincXA=;
	b=dHMoLsmitKOfGLQqKjofmvtYlmDSiiENvX/XOx8BupwYawp1MUhgNBdke2zVBK+Dw2lkHc
	2ARPUFYYjgyU1e+J6faPiRXGlT+XGQcZAMWiC5JnH7kOhcnnZgWyNGJGhgUITfiZOTItR1
	OFIPwX3IpDOqNcWSWZ/eqRODF/CKIO8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-7NdDplx1N6uHGbPO0sqs3w-1; Tue, 28 Apr 2026 10:10:17 -0400
X-MC-Unique: 7NdDplx1N6uHGbPO0sqs3w-1
X-Mimecast-MFC-AGG-ID: 7NdDplx1N6uHGbPO0sqs3w_1777385416
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4411a1f9601so7681584f8f.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 07:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777385416; x=1777990216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ymlOvxmwGZ8VtNX0ef8EHtkI32hxd4KqndZm7HincXA=;
        b=gDIHizC5S2YAEkFl4ONS+8CeIeiUPurb5h8HF5QQQ3BE2vP2hsKL0cYClzJDF0CPHA
         +LAVkEFbnlyMcbNzDnCUCylgYvzrooHhNdgIyCN5EZIokSWbkP6oxYjXujkHoIvvWnYq
         r5PWwNqbmtgJ5WK6Z2CPtv+wco5MLD/cYKSOl9JOx8GSvTGZCFf6EO3aQJE23JPaD+gq
         Tq6hPdAgocwBWhJtwQeE3UKjBk+bGpCmWwjy8K1c/5aIwEzogVp9pwP9rxupZPoA5oDT
         J9Ie+L8dO2w5KLG2NwgS0hLUvR9zNKXn5wNpp/tMCrMEWtx75jO9Q/JjOyf9Gkyv+rLg
         lNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777385416; x=1777990216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymlOvxmwGZ8VtNX0ef8EHtkI32hxd4KqndZm7HincXA=;
        b=oMccFm+YEQY+o+BEqazev3Wk90OrWl77RZwuoJJ4/qNsTNHV64BRvhLJduCPWJ2/oJ
         U+vzs1qAT77ZG7w783kVrFkjO61ns9Ku3rgmWqF3ZHeZYSpTloBs2QuMArgX2NjufOmz
         yjyU4MBAa3CG/Akq1DhDP3vduiHcB4WLXgICFaar2ogANdQ9t5XfORNFQ1zJATdD9LLf
         WBpPcs6YEAL3+dO5gWOqZpNsUNCarCpSHF74MLelwsVRIVWx6QJGRh2O1B1RjcaBAEzx
         kgOBY4DTEaXhS5r60Iacd1UaSRUXPb63LXXJOG0ZimQ5Zl3GLTovipw4bwv8Z3cT70bs
         KKeA==
X-Forwarded-Encrypted: i=1; AFNElJ+PuPkc3JxA2yxIdQEHRkp9aUgaMXGbV5bm/Oafqd7IpJ/wkCKKY2SEqLLAcx9OVUuQNhuEMnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ShhX7XZahqocRUNLaKfUPWmcvm4PEEROVdj8XV7mcks822Qb
	qMJN8qyUpD0MmT5sWbPvBLTR0b5wkG6l21QHQxmrtiOoZhNB+Y1V2lnuodBSWCjp9UzekkK5Lil
	9BVJ1MesDbXfIzq30FAKuo8sn84AvCTovo7lqPLPQbXiuZmPo2U7RbX5RXA==
X-Gm-Gg: AeBDiesO/cABy5nJDnuxvWzkY+bJmRUk9+K/Im/WC/zCGr4quFXcQ60FOyanDl3wqYb
	cfDFIoiAhzJNsfiOAy67hE7E4dMld3lGi2La5JkiwotAlVuSpcEcrZofncpiJ9YzLUe5q4hAJfo
	lWsRZgsQE5MyrqddFgAziu38SNj7I1MwPT+BHzHcvsAacB9VYZa+4MzwLwhKE6AwdptRXHjlJaH
	MQ5sGCnqmoyFR4RLgihkH506ZzGad5BHJ4oJdznXKEni0KO3L/W+cH270fEBnYDDLspbsCfeHM7
	zF+CmVaSvJpPtxLyaQTjdWeEjrTsc9B/H/4R8oH7ETpAl0hJRTWcjOTDldWVU6m5Q9pMOPqY0pO
	rNWv16GmrfBkbUsiJ/KPw17Lf7T4L6xu6YNpwmdspVSUOJtaZvIcnBYFt
X-Received: by 2002:a05:600c:138b:b0:48a:563c:c8c0 with SMTP id 5b1f17b1804b1-48a77ae59c8mr53086495e9.7.1777385412800;
        Tue, 28 Apr 2026 07:10:12 -0700 (PDT)
X-Received: by 2002:a05:600c:138b:b0:48a:563c:c8c0 with SMTP id 5b1f17b1804b1-48a77ae59c8mr53084375e9.7.1777385411078;
        Tue, 28 Apr 2026 07:10:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a773aeb6dsm71069655e9.5.2026.04.28.07.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:10:09 -0700 (PDT)
Date: Tue, 28 Apr 2026 10:10:05 -0400
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
Message-ID: <20260428100731-mutt-send-email-mst@kernel.org>
References: <20260428123859.19578-1-simon.schippers@tu-dortmund.de>
 <20260428123859.19578-5-simon.schippers@tu-dortmund.de>
 <20260428084851-mutt-send-email-mst@kernel.org>
 <cdc3cbc8-cf6a-437c-b34c-dd8ced65d7f8@tu-dortmund.de>
 <20260428092150-mutt-send-email-mst@kernel.org>
 <d00bea39-7748-46ad-9c31-27326041f03c@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d00bea39-7748-46ad-9c31-27326041f03c@tu-dortmund.de>
X-Rspamd-Queue-Id: 46663486E75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281908-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-dortmund.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 03:41:20PM +0200, Simon Schippers wrote:
> On 4/28/26 15:22, Michael S. Tsirkin wrote:
> > On Tue, Apr 28, 2026 at 03:10:44PM +0200, Simon Schippers wrote:
> >> On 4/28/26 14:50, Michael S. Tsirkin wrote:
> >>> On Tue, Apr 28, 2026 at 02:38:59PM +0200, Simon Schippers wrote:
> >>>> This commit prevents tail-drop when a qdisc is present and the ptr_ring
> >>>> becomes full. Once an entry is successfully produced and the ptr_ring
> >>>> reaches capacity, the netdev queue is stopped instead of dropping
> >>>> subsequent packets.
> >>>>
> >>>> If producing an entry fails anyways due to a race, tun_net_xmit returns
> >>>> NETDEV_TX_BUSY, again avoiding a drop. Such races are expected because
> >>>> LLTX is enabled and the transmit path operates without the usual locking.
> >>>>
> >>>> If no qdisc is present, the previous tail-drop behavior is preserved.
> >>>>
> >>>> The existing __tun_wake_queue() function of the consumer races with the
> >>>> producer for waking/stopping the netdev queue: the consumer may drain
> >>>> the ring just as the producer stops the queue, leading to a permanent
> >>>> stall. To avoid this, the producer re-checks the ring after stopping
> >>>> and wakes the queue itself if space was just made. An
> >>>> smp_mb__after_atomic() is required so the re-peek of the ring sees any
> >>>> drain that the consumer performed.
> >>>> smp_mb__after_atomic() pairs with the test_and_clear_bit() inside of
> >>>> netif_wake_subqueue():
> >>>>
> >>>> Consumer CPU                  Producer CPU
> >>>> ========================      =========================
> >>>> __ptr_ring_consume()
> >>>> netif_wake_subqueue()         netif_tx_stop_queue()
> >>>>           /\                  smp_mb__after_atomic()
> >>>>           ||                  __ptr_ring_produce_peek()
> >>>> contains RMW operation
> >>>>  test_and_clear_bit()
> >>>>           /\
> >>>>           ||
> >>>>  "Fully ordered RMW:
> >>>> smp_mb() before + after"
> >>>>     - atomic_t.txt
> >>>>
> >>>> Benchmarks:
> >>>> The benchmarks show a slight regression in raw transmission performance,
> >>>> though no packets are lost anymore.
> >>>
> >>> Could you include the packets received as well?
> >>> To demonstrate the gains/lack of loss. 
> >>>
> >>
> >> Do you mean the number of packets received by the VM?
> >> They should just be the same as the number sent (shown below), right?
> > 
> > Minus the loss? Which this is about, right?
> 
> Yes. I simply calculated "Lost/s":
> 
> elapsed_time = 100e6 / sent_pps
> Lost/s = total_errors / elapsed_time
> 
> 
> To get back total_errors for example for TAP
> 1 thread sending:
> 
> elapsed_time = 100e6 / 1.136Mpps = 88s
> 
> 3758 Mpps = total_errors / 88s
> <=> total_errors = 331 million packets
> 
> So, out of 431 million packets sent, 100 million were successfully
> delivered and 331 million were lost.

That is my issue.

I kind of have trouble mapping that to the table below.
For example:

 | TAP        | Transmitted | 1.136 Mpps   | 1.130 Mpps     | -0.6%    |
 |            +-------------+--------------+----------------+----------+
 |            | Lost/s      | 3.758 Mpps   | 0 pps          |          |

how can # of lost packets exceed the # of transmitted packets?

Thanks!


> > 
> >> I assume they would be visible as RX-DRP for TAP.
> >> For TAP + vhost-net I would have to rewrite the XDP drop
> >> program to count the number of dropped packets...
> >> And I would have to automate it...
> >>
> >>>>
> >>>> The previously introduced threshold to only wake after the queue stopped
> >>>> and half of the ring was consumed showed to be a descent choice:
> >>>> Waking the queue whenever a consume made space in the ring strongly
> >>>> degrades performance for tap, while waking only when the ring is empty
> >>>> is too late and also hurts throughput for tap & tap+vhost-net.
> >>>> Other ratios (3/4, 7/8) showed similar results (not shown here), so
> >>>> 1/2 was chosen for the sake of simplicity for both tun/tap and
> >>>> tun/tap+vhost-net.
> >>>>
> >>>> Test setup:
> >>>> AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
> >>>> Average over 50 runs @ 100,000,000 packets. SRSO and spectre v2
> >>>> mitigations disabled.
> >>>>
> >>>> Note for tap+vhost-net:
> >>>> XDP drop program active in VM -> ~2.5x faster, slower for tap due to
> >>>> more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in perf)
> >>>>
> >>>> +--------------------------+--------------+----------------+----------+
> >>>> | 1 thread                 | Stock        | Patched with   | diff     |
> >>>> | sending                  |              | fq_codel qdisc |          |
> >>>> +------------+-------------+--------------+----------------+----------+
> >>>> | TAP        | Transmitted | 1.136 Mpps   | 1.130 Mpps     | -0.6%    |
> >>>> |            +-------------+--------------+----------------+----------+
> >>>> |            | Lost/s      | 3.758 Mpps   | 0 pps          |          |
> >>>> +------------+-------------+--------------+----------------+----------+
> >>>> | TAP        | Transmitted | 3.858 Mpps   | 3.816 Mpps     | -1.1%    |
> >>>> |            +-------------+--------------+----------------+----------+
> >>>> | +vhost-net | Lost/s      | 789.8 Kpps   | 0 pps          |          |
> >>>> +------------+-------------+--------------+----------------+----------+
> >>>>
> >>>> +--------------------------+--------------+----------------+----------+
> >>>> | 2 threads                | Stock        | Patched with   | diff     |
> >>>> | sending                  |              | fq_codel qdisc |          |
> >>>> +------------+-------------+--------------+----------------+----------+
> >>>> | TAP        | Transmitted | 1.117 Mpps   | 1.087 Mpps     | -2.7%    |
> >>>> |            +-------------+--------------+----------------+----------+
> >>>> |            | Lost/s      | 8.476 Mpps   | 0 pps          |          |
> >>>> +------------+-------------+--------------+----------------+----------+
> >>>> | TAP        | Transmitted | 3.679 Mpps   | 3.464 Mpps     | -5.8%    |
> >>>> |            +-------------+--------------+----------------+----------+
> >>>> | +vhost-net | Lost/s      | 5.306 Mpps   | 0 pps          |          |
> >>>> +------------+-------------+--------------+----------------+----------+
> >>>>
> >>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >>>> ---
> >>>>  drivers/net/tun.c | 30 ++++++++++++++++++++++++++++--
> >>>>  1 file changed, 28 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>> index efe809597622..c2a1618cc9db 100644
> >>>> --- a/drivers/net/tun.c
> >>>> +++ b/drivers/net/tun.c
> >>>> @@ -1011,6 +1011,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
> >>>>  	struct netdev_queue *queue;
> >>>>  	struct tun_file *tfile;
> >>>>  	int len = skb->len;
> >>>> +	bool qdisc_present;
> >>>> +	int ret;
> >>>>  
> >>>>  	rcu_read_lock();
> >>>>  	tfile = rcu_dereference(tun->tfiles[txq]);
> >>>> @@ -1065,13 +1067,37 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
> >>>>  
> >>>>  	nf_reset_ct(skb);
> >>>>  
> >>>> -	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> >>>> +	queue = netdev_get_tx_queue(dev, txq);
> >>>> +	qdisc_present = !qdisc_txq_has_no_queue(queue);
> >>>> +
> >>>> +	spin_lock(&tfile->tx_ring.producer_lock);
> >>>> +	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
> >>>> +	if (__ptr_ring_produce_peek(&tfile->tx_ring) && qdisc_present) {
> >>>> +		netif_tx_stop_queue(queue);
> >>>> +		/* Re-peek and wake if the consumer drained the ring
> >>>> +		 * concurrently in a race. smp_mb__after_atomic() pairs
> >>>> +		 * with the test_and_clear_bit() of netif_wake_subqueue()
> >>>> +		 * in __tun_wake_queue().
> >>>> +		 */
> >>>> +		smp_mb__after_atomic();
> >>>> +		if (!__ptr_ring_produce_peek(&tfile->tx_ring))
> >>>> +			netif_tx_wake_queue(queue);
> >>>> +	}
> >>>> +	spin_unlock(&tfile->tx_ring.producer_lock);
> >>>> +
> >>>> +	if (ret) {
> >>>> +		/* If a qdisc is attached to our virtual device,
> >>>> +		 * returning NETDEV_TX_BUSY is allowed.
> >>>> +		 */
> >>>> +		if (qdisc_present) {
> >>>> +			rcu_read_unlock();
> >>>> +			return NETDEV_TX_BUSY;
> >>>> +		}
> >>>>  		drop_reason = SKB_DROP_REASON_FULL_RING;
> >>>>  		goto drop;
> >>>>  	}
> >>>>  
> >>>>  	/* dev->lltx requires to do our own update of trans_start */
> >>>> -	queue = netdev_get_tx_queue(dev, txq);
> >>>>  	txq_trans_cond_update(queue);
> >>>>  
> >>>>  	/* Notify and wake up reader process */
> >>>> -- 
> >>>> 2.43.0
> >>>
> > 


