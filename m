Return-Path: <netdev+bounces-269894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HCnMfIvvWmI7QIAu9opvQ
	(envelope-from <netdev+bounces-269894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:30:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA442D9992
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 259AD302D116
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD395372EDC;
	Fri, 20 Mar 2026 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yvug7t3p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93B31A6800;
	Fri, 20 Mar 2026 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006182; cv=none; b=WGxaoYJ3SQppbzh4SFbhr1q+esvpMaNTrU0lpUjqLYpaa8Gczmc+wfLVsir+pZV7LEb7tD4uANUH/OE5jczoISZBuCQJe3NC/kQaLCgUJKjmPXw0WWRpMFy5pQYSpQYJAtMyKi1d5TFQDYJivQxlM4C1M/0WfpFpaeib/HPyJMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006182; c=relaxed/simple;
	bh=a/Kg539vue2ngY+OY8ZDZa5onMTW99kiRa7ZsGcZb18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEbjsobGmMhZ6ooKZYlwgQJyZ68aH3q08KH6zfjb4oPo7ppho5V4WwkGTQqyeIEjQ1bHCj8lvn/zWfanEinJNV2EaKeEUgY3e9kcqSDMShcd2AwHeKr98Txtk15HeiyfIkM0eqzbFtZFf5yvvKNpkNU6oP4/0kMh8LjDWxtuLx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yvug7t3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF6EC4CEF7;
	Fri, 20 Mar 2026 11:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774006182;
	bh=a/Kg539vue2ngY+OY8ZDZa5onMTW99kiRa7ZsGcZb18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yvug7t3p3Bt8+9Geiy0PuQm4AnN14FNfEoRpFirz4heoGNuimSPrY1hDvOo/m2IDj
	 8p2yjeQpv2hgrwHzA9+qC0ljMw18niMRBfCFkORPKuLbUGF01FHhwubSkDKDmasoQM
	 VB22LNnCrYJWoqlqkhG8aFWIyCcZysz2+O7zriBE78XX7eFVAAB5L9Z01ULUCV/H9U
	 mLhFvEmRtu9WAEZjie03bNrn8sxqZHHX4b8qtEIJGhNxPQClTuQ9qdzJdiZKVcWqPS
	 YiIvShkqwujditHWSGJ9kUZQZSK/HRpZPmFH6jDvWOtPIJ0a//p/TN7WajwDqWGmpx
	 JzYx00xJHbj4Q==
From: Simon Horman <horms@kernel.org>
To: vikas.gupta@broadcom.com
Cc: Simon Horman <horms@kernel.org>,
	vsrama-krishna.nemani@broadcom.com,
	edumazet@google.com,
	ajit.khaparde@broadcom.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pavan.chebbi@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	michael.chan@broadcom.com,
	bhargava.marreddy@broadcom.com,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 10/10] bng_en: add support for ethtool -S stats display
Date: Fri, 20 Mar 2026 11:27:19 +0000
Message-ID: <20260320112717.2065386-3-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319055124.1350670-11-vikas.gupta@broadcom.com>
References: <20260319055124.1350670-11-vikas.gupta@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-269894-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.954];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2CA442D9992
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html

Simon says: This is somewhat more subjective than the other two AI
generated reviews I released for this patch-set. But I think it does
at least warrant discussion.

---
bng_en: add support for ethtool -S stats display

This patch implements the legacy ethtool statistics interface to expose
hardware counters through ethtool -S, including per-queue ring stats,
TPA stats, port level stats, and per-priority stats.

> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
> index 2ae13f18e2d7..1a0eb987ef6f 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c

[ ... ]

