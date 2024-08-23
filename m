Return-Path: <netdev+bounces-121321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A1195CB60
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 13:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D2F1F246DD
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 11:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9D015382E;
	Fri, 23 Aug 2024 11:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3FZitDI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D39149019;
	Fri, 23 Aug 2024 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724412666; cv=none; b=ZzM8Uoy/KXvWXR2jl6H+bgt7w/QnqY1+QY4j67fAPXqmwFj8gxuMrDzAYg9QuhuqQj8JjhKWBWXffkNEGtyDchgqTsINSlrGJ7IW7sXZrM7BZd4us6GtMSf7KgKxerwoi7B4PO5Gy3XBNMPXHhbn8Jo6j9wmK0Wi2qDheJsBEUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724412666; c=relaxed/simple;
	bh=u56sx2dT+ozOd5zmWGNmvgk3ks2U0lu3dCC0gWdRB2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epuwiulQz7SfFizZY3fdWNJ+jAsdE8V561ziYe4o+Q0GNZp/TiiR+nJY5+rp02uEPyzn7JH2Qd2kNpWv5kWSy/hxedzmHFjN5q8bj72nzVBa/yl/6ROYnEMwc8ShfSM1FsxlRaPufGFYfVk/LzjcqILDRRaH47/u9gHSIjXLlYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3FZitDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3705CC32786;
	Fri, 23 Aug 2024 11:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724412665;
	bh=u56sx2dT+ozOd5zmWGNmvgk3ks2U0lu3dCC0gWdRB2M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I3FZitDIkFJ+rN4gKq5bPxU3w/eZ201rvuN92pHNZoOJZpbxkR5Tht38ha1Eu2Xqj
	 IDFhodXbf6UVomb8l/+GdaK/Gr8/yH2OcrNQxoOldMlwNUSBu4fu0MYzpx6ZNC9a9B
	 UsRzxTf7k5ey03+e3YhH3FaIWqL7DcLXa4RwIgoYRb1hkiUU9FwM8GhC2rUc/ffrsx
	 yd0JfJT/0u6ik7gK/GXm5HUcMIU8LizU+jysmJnnCsy6NB1Sldnr60ZDod3WTlupg+
	 kY/9rVTRwU5+MNx7jImGPh93rbhwEBhCYNj6Atm3HUV2I75McfGGm27nD6ZxmCiY1m
	 RpWcEQzIXLxlw==
Message-ID: <cde0064d-83dd-4a7f-8921-053c25aae08b@kernel.org>
Date: Fri, 23 Aug 2024 14:30:58 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/7] net: ti: icssg-prueth: Enable IEP1
To: "Anwar, Md Danish" <a0501179@ti.com>, MD Danish Anwar
 <danishanwar@ti.com>, Dan Carpenter <dan.carpenter@linaro.org>,
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
 <8ab571a7-6441-4616-b456-a0677b2520c7@kernel.org>
 <c26c0761-def7-48a1-973d-2c918689902d@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <c26c0761-def7-48a1-973d-2c918689902d@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 22/08/2024 15:12, Anwar, Md Danish wrote:
> 
> 
> On 8/22/2024 4:57 PM, Roger Quadros wrote:
>>
>>
>> On 22/08/2024 08:52, MD Danish Anwar wrote:
>>>
>>>
>>> On 21/08/24 5:23 pm, Roger Quadros wrote:
>>>>
>>>>
>>>> On 21/08/2024 14:33, Anwar, Md Danish wrote:
>>>>> Hi Roger,
>>>>>
>>>>> On 8/21/2024 4:57 PM, Roger Quadros wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 13/08/2024 10:42, MD Danish Anwar wrote:
>>>>>>> IEP1 is needed by firmware to enable FDB learning and FDB ageing.
>>>>>>
>>>>>> Required by which firmware?
>>>>>>
>>>>>
>>>>> IEP1 is needed by all ICSSG firmwares (Dual EMAC / Switch / HSR)
>>>>>
>>>>>> Does dual-emac firmware need this?
>>>>>>
>>>>>
>>>>> Yes, Dual EMAC firmware needs IEP1 to enabled.
>>>>
>>>> Then this need to be a bug fix?
>>>
>>> Correct, this is in fact a bug. But IEP1 is also needed by HSR firmware
>>> so I thought of keeping this patch with HSR series. As HSR will be
>>> completely broken if IEP1 is not enabled.
>>>
>>> I didn't want to post two patches one as bug fix to net and one part of
>>> HSR to net-next thus I thought of keeping this patch in this series only.
>>
>> Bug fixes need to be posted earlier as they can get accepted sooner and
>> even back-ported to stable. You also need to add the Fixes tag.
>>
> 
> Yes I understand that. The problem was I will need to send the patch
> twice once as bug fix to net/main, once as part of this series to
> net-next/main and drop it from this series once the patch gets merged to
> net and is synced to net-next. Since I cannot post this series without
> this patch as the HSR feature will get broken.

HSR feature is not yet there so nothing will be broken. You can mention
in cover letter that a separate patch is required for functionality.

> 
> Or I need to post this to net/main and wait for it to be part of
> net-next and then only I can re-post this series. So to avoid all these
> I thought of only posting it as part of this series. This is not a major
> bug and it will be okay from feature perspective if this bug gets merged
> via net-next.
> 

If there is no build dependency I don't see why you need to wait.

> What do you suggest now? Should I post the bug fix to net/main and post
> this seires without this patch or wait for the bug fix to sync then only
> post this series?
> 

please see below.

>>>
>>>> What is the impact if IEP1 is not enabled for dual emac.
>>>>
>>>
>>> Without IEP1 enabled, Crash is seen on AM64x 10M link when connecting /
>>> disconnecting multiple times. On AM65x IEP1 was always enabled because
>>
>> In that ase you need to enable quirk_10m_link_issue for AM64x platform.
> 
> Correct. But since for all ICSSG supported platform quirk_10m_link_issue
>  needs to be enabled. Which in turn will enable IEP1. I think it's
> better enable IEP1 directly without any condition.
> 
> IEP1 is also needed for Switch and HSR firmwares so I thought directly
> enabling it instead of enabling it inside the if check
> `prueth->pdata.quirk_10m_link_issue` would be better idea.
> 
> What do you suggest here? Will setting `quirk_10m_link_issue` as true
> for AM64x will be a better approach or always enabling IEP1 without any
> if check will be better approach for this?

I would suggest that you first send a bug fix patch for AM64x which sets
quirk_10m_link_issue for AM64x. This should make it into the next -rc
and eventually stable.

Then in your HSR series, you can decide if you want to conditionally
enable it for HSR/switch mode or permanently enable it regardless.

> 
>> I understand that IEP1 is not required for 100M/1G.
>>
>>> `prueth->pdata.quirk_10m_link_issue` was true. FDB learning and FDB
>>> ageing will also get impacted if IEP1 is not enabled.
>>
>> Is FDB learning and ageing involved in dual Emac mode?
>>
> 
> Yes FDB learning and ageing is involved in dual EMAC mode as well.
> 
>>>
>>>>>
>>>>>>> Always enable IEP1
>>>>>>>
>>>>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>>>>> ---
>>>>
>>>
>>
> 

-- 
cheers,
-roger

