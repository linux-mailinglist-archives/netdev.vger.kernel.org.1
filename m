Return-Path: <netdev+bounces-39980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B2F7C549E
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 14:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26151C20D8A
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 12:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E531EA94;
	Wed, 11 Oct 2023 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="bM8Muzgd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150C3F4E5
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 12:59:05 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A03698
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 05:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1697029133; x=1697633933; i=wahrenst@gmx.net;
 bh=1JpjdmbO7279KQF0fV1Ca+ylXOH4hSjx4X2zq7eo0yw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=bM8Muzgdd4/G0Dj6PvTm6G9qjDmJGR6hwSHeIaZCUs7LEUHr0OQw3gtVZY3rqtr5A8qrVnJVUn2
 3HyLwBDxB/tP9em04+x87EKX6eV5V49q84/AkCpxLhGoSZushGZmyhrCBVAcHnSaOT7IpFtMxFb8D
 Iqp28A7VhrWJVCe5Nv5QVR5FCmy/VrHV8hp3SL4bHO0WDilB34ot12PgSinahBoVcOLmRP4kNeZTE
 SRjUmBHBkpqg/c2QM9JpV8UgU2iTrHkiouy9wreXeBqWMvmjtIt3hk85Jq+hoY6UBoCsZpIkrSmlP
 njg4QBj3Hgz8GBgp5uBoviVy/RhqYG89kHtg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2nA-1rKgtq3mni-00nCpu; Wed, 11
 Oct 2023 14:58:52 +0200
Message-ID: <e0cfcd37-679c-418c-9f44-529b7c31b437@gmx.net>
Date: Wed, 11 Oct 2023 14:58:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iperf performance regression since Linux 5.18
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
 Stefan Wahren <stefan.wahren@chargebyte.com>,
 Michael Heimpold <mhei@heimpold.de>, netdev@vger.kernel.org
References: <7f31ddc8-9971-495e-a1f6-819df542e0af@gmx.net>
 <CANn89iKY58YSknzOzkEHxFu=C=1_p=pXGAHGo9ZkAfAGon9ayw@mail.gmail.com>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <CANn89iKY58YSknzOzkEHxFu=C=1_p=pXGAHGo9ZkAfAGon9ayw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:llGasuI+sRHCH+fP0Oew1+C1FB4cUmywIUEkMW5Y7sWpSUf+jSh
 Ml+DB2CLn8SLQIH3QW5LfAV2N8S2IfWR9TnscaHNz6QIjLRXlrU5ftji8akVjo1u+v+rV2L
 YROzp6DcFKV1Thmy6FMHQKkJ1sCU7OVV/iTt7FbNYBJnU+pnr6nkXAD58kDiYpRS0psEmaC
 BxlaWg/FYc3ljLRigivtA==
UI-OutboundReport: notjunk:1;M01:P0:g9QLI2GXxwE=;ODcaflKS8NtvZT/9ZG5TuMyY1nl
 Q0zDhAJ25qVCMjIQ4qhIbzoLVCO2wWW+xoACksPfl1TcFFzOyKjzFAC4+EQ988dW9eKuif8wt
 Fo7XZHMCm78fc0kzLeQlVv0rbCOVBqPRuPaIbiEGhReYm3UZwba3XZmON7TbPHYrp/82KYK4o
 m3C7qtAuyy3zf3klmEahGHdjUS2NqSGNGoiC71umXRg0TsMzH+p5ETC30rkvFqO6bGitactid
 8VcKsV4YNuRPfsPIzIfziUDHpG7cI5DVoB4w8bj5NM5MahnpQrcwcMEJmzvvWqyNlFueWCS4O
 ne3VEVoFFBtIzQmkPWHP4DWXdHTuHbG+xF2tBEZqYK7OiaYQ+z07BpAVEqCC2jElDqit5rgOZ
 8l9GUkXOAnao+T+jDAJA6TFEf4t7bu+ja0fmkTQXTSOKxn1eTo/s5TxgLoQ5X9w0wy37RFrN9
 fVpZX6VXQiUDYEZXrJqrgUoXLs3fv9VJ8SnJn5P5hcYoXIQhzJ/+y5QUsnsoWpbXQfmlvKFnz
 dbVXjB6uHkEuhVX9+Y3eTrgZ/XSkEDTYWfIOvbgW17wc/ONxxUkFE/UdkP//+Vh8GJQqJzvyi
 V2ioYvYoEwsnOkGN3uqj1L2GwhFzU7wISatZRRNWu7C/sG9sqCuAnim/qu6zqvOZ88/eHznBe
 CI0vHxKCqBqe9L3/KY5XudKKuAgf+/OtS+NQHMWEwI2wOPaMPr7c92vIOh7pmKvVFIMtSKioG
 iS1rkLxjyVTmHpEkiR9GfbLUPJ1v4Ff1HnzaXqvIq4BdgVpY9T+F2QK/QCm6bV2A9Ex17BsSS
 vKA5anm+OM1TIF3mv6E/8dzyR4Dwv+xJh17HgakvjImLzqm/jwewGrgPc3vYxE/dJ4/e0swBn
 /kYgld1XZS3dMLRLvRNJoX7Qvt3g2l40YdfSnFehj0lhKBNC55vfVewer8fCjrDs9lx8DyjNb
 CAQ7lw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Eric,

