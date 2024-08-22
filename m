Return-Path: <netdev+bounces-120932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754B795B3B9
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919861C21838
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007BC1C8FC9;
	Thu, 22 Aug 2024 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeDQB0G1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD64914A0B8;
	Thu, 22 Aug 2024 11:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724326054; cv=none; b=WoxVpk+VvMwdrb9bA+APbY4lwMWJXA53aGTO0ac7cTfzX5UWyRAEnUYcj3/Qb6kYHQBHExUAHDqcNMuXeNjjmY6Ckcr87d2eModVRfGwxk1vTEQPCJ/3sWAxvAFIUU11HnZNohJPnNqMNdbYs6rlX/pTMzaJwJML157p9Z0zoDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724326054; c=relaxed/simple;
	bh=JfZQE4xgNpbHgPpxuLPDhtB/4/9FxFiUKFkyPjhZbj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9kl5VgJzrEsoFWqIPA2FtZcBjF/skRPB97J4tWiZ31uufbFV7KNnaeynk5Urg+TbI0DScjkkLwaP2pTEFbyLVnUV4s/iyHQyh/fMbbsd4jlSqsIguK5nVWcSRfRjG3k+CkkDSKbJ6JG4kOias0RKd6TcGrEEXVELnXHmwqZxFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeDQB0G1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4663FC32782;
	Thu, 22 Aug 2024 11:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724326054;
	bh=JfZQE4xgNpbHgPpxuLPDhtB/4/9FxFiUKFkyPjhZbj8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OeDQB0G17NRngRY+ByffGZv7pDLtpcIpNgSRNlRod2/HoJp0uVK1Am1oGo49lnacR
	 m9TfsuO+3wgARIPO23WvGHXP7/DgAS3ntciaWkwm8BU6vWXN6OPGNHaQlPu89dk6cX
	 iRELSa+bSaZlHBDRF68LESigi7uHLsUTPIyx1l9rB4XL+GyP3MyrDsQkePtjCQe02I
	 81S1tXkaJYM3yGQUrSP1gS1XqSCdXm9DPpj91sNc6e88lrkewPytyxcc4NRkBn1Knu
	 4rG6+elJBfrRVEzq6kcudKG2suKouOdsXd+mdiMwQt1QD6efwSgRjh2y88zvMzyPEL
	 BmzVp+8ICvqZg==
Message-ID: <8ab571a7-6441-4616-b456-a0677b2520c7@kernel.org>
Date: Thu, 22 Aug 2024 14:27:27 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/7] net: ti: icssg-prueth: Enable IEP1
To: MD Danish Anwar <danishanwar@ti.com>, "Anwar, Md Danish"
 <a0501179@ti.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Andrew Lunn <andrew@lunn.ch>, Jan Kiszka <jan.kiszka@siemens.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <20240813074233.2473876-2-danishanwar@ti.com>
 <aee5b633-31ce-4db0-9014-90f877a33cf4@kernel.org>
 <9766c4f6-b687-49d6-8476-8414928a3a0e@ti.com>
 <ae36c591-3b26-44a7-98a4-a498ee507e27@kernel.org>
 <070a6aea-bebe-42c8-85be-56eb5f2f3ace@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <070a6aea-bebe-42c8-85be-56eb5f2f3ace@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22/08/2024 08:52, MD Danish Anwar wrote:
> 
> 
> On 21/08/24 5:23 pm, Roger Quadros wrote:
>>
>>
>> On 21/08/2024 14:33, Anwar, Md Danish wrote:
>>> Hi Roger,
>>>
>>> On 8/21/2024 4:57 PM, Roger Quadros wrote:
>>>> Hi,
>>>>
>>>> On 13/08/2024 10:42, MD Danish Anwar wrote:
>>>>> IEP1 is needed by firmware to enable FDB learning and FDB ageing.
>>>>
>>>> Required by which firmware?
>>>>
>>>
>>> IEP1 is needed by all ICSSG firmwares (Dual EMAC / Switch / HSR)
>>>
>>>> Does dual-emac firmware need this?
>>>>
>>>
>>> Yes, Dual EMAC firmware needs IEP1 to enabled.
>>
>> Then this need to be a bug fix?
> 
> Correct, this is in fact a bug. But IEP1 is also needed by HSR firmware
> so I thought of keeping this patch with HSR series. As HSR will be
> completely broken if IEP1 is not enabled.
> 
> I didn't want to post two patches one as bug fix to net and one part of
> HSR to net-next thus I thought of keeping this patch in this series only.

Bug fixes need to be posted earlier as they can get accepted sooner and
even back-ported to stable. You also need to add the Fixes tag.

> 
>> What is the impact if IEP1 is not enabled for dual emac.
>>
> 
> Without IEP1 enabled, Crash is seen on AM64x 10M link when connecting /
> disconnecting multiple times. On AM65x IEP1 was always enabled because

In that ase you need to enable quirk_10m_link_issue for AM64x platform.
I understand that IEP1 is not required for 100M/1G.

> `prueth->pdata.quirk_10m_link_issue` was true. FDB learning and FDB
> ageing will also get impacted if IEP1 is not enabled.

Is FDB learning and ageing involved in dual Emac mode?

> 
>>>
>>>>> Always enable IEP1
>>>>>
>>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>>> ---
>>
> 

-- 
cheers,
-roger

