Return-Path: <netdev+bounces-41042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6418A7C967C
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 23:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8E59B20B66
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 21:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7354D26282;
	Sat, 14 Oct 2023 21:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWix/OfR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC46FC8C0
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 21:16:24 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC7CDD
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 14:16:22 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7ad24b3aaso39893357b3.2
        for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 14:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697318181; x=1697922981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4lN4pMK4mXMM/ywCaI+Ry/UqoYoan19Xv2H6yBxxGE=;
        b=MWix/OfRGtv/6v4gbLUA6Xg3XUPs380ZF3/Gwc7ENUWAUJWKm87CclKyiIQJwdzxz4
         bQxSCSfIHzoLAvfNLeOLUprFpiy6eA590PATMXZejzY1Kk1lKenXfXoud0MVE/wyPf46
         6dxf9FYANiikjrWKZZcS60JdCLRKRNnc/ibpfpa2LP7Id/CXR1EH6NyBexzF7CxC/pZG
         01ol+L6YUb5hZggmK1kYar+nlzRBjvVRRRDHwOOiFucuqrTWvllFhrT7JpjTWjvIHaq3
         EVKHLirs+gFRKTs+A+xST6N2awh5CKiiPj57NCvcszNFroTienUmC4tyIWDt4TeiQ5ZC
         7oTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697318181; x=1697922981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4lN4pMK4mXMM/ywCaI+Ry/UqoYoan19Xv2H6yBxxGE=;
        b=gtqFH+J9FSExvdyc0MuyWZGvP+wBOZbIuXqiWTkQ7FOH7zZpC6xwbAJzD7YXLvV6ji
         hwHWd8eHV3HCrlLcGOlPpBDD4LLrqD169t9j7AI/KHjpKYd+PnHz0U1o/R5xx5A0D28t
         CyUyW+/evSX2pOuqvQJbVrjcoGa6uLI4iDhLy/SRttIBlkq7TgP/07HpYH5Ni0KIt2Pv
         h6T4mCg42XL63BsOaoX4HMuqkMn57978KhgxSKPE32ij6MCjQo+baWJnbwAMf5qOHRjA
         qmI4vm1VxkNJFNzUjc8DyXDODeP6uKv36SeMtXJwYgiGYR+sXzoP1OgkZLgDbW4g5Wy0
         Hw7g==
X-Gm-Message-State: AOJu0YwKDoSUFhR+LzzcgE/vv/r9Tw0OcGzLVCuJ8QBYj7dlmQU3PxYh
	HXIaV3N6sOSZskZqE5iSCBE7yFzTZDcRd54viNA=
X-Google-Smtp-Source: AGHT+IFNtC6JCerqV2nRDQy/eQLyhIzkYwZJTcL8bCj8SMfq2JFbtxogtnWnp7glo2na81sCsXkxrtWD1X4mdwWdRlw=
X-Received: by 2002:a0d:d802:0:b0:5a7:be29:19ac with SMTP id
 a2-20020a0dd802000000b005a7be2919acmr15289297ywe.12.1697318181402; Sat, 14
 Oct 2023 14:16:21 -0700 (PDT)
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
From: Dave Taht <dave.taht@gmail.com>
Date: Sat, 14 Oct 2023 14:16:09 -0700
Message-ID: <CAA93jw6ze82DAigekJmTGbe=+PYodSogdyCrs5_1+5_2XwTtLw@mail.gmail.com>
Subject: Re: iperf performance regression since Linux 5.18
To: Neal Cardwell <ncardwell@google.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com, 
	Stefan Wahren <stefan.wahren@chargebyte.com>, Michael Heimpold <mhei@heimpold.de>, netdev@vger.kernel.org, 
	Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I am also kind of a huge believer in packet captures...

On Sat, Oct 14, 2023 at 12:41=E2=80=AFPM Neal Cardwell <ncardwell@google.co=
m> wrote:
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
>


--=20
Oct 30: https://netdevconf.info/0x17/news/the-maestro-and-the-music-bof.htm=
l
Dave T=C3=A4ht CSO, LibreQos

