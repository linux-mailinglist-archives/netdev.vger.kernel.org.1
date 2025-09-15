Return-Path: <netdev+bounces-223184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 476C6B582C6
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 19:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7130189E016
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53D6286433;
	Mon, 15 Sep 2025 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0RBnXz3y"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D750B261B91
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956037; cv=none; b=WsEiwCeam/SqszJBHbG2KBpcvidpgHgy0YCsGsU80GtBJoEn1B9OEuYfKPefKgK4Cpz1InyqtLhmcVHR1KQU3MyTRZhiVdg2ZHpjbHzkMGSbztF1n76rCvvFsOQFYbfwqKEEuvOGRbYK7ppW90eNpksNVrnUCrjcykdYRDIXNtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956037; c=relaxed/simple;
	bh=1fC6qPHhw0+ReUKx7i0sZJqlysF67p/4YIgETaU4kAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DP1cq5ntdrIpjyIgK9sbN/vOHQ1bp910W1s553GH+Uykut//G+pA3l7DhhObiRLsVOmEbR4ndfPRolrXvmaQDAtnKuqD6SSnohHXjByih8TtBlGGDUgsR+H7DpebDH5V4jDQ1UID8pMaKDxOWLr+lxim1scoAr/ew49YnssU6g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0RBnXz3y; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6154A1A0E1A;
	Mon, 15 Sep 2025 17:07:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 30E336063F;
	Mon, 15 Sep 2025 17:07:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F0C3D102F2AEE;
	Mon, 15 Sep 2025 19:07:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757956031; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7Z/vVaiwPDqUIpffCxIZ4JsTPL7u+izJHcekcnCQ+bw=;
	b=0RBnXz3yzSj4Wd59ElaLcVjrbrd4sqPuOgxh6gPpKNjxNPi9sDXJVmfN+As+7qCfMr5yTu
	Ttz/nCe8z7rRmvqZVjFKpEA2NAqw/kpJfOXJybZ4y22IYxmp+mJvz6Y6cmJZG9fmgoTHl2
	Lzc9LA7LPi7trV3K3KWIXlUZZ97fbbX1zMU4Sh6kADsImquztNa5dpePXL+Jv5FzirSs8t
	CO+VhHAOcaoaqAhBPayQELonWrzyf8xjsIENWKM1U59OSdi9J95URpFo8/1jM25mrQDZyH
	BmK19/1MDDieKjYPgX/Vs+240gpTrxvwaE0ncDRAufCJ0YM0z97bbd9/myvLPg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Mon, 15 Sep 2025 19:06:28 +0200
Subject: [PATCH net-next v3 3/5] docs: devlink: Sort table of contents
 alphabetically
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-feature_poe_permanent_conf-v3-3-78871151088b@bootlin.com>
References: <20250915-feature_poe_permanent_conf-v3-0-78871151088b@bootlin.com>
In-Reply-To: <20250915-feature_poe_permanent_conf-v3-0-78871151088b@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>
Cc: kernel@pengutronix.de, Dent Project <dentproject@linuxfoundation.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-Last-TLS-Session-Version: TLSv1.3

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Sort devlink documentation table of contents alphabetically to improve
readability and make it easier to locate specific chapters.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v2:
- New patch
---
 Documentation/networking/devlink/index.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 270a65a014111..0c58e5c729d92 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -56,18 +56,18 @@ general.
    :maxdepth: 1
 
    devlink-dpipe
+   devlink-eswitch-attr
+   devlink-flash
    devlink-health
    devlink-info
-   devlink-flash
+   devlink-linecard
    devlink-params
    devlink-port
    devlink-region
-   devlink-resource
    devlink-reload
+   devlink-resource
    devlink-selftests
    devlink-trap
-   devlink-linecard
-   devlink-eswitch-attr
 
 Driver-specific documentation
 -----------------------------
@@ -78,12 +78,14 @@ parameters, info versions, and other features it supports.
 .. toctree::
    :maxdepth: 1
 
+   am65-nuss-cpsw-switch
    bnxt
    etas_es58x
    hns3
    i40e
-   ionic
    ice
+   ionic
+   iosm
    ixgbe
    kvaser_pciefd
    kvaser_usb
@@ -93,11 +95,9 @@ parameters, info versions, and other features it supports.
    mv88e6xxx
    netdevsim
    nfp
-   qed
-   ti-cpsw-switch
-   am65-nuss-cpsw-switch
-   prestera
-   iosm
    octeontx2
+   prestera
+   qed
    sfc
+   ti-cpsw-switch
    zl3073x

-- 
2.43.0


