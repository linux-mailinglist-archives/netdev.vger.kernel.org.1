Return-Path: <netdev+bounces-288245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHhvCAffBmp4ogIAu9opvQ
	(envelope-from <netdev+bounces-288245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:53:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A3154BC51
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0556A30A0E9F
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3017426D24;
	Fri, 15 May 2026 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ryqJmcT6"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D862E402B83
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834347; cv=none; b=ruglT1d6lb3N43oXiiIMgY1c64pBmpaQ+jjcVIRSmbupwD2MlpE+J2PiBMoyCpfpK2VBz2BbsRfHANkS2Bvq3ZsJRGgdU84jdKaLKIQFEF/Qif434zKgaakzOXjtTofZQ6nTj0Z+i+jqJmOfhwG0nClmUNkaR/zLCreL7YCOvSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834347; c=relaxed/simple;
	bh=EOwMc4cnN6mjXx+lNAo0TmGO3icV95F/RHTdgA6irSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sIIlZVDSpSSZ2LDdfSsijX5VuusNoSW2/oYuQZjh7EtAzsVPeO/WRIQqyn10K62alWe5UJXEXrA9emsze3izUjfHyUNShYPw6R7g/kZsbV/4mAywqCwDoySxO0dqUoaEZzMuQ6UaA2RjOh39MFGietvBrM7czwq+1NoBeaqzgRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ryqJmcT6; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5042E1A35DD;
	Fri, 15 May 2026 08:39:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2576C606FD;
	Fri, 15 May 2026 08:39:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0A57C11AF8FCA;
	Fri, 15 May 2026 10:38:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778834342; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NmRmaxENCbzVfYEf7DmKsuBOHPJgb9fR4nlBynu9nU4=;
	b=ryqJmcT6nglwvjv5mhUGB5keB1lD9oi4oEmNW05gMM4teVmc3NyF120t8PjxebJe8Ad0HD
	bKdvH3JnFLnfag4tzYz100wmqwj7JuFwjYt/j2iICjJp741fhmyDNxYzGb6y6/JYIDQ/xz
	MyMZIj8kAGDGhg+DuSQ5UbyZwraa72SW/UL1uOijoFcE3nHl4mVAkWineh+vv2K1438X11
	8dp3exgpbYUo/vGP0LG9j+4nk/uL/ABRWvlEB+l3oMrP2VAL1H9sJjdZJlkhHdXYnpIBMJ
	aOZ9fpjltXNVRHcgyT3dQh0nMxDY+ISP4pkd24rFs3q0p3UbI9cUBnZHJzxnKA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Fri, 15 May 2026 10:38:42 +0200
Subject: [PATCH net-next v2 7/8] net: dsa: microchip: call DSA's
 phy_{read/write} to do mdio {read/write}
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-clean-ksz-2nd-series-v2-7-35a968a739f6@bootlin.com>
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
X-Rspamd-Queue-Id: 72A3154BC51
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288245-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Action: no action

ksz_sw_mdio_read() and ksz_sw_mdio_write() respectively call
ksz_dev_ops::phy_r() and ksz_dev_ops::phy_w() just like
dsa_switch_ops::phy_read() and dsa_switch_ops::phy_write() do.

Call dsa_switch_ops::phy_read() from ksz_sw_mdio_read() and
dsa_switch_ops::phy_write() from ksz_sw_mdio_write() so we'll be able
to get rid of the useless indirections provided by ksz_dev_ops in
upcoming patch.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index f44974cf4e595..0d66592dff703 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2260,22 +2260,18 @@ static void ksz_update_port_member(struct ksz_device *dev, int port)
 static int ksz_sw_mdio_read(struct mii_bus *bus, int addr, int regnum)
 {
 	struct ksz_device *dev = bus->priv;
-	u16 val;
-	int ret;
-
-	ret = dev->dev_ops->r_phy(dev, addr, regnum, &val);
-	if (ret < 0)
-		return ret;
+	struct dsa_switch *ds = dev->ds;
 
-	return val;
+	return ds->ops->phy_read(ds, addr, regnum);
 }
 
 static int ksz_sw_mdio_write(struct mii_bus *bus, int addr, int regnum,
 			     u16 val)
 {
 	struct ksz_device *dev = bus->priv;
+	struct dsa_switch *ds = dev->ds;
 
-	return dev->dev_ops->w_phy(dev, addr, regnum, val);
+	return ds->ops->phy_write(ds, addr, regnum, val);
 }
 
 /**

-- 
2.53.0


