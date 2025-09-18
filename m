Return-Path: <netdev+bounces-216413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152FDB337F4
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 09:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07053B06DE
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 07:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB65296BD7;
	Mon, 25 Aug 2025 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvSbYewU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34A2296BA6;
	Mon, 25 Aug 2025 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756107459; cv=none; b=dnA9/zfIfR9LqX3zssROtNndnX3QVyWVngWxJ6Gx21UcL6sRaP1sL2FSErL7N1ADzPQD5yJGJPTfBwqIb+28Njy1PDeL4mfKvCZZe5DuyP/aorP3dZignGs20udEs40IhJVssdRVJPZU8zOJXb6e2WirtG18eC2bhLUPYeQHQxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756107459; c=relaxed/simple;
	bh=8Xuat5q/bZZpMzPwFIkh7VaktYMRLaRNPSYsoQ3oS0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WuuhOl9J+AjFpGq8dLLoCJX1eEl9LCqxkDsIA4UVicOqZejIZUOwduvddTj398JhfV4SviH0mzMP+G/N19r/OQiLoksZ5ldZIXJ0xEd9zLvUZBbjZp4+TlKD+wsZb25QDbWutIDAQ9JiZUskbwAa+Lt/HM2KZ5KWcFhzOK1Sip8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvSbYewU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA22C4CEED;
	Mon, 25 Aug 2025 07:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756107459;
	bh=8Xuat5q/bZZpMzPwFIkh7VaktYMRLaRNPSYsoQ3oS0Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RvSbYewU3bmOnaNDNcoMiWjgIKvvrMHo5tWpU3d400C3IYl9vMYTI0ZX5kijfN5qE
	 zuIVbvV3O0iAI0IaOXiAKIE3sGMR5UkArSjLP+1Vxf4MYJiQUZAnz+Yp3fcWv4SXnx
	 MIFnixrBLZjbOWNJzIpxDEwbzL5se0Cz3rWL9m6XC3JemOnm/X9qniAGiKeUaJH52a
	 Qbf1oegujVn8rfW2Rewv2FRFkDjzxxM2awj4oE0uQlt1MKURL7PyKE8e5Vx+VosUvS
	 ejZSLgiYvJ5FFBNuf4/Ub7LRA4VxmneXfcoTr7EiJ3nV3IqbnrrTCNg3hH+7HiP9aP
	 SD0rYENc9mjTw==
Message-ID: <96b6f650-fa4d-461b-91f6-cb210cb1982d@kernel.org>
Date: Mon, 25 Aug 2025 09:37:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/3] dt-bindings: net: dsa: yt921x: Add
 Motorcomm YT921x switch support
To: Yangfl <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250824005116.2434998-1-mmyangfl@gmail.com>
 <20250824005116.2434998-2-mmyangfl@gmail.com>
 <20250824-jolly-amaranth-panther-97a835@kuoka>
 <CAAXyoMOfhSWhRCiFudju-DNtvD+8kHGhLzT2NGBF2cK_Ctviyw@mail.gmail.com>
 <0cb62840-845b-4a9f-94c6-e40d0b72ce95@kernel.org>
 <CAAXyoMMej5XJmofiY_9cpzscxm2GyZw_v9hcSYu7NvhcNFFV2Q@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CAAXyoMMej5XJmofiY_9cpzscxm2GyZw_v9hcSYu7NvhcNFFV2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/08/2025 04:39, Yangfl wrote:
> On Mon, Aug 25, 2025 at 2:09 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 24/08/2025 11:25, Yangfl wrote:
>>> On Sun, Aug 24, 2025 at 5:20 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>
>>>> On Sun, Aug 24, 2025 at 08:51:09AM +0800, David Yang wrote:
>>>>> The Motorcomm YT921x series is a family of Ethernet switches with up to
>>>>> 8 internal GbE PHYs and up to 2 GMACs.
>>>>>
>>>>> Signed-off-by: David Yang <mmyangfl@gmail.com>
>>>>> ---
>>>>
>>>> <form letter>
>>>> This is a friendly reminder during the review process.
>>>>
>>>> It looks like you received a tag and forgot to add it.
>>>>
>>>> If you do not know the process, here is a short explanation:
>>>> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
>>>> versions of patchset, under or above your Signed-off-by tag, unless
>>>> patch changed significantly (e.g. new properties added to the DT
>>>> bindings). Tag is "received", when provided in a message replied to you
>>>> on the mailing list. Tools like b4 can help here. However, there's no
>>>> need to repost patches *only* to add the tags. The upstream maintainer
>>>> will do that for tags received on the version they apply.
>>>>
>>>> Please read:
>>>> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
>>>>
>>>> *If a tag was not added on purpose, please state why* and what changed.
>>>> </form letter>
>>>>
>>>>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>
>>> Thanks.
>>>
>>>>  - use enum for reg in dt binding
>>>
>>> I made a change in dt binding. If you are fine with that change, I'll
>>> add the tag in the following versions (if any).
>>
>>
>> Cover letter must state the reason.
>>
>>
>> Best regards,
>> Krzysztof
> 
> as requested in the previous version
> 
> https://lore.kernel.org/r/f76df98e-f743-4dc2-9f10-93b97f69addb@lunn.ch

Hm? Where is there a statement that you remove review because of this
and that?


Best regards,
Krzysztof

