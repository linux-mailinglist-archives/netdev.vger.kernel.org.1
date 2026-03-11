Return-Path: <netdev+bounces-266650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO+eDjxvsWlVvAIAu9opvQ
	(envelope-from <netdev+bounces-266650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:33:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 450CC2649CB
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BFF283002B4C
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0CA2D8370;
	Wed, 11 Mar 2026 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="rSBc3TpU"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081922D8DC4;
	Wed, 11 Mar 2026 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235845; cv=none; b=AWD+25quIGNlw0ofTFys77MizqkNDrqgtkkOzawYsNJWTpdoA3JtUY3YCN6hr4EiyGX8j/uYJafMUTyOHVXWLaEBc3P/BluuntUUdsWpSHFZiLsTGhNQTGeI2o6jUl/7Zbrgo1CsOPvUnku7c+mZ076Aqg6HIOJ4aeJcpZR5PNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235845; c=relaxed/simple;
	bh=7y72HbJ4Q4YiJ9fnRRMGG/dy/qXBIJDT+gp71R+6sks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KgEsYdBERLumkMvDQ1ebnBiE76WfxWnq9kFHQq4qZLzCOKeiMidyQirwT8tS0kWZfMh5nXWXGDDdB0VoezgHPkIaVQ5LC8L+quDeRHm7e/GPjl3YOJV43/ywFt0rYhOnxEFW47rSsaZKnXkqy47WeZHIsYx5f3JPqbUOJ8uJj70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=rSBc3TpU; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1773235822;
	bh=/n5/x+jo0TsAu5chRtqefh7lqxbnimv8Mv/Kg3q9n14=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=rSBc3TpUY5iVXqTMW2vx3V7HLBvh8ws90bw10OJfn/ImCzKGNHF501z4KmHFCtprZ
	 OYlI8JTde69HU+Gv92csQ6HzWniHMns2/hKOnyhR0nwE3uGt1WTczxswFdXODa8s3Q
	 5HW8Vaz6iBTx++FrMJMQ1pk/WFMFklIfc+KN8WIg=
X-QQ-mid: esmtpsz21t1773235817t999ba145
X-QQ-Originating-IP: 1TQxbN6Cjg54xj6oO6AO1xBNwYPm1SJw+xAzlRws7Kg=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Mar 2026 21:30:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9918889740481163740
EX-QQ-RecipientCnt: 15
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: shshaikh@marvell.com,
	manishc@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg,
	Kexin Sun <kexinsun@smail.nju.edu.cn>
Subject: [PATCH] qlcnic: update outdated comment
Date: Wed, 11 Mar 2026 21:30:11 +0800
Message-Id: <20260311133012.519-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: M/APdU6Xy1bypRnsIUOctawRGMKnqT841Q2xWHVuz0zoeyuR/JqCrddt
	A570HloX8oiIHRpYA8jL2+NIopFO3LoFJ/SANqckVvmb7iNKB1m90xI16NILmS3I8UStBeI
	ATnsDSMWTYQjxkUtrLA+x0qhFQTJ4qFgokzOPJlNBVshRivy5o9pRAv3sKJtvWlxgrT9+Lg
	OfRHJT6ahUYmGP5xbTbogNPFhRVJCl0bCPe58uWQPvutFdIE+pUStDw7NLiL1unXt28BHpZ
	f2g5g18qviaLG5jfGpeE4f0iXQ7r64aHizgY4dsr/7awUlbC3e9eY6Au4AG8v1U+v2jk1Ud
	bLlq8ZajUQ1VxAMx7XPJQiHt+lOIt8S080kns33+pj9+8CYEXaOhtJg0+hu0YQWGRLx5s8L
	UU/UwMzywnMlWtxmnTgwyC7Da4Qmo0Ftc8I8yZsg/Jwa8XkOJsdm8KTY7nzuX3CMwa2D1Mi
	BZA3k78mgaswr6dP5E3yRwOVUhB07pLZgN5FP5X7Wflqsu2S5/gFFgLVMbI5e+tQFipMa7q
	pqonapWjiM7qmq/GFkEIe7N2Bnz7/B9CytC6DkSADd7t+6/8rwYFQgaa8sHAdDRiP9MZmE2
	WMk2pIYsKLK3AyFLd2gjpJDrWLI5BlxBWxuBdalMMvsBnH0feu9zDfbTzzZjpzut3A7asSx
	VHZDWpZqkfGZjiy3oqqpHAaj3MTjehkLgoo4vp1ZWPHsZcvfVSIP0ekSj9PtJdulgX2yNZR
	Qczxs+xEHPV9uHtUun0R3+SEp7Vi9Cv9Wq0oFQZ5vdy3gvAsNbYP6yFzxszoYa8ULEm3gQp
	AbbQgFHsMJsVxSsNfHdOQ4aZtzBvzjX4uoeOBldJKnR41MG6aMn4/RRCZ2jR1WPGYo4oOhu
	vXvnY+0/KBW/GJuznY5N8GMjzxGioxcIltmEiJCH/a74YxFH7nquyAFz+3zFiOLa/IuVVoF
	YFr3dNLEBhAtCkwDglNRhasM+edMxLxrUf2H7syKXMSbE189MKWxDb6xnnq+fX5Ywb/x22Q
	vlOabaxRDl/XtO37giXbKoxJ/m4EOwS7dp3pk9KENZ7TGUUq5Wi4SMKsGQoF21MgkL59mVF
	IEuXXmsCoSLWLIf3fbvsSTfYoe/jZR04CjAqNAvFzWx
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 450CC2649CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[smail.nju.edu.cn,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[smail.nju.edu.cn:s=iohv2404];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-266650-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kexinsun@smail.nju.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[smail.nju.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nju.edu.cn:email]
X-Rspamd-Action: no action

The function pci_unmap_page() was a compatibility wrapper around
dma_unmap_page(), and was removed by commit 7968778914e5 ("PCI:
Remove the deprecated pci-dma-compat.h API"). Update the comment
accordingly.

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic.h b/drivers/net/ethernet/qlogic/qlcnic/qlcnic.h
index 3d0b5cd978cb..d7c8fadb49de 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic.h
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic.h
@@ -354,7 +354,7 @@ struct qlcnic_skb_frag {
 
 /*
  * There will be one qlcnic_buffer per skb packet.    These will be
- * used to save the dma info for pci_unmap_page()
+ * used to save the dma info for dma_unmap_page()
  */
 struct qlcnic_cmd_buffer {
 	struct sk_buff *skb;
-- 
2.25.1


