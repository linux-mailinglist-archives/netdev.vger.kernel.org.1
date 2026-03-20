Return-Path: <netdev+bounces-269893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK6aCDEvvWmI7QIAu9opvQ
	(envelope-from <netdev+bounces-269893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:27:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD952D98A3
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FD3530117DB
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05733A7F4C;
	Fri, 20 Mar 2026 11:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJ4oi4dd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726F139BFF5;
	Fri, 20 Mar 2026 11:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006031; cv=none; b=azKSaURPoY+40KLbuN7KYdZKlgGRd7KL1BDjsA7vTXhZdlqq1lY5LtkILtl4NjGriXR/Xl2jp7iCkVFgkkprvwZdXRH+YMjUGBfSBVsztZs9TRgAoZZuPdY6/Zj/WMh5QDEa+VKMG+0OCkWbuU/Tpl+mGxtofMEo+uG/5SpNBQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006031; c=relaxed/simple;
	bh=1wRF58FiDWImzLkG3HRq7nLNRkGKi0N9A0UY6bLIJWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUl9ISIl9wpQB885iEINfm0eOYzgtHtMT98Cn4PVRa9vtaz/6QbpzywwTO5uVl6shdCfZGz6t5wSFpuSPdzqyIF6GxxR+ZQJz3yKbc35GQPsA7p2Q37SRtGLLw3vWpJXjdfS0rl5/wndSFMm1DFtBvPZXxCSmJKqROUW+vScBH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJ4oi4dd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207D9C4CEF7;
	Fri, 20 Mar 2026 11:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774006030;
	bh=1wRF58FiDWImzLkG3HRq7nLNRkGKi0N9A0UY6bLIJWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJ4oi4ddq+uw8egN98CvDGk2f7bJglUTdcJOacefG9E3+3ec/WAoR1ufSCC1BClKS
	 svWEQ+lQR29bmtUXUa6bZ0JlbHZZTZj+yViHiifcT1fxuPu/Gy5YTB2YVl7XqZL5Fq
	 s996aMxdl9lbo83CQdmej+D3XvC6iFjQV+M3cE2urRTbLTSFDYx6MLMe/pty2s4Z4x
	 +M7tUJ/GIBFJ4TUG6GPMir1DUoAXA8GdwJ21cyxUYUdvOBBm+3039DLmneEj8v/pII
	 AytEAYAtF58UhSiA3uAIKVz4BXo88uRguCyvBOK4hMHS1kXNANhKl7/8jOzFaMPnQV
	 RdiGwjCKZeL2w==
From: Simon Horman <horms@kernel.org>
To: vikas.gupta@broadcom.com
Cc: Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	vsrama-krishna.nemani@broadcom.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ajit.khaparde@broadcom.com,
	bhargava.marreddy@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v8 09/10] bng_en: implement netdev_stat_ops
Date: Fri, 20 Mar 2026 11:27:04 +0000
Message-ID: <20260320112704.2065290-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319055124.1350670-10-vikas.gupta@broadcom.com>
References: <20260319055124.1350670-10-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-269893-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.973];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AFD952D98A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
bng_en: implement netdev_stat_ops

