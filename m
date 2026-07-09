Return-Path: <netdev+bounces-306164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Nys5JLV1T2qkhAIAu9opvQ
	(envelope-from <netdev+bounces-306164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:19:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A2D72F822
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:19:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=R4FbmQoq;
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306164-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306164-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A06B3131251
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 10:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970143BE17E;
	Thu,  9 Jul 2026 10:09:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E98408022;
	Thu,  9 Jul 2026 10:09:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591747; cv=none; b=MS1HJ82I57Q/sKQ7m5r/axSXavT+iua9yssnCZrvX3b73xiuvza+83AEISbHnftfZpMZP7YGIT73u6PoomY/ClWqProUPpEb0W2lwuQif6GLYmXX/+qdM/rgaHNCeGkUsNpmTm8bD2R6kx6CIeysn2IRMMiiga1qYfiukJYExxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591747; c=relaxed/simple;
	bh=VseLt84HN9pRMqSfQLuHa2XgUprH4VW97c56Y2Fc5l0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OWmioXaxn8qZ2yQf1yqN+jpUS2s6ciGmA8n/rle8irTaA1ozN4jIrcsTOMBv1p8k0LlVL+Snti8iCLbqS1f3WM4ZB0WljDAEJuI39kK77aGdvsiaAGO9pmjBF9yEBKMxBiKgo407j2Eol1KgUcxdBMa/DTHoJY2MDNY2zeJ2B0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=R4FbmQoq; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 669A2om062982781, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1783591370;
	bh=02qJkGoL3XQfkCurikv7zc6qI6DxSrX7y2ITegEFWvQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=R4FbmQoqCMdXgcP5jArrzv/7s11GIO3a8Qf8b+0e1wvD62ESBaRQ6/r7ddoO6q1F2
	 NuEEGbQd03/FBU9HdzjqQD0fCMOqR6pTVsYIDqTfkWSINPn80SvRmoSB02nNjdfQq2
	 eyHssDwEho2VaH5lqGeuHxHmS29RuyYhtGFSEwRfqRvtNQRU6QhAdWpZOHS0K+p1iW
	 JzdOGCEWYbUftVwkiRIeGcEMChnIv3fR+2Wy+XrLAn+eAY9xau2TTeasPzaK0P5HlD
	 akZBs8D4prIZpL1kLqm97Q7Cd9hoWqxarJ4kPWs834/tTfHJhtDlRoXlxZdhQO8yl1
	 5zSbTN7/KuNcg==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 669A2om062982781
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 9 Jul 2026 18:02:50 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Jul 2026 18:02:50 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 9 Jul 2026 18:02:50 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <linux@armlinux.org.uk>, <enelsonmoore@gmail.com>,
	<daniel@thingy.jp>, Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH net-next v6 7/7] r8169: fix RTL8116af can not enter s0idle and c10
Date: Thu, 9 Jul 2026 18:02:36 +0800
Message-ID: <20260709100237.541-8-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260709100237.541-1-javen_xu@realsil.com.cn>
References: <20260709100237.541-1-javen_xu@realsil.com.cn>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306164-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:linux@armlinux.org.uk,m:enelsonmoore@gmail.com,m:daniel@thingy.jp,m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,makrotopia.org,armlinux.org.uk,gmail.com,thingy.jp,realsil.com.cn];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realsil.com.cn:from_mime,realsil.com.cn:email,realsil.com.cn:mid,realsil.com.cn:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41A2D72F822

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

Changes in v5:
 - no changes

Changes in v6:
 - no changes
---
 drivers/net/ethernet/realtek/r8169_main.c | 42 +++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index c279beb6fdb5..c0b0c2bc5a48 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -3771,6 +3771,42 @@ static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
 	r8168_mac_ocp_modify(tp, 0xe860, 0x0000, 0x0080);
 }
 
+static void rtl_lowpower_hidden_functions(struct pci_dev *pdev)
+{
+	unsigned int slot = PCI_SLOT(pdev->devfn);
+	struct pci_bus *bus = pdev->bus;
+	int func, pos;
+	u16 val;
+
+	for (func = 2; func < 8; func++) {
+		unsigned int devfn = PCI_DEVFN(slot, func);
+
+		pos = pci_bus_find_capability(bus, devfn, PCI_CAP_ID_EXP);
+		if (pos) {
+			pci_bus_read_config_word(bus, devfn, pos + PCI_EXP_LNKCTL, &val);
+
+			if (PCI_POSSIBLE_ERROR(val))
+				continue;
+
+			val |= (PCI_EXP_LNKCTL_ASPMC | PCI_EXP_LNKCTL_CLKREQ_EN);
+			pci_bus_write_config_word(bus, devfn, pos + PCI_EXP_LNKCTL, val);
+		}
+
+		pos = pci_bus_find_capability(bus, devfn, PCI_CAP_ID_PM);
+		if (pos) {
+			pci_bus_read_config_word(bus, devfn, pos + PCI_PM_CTRL, &val);
+
+			if (PCI_POSSIBLE_ERROR(val))
+				continue;
+
+			val &= ~PCI_PM_CTRL_STATE_MASK;
+			val |= PCI_D3hot;
+			val |= PCI_PM_CTRL_PME_STATUS;
+			pci_bus_write_config_word(bus, devfn, pos + PCI_PM_CTRL, val);
+		}
+	}
+}
+
 static void rtl_hw_start_8117(struct rtl8169_private *tp)
 {
 	static const struct ephy_info e_info_8117[] = {
@@ -5326,6 +5362,9 @@ static int rtl8169_resume(struct device *device)
 	/* Some chip versions may truncate packets without this initialization */
 	rtl_init_rxcfg(tp);
 
+	if (rtl_is_8116af(tp))
+		rtl_lowpower_hidden_functions(tp->pci_dev);
+
 	return rtl8169_runtime_resume(device);
 }
 
@@ -6160,6 +6199,9 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		rtl8168_driver_start(tp);
 	}
 
+	if (rtl_is_8116af(tp))
+		rtl_lowpower_hidden_functions(tp->pci_dev);
+
 	if (pci_dev_run_wake(pdev))
 		pm_runtime_put_sync(&pdev->dev);
 
-- 
2.43.0


