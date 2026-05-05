Return-Path: <netdev+bounces-284571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EECrCT5H+mmOLwMAu9opvQ
	(envelope-from <netdev+bounces-284571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 21:38:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B502B4D32A9
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 21:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A86E3012D72
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 19:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FFD3D5648;
	Tue,  5 May 2026 19:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="e4C+ZIls"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DA63D7D9B
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778009915; cv=none; b=P9GhNmlhbPnJFay5uy+Nph+UPdVp00kV28U2F3qGRJ6ofgGOJ7JVJVVO7EMnS0j0zROj0zyeMBm47EAX3UC2KRVTKX+TMBxgE6lLJrKY/Xb9gSthgOw/KKMjDVezSG/hZA+ukpBQpDbuxIerNsA4aTaCmsens07LiQ6t9Qoze2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778009915; c=relaxed/simple;
	bh=u+jf91xuGl4ahZJBN1Gd4iBF1Bp/gns4kPS3ESE6aZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzEc/xvYrpfrKpvxTFdc8Q+DqS4TPKJEP1IyjF+hjAvVqNbusApueHHmjKULKk5cFjbfqNrCGIR1Jccwrl/NdleCPe96MZ0XBxBlA7VAIrdPOGiQhfDlo+Fjaa3uhLgXhVnKTjUOeDFYpT+O7n2lsTbsGjgrZ5zPnJ3eeki2/Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=e4C+ZIls; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645EFexA3154524
	for <netdev@vger.kernel.org>; Tue, 5 May 2026 12:38:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=s2048-2025-q2; bh=rbRx5fQ
	80ALi8KM5pb0fADbrfsoWiOx9Jy8n09ncvoU=; b=e4C+ZIlsoFe0r3T5AGW+27f
	Vl/+2aWbZjqtl7+SywzY4O9Oaw/CrVrBp2QnccZXoN6W2hEhj+c3tYjjRbMRtRw4
	w8C/YkqkSE7oe1R4n70vz52W5DS9jhpWFrHIR87uW/ZZIbhf/rwX8gfwf1OxGZxO
	hc8cyj7Fb0JR/LnulSI56SPyJe0//+AhqtXu8kW7XujL6pqZRG+TPnwwu2GnyxFn
	cZeXJ7Xo+vh9Td8AlzbaQq8ySGBGs6Ps6l4Lwfcff6OFTVNEuaTAPohCHHLZmYTP
	9as1rXJkx9X3wY1uXiE69RXjDsag+mkaoWPHw4ibDpeANCT3zoC4Z4osrfTskIQ=
	=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dwda0k91j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 05 May 2026 12:38:32 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d496d080d8so7466650a34.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 12:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778009911; x=1778614711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rbRx5fQ80ALi8KM5pb0fADbrfsoWiOx9Jy8n09ncvoU=;
        b=LgP3tyajGytGNRNF2Ob/kYjBsmdN1spebiJ5eTnYNWMSyEcKE8D0W+6GoxcLej8Fgt
         Ia4vI+C4tHcKtkL2KO7netG4wwd1lE6zTLeNzyNy1zwf01dYwB21/A1gi/C6eZMP0MMx
         d/Wupjsi2ICPiu8F2TwoyYFtqt9B/mCvBb2D3rohC8wiiFG7K5sqW258sH87Dl/6TSAM
         bONmo7SFqr27nBWPwN1X2zVDs2J0/BWc9qOhb/xZ21mSzU6EO85dDC0QiV8wGIHSjbVV
         kh/v2asV2SS77KoSA3hkF9Lio4EjIePKhPg5+oJ6hg8yYjlleubTCorbAtltGbzlPg6J
         l46w==
X-Gm-Message-State: AOJu0YwCSUI69p5jOn/bHKMI1wFBEbWLRmENeIrcSb4ve4myv/iMwn0M
	17Q+LRrHKj3AKtCxYRGzuj8taZpq3ugOd8eFnBVma3Ut2HZoO/X44rAp476ymmUEheKVIbqjbLX
	j95+5Snf23df33vSetdbb9Ztdd07cbJILt2KNP3fVAS5bukv3jQUsvplW76iXVZk33g4YIKHp6v
	BiBEj/WvmWpy6pyJopTSXPEHdTzutHbd8EhhP6
X-Gm-Gg: AeBDietJ5sCQsMB6wqefN8am+UKSVvxE8ty/4T9PXMsnbnQsQ19GsyFSN5mN3WVFvYn
	XDwD0tekzd4OQX/d981y4a7x8cXzuFVN8/Zh0vy04nNWUBdapbk9TZDc8W3GhO9o+dlOqDyzANe
	4zHyk1zdE+qu5GOXxq4/wNfZLwhTCKU5C9/SijbdJ3sXLHpBb9lw6htG7HEGxFp6yXvLZ5wYHqG
	sft+gLoXLCdubjIAw71G+OtLplARWY5uZV6Aauxen6FZYPAmFFyiI+XmhUA20hfAfQOBqUVhimS
	r6/lWeziuf+5WxIpY8UxS8BsrI5U9QVGMV1b7Z8Kr/Y121FK7LXtpDQCwYfI/LLphsMBURYpjMI
	M6K0V+wLThKodJykIxZ/zKA==
X-Received: by 2002:a05:6820:81cb:b0:696:6d4f:a46c with SMTP id 006d021491bc7-69998d0db94mr97394eaf.30.1778009910808;
        Tue, 05 May 2026 12:38:30 -0700 (PDT)
X-Received: by 2002:a05:6820:81cb:b0:696:6d4f:a46c with SMTP id 006d021491bc7-69998d0db94mr97361eaf.30.1778009909766;
        Tue, 05 May 2026 12:38:29 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:44::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69689441144sm9032685eaf.2.2026.05.05.12.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:38:28 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ncardwell@google.com, dsahern@kernel.org,
        ntspring@meta.com
Subject: [PATCH net-next v3 2/2] selftests: net: add local ECMP rehash test
Date: Tue,  5 May 2026 12:38:24 -0700
Message-ID: <20260505193824.2791642-3-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260505193824.2791642-1-ntspring@meta.com>
References: <20260505193824.2791642-1-ntspring@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OT-hFAgmO6u1vr0xeePsgCboBkhbZjBD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE5MSBTYWx0ZWRfX34nC6lX/DgA+
 eh+x3JMM3+lWfyMr9vh2037D33KEdelGTTALP9LyM4NQl0uCDeTwbXXPWyR5YDtxvyhRszIgPF1
 6p62bSnOXSMT/7nx2nf7umSzcyk5f5fC2JY+DcMIbKSz/WT7C1y/pHYgVAgBVMGGdD13b+VRzzy
 /VkthcVswSJcI1udlA0SjV7LilyysEgxSB9jBaowYQJMAUyuTtrRV495uXVBZIrjRd+KITImyrV
 UK4EuBO9KnAWX5cptIjTE9RaJF38qwYWT0pH8L2dx/oJ4qUDYLhcAaNHg8AdJ2HCyzzNsRQ5XGx
 sPIv5jq/pz6cbZifa2tIItjANeYfd5FVlyBBpQ6/WvF3ZQiXx/6jbOaBrGGjD7mcx8S/NCoMgKO
 6nEL042GP2GLkFEcbcMTejziuVbx9xGdeV4QWfFUoWDXq5S7hIF88VRWUC/YIvt4REffq9aZS0k
 gPYAbylUJT5X4BXwY9Q==
X-Authority-Analysis: v=2.4 cv=NYjWEWD4 c=1 sm=1 tr=0 ts=69fa4738 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=tpM8CJlwf7uhpglF1g9U:22 a=VabnemYjAAAA:8 a=ceGynBpgY5YJunApsO0A:9
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: OT-hFAgmO6u1vr0xeePsgCboBkhbZjBD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Rspamd-Queue-Id: B502B4D32A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-284571-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:dkim,meta.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ecmp_rehash.sh:url];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]

