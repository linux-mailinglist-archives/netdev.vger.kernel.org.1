Return-Path: <netdev+bounces-256734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MEUKClpg2kbmgMAu9opvQ
	(envelope-from <netdev+bounces-256734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:43:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D482EE9396
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF991303C132
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 15:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE10423A63;
	Wed,  4 Feb 2026 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rt+B6zt2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66239421EE7
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218410; cv=none; b=mLIFU5ZfCRhE7P2US2QcvV9znTcaLhcQ5oLNL6WYBdhxFDJy6CARnl+jU/Z5KmRTtJzBYPBSirOTt6ERuzicbRmoEASKzIJCOSNPmYhsrmn+80nvOjRWQHQLbsKFjiEAUJaah9h/yO3TZYy7WQtEMVBSG3NXfjd9pjVlOGvevo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218410; c=relaxed/simple;
	bh=dxAvJxjujXNZpknLxNF/88cnBbkeW92sUEriI7kP+U4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nevBmHQKOEvf+7BV0KCdz6DYGScVZ0pTIvOU+swTpSxgJTYV5A8WPLUe8FU3OQapgboitUVZFGDRNcCnGsePQ1mRwd5QNBMeMgE6rAXNvHvlRSpQkmKNhklGGgQvPAiQx1XWIvgoYlZwLKEN5ml/WwA0iTxZJ1mk8M95LMU1YRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rt+B6zt2; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-794e0e933ccso33570277b3.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 07:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770218409; x=1770823209; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LOgDKprzLNk/M5L64iqCKl1A9hUUu7EpJXq39MXIcgA=;
        b=Rt+B6zt2G9xi8H9lbj7wvI2acsXaGax3WpWicJ4EbWZInEgFTTJXTFk7EvXVcig5KW
         uT8rRzMeOHrR0DzOqnoVXMIk8WNSk3skFuAVRw2UkqEHUEjeOgmEILa2+/0/ll7e80an
         mtqQQVYLjWdcII0uyQ/6cobCdiz7ijsfP5qbOGJWU6u4lRMSQGB9H5WbTmog9wqYTxTt
         0toCHrOadZ6F7AI+ZBS+lewN1rbQ/3NMORUc8CwiK8d7fygyPBPOBaAy07sKrgGrsNTw
         tvQnQaNSXuLiXFZ1X2RwEu6urhndGwphgolsUd3Gl20V2GDwZLIOT+BTn8VYjukgZm6/
         n7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770218409; x=1770823209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LOgDKprzLNk/M5L64iqCKl1A9hUUu7EpJXq39MXIcgA=;
        b=Az6nPIys5W97JCyBkxCcxuGsNfgTKOm5uxivWdfWQua9kHlitZlByV5uxO7klf7f25
         833+v2GLgLlvFoMnOHIz6oEHDKlHW81F42/csr9jH+fGgn8rmXNMalPF8mKWElZmf5kI
         qFmEfe57jbb+r4m+IWBkRP+HiU8rDoYeXDYA+jAj/TxnE3BlP6+8ZDclys8jnKdJNoTF
         COd+5kt9elKL80KdPAYsFEcID6y385oBOS4MkOI2AEOJmb5/Fsc7Br7+Krrwmx+nBvCY
         q75JF6I674O2vM0+DT4V+rrS7qItGMJaQlI0mkDPiV0kC7Fjm2Ll+YQ+xnDR79kysNco
         A7mg==
X-Gm-Message-State: AOJu0YybF+eTVZb8jDY7hg+9/CKFBBwO6ARNY8ln3my/e0uwoomSCRWp
	4iNwRD/MK3i26zYYC5Uq+IKFfc2UW9gc1hWLOdCsOXV+gTK2fOjT6S3e
X-Gm-Gg: AZuq6aLY9ykSblQcQ/kl0bfzSTz6j+7Aqbg1FOyiiry0WO5GlfdCdXlrjBket0izg80
	svg5uZSD3mnzA0bdNSt7J5u/bmuWe/IGo/th16AIJbxy1TJOlU0D+QCk7T6zrcqc+u0rQuarM0q
	nde7PUdKJpFW3nUFk2+y/cCgY18RiWOz0UTwqSVlCxlXnZY8oIXvqRFTnOzgbjBoAT+B+huzayl
	vya7CXl/QODNZD3c0jxP2Gf9dLW1fgBpZcGWVYPNTETNwBiZW96n0YemX+N7g6bHX8QiAgM6Ko1
	J69f/HzLEnncOA1iss+OP6MPJNOrYjI9NjC0E520nZ2fwY2P1nNiqeuHHR/oiRGkr/AsiSexAoF
	dLIheNy0W7TMdFrn+he8B7l6AKflTqgpbg3IXmroptB/wWbVI+UB0PyHMvvjBO2aTVLeepIdIU7
	T58GLyEAr/
X-Received: by 2002:a05:690c:6c91:b0:795:10f0:3342 with SMTP id 00721157ae682-79510f050a1mr3384537b3.61.1770218409257;
        Wed, 04 Feb 2026 07:20:09 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:59::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794fefe86e2sm23023337b3.45.2026.02.04.07.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 07:20:08 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Wed, 04 Feb 2026 07:20:05 -0800
Subject: [PATCH net-next 1/9] psp: support rx rekey operation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-psp-v1-1-5f034e2dfa36@gmail.com>
References: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
In-Reply-To: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, Boris Pismenny <borisp@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Daniel Zahka <daniel.zahka@gmail.com>
X-Mailer: b4 0.13.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256734-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,nvidia.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D482EE9396
X-Rspamd-Action: no action

Support rx-assoc netlink operation on an already keyed socket.

Performing an rx-rekey on a socket involves splicing a new psp_assoc
object with newly generated rx state and reused tx state into a
socket's psp_assoc field. Add a 'prev' field to struct psp_assoc,
because we need to be able to accept skb's matching the previous
assoc. For SADB implementations, after copying the tx state of the
assoc, we need to mark the prior assoc as not needing tx key
cleanup. The 'tx_moved' field is introduced to struct psp_assoc for
this purpose.

With this change, skb's matching the current or previous psp_assoc
will be accepted. It might be reasonable to stop accepting skb's on
the previous assoc after seeing skb's with the new assoc and after
waiting a grace period, but that is not implemented for now.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 include/net/psp/functions.h |  6 ++++++
 include/net/psp/types.h     |  3 +++
 net/psp/psp.h               |  6 +++---
 net/psp/psp_nl.c            |  6 +-----
 net/psp/psp_sock.c          | 41 +++++++++++++++++++++++++++--------------
 5 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
index c5c23a54774e..0f8b16f2f093 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -103,6 +103,12 @@ __psp_sk_rx_policy_check(struct sk_buff *skb, struct psp_assoc *pas)
 		return 0;
 	}
 
