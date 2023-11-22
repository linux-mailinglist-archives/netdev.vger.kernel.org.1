Return-Path: <netdev+bounces-50163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDB17F4BFE
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5269F1C20849
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2113C1CA8A;
	Wed, 22 Nov 2023 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kp5ur3uK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0666D5789A
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 16:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16C8C433C8;
	Wed, 22 Nov 2023 16:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700669397;
	bh=WgEbQUzljkmPx9DNy1w2RWPaZfvYuaXNx5g4RVFyMtk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Kp5ur3uKxSf37FoYnrEEEGsdX4saYIEAR4/CyVrxzt38B8+8fwVwl+gqZ8Ui9yp6D
	 vXwfKPfMA3JfPvAgR0G2DMfCT1bnA+WXJDkrgQURx7PE1obqbGj+9cfUG2hn86xVPP
	 r4CRHPdBS8CBkiJa/+kopWBPZkZguWRA4ljElV7Vs2JTgX2JyfORZY5EmLmkkfIuna
	 /ZfMpywqobRj7U+r4I4qyi5jVlqDNIdUaURQI55sZCmn+5SRU5glFwJxgay/TdQWuM
	 XlCgzWke1B8zq7WHAGFEUEaelD0ta4jOWqmwpX0HuSNBmfEMV7fLyWRQQXcsvziJfd
	 1A80rGI0zNl3g==
Message-ID: <73042de6-7e51-4c08-a1c2-b0a0a301ba2e@kernel.org>
Date: Wed, 22 Nov 2023 17:09:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 09/13] net: page_pool: report amount of memory
 held by page pools
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, almasrymina@google.com, ilias.apalodimas@linaro.org,
 dsahern@gmail.com, dtatulea@nvidia.com, willemb@google.com
References: <20231122034420.1158898-1-kuba@kernel.org>
 <20231122034420.1158898-10-kuba@kernel.org>
 <ee5c3780-2b0e-4db2-97d0-48659686c772@kernel.org>
 <20231122080613.5a168d74@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231122080613.5a168d74@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/22/23 17:06, Jakub Kicinski wrote:
> On Wed, 22 Nov 2023 16:24:55 +0100 Jesper Dangaard Brouer wrote:
>>> +      -
>>> +        name: inflight
>>> +        type: uint
>>> +        doc: |
>>> +          Number of outstanding references to this page pool (allocated
>>> +          but yet to be freed pages).
>>
>> Maybe it is worth explaining in this doc that these inflight references
>> also cover elements in (ptr) ring (and alloc-cache) ?
>>
>> In a follow up patchset, we likely also want to expose the PP ring size.
>> As that could be relevant when assessing inflight number.
> 
> Good point, how about:
> 
>            Number of outstanding references to this page pool (allocated
>            but yet to be freed pages). Allocated pages may be held in
>            socket receive queues, driver receive rings, page pool recycling
>            ring, the page pool cache, etc.

Sound good to me :-) - ACK

--Jesper

