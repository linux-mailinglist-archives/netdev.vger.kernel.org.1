Return-Path: <netdev+bounces-275591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Hp8Bf2z02kdkgcAu9opvQ
	(envelope-from <netdev+bounces-275591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 15:24:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9843A386E
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 15:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39C693011F39
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 13:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F509372B27;
	Mon,  6 Apr 2026 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="GJWcnboR"
X-Original-To: netdev@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B88342CB0
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775481817; cv=none; b=cmrLPW7WxTwgMhmJkFWAzqSut3F25p/HFcLKHF5DAsIS1JTKfgYgkNe/fWclLylK9/BEHmwY+vJDGM8j2v/71nhLskmw5OBqUum1uP1fiPEAma2Vsf2AZLVYgGbKyEBFx+2Tyvn+CI8zLY1SVkkMuapP4vHhTo5QBEyvI1Nq0aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775481817; c=relaxed/simple;
	bh=mXFAs2Coc5oDJXOUB6fDAqftGKxjrriAiqwPPKc6SZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALqs48zDYNUARQLZWmcchE6DRDaFQIaWKAdIG27RFgbfiTreLRv8otbI58zFvVBIeFvWKtdILhQiRb/HGJIzApp++8d+Ve7YmbGhHZ625DF806z4+iGvRbZgYeHzZOGiHoSmD/Ipnr6zcOPfPB997R0pJKZJ1KiZ1ZVsduNf5sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=GJWcnboR; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 62FC6240101
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 15:23:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1775481814; bh=3CvR4mUYf6ZjmJGR7AtlPA2W77YYH5GWBlsX5HVZDK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=GJWcnboRWlVnEpD1zeVyFc5MA5PXQYW9DQxINQp5Ui2/7BBUmaEQ1ffr0BPdb1UCN
	 KJkind03lmAEmzVpMI+ZoNw3tBpjPK9VB0do3fxKWIUd4Q+jQoiYIoAdY8Y8lyuje8
	 Exc/JJVC8ZaTu3I38xM/YsxGof5u8Gb2yyr+5imrelaoB7TGQVOosEed/cjQE9XASC
	 ytolA8DvjEmOOUZHrBM3CExbdW+GoXJPJvj9KLu0TFSuRFRbtgv2FKP64FcScEqcZI
	 x26vLyuoIXMOphgxQb15wGV9sjNLFYSCDzfQQMy1RDGxUO+IoP8CCPGaRjPPp5QcqZ
	 YLmV2R4rhzNTg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fq94w2VBXz9rxD;
	Mon,  6 Apr 2026 15:23:27 +0200 (CEST)
From: John Pavlick <jspavlick@posteo.net>
To: linux@armlinux.org.uk
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Pavlick <jspavlick@posteo.net>,
	Marcin Nita <marcin.nita@leolabs.pl>
Subject: [PATCH v3] net: sfp: add quirks for Hisense and HSGQ GPON ONT SFP modules
Date: Mon, 06 Apr 2026 13:23:33 +0000
Message-ID: <20260406132321.72563-1-jspavlick@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[posteo.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[posteo.net:s=2017];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275591-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,posteo.net,leolabs.pl];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jspavlick@posteo.net,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[posteo.net:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[posteo.net:dkim,posteo.net:email,posteo.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,leolabs.pl:email]
X-Rspamd-Queue-Id: 6A9843A386E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Several GPON ONT SFP sticks based on Realtek RTL960x report
1000BASE-LX at 1300MBd in their EEPROM but can operate at 2500base-X.
On hosts capable of 2500base-X (e.g. Banana Pi R3 / MT7986), the
kernel negotiates only 1G because it trusts the incorrect EEPROM data.

Add quirks for:
- Hisense-Leox LXT-010S-H
- Hisense ZNID-GPON-2311NA
- HSGQ HSGQ-XPON-Stick

Each quirk advertises 2500base-X and ignores TX_FAULT during the
module's ~40s Linux boot time.

Tested on Banana Pi R3 (MT7986) with OpenWrt 25.12.1, confirmed
2.5Gbps link and full throughput with flow offloading.

Suggested-by: Marcin Nita <marcin.nita@leolabs.pl>
Signed-off-by: John Pavlick <jspavlick@posteo.net>
---
Changes in v3:
  - Fix inaccurate commit message: the MT7986 SerDes is not fixed at
    2500base-X; it also supports 1000base-X and SGMII. Corrected to
    state that the kernel negotiates only 1G because it trusts the
    incorrect EEPROM data.
Changes in v2:
  - Add Suggested-by tag for Marcin Nita <marcin.nita@leolabs.pl>, who
    suggested investigating sfp.c quirks as a solution rather than
    attempting to edit the EEPROM data directly on the module.

 drivers/net/phy/sfp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index f1070eb0a0bb..bd970f753beb 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -543,6 +543,22 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK("HUAWEI", "MA5671A", sfp_quirk_2500basex,
 		  sfp_fixup_ignore_tx_fault_and_los),
 
+	// Hisense LXT-010S-H is a GPON ONT SFP (sold as LEOX LXT-010S-H) that
+	// can operate at 2500base-X, but reports 1000BASE-LX / 1300MBd in its
+	// EEPROM
+	SFP_QUIRK("Hisense-Leox", "LXT-010S-H", sfp_quirk_2500basex,
+		  sfp_fixup_ignore_tx_fault),
+
+	// Hisense ZNID-GPON-2311NA can operate at 2500base-X, but reports
+	// 1000BASE-LX / 1300MBd in its EEPROM
+	SFP_QUIRK("Hisense", "ZNID-GPON-2311NA", sfp_quirk_2500basex,
+		  sfp_fixup_ignore_tx_fault),
+
+	// HSGQ HSGQ-XPON-Stick can operate at 2500base-X, but reports
+	// 1000BASE-LX / 1300MBd in its EEPROM
+	SFP_QUIRK("HSGQ", "HSGQ-XPON-Stick", sfp_quirk_2500basex,
+		  sfp_fixup_ignore_tx_fault),
+
 	// Lantech 8330-262D-E and 8330-265D can operate at 2500base-X, but
 	// incorrectly report 2500MBd NRZ in their EEPROM.
 	// Some 8330-265D modules have inverted LOS, while all of them report
-- 
2.53.0


