Return-Path: <netdev+bounces-201793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCB0AEB16D
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557F85667AD
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 08:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F10521E08A;
	Fri, 27 Jun 2025 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKUojzIY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E5136672;
	Fri, 27 Jun 2025 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751013424; cv=none; b=o0y4F5JgeL3J/c1KxxxmARVEpUm8kPIrnkb+93U1LNECNxUWfr0+k7cb6UdXm7wz6NUAq5Kh/EnosK+MSfesW6gIjz4A6pUFOfpa/Yfg5vzoKuV5ANoHDAvDDPIZ66ghWfKUFJ7TYvmj4Sehg80EBiOoruDn22yB3LVlcmMeWUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751013424; c=relaxed/simple;
	bh=yWXI+MjQClJMKfE5POsBy9to/tIrO6o24Qlch/pvNSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfD4zmZ4MDQ+g0Az8ctqRx2m4BbAqNIqnn26k6Qhn1ZTfgNIgtpDqBSULp1TbZO9UbLbhAD5BoTz+I6F1bcbRjDQnHTL4uhYy753F/tIKDQcxYXKE2SZXCQb6WYEYAAYmAhNNfQvPD7C4yXFsrQChGpQwhwPRE8G5VxJJ+CJVeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKUojzIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AA8C4CEE3;
	Fri, 27 Jun 2025 08:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751013423;
	bh=yWXI+MjQClJMKfE5POsBy9to/tIrO6o24Qlch/pvNSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uKUojzIYgA4egmrpUAzw5VgfAMdSLFoHrcwyvD4cYNKrT4sFI1dUq9Uao1Jz9eqGy
	 Cl7VIxetZSqylOssl7W9tzxwrJSSKEuO0vc40YCKJhU+zJPO+60wj1Z0Ff6t87ir/E
	 8yLPGDYI1uVWxp8DRUinDIrBaq8vzhtVcGa3Vzs68KKJi24X42fhX53Z0loX+lZEsl
	 zrZhZEMan5NpQ8pm/+41uM5FmpWDrzZm6HjCBQXrfPbPWPesLIzF25M2LaYb7EJc6I
	 pYSOHMhj2Pg0aGQ6AHvc5Sa/w+nRnsYljwqp7/iJNWyRM7MI+eBqMm0aWPhS+pxCQn
	 WHG5LuDbVJhSw==
Date: Fri, 27 Jun 2025 10:37:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Laura Nao <laura.nao@collabora.com>, mturquette@baylibre.com, 
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, p.zabel@pengutronix.de, richardcochran@gmail.com, 
	guangjie.song@mediatek.com, wenst@chromium.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	kernel@collabora.com
Subject: Re: [PATCH v2 09/29] dt-bindings: clock: mediatek: Describe MT8196
 peripheral clock controllers
Message-ID: <20250627-ingenious-tourmaline-wapiti-fa7676@krzk-bin>
References: <20250624143220.244549-1-laura.nao@collabora.com>
 <20250624143220.244549-10-laura.nao@collabora.com>
 <7dfba01a-6ede-44c2-87e3-3ecb439b48e3@kernel.org>
 <284a4ee5-806b-45f9-8d57-d02ec291e389@collabora.com>
 <0870a2ba-936b-4eb2-a570-f2c9dea471b8@kernel.org>
 <9fc32523-5009-4f48-8d82-6c3fd285801d@collabora.com>
 <29eeae4f-59ed-4781-88b1-4fd76714ecb6@kernel.org>
 <312f321f-2e49-48ac-bc41-a741f5e3b3a5@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <312f321f-2e49-48ac-bc41-a741f5e3b3a5@collabora.com>

