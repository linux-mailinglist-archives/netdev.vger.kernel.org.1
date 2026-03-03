Return-Path: <netdev+bounces-263360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uA0EIrEmp2k3fAAAu9opvQ
	(envelope-from <netdev+bounces-263360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:21:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BF61F537B
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 19:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8773530D67E0
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 18:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CF13E556A;
	Tue,  3 Mar 2026 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+pdF+Ex"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F48358371;
	Tue,  3 Mar 2026 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561764; cv=none; b=McA41AJpHsMKQvKkYZBw+8r3VzAQgOJRSb7i47ecaMNEVhlPnnLivYFRurzUfOS/qmUKy/CoZABu+NtNHTAbmGj1WnFo/UzZCG+cwr1ERSQoIpCP2sCegr4VDHMgcgoIhd0gaQ8UXmtVvKMjIg9izAruiOvjBLydn6o6bUTvvvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561764; c=relaxed/simple;
	bh=vaae6bB7vBAa0A22NTCzZ3Js4GLopWv7MnqhKAcM0n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pYzjBUH0PAE1cZWNGHo6t7DbJk+IepIlDMY+PE9n/0oBYNNZnHO1VizFaeNkugMHi5LdZ3uafGRnAYCWhCcwJ27n8YzXwJ33qUKZ6y/BFT4HD3Sfyn/YUl5/yJca8ik7GSctgz1/u9YFIN5O0OrR0s+sp/x+11Sx+t4SvvMmsro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+pdF+Ex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08ECC116C6;
	Tue,  3 Mar 2026 18:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772561763;
	bh=vaae6bB7vBAa0A22NTCzZ3Js4GLopWv7MnqhKAcM0n8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p+pdF+ExNF5nXkWcz/tZ1LYXHOxDfwWNf4JWdnwtlBPwAK3n9IVHCQyNnLKK+iTRm
	 KYWBGjusJD62F/FFK8bHK+MbSLTkD6pg9ZJq2wdEJAKqqKy5yEwhOP4yKj2Cq50H/1
	 WFBNL72IgGoaUKAJa7xJLblpvuUY4VtzBoGUvhMs4Furk6+J5QkU/NGPvX2wHzt275
	 wtw5ADeTrGPKR8l0MuzfTJCzumbpV4i9AcYc86njhlwzs0QPy+MN8mOEF6RKRmjZ3I
	 LER53gh7nSl4hxiYKHgo+ar3RzyRmD5elWFDho6wSS3I5gnWF4FKQEh3sfJM9fYCem
	 aDJ8cx2ff2t1w==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 5/5] selftests: rss_drv: Add RSS indirection table resize tests
Date: Tue,  3 Mar 2026 19:15:33 +0100
Message-ID: <20260303181535.2671734-6-bjorn@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303181535.2671734-1-bjorn@kernel.org>
References: <20260303181535.2671734-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 00BF61F537B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.96 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263360-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rss_drv.py:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lib.py:url]
X-Rspamd-Action: no action

Add resize tests to rss_drv.py. Devices without dynamic table
sizing are skipped via _require_dynamic_indir_size().

resize_periodic: set a periodic table (equal 2), shrink
channels to fold, grow back to unfold. Check the pattern is
preserved. Has main and non-default context variants.

resize_nonperiodic_reject: set a non-periodic table (equal N),
verify that channel reduction is rejected.

Pass queue_count=8 to NetDrvEnv so netdevsim is created with
enough queues for the resize tests.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 .../selftests/drivers/net/hw/rss_drv.py       | 101 +++++++++++++++++-
 1 file changed, 96 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_drv.py b/tools/testing/selftests/drivers/net/hw/rss_drv.py
