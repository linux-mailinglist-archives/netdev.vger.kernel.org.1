Return-Path: <netdev+bounces-45880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CF77E001C
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 10:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1091C209D9
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 09:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EB4125A8;
	Fri,  3 Nov 2023 09:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWc89r+K"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E21033C1
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 09:53:40 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE287191
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 02:53:37 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54357417e81so10151a12.0
        for <netdev@vger.kernel.org>; Fri, 03 Nov 2023 02:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699005216; x=1699610016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEMB4rup2GcVmUN3BC8IOgWCRAKbKMD4bniP3gCgn7U=;
        b=lWc89r+KoIFIREm2Lbcf86NHT5ao1AbqbwYlZbbCwnM4h29Tr0+uQF+bJyNUGUxMT+
         SYREvlLMahMoA8qxyVkIiXp2ACvUZtXAd+Gb9vG08i69iONPiAhiIAViL6jLs+4h+BVo
         XTxaYeedxuOdDJD1v5i8aFiKUgrPdIS8UM4J+P5BHqNcWvh6u17pei9ipBDZnkCQJKvG
         EuUy01qD3DYhF62NQMzvZht44bvubb4KKRK/3E93ivvj7Cz/9Pf8Jh00Anr2vNdc5MPi
         El9rqwfAIjg6pus5uoIceNAryiUvQ4qPeiykeusHbIKpHVQo6wsXRFD9ZKA2gtBzly37
         NoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699005216; x=1699610016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEMB4rup2GcVmUN3BC8IOgWCRAKbKMD4bniP3gCgn7U=;
        b=hcJo239MxKDTVF81nxwULjtCYND7uy14CFL3wMU7SRBaNw7HLc2daPgciP/jgL2Vg8
         /xHyMTLJq0HyfH1giQpslekdHiLogW3HW35sACnnJrF7LmaFI/EKDUKTZk3bsPHNhLDM
         mURUTm/UyfMeIh9AmFNzt3CJsHJqTHaYzWLg0ZQn3wXfw4/I3d+txtk7CguJ33xamHdN
         fiy9565D2EhuktsuDsEoqfMsP1OVjASuraqVXBtInUSaOm/tRTDxoKIyVnLj++/8TQ9c
         aJ85FqF72Tww/OE2bGO0yOlPOQAek29W5EZBgomtYxF7oGjCEIxuX9hX/cCI5uiLAQX3
         IQNA==
X-Gm-Message-State: AOJu0YxvABbhOxJmUbP2aXVlac03vBh8kdFiBePgW/qvNiRQxUIT604/
	je9gP+aXLyzZSb2VanCw+ZTVsRqxs+aKUmMbnaCRTg==
X-Google-Smtp-Source: AGHT+IHyVCNQpk40rCktjxoJkl8EpYJDW3sA+RubWqyyqedoukbfreWMeaPu96wOdjav/61Llp0NOOCa5enrw9Bkg5M=
X-Received: by 2002:a05:6402:350a:b0:543:faac:e136 with SMTP id
 b10-20020a056402350a00b00543faace136mr186798edd.1.1699005215886; Fri, 03 Nov
 2023 02:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230717152917.751987-1-edumazet@google.com> <738bb6a1-4e99-4113-9345-48eea11e2108@kernel.org>
 <c798f412-ac14-4997-9431-c98d1b8e16d8@kernel.org> <875400ba-58d8-44a0-8fe9-334e322bd1db@kernel.org>
 <CANn89iJOwQUwAVcofW+X_8srFcPnaWKyqOoM005L6Zgh8=OvpA@mail.gmail.com> <20231103092706.6rw2ehuigxfdvhlc@lion.mk-sys.cz>