Add ecmp_rehash.sh to exercise TCP local ECMP path re-selection on
retransmission timeout and PLB.  The topology is two namespaces
connected by two parallel veth pairs with a 2-way ECMP route.  When a
TCP path is blocked (via tc drop) or congested (via netem ECN marking),
the kernel rehashes the connection via sk_rethink_txhash() +
sk_dst_reset(), causing the next route lookup to pick the other local
ECMP nexthop through the new fl6->mp_hash propagation.

Five tests cover the code paths modified in the preceding patch:

  test_ecmp_syn_rehash: Block both forward paths during connection
  setup.  With tcp_syn_retries=25, SYNs retry at 1-second intervals;
  verify that both interfaces carry SYN packets, proving
  tcp_write_timeout() rehashed the SYN to a new path.

  test_ecmp_synack_rehash: Block the server's return paths so SYN/ACKs
  are dropped.  Each duplicate SYN arriving at the server triggers
  tcp_rtx_synack() which re-rolls tcp_rsk(req)->txhash, so the
  retransmitted SYN/ACK selects a different return path via
  inet6_csk_route_req().

  test_ecmp_midstream_rehash: Establish a data transfer, then block the
  active forward path.  Verify data appears on the alternate path after
  RTO triggers sk_dst_reset() in tcp_write_timeout() and the retransmit
  rebuilds the route through inet6_sk_rebuild_header() with the new
  mp_hash.  Sets tcp_retries1=255 to suppress the pre-existing
  __dst_negative_advice() fallback, isolating the patch's sk_dst_reset()
  as the sole dst invalidation mechanism.

  test_ecmp_midstream_ack_rehash: Establish a data transfer, then block
  the receiver's return paths so ACKs are dropped.  The sender times
  out and retransmits with a new flowlabel; the receiver detects the
  changed flowlabel via tcp_rcv_spurious_retrans() and rehashes its own
  txhash so that its ACKs try a different ECMP return path.

  test_ecmp_plb_rehash: Establish a data transfer using DCTCP, then
  apply ECN marking (netem loss 100% ecn) on the active path.  Sustained
  ECN congestion triggers PLB (Protective Load Balancing) which calls
  sk_rethink_txhash() + sk_dst_reset(), moving traffic to the alternate
  path.  Verifies that TCPPLBRehash increments and TcpTimeoutRehash
  does not, confirming the rehash is PLB-driven, not RTO-driven.

