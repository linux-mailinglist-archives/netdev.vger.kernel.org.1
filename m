Return-Path: <netdev+bounces-105582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A67911E1B
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3191B212D3
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 08:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8868D172790;
	Fri, 21 Jun 2024 08:02:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F5217165C
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956937; cv=none; b=sTx+e0Q4Op6AEGRhYbUFNaTyC4CdPhKktmPFlgXJpLpp9Xso/LlR6gYI29qHLRqC0Plz4EUZwhSXAZ2rQPE+xM2DiyJlhew/2N19VnuKiDtAJ1N350E7SiJVrKm6kT3kKys7Ck4AAKYfNnOEnFMWfbBCUe04X5E9Okpoh4XNuRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956937; c=relaxed/simple;
	bh=hzOAIpwMQ2nMf8zOpKIrqfwhoNCRifXZBq+aXbwcEvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sN9/xhHxHOn6g9pvM3GQ4TRW/wzuzsTxrTfCSOLdEDWHDmw3GbcVxSzjri1VaF+Unq87b68CO2e+dz63JEWOsgX5ONIqqhCiR6cTtMU9YN6zYTAAA/uxw4aA7bOac+rEvZBZirTIMTarDzvgNAWvM2Mf7PRJ0Zcd5wEtKnuEZGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDo-00046k-9r
	for netdev@vger.kernel.org; Fri, 21 Jun 2024 10:02:12 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDk-003tMg-3i
	for netdev@vger.kernel.org; Fri, 21 Jun 2024 10:02:08 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id C88662EE444
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 08:02:07 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E6F212EE3B3;
	Fri, 21 Jun 2024 08:02:03 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 505d5c9c;
	Fri, 21 Jun 2024 08:02:03 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Martin Jocic <martin.jocic@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 17/24] can: kvaser_pciefd: Rename board_irq to pci_irq
Date: Fri, 21 Jun 2024 09:48:37 +0200
Message-ID: <20240621080201.305471-18-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621080201.305471-1-mkl@pengutronix.de>
References: <20240621080201.305471-1-mkl@pengutronix.de>
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

From: Martin Jocic <martin.jocic@kvaser.com>

Rename the variable name board_irq in the ISR to pci_irq to
be more specific and to match the macro by which it is read.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
Link: https://lore.kernel.org/all/20240614151524.2718287-7-martin.jocic@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index b08084b0a95b..8b2c18f2f23b 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1691,17 +1691,17 @@ static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
 {
 	struct kvaser_pciefd *pcie = (struct kvaser_pciefd *)dev;
 	const struct kvaser_pciefd_irq_mask *irq_mask = pcie->driver_data->irq_mask;
-	u32 board_irq = ioread32(KVASER_PCIEFD_PCI_IRQ_ADDR(pcie));
+	u32 pci_irq = ioread32(KVASER_PCIEFD_PCI_IRQ_ADDR(pcie));
 	int i;
 
-	if (!(board_irq & irq_mask->all))
+	if (!(pci_irq & irq_mask->all))
 		return IRQ_NONE;
 
-	if (board_irq & irq_mask->kcan_rx0)
+	if (pci_irq & irq_mask->kcan_rx0)
 		kvaser_pciefd_receive_irq(pcie);
 
 	for (i = 0; i < pcie->nr_channels; i++) {
-		if (board_irq & irq_mask->kcan_tx[i])
+		if (pci_irq & irq_mask->kcan_tx[i])
 			kvaser_pciefd_transmit_irq(pcie->can[i]);
 	}
 
-- 
2.43.0



