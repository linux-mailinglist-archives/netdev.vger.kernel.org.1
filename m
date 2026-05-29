Return-Path: <netdev+bounces-292991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKXgDEgnGWoSrQgAu9opvQ
	(envelope-from <netdev+bounces-292991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:42:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B43A5FD78C
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C20C730EB023
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 05:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9887939FCC4;
	Fri, 29 May 2026 05:40:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341033A16AB;
	Fri, 29 May 2026 05:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780033204; cv=none; b=Z/tJQzinj8MXeT0x5h55CM9bomRxtbsDqsCNs8dkDqMuKzk1WsMEEuZyoChug8N9J2DixTMEQ1EhsPUecc5ikpsDQ1bkw2COIy4apDgZZMhdlN96zSPi5xn7Ho1JSFJJu1jCBqFcNygEhf44RxW0q00Kcjxd2O+hqoFP4nAOtv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780033204; c=relaxed/simple;
	bh=u+E5pemDD3VOKY+ED2QU0YCu+rrKByOaaaeqWiUIYIw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5PUuBvDqXK8G//sfdWxJXZE7aZsYTyAIfomWfXUB2UkWxzQ93DP5K5tzOWa3eU48OwQ/oPJvAJrdXh68stfduHcVwD/BpfMtNmj115c8hyAVAkxZM1RINvPcm7/0yapVxeuRO65ogVJzLngxztUSKxK7j/BCWhNGempq6O6N4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wSpws-000000004Cm-1Bas;
	Fri, 29 May 2026 05:39:58 +0000
Date: Fri, 29 May 2026 06:39:55 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: John Crispin <john@phrozen.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v4 1/4] net: dsa: mxl862xx: store firmware version
 for feature gating
Message-ID: <d4aa5a0116e2b3847d2b24fb42435812c5dfcc7b.1780032869.git.daniel@makrotopia.org>
References: <cover.1780032869.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1780032869.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292991-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[phrozen.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:mid,makrotopia.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8B43A5FD78C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Query the firmware version at init (already done in wait_ready),
cache it in priv->fw_version, and provide MXL862XX_FW_VER_MIN()
for version-gated code paths throughout the driver.

MXL862XX_FW_VER() packs major/minor/revision into a u32 with
bitwise shifts so that versions compare with natural ordering,
independent of host endianness.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v4: no changes
v3: use bitwise shifts in macro instead of endian-specific union
v2: no changes

 drivers/net/dsa/mxl862xx/mxl862xx.c |  3 +++
 drivers/net/dsa/mxl862xx/mxl862xx.h | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+)

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
index 80053ab40e4c..e3db3711b245 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.h
@@ -3,6 +3,7 @@
 #ifndef __MXL862XX_H
 #define __MXL862XX_H
 
+#include <asm/byteorder.h>
 #include <linux/mdio.h>
 #include <linux/workqueue.h>
 #include <net/dsa.h>
@@ -241,6 +242,25 @@ struct mxl862xx_port {
 	spinlock_t stats_lock; /* protects stats accumulators */
 };
 
+/**
+ * struct mxl862xx_fw_version - firmware version for comparison and display
+ * @major: firmware major version
+ * @minor: firmware minor version
+ * @revision: firmware revision number
+ */
+struct mxl862xx_fw_version {
+	u8 major;
+	u8 minor;
+	u16 revision;
+};
+
+#define MXL862XX_FW_VER(maj, min, rev) \
+	(((u32)(maj) << 24) | ((u32)(min) << 16) | (rev))
+#define MXL862XX_FW_VER_MIN(priv, maj, min, rev) \
+	(MXL862XX_FW_VER((priv)->fw_version.major, (priv)->fw_version.minor, \
+			 (priv)->fw_version.revision) >= \
+	 MXL862XX_FW_VER(maj, min, rev))
+
 /* Bit indices for struct mxl862xx_priv::flags */
 #define MXL862XX_FLAG_CRC_ERR		0
 #define MXL862XX_FLAG_WORK_STOPPED	1
@@ -258,6 +278,8 @@ struct mxl862xx_port {
  * @drop_meter:         index of the single shared zero-rate firmware meter
  *                      used to unconditionally drop traffic (used to block
  *                      flooding)
+ * @fw_version:         cached firmware version, populated at probe and
+ *                      compared with MXL862XX_FW_VER_MIN()
  * @ports:              per-port state, indexed by switch port number
  * @bridges:            maps DSA bridge number to firmware bridge ID;
  *                      zero means no firmware bridge allocated for that
@@ -275,6 +297,7 @@ struct mxl862xx_priv {
 	struct work_struct crc_err_work;
 	unsigned long flags;
 	u16 drop_meter;
+	struct mxl862xx_fw_version fw_version;
 	struct mxl862xx_port ports[MXL862XX_MAX_PORTS];
 	u16 bridges[MXL862XX_MAX_BRIDGES + 1];
 	u16 evlan_ingress_size;
-- 
2.54.0

