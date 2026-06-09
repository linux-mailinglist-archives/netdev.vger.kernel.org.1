Return-Path: <netdev+bounces-297168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CHTSHntCKGrVBAMAu9opvQ
	(envelope-from <netdev+bounces-297168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:42:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10020662860
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:42:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=Bvtcjvz7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297168-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297168-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cisco.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74C463104028
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 16:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8A4496900;
	Tue,  9 Jun 2026 16:32:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C423B840F;
	Tue,  9 Jun 2026 16:32:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022770; cv=none; b=TyvBrdE8+AEtdFAF4pR4U7qQnAjshnGcbcXRK+8B7sXCZJ8lIy8+GiTJCO6vW5vmRHqNjgPisv9RKfrPt5XM6aLXUiiymxdyU4szvlR7WIrDCBh2Hj4CVy8rTNsrDxIwTX0RbmzXfN9QOIgR07uLi91iYAEaTSBst7pqgQFaWmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022770; c=relaxed/simple;
	bh=t34WFg1OJPAyXY9QMriV4a3e8O+6EvDBd8KRpI56OF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jlqhhgdkfd+LQLG8pDpml0NhHiGmZWgVQf0YUTywU3NIRhnJMniI54W+/8fvZfzql+HGafMXlux+B2Vktpfy9IPWkm6hZHHd03r+zJ/nyHk3AS+MrNizI59wnqAbL1QIbefkdzPpnSrkT/9SBXfX7nYDiiSXRFL0xbMNxqFtl/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=Bvtcjvz7; arc=none smtp.client-ip=173.37.86.77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2592; q=dns/txt;
  s=iport01; t=1781022768; x=1782232368;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=EQWp/i9x4NzDrC5VaN05TPdpcwXUJymdJW1VclAN818=;
  b=Bvtcjvz7Fqk9cl7eMQstpI6Bu4X3cbVFcq85qTa8FDHK+qFPwOEIRIyg
   jTvBLlKqXNYMbanF2TbCrbmohF86wgVk05P31UK8A+l6B7ZzESk1zCYBL
   wG9MFmQqZr6axhJkb8I929kF2YzMPOQ8jWaF3mxb6JeUBpQXQkWaEGUgU
   vlQv+XjGSTWY8VVTaU/kjO5juVTxIWDl1/BjOhQRFityHK3nMCBlFK1G2
   +70pM0yzfLCHmSryhmAqmPF7AH9xyXM48sIwiZE8xemrUpw6cYTgNHTG4
   kmxUD7w6fOt2qarTW0VYnX5gNiA5kjDV+OT2EkX8dI2so0PvAzl9xnubC
   A==;
X-CSE-ConnectionGUID: HjUIZSZRQRuFC70osNjTVw==
X-CSE-MsgGUID: 9wzlIQReQmSu2YDzlhHH9g==
X-IPAS-Result: =?us-ascii?q?A0AaAAAaPyhq/4//Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AcBAQsBglaBUkNJhFeIHIc3giGeHoF+DwEBAQ9RBAEBhQYCjTcCJjQJDgECB?=
 =?us-ascii?q?AMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGXIZbAgEDIwRSECUCJgICR?=
 =?us-ascii?q?hAGARKDAoJ0A7Ugen8zgQGEfdlFgWYBCxQBgQouAYVwgmkBgXCEBjuEQScbg?=
 =?us-ascii?q?UlEhH2ECoQUgmoEgxwSkGcJP4ECHANZLAFVEw0KCwcFYVIzAyAKCxISGBUCF?=
 =?us-ascii?q?C8PBBYyHXAMJxIsFzRYGwcFgUqBOxQxBCGBBYUSIx8DOYEVgXyBKGdpFTE1T?=
 =?us-ascii?q?QMLGA1IESw3Bg4bBD0BbgeMOhcPgUhxPVKCaCmTQIMyjV9roQ6EJoFmoA8BM?=
 =?us-ascii?q?pdnkwQsmFoio383hGiBaDyBWTMaCBsVgyJTGQ+OLRYcy2InMj8HAgcPApFzg?=
 =?us-ascii?q?X0BAQ?=
IronPort-Data: A9a23:5HvLKKj68W+CDrn2pFq5Sv7eX161vREKZh0ujC45NGQN5FlHY01je
 htvCj3SaP2LMWXycoxyao3j8hsDu5bUnd8wQQI6/n01EC9jpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOOn9SUgvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZeDULOZ82QsaDxMtfrS8EoHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqU4+NtWM1p8z
 8UiNR4mMUiEnMS0/IykH7wEasQLdKEHPasFsX1miDWcBvE8TNWbHePB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWZgx/5JEWxI9EglHkeiFZs1KWpYI84nPYy0p6172F3N/9Jo3QHJwKxRfEz
 o7A1zXmEBU7DeaS8D++7yidqv3LnQPbCY1HQdVU8dYv2jV/3Fc7BBQIWF6TrfCnh0u6XNxDb
 UoZ5kIGqaUz6EWsZtXwVRyxpjiDpBF0c9dcDugz+gyR4qXT5AmdCy4PSTspQN87vsYeRjEw0
 FKN2dTzClRHubuZU3+CtbGZsT+/JwARMGkEIyQEJSMd6tPupoAblB/DTt9/VqWyi7XdHTD23
 iDPryUkgbgXpdAE2r/9/l3dhT+o4J/TQWYd4AjLUm+7xh12aZTjZIGy71Xfq/FaI+6kokKpp
 nMInY2aqesJF5zIzHLLS+QWF7bv7PGAWNHBvWNS81Aa32zF0xaekUp4uVmS+G8B3h44RALU
IronPort-HdrOrdr: A9a23:v3+56q//lk+a5gj9xlVuk+AuI+orL9Y04lQ7vn2ZhyYlFvBw8P
 rOoB1773HJYVkqNU3I9errBEDEewK/yXcX2+Ys1MmZPDUO0VHAROpfBMnZsl7d8kbFmtK1u5
 0QFpRWOZncAUd3iMDi7BL9MdoxqeP3iZyAtKPyw2hgSAdyZ7ol1Qd2DQ6HDlZ7LTM2Y6bRbK
 DsgfZvln6HZWkdaNi9Cz0uWujOoMCOqbfdCCR2fyLOLGK1/EmVAHmQKWni4isj
X-Talos-CUID: =?us-ascii?q?9a23=3A0R9vc2l+OrwHSbJ50MIV87x8lPPXOV3f8VbiGH2?=
 =?us-ascii?q?CMFx0ZpbKEViL3qFYrdU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AKLNanQ9ITICmn5RpfGFzjGeQf5Z38aCPMXoAqJA?=
 =?us-ascii?q?9ppO1GT50Oxe93TviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,196,1774310400"; 
   d="scan'208";a="492117394"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 09 Jun 2026 16:32:47 +0000
Received: from [127.0.0.1] (unknown [10.25.128.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPS id 1E9F51800025F;
	Tue,  9 Jun 2026 16:32:47 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Tue, 09 Jun 2026 09:32:27 -0700
Subject: [PATCH net-next v8 01/10] enic: verify firmware supports V2 SR-IOV
 at probe time
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-enic-sriov-v2-admin-channel-v2-v8-1-8ad8babbb826@cisco.com>
References: <20260609-enic-sriov-v2-admin-channel-v2-v8-0-8ad8babbb826@cisco.com>
In-Reply-To: <20260609-enic-sriov-v2-admin-channel-v2-v8-0-8ad8babbb826@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781022766; l=2641;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=t34WFg1OJPAyXY9QMriV4a3e8O+6EvDBd8KRpI56OF4=;
 b=5U3PkOkHztm46C+fy23gls+YYxBUDl8TBDpJ5ChFS63osb9PRZHL2lAOtZIcJcLOOaeEwV4Bz
 uBk0v6ZXgiMC5HJhYWbT4LvCA9g+fhq6vqbwVSTr/xOCyG90QHaKx7R
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.186];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.186, [10.25.128.186]
X-Outbound-Node: rcdn-l-core-06.cisco.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[cisco.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297168-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sebaddel@cisco.com,m:satishkh@cisco.com,m:leitao@debian.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[cisco.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,cisco.com:dkim,cisco.com:email,cisco.com:mid,cisco.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10020662860

During PF probe, query the firmware get-supported-feature interface
to verify that the running firmware supports V2 SR-IOV. Firmware
version 5.3(4.72) and later report VIC_FEATURE_SRIOV via
CMD_GET_SUPP_FEATURE_VER. If the firmware does not support the
feature, set vf_type to ENIC_VF_TYPE_NONE and log a warning so the
admin knows a firmware upgrade is needed.

VIC_FEATURE_SRIOV is assigned the explicit value 4 to match the
firmware ABI.  Slot 3 (firmware's VIC_FEATURE_PTP) is reserved with
a comment rather than a placeholder enum entry, since PTP is not
used by the upstream driver.

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
index 605ef17f967e..3b6efa743dba 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_devcmd.h
@@ -734,6 +734,8 @@ enum vic_feature_t {
 	VIC_FEATURE_VXLAN,
 	VIC_FEATURE_RDMA,
 	VIC_FEATURE_VXLAN_PATCH,
+	/* slot 3 reserved for firmware VIC_FEATURE_PTP */
+	VIC_FEATURE_SRIOV	= 4,
 	VIC_FEATURE_MAX,
 };
 

-- 
2.43.0


