Return-Path: <netdev+bounces-257269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMDABInVhGlo5gMAu9opvQ
	(envelope-from <netdev+bounces-257269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 18:38:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 752F4F6060
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 18:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47E80308444C
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 17:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A24C2F069E;
	Thu,  5 Feb 2026 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zze8DuYz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572FD2F6918;
	Thu,  5 Feb 2026 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770312878; cv=none; b=h+tfcIP7yTgiKzxCSzjaNbFyKnMGH2EM0g1pFRsxKxwTOJH3/Zt5dDt+TU+H57jpvoSGclE3yJvTBcjW3WxrdGemsHcxmC6Lw+nLX/6JzxTT0jJHJObZLrA6UdJFkYYPUs74KuYRCU7TuN81VDqHqjgq29yTClR0D+v5Hn+nleI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770312878; c=relaxed/simple;
	bh=D/iQjOftxqGSKalGLU9OYqOcaN+EOAJaJPRQsCAyIZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cJy3TLxSxKX/ZV6hTKhwjeqUc6ZK0idKwR4bAXztSmdB9AthjHElLvcHfXO9ptNEWDtJvJJuI8yHngRhPymiNjgL/C61sfk3Ndj3ZNbTCRKyrqTO1uHzGuH6RGuhRYFr70YZKZdLuaLwpfb0TKhG06lPj4O55Jv584LqpJ7uz9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zze8DuYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0017C2BC87;
	Thu,  5 Feb 2026 17:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770312877;
	bh=D/iQjOftxqGSKalGLU9OYqOcaN+EOAJaJPRQsCAyIZI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Zze8DuYzact+B2jyEROViCDrXfJJYSJulyOvr79ZUv80Qty+hT7XLToqdsOFm0WyI
	 PH5EexxYGzgZPRoqSLpo51ELc6vytmMD/lBufxPD4QBHo0ZV1fQC6QDpCWRLey48rZ
	 +UKfgJxqS5UZ1K6+GuPDftaFA6LpNRWCOU7i8T+vfhI6l4W8Uiq7aDvdA60DL5hkKF
	 wmy/rcvtQQiunCHso+mH9rJqB6GPG4hZ3yqqhsyXYPJHE3bbn2XdPKemg7h14pxtws
	 qJxiSCyWG9M2rqvYJFN6T8xgVeu4GU+g3wwVifDcl6dfn7AJL8LQ+wqYNrYhiboPDb
	 llNJzRyNVAeww==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 05 Feb 2026 18:34:23 +0100
Subject: [PATCH net v2 3/4] mptcp: fix kdoc warnings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-net-mptcp-misc-fixes-6-19-rc8-v2-3-c2720ce75c34@kernel.org>
References: <20260205-net-mptcp-misc-fixes-6-19-rc8-v2-0-c2720ce75c34@kernel.org>
In-Reply-To: <20260205-net-mptcp-misc-fixes-6-19-rc8-v2-0-c2720ce75c34@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Donald Hunter <donald.hunter@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4561; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=D/iQjOftxqGSKalGLU9OYqOcaN+EOAJaJPRQsCAyIZI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJbriz+7BtnuytqwbOVFhOeLcmT1He5eDnjFffL5pd7F
 gnyv+H72lHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRtysZGfYz5N34YyPGk5a1
 r8P7KPfvzafYOesK5F6dnWn7a6kovzUjwxFjI9HonxNrJ+6YvZ3tUBBjs1r01d4ndR7TCy9UrOX
 JZwIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257269-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,infradead.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 752F4F6060
X-Rspamd-Action: no action

The following warnings were visible:

  $ ./scripts/kernel-doc -Wall -none \
        net/mptcp/ include/net/mptcp.h include/uapi/linux/mptcp*.h \
        include/trace/events/mptcp.h
  Warning: net/mptcp/token.c:108 No description found for return value of 'mptcp_token_new_request'
  Warning: net/mptcp/token.c:151 No description found for return value of 'mptcp_token_new_connect'
  Warning: net/mptcp/token.c:246 No description found for return value of 'mptcp_token_get_sock'
  Warning: net/mptcp/token.c:298 No description found for return value of 'mptcp_token_iter_next'
  Warning: net/mptcp/protocol.c:4431 No description found for return value of 'mptcp_splice_read'
  Warning: include/uapi/linux/mptcp_pm.h:13 missing initial short description on line:
   * enum mptcp_event_type

Address all of them: either by using the 'Return:' keyword, or by adding
a missing initial short description.

The MPTCP CI will soon report issues with kdoc to avoid introducing new
issues and being flagged by the Netdev CI.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Donald Hunter <donald.hunter@gmail.com>
v2: also modify D/n/s/mptcp_pm.yaml, used to generate i/u/l/mptcp_pm.h.
---
 Documentation/netlink/specs/mptcp_pm.yaml |  1 +
 include/uapi/linux/mptcp_pm.h             |  2 +-
 net/mptcp/token.c                         | 16 +++++++++-------
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index ba30a40b9dbf..39f3facc38e5 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -15,6 +15,7 @@ definitions:
     type: enum
     name: event-type
     enum-name: mptcp-event-type
+    doc: Netlink MPTCP event types
     name-prefix: mptcp-event-
     entries:
       -
diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_pm.h
index c97d060ee90b..fe9863d75350 100644
--- a/include/uapi/linux/mptcp_pm.h
+++ b/include/uapi/linux/mptcp_pm.h
@@ -11,7 +11,7 @@
 #define MPTCP_PM_VER	1
 
 /**
- * enum mptcp_event_type
+ * enum mptcp_event_type - Netlink MPTCP event types
  * @MPTCP_EVENT_UNSPEC: unused event
  * @MPTCP_EVENT_CREATED: A new MPTCP connection has been created. It is the
  *   good time to allocate memory and send ADD_ADDR if needed. Depending on the
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 5bb924534387..f1a50f367add 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -103,7 +103,7 @@ static void mptcp_crypto_key_gen_sha(u64 *key, u32 *token, u64 *idsn)
  * It creates a unique token to identify the new mptcp connection,
  * a secret local key and the initial data sequence number (idsn).
  *
- * Returns 0 on success.
+ * Return: 0 on success.
  */
 int mptcp_token_new_request(struct request_sock *req)
 {
@@ -146,7 +146,7 @@ int mptcp_token_new_request(struct request_sock *req)
  * the computed token at a later time, this is needed to process
  * join requests.
  *
- * returns 0 on success.
+ * Return: 0 on success.
  */
 int mptcp_token_new_connect(struct sock *ssk)
 {
@@ -241,7 +241,7 @@ bool mptcp_token_exists(u32 token)
  * This function returns the mptcp connection structure with the given token.
  * A reference count on the mptcp socket returned is taken.
  *
- * returns NULL if no connection with the given token value exists.
+ * Return: NULL if no connection with the given token value exists.
  */
 struct mptcp_sock *mptcp_token_get_sock(struct net *net, u32 token)
 {
@@ -288,11 +288,13 @@ EXPORT_SYMBOL_GPL(mptcp_token_get_sock);
  * @s_slot: start slot number
  * @s_num: start number inside the given lock
  *
- * This function returns the first mptcp connection structure found inside the
- * token container starting from the specified position, or NULL.
+ * Description:
+ *   On successful iteration, the iterator is moved to the next position and a
+ *   reference to the returned socket is acquired.
  *
- * On successful iteration, the iterator is moved to the next position and
- * a reference to the returned socket is acquired.
+ * Return:
+ *   The first mptcp connection structure found inside the token container
+ *   starting from the specified position, or NULL.
  */
 struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_slot,
 					 long *s_num)

-- 
2.51.0


