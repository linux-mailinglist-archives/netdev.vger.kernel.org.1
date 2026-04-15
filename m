Return-Path: <netdev+bounces-278681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIiANV0032kbQQAAu9opvQ
	(envelope-from <netdev+bounces-278681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:46:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41958401044
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF4B930C3DDF
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 06:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE6D3914E4;
	Wed, 15 Apr 2026 06:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iconn-networks.com header.i=@iconn-networks.com header.b="LQ8vHv9z"
X-Original-To: netdev@vger.kernel.org
Received: from zebra.wilibox.com (zebra.wilibox.com [62.77.155.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D6E3914EE;
	Wed, 15 Apr 2026 06:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.77.155.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776235506; cv=none; b=CW4dIRNnhEJAKWvK6nn6+B3e2gFIjS2vnB8H9c/ZZb0KsW3A/gTcdq+I/P26/kNkj+ypyh9N61OD9rfj54T+9Mt6Ji2t5hjrSL+JDckz7LVOgILHxn8lelbq7rj7rtwf1Bf9KSs3A+cy0IjelAIDnuMBDcfL62iKnlPc1Pf5Ixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776235506; c=relaxed/simple;
	bh=7WTEyNFffV6w+pCAcVJLy3VQLEuiEkAU9UhKwjIbB94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DLuPGNeKGsXau4HWHWBTfTUZl9+tnSyAixRkJSGf9iYqss/8kYvEESPOs8F1TFhdXT6BETGDs9PV1+kKxGEGWKvR1MuG8zzp4nUTLf4gHHp6jxzWWNrxjh/jWzm+W6URz7+uPumG5unN9tL/AnpjG4XewupqQAGQNaXV5VvT3mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iconn-networks.com; spf=pass smtp.mailfrom=iconn-networks.com; dkim=pass (2048-bit key) header.d=iconn-networks.com header.i=@iconn-networks.com header.b=LQ8vHv9z; arc=none smtp.client-ip=62.77.155.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iconn-networks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iconn-networks.com
Received: from debian (unknown [81.7.79.211])
	(Authenticated sender: ernestas.k@iconn-networks.com)
	by zebra.wilibox.com (Postfix) with ESMTPSA id 3F08616B45F;
	Wed, 15 Apr 2026 09:35:39 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iconn-networks.com;
	s=default; t=1776234939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L05OlKW4YM2KyYAU8naVj9tMRq09rF1jmo/4V29Em5Y=;
	b=LQ8vHv9zseyWnC4CdOgzlUazV2Q2265npKJ4RnBdQswExJAbJDFl9yo9hen6MaTLmjc2Gk
	B9HjzLZwi0V/PD58Fk4tjay++VR5fC3F/xtfqzmyCl9CVSQCvYe/ZXGUhEH3VbdI0AUEce
	M0lmBgp/eMu3pMuEtS4qeKc0UXiRaYfBvmJe1Ke0UMzvqWwJtZZRr3IZIvZkoPpDkquQdy
	ooHUQaz9iEP9AajI1XXEeyacBwFPYAfUCnyz+IVh+F8CiGSFLvJ+9lGBaKKwDWWJR8YY+Q
	5lsjlBL/1JwvxjXGRf81H8U1zzGXN8PdS6tf/mSAKcNJS6M9K30J71khSxVlpQ==
Authentication-Results: zebra.wilibox.com;
	auth=pass smtp.auth=ernestas.k@iconn-networks.com smtp.mailfrom=ernestas.k@iconn-networks.com
From: Ernestas Kulik <ernestas.k@iconn-networks.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ernestas Kulik <ernestas.k@iconn-networks.com>
Subject: [PATCH] llc: Return -EINPROGRESS from llc_ui_connect()
Date: Wed, 15 Apr 2026 09:34:57 +0300
Message-ID: <20260415063457.1008868-1-ernestas.k@iconn-networks.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iconn-networks.com,quarantine];
	R_DKIM_ALLOW(-0.20)[iconn-networks.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278681-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernestas.k@iconn-networks.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iconn-networks.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iconn-networks.com:email,iconn-networks.com:dkim,iconn-networks.com:mid]
X-Rspamd-Queue-Id: 41958401044
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Given a zero sk_sndtimeo, llc_ui_connect() skips waiting for state
change and returns 0, confusing userspace applications that will assume
the socket is connected, making e.g. getpeername() calls error out.

Set rc to -EINPROGRESS before considering blocking, akin to AF_INET
sockets.

Signed-off-by: Ernestas Kulik <ernestas.k@iconn-networks.com>
---
 net/llc/af_llc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 59d593bb5d18..9317d092ba84 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -515,10 +515,12 @@ static int llc_ui_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 		sock->state  = SS_UNCONNECTED;
 		sk->sk_state = TCP_CLOSE;
 		goto out;
 	}
 
+	rc = -EINPROGRESS;
+
 	if (sk->sk_state == TCP_SYN_SENT) {
 		const long timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);
 
 		if (!timeo || !llc_ui_wait_for_conn(sk, timeo))
 			goto out;
-- 
2.53.0