In-Reply-To: <20231103092706.6rw2ehuigxfdvhlc@lion.mk-sys.cz>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 3 Nov 2023 10:53:22 +0100
Message-ID: <CANn89iKPdAVdPo1g15dEp3smAjM2rY0T25p3y2Dzu-poFk5kWA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: get rid of sysctl_tcp_adv_win_scale
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Jiri Slaby <jirislaby@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 10:27=E2=80=AFAM Michal Kubecek <mkubecek@suse.cz> w=
rote:
>
> On Fri, Nov 03, 2023 at 09:17:27AM +0100, Eric Dumazet wrote:
> >
> > It seems the test had some expectations.
> >
> > Setting a small (1 byte) RCVBUF/SNDBUF, and yet expecting to send
> > 46080 bytes fast enough was not reasonable.
> > It might have relied on the fact that tcp sendmsg() can cook large GSO
> > packets, even if sk->sk_sndbuf is small.
> >
> > With tight memory settings, it is possible TCP has to resort on RTO
> > timers (200ms by default) to recover from dropped packets.
>
> There seems to be one drop but somehow the sender does not recover from
> it, even if the retransmit and following packets are acked quickly:
>
> 09:15:29.424017 IP 127.0.0.1.40386 > 127.0.0.1.42483: Flags [S], seq 1046=
49613, win 33280, options [mss 65495,sackOK,TS val 1319295278 ecr 0,nop,wsc=
ale 7], length 0
> 09:15:29.424024 IP 127.0.0.1.42483 > 127.0.0.1.40386: Flags [S.], seq 134=
3383818, ack 104649614, win 585, options [mss 65495,sackOK,TS val 131929527=
8 ecr 1319295278,nop,wscale 0], length 0
> 09:15:29.424031 IP 127.0.0.1.40386 > 127.0.0.1.42483: Flags [.], ack 1, w=
in 260, options [nop,nop,TS val 1319295278 ecr 1319295278], length 0
> 09:15:29.424155 IP 127.0.0.1.42483 > 127.0.0.1.40386: Flags [.], seq 1:16=
641, ack 1, win 585, options [nop,nop,TS val 1319295279 ecr 1319295278], le=
ngth 16640
> 09:15:29.424160 IP 127.0.0.1.40386 > 127.0.0.1.42483: Flags [.], ack 1664=
1, win 130, options [nop,nop,TS val 1319295279 ecr 1319295279], length 0
> 09:15:29.424179 IP 127.0.0.1.42483 > 127.0.0.1.40386: Flags [P.], seq 166=
41:33281, ack 1, win 585, options [nop,nop,TS val 1319295279 ecr 1319295279=
], length 16640
> 09:15:29.424183 IP 127.0.0.1.40386 > 127.0.0.1.42483: Flags [.], ack 1664=
1, win 0, options [nop,nop,TS val 1319295279 ecr 1319295279], length 0
> 09:15:29.424280 IP 127.0.0.1.40386 > 127.0.0.1.42483: Flags [P.], seq 1:1=
2, ack 16641, win 16640, options [nop,nop,TS val 1319295279 ecr 1319295279]=
, length 11
> 09:15:29.424284 IP 127.0.0.1.42483 > 127.0.0.1.40386: Flags [.], ack 12, =
win 574, options [nop,nop,TS val 1319295279 ecr 1319295279], length 0
> 09:15:29.630272 IP 127.0.0.1.42483 > 127.0.0.1.40386: Flags [P.], seq 166=
41:33281, ack 12, win 574, options [nop,nop,TS val 1319295485 ecr 131929527=
9], length 16640
> 09:15:29.630334 IP 127.0.0.1.40386 > 127.0.0.1.42483: Flags [.], ack 3328=
1, win 2304, options [nop,nop,TS val 1319295485 ecr 1319295485], length 0



> 09:15:29.836938 IP 127.0.0.1.42483 > 127.0.0.1.40386: Flags [P.], seq 332=
81:35585, ack 12, win 574, options [nop,nop,TS val 1319295691 ecr 131929548=
5], length 2304
> 09:15:29.836984 IP 127.0.0.1.40386 > 127.0.0.1.42483: Flags [.], ack 3558=
5, win 2304, options [nop,nop,TS val 1319295691 ecr 1319295691], length 0
> 09:15:30.043606 IP 127.0.0.1.42483 > 127.0.0.1.40386: Flags [P.], seq 355=
85:37889, ack 12, win 574, options [nop,nop,TS val 1319295898 ecr 131929569=
1], length 2304
> 09:15:30.043653 IP 127.0.0.1.40386 > 127.0.0.1.42483: Flags [.], ack 3788=
9, win 2304, options [nop,nop,TS val 1319295898 ecr 1319295898], length 0
> 09:15:30.250270 IP 127.0.0.1.42483 > 127.0.0.1.40386: Flags [P.], seq 378=
89:40193, ack 12, win 574, options [nop,nop,TS val 1319296105 ecr 131929589=
8], length 2304
> 09:15:30.250316 IP 127.0.0.1.40386 > 127.0.0.1.42483: Flags [.], ack 4019=
3, win 2304, options [nop,nop,TS val 1319296105 ecr 1319296105], length 0
> 09:15:30.456932 IP 127.0.0.1.42483 > 127.0.0.1.40386: Flags [P.], seq 401=
93:42497, ack 12, win 574, options [nop,nop,TS val 1319296311 ecr 131929610=
5], length 2304
> 09:15:30.456975 IP 127.0.0.1.40386 > 127.0.0.1.42483: Flags [.], ack 4249=
7, win 2304, options [nop,nop,TS val 1319296311 ecr 1319296311], length 0
> 09:15:30.663598 IP 127.0.0.1.42483 > 127.0.0.1.40386: Flags [P.], seq 424=
97:44801, ack 12, win 574, options [nop,nop,TS val 1319296518 ecr 131929631=
1], length 2304
> 09:15:30.663638 IP 127.0.0.1.40386 > 127.0.0.1.42483: Flags [.], ack 4480=
1, win 2304, options [nop,nop,TS val 1319296518 ecr 1319296518], length 0
> 09:15:30.663646 IP 127.0.0.1.42483 > 127.0.0.1.40386: Flags [FP.], seq 44=
801:46081, ack 12, win 574, options [nop,nop,TS val 1319296518 ecr 13192965=
18], length 1280
> 09:15:30.663712 IP 127.0.0.1.40386 > 127.0.0.1.42483: Flags [F.], seq 12,=
 ack 46082, win 2304, options [nop,nop,TS val 1319296518 ecr 1319296518], l=
