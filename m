Return-Path: <netdev+bounces-41034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF38F7C9618
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 21:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B662C281C60
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 19:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E468D134A8;
	Sat, 14 Oct 2023 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQYbCrCr"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F88E2113
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 19:40:52 +0000 (UTC)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A09FB7
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 12:40:51 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-4a403fdebedso1276730e0c.1
        for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 12:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697312450; x=1697917250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNY2rAbDmteu+8bsN6q+wboPgM5FHqdwihRv4jqTPUc=;
        b=pQYbCrCrdipiGO0qIv/d+5jvKf5lZijGykdlC3/pzpz3x8rKO1tJR1NAWOdn0eYTAa
         97JUEl1LrLXfWnXEHn4L4vP3IzVbp/aWXgbYLds2LJt7ZwsyQekaLuDl7j9gyUlW0sSB
         TvNEi28RZIT02e/e9gQuDrcCFdtLT0ZzVhVuCbNzCLUGGEg93soBa8EEREo+BfOfklHs
         +Vw16wG2KYicqUDzSUggiNQbX+ttXXiN+MY5ic33TtYYmy+wuFNjEMIjX2asNMfjIbsE
         dRgekEoo8olDphLBCKEhvlT4qUzKsfmQNvohT3pQiBq2idOClN9B+J0NamSNKzI6LNpR
         Ch1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697312450; x=1697917250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNY2rAbDmteu+8bsN6q+wboPgM5FHqdwihRv4jqTPUc=;
        b=Zj4ooCSY1ORGq+isuAz77+r4Rmqdb57EBSvDiXAnNxSBHTTaCemAyeKrQrT+vtrcIZ
         U3L6zjC75FCM1gNi100A2hToGjkw3QjIa8xhbomGxplfaXJePLkeoR8t3wiVqmuTl1VN
         DNZXum7UvkDGgmeC/7ST2JGRkwgQ+rcURtdp/lfLfi2ob5NC1uax4uqXeOdP0ATBEFeV
         Vmp4X6rD7bbx6vmMvFTwXHjkZKDN66UI3mgU4uS0jToZ6tNCMGSPjPc+b5cvGc7W4WB6
         FqF2lNmpXnNgwo1PG4C0SFcfeLoekQvh10SiwZhO8eRUCpJs9aNeVg495LUnMJw+L5V1
         yc4A==
X-Gm-Message-State: AOJu0YwDgCOiFz/dYBt8gxc4AXF9k/oY5g3V9tZ06NHvYFsUtkPp2Op6
	7X9hPddBXPWbQngc9rBsKnFs++qZ+CEc0NleptysnQ==
X-Google-Smtp-Source: AGHT+IGuyfPvki0A9IsVBULFrtCoLSru/A07Kdd+fIfwfkt+US7tePiDddsJFe9DaGWg1iLA9ovlz5oyMNTVeadqJhA=
X-Received: by 2002:a67:f308:0:b0:452:61f6:4b53 with SMTP id
 p8-20020a67f308000000b0045261f64b53mr29764490vsf.2.1697312449959; Sat, 14 Oct
 2023 12:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7f31ddc8-9971-495e-a1f6-819df542e0af@gmx.net> <CANn89iKY58YSknzOzkEHxFu=C=1_p=pXGAHGo9ZkAfAGon9ayw@mail.gmail.com>
 <CADVnQymV=nv53YaC8kLC1qT1ufhJL9+w_wcZ+8AHwPRG+JRdnw@mail.gmail.com> <a35b1a27-575f-4d19-ad2d-95bf4ded40e9@gmx.net>
In-Reply-To: <a35b1a27-575f-4d19-ad2d-95bf4ded40e9@gmx.net>
From: Neal Cardwell <ncardwell@google.com>
Date: Sat, 14 Oct 2023 15:40:33 -0400
Message-ID: <CADVnQymM2HrGrMGyJX2QQ9PpgQT8JqsRz_0U8_WvdvzteqsfEQ@mail.gmail.com>
Subject: Re: iperf performance regression since Linux 5.18
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com, 
	Stefan Wahren <stefan.wahren@chargebyte.com>, Michael Heimpold <mhei@heimpold.de>, netdev@vger.kernel.org, 
	Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 9:37=E2=80=AFAM Stefan Wahren <wahrenst@gmx.net> wr=
