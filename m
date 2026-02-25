Return-Path: <netdev+bounces-261019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAMBLK0an2kzZAQAu9opvQ
	(envelope-from <netdev+bounces-261019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:52:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D52C19A028
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74F1830D0525
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CA83E8C4D;
	Wed, 25 Feb 2026 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="bmgw4dBT"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839A93D3314
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772033997; cv=pass; b=r1jU7WQ1n4SeMdkWrE3EbTOetWQTwHI3cvfuPV6bNqQsr2OjipRSEqcfHPJr91Iy7cURjiowaLDZ6BfUpYwI0bM6TPu3usZwkbkEnRFGTAXFxMYG5xE32Ncodh0alQpL7G55z/5KCBMS7NMci88qXjZwAMHG5ojR8FjvtVDFwfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772033997; c=relaxed/simple;
	bh=+7OfSqVl2JRMxe+6A+3HIBmjGoXVouUjJsi0i08PFFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phAKpIJJcaRA8Ss3cRJy9QJ839bm59pVt/TkJRyZZyaNhMBoH2pvLZkXVQMMIzlX1ze+wH+jzQ8c4Gs93TGroaf7Ms+TbI/AK8knDbj53N+6XCqwEo8aOoKOnWhv9WLPtEa7epHJJ6adZ4FSdu0A0K00+XZc0ld3Cz7Cps5vMXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=bmgw4dBT; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1772033952; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=caasC2rZUM74NCYZnKVeLw8g3s2eW1JpFDunKiDWcKYnwYReTCypba5R6wY0Yh7Wz92X0ulIUobTBoLB44ZFUy51DRQHAsW4pzyVPQysGk0mjT3ocvxC8OXLMu/pMBSMENOmWzx4WxI823z/pX6o4S5M1yxHjEn17uv1CXkhhXU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772033952; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bZsVjpj3tS2NcSPeVCwY36YWu9qsHzN4VwqVHxl0Hrc=; 
	b=KxnuNvMy6PTCuLX01J40LXApiq1MRXvYWYyIDo+K7cGBuHdn0jdP06i6TkgLzBBF8MtbOIlnFYNfiC8YVvBsEJMWggdC0UqXQ6rUgWaZbu34C0MYVmqH0upfWpcufr2eQfQZMJGxCyw/Dh58Iq7PB/iF0Fge/EL5NNJaNgdDfco=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772033951;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=bZsVjpj3tS2NcSPeVCwY36YWu9qsHzN4VwqVHxl0Hrc=;
	b=bmgw4dBT3wIw/Clc86Ys7HH12xJexgiZco0zmMy4gJWNvu1s1HK00PTl3zrFEi/n
	QRWcylTaSesf1uE2H7H7BV0Z5Ni3VmHkPY93v/VqLTw0zu0BOPH+igc/gyJLoFCU47f
	kcu8CnM6qT7hSR4KYm1SRqc0o95hwrofJGLFF5u2wspL/WJOrOHXxBiQVi8rNjZWBNz
	m2KomVUTWFTVal0vZToOf/753yiMoMOeYgFM2AuSh1gyG9l8DKKg4ABYmvxd5XYBzAu
	c2o62vitNflggH57LEjFcoTmZu2ezT3t7QsOAh261A2njAnWjOz4jDxVHIQgE7KaVkN
	PQplNEtjRQ==
Received: by mx.zohomail.com with SMTPS id 1772033950667606.3964192503419;
	Wed, 25 Feb 2026 07:39:10 -0800 (PST)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	maciek@machnikowski.net,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev,
	horms@kernel.org
Subject: [PATCH v3 net-next 3/3] selftests:net: Implement ptp4l sync test using netdevsim
Date: Wed, 25 Feb 2026 16:38:58 +0100
Message-ID: <20260225153858.29486-4-maciek@machnikowski.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225153858.29486-1-maciek@machnikowski.net>
References: <20260225153858.29486-1-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[machnikowski.net:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,machnikowski.net,gmail.com,intel.com,lunn.ch,linux.dev];
	DMARC_NA(0.00)[machnikowski.net];
	TAGGED_FROM(0.00)[bounces-261019-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.972];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lib.sh:url,machnikowski.net:mid,machnikowski.net:dkim,machnikowski.net:email,ptp.sh:url]
X-Rspamd-Queue-Id: 0D52C19A028
X-Rspamd-Action: no action

Add PTP synchronization test using ptp4l and netdevsim.

The test creates two netdevsim adapters, links them together
and runs the ptp4l leader and ptp4l follower on two ends
of the netdevsim link and waits for the follower to report the
synchronized state (s2) in its output log.

This implementation runs the test runs over IPv4 link.

Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
---
 tools/testing/selftests/net/Makefile |   1 +
 tools/testing/selftests/net/ptp.sh   | 105 +++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100755 tools/testing/selftests/net/ptp.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index afdea6d95..db576ea96 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -64,6 +64,7 @@ TEST_PROGS := \
 	nl_netdev.py \
 	pmtu.sh \
 	psock_snd.sh \
+	ptp.sh \
 	reuseaddr_ports_exhausted.sh \
 	reuseport_addr_any.sh \
 	route_hint.sh \
