Return-Path: <netdev+bounces-289283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHt5Gvb/C2pcTQUAu9opvQ
	(envelope-from <netdev+bounces-289283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:15:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D002577CF2
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96FA73036736
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D15437F743;
	Tue, 19 May 2026 06:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0xIF9nJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA26D37DE98
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 06:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171312; cv=pass; b=V+uQwwB1RAW7DP6wLNIXEIPk1yMyytNOGgIOYqCp7IBw3mEo3JkhmkGWu2C8zpYUqBZZAq9dV+ARsXPiqWS0XboQy55gxQAEzWvnrQbPZ+3JW89TOYr3L0jQ6z7slgwMYiqWxi0TZ879NYNizDrghSAmWWBVZ/HBdDrRQcSsP2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171312; c=relaxed/simple;
	bh=QPv9NrKqks25XdbSHhPFI546BElb5U2rT+BiAzKQ+7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fe/MGyBKYa4ZZSAmji2c6Ia2TN1LP+Tx83iOJK5JE0o4S+FcYZ9Z/4q2RWBQfj320rg+v+EJsX65LMoANM9WlnOhhR6cjPhc68EXGOeLaqFg44OiAIaG5eeukMSpR7mjbU4vHJdzLf2jvOlnQvt/DbIz1jl6ZNI84wEXvi2yZPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0xIF9nJ; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so11935150eec.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 23:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779171309; cv=none;
        d=google.com; s=arc-20240605;
        b=Qo9F4zK1pk45DTsTRx2Sp+UFV00t9rCFJe0ncSRYkOa1rFs2nE7lEjCT+T7CpO25nL
         DuD7ETdjsJiIw6wivuSIgvsOrSMlJn9D8HNcfFZSHv5/juo0+dxQMo14FGBWPknKzTWd
         xEWRJS3lDVrjCQH/SeAvLvTlb9VacHbmQq6gJ01M5JXSLJ59QXIQxugzop87mD56EV/D
         v6QnEFhY2ueRU1c0b09tBMGMWL3XIeHnJjE4yQ9Scj29jT/evVcRPPuKhWOwPULVuGFo
         l+01LMZcE2Ouv2OGcv0vfO4ZPKhFqEwfnDv7dBgxksFqXAPvmccsRXjXyh3JP+rsycQg
         i0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e3rxUJ/0l+GpFnRLs/exHMJwdlcSweb1iM7tuoW5l3A=;
        fh=sS5gd3bJ/HBPRrbXBH6fX72vb3zXhVR1dYzlLNncIhs=;
        b=DtUZXkkFGPP9Rgl6RB0j/IkbBWFyTOW3TU9/ahoce/up3SelwTwzsHJZruqBZDa1zF
         3C77b2AZkzpcWqygHTcB4nsLO/CXi89RYWCWLDvyyk/J0xmec2/0jZOQFn7B6jxqIp9F
         Zk0J01Hn+4x3iXm4L4AC3JFDBT+nGejl9QHgMexbN/l+l3Gp9kALUDl75Jp5KuZBlsUt
         QRub2g2Sgo4LWvf/yPiRDFoO280GWEAGTTxRXMZsEMjzy3CAsLCuqzCkXz/QOb+XjQYD
         auqHcoVnchWoQJLtMtceV5Kqb08o5iBl40d9r+VqjiA5QXF5LPF9jHs7jXY3hWkYO8BO
         9r8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779171309; x=1779776109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3rxUJ/0l+GpFnRLs/exHMJwdlcSweb1iM7tuoW5l3A=;
        b=K0xIF9nJkPkPRVvHiSwlUbkwOna/D1U7CNVoC2deCiQWXFHenpjXwiBqd7Bie5r6fe
         f0s1+5TexX8TcakVB9gHtxoPgrwxm4OhTInS+wgU+mftW3dCw/H37e9b038U+6FwD01K
         dSVH+FVkOdKXctiGcv3+amRo9xlhA+zwudrZHN4ZjF2BFzHCg+Es2NwVu9AHsSxWwawH
         IO0GT42qOuSSHbSNs7Md4qBoSck17yZoG7gVmwcst4LlV7TXLiUnHAK9XXDMFClAzTCx
         1Oh+2vneMPrJqRQwxynJvAXSK1oxcHjHt6rIdtCch1ca5pWXivYNbPO4fmIlsvFgsnsW
         ig2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779171309; x=1779776109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e3rxUJ/0l+GpFnRLs/exHMJwdlcSweb1iM7tuoW5l3A=;
        b=Ez7Yuzpua53ihZe1F0/sYCkX3q9KM7DWtEkxQpxC21LSFCp9vqKmBvvsOJrtjzysva
         oZHcXbavwaxEBSZUtSfzWDx7LbrcRx2Tw0itRnAcX5cZbQqINjYtwT7Q+R75ZMdROqqz
         Dqr2bwqG9ZxKE4/fWKJVC2CPkQogK5KxPApfbQI7DPS4OM4/4FspQKl51/mNpu8h8TfV
         ixItEAs2mioGf2HTiS/3zhSWme37jVt25Hr4P5QHb0y+lQcEMtRdmC1cXQs7I7r+j6TV
         mx8BOPof/lAHbtah66jmKE50lexxa9mDbvFYDSnTzkcjKj/4o6cO5ctfNpUYbBCkErGg
         0U2Q==
X-Forwarded-Encrypted: i=1; AFNElJ93NR6GhyX+kTQLnvJNOPW6hilOt0Aa47zUJuxnh85S5M6N6L7JLroG45OWt8/56ggqeOph4Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHw6rY/wWhrjWTDOtv11l/6J/eG0qrv37XmDby5+4TcxwJHrRw
	9P5lGSor4yp9VqejutJUh1miY/v9yZjRPj1TRwErNjW95/zxKi+MatUhlt2ZufZo1KH3r2yPCb8
	x01mbXM5VmCBJzfyodJfkiCYs5j/O3YI=
X-Gm-Gg: Acq92OEsLk1zhBESG/SGpeA0iqk3HhhFXc+b/yoP+2dxgiMI0rAHr5KIj0Z3CvKt61v
	u/2IkWWaL86L26d7fgSDVfub0n9OSF0hl3GPWdtlny7WGNBy4ff8EFZiQlwzT5TswA0+GVeuT2b
	i2G6qz4v3K2EdLARaebpstYiOCrmfNvquaOc+i7h+sqnR5xlxy2XEkmeuON5/5OMXzMX4PWiHzP
	emRWprjxv81z0lYhbcoHluo4WVsHZobPWP6iYdkYNDsQfsGSUHWUXasvIAHz7WO/bz6OCXEuwEZ
	40uFTflB
X-Received: by 2002:a05:7300:a984:b0:2c5:b23e:48a9 with SMTP id
 5a478bee46e88-303986a160emr7175515eec.25.1779171308865; Mon, 18 May 2026
 23:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511135703.62470-1-clamor95@gmail.com> <20260511135703.62470-6-clamor95@gmail.com>
 <20260515-utopian-malamute-of-patience-367e8e@quoll> <CAPVz0n2wrAdU0JKx7eb7uosCcoGayqNchK591VPph-5_nBAMXg@mail.gmail.com>
 <20260518-mustard-rabbit-of-ecstasy-eed3b6@quoll>
In-Reply-To: <20260518-mustard-rabbit-of-ecstasy-eed3b6@quoll>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 19 May 2026 09:14:56 +0300
X-Gm-Features: AVHnY4IxlqAJY6NaFP2GVNqF_snPzx1hM2RZ9fLkqEGHKp_bJ_sC8-qzf4i8pFA
Message-ID: <CAPVz0n3C+g9zLaq9gN1OFnC=19oRwoZon_E0q0oFKbn-dG-FaA@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] dt-bindings: phy: tegra: Document Nvidia Tegra
 XMM6260 PHY
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Chen <peter.chen@kernel.org>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289283-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0D002577CF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

