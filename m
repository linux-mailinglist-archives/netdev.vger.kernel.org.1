Return-Path: <netdev+bounces-105378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80028910E74
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 19:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D64B25E5D
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 17:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4565C1AD3E9;
	Thu, 20 Jun 2024 17:26:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from orthanc.universe-factory.net (orthanc.universe-factory.net [104.238.176.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FAB1B3F10;
	Thu, 20 Jun 2024 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.238.176.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904390; cv=none; b=c43Zwyr91lJjllE+aS0ZHeCyhymT97io3nQucG/z2Ebgbr/koi1LJc2fshSQEKd6kAvXul/MhJc5UkfqD5/4bilQ6H8DRi2h30nEMm47uhWczLtF4UK0vACV8ZcEKr2XinKn0RMIWNker8Mjs6jWgPWmzKRg35l8OA0saQEW7BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904390; c=relaxed/simple;
	bh=CZj8lmI9RkVc2iaMKGFU/ruBchughOgN/7iqWvVTWz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OiqCJknFOMeNRGdE/VyxM7x/8iYFPMKMddyJXJXXFTehz/tDmMIdFJT0IICdcJR++F8SwLlyGmLxE8TVnpXHrjoXb3YDsbbs1gimN8o0/1dNG2bzkiyNaJweLI9uIGd/ScRSGJQFUuvSudTUbdCGq51rKFLCSHoCu93c5S1VX3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=universe-factory.net; spf=pass smtp.mailfrom=universe-factory.net; arc=none smtp.client-ip=104.238.176.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=universe-factory.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=universe-factory.net
Received: from avalon.fritz.box (unknown [IPv6:2001:19f0:6c01:100::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by orthanc.universe-factory.net (Postfix) with ESMTPSA id EB6071FC32;
	Thu, 20 Jun 2024 19:26:20 +0200 (CEST)
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <mschiffer@universe-factory.net>
Subject: [PATCH net-next 0/3] net: dsa: qca8k: cleanup and port isolation
Date: Thu, 20 Jun 2024 19:25:47 +0200
Message-ID: <cover.1718899575.git.mschiffer@universe-factory.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A small cleanup patch, and basically the same changes that were just
accepted for mt7530 to implement port isolation.

Matthias Schiffer (3):
  net: dsa: qca8k: do not write port mask twice in bridge join/leave
  net: dsa: qca8k: factor out bridge join/leave logic
  net: dsa: qca8k: add support for bridge port isolation

 drivers/net/dsa/qca/qca8k-common.c | 118 +++++++++++++++++------------
 drivers/net/dsa/qca/qca8k.h        |   1 +
 2 files changed, 70 insertions(+), 49 deletions(-)

-- 
2.45.2


