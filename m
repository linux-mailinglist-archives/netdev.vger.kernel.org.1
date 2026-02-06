Return-Path: <netdev+bounces-257473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB5KFcZ8hWlQCQQAu9opvQ
	(envelope-from <netdev+bounces-257473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 06:31:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F295FA5C0
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 06:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FFB13029780
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 05:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE04F335079;
	Fri,  6 Feb 2026 05:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BOuDVXYN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA22288C08
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 05:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770355856; cv=none; b=INHwvSzPBqwZVwrgkVhXN/Urxevl9O0Ev8gbgBBADhTmBMlbqy65ntbpta9eraAla6wpzCAHLucEfVPQcE/MU+JdB967Ab0hTYz0EPD3eVAJLIK++PmqYcavMc4s4tEOnfWKKsASpEqL6WpF9TZbZvWHJfKP6iEeIh/ePgpfIs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770355856; c=relaxed/simple;
	bh=SLE/gf+O4ecABy+44L68k8uPfLvV3udyEhZJhnaVEWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WoCkK1Bh/XlWDCP7dXtTLJ1iSkdrHZCqKX2F+IbXAsIJ6X/BoOJAIRiFCDNzHiUTkf7l1GlN5COqDpz9yhMzCkAAVMhTMScYU6tMmMMT571FRaVlb+6YBPkv8qDOPnmYJt8ZbuMWy56KTs3dZqgofS9HoVzV/vDIM0PrPUvRom4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BOuDVXYN; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-7cfd8ca8191so130791a34.3
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 21:30:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770355855; x=1770960655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wzB7gBp5OGnm8HOCODUdquZN2BSz97bufhK5V426hLY=;
        b=rZAHEtyuMX2GxDmCVuU9Vviy7lbhvlBXqjGsxBRgAdh+2w4kIcPWxv6ppzkB2CkFP2
         OO/9PPhDdKQRXL5cIExS6klOh8ri7HIG8pcBWydTlsGLWwkzyPBsgFxDOBs3/t489vCh
         svul7rvkH1EwoDu4VFjfhCw3g8WcXF/ZgxNr4glqosDwMK0IT7gx5NmodTP0wLdDAj4v
         y8E7mYEOzs5USeH62OH0ipupNRhAgxjNbzAFqNLIpMG23PPjm167ifzAOj0AARvQzRJs
         sl5Dnbu6l/nYxAqjuhQH9SadHBvIzolnEApxnkA0EqEkl/uvTmYcoNDCPlEZOqcWi23e
         fToQ==
X-Gm-Message-State: AOJu0Yy2NU4P5rAlEHSEVPUiUfxjTiNok/6bQqYcKJg/o5cAmU86C9UA
	GSiiUnzjwU2VuPpOvYibs4AB+T1S8VD4Jda0zN4jDbf6F9fPUg1eInzfBycE5a5ALdm1J6AuCAD
	FiHA/5r5fPMPklNIVAEmCDijj2u6xMWc2wXydYGWgPAhdUJxBfSk1m39xmwjcBgj9S833bdVxcK
	guks+Wvl2+zEsufkMsribzA0Ny0E7OL9soLq4GXpv0cUxS8Mrel4znQ+0uRmsvf8fO7D2fnmwDP
	zsC86eu1tc=
X-Gm-Gg: AZuq6aLJjbIZwH5dHge+HMmpUL3lUOX/eqG49njak2vprFHdu+vyoI51X3PU3sk5PCY
	HpH+106mJcEyc7vc0FJcFgmbXAcHzNbnAs0gVlmvD+BNJ42KUvfJMDqbbSVAAjcVKcAiUWmUPAa
	1wUYIMp9mTIA6FjjsAQvsG3RjM/oW8KqUhvhi5R4kPEDWpC7rn++YBinHehP5n9cBy2ZGlKyJa+
	ozfBl4iWvYtOTbCFRxECA12skiP6D+cEDvkbT1hzpdSHdwxxAbN7uaaR1Ee6JDurPTNNi/ZGDja
	PGPo/uGBJoqJZFQmVypOyWbH1BUAvVSQSxv6QrF0nKPpvKuxbxYq2AKNlVUxov4DT+PCaQK6GUr
	QGZ7vH3fpIcnTH54anpzqIb7T/ZNqr9S6f8BBls6cr+mbvfVEqJ9bOdEsZAFgTz/isj3QbvsPBK
	/6GoUoFg0Qa5m3FsFhkLAkK10gexOLjUP6rzsYQ/nk6g==
X-Received: by 2002:a05:6830:6518:b0:7c7:3b3:fdbc with SMTP id 46e09a7af769-7d464424b9emr715818a34.14.1770355855120;
        Thu, 05 Feb 2026 21:30:55 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7d4647748e5sm264362a34.5.2026.02.05.21.30.54
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Feb 2026 21:30:55 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7cfd12d8245so531160a34.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 21:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770355854; x=1770960654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzB7gBp5OGnm8HOCODUdquZN2BSz97bufhK5V426hLY=;
        b=BOuDVXYNZWOgmUqo3jGvqeJHbV0DoK+4xenmrz6XgWozUuwnsefGi+gbJy6uahGvbr
         tCUMpHrL6zTCTr5vJb0/BCNCp5MFvWEvpZU3yB6zBvGSkpGXJI/pDzKShsGloo/p0WD0
         z+wkv+MRlaqrWMH9bwliGSHDLKyZ8x0qxCLDY=
X-Received: by 2002:a05:6830:628c:b0:7cf:d9ba:c980 with SMTP id 46e09a7af769-7d46448205bmr972070a34.17.1770355854032;
        Thu, 05 Feb 2026 21:30:54 -0800 (PST)
X-Received: by 2002:a05:6830:628c:b0:7cf:d9ba:c980 with SMTP id 46e09a7af769-7d46448205bmr972063a34.17.1770355853657;
        Thu, 05 Feb 2026 21:30:53 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4647aa6cbsm903529a34.26.2026.02.05.21.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 21:30:52 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net v2 4/4] selftests: drv-net: rss_ctx: test RSS contexts persist after ifdown/up
