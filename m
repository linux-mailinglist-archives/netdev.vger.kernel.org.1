Return-Path: <netdev+bounces-41051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDC87C971E
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 00:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EAF7B20BBF
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 22:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B5E2628A;
	Sat, 14 Oct 2023 22:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g//bDMJK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE261845
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 22:51:48 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91555D8
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 15:51:46 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so4189a12.1
        for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 15:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697323904; x=1697928704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K00T4i/GNbAMnPEVca4E7FGRh+xWaXajtvfvIjz1kr4=;
        b=g//bDMJKl6kx3uGz90FB+iwpHx+I5OU6gt+OLMT727FGhiFWusx1jO9YQtzAeaspG7
         oYJ3tTSdaN8n/2n+tW3bJeZBtP5P0BdmWZGw6xJN6jATRID4fN88+qznUcDZ7CGwSARM
         +riA1z+UvgbZ7t+Dsiv+U79hOleLVXYfzkAD+KvxhB+hjcMkbYaFQnchmt1iSdtbtDFG
         K1QzxBnbAXNzQ4Gu9YTCHT/+cKei+ENWo2kLxU0mFe9F7k62PE9meisgkI5POrgrMRGn
         YHEzloGEHj1iCe1GQbeNMa76HgyUxdl7sjYMgUN6MHJF5mc2+z1OVdNv/sjy7x3NhtSp
         ArWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697323904; x=1697928704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K00T4i/GNbAMnPEVca4E7FGRh+xWaXajtvfvIjz1kr4=;
        b=JWq5pAWCFp6a3ovl5aAIU8iqU3nQaMISBH8aOynpFR7Ck3p4CMrdIAd9jGEEk0X42R
         vPVtQEIprrB6ApUNaodxU7Uy9ri73ltCxAfkGpurx8A06EJmUpn+dpf2NjVK9aV2IrAl
         2esuh1CSXpluwGlIkwwvMZkExfH2t5y55UW43MzhacscmSKa1VsLaQzlCwGBvLuwiIis
         GfScJpi4wI1Vt2jkw1zTGWtxKCeigWUct0w+I+98vFPtbVIQ4QvikqovRBNnK3/TXdEW
         130jA+eSCS2YMBRmQeWGwZsCzsBIrs9aoQqaQLQy4+bhC4LHKeb2OkGe2INlelGXdoqu
         ewIg==
X-Gm-Message-State: AOJu0Yyow6FNAq9YIcuEWAxwq3fZh1QiswhJq8lEpB9BOFkDvtmou0SE
	ORlY4NpXoa//1WRT8Zb0xdT3PcTR3ZnI0hTlVRFTu9psMLftBHUlXbRIPA==
X-Google-Smtp-Source: AGHT+IFL2KNTfXkr2eWzixAwygdqi5CKLQ1XGQJUqbCLWwIi3pgSsxz2naGm+NXu/7y983BT8b7lfVnSAFaPgDvaWY0=
X-Received: by 2002:a50:8a95:0:b0:538:5f9e:f0fc with SMTP id
 j21-20020a508a95000000b005385f9ef0fcmr111127edj.0.1697323904372; Sat, 14 Oct
 2023 15:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7f31ddc8-9971-495e-a1f6-819df542e0af@gmx.net> <CANn89iKY58YSknzOzkEHxFu=C=1_p=pXGAHGo9ZkAfAGon9ayw@mail.gmail.com>
 <CADVnQymV=nv53YaC8kLC1qT1ufhJL9+w_wcZ+8AHwPRG+JRdnw@mail.gmail.com>
 <a35b1a27-575f-4d19-ad2d-95bf4ded40e9@gmx.net> <CADVnQymM2HrGrMGyJX2QQ9PpgQT8JqsRz_0U8_WvdvzteqsfEQ@mail.gmail.com>
In-Reply-To: <CADVnQymM2HrGrMGyJX2QQ9PpgQT8JqsRz_0U8_WvdvzteqsfEQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 15 Oct 2023 00:51:30 +0200
Message-ID: <CANn89iL97hLAyHx9ee1VKTnLEgJeEVPrf_8-wf0BEBKAPQitPA@mail.gmail.com>
Subject: Re: iperf performance regression since Linux 5.18
To: Neal Cardwell <ncardwell@google.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, Jakub Kicinski <kuba@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com, 
	Stefan Wahren <stefan.wahren@chargebyte.com>, Michael Heimpold <mhei@heimpold.de>, netdev@vger.kernel.org, 
	Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023 at 9:40=E2=80=AFPM Neal Cardwell <ncardwell@google.com=
