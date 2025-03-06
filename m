Return-Path: <netdev+bounces-172316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B13A54334
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 08:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57477189417A
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 07:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED841A5B8B;
	Thu,  6 Mar 2025 07:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hecywSUY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F23019DF4D;
	Thu,  6 Mar 2025 07:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741244734; cv=none; b=aOxOYVvmhR9FUTI6swLu8jouz15+ClEaI8X5/AaEMA0WnXCZ8knre5IVKgm2hvX9O3TWYy4uZ+PCsVF+LP+fP9DHjG50p1FMHb0jQjxujliqA9n6hpWd6ccgl+l4b+PrOnQ418m48deI3JaA9k5/HNo6YPKSfTN6xKo2VsWRdss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741244734; c=relaxed/simple;
	bh=2mj5Lmm88y0kQhwct/3wA//D7aNt1Lt6qq942WjAldk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pEQrmi8deyqvItoYOnmSvexVgk0t5B4EHNcXXDLyKTj24RInmi86sRhloSjNG7RPYto4IMErpu5ocHWY8EhpzfSlfMgYK8v1TbTTN69SaT/RQHHnBE3dnOodVTgvNAaaahD25Yg2m4Z8zlkjdbIwv0DmLq7KGhTtLlIg81MA95Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hecywSUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5351C4CEE4;
	Thu,  6 Mar 2025 07:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741244733;
	bh=2mj5Lmm88y0kQhwct/3wA//D7aNt1Lt6qq942WjAldk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hecywSUYoB+yhiCnpdiocJrMUNx0RFZxotj9PrwxwOJfD+IpqekqyEGYzIoC/Ki6s
	 0pSBfM6vb6795Kc4ZhfRBXfWpvf/kE2mdScp4ZsFSWoBqN8i8RESTgAMJncMDoYrPm
	 /WF0TBB6Cy+6xza1/byUoc8H5eMdxZDJ5YLetldg4u/YsEMjbsyz2aI8MQpvo3nojR
	 KZ4QutpDIis4cR+rovFhn+587Bw7rIN5/GiHcJZ1BMMAsP6g0fsDr7vbAUOZ7sAX3y
	 xDWZtuOr9Y4Tu3dAaX6EqdSofxeYwQX6ywsdXd0UGW4eGRjzcomZ2XYu3ZSMk1a02/
	 sz15W+hbCJMiw==
Message-ID: <a9ddeccf-8fc6-453c-af62-55e895888a77@kernel.org>
Date: Thu, 6 Mar 2025 08:05:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] dt-bindings: net: Add FSD EQoS device tree
 bindings
To: Swathi K S <swathi.ks@samsung.com>, krzk+dt@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, conor+dt@kernel.org,
 richardcochran@gmail.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com
Cc: rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 pankaj.dubey@samsung.com, ravi.patel@samsung.com, gost.dev@samsung.com
References: <20250305091246.106626-1-swathi.ks@samsung.com>
 <CGME20250305091852epcas5p18a0853e85a5ed3d36d5d42ef89735ca6@epcas5p1.samsung.com>
 <20250305091246.106626-2-swathi.ks@samsung.com>
 <89dcfb2a-d093-48f9-b6d7-af99b383a1bc@kernel.org>
 <00e301db8e49$95bfbf90$c13f3eb0$@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <00e301db8e49$95bfbf90$c13f3eb0$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/03/2025 04:40, Swathi K S wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: 05 March 2025 21:12
>> To: Swathi K S <swathi.ks@samsung.com>; krzk+dt@kernel.org;
>> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
>> kuba@kernel.org; pabeni@redhat.com; robh@kernel.org;
>> conor+dt@kernel.org; richardcochran@gmail.com;
>> mcoquelin.stm32@gmail.com; alexandre.torgue@foss.st.com
>> Cc: rmk+kernel@armlinux.org.uk; netdev@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com;
>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>> pankaj.dubey@samsung.com; ravi.patel@samsung.com;
>> gost.dev@samsung.com
>> Subject: Re: [PATCH v8 1/2] dt-bindings: net: Add FSD EQoS device tree
>> bindings
>>
>> On 05/03/2025 10:12, Swathi K S wrote:
>>> Add FSD Ethernet compatible in Synopsys dt-bindings document. Add FSD
>>> Ethernet YAML schema to enable the DT validation.
>>>
>>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>>> Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
>>> Signed-off-by: Swathi K S <swathi.ks@samsung.com>
>>
>> <form letter>
>> This is a friendly reminder during the review process.
>>
>> It looks like you received a tag and forgot to add it.
>>
>> If you do not know the process, here is a short explanation:
>> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
>> versions of patchset, under or above your Signed-off-by tag, unless patch
>> changed significantly (e.g. new properties added to the DT bindings). Tag is
>> "received", when provided in a message replied to you on the mailing list.
>> Tools like b4 can help here. However, there's no need to repost patches
>> *only* to add the tags. The upstream maintainer will do that for tags
>> received on the version they apply.
>>
>> Please read:
>> https://protect2.fireeye.com/v1/url?k=19972162-781c345b-1996aa2d-
>> 000babffae10-7bd6b1a1d78b210b&q=1&e=94dcc3a6-5303-441a-8c1e-
>> de696b216f86&u=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv6.12-
>> rc3%2Fsource%2FDocumentation%2Fprocess%2Fsubmitting-
>> patches.rst%23L577
>>
>> If a tag was not added on purpose, please state why and what changed.
> 
> Hi Krzysztof, 
> As per a review comment received from Russell, I had added 2 new properties to the DT - assigned-clocks and assigned-clock-parents properties. 
> The example in the DT binding reflects the same.
> I felt it wouldn't be fair to add 'Reviewed-by' tag without you reviewing the updates again.
> But I should have mentioned that in cover letter and apologies for missing to do that.
Nothing in changelog explained new properties. Nothing mentioned
dropping tag, which you always must explicitly say.

Best regards,
Krzysztof