Date: Thu,  5 Feb 2026 21:29:30 -0800
Message-ID: <20260206052930.1882740-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260206052930.1882740-1-michael.chan@broadcom.com>
References: <20260206052930.1882740-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257473-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,lib.py:url,rss_ctx.py:url];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9F295FA5C0
X-Rspamd-Action: no action

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Add a test to verify that RSS contexts persist across interface
down/up along with their associated Ntuple fitlers. Another test
that creates contexts/rules keeping interface down and test their
persistence is also added.

Tested on bnxt_en:

 TAP version 13
 1..1
 # timeout set to 0
 # selftests: drivers/net/hw: rss_ctx.py
 # TAP version 13
 # 1..2
 # ok 1 rss_ctx.test_rss_context_persist_create_and_ifdown
 # ok 2 rss_ctx.test_rss_context_persist_ifdown_and_create # SKIP Create context not supported with interface down
 # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:1 error:0

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2: Many improvements suggested by Jakub:
1. simplified the tests to have only 2 contexts, use one of the contexts
to test ntuple filters' persistence also 
2. used @ksft_disruptive for the test
3. used netlink API to get rss contexts

v1: https://lore.kernel.org/netdev/20260129061646.1417185-5-michael.chan@broadcom.com/
---
 .../selftests/drivers/net/hw/rss_ctx.py       | 102 +++++++++++++++++-
 1 file changed, 101 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index ed7e405682f0..f72162ee9dc3 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -4,11 +4,13 @@
 import datetime
 import random
 import re
+import time
 from lib.py import ksft_run, ksft_pr, ksft_exit
 from lib.py import ksft_eq, ksft_ne, ksft_ge, ksft_in, ksft_lt, ksft_true, ksft_raises
 from lib.py import NetDrvEpEnv
 from lib.py import EthtoolFamily, NetdevFamily
 from lib.py import KsftSkipEx, KsftFailEx
+from lib.py import ksft_disruptive
 from lib.py import rand_port
 from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
 
@@ -809,6 +811,102 @@ def test_rss_default_context_rule(cfg):
                           'noise' : (0, 1) })
 
 
