Return-Path: <netdev+bounces-294814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CdZiKT9JIGrV0AAAu9opvQ
	(envelope-from <netdev+bounces-294814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:33:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 430136393B6
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:33:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jK2FSdBv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294814-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294814-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 253103072E2C
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 15:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03D63D9DCF;
	Wed,  3 Jun 2026 15:24:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69E53D905D
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 15:24:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500274; cv=none; b=PWwwBK4YoES6PKQdjRw4caW2J53YgXovHGG1c7KmIV9hKV8isWrF9630iPirvC04t1xIGTJ+nVLILjpe+NGX+/L2etVE2E4XF63GBFGCIjGHwKkE75bjlO2VxMre43VOxMzsfOgeM9Ye6QRQutO+x5CLHO+wKs/e5vfxnHllnMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500274; c=relaxed/simple;
	bh=XaIM7zKG2oULZ98oxTQyUI/WBSYxtPGx4M0SHKrpMUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fN2oU69SnYbJDOQ7+CzpC4oUUlpVSOi65ec4ecRqQGQ7ggdAzQ9TeqZqEe3/yYAoX91okR87fVScloDGm4mNDQSPplK61T5YkZSY/tcmQhf4pCH+q7jBX3LcVVvr2eG7Avm3QPc6OhRUshymKH12WS5Nb4z5eKyTEz+lMF+qjTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jK2FSdBv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C44F1F00893;
	Wed,  3 Jun 2026 15:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780500273;
	bh=XssGD0QMEZ8GmnbPrn0JxuHA1sjmRZjJxeTvc9w73C8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jK2FSdBv/M44B2x84UHgef1IqURmLSZFFcQ3it195veF2CTt4GLb9d/Z/SqhJGvP4
	 p385FX4SsJGgH5Xxoe3o+mBND9HWi/4ltieoJ+BJrDmOYod7BQ598sfLaGVNBQdXHO
	 tYO2ZUO9l5hwJa2IydtG96N2P3FBescSPwbCzsogV5tRDssEqoiyolrTFdo/2QTFDY
	 ySCMzJcyXqPVAsizkftK4hgTiAQc51j9cyRBFOZVc1X+llH1Moz/KVkAl0NFkxeJXu
	 rQLPRrzvrCDdG7DyKk1hOeTWB9MhdPMAmkWCGPxOFX9ngnTSdrlrV4ib1QH+VCNcVr
	 oQuyEXCxBOgtg==
From: Simon Horman <horms@kernel.org>
To: mengyuanlou@net-swift.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v3 3/3] net: libwx: support vf hardware statistics
Date: Wed,  3 Jun 2026 16:24:18 +0100
Message-ID: <20260603152417.3797775-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529075147.88398-4-mengyuanlou@net-swift.com>
References: <20260529075147.88398-4-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294814-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mengyuanlou@net-swift.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:jiawenwu@trustnetic.com,m:duanqiangwen@net-swift.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 430136393B6

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: libwx: support vf hardware statistics

This patch adds an ethtool -S path for Wangxun VF netdevs, introduces a
VF-specific stats string array, and gates the hardware register reads in
wx_update_stats() so that VF callers skip them.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> index 30c6ef6103ac..a12e1205ce80 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> @@ -48,6 +48,10 @@ static const struct wx_stats wx_gstrings_stats[] = {
>  	WX_STAT("rx_hwtstamp_cleared", rx_hwtstamp_cleared),
>  };
>  
> +static const struct wx_stats wx_gstrings_stats_vf[] = {
> +	WX_STAT("non_eop_descs", non_eop_descs),
> +};

[Medium]
The subject says "support vf hardware statistics" and the changelog says
"Add support to show hardware statistics for ethtool -S ethx", but the
only entry in wx_gstrings_stats_vf[] is non_eop_descs, which is a pure
software counter accumulated from per-ring rx_stats.non_eop_descs by the
driver fast path in wx_lib.c rather than read from any hardware register.

[Low]
Is there a reason only non_eop_descs is exposed for VFs? wx_update_stats()
already aggregates six per-queue software counters that are equally valid
on a VF (non_eop_descs, alloc_rx_buff_failed, hw_csum_rx_good,
hw_csum_rx_error, restart_queue, tx_busy), and the ethtool -S string list
is in practice a stable interface that monitoring tools key on by name, so
each future addition will churn it.