> wrote:
>
> On Fri, Oct 13, 2023 at 9:37=E2=80=AFAM Stefan Wahren <wahrenst@gmx.net> =
wrote:
> >
> > Hi,
> >
> > Am 09.10.23 um 21:19 schrieb Neal Cardwell:
> > > On Mon, Oct 9, 2023 at 3:11=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> > >> On Mon, Oct 9, 2023 at 8:58=E2=80=AFPM Stefan Wahren <wahrenst@gmx.n=
et> wrote:
> > >>> Hi,
> > >>> we recently switched on our ARM NXP i.MX6ULL based embedded device
> > >>> (Tarragon Master [1]) from an older kernel version to Linux 6.1. Af=
ter
> > >>> that we noticed a measurable performance regression on the Ethernet
> > >>> interface (driver: fec, 100 Mbit link) while running iperf client o=
n the
> > >>> device:
> > >>>
> > >>> BAD
> > >>>
> > >>> # iperf -t 10 -i 1 -c 192.168.1.129
> > >>> ------------------------------------------------------------
> > >>> Client connecting to 192.168.1.129, TCP port 5001
> > >>> TCP window size: 96.2 KByte (default)
> > >>> ------------------------------------------------------------
> > >>> [  3] local 192.168.1.12 port 56022 connected with 192.168.1.129 po=
rt 5001
> > >>> [ ID] Interval       Transfer     Bandwidth
> > >>> [  3]  0.0- 1.0 sec  9.88 MBytes  82.8 Mbits/sec
> > >>> [  3]  1.0- 2.0 sec  9.62 MBytes  80.7 Mbits/sec
> > >>> [  3]  2.0- 3.0 sec  9.75 MBytes  81.8 Mbits/sec
> > >>> [  3]  3.0- 4.0 sec  9.62 MBytes  80.7 Mbits/sec
> > >>> [  3]  4.0- 5.0 sec  9.62 MBytes  80.7 Mbits/sec
> > >>> [  3]  5.0- 6.0 sec  9.62 MBytes  80.7 Mbits/sec
> > >>> [  3]  6.0- 7.0 sec  9.50 MBytes  79.7 Mbits/sec
> > >>> [  3]  7.0- 8.0 sec  9.75 MBytes  81.8 Mbits/sec
> > >>> [  3]  8.0- 9.0 sec  9.62 MBytes  80.7 Mbits/sec
> > >>> [  3]  9.0-10.0 sec  9.50 MBytes  79.7 Mbits/sec
> > >>> [  3]  0.0-10.0 sec  96.5 MBytes  80.9 Mbits/sec
> > >>>
> > >>> GOOD
> > >>>
> > >>> # iperf -t 10 -i 1 -c 192.168.1.129
> > >>> ------------------------------------------------------------
> > >>> Client connecting to 192.168.1.129, TCP port 5001
> > >>> TCP window size: 96.2 KByte (default)
> > >>> ------------------------------------------------------------
> > >>> [  3] local 192.168.1.12 port 54898 connected with 192.168.1.129 po=
rt 5001
> > >>> [ ID] Interval       Transfer     Bandwidth
> > >>> [  3]  0.0- 1.0 sec  11.2 MBytes  94.4 Mbits/sec
> > >>> [  3]  1.0- 2.0 sec  11.0 MBytes  92.3 Mbits/sec
> > >>> [  3]  2.0- 3.0 sec  10.8 MBytes  90.2 Mbits/sec
> > >>> [  3]  3.0- 4.0 sec  11.0 MBytes  92.3 Mbits/sec
> > >>> [  3]  4.0- 5.0 sec  10.9 MBytes  91.2 Mbits/sec
> > >>> [  3]  5.0- 6.0 sec  10.9 MBytes  91.2 Mbits/sec
> > >>> [  3]  6.0- 7.0 sec  10.8 MBytes  90.2 Mbits/sec
> > >>> [  3]  7.0- 8.0 sec  10.9 MBytes  91.2 Mbits/sec
> > >>> [  3]  8.0- 9.0 sec  10.9 MBytes  91.2 Mbits/sec
> > >>> [  3]  9.0-10.0 sec  10.9 MBytes  91.2 Mbits/sec
> > >>> [  3]  0.0-10.0 sec   109 MBytes  91.4 Mbits/sec
> > >>>
> > >>> We were able to bisect this down to this commit:
> > >>>
> > >>> first bad commit: [65466904b015f6eeb9225b51aeb29b01a1d4b59c] tcp: a=
djust
> > >>> TSO packet sizes based on min_rtt
> > >>>
> > >>> Disabling this new setting via:
> > >>>
> > >>> echo 0 > /proc/sys/net/ipv4/tcp_tso_rtt_log
> > >>>
> > >>> confirm that this was the cause of the performance regression.
> > >>>
> > >>> Is it expected that the new default setting has such a performance =
impact?
> > > Indeed, thanks for the report.
> > >
> > > In addition to the "ss" output Eric mentioned, could you please grab
> > > "nstat" output, which should allow us to calculate the average TSO/GS=
O
> > > and LRO/GRO burst sizes, which is the key thing tuned with the
> > > tcp_tso_rtt_log knob.
> > >
> > > So it would be great to have the following from both data sender and
> > > data receiver, for both the good case and bad case, if you could star=
t
> > > these before your test and kill them after the test stops:
> > >
> > > (while true; do date; ss -tenmoi; sleep 1; done) > /root/ss.txt &
> > > nstat -n; (while true; do date; nstat; sleep 1; done)  > /root/nstat.=
txt
> > i upload everything here:
> > https://github.com/lategoodbye/tcp_tso_rtt_log_regress
> >
> > The server part is a Ubuntu installation connected to the internet. At
> > first i logged the good case, then i continued with the bad case.
> > Accidentally i delete a log file of bad case, so i repeated the whole
> > bad case again. So the uploaded bad case files are from the third run.
>
> Thanks for the detailed data!
>
> Here are some notes from looking at this data:
>
> + bad client: avg TSO burst size is roughly:
> https://github.com/lategoodbye/tcp_tso_rtt_log_regress/blob/main/nstat_cl=
ient_bad.log
> IpOutRequests                   308               44.7
> IpExtOutOctets                  10050656        1403181.0
> est bytes   per TSO burst: 10050656 / 308 =3D 32632
> est packets per TSO burst: 32632 / 1448 ~=3D 22.5
>
> + good client: avg TSO burst size is roughly:
> https://github.com/lategoodbye/tcp_tso_rtt_log_regress/blob/main/nstat_cl=
ient_good.log
> IpOutRequests                   529               62.0
> IpExtOutOctets                  11502992        1288711.5
> est bytes   per TSO burst: 11502992 / 529 ~=3D 21745
> est packets per TSO burst: 21745 / 1448 ~=3D 15.0
>
> + bad client ss data:
> https://github.com/lategoodbye/tcp_tso_rtt_log_regress/blob/main/ss_clien=
t_bad.log
> State Recv-Q Send-Q Local Address:Port   Peer Address:PortProcess
> ESTAB 0      236024  192.168.1.12:39228 192.168.1.129:5001
> timer:(on,030ms,0) ino:25876 sk:414f52af rto:0.21 cwnd:68 ssthresh:20
> reordering:0
> Mbits/sec allowed by cwnd: 68 * 1448 * 8 / .0018 / 1000000.0 ~=3D 437.6
>
> + good client ss data:
> https://github.com/lategoodbye/tcp_tso_rtt_log_regress/blob/main/ss_clien=
t_good.log
> Fri Oct 13 15:04:36 CEST 2023
> State Recv-Q Send-Q Local Address:Port   Peer Address:PortProcess
> ESTAB 0      425712  192.168.1.12:33284 192.168.1.129:5001
> timer:(on,020ms,0) ino:20654 sk:414f52af rto:0.21 cwnd:106 ssthresh:20
> reordering:0
> Mbits/sec allowed by cwnd: 106 * 1448 * 8 / .0028 / 1000000.0 =3D 438.5
>
> So it seems indeed like cwnd is not the limiting factor, and instead
> there is something about the larger TSO/GSO bursts (roughly 22.5
> packets per burst on average) in the "bad" case that is causing
> problems, and preventing the sender from keeping the pipe fully
> utilized.
>
> So perhaps the details of the tcp_tso_should_defer() logic are hurting
> performance?
>
> The default value of tcp_tso_win_divisor is 3, and in the bad case the
> cwnd / tcp_tso_win_divisor =3D 68 / 3 =3D 22.7 packets, which is
> suspiciously close to the average TSO burst size of 22.5. So my guess
> is that the tcp_tso_win_divisor of 3 is the dominant factor here, and
> perhaps if we raise it to 5, then 68/5 ~=3D 13.60 will approximate the
> TSO burst size in the "good" case, and fully utilize the pipe. So it
> seems worth an experiment, to see what we can learn.
>
> To test that theory, could you please try running the following as
> root on the data sender machine, and then re-running the "bad" test
> with tcp_tso_rtt_log at the default value of 9?
>
>    sysctl net.ipv4.tcp_tso_win_divisor=3D5
>
> Thanks!
> neal

Hmm, we receive ~3200 acks per second, I am not sure the
tcp_tso_should_defer() logic
would hurt ?

Also the ss binary on the client seems very old, or its output has
been mangled perhaps ?

State Recv-Q Send-Q Local Address:Port   Peer Address:PortProcess
ESTAB 0      492320  192.168.1.12:33284 192.168.1.129:5001
timer:(on,030ms,0) ino:20654 sk:414f52af rto:0.21 cwnd:106 ssthresh:20
reordering:0

