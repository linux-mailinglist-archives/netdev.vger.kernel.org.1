Return-Path: <netdev+bounces-255076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG8eJ2J2fGmWNAIAu9opvQ
	(envelope-from <netdev+bounces-255076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 10:14:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13609B8C91
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 10:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CD0A301389D
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 09:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C943502B6;
	Fri, 30 Jan 2026 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="itfEkB5W"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8411630DD3A;
	Fri, 30 Jan 2026 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769764437; cv=none; b=VcRJYmhbxqmhqMkn3GrFhSUO8JOffe9BXPmbweg26Wmg5biPxZgMCN6Bc/MiJDq4ms75F1GNQ5mGJ5LNbGDPW1W7xen/kal/r6TKdaFH7O9ohKmJjTw+DArLad3h9JulPrE/LKyvWZQA3ZjN3gzG/qoG4jRD65vi8hBS7Nald+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769764437; c=relaxed/simple;
	bh=F/U8jHO0CBC+k1le1oLJ3ADGRkv4KfRL10OA46PTBPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=f1SSXPAIRbqcK4wNvmaV34OllpI81MpdxD/m3De4MX9w/J95wePOfT0Lg9GejDUR3xhVa3+dixnLKdDLONeV1zgm4Smli+eI8AmHkdfjqe3Z7Rf23Gi6ENZl70CgXnPUR5Lkh/gI4FLtlu6/4ASlN1N1id/fi1803sl9gHwFzXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=itfEkB5W; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1769764436; x=1801300436;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=F/U8jHO0CBC+k1le1oLJ3ADGRkv4KfRL10OA46PTBPo=;
  b=itfEkB5WUp1X5m/wUxhQvvopUZQ4xeZEyp5H8RKUWjOG8/TGBM5DOTeT
   OkidH5HGHccxySMCXm1ZzxfGV1Hu29CGTgnoZRxUK0Nd/YCdKviH4634a
   Wr67UmUOh9hRczpcHM1SMTDvZVG1127yzwkum8bCnwJHBGjeYVRm9rsVV
   rV/EKM0FuFvYi0ZnLeocRuLUv+XUg9CLwlBx5kE4P6pVlqiEOrWGtD/uI
   akgA5X2ptw4nkszH7Q+eEkfXPZ3/7+BqguPV18GlyEK76JxUVvyIHK+u2
   lmZTKByspa8X3iYk0tEyvs2na3qj21LisDSoxL09mwUQwUIc0vFSN3uVP
   Q==;
X-CSE-ConnectionGUID: gRA6Eq8gTayVI/IjMfkg0Q==
X-CSE-MsgGUID: u951SVU/S1yYb3UQJ4qysg==
X-IronPort-AV: E=Sophos;i="6.21,262,1763449200"; 
   d="scan'208";a="284057071"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 02:13:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 30 Jan 2026 02:13:21 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 30 Jan 2026 02:13:19 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Fri, 30 Jan 2026 10:12:50 +0100
Subject: [PATCH net-next v2] net: phy: micrel: Add support for lan9645x
 internal phy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260130-phy_micrel_add_support_for_lan9645x_internal_phy-v2-1-202ac31cf9c4@microchip.com>
X-B4-Tracking: v=1; b=H4sIABF2fGkC/5WOTQ6CMBCFr2JmbQ2tCOjKexjSlDKVSbBt2kogh
 Ltb8QQuX97P91aIGAgj3A4rBJwokrNZiOMB9KDsExn1WYMoRFVwXjI/LPJFOuAoVd/L+PbehSS
 NC3JU9lqVl1mSTRisGmUOswrNVdWN0F3TQZ71AQ3NO/IBFhOzOCdoszNQTC4s+5eJ7/4PK87/Y
 yfOOGvKpuy4uqja9Pdv3emB/Em7F7Tbtn0AGm4dgv4AAAA=
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255076-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13609B8C91
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
Changes in v2:
- Check write errors in lan9645x_config_intr.
- Added more comments for the erratas which are not yet documented in
  the datasheet.
- Change workaround in lan9645x_suspend from ANEG restart and sleep to
  asserting Software Soft Reset and poll for self-clear.
- Return IRQ_NONE when IRQ is not handled in lan9645x_handle_interrupt.
- Link to v1: https://lore.kernel.org/r/20260123-phy_micrel_add_support_for_lan9645x_internal_phy-v1-1-8484b1a5a7fd@microchip.com
---
 drivers/net/phy/micrel.c   | 152 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/micrel_phy.h |   1 +
 2 files changed, 153 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 225d4adf28be..fe77ad899f10 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -6502,6 +6502,142 @@ static void lan8842_get_phy_stats(struct phy_device *phydev,
 	stats->tx_errors = priv->phy_stats.tx_errors;
 }
 
+#define LAN9645X_CONTROL_REGISTER		0x1f
+#define LAN9645X_CONTROL_REGISTER_SOFT_RESET	BIT(1)
+
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
+	/* Tx low I on channel C/D overwrite */
+	{ LAN8814_PAGE_POWER_REGS,
+	  LAN9645X_TX_LOW_I_CH_CD_POWER_MGMT,
+	  0xbfff },
+	/* Channel B low I overwrite */
+	{ LAN8814_PAGE_POWER_REGS,
+	  LAN9645X_TX_LOW_I_CH_B_POWER_MGMT,
+	  0xabbf },
+	/* Channel A low I overwrite */
+	{ LAN8814_PAGE_POWER_REGS,
+	  LAN9645X_TX_LOW_I_CH_A_POWER_MGMT,
+	  0xbd3f },
+};
+
+static int lan9645x_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Apply erratas from previous generations.  */
+	ret = lan8842_erratas(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* Apply errata for an issue where bringing a port down, can cause a few
+	 * CRC errors for traffic flowing through adjacent ports.
+	 */
+	return lanphy_write_reg_data(phydev, force_dac_tx_errata,
+				     ARRAY_SIZE(force_dac_tx_errata));
+}
+
+static int lan9645x_suspend(struct phy_device *phydev)
+{
+	int ret, val;
+
+	/* Force link down before software power down (SPD), by doing software
+	 * soft reset. This resets the PHY, but keeps all register configuration
+	 * intact. The bit self clears.
+	 *
+	 * This is needed as a workaround for an issue where performing SPD on a
+	 * port can bring adjacent ports down, when there is traffic flowing
+	 * through the ports.
+	 */
+	ret = phy_modify(phydev, LAN9645X_CONTROL_REGISTER,
+			 LAN9645X_CONTROL_REGISTER_SOFT_RESET, 1);
+	if (ret)
+		return ret;
+
+	ret = phy_read_poll_timeout(phydev, LAN9645X_CONTROL_REGISTER, val,
+				    !(val & LAN9645X_CONTROL_REGISTER_SOFT_RESET),
+				    3000, 100000, true);
+	if (ret)
+		return ret;
+
+	return genphy_suspend(phydev);
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
+		err = phy_write(phydev, LAN8804_CONTROL,
+				LAN8804_CONTROL_INTR_POLARITY);
+		if (err)
+			return err;
+
+		/* By default interrupt buffer is open-drain in which case the
+		 * interrupt can be active only low. Therefore change the
+		 * interrupt buffer to be push-pull to be able to change
+		 * interrupt polarity.
+		 */
+		err = phy_write(phydev, LAN8804_OUTPUT_CONTROL,
+				LAN8804_OUTPUT_CONTROL_INTR_BUFFER);
+		if (err)
+			return err;
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
+	if (status & (LAN8814_INT_LINK | LAN8814_INT_FLF)) {
+		phy_trigger_machine(phydev);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
 static struct phy_driver ksphy_driver[] = {
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_KS8737),
@@ -6740,6 +6876,21 @@ static struct phy_driver ksphy_driver[] = {
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
@@ -6838,6 +6989,7 @@ static const struct mdio_device_id __maybe_unused micrel_tbl[] = {
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


