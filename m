Return-Path: <netdev+bounces-18692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBE37584DE
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 20:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927612816E0
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 18:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896EA3FF4;
	Tue, 18 Jul 2023 18:33:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6B6ED5
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 18:33:57 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246269D
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 11:33:56 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-57a551ce7e9so61410687b3.3
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 11:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689705235; x=1692297235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tMloXa4I4dsVHitk3IEEmkr0KjVokwbjqH/sSzUNgMo=;
        b=hyEGD3T8/PTZ799wIpOIAp/ES6Cfn6IFlzM8M+anB8SJfVbnKXOHiTg9s0EsoQWZAi
         tL9rZ5E72HRrGPDst2oPaSutxNJte1OGBVQ1/IaEVOSb0kj4wmwpUc8hHLkcrkZLiBSu
         cc+3HKwMJh75A1Fh6MkBr96xS98Up5hdX5DcrR9NY6hxTkFe3TBJOkx2cLK5o7cw76B4
         Y9gqyTuwj3Hc/UU7I5w0shR2xM6VC9qW16jukeX8xtMvB8WgqJYVmayGjrQaa52l1lTP
         5+tlIijmL9ZEqnhJCl4vnFnyGSYbLsifp/lW7rb0NOnlkNqi6uzTYBfHS/LVWwXPiz4+
         6Vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689705235; x=1692297235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tMloXa4I4dsVHitk3IEEmkr0KjVokwbjqH/sSzUNgMo=;
        b=Adm6f8pzzDx0d7nKH0KHv2UkHcl+WcKOWMBReW/qwWHoC0hMLVvIjDj2OMrlYASDLv
         kC4PRAgOqZxR6JVnXX+cUQjb+BHxqIuBLapi/1UgQM7sWUOWKtXUOVIlRjoqhmSGgxTC
         /g9Ok3XVHKc6FcdKLYnCYdTwXChn/ssLu2T9EIv9d9SMY82keqDC0nxVq8z8dO+gBZc3
         Hp2rHx5e22oO8ghu0Vihjl0ranI3JYSq4n2rBxrLdi83HnwZaSueGk723sOiVsenZAh7
         KaH30ArqiWNaLYLUiMPbIEu25/wSRJCtCZbxVex3OaBW/0ZMHy8k4yVvvcLZoOj/yg1H
         CGdQ==
X-Gm-Message-State: ABy/qLbSuVWM+fYripHwuaVB11W+tnfn0dBXrh9a2FdyvY1Y8haTFoff
	Ov44iVKaQ7X5r8aaots+T2g=
X-Google-Smtp-Source: APBJJlHPwLlZ9saOw8Y6SRLbFrFCnXawqtj4pRUGJsqoS3XDo7mFvd/JgjhkIbpB/LdSjDO+/jPbhA==
X-Received: by 2002:a0d:f506:0:b0:57a:8de9:16a3 with SMTP id e6-20020a0df506000000b0057a8de916a3mr554502ywf.8.1689705235221;
        Tue, 18 Jul 2023 11:33:55 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:770d:e789:cf56:fb43])
        by smtp.gmail.com with ESMTPSA id r66-20020a0dcf45000000b0057069c60799sm607227ywd.53.2023.07.18.11.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 11:33:54 -0700 (PDT)
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
Subject: [PATCH net-next v3 0/2] Remove expired routes with a separated list of routes.
Date: Tue, 18 Jul 2023 11:33:49 -0700
Message-Id: <20230718183351.297506-1-kuifeng@meta.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

Kui-Feng Lee (2):
  net/ipv6: Remove expired routes with a separated list of routes.
  selftests: fib_tests: Add a test case for IPv6 garbage collection

 include/net/ip6_fib.h                    | 65 +++++++++++++++++++-----
 net/ipv6/ip6_fib.c                       | 53 +++++++++++++++++--
 net/ipv6/route.c                         |  6 +--
 tools/testing/selftests/net/fib_tests.sh | 46 ++++++++++++++++-
 4 files changed, 149 insertions(+), 21 deletions(-)

-- 
2.34.1


