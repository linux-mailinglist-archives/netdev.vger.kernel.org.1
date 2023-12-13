Return-Path: <netdev+bounces-57045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F6C811BEA
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 19:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739CA1C20D30
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 18:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC463A8EA;
	Wed, 13 Dec 2023 18:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MloHbArP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6581810E
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 10:04:56 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso531a12.1
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 10:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702490695; x=1703095495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21jXasXtmRzkqxKFo4eGWsmHlpxdFbQH+B0lhXK71P4=;
        b=MloHbArPCGy4UH5vKI6xDmEliPPlzqx/k9DUZmUzdQkSorQv0HIEFxXAraXbpUaW8T
         Y3t8aDwWC3h/gKz/oWjnagGkt8cmAWbgZvI5FqNoM0jYDr5scRs5/VA4SlZNk6D1PQku
         7BEJ+Khlwwp2KHuOSJR2GUM8pdz0C2ZQrVmlqAtVmPwN321cXzV/ZxOtZmqI01RLPJsL
         5E60pw7XD32cPDF1PwqKopY9ppcR+0GRn8flADXgoBaGQJ1JrQd99Ydjjr8cLFY6wvFo
         9JbseIqA3hwhh//FBGfvnr6BTc4VQFCzbhuk0fciFBauC9/wsr2fgPrsXg97zQRMR0Fm
         l4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702490695; x=1703095495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21jXasXtmRzkqxKFo4eGWsmHlpxdFbQH+B0lhXK71P4=;
        b=mcSriEXVrxzb+bTy+6vdxcw1NLU3xuvdPLE2j6yJYpW/C+bpbaP/clupF5xCnzlmFL
         YEZVWIqHA58QFT4UBx9kslp4ZYcUDV0iJoq4lrX1uRE/4yECy0h78MlYNHBk0ZqgHovg
         Sgz4OefJE5hacmyeTlsM1t0gXKWJMtXibElKvuy7OxBiwaizUjr5vlvlaFDaU7UeYBGc
         O7RQ2d79+dv7Dg2wUTBqCYeb+Hyn/zP47WHySRilW04HfUTZbY4oBYjsAVXwy57BXa+D
         jFxQ/M8lYN+LAM50vf/QFyum66zo7zdXIhy0/Nf07uPS0NNLTfNmsyCd2BJMzBDbRHVV
         rLng==
X-Gm-Message-State: AOJu0YySBLA2pbFzAyemzZUjOdeEj8cNoUi/h5m2BKjOWOukSvuiBWSJ
	Y0hOyFmEduOXTK/sIVX/en1W27ew13wPPkoNuxakwQ==
X-Google-Smtp-Source: AGHT+IFZ0QnhCZ83tmXoK6mhFHyBdcvp5mCRnCffsk1ck7VZ9hKplAHt87E6Nft++7qp0ZDZ9mDDVfILHJcQSQ2GlaQ=
X-Received: by 2002:a50:c092:0:b0:543:fb17:1a8 with SMTP id
 k18-20020a50c092000000b00543fb1701a8mr511384edf.3.1702490694642; Wed, 13 Dec
 2023 10:04:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213165741.93528-1-jhs@mojatatu.com> <CANn89iK+4p7i_+NaLQq5S7yQ+JB=ZEUJEsxvFkzamttzm21u8A@mail.gmail.com>
 <CANn89iK-4==X-bELpZwLVJCBNOoDYfZEQkCOtNeSRqc=CT-PEw@mail.gmail.com> <CAM0EoMm8sRhONAJj6OhJ_+9BmzzSV71F=LuCWze_0Mc1h9V+kQ@mail.gmail.com>
In-Reply-To: <CAM0EoMm8sRhONAJj6OhJ_+9BmzzSV71F=LuCWze_0Mc1h9V+kQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 13 Dec 2023 19:04:42 +0100
Message-ID: <CANn89iKB3u6i36Bjqz87jn9b0GQMkUswQMUL+F57B-KYQZwGhQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net_sched: sch_fq: Fix out of range band computation
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Willem de Bruijn <willemb@google.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	netdev@vger.kernel.org, pctammela@mojatatu.com, victor@mojatatu.com, 
	Coverity Scan <scan-admin@coverity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 6:53=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Wed, Dec 13, 2023 at 12:42=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Wed, Dec 13, 2023 at 6:29=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Wed, Dec 13, 2023 at 5:57=E2=80=AFPM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > > >
> > > > It is possible to compute a band of 3. Doing so will overrun array
> > > > q->band_pkt_count[0-2] boundaries.
> > > >
> > > > Fixes: 29f834aa326e ("net_sched: sch_fq: add 3 bands and WRR schedu=
ling")
> > > > Reported-by: Coverity Scan <scan-admin@coverity.com>
> > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > ---
> > > >  net/sched/sch_fq.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > > > index 3a31c47fea9b..217c430343df 100644
> > > > --- a/net/sched/sch_fq.c
> > > > +++ b/net/sched/sch_fq.c
> > > > @@ -159,7 +159,7 @@ struct fq_sched_data {
> > > >  /* return the i-th 2-bit value ("crumb") */
> > > >  static u8 fq_prio2band(const u8 *prio2band, unsigned int prio)
> > > >  {
> > > > -       return (prio2band[prio / 4] >> (2 * (prio & 0x3))) & 0x3;
> > > > +       return (prio2band[prio / 4] >> (2 * (prio & 0x3))) % 0x3;
> > > >  }
> > > >
> > >
> > > Are you sure this is needed ?
> > >
> > > fq_load_priomap() makes sure this can not happen...
> >
> > Yeah, I am pretty sure this patch is incorrect, we need to mask to get
> > only two bits.
>
> The check in fq_load_priomap() is what makes it moot. Masking with
> b'11 could result in b'11. Definitely the modulo will guarantee
> whatever results can only be in the range 0..2. But it is not needed.
>
>


Modulo would be incorrect, since it would use high order bits.

(0x22 % 3) is different than (0x22 & 3)

Had you written:

return ((prio2band[prio / 4] >> (2 * (prio & 0x3))) & 0x3) % 3)

Then yes, the last % 3 would be "not needed"

