Return-Path: <netdev+bounces-155098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC5CA00FAD
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 22:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F0D37A0216
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 21:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEBE1C5F0D;
	Fri,  3 Jan 2025 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O3fPMScJ"
X-Original-To: netdev@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470811C5F1F;
	Fri,  3 Jan 2025 21:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735938959; cv=none; b=ndAzWr8AK94yADoY5r8mSNn4PuyYFVkM2t/TjuXe2RSrw6VxrOS0XW2m5aNIv4qSy35QmRQci07Gm6xuoHIM8ZV6ZsyNSGfjGXL/jyBl9ia/rHrduCme6KzQt5CXIdgUr9Ap18oa6kxMrJTpGn/hlfgQc4wFnZ96XszGgfj1g4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735938959; c=relaxed/simple;
	bh=7J/eh52uJk71WbVQkH2eMFY49Q8W9fou8NIi2HeyyTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZjgoGY+bjohS3vGGECknNP36wxClp6n7BQFBrRJ0/ur0JgrA+FA3vo7UeOUJMteBYUqhVCtxOQspikTaQ50fGMtbxFXTkHJZz4HQFEzBja0DBR3sM1dHxWOiVlMWyQuKPgn9yNqHxa+mfgQ4ObHrlpWaoxaxnmszXFcqxow1vGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O3fPMScJ; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay9-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::229])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 06376C0C2C;
	Fri,  3 Jan 2025 21:13:40 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 09F30FF802;
	Fri,  3 Jan 2025 21:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735938812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4FptY7neSNIpm8/KU8J5QUzyVqJhV+phM8Nu0jRFeM=;
	b=O3fPMScJsVqd6+32RL6qNyUYtNPxT8VeOjejIsNnrXWHh43zFDWeI6ju3nqO8UnX+FCGZM
	D5ujcMVTR1vGHDMWYeryK7cYJSB3M0sxE4AdiddrS/aEmKcoUygbfPdvOZXk3EIePbShD0
	q2wRXtzudurs450Jsd6QNpQ4NtYO+GZsYse8vYDHSo9sfyvhxRDZ1AtLOg4bSv1V010+Ep
	WlZppnk8iSLXixAe2uezrcuFkkzNUMu/Qr1RPK6tDj1NiZVlgG4KBUENSnoNh6CqDP1EQu
	4cmZmUP9Ri8o8ZFbuBUJdgYzBSSU3f236ola5/89NQ26qR/JsqsF0VSyNeSx6w==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 03 Jan 2025 22:12:50 +0100
Subject: [PATCH net-next v4 01/27] net: pse-pd: Remove unused
 pse_ethtool_get_pw_limit function declaration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-feature_poe_port_prio-v4-1-dc91a3c0c187@bootlin.com>
References: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
In-Reply-To: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 devicetree@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>, 
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


