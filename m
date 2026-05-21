Return-Path: <netdev+bounces-290248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPEeKoyiDmpxAwYAu9opvQ
	(envelope-from <netdev+bounces-290248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:13:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B38859F541
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E9443035304
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 06:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7E0394EAF;
	Thu, 21 May 2026 06:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Avgy8Kdj"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F01367B82
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779343987; cv=none; b=rR/y5xgQMy7eExktMc+HSpl6Y4Y59Vfz83qGAZu0025oivArh0QNHYApAE6HmcxF4/NSJls6blpd3FYpUfcaKg7as0AeghKtUqDTbAngDoppuEXTE0KJUHziJUTw8uC3EObty44xYj1PD/j+TcIXkFjTK3eEMueJRM9LSajFlxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779343987; c=relaxed/simple;
	bh=88Y5nri+OcUKFzuUVBLjul49JnfAs8UVFOYggCbYR7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hJzlYGvaK2++ge/ZxcqKPitbXDTVWmdewW8d4cXI+wFM2C/RbmmTqhsUgiCKQFs0us+ne61MKj3X52D7Q+8wv5HT/039LJ1JEEJDNf9iFi8kYz6AeubDUg32UhexNxp0LwdVh34x2yFwS2glu2bj4PWdAtJ4mAtjCQIDldhLe2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Avgy8Kdj; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 61A2E4E42D17;
	Thu, 21 May 2026 06:13:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 36EFA60718;
	Thu, 21 May 2026 06:13:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F23D3107EA6BA;
	Thu, 21 May 2026 08:12:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779343980; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FC5x+tJvMo1AFUbcQhgQWVn89tnpJgMlVgF5WlY5jzs=;
	b=Avgy8Kdjl8QdELAx5ZpBvhUL4kcvs27x/5cttl7XWJXy3IAES57Fwx8r46LOGoz7ygDdw8
	VxppLEk0iYnGaVTBcp3bX6LWxY1f8zEr5URbH0sa4inw3nGSncGni9yYpfcyXZiY/aEdV/
	w6m5odJWbxQZAGESvnC1+QVQH4J4uawihcx/8NF/CX3azMCIO49v4qjkW4cARYxVp22fv6
	7DtshroRYNi/6WXoph8dQNmHOyN6t2YqL2oK5hYmZKYtv/r5vtMG9IKv1WtvEzwhkYTFs0
	W8/DADTa6d/H1YtAGIl+KU1rK+PzS24Hgkisc8MRkyP5MUABY/fPdc7ysQUbkQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 21 May 2026 08:12:42 +0200
Subject: [PATCH net-next v3 7/8] net: dsa: microchip: call DSA's
 phy_{read/write} to do mdio {read/write}
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-clean-ksz-2nd-series-v3-7-75c38971c19a@bootlin.com>
References: <20260521-clean-ksz-2nd-series-v3-0-75c38971c19a@bootlin.com>
In-Reply-To: <20260521-clean-ksz-2nd-series-v3-0-75c38971c19a@bootlin.com>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290248-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8B38859F541
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index e3f481c32e09..3c09bc8ffaec 100644
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
2.54.0


