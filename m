Return-Path: <netdev+bounces-157051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7172A08C73
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B88E164E5C
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FA920C484;
	Fri, 10 Jan 2025 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fr7ZhPgg"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC0F20ADFD;
	Fri, 10 Jan 2025 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502047; cv=none; b=dHdepfAivjfz6jEmqd5y9Nr47wl9bX/3VbCCpxguGoevLt4VAIpojMQeKSWzY1WmaxDoM7mx1V97ouxZfyql4iWIMuRYrcmCnNgY1yqb1CZKpsoSJl/XC2PDt30d4/144CLIa+vwCnMzdgKuFYKQ8Qeq4kmGzn+8Lzh8pvIsu6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502047; c=relaxed/simple;
	bh=PDl2g7fKJGyD6zAj6RjsXeYUPk2qXfNoXBzZDt3NGPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tgtDBQtnLsoCj25hPRrLaWwKvb8U+J1rCnqZRMOHTO8u0uKX0iVzeB+68cJwV1yVNX3HoNLAoOZ+SvFN8DPtcTPvjPMyyoj5HBqAk2TiXY/5mD77O/9UT94v62TO9i7KUa77We89csJJzs4i52y18xidqyeVMLgItzhL+EBLweM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fr7ZhPgg; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DDFA66000C;
	Fri, 10 Jan 2025 09:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736502043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayRV9+l17ONAq1pIr8+GSEltHOMPV9kPPJnrAbxjFVU=;
	b=fr7ZhPggKZZ/vo1MBxIE8gGZEbYW38rM4YanTf/Hm+6csmeTk/ePDJ+26ljilPiHV0FRUF
	/m2PRWplGUvyM/WEZElcmEX19y9cak0HWrbbTRJnBwE4/Kwk6SLmQIMhHaTcfkBrLaR14T
	/OSg8uh+9MUGktbH+ywrKr5J0cN7Cb8ZX0l+dO8tehLCRT6HoZlesv2mvBHWcirG4YqsBh
	ASXr2AYTNQKaS03BolJE4kyiQ9vyvwBlkr/3o6FSHUgRdYwQOpuXi0FcXtocdu5pZbBeb7
	e1Y2sLHKXGHPMszyngphVY8EnO7sLEhojio0YfK22rADpCS7qhkkKJu8YGY2Kg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 10 Jan 2025 10:40:20 +0100
Subject: [PATCH net-next v3 01/12] net: pse-pd: Remove unused
 pse_ethtool_get_pw_limit function declaration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-feature_poe_arrange-v3-1-142279aedb94@bootlin.com>
References: <20250110-b4-feature_poe_arrange-v3-0-142279aedb94@bootlin.com>
In-Reply-To: <20250110-b4-feature_poe_arrange-v3-0-142279aedb94@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.1
X-GND-Sasl: kory.maincent@bootlin.com

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


