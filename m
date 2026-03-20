Return-Path: <netdev+bounces-269944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGQ/NdpdvWl09QIAu9opvQ
	(envelope-from <netdev+bounces-269944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:46:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A10272DBFF2
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2B61304C85A
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9018627AC57;
	Fri, 20 Mar 2026 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="S6h+IxUc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A95C3CE492
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017735; cv=none; b=C9+g5kpwew9WpHDpZFDesN4B9rruwJ1dHV2dzAblG/HO/5HR0p4GbZjUFL6b5dpAc8/keny2KbAjgaCup/k/0ZIGt14hxg+Z71cdZ/9MQJyknCLOlBINHmC+YfekC5EKQn2N82LA1vdY6HMJWnPZRkqGSGX3wWDKuDxKI8gZ3DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017735; c=relaxed/simple;
	bh=gZOdfjY1VvR5IwPQ4DlYdoa0l2KwYEyHRE+QSQfPXrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQhzvzPsioZuPNIaN5WHSjxGWcTMNtRoIK605k3Rw7wMSQNijHCf6LVHNuXDWFgAdddgYhfmL+z/OsF9ay+Dnx95rxhm4lNSq2qzIJ/E6qm4qQf48yMLFcfixlNsWGPte9UgbEhcFnFSu9hhzUUP4e+K+vOkN3wcaomyPiNiLuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=S6h+IxUc; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35a094cc3e9so1304812a91.3
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774017733; x=1774622533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnLqUf8eREw2cxnnLAXHgQIdPczp+LnKWCZ2auovkBA=;
        b=S6h+IxUcDve7CSroRjQdoXgfJSHNJPrX0b2pIxo84kxe3092NVaQB59jjcU4Xkjp0a
         vX5ULqbDlLDCUe1i1GsP5JG2O4/CeJ01QJqvTmq9xFKtgVc3aKOrt38w4jnq34rUjT65
         GVuk9LF0eW1s5sZBtzd6l6AugFUAeS0xlvR7d98JMSOZJ/86cM65JwZC5HLW9AhsoM5y
         AfWMmg2H8GoE4efGQEig2JWoSkeokRtKnmWaKhJlhooEuquadPQ3AH/H+1hOKNqqZCJw
         GpiP/AB68pfW+AZ32xrOfyeoIOnHPoWvfEuc2toCRBgpOeGLJBTBMM5y1HigL6uuw/f9
         UJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774017733; x=1774622533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mnLqUf8eREw2cxnnLAXHgQIdPczp+LnKWCZ2auovkBA=;
        b=R/iTSDASdaf2j7P72LWEpSau52UfTq7n+q5Sy1E+kOhnJYjrjebmK6q33HDXrBGzSY
         UCULEpwYygyHHgIjFuXlwBRekdI2bp1TFG33MNsXMZt5hgCihgtwjsobwzI1ABvubogb
         DoeyM+fkRyeUzyNgna82CeLA935ZqlcQ85oQaF/AZMezTtUv9MlyWVits83QWDidUwCX
         TZHjH4IjxVGYYtXnojWaqJtsV5Gw9xIIzCT/yl6busv36sqXF8Kmc+YB+dbuTrlCICQU
         MYGHqh9B1c/CbeFhdXqYJDqYQppacCiU3241wOhbAszEfJ0m5eXI8gyNAxFRt6mSS8uE
         E31Q==
X-Gm-Message-State: AOJu0YytKuMkgrUdnHdpmsGs3cqFDhwDGHTQ3ZxFGSoh9OYN9hf3SwnR
	MOhrTiKuYtyqsfNJ+t6n6bnHP4ev0mgYLhiTyOk0KIif4fLlQGpp4yGu404jocDG51jKh2+a5TR
	QESr1C4U=
X-Gm-Gg: ATEYQzzEGxy5BgaLMKeVwGhINEULoMlo9Cc9WkSxyBkBYbdUC5osnBszOTzUWajrhBu
	H4oNlJGU/Biupynhzbmm3fdHngnuqxPO6Pa999z2q6SyYRfrFxdNIIIRzPoz+ByoIuj7VUCisSK
	t+qozxzzRl3ad3r0m6ln+HQlnzl0Biop1YDjO8fu8ZB/kN7dss67Yy7MgTquC+yVkap8Q5oa+Is
	XFpQ4uSsxX+/2LhKQuGQh5IIctqMvCirVeZqQwxGRu+h294jp0EFo/zvQk/jmzuLTQevBmNNzNJ
	EI4d/+s86pERllcexRq60cH04+CKaQjlGv22bjOwin9g1vMDKVidmpsHk0R748KrttruFanhqDP
	yzORIrq7fH9/+5nZfnRIV8HA86/U/rAk1KwTppRd+fYlXMno5zUbYpkoGPV7G7PFwXyVaRYfkXg
	4TrNZX
X-Received: by 2002:a17:90b:5584:b0:359:8e1c:53e with SMTP id 98e67ed59e1d1-35bd2d3b94emr2258575a91.31.1774017733134;
        Fri, 20 Mar 2026 07:42:13 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc610c1efsm5621687a91.14.2026.03.20.07.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:42:12 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>,
	linux-kselftest@vger.kernel.org
Subject: [net-next v4 12/12] selftests: drv-net: Add USO test
Date: Fri, 20 Mar 2026 07:41:33 -0700
Message-ID: <20260320144141.260246-13-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320144141.260246-1-joe@dama.to>
References: <20260320144141.260246-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-269944-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.982];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20230601.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dama.to:email,dama.to:mid,uso.py:url]
X-Rspamd-Queue-Id: A10272DBFF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a simple test for USO. Can be used with netdevsim or real hardware.
Tests both ipv4 and ipv6 with several full segments and a partial
segment.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v4:
   - Fix python linter issues (unused imports, docstring, etc).

 rfcv2:
   - new in rfcv2

 tools/testing/selftests/drivers/net/Makefile |  1 +
 tools/testing/selftests/drivers/net/uso.py   | 96 ++++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/uso.py

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 8154d6d429d3..800065fe443f 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -22,6 +22,7 @@ TEST_PROGS := \
 	ring_reconfig.py \
 	shaper.py \
 	stats.py \
