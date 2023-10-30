Return-Path: <netdev+bounces-45288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C787DBF33
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 18:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229682816D1
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 17:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68E0199B5;
	Mon, 30 Oct 2023 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apDiZUTE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C3A199AC
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 17:40:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7177E8
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 10:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698687642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=I2JHh73zIxCYXhkBKGYhrEXftWXIPybkxG0xOR3on7I=;
	b=apDiZUTE+VOGH0AHqRqnMeWn2XnU4DrV4OAzrWoxaKWzGpL9Qgs6ciaF/jTSnRAofes2og
	FMD+xEFBAesacqxHa63MmlDjlcmJZSOf3MoypuIhKhEdCV++HPNxfxHHqXOneI/N69fWYS
	HH7JZnU674qxyfar4nB9TiOFB+6xVoQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-MPTuxcquNeeiGB_8uXHVng-1; Mon, 30 Oct 2023 13:40:41 -0400
X-MC-Unique: MPTuxcquNeeiGB_8uXHVng-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-778ac2308e6so599629985a.3
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 10:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698687641; x=1699292441;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I2JHh73zIxCYXhkBKGYhrEXftWXIPybkxG0xOR3on7I=;
        b=Um5SSBtl+7vymxzEtMhHDZg90tK+POPUD7M/jRvoxinGAVZE8PWAEB3SBbTd/qp8u2
         LdMcDZwscwmxD9OMD/4b1hrUkpt03CG8W9cEoOk0rPKyJSOt3gr59HV5XFALd/3UCku+
         wxGhhq5bAVM8FWWNk4h5GdGMYyxUsz27qmLbmoCgko1/4FpkgVWHqw5yp3sUijmYpcV8
         EAMu0/OX1rhU07yrjfWe0aM6aA7HRVOrd0xHDwdp8ogYr3ytrxwjvWtbG+BMWTHkr7ih
         KHvLnXBLgvb76iNgNaHq+pi4sxSbrKrwd70xgvbpX5kxgFe9WKlAUMrNc1VEsgUdLw+Q
         KYdw==
X-Gm-Message-State: AOJu0Yz9Jr7C2wrOYhBKojCuibsYUPImyq2t7tPIhpiGOTobRDCbuPyA
	1lymBjgW63rFPm7W9Go8HyCj7VIfcA3V6fsZKXvl4rt9B6R/mrT78FMQZEAJkZuFJawRfnO7LLP
	BIJNFkXESs9JaXGap
X-Received: by 2002:a05:620a:2589:b0:778:94cc:723 with SMTP id x9-20020a05620a258900b0077894cc0723mr12430096qko.1.1698687641238;
        Mon, 30 Oct 2023 10:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoqut/KAS12Hj1elfEzt5W6duWsTX0hSRvTSrWXOatBJSSICCKoO+CiCrF5FveWevaaikHtA==
X-Received: by 2002:a05:620a:2589:b0:778:94cc:723 with SMTP id x9-20020a05620a258900b0077894cc0723mr12430079qko.1.1698687640998;
        Mon, 30 Oct 2023 10:40:40 -0700 (PDT)
Received: from fedora ([142.181.225.135])
        by smtp.gmail.com with ESMTPSA id w7-20020a05620a094700b007742c6823a3sm3501927qkw.108.2023.10.30.10.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 10:40:40 -0700 (PDT)
Date: Mon, 30 Oct 2023 13:40:39 -0400
From: Lucas Karpinski <lkarpins@redhat.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, shuah@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/net: synchronize udpgso_bench rx and tx
Message-ID: <6ceki76bcv7qz6de5rxc26ot6aezdmeoz2g4ubtve7qwozmyyw@zibbg64wsdjp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20231006

The sockets used by udpgso_bench_tx aren't always ready when
udpgso_bench_tx transmits packets. This issue is more prevalent in -rt
kernels, but can occur in both. Replace the hacky sleep calls with a
function that checks whether the ports in the namespace are ready for
use.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
---
https://lore.kernel.org/all/t7v6mmuobrbucyfpwqbcujtvpa3wxnsrc36cz5rr6kzzrzkwtj@toz6mr4ggnyp/

Changelog v2: 
- applied synchronization method suggested by Pablo
- changed commit message to code 

 tools/testing/selftests/net/udpgro.sh         | 27 ++++++++++++++-----
 tools/testing/selftests/net/udpgro_bench.sh   | 19 +++++++++++--
 tools/testing/selftests/net/udpgro_frglist.sh | 19 +++++++++++--
 3 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selftests/net/udpgro.sh
