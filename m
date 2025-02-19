Return-Path: <netdev+bounces-167795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 346EEA3C5BE
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 18:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C65C3A37EA
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 17:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0831F214232;
	Wed, 19 Feb 2025 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="HuEBl+XN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JWmcviSy"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CCA189906;
	Wed, 19 Feb 2025 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985072; cv=none; b=X7IGf+kB1Cwzpz/pozaP1BHR5VfpQyprzRo0ORAuSie703sQw+H4skTcd/NHyz9ljMEisyVh0+onnSjMx9zrneY6WSYwJEOxAnmxkYlLY4hGv7Sf4tw6K8HWOMoXbjRx0tKG3n60wEM1clhBc2SXEQNZ0VhttDU735FTO+6JuFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985072; c=relaxed/simple;
	bh=GoZpE68iA0G0SjysI+X7wQAPkiW1Vzlo0DXzSRuricI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSkcroNyiCCOIUa/zU+LCA/cNzCUO3Wl9/DGh1aAzDIE6aA2nY7EBENXDn2ZFyzX8dKppq9WuB4Z6K1ytLmcJq1Ey0vzVBmTZ2tIwORCSNHYnwKl2C4NJRYaWqN+vQdKKOOjJlzkQD2rWHOhVbF4RCE/iBblya/3lQeVpD1vKS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=HuEBl+XN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JWmcviSy; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 36BCC1140105;
	Wed, 19 Feb 2025 12:11:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 19 Feb 2025 12:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739985069; x=1740071469; bh=6xRf/SvN2H
	iaZCi3Y5dfp119ptUp4xBlyXwvvU7S1Os=; b=HuEBl+XNFMKxsRPnh/lkdkbgXY
	1d0ieOBWxU2Q0Ca4by4GyVwJPknbXzHk06ZWuai7FHPFrP5xAwwIIpF62VBA2OCF
	42+R2Z9PUCyGUErDa9v1QHZ6t+ib2UDD0IfcYslE66LeyxCwfWfs8WYaLR91l1YR
	AjcTe1/9CIU8SMOQppAD/fV8L82ocgFUAgl6dvw6+tpvZ09kKER6Z2bD52y0QV0L
	0Nz52kaBfjKZEBqClBZNnLCEvnaOJx5fu5xsR0mMPVYWjwyDvnWLSKwKPheoADJq
	nso5JTzUOk0lw3krouLfzvkFvBwv3CPw11ny+9VwG012wjq927gMzG1TSJJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739985069; x=1740071469; bh=6xRf/SvN2HiaZCi3Y5dfp119ptUp4xBlyXw
	vvU7S1Os=; b=JWmcviSyu+R6+p5tIH0/c+teAWq2z6MUEnMCLnIl90sipeKQ71O
	hikCNtZm7k7XEXIWwyZR7ZqZ99kP+xekqkGYJ81x0giHbYTROxNZqeYqmStJWllq
	VfFaQQcV/SSvQXobUzKRnaVZ5o8J73nwcbUDyNeVbKpV+7Fkn6YrL2fu9Ie+FRhO
	9HuAm7Z4hbgs6iaVW0eaP+ZQjwwgnj0UV4nuBpU7yObbZYXYfH6vuD3bNwhL9GS9
	XBt3GhjSS6cLpO6WCcGMpGsnbpEIE/aL0WdOMJYTFxnRpyjncWLS0lbgq0c14MTb
	k4mquZK7MfMJ2VCXOgWnQd/AWLLjloBx34w==
X-ME-Sender: <xms:qxC2Z9fV-qj_8UEn__vhzLrQIlZk29RbJzdEX06vX2F2fq0uqKR8hw>
    <xme:qxC2Z7NSFiteNR2YDVYHltLB43VWU0TPgom63hHEwXfWkTrEOH1kRU0SJzb8sPg6a
    zq7pWpSvKVnU3MsrA>
X-ME-Received: <xmr:qxC2Z2hgMtVyxlUPqVrgmaUwUK5SfvXI9ErhJzdhqE8f41WFGsu7g317uuHk3Mp_8jllJ2ZoqQvFYZ9sEdJYlI0mtrC7XaAXx5LI8txUSsu7ZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffk
    fhggtggujgesthdtsfdttddtvdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihuse
    gugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpedvfeekteduudefieegtdehfeff
    keeuudekheduffduffffgfegiedttefgvdfhvdenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggprhgt
    phhtthhopeegtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghpgedvtddtje
    efsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdr
    nhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    grsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegvughumhgriigvthesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprghlmhgrshhrhihmihhnrgesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomhdprhgtphhtth
    hopegtohhrsggvtheslhifnhdrnhgvth
