Return-Path: <netdev+bounces-264689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJBLMlN1qmnRRwEAu9opvQ
	(envelope-from <netdev+bounces-264689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 07:33:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A25E21C192
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 07:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E430302DAAF
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 06:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F1537104F;
	Fri,  6 Mar 2026 06:33:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1A5366042
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 06:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772778829; cv=none; b=n9nHpqjaQuTZQfobYOJzf3sxx2m1Mxfawb2/RV2NduCr1LyBsPR3eRWdDLJh/Fye8S9N7IkAVa5oIRbX+ub7eDP8qlKEFlLiXSbu8eIbDGP6uURm70yW+b16HD/pkuXfmd08LOFmlQLZVZxVlpXWspk/g/djWSq2XM6CQOXTW5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772778829; c=relaxed/simple;
	bh=bQ1iIvjboEs1N26sVJJEBNZjYLljImHXeHO8kndxh1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rNkIrPAIxgXgUDTi9DYBKVNLI50icj8i1u87n8SDD2OV7ALZpeEEpsHkaEzZGQ0h9uZFhTX0+ItTY2HH/kuTaPAOofN7VJC6HGuKdqaQBHr6lmDumQZSiBTJhFrzTNNnwdvv93xslDpLRUexozYjZK945ypx32WQ7zVqO/NYNqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz3t1772778771t4a733084
X-QQ-Originating-IP: BQMlwJ25A0yTYuOTPCZGuVKMrfow9S7MKV7e+4oXKrE=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.243.152])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Mar 2026 14:32:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 296988981174416083
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
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v4 03/10] net: ngbe: remove redundant macros
Date: Fri,  6 Mar 2026 14:32:04 +0800
Message-Id: <20260306063211.20536-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260306063211.20536-1-jiawenwu@trustnetic.com>
References: <20260306063211.20536-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MZFfrANmYw9trFlqSTprWJEsi6QSNeDKZiE4lLFb+0gfv20gMOlM7RcW
	Z9odYRTWlHWHCwAVGdT4zJS1crSss0i5kRWkR8bhZc1jefXpMEWJA1V364g+Q9RFslodFi5
	Z0Uzk+5rUXy8CHp0gGAAL/tZef82zO5kN8cuOjqnxs7MChc+Vvt8limB+1JjH5ra+wNDflr
	kRaDnyCt+WJRpk6/7rV+UtS0zssQZDeKaUcIOqTUHa+DPQ3SoQS02Tyc+50qxPiEuAqIXcw
	GHKhdssvUUjBMGkLCaLcwkVUjdvYqrnu6gd/TR99SfsLm9S937jbZtD6D2a07a2z3AlJCJ8
	/Nx2w/fqxUbuQ1U9iylx8wWBHA90RAVO6Qwt92G/w1GooQb/aLTZH0lY6gNJRLGkiExeEfJ
	jZ9LMShM0do9dXu+O8BVy4k8ivlXSCbLrMawxZI8aTAolYhw4VDT+kMHnB3G0GAFrfBkt5d
	JuWN89jV0nxhY7SssTNpmHWYohhUNOhgkxBbo+BVahinmXracaQQwaamk4Dag+OpT3ozKkK
	Nn4rKGi4QlgpPgygFvWiDzPP5hGS0RIB653trFyXL82QGMc3E4ugPiNoeeTCAt9Zm/gxPPU
	zgDB22Z7jaGeQemEgnuMWkAqr2vECIIGpApEv1GZIQEmused7Ta66VVQHFvUWc1cTzYzAlQ
	wqN3byaYYSWArT3NvW6U8doWUC7L9NBOexjVOclFd5WUsp7jNOBIqiDHs5ggYoVMe6lJDZ3
	qBABalg+h4DxrVsNIkRTMhYdRG+RKMa1L0T4h4Su4FPnQInwy9+rbLn0tZn4Y8B0qly5Hf9
	JfRp4eF8hvb8sGekp8xnAja/7oLojHyheGg/h7EHyWcVGn6asM5aEB1ZO9iKBTnlJuHAjM/
	Jca6paKfPPUwcn3fKhpu9xPfkDp0dQQLxcxqqfTu3/2pILSjwQ48osoNTTUoGme+/BbVPPt
	zAD2d3mpGxv5Y2emKV2UHNtAgeGcPiuuPfxRWJgbbUKyVHWBjaVd0esl5psEHSn/qyi++PP
	g7LHd1YqflVg+XUccexzh4xo1Tb09NWxtwwTNsE85WzKFTBwWYnrh7r0kqlhnySrLW11lLV
	KOGTkAZ+acyBSFp5gJ7BAKbfjjEENOtEQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 6A25E21C192
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264689-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,trustnetic.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
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


