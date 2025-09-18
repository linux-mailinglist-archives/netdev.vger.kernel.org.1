Return-Path: <netdev+bounces-224565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5126B8646D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B990D3B2D5E
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10652F7ADC;
	Thu, 18 Sep 2025 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="P/YYGBkz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92F431B809
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217180; cv=none; b=Pb1P8Mphp9Psj2OQGSMGpiONuW/wOZIbOmiXwvt+4u4UHga/1OHRFq3rM40ieKJwCifLEDfe5kpBQQ+7If0KglC6Feik/NhReE2yH0/A8r1OcT1+wH+XjWIq2w6i6ospdbaRHJYAaqV9bCXtWl33NKjrgDVtJsEj61Qa2XrpjVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217180; c=relaxed/simple;
	bh=yRXHDtQ/G3bT9ailoOKhdZfQalJdRleQ4BDHvp6niZs=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Bi6QsqNU2RKF6ZitrxlUyPOIatJtTUWxHHNJcvmPYsUh0ezJBpg6GmBmMUoloAnm0WO6bA30v6v9UbEG7AVOCzEkna7KcnY7HupkIAJEum5qm1G/8OZNp8hQ5c48i1GrMPNh7AuZ7gDS2TZodSPbqn1wnNHaG6/RjlKijDbEdzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=P/YYGBkz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=o5vDgxhLZvanpHoj46FMW9NqDfITPAkwUtrnGqCj3lE=; b=P/YYGBkzUqNos8KpDdQh1pSM9H
	dKxLGzfxqI3E9uddYG5gAlBQQpMlZHsQQdBj9whWEBC6IH/VHGr+UXisHcVEsFFuutN3VxE9Uelxt
	F+bVERhKM3lqjxJITSwUUgTOcw2lyqwNqenL8RDjid76YzKi/uOr52o+gm3ye/XIF2NXJLCevSGsm
	thxk+P+gMKhqiglCG1mkC+k9iSDDy9iAObGs4I2Cmt+qQya1xrdVC+3lfIEmNaoiO8GIHVhZ1tB09
	LJog6d9ez05ARV8g9txX50+f/GgNOFNXac3JPzErEyP4xkIN4KO9ZZu6hHF5cUszgUC4Dg3eC0S/i
	gYWxM2cg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35136 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uzIbV-000000001bn-2c30;
	Thu, 18 Sep 2025 18:39:33 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uzIbU-00000006mzo-3MJE;
	Thu, 18 Sep 2025 18:39:32 +0100
In-Reply-To: <aMxDh17knIDhJany@shell.armlinux.org.uk>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 08/20] net: dsa: mv88e6xxx: convert
 mv88e6xxx_hwtstamp_work() to take chip
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uzIbU-00000006mzo-3MJE@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 18 Sep 2025 18:39:32 +0100

Instead of passing a pointer to the ptp_clock_info structure, pass a
pointer to mv88e6xxx_chip instead. This allows the transition to the
generic marvell PTP library easier.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/hwtstamp.c | 3 +--
 drivers/net/dsa/mv88e6xxx/hwtstamp.h | 2 +-
 drivers/net/dsa/mv88e6xxx/ptp.c      | 7 ++++++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index 6e6472a3b75a..ba989d699113 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -439,9 +439,8 @@ static int mv88e6xxx_txtstamp_work(struct mv88e6xxx_chip *chip,
 	return 0;
 }
 
-long mv88e6xxx_hwtstamp_work(struct ptp_clock_info *ptp)
+long mv88e6xxx_hwtstamp_work(struct mv88e6xxx_chip *chip)
 {
-	struct mv88e6xxx_chip *chip = ptp_to_chip(ptp);
 	struct dsa_switch *ds = chip->ds;
 	struct mv88e6xxx_port_hwtstamp *ps;
 	int i, restart = 0;
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.h b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
index c359821d5a6e..747351d59921 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.h
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
@@ -124,7 +124,7 @@ void mv88e6xxx_port_txtstamp(struct dsa_switch *ds, int port,
 int mv88e6xxx_get_ts_info(struct dsa_switch *ds, int port,
 			  struct kernel_ethtool_ts_info *info);
 
-long mv88e6xxx_hwtstamp_work(struct ptp_clock_info *ptp);
+long mv88e6xxx_hwtstamp_work(struct mv88e6xxx_chip *chip);
 int mv88e6xxx_hwtstamp_setup(struct mv88e6xxx_chip *chip);
 void mv88e6xxx_hwtstamp_free(struct mv88e6xxx_chip *chip);
 int mv88e6352_hwtstamp_port_enable(struct mv88e6xxx_chip *chip, int port);
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index 43c4af82cb1c..03f30424ba97 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -503,6 +503,11 @@ static void mv88e6xxx_ptp_overflow_check(struct work_struct *work)
 			      MV88E6XXX_TAI_OVERFLOW_PERIOD);
 }
 
+static long mv88e6xxx_ptp_aux_work(struct ptp_clock_info *ptp)
+{
+	return mv88e6xxx_hwtstamp_work(ptp_to_chip(ptp));
+}
+
 int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 {
 	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
@@ -551,7 +556,7 @@ int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 	chip->ptp_clock_info.settime64	= mv88e6xxx_ptp_settime;
 	chip->ptp_clock_info.enable	= mv88e6xxx_ptp_enable;
 	chip->ptp_clock_info.verify	= mv88e6xxx_ptp_verify;
-	chip->ptp_clock_info.do_aux_work = mv88e6xxx_hwtstamp_work;
+	chip->ptp_clock_info.do_aux_work = mv88e6xxx_ptp_aux_work;
 
 	chip->ptp_clock_info.supported_extts_flags = PTP_RISING_EDGE |
 						     PTP_FALLING_EDGE |
-- 
2.47.3


