Return-Path: <netdev+bounces-289553-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKorCzCgDGq8jwUAu9opvQ
	(envelope-from <netdev+bounces-289553-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:38:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CADF7583326
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7F85305691F
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7634A13BA;
	Tue, 19 May 2026 17:38:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0F22EE262;
	Tue, 19 May 2026 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212306; cv=none; b=aCPMCyKydPfJq1otvP0eEltbAXmst8zcqCYKhVuBH6cy+sAyGsZLP8cHFrT6ZY/3UrAQauYzvnO1LXpBZKIhtBIZgVE0olihF70zXMKM7rp6DOeNwgfOKMjJ5zZQohBByrY9+gOxGD6/AjA1SIcijc/ATJm5gHcpJ/a+PY+LnV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212306; c=relaxed/simple;
	bh=Ya34A5Ega1hjBEMTrDG4nc92eQjfocZ5jMv67Te6ik4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFiC1emB9+oOMC71/Q3doJTNoNFRznbVL8WSyhIWOEy8GFs0w50z6r3FgSmVAuHLPjTGNV7HVqh9Mdic5fflQCthHGzHpif0UQDvcWCrqsDJVpPc6NKX/70yuYX4mbfAVYuYnTFKK6snFv85jLGhTnQY2MfhNw+t/8h94QfsKWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wPOOW-000000001dR-1why;
	Tue, 19 May 2026 17:38:16 +0000
Date: Tue, 19 May 2026 18:38:13 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/5] net: dsa: mxl862xx: store firmware version for
 feature gating
Message-ID: <4b09d71cc8c1b8cc56cf03212f79670b80eb1ce6.1779203863.git.daniel@makrotopia.org>
References: <cover.1779203863.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779203863.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289553-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	DMARC_NA(0.00)[makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:mid,makrotopia.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CADF7583326
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Query the firmware version at init (already done in wait_ready),
cache it in priv->fw_version, and provide MXL862XX_FW_VER_MIN()
for version-gated code paths throughout the driver.

The union mxl862xx_fw_version lays out major/minor/revision so
that the u32 raw field compares with natural version ordering on
both big- and little-endian machines.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mxl862xx/mxl862xx.c |  3 +++
 drivers/net/dsa/mxl862xx/mxl862xx.h | 36 +++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index b60482d93a85..2f22adedfbf6 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -257,6 +257,9 @@ static int mxl862xx_wait_ready(struct dsa_switch *ds)
 			 ver.iv_major, ver.iv_minor,
 			 le16_to_cpu(ver.iv_revision),
 			 le32_to_cpu(ver.iv_build_num));
+		priv->fw_version.major = ver.iv_major;
+		priv->fw_version.minor = ver.iv_minor;
+		priv->fw_version.revision = le16_to_cpu(ver.iv_revision);
 		return 0;
 
 not_ready_yet:
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.h b/drivers/net/dsa/mxl862xx/mxl862xx.h
index 80053ab40e4c..79fd32c4db4e 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.h
@@ -3,6 +3,7 @@
 #ifndef __MXL862XX_H
 #define __MXL862XX_H
 
+#include <asm/byteorder.h>
 #include <linux/mdio.h>
 #include <linux/workqueue.h>
 #include <net/dsa.h>
@@ -241,6 +242,38 @@ struct mxl862xx_port {
 	spinlock_t stats_lock; /* protects stats accumulators */
 };
 
+/**
+ * union mxl862xx_fw_version - firmware version for comparison and display
+ * @major: firmware major version
+ * @minor: firmware minor version
+ * @revision: firmware revision number
+ * @raw: combined u32 for direct >= comparison (major most significant)
+ *
+ * The struct layout places major in the most-significant byte of the
+ * u32 on both big- and little-endian machines, so raw values compare
+ * with the natural major > minor > revision ordering.
+ */
+union mxl862xx_fw_version {
+	struct {
+#if defined(__BIG_ENDIAN)
+		u8 major;
+		u8 minor;
+		u16 revision;
+#elif defined(__LITTLE_ENDIAN)
+		u16 revision;
+		u8 minor;
+		u8 major;
+#endif
+	};
+	u32 raw;
+};
+
+#define MXL862XX_FW_VER(maj, min, rev) \
+	((union mxl862xx_fw_version){ .major = (maj), .minor = (min), \
+				      .revision = (rev) }).raw
+#define MXL862XX_FW_VER_MIN(priv, maj, min, rev) \
+	((priv)->fw_version.raw >= MXL862XX_FW_VER(maj, min, rev))
+
 /* Bit indices for struct mxl862xx_priv::flags */
 #define MXL862XX_FLAG_CRC_ERR		0
 #define MXL862XX_FLAG_WORK_STOPPED	1
@@ -258,6 +291,8 @@ struct mxl862xx_port {
  * @drop_meter:         index of the single shared zero-rate firmware meter
  *                      used to unconditionally drop traffic (used to block
  *                      flooding)
+ * @fw_version:         cached firmware version, populated at probe and
+ *                      compared with MXL862XX_FW_VER_MIN()
  * @ports:              per-port state, indexed by switch port number
  * @bridges:            maps DSA bridge number to firmware bridge ID;
  *                      zero means no firmware bridge allocated for that
@@ -275,6 +310,7 @@ struct mxl862xx_priv {
 	struct work_struct crc_err_work;
 	unsigned long flags;
 	u16 drop_meter;
+	union mxl862xx_fw_version fw_version;
 	struct mxl862xx_port ports[MXL862XX_MAX_PORTS];
 	u16 bridges[MXL862XX_MAX_BRIDGES + 1];
 	u16 evlan_ingress_size;
-- 
2.54.0

