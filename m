Return-Path: <netdev+bounces-195719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8608AD2128
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 16:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47693AB46C
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 14:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4887525A351;
	Mon,  9 Jun 2025 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pyGuTSDf"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7761C25D54A
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749480026; cv=none; b=iE4JPrJynfuwMpyjGKtPMu7QdOTU4nqSZilouuxFQr1vVwhBazYnMnQXtQ4H6L5kgAjyXjz3PWFFhnao1NwWvWfU2kExiKpVGwvJ7oUgRjvoXvGWgP38pe6nL6NUxqGxTauWtDLAdvgW8TwTkb2CRT8fa6rv+MoNQxMNy9D8isk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749480026; c=relaxed/simple;
	bh=xZWJ7DeAB8U98hOrncXa2h5Zd9gSYSnW04hRz1dwWwU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=Yjn8HaSEgYqtbyYCGyVak7l8pMI5IlxoFQrcLhHMetONKqerG5EEQW63QPsSvBjh/saxCxqaDGIwTciHS920bR0RHcuFcrjYPEbWFEkzkbMjahBijZEQ0RIZt3fLK8mUmVoRT7dS7zZtPQgHmsqGr3tZsnCoJtfUYXUfhDFCuX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pyGuTSDf; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250609144014euoutp01fdf289df7b6aa595cf1e038ab8c7d73b~HZs3o8TTO0373303733euoutp01F
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 14:40:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250609144014euoutp01fdf289df7b6aa595cf1e038ab8c7d73b~HZs3o8TTO0373303733euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749480014;
	bh=yQiQtkLtTYnohEeuNL15/EQgRaVP0IhcScwxaKjceVo=;
	h=From:To:Cc:Subject:Date:References:From;
	b=pyGuTSDfMHWISE0AoH9YdoA2F1X/6phzfGJkJ9YXxjdQL3RsD8T6OFUHsgGloc76N
	 qeIZu4BmRGj94VNxOfPGI3SlfJ0JYcNBxKLGwKxChyIEGASUnfApM7fkPmQXCJUmwj
	 JBRGjgbbCgZsDqHyhU0FwxhoPcBLCMkc0zd57A8M=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250609144014eucas1p2ee94d7aabff15fbadcc1af1fa64ce22d~HZs3HC4Mz1655216552eucas1p2Y;
	Mon,  9 Jun 2025 14:40:14 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250609144013eusmtip2e77257db9bb7dc1bdfcb3b29d3b95e17~HZs2z_Erh2757727577eusmtip24;
	Mon,  9 Jun 2025 14:40:13 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: andrew@lunn.ch
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
	j.raczynski@samsung.com, wenjing.shan@samsung.com
Subject: [PATCH] net/mdiobus: Fix potential out-of-bounds read/write access
Date: Mon,  9 Jun 2025 16:37:58 +0200
Message-Id: <20250609143758.1407718-1-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250609144014eucas1p2ee94d7aabff15fbadcc1af1fa64ce22d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250609144014eucas1p2ee94d7aabff15fbadcc1af1fa64ce22d
X-EPHeader: CA
X-CMS-RootMailID: 20250609144014eucas1p2ee94d7aabff15fbadcc1af1fa64ce22d
References: <CGME20250609144014eucas1p2ee94d7aabff15fbadcc1af1fa64ce22d@eucas1p2.samsung.com>

When using publicly available tools like 'mdio-tools' to read/write data
from/to network interface and its PHY via mdiobus, there is no verification of
parameters passed to the ioctl and it accepts any mdio address.
Currently there is support for 32 addresses in kernel via PHY_MAX_ADDR define,
but it is possible to pass higher value than that via ioctl.
While read/write operation should generally fail in this case,
mdiobus provides stats array, where wrong address may allow out-of-bounds
read/write.

Fix that by adding address verification before read/write operation.
While this excludes this access from any statistics, it improves security of
read/write operation.

Fixes: 080bb352fad00 ("net: phy: Maintain MDIO device and bus statistics")
Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
Reported-by: Wenjing Shan <wenjing.shan@samsung.com>
---
 drivers/net/phy/mdio_bus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index a6bcb0fee863..60fd0cd7cb9c 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -445,6 +445,9 @@ int __mdiobus_read(struct mii_bus *bus, int addr, u32 regnum)
 
 	lockdep_assert_held_once(&bus->mdio_lock);
 
+	if (addr >= PHY_MAX_ADDR)
+		return -ENXIO;
+
 	if (bus->read)
 		retval = bus->read(bus, addr, regnum);
 	else
@@ -474,6 +477,9 @@ int __mdiobus_write(struct mii_bus *bus, int addr, u32 regnum, u16 val)
 
 	lockdep_assert_held_once(&bus->mdio_lock);
 
+	if (addr >= PHY_MAX_ADDR)
+		return -ENXIO;
+
 	if (bus->write)
 		err = bus->write(bus, addr, regnum, val);
 	else
-- 
2.34.1