+	if (pas->prev && psp_pse_matches_pas(pse, pas->prev)) {
+		pas->peer_tx = 1;
+		pas->prev->peer_tx = 1;
+		return 0;
+	}
+
 	if (!pse) {
 		if (!pas->tx.spi ||
 		    (!pas->peer_tx && psp_is_allowed_nondata(skb, pas)))
diff --git a/include/net/psp/types.h b/include/net/psp/types.h
index 25a9096d4e7d..52844ac6f870 100644
--- a/include/net/psp/types.h
+++ b/include/net/psp/types.h
@@ -139,6 +139,9 @@ struct psp_assoc {
 
 	u32 upgrade_seq;
 
+	struct psp_assoc *prev;
+
+	bool tx_moved;
 	struct psp_key_parsed tx;
 	struct psp_key_parsed rx;
 
diff --git a/net/psp/psp.h b/net/psp/psp.h
index 9f19137593a0..b86539d5137a 100644
--- a/net/psp/psp.h
+++ b/net/psp/psp.h
@@ -21,9 +21,9 @@ void psp_nl_notify_dev(struct psp_dev *psd, u32 cmd);
 struct psp_assoc *psp_assoc_create(struct psp_dev *psd);
 struct psp_dev *psp_dev_get_for_sock(struct sock *sk);
 void psp_dev_tx_key_del(struct psp_dev *psd, struct psp_assoc *pas);
-int psp_sock_assoc_set_rx(struct sock *sk, struct psp_assoc *pas,
-			  struct psp_key_parsed *key,
-			  struct netlink_ext_ack *extack);
+void psp_sock_assoc_set_rx(struct sock *sk, struct psp_assoc *pas,
+			   struct psp_key_parsed *key,
+			   struct netlink_ext_ack *extack);
 int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
 			  u32 version, struct psp_key_parsed *key,
 			  struct netlink_ext_ack *extack);
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index 6afd7707ec12..a540a1e77694 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -446,11 +446,7 @@ int psp_nl_rx_assoc_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_free_pas;
 	}
 
