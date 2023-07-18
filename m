Return-Path: <netdev+bounces-18674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DAA758414
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 20:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E481C20DA8
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 18:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340BE16439;
	Tue, 18 Jul 2023 18:03:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A101641A
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 18:03:48 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E1EA1
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 11:03:47 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5703d12ab9aso63845617b3.2
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 11:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689703427; x=1692295427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Riln5D5h2av6atICAmEf/T7z2Htnvljx+MGTGiofZP4=;
        b=i9/qKEThNtRXTTqLYSLyydaQ2gzOl+xHWBUQq1OxjerFSOO6C9PYWqBlywFuZIwmSc
         GFimedGoBQJTjI8S52p4/Geye0zenpRlixvnKwAUHdQ+nRVPUPeMyPedHw7CinIFamYx
         EEsZ1b899aTSRq67dO4b27Yy0ulqcp1R6WIDpbUSbF7ZLSKM1MCQhYfuJeG5sWDZOL1P
         rCUgqi1hZB/5AEDon2UShDf3hIXRR5BqRueBWkHsNWa/6IYOZZ6vngEkIUmk8tDpWs9I
         A2MPtieHwTyygZ8BBpEDl8u3DfoTuUihU+rTifwsfmhorTq3MZVUTWq6WrMwhqplOEZ4
         ndiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689703427; x=1692295427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Riln5D5h2av6atICAmEf/T7z2Htnvljx+MGTGiofZP4=;
        b=IfBTnjze3OwpQZfjd062/ae9tTS9I0FHn0kxHO++vYIwm+r+1AmpgKdRnfHY29RoZA
         Sd+VZH+HPRHd3jITqe8WIt4/azraGUp1mAKx5MaP14IlM5oiQjcaZzq6osogCT8AV2y4
         klGCd5hFsIjsDzwdxRl2W6bRzQ1kasFj94+LK1gFbYU2O9RsWF3pI60gQ6I9mmj9PrHy
         9e8bUObOT/FGEP6nVkJifIemMhFAnVudIBwt3T7V//V+3noojJz71OpBDu441UtJju1h
         VsNiG6aT4yV61Av2oP7eudHfeVJxwiIgaSpCoytky2wivk9sD0mi+/pvVrjEh78+UvgR
         nvSw==
X-Gm-Message-State: ABy/qLasUrx+pdUZuKdm9gUdQijnU1y9ofyWRNtolYLu1onnbVs0vUsY
	1mElh/p9oIXx28/9lO1q9sk=
X-Google-Smtp-Source: APBJJlHtneXtYqeZk2BtrdTLTlwRHXiDIfFVJex9OwL+oDjNhszHvwGHvDZI3qjhtPk+GrQ8n6bdkg==
X-Received: by 2002:a81:a001:0:b0:583:4f67:d5c3 with SMTP id x1-20020a81a001000000b005834f67d5c3mr350362ywg.52.1689703426877;
        Tue, 18 Jul 2023 11:03:46 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:770d:e789:cf56:fb43])
        by smtp.gmail.com with ESMTPSA id d3-20020a81d343000000b00577044eb00esm579121ywl.21.2023.07.18.11.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 11:03:46 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/2] selftests: fib_tests: Add a test case for IPv6 garbage collection
Date: Tue, 18 Jul 2023 11:03:21 -0700
Message-Id: <20230718180321.294721-3-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230718180321.294721-1-kuifeng@meta.com>
References: <20230718180321.294721-1-kuifeng@meta.com>
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

Add 10 IPv6 routes with expiration time.  Wait for a few seconds
to make sure they are removed correctly.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 tools/testing/selftests/net/fib_tests.sh | 49 +++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 35d89dfa6f11..55bc6897513a 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -9,7 +9,7 @@ ret=0
 ksft_skip=4
 
 # all tests in this script. Can be overridden with -t option
-TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh"
+TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh fib6_gc_test"
 
 VERBOSE=0
 PAUSE_ON_FAIL=no
@@ -747,6 +747,52 @@ fib_notify_test()
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
+	OLD_INTERVAL=$(sysctl -n net.ipv6.route.gc_interval)
+	# Check expiration of routes every 3 seconds (GC)
+	$NS_EXEC sysctl -wq net.ipv6.route.gc_interval=3
+
+	$IP link add dummy_10 type dummy
+	$IP link set dev dummy_10 up
+	$IP -6 address add 2001:10::1/64 dev dummy_10
+
+	for i in 0 1 2 3 4 5 6 7 8 9; do
+	    # Expire route after 2 seconds
+	    $IP -6 route add 2001:20::1$i \
+		via 2001:10::2 dev dummy_10 expires 2
+	done
+	N_EXP=$($IP -6 route list |grep expires|wc -l)
+	if [ $N_EXP -ne 10 ]; then
+		echo "FAIL: expected 10 routes with expires, got $N_EXP"
+		ret=1
+	else
+	    sleep 4
+	    N_EXP_s20=$($IP -6 route list |grep expires|wc -l)
+
+	    if [ $N_EXP_s20 -ne 0 ]; then
+		echo "FAIL: expected 0 routes with expires, got $N_EXP_s20"
+		ret=1
+	    else
+		ret=0
+	    fi
+	fi
+
+	set +e
+
+	log_test $ret 0 "ipv6 route garbage collection"
+
+	sysctl -wq net.ipv6.route.gc_interval=$OLD_INTERVAL
+
+	cleanup &> /dev/null
+}
+
 fib_suppress_test()
 {
 	echo
@@ -2217,6 +2263,7 @@ do
 	ipv4_mangle)			ipv4_mangle_test;;
 	ipv6_mangle)			ipv6_mangle_test;;
 	ipv4_bcast_neigh)		ipv4_bcast_neigh_test;;
+	fib6_gc_test|ipv6_gc)		fib6_gc_test;;
 
 	help) echo "Test names: $TESTS"; exit 0;;
 	esac
-- 
2.34.1


