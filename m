Return-Path: <netdev+bounces-176107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1005FA68CFF
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 13:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6255175956
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 12:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8361255223;
	Wed, 19 Mar 2025 12:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDVyaULN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDCB212B02;
	Wed, 19 Mar 2025 12:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742387651; cv=none; b=AJiEDxEttXt2/2tIcRYOJukMx/DchpC57lPNLq2bfNMqermLG6qRKBcrVvtgQM1GSu+zel/XJRrrUHD3SKoDANPgG1L/Xj0mAhbzLTrVo75LxZ/bMK6sgV8tOzQJKfWjuIazTaTflDLALuyp4BTr3WM918sCmUjniu4wKCuUjtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742387651; c=relaxed/simple;
	bh=u4CvmzG+F/cEBCAy6e783SpWREAq0lot6p7ZqiX6RRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHW+qIYg3yuKs2PndaTD1FgJzUD8aV1NT2XBG0zSD8WJsIC6cnRpM+fiJHjcKGSmMvjb7JCeGfyysTRQkWdpVLZAS8PIeG1ulftlKR7HA7WJDEpUlwEZjU1omB8VX8WyltLgfc/I1V6X42pFEajjlAxvCv+FoyBgxXJZKJuI/PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDVyaULN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD32C4CEE9;
	Wed, 19 Mar 2025 12:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742387651;
	bh=u4CvmzG+F/cEBCAy6e783SpWREAq0lot6p7ZqiX6RRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YDVyaULNiNHqe6vdv8o1kvhSbYiQYYwZoqi75nvqC1kSv42H+fmzZ2bCFd22ewHbI
	 JKd3ihQMUUiokmvtp3XZs9WdX3aC4Lm1LjQGNsOEwMuBj3/vDlWk9INsT5q6fwGsE9
	 O+bs+S3dmihmy1SqF9boAdNjmwFJc6FCWrYmJMLTriUPDHagd4tfRyiC/3TYQlNGpY
	 kSrlM0LqrdFQchBpZeI9jNl4af9ej1uudHPYC4JWtcQtW9Uv3E+0xFs52pw/Psw/H8
	 H/05r7Dg8pzD+90molK2zsTxPbWwaLaS34+6erFM96obKwQ1dR7Gfbh87KSeEhTRYx
	 Z4zf7BcPIqBiQ==
Date: Wed, 19 Mar 2025 12:34:07 +0000
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next] rtase: Add ndo_setup_tc support for CBS offload
 in traffic control setup
Message-ID: <20250319123407.GC280585@kernel.org>
References: <20250314094021.10120-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314094021.10120-1-justinlai0215@realtek.com>

On Fri, Mar 14, 2025 at 05:40:21PM +0800, Justin Lai wrote:
> Add support for ndo_setup_tc to enable CBS offload functionality as
> part of traffic control configuration for network devices.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

...

> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> index 2aacc1996796..2a61cd192026 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -1661,6 +1661,54 @@ static void rtase_get_stats64(struct net_device *dev,
>  	stats->rx_length_errors = tp->stats.rx_length_errors;
>  }
>  
> +static void rtase_set_hw_cbs(const struct rtase_private *tp, u32 queue)
> +{
> +	u32 idle = tp->tx_qos[queue].idleslope * RTASE_1T_CLOCK;
> +	u32 val, i;
> +
> +	val = u32_encode_bits(idle / RTASE_1T_POWER, RTASE_IDLESLOPE_INT_MASK);
> +	idle %= RTASE_1T_POWER;
> +
> +	for (i = 1; i <= RTASE_IDLESLOPE_INT_SHIFT; i++) {
> +		idle *= 2;
> +		if ((idle / RTASE_1T_POWER) == 1)
> +			val |= BIT(RTASE_IDLESLOPE_INT_SHIFT - i);
> +
> +		idle %= RTASE_1T_POWER;
> +	}
> +
> +	rtase_w32(tp, RTASE_TXQCRDT_0 + queue * 4, val);
> +}
> +
> +static void rtase_setup_tc_cbs(struct rtase_private *tp,
> +			       const struct tc_cbs_qopt_offload *qopt)
> +{
> +	u32 queue = qopt->queue;

Hi Justin,

Does queue need to be checked somewhere to make sure it is in range?

> +
> +	tp->tx_qos[queue].hicredit = qopt->hicredit;
> +	tp->tx_qos[queue].locredit = qopt->locredit;
> +	tp->tx_qos[queue].idleslope = qopt->idleslope;
> +	tp->tx_qos[queue].sendslope = qopt->sendslope;

Does qopt->enable need to be honoured in order to allow
the offload to be both enabled and disabled?

> +
> +	rtase_set_hw_cbs(tp, queue);
> +}
> +
> +static int rtase_setup_tc(struct net_device *dev, enum tc_setup_type type,
> +			  void *type_data)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +
> +	switch (type) {
> +	case TC_SETUP_QDISC_CBS:
> +		rtase_setup_tc_cbs(tp, type_data);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
>  static netdev_features_t rtase_fix_features(struct net_device *dev,
>  					    netdev_features_t features)
>  {

...

