Return-Path: <netdev+bounces-57040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ED5811B8F
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 18:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5EB1F216EB
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 17:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF1559522;
	Wed, 13 Dec 2023 17:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ZrEQlSbt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CE683
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 09:53:20 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5d8a772157fso63901467b3.3
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 09:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702490000; x=1703094800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kERaWxChdNaAelSUNwLg6ZGYzN4ju9p19OphJzitE4U=;
        b=ZrEQlSbtMYsmy8khrYNKcHzjNUN1+RqPhdOrbT7/OY5mr+Csj0Bme71flZiEB9R8pA
         YTM1wSAYreCmFHeqyyYRKCcBF3impMwmGFnLZ5NM92NoqEAec0ghm14Wme45uAUGYEKd
         IVVmtu6hBhYHSFVtngnItoSLu5VfkwboE5MfGgWDX/jpdbEDmkg8/KTlXSed9iGR40Hx
         FsfVx13puvM2fNeqqiKgGZhdQSUBfJ8CyuanC+cmeFzVp24mgOzLXWDz3Cr6OGxQjMY9
         H0hMyPEM7TraQbz8pU1L+eKC/uI06VmtnQBHIk0+Ob/cqkGXSWKC6JG1IWGoPDSc0T3W
         cQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702490000; x=1703094800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kERaWxChdNaAelSUNwLg6ZGYzN4ju9p19OphJzitE4U=;
        b=WhzB+pP1lgiWVZu19DvxjlIUziWJxpExQgTsvrKVPKEeJ3WcwRwsOFbFVWF0wrz/1f
         rwKbsyeY36eXxhjVzWVsd4TDaZ+xknfP0qS53yJp4Juo4H/cS4Z/urV1DbCn39Pg1mCi
         lMTFVD2TG6NCPeauB3IkamRss14FVi2PWvedW0xUXjzltThnX0QZeW4CVUIi8iQneNgr
         YdPnxvwpWyn1kJbE9Ezc6hiQX7gzHIjBYq+HKzOgEV/cgyiSK2ZK7r3z7vfzxgPsxQo1
         PANFcxeLesUTqheRl8QMAyrR9ZlUXsomHmpwgzwNiHNrS4ECADwDACzqOYhDtIv9SmAz
         YoXA==
X-Gm-Message-State: AOJu0YzaQOfId7MG0pKbdGcwFJBB902wo+ATFF9wstDQRiqMnrnSELgn
	8KJSGd9Zsf206tJMP2kHk7ysGO/i7b37A5H/2uS0OA==
X-Google-Smtp-Source: AGHT+IE5YqWdlBa1NG0OQQbix7wM0jSw6W33ECNmULlobrc7i0vh8avdobDKSM5nMxUmUfWFNSLcSDYY/UJKy64uXrY=
X-Received: by 2002:a81:a505:0:b0:5d7:1941:aa7 with SMTP id
 u5-20020a81a505000000b005d719410aa7mr6475977ywg.66.1702490000037; Wed, 13 Dec
 2023 09:53:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213165741.93528-1-jhs@mojatatu.com> <CANn89iK+4p7i_+NaLQq5S7yQ+JB=ZEUJEsxvFkzamttzm21u8A@mail.gmail.com>
 <CANn89iK-4==X-bELpZwLVJCBNOoDYfZEQkCOtNeSRqc=CT-PEw@mail.gmail.com>
In-Reply-To: <CANn89iK-4==X-bELpZwLVJCBNOoDYfZEQkCOtNeSRqc=CT-PEw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 13 Dec 2023 12:53:09 -0500
Message-ID: <CAM0EoMm8sRhONAJj6OhJ_+9BmzzSV71F=LuCWze_0Mc1h9V+kQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net_sched: sch_fq: Fix out of range band computation
To: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemb@google.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	netdev@vger.kernel.org, pctammela@mojatatu.com, victor@mojatatu.com, 
	Coverity Scan <scan-admin@coverity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 12:42=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Dec 13, 2023 at 6:29=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Dec 13, 2023 at 5:57=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > It is possible to compute a band of 3. Doing so will overrun array
> > > q->band_pkt_count[0-2] boundaries.
> > >
> > > Fixes: 29f834aa326e ("net_sched: sch_fq: add 3 bands and WRR scheduli=
ng")
> > > Reported-by: Coverity Scan <scan-admin@coverity.com>
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > ---
> > >  net/sched/sch_fq.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > > index 3a31c47fea9b..217c430343df 100644
> > > --- a/net/sched/sch_fq.c
> > > +++ b/net/sched/sch_fq.c
> > > @@ -159,7 +159,7 @@ struct fq_sched_data {
> > >  /* return the i-th 2-bit value ("crumb") */
> > >  static u8 fq_prio2band(const u8 *prio2band, unsigned int prio)
> > >  {
> > > -       return (prio2band[prio / 4] >> (2 * (prio & 0x3))) & 0x3;
> > > +       return (prio2band[prio / 4] >> (2 * (prio & 0x3))) % 0x3;
> > >  }
> > >
> >
> > Are you sure this is needed ?
> >
> > fq_load_priomap() makes sure this can not happen...
>
> Yeah, I am pretty sure this patch is incorrect, we need to mask to get
> only two bits.

The check in fq_load_priomap() is what makes it moot. Masking with
b'11 could result in b'11. Definitely the modulo will guarantee
whatever results can only be in the range 0..2. But it is not needed.

cheers,
jamal

