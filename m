Return-Path: <netdev+bounces-293614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COeEE7hGHWpbXwkAu9opvQ
	(envelope-from <netdev+bounces-293614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 10:45:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CA061BB08
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 10:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65860302B80B
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 08:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BEB3890F8;
	Mon,  1 Jun 2026 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pq+e2udQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2002B388876;
	Mon,  1 Jun 2026 08:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780303240; cv=none; b=I/qy7SIkV+anWizQkZWqXk9mHPAbVXBtcn/fcwy1yKzMmt+M4tNuIiYfRGm0owYhT34Md8SFL6Z6a+BhkbBE2casC55ZDlw7j0oikaXYjHmdcIuAZMXq18PlZLkb+n+ND9Q2+BiFk80XYXavtoKsIzOch+GmduR+t3uwyWplRu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780303240; c=relaxed/simple;
	bh=DDKD2SJwhyqWOtCckBH8XOrfrqw8hA5OvRQwJ5q76k0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MLFbAccLvmLqfT6VkYlyWNHZsOn6WiEZQQY1F6ifZi9UL0lPI7CMZ6i2Gr6itKyBxOCbOrcD4iKECozWTF/P32KN7xR/PCMrFF8ArcB0LZQJfpLUVVxpunmS+hqBsxheTpNoOYVc4v4lfWAXjidbYx1ElfHf8hvZ7HQukBYoYZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pq+e2udQ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 506EB4E42DD0;
	Mon,  1 Jun 2026 08:40:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 23F02602AB;
	Mon,  1 Jun 2026 08:40:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9DD7110888076;
	Mon,  1 Jun 2026 10:40:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780303233; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=pjuI4AEx5LMUF9kRBIZE3sijXPwdpHTr+4agvyYrasE=;
	b=pq+e2udQuEBuEB6+QrWHvEDeFhEo3qKYdKIijAVSZl3VwRp5o5W+9/LHdv+nFe9UCQeaYw
	iAVz5fGh9Fxdflu/NNwOEcMGup5jgFu2lHe4K6lhSn7he3rmOGbKBQs3H+iwvlExhmSeE5
	wmSnImlYJAi3zOts+KrFRhL4gSHOUCG1w8FTXTO0+kRk6q42osm2zFXOzoalplyUYvEqqD
	zNISQgSrDnIzF3qWYH8XtPOR0sQnakUCeXuosvktTml6oJm2K3AYW98wgjbCcY5Km7RWWe
	F/60I7Jux/BtuHYXHLrIATO5E6caFSxjBGteFQq3wNvLsPlEFk/f8UJa8nvf6w==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com
Subject: [PATCH net v2 0/3] net: phy: some cleanups following phy_port SFP
Date: Mon,  1 Jun 2026 10:40:25 +0200
Message-ID: <20260601084029.815461-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293614-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: C0CA061BB08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

While posting the v11 of phy_port netlink, sashiko found some
pre-existing issues, and following the tentative fix [1], Nicolai found
some more :)

Patch 1 and 2 add some cleanup in the phy_probe error paths, to discard
all SFP and phy_port that have been set-up when probing fails further
down the road.

Patch 3 fixes a sashiko-reported issue that I was able to reproduce,
where we hit a deadlock when trying to setup PHY-driven SFP ports while
using genphy. This is because the sfp init logic for PHYs is now
generic, instead of per-driver, and genphy has the particularity of
running its .probe() under RTNL, which clashes with the SFP code.

One more reason to try and cleanup RTNL handling in PHY/SFP :)

Thanks Nicolai for the feedback on V1,

Maxime

[1] : https://lore.kernel.org/r/20260530072706.3167745-1-maxime.chevallier@bootlin.com

Maxime Chevallier (3):
  net: phy: clean the sfp upstream if phy probing fails
  net: phy: remove phy ports upon probe failure
  net: phy: don't try to setup PHY-driven SFP cages when using genphy

 drivers/net/phy/phy_device.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

-- 
2.54.0


