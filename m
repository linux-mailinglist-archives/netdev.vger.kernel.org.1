Return-Path: <netdev+bounces-288246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEglA3PdBmp4ogIAu9opvQ
	(envelope-from <netdev+bounces-288246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:46:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B4254BA8F
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BBE0302FADF
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0C3426ED1;
	Fri, 15 May 2026 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nbxgwGPd"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB26042669D;
	Fri, 15 May 2026 08:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834351; cv=none; b=lDpzifGcbnbKrGNAUu8vgRJYF+4INV9n6T/GRx5urBhPxPeLrQbHtzVZsxByKFD2fOUr0zf6sRmw28XSMGvcAHEmGLcMb2DPz2O8CtOJ/K6q0Wr+w4E95yTi7wvp+joobuyre/gKwofr1mVRah7WvTIxe2sgiIuBqqhsehYK6RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834351; c=relaxed/simple;
	bh=WlotFfFm26e+ll06bVwW7NXbn3tqGF41QjD1Gk0Umrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CczsaKpKtWVnBsNIu/PcGRmpdnzk+Rb2HSSkKWDAiSkA3w7KzZPqI28RSc0h2mP0osJkUc27+O2W4X7iGLeG+xbYM+5x0johf+POw9u2cHgxY/xw4vDkDW5VrmYpCXY/1N46/V9/2J1pBPp3PltYbyq4w8NC82NyaqOXyt9hevI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nbxgwGPd; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7C8571A1E92;
	Fri, 15 May 2026 08:39:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4A949606FD;
	Fri, 15 May 2026 08:39:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 577D011AF901E;
	Fri, 15 May 2026 10:39:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778834345; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ek+meJNWtx4HoWXvowMfK7LnKbneqWm3u6A9/CDQGgQ=;
	b=nbxgwGPdoA8c7lOpTOhdNjYz+x3gPGKk/wagvnL3VttPBpcOGdHS4e0DC4us31v6YpSa+w
	IldXHaOfOlQ3viyMdtZ36Tued6oUHVb69z/pqQ4L7rjCLRdF/ssJejNbr7YYLblLco6MZg
	9Fd6alYO+ELp5Mc/dnbi8Xu33U2ctKqKCpp18AQ06iEWoBs7CgSprnE3+Ru3NMvMv0lgio
	hocZBql0G5LTNCoYQn7AAiJ7kOgvYvoknoysqspBORYyXYeKZ1YyRL/ntCacsEk8t50GS/
	yRX3O6075RAR9a2N1vFA7xkh6xmwf0LV7ohnkaZIFKsbQtFVoJj0szLLFI1tpw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Fri, 15 May 2026 10:38:43 +0200
Subject: [PATCH net-next v2 8/8] net: dsa: microchip: bypass dev_ops for
 phy_read()/phy_write()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-clean-ksz-2nd-series-v2-8-35a968a739f6@bootlin.com>
References: <20260515-clean-ksz-2nd-series-v2-0-35a968a739f6@bootlin.com>
In-Reply-To: <20260515-clean-ksz-2nd-series-v2-0-35a968a739f6@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 05B4254BA8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288246-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Action: no action

phy_read() and phy_write() are handled through common functions that
redirect the treatment to ksz_dev_ops callbacks. This layer of
indirection isn't needed since we now have a dsa_switch_ops for each
kind of switch

Remove one indirection layer for KSZ switches, by connecting the
ksz_dev_ops::phy_r() and ksz_dev_ops::phy_w() operations directly to
dsa_switch_ops.
Remove the now unused phy_r()/phy_w() callbacks from ksz_dev_ops.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c         | 68 ++++++++++++++++++++++++++------
 drivers/net/dsa/microchip/ksz9477.c      | 31 +++++++++++++--
 drivers/net/dsa/microchip/ksz_common.c   | 25 ------------
 drivers/net/dsa/microchip/ksz_common.h   |  4 --
 drivers/net/dsa/microchip/lan937x_main.c | 29 ++++++++++----
 5 files changed, 104 insertions(+), 53 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 09968aec65063..0f84b2e7d25d8 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -1057,6 +1057,19 @@ static int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
 	return 0;
 }
 
