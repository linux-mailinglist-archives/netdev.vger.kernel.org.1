Return-Path: <netdev+bounces-47526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8502C7EA6F8
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5BD81C20837
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BEE3D992;
	Mon, 13 Nov 2023 23:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oe8XLi1M"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB703D988
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:33:11 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1A88F
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:33:10 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a909b4e079so69221897b3.2
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699918389; x=1700523189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xxjezZoQVYT/djqUOEHwFcSmt9k210o6A5Ds/8QFmQs=;
        b=Oe8XLi1M8sU/H4lPXvr9oToUxd4QajAZ8f3uknABjfS/R+z46c4y0MPaNbR4zL4lKI
         /OEzlf5Z0bpPVvBxjofc4E4UY8vYsnPauA45qk7N043x/ooWA0Sma3qZDLmwdQzTHyaH
         b7qiZh5TqJ9HJlQMwWrSyN+YjNmDUeb4s0bE2ZRiMfn5Ofn73fcX8loPgoz2H+5AFlpk
         zXOIse73AJTgqKJGzKRQrW8hp+ZgZ9vG9Z/WeclQckusC5qcg5fGgyAuoMGliFeuAlrX
         G9pOOehfS1hvY/11kN8L6fBpXobAaG0kjuG5u/uDI/KjrWXMG9ZLRbhiuq/iZd143Kzi
         ROjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699918389; x=1700523189;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xxjezZoQVYT/djqUOEHwFcSmt9k210o6A5Ds/8QFmQs=;
        b=EuLSpT/PuknvXIuAUC3fsILWRmU6ZPcXQ7M+am+g4gemTTgqnq4cQofSG2F7Mwiq1c
         QbKmabvjpNsgcXqHpQ+Yijrcotx0caOrnKUFqQuH8jyF/O0bQB0l1vH/VqfhuE8pJ0tk
         9QpIHBOktHwqglyT5StolwwZ0aO87SSIEkbsl2JMN0kfXUOs/+hTC7yHXNNR2Hu5jBS2
         22tUtoxO0sZpe6hUGbqKvpPhS5d2zQLFg6wRy3GA396/btd+YvPRXU/nB999M3y2zrhj
         XMawETnOhd+TCDNGCLzq9aWTTZhcJxZ2jFb1fNFe3Bi58/s9tozBMbdZZSVHDXxzROOj
         z9wg==
X-Gm-Message-State: AOJu0Yz8naZFivk2S38obVxx0FoMkU8CJJfoyH60lYPJAAmn936+Bz2R
	YcFWnOiqyRZYA5VBTC19WDcdC5fRITGoYqE=
X-Google-Smtp-Source: AGHT+IEH1xvcl14cW/9kN0HgUdu9iXWisHtH+W06m8iLGnTpH+z20xcGvHq+QIbtYC2H/BviCPwyguHTy1kleG4=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a81:a18b:0:b0:5be:94a6:d84b with SMTP id
 y133-20020a81a18b000000b005be94a6d84bmr220706ywg.5.1699918389572; Mon, 13 Nov
 2023 15:33:09 -0800 (PST)
Date: Mon, 13 Nov 2023 23:32:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231113233301.1020992-1-lixiaoyan@google.com>
Subject: [PATCH v7 net-next 0/5] Analyze and Reorganize core Networking
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
1) removed snmp patch changes.
2) updated cache group size requirements. Chosen to not use cachelines
but actual sum of struct member sizes to not make assumptions on cacheline
sizes.

v6 changes:
1) fixed one comment.

v7 changes:
1) update netns check to within config and send in 6.7 cycle.

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
 net/core/net_namespace.c                      |  45 ++++
 net/ipv4/tcp.c                                |  93 +++++++
 15 files changed, 1167 insertions(+), 182 deletions(-)
 create mode 100644 Documentation/networking/net_cachelines/index.rst
 create mode 100644 Documentation/networking/net_cachelines/inet_connection_sock.rst
 create mode 100644 Documentation/networking/net_cachelines/inet_sock.rst
 create mode 100644 Documentation/networking/net_cachelines/net_device.rst
 create mode 100644 Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
 create mode 100644 Documentation/networking/net_cachelines/snmp.rst
 create mode 100644 Documentation/networking/net_cachelines/tcp_sock.rst

-- 
2.43.0.rc0.421.g78406f8d94-goog


