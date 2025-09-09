Return-Path: <netdev+bounces-221216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C613B4FC5E
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7644E34AE
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3A733CE90;
	Tue,  9 Sep 2025 13:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ny5luSKz"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8E431C59C
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 13:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424126; cv=none; b=E1rG6GM9caCoqUZkKoTx5RPKidLq9RPtfP4gXx0KxSwg94iDKKgNOsMP6greLJQ6WXVSn9/oVtsfQwRpl+t5TqvWxTRVPl+inxJBgNr2vlsOZGbnZgpaPhU5AEWZ1cU1M7MfMZ2/HCGlstfz7AqjlLGJPuKchobgibawO84sVPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424126; c=relaxed/simple;
	bh=tKbw9+9TF7pYl5uEZwolNfYlJ+3ACNEmgPvOsSGk73c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TChnQ8dI3Lfcxtlz3mYaJkHImLQnDg0azH51UY/Wf+RLLeijmTaFacZkvBL8vTFt8QZqUY5KTaG8sF+YVvrTbcAqCsCi0ir3YWFQqDZZtgS4CXVXdRD5MHNMuN/WqQSSzpwB5MRi2HIs5ZIuEbqeZh/JdW4KlHjFaZa3Ezej8tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ny5luSKz; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8BDC7C6B39C;
	Tue,  9 Sep 2025 13:21:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2A89760630;
	Tue,  9 Sep 2025 13:22:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3BC7D102F1D42;
	Tue,  9 Sep 2025 15:22:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757424120; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=qlQm4Uqrg5cNEG78At7VfBrU9Z1kHsNamidbkl28UHc=;
	b=ny5luSKzgj4VLYog8D4jM3HNdMLxKaQIlKPxaCdQg7Q8JZi/jUu0v3hfdZFpWCT+UjlB94
	cItL7mRvZUnxSLKp9ZEMKwjPXmZKxohLTAZmRxB+4MuBf1Md4ZzqyvH8LsGJTRUZ72s/2B
	EyOGR4ksLktG8ifqARDQqUJhsCQOflCAdQdB5P/NnRZul9pm04fJNibmYhp22tEhFzr0c5
	7iu0Oa9xdDha8VOic2X0XM8vIny2eBoFnt1qHVOUPm7CpB6+zp4baUAhNoICRHKV2PTxxz
	1h/iLVg3cyVFf0XCiBbfS6MNzVpmU5N7XGQBRvzKIi6EsFvl4BWbsfR59DJlyw==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH iproute2-next 0/2] Add uapi header import script
Date: Tue, 09 Sep 2025 15:21:41 +0200
Message-Id: <20250909-feature_uapi_import-v1-0-50269539ff8a@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOUpwGgC/x3MwQoCIRRG4VcZ7jrBbILsVSIGzd+6i1SuGgPDv
 Hsyy29xzkYVwqh0nzYS/LhyTgPn00Svj0tvKA7DZLS5aqutinCtC5buCi/8LVmauvngXcAcvb3
 QKIsg8npcH8RFcm8wKmFt9Nz3P/IdIMh0AAAA
To: David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-Last-TLS-Session-Version: TLSv1.3

Add a script to automate importing Linux UAPI headers from kernel source.
The script handles dependency resolution and creates a commit with proper
attribution, similar to the ethtool project approach.

Run the script and import the current state of Linux UAPI header from
net-next.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (2):
      scripts: Add uapi header import script
      Update kernel headers

 include/uapi/linux/devlink.h |  2 ++
 include/uapi/linux/if_link.h |  1 +
 include/uapi/linux/stddef.h  |  1 -
 scripts/iproute2-import-uapi | 67 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+), 1 deletion(-)
---
base-commit: 68ba2bc6e2d060526496bc79591b09fcbc851a7f
change-id: 20250909-feature_uapi_import-8bdbade4fb93

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