Signed-off-by: Neil Spring <ntspring@meta.com>
---
 tools/testing/selftests/net/Makefile       |   1 +
 tools/testing/selftests/net/ecmp_rehash.sh | 569 +++++++++++++++++++++
 2 files changed, 570 insertions(+)
 create mode 100755 tools/testing/selftests/net/ecmp_rehash.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index baa30287cf22..6ec1b24218ad 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -26,6 +26,7 @@ TEST_PROGS := \
 	cmsg_time.sh \
 	double_udp_encap.sh \
 	drop_monitor_tests.sh \
+	ecmp_rehash.sh \
 	fcnal-ipv4.sh \
 	fcnal-ipv6.sh \
 	fcnal-other.sh \
diff --git a/tools/testing/selftests/net/ecmp_rehash.sh b/tools/testing/selftests/net/ecmp_rehash.sh
new file mode 100755
index 000000000000..7b56225623b7
--- /dev/null
+++ b/tools/testing/selftests/net/ecmp_rehash.sh
@@ -0,0 +1,569 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test local ECMP path re-selection on TCP retransmission timeout and PLB.
+#
+# Two namespaces connected by two parallel veth pairs with a 2-way ECMP
+# route.  When a TCP path is blocked (via tc drop) or congested (via
+# netem ECN marking), the kernel rehashes the connection via
+# sk_rethink_txhash() + sk_dst_reset(), causing the next route lookup
+# to select the other ECMP path.
+#
+# False negative: ~(1/2)^25 ~ 3e-8.  With tcp_syn_retries=25 and
+# tcp_syn_linear_timeouts=25 there are 26 SYN attempts at 1-second
+# intervals, each choosing one of 2 paths uniformly.
+
+source lib.sh
+
+SUBNETS=(a b)
+PORT=9900
+
+ALL_TESTS="
+	test_ecmp_syn_rehash
+	test_ecmp_synack_rehash
+	test_ecmp_midstream_rehash
+	test_ecmp_midstream_ack_rehash
+	test_ecmp_plb_rehash
+"
+
+link_tx_packets_get()
+{
+	local ns=$1; shift
+	local dev=$1; shift
+
+	ip netns exec "$ns" cat "/sys/class/net/$dev/statistics/tx_packets"
+}
+
+# Return the number of packets matched by the tc filter action on a device.
+# When tc drops packets via "action drop", the device's tx_packets is not
+# incremented (packet never reaches veth_xmit), but the tc action maintains
+# its own counter.
+tc_filter_pkt_count()
+{
+	local ns=$1; shift
+	local dev=$1; shift
+
+	ip netns exec "$ns" tc -s filter show dev "$dev" parent 1: 2>/dev/null |
+		awk '/Sent .* pkt/ { for (i=1;i<=NF;i++) if ($i=="pkt") { print $(i-1); exit } }'
+}
+
+# Read a TcpExt counter from /proc/net/netstat in a namespace.
+get_netstat_counter()
+{
+	local ns=$1; shift
+	local field=$1; shift
+
+	ip netns exec "$ns" awk -v key="$field" '
+		/^TcpExt:/ {
+			if (!h) { split($0, n); h=1 }
+			else {
+				split($0, v)
+				for (i in n)
+					if (n[i] == key) print v[i]
+			}
+		}
+	' /proc/net/netstat
+}
+
+# Apply netem ECN marking: CE-mark all ECT packets instead of dropping them.
+mark_ecn()
+{
+	local ns=$1; shift
+	local dev=$1; shift
+
+	ip netns exec "$ns" tc qdisc add dev "$dev" root netem loss 100% ecn
+}
+
+# Block TCP (IPv6 next-header = 6) egress, allowing ICMPv6 through.
+block_tcp()
+{
+	local ns=$1; shift
+	local dev=$1; shift
+
+	ip netns exec "$ns" tc qdisc add dev "$dev" root handle 1: prio
+	ip netns exec "$ns" tc filter add dev "$dev" parent 1: \
+		protocol ipv6 prio 1 u32 match u8 0x06 0xff at 6 action drop
+}
+
+unblock_tcp()
+{
+	local ns=$1; shift
+	local dev=$1; shift
+
+	ip netns exec "$ns" tc qdisc del dev "$dev" root 2>/dev/null
+}
+
+# Return success when a device's TX counter exceeds a baseline value.
+dev_tx_packets_above()
+{
+	local ns=$1; shift
+	local dev=$1; shift
+	local baseline=$1; shift
+
+	local cur
+	cur=$(link_tx_packets_get "$ns" "$dev")
+	[ "$cur" -gt "$baseline" ]
+}
+
+# Return success when both devices have dropped at least one TCP packet.
+both_devs_attempted()
+{
+	local ns=$1; shift
+	local dev0=$1; shift
+	local dev1=$1; shift
+
+	local c0 c1
+	c0=$(tc_filter_pkt_count "$ns" "$dev0")
+	c1=$(tc_filter_pkt_count "$ns" "$dev1")
+	[ "${c0:-0}" -ge 1 ] && [ "${c1:-0}" -ge 1 ]
+}
+
+link_tx_packets_total()
+{
+	local ns=$1; shift
+
+	echo $(( $(link_tx_packets_get "$ns" veth0a) +
+		 $(link_tx_packets_get "$ns" veth1a) ))
+}
+
+setup()
+{
+	setup_ns NS1 NS2
+
+	local ns
+	for ns in "$NS1" "$NS2"; do
+		ip netns exec "$ns" sysctl -qw net.ipv6.conf.all.accept_dad=0
+		ip netns exec "$ns" sysctl -qw net.ipv6.conf.default.accept_dad=0
+		ip netns exec "$ns" sysctl -qw net.ipv6.conf.all.forwarding=1
+		ip netns exec "$ns" sysctl -qw net.core.txrehash=1
+	done
+
+	local i sub
+	for i in 0 1; do
+		sub=${SUBNETS[$i]}
+		ip link add "veth${i}a" type veth peer name "veth${i}b"
+		ip link set "veth${i}a" netns "$NS1"
+		ip link set "veth${i}b" netns "$NS2"
+		ip -n "$NS1" addr add "fd00:${sub}::1/64" dev "veth${i}a"
+		ip -n "$NS2" addr add "fd00:${sub}::2/64" dev "veth${i}b"
+		ip -n "$NS1" link set "veth${i}a" up
+		ip -n "$NS2" link set "veth${i}b" up
+	done
+
+	ip -n "$NS1" addr add fd00:ff::1/128 dev lo
+	ip -n "$NS2" addr add fd00:ff::2/128 dev lo
+
+	# Allow many SYN retries at 1-second intervals (linear, no
+	# exponential backoff) so the rehash test has enough attempts
+	# to exercise both ECMP paths.  tcp_syn_retries is a pure
+	# retransmission count (not time-based for SYN_SENT), so with
+	# linear 1-second intervals it also sets the total lifetime.
+	ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_syn_retries=25
+	ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_syn_linear_timeouts=25
+
+	# Keep the server's request socket alive during the blocking
+	# period so SYN/ACK retransmits continue.
+	ip netns exec "$NS2" sysctl -qw net.ipv4.tcp_synack_retries=25
+
+	ip -n "$NS1" -6 route add fd00:ff::2/128 \
+		nexthop via fd00:a::2 dev veth0a \
+		nexthop via fd00:b::2 dev veth1a
+
+	ip -n "$NS2" -6 route add fd00:ff::1/128 \
+		nexthop via fd00:a::1 dev veth0b \
+		nexthop via fd00:b::1 dev veth1b
+
+	for i in 0 1; do
+		sub=${SUBNETS[$i]}
+		ip netns exec "$NS1" \
+			ping -6 -c1 -W5 "fd00:${sub}::2" &>/dev/null
+		ip netns exec "$NS2" \
+			ping -6 -c1 -W5 "fd00:${sub}::1" &>/dev/null
+	done
+
+	if ! ip netns exec "$NS1" ping -6 -c1 -W5 fd00:ff::2 &>/dev/null; then
+		echo "Basic connectivity check failed"
+		return $ksft_skip
+	fi
+}
+
+# Block ALL paths, start a connection, wait until SYNs have been dropped
+# on both interfaces (proving rehash steered the SYN to a new path), then
+# unblock so the connection completes.
+test_ecmp_syn_rehash()
+{
+	RET=0
+
+	block_tcp "$NS1" veth0a
+	defer unblock_tcp "$NS1" veth0a
+	block_tcp "$NS1" veth1a
+	defer unblock_tcp "$NS1" veth1a
+
+	ip netns exec "$NS2" socat \
+		"TCP6-LISTEN:$PORT,bind=[fd00:ff::2],reuseaddr,fork" \
+		EXEC:"echo ESTABLISH_OK" &
+	defer kill_process $!
+
+	wait_local_port_listen "$NS2" $PORT tcp
+
+	local rehash_before
+	rehash_before=$(get_netstat_counter "$NS1" TcpTimeoutRehash)
+
+	# Start the connection in the background; it will retry SYNs at
+	# 1-second intervals until an unblocked path is found.
+	# Use -u (unidirectional) to only receive from the server;
+	# sending data back would risk SIGPIPE if the server's EXEC
+	# child has already exited.
+	local tmpfile
+	tmpfile=$(mktemp)
+	defer rm -f "$tmpfile"
+
+	ip netns exec "$NS1" socat -u \
+		"TCP6:[fd00:ff::2]:$PORT,bind=[fd00:ff::1],connect-timeout=60" \
+		STDOUT >"$tmpfile" 2>&1 &
+	local client_pid=$!
+	defer kill_process $client_pid
+
+	# Wait until both paths have seen at least one dropped SYN.
+	# This proves sk_rethink_txhash() rehashed the connection from
+	# one ECMP path to the other.
+	slowwait 30 both_devs_attempted "$NS1" veth0a veth1a
+	check_err $? "SYNs did not appear on both paths (rehash not working)"
+	if [ $RET -ne 0 ]; then
+		log_test "Local ECMP SYN rehash: establish with blocked paths"
+		return
+	fi
+
+	# Unblock both paths and let the next SYN retransmit succeed.
+	unblock_tcp "$NS1" veth0a
+	unblock_tcp "$NS1" veth1a
+
+	local rc=0
+	wait $client_pid || rc=$?
+
+	local result
+	result=$(cat "$tmpfile" 2>/dev/null)
+
+	if [[ "$result" != *"ESTABLISH_OK"* ]]; then
+		check_err 1 "connection failed after unblocking (rc=$rc): $result"
+	fi
+
+	local rehash_after
+	rehash_after=$(get_netstat_counter "$NS1" TcpTimeoutRehash)
+	if [ "$rehash_after" -le "$rehash_before" ]; then
+		check_err 1 "TcpTimeoutRehash counter did not increment"
+	fi
+
+	log_test "Local ECMP SYN rehash: establish with blocked paths"
+}
+
+# Block the server's return paths so SYN/ACKs are dropped.  The client
+# retransmits SYNs at 1-second intervals; each duplicate SYN arriving at
+# the server triggers tcp_rtx_synack() which re-rolls txhash, so the
+# retransmitted SYN/ACK selects a different ECMP return path.
+test_ecmp_synack_rehash()
+{
+	RET=0
+	local port=$((PORT + 2))
+
+	block_tcp "$NS2" veth0b
+	defer unblock_tcp "$NS2" veth0b
+	block_tcp "$NS2" veth1b
+	defer unblock_tcp "$NS2" veth1b
+
+	ip netns exec "$NS2" socat \
+		"TCP6-LISTEN:$port,bind=[fd00:ff::2],reuseaddr,fork" \
+		EXEC:"echo SYNACK_OK" &
+	defer kill_process $!
+
+	wait_local_port_listen "$NS2" $port tcp
+
+	# Start the connection; SYNs reach the server (client egress is
+	# open) but SYN/ACKs are dropped on the server's return path.
+	local tmpfile
+	tmpfile=$(mktemp)
+	defer rm -f "$tmpfile"
+
+	ip netns exec "$NS1" socat -u \
+		"TCP6:[fd00:ff::2]:$port,bind=[fd00:ff::1],connect-timeout=60" \
+		STDOUT >"$tmpfile" 2>&1 &
+	local client_pid=$!
+	defer kill_process $client_pid
+
+	# Wait until both server-side interfaces have dropped at least
+	# one SYN/ACK, proving the server rehashed its return path.
+	slowwait 30 both_devs_attempted "$NS2" veth0b veth1b
+	check_err $? "SYN/ACKs did not appear on both return paths"
+	if [ $RET -ne 0 ]; then
+		log_test "Local ECMP SYN/ACK rehash: blocked return path"
+		return
+	fi
+
+	# Unblock and let the connection complete.
+	unblock_tcp "$NS2" veth0b
+	unblock_tcp "$NS2" veth1b
+
+	local rc=0
+	wait $client_pid || rc=$?
+
+	local result
+	result=$(cat "$tmpfile" 2>/dev/null)
+
+	if [[ "$result" != *"SYNACK_OK"* ]]; then
+		check_err 1 "connection failed after unblocking (rc=$rc): $result"
+	fi
+
+	log_test "Local ECMP SYN/ACK rehash: blocked return path"
+}
+
+# Establish a data transfer with both paths open, then block the
+# active path.  Verify that data appears on the previously inactive
+# path (proving RTO triggered a rehash) and that TcpTimeoutRehash
+# incremented.
+test_ecmp_midstream_rehash()
+{
+	RET=0
+	local port=$((PORT + 1))
+
+	ip netns exec "$NS2" socat -u \
+		"TCP6-LISTEN:$port,bind=[fd00:ff::2],reuseaddr" - >/dev/null &
+	defer kill_process $!
+
+	wait_local_port_listen "$NS2" $port tcp
+
+	local base_tx0 base_tx1
+	base_tx0=$(link_tx_packets_get "$NS1" veth0a)
+	base_tx1=$(link_tx_packets_get "$NS1" veth1a)
+
+	# Continuous data source; timeout caps overall test duration and
+	# must exceed the slowwait below so data keeps flowing.
+	ip netns exec "$NS1" bash -c "
+		cat /dev/zero | timeout 90 socat - \
+			'TCP6:[fd00:ff::2]:$port,bind=[fd00:ff::1]'
+	" &>/dev/null &
+	local client_pid=$!
+	defer kill_process $client_pid
+
+	# Wait for enough packets to identify the active path.
+	busywait $BUSYWAIT_TIMEOUT until_counter_is \
+			">= $((base_tx0 + base_tx1 + 10))" \
+		link_tx_packets_total "$NS1" > /dev/null
+	check_err $? "no TX activity detected"
+	if [ $RET -ne 0 ]; then
+		log_test "Local ECMP midstream rehash: block active path"
+		return
+	fi
+
+	# Find the active path and block it.
+	local current_tx0 current_tx1 active_idx inactive_idx
+	current_tx0=$(link_tx_packets_get "$NS1" veth0a)
+	current_tx1=$(link_tx_packets_get "$NS1" veth1a)
+	if [ $((current_tx0 - base_tx0)) -ge $((current_tx1 - base_tx1)) ]; then
+		active_idx=0; inactive_idx=1
+	else
+		active_idx=1; inactive_idx=0
+	fi
+	local inactive_before
+	inactive_before=$(link_tx_packets_get "$NS1" "veth${inactive_idx}a")
+
+	local rehash_before
+	rehash_before=$(get_netstat_counter "$NS1" TcpTimeoutRehash)
+	# Suppress the existing __dst_negative_advice() in
+	# tcp_write_timeout() so that the patch's sk_dst_reset()
+	# is the only dst-invalidation mechanism on the RTO path.
+	ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_retries1=255
+	defer ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_retries1=3
+
+	block_tcp "$NS1" "veth${active_idx}a"
+	defer unblock_tcp "$NS1" "veth${active_idx}a"
+
+	# Wait for meaningful data on the previously inactive path,
+	# proving RTO triggered a rehash and data actually moved.
+	# Require 100 packets beyond baseline to rule out stray
+	# control packets (ND, etc.).  Allow 60s for multiple RTO
+	# cycles with exponential backoff.
+	slowwait 60 dev_tx_packets_above \
+		"$NS1" "veth${inactive_idx}a" "$((inactive_before + 100))"
+	check_err $? "data did not appear on alternate path after blocking"
+
+	local rehash_after
+	rehash_after=$(get_netstat_counter "$NS1" TcpTimeoutRehash)
+	if [ "$rehash_after" -le "$rehash_before" ]; then
+		check_err 1 "TcpTimeoutRehash counter did not increment"
+	fi
+
+	log_test "Local ECMP midstream rehash: block active path"
+}
+
+# Block the receiver's (NS2) ACK return paths while data flows from
+# NS1 to NS2.  The sender (NS1) times out and retransmits with a new
+# flowlabel; the receiver detects the changed flowlabel via
+# tcp_rcv_spurious_retrans() and rehashes its own txhash so that its
+# ACKs try a different ECMP return path.
+test_ecmp_midstream_ack_rehash()
+{
+	RET=0
+	local port=$((PORT + 3))
+
+	ip netns exec "$NS2" socat -u \
+		"TCP6-LISTEN:$port,bind=[fd00:ff::2],reuseaddr" - >/dev/null &
+	defer kill_process $!
+
+	wait_local_port_listen "$NS2" $port tcp
+
+	local base_tx0 base_tx1
+	base_tx0=$(link_tx_packets_get "$NS1" veth0a)
+	base_tx1=$(link_tx_packets_get "$NS1" veth1a)
+
+	# Continuous data source from NS1 to NS2.
+	ip netns exec "$NS1" bash -c "
+		cat /dev/zero | timeout 120 socat - \
+			'TCP6:[fd00:ff::2]:$port,bind=[fd00:ff::1]'
+	" &>/dev/null &
+	defer kill_process $!
+
+	# Wait for data to start flowing.
+	busywait $BUSYWAIT_TIMEOUT until_counter_is \
+			">= $((base_tx0 + base_tx1 + 10))" \
+		link_tx_packets_total "$NS1" > /dev/null
+	check_err $? "no TX activity detected"
+	if [ $RET -ne 0 ]; then
+		log_test "Local ECMP midstream ACK rehash: blocked return path"
+		return
+	fi
+
+	local rehash_before
+	rehash_before=$(get_netstat_counter "$NS2" TcpDuplicateDataRehash)
+
+	# Block both return paths from NS2 so ACKs are dropped.
+	# Data from NS1 still arrives (tc filter is on egress).
+	block_tcp "$NS2" veth0b
+	defer unblock_tcp "$NS2" veth0b
+	block_tcp "$NS2" veth1b
+	defer unblock_tcp "$NS2" veth1b
+
+	# NS1 will RTO (no ACKs), retransmit with new flowlabel.
+	# NS2 detects the flowlabel change via tcp_rcv_spurious_retrans(),
+	# rehashes, and NS2's ACKs try a different ECMP return path.
+	# Wait until both NS2 interfaces have dropped at least one ACK.
+	slowwait 60 both_devs_attempted "$NS2" veth0b veth1b
+	check_err $? "ACKs did not appear on both return paths"
+
+	local rehash_after
+	rehash_after=$(get_netstat_counter "$NS2" TcpDuplicateDataRehash)
+	if [ "$rehash_after" -le "$rehash_before" ]; then
+		check_err 1 "TcpDuplicateDataRehash counter did not increment"
+	fi
+
+	log_test "Local ECMP midstream ACK rehash: blocked return path"
+}
+
+# Establish a DCTCP data transfer with PLB enabled, then ECN-mark both
+# paths.  Sustained CE marking triggers PLB to call sk_rethink_txhash()
+# + sk_dst_reset(), bouncing the connection between ECMP paths.  Verify
+# data appears on both paths and that TCPPLBRehash incremented.
+test_ecmp_plb_rehash()
+{
+	RET=0
+	local port=$((PORT + 4))
+
+	# DCTCP is a restricted congestion control algorithm.  Setting it
+	# as the default in the init namespace makes it globally
+	# non-restricted (TCP_CONG_NON_RESTRICTED), allowing child
+	# namespaces to use it.
+	sysctl -qw net.ipv4.tcp_congestion_control=dctcp
+	defer sysctl -qw net.ipv4.tcp_congestion_control=cubic
+
+	# Enable ECN and DCTCP with PLB on the sender.
+	ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_ecn=1
+	ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_congestion_control=dctcp
+	ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_plb_enabled=1
+	ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_plb_rehash_rounds=3
+	ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_plb_cong_thresh=1
+	ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_plb_suspend_rto_sec=0
+	defer ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_ecn=0
+	defer ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_congestion_control=cubic
+	defer ip netns exec "$NS1" sysctl -qw net.ipv4.tcp_plb_enabled=0
+
+	# DCTCP sets ECT on the SYN; the receiver must also use DCTCP
+	# so that tcp_ca_needs_ecn(listen_sk) accepts the ECN
+	# negotiation.
+	ip netns exec "$NS2" sysctl -qw net.ipv4.tcp_ecn=1
+	ip netns exec "$NS2" sysctl -qw net.ipv4.tcp_congestion_control=dctcp
+	defer ip netns exec "$NS2" sysctl -qw net.ipv4.tcp_ecn=0
+	defer ip netns exec "$NS2" sysctl -qw net.ipv4.tcp_congestion_control=cubic
+
+	ip netns exec "$NS2" socat -u \
+		"TCP6-LISTEN:$port,bind=[fd00:ff::2],reuseaddr" - >/dev/null &
+	defer kill_process $!
+
+	wait_local_port_listen "$NS2" $port tcp
+
+	local base_tx0 base_tx1
+	base_tx0=$(link_tx_packets_get "$NS1" veth0a)
+	base_tx1=$(link_tx_packets_get "$NS1" veth1a)
+
+	ip netns exec "$NS1" bash -c "
+		cat /dev/zero | timeout 90 socat - \
+			'TCP6:[fd00:ff::2]:$port,bind=[fd00:ff::1]'
+	" &>/dev/null &
+	local client_pid=$!
+	defer kill_process $client_pid
+
+	# Wait for data to start flowing before applying ECN marking.
+	busywait $BUSYWAIT_TIMEOUT until_counter_is \
+			">= $((base_tx0 + base_tx1 + 10))" \
+		link_tx_packets_total "$NS1" > /dev/null
+	check_err $? "no TX activity detected"
+	if [ $RET -ne 0 ]; then
+		log_test "Local ECMP PLB rehash: ECN-marked path"
+		return
+	fi
+
+	# Snapshot TX counters and rehash stats before ECN marking.
+	local pre_ecn_tx0 pre_ecn_tx1
+	pre_ecn_tx0=$(link_tx_packets_get "$NS1" veth0a)
+	pre_ecn_tx1=$(link_tx_packets_get "$NS1" veth1a)
+
+	local plb_before rto_before
+	plb_before=$(get_netstat_counter "$NS1" TCPPLBRehash)
+	rto_before=$(get_netstat_counter "$NS1" TcpTimeoutRehash)
+
+	# CE-mark all data on both paths.  PLB detects sustained
+	# congestion and rehashes, bouncing traffic between paths.
+	mark_ecn "$NS1" veth0a
+	defer unblock_tcp "$NS1" veth0a	# removes the marking rule
+	mark_ecn "$NS1" veth1a
+	defer unblock_tcp "$NS1" veth1a	# removes the marking rule
+
+	# Wait for meaningful data on both paths, proving PLB rehashed
+	# the connection and traffic actually moved.  Require at least
+	# 100 packets beyond the baseline to rule out stray control
+	# packets (ND, etc.) satisfying the check.
+	slowwait 60 dev_tx_packets_above \
+		"$NS1" veth0a "$((pre_ecn_tx0 + 100))"
+	check_err $? "no data on veth0a after ECN marking"
+
+	slowwait 60 dev_tx_packets_above \
+		"$NS1" veth1a "$((pre_ecn_tx1 + 100))"
+	check_err $? "no data on veth1a after ECN marking"
+
+	local plb_after rto_after
+	plb_after=$(get_netstat_counter "$NS1" TCPPLBRehash)
+	rto_after=$(get_netstat_counter "$NS1" TcpTimeoutRehash)
+	if [ "$plb_after" -le "$plb_before" ]; then
+		check_err 1 "TCPPLBRehash counter did not increment"
+	fi
+	if [ "$rto_after" -gt "$rto_before" ]; then
+		check_err 1 "TcpTimeoutRehash incremented; rehash was RTO-driven, not PLB"
+	fi
+
+	log_test "Local ECMP PLB rehash: ECN-marked path"
+}
+
+require_command socat
+
+trap cleanup_all_ns EXIT
+setup || exit $?
+tests_run
+exit $EXIT_STATUS
-- 
2.52.0


