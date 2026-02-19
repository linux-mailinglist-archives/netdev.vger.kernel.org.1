Return-Path: <netdev+bounces-259569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OaVDlpcl2lexQIAu9opvQ
	(envelope-from <netdev+bounces-259569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:54:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA08161CDB
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C82F303CEF1
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E1B2F0C7E;
	Thu, 19 Feb 2026 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fFWK/EZo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325832EC083
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771527229; cv=none; b=WeajF8WpdXMqbRXuEULwSQjdHYtFw3PXDl6RW3UTZHwmmtslRBiSGBNVxlBMBl+RE4LZ74ejwSbnng6HzHzyBA4wppd09ISJRQpiwCJ5sDJkF5FT+SumLlH1sagkLvgYJAaAfS+pjPtS+MgJX72Z6GrvLIslXYeGOQ0x/jBsTUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771527229; c=relaxed/simple;
	bh=B8pKtQPFdTwJXlDtgNGXqc3gHOD+BWHl5j/fDq+v90A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0qngY8YV9veCuF45nTPncaVTppMHyruE0a61b6A8RR28D6BBncvUmkb4hWEp4E7sRpoc7/l1a8XrrEiZTA0HgMgfxE7MHvl8apqU53mIgrs9KRsMGck8q1/vZZzQ0EQhOy2tQtmv98oVT8CAbWdKdY9HCkndVYkDtG8CWmwPTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fFWK/EZo; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-8954a050c19so15942246d6.3
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 10:53:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771527227; x=1772132027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRALV8S5SycwE1cozmsAcF2ZCcAdV2ORqka9l/U6rP0=;
        b=BWOqTy8wEWYha3NeztlokwOrlkTgdZB3RtiRbZvm+vDFVh1v1fmH+Jwia67V9idTk2
         6MNxovKw208DGr9yilTCogEL0R9OqhOtJopJyyQTJfdGUO3WFKg7cRikidNcJvc9FDU8
         oJaTcztbq1uUp1E3sDjRs0pLT1cVfbi4OoJGfyiqn1rgutdKf5MCMqVrT/XFyjpM83Bp
         AYYIbFjSd2TqIUSkFyMqIL1RZTslw1SUjr/T52yggORPiiegoVo2xekklRcweIGuCeVg
         rYm4UyyHtlH3eCNE51gjSQHmkCToOG/1H59I5C8w8FeA/8GYwEarKwJNbWPJwTqfsInd
         EfIQ==
X-Gm-Message-State: AOJu0YwIfRrAbBd5rq0ZrM1l0ExOAl4fD5tzpH6hjSgKMfxGbLo2T0IR
	pdCLpJvFw9mTx0K9JTHebI+u4ppkHN7LGy/vB+AUoaVjr41PDW/+YUKI6QlgpPD83HonugfWyQc
	ejli+FFD+ochfRZ61LNsh0aQIhtJTUt50CMCCYKvjB7llAHxQmWrEjJKfp/woOoIwOlPAFAnZbV
	zsJ/HQHB7RwMygCo0MfpW7Ke9CySSDk8OZCMAzJIujfbZUwiQYrs8oxupC46/NcnGVCRnl7dWxf
	/bjUrTzfmM=
X-Gm-Gg: AZuq6aKSqrHG2Rgfh9bkvNLij2NwBBQINssZ0b6smzzynE3bAo6CmzCPHcGa+e2fMUV
	VSbAhML5EZ59qQCqwvKYrd/7Vc1eWybJAHMjFyGIr6S/taB/9HL0kR9MDq2+xM9dpsKfLeTTxKw
	gkdGSnKF1KVxgbIAti4Iswa3WYLRRjNDCW93cBHnKwcy+hABdl6yT/7lb0wGqOBBmrELiV37VkG
	v1nz9FIgGRbXY5NeHQoxv2ijwLcd3mS7cp5rPWCOkPDlQTv/rbcv35nAjhT/dH2cLSr7CnJpa/X
	88TUnHoiSXYSCmVtaUGvUVeGdgOpa+qq/XgZE79BMjX+RY37LLRbiFYYLsvY/aZChaUCU7M+sVx
	pXuvR62NiAvxXnrL+uCl1VGHMU7NmAd42+mpCZwAjwRy9JDzPHndR/CpoPE3ZHmMkt8JiIujFjx
	B9f8w+FkOX08GLUTV7bGsRQ69dA2UMlcyMaH1tiXwavreK9Of1XVwzec2p
X-Received: by 2002:a05:6214:4111:b0:896:fdde:d014 with SMTP id 6a1803df08f44-89734944681mr335397306d6.49.1771527226959;
        Thu, 19 Feb 2026 10:53:46 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-94.dlp.protect.broadcom.com. [144.49.247.94])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50684a6e151sm24582191cf.3.2026.02.19.10.53.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Feb 2026 10:53:46 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ba87c0e198so963190eec.1
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 10:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771527226; x=1772132026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRALV8S5SycwE1cozmsAcF2ZCcAdV2ORqka9l/U6rP0=;
        b=fFWK/EZoUBudVZ04WpcvgDYcRZRKCF6Rdb5/TPlvjaF3OCcbEBJmW9hWGUCUUsHF/D
         Wt7pTXLpc+V9GrrPwXV8K+1y2UYinRVB7L9KeULGdbbvTHaqZ2iq7GYpLMqYzxI6Qdj2
         BWOw1s2pHIxWC0lt7oLcoYIvmSRHo1Tz8/E08=