> +
>  static const struct wx_stats wx_gstrings_fdir_stats[] = {
>  	WX_STAT("fdir_match", stats.fdirmatch),
>  	WX_STAT("fdir_miss", stats.fdirmiss),
> @@ -69,7 +73,9 @@ static const struct wx_stats wx_gstrings_rsc_stats[] = {
>  #define WX_QUEUE_STATS_LEN ( \
>  		(WX_NUM_TX_QUEUES + WX_NUM_RX_QUEUES) * \
>  		(sizeof(struct wx_queue_stats) / sizeof(u64)))
> -#define WX_GLOBAL_STATS_LEN  ARRAY_SIZE(wx_gstrings_stats)
> +#define WX_GLOBAL_STATS_LEN (wx->pdev->is_virtfn ? \
> +		ARRAY_SIZE(wx_gstrings_stats_vf) : \
> +		ARRAY_SIZE(wx_gstrings_stats))

[Low]
WX_GLOBAL_STATS_LEN was previously a compile-time constant. The new
definition silently requires every caller of WX_GLOBAL_STATS_LEN /
WX_STATS_LEN to have a local variable named exactly wx of type
struct wx * already initialised in scope.

That hidden contract is the reason wx_get_drvinfo() had to be reordered in
this same patch:

-	unsigned int stats_len = WX_STATS_LEN;
 	struct wx *wx = netdev_priv(netdev);
+	unsigned int stats_len;

+	stats_len = WX_STATS_LEN;

A future caller using a different identifier (priv, adapter), reaching
the macro before wx is initialised, or using it as a static initialiser /
array size, will fail in non-obvious ways. Would a static inline helper
such as wx_global_stats_len(struct wx *wx) be preferable to a function-like
macro that captures an identifier from the caller's scope?

>  #define WX_FDIR_STATS_LEN  ARRAY_SIZE(wx_gstrings_fdir_stats)
>  #define WX_RSC_STATS_LEN  ARRAY_SIZE(wx_gstrings_rsc_stats)
>  #define WX_STATS_LEN (WX_GLOBAL_STATS_LEN + WX_QUEUE_STATS_LEN)

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> index 260e14d5d541..ce172b6deb80 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> @@ -2917,6 +2917,9 @@ void wx_update_stats(struct wx *wx)
>  	wx->restart_queue = restart_queue;
>  	wx->tx_busy = tx_busy;
>  
> +	if (wx->pdev->is_virtfn)
> +		goto skip_hw_stats;
> +

[Medium]
With this skip in place, none of the values exposed for a VF originate
from hardware, every rd32/rd64 against MMIO is bypassed. Should the
subject and changelog be reworded to describe what the patch actually
does, for example exposing VF software per-queue counters via ethtool -S?

>  	wx_update_xoff_rx_lfc(wx);
>  
>  	hwstats->gprc += rd32(wx, WX_RDM_PKT_CNT);

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> index 26de78e9a69e..ee0b10c71b56 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> @@ -336,6 +337,7 @@ void wxvf_down(struct wx *wx)
>  	netif_tx_disable(netdev);
>  	netif_carrier_off(netdev);
>  	wx_napi_disable_all(wx);
> +	wx_update_stats(wx);
>  	wx_reset_vf(wx);

[Medium]
Is this wx_update_stats(wx) call reachable as anything other than a
no-op? wxvf_down() begins with:

	if (test_and_set_bit(WX_STATE_DOWN, wx->state))
		return;

so by the time the new call runs, WX_STATE_DOWN is already set. And
wx_update_stats() starts with:

	if (test_bit(WX_STATE_DOWN, wx->state) ||
	    test_bit(WX_STATE_RESETTING, wx->state))
		return;

The reset path has the same property, since wxvf_reinit_locked() sets
WX_STATE_RESETTING before calling wxvf_down().

If the intent is to fold the final per-queue counters into the wx
aggregates before wx_reset_vf() and the ring cleanup, would it work to
move the call before WX_STATE_DOWN is set, or use a path that bypasses
the gating bits?

>  
>  	wx_clean_all_tx_rings(wx);

[ ... ]

