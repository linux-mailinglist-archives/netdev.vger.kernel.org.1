Return-Path: <netdev+bounces-125564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DF496DB3E
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 16:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC7E1F28DCA
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBAD19DFB9;
	Thu,  5 Sep 2024 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="edkBSa94"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCEE19DF5B
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545399; cv=none; b=g1KPlVTIPPiz39NwcL3gJMElbwas1sWUcz2Lwh6b04IVheDazlvygFR++Mm26wzxwHBOIaNxlbvSufcdzUBm8AMgFmUZ6kePT/GkqlOLUh3b/npp1O8qfWtl3wcdLwso35IOq/tz6yRklotZyolaOgZMd/Sd/S2iNxi9XdMvki0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545399; c=relaxed/simple;
	bh=26I3CCN1xk1tflNeHygcv2g3UJ01SvA+yYFIQvJ2Ux4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/jWQ45BTkJJH9QFcbKfqew4rA6GzS5BDa7icqzYhB+a14IaoKityS+1J0X8kloqz5JfWMX0WMfZKatT5eCn7Fu6stdaA9EGHEhlGWRBc5hqejtFc3eXny5uGc6qle9hu5OLbxSq4Bj1uEnDoqDD0OGXVCpdO2tsRjyLNRbkRqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=edkBSa94; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e3cc6c1f-97f4-45f1-a909-00cf986cd465@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725545395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MW3j9iwJ2dsJQ38vKTBplOuhuzXGBXMoOjy8GycZgz0=;
	b=edkBSa94lZRP/tSBPcbC+2j5ggoI+MRWOpPEBoC8N73+RyYHYXh8XVmQTTNDawAV+p+tDY
	USJzBsLCMfplQwL4okOKEVoZ88BYRG5Gke9MSPoOtPUKh3l19Cn9u5xd+ltf6F1kXT2KE4
	YmsW+T/8ASEU++Zli5P6zjheAzPYT98=
Date: Thu, 5 Sep 2024 10:09:51 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] net: xilinx: axienet: Remove unused checksum
 variables
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "Simek, Michal" <michal.simek@amd.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240903184334.4150843-1-sean.anderson@linux.dev>
 <20240903184334.4150843-2-sean.anderson@linux.dev>
 <MN0PR12MB595303AE2C49E45A0CF435A1B79C2@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <MN0PR12MB595303AE2C49E45A0CF435A1B79C2@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/4/24 13:03, Pandey, Radhey Shyam wrote:
>> -----Original Message-----
>> From: Sean Anderson <sean.anderson@linux.dev>
>> Sent: Wednesday, September 4, 2024 12:14 AM
>> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; David S .
>> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
>> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
>> netdev@vger.kernel.org
>> Cc: Simek, Michal <michal.simek@amd.com>; linux-arm-
>> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Sean Anderson
>> <sean.anderson@linux.dev>
>> Subject: [PATCH 1/3] net: xilinx: axienet: Remove unused checksum variables
>> 
>> These variables are set but never used. Remove them
>> 
> 
> Nit - Missing "." at the end.

Will fix if I send a v2.

> Also, just curious how you found these unused vars ? 
> using some tool or in code walkthrough?

I read the code and noticed it :)

--Sean

>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> 
> Rest seems fine.
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> 
> 
>> ---
>> 
>>  drivers/net/ethernet/xilinx/xilinx_axienet.h      |  5 -----
>>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 12 ------------
>>  2 files changed, 17 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> b/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> index c301dd2ee083..b9d2d7319220 100644
>> --- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
>> @@ -527,8 +527,6 @@ struct skbuf_dma_descriptor {
>>   *		  supported, the maximum frame size would be 9k. Else it is
>>   *		  1522 bytes (assuming support for basic VLAN)
>>   * @rxmem:	Stores rx memory size for jumbo frame handling.
>> - * @csum_offload_on_tx_path:	Stores the checksum selection on TX
>> side.
>> - * @csum_offload_on_rx_path:	Stores the checksum selection on RX
>> side.
>>   * @coalesce_count_rx:	Store the irq coalesce on RX side.
>>   * @coalesce_usec_rx:	IRQ coalesce delay for RX
>>   * @coalesce_count_tx:	Store the irq coalesce on TX side.
>> @@ -606,9 +604,6 @@ struct axienet_local {
>>  	u32 max_frm_size;
>>  	u32 rxmem;
>> 
>> -	int csum_offload_on_tx_path;
>> -	int csum_offload_on_rx_path;
>> -
>>  	u32 coalesce_count_rx;
>>  	u32 coalesce_usec_rx;
>>  	u32 coalesce_count_tx;
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> index fe6a0e2e463f..60ec430f3eb0 100644
>> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> @@ -2631,38 +2631,26 @@ static int axienet_probe(struct platform_device
>> *pdev)
>>  	if (!ret) {
>>  		switch (value) {
>>  		case 1:
>> -			lp->csum_offload_on_tx_path =
>> -				XAE_FEATURE_PARTIAL_TX_CSUM;
>>  			lp->features |= XAE_FEATURE_PARTIAL_TX_CSUM;
>>  			/* Can checksum TCP/UDP over IPv4. */
>>  			ndev->features |= NETIF_F_IP_CSUM;
>>  			break;
>>  		case 2:
>> -			lp->csum_offload_on_tx_path =
>> -				XAE_FEATURE_FULL_TX_CSUM;
>>  			lp->features |= XAE_FEATURE_FULL_TX_CSUM;
>>  			/* Can checksum TCP/UDP over IPv4. */
>>  			ndev->features |= NETIF_F_IP_CSUM;
>>  			break;
>> -		default:
>> -			lp->csum_offload_on_tx_path =
>> XAE_NO_CSUM_OFFLOAD;
>>  		}
>>  	}
>>  	ret = of_property_read_u32(pdev->dev.of_node, "xlnx,rxcsum",
>> &value);
>>  	if (!ret) {
>>  		switch (value) {
>>  		case 1:
>> -			lp->csum_offload_on_rx_path =
>> -				XAE_FEATURE_PARTIAL_RX_CSUM;
>>  			lp->features |= XAE_FEATURE_PARTIAL_RX_CSUM;
>>  			break;
>>  		case 2:
>> -			lp->csum_offload_on_rx_path =
>> -				XAE_FEATURE_FULL_RX_CSUM;
>>  			lp->features |= XAE_FEATURE_FULL_RX_CSUM;
>>  			break;
>> -		default:
>> -			lp->csum_offload_on_rx_path =
>> XAE_NO_CSUM_OFFLOAD;
>>  		}
>>  	}
>>  	/* For supporting jumbo frames, the Axi Ethernet hardware must
>> have
>> --
>> 2.35.1.1320.gc452695387.dirty
> 


