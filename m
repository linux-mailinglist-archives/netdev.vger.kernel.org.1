Return-Path: <netdev+bounces-275214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDl/K+gn0Gko4AYAu9opvQ
	(envelope-from <netdev+bounces-275214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:49:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 090E839844C
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 999143053645
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 20:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127353BD237;
	Fri,  3 Apr 2026 20:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="epoQLn+s";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dW1tQzW0"
X-Original-To: netdev@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD9E23D7FB;
	Fri,  3 Apr 2026 20:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775249173; cv=none; b=NOSt5359zcWfKaEoruGqCG/6IRslBS4blzvrkqHHd9+48aZdxJNKVpxytoZELyM+XNQAWh145rN6OZkoBIafiy3JfVGsp6JeZzqbjJm2EWLbxLgk3zVUmIjpgtXH3mKeo6A+hcVaoiocldu0N4/Tq7VOHqn9/n0yQ0vGbbyANns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775249173; c=relaxed/simple;
	bh=suheY/UrH8prsaVcQ3uhpQYUXmPEpsKJn7ro7xcYLN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VXTQlOJX86uiYjuJT9umLGwVSKud7TRHdquZOF4uzo3bF0f5CD/VAGm0RToR2OQb8iYMwXa4BPC4xlap7I+w7dkmLB+faee7zDQqq1hfouKekRkQvOSNrgusgPaGlK3SpUxtSiXGhiFtHVr0m1Rn9B7ZLWGvAo3JJjxwHSZYUw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=epoQLn+s; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=dW1tQzW0; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4fnW2y3clczB12x;
	Fri,  3 Apr 2026 22:46:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775249162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K4qIv147Xt8rsVwGLVGnAClnwr+dtQhi4QaadIQ4afc=;
	b=epoQLn+sS3rsaQoxZNQFKGBI6OopP+13vcsbEWcRl4oGApB05jrIjlL2G3kroxb8F7zrrv
	JYRtzPDxSe8bmmW3OLy1W9dlPVnf0S63y6RKP9O1x4LmBemGg7lIDr9YVZAGztaLW7os8q
	OXUXCu+VyEU6Oa1yBlguBPNcDv4sG2QJdsaqxpSuEUzAQqD08Xdb057Pxngje+ragtluu8
	sDhl+qYMuGCwV37JBPTB8TMNPv4JrtD4NpwsQY/wqpYbIWPsLb8LT7nF64jHMHBYONUaUz
	E8qA6IC+zaGTg2vpKrlkfZOmdWr7h1EogTLbpe/2KMQ0SfYBener358aufq7rQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=dW1tQzW0;
	spf=pass (outgoing_mbo_mout: domain of mashiro.chen@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=mashiro.chen@mailbox.org
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775249160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K4qIv147Xt8rsVwGLVGnAClnwr+dtQhi4QaadIQ4afc=;
	b=dW1tQzW07GAK2JC1ibLKwi1A1G6hvGHgnwHx2WnHMgV2yd9AeHlzLIODqP4QRaNlOX2w9B
	/qfoXsYgjDul7HvafMEN73/hdwJCfdxYJIwgRnrwc2Xz5bgAN+JiUxDtjeI14GW8iwUl7X
	wHh3TWL45zRnaU7O2ddn3MsQ4rlQNYNO4wQaeMIW2KDJ5GwxIPMacSTzAgMhyVbvmHCRF2
	aP4SPgIqWtA2pmWfYUry8wiakkpZ5B4tVt2SPrIwuY/ORFl/z+XSpgW0+9TdOal4aOgZgV
	HcymW7Fc7SbVvm4nYrJZOePxPAz2R4bqtMJxN2fK7uL71GhtRDNoUXAzO+xHVg==
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	linux-hams@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mashiro Chen <mashiro.chen@mailbox.org>,
	syzbot+abd2b69348e2d9b107a1@syzkaller.appspotmail.com
Subject: [PATCH net] net: rose: stop timers before freeing neighbour in rose_neigh_put
Date: Sat,  4 Apr 2026 04:44:59 +0800
Message-ID: <20260403204459.124812-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: sbwep65h3pxq3iomk4695c9my5itzwek
X-MBO-RS-ID: 8e464e809dfb223fc14
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275214-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,abd2b69348e2d9b107a1];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailbox.org:dkim,mailbox.org:email,mailbox.org:mid]
X-Rspamd-Queue-Id: 090E839844C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rose_neigh_put() frees the rose_neigh object when the reference count
reaches zero, but does not stop the t0timer and ftimer beforehand.
If a timer has been scheduled and fires after the object is freed,
the callback will access already-freed memory, leading to a
use-after-free.

For example, this can happen when rose_timer_expiry() in ROSE_STATE_2
calls rose_neigh_put() dropping the last reference while the
neighbour's t0timer is still pending:

  rose_timer_expiry() (ROSE_STATE_2)
    rose_neigh_put(rose->neighbour)   --> refcount drops to 0, kfree
  ...
  rose_t0timer_expiry()               --> UAF: accesses freed neigh

Fix this by calling timer_delete_sync() for both t0timer and ftimer
in rose_neigh_put() before freeing the object. This ensures any
pending or running timer callback completes before the memory is
released.

This is safe because rose_neigh_put() is never called from the
neigh's own timer callbacks (t0timer_expiry / ftimer_expiry), so
timer_delete_sync() cannot deadlock.

Reported-by: syzbot+abd2b69348e2d9b107a1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=abd2b69348e2d9b107a1
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
---
 include/net/rose.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/rose.h b/include/net/rose.h
index 2b5491bbf39ab..c69024e865456 100644
--- a/include/net/rose.h
+++ b/include/net/rose.h
@@ -160,6 +160,8 @@ static inline void rose_neigh_hold(struct rose_neigh *rose_neigh)
 static inline void rose_neigh_put(struct rose_neigh *rose_neigh)
 {
 	if (refcount_dec_and_test(&rose_neigh->use)) {
+		timer_delete_sync(&rose_neigh->t0timer);
+		timer_delete_sync(&rose_neigh->ftimer);
 		if (rose_neigh->ax25)
 			ax25_cb_put(rose_neigh->ax25);
 		kfree(rose_neigh->digipeat);
-- 
2.53.0


