Return-Path: <netdev+bounces-172054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAD2A501A9
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 15:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68303AF6B6
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 14:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFEC205AB0;
	Wed,  5 Mar 2025 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S7w4FCBd"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6429BC2ED;
	Wed,  5 Mar 2025 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184386; cv=none; b=tSaUIDXPR6pzyQ3iC4yKQ0/hFZFLXQqXUtLCmp7U2luG70CdBRWiCmx5EmmUItNIsOxaGULpvbJqu6RUXMAwJT7OoNlkaGxGFLai/t+/X0XCFEJMXZQZV3mCseZbx1LgKp6cpkc3cEynycQ4VgGLq3bs5TpDGKmDAZ3HdQfD6V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184386; c=relaxed/simple;
	bh=9h8JYw79AeYdd1PACJ3GnM6FZYS0z3cvnIAcFNoR+lA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uYQQwonVR+SNW3V3P0dYRW1YHjP5Xv1ziDx3o67PKdb6RhMicDP8UrHs5GCS6y8QoWwDQhCYEs7qG0991Rp271Gh8LS2ePj4I56aYn9E2Rj5mATwpxq7XXhXkzKoqLpEWr7Lv/kmmzzt6a6S1VIi97JyjzekRZqfbOcZHDpB0U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=S7w4FCBd; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 48B3B44113;
	Wed,  5 Mar 2025 14:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741184382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YY4Pp+CzXGStQ9eEENpuYpVt2ERsOCjh5tfjvgZMmCk=;
	b=S7w4FCBdwNrZeSsprQWO8JntEcQMcq0RLJjZLZf5MSJhvF7zYCuP5/sqYWfqWQXBjyhU+v
	78OpFEnsC5hD2uIqed0xkZKSHC6KNPdtlaRsbfu1ElwAPtjdkiG3kzHFJ4pyKRamZqpQKB
	FW18ZJhYra6vlFB4yNFmt8vCLSrJRTv7lc86bTZdF2ygxCBnDUC1+3ODmzAMe/hrAn1k8A
	EQqFvAjkzon8tWFnFbHXnfGYSg0Ec3iz1CLd3EsV3j36aUjkQfFr/edHkW+zL/CtH6Z/Yd
	PdTW4ElgGQRmRGgvGJHBJlkDhKx3HCHIhjNQJlnVnEvFJ+Yn9ddwef6esQup4Q==
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
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Subject: [PATCH net-next 0/7] net: ethtool: Introduce ethnl dump helpers
Date: Wed,  5 Mar 2025 15:19:30 +0100
Message-ID: <20250305141938.319282-1-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehtdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeeiueduleekjeeigeeffeelgfehvedufeejueevgeekgfdtjedtteekffffheejnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvuddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvl
 hdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi everyone,

This series adds some scaffolding into ethnl to ease the support of
DUMP operations.

As of today when using ethnl's default ops, the DUMP requests will
simply perform a GET for each netdev.

That hits limitations for commands that may return multiple messages for
a single netdev, such as :

 - RSS (listing contexts)
 - All PHY-specific commands (PLCA, PSE-PD, phy)
 - tsinfo (one item for the netdev +  one per phy)

 Commands that need a non-default DUMP support have to re-implement
 ->dumpit() themselves, which prevents using most of ethnl's internal
 circuitry.

This series therefore introduces a better support for dump operations in
ethnl.

The patches 1 and 2 introduce the support for filtered DUMPs, where an
ifindex/ifname can be passed in the request header for the DUMP
operation. This is for when we want to dump everything a netdev
supports, but without doing so for every single netdev. ethtool's
"--show-phys ethX" option for example performs a filtered dump.

Patch 3 introduces 3 new ethnl ops : 
 ->dump_start() to initialize a dump context
 ->dump_one_dev(), that can be implemented per-command to dump
 everything on a given netdev
 ->dump_done() to release the context

The default behaviour for dumps remains the same, calling the whole
->doit() path for each netdev.

Patch 4 introduces a set of ->dump_start(), ->dump_one_dev() and
->dump_done() callback implementations that can simply be plugged into
the existing commands that list objects per-phy, making the 
phy-targeting command behaviour more coherent.

Patch 5 uses that new set of helpers to rewrite the phy.c support, which
now uses the regulat ethnl_ops instead of fully custom genl ops. This
one is the hardest to review, sorry about that, I couldn't really manage
to incrementally rework that file :(

Patches 6 and 7 are where the new dump infra shines, adding per-netdev
per-phy dump support for PLCA and PSE-PD.

We could also consider converting tsinfo/tsconfig, rss and tunnels to
these new ->dump_***() operations as well, but that's out of this
series' scope.

I've tested that series with some netdevsim PHY patches that I plan to
submit (they can be found here [1]), with the refcount tracker
for net/netns enabled to make sure the lock usage is somewhat coherent.

Thanks,

Maxime

[1]: https://github.com/minimaxwell/linux/tree/mc/netdevsim-phy



Maxime Chevallier (7):
  net: ethtool: netlink: Allow per-netdevice DUMP operations
  net: ethtool: netlink: Rename ethnl_default_dump_one
  net: ethtool: netlink: Introduce command-specific dump_one_dev
  net: ethtool: netlink: Introduce per-phy DUMP helpers
  net: ethtool: phy: Convert the PHY_GET command to generic phy dump
  net: ethtool: plca: Use per-PHY DUMP operations
  net: ethtool: pse-pd: Use per-PHY DUMP operations

 net/ethtool/netlink.c | 161 ++++++++++++++------
 net/ethtool/netlink.h |  46 +++++-
 net/ethtool/phy.c     | 335 ++++++++++++------------------------------
 net/ethtool/plca.c    |  12 ++
 net/ethtool/pse-pd.c  |   6 +
 5 files changed, 277 insertions(+), 283 deletions(-)

-- 
2.48.1


