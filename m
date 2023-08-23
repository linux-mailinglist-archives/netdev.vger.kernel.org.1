Return-Path: <netdev+bounces-29855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6478C784F66
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 05:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D8828126B
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 03:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F1720F12;
	Wed, 23 Aug 2023 03:42:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C7317C6
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 03:42:24 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47096E5E
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 20:42:13 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bdc27e00a1so544680a34.3
        for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 20:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692762132; x=1693366932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQ6jNZAIndEYnEw5Gb7tXhsRBrNcfZ5TI9uLzBTtL1o=;
        b=blO1zAYh7zt7QWOEnPfBqiTfyBBx1xMaZjZ2pkszMZzFrTCKHG8A3UKxYXZqu9vz1A
         AnBYu9yOCjYutYiiCgNleaXfn0/ovVjU5YqbXrWgvqzYy6oWlTLdIG1vf+2EZTtmIY1a
         yucca2VebfhJhhB+Tyx+xFqqjoyDsIdRazNU1ipCvDo/wnkpnuEJOMORhmDGlUxzTBBY
         ujoJEiIl3700mNBsVSIf5k3MO45v8KYCyUcUbY0a2zx7C7QJTtjd8eQ8Yp8Bm4OBLiMB
         qZqDuR6E234cygIgfWZ/2DIGsAQ7pgeMOVN31gH6pS+3ZtCeocpWi9khjtltiPuJC17U
         NojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692762132; x=1693366932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQ6jNZAIndEYnEw5Gb7tXhsRBrNcfZ5TI9uLzBTtL1o=;
        b=V6zJU5ZQ3gcz+TWlN4cgP0fIgo1K6gKX5sgFRhNuK9izQNsLJ/eBWYnD8zx/HPdMxR
         cixpVWRP6zBHnqH1FH9+j1+ZU6I+324D+9KEzskSmcAPvs7ZZN3ulrnOK9ZLe+MfkO8a
         oJphjf6t5iV3icEwy6szsGsake3QG832Tl1WrO3yTcXXe2ZL1bVgTjeVRKa/aKABC6Wa
         oNwfjnXNTh0z9HAHBWT96MtMM6c4rh4UoC6RNAjH6MLwYhaSKR0RzP+IRewl/q3CvRsL
         N58es4uTek3BbSPnqyQJiMmaqgs/Simcqv0yHSB4txFEoSCollpwPLfSW2kTUt9BWn4K
         u/lw==
X-Gm-Message-State: AOJu0YzS7/OLLKc+etTpvqX51nyRszJkGYgflsaICs9JPtNvsS7SOnq7
	bMrqA7BYN84pX4zJd5K/1Fl3to4DLIQRQSj6lIk=
X-Google-Smtp-Source: AGHT+IHJJRRj5E5Rmxc5eX+/eScN0btjRlqWnn+oHpKfnW0K/KDT5xkhUWU7cXDk/6exwtfnZELL8hjBLNgP9DHNDDU=
X-Received: by 2002:a05:6870:c0cf:b0:1c0:fcbd:2345 with SMTP id
 e15-20020a056870c0cf00b001c0fcbd2345mr14837859oad.20.1692762132412; Tue, 22
 Aug 2023 20:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230821011116.21931-1-alexhenrie24@gmail.com> <e0e8e74a65ae24580d3ab742a8e76ca82bf26ff8.camel@redhat.com>
In-Reply-To: <e0e8e74a65ae24580d3ab742a8e76ca82bf26ff8.camel@redhat.com>
From: Alex Henrie <alexhenrie24@gmail.com>
Date: Tue, 22 Aug 2023 21:41:37 -0600
Message-ID: <CAMMLpeRR_JmFp3DnDJbYdjxnpfxLke-z5KW=EA8_H_xj3FzXvg@mail.gmail.com>
Subject: Re: [PATCH] ipv6/addrconf: clamp preferred_lft to the minimum instead
 of erroring
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, jbohac@suse.cz, benoit.boissinot@ens-lyon.org, 
	davem@davemloft.net, hideaki.yoshifuji@miraclelinux.com, dsahern@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Paolo, thanks for the review.

On Tue, Aug 22, 2023 at 3:54=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:

> It looks like you are fixing 2 separate bugs, so 2 separate patches
> would be better.

The two problems are closely related, and in the same function. But I
will split the patch into two patches to your preference.

> You should explicitly state the target tree (in this case 'net') into
> the patch subj.

Will fix in v2, thanks.

> You should add a suitable fixes tag to each patch.

That would be "Fixes: 76506a986dc31394fd1f2741db037d29c7e57843" and
"Fixes: eac55bf97094f6b64116426864cf4666ef7587bc", correct?

> On Sun, 2023-08-20 at 19:11 -0600, Alex Henrie wrote:

> > @@ -1368,7 +1368,7 @@ static int ipv6_create_tempaddr(struct inet6_ifad=
dr *ifp, bool block)
> >        * idev->desync_factor if it's larger
> >        */
> >       cnf_temp_preferred_lft =3D READ_ONCE(idev->cnf.temp_prefered_lft)=
;
> > -     max_desync_factor =3D min_t(__u32,
> > +     max_desync_factor =3D min_t(__s64,
> >                                 idev->cnf.max_desync_factor,
> >                                 cnf_temp_preferred_lft - regen_advance)=
;
>
> It would be better if you describe in the commit message your above
> fix.

I did mention the underflow problem in the commit message. When I
split the patch into two patches, it will be even more prominent. What
more would you like the commit message to say?

> Also possibly using 'long' as the target type (same as
> 'max_desync_factor') would be more clear.

OK, will change in v2.

> > @@ -1402,12 +1402,8 @@ static int ipv6_create_tempaddr(struct inet6_ifa=
ddr *ifp, bool block)
> >        * temporary addresses being generated.
> >        */
> >       age =3D (now - tmp_tstamp + ADDRCONF_TIMER_FUZZ_MINUS) / HZ;
> > -     if (cfg.preferred_lft <=3D regen_advance + age) {
> > -             in6_ifa_put(ifp);
> > -             in6_dev_put(idev);
> > -             ret =3D -1;
> > -             goto out;
> > -     }
> > +     if (cfg.preferred_lft <=3D regen_advance + age)
> > +             cfg.preferred_lft =3D regen_advance + age + 1;
>
> This change obsoletes the comment pairing the code. At very least you
> should update that and the sysctl knob description in
> Documentation/networking/ip-sysctl.rst.

The general idea is still valid: The preferred lifetime must be
greater than regen_advance. I will rephrase the comment to be more
clear in v2.

> But I'm unsure we can raise the preferred lifetime so easily. e.g. what
> if preferred_lft becomes greater then valid_lft?

Excellent point. We really should clamp preferred_lft to valid_lft as
well. I can make that change in v2.

By the way, if valid_lft is less than regen_advance, temporary
addresses still won't work. However, that is much more understandable
because valid_lft has to be at least the length of the longest needed
connection, so in practice it's always going to be much longer than 5
seconds.

> I think a fairly safer alternative option would be documenting the
> current behavior in ip-sysctl.rst

I feel strongly that the current behavior, which can appear to be
working fine for a few minutes before breaking, is very undesirable. I
could, nonetheless, add some explanation to ip-sysctl.rst about what
happens if preferred_lft or valid_lft is too small.

Thanks for caring about doing IPv6 right,

-Alex