diff --git a/tools/testing/selftests/net/ptp.sh b/tools/testing/selftests/net/ptp.sh
new file mode 100755
index 000000000..8e5b3e1e4
--- /dev/null
+++ b/tools/testing/selftests/net/ptp.sh
@@ -0,0 +1,105 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+# shellcheck disable=SC2329
+#
+# By Maciek Machnikowski <maciek@machnikowski.net> (c) 2026,
+#
+# Self-tests for HW timestamping and 1588 synchronization on the netdevsim
+# emulation with ptp_mock.
+#
+# This test:
+# - Creates two netdevsim instances in two separate namespaces
+# - Assigns IPv4 addresses to those instances
+# - Runs ptp4l leader in the nssv namespace using IPv4 traffic
+# - Runs ptp4l follower in the nscl namespace using IPv4 traffic
+# - Waits for the follower to reach synchronized state (s2) or the timeout
+
+source lib.sh
+
+NSIM_DEV_1_ID=$((256 + RANDOM % 256))
+NSIM_DEV_2_ID=$((512 + RANDOM % 256))
+
+NSIM_DEV_SYS_LINK=/sys/bus/netdevsim/link_device
+NSIM_DEV_SYS_UNLINK=/sys/bus/netdevsim/unlink_device
+PTP4L_SYNC_TIMEOUT=20
+
+setup_netdevsim()
+{
+	set -e
+	ip netns add nssv
+	ip netns add nscl
+
+	NSIM_DEV_1_NAME=$(create_netdevsim "$NSIM_DEV_1_ID" "nssv")
+	NSIM_DEV_2_NAME=$(create_netdevsim "$NSIM_DEV_2_ID" "nscl")
+
+	ip netns exec nssv ip addr add '192.168.1.1/24' dev "$NSIM_DEV_1_NAME"
+	ip netns exec nscl ip addr add '192.168.1.2/24' dev "$NSIM_DEV_2_NAME"
+
+	set +e
+}
+
+cleanup()
+{
+	[ -n "${PTP4L_LEADER_PID-}" ] && {
+		kill "$PTP4L_LEADER_PID" "$PTP4L_FOLLOWER_PID" 2>/dev/null
+		wait "$PTP4L_LEADER_PID" "$PTP4L_FOLLOWER_PID" 2>/dev/null
+		rm -f "$PTP4L_LEADER_LOG" "$PTP4L_FOLLOWER_LOG"
+	}
+
+	[ -n "${NSIM_DEV_1_FD-}" ] && [ -n "${NSIM_DEV_1_IFIDX-}" ] && \
+		echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX" > "$NSIM_DEV_SYS_UNLINK" 2>/dev/null
+	cleanup_netdevsim "${NSIM_DEV_2_ID-}" 2>/dev/null
+	cleanup_netdevsim "${NSIM_DEV_1_ID-}" 2>/dev/null
+
+	ip netns del nscl 2>/dev/null
+	ip netns del nssv 2>/dev/null
+
+	modprobe -r netdevsim 2>/dev/null
+}
+
+if [ ! -x "$(command -v ptp4l)" ]; then
+	echo "ptp4l command not found. Skipping PTP sync test"
+	exit 4
+fi
+
+trap cleanup EXIT
+
+setup_netdevsim
+
+# Link netdevsim1 with netdevsim2
+NSIM_DEV_1_FD=$((256 + RANDOM % 256))
+exec {NSIM_DEV_1_FD}</var/run/netns/nssv
+NSIM_DEV_1_IFIDX=$(ip netns exec nssv cat "/sys/class/net/$NSIM_DEV_1_NAME/ifindex")
+
+NSIM_DEV_2_FD=$((512 + RANDOM % 256))
+exec {NSIM_DEV_2_FD}</var/run/netns/nscl
+NSIM_DEV_2_IFIDX=$(ip netns exec nscl cat "/sys/class/net/$NSIM_DEV_2_NAME/ifindex")
+
+if ! echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX" \
+	  "$NSIM_DEV_2_FD:$NSIM_DEV_2_IFIDX" > "$NSIM_DEV_SYS_LINK"; then
+	echo "linking netdevsim1 with netdevsim2 failed"
+	exit 1
+fi
+
+# PTP synchronization test: run ptp4l leader in nssv and follower in nscl,
+# then parse follower output to verify they synchronized (servo state s2 = locked).
+PTP4L_LEADER_LOG=$(mktemp)
+PTP4L_FOLLOWER_LOG=$(mktemp)
+ip netns exec nssv ptp4l -i "$NSIM_DEV_1_NAME" -m -4 -P \
+	> "$PTP4L_LEADER_LOG" 2>&1 &
+PTP4L_LEADER_PID=$!
+
+ip netns exec nscl ptp4l -i "$NSIM_DEV_2_NAME" -s -m -4 -P \
+	> "$PTP4L_FOLLOWER_LOG" 2>&1 &
+PTP4L_FOLLOWER_PID=$!
+
+
+for _ in $(seq 1 "$PTP4L_SYNC_TIMEOUT"); do
+	if grep -q ' s2 ' "$PTP4L_FOLLOWER_LOG" 2>/dev/null; then
+		exit 0
+	fi
+	sleep 1
+done
+
+echo "ptp4l follower did not reach locked state (s2) within ${PTP4L_SYNC_TIMEOUT}s"
+exit 1
-- 
2.53.0


