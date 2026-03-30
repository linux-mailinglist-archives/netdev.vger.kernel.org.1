Return-Path: <netdev+bounces-273196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCQeKMd/ymnX9QUAu9opvQ
	(envelope-from <netdev+bounces-273196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:51:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 009FD35C577
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1894303C63A
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7046C3D413D;
	Mon, 30 Mar 2026 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jk9ZJLSj"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4CC238150;
	Mon, 30 Mar 2026 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878171; cv=none; b=XpETNgWxMzKIL4b/B70NVgGz0Mg94PFKgoMoJ0v5dQ3rU43ryeRzH5FCeqgvzDHU7WtDzju1lmfSwChE2Vs0L+VCePRBbcwJDWXyBvKuGsUEwyJEeoj/F23hmGKQ9zUquPlE8+3ItltN3CRxwQi6WxqnrdDeHvWrPaknBD32Anw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878171; c=relaxed/simple;
	bh=6IRIpHIj+N++yiCem11RlYYa0rcQ4NBJhwZvsqPL2WA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LhSA1JC/1n3pQPOicfOILReSh2WDsOQVhDArhqiWQK5VKrFiIARAiTju7unofqk+M1eCSnbXCGQTOT9QrVJ+DMPYs0gu5RuzMYcxg2llp1OjklN3IB1fVVOfAk1Dz+JgKT4Yj6W0656iIYFQr1iN3lU7REi+odyuXAAZTbnIyFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jk9ZJLSj; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774878169; x=1806414169;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6IRIpHIj+N++yiCem11RlYYa0rcQ4NBJhwZvsqPL2WA=;
  b=jk9ZJLSjmlLYCd5+LZpB3CcGd8MV9L0mxw9d+mFBjXsb4vOZ4yrHHgyB
   fjomy57DAVAGrNU/zINlsYa6ALVjCZGXN2WMIllJWWt14xLltn7jrf+B2
   f2Q0nlTtqpbgXsszOhTG6YT2bCdHqdCnthchNkcBPkK4DwyTuh1q2FwB/
   2P/slvaDw9k/SzqDBV215kldFi4+efiV/t4XhHeNv4aI3iVfGmUYxs4sO
   wb+IZXBmAvt44OsFURNMt567BgDakqB1Gz2ihelohMbrV4xkYccHXa5Sa
   hmaZ5ronNON0Wl8wiaH4OsrhljfkrsOMfG6UwBd7sJ6fGlfaZdS4iwKHO
   Q==;
X-CSE-ConnectionGUID: 8rpL+xwkQsmCO/TnwCZ14w==
X-CSE-MsgGUID: XlUhTyqySMC9CJYhTwfLtA==
X-IronPort-AV: E=Sophos;i="6.23,150,1770620400"; 
   d="scan'208";a="222664073"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 06:42:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Mon, 30 Mar 2026 06:42:30 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 30 Mar 2026 06:42:26 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <parthiban.veerasooran@microchip.com>, <piergiorgio.beruto@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <steve.glendinning@shawell.net>,
	<UNGLinuxDriver@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: [PATCH net-next 0/3] Add OATC10 Sleep Wake-up support and LAN867x Rev.D0 handling
Date: Mon, 30 Mar 2026 19:12:19 +0530
Message-ID: <20260330134222.67597-1-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273196-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,shawell.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[parthiban.veerasooran@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	HAS_WP_URI(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,opensig.org:url]
X-Rspamd-Queue-Id: 009FD35C577
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series adds support for 10BASE‑T1S Open Alliance TC10 (OATC10)
Sleep/Wake‑up to the generic Clause 45 PHY layer and integrates it with
the Microchip LAN867x Rev.D0 T1S PHY driver. It also ensures that PHY
suspend is properly invoked from the smsc95xx USB Ethernet driver so that
low‑power states are entered during system suspend.

Patch Summary:

1. add generic OATC10 suspend/resume helpers
   - Add TC10 Sleep/Wake‑up MDIO register definitions
   - Implement genphy_c45_oatc10_suspend() and genphy_c45_oatc10_resume()
   - Cache PLCA configuration in struct phy_device for restore after wake

2. add LAN867x Rev.D0 TC10 suspend and Wake‑on‑PHY support
   - Enable TC10 low‑power entry via generic helpers
   - Restore configuration correctly on resume
   - Add ethtool WoL support using PHY wake‑up pulse (WUP)
   - Mark driver with PHY_ALWAYS_CALL_SUSPEND

3. suspend attached PHY on system suspend
   - Call phy_suspend() before USB suspend
   - Allows TC10‑capable PHYs to enter low‑power state

Testing:

Tested on EVB-LAN8670-USB Rev.D0 with suspend/resume cycles and verified:
  - PLCA configuration is preserved across low-power transitions.
  - Wake-up Pulse triggers proper resume.
  - ethtool WOL operations function as expected.

Reference:
Open Alliance TC10 10BASE-T1S Sleep/Wake-up Specification:
https://opensig.org/wp-content/uploads/2024/01/TC14_TC10_JWG_10BASE-T1S-Sleep-Wake-up-Specification_1.0_final.pdf


Parthiban Veerasooran (3):
  net: phy: phy-c45: add OATC10 Sleep/Wakeup support in 10BASE-T1S PHYs
  net: phy: microchip_t1s: add suspend and WOL support for LAN867x
    Rev.D0
  net: usb: smsc95xx: suspend PHY during USB suspend

 drivers/net/phy/mdio-open-alliance.h | 13 ++++
 drivers/net/phy/microchip_t1s.c      | 67 ++++++++++++++++++++-
 drivers/net/phy/phy-c45.c            | 82 ++++++++++++++++++++++++++
 drivers/net/usb/smsc95xx.c           |  6 ++
 include/linux/phy.h                  | 88 +++++++++++++++-------------
 5 files changed, 211 insertions(+), 45 deletions(-)


base-commit: cf0d9080c6f795bc6be08babbffa29b62c06e9b0
-- 
2.34.1


