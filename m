Return-Path: <netdev+bounces-158559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540A9A127D3
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 16:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693C9167111
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B6014B077;
	Wed, 15 Jan 2025 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bw7fG8P5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A1F13DB9F;
	Wed, 15 Jan 2025 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736956190; cv=none; b=RhlXThjr8U0L6w2jqZTN1I7DX6VNj7ZRMcXI5h9nKNKDrYqB3iiZvYuo+hBzR4rne8tXPM/nd9dvHZLvA60nzLWSH1VVxMPZGoRsCd4wlia5UiJ8m6p4nZy+a4u2eqfTC9Onfjk642AazRUVeB3wCYifSMIPm22Zh426CCxztwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736956190; c=relaxed/simple;
	bh=o8oTdXfpXYvKbpxgFeYHTBSgRC8ggH1Ckg7IIEgckBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CS7RPLsjO9e+dTRQWZH4RD2k3don9Znt/lBJv90Lxz7Kf6fVr8ZGqpaeC4DMBgM9tAEO3PsvZ/fnR9K+Bm44DKcA0MtxYxQBjGNYGwPvOkPjpuEGPklBwMhjCDl/aIPRqoOGy/l1zswEJoeU74/Q+dlNgxGYION2y3QhJ6tBK1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bw7fG8P5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3FAC4CED1;
	Wed, 15 Jan 2025 15:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736956190;
	bh=o8oTdXfpXYvKbpxgFeYHTBSgRC8ggH1Ckg7IIEgckBU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bw7fG8P5B2Mva+mwJtbpOiNImjI2SkLIMgsfSuxQk1av+wC3zU0v3QuvHJWYg4NJS
	 SkrmJ9TlIrLLquMfoluAzOOTWFDJX6MK9xAr/l2vXfFwBPBu71H/lmsFmpifoIqhd5
	 FeFKNuY9mA0sIngGadxRP+F//aPQWnX/u9Iyqul6K7XuhAZ8BujqoAM6CYgIuXDEdg
	 8s5j0Q0oifrIIfEep7YulpjyCVF9rGouEILVgmMBO5n0Jc5w8uIdr51YvG/5q56TX2
	 X6grTHakXiYEu8sbwmk4yjR7W9/yzHSl3Di6LHGcDRBk00wmpp3C9ZnYFam6fqI3h9
	 KjBVMrJnbI8nA==
Message-ID: <3c9bdd38-d60f-466d-a767-63f71368d41e@kernel.org>
Date: Wed, 15 Jan 2025 17:49:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw: fix freeing IRQ in
 am65_cpsw_nuss_remove_tx_chns()
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>, srk@ti.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250114-am65-cpsw-fix-tx-irq-free-v1-1-b2069e6ed185@kernel.org>
 <gygqjjyso3p4qgam4fpjdkqidj2lhxldkmaopqg32bw3g4ktpj@43tmtsdexkqv>
 <8776a109-22c3-4c1e-a6a1-7bb0a4c70b06@kernel.org>
 <m4rhkzcr7dlylxr54udyt6lal5s2q4krrvmyay6gzgzhcu4q2c@r34snfumzqxy>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <m4rhkzcr7dlylxr54udyt6lal5s2q4krrvmyay6gzgzhcu4q2c@r34snfumzqxy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Siddharth,

On 15/01/2025 12:38, Siddharth Vadapalli wrote:
> On Wed, Jan 15, 2025 at 12:04:17PM +0200, Roger Quadros wrote:
>> Hi Siddharth,
>>
>> On 15/01/2025 07:18, Siddharth Vadapalli wrote:
>>> On Tue, Jan 14, 2025 at 06:44:02PM +0200, Roger Quadros wrote:
>>>
>>> Hello Roger,
>>>
>>>> When getting the IRQ we use k3_udma_glue_rx_get_irq() which returns
>>>
>>> You probably meant "k3_udma_glue_tx_get_irq()" instead? It is used to
>>> assign tx_chn->irq within am65_cpsw_nuss_init_tx_chns() as follows:
>>
>> Yes I meant tx instead of rx.
>>
>>>
>>> 		tx_chn->irq = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);
>>>
>>> Additionally, following the above section we have:
>>>
>>> 		if (tx_chn->irq < 0) {
>>> 			dev_err(dev, "Failed to get tx dma irq %d\n",
>>> 				tx_chn->irq);
>>> 			ret = tx_chn->irq;
>>> 			goto err;
>>> 		}
>>>
>>> Could you please provide details on the code-path which will lead to a
>>> negative "tx_chn->irq" within "am65_cpsw_nuss_remove_tx_chns()"?
>>>
>>> There seem to be two callers of am65_cpsw_nuss_remove_tx_chns(), namely:
>>> 1. am65_cpsw_nuss_update_tx_rx_chns()
>>> 2. am65_cpsw_nuss_suspend()
>>> Since both of them seem to invoke am65_cpsw_nuss_remove_tx_chns() only
>>> in the case where am65_cpsw_nuss_init_tx_chns() *did not* error out, it
>>> appears to me that "tx_chn->irq" will never be negative within
>>> am65_cpsw_nuss_remove_tx_chns()
>>>
>>> Please let me know if I have overlooked something.
>>
>> The issue is with am65_cpsw_nuss_update_tx_rx_chns(). It can be called
>> repeatedly (by user changing number of TX queues) even if previous call
>> to am65_cpsw_nuss_init_tx_chns() failed.
> 
> Thank you for clarifying. So the issue/bug was discovered since the
> implementation of am65_cpsw_nuss_update_tx_rx_chns(). The "Fixes" tag
> misled me. Maybe the "Fixes" tag should be updated? Though we should
> code to future-proof it as done in this patch, the "Fixes" tag pointing
> to the very first commit of the driver might not be accurate as the
> code-path associated with the bug cannot be exercised at that commit.

