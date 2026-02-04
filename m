Return-Path: <netdev+bounces-256776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCOfGpx7g2lQnwMAu9opvQ
	(envelope-from <netdev+bounces-256776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 18:02:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC59EAB70
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 18:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB5B630292B8
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 16:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A80A34404B;
	Wed,  4 Feb 2026 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJELLuzP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C65343200;
	Wed,  4 Feb 2026 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224273; cv=none; b=QdCP7FGoVcQbwLkxuUAcWT2hGdescGrmniNyGv/1GClc2S3N+8FaMontCRlpFueC7kJVILwYRqkIY7D3oOj8FMmZ29CsUBQ50VqxSP+4O9lAoUlS5PAxfuLKEAOWHRSNeaXxtE91c7Q1M9ccGdPohHGOCnXtR6V7pRwjHC5Iqro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224273; c=relaxed/simple;
	bh=oQrIrDfVl4PepNgPPdzQwgI/kMNP/CA7VfcOXfAUYiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qkpj8Jr9lFOOnb5wBq1PQth3Z8XFQRetuW8pz7pjBs9g1gzQBXpkUxiB02wjwW/MLKaKe9rpkrF2he7Wihr4WU5iD+O8qC7qBusFsMZH2h34JaiQ2VrWQ+pTtHv6aqIBT6/XTOIhWhSjbL7TNSFcs1xm2iYKumYzar4EZtt7HwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJELLuzP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86BEC19423;
	Wed,  4 Feb 2026 16:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770224272;
	bh=oQrIrDfVl4PepNgPPdzQwgI/kMNP/CA7VfcOXfAUYiQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RJELLuzP+RIur+Fsia8tS7AaxU2kaaRTR6KElUpyd8qiL4hRZKKEkuTxpoYsn5lI/
	 BPflU7nPt+WtoaKXFaD/SUdg2WXVBeQKeHGxFTKAJGU+Uab7zDxXz+WacTDxzZYduy
	 Hu2qhe2F2zXQZPrTB3pYpwxemsV0xpIRT6nZvktMVJqpUcG+xPabhBoq/CMoH6Lup1
	 Q+/BfSL0K138IDtHsicOZ7XX/MXRymMQ+asEPGhP1kGRxqgSZDiwtX2egxvhwdU9pC
	 hTMn0bg+X2YB+zAW9xlZzbCGilL98tG3YD57/6FtaXQnkdOVD4UduV3lGvkpdhPrZN
	 C9vct5yzHH7AA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 04 Feb 2026 17:57:27 +0100
Subject: [PATCH net 3/4] mptcp: fix kdoc warnings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-net-mptcp-misc-fixes-6-19-rc8-v1-3-cb559fb6b50a@kernel.org>
References: <20260204-net-mptcp-misc-fixes-6-19-rc8-v1-0-cb559fb6b50a@kernel.org>
In-Reply-To: <20260204-net-mptcp-misc-fixes-6-19-rc8-v1-0-cb559fb6b50a@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3873; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=oQrIrDfVl4PepNgPPdzQwgI/kMNP/CA7VfcOXfAUYiQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKbq9r63lbOn9TOH2MXd0+q4ujbhN1bdUQjhb5Om3WE9
 9eZpCyXjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgInsOMjIsKqn1s5I1Dqj4/as
 R/Yrc6xaHz0uYuS6/Ef0gM/W9Dn7vRj+e16K8TjtbsWcueq0lW/iFdmLs5ls3i5jrDR8qbtXqEe
 QDwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256776-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9AC59EAB70
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
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/uapi/linux/mptcp_pm.h |  2 +-
 net/mptcp/token.c             | 16 +++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

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


