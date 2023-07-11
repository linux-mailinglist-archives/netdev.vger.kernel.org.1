Return-Path: <netdev+bounces-16866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C49174F128
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 16:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E401C20F67
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 14:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8440319BA1;
	Tue, 11 Jul 2023 14:06:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E4C14AB5
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 14:06:38 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BF79E;
	Tue, 11 Jul 2023 07:06:36 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6b711c3ad1fso4686128a34.0;
        Tue, 11 Jul 2023 07:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689084396; x=1691676396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtrkZvukDlSziDN0KAKNR+HUJU/841tM48VnLXRDDo8=;
        b=E0N5tqHigGPruoL2OipUVobpIf9hqdDDMV7POeXa1hvOx/8WegYkYYvn94MTxxKxJB
         kz47DRPK9wkaxvKzUSaY/Y5NlpuFvJrZGr9WdXtD9WeHuH1QPn6YfSKm2WXdsQ4C/nJ+
         wGf9iWDQJevFgkRbJVqy2mhM7TzViwcncDXgJ22Kl0qGyfrLCaUyT5k+sNh9RqGx34Gx
         pdLGBeyBUw4jhdjtVHTGavhSKH3cbKBPalYtCzo3KDQIVwi6Iu1tcNpWzbZ7KHdC8Prn
         jyuMsehIt3AeI6jMw4g86lWQZy9DYYpg0qGYUZoHXk7+nM07DGLlBBk9a/xtkNBH33zs
         ShZg==
X-Gm-Message-State: ABy/qLbsxYrWnbJ+5hYqjKPUD1ObgOhYkc0vm0/kt6yZAz2DQ889PHUF
	B5c8bhSWUQelj8p6zepVpdl6RlP5cApBRw==
X-Google-Smtp-Source: APBJJlHk6JvYY7usor+bMX+25K9L8lRHpC1MM+kzOkVK2RhHg0e+lmulc9h6UW2o6cwVtHPj090TVw==
X-Received: by 2002:a05:6870:b608:b0:1b0:7078:58ad with SMTP id cm8-20020a056870b60800b001b0707858admr17820465oab.38.1689084395878;
        Tue, 11 Jul 2023 07:06:35 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id e3-20020a056870944300b001a6a3f99691sm1029564oal.27.2023.07.11.07.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 07:06:35 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6b87d505e28so4671725a34.2;
        Tue, 11 Jul 2023 07:06:35 -0700 (PDT)
X-Received: by 2002:a9d:560a:0:b0:6b8:83ca:560a with SMTP id
 e10-20020a9d560a000000b006b883ca560amr13140949oti.18.1689084395442; Tue, 11
 Jul 2023 07:06:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230511181931.869812-1-tj@kernel.org> <20230511181931.869812-7-tj@kernel.org>
 <ZF6WsSVGX3O1d0pL@slm.duckdns.org> <CAMuHMdVCQmh6V182q4g---jvsWiTOP2hBPZKvma6oUN6535LEg@mail.gmail.com>
In-Reply-To: <CAMuHMdVCQmh6V182q4g---jvsWiTOP2hBPZKvma6oUN6535LEg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Jul 2023 16:06:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW1kxZ1RHKTRVRqDNAbj1Df2=v0fPn5KYK3kfX_kiXR6A@mail.gmail.com>
Message-ID: <CAMuHMdW1kxZ1RHKTRVRqDNAbj1Df2=v0fPn5KYK3kfX_kiXR6A@mail.gmail.com>
Subject: Re: Consider switching to WQ_UNBOUND messages (was: Re: [PATCH v2
 6/7] workqueue: Report work funcs that trigger automatic CPU_INTENSIVE mechanism)
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, 
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-team@meta.com, 
	Linux PM list <linux-pm@vger.kernel.org>, 
	DRI Development <dri-devel@lists.freedesktop.org>, linux-rtc@vger.kernel.org, 
	linux-riscv <linux-riscv@lists.infradead.org>, netdev <netdev@vger.kernel.org>, 
	Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, 
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 3:55=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Tejun,
>
> On Fri, May 12, 2023 at 9:54=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> > Workqueue now automatically marks per-cpu work items that hog CPU for t=
oo
> > long as CPU_INTENSIVE, which excludes them from concurrency management =
and
> > prevents stalling other concurrency-managed work items. If a work funct=
ion
> > keeps running over the thershold, it likely needs to be switched to use=
 an
> > unbound workqueue.
> >
> > This patch adds a debug mechanism which tracks the work functions which
> > trigger the automatic CPU_INTENSIVE mechanism and report them using
> > pr_warn() with exponential backoff.
> >
> > v2: Drop bouncing through kthread_worker for printing messages. It was =
to
> >     avoid introducing circular locking dependency but wasn't effective =
as it
> >     still had pool lock -> wci_lock -> printk -> pool lock loop. Let's =
just
> >     print directly using printk_deferred().
> >
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
>
> Thanks for your patch, which is now commit 6363845005202148
> ("workqueue: Report work funcs that trigger automatic CPU_INTENSIVE
> mechanism") in v6.5-rc1.
>
> I guess you are interested to know where this triggers.
> I enabled CONFIG_WQ_CPU_INTENSIVE_REPORT=3Dy, and tested
> the result on various machines...

> OrangeCrab/Linux-on-LiteX-VexRiscV with ht16k33 14-seg display and ssd130=
xdrmfb:
>
>   workqueue: check_lifetime hogged CPU for >10000us 4 times, consider
> switching to WQ_UNBOUND
>   workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 1024
> times, consider switching to WQ_UNBOUND
>   workqueue: fb_flashcursor hogged CPU for >10000us 128 times,
> consider switching to WQ_UNBOUND
>   workqueue: ht16k33_seg14_update hogged CPU for >10000us 128 times,
> consider switching to WQ_UNBOUND
>   workqueue: mmc_rescan hogged CPU for >10000us 128 times, consider
> switching to WQ_UNBOUND

Got one more after a while:

workqueue: neigh_managed_work hogged CPU for >10000us 4 times,
consider switching to WQ_UNBOUND

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

