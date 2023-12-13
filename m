Return-Path: <netdev+bounces-57038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28124811B6F
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 18:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821961F21941
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 17:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8413556B86;
	Wed, 13 Dec 2023 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3i3YXhu0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C43110D
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 09:42:50 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso34a12.1
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 09:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702489369; x=1703094169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6HDqMnTEYxYEiyYODeFWz0qKheku0Qvr8il/Hh/jGg=;
        b=3i3YXhu0EiXXx4J7vAY08zgbLnGByrkH9GtAfX1+BV6PhJsNtKc5rqu9/zCSUNxU6G
         jDPk2pUvAZ886w/51qIF+ygb+/YK9jTZfWQJJ/Dx7aDH9KyiHHb7Js7nDl4JCUe1HeX+
         iSr6zeQVjlIAnfkW43DesXca8x5zFaBhGBthMphbRjGQOhmW3c82rPqijIVOnMfCdEwz
         zCurNh+h/5O83lsOw6hjLCQKZv0yYOhaA27tgaiH9WJb4NvFMjnbZB6PCfCIg/uDK2cN
         XnM5FK4tXb2JPACC3DvPu1aOj+qhekF27BD/sBp39BZLwUWxs6jEDJyElEV8ARxA6a/B
         uq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702489369; x=1703094169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6HDqMnTEYxYEiyYODeFWz0qKheku0Qvr8il/Hh/jGg=;
        b=Xdv9om3vzBd10MgAZsUM40gx6q8nOUIX9X/cNurvnEjE2wwsX7md8TZoRiVS5Z1+zv
         Ax8O4A4/am/QprnBku91gncT1EHgXwK8YoYgLBkKQnri9RVVEG548QnrxOD+9TLUR8WZ
         SpxSKR5irPvMbEF2b7OrzYiRpfx36LuDdKnyl5xr267CVqfODV9iVkjc4oQJP07jZg0P
         un14L62W/AUnGH3j0h4Ga5wyMeJUIHEbZAtrmXz/m+8FKsTmwCRnmiuWfbvcWbOk6hn0
         ei+vaedMEQ9rzcYKJIht3HJU/vEXvJHkzPZ2WbyuuGMSIJUbs4F2M7VuXfs2fYsxtI0c
         pShQ==
X-Gm-Message-State: AOJu0Yzpmh9vF4vKZ6uZAu+KUdt7BDV1icgm2uUOCo4oKooFOxqLZK+U
	pMFbMXrjNHHYCZhTP3rOGWw9YHMWEHVDSwJApPxqmg==
X-Google-Smtp-Source: AGHT+IF+VYJrevyv/es22vbxMiD2X5UOdd6QpJ4GklUXoy+cGM25LOxi22lXrv6WZmo0RDn13jBJeBn5iCuxaFCEiAc=
X-Received: by 2002:a50:ccde:0:b0:54c:384b:e423 with SMTP id
 b30-20020a50ccde000000b0054c384be423mr489660edj.5.1702489368415; Wed, 13 Dec
 2023 09:42:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213165741.93528-1-jhs@mojatatu.com> <CANn89iK+4p7i_+NaLQq5S7yQ+JB=ZEUJEsxvFkzamttzm21u8A@mail.gmail.com>
In-Reply-To: <CANn89iK+4p7i_+NaLQq5S7yQ+JB=ZEUJEsxvFkzamttzm21u8A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 13 Dec 2023 18:42:35 +0100
Message-ID: <CANn89iK-4==X-bELpZwLVJCBNOoDYfZEQkCOtNeSRqc=CT-PEw@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net_sched: sch_fq: Fix out of range band computation
To: Jamal Hadi Salim <jhs@mojatatu.com>, Willem de Bruijn <willemb@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, netdev@vger.kernel.org, pctammela@mojatatu.com, 
	victor@mojatatu.com, Coverity Scan <scan-admin@coverity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 6:29=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
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
> fq_load_priomap() makes sure this can not happen...

Yeah, I am pretty sure this patch is incorrect, we need to mask to get
only two bits.

