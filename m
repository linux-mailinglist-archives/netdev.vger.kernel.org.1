Return-Path: <netdev+bounces-284849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EW0KEBK+2mYYwMAu9opvQ
	(envelope-from <netdev+bounces-284849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:03:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC194DB9C0
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4B61300DF51
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 13:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D498453497;
	Wed,  6 May 2026 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="E8OhQFbW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C3F3F7892;
	Wed,  6 May 2026 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075893; cv=none; b=lxQ3WUECf8PJUXdpBSZlvpi/pp2i7P6gTZ+NPJU70ixIpCiRP/R83m6RY8qfiS3GVNWGPkTdAPUYW5OQCKaF9Xb10F1UY3IJG3vv/J+Ge+x+EbnFDKHtps7VQ/1fAR9I5BYFpaodXuHFArA4h4ihhyYBmGhpu5zFPsX1pEl50R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075893; c=relaxed/simple;
	bh=D58SoE8E1agWEVUoG8uxhBpL2pS/XjCzjDjZUATIX7U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Thf8nRaGKbMA0BP26Xojm2/JAuf7fTUpmxsJkDcqzl87lk4sQOJcQAZpjtn9X+FbPCCxz842/AiAK+RysHZgEH1HtiVKLvsNkRy/+WDv4dpa/Y0x8smguQNKsUvXQHHTxRBtzWWgcV8BaCNMjBwr77ECivMbMzqzDJqt0pkrcA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=E8OhQFbW; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646APXAs2226342;
	Wed, 6 May 2026 06:57:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=vaUofWdhgU0TNI7a765yeci
	i87UyXIbCAdrjr9o/4aY=; b=E8OhQFbW954LKKNIpbQ0y8PEeGaMrz3l1zZSRPs
	SjPM6vsMRdQiqtErYeRHbqxCNxCKhyCOFhy5/MJD07eJhAxKvuc7JsiXa8VQNhjP
	fPOf0wjf7FA9MnsW9fIbXhJNNbn4fqeMtz1rC7T/a+fGKE7oICpCmRe3cMQu0tHR
	tkK8GMPuWTMy7/UM5oCqFp9gv0N0Bge3yPpK3aKvUBDkNTDLFFELGb2txAhgQCXX
	PLLQTfOjJwpNLHKyT7JV/tsZK/U2Gf80KgLBN6PReIeiIYlV5q1cinKARJm4j/Au
	gpf54B4e9iNLUqwZlHPoDKDC57Nol40UrlUbXZasMAbVjzg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dyupyt07e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 06:57:58 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 6 May 2026 06:57:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 6 May 2026 06:57:57 -0700
Received: from BG-LT92649.marvell.com (BG-LT92649.marvell.com [10.28.166.218])
	by maili.marvell.com (Postfix) with ESMTP id 205CB3F7092;
	Wed,  6 May 2026 06:57:52 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <irusskikh@marvell.com>, <epomozov@marvell.com>,
        <richardcochran@gmail.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        Sukhdeep Singh <sukhdeeps@marvell.com>
Subject: [PATCH net-next 0/9] net: atlantic: add PTP support for AQC113 (Antigua)
Date: Wed, 6 May 2026 19:26:57 +0530
Message-ID: <20260506135706.2834-1-sukhdeeps@marvell.com>
X-Mailer: git-send-email 2.52.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ClAkflwHqR4VP5rlx6US55nveGEVu7_y
X-Proofpoint-ORIG-GUID: ClAkflwHqR4VP5rlx6US55nveGEVu7_y
X-Authority-Analysis: v=2.4 cv=BoOtB4X5 c=1 sm=1 tr=0 ts=69fb48e6 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=D6WJUydZfyHhnkMUwaQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzNyBTYWx0ZWRfXxTA+ktwkA1l9
 /YqKj60zGWVl0i0oeAH3b6H8INHudKnL9pl4+k/4GfvkVyVwHRqe1jVLnoHTr9+mWYtSuV29qZD
 tbEiiB3JR/R4oc9zHQkmI7dgOCnMyX0B9kfvUT86+2wKhS4StfIIj4IRPdhqulalQAnXLY3YJ00
 3edMJMViGZeA6iwvBPsZK4Qf4KKBQicDpHyn/vpFWqML+qSrNv0Sjaslva99nqlHgchLxBLTAsm
 M0AgVuACd5YdIZ8BZFW3Wz9vdYl6SgtEqvyWEVUZfI6+tvZE17YapcXnGQJ5pXLt1Un9u/XuzUI
 4RvuNSgpn56DWU8OhmmuL6Dq9NIdVx2Y7+7stnKThrpVa5nH28/VCaeFgpNu4AYgSQcGBwyC9rQ
 d3q2+zC3g8KxyIFhhRT3xiOSTaqJHzuQ3o+W4vmKQvRj7EWpkehqkPBRAvg+Gh6AjEHwDkMtq4e
 QpS00lXp2+EucSOkFzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Rspamd-Queue-Id: ECC194DB9C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284849-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,marvell.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

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

