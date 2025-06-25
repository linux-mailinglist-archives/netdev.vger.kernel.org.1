Return-Path: <netdev+bounces-200995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E039AAE7B0A
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC4A3A9BC8
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 08:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8802857E0;
	Wed, 25 Jun 2025 08:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DW1bIPn8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054FB27F18F;
	Wed, 25 Jun 2025 08:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841857; cv=none; b=NSISRoSCIyJnRbzweNLYo42u7a7ikuR/E5R33E5yfOfuxVyce5lOzr+kSIxVgKVacOdrI/TLkzejXjAkZGlX/cTAE09ckBcmcDlMb1uJTjLkHH8up/aTIAjDy/IHcjwegL4i6ey9ft8VcIyMJ2T9H8Od3XyforNSmBzqOuxzipE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841857; c=relaxed/simple;
	bh=0QgB6O4O/sYU4iRucJ8iotwxezNS2MkmRTc3/U3q/9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+QuOWC26dQGwzDxme+03uaQwponS8676OQvErxW+umPdG6gKTN5lTFq+t/63qus3MkDYjAHUizopf4t/uPmVYvX36Nt9x7ktQPDHWDFsrnnBj3QNLv+0b7WQEVsAFuurIbW3mF0jMkCYnfTuG/TOpLMNNn+cZXt7bU5I3wogDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DW1bIPn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0FFC4CEEA;
	Wed, 25 Jun 2025 08:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750841856;
	bh=0QgB6O4O/sYU4iRucJ8iotwxezNS2MkmRTc3/U3q/9w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DW1bIPn8+wO1CO4ERNB9TZT6bfg+jmleh0swnm693vd3NvFbpG/OZSMRc56gGicV5
	 ZtF7p9vu8eh+rQYXLenH3rs2RhhmlE9o0vVCOz+uayDuNHhm5pY7OMLtBen1qooAdO
	 swoHx7Fsv/3l93q4QM3UpIHr5oMR8YjS2SZiaOWfWBz+5DGG14NuG0sKv85YiG7/ij
	 vGVG+davd9Q+wMxOEA5GnRmH3+7VbFNZxjoH7cJD02Och3vEOKe9Mb26Kz9twdi5FF
	 SbbQBlLN9MJ8GnBrTroEgtrrLQsM8HbBaIDLDQM3JE8sWH4tYrjmraF36T9AnpVF+L
	 bps/xM9fsAw2w==
Message-ID: <0870a2ba-936b-4eb2-a570-f2c9dea471b8@kernel.org>
Date: Wed, 25 Jun 2025 10:57:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/29] dt-bindings: clock: mediatek: Describe MT8196
 peripheral clock controllers
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Laura Nao <laura.nao@collabora.com>, mturquette@baylibre.com,
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, p.zabel@pengutronix.de, richardcochran@gmail.com
Cc: guangjie.song@mediatek.com, wenst@chromium.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 kernel@collabora.com
References: <20250624143220.244549-1-laura.nao@collabora.com>
 <20250624143220.244549-10-laura.nao@collabora.com>
 <7dfba01a-6ede-44c2-87e3-3ecb439b48e3@kernel.org>
 <284a4ee5-806b-45f9-8d57-d02ec291e389@collabora.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <284a4ee5-806b-45f9-8d57-d02ec291e389@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/06/2025 10:20, AngeloGioacchino Del Regno wrote:
> Il 24/06/25 18:02, Krzysztof Kozlowski ha scritto:
>> On 24/06/2025 16:32, Laura Nao wrote:
>>> +  '#reset-cells':
>>> +    const: 1
>>> +    description:
>>> +      Reset lines for PEXTP0/1 and UFS blocks.
>>> +
>>> +  mediatek,hardware-voter:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description:
>>> +      On the MT8196 SoC, a Hardware Voter (HWV) backed by a fixed-function
>>> +      MCU manages clock and power domain control across the AP and other
>>> +      remote processors. By aggregating their votes, it ensures clocks are
>>> +      safely enabled/disabled and power domains are active before register
>>> +      access.
>>
>> Resource voting is not via any phandle, but either interconnects or
>> required opps for power domain.
> 
> Sorry, I'm not sure who is actually misunderstanding what, here... let me try to
> explain the situation:
> 
> This is effectively used as a syscon - as in, the clock controllers need to perform
> MMIO R/W on both the clock controller itself *and* has to place a vote to the clock
> controller specific HWV register.

syscon is not the interface to place a vote for clocks. "clocks"
property is.

> 
> This is done for MUX-GATE and GATE clocks, other than for power domains.
> 
> Note that the HWV system is inside of the power domains controller, and it's split
> on a per hardware macro-block basis (as per usual MediaTek hardware layout...).
> 
> The HWV, therefore, does *not* vote for clock *rates* (so, modeling OPPs would be
> a software quirk, I think?), does *not* manage bandwidth (and interconnect is for
> voting BW only?), and is just a "switch to flip".

That's still clocks. Gate is a clock.

> 
> Is this happening because the description has to be improved and creating some
> misunderstanding, or is it because we are underestimating and/or ignoring something
> here?
> 

Other vendors, at least qcom, represent it properly - clocks. Sometimes
they mix up and represent it as power domains, but that's because
downstream is a mess and because we actually (at upstream) don't really
know what is inside there - is it a clock or power domain.


Best regards,
Krzysztof

