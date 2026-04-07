Return-Path: <netdev+bounces-275849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAVTBaly1GmSuAcAu9opvQ
	(envelope-from <netdev+bounces-275849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:57:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCCA3A9455
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B3F5303FDC8
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 02:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E88372EDD;
	Tue,  7 Apr 2026 02:57:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C2E372675
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 02:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775530648; cv=none; b=lKyUS7U3N8tomfkV0Odqd0c7wOkS/3rC1SLd+IY6/9xjmbtSC34YnKdDZy+VnxFlshYKLYhs7SSgLM2FZZI/UCv4Y34euWGMG0rRYceLugE+YupA+n+QTHhJAQ/JB56KReHKcXVp7O1d7WpJBHLqmDmBhvIb/1f0FnVh7IVvh+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775530648; c=relaxed/simple;
	bh=bQ1iIvjboEs1N26sVJJEBNZjYLljImHXeHO8kndxh1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VJk+TrYoz+UHrXviV3X641oXs2nLV08P9nVZcoNDckRgfiqng7fIjkZn2Jp0ueHyoH22SGxagLPfVJBuYNXOasgzIhspn7a/zOBuAJ4q6O7+oWpM7sJG8N5xkb4Cvcyyc2pp45nZ4FEtp42W7Me/c9gyMwK1s8ENDRwUqkSZqg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz3t1775530602t9625de01
X-QQ-Originating-IP: ev+yj4Vj6gZUJhjOtnbPQL3sRg46GYRleJ6zU6H/Lus=
Received: from lap-jiawenwu.trustnetic.com ( [115.220.225.134])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 07 Apr 2026 10:56:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6815522984052776672
EX-QQ-RecipientCnt: 17
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v7 3/9] net: ngbe: remove redundant macros
Date: Tue,  7 Apr 2026 10:56:10 +0800
Message-Id: <20260407025616.33652-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260407025616.33652-1-jiawenwu@trustnetic.com>
References: <20260407025616.33652-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MWxexosv2xAzSkQiOsNu+bhTsNsus572tdeiuHGPrfwSG3RghqlOi6Cc
	fHG4LvVHdEse2MOpuEmppsvLAP3GPEy6tobag05odjvXJiFJeUappxXOJ+bAt8OC2TWNCiR
	ycpld2LqC06JjzHeuRzANXav+h2Qp+mJ+rPQPHXq1ZDH/eZrenUlKt9AXGTovOd5pd/kiQs
	LmASbJW0soItd/q8L4mM7ztB7EUlKbTgFa4njodY5Eh/EiZtcuJo8MMhwjY6rwxYkL249DR
	yA4K99AI24C2+R7XxXtyjOl7jLGmGVzHk+ISXAvRNQR25nyd1FngoIhVJfkw48ig3VjEQQz
	stt03S/jfzAElY6YCZyyVXnhLrps20kcRQ/tLw+wNkEGfukXEByvt4FpA+GJ+oYy+TKP/IE
	CH89sob8bOUvUpaYW8erldPq2YklSQnMJwDtzxzbUt4wvknlrXcG6dtXIsZ1avTg/LU1gcl
	g+h2Hv1Gz7aR5Qbl0mK1Y9tbXWn1hFspcr6x0nwccuvrpZKGM/menZrNCM7d7o4T9t/OA2C
	TqMMwQP+uxKeFKdYdNKXgIAvkcHKFd5dSAf12nSHywwtdNztXDYVy0IAs5MtBjXNKcbBo14
	MKaeG7rmg/0wucfxpnJFfEAEg6RUuFH1LBF3hmPhD6JlXAsPyO3JwRdhHCbhkdljphpcQX9
	40c1bof7xcH3XKojwd7D1yq++EEc6IvqJ1VGu3tXOR3pJo+1UwJcPWzmx1a1/V6Q38VNpnS
	JjESGYCpo9BjZfUJmSAAwiyS2zi59seLkz8wY99kSw10agOXZH7zol5wiiKdLjx5CB7nqWQ
	f1RZUDuLd0SKCRW68pZlezNyKp1eY5KA0CqOwrOKqCupJreVDK8PgCgMw6S342ChxU1RzCh
	Z36NqtaB+hsNBTLxHO9cBmuA+nCqS+fI+29YbiTnWvQGfwOpjyNiA5g8cLSK6nquQWLVS/O
	BZumcFtu9KTZQuADfyxQoglyq1/myXHxu6NLQJ533CnrchNJlwtvbrZ0xvqiZMg8/qyT5t0
	xMuW/S/djEts5LE8W5WQ3vCudTW9VsGNiC6Eg+ixwklvY7rNel+xj9jF7hjKN8MoNla2n8J
	kdf62wR24tzRhirj1uNJv3I/cxVL8QeaMWWgcvI7Unz
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275849-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,linux.intel.com,intel.com,dama.to,gmail.com,debian.org,trustnetic.com];
	NEURAL_SPAM(0.00)[0.290];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustnetic.com:email,trustnetic.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama.to:email]
X-Rspamd-Queue-Id: 5DCCA3A9455
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

NGBE_NCSI_SUP and NGBE_NCSI_MASK are duplicate-defined, they can be
replaced by the macros defined in libwx. Just remove them.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 4 ++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index e28ddf684a06..8c9d505721b1 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -57,7 +57,7 @@ static void ngbe_init_type_code(struct wx *wx)
 
 	wx->mac.type = wx_mac_em;
 	type_mask = (u16)(wx->subsystem_device_id & NGBE_OEM_MASK);
-	ncsi_mask = wx->subsystem_device_id & NGBE_NCSI_MASK;
+	ncsi_mask = wx->subsystem_device_id & WX_NCSI_MASK;
 	wol_mask = wx->subsystem_device_id & WX_WOL_MASK;
 
 	val = rd32(wx, WX_CFG_PORT_ST);
@@ -66,7 +66,7 @@ static void ngbe_init_type_code(struct wx *wx)
 		       em_mac_type_mdi;
 
 	wx->wol_hw_supported = (wol_mask == WX_WOL_SUP) ? 1 : 0;
-	wx->ncsi_enabled = (ncsi_mask == NGBE_NCSI_MASK ||
+	wx->ncsi_enabled = (ncsi_mask == WX_NCSI_SUP ||
 			   type_mask == NGBE_SUBID_OCP_CARD) ? 1 : 0;
 
 	switch (type_mask) {
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index f1957fa0add4..7077a0da4c98 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -37,9 +37,6 @@
 
 #define NGBE_OEM_MASK				0x00FF
 
-#define NGBE_NCSI_SUP				0x8000
-#define NGBE_NCSI_MASK				0x8000
-
 /**************** EM Registers ****************************/
 /* chip control Registers */
 #define NGBE_MIS_PRB_CTL			0x10010
-- 
2.48.1


