Return-Path: <netdev+bounces-258570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDfIDHXLjmm/EwEAu9opvQ
	(envelope-from <netdev+bounces-258570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 07:57:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E11A013358D
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 07:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 731C4305262A
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 06:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7302798ED;
	Fri, 13 Feb 2026 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="SxjwYTYR"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786D72264CA;
	Fri, 13 Feb 2026 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770965873; cv=none; b=Vc0osIe+pm6F5KBgeiOmgPaaKALDPGQSSgAx5OjFkURNZufBqldeGN6dbg75BpQLttuSkmhU5EM7NEN79dHvsp+XRq+CFMjot4+a//mptNbo0uKH4iUskGg1X11f8WpVq1dTMQHFjUyGW2Mxvb3VfoLOOme535OeAlPF/puGJBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770965873; c=relaxed/simple;
	bh=sihSY8ofaTRnTNRazDGJyGTlXMCmIKQdzFoD5ExVY6c=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=bLjOckmVhMtcxV1T4r3hd7QtLxQG2MQ1twOab8FLwxY7auNLpdjzmQ9kgIhOEa6RIck5Qxu4ZzsirGFwa2f/5jfFCT2b12LElhHaApijOZgeXQLnHopwAOcXXfzJWYEqBBg8f9Pzir7mgX8pdXG+FNcrpyO8FCJM3v2UWBD4JD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=SxjwYTYR; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1770965860; bh=77PLzw+c7oReRzI71g1p/p+1xvQhRSrvDxE9YzlwFXk=;
	h=From:To:Cc:Subject:Date;
	b=SxjwYTYR2H8pnz3e19y9xajr4VPew3PY2rm82aWeD+yypQ4FeWKCc34FNvZQZjCQM
	 v8Rkv17aMLR00XIwjOmndwyAVX0O7g6TR84G3+cG6rZuOKKzCUgi3ztbKVgSZL1hg0
	 0YzP3yNegCC1bkSiF5JAEGPaZAChunqItYHMTMmE=
Received: from PC24010019.. ([58.240.122.156])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id E5B9C41C; Fri, 13 Feb 2026 14:57:27 +0800
X-QQ-mid: xmsmtpt1770965847t9f3xcgs5
Message-ID: <tencent_5F3DFF496EC95F5BC0D71C297D088B06F40A@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uUYB9/x3lXtMrdEr6Ga8W046Ot9h1th+dNW0fVbSKUbJIEbIU+V
	 wQLN91ofI1tulh04GYIKntRiN7t6n34L4n4SqT9cxCdySkpGdBJxdXey6HnY5iXc4Qpb4aLY18Ji
	 7MDHVxhr9nBCVn1yi6Jh9jCfFEFahovyaSsvryHgC1ox70TwnH2LNTIWIYeZCbYLtGJ9WjRhq/9k
	 VklAnsHk3Vqy9zxPce9I0TfjkOPEHY8dWwYVR60Rzfe9c9KKi9ayyH4VAet6wE/geQRUtJ4wW57B
	 90iN0aGBe7y9jeqy7aHzVetBBQP4iK7Ac2QEu31SxoHbZC5SwtUSwhC78v1epXQFhykvJWJB8q0f
	 lhIL3KtCQsoCtcaSbiTDGNUsM3g8gBRoNVjHWjyt0f9O5ZT5a+vLZCS6ukctpfo34wOP3W5fZWRj
	 1QNg5uzeJDk+mSNLSBvFmt3fRCrIL3pqgdyhhuAEyJ3EczXhBQuYTcyc0+aueUMgyoMLFap+4bOd
	 cdb9r34VK6MgzVP2w5k3OqgMu68ruGPidHIRL5ooUeIDGWnTRKYPZlxpoMvlh0B4JHeCfh6Rekbf
	 Y+L9n5H0LM97sQoqSyQcxIHlr7tAXeDf72YDeZpJ6V47XBcPJRbbqwI8aujHq6cVs6P91fujn31V
	 sAYPtkKlFhzThEbSsyK7drOB+FzrGTv6g/KB+sejbImyx0ZPEINCMbC19brGrS67vQ9wGkHRU2AM
	 ridOV7sKs6JyoFjdNNGGqxxTHrV4x/WzTq365yx0T675G02dV3HOgGZOrsSy7Z7JJkpqfMEWZjpn
	 ATdAdwTl/M+XoURSMlLvdfcvtDxh9u9TgtJJO/3deQYz3/h6Z+Gpz0bForrSVaHvjvyhH+q6GXOz
	 7KyiiGRixSLKpP0YJHBktpJ+iVhYY1C/noOB/FcHo52AaCR578IxF5dRPUKadzGc41zJKs15jyGP
	 H66oVb09LQUk29j9R9MIlsFA988HmLSM5WNtRNv/yUcCii5vztg9/7cdAiaZKOUVjiE+GyH+WtH2
	 ejfdXB68O9qEV3mRObg+pQzJsaC4p9vAtHxjtEGDmuZ9FdnhSBtKz+tQiayjxkDcigDy2hPT2wxL
	 6yeKx55wqffU3SdZcY47+NqhWglrqcevuBymiB839P9yyMW8o=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: "zhengping.zhang" <aquapinn@qq.com>
To: lorenzo@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com,
	zhengping.zhang@airoha.com,
	"zhengping.zhang" <aquapinn@qq.com>
Subject: [PATCH] net: airoha: fix typo in function name
Date: Fri, 13 Feb 2026 14:57:25 +0800
X-OQ-MSGID: <20260213065725.885845-1-aquapinn@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258570-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aquapinn@qq.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.infradead.org,vger.kernel.org,airoha.com,qq.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qq.com:mid,qq.com:dkim,qq.com:email]
X-Rspamd-Queue-Id: E11A013358D
X-Rspamd-Action: no action

