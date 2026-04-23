Return-Path: <netdev+bounces-280798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FiJMoJJ6mkhxgIAu9opvQ
	(envelope-from <netdev+bounces-280798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:32:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 736CA454EC6
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 163B4300FEEF
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80300383C97;
	Thu, 23 Apr 2026 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="ZGUSR4gu"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16A13803C2;
	Thu, 23 Apr 2026 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776961813; cv=none; b=U792bQmypBZqp01HwUQS94OmsdVGjNOvg3Vewn+DupKlkOHkuyPHKvV1p7OwDAL47M0TYEVeLJYWVBhtBx8lyOypLBLxsoGTh2eNjLsa+yBCZN00h6Jy3sF/72UmCp4fMM8um7SB38zCbyQB+Ndt1gI+gx8VZdHsSxyo1h1gQ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776961813; c=relaxed/simple;
	bh=ZXSTJ7b/38rgvmYO873buvlool6i84d5a2ZJr/9ipT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BgvQUxLh9DUps2+VVAuXbsvy9TPMElYPMY4Kou71pzXmrQTmX4Lpk9LCQlRhiOUJFGwl4xPEuQshaJECMPv9Z136Ik4CcBt+e4a+IjMVr9HA3BdG6Fo0TqkYX+hL14IfgPOSaJvbtose/cdsVw8ian/Zw/+6YrW8oO6WGz9nCEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=ZGUSR4gu; arc=none smtp.client-ip=173.37.142.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2512; q=dns/txt;
  s=iport01; t=1776961812; x=1778171412;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Ks0lsgTrBdaqV3gPaDF/jXpyLgWa4qOq0Cl3j1wSwFo=;
  b=ZGUSR4guD0vP5Kgb/wEZOcdhCPhbDhqaen60AiMH8SspalyY5M2Kxz6b
   chyy1H8UR+G+sstOynQ2Jif3Mpz3B6UjoHiFurBGY+oLXBZkepVJpQvJk
   hqyQUkvOlL6PEp/67YG3yjqgn1fDPVHhKCImaa97LpuIO3M6ABajTgFHa
   uwfsG3r3y3KGU5PxfE5B5OTbpuf2a8SEHDCVGaOT2RKFMWLVUBva3RxKQ
   c9ulZ1X+nLaRRfl4iGir3n1K0YidIpckZOqRcRT32ikmA+VtIBISSjc22
   rT9fapj3ewDapomhZAkvHB3txvrUwHakdtQNhpB0gvCzPTU7oxSSl5JJl
   g==;
X-CSE-ConnectionGUID: m46ZXPfLRMGKfxqLNDC25g==
X-CSE-MsgGUID: l9WP7h05RHC7Me65Z1pb/w==
X-IPAS-Result: =?us-ascii?q?A0BIAgCSPupp/4//Ja1aHgEBCxIMgWsQDwuCU4FPQ0mEV?=
 =?us-ascii?q?49TgiGeHYF/DwEBAQ9RBAEBhQYCjSwCJjQJDgECBAEBAQEDAgMBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEKAQEFAQEBAgEHBYEOE4ZchlsCAQMjBFIQJQImAgJGEAYBEoMCgnQDs?=
 =?us-ascii?q?Dt6fzOBAYR9sySBZAELFAGBCi6FcoJmAYFwhAY7hD8nG4FJRIR9hAqEFIJpB?=
 =?us-ascii?q?IMcFIIgjH0JP4ECHANZLAFVEw0KCwcFYVIzAyAKCxISGBUCFC8PBBYyHXAMJ?=
 =?us-ascii?q?xIsFzRYGwcFgUuECW0UMQQhgQuDKoE2ewMLGA1IESw3Bg4bBD0BbgeKNCAPg?=
 =?us-ascii?q?TlxPVKCaCmTQIMyjV1roQ6EJoFkoA4BMpdmkwUsmFoio08xN4RogWg8gVkzG?=
 =?us-ascii?q?ggbFYMiUxkPji0WHMoDJjI/BwIHDgKRc4F9AQE?=
IronPort-Data: A9a23:CZ1cta9I3rNSx7d8c1HwDrUDQH+TJUtcMsCJ2f8bNWPcYEJGY0x3n
 DdLUGzTM6neYmb2Lt9+at7l9EIGvsXTmN5qSwQ6qyxEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmB4E/rbui/xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4mpyyHjEAX9gWAsbjhPs/7rRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dgJtb
 7+epF0R1jqxEyYFUrtJoJ6iGqE5auK60Ty1t5Zjc/PKbi6uCcAF+v1T2PI0MS+7gtgS9jx74
 I0lWZeYEW/FMkBQ8QgQe0EwLs1wAUFJ0Lqbf0qPicK39WjpUHX82tFIIGpsYIJNr46bAUkWn
 RAZACoGYhbGg6e9x6i2D7EywM8iN8LseogYvxmMzxmAUq1gGs+FGfiXo4YEh1/chegWdRraT
 9EQdTt0bBfASxZOIVwQTpk5mY9Eg1GgL2QB8w3F+/dfD277yF1O6OftaIfvWvfVYMgLw3TBv
 miB4DGsav0dHJnFodafyVqgj/HCmAv3UZwfEbm/+OIshlCPrkQXBRwKXFyTrfSzi0e4HdVFJ
 CQ89yYzqKEg+VCDQd76UBm15nWDu3Y0WMdaGsU55RuLx66S5ByWbkANSDJbZcNlssIqSTE0/
 luUmdWvDjwHmKWcQ3+b95+OoD+yMDRTJmgHDQcATA0Y85zgrZs1gxbnUNluCui2g8fzFDW2x
 CqFxAA4iqkfgNAjyaq25xbEjiiqq5yPSRQ6jjg7RUq/5Q9/IYrgbIuy5B2Ds7BLLZ2SSR+Ku
 31sd9Wi0d3ixKqlzESlKNjh1pnzjxpZGFUwWWJSIqQ=
IronPort-HdrOrdr: A9a23:Ixv12q9U5dsgRxgl0y1uk+AuI+orL9Y04lQ7vn2ZhyYlFvBw8P
 rOoB1773HJYVkqNU3I9errBEDEewK/yXcX2+Ys1MmZPDUO0VHAROpfBMnZsl7d8kbFmtK1u5
 0QFpRWOZncAUd3iMDi7BL9MdoxqeP3iZyAtKPyw2hgSAdyZ7ol1Qd2DQ6HDlZ7LTM2Y6bRbK
 DsgfZvln6HZWkdaNi9Cz0uWujOoMCOqbfdCCR2fyLOLGK1/EmVAHmQKWni4isj
X-Talos-CUID: 9a23:pADbvWBm3SF+ZY76Eyw7qnwkIs4BSFjy73nAOmueJU0zFbLAHA==
X-Talos-MUID: 9a23:0GZVZQWIJtir7Ijq/Du9uwk9NJ812YSFV2UAz8g04tGOcjMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,195,1770595200"; 
   d="scan'208";a="741137865"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 23 Apr 2026 16:29:02 +0000
Received: from [127.0.0.1] (unknown [10.25.128.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPS id 254C4180003AB;
	Thu, 23 Apr 2026 16:29:02 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Thu, 23 Apr 2026 09:28:02 -0700
Subject: [PATCH net-next v5 01/10] enic: verify firmware supports V2 SR-IOV
 at probe time
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-enic-sriov-v2-admin-channel-v2-v5-1-caa9f504a3dc@cisco.com>
References: <20260423-enic-sriov-v2-admin-channel-v2-v5-0-caa9f504a3dc@cisco.com>
In-Reply-To: <20260423-enic-sriov-v2-admin-channel-v2-v5-0-caa9f504a3dc@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com, 
 Satish Kharat <satishkh@cisco.com>, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776961741; l=2560;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=ZXSTJ7b/38rgvmYO873buvlool6i84d5a2ZJr/9ipT8=;
 b=90YRLlQzoHUs/dWlwOgUlCwhbW9Bad3DjLGRQ1leGNKTHHOubM/uvuVRUtLmejCpW/828nSLT
 Fvl8c5lHNO+A+OeISO4Gi+lGEgIAqObut6QIbt4OFFro/5Gm0rVRsnG
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.216];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.216, [10.25.128.216]
X-Outbound-Node: rcdn-l-core-06.cisco.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280798-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[cisco.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:email,cisco.com:dkim,cisco.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 736CA454EC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During PF probe, query the firmware get-supported-feature interface
to verify that the running firmware supports V2 SR-IOV. Firmware
version 5.3(4.72) and later report VIC_FEATURE_SRIOV via
CMD_GET_SUPP_FEATURE_VER. If the firmware does not support the
feature, set vf_type to ENIC_VF_TYPE_NONE and log a warning so the
admin knows a firmware upgrade is needed.

The VIC_FEATURE_SRIOV enum value (4) matches the firmware ABI. A
placeholder entry (VIC_FEATURE_PTP at position 3) is added to keep
the enum in sync with firmware's feature numbering.

Suggested-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c   | 21 ++++++++++++++++++++-
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h |  2 ++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index e7125b818087..53d68272d06a 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2641,8 +2641,10 @@ static void enic_iounmap(struct enic *enic)
 static void enic_sriov_detect_vf_type(struct enic *enic)
 {
 	struct pci_dev *pdev = enic->pdev;
-	int pos;
+	u64 supported_versions, a1 = 0;
 	u16 vf_dev_id;
+	int pos;
+	int err;
 
 	if (enic_is_sriov_vf(enic) || enic_is_dynamic(enic))
 		return;
@@ -2669,6 +2671,23 @@ static void enic_sriov_detect_vf_type(struct enic *enic)
 		enic->vf_type = ENIC_VF_TYPE_NONE;
 		break;
 	}
+
+	if (enic->vf_type != ENIC_VF_TYPE_V2)
+		return;
+
+	/* A successful command means firmware recognizes
+	 * VIC_FEATURE_SRIOV; supported_versions is available
+	 * for sub-feature versioning in the future.
+	 */
+	err = vnic_dev_get_supported_feature_ver(enic->vdev,
+						 VIC_FEATURE_SRIOV,
+						 &supported_versions,
+						 &a1);
+	if (err) {
+		dev_warn(&pdev->dev,
+			 "SR-IOV V2 not supported by current firmware. Upgrade to VIC FW 5.3(4.72) or higher.\n");
+		enic->vf_type = ENIC_VF_TYPE_NONE;
+	}
 }
 #endif
 
diff --git a/drivers/net/ethernet/cisco/enic/vnic_devcmd.h b/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
index 605ef17f967e..7a4bce736105 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
@@ -734,6 +734,8 @@ enum vic_feature_t {
 	VIC_FEATURE_VXLAN,
 	VIC_FEATURE_RDMA,
 	VIC_FEATURE_VXLAN_PATCH,
+	VIC_FEATURE_PTP,
+	VIC_FEATURE_SRIOV,
 	VIC_FEATURE_MAX,
 };
 

-- 
2.43.0


