Return-Path: <netdev+bounces-208330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C23B0B097
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 17:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96BC3AE677
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 15:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788241DE8BE;
	Sat, 19 Jul 2025 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y/EV+ckb"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215DD1EB3D
	for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752938228; cv=none; b=K1SCaj+umhVZd1ULt6CLrWOVCayB0SAGL7x1+xa4PaHXc4V8qcW5B5J8vOXP0JfDykoJhm5WFrLYUUWj1Tys+VQ3wYa2gY3Ap1mTIYJ0BAGv0QmCQgfCGpHA68H75bvoxgzybeEOi1erk2h/JyCmG/nRiqoL/4CSB7fkPM7bUXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752938228; c=relaxed/simple;
	bh=IHwbvCz1zDamw2mairfQORXsN8jGBSDQs5nizcpprvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mQyG58i4K9bZ7nW7Bx+vm4228IAka98JyyPaN+PbcPpvO4/tutCLKv2BqmnDQLeylyXamDmqiCSVXA2AHScYric/MJCsmncFjLegaen75xvLeRcCpWVLE9Z3oIoCwe7cSmWYqbzbPO41xKYCapRSOUcPzQow3YlHkGdNbTLcIAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y/EV+ckb; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <509add4e-5dff-4f30-b96b-488919fedb77@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752938211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xk5P+fAr8LMRJWfH3D/mBbRYfZMtip1HO6juhnoIxBM=;
	b=Y/EV+ckbbNQVvUL5aVpnV+d9009/TlvtMJ0Eln5GB5rU7Qy8/UVEdkLPOZ4LbFOdP6yrqS
	gk5+GjlGTihHxaSG2yoIYmmAQm7BJGAvNKxlgm9cejdCBHDiUOhAevASkJu96HT+w8MKkT
	JHxU52K+ntlrtd0xXPN+sPeWXLJ5zQc=
Date: Sat, 19 Jul 2025 16:16:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RESEND PATCH net-next] amd-xgbe: Configure and retrieve
 'tx-usecs' for Tx coalescing
To: Vishal Badole <Vishal.Badole@amd.com>, Shyam-sundar.S-k@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250719072608.4048494-1-Vishal.Badole@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250719072608.4048494-1-Vishal.Badole@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 19.07.2025 08:26, Vishal Badole wrote:
> Ethtool has advanced with additional configurable options, but the
> current driver does not support tx-usecs configuration.
> 
> Add support to configure and retrieve 'tx-usecs' using ethtool, which
> specifies the wait time before servicing an interrupt for Tx coalescing.
> 
> Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
>   drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 19 +++++++++++++++++--
>   drivers/net/ethernet/amd/xgbe/xgbe.h         |  1 +
>   2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> index 12395428ffe1..362f8623433a 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> @@ -450,6 +450,7 @@ static int xgbe_get_coalesce(struct net_device *netdev,
>   	ec->rx_coalesce_usecs = pdata->rx_usecs;
>   	ec->rx_max_coalesced_frames = pdata->rx_frames;
>   
> +	ec->tx_coalesce_usecs = pdata->tx_usecs;
>   	ec->tx_max_coalesced_frames = pdata->tx_frames;
>   
>   	return 0;
> @@ -463,7 +464,7 @@ static int xgbe_set_coalesce(struct net_device *netdev,
>   	struct xgbe_prv_data *pdata = netdev_priv(netdev);
>   	struct xgbe_hw_if *hw_if = &pdata->hw_if;
>   	unsigned int rx_frames, rx_riwt, rx_usecs;
> -	unsigned int tx_frames;
> +	unsigned int tx_frames, tx_usecs;
>   
>   	rx_riwt = hw_if->usec_to_riwt(pdata, ec->rx_coalesce_usecs);
>   	rx_usecs = ec->rx_coalesce_usecs;
> @@ -485,9 +486,22 @@ static int xgbe_set_coalesce(struct net_device *netdev,
>   		return -EINVAL;
>   	}
>   
> +	tx_usecs = ec->tx_coalesce_usecs;
>   	tx_frames = ec->tx_max_coalesced_frames;
>   
> +	/* Check if both tx_usecs and tx_frames are set to 0 simultaneously */
> +	if (!tx_usecs && !tx_frames) {
> +		netdev_err(netdev,
> +			   "tx_usecs and tx_frames must not be 0 together\n");
> +		return -EINVAL;
> +	}
> +
>   	/* Check the bounds of values for Tx */
> +	if (tx_usecs > XGMAC_MAX_COAL_TX_TICK) {
> +		netdev_err(netdev, "tx-usecs is limited to %d usec\n",
> +			   XGMAC_MAX_COAL_TX_TICK);
> +		return -EINVAL;
> +	}
>   	if (tx_frames > pdata->tx_desc_count) {
>   		netdev_err(netdev, "tx-frames is limited to %d frames\n",
>   			   pdata->tx_desc_count);
> @@ -499,6 +513,7 @@ static int xgbe_set_coalesce(struct net_device *netdev,
>   	pdata->rx_frames = rx_frames;
>   	hw_if->config_rx_coalesce(pdata);
>   
> +	pdata->tx_usecs = tx_usecs;
>   	pdata->tx_frames = tx_frames;
>   	hw_if->config_tx_coalesce(pdata);
>

I'm not quite sure, but it looks like it never works. config_tx_coalesce()
callback equals to xgbe_config_tx_coalesce() which is implemented as:

static int xgbe_config_tx_coalesce(struct xgbe_prv_data *pdata)
{
         return 0;
}

How is it expected to change anything from HW side?

> @@ -830,7 +845,7 @@ static int xgbe_set_channels(struct net_device *netdev,
>   }
>   
>   static const struct ethtool_ops xgbe_ethtool_ops = {
> -	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS |
> +	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
>   				     ETHTOOL_COALESCE_MAX_FRAMES,
>   	.get_drvinfo = xgbe_get_drvinfo,
>   	.get_msglevel = xgbe_get_msglevel,
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
> index 42fa4f84ff01..e330ae9ea685 100755
> --- a/drivers/net/ethernet/amd/xgbe/xgbe.h
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
> @@ -272,6 +272,7 @@
>   /* Default coalescing parameters */
>   #define XGMAC_INIT_DMA_TX_USECS		1000
>   #define XGMAC_INIT_DMA_TX_FRAMES	25
> +#define XGMAC_MAX_COAL_TX_TICK		100000
>   
>   #define XGMAC_MAX_DMA_RIWT		0xff
>   #define XGMAC_INIT_DMA_RX_USECS		30


