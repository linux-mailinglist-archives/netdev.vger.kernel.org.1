Return-Path: <netdev+bounces-159131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86ABFA147AA
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 02:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3FAC7A1114
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 01:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB701F95A;
	Fri, 17 Jan 2025 01:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pXUCit1+"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9299778F4A;
	Fri, 17 Jan 2025 01:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737078134; cv=none; b=QZ+2Gk9PDeKE3Hu7oVQWYOd4gsDlV+PiTt9LLIIbUsVdUsRwnV7qheVWxz1720x6AoDz4TRzkCczMrj9QV8c1qvrFmkLW7CO8zLF7sLiiiNAcZpo98zBsU4p6TGX/LIK9uRNKms1cpwaaoU1Lbr6HAhlt3ly/OuzfIQ2gsSsQwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737078134; c=relaxed/simple;
	bh=CnguXFDboJbCn4G1/RrkMA436NeV6IFnZANRlKwyDsU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbaaK+zuM8i217oz2bFz4E7RKSbC8i/E/GhMQJXr2ji4VcYBNHoRW43YFRrF/4+5LB8LNhjR/1dSoslO0eSd3RzjkCnedcpB64osnsvovTCGhLlAuea7mg3DEJdCFryUr68BM55DUybaSqqdbnCCt4HnDglV5Li4Gs2IGxHb9nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=pXUCit1+; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1737078127; bh=V/kVfBSc6XNDSpGWUA89ZDPbtRDg4CT3J8xdbo5yU5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pXUCit1+radxg4csWdY6Ae1Fk2M8WLVhuYAtfcsKtwO60uDjQ93EbabNzUgLWCRYc
	 rXKRyJAHlLXRPbVDwwe0Xxwzpq6L51BD9aB9Kv/us1IbP6W7HiMCRilnpQBcdZfrRv
	 n01o1VghwOshIdSsJ0JirpeI+j78Te6YXQYcWTQM=
Received: from mail.red54.com ([2603:c023:2:bd00:3e58:d853:ce34:adf3])
	by newxmesmtplogicsvrszgpuc5-0.qq.com (NewEsmtp) with SMTP
	id A7627643; Fri, 17 Jan 2025 09:41:54 +0800
X-QQ-mid: xmsmtpt1737078114tur81dlbk
Message-ID: <tencent_27DFF9F35BFBF50F6EE024ED508FA8F5FA06@qq.com>
X-QQ-XMAILINFO: MQAOa38Yz/8/xDUypGXbB5QCNvhaMIxXGbW4d0RErgpaqZ9gAy0zyDuxTOT0xg
	 sVOs4Q4U7X8aJTiHDj/tKxVZD6ih0Va2mS6Ao4t0PigY5Npn+UoUYrNqa2cq2wrMrLCSmCon5pYp
	 fYnk1NhTstWaRWwz0rbQ2zORKtEMqIHZeNAjCQucTVKyZtj2R7XmKOFqDkXQPgsho1REg5PaO+a4
	 s5zrbLowygkAULSlcxiJrABPgSadnRVRoxrnfX2MF5KNeJl+f0NOPWEVEL/y/rxmT7B1BOaYxqXo
	 35LO7Ouk7bhe4zdnzq+bTNSVTzuPg3apvmFAGlPoDTB9Gn7TDwXkcG29GfU1l7If1H5eiUEBCsT4
	 H3yOFljB9ZoV+MAAeb8wL+139lA+cTKePS/iUQZjzVG6024rBQBX40xNJ83LVIV5vWbrPGjl6pLd
	 uW+cY2pYZjLEScCkAQ2+7CWXPw0oTiPyywmD+p4PbiulnJCnYm6J/KKJCtQQmZlLe3oIUeQlJzkl
	 LWVmE3Qwp8vAcYRFgnLAQeq+ZDZqdg/b+lhtDcRVJycecz94UbiWflizqYHGv9qMCPn/kgumGPLt
	 4Hyv4PAucZObolpv9CJvqe16nw7tIDfDzDbQM4F0xQuVDECIsnPtNhEd3YQAZyo6/qEyHlO7C6qS
	 vn/l5PqsNTQafB0NU5TKacKDFIpJLvwOrj2bTFehJ57Z9vzDJdweQaua7r8A3sz7G5Iha34mE3yx
	 lfuleCKSV8yDp81ROX5+ap9AWmuNHe3bopVUzI33XPvcD1M6OhaaKZD9R7mrBnivpstMPFOLDPOo
	 kt61nFnz8/NWdfcq+LdwYT/W07HmrDh5SO8fSgefBUHEgy+UMcHVXi1uZDwZVCYl9WpKJk4aT7gG
	 cY6w0RgYvFo60m5kmIYvNFdisD6pZUb0cV8h1WvIlR+5STN5rhqK2K7poQAqZ0B2ho0X0/Cq5710
	 0EZzxvxachulWrdltIkACL76RQAdLZD8q6l0DxITl6BvCIpBOeGOnUUkcW2XoAB+Fq5RgsQzotU7
	 FX+IcOh67MS8bprPGf/EVi4X9wU4Y=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
