Return-Path: <netdev+bounces-127751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4598D976559
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 11:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0EC2824D3
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 09:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D38F192B68;
	Thu, 12 Sep 2024 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WUD6cBZG"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E456F2FD;
	Thu, 12 Sep 2024 09:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726132818; cv=none; b=N7G3MrHbH3OwH46cq0MCGaW/bkXo1WWGnvxgW4r9/3a8QGFxFvMjkBBTCxCh1AfVNG3LQNPg2A0Jn2Op4BexFq50QiJQyzzQPZGMJ6LOsRL3GYjzt2ewkd+07ObXRHWAWUWxICmLMAu++vcCmQ/Fx9ut4LoTPplwrtvJagQewjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726132818; c=relaxed/simple;
	bh=ixDQDSYn5XdKlp7TbARmjigi+U/yIIjKrRNMCywRqcc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i8UNE5P+hfuif65QGpDQCuEUJ+YsKqKOp1icDKhlp2MYAnHgOZxoIeAaqHXaTohWMLh50VlJGY4G+MNEb9W2GxQSIPoVX2XHPajZFIwTgJ0JGWbD7grA8bP6pU67HabVyuIjos6usxOOLDQ2Q7/E2kvUgIf7utdfHjJiiE+ulPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WUD6cBZG; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A69022000B;
	Thu, 12 Sep 2024 09:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726132814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h+elj3W9YKoXNyFIawxDOxHKXVZOZw56WclS+4C8ADc=;
	b=WUD6cBZGuRR9EzMgMBlGqptvu/BFv43AzyxikJ0vTqlubxuIR4bMIwZbe8+1JjXpvfpWpN
	VFh2cB47FPcZomxv3HwUosLcHmpHpwImOc9oFddHPPfF/8hCtmAhbIhoFpvtWWinVtsAWx
	DluO+I7zYI4tf1nAEo7J3vfMduF+EQ9deGrSi5kCRaJ52WYCYDE3ULmSyPA2EXztJSHnnK
	sw/BM76AO8HAgp0fnUctMEOLb7VjrGBz/W68F57D5RlhCwrVol+0ipOCQI+suBZ4803TkI
	nWamKQEp+aE+sHKtNQNH2xDBJJ2DENMFN+1Ym+cyvTjFqgalGM+u2H14nx0fZA==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH ethtool-next 0/3] Add support for new features in C33 PSE
Date: Thu, 12 Sep 2024 11:20:01 +0200
Message-Id: <20240912-feature_poe_power_cap-v1-0-499e3dd996d7@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEKy4mYC/x2MQQrCMBQFr1L+2kBMtaFeRUqJzav9IEn4ibZQe
 neji1nMYmanDGFkujU7CT6cOYYq51ND0+LCE4p9dTLaXLTVvZrhylswpvhjhYyTS+raPXxvO+9
 Na6m2STDz9v/eCWUpMb5UwFZoOI4v6EBC5HUAAAA=
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>
Cc: Kyle Swenson <kyle.swenson@est.tech>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This series adds support for several new features to the C33 PSE commands:
- Get the Class negotiated between the Powered Device and the PSE
- Get Extended state and substate
- Get the Actual power
- Configure the power limit
- Get the Power limit ranges available

It also updates the manual accordingly.

Example:
$ ethtool --set-pse eth1 c33-pse-avail-pw-limit 18000
$ ethtool --show-pse eth1
PSE attributes for eth1:
Clause 33 PSE Admin State: enabled
Clause 33 PSE Power Detection Status: disabled
Clause 33 PSE Extended State: Group of mr_mps_valid states
Clause 33 PSE Extended Substate: Port is not connected
Clause 33 PSE Available Power Limit: 18000
Clause 33 PSE Power Limit Ranges:
        range:
                min 15000
                max 18100
        range:
                min 30000
                max 38000
        range:
                min 60000
                max 65000
        range:
                min 90000
                max 97500

This series requisites the c33 PSE documentation support patch sent
mainline:
https://lore.kernel.org/r/20240911-fix_missing_doc-v2-1-e2eade6886b9@bootlin.com

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (3):
      ethtool: pse-pd: Expand C33 PSE with several new features
      ethtool.8: Fix small documentation nit
      ethtool.8: Add documentation for new C33 PSE features

 ethtool.8.in     |  37 +++++++-
 netlink/pse-pd.c | 275 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 311 insertions(+), 1 deletion(-)
---
base-commit: 1675c9c8df2e13c2c800ef4d86cfc5a37ddeaa3e
change-id: 20240709-feature_poe_power_cap-56bd976dd237

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


