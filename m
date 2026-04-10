Return-Path: <netdev+bounces-277565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMptJDJa2WlGoggAu9opvQ
	(envelope-from <netdev+bounces-277565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:14:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2903DC6E7
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45A493045ECA
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329D037FF6E;
	Fri, 10 Apr 2026 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAhC5VmT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBFB345725;
	Fri, 10 Apr 2026 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775851946; cv=none; b=bvsK9DkHcqd66dDvzaoXvHy36qDpgmZ05TZPp6Q3ZfjTVjbb1GQJrzIlXjdQqs0DAf1T/pde1pfj3sVqgX/5w4zvFCzESCxrwGXjA9Ac3pFbfsfw50+ZGp+qXY+r2XXyade/VrrosG2/W/bCJxw5KDgIMIH9BayjyAmIE83XcEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775851946; c=relaxed/simple;
	bh=zJENbdJF3J8/i0rEsNUS4/irSrpTd9hqFECXcs7Qcos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtKDGDrQA17smjnv7/p4bQ8jRJGePH7KJQgtSnRPsx0F7ObSDh42Tu6QutE+R0VuZFmQl7aeCCSx0BW7Txy6uDBmmolthfphHz9jA8/E3i9LW4HitOOKVnT321wAR/E7GPBn+p+W0ahccq+G4O6F8UVpS4caAr8+QNCque0bt4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAhC5VmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B298C19421;
	Fri, 10 Apr 2026 20:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775851945;
	bh=zJENbdJF3J8/i0rEsNUS4/irSrpTd9hqFECXcs7Qcos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UAhC5VmThF6Xn0bJcBm3XoWuvLFehrmwCCVh8/pBq51dJFadCd3MmwBLZuJ/+Esuy
	 yAaIxmi+LknCLKqbqRfZKhki0iImduT3VzjUsiyF8CJohdLB1DLu6cRojlFP3cb6sE
	 aGprfqeW2cf5ZpIWjo68etmwJgyaQeRnQBC3Kx+Fp8c2pDmMXUaehg04a9GRfXeb82
	 LKKy4zyoVCmHc1TrP4h+iy9LeAPIxFDHJbJyijQCTWeXElHREIIS+M/FSSqPeG11WG
	 BRzU4qLsZ3YVf1uZoa8OH/07M8TfEl3uCf5E3Yw7qSRgzKrTjsROVmWOU2/TbfOshj
	 WLY9DE2MjJ7uQ==
From: Simon Horman <horms@kernel.org>
To: gongfan1@huawei.com
Cc: Simon Horman <horms@kernel.org>,
	edumazet@google.com,
	zhengjiezhen@h-partners.com,
	guoxin09@huawei.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	maxime.chevallier@bootlin.com,
	zhoushuai28@huawei.com,
	mohsin.bashr@gmail.com,
	ioana.ciornei@nxp.com,
	zhuyikai1@h-partners.com,
	luosifu@huawei.com,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	shijing34@huawei.com,
	wulike1@huawei.com
Subject: Re: [PATCH net-next v04 3/6] hinic3: Add ethtool coalesce ops
Date: Fri, 10 Apr 2026 21:12:09 +0100
Message-ID: <20260410201209.651627-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <f9f5c1239d17675283a2da8b307f5aca8f46864c.1775618798.git.zhuyikai1@h-partners.com>
References: <f9f5c1239d17675283a2da8b307f5aca8f46864c.1775618798.git.zhuyikai1@h-partners.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,h-partners.com,huawei.com,vger.kernel.org,lunn.ch,bootlin.com,gmail.com,nxp.com,davemloft.net,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-277565-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 1C2903DC6E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
hinic3: Add ethtool coalesce ops

This patch implements ethtool .get_coalesce and .set_coalesce callback
functions to allow users to configure and monitor RX coalesce settings.

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> index be26698fc658..a4b2d5ba81f8 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c

[ ... ]

> @@ -985,9 +990,230 @@ static void hinic3_get_pause_stats(struct net_device *netdev,
>  	kfree(ps);
>  }
>
> +static int hinic3_set_queue_coalesce(struct net_device *netdev, u16 q_id,
> +				     struct hinic3_intr_coal_info *coal)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_intr_coal_info *intr_coal;
> +	struct hinic3_interrupt_info info = {};
> +	int err;
> +
> +	intr_coal = &nic_dev->intr_coalesce[q_id];
> +
> +	intr_coal->coalesce_timer_cfg = coal->coalesce_timer_cfg;
> +	intr_coal->pending_limit = coal->pending_limit;
> +	intr_coal->rx_pending_limit_low = coal->rx_pending_limit_low;
> +	intr_coal->rx_pending_limit_high = coal->rx_pending_limit_high;
> +
> +	if (!test_bit(HINIC3_INTF_UP, &nic_dev->flags) ||
> +	    q_id >= nic_dev->q_params.num_qps || nic_dev->adaptive_rx_coal)
> +		return 0;
> +
> +	info.msix_index = nic_dev->q_params.irq_cfg[q_id].msix_entry_idx;
> +	info.interrupt_coalesc_set = 1;
> +	info.coalesc_timer_cfg = intr_coal->coalesce_timer_cfg;
> +	info.pending_limit = intr_coal->pending_limit;
> +	info.resend_timer_cfg = intr_coal->resend_timer_cfg;
> +	err = hinic3_set_interrupt_cfg(nic_dev->hwdev, info);
> +	if (err) {
> +		netdev_warn(netdev, "Failed to set queue%u coalesce\n", q_id);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int is_coalesce_exceed_limit(struct net_device *netdev,
> +				    const struct ethtool_coalesce *coal)
> +{
> +	const struct {
> +		const char *name;
> +		u32 value;
> +		u32 limit;
> +	} coalesce_limits[] = {
> +		{"rx_coalesce_usecs",
> +		 coal->rx_coalesce_usecs,
> +		 COALESCE_MAX_TIMER_CFG},
> +		{"rx_max_coalesced_frames",
> +		 coal->rx_max_coalesced_frames,
> +		 COALESCE_MAX_PENDING_LIMIT},
> +		{"rx_max_coalesced_frames_low",
> +		 coal->rx_max_coalesced_frames_low,
> +		 COALESCE_MAX_PENDING_LIMIT},
> +		{"rx_max_coalesced_frames_high",
> +		 coal->rx_max_coalesced_frames_high,
> +		 COALESCE_MAX_PENDING_LIMIT},
> +	};
> +
> +	for (int i = 0; i < ARRAY_SIZE(coalesce_limits); i++) {
> +		if (coalesce_limits[i].value > coalesce_limits[i].limit) {
> +			netdev_err(netdev, "%s out of range %d-%d\n",
> +				   coalesce_limits[i].name, 0,
> +				   coalesce_limits[i].limit);
> +			return -ERANGE;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int is_coalesce_legal(struct net_device *netdev,
> +			     const struct ethtool_coalesce *coal)
> +{
> +	int err;
> +
> +	err = is_coalesce_exceed_limit(netdev, coal);
> +	if (err)
> +		return err;
> +
> +	if (coal->rx_max_coalesced_frames_low >
> +	    coal->rx_max_coalesced_frames_high) {
> +		netdev_err(netdev, "invalid coalesce frame high %u, low %u, unit %d\n",
> +			   coal->rx_max_coalesced_frames_high,
> +			   coal->rx_max_coalesced_frames_low,
> +			   COALESCE_PENDING_LIMIT_UNIT);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

Does this validation allow non-zero low with zero high? For example, if
rx_max_coalesced_frames_low=10 and rx_max_coalesced_frames_high=0, the
condition 'low > high' would be true and return -EINVAL, which is correct.

However, this validation still accepts the case where low equals high, including
when both are zero. In v03, a reviewer asked: "So this would allow non-zero low
and zero high. For example, low = 10, high = 0. Is this expected?" The original
v03 logic was 'low >= high && high > 0' which rejected the case where low
equals high. In v04, this was changed to 'low > high' only, but the reviewer's
concern about whether allowing low=high (including low=0, high=0) is expected
behavior was not directly addressed.

Reference: https://lore.kernel.org/netdev/18d5a9b7-9c8d-4fc4-9332-fab27449dc58@gmail.com/

> +
> +static void check_coalesce_align(struct net_device *netdev,
> +				 u32 item, u32 unit, const char *str)
> +{
> +	if (item % unit)
> +		netdev_warn(netdev, "%s in %d units, change to %u\n",
> +			    str, unit, item - item % unit);
> +}

[ ... ]

> @@ -1003,6 +1229,8 @@ static const struct ethtool_ops hinic3_ethtool_ops = {
>  	.get_eth_ctrl_stats             = hinic3_get_eth_ctrl_stats,
>  	.get_rmon_stats                 = hinic3_get_rmon_stats,
>  	.get_pause_stats                = hinic3_get_pause_stats,
> +	.get_coalesce                   = hinic3_get_coalesce,
> +	.set_coalesce                   = hinic3_set_coalesce,
>  };
>
>  void hinic3_set_ethtool_ops(struct net_device *netdev)

[ ... ]

> @@ -985,9 +990,230 @@ static void hinic3_get_pause_stats(struct net_device *netdev,
>
>  static const struct ethtool_ops hinic3_ethtool_ops = {
> -	.supported_coalesce_params      = ETHTOOL_COALESCE_USECS |
> -					  ETHTOOL_COALESCE_PKT_RATE_RX_USECS,
> +	.supported_coalesce_params      = ETHTOOL_COALESCE_RX_USECS |
> +					  ETHTOOL_COALESCE_RX_MAX_FRAMES |
> +					  ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
> +					  ETHTOOL_COALESCE_RX_MAX_FRAMES_LOW |
> +					  ETHTOOL_COALESCE_RX_MAX_FRAMES_HIGH,

Was the removal of ETHTOOL_COALESCE_TX_USECS intentional? In v02, the code
included 'ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_PKT_RATE_RX_USECS', but
v03 and v04 changed this to only RX-specific parameters. A reviewer asked if
this was intentional, but there was no response from the author and the v04
changelog does not mention this concern.

Reference: https://lore.kernel.org/netdev/18d5a9b7-9c8d-4fc4-9332-fab27449dc58@gmail.com/

