Return-Path: <netdev+bounces-275581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0K+COV+k02m1jwcAu9opvQ
	(envelope-from <netdev+bounces-275581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 14:17:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 825E73A33CD
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 14:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCE2E3015473
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 12:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088BC3358AF;
	Mon,  6 Apr 2026 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="nuLIkick"
X-Original-To: netdev@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6792D97A6
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 12:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775477845; cv=none; b=XjScxOysRVGg6C1S6FYz1oT6Ba/8qSmB6PDhiJ71YotX/aeFKulzmytQWBj+Q5k3LlBaBndd/X/7IeDIpFMzPyhJENZ2dNi76tPhHbZxox7gS2BlGEyXN+JkYxnjcWXmPY04G7yivax/S7QqA2WDNQoAyinxPgeU0jEJvo1jveE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775477845; c=relaxed/simple;
	bh=/WzMW28IjWmZnRlmWMvuoIBeIKjUEIvXVICyjwf8m3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PJ+zSmUMuOXhqDI/NrD0wR/iY2/35kCI5xWKLiDHJgx0L7WorAArUjMK3eqvqCkhkhQ2dGypE7zFznDBdol1aiIxJn3cl+okMR8AF3wNOOss05KQGpWfCiWMcThuiOrv+Ev73U9bkBFEsBHH+xlqCTLDdk669UBf0aPvbSRNs7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=nuLIkick; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id E00AC240101
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 14:17:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1775477841; bh=FvLAg6B4pdIV6SmF5cLammCmoQlQ2eq/da3X4qGi024=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=nuLIkickNqI5bDMLS663F/5GLe8kHlmNx1qFqz4OBpUsC80IiyJYP+ACKiVb9KtgA
	 ecmwRZ6q1Vri7KjvGuEBHXrABIsAIxNg+2qW38F2EZFV4CK1kgUk8i3EpcAJ56XwcO
	 jhcmrC5NKkKZw4dHNvA114qiRiMsIVHVINxVqLbFjoYWFLmC2ix40WW1IjgLKLfQ6A
	 hsFG7MoBR8pdMN3ZFG/FssoBMd88o46q4UwIGzDbLx50r53QdAdlm92rDuDmTjFtEX
	 IL8f0IwJIL7eqUct4gtX1r9A/JshS5bJBFhu9cqfUTRNlO3fHE8kTZRMRF1sf4f31Q
	 HSlQn+v1jSJGg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fq7cb3m9Zz6tvs;
	Mon,  6 Apr 2026 14:17:19 +0200 (CEST)
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
Subject: [PATCH v2] net: sfp: add quirks for GPON ONT SFP sticks
Date: Mon, 06 Apr 2026 12:17:21 +0000
Message-ID: <20260406121716.69854-1-jspavlick@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[posteo.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[posteo.net:s=2017];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,posteo.net,leolabs.pl];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[posteo.net:+];
	TAGGED_FROM(0.00)[bounces-275581-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jspavlick@posteo.net,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 825E73A33CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Several GPON ONT SFP sticks based on Realtek RTL960x report
1000BASE-LX at 1300MBd in their EEPROM but can operate at 2500base-X.
On hosts with serdes fixed at 2.5Gbase-X (e.g. Banana Pi R3 / MT7986),
the kernel rejects them with 'no common interface modes'.

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