+static int ksz8_phy_read16(struct dsa_switch *ds, int addr, int reg)
+{
+	struct ksz_device *dev = ds->priv;
+	u16 val = 0xffff;
+	int ret;
+
+	ret = ksz8_r_phy(dev, addr, reg, &val);
+	if (ret)
+		return ret;
+
+	return val;
+}
+
 /**
  * ksz8_w_phy_ctrl - Translates and writes to the SMI interface from a MIIM PHY
  *		     Control register (Reg. 31).
@@ -1266,6 +1279,18 @@ static int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 	return 0;
 }
 
+static int ksz8_phy_write16(struct dsa_switch *ds, int addr, int reg, u16 val)
+{
+	struct ksz_device *dev = ds->priv;
+	int ret;
+
+	ret = ksz8_w_phy(dev, addr, reg, val);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static void ksz8_cfg_port_member(struct ksz_device *dev, int port, u8 member)
 {
 	int offset = P_MIRROR_CTRL;
@@ -2194,6 +2219,19 @@ static int ksz8463_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
 	return 0;
 }
 
+static int ksz8463_phy_read16(struct dsa_switch *ds, int addr, int reg)
+{
+	struct ksz_device *dev = ds->priv;
+	u16 val = 0xffff;
+	int ret;
+
+	ret = ksz8463_r_phy(dev, addr, reg, &val);
+	if (ret)
+		return ret;
+
+	return val;
+}
+
 static int ksz8463_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 {
 	u16 sw_reg = 0;
@@ -2222,6 +2260,18 @@ static int ksz8463_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 	return 0;
 }
 
+static int ksz8463_phy_write16(struct dsa_switch *ds, int addr, int reg, u16 val)
+{
+	struct ksz_device *dev = ds->priv;
+	int ret;
+
+	ret = ksz8463_w_phy(dev, addr, reg, val);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int ksz8_switch_init(struct ksz_device *dev)
 {
 	dev->cpu_port = fls(dev->info->cpu_ports) - 1;
@@ -2330,8 +2380,6 @@ const struct phylink_mac_ops ksz8_phylink_mac_ops = {
 const struct ksz_dev_ops ksz8463_dev_ops = {
 	.get_port_addr = ksz8463_get_port_addr,
 	.cfg_port_member = ksz8_cfg_port_member,
-	.r_phy = ksz8463_r_phy,
-	.w_phy = ksz8463_w_phy,
 	.r_mib_cnt = ksz8_r_mib_cnt,
 	.r_mib_pkt = ksz8_r_mib_pkt,
 	.r_mib_stat64 = ksz88xx_r_mib_stats64,
@@ -2343,8 +2391,6 @@ const struct ksz_dev_ops ksz8463_dev_ops = {
 const struct ksz_dev_ops ksz87xx_dev_ops = {
 	.get_port_addr = ksz8_get_port_addr,
 	.cfg_port_member = ksz8_cfg_port_member,
-	.r_phy = ksz8_r_phy,
-	.w_phy = ksz8_w_phy,
 	.r_mib_cnt = ksz8_r_mib_cnt,
 	.r_mib_pkt = ksz8_r_mib_pkt,
 	.r_mib_stat64 = ksz_r_mib_stats64,
@@ -2359,8 +2405,6 @@ const struct ksz_dev_ops ksz87xx_dev_ops = {
 const struct ksz_dev_ops ksz88xx_dev_ops = {
 	.get_port_addr = ksz8_get_port_addr,
 	.cfg_port_member = ksz8_cfg_port_member,
-	.r_phy = ksz8_r_phy,
-	.w_phy = ksz8_w_phy,
 	.r_mib_cnt = ksz8_r_mib_cnt,
 	.r_mib_pkt = ksz8_r_mib_pkt,
 	.r_mib_stat64 = ksz88xx_r_mib_stats64,
@@ -2378,8 +2422,8 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.get_phy_flags		= ksz_get_phy_flags,
 	.setup			= ksz8_setup,
 	.teardown		= ksz_teardown,
-	.phy_read		= ksz_phy_read16,
-	.phy_write		= ksz_phy_write16,
+	.phy_read		= ksz8463_phy_read16,
+	.phy_write		= ksz8463_phy_write16,
 	.phylink_get_caps	= ksz8_phylink_get_caps,
 	.port_setup		= ksz8_dsa_port_setup,
 	.get_strings		= ksz_get_strings,
@@ -2438,8 +2482,8 @@ const struct dsa_switch_ops ksz87xx_switch_ops = {
 	.get_phy_flags		= ksz_get_phy_flags,
 	.setup			= ksz8_setup,
 	.teardown		= ksz_teardown,
-	.phy_read		= ksz_phy_read16,
-	.phy_write		= ksz_phy_write16,
+	.phy_read		= ksz8_phy_read16,
+	.phy_write		= ksz8_phy_write16,
 	.phylink_get_caps	= ksz8_phylink_get_caps,
 	.port_setup		= ksz8_dsa_port_setup,
 	.get_strings		= ksz_get_strings,
@@ -2498,8 +2542,8 @@ const struct dsa_switch_ops ksz88xx_switch_ops = {
 	.get_phy_flags		= ksz_get_phy_flags,
 	.setup			= ksz8_setup,
 	.teardown		= ksz_teardown,
-	.phy_read		= ksz_phy_read16,
-	.phy_write		= ksz_phy_write16,
+	.phy_read		= ksz8_phy_read16,
+	.phy_write		= ksz8_phy_write16,
 	.phylink_get_caps	= ksz8_phylink_get_caps,
 	.port_setup		= ksz8_dsa_port_setup,
 	.get_strings		= ksz_get_strings,
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index aac7fc478eda8..c1395322e54ba 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -575,6 +575,19 @@ static int ksz9477_r_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 *data)
 	return 0;
 }
 
+static int ksz9477_phy_read16(struct dsa_switch *ds, int addr, int reg)
+{
+	struct ksz_device *dev = ds->priv;
+	u16 val = 0xffff;
+	int ret;
+
+	ret = ksz9477_r_phy(dev, addr, reg, &val);
+	if (ret)
+		return ret;
+
+	return val;
+}
+
 static int ksz9477_w_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 val)
 {
 	u32 mask, val32;
@@ -600,6 +613,18 @@ static int ksz9477_w_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 val)
 	return ksz_prmw32(dev, addr, 0x100 + (reg << 1), mask, val32);
 }
 
+static int ksz9477_phy_write16(struct dsa_switch *ds, int addr, int reg, u16 val)
+{
+	struct ksz_device *dev = ds->priv;
+	int ret;
+
+	ret = ksz9477_w_phy(dev, addr, reg, val);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 void ksz9477_cfg_port_member(struct ksz_device *dev, int port, u8 member)
 {
 	ksz_pwrite32(dev, port, REG_PORT_VLAN_MEMBERSHIP__4, member);
@@ -1912,8 +1937,6 @@ const struct phylink_mac_ops ksz9477_phylink_mac_ops = {
 const struct ksz_dev_ops ksz9477_dev_ops = {
 	.get_port_addr = ksz9477_get_port_addr,
 	.cfg_port_member = ksz9477_cfg_port_member,
-	.r_phy = ksz9477_r_phy,
-	.w_phy = ksz9477_w_phy,
 	.r_mib_cnt = ksz9477_r_mib_cnt,
 	.r_mib_pkt = ksz9477_r_mib_pkt,
 	.r_mib_stat64 = ksz_r_mib_stats64,
@@ -1932,8 +1955,8 @@ const struct dsa_switch_ops ksz9477_switch_ops = {
 	.get_phy_flags		= ksz_get_phy_flags,
 	.setup			= ksz9477_setup,
 	.teardown		= ksz_teardown,
-	.phy_read		= ksz_phy_read16,
-	.phy_write		= ksz_phy_write16,
+	.phy_read		= ksz9477_phy_read16,
+	.phy_write		= ksz9477_phy_write16,
 	.phylink_get_caps	= ksz9477_phylink_get_caps,
 	.port_setup		= ksz9477_dsa_port_setup,
 	.set_ageing_time	= ksz9477_set_ageing_time,
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 0d66592dff703..95aa3ab5b5719 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2838,31 +2838,6 @@ void ksz_init_mib_timer(struct ksz_device *dev)
 	}
 }
 
-int ksz_phy_read16(struct dsa_switch *ds, int addr, int reg)
-{
-	struct ksz_device *dev = ds->priv;
-	u16 val = 0xffff;
-	int ret;
-
-	ret = dev->dev_ops->r_phy(dev, addr, reg, &val);
-	if (ret)
-		return ret;
-
-	return val;
-}
-
-int ksz_phy_write16(struct dsa_switch *ds, int addr, int reg, u16 val)
-{
-	struct ksz_device *dev = ds->priv;
-	int ret;
-
-	ret = dev->dev_ops->w_phy(dev, addr, reg, val);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 u32 ksz_get_phy_flags(struct dsa_switch *ds, int port)
 {
 	struct ksz_device *dev = ds->priv;
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index c66d75347c6cb..b67038cf1bd09 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -398,8 +398,6 @@ struct ksz_dev_ops {
 	 *  - Negative error code on failure (e.g., invalid configuration).
 	 */
 	int (*create_phy_addr_map)(struct ksz_device *dev, bool side_mdio);
