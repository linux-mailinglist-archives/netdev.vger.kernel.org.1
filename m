Return-Path: <netdev+bounces-47750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A057E7EB325
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 16:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DACF71C208A5
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 15:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8384941227;
	Tue, 14 Nov 2023 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGgUqWil"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BE841228
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 15:11:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3282CF5
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 07:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699974696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=m/doj/T8nqtKHRc2PP5ZmgpfbSgB0XHlZpghgNdMkI4=;
	b=jGgUqWilN/mQr7s8M3WfUUH0RJdC/dokwNLDzI08MQislACLRLLmjayhT2XieZNoGxeXx0
	iWptYdamVW5GuMXWfl/4+QzwzMZIesR2FG5PkNeq9GnofgusOLqKi2K8J0E324pTI6ApLi
	Dct8zkCaAvXe7UK14v1vLTg0+JW34gU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-VwbVsHzeMduIwqGvy2DEXg-1; Tue, 14 Nov 2023 10:11:33 -0500
X-MC-Unique: VwbVsHzeMduIwqGvy2DEXg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-670991f8b5cso110272586d6.1
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 07:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699974693; x=1700579493;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/doj/T8nqtKHRc2PP5ZmgpfbSgB0XHlZpghgNdMkI4=;
        b=Zawr37agoxz/DIKaGe1V6LctSzm7HcbSOMigA/Rn0DG5LsoBF93kCleyUV8MKYc0ST
         qH94BzrmFx8os6tb/KCnd56OxS890lFgLk0DFE5gMefRh1ljLwh99KmxGi+jDGptbs1F
         e/lgOa55zeV9/l3IQP0PA3QMpdnPxImlhvE+JUfEi5U0Nnw03xTs6IlwtlE199BjGtxl
         Kpf8pSaY67cKOQXwSNPapN0THr93YRuPhncqqRvEBsIHAbsKr6NJnTpIZbWGSARZnRC+
         Ba2/gczDx8VcHufKroygTKCxAqjcWjTq0gMJdo35KpSqGq3gbuq/2PipHw6N1YOeoRgm
         miRA==
X-Gm-Message-State: AOJu0Yy6xOd89KAcf1tko/kfvUKZKeHL4//LWx6OVkVBTDqGQKYr7ozI
	4Q3LW5vSP3g6cTjIvtUyzEwttJcYd/ZwUgn/LUlsN3LB4jCFTyW5KduTr9YNnKVJ8xOJiauzbYc
	qBaIxJmO1xuGlM9Y2
X-Received: by 2002:a05:6214:a6b:b0:671:560f:3306 with SMTP id ef11-20020a0562140a6b00b00671560f3306mr4222474qvb.4.1699974693059;
        Tue, 14 Nov 2023 07:11:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETr8rC65ge7cAq25brn2IswFpgUjOqN5yHvyuJsXuhW2wFWXuNITxZngmj3KoUixz/DqtrQw==
X-Received: by 2002:a05:6214:a6b:b0:671:560f:3306 with SMTP id ef11-20020a0562140a6b00b00671560f3306mr4222433qvb.4.1699974692710;
        Tue, 14 Nov 2023 07:11:32 -0800 (PST)
Received: from fedora ([142.181.225.135])
        by smtp.gmail.com with ESMTPSA id u12-20020a0cea4c000000b00655d711180dsm2988835qvp.17.2023.11.14.07.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:11:32 -0800 (PST)
Date: Tue, 14 Nov 2023 10:11:31 -0500
From: Lucas Karpinski <lkarpins@redhat.com>
To: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3] selftests/net: synchronize udpgro tests' tx and
 rx connection
Message-ID: <jvzrm33xjrhal3qro37tfpfw2w4jbh35byjlogcc776xt4fpzy@zkmfoqn5ipil>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20231023

The sockets used by udpgso_bench_tx aren't always ready when
udpgso_bench_tx transmits packets. This issue is more prevalent in -rt
kernels, but can occur in both. Replace the hacky sleep calls with a
function that checks whether the ports in the namespace are ready for
use.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
---
https://lore.kernel.org/all/6ceki76bcv7qz6de5rxc26ot6aezdmeoz2g4ubtve7qwozmyyw@zibbg64wsdjp/
v3:
- moved redundant code to net_helper.sh
- replaced awk with grep
- changed commit message to specify udpgro
- added target tree

v2:
- applied synchronization method suggested by Paolo
- changed commit message to code

