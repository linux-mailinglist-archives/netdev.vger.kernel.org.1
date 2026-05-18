Return-Path: <netdev+bounces-289028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4P2qEvgEC2qj/QQAu9opvQ
	(envelope-from <netdev+bounces-289028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:24:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C27B756C931
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58C6030D5FF8
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5AF3FF1CC;
	Mon, 18 May 2026 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0auKsWR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2A9322B6F;
	Mon, 18 May 2026 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106465; cv=none; b=By7ycJjNqd7ZdtxwwLP09QF7HEZl7eT64ETHXHXTyrFgQ0ZOCgcuCc2UvZZDbUTRLPifCOxdIVsqj9IGladDydP2Npx/7u8C0EUD+uOaZCl4RgU9b9Ubi+r6cJi7jFHNknR/AbU6w7LRkfMvXbXLfkyYNSHzRMOHZ6bLngAu1QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106465; c=relaxed/simple;
	bh=GNYTfMcpdYqvc5O6r9OZMMFpvN0zVIdv7qdjGK/a46A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbIc7VZBFGQQ33muej5snZlMA2SsO3t/0qwX2sL2iS7VuBty2uRjouufwEDzLpekL9wWZ7ZQ60coJvHi20XL8J351yRvStAqOjhoP8zM98ildE9ljNA1XwcqPcHz+3KJApx3G+ibDBy0kKlswRcUTHBF2faaB6tA4OD84KODrv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0auKsWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2665DC2BCB7;
	Mon, 18 May 2026 12:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779106465;
	bh=GNYTfMcpdYqvc5O6r9OZMMFpvN0zVIdv7qdjGK/a46A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U0auKsWR6IY5dSn2or0lJLFBvKIhnen8FrW7e70aiBBrFqnjKp5HWAwWjshEbXK9y
	 bjdtatA1i8duY1hH3i7Iha/fO3EkWu9cN1ef8m8zBNocKK2eN7htVpFliI/ZpBjSVA
	 iA0a/YR8mqjL1rLeTslcic5VukgHquImcj0pQe2znlVKo0EHuhRh/ybXSPz7kQDpVs
	 6LRiJ+GpVBHw+2O6iFryXfIeTsHSPu7PtrMS7nKl75sC/RbmOOGPo4DDka0RC7bLlq
	 OezasHM8gt4CzVFdvM7DbhUgf5q4ORIiTot9m8QUJqR68pgCNjo1GiW9BAGagizcjZ
	 TNvkzRDadjgbg==
Date: Mon, 18 May 2026 14:14:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Chen <peter.chen@kernel.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 5/6] dt-bindings: phy: tegra: Document Nvidia Tegra
 XMM6260 PHY
Message-ID: <20260518-mustard-rabbit-of-ecstasy-eed3b6@quoll>
References: <20260511135703.62470-1-clamor95@gmail.com>
 <20260511135703.62470-6-clamor95@gmail.com>
 <20260515-utopian-malamute-of-patience-367e8e@quoll>
 <CAPVz0n2wrAdU0JKx7eb7uosCcoGayqNchK591VPph-5_nBAMXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPVz0n2wrAdU0JKx7eb7uosCcoGayqNchK591VPph-5_nBAMXg@mail.gmail.com>
X-Rspamd-Queue-Id: C27B756C931
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289028-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 11:37:34AM +0300, Svyatoslav Ryhel wrote:
> =D0=BF=D1=82, 15 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 11=
:20 Krzysztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Mon, May 11, 2026 at 04:57:00PM +0300, Svyatoslav Ryhel wrote:
> > > Document the XMM6260 PHY used by various devices based on the Nvidia =
Tegra
> > > SoC, describing its usage
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  .../bindings/phy/nvidia,tegra-xmm6260.yaml    | 58 +++++++++++++++++=
++
> > >  1 file changed, 58 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/phy/nvidia,tegr=
a-xmm6260.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra-xmm62=
60.yaml b/Documentation/devicetree/bindings/phy/nvidia,tegra-xmm6260.yaml
> > > new file mode 100644
> > > index 000000000000..0346433c9772
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/phy/nvidia,tegra-xmm6260.yaml
> > > @@ -0,0 +1,58 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/phy/nvidia,tegra-xmm6260.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Nvidia Tegra PHY for XMM6260 modem
> >
> > XMM6260 is Infineon modem, so any combination with nvidia,tegra is very
> > confusing.
> >
>=20
> May you please suggest how to adjust the name then? Thank you.

Depending what is that. Start describing hardware, not driver behavior
to help in that.

>=20
> > > +
> > > +description:
> > > +  A hardware configuration used in Tegra SoCs to provide proper inte=
raction
> > > +  between the application processor and the modem, as well as contro=
l over
> > > +  one of the SoC's USB lines for the modem.
> > > +
> > > +maintainers:
> > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: nvidia,tegra-xmm6260
> >
> > Also here.
> >
> > What sort of phy is this? So far looks more like a software construct.
> >
>=20
> Infineon XMM6260 does not work as an ordinary USB modem, it is a
> standalone CPU which just exposes itself to AP via USB. In order to do
> so, it has to have control over a USB bus of AP which is dedicated to
> it. In case of Tegra - XMM6260 interaction it looks like this: second
> Tegra USB controller is set into HSIC mode and is dedicated solely to
> the modem, modem controls this USB bus. Then the main XMM6260 driver
> performs power and init sequence and once it is ready it calls phy to
> register controller. Phy has its own supply, controls USB controller
> de/register and using enable GPIO sends signal to modem to proceed.
> Additionally, since some XMM626 versions have a few steps to setup
> exposing different USB devices, phy handles controller reinit for each
> step. If treat XMM6260 as an simple USB modem it will never init.
>=20
> One more benefit of having PHY is that modem driver itself is generic
> and PHY handles SoC specific configurations required by the modem.
> Since this modem was used on a variety of different SoC's (Exynos and
> OMAP for example) they can reuse modem's driver and provide only PHY
> which handles modem interactions with the USB bus.

Without any registers here, this is not a PHY but a power sequencing,
just like we do for other USB or PCI devices.

Optionally, it could be part of existing USB phy, when configuring it in
HSIC mode, but it seems you add here supplies for the modem, not actual
phy as the phy is undefined.

The problem is that in the patch and explanation you mix driver model
and driver behavior, so I really don't know what is this hardware. And
it is not my job to guess, btw. A partial argument/proof why this is not
a PHY, is that you reference the USB in the node, so phy-provider
references the phy-consumer. That's reverse. If this is PHY, it's USB's
HSIC phy, thus this needs to be referenced by USB.

If this is power sequencing, then it can be represented as USB device,
just like we do for all USB devices, but then it is not PHY and
phy-cells are not appropriate.


Best regards,
Krzysztof