ote:
>
> Hi,
>
> Am 09.10.23 um 21:19 schrieb Neal Cardwell:
> > On Mon, Oct 9, 2023 at 3:11=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >> On Mon, Oct 9, 2023 at 8:58=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net=
> wrote:
> >>> Hi,
> >>> we recently switched on our ARM NXP i.MX6ULL based embedded device
> >>> (Tarragon Master [1]) from an older kernel version to Linux 6.1. Afte=
r
> >>> that we noticed a measurable performance regression on the Ethernet
> >>> interface (driver: fec, 100 Mbit link) while running iperf client on =
the
> >>> device:
> >>>
> >>> BAD
> >>>
> >>> # iperf -t 10 -i 1 -c 192.168.1.129
> >>> ------------------------------------------------------------
> >>> Client connecting to 192.168.1.129, TCP port 5001
> >>> TCP window size: 96.2 KByte (default)
> >>> ------------------------------------------------------------
> >>> [  3] local 192.168.1.12 port 56022 connected with 192.168.1.129 port=
 5001
> >>> [ ID] Interval       Transfer     Bandwidth
> >>> [  3]  0.0- 1.0 sec  9.88 MBytes  82.8 Mbits/sec
> >>> [  3]  1.0- 2.0 sec  9.62 MBytes  80.7 Mbits/sec
> >>> [  3]  2.0- 3.0 sec  9.75 MBytes  81.8 Mbits/sec
> >>> [  3]  3.0- 4.0 sec  9.62 MBytes  80.7 Mbits/sec
> >>> [  3]  4.0- 5.0 sec  9.62 MBytes  80.7 Mbits/sec
> >>> [  3]  5.0- 6.0 sec  9.62 MBytes  80.7 Mbits/sec
> >>> [  3]  6.0- 7.0 sec  9.50 MBytes  79.7 Mbits/sec
> >>> [  3]  7.0- 8.0 sec  9.75 MBytes  81.8 Mbits/sec
> >>> [  3]  8.0- 9.0 sec  9.62 MBytes  80.7 Mbits/sec
> >>> [  3]  9.0-10.0 sec  9.50 MBytes  79.7 Mbits/sec
> >>> [  3]  0.0-10.0 sec  96.5 MBytes  80.9 Mbits/sec
> >>>
> >>> GOOD
> >>>
> >>> # iperf -t 10 -i 1 -c 192.168.1.129
> >>> ------------------------------------------------------------
> >>> Client connecting to 192.168.1.129, TCP port 5001
> >>> TCP window size: 96.2 KByte (default)
> >>> ------------------------------------------------------------
> >>> [  3] local 192.168.1.12 port 54898 connected with 192.168.1.129 port=
 5001
> >>> [ ID] Interval       Transfer     Bandwidth
> >>> [  3]  0.0- 1.0 sec  11.2 MBytes  94.4 Mbits/sec
> >>> [  3]  1.0- 2.0 sec  11.0 MBytes  92.3 Mbits/sec
> >>> [  3]  2.0- 3.0 sec  10.8 MBytes  90.2 Mbits/sec
> >>> [  3]  3.0- 4.0 sec  11.0 MBytes  92.3 Mbits/sec
> >>> [  3]  4.0- 5.0 sec  10.9 MBytes  91.2 Mbits/sec
> >>> [  3]  5.0- 6.0 sec  10.9 MBytes  91.2 Mbits/sec
> >>> [  3]  6.0- 7.0 sec  10.8 MBytes  90.2 Mbits/sec
> >>> [  3]  7.0- 8.0 sec  10.9 MBytes  91.2 Mbits/sec
> >>> [  3]  8.0- 9.0 sec  10.9 MBytes  91.2 Mbits/sec
> >>> [  3]  9.0-10.0 sec  10.9 MBytes  91.2 Mbits/sec
> >>> [  3]  0.0-10.0 sec   109 MBytes  91.4 Mbits/sec
> >>>
> >>> We were able to bisect this down to this commit:
> >>>
> >>> first bad commit: [65466904b015f6eeb9225b51aeb29b01a1d4b59c] tcp: adj=
ust
> >>> TSO packet sizes based on min_rtt
> >>>
> >>> Disabling this new setting via:
> >>>
> >>> echo 0 > /proc/sys/net/ipv4/tcp_tso_rtt_log
> >>>
> >>> confirm that this was the cause of the performance regression.
> >>>
> >>> Is it expected that the new default setting has such a performance im=
pact?
> > Indeed, thanks for the report.
> >
> > In addition to the "ss" output Eric mentioned, could you please grab
> > "nstat" output, which should allow us to calculate the average TSO/GSO
> > and LRO/GRO burst sizes, which is the key thing tuned with the
> > tcp_tso_rtt_log knob.
> >
> > So it would be great to have the following from both data sender and
> > data receiver, for both the good case and bad case, if you could start
> > these before your test and kill them after the test stops:
> >
> > (while true; do date; ss -tenmoi; sleep 1; done) > /root/ss.txt &
> > nstat -n; (while true; do date; nstat; sleep 1; done)  > /root/nstat.tx=
t
> i upload everything here:
> https://github.com/lategoodbye/tcp_tso_rtt_log_regress
>
> The server part is a Ubuntu installation connected to the internet. At
> first i logged the good case, then i continued with the bad case.
> Accidentally i delete a log file of bad case, so i repeated the whole
> bad case again. So the uploaded bad case files are from the third run.

