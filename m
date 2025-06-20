Return-Path: <netdev+bounces-199743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6F1AE1B01
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 14:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2BA04A794D
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18EB28B7C6;
	Fri, 20 Jun 2025 12:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bzVI3fgB"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78509221FC0;
	Fri, 20 Jun 2025 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750422803; cv=none; b=Ca6P+70ZAzWaWYXknkgcoAq5skj0dRKShEZuWXlghIyQ1HKEbgGFBPKUCqztTMd9vbE8OkgB8qeQ/Pi+FiXFgLNcmSFouWlPFNBnnLz8mdWnOPk37ZpJAEbmmx0cQeM13igE1HZUhei42LBovlHmZsk8YXzlDm3I7gLM1ilwrTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750422803; c=relaxed/simple;
	bh=DaGgyoq4tptnaaMFKQ5NAr1kA6WiOSlnJM6CJ4wUsz0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gJ+bVN8Y3exJfNOLXP+KVsi0yf4f8TjYpW3fzhl7Xp7+FLNk+3Ig5O7p6itZEnVQ4t1yPcyt5L3nVGqKhzVM9cIAMqQzHTZNlSLf04ivjaEpS5JJFGl6fs6xXHvvUjazr1yfqRx8Wswp8xW8ksfldE/4P7YTW1gLrWCDY1Yc78g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bzVI3fgB; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C0EB51FD3B;
	Fri, 20 Jun 2025 12:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750422799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0nTWKYvxlcW790wtzf4aEgMXnEq9wDwuPS3BdqPXpms=;
	b=bzVI3fgBtk/4M0taOrX2MmN8vxYXjkqdVLqs0XdmXB5/F5yK0tX7pj1MqqXTnthypSg4/F
	4712mYfUb+ZktLTOOx99CpoN4dOZjcrBx2Lx37Fj5EsXTCkwra/y7K34dKWk3OXgzT1xSf
	NQFLn2VuKdzYkZCOKu3E+QP741rpVNaYbSEhVMefO7hLwMET/R8TBU9lNou+5vFZ99SgEZ
	nBbGa1HAj1aTEvdw3gcqxKqmjxEK4/lk+5APH8ZbG8ZF2kSnk64chRLbro3kMgCvXH68Hd
	gzrvFDW4YyKj03IpVK0tRGIAI2WwE/UB/+0xMqREPYK6qOfJ3jfwgKiCOdJH/Q==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH ethtool-next 0/2] Add support for PSE priority feature.
Date: Fri, 20 Jun 2025 14:33:05 +0200
Message-Id: <20250620-b4-feature_poe_pw_budget-v1-0-0bdb7d2b9c8f@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAFVVWgC/x2MwQqDMBAFf0X23IUYYin9lVIk6osulESS1Qriv
 zf0MIc5zJxUkAWFns1JGbsUSbFKe2toXHycwTJVJ2usa61xPDgO8Lpl9GuqfPthm2YoGw887ta
 Fseuo5mtGkOO/fhF00ZQ+HHEova/rB65O5794AAAA
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>
Cc: Kyle Swenson <kyle.swenson@est.tech>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekgeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthekredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedugefgudfftefhtdeghedtieeiueevleeludeiieetjeekteehleehfeetuefggeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehkhihlvgdrshifvghnshhonhesvghsthdrthgvtghhpdhrtghpthhtoheprghnughrv
 gifsehluhhnnhdrtghhpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehmkhhusggvtggvkhesshhushgvrdgtii
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Add support for PSE (Power Sourcing Equipment) priority management and
event monitoring capabilities.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (2):
      update UAPI header copies
      ethtool: pse-pd: Add PSE priority and event monitoring support

 ethtool.8.in                           |  13 ++++
 ethtool.c                              |   1 +
 netlink/monitor.c                      |   8 ++
 netlink/netlink.h                      |   1 +
 netlink/pse-pd.c                       |  88 ++++++++++++++++++++++
 uapi/linux/ethtool.h                   | 134 +++++++++++++++++----------------
 uapi/linux/ethtool_netlink_generated.h |  59 +++++++++++++--
 uapi/linux/if_link.h                   |  16 ++++
 8 files changed, 250 insertions(+), 70 deletions(-)
---
base-commit: 64226907d0d6734bef5098eb343fd2194cd140e2
change-id: 20241204-b4-feature_poe_pw_budget-0aee8624fc55

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


