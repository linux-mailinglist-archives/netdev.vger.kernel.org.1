Return-Path: <netdev+bounces-278210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XhlzMWBp3WnfdwkAu9opvQ
	(envelope-from <netdev+bounces-278210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:08:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CED3F3B62
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A7F93016526
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A7339A075;
	Mon, 13 Apr 2026 22:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="E7tpoW5j"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3610639A051
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 22:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776118103; cv=none; b=YaoSLo9OqF69TUeiPkvuCi929l4QJlKskXQqjXZifqtmSVMcRVIYVSVxg56hSJMpgfM9LHRZG2l9aLObEny7qfVAd412icgcMj6OPXhsHgq4dpQWLUTkvKuE3L0Ct2cq5Q1umzdk4SKTNUrbd1/FCV7sd4QCj1AXzhc07g9Rma4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776118103; c=relaxed/simple;
	bh=Id57ErV3Ss9oHJFG1P//7cPuA2LJ8Aopaq6ugKyC6kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYee3/z2yYOSaFfS9EDbblbBIw27zV39CsllfhHBFKiFTo4VrIYMYFBA3Gr5xd1PirL9DeLJSoF8j14BGKQttnozZvPjmyCBgTAdLgVaagWrigaTmuWgxnrMBvlNYjpODQDE8JoOKdsq1iCbvVA/fwald0tUQcl10y4r1J9JgNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=E7tpoW5j; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=MbFZ3KzOxtqcptxGM0RUJMkdVbx55SrWBGE4TuY7MPs=; b=E7tpoW5jG07QG/YvExQTcjaVXy
	CDSFfouxZtlVqJt+9srZbRmctoRBIGl3aaflG56LQcDPLZldhPvVHCe9x9GAEh0F3+tqZ6/9DGGm5
	6o9Kk4K066a78AOd/5jaShnz2I5ACM3lnGCpt8w+1aquL8ulKg6ZhbTIs7V51RYnK+7/aeQHNDh2r
	1Ob2EhYg27hCsuOyT1SlKZuD3gvjeLnb/I8nUuepHS7rlFsA9BRGvSg/UD91cRjBXLflzwvDK/we4
	Y5nVvQhZk+ByKUuwdMdkHFCGkb7nqmw2nLIG7uTDFq5O1YIeB0tldpvG3yqfiqu18V7Tq9QQAbISJ
	Qhj4iAYQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wCPRy-000D8i-2P;
	Tue, 14 Apr 2026 00:08:10 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	dw@davidwei.uk,
	pabeni@redhat.com,
	razor@blackwall.org
Subject: [PATCH net-next v2 1/3] tools/ynl: Make YnlFamily closeable as a context manager
Date: Tue, 14 Apr 2026 00:08:04 +0200
Message-ID: <20260413220809.604592-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413220809.604592-1-daniel@iogearbox.net>
References: <20260413220809.604592-1-daniel@iogearbox.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278210-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24CED3F3B62
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


