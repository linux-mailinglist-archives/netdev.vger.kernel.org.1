Return-Path: <netdev+bounces-260021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JsQLMxJnGmODAQAu9opvQ
	(envelope-from <netdev+bounces-260021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:36:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA48176297
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD3B8302BEAE
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293BE35CB8F;
	Mon, 23 Feb 2026 12:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="Wlc8h9M2"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97181D5170
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850137; cv=pass; b=r1GiQdl4hYKK/c/C2kHWSZJsf8aJWnx6VNy1CMBW9B6SDW89hMctZvzC2UWpX/azc/hide5X84Exuh30eufxxr3QjYfStMuMcBDZgX5lUgMhFI9fsCvuNuV0PS47LDWBl25cUlsLionQsCgwQHXyPqNKJlLfLYxfEPacGE5aI44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850137; c=relaxed/simple;
	bh=KHcFVrPdUh0yBFFsnP1uV3ZVuZDr2OxfyEAVkDB6y/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIgWosJgwxT8h/RiUGxPZoSSOWX4HkugNS0e5xgHPjUQklJ/4sidB4GAwGZzJwgPn7wEjNgxfyJk6SDUTVlQ9dd1Rceruj8ZFmsiLSoqYjsY/gMZ2lgd1F04YqnQi9Y/SCljkC/LQdNGWqkgee++CKaMKcYzBQLUr/BL0BYIAtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=Wlc8h9M2; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1771850083; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MDwmLhPnV2NCb554RK1+QY9nYI+P0xYNMwWOh3rjVNIrIpB2wtx8Tr52gP7g5abMJTQ94HXaRla0N2aGmHj/YYb9Ct6IC3BSn55X4J5hFdKuE/xt19NfW0xPz5yaBNag5QjfGDcIX051wu/dFwYvMCHpmuGFuBrOsrSAXI+y2rY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771850083; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=trkTZqOxlPzl7mbWG9PT8ZcCPYzjDw5wBy0DTK8r9mc=; 
	b=cn2J3uaJSmxFzWe02N+C/c3iTtG42Pb3vz5uKaAZ0C1lwHTvIK+mnaE/2uclaUW580xNyv7rXPwywZ5SvL8XFp+RIm77Nr4vdwc9BlIY5PTXPB5edT84Mdm3ZT4mPcy9ULvv+iUh42qgzIq/o4C1mTN61K5OvlQoDC80ZSOaY2w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771850083;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=trkTZqOxlPzl7mbWG9PT8ZcCPYzjDw5wBy0DTK8r9mc=;
	b=Wlc8h9M239b8/TtYs4ESPydu/wpHo8OZrWAQC3zmjqDC+Zh0d+YDGNHkzPSTzISE
	Qbw+aJ6qfBvO5jTdfu5ki38I62w8SW90T0VA/yyuEKOrhDj0BjSDyvCJY5auLemfd0I
	7RPKmrDFBOYB99GmoBb7jsPF48lMVwiP16Iy20yYQOg2m5wndJYQpkHZL5FmEMQBjIK
	BLsYaxUhVuuCCpo9yimhtimL5nFJHNuAxMBPZkw9QKPiAgmn8lR40Mvcs2RxM9XLJX8
	lJS4MxF2+Y+B9t4UeXVWomyQQKq4LDqBmawexJI5D7B3nPH32FtC+bvJP1sHVBoZ36U
	hDFTdJ6PQQ==
Received: by mx.zohomail.com with SMTPS id 1771850081699529.0701457010954;
	Mon, 23 Feb 2026 04:34:41 -0800 (PST)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	maciek@machnikowski.net,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev
Subject: [PATCH v2 net-next 3/3] selftests:net: Implement ptp4l sync test using netdevsim
Date: Sun, 22 Feb 2026 10:41:10 +0100
Message-ID: <20260222094110.127927-4-maciek@machnikowski.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222094110.127927-1-maciek@machnikowski.net>
References: <20260222094110.127927-1-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[26];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[machnikowski.net:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,machnikowski.net,gmail.com,intel.com,lunn.ch,linux.dev];
	TAGGED_FROM(0.00)[bounces-260021-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[machnikowski.net];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,machnikowski.net:mid,machnikowski.net:dkim,machnikowski.net:email,lib.sh:url]
X-Rspamd-Queue-Id: 2AA48176297
X-Rspamd-Action: no action

Add PTP synchronization test using ptp4l and netdevsim.

The test creates two netdevsim adapters, links them together
and runs the ptp4l leader and ptp4l follower on two ends
of the netdevsim link and waits for the follower to report the
synchronized state (s2) in its output log.

This implementation runs the test runs over IPv4 link.

Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
---
 tools/testing/selftests/net/ptp.sh | 93 ++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100755 tools/testing/selftests/net/ptp.sh

diff --git a/tools/testing/selftests/net/ptp.sh b/tools/testing/selftests/net/ptp.sh
new file mode 100755
index 000000000..8b1604b96
--- /dev/null
+++ b/tools/testing/selftests/net/ptp.sh
@@ -0,0 +1,93 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
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
+	NSIM_DEV_1_NAME=$(create_netdevsim $NSIM_DEV_1_ID nssv)
+	NSIM_DEV_2_NAME=$(create_netdevsim $NSIM_DEV_2_ID nscl)
+
+	ip netns exec nssv ip addr add '192.168.1.1/24' dev $NSIM_DEV_1_NAME
+	ip netns exec nscl ip addr add '192.168.1.2/24' dev $NSIM_DEV_2_NAME
+
+	set +e
+}
+
+cleanup()
+{
+	[ -n "${PTP4L_LEADER_PID-}" ] && {
+		kill $PTP4L_LEADER_PID $PTP4L_FOLLOWER_PID 2>/dev/null
+		wait $PTP4L_LEADER_PID $PTP4L_FOLLOWER_PID 2>/dev/null
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
+###
+### Code start
+###
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
+NSIM_DEV_1_IFIDX=$(ip netns exec nssv cat /sys/class/net/$NSIM_DEV_1_NAME/ifindex)
+
+NSIM_DEV_2_FD=$((512 + RANDOM % 256))
+exec {NSIM_DEV_2_FD}</var/run/netns/nscl
+NSIM_DEV_2_IFIDX=$(ip netns exec nscl cat /sys/class/net/$NSIM_DEV_2_NAME/ifindex)
+
+if ! echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:$NSIM_DEV_2_IFIDX" > "$NSIM_DEV_SYS_LINK"; then
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
+for _ in $(seq 1 $PTP4L_SYNC_TIMEOUT); do
+	if grep -q ' s2 ' "$PTP4L_FOLLOWER_LOG" 2>/dev/null; then
+		exit 0
+	fi
+	sleep 1
+done
+
+echo "ptp4l follower did not reach locked state (s2) within ${PTP4L_SYNC_TIMEOUT}s"
+exit 1
\ No newline at end of file
-- 
2.53.0


