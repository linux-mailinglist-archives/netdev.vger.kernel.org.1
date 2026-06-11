Return-Path: <netdev+bounces-298041-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uSjsDweEKmo9rgMAu9opvQ
	(envelope-from <netdev+bounces-298041-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:46:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BCD6708BB
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:46:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=ict4qA89;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298041-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298041-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 850FB32A633E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433F13C4576;
	Thu, 11 Jun 2026 09:44:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305B8388883;
	Thu, 11 Jun 2026 09:44:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171072; cv=none; b=UqGATHB5OgI0dT4T1J2OLs1ix/NepqZ7fLqTso7PylmlOju1Oc/t9FHGgIhr7bRSiD7sBE+b5QD9TtZU/Rss4kJvoRxNLKH4yY8eHcK6mRPlA3jtxKjmdT6vzd2O5f7cP9pF0d5CVmnhwfcA9VMblvQRBsmA5yn6nV0i0NI2rcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171072; c=relaxed/simple;
	bh=1tSD0GWknjkmYPJQZTVgAdsrYR9YvFojAyejDbB4apE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Biuja3SmAgv9xviz8t29Cmzm2Tq7uSONHnirFJDViMYfy3hRVI9rwymPuop+isXXNocBViaeZMijT0jMG/wdZyFbNQ9MBWeov4mo+0rBEwPb70s1w54GascDdFzvGNiB6FJDNEhd7vWi6YiPbQoWtctT23tcwsgJwPsdRXNoA5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=ict4qA89; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65B9hmUwB1836014, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1781171028;
	bh=LwXFZZJIcxwOK4n2zLp5jQdDHi1Ox+4quE+ySM5WD6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ict4qA89z9deJr2rMOlVSpQ2hHZrEk5G3czFC4eMTpU4xEC6/NJTtgprJTp1tJ66H
	 niHe3CKSM3S/BImpywDseywx4WaSLF9LhTYhVsiXXbnzAlmMvCQxRcRQFn9HIvE6z5
	 0fjTTXdTNjhBgPrT691hcvzVFYQ9cUlEx+lEnvsz0HP9AZ4BWGhMxKdCTzsV/BloH5
	 C/ZR3n+ptKqLJCLzjqOnWnqISZEKsf+6lGQuW3AhoWzAQYvMlz0l3bD1a+fOo6IKui
	 h0hhY8D5Wq0C2nzqP6JsSrmzO46XhVcwgLcFoz9s13XHBQMmufF2YP0UlUscq8KozX
	 JNfUtDKYxzynA==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65B9hmUwB1836014
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Jun 2026 17:43:48 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Jun 2026 17:43:48 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Jun 2026 17:43:48 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v2 6/6] r8169: fix RTL8116af can not enter s0idle and c10
Date: Thu, 11 Jun 2026 17:43:45 +0800
Message-ID: <20260611094345.880-7-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260611094345.880-1-javen_xu@realsil.com.cn>
References: <20260611094345.880-1-javen_xu@realsil.com.cn>
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
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298041-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realsil.com.cn:dkim,realsil.com.cn:email,realsil.com.cn:mid,realsil.com.cn:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6BCD6708BB

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
Changes in v2:
 - no changes
---
 drivers/net/ethernet/realtek/r8169_main.c | 31 +++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index a49e7a8d8f4d..bc00cdc3add6 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -356,6 +356,9 @@ enum rtl_registers {
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
@@ -3789,6 +3819,7 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
 	r8168_mac_ocp_write(tp, 0xc094, 0x0000);
 	r8168_mac_ocp_write(tp, 0xc09e, 0x0000);
 
+	rtl_disable_hidden_function(tp->pci_dev);
 	/* firmware is for MAC only */
 	r8169_apply_firmware(tp);
 }
-- 
2.43.0


