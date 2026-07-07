Return-Path: <netdev+bounces-305486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dLbCC0QITWqEtwEAu9opvQ
	(envelope-from <netdev+bounces-305486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 16:08:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD18E71C566
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 16:08:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lPmSiGoy;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305486-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305486-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8556A3102C40
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 14:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE5C42378A;
	Tue,  7 Jul 2026 13:59:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2E14229D0
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 13:59:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432789; cv=none; b=PZgc7YX3KCewpEnjMu6+OkRuCeWhnPofVXDqCfSHl7DWoaErx+xJjAf3iR4POhA+gpclU5hotEEjMAPhA63vbe7ZSPji8gnMsBrVecC6nYeN0nhSR+URo4suqF+ahF0+qjjwueeHjkCChHPW3jD5OeiX4QiWdnHCGrWkr49r+B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432789; c=relaxed/simple;
	bh=diUIIKStfenJCEasoEwrp+wCmRi3qtN6/sa0FZ2l7bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBiT2fCVnC+rl/S8BI60hKmoneUMo/JjpN1qaCI8cPGqd8VhWm38g5PEpQHflbx5avT4Pwb1cK0aBhSafzNVbYxJZjl7EHHSSGKgTEycfy5xGN07Bv2yTbA6ZtQ4VfDq4hTCOJagESKuw9VGVeDzSybrhL7UjCKDqS2S57OzhzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPmSiGoy; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-46cea75d96cso430757f8f.1
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 06:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783432785; x=1784037585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Pv4NrN4dYt4KyUEdjIMuVrZU8kjGasmAaF2k9w2Y9c=;
        b=lPmSiGoyhFDbS7HcOq+2dc8CehRpMTJqG4olUxO46l1DAE45xkr+o3eU1Udmvvu+kp
         AKna/0nqJB5daIrN19EdU2b0AqgOpOdJxvQsO2jYvUPcIlbxtvkQRZsbPmGK1uqlhqeK
         u1nXyY2o/hEgskLqXZRR/IRDR0S9l7nKsAv/5o3Hf5JU6F4S0fEUUnWMGLgzPlLIaw68
         y7xqtxNhVz6dHCYgWMSsmgmkCJK9qb4gOhdBmPF40bM3dRyM4eKDNCNB+5zVuutL1Gim
         hLEKU5lKardsozp0w7WnqMVvXpSvsYOVlaviPpNo5lng7k7DEljJ06c7wEqLnRJZh4BF
         SYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783432785; x=1784037585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Pv4NrN4dYt4KyUEdjIMuVrZU8kjGasmAaF2k9w2Y9c=;
        b=CspznbJJuQQvS0dY+c2lz34dpl43QU5jPvoo5QNb2UZarrU+M9qllsMwlMtsWEEUqq
         Jpc3OeXi6YQPvU3Q79/Yqo/VGMBo11iRmsvK7WROmJW9whz97duZzzqxqCU/UHFmwqxH
         3C6LZ9gF6ZWEZPl2w+JAjqCq4cV8lWMkcGxMQhSQP6jpJkRITlu7d8+TuJzWaSGg9zSW
         pREG3xeLrDy8GmvDmQ4UegWpDIvFDkwnLZ3oblJKpl0U2/ElKk1/ZLLw6g368mtvSBbV
         YwbuG1pgsdlTct8QqPLcoVufkSXEFHjzyHLjQpW/7b/D0gcXa2Wer8HA1P5am0FGnaQp
         OCbw==
X-Gm-Message-State: AOJu0YyfsPORNtMxQKSDzsefpy4kGEs8soSO5qRhe+tOwVoN/yGyxRZJ
	9LSgeA5q5MI9A4gMV23evCvMVKPvgnr7PJ2cMdBwAuD1eMGBRrkfYwYE2FPx0HXU
X-Gm-Gg: AfdE7cnLR8LdkGO3acvsY93TIRxsZ7pi8A7wTw0s3SvirNbDSI32dFU9X3Q7/k1h80i
	mHMmuW6Fk+WaRhFZmk2HaFt/FxiyP7CvCSm0VRcd53tz6rBOibVGghDJLfXODY+o1RlO1wyJoQG
	mG3PMJ5GDltR9iMMpRpSI7Xg+ubDOHPBbzfxPRfKxvGPtrbvWUlEJUI8ISs6wwtdIDG3eKrw/IJ
	rDyxEjuJODxXASdWYP9sQiTHIrkGm7EiVdHjGKgTbosYZPRQLQ7Z4E9TfBtz/BAupSqdlmco0NN
	r5zAfYRGHZG0Hpf+A9b138zzXGaaR5oss0CIVGOhPf47WBjVuctIugR1hzvPeUHqOPd72VU2eho
	fnf3jq2CJlpiUhRt5yMaHgOe+Nvtxegm2g9qiG5pQstn7Oa9RkWMiDolTEuIjP5XE29d5yntLVU
	aNAJYgHBkNQiNSsqGyvM7ms4qUxTM0+Msfvsi6RL9t0niyDWNnZ95ZGM2R8LHc6xh2FG8WKGDAP
	Wh5dVU4zriL86+hwBtz8i5q2uAp4QzXhGt3f2RLg0rEgPTMKJjt4878vRfGkg==
X-Received: by 2002:a05:600c:4694:b0:493:e4a0:8e1f with SMTP id 5b1f17b1804b1-493e4a09609mr2760935e9.7.1783432784811;
        Tue, 07 Jul 2026 06:59:44 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-189-165-250.77.189.pool.telefonica.de. [77.189.165.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f40d50sm67409615e9.5.2026.07.07.06.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 06:59:44 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Felix Maurer <fmaurer@redhat.com>,
	Luka Gejak <luka.gejak@linux.dev>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net-next v3 4/4] selftests: net: hsr: add PRP RedBox test
Date: Tue,  7 Jul 2026 15:59:37 +0200
Message-ID: <20260707135937.18-5-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707135937.18-1-xiexinet@gmail.com>
References: <20260707135937.18-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,linux.dev,suse.de,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-305486-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:bigeasy@linutronix.de,m:fmaurer@redhat.com,m:luka.gejak@linux.dev,m:fmancera@suse.de,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xiexinet@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[xiexinet@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiexinet@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,hsr_common.sh:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hsr_prp_redbox.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD18E71C566

Add a kselftest that builds a PRP RedBox (interlink) with a SAN behind the
interlink and a peer DANP, and checks bidirectional unicast across the
interlink, preservation of the SAN source MAC on the PRP network, and that
the proxy-announce supervision frame carries the RedBox-MAC TLV (Type 30)
terminated by an EOT marker. It reuses the hsr_common.sh / lib.sh helpers
and skips cleanly on a kernel or iproute2 without PRP interlink support.

The background ping is killed by its exact PID: ip netns exec does not
isolate the PID namespace, so a pattern-based pkill could hit unrelated
processes on the host.

Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 tools/testing/selftests/net/hsr/Makefile      |  1 +
 .../selftests/net/hsr/hsr_prp_redbox.sh       | 99 +++++++++++++++++++
 2 files changed, 100 insertions(+)
 create mode 100755 tools/testing/selftests/net/hsr/hsr_prp_redbox.sh

diff --git a/tools/testing/selftests/net/hsr/Makefile b/tools/testing/selftests/net/hsr/Makefile
index 31fb9326cf5..2150e487ac7 100644
--- a/tools/testing/selftests/net/hsr/Makefile
+++ b/tools/testing/selftests/net/hsr/Makefile
@@ -4,6 +4,7 @@ top_srcdir = ../../../../..
 
 TEST_PROGS := \
 	hsr_ping.sh \
+	hsr_prp_redbox.sh \
 	hsr_redbox.sh \
 	link_faults.sh \
 	prp_ping.sh \
diff --git a/tools/testing/selftests/net/hsr/hsr_prp_redbox.sh b/tools/testing/selftests/net/hsr/hsr_prp_redbox.sh
new file mode 100755
index 00000000000..479c892225b
--- /dev/null
+++ b/tools/testing/selftests/net/hsr/hsr_prp_redbox.sh
@@ -0,0 +1,99 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test a PRP RedBox (PRP-SAN): a SAN that sits behind the interlink port must
+# reach, and be reached by, a peer DANP on the PRP network with its own MAC
+# preserved on the wire, and the RedBox must announce the SAN with a RedBox-MAC
+# TLV (terminated by an EOT marker) in its PRP supervision frames.
+#
+#   RB    PRP RedBox: prp0 over rb_a/rb_b (LAN A/B) + interlink rb_il
+#   PEER  peer DANP : prp0 over pe_a/pe_b, 100.64.0.2
+#   SAN   SAN       : san_il, own MAC, 100.64.0.51 (behind the interlink)
+
+ipv6=false
+
+source ./hsr_common.sh
+
+check_prerequisites
+
+if ! command -v tcpdump >/dev/null 2>&1; then
+	echo "SKIP: This test requires tcpdump"
+	exit $ksft_skip
+fi
+
+if ! ip link help hsr 2>&1 | grep -q interlink; then
+	echo "SKIP: iproute2 too old (no hsr interlink support)"
+	exit $ksft_skip
+fi
+
+setup_ns RB PEER SAN
+trap 'cleanup_ns "$RB" "$PEER" "$SAN"' EXIT
+
+ip link add rb_a netns "$RB" type veth peer name pe_a netns "$PEER"
+ip link add rb_b netns "$RB" type veth peer name pe_b netns "$PEER"
+ip link add rb_il netns "$RB" type veth peer name san_il netns "$SAN"
+
+ip -n "$RB"   link set rb_a up
+ip -n "$RB"   link set rb_b up
+ip -n "$RB"   link set rb_il up
+ip -n "$PEER" link set pe_a up
+ip -n "$PEER" link set pe_b up
+ip -n "$SAN"  link set san_il up
+ip -n "$SAN"  addr add 100.64.0.51/24 dev san_il
+
+# Feature gate: PRP interlink (RedBox) creation. A kernel without PRP RedBox
+# support rejects this with -EINVAL, so SKIP rather than FAIL.
+if ! ip -n "$RB" link add name prp0 type hsr slave1 rb_a slave2 rb_b \
+     interlink rb_il proto 1 2>/dev/null; then
+	echo "SKIP: kernel without PRP RedBox (interlink) support"
+	exit $ksft_skip
+fi
+ip -n "$RB"   link set prp0 up
+ip -n "$PEER" link add name prp0 type hsr slave1 pe_a slave2 pe_b proto 1
+ip -n "$PEER" link set prp0 up
+ip -n "$PEER" addr add 100.64.0.2/24 dev prp0
+sleep 1
+
+san_mac=$(ip -n "$SAN" -br link show san_il | awk '{print $3}')
+rb_mac=$(ip -n "$RB" -br link show rb_il | awk '{print $3}')
+
+# Bidirectional unicast across the interlink.
+do_ping "$PEER" 100.64.0.51
+do_ping "$SAN"  100.64.0.2
+stop_if_error "PRP RedBox bidirectional unicast failed"
+
+# The SAN source MAC must be preserved on the PRP network, not laundered to the
+# RedBox MAC: the peer resolves the SAN IP to the SAN's own MAC.
+neigh=$(ip -n "$PEER" neigh show 100.64.0.51 | awk '{print $5}')
+if [ "$neigh" != "$san_mac" ]; then
+	echo "SAN MAC preservation [ FAIL ]: peer resolved 100.64.0.51 to" \
+	     "'$neigh', expected $san_mac" 1>&2
+	ret=1
+fi
+stop_if_error "SAN MAC not preserved on the PRP network"
+
+# The proxy-announce supervision frame must carry, in order, the life-check TLV
+# (type 0x14, len 6) + MacAddressA == SAN MAC + the RedBox-MAC TLV (type 0x1e,
+# len 6) + MacAddressRedBox == RedBox MAC + the EOT marker (0x0000).
+ip netns exec "$SAN" ping -i 0.2 -q 100.64.0.2 >/dev/null 2>&1 &
+ping_pid=$!
+cap=$(ip netns exec "$PEER" timeout 5 tcpdump -i pe_a -nn -x \
+	"ether proto 0x88fb and ether src $rb_mac" 2>/dev/null || true)
+kill "$ping_pid" 2>/dev/null || true
+wait "$ping_pid" 2>/dev/null || true
+
+san_hex=$(echo "$san_mac" | tr -d ':')
+rb_hex=$(echo "$rb_mac" | tr -d ':')
+# Reassemble contiguous frame hex: drop the "0x0010:" offset labels and spaces.
+frame_hex=$(echo "$cap" | awk '/^[[:space:]]*0x[0-9a-f]+:/ {
+	sub(/^[[:space:]]*0x[0-9a-f]+:[[:space:]]*/, "");
+	gsub(/ /, ""); printf "%s", $0 }')
+if ! echo "$frame_hex" | grep -q "1406${san_hex}1e06${rb_hex}0000"; then
+	echo "supervision RedBox-MAC TLV [ FAIL ]: missing SAN MAC, Type-30" \
+	     "payload, or EOT" 1>&2
+	ret=1
+fi
+stop_if_error "PRP RedBox supervision RedBox-MAC TLV/EOT check failed"
+
+echo "INFO: PRP RedBox (PRP-SAN) conformance checks passed"
+exit $ret
-- 
2.53.0


