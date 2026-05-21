Return-Path: <netdev+bounces-290609-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mO3RL2ltD2qOLAYAu9opvQ
	(envelope-from <netdev+bounces-290609-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 22:39:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 642BD5ABD57
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 22:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9340300B59B
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810D6407CD3;
	Thu, 21 May 2026 20:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7+Q7yPH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C469E335066
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 20:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779395942; cv=pass; b=H7OBCwfUSfBVSWmUpDhbvAWcxWdSS1SzRv6CDpmCEadh8xT+NLHj1hZxbSWJjxw9wjbp6k89dHrzRMQlOvBO6uflDopxxfemd8cmPNXWnDSMYm5JDJCbireqHvofbLV7MvscpiPiRA+pVuOIO6I3ILL+K1Va+8gWxiKqqsm5wc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779395942; c=relaxed/simple;
	bh=7WguGWw3OMqpoY1uNfi3T8L8p63iIWg1hfU/ZsmVvjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBQCX5Gcw6jMdFEoYb0ZOCn9dsnKRwSjx4UCl/fd1Y6nDPgeSVoxCTPNzRoGvT4ItfqsX+RbzhPlqnKI58Y414EBL5hsR4ZA7QtgPAbeR/7bKVleYqpjJs06SMTQjm5JoNim2Zyez6hqgx1LbLVFSzlT6rTiwlhnKPqrt07ywnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p7+Q7yPH; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bd3d7c29b4dso976096566b.2
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:39:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779395939; cv=none;
        d=google.com; s=arc-20240605;
        b=fk1nHx1mgRlI0DVhDfw1vbQUbdGr7PZJCzkaaj1BsKztKsqLdvcmQYOfb22JT0KgSo
         FHfhtVvpETWZcJVMx6gH6k1p2POGH5a1nR7ZdtTd2kpizCibUe3Q7XomidccH8H4XuK2
         sTTq6h8EHjtdz6vvhOy9NxsDZ6S2kaKwaz4HB+2v8waJWKWCXJMBYNlSt8uJCdQH3r+r
         l5EFXC7fbc0/NuW3Utb3cywVyO4nhe1AeR6SEabempJJFAv1NysFTVozB51d+x+GN16l
         8eQh/JWsgqLdoDNGLxrzplepkPvCPQS2cIjfSp+kK2sVECSHusuji4lh0KRR3lIQLZNT
         vOHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fW1oXwCiens3FCanTelYWJicgu3a4rD4BDnCOzooE1I=;
        fh=dDcLI9Oy8UOEuPx3aWzLkAiulA3MYhPSUB7C++EfPvw=;
        b=FyEO7OZa7mynhorfZ62H+WSwlcOslJ7hnMOrWKp5k1xMRsLho7iKaSm6YE1ZlRwzk8
         5VrmQQ7pJmsosOHCEMAiflJFUvCjD553bc6XCTpf4G6GYRR3QkM8wFCx72CTJoQDCwuL
         ekn4FA54/PsjQfgok7XUfguAyrb2QsHrEkzFpUBJ1b1QKd1E2DTJXNLjW49kuars8R3s
         GbCbPy80xtZAQ/j+8NSnOq9m8PtHaNNicqGBQIVcu/0X/sFUKvjuWQPb70Qp5NNoaHRW
         /2XePLPYJ7qblm2cmBtx0fXYOBVHqpNUwCnpvHtRu9rsN+tTpxElhXIFJwZKgBVK7gY/
         /EFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779395939; x=1780000739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fW1oXwCiens3FCanTelYWJicgu3a4rD4BDnCOzooE1I=;
        b=p7+Q7yPHk0wEhCoNuUDnK+EncHe+ssHY7YE9gd6+b8quQv1QeXgGjsQwddb5fiJlJT
         Kqzkgny6n8Cwg1zLRoyREKt2NETUCI1DGF9X/FuP15/5JiMeqpROqKdz2VjRjwAz8dU1
         bbUbD7jm5eDmqnJntl8X+AT8kmjbUHtKLeehJgVAKlh3BtfT3RYAtlibC3D7+N4aYvHx
         H9Eka+JLgLq5pAaJ+3PWvVLiHkiY9/Q+G4QHUiO11fddvRZisIbBhaFpYQXq+y7in7wD
         CT76YhHW2ZxvfjBz8AXMCfwUjkWq+JEIGaCZuNaztdwXyWvTx+SIN4V56KfCemjzPYQw
         i1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779395939; x=1780000739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fW1oXwCiens3FCanTelYWJicgu3a4rD4BDnCOzooE1I=;
        b=kSQ3PSQ4dUIegytmc1SuQ35Rvyk/2n3w/Fg+lB+eTRVWMBl3/4/cDwd7h80MO068kf
         VoyDQ0+mvkMa4Lh+AC7t94+l0CK8jCFdiy0Dh5ndhOepkMenQyJAA/D5stSX+aaSz+HC
         5QdYjEkafhdybXfI+KlBuesiCcWr8R3n9xxfNB97yji/vJILL4fnBZdb5tRyswEC1Rwm
         0+DD8Dp4cf8ZSALhXb7yf6Bu8UrXEUexXQViQGkb2AgSu48+Hcgq/8vYholGa+48S4vI
         ZDF93gN9chAbnFiWqbA1dlSlkrwSBWACcQCFL0GGXSk8big2MrFcr7t96owL726vCmvH
         tC8g==
X-Forwarded-Encrypted: i=1; AFNElJ/HRbm8qxvl1DLwFsikZCWwz4q3SNm3ZDcWYrkLCYT/JBUFwRMMqRODlfworXgr0Idb4G36r6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTMkJZaBay5uxDopR4Q76DiHsI4SoEqrMVQ+noRCCMSw6vyS9d
	mKkQOGyK2VnsEmHCn0P7lkxf+Cb1nj4nxoFipCspW67r0D/Yoxwx3LwBDfRDaQb1cSeuNQ9Jx3C
	SxVY1hl/GFcbCxMv5N0iiFisNP0vRTA==
X-Gm-Gg: Acq92OHd/9kqXhvIU94ZB0z8kAcQz3lbn1zUZeobYC9qelGxG0zWlIKCUPrq14Q3hnx
	QlH5jerEYfPZV6o7r9xUKoGIJsAc+MnWW/nUrNOvLIemaxRPCzqsfjFvBEYwkLns9z0VPDBfLm5
	9I3lZ6BSpa7N/4ruCwhsHnVX+85ETWzSPVyHNOB7FcNtbRoOLFhWWxJaACECY2NkhEISftB+9tj
	Q7oGwgGbPhWbcMbOCW8ecp2Vl7ZWOKzQ9u+J/AaoS24EVQM6ZMlQ7zJYX22re7MpumfXhjLtf9o
	WOQN7gaAOsn1Mg==
X-Received: by 2002:a17:907:928a:b0:bd2:fcd8:4cf9 with SMTP id
 a640c23a62f3a-bdd263c932fmr54408966b.41.1779395938847; Thu, 21 May 2026
 13:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520191943.73938-1-arouhi@sitime.com> <20260520191943.73938-3-arouhi@sitime.com>
 <48cc27ed-48e8-41db-8351-166774466a69@kernel.org>
In-Reply-To: <48cc27ed-48e8-41db-8351-166774466a69@kernel.org>
From: Ali Rouhi <rouhi.ali@gmail.com>
Date: Thu, 21 May 2026 13:38:46 -0700
X-Gm-Features: AVHnY4ILigC8YCZY8euCoRmiEe_rpzQc4MgyNgFRQqdyzkCC81wUGU1H3Wbu8Uo
Message-ID: <CALFSGupB_eRHQ=h2PzwiLE1gTvd7kZbBP+eWOVWVxapVjzgeXw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/3] dt-bindings: dpll: add SiTime SiT9531x
 clock generator
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev, 
	arkadiusz.kubalewski@intel.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, cjubran@nvidia.com, Oleg.Zadorozhnyi@devoxsoftware.com, 
	devicetree@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ali Rouhi <arouhi@sitime.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290609-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.68:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rouhiali@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,devicetree.org:url,sitime.com:email]