X-Received: by 2002:a05:7301:6587:b0:2ba:6e87:5263 with SMTP id 5a478bee46e88-2baba10ce19mr9587436eec.32.1771527225567;
        Thu, 19 Feb 2026 10:53:45 -0800 (PST)
X-Received: by 2002:a05:7301:6587:b0:2ba:6e87:5263 with SMTP id 5a478bee46e88-2baba10ce19mr9587412eec.32.1771527224926;
        Thu, 19 Feb 2026 10:53:44 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb6782e5sm21488155eec.29.2026.02.19.10.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 10:53:44 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	horms@kernel.org
Subject: [PATCH net v4 3/3] selftests: drv-net: rss_ctx: test RSS contexts persist after ifdown/up
Date: Thu, 19 Feb 2026 10:53:13 -0800
Message-ID: <20260219185313.2682148-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260219185313.2682148-1-michael.chan@broadcom.com>
References: <20260219185313.2682148-1-michael.chan@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259569-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim,broadcom.com:email,rss_ctx.py:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: ADA08161CDB
X-Rspamd-Action: no action

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Add a test to verify that RSS contexts persist across interface
down/up along with their associated Ntuple filters. Another test
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
v3: More improvements suggested by Jakub:
1. Used defer() and exec() for the if up
2. Wait for carrier before trying the ping to start traffic tests
3. Replace manual subprocess.run() ping loop with cmd()
4. Fixed all ruff and pylint warnings in the newly added code

v2: Many improvements suggested by Jakub:
https://lore.kernel.org/netdev/20260206052930.1882740-5-michael.chan@broadcom.com/
1. simplified the tests to have only 2 contexts, use one of the contexts
to test ntuple filters' persistence also 
2. used @ksft_disruptive for the test
3. used netlink API to get rss contexts

v1: https://lore.kernel.org/netdev/20260129061646.1417185-5-michael.chan@broadcom.com/
---
 .../selftests/drivers/net/hw/rss_ctx.py       | 100 +++++++++++++++++-
 1 file changed, 98 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index ed7e405682f0..b9b7527c2c6b 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -4,13 +4,15 @@
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
-from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
+from lib.py import cmd, ethtool, ip, defer, GenerateTraffic, CmdExitFailure, wait_file
 
 
 def _rss_key_str(key):
@@ -809,6 +811,98 @@ def test_rss_default_context_rule(cfg):
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
+        except Exception as exc:
+            raise KsftSkipEx("Not enough queues for the test") from exc
+
+    ethtool(f"-X {cfg.ifname} equal 2")
+    defer(ethtool, f"-X {cfg.ifname} default")
+
+    ifup = defer(ip, f"link set dev {cfg.ifname} up")
+    if pre_down:
+        ip(f"link set dev {cfg.ifname} down")
+
+    try:
+        ctx1_id = ethtool_create(cfg, "-X", "context new start 2 equal 2")
+        defer(ethtool, f"-X {cfg.ifname} context {ctx1_id} delete")
+    except CmdExitFailure as exc:
+        raise KsftSkipEx("Create context not supported with interface down") from exc
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
+    ifup.exec()
+
+    wait_file(f"/sys/class/net/{cfg.ifname}/carrier",
+        lambda x: x.strip() == "1", deadline=20)
+
+    remote_addr = cfg.remote_addr_v[cfg.addr_ipver]
+    for _ in range(10):
+        if cmd(f"ping -c 1 -W 1 {remote_addr}", fail=False).ret == 0:
+            break
+        time.sleep(1)
+    else:
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
+    """
+    Create RSS contexts then cycle the interface down and up.
+    """
+    test_rss_context_persist_ifupdown(cfg, pre_down=False)
+
+
+def test_rss_context_persist_ifdown_and_create(cfg):
+    """
+    Bring interface down first, then create RSS contexts and bring up.
+    """
+    test_rss_context_persist_ifupdown(cfg, pre_down=True)
+
+
 def main() -> None:
     with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
         cfg.context_cnt = None
@@ -823,7 +917,9 @@ def main() -> None:
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


