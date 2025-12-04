Return-Path: <netdev+bounces-243642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B85FCA4B57
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 18:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 075BC30840D7
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 17:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758E026B741;
	Thu,  4 Dec 2025 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="Dj4w0xlX"
X-Original-To: netdev@vger.kernel.org
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A698026B08F;
	Thu,  4 Dec 2025 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764868036; cv=none; b=erp08Ank0uyWUD2Ab2s5vhyzmUbycIVhVGR6u+Y/NJYbmuBIAgir532Zq7gSteMuIXGElQdIwJYTn5x+JI9hCssMJJvbF84ysJ6dMu+XkuRoyU2X3Gg69K+vZNVg8R9rIcJPXRNmFdYcJ11ZIJlC+If4z7DmDxseWsJ0jRii60Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764868036; c=relaxed/simple;
	bh=5zP/hFQikdgj7EybxuJOV1ARFzT5xlL1pLXcm4/eabQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dljZCWdbYe1Gf9rL/Rwd64N+pPf6DAX8Ohul50PmyDnP8XS72TnYYm4QSM0TSsQHpa+AyxpUXps5QAOUI7hG6sHsOdYG2Vlu1+bJhH86WaJQEVHBIk/xMu6OyAEz588LW5l7UWlNFqFHs1daUaUx17BOS1FKjo9s4YW2ZtOjHVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=Dj4w0xlX; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout3.routing.net (Postfix) with ESMTP id 6EA9A604D8;
	Thu,  4 Dec 2025 16:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1764867540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yEf34xHass0T0b10s6FQMT0sLObUUkUTpYfcGRnwAwU=;
	b=Dj4w0xlX7NLM+Fzl6FHDzbPflg0O6XePe+A8UwQjldkWgAWVLnpHrtIA4xbBQOA/jtB1a9
	prO8apLdAo099MsGpJ0xCSwmnX2EnXItE02lGa1Ij5VkQacvTk7VZnyw3FfljtNHBDUDR5
	tAKu+iNZW5AipCHWAedSmaVmt0klx1k=
Received: from frank-u24.. (fttx-pool-157.180.225.155.bambit.de [157.180.225.155])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 2BA6B1226EB;
	Thu,  4 Dec 2025 16:59:00 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [RFC v2 0/3] Add RSS and LRO support
Date: Thu,  4 Dec 2025 17:58:42 +0100
Message-ID: <20251204165849.8214-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

This series is currently only for discussion to get the upported SDK driver
changes in a good shape.
To use it some other parts are still missing like USXGMII PCS support on
mt7988.

patches are upported from mtk SDK:
- https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/refs/heads/master/master/files/target/linux/mediatek/patches-6.12/999-eth-08-mtk_eth_soc-add-register-definitions-for-rss-lro-reg.patch
- https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/refs/heads/master/master/files/target/linux/mediatek/patches-6.12/999-eth-09-mtk_eth_soc-add-rss-support.patch
- https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/refs/heads/master/master/files/target/linux/mediatek/patches-6.12/999-eth-10-mtk_eth_soc-add-hw-lro-support.patch

RSS / LRO

HW-acceleration for ending traffic. For routed traffic PPE is needed and
hw offloading in nftables.
Bridged traffic may need additional changes (openwrt use bridger utility).

RSS (Receive Side Scaling)

using 4 additional IRQ for spreading load

cat /proc/interrupts | grep ethernet

echo 1 > /proc/irq/105/smp_affinity
echo 2 > /proc/irq/106/smp_affinity
echo 4 > /proc/irq/107/smp_affinity
echo 8 > /proc/irq/108/smp_affinity

moving tx frame-engine irq to different cpu (here 3rd)
echo 4 > /proc/irq/103/smp_affinity

disable RPS (Receive Packet Steering) for all macs:

echo 0 > /sys/devices/platform/soc/15100000.ethernet/net/eth0/queues/rx-0/rps_cpus

pay attention on iperf-version (iperf 3.17 is ok, 3.12 is not)

traffic must be created using multiple streams so that it can be splitted, so use
multithreaded iperf3

on R4: bin/iperf3 -s
on the other side: iperf3 -c 192.168.1.1 -i 1 -P 4

you should reach ~9.3 GBit/s

and see spreading load over CPU cores

root@bpi-r4-phy-8G:~# cat /proc/interrupts | grep eth
103: 20 198366 0 0 GICv3 229 Level 15100000.ethernet
105: 3611 0 0 0 GICv3 221 Level 15100000.ethernet, 15100000.ethernet
106: 2 6842 0 0 GICv3 222 Level 15100000.ethernet, 15100000.ethernet
107: 4 0 27643 0 GICv3 223 Level 15100000.ethernet, 15100000.ethernet
108: 3 0 0 27925 GICv3 224 Level 15100000.ethernet, 15100000.ethernet

using the iperf3 from debian bookworm (3.12) results in only 6.7GBit/s, so
newer version is needed (not tested yet in trixie).

LRO(Large Receive Offload)

Add HW LRO RX rule:

ethtool -N [interface] flow-type tcp4 dst-ip [IP] action 0 loc [0/1]

Delete HW LRO RX rule:

ethtool -N [interface] delete [0/1]

Enable/Disable HW LRO rule:

ethtool -K [interface] lro [on | off]

Show the current offload features:

ethtool -k [interface]

example:

ethtool -N eth2 flow-type tcp4 dst-ip 192.168.1.1 action 0 loc 0
ethtool -K eth2 lro on ethtool -k eth2

using iperf(2) instead of iperf3 to reach full traffic!

verify with propritary debugfs (not part of this series)

Enable HW LRO rings
echo 4 1 > /proc/mtketh/hw_lro_auto_tlb
Enable HW LRO statistics
echo 5 1 > /proc/mtketh/hw_lro_auto_tlb

cat /proc/mtketh/hw_lro_stats

changes:
  v2:
    - drop wrong change (MTK_CDMP_IG_CTRL is only netsys v1)
    - Fix immutable string IRQ setup (thx to Emilia Schotte)
    - drop links to 6.6 patches/commits in sdk in comments


Mason Chang (3):
  net: ethernet: mtk_eth_soc: Add register definitions for RSS and LRO
  net: ethernet: mtk_eth_soc: Add RSS support
  net: ethernet: mtk_eth_soc: Add LRO support

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 762 ++++++++++++++++----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 171 +++--
 2 files changed, 753 insertions(+), 180 deletions(-)

-- 
2.43.0


