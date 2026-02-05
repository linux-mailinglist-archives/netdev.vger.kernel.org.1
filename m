Return-Path: <netdev+bounces-257268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOdNHrnUhGlo5gMAu9opvQ
	(envelope-from <netdev+bounces-257268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 18:34:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AADF5FCA
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 18:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 21CA830055ED
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 17:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B64C2F5487;
	Thu,  5 Feb 2026 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDS4RBq+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061892EF652;
	Thu,  5 Feb 2026 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770312876; cv=none; b=D1wN99lCjzR7doNwJff+BlhNBlyPdI00ROL+LqPbQhi1y0JLA6L7m7gE2ZXLI7/bhj+7MQ8sPsEy0U+YHWHx+pbS7wtVsBOQHYUBMYz0IMNdqEhhYcTeRPBdHQJZ0ddb5lmghGs93SAbqdpOz5sm8RF8tQJh8neKSce93+FwoYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770312876; c=relaxed/simple;
	bh=k86znqb/C5wurGTotFhvFsMFzCbZUfP3RFI0jLbub1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b6mYBhpzn2tdY0v4XSZLfAKvK9jsZPgO2qRJJohwhWMViWQTKY7wXT6LsBKI7mWFZvG4DrnNxusRp7lLfu5B3W86B6Eac4zZxzgpdDjuRly/M3iWa7LShcL/T+t1PK4F4K71uiws8HyvYhIhS/7ZeCj8vmnF9XXh+VVrAozgei0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDS4RBq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC2AC4CEF7;
	Thu,  5 Feb 2026 17:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770312875;
	bh=k86znqb/C5wurGTotFhvFsMFzCbZUfP3RFI0jLbub1Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HDS4RBq+NyGOF2rklLqTESSWlozTjwMuWpUs0mKMd3j2vxDo7seB+hJwJV0vJToOJ
	 ARM6dbQI+bN19e2xrSfPwly4H61m6sV7JHtEhrazpfonZCQdnmjQkWTs8MD3MVOT96
	 RXZuVCADdtW57jWadEdP94tyMAlZFkmtpE8wkUX/tE5pJbIxLDrCTJ08SHZCUz2UEH
	 vKANU3Sr/4q5bcUDjPVXjGawx2Yo91P6XkYKEw4CWe9WPLB38tlo2T9v5DP1zF6whX
	 KUgkSlWAVtOf/F42ODsvHxs0kVPfzH/iapy/XKBOruA2RYKfVFsld4XJtFgL6ZvYa6
	 qI2Dtacvdf45g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 05 Feb 2026 18:34:22 +0100
Subject: [PATCH net v2 2/4] mptcp: pm: in-kernel: clarify
 mptcp_pm_remove_anno_addr()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-net-mptcp-misc-fixes-6-19-rc8-v2-2-c2720ce75c34@kernel.org>
References: <20260205-net-mptcp-misc-fixes-6-19-rc8-v2-0-c2720ce75c34@kernel.org>
In-Reply-To: <20260205-net-mptcp-misc-fixes-6-19-rc8-v2-0-c2720ce75c34@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=k86znqb/C5wurGTotFhvFsMFzCbZUfP3RFI0jLbub1Y=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJbriy6JhS8oTXPNNDY/8+h+wVLPM4WNCt2yq54fSREK
 vQyU4FjRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwEQuX2Rk+BSisubxP9/vKRJp
 G/gO6AroP3v/6ue+X/+d1nWsel6YfJzhf4B0XMYecZ+cHVy9ug3yoUltr/8yql4R73XWaPxad1C
 QDwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257268-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90AADF5FCA
X-Rspamd-Action: no action

The variable 'ret' was used, but it was not cleared what it was, and
probably led to an issue [1].

Rename it to 'announced' to avoid confusions.

While at it, remove the returned value of the helper: it is only used in
one place, and the returned value is not used.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/606 [1]
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 4972c19fc73e..b5316a6c7d1b 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1044,24 +1044,23 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
+static void mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 				      const struct mptcp_addr_info *addr,
 				      bool force)
 {
 	struct mptcp_rm_list list = { .nr = 0 };
-	bool ret;
+	bool announced;
 
 	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
-	ret = mptcp_remove_anno_list_by_saddr(msk, addr);
-	if (ret || force) {
+	announced = mptcp_remove_anno_list_by_saddr(msk, addr);
+	if (announced || force) {
 		spin_lock_bh(&msk->pm.lock);
-		if (ret)
+		if (announced)
 			msk->pm.add_addr_signaled--;
 		mptcp_pm_remove_addr(msk, &list);
 		spin_unlock_bh(&msk->pm.lock);
 	}
-	return ret;
 }
 
 static void __mark_subflow_endp_available(struct mptcp_sock *msk, u8 id)

-- 
2.51.0


