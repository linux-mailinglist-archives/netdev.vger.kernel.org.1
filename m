Return-Path: <netdev+bounces-247032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2BFCF3B23
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 14:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E0153133E22
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 12:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3388340275;
	Mon,  5 Jan 2026 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="brSQVMN7"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5200933FE12;
	Mon,  5 Jan 2026 12:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767617103; cv=none; b=dCs74QDgyxICL1UwQYmU2hBp039Yo2xyIK1XpD/D1Iw23aHy053lkzx7K0TBBxnUcb28NFtVithw31KE4cC4QeUWZpSk45kyKsoaeLRT0AElAQey3EHDtSd+RUk3ofa17SsfKurN3Ai20Au80hE8+I0zuArR6pbcf5Im0FSahKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767617103; c=relaxed/simple;
	bh=kde+YF5V+DYYmMMob26eEC+xps34thGQHk+CSSqXeBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PcX0N3PQzZV+Gr7m/fO7zQZPydkESkru78xfA2XzYmHKqCExnzVRbWFTQgIkioZOBUayH0SllCzpDwos2rks/EMuxecybiooIyEP/z/mI0zIs3HPT615aw355VIcUGgq8v/6ErH8/Z5akBQB4Ycyomk4egpzz/73n2IOOa+NweY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=brSQVMN7; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oBPTsdQ+5QIOEyqpw9EejEwAlJu22ofULxi/H8UNZbA=; b=brSQVMN7FjeSc2Fbit2wtuBftX
	7fGHa72sFdSvSHkxwn6CCv8mdxFRKn23JbEY0U9jj44OFUm4GIkQv/7enuF0FDBaJL114NDictATW
	YZuhKE1Lbb7PyqenJnHKNu2FgJEb5BI+n4GENjGIahLzQUchWnSzMZbnDseFg2KZiDEP7D9/XVaIK
	svU8Qr6g+WGmU5hNbyFG5PLU+Rjt/O41/hq1hxt3ApE3HOO4G/vB+6PcH4jXK4oGcYO1zuQIl+MiV
	Lgjl31R510y1lwj67dTUGmNnlEUqCVZK4XEqIyqkygjywFuM3UxUUY8F9w8xXASRRPBJ5KDARZCJP
	Fb62Mbow==;
Received: from [122.175.9.182] (port=7326 helo=cypher.couthit.local)
	by server.couthit.com with esmtpa (Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1vcjgg-0000000Ezqj-36WM;
	Mon, 05 Jan 2026 07:27:55 -0500
From: Parvathi Pudi <parvathi@couthit.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	parvathi@couthit.com,
	rogerq@kernel.org,
	pmohan@couthit.com,
	basharath@couthit.com,
	afd@ti.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	alok.a.tiwari@oracle.com,
	horms@kernel.org,
	pratheesh@ti.com,
	j-rameshbabu@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	krishna@couthit.com,
	mohan@couthit.com
Subject: [PATCH net-next v11 0/3] STP/RSTP SWITCH support for PRU-ICSSM Ethernet driver
Date: Mon,  5 Jan 2026 17:53:06 +0530
Message-ID: <20260105122549.1808390-1-parvathi@couthit.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.couthit.com: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,

The DUAL-EMAC patch series for Megabit Industrial Communication Sub-system
(ICSSM), which provides the foundational support for Ethernet functionality
over PRU-ICSS on the TI SOCs (AM335x, AM437x, and AM57x), was merged into
net-next recently [1].

This patch series enhances the PRU-ICSSM Ethernet driver to support bridge
(STP/RSTP) SWITCH mode, which has been implemented using the "switchdev"
framework and interacts with the "mstp daemon" for STP and RSTP management
in userspace.

When the  SWITCH mode is enabled, forwarding of Ethernet packets using
either the traditional store-and-forward mechanism or via cut-through is
offloaded to the two PRU based Ethernet interfaces available within the
ICSSM. The firmware running on the PRU inspects the bridge port states and
performs necessary checks before forwarding a packet. This improves the
overall system performance and significantly reduces the packet forwarding
latency.

Protocol switching from Dual-EMAC to bridge (STP/RSTP) SWITCH mode can be
done as follows.

Assuming eth2 and eth3 are the two physical ports of the ICSS2 instance:

>> brctl addbr br0
>> ip maddr add 01:80:c2:00:00:00 dev br0
>> ip link set dev br0 address $(cat /sys/class/net/eth2/address)
>> brctl addif br0 eth2
>> brctl addif br0 eth3
>> mstpd
>> brctl stp br0 on
# STP to RSTP mode
>> mstpctl setforcevers br0 rstp
>> ip link set dev br0 up

To revert back to the default dual EMAC mode, the steps are as follows:

>> ip link set dev br0 down
>> brctl delif br0 eth2
>> brctl delif br0 eth3
>> brctl delbr br0

The patches presented in this series have gone through the patch verification
tools and no warnings or errors are reported.

Sample test logs obtained from AM33x, AM43x and AM57x verifying the
functionality on Linux next kernel are available here:

[Interface up Testing](https://gist.github.com/ParvathiPudi/28fc4a2abff0c6f617d80f09c4a12881)

[Ping Testing](https://gist.github.com/ParvathiPudi/1f50c92e5c36b3d297bd4fc684b3d7fd)

[Iperf Testing](https://gist.github.com/ParvathiPudi/1dc93b2a65f873e8ab85747fed6ea953)

[1] https://lore.kernel.org/all/20250912104741.528721-1-parvathi@couthit.com/

This is the v11 of the patch series [v1]. This version of the patchset
has no changes from [v10] of the series.

Changes from v10 to v11:

*) Dropped the RFC tag.
*) No code changes were made, only the version was updated.
*) Rebased the series on latest net-next.

Changes from v9 to v10:

*) Added RFC tag as net-next is closed now.
*) Addressed applicable AI review warnings, including clearing the host lock before returning on
timeout, avoiding a race on hw_bridge_dev and adding a conditional check to avoid null
pointer dereferences.
*) Rebased the series on latest net-next.

