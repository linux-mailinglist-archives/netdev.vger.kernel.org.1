Return-Path: <netdev+bounces-267303-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKawFzG5s2lXaQAAu9opvQ
	(envelope-from <netdev+bounces-267303-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:13:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0841527EA36
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35DC8301E9A9
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 07:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FA8365A08;
	Fri, 13 Mar 2026 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faMlZlAn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C578E3659EA;
	Fri, 13 Mar 2026 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773386021; cv=none; b=QeUUamo85yA665+yJYBEEYihrizDrZTz4aAaIgaBmYqrTp/vtjJYaviF2HnDf+pMcHuG5bOAeVskVPDJirUhBc4j6OUX3pDZBCzH+Etx3s1v0CnXon6+ADUXsmt0fF9gwCoduGoKe+GF7EK6cBZzxRT221dSzCW2SCPd4is2EP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773386021; c=relaxed/simple;
	bh=pi+jA2SaVz5VZQibrNj7aQIvOkEoJMAlD8C/xK4hfM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VwJ2TgsOqLQyz/Rgo64FSM4/HVhGn/6H/tWM+iobUKUPc8CScPVGl8tBajWyyJQCrCzQlMtddTBn10z2xmk43duoEQsaeakOQm7f16A3Pzr36qFTf2naOaHG01jqOYuBBDtn4dbfjjCqn2xdviAdi9r/W5BpU8PTZCJZeICVuyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faMlZlAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCC6C19424;
	Fri, 13 Mar 2026 07:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773386021;
	bh=pi+jA2SaVz5VZQibrNj7aQIvOkEoJMAlD8C/xK4hfM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=faMlZlAnf/GK6B6DEfKTZEsA1slBk9zJqlMLH9uhohjSpPYeoMC6njTKseG6Z5b6L
	 nCBvFf8HIELIWOlRes2kkWJ9BD4WgVIHjv1BIMc5XoD4yeAY1UBMa6Hkp1sBeY+0c1
	 3n7lpOyl2mnQ3yekyJzBKNdgbtM/azy+ws57LeevEa8HxoA9AUnTc9IRy4VCSlsNZc
	 qnUTAIvaRvpVODHKZEOTcDagmzbj0REy7s+XELo6yr7LKXS5cddBLvDoYbiicO+9yS
	 NmBMl/13RO2CmHU/WCbCRo6AAGNKnu23uPu0OQXN6q1qSmE4pHEVsWI2fwjdyUjE47
	 b92sbB6mAQaSA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v4 3/3] selftests: rss_drv: Add RSS indirection table resize tests
Date: Fri, 13 Mar 2026 08:13:15 +0100
Message-ID: <20260313071322.3489243-4-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313071322.3489243-1-bjorn@kernel.org>
References: <20260313071322.3489243-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.93 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267303-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:email,rss_drv.py:url,lib.py:url]
X-Rspamd-Queue-Id: 0841527EA36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add resize tests to rss_drv.py. Devices without dynamic table sizing
are skipped via _require_dynamic_indir_size().

resize_periodic: set a periodic table (equal 4), shrink channels to
fold, grow back to unfold. Check the exact pattern is preserved. Has
main and non-default context variants.

resize_nonperiodic_reject: set a non-periodic table (equal N), verify
that channel reduction is rejected.

Tested-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 .../selftests/drivers/net/hw/rss_drv.py       | 163 +++++++++++++++++-
 1 file changed, 159 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_drv.py b/tools/testing/selftests/drivers/net/hw/rss_drv.py
