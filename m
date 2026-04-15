Return-Path: <netdev+bounces-278860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBm2LmTe32kaZwAAu9opvQ
	(envelope-from <netdev+bounces-278860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 20:52:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2730B407358
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 20:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4DCF3030D5F
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 18:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3257F3644A3;
	Wed, 15 Apr 2026 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2aubf1o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92551277C9E
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776279136; cv=none; b=aHjznu7oQ5x/u33VUyxguUZHloVv7cZVPZYj7B1Sdc4dokiZRuVxqQaXcPHoP6rOerbXKK/1YTErfgmso/nWB/hMzT1iilVQMI8gRAa1XBiCgk/xOdpNGI/kJWszi6AZPKZ6bX7VfXKUBIdRWyZBpRn7hOtEqczLnWfJ8hAe8AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776279136; c=relaxed/simple;
	bh=2NBoU68MoEb6tabflloQxM4Y0+PZOEURSqv8hhh6XWk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=etgLQJa/qKUHOIBGvaN//GmQvtoUYZEhTfUehUWoR4XSg6wmNOhhZ3RSuKUdEZIPWnDzfNulPrJq6BsVWJlV+N7YaRrRoQgVvWeVZVLmS25gfMKFgXEDPfsAq88ForajqEm7/vO236zUJCi22aVjXSn0GWi0DuisrykycQ+5FNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2aubf1o; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso70511825e9.1
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 11:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776279133; x=1776883933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eQhlpKS2BSyq0738gAtdb37OSAxAE8MeKj2xvPQlbfc=;
        b=c2aubf1olYkpFt8BbV1z01QoXGxHOWlZ8+jLzjkCi2Xj9m+whUbgf0NLUJsyHc09b0
         WBnPdAYJdLpGoVJSYeUY98Ig0LwuZtVSwhw4GiJILSbtoJTcAF2dOck1Ye6HQ2+p3d+E
         I2XInjz+u/rJDiEvQmd5rtKUcxDiA7mEzlvIpzELjjLmpJHsiPbWPXZsgExQoY6rj2GB
         cvFACXDFp9rOOaH2JOgp6eWfitkwjnCJ1OIhHt+4+U7viwbRollVAGMfPXkWqorAUy4x
         A+9FI67xSMzCoRw0bv0vUXuZFWLmzjxJzKTxWU6cg0tv2GfqGNpF1pd1Z6Iw/WT+EzZB
         aUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776279133; x=1776883933;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQhlpKS2BSyq0738gAtdb37OSAxAE8MeKj2xvPQlbfc=;
        b=TKoPju0mG8NWNYZV4oD8KiLZgZOf4+sXAnJm2aA/oVNFnf9L2XxNDVSh5vmI57sTw/
         wAJt3pjT/S17CERSjJIfp7Wm6LFIbX1BW0NkgjLMXgv1kPyuLRgwEV+SCvs+U8tdU1QE
         A3t0ARv9bZiWa4fUKdxWkG4WJnckTfCSGoTA3snl4bv6505uJKNBKwRu30g9aZgTRCO8
         v578e147cbQ9kMdAVTC5cquJEhYE98kEtrbGufCnrSewffG0a1V97p7LreP+CTM0KdxT
         htncpDlo3aFHKPPf9+JqmAqqryDVdSycn7azewumvXHeN1ZV5ESFrI1Dmd3vfA2ahm9H
         zEnQ==
X-Gm-Message-State: AOJu0YyTuhZsZV4r8Xcf4Rk6qoRvY1wDt6DOWMh3kfVgEsj0dsoB96DU
	jMG78ifAVibFBmbSzymtRMC0r7ykuDPualYJgYXKyZrvnhc7tPguLUMMH1E6gu+c
X-Gm-Gg: AeBDiesc3Vz1uk4GlqQEu2SRjhVesRTSuwwR0D5WFrfxuwlZ7GoJVkN3222mFpmEgfh
	cdzqcmleZAYO+K/ILInJRwriM398627W+lcwAT/9rn6X2WMOJHTd09/FfEzx3C1M3jVP3uTkgO3
	I1YXkt8CQLoMnBrYOGTBdEw/6DaZTVIJDn/p5XyhKPxmnZDx/haJx7/N7y1m52WxJe4JJUr/waX
	L+Sk8hfSgz/1RarN7j1Ytof/qsDTQe1VB+GLWJwoUNI6wMZ7TXiCO6Ya0T5AY519ZvFMXwP9Fhg
	rCkjTu8UoOlLKZVFteLJwomzTnYUkV9oggI618vPH//Tg9WeI2dP9Z2cPwZWtghufp3Eh75FLJI
	+P66kJKPqC2U6QVcZjoMKCWeFikvD+MTSlErj2Kz4aJGNKmT0GG79zrVcZJLXVCHO2EJbhDT4sd
	ERmVp0mcLg2k6L1cBXshWQ3Za4x1U26RiQWMT1j5TrCGL9txCHWUMKf5aJ03mD6zH2qiCS48xAZ
	R0=
X-Received: by 2002:a05:600c:8b27:b0:486:f634:ef1 with SMTP id 5b1f17b1804b1-488d687664emr298405715e9.17.1776279132500;
        Wed, 15 Apr 2026 11:52:12 -0700 (PDT)
Received: from dau-home-pc ([89.222.123.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5f11sm7760661f8f.18.2026.04.15.11.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:52:11 -0700 (PDT)
Date: Wed, 15 Apr 2026 21:52:08 +0300
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH net-next v2 2/2] selftests: net: add FOU multicast
 encapsulation resubmit test
Message-ID: <ad_eWBo76OLcgPSA@dau-home-pc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad_dal164gVmImWl@dau-home-pc>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-278860-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fou_mcast_encap.py:url]
X-Rspamd-Queue-Id: 2730B407358
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a selftest to verify that FOU-encapsulated packets addressed to a
multicast destination are correctly resubmitted to the inner protocol
handler (GRE) via the UDP multicast delivery path.

The test creates two network namespaces connected by a veth pair. The
receiver namespace has a FOU/GRETAP tunnel with a multicast remote
address (239.0.0.1). A Python helper script (fou_mcast_encap.py)
crafts GRE-over-UDP packets and sends them to the multicast address.

The early demux optimization (net.ipv4.ip_early_demux) is disabled on
the receiver to force packets through __udp4_lib_mcast_deliver(),
which is the code path that was previously broken.

Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
Assisted-by: Claude:claude-opus-4-6
---
 tools/testing/selftests/net/Makefile          |   2 +
 .../testing/selftests/net/fou_mcast_encap.py  |  81 ++++++++++++++
 .../testing/selftests/net/fou_mcast_encap.sh  | 105 ++++++++++++++++++
 3 files changed, 188 insertions(+)
 create mode 100755 tools/testing/selftests/net/fou_mcast_encap.py
 create mode 100755 tools/testing/selftests/net/fou_mcast_encap.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index a275ed584026..2b463dda5ac6 100644
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
@@ -195,6 +196,7 @@ TEST_GEN_PROGS := \
 
 TEST_FILES := \
 	fcnal-test.sh \
+	fou_mcast_encap.py \
 	in_netns.sh \
 	lib.sh \
 	settings \
diff --git a/tools/testing/selftests/net/fou_mcast_encap.py b/tools/testing/selftests/net/fou_mcast_encap.py
new file mode 100755
index 000000000000..0fd836c454a8
--- /dev/null
+++ b/tools/testing/selftests/net/fou_mcast_encap.py
@@ -0,0 +1,81 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""Send FOU/GRE encapsulated packets to a multicast destination.
+
+Build and send GRE-over-UDP (FOU) packets with a multicast outer
+destination IP. Used by fou_mcast_encap.sh to test that the UDP
+multicast delivery path correctly resubmits encapsulated packets
+to the inner protocol handler.
+"""
+
+import argparse
+import socket
+import struct
+
+
+def checksum(data):
+    """Compute Internet checksum (RFC 1071)."""
+    csum = 0
+    for i in range(0, len(data) - 1, 2):
+        csum += (data[i] << 8) + data[i + 1]
+    if len(data) % 2:
+        csum += data[-1] << 8
+    while csum >> 16:
+        csum = (csum & 0xFFFF) + (csum >> 16)
+    return ~csum & 0xFFFF
+
+
+def build_gre_encap_packet(dst_addr):
+    """Build a GRE/Ethernet/IP/ICMP payload for FOU encapsulation."""
+    gre_key = socket.inet_aton(dst_addr)
+    gre_hdr = struct.pack("!HH", 0x2000, 0x6558) + gre_key
+
+    dst_mac = b"\xff\xff\xff\xff\xff\xff"
+    src_mac = b"\x02\x00\x00\x00\x00\x01"
+    eth_hdr = dst_mac + src_mac + struct.pack("!H", 0x0800)
+
+    inner_ip_src = socket.inet_aton("192.168.99.1")
+    inner_ip_dst = socket.inet_aton("192.168.99.2")
+
+    icmp_payload = b"TESTFOU!" * 4
+    icmp_hdr = struct.pack("!BBHHH", 8, 0, 0, 0x1234, 1) + icmp_payload
+    icmp_csum = checksum(icmp_hdr)
+    icmp_hdr = struct.pack("!BBHHH", 8, 0, icmp_csum, 0x1234, 1) + icmp_payload
+
+    ip_len = 20 + len(icmp_hdr)
+    ip_hdr = struct.pack("!BBHHHBBH", 0x45, 0, ip_len, 0x1234, 0, 64, 1, 0)
+    ip_hdr += inner_ip_src + inner_ip_dst
+    ip_csum = checksum(ip_hdr)
+    ip_hdr = ip_hdr[:10] + struct.pack("!H", ip_csum) + ip_hdr[12:]
+
+    return gre_hdr + eth_hdr + ip_hdr + icmp_hdr
+
+
+def main():
+    parser = argparse.ArgumentParser(
+        description="Send FOU/GRE encapsulated packets to a multicast address"
+    )
+    parser.add_argument(
+        "-c", "--count", type=int, required=True,
+        help="number of packets to send",
+    )
+    parser.add_argument(
+        "-d", "--dst", default="239.0.0.1",
+        help="destination multicast address (default: 239.0.0.1)",
+    )
+    parser.add_argument(
+        "-p", "--port", type=int, default=4797,
+        help="destination UDP port (default: 4797)",
+    )
+    args = parser.parse_args()
+
+    payload = build_gre_encap_packet(args.dst)
+
+    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
+    for _ in range(args.count):
+        sock.sendto(payload, (args.dst, args.port))
+    sock.close()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/net/fou_mcast_encap.sh b/tools/testing/selftests/net/fou_mcast_encap.sh
new file mode 100755
index 000000000000..1f9dbe7092f3
--- /dev/null
+++ b/tools/testing/selftests/net/fou_mcast_encap.sh
@@ -0,0 +1,105 @@
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
+	local script_dir
+	script_dir=$(dirname "$(readlink -f "$0")")
+
+	ip netns exec "$NSENDER" python3 "$script_dir/fou_mcast_encap.py" \
+		-c "$count" -d 239.0.0.1 -p 4797
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


