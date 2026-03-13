Return-Path: <netdev+bounces-267604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFoXNdh+tGmuowAAu9opvQ
	(envelope-from <netdev+bounces-267604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:17:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F4C28A152
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 379C3309B082
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261E6366DDB;
	Fri, 13 Mar 2026 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="qQ8ga+4E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC383806CF
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 21:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773436619; cv=none; b=Ks7LMxOycJopX5n86u0NZVv3Yp0pNs7Fbj3m+1xmEuw/zpkk5Zhqsx0xNVv7MaXU4VK94cRhj2MQ44LmMICAHkwQEn1QBxQ5727R00hVYL8jKAqf0nPZtj6uB3bDfX3YXqPcn5sk6fmvoHxrxofBR+Iv4iD1+81QGjC2QvNnStA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773436619; c=relaxed/simple;
	bh=JJPqK+Fq1OECH2DPGLMml6U5j96ON1Bcatvp/H2uPGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G9p/WWy9tlFdJTbOLE+NAk91Sjhbc7AzvXSaMQYqAycSSYl2m0kJSAIil54ncm1CsQ/4xX5unaedXb+rYRIwO3wQQbjKAFX+Bi4oTacOPQKTZDCkVIbUPkDm2DnWC5sEQc+7/ZVe0e7VudH/kqY1f9+tnP1x1UM542pnzvBZfE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=qQ8ga+4E; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ae43042ea7so33011795ad.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773436616; x=1774041416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYFR+Yq0O9iTOkLd8o1rMp+sxGsqQ7dNWH/FeCa5ijg=;
        b=qQ8ga+4ET91WaFcP0V0YNIAQ2ZLig0dFkQGAFVUkIq85Eyeb8bbY+gtzfUTp+bvhjG
         HHmHM3dAq6mgSNArWChwve/TKyVpOF6dkkIY9vxFlPrZB0ZgHL5cj/t9crPrzYYsPzCT
         Xnguyeodfc0yN+XKm1nuuFxWMwF4EDjaQ/c9XHLQsVyiUaYVeY1Kutiu9EIl00/JIi75
         C9ppf9gTCEsXY1GEj34gyfVhGZOp9cV6eWfb5OkSn1Arfo/RUf3g1QAhEYKpIaeCoSdL
         ppcEb9iuKbT7iRJ1jcIF3b4NdivbXfZ/3gcRHulsJhxP2SsB2cDLHvsa1E8h655JZYOA
         tBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773436616; x=1774041416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hYFR+Yq0O9iTOkLd8o1rMp+sxGsqQ7dNWH/FeCa5ijg=;
        b=M25l19IvBcTRDgpc55atQhoqT36380NB/RxrSvOHzoLgq2MYt9hM9uvclylhERV/pD
         uaapiktRzahIGItBCTvsqcI9/CcVYhIQ3aDAFjinoQnriHhz8konkjPv824wDMF3ys0v
         o+HErgTbEiVBZIhKGyY6d3905mjwDyep9RJWs/7GenJPMPc7Npys1/YLFzRHO0SeIPg0
         LcLSgHgFlSXIunmL1uqu7hSKKhrP9uzD8YmcPfVHpwlaDDj4zzCzrqG/kTyzVzX+JXHO
         pp0KliepmtnLX2KpLGIBcXgd8rvCR8qTFl5pVG6VT7rkxG2fJVbdc3C+H5iMNmBafoZh
         Sejg==
X-Gm-Message-State: AOJu0YxC14A12tE8pW5R3jrgsmALWjfUYh+P3sDVUGBP5VHXG5BD879S
	11yvHgfOYqH0kHibzabw6LNSXw0ILbXHJp4IIJTwFUY9Jf1Ij8H+RO0Nh/fxo7n6tl5oq8tlLbd
	GAOpXMbo=
X-Gm-Gg: ATEYQzzFOv6ivd+iKPjy8GiJmJVIWoi6b15HbcRHfJ45kU0br/FLVXaIv373ut4Vw7w
	tH+kfDyc5701Tvjb1hj8duCeFq58OhBqillqPitJBPjEh4/DBXKXldlqz8YR3CBvDNcynLDFqBd
	AzoumYiwwtpWJ6awULVJgEylDBXAdcpo6mzN9fTDyd6OCJow5OlqTbDVc3GHA5ixV0t/lRrTjKJ
	q/oLJ5zT9mqUb1WMVFEPHLbj+jr+kwqKevKUNPCAtoyVZUUEYJH4HSYYX85gPh8PrF8jLI8ozAs
	PDUMf2KF6o+2+erScQ3kck3hR3FrexOAlQ5GiC98gVRyaS+agcXO2yVTpHiJTIeaRHXl1ThDiRT
	eil86e3pPTeHNZBSY/9tB5e/JY5FY8u7iD53sAsvfpLXH3CuKPriU7OOXC9uKt+qFCbvKcKqYmH
	9k3Srmng2ZXX71/joXIRsbFvILQ6CNK+O2
X-Received: by 2002:a17:903:f84:b0:2ae:b9cd:d2ce with SMTP id d9443c01a7336-2aecaaad664mr42537995ad.27.1773436616445;
        Fri, 13 Mar 2026 14:16:56 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece81afccsm31204195ad.68.2026.03.13.14.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 14:16:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 01/12] selftests: net: add netem qdisc test
