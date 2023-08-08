Return-Path: <netdev+bounces-25493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 559D9774532
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D381C20E89
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8436313FF5;
	Tue,  8 Aug 2023 18:38:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F0214AB2
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:38:01 +0000 (UTC)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8EAF3A3E
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 11:03:32 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-586df08bba0so27646627b3.3
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 11:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691517811; x=1692122611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2EqL7a+3pT/pYF2vK7r1x0jpubF0xUW9s343oZ/t8w=;
        b=R5WIpzjt9nXJ8d2bcdblJj7WjyhNGeOOAsPd8AWGuKANynbYnF9uZuJluF7UEUQgsL
         HZNjPu/sjVLrds39+lpq5zpA5gI6oGMmprRtLrtW3/7prjAyKQ1J0/beOfZAyUlrmnbz
         x/kv71SyOEf0ryGLz5bX2bx0fMtwOw4pOSk+9q1MDuw0b4pNzhKinmXn2gOz3YpMlsad
         nIpl8WR+9yazbBiKNuJAaqpUfr/iXGRj6RPrYdSgtwhEkBPlt6g2zyTvbXB9jACnBNth
         GqjOkzZQQUGlerILBBOJpK83Yah6bkI3Q6GeI8LoSE+yW307+mXyo/hwayMn+Jtwl9MT
         lzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691517811; x=1692122611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2EqL7a+3pT/pYF2vK7r1x0jpubF0xUW9s343oZ/t8w=;
        b=e+G5vf50m8yE1i3G5eDtaF62/IXNYI/F9/HR780rzjgQY8Mizridgs9c9KAKCSsUBE
         zKKlnn10Hah2Hwg6Ci//hiwiiMfxZuLUX8Xwcsqi98LYHoSYQri2ziO6qlOXXgXeZ6ow
         06AsqM3qAuL+v5KXzWUXvh2j0JrhQ32RgD/KdYGodBFbDbN/+wtvqB9iI4NJ+Vw5jJem
         blAPNxmnV7eg4pBK1MJQDfKLzxOtMLULYq4wRoYjnp8KzFFB9COrN9uI4zLBHClaJ3s+
         +GLu8xArx8U70pv+EYb4jPi5F8CtUKJbmbtWv6SJWYfqi1YOSRJHUcriBEaE23GKMChs
         sFYw==
X-Gm-Message-State: AOJu0YzUtrhlH7uNoUqNnAX1gWkkCmg4gyu3BNagpx3bffTVyW98p7AL
	3QoSZqzkxGWTv8TmfX6q1vU=
X-Google-Smtp-Source: AGHT+IEZvBplLbmw1SLxwuCnkXSv2Ogl1GGBQbBglgMxx0DR6LW7RROurgPNifZ7tZ6Av9vAiAxs9g==
X-Received: by 2002:a0d:ddcb:0:b0:576:98e0:32a6 with SMTP id g194-20020a0dddcb000000b0057698e032a6mr496023ywe.14.1691517811594;
        Tue, 08 Aug 2023 11:03:31 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:791:e1e6:ba74:485a])
        by smtp.gmail.com with ESMTPSA id s6-20020a815e06000000b005731dbd4928sm3458358ywb.69.2023.08.08.11.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 11:03:31 -0700 (PDT)
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
Subject: [PATCH net-next v6 2/2] selftests: fib_tests: Add a test case for IPv6 garbage collection
Date: Tue,  8 Aug 2023 11:03:09 -0700
Message-Id: <20230808180309.542341-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808180309.542341-1-thinker.li@gmail.com>
References: <20230808180309.542341-1-thinker.li@gmail.com>
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


