Return-Path: <netdev+bounces-300897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lT20EPo1OGpDZwcAu9opvQ
	(envelope-from <netdev+bounces-300897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 21:05:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8426AB7AA
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 21:05:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TDrk2GSc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300897-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300897-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E113A300A119
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 19:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CB6274B2A;
	Sun, 21 Jun 2026 19:04:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FA81F151C
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 19:04:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782068699; cv=none; b=NHdNskAVUmn/bE5EQEIszxbKJuqDIrK++HRKOB/OB+zs+hxRn3giXbYl/wKTzRLe9fh8/7AGajCBg4tB6ShOCCTtRl/UY7nphj2C/0ntFuVY/PLPwYAW/CTjRUDmZeB2NMsXl4YsUGYiAZJOyLXe6hWqsiwgNOvvR0hPnIG/iwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782068699; c=relaxed/simple;
	bh=aXRM6rleMtmqAGpHOgyjB5R1SPGt0HQzOmTZSePQYyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V71L7BR6ifXAA6m+GUu0ApQ5dLdAF6UHAqwyO1Qk+rMP+Y4wv/gkfMTYZ/Gtc4D9Bxih+L2Jq+n+/qLXp3hY8yk9idpW//fJPXmvaQGZWDLks1fs5539dsye5MdMSpb7s06lrvBpQC8cp5lyXl2ub64rCYbVWmOFuEdQhFSPgBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDrk2GSc; arc=none smtp.client-ip=209.85.208.41
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-697ad7f663cso363151a12.1
        for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 12:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782068695; x=1782673495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Vd217j9BX8Lq/p1KnSze+ojMBVOwOcfGoPl0hFkSxs=;
        b=TDrk2GScixZ8fmReWUDeY/s7vMVWHhN81yKK5WccjYZ2HkMCxqJAcJeXxa9AgulqYh
         0K5pdzMEVcU/54rnDQtBtGZJMslqsjCcazs/IvqhdKV9tAesj9vt9UKgiQ27v3bsRCvK
         zTg3PjJ3qQtR9dUVZTYRkNAIH5jO34UvO32xXtA+r9i+k7TsQTpbheqUQ/y0WJbSyufi
         +wN9KV6DeroDvcdhU5DRg6B7Ya0xUiuYDN0Te+qLNXcriDzwa6sNFtURHYolc7pU50e6
         aAkuXdOrTwUzo7bfcwgRCt/NCsS4t1qrdHWFm+euzJqcRSdekFKoS0eJ9nzhhY9oTWgf
         N99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782068695; x=1782673495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Vd217j9BX8Lq/p1KnSze+ojMBVOwOcfGoPl0hFkSxs=;
        b=GRWuTDAIGUR6i85P2c9Fyu16h0IWLCjl54VuxBj5NZk4KAf3ZqTTN4i0Za4wPBMeNI
         Lhv5TbTOprE2XbhzmQrhBNE9lC/wExkWQWGjQBZ9HZaSauzZRe+MskRO4FzgrYj/LiEo
         zsf5xsiutuX7SEes+FGLdaiyhdvpmQ0GqSDuAIBR5D8WmXhwE8ZvL/vAo/bcNS6LGP64
         9EEc8ASqidQvB1HNgP4zzZLjACkoQ2FAPDgCHoqnOw/q3wB5ijB9iiw6UPOW/h9ViO79
         9VH+rienWeMpdB531Szo9tdPhxLWiHiPWHrMRWA3dhygsysVaC8+tQrNwBD0lQvOVGDB
         gLrA==
X-Gm-Message-State: AOJu0YzjEjXhJkcHP32YAiN4eoLxdpCduoZH3xZ9gOBnlkMf1/4EIXt5
	waijuw1oDF1Ds5Mi77UG/g9tEQMcZNSSbPJzg+LCzvBMkrJVi+dSOOK8/kNPLKvF
X-Gm-Gg: AfdE7cnA4otfMVfSnRcPDh/mUEI1s76PnezXTDAxDZqnjJ07YnM/oVoRooisR4nytdz
	h0gvxCkxzirQ3E4qIGm1npwV11P09/hH0cJ2cyl8FQYoTUen496X1p0U80lVH9dIYT3ayQYLUcV
	BNkIj8zqMrSHn5tjt8VGAfnF7cCEJPaXZPWWTQf+xsPM+giAKsY2UWf39EV12fAI71QQXzV/lgy
	4gDVqSLKmNYUvkWV6M8hcdOEvoaHtY+jB5HiRlB+ue2U1vZxJMbNJfxDgQqRNoLIgC2Vuyfla47
	goGOPfn+giDHRnfa5KkY2i2RnefbbeMDhK3sNzoexNwdBNvIuE+uEKaKgqZFMOvE3eSLxtDvYQ8
	DCBaYJG0Yy9PofGtnn/cYvA06dBIQWHzDA5elFZ1sjV0xKfpsusjdgyEBSogf0MLhrhC4Z1snSb
	9zpSqLukgWuZTSzLidYSdswPMfJFvGte+ZZrxl/jE1rWmkBmVzv+klxbQfjVEaUcM5lzyo32O2o
	dfMgw==
X-Received: by 2002:a17:906:7944:b0:c0e:5a63:85df with SMTP id a640c23a62f3a-c0e5a642b5emr88280366b.30.1782068694741;
        Sun, 21 Jun 2026 12:04:54 -0700 (PDT)
Received: from dau-home-pc.megasoftware.org ([95.164.115.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e99977fsm230558266b.20.2026.06.21.12.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 12:04:53 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	davem@davemloft.net,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next RESEND v3 2/2] selftests: net: add FOU multicast encapsulation resubmit test
Date: Sun, 21 Jun 2026 22:04:12 +0300
Message-ID: <d453a15be455920b57b0da000a91ace4d01a0596.1782067871.git.littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1782067871.git.littlesmilingcloud@gmail.com>
References: <cover.1782067871.git.littlesmilingcloud@gmail.com> <cover.1777934869.git.littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300897-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:willemb@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuniyu@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[littlesmilingcloud@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[littlesmilingcloud@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fou_mcast_encap.sh:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B8426AB7AA

Add a selftest to verify that FOU-encapsulated packets addressed to a
multicast destination are correctly resubmitted to the inner protocol
handler (GRE) via the UDP multicast delivery path.

The test creates two network namespaces connected by a veth pair with
a FOU/GRETAP tunnel using a multicast remote address (239.0.0.1).
Ping is sent through the tunnel and received packets are counted on
the receiver's tunnel interface.

A static neighbor entry is configured on the sender because ARP
replies from the receiver cannot traverse the unidirectional multicast
tunnel back to the sender.

The early demux optimization (net.ipv4.ip_early_demux) is disabled on
the receiver to force packets through __udp4_lib_mcast_deliver(),
which is the code path being tested.

Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
Assisted-by: Claude:claude-opus-4-6
---
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/fou_mcast_encap.sh  | 112 ++++++++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100755 tools/testing/selftests/net/fou_mcast_encap.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 708d960ae07d..7e9ae937cffa 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -39,6 +39,7 @@ TEST_PROGS := \
 	fib_rule_tests.sh \
 	fib_tests.sh \
 	fin_ack_lat.sh \
+	fou_mcast_encap.sh \
 	fq_band_pktlimit.sh \
 	gre_gso.sh \
 	gre_ipv6_lladdr.sh \
diff --git a/tools/testing/selftests/net/fou_mcast_encap.sh b/tools/testing/selftests/net/fou_mcast_encap.sh
new file mode 100755
index 000000000000..8db9633f4c28
--- /dev/null
+++ b/tools/testing/selftests/net/fou_mcast_encap.sh
@@ -0,0 +1,112 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test that UDP encapsulation (FOU) correctly handles packet resubmit
+# when packets are delivered via the multicast UDP delivery path.
+#
+# When a FOU-encapsulated packet arrives with a multicast destination IP,
+# __udp4_lib_mcast_deliver() must resubmit it to the inner protocol
+# handler (e.g., GRE) rather than consuming it. This test verifies that
+# by creating a FOU/GRETAP tunnel with a multicast remote address and
+# sending ping through it.
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
+	# Sender: GRETAP with FOU encap (no FOU listener needed on TX side)
+	ip -n "$NSENDER" link add eoudp0 type gretap \
+		remote 239.0.0.1 local 10.0.0.1 \
+		encap fou encap-sport 4797 encap-dport 4797 \
+		key 239.0.0.1
+	ip -n "$NSENDER" link set eoudp0 up
+	ip -n "$NSENDER" addr add 192.168.99.1/24 dev eoudp0
+
+	# Receiver: FOU listener + GRETAP
+	ip netns exec "$NRECV" ip fou add port 4797 ipproto 47
+	ip -n "$NRECV" link add eoudp0 type gretap \
+		remote 239.0.0.1 local 10.0.0.2 \
+		encap fou encap-sport 4797 encap-dport 4797 \
+		key 239.0.0.1
+	ip -n "$NRECV" link set eoudp0 up
+	ip -n "$NRECV" addr add 192.168.99.2/24 dev eoudp0
+
+	# Static neigh entry on sender: ARP replies cannot traverse the
+	# multicast tunnel back, so pre-populate the neighbor cache.
+	local recv_mac
+	recv_mac=$(ip -n "$NRECV" link show eoudp0 | awk '/ether/{print $2}')
+	ip -n "$NSENDER" neigh add 192.168.99.2 lladdr "$recv_mac" dev eoudp0
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
+	# Warmup: let any initial broadcast/ARP traffic settle
+	ip netns exec "$NSENDER" ping -c 1 -W 1 192.168.99.2 >/dev/null 2>&1
+	sleep 1
+
+	rx_before=$(get_rx_packets)
+	ip netns exec "$NSENDER" ping -c $count -W 1 192.168.99.2 >/dev/null 2>&1
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