On Wed, Jun 25, 2025 at 02:42:15PM +0200, AngeloGioacchino Del Regno wrote:
> Il 25/06/25 13:05, Krzysztof Kozlowski ha scritto:
> > On 25/06/2025 11:45, AngeloGioacchino Del Regno wrote:
> > > Il 25/06/25 10:57, Krzysztof Kozlowski ha scritto:
> > > > On 25/06/2025 10:20, AngeloGioacchino Del Regno wrote:
> > > > > Il 24/06/25 18:02, Krzysztof Kozlowski ha scritto:
> > > > > > On 24/06/2025 16:32, Laura Nao wrote:
> > > > > > > +  '#reset-cells':
> > > > > > > +    const: 1
> > > > > > > +    description:
> > > > > > > +      Reset lines for PEXTP0/1 and UFS blocks.
> > > > > > > +
> > > > > > > +  mediatek,hardware-voter:
> > > > > > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > > > > > +    description:
> > > > > > > +      On the MT8196 SoC, a Hardware Voter (HWV) backed by a fixed-function
> > > > > > > +      MCU manages clock and power domain control across the AP and other
> > > > > > > +      remote processors. By aggregating their votes, it ensures clocks are
> > > > > > > +      safely enabled/disabled and power domains are active before register
> > > > > > > +      access.
> > > > > > 
> > > > > > Resource voting is not via any phandle, but either interconnects or
> > > > > > required opps for power domain.
> > > > > 
> > > > > Sorry, I'm not sure who is actually misunderstanding what, here... let me try to
> > > > > explain the situation:
> > > > > 
> > > > > This is effectively used as a syscon - as in, the clock controllers need to perform
> > > > > MMIO R/W on both the clock controller itself *and* has to place a vote to the clock
> > > > > controller specific HWV register.
> > > > 
> > > > syscon is not the interface to place a vote for clocks. "clocks"
> > > > property is.
> > > > 
> > > > > 
> > > > > This is done for MUX-GATE and GATE clocks, other than for power domains.
> > > > > 
> > > > > Note that the HWV system is inside of the power domains controller, and it's split
> > > > > on a per hardware macro-block basis (as per usual MediaTek hardware layout...).
> > > > > 
> > > > > The HWV, therefore, does *not* vote for clock *rates* (so, modeling OPPs would be
> > > > > a software quirk, I think?), does *not* manage bandwidth (and interconnect is for
> > > > > voting BW only?), and is just a "switch to flip".
> > > > 
> > > > That's still clocks. Gate is a clock.
> > > > 
> > > > > 
> > > > > Is this happening because the description has to be improved and creating some
> > > > > misunderstanding, or is it because we are underestimating and/or ignoring something
> > > > > here?
> > > > > 
> > > > 
> > > > Other vendors, at least qcom, represent it properly - clocks. Sometimes
> > > > they mix up and represent it as power domains, but that's because
> > > > downstream is a mess and because we actually (at upstream) don't really
> > > > know what is inside there - is it a clock or power domain.
> > > > 
> > > 
> > > ....but the hardware voter cannot be represented as a clock, because you use it
> > > for clocks *or* power domains (but at the same time, and of course in different
> > > drivers, and in different *intertwined* registers).
> > > 
> > > So the hardware voter itself (and/or bits inside of its registers) cannot be
> > > represented as a clock :\
> > > 
> > > In the context of clocks, it's used for clocks, (and not touching power domains at
> > > all), but in the context of power domains it's used for power domains (and not
> > > touching clocks at all).
> > 
> > I don't understand this. Earlier you mentioned "MUX-GATE and GATE
> > clocks", so these are clocks, right? How these clocks are used in other
> > places as power domains?
> 
> I think you've misread, or I've explained badly enough to make you misread...
> let me describe some more to try to let you understand this properly.
> 
> The hardware voter is a unit that is used to vote for "flipping various switches",
> in particular, you can vote for, *either*:
>  - Enabling or disabling a *clock*; or
>  - Enabling or disabling a *power domain*.
> 
> There may be multiple (by hardware, in-silicon) copies of the Hardware Voter; in
> the specific case of the MediaTek Dimensity 9400 MT6991 and of the MediaTek MT8196
> Chromebook SoC, there is only one instance.

Everything so far very similar to qcom... They do exactly like that.

> 
> The Hardware Voter, there, is located in the SCPSYS macro-block.
> 
> The SCPSYS macro-block contains:
>  - A system controller
>  - A Hardware Voter IP (new in MT6991/MT8196)
>  - A power domains controller
>  - Other hardware that is not relevant for this discussion
> 
> The HWV is MMIO-accessible, and there is one (small, for now) set of registers,
> allowing to vote for turning on/off one (or maybe multiple too, not sure about
> that as there's no documentation and when I tried with multi-votes it didn't work)
> clk/pd at a time.