Date: Fri, 13 Mar 2026 14:15:01 -0700
Message-ID: <20260313211646.12549-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313211646.12549-1-stephen@networkplumber.org>
References: <20260313211646.12549-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.56 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-267604-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim,networkplumber.org:email,networkplumber.org:mid,netfilter.org:email,netem.sh:url]
X-Rspamd-Queue-Id: 37F4C28A152
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a selftest for the netem network emulator qdisc covering basic
functionality, multi-netem qdisc trees, inner qdisc combinations,
and crash resistance under adversarial configurations.

The test validates that HTB and HFSC parents work correctly with netem
children including duplication, which exercises the code paths involved
in CVE-2024-45016, CVE-2025-37890, CVE-2025-38001, and CVE-2025-38553.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS                          |   1 +
 tools/testing/selftests/net/Makefile |   1 +
 tools/testing/selftests/net/config   |   3 +
 tools/testing/selftests/net/netem.sh | 802 +++++++++++++++++++++++++++
 4 files changed, 807 insertions(+)
 create mode 100755 tools/testing/selftests/net/netem.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index ff6f17458f19..60be4001c0cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18225,6 +18225,7 @@ M:	Stephen Hemminger <stephen@networkplumber.org>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	net/sched/sch_netem.c
+F:	tools/testing/selftests/net/netem*
 
 NETFILTER
 M:	Pablo Neira Ayuso <pablo@netfilter.org>
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index a24ea64e2ae8..605566b4db21 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -62,6 +62,7 @@ TEST_PROGS := \
 	ndisc_unsolicited_na_test.sh \
 	netdev-l2addr.sh \
 	netdevice.sh \
+	netem.sh \
 	netns-name.sh \
 	netns-sysctl.sh \
 	nl_netdev.py \
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index cd49b7dfe216..8678f4a346bc 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -96,6 +96,9 @@ CONFIG_NET_SCH_ETF=m
 CONFIG_NET_SCH_FQ=m
 CONFIG_NET_SCH_FQ_CODEL=m
 CONFIG_NET_SCH_HTB=m
+CONFIG_NET_SCH_HFSC=m
+CONFIG_NET_SCH_SFQ=m
+CONFIG_NET_SCH_TBF=m
 CONFIG_NET_SCH_INGRESS=m
 CONFIG_NET_SCH_NETEM=y
 CONFIG_NET_SCH_PRIO=m
