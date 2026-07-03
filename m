Return-Path: <netdev+bounces-304469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RZgnFVyAR2q0ZgAAu9opvQ
	(envelope-from <netdev+bounces-304469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 11:26:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE397009F8
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 11:26:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=DZ0SnF0a;
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304469-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304469-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7B1E303EB16
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 09:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6407F3B19D1;
	Fri,  3 Jul 2026 09:25:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144CA3B0ACC;
	Fri,  3 Jul 2026 09:25:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070732; cv=none; b=e/d05bTYGf7/w0v0ld1RN3FDUFV1bms2aisMxXOYRmo/vZo5PZT5TG5CZ3bqHW1INNiTRDZ2M6SM+z5HQsr+ubzt3ElI5FNODsq8/Z0XNmfihF5fhZZUz/mb2qaKJmET7vEWIi5AEdOQIKi4hiI7psBC/x7BwxqkZW92gMTSfNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070732; c=relaxed/simple;
	bh=+w3iI0F2QcIRlzVsH8hx+cjktI/TXrZrw0Zm4Uw5yaY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a4SCqAwnNEXEU04fjtB9ZYStGklPcgBYljhUqKB2DN8Y5BDYxlfY9GSZkZPMJRf8oh71zdTXd6Y+aIJoDXPMJ3w7WMkFUKGjYIFIDAu2Bbj/WOi8WEavY2NJ7FFFfF0GHtXyE405rElg0UPLH403U+NULcWm/D6ZjiEJi898xz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=DZ0SnF0a; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6639P3SQ02572104, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1783070703;
	bh=7xJjw4OUl+JbtO09ltxM6adgXmlkyNRcHGzobj8UvX0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=DZ0SnF0afzlYG+Ot9iP0Zy4f7FpjxrPpXspHaTj9cle5y0aurpSgeKbTtzA+zpR/w
	 VmWRHeW/CS/KAVaExDsmK9E6RyWGOTMT8M8fBwyktxp5OGIZHHYiVNdLxbQfqwxxp6
	 sBulQr74FfNjQ7JqwQ2hsYptOcBV6MCEppUFgCFsMIyF5Ll2EzLL9TdQKtZIBnO7zJ
	 W7irL0ZL9NKJuyAlJXLezTQ1LYzzFu++cCFq1iq3SKUP5hsp/XHJVuJDLDI1Vnwyx4
	 T3HnpwW4ZwArXmizxINSiN06iX/1P3o3J1k9yaLrUmE/pgYnFuYRVTdjHaJftv30r7
	 /h3Z5iUBzGMAA==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6639P3SQ02572104
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 17:25:03 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 17:25:02 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Jul 2026 17:25:02 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v4 5/6] r8169: fix RTL8116af can not enter s0idle and c10
Date: Fri, 3 Jul 2026 17:24:58 +0800
Message-ID: <20260703092459.1124-6-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260703092459.1124-1-javen_xu@realsil.com.cn>
References: <20260703092459.1124-1-javen_xu@realsil.com.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304469-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CE397009F8

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

Changes in v3:
 - no changes

Changes in v4:
 - add gate for rtl_lowpower_hidden_functions, only for RTL8116af
---
 drivers/net/ethernet/realtek/r8169_main.c | 57 ++++++++++++++++++-----
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 635131c51db9..0dd805f0d613 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -97,17 +97,20 @@
 #define JUMBO_9K	(9 * SZ_1K - VLAN_ETH_HLEN - ETH_FCS_LEN)
 #define JUMBO_16K	(SZ_16K - VLAN_ETH_HLEN - ETH_FCS_LEN)
 
-#define OCP_SDS_ADDR_REG	0xEB10
-#define OCP_SDS_CMD_REG		0xEB0E
-#define OCP_SDS_DATA_REG	0xEB14
-#define SDS_CMD_READ		0x0001
-#define RTL_SDS_C22_BASE	0x40
-#define RTL_PKG_DETECT		0xdc00
-#define RTL_PKG_DETECT_MASK	0x0078
-#define RTL_PKG_DETECT_8116AF	0x0030
-#define RTL_INT_HW_ID		0xd006
-#define RTL_INT_HW_ID_MASK	0x00ff
-#define RTL_INT_HW_ID_8116AF	0x0000
+#define OCP_SDS_ADDR_REG		0xEB10
+#define OCP_SDS_CMD_REG			0xEB0E
+#define OCP_SDS_DATA_REG		0xEB14
+#define SDS_CMD_READ			0x0001
+#define RTL_SDS_C22_BASE		0x40
+#define RTL_PKG_DETECT			0xdc00
+#define RTL_PKG_DETECT_MASK		0x0078
+#define RTL_PKG_DETECT_8116AF		0x0030
+#define RTL_INT_HW_ID			0xd006
+#define RTL_INT_HW_ID_MASK		0x00ff
+#define RTL_INT_HW_ID_8116AF		0x0000
+#define RTL8116AF_FUNC_PM_CSR		0x80
+#define RTL8116AF_FUNC_EXP_LNKCTL	0x44
+#define RTL_PM_D3HOT			GENMASK(1, 0)
 
 static const struct rtl_chip_info {
 	u32 mask;
@@ -3779,6 +3782,35 @@ static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
 	r8168_mac_ocp_modify(tp, 0xe860, 0x0000, 0x0080);
 }
 
+static void rtl_lowpower_hidden_functions(struct pci_dev *pdev)
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
+			val &= ~PCI_PM_CTRL_PME_STATUS;
+			val &= ~(PCI_PM_CTRL_STATE_MASK | PCI_PM_CTRL_PME_ENABLE);
+			val |= (RTL_PM_D3HOT | PCI_PM_CTRL_PME_ENABLE);
+			pci_bus_write_config_dword(bus, devfn, RTL8116AF_FUNC_PM_CSR, val);
+		}
+
+		ret = pci_bus_read_config_dword(bus, devfn, RTL8116AF_FUNC_EXP_LNKCTL, &val);
+		if (!ret && !PCI_POSSIBLE_ERROR(val)) {
+			val &= ~((PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_LABS) << 16);
+			val |= PCI_EXP_LNKCTL_ASPMC;
+			pci_bus_write_config_dword(bus, devfn, RTL8116AF_FUNC_EXP_LNKCTL, val);
+		}
+	}
+}
+
 static void rtl_hw_start_8117(struct rtl8169_private *tp)
 {
 	static const struct ephy_info e_info_8117[] = {
@@ -3835,6 +3867,9 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
 	r8168_mac_ocp_write(tp, 0xc094, 0x0000);
 	r8168_mac_ocp_write(tp, 0xc09e, 0x0000);
 
+	if (rtl_is_8116af(tp))
+		rtl_lowpower_hidden_functions(tp->pci_dev);
+
 	/* firmware is for MAC only */
 	r8169_apply_firmware(tp);
 }
-- 
2.43.0


