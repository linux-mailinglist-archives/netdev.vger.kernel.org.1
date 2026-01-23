Return-Path: <netdev+bounces-252671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL2RJKIoc2k7swAAu9opvQ
	(envelope-from <netdev+bounces-252671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:52:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB0B72031
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F49B3001CE4
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D053161B8;
	Fri, 23 Jan 2026 07:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WqCYimpU"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8BC274B55;
	Fri, 23 Jan 2026 07:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769154714; cv=none; b=Hv+KDTVHgxScrNmsdrltUL4uZaUFLM3uQoH7q5uONdb4LWjSuEiqBSyTnnbUZELi/DZn6kyx0BGx90vh/eTe/tfMiskYViHAkxOm+8TMVK4rAml5ErZ5m1zlaTrM+Q845YxNq3jtH0o4Ffh9hizigFrwHKkmC5GwnQzJ9/Y3ARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769154714; c=relaxed/simple;
	bh=MdA6iJwFmIFC8a4I6IHZYMTyRpmo6BX+agXIgSpsj8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=jmdjOG7/OXhTRDQlgDFjN9ew3aE223ORMy6gjWNAF3JldZySK5hz3L0qdfh8BbXPJ4ccNJHeJ9eE+27wItefH6hVpxVH+1Ww51oue81VuhydKgQWFFwJLpWqziz5OEw4riVO2JQ427ZRKC2D4PUnheVBuwquFWUdeAaLRfRfkVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WqCYimpU; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1769154713; x=1800690713;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=MdA6iJwFmIFC8a4I6IHZYMTyRpmo6BX+agXIgSpsj8c=;
  b=WqCYimpUK/yZ7/ilYVA9Q5UNIku+rmzKvoDpsn2JWrGKx6xtHWOc1qat
   gorUMht1+cQ58ji35LzIIZ5S83gaklLlTymaBbG1Xrh77rkvvXaUAKZqv
   CpUhQ6QPEfByqkZrTqMhc6CA7Z9fWGJ2bUEdJZXV3Kw+TO4F40vTkZr3q
   G6Q7qJ77PJsn8DoeqEM3igwSG5Fg8JangizTgcJQGqOgEJDrVU66vNusA
   5hm/EetKKVVKj32Np6Kvq4ZNjaKMHtYMcHIANkdcxG4OxaGiF31uRx/z9
   0ktynv0hL/n2yAUOWfqp9EOhAdSKdIHCKfQaWGr9bBr2YBRaH/wAp+5x5
   w==;
X-CSE-ConnectionGUID: 0TYwbpQITKqEsN74sP9Wsg==
X-CSE-MsgGUID: hzC8qGJJTUWLK23FlJCWhw==
X-IronPort-AV: E=Sophos;i="6.21,248,1763449200"; 
   d="scan'208";a="283704035"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2026 00:51:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 23 Jan 2026 00:51:37 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 23 Jan 2026 00:51:35 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Fri, 23 Jan 2026 08:50:55 +0100
Subject: [PATCH net-next] net: phy: micrel: Add support for lan9645x
 internal phy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260123-phy_micrel_add_support_for_lan9645x_internal_phy-v1-1-8484b1a5a7fd@microchip.com>
X-B4-Tracking: v=1; b=H4sIAF4oc2kC/x2N0QqDMAwAf0XyvIKKc7pfGRKqjTPQxZJ2o0P89
 5U9Hhx3B0RSpgj36gClD0fepUBzqWDZrDzJsCsMbd32ddN0JmxffPGi5NE6h/Edwq4J113RWxn
 77pqRJZGK9Vhk09M62tvQLvMwQ8kGpZXzf/kAoWSEcoLpPH9xs1SqjAAAAA==
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, <o.rempel@pengutronix.de>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Daniel Machon <daniel.machon@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252671-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,microchip.com:email,microchip.com:dkim,microchip.com:mid]
X-Rspamd-Queue-Id: 9DB0B72031
X-Rspamd-Action: no action

