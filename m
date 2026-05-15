Return-Path: <netdev+bounces-288237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IhvEMzbBmoxogIAu9opvQ
	(envelope-from <netdev+bounces-288237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:39:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0E554B83B
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7B3F303B806
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50777402B9D;
	Fri, 15 May 2026 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6af3o+k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7217A346FA6
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834269; cv=pass; b=ERRtMDyu6A47zYzWLnijJSmQSk2T9P7CDTQdZ2Vp2PY9/w6Ouai7loVwiNLOqB8hskakK3gbbKCd/c9OyCs4c2AOENCJC11AJSy3txKg6X957PoU1Uhw7EeuH7yCDOa6c9DPb6Z2EuzTEUc4SKNY0/rMHzEZb63zf32H2TMusEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834269; c=relaxed/simple;
	bh=unrCV9BlS+NT2H9YcNFBIBdPF5SnAoNci8LrnilLGqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9oOMgTd2MsBxwZ6dpuC1vnlFP03ledJmxfwckUeHblxCnzn2fM3PBD7FoxT6JoIBYE2gO+q1d0jstB2+Qf3igOyZk3QeWZWiyxKS4o/8GQGv/S3lT58FuGiVfnKm0vABkuh6OMzgaeYpb+S5sJFuCiZeTwYDUhCuAlIr5pVHxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6af3o+k; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30246cfd41aso3784045eec.1
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 01:37:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778834266; cv=none;
        d=google.com; s=arc-20240605;
        b=g8qAvd3q1d2VIMtbDk8aOZMnoF6NvKxlRcbySIAZXRlddpmrPydZvZc87rWZe6iaxh
         FTSMpDA6gEj/vWWSNI4V5SuFxJPuTx9c3zVD8Ok1HQRblqji7Qrq8EQ1y3tmifGJFkRj
         kfGLbB1/VOir+L4l/FrVPmMRFKj4KLluexIeiujCPX/GNiza6rC+LMj77SWqlZp5oJWt
         v5rmR+NLlbV7NkLKeKX8lTe3gxyRLw3FWdi2aLjuwvFJvh/amKLyH9kDlXFRDPkaIQ3v
         5M04PyoKJH5b0lSVCB70yk3WOjRY5v/hclk7mOBR+hpEumC7NF1IphhvTTvKIhB+oubl
         5trw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Me5hEq/uVA2vry/WusH3UXPaCOwfFKJKOpGLMOeOsm4=;
        fh=lT+vLTziEnqFn+3Bb5g/xccxDHliMDO9A/H10eoB4D0=;
        b=H9hLzEvg5RLYzC3hkfwvHwlq0g0O9naBx1WYh0++m+G0cW4xzKfYHcfT2OU8XRV2LO
         PhLS/ETWgdoXu2fiRBxi2YSBgggtI9gAJcYWBZcX5tVDzTZi6frr6ZHurgDlUw2r17rQ
         Hn/DjoZnfxbPafVlhbaw6OOrAPNrlVg+7oy+yjuE5ajPganzIEl4iuZVYf1oBuf3Z9g9
         a/3G+LNEVNzq7dm2qndvzn2V2lK0sLVM4j+ZEr4kQQyrYGvXs2AQVB556pJ8YgioWDsE
         /z45xnOTJYggb5KA+4BdRs8pywCfq3JT5EYloKQTNI+RD3HzLORuw6yxYPNOLg/98M26
         Z+WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778834266; x=1779439066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Me5hEq/uVA2vry/WusH3UXPaCOwfFKJKOpGLMOeOsm4=;
        b=J6af3o+kBsvRvTtp5InCk67+NlrHIgODsJqzwPQ4eeD/BCnyKtt777pgo+ofAPURgL
         HzF6jMMLQnZwqvEoSifIHHtDcnqLkg6tfXFJUMNbt9wOlNkvosQUL6rDxtj5EHMRtLiW
         ZSCWHveKvVYdi/LPIbok9bDg3toxM2bFzpJqtF51ebmOrU+3nQM18F81oojcUr+8CwcR
         NKVd7SskLjzvNNJ5ePGlIbeneLV81gyGLhDuLs0MTDHogUxdE/GLW6nkBHrybnLzlgy9
         HPz0FxaBnNMkD7G/1UMHm15/7xFBqsuWpGyGV03ic1+IxCMQw46To/ZPmsY8SN2Xg4oJ
         RrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778834266; x=1779439066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Me5hEq/uVA2vry/WusH3UXPaCOwfFKJKOpGLMOeOsm4=;
        b=YUti6WzTtlOFZuZm8wXNwPnAijyjrEHZwIqoMNkGu1b7OroTFZfBjHKhzSsgSvAv2F
         SmH9xqwAxkM2kdctpgzNqYPOMLvYWEL0V+iYMHaxlKr04EhOHhznWX7ZLTyuBbOvtMzX
         fCczD2c8MxVeq0bPJ2TSXBkZ8p0mPDn9IyxU63Ts+6Rz3y5LJsWe7ua9fl3W3GfAHYMl
         BxPO5VzVEXjq37UhKY4Fr9khn8cixXUT1tWDmSS58FrbzybKFOPh4Tu/dogJRGBCXUzD
         RuQI7q/IfwWunscIWbOl0mfuuIfBvDRZOAZZsNf3zWN23IvK9GR9K9wT7KbvJRuqmOXi
         RJyQ==
X-Forwarded-Encrypted: i=1; AFNElJ8rTEI60tarBedpkrV/YE1BA8sQZTU6rqlfrfqLVwOxcKimEu4NWIIi8Fv1qXS/tZlGG/Gk8Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxelM2ClZo9Xsn1a/gFoElxiekOmeDtHVA7DnDQYrGYi9hnSVjs
	f1qHLASzGd/MHwIxsey1WH1TG5kuwZxozZISj39++6o+WwZuVnerbqoVGEzpH+A0Ftf48CLCwoH
	M3Wnltr009LAH8ONRGI1IqpqIHXxderU=
X-Gm-Gg: Acq92OFA2NoMcjj7FjaCW6C9dUgR6jqgmb1vtN9xFZRcD1Unq/ujaCY/BubNlyI9WMY
	nLduFJiDtthX6OvyHW7duXSehpgsDGnSBR8VYJGzoPOyfXHx6tkkzDNV7oUQTcTBtIXlr0ssVRx
	ChAIedV5oMxFAva7br62StfIjyTbuzRoR3/vSWWf1WSjvoQSNlI27yAJ+M3IErGhNFjZYqDiyVj
	BTxQomqt0V1BmiiZ0Y1LicPIwRAabh40893AQHPrDbApoDYh58DPT1cBdKIDQ2BTXa22Si7Ps6c
	PoVGYT5Z
X-Received: by 2002:a05:7300:fb83:b0:2ed:ff78:2c12 with SMTP id
 5a478bee46e88-303986b7f00mr1545456eec.34.1778834265492; Fri, 15 May 2026
 01:37:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511135703.62470-1-clamor95@gmail.com> <20260511135703.62470-6-clamor95@gmail.com>
 <20260515-utopian-malamute-of-patience-367e8e@quoll>
In-Reply-To: <20260515-utopian-malamute-of-patience-367e8e@quoll>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 15 May 2026 11:37:34 +0300
X-Gm-Features: AVHnY4LfeFEmg-csCdRMVtN73Y-dqI06XuWSB80BMJnQTmRPDx1qbsh-tCMg8j0
Message-ID: <CAPVz0n2wrAdU0JKx7eb7uosCcoGayqNchK591VPph-5_nBAMXg@mail.gmail.com>
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
X-Rspamd-Queue-Id: EB0E554B83B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288237-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

=D0=BF=D1=82, 15 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 11:2=
0 Krzysztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, May 11, 2026 at 04:57:00PM +0300, Svyatoslav Ryhel wrote:
> > Document the XMM6260 PHY used by various devices based on the Nvidia Te=
gra
> > SoC, describing its usage
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../bindings/phy/nvidia,tegra-xmm6260.yaml    | 58 +++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/nvidia,tegra-=
xmm6260.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra-xmm6260=
.yaml b/Documentation/devicetree/bindings/phy/nvidia,tegra-xmm6260.yaml
> > new file mode 100644
> > index 000000000000..0346433c9772
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/nvidia,tegra-xmm6260.yaml
> > @@ -0,0 +1,58 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/nvidia,tegra-xmm6260.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nvidia Tegra PHY for XMM6260 modem
>
> XMM6260 is Infineon modem, so any combination with nvidia,tegra is very
> confusing.
>

May you please suggest how to adjust the name then? Thank you.

> > +
> > +description:
> > +  A hardware configuration used in Tegra SoCs to provide proper intera=
ction
> > +  between the application processor and the modem, as well as control =
over
> > +  one of the SoC's USB lines for the modem.
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: nvidia,tegra-xmm6260
>
> Also here.
>
> What sort of phy is this? So far looks more like a software construct.
>

Infineon XMM6260 does not work as an ordinary USB modem, it is a
standalone CPU which just exposes itself to AP via USB. In order to do
so, it has to have control over a USB bus of AP which is dedicated to
it. In case of Tegra - XMM6260 interaction it looks like this: second
Tegra USB controller is set into HSIC mode and is dedicated solely to
the modem, modem controls this USB bus. Then the main XMM6260 driver
performs power and init sequence and once it is ready it calls phy to
register controller. Phy has its own supply, controls USB controller
de/register and using enable GPIO sends signal to modem to proceed.
Additionally, since some XMM626 versions have a few steps to setup
exposing different USB devices, phy handles controller reinit for each
step. If treat XMM6260 as an simple USB modem it will never init.

One more benefit of having PHY is that modem driver itself is generic
and PHY handles SoC specific configurations required by the modem.
Since this modem was used on a variety of different SoC's (Exynos and
OMAP for example) they can reuse modem's driver and provide only PHY
which handles modem interactions with the USB bus.

> Best regards,
> Krzysztof
>