Changes from v8 to v9:

*) Added RFC tag as net-next is closed now.
*) Addressed  Jakub Kicinski comments on patch 1 and 2 of the series.
*) Rebased the series on latest net-next.

Changes from v7 to v8:

*) Modified dev_hold/dev_put reference to netdev_hold/netdev_put in patch 2 of the series.
*) Rebased the series on latest net-next.

Changes from v6 to v7:

*) Addressed Jakub Kicinski comments on patch 2 of the series.
*) Rebased the series on latest net-next.

Changes from v5 to v6:

*) Addressed Simon Horman comments on patch 1, 2 and 3 of the series.
*) Rebased the series on latest net-next.

Changes from v4 to v5:

*) Addressed ALOK TIWARI comments on patch 1 of the series.
*) Rebased the series on latest net-next.

Changes from v3 to v4:

*) Addressed Andrew Lunn comments on patch 1 and 2 of the series.
*) Rebased the series on latest net-next.

Changes from v2 to v3:

*) Dropped the RFC tag.
*) Addressed  MD Danish Anwar comments on patch 3 of the series.
*) Rebased the series on latest net-next.

Changes from v1 to v2 :

*) Added RFC tag as net-next is closed now.
*) Updated the cover letter of the series to generalize and indicate support for
both STP and RSTP along with subject change as per Andrew Lunn's suggestion.
*) Addressed the Andrew Lunn's comments on patch 1 of the series.
*) Rebased the series on latest net-next.

[v1] https://lore.kernel.org/all/20250925141246.3433603-1-parvathi@couthit.com/
[v2] https://lore.kernel.org/all/20251006104908.775891-1-parvathi@couthit.com/
[v3] https://lore.kernel.org/all/20251014124018.1596900-1-parvathi@couthit.com/
[v4] https://lore.kernel.org/all/20251110125539.31052-1-parvathi@couthit.com/
[v5] https://lore.kernel.org/all/20251113101229.675141-1-parvathi@couthit.com/
[v6] https://lore.kernel.org/all/20251124135800.2219431-1-parvathi@couthit.com/
[v7] https://lore.kernel.org/all/20251126124602.2624264-1-parvathi@couthit.com/
[v8] https://lore.kernel.org/all/20251126163056.2697668-1-parvathi@couthit.com/
[v9] https://lore.kernel.org/all/20251205123146.462397-1-parvathi@couthit.com/
[v10] https://lore.kernel.org/all/20251216132641.1313026-1-parvathi@couthit.com/

Thanks and Regards,
Parvathi.

Roger Quadros (3):
  net: ti: icssm-prueth: Add helper functions to configure and maintain
    FDB
  net: ti: icssm-prueth: Add switchdev support for icssm_prueth driver
  net: ti: icssm-prueth: Add support for ICSSM RSTP switch

 drivers/net/ethernet/ti/Makefile              |    2 +-
 drivers/net/ethernet/ti/icssm/icssm_prueth.c  |  529 +++++++-
 drivers/net/ethernet/ti/icssm/icssm_prueth.h  |   20 +-
 .../ethernet/ti/icssm/icssm_prueth_fdb_tbl.h  |   76 ++
 .../ethernet/ti/icssm/icssm_prueth_switch.c   | 1065 +++++++++++++++++
 .../ethernet/ti/icssm/icssm_prueth_switch.h   |   37 +
 drivers/net/ethernet/ti/icssm/icssm_switch.h  |  103 ++
 .../net/ethernet/ti/icssm/icssm_switchdev.c   |  333 ++++++
 .../net/ethernet/ti/icssm/icssm_switchdev.h   |   13 +
 .../ti/icssm/icssm_vlan_mcast_filter_mmap.h   |  120 ++
 10 files changed, 2275 insertions(+), 23 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_fdb_tbl.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_switchdev.c
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_switchdev.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_vlan_mcast_filter_mmap.h

-- 
2.43.0


