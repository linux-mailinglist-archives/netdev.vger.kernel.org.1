Return-Path: <netdev+bounces-253885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCOOJI/CeGmltAEAu9opvQ
	(envelope-from <netdev+bounces-253885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:50:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7312951C8
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2A35307FC2A
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F2535CBCA;
	Tue, 27 Jan 2026 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pPFfg3wa"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D1835CB9B
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521357; cv=none; b=FLgaRALTLNV4mR93jceBuIdyN/GGBHS13G9fZJBW8PpSe7XWJ0otG7w1dbGPUnUN/5uKArorqz4movamjM1ILy74ldeEza2O4Wm+llVGaJt8cBcVhSp3Unuuvd7/CAERTTNR+znipwvT39D20KyLozxikQTBs6X5a3YoRscxYGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521357; c=relaxed/simple;
	bh=AxbRNSV+MGlIrdbZNQx3WZxbKnpHL7fzSnW3Fnkk3g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDOuP3angEClCw6VH44te84hROIjpHwA+PQsSDWu55qCzAf0riMjelp89fPJjvXVRE2Me28oWpiN1Y3rRJ3y/vcc/h8KL3yaBqA8odk2yw8aQGNc7ZHKLohg6vYDwoeyfbQhfhfE+AcA0ALkvgQuvGklOsJ8cIP2EPwndfLMz7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pPFfg3wa; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3CE29C211C0;
	Tue, 27 Jan 2026 13:42:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2A487606F5;
	Tue, 27 Jan 2026 13:42:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D785119A8687;
	Tue, 27 Jan 2026 14:42:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769521353; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=8lrGzf6PbbtMSnb6kURa7INkbEyB0GSQ5wN3CCFsZEA=;
	b=pPFfg3wa6azN6ydEt7rt0orYcnE9rBJszS/eId6K5h3KKdmLdOFsrt6PljzOitrNn8v5y3
	wgv6MLRbICCPQCTjAVhDzWcB1jX1NFJgM9YMnOqKvuxd9VdH2O1wxQwlQOP1MdAHYEhqt3
	Pe5XZo1JAEeTW9fSLnlDwjNswpiCiiP8H9LTUik8f4E4KGJi8YEth8K4I+0VzWoOMaDORN
	Vsu7yN6rJVeQNnAu4M8qAetSaq+0j8JT8XrOSEk4rfygSrxNLZT/dyAU/g2PmbyMiKB7Vp
	18DeULMwdtT+uBIe2pZu9IpUP7uqAuHwfuSQqZ5Uv8usDobqx3k2cfsUccvbOQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: [PATCH net-next 06/13] net: sfp: Add a sfp-bus ops when connecting a module without PHY
Date: Tue, 27 Jan 2026 14:41:54 +0100
Message-ID: <20260127134202.8208-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
References: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-253885-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: E7312951C8
X-Rspamd-Action: no action

The SFP bus infrastructure notifies its upstream when a PHY device was
discovered on the module. However, we don't have any indication when a
module with no PHY was inserted, except for the .insert() and .start()
notifications.

We want to keep track of the SFP module's capabilities using phy_port.
When the module contains an embedded PHY, the PHY driver will expose a
phy_port for it. However when there's no PHY, we have no hook to
populate the phy_port, so let's introduce one. It is called when we
have parsed the module's caps, applied the fixups, tried and failed to
probe for a PHY.

This will allow the bus' upstream to create the corresponding port, and
register it to the topology.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/sfp-bus.c | 20 ++++++++++++++++++++
 drivers/net/phy/sfp.c     | 12 ++++++++++++
 drivers/net/phy/sfp.h     |  2 ++
 include/linux/sfp.h       |  5 +++++
 4 files changed, 39 insertions(+)

diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index b945d75966d5..a3d9e28badd0 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -753,6 +753,26 @@ void sfp_remove_phy(struct sfp_bus *bus)
 }
 EXPORT_SYMBOL_GPL(sfp_remove_phy);
 
