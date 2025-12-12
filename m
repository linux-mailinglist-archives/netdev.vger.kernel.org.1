Return-Path: <netdev+bounces-244455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 059C5CB7E16
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 05:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 944CC30056B9
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 04:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC88D30C37E;
	Fri, 12 Dec 2025 04:42:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from chocolate.ash.relay.mailchannels.net (chocolate.ash.relay.mailchannels.net [23.83.222.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9727330C371
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 04:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765514523; cv=pass; b=lOxFRLZpf5bPd/og8w1p8aCt4Fn0Vb2STxPxbiuozqw+j21AIyh3L+wh2NaHXaAyO9Eg5GdDVfPHPuJZADkfPRPwjI0n0HKkOK9ajARbWz2BSyU1aFELDhAsVZGNp6HDFdo5mqoqx74asBXzOvLL2oRKq37nNuCR9N/9XDlMPbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765514523; c=relaxed/simple;
	bh=i9EL2uipxz9iTlo3aKqa+Q5Env0NJaULxilf6q6/6AA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbTSpxenkr2qvw1fttsJgePVaR2CvutQlTeYzHUI/nUcfLt2aZYLMZZMOWep3DJQJAB3dU9cON8MkdTR6QtCwK43mZmyjVjO9llSSjfifQGphAXK7mfsODwge7jMJ9oAxhuxLZX5U9SgktwxFtRG5NjwT3pPKNER5nomb+CrCGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=christoph.anton.mitterer.name; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.222.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=christoph.anton.mitterer.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 594B574265C;
	Fri, 12 Dec 2025 04:26:18 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-green-1.trex.outbound.svc.cluster.local [100.102.46.239])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 966DA742234
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 04:26:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1765513578;
	b=YpuWLsAnFJ2pDxK4SarmnFTX3Zn+iF9HbuS27zI1srKm1bmkYI0mnHcGWtb8yeOXLB9ZRk
	NHGVJWpAkx9IdxFc055E+91F5t5ln6GvRk1oEeO+kusWcsq5TnUAdy69mx0MBLDTirvM/c
	l7cgGy3gYhrFAWq/QOGZO8iHS4yyETxI1+pCI03ic7rvT7DnsCk9gL9EGYnMCue7gvhaOT
	nLFcuDhHl/jvHXN103wBhb2TRMnpA/3OoapiuNGrV5f6dRe5pqp0C/l79dbzPSycISQZGH
	GPOuxyV8kUnQ9vp5U7qe0jaRI9iDjUIz4lUInRMiQnmPuwEXL0vAh7plNLmnQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1765513578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i+DuElYlnlw9QvWzGxjyC5murhvkBzg6t10/Pp2VRDU=;
	b=YC/l72cCL3appaWLnvRmpJ7j8UlXUPI3YUeR+bA5e/XxkU9oqMfGUmUKW6a1jyYYRGw4pE
	I/XjE3r6EwOwBBH2MjXheMmPPX+yAlh/yQfM9/o63nMvIEbgCYMNZL1lr6igttcJq3h9a/
	vufiv52VwiHSLH7wP1C+Xf/hmbyzzOnLgs233EEFgct89r+paS4kxXEZXt2AD5akFiOfru
	WZAuIxFnJ49rA/4JJwR2sABRhiykOF7WydORfRIUYtUw2WLqmtoK+gxIwYcuDCQdtble7z
	WXGPR4viaEdlcyawHzy49xOUTF/RAUprMxSNTlqaJ3rQ1apCrQrnlgtvYlJ9yg==
ARC-Authentication-Results: i=1;
	rspamd-9c757c4bc-c4qcg;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MC-Copy: stored-urls
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-White-Juvenile: 2a5f25b137cfd1df_1765513578177_4098078253
X-MC-Loop-Signature: 1765513578177:154245540
X-MC-Ingress-Time: 1765513578177
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.46.239 (trex/7.1.3);
	Fri, 12 Dec 2025 04:26:18 +0000
Received: from p5090f480.dip0.t-ipconnect.de ([80.144.244.128]:63667 helo=heisenberg.scientia.org)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <calestyo@scientia.org>)
	id 1vTujR-000000068cI-0uG2
	for netdev@vger.kernel.org;
	Fri, 12 Dec 2025 04:26:15 +0000
Received: by heisenberg.scientia.org (Postfix, from userid 1000)
	id 7817E6213AAC; Fri, 12 Dec 2025 05:26:14 +0100 (CET)
From: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
To: netdev@vger.kernel.org
Subject: [PATCH 1/1] lib: Align naming rules with the kernel
Date: Fri, 12 Dec 2025 05:18:13 +0100
Message-ID: <20251212042611.786603-2-mail@christoph.anton.mitterer.name>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251212042611.786603-1-mail@christoph.anton.mitterer.name>
References: <20251212042611.786603-1-mail@christoph.anton.mitterer.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: calestyo@scientia.org

This aligns the naming rules with those of the kernel as set in the
`dev_valid_name()`-function in `net/core/dev.c`.

It also affects the validity of altnames.

Signed-off-by: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
---
 lib/utils.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/utils.c b/lib/utils.c
index 0719281a..e4e5f337 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -851,8 +851,10 @@ static int __check_ifname(const char *name)
 {
 	if (*name == '\0')
 		return -1;
+	if (!strcmp(name, ".") || !strcmp(name, ".."))
+		return -1;
 	while (*name) {
-		if (*name == '/' || isspace(*name))
+		if (*name == '/' || *name == ':' || isspace(*name))
 			return -1;
 		++name;
 	}
-- 
2.51.0


