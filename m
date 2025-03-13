Return-Path: <netdev+bounces-174639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F622A5FA0B
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 16:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766FA19C6914
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 15:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395A7268FDA;
	Thu, 13 Mar 2025 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ku4jvNcq"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F96269825;
	Thu, 13 Mar 2025 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879827; cv=none; b=QKf2FFfnL6ttJur52OgujdZhm2FEBVHuMs+yR0ta3JmSB891pD3xUXTrYe/maU+0X/rGiWZyRCA8jA1ISriUaGquIv0tFJQ/rtyJekdRJ5HJzq72kTo+AkvIwNBMmn9AXD1wXTbAWPo3vhMP/BaZ68i4Wph0qQmUzdpi7+I+c8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879827; c=relaxed/simple;
	bh=T2noBBiCzd0gH9aLN6XsHXL1NLRMPMuCP8lCMYKmBtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BBGBFCQ+cCDreMF4T9notdNcSMH5WtSWrP1mGw8YFBoOgLzw7fI7mrQkZatuZNugHZe1gUqCszwvxLhoO+kK4JFHNNwXYxhHnUhoxJMKRpQjzihok3Nn1+92+1Rj73IwicsnGF8hjMPK8ezIDWE4QJPDLJo9PttttT9NTAa8D3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ku4jvNcq; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0F9392047B;
	Thu, 13 Mar 2025 15:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741879823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B4YeofroQrEDujXUpBMx/SduL0E+UxUpkzIGQ94eyP0=;
	b=Ku4jvNcqqwt39YElIRDm3I0Lcq0ReUd2paFG3rDZv+/u4DAW9XwgcYkppn7dkA1kHjNLzh
	WnLQBVOvbpt4EXUwgpa4XOr6s1IaNXHn8MEorCjzXmdSkMiIv7YxQAxyNAJYWSIFRU1L2B
	eGbCq+se5vEWdhk8LstFhMmQFgE3R87KXPUInaJ/xq+e/EWeZ40JF4dnb2ayUVGqhL24Xq
	qLTA9FeV3zIDo3440SDW2BdRmRUOAgwKiFU/Q46rZrhsnGcO8ODvXb/O1uFMtQ6sGOYorP
	UGqSXnt/PMycy2kTPWCH7IuG7FfoCDAX/XU9Wga1ozwmmZPBiB4mG/+br8It6w==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next] MAINTAINERS: Add dedicated entries for phy_link_topology
Date: Thu, 13 Mar 2025 16:30:06 +0100
Message-ID: <20250313153008.112069-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephedtheeufeeutdekudelfedvfefgieduveetveeuhffgffekkeehueffueehhfeunecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdqvddrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmr
 giivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

The infrastructure to handle multi-phy devices is fairly standalone.
Add myself as maintainer for that part as well as the netlink uAPI
that exposes it.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ffbcd072fb14..7d878c62e67d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16491,6 +16491,13 @@ F:	net/ethtool/mm.c
 F:	tools/testing/selftests/drivers/net/hw/ethtool_mm.sh
 K:	ethtool_mm
 
+NETWORKING [ETHTOOL PHY TOPOLOGY]
+M:	Maxime Chevallier <maxime.chevallier@bootlin.com>
+F:	Documentation/networking/phy-link-topology.rst
+F:	drivers/net/phy/phy_link_topology.c
+F:	include/linux/phy_link_topology.h
+F:	net/ethtool/phy.c
+
 NETWORKING [GENERAL]
 M:	"David S. Miller" <davem@davemloft.net>
 M:	Eric Dumazet <edumazet@google.com>
-- 
2.48.1


