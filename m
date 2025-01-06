Return-Path: <netdev+bounces-155399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D705A022EF
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 11:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DCC61884F25
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 10:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162051DA633;
	Mon,  6 Jan 2025 10:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v3ZbXAek"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7EFF9D6
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736159336; cv=none; b=VZMXv3O5Sg417GlGbRUnulLPzwZxX9iSOkWowtQl5yuEeqqqnZZgObQ30qy9t6eG3bSCQWAogfzj1oI1FEvUN15u8y7Fn+nJMbktxBS1hXQtztlaFDRa6KgoLfyV5bSDKeomxFsoJrgVT0OQEze06Gkkcs60b1WJlmpxJJp//kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736159336; c=relaxed/simple;
	bh=0o/dztFAzIIWSKrxTxjPH+RNXrW7946TgLS+Cu7t+BQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+KIbkKuxJxdV5zJOP51pHvyfXrUbAvDTdadfWMy0Iy8d3cFDXWz1JctgrW8aVaFKUP+KgOY24MMlyk/jvHkYjESc/+kuuBoUZ/kqwcShIVK8on48QgLZHvrL9nzfSPwtrx8QoHMYHqTan3A2jfF7Fqxjkkpb42L3KhEuINQCuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v3ZbXAek; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7710d787-3fab-46bf-b6b5-0fd2ff627a65@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736159331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ymSSkw+Xb701ds0oN6+3BM8MZ47JcS1Dz/qSpOfPg8=;
	b=v3ZbXAekznpDhvQ3rNyEj9Ks4XizSsNX17yaWiuQk1VjUVyU6tTWodOqnhawqMjR93/Nwi
	MtH72kbXmeS+I4pVxxk1IEfiEavW+f8KYAu8dz1AyL/Uu+ujrkiw/HqqF80Em05gu5wDe0
	tQO/LOl0d3mdojTDhWddC733BTY8Kjs=
Date: Mon, 6 Jan 2025 10:28:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 2/4] net: wangxun: Implement get_ts_info
To: Jiawen Wu <jiawenwu@trustnetic.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, jacob.e.keller@intel.com, netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com
References: <20250106084506.2042912-1-jiawenwu@trustnetic.com>
 <20250106084506.2042912-3-jiawenwu@trustnetic.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250106084506.2042912-3-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 06/01/2025 08:45, Jiawen Wu wrote:
> Implement the function get_ts_info in ethtool_ops which is needed to get
> the HW capabilities for timestamping.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>   .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 35 +++++++++++++++++++
>   .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  2 ++
>   .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  1 +
>   .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  1 +
>   4 files changed, 39 insertions(+)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> index c4b3b00b0926..27e6643509f6 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> @@ -455,3 +455,38 @@ void wx_set_msglevel(struct net_device *netdev, u32 data)
>   	wx->msg_enable = data;
>   }
>   EXPORT_SYMBOL(wx_set_msglevel);
> +
> +int wx_get_ts_info(struct net_device *dev,
> +		   struct kernel_ethtool_ts_info *info)
> +{
> +	struct wx *wx = netdev_priv(dev);
> +
> +	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
> +			   BIT(HWTSTAMP_FILTER_PTP_V1_L4_SYNC) |
> +			   BIT(HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ) |
> +			   BIT(HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
> +			   BIT(HWTSTAMP_FILTER_PTP_V2_L4_EVENT) |
> +			   BIT(HWTSTAMP_FILTER_PTP_V2_SYNC) |
> +			   BIT(HWTSTAMP_FILTER_PTP_V2_L2_SYNC) |
> +			   BIT(HWTSTAMP_FILTER_PTP_V2_L4_SYNC) |
> +			   BIT(HWTSTAMP_FILTER_PTP_V2_DELAY_REQ) |
> +			   BIT(HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ) |
> +			   BIT(HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ) |
> +			   BIT(HWTSTAMP_FILTER_PTP_V2_EVENT);
> +
> +	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
> +				SOF_TIMESTAMPING_TX_HARDWARE |
> +				SOF_TIMESTAMPING_RX_HARDWARE |
> +				SOF_TIMESTAMPING_RAW_HARDWARE;
> +
> +	if (wx->ptp_clock)
> +		info->phc_index = ptp_clock_index(wx->ptp_clock);
> +	else
> +		info->phc_index = -1;
> +
> +	info->tx_types = BIT(HWTSTAMP_TX_OFF) |
> +			 BIT(HWTSTAMP_TX_ON);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(wx_get_ts_info);
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
> index 600c3b597d1a..7c3630e3e187 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
> @@ -40,4 +40,6 @@ int wx_set_channels(struct net_device *dev,
>   		    struct ethtool_channels *ch);
>   u32 wx_get_msglevel(struct net_device *netdev);
>   void wx_set_msglevel(struct net_device *netdev, u32 data);
> +int wx_get_ts_info(struct net_device *dev,
> +		   struct kernel_ethtool_ts_info *info);
>   #endif /* _WX_ETHTOOL_H_ */
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> index e868f7ef4920..9270cf8e5bc7 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> @@ -138,6 +138,7 @@ static const struct ethtool_ops ngbe_ethtool_ops = {
>   	.set_channels		= ngbe_set_channels,
>   	.get_msglevel		= wx_get_msglevel,
>   	.set_msglevel		= wx_set_msglevel,
> +	.get_ts_info		= wx_get_ts_info,
>   };
>   
>   void ngbe_set_ethtool_ops(struct net_device *netdev)
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
> index d98314b26c19..9f8df5b3aee0 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
> @@ -529,6 +529,7 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
>   	.set_rxnfc		= txgbe_set_rxnfc,
>   	.get_msglevel		= wx_get_msglevel,
>   	.set_msglevel		= wx_set_msglevel,
> +	.get_ts_info		= wx_get_ts_info,
>   };
>   
>   void txgbe_set_ethtool_ops(struct net_device *netdev)

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