X-ME-Proxy: <xmx:qxC2Z2_o011EnyG6iOAVEiDHLQtI07SKCAafxA775JeRWFHuv8J8dw>
    <xmx:qxC2Z5t1pRq0cODmX9PThi4vE_9lquUYswQu9pMKIyAarTQrjE1qSg>
    <xmx:qxC2Z1Hx5lVPzNoydma5F87R0co1RmDb6qhfTPnlJ2iLCka4XGyR9g>
    <xmx:qxC2ZwMXbTedpjj_48DIznglXafNNiYu1Oc3ByyXAsa49hsY7dWTSA>
    <xmx:rRC2Z3hQrajGlyJZGUFckWVcslBTXBU_CyvHnfIxhq6VKBTuJBj8Y9YV>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 12:11:03 -0500 (EST)
Date: Wed, 19 Feb 2025 10:11:01 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, almasrymina@google.com, 
	donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com, andrew+netdev@lunn.ch, 
	hawk@kernel.org, ilias.apalodimas@linaro.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org, 
	kory.maincent@bootlin.com, maxime.chevallier@bootlin.com, danieller@nvidia.com, 
	hengqi@linux.alibaba.com, ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, 
	hkallweit1@gmail.com, ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, jdamato@fastly.com, 
	aleksander.lobakin@intel.com, kaiyuanz@google.com, willemb@google.com, daniel.zahka@gmail.com, 
	Andy Gospodarek <gospo@broadcom.com>
Subject: Re: [PATCH net-next v9 07/10] bnxt_en: add support for
 tcp-data-split ethtool command
Message-ID: <lq62gh5sua72thbwswtodutom44d77nar2pxo7gue4h3w2muoc@tpol55i7vic5>
References: <20250114142852.3364986-1-ap420073@gmail.com>
 <20250114142852.3364986-8-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114142852.3364986-8-ap420073@gmail.com>

Hi Taehee,

