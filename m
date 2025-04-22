Return-Path: <netdev+bounces-184774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FBCA97211
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2802189CA1C
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7CB283C9E;
	Tue, 22 Apr 2025 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BL+N8Q5F"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831B328FFEF;
	Tue, 22 Apr 2025 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745338284; cv=none; b=WTfskOYipKKXnpuVENcvH/5wSUXswoVIYrIvD1p1Jlx/GBdHU/ZeVdLEe3pFg+U8cZyDy/21GKAkI4/unUkFadA/PLHt/ZF7/aYqflwcEqc47MMitnZUk54XVNhU2/DHp09R1dO2EoPCVgl5RcdotaqyMffkuyDei9igkI6YH7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745338284; c=relaxed/simple;
	bh=RRoJLlC7A12/TR2Wz8V+c+670ziWaCSA92DtyIsQ39c=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=bVX6ycf0Of5VJtnebyoAzc0RC07xNAiyMv5pfI2GEJ2lbc+/IOti1h/LUhhyoy3S7na4ZNZUk7tDP+muma9ShnbbJPKBZFH037iQzyzYEgmIx1tzkyBrprQf+Xbw+28y6UYVNmuhSSuWfdw5CaMhMPtLrKo0F3MbVXgGPpIa5Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BL+N8Q5F; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6506D43A46;
	Tue, 22 Apr 2025 16:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745338279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRoJLlC7A12/TR2Wz8V+c+670ziWaCSA92DtyIsQ39c=;
	b=BL+N8Q5Fn6rdiqBn6OmTsxXoJ9Hmwb4+Cp9EPmNsArEyLxUBWFVxrjkUHAF0kIsavPM6XX
	diCJtu+5Ly9c8KpN6G8x6k6lDFpyCYNdFdmJbLzqvILAA2E461zP6Vl5aQnWM52I1ZKFjb
	URv4AQLYjPslN6FYm//6sL4cTinqbdZ0ozPAQ8e/3iB+TBYuQf2hdfFevjXWgqw3IDHG8/
	uY3oRLwfCgKhdSGVb6x4CH2T0ogBE6yTmirNGCqLE14+OuS7xL/NOa3//AO+jRjVas+IZt
	Do7zVrHIg0pSTNgvl5tNaYZYAfY7atWN0Xxx+Tu4ztV+/zEpRVIM3rCNf3Da9w==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Apr 2025 18:11:18 +0200
Message-Id: <D9DAS80VMYAW.3JALOQIHS2B0W@bootlin.com>
To: "Maxime Chevallier" <maxime.chevallier@bootlin.com>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>, "Richard Cochran"
 <richardcochran@gmail.com>, "Daniel Machon" <daniel.machon@microchip.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [PATCH net 1/2] net: stmmac: fix dwmac1000 ptp timestamp status
 offset
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250422-stmmac_ts-v1-0-b59c9f406041@bootlin.com>
 <20250422-stmmac_ts-v1-1-b59c9f406041@bootlin.com>
 <20250422174934.309a1309@fedora.home>
In-Reply-To: <20250422174934.309a1309@fedora.home>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeegudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvfevuffhofhfjgesthhqredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekgfffhfehhfefgeekhfffudfhheekveffleeuhfelgfefueevhedvkeduhfehveenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudeipdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhto
 hepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhgtohhquhgvlhhinhdrshhtmhefvdesghhmrghilhdrtghomhdprhgtphhtthhopegrlhgvgigrnhgurhgvrdhtohhrghhuvgesfhhoshhsrdhsthdrtghomh
X-GND-Sasl: alexis.lothore@bootlin.com

Hi Maxime,

On Tue Apr 22, 2025 at 5:49 PM CEST, Maxime Chevallier wrote:
> Hi Alexis,
>
> On Tue, 22 Apr 2025 17:07:22 +0200
> Alexis Lothore <alexis.lothore@bootlin.com> wrote:
>
>> When a PTP interrupt occurs, the driver accesses the wrong offset to
>> learn about the number of available snapshots in the FIFO for dwmac1000:
>> it should be accessing bits 29..25, while it is currently reading bits
>> 19..16 (those are bits about the auxiliary triggers which have generated
>> the timestamps). As a consequence, it does not compute correctly the
>> number of available snapshots, and so possibly do not generate the
>> corresponding clock events if the bogus value ends up being 0.
>>=20
>> Fix clock events generation by reading the correct bits in the timestamp
>> register for dwmac1000.
>>=20
>> Fixes: 19b93bbb20eb ("net: stmmac: Introduce dwmac1000 timestamping oper=
ations")
>
> Looks like the commit hash is wrong, should be :
>
> 477c3e1f6363 ("net: stmmac: Introduce dwmac1000 timestamping operations")

Yes, you are absolutely right, I wrongly picked this hash from a custom
branch rather than a stable branch -_- Thanks for spotting this, will be
fixed in v2.

>
> Other than that I agree with the change, these offset are the right
> ones, thanks...
>
> With the Fixes tag fixed,
>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Alexis




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


