Return-Path: <netdev+bounces-28124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B04077E4DA
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 17:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48B0281A27
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 15:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DF4156D8;
	Wed, 16 Aug 2023 15:15:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E05156C0
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 15:15:55 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370E1211E
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 08:15:53 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52580a24128so1315180a12.2
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 08:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692198951; x=1692803751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puvpXW6WtSEP5qYHIEgG+Dhh07YeGJgxRWhJ33GofDw=;
        b=hPdP6/Pvgbypz2R1NLKsnjwN0zT4V8KAIsSKb4zKoApe0zHtDATs52jCF7sf4HvuJG
         mLDau1naZhXgX8cNogp2rojGSmJzD7PW/IZmTgdwPhip8D2vMgeJ7SFKq0eY+BgvTH1N
         ws3Qd9XQi9OUBrCMzrtO3rJTvop/2uibLXwKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692198951; x=1692803751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puvpXW6WtSEP5qYHIEgG+Dhh07YeGJgxRWhJ33GofDw=;
        b=ko4KdxcpPE+Sb9wbFaH6aNr0/oayxOD22dwJJI9iALrr15nxsEsTbCe5uuPMVfASh/
         iN6SUtcCx1SkJHFQp28Hh7iTeIPwdlj40xmii5X8Yc9RREFhKa7FWt+7+rHck+OwipTB
         I80M+Ar1hGTOFPpsz+vtVg06zY7nN8tNZJwMmjaIJQZ+9wDFvgiQDmekLyzEi+Ak3Niv
         D+fW0YMWDNCKcsgMUAOE6UIDRpnzzxKBjHueJVN4qenrxtbINsATWbf/rUevVcI13w52
         LDRxl9pPBwfPClDTzeyvGQsjODfm6/LDPa3qO4wL7X2QCj9mv996+HLeJE7Y+2SAGhfx
         ez6Q==
X-Gm-Message-State: AOJu0Yzcjzu5vQFxaqzavkmF6xfVMAdGRs0frEgGOzqfIakm3jcN3sXp
	iQpUbku5GQ5UdBaEb+1R1LwwiN61gFfeCF6t7+Rd/Q==
X-Google-Smtp-Source: AGHT+IHfzSFhf/ohbt4wYzNrb2XP60Adg1atddS4UD94IEueZA9iVab1ihN9aiEi4THtZZnDxmlrSfSLduUvbp/Z/f4=
X-Received: by 2002:aa7:ce14:0:b0:525:6cc7:8092 with SMTP id
 d20-20020aa7ce14000000b005256cc78092mr1715070edv.13.1692198951586; Wed, 16
 Aug 2023 08:15:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230814093528.117342-1-bigeasy@linutronix.de>
 <20230814093528.117342-3-bigeasy@linutronix.de> <25de7655-6084-e6b9-1af6-c47b3d3b7dc1@kernel.org>
 <d1b510a0-139a-285d-1a80-2592ea98b0d6@kernel.org>