=D0=BF=D0=BD, 18 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 15:1=
4 Krzysztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, May 15, 2026 at 11:37:34AM +0300, Svyatoslav Ryhel wrote:
> > =D0=BF=D1=82, 15 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE =
11:20 Krzysztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Mon, May 11, 2026 at 04:57:00PM +0300, Svyatoslav Ryhel wrote:
> > > > Document the XMM6260 PHY used by various devices based on the Nvidi=
a Tegra
> > > > SoC, describing its usage
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  .../bindings/phy/nvidia,tegra-xmm6260.yaml    | 58 +++++++++++++++=
++++
> > > >  1 file changed, 58 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/phy/nvidia,te=
gra-xmm6260.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra-xmm=
6260.yaml b/Documentation/devicetree/bindings/phy/nvidia,tegra-xmm6260.yaml
> > > > new file mode 100644
> > > > index 000000000000..0346433c9772
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/phy/nvidia,tegra-xmm6260.ya=
ml
> > > > @@ -0,0 +1,58 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/phy/nvidia,tegra-xmm6260.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Nvidia Tegra PHY for XMM6260 modem
> > >
> > > XMM6260 is Infineon modem, so any combination with nvidia,tegra is ve=
ry
> > > confusing.
> > >
> >
> > May you please suggest how to adjust the name then? Thank you.
>
> Depending what is that. Start describing hardware, not driver behavior
> to help in that.
>
> >
> > > > +
> > > > +description:
> > > > +  A hardware configuration used in Tegra SoCs to provide proper in=
teraction
> > > > +  between the application processor and the modem, as well as cont=
rol over
> > > > +  one of the SoC's USB lines for the modem.
> > > > +
> > > > +maintainers:
> > > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: nvidia,tegra-xmm6260
> > >
> > > Also here.
> > >
> > > What sort of phy is this? So far looks more like a software construct=
.
> > >
> >
> > Infineon XMM6260 does not work as an ordinary USB modem, it is a
> > standalone CPU which just exposes itself to AP via USB. In order to do
> > so, it has to have control over a USB bus of AP which is dedicated to
> > it. In case of Tegra - XMM6260 interaction it looks like this: second
> > Tegra USB controller is set into HSIC mode and is dedicated solely to
> > the modem, modem controls this USB bus. Then the main XMM6260 driver
> > performs power and init sequence and once it is ready it calls phy to
> > register controller. Phy has its own supply, controls USB controller
> > de/register and using enable GPIO sends signal to modem to proceed.
> > Additionally, since some XMM626 versions have a few steps to setup
> > exposing different USB devices, phy handles controller reinit for each
> > step. If treat XMM6260 as an simple USB modem it will never init.
> >
> > One more benefit of having PHY is that modem driver itself is generic
> > and PHY handles SoC specific configurations required by the modem.
> > Since this modem was used on a variety of different SoC's (Exynos and
> > OMAP for example) they can reuse modem's driver and provide only PHY
> > which handles modem interactions with the USB bus.
>
> Without any registers here, this is not a PHY but a power sequencing,
> just like we do for other USB or PCI devices.
>
> Optionally, it could be part of existing USB phy, when configuring it in
> HSIC mode, but it seems you add here supplies for the modem, not actual
> phy as the phy is undefined.
>
> The problem is that in the patch and explanation you mix driver model
> and driver behavior, so I really don't know what is this hardware. And
> it is not my job to guess, btw. A partial argument/proof why this is not
> a PHY, is that you reference the USB in the node, so phy-provider
> references the phy-consumer. That's reverse. If this is PHY, it's USB's
> HSIC phy, thus this needs to be referenced by USB.
>
> If this is power sequencing, then it can be represented as USB device,
> just like we do for all USB devices, but then it is not PHY and
> phy-cells are not appropriate.

I was looking into power sequencing and using it instead of phy is
perfectly fine for me. How I see XMM modem configuration:
- main device which handles most of generic power sequences,
init/deinit and detection for USB device (both, target USB device and
intermediate stages for fw loading)
- phy or power seq, does not matter, both fit, that performs
manipulations with SoC specific USB controller in order to ensure
correct modem boot

If I use power seq then modem will require link to power seq and power
seq will work with USB line, this should not create confusion of phy
acquiring USB that is phy consumer. Will this approach be acceptable?

>
>
> Best regards,
> Krzysztof
>

