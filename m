Return-Path: <netdev+bounces-292993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADihML8nGWoSrQgAu9opvQ
	(envelope-from <netdev+bounces-292993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:44:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 253875FD7CA
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E044A31AD5F0
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 05:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BF33A2540;
	Fri, 29 May 2026 05:40:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E7830BF6B;
	Fri, 29 May 2026 05:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780033217; cv=none; b=U4zPfX2Qi7cFJlmenBNJ63caereW6SLNyJk1lcfypVXT+zPwyWfcEM+IZ07HPVdS+cxpxG8IoU4E3h2en8Zikyybc69nlENoVMja6RAxELjA8i48MSc/41esjzm0pN2pHYgjpxgu8X+FjPo9CkqUoSStkrturhM0USr5Uw5xLrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780033217; c=relaxed/simple;
	bh=LshSK5jZdWAj7jNYFFXTETtUsrkXGvrNBRP/Ky2wr0I=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDUXTQbAkHTBMPmmnwy1Us0amocabvX1uNGZTLtjuBUl5gYHKGG/WMANxL19MXnMlQ+qjofha8rCKdEWU6g+1S0Xkj+fAQLY7NZQ8oOPIK+2gLo8ckEF9MzmvFdludSKBqpHK3YOEU1BKhtkg7jIZrLot/V8IjdLpiiWINiJiko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wSpx6-000000004DK-3C30;
	Fri, 29 May 2026 05:40:12 +0000
Date: Fri, 29 May 2026 06:40:10 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: John Crispin <john@phrozen.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v4 3/4] net: dsa: mxl862xx: move API macros to
 mxl862xx-host.h
Message-ID: <c9f8cadf99a455ec157b4838eaff266dee8e0cf6.1780032869.git.daniel@makrotopia.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292993-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,makrotopia.org:mid,makrotopia.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 253875FD7CA
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
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
v4: no changes
v3: no changes
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

