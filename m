Return-Path: <netdev+bounces-208458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41C7B0B859
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 23:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9585D171977
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 21:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720BA1DED52;
	Sun, 20 Jul 2025 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jWPYcm8S"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA61A3150
	for <netdev@vger.kernel.org>; Sun, 20 Jul 2025 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753047357; cv=none; b=B69IJLn1KXYn3SZwXgWnthN7T5CDbcPAL4uYcdG5lrj5YRLEiSSLY/GcjFW0riwMl7a9AUFaBy9zY4miy9OIOARrBD4nuEzqytguX2Iroz/EwGMWogGfzYIF8uaPUE6D1qni7UkV5he6H4q/yqNJGFcQ0A0bJiaajw0hHS15Jek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753047357; c=relaxed/simple;
	bh=b4Z74NuZYX02vUEEbDNIZ6r046XXi26X/l8LNz8RVaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IALdhN4nUOzvmEaxk9K/Rh9a9uFSUQgbrAixWfoGOogws/zTJq1IasAnpqIv6LJb/69i0O8mUeIPk/U9iV6RvYsz2sUEnZckZFYgJ60ZyVOP0Hk4HfSuTpw0IJFRTMcSKiLZXDmlGpT2lX8qaNYRt3BIohjxPUNZ6ympRA8OzOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jWPYcm8S; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f5e40d58-c956-4ade-9de8-f88c834772f1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753047351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yv081/txZuysT+wxl5AYc5FYJLhLSpKXz8nW3yIQPSA=;
	b=jWPYcm8Slye/lYknIlX7JFTMaT+kYK12dyKq3PF+UpBroRnHPxLJGqdaCXG/KadGOBUCQR
	bo56ivB/JavT3l3kmRKAZcIpE0rnWBeFwR285kCjJjR0vSBtPQ9nUiAXf2tLV0AG/uh7AM
	pMs48w/nOSPhSNpOE+HSy28p5No4kBE=
Date: Sun, 20 Jul 2025 22:35:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RESEND PATCH net-next] amd-xgbe: Configure and retrieve
 'tx-usecs' for Tx coalescing
To: "Badole, Vishal" <vishal.badole@amd.com>, Shyam-sundar.S-k@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250719072608.4048494-1-Vishal.Badole@amd.com>
 <509add4e-5dff-4f30-b96b-488919fedb77@linux.dev>
 <e2ee64c4-4923-4691-bcfd-df9222f2c30b@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <e2ee64c4-4923-4691-bcfd-df9222f2c30b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 20.07.2025 19:28, Badole, Vishal wrote:
