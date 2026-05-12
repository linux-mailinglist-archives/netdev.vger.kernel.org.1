Return-Path: <netdev+bounces-287289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAcJAd6OA2qo7QEAu9opvQ
	(envelope-from <netdev+bounces-287289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:34:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E5E5294CB
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 22:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2F9C310C824
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387AB3E1D18;
	Tue, 12 May 2026 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASOYamZH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437DE3DD85C
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617448; cv=pass; b=QoN2RcbYGIyDgucCdypEK/5XQJNaN/PW/aMGrCVCNCTX7i6+agFggjbgre3BKUXjw1TIZjm/RznG01SC41zNHPRT4OT2611Rbjr9eIxKwEvfQhdNlG/8VBfmzRI0N4lNSuAUnonRctv9wfLSFHbHcmgIRgjNxHU0djz6Zl81BBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617448; c=relaxed/simple;
	bh=zOIYQuKqDNpStO0ViGu2tf81RloMLiMv3PTIgfzmFjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=utjm/Bndj1wj5SBDB/WKO3NrZ8d3JLCIgHChwXolU1aFPgyLmbI57+xzrwlxqIeHh9hSSv6WTchHqpMS7vN+Ujsr5uIdQY1E53KmAT6ZjCELHdLUrTHsyGWKjd6253UJwuyIIF+3ss/QLZghaf7AmG55APzxiSsgHQCWwCuU3BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASOYamZH; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9d9971d059so880295366b.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:24:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778617444; cv=none;
        d=google.com; s=arc-20240605;
        b=djKN5j/hoKXKXTq+24xMiZmBk9g5yRLaMFqA3+zlJMwgbtVzwgKZtOaUNwqXds4F+K
         geYYv+gjAQMeWl+C4mKSZ+OJaPpSZVrZ/nZCWuV4tk4zhfR6yJuyXeEFRdhCgN523ClA
         jUuMr6rhf1OHK+83l3gmOgLcGdy0cxOHnDRJDUTLNceVv7gwgS3Xw9q0m9uc9biHK7Ht
         ZrC+fmPJg8+qBFPB+OfL5W+UG2rKlT47RUEQ2N0ry6BTPOpytfYTufr+uq8Nzyz+bHvE
         DBPAFFIk00c7q0mQhgq5EUo2jkbwNu07sBeAd+7zAEzBf/4vw8PF2/Xs2YLrNrVjSZPR
         Pj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s5NbfZo3rJwfoGNoC6qpeTd0z48sbM+qfi9cSxeF1tM=;
        fh=ItW+1DPmylrSDlzasrMgQGr97qo1tuWILNNI+UkUy74=;
        b=WB2HILvY2jW52te1jxD2qzVe9ELVwX1PkAaFZwcuvooVz+2qpdp4ezUDT2G1JDHOPu
         aoL1Q5rgSWkK4m5iN06EbyCKMvtEBk3PVqXYRV7tz3+mmaTG9adXK/rXsmP/btuEF0Km
         UbUN5QLvAjMZA9ha6yt1JkNEx+DIXicV4QEvZBso4m4gLcUikHr4XPMxrtnycCNUWWQZ
         Lg/BBwh8fc+EYU+huu4nAcTwHaL9Fo5gSOa8OlfzKm9gqEAqejZm8UuNgBQBcIGvi8ss
         V3CaTPRM4ewpVPkRpy59xhTHNtC8EbfATLaG6uZBjrMUYDWOlJF0IOd8tjoJWVjACD53
         y/CA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778617444; x=1779222244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5NbfZo3rJwfoGNoC6qpeTd0z48sbM+qfi9cSxeF1tM=;
        b=ASOYamZHqZPiLAWqwI0yx8YELqToVWlL8bsNLfOJv3OjHWlxuBnTq/axuxbopsTRkR
         gLHhC//dA6h0z9P5LAB/Bvm4DR910ramnNcqbhBtb6VT0tlPIKn23kGtmib/xX27EWZU
         OqGq7+UuXr9DDuVp9BKttMj1lRPDnaSmYQWbf0CzseSDziBWqo6qA7JRHMebsdIySuxm
         OCCB3RLZN7Qw+jTKz3y8xnyVq2A2chHmncMC8qf0yudCFDEN9yQ1Lo/eQGqGg+OYx/w2
         POnCJrDiVagq/akGAAwaQhCt9rzCVqg+Ezfb944AiB0u4QV5mdtGQETKIg3gVk8MczS1
         T0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778617444; x=1779222244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s5NbfZo3rJwfoGNoC6qpeTd0z48sbM+qfi9cSxeF1tM=;
        b=DoZbpzjZZHvNvdwfH8hAChA29GVklenXyYi+IIJ+KZkn9hzozY3iHZr9p4aFEaDAVk
         FM4q35CsEpdWzlikZVGcxQCvq9QSkTBSiX3hgEw8hgXjusUGYceON8sbftD55OZofJs1
         HpjYiZipdQSddNLLpjBiSv7ZXQu9awVywgMj6JNbPglq8PsZXL3XBL0B0c3bqHLqtRWd
         87sGsKU1uBvovrTLFwt5GYpzHwIAtyJVep4rlFMlnlgMTymJNxgzG4EsnittunVHd2M8
         O062zQ7BVr73ac65eTlWJf6AwQDOht2KKkxGNf34YLQCkCSZV1HtxGPdvyju5ZkH5Kan
         z0NQ==
X-Forwarded-Encrypted: i=1; AFNElJ9K79kSANm8v0BNudlTwDCU0UY3HqcoqjXyG/J0tr7wMLfpq8YSP6/0gWA6W2TDbkl+9MTodwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMV0W1LnqfSfwJZMvXTxnt2iJhVLlAfxRLahNYMpdvp8hP15AY
	LANSSnotGsv+9h8yVivtih6JuJib7iwS8myRv/7QXbkRtjzzbAfVcrkIPt1TVXadZ3Lxr1Vz8rz
	br5YRSWUQ8EGIvBGB0fC1H2zRIp9y3w==
X-Gm-Gg: Acq92OGBt38FD67udtWG0tJbD8cDhlbQ14lI4y6+KFCd7fsXfi6V6jsQzHhZV2GGAWJ
	xwbQm4jHi+bm1B9IIajx0NImtjCT5uAmmM0w9fYnEK1M1NsPU8kiKY1gQb3ueUwUHUox0qiueyv
	CXmSflr+xpf8OBb6N8MuXUtgoXyxfrfGeY05NVDCbJYppzdlIHMFos/C1UTLB66UbDaeWgQI0EJ
	JuA8ZdzzQOPTJnW56fWNZaJZoCUsDvoFpF0Z2tTrX7pwO7XRR9pdlxoRqb8IVlkdnmJ+s5SxLrK
	SRs=
X-Received: by 2002:a17:906:7313:b0:bc2:e83f:c438 with SMTP id
 a640c23a62f3a-bd3c161dbc9mr20196266b.31.1778617443298; Tue, 12 May 2026
 13:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511211143.19792-1-arouhi@sitime.com> <20260511211453.20671-1-arouhi@sitime.com>
 <20260512-cadet-overrun-c66bf033e024@spud> <CALFSGurCGzyk3mOPnyP_p2o+s9kCCQZc4MjBsDpPxqSPV1ZseA@mail.gmail.com>
In-Reply-To: <CALFSGurCGzyk3mOPnyP_p2o+s9kCCQZc4MjBsDpPxqSPV1ZseA@mail.gmail.com>
From: Ali Rouhi <rouhi.ali@gmail.com>
Date: Tue, 12 May 2026 13:23:51 -0700
X-Gm-Features: AVHnY4LmWnYP_EIb2Ffl-weepoq8wJbkHWR7bQAmE75NVC2lYu2L_5K52-anKZs
Message-ID: <CALFSGuo8_JMh5jJth+pDPfYWNn7asAgxqtjiVFZK85GcvvkTzA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] dt-bindings: dpll: add SiTime SiT9531x clock generator
To: Conor Dooley <conor@kernel.org>
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev, 
	arkadiusz.kubalewski@intel.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, cjubran@nvidia.com, Oleg.Zadorozhnyi@devoxsoftware.com, 
	devicetree@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ali Rouhi <arouhi@sitime.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 55E5E5294CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287289-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rouhiali@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.68:email,mail.gmail.com:mid,devicetree.org:url]
