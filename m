Return-Path: <netdev+bounces-27831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4B677D62E
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 00:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7C71C20E99
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 22:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14C218B16;
	Tue, 15 Aug 2023 22:32:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E627417733
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 22:32:18 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A562100
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 15:32:01 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5257f2c0773so539761a12.2
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 15:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692138720; x=1692743520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6R1K7ydUNFwtjoi/u3FY7+KS9fiu0n5Lc1EtyEIeePE=;
        b=eB2hYLGDWreCCGz4u7/lLVM/3mhrrmlpJmf6qykpGgYnFwjWbaWXqmpDzPRIWrbTV7
         chAc0pfd09KQ7RQAMFhAP41RI2jD7JJDedvL0yl2tPrkUs6AmYdlZ6oKnnN7mEyeyztp
         IvP7TwBmkEMW7DgDQR4gERPEcxcrzeZ1NYUb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692138720; x=1692743520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6R1K7ydUNFwtjoi/u3FY7+KS9fiu0n5Lc1EtyEIeePE=;
        b=Xedua6AtDlvUQX1WukUPl6Gw2yorJzdwEaIFGYQu0Qrs9sjn+ZNtS26E3qzLhpgyM8
         sT8SnrWPvTY3bf7eZFMpnEv2r7i6fmFceRaAy3wecY5P75eF+7AzEMnznJY7TqHbLeLM
         fTONiyA3G5eW0tKt4I26/itctt1VkT4s/+rlqRRBa4A1bU7nDY7BCphdxaJND3rDmZv4
         eH+SmL6TAenOQhwQwaqChn/eV5bndhQX7rEv/c785dOM2CALklTY6BADdm12g69KZHEv
         9q/u1ucEzf3f6uDsl0D1YSEm4rhbE2i3PYwByC/SsOfW4hV7YjUtaBSQpkwAsqm31AOe
         P/Pw==
X-Gm-Message-State: AOJu0YxYRpGc62rnonexxhYonqgw1oohWofPwT/8IqWCRv5Ua8/TMoaw
	zTWerpKXUSoSwyTXnkwEXG/thy2SozkAlawsdrdaMA==
X-Google-Smtp-Source: AGHT+IHLnvvHpVGa2ywLMBcWm2YOrhVOII3BV6OZjuJ+ojTRMx3vBIotf2jz9W0SnMJBKanY97CG/LjI41ukHSMs1Cs=
X-Received: by 2002:aa7:d1ce:0:b0:523:d1e0:7079 with SMTP id
 g14-20020aa7d1ce000000b00523d1e07079mr140764edp.21.1692138720456; Tue, 15 Aug
 2023 15:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230814093528.117342-1-bigeasy@linutronix.de>
 <20230814093528.117342-3-bigeasy@linutronix.de> <25de7655-6084-e6b9-1af6-c47b3d3b7dc1@kernel.org>
In-Reply-To: <25de7655-6084-e6b9-1af6-c47b3d3b7dc1@kernel.org>
From: Yan Zhai <yan@cloudflare.com>
Date: Tue, 15 Aug 2023 17:31:49 -0500
Message-ID: <CAO3-PbpX_Hzxy5aj-mppnipm2HE63oB-p51DAV7v9HvSNS9y6Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] softirq: Drop the warning from do_softirq_post_smp_call_flush().
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Wander Lairson Costa <wander@redhat.com>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 15, 2023 at 7:08=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
>
>
> On 14/08/2023 11.35, Sebastian Andrzej Siewior wrote:
> > This is an undesired situation and it has been attempted to avoid the
> > situation in which ksoftirqd becomes scheduled. This changed since
> > commit d15121be74856 ("Revert "softirq: Let ksoftirqd do its job"")
> > and now a threaded interrupt handler will handle soft interrupts at its
> > end even if ksoftirqd is pending. That means that they will be processe=
d
> > in the context in which they were raised.
>
> $ git describe --contains d15121be74856
> v6.5-rc1~232^2~4
>
> That revert basically removes the "overload" protection that was added
> to cope with DDoS situations in Aug 2016 (Cc. Cloudflare).  As described
> in https://git.kernel.org/torvalds/c/4cd13c21b207 ("softirq: Let
> ksoftirqd do its job") in UDP overload situations when UDP socket
> receiver runs on same CPU as ksoftirqd it "falls-off-an-edge" and almost
> doesn't process packets (because softirq steals CPU/sched time from UDP
> pid).  Warning Cloudflare (Cc) as this might affect their production
> use-cases, and I recommend getting involved to evaluate the effect of
> these changes.
>
> I do realize/acknowledge that the reverted patch caused other latency
> issues, given it was a "big-hammer" approach affecting other softirq
> processing (as can be seen by e.g. the watchdog fixes patches).
> Thus, the revert makes sense, but how to regain the "overload"
> protection such that RX networking cannot starve processes reading from
> the socket? (is this what Sebastian's patchset does?)
>
Thanks for notifying us. We will need to evaluate if this is going to
change the picture under serious floods.

Yan

> --Jesper
>
> Thread link for people Cc'ed:
> https://lore.kernel.org/all/20230814093528.117342-1-bigeasy@linutronix.de=
/#r

