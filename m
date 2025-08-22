Return-Path: <netdev+bounces-216081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E68B31F9E
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 17:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235F73B0D87
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 15:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5E123D7C1;
	Fri, 22 Aug 2025 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nXnlOgEh"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AB1255F27;
	Fri, 22 Aug 2025 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755877079; cv=none; b=U1b6p9THowpNIc+aQv9Cyk+3eJTIsuNDHZXXPnxwo5JCVgeoQkHIMzpRutXFx/ZbRi9B1v4nUVLBTFGJYTQbBc3IkLPWJUfo66u8JO7rfn4ykyXYZNEK9zHt+KlIBdjGMZuJyGKzq7I0j+W8ayg+s8UQLjM72I6xcGYPaCvEtkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755877079; c=relaxed/simple;
	bh=uSDz0yKbW29Kqi+kh8DILfeymb7IOfkqZihSGlvm7og=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nrX4kSu7Y/E8/F+ESMTS30mMFvTZt95UxJYQKchNhy5glHiduo2Eu29a4NBgYnn2jhCZ8/JUU1CjRdP1tUakAPMNOy8mXgm/Nw5ak7GVFg3Gbf2z8DlE63l1KeAkDf2HabAojFtXBmoYyN/qlu0LODgmlVLl6wDL2nvuazC3RcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nXnlOgEh; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 840BE1A0C7D;
	Fri, 22 Aug 2025 15:37:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5D541604AD;
	Fri, 22 Aug 2025 15:37:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 15DF61C22D750;
	Fri, 22 Aug 2025 17:37:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755877072; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=vL6SrPv3s4tTvpqu8dd2Y1q408FTzzYF7Ub5PJS8YhE=;
	b=nXnlOgEh0bh2bNUup3nmDKXLrqgFtrINTl3DU4jsEkiPmbHvjxNavZMP/KdtwYbg1HQJlg
	gyp6rZcYK/j605g0Zp1B9YU6ca6AIF8waBv+1MttReNAflFChlO/gOKjBm3VAqisH6X/DP
	I7jbLyi1hUZfRWi3vnspulAi4soVTbkq97Y71OP3T+fx9NqhNZLsN7uPrb0TuK03Ufcoo7
	xhvocetCeRg/+or2ChXBMwnfRL9lbqvjWHv4Wo8nyEFT6cV2VsLPKY6fK3YvWCKPu41bpQ
	arIeUOPpGhYfohMMo6PT5GdZrFZiv8Mxyt9RcxqVEKsHg7WAqqHSGZ2sVX6AgQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next 0/2] net: pse-pd: pd692x0: Add permanent
 configuration management support
Date: Fri, 22 Aug 2025 17:37:00 +0200
Message-Id: <20250822-feature_poe_permanent_conf-v1-0-dcd41290254d@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJyOqGgC/x3MQQqDMBBG4avIrBtIUivSq5QiIf6ps3Aik7QI4
 t0bXLzFt3kHFSij0LM7SPHjwlka3K2juAT5wPDcTN76hx3d3SSE+lVMW25B1yCQOsUsySAOvZ1
 DhEue2mBTJN6v+YsE1Qj2Su/z/APP+hlsdgAAAA==
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: kernel@pengutronix.de, Dent Project <dentproject@linuxfoundation.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-Last-TLS-Session-Version: TLSv1.3

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch series adds support for saving and resetting the PD692x0
device's permanent configuration through new sysfs attributes:
save_conf and reset_conf.

The permanent configuration allows settings to persist across device
resets and power cycles, providing better control over PSE behavior
in production environments.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
---
Kory Maincent (2):
      net: pse-pd: pd692x0: Separate configuration parsing from hardware setup
      net: pse-pd: pd692x0: Add sysfs interface for configuration save/reset

 drivers/net/pse-pd/pd692x0.c | 262 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 221 insertions(+), 41 deletions(-)
---
base-commit: 02ccf77ea7d93268e52b4ea31f5538874bca5ac1
change-id: 20250813-feature_poe_permanent_conf-ec640dace1f2

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


