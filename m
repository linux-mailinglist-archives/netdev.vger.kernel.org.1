Return-Path: <netdev+bounces-196024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F8BAD32B0
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 11:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8EE16CE35
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 09:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC6F28D8C5;
	Tue, 10 Jun 2025 09:49:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B0628C2AB
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548982; cv=none; b=gwHHLUk4w5ic+ewAm0cGRO/NAhGmfGNg8YbLdyirYAOCTHsTeGMkWqS1qhB/1F29Y0RxBmGtcLCvJf4GHLXs/WNARkXso5Qiy9zY7HsBzLHculC+zO03kaxK9kv32cILeaNnxExheWoNJs7922xKVS+4kYW0paML1KTTjWboGEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548982; c=relaxed/simple;
	bh=G2AbIDm+d8CmG7vak1QRzDSXqIyrn01Ip9EUWDPVA8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+5w8hgdrLF8L9uPsvwHA0/bf5XWUa5zxar2WyUVENCY2dC7vjSmZZRrSCQgmBEcus7/VphQl1fcZiu774/5DBVs3ZSdtoGXkYPd5sykpIDr2g0SwLGMNwT3Ys7JlTQkQHzXaLtePdw+QpGu50LjIK4Op9zaLF42vYgdNUyajkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uOvbt-00063g-Q7
	for netdev@vger.kernel.org; Tue, 10 Jun 2025 11:49:37 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uOvbt-002kcZ-0L
	for netdev@vger.kernel.org;
	Tue, 10 Jun 2025 11:49:37 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id C56C34241A4
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 09:49:36 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 542B9424182;
	Tue, 10 Jun 2025 09:49:35 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5e326d54;
	Tue, 10 Jun 2025 09:49:34 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 2/7] can: bittiming: rename CAN_CTRLMODE_TDC_MASK into CAN_CTRLMODE_FD_TDC_MASK
Date: Tue, 10 Jun 2025 11:46:17 +0200
Message-ID: <20250610094933.1593081-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610094933.1593081-1-mkl@pengutronix.de>
References: <20250610094933.1593081-1-mkl@pengutronix.de>
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

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

With the introduction of CAN XL, a new CAN_CTRLMODE_XL_TDC_MASK will
be introduced later on. Because CAN_CTRLMODE_TDC_MASK is not part of
the uapi, rename it to CAN_CTRLMODE_FD_TDC_MASK to make it more
explicit that this mask is meant for CAN FD.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20241112165118.586613-10-mailhol.vincent@wanadoo.fr
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/calc_bittiming.c |  2 +-
 drivers/net/can/dev/netlink.c        | 12 ++++++------
 include/linux/can/bittiming.h        |  2 +-
 include/linux/can/dev.h              |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 3809c148fb88..a94bd67c670c 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -179,7 +179,7 @@ void can_calc_tdco(struct can_tdc *tdc, const struct can_tdc_const *tdc_const,
 	if (!tdc_const || !(ctrlmode_supported & CAN_CTRLMODE_TDC_AUTO))
 		return;
 
-	*ctrlmode &= ~CAN_CTRLMODE_TDC_MASK;
+	*ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
 
 	/* As specified in ISO 11898-1 section 11.3.3 "Transmitter
 	 * delay compensation" (TDC) is only applicable if data BRP is
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 4ebd5181aea9..08261cfcf6b2 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -67,12 +67,12 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 
 	if (data[IFLA_CAN_CTRLMODE]) {
 		struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
-		u32 tdc_flags = cm->flags & CAN_CTRLMODE_TDC_MASK;
+		u32 tdc_flags = cm->flags & CAN_CTRLMODE_FD_TDC_MASK;
 
 		is_can_fd = cm->flags & cm->mask & CAN_CTRLMODE_FD;
 
 		/* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually exclusive */
-		if (tdc_flags == CAN_CTRLMODE_TDC_MASK)
+		if (tdc_flags == CAN_CTRLMODE_FD_TDC_MASK)
 			return -EOPNOTSUPP;
 		/* If one of the CAN_CTRLMODE_TDC_* flag is set then
 		 * TDC must be set and vice-versa
@@ -230,16 +230,16 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			dev->mtu = CAN_MTU;
 			memset(&priv->fd.data_bittiming, 0,
 			       sizeof(priv->fd.data_bittiming));
-			priv->ctrlmode &= ~CAN_CTRLMODE_TDC_MASK;
+			priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
 			memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
 		}
 
-		tdc_mask = cm->mask & CAN_CTRLMODE_TDC_MASK;
+		tdc_mask = cm->mask & CAN_CTRLMODE_FD_TDC_MASK;
 		/* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually
 		 * exclusive: make sure to turn the other one off
 		 */
 		if (tdc_mask)
-			priv->ctrlmode &= cm->flags | ~CAN_CTRLMODE_TDC_MASK;
+			priv->ctrlmode &= cm->flags | ~CAN_CTRLMODE_FD_TDC_MASK;
 	}
 
 	if (data[IFLA_CAN_BITTIMING]) {
@@ -339,7 +339,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			err = can_tdc_changelink(priv, data[IFLA_CAN_TDC],
 						 extack);
 			if (err) {
-				priv->ctrlmode &= ~CAN_CTRLMODE_TDC_MASK;
+				priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
 				return err;
 			}
 		} else if (!tdc_mask) {
diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index 9b8a9c39614b..5dfdbb63b1d5 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -14,7 +14,7 @@
 #define CAN_BITRATE_UNSET 0
 #define CAN_BITRATE_UNKNOWN (-1U)
 
-#define CAN_CTRLMODE_TDC_MASK					\
+#define CAN_CTRLMODE_FD_TDC_MASK				\
 	(CAN_CTRLMODE_TDC_AUTO | CAN_CTRLMODE_TDC_MANUAL)
 
 /*
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 492d23bec7be..e492dfa8a472 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -93,7 +93,7 @@ struct can_priv {
 
 static inline bool can_tdc_is_enabled(const struct can_priv *priv)
 {
-	return !!(priv->ctrlmode & CAN_CTRLMODE_TDC_MASK);
+	return !!(priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);
 }
 
 /*
-- 
2.47.2



