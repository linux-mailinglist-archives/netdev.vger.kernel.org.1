Return-Path: <netdev+bounces-190337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B054AB64D4
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB87176120
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 07:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D12520B1FC;
	Wed, 14 May 2025 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H1u1UPG0"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95481F30C3;
	Wed, 14 May 2025 07:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747209014; cv=none; b=W+Lrr1YTuoLESsd5x20FjURfj28PKd3EPOW3no/KsDwcvIt8aQmBGxMJTrdN/I7bHrsfr3wh9E5FqtoKi48ncXXP9CBlqNxx47uhzuM6+29yXz8WZ5tpURHdyPjlvjBg6s0eLmWIMjtSu4gQEHuLhNte9GhITIpi1xUAn5nWPts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747209014; c=relaxed/simple;
	bh=+5oOGwpowz/X7zHkO0L67buoUYgiwxkv68nZ43WUEOk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d9bWd5lh2MTvozUOrAx6Z525G7+tmeh5t2jQcIm0HrBqRb4uBXyAuQO58uNJJYjaskV7aFS9gYPIHAqtsMYJiUDkT87GKnJeTMDgtM7l0WiRWOSb+u7VNxqWqd8stRwdRaAgbkk3zTM9wSztGrfgWstkC43yTWY6pb4oTogKUTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=H1u1UPG0; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6DE51439C5;
	Wed, 14 May 2025 07:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747209010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ArkRQAzqeuFfmh98LSaODok3mtKen4dhTOKh2DmU01w=;
	b=H1u1UPG0tLpArroM327U2QK3w4gdvsNvNofVhap+GNr5HI8b9dDTJ9+9R2KSbREaZWz7RE
	y47S9rffuA5SnCsPoUXbD3diqCf8Am68DMFxLrTqiPeFFpS818Et4n9waHl0FORNftidxg
	3Aa9AaNfRL9ikM528Fj1qON7ZiuQQAO1S4Bs7thQ0SiZgfy0MBxXt9qbaDdcbIhtqJLBqG
	0yTam+g+Zpm6bnaGvFw382o7WaNYIzjtq75FO6QcdDMxqGHk+CVipQaKOGjGbySW+I3CC5
	OEhiZc1KbK/CBIXJv07Zed/37bHuFo0tijX+PY6bR0lRwQSGm7NBbkG/CRIcbA==
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next 0/3] net: phy: dp83869: Support 1Gbps fiber SFP
 modules
Date: Wed, 14 May 2025 09:49:56 +0200
Message-Id: <20250514-dp83869-1000basex-v1-0-1bdb3c9c3d63@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACVLJGgC/x3MQQqAIBBA0avErBsYS6O6SrSwnGo2FhohSHdPW
 r7F/xkiB+EIY5Uh8CNRTl+g6grWw/qdUVwxNNQYMqpFd/Vt3w2oiGixkRNqp0kba7XqVijdFXi
 T9D8n8Hyj53TD/L4ftSIl4W0AAAA=
X-Change-ID: 20250513-dp83869-1000basex-4d4045aa416c
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeigeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheptfhomhgrihhnucfirghnthhoihhsuceorhhomhgrihhnrdhgrghnthhoihhssegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekgeeggeehffeufeeivefffeelueeigeevjefhieduleekgeelleegudevfeekueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudefngdpmhgrihhlfhhrohhmpehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvl
 hdrohhrghdprhgtphhtthhopehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: romain.gantois@bootlin.com

Hello everyone,

This is version one of my series which adds support for downstream
1000Base-X SFP modules in the DP83869 PHY driver. It depends on the
following series from Maxime Chevallier, which introduces an ethernet port
representation and simplifies SFP support in PHY drivers:

https://lore.kernel.org/all/20250507135331.76021-1-maxime.chevallier@bootlin.com/

The DP83869 PHY supports a variety of different operational modes,
including RGMII-to-1000Base-X, which allows it to interface an
RGMII-capable MAC with a fiber SFP module.

RGMII-to-100Base-FX and RGMII-to-SGMII modes are also supported by the
DP83869, which makes it possible to support 100Mbps fiber modules and
copper modules. However, this series focuses on 1Gbps fiber modules as a
first step.

The first two patches in this series do some preliminary groundwork so that
the DP83869 can function properly in RGMII-to-1000Base-X mode. These
definitely toe the line between fixes and new features, but since the
targeted behaviors have never been implemented in the DP83869 driver, I've
decided to include them here. Please let me know if you disagree with this.

Best Regards,

Romain

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
Romain Gantois (3):
      net: phy: dp83869: Restart PHY when configuring mode
      net: phy: dp83869: ensure FORCE_LINK_GOOD is cleared
      net: phy: dp83869: Support 1000Base-X SFP modules

 drivers/net/phy/dp83869.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
---
base-commit: 5b6d59102462301b7ad256b1213964044d3fb50f
change-id: 20250513-dp83869-1000basex-4d4045aa416c

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


