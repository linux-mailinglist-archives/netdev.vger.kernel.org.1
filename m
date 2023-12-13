Return-Path: <netdev+bounces-57037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF92811B6E
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 18:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2DB281422
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 17:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD8B3306D;
	Wed, 13 Dec 2023 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="0fTFo2ap"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8092CF2
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 09:42:48 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5e35e1dfb99so327927b3.0
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 09:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702489367; x=1703094167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvMIOR5nJPSjrU5SLOFlml29mUG5x/bknl8LwPXtYYI=;
        b=0fTFo2apC1liVtLkJVf6tgOIBav53Uf5/kOhfb7bP8trwpC6/fi5FSJGdrzpv9HT5i
         Y4u8rp5sT1oNXsHhpc2M39cm+wYdEpcqT5g1UiuImYLhvyHyccku816ZC8GZo/H0TsLV
         ym1IgFgpyZMLOdzYaPyPYaa98VwyG9G7Dm5d1GbjqhqBQqbbD8ZQpzg85MC+PdIgogIz
         5bVqexX79ZH3KL6hWs58rWHcm4+VDzaW/VjKnedJJ3n28UNJEpAETJhLaiiO4FoAM0OA
         chCy8Nbc8IytOPdMExa+UX0cVn2p5TgZfyPS1cXyOdFx5sPkOdTIAFt5lLs/zsS8Ydo5
         wH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702489367; x=1703094167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvMIOR5nJPSjrU5SLOFlml29mUG5x/bknl8LwPXtYYI=;
        b=dgoWNR2n1DPPA9Ostwib5wiW9KnKo7Hjgu7o+BRvqfPKGdE97eOHP4y5kC+ouHUesZ
         DCu4GNk4lwUsSaPgTqeLvxgsZEUQGVePgy9tvC3siv6AILDOpgPWBWXotSK0xgum6xam
         zyWuPQ2x/iVFoveTOXc65kBjVkRBV+IYYJVSj6So9U362ts/JqpskaB6ADgJ/l6CJQ9L
         8dX7u3j5cSW4Z+1CZOa//xgUYPC5nXiBuW6efpPueVF+cRyq8ohU6pb5tilursr5Cv+I
         3uR/U6VBrqSY/KxEaE6KLw9JqJz1JtulTVG9SGWwNcQ1O2/kWT3tS8z3bWLpQs+ZIzUS
         coNA==
X-Gm-Message-State: AOJu0YxAv8eBZYXIYB54DAmuhLLMSdMV5AyRRjLkPENRe5k8s2wf5W2n
	kZRwlDnbFkQg1mKRSytbWMGtmq4ZQ4Ahu+EG89WiU8WqyomZ8AEplhs=
X-Google-Smtp-Source: AGHT+IHF5qGsdzz8V6FdMqPfWh2j2rGP6kvucwpoVw72Ywgviq8Beok2dxv3biUyur8KhccoapWayh1hcPCeSvkp0+c=
X-Received: by 2002:a81:7108:0:b0:5d3:55ae:90d6 with SMTP id
 m8-20020a817108000000b005d355ae90d6mr7037705ywc.28.1702489367283; Wed, 13 Dec
 2023 09:42:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213165741.93528-1-jhs@mojatatu.com> <CANn89iK+4p7i_+NaLQq5S7yQ+JB=ZEUJEsxvFkzamttzm21u8A@mail.gmail.com>
In-Reply-To: <CANn89iK+4p7i_+NaLQq5S7yQ+JB=ZEUJEsxvFkzamttzm21u8A@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 13 Dec 2023 12:42:35 -0500
Message-ID: <CAM0EoMmXp2p3kSHBbG5htKcCrJPWuXAo4v8trrf22s8dTskrdA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net_sched: sch_fq: Fix out of range band computation
To: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemb@google.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	netdev@vger.kernel.org, pctammela@mojatatu.com, victor@mojatatu.com, 
	Coverity Scan <scan-admin@coverity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 12:30=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Dec 13, 2023 at 5:57=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > It is possible to compute a band of 3. Doing so will overrun array
> > q->band_pkt_count[0-2] boundaries.
> >
> > Fixes: 29f834aa326e ("net_sched: sch_fq: add 3 bands and WRR scheduling=
")
> > Reported-by: Coverity Scan <scan-admin@coverity.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> >  net/sched/sch_fq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > index 3a31c47fea9b..217c430343df 100644
> > --- a/net/sched/sch_fq.c
> > +++ b/net/sched/sch_fq.c
> > @@ -159,7 +159,7 @@ struct fq_sched_data {
> >  /* return the i-th 2-bit value ("crumb") */
> >  static u8 fq_prio2band(const u8 *prio2band, unsigned int prio)
> >  {
> > -       return (prio2band[prio / 4] >> (2 * (prio & 0x3))) & 0x3;
> > +       return (prio2band[prio / 4] >> (2 * (prio & 0x3))) % 0x3;
> >  }
> >
>
> Are you sure this is needed ?
>

According to coverity static analysis.

> fq_load_priomap() makes sure this can not happen...

True. Sounds like a false positive because coverity sees the masking
with &0x3 and assumes we could get a result of 3.

cheers,
jamal