X-Rspamd-Action: no action

On Mon, May 12, 2026, Conor Dooley wrote:
> This is not relevant information in a binding FYI.

Agreed =E2=80=94 removed the Linux-specific paragraph from the description.

> Description here shouldn't talk about what linux drivers do
> with the property. Remove the second sentence please.

Done =E2=80=94 reset-gpios now just says "GPIO connected to the chip's
active-low reset pin (RESETB)."

> Same here. If you even converted "uses it" to "should" or "must"
> then it'd be fine.

Reworded to describe hardware behavior: "Asserted when the device
detects a status change such as lock acquisition or loss."

> Can you explain why there's no reference to dpll-device.yaml and
> none of the properties involved are used?

That was an oversight on my part. v2 adds allOf/$ref to
dpll-device.yaml, switches to unevaluatedProperties, and includes
input-pins/output-pins sub-nodes in the second example.

Thanks for the review.

Ali


On Tue, May 12, 2026 at 1:15=E2=80=AFPM Ali Rouhi <rouhi.ali@gmail.com> wro=
te:
>
> On Tue, May 12, 2026 at 10:52=E2=80=AFAM Conor Dooley <conor@kernel.org> =
wrote:
> > This is not relevant information in a binding FYI.
>
> Agreed =E2=80=94 removed the Linux-specific paragraph from the descriptio=
n.
>
> > Description here shouldn't talk about what linux drivers do
> > with the property. Remove the second sentence please.
>
> Done =E2=80=94 reset-gpios now just says "GPIO connected to the chip's
> active-low reset pin (RESETB)."
>
> > Same here. If you even converted "uses it" to "should" or "must"
> > then it'd be fine.
>
> Reworded to describe hardware behavior: "Asserted when the device
> detects a status change such as lock acquisition or loss."
>
> > Can you explain why there's no reference to dpll-device.yaml and
> > none of the properties involved are used?
>
> That was an oversight on my part. v2 adds allOf/$ref to
> dpll-device.yaml, switches to unevaluatedProperties, and includes
> input-pins/output-pins sub-nodes in the second example.
>
> Thanks Conor for the review.
>
> Ali
>
> On Tue, May 12, 2026 at 10:52=E2=80=AFAM Conor Dooley <conor@kernel.org> =
wrote:
>>
>> On Mon, May 11, 2026 at 02:14:52PM -0700, Ali Rouhi wrote:
>> > Add device tree binding documentation for the SiTime SiT95316
>> > and SiT95317 DPLL clock generators.
>> >
>> > Signed-off-by: Ali Rouhi <arouhi@sitime.com>
>> > ---
>> >  .../bindings/dpll/sitime,sit9531x.yaml        | 82 ++++++++++++++++++=
+
>> >  1 file changed, 82 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit9=
531x.yaml
>> >
>> > diff --git a/Documentation/devicetree/bindings/dpll/sitime,sit9531x.ya=
ml b/Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml
>> > new file mode 100644
>> > index 000000000000..0b05f0de65b9
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml
>> > @@ -0,0 +1,82 @@
>> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> > +%YAML 1.2
>> > +---
>> > +$id: http://devicetree.org/schemas/dpll/sitime,sit9531x.yaml#
>> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> > +
>> > +title: SiTime SiT9531x DPLL Clock Generator
>> > +
>> > +maintainers:
>> > +  - Ali Rouhi <arouhi@sitime.com>
>> > +
>> > +description: |
>> > +  The SiTime SiT95316 and SiT95317 are I2C-controlled programmable cl=
ock
>> > +  generators with integrated DPLL for synchronization applications.  =
Both
>> > +  variants contain four PLLs with automatic/manual reference selectio=
n,
>> > +  DCO frequency adjustment, and phase offset measurement via an on-ch=
ip
>> > +  TDC (Time-to-Digital Converter).
>> > +
>> > +  The SiT95317 provides 4 inputs and 8 outputs; the SiT95316 provides
>> > +  4 inputs and 12 outputs.
>>
>>
>> > +
>> > +  Runtime configuration (reference selection, frequency, phase) is ma=
naged
>> > +  through the kernel DPLL netlink subsystem; the device tree describe=
s only
>> > +  the hardware wiring.
>>
>> This is not relevant information in a binding FYI.
>>
>> > +
>> > +properties:
>> > +  compatible:
>> > +    enum:
>> > +      - sitime,sit95316
>> > +      - sitime,sit95317
>> > +
>> > +  reg:
>> > +    maxItems: 1
>> > +
>> > +  reset-gpios:
>> > +    maxItems: 1
>> > +    description:
>> > +      GPIO connected to the chip's active-low reset pin.  If present,=
 the