In-Reply-To: <d1b510a0-139a-285d-1a80-2592ea98b0d6@kernel.org>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 16 Aug 2023 10:15:40 -0500
Message-ID: <CAO3-PbpbrK6FAACw5TQyBxJ6jgO7_bhLFuPVAziUE+40_o_GnA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] softirq: Drop the warning from do_softirq_post_smp_call_flush().
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Wander Lairson Costa <wander@redhat.com>, linux-kernel@vger.kernel.org, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 9:49=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
>
>
> On 15/08/2023 14.08, Jesper Dangaard Brouer wrote:
> >
> >
> > On 14/08/2023 11.35, Sebastian Andrzej Siewior wrote:
> >> This is an undesired situation and it has been attempted to avoid the
> >> situation in which ksoftirqd becomes scheduled. This changed since
> >> commit d15121be74856 ("Revert "softirq: Let ksoftirqd do its job"")
> >> and now a threaded interrupt handler will handle soft interrupts at it=
s
> >> end even if ksoftirqd is pending. That means that they will be process=
ed
> >> in the context in which they were raised.
> >
> > $ git describe --contains d15121be74856
> > v6.5-rc1~232^2~4
> >
> > That revert basically removes the "overload" protection that was added
> > to cope with DDoS situations in Aug 2016 (Cc. Cloudflare).  As describe=
d
> > in https://git.kernel.org/torvalds/c/4cd13c21b207 ("softirq: Let
> > ksoftirqd do its job") in UDP overload situations when UDP socket
> > receiver runs on same CPU as ksoftirqd it "falls-off-an-edge" and almos=
t
> > doesn't process packets (because softirq steals CPU/sched time from UDP
> > pid).  Warning Cloudflare (Cc) as this might affect their production
> > use-cases, and I recommend getting involved to evaluate the effect of
> > these changes.
> >
>
> I did some testing on net-next (with commit d15121be74856 ("Revert
> "softirq: Let ksoftirqd do its job"") using UDP pktgen + udp_sink.
>
> And I observe the old overload issue occur again, where userspace
> process (udp_sink) process very few packets when running on *same* CPU
> as the NAPI-RX/IRQ processing.  The perf report "comm" clearly shows
> that NAPI runs in the context of the "udp_sink" process, stealing its
> sched time. (Same CPU around 3Kpps and diff CPU 1722Kpps, see details
> below).
> What happens are that NAPI takes 64 packets and queue them to the
> udp_sink process *socket*, the udp_sink process *wakeup* process 1
> packet from socket queue and on exit (__local_bh_enable_ip) runs softirq
> that starts NAPI (to again process 64 packets... repeat).
>
I think there are two scenarios to consider:
1. Actual DoS scenario. In this case, we would drop DoS packets
through XDP, which might actually relieve the stress. According to
Marek's blog XDP can indeed drop 10M pps [1] so it might not steal too
much time. This is also something I would like to validate again since
I cannot tell if those tests were performed before or after the
reverted commit.
2. Legit elephant flows (so it should not be just dropped). This one
is closer to what you tested above, and it is a much harder issue
since packets are legit and should not be dropped early at XDP. Let
the scheduler move affected processes away seems to be the non-optimal
but straight answer for now. However, I suspect this would impose an
overload issue for those programmed with RFS or ARFS, since flows
would "follow" the processes. They probably have to force threaded
NAPI for tuning.

[1] https://blog.cloudflare.com/how-to-drop-10-million-packets/

>
> > I do realize/acknowledge that the reverted patch caused other latency
> > issues, given it was a "big-hammer" approach affecting other softirq
> > processing (as can be seen by e.g. the watchdog fixes patches).
> > Thus, the revert makes sense, but how to regain the "overload"
> > protection such that RX networking cannot starve processes reading from
> > the socket? (is this what Sebastian's patchset does?)
> >
>
> I'm no expert in sched / softirq area of the kernel, but I'm willing to
> help out testing different solution that can regain the "overload"
> protection e.g. avoid packet processing "falls-of-an-edge" (and thus
> opens the kernel to be DDoS'ed easily).
> Is this what Sebastian's patchset does?
>
>
> >
> > Thread link for people Cc'ed:
> > https://lore.kernel.org/all/20230814093528.117342-1-bigeasy@linutronix.=
de/#r
>
> --Jesper
> (some testlab results below)
>
> [udp_sink]
> https://github.com/netoptimizer/network-testing/blob/master/src/udp_sink.=
c
>
>
> When udp_sink runs on same CPU and NAPI/softirq
>   - UdpInDatagrams: 2,948 packets/sec
>
> $ nstat -n && sleep 1 && nstat
> #kernel
> IpInReceives                    2831056            0.0
> IpInDelivers                    2831053            0.0
> UdpInDatagrams                  2948               0.0
> UdpInErrors                     2828118            0.0
> UdpRcvbufErrors                 2828118            0.0
> IpExtInOctets                   130206496          0.0
> IpExtInNoECTPkts                2830576            0.0
>
> When udp_sink runs on another CPU than NAPI-RX.
>   - UdpInDatagrams: 1,722,307 pps
>
> $ nstat -n && sleep 1 && nstat
> #kernel
> IpInReceives                    2318560            0.0
> IpInDelivers                    2318562            0.0
> UdpInDatagrams                  1722307            0.0
> UdpInErrors                     596280             0.0
> UdpRcvbufErrors                 596280             0.0
> IpExtInOctets                   106634256          0.0
> IpExtInNoECTPkts                2318136            0.0
>
>


--=20

Yan

