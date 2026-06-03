Return-Path: <netdev+bounces-294599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6REYFJDUH2pgqgAAu9opvQ
	(envelope-from <netdev+bounces-294599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:15:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4480A63510D
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:15:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=UxG0hh3Q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294599-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294599-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9294230E5AEA
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211F940DFDE;
	Wed,  3 Jun 2026 06:59:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D1640B6D1;
	Wed,  3 Jun 2026 06:59:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469985; cv=none; b=kwO0FWmilwWGwr9QuDpuFzoWcSOiq3V4RYWzIu2IU3xN9v5rx9JbnGAqSSeK+83hzNObudZhKI3jccocy9AyfV5KMZ4cC/niHKTYjObHyFUgyUy2D7hyB+MOiSNmQaQ7NBKJWt2w6wwauS572O5foSNFGgHjQiHDcXOmUPB8b3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469985; c=relaxed/simple;
	bh=wco1WsXFx9HhMO6jzXA5DmdcmtCt5f4BRno6JcD2MrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TVSVT+QkKpw9rfPiysXO7GIkNvRBvgoCgyA39D/uHZBnr9CRUTkqMTGzgkrWpDCCpcwtqA2CD2Pe0ylXuJvZt+CogkC4GIsqpVTgGq9vWZSbUO0SIqYi34VzUCms+wNIAMt7MQerj95jtwAtIYMf9V+p5hyXOBH5zxTjSCmZahk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=UxG0hh3Q; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6536xK0213643786, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780469960;
	bh=oEJUQpcoZWNtzmED8fDqn2l53Rig2vB4GMbla3zgpiw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=UxG0hh3QlqgmTDm91ZsfsrBFFuOxAAAE+iDuITmQkXNTjFBPQorzBfawcIYl0NlWT
	 RKJ4L9yhGKu3soAANU2Lz9jIhi8J4LdhTLLLlsRCQGmMLbq0MDo6Bo9GiGlvVofnJt
	 2znM1i8jy5M+fDmU6AKBX85df898JG2BoFp1M5ttZbfw1dBYu+dDIlGyuEdK/zdA2P
	 n/+s1Q6KBXeB7ncvTcWDI6y/POyPumJ4CNjdEtJ05IhMv91TwpTm+IqCaZNLEYuP2p
	 WRn8GVcGTSPEUymbg7MjoDIXVWWLKpmmPtba/YLhZiSJPtpbuO7ynDtkJVQxlplMWa
	 nX58/bqHBamTQ==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6536xK0213643786
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Jun 2026 14:59:20 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Jun 2026 14:59:19 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 3 Jun 2026 14:59:19 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 4/5] r8169: add ltr support for RTL8116af
Date: Wed, 3 Jun 2026 14:59:15 +0800
Message-ID: <20260603065916.334-5-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260603065916.334-1-javen_xu@realsil.com.cn>
References: <20260603065916.334-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294599-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,realsil.com.cn:mid,realsil.com.cn:dkim,realsil.com.cn:from_mime,realsil.com.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4480A63510D

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds ltr support for RTL8116af, enables RTL8116af enter l1.2
state. This makes sense for the system to enter c10 state.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 31 +++++++++++++++++++----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 56653608633a..5db15137f216 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -334,11 +334,13 @@ enum rtl_registers {
 	ALDPS_LTR	= 0xe0a2,
 	LTR_OBFF_LOCK	= 0xe032,
 	LTR_SNOOP	= 0xe034,
+	SEND_LTR_MSG	= 0xe038,
 
 #define ALDPS_LTR_EN			BIT(0)
 #define LTR_OBFF_LOCK_EN		BIT(0)
 #define LINK_SPEED_CHANGE_EN		BIT(14)
 #define LTR_SNOOP_EN			GENMASK(15, 14)
+#define LTR_MSG_EN			BIT(0)
 };
 
 enum rtl8168_8101_registers {
@@ -3153,8 +3155,22 @@ static void rtl_enable_ltr(struct rtl8169_private *tp)
 		r8168_mac_ocp_write(tp, 0xcdf2, 0x9003);
 		r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0000, LINK_SPEED_CHANGE_EN);
 		break;
-	case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
 	case RTL_GIGA_MAC_VER_52:
+		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
+		r8168_mac_ocp_modify(tp, LTR_SNOOP, 0x0000, LTR_SNOOP_EN);
+		r8168_mac_ocp_write(tp, 0xe02c, 0x1880);
+		r8168_mac_ocp_write(tp, 0xe02e, 0x4880);
+		r8168_mac_ocp_modify(tp, ALDPS_LTR, 0x0000, ALDPS_LTR_EN);
+		r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdd2, 0x883c);
+		r8168_mac_ocp_write(tp, 0xcdd4, 0x8c12);
+		r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
+		r8168_mac_ocp_write(tp, 0xe0a6, 0x9003);
+		r8168_mac_ocp_write(tp, 0xe0a8, 0x9003);
+		break;
+	case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
 		r8168_mac_ocp_modify(tp, ALDPS_LTR, 0x0000, ALDPS_LTR_EN);
 		RTL_W8(tp, COMBO_LTR_EXTEND, RTL_R8(tp, COMBO_LTR_EXTEND) | COMBO_LTR_EXTEND_EN);
 		fallthrough;
@@ -3174,6 +3190,7 @@ static void rtl_enable_ltr(struct rtl8169_private *tp)
 	}
 	/* chip can trigger LTR */
 	r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0003, LTR_OBFF_LOCK_EN);
+	r8168_mac_ocp_modify(tp, SEND_LTR_MSG, 0x0000, LTR_MSG_EN);
 }
 
 static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
@@ -3207,6 +3224,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 		rtl_enable_ltr(tp);
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
+		case RTL_GIGA_MAC_VER_52:
 		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_LAST:
 			/* reset ephy tx/rx disable timer */
 			r8168_mac_ocp_modify(tp, 0xe094, 0xff00, 0);
@@ -3219,6 +3237,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 	} else {
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
+		case RTL_GIGA_MAC_VER_52:
 		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_LAST:
 			r8168_mac_ocp_modify(tp, 0xe092, 0x00ff, 0);
 			break;
@@ -3732,7 +3751,9 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
 
 	rtl_eri_set_bits(tp, 0xd4, 0x0010);
 
-	rtl_eri_write(tp, 0x5f0, ERIAR_MASK_0011, 0x4f87);
+	rtl_eri_write(tp, 0x5f0, ERIAR_MASK_0011, 0x4000);
+
+	r8168_mac_ocp_write(tp, 0xe098, 0xc302);
 
 	rtl_disable_rxdvgate(tp);
 
@@ -3757,9 +3778,9 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
 	}
 
 	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0000);
-	r8168_mac_ocp_write(tp, 0xea80, 0x0003);
-	r8168_mac_ocp_modify(tp, 0xe052, 0x0000, 0x0009);
-	r8168_mac_ocp_modify(tp, 0xd420, 0x0fff, 0x047f);
+	r8168_mac_ocp_write(tp, 0xea80, 0x0000);
+	r8168_mac_ocp_modify(tp, 0xe052, 0x0009, 0x0000);
+	r8168_mac_ocp_modify(tp, 0xd420, 0x0fff, 0x045f);
 
 	r8168_mac_ocp_write(tp, 0xe63e, 0x0001);
 	r8168_mac_ocp_write(tp, 0xe63e, 0x0000);
-- 
2.43.0


