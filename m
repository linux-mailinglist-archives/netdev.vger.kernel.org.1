Return-Path: <netdev+bounces-23476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E8D76C193
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 02:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82AC01C20E7D
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 00:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF83B637;
	Wed,  2 Aug 2023 00:43:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16E47E
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:43:19 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A08213E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 17:43:18 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-583ae4818c8so70784547b3.3
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 17:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690936997; x=1691541797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JaKiaM9L/tr/M3ADd4/fknorkY1s7BcBJwwSJwtKOq4=;
        b=cQyj7cWdBsK8vhWLhKhNo6mabI9DC/zSEGjJwoYsYULDuY+NuScUxzCroj6PDJt9+z
         uH7T9ImAq+p0xLPaPjVnB+4C4B5DeBfdk9d1407tWK4v/vhgyAJ3MHu+HgFYDfKrTYaP
         D+GvPrBDFtgbldxoKi8uf07I5oBTKXFlU6C9qidVGE4UYu/fXbqwGKayM8kj3qavYrPH
         HMVuHcbkddQJiQVc/NeOUVMF7mJLyliwpnu3drAPbJgsfGos5NbiuZC6zGG7VBi360uq
         Qow9RGblIFK20OzkYFTVpgsDDcN0qgOW8nqSi8v8WOG0A24cIxXHhHdG9aMiR9gXKJJU
         bq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690936997; x=1691541797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JaKiaM9L/tr/M3ADd4/fknorkY1s7BcBJwwSJwtKOq4=;
        b=fOC1Yh9hgCkK5nHYZzJw5/8THWmzsPnmJk7EG+8RNITtAnXocFZTJKoNNyhuEAQqHw
         fq2GdhsSRLtyAbsLjZzMeycRhhSrUWm9j16MlBI5jE69b/O2wEGmA7K/akpti92tMWrO
         6+wE3zY+Cl1NJMNRwuWoYc/+6ZKBUcgIkM9mA21pdRyfyUmep12f4LErFOXkTuDzfN1r
         1PoAOF2rrMub2wRSKi9wD6ySNu5AXUnRJDLHtPSLHdDijJz3FZyiGmuNPCVCIrJiwO0u
         o+5ns/Gg5hFVy0itkQ0GMrz09R+jSRsTC5aQVcgILaGa2TxbtsX7uXoXXeZt14/3vWx/
         mVtA==
X-Gm-Message-State: AOJu0YwBcA0ZJwxW1WWh/Z18hAa2idihETAvqfZT7+J+MyGM50lNo6Wg
	GhYTAPpHp17PJ6QOE+Lpjwk=
X-Google-Smtp-Source: AGHT+IGygj56W751RJk0YN2zw0Dzbb4SiIpUTkyRMC+J5E1Rq9CjxrvUdJMtQOtSfSnSI1OiljDXOA==
X-Received: by 2002:a0d:df0c:0:b0:565:c21d:8ec6 with SMTP id i12-20020a0ddf0c000000b00565c21d8ec6mr2021534ywe.6.1690936997288;
        Tue, 01 Aug 2023 17:43:17 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b827:13ed:6fde:4670])
        by smtp.gmail.com with ESMTPSA id t14-20020a81830e000000b0057a560a9832sm4196344ywf.1.2023.08.01.17.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 17:43:16 -0700 (PDT)
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
Subject: [PATCH net-next v5 0/2] Remove expired routes with a separated list of routes.
Date: Tue,  1 Aug 2023 17:43:01 -0700
Message-Id: <20230802004303.567266-1-thinker.li@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
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

Kui-Feng Lee (2):
  net/ipv6: Remove expired routes with a separated list of routes.
  selftests: fib_tests: Add a test case for IPv6 garbage collection

 include/net/ip6_fib.h                    |  65 ++++++++++++---
 net/ipv6/ip6_fib.c                       |  56 +++++++++++--
 net/ipv6/route.c                         |   6 +-
 tools/testing/selftests/net/fib_tests.sh | 101 ++++++++++++++++++++++-
 4 files changed, 203 insertions(+), 25 deletions(-)

-- 
2.34.1


