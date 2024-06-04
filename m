Return-Path: <netdev+bounces-100521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF8C8FB002
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 12:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F4D1C232B8
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 10:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D070E1459EC;
	Tue,  4 Jun 2024 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LyVmBlcG"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF55145335;
	Tue,  4 Jun 2024 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717497601; cv=none; b=qRSp9IjHYXa70A9iEQJcJMMjPltGL3ECr8NR3IRADK8i4VaUhNWTeSO+czsBXIVNfeII4INvgJ5j+PnM92f6kIdt/0H33MNkzR29FsvhV30TImI81IxeTwdJONctZ814J/lJn0kzgETZqbffFAfguBsWM2V8s73Pbd42tdAJ2y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717497601; c=relaxed/simple;
	bh=XsyXncgoWQvrngpkMvLt3DGzZeulRaLN3MbMuKPLCl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KvPRYDA/gmvRyaHBFo0cMNaMVgnxtmtyTKUj9hQ7xU8v82AXtn8NklSmMGDvWD8kY0N4QW8fkqGkAnofOxEGGCm1cFJhLZgstiRcEpkLjcU/WkPw2GuysCpft5wvYX09nyRCuR+rm+xyxNKucu3pFUn+S6nnsmyTatnX1oorRFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LyVmBlcG; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7AB8C1BF206;
	Tue,  4 Jun 2024 10:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717497598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNk3Stk535OTiM2Qdc5kDPrQfw9T0Zu8ZaQfzXwH48o=;
	b=LyVmBlcGt396Ko6rtVMGZsH7VxtGyON3hY+19EKkPzScwYbD7/j9OLdy3IOYCw11tu4aA6
	7WldzT+MdwqRVfvU5VwlMZ0gLnO3My7mVxw1yXZe7JxG6iLjnxEj0vSZCwddAUC3r/M4a/
	gEZVp9CeNJE1FClhQnVZjDvNgErHYXDgI8Qn+fY9xVVriEKwE45W41k8OFzgwkNQowMVWS
	NDXyMTSCdmxXSrkF78wteyh4T0WAXkwqG+fCYLAEgBMAmIpEdJp7+Ex2AFZP/rInb31FP/
	mzS/9ORE9EL2CcsYpbyZVFxvWI//JVQb0plZ+XxtElbyYtS0QMDpPq+C14pzCA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 04 Jun 2024 12:39:37 +0200
Subject: [PATCH net-next v14 02/14] net: Move dev_set_hwtstamp_phylib to
 net/core/dev.h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-feature_ptp_netnext-v14-2-77b6f6efea40@bootlin.com>
References: <20240604-feature_ptp_netnext-v14-0-77b6f6efea40@bootlin.com>
In-Reply-To: <20240604-feature_ptp_netnext-v14-0-77b6f6efea40@bootlin.com>
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
index d20c6c99eb88..2179fd437271 100644
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


