Return-Path: <netdev+bounces-289029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NMrLXoGC2rt/QQAu9opvQ
	(envelope-from <netdev+bounces-289029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:30:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3153E56CAEC
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 325613040027
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5544F405841;
	Mon, 18 May 2026 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3jeF28S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812A54048A2
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107036; cv=pass; b=ujHb+SdNMU1NC6GUwtM9zydA9Mc32roOr48IJgLv2WcsswEfigzgjiAElre7ZienJmIrkE7L+v2ox3LYNmyb8vPTHrplpdzik+IB50IBgGkv1QajrT1229GuGvgg5XJfanX+lN9veq1zf9qx/hSVRmGG4JUmZoE+iV/s+IjI0TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107036; c=relaxed/simple;
	bh=fSU/Nv50gQUXxxzoYFAghpmKq4w9ZnFqkSDSVnIbHqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+Fz+GlUxPuYTUTUctNMGa3nETvGjDmrvSbOCZAD1JgSkyWb/6eofY0OElyfdOQSYmTIiKCpEQ97sO6QZCuepRXsTXPOIrc3KntxHWwRfMAk2ufXA5HbL7WK3tdKy38nuUPlt9Jl/ANJl/DTGnKyacHJtZ771h2csYb4vzVHvWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3jeF28S; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ee1054627bso2108174eec.1
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 05:23:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779107034; cv=none;
        d=google.com; s=arc-20240605;
        b=Yg+mxw3Qt50ponlEyEZZ4qXQ4ePIjZfRMb5wtSV3NyNERNgFN/TbAGflNVe7dOr3zJ
         uuJEUAO96G4X/9V5a82lHcel9V2+rDBXOhytj+4okUECpVfyrJCRzQGthhXbndn+zf/T
         0IiLE0Bqg8jwQF17hmvLb3l1IhROSiq9SD6yOpoACYa7KWCDJECl+dzfdeCa/DORRPL6
         ZBszhjxu4iouZM3qyxrpEsDfi+Z23g9hVTFj8o4nAHL8dBe7A645Q/zPhMJcv/lv+KOE
         bjctb8N85PUyM15jXDXy5r+No29JuUE5GLSxIc81aiB1FvVHWjppghGS/AQVw6QXnkRp
         wF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/sybBoxzQkI8aLI6NqXXkb4wIzeCWahvMKbXOpYmLoU=;
        fh=hvvnkMkZ7MbvzEMoY6Sk6XJZbvZdS5O2iyrzO0Y6jKc=;
        b=DjrV5s6Tb1NFLggeYnXpsMAFp7YhrRfb8SZcMXrprWuEgTo867xKekk4cBmnYo5xjs
         LG75oKMQzfFpXiZnhsTTmRJuOGt5ATN/Ne2YJyHowLxFqDPNfDCJHs8q6Bv5Mls+m4tO
         2aMqPa5aTsqsMvJAzMPY8jtSXdqrsduVM9rNVyw9Ftt5TqNgkgnt8JmmW0CApa8REVY8
         W25+s0Lmr8y10m9aRZzy0HUuAQqk6kD5Csz5cqM9lnplcKsg9df+X8jxBNUOBKttXquy
         PMpIdJ9vvZxLwgswzLGFhgnl3rkf5Vm0OoySqrVG6Vj+hzARhgvAiNAt6ebwook7m2FW
         79ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779107034; x=1779711834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sybBoxzQkI8aLI6NqXXkb4wIzeCWahvMKbXOpYmLoU=;
        b=m3jeF28SK1CuzUt6M+4OnYzbZvIx8KWEaXA2AEFiJxgjbZFS3PMv92wVmPBPeomoZs
         6CMZshDWsF5YHjqWxvbWvfyrfoKXLZJQKbPKvuB3i1xspRGhidOwFGRigBptY0UOAG+a
         ruQAgwaL9CDLIkj5JsXs0yvxxT6cM/YOYuIpKhOVUb+FKLCYoyaxNMf1+Ps+1Tf+uPXz
         7+hgjYw8XMuNidGEPADXGEwqpMP3R81SrYVEHu1XrLNfqlsvPZf4iVGp35M69uKerlbe
         HI6ZIvF4xza+W7nGjepPYeYYKZa79VxIqb7rAEoUkm4ZyQPVVVdX2IDsc7TpNNraI8gZ
         5SNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779107034; x=1779711834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/sybBoxzQkI8aLI6NqXXkb4wIzeCWahvMKbXOpYmLoU=;
        b=SPSjqPtUBG0EK43TejwFlK/46CAidnhuY5+QoUhKF64FY84QjihR7KamO4A4eoIwO5
         H42leFU8TKN7j1ZDVu8ONz/y7Y9vAmtDoNMS0dd5/6ykuYHiG5C6563QtH8Iz+X+8Fvf
         TsMBKCFXMnpzO98mS6w5QnixOEjniqAoTljCO3gCcczmFHtwtmVXnf1hxuIJl258sKwa
         +ri1GAxr4Tkx7FCt/ovVM/M9UnAd8hRCjkpccw5dC7jqHspE5yDswrt4wlXWI437erGd
         u4Nyfo1+0fNeY193tE0ygFrK6iNwNt+FGQXZHzXiuc7AktNeRCejiCqN+MpWsnSTQ/8g
         tT2g==
X-Forwarded-Encrypted: i=1; AFNElJ8lUUc2zZlWli2zWNtvKTqa9szEseSpblXfRUeC6WJxeQHcjG5rCR4Cu1rlQ0WFtXqHkzEfsvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNMlTILaUw72BMtxLdIl6zvFxe31lkdjKwqnhVs7j4p1O833yo
	YBqHfI11n+0e2IN0VJkxOQxGN+OYkptmyGOcA9Uui6FviJHmw7MVmN/kfrI4I8vx41Wyq11uZiP
	YYmvghixF7CZ427zYjtDQb7pIVU5nFSY=
X-Gm-Gg: Acq92OEPHqRpufM9pEOTe9Z+RAXTpxBLFSY5N0GpbhYSmtO3/xwGIIrr2SYC1JHn1Az
	GHOY4CpGYn4YvDNg/o0x5gTQBj34nM7PSM50L3q3WbR6KEwskEzKk8IfqlNR82s0DkJL8ow6BLf
	UmmanE6IyQin4a1ZkEeyxgfcxSx/lvN3cqOE7NtSu/4EmQnv/FRaL0khU15dpEcHehfuh90sVVl
	DRprMrubQ1He7OwkohefC0zahtLgEm30y/PNkU7J2EJLh/H5TPk7mVyycdrZ5VAOvQ4HwgiTuhD
	42Dz9wb7lKorB+rND9o=
X-Received: by 2002:a05:7300:a897:b0:2ed:a58c:942 with SMTP id
 5a478bee46e88-303978ad90cmr5911766eec.8.1779107033494; Mon, 18 May 2026
 05:23:53 -0700 (PDT)
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
Date: Mon, 18 May 2026 15:23:42 +0300
X-Gm-Features: AVHnY4LNwA3nH_QM5Y-7LcPOdghwjQLoGIom9Y5M5xnInrZ8XmypJBIC54V587Y
Message-ID: <CAPVz0n1Q_5WYAE0GKzFA1SpW55GS3dCLgxcMzw-nOEMaYobn6w@mail.gmail.com>
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
X-Rspamd-Queue-Id: 3153E56CAEC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289029-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

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
>

If I integrate USB controller reference into the modem, modem will not
be generic since Exynos and OMAP don't use Chipidea USB controller
(both those SoC use this modem). Modem has to control USB controllers
init and deinit in order to operate properly. I have tried to resolve
this with PHY but if you find this inappropriate, maybe you can
suggest better suited way?

>
> Best regards,
> Krzysztof
>