-	int (*r_phy)(struct ksz_device *dev, u16 phy, u16 reg, u16 *val);
-	int (*w_phy)(struct ksz_device *dev, u16 phy, u16 reg, u16 val);
 	void (*r_mib_cnt)(struct ksz_device *dev, int port, u16 addr,
 			  u64 *cnt);
 	void (*r_mib_pkt)(struct ksz_device *dev, int port, u16 addr,
@@ -442,8 +440,6 @@ void ksz_switch_macaddr_put(struct dsa_switch *ds);
 void ksz_switch_shutdown(struct ksz_device *dev);
 int ksz_handle_wake_reason(struct ksz_device *dev, int port);
 
-int ksz_phy_read16(struct dsa_switch *ds, int addr, int reg);
-int ksz_phy_write16(struct dsa_switch *ds, int addr, int reg, u16 val);
 u32 ksz_get_phy_flags(struct dsa_switch *ds, int port);
 
 int ksz_sset_count(struct dsa_switch *ds, int port, int sset);
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 690f99da0bfee..536153886f7b8 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -334,14 +334,29 @@ static int lan937x_internal_phy_read(struct ksz_device *dev, int addr, int reg,
 	return ksz_read16(dev, REG_VPHY_IND_DATA__2, val);
 }
 
-static int lan937x_r_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 *data)
+static int lan937x_phy_read16(struct dsa_switch *ds, int addr, int reg)
 {
-	return lan937x_internal_phy_read(dev, addr, reg, data);
+	struct ksz_device *dev = ds->priv;
+	u16 val = 0xffff;
+	int ret;
+
+	ret =  lan937x_internal_phy_read(dev, addr, reg, &val);
+	if (ret)
+		return ret;
+
+	return val;
 }
 
