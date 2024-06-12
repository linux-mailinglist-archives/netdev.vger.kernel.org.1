Return-Path: <netdev+bounces-102909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A64B905646
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 17:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF5BB1F21798
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 15:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF691802D0;
	Wed, 12 Jun 2024 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VgdlRj8g"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB0817F4EC;
	Wed, 12 Jun 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204706; cv=none; b=cmB1PHP9DX8rp3pDRjoRHzmHIAOJcB+1Uzvx/IqUeHM9Ofw24ynunjhbZqkDpXoLEIHekjSxu/cvQ46c48vtbTiheZNGor/vLd3DXIDGQ0RsgKOH+/1iEl3NJ8BArla/NosQBpZPH1T+0cmGNCAM1JJ1Xh1SJ0MtmDx5XTlBARA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204706; c=relaxed/simple;
	bh=fo48TrjzteY/bWUklxe6GXLv01EZ7bLT1ntsQc67Cmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i5r0P5NJOUUApbRIRwEdljedkbcBBm60yJravQ98IaRNlARh0td9hySrpMPyG8w7e3MF2kq/QQj5uJ70S4yrUzaxPEI2ngJGNWp+qX6bgX4w7StIDNQO1//g1CmBDGyEkpmXRlCsKR0jHkBXOaFFSFYtHwT9DGJTjuQ4uQDcZxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VgdlRj8g; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0778D4000B;
	Wed, 12 Jun 2024 15:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718204697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMnuCma5EN1mYWxfE9yxvzI7yrZrJ9Ae1v97/DqbDdk=;
	b=VgdlRj8geDzeFALXJ9KSmTOLuIjCa4RqqiflvKefaJvJ/18l0QGRLPE3cmt5EP/rP9x3LE
	nzKhBWUsaGIMshgkXESK6KbdCeekHfzZJEBP7ApRi/Gp/7RJ3FAzHBM0cDbq1gJEnKBU9E
	+0zWOQ/yoijrYFVcYduRA/pWKpSACGABbrBmdGkEsHGCu1ZCHNjsttJ2WLjdfOMW8Gmxay
	Y9neoF6e17+Cfu3thcvL2rRQg5J2Q4QMPHpM8MNegMxZNwztiWSC+KtpLROjQKpYNSsihU
	tIHMnTD6xDPk7PDxTqMlYsqva1Sc+hmnwPQODGlKUuALpRap1yrVVRjWwMXV5A==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 12 Jun 2024 17:04:02 +0200
Subject: [PATCH net-next v15 02/14] net: Move dev_set_hwtstamp_phylib to
 net/core/dev.h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-feature_ptp_netnext-v15-2-b2a086257b63@bootlin.com>
References: <20240612-feature_ptp_netnext-v15-0-b2a086257b63@bootlin.com>
In-Reply-To: <20240612-feature_ptp_netnext-v15-0-b2a086257b63@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: kory.maincent@bootlin.com

This declaration was added to the header to be called from ethtool.
ethtool is separated from core for code organization but it is not really
a separate entity, it controls very core things.
As ethtool is an internal stuff it is not wise to have it in netdevice.h.
Move the declaration to net/core/dev.h instead.

Remove the EXPORT_SYMBOL_GPL call as ethtool can not be built as a module.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v10:
- New patch.
---
 include/linux/netdevice.h | 3 ---
 net/core/dev.h            | 4 ++++
 net/core/dev_ioctl.c      | 1 -
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f148a01dd1d1..392083cff5ee 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3903,9 +3903,6 @@ int generic_hwtstamp_get_lower(struct net_device *dev,
 int generic_hwtstamp_set_lower(struct net_device *dev,
 			       struct kernel_hwtstamp_config *kernel_cfg,
 			       struct netlink_ext_ack *extack);
-int dev_set_hwtstamp_phylib(struct net_device *dev,
-			    struct kernel_hwtstamp_config *cfg,
-			    struct netlink_ext_ack *extack);
 int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *userdata);
 unsigned int dev_get_flags(const struct net_device *);
 int __dev_change_flags(struct net_device *dev, unsigned int flags,
diff --git a/net/core/dev.h b/net/core/dev.h
index b7b518bc2be5..58f88d28bc99 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -166,4 +166,8 @@ static inline void dev_xmit_recursion_dec(void)
 	__this_cpu_dec(softnet_data.xmit.recursion);
 }
 
+int dev_set_hwtstamp_phylib(struct net_device *dev,
+			    struct kernel_hwtstamp_config *cfg,
+			    struct netlink_ext_ack *extack);
+
 #endif
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 9a66cf5015f2..b9719ed3c3fd 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -363,7 +363,6 @@ int dev_set_hwtstamp_phylib(struct net_device *dev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(dev_set_hwtstamp_phylib);
 
 static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 {

-- 
2.34.1


