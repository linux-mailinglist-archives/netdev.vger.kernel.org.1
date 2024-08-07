Return-Path: <netdev+bounces-116457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A79B94A78D
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 14:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0618A2848B9
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 12:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A83A1E4EFE;
	Wed,  7 Aug 2024 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ibR3BB3E";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="f9BZ3qtY"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB4C1E4EFB;
	Wed,  7 Aug 2024 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723032768; cv=none; b=WwqPtSEi9o7oM/hZbGeJAoqQu9Frsk3Tzfq6wre6eqDevda9wMXGaJjvhpE9K+tYeP/1v8zMS0Ny8llCh49cLUvOTMf7GU8XKdqFo57b4Pt9VArQrMWpuGFuoodDK/wBfmJLz4JrlhOloepaChV1584+19uDp/3hBh8prUQa8ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723032768; c=relaxed/simple;
	bh=wYU7aOTDXK5DGONl2s2OQcLhcVXieXn1fqP+9x5A9b4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eHfayKm1CT6/SVv+9MWh/Qelf07K02SXwJJ5+TF7sKOTBlr87FJfrT6W77zxdJMeti1pkqLx1Xm6YLc6OMQfjsOA0p9j9NTNOF2JYrzO8Gg76f3DrFFWVnQdxBuRClgp2aZhL7AxLJZ/D6qNDl2nKfUgwLQ/CbMyEXD7gHcnC4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ibR3BB3E; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=f9BZ3qtY reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723032765; x=1754568765;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FrFm0a/CP4eAozJxBnIDxJwp5hKoHQQTdiePfUrFRR8=;
  b=ibR3BB3EBiMFu+r+p+kDMFR4G9m3oyTOHBwkK5WalMNoeflLRKJLdHal
   I+1mnsRNHrU+B2p5A3NvYJ2pVAs//cFqnStAr9Q8iE/gWfn4p+TMshfQm
   Z4m1UIFUKOSP2yixwDWgKYqpjR/C6xWk07HgPQoO1jXymgOHxIxLEaTde
   yPFxXbkLvQphvTPdeKavChrDbSJ1Yp8M06A5HRcmKG37aL5MeLvczaHaU
   m5Awhc9u1Tv5lN612sUrHBSAHlYiYeYBTqKyfgSg/+Xl7EzdevIZR+Irr
   86CdyFgzvWa6c/IdxBOxLehYa26KLXYlOC3OMIfbcUy+n/GnTCstcDmZ0
   Q==;
X-CSE-ConnectionGUID: 88j1+HaOSROhSeR+uFcgAw==
X-CSE-MsgGUID: SXIZty3KSjixY1qB6I3wLA==
X-IronPort-AV: E=Sophos;i="6.09,269,1716242400"; 
   d="scan'208";a="38292633"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 Aug 2024 14:12:42 +0200
X-CheckPoint: {66B364BA-20-CC8A42C9-EEB26961}
X-MAIL-CPID: 24B5C2277049345D6307A7D102250CBE_2
X-Control-Analysis: str=0001.0A782F25.66B364BB.0001,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8A16F1673A7;
	Wed,  7 Aug 2024 14:12:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723032758;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=FrFm0a/CP4eAozJxBnIDxJwp5hKoHQQTdiePfUrFRR8=;
	b=f9BZ3qtYO8WAMPN+lAHwbtF3H73+S2yXWs27akY2GYT6U0Ysl2fv9swWe2puPGUUuQ61t7
	BL2qP+ECVsSpYwztmWAyFt+XHchSH6Qxedcgsz3BQH/WRUrh5H3xi7oEW88iWIpPoWYW7r
	2Qw1W5CpOjaTAkcwUyH0hkp9xavpm3MCANBEQGc99PvGeDC1jv6SnNPJNxr4lGK2p7vKEP
	dxrD7fi24b/QewV2ORNadx8eVvXWqjBem9HTTI3kvgmhdivR/xeuKU40cFdsQBiuhdS9cl
	GuFtflONUgUkWyS+YjrYyRMcn0xcPDO389e2v5Z5deqWav1qKKA0tQAyNMPTGQ==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH net-next] net: ti: icssg_prueth: populate netdev of_node
Date: Wed,  7 Aug 2024 14:12:15 +0200
Message-ID: <20240807121215.3178964-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Allow of_find_net_device_by_node() to find icssg_prueth ports and make
the individual ports' of_nodes available in sysfs.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

Tested on a TI AM64x SoC. I don't have a device using the icssg_prueth_sr1
variant of the driver, but as this part of icssg_prueth.c and
icssg_prueth_sr1.c is identical, it seems like a good idea to make the
same change in both variants.

 drivers/net/ethernet/ti/icssg/icssg_prueth.c     | 1 +
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 9dc9de39bb8f0..53a3e44b99a20 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -857,6 +857,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 	}
 	ether_addr_copy(emac->mac_addr, ndev->dev_addr);
 
+	ndev->dev.of_node = eth_node;
 	ndev->min_mtu = PRUETH_MIN_PKT_SIZE;
 	ndev->max_mtu = PRUETH_MAX_MTU;
 	ndev->netdev_ops = &emac_netdev_ops;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
index 54b7e27608ce8..292f04d29f4f7 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
@@ -847,6 +847,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 	}
 	ether_addr_copy(emac->mac_addr, ndev->dev_addr);
 
+	ndev->dev.of_node = eth_node;
 	ndev->min_mtu = PRUETH_MIN_PKT_SIZE;
 	ndev->max_mtu = PRUETH_MAX_MTU;
 	ndev->netdev_ops = &emac_netdev_ops;
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


