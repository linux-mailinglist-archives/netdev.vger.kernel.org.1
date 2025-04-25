Return-Path: <netdev+bounces-186069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4519FA9CF53
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 19:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98BA4E2356
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 17:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1401E7648;
	Fri, 25 Apr 2025 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fbIJ+x7N"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FDA1DEFDA;
	Fri, 25 Apr 2025 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601285; cv=none; b=X4LfT9Ia5bFCTRSZZVvXre+aaRRq4VMxkTTSjBp8O+d2ziz3gR/BK+s9nY22wkEGUht3hGmD9xEdFjVcOC3j1JV48q4vlwwNGfokCqPDls3gFD9MzKBt6ueg4vkVHdoC2QkyPa0irXIm7i+HaKcNJMw6luqnkaObc6FzmHFXUMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601285; c=relaxed/simple;
	bh=6DMIyv99NLNAyeXPbc0pWQ2kE0klBbb64BNimrX7gKw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PNZvukUutzKoZwNQwUPUCCDvxNBhZOnu3u04l/Lz9P2RYjQuY0KaJeoZ81RFyMFeAdIEIlpSIgrEW+QeCESjdu/BUbOk8joxEhNrkQHNBeoFM98OuWGbYVbLhgABmO7iL2OxxGzLdp3e4ZgzrKQ1Qb/g1O33A1N3U3zVyswmavo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fbIJ+x7N; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A5D3D439C2;
	Fri, 25 Apr 2025 17:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745601274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sSGgYViN5hTjqbMQatIXtzugVvb8WaK6qBfz4uZBEB4=;
	b=fbIJ+x7NwAzdGBRbPoOhn9DUZZ81nd1Z2jCIe2aAp55ZxfOtzr3KzcSbV+jivSLHF2Nx9J
	5Fi4JFUcDO5FFdHJdeD+cMSrz+OrAu9itI22e+IYS53JAUmfMHj1dQ53Q9KGNhWtIk2aUk
	aw+R6W1jCuPyqNoBY1RYrQQDlxOKm3dYVisJK2btd2axGBL1Jes5Goxk8bdNluC73tBLMO
	9TMZikFXomxtmVOCjL/8TBNKEY1NynYj0FXoYQy/FsU/bANBmhJEacCygNuUDHZ/Evjm9O
	bshtYQy2nsezexL/llbqRISfOgHanoXkH9ujfvacGwBNMBIoELOXGATSh9Icfg==
From: Kory Maincent <kory.maincent@bootlin.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next] netlink: specs: ethtool: Remove UAPI duplication of phy-upstream enum
Date: Fri, 25 Apr 2025 19:14:18 +0200
Message-Id: <20250425171419.947352-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvleduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgedugedvkeelhfehfeeuieeigeetgeetuedugeetuddvveffieekgfejkefgudeknecukfhppedvrgdtudemtggsudelmeekheekjeemjedutddtmeefleefugemsgegieelmegtkegstgemrgejvgelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkeehkeejmeejuddttdemfeelfegumegsgeeileemtgeksggtmegrjegvledphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtrddrpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrl
 hhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

The phy-upstream enum is already defined in the ethtool.h UAPI header
and used by the ethtool userspace tool. However, the ethtool spec does
not reference it, causing YNL to auto-generate a duplicate and redundant
enum.

Fix this by updating the spec to reference the existing UAPI enum
in ethtool.h.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Not sure if it should be sent as a fix as there is no real issue here.
---
 Documentation/netlink/specs/ethtool.yaml       | 4 +++-
 include/uapi/linux/ethtool_netlink_generated.h | 5 -----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 655d8d10fe24..c650cd3dcb80 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -89,8 +89,10 @@ definitions:
           doc: Group of short_detected states
   -
     name: phy-upstream-type
-    enum-name:
+    enum-name: phy-upstream
+    header: linux/ethtool.h
     type: enum
+    name-prefix: phy-upstream
     entries: [ mac, phy ]
   -
     name: tcp-data-split
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index fe24c3459ac0..30c8dad6214e 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -31,11 +31,6 @@ enum ethtool_header_flags {
 	ETHTOOL_FLAG_STATS = 4,
 };
 
-enum {
-	ETHTOOL_PHY_UPSTREAM_TYPE_MAC,
-	ETHTOOL_PHY_UPSTREAM_TYPE_PHY,
-};
-
 enum ethtool_tcp_data_split {
 	ETHTOOL_TCP_DATA_SPLIT_UNKNOWN,
 	ETHTOOL_TCP_DATA_SPLIT_DISABLED,
-- 
2.34.1