>> > +      driver holds the line deasserted at probe.  Optional; boards th=
at do
>> > +      not route the reset line omit this property.
>>
>> Description here shouldn't talk about what linux drivers do with the
>> property. Remove the second sentence please.
>>
>> > +
>> > +  interrupts:
>> > +    maxItems: 1
>> > +    description:
>> > +      Interrupt from the chip's active-low INTRB output.  When wired,=
 the
>> > +      driver uses it to trigger immediate status readback instead of
>> > +      relying solely on periodic polling.  Optional.
>>
>> Same here. If you even converted "uses it" to "should" or "must" then
>> it'd be fine.
>>
>> > +
>> > +required:
>> > +  - compatible
>> > +  - reg
>>
>> Can you explain why there's no reference to dpll-device.yaml and none of
>> the properties involved are used?
>>
>> Cheers,
>> Conor.
>>
>> > +
>> > +additionalProperties: false
>> > +
>> > +examples:
>> > +  - |
>> > +    i2c {
>> > +        #address-cells =3D <1>;
>> > +        #size-cells =3D <0>;
>> > +
>> > +        clock-generator@68 {
>> > +            compatible =3D "sitime,sit95317";
>> > +            reg =3D <0x68>;
>> > +        };
>> > +    };
>> > +
>> > +  - |
>> > +    #include <dt-bindings/gpio/gpio.h>
>> > +    #include <dt-bindings/interrupt-controller/irq.h>
>> > +
>> > +    i2c {
>> > +        #address-cells =3D <1>;
>> > +        #size-cells =3D <0>;
>> > +
>> > +        clock-generator@68 {
>> > +            compatible =3D "sitime,sit95316";
>> > +            reg =3D <0x68>;
>> > +            reset-gpios =3D <&gpio 78 GPIO_ACTIVE_LOW>;
>> > +            interrupts =3D <12 IRQ_TYPE_LEVEL_LOW>;
>> > +        };
>> > +    };
>> > +...
>> > --
>> > 2.43.0
>> >