-static int lan937x_w_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 val)
+static int lan937x_phy_write16(struct dsa_switch *ds, int addr, int reg, u16 val)
 {
-	return lan937x_internal_phy_write(dev, addr, reg, val);
+	struct ksz_device *dev = ds->priv;
+	int ret;
+
+	ret = lan937x_internal_phy_write(dev, addr, reg, val);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 static int lan937x_reset_switch(struct ksz_device *dev)
@@ -818,8 +833,6 @@ const struct ksz_dev_ops lan937x_dev_ops = {
 	.cfg_port_member = ksz9477_cfg_port_member,
 	.mdio_bus_preinit = lan937x_mdio_bus_preinit,
 	.create_phy_addr_map = lan937x_create_phy_addr_map,
-	.r_phy = lan937x_r_phy,
-	.w_phy = lan937x_w_phy,
 	.r_mib_cnt = ksz9477_r_mib_cnt,
 	.r_mib_pkt = ksz9477_r_mib_pkt,
 	.r_mib_stat64 = ksz_r_mib_stats64,
@@ -836,8 +849,8 @@ const struct dsa_switch_ops lan937x_switch_ops = {
 	.get_phy_flags		= ksz_get_phy_flags,
 	.setup			= lan937x_setup,
 	.teardown		= ksz_teardown,
-	.phy_read		= ksz_phy_read16,
-	.phy_write		= ksz_phy_write16,
+	.phy_read		= lan937x_phy_read16,
+	.phy_write		= lan937x_phy_write16,
 	.phylink_get_caps	= lan937x_phylink_get_caps,
 	.port_setup		= lan937x_dsa_port_setup,
 	.set_ageing_time	= lan937x_set_ageing_time,

-- 
2.53.0