X-Rspamd-Queue-Id: 642BD5ABD57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Mismatched DCO. Use consistent identity or fix your commits.

Apologies =E2=80=94 Gmail's SMTP relay rewrites the From header to my
personal address (rouhi.ali@gmail.com).  I'm working with IT to
get corporate SMTP credentials so the From matches the Signed-off-by
(arouhi@sitime.com) in v3.

> Same as last time. Why are you describing drivers?

Will drop the clocks description entirely =E2=80=94 maxItems and
clock-names are sufficient.

> Drop node. Wasn't here before, so why did you add it?
> Drop.

Will drop both xo and xo2 fixed-clock nodes from the examples.

Thanks for the review.

Best regards,
Ali

On Thu, May 21, 2026 at 12:26=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 20/05/2026 21:19, Ali Rouhi wrote:
> > Add device tree binding documentation for the SiTime SiT95316
> > and SiT95317 DPLL clock generators.
> >
> > Co-developed-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> > Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> > Signed-off-by: Ali Rouhi <arouhi@sitime.com>
>
> Mismatched DCO. Use consistent identity or fix your commits.
>
> > ---
> >  .../bindings/dpll/sitime,sit9531x.yaml        | 145 ++++++++++++++++++
> >  1 file changed, 145 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit95=
31x.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/dpll/sitime,sit9531x.yam=
l b/Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml
> > new file mode 100644
> > index 000000000000..ac88f2f0b2ae
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml
> > @@ -0,0 +1,145 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dpll/sitime,sit9531x.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SiTime SiT9531x DPLL Clock Generator
> > +
> > +maintainers:
> > +  - Ali Rouhi <arouhi@sitime.com>
> > +
> > +description: |
> > +  SiTime SiT95316 and SiT95317 are I2C-controlled programmable clock
> > +  generators with integrated DPLL for synchronization applications.  B=
oth
> > +  variants contain four PLLs with automatic/manual reference selection=
,
> > +  DCO frequency adjustment, and phase offset measurement via an on-chi=
p
> > +  TDC (Time-to-Digital Converter).
> > +
> > +  SiT95317 provides 4 inputs and 8 outputs; SiT95316 provides
> > +  4 inputs and 12 outputs.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - sitime,sit95316
> > +      - sitime,sit95317
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +    description:
> > +      External crystal/oscillator feeding the chip's XIN/XO_CLK input.
> > +      The chip's PLL Fvco is computed relative to this reference, so t=
he
> > +      driver requires a non-zero rate at probe time.
>
> Same as last time. Why are you describing drivers?
>
> > +
> > +  clock-names:
> > +    items:
> > +      - const: xtal
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description:
> > +      GPIO connected to the chip's active-low reset pin (RESETB).
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description:
> > +      Interrupt from the chip's active-low INTRB output.  Asserted whe=
n
> > +      the device detects a status change such as lock acquisition or l=
oss.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +
> > +allOf:
> > +  - $ref: /schemas/dpll/dpll-device.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    xo: xo {
> > +        compatible =3D "fixed-clock";
> > +        #clock-cells =3D <0>;
> > +        clock-frequency =3D <48000000>;
> > +    };
>
> Drop node. Wasn't here before, so why did you add it?
>
>
> > +
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        dpll@68 {
> > +            compatible =3D "sitime,sit95317";
> > +            reg =3D <0x68>;
> > +            clocks =3D <&xo>;
> > +            clock-names =3D "xtal";
> > +        };
> > +    };
> > +
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    xo2: xo2 {
> > +        compatible =3D "fixed-clock";
> > +        #clock-cells =3D <0>;
> > +        clock-frequency =3D <48000000>;
> > +    };
>
> Drop.
>
> > +
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
>
>
>
> Best regards,
> Krzysztof

