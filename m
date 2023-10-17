Return-Path: <netdev+bounces-41643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430C97CB819
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 03:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F04C52815C6
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 01:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5194F4409;
	Tue, 17 Oct 2023 01:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGUw5Zcg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961D620FC
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 01:47:28 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0649B
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:47:23 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a81cd8d267so58161147b3.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697507242; x=1698112042; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cHnZ3ZIgkOWoYkHjWP6D13w47GE8LbVUE6HoSVnoMhc=;
        b=wGUw5ZcgCLLNEMmTs9KDfFbTs2aYnuRoVwBMDFgWIkMmF/TkFWJJxkGBI74YAvbc7K
         5GtmSMyGL7x9IVWC/4l3TM6JcTF4MASqErod1mqQvTVt2OAKUiyCB8cZlQARWxe51GIx
         CEUYikuOuF8ze5ZqDoig9vzEfQgV9dJahy95nNInE4meRSuONA2YUWyvw94T63kgSOnL
         5vJnyCdk0mwmLhA914CRRvrHE+2awScX1BFCl2n10HI2kv0mlAqTydZVRPm+fA//HJ9R
         5wMXGWRct/aEvWj8sF5LuZ+B0Zt4B8rCpRXQUoR5NfgmV+YT9+zokmYrMmTV5j+9Yu52
         9p+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697507242; x=1698112042;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cHnZ3ZIgkOWoYkHjWP6D13w47GE8LbVUE6HoSVnoMhc=;
        b=VBKRjl5wONN5UfEWiO32N7xd537meZqhhweK0yUXaTbSFi2tNdQZjdXr8AojH1BxZ4
         djU+Df2f3Z7L3KCc7bxk22fmG25msQRdCOsnozqr1Ev2DK372h9VaRTj9V6mTL77UxCc
         h75qttj5k7NxykyvXBGcPXkhviZibsNDZ+E6YAyiO6/d/kxiaRuw4J/SuWFLQcS0XEFs
         rPG1Rzkkd8z5x1unXp7oFYrO3+x5NC7kGNlNy/ZnFr8ElDgQXrtdemx/LFlFR0oBOUKt
         B1AfTisUO+1GDQi2L+3v4IR4ja7k3H253caTAdu4cls+goemvjCyK/85Nr4lRmARwxoF
         qyCA==
X-Gm-Message-State: AOJu0YyQtzqUHcvVBORF6Em945tNd61IOX5Y2E4KvfYFt3RjAxE/2Dpp
	lS1SnZ+u58HkkQcnKbKqCqN7e8ljpu8Zaxw=
X-Google-Smtp-Source: AGHT+IFh1L5NDhiKl4HU0FULWV67akb95MoOqfjQi0ja0aYmlxHSswZ5TVzoCXMGxTj3Cii5b8lVLwo+UkeqbE0=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a0d:d90f:0:b0:59b:d857:8317 with SMTP id
 b15-20020a0dd90f000000b0059bd8578317mr19381ywe.2.1697507242414; Mon, 16 Oct
 2023 18:47:22 -0700 (PDT)
Date: Tue, 17 Oct 2023 01:47:11 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231017014716.3944813-1-lixiaoyan@google.com>
Subject: [PATCH v2 net-next 0/5] Analyze and Reorganize core Networking
 Structs to optimize cacheline consumption
From: Coco Li <lixiaoyan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Coco Li <lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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

Coco Li (4):
  Documentations: Analyze heavily used Networking related structs
  netns-ipv4: reorganize netns_ipv4 fast path variables
  net-device: reorganize net_device fast path variables
  tcp: reorganize tcp_sock fast path variables

 .../net_cachelines/inet_connection_sock.rst   |  42 ++++
 .../networking/net_cachelines/inet_sock.rst   |  37 +++
 .../networking/net_cachelines/net_device.rst  | 167 ++++++++++++
 .../net_cachelines/netns_ipv4_sysctl.rst      | 151 +++++++++++
 .../networking/net_cachelines/snmp.rst        | 128 ++++++++++
 .../networking/net_cachelines/tcp_sock.rst    | 148 +++++++++++
 include/linux/netdevice.h                     |  99 ++++----
 include/linux/tcp.h                           | 238 +++++++++---------
 include/net/netns/ipv4.h                      |  41 +--
 include/uapi/linux/snmp.h                     |  34 ++-
 10 files changed, 896 insertions(+), 189 deletions(-)
 create mode 100644 Documentation/networking/net_cachelines/inet_connection_sock.rst
 create mode 100644 Documentation/networking/net_cachelines/inet_sock.rst
 create mode 100644 Documentation/networking/net_cachelines/net_device.rst
 create mode 100644 Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
 create mode 100644 Documentation/networking/net_cachelines/snmp.rst
 create mode 100644 Documentation/networking/net_cachelines/tcp_sock.rst

-- 
2.42.0.655.g421f12c284-goog