Sender: yeking@red54.com
From: Yeking@Red54.com
To: kuba@kernel.org
Cc: Yeking@Red54.com,
	arnd@arndb.de,
	davem@davemloft.net,
	edumazet@google.com,
	gregkh@linuxfoundation.org,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	prarit@redhat.com,
	vkuznets@redhat.com
Subject: [PATCH net-next v3] net: appletalk: Drop aarp_send_probe_phase1()
Date: Fri, 17 Jan 2025 01:41:40 +0000
X-OQ-MSGID: <20250117014140.244788-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250115140629.1c37c8a2@kernel.org>
References: <20250115140629.1c37c8a2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>

aarp_send_probe_phase1() used to work by calling ndo_do_ioctl of
appletalk drivers ltpc or cops, but these two drivers have been removed
since the following commits:
commit 03dcb90dbf62 ("net: appletalk: remove Apple/Farallon LocalTalk PC
support")
commit 00f3696f7555 ("net: appletalk: remove cops support")

Thus aarp_send_probe_phase1() no longer works, so drop it. (found by
code inspection)

Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
V2 -> V3: Drop if(), and update commit message
V1 -> V2: Update commit message

 net/appletalk/aarp.c | 45 +++++++-------------------------------------
 1 file changed, 7 insertions(+), 38 deletions(-)

diff --git a/net/appletalk/aarp.c b/net/appletalk/aarp.c
index 9fa0b246902b..05cbb3c227c5 100644
--- a/net/appletalk/aarp.c
+++ b/net/appletalk/aarp.c
@@ -432,49 +432,18 @@ static struct atalk_addr *__aarp_proxy_find(struct net_device *dev,
 	return a ? sa : NULL;
 }
 
-/*
- * Probe a Phase 1 device or a device that requires its Net:Node to
- * be set via an ioctl.
- */
-static void aarp_send_probe_phase1(struct atalk_iface *iface)
-{
-	struct ifreq atreq;
-	struct sockaddr_at *sa = (struct sockaddr_at *)&atreq.ifr_addr;
-	const struct net_device_ops *ops = iface->dev->netdev_ops;
-
-	sa->sat_addr.s_node = iface->address.s_node;
-	sa->sat_addr.s_net = ntohs(iface->address.s_net);
-
-	/* We pass the Net:Node to the drivers/cards by a Device ioctl. */
-	if (!(ops->ndo_do_ioctl(iface->dev, &atreq, SIOCSIFADDR))) {
-		ops->ndo_do_ioctl(iface->dev, &atreq, SIOCGIFADDR);
-		if (iface->address.s_net != htons(sa->sat_addr.s_net) ||
-		    iface->address.s_node != sa->sat_addr.s_node)
-			iface->status |= ATIF_PROBE_FAIL;
-
-		iface->address.s_net  = htons(sa->sat_addr.s_net);
-		iface->address.s_node = sa->sat_addr.s_node;
-	}
-}
-
-
 void aarp_probe_network(struct atalk_iface *atif)
 {
-	if (atif->dev->type == ARPHRD_LOCALTLK ||
-	    atif->dev->type == ARPHRD_PPP)
-		aarp_send_probe_phase1(atif);
-	else {
-		unsigned int count;
+	unsigned int count;
 
-		for (count = 0; count < AARP_RETRANSMIT_LIMIT; count++) {
-			aarp_send_probe(atif->dev, &atif->address);
+	for (count = 0; count < AARP_RETRANSMIT_LIMIT; count++) {
+		aarp_send_probe(atif->dev, &atif->address);
 
-			/* Defer 1/10th */
-			msleep(100);
+		/* Defer 1/10th */
+		msleep(100);
 
-			if (atif->status & ATIF_PROBE_FAIL)
-				break;
-		}
+		if (atif->status & ATIF_PROBE_FAIL)
+			break;
 	}
 }
 
-- 
2.43.0


