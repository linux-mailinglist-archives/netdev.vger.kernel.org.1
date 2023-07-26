Return-Path: <netdev+bounces-21424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D09763930
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9E11C213B1
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFAE21D36;
	Wed, 26 Jul 2023 14:32:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA512AB27
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 14:32:52 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1150D196
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 07:32:49 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bcfe28909so38565166b.3
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 07:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690381967; x=1690986767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mv0yRbES3EfD9bspTWviKRieLzb9r1m2dwD2cIgf4aY=;
        b=dUYpGqPbFkMgPrdLowlCuNuFT8QmIzngzDO2cyymud5D8XpUWyNJYY0o2A+heA1QDh
         BHPhmOi07H9EkbDRjdEEWxdQPV96Xwh9Mm5WMgyXNam1nfmN7Pzsm6C95dlqrLsEwb+Y
         SK+bt/W2HxHNMn3G51qINxqmQHYsEkmiCMrLmTPBXxbZMutxtVUtVrUDmucU7zBabto/
         4mqmH98w92aLQpzjOrY9qAR/VgfTMVkMqgYFYjBJ1Rfj4BMYqk5GQdwPa9QOOROAkLes
         H0T8VoSoNnw/wZ/YH/BAs42LeT/Ogi6oBxTR5QhtTAbH8aD3oiq6zDLTAbiwkWFJOuyF
         mQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690381967; x=1690986767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mv0yRbES3EfD9bspTWviKRieLzb9r1m2dwD2cIgf4aY=;
        b=cBuWd3RJ3ZjYy7ZcG9soWDbFnveD62Dk7PUXgvdlfUZLWlc2TGmPPwwne7ArodpMOc
         r1IRHaWraj7a5LmdmdYNbX9wMviIuSxnPJ1HDz6H5BQVt/M4gWqiPH7/Xr8aIcy1uQ8b
         T6V5HsHDtUYb/DOO/bZ79C+f+owPyyTwjSCISIT1XYSBpliggQfVTGNsYYzwFWKbGxCH
         s1C3mGmffe2ADfwZ+SsXRNdsRTj72gIvNNPqwhEF41jxLP2varkFWTk8YxjOXgT8kyaH
         GlDPDxcaZVGuabHiLrwy1Exyzny2+dsWhv2PhT5LgQ3AwSOdGkrbZYFqYHuBdR9BBy1E
         dfyw==
X-Gm-Message-State: ABy/qLbV+TKLUEx4emj+j+HVqQ5fM7LbbPv5mC45zkgsbK3uWvZQEHZI
	6jlvWr5N5v+MyWMUqMhKPminjhK0pXzI6WBRC/k=
X-Google-Smtp-Source: APBJJlF5G3155eQMm3z4NuIiXvIs/2CDl6Is8q4+f1WNKHF6LWYe6F3a6l8dKDuUSYNVBobMQKpJ+aVwLuX4XSUv3jU=
X-Received: by 2002:a17:906:5a5a:b0:973:e5d9:d6ff with SMTP id
 my26-20020a1709065a5a00b00973e5d9d6ffmr2007741ejc.66.1690381967155; Wed, 26
 Jul 2023 07:32:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230721071532.613888-1-marcin.szycik@linux.intel.com>
 <20230721071532.613888-3-marcin.szycik@linux.intel.com> <ZLqZRFa1VOHHWCqX@smile.fi.intel.com>
 <5775952b-943a-f8ad-55a1-c4d0fd08475f@intel.com> <CAHp75VcFse1_gijfhDkyxhBFtd1d-o5_4RO2j2urSXJ_HuZzyg@mail.gmail.com>
 <d5ffe1d3-0378-eaaf-c77f-a1f8a2875826@intel.com>
In-Reply-To: <d5ffe1d3-0378-eaaf-c77f-a1f8a2875826@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 26 Jul 2023 17:32:10 +0300
Message-ID: <CAHp75VfP5b4Rv64LZb1e2oCxfjfvNRZvBbGNcOc19tTcUYEjhA@mail.gmail.com>
Subject: Re: [PATCH iwl-next v3 2/6] ip_tunnel: convert __be16 tunnel flags to bitmaps
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Andy Shevchenko <andy@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
	Marcin Szycik <marcin.szycik@linux.intel.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, wojciech.drewek@intel.com, 
	michal.swiatkowski@linux.intel.com, davem@davemloft.net, kuba@kernel.org, 
	jiri@resnulli.us, pabeni@redhat.com, jesse.brandeburg@intel.com, 
	simon.horman@corigine.com, idosch@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 4:17=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
> From: Andy Shevchenko <andy.shevchenko@gmail.com>
> Date: Wed, 26 Jul 2023 15:01:44 +0300
> > On Wed, Jul 26, 2023 at 2:11=E2=80=AFPM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:
> >> From: Andy Shevchenko <andy@kernel.org>, Yury Norov <yury.norov@gmail.=
com>
> >> Date: Fri, 21 Jul 2023 17:42:12 +0300
> >>> On Fri, Jul 21, 2023 at 09:15:28AM +0200, Marcin Szycik wrote:
> >>>> From: Alexander Lobakin <aleksander.lobakin@intel.com>

...

> >>>> +static inline void ip_tunnel_flags_from_be16(unsigned long *dst, __=
be16 flags)
> >>>> +{
> >>>> +    bitmap_zero(dst, __IP_TUNNEL_FLAG_NUM);
> >>>
> >>>> +    *dst =3D be16_to_cpu(flags);
> >>>
> >>> Oh, This is not good. What you need is something like bitmap_set_valu=
e16() in
> >>> analogue with bitmap_set_value8().
> >>
> >> But I don't need `start`, those flag will always be in the first word
> >> and I don't need to replace only some range, but to clear everything a=
nd
> >> then set only the flags which are set in that __be16.
> >> Why shouldn't this work?
> >
> > I'm not saying it should or shouldn't (actually you need to prove that
> > with some test cases added). What I'm saying is that this code is a
>
> Good idea BTW!
>
> > hack because of a layering violation. We do not dereference bitmaps
> > with direct access. Even in your code you have bitmap_zero() followed
> > by this hack. Why do you call that bitmap_zero() in the first place if
> > you are so sure everything will be okay? So either you stick with
>
> Because the bitmap can be longer than one long, but with that direct
> deference I only rewrite the first one.

And either you don't need bitmaps (you always operate in the range of
a 32-bit type) or you need to avoid knowing the bitmap internals.
Relying on internal implementation is not a good code, i.e. layering
violation.

> But I admit it's a hack (wasn't hiding that). Just thought this one is
> "semi-internal" and it would be okayish to have it... I was wrong :D
> What I'm thinking of now is:
>
>         bitmap_zero() // make sure the whole bitmap is cleared
>         bitmap_set_value16() // with `start` =3D=3D 0

Right.

> With adding bitmap_set_value16() in a separate commit obviously.

Correct.

> That combo shouldn't be too hard for the compiler to optimize into
> a couple writes I hope.

Exactly why I suggested using fixed-width accessors. And if you use
compile-time constants for the bitmaps <=3D BITS_PER_LONG, it will be
(or at least it should be) optimized to the bitwise ops. That's how
bitmap APIs are done nowadays.

> > bitops / bitmap APIs or drop all of them and use POD types and bit
> > wise ops.

...

> >>>> +    ret =3D cpu_to_be16(*flags & U16_MAX);
> >
> > Same as above.

--=20
With Best Regards,
Andy Shevchenko

