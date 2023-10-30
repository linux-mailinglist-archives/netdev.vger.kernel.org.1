Return-Path: <netdev+bounces-45147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4937DB2CC
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 06:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944E81C208C2
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 05:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9D2ED4;
	Mon, 30 Oct 2023 05:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FdTmaR8z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18F11366
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 05:25:57 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB48A9
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 22:25:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7cf717bacso38299417b3.1
        for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 22:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698643555; x=1699248355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MZWS1G90NKwco3dL3nzwT3iA9FHXKTBliDAiVirupxE=;
        b=FdTmaR8zxF4KHcFDR+dGERbCsTE0VvAY6G4FbuAkaIjPs7vGohqDti+CUuNejrbDDf
         vUe82rCFmNn0UjihxLcKHKS/uje++/TFX93uNe1O+5dduTJxZYvbOkl2YvwUnAuNCz6k
         QNKVylhKq1oGFMDqA3/gN7KdnZWlyJjrhHUhDBr3J+pNh43byfEtLmr9JNMcidBqREeY
         N6X1x3Cjzjx8zmx5aMVxxkIJOp8K8WahHKJj1VUJNpUDmpehjBnbADFNatgnK2X5aFI8
         ZQtGJbQKF55HR1/liPd6cEGnfznyqByJRzG14apzwPoWQANFkWDl50yF2c3sjqOCER2v
         x7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698643555; x=1699248355;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MZWS1G90NKwco3dL3nzwT3iA9FHXKTBliDAiVirupxE=;
        b=qQUH0cBa3laBY+Z4wPOJCiAQk1dcCF5+7FSPybFNqS2syq6Kbk3/5PFjXD8dEnnBDd
         BS75JkVdxotuJhCSKAd5sbqtDP+Fpd2als+ItSCGxcXk91IN6oaywmQmidRa1p0U23is
         DykBCsTLX0uhfi2GvpSIqxhyRn9trdKQ1tB6tq+5IgwEe2U/n4zCapsC/FCmp6UAcv5Z
         L6ABwiLg3G/rMGCIjoExgYh01EZHTrSplz5/wu9qUtbh4Kpz4tFDOQAkNB5juLBwyp8a
         UKxU8fBaAidy8H/fFrRCsCF/iwfA5YqImQXXbGEmCK0qSkGie5vkYwZ5rY1qG2oWZUjA
         adnA==
X-Gm-Message-State: AOJu0YxwvcbFgikiRjFd9PLXCoQ1dwM8cYRacYLECvTJe1ZnI5875XIX
	ERa8Aqqr8tXLjq4n/avyzjfNXd0qReCCWnQ=
X-Google-Smtp-Source: AGHT+IHfkwUuj9qVmehxZG+3uZtL+D1DfL01UlPYkFpi01EzfiZl2zeRwOK1bSwDCLol+EX68GvNgbt4mH40lqI=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a81:6d17:0:b0:5a8:205e:1f27 with SMTP id
 i23-20020a816d17000000b005a8205e1f27mr177308ywc.6.1698643555712; Sun, 29 Oct
 2023 22:25:55 -0700 (PDT)
Date: Mon, 30 Oct 2023 05:25:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231030052550.3157719-1-lixiaoyan@google.com>
Subject: [PATCH v6 net-next 0/5] Analyze and Reorganize core Networking
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

v6 changes:
1) fixed one comment.

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


