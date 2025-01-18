Return-Path: <netdev+bounces-159565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5BDA15D74
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 15:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8E3166A9F
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 14:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D47C18DF73;
	Sat, 18 Jan 2025 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9thiuN4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614B52B9A8;
	Sat, 18 Jan 2025 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737211796; cv=none; b=pgHOkMWbVASbRvbg6nwMZftGILNcW+Zt6RobbU8+y/46y3hhZolhwueSaxiyLE+Fp2qn0yYK4d1EhhmjHGyK29DHRRvc3CyGKZ/TLDkqxPVpWO0vhWu6WrURR6i3fDF1+eMSpSFcxqeQayP9amwvjmMLN2/XtorMfIzpiN8Jx4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737211796; c=relaxed/simple;
	bh=bVqmhetk8a5Vw9VMxllSyWuAl6BxluH53gM4ZLadOCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7wtcJ88DW29QsYODJEn4gaUreJhDFmKNbmvxkbeVqYXIRCCXtZ47oKr2I5M1x5sHtNGNUrfSeLfVW9LzLKOV7R6bE5nWQvb66uGB0oKgOziHuUS+nCTQU59M/IMsYn52hglUDFIGSAh9ljJMzRWZEzc+TKZTaEG7YSfJTqU4t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9thiuN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250CFC4CED1;
	Sat, 18 Jan 2025 14:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737211795;
	bh=bVqmhetk8a5Vw9VMxllSyWuAl6BxluH53gM4ZLadOCk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q9thiuN4l+A5TxN2DajKUdAuhN/NsQHdy+bi6E/BEmXeM9Ixo0P/TK4SFp2SbMsXY
	 oT9lqjwfp+OOQ6n8fVuehyPNeRIrD8kjvJjKT3oo+iiC01bV+mlv9BbNGYAFOAVA43
	 y184/oyBS4C/XHdZtEfitMJlL/0GFm6W9vJez6omQNSJ7CMFXtNiH2ndboQldwZx9R
	 EIQ/MTfnMplO6tv8Lj/ItuboAltPS/TOLlTr1RvX6J/nmiogQZ0jE37Z1RBrcrYDzF
	 6WyNwdnD9gQtmWq1vASb2EwOAnu5h4IPkoqGLSlhpl7IFjcZavqsljqFxjeqleTmLU
	 8YrgYEbhOta0w==
Message-ID: <70a4df53-c780-40ca-9415-566fdd3c9a98@kernel.org>
Date: Sat, 18 Jan 2025 16:49:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ethernet: ti: am65-cpsw: fix freeing IRQ in
 am65_cpsw_nuss_remove_tx_chns()
To: Jacob Keller <jacob.e.keller@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: srk@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>
References: <20250116-am65-cpsw-fix-tx-irq-free-v2-1-ada49409a45f@kernel.org>
 <2d6de2f0-09a7-4d1a-9288-6a9786256b12@intel.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <2d6de2f0-09a7-4d1a-9288-6a9786256b12@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18/01/2025 02:40, Jacob Keller wrote:
> 
> 
> On 1/16/2025 5:54 AM, Roger Quadros wrote:
>> When getting the IRQ we use k3_udma_glue_tx_get_irq() which returns
>> negative error value on error. So not NULL check is not sufficient
>> to deteremine if IRQ is valid. Check that IRQ is greater then zero
>> to ensure it is valid.
>>
> 
> Using the phrase "NULL check" is a bit odd since the value returned
> isn't a pointer. It is correct that checking for 0 is not sufficient
> since it could be a negative error value. Given that IRQ numbers are
> typically considered like an opaque object, perhaps thinking in terms of
> pointers and NULL is common place. Either way, its not worth re-rolling
> for a minor phrasing change like this.

I agree with your view.

> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks!

> 
>> There is no issue at probe time but at runtime user can invoke
>> .set_channels which results in the following call chain.
>> am65_cpsw_set_channels()
>>  am65_cpsw_nuss_update_tx_rx_chns()
>>   am65_cpsw_nuss_remove_tx_chns()
>>   am65_cpsw_nuss_init_tx_chns()
>>
>> At this point if am65_cpsw_nuss_init_tx_chns() fails due to
>> k3_udma_glue_tx_get_irq() then tx_chn->irq will be set to a
>> negative value.
>>
>> Then, at subsequent .set_channels with higher channel count we
>> will attempt to free an invalid IRQ in am65_cpsw_nuss_remove_tx_chns()
>> leading to a kernel warning.
>>
>> The issue is present in the original commit that introduced this driver,
>> although there, am65_cpsw_nuss_update_tx_rx_chns() existed as
>> am65_cpsw_nuss_update_tx_chns().
>>
>> Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> Reviewed-by: Simon Horman <horms@kernel.org>
>> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>> Changes in v2:
>> - Fixed typo in commit log k3_udma_glue_rx_get_irq->k3_udma_glue_tx_get_irq
>> - Added more details to commit log
>> - Added Reviewed-by tags
>> - Link to v1: https://lore.kernel.org/r/20250114-am65-cpsw-fix-tx-irq-free-v1-1-b2069e6ed185@kernel.org
>> ---
>>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> index 5465bf872734..e1de45fb18ae 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> @@ -2248,7 +2248,7 @@ static void am65_cpsw_nuss_remove_tx_chns(struct am65_cpsw_common *common)
>>  	for (i = 0; i < common->tx_ch_num; i++) {
>>  		struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];
>>  
>> -		if (tx_chn->irq)
>> +		if (tx_chn->irq > 0)
>>  			devm_free_irq(dev, tx_chn->irq, tx_chn);
>>  
>>  		netif_napi_del(&tx_chn->napi_tx);
>>
>> ---
>> base-commit: 5bc55a333a2f7316b58edc7573e8e893f7acb532
>> change-id: 20250114-am65-cpsw-fix-tx-irq-free-846ac55ee6e1
>>
>> Best regards,
> 

-- 
cheers,
-roger


