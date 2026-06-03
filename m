Return-Path: <netdev+bounces-294839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zAyeCL9YIGq81gAAu9opvQ
	(envelope-from <netdev+bounces-294839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:39:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BD3639D56
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:39:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cex9yb8L;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294839-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294839-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9727305FE33
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 16:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFB5401A10;
	Wed,  3 Jun 2026 16:29:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EEE2EF653;
	Wed,  3 Jun 2026 16:29:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780504195; cv=none; b=of0Tz6oSvTEkVAyYebV//RyJi0W4dTmbLh2pwfxXuTTg5bZc8yaqoSW4lf1xxyArIpFV56wNWRZxeL2oiQjXJewKt/THkqmHv4Y2j5sBjYUkP7HLH+DD4D/RBUB7iNOX6PmHiHOaa5VmOoQMT/gO3HBNYVhxJwKkN31UJ3qIbPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780504195; c=relaxed/simple;
	bh=6uKG0pM6J8L5AeSbQ1InCVY0q5DwTjDEIszIKL4VgQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J0VGbaBKQXq4rvhHePngcqJTr2T6I0061Ku/MGxBIrNfrXEz1B/VxmVDjXUOQZsm0aovjAlPLbMoi6pP1zXlVcYBX81sPZT+Nc6y/hEbNnw+iSxIi/BMFQjIrjeRMqCDbNVJFOdRh4DVAIcYg56hHX6R8KVx8FoVv5F6ukNeuIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cex9yb8L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADE11F00893;
	Wed,  3 Jun 2026 16:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780504194;
	bh=qWc4Pg9S5Yrbzz6mVTDrVjWosTqWIsAjK4BlyMO77W0=;
	h=From:To:Cc:Subject:Date;
	b=cex9yb8LHXPviBXRPHWsU96LYwqt0JeCU3Mh4GxR0LogNLs7p7ViLv6ngz1E5fiMF
	 HbXo5CBlJy+gEvtNcespaUEYW77W3dcF3xVwWG3r5kbFgsl/p6NDfMhtrmg1PKZ3mO
	 cQHcmcdgjqsJUJnJ7h1beM/ea21D3DW7/bd9zffU2W9+gxB6qYqXK57/IScyDUDH2S
	 AKGU61pgESQe4xA2y9D0AhXECsxR8GXfaO02J6KdfOmlfDbwPr/SjIx53+0yEVb3lF
	 y1lUEw8c9FdJ54mvO6hN0IOfYEkRDTf+Db/lNN7hD9ZEJaZAYFj09KgF3RAL2FaTYK
	 s61XvwVIrDw4Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	johannes@sipsolutions.net,
	Jakub Kicinski <kuba@kernel.org>,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next] docs: exclude driver and netdevsim bugs
Date: Wed,  3 Jun 2026 09:29:43 -0700
Message-ID: <20260603162943.2406080-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:johannes@sipsolutions.net,m:kuba@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:workflows@vger.kernel.org,m:linux-doc@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294839-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lwn.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85BD3639D56

Initial wave of AI-generated fixes was mostly for core and protocols
we care about. But the number of irrelevant driver fixes is slowly
increasing. Add a section of explicit exclusions to our maintainer
profile.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: corbet@lwn.net
CC: skhan@linuxfoundation.org
CC: workflows@vger.kernel.org
CC: linux-doc@vger.kernel.org
---
 Documentation/process/maintainer-netdev.rst | 28 +++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index ec7b9aa2877f..cc4b5fa3b5c1 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -272,6 +272,34 @@ the case today. Please follow the standard stable rules in
 :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`,
 and make sure you include appropriate Fixes tags!
 
+Bug fixes
+~~~~~~~~~
+
+Unless explicitly excluded all bug fixes should be targeting the ``net``
+tree and contain an appropriate Fixes tag.
+
+Obvious exclusions:
+
+ - fixes for bugs which only exist in ``net-next`` should target ``net-next``
+   (please still include the Fixes tag in the commit message)
+ - bugs which cannot be reached, e.g. in code paths not executed given
+   current in-tree callers
+ - fixes for compiler warnings and typos
+
+Fixes for selftests and selftest-related infrastructure (most notably
+including the ``netdevsim`` driver) are only considered ``net``-worthy
+if they substantially reduce the flakiness of the test.
+
+Additionally, netdev does not consider bugs to be ``net``-worthy
+if they fulfill **all** of the following criteria:
+ - bug is in a hardware device driver;
+ - bug is either a missing error handling or is part of the error handling flow;
+ - bug was discovered by a static analysis / AI tool;
+ - bug was triggered/observed only with kernel changes or fault injection.
+Fixes for such bugs should default to ``net-next`` and should **not** contain
+a Fixes tag. Networking or driver maintainers may redirect such fixes to ``net``
+at their discretion if they consider the condition to be relevant enough.
+
 Security fixes
 ~~~~~~~~~~~~~~
 
-- 
2.54.0


