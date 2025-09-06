Return-Path: <netdev+bounces-220537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844B0B46808
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 03:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29DCA7A47F9
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 01:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F001A23AC;
	Sat,  6 Sep 2025 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaVgRrDJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF8718BC3D;
	Sat,  6 Sep 2025 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757122829; cv=none; b=i980qwZXmRXM6hEfnCUhW5YF+KyxXx/LHJGSwLxLrGJ1hqTn/OKpeSwu/Djm1kJjjBIkzeEEOUmtiA295YJMbCFivIkEGJnsl8hIG35kVq43nPiEJT6KbhXWuJWzpkMP9BMEJmHSSaqSnKzQroE99gruXQkupBw96woz1oyeezo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757122829; c=relaxed/simple;
	bh=qBPngzmvEW0XrVGmLUiiqF/SwPlUqkzMiy9zfS+M2w8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FWCljz5HuAEJtcrc+I5kymy0Fo8W5eN5mzyGzvlIwhGn3GbqsdNT9X+SH1yJFqFyuj64iRR0oqHko94t6dz90hXG7sRqn/re8f0aRyVBNFw5aGRxm9X3GtJjtHAQ+BzYS9ex8cfFlsLFalwijwTZYAVfYd/onEjR5GGX1MAC7jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaVgRrDJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181FDC4CEF1;
	Sat,  6 Sep 2025 01:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757122828;
	bh=qBPngzmvEW0XrVGmLUiiqF/SwPlUqkzMiy9zfS+M2w8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FaVgRrDJzOgLo9cwMZQPVbZgS7vsp9jMWCOj3SThhK21a6LmJrhA4UCAXmQUaGpJ4
	 82RFqfG7PA4RqkOr2pDcQLLres22YANrAzp9DbDjvV9MtcDRHcwTmrEvj9QGtHIUv6
	 3Vv2AyWFuj6cFNzW0v74CmozWEKtGFi0n7MIV4/uA0MkpfogOqLxZdfZECpswI54UE
	 vu7cMpI96VMdZtPWT7avo1vpLidTR02aqo344jAPw1i0WlfziaQdEygD/zbHvCwfd5
	 biRZJnm9/IGPZjLoxASKyVXDqk0G9xLl42nUYfDwGNLm+wrvV6pN5ZIyuMhJNF3YVz
	 AdIMs+JmXzRFA==
Date: Fri, 5 Sep 2025 18:40:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <richardcochran@gmail.com>, <linux-kernel@vger.kernel.org>,
 <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH net-next v4] amd-xgbe: Add PPS periodic output support
Message-ID: <20250905184027.0b36d81b@kernel.org>
In-Reply-To: <20250903174953.3639692-1-Raju.Rangoju@amd.com>
References: <20250903174953.3639692-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Sep 2025 23:19:53 +0530 Raju Rangoju wrote:
> -		 xgbe-hwtstamp.o xgbe-ptp.o \
> +		 xgbe-hwtstamp.o xgbe-ptp.o xgbe-pps.o\

nit: missing space before the backslash?

>  		 xgbe-i2c.o xgbe-phy-v1.o xgbe-phy-v2.o \
>  		 xgbe-platform.o
>  
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
> index 009fbc9b11ce..c8447825c2f6 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h

>  /* MAC register entry bit positions and sizes */
>  #define MAC_HWF0R_ADDMACADRSEL_INDEX	18
>  #define MAC_HWF0R_ADDMACADRSEL_WIDTH	5
> @@ -460,8 +476,26 @@
>  #define MAC_TSCR_TXTSSTSM_WIDTH		1
>  #define MAC_TSSR_TXTSC_INDEX		15
>  #define MAC_TSSR_TXTSC_WIDTH		1
> +#define MAC_TSSR_ATSSTN_INDEX		16
> +#define MAC_TSSR_ATSSTN_WIDTH		4
> +#define MAC_TSSR_ATSNS_INDEX		25
> +#define MAC_TSSR_ATSNS_WIDTH		5
> +#define MAC_TSSR_ATSSTM_INDEX		24
> +#define MAC_TSSR_ATSSTM_WIDTH		1
> +#define MAC_TSSR_ATSSTN_INDEX		16
> +#define MAC_TSSR_ATSSTN_WIDTH		4
> +#define MAC_TSSR_AUXTSTRIG_INDEX	2
> +#define MAC_TSSR_AUXTSTRIG_WIDTH	1
>  #define MAC_TXSNR_TXTSSTSMIS_INDEX	31
>  #define MAC_TXSNR_TXTSSTSMIS_WIDTH	1
> +#define MAC_AUXCR_ATSEN3_INDEX		7
> +#define MAC_AUXCR_ATSEN3_WIDTH		1
> +#define MAC_AUXCR_ATSEN2_INDEX		6
> +#define MAC_AUXCR_ATSEN2_WIDTH		1
> +#define MAC_AUXCR_ATSEN1_INDEX		5
> +#define MAC_AUXCR_ATSEN1_WIDTH		1
> +#define MAC_AUXCR_ATSEN0_INDEX		4
> +#define MAC_AUXCR_ATSEN0_WIDTH		1

We have a lot of completely unused defines here....

>  #define MAC_TICSNR_TSICSNS_INDEX	8
>  #define MAC_TICSNR_TSICSNS_WIDTH	8
>  #define MAC_TECSNR_TSECSNS_INDEX	8

> +int xgbe_pps_config(struct xgbe_prv_data *pdata,
> +		    struct xgbe_pps_config *cfg, int index, bool on)
> +{
> +	unsigned int value = 0;
> +	unsigned int tnsec;
> +	u64 period;
> +
> +	tnsec = XGMAC_IOREAD(pdata, MAC_PPSx_TTNSR(index));
> +	if (XGMAC_GET_BITS(tnsec, MAC_PPSx_TTNSR, TRGTBUSY0))
> +		return -EBUSY;
> +
> +	value = XGMAC_IOREAD(pdata, MAC_PPSCR);
> +	value &= ~get_pps_mask(index);
> +
> +	if (!on) {
> +		value |= get_pps_cmd(index, 0x5);

..and yet there are constants in the code which do not have a define.


> +		value |= PPSEN0;
> +		XGMAC_IOWRITE(pdata, MAC_PPSCR, value);
> +
> +		return 0;
> +	}
> +
> +	XGMAC_IOWRITE(pdata, MAC_PPSx_TTSR(index), cfg->start.tv_sec);
> +	XGMAC_IOWRITE(pdata, MAC_PPSx_TTNSR(index), cfg->start.tv_nsec);
> +
> +	period = cfg->period.tv_sec * NSEC_PER_SEC;
> +	period += cfg->period.tv_nsec;
> +	do_div(period, XGBE_V2_TSTAMP_SSINC);
> +
> +	if (period <= 1)
> +		return -EINVAL;
> +
> +	XGMAC_IOWRITE(pdata, MAC_PPSx_INTERVAL(index), period - 1);
> +	period >>= 1;
> +	if (period <= 1)
> +		return -EINVAL;

I presume that the writes don't matter until we set PPSCR, so returning
an error after performing some writes already is not a bug. But still
it looks s little odd. Especially checking period twice. Why not
calculate the period first, check that it's not <= 3, and then write
out the entire config only once we know that?

Thanks for redoing the mask helpers BTW I think this is much cleaner.
-- 
pw-bot: cr

