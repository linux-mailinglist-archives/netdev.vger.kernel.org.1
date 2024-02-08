Return-Path: <netdev+bounces-70279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7291484E3B3
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 16:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A201C23107
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16237AE53;
	Thu,  8 Feb 2024 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JdObgyMB"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302FD1E4BF
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707404863; cv=none; b=erf2v+SARCsDj1cApG6w/2Hlsrv/sc8G1DQ5nx6hBcUFRMsLQGESenho5XnbAIVpbKmGV6AQntrCszO5ysjR+J6KCE0InRxUEvgTuAKhEHToF/QmBzJBWMc3Y0/oGQrN0r4YpqB7UIGn6Y6wFDP5oNO2a6JRbqGcDSIoi1K6BEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707404863; c=relaxed/simple;
	bh=vwlIGebp9eqQ5DRFfzrUQ8c5/g9Lkk77ZHifsoM1IQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lQlgFpcp251mo+rq5Gw23ktFwvsm3dvY4p7uGvFgUXETvzY5IGQLBjCT0MTZEsRWk0ei32ZMC04v2sA+jjYykUc8Be88SGfnn9OzCeQUoT2TLqkslKzs6Qa+JP8EhtOFWFdSTUcimXGHBzUU6bsFjYeDtdkWbDjS9Et58EY1V/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JdObgyMB; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1b4f32d0-a203-4c97-94e1-93ec40364c3c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707404859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MEXn0Pkjye0UsAfRWO1sP+a/rfWIwp8KQzaA582+tKs=;
	b=JdObgyMBJvjT6YNZYxdVFzbfirnDaqCbzaCYACuKKdJXHvDtwUzzgAVpsB2VUbZxr5Ad5x
	LOYOZRwyQ6hw+bKNyiizEBKDwp4Bt1mZfb2k5ZnnFw3+jFH66j6QFkfkcb5Owbsz+sXeZa
	iuzK4/abkW25LW6wQNM+9Cxy5SHXFUk=
Date: Thu, 8 Feb 2024 10:07:27 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH][next] drivers: net: xgene: remove redundant assignment to
 variable offset
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Colin Ian King <colin.i.king@gmail.com>,
 Iyappan Subramanian <iyappan@os.amperecomputing.com>,
 Keyur Chudgar <keyur@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240208122012.2597561-1-colin.i.king@gmail.com>
 <f39d8e56-9ac1-42b4-bb2c-1bc97a0f43b3@linux.dev>
 <4e0d27a6-37be-4b6e-a60e-508bcb0884cb@moroto.mountain>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <4e0d27a6-37be-4b6e-a60e-508bcb0884cb@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/02/2024 13:40, Dan Carpenter wrote:
> On Thu, Feb 08, 2024 at 12:39:24PM +0000, Vadim Fedorenko wrote:
>> On 08.02.2024 12:20, Colin Ian King wrote:
>>> The variable offset is being initialized with a value that is never
>>> read, it is being re-assigned later on in either path of an if
>>> statement before being used. The initialization is redundant and
>>> can be removed.
>>>
>>> Cleans up clang scan build warning:
>>> drivers/net/ethernet/apm/xgene/xgene_enet_cle.c:736:2: warning: Value
>>> stored to 'offset' is never read [deadcode.DeadStores]
>>>
>>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>>> ---
>>>    drivers/net/ethernet/apm/xgene/xgene_enet_cle.c | 1 -
>>>    1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_cle.c b/drivers/net/ethernet/apm/xgene/xgene_enet_cle.c
>>> index de5464322311..8f104642897b 100644
>>> --- a/drivers/net/ethernet/apm/xgene/xgene_enet_cle.c
>>> +++ b/drivers/net/ethernet/apm/xgene/xgene_enet_cle.c
>>> @@ -733,7 +733,6 @@ static int xgene_cle_setup_rss(struct xgene_enet_pdata *pdata)
>>>    	u32 offset, val = 0;
>>>    	int i, ret = 0;
>>> -	offset = CLE_PORT_OFFSET;
>>>    	for (i = 0; i < cle->parsers; i++) {
>>>    		if (cle->active_parser != PARSER_ALL)
>>>    			offset = cle->active_parser * CLE_PORT_OFFSET;
>>
>> It looks like more refactoring can be done here.
>> "if (cle->active_parser != PARSER_ALL)" is static, no need to check it inside
>> the loop.
>>
> 
> You still need to check...  I don't really think it's an improvement.
> 
> regards,
> dan carpenter
> 
> diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_cle.c b/drivers/net/ethernet/apm/xgene/xgene_enet_cle.c
> index de5464322311..61e31cc55771 100644
> --- a/drivers/net/ethernet/apm/xgene/xgene_enet_cle.c
> +++ b/drivers/net/ethernet/apm/xgene/xgene_enet_cle.c
> @@ -733,11 +733,11 @@ static int xgene_cle_setup_rss(struct xgene_enet_pdata *pdata)
>   	u32 offset, val = 0;
>   	int i, ret = 0;
>   
> -	offset = CLE_PORT_OFFSET;
> +	if (cle->active_parser != PARSER_ALL)
> +		offset = cle->active_parser * CLE_PORT_OFFSET;
> +

I think we can add "else" here and avoid the loop in case of != 
PARSER_ALL and avoid "if" in the loop, wdyt?

>   	for (i = 0; i < cle->parsers; i++) {
> -		if (cle->active_parser != PARSER_ALL)
> -			offset = cle->active_parser * CLE_PORT_OFFSET;
> -		else
> +		if (cle->active_parser == PARSER_ALL)
>   			offset = i * CLE_PORT_OFFSET;
>   
>   		/* enable RSS */


