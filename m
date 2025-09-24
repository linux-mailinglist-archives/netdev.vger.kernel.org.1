Return-Path: <netdev+bounces-225880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD2FB98D9D
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5D12E7313
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486A0280339;
	Wed, 24 Sep 2025 08:22:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47422248A5
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702119; cv=none; b=uZVUl5tmvMD5xS10Xvm0t8COtOY5y10zmXIHMiobOPPLi6QZNjmPvEgW1IY3rqTE5ILoQ2IfltAcnQhD1iDteNX4wYZg2aeYyFOKZa6v/tF0TV4A84X5cjqtRvo5YeEnNJLCV0P4U9jcEkArXga/n6R9mVZ7lIn7eaw7PeXMwLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702119; c=relaxed/simple;
	bh=cFLbESbAIn/mr9J6GG4FjnQgFD5qgg6MmivH5+SLSRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RselIH0Jp9P3+eEf3Uvrn217EE64NO22QqKRsOuGNuyyDr5A+bJhmdUO1ZSNpIsnkeR/Ym8dmpY5oMooea2bGg4LrCVEB5UPy3TvUFDf15aQmW6bPH12Bhi2zOFAciTIK1XmwNdD+W3WPE/ke/cvs+YnT4wbmn8ghkkq1vS2utU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkf-0001GX-Bw; Wed, 24 Sep 2025 10:21:25 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-000Dwi-29;
	Wed, 24 Sep 2025 10:21:23 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F3771478869;
	Wed, 24 Sep 2025 08:21:06 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 03/48] can: dev: sort includes by alphabetical order
Date: Wed, 24 Sep 2025 10:06:20 +0200
Message-ID: <20250924082104.595459-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924082104.595459-1-mkl@pengutronix.de>
References: <20250924082104.595459-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Vincent Mailhol <mailhol@kernel.org>

Includes are out of order in

  drivers/net/can/dev/dev.c

Sort them by alphabetical order.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250830152107.694201-2-mailhol@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 3913971125de..99b78cbb2252 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -4,17 +4,17 @@
  * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
  */
 
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/netdevice.h>
-#include <linux/if_arp.h>
-#include <linux/workqueue.h>
 #include <linux/can.h>
 #include <linux/can/can-ml.h>
 #include <linux/can/dev.h>
 #include <linux/can/skb.h>
 #include <linux/gpio/consumer.h>
+#include <linux/if_arp.h>
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
 #include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
 
 static void can_update_state_error_stats(struct net_device *dev,
 					 enum can_state new_state)
-- 
2.51.0


