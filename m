Return-Path: <netdev+bounces-273402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKWvMpYTy2nsDgYAu9opvQ
	(envelope-from <netdev+bounces-273402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:21:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4236E362A03
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73063303AF35
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D08319E992;
	Tue, 31 Mar 2026 00:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmOUjJsm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F50128395;
	Tue, 31 Mar 2026 00:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774916373; cv=none; b=iXXDOJQ4S4Oh3H5AklXOwc9cYRygWSwnxEFtJQHovz4gzfwDtwxGhdCmPaZxZFkfdLQTU4yL0gXrbS/eE/SaTojyE57a3cKAXGHxyhREkbPdV/6O1+gCe6uoIFZvgSwQHiP6ZDAd0afMs8fktPS5VHATdgagyIQGiVt6kaHJiT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774916373; c=relaxed/simple;
	bh=BXULtmlXkPYdMHmg4h32Ezg59yLkkE8iXQE0hVo0x60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fcerh7bv0jgJT8ieRQ4R1zfrutPR+MCL/Qyaj17LzX6jxnkAStpnkYigFQQrcCg0VFueq1KShetyGww6LVd6cSzLwbjIw9La6XDwYGJq8HovjmoEdsijVe9zuRmcZXPURHZhjHGQnwTSi23F56uTr82tbue6wYmYs9cy2gqhFrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmOUjJsm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68690C4CEF7;
	Tue, 31 Mar 2026 00:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774916372;
	bh=BXULtmlXkPYdMHmg4h32Ezg59yLkkE8iXQE0hVo0x60=;
	h=From:To:Cc:Subject:Date:From;
	b=RmOUjJsm7ylo1XGZVHxCyons2BJtD+XT7PqZ7CJKhRe+Jko66Y+SoU8FESgk60k5N
	 2O2j8uQmdlJbdE2dFrrekZvgtr6at8KPaF58uLJB8SRvhT2f0iFpXA/fyKgEvdkaAs
	 mXyGW4jRK33XU3oPhL0HTOzYIgJE6NASoaatAiMnmj35xlsxL6AWnGs1OoRyHBl3ij
	 B9n6wTN4j3kMcm0qktxUxuSigT3qnTS98ABvzd2AG6xuEdyyazP82UWDPzNR8fm2KL
	 3nbnsJLk56TKvTj1uKCzkM82PaLELe6s7nGASWzQFMZ+vDujbCkrqxS0ZAWVKpEWtn
	 rimIuWQzzXuIg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	joe@dama.to,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: update the README with variants
Date: Mon, 30 Mar 2026 17:19:30 -0700
Message-ID: <20260331001930.3411279-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273402-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama.to:email]
X-Rspamd-Queue-Id: 4236E362A03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Test authors need to know about variants, existing tests don't use
them because variants are relatively recent.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: joe@dama.to
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 .../testing/selftests/drivers/net/README.rst  | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index c94992acf10b..b26b364be534 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -253,6 +253,39 @@ By default the tests are expected to be able to run on
 single-interface systems. All tests which may disconnect ``NETIF``
 must be annotated with ``@ksft_disruptive``.
 
+ksft_variants
+~~~~~~~~~~~~~
+
+Use the ``@ksft_variants`` decorator to run a test with multiple sets
+of inputs as separate test cases. This avoids duplicating test functions
+that only differ in parameters.
+
+Parameters can be a single value, a tuple, or a ``KsftNamedVariant``
+(which gives an explicit name to the sub-case). The argument to the
+decorator can be a list or a generator.
+
+Example::
+
+  @ksft_variants([
+      KsftNamedVariant("main", False),
+      KsftNamedVariant("ctx", True),
+  ])
+  def resize_periodic(cfg, create_context):
+      # test body receives (cfg, create_context) where create_context
+      # is False for the "main" variant and True for "ctx"
+      pass
+
+or::
+
+  def _gro_variants():
+      for mode in ["sw", "hw"]:
+          for protocol in ["tcp4", "tcp6"]:
+              yield (mode, protocol)
+
+  @ksft_variants(_gro_variants())
+  def test(cfg, mode, protocol):
+      pass
+
 Running tests CI-style
 ======================
 
-- 
2.53.0