-	err = psp_sock_assoc_set_rx(socket->sk, pas, &key, info->extack);
-	if (err) {
-		NL_SET_BAD_ATTR(info->extack, info->attrs[PSP_A_ASSOC_SOCK_FD]);
-		goto err_free_pas;
-	}
+	psp_sock_assoc_set_rx(socket->sk, pas, &key, info->extack);
 	psp_assoc_put(pas);
 
 	return psp_nl_reply_send(rsp, info);
diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index f785672b7df6..3a8abd023f99 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -85,7 +85,7 @@ static int psp_dev_tx_key_add(struct psp_dev *psd, struct psp_assoc *pas,
 
 void psp_dev_tx_key_del(struct psp_dev *psd, struct psp_assoc *pas)
 {
-	if (pas->tx.spi)
+	if (pas->tx.spi && !pas->tx_moved)
 		psd->ops->tx_key_del(psd, pas);
 	list_del(&pas->assocs_list);
 }
@@ -99,6 +99,7 @@ static void psp_assoc_free(struct work_struct *work)
 	if (psd->ops)
 		psp_dev_tx_key_del(psd, pas);
 	mutex_unlock(&psd->lock);
+	psp_assoc_put(pas->prev);
 	psp_dev_put(psd);
 	kfree(pas);
 }
@@ -129,30 +130,42 @@ void psp_sk_assoc_free(struct sock *sk)
 	psp_assoc_put(pas);
 }
 
-int psp_sock_assoc_set_rx(struct sock *sk, struct psp_assoc *pas,
-			  struct psp_key_parsed *key,
-			  struct netlink_ext_ack *extack)
+static void psp_sock_rx_rekey(struct psp_assoc *pas, struct psp_assoc *prev)
 {
-	int err;
+	lockdep_assert_held(&pas->psd->lock);
+
+	pas->peer_tx = prev->peer_tx;
+	pas->upgrade_seq = prev->upgrade_seq;
+
+	/* steal refcount from sk->psp_assoc */
+	pas->prev = prev;
+
+	memcpy(&pas->tx, &prev->tx, sizeof(pas->tx));
+	memcpy(pas->drv_data, prev->drv_data, pas->psd->caps->assoc_drv_spc);
+	prev->tx_moved = true;
+
+	psp_assoc_put(prev->prev);
+	prev->prev = NULL;
+}
+
+void psp_sock_assoc_set_rx(struct sock *sk, struct psp_assoc *pas,
+			   struct psp_key_parsed *key,
+			   struct netlink_ext_ack *extack)
+{
+	struct psp_assoc *prev;
 
 	memcpy(&pas->rx, key, sizeof(*key));
 
 	lock_sock(sk);
 
-	if (psp_sk_assoc(sk)) {
-		NL_SET_ERR_MSG(extack, "Socket already has PSP state");
-		err = -EBUSY;
-		goto exit_unlock;
-	}
+	prev = psp_sk_assoc(sk);
+	if (prev)
+		psp_sock_rx_rekey(pas, prev);
 
 	refcount_inc(&pas->refcnt);
 	rcu_assign_pointer(sk->psp_assoc, pas);
-	err = 0;
 
-exit_unlock:
 	release_sock(sk);
-
-	return err;
 }
 
 static int psp_sock_recv_queue_check(struct sock *sk, struct psp_assoc *pas)

-- 
2.47.3


