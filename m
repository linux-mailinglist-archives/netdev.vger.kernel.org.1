Return-Path: <netdev+bounces-256774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OQ3Luh6g2nyngMAu9opvQ
	(envelope-from <netdev+bounces-256774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:59:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F527EAAB2
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 17:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 340393021575
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 16:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0782A341063;
	Wed,  4 Feb 2026 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITKusBxr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79DB341052;
	Wed,  4 Feb 2026 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224270; cv=none; b=Wr27De0FVe7+Mq3IryjkuUVurUKD45kmXbbQ1O/NNlVejSekX+FR65uUSkHZcU1Q2M9Zf06u+06UEkX0uFS3tuQT3v8GsCSItdZKe+ZudD5iaw8A9hH1h12JRr0d3WqLg7484Ww9i7nApBjWFsSwAUDuhVkzQ6eGjQXWwr7YI6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224270; c=relaxed/simple;
	bh=k86znqb/C5wurGTotFhvFsMFzCbZUfP3RFI0jLbub1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l89IF64Li3bgSeohOPK0mIQSP0uAaVD6vHqmeBeIWyRXw1z7e0ypJw54oAaua7KNZhhRlvSgbIlOKJPEtVVzNAn245f4ltcKM0a4iw7pN7teq6EBRsIh7RrEC9AgAN/urrx1/CmN87OGx0chlbvOOBu0rnNUmIbd1w/9e5uv+K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITKusBxr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC07C116C6;
	Wed,  4 Feb 2026 16:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770224270;
	bh=k86znqb/C5wurGTotFhvFsMFzCbZUfP3RFI0jLbub1Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ITKusBxrg7bQ7WrFjaqePKrJ21maayO555bUcYIBxaFzJcMqUqH7Rhxna/30O6Yde
	 07CGxn4TKFbJXTqG6peHAIprMBjl1DxYA9c5rZxzmlHX8oypAHpObBYkxO0Zr+H7NN
	 t4o+Kfumon2FaxTxFfOfIdtF5UdApSt54CgAEypsHN9uUdLr+R74sn+20qH3J7Wx1z
	 cfRRlw/7SdvETQAIg4Xa4nTyp3LdVYUHkmnLaWoORZtUilLIH0jheU25aEdIdono/E
	 A9lImyFULL2Bl5SJHO6xRGXh1ZaZxv+lBoC1mMVgyBva6/F3JAflA0ww3Ug/+pk7nt
	 khbgufWITUpnA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 04 Feb 2026 17:57:26 +0100
Subject: [PATCH net 2/4] mptcp: pm: in-kernel: clarify
 mptcp_pm_remove_anno_addr()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-net-mptcp-misc-fixes-6-19-rc8-v1-2-cb559fb6b50a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=k86znqb/C5wurGTotFhvFsMFzCbZUfP3RFI0jLbub1Y=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKbq1pV1SZonbyTf3mxem7dfp9WjaLp7Vlvn/0rO11lP
 HlJgbNQRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwETq2Rn++yWk1KrKyv8/1Lk2
 ++rjwNT9NsLCH7L1pm6dsjYnprr+LSPDEZfwWXE717V1HZ9wlinCsqg4ZoVpiMFKEd6qoGMnpfp
 5AQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256774-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F527EAAB2
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


