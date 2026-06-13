Return-Path: <netdev+bounces-298893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lvczNqHJLGpuWQQAu9opvQ
	(envelope-from <netdev+bounces-298893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 05:08:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7719A67D962
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 05:08:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298893-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298893-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF6053017E6B
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D00A3A7F41;
	Sat, 13 Jun 2026 03:07:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6F73A6B8D;
	Sat, 13 Jun 2026 03:07:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781320055; cv=none; b=EqZscVgERAk4XQ+lGRSugKcv0UGEi8/t647N1U1ltwNNbdhenxvYfa96oYvrKXNdsFXUrZy6U4srUVdSTm9Hoa62cYsHP9NtH7SZQy9z6LfSFUIo/nXzyAXg3196vib0iyedFwzhtofWIplHtsBaZ+IAtSzp20hyksKIPMXfmG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781320055; c=relaxed/simple;
	bh=wx48HIbY2SsknzDftVqq0zsp760P8dHgoDmf/DwV/W8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ic04KXOdhKeWDCYLlL2ieuEAvQ7rz0j0r0NyzKaNevUaKUjcHBBd83TqlI/g9RfgTFbBrwulbNeeeUTJZPlPFr3Kb5FiHNruSrn1xpm+scYereoRqnfYEDU37unwmEkl1ouaRkZ+FcigS0XiC2VgL0ougWAwx9jaEnUlvzJzloE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wYEiT-000000007kE-31tR;
	Sat, 13 Jun 2026 03:07:25 +0000
Date: Sat, 13 Jun 2026 04:07:23 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v6 3/4] net: dsa: mxl862xx: move API macros to
 mxl862xx-host.h
Message-ID: <914f57931e79cc3932a9f32813465c08d29cf4bf.1781319534.git.daniel@makrotopia.org>
References: <cover.1781319534.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781319534.git.daniel@makrotopia.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[makrotopia.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-298893-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@makrotopia.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7719A67D962

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
v6: no changes
v5: no changes
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

