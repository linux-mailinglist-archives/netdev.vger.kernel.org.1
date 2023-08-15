Return-Path: <netdev+bounces-27750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076EC77D17E
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 20:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 291611C20DE8
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 18:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC4B18021;
	Tue, 15 Aug 2023 18:07:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F5818022
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 18:07:20 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997281987
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 11:07:19 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-589a9fc7fc6so61106557b3.1
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 11:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692122839; x=1692727639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujcv+EoTY4kLHVpY2ZdtWCzr8baRLX1ANim8dqftgGs=;
        b=dl4fNh8wkC4YtpmbUSdxYSovgxpqcLxH6QQhr7COMan2KKxZijSW9VPOKAu6pbpMvT
         8lJNc5Okp9g9W480AYfcCdP4pH1u6q2QZQl3FVE2fzBZfkvzwyioRblGwiV9136hLmZZ
         q0h1tSOiDHn8H/7rWyybxOx0xn9tZDPtdN9/3JVZdfCTDuu0niKvup4+q8Yqeq5+ICeZ
         dwcHK0+1NnV0HjjzN/IoJKdEKoqTpmz+omsK/Ea3Dd7z2kmRdE4scXDMfcK3NpyS1+Ol
         AGHQD07uMEThqQgxrUP7KXqxOWb/aM3VPUjBbu+vYIa0KFhmOK9RTJOD28861B8v/XjE
         IrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692122839; x=1692727639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujcv+EoTY4kLHVpY2ZdtWCzr8baRLX1ANim8dqftgGs=;
        b=LsHj+MUwIreys2srghNEH9jigemkAcF2ekQ5oiyEvj2FFsCOznAhPrPEHAhR+DCHXb
         CfsfxwTZwMktIsr35u5hpPysy9CjYuipgnqlSuaodd+dIgBPCRGNMrtI+8+w0jITAQHy
         R90LEVzkdA2juRWG2L5fVHOxGENeSiPsb/t4O3z/je4ben4906R2fBYis7WnQSia4xVO
         5Lxhi5KsjylHQx8eidz33lK8sTTvn/k/gyDaHIqMgdbQOQrMRlBivKzDYpF4iHP5zVPC
         iVBC1lzhoLRP0MeRq5+x/KuYcRELGcX/Enj+OQGVKn3vjmMrsUw2WxQP+hg5Aiqivp3t
         k+HQ==
X-Gm-Message-State: AOJu0Yy9YsQ20jrsC+p1DGbc1iXtlUxt1gfN1xWPT5snDcMEdpsxobx6
	H2yDOb2Vr6LR8rWEB/BaPBk=
X-Google-Smtp-Source: AGHT+IGkFpG25hR3qNYDj5EQNgoGEemGNIcA3GoUO3LcS/MOyKPFM5D3QqwwGicXL1YqgSjc27+qrA==
X-Received: by 2002:a81:c30a:0:b0:583:d0c3:9ae1 with SMTP id r10-20020a81c30a000000b00583d0c39ae1mr12080540ywk.51.1692122838799;
        Tue, 15 Aug 2023 11:07:18 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:84ee:9e38:88fa:8a7b])
        by smtp.gmail.com with ESMTPSA id n186-20020a8172c3000000b0058605521e6esm3543338ywc.125.2023.08.15.11.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 11:07:17 -0700 (PDT)
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
Subject: [PATCH net-next v8 2/2] selftests: fib_tests: Add a test case for IPv6 garbage collection
Date: Tue, 15 Aug 2023 11:07:06 -0700
Message-Id: <20230815180706.772638-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815180706.772638-1-thinker.li@gmail.com>
References: <20230815180706.772638-1-thinker.li@gmail.com>
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

Add 1000 IPv6 routes with expiration time (w/ and w/o additional 5000
permanet routes in the background.)  Wait for a few seconds to make sure
they are removed correctly.

The expected output of the test looks like the following example.

> Fib6 garbage collection test
>     TEST: ipv6 route garbage collection [ OK ]

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 tools/testing/selftests/net/fib_tests.sh | 72 +++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 35d89dfa6f11..c14ad6e75c1e 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -9,13 +9,16 @@ ret=0
 ksft_skip=4
 
 # all tests in this script. Can be overridden with -t option
-TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh"
+TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify \
+       ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics \
+       ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr \
+       ipv4_mangle ipv6_mangle ipv4_bcast_neigh fib6_gc_test"
 
 VERBOSE=0
 PAUSE_ON_FAIL=no
 PAUSE=no
-IP="ip -netns ns1"
-NS_EXEC="ip netns exec ns1"
+IP="$(which ip) -netns ns1"
+NS_EXEC="$(which ip) netns exec ns1"
 
 which ping6 > /dev/null 2>&1 && ping6=$(which ping6) || ping6=$(which ping)
 
@@ -747,6 +750,68 @@ fib_notify_test()
 	cleanup &> /dev/null
 }
 
+fib6_gc_test()
+{
+	setup
+
+	echo
+	echo "Fib6 garbage collection test"
+	set -e
+
+	EXPIRE=3
+
+	# Check expiration of routes every $EXPIRE seconds (GC)
+	$NS_EXEC sysctl -wq net.ipv6.route.gc_interval=$EXPIRE
+
+	$IP link add dummy_10 type dummy
+	$IP link set dev dummy_10 up
+	$IP -6 address add 2001:10::1/64 dev dummy_10
+
+	$NS_EXEC sysctl -wq net.ipv6.route.flush=1
+
+	# Temporary routes
+	for i in $(seq 1 1000); do
+	    # Expire route after $EXPIRE seconds
+	    $IP -6 route add 2001:20::$i \
+		via 2001:10::2 dev dummy_10 expires $EXPIRE
+	done
+	sleep $(($EXPIRE * 2))
+	N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
+	if [ $N_EXP_SLEEP -ne 0 ]; then
+	    echo "FAIL: expected 0 routes with expires, got $N_EXP_SLEEP"
+	    ret=1
+	else
+	    ret=0
+	fi
+
+	# Permanent routes
+	for i in $(seq 1 5000); do
+	    $IP -6 route add 2001:30::$i \
+		via 2001:10::2 dev dummy_10
+	done
+	# Temporary routes
+	for i in $(seq 1 1000); do
+	    # Expire route after $EXPIRE seconds
+	    $IP -6 route add 2001:20::$i \
+		via 2001:10::2 dev dummy_10 expires $EXPIRE
+	done
+	sleep $(($EXPIRE * 2))
+	N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
+	if [ $N_EXP_SLEEP -ne 0 ]; then
+	    echo "FAIL: expected 0 routes with expires," \
+		 "got $N_EXP_SLEEP (5000 permanent routes)"
+	    ret=1
+	else
+	    ret=0
+	fi
+
+	set +e
+
+	log_test $ret 0 "ipv6 route garbage collection"
+
+	cleanup &> /dev/null
+}
+
 fib_suppress_test()
 {
 	echo
@@ -2217,6 +2282,7 @@ do
 	ipv4_mangle)			ipv4_mangle_test;;
 	ipv6_mangle)			ipv6_mangle_test;;
 	ipv4_bcast_neigh)		ipv4_bcast_neigh_test;;
+	fib6_gc_test|ipv6_gc)		fib6_gc_test;;
 
 	help) echo "Test names: $TESTS"; exit 0;;
 	esac
-- 
2.34.1


