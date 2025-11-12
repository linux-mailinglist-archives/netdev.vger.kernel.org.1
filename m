Return-Path: <netdev+bounces-237935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD72C51B65
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1176918817B8
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 10:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020F6303A23;
	Wed, 12 Nov 2025 10:36:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07FF2F9D94;
	Wed, 12 Nov 2025 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943818; cv=none; b=dFhr2yM4MQ2QBpvqLUbTzto3IGlM+4S9zbFlQ4XIzAeiDBYF3P99frS5Ps7Q+AQxQhuzjmdRnaXem9bY7LBqqKvLwA0JqQZxWjoML+WxEcVoRI3AemM9mWfRkm3KGePznnvM6mnn3uhw+gM3cY8EIuPoMK/Nz427AOO6cdXCDJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943818; c=relaxed/simple;
	bh=Acze1rwtk7babDJi3givwJP4IT0+DonopucP8OPEWmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zdh1HNSwC04a9dRDHLKZcKbNR02hrrZbYcFEm9xQlvxNeoX0PpaIWBE3f6PUsYnU8Q/xWhTuObFXDkWnu26krF0DCdSQQgwkghTLHyLIwZgJc8w/3ZV4VlbjncRkmbcUWVLjEPdHQijCwW6ZCXdtlctAn5QOw/TaFHZadhq/R2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.44.32] (unknown [185.238.219.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 496CC617C4FA5;
	Wed, 12 Nov 2025 11:36:04 +0100 (CET)
Message-ID: <73e29237-4937-4cc7-9830-427bf7464591@molgen.mpg.de>
Date: Wed, 12 Nov 2025 11:35:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next] net: ixgbe: convert to use
 .get_rx_ring_count
To: Breno Leitao <leitao@debian.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20251112-ixgbe_gxrings-v1-1-960e139697fa@debian.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251112-ixgbe_gxrings-v1-1-960e139697fa@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Breno,


Thank you for your patch.

Am 12.11.25 um 11:23 schrieb Breno Leitao:
> Convert the ixgbe driver to use the new .get_rx_ring_count ethtool
> operation for handling ETHTOOL_GRXRINGS command. This simplifies the
> code by extracting the ring count logic into a dedicated callback.
> 
> The new callback provides the same functionality in a more direct way,
> following the ongoing ethtool API modernization.

Maybe add a paragraph how you tested this.

> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> index 2d660e9edb80..2ad81f687a84 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -2805,6 +2805,14 @@ static int ixgbe_rss_indir_tbl_max(struct ixgbe_adapter *adapter)
>   		return 64;
>   }
>   
> +static u32 ixgbe_get_rx_ring_count(struct net_device *dev)
> +{
> +	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
> +
> +	return min_t(u32, adapter->num_rx_queues,
> +		     ixgbe_rss_indir_tbl_max(adapter));
> +}
> +
>   static int ixgbe_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
>   			   u32 *rule_locs)
>   {
> @@ -2812,11 +2820,6 @@ static int ixgbe_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
>   	int ret = -EOPNOTSUPP;
>   
>   	switch (cmd->cmd) {
> -	case ETHTOOL_GRXRINGS:
> -		cmd->data = min_t(int, adapter->num_rx_queues,
> -				  ixgbe_rss_indir_tbl_max(adapter));
> -		ret = 0;
> -		break;
>   	case ETHTOOL_GRXCLSRLCNT:
>   		cmd->rule_cnt = adapter->fdir_filter_count;
>   		ret = 0;
> @@ -3743,6 +3746,7 @@ static const struct ethtool_ops ixgbe_ethtool_ops = {
>   	.get_ethtool_stats      = ixgbe_get_ethtool_stats,
>   	.get_coalesce           = ixgbe_get_coalesce,
>   	.set_coalesce           = ixgbe_set_coalesce,
> +	.get_rx_ring_count	= ixgbe_get_rx_ring_count,
>   	.get_rxnfc		= ixgbe_get_rxnfc,
>   	.set_rxnfc		= ixgbe_set_rxnfc,
>   	.get_rxfh_indir_size	= ixgbe_rss_indir_size,
> @@ -3791,6 +3795,7 @@ static const struct ethtool_ops ixgbe_ethtool_ops_e610 = {
>   	.get_ethtool_stats      = ixgbe_get_ethtool_stats,
>   	.get_coalesce           = ixgbe_get_coalesce,
>   	.set_coalesce           = ixgbe_set_coalesce,
> +	.get_rx_ring_count	= ixgbe_get_rx_ring_count,
>   	.get_rxnfc		= ixgbe_get_rxnfc,
>   	.set_rxnfc		= ixgbe_set_rxnfc,
>   	.get_rxfh_indir_size	= ixgbe_rss_indir_size,

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

