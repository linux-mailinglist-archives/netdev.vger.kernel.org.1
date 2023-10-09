Return-Path: <netdev+bounces-39280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5B07BEA5C
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 21:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFDB280E7B
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 19:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FB73B7A0;
	Mon,  9 Oct 2023 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UqgmM3Dw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED2AFBE3
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 19:11:12 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807B5A6
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 12:11:10 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40662119cd0so122115e9.1
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 12:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696878669; x=1697483469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLQp45suCIf2mNsdLU/Ue57LNi9QiOR2VG5lxQ0v0P0=;
        b=UqgmM3Dwl18ro6kjKWKnpiDMMsQ5lIpvz/TX6GZ1KgvMySvPOo7ewYAuT1DP5uD4qC
         +IzeBtt5nNnYHIfZPqK+qqfvNODlr0hXL+pCDG5kXywyWZWe4j1ZAxOGEENVx2qFu6Ck
         1ZNhaziVQPyY0gVUuGEqsPGcw1Nyx6O4FxjtuaICnJCabvGgjgjs07extKvw67KQ+4Vu
         VigNsNjfudasGFwVgrJH1aslNSuTqoqyL9Zv35tD2BVgpRXLe4XQJXEhnZN4KEwYuRG9
         noSFqdsOFVTgKLZpMGYX9o2bpwdRCzn2eAfLJ5c63UOcCfoOzPjywDD89XIGPtXcH8dQ
         NChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696878669; x=1697483469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLQp45suCIf2mNsdLU/Ue57LNi9QiOR2VG5lxQ0v0P0=;
        b=MzlNQAa31AFR5IK6iL9nNSze/N4h65N64+/n2gbqoc+kiMgMlk13U6h8GYNDYSNzp6
         j+RHCYOeu3rnFs6110ykVRMNPZLnj/Ut7+MJPf9XgIs9BjprLxAbbcku2pEtj5NBhAYb
         KqhbBa3uSaQOrIU944qoYB/GzK+Az2iom0CbOwJDxyn9X+AHjiwdk9v0P1cMst5q/UgF
         f0PRw6ol+RnNI7feRNJAkEcL05z5hXeNwgK6gx2ur+YuNZ7ii2dggbC62bbpEtxRLpXB
         NGb06rhduV8G2GJMjKSiUCfLe8aPPCt4tff06ziAGotjnJXOSYmjLz167cDRVfrzJulk
         kCyQ==
X-Gm-Message-State: AOJu0Yz3N2LIP6zp6yzPEboz6aa9QvCsZUMa+TSolpp3K/I2b0UjVtB4
	A2mgxt3Pcn7jUq+0d4p3LPLuHYwz3WFCir7xoYHkj0tYicWxwiEXUboLJYbZ
X-Google-Smtp-Source: AGHT+IEDTPWoZzwI9VPMOcHI6q5jSybQG38WUREGvl+U0I4dULiuezGHVMcxK7xiQhRA8KaxGGojUGXjY/eaQiV+IKY=
X-Received: by 2002:a05:600c:45d1:b0:405:35bf:7362 with SMTP id
 s17-20020a05600c45d100b0040535bf7362mr363758wmo.0.1696878668730; Mon, 09 Oct
 2023 12:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7f31ddc8-9971-495e-a1f6-819df542e0af@gmx.net>
In-Reply-To: <7f31ddc8-9971-495e-a1f6-819df542e0af@gmx.net>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Oct 2023 21:10:55 +0200
Message-ID: <CANn89iKY58YSknzOzkEHxFu=C=1_p=pXGAHGo9ZkAfAGon9ayw@mail.gmail.com>
Subject: Re: iperf performance regression since Linux 5.18
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com, 
	Stefan Wahren <stefan.wahren@chargebyte.com>, Michael Heimpold <mhei@heimpold.de>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 8:58=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net> wro=
