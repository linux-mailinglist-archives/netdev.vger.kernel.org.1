Return-Path: <netdev+bounces-39279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 338887BEA36
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B2911C20AD4
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 18:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E3F3B785;
	Mon,  9 Oct 2023 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="iRWhc8J2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECCA35880
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 18:58:45 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA5C9C
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 11:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1696877912; x=1697482712; i=wahrenst@gmx.net;
 bh=tAtU2Dk5byNReki6MuBlCTvPKM01v67K8t1oXx/Bkb4=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=iRWhc8J2a+vFO5m3EHkPU27yFymOUx5zY1njNMch9aIAtQWFOLfhHh40/vWpUDeTn8ban4/WKp0
 VbHu8NVBWwGXvGgWcicDb7ETP1sI4VT33l+oeH+V37KaWP+rrUe3bLANYanfWdca+PaJGs2fMXbt8
 Z8Vuk7U7EQFeaAMoxwThPrnK/OnyhREI74xGZE9fVysqIEf1R+9uedbS1MBb1t9CGbGZDrrUwKFwU
 Pg+PqYuCWYo8LxIBxl8BUL8jDlKCzFc0k0lMkFKi/qPQL7BP8ZXsoPJ0uswS70Z1YGrCsMP+kRBFZ
 a4eOKvJBGhT3XXBNKp4gw6EdyhLAy4Z5lwRQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5mKJ-1rfScN2UEl-017Aqs; Mon, 09
 Oct 2023 20:58:32 +0200
Message-ID: <7f31ddc8-9971-495e-a1f6-819df542e0af@gmx.net>
Date: Mon, 9 Oct 2023 20:58:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Neal Cardwell <ncardwell@google.com>, Fabio Estevam <festevam@gmail.com>,
 linux-imx@nxp.com, Stefan Wahren <stefan.wahren@chargebyte.com>,
 Michael Heimpold <mhei@heimpold.de>, netdev@vger.kernel.org
From: Stefan Wahren <wahrenst@gmx.net>
Subject: iperf performance regression since Linux 5.18
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lgSvZOfj/S4ghCnBDwh9D4sOzXhydppzRnlh4nMj3At/v7rUsVF
 2iPLLU5lAjREIL+I6YvygZjM+rVPxb/qfdxpISDZ+41QoEcw7oghETHylVnll2gFLIojlVR
 IlOrfWz3CjwGq4mtfY/UgswMqXMaCiSuUcGpjxdHW1Lx7ZnJnHnMTqIVi9iivSCRd1V6T2t
 +N2QNUPkLhaSfLHm+3viQ==
UI-OutboundReport: notjunk:1;M01:P0:3vTd7NdbPvQ=;4225N5AEdSPLlJLH5F/nEpWtQEt
 g+Scj8aR9LGlQmv/fZNbDPUurLACpd+T93IvH0jJtQhVgM1pHz+LengvpasEhagvAFloMXH4O
 gZzo3WRVO7JTbDZI9FoeuL67J9HDO3bnJps8Y3vNre1dgluTERhsG4j628m16rzHTDAQRQfAl
 o3pWB9cHZkQElLP2rVQsINJcZ5Iwl8bfuWkU5Z3t+TTemhqf6RlHobUGGM8ndKi5gpfRdgj/3
 qEeIu9elEogoWCnzqaoeXiBzZWSre9PIiJFel1L5P/gbahm9lN3DLhdKU/vCCg+hxxMBmGHCB
 jR2GzyQFPCfq4LYjwdzL/JEpXTmkaXxJpOv09u6EOXhAdyozTom7qWAJaahAcyvyo0beNe8kH
 91uGEPnwF+fSOjP4nL6IkA67HNbQCRO8fcajQjK402X0L8NgMUVgBqJZh6To9r8jqtJryedkL
 ewKSUoiCJSqwcyfeQDzZpMRtPGGQLzQe7DyqGyB3D9LkojbkNKM+Tkn9rHR9VLyu+IpKUvTkL
 PRq2249z1jPJjjp4LOoOxzdCperrTfQ+UyY7RNEeg5JgHxtmbo08oSCg8ytm5mqxG7smCyHti
 FmTapqyUdCVZNwwLdvgtiWhOrBLr2KVt41GjJU1na0UkON81KodhehFMHJXxkmFcdkCIHgB1a
 nUiaibvDOGDHehruSsx6R3tW8ghuRpsOqR2BLHlA9crpfwjwZf9lCZ13fC8r7urIJULijX03z
 c4fe0T+LdriRXIqNfYTw/OzrotWyM+Np4dGWTenfGdohtYPi7pWpoN+XtTiraOg8YmqEn+AEz
 PeTmPKa1OkzDOJ0Xr842O7pstPAlbuiDzzK2PXEtQemLbGXg8ROeHLonvSvc8mMIoBUz21l8B
 /ay7rZIwzTdQApmBlkXlKJoGWYH94O168P6t0dkdNvTCDDCmbFjrEy9lr1usYP5krCSPZ8oXD
 2mdVdA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,
