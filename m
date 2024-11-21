Return-Path: <netdev+bounces-146654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B596F9D4ED3
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629271F21712
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A9F1DAC93;
	Thu, 21 Nov 2024 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SVaHKaVW"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1681CD1EF;
	Thu, 21 Nov 2024 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200222; cv=none; b=pFyc7F5mIHH2IcQCs2gTgZyb+6tP3GUE1VlfgqzAFQIEzY2LCAdaX0PKAqB2l3RuY0WCkpXmKWIDUPRkvH2+F6GA4u5C+mvNUFGI4WjJJE8qIAFaTSL/ozjiUGSMytfOqmWzLAd+X5TnReL22NtjdTS0VTDsXVe1m0nBWUzrYMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200222; c=relaxed/simple;
	bh=7J/eh52uJk71WbVQkH2eMFY49Q8W9fou8NIi2HeyyTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u6Fo7DT2Y8jfAOqMP5vTWtJ9/FssxmBqiCr04TOhX2hBZRBb0XrqHILaGw5pvCNNm1GIhGE3lxNmhSd6iqBjdXp0yp0lINexASglui96x5UIHz6HZonSJPt7bwltygIFCnkxt6IynrE1NWh4OC+yTSiJ3736sojQvz4A+p1r1Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SVaHKaVW; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 845F440007;
	Thu, 21 Nov 2024 14:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4FptY7neSNIpm8/KU8J5QUzyVqJhV+phM8Nu0jRFeM=;
	b=SVaHKaVWgVx29UyAi9iDL6JErcoU9cWtXFxK0CZJsonyX3I6McZlPTBpp5Vc9BWBqz5CLW
	HZmZafyloTDjJHJrf4glvsPsF2wbjnptF98abO6Qxo0HYHkUInnx460szNHpG2ZdqBEbca
	G8JKyY6vGahEUhOtWl0J9IDb6jkkzxKOYAkNYhpRTuPoV15s57HJVzMtJH6wj6i4aUS83M
	UtUliBzd3hV5kDIlFxfCAtfAVcRa//6MhfGck1oD6zJjKV3riefqhKuoosZm5BUtKF3h9J
	tQu6VM+SZBsID4+A8RsKkxGHgvSfEJbDw2sNutlKT6vs8y4WXw/huk3euT7sJg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 21 Nov 2024 15:42:27 +0100
Subject: [PATCH RFC net-next v3 01/27] net: pse-pd: Remove unused
 pse_ethtool_get_pw_limit function declaration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-feature_poe_port_prio-v3-1-83299fa6967c@bootlin.com>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
In-Reply-To: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Removed the unused pse_ethtool_get_pw_limit() function declaration from
pse.h. This function was declared but never implemented or used,
making the declaration unnecessary.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Kyle Swenson <kyle.swenson@est.tech>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 include/linux/pse-pd/pse.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 591a53e082e6..85a08c349256 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -184,8 +184,6 @@ int pse_ethtool_set_config(struct pse_control *psec,
 int pse_ethtool_set_pw_limit(struct pse_control *psec,
 			     struct netlink_ext_ack *extack,
 			     const unsigned int pw_limit);
-int pse_ethtool_get_pw_limit(struct pse_control *psec,
-			     struct netlink_ext_ack *extack);
 
 bool pse_has_podl(struct pse_control *psec);
 bool pse_has_c33(struct pse_control *psec);
@@ -222,12 +220,6 @@ static inline int pse_ethtool_set_pw_limit(struct pse_control *psec,
 	return -EOPNOTSUPP;
 }
 
-static inline int pse_ethtool_get_pw_limit(struct pse_control *psec,
-					   struct netlink_ext_ack *extack)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline bool pse_has_podl(struct pse_control *psec)
 {
 	return false;

-- 
2.34.1


