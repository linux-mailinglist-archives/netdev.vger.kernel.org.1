Return-Path: <netdev+bounces-294600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OtUJJ2vTH2oCqgAAu9opvQ
	(envelope-from <netdev+bounces-294600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:10:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE53A635063
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:10:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=Dw2Q0Myt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294600-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294600-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9361630E242E
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5271E40FDB9;
	Wed,  3 Jun 2026 06:59:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B0B409620;
	Wed,  3 Jun 2026 06:59:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469985; cv=none; b=M7vm33g1vzs++GGEjSqQAP/oRjf75nl4YD0MfeKc4UZ5iImbeLhElisJhYqbnQrj4IbweNBlQMk44dD3vhbCj6GwQL5JTw4N9uoU9x6gNiHhqbxIcH/yZvNMexDH3AvD3WGClfIov7h507MNO+53F0kDF9pvLPFwrC/joT9O+ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469985; c=relaxed/simple;
	bh=5oF24+QgNRDqV1rY1wjnWqyUj6Bm0F/UhtC+TFpT0lg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTEpMs0mNuB9f//i819V6K1tnP5uzkEOFVf8UcWh2B3O+I+AIENHZW3UQWJSjx9+NG/4EG+1/FK3Zluzt2JvkCj9FxeCArY752ungScHBcccnAuV+OmliuhTPiy7NBu7pJuuGVdUSXuVoQreU6fezYDSKBcGRuU6IUvM8HTvMTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=Dw2Q0Myt; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6536xK0313643786, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780469960;
	bh=noRw64KBgx4W8m91UcHG96FC1h2z9tnNyn/WjAASIq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Dw2Q0MytaPNN/IpMcwAlrC13W70osS/zvbs/qIx/C7fSYE5WTJyMHHcq4bEUSJXOU
	 t19aB0Ovjcql97Sz8iYi+xZ7kSYpm1PP8PNMcDm7p7oAuSIeGYVH/Q6YeIjLp4U4/3
	 6BRyYpdi1/usNx6qzJtlOKs5itZKU0zP4pdYisduRjdke3YxHwygo2WMfUOD4KLKxP
	 9gPzWzCRYgzDNHpX89rsXv1oj6rqZxfoEntxTHkzdPi38Z8LA8FsFOt6nLINYOTzSV
	 Csx9avflhh+1R9yY64nLpL+XnSXaS8jCJxF+iVR5u37xYzYtrJ3br2e5YvolZMBDB4
	 nNFKt3sV1YXtQ==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6536xK0313643786
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Jun 2026 14:59:20 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Jun 2026 14:59:20 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 3 Jun 2026 14:59:20 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 5/5] r8169: fix RTL8116af can not enter s0idle and c10
Date: Wed, 3 Jun 2026 14:59:16 +0800
Message-ID: <20260603065916.334-6-javen_xu@realsil.com.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294600-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[realsil.com.cn:mid,realsil.com.cn:dkim,realsil.com.cn:from_mime,realsil.com.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE53A635063

From: Javen Xu <javen_xu@realsil.com.cn>

RTL8116AF is a multi-function device. Functions 2 to 7 are hidden from
the PCI core and return an all-ones response when their vendor ID is read,
so they are not enumerated as normal PCI functions.

However, these hidden functions can still affect platform power
management. If they are left in D0 or keep ASPM disabled, the platform may
fail to enter the low-power s0ix state and the CPU package may fail to
enter Package C10.

Put functions 2 to 7 into D3hot and enable ASPM on their PCIe link control
register. Since these functions are hidden, access their configuration
space through pci_bus_read_config_dword() / pci_bus_write_config_dword()
using the same slot and the target function numbers.

Ignore functions that return a PCI error response when reading their
configuration space.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 31 +++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 5db15137f216..cf73915c48bc 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -341,6 +341,9 @@ enum rtl_registers {
 #define LINK_SPEED_CHANGE_EN		BIT(14)
 #define LTR_SNOOP_EN			GENMASK(15, 14)
 #define LTR_MSG_EN			BIT(0)
+#define RTL8116AF_FUNC_PM_CSR		0x80
+#define RTL8116AF_FUNC_EXP_LNKCTL	0x44
+#define RTL_PM_D3HOT			GENMASK(1, 0)
 };
 
 enum rtl8168_8101_registers {
@@ -3731,6 +3734,33 @@ static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
 	r8168_mac_ocp_modify(tp, 0xe860, 0x0000, 0x0080);
 }
 
+static void rtl_disable_hidden_function(struct pci_dev *pdev)
+{
+	unsigned int slot = PCI_SLOT(pdev->devfn);
+	struct pci_bus *bus = pdev->bus;
+	unsigned int devfn;
+	int func;
+	int ret;
+	u32 val;
+
+	for (func = 2; func < 8; func++) {
+		devfn = PCI_DEVFN(slot, func);
+
+		ret = pci_bus_read_config_dword(bus, devfn, RTL8116AF_FUNC_PM_CSR, &val);
+		if (!ret && !PCI_POSSIBLE_ERROR(val)) {
+			val &= ~(PCI_PM_CTRL_STATE_MASK | PCI_PM_CTRL_PME_ENABLE);
+			val |= (RTL_PM_D3HOT | PCI_PM_CTRL_PME_ENABLE);
+			pci_bus_write_config_dword(bus, devfn, RTL8116AF_FUNC_PM_CSR, val);
+		}
+
+		ret = pci_bus_read_config_dword(bus, devfn, RTL8116AF_FUNC_EXP_LNKCTL, &val);
+		if (!ret && !PCI_POSSIBLE_ERROR(val)) {
+			val |= PCI_EXP_LNKCTL_ASPMC;
+			pci_bus_write_config_dword(bus, devfn, RTL8116AF_FUNC_EXP_LNKCTL, val);
+		}
+	}
+}
+
 static void rtl_hw_start_8117(struct rtl8169_private *tp)
 {
 	static const struct ephy_info e_info_8117[] = {
@@ -3787,6 +3817,7 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
 	r8168_mac_ocp_write(tp, 0xc094, 0x0000);
 	r8168_mac_ocp_write(tp, 0xc09e, 0x0000);
 
+	rtl_disable_hidden_function(tp->pci_dev);
 	/* firmware is for MAC only */
 	r8169_apply_firmware(tp);
 }
-- 
2.43.0