index 0c743752669a..04792a315729 100755
--- a/tools/testing/selftests/net/udpgro.sh
+++ b/tools/testing/selftests/net/udpgro.sh
@@ -24,6 +24,22 @@ cleanup() {
 }
 trap cleanup EXIT
 
+wait_local_port_listen()
+{
+	local port="${1}"
+
+	local port_hex
+	port_hex="$(printf "%04X" "${port}")"
+
+	local i
+	for i in $(seq 10); do
+		ip netns exec "${PEER_NS}" cat /proc/net/udp* | \
+			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/) {rc=0; exit}} END {exit rc}" &&
+			break
+		sleep 0.1
+	done
+}
+
 cfg_veth() {
 	ip netns add "${PEER_NS}"
 	ip -netns "${PEER_NS}" link set lo up
@@ -51,8 +67,7 @@ run_one() {
 		echo "ok" || \
 		echo "failed" &
 
-	# Hack: let bg programs complete the startup
-	sleep 0.2
+	wait_local_port_listen 8000
 	./udpgso_bench_tx ${tx_args}
 	ret=$?
 	wait $(jobs -p)
@@ -97,7 +112,7 @@ run_one_nat() {
 		echo "ok" || \
 		echo "failed"&
 
-	sleep 0.1
+	wait_local_port_listen 8000
 	./udpgso_bench_tx ${tx_args}
 	ret=$?
 	kill -INT $pid
@@ -118,11 +133,9 @@ run_one_2sock() {
 		echo "ok" || \
 		echo "failed" &
 
-	# Hack: let bg programs complete the startup
-	sleep 0.2
+	wait_local_port_listen 12345
 	./udpgso_bench_tx ${tx_args} -p 12345
-	sleep 0.1
-	# first UDP GSO socket should be closed at this point
+	wait_local_port_listen 8000
 	./udpgso_bench_tx ${tx_args}
 	ret=$?
 	wait $(jobs -p)
diff --git a/tools/testing/selftests/net/udpgro_bench.sh b/tools/testing/selftests/net/udpgro_bench.sh
index 894972877e8b..91833518e80b 100755
--- a/tools/testing/selftests/net/udpgro_bench.sh
+++ b/tools/testing/selftests/net/udpgro_bench.sh
@@ -16,6 +16,22 @@ cleanup() {
 }
 trap cleanup EXIT
 
+wait_local_port_listen()
+{
+	local port="${1}"
+
+	local port_hex
+	port_hex="$(printf "%04X" "${port}")"
+
+	local i
+	for i in $(seq 10); do
+		ip netns exec "${PEER_NS}" cat /proc/net/udp* | \
+			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/) {rc=0; exit}} END {exit rc}" &&
+			break
+		sleep 0.1
+	done
+}
+
 run_one() {
 	# use 'rx' as separator between sender args and receiver args
 	local -r all="$@"
@@ -40,8 +56,7 @@ run_one() {
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx ${rx_args} -r &
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -t ${rx_args} -r &
 
-	# Hack: let bg programs complete the startup
-	sleep 0.2
+	wait_local_port_listen 8000
 	./udpgso_bench_tx ${tx_args}
 }
 
diff --git a/tools/testing/selftests/net/udpgro_frglist.sh b/tools/testing/selftests/net/udpgro_frglist.sh
index 0a6359bed0b9..0aa2068f122c 100755
--- a/tools/testing/selftests/net/udpgro_frglist.sh
+++ b/tools/testing/selftests/net/udpgro_frglist.sh
@@ -16,6 +16,22 @@ cleanup() {
 }
 trap cleanup EXIT
 
+wait_local_port_listen()
+{
+	local port="${1}"
+
+	local port_hex
+	port_hex="$(printf "%04X" "${port}")"
+
+	local i
+	for i in $(seq 10); do
+		ip netns exec "${PEER_NS}" cat /proc/net/udp* | \
+			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/) {rc=0; exit}} END {exit rc}" &&
+			break
+		sleep 0.1
+	done
+}
+
 run_one() {
 	# use 'rx' as separator between sender args and receiver args
 	local -r all="$@"
@@ -45,8 +61,7 @@ run_one() {
         echo ${rx_args}
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx ${rx_args} -r &
 
-	# Hack: let bg programs complete the startup
-	sleep 0.2
+	wait_local_port_listen 8000
 	./udpgso_bench_tx ${tx_args}
 }
 
-- 
2.41.0


