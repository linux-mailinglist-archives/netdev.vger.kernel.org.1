Return-Path: <netdev+bounces-300014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o5XII+QgMmpRvQUAu9opvQ
	(envelope-from <netdev+bounces-300014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:21:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8717696657
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:21:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=zohomail.in header.s=zoho header.b=IXTYXipB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300014-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300014-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=zohomail.in;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 951223082588
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 04:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D953009E1;
	Wed, 17 Jun 2026 04:21:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sender-pp-o91.zoho.in (sender-pp-o91.zoho.in [103.117.158.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DE319DF55;
	Wed, 17 Jun 2026 04:21:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781670114; cv=pass; b=O2gbrH5hq9QLlPDlnxZtwM7ibSFuwoY776O8yYghRZtq1Cw0Y//DwUTjAVI7C9x57osxJ+/Z+PrrLTEClNexXlDfHRLbsN1laZKm0c5FwJ0cUPPUQDsf9IbZq6EcYqdQieb81/WGD++CN1/iB3Bj4pUmboV8hM49+9V0d2TBvQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781670114; c=relaxed/simple;
	bh=E2CxQDBiq8vkYZw3+L5768AtJrxkFo63zk3KjEZb/Q0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=IH8iBYAQMIPI2OY+Q463RVnUIE5ExZFm3A4blAvGl1q+t3sOSLWKCu4d/Rb3Tv06/Zstbt0aJZNhzcQFoA659Zpf9i5PDt9qcUxz9BsGgHCiEPfghYzuF6TTDlUtfNDWs8ryLjl43ghXWk1fIp/O+MJWEvh/3diBcS9jaf2/hjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=kshitiz.bartariya@zohomail.in header.b=IXTYXipB; arc=pass smtp.client-ip=103.117.158.91
ARC-Seal: i=1; a=rsa-sha256; t=1781670056; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=eaZBpmx3YXhMK3SlM2TZL/DVa2tDz8yc8j1s5h2no1mbLIwjCOtSzfd8RL2+XaJ5MRRA9k7MP05vSfOEXQVlqTKJ5cABzEfkXTlRiPtPn1HOCMJFnPwBakK95ExLnd9LviyS/j6jRKVthRRRjgStsqNvLrDXlFsRCIFcZf/e3/Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1781670056; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TIe4l3ASPdIIXkbKu0EttgIt8LTWQF4HXBMwvsrr0Ik=; 
	b=Tf1Nnxls8NRZlSalWlyhm/las5UXzhx75fLhLKwxctfE1dSJjRon8J+h2+btScVQETetV/0bK2WE7yQqzstk27JI+OD1g8mPwXJ30pUcCFdo74mxNim2/ViscAq+3vgr/WVtdYGcKKzqpxGoV/SHwKgO8FpBHgi5difiyVGwkYI=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=kshitiz.bartariya@zohomail.in;
	dmarc=pass header.from=<kshitiz.bartariya@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781670056;
	s=zoho; d=zohomail.in; i=kshitiz.bartariya@zohomail.in;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=TIe4l3ASPdIIXkbKu0EttgIt8LTWQF4HXBMwvsrr0Ik=;
	b=IXTYXipBSM41EDF4GrHfpBmygZgyNz3yrNxAvuB8z371nZ67aD6iUUHB9ZQOKNXa
	0VFvBR9Quy0LOD/bCam2Jnoktnczsrbxks1rc67NeNRr8nvXG+LmIwcl1gVbj7RGW1z
	9mCOPd7quLlY2dDJULbDdXFIsf10e+BCbLNybzZ8=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1781670049413913.9124159394931; Wed, 17 Jun 2026 09:50:49 +0530 (IST)
Received: from  [49.206.134.238] by mail.zoho.in
	with HTTP;Wed, 17 Jun 2026 09:50:49 +0530 (IST)
Date: Wed, 17 Jun 2026 09:50:49 +0530
From: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
To: "Simon Horman" <horms@kernel.org>
Cc: "intel-wired-lan" <intel-wired-lan@osuosl.org>,
	"anthony.l.nguyen" <anthony.l.nguyen@intel.com>,
	"przemyslaw.kitszel" <przemyslaw.kitszel@intel.com>,
	"andrew+netdev" <andrew+netdev@lunn.ch>,
	"davem" <davem@davemloft.net>, "edumazet" <edumazet@google.com>,
	"kuba" <kuba@kernel.org>, "pabeni" <pabeni@redhat.com>,
	"jedrzej.jagielski" <jedrzej.jagielski@intel.com>,
	"intel-wired-lan" <intel-wired-lan@lists.osuosl.org>,
	"netdev" <netdev@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19ed3cf767d.36a9bda531830.5017017162150392549@zohomail.in>
In-Reply-To: <20260615115806.756776-1-horms@kernel.org>
References: <20260613091231.26601-1-kshitiz.bartariya@zohomail.in> <20260615115806.756776-1-horms@kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH net-next v4] ixgbe: implement
 get_queue_stats_rx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.in,reject];
	R_DKIM_ALLOW(-0.20)[zohomail.in:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-300014-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:intel-wired-lan@osuosl.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jedrzej.jagielski@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kshitiz.bartariya@zohomail.in,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kshitiz.bartariya@zohomail.in,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[zohomail.in:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8717696657

Hi Simon,

For the review generated by AI, I had done changes on that line previously but Jakub Kicinski <kuba@kernel.org> pointed out that such checks are redundant https://lore.kernel.org/lkml/20260525085356.5c336491@kernel.org/ .

Kindly let me know according to whom I've to make the final changes.

Thanks,
Kshitiz

From: Simon Horman <horms@kernel.org>
To: <intel-wired-lan@osuosl.org>
Cc: "Simon Horman"<horms@kernel.org>, <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>, <jedrzej.jagielski@intel.com>, <kshitiz.bartariya@zohomail.in>, <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date: Mon, 15 Jun 2026 17:28:06 +0530
Subject: Re: [Intel-wired-lan] [PATCH net-next v4] ixgbe: implement get_queue_stats_rx

 > This is an AI-generated review of your patch. The human sending this
 > email has considered the AI review valid, or at least plausible.
 > Full review at: https://netdev-ai.bots.linux.dev/sashiko/
 > ---
 > ixgbe: implement get_queue_stats_rx
 > 
 > This patch wires ixgbe into the netdev_stat_ops interface so that per-RX
 > queue counters (bytes, packets, alloc_fail, csum_bad) are exported
 > through the netdev generic netlink API.
 > 
 > > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
 > > index bc16e4c93fd4..67844e25af23 100644
 > > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
 > > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
 > > @@ -9759,6 +9759,30 @@ static void ixgbe_get_stats64(struct net_device *netdev,
 > >      stats->rx_missed_errors    = netdev->stats.rx_missed_errors;
 > >  }
 > >  
 > > +static void ixgbe_get_queue_stats_rx(struct net_device *dev, int idx,
 > > +                     struct netdev_queue_stats_rx *stats)
 > > +{
 > > +    struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
 > > +    struct ixgbe_ring *ring = adapter->rx_ring[idx];
 > > +
 > 
 > [High]
 > Can adapter->rx_ring[idx] be observed NULL here?
 > 
 > Elsewhere in the same driver, this slot is treated as nullable. The
 > writer side uses WRITE_ONCE() in both directions, for example in
 > ixgbe_free_q_vector():
 > 
 >     WRITE_ONCE(adapter->rx_ring[ring->queue_index], NULL);
 > 
 > and the existing readers in ixgbe_main.c pair that with READ_ONCE() and
 > a NULL guard, e.g. ixgbe_get_stats64():
 > 
 >     struct ixgbe_ring *ring = READ_ONCE(adapter->rx_ring[i]);
 >     if (ring) {
 >         ...
 >     }
 > 
 > and ixgbe_update_stats():
 > 
 >     struct ixgbe_ring *rx_ring = READ_ONCE(adapter->rx_ring[i]);
 >     if (!rx_ring)
 >         continue;
 > 
 > If a userspace caller issues a per-queue qstats request while the driver
 > is reconfiguring queues (e.g. ixgbe_clear_interrupt_scheme() /
 > ixgbe_init_interrupt_scheme() during reset), would a plain dereference
 > here oops?
 > 
 > Should this callback follow the same READ_ONCE() plus NULL-skip pattern
 > used in ixgbe_get_stats64() and ixgbe_update_stats()?
 > 
 > > +    stats->bytes = ring->stats.bytes;
 > > +    stats->packets = ring->stats.packets;
 > 
 > [Medium]
 > Should these 64-bit reads be wrapped in a u64_stats_sync read section?
 > 
 > The writer side, ixgbe_update_rx_ring_stats(), updates these counters
 > under ring->syncp:
 > 
 >     u64_stats_update_begin(&rx_ring->syncp);
 >     rx_ring->stats.packets += total_packets;
 >     rx_ring->stats.bytes += total_bytes;
 >     u64_stats_update_end(&rx_ring->syncp);
 > 
 > and the syncp is initialized at probe (u64_stats_init() on ring->syncp).
 > ixgbe_get_stats64() in this same file already mirrors that on the read
 > side:
 > 
 >     do {
 >         start = u64_stats_fetch_begin(&ring->syncp);
 >         packets = ring->stats.packets;
 >         bytes   = ring->stats.bytes;
 >     } while (u64_stats_fetch_retry(&ring->syncp, start));
 > 
 > On 32-bit kernels a 64-bit load is not atomic, so without the fetch
 > loop can the values returned to userspace be torn (high half from one
 > update, low half from another)?
 > 
 > > +    stats->alloc_fail = ring->rx_stats.alloc_rx_page_failed +
 > > +                ring->rx_stats.alloc_rx_buff_failed;
 > > +    stats->csum_bad = ring->rx_stats.csum_err;
 > > +}
 > > +
 > 
 > [ ... ]
 > 


