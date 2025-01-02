Return-Path: <netdev+bounces-154803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A3A9FFCFF
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 502143A31A4
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3EC15573A;
	Thu,  2 Jan 2025 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YhqX5L4/"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B7014F9F7
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839855; cv=none; b=aVRLiXhGOC7wbRZqARD3SeY0/uR1/F2fP4bMp8d6LlNrcZtqvYNzbtx1G6eXUCp/wDiel4s4KGbMFeeqMGEbUaC1HpvxDaI2wGs3PL6McUXKLdCi/+Ota9Jj5WveL3EdU7rFuzTZ+zSaC71Gc3cHCd4Y1U9iMLlr3jM4lVv9nLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839855; c=relaxed/simple;
	bh=km5H5wzABpe+H3TtrDTsFCgpwNuXS2ZgEsQps5Oz4u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s57Swc6ECZHHl31IX4IbyV2Hdf1iRzOSfCd85XzBp/LZsrusFfl8K3Wz05WbJDBsgFWDwSIkSDK6kRAKMEw+Yfj21G7b3BeU04K54kVFsNnJkJBjr3Qrol3IFGCW85iPdX8ySgpboFLiJipehraDkLen5geKggmF4DpHnFoO2fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YhqX5L4/; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <00a642f0-5e80-4aa7-b1e5-219fa0fcb973@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1735839851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfoDx02/g+nGMBuGm5/vlY0fqRV13uFTadsHGEpeppI=;
	b=YhqX5L4/aHysa1mU4YmhNQ56Htn0M+VxeQ/E21Z9EaMZkp7ubLzf+ALLzw7MN0U639Zu7h
	JICUzEBTA3ymXMW/uOOvqG0ORpLmKlT+N1KRpSKvidR+H/cXdwJhmsRGhSizjA+PGHZLW6
	l7ZBUqvswF6zfGgjT6GL8w+qew1niEw=
Date: Thu, 2 Jan 2025 17:44:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/4] net: wangxun: Implement get_ts_info
To: Jiawen Wu <jiawenwu@trustnetic.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, jacob.e.keller@intel.com, netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com
References: <20250102103026.1982137-1-jiawenwu@trustnetic.com>
 <20250102103026.1982137-3-jiawenwu@trustnetic.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250102103026.1982137-3-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 02/01/2025 10:30, Jiawen Wu wrote:
> Implement the function get_ts_info in ethtool_ops which is needed to get
> the HW capabilities for timestamping.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>   .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 37 +++++++++++++++++++
>   .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  2 +
>   .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  1 +
>   .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  1 +
>   4 files changed, 41 insertions(+)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> index c4b3b00b0926..2a228faf0c26 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> @@ -455,3 +455,40 @@ void wx_set_msglevel(struct net_device *netdev, u32 data)
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
> +				SOF_TIMESTAMPING_RX_SOFTWARE |

SOF_TIMESTAMPING_RX_SOFTWARE is now moved to core networking and there
is no need to report it from driver

> +				SOF_TIMESTAMPING_SOFTWARE |

SOF_TIMESTAMPING_SOFTWARE means "software-system-clock". What kind of
software clock is provided by the driver?

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


