Return-Path: <netdev+bounces-263007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPOTEspPpmmxNwAAu9opvQ
	(envelope-from <netdev+bounces-263007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:04:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 652081E84CA
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA0F3306E85B
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 03:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B859375F76;
	Tue,  3 Mar 2026 03:04:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ABE26E711
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 03:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507079; cv=none; b=deQuqYaMzcqgpmL6D+Mri/dC4mYErT1qR1j6FgdxDzUJ6vuEhxevyIjFWpCah8NPbNPtB03I3LOSdcMxuRi9jTGX/+XJy6rKbpcH57DgSKWPktEIyYKscV7e0KPjVpzD/w50Ridmvi5RkePy9fjScTgtYCn9tekHnO5NOmH2SD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507079; c=relaxed/simple;
	bh=bQ1iIvjboEs1N26sVJJEBNZjYLljImHXeHO8kndxh1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pUwFhBD+8TM3GRBaNVTLeBlCm8l2nHUkwLnBo3P2QOhActL2dT9w3F5M8YtmpWGSfAL5k5tos5DynyfGlYpcGg0YXnjQPjFmZUpQjmzvy7ZxYj/29EUPM2BZE/hhTz5oH2kYy+igpH1xH7clIwFraziqoxPxNjWa9Ce51FPHqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz19t1772507030tb40bebba
X-QQ-Originating-IP: 7YUJRh6O22CiGhMO7wv7+kIrDMyCQRM+Mni2qNEMoKE=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.70.252])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Mar 2026 11:03:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12091037546246444057
EX-QQ-RecipientCnt: 18
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3 2/9] net: ngbe: remove redundant macros
Date: Tue,  3 Mar 2026 11:03:24 +0800
Message-Id: <20260303030331.24076-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260303030331.24076-1-jiawenwu@trustnetic.com>
References: <20260303030331.24076-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MwqrwaLzgdebxj1NNPZggAN81pC9c348EnKKVsAQm4F4sm0DbYJGK/rc
	wfpZh3jyYiVxZWVgfzkTOpZt0J/TCYI/fmqOcA4DYme2vSqLWr49vb7U6qU9K7UDJscHkV0
	svTXFhr98LIHM1av7lw+Jr/D/He4oa8YVr29WJnsQdaJi5hk4+vGmLJn+FDOem6LL3xT83M
	TTECUd0fTwRzaqECWq0KIqalH28cXSkbXTNdRysCybVsCNiswYSmN0DXhB9Si08y6PRLBOH
	mN2b3rldlydXBrupwLAA7L0Ttep4+S6/ckF953ZASdtpaQf5YQa/udmcIWU4DH4IDlk4u4v
	RZH2ShbgbOTvC/yMl/65UTgyh9a/RvVatiaPCCi4wSBo6suI4I8NDsY+uqAyj500g47IhnW
	0rL8mxYCBhvRQS/AALiVJKThSMuNAgNjc6DPKHeOPp3l7fOY9TLiOV39VydQX6duMgjLptZ
	4CboEHzgcBJUPM022LZPW8Es+WFvpybtXeCgbArIhrya5LGtTSWjkcWGPBtaZHfZ0ef2Jik
	UrQjJ56O9rW64qeuwoQm9S0Ck+6dnygoasL57Shc+WweI/xXuVvrKtT5scvkdWuyvN+Kl3D
	Knp1RCZjWWgLyL1I8EYY1uuNGkSgWehF3mJrqbLxC3iozpMtF02T8ra5z57sdNKI/jsOiqb
	uLefzmBtv10mC8n94SVSCaeQB3ic+2JJq4vDmZtHE1YVrpC1JjSXPpXT0KNzq8aVvj5D5qv
	JdC9HRcWMVV/2TW3majEA2FqlmnsoDQBrbztmpt4uC+kT7IgSnkSw1eDUJg1Xdbw7IIQ2WK
	ouT7ioazha7QcCuuCASYq52tVFwE1HHMo8ruxEDp7GulymHF/lmGWRulaElWPAwZzb4sqf6
	UlMvbVPSLvy/CkWvJ05lEiSds7i04CthPakMX47AFnYJ/++RFVx3tgCC5RFkH0ag/qd/TEk
	bELzkTuCJM/F6TdajpcRYKTQxkPl3f0e8TGPrenCB6eYFQ/PZ+SASyfZEiOKlxhmuhBjiGk
	ZFkory2LZ00BE6fxzXhsUZrXXfPns0vVqUEA6SfnU4mLBS7QhsuZ12Gpm3c5zJWj57RNeBI
	7AVEvauayY1VAweRBxwMGc=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 652081E84CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263007-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.857];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dama.to:email]
X-Rspamd-Action: no action

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