Am 09.10.23 um 21:10 schrieb Eric Dumazet:
> On Mon, Oct 9, 2023 at 8:58=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net> =
wrote:
>> Hi,
>> we recently switched on our ARM NXP i.MX6ULL based embedded device
>> (Tarragon Master [1]) from an older kernel version to Linux 6.1. After
>> that we noticed a measurable performance regression on the Ethernet
>> interface (driver: fec, 100 Mbit link) while running iperf client on th=
e
>> device:
>>
>> BAD
>>
>> # iperf -t 10 -i 1 -c 192.168.1.129
>> ------------------------------------------------------------
>> Client connecting to 192.168.1.129, TCP port 5001
>> TCP window size: 96.2 KByte (default)
>> ------------------------------------------------------------
>> [  3] local 192.168.1.12 port 56022 connected with 192.168.1.129 port 5=
001
>> [ ID] Interval       Transfer     Bandwidth
>> [  3]  0.0- 1.0 sec  9.88 MBytes  82.8 Mbits/sec
>> [  3]  1.0- 2.0 sec  9.62 MBytes  80.7 Mbits/sec
>> [  3]  2.0- 3.0 sec  9.75 MBytes  81.8 Mbits/sec
>> [  3]  3.0- 4.0 sec  9.62 MBytes  80.7 Mbits/sec
>> [  3]  4.0- 5.0 sec  9.62 MBytes  80.7 Mbits/sec
>> [  3]  5.0- 6.0 sec  9.62 MBytes  80.7 Mbits/sec
>> [  3]  6.0- 7.0 sec  9.50 MBytes  79.7 Mbits/sec
>> [  3]  7.0- 8.0 sec  9.75 MBytes  81.8 Mbits/sec
>> [  3]  8.0- 9.0 sec  9.62 MBytes  80.7 Mbits/sec
>> [  3]  9.0-10.0 sec  9.50 MBytes  79.7 Mbits/sec
>> [  3]  0.0-10.0 sec  96.5 MBytes  80.9 Mbits/sec
>>
>> GOOD
>>
>> # iperf -t 10 -i 1 -c 192.168.1.129
>> ------------------------------------------------------------
>> Client connecting to 192.168.1.129, TCP port 5001
>> TCP window size: 96.2 KByte (default)
>> ------------------------------------------------------------
>> [  3] local 192.168.1.12 port 54898 connected with 192.168.1.129 port 5=
001
>> [ ID] Interval       Transfer     Bandwidth
>> [  3]  0.0- 1.0 sec  11.2 MBytes  94.4 Mbits/sec
>> [  3]  1.0- 2.0 sec  11.0 MBytes  92.3 Mbits/sec
>> [  3]  2.0- 3.0 sec  10.8 MBytes  90.2 Mbits/sec
>> [  3]  3.0- 4.0 sec  11.0 MBytes  92.3 Mbits/sec
>> [  3]  4.0- 5.0 sec  10.9 MBytes  91.2 Mbits/sec
>> [  3]  5.0- 6.0 sec  10.9 MBytes  91.2 Mbits/sec
>> [  3]  6.0- 7.0 sec  10.8 MBytes  90.2 Mbits/sec
>> [  3]  7.0- 8.0 sec  10.9 MBytes  91.2 Mbits/sec
>> [  3]  8.0- 9.0 sec  10.9 MBytes  91.2 Mbits/sec
>> [  3]  9.0-10.0 sec  10.9 MBytes  91.2 Mbits/sec
>> [  3]  0.0-10.0 sec   109 MBytes  91.4 Mbits/sec
>>
>> We were able to bisect this down to this commit:
>>
>> first bad commit: [65466904b015f6eeb9225b51aeb29b01a1d4b59c] tcp: adjus=
t
>> TSO packet sizes based on min_rtt
>>
>> Disabling this new setting via:
>>
>> echo 0 > /proc/sys/net/ipv4/tcp_tso_rtt_log
>>
>> confirm that this was the cause of the performance regression.
>>
>> Is it expected that the new default setting has such a performance impa=
ct?
> Thanks for the report
>
> Normally no. I guess you need to give us more details.
>
> qdisc in use, MTU in use, congestion control in use, "ss -temoi dst
> 192.168.1.129 " output from sender side while the flow is running.
since ss and nstat are not yet available on my Embedded device this will
take some time.

But at least the available information:

qdisc: pfifo_fast
MTU: 1500
congestion control: cubic

Best regards
>
> Note that reaching line rate on a TCP flow is always tricky,
> regardless of what 'line rate' is.
>
> I suspect an issue on the receiving side with larger GRO packets perhaps=
 ?
>
> You could try to limit GRO or TSO packet sizes to determine if this is
> a driver issue.
>
> (ip link set dev ethX gro_max_size XXXXX  gso_max_size YYYYY)
>

