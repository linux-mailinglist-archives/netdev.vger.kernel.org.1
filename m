Return-Path: <netdev+bounces-255132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL1dGmuofGnuOAIAu9opvQ
	(envelope-from <netdev+bounces-255132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 13:47:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDD7BAA10
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 13:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C5053004051
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21164355027;
	Fri, 30 Jan 2026 12:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="RmIlmrPA"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1AA125A9;
	Fri, 30 Jan 2026 12:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769777253; cv=none; b=VeKkJ9RvdxSa0UZpa2KfSab00wdb2BXp8LcfE57Upz7iXbS/n9gTngWgXwwR4UxIgVFJLyQrQNsTUoISF9lW8aI2u2I7R2Y9Ta6/Gr/XrixBjpFsBypO7S3PytsewAMmusd6y0aihMyjKLBazEp+wEbRK3QAc0qaoIGNB1+gSpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769777253; c=relaxed/simple;
	bh=h7X1Qh6XZ8+vdHPGeulSbepwFceiCrzicTqzbzuSu8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oteZmksd1Qs42jgb+UJxwiYyLIxQB7yu5AvjixAEKDqXebkhQzR7Lr8J53Y2hKFdjSayvGzmnGdt6kKpYejLZeUXiq2UksV+xbDeOuIGcMXUeuaRacChxDLsFpi8USunfUyuY6cMBwcKeat4OlFgQ9ukY9zDUuXkoGBJORdm71E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=RmIlmrPA; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=y8EW95ucxAeggdlWigGJ3lVj3BaqCqydwTiog/fLUxw=; b=RmIlmrPAkVTTnB1UdcSJVQzuxg
	ZNdNve4f8c89XI5AsfUOCNPkmESqM9Gnif3AnVXFT6zg8ctN1DO6sZ13W8F/VPd1rBYKjMknX8iCU
	/9P5j49mOFmqIT2WFJPySYVpDPJEQng00WXmO+nj8N74IEyQ3tNgBcRckJKaMSxFHASO53bEYsonT
	MtlEkd9VGtGMEMoTCy1k0eEETfS5za6dYJFcelzaFq8QXF3cZYhkXzm9I++R+gE60FDckShyoPVVV
	PFXMEqUdT99hW8DtMlJ2Biz8CRQw9a+KSckmfIvvVAm6t6c3tyJbqN5qfCd/J/1LFDoi5dA2r9WZK
	ghbxIioA==;
Received: from [122.175.9.182] (port=57735 helo=cypher.couthit.local)
	by server.couthit.com with esmtpa (Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1vlnuC-00000002WPH-1GKm;
	Fri, 30 Jan 2026 07:47:20 -0500
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
Subject: [PATCH net-next v13 0/3] STP/RSTP SWITCH support for PRU-ICSSM Ethernet driver
Date: Fri, 30 Jan 2026 18:13:42 +0530
Message-ID: <20260130124559.1182780-1-parvathi@couthit.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[couthit.com:s=default];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[couthit.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255132-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_X_GMSV(0.00)[parvathi@couthit.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_X_AS(0.00)[parvathi@couthit.com];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[couthit.com:-];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[parvathi@couthit.com,netdev@vger.kernel.org];
	HAS_X_SOURCE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	HAS_X_ANTIABUSE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CEDD7BAA10
X-Rspamd-Action: no action

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

[Interface up Testing](https://gist.github.com/ParvathiPudi/91b05f4e6d69d72f55ddd4e95301ab20)

[Ping Testing](https://gist.github.com/ParvathiPudi/9e7573ea85ef72a3ebcbdb4c902f3b8a)

[Iperf Testing](https://gist.github.com/ParvathiPudi/30abedf115aba19542e0156486766553)

[1] https://lore.kernel.org/all/20250912104741.528721-1-parvathi@couthit.com/

This is the v13 of the patch series [v1]. This version of the patchset
addresses the comments made on [v12] of the series.

Changes from v12 to v13:

*) Reverted the use of kmalloc_obj() and kzalloc_obj() back to kmalloc() and kzalloc(),
since the corresponding changes are not reflected in the net-next branch.
*) Addressed AI review warnings on patch 3 of the series.
*) Rebased the series on latest net-next.

Changes from v11 to v12:

*) Addressed Paolo Abeni comments on  patch 1 and 3 of the series.
*) Rebased the series on latest net-next.

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
[v11] https://lore.kernel.org/all/20260105122549.1808390-1-parvathi@couthit.com/
[v12] https://lore.kernel.org/all/20260123135932.535735-1-parvathi@couthit.com/

Thanks and Regards,
Parvathi.

Roger Quadros (3):
  net: ti: icssm-prueth: Add helper functions to configure and maintain
    FDB
  net: ti: icssm-prueth: Add switchdev support for icssm_prueth driver
  net: ti: icssm-prueth: Add support for ICSSM RSTP switch

 drivers/net/ethernet/ti/Makefile              |    2 +-
 drivers/net/ethernet/ti/icssm/icssm_prueth.c  |  545 ++++++++-
 drivers/net/ethernet/ti/icssm/icssm_prueth.h  |   20 +-
 .../ethernet/ti/icssm/icssm_prueth_fdb_tbl.h  |   76 ++
 .../ethernet/ti/icssm/icssm_prueth_switch.c   | 1065 +++++++++++++++++
 .../ethernet/ti/icssm/icssm_prueth_switch.h   |   37 +
 drivers/net/ethernet/ti/icssm/icssm_switch.h  |  103 ++
 .../net/ethernet/ti/icssm/icssm_switchdev.c   |  333 ++++++
 .../net/ethernet/ti/icssm/icssm_switchdev.h   |   13 +
 .../ti/icssm/icssm_vlan_mcast_filter_mmap.h   |  120 ++
 10 files changed, 2291 insertions(+), 23 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_fdb_tbl.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_switchdev.c
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_switchdev.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_vlan_mcast_filter_mmap.h

-- 
2.43.0


