Return-Path: <netdev+bounces-156621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDED0A072B0
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21EB8188A101
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E869121638D;
	Thu,  9 Jan 2025 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nQxYQDhN"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C695215F5C;
	Thu,  9 Jan 2025 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417934; cv=none; b=qtsETGgCpLbEpwZtPVahFhjZst2t29/hJ2ef3P6jdM/IDpYpcLOJ9j/b0J1PtAAW/sLnSPlGuJnPMvZtvfwjzRbc1vFM76uFsx0lJUAx3RZV+1aA+C9HaG8Vy/DZ5r5+fg3BbJyePpaQrmHf9rNqPbFnBoLLeMRB39src3o7ZZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417934; c=relaxed/simple;
	bh=7J/eh52uJk71WbVQkH2eMFY49Q8W9fou8NIi2HeyyTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DfuhsnBwyQOkyclME+KV9bEmMbUOGA4o9l9JqfZUdtdXeZf7qqdo95t6mxKUoCnKUltvREHzZWGjx3Dtt0Y/G4qRrO+u0Oggl2Mhn/RsYNcVF3qmtJhSzcFSB0jr5Y4fMgy1ruRQ1+257uVsrwwJDTg6mHwjMrLPWI492avUSxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nQxYQDhN; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4753BE000F;
	Thu,  9 Jan 2025 10:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736417925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4FptY7neSNIpm8/KU8J5QUzyVqJhV+phM8Nu0jRFeM=;
	b=nQxYQDhNPb77ggDko/bLrTHO6VMpOmgNdu+zcFZOdtV/m5n5vw81zlmmajJloaPbxBJDpc
	Yf+YWxiyUC19+7BWt7TT/lkKPoKfMh8bai9p/CL4WYLmVUfg+IzfMAcsRIw7pps9mZ+ann
	PiBjuzWjxoiSzhqMhj159Xip2kAYUL8fiMrsL0o/g1JcII5WB4urfGEsNFxiSqrQ4bA4rw
	MJWkTgiJLrbRR5EgfBVCuX/ye1gd3hEUZkvQnCXm4vMkbVUJD24YXIwHo0DyuiaGvob+k5
	Fnana6uCJMwDiXsQC/JK8hF6XqsqRpQ0WNOBMnPXAvSn8+oi3hS7LtkCQx8I0w==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 09 Jan 2025 11:17:55 +0100
Subject: [PATCH net-next v2 01/15] net: pse-pd: Remove unused
 pse_ethtool_get_pw_limit function declaration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-b4-feature_poe_arrange-v2-1-55ded947b510@bootlin.com>
References: <20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com>
In-Reply-To: <20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>
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


