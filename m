Return-Path: <netdev+bounces-278592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2D+YGJHN3mkfIgAAu9opvQ
	(envelope-from <netdev+bounces-278592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 01:28:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B833FF096
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 01:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3673A3021A3B
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 23:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BA23BA248;
	Tue, 14 Apr 2026 23:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHmF2XgP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EF229E0E5
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 23:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776209293; cv=none; b=B7UAZ78iHKbyaZf+LAP83KcbetE/MBs/Kzh7qkQnF1GWinftacxgzZ5V8M7gasjrFcE0YA2WqFc3SEx5DI8ZrkB4rNRUPNCa7jKYCcy4u3NYihP8BjKgED06T2CDp7N+zig5qxvOAhiaNA0ZnrAQIfEB7Sp77z3zj1CPB3uy/q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776209293; c=relaxed/simple;
	bh=aYZRULxq+UDwCoSqziMpUqb5zkeflt/jUR+e0NsdbyA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=d2RdEelegK3EQQxdNVgOMsyqbo0ggk1a6EGLLPOWaj9P86rk5FPDCCNAK4tf13TrMIKg9BLCOD9lDW+K6BkTIXppHwdqnC6vPxjji9nk3BezAY+RSybLUeULJ4gTNXmUpo+s/D9G4/w0rUem88KRzaim5QiVlrt/hbYWM8P9jXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHmF2XgP; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9c6f1d1282so818933166b.3
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 16:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776209290; x=1776814090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2bHO+ZzL+lDSeWw1GERdEfrkm+6Yh9DAr7U7HlZQAIg=;
        b=lHmF2XgPVSqrpM/pRDdNERm1y5UBIXT+fGHRibi+dvXJ4ZPLOkUW/+GcywZOkXUDlk
         gIJRqUewG7magNtCDMajf9kubS2IDwDn29FO49y/Cpw/3cqty3uM4LpoWuUF0SelwLFQ
         dYLAGedJ8D6Z76UO3vpd6WbxHPNZInZF7HgcLsy68AEioqMwAhuy6OAhYVob5i6Vl4U1
         ZupVcOKAPBYodCwdhqfUMXQnXKqz9YwuvTtmp0mygH/eL77O5nuU/MqrgC1oCD3gA/yO
         9pkB7+dep6d4Ab/iGv/voUhNm02yVBTCUgRdzcDNQk5u1+LVhWZG3O9xW9H9QKn9mUZ0
         SRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776209290; x=1776814090;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bHO+ZzL+lDSeWw1GERdEfrkm+6Yh9DAr7U7HlZQAIg=;
        b=a6lgcRe+KJZ1xi4fksQe90/14xcepvN9CtoKXKgAfnOTBLeeMVMmVeRh3FAehwQUCt
         QOOy+67S2A7ifPxELhqiGAStmt2VfH0w8OJxzn/xAsOSHRuUD6/IH8uUCWSANnteN1XN
         aUDOVSTmAop7jH+wrj0ub8mhljZ5VrreTY6MqCMX4sXGFj3Ewm0+3HX3gOcHaJGYs4Uo
         fv/s6W+JvVfu525S588WV0/n5yc2xdi1nyRA0jkxtC8FG16Ifl6jJ0v8PtgBbCbR81rI
         lQB4qIJ1ldFTuAlCY9nNQzL68BrJ5v0kAv/JCe7dxHuPDpRmUqGdjwUxLxRSWXtUn2CA
         x0Jw==
X-Gm-Message-State: AOJu0YxJfktCdp8HfKcYee87yncdbfV0M5jmou3LsU70YXKUjYI7UehC
	5TIeFE+HvAeyZDnvkRIxdVUvAdLGnDHYKHL74pDYVannELom3baYBLjKof9xlL0x
X-Gm-Gg: AeBDievYPOgYN33p3ZwO7oyF84KGfewonZSOAA41Ij8OE3lbGbf8y7ocuaKafUjsq9U
	i7LIpWUOj/84oQLMCbqEF/Pmw7yKb36jNTS/rj2SdEIS4aMDVnjebkTpu0rfqqpbnGrIKt57wZn
	l5IB8RVqZ0AhrLK+He0vg844Kru/jh+pUOmKHXPVQHnVOGmKfjB6lCH6pYmTSjiW8OPR35toQ7L
	5Xq5JKvmqbRMu/1aS+Wf0sXUnar+Uav2zar8JavSRYg5UZ0ks14650qEVpV673E+SsKOsrc+pU0
	mxsECniEZBLRKKwaeyPY0+ePtgRbZBnSAJIyb/kJnqFMavbDJI2onU0VF49miE5YF4+r4FvRWDL
	yPZlOkd+9TsxW977Swusjz/4453aCcY4g5RoBWjvLY258dVfz2bPKFxeTT3QVw+ihQOvybQmxQD
	+eCbw2n349vheajidF/uGN/8L6vfFXhln9I8mk6n+ek6NywKJiFrbPDAeJMl/mgQ2vvu20oAGsj
	Avb
X-Received: by 2002:a17:907:c78e:b0:b9c:4096:7893 with SMTP id a640c23a62f3a-b9d727a0d21mr1138652266b.14.1776209289945;
        Tue, 14 Apr 2026 16:28:09 -0700 (PDT)
Received: from dau-home-pc ([185.229.191.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e5c5b98sm451243466b.34.2026.04.14.16.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 16:28:08 -0700 (PDT)
Date: Wed, 15 Apr 2026 02:28:06 +0300
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH net-next 2/2] selftests: net: add FOU multicast
 encapsulation resubmit test
Message-ID: <ad7NhoxmrFJAsXe7@dau-home-pc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad7MsSJOuUU6EGwS@dau-home-pc>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-278592-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[littlesmilingcloud@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04B833FF096
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a selftest to verify that FOU-encapsulated packets addressed to a
multicast destination are correctly resubmitted to the inner protocol
handler (GRE) via the UDP multicast delivery path.

The test creates two network namespaces connected by a veth pair. The
receiver namespace has a FOU/GRETAP tunnel with a multicast remote
address (239.0.0.1). The sender crafts GRE-over-UDP packets and sends
them to the multicast address.

The early demux optimization (net.ipv4.ip_early_demux) is disabled on
the receiver to force packets through __udp4_lib_mcast_deliver(),
which is the code path that was previously broken.

Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
Assisted-by: Claude:claude-opus-4-6
---
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/fou_mcast_encap.sh  | 150 ++++++++++++++++++
 2 files changed, 151 insertions(+)
 create mode 100755 tools/testing/selftests/net/fou_mcast_encap.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index a275ed584026..9b2a573e4af2 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -38,6 +38,7 @@ TEST_PROGS := \
 	fib_rule_tests.sh \
 	fib_tests.sh \
 	fin_ack_lat.sh \
+	fou_mcast_encap.sh \
 	fq_band_pktlimit.sh \
 	gre_gso.sh \
 	gre_ipv6_lladdr.sh \
diff --git a/tools/testing/selftests/net/fou_mcast_encap.sh b/tools/testing/selftests/net/fou_mcast_encap.sh
new file mode 100755
index 000000000000..d4737d674862
--- /dev/null
+++ b/tools/testing/selftests/net/fou_mcast_encap.sh
@@ -0,0 +1,150 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test that UDP encapsulation (FOU) correctly handles packet resubmit
+# when packets are delivered via the multicast UDP delivery path.
+#
+# When a FOU-encapsulated packet arrives with a multicast destination IP,
+# __udp4_lib_mcast_deliver() must resubmit it to the inner protocol
+# handler (e.g., GRE) rather than consuming it. This test verifies that
+# by creating a FOU/GRETAP tunnel with a multicast remote address, sending
+# encapsulated packets, and checking that they are correctly decapsulated.
+#
+# The early demux optimization can mask this issue by routing packets via
+# the unicast path (udp_unicast_rcv_skb), so we disable it to force
+# packets through __udp4_lib_mcast_deliver().
+
+source lib.sh
+
+NSENDER=""
+NRECV=""
+
+cleanup() {
+	cleanup_all_ns
+}
+
+trap cleanup EXIT
+
+setup() {
+	setup_ns NSENDER NRECV
+
+	ip link add veth_s type veth peer name veth_r
+	ip link set veth_s netns "$NSENDER"
+	ip link set veth_r netns "$NRECV"
+
+	ip -n "$NSENDER" addr add 10.0.0.1/24 dev veth_s
+	ip -n "$NSENDER" link set veth_s up
+
+	ip -n "$NRECV" addr add 10.0.0.2/24 dev veth_r
+	ip -n "$NRECV" link set veth_r up
+
+	# Disable early demux to force multicast delivery path
+	ip netns exec "$NRECV" sysctl -wq net.ipv4.ip_early_demux=0
+
+	# Join multicast group on receiver
+	ip -n "$NRECV" addr add 239.0.0.1/32 dev veth_r autojoin
+
+	# Multicast routes
+	ip -n "$NRECV" route add 239.0.0.0/8 dev veth_r
+	ip -n "$NSENDER" route add 239.0.0.0/8 dev veth_s
+
+	# FOU listener
+	ip netns exec "$NRECV" ip fou add port 4797 ipproto 47
+
+	# GRETAP with multicast remote - this triggers __udp4_lib_mcast_deliver
+	ip -n "$NRECV" link add eoudp0 type gretap \
+		remote 239.0.0.1 local 10.0.0.2 \
+		encap fou encap-sport 4797 encap-dport 4797 \
+		key 239.0.0.1
+	ip -n "$NRECV" link set eoudp0 up
+	ip -n "$NRECV" addr add 192.168.99.2/24 dev eoudp0
+}
+
+send_fou_gre_packets() {
+	local count=$1
+
+	ip netns exec "$NSENDER" python3 -c "
+import socket, struct
+
+# GRE header: key flag set, proto=0x6558 (transparent ethernet bridging)
+gre_key = socket.inet_aton('239.0.0.1')
+gre_hdr = struct.pack('!HH', 0x2000, 0x6558) + gre_key
+
+# Inner Ethernet frame
+dst_mac = b'\xff\xff\xff\xff\xff\xff'
+src_mac = b'\x02\x00\x00\x00\x00\x01'
+eth_hdr = dst_mac + src_mac + struct.pack('!H', 0x0800)
+
+# Inner IP: 192.168.99.1 -> 192.168.99.2, ICMP echo
+inner_ip_src = socket.inet_aton('192.168.99.1')
+inner_ip_dst = socket.inet_aton('192.168.99.2')
+
+# ICMP echo request
+icmp_payload = b'TESTFOU!' * 4
+icmp_hdr = struct.pack('!BBHHH', 8, 0, 0, 0x1234, 1) + icmp_payload
+csum = 0
+for i in range(0, len(icmp_hdr), 2):
+    if i + 1 < len(icmp_hdr):
+        csum += (icmp_hdr[i] << 8) + icmp_hdr[i+1]
+    else:
+        csum += icmp_hdr[i] << 8
+while csum >> 16:
+    csum = (csum & 0xffff) + (csum >> 16)
+csum = ~csum & 0xffff
+icmp_hdr = struct.pack('!BBHHH', 8, 0, csum, 0x1234, 1) + icmp_payload
+
+# Inner IP header
+ip_len = 20 + len(icmp_hdr)
+ip_hdr = struct.pack('!BBHHHBBH', 0x45, 0, ip_len, 0x1234, 0, 64, 1, 0)
+ip_hdr += inner_ip_src + inner_ip_dst
+csum = 0
+for i in range(0, 20, 2):
+    csum += (ip_hdr[i] << 8) + ip_hdr[i+1]
+while csum >> 16:
+    csum = (csum & 0xffff) + (csum >> 16)
+csum = ~csum & 0xffff
+ip_hdr = ip_hdr[:10] + struct.pack('!H', csum) + ip_hdr[12:]
+
+payload = gre_hdr + eth_hdr + ip_hdr + icmp_hdr
+
+sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
+for _ in range($count):
+    sock.sendto(payload, ('239.0.0.1', 4797))
+sock.close()
+"
+}
+
+get_rx_packets() {
+	ip -n "$NRECV" -s link show eoudp0 | awk '/RX:/{getline; print $2}'
+}
+
+test_fou_mcast_encap() {
+	local count=100
+	local rx_before
+	local rx_after
+	local rx_delta
+
+	rx_before=$(get_rx_packets)
+	send_fou_gre_packets $count
+	sleep 1
+	rx_after=$(get_rx_packets)
+
+	rx_delta=$((rx_after - rx_before))
+
+	if [ "$rx_delta" -ge "$count" ]; then
+		echo "PASS: received $rx_delta/$count packets via multicast FOU/GRETAP"
+		return "$ksft_pass"
+	elif [ "$rx_delta" -gt 0 ]; then
+		echo "FAIL: only $rx_delta/$count packets received (partial delivery)"
+		return "$ksft_fail"
+	else
+		echo "FAIL: 0/$count packets received (multicast encap resubmit broken)"
+		return "$ksft_fail"
+	fi
+}
+
+echo "TEST: FOU/GRETAP multicast encapsulation resubmit"
+
+setup
+test_fou_mcast_encap
+exit $?
-- 
2.47.3


