Return-Path: <netdev+bounces-198599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7528ADCD38
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC7F3B2CFA
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DBB2E3AE0;
	Tue, 17 Jun 2025 13:25:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194B02E266B
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750166738; cv=none; b=W50kOSmgbWxahd6yo8ezt5v3FKoBQOAWEW1xL5P3Jj3d9vo57J3fN7Z9Tjrx/NPZD9NUWy5QZSR5pGPYRi7lfhoQXzYD780ehT8I/TctgraG03o4Ec50NHvXdyCn2N9DBopge/Lh5dFmhGz6Dh913MpWVb62DnsWZExfLYvhmas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750166738; c=relaxed/simple;
	bh=sA04u1PdDgRmLuhc7IHhWUv+JPtsYb7W1PMpqmuQz+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OJpX9YlLgWH7KlaHRLJnPMsYqk/UX3EZ5S3ma1O2ZrBORHawUxqghxcfGJDaBYlLZqeZzUrOUXUZKYCKW/TrlEkVW0hlPRm7sbiqV2NS/cUDHBV0z7Zou7d9yEla/SjWgOn+py3G00Pfy8R4Xj+gge7LF44w9FqHLRMe5e1FBA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f3d:bb00:e2bf:c3f2:96ab:885d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id 8D75166ECF2
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 13:25:25 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 5326442A7F5
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 13:25:25 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 5912342A7A0;
	Tue, 17 Jun 2025 13:25:21 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5de7fef6;
	Tue, 17 Jun 2025 13:25:20 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 17 Jun 2025 15:24:52 +0200
Subject: [PATCH net-next v3 02/10] net: fec: struct fec_enet_private:
 remove obsolete comment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-fec-cleanups-v3-2-a57bfb38993f@pengutronix.de>
References: <20250617-fec-cleanups-v3-0-a57bfb38993f@pengutronix.de>
In-Reply-To: <20250617-fec-cleanups-v3-0-a57bfb38993f@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1013; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=sA04u1PdDgRmLuhc7IHhWUv+JPtsYb7W1PMpqmuQz+g=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBoUWyvSCJ0U4ZK6rvs4QmjRvoApMNKLKPvQJO6J
 koIGM7ZtImJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaFFsrwAKCRAMdGXf+ZCR
 nCLmCACZLmnH7FBEwBptt5ZIYehRK0klWwgstNt72x1ZUNLTJLB7SMBEYUvYOeFpGTa/LM09i7P
 pHwMhZb/uXpxiGyTKhu9n4qQ2eKh6rB9Pfw1wacIWjpI5TOhVU1I/ZbwaoPGK60OfYolhJhga3Q
 SV8naIm1WKt1zLUUwQbz7gXmvNh2pcj5D2z5R9Hv+mVE+Y0z7tYeTIU5IwIr7IP1W5ZIGruG7Vg
 /2ceDG5EpkZQtk/GUwbKFmy6xw1usE+NZXAD+uYwFM/Qwk1xZccAzFwQITIiErbXIyL8jGf9ZTs
 qd7trbm30FYSCgr3D2hXmaj3hXEjym160YHJDj24CbyRnTuH
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

In commit 4d494cdc92b3 ("net: fec: change data structure to support
multiqueue") the data structures were changed, so that the comment about
the sent-in-place skb doesn't apply any more. Remove it.

Reviewed-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 3cce9bba5dee..ce1e4fe4d492 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -614,7 +614,6 @@ struct fec_enet_private {
 	unsigned int num_tx_queues;
 	unsigned int num_rx_queues;
 
-	/* The saved address of a sent-in-place packet/buffer, for skfree(). */
 	struct fec_enet_priv_tx_q *tx_queue[FEC_ENET_MAX_TX_QS];
 	struct fec_enet_priv_rx_q *rx_queue[FEC_ENET_MAX_RX_QS];
 

-- 
2.47.2



