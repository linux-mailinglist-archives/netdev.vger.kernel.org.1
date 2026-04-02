Return-Path: <netdev+bounces-274712-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB+XAK3lzmk5rQYAu9opvQ
	(envelope-from <netdev+bounces-274712-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 23:54:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C57438E7E7
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 23:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB0E9301DDDD
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 21:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EC43876C6;
	Thu,  2 Apr 2026 21:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jugfr0Nv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCB1387590;
	Thu,  2 Apr 2026 21:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775166888; cv=none; b=uoTfHy9k08jMO6tpeDVrDa91bQTwwprfjAj7H9dL0vp/D3G/qiH/ZPfwLA7VxOEaP156GvofjYusVGVnX6etuXaoXutlvG8K4YjW6rlQsUAmSauCHCAa2p2OOIIB4HOT1c6zt6i84c5cP+Qw5R9WUBsXXXnLHU/obS4SYwwcMWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775166888; c=relaxed/simple;
	bh=8xG47UVaicBg3PGvoKmkcXt2eBzcPg4SMCh5HpVNuIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k1tpWK9l/GDQJ/XlN2+U/7WB44t3jSHUKgVJu1/mNV01159j239XymjiSZmW1+cxMvOP5uYxT1/kIAqWKcFuHh+eKCAz+2+4PdZyRa7DCK8Vuqm8ChxVHNbiaXHQlj0h9Z52+MX91Pps0ne+zsjJZH+aQTxusvHgN50b8V3sk3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jugfr0Nv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE97FC116C6;
	Thu,  2 Apr 2026 21:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775166887;
	bh=8xG47UVaicBg3PGvoKmkcXt2eBzcPg4SMCh5HpVNuIY=;
	h=From:To:Cc:Subject:Date:From;
	b=jugfr0NvB1mIYoQZ/YuvrKSYo/SX+02atopM5EUi7Yv0Nmfwv0r+3n9o4nqOGgQNL
	 mUxmXo3gaqtFN19dmH0/OPHlHcHT9Eoy11LYUUykyYdjsgkl3NMzekhqWNL0OUD7M4
	 fhVAMNaITjHmJoDLywZ1tpxYiwM/HIOmGJcOCNSvgUyBCnwspj8E815chE8ZmgMhVB
	 x6lZH6un8ZcW4i0CeU4niVKB5WT2DzqHQSSzUm6b9QWorQ6nEzyQ9kIqM8lyBEmjDb
	 ux/A5YFcAgZKRn5E6rujsvb16TQtMbOYz5XyUmvIDL2BOi+Sn5l2CNbqsbyOEfFnEx
	 KUjPDISeA8jYw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	Joe Damato <joe@dama.to>,
	shuah@kernel.org,
	petrm@nvidia.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2] selftests: net: py: color the basics in the output
Date: Thu,  2 Apr 2026 14:54:44 -0700
Message-ID: <20260402215444.1589893-1-kuba@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-274712-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fomichev.me:email,dama.to:email]
X-Rspamd-Queue-Id: 8C57438E7E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sometimes it's hard to spot the ok / not ok lines in the output.
This is especially true for the GRO tests which retries a lot
so there's a wall of non-fatal output printed.

Try to color the crucial lines green / red / yellow when running
in a terminal.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Acked-by: Joe Damato <joe@dama.to>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - use functools instead of open coding the caching (pylint)
v1: https://lore.kernel.org/20260401183309.378671-1-kuba@kernel.org

CC: shuah@kernel.org
CC: petrm@nvidia.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/lib/py/ksft.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 6cdfb8afccb5..7b8af463e35d 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -2,6 +2,7 @@
 
 import functools
 import inspect
+import os
 import signal
 import sys
 import time
@@ -31,6 +32,17 @@ KSFT_DISRUPTIVE = True
     pass
 
 
+@functools.lru_cache()
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
 def ksft_pr(*objs, **kwargs):
     """
     Print logs to stdout.
@@ -165,6 +177,14 @@ KSFT_DISRUPTIVE = True
         res += "." + case_name
     if comment:
         res += " # " + comment
+    if _ksft_supports_color():
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


