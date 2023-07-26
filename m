Return-Path: <netdev+bounces-21350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4E47635C6
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2AD3281E07
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 12:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E1ABE5F;
	Wed, 26 Jul 2023 12:02:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8440DCA4C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:02:28 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B106AA
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 05:02:23 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bcc0adab4so58406566b.2
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 05:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690372941; x=1690977741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoPCQO3CIWnYMM0tX6KNUXPCxTm/c6ulY3wdvUR9O3k=;
        b=fXcn05ddUN9vYrh1ugt4x04y/YcV0UlEHd1XbmnKxljT0pYmnwNzxEbNMGby7u586D
         ZCGtiAumAa1h+6+tIO0DZi+UF0ryr//Ym6wWygmuVvwGa9zWLBk8iZHwK9syYBUEyVfE
         o5Sttj5qbc0FCRLNMnOLtmyw0KAcqFW2fE+dAbYFl2WizKx9SP53Pqe8L9OGkV/+xcV4
         AOt7meVttoKQpVIUhqA+5s9k9VYdMKVCHJA/sTF6UNOfNXPuLwddpBN52JMyLdnJR8ZI
         Te5dPdBAfnVz/yqv2oQZOOu8EVstDtFLW6h398NDVyKJ86oHQ+8UHRswJYv2c1ouAxz3
         ovzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690372941; x=1690977741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoPCQO3CIWnYMM0tX6KNUXPCxTm/c6ulY3wdvUR9O3k=;
        b=ce5vxtHgBI/H98AJmS4Vqxcd+nBgl7egQRPee4i9mzJLj6ntkcS1hBXbEZHiAI6N/a
         Y8MlJ3gONORtlCWxII+dBtqcfjf0vdUEsumNLNooTYtopTX9iOYuEaL692Uifd5WgTVt
         zJcU/udY7HlCgzeDw8+ys9VGf3JwHrd0iA5ZvaHmCFX4QJuDylV8JpjeCZ20GQjny+ii
         Zmb5cYJY1hT8tXvS+qi/TnRnuzO3WYAODsyIS1Mcb9ydMBdp8Kq9AN0ZWuX1kWHiPgz6
         eRqturNCNB629viWPBH1D9tOugqmlarDW6yDqets2o/cfIjm7X2EOKPVgb0aQI3gglGF
         vEAQ==
X-Gm-Message-State: ABy/qLYZppzNFMhhqkiz7c0xPiEeAL8e5MoFQibydJTmdDFQax6t/+rt
	PcMuy4CYbzMijxQRB3GiPoVkrgPYoZndsCL+2qo=
X-Google-Smtp-Source: APBJJlGCtZkEdxLxj+wDw3nfkiQ9ynP6L2xpuL8g7cVF/3nB4WS+zihn9Q74H6Uf3KkzYO/fIAEgI2luhWo4wNmYwgQ=
X-Received: by 2002:a17:906:5dcc:b0:99b:492d:25fa with SMTP id
 p12-20020a1709065dcc00b0099b492d25famr1358608ejv.76.1690372941252; Wed, 26
 Jul 2023 05:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230721071532.613888-1-marcin.szycik@linux.intel.com>
 <20230721071532.613888-3-marcin.szycik@linux.intel.com> <ZLqZRFa1VOHHWCqX@smile.fi.intel.com>
 <5775952b-943a-f8ad-55a1-c4d0fd08475f@intel.com>
In-Reply-To: <5775952b-943a-f8ad-55a1-c4d0fd08475f@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 26 Jul 2023 15:01:44 +0300
Message-ID: <CAHp75VcFse1_gijfhDkyxhBFtd1d-o5_4RO2j2urSXJ_HuZzyg@mail.gmail.com>
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

On Wed, Jul 26, 2023 at 2:11=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
> From: Andy Shevchenko <andy@kernel.org>, Yury Norov <yury.norov@gmail.com=
>
> Date: Fri, 21 Jul 2023 17:42:12 +0300
>
> > +Cc: Yury on bitmap assignments.
>
> I told Marcin to add you to Cc when sending, but forgot Yury, my
> apologies =3D\
>
> >
> > (Yury, JFYI,
> >  if you need the whole series, take message ID as $MSG_ID of this email
> >  and execute
> >
> >    `b4 mbox $MSG_ID`
> >
> >  to retrieve it)
> >
> > On Fri, Jul 21, 2023 at 09:15:28AM +0200, Marcin Szycik wrote:
> >> From: Alexander Lobakin <aleksander.lobakin@intel.com>

...

> >> and replace all TUNNEL_* occurencies to

occurrences

...

> >> otherwise there will be too much conversions

too many
(countable)

...

> >> +static inline void ip_tunnel_flags_from_be16(unsigned long *dst, __be=
16 flags)
> >> +{
> >> +    bitmap_zero(dst, __IP_TUNNEL_FLAG_NUM);
> >
> >> +    *dst =3D be16_to_cpu(flags);
> >
> > Oh, This is not good. What you need is something like bitmap_set_value1=
6() in
> > analogue with bitmap_set_value8().
>
> But I don't need `start`, those flag will always be in the first word
> and I don't need to replace only some range, but to clear everything and
> then set only the flags which are set in that __be16.
> Why shouldn't this work?

I'm not saying it should or shouldn't (actually you need to prove that
with some test cases added). What I'm saying is that this code is a
hack because of a layering violation. We do not dereference bitmaps
with direct access. Even in your code you have bitmap_zero() followed
by this hack. Why do you call that bitmap_zero() in the first place if
you are so sure everything will be okay? So either you stick with
bitops / bitmap APIs or drop all of them and use POD types and bit
wise ops.

...

> >> +    ret =3D cpu_to_be16(*flags & U16_MAX);

Same as above.

...

> >> +    __set_bit(IP_TUNNEL_KEY_BIT, info->key.tun_flags);
> >> +    __set_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags);
> >> +    __set_bit(IP_TUNNEL_NOCACHE_BIT, info->key.tun_flags);
> >>      if (flags & BPF_F_DONT_FRAGMENT)
> >> -            info->key.tun_flags |=3D TUNNEL_DONT_FRAGMENT;
> >> +            __set_bit(IP_TUNNEL_DONT_FRAGMENT_BIT, info->key.tun_flag=
s);
> >>      if (flags & BPF_F_ZERO_CSUM_TX)
> >> -            info->key.tun_flags &=3D ~TUNNEL_CSUM;
> >> +            __clear_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags);
> >
> > Instead of set/clear, use assign, i.e. __asign_bit().
>
> Just to make it clear, you mean
>
>         __assign_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags,
>                      flags & BPF_F_ZERO_CSUM_TX);
>
> right?

Yes.


--=20
With Best Regards,
Andy Shevchenko