> @@ -42,6 +307,219 @@ static void bnge_get_drvinfo(struct net_device *dev,
>  	strscpy(info->bus_info, pci_name(bd->pdev), sizeof(info->bus_info));
>  }
>
> +static int bnge_get_sset_count(struct net_device *dev, int sset)
> +{
> +	struct bnge_net *bn = netdev_priv(dev);
> +
> +	switch (sset) {
> +	case ETH_SS_STATS:
> +		return bnge_get_num_stats(bn);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}

[ ... ]

> +static void bnge_get_ethtool_stats(struct net_device *dev,
> +				   struct ethtool_stats *stats, u64 *buf)
> +{
> +	struct bnge_net *bn = netdev_priv(dev);
> +	struct bnge_dev *bd = bn->bd;
> +	u32 tpa_stats;
> +	u32 i, j = 0;
> +
> +	if (!bn->bnapi) {
> +		j += bnge_get_num_ring_stats(bd);
> +		goto skip_ring_stats;
> +	}
> +
> +	tpa_stats = bnge_get_num_tpa_ring_stats(bd);
> +	for (i = 0; i < bd->nq_nr_rings; i++) {
> +		struct bnge_napi *bnapi = bn->bnapi[i];
> +		struct bnge_nq_ring_info *nqr;
> +		u64 *sw_stats;
> +		int k;
> +
> +		nqr = &bnapi->nq_ring;
> +		sw_stats = nqr->stats.sw_stats;
> +
> +		if (is_rx_ring(bd, i)) {
> +			buf[j++] = BNGE_GET_RING_STATS64(sw_stats, rx_ucast_pkts);
> +			buf[j++] = BNGE_GET_RING_STATS64(sw_stats, rx_mcast_pkts);
> +			buf[j++] = BNGE_GET_RING_STATS64(sw_stats, rx_bcast_pkts);
> +			buf[j++] = BNGE_GET_RING_STATS64(sw_stats, rx_ucast_bytes);
> +			buf[j++] = BNGE_GET_RING_STATS64(sw_stats, rx_mcast_bytes);
> +			buf[j++] = BNGE_GET_RING_STATS64(sw_stats, rx_bcast_bytes);
> +		}
> +		if (is_tx_ring(bd, i)) {
> +			buf[j++] = BNGE_GET_RING_STATS64(sw_stats, tx_ucast_pkts);
> +			buf[j++] = BNGE_GET_RING_STATS64(sw_stats, tx_mcast_pkts);
> +			buf[j++] = BNGE_GET_RING_STATS64(sw_stats, tx_bcast_pkts);
> +			buf[j++] = BNGE_GET_RING_STATS64(sw_stats, tx_ucast_bytes);
> +			buf[j++] = BNGE_GET_RING_STATS64(sw_stats, tx_mcast_bytes);
> +			buf[j++] = BNGE_GET_RING_STATS64(sw_stats, tx_bcast_bytes);
> +		}

This isn't a bug, but Documentation/networking/statistics.rst flags a
potential concern about interface duplication. The patch adds per-queue
ring statistics (rxqN_ucast_packets, rxqN_mcast_packets,
rxqN_bcast_packets, rxqN_ucast_bytes, rxqN_mcast_bytes, rxqN_bcast_bytes,
and tx equivalents) to the ethtool -S interface.

However, this driver already implements the standard per-queue statistics
API via netdev_stat_ops (bnge_get_queue_stats_rx and
bnge_get_queue_stats_tx in bnge_netdev.c). That interface exposes
per-queue packets and bytes through netlink, which is the designated
mechanism for per-queue counters.

According to Documentation/networking/statistics.rst, per-queue stats
should use the standard netdev_stat_ops interface rather than ethtool -S.
The documentation states that drivers should avoid adding new counters to
ethtool -S for values that have a standard uAPI.

While the ethtool -S stats provide a ucast/mcast/bcast breakdown not
directly available from the standard per-queue API (which aggregates to
total packets and bytes), this still represents duplication of the
fundamental per-queue packet and byte counters. Could these per-queue
stats be omitted from ethtool -S, keeping only the truly hardware-specific
stats like TPA, port-level, and priority stats that don't have a standard
interface?

[ ... ]

> @@ -262,6 +740,9 @@ static const struct ethtool_ops bnge_ethtool_ops = {
>  	.nway_reset		= bnge_nway_reset,
>  	.get_pauseparam		= bnge_get_pauseparam,
>  	.set_pauseparam		= bnge_set_pauseparam,
> +	.get_sset_count		= bnge_get_sset_count,
> +	.get_strings		= bnge_get_strings,
> +	.get_ethtool_stats	= bnge_get_ethtool_stats,
>  	.get_eth_phy_stats	= bnge_get_eth_phy_stats,
>  	.get_eth_mac_stats	= bnge_get_eth_mac_stats,
>  	.get_eth_ctrl_stats	= bnge_get_eth_ctrl_stats,

