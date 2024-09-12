Return-Path: <netdev+bounces-127733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C25E976401
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 10:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED3F1C20B7A
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE1C190489;
	Thu, 12 Sep 2024 08:06:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4755C18FDDB
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726128380; cv=none; b=LmCNRdeSyFoPaYIZBB6bEe/+1XF/CwSBfmH4JCJQjL7Qn/glTvGRUZfOj6eLKS9cHRpfumECBX6tEZSnAza0FDHoU9ILYWs9Th4kuG2RHoWnWIvscwpREvnjnj5S4k9k2lABROIX64Gu9HNMEVf5E4IEvecCycDLAIH2jBoKCTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726128380; c=relaxed/simple;
	bh=Ms10KLTfPEuAES8odMatWMgk9SPFD3I+Fktxpm+m2lY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UaJCKoiDI0ouJvq9OLMAz4w8JKKRh1xU9vBMDbftZxOoW3lUtQuEF+7ZrFSqgmh9/vGrQIDiQ6BB3HT4KyFL77C5d6TeXaJN2CB05CeZJTN337uR67obYzxmuM2T40R4me0VKEQN5Bi5LQjtkHZj4s2t9SZjX8G2Dgh/0gFRHmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1soeq9-00049o-Ma
	for netdev@vger.kernel.org; Thu, 12 Sep 2024 10:06:09 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1soeq7-007KhJ-B7
	for netdev@vger.kernel.org; Thu, 12 Sep 2024 10:06:07 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 8D23E338EE4
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 08:04:42 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id CE532338EA0;
	Thu, 12 Sep 2024 08:04:40 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9c106299;
	Thu, 12 Sep 2024 08:04:40 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 2/5] can: usb: Kconfig: Fix list of devices for esd_usb driver
Date: Thu, 12 Sep 2024 09:58:59 +0200
Message-ID: <20240912080438.2826895-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912080438.2826895-1-mkl@pengutronix.de>
References: <20240912080438.2826895-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Stefan Mätje <stefan.maetje@esd.eu>

The CAN-USB/3-FD was missing on the list of supported devices.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
Link: https://patch.msgid.link/20240910170236.2287637-1-stefan.maetje@esd.eu
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index 3e1fba12c0c3..9dae0c71a2e1 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -17,11 +17,12 @@ config CAN_EMS_USB
 config CAN_ESD_USB
 	tristate "esd electronics gmbh CAN/USB interfaces"
 	help
-	  This driver adds supports for several CAN/USB interfaces
+	  This driver adds support for several CAN/USB interfaces
 	  from esd electronics gmbh (https://www.esd.eu).
 
 	  The drivers supports the following devices:
 	    - esd CAN-USB/2
+	    - esd CAN-USB/3-FD
 	    - esd CAN-USB/Micro
 
 	  To compile this driver as a module, choose M here: the module
-- 
2.45.2



