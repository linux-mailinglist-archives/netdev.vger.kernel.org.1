Return-Path: <netdev+bounces-281852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBtiMAay8GnsXQEAu9opvQ
	(envelope-from <netdev+bounces-281852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:11:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AEA48596A
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 452FD315C8DB
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546A443DA39;
	Tue, 28 Apr 2026 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a6Fjp7Av"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E8542EEA2
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381130; cv=none; b=SHWT5hnwKRoAvt4gpINKjpcY+hVyutfDc0hR7Q4xTXqKTN6Qbt5JbtZIBL256GMxomHgsUGarOVeF0eJe3HF7Myh1gZpmMPKJ149xAaeGP2H4psW2BJeV/bgodzococDLczz3l8dSOJTAUuCCCleHlTawmBnmJqUPpTM6eqtw6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381130; c=relaxed/simple;
	bh=mXAUgVrsGmi1Pu/7E2MbcsYLqDHmGZYRZhThUyg1CKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bu4wYjEoxR0brSWr10bAjHKhgWeXI/o2TRDLZmDFq4T1Xlr95skfW40XQt9TJyejHypLR4pcbP8UNL5O7DI56A818fyAn0FU1rhLi1T58r4V2LDzsV3bwrzZNpRDkCnOjIrFP6i/dbeEW9VfqkgCqvzxhSVEi1oJG2DC1vl8IzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a6Fjp7Av; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C3C49C5EF07;
	Tue, 28 Apr 2026 12:59:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 17F23601D0;
	Tue, 28 Apr 2026 12:58:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7E15A10728B55;
	Tue, 28 Apr 2026 14:58:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777381123; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=TpPwl4y9tm8O+ejPdtapeLQ0xFITNwvuZv5Vcb8QVqw=;
	b=a6Fjp7AvaxJYEm6KKsDpL1vPpyQUsPxSw80XqsG+CA8+3g/w3ejWzzvXWquJYhZZWJEHZ1
	QmGLxVqgc4pJb9T8uxK623dXpoRR5B+nQIl+nJqYEbG8n59Rm2tluYcnvPLXFuY7SykG1M
	KVN9l9UC2xAzTYuVFTcgcbp/OLBPmH+vbynN6UDbrX3GVuUMXkR0yusDsxnIuEbbbcISSu
	7LcL4g8GVb5YbT8Bm1Pu1kGmIcDsUXWvNXH71aSdADSbkU1pXBG6a/0IXYudBjhqy3gHKU
	/WCF/2XpRgsfOXGEzfuhfWmanmrXXXeTsFponb1O/gRD/XH83nxL/Fcr/Ci34Q==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Camelia Groza <camelia.groza@nxp.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: aquantia: use ADVERTISE_XNP for extended next page advertising
Date: Tue, 28 Apr 2026 14:58:27 +0200
Message-ID: <20260428125827.238469-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 21AEA48596A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-281852-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,armlinux.org.uk,gmail.com,nxp.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]

When configuring the link parameters in forced mode for the AQR-105, the
Extended Next Page bit gets advertised for Multi-Gigabit modes.

This is done through bit 12 of MDIO_AN_ADVERTISE in MDIO_MMD_AN. This
contains a copy of the MII_ADVERTISE, for which 802.3 defines bit 12 as
the Extended Next Page advertising. This bit used to be marked as
reserved, but a proper define for it was added in :

commit e7a62edd34b1 ("net: phy: qcom: at803x: Use the correct bit to disable extended next page")

Let's use it instead of the ADVERTISE_RESV definition, making the code
more self-documenting.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 41f3676c7f1e..e95d391a6dc2 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -385,15 +385,15 @@ static int aqr105_setup_forced(struct phy_device *phydev)
 			vend |= MDIO_AN_VEND_PROV_1000BASET_HALF;
 		break;
 	case SPEED_2500:
-		adv |= (ADVERTISE_NPAGE | ADVERTISE_RESV);
+		adv |= (ADVERTISE_NPAGE | ADVERTISE_XNP);
 		vend |= MDIO_AN_VEND_PROV_2500BASET_FULL;
 		break;
 	case SPEED_5000:
-		adv |= (ADVERTISE_NPAGE | ADVERTISE_RESV);
+		adv |= (ADVERTISE_NPAGE | ADVERTISE_XNP);
 		vend |= MDIO_AN_VEND_PROV_5000BASET_FULL;
 		break;
 	case SPEED_10000:
-		adv |= (ADVERTISE_NPAGE | ADVERTISE_RESV);
+		adv |= (ADVERTISE_NPAGE | ADVERTISE_XNP);
 		ctrl10 |= MDIO_AN_10GBT_CTRL_ADV10G;
 		break;
 	default:
-- 
2.49.0