ength 0
> 09:15:30.663724 IP 127.0.0.1.42483 > 127.0.0.1.40386: Flags [.], ack 13, =
win 573, options [nop,nop,TS val 1319296518 ecr 1319296518], length 0
>
> (window size values are scaled here). Part of the problem is that the
> receiver side sets SO_RCVBUF after connect() so that the window shrinks
> after sender already sent more data; when I move the bufsized() calls
> in the python script before listen() and connect(), the test runs
> quickly.

This makes sense.

Old kernels would have instead dropped a packet, without changing test stat=
us:

09:49:49.390066 IP localhost.39710 > localhost.44173: Flags [S], seq
1464131415, win 65495, options [mss 65495,sackOK,TS val 578664891 ecr
0,nop,wscale 7], length 0
09:49:49.390078 IP localhost.44173 > localhost.39710: Flags [S.], seq
2322612108, ack 1464131416, win 1152, options [mss 65495,sackOK,TS val
578664891 ecr 578664891,nop,wscale 0], length 0
09:49:49.390088 IP localhost.39710 > localhost.44173: Flags [.], ack
1, win 512, options [nop,nop,TS val 578664891 ecr 578664891], length 0
09:49:49.390319 IP localhost.44173 > localhost.39710: Flags [.], seq
1:32769, ack 1, win 1152, options [nop,nop,TS val 578664892 ecr
578664891], length 32768
09:49:49.390325 IP localhost.39710 > localhost.44173: Flags [.], ack
32769, win 256, options [nop,nop,TS val 578664892 ecr 578664892],
length 0
09:49:49.390355 IP localhost.44173 > localhost.39710: Flags [P.], seq
32769:46081, ack 1, win 1152, options [nop,nop,TS val 578664892 ecr
578664892], length 13312
<prior packet has been dropped by receiver>
09:49:49.390479 IP localhost.39710 > localhost.44173: Flags [P.], seq
1:12, ack 32769, win 256, options [nop,nop,TS val 578664892 ecr
578664892], length 11
09:49:49.390483 IP localhost.44173 > localhost.39710: Flags [.], ack
12, win 1141, options [nop,nop,TS val 578664892 ecr 578664892], length
0
09:49:49.390547 IP localhost.44173 > localhost.39710: Flags [F.], seq
46081, ack 12, win 1141, options [nop,nop,TS val 578664892 ecr
578664892], length 0
09:49:49.390552 IP localhost.39710 > localhost.44173: Flags [.], ack
32769, win 256, options [nop,nop,TS val 578664892 ecr
578664892,nop,nop,sack 1 {46081:46082}], length 0

<packet retransmit>
09:49:49.390562 IP localhost.44173 > localhost.39710: Flags [P.], seq
32769:46081, ack 12, win 1141, options [nop,nop,TS val 578664892 ecr
578664892], length 13312
09:49:49.390567 IP localhost.39710 > localhost.44173: Flags [.], ack
46082, win 152, options [nop,nop,TS val 578664892 ecr 578664892],
length 0
09:49:49.390677 IP localhost.39710 > localhost.44173: Flags [F.], seq
12, ack 46082, win 152, options [nop,nop,TS val 578664892 ecr
578664892], length 0
09:49:49.390685 IP localhost.44173 > localhost.39710: Flags [.], ack
13, win 1141, options [nop,nop,TS val 578664892 ecr 578664892], length
0


Retracting TCP windows has always been problematic.

If we really want to be very gentle, this could add more logic,
shorter timer events for pathological cases like that,
I am not sure this is really worth it, especially if dealing with one
million TCP sockets in this state.