tools/testing/selftests/net/net_helper.sh     | 22 +++++++++++++++++++
 tools/testing/selftests/net/udpgro.sh         | 13 +++++------
 tools/testing/selftests/net/udpgro_bench.sh   |  5 +++--
 tools/testing/selftests/net/udpgro_frglist.sh |  5 +++--
 4 files changed, 34 insertions(+), 11 deletions(-)
 create mode 100755 tools/testing/selftests/net/net_helper.sh

diff --git a/tools/testing/selftests/net/net_helper.sh b/tools/testing/selftests/net/net_helper.sh
new file mode 100755
index 000000000000..4fe0befa13fb
--- /dev/null
+++ b/tools/testing/selftests/net/net_helper.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Helper functions
+
+wait_local_port_listen()
+{
+	local listener_ns="${1}"
+	local port="${2}"
+	local protocol="${3}"
+	local port_hex
+	local i
+
+	port_hex="$(printf "%04X" "${port}")"
+	for i in $(seq 10); do
+		if ip netns exec "${listener_ns}" cat /proc/net/"${protocol}"* | \
+		   grep -q "${port_hex}"; then
+			break
+		fi
+		sleep 0.1
+	done
+}
diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selftests/net/udpgro.sh
index 0c743752669a..af5dc57c8ce9 100755
--- a/tools/testing/selftests/net/udpgro.sh
+++ b/tools/testing/selftests/net/udpgro.sh
@@ -3,6 +3,8 @@
 #
 # Run a series of udpgro functional tests.
 
+source net_helper.sh
+
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
 BPF_FILE="../bpf/xdp_dummy.bpf.o"
@@ -51,8 +53,7 @@ run_one() {
 		echo "ok" || \
 		echo "failed" &
 
-	# Hack: let bg programs complete the startup
-	sleep 0.2
+	wait_local_port_listen ${PEER_NS} 8000 udp
 	./udpgso_bench_tx ${tx_args}
 	ret=$?
 	wait $(jobs -p)
@@ -97,7 +98,7 @@ run_one_nat() {
 		echo "ok" || \
 		echo "failed"&
 
-	sleep 0.1
+	wait_local_port_listen "${PEER_NS}" 8000 udp
 	./udpgso_bench_tx ${tx_args}
 	ret=$?
 	kill -INT $pid
@@ -118,11 +119,9 @@ run_one_2sock() {
 		echo "ok" || \
 		echo "failed" &
 
-	# Hack: let bg programs complete the startup
-	sleep 0.2
+	wait_local_port_listen "${PEER_NS}" 12345 udp
 	./udpgso_bench_tx ${tx_args} -p 12345
-	sleep 0.1
-	# first UDP GSO socket should be closed at this point
+	wait_local_port_listen "${PEER_NS}" 8000 udp
 	./udpgso_bench_tx ${tx_args}
 	ret=$?
 	wait $(jobs -p)
diff --git a/tools/testing/selftests/net/udpgro_bench.sh b/tools/testing/selftests/net/udpgro_bench.sh
index 894972877e8b..cb664679b434 100755
--- a/tools/testing/selftests/net/udpgro_bench.sh
+++ b/tools/testing/selftests/net/udpgro_bench.sh
@@ -3,6 +3,8 @@
 #
 # Run a series of udpgro benchmarks
 
+source net_helper.sh
+
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
 BPF_FILE="../bpf/xdp_dummy.bpf.o"
@@ -40,8 +42,7 @@ run_one() {
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx ${rx_args} -r &
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -t ${rx_args} -r &
 
-	# Hack: let bg programs complete the startup
-	sleep 0.2
+	wait_local_port_listen "${PEER_NS}" 8000 udp
 	./udpgso_bench_tx ${tx_args}
 }
 
diff --git a/tools/testing/selftests/net/udpgro_frglist.sh b/tools/testing/selftests/net/udpgro_frglist.sh
index 0a6359bed0b9..dd47fa96f6b3 100755
--- a/tools/testing/selftests/net/udpgro_frglist.sh
+++ b/tools/testing/selftests/net/udpgro_frglist.sh
@@ -3,6 +3,8 @@
 #
 # Run a series of udpgro benchmarks
 
+source net_helper.sh
+
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
 BPF_FILE="../bpf/xdp_dummy.bpf.o"
@@ -45,8 +47,7 @@ run_one() {
         echo ${rx_args}
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx ${rx_args} -r &
 
-	# Hack: let bg programs complete the startup
-	sleep 0.2
+	wait_local_port_listen "${PEER_NS}" 8000 udp
 	./udpgso_bench_tx ${tx_args}
 }
 
-- 
2.41.0


