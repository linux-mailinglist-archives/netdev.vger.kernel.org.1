Return-Path: <netdev+bounces-221314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC851B501CF
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 872284E4150
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABC526E16C;
	Tue,  9 Sep 2025 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vgZlJAwP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5B7322C66
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432775; cv=none; b=rgAoN7+F5IqblczHDae6xjH+DkYg2566OAiZI0qLSXSUypv18e+D45r1r7V5SdiBE1i6Ap+PH9B9QbZ8ylzcHCGVxPpMbLjxdwncM+8+tUKr6BgOEsfQPAF+DrWaeSz2wLm17gtWKmdMhLHpXNFA0w/zRunRIxa1YMlBClG0pM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432775; c=relaxed/simple;
	bh=KWvtSo8o4PLcisK9q+jy4pMMjXQBw8BIWI9VYFVzfPE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=XscX9m5avoHhG7H1J+7YdEa1pcJxn0zadKlCzS+yqCl700I8XBzyBDaOIZsc4XVYt5Q3zTPcVjn4oMUQLEzkDLSoLTmm84Af4r8rACWTZIWbTE4FJqeXEEYUGI3R7AU7vpH5QSwjA4nHfuh5zZsiKEWvN83j7uGjUbqkBjxcpYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vgZlJAwP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KSS3waHdnr6au8QDZdZPBBdNEEpGrJ29F+o8NjTrhX0=; b=vgZlJAwPk1IxAZk/+oeXpmJ5Ke
	ReHXeoFUAT9u8TWM8ig2guJKHhfCGjDbwa4g6c8xuJ4OeN4lQIfh0HWUICJYO+Ylvl+9nYZAbJBYt
	UCsiJXHgxgHwUWTtgQMJYueZblwF+1Ck/guQhXASq+LhVdRad/DE3bqVnrR5QKJOzTYu6vBXQ+9ue
	rG52dU9qTqf49SyiesGIKN3HOd/qZo6ofnxPqJrPwwc0DLf4zDaxXxclfahD4Lb0wJlMa/VZBua8a
	3/LmWBGvmILFfJVAkNR+37BCBEagy2mEDLYra6IvbJr0vA13SaOAWD8GedRgO4UrXrcyNvQ6DMiqy
	rBeuTJmQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47166 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uw0Xq-000000008Pu-0i45;
	Tue, 09 Sep 2025 16:46:10 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uw0Xp-00000004IOI-1i7v;
	Tue, 09 Sep 2025 16:46:09 +0100
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
Subject: [PATCH net-next 4/4] net: dsa: mv88e6xxx: remove unused support for
 PPS event capture
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uw0Xp-00000004IOI-1i7v@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 09 Sep 2025 16:46:09 +0100

mv88e6352_config_eventcap() is documented as handling both EXTTS and
PPS capture modes, but nothing ever calls it for PPS capture. Remove
the unused PPS capture mode support.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/ptp.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index 37ffa13c0e3e..2dc5dff99633 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -167,16 +167,13 @@ static u64 mv88e6165_ptp_clock_read(struct cyclecounter *cc)
 }
 
 /* mv88e6352_config_eventcap - configure TAI event capture
- * @event: PTP_CLOCK_PPS (internal) or PTP_CLOCK_EXTTS (external)
  * @rising: zero for falling-edge trigger, else rising-edge trigger
  *
  * This will also reset the capture sequence counter.
  */
-static int mv88e6352_config_eventcap(struct mv88e6xxx_chip *chip, int event,
-				     int rising)
+static int mv88e6352_config_eventcap(struct mv88e6xxx_chip *chip, int rising)
 {
 	u16 evap_config;
-	u16 cap_config;
 	int err;
 
 	evcap_config = MV88E6XXX_TAI_CFG_CAP_OVERWRITE |
@@ -188,20 +185,8 @@ static int mv88e6352_config_eventcap(struct mv88e6xxx_chip *chip, int event,
 	if (err)
 		return err;
 
-	if (event == PTP_CLOCK_PPS) {
-		cap_config = MV88E6XXX_TAI_EVENT_STATUS_CAP_TRIG;
-	} else if (event == PTP_CLOCK_EXTTS) {
-		/* if STATUS_CAP_TRIG is unset we capture PTP_EVREQ events */
-		cap_config = 0;
-	} else {
-		return -EINVAL;
-	}
-
 	/* Write the capture config; this also clears the capture counter */
-	err = mv88e6xxx_tai_write(chip, MV88E6XXX_TAI_EVENT_STATUS,
-				  cap_config);
-
-	return err;
+	return mv88e6xxx_tai_write(chip, MV88E6XXX_TAI_EVENT_STATUS, 0);
 }
 
 static void mv88e6352_tai_event_work(struct work_struct *ugly)
@@ -354,7 +339,7 @@ static int mv88e6352_ptp_enable_extts(struct mv88e6xxx_chip *chip,
 		schedule_delayed_work(&chip->tai_event_work,
 				      TAI_EVENT_WORK_INTERVAL);
 
-		err = mv88e6352_config_eventcap(chip, PTP_CLOCK_EXTTS, rising);
+		err = mv88e6352_config_eventcap(chip, rising);
 	} else {
 		func = MV88E6352_G2_SCRATCH_GPIO_PCTL_GPIO;
 
-- 
2.47.3


