Return-Path: <netdev+bounces-221313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DEBB501D0
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68E51898046
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B19D341AA1;
	Tue,  9 Sep 2025 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Nkl1IuZ9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C511322C66
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432770; cv=none; b=doan+h97C8Me1vs//jOut1am2SsDBNGekU55FCQFpLZnJwGN2b8HqOk31cKPIp8L+Px5Xzo0Kj3uj4OR++Nikfifz85pbcBFQvP6G8yYvlReVj0fJBmoYAda9Ccs2c4exE1RtxBP1/G7Awcdi40iJFla3k5qd6kIqBeymZPl6jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432770; c=relaxed/simple;
	bh=qN5YugrROAejwhduFm0qSFC7ZcCixIPgKXVCyKEub3w=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=cZ8ScOAdWonLb7M7LmFGjHep6N2ze3Z4u+fcQF4N8mClm5UqLjtcuEu0hK4o7TcJqWGz2DdvreaIVpnmhOyY4Jb4W+KBhTZngWq4CMO05p33FeUsVOz6gFfcs5JNj0y/I0TcwkSbiwekb3VU/PS46Gn5x4XwET11TK30VNPkfK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Nkl1IuZ9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=f9KGMQc+mq7Y0Qi9UXcYowtcZ2OJDnDijP9lgx/bm24=; b=Nkl1IuZ9IUtBO2qBGrMydRvRgk
	oMt2LgPEQtmG22DWJ4uPOzeXxhlnnuFV9bYMAYNxvtKiE/EBD7Ro2mrVqWPJAckKpiQdVaxK+8qb8
	Q/uDCNzThPrVwVshYhR7hwB73VzTprnQulDp5XA8tcll3oLaKZScdbVtByPkEC65Svt6ffZ4rUjuU
	X6X31AUHV+BUCrT/jALOg9tfBIOtk6nbvbETUfaEULZRwBMLUqO33qoLeC82L+Q4I7TI/ugrSkAbs
	fQ9Wjt55/EGQcPyf8xhUd1wS+EqxE6JLd7EkXAtMMdr+8Kj0wp6DCQ2lUnmHwFokLRSdydRkvvgiF
	zc6wy/1Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51924 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uw0Xl-000000008Pf-0KV7;
	Tue, 09 Sep 2025 16:46:05 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uw0Xk-00000004IOC-1EJd;
	Tue, 09 Sep 2025 16:46:04 +0100
In-Reply-To: <aMBLorDdDmIn1gDP@shell.armlinux.org.uk>
References: <aMBLorDdDmIn1gDP@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 3/4] net: dsa: mv88e6xxx: remove chip->evcap_config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uw0Xk-00000004IOC-1EJd@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 09 Sep 2025 16:46:04 +0100

evcap_config is only read and written in mv88e6352_config_eventcap(),
so it makes little sense to store it in the global chip struct. Make
it a local variable instead.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/chip.h |  1 -
 drivers/net/dsa/mv88e6xxx/ptp.c  | 11 +++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 9beaffb2eb12..2f211e55cb47 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -424,7 +424,6 @@ struct mv88e6xxx_chip {
 	struct ptp_clock_info	ptp_clock_info;
 	struct delayed_work	tai_event_work;
 	struct ptp_pin_desc	pin_config[MV88E6XXX_MAX_GPIO];
-	u16 evcap_config;
 	u16 enable_count;
 
 	/* Current ingress and egress monitor ports */
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index 402328b9349b..37ffa13c0e3e 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -175,17 +175,16 @@ static u64 mv88e6165_ptp_clock_read(struct cyclecounter *cc)
 static int mv88e6352_config_eventcap(struct mv88e6xxx_chip *chip, int event,
 				     int rising)
 {
-	u16 global_config;
+	u16 evap_config;
 	u16 cap_config;
 	int err;
 
-	chip->evcap_config = MV88E6XXX_TAI_CFG_CAP_OVERWRITE |
-			     MV88E6XXX_TAI_CFG_CAP_CTR_START;
+	evcap_config = MV88E6XXX_TAI_CFG_CAP_OVERWRITE |
+		       MV88E6XXX_TAI_CFG_CAP_CTR_START;
 	if (!rising)
-		chip->evcap_config |= MV88E6XXX_TAI_CFG_EVREQ_FALLING;
+		evcap_config |= MV88E6XXX_TAI_CFG_EVREQ_FALLING;
 
-	global_config = chip->evcap_config;
-	err = mv88e6xxx_tai_write(chip, MV88E6XXX_TAI_CFG, global_config);
+	err = mv88e6xxx_tai_write(chip, MV88E6XXX_TAI_CFG, evcap_config);
 	if (err)
 		return err;
 
-- 
2.47.3


