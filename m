Return-Path: <netdev+bounces-278052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLliIDXW3GmcWQkAu9opvQ
	(envelope-from <netdev+bounces-278052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:40:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5733EB696
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41650301CFDB
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234433C2777;
	Mon, 13 Apr 2026 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="GMU85UrX"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23703603E0
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080418; cv=none; b=WzFLgvd8Wl2AjACI57KsrxOrMhcN7zx+XtkhowKhLQqioi3q5GgTpguTsH1/z3L4weAPXWbfk8TEzAHCcrpjUc9SIAv/XGwB6mwqt+3yVo+YTRMSNo9WUWqQEcGwKcfcdzODKDHod8PjMLTDhnv2I+7zVdXJIGxG8R9wYekaq5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080418; c=relaxed/simple;
	bh=Id57ErV3Ss9oHJFG1P//7cPuA2LJ8Aopaq6ugKyC6kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+FShz7KjJ7mP9f/83owZBF4T+EbVnAb5e5suZRKcqLkXhmA+5n4Y/wZ5mAT19/KxhLp/8z1vmNAgRfDxB+HuwXasJD2jZrbHcBPCOep2ysv+4wgCzS34l3Ru6dWuSqT0hojPdYRYaLsIfeMdlLJcFSzWprkMvCC8i5wAphyrbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=GMU85UrX; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=MbFZ3KzOxtqcptxGM0RUJMkdVbx55SrWBGE4TuY7MPs=; b=GMU85UrXoFPN4fqCFcjq6uy/Q7
	OGAL8zCEcqgwvcUBsNre1DB9ZSG5RyC5r/3Whxe6WQQIQPcJxb4pMq4vXsCpHMK4JYf5a02MHHjIp
	4XTGGHrx1e6UyIAdMIa5CC7jWakUj6awdOBwcGQYRDLfQKLH0WJy5wfAHP5+lyy6SeoMOlyfkzcam
	HFalq00akvGbrlozpPGY6kXiciyYTHG5Fg/kYNwUNB0wKlRvXd9nCrY7BNA5tUf3O/8JBLT/zuJzz
	zUC7+jCmn/n2J2vohWJ/xkY5xcqamGzLJ9hmSDLW/WruaUR6ns3bUBb8Dnfrqjfk8aL8q4zTY8Xk7
	JxQCFfcA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wCFeH-000ILu-0b;
	Mon, 13 Apr 2026 13:40:13 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: pabeni@redhat.com,
	dw@davidwei.uk,
	razor@blackwall.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/3] tools/ynl: Make YnlFamily closeable as a context manager
Date: Mon, 13 Apr 2026 13:40:08 +0200
Message-ID: <20260413114011.588162-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413114011.588162-1-daniel@iogearbox.net>
References: <20260413114011.588162-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27970/Mon Apr 13 08:24:33 2026)
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278052-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid,self.family:url]
X-Rspamd-Queue-Id: DB5733EB696
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

YnlFamily opens an AF_NETLINK socket in __init__ but has no way
to release it other than leaving it to the GC. YnlFamily holds a
self reference cycle through SpecFamily's self.family = self
in its super().__init__() call, so refcount GC cannot reclaim
it and the socket stays open until the cyclic GC runs.

If a test creates a guest netns, instantiates a YnlFamily inside
it via NetNSEnter(), performs some test case work via Ynl, and
then deletes the netns, then the 'ip netns del' only drops the
mount binding and cleanup_net in the kernel never runs, so any
subsequent test case assertions that objects got cleaned up would
fail given this only gets triggered later via cyclic GC run.

Add an explicit close() that closes the netlink socket and wire
up the __enter__/__exit__ so callers can scope the instance
deterministically via 'with YnlFamily(...) as ynl: ...'.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/net/ynl/pyynl/lib/ynl.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 9c078599cea0..f63c6f828735 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -731,6 +731,16 @@ class YnlFamily(SpecFamily):
             bound_f = functools.partial(self._op, op_name)
             setattr(self, op.ident_name, bound_f)
 
+    def close(self):
+        if self.sock is not None:
+            self.sock.close()
+            self.sock = None
+
+    def __enter__(self):
+        return self
+
+    def __exit__(self, exc_type, exc, tb):
+        self.close()
 
     def ntf_subscribe(self, mcast_name):
         mcast_id = self.nlproto.get_mcast_id(mcast_name, self.mcast_groups)
-- 
2.43.0