Fair enough. I'll change the Fixes commit.

> 
> Independent of the above change suggested for the "Fixes" tag,
> 
> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> There seems to be a different bug in am65_cpsw_nuss_update_tx_rx_chns()
> which I have described below.
> 
>>
>> Please try the below patch to simulate the error condition.
>>
>> Then do the following
>> - bring down all network interfaces
>> - change num TX queues to 2. IRQ for 2nd channel fails.
>> - change num TX queues to 3. Now we try to free an invalid IRQ and we see warning.
>>
>> Also I think it is good practice to code for set value than to code
>> for existing code paths as they can change in the future.
>>
>> --test patch starts--
>>
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> index 36c29d3db329..c22cadaaf3d3 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> @@ -155,7 +155,7 @@
>>  			 NETIF_MSG_IFUP	| NETIF_MSG_PROBE | NETIF_MSG_IFDOWN | \
>>  			 NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
>>  
>> -#define AM65_CPSW_DEFAULT_TX_CHNS	8
>> +#define AM65_CPSW_DEFAULT_TX_CHNS	1
>>  #define AM65_CPSW_DEFAULT_RX_CHN_FLOWS	1
>>  
>>  /* CPPI streaming packet interface */
>> @@ -2346,7 +2348,10 @@ static int am65_cpsw_nuss_init_tx_chns(struct am65_cpsw_common *common)
>>  		tx_chn->dsize_log2 = __fls(hdesc_size_out);
>>  		WARN_ON(hdesc_size_out != (1 << tx_chn->dsize_log2));
>>  
>> -		tx_chn->irq = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);
>> +		if (i == 1)
>> +			tx_chn->irq = -ENODEV;
>> +		else
>> +			tx_chn->irq = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);
> 
> The pair - am65_cpsw_nuss_init_tx_chns()/am65_cpsw_nuss_remove_tx_chns()
> seem to be written under the assumption that failure will result in the
> driver's probe failing.
> 
> With am65_cpsw_nuss_update_tx_rx_chns(), that assumption no longer holds
> true. Please consider the following sequence:
> 
> 1.
> am65_cpsw_nuss_probe()
>   am65_cpsw_nuss_register_ndevs()
>     am65_cpsw_nuss_init_tx_chns() => Succeeds
> 
> 2.
> Probe is successful
> 
> 3.
> am65_cpsw_nuss_update_tx_rx_chns() => Invoked by user
>   am65_cpsw_nuss_remove_tx_chns() => Succeeds
>     am65_cpsw_nuss_init_tx_chns() => Partially fails
>       devm_add_action(dev, am65_cpsw_nuss_free_tx_chns, common);
>       ^ DEVM Action is added, but since the driver isn't removed,
>       the cleanup via am65_cpsw_nuss_free_tx_chns() will not run.
> 
> Only when the user re-invokes am65_cpsw_nuss_update_tx_rx_chns(),
> the cleanup will be performed. This might have to be fixed in the
> following manner:
> 
> @@ -3416,10 +3416,17 @@ int am65_cpsw_nuss_update_tx_rx_chns(struct am65_cpsw_common *common,
>         common->tx_ch_num = num_tx;
>         common->rx_ch_num_flows = num_rx;
>         ret = am65_cpsw_nuss_init_tx_chns(common);
> -       if (ret)
> +       if (ret) {
> +               devm_remove_action(dev, am65_cpsw_nuss_free_tx_chns, common);
> +               am65_cpsw_nuss_free_tx_chns(common);
>                 return ret;
> +       }
> 
>         ret = am65_cpsw_nuss_init_rx_chns(common);
> +       if (ret) {
> +               devm_remove_action(dev, am65_cpsw_nuss_free_rx_chns, common);
> +               am65_cpsw_nuss_free_rx_chns(common);
> +       }
> 
>         return ret;
>  }
> 
>  Please let me know what you think.

I've already implemented a cleanup series to get rid of devm_add/remove_action,
cleanup probe error path and streamline TX and RQ queue init/cleanup.
I'll send out the series soon as soon as I finish some tests.

-- 
cheers,
-roger


