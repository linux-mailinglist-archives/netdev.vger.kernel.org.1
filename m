Return-Path: <netdev+bounces-35332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3027A8E85
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 23:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCF64B2077E
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 21:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB824405D8;
	Wed, 20 Sep 2023 21:32:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763AE41A88
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 21:32:39 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A8083
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 14:32:37 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-41761e9181eso51671cf.1
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 14:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695245556; x=1695850356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9wfUCaHx2BJYGBfZgiM/E4DpL0IZmdB+QjwLVNJu3U=;
        b=jqtwKaCytLygL85fP3CEaYNU/+0X7pXLqhgjW1XTp0SY+yzlvDejwTa94j8Iv/DLFr
         DMAlxMr44f3fJRQJgIf0PW2wtZ9dHowThcwRro+nlQwOP+Rbxp5VsPpeHTTDKra05Mee
         MPP+9GYRJeZFtKsp/tgJ8xFWCsYAvmDT/2ewxuuoXOjWIiPA98O5dP5onAwB7C85kb67
         9/Pn7rJ/lEXdVfkcUfoTvhzdjQCXPlowIzU0Mc+TwHk28+FaFWlGOFwOL7xHPvhfsggo
         xFIv7bx7SGFbaJWfBMNOp4H/wzQ3HDr69BELCk0FjSuPSQpKjnnYaPRjl+QtzMsKeBDk
         MO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695245556; x=1695850356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9wfUCaHx2BJYGBfZgiM/E4DpL0IZmdB+QjwLVNJu3U=;
        b=rkj/92Jeg1Q4rTxkB0AdqA4I9gZLm7CDXLLy9GXvKy/8reQMcKKkbfqC+Y1fOt3fio
         oOHTmNQEyCmSB5kAXlpMxjZLCGCLhMGrZ1K1kSupTybOQStJTMWKw1WEbAJKQK0JKczo
         02ZI1iw3G8j8LPF7EbW+XT0khpasfwssAfEynjdG49t1JYKmC/U8lOQuITmvUjVAQsm/
         vYrwc7qNmG142DimSojIcnsRLUpGtLgFFCiYyrn9wlG4lp9A5ttAnxdJQV+qYFgdizul
         8bEou7f63id5XmHb9uuTid6OmluwswyYRbbSrHYuRDtprpKmCmuIRtoRil31orTE2jFh
         PU+A==
X-Gm-Message-State: AOJu0Yx2BCkmHdIwOtmSwl5Li9KIBYRnQn9lB534zIRZIszk0AcJWoLn
	gjYMAIayZ+D1y991P4mDgpLEDUST9+76cew8Gc8QpQ==
X-Google-Smtp-Source: AGHT+IG6Z24Vtf4xtkta5LpLm34ziooETFsTVq5oKng6LyscDNxOtaEvk90A7xiu190DkcyabBfK11Wmdt9YfwyzsWQ=
X-Received: by 2002:a05:622a:24b:b0:410:9855:ac6 with SMTP id
 c11-20020a05622a024b00b0041098550ac6mr82540qtx.14.1695245555792; Wed, 20 Sep
 2023 14:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920201715.418491-1-edumazet@google.com> <20230920201715.418491-2-edumazet@google.com>
 <CAM0EoMmKrUwMBqKeBSDCe-pa=7ouMYhCtpv7tRR6uzxkn_hGfA@mail.gmail.com>
In-Reply-To: <CAM0EoMmKrUwMBqKeBSDCe-pa=7ouMYhCtpv7tRR6uzxkn_hGfA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 20 Sep 2023 23:32:24 +0200
Message-ID: <CANn89iJNbZq+HWGnWrKBc8ULE=HVK04VUs2TrvWYu5Ef1vy+yQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/5] net_sched: constify qdisc_priv()
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 10:45=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Wed, Sep 20, 2023 at 4:17=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > In order to propagate const qualifiers, we change qdisc_priv()
> > to accept a possibly const argument.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  include/net/pkt_sched.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
> > index 15960564e0c364ef430f1e3fcdd0e835c2f94a77..9fa1d0794dfa5241705f9a3=
9c896ed44519a9f13 100644
> > --- a/include/net/pkt_sched.h
> > +++ b/include/net/pkt_sched.h
> > @@ -20,10 +20,10 @@ struct qdisc_walker {
> >         int     (*fn)(struct Qdisc *, unsigned long cl, struct qdisc_wa=
lker *);
> >  };
> >
> > -static inline void *qdisc_priv(struct Qdisc *q)
> > -{
> > -       return &q->privdata;
> > -}
> > +#define qdisc_priv(q)                                                 =
 \
> > +       _Generic(q,                                                    =
 \
> > +                const struct Qdisc * : (const void *)&q->privdata,    =
 \
> > +                struct Qdisc * : (void *)&q->privdata)
>
> Didnt know you could do this - C11? Would old compilers work here or
> do we have some standardization version around compiler versions?

We already use this in the tree, I would not worry for more instances
of _Generic()

commit 6ec4476ac82512f09c94aff5972654b70f3772b2
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Jul 8 10:48:35 2020 -0700

    Raise gcc version requirement to 4.9

    I realize that we fairly recently raised it to 4.8, but the fact is, 4.=
9
    is a much better minimum version to target.

    We have a number of workarounds for actual bugs in pre-4.9 gcc versions
    (including things like internal compiler errors on ARM), but we also
    have some syntactic workarounds for lacking features.

    In particular, raising the minimum to 4.9 means that we can now just
    assume _Generic() exists, which is likely the much better replacement
    for a lot of very convoluted built-time magic with conditionals on
    sizeof and/or __builtin_choose_expr() with same_type() etc.

    Using _Generic also means that you will need to have a very recent
    version of 'sparse', but thats easy to build yourself, and much less of
    a hassle than some old gcc version can be.

    The latest (in a long string) of reasons for minimum compiler version
    upgrades was commit 5435f73d5c4a ("efi/x86: Fix build with gcc 4").

    Ard points out that RHEL 7 uses gcc-4.8, but the people who stay back o=
n
    old RHEL versions persumably also don't build their own kernels anyway.
    And maybe they should cross-built or just have a little side affair wit=
h
    a newer compiler?

    Acked-by: Ard Biesheuvel <ardb@kernel.org>
    Acked-by: Peter Zijlstra <peterz@infradead.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

