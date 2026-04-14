Return-Path: <netdev+bounces-278514-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJnBNFVh3mn+CQAAu9opvQ
	(envelope-from <netdev+bounces-278514-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:46:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6F83FC17A
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A11F130AFA7B
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170ED3D8135;
	Tue, 14 Apr 2026 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MNglCthu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B8D2DA768
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181199; cv=none; b=Y9ZijopiMGhbUJXymbaQZhP5rMZFN4mFct/K9Itz5hfhsh/IEk3yHUUclXVzOkRpr0I8JPe5BxaSZIkQFnkqGNzWjbGCehTG/SuY9Q6YLiQjg2AiyViS9903roeZ04dmhFmrGNUR95/PJ8TB4Ph6hYaOluqlXUfv+M7HQQ8oxvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181199; c=relaxed/simple;
	bh=UYBKmH4EGZDOhst1V9HKHk7lKiIbG0HcupkVW46Dloc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggX08c7pyGrUAhR2/dm7cdeCg4YsubbUVgYrLnb6qgqCtlsCmLDVRhX0ItH28YUVHfj0W8fEjkquVG+xKzvLaDWzavhcdiR7iUQPO+2joE7MQuV4xYaeVLr20DU7gAGxKFxWxy3qUtzUMe2syhvuc5yfHOxwnCXKZGjTd5c/Mtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=MNglCthu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28813C19425;
	Tue, 14 Apr 2026 15:39:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MNglCthu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1776181197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lHT13fg6yvsqPaOe8/K4rh+POPJwgxF0sB7N+D7U8ag=;
	b=MNglCthunBioV0d2V0q440e5LKjT9iFIwdUuapEQTKleyCe3CKoFxqYcQieAl27Mtf5vqU
	bPw9ULZyd/dnUUlpmoaVffYO0Y7lxA4mEn7C9eYLjiPNaUO+oJnKOXvKX0jgWrylGRvJMC
	4FIoUxOg5kK3m74LKw+Hp522B2+N9es=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 34eccd26 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Apr 2026 15:39:57 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 3/4] wireguard: allowedips: remove redundant space
Date: Tue, 14 Apr 2026 17:39:43 +0200
Message-ID: <20260414153944.2742252-4-Jason@zx2c4.com>
In-Reply-To: <20260414153944.2742252-1-Jason@zx2c4.com>
References: <20260414153944.2742252-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zx2c4.com,quarantine];
	R_DKIM_ALLOW(-0.20)[zx2c4.com:s=20210105];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[zx2c4.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278514-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Jason@zx2c4.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,zx2c4.com:email,zx2c4.com:dkim,zx2c4.com:mid]
X-Rspamd-Queue-Id: 8C6F83FC17A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Not a contentful commit, but amusingly found when porting ba3d7b93 to
Windows.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/selftest/allowedips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireguard/selftest/allowedips.c b/drivers/net/wireguard/selftest/allowedips.c
index 2da3008c3a014..3e857e6fb627b 100644
--- a/drivers/net/wireguard/selftest/allowedips.c
+++ b/drivers/net/wireguard/selftest/allowedips.c
@@ -623,7 +623,7 @@ bool __init wg_allowedips_selftest(void)
 	test_boolean(!remove(6, b, 0x24446801, 0x40e40800, 0xdeaebeef, 0xdefbeef, 128));
 	test(6, a, 0x24446801, 0x40e40800, 0xdeaebeef, 0xdefbeef);
 	/* invalid CIDR should have no effect and return -EINVAL */
-	test_boolean(remove(6, a, 0x24446801, 0x40e40800, 0xdeaebeef, 0xdefbeef, 129)  == -EINVAL);
+	test_boolean(remove(6, a, 0x24446801, 0x40e40800, 0xdeaebeef, 0xdefbeef, 129) == -EINVAL);
 	test(6, a, 0x24446801, 0x40e40800, 0xdeaebeef, 0xdefbeef);
 	remove(6, a, 0x24446801, 0x40e40800, 0xdeaebeef, 0xdefbeef, 128);
 	test_negative(6, a, 0x24446801, 0x40e40800, 0xdeaebeef, 0xdefbeef);
-- 
2.53.0


