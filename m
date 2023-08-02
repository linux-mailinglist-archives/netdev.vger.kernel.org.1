Return-Path: <netdev+bounces-23478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CE276C195
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 02:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337FE281B93
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 00:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97552A5F;
	Wed,  2 Aug 2023 00:43:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE8D7E
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:43:22 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDD7213E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 17:43:20 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5844bb9923eso73938867b3.0
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 17:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690937000; x=1691541800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+dkCMl278sLhB4ap7p8ERGG3uylKtSpSPJXUEE81kk=;
        b=iTZ/KybJcHixAMy5sO4u3Lw5oNBeH8U/HtiF+BMRECc9dJp47T9r3LcL7bRcTFsg3z
         2Pb/qJemJB5nmCNFNs12PoMWMss9HwRuP8y9Ej9JHrmdf77nWmnx7l2Hoeg3zSbIjfC/
         HPUBQr0hYevedvzNPmvSZMNsJOVxjgNqT26gfaSPhoBEd0crWQgUGb15NgZY7zTuZCA1
         +CJiutYHGPJZk3SIE3yDHMo1ObeotlaxzzhZq5Mbd4Tx2//uEuRF/ajfliOSQoxF3GlP
         /CIOJrJjY+CivqnwdLmoLFgCW8cXUMLCfgfqvqEtUOR7fJND6n5aS6QMlFrDNiGLv61Q
         yRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690937000; x=1691541800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+dkCMl278sLhB4ap7p8ERGG3uylKtSpSPJXUEE81kk=;
        b=WypmySL5OWun7djDe3kojfZX7R75PqfenNRCsZq46uXwWDYYYDMSfRc2LlQCIoeThq
         bvtGe3gR/nvwe+4t0y264qNMq5b5ZRa4SdPtly14G3jBV/XnwTUH8zcUWMzwGBTcdVwh
         gpMJt2o1GiwXs1Zq92w6gTgcwhNQPiIs6HD2EoMSz9IMnuG1b/6Qai5eAmpwdo0opsoM
         6ckQTPD9zZPd4p0Fcw+B/0MGd6YIWRFLeRgLjogUQe9aT3bJL1N/FbNEVKpRVenz0Vow
         yQCSXajN7b2RNuKXO3Aary03ptAOmbC4FPbj53QhkxXq/1PFa6T3ltIqSusP4LkGUqkC
         Y5qA==
X-Gm-Message-State: ABy/qLaiCbahdPlX5JeaozFkmwaLI/+dY2cNAoemeDkYiTpJmhpw83ef
	U2CDfH7kJVbZwCCt/ETSBBU=
X-Google-Smtp-Source: APBJJlEubvSgX6v1iazkHBLNaOHYUoyxOfy1hZeDb+S0h0TO8n/5f6vEb59g0E+OODPwpGed7mkOuQ==
X-Received: by 2002:a81:4e56:0:b0:57a:f72:ebf8 with SMTP id c83-20020a814e56000000b0057a0f72ebf8mr18338245ywb.28.1690936999967;
        Tue, 01 Aug 2023 17:43:19 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b827:13ed:6fde:4670])
        by smtp.gmail.com with ESMTPSA id t14-20020a81830e000000b0057a560a9832sm4196344ywf.1.2023.08.01.17.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 17:43:19 -0700 (PDT)
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
Subject: [PATCH net-next v5 2/2] selftests: fib_tests: Add a test case for IPv6 garbage collection
Date: Tue,  1 Aug 2023 17:43:03 -0700
Message-Id: <20230802004303.567266-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802004303.567266-1-thinker.li@gmail.com>
References: <20230802004303.567266-1-thinker.li@gmail.com>
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

Add 1000 IPv6 routes with expiration time.  Wait for a few seconds
to make sure they are removed correctly.

The expected output of the test looks like the following example.

> Fib6 garbage collection test
>     TEST: ipv6 route garbage collection (0.000562s, 0.000566s) [ OK ]

The first number is the GC time without additional permanent routes.
The second number is the GC time with additional permanent routes.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/testing/selftests/net/fib_tests.sh | 101 ++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 35d89dfa6f11..ffd7a044f950 100755
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
 
@@ -747,6 +750,97 @@ fib_notify_test()
 	cleanup &> /dev/null
 }
 
+fib6_gc_test()
+{
+	echo
+	echo "Fib6 garbage collection test"
+
+	STRACE=$(which strace)
+	if [ -z "$STRACE" ]; then
+	    echo "    SKIP: strace not found"
+	    ret=$ksft_skip
+	    return
+	fi
+
+	EXPIRE=10
+
+	setup
+
+	set -e
+
+	# Check expiration of routes every 3 seconds (GC)
+	$NS_EXEC sysctl -wq net.ipv6.route.gc_interval=300
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
+	N_EXP=$($IP -6 route list |grep expires|wc -l)
+	if [ $N_EXP -ne 1000 ]; then
+		echo "FAIL: expected 1000 routes with expires, got $N_EXP"
+		ret=1
+	else
+	    sleep $EXPIRE
+	    REALTM_NP=$($NS_EXEC $STRACE -T sysctl \
+		       -wq net.ipv6.route.flush=1 2>&1 | \
+		       awk -- '/write\(.*"1\\n", 2\)/ { gsub("(.*<|>.*)", ""); print $0;}')
+	    N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
+
+	    if [ $N_EXP_SLEEP -ne 0 ]; then
+		echo "FAIL: expected 0 routes with expires, got $N_EXP_SLEEP"
+		ret=1
+	    else
+		ret=0
+	    fi
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
+	N_EXP=$($IP -6 route list |grep expires|wc -l)
+	if [ $N_EXP -ne 1000 ]; then
+	    echo
+	    "FAIL: expected 1000 routes with expires, got $N_EXP (5000 permanent routes)"
+		ret=1
+	else
+	    sleep $EXPIRE
+	    REALTM_P=$($NS_EXEC $STRACE -T sysctl \
+		       -wq net.ipv6.route.flush=1 2>&1 | \
+		       awk -- '/write\(.*"1\\n", 2\)/ { gsub("(.*<|>.*)", ""); print $0;}')
+	    N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
+
+	    if [ $N_EXP_SLEEP -ne 0 ]; then
+		echo "FAIL: expected 0 routes with expires," \
+		     "got $N_EXP_SLEEP (5000 permanent routes)"
+		ret=1
+	    else
+		ret=0
+	    fi
+	fi
+
+	set +e
+
+	log_test $ret 0 "ipv6 route garbage collection (${REALTM_NP}s, ${REALTM_P}s)"
+
+	cleanup &> /dev/null
+}
+
 fib_suppress_test()
 {
 	echo
@@ -2217,6 +2311,7 @@ do
 	ipv4_mangle)			ipv4_mangle_test;;
 	ipv6_mangle)			ipv6_mangle_test;;
 	ipv4_bcast_neigh)		ipv4_bcast_neigh_test;;
+	fib6_gc_test|ipv6_gc)		fib6_gc_test;;
 
 	help) echo "Test names: $TESTS"; exit 0;;
 	esac
-- 
2.34.1


