Return-Path: <netdev+bounces-52023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814D37FCFDE
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 08:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A559B1C209CD
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 07:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD3310959;
	Wed, 29 Nov 2023 07:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A92M++Io"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE082132
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 23:28:00 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a541b720aso7529761276.0
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 23:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701242879; x=1701847679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wi1UGBZv3FY6XCy4QwKN3cgLI0DesjDwgOR9mPrAeFU=;
        b=A92M++IoVN2ma51GY+rnB4oUmp+eJTrl220xJVKrbtat7VDw/2FhDC8iIRrwFd+vts
         KS8EFmi2uIo+V+HRm8+t6GlQZTwqjdXTVWmscJTb+jWmkkVnm/z7Sp8Iaug2+itCVmby
         77aE6Y3kJ15zT/sEG7u4RmjFrUEu+6PF6Gw8zognVvjtXrd31nZRKwWVeS2UkVETqZJN
         KdscVhuNBeWLb3ywk6Fu7kgHKaiws155ePbweOH1ok0kNVgmQ8uZLlJyXmts7CM64rC/
         03aDpzQEggUWr+7MZ1IshLbivA7nka9TwGLFLGTmblVHYqMwgqprk9XGFz/715efOTTz
         XSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701242879; x=1701847679;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wi1UGBZv3FY6XCy4QwKN3cgLI0DesjDwgOR9mPrAeFU=;
        b=JnaG1XQQBhRoQ7/AxIayRggEr4Q2K+ongHZ2/hrzgc0iGU52LRWg/aL2gr8YTse8Gu
         wbdVIawn0Q3qzexuv83f5WN1uFlRVtBuKvv2UxgybXU/8OGWtKvCsS9znJMdqDb2vV91
         QqX8dgOZo3QjOJM7xa7HfHU2+oCIZ9NqrZlKbAj9Jz2z4YWgJrgv4DXxwj2BwuALmko/
         YSV0f5OmPtjIGB/+xGpfAaB0FH847blcJkz9dEQmgPdCX87UKl9n27CdIg69DLIRibAI
         TwAfenm0xvwdfNuh0/jfwLZF7nBpATXOJJ5uzA+J85mbdaUKt36+D5IgvdJ64lhZv/9R
         zbgA==
X-Gm-Message-State: AOJu0YyRn4k2UmwsHxh3++97Rnbh/fZ/12VMn2lcdklnmU5Mgw4CsboE
	fTfHsRrdtHlgCWvVnjGz5xApxFt+WX0i0dM=
X-Google-Smtp-Source: AGHT+IFGd002rDzVEPHBNnr+Y2M9d09ix4LVT+l56i30OfnX/eg6fb/ikrcPZYFGsi0G8dVlLLV+NJstPGlw1QY=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a25:d145:0:b0:d9a:5e10:c34d with SMTP id
 i66-20020a25d145000000b00d9a5e10c34dmr477678ybg.11.1701242879382; Tue, 28 Nov
 2023 23:27:59 -0800 (PST)
Date: Wed, 29 Nov 2023 07:27:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129072756.3684495-1-lixiaoyan@google.com>
Subject: [PATCH v8 net-next 0/5] Analyze and Reorganize core Networking
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

v8 changes:
1. Update net_device_read_txrx cache group maximum
2. Update MAINTAINERS for documentations
3. Skip __cache_group variables in scripts/kernel-doc

Coco Li (5):
  Documentations: Analyze heavily used Networking related structs
  cache: enforce cache groups
  netns-ipv4: reorganize netns_ipv4 fast path variables
  net-device: reorganize net_device fast path variables
  tcp: reorganize tcp_sock fast path variables

 Documentation/networking/index.rst            |   1 +
 .../networking/net_cachelines/index.rst       |  15 ++
 .../net_cachelines/inet_connection_sock.rst   |  49 ++++
 .../networking/net_cachelines/inet_sock.rst   |  43 +++
 .../networking/net_cachelines/net_device.rst  | 177 +++++++++++++
 .../net_cachelines/netns_ipv4_sysctl.rst      | 157 +++++++++++
 .../networking/net_cachelines/snmp.rst        | 134 ++++++++++
 .../networking/net_cachelines/tcp_sock.rst    | 156 +++++++++++
 MAINTAINERS                                   |   3 +
 include/linux/cache.h                         |  25 ++
 include/linux/netdevice.h                     | 117 +++++----
 include/linux/tcp.h                           | 248 ++++++++++--------
 include/net/netns/ipv4.h                      |  47 ++--
 net/core/dev.c                                |  56 ++++
 net/core/net_namespace.c                      |  45 ++++
 net/ipv4/tcp.c                                |  93 +++++++
 scripts/kernel-doc                            |   5 +
 17 files changed, 1189 insertions(+), 182 deletions(-)
 create mode 100644 Documentation/networking/net_cachelines/index.rst
 create mode 100644 Documentation/networking/net_cachelines/inet_connection_sock.rst
 create mode 100644 Documentation/networking/net_cachelines/inet_sock.rst
 create mode 100644 Documentation/networking/net_cachelines/net_device.rst
 create mode 100644 Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
 create mode 100644 Documentation/networking/net_cachelines/snmp.rst
 create mode 100644 Documentation/networking/net_cachelines/tcp_sock.rst

-- 
2.43.0.rc1.413.gea7ed67945-goog


