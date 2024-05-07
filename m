Return-Path: <netdev+bounces-94055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 887468BE0BC
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 13:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6331F21B27
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 11:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038BC1514E1;
	Tue,  7 May 2024 11:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="EZOphe+l"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8E11514DE;
	Tue,  7 May 2024 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715080355; cv=none; b=uaWpyOj7N7Y73w1FVucYUEMmF3liyAesnc5j1qvPmnUf5obhR8td+seWfLM2eYJ5tEYEiOiobkzq1g2MF1xeiqqwZ8lSH0IRWeuDM4mSyiCvCjOiDUjH1Wirp4mWLz+3ICwFeh6OmqQE5YVwzuOtNNghlgOLXMLBNOOd6uLHDEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715080355; c=relaxed/simple;
	bh=zSxCKA0DoPcq5N5f7sSYXUx1jwib2HFJ6z5toCJG9ic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RE4nz6P4HF2ZlxY6r7FNjuaHNzruHIXP11NROK8Czh+RyCyoJfGsxrpT1cRTAPYLUoFp8lhzH3SYzUEEdJlIh+at34OyUylHYyNZ8E7AJZ8hgFJR/un1H0B2pysXz3VosooYWSIeb0LnS3OZtd5gnJvCdGsxH+bFIFOvINRkzBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=EZOphe+l; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 7A0F88872F;
	Tue,  7 May 2024 13:12:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715080352;
	bh=jN+EFedDRgb8BUKslcDfIzWNN0Nyjd/TLRJiDObOb4A=;
	h=From:To:Cc:Subject:Date:From;
	b=EZOphe+lgfXkwuYNX/4PmH1PHKP+QI9UBTFYz3eq2wd7wZiKfVnBH+3F+z2/NZWNU
	 YidvliZOBZWxITzzJ/Y7SQTv1/nE2TCdmdvaxn9WdcyPV+73gq5jjh/yZoyReEcg82
	 FrZGUEwy457kIu6e5KedOwMRREPVTlZCXro++H+tosO6PgbEMPLYEGOiQgM6YLiic7
	 NAspXfMR2TZ0GdkmdlzUpCpLWVORm1Y14isoZuvvYFbuX0IBBRUcfUTuVirwcDHnkX
	 ovDMIJHco8RWvKJcjyecAiQhSpvenl1fDT+EZjJiPptNGl/A6C/G8MPAtAhbg0QIkM
	 AUhfterVL1Ipg==
From: Lukasz Majewski <lukma@denx.de>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Simon Horman <horms@kernel.org>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Arvid Brodin <Arvid.Brodin@xdin.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [net PATCH v2] hsr: Simplify code for announcing HSR nodes timer setup
Date: Tue,  7 May 2024 13:12:14 +0200
Message-Id: <20240507111214.3519800-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Up till now the code to start HSR announce timer, which triggers sending
supervisory frames, was assuming that hsr_netdev_notify() would be called
at least twice for hsrX interface. This was required to have different
values for old and current values of network device's operstate.

This is problematic for a case where hsrX interface is already in the
operational state when hsr_netdev_notify() is called, so timer is not
configured to trigger and as a result the hsrX is not sending supervisory
frames to HSR ring.

This error has been discovered when hsr_ping.sh script was run. To be
more specific - for the hsr1 and hsr2 the hsr_netdev_notify() was
called at least twice with different IF_OPER_{LOWERDOWN|DOWN|UP} states
assigned in hsr_check_carrier_and_operstate(hsr). As a result there was
no issue with sending supervisory frames.
However, with hsr3, the notify function was called only once with
operstate set to IF_OPER_UP and timer responsible for triggering
supervisory frames was not fired.

The solution is to use netif_oper_up() and netif_running() helper
functions to assess if network hsrX device is up.
Only then, when the timer is not already pending, it is started.
Otherwise it is deactivated.

Signed-off-by: Lukasz Majewski <lukma@denx.de>

Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
---
Changes for v2:

- Add extra condition to check if the hsr network device is running
  (not only up).

- Only start announce timer when it is not pending (to avoid period
  shortening/violation)
---
 net/hsr/hsr_device.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index e9d45133d641..5afc450d0855 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -61,39 +61,36 @@ static bool hsr_check_carrier(struct hsr_port *master)
 	return false;
 }
 
-static void hsr_check_announce(struct net_device *hsr_dev,
-			       unsigned char old_operstate)
+static void hsr_check_announce(struct net_device *hsr_dev)
 {
 	struct hsr_priv *hsr;
 
 	hsr = netdev_priv(hsr_dev);
-
-	if (READ_ONCE(hsr_dev->operstate) == IF_OPER_UP && old_operstate != IF_OPER_UP) {
-		/* Went up */
-		hsr->announce_count = 0;
-		mod_timer(&hsr->announce_timer,
-			  jiffies + msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL));
+	if (netif_running(hsr_dev) && netif_oper_up(hsr_dev)) {
+		/* Enable announce timer and start sending supervisory frames */
+		if (!timer_pending(&hsr->announce_timer)) {
+			hsr->announce_count = 0;
+			mod_timer(&hsr->announce_timer, jiffies +
+				  msecs_to_jiffies(HSR_ANNOUNCE_INTERVAL));
+		}
+	} else {
+		/* Deactivate the announce timer  */
+		timer_delete(&hsr->announce_timer);
 	}
-
-	if (READ_ONCE(hsr_dev->operstate) != IF_OPER_UP && old_operstate == IF_OPER_UP)
-		/* Went down */
-		del_timer(&hsr->announce_timer);
 }
 
 void hsr_check_carrier_and_operstate(struct hsr_priv *hsr)
 {
 	struct hsr_port *master;
-	unsigned char old_operstate;
 	bool has_carrier;
 
 	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
 	/* netif_stacked_transfer_operstate() cannot be used here since
 	 * it doesn't set IF_OPER_LOWERLAYERDOWN (?)
 	 */
-	old_operstate = READ_ONCE(master->dev->operstate);
 	has_carrier = hsr_check_carrier(master);
 	hsr_set_operstate(master, has_carrier);
-	hsr_check_announce(master->dev, old_operstate);
+	hsr_check_announce(master->dev);
 }
 
 int hsr_get_max_mtu(struct hsr_priv *hsr)
-- 
2.20.1