Thanks for the detailed data!

Here are some notes from looking at this data:

+ bad client: avg TSO burst size is roughly:
https://github.com/lategoodbye/tcp_tso_rtt_log_regress/blob/main/nstat_clie=
nt_bad.log
IpOutRequests                   308               44.7
IpExtOutOctets                  10050656        1403181.0
est bytes   per TSO burst: 10050656 / 308 =3D 32632
est packets per TSO burst: 32632 / 1448 ~=3D 22.5

+ good client: avg TSO burst size is roughly:
https://github.com/lategoodbye/tcp_tso_rtt_log_regress/blob/main/nstat_clie=
nt_good.log
IpOutRequests                   529               62.0
IpExtOutOctets                  11502992        1288711.5
est bytes   per TSO burst: 11502992 / 529 ~=3D 21745
est packets per TSO burst: 21745 / 1448 ~=3D 15.0

+ bad client ss data:
https://github.com/lategoodbye/tcp_tso_rtt_log_regress/blob/main/ss_client_=
bad.log
State Recv-Q Send-Q Local Address:Port   Peer Address:PortProcess
ESTAB 0      236024  192.168.1.12:39228 192.168.1.129:5001
timer:(on,030ms,0) ino:25876 sk:414f52af rto:0.21 cwnd:68 ssthresh:20
reordering:0
Mbits/sec allowed by cwnd: 68 * 1448 * 8 / .0018 / 1000000.0 ~=3D 437.6

+ good client ss data:
https://github.com/lategoodbye/tcp_tso_rtt_log_regress/blob/main/ss_client_=
good.log
Fri Oct 13 15:04:36 CEST 2023
State Recv-Q Send-Q Local Address:Port   Peer Address:PortProcess
ESTAB 0      425712  192.168.1.12:33284 192.168.1.129:5001
timer:(on,020ms,0) ino:20654 sk:414f52af rto:0.21 cwnd:106 ssthresh:20
reordering:0
Mbits/sec allowed by cwnd: 106 * 1448 * 8 / .0028 / 1000000.0 =3D 438.5

So it seems indeed like cwnd is not the limiting factor, and instead
there is something about the larger TSO/GSO bursts (roughly 22.5
packets per burst on average) in the "bad" case that is causing
problems, and preventing the sender from keeping the pipe fully
utilized.

So perhaps the details of the tcp_tso_should_defer() logic are hurting
performance?

The default value of tcp_tso_win_divisor is 3, and in the bad case the
cwnd / tcp_tso_win_divisor =3D 68 / 3 =3D 22.7 packets, which is
suspiciously close to the average TSO burst size of 22.5. So my guess
is that the tcp_tso_win_divisor of 3 is the dominant factor here, and
perhaps if we raise it to 5, then 68/5 ~=3D 13.60 will approximate the
TSO burst size in the "good" case, and fully utilize the pipe. So it
seems worth an experiment, to see what we can learn.

To test that theory, could you please try running the following as
root on the data sender machine, and then re-running the "bad" test
with tcp_tso_rtt_log at the default value of 9?

   sysctl net.ipv4.tcp_tso_win_divisor=3D5

Thanks!
neal

