Return-Path: <netdev+bounces-153238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD919F7503
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 07:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B79116558F
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 06:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAD52165FF;
	Thu, 19 Dec 2024 06:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YLp9oOOF"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE252165EE
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 06:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734591541; cv=none; b=ojxLjltw6AgMTD53lJ5T0PyOr2gSQZkIKA19uP/ZcNUPQ3spf9luHADy6HCzekuAqp1aetU4H2MIK3omAu+QmhRRJ5zo5baI8KBEj5XAag2oMAkohWROVxHh8Gz9tpbxE4zhcMcdn7exaLfjck6KKPZSDJeQ5bCc8/j/ZLkJHGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734591541; c=relaxed/simple;
	bh=Mb6T2zB5JQVygWpUN/LgejmP5zAoY7CYpZoeCBFq5SE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KVsyKkn0L40FUtCI2yRX2WUEXlQDo6iwzymrvbYfMKy/a2kNsTzq7JtuBOIw4o33zdk/AQJmIuqdRQ80m5+aWB4AF8Tnq7bzwJRrtL/tF5++Hq3ZEfDLvlOb4M63Ht0btapP5etOV//P2uyNN/av/ClidDmIerXo1QNn73mONS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YLp9oOOF; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734591526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9XW4h1w0OttnGxwY0XOlVjmrAVb90CHcsYw0jGSlEiE=;
	b=YLp9oOOFOMuf2jD+gIGAa1kE4Np1/1CfYNpkhOJS9rfgTIekQ0UDN2c1LOKWgR2F/Bt1Re
	374oTCd9SxL6jNidVbtWkg1ZXxIdrp8MypCA0DoeYMKvpf7seSqYIYE7Xcm/mwZxEUtGQT
	5FOsvKnzs0/FeskAL2R0cc5GhhJybys=
From: Yajun Deng <yajun.deng@linux.dev>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH net-next] net: mdio_bus: change the bus name to mdio
Date: Thu, 19 Dec 2024 14:58:55 +0800
Message-Id: <20241219065855.1377069-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since all directories under the /sys/bus are bus, we don't need to add a
bus suffix to mdio.

Change the bus name to mdio.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 drivers/net/phy/mdio_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 7e2f10182c0c..20dd59208973 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -1425,7 +1425,7 @@ static const struct attribute_group *mdio_bus_dev_groups[] = {
 };
 
 const struct bus_type mdio_bus_type = {
-	.name		= "mdio_bus",
+	.name		= "mdio",
 	.dev_groups	= mdio_bus_dev_groups,
 	.match		= mdio_bus_match,
 	.uevent		= mdio_uevent,
-- 
2.25.1


