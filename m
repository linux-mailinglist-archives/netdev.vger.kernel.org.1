Return-Path: <netdev+bounces-26982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5D2779BEE
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 02:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEBDC281F9C
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 00:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1DD636;
	Sat, 12 Aug 2023 00:30:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410A9290E
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 00:30:55 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA8F3585
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 17:30:50 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-583c48a9aa1so28133777b3.1
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 17:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691800250; x=1692405050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zPh2F/dn/0zR7+tcvWLlQsCCi7MwQNt4nMfuymzg+mc=;
        b=Tzik3s1hpTVXv4P6b3+FnIE+INdvMCD5KT/lSBrxqiJY+5/VOOLgEpbqCLWiIWwY5c
         Xhw7XPK1FhA67jLv1SRyNWUAEgXlF1MAAfUgbpXXteZfmLoB5jrAKM1VfnrLdoR5uKd1
         yuw4zqvYhB8fgEhBVwJSb2OicslaQFbtgnGCblxSPJ1NpQF1CBFIxqw6tQ9KuQlnO2ku
         B+DKylV0drqtWz/3NNz4hHRhc+qIMtfeBNutVJYC+5z0KAf/GOq86uzu8ETmwWGHl1N7
         m1qqwzThzJccbqc2jrsQjRcuPNEEyHZ4AbH5JgIH1/7ahctwwwrwaIfZl8aV8JR3JA1C
         zSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691800250; x=1692405050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPh2F/dn/0zR7+tcvWLlQsCCi7MwQNt4nMfuymzg+mc=;
        b=DhiReO8Bz23P6zgLiWDPvyHtHnrq+K4sAmZMVgGCK6MBO0De89lh5mM2VQz4ZpvPO0
         ALFqMax8agSo+Bje5tzi2KK4t+fsE+y/LhdKQMAUKG8nI+ssGMwn/zXAbS5tY3PKtkx4
         llyXH4l/yg4KoEiZZfuxeg07U4Kewn2kODMiW6t5kOjeZkpqgOSv3Om0PdAbqWJxwZnr
         fq53fw25E7Xs8FN+gQPLeSRYh2S4EYYNRifnVlNJI/5nx6EaQKfQwju0hiohB9N0uuVB
         BB6zwwNPkdnuJ5f94TRjGnLhdzCymsaDRAsoP4RcHkZ/SMXSxvQBHfgI41JuDOpGvGhg
         R1pw==
X-Gm-Message-State: AOJu0Yy9uisun0V6B2qcQ213i2cO6qR+Qtc2gq+SHbWPZfZ9rjjHS5cD
	nqrhkvu30LeB4RujdeRIPEI=
X-Google-Smtp-Source: AGHT+IFzb74BlcjElP+h3xMjSeH0LKnG6Y91qAitI0oBOPddU5kF20UBqBSBUslRGg4Bsk4Q9OWhaA==
X-Received: by 2002:a81:91c7:0:b0:57a:2e83:4daf with SMTP id i190-20020a8191c7000000b0057a2e834dafmr3358983ywg.32.1691800249991;
        Fri, 11 Aug 2023 17:30:49 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:680f:f8a3:c49b:84db])
        by smtp.gmail.com with ESMTPSA id n11-20020a0dcb0b000000b0058419c57c66sm1319648ywd.4.2023.08.11.17.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 17:30:49 -0700 (PDT)
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
Subject: [PATCH net-next v7 0/2] Remove expired routes with a separated list of routes.
Date: Fri, 11 Aug 2023 17:30:45 -0700
Message-Id: <20230812003047.447772-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Kui-Feng Lee (2):
  net/ipv6: Remove expired routes with a separated list of routes.
  selftests: fib_tests: Add a test case for IPv6 garbage collection

 include/net/ip6_fib.h                    | 62 +++++++++++++++-----
 net/ipv6/ip6_fib.c                       | 54 ++++++++++++++++--
 net/ipv6/route.c                         |  6 +-
 tools/testing/selftests/net/fib_tests.sh | 72 +++++++++++++++++++++++-
 4 files changed, 169 insertions(+), 25 deletions(-)

-- 
2.34.1


