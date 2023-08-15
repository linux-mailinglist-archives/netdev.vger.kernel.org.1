Return-Path: <netdev+bounces-27748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3850777D17B
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 20:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24C7281574
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 18:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85D615AFC;
	Tue, 15 Aug 2023 18:07:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1E6156D9
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 18:07:15 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B921984
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 11:07:14 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-584034c706dso62641847b3.1
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 11:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692122833; x=1692727633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RG6MXXJz2S2XEVwPYJGUSZpWcA5qYI6DcKSMHJRq58Y=;
        b=fHyBwL/GZY/8ETEcCzAOmHE5RHPGSlP96dtfbc6XLaa6O4PI4gmtaI8MZ+j9CjWfwT
         WnLUN28thl+i9wHqAExhsH9y+2S7BxteSibyFHgUEw4KEUIEjsL89VRxaVtjbyRTFDC/
         KlWj8OnA/GntGptb6vMwW1he7yr2W43WBQ0g9H16YVSVDsZNFexlsnHQvnWvEn2Fufwa
         AnXlMM81KMfTtukB65v8yzkLSLtllICaUrWIRjAhJ9NcrDUhyRG6PaiLen16QslijEg3
         75YL4nqJ50LKhaqlE5Ei0gHEAOSyoZTnie/dfFp6bjLoRnxeoIMczlSlMDTzMb/zY/t3
         Fh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692122833; x=1692727633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RG6MXXJz2S2XEVwPYJGUSZpWcA5qYI6DcKSMHJRq58Y=;
        b=Uk9rothEOxgJTPh/cWfxZCYPJ0nsPqE/Ax+xNYGYed2Tc53gXnOVF4S08UWirVRkuK
         j2Phah/2OJb6gWmv3sWlwOsmIK+WEfQjKdjZbAmlA5n1ouXCpfNrL84Z6KZUdrkn/g05
         mzeoGWBQIdjudO+OUiN9vqqOYJlRerFtbrd88AR8g5lMiuhFvkmmvzK5wHzt75ZJ3ka/
         4rRAi5oa6NvCmb7bguWCN11QvJ9OQ5IAcVPiU3ZAX7huQkwsj3hgz5XWT3g7zCY10L0+
         9BSIwCQMmvW77OrdH2Eu2u10ew/Zqnkwjae/QGQ8Hifl8T81HKdW39o3/kLXUqheLpQ4
         9tBQ==
X-Gm-Message-State: AOJu0Yzkqx/H966koGx0+j6OV6HHrmUEeQu4jIAjdiB3LPGW5Q2QFGCj
	9GNorvqhRbGVxBp+TVngZ4Y=
X-Google-Smtp-Source: AGHT+IFIdPItMpwrjUP6pr8ZbLfHIaFB6BAm7YbWELoMUodCB/hyckVAvJrTBaVXrSOneu1VMDiFmg==
X-Received: by 2002:a81:a1d7:0:b0:589:d560:adaa with SMTP id y206-20020a81a1d7000000b00589d560adaamr10574893ywg.7.1692122833325;
        Tue, 15 Aug 2023 11:07:13 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:84ee:9e38:88fa:8a7b])
        by smtp.gmail.com with ESMTPSA id n186-20020a8172c3000000b0058605521e6esm3543338ywc.125.2023.08.15.11.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 11:07:11 -0700 (PDT)
From: thinker.li@gmail.com
To: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	yhs@meta.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH net-next v8 0/2] Remove expired routes with a separated list of routes.
Date: Tue, 15 Aug 2023 11:07:04 -0700
Message-Id: <20230815180706.772638-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

FIB6 GC walks trees of fib6_tables to remove expired routes. Walking a tree
can be expensive if the number of routes in a table is big, even if most of
them are permanent. Checking routes in a separated list of routes having
expiration will avoid this potential issue.

Background
==========

The size of a Linux IPv6 routing table can become a big problem if not
managed appropriately.  Now, Linux has a garbage collector to remove
expired routes periodically.  However, this may lead to a situation in
which the routing path is blocked for a long period due to an
excessive number of routes.

