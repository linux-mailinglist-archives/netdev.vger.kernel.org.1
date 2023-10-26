Return-Path: <netdev+bounces-44408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 930317D7E5C
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 10:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE5C1C20E4B
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 08:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1496918B1A;
	Thu, 26 Oct 2023 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DlpodVhY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CACB18AF6
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 08:20:13 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9642DE
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 01:20:11 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b5a586da6so6266827b3.1
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 01:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698308411; x=1698913211; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sZvrgh55MTtUEq+aTs/7Z4g3Cla3nBQj+jdH8zev9P0=;
        b=DlpodVhYPG0KO5umvNXWj2GrbVijg4C4dp8LNCB99N7u5PwZ8S7bYdLIY6ZSwgS0xQ
         tRDa+zAWdDNGttm4XBS1Zzaeqdt+gWZ3+K9uPyYimj0VuIR2zDIkjJUJvuWGRL5mWupR
         /0uL+vSjpAMcUxWVLZcFmPDx8p3ZDUVoAdv8vxvIWs9lDSdHVkXNcHtKO/JvbD2fLoqj
         qIqvGoZWz4d0bKTFX6tQcQVwgcxHs8GmFuBg1MerWHyAt19OQuJNfJoxnwtcLUBxk/Ux
         YNSpNt5JBPtlC483dQ3tNruid+6IEGFFZPpWcRFhke1uzbW50i8L5hLOzDAZlz5WEuyc
         lHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698308411; x=1698913211;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sZvrgh55MTtUEq+aTs/7Z4g3Cla3nBQj+jdH8zev9P0=;
        b=Z0vhksJ7X2zUTRgGar1uwmZP8OtT2Ax6aYb02uIc2VP9KR1fNaMY7THGpEpxqeWZbe
         E6OmBKfuvfkG8JxW5ICgN0z+h8UHi3duI0QTNprUIbde7owL4DcjGXRcpS9Aqut5ZGM1
         qt/nvq0BsSoAYCmdioocMKupwFX/zBpbV9NgSdmpMwuSTc88yiAjTWw4bQMuubzLkW6r
         cQrr/CB+3BjtMhOXKQvu3WL8bWKO7zO4kYXssvO/DjDLfodxL8dwHk52KzrzaY68RhDF
         UHGbRIt1kx16DclUSlJpRnFuIckhl4puKd1xI6h0XhrOTZgSiNxBmEXc17ypN8WCS39H
         1tJQ==
X-Gm-Message-State: AOJu0YzWANUNTKktvLMs0pYlkAGlUkZx6FBjZ2e+kzsioddVle3dEggq
	E5tacYXTQaORIxdX72TDWxOOzp5b4eERBcY=
X-Google-Smtp-Source: AGHT+IGwI+HJ8rQfIi0Oqe08X6bPFljZgwjW3OG9rcCpwTXSr7D9iz96t00vqeCmGRUFSc5PD5Zm1hJCjxobxc8=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a05:690c:ec6:b0:5a7:d45d:1223 with SMTP
 id cs6-20020a05690c0ec600b005a7d45d1223mr88500ywb.3.1698308410901; Thu, 26
 Oct 2023 01:20:10 -0700 (PDT)
Date: Thu, 26 Oct 2023 08:19:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231026081959.3477034-1-lixiaoyan@google.com>
Subject: [PATCH v4 net-next 0/6] Analyze and Reorganize core Networking
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

V3 added cacheline safeguards, and V4 addressed comment changes and
documentation updates of struct member changes.

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
 .../networking/net_cachelines/net_device.rst  | 175 +++++++++++++
 .../net_cachelines/netns_ipv4_sysctl.rst      | 155 +++++++++++
 .../networking/net_cachelines/snmp.rst        | 132 ++++++++++
 .../networking/net_cachelines/tcp_sock.rst    | 154 +++++++++++
 fs/proc/proc_net.c                            |  39 +++
 include/linux/cache.h                         |  18 ++
 include/linux/netdevice.h                     | 113 +++++----
 include/linux/tcp.h                           | 240 +++++++++---------
 include/net/netns/ipv4.h                      |  43 ++--
 include/uapi/linux/snmp.h                     |  41 ++-
 net/core/dev.c                                |  51 ++++
 net/ipv4/tcp.c                                |  85 +++++++
 16 files changed, 1153 insertions(+), 195 deletions(-)
 create mode 100644 Documentation/networking/net_cachelines/index.rst
 create mode 100644 Documentation/networking/net_cachelines/inet_connection_sock.rst
 create mode 100644 Documentation/networking/net_cachelines/inet_sock.rst
 create mode 100644 Documentation/networking/net_cachelines/net_device.rst
 create mode 100644 Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
 create mode 100644 Documentation/networking/net_cachelines/snmp.rst
 create mode 100644 Documentation/networking/net_cachelines/tcp_sock.rst

-- 
2.42.0.758.gaed0368e0e-goog


