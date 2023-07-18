Return-Path: <netdev+bounces-18534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228AB757891
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 11:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536BB1C208F1
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 09:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FF4F9EA;
	Tue, 18 Jul 2023 09:55:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367ADF9D4
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 09:55:30 +0000 (UTC)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C7626B2;
	Tue, 18 Jul 2023 02:55:12 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-c2cf4e61bc6so5807310276.3;
        Tue, 18 Jul 2023 02:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689674112; x=1692266112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkfu4+zrfsEvNM/oP4wLx2h/8nsgQPK5hugPJnR2T8Y=;
        b=bpbkAuFRysVLakByeshb8zpAsRtDwSouyWI2zK8LDbire43Ga6Px797CbkzAEiYTKh
         piTAc/yW/QL3vr53oUbNpxFt5cPJkATey1YCK71ZQagCHeVXrO32uIis8HA7XLQFfqsW
         S5n52bvq5HBIybyTxHoC8tZ3iUO5lzXGf0Oai+tGxmOCqcyqyD9P34lpYl0pQppd/BLd
         xFtARFHae+ozxOlCh1aIc0RgweteWxn/3C7dNypw34JcK45OkiqAiJGGCJUzpWg6mavK
         PqldY9eDrQR3+uGc4HbfLWR05ihT06SvVrQh22NKEjO2C3COV1RX6dSdLs3T51QHncMi
         yoeg==
X-Gm-Message-State: ABy/qLaKFV4gKKmCio9VcszED83JhY/l94h7gsHuaSgsQvcG/fREdS2p
	Sq903AZKZLFu6PblYNwErObL3XvKfNFUbA==
X-Google-Smtp-Source: APBJJlGPc04fhgxz0E0wgRdcDYs3513a4we7nVqGeT+GTp9gDnYZ0rkf654mHClpLr/GNVPMHelMGg==
X-Received: by 2002:a25:6fc2:0:b0:c91:717e:7658 with SMTP id k185-20020a256fc2000000b00c91717e7658mr2408070ybc.2.1689674111749;
        Tue, 18 Jul 2023 02:55:11 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id x71-20020a25ce4a000000b00cec105e03d1sm123056ybe.38.2023.07.18.02.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 02:55:10 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso5811573276.2;
        Tue, 18 Jul 2023 02:55:10 -0700 (PDT)
X-Received: by 2002:a25:860f:0:b0:cec:59f7:b352 with SMTP id
 y15-20020a25860f000000b00cec59f7b352mr989091ybk.58.1689674110647; Tue, 18 Jul
 2023 02:55:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230511181931.869812-1-tj@kernel.org> <20230511181931.869812-7-tj@kernel.org>
 <ZF6WsSVGX3O1d0pL@slm.duckdns.org> <CAMuHMdVCQmh6V182q4g---jvsWiTOP2hBPZKvma6oUN6535LEg@mail.gmail.com>
 <CAMuHMdW1kxZ1RHKTRVRqDNAbj1Df2=v0fPn5KYK3kfX_kiXR6A@mail.gmail.com>
 <ZK3MBfPS-3-tJgjO@slm.duckdns.org> <ZK30CR196rs-OWLq@slm.duckdns.org>
 <CAMuHMdUCXPi+aS-7bR3qRetKF9T3W9jk_HKjvaXmfHv5SEeuFg@mail.gmail.com> <ZLXIvXBvhsnL-ik_@slm.duckdns.org>
In-Reply-To: <ZLXIvXBvhsnL-ik_@slm.duckdns.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Jul 2023 11:54:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU8CGhsU-1PZNdWH1xjbWcWSg2s2RFAegXi+vs=d-0t8Q@mail.gmail.com>
Message-ID: <CAMuHMdU8CGhsU-1PZNdWH1xjbWcWSg2s2RFAegXi+vs=d-0t8Q@mail.gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Tejun,

On Tue, Jul 18, 2023 at 1:03=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
> Can you please the following patch and see how many reports you get? Look=
ing
> back at your reports, I think some of them probably should be converted t=
o
> UNBOUND but we should have a better idea with the adjusted threshold.
>
> Thanks.
>
> From 8555cbd4b22e5f85eb2bdcb84fd1d1f519a0a0d3 Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Mon, 17 Jul 2023 12:50:02 -1000
> Subject: [PATCH] workqueue: Scale up wq_cpu_intensive_thresh_us if BogoMI=
PS is
>  below 1000
>
> wq_cpu_intensive_thresh_us is used to detect CPU-hogging per-cpu work ite=
ms.
> Once detected, they're excluded from concurrency management to prevent th=
em
> from blocking other per-cpu work items. If CONFIG_WQ_CPU_INTENSIVE_REPORT=
 is
> enabled, repeat offenders are also reported so that the code can be updat=
ed.
>
> The default threshold is 10ms which is long enough to do fair bit of work=
 on
> modern CPUs while short enough to be usually not noticeable. This
> unfortunately leads to a lot of, arguable spurious, detections on very sl=
ow
> CPUs. Using the same threshold across CPUs whose performance levels may b=
e
> apart by multiple levels of magnitude doesn't make whole lot of sense.
>
> This patch scales up wq_cpu_intensive_thresh_us upto 1 second when BogoMI=
PS
> is below 1000. This is obviously very inaccurate but it doesn't have to b=
e
> accurate to be useful. The mechanism is still useful when the threshold i=
s
> fully scaled up and the benefits of reports are usually shared with every=
one
> regardless of who's reporting, so as long as there are sufficient number =
of
> fast machines reporting, we don't lose much.
>
> Some (or is it all?) ARM CPUs systemtically report significantly lower
> BogoMIPS. While this doesn't break anything, given how widespread ARM CPU=
s
> are, it's at least a missed opportunity and it probably would be a good i=
dea
> to teach workqueue about it.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>

Thanks!

I gave it a try on a system with an 800 MHz Cortex A9, only to discover
it makes no difference, as that machine has 1600 BogoMIPS:

workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 4 times,
consider switching to WQ_UNBOUND
workqueue: drm_fb_helper_damage_work hogged CPU for >10000us 8 times,
consider switching to WQ_UNBOUND
workqueue: genpd_power_off_work_fn hogged CPU for >10000us 4 times,
consider switching to WQ_UNBOUND
workqueue: blk_mq_run_work_fn hogged CPU for >10000us 4 times,
consider switching to WQ_UNBOUND
workqueue: pm_runtime_work hogged CPU for >10000us 4 times, consider
switching to WQ_UNBOUND
workqueue: phy_state_machine hogged CPU for >10000us 4 times, consider
switching to WQ_UNBOUND
workqueue: drm_mode_rmfb_work_fn hogged CPU for >10000us 4 times,
consider switching to WQ_UNBOUND
workqueue: sync_hw_clock hogged CPU for >10000us 4 times, consider
switching to WQ_UNBOUND
workqueue: rtc_timer_do_work hogged CPU for >10000us 4 times, consider
switching to WQ_UNBOUND

Artificially low BogoMIPS numbers only happen on systems that have
the related timers (Cortex A7/A15 and later, Cortex A9 MPCore,
and arm64).

I will test on more systems, but that will probably not happen until
next week...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

