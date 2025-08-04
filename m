Return-Path: <netdev+bounces-211585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E77B1A3F8
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 15:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F533A4A38
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 13:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6911F26E6FB;
	Mon,  4 Aug 2025 13:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEwlJ1FD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3355025C81C;
	Mon,  4 Aug 2025 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754315937; cv=none; b=SDR+GkJT9mFLCFCYYdKbEhoGs2EHi0AP+IEUlQDPCVA7rIxHzODKwpc5yI37rGJY5Gb9MaLDuAsyMnpJzRuBmiB0maZA96v4TmMQ+Yt+sQeC8lv0ty0qmyTyt3NjZWUtGH9A2gv1lJTEPucifVLkR60tdaWjmOlSoG83bxn1dj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754315937; c=relaxed/simple;
	bh=7S8Hcavqc28ZL8iVcbrYH0U2GQeImQOnW5wu7/4OZkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kg4rdJzgCZDcfUG15yBRf5tWI9YCHVgF4jZFGKCCljZUmjlvOeUurzesT3yxV/TGR/jSewfB9YGeqyqvS+53s6h+Eun9Ia+EOFQ3+wLAybDhfj8meHJvJnchumsPNgynvPb+B1oBqKXT7GtlgwvA3HNyQF4B2gdSSyDFO1H4spQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEwlJ1FD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D83C4CEF0;
	Mon,  4 Aug 2025 13:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754315936;
	bh=7S8Hcavqc28ZL8iVcbrYH0U2GQeImQOnW5wu7/4OZkw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BEwlJ1FD3tS+6HTum4LGzdjC7wIFsjQdVsrQI4Zqp+9REkPtaLD/cz0FnBqtg7Cr5
	 DS/0nattZmh8oLk6EqkEcSz9XVbdzqKqDhwgqrke3553t0dIJFwSIO0j8iWBYKp89g
	 7SSWmlG6IkwBHesquXbRI6v6JE2wzApuNPIMzucigQa6++3Lljsk6tIf515ARTYad+
	 jAH6aXcbvGPyalEcX6p9YP1C7oJFXB49BmHWKYMydDstgwVgpEChrUPJ/ksNF66T7f
	 ue/gLZ/q4BwIyVszBuoY6QOct9ZqRpU2K+dlLGiHzYvmaQCm9Q9geAq/yHd73xrwvl
	 YNQWmFXpebwHg==
Message-ID: <2555e9fe-3bc0-4f89-9d0b-2f7f946632e7@kernel.org>
Date: Mon, 4 Aug 2025 15:58:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/27] dt-bindings: clock: mediatek: Describe MT8196
 clock controllers
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Laura Nao <laura.nao@collabora.com>, wenst@chromium.org
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 guangjie.song@mediatek.com, kernel@collabora.com, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com, mturquette@baylibre.com, netdev@vger.kernel.org,
 nfraprado@collabora.com, p.zabel@pengutronix.de, richardcochran@gmail.com,
 robh@kernel.org, sboyd@kernel.org
References: <fbe7b083-bc3f-4156-8056-e45c9adcb607@kernel.org>
 <20250804083540.19099-1-laura.nao@collabora.com>
 <373f44c3-8a6a-4d52-ba6b-4c9484e2eac1@kernel.org>
 <1db77784-a59a-49bd-89b5-9e81e6d3bafc@collabora.com>
 <e9ee33b0-d6b0-4641-aeeb-9803b4d1658a@kernel.org>
 <00a12553-b248-4193-8017-22fea07ee196@collabora.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <00a12553-b248-4193-8017-22fea07ee196@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/08/2025 15:27, AngeloGioacchino Del Regno wrote:
> 
> We discussed about aggregating votes, yes, in software - this instead is a
> *broken* hardware that does the aggregation internally and does not require
> nor want external drivers to do the aggregation.
> 
>> Maybe it is just the name, so avoid all the confusing "votes" if this is
>> not voting system. If this is a voting system, then don't use custom
>> phandles.
> 
> Being it fundamentally *broken*, this being a voting system is what the hardware
> initially wanted to be - but effectively, since it requires YOU to:
>   - Make sure that power supplies are turned on, if not, turn them on by "touching"
>     HW registers (so, without any assistance from the voter MCU), if any;
>   - Turn on parent clocks manually, if any, before using the "voter mcu" to try
>     to ungate that clock; and
>     - Enable the "FENC" manually, after the mcu says that the clock was ungated.


I understand that "YOU" as Linux driver, when you want to do something
(e.g. toggle) a clock?
If so this looks a lot like power domain, although with some differences.

> 
> in the current state, it is just an hardware managed refcounting system and
> nothing else, because the MCU seems to be unfinished, hence, again, b r o k e n.
> 
> Note that by "manually" I always mean "with direct writes to a clock controller's
> registerS, and without any automation/assistance from the HWV MCU".
> 
> We're using the "hardware-voter" name because this is how MediaTek calls it in the
> datasheets, and no it doesn't really *deserve* that name for what it is exactly in
> MT8196 and MT6991.

Please capture most/all of this in the property description, so it will
be clear that we treat it as some sort of exception and other users of
that property would need similar rationale.

I am asking for this because I do not want this to be re-used for any
other work which would represent something like real voting for
resources. I want it to be clear for whoever looks at it later during
new SoC bringup.

If you send the same code as v4, the same commit msg, just like Laura
did twice in v2 and v3, I will just keep NAKing via mutt macro because
it's a waste of my time.

> 
> And mind you - if using the "interconnect" property for this means that we have to
> add an interconnect driver for it, no, we will not do that, as placing a software

Existing driver(s) can be as well interconnect providers. Same with
power domains.

I do not talk here how you should implement this in the drivers.

> vote that votes clocks in a a voter MCU that does exactly what the interconnect

What is a "software vote"? How did you encode it in DT? Via that phandle?

> driver would do - then requiring virtual/fake clocks - is not a good solution.

We do not add "software votes" in DT as separate properties, because
they are "software". So maybe that's another problem here...

> 
> So, what should we do then?
> 
> Change it to "mediatek,clock-hw-refcounter", and adding a comment to the binding
> saying that this is called "Hardware Voter (HWV)" in the datasheets?
> 
> Or is using the "interconnect" property without any driver in the interconnect API
> actually legit? - Because to me it doesn't look like being legit (and if it is, it
> shouldn't be, as I'm sure that everyone would expect an interconnect API driver
> when encountering an "interconnect" property in DT), and if so, we should just add

Why you would not add any interconnect driver for interconnect API?
Look, the current phandle allows you to poke in some other MMIO space
for the purpose of enabling the clock FOO? So interconnect or power
domains or whatever allows you to have existing or new driver to receive
xlate() and, when requested resources associated with clock FOO.

Instead of the FOO clock driver poking resources, you do
clk_prepare_enable() or pm_domain or icc_enable().



Best regards,
Krzysztof

