Return-Path: <netdev+bounces-299411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OW9RG+voL2qLIwUAu9opvQ
	(envelope-from <netdev+bounces-299411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 13:58:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5966E685E71
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 13:58:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=biM2fV1+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299411-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299411-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 291813002930
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 11:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377E63E450B;
	Mon, 15 Jun 2026 11:58:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9A23E4C6E;
	Mon, 15 Jun 2026 11:58:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524708; cv=none; b=gnX2Ib3On1Vwab8mqvixn676PJIXPxcj9ZE1n1J0IavOiKlskWIx/ZeDpTPAWHryKhhwpp6ul+Cz0njadqFohz3mJZbLdaAuX2kHUllBVyhN0BL78zQQ+0xZpfDYYMzdd+N7zufA3u6bUXkRr3Wh9rGMVUy7Pr9ruagmdg57+zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524708; c=relaxed/simple;
	bh=r98cbYusXx9/Re6eslEbt5yaqvKtc1ZXYecMvqWCdDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HCam/OtxsjbSycoXacrI7hATsOp+f0RH+GP8HpiWUlqmpZmUtXf4Vjgtm5tn59dlEKJ+vkSParU4iTrnbV1T6WjahEoILi2FDBPfVpSSkwBc8J6WP9cmJmMVqaP4sM+gMFDQsaJCdulgXVL5JmxyI/W9MdjVUhArgNQeFuXrWpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biM2fV1+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2179F1F00A3A;
	Mon, 15 Jun 2026 11:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781524706;
	bh=AxorqoSl7GNbTaT4GN1VoPJxbHSXX4/2W2cvV0NxdmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=biM2fV1+UuD+NY7cxKRo/9UUMZ1aCXvK64Gz25xP6S3TwYCDzANwAFgUhoZF14eEE
	 25i9a+FX9LcYzZDT6d44wwqV/xQ9a0U0yd9xBtOJ1mnOMxvn5WWD8hQ8YRd4mPfxXH
	 28Mq6CKsW0V0JlR+4Kw7m+mLHgzbIS9BAudpQFyNKDYLM8x02jaAORHzv68zSBdbBp
	 0lJVWBq2CajnnVjRffQ550Q5cNqQZUebLfD1J6F39Jduo7TD69WVc5rkZ5HZlFJWAc
	 tLWbUS2lw4h2QXFRWA4vYLjj2ZHN8Z2ebRmBJlEB9DykYfOCJsIh53j1Bo4qSLrokR
	 IyDll7VS220SQ==
From: Simon Horman <horms@kernel.org>
To: intel-wired-lan@osuosl.org
Cc: Simon Horman <horms@kernel.org>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jedrzej.jagielski@intel.com,
	kshitiz.bartariya@zohomail.in,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH net-next v4] ixgbe: implement get_queue_stats_rx
Date: Mon, 15 Jun 2026 12:58:06 +0100
Message-ID: <20260615115806.756776-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613091231.26601-1-kshitiz.bartariya@zohomail.in>
References: <20260613091231.26601-1-kshitiz.bartariya@zohomail.in>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299411-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@osuosl.org,m:horms@kernel.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jedrzej.jagielski@intel.com,m:kshitiz.bartariya@zohomail.in,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5966E685E71

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
ixgbe: implement get_queue_stats_rx

This patch wires ixgbe into the netdev_stat_ops interface so that per-RX
queue counters (bytes, packets, alloc_fail, csum_bad) are exported
through the netdev generic netlink API.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index bc16e4c93fd4..67844e25af23 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -9759,6 +9759,30 @@ static void ixgbe_get_stats64(struct net_device *netdev,
>  	stats->rx_missed_errors	= netdev->stats.rx_missed_errors;
>  }
>  
> +static void ixgbe_get_queue_stats_rx(struct net_device *dev, int idx,
> +				     struct netdev_queue_stats_rx *stats)
> +{
> +	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
> +	struct ixgbe_ring *ring = adapter->rx_ring[idx];
> +

[High]
Can adapter->rx_ring[idx] be observed NULL here?

Elsewhere in the same driver, this slot is treated as nullable. The
writer side uses WRITE_ONCE() in both directions, for example in
ixgbe_free_q_vector():

    WRITE_ONCE(adapter->rx_ring[ring->queue_index], NULL);

and the existing readers in ixgbe_main.c pair that with READ_ONCE() and
a NULL guard, e.g. ixgbe_get_stats64():

    struct ixgbe_ring *ring = READ_ONCE(adapter->rx_ring[i]);
    if (ring) {
        ...
    }

and ixgbe_update_stats():

    struct ixgbe_ring *rx_ring = READ_ONCE(adapter->rx_ring[i]);
    if (!rx_ring)
        continue;

If a userspace caller issues a per-queue qstats request while the driver
is reconfiguring queues (e.g. ixgbe_clear_interrupt_scheme() /
ixgbe_init_interrupt_scheme() during reset), would a plain dereference
here oops?

Should this callback follow the same READ_ONCE() plus NULL-skip pattern
used in ixgbe_get_stats64() and ixgbe_update_stats()?

> +	stats->bytes = ring->stats.bytes;
> +	stats->packets = ring->stats.packets;

[Medium]
Should these 64-bit reads be wrapped in a u64_stats_sync read section?

The writer side, ixgbe_update_rx_ring_stats(), updates these counters
under ring->syncp:

    u64_stats_update_begin(&rx_ring->syncp);
    rx_ring->stats.packets += total_packets;
    rx_ring->stats.bytes += total_bytes;
    u64_stats_update_end(&rx_ring->syncp);

and the syncp is initialized at probe (u64_stats_init() on ring->syncp).
ixgbe_get_stats64() in this same file already mirrors that on the read
side:

    do {
        start = u64_stats_fetch_begin(&ring->syncp);
        packets = ring->stats.packets;
        bytes   = ring->stats.bytes;
    } while (u64_stats_fetch_retry(&ring->syncp, start));

On 32-bit kernels a 64-bit load is not atomic, so without the fetch
loop can the values returned to userspace be torn (high half from one
update, low half from another)?

> +	stats->alloc_fail = ring->rx_stats.alloc_rx_page_failed +
> +			    ring->rx_stats.alloc_rx_buff_failed;
> +	stats->csum_bad = ring->rx_stats.csum_err;
> +}
> +

[ ... ]

