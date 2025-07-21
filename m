Return-Path: <netdev+bounces-208505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66ECB0BE58
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 10:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A7716D1EC
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 08:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0354520C009;
	Mon, 21 Jul 2025 08:02:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1D6469D
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 08:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753084970; cv=none; b=H92WDcaDNAvQuVoEdjqtL/AYyULu9BpFmxFfEtuJuWXcMQDItLjcFZjb0wjMDzJoxN+Prj/Wi6IM3iQuqM2xdr2Nzdm1ctPtt0y2WX8WTxosR5Qub1FJWH7UEFi2iN8BxKdoTN3QVeHX1r3J2kbeGY9bIU4V7XJb2Or315COLtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753084970; c=relaxed/simple;
	bh=8pjqn7Plrn+id9IfY8/4DIYjODFkHMG+uWBAlpHYTtk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lE4x/ohCTiVbLsnpKFV8uvcETkq3lSBbPE/Fkky4QH8Iu+E0jPbUNazjDvn7vAD3kny8K+L8l/KEHZ9p+LuHM2azzHnuWaGixalv/i9x4+QezKd4hTWDRMC2GJMoPsRu96CXkpZQaC6JQVckZkdlBDbWxcPc7WfGU7REfSyHKt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz21t1753084895t79760790
X-QQ-Originating-IP: lMoZS5z64F4I2OKInSG8LFMKWTHBk6GlMbgficM0jQ8=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.205.22])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Jul 2025 16:01:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14552170565156338871
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
Subject: [PATCH net-next v2 1/3] net: wangxun: change the default ITR setting
Date: Mon, 21 Jul 2025 16:01:01 +0800
Message-Id: <20250721080103.30964-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250721080103.30964-1-jiawenwu@trustnetic.com>
References: <20250721080103.30964-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Nw9C1WBu09hPmMTJZZ0EIrpHJV2/KLqC68VTWz+2jxlFL3buGDv1f8uh
	0OQKK+b12em4nD2ofxmLiFaTF3/4x9AR9EI5aFK1/Bm3lLCZZ3At7MdQEWCrEOjmzyqpA/G
	Gb7UQeyMT/LlAdTW1z6fcoxzWVTBJoBMb2VZS+7zubGZQUjozct90U8FrwMxuknBkolEOgG
	O2/JPE79SU1SxuqlI3gklj6h8qqzOOZ8oTKnu0ew00kTuPH21cTVQaY7fpn4gj5KwjIToQq
	0I3fYNbNOLa3jWPmgXV6CpjN2F4k9egHyXZHisB7HPszdwI5mKzGyDWf+22VnUFfUdxIcFV
	c2sSCjB2hleQmq+QXpE5z9mxdE3n/MAy6U8g67RKihRM4TGz2LwtWJnjU2yAazNHqzKhf5T
	COoHnYhji/NbJgurT6swPfi82x546JsaLe510+ZszjVOWRNR0/x/3ATLlICFRrVnaPKWakw
	VXDupuRvItLlHv3zJWTt931FUrMiGCcUk4s8AU5bavc1EHJlQPeWaMzKDy7zLpscZTyBp6/
	EuHIhacsLfb4Kks+gksb1nJx7Pv6dUhIUWtL8pls+K1UvSZUOulpiMBWtq+9JA5rDpNDD+a
	/+zX4RyaoiWdGgwuOU7mFXRpdcNi+GqAPBjOzqGS0KzbYr+zCRiQZaUvECnzxlJ176Qq6hZ
	Fw3vs1TCXnu+mDoFnssMIJV56Rl8gRuYN/PFCPzMq3dd1Vt71eGhSHo+bDm8N3+bXXzgfr1
	y/4C1mMWiYnBDz5EbYJPSlIH4MqV1YF8ZNXXKr7wK5/gMsLvLDIV6cE9fxRXJmJhRikXFqO
	KWoagiEfz7LPPMmBqsEg6ohmmV98ZaVpDSEMU4rvbFLA7Il2nk/FbE5wkd780bkGZDsK6V0
	84wpHiRnZNeo9sXV4FRTytqLdR+rFO/9Qsqtj2dPeyVielO4iE+0JHNjnjvc1z8FJZYTYlV
	C1fDK7iSNK5j6ZMsag+u/oXdaNsToY+5p7kH6LFzkDhuMr1e+I4cVp3CjYyxkc8O2eNnQSA
	wc+CplQcOe3o9spz2XsyCe7yDJyXU=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

For various types of devices, change their default ITR settings
according to their hardware design.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 24 +++++++------------
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  5 ++--
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index c12a4cb951f6..85fb23b238d1 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -340,13 +340,19 @@ int wx_set_coalesce(struct net_device *netdev,
 	switch (wx->mac.type) {
 	case wx_mac_sp:
 		max_eitr = WX_SP_MAX_EITR;
+		rx_itr_param = WX_20K_ITR;
+		tx_itr_param = WX_12K_ITR;
 		break;
 	case wx_mac_aml:
 	case wx_mac_aml40:
 		max_eitr = WX_AML_MAX_EITR;
+		rx_itr_param = WX_20K_ITR;
+		tx_itr_param = WX_12K_ITR;
 		break;
 	default:
 		max_eitr = WX_EM_MAX_EITR;
+		rx_itr_param = WX_7K_ITR;
+		tx_itr_param = WX_7K_ITR;
 		break;
 	}
 
@@ -359,9 +365,7 @@ int wx_set_coalesce(struct net_device *netdev,
 	else
 		wx->rx_itr_setting = ec->rx_coalesce_usecs;
 
-	if (wx->rx_itr_setting == 1)
-		rx_itr_param = WX_20K_ITR;
-	else
+	if (wx->rx_itr_setting != 1)
 		rx_itr_param = wx->rx_itr_setting;
 
 	if (ec->tx_coalesce_usecs > 1)
@@ -369,20 +373,8 @@ int wx_set_coalesce(struct net_device *netdev,
 	else
 		wx->tx_itr_setting = ec->tx_coalesce_usecs;
 
-	if (wx->tx_itr_setting == 1) {
-		switch (wx->mac.type) {
-		case wx_mac_sp:
-		case wx_mac_aml:
-		case wx_mac_aml40:
-			tx_itr_param = WX_12K_ITR;
-			break;
-		default:
-			tx_itr_param = WX_20K_ITR;
-			break;
-		}
-	} else {
+	if (wx->tx_itr_setting != 1)
 		tx_itr_param = wx->tx_itr_setting;
-	}
 
 	/* mixed Rx/Tx */
 	if (wx->q_vector[0]->tx.count && wx->q_vector[0]->rx.count)
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index e0fc897b0a58..3fff73ae44af 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -119,9 +119,8 @@ static int ngbe_sw_init(struct wx *wx)
 						   num_online_cpus());
 	wx->rss_enabled = true;
 
-	/* enable itr by default in dynamic mode */
-	wx->rx_itr_setting = 1;
-	wx->tx_itr_setting = 1;
+	wx->rx_itr_setting = WX_7K_ITR;
+	wx->tx_itr_setting = WX_7K_ITR;
 
 	/* set default ring sizes */
 	wx->tx_ring_count = NGBE_DEFAULT_TXD;
-- 
2.48.1