index 2d1a33189076..9763760f8306 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_drv.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_drv.py
@@ -5,9 +5,9 @@
 Driver-related behavior tests for RSS.
 """
 
-from lib.py import ksft_run, ksft_exit, ksft_ge
-from lib.py import ksft_variants, KsftNamedVariant, KsftSkipEx
-from lib.py import defer, ethtool
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ge
+from lib.py import ksft_variants, KsftNamedVariant, KsftSkipEx, ksft_raises
+from lib.py import defer, ethtool, CmdExitFailure
 from lib.py import EthtoolFamily, NlError
 from lib.py import NetDrvEnv
 
@@ -45,6 +45,18 @@ def _maybe_create_context(cfg, create_context):
     return ctx_id
 
 
+def _require_dynamic_indir_size(cfg, ch_max):
+    """Skip if the device does not dynamically size its indirection table."""
+    ethtool(f"-X {cfg.ifname} default")
+    ethtool(f"-L {cfg.ifname} combined 2")
+    small = len(_get_rss(cfg)['rss-indirection-table'])
+    ethtool(f"-L {cfg.ifname} combined {ch_max}")
+    large = len(_get_rss(cfg)['rss-indirection-table'])
+
+    if small == large:
+        raise KsftSkipEx("Device does not dynamically size indirection table")
+
+
 @ksft_variants([
     KsftNamedVariant("main", False),
     KsftNamedVariant("ctx", True),
@@ -76,11 +88,154 @@ def indir_size_4x(cfg, create_context):
         _test_rss_indir_size(cfg, test_max, context=ctx_id)
 
 
+@ksft_variants([
+    KsftNamedVariant("main", False),
+    KsftNamedVariant("ctx", True),
+])
+def resize_periodic(cfg, create_context):
+    """Test that a periodic indirection table survives channel changes.
+
+    Set a non-default periodic table ([3, 2, 1, 0] x N) via netlink,
+    reduce channels to trigger a fold, then increase to trigger an
+    unfold. Using a reversed pattern (instead of [0, 1, 2, 3]) ensures
+    the test can distinguish a correct fold from a driver that silently
+    resets the table to defaults. Verify the exact pattern is preserved
+    and the size tracks the channel count.
+    """
+    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    ch_max = channels.get('combined-max', 0)
+    qcnt = channels['combined-count']
+
+    if ch_max < 4:
+        raise KsftSkipEx(f"Not enough queues for the test: max={ch_max}")
+
+    defer(ethtool, f"-L {cfg.ifname} combined {qcnt}")
+
+    _require_dynamic_indir_size(cfg, ch_max)
+
+    ctx_id = _maybe_create_context(cfg, create_context)
+
+    # Set a non-default periodic pattern via netlink
+    rss = _get_rss(cfg, context=ctx_id)
+    orig_size = len(rss['rss-indirection-table'])
+    pattern = [3, 2, 1, 0] * (orig_size // 4)
+    req = {'header': {'dev-index': cfg.ifindex}, 'indir': pattern}
+    if ctx_id:
+        req['context'] = ctx_id
+    else:
+        defer(ethtool, f"-X {cfg.ifname} default")
+    cfg.ethnl.rss_set(req)
+
+    # Shrink — should fold
+    ethtool(f"-L {cfg.ifname} combined 4")
+    rss = _get_rss(cfg, context=ctx_id)
+    indir = rss['rss-indirection-table']
+
+    ksft_ge(orig_size, len(indir), "Table did not shrink")
+    ksft_eq(indir, [3, 2, 1, 0] * (len(indir) // 4),
+            "Folded table has wrong pattern")
+
+    # Grow back — should unfold
+    ethtool(f"-L {cfg.ifname} combined {ch_max}")
+    rss = _get_rss(cfg, context=ctx_id)
+    indir = rss['rss-indirection-table']
+
+    ksft_eq(len(indir), orig_size, "Table size not restored")
+    ksft_eq(indir, [3, 2, 1, 0] * (len(indir) // 4),
+            "Unfolded table has wrong pattern")
+
+
+@ksft_variants([
+    KsftNamedVariant("main", False),
+    KsftNamedVariant("ctx", True),
+])
+def resize_nonperiodic_reject(cfg, create_context):
+    """Test that a non-periodic table blocks channel reduction.
+
+    Set equal weight across all queues so the table is not periodic
+    at any smaller size, then verify channel reduction is rejected.
+    An additional context with a periodic table is created to verify
+    that validation catches the non-periodic one even when others
+    are fine.
+    """
+    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    ch_max = channels.get('combined-max', 0)
+    qcnt = channels['combined-count']
+
+    if ch_max < 4:
+        raise KsftSkipEx(f"Not enough queues for the test: max={ch_max}")
+
+    defer(ethtool, f"-L {cfg.ifname} combined {qcnt}")
+
+    _require_dynamic_indir_size(cfg, ch_max)
+
+    ctx_id = _maybe_create_context(cfg, create_context)
+    ctx_ref = f"context {ctx_id}" if ctx_id else ""
+
+    # Create an extra context with a periodic (foldable) table so that
+    # the validation must iterate all contexts to find the bad one.
+    extra_ctx = _maybe_create_context(cfg, True)
+    ethtool(f"-X {cfg.ifname} context {extra_ctx} equal 2")
+
+    ethtool(f"-X {cfg.ifname} {ctx_ref} equal {ch_max}")
+    if not create_context:
+        defer(ethtool, f"-X {cfg.ifname} default")
+
+    with ksft_raises(CmdExitFailure):
+        ethtool(f"-L {cfg.ifname} combined 2")
+
+
+@ksft_variants([
+    KsftNamedVariant("main", False),
+    KsftNamedVariant("ctx", True),
+])
+def resize_nonperiodic_no_corruption(cfg, create_context):
+    """Test that a failed resize does not corrupt table or channel count.
+
+    Set a non-periodic table, attempt a channel reduction (which must
+    fail), then verify both the indirection table contents and the
+    channel count are unchanged.
+    """
+    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    ch_max = channels.get('combined-max', 0)
+    qcnt = channels['combined-count']
+
+    if ch_max < 4:
+        raise KsftSkipEx(f"Not enough queues for the test: max={ch_max}")
+
+    defer(ethtool, f"-L {cfg.ifname} combined {qcnt}")
+
+    _require_dynamic_indir_size(cfg, ch_max)
+
+    ctx_id = _maybe_create_context(cfg, create_context)
+    ctx_ref = f"context {ctx_id}" if ctx_id else ""
+
+    ethtool(f"-X {cfg.ifname} {ctx_ref} equal {ch_max}")
+    if not create_context:
+        defer(ethtool, f"-X {cfg.ifname} default")
+
+    rss_before = _get_rss(cfg, context=ctx_id)
+
+    with ksft_raises(CmdExitFailure):
+        ethtool(f"-L {cfg.ifname} combined 2")
+
+    rss_after = _get_rss(cfg, context=ctx_id)
+    ksft_eq(rss_after['rss-indirection-table'],
+            rss_before['rss-indirection-table'],
+            "Indirection table corrupted after failed resize")
+
+    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    ksft_eq(channels['combined-count'], ch_max,
+            "Channel count changed after failed resize")
+
+
 def main() -> None:
     """ Ksft boiler plate main """
     with NetDrvEnv(__file__) as cfg:
         cfg.ethnl = EthtoolFamily()
-        ksft_run([indir_size_4x], args=(cfg, ))
+        ksft_run([indir_size_4x, resize_periodic,
+                  resize_nonperiodic_reject,
+                  resize_nonperiodic_no_corruption], args=(cfg, ))
     ksft_exit()
 
 
-- 
2.53.0


