Return-Path: <netdev+bounces-241874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E230C89A70
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 13:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E034E3B74D6
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 12:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93EE327217;
	Wed, 26 Nov 2025 12:01:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4982DEA64
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764158490; cv=none; b=FiAeEqyt9iezxC+tfO/AsFQ2yPl6xNBjvt3KnEw2D8btl7hCWk73K9dyGZhUZMXiRjsO+fuj2ZSR2KYOSLTTs/Q55nV4RUzjJamvmz9PeXixThgO/BqkxZ+hTrWl2dr2I+JdFeSm6ELidDxAMMO9RFPNWePFM3uFj11BcMuO+g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764158490; c=relaxed/simple;
	bh=NPDg3uNDgYhh7Ox4l5HPR0swr7EjvK5g0neVGasOI4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJrlnMoqGnHYP6gUt7e96LsWl2sd6hLvsu4ImWLTRyejT718ZWLe9ORG/fRONVUfTCAjRzdN5POiM1v/ApnEZpuC8tpbnyxF8wgoAzuZqg98g9OcrQvenrDozgDoTdLjmLVdpbPoYrXnjAWD+kZ8WN3JZAupIsZ5s9B9rHB2tEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOECu-0004V8-8t; Wed, 26 Nov 2025 13:01:12 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOECt-002bFQ-0s;
	Wed, 26 Nov 2025 13:01:11 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0CB084A8AA4;
	Wed, 26 Nov 2025 12:01:11 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 25/27] MAINTAINERS: Add myself as m_can maintainer
Date: Wed, 26 Nov 2025 12:57:14 +0100
Message-ID: <20251126120106.154635-26-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126120106.154635-1-mkl@pengutronix.de>
References: <20251126120106.154635-1-mkl@pengutronix.de>
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

From: Markus Schneider-Pargmann <msp@baylibre.com>

As I have contributed to the m_can driver over the past years, I would
like to continue maintaining the driver. As Chandrasekar is currently
not responsive, I will replace him as the maintainer of the driver.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Link: https://patch.msgid.link/20251119-topic-mcan-reviewer-v6-18-v2-1-f842c3094b18@baylibre.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e9a8d945632b..92951d196d27 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15413,7 +15413,7 @@ F:	drivers/net/phy/mxl-86110.c
 F:	drivers/net/phy/mxl-gpy.c
 
 MCAN MMIO DEVICE DRIVER
-M:	Chandrasekar Ramakrishnan <rcsekar@samsung.com>
+M:	Markus Schneider-Pargmann <msp@baylibre.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
-- 
2.51.0