+	uso.py \
 	xdp.py \
 # end of TEST_PROGS
 
diff --git a/tools/testing/selftests/drivers/net/uso.py b/tools/testing/selftests/drivers/net/uso.py
new file mode 100755
index 000000000000..2ddeae99b4d6
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/uso.py
@@ -0,0 +1,96 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Test USO
+
+Sends large UDP datagrams with UDP_SEGMENT and verifies that the peer
+receives the correct number of individual segments with correct sizes.
+"""
+import socket
+import time
+
+from lib.py import ksft_run, ksft_exit, KsftSkipEx
+from lib.py import ksft_ge
+from lib.py import NetDrvEpEnv
+from lib.py import defer, ethtool, ip, rand_port
+
+# python doesn't expose this constant, so we need to hardcode it to enable UDP
+# segmentation for large payloads
+UDP_SEGMENT = 103
+
+
+def _send_uso(cfg, ipver, mss, total_payload, port):
+    if ipver == "4":
+        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
+        dst = (cfg.remote_addr_v["4"], port)
+    else:
+        sock = socket.socket(socket.AF_INET6, socket.SOCK_DGRAM)
+        dst = (cfg.remote_addr_v["6"], port)
+
+    sock.setsockopt(socket.IPPROTO_UDP, UDP_SEGMENT, mss)
+    payload = bytes(range(256)) * ((total_payload // 256) + 1)
+    payload = payload[:total_payload]
+    sock.sendto(payload, dst)
+    sock.close()
+    return payload
+
+
+def _get_rx_packets(cfg):
+    stats = ip(f"-s link show dev {cfg.remote_ifname}",
+               json=True, host=cfg.remote)[0]
+    return stats['stats64']['rx']['packets']
+
+
+def _test_uso(cfg, ipver, mss, total_payload):
+    cfg.require_ipver(ipver)
+
+    try:
+        ethtool(f"-K {cfg.ifname} tx-udp-segmentation on")
+    except Exception as exc:
+        raise KsftSkipEx(
+            "Device does not support tx-udp-segmentation") from exc
+    defer(ethtool, f"-K {cfg.ifname} tx-udp-segmentation off")
+
+    expected_segs = (total_payload + mss - 1) // mss
+
+    rx_before = _get_rx_packets(cfg)
+
+    port = rand_port(stype=socket.SOCK_DGRAM)
+    _send_uso(cfg, ipver, mss, total_payload, port)
+
+    time.sleep(0.5)
+
+    rx_after = _get_rx_packets(cfg)
+    rx_delta = rx_after - rx_before
+
+    ksft_ge(rx_delta, expected_segs,
+            comment=f"Expected >= {expected_segs} rx packets, got {rx_delta}")
+
+
+def test_uso_v4(cfg):
+    """USO IPv4: 11 segments (10 full + 1 partial)."""
+    _test_uso(cfg, "4", 1400, 1400 * 10 + 500)
+
+
+def test_uso_v6(cfg):
+    """USO IPv6: 11 segments (10 full + 1 partial)."""
+    _test_uso(cfg, "6", 1400, 1400 * 10 + 500)
+
+
+def test_uso_v4_exact(cfg):
+    """USO IPv4: exact multiple of MSS (5 full segments)."""
+    _test_uso(cfg, "4", 1400, 1400 * 5)
+
+
+def main() -> None:
+    """Run USO tests."""
+    with NetDrvEpEnv(__file__) as cfg:
+        ksft_run([test_uso_v4,
+                  test_uso_v6,
+                  test_uso_v4_exact],
+                 args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.52.0


