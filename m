Return-Path: <netdev+bounces-280013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNMvKIoR52nL3QEAu9opvQ
	(envelope-from <netdev+bounces-280013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 07:56:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1924D4369F0
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 07:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EC3D30242AE
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 05:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66FB346AE5;
	Tue, 21 Apr 2026 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iconn-networks.com header.i=@iconn-networks.com header.b="Vn42iAD6"
X-Original-To: netdev@vger.kernel.org
Received: from zebra.wilibox.com (zebra.wilibox.com [62.77.155.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C713E33D4E9;
	Tue, 21 Apr 2026 05:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.77.155.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776750964; cv=none; b=ZKtMr12+6YXD3ipD/wHmLdUrw0Sx592eKZA28c0RvMnSYTGCKCqSqAebn38ZlqRmwAiIe2uad1ldfqfe0SBg2ytq/wbAIvNe98E6xv1LdnjOSzaPwiWviSe5C2wrj1AnF4qEql1n1KNeDYHSjz0zVIBHRKD2TRFtFEOBpeh1JRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776750964; c=relaxed/simple;
	bh=DcMclXg/Po0bXxvxcx4NlEqE/X230tARdMyuBLJjepI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnldKRLY62EMBfHsM1xKe+LktcWs1Vo6vkSOyyn5YfdQuU3dDHBVEHkBTAfwd8Wf7fEg0U/ispUWADDmY2abqn5wgMh397K37RlywAYmhZDemdZQX1Z1iTt1rNpwfLm3hGYeTmAkkcqic2IXZoDK4G3UoBnosHAm1N4+inPZjpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iconn-networks.com; spf=pass smtp.mailfrom=iconn-networks.com; dkim=pass (2048-bit key) header.d=iconn-networks.com header.i=@iconn-networks.com header.b=Vn42iAD6; arc=none smtp.client-ip=62.77.155.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iconn-networks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iconn-networks.com
Received: from debian (unknown [81.7.79.211])
	(Authenticated sender: ernestas.k@iconn-networks.com)
	by zebra.wilibox.com (Postfix) with ESMTPSA id 328A7173597;
	Tue, 21 Apr 2026 08:55:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iconn-networks.com;
	s=default; t=1776750957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=77IJCLq8xtJEoLm2lUrB3oOs79h7WrubaDkPMokJfYs=;
	b=Vn42iAD6xZ8F2QYqNE1kArMwTBxltN/Hanh+nAESc6i9kFoCjhH/YJlpYOLCYLWutcXXmg
	iA0llbEqmuXniqCnYGkuDBgjK/npztT2v+AZ5ReOv8EU2NAOClywuYLvajfookgLNnjUJt
	6sEqixUSYmvJ3pXv0wQ9tMYPxKusFfzCojQSnU91MYr/X87k+RCEQuHG/FX6IAVHQRXyQZ
	3tlDIvNu2zk45yX8LEMgvGe+/sPWd4a51in8d126Dl6nX9YXRTwVAYw3W0LEekMFSejS8j
	hfcbLwporiULNG4R9c9FdWYndm4XO4Vb+GCEsHq1bmTwOfK5MWRemQojgYHAjw==
Authentication-Results: zebra.wilibox.com;
	auth=pass smtp.auth=ernestas.k@iconn-networks.com smtp.mailfrom=ernestas.k@iconn-networks.com
From: Ernestas Kulik <ernestas.k@iconn-networks.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	Ernestas Kulik <ernestas.k@iconn-networks.com>
Subject: [PATCH v2] llc: Return -EINPROGRESS from llc_ui_connect()
Date: Tue, 21 Apr 2026 08:54:58 +0300
Message-ID: <20260421055458.263071-1-ernestas.k@iconn-networks.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415063457.1008868-1-ernestas.k@iconn-networks.com>
References: <20260415063457.1008868-1-ernestas.k@iconn-networks.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280013-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernestas.k@iconn-networks.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[iconn-networks.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1924D4369F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Given a zero sk_sndtimeo, llc_ui_connect() skips waiting for state
change and returns 0, confusing userspace applications that will assume
the socket is connected, making e.g. getpeername() calls error out.

More specifically, the issue was discovered in libcoap, where
newly-added AF_LLC socket support was behaving differently from AF_INET
connections due to EINPROGRESS handling being skipped.

Set rc to -EINPROGRESS before considering blocking, akin to AF_INET
sockets.

Signed-off-by: Ernestas Kulik <ernestas.k@iconn-networks.com>
---
 net/llc/af_llc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 59d593bb5d18..1b210db3119e 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -518,12 +518,14 @@ static int llc_ui_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 	}
 
 	if (sk->sk_state == TCP_SYN_SENT) {
 		const long timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);
 
-		if (!timeo || !llc_ui_wait_for_conn(sk, timeo))
+		if (!timeo || !llc_ui_wait_for_conn(sk, timeo)) {
+			rc = -EINPROGRESS;
 			goto out;
+		}
 
 		rc = sock_intr_errno(timeo);
 		if (signal_pending(current))
 			goto out;
 	}
-- 
2.53.0