+@ksft_disruptive
+def test_rss_context_persist_ifupdown(cfg, pre_down=False):
+    """
+    Test that RSS contexts and their associated ntuple filters persist across
+    an interface down/up cycle.
+
+    """
+
+    require_ntuple(cfg)
+
+    qcnt = len(_get_rx_cnts(cfg))
+    if qcnt < 6:
+        try:
+            ethtool(f"-L {cfg.ifname} combined 6")
+            defer(ethtool, f"-L {cfg.ifname} combined {qcnt}")
+        except:
+            raise KsftSkipEx("Not enough queues for the test")
+
+    ethtool(f"-X {cfg.ifname} equal 2")
+    defer(ethtool, f"-X {cfg.ifname} default")
+
+    if pre_down:
+        ip(f"link set dev {cfg.ifname} down")
+
+    try:
+        ctx1_id = ethtool_create(cfg, "-X", "context new start 2 equal 2")
+        defer(ethtool, f"-X {cfg.ifname} context {ctx1_id} delete")
+    except CmdExitFailure:
+        if pre_down:
+            ip(f"link set dev {cfg.ifname} up")
+            raise KsftSkipEx("Create context not supported with interface down")
+        raise
+
+    ctx2_id = ethtool_create(cfg, "-X", "context new start 4 equal 2")
+    defer(ethtool, f"-X {cfg.ifname} context {ctx2_id} delete")
+
+    port_ctx2 = rand_port()
+    flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {port_ctx2} context {ctx2_id}"
+    ntuple_id = ethtool_create(cfg, "-N", flow)
+    defer(ethtool, f"-N {cfg.ifname} delete {ntuple_id}")
+
+    if not pre_down:
+        ip(f"link set dev {cfg.ifname} down")
+
+    ip(f"link set dev {cfg.ifname} up")
+
+    import subprocess
+    max_wait = 10
+    ping_success = False
+    remote_addr = cfg.remote_addr_v[cfg.addr_ipver]
+    for attempt in range(max_wait):
+        try:
+            result = subprocess.run(['ping', '-c', '1', '-W', '1', remote_addr],
+                                  capture_output=True, timeout=2)
+            if result.returncode == 0:
+                ping_success = True
+                break
+        except Exception:
+            pass
+        time.sleep(1)
+
+    if not ping_success:
+        raise KsftSkipEx("Cannot reach remote host after interface up")
+
+    ctxs = cfg.ethnl.rss_get({'header': {'dev-name': cfg.ifname}}, dump=True)
+
+    data1 = [c for c in ctxs if c.get('context') == ctx1_id]
+    ksft_eq(len(data1), 1, f"Context {ctx1_id} should persist after ifup")
+
+    data2 = [c for c in ctxs if c.get('context') == ctx2_id]
+    ksft_eq(len(data2), 1, f"Context {ctx2_id} should persist after ifup")
+
+    _ntuple_rule_check(cfg, ntuple_id, ctx2_id)
+
+    cnts = _get_rx_cnts(cfg)
+    GenerateTraffic(cfg).wait_pkts_and_stop(20000)
+    cnts = _get_rx_cnts(cfg, prev=cnts)
+
+    main_traffic = sum(cnts[0:2])
+    ksft_ge(main_traffic, 18000, f"Main context traffic distribution: {cnts}")
+    ksft_lt(sum(cnts[2:6]), 500, f"Other context queues should be mostly empty: {cnts}")
+
+    _send_traffic_check(cfg, port_ctx2, f"context {ctx2_id}",
+                        {'target': (4, 5),
+                         'noise': (0, 1),
+                         'empty': (2, 3)})
+
+
+def test_rss_context_persist_create_and_ifdown(cfg):
+    test_rss_context_persist_ifupdown(cfg, pre_down=False)
+
+
+def test_rss_context_persist_ifdown_and_create(cfg):
+    test_rss_context_persist_ifupdown(cfg, pre_down=True)
+
+
 def main() -> None:
     with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
         cfg.context_cnt = None
@@ -823,7 +921,9 @@ def main() -> None:
                   test_rss_context_out_of_order, test_rss_context4_create_with_cfg,
                   test_flow_add_context_missing,
                   test_delete_rss_context_busy, test_rss_ntuple_addition,
-                  test_rss_default_context_rule],
+                  test_rss_default_context_rule,
+                  test_rss_context_persist_create_and_ifdown,
+                  test_rss_context_persist_ifdown_and_create],
                  args=(cfg, ))
     ksft_exit()
 
-- 
2.51.0


