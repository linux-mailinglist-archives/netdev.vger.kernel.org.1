Return-Path: <netdev+bounces-293014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAasKn47GWpVtAgAu9opvQ
	(envelope-from <netdev+bounces-293014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:08:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBD85FE56C
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E955301AFF8
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6373AEF3B;
	Fri, 29 May 2026 07:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rexion.ai header.i=@rexion.ai header.b="dz1/UVW0"
X-Original-To: netdev@vger.kernel.org
Received: from out-13.smtp.spacemail.com (out-13.smtp.spacemail.com [63.250.43.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09F83557F3
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 07:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780038517; cv=none; b=LnkD+t56n1RUd4+dp/a5FWmnawM7p3BpNB5iTxfdWzV0eIBbW9t9DE5QAIyA7UkfJZpLg9v+KwOyR3UObUJytJA1Jd7BOXnRGwrt2ILtKxJzlDA0f1mJzACEwGeucdohS9WWyTOD7Qaf4BfRGGgF4cLng306xkQc7N614OpaEUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780038517; c=relaxed/simple;
	bh=w8rDCImo45cNeBBAbXgouK/H1dZRWJTLqul97uC6D6U=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Message-Id:Date; b=ULLGBMGHGV9BDnYeDSyztvcENukb6UR5LMPSEV2R/x2hAL8PmVBFyd1lrqxEOlZZ2GZYPQXQXVNYB4haFXCzCf6bSY6fe9R4OGbz9FUNdsNP+dQLS1LSWOwCoXwdixqypYPAWh+Kx6KTl6XLo06LpHAoNA5XqAgym0tRKgPj2Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexion.ai; spf=pass smtp.mailfrom=rexion.ai; dkim=fail (0-bit key) header.d=rexion.ai header.i=@rexion.ai header.b=dz1/UVW0 reason="key not found in DNS"; arc=none smtp.client-ip=63.250.43.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexion.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rexion.ai
Received: from [127.0.1.1] (unknown [49.207.213.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4gRZFl1CWvz2x9j;
	Fri, 29 May 2026 07:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rexion.ai;
	s=spacemail; t=1780038508;
	bh=UrxZMTH5tjC9YYUvda+5w8ejK65Zl6QfToffy/U/zvY=;
	h=From:To:Cc:Subject:Date:From;
	b=dz1/UVW0WV/0s64gNVtPtlXAbAhdKYIZ06eP9AjfvaZWJl5kIzbCBKRBYk/1Gmdxz
	 fmWXtWqcTxlY2KHLrbKPfsIl3sG5OoHq6xkRzidLZESxMMEmG7tgL1KLevEYF2jN9W
	 42ErGs6LDiwAm7+Xjf8uL8E8AopaioQyJdGXPEuZGY0TQo5E9tBeAdpxKY2PN9Hbha
	 My0tL01YwaoTBcF5d2ervqPO351SBpDXVhHxH+sh8lmR/cMXgCUgbno07bQ1L8XhVz
	 dgDzSh2iU0caqYqF3nIdJjslueG3V3FrnbIy5oD+f+fzn3pUpXv0vcfjtngQGTut58
	 L/lCEGCogflUQ==
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Rahul Chandelkar <rc@rexion.ai>
To: netdev@vger.kernel.org
Cc: Alexandra Winter <wintera@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, Wenjia Zhang <wenjia@linux.ibm.com>
Subject: [PATCH net] dibs: fix use-after-free in dmb lookup functions
Message-Id: <4gRZFl1CWvz2x9j@mail.spacemail.com>
Date: Fri, 29 May 2026 07:08:26 +0000 (UTC)
X-Envelope-From: rc@rexion.ai
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[rexion.ai];
	TAGGED_FROM(0.00)[bounces-293014-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_PERMFAIL(0.00)[rexion.ai:s=spacemail];
	DKIM_TRACE(0.00)[rexion.ai:~];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rc@rexion.ai,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,rexion.ai:email,mail.spacemail.com:mid]
X-Rspamd-Queue-Id: 4CBD85FE56C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From 68f633e58deb6edffa435a3b2bdc4a12a5e36daf Mon Sep 17 00:00:00 2001
From: Rahul Chandelkar <rc@rexion.ai>
Date: Fri, 29 May 2026 12:32:34 +0530
Subject: [PATCH net] dibs: fix use-after-free in dmb lookup functions

dibs_lo_attach_dmb(), dibs_lo_detach_dmb(), and dibs_lo_unregister_dmb()
all release read_lock_bh before operating on the dmb_node pointer found
during hash table lookup. A concurrent unregister on the same token can
kfree() the node in this window, causing a use-after-free when the
original caller subsequently performs refcount_inc_not_zero() or
refcount_dec_and_test() on the freed object.

Fix by performing the refcount operation while still holding read_lock_bh,
so the node cannot be freed between lookup and use. Release the lock
before any code path that may call __dibs_lo_unregister_dmb(), since that
function acquires write_lock_bh internally via hash_del().

Fixes: cb990a45d7f6 ("dibs: Define dibs loopback")
Signed-off-by: Rahul Chandelkar <rc@rexion.ai>
---
 drivers/dibs/dibs_loopback.c | 42 +++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/dibs/dibs_loopback.c b/drivers/dibs/dibs_loopback.c
index ec3b48cb0e87..d7c779cc0d9b 100644
--- a/drivers/dibs/dibs_loopback.c
+++ b/drivers/dibs/dibs_loopback.c
@@ -150,17 +150,21 @@ static int dibs_lo_unregister_dmb(struct dibs_dev *dibs, struct dibs_dmb *dmb)
 			break;
 		}
 	}
-	read_unlock_bh(&ldev->dmb_ht_lock);
-	if (!dmb_node)
+	if (!dmb_node) {
+		read_unlock_bh(&ldev->dmb_ht_lock);
 		return -EINVAL;
+	}
+	if (!refcount_dec_and_test(&dmb_node->refcnt)) {
+		read_unlock_bh(&ldev->dmb_ht_lock);
+		return 0;
+	}
+	read_unlock_bh(&ldev->dmb_ht_lock);
 
-	if (refcount_dec_and_test(&dmb_node->refcnt)) {
-		spin_lock_irqsave(&dibs->lock, flags);
-		dibs->dmb_clientid_arr[dmb_node->sba_idx] = NO_DIBS_CLIENT;
-		spin_unlock_irqrestore(&dibs->lock, flags);
+	spin_lock_irqsave(&dibs->lock, flags);
+	dibs->dmb_clientid_arr[dmb_node->sba_idx] = NO_DIBS_CLIENT;
+	spin_unlock_irqrestore(&dibs->lock, flags);
 
-		__dibs_lo_unregister_dmb(ldev, dmb_node);
-	}
+	__dibs_lo_unregister_dmb(ldev, dmb_node);
 	return 0;
 }
 
@@ -184,16 +188,10 @@ static int dibs_lo_attach_dmb(struct dibs_dev *dibs, struct dibs_dmb *dmb)
 			break;
 		}
 	}
