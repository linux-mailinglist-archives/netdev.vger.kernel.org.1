Return-Path: <netdev+bounces-27272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B2977B50E
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 11:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6690828101D
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 09:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69944A946;
	Mon, 14 Aug 2023 09:05:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1D4A927
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 09:05:09 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE02127;
	Mon, 14 Aug 2023 02:05:05 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-586bacac98aso36725407b3.2;
        Mon, 14 Aug 2023 02:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692003904; x=1692608704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3ycoIeppxdN8sWq7VOLxcXgAcJ1tGCUh5KzOAHQXXk=;
        b=Sk0SA8swx/aCuGFqb0IzKhT9bOxQK1AOpljXy63hkdLB1k1Ua1xsRSno4LwntvSuUv
         4A2fqXLvGRgxaHrhOxfCCzm0E2U425UI27XOFCQY2c7/YK7SM0Mjr9SwPqW7nauFbiqW
         lYEQaZAvipoeXDudCnqsCjnLWxsG3YRVm2h8XuTd6N9LYzPYcYArJI6d1jA1QsSUuRpT
         nJZYUk/ohTGwtJu47uqKVJriLUuT4YAU24UfB+QIrs5qzdGMMmJgrU1VevirlCL5FB7j
         NTwNaQYLwc0Y84Z4iv7YoUMoSmACO6uOX9WUdVsfwKwGRPNrx210vQkN1HUNWOxXLjR5
         S9pg==
X-Gm-Message-State: AOJu0YxwUy9NFuhd7jv/7JeW2Sx71yiSFGR/qVjX3LAF78tL6tbEqnGH
	MRBNff1xACzoHLhckdPAwev1m5aTLOeiTQ==
X-Google-Smtp-Source: AGHT+IGge39ImiDb+7423s3QNFIxfPMQNSIY3UxBvi3pEJZJXQq7z9AHiqru5cHEjTcVYtyYUJj6hQ==
X-Received: by 2002:a0d:cbcb:0:b0:589:f47b:beac with SMTP id n194-20020a0dcbcb000000b00589f47bbeacmr1885768ywd.39.1692003904373;
        Mon, 14 Aug 2023 02:05:04 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id e187-20020a8169c4000000b00559fb950d9fsm2659794ywc.45.2023.08.14.02.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 02:05:03 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-d690c9fbda3so631450276.0;
        Mon, 14 Aug 2023 02:05:03 -0700 (PDT)
X-Received: by 2002:a25:e090:0:b0:d4f:f231:78be with SMTP id
 x138-20020a25e090000000b00d4ff23178bemr8026219ybg.6.1692003903683; Mon, 14
 Aug 2023 02:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACna6rxpzDWE5-gnmpgMgfzPmmHvEGTZk4GJvJ8jLSMazh2bVA@mail.gmail.com>
 <bd5feeb3-bc44-d4d2-7708-eea9243b49a4@gmail.com> <0f9d0cd6-d344-7915-7bc1-7a090b8305d2@gmail.com>
In-Reply-To: <0f9d0cd6-d344-7915-7bc1-7a090b8305d2@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Aug 2023 11:04:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXPB+nSHUTPufiaRP0cxvk2_raEHavwTouaiWibdQtCTg@mail.gmail.com>
Message-ID: <CAMuHMdXPB+nSHUTPufiaRP0cxvk2_raEHavwTouaiWibdQtCTg@mail.gmail.com>
Subject: Re: ARM board lockups/hangs triggered by locks and mutexes
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Florian Fainelli <f.fainelli@gmail.com>, linux-clk@vger.kernel.org, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	Network Development <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	OpenWrt Development List <openwrt-devel@lists.openwrt.org>, 
	bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Rafal,

On Mon, Aug 7, 2023 at 1:11=E2=80=AFPM Rafa=C5=82 Mi=C5=82ecki <zajec5@gmai=
l.com> wrote:
> On 4.08.2023 13:07, Rafa=C5=82 Mi=C5=82ecki wrote:
> > I triple checked that. Dropping a single unused function breaks kernel =
/
> > device stability on BCM53573!
> >
> > AFAIK the only thing below diff actually affects is location of symbols
> > (I actually verified that by comparing System.map before and after -
> > over 22'000 of relocated symbols).
> >
> > Can some unfortunate location of symbols cause those hangs/lockups?
>
> I performed another experiment. First I dropped mtd_check_of_node() to
> bring kernel back to the stable state.
>
> Then I started adding useless code to the mtdchar_unlocked_ioctl(). I
> ended up adding just enough to make sure all post-mtd symbols in
> System.map got the same offset as in case of backporting
> mtd_check_of_node().
>
> I started experiencing lockups/hangs again.
>
> I repeated the same test with adding dumb code to the brcm_nvram_probe()
> and verifying symbols offsets following brcm_nvram_probe one.
>
> I believe this confirms that this problem is about offset or alignment
> of some specific symbol(s). The remaining question is what symbols and
> how to fix or workaround that.

I had similar experiences on other ARM platforms many years ago:
bisection lead to something completely bogus, and it turned out
adding a single line of innocent code made the system lock-up or crash
unexpectedly.  It was definitely related to alignment, as adding the
right extra amount of innocent code would fix the problem. Until some
later change changing alignment again...
I never found the real cause, but the problems went away over time.
I am not sure I did enable all required errata config options, so I
may have missed some...

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