te:
>
> Hi,
> we recently switched on our ARM NXP i.MX6ULL based embedded device
> (Tarragon Master [1]) from an older kernel version to Linux 6.1. After
> that we noticed a measurable performance regression on the Ethernet
> interface (driver: fec, 100 Mbit link) while running iperf client on the
> device:
>
> BAD
>
> # iperf -t 10 -i 1 -c 192.168.1.129
> ------------------------------------------------------------
> Client connecting to 192.168.1.129, TCP port 5001
> TCP window size: 96.2 KByte (default)
> ------------------------------------------------------------
> [  3] local 192.168.1.12 port 56022 connected with 192.168.1.129 port 500=
1
> [ ID] Interval       Transfer     Bandwidth
> [  3]  0.0- 1.0 sec  9.88 MBytes  82.8 Mbits/sec
> [  3]  1.0- 2.0 sec  9.62 MBytes  80.7 Mbits/sec
> [  3]  2.0- 3.0 sec  9.75 MBytes  81.8 Mbits/sec
> [  3]  3.0- 4.0 sec  9.62 MBytes  80.7 Mbits/sec
> [  3]  4.0- 5.0 sec  9.62 MBytes  80.7 Mbits/sec
> [  3]  5.0- 6.0 sec  9.62 MBytes  80.7 Mbits/sec
> [  3]  6.0- 7.0 sec  9.50 MBytes  79.7 Mbits/sec
> [  3]  7.0- 8.0 sec  9.75 MBytes  81.8 Mbits/sec
> [  3]  8.0- 9.0 sec  9.62 MBytes  80.7 Mbits/sec
> [  3]  9.0-10.0 sec  9.50 MBytes  79.7 Mbits/sec
> [  3]  0.0-10.0 sec  96.5 MBytes  80.9 Mbits/sec
>
> GOOD
>
> # iperf -t 10 -i 1 -c 192.168.1.129
> ------------------------------------------------------------
> Client connecting to 192.168.1.129, TCP port 5001
> TCP window size: 96.2 KByte (default)
> ------------------------------------------------------------
> [  3] local 192.168.1.12 port 54898 connected with 192.168.1.129 port 500=
1
> [ ID] Interval       Transfer     Bandwidth
> [  3]  0.0- 1.0 sec  11.2 MBytes  94.4 Mbits/sec
> [  3]  1.0- 2.0 sec  11.0 MBytes  92.3 Mbits/sec
> [  3]  2.0- 3.0 sec  10.8 MBytes  90.2 Mbits/sec
> [  3]  3.0- 4.0 sec  11.0 MBytes  92.3 Mbits/sec
> [  3]  4.0- 5.0 sec  10.9 MBytes  91.2 Mbits/sec
> [  3]  5.0- 6.0 sec  10.9 MBytes  91.2 Mbits/sec
> [  3]  6.0- 7.0 sec  10.8 MBytes  90.2 Mbits/sec
> [  3]  7.0- 8.0 sec  10.9 MBytes  91.2 Mbits/sec
> [  3]  8.0- 9.0 sec  10.9 MBytes  91.2 Mbits/sec
> [  3]  9.0-10.0 sec  10.9 MBytes  91.2 Mbits/sec
> [  3]  0.0-10.0 sec   109 MBytes  91.4 Mbits/sec
>
> We were able to bisect this down to this commit:
>
> first bad commit: [65466904b015f6eeb9225b51aeb29b01a1d4b59c] tcp: adjust
> TSO packet sizes based on min_rtt
>
> Disabling this new setting via:
>
> echo 0 > /proc/sys/net/ipv4/tcp_tso_rtt_log
>
> confirm that this was the cause of the performance regression.
>
> Is it expected that the new default setting has such a performance impact=
?

Thanks for the report

Normally no. I guess you need to give us more details.

qdisc in use, MTU in use, congestion control in use, "ss -temoi dst
192.168.1.129 " output from sender side while the flow is running.

Note that reaching line rate on a TCP flow is always tricky,
regardless of what 'line rate' is.

I suspect an issue on the receiving side with larger GRO packets perhaps ?

You could try to limit GRO or TSO packet sizes to determine if this is
a driver issue.

(ip link set dev ethX gro_max_size XXXXX  gso_max_size YYYYY)


>
> More information of the platform ...
>
> # ethtool -k eth0
> Features for eth0:
> rx-checksumming: on
> tx-checksumming: on
>      tx-checksum-ipv4: on
>      tx-checksum-ip-generic: off [fixed]
>      tx-checksum-ipv6: on
>      tx-checksum-fcoe-crc: off [fixed]
>      tx-checksum-sctp: off [fixed]
> scatter-gather: on
>      tx-scatter-gather: on
>      tx-scatter-gather-fraglist: off [fixed]
> tcp-segmentation-offload: on
>      tx-tcp-segmentation: on
>      tx-tcp-ecn-segmentation: off [fixed]
>      tx-tcp-mangleid-segmentation: off
>      tx-tcp6-segmentation: off [fixed]
> generic-segmentation-offload: on
> generic-receive-offload: on
> large-receive-offload: off [fixed]
> rx-vlan-offload: on
> tx-vlan-offload: off [fixed]
> ntuple-filters: off [fixed]
> receive-hashing: off [fixed]
> highdma: off [fixed]
> rx-vlan-filter: off [fixed]
> vlan-challenged: off [fixed]
> tx-lockless: off [fixed]
> netns-local: off [fixed]
> tx-gso-robust: off [fixed]
> tx-fcoe-segmentation: off [fixed]
> tx-gre-segmentation: off [fixed]
> tx-gre-csum-segmentation: off [fixed]
> tx-ipxip4-segmentation: off [fixed]
> tx-ipxip6-segmentation: off [fixed]
> tx-udp_tnl-segmentation: off [fixed]
> tx-udp_tnl-csum-segmentation: off [fixed]
> tx-gso-partial: off [fixed]
> tx-tunnel-remcsum-segmentation: off [fixed]
> tx-sctp-segmentation: off [fixed]
> tx-esp-segmentation: off [fixed]
> tx-udp-segmentation: off [fixed]
> tx-gso-list: off [fixed]
> fcoe-mtu: off [fixed]
> tx-nocache-copy: off
> loopback: off [fixed]
> rx-fcs: off [fixed]
> rx-all: off [fixed]
> tx-vlan-stag-hw-insert: off [fixed]
> rx-vlan-stag-hw-parse: off [fixed]
> rx-vlan-stag-filter: off [fixed]
> l2-fwd-offload: off [fixed]
> hw-tc-offload: off [fixed]
> esp-hw-offload: off [fixed]
> esp-tx-csum-hw-offload: off [fixed]
> rx-udp_tunnel-port-offload: off [fixed]
> tls-hw-tx-offload: off [fixed]
> tls-hw-rx-offload: off [fixed]
> rx-gro-hw: off [fixed]
> tls-hw-record: off [fixed]
> rx-gro-list: off
> macsec-hw-offload: off [fixed]
> rx-udp-gro-forwarding: off
> hsr-tag-ins-offload: off [fixed]
> hsr-tag-rm-offload: off [fixed]
> hsr-fwd-offload: off [fixed]
> hsr-dup-offload: off [fixed]
>
> [1] -
> https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/nxp/imx/=
imx6ull-tarragon-master.dts