index 2d1a33189076..8725500f2955 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_drv.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_drv.py
@@ -5,9 +5,9 @@
 Driver-related behavior tests for RSS.
 """
 
-from lib.py import ksft_run, ksft_exit, ksft_ge
-from lib.py import ksft_variants, KsftNamedVariant, KsftSkipEx
-from lib.py import defer, ethtool
+from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ge
+from lib.py import ksft_variants, KsftNamedVariant, KsftSkipEx, KsftFailEx
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
@@ -76,11 +88,90 @@ def indir_size_4x(cfg, create_context):
         _test_rss_indir_size(cfg, test_max, context=ctx_id)
 
 
+@ksft_variants([
+    KsftNamedVariant("main", False),
+    KsftNamedVariant("ctx", True),
+])
+def resize_periodic(cfg, create_context):
+    """Test that a periodic indirection table survives channel changes.
+
+    Set a periodic table (equal 2), reduce channels to trigger a
+    fold, then increase to trigger an unfold. Verify the table pattern
+    is preserved and the size tracks the channel count.
+    """
+    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    ch_max = channels.get('combined-max', 0)
+    qcnt = channels['combined-count']
+
+    if ch_max < 4:
+        raise KsftSkipEx(f"Not enough queues for the test: max={ch_max}")
+
+    defer(ethtool, f"-L {cfg.ifname} combined {qcnt}")
+    ethtool(f"-L {cfg.ifname} combined {ch_max}")
+
+    _require_dynamic_indir_size(cfg, ch_max)
+
+    ctx_id = _maybe_create_context(cfg, create_context)
+    ctx_ref = f"context {ctx_id}" if ctx_id else ""
+
+    ethtool(f"-X {cfg.ifname} {ctx_ref} equal 2")
+    if not create_context:
+        defer(ethtool, f"-X {cfg.ifname} default")
+
+    orig_size = len(_get_rss(cfg, context=ctx_id)['rss-indirection-table'])
+
+    # Shrink — should fold
+    ethtool(f"-L {cfg.ifname} combined 2")
+    rss = _get_rss(cfg, context=ctx_id)
+    indir = rss['rss-indirection-table']
+
+    ksft_ge(orig_size, len(indir), "Table did not shrink")
+    ksft_eq(set(indir), {0, 1}, "Folded table has wrong queues")
+
+    # Grow back — should unfold
+    ethtool(f"-L {cfg.ifname} combined {ch_max}")
+    rss = _get_rss(cfg, context=ctx_id)
+    indir = rss['rss-indirection-table']
+
+    ksft_eq(len(indir), orig_size, "Table size not restored")
+    ksft_eq(set(indir), {0, 1}, "Unfolded table has wrong queues")
+
+
+def resize_nonperiodic_reject(cfg):
+    """Test that a non-periodic table blocks channel reduction.
+
+    Set equal weight across all queues so the table is not periodic
+    at any smaller size, then verify channel reduction is rejected.
+    """
+    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    ch_max = channels.get('combined-max', 0)
+    qcnt = channels['combined-count']
+
+    if ch_max < 4:
+        raise KsftSkipEx(f"Not enough queues for the test: max={ch_max}")
+
+    defer(ethtool, f"-L {cfg.ifname} combined {qcnt}")
+    ethtool(f"-L {cfg.ifname} combined {ch_max}")
+
+    _require_dynamic_indir_size(cfg, ch_max)
+
+    ethtool(f"-X {cfg.ifname} equal {ch_max}")
+    defer(ethtool, f"-X {cfg.ifname} default")
+
+    try:
+        ethtool(f"-L {cfg.ifname} combined 2")
+    except CmdExitFailure:
+        pass
+    else:
+        raise KsftFailEx("Channel reduction should fail with non-periodic table")
+
+
 def main() -> None:
     """ Ksft boiler plate main """
-    with NetDrvEnv(__file__) as cfg:
+    with NetDrvEnv(__file__, queue_count=8) as cfg:
         cfg.ethnl = EthtoolFamily()
-        ksft_run([indir_size_4x], args=(cfg, ))
+        ksft_run([indir_size_4x, resize_periodic,
+                  resize_nonperiodic_reject], args=(cfg, ))
     ksft_exit()
 
 
-- 
2.53.0


