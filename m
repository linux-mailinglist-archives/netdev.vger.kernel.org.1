Return-Path: <netdev+bounces-144393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7449C6F01
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 13:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FD85B2D1D0
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 12:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CC11FF7B6;
	Wed, 13 Nov 2024 12:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6uQKSE+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468B41FCF73;
	Wed, 13 Nov 2024 12:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731500364; cv=none; b=Vtou7HCC/zRX9zmzb52mMy7AOYMKLMw7Z+Uo0b24nKJX4le7MS2yDuqfe6OXYfIX/eEgDF/Bg8eZFQsVyIKf3bXODAiSGL3WIxDvccNHNZOAxOrEkdv1WyiUkNs5EXrzfpL07oDAHGeaEn7htb04lMWp4W6tOBPzFLf5qA0S7O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731500364; c=relaxed/simple;
	bh=MRfrMS2NSXnwvk0Sf7GaU1O/RZZoM1ZJQOA8Qn8wyr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIuwwGeqEY/Y4a4Oc30trrHOaE5l1LAONTG596at6TzuaSdw6zd+hB45SjubfxUyOBzGTrUcnNNGEnusyyYxq+w/HdwqhaZxetC4qElC5+Fmi6hxMoWRS8z2TEK1OoIal8mgAsx/uRr6diXAYzP/LnyGoPCImzqqKc3IgyQhWIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6uQKSE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195F3C4CECD;
	Wed, 13 Nov 2024 12:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731500363;
	bh=MRfrMS2NSXnwvk0Sf7GaU1O/RZZoM1ZJQOA8Qn8wyr8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c6uQKSE+Z8mVuqF3X2BreB9nkrA++x9ggOBttAbYhtUrRuA2+XptAHGTOCXyuBqQx
	 RU9Bq2baf/NZ3gDA/OkAOflg3+RNv+GiTWLZn3FGWRtATVARpmhL5fWjr5exTvgtNb
	 M3QKmQiH60HK+TRUqjR2kj+7mGwM8qdGFmE7gcVGRClz1O1wBLlrMKU0xZBxUDSRY4
	 Ap/bVjhmf6rqG0NasSnosbsJs/qL2UGqNwgmvNsp6+To9y+AlMFvQNBj5u5D210RAr
	 NWoWOVm7CSZYGhogLH2tKBUVkKCZluF4qGb56xaGI9h06zw9l9gyGnHVfaF7K0XWlP
	 g0fAdRyO0YlWQ==
Message-ID: <5e54aa43-8299-4166-8724-ebe48a9a9747@kernel.org>
Date: Wed, 13 Nov 2024 13:19:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] samples: pktgen: correct dev to DEV
To: Wei Fang <wei.fang@nxp.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "lorenzo@kernel.org" <lorenzo@kernel.org>
References: <20241112030347.1849335-1-wei.fang@nxp.com>
 <0cde0236-c539-487d-a212-b660331d3683@kernel.org>
 <PAXPR04MB8510E9AF9E925D93C851E8A8885A2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <PAXPR04MB8510E9AF9E925D93C851E8A8885A2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/11/2024 11.06, Wei Fang wrote:
>> On 12/11/2024 04.03, Wei Fang wrote:
>>> In the pktgen_sample01_simple.sh script, the device variable is
>>> uppercase 'DEV' instead of lowercase 'dev'. Because of this typo, the
>>> script cannot enable UDP tx checksum.
>>>
>>> Fixes: 460a9aa23de6 ("samples: pktgen: add UDP tx checksum support")
>>> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>>> ---
>>>    samples/pktgen/pktgen_sample01_simple.sh | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/samples/pktgen/pktgen_sample01_simple.sh
>>> b/samples/pktgen/pktgen_sample01_simple.sh
>>> index cdb9f497f87d..66cb707479e6 100755
>>> --- a/samples/pktgen/pktgen_sample01_simple.sh
>>> +++ b/samples/pktgen/pktgen_sample01_simple.sh
>>
>> Why are you only fixing one script?
>>
> 
> Other scripts are correct, because they are all multi-threaded, "dev" is
> defined for each thread like below.
> 
> dev=${DEV}@${thread}
> 

Good point! - then this patch is enough :-)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

Thanks for fixing this,
--Jesper

