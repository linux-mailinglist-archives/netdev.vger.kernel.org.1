Return-Path: <netdev+bounces-142876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83519C08F9
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 15:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB811F240F6
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B530621219F;
	Thu,  7 Nov 2024 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLs0+dJr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3471E049C;
	Thu,  7 Nov 2024 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730990049; cv=none; b=AxYzwjzi7jvX4e0zDaINr+c/qaOX1730zKcnnQLiC0X9ttBdnNs/vWNAMm+DTa13GBldsmDmb2nIIYmde2lSfMBgnIpFWiITRN73ILjmgTihZhpXPUtlMMZ5jLnhq/9qHt4SbuxT6zreXz+BKatCPuYUkxGZ0yfrMARSXwr2uTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730990049; c=relaxed/simple;
	bh=PZ0qlphJcD8vX64gcDaorA5K5So48tJfKoWbNIH4d5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqT/2wrPFD5J45RXLUc4H3ileg4B1ycVvlFoiCDRZ7RVBvzTjAL3GyUp2BgI9fF8ajjeoQyeflpbY9rwcUIBLGOcaqY5SSs3M+TpL+aXOyDux/M5iwFQA29rg+InGx/R+c0e0HyeiVzKL8lZmRIlC72IyqMTOOeSAC8wv+EufcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLs0+dJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935D0C4CECC;
	Thu,  7 Nov 2024 14:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730990049;
	bh=PZ0qlphJcD8vX64gcDaorA5K5So48tJfKoWbNIH4d5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aLs0+dJrOkCwh+rGYeR+BNamanHu9Yy6X6Nr3eJEp8SwlcPvp5BGy/oVovkQzpdFh
	 v14otvCmmY2CqP/Z9qC1yAUCFc+UFbLBP1jH481MZGzBBgd7sjI9E+Sg06rVN/2PVF
	 UNYighYZmct23f2LtAd7/5KzI6OUY0pArTzJxNVC+TI6O7UEzLKm+XdzMltHQgBjzh
	 DUe5+DRhEk5IyUyDjsRT/wkLiIz9jaC5wXFw8VX7T6qQb/3QgJaHq2/lvr/rGTYbq7
	 UeML0mOZA8LdYdZnIHpKiUdPzTEURQokiB/qQtOF2tvp1EoPArLfdhxBMkwhDLsUJQ
	 23W38BsTUXytQ==
Date: Thu, 7 Nov 2024 14:34:04 +0000
From: Simon Horman <horms@kernel.org>
To: Divya Koppera <divya.koppera@microchip.com>
Cc: andrew@lunn.ch, arun.ramadoss@microchip.com,
	UNGLinuxDriver@microchip.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, richardcochran@gmail.com
Subject: Re: [PATCH net-next 2/5] net: phy: microchip_ptp : Add ptp library
 for Microchip phys
Message-ID: <20241107143404.GV4507@kernel.org>
References: <20241104090750.12942-1-divya.koppera@microchip.com>
 <20241104090750.12942-3-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104090750.12942-3-divya.koppera@microchip.com>

On Mon, Nov 04, 2024 at 02:37:47PM +0530, Divya Koppera wrote:
> Add ptp library for Microchip phys
> 1-step and 2-step modes are supported, over Ethernet and UDP(ipv4, ipv6)
> 
> Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
> ---
>  drivers/net/phy/microchip_ptp.c | 990 ++++++++++++++++++++++++++++++++
>  1 file changed, 990 insertions(+)
>  create mode 100644 drivers/net/phy/microchip_ptp.c
> 
> diff --git a/drivers/net/phy/microchip_ptp.c b/drivers/net/phy/microchip_ptp.c

...

> +static bool mchp_ptp_get_sig_tx(struct sk_buff *skb, u16 *sig)
> +{
> +	struct ptp_header *ptp_header;
> +	int type;
> +
> +	type = ptp_classify_raw(skb);
> +	if (type == PTP_CLASS_NONE)
> +		return false;
> +
> +	ptp_header = ptp_parse_header(skb, type);
> +	if (!ptp_header)
> +		return false;
> +
> +	*sig = htons(ptp_header->sequence_id);

Hi Divya,

The type of *sig is u16, a host-byte order integer.
But htons() returns __be16, a big-endian integer.
This does not seem right.

Likewise, in the caller, and beyond, if these are big-endian integers
then appropriate types - probably __be16 - should be used.

Flagged by Sparse.

> +
> +	return true;
> +}

