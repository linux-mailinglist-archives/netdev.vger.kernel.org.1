Return-Path: <netdev+bounces-234677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 653F9C2602F
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1229E351780
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 16:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EA42F619F;
	Fri, 31 Oct 2025 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MZfkb0Wc"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC3A2F6184;
	Fri, 31 Oct 2025 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926749; cv=none; b=uxjlBFFixiUGtzqhXnsKvyR9TWG7XWwNZSSmGivsHSbszD1Qj5TqXrCu8s4m2iKQU5vLiB/ICCQESDit4RsS5odsBqpA5o9fPYzBcBgBqwXCkd+YS/ekUQQVdaT8KVn6VydzdX8HmCn+TYs4uUqlhy/iSw8+JwT4g86R+0MbEW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926749; c=relaxed/simple;
	bh=LEr3x9tuS8yTEFBK3IKGOXgNrYsYHrFbpXnESMfGzLI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ph4XM2+kjhwEpD0u9bo8Z7LnFbvZvRfI3iBJypArqNsqhtMCV2C/YpeObDOzY0pdFtu7JYkZf61JBRgKE0f00PDkWvYGjgKetXnIT0VxLGBtf4zQSLWKlNwdMDLA3q+V7OUSo+ZWp65MuU4+IklwrDNmfwNTWhr7f7TFHIgVVQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MZfkb0Wc; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 075564E41442;
	Fri, 31 Oct 2025 16:05:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C0CF060704;
	Fri, 31 Oct 2025 16:05:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2657911818067;
	Fri, 31 Oct 2025 17:05:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761926743; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=OPazbeDRT0Q5f0epnk2G/F59cesXNh/6rt5ipUikWIo=;
	b=MZfkb0WcNcDhX9hcGZEqghVJpZ5lzSbRMMJP3pGdqVFh4ditWCfqFsT+hvHirogN/kouNG
	fC97ZueUOAVpM99gB9v/1RFYcOhJDhg4rONTvOpNTyUutEHjkh+8FizOfvWcjRN19k5Zgl
	TFat2KiRIEUtYpH8b5rAPMffp0O/HdEUQ1T4dpbt0Mre7X8ZAFGeuThxPzBdQfyYEK4FXC
	/2K2X0TpIV1EEe8qkI/nDWJHmx5r3d6BWW4UbtjtM5ZWxZIvmlRY1YjrqpQt6A3f/ztLzb
	EVnB9Yk2W/Sdu/C53t2/QJMQY+vLsiTWSZ3u+hxV5PMxlyBKUWlzlLpBd42IJw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net 0/3] net: dsa: microchip: Fix resource releases in
 error path
Date: Fri, 31 Oct 2025 17:05:37 +0100
Message-Id: <20251031-ksz-fix-v1-0-7e46de999ed1@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFHeBGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA2ND3eziKt20zArdlCRjE9OUNHMzY9M0JaDqgqJUoDDYpGilvNQSpdj
 aWgDbBj6aXgAAAA==
X-Change-ID: 20251031-ksz-fix-db345df7635f
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

I worked on adding PTP support for the KSZ8463. While doing so, I ran
into a few bugs in the resource release process that occur when things go
wrong arount IRQ initialization.

This small series fixes those bugs.

The next series, which will add the PTP support, depend on this one.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
Bastien Curutchet (Schneider Electric) (3):
      net: dsa: microchip: Fix checks on irq_find_mapping()
      net: dsa: microchip: Ensure a ksz_irq is initialized before freeing it
      net: dsa: microchip: Immediately assing IRQ numbers

 drivers/net/dsa/microchip/ksz_common.c | 14 ++++++++------
 drivers/net/dsa/microchip/ksz_ptp.c    | 17 +++++++++--------
 2 files changed, 17 insertions(+), 14 deletions(-)
---
base-commit: cd2f741f5aec1043b707070e7ea024e646262277
change-id: 20251031-ksz-fix-db345df7635f

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>


