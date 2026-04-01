Return-Path: <netdev+bounces-274219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBoUDOxkzWkHdAYAu9opvQ
	(envelope-from <netdev+bounces-274219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 20:33:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E703A37F4EF
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 20:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0ED52301E072
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 18:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CB9477E4D;
	Wed,  1 Apr 2026 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5tAJMFN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94943426D23;
	Wed,  1 Apr 2026 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775068391; cv=none; b=Vw04enJAcsGnjmPBOm6etwlpFr9mSI7RP8uGSPoTKnbAZQegOKTDiUXvWEZrxW9xMOQRGUf50arWFq0/a20ELYHxV2hlnOC09EEiJpCCikVnJ1eKjfBCfZNVVsPCFFkD6L4hCHvHK3qT9foTWjDX79h52qZIkNueRs+KvWI5Jks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775068391; c=relaxed/simple;
	bh=NNE70fWuJRpz4oByRIiJSVRGegGClgqD9S335Nhg77U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dL4JvcSbqDQY8iX7STa9HKbcs3fuTLoPA2dVJ8mNHwQkL1NotcD6jsPEmZ1sQ14kO1HOb+E1/1mnfiPr7kib0/kqKLBBO0ttqotnLoG5jw7YX37myrmjVOzORWrDFOF4vdZoQGaZ7EM+HjsgVh+6FZTxRi8XdQ9st/tzXUHbH3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5tAJMFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE05C4CEF7;
	Wed,  1 Apr 2026 18:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775068391;
	bh=NNE70fWuJRpz4oByRIiJSVRGegGClgqD9S335Nhg77U=;
	h=From:To:Cc:Subject:Date:From;
	b=r5tAJMFNEhRuXMh02j7odFiUv+iqLHj2StQMdDtZehGbrEe3On4h9BDRxUzOfKzNQ
	 oQpw0LwIP/jgxmHbSxmO3/8H0vscF97ropDZNz9IB+Z9oFJ8COIT+9HmQ3VByz2EyC
	 jNAEgvQ1RKlNkbtYCBgdY8GvQLNrbV9p6jHwcB5RUnLOTy4H4et75VFgqfVQAPaptQ
	 nIxfhbawGR53SNeHHm67JLj+/sPHQQvo+xD1X06y3ruLZmU4uEJaW7l+5PT8vMOHBP
	 MJg41s/pJQSqUbVHwJHY5aUxbVHriMGSVx19sAqXjCk70o4zlLo3HrqVOXwbnGkg6R
	 dVyWplJvWxT0w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	petrm@nvidia.com,
	willemb@google.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: net: py: color the basics in the output
Date: Wed,  1 Apr 2026 11:33:09 -0700
Message-ID: <20260401183309.378671-1-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274219-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E703A37F4EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sometimes it's hard to spot the ok / not ok lines in the output.
This is especially true for the GRO tests which retries a lot
so there's a wall of non-fatal output printed.

Try to color the crucial lines green / red / yellow when running
in a terminal.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
This is a bit of RFC, I'm not super convinced this is worth
carrying in the tree? Please Ack/Review I'll apply if we get
3 supporting tags.
---
CC: shuah@kernel.org
CC: petrm@nvidia.com
CC: willemb@google.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/lib/py/ksft.py | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 28a7a994526d..2a6e9113ef5b 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -4,6 +4,7 @@ import argparse
 import fnmatch
 import functools
 import inspect
+import os
 import signal
 import sys
 import time
@@ -17,6 +18,26 @@ KSFT_RESULT_ALL = True
 KSFT_DISRUPTIVE = True
 
 
+def _ksft_supports_color():
+    if os.environ.get("NO_COLOR") is not None:
+        return False
+    if not hasattr(sys.stdout, "isatty") or not sys.stdout.isatty():
+        return False
+    if os.environ.get("TERM") == "dumb":
+        return False
+    return True
+
+
+_KSFT_COLOR = None
+
+
+def _ksft_color():
+    global _KSFT_COLOR
+    if _KSFT_COLOR is None:
+        _KSFT_COLOR = _ksft_supports_color()
+    return _KSFT_COLOR
+
+
 class KsftFailEx(Exception):
     pass
 
@@ -167,6 +188,14 @@ KSFT_DISRUPTIVE = True
         res += "." + case_name
     if comment:
         res += " # " + comment
+    if _ksft_color():
+        if comment.startswith(("SKIP", "XFAIL")):
+            color = "\033[33m"
+        elif ok:
+            color = "\033[32m"
+        else:
+            color = "\033[31m"
+        res = color + res + "\033[0m"
     print(res, flush=True)
 
 
-- 
2.53.0


