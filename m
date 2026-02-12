Return-Path: <netdev+bounces-258421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O+VCDGOjWl54QAAu9opvQ
	(envelope-from <netdev+bounces-258421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 09:24:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 720C912B3A7
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 09:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82D44300F124
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 08:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E5C2D060D;
	Thu, 12 Feb 2026 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TnLUZ/bz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCC32C11FE
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770884513; cv=none; b=NJ24NGA5I8dxER8Kmsa4+NpQWuy819aOvQxAJVjJB/Sdl753nA5rhWdHPJsmm2evw4aNFQE57cVezRNWugASZda7DZ7ld991XCdvrw2sjEQY9aPZZeVKpjIkP0+7CtVJt/ETSg2OeJpKLamTS1qCaKoMGTKaBtYQ4wNeY3nsC+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770884513; c=relaxed/simple;
	bh=s1z3mIlDAgSyfJsqZjGOF13vW0ZC3bG5GORwMLLbaUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FpysrFytNS7xGbi8ODE2x3oL34Q9bN8ey64GWTm426LBsMuHp8XbWK4792pJE+LxLa8MaEIBThDi+r94gpmASy5BDIQjVmxowCTxpqFReO+5NVo2LifKSltbJDy6S+U0XmD6GzAfoIiMTqISF4W7KdAe5lJ1U+k/oXgI4NpeFmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TnLUZ/bz; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-824af5e5c81so707329b3a.0
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 00:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770884512; x=1771489312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWqaOsjQMFpZ4agq7Hu/nDcrO3ihcY3ZePAIP4O4LkI=;
        b=xIh+B3NA8Y8RaEp5H0ncltNPhivBuR0BjR+o9IymwTdjL7AxBvqldB5qk11AVLGPO9
         iTC9yffG6L6MxBm5MTJQ5YPdfq/yeuSu/jfKg4+uoddt5vj7P0vNbYOHr/zchQEE6aZ2
         q6HvRt8VJ1U+i/Io2U3lZmJxjHxblFqgGFcFthfgNvhk3TyQ/H9wMziGhUUDndCb4x+d
         vE7JLCi6QZUM2RNF9638pGzaVwEy7RnPSrbJ+h5KBnJYT9VK0NvJYn8bZFGXrV/KtCBU
         9DMgZTxtMSufUEdgT8aJauGVQlJBJZf5G4yJtwArttwWPUQFNAM6d3ECptHVYdA8J41F
         e58Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/OE61wQ7NqZNd0wmEv55eB0unPIeEDpo44uk1dw61AUzlyuOrBWZiZ+FqTMjXcX2XTwbXd88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfoOA20lvDYQN6bh4+khHi/5dxawuaOosLPUqHs8EsVjtMtOyv
	ac5pw2mk7CdV3P7Q5kcAKBl3vIPOL1TYMJXOSe1KLrnEdf1aSCobKFM0WuQHNqgNcDJRXgK6G3k
	cm3jn7PSl065ttxVHIaE7spAY6/vPEEdpF5DNaBiWrnS6MGF2OXvCnruUR948xYnIuexNZ6nlp3
	BtWJ+zA7WziVmvgMRHUjcJXcA9AjLXWWpoRsxrsvzVpoznQiFITlfWBO9W8NdodEl0m1ObpSYuF
	hgX9rZwpVo=
X-Gm-Gg: AZuq6aJV9BUZke3BXW8bQyI8Yp16IjEE0teUzCjObr3Ol/b7M0Xw0eK1XdENXOI4FnN
	cpsLCq8D5z2RzX/jEg0wgHvGOE9uID3pRpMBvoNxQErjWviGY9JKCtNQPBlnth4movWUQJ7Wrg/
	LhyWduPNhSC/yRh9KMZ0vwMMf1o0rup92sDGhQ79U6O6zlCnU06Q4Q+mZDwgCLFj3c4h3RlrsEr
	Ye3aFGVwngrgGbRHq9f3uAC3tEJsxJCqnvnAH6CQt1SpkZgRwyzrqHMby8L84X7xNYBTvindUTs
	oQJ21sW6uuG6QOWDVlxvfrWqIEZD0AtArqFzqLx7pt7n8lAbmP3MsqSAt6xULnWPNonsF5jnvE8
	AZbb6tHgHQrLQ/FXtG6Gm5qACmk+ZhYjsSsXvgeZGfPgqeuZJO8+SvN6lgGCvXCZCGz3LZbGL1G
	PM3eNcpMMa9Lf/OoCuVNBVsQPLeixWKv0gwlZdeFnRIfjImstekjOBwA==
X-Received: by 2002:a05:6a00:ac89:b0:824:3419:25dd with SMTP id d2e1a72fcca58-824b0623561mr1873878b3a.69.1770884511646;
        Thu, 12 Feb 2026 00:21:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-8249e12a6a2sm481164b3a.0.2026.02.12.00.21.51
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2026 00:21:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aadeb3dee4so141982725ad.2
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 00:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770884510; x=1771489310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWqaOsjQMFpZ4agq7Hu/nDcrO3ihcY3ZePAIP4O4LkI=;
        b=TnLUZ/bzY0l8dTCAvjz7eLJHZPPC8n/QL5QqTyNHEZ7LPqTxkABAZhjricd7M5As4v
         WZlkLCDcHKdrEqZNitJy6HicDBYIxxopYVFCXNgOZ7UCGefCQTKdl4NFiHJA6054+s/F
         3yzzbTCib/uEJrRpjN3eZpShtJrREyCh4WN9c=
X-Forwarded-Encrypted: i=1; AJvYcCVviSKWa7hlef1oEeIaRYDhhb6K1ax9F5Tnzbkw9UsblUAye9nuM1nSZPW2cWUTDn6OTeTEcr8=@vger.kernel.org
X-Received: by 2002:a17:902:c215:b0:2a3:bf9d:9399 with SMTP id d9443c01a7336-2ab399ec0e2mr15393695ad.35.1770884509801;
        Thu, 12 Feb 2026 00:21:49 -0800 (PST)
X-Received: by 2002:a17:902:c215:b0:2a3:bf9d:9399 with SMTP id d9443c01a7336-2ab399ec0e2mr15393585ad.35.1770884509445;
        Thu, 12 Feb 2026 00:21:49 -0800 (PST)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab299983d0sm44077615ad.79.2026.02.12.00.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 00:21:48 -0800 (PST)
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
To: kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	bobbyeshleman@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	michael.chan@broadcom.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com
Subject: [PATCH 1/1] Re: [PATCH net v2 4/4] selftests: drv-net: rss_ctx: test RSS contexts persist after ifdown/up
Date: Thu, 12 Feb 2026 00:12:50 -0800
Message-Id: <20260212081250.4088970-1-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260211085822.184f85c2@kernel.org>
References: <20260211085822.184f85c2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258421-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,broadcom.com,gmail.com,davemloft.net,google.com,vger.kernel.org,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lib.py:url];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 720C912B3A7
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 10:01 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> >
> > My experiments are pointing to 'self.cancel()' sometimes taking a lot
> > of time as part of the exec().
> > I don't know but I feel the new test code itself should be OK. I can
> > send a v3 and you can run it once too?
>
> Could you reply to this thread with what the version of the patch where
> you see defer() takes a long time? We use defer all over the place..

Please find the patch with which I see exec() and defer() often taking a
lot of time to perform ifup..
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
2.47.3


