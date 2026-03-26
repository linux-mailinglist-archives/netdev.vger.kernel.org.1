Return-Path: <netdev+bounces-271798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK8GLsWXxGnn1AQAu9opvQ
	(envelope-from <netdev+bounces-271798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:19:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F63B32E527
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0305730715C6
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 02:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C80137F8AD;
	Thu, 26 Mar 2026 02:16:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9760E2D7D59
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774491367; cv=none; b=OY4p3mNYn0Gydg+Jjy9P4xlwzbPcA0MiuXzZ1/1SuxH86rMNdLTbgS2NqLzZEfztGXQAFLNMFYXRMoz94vac6k2uDINwrk7vnl7Qq0w4ysqQZ7CSXdBOem606ojTx6TYU+EyzLZhuao0OIGC6sG6sCKMnS2b9mHC0EtIkxbG6UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774491367; c=relaxed/simple;
	bh=bQ1iIvjboEs1N26sVJJEBNZjYLljImHXeHO8kndxh1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mEofIoBEmax0N83RWC9mPETbIg5WneCnobhRZUEdjeREdj4ZoH6/OiebDtHuqSldF6xKU819iJMU2JdBRmofmHyiufa0De7hE21PH71PeK2EwFXgWDyNN9n3tAAqatbHWt2GAoJmHfCrVxV1iVKVMIB49KXwikJ5kJ4jlew07EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz11t1774491310ta890498e
X-QQ-Originating-IP: TJJ2EQBMcRc6B2jt3INTZmtj5J+tV1PxzZcCQ6ZgwdA=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.60.44])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Mar 2026 10:15:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17796672652307540879
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
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v6 03/11] net: ngbe: remove redundant macros
Date: Thu, 26 Mar 2026 10:13:58 +0800
Message-Id: <20260326021406.30444-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260326021406.30444-1-jiawenwu@trustnetic.com>
References: <20260326021406.30444-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M00LTjaIG6jEn7Mr9ugICi+112CAqujSbrtmLpZ433RZWvk2D4hK6fZv
	dhyXVsNIRiYzPgMvSCgzciRAUo/nP8N4Jqrati8vqLuLfMwZplaO3jTcpQBfg8hwRgDq+BL
	nGqTaJZdX+IExgBMrVSfQjCJXsokfcqwBI3gPtXHXD5teQ+gxCtZYtFmFP/a8MaMjzJZSZl
	1mtOzCQby+eKCUwxtQEWPnzIFPjciA6cNpwIsQ6QLO6K0HYul4lCH4Oahqb2IALmuU3IrIK
	WsWNZqZVDVmmPqC4Km+9rxmDCPSvwGwkkedZW/xMMsCMbwl6y2ZMM8IPUdHIV681eRbxREp
	jHzpyFvY1J+UbszbsJZo/r+RvZ/b5gSbO98Ki51gqPy6UMegMr3/RkQagS34JUXOfo2bZ0L
	Ir4mvEh3EcDWU3EuOkqn7FVjD3uTe84OMGNfIVKekuC1EtprdDu9NViDjXJ1YAG9MUy5vtH
	n4XXqIcJrOP0qsdYba5qxa+60EPfSJufk0uMuV4v5ByYFdx7HUXYwEJ+2LCL5vpj+A/7yRj
	7PGi4L1YjYv0UwCozOpqnfibLI0mS2/JWEF7aqPTDSKU2z8L6yvn3x8Ypim5IRpsVd3/hpq
	qEvRW4OtLnNpZYtu9YboE+T4lTEClJJsg9OB/N8zi9SkDxYX2rYOV1Ba1upN4dai8Cu4svN
	Pevtn1+Sw0x/G4bquVxNqfA++HF3rIU0O27Ib5AmG05WqiIkKL7G2H6TLoxKJ7pZA42OTZb
	wU57yo1QAT7U2V99bYzDt38HVh8Po5iatXURgA0ASRoR4zse2SxQtUJDp/SaUI9Uicf7ZbI
	OK885YYwRK1BgsT4dvm+D6ekLIAHaznuVXBbxDQlFPGGyNsSNdBnifELVtNFUic+r8ysRFV
	CIVGISHKm2fBc33X5qQSXh04ISk3WRqoTxILtHEONUiDcqR5sJxN7qjCTn7WIS64Pwb3/ac
	s04griqKepQywPRE0+Ao0bw6j5eTGkUBhXIXV01hgA536AwBSzhWpUTmkpr3gYa3mrQ/BYN
	xUS0vMvIK19J3DPI1BdMNeak399Z1gZbRRMXHKbwZ0gpT6H6LziIISkt1enZSHQJrKQ4qlm
	0+O1m9U5AW/n/NCOWbImhQ=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271798-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,linux.intel.com,intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,trustnetic.com:email,trustnetic.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F63B32E527
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