Sure, the only difference against qcom is interface - qcom uses
remoteprocs channels, here you have MMIO. The interface does not matter
though.

> 
> Probably not important but worth mentioning: the HWV can vote for clocks or for
> power domains in macro-blocks outside of its own (so, outside of the SCPSYS block,
> for example - it can vote to turn on a clock or a power domain in HFRPSYS as well).

Same for qcom.

> 
> The register set in the HWV is *not* split between clock voters and PDs voters,
> in the sense that the register set of clock voters is *not contiguous*; trying
> to be as clear as possible, you have something like (mock register names ahead):
>  0x0 - CLOCK_VOTER_0 (each bit is a clock)
>  0x4 - PD_VOTER_0 (each bit is a power domain)
>  0x8 - SECURE_WORLD_CLOCK_VOTER_1
>  0xc - PD_VOTER_1
>  0x10 - SECURE_WORLD_PD_VOTER_0
> 
> ...etc etc.

OK

> 
> >> If they are, this either has to be fixed or
> > apparently this is a power domain and use it as power domain also here.
> 
> So no, clocks are not used as power domains, and power domains are not used as
> clocks; we are talking purely about something that aggregates votes internally

OK

> and decides to turn on/off "whatever thing it is" (one of the clocks, or one of
> the power domains) - and to do that, you flip a bit in a register, and then you
> read another two registers to know the status of the internal state machine....

Sure. This is 100% not syscon, though. You must not do it via syscon,
because you will be flopping bits of other devices in this driver.
What's more, the actual implementation - registers for voting - is
irrelevant to this device here. This device here wants:
power domain
or
clock

Hm... don't we have bindings for this? Wait, we have!

> 
> ....and you do that atomically, this can't sleep, the system has to lock up
> until HWV is done (I think I know what you're thinking, and yes, it's really
> like this) otherwise you're surely racing.

Sure, no problems here.

> 
> > 
> > Really, something called as hardware voter is not that uncommon and it
> > does fit existing bindings.
> > 
> 
> Do you mean the interconnect/qcom/bcm-voter.c?

This and many others - all rpm/rpmh/rsc are for that.

> 
> That one seems to aggregate votes in software to place a vote in a hardware voter
> (the Bus Clock Manager) and I see it as being really convoluted.

I do not say that drivers are example to follow. Actually, I do not
recommend even DT bindings!

> 
> For MediaTek's HWV, you don't need to aggregate anything - actually, the HWV itself
> is taking care of aggregating requests internally...
> 
> Also, checking sdx75 and x1e80100 DTs, I see a virtual clock controller described,
> placing votes through the bcm-voter, and with clocks that looks like being kind
> of disguised/faked as interconnects?

Don't remember exactly, but I don't think it matters. What matters is
you need to choose appropriate representation for your votes.
> 
> That's a bit unclear, and even if I'm wrong about those being disguised as icc,
> and not virtual, purely looking at the usage of the clk_virt and bcm-voters, I
> seriously don't think that any similar structure with interconnect would fit
> MediaTek SoCs in any way...


> 
> > > 
> > > I'm not sure what qcom does - your reply makes me think that they did it such that
> > > the clocks part is in a MMIO and the power domains part is in a different MMIO,
> > > without having clock/pd intertwined voting registers...
> > 
> > No, you just never have direct access to hardware. You place votes and
> > votes go to the firmware. Now depending on person submitting it or
> > writing internal docs, they call it differently, but eventually it is
> > the same. You want to vote for some specific signal to be active or
> > running at some performance level.
> > 
> 
> Okay then there is one similarity, but it's different; MTK HWV is only arbitering
> a on/off request; Nothing else.

Does not matter, still the same concept.

In 2026 or 2027 you will do other votes as well...

> 
> No RATE votes.
> No performance levels.
> Literally, that's it.

Best regards,
Krzysztof


