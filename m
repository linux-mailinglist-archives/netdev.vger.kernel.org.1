Return-Path: <netdev+bounces-296385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t6pUJPpqJmrRWAIAu9opvQ
	(envelope-from <netdev+bounces-296385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:10:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4CF653696
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:10:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296385-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296385-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6412B30038D9
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 07:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5EE34E745;
	Mon,  8 Jun 2026 07:10:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0CF3101D4
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 07:10:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780902613; cv=none; b=b9WfyeLAZObncR82LzCkyI/NWrSguDXGAN086DaYMk/Pu6GmzcrcpTQ7P+xPNPA7N+IIT66jxfOuUTGyaIRVtENDeXizczNhLoO44f5O3uekvKYZBLuT3FZmJT147oa16sp9vVpd87coj1r3FOsNb2OxcQdvpAJ8v6CpGf/IuKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780902613; c=relaxed/simple;
	bh=YFKArg1umaXnXIGnxXL4S/B58HY+3pT5M5b+rNHc5uA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LnEx9bzd1115UQI87S1ipBc1CzkMF2PItx4Hi/TMZXnQ1gGkjvPpuWhRdHTPxc3nCsY9kv1lLa37uAcAOadjmwhsWcsNjGSFiaOeRXLDvLyNcFBVDQMwxXnZTdSfinrtD9L30boLahwdCUokqHXjWC/coxf37tfyGNHo6uOOlbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
X-QQ-mid: esmtpgz13t1780902543t621014f6
X-QQ-Originating-IP: Iv5ScAM3wvmVdZlz1dNhxkDqoEudTlvYocDPjNqL994=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.184.84])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 08 Jun 2026 15:09:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1869345008062573721
EX-QQ-RecipientCnt: 11
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v3 3/3] net: txgbe: initialize PHY interface to 0
Date: Mon,  8 Jun 2026 15:08:42 +0800
Message-Id: <20260608070842.36504-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260608070842.36504-1-jiawenwu@trustnetic.com>
References: <20260608070842.36504-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Nvs1B4DXFZmrcI4VUhru6HwvjY3eoynncCFEEg466gYXdoGS+9xHJ5QS
	eHB72yrKwJ5FUulzsQELe2F7T34/S1M1Taf50JKYu17gqYBmPywP5fXsEmFPY9BzijHlht4
	8hOM43DUoFK7OigNP+wYwNlG1iLlTpvcmLqkoWqttRSko5dud09v0c3+CRbWoPa+dPpOUeN
	3BAK37ZuRxukkSea33sqpyumpbQk9DgPcsJih1fv6u9/3ZKM9mJJO5l8O4d9ZGydzWA9ngD
	UNEwW38ODayyYM0ZtRRo+skzdm8+478XlhNbkC9tNHc76dL2WBNXm9Kj8yWyw1xDWLq1Aek
	NIb1bNaIEwi6zPISV20kjUwqgTTDLczVMyk+3BJo39/u3VvAkJeYrBHna7wwfma8GCFr5Ok
	muZsU1HxeqKtl9SEgI2HPWUZFIxAjmmMttM6ZONGR070U6PxeeqnJODnJFdUM06NrCOaarc
	xJoGqe8cWlVEIzX88BNXT27v7ro7dEXFahVoXJDJHVSPkSfrYaoj5KWHeLOgfvfakhFKILG
	2XZAwcgjaDx5ktYV4R3EcJMpvBzL89yo1hwf73sVxxZ0ChjaQa7jouNY6HRdmyfzQQPbLfk
	IqvhyFLmG8nHdwyGPNmLjdo/6hude6XKG4lX6wsYkEk89kGMDSiHpB5zWurP3IWs71DHUEL
	XIlEs9HQ564y13e38vigQx1NZQu9jyHko+iI4ECdfNDLeG/RYRfkXod1+fo9pvW3UK45Anp
	AehDdaZgStFy1zX88LfbbakwX0Do/QV1SxBBJsZR2WxdzB8kJW50YYaRG+yLCYwQYm1XRZX
	ampkITYvXVtkDMsdg9278iT09IklHD4julpwCFZJMLCbu67++IjPIxjIAkNReD85rhLZ6wx
	mZXZqlU9vrJ8YaFmd4dzqXp4FfRea2U0kOXBCnUglCYYxry8X6Z7Yf6jl4pAT/jVn9ITvdP
	3L6brJwiNWmH7xS/UfnmOUCPCkJMQl9m3PwZTm5W8i8bR0C20d/GxxTdzs3VhK0MseJZ+ME
	RW80akulSZOp+2NDEzvkQ//P/PNS8kL8rINrBmo7HbP0UA4CQx5FzB1TomR9tqFnteqkZ5C
	ZemP1MTHPmAAPdqZ7dAUpZJtTzqcTqcVOu6BSVjTcJh
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296385-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,trustnetic.com];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:larysa.zaremba@intel.com,m:fabio.baltieri@gmail.com,m:jiawenwu@trustnetic.com,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D4CF653696

DECLARE_PHY_INTERFACE_MASK() does not guarantee zeroed contents. Add a
new macro DECLARE_PHY_INTERFACE_MASK_ZERO(), make the stack variable to
be zeroed before setting supported interfaces.

Fixes: 57d39faed4c9 ("net: txgbe: improve functions of AML 40G devices")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c  | 4 ++--
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index bdac654a2364..8fc32df8e49a 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -204,7 +204,7 @@ int txgbe_set_phy_link(struct wx *wx)
 static int txgbe_sfp_to_linkmodes(struct wx *wx, struct txgbe_sff_id *id)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(modes) = { 0, };
-	DECLARE_PHY_INTERFACE_MASK(interfaces);
+	DECLARE_PHY_INTERFACE_MASK_ZERO(interfaces);
 	struct txgbe *txgbe = wx->priv;
 
 	if (id->cable_tech & TXGBE_SFF_DA_PASSIVE_CABLE) {
@@ -271,7 +271,7 @@ static int txgbe_sfp_to_linkmodes(struct wx *wx, struct txgbe_sff_id *id)
 static int txgbe_qsfp_to_linkmodes(struct wx *wx, struct txgbe_sff_id *id)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(modes) = { 0, };
-	DECLARE_PHY_INTERFACE_MASK(interfaces);
+	DECLARE_PHY_INTERFACE_MASK_ZERO(interfaces);
 	struct txgbe *txgbe = wx->priv;
 
 	if (id->transceiver_type & TXGBE_SFF_ETHERNET_40G_CR4) {
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 6b05f32b4a01..877234e3fdc2 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -315,6 +315,9 @@ void txgbe_up(struct wx *wx);
 int txgbe_setup_tc(struct net_device *dev, u8 tc);
 void txgbe_do_reset(struct net_device *netdev);
 
+#define DECLARE_PHY_INTERFACE_MASK_ZERO(name) \
+	unsigned long name[PHY_INTERFACE_MODE_MAX] = { 0, }
+
 #define TXGBE_LINK_SPEED_UNKNOWN        0
 #define TXGBE_LINK_SPEED_10GB_FULL      4
 #define TXGBE_LINK_SPEED_25GB_FULL      0x10
-- 
2.51.0


