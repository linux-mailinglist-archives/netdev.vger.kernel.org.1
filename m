Return-Path: <netdev+bounces-154786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D409FFCC8
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2101162806
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF6B133987;
	Thu,  2 Jan 2025 17:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aO6BgGsN"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1637F1420A8
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839248; cv=none; b=CiIMwAY49M9XNkc2xxqT9m3jM8oLAh1fN1au+UxD7OsF2Tw44QNhYgqfGzQGy4pwcq1d1ejRxU18+nJpeTKVSekSjTYWwMLM4+wZ7xWMOmCScfD3/1eHB7Ow/iouE92bx0E3mFeDKAyezfpXuxRq0yvSrl7BMaRLQPw2IJr5ZQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839248; c=relaxed/simple;
	bh=QHWKK0xoCGwcpTig2P1cz+z5mYy8CtK+sa/rTjhUQWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+2gyCC2m7A/ah8VsAPRnpslulmDEo2eg31rEtNQ37RMEBH8HxN50xZ8dd6+VrBwmzLTDLNfVqWxt8QhDoSKIBEUf0elrmER22CjSpNbDHp2KRgSs9/4ra83N6aCbcQaFULG7+TxCawsnr2oveG8W+Yjz4mk/NjuyrSEjSRFBzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aO6BgGsN; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ce5f90f8-4471-43c7-b580-0fa42343d448@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1735839242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J7H0GuG5N2VNxhso5RXR0A2cNHYPxlxZ1ZJYMCSGlvs=;
	b=aO6BgGsNfqxvbkigFKh0X3UqZi/FUWWmmP2YZVfWkunU/mupUd/2rJAW/ggA68SNkJs2Ei
	gDotDUnAsMe+eeCFCyW1a2XszSf7zzrXnWyvSw7MBPyFr5JB+o3ExPD/8w3kK7efwqev3v
	g9LqMOydjSCih2Vv3++Gqhyqklxza/0=
Date: Thu, 2 Jan 2025 17:33:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/4] net: wangxun: Add support for PTP clock
To: Jiawen Wu <jiawenwu@trustnetic.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, jacob.e.keller@intel.com, netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com
References: <20250102103026.1982137-1-jiawenwu@trustnetic.com>
 <20250102103026.1982137-2-jiawenwu@trustnetic.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250102103026.1982137-2-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 02/01/2025 10:30, Jiawen Wu wrote:
> Implement support for PTP clock on Wangxun NICs.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

[...]

>   
> +int wx_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
> +{
> +	struct wx *wx = netdev_priv(netdev);
> +
> +	switch (cmd) {
> +	case SIOCGHWTSTAMP:
> +		return wx_ptp_get_ts_config(wx, ifr);
> +	case SIOCSHWTSTAMP:
> +		return wx_ptp_set_ts_config(wx, ifr);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +EXPORT_SYMBOL(wx_ioctl);
> +
>   MODULE_DESCRIPTION("Common library for Wangxun(R) Ethernet drivers.");
>   MODULE_LICENSE("GPL");

[...]

> @@ -507,6 +513,7 @@ static const struct net_device_ops ngbe_netdev_ops = {
>   	.ndo_get_stats64        = wx_get_stats64,
>   	.ndo_vlan_rx_add_vid    = wx_vlan_rx_add_vid,
>   	.ndo_vlan_rx_kill_vid   = wx_vlan_rx_kill_vid,
> +	.ndo_eth_ioctl          = wx_ioctl,
>   };
>   
>   /**

[...]

> @@ -479,6 +488,7 @@ static const struct net_device_ops txgbe_netdev_ops = {
>   	.ndo_get_stats64        = wx_get_stats64,
>   	.ndo_vlan_rx_add_vid    = wx_vlan_rx_add_vid,
>   	.ndo_vlan_rx_kill_vid   = wx_vlan_rx_kill_vid,
> +	.ndo_eth_ioctl          = wx_ioctl,
>   };
> 

ioctl interface is deprecated for this case. Could you please use
.ndo_hwtstamp_get and .ndo_hwtstamp_set for the new code?