This patch adds netdev_stat_ops implementation to provide standardized
per-queue statistics via the Netlink API, including hardware drop
counters.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> index 2513b0907693..fa732b99358e 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> @@ -3031,6 +3031,81 @@ static int bnge_close(struct net_device *dev)
>  	return 0;
>  }
>
> +static void bnge_get_queue_stats_rx(struct net_device *dev, int i,
> +				    struct netdev_queue_stats_rx *stats)
> +{
> +	struct bnge_net *bn = netdev_priv(dev);
> +	struct bnge_nq_ring_info *nqr;
> +	u64 *sw;
> +
> +	if (!bn->bnapi)
> +		return;
> +
> +	nqr = &bn->bnapi[i]->nq_ring;
                ^^^^

Can this race with bnge_close_core and dereference bn->bnapi after it's
freed? The NULL check at line 3041 doesn't prevent the race since
bnge_close_core can free bn->bnapi between the check and dereference.

Looking at the existing bnge_get_stats64, it uses rcu_read_lock() when
accessing bn->bnapi:

bnge_get_stats64() {
    rcu_read_lock();
    if (test_bit(BNGE_STATE_OPEN, &bd->state)) {
        ... access bn->bnapi ...
    }
    rcu_read_unlock();
}

And bnge_close_core uses synchronize_rcu() to wait for readers before
freeing:

bnge_close_core() {
    ...
    synchronize_rcu();
    bnge_del_napi(bn);
        -> bnge_free_core(bn);
            -> bn->bnapi = NULL;
}

Without RCU protection, this sequence can occur:

Thread A (stats)                  Thread B (close)
----------------                  ----------------
if (!bn->bnapi)  [PASSES]
                                  bnge_close_core()
                                    bnge_free_core()
                                      bn->bnapi = NULL
nqr = &bn->bnapi[i]  [CRASH]

Should bnge_get_queue_stats_rx acquire rcu_read_lock() and check
test_bit(BNGE_STATE_OPEN) before accessing bn->bnapi?

> +	sw = nqr->stats.sw_stats;
> +
> +	stats->packets = 0;
> +	stats->packets += BNGE_GET_RING_STATS64(sw, rx_ucast_pkts);
> +	stats->packets += BNGE_GET_RING_STATS64(sw, rx_mcast_pkts);
> +	stats->packets += BNGE_GET_RING_STATS64(sw, rx_bcast_pkts);
> +
> +	stats->bytes = 0;
> +	stats->bytes += BNGE_GET_RING_STATS64(sw, rx_ucast_bytes);
> +	stats->bytes += BNGE_GET_RING_STATS64(sw, rx_mcast_bytes);
> +	stats->bytes += BNGE_GET_RING_STATS64(sw, rx_bcast_bytes);
> +
> +	stats->hw_drop_overruns = BNGE_GET_RING_STATS64(sw, rx_discard_pkts);
> +	stats->hw_drops = BNGE_GET_RING_STATS64(sw, rx_error_pkts) +
> +				stats->hw_drop_overruns;
> +}
> +
> +static void bnge_get_queue_stats_tx(struct net_device *dev, int i,
> +				    struct netdev_queue_stats_tx *stats)
> +{
> +	struct bnge_net *bn = netdev_priv(dev);
> +	struct bnge_napi *bnapi;
> +	u64 *sw;
> +
> +	if (!bn->tx_ring)
> +		return;
> +
> +	bnapi = bn->tx_ring[bn->tx_ring_map[i]].bnapi;
                ^^^^

Does this have the same race with bnge_close_core? The NULL check doesn't
prevent bnge_close_core from freeing bn->tx_ring between the check and
dereference.

Following the same pattern as bnge_get_stats64, should this also use
rcu_read_lock() and check BNGE_STATE_OPEN before accessing bn->tx_ring?

> +	sw = bnapi->nq_ring.stats.sw_stats;
> +
> +	stats->packets = 0;
> +	stats->packets += BNGE_GET_RING_STATS64(sw, tx_ucast_pkts);
> +	stats->packets += BNGE_GET_RING_STATS64(sw, tx_mcast_pkts);
> +	stats->packets += BNGE_GET_RING_STATS64(sw, tx_bcast_pkts);
> +
> +	stats->bytes = 0;
> +	stats->bytes += BNGE_GET_RING_STATS64(sw, tx_ucast_bytes);
> +	stats->bytes += BNGE_GET_RING_STATS64(sw, tx_mcast_bytes);
> +	stats->bytes += BNGE_GET_RING_STATS64(sw, tx_bcast_bytes);
> +
> +	stats->hw_drop_errors = BNGE_GET_RING_STATS64(sw, tx_error_pkts);
> +	stats->hw_drops = BNGE_GET_RING_STATS64(sw, tx_discard_pkts) +
> +				stats->hw_drop_errors;
> +}
> +
> +static void bnge_get_base_stats(struct net_device *dev,
> +				struct netdev_queue_stats_rx *rx,
> +				struct netdev_queue_stats_tx *tx)
> +{
> +	struct bnge_net *bn = netdev_priv(dev);
> +
> +	rx->packets = bn->net_stats_prev.rx_packets;
> +	rx->bytes = bn->net_stats_prev.rx_bytes;
       ^^^^

Can this race with bnge_close_core when reading bn->net_stats_prev?
bnge_close_core writes to bn->net_stats_prev while this function reads
it without any locking.

Looking at bnge_get_stats64, it uses rcu_read_lock() before accessing
bn->net_stats_prev. While this won't cause a crash like the other two
issues, it could result in torn reads on 32-bit systems where reading
u64 is not atomic, potentially returning inconsistent statistics to
userspace.

Should bnge_get_base_stats also use rcu_read_lock() when reading
bn->net_stats_prev?

> +
> +	tx->packets = bn->net_stats_prev.tx_packets;
> +	tx->bytes = bn->net_stats_prev.tx_bytes;
> +}
> +
> +static const struct netdev_stat_ops bnge_stat_ops = {
> +	.get_queue_stats_rx	= bnge_get_queue_stats_rx,
> +	.get_queue_stats_tx	= bnge_get_queue_stats_tx,
> +	.get_base_stats		= bnge_get_base_stats,
> +};
> +

[ ... ]

