Return-Path: <netdev+bounces-44062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D62EA7D5F76
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 03:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C6C281881
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 01:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83F515C0;
	Wed, 25 Oct 2023 01:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HdBa8e57"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8D815B5
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 01:24:19 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2BD10D5
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 18:24:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9cfec5e73dso5041364276.2
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 18:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698197056; x=1698801856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c4w4uwqNeZJuL7It51eJiTQq0vVgJsQz4qsVa8U8I2U=;
        b=HdBa8e57qKsEg/lhvN4/5lpDTKRscwy11bt7mq/mgfjfRWVGL7MPqq5sOFhwsb2a55
         rkooqX3bEc8XhXryhcDEZe0MbBL7rsrAX3vOHHCbX7p4Yo9TptJrwlvf1em2BELWmw26
         JnUJ/kNvm72w/+DnJpB9+Aytv06PNLxv6n3a1xXa5BCW/LLebunED0VbCADzE4n+LXCS
         gTiTDK7yPZ8ddY+repm1vGkZ3F+lhJAtAaIuWITy44gDbNtNR4PjWFzWdO9WMkotGPT5
         ++nNvPAza2v01cI33sfIT5fZ8O+WmzUicg5ZfNfEs4R8+4ZLGV95kwPyHB6j/nNHWOiD
         U12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698197056; x=1698801856;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c4w4uwqNeZJuL7It51eJiTQq0vVgJsQz4qsVa8U8I2U=;
        b=BA6fDOgP58zWnHTVbu47QxbcIwDd+bB+fR3cdRVgvosCMqLlx3se/No/uttKsyOhNN
         kIVZk4apbfLsUXmFwu+WXlUgBzmQ1HEYg7KRekWryVXhj0lI89yg//ok5Hse99oT6Uyn
         fk62wyKsjixRR0F7Y2W/btnYI7ij0CUY2+KsYR+qXfZ3aioYQwTSpdbiWRYIQ+J+VjZv
         0DPS/FYueA+HZO9b5f5bbDXDApU/ubc4MzOcjc9OduDnzqJ76MF6hpjSATKrM7Ak0os2
         4egTRC7AVtacebuoUkGG/dhw/QCXQboUD9itPjrQL15ZTla2GOS/od2+2wAgSzMSmGWV
         jfxg==
X-Gm-Message-State: AOJu0YwGzpEKPAvrcUbW/eYI+GjCBJq2ry3IIjm6jmEXK5PAn3pIGID2
	GWfCznwVWvUY/JxZGJ3BiGkAxnQLL9OFwyE=
X-Google-Smtp-Source: AGHT+IH9Q3k3+i8C7JfEtWJgtgpHAuQFvDAo/zzfBuVy9L970u5xf/VZDX9ZQI9Im77Z2Vfxf2PyPy6aXdg3D1s=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a25:3492:0:b0:d9a:efcc:42af with SMTP id
 b140-20020a253492000000b00d9aefcc42afmr237361yba.2.1698197056524; Tue, 24 Oct
 2023 18:24:16 -0700 (PDT)
Date: Wed, 25 Oct 2023 01:24:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231025012411.2096053-1-lixiaoyan@google.com>
Subject: [PATCH v3 net-next 0/6] Analyze and Reorganize core Networking
 Structs to optimize cacheline consumption
From: Coco Li <lixiaoyan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Pradeep Nemavat <pnemavat@google.com>, Coco Li <lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, variable-heavy structs in the networking stack is organized
chronologically, logically and sometimes by cache line access.

This patch series attempts to reorganize the core networking stack
variables to minimize cacheline consumption during the phase of data
transfer. Specifically, we looked at the TCP/IP stack and the fast
path definition in TCP.

For documentation purposes, we also added new files for each core data
structure we considered, although not all ended up being modified due
to the amount of existing cache line they span in the fast path. In
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

Chao Wu (1):
  net-smnp: reorganize SNMP fast path variables

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
 .../networking/net_cachelines/net_device.rst  | 171 +++++++++++++
 .../net_cachelines/netns_ipv4_sysctl.rst      | 155 +++++++++++
 .../networking/net_cachelines/snmp.rst        | 132 ++++++++++
 .../networking/net_cachelines/tcp_sock.rst    | 152 +++++++++++
 fs/proc/proc_net.c                            |  39 +++
 include/linux/cache.h                         |  18 ++
 include/linux/netdevice.h                     | 101 ++++----
 include/linux/tcp.h                           | 240 +++++++++---------
 include/net/netns/ipv4.h                      |  43 ++--
 include/uapi/linux/snmp.h                     |  41 ++-
 net/core/dev.c                                |  45 ++++
 net/ipv4/tcp.c                                |  85 +++++++
 16 files changed, 1135 insertions(+), 189 deletions(-)
 create mode 100644 Documentation/networking/net_cachelines/index.rst
 create mode 100644 Documentation/networking/net_cachelines/inet_connection_sock.rst
 create mode 100644 Documentation/networking/net_cachelines/inet_sock.rst
 create mode 100644 Documentation/networking/net_cachelines/net_device.rst
 create mode 100644 Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
 create mode 100644 Documentation/networking/net_cachelines/snmp.rst
 create mode 100644 Documentation/networking/net_cachelines/tcp_sock.rst

-- 
2.42.0.758.gaed0368e0e-goog


