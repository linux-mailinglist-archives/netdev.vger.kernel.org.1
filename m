Return-Path: <netdev+bounces-270297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDf4HiN9v2mF5QMAu9opvQ
	(envelope-from <netdev+bounces-270297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 06:24:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB0B2E8412
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 06:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C135300F5F0
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 05:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81E4288C2D;
	Sun, 22 Mar 2026 05:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="B9pOQmSX"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19F270808;
	Sun, 22 Mar 2026 05:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774157078; cv=none; b=ax/wy0eL3HTnEzQhEc4v8GH5+U+Sux5o/GMp8aIvRgYqqogn6EYxP0buXM1nCH4J+e+ARNsfu+P7ds8AppvRrqbYRoNvX6N5S6TL76VLiilPBNDNQ9TKT7BfeM5waBX4KG5hoOR6ZyDz/0cNZPvCkHbXTtfvlAyHlgN48aiLVe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774157078; c=relaxed/simple;
	bh=z+jeJrg+42KvYrLm1nJvkRMFkHaDI7YWq6D1mcg/TE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WzeTJ2AFbjyrwdCGZK/QjIIzgrFYZyS8cQp5fRukh0KnfEEOlKfYpDH64xY7MZgf6YQbBm96fIeECwttjPOSWcvTefrkM73kLoH13/cVMjLHzwWMOCCI72x5qeb+Sa5mCmiW4NJDykuyzYG+kSDctanCM3/Uy5UoGY460xBBDH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=B9pOQmSX; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1774157065;
	bh=ZgmfdFihQi+4djkTzwSgq5e/cW4SyloibvW+9Xvo/tI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=B9pOQmSXwjC81+4ZkTETCHVraVNxbdkYfgfxcniA/nDMA2bE8tqaHGNFk8u0WBdve
	 O2e70/g3S0oN+7Wju3tHfnmF0T3R8BcxnTKxB7sMbGYr4Qfa9IHJziOi84gbVEt59i
	 Pc9ZD9mNxTlovVja+ld60mJTwxljPqqYe6A9rjdI=
X-QQ-mid: esmtpgz13t1774157060t316372c2
X-QQ-Originating-IP: pigerY6xrq7Z2EVpquY2nLMIWpBzzzala9fIQkiXZ7U=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 22 Mar 2026 13:24:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6154806126000090797
EX-QQ-RecipientCnt: 15
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg,
	Kexin Sun <kexinsun@smail.nju.edu.cn>
Subject: [PATCH v2] tcp: update outdated comment for removed _decode_session6()
Date: Sun, 22 Mar 2026 13:24:17 +0800
Message-Id: <20260322052417.1216-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260321105951.8314-1-kexinsun@smail.nju.edu.cn>
References: <20260321105951.8314-1-kexinsun@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: N2K7JO7TcIoE9l2k02UY3Jytfsy44gPatrcQEDT+G0L8BrWzAReZ+iRo
	DOeV0oIiAFCkNx4AD/VFF8OBLYN+nhtdt1bZbNUn4v8HlQmMOhvEwG0/bwRQ7zMCIwmEFHI
	dLv3hGnUZY5/81nSskwe7zKI0nQPa0hbIC+Lf2585CmVkT3zIcc2J7eTC+iUXRTHp5CQJ+C
	3lnlclm/ok/Q4W4UnRDElabo2aE7p0GgEjXBUvwfeokSjDheydopL90cFbJS/dfDlBmuKHn
	EyxS5o/dm7rbBLfM3YANi/3yEXoj0p7VpH3IJg7oyh3Vk9VuPoc86LVRUKgXXVd0+mYw/s+
	sOCkwvVl1UCqGjuki5QQ+4snLvZo+q+h3eaAHk4FnQnxvheIb3X6iWaNvE5tiWB2Ids9qo+
	HwCPhIYRSgozIJtMLfWyrc6DlES4ZcsalD48EEZJ+X8/Dh0Cv2XUStGtO4qfQAyeZQ1UiY9
	dBdagaQPouvv/G5ups/XcNmNzIXvxj7yA7w+247eo/nEr1iV2Wd+1aljfziuvHKIRK9FCCL
	2MmF8kVxZhk8x3xK9sSWtVrShXYk2JpF1/bK8orcTbMWA3YgSmzAYMiPKY7Jr4hiTcnaEDP
	N5J7CzvwbczSSQUVuMZ0B9ich2VvtvaXelkCp3+GdW3Rsd0odXUrkj3nTQF7vbabai3P9TU
	B4cOAabJVoILSsNFD6ycOYcczs7tLgQsahOrLl+fYQC5v2OTiv/oKVoQ/Va3RgCl0N8MnSy
	IVJhpH4JSSCS+TvSe+XirWuiNtAqeFgPfdYW6tnQ5B6UvFjdVV0yZk8TyxxGTRfH5YArVql
	JVcv+GZKHWe6AhB93/z6yUBJaz299T/JEtXJynKxs6dKwBmOvebGOtPH4cDvi8FBkyzc9m1
	sGF7mh4yzWjQaghhSWTkYJmgmkw9DCxlBHdVCvgTc3DPBLqSIk9H5frUX3k6jp8L5jmMWjl
	vOvAwHb8tLZflPIDhaNMw80P63PXbUxfExYVaVEiRkfs/xtU+gwsYWmLv7TqsXakcemCM8e
	2JK4THmjLCi8zYU4vJ
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270297-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[smail.nju.edu.cn:?];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kexinsun@smail.nju.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.542];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DMARC_DNSFAIL(0.00)[smail.nju.edu.cn : SPF/DKIM temp error,reject];
	R_DKIM_TEMPFAIL(0.00)[smail.nju.edu.cn:s=iohv2404];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nju.edu.cn:email,smail.nju.edu.cn:mid]
X-Rspamd-Queue-Id: 1DB0B2E8412
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The comment in tcp_v6_fill_cb() states that the memmove of
IP6CB into TCP_SKB_CB must be done after xfrm6_policy_check()
because _decode_session6() uses IP6CB().

This ordering constraint was introduced by commit 2dc49d1680b5
("tcp6: don't move IP6CB before xfrm6_policy_check()") and was
valid at the time.  However, commit 7a0207094f1b ("xfrm: policy:
replace session decode with flow dissector") replaced the
per-family decode_session callbacks with the flow dissector,
which parses packet headers directly without accessing IP6CB().

Since xfrm6_policy_check() no longer reads IP6CB() anywhere in
its call chain, the ordering constraint no longer applies.
Simplify the comment to describe only what the memmove and
barrier() actually do.

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 net/ipv6/tcp_ipv6.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d10487b4e5bf..619b35669361 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1688,10 +1688,9 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 static void tcp_v6_fill_cb(struct sk_buff *skb, const struct ipv6hdr *hdr,
 			   const struct tcphdr *th)
 {
-	/* This is tricky: we move IP6CB at its correct location into
-	 * TCP_SKB_CB(). It must be done after xfrm6_policy_check(), because
-	 * _decode_session6() uses IP6CB().
-	 * barrier() makes sure compiler won't play aliasing games.
+	/* Move IP6CB to its saved location in TCP_SKB_CB().
+	 * barrier() makes sure compiler won't play aliasing
+	 * games.
 	 */
 	memmove(&TCP_SKB_CB(skb)->header.h6, IP6CB(skb),
 		sizeof(struct inet6_skb_parm));
-- 
2.25.1


