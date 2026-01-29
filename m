Return-Path: <netdev+bounces-254587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGPYBMj7emlaAQIAu9opvQ
	(envelope-from <netdev+bounces-254587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 07:18:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE78AC2F5
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 07:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 833E930107D6
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 06:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8C82E9EAE;
	Thu, 29 Jan 2026 06:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dYSzlL61"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422D42DB7AD
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 06:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769667457; cv=none; b=Xtx2ek40P0XEiaeJlmUv/YLzoCGhStt+Vqt7j4Szj3WNc2/e6NCcCa8kBELdsa2Z+5EeQVIV3G328mCW53RUugL4n72erkj6mZZhZlWZwPv/jQIaYIpgHfDpsNsuPUNMk1GUrQIhvA2TDvTssKxMErN25TMuAf2ZKx4RQ0g+8GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769667457; c=relaxed/simple;
	bh=g1JqeULTDW61vZgEnCGbS9W0ng6/TDXS0wGcmZHn57s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjEib1deA3g6PrH2Le9ke10PhusVug+dhfDx1jsKuljuzcZ2vQmMn6EJm/S/0BOWQs+pwmSsLuDbk/VNFYWQ9+OonCh2uob/7eCfHCrqGxcdEQnJXNgRJl8ea68BJi55NfA2OFQpTKZtd0/N86BwK6+Mp83mZ1h9h6b4OqbbmE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dYSzlL61; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a7a94c6d4fso2915035ad.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 22:17:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769667455; x=1770272255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijOcFXxCM942lF0BqmGZdm0ZfSYbtqy0UaP1oVcX7Xs=;
        b=HW4dY3krLNkjz+UZy5/6IVwprMl5IMRWWbzdDVjQHntaVjgd2oUQXsQ0oSSlfntDin
         jm8Nf2DGGC0eoyfOUpUIwx5RpE/TBNgdPW2wlvCe4K6s/mXd65Ir8EslFPXzZBANhLFa
         Sxv4d4Lc7n/09U2xPUJ649GGxDUbJ4imyojQFTRjrS7cKnEJgm1cl1ez3cp5pcqsvhi3
         UEoL3EbnhTpfuZS23A1m46slSy78q3CASGqP+m441clZT5MTPasV2MzbRr+gjOcxXRNC
         NIBsO1L/j0YbuNPHAD3oZPZMXM+r2lrJ8AUfl423r4hYbAHmJHc0eWgz3pVyUjh85JpS
         6Dqg==
X-Gm-Message-State: AOJu0YxmjXmGv/mvFHLcd0RFT+GRUIGV5Rjwe3DlSvvNY9fIAnad9smG
	5LmojiC6ULlbryOOMa2dFNPog7HWBz1uw2u+4pMQ0jOaJ4+mOmNmCACQEP8KFtrEjEIaeYKHBoE
	s7Vs7yCSLYTpuTf0ZFVqNI9su/mpiVGzo27NWBeqRgYvNWjj8ptq6lWFHz4Ng3EA5paOsoIP86i
	iZgEXvHhMcUP7u9ya0NBf7bqn89tZIF9hCi93UYwRjs6bwx7MtV80+U5vuFCg5pYzCijTJccshy
	zBisXtmtn8=
X-Gm-Gg: AZuq6aK1rshXhjBCfOQOx3s7L9W7+2CuKVezFZiG8Vs/zNoc5480nozSJerKr66lfmn
	3RwwuQuAKSg23EW6mY7fnaT6z0iijQoOeKek49LE+T+j62Ea1747kFaxnJ441LNf8ohWjdNHam8
	Qo+DSlNPGU33uBL4O8LkxR+CyyopCK1+7coexvMWzurWLuJI+AIoA4RGuN0U5xOG1L57PsA9WxL
	/l5FFeF7pVotZFLyH1s3TsxHCmpUNPQc6AS1Tmf+7US9PfZpXoHQEQ0qza73LhDCfF8/FIC4OPB
	+ugk9kpkItzPnXX5gt7GaTW5H6qz0h4qHYLndZD9AtYjfd8UU89DOjrDpb6Cz3dWu5CPTbxhwJv
	UizeE/7HsEopd2kCZvZNVdyaXuDLqdxdcwmTTbmItbLImcFaQDSzQybUNtgtlcKRVg7HIzORVQs
	6XEMfFxSGrW0Fue1PboElWe25AQCJk8exvNORBJBJ5EPw+
X-Received: by 2002:a17:903:1250:b0:294:def6:5961 with SMTP id d9443c01a7336-2a870e146f4mr77465075ad.45.1769667452625;
        Wed, 28 Jan 2026 22:17:32 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a88b414125sm5651445ad.17.2026.01.28.22.17.32
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jan 2026 22:17:32 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-124aa710af7so4193603c88.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 22:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769667451; x=1770272251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijOcFXxCM942lF0BqmGZdm0ZfSYbtqy0UaP1oVcX7Xs=;
        b=dYSzlL61yJaTeEkibRewdgbnFLLjU7fjdq271LpjOgnzfbHqJi37kwIeC+eEh5cZhn
         ON1ADb6R+0aYYg/SPpTvS3l53eqwkpZFTBbi09dJyr3cGKPnbY9Jw7nkO1+nKc0QG3MP
         wx+zUij3HTzXMektDumYW803uY1c2ZsrcT4+E=
X-Received: by 2002:a05:7022:6b94:b0:119:e56b:957c with SMTP id a92af1059eb24-124a005b9c3mr4795133c88.1.1769667450821;
        Wed, 28 Jan 2026 22:17:30 -0800 (PST)
X-Received: by 2002:a05:7022:6b94:b0:119:e56b:957c with SMTP id a92af1059eb24-124a005b9c3mr4795116c88.1.1769667450225;
        Wed, 28 Jan 2026 22:17:30 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9e0304bsm5318226c88.14.2026.01.28.22.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 22:17:29 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net 4/4] selftests: drv-net: rss_ctx: test RSS contexts persist after ifdown/up
