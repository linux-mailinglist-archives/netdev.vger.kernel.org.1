Return-Path: <netdev+bounces-201798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 177B6AEB188
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6433ABAC7
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 08:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AED248F62;
	Fri, 27 Jun 2025 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8BnQ4a2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3217F17741;
	Fri, 27 Jun 2025 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751013891; cv=none; b=uJFPV6/poyRkcTzn5Q1zCVL57nzYL9sXqY/UiBXsVK5Ths2Ew2tWwGVgwFnIDEb7xmRzM0DwiuvxGjdrZKCvBMoxFmyz8WnJt5SMte8czPWrDzRSJ30vM2QDD5HSg4gQDzKmryWVFOmx2QSSHFvc7IosEFDsmZDbb/yHhIkvZvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751013891; c=relaxed/simple;
	bh=RTLLpwAcPZOfKhzKTWv9DijE/pyyo/yM7NlOJeC3mSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPkhczQB1QUNksl7zpyRLBGk35nf5nxR+gCUmuDXMN/SpM3Z9gSPDQmO58G1fruMG80wuSVb7NBxprWbacnmzUrROHTm39xOjac00HIT3OQ0ImMcIgouf/hv3f1Jtn4sXTFOsRaG8+FtJD5wnCjVnN6fc2is237gQFG3PFczeOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8BnQ4a2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C807BC4CEE3;
	Fri, 27 Jun 2025 08:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751013890;
	bh=RTLLpwAcPZOfKhzKTWv9DijE/pyyo/yM7NlOJeC3mSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D8BnQ4a2qY+T7f6Nj93ZdhYrpdcPOQOWkuZ8+ABcMmaaalqNwlzCVewwvEgKG6BXN
	 ELWtADd0yAz+SoTC/LZgdsX4Ushlh5KbRxIGqcRmn+9J+0ZO4TLxmwbgDWK9x6bN+H
	 10Vsq5P6ufR4FKHGBpEc4FJLcUKby3zlkCiJ+N/vb7jd98zAZkmsowWvFUxuZBy/US
	 nalHm8bz7WEsfTHX4KPH/CS3zgKjx1DcskmR5Vq0fHOvdrK4oLUi0ln10/uPriktBK
	 uYQ4uVZUxK8GfgwwpJsTo8mRVpqk+ML+kUwBmHPrMhNHUqt5KImfrhwoJ7SlperKMh
	 BRGsPXnnQmfTg==
Date: Fri, 27 Jun 2025 10:44:47 +0200
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
Message-ID: <20250627-camouflaged-utopian-hedgehog-11ea2c@krzk-bin>
References: <20250624143220.244549-1-laura.nao@collabora.com>
 <20250624143220.244549-10-laura.nao@collabora.com>
 <7dfba01a-6ede-44c2-87e3-3ecb439b48e3@kernel.org>
 <284a4ee5-806b-45f9-8d57-d02ec291e389@collabora.com>
 <0870a2ba-936b-4eb2-a570-f2c9dea471b8@kernel.org>
 <9fc32523-5009-4f48-8d82-6c3fd285801d@collabora.com>
 <86654ad1-a2ab-4add-b9de-4d56c67f377b@kernel.org>
 <ae478fd7-c627-433c-a614-b76dcd4164d2@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae478fd7-c627-433c-a614-b76dcd4164d2@collabora.com>

On Wed, Jun 25, 2025 at 02:48:39PM +0200, AngeloGioacchino Del Regno wrote:
> Il 25/06/25 13:06, Krzysztof Kozlowski ha scritto:
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
> > 
> > BTW:
> > 
> > git grep mediatek,hardware-voter
> > 0 results
> > 
> > so I do not accept explanation that you use it in different drivers. Now
> > is the first time this is being upstream, so now is the time when this
> > is shaped.
> 
> I was simply trying to explain how I'm using it in the current design and nothing
> else; and I am happy to understand what other solution could there be for this and
> if there's anything cleaner.
> 
> You see what I do, and I'm *sure* that you definitely know that my goal is *not* to
> just tick yet another box, but to make things right, - and with the best possible
> shape and, especially, community agreement.

Ack, I understand. Your case here is really not different from all
others. Interface is different, hardware is different, but the concept -
you place votes via some intermediary - is completely the same which
qcom is doing since years and maybe other vendors as well.

And I expect more and more of this in case of Mediatek, so in the future
you will be plcing votes not only for on/off but also for values.
Everyone goes there, mobile, automotive... maybe IoT lags behind because
performance there is not that important, but all others need top
performance with top energy saving which they cannot do in Linux and
they move it to firmware (SCMI, hw voter, dedicated blocks, whatever).

You need to start designing this proper with that future in mind and
syscon is a strong no-go. Whether this is clocks, power domains or
interconnects - dunno yet, maybe both.

Best regards,
Krzysztof


