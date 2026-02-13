Return-Path: <netdev+bounces-258621-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lRzGMPA9j2llOAEAu9opvQ
	(envelope-from <netdev+bounces-258621-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 16:06:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEC1137661
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 16:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1641C30263CC
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 15:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2306356A2B;
	Fri, 13 Feb 2026 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEeTxv6Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1A62C11CF
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770995178; cv=none; b=VF2cO/PRvUY2MDK6FNr+h8hOoOecdDjZb3mvJEulLlec1b3XHgQcC76HGXOBKwwy3FP67xgryIVmp2LjpwdyCZVISbka8gkZHvmD6xhu9Dt9F3xwFVV/lIWzIaEOLwh5ftAuvQ1uswxaOW1+vAEa+LZih01mmQoqtJ+iAMRNZp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770995178; c=relaxed/simple;
	bh=zcMl5ICj6tdjHRVUkCNQNcsPrdeSaI9/cjs1ydke4eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIA4kEx6lYX5phHbpcFYePw5PD1pTbWEtZxndgMx5uuhalkLXQQbJ9w6aLSvr4K8PhXgeA0eZ6pOzAc1bO/KBlS/ogTzbm2d3Tq0v/9Bh/dyGkdx5btAsq3E4bp/4egYD/JoI279t05X0Ks/mf28+7d8iaabMqcA9VprJfSnxwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEeTxv6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4959AC116C6;
	Fri, 13 Feb 2026 15:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770995178;
	bh=zcMl5ICj6tdjHRVUkCNQNcsPrdeSaI9/cjs1ydke4eQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QEeTxv6ZuBwOwbN7qo9vYzzusnmQUVrOe6ZG8wSxEdDpcj2IZkGRRuoBBF/6Yvhrm
	 ishuCbSCgUcjOx5TbAOdMo50GH9TjfF9cb877Ne+8KOHGkqnKbN1ELt5/ZbrbhmetJ
	 do41jgPrsAjbs8uh9C4FALFk3ggZEXLa5+SwD/TmvYx3noxvco0AF23v3tGJXmLvqi
	 OWojZqHtEo/uYrlI9Gkc0beGd4n9ffY3EU1rhY2LP1qo4m0J6htYv5492ccL5jvaku
	 p2dKjgNyzas25SBdcSergQNhHlLakpABdgj6ys+/hGyjM4p3gJpM1BgGXTM4RPUny5
	 HAXcVA8MoWa3g==
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: Simon Horman <horms@kernel.org>,
	anthony.l.nguyen@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: Re: [iwl-next,v1] ice: implement symmetric RSS hash configuration
Date: Fri, 13 Feb 2026 15:01:31 +0000
Message-ID: <20260213150130.2513644-2-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260213034429.1830480-1-aleksandr.loktionov@intel.com>
References: <20260213034429.1830480-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258621-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2EEC1137661
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
ice: implement symmetric RSS hash configuration

The driver advertises symmetric RSS support via supported_input_xfrm
but ice_set_rxfh() ignored the input_xfrm parameter, making it
impossible to configure symmetric hashing. This patch fixes
ice_set_rxfh() to check the input_xfrm parameter and configure
symmetric hashing appropriately, modifies ice_set_rss_vsi_ctx() to use
vsi->rss_hfunc instead of hardcoding values, and updates
ice_get_rxfh_fields() to report symmetric field configurations.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index c6bc29cfb8e6..6dc37f96b57e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -3037,8 +3037,10 @@ ice_get_rxfh_fields(struct net_device *netdev, struct ethtool_rxfh_fields *nfc)
>
>  	hash_flds = ice_get_rss_cfg(&pf->hw, vsi->idx, hdrs, &symm);
>  	if (hash_flds == ICE_HASH_INVALID) {
> -		dev_dbg(dev, "No hash fields found for the given header type, vsi num = %d\n",
> +		/* Provide default symmetric hash fields when no config exists */
> +		dev_dbg(dev, "No RSS config for this flow, using symmetric defaults, vsi num = %d\n",
>  			vsi->vsi_num);
> +		nfc->data = RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3;
>  		return 0;
>  	}
>
> @@ -3067,6 +3069,7 @@ ice_get_rxfh_fields(struct net_device *netdev, struct ethtool_rxfh_fields *nfc)
>  	    hash_flds & ICE_FLOW_HASH_FLD_GTPU_DWN_TEID)
>  		nfc->data |= (u64)RXH_GTP_TEID;
>
> +	nfc->data = RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3;
                  ^^^^^^^

Does this unconditional assignment at the end of ice_get_rxfh_fields()
overwrite the actual hardware configuration that was just computed?

The hash fields are carefully decoded from the hardware configuration
returned by ice_get_rss_cfg() and built up in nfc->data through the series
of bitwise OR operations. Then this line uses assignment (=) rather than
bitwise OR (|=), replacing all those computed values with a fixed set of
hash fields.

This would make the entire per-field computation from the hardware state
become dead code. The function would always report the same fixed hash
fields (RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3) regardless
of what is actually configured in hardware. GTP TEID hash fields would
never be reported even when configured.

Was this intended to be an additional |= operation, or should this line
be removed entirely?

> @@ -3667,7 +3670,6 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
>  	     struct netlink_ext_ack *extack)
>  {
>  	struct ice_netdev_priv *np = netdev_priv(netdev);
> -	u8 hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
>  	struct ice_vsi *vsi = np->vsi;
>  	struct ice_pf *pf = vsi->back;
>  	struct device *dev;

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index d921269e1fe7..31f2757cf7fa 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -1155,7 +1155,7 @@ static void ice_set_fd_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
>   * @ctxt: the VSI context being set
>   * @vsi: the VSI being configured
>   */
> -static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
> +void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
>  {
>  	u8 lut_type, hash_type;
>  	struct device *dev;
> @@ -1181,7 +1181,9 @@ static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
>  		return;
>  	}
>
> -	hash_type = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
> +        if (!vsi->rss_hfunc)
> +		vsi->rss_hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
> +	hash_type = vsi->rss_hfunc;
>  	vsi->rss_hfunc = hash_type;
>
>  	ctxt->info.q_opt_rss =

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
> index 49454d98dcfe..29ba335dcc54 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.h
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.h
> @@ -46,6 +46,7 @@ void ice_vsi_delete(struct ice_vsi *vsi);
>  int ice_vsi_cfg_tc(struct ice_vsi *vsi, u8 ena_tc);
>
>  int ice_vsi_cfg_rss_lut_key(struct ice_vsi *vsi);
> +void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi);
>
>  void ice_vsi_cfg_netdev_tc(struct ice_vsi *vsi, u8 ena_tc);
>