we recently switched on our ARM NXP i.MX6ULL based embedded device
(Tarragon Master [1]) from an older kernel version to Linux 6.1. After
that we noticed a measurable performance regression on the Ethernet
interface (driver: fec, 100 Mbit link) while running iperf client on the
device:

BAD

# iperf -t 10 -i 1 -c 192.168.1.129
=2D-----------------------------------------------------------
Client connecting to 192.168.1.129, TCP port 5001
TCP window size: 96.2 KByte (default)
=2D-----------------------------------------------------------
[=C2=A0 3] local 192.168.1.12 port 56022 connected with 192.168.1.129 port=
 5001
[ ID] Interval=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Transfer=C2=A0=C2=A0=C2=
=A0=C2=A0 Bandwidth
[=C2=A0 3]=C2=A0 0.0- 1.0 sec=C2=A0 9.88 MBytes=C2=A0 82.8 Mbits/sec
[=C2=A0 3]=C2=A0 1.0- 2.0 sec=C2=A0 9.62 MBytes=C2=A0 80.7 Mbits/sec
[=C2=A0 3]=C2=A0 2.0- 3.0 sec=C2=A0 9.75 MBytes=C2=A0 81.8 Mbits/sec
[=C2=A0 3]=C2=A0 3.0- 4.0 sec=C2=A0 9.62 MBytes=C2=A0 80.7 Mbits/sec
[=C2=A0 3]=C2=A0 4.0- 5.0 sec=C2=A0 9.62 MBytes=C2=A0 80.7 Mbits/sec
[=C2=A0 3]=C2=A0 5.0- 6.0 sec=C2=A0 9.62 MBytes=C2=A0 80.7 Mbits/sec
[=C2=A0 3]=C2=A0 6.0- 7.0 sec=C2=A0 9.50 MBytes=C2=A0 79.7 Mbits/sec
[=C2=A0 3]=C2=A0 7.0- 8.0 sec=C2=A0 9.75 MBytes=C2=A0 81.8 Mbits/sec
[=C2=A0 3]=C2=A0 8.0- 9.0 sec=C2=A0 9.62 MBytes=C2=A0 80.7 Mbits/sec
[=C2=A0 3]=C2=A0 9.0-10.0 sec=C2=A0 9.50 MBytes=C2=A0 79.7 Mbits/sec
[=C2=A0 3]=C2=A0 0.0-10.0 sec=C2=A0 96.5 MBytes=C2=A0 80.9 Mbits/sec

GOOD

# iperf -t 10 -i 1 -c 192.168.1.129
=2D-----------------------------------------------------------
Client connecting to 192.168.1.129, TCP port 5001
TCP window size: 96.2 KByte (default)
=2D-----------------------------------------------------------
[=C2=A0 3] local 192.168.1.12 port 54898 connected with 192.168.1.129 port=
 5001
[ ID] Interval=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Transfer=C2=A0=C2=A0=C2=
=A0=C2=A0 Bandwidth
[=C2=A0 3]=C2=A0 0.0- 1.0 sec=C2=A0 11.2 MBytes=C2=A0 94.4 Mbits/sec
[=C2=A0 3]=C2=A0 1.0- 2.0 sec=C2=A0 11.0 MBytes=C2=A0 92.3 Mbits/sec
[=C2=A0 3]=C2=A0 2.0- 3.0 sec=C2=A0 10.8 MBytes=C2=A0 90.2 Mbits/sec
[=C2=A0 3]=C2=A0 3.0- 4.0 sec=C2=A0 11.0 MBytes=C2=A0 92.3 Mbits/sec
[=C2=A0 3]=C2=A0 4.0- 5.0 sec=C2=A0 10.9 MBytes=C2=A0 91.2 Mbits/sec
[=C2=A0 3]=C2=A0 5.0- 6.0 sec=C2=A0 10.9 MBytes=C2=A0 91.2 Mbits/sec
[=C2=A0 3]=C2=A0 6.0- 7.0 sec=C2=A0 10.8 MBytes=C2=A0 90.2 Mbits/sec
[=C2=A0 3]=C2=A0 7.0- 8.0 sec=C2=A0 10.9 MBytes=C2=A0 91.2 Mbits/sec
[=C2=A0 3]=C2=A0 8.0- 9.0 sec=C2=A0 10.9 MBytes=C2=A0 91.2 Mbits/sec
[=C2=A0 3]=C2=A0 9.0-10.0 sec=C2=A0 10.9 MBytes=C2=A0 91.2 Mbits/sec
[=C2=A0 3]=C2=A0 0.0-10.0 sec=C2=A0=C2=A0 109 MBytes=C2=A0 91.4 Mbits/sec

