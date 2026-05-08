Return-Path: <netdev+bounces-285774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yG6WDyHR/Wl2jgAAu9opvQ
	(envelope-from <netdev+bounces-285774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:03:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B20164F60D8
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BE2F301727E
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB91372B4B;
	Fri,  8 May 2026 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bY5WhrWY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727EE256C84;
	Fri,  8 May 2026 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778241804; cv=none; b=AfEH6ateml8HMHUhWIbtMTrP7pVUvIj/C9WO41YFTMJoIxl6doBCUjb98vBO5+GlSohVh976GCg6z79c6QZ1ShcHh+DMUQrSv4fJ/GmqqbxdNf/rwkRkEXaAg0ueQYZ4AUJUb7tQVoD1RBR5Z//hreZdzaDqKqUDshgntZ8WvtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778241804; c=relaxed/simple;
	bh=g6fPHPIaMrimEkluU7Nv9VTxJMFe2QqLzA63QAt/Z0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPbgFQrCZh9mgK7cdv4u1bj4t3xOSW4lOf/qtgLxgqOWgl2xv3tVN9/17iit9KadBCPpkrwXyfa9QWgIqhqFl7x3MdRIlzGVEEdveEqr6gxp5bevfnBVAPfMLMeNZGrWm7UJvNHK7luz2GJjoeAE/zWaIl/Yxvsn7SZOtZ98+OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bY5WhrWY; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648B8TYt2841686;
	Fri, 8 May 2026 05:02:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
	ftJk20xYEKv2SoQ3gqS0JXxBE1+inAABxct5Pr9YIg=; b=bY5WhrWY0RA5FDnrt
	46VcBaQixiBiL4hdiQ2WYJD1j1atPJxFFXLhDn/xKq2zA6Bqp3An79H7O2/dK1Cw
	8Rbnk5ZfgyLAWUh2+BbDnzpHH8egYQu01JTzG0jDjhSyL2JaqfBwR8ehtjmusHbE
	sptiGqJrUoYUnKfFGJBZQp4Qrit/G2qlfKOwY52RFcSN40qcRgV3niJ+Vz5xw343
	5zz/ghgINzTfu0tFWTR0qsRwxnBAi4C+s+NmaUKRvfUZprHgY84cKzgGY3G6PZ5t
	8eaSxab6eRiY1cNLbMW52KCt62iWOVArlob9yn5DEZvFUMPxH9i72p3HixyR//4l
	wQJMA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e14g0hqtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 05:02:56 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 8 May 2026 05:02:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 8 May 2026 05:02:55 -0700
Received: from BG-LT92649.marvell.com (BG-LT92649.marvell.com [10.28.166.218])
	by maili.marvell.com (Postfix) with ESMTP id E8BA63F706D;
	Fri,  8 May 2026 05:02:50 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <irusskikh@marvell.com>, <epomozov@marvell.com>,
        <richardcochran@gmail.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <vadim.fedorenko@linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Sukhdeep Singh
	<sukhdeeps@marvell.com>
Subject: [PATCH net-next v2 0/9] net: atlantic: add PTP support for AQC113 (Antigua)
Date: Fri, 8 May 2026 17:31:47 +0530
Message-ID: <20260508120156.3060-1-sukhdeeps@marvell.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260506135706.2834-1-sukhdeeps@marvell.com>
References: <20260506135706.2834-1-sukhdeeps@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: yC1KXo58hFLpQ9pRIB4kdd7_cU3svRa0
X-Authority-Analysis: v=2.4 cv=bMUm5v+Z c=1 sm=1 tr=0 ts=69fdd0f0 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=D6WJUydZfyHhnkMUwaQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEyNSBTYWx0ZWRfX/1DjNePbS0P9
 1gZcJAolBee6Cca95Jg/wXk9sRSOEIgxqzvnbB7BUMMAwX9Si7VP+HhOo4dV1M8VwwSLqyJW180
 oafO22LbofLiL2lHkym+ey4W5fMK53dL4i66lse1li2Pzu+oBTyGNOeQNxGAq9kgUegkRX3DtI8
 AnCapFgBV9cHeTQRySaumFK08EdMBtRXtO6I0Ol7zjxImHFjRhWe1aLX06y8dtpOF7f9DGCYcyb
 NxzfDg6I7v4pEyB6Wq+cM6TpT8dLxtxEw9+V+HP5wV6gt3rWgn5H6HGJicGBeLtE3L6FZkfc4su
 fRtjoYfpGNc0LS4/vPYz6xcxnsT5EjjcjOjGCvoFKMqClQ855Latnq7o3aV/rodZZlgyUvBwBPz
 ZQxga3T0uZ3Kif+vLy27iX+a705gw5QjLxMC1T24kP2y7ART0Wcxt2BLYSauSDDHf6llh6BMJNI
 H6fj4tJJdc92/r3gbbQ==
X-Proofpoint-GUID: yC1KXo58hFLpQ9pRIB4kdd7_cU3svRa0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Rspamd-Queue-Id: B20164F60D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-285774-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,marvell.com:mid,marvell.com:dkim];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