+int sfp_module_connect_nophy(struct sfp_bus *bus)
+{
+	const struct sfp_upstream_ops *ops = sfp_get_upstream_ops(bus);
+
+	if (ops && ops->connect_nophy)
+		return ops->connect_nophy(bus->upstream);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sfp_module_connect_nophy);
+
+void sfp_module_disconnect_nophy(struct sfp_bus *bus)
+{
+	const struct sfp_upstream_ops *ops = sfp_get_upstream_ops(bus);
+
+	if (ops && ops->disconnect_nophy)
+		ops->disconnect_nophy(bus->upstream);
+}
+EXPORT_SYMBOL_GPL(sfp_module_disconnect_nophy);
+
 void sfp_link_up(struct sfp_bus *bus)
 {
 	const struct sfp_upstream_ops *ops = sfp_get_upstream_ops(bus);
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 47f095bd91ce..0f6357a98787 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -1875,6 +1875,8 @@ static void sfp_sm_mod_next(struct sfp *sfp, unsigned int state,
 
 static void sfp_sm_phy_detach(struct sfp *sfp)
 {
+	if (!sfp->mod_phy)
+		sfp_module_disconnect_nophy(sfp->sfp_bus);
 	sfp_remove_phy(sfp->sfp_bus);
 	phy_device_remove(sfp->mod_phy);
 	phy_device_free(sfp->mod_phy);
@@ -1918,6 +1920,11 @@ static int sfp_sm_probe_phy(struct sfp *sfp, int addr, bool is_c45)
 	return 0;
 }
 
+static int sfp_sm_connect_nophy(struct sfp *sfp)
+{
+	return sfp_module_connect_nophy(sfp->sfp_bus);
+}
+
 static void sfp_sm_link_up(struct sfp *sfp)
 {
 	sfp_link_up(sfp->sfp_bus);
@@ -2749,6 +2756,11 @@ static void sfp_sm_main(struct sfp *sfp, unsigned int event)
 			sfp_sm_next(sfp, SFP_S_FAIL, 0);
 			break;
 		}
+		if (!sfp->mod_phy) {
+			ret = sfp_sm_connect_nophy(sfp);
+			if (ret)
+				sfp_sm_next(sfp, SFP_S_FAIL, 0);
+		}
 		if (sfp_module_start(sfp->sfp_bus)) {
 			sfp_sm_next(sfp, SFP_S_FAIL, 0);
 			break;
diff --git a/drivers/net/phy/sfp.h b/drivers/net/phy/sfp.h
index 879dff7afe6a..02f3814aac84 100644
--- a/drivers/net/phy/sfp.h
+++ b/drivers/net/phy/sfp.h
@@ -37,6 +37,8 @@ int sfp_module_insert(struct sfp_bus *bus, const struct sfp_eeprom_id *id,
 void sfp_module_remove(struct sfp_bus *bus);
 int sfp_module_start(struct sfp_bus *bus);
 void sfp_module_stop(struct sfp_bus *bus);
+int sfp_module_connect_nophy(struct sfp_bus *bus);
+void sfp_module_disconnect_nophy(struct sfp_bus *bus);
 struct sfp_bus *sfp_register_socket(struct device *dev, struct sfp *sfp,
 				    const struct sfp_socket_ops *ops);
 void sfp_unregister_socket(struct sfp_bus *bus);
diff --git a/include/linux/sfp.h b/include/linux/sfp.h
index 5c71945a5e4d..20c9f66c1080 100644
--- a/include/linux/sfp.h
+++ b/include/linux/sfp.h
@@ -561,6 +561,9 @@ struct sfp_module_caps {
  *   on the module.
  * @disconnect_phy: called when a module with an I2C accessible PHY has
  *   been removed.
+ * @connect_nophy: called when it was established that the connected module
+ *		   doesn't habe an I2C accessible.
+ * @disconnect_nophy: called when the PHY-less module has been removed.
  */
 struct sfp_upstream_ops {
 	void (*attach)(void *priv, struct sfp_bus *bus);
@@ -573,6 +576,8 @@ struct sfp_upstream_ops {
 	void (*link_up)(void *priv);
 	int (*connect_phy)(void *priv, struct phy_device *);
 	void (*disconnect_phy)(void *priv, struct phy_device *);
+	int (*connect_nophy)(void *priv);
+	void (*disconnect_nophy)(void *priv);
 };
 
 #if IS_ENABLED(CONFIG_SFP)
-- 
2.49.0