> 
> 
> On 7/19/2025 8:46 PM, Vadim Fedorenko wrote:
>> On 19.07.2025 08:26, Vishal Badole wrote:
>>> Ethtool has advanced with additional configurable options, but the
>>> current driver does not support tx-usecs configuration.
>>>
>>> Add support to configure and retrieve 'tx-usecs' using ethtool, which
>>> specifies the wait time before servicing an interrupt for Tx coalescing.
>>>
>>> Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
>>> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>>> ---
>>>   drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 19 +++++++++++++++++--
>>>   drivers/net/ethernet/amd/xgbe/xgbe.h         |  1 +
>>>   2 files changed, 18 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/ net/ 
>>> ethernet/amd/xgbe/xgbe-ethtool.c
>>> index 12395428ffe1..362f8623433a 100644
>>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
>>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
>>> @@ -450,6 +450,7 @@ static int xgbe_get_coalesce(struct net_device *netdev,
>>>       ec->rx_coalesce_usecs = pdata->rx_usecs;
>>>       ec->rx_max_coalesced_frames = pdata->rx_frames;
>>> +    ec->tx_coalesce_usecs = pdata->tx_usecs;
>>>       ec->tx_max_coalesced_frames = pdata->tx_frames;
>>>       return 0;
>>> @@ -463,7 +464,7 @@ static int xgbe_set_coalesce(struct net_device *netdev,
>>>       struct xgbe_prv_data *pdata = netdev_priv(netdev);
>>>       struct xgbe_hw_if *hw_if = &pdata->hw_if;
>>>       unsigned int rx_frames, rx_riwt, rx_usecs;
>>> -    unsigned int tx_frames;
>>> +    unsigned int tx_frames, tx_usecs;
>>>       rx_riwt = hw_if->usec_to_riwt(pdata, ec->rx_coalesce_usecs);
>>>       rx_usecs = ec->rx_coalesce_usecs;
>>> @@ -485,9 +486,22 @@ static int xgbe_set_coalesce(struct net_device *netdev,
>>>           return -EINVAL;
>>>       }
>>> +    tx_usecs = ec->tx_coalesce_usecs;
>>>       tx_frames = ec->tx_max_coalesced_frames;
>>> +    /* Check if both tx_usecs and tx_frames are set to 0 simultaneously */
>>> +    if (!tx_usecs && !tx_frames) {
>>> +        netdev_err(netdev,
>>> +               "tx_usecs and tx_frames must not be 0 together\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>>       /* Check the bounds of values for Tx */
>>> +    if (tx_usecs > XGMAC_MAX_COAL_TX_TICK) {
>>> +        netdev_err(netdev, "tx-usecs is limited to %d usec\n",
>>> +               XGMAC_MAX_COAL_TX_TICK);
>>> +        return -EINVAL;
>>> +    }
>>>       if (tx_frames > pdata->tx_desc_count) {
>>>           netdev_err(netdev, "tx-frames is limited to %d frames\n",
>>>                  pdata->tx_desc_count);
>>> @@ -499,6 +513,7 @@ static int xgbe_set_coalesce(struct net_device *netdev,
>>>       pdata->rx_frames = rx_frames;
>>>       hw_if->config_rx_coalesce(pdata);
>>> +    pdata->tx_usecs = tx_usecs;
>>>       pdata->tx_frames = tx_frames;
>>>       hw_if->config_tx_coalesce(pdata);
>>>
>>
>> I'm not quite sure, but it looks like it never works. config_tx_coalesce()
>> callback equals to xgbe_config_tx_coalesce() which is implemented as:
>>
>> static int xgbe_config_tx_coalesce(struct xgbe_prv_data *pdata)
>> {
>>          return 0;
>> }
>>
>> How is it expected to change anything from HW side?
>>
> 
> The code analysis reveals that pdata, a pointer to xgbe_prv_data, is obtained 
> via netdev_priv(netdev). The tx_usecs member of the xgbe_prv_data structure is 
> then updated with the user-specified value through this pdata pointer. This 
> updated tx_usecs value propagates throughout the codebase wherever TX coalescing 
> functionality is referenced.
> 
> We have validated this behavior through log analysis and transmission 
> timestamps, confirming the parameter updates are taking effect.
> 
> Since this is a legacy driver implementation where xgbe_config_tx_coalesce() 
> currently lacks actual hardware configuration logic for TX coalescing 
> parameters, we plan to modernize the xgbe driver and eliminate redundant code 
> segments in future releases.

Effectively, when the user asks for the coalescing configuration, the driver 
reports values which are not really HW-configured values. At the same time
driver reports correct configuration even though the configuration is not
actually supported by the driver and it doesn't configure HW. This sounds odd.

Why didn't you start with the actual implementation instead of doing this
useless copying of values?


> 
>>> @@ -830,7 +845,7 @@ static int xgbe_set_channels(struct net_device *netdev,
>>>   }
>>>   static const struct ethtool_ops xgbe_ethtool_ops = {
>>> -    .supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS |
>>> +    .supported_coalesce_params = ETHTOOL_COALESCE_USECS |
>>>                        ETHTOOL_COALESCE_MAX_FRAMES,
>>>       .get_drvinfo = xgbe_get_drvinfo,
>>>       .get_msglevel = xgbe_get_msglevel,
>>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ ethernet/ 
>>> amd/xgbe/xgbe.h
>>> index 42fa4f84ff01..e330ae9ea685 100755
>>> --- a/drivers/net/ethernet/amd/xgbe/xgbe.h
>>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
>>> @@ -272,6 +272,7 @@
>>>   /* Default coalescing parameters */
>>>   #define XGMAC_INIT_DMA_TX_USECS        1000
>>>   #define XGMAC_INIT_DMA_TX_FRAMES    25
>>> +#define XGMAC_MAX_COAL_TX_TICK        100000
>>>   #define XGMAC_MAX_DMA_RIWT        0xff
>>>   #define XGMAC_INIT_DMA_RX_USECS        30
>>
> 


