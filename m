Return-Path: <netdev+bounces-45051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 861DD7DAB9E
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 08:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8D2281736
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 07:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8A26FD9;
	Sun, 29 Oct 2023 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4riE/LWW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648B879E5
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 07:52:52 +0000 (UTC)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6F4D6
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 00:52:50 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-27d56564684so3447022a91.2
        for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 00:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698565970; x=1699170770; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KLSV0t/MTtVgP7bk5okHqiivsagnjynn9u5/BnTVmVI=;
        b=4riE/LWWgIMGIuPT8/WiWf1suqttmcJJJ0gGmoNvEp/pHJ3HVIWNo0VZUOQhNzHV/D
         ib87NOxvdfBOagUqBnqRKlFJ0M3nt6h3EuAb0kWRMLU0iMHc/BlAlMAmIC0eaV7qRpyg
         iO323Vlei2/T9/EJQBe3hl0ssiM/pHbd/m4sCHcFpBpntpLLPqjzzE74a3/EmwiVe3mx
         an1t5pI41m3i2waMucPaZskbU5MlDJqpo4d+H3mTHIw0XErWDZiK/9vEjZN9VpaAlEM/
         gpBHnvf3SpkYUeebQPlUNxqbzvBIsig0KKprTwGENQUZZF33R9wGG7bjKqVB+h0HsuzJ
         qHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698565970; x=1699170770;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KLSV0t/MTtVgP7bk5okHqiivsagnjynn9u5/BnTVmVI=;
        b=De7+/jxSvCgRizsD1BIZNSckbF9JVu2CxgX1TPSez7VeGE250PbcW2GuXDb6QlYZt7
         WwelST/rErKTHIzH+dsdwxsHZQVtpsnmPfDRSLljQgznDam7wXb0eu3hskCOHcFTznAy
         QlfKvUZJq+Ic9/giHkt4opQ/ml9+jx+WyH9bxJwl0fXP/X0L6NtIsWlz1Q90XdlwoYCa
         h8wyvIKW5m477Omb3GNwW2OsZ2Ep3U0/3M9st6lKl5gT4VWotUyyNMMSGth5WBFN+vch
         p4+ieWSFSL7yvgOELStMJGWOQtomcipRJN6J0eUxmUlU0SM6q4TQKGsBnCGR2lehyXHQ
         /P7g==
X-Gm-Message-State: AOJu0YyB1Y2OJhmR2fYZT9TSdyYvS02SNJqIjSrhqEsAW8N2Qr40Cs/N
	6UVQwz3OZupXSIwl+GniAlI+RwXy7NkniCA=
X-Google-Smtp-Source: AGHT+IHGFtYfBhnld+5eQNYm5J1gcOOqGLeaUL/ggRf4IBZALSeThonbop8waDD9UZsP1GhGTmbxztea/Pfd0mo=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a17:903:454:b0:1cc:3f29:2904 with SMTP
 id iw20-20020a170903045400b001cc3f292904mr22453plb.7.1698565970086; Sun, 29
 Oct 2023 00:52:50 -0700 (PDT)
Date: Sun, 29 Oct 2023 07:52:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231029075244.2612089-1-lixiaoyan@google.com>
Subject: [PATCH v5 net-next 0/5] Analyze and Reorganize core Networking
 Structs to optimize cacheline consumption
From: Coco Li <lixiaoyan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, 
	David Ahern <dsahern@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Pradeep Nemavat <pnemavat@google.com>, Coco Li <lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, variable-heavy structs in the networking stack is organized
chronologically, logically and sometimes by cacheline access.

This patch series attempts to reorganize the core networking stack
variables to minimize cacheline consumption during the phase of data
transfer. Specifically, we looked at the TCP/IP stack and the fast
path definition in TCP.

