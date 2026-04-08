Return-Path: <netdev+bounces-276311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cILNCBP/1Wn4/gcAu9opvQ
	(envelope-from <netdev+bounces-276311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:09:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6646B3B7E6E
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A6743036761
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 07:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15E1366549;
	Wed,  8 Apr 2026 07:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VjupYkoH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13F937186B
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 07:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775631925; cv=none; b=XSeI9aYKPdS+TRaSnLVQ6UsO4sDH5Ak7Vge6F0v4MF53XcVTOkrQx7K0UrhauGKOMhFHaTPk0cKmUpF/9QSxNkdoVTqUKqPYY+2+2JA4kjrF1O2QvDclaJkMF61pehCQWTzhOzFf1Kf6Huai738dQcCsQuYuo+sQJahYr6wyGY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775631925; c=relaxed/simple;
	bh=pc4b4gEMJazDbRKa1P9MUpMhvSC9M5+N0Ut1616OeIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BygYNsnGRIfkhgqLu298mlmz+WjvyOMxCkH61G0qyJzhnuEi9lgwJgkdMAaF/0HSfEgX2hT4nLTvklj49PpILJn9P3+9hlJ3ssals3Rmg0G7gG4G9fD008pMPf7K8a5R/uuSJsG0nqNomqZnb3y8zHuJcdeuYIWilbRK5eN59Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VjupYkoH; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637J6Qfp2664259
	for <netdev@vger.kernel.org>; Wed, 8 Apr 2026 00:05:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=JwAkq4/tjcvaorSEz8DJ4GnrlhIUUQfNXp1rAzwE8uY=; b=VjupYkoH/o+J
	lzi8JO0sSmTY4p70L6HXUzo8QuAMMyJUzTywCBSNI6FPr0PMdXRDCAadu0wnY8Vh
	hgXPXq8oYE8rmIHrJM2KEM5MO1qqrfZRTaGX3JjnuG7wegEHc3zeMOfuzixV/txi
	h2ybdPWTzG0nh4tLsBtaSVBtU0y+FuV+3xaC+kYC5Fj7b4eQkBVMzZjhZ2wsNhu+
	6QdKxE1RVbjchm6DC8okE7G6aWmdMvjedyE6/ZIhyY/Ry96qVuwH3C17Qi2baWnh
	uRFA2eVHcrROE8XruaVDHQozYHJt1RsJSu9kM2KRNWf4jumUfjMS2R4PdC/lL6Fo
	iSdM17VtuA==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dcmsu99jn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 00:05:22 -0700 (PDT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-68721a878d7so6193934eaf.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 00:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775631922; x=1776236722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JwAkq4/tjcvaorSEz8DJ4GnrlhIUUQfNXp1rAzwE8uY=;
        b=qqtpvqNL/ih0FxWfpBI/qKnWm1aldWalzkTkNF13iDR9qNGkpW15a7uFJZb9KPDIGk
         tKiPs32AT8GXdE6ichdAQy9NfK5BN15P6Tr6fX1nrBM7msDtyLdGxobtn9QQu+krliDx
         hBOwtNmwBqDEoH0ebYWh1zZSCK5QhcU+91hrfNxZqyDA4z7x0OY201PmyNHiVNdeQT0o
         x1rEy+YiAGra9LJ4n/HifGS+FdBuSoD3AZ+pT4bccn7tXNdqKDBEBFf7Q+GruyGBC/Uu
         O13CzF7/XIKjvacQlmEV778FHGAQIcF3f2KiazwSQQAr8n7sqVEfvtWvLntCWU3S7Ixl
         0emA==
X-Gm-Message-State: AOJu0YygfTSGBrIgmLkp0yoR53dBAtDHKbfsG0yS2Dpec+v4/mBJhd+d
	jFmUUoSpmvZuiOV7pxABg/bPsdX2tcDUdN8vNGrAGLaThOWLVO8YgjE/F5276m+W0PCf1Jregrc
	zIQ47ocDvnU9HGoq0FMvN9xu6SeIgbcvGfUeFCpStxJz32tguOQJPnGLgcnh9Ha2lJ39ysLeYRW
	2C1pIsww59uRyeti34IcIpuJzAfrMG7TqbrTA2
X-Gm-Gg: AeBDieuZ5g+uHRsD/KhG0TPD2IOzqmXYN4tj7Z/QaDQHa5UDy4Yck+b+F1JK1QrwRVU
	OmID+5u8pes1NCXmcW6tJCJhOyp58lJtJZGrpO62VQdxUuU4moTdHpzBMsBwPVuHN3+eNIHGHHe
	mlF8+YVuC+RSG2KGpopGV+7C2wCjTG9T8BgX79Vz93D6ahN1DFxkJ4r6sVtX6n92eS2BSQyUzbW
	1HLZ5Ee7beEuw5UcXFMH+KZlBMib7cbj4khG/8zKiXj8IjgaUNMXnsUL9tyhVpS3tL4ez0OBDPs
	T3sQGJ+um5zFxcDC+ZBcIi5Bmr+PoSMx4QkuuORc+lCyeg/IZ8yIo0RY5i9D6iI39RzOe1AVe4L
	JqkeknJ90N1I=
X-Received: by 2002:a05:6820:168d:b0:67e:3267:f02f with SMTP id 006d021491bc7-6821f677d8cmr10942512eaf.38.1775631921556;
        Wed, 08 Apr 2026 00:05:21 -0700 (PDT)
X-Received: by 2002:a05:6820:168d:b0:67e:3267:f02f with SMTP id 006d021491bc7-6821f677d8cmr10942488eaf.38.1775631920890;
        Wed, 08 Apr 2026 00:05:20 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:71::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6823d419d09sm9001450eaf.15.2026.04.08.00.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 00:05:20 -0700 (PDT)
From: Neil Spring <ntspring@meta.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org
Subject: [PATCH net-next v2 2/2] selftests: net: add ECMP rehash test
Date: Wed,  8 Apr 2026 00:05:14 -0700
Message-ID: <20260408070514.1840227-3-ntspring@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408070514.1840227-1-ntspring@meta.com>
References: <20260408002802.2448424-1-ntspring@meta.com>
 <20260408070514.1840227-1-ntspring@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eQMZngWM5ggiWCZU7iLpnzilHerNVO4i
X-Authority-Analysis: v=2.4 cv=fIYJG5ae c=1 sm=1 tr=0 ts=69d5fe32 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22 a=VabnemYjAAAA:8
 a=_tJXsZ62ISBIMLIKAhQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-UhsvdU3ccFDOXFxFb4l:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: eQMZngWM5ggiWCZU7iLpnzilHerNVO4i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA2MSBTYWx0ZWRfX4FubZJRDFwbf
 7P7RjwWedu83+DLHEHjTQsN8VcC3No3IifzXyjsxhKWpU0Sgbf3FjfOH4J8heQdV6E7ll0YrFgm
 GUanN42dpPQJ+94FV/XUE9kBpi71n8Fe4RI3PLirIatt4dnt7gym9GpPgMuHjS3AGNevkj1/pMA
 x0CT3XMZNul8WIApUSpsMfltN7ncsfD7HzdF3XAjQ25LjLcgqP8YigTptIRvWixoI6jCU+yaRco
 37OAUCk96bSSWnNTp3mEBPyf8kQn5wJzvCl3qwlxf1oOOrb3qdSHqC6xpRDNJtIlW/IWRu0E3Uq
 gR4m6bGPtGa4yk8RKRej0A3TNcmHUDjt9joX0AeRKJYbQsnXrvV9KwoW736GJUhMxBEkF+K0En/
 Y1H/+mB/DMFUqZ+VRS0nrKlRhXLperadGtV8DFSPoTfqmr6UO2EnEP6uO2o8MJM1n07kzXSiTTM
 iGY3I873lPSZoD1A8dA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-07_05,2025-10-01_01
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276311-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:dkim,meta.com:email,meta.com:mid];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6646B3B7E6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add ecmp_rehash.sh to exercise TCP ECMP path re-selection on
retransmission timeout.  Three tests cover client SYN rehash, server
SYN/ACK rehash, and midstream RTO rehash of an established connection
over a two-path ECMP topology with one leg blocked by tc.

The SYN test retries 26 times, so has a false negative probability
of ~(1/2)^25 ≈ 3e-8.

Signed-off-by: Neil Spring <ntspring@meta.com>
---
 tools/testing/selftests/net/Makefile       |   1 +
 tools/testing/selftests/net/ecmp_rehash.sh | 361 +++++++++++++++++++++
 2 files changed, 362 insertions(+)
 create mode 100755 tools/testing/selftests/net/ecmp_rehash.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 6bced3ed798b..acc61a51d7e2 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -25,6 +25,7 @@ TEST_PROGS := \
 	cmsg_time.sh \
 	double_udp_encap.sh \
 	drop_monitor_tests.sh \
+	ecmp_rehash.sh \
 	fcnal-ipv4.sh \
 	fcnal-ipv6.sh \
 	fcnal-other.sh \
diff --git a/tools/testing/selftests/net/ecmp_rehash.sh b/tools/testing/selftests/net/ecmp_rehash.sh
new file mode 100755
index 000000000000..a468ccf22d4f
--- /dev/null
+++ b/tools/testing/selftests/net/ecmp_rehash.sh
@@ -0,0 +1,361 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test ECMP path re-selection on TCP retransmission timeout.
+#
+# Two namespaces connected by two parallel veth pairs with a 2-way ECMP
+# route.  When a TCP path is blocked (via tc drop), RTO triggers
+# sk_rethink_txhash() + sk_dst_reset(), causing the next route lookup
+# to select the other ECMP path.
+#
+# False negative: ~(1/2)^25 ≈ 3e-8.  With tcp_syn_retries=25 and
+# tcp_syn_linear_timeouts=25 there are 26 SYN attempts at 1-second
+# intervals, each choosing one of 2 paths uniformly.
+
+source lib.sh
+
+SUBNETS=(a b)
+PORT=9900
+
+ALL_TESTS="
+	test_ecmp_rto_rehash
+	test_ecmp_synack_rehash
+	test_ecmp_midstream_rehash
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
+# Read TcpTimeoutRehash counter from /proc/net/netstat in a namespace.
+# This counter increments in tcp_write_timeout() on every RTO that triggers
+# sk_rethink_txhash().
+get_timeout_rehash_count()
+{
+	local ns=$1; shift
+
+	ip netns exec "$ns" awk '
+		/^TcpExt:/ {
+			if (!h) { split($0, n); h=1 }
+			else {
+				split($0, v)
+				for (i in n)
+					if (n[i] == "TcpTimeoutRehash") print v[i]
+			}
+		}
+	' /proc/net/netstat
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
+	ip netns exec "$NS2" sysctl -qw net.ipv4.tcp_synack_retries=10
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
+test_ecmp_rto_rehash()
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
+	rehash_before=$(get_timeout_rehash_count "$NS1")
+
+	# Start the connection in the background; it will retry SYNs at
+	# 1-second intervals until an unblocked path is found.
+	# Use -u (unidirectional) to only receive from the server;
+	# sending data back would risk SIGPIPE if the server's EXEC
+	# child has already exited.
+	ip netns exec "$NS1" socat -u \
+		"TCP6:[fd00:ff::2]:$PORT,bind=[fd00:ff::1],connect-timeout=60" \
+		STDOUT >"/tmp/ecmp_rto_$$" 2>&1 &
+	local client_pid=$!
+	defer kill_process $client_pid
+
+	# Wait until both paths have seen at least one dropped SYN.
+	# This proves sk_rethink_txhash() rehashed the connection from
+	# one ECMP path to the other.
+	slowwait 30 both_devs_attempted "$NS1" veth0a veth1a
+	check_err $? "SYNs did not appear on both paths (rehash not working)"
+	if [ $RET -ne 0 ]; then
+		log_test "ECMP RTO rehash: establish with blocked paths"
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
+	result=$(cat "/tmp/ecmp_rto_$$" 2>/dev/null)
+	rm -f "/tmp/ecmp_rto_$$"
+
+	if [[ "$result" != *"ESTABLISH_OK"* ]]; then
+		check_err 1 "connection failed after unblocking (rc=$rc): $result"
+	fi
+
+	local rehash_after
+	rehash_after=$(get_timeout_rehash_count "$NS1")
+	if [ "$rehash_after" -le "$rehash_before" ]; then
+		check_err 1 "TcpTimeoutRehash counter did not increment"
+	fi
+
+	log_test "ECMP RTO rehash: establish with blocked paths"
+}
+
+# Block the server's return paths so SYN/ACKs are dropped.  The client
+# retransmits SYNs at 1-second intervals; each duplicate SYN arriving at
+# the server updates ir_iif to match the new arrival interface, so the
+# retransmitted SYN/ACK routes back via the interface the SYN arrived on.
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
+	ip netns exec "$NS1" socat -u \
+		"TCP6:[fd00:ff::2]:$port,bind=[fd00:ff::1],connect-timeout=60" \
+		STDOUT >"/tmp/ecmp_synack_$$" 2>&1 &
+	local client_pid=$!
+	defer kill_process $client_pid
+
+	# Wait until both server-side interfaces have dropped at least
+	# one SYN/ACK, proving the server rehashed its return path.
+	slowwait 30 both_devs_attempted "$NS2" veth0b veth1b
+	check_err $? "SYN/ACKs did not appear on both return paths"
+	if [ $RET -ne 0 ]; then
+		log_test "ECMP SYN/ACK rehash: blocked return path"
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
+	result=$(cat "/tmp/ecmp_synack_$$" 2>/dev/null)
+	rm -f "/tmp/ecmp_synack_$$"
+
+	if [[ "$result" != *"SYNACK_OK"* ]]; then
+		check_err 1 "connection failed after unblocking (rc=$rc): $result"
+	fi
+
+	log_test "ECMP SYN/ACK rehash: blocked return path"
+}
+
+# Establish a data transfer with both paths open, then block the
+# active path.  Verify the transfer continues via rehash and that
+# TcpTimeoutRehash incremented.
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
+	ip netns exec "$NS1" bash -c "
+		for i in \$(seq 1 40); do
+			dd if=/dev/zero bs=10k count=1 2>/dev/null
+			sleep 0.25
+		done | timeout 60 socat - 'TCP6:[fd00:ff::2]:$port,bind=[fd00:ff::1]'
+	" &>/dev/null &
+	local client_pid=$!
+	defer kill_process $client_pid
+
+	busywait $BUSYWAIT_TIMEOUT until_counter_is \
+			">= $((base_tx0 + base_tx1 + 20))" \
+		link_tx_packets_total "$NS1"
+	check_err $? "no TX activity detected"
+	if [ $RET -ne 0 ]; then
+		log_test "ECMP midstream rehash: block active path"
+		return
+	fi
+
+	# Find the active path and block it.
+	local cur0 cur1 active_idx
+	cur0=$(link_tx_packets_get "$NS1" veth0a)
+	cur1=$(link_tx_packets_get "$NS1" veth1a)
+	if [ $((cur0 - base_tx0)) -ge $((cur1 - base_tx1)) ]; then
+		active_idx=0
+	else
+		active_idx=1
+	fi
+
+	local rehash_before
+	rehash_before=$(get_timeout_rehash_count "$NS1")
+
+	block_tcp "$NS1" "veth${active_idx}a"
+	defer unblock_tcp "$NS1" "veth${active_idx}a"
+
+	local rc=0
+	wait $client_pid || rc=$?
+
+	check_err $rc "data transfer failed after blocking veth${active_idx}a"
+
+	local rehash_after
+	rehash_after=$(get_timeout_rehash_count "$NS1")
+	if [ "$rehash_after" -le "$rehash_before" ]; then
+		check_err 1 "TcpTimeoutRehash counter did not increment"
+	fi
+
+	log_test "ECMP midstream rehash: block active path"
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
+require_command socat
+
+trap cleanup_all_ns EXIT
+setup || exit $?
+tests_run
+exit $EXIT_STATUS
-- 
2.52.0