From: Sukhdeep Singh <sukhdeeps@marvell.com>

This series adds IEEE 1588 PTP support for the AQC113 (Antigua) network
controller. AQC113 is the successor to the existing AQC107 (Atlantic)
chip already supported by the atlantic driver.

AQC113 uses a substantially different hardware architecture for PTP
compared to AQC107:

  - Dual on-chip TSG clocks with direct register access instead of
    PHY-based timestamping via firmware
  - TX timestamps via descriptor writeback instead of firmware mailbox
  - Hardware L3/L4 RX filters for PTP multicast steering with both
    IPv4 and IPv6 support
  - Reference-counted shared filter slots managed through an Action
    Resolver Table (ART), allowing multiple rules to share L3/L4
    hardware filters when their match criteria are identical

The series is structured in three parts:

Patches 1-3 prepare the existing L3/L4 filter path:

  Patch 1 corrects flow_type masking and IPv6 address handling in
  aq_set_data_fl3l4(). Patch 2 moves the active_ipv4/ipv6 bitmap
  updates to after the hardware write succeeds. Patch 3 decouples
  the function from driver-internal structures so it can be called
  directly by the AQC113 PTP filter setup code.

Patches 4-6 add the AQC113 hardware infrastructure:

  Patch 4 adds the low-level register definitions and accessor
  functions. Patch 5 adds filter data structures and firmware
  capability query. Patch 6 implements the complete L2/L3/L4 RX
  filter management layer including the reference-counted sharing
  and ART integration.

Patches 7-9 add the AQC113 PTP feature:

  Patch 7 reserves the dedicated PTP traffic class buffer and
  configures the TX path. Patch 8 extends the hw_ops interface
  with PTP-specific function pointers and updates AQC107 to the
  new signatures. Patch 9 implements the full PTP subsystem
  integration for AQC113.

The existing AQC107 PTP implementation is not functionally changed
by this series; AQC113-specific code paths are gated on chip
detection throughout.

Tested on AQC113 at 1G, 2.5G, 5G, and 10G link speeds using
ptp4l/phc2sys with hardware timestamping in both L2 and L4
(IPv4/IPv6) modes.

Changes in v2:
- Patch 6: Remove redundant variable initializers for art_mask, h, l
  and err as suggested by Vadim Fedorenko

Sukhdeep Singh (9):
  net: atlantic: correct L3L4 filter flow_type masking and IPv6 handling
  net: atlantic: move active_ipv4/ipv6 bitmap updates after HW write
  net: atlantic: decouple aq_set_data_fl3l4() from driver internals
  net: atlantic: add AQC113 hardware register definitions and accessors
  net: atlantic: add AQC113 filter data structures and firmware query
  net: atlantic: implement AQC113 L2/L3/L4 RX filter management
  net: atlantic: add AQC113 PTP traffic class and TX path setup
  net: atlantic: extend hw_ops and TX descriptor for AQC113 PTP
  net: atlantic: add PTP support for AQC113 (Antigua)

 drivers/net/ethernet/aquantia/atlantic/aq_filters.c          |  64 +-
 drivers/net/ethernet/aquantia/atlantic/aq_filters.h          |   3 +
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h               |  37 +-
 drivers/net/ethernet/aquantia/atlantic/aq_main.c             |  33 +-
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c              |  51 +-
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c         |   4 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.c              | 531 +++++++--
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.h              |  15 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c             |  42 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.h             |   4 +-
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c   |  15 +-
 drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c    | 813 +++++++++++-
 drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.h    |  12 +
 drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h | 69 +-
 drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_llh.c | 360 ++++++
 drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_llh.h | 107 +-
 drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_llh_internal.h | 204 ++-
 drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.c |  33 +
 drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils.h |  15 +
 drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c |  52 +
 20 files changed, 2244 insertions(+), 224 deletions(-)

-- 
2.43.0

