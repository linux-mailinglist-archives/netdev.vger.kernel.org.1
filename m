Return-Path: <netdev+bounces-261742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULoOMnRJoWkirwQAu9opvQ
	(envelope-from <netdev+bounces-261742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:36:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 527391B3FAF
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A72EE303D6A6
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 07:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59203603DD;
	Fri, 27 Feb 2026 07:36:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C34335541
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772177778; cv=none; b=qIZHr2pkestGP2+PIRi2Fseg+FRo9shvjZbJlY2bNwoRwliO/4eCRgbpUaNJwXEq1NhjaBJOOl+Ag+2IxSQyiU4rfVG7UqMET2xxxuDiWeg9x82ack75H5M3b68+wfFK420L5SObJqdc0c+Vy8zExwVYiRe4IWjqM0UO1XadIX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772177778; c=relaxed/simple;
	bh=Qz3X7wFoPw2MQVserjn2t3iqQDg0xX+aA1AQbFK3asI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=giJ/b46aBXrE7DRr/xfuAFZy49sDX2O8o9L2JzN0PdKkrh2tdwlCJI2EuFtFBr+rl5jaP0yqN4JrOGVcQsLiqcON/QqqcxahUBH5KzOW/Y2WlM5p6z2UCPLa9XbrsAg67DpPIOq/A5+PtWWtJplFbvefU0K6STMmlPBuLZx93EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz16t1772177707t20cfbbff
X-QQ-Originating-IP: fgrcwrOL62JfXqTfvinJNGph8sFAZdN4VB4zpJpfwEI=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.96.164])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Feb 2026 15:35:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4420345484911093155
EX-QQ-RecipientCnt: 9
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 2/8] net: ngbe: remove redundant macros
Date: Fri, 27 Feb 2026 15:34:44 +0800
Message-Id: <20260227073450.23680-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260227073450.23680-1-jiawenwu@trustnetic.com>
References: <20260227073450.23680-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NHu6THI/J1zco6hYCDuwUpFrkflg5MQ2KpKQHEwz6yzPG6WZd6P/cAqO
	MO8mdNN1Q/4QKYi0VoyIh45uJzcOaIUdCzkGP/mFdWWQmIOb3v0pOnql0qkNMn7Zp2D7BPz
	Qo5dMWrIjWyvC4FQZGp1u0KJMy54tuNeOpKmnWwITLmkMDwLRcgFxRp48k1I71ri2H/+cPn
	1aUF0a6fZK+9lWBlsnMXSQmbhELjmczoxtPZ9JBU0a8M4iSS54lc7jVx5jP13sC9y6P3nhf
	pGalYN0WJpDTg/rX0+tsqFhEJNZuZvbj7HAwEMKGtYQRBu8aOgjpt8na4iGCQ2tp8RMNv8R
	URsn9QrLPkd3Xk/g1xAc/pm1i1bMckfi2b4FRLEv0geaqXc/CQIU/j7ywmPTr98iHsbbboS
	KXgdHYwd98GqGpBqu4BHdkdLZNyPKfiXrD1160Znjx4Qlo7Hd2w+pvIpLZWN4EXDZhHkbdx
	fs1pukFRMumvLNGE+ZpHSTqAfdFnLAXoGFmzUdx2LRDTJJsuUhcwsyFGrALmOGgIXek538l
	MDk4fBCTo7YHqq6Mhb0oMBaSkMImn/W2JHneD1Q14+9Exzn8XwE+sxidQ9c8Ke78J3OFA9b
	Z6Og/y9nRL79bE0ygV3xemJwryE9nxGXdAcb8UG357oTNyGOt/UR0IRrmRXdblYkPGilosH
	o0dJRCzxOJKSsp+kG7jeSBcb8NzTe8+fpR0fZ6+afrnV4ft5FiHXzLWDIde7edCpqKxwpyy
	dVcymiA4JRvtc7wKtXWX8PE4jZbEj91di2RXuc6xbZD5t7kwJzCsm197tdGQ4mzr31OpR6W
	bDZnaP0G0+DZoVsIxXM7nuprelm/CKX9thvy6CHaiVyoPsfmaiOjjdiAayn0yKKGOpBblmp
	LjCW+H0igJ/E3fkwDggl6JwGCoLUIwzXmI6fmuToBnWsnAzhMqxG7yz6ReZ3c14COm3mN6+
	zIWo9+cWza6QnUK+X/v5FGMbblEP4xqm4XvGjNoR2TSA1/4RMESVMD+XUdOk40NMi3MlGJl
	uDX777mU80GLna0sXC9DqjOTMxt/QgE4NOYMM2VyN9elVMzIjfDYWUVLs5JG0=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261742-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,trustnetic.com:mid,trustnetic.com:email]
X-Rspamd-Queue-Id: 527391B3FAF
X-Rspamd-Action: no action

NGBE_NCSI_SUP and NGBE_NCSI_MASK are duplicate-defined, they can be
replaced by the macros defined in libwx. Just remove them.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
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


