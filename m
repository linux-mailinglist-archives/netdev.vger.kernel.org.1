Return-Path: <netdev+bounces-143754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777AA9C3FAB
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 14:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D78F1C2174D
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 13:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5D219D8A9;
	Mon, 11 Nov 2024 13:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PbMwkWqG"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD12194ACC
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 13:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731332507; cv=none; b=VHRt+7PEbZtR18BLOZXyzBPSA/djTSNtP++y2TZY4hm8mmcZx1ZxgU2b/fpVdYgMyeakq5n5YZbtJJl5/c9sWtoFKqlV+MURfZTP7AP179AAl0x3GA/DhiTWyqblwryXRVjllXNOuQ/i0XKJi8b+wYxepyFvMwE4KvIjnlOSOJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731332507; c=relaxed/simple;
	bh=+QRXRDdIlw+Svhh4sVB+mO1XLL8LjPKIRH2bR+ZAz9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sFYw4BiUM+YU9MT8NUqy349Ak0nQ4LnAZ+9oDC9qMawZ7XFrx5BzOQyxWzYRzkdTY2z8m8Shq0m292odpFV2vZKI7wOMPo5yCvO40sH7jNlIR/JRISwElWiQ1VutTYOO/sv197qsLfzax3SU/Sa/pZn90JlHC0O8ZYV9KhARRB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PbMwkWqG; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e9312a77-80fa-4915-b2a9-2dcbfcf581a4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731332502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0tJFZxcADoWnsLW+WgeM0GNfB/Rg8Wjey9ZAg9wb7rY=;
	b=PbMwkWqG7KHdN/ghiO4BJ6ne3eB5G5oizRQ1ncfWrqkRtQpOfDPwV+nQxqsx0OZSvjUazq
	eF9Kzupko4oXK1N6MQltGpD7i3OgU9NldNFeQR5PCF/c4MjD0vep40qagUOjoL43vwfomr
	GIfpu4FpwFH7xIJeTIdoEGGIbxv0VeI=
Date: Mon, 11 Nov 2024 13:41:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 2/5] net: phy: microchip_ptp : Add ptp library
 for Microchip phys
To: Divya Koppera <divya.koppera@microchip.com>, andrew@lunn.ch,
 arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 richardcochran@gmail.com
References: <20241111125833.13143-1-divya.koppera@microchip.com>
 <20241111125833.13143-3-divya.koppera@microchip.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241111125833.13143-3-divya.koppera@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/11/2024 12:58, Divya Koppera wrote:
> Add ptp library for Microchip phys
> 1-step and 2-step modes are supported, over Ethernet and UDP(ipv4, ipv6)
> 
> Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
> ---
> v1 -> v2
> - Removed redundant memsets
> - Moved to standard comparision than memcmp for u16
> - Fixed sparse/smatch warnings reported by kernel test robot
> - Added spinlock to shared code
> - Moved redundant part of code out of spinlock protected area
> ---
>   drivers/net/phy/microchip_ptp.c | 998 ++++++++++++++++++++++++++++++++
>   1 file changed, 998 insertions(+)
>   create mode 100644 drivers/net/phy/microchip_ptp.c

[..snip..]

> +static struct mchp_ptp_rx_ts *mchp_ptp_get_rx_ts(struct mchp_ptp_clock *ptp_clock)
> +{
> +	struct phy_device *phydev = ptp_clock->phydev;
> +	struct mchp_ptp_rx_ts *rx_ts = NULL;
> +	u32 sec, nsec;
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
> +	rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> +			  MCHP_PTP_RX_MSG_HEADER2(BASE_PORT(ptp_clock)));
> +	if (rc < 0)
> +		goto error;
> +
> +	rx_ts = kzalloc(sizeof(*rx_ts), GFP_KERNEL);

I think I've asked it already, but why zero out new allocation, which
will be fully re-written by the next instructions? Did you find any
problems?

> +	if (!rx_ts)
> +		return NULL;
> +
> +	rx_ts->seconds = sec;
> +	rx_ts->nsec = nsec;
> +	rx_ts->seq_id = rc;
> +
> +error:
> +	return rx_ts;
> +}
> +
> +static void mchp_ptp_process_rx_ts(struct mchp_ptp_clock *ptp_clock)
> +{
> +	struct phy_device *phydev = ptp_clock->phydev;
> +	int caps;
> +
> +	do {
> +		struct mchp_ptp_rx_ts *rx_ts;
> +
> +		rx_ts = mchp_ptp_get_rx_ts(ptp_clock);
> +		if (rx_ts)
> +			mchp_ptp_match_rx_ts(ptp_clock, rx_ts);
> +
> +		caps = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> +				    MCHP_PTP_CAP_INFO(BASE_PORT(ptp_clock)));
> +		if (caps < 0)
> +			return;
> +	} while (MCHP_PTP_RX_TS_CNT(caps) > 0);
> +}
> +

