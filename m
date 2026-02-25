Return-Path: <netdev+bounces-260996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AftF6YLn2neYgQAu9opvQ
	(envelope-from <netdev+bounces-260996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:48:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA2D198ED9
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FEAA3025C5C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7373D3CFC;
	Wed, 25 Feb 2026 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hasTqElL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8058D2877E5
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 14:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772030881; cv=pass; b=Ybow3IY98rC6RSBMn9btHCwZOpqq0X7beVe+CK2pIiEsuDfKOkZMghTRmng6C5HCnLj3C6ndWxOp9zjsSn92amcINoKPOkYgY84WB8sWkLhaihFKHBkprqgZJm9IsIvk9FiDlizVS3Vxd6UazXsnnJA+nEag+v2HcBsAfaYp0XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772030881; c=relaxed/simple;
	bh=b02ayuuJrrJYAQOqFctTzanPk6a09+Yfai8bQ2pW0r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tidDrsiiOck3X9Qry5uXe9uXijq1+I2NQ6+UkUQ7UxA+LI0MiLwU4k6vdf1zDP/wAFBiyvwYcGCvOR9LI5QLPYcQRw3sH3TiTEWaQQhJrh7vU4lABf0ywOMhuXbdoiDKYg/KnEqL84HQqenVovZ1gnSIFyde2eh80NPy0Zg0CVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hasTqElL; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d18c654458so2863065a34.3
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 06:48:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772030879; cv=none;
        d=google.com; s=arc-20240605;
        b=WdSPCxdZd95GjstljqwjaLaDcEGqJ9zayKtzX4oac8EcVYMfX7XhVGT7bb3K6fyhZr
         3Bq6xE9/DefTS0qednY4Q9iOt18cRTP5EcAktkGSWRKy9gD+Mq1Jn8FuCJdinirvihTT
         9ONiGT5Fy2rrvAGWc3LZr2lyFjL9NSYR9ji9SOBR6MVvNAErNIHY1JujQyYAxWz3o71y
         npFAelELI+29pgEgRK+F2EM6hmZnAm7HGUtCSMd8sOhir5U0b3plRnLYMWbQvADDwuil
         Gt3XufZgvzkvyZq49BWrO5FoNsv0UykBa7BCSS8D7wqqxI4sBez+ULJA8juq1OUCnpf/
         qnTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u0kfbmdw6mfzinq2TVFcXbBmnMywl5U7cR9oYK1yBVE=;
        fh=1ffhz1LCn+XjckKwJV4d58j3PNJFvGXtZYChy/J7jCo=;
        b=WW1+wFUGhTSfsZt7PAA7rW78CrehpVE0Y4qG82dCwW3nk3vo9V3QHExuGFkbwzY4RP
         gHPsdjUEcdPuTlzek1XblfFpSbnq1+TYzoVMPAhPKIB/JpVmcJTN+UFteOTdN+S6ZYtM
         XghsA2JEisf/wT6zlbMSkO6uIC3+e8uxB6jhfCmXsdG7lCAna1beyQ0/gm6FpXwRXg45
         w5n+tu/EE1snuu3laXw6L7/ZwkK9aenQxTqFKCcz/3PktH5PDMvaEpl/cF+RoSG/vYP7
         2rsKwPXGTXSek/TQt1eqiezz7nMFggrrAOKnYmJ3uZj+ENPwKkCo6T0X+9mrivOkIsb4
         cmhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772030879; x=1772635679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0kfbmdw6mfzinq2TVFcXbBmnMywl5U7cR9oYK1yBVE=;
        b=hasTqElLxpVsAcPJKgKUOcUjNIQivSA9lfLiPizCDsLmzSc/g1a0FJeE4AYZ82PL8r
         +M0+lWI+v0yTxIzKhvEph8SITLBWZrMYN/mjtecGGtp3xlEEtcZUOE8YC0xqXIUPEAW+
         g0jcJY9NCMdSCEfZcolQK8v5wqcy6okxQ66ZbZIYtOGfRpISSgz5EzVeeywBTVD81eji
         RCcric0k8d9TM2dxugQatpR/HTcS8unTMhNlL/MrwMjaVYLPvKe5z1PALF9devQN/nL9
         sMVpXg9MWtJAjKZJ+n40NFdIk4WwRa78Ca2OBzds8mEAiIHN5f6yKGs0kqJ4RwlQ2yMd
         QjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772030879; x=1772635679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u0kfbmdw6mfzinq2TVFcXbBmnMywl5U7cR9oYK1yBVE=;
        b=qqKRHbaxVjPZvsebjNRgtUHQGrTmdC+QHnuEAkovfGMc18ffXqtwmBpu17EQU9P437
         o/ypF4Oib64MgZ8hOQIEes6EBWcultmWXPnog2q7MYhDlEwCql4VTooivhh9pDI0BiJl
         Dl8zruEm8RQrXTtEVX6JzbOBd9mSZeHKR52tIt4i6zhLUEh5jKut+tyANcC4HhbLhWgT
         21fdDvw4kp2UO963nMqZF+BH2qCubJ5LdIqa+VBrcjXS75laS+W3TtpVmWn90+91yDi1
         rJAvJiGU1TybflVCgJzQ6LFfEQPLrJg8bq74V/ZbYTgbyLTxz4OyUoEVebV+/NsV2P+Y
         1CXw==
X-Gm-Message-State: AOJu0YyLB0lWtmrwdzDwRX0Vps6H8/EW2lHyKn0AphJLX5u/6aBV7y12
	VWSRX8ckkLU6z+6BxJNhn1JQA9ogW/QYVLHO37q2iAKgfI7HwAWwdZCDry9cLQ1vPUnRoRS5rS2
	c2dVDGf4O52XVm/IfBx41gFseKmJ2HBU=
X-Gm-Gg: ATEYQzzQ1kr7otGKxoBIAUX/Xel8pBQ5NuoJWX2sHy60HadFV39nrmzcr9LqvJTx+/q
	vfsXcgA3GeCvR5jlLH5A0Y3heZ5IZWet5yvj7Yrp/qcMu2TeGH6M/9lSrWnQfvIcQfCTvSzduQ2
	LeVjRIqKGxFhJuNatIcxjwjc+WHUWryEDKqy5v6u96IY6j6/V7xkeAIeeu7VJs/3nkAvQ0hyyIa
	/zFNlfzS7N7+PMiFLbEeq7SCVh8iDd81LMfXgUbnzpRsx9L7mp6Tz1GDck23/B1Hy6rUVXbpKhj
	h/5ttfk3kvJgLPszWs8ofBgYHegr39PT7tjJ5K5RuZvYDMeaqQTC
X-Received: by 2002:a05:6820:2d01:b0:662:c7a9:bb14 with SMTP id
 006d021491bc7-679c46eb230mr8727481eaf.35.1772030879206; Wed, 25 Feb 2026
 06:47:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225090853.2021140-1-mmyangfl@gmail.com> <20260225090853.2021140-3-mmyangfl@gmail.com>
 <8be7610c-c606-4c7d-8c8b-b2873bed082e@lunn.ch>
In-Reply-To: <8be7610c-c606-4c7d-8c8b-b2873bed082e@lunn.ch>
From: David Yang <mmyangfl@gmail.com>
Date: Wed, 25 Feb 2026 22:47:18 +0800
X-Gm-Features: AaiRm51d5-BFQPrh02PDGjoOq1kDLlwBa_UczElG4BhDTU4G_FbKGvP24cPa_Cw
Message-ID: <CAAXyoMO7YS28fwAkf93qN8Bc45qE2M6N9OzzKW+wSTJ_ujeXnQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] net: dsa: yt921x: Add port police support
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260996-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lunn.ch:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CCA2D198ED9
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 10:17=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
...
> > +/* v * 2^e */
> > +#define ldexpi(v, e) ({ \
> > +     __auto_type _v =3D (v); \
> > +     __auto_type _e =3D (e); \
> > +     _e >=3D 0 ? _v << _e : _v >> -_e; \
> > +})
> > +
> > +/* slot (ns) * rate (/s) / 10^9 (ns/s) =3D 2^C * token * 4^unit */
> > +#define rate2token(rate, unit, slot_ns, C) \
> > +     ((u32)(ldexpi((slot_ns) * (rate), \
> > +                   -(2 * (unit) + (C) + YT921X_TOKEN_RATE_C)) / 100000=
0000))
> > +#define token2rate(token, unit, slot_ns, C) \
> > +     (ldexpi(1000000000 * (u64)(token), \
> > +             2 * (unit) + (C) + YT921X_TOKEN_RATE_C) / (slot_ns))
> > +
> > +/* burst =3D 2^C * token * 4^unit */
> > +#define burst2token(burst, unit, C) ((u32)ldexpi((burst), -(2 * (unit)=
 + (C))))
