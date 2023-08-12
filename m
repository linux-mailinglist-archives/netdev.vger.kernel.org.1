Return-Path: <netdev+bounces-26984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A429779BF0
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 02:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0C81C20D85
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 00:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC49A2D;
	Sat, 12 Aug 2023 00:30:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D56D2592
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 00:30:57 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4FD2686
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 17:30:53 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-58419517920so26707297b3.0
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 17:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691800252; x=1692405052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujcv+EoTY4kLHVpY2ZdtWCzr8baRLX1ANim8dqftgGs=;
        b=MQ4iT+glAF6R6aGeeo5uBdrrUtXv0l1eN0TcXNreIHZDHUXhdk6O5Rr5rq2eJgCcBf
         s33ea7mwHj/WlkeHKy6jSfoAvoY80jBTJu/noue/nYeAIq9CH6wqwgCbuIu0xwd2o6VP
         Cwo0n+nFJobjO1meyjjojXNpyp3o0Za0yscsoo3glQdrhTbucn3idpcnW/+sFZVXJRj0
         T/7CitbTvlmCGrd5SO2nITYE8Q3WW8rpc5h7ZWHz0/ieOQLb2Htv1vjxJELDLF2EvC+Q
         jY2zll16NAoF+Q8DRVRBqNwtRfrNnrHO+unceM3A4hA0kB5oI72LV6VncGpuQBbSbeHr
         sz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691800252; x=1692405052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujcv+EoTY4kLHVpY2ZdtWCzr8baRLX1ANim8dqftgGs=;
        b=HcBd4z9Z3rLqBh9NUHL+QITgUksGYrxSdT41R2dcaPFaJ8yZYmInGYH4Bw3GxucT6h
         vcjgV+dhnQ8FOSjOaaliTIyuklZ4KkMY0KAPDw5ECQe2QujGq4DwaoUx8uD5sWj1Ilnk
         fyi5otC+vZtxafy4NN5XGVMIVY7jlBoAnlQr4CPSLcvKSvyZfKlljfDQK/CznoKKxW2b
         ZSFotfeBLn57Oty29fbX8OljHCqyTnGh69Ele+oGnBaSU8O3t5463cYm9EN02u98i/HK
         Qugsu/VoOtaMQRedytUNaZhH6KhGNuyJd29zbqQgn1eboRmLxtuOUYSVDn1mRiJHJrO+
         TiRg==
X-Gm-Message-State: AOJu0Yxp9NczObPg5eK9dt71ZjEmNbTh4RtzvJF5XQNbgri34b3VbOJE
	yFt6H1u6c+JJ6IbMBraEEzY=
X-Google-Smtp-Source: AGHT+IFCKiwYq0Mb9LIlHCeR/cHLDE5ux8+7HXktNELcLZ4CGgiffHf0GHRU9dgl5bs9EE0N+PfNYg==
X-Received: by 2002:a0d:d5d1:0:b0:570:6d74:21d5 with SMTP id x200-20020a0dd5d1000000b005706d7421d5mr3257012ywd.13.1691800252526;
        Fri, 11 Aug 2023 17:30:52 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:680f:f8a3:c49b:84db])
        by smtp.gmail.com with ESMTPSA id n11-20020a0dcb0b000000b0058419c57c66sm1319648ywd.4.2023.08.11.17.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 17:30:52 -0700 (PDT)
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
Subject: [PATCH net-next v7 2/2] selftests: fib_tests: Add a test case for IPv6 garbage collection
Date: Fri, 11 Aug 2023 17:30:47 -0700
Message-Id: <20230812003047.447772-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230812003047.447772-1-thinker.li@gmail.com>
References: <20230812003047.447772-1-thinker.li@gmail.com>
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