For documentation purposes, we also added new files for each core data
structure we considered, although not all ended up being modified due
to the amount of existing cacheline they span in the fast path. In
the documentation, we recorded all variables we identified on the
fast path and the reasons. We also hope that in the future when
variables are added/modified, the document can be referred to and
updated accordingly to reflect the latest variable organization.

Tested:
Our tests were run with neper tcp_rr using tcp traffic. The tests have $cpu
number of threads and variable number of flows (see below).

Tests were run on 6.5-rc1

Efficiency is computed as cpu seconds / throughput (one tcp_rr round trip).
The following result shows efficiency delta before and after the patch
series is applied.

On AMD platforms with 100Gb/s NIC and 256Mb L3 cache:
IPv4
Flows   with patches    clean kernel      Percent reduction
30k     0.0001736538065 0.0002741191042 -36.65%
20k     0.0001583661752 0.0002712559158 -41.62%
10k     0.0001639148817 0.0002951800751 -44.47%
5k      0.0001859683866 0.0003320642536 -44.00%
1k      0.0002035190546 0.0003152056382 -35.43%

IPv6
Flows   with patches  clean kernel    Percent reduction
30k     0.000202535503  0.0003275329163 -38.16%
20k     0.0002020654777 0.0003411304786 -40.77%
10k     0.0002122427035 0.0003803674705 -44.20%
5k      0.0002348776729 0.0004030403953 -41.72%
1k      0.0002237384583 0.0002813646157 -20.48%

On Intel platforms with 200Gb/s NIC and 105Mb L3 cache:
IPv6
Flows   with patches    clean kernel    Percent reduction
30k     0.0006296537873 0.0006370427753 -1.16%
20k     0.0003451029365 0.0003628016076 -4.88%
10k     0.0003187646958 0.0003346835645 -4.76%
5k      0.0002954676348 0.000311807592  -5.24%
1k      0.0001909169342 0.0001848069709 3.31%

v5 changes:
1) removed snmp patch changes for next net-dev cycle. Pending work:
move file out of uapi.
2) updated cache group size requirements. Chosen to not use cachelines
but actual sum of struct member sizes to not make assumptions on cacheline
sizes.

Coco Li (5):
  Documentations: Analyze heavily used Networking related structs
  cache: enforce cache groups
  netns-ipv4: reorganize netns_ipv4 fast path variables
  net-device: reorganize net_device fast path variables
  tcp: reorganize tcp_sock fast path variables

 Documentation/networking/index.rst            |   1 +
 .../networking/net_cachelines/index.rst       |  13 +
 .../net_cachelines/inet_connection_sock.rst   |  47 ++++
 .../networking/net_cachelines/inet_sock.rst   |  41 +++
 .../networking/net_cachelines/net_device.rst  | 175 ++++++++++++
 .../net_cachelines/netns_ipv4_sysctl.rst      | 155 +++++++++++
 .../networking/net_cachelines/snmp.rst        | 132 ++++++++++
 .../networking/net_cachelines/tcp_sock.rst    | 154 +++++++++++
 include/linux/cache.h                         |  25 ++
 include/linux/netdevice.h                     | 117 +++++----
 include/linux/tcp.h                           | 248 ++++++++++--------
 include/net/netns/ipv4.h                      |  47 ++--
 net/core/dev.c                                |  56 ++++
 net/core/net_namespace.c                      |  43 +++
 net/ipv4/tcp.c                                |  93 +++++++
 15 files changed, 1165 insertions(+), 182 deletions(-)
 create mode 100644 Documentation/networking/net_cachelines/index.rst
 create mode 100644 Documentation/networking/net_cachelines/inet_connection_sock.rst
 create mode 100644 Documentation/networking/net_cachelines/inet_sock.rst
 create mode 100644 Documentation/networking/net_cachelines/net_device.rst
 create mode 100644 Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
 create mode 100644 Documentation/networking/net_cachelines/snmp.rst
 create mode 100644 Documentation/networking/net_cachelines/tcp_sock.rst

-- 
2.42.0.820.g83a721a137-goog