For example, years ago, there is a commit c7bb4b89033b ("ipv6: tcp:
drop silly ICMPv6 packet too big messages").  The root cause is that
malicious ICMPv6 packets were sent back for every small packet sent to
them. These packets add routes with an expiration time that prompts
the GC to periodically check all routes in the tables, including
permanent ones.

Why Route Expires
=================

Users can add IPv6 routes with an expiration time manually. However,
the Neighbor Discovery protocol may also generate routes that can
expire.  For example, Router Advertisement (RA) messages may create a
default route with an expiration time. [RFC 4861] For IPv4, it is not
possible to set an expiration time for a route, and there is no RA, so
there is no need to worry about such issues.

Create Routes with Expires
==========================

You can create routes with expires with the  command.

For example,

    ip -6 route add 2001:b000:591::3 via fe80::5054:ff:fe12:3457 \ 
        dev enp0s3 expires 30

The route that has been generated will be deleted automatically in 30
seconds.

GC of FIB6
==========

The function called fib6_run_gc() is responsible for performing
garbage collection (GC) for the Linux IPv6 stack. It checks for the
expiration of every route by traversing the trees of routing
tables. The time taken to traverse a routing table increases with its
size. Holding the routing table lock during traversal is particularly
undesirable. Therefore, it is preferable to keep the lock for the
shortest possible duration.

Solution
========

The cause of the issue is keeping the routing table locked during the
traversal of large trees. To solve this problem, we can create a separate
list of routes that have expiration. This will prevent GC from checking
permanent routes.

Result
======

We conducted a test to measure the execution times of fib6_gc_timer_cb()
and observed that it enhances the GC of FIB6. During the test, we added
permanent routes with the following numbers: 1000, 3000, 6000, and
9000. Additionally, we added a route with an expiration time.

Here are the average execution times for the kernel without the patch.
 - 120020 ns with 1000 permanent routes
 - 308920 ns with 3000 ...
 - 581470 ns with 6000 ...
 - 855310 ns with 9000 ...

The kernel with the patch consistently takes around 14000 ns to execute,
regardless of the number of permanent routes that are installed.

Major changes from v7:

 - Fix warings raised by the patchwork.

Major changes from v6:

 - Remove unnecessary check of tb6 in fib6_clean_expires_locked().

 - Use ib6_clean_expires_locked() instead in fib6_purge_rt().

Major changes from v5:

 - Change the order of adding new routes to the GC list and starting
   GC timer.

 - Remove time measurements from the test case.

 - Stop forcing GC flush.

Major changes from v4:

 - Detect existence of 'strace' in the test case.

Major changes from v3:

 - Fix the type of arg according to feedback.

 - Add 1k temporary routes and 5K permanent routes in the test case.
   Measure time spending on GC with strace.

Major changes from v2:

 - Remove unnecessary and incorrect sysctl restoring in the test case.

Major changes from v1:

 - Moved gc_link to avoid creating a hole in fib6_info.

 - Moved fib6_set_expires*() and fib6_clean_expires*() to the header
   file and inlined. And removed duplicated lines.

 - Added a test case.

---
v1: https://lore.kernel.org/all/20230710203609.520720-1-kuifeng@meta.com/
v2: https://lore.kernel.org/all/20230718180321.294721-1-kuifeng@meta.com/
v3: https://lore.kernel.org/all/20230718183351.297506-1-kuifeng@meta.com/
v4: https://lore.kernel.org/bpf/20230722052248.1062582-1-kuifeng@meta.com/
v5: https://lore.kernel.org/all/20230802004303.567266-1-thinker.li@gmail.com/
v6: https://lore.kernel.org/all/20230808180309.542341-1-thinker.li@gmail.com/
v7: https://lore.kernel.org/all/20230812003047.447772-1-thinker.li@gmail.com/

Kui-Feng Lee (2):
  net/ipv6: Remove expired routes with a separated list of routes.
  selftests: fib_tests: Add a test case for IPv6 garbage collection

 include/net/ip6_fib.h                    | 64 ++++++++++++++++-----
 net/ipv6/ip6_fib.c                       | 55 ++++++++++++++++--
 net/ipv6/route.c                         |  6 +-
 tools/testing/selftests/net/fib_tests.sh | 72 +++++++++++++++++++++++-
 4 files changed, 172 insertions(+), 25 deletions(-)

-- 
2.34.1