On Tue, Jan 14, 2025 at 02:28:49PM +0000, Taehee Yoo wrote:
> NICs that uses bnxt_en driver supports tcp-data-split feature by the
> name of HDS(header-data-split).
> But there is no implementation for the HDS to enable by ethtool.
> Only getting the current HDS status is implemented and The HDS is just
> automatically enabled only when either LRO, HW-GRO, or JUMBO is enabled.
> The hds_threshold follows rx-copybreak value. and it was unchangeable.
> 
> This implements `ethtool -G <interface name> tcp-data-split <value>`
> command option.
> The value can be <on> and <auto>.
> The value is <auto> and one of LRO/GRO/JUMBO is enabled, HDS is
> automatically enabled and all LRO/GRO/JUMBO are disabled, HDS is
> automatically disabled.
> 
> HDS feature relies on the aggregation ring.
> So, if HDS is enabled, the bnxt_en driver initializes the aggregation ring.
> This is the reason why BNXT_FLAG_AGG_RINGS contains HDS condition.
> 
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> Tested-by: Stanislav Fomichev <sdf@fomichev.me>
> Tested-by: Andy Gospodarek <gospo@broadcom.com>
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
> 
> v9:
>  - No changes.
> 
> v8:
>  - No changes.
> 
> v7:
>  - Remove hds unrelated changes.
>  - Return -EINVAL instead of -EOPNOTSUPP;
> 
> v6:
>  - Disallow to attach XDP when HDS is in use.
>  - Add Test tag from Andy.
> 
> v5:
>  - Do not set HDS if XDP is attached.
>  - Enable tcp-data-split only when tcp_data_split_mod is true.
> 
> v4:
>  - Do not support disable tcp-data-split.
>  - Add Test tag from Stanislav.
> 
> v3:
>  - No changes.
> 
> v2:
>  - Do not set hds_threshold to 0.
> 
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  5 +++--
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 20 +++++++++++++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  4 ++++
>  4 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index d19c4fb588e5..f029559a581e 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -4630,7 +4630,7 @@ void bnxt_set_ring_params(struct bnxt *bp)
>  	bp->rx_agg_ring_size = 0;
>  	bp->rx_agg_nr_pages = 0;
>  
> -	if (bp->flags & BNXT_FLAG_TPA)
> +	if (bp->flags & BNXT_FLAG_TPA || bp->flags & BNXT_FLAG_HDS)
>  		agg_factor = min_t(u32, 4, 65536 / BNXT_RX_PAGE_SIZE);
>  
>  	bp->flags &= ~BNXT_FLAG_JUMBO;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index 7edb92ce5976..7dc06e07bae2 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -2244,8 +2244,6 @@ struct bnxt {
>  	#define BNXT_FLAG_TPA		(BNXT_FLAG_LRO | BNXT_FLAG_GRO)
>  	#define BNXT_FLAG_JUMBO		0x10
>  	#define BNXT_FLAG_STRIP_VLAN	0x20
> -	#define BNXT_FLAG_AGG_RINGS	(BNXT_FLAG_JUMBO | BNXT_FLAG_GRO | \
> -					 BNXT_FLAG_LRO)
>  	#define BNXT_FLAG_RFS		0x100
>  	#define BNXT_FLAG_SHARED_RINGS	0x200
>  	#define BNXT_FLAG_PORT_STATS	0x400
> @@ -2266,6 +2264,9 @@ struct bnxt {
>  	#define BNXT_FLAG_ROCE_MIRROR_CAP	0x4000000
>  	#define BNXT_FLAG_TX_COAL_CMPL	0x8000000
>  	#define BNXT_FLAG_PORT_STATS_EXT	0x10000000
> +	#define BNXT_FLAG_HDS		0x20000000
> +	#define BNXT_FLAG_AGG_RINGS	(BNXT_FLAG_JUMBO | BNXT_FLAG_GRO | \
> +					 BNXT_FLAG_LRO | BNXT_FLAG_HDS)
>  
>  	#define BNXT_FLAG_ALL_CONFIG_FEATS (BNXT_FLAG_TPA |		\
>  					    BNXT_FLAG_RFS |		\
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index e9e63d95df17..413007190f50 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -840,16 +840,35 @@ static int bnxt_set_ringparam(struct net_device *dev,
>  			      struct kernel_ethtool_ringparam *kernel_ering,
>  			      struct netlink_ext_ack *extack)
>  {
> +	u8 tcp_data_split = kernel_ering->tcp_data_split;
>  	struct bnxt *bp = netdev_priv(dev);
> +	u8 hds_config_mod;
>  
>  	if ((ering->rx_pending > BNXT_MAX_RX_DESC_CNT) ||
>  	    (ering->tx_pending > BNXT_MAX_TX_DESC_CNT) ||
>  	    (ering->tx_pending < BNXT_MIN_TX_DESC_CNT))
>  		return -EINVAL;
>  
> +	hds_config_mod = tcp_data_split != dev->ethtool->hds_config;
> +	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED && hds_config_mod)
> +		return -EINVAL;
> +
> +	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
> +	    hds_config_mod && BNXT_RX_PAGE_MODE(bp)) {
> +		NL_SET_ERR_MSG_MOD(extack, "tcp-data-split is disallowed when XDP is attached");
> +		return -EINVAL;
> +	}
> +
>  	if (netif_running(dev))
>  		bnxt_close_nic(bp, false, false);
>  
> +	if (hds_config_mod) {
> +		if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED)
> +			bp->flags |= BNXT_FLAG_HDS;
> +		else if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_UNKNOWN)
> +			bp->flags &= ~BNXT_FLAG_HDS;
> +	}
> +
>  	bp->rx_ring_size = ering->rx_pending;
>  	bp->tx_ring_size = ering->tx_pending;
>  	bnxt_set_ring_params(bp);
> @@ -5371,6 +5390,7 @@ const struct ethtool_ops bnxt_ethtool_ops = {
>  				     ETHTOOL_COALESCE_STATS_BLOCK_USECS |
>  				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
>  				     ETHTOOL_COALESCE_USE_CQE,
> +	.supported_ring_params	= ETHTOOL_RING_USE_TCP_DATA_SPLIT,
>  	.get_link_ksettings	= bnxt_get_link_ksettings,
>  	.set_link_ksettings	= bnxt_set_link_ksettings,
>  	.get_fec_stats		= bnxt_get_fec_stats,
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> index f88b641533fc..1bfff7f29310 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> @@ -395,6 +395,10 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
>  			    bp->dev->mtu, BNXT_MAX_PAGE_MODE_MTU);
>  		return -EOPNOTSUPP;
>  	}
> +	if (prog && bp->flags & BNXT_FLAG_HDS) {
> +		netdev_warn(dev, "XDP is disallowed when HDS is enabled.\n");
> +		return -EOPNOTSUPP;
> +	}

I think there might be a bug here. On my 6.13 (ish) kernel when I try to
install an XDP driver mode program, I get:

    [Tue Feb 18 17:02:14 2025] bnxt_en 0000:01:00.0 eth0: XDP is disallowed when HDS is enabled.

Setting HDS to auto (seems like off isn't supported?) doesn't seem to
help either:

    # ethtool -g eth0
    Ring parameters for eth0:
    Pre-set maximums:
    RX:                     2047
    RX Mini:                n/a
    RX Jumbo:               8191
    TX:                     2047
    TX push buff len:       n/a
    Current hardware settings:
    RX:                     2047
    RX Mini:                n/a
    RX Jumbo:               8188
    TX:                     2047
    RX Buf Len:             n/a
    CQE Size:               n/a
    TX Push:                off
    RX Push:                off
    TX push buff len:       n/a
    TCP data split:         on

    # ethtool -G eth0 tcp-data-split auto
    # ethtool -g eth0 | grep "TCP data split"
    TCP data split:         on

[..]

Thanks,
Daniel