Corrected the typo in the function name from `airhoa_is_lan_gdm_port`
to `airoha_is_lan_gdm_port`.
This change ensures consistency in the API naming convention.

Signed-off-by: zhengping.zhang <aquapinn@qq.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 drivers/net/ethernet/airoha/airoha_eth.h | 2 +-
 drivers/net/ethernet/airoha/airoha_ppe.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 62bcbbbe2a95..3779f93b47bc 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -76,7 +76,7 @@ static void airoha_set_macaddr(struct airoha_gdm_port *port, const u8 *addr)
 	struct airoha_eth *eth = port->qdma->eth;
 	u32 val, reg;
 
-	reg = airhoa_is_lan_gdm_port(port) ? REG_FE_LAN_MAC_H
+	reg = airoha_is_lan_gdm_port(port) ? REG_FE_LAN_MAC_H
 					   : REG_FE_WAN_MAC_H;
 	val = (addr[0] << 16) | (addr[1] << 8) | addr[2];
 	airoha_fe_wr(eth, reg, val);
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 20e602d61e61..59ed7569f7c3 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -626,7 +626,7 @@ u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val);
 #define airoha_qdma_clear(qdma, offset, val)			\
 	airoha_rmw((qdma)->regs, (offset), (val), 0)
 
-static inline bool airhoa_is_lan_gdm_port(struct airoha_gdm_port *port)
+static inline bool airoha_is_lan_gdm_port(struct airoha_gdm_port *port)
 {
 	/* GDM1 port on EN7581 SoC is connected to the lan dsa switch.
 	 * GDM{2,3,4} can be used as wan port connected to an external
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 2221bafaf7c9..9e07b4653af1 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -321,7 +321,7 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 			/* For downlink traffic consume SRAM memory for hw
 			 * forwarding descriptors queue.
 			 */
-			if (airhoa_is_lan_gdm_port(port))
+			if (airoha_is_lan_gdm_port(port))
 				val |= AIROHA_FOE_IB2_FAST_PATH;
 			if (dsa_port >= 0)
 				val |= FIELD_PREP(AIROHA_FOE_IB2_NBQ,
-- 
2.43.0


