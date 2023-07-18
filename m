Return-Path: <netdev+bounces-18672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFEE75840F
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 20:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E161C20DA7
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 18:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CB615AFF;
	Tue, 18 Jul 2023 18:03:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B00115AD8
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 18:03:46 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DE6A1
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 11:03:45 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-579e212668fso85516157b3.1
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 11:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689703424; x=1692295424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S6oUM3Pu09QMcWdhveiKRJ9uWWTzakR6SjAXBAE64is=;
        b=UOGy33U5SmJGv0qIt5hV6EYwY+yqNCtWu9WhQeWysShLtAho92yufk03bpkjQG4VUE
         jKb7K7DR6v43hPedVs71jyPPl+AwqHK9crWUJfhPWuDzCPgUZXK8MSeG3TZkI+wApMtE
         exoxYBCtoS9F7FUPaXjc/CR/lgQfbEqrS7v2gEYn97aM4nlbgdjTnwYzd/Dogtojjw5n
         xXeISmdW2F5FpyyGQtJLEMu0Rxc++QHtkSndvX5jrfS764VgyvRnkPT1TOGYQNHMesCF
         zGbStsaEYigMspGiWuoGl4jSwlUQd3MBG5IhD0ypxg7hkRd0Fcxttnsh9jA8iZa7j20H
         81Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689703424; x=1692295424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6oUM3Pu09QMcWdhveiKRJ9uWWTzakR6SjAXBAE64is=;
        b=YhYy4+PamG/J3o1cCjh/sLalvpSZQSK8PKKYz+PAE+efDc/NJXkru1tVzjTtTu1lhr
         YSzsqSC4ZZw+bA5iVBUAtItWP3WMbW9KO2zK55ghXf76XvplshE9LLF2nVWa6lqB+oUu
         kQz/UKD7CheS7+xiB3KrKZef5jvBVhV7927yVKjEay3es52vO3pZOWnitUAdSe6ToKfl
         ZUGZ6FMNO9ubpyLA4PnLa2HFif6DZ0VNj1Ayuo6njRc/KO/ZOGQn5RwR8pZCk68dAWBf
         LkuhvGGmth0G9ieY865FbVvlMw1rK6kR2xpFkNk7VmvBKUOx1NUjHsmeo6qvLKpQR1Lr
         7fWg==
X-Gm-Message-State: ABy/qLaFpo5UVVoLfVaH5PQscmFKrZOtEM1xjqzUPowwZVfl8M/g4PCK
	tbGZmATPXn8olkFppFWGKZk=
X-Google-Smtp-Source: APBJJlEuAmcAtW06W1lsid++Pyt9t3KPHY9TGHREEB6E1MWatpLQ2Qx5sgCa96ynTpHpm4bCD2YmCg==
X-Received: by 2002:a81:8307:0:b0:579:de63:3486 with SMTP id t7-20020a818307000000b00579de633486mr13675557ywf.5.1689703424446;
        Tue, 18 Jul 2023 11:03:44 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:770d:e789:cf56:fb43])
        by smtp.gmail.com with ESMTPSA id d3-20020a81d343000000b00577044eb00esm579121ywl.21.2023.07.18.11.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 11:03:43 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
X-Google-Original-From: Kui-Feng Lee <kuifeng@meta.com>
To: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	yhs@meta.com
Cc: Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH net-next v2 0/2] Remove expired routes with a
Date: Tue, 18 Jul 2023 11:03:19 -0700
Message-Id: <20230718180321.294721-1-kuifeng@meta.com>
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

For example, years ago, there is a commit c7bb4b89033b ("ipv6: tcp: drop
silly ICMPv6 packet too big messages") about "ICMPv6 Packet too big
messages". The root cause is that malicious ICMPv6 packets were sent back
for every small packet sent to them. These packets add routes with an
expiration time that prompts the GC to periodically check all routes in the
tables, including permanent ones.

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


Major changes from v1:

 - Moved gc_link to avoid creating a hole in fib6_info.

 - Moved fib6_set_expires*() and fib6_clean_expires*() to the header
   file and inlined. And removed duplicated lines.

 - Added a test case.

---
v1: https://lore.kernel.org/all/20230710203609.520720-1-kuifeng@meta.com/

Kui-Feng Lee (2):
  net/ipv6: Remove expired routes with a separated list of routes.
  selftests: fib_tests: Add a test case for IPv6 garbage collection

 include/net/ip6_fib.h                    | 65 +++++++++++++++++++-----
 net/ipv6/ip6_fib.c                       | 53 +++++++++++++++++--
 net/ipv6/route.c                         |  6 +--
 tools/testing/selftests/net/fib_tests.sh | 49 +++++++++++++++++-
 4 files changed, 152 insertions(+), 21 deletions(-)

-- 
2.34.1


