Return-Path: <netdev+bounces-281933-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBgpJFbY8GlHaAEAu9opvQ
	(envelope-from <netdev+bounces-281933-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:55:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 88345488510
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 00004304EDF2
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C015D1B3B19;
	Tue, 28 Apr 2026 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jhaogm61";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLKf5dCT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5C6305064
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386755; cv=none; b=A8RySHOIIWsvKWcxanIVIvmO1kGLRmNf4F+y8YAKFZaxmUkqW3zY6pqn7Z3ZIiKQieqppMA5YDUJBU2brVgjaibJf0z0Na62quesKKzHYu2JrLU/AxeF8ANKOLr7Uo7iPwdh+/OiH64Tg2wwHf8d3fF7vSqdYuWHM7Zy50n9ptA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386755; c=relaxed/simple;
	bh=PflM0WAo79zj/vrmft2LxB9enula3rWFzuEZCd/m0Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkGg8jraSsYJiITDrEGQio39pEeXUCKOYWf7Sgg4AfugVoHabZkDtBH1pfInEaNcHplUDXT8awU9ZHCq87127DKCzdAdq5jtSdsNRTeoCLIPUYLQ5cdUcTMwiU4WJ6fz/Et0iD8E1e9QZ926UA0eyaKnGzEdETH+WRm5Sy+Fljw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jhaogm61; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLKf5dCT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777386752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vy+Zqi/x02FVQVkOBreJZs+wOKUpsU6s7p7xuZL/QrU=;
	b=Jhaogm61/0fd4EsqLjH0OP/CcH7BczdLldXBKo8Mu1eB5Jl/5l8Qlt5J9Hw++9HX9pWPNA
	fwPxsgAUthzdUXNPTqqJGhF/EyaVKyGmY6oFhyv7QYvzzeQixmjABvaXBjwEf5ixI9FkYQ
	e1F5iM8NsaQ1i3Pk7G25r7YyGh8W/qw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-zVwrut0bNRSe7v3yTPpPJw-1; Tue, 28 Apr 2026 10:32:31 -0400
X-MC-Unique: zVwrut0bNRSe7v3yTPpPJw-1
X-Mimecast-MFC-AGG-ID: zVwrut0bNRSe7v3yTPpPJw_1777386750
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43ea7a5da42so6414494f8f.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 07:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777386750; x=1777991550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vy+Zqi/x02FVQVkOBreJZs+wOKUpsU6s7p7xuZL/QrU=;
        b=aLKf5dCToNDihQIDNghNaf+ACoIkIFVzajwHbEDNjIIhFrhLFbg1yTdp1lKdT+Srvy
         Tn095+0iXDM75Xy7w3ZlSFasrzLpPuBb0eLE1ImGHXpsGkxorAZ5rcOgYPwOexJ7tjwF
         WgFMyEl8aj6HKU6QJt7Q+Ay/Vwq+U00NnX3ch7IBuNb5xOdw3d36ui0Ha2trRXZ/VxSj
         EbcgYlbSN1RyHDwAH54jX2TVaRECeQQc73HOSL5Dt5R5WppY7uATtQM3zuM9i7XEhzJy
         lIsEdObD/yCvdMyXQeNm9A0G1cAXk6m7qzLUuiirNoBMSGMY7pVlJS/SQdLvASdT/MCo
         RjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386750; x=1777991550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vy+Zqi/x02FVQVkOBreJZs+wOKUpsU6s7p7xuZL/QrU=;
        b=pu+IjTBDaWqL8l3F2+pYjw37k4ouHP3nDYM3/A8xEGSQipHB4KVt4C9/AMc7OiTgtF
         LbvkWGq+cgnudr83dui2zBCK7FKTWycCcLVKslg4b5inCbiIzfUJxlKYcdyV1TTuzpjN
         DdsgHF/fNbgYhYgzTMBCrKHBVaTLSPhJFblpOsIu9aVONQCKhbCB1eaBFE1mGZiHXl2V
         Sd85VBHb0E/VPPA+i4BCyuTigEa3fXV2ZYYnvmIAGQFiNVwAzBGjPmcA6amVgdPDN7qA
         2M9vnkKsTEySS/h6SAkPx6O2Z9jz9lJRj0doFVbtT6PgymBwt96CQwH6rHA1JH0cyGaU
         iyKw==
X-Forwarded-Encrypted: i=1; AFNElJ8ObrtF8O3CRafRpbp3l/396Tco3wmpGD7dKTIzV+kDb1VewabgJZCc6wBd9nW6OqomCcf8iMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ePoddmhIXszMGIHmt/RuQBd1bNGOW1zEjPdOxhUKGekvIssk
	/6LEtTJlaX3+iaSYUKzk+rHISnOpVdUimL3eZAyJbDBaRczXaxQky55ltEORi5lvjVm0f1TFiBr
	e2gJzGYLBA1R3zUtNxcHH0zeanHBUt409OqCDngnvDLfsFZETxfi25s+dDA==
X-Gm-Gg: AeBDiesR8OdU+j8fWEEgYb967WssgwCMSP14bAY3Hs0cYR7DG9QPMPfCbwj0Q6+2D1p
	e0SknihzSEEFS9IfJ3tkmVagfdZ8d371WjvN7SfoeJuQeBSmiRneMhDwMKxtofY/ZbjgnuGiG6D
	2JgoPMbwdetmbrG6GUFSX/agJZQTbeeQPc3XYz0odsKlvCrjfsvU5h02JCz5/QRR6QOdGI3b5UT
	01OnSlT4Iu9u7MC9qeS1aAuRgL8nB+nlMJ40pD4M63uaNlsguEtqQaYWzlShJgT/BCF2xvKPfEz
	QclHZ7DwZOSYglv2cQ8utPKmoyDm5F4sILre/FQcBzns7PvB56+jGgN9uv5a6FW1Yha3Twn1dX8
	mkl8zS+Mab7PNETgVNreQ+Br4NODJ60slp9RSEirn72US6C8k8iQIGPjj
X-Received: by 2002:a05:6000:24c3:b0:43d:7828:1f81 with SMTP id ffacd0b85a97d-4464b86e6a0mr6214083f8f.41.1777386744536;
        Tue, 28 Apr 2026 07:32:24 -0700 (PDT)
X-Received: by 2002:a05:6000:24c3:b0:43d:7828:1f81 with SMTP id ffacd0b85a97d-4464b86e6a0mr6213603f8f.41.1777386740512;
        Tue, 28 Apr 2026 07:32:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463f4c0b23sm6873138f8f.21.2026.04.28.07.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:32:19 -0700 (PDT)
Date: Tue, 28 Apr 2026 10:32:16 -0400
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
Message-ID: <20260428103108-mutt-send-email-mst@kernel.org>
References: <20260428123859.19578-1-simon.schippers@tu-dortmund.de>
 <20260428123859.19578-5-simon.schippers@tu-dortmund.de>
 <20260428084851-mutt-send-email-mst@kernel.org>
 <cdc3cbc8-cf6a-437c-b34c-dd8ced65d7f8@tu-dortmund.de>
 <20260428092150-mutt-send-email-mst@kernel.org>
 <d00bea39-7748-46ad-9c31-27326041f03c@tu-dortmund.de>
 <20260428100731-mutt-send-email-mst@kernel.org>
 <f4274173-23ef-43c3-aab4-b64678b440ec@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4274173-23ef-43c3-aab4-b64678b440ec@tu-dortmund.de>
X-Rspamd-Queue-Id: 88345488510
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281933-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-dortmund.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 04:18:54PM +0200, Simon Schippers wrote:
> On 4/28/26 16:10, Michael S. Tsirkin wrote:
> > On Tue, Apr 28, 2026 at 03:41:20PM +0200, Simon Schippers wrote:
> >> On 4/28/26 15:22, Michael S. Tsirkin wrote:
> >>> On Tue, Apr 28, 2026 at 03:10:44PM +0200, Simon Schippers wrote:
> >>>> On 4/28/26 14:50, Michael S. Tsirkin wrote:
> >>>>> On Tue, Apr 28, 2026 at 02:38:59PM +0200, Simon Schippers wrote:
> >>>>>> This commit prevents tail-drop when a qdisc is present and the ptr_ring
> >>>>>> becomes full. Once an entry is successfully produced and the ptr_ring
> >>>>>> reaches capacity, the netdev queue is stopped instead of dropping
> >>>>>> subsequent packets.
> >>>>>>
> >>>>>> If producing an entry fails anyways due to a race, tun_net_xmit returns
> >>>>>> NETDEV_TX_BUSY, again avoiding a drop. Such races are expected because
> >>>>>> LLTX is enabled and the transmit path operates without the usual locking.
> >>>>>>
> >>>>>> If no qdisc is present, the previous tail-drop behavior is preserved.
> >>>>>>
> >>>>>> The existing __tun_wake_queue() function of the consumer races with the
> >>>>>> producer for waking/stopping the netdev queue: the consumer may drain
> >>>>>> the ring just as the producer stops the queue, leading to a permanent
> >>>>>> stall. To avoid this, the producer re-checks the ring after stopping
> >>>>>> and wakes the queue itself if space was just made. An
> >>>>>> smp_mb__after_atomic() is required so the re-peek of the ring sees any
> >>>>>> drain that the consumer performed.
> >>>>>> smp_mb__after_atomic() pairs with the test_and_clear_bit() inside of
> >>>>>> netif_wake_subqueue():
> >>>>>>
> >>>>>> Consumer CPU                  Producer CPU
> >>>>>> ========================      =========================
> >>>>>> __ptr_ring_consume()
> >>>>>> netif_wake_subqueue()         netif_tx_stop_queue()
> >>>>>>           /\                  smp_mb__after_atomic()
> >>>>>>           ||                  __ptr_ring_produce_peek()
> >>>>>> contains RMW operation
> >>>>>>  test_and_clear_bit()
> >>>>>>           /\
> >>>>>>           ||
> >>>>>>  "Fully ordered RMW:
> >>>>>> smp_mb() before + after"
> >>>>>>     - atomic_t.txt
> >>>>>>
> >>>>>> Benchmarks:
> >>>>>> The benchmarks show a slight regression in raw transmission performance,
> >>>>>> though no packets are lost anymore.
> >>>>>
> >>>>> Could you include the packets received as well?
> >>>>> To demonstrate the gains/lack of loss. 
> >>>>>
> >>>>
> >>>> Do you mean the number of packets received by the VM?
> >>>> They should just be the same as the number sent (shown below), right?
> >>>
> >>> Minus the loss? Which this is about, right?
> >>
> >> Yes. I simply calculated "Lost/s":
> >>
> >> elapsed_time = 100e6 / sent_pps
> >> Lost/s = total_errors / elapsed_time
> >>
> >>
> >> To get back total_errors for example for TAP
> >> 1 thread sending:
> >>
> >> elapsed_time = 100e6 / 1.136Mpps = 88s
> >>
> >> 3758 Mpps = total_errors / 88s
> >> <=> total_errors = 331 million packets
> >>
> >> So, out of 431 million packets sent, 100 million were successfully
> >> delivered and 331 million were lost.
> > 
> > That is my issue.
> > 
> > I kind of have trouble mapping that to the table below.
> > For example:
> > 
> >  | TAP        | Transmitted | 1.136 Mpps   | 1.130 Mpps     | -0.6%    |
> >  |            +-------------+--------------+----------------+----------+
> >  |            | Lost/s      | 3.758 Mpps   | 0 pps          |          |
> > 
> > how can # of lost packets exceed the # of transmitted packets?
> > 
> > Thanks!
> 
> I just do use the sample script [1]:
> 
> ./pktgen_sample02_multiqueue.sh -n 100000000 ...
> 
> ... and this runs until 100_000_000 packets were sucessfully
> transmitted, independently of the lost packets/errors.
> 
> [1] Link: https://www.kernel.org/doc/html/latest/networking/pktgen.html#sample-scripts

Confused. Are you saying "transmitted" is actually "received"? And the #
of packets sent is Transmitted + Lost?

> > 
> > 
> >>>
> >>>> I assume they would be visible as RX-DRP for TAP.
> >>>> For TAP + vhost-net I would have to rewrite the XDP drop
> >>>> program to count the number of dropped packets...
> >>>> And I would have to automate it...
> >>>>
> >>>>>>
> >>>>>> The previously introduced threshold to only wake after the queue stopped
> >>>>>> and half of the ring was consumed showed to be a descent choice:
> >>>>>> Waking the queue whenever a consume made space in the ring strongly
> >>>>>> degrades performance for tap, while waking only when the ring is empty
> >>>>>> is too late and also hurts throughput for tap & tap+vhost-net.
> >>>>>> Other ratios (3/4, 7/8) showed similar results (not shown here), so
> >>>>>> 1/2 was chosen for the sake of simplicity for both tun/tap and
> >>>>>> tun/tap+vhost-net.
> >>>>>>
> >>>>>> Test setup:
> >>>>>> AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
> >>>>>> Average over 50 runs @ 100,000,000 packets. SRSO and spectre v2
> >>>>>> mitigations disabled.
> >>>>>>
> >>>>>> Note for tap+vhost-net:
> >>>>>> XDP drop program active in VM -> ~2.5x faster, slower for tap due to
> >>>>>> more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in perf)
> >>>>>>
> >>>>>> +--------------------------+--------------+----------------+----------+
> >>>>>> | 1 thread                 | Stock        | Patched with   | diff     |
> >>>>>> | sending                  |              | fq_codel qdisc |          |
> >>>>>> +------------+-------------+--------------+----------------+----------+
> >>>>>> | TAP        | Transmitted | 1.136 Mpps   | 1.130 Mpps     | -0.6%    |
> >>>>>> |            +-------------+--------------+----------------+----------+
> >>>>>> |            | Lost/s      | 3.758 Mpps   | 0 pps          |          |
> >>>>>> +------------+-------------+--------------+----------------+----------+
> >>>>>> | TAP        | Transmitted | 3.858 Mpps   | 3.816 Mpps     | -1.1%    |
> >>>>>> |            +-------------+--------------+----------------+----------+
> >>>>>> | +vhost-net | Lost/s      | 789.8 Kpps   | 0 pps          |          |
> >>>>>> +------------+-------------+--------------+----------------+----------+
> >>>>>>
> >>>>>> +--------------------------+--------------+----------------+----------+
> >>>>>> | 2 threads                | Stock        | Patched with   | diff     |
> >>>>>> | sending                  |              | fq_codel qdisc |          |
> >>>>>> +------------+-------------+--------------+----------------+----------+
> >>>>>> | TAP        | Transmitted | 1.117 Mpps   | 1.087 Mpps     | -2.7%    |
> >>>>>> |            +-------------+--------------+----------------+----------+
> >>>>>> |            | Lost/s      | 8.476 Mpps   | 0 pps          |          |
> >>>>>> +------------+-------------+--------------+----------------+----------+
> >>>>>> | TAP        | Transmitted | 3.679 Mpps   | 3.464 Mpps     | -5.8%    |
> >>>>>> |            +-------------+--------------+----------------+----------+
> >>>>>> | +vhost-net | Lost/s      | 5.306 Mpps   | 0 pps          |          |
> >>>>>> +------------+-------------+--------------+----------------+----------+
> >>>>>>
> >>>>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >>>>>> ---
> >>>>>>  drivers/net/tun.c | 30 ++++++++++++++++++++++++++++--
> >>>>>>  1 file changed, 28 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>>>> index efe809597622..c2a1618cc9db 100644
> >>>>>> --- a/drivers/net/tun.c
> >>>>>> +++ b/drivers/net/tun.c
> >>>>>> @@ -1011,6 +1011,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
> >>>>>>  	struct netdev_queue *queue;
> >>>>>>  	struct tun_file *tfile;
> >>>>>>  	int len = skb->len;
> >>>>>> +	bool qdisc_present;
> >>>>>> +	int ret;
> >>>>>>  
> >>>>>>  	rcu_read_lock();
> >>>>>>  	tfile = rcu_dereference(tun->tfiles[txq]);
> >>>>>> @@ -1065,13 +1067,37 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
> >>>>>>  
> >>>>>>  	nf_reset_ct(skb);
> >>>>>>  
> >>>>>> -	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> >>>>>> +	queue = netdev_get_tx_queue(dev, txq);
> >>>>>> +	qdisc_present = !qdisc_txq_has_no_queue(queue);
> >>>>>> +
> >>>>>> +	spin_lock(&tfile->tx_ring.producer_lock);
> >>>>>> +	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
> >>>>>> +	if (__ptr_ring_produce_peek(&tfile->tx_ring) && qdisc_present) {
> >>>>>> +		netif_tx_stop_queue(queue);
> >>>>>> +		/* Re-peek and wake if the consumer drained the ring
> >>>>>> +		 * concurrently in a race. smp_mb__after_atomic() pairs
> >>>>>> +		 * with the test_and_clear_bit() of netif_wake_subqueue()
> >>>>>> +		 * in __tun_wake_queue().
> >>>>>> +		 */
> >>>>>> +		smp_mb__after_atomic();
> >>>>>> +		if (!__ptr_ring_produce_peek(&tfile->tx_ring))
> >>>>>> +			netif_tx_wake_queue(queue);
> >>>>>> +	}
> >>>>>> +	spin_unlock(&tfile->tx_ring.producer_lock);
> >>>>>> +
> >>>>>> +	if (ret) {
> >>>>>> +		/* If a qdisc is attached to our virtual device,
> >>>>>> +		 * returning NETDEV_TX_BUSY is allowed.
> >>>>>> +		 */
> >>>>>> +		if (qdisc_present) {
> >>>>>> +			rcu_read_unlock();
> >>>>>> +			return NETDEV_TX_BUSY;
> >>>>>> +		}
> >>>>>>  		drop_reason = SKB_DROP_REASON_FULL_RING;
> >>>>>>  		goto drop;
> >>>>>>  	}
> >>>>>>  
> >>>>>>  	/* dev->lltx requires to do our own update of trans_start */
> >>>>>> -	queue = netdev_get_tx_queue(dev, txq);
> >>>>>>  	txq_trans_cond_update(queue);
> >>>>>>  
> >>>>>>  	/* Notify and wake up reader process */
> >>>>>> -- 
> >>>>>> 2.43.0
> >>>>>
> >>>
> > 


