Return-Path: <netdev+bounces-136330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA919A153D
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 23:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905C0282409
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 21:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB411D7E4E;
	Wed, 16 Oct 2024 21:52:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65F11D6195
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115557; cv=none; b=mT+h458b4nckkN0i15S4mLwg4slncsuKhhaGU1yelHhfKbPeEnkduluB97ZAFtF0D2/tqLJpm8Hd4g0IO3eaxmJFRJ8VEOHWnTgOF6ItUQyyW5keYRiVZgFVEDzxBF7KuB7rvT4+vw1YQVlRqmpwbUOScl6hweQJrok/B0vVaS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115557; c=relaxed/simple;
	bh=494pt2T3kZMKALHOHvTRwkhbNls4OKIiye9xhuUdKVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=An/7GNTE9fsiATHsOe9shPw2ty0vu3WqyFjXQqYZFIwT+Q0mfgFrM8ATa3MCXsumgLcfZczr+uJ+rcnlRASboBIQX5DA/PDJEQbX6QGbmdv3xxzfp6eujvV4/sq+QR6FpI86z+2V43jKDTTH6YWviGsYXqi2CC0OKmZNfMfDnXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1BwP-0003K1-90
	for netdev@vger.kernel.org; Wed, 16 Oct 2024 23:52:25 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1BwN-002OPg-Lf
	for netdev@vger.kernel.org; Wed, 16 Oct 2024 23:52:23 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 5B8993548C7
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 21:52:23 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 1817735487E;
	Wed, 16 Oct 2024 21:52:20 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 671f4d1b;
	Wed, 16 Oct 2024 21:52:18 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 16 Oct 2024 23:51:52 +0200
Subject: [PATCH net-next 04/13] net: fec: rename struct fec_devinfo
 fec_imx6x_info -> fec_imx6sx_info
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-fec-cleanups-v1-4-de783bd15e6a@pengutronix.de>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
In-Reply-To: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1875; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=494pt2T3kZMKALHOHvTRwkhbNls4OKIiye9xhuUdKVQ=;
 b=owGbwMvMwMWoYbHIrkp3Tz7jabUkhnQB0+ZD5+/cqGUKjqpg0VJyneaR1P7qrv2xJ1tenLgYw
 PTtlLdiJ6MxCwMjF4OsmCJLgMOutgfbWO5q7rGLhxnEygQyhYGLUwAmIjqBg6FVW2pqdSIHQ1/R
 Rv9fKp6XuBiPR+w+vmWJyqMt2o8k2wz3C4SbunVWV67RDXlsvNx557y/jzLY3bb0b6pTee0XsYz
 54pzNR5fJfmNJUvSuaw6eKq3bkq3AvmRbj1+zyYNlxkaZhTcMy8Wv3rLjjPuxpm5lTcfzVuctJ2
 zXZCTxXqwtFdDQdLPVlGkvz7r7X0DmqtLeV8vyWQSZLV0ZvaUaIpZXXhW7uHuVxFH/+X33jtzRY
 /h/39LO6aqU5Nw5UlUnzuly3FmtFv4qRPBmj+okCaY3VWKvtkXv/DzLJEk07Y2r9RFhn74I3fY1
 T8MSuW1k5jP8vdHwtVpoQvObvyufqxwPOiJ91JXxxlIFAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

In da722186f654 ("net: fec: set GPR bit on suspend by DT
configuration.") the platform_device_id fec_devtype::driver_data was
converted from holding the quirks to a pointing to struct fec_devinfo.

The struct fec_devinfo holding the information for the i.MX6SX was
named fec_imx6x_info.

To align the name of the struct with the SoC's name, rename struct
fec_devinfo fec_imx6x_info to struct fec_devinfo fec_imx6sx_info.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 1b55047c0237cbea4e44a5a8335af5c11e2325f8..c57039cc83228dcd980a8fdbc18cd3eab2dfe1a5 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -131,7 +131,7 @@ static const struct fec_devinfo fec_mvf600_info = {
 		  FEC_QUIRK_HAS_MDIO_C45,
 };
 
-static const struct fec_devinfo fec_imx6x_info = {
+static const struct fec_devinfo fec_imx6sx_info = {
 	.quirks = FEC_QUIRK_ENET_MAC | FEC_QUIRK_HAS_GBIT |
 		  FEC_QUIRK_HAS_BUFDESC_EX | FEC_QUIRK_HAS_CSUM |
 		  FEC_QUIRK_HAS_VLAN | FEC_QUIRK_HAS_AVB |
@@ -196,7 +196,7 @@ static const struct of_device_id fec_dt_ids[] = {
 	{ .compatible = "fsl,imx28-fec", .data = &fec_imx28_info, },
 	{ .compatible = "fsl,imx6q-fec", .data = &fec_imx6q_info, },
 	{ .compatible = "fsl,mvf600-fec", .data = &fec_mvf600_info, },
-	{ .compatible = "fsl,imx6sx-fec", .data = &fec_imx6x_info, },
+	{ .compatible = "fsl,imx6sx-fec", .data = &fec_imx6sx_info, },
 	{ .compatible = "fsl,imx6ul-fec", .data = &fec_imx6ul_info, },
 	{ .compatible = "fsl,imx8mq-fec", .data = &fec_imx8mq_info, },
 	{ .compatible = "fsl,imx8qm-fec", .data = &fec_imx8qm_info, },

-- 
2.45.2