LAN9645X is a family of switch chips with 5 internal copper phys. The
internal PHY is based on parts of LAN8832. This is a low-power, single
port triple-speed (10BASE-T/100BASE-TX/1000BASE-T) ethernet physical
layer transceiver (PHY) that supports transmission and reception of data
on standard CAT-5, as well as CAT-5e and CAT-6 Unshielded Twisted
Pair (UTP) cables.

Add support for the internal PHY of the lan9645x chip family.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
 drivers/net/phy/micrel.c   | 142 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/micrel_phy.h |   1 +
 2 files changed, 143 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 225d4adf28be..7f47f7987067 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -6502,6 +6502,132 @@ static void lan8842_get_phy_stats(struct phy_device *phydev,
 	stats->tx_errors = priv->phy_stats.tx_errors;
 }
 
+#define LAN9645X_DAC_ICAS_AMP_POWER_DOWN	0x47
+#define LAN9645X_BTRX_QBIAS_POWER_DOWN		0x46
+#define LAN9645X_TX_LOW_I_CH_CD_POWER_MGMT	0x45
+#define LAN9645X_TX_LOW_I_CH_B_POWER_MGMT	0x44
+#define LAN9645X_TX_LOW_I_CH_A_POWER_MGMT	0x43
+
+static const struct lanphy_reg_data force_dac_tx_errata[] = {
+	/* Force channel A/B/C/D TX on */
+	{ LAN8814_PAGE_POWER_REGS,
+	  LAN9645X_DAC_ICAS_AMP_POWER_DOWN,
+	  0 },
+	/* Force channel A/B/C/D QBias on */
+	{ LAN8814_PAGE_POWER_REGS,
+	  LAN9645X_BTRX_QBIAS_POWER_DOWN,
+	  0xaa },
+	/* tx low I on channel C/D overwrite */
+	{ LAN8814_PAGE_POWER_REGS,
+	  LAN9645X_TX_LOW_I_CH_CD_POWER_MGMT,
+	  0xbfff },
+	/* channel B low I overwrite */
+	{ LAN8814_PAGE_POWER_REGS,
+	  LAN9645X_TX_LOW_I_CH_B_POWER_MGMT,
+	  0xabbf },
+	/* channel A low I overwrite */
+	{ LAN8814_PAGE_POWER_REGS,
+	  LAN9645X_TX_LOW_I_CH_A_POWER_MGMT,
+	  0xbd3f },
+};
+
+static int lan9645x_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Apply erratas. */
+	ret = lan8842_erratas(phydev);
+	if (ret < 0)
+		return ret;
+
+	return lanphy_write_reg_data(phydev, force_dac_tx_errata,
+				     ARRAY_SIZE(force_dac_tx_errata));
+}
+
+static int lan9645x_suspend(struct phy_device *phydev)
+{
+	int aneg_en_state, ret;
+
+	/* Software workaround from design to handle SPD. SPD will stop AFE
+	 * clock from AFE port, which makes the system MAC fifo unable to flush.
+	 * The workaround is to restart ANEG and wait for flush, before issuing
+	 * software power down.
+	 */
+	aneg_en_state = phy_read(phydev, MII_BMCR) & BMCR_ANENABLE;
+
+	ret = phy_restart_aneg(phydev);
+	if (ret)
+		return ret;
+
+	/* Allow time for system FIFO flush data */
+	usleep_range(8 * USEC_PER_MSEC, 12 * USEC_PER_MSEC);
+
+	ret = genphy_suspend(phydev);
+	if (ret)
+		return ret;
+
+	if (!aneg_en_state)
+		return phy_modify(phydev, MII_BMCR, BMCR_ANENABLE, 0);
+
+	return 0;
+}
+
+static int lan9645x_config_intr(struct phy_device *phydev)
+{
+	int err;
+
+	/* enable / disable interrupts */
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		/* This is an internal PHY of lan9645x and is not possible to
+		 * change the polarity of irq sources in the OIC (CPU_INTR)
+		 * found in lan9645x. Therefore change the polarity of the
+		 * interrupt in the PHY from being active low instead of active
+		 * high.
+		 */
+		phy_write(phydev, LAN8804_CONTROL,
+			  LAN8804_CONTROL_INTR_POLARITY);
+
+		/* By default interrupt buffer is open-drain in which case the
+		 * interrupt can be active only low. Therefore change the
+		 * interrupt buffer to be push-pull to be able to change
+		 * interrupt polarity.
+		 */
+		phy_write(phydev, LAN8804_OUTPUT_CONTROL,
+			  LAN8804_OUTPUT_CONTROL_INTR_BUFFER);
+
+		err = lan8814_ack_interrupt(phydev);
+		if (err)
+			return err;
+
+		err = phy_write(phydev, LAN8814_INTC,
+				LAN8814_INT_LINK | LAN8814_INT_FLF);
+	} else {
+		err = phy_write(phydev, LAN8814_INTC, 0);
+		if (err)
+			return err;
+
+		err = lan8814_ack_interrupt(phydev);
+	}
+
+	return err;
+}
+
+static irqreturn_t lan9645x_handle_interrupt(struct phy_device *phydev)
+{
+	int status;
+
+	status = phy_read(phydev, LAN8814_INTS);
+	if (status < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	if (status & (LAN8814_INT_LINK | LAN8814_INT_FLF))
+		phy_trigger_machine(phydev);
+
+	return IRQ_HANDLED;
+}
+
 static struct phy_driver ksphy_driver[] = {
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_KS8737),
@@ -6740,6 +6866,21 @@ static struct phy_driver ksphy_driver[] = {
 	.set_tunable	= lan8842_set_tunable,
 	.cable_test_start	= lan8814_cable_test_start,
 	.cable_test_get_status	= ksz886x_cable_test_get_status,
+}, {
+	PHY_ID_MATCH_MODEL(PHY_ID_LAN9645X),
+	.name		= "Microchip LAN9645X Gigabit PHY",
+	.config_init	= lan9645x_config_init,
+	.driver_data	= &ksz9021_type,
+	.probe		= kszphy_probe,
+	.soft_reset	= genphy_soft_reset,
+	.suspend	= lan9645x_suspend,
+	.resume		= genphy_resume,
+	.config_intr	= lan9645x_config_intr,
+	.handle_interrupt = lan9645x_handle_interrupt,
+	.get_tunable	= lan8842_get_tunable,
+	.set_tunable	= lan8842_set_tunable,
+	.get_phy_stats	= lan8842_get_phy_stats,
+	.update_stats	= lan8842_update_stats,
 }, {
 	PHY_ID_MATCH_MODEL(PHY_ID_KSZ9131),
 	.name		= "Microchip KSZ9131 Gigabit PHY",
@@ -6838,6 +6979,7 @@ static const struct mdio_device_id __maybe_unused micrel_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN8804) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN8841) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN8842) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN9645X) },
 	{ }
 };
 
diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
index ca691641788b..9c6f9817383f 100644
--- a/include/linux/micrel_phy.h
+++ b/include/linux/micrel_phy.h
@@ -33,6 +33,7 @@
 #define PHY_ID_LAN8804		0x00221670
 #define PHY_ID_LAN8841		0x00221650
 #define PHY_ID_LAN8842		0x002216C0
+#define PHY_ID_LAN9645X		0x002216D0
 
 #define PHY_ID_KSZ886X		0x00221430
 #define PHY_ID_KSZ8863		0x00221435

---
base-commit: cbe8e6bef6a3b4b895b47ea56f5952f1936aacb6
change-id: 20260114-phy_micrel_add_support_for_lan9645x_internal_phy-6ef9a782cb8b

Best regards,
-- 
Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>


