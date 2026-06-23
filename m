Return-Path: <netdev+bounces-301298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F1J+AQs/Omrv4gcAu9opvQ
	(envelope-from <netdev+bounces-301298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 10:08:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0796B5274
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 10:08:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="IUrzX1/D";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301298-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301298-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EDFC8302C2A8
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 08:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F853CAE84;
	Tue, 23 Jun 2026 08:05:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89293CA48E
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 08:05:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782201947; cv=none; b=ECU+VrpRq3FK5+jRCJ95h3XMlTS491+V0TDEvw9ZFoMrsDZ11OQET2oO3Jj5rCU6qwDV9O5stLIkQftt5KC+Sl4H1dnWUDDQajmZwLI18xK+vE1fFV6aMUb7EgxdVxwNq1yCe4VzrdhV3vLc52KJrT6TwTaOeJ87rXFOKqVgC18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782201947; c=relaxed/simple;
	bh=963pITVs9Rjb81Ci2uL3NJ/HsVakcZ3k4mlbk16oCok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4G9nBh2hRnC2Svtex3xbtSVvm0bMNHvu0VsjOWmYqYmcKTBxarbC6yKCO9ZFkOqCijLnfDsed5kCurLGxAmvHSdER3JPwpDfKWJ3bMbggGbpYE7xEtW3jFyQ1xeM2NVJHhnUiuNRHIttj9pG+IG/ZLZ3H/GkPXU5jK1rf587+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUrzX1/D; arc=none smtp.client-ip=209.85.221.45
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ef29c5561so2964235f8f.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 01:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782201944; x=1782806744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDgSh5umR4LQMz2jeGs6QRx4dsp/V9xsfSzq9kWYIeg=;
        b=IUrzX1/DEn+G9jGmx8a1V0iY4AVfgUFdxsC0/TbYeuPP0+FMu6YrFI+e8i3kqSm+gY
         Zjp30c8Wx7J7F66f/KB6233i8X0D3W4ZZeBc1aYdDWrF5xPUjwEvPV8xijW4ZYEPfNwF
         0kJ0X9M1lOGSaXXDzeP2UImFgnDr7XC+bNpzI4RHjhW5cf/wIuaRfzac2xB75ORGJ+v4
         iDmDGz/sAZVqTHv7n5+OjkNcNFGhoK5fKof7wRcq8egIvIrN5mSyBNi5z/g/dI/giAhJ
         liGtUBxpUhX6wOXws6KjnuVhF1JNEneT8gIJeYRtSAK/uGtn6Cne4hXCMByuKT5HBzmb
         04bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782201944; x=1782806744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hDgSh5umR4LQMz2jeGs6QRx4dsp/V9xsfSzq9kWYIeg=;
        b=m2fj6E11f+B50BNcnwQKDXSYcJfnVUxuox0cxZtSI7VC6Sr8msedXK3LPFEACPS7Us
         qJbCxsZXUS1ZfQPFitKH7jcEyeGidObHsj2X7loWkxit1+gwqZYxOMbN3pOYQgzMpNF6
         jZ5u5d5w+Ba5/PQ45qsa5hvF1fjj9rEnVr8bDp8cJ2yszCnNvPZVDNsFUJ9wgDblIcy1
         jk7hnMXwCnCpWix/UiFWpa1GGMz00I1YzXB3nI7Fa5LA4NrHqzAMRqaiHFJP7jksiaXm
         WcPr5K8ZeZu/ZxtJ4qm0rRZJ5QEiN+C1yj2s05mag0EaaeUyYZcYQCLftV03/EuVPKpo
         uB+Q==
X-Forwarded-Encrypted: i=1; AHgh+RrLeX0XEKVoDN1XoxPlAjehBNAQOWsUgBVVHj0NTdy6G/oluoNsjeqqJdyVSmJpQ+BZEMSQe70=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGvplvn4n0wik4YxX+BKTk8+R5gDo+rcVthNnxocrYt1WFepC6
	I99XiOwzGGDNIHusCh2aib17NDF7kg6kiFhNvRXq+Ok5Q6WtdvQ9bK/Y
X-Gm-Gg: AfdE7ck/cPim3f81elN+1dGPs9AVHWJ4Y6QdQkZ/s6qzUMpGVkup3Hp7eS6uLX/rLkR
	M9OFaBFdnn5ThPipkqxKMbPl0lJVhlPXhFnAZoly0fDngz5IeXSqlLR8BrYrr9EnozLFtw23yW9
	tzIuVtBpWYDJFtjIoxa/uP9ADkdkkfAqelvZfEc8V/cITQ4h+OkmzkHKI3UeTxQg7G6Bn3Jzfj0
	7xpr/VSJU05/sFuaXGBdXg1fZW2SV68swubR5GdvNAXv805c5fTNaDNNA+ge1Xjlyih5Kh6JKs4
	fv8rDvnFV8/WEGZdCgSfe3KFS4TMFzI7Bx1z2LhYhuKRIkOos0PfRZfKn6J8yIwNVgYQp1PCvLX
	JEV6GXxx1MigIotpzTe5gmdxo78lLE9HEk3tWdOuvm3CKO4OdLB1y0dvgNzkyuYl2pJYWCwoaNh
	T+LzlsMgbWPevDEJF3YOzX0h552j7teMK3zbMD4odXHzF2v5Ke/IpCWQZyHDHjvUsZhsJ/i2oj0
	66rfsw=
X-Received: by 2002:adf:f78f:0:b0:460:70ae:f1af with SMTP id ffacd0b85a97d-46add36e36bmr1861389f8f.27.1782201943954;
        Tue, 23 Jun 2026 01:05:43 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46667221de7sm32486503f8f.33.2026.06.23.01.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 01:05:43 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	maxime.chevallier@bootlin.com,
	bjorn@mork.no,
	olek2@wp.pl,
	kabel@kernel.org,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: [PATCH net-next v3 2/2] net: phy: mdio-i2c: defer RollBall bridge probe to PHY discovery
Date: Tue, 23 Jun 2026 10:05:38 +0200
Message-ID: <20260623080538.7646-3-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260623080538.7646-1-petr.wozniak@gmail.com>
References: <20260623080538.7646-1-petr.wozniak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-301298-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-phy@lists.infradead.org,m:maxime.chevallier@bootlin.com,m:bjorn@mork.no,m:olek2@wp.pl,m:kabel@kernel.org,m:petr.wozniak@gmail.com,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.infradead.org,bootlin.com,mork.no,wp.pl,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,wp.pl:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE0796B5274

commit 8fe125892f40 ("net: phy: sfp: probe for RollBall I2C-to-MDIO
bridge in mdio-i2c") introduced a regression: the RollBall I2C-to-MDIO
bridge is not yet ready to respond to CMD_READ/CMD_DONE cycles when
sfp_sm_add_mdio_bus() runs in SFP_S_INIT.  The 200 ms probe times out,
i2c_mii_probe_rollball() returns -ENODEV, and sfp_sm_add_mdio_bus()
sets mdio_protocol = MDIO_I2C_NONE.  By the time sfp_sm_probe_for_phy()
runs (up to ~17 s later on affected hardware), the bridge is fully
initialized but PHY probing is skipped because the protocol has already
been changed to NONE.

This affects both modules inserted before boot and hotplugged modules on
hardware where bridge initialization exceeds the 200 ms probe window
(confirmed: FLYPRO SFP-10GT-CS-30M with Aquantia AQR113C, hotplugged).

Move the probe from i2c_mii_init_rollball(), called at bus-creation time,
to sfp_sm_probe_for_phy() in sfp.c, where it runs after the SFP state
machine module initialization delays.  Export the probe function as
mdio_i2c_probe_rollball() so sfp.c can call it.

For RTL8261BE-based modules the probe correctly returns -ENODEV at PHY
discovery time, causing sfp_sm_probe_for_phy() to destroy the MDIO bus
and set MDIO_I2C_NONE, eliminating the 5+ minute PHY probe retry loop.

For genuine RollBall modules (e.g. FLYPRO SFP-10GT-CS-30M with Aquantia
AQR113C) the probe now runs after initialization is complete and
correctly returns 0, so PHY detection proceeds normally.

Reported-by: Aleksander Bajkowski <olek2@wp.pl>
Fixes: 8fe125892f40 ("net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in mdio-i2c")
Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
---
v3: regenerated against net-next (v2 failed to apply due to transit
    corruption); fixed block comment style (checkpatch); no functional
    change.
v2: commit message only - generalized scope (Aleksander Bajkowski);
    corrected SM description (Jan Hoffmann); no code change from v1.
v1: initial.
 drivers/net/mdio/mdio-i2c.c   | 15 +++++++++------
 drivers/net/phy/sfp.c         | 22 +++++++++++++---------
 include/linux/mdio/mdio-i2c.h |  1 +
 3 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/net/mdio/mdio-i2c.c b/drivers/net/mdio/mdio-i2c.c
index b88f63234b4e..2a3a418c1369 100644
--- a/drivers/net/mdio/mdio-i2c.c
+++ b/drivers/net/mdio/mdio-i2c.c
@@ -419,7 +419,7 @@ static int i2c_mii_write_rollball(struct mii_bus *bus, int phy_id, int devad,
 	return 0;
 }
 
-static int i2c_mii_probe_rollball(struct i2c_adapter *i2c)
+int mdio_i2c_probe_rollball(struct i2c_adapter *i2c)
 {
 	u8 data_buf[] = { ROLLBALL_DATA_ADDR, 0x01, 0x00, 0x00 };
 	u8 cmd_buf[]  = { ROLLBALL_CMD_ADDR, ROLLBALL_CMD_READ };
@@ -462,9 +462,13 @@ static int i2c_mii_probe_rollball(struct i2c_adapter *i2c)
 
 	return -ENODEV;
 }
+EXPORT_SYMBOL_GPL(mdio_i2c_probe_rollball);
 
 static int i2c_mii_init_rollball(struct i2c_adapter *i2c)
 {
+	/* Send the RollBall unlock password; bridge presence is verified
+	 * later, in sfp_sm_probe_for_phy(), after module initialization.
+	 */
 	struct i2c_msg msg;
 	u8 pw[5];
 	int ret;
@@ -486,7 +490,7 @@ static int i2c_mii_init_rollball(struct i2c_adapter *i2c)
 	if (ret != 1)
 		return -EIO;
 
-	return i2c_mii_probe_rollball(i2c);
+	return 0;
 }
 
 static bool mdio_i2c_check_functionality(struct i2c_adapter *i2c,
@@ -531,10 +535,9 @@ struct mii_bus *mdio_i2c_alloc(struct device *parent, struct i2c_adapter *i2c,
 	case MDIO_I2C_ROLLBALL:
 		ret = i2c_mii_init_rollball(i2c);
 		if (ret < 0) {
-			if (ret != -ENODEV)
-				dev_err(parent,
-					"Cannot initialize RollBall MDIO I2C protocol: %d\n",
-					ret);
+			dev_err(parent,
+				"Cannot initialize RollBall MDIO I2C protocol: %d\n",
+				ret);
 			mdiobus_free(mii);
 			return ERR_PTR(ret);
 		}
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index c4d274ab651e..bbfaa0450798 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -2174,17 +2174,10 @@ static void sfp_sm_fault(struct sfp *sfp, unsigned int next_state, bool warn)
 
 static int sfp_sm_add_mdio_bus(struct sfp *sfp)
 {
-	int ret;
-
 	if (sfp->mdio_protocol == MDIO_I2C_NONE)
 		return 0;
 
-	ret = sfp_i2c_mdiobus_create(sfp);
-	if (ret == -ENODEV) {
-		sfp->mdio_protocol = MDIO_I2C_NONE;
-		return 0;
-	}
-	return ret;
+	return sfp_i2c_mdiobus_create(sfp);
 }
 
 /* Probe a SFP for a PHY device if the module supports copper - the PHY
@@ -2215,7 +2208,18 @@ static int sfp_sm_probe_for_phy(struct sfp *sfp)
 		break;
 
 	case MDIO_I2C_ROLLBALL:
-		err = sfp_sm_probe_phy(sfp, SFP_PHY_ADDR_ROLLBALL, true);
+		/* Probe here, after module initialization delays, so that
+		 * genuine RollBall bridges have had time to start up.
+		 * Modules without a bridge (e.g. RTL8261BE) return -ENODEV.
+		 */
+		err = mdio_i2c_probe_rollball(sfp->i2c);
+		if (err == -ENODEV) {
+			sfp_i2c_mdiobus_destroy(sfp);
+			sfp->mdio_protocol = MDIO_I2C_NONE;
+			break;
+		}
+		if (!err)
+			err = sfp_sm_probe_phy(sfp, SFP_PHY_ADDR_ROLLBALL, true);
 		break;
 	}
 
diff --git a/include/linux/mdio/mdio-i2c.h b/include/linux/mdio/mdio-i2c.h
index 65b550a6fc32..5cf14f45c94b 100644
--- a/include/linux/mdio/mdio-i2c.h
+++ b/include/linux/mdio/mdio-i2c.h
@@ -20,5 +20,6 @@ enum mdio_i2c_proto {
 
 struct mii_bus *mdio_i2c_alloc(struct device *parent, struct i2c_adapter *i2c,
 			       enum mdio_i2c_proto protocol);
+int mdio_i2c_probe_rollball(struct i2c_adapter *i2c);
 
 #endif
-- 
2.51.0


