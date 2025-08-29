Return-Path: <netdev+bounces-218340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B864AB3C0B1
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 18:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48371C83FE5
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 16:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F9A2236F0;
	Fri, 29 Aug 2025 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J3fkulsD"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93C029E0FF
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485001; cv=none; b=g7WEooM5D+BbB53g3ZVyPrYVz8qzB41FAOhJbLoT5tSUjG39YZFxtIg5prrOfDFWrMHcvKan8byE9BWexg7XxAOPIIXQzX3QUitOXWJU6iIxgci2hbTS9khhyV/TC2IpIXbwxjeHXMLlFweQvXs6CYyfx0cpfQzlpbKQrnN+cmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485001; c=relaxed/simple;
	bh=p3JqtUSSx0HxxWGt1wJsKnufY7nH+uaI1v2POiauOb4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sSoBwvN9hOxjCpDWUWoOY26ZMSXT8J80wFxTMN9wlDga3Vc4B1KyAVqXt4XN775roZT4kOT3jLU44KH8SKIvvCNpRoHX7ZK7Byb8NwFHWbm0QUn9wAjJiO5Sh4cVc3/5bwQDR16swlYnqo+ym+d2/iav9+p9/lW0NT6s2hgSyPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J3fkulsD; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 51BBCC8F473;
	Fri, 29 Aug 2025 16:29:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AD79D605F1;
	Fri, 29 Aug 2025 16:29:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 49B821C22DB2E;
	Fri, 29 Aug 2025 18:29:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756484994; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=fYBSTx5Yv8g5Uib1uT5+nAf3T9cNxeyce5RqsqKnN0o=;
	b=J3fkulsDLvPuAHZxcwgTDQbisnHKcpFIwk0yfl7sM+R3FDVaAL54q7R/fp/NiApJKQRxQd
	diCrYZCOsXq6Uun6WKRROyM6R2564T5STtP7Xuf7p2jdfLXA0oQ15398t1YSYtdgJEndxR
	cY/VLFZEgk8O9SjynNItMPG5dcMG4ZO7iJ2ZabLdWc+Nt7wEOBrQF51J9gD2wy4oSjne+9
	oB/Df3Y4Dem+muI5kG6rvFVT19Wsf6Ux6cf7ts51y5RACw12keN5cLz7ckScv/1v8jm7VO
	8uQCcNJUwr7VTuO37A+7jk6+MQNySixn7UXSOgW7BOVgRe95oMcFhGEm2N3uHQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v2 0/4] net: pse-pd: pd692x0: Add permanent
 configuration management support
Date: Fri, 29 Aug 2025 18:28:42 +0200
Message-Id: <20250829-feature_poe_permanent_conf-v2-0-8bb6f073ec23@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADrVsWgC/32NwQrCMBBEf6Xs2UgSo6gn/0NKicnGLthNSWKpl
 P67od49zOExw7wFMibCDNdmgYQTZYpcQe8acL3lJwrylUFLfZRndRABbXkn7MZYg2mwjFw6Fzk
 IdCcjvXWogoZ6MCYMNG/nd2AsgnEu0Namp1xi+mzWSW39T6D1P8GkhBTeeaP0pc6Nvz1iLC/iv
 YsDtOu6fgFCsQFs0AAAAA==
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: kernel@pengutronix.de, Dent Project <dentproject@linuxfoundation.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 linux-doc@vger.kernel.org, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-Last-TLS-Session-Version: TLSv1.3

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch series adds support for saving and resetting the PD692x0
device's permanent configuration through driver devlink param attributes:
PD692X0_DEVLINK_PARAM_ID_SAVE_CONF and PD692X0_DEVLINK_PARAM_ID_RESET_CONF.

The permanent configuration allows settings to persist across device
resets and power cycles, providing better control over PSE behavior
in production environments.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
---
Changes in v2:
- Move from sysfs interface to devlink interface for the permanent
  configuration support
- Remove the __free macro from pd692x0 driver following net policy.
- Link to v1: https://lore.kernel.org/r/20250822-feature_poe_permanent_conf-v1-0-dcd41290254d@bootlin.com

---
Kory Maincent (4):
      net: pse-pd: pd692x0: Replace __free macro with explicit kfree calls
      net: pse-pd: pd692x0: Separate configuration parsing from hardware setup
      docs: devlink: Sort table of contents alphabetically
      net: pse-pd: pd692x0: Add devlink interface for configuration save/reset

 Documentation/networking/devlink/index.rst   |  21 +-
 Documentation/networking/devlink/pd692x0.rst |  32 +++
 drivers/net/pse-pd/pd692x0.c                 | 325 +++++++++++++++++++++++----
 3 files changed, 325 insertions(+), 53 deletions(-)
---
base-commit: 01a8d87c13cc9ccd3692d3e750075a772b3626da
change-id: 20250813-feature_poe_permanent_conf-ec640dace1f2

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