...

> +static struct mchp_ptp_rx_ts *mchp_ptp_get_rx_ts(struct mchp_ptp_clock *ptp_clock)
> +{
> +	struct phy_device *phydev = ptp_clock->phydev;
> +	struct mchp_ptp_rx_ts *rx_ts = NULL;
> +	u32 sec, nsec;
> +	u16 seq;
> +	int rc;
> +
> +	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> +			  MCHP_PTP_RX_INGRESS_NS_HI(BASE_PORT(ptp_clock)));
> +	if (rc < 0)
> +		goto error;
> +	if (!(rc & MCHP_PTP_RX_INGRESS_NS_HI_TS_VALID)) {
> +		phydev_err(phydev, "RX Timestamp is not valid!\n");
> +		goto error;
> +	}
> +	nsec = (rc & GENMASK(13, 0)) << 16;
> +
> +	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> +			  MCHP_PTP_RX_INGRESS_NS_LO(BASE_PORT(ptp_clock)));
> +	if (rc < 0)
> +		goto error;
> +	nsec |= rc;
> +
> +	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> +			  MCHP_PTP_RX_INGRESS_SEC_HI(BASE_PORT(ptp_clock)));
> +	if (rc < 0)
> +		goto error;
> +	sec = rc << 16;
> +
> +	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> +			  MCHP_PTP_RX_INGRESS_SEC_LO(BASE_PORT(ptp_clock)));
> +	if (rc < 0)
> +		goto error;
> +	sec |= rc;
> +
> +	seq = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> +			   MCHP_PTP_RX_MSG_HEADER2(BASE_PORT(ptp_clock)));
> +	if (seq < 0)

seq is unsigned; it can never be less than 0.

Flagged by Smatch.

> +		goto error;
> +
> +	rx_ts = kzalloc(sizeof(*rx_ts), GFP_KERNEL);
> +	if (!rx_ts)
> +		return NULL;
> +
> +	rx_ts->seconds = sec;
> +	rx_ts->nsec = nsec;
> +	rx_ts->seq_id = seq;
> +
> +error:
> +	return rx_ts;
> +}

...

> +static bool mchp_ptp_get_tx_ts(struct mchp_ptp_clock *ptp_clock,
> +			       u32 *sec, u32 *nsec, u16 *seq)
> +{
> +	struct phy_device *phydev = ptp_clock->phydev;
> +	int rc;
> +
> +	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> +			  MCHP_PTP_TX_EGRESS_NS_HI(BASE_PORT(ptp_clock)));
> +	if (rc < 0)
> +		return false;
> +	if (!(rc & MCHP_PTP_TX_EGRESS_NS_HI_TS_VALID))
> +		return false;
> +	*nsec = (rc & GENMASK(13, 0)) << 16;
> +
> +	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> +			  MCHP_PTP_TX_EGRESS_NS_LO(BASE_PORT(ptp_clock)));
> +	if (rc < 0)
> +		return false;
> +	*nsec = *nsec | rc;
> +
> +	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> +			  MCHP_PTP_TX_EGRESS_SEC_HI(BASE_PORT(ptp_clock)));
> +	if (rc < 0)
> +		return false;
> +	*sec = rc << 16;
> +
> +	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> +			  MCHP_PTP_TX_EGRESS_SEC_LO(BASE_PORT(ptp_clock)));
> +	if (rc < 0)
> +		return false;
> +	*sec = *sec | rc;
> +
> +	*seq = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> +			    MCHP_PTP_TX_MSG_HEADER2(BASE_PORT(ptp_clock)));
> +	if (*seq < 0)

Likewise, *seq is unsigned; it can never be less than 0.

> +		return false;
> +
> +	return true;
> +}

...