> > +#define token2burst(token, unit, C) ldexpi((u64)(token), 2 * (unit) + =
(C))
>
> Please avoid macros like this. Write functions. The compiler will
> inline them if that makes sense. But you gain type checking, etc.
>

ldexpi is generic over integer types and we do type conversions in the
formulas below. So I think it cannot be expressed as a function.

> > +static struct yt921x_meter
> > +yt921x_meter_tfm(struct yt921x_priv *priv, int port, unsigned int slot=
_ns,
> > +              u64 rate, u64 burst, unsigned int flags,
> > +              u32 cir_max, u32 cbs_max, int unit_max)
> > +{
> > +     const int C =3D flags & YT921X_METER_PKT_MODE ? YT921X_TOKEN_PKT_=
C :
> > +                   YT921X_TOKEN_BYTE_C;
> > +     struct device *dev =3D to_device(priv);
> > +     struct yt921x_meter meter;
> > +     bool distorted;
> > +     u64 burst_est;
> > +     u64 burst_max;
> > +     u64 rate_max;
> > +
> > +     meter.unit =3D unit_max;
> > +     rate_max =3D token2rate(cir_max, meter.unit, slot_ns, C);
> > +     burst_max =3D token2burst(cbs_max, meter.unit, C);
> > +
> > +     /* Clamp rate and burst */
> > +     if (rate > rate_max || burst > burst_max) {
> > +             dev_warn(dev,
> > +                      "rate %llu, burst %llu too high, max is %llu, %l=
lu, clamping...\n",
> > +                      rate, burst, rate_max, burst_max);
>
> I'm not sure clamping is the correct thing to do here. -ERANGE would
> make it clearer that what the user requests is not possible.
>

The maxima are way larger than the physical limitations of GbE, so
they are also acceptable. Still it would be quite unusual for users to
supply such values.

> > +
> > +             if (rate > rate_max)
> > +                     rate =3D rate_max;
> > +             if (burst > burst_max)
> > +                     burst =3D burst_max;
> > +
> > +             burst_est =3D slot_ns * rate / 1000000000;
> > +     } else {
> > +             u64 burst_sug;
> > +
> > +             burst_est =3D slot_ns * rate / 1000000000;
> > +             burst_sug =3D burst_est;
> > +             if (flags & YT921X_METER_PKT_MODE)
> > +                     burst_sug++;
> > +             else
> > +                     burst_sug +=3D ETH_HLEN + yt921x_mtu_fetch(priv, =
port) +
> > +                                  ETH_FCS_LEN;
> > +             if (burst_sug > burst)
> > +                     dev_warn(dev,
> > +                              "Consider burst at least %llu to match r=
ate %llu\n",
> > +                              burst_sug, rate);
> > +
> > +             /* Select unit */
> > +             for (; meter.unit > 0; meter.unit--) {
> > +                     if (rate > (rate_max >> 2) || burst > (burst_max =
>> 2))
> > +                             break;
> > +                     rate_max >>=3D 2;
> > +                     burst_max >>=3D 2;
> > +             }
> > +     }
> > +
> > +     /* Calculate information rate and bucket size */
> > +     distorted =3D false;
> > +     meter.cir =3D rate2token(rate, meter.unit, slot_ns, C);
> > +     if (!meter.cir) {
> > +             distorted =3D true;
> > +             meter.cir =3D 1;
> > +     } else if (meter.cir > cir_max) {
> > +             WARN_ON(1);
> > +             meter.cir =3D cir_max;
>
> What does this WARN_ON() indicate? If this fires, you want somebody
> who is debugging it to be able to understand it.
>

It means logical error during unit selection. Surely internal error
and the debugger must be familiar with the implementation details, I
think.

...