We were able to bisect this down to this commit:

first bad commit: [65466904b015f6eeb9225b51aeb29b01a1d4b59c] tcp: adjust
TSO packet sizes based on min_rtt

Disabling this new setting via:

echo 0 > /proc/sys/net/ipv4/tcp_tso_rtt_log

confirm that this was the cause of the performance regression.

Is it expected that the new default setting has such a performance impact?

More information of the platform ...

# ethtool -k eth0
Features for eth0:
rx-checksumming: on
tx-checksumming: on
 =C2=A0=C2=A0 =C2=A0tx-checksum-ipv4: on
 =C2=A0=C2=A0 =C2=A0tx-checksum-ip-generic: off [fixed]
 =C2=A0=C2=A0 =C2=A0tx-checksum-ipv6: on
 =C2=A0=C2=A0 =C2=A0tx-checksum-fcoe-crc: off [fixed]
 =C2=A0=C2=A0 =C2=A0tx-checksum-sctp: off [fixed]
scatter-gather: on
 =C2=A0=C2=A0 =C2=A0tx-scatter-gather: on
 =C2=A0=C2=A0 =C2=A0tx-scatter-gather-fraglist: off [fixed]
tcp-segmentation-offload: on
 =C2=A0=C2=A0 =C2=A0tx-tcp-segmentation: on
 =C2=A0=C2=A0 =C2=A0tx-tcp-ecn-segmentation: off [fixed]
 =C2=A0=C2=A0 =C2=A0tx-tcp-mangleid-segmentation: off
 =C2=A0=C2=A0 =C2=A0tx-tcp6-segmentation: off [fixed]
generic-segmentation-offload: on
generic-receive-offload: on
large-receive-offload: off [fixed]
rx-vlan-offload: on
tx-vlan-offload: off [fixed]
ntuple-filters: off [fixed]
receive-hashing: off [fixed]
highdma: off [fixed]
rx-vlan-filter: off [fixed]
vlan-challenged: off [fixed]
tx-lockless: off [fixed]
netns-local: off [fixed]
tx-gso-robust: off [fixed]
tx-fcoe-segmentation: off [fixed]
tx-gre-segmentation: off [fixed]
tx-gre-csum-segmentation: off [fixed]
tx-ipxip4-segmentation: off [fixed]
tx-ipxip6-segmentation: off [fixed]
tx-udp_tnl-segmentation: off [fixed]
tx-udp_tnl-csum-segmentation: off [fixed]
tx-gso-partial: off [fixed]
tx-tunnel-remcsum-segmentation: off [fixed]
tx-sctp-segmentation: off [fixed]
tx-esp-segmentation: off [fixed]
tx-udp-segmentation: off [fixed]
tx-gso-list: off [fixed]
fcoe-mtu: off [fixed]
tx-nocache-copy: off
loopback: off [fixed]
rx-fcs: off [fixed]
rx-all: off [fixed]
tx-vlan-stag-hw-insert: off [fixed]
rx-vlan-stag-hw-parse: off [fixed]
rx-vlan-stag-filter: off [fixed]
l2-fwd-offload: off [fixed]
hw-tc-offload: off [fixed]
esp-hw-offload: off [fixed]
esp-tx-csum-hw-offload: off [fixed]
rx-udp_tunnel-port-offload: off [fixed]
tls-hw-tx-offload: off [fixed]
tls-hw-rx-offload: off [fixed]
rx-gro-hw: off [fixed]
tls-hw-record: off [fixed]
rx-gro-list: off
macsec-hw-offload: off [fixed]
rx-udp-gro-forwarding: off
hsr-tag-ins-offload: off [fixed]
hsr-tag-rm-offload: off [fixed]
hsr-fwd-offload: off [fixed]
hsr-dup-offload: off [fixed]

[1] -
https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/nxp/imx/i=
mx6ull-tarragon-master.dts

