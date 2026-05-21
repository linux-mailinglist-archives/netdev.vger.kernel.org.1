Return-Path: <netdev+bounces-290223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BKjDblwDmq8+gUAu9opvQ
	(envelope-from <netdev+bounces-290223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:40:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D87A459E2A4
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 04:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87305301F360
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B61377034;
	Thu, 21 May 2026 02:40:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9DE3148C9;
	Thu, 21 May 2026 02:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779331245; cv=none; b=fAiGVwAFieSLp6Q8EJ4O2qz/4S1p/kUgV3rthkzExksAy7LQuiSOg/scKtP7zMNHag/7xfocUZOJN1uje3ifGuF7lIXYYQkrmVRqDrHsnaiNtVYCleIyVNQnR2oif6ItgPwD2HWS1wC2tKO/yymzL6WDa9oZB5FK0h/M2nwNprw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779331245; c=relaxed/simple;
	bh=74+/mhGsubGkzR1Q3/tbIF1S5yRos9UN6wCOqR//nqM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7i2UWRdlvH4RPIfGEkN6eyyRV93IpWjJhZ8U4eBUAb9MP4Ii06eYeHoeaeKNtxXOIYk2H80Zorr8wX/jH2BfwI+dGhbJ7d4p3tAM9+4cmlhbmjr7/4oq0ckf6IuCF8ifUC64uAFvwm70vtm+gXoI8ogNh+HW0RKtUXkaWFNLAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wPtKz-0000000034y-0ZOV;
	Thu, 21 May 2026 02:40:41 +0000
Date: Thu, 21 May 2026 03:40:38 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 3/4] net: dsa: mxl862xx: move API macros to mxl862xx-host.h
Message-ID: <b6682128d4550c6d1591ad27a21866e4d6c5507b.1779330653.git.daniel@makrotopia.org>
References: <cover.1779330653.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779330653.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290223-lists,netdev=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[sto.lore.kernel.org:server fail,makrotopia.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D87A459E2A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move the MXL862XX_API_WRITE, MXL862XX_API_READ and
MXL862XX_API_READ_QUIET convenience macros from mxl862xx.c to
mxl862xx-host.h next to the mxl862xx_api_wrap() prototype they wrap.
This makes them available to other compilation units that include
mxl862xx-host.h, which is needed once the SerDes PCS code in
mxl862xx-phylink.c also calls firmware commands.

No functional change.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: no changes

 drivers/net/dsa/mxl862xx/mxl862xx-host.h | 8 ++++++++
 drivers/net/dsa/mxl862xx/mxl862xx.c      | 7 -------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.h b/drivers/net/dsa/mxl862xx/mxl862xx-host.h
index 84512a30bc18..66d6ae198aff 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-host.h
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.h
@@ -9,6 +9,14 @@ void mxl862xx_host_init(struct mxl862xx_priv *priv);
 void mxl862xx_host_shutdown(struct mxl862xx_priv *priv);
 int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *data, u16 size,
 		      bool read, bool quiet);
+
+#define MXL862XX_API_WRITE(dev, cmd, data) \
+	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), false, false)
+#define MXL862XX_API_READ(dev, cmd, data) \
+	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), true, false)
+#define MXL862XX_API_READ_QUIET(dev, cmd, data) \
+	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), true, true)
+
 int mxl862xx_reset(struct mxl862xx_priv *priv);
 
 #endif /* __MXL862XX_HOST_H */
diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
index a193f3c07d35..0b1a23364eb5 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
@@ -24,13 +24,6 @@
 #include "mxl862xx-host.h"
 #include "mxl862xx-phylink.h"
 
-#define MXL862XX_API_WRITE(dev, cmd, data) \
-	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), false, false)
-#define MXL862XX_API_READ(dev, cmd, data) \
-	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), true, false)
-#define MXL862XX_API_READ_QUIET(dev, cmd, data) \
-	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), true, true)
-
 /* Polling interval for RMON counter accumulation. At 2.5 Gbps with
  * minimum-size (64-byte) frames, a 32-bit packet counter wraps in ~880s.
  * 2s gives a comfortable margin.
-- 
2.54.0