diff --git a/tools/testing/selftests/net/netem.sh b/tools/testing/selftests/net/netem.sh
new file mode 100755
index 000000000000..7da18429c4ff
--- /dev/null
+++ b/tools/testing/selftests/net/netem.sh
@@ -0,0 +1,802 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test netem qdisc focusing on:
+#   - valid multi-netem trees (HTB, HFSC parents)
+#   - packet duplication under various topologies
+#   - robustness against misconfigurations that previously caused
+#     soft lockups, OOM, or UAF (syzkaller-class inputs)
+#
+# These tests do NOT validate statistical accuracy of delay/loss
+# distributions; they verify the kernel doesn't crash and that
+# packets actually flow (or are cleanly dropped) under each config.
+#
+# Author: Stephen Hemminger <stephen@networkplumber.org>
+
+source lib.sh
+
+NSPREFIX="netem-test"
+NS_SRC="${NSPREFIX}-src"
+NS_DST="${NSPREFIX}-dst"
+
+VETH_SRC="veth-src"
+VETH_DST="veth-dst"
+
+SRC_IP="192.168.99.1"
+DST_IP="192.168.99.2"
+
+# How long to wait for a potentially-stuck kernel (seconds)
+LOCKUP_TIMEOUT=15
+
+PASS=0
+FAIL=0
+SKIP=0
+
+cleanup()
+{
+	ip netns del "$NS_SRC" 2>/dev/null
+	ip netns del "$NS_DST" 2>/dev/null
+}
+
+setup()
+{
+	cleanup
+
+	ip netns add "$NS_SRC" || return $ksft_skip
+	ip netns add "$NS_DST" || return $ksft_skip
+
+	ip -n "$NS_SRC" link add "$VETH_SRC" type veth \
+		peer name "$VETH_DST" netns "$NS_DST" || return $ksft_skip
+
+	ip -n "$NS_SRC" addr add "${SRC_IP}/24" dev "$VETH_SRC"
+	ip -n "$NS_DST" addr add "${DST_IP}/24" dev "$VETH_DST"
+
+	ip -n "$NS_SRC" link set "$VETH_SRC" up
+	ip -n "$NS_DST" link set "$VETH_DST" up
+
+	ip -n "$NS_SRC" link set lo up
+	ip -n "$NS_DST" link set lo up
+
+	# Sanity: can we ping at all?
+	ip netns exec "$NS_SRC" ping -c 1 -W 2 "$DST_IP" >/dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		echo "# SKIP: basic connectivity failed"
+		return $ksft_skip
+	fi
+
+	return 0
+}
+
+# Reset qdisc on src veth to default (remove any previous test config)
+reset_qdisc()
+{
+	# Remove any existing root qdisc. Must use 'tc' not 'ip'.
+	run_tc qdisc del dev "$VETH_SRC" root 2>/dev/null
+	return 0
+}
+
+# Send ICMP ping traffic and require at least one reply.
+# Uses generous intervals to accommodate delay/loss configs.
+# Usage: send_traffic <count> [timeout]
+send_traffic()
+{
+	local count=${1:-20}
+	local timeout=${2:-10}
+	local received
+
+	received=$(ip netns exec "$NS_SRC" \
+		timeout "$timeout" \
+		ping -c "$count" -i 0.1 -W 2 "$DST_IP" 2>/dev/null |
+		awk '/packets transmitted/ { print $4 }')
+
+	[ "${received:-0}" -gt 0 ] 2>/dev/null
+}
+
+# Send traffic and verify kernel didn't lock up.
+# Returns 0 if kernel survived (regardless of whether traffic arrived).
+# Usage: survive_traffic <count> [timeout]
+survive_traffic()
+{
+	local count=${1:-20}
+	local timeout=${2:-$LOCKUP_TIMEOUT}
+
+	# Use ping as the traffic source — simpler and more reliable
+	# for crash testing. We don't care about replies.
+	ip netns exec "$NS_SRC" \
+		timeout "$timeout" ping -c "$count" -i 0.05 -W 1 "$DST_IP" \
+		>/dev/null 2>&1
+	local rc=$?
+
+	# timeout returns 124 if it had to kill the child
+	if [ $rc -eq 124 ]; then
+		return 1  # kernel likely stuck
+	fi
+
+	return 0
+}
+
+log_result()
+{
+	local result=$1
+	local name=$2
+
+	case $result in
+	0)
+		printf "    PASS: %s\n" "$name"
+		PASS=$((PASS + 1))
+		;;
+	$ksft_skip)
+		printf "    SKIP: %s\n" "$name"
+		SKIP=$((SKIP + 1))
+		;;
+	*)
+		printf "    FAIL: %s\n" "$name"
+		FAIL=$((FAIL + 1))
+		ret=1
+		;;
+	esac
+}
+
+run_cmd()
+{
+	ip netns exec "$NS_SRC" "$@"
+}
+
+run_tc()
+{
+	ip netns exec "$NS_SRC" tc "$@"
+}
+
+# =====================================================================
+# TEST CASES
+# =====================================================================
+
+# --- Group 1: Basic sanity ---
+
+test_basic_delay()
+{
+	local name="basic netem delay"
+
+	reset_qdisc
+	run_tc qdisc replace dev "$VETH_SRC" root netem delay 10ms || {
+		log_result 1 "$name"
+		return
+	}
+
+	if send_traffic 20; then
+		log_result 0 "$name"
+	else
+		log_result 1 "$name"
+	fi
+}
+
+test_basic_duplicate()
+{
+	local name="basic netem duplicate 50%"
+
+	reset_qdisc
+	run_tc qdisc replace dev "$VETH_SRC" root netem delay 10ms duplicate 50% || {
+		log_result 1 "$name"
+		return
+	}
+
+	if send_traffic 20; then
+		log_result 0 "$name"
+	else
+		log_result 1 "$name"
+	fi
+}
+
+test_basic_loss()
+{
+	local name="basic netem loss 30%"
+
+	reset_qdisc
+	run_tc qdisc replace dev "$VETH_SRC" root netem delay 5ms loss 30% || {
+		log_result 1 "$name"
+		return
+	}
+
+	# With 30% loss, 20 packets should still get some through
+	if send_traffic 40; then
+		log_result 0 "$name"
+	else
+		log_result 1 "$name"
+	fi
+}
+
+test_basic_corrupt()
+{
+	local name="basic netem corrupt 10%"
+
+	reset_qdisc
+	run_tc qdisc replace dev "$VETH_SRC" root netem delay 5ms corrupt 10% || {
+		log_result 1 "$name"
+		return
+	}
+
+	if send_traffic 20; then
+		log_result 0 "$name"
+	else
+		log_result 1 "$name"
+	fi
+}
+
+test_basic_reorder()
+{
+	local name="basic netem reorder 25% gap 5"
+
+	reset_qdisc
+	run_tc qdisc replace dev "$VETH_SRC" root netem delay 50ms \
+		reorder 25% 50% gap 5 || {
+		log_result 1 "$name"
+		return
+	}
+
+	if send_traffic 30; then
+		log_result 0 "$name"
+	else
+		log_result 1 "$name"
+	fi
+}
+
+test_pfifo_child()
+{
+	local name="netem with pfifo child qdisc"
+
+	reset_qdisc
+	run_tc qdisc replace dev "$VETH_SRC" root handle 1: \
+		netem delay 10ms 50ms || {
+		log_result 1 "$name"
+		return
+	}
+	run_tc qdisc add dev "$VETH_SRC" parent 1:1 \
+		pfifo limit 1000 || {
+		log_result 1 "$name"
+		return
+	}
+
+	if send_traffic 20; then
+		log_result 0 "$name"
+	else
+		log_result 1 "$name"
+	fi
+}
+
+# --- Group 2: Multi-netem trees (the configs that check_netem_in_tree blocked) ---
+
+test_htb_two_netem_leaves()
+{
+	local name="HTB root, two netem leaves (no dup)"
+
+	reset_qdisc
+	run_tc qdisc replace dev "$VETH_SRC" root handle 1: htb default 10 || {
+		log_result $ksft_skip "$name"
+		return
+	}
+	run_tc class add dev "$VETH_SRC" parent 1: classid 1:10 \
+		htb rate 10mbit || {
+		log_result 1 "$name"
+		return
+	}
+	run_tc class add dev "$VETH_SRC" parent 1: classid 1:20 \
+		htb rate 10mbit || {
+		log_result 1 "$name"
+		return
+	}
+	run_tc qdisc add dev "$VETH_SRC" parent 1:10 handle 10: \
+		netem delay 10ms || {
+		log_result 1 "$name"
+		return
+	}
+	run_tc qdisc add dev "$VETH_SRC" parent 1:20 handle 20: \
+		netem delay 20ms || {
+		log_result 1 "$name"
+		return
+	}
+
+	if send_traffic 20; then
+		log_result 0 "$name"
+	else
+		log_result 1 "$name"
+	fi
+}
+
+test_htb_netem_dup_one_leaf()
+{
+	local name="HTB root, one netem with dup, one without"
+
+	reset_qdisc
+	run_tc qdisc replace dev "$VETH_SRC" root handle 1: htb default 10 || {
+		log_result $ksft_skip "$name"
+		return
+	}
+	run_tc class add dev "$VETH_SRC" parent 1: classid 1:10 \
+		htb rate 10mbit
+	run_tc class add dev "$VETH_SRC" parent 1: classid 1:20 \
+		htb rate 10mbit
+
+	# First leaf: netem with duplication
+	run_tc qdisc add dev "$VETH_SRC" parent 1:10 handle 10: \
+		netem delay 10ms duplicate 25% 2>/dev/null
+	local rc1=$?
+
+	# Second leaf: netem without duplication
+	run_tc qdisc add dev "$VETH_SRC" parent 1:20 handle 20: \
+		netem delay 20ms 2>/dev/null
+	local rc2=$?
+
+	# check_netem_in_tree rejects this valid config — that's a bug.
+	if [ $rc1 -ne 0 ] || [ $rc2 -ne 0 ]; then
+		echo "# tc rejected multi-netem tree (check_netem_in_tree bug)"
+		log_result 1 "$name"
+		return
+	fi
+
+	if send_traffic 20; then
+		log_result 0 "$name"
+	else
+		log_result 1 "$name"
+	fi
+}
+
+test_hfsc_netem_child()
+{
+	local name="HFSC root, netem child (CVE-2025-37890 topology)"
+
+	reset_qdisc
+	run_tc qdisc replace dev "$VETH_SRC" root handle 1: hfsc default 1 || {
+		log_result $ksft_skip "$name"
+		return
+	}
+	run_tc class add dev "$VETH_SRC" parent 1: classid 1:1 \
+		hfsc ls rate 50mbit ul rate 50mbit || {
+		log_result 1 "$name"
+		return
+	}
+	run_tc qdisc add dev "$VETH_SRC" parent 1:1 handle 10: \
+		netem delay 10ms || {
+		log_result 1 "$name"
+		return
+	}
+
+	if send_traffic 30; then
+		log_result 0 "$name"
+	else
+		log_result 1 "$name"
+	fi
+}
+
+test_hfsc_netem_dup()
+{
+	local name="HFSC root, netem child with duplicate"
+
+	reset_qdisc
+	run_tc qdisc replace dev "$VETH_SRC" root handle 1: hfsc default 1 || {
+		log_result $ksft_skip "$name"
+		return
+	}
+	run_tc class add dev "$VETH_SRC" parent 1: classid 1:1 \
+		hfsc ls rate 50mbit ul rate 50mbit
+	run_tc qdisc add dev "$VETH_SRC" parent 1:1 handle 10: \
+		netem delay 10ms duplicate 30%
+
+	if [ $? -ne 0 ]; then
+		echo "# tc rejected HFSC + netem duplicate"
+		log_result $ksft_skip "$name"
+		return
+	fi
+
+	# This is the topology that triggered CVE-2025-37890.
+	# We just need to survive it.
+	if survive_traffic 50; then
+		log_result 0 "$name"
+	else
+		log_result 1 "$name"
+	fi
+}
+
+test_hfsc_two_netem_classes()
+{
+	local name="HFSC root, two classes each with netem"
+
+	reset_qdisc
+	run_tc qdisc replace dev "$VETH_SRC" root handle 1: hfsc default 1 || {
+		log_result $ksft_skip "$name"
+		return
+	}
+	run_tc class add dev "$VETH_SRC" parent 1: classid 1:1 \
+		hfsc ls rate 25mbit ul rate 25mbit
+	run_tc class add dev "$VETH_SRC" parent 1: classid 1:2 \
+		hfsc ls rate 25mbit ul rate 25mbit
+
+	run_tc qdisc add dev "$VETH_SRC" parent 1:1 handle 10: \
+		netem delay 10ms
+	run_tc qdisc add dev "$VETH_SRC" parent 1:2 handle 20: \
+		netem delay 20ms
+
+	if [ $? -ne 0 ]; then
+		log_result $ksft_skip "$name"
+		return
+	fi
+
+	if send_traffic 30; then
+		log_result 0 "$name"
+	else
+		log_result 1 "$name"
+	fi
+}
+
+# --- Group 3: Inner qdisc combinations ---
+
+test_netem_tbf_child()
+{
+	local name="netem with TBF child (non-work-conserving)"
+
+	reset_qdisc
+	run_tc qdisc replace dev "$VETH_SRC" root handle 1: \
+		netem delay 10ms || {
+		log_result $ksft_skip "$name"
+		return
+	}
+
+	# TBF as inner qdisc — previously caused stalls with
+	# some parent qdiscs. As a direct child of netem, the
+	# expectation is packets flow (possibly rate-limited).
+	run_tc qdisc add dev "$VETH_SRC" parent 1:1 handle 10: \
+		tbf rate 1mbit burst 10kb latency 50ms || {
+		log_result $ksft_skip "$name"
+		return
+	}
+
+	if survive_traffic 20; then
+		log_result 0 "$name"
+	else
+		log_result 1 "$name"
+	fi
+}
+
+test_htb_netem_tbf_chain()
+{
+	local name="HTB -> netem -> TBF chain"
+
+	reset_qdisc
+	run_tc qdisc replace dev "$VETH_SRC" root handle 1: htb default 10 || {
+		log_result $ksft_skip "$name"
+		return
+	}
+	run_tc class add dev "$VETH_SRC" parent 1: classid 1:10 \
+		htb rate 5mbit
+	run_tc qdisc add dev "$VETH_SRC" parent 1:10 handle 10: \
+		netem delay 10ms
+	run_tc qdisc add dev "$VETH_SRC" parent 10:1 handle 100: \
+		tbf rate 1mbit burst 10kb latency 50ms
+
+	if [ $? -ne 0 ]; then
+		log_result $ksft_skip "$name"
+		return
+	fi
+
+	# This is a historically problematic config. Just surviving is success.
+	if survive_traffic 30; then
+		log_result 0 "$name"
+	else
+		log_result 1 "$name"
+	fi
+}
+
+test_netem_sfq_child()
+{
+	local name="netem with SFQ child qdisc"
+
+	reset_qdisc
+	run_tc qdisc replace dev "$VETH_SRC" root handle 1: \
+		netem delay 10ms || {
+		log_result 1 "$name"
+		return
+	}
+	run_tc qdisc add dev "$VETH_SRC" parent 1:1 handle 10: \
+		sfq perturb 10 || {
+		log_result $ksft_skip "$name"
+		return
+	}
+
+	if send_traffic 20; then
+		log_result 0 "$name"
+	else
+		log_result 1 "$name"
+	fi
+}
+
+# --- Group 4: Abuse / crash resistance ---
+
+test_dup_100_percent()
+{
+	local name="netem duplicate 100% (stress)"
+
+	reset_qdisc
+	run_tc qdisc replace dev "$VETH_SRC" root netem delay 5ms duplicate 100% || {
+		log_result 1 "$name"
+		return
+	}
+
+	# 100% dup means every packet cloned. Must not explode.
+	if survive_traffic 30; then
+		log_result 0 "$name"
+	else
+		log_result 1 "$name"
+	fi
+}
+
+test_dup_100_no_delay()
+{
+	local name="netem duplicate 100% with zero delay"
+
+	reset_qdisc
+	run_tc qdisc replace dev "$VETH_SRC" root netem duplicate 100% || {
+		log_result 1 "$name"
+		return
+	}
+
+	# Zero delay + 100% dup is a degenerate case
+	if survive_traffic 30; then
+		log_result 0 "$name"
+	else
+		log_result 1 "$name"
+	fi
+}
+
+test_all_impairments()
+{
+	local name="netem all impairments simultaneously"
+
+	reset_qdisc
+	run_tc qdisc replace dev "$VETH_SRC" root netem \
+		delay 10ms 5ms 25% \
+		loss 10% \
+		duplicate 10% \
+		corrupt 5% \
+		reorder 5% 50% || {
+		log_result 1 "$name"
+		return
+	}
+
+	if survive_traffic 50; then
+		log_result 0 "$name"
+	else
+		log_result 1 "$name"
+	fi
+}
+
+test_rapid_reconfig()
+{
+	local name="rapid qdisc add/change/delete cycling"
+
+	reset_qdisc
+
+	# Rapidly add, change, and delete netem config while traffic runs.
+	# This is the kind of thing syzkaller does.
+	ip netns exec "$NS_SRC" ping -c 100 -i 0.02 -W 1 "$DST_IP" \
+		>/dev/null 2>&1 &
+	local traffic_pid=$!
+
+	local i
+	for i in $(seq 1 20); do
+		run_tc qdisc replace dev "$VETH_SRC" root netem delay 5ms \
+			duplicate 10% 2>/dev/null
+		run_tc qdisc change dev "$VETH_SRC" root netem delay 10ms \
+			loss 5% 2>/dev/null
+		run_tc qdisc change dev "$VETH_SRC" root netem delay 1ms \
+			duplicate 50% 2>/dev/null
+		run_tc qdisc del dev "$VETH_SRC" root 2>/dev/null
+	done
+
+	wait $traffic_pid 2>/dev/null
+
+	# If we got here, the kernel didn't lock up
+	log_result 0 "$name"
+}
+
+test_limit_1()
+{
+	local name="netem limit 1 with duplication"
+
+	reset_qdisc
+	# Minimal queue limit with duplication — exercises the
+	# t_len >= sch->limit drop path in enqueue
+	run_tc qdisc replace dev "$VETH_SRC" root netem \
+		limit 1 delay 10ms duplicate 50% || {
+		log_result 1 "$name"
+		return
+	}
+
+	# Most packets will be dropped, but kernel must survive
+	if survive_traffic 30; then
+		log_result 0 "$name"
+	else
+		log_result 1 "$name"
+	fi
+}
+
+test_slot_config()
+{
+	local name="netem slot configuration"
+
+	reset_qdisc
+	run_tc qdisc replace dev "$VETH_SRC" root netem \
+		delay 10ms slot 20ms 40ms packets 5 bytes 1500 || {
+		# slot may not be supported on old kernels
+		log_result $ksft_skip "$name"
+		return
+	}
+
+	if send_traffic 30; then
+		log_result 0 "$name"
+	else
+		log_result 1 "$name"
+	fi
+}
+
+test_rate_limiting()
+{
+	local name="netem rate limiting"
+
+	reset_qdisc
+	run_tc qdisc replace dev "$VETH_SRC" root netem \
+		delay 10ms rate 1mbit || {
+		log_result 1 "$name"
+		return
+	}
+
+	if send_traffic 20; then
+		log_result 0 "$name"
+	else
+		log_result 1 "$name"
+	fi
+}
+
+# --- Group 5: Multi-netem dup trees (the CVE-2025-38553 triggers) ---
+
+test_htb_two_netem_both_dup()
+{
+	local name="HTB root, two netem leaves both duplicating"
+
+	reset_qdisc
+	run_tc qdisc replace dev "$VETH_SRC" root handle 1: htb default 10 || {
+		log_result $ksft_skip "$name"
+		return
+	}
+	run_tc class add dev "$VETH_SRC" parent 1: classid 1:10 \
+		htb rate 10mbit
+	run_tc class add dev "$VETH_SRC" parent 1: classid 1:20 \
+		htb rate 10mbit
+
+	run_tc qdisc add dev "$VETH_SRC" parent 1:10 handle 10: \
+		netem delay 10ms duplicate 25% 2>/dev/null
+	local rc1=$?
+	run_tc qdisc add dev "$VETH_SRC" parent 1:20 handle 20: \
+		netem delay 10ms duplicate 25% 2>/dev/null
+	local rc2=$?
+
+	if [ $rc1 -ne 0 ] || [ $rc2 -ne 0 ]; then
+		echo "# tc rejected multi-netem dup tree (check_netem_in_tree bug)"
+		log_result 1 "$name"
+		return
+	fi
+
+	# This was the CVE-2025-38553 scenario.
+	# With recursion guard: should survive.
+	# Without: may lock up — that's what the timeout catches.
+	if survive_traffic 50 "$LOCKUP_TIMEOUT"; then
+		log_result 0 "$name"
+	else
+		log_result 1 "$name"
+	fi
+}
+
+test_nested_netem()
+{
+	local name="nested netem (netem inside netem child)"
+
+	reset_qdisc
+	run_tc qdisc replace dev "$VETH_SRC" root handle 1: \
+		netem delay 10ms || {
+		log_result 1 "$name"
+		return
+	}
+	# Try to add netem as child of netem. This is unusual
+	# but shouldn't crash.
+	run_tc qdisc add dev "$VETH_SRC" parent 1:1 handle 10: \
+		netem delay 5ms duplicate 10% 2>/dev/null
+
+	if [ $? -ne 0 ]; then
+		echo "# nested netem rejected by kernel (check_netem_in_tree bug)"
+		log_result 1 "$name"
+		return
+	fi
+
+	if survive_traffic 30; then
+		log_result 0 "$name"
+	else
+		log_result 1 "$name"
+	fi
+}
+
+# =====================================================================
+# MAIN
+# =====================================================================
+
+trap cleanup EXIT
+
+ret=0
+
+# Check prerequisites
+if [ "$(id -u)" -ne 0 ]; then
+	echo "SKIP: must be run as root"
+	exit $ksft_skip
+fi
+
+for tool in tc ip ping; do
+	if ! command -v "$tool" >/dev/null 2>&1; then
+		echo "SKIP: $tool not found"
+		exit $ksft_skip
+	fi
+done
+
+# Check kernel has netem
+if ! ip netns add "${NSPREFIX}-probe" 2>/dev/null; then
+	echo "SKIP: network namespaces not available"
+	exit $ksft_skip
+fi
+ip netns exec "${NSPREFIX}-probe" \
+	tc qdisc add dev lo root netem delay 1ms 2>/dev/null
+if [ $? -ne 0 ]; then
+	ip netns del "${NSPREFIX}-probe"
+	echo "SKIP: netem qdisc not available (CONFIG_NET_SCH_NETEM)"
+	exit $ksft_skip
+fi
+ip netns del "${NSPREFIX}-probe"
+
+setup
+if [ $? -eq $ksft_skip ]; then
+	echo "SKIP: setup failed"
+	exit $ksft_skip
+fi
+
+# Group 1: Basic sanity
+test_basic_delay
+test_basic_duplicate
+test_basic_loss
+test_basic_corrupt
+test_basic_reorder
+test_pfifo_child
+
+# Group 2: Multi-netem trees
+test_htb_two_netem_leaves
+test_htb_netem_dup_one_leaf
+test_hfsc_netem_child
+test_hfsc_netem_dup
+test_hfsc_two_netem_classes
+
+# Group 3: Inner qdisc combos
+test_netem_tbf_child
+test_htb_netem_tbf_chain
+test_netem_sfq_child
+
+# Group 4: Abuse / crash resistance
+test_dup_100_percent
+test_dup_100_no_delay
+test_all_impairments
+test_rapid_reconfig
+test_limit_1
+test_slot_config
+test_rate_limiting
+
+# Group 5: Multi-netem dup (CVE triggers)
+test_htb_two_netem_both_dup
+test_nested_netem
+
+echo
+echo "Summary: $PASS pass, $FAIL fail, $SKIP skip"
+
+exit $ret
-- 
2.51.0