Date: Wed, 28 Jan 2026 22:16:46 -0800
Message-ID: <20260129061646.1417185-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260129061646.1417185-1-michael.chan@broadcom.com>
References: <20260129061646.1417185-1-michael.chan@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254587-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5DE78AC2F5
X-Rspamd-Action: no action

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Add tests to verify
1. that RSS contexts persist across interface down/up
2. that RSS contexts persist across interface down/up along
with their associated Ntuple fitlers

Testing on bnxt_en:

 TAP version 13
 1..1
 # timeout set to 0
 # selftests: drivers/net/hw: rss_ctx.py
 # TAP version 13
 # 1..2
 # ok 1 rss_ctx.test_rss_context_persist_ifupdown
 # ok 2 rss_ctx.test_rss_context_ntuple_persist_ifupdown
 # # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
 ok 1 selftests: drivers/net/hw: rss_ctx.py

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .../selftests/drivers/net/hw/rss_ctx.py       | 117 +++++++++++++++++-
 1 file changed, 116 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index ed7e405682f0..4e46c5931c7f 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -809,6 +809,119 @@ def test_rss_default_context_rule(cfg):
                           'noise' : (0, 1) })
 
 
+def test_rss_context_persist_ifupdown(cfg):
+    """
+    Check that RSS contexts persist across an interface down/up cycle.
+    """
+
+    require_context_cnt(cfg, 10)
+
+    # Create 10 RSS contexts and store their IDs and configurations
+    ctx_ids = []
+    ctx_configs_before = {}
+    try:
+        for i in range(10):
+            ctx_id = ethtool_create(cfg, "-X", "context new")
+            ctx_ids.append(ctx_id)
+            defer(ethtool, f"-X {cfg.ifname} context {ctx_id} delete")
+    except CmdExitFailure:
+        raise KsftSkipEx(f"Could only create {len(ctx_ids)} contexts, test requires 10")
+
+    # Bring interface down
+    ip(f"link set dev {cfg.ifname} down")
+
+    # Bring interface back up
+    ip(f"link set dev {cfg.ifname} up")
+
+    # Wait for interface to be fully up
+    cfg.wait_hw_stats_settle()
+
+    # Verify all 10 contexts still exist after ifup
+    missing_contexts = []
+    persisted_contexts = []
+
+    for ctx_id in ctx_ids:
+        try:
+            data = get_rss(cfg, context=ctx_id)
+            _rss_key_check(cfg, data=data, context=ctx_id)
+            persisted_contexts.append(ctx_id)
+        except CmdExitFailure:
+            missing_contexts.append(ctx_id)
+            ksft_pr(f"Context {ctx_id} is missing after ifup")
+
+
+def test_rss_context_ntuple_persist_ifupdown(cfg):
+    """
+    Test that RSS contexts and their associated ntuple filters persist across
+    an interface down/up cycle.
+    """
+
+    require_ntuple(cfg)
+    require_context_cnt(cfg, 10)
+
+    # Create 10 RSS contexts with ntuple filters
+    ctx_ids = []
+    ntuple_ids = []
+    ports = []
+
+    try:
+        for i in range(10):
+            # Create RSS context
+            ctx_id = ethtool_create(cfg, "-X", "context new")
+            ctx_ids.append(ctx_id)
+            defer(ethtool, f"-X {cfg.ifname} context {ctx_id} delete")
+
+            # Create ntuple filter for this context
+            port = rand_port()
+            ports.append(port)
+            flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {port} context {ctx_id}"
+            ntuple_id = ethtool_create(cfg, "-N", flow)
+            ntuple_ids.append(ntuple_id)
+            defer(ethtool, f"-N {cfg.ifname} delete {ntuple_id}")
+
+    except CmdExitFailure:
+        raise KsftSkipEx(f"Could only create {len(ctx_ids)} contexts with ntuple filters, test requires 10")
+
+    # Bring interface down
+    ip(f"link set dev {cfg.ifname} down")
+
+    # Bring interface back up
+    ip(f"link set dev {cfg.ifname} up")
+
+    # Wait for interface to be fully up
+    cfg.wait_hw_stats_settle()
+
+    # Verify all contexts and ntuple rules still exist after ifup
+    missing_contexts = []
+    persisted_contexts = []
+    missing_ntuple_rules = []
+    persisted_ntuple_rules = []
+    broken_associations = []
+
+    for i, ctx_id in enumerate(ctx_ids):
+        # Check if context persists
+        try:
+            data = get_rss(cfg, context=ctx_id)
+            _rss_key_check(cfg, data=data, context=ctx_id)
+            persisted_contexts.append(ctx_id)
+        except CmdExitFailure:
+            missing_contexts.append(ctx_id)
+            ksft_pr(f"Context {ctx_id} is missing after ifup")
+            continue
+
+        # Check if ntuple rule persists
+        ntuple_id = ntuple_ids[i]
+        try:
+            _ntuple_rule_check(cfg, ntuple_id, ctx_id)
+            persisted_ntuple_rules.append(ntuple_id)
+        except CmdExitFailure:
+            missing_ntuple_rules.append(ntuple_id)
+            ksft_pr(f"Ntuple rule {ntuple_id} is missing after ifup")
+        except Exception as e:
+            broken_associations.append((ntuple_id, ctx_id))
+            ksft_pr(f"Ntuple rule {ntuple_id} exists but is not properly associated with context {ctx_id}: {e}")
+
+
 def main() -> None:
     with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
         cfg.context_cnt = None
@@ -823,7 +936,9 @@ def main() -> None:
                   test_rss_context_out_of_order, test_rss_context4_create_with_cfg,
                   test_flow_add_context_missing,
                   test_delete_rss_context_busy, test_rss_ntuple_addition,
-                  test_rss_default_context_rule],
+                  test_rss_default_context_rule,
+                  test_rss_context_persist_ifupdown,
+                  test_rss_context_ntuple_persist_ifupdown],
                  args=(cfg, ))
     ksft_exit()
 
-- 
2.51.0