-	if (!dmb_node) {
-		read_unlock_bh(&ldev->dmb_ht_lock);
-		return -EINVAL;
-	}
+	if (dmb_node && !refcount_inc_not_zero(&dmb_node->refcnt))
+		dmb_node = NULL;
 	read_unlock_bh(&ldev->dmb_ht_lock);
-
-	if (!refcount_inc_not_zero(&dmb_node->refcnt))
-		/* the dmb is being unregistered, but has
-		 * not been removed from the hash table.
-		 */
+	if (!dmb_node)
 		return -EINVAL;
 
 	/* provide dmb information */
@@ -220,14 +218,14 @@ static int dibs_lo_detach_dmb(struct dibs_dev *dibs, u64 token)
 			break;
 		}
 	}
-	if (!dmb_node) {
+	if (dmb_node && refcount_dec_and_test(&dmb_node->refcnt)) {
 		read_unlock_bh(&ldev->dmb_ht_lock);
-		return -EINVAL;
+		__dibs_lo_unregister_dmb(ldev, dmb_node);
+		return 0;
 	}
 	read_unlock_bh(&ldev->dmb_ht_lock);
-
-	if (refcount_dec_and_test(&dmb_node->refcnt))
-		__dibs_lo_unregister_dmb(ldev, dmb_node);
+	if (!dmb_node)
+		return -EINVAL;
 	return 0;
 }
 
-- 
2.54.0


