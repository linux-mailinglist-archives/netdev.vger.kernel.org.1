Return-Path: <netdev+bounces-304637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WkpyM8X6R2q+iQAAu9opvQ
	(envelope-from <netdev+bounces-304637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:09:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6251704C3D
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:09:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=BlBBoIip;
	dmarc=pass (policy=reject) header.from=cisco.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304637-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304637-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95105301B903
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 18:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462DA2F7EEF;
	Fri,  3 Jul 2026 18:09:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46072DC78C;
	Fri,  3 Jul 2026 18:09:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783102145; cv=none; b=APBw4Nwkd1LJeJbshSPp6QeMSn9O7mHssjof00xUuRUgNiLVWYcuk2ngyjQiUWi4dm6CZYG/UQYAdKUUPckhJbwOh4twgIRakEoLD/1Z5QagTiXF1fSgBHNgU14nDjo1uJ79mENbkPphU8QcZl6VkxjPKOnNgLq8E4imr8eM9E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783102145; c=relaxed/simple;
	bh=YVWsyqYoWW2CBtx69JGJIcwhXeNE01ExeOEUnkKHohk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YVXO3lOUDAP2oZ+y6KlbSKiwvEQQ3//LrlCGp/SslqKHZRJ7jPZvfWGLSXqG6i+XmJSfDI6eqi1JkZEG+MIoiPvwmkFYVpyQWXZMZ0+aILb1onP9/+5FW0exCT4jRZ71qxBqK5WPPiE4/h9kQkvzHltO4DwSxpjWOx0tzpFRHpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=BlBBoIip; arc=none smtp.client-ip=173.37.86.72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2855; q=dns/txt;
  s=iport01; t=1783102143; x=1784311743;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=oTv31BzNQWB8toTQcOW/4vIULMI6fm0ZPo7b9hMRs+Q=;
  b=BlBBoIip5wNmqbqCj7AZYpYJPIEejpNua+zQ2EnID+l8/lUCmQHjvjl3
   +CJWGH/MRw6Qni4I/XtDtu/oqtaXs5Oty2zFyXF8/XTN32iuMYdUk/dw1
   eF2nVzmA9uuF4ZoNyGQo1URoGWRU/RviD0FMjKkBcu9BGkUVsyX8bv97u
   xVWB6q59VskSfAhDwESAYge30eXHWHL/OM591uhjhWDqXyhxJldmMlswk
   jD6c9D2VoWiT7EdlggfSPorqBCeLEDbkNAZpqdS7bp1LXmkSorMI3PC+o
   8VRUxnu8RHUvWSmAAuHTPjb15T96VA6VtUWI4hr+jvXolmE+Eq99WiPUX
   w==;
X-CSE-ConnectionGUID: ZG/nh3fQT1ep3TPgE2zXAQ==
X-CSE-MsgGUID: wBa9u6QGTYqsI+mHrDRc4g==
X-IPAS-Result: =?us-ascii?q?A0D7AgDU+Udq/5P/Ja1aHgEBCxIMggULgleBUkNJhFePU?=
 =?us-ascii?q?4Ihnh6Bfg8BAQEPUQQBAYUGAo1LAiY2Bw4BAgQDAgMBAQEBAQEBAQEBAQsBA?=
 =?us-ascii?q?QUBAQECAQcFgQ4ThlyGWwIBAyMEUhAlAiYCAkYQBgESgwKCdAO8BXp/M4EBh?=
 =?us-ascii?q?H3ZRoFmAQsUAYEKLoVxgmoBgXCEBjuEQScbgUlEhH6ECoQUgmoEgxwSkR8JP?=
 =?us-ascii?q?4ECHANZLAFVEw0KCwcFYVIzAyAKCxISGBUCFC8PBBYyHXAMJxIsFzRYGwcFg?=
 =?us-ascii?q?R2BFTEEIYEEhHkjHwM5f4EwdUp5M4ECARIeCoFSgSYDCxgNSBEsNwYOGwQ9A?=
 =?us-ascii?q?W4HjQAXD4FMcT1Sgmgpk0CDMo1fa6EPhCeBZqAPATKXZ5MFLJhcI6QAN4Rog?=
 =?us-ascii?q?W8DMoFZMxoIGxWDIlMZD44tFhzSHicyPgEHAgcPAoFzkACBfQEB?=
IronPort-Data: A9a23:qvFzEKr3Ci5yj5avSV8pwoIAyndeBmLFZBIvgKrLsJaIsI4StFCzt
 garIBmCPvnZM2Oked93ao+zphwAvsWGzdEwTlBoqiw1QSxB+ePIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9j8kif3gqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYgLNNwJcaDpOtfrc8Eg35pwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0tRYRmdOr
 vIhFGkAdku/v+2bmqCLY9A506zPLOGzVG8ekmtrwTecCbMtRorOBvySo9RZxzw3wMtJGJ4yZ
 eJANmEpN0uGOUASfA5LV/rSn8/w7pX7WyZRtFOOpak3y2PS1wd2lrPqNbI5f/TXHZkMzhzD+
 zuuE2LRHTsTZcHB8BW5w2u3p6zKvTnXYolOG+jtnhJtqBjJroAJMzUaXEW2pNG1g1CzXtZYJ
 VBS/CcyxYA2+U23R97VUxCyoXeC+BkGVLJ4HuEn7Qifx7b87AGeCWwJCDVGbbQOt9I8TBQp2
 0WPktevAiZg2JWcT36H+6jXqz6uNSULBWsfYylCRgtty8Hqqow1jzrVQ9pjGbLzhdrwcRn0w
 jaXvG09iq8VgMojyaq25xbEjiiqq5yPSRQ6ji3RU36p4x1ReoGofcqr5ELd4PIGK5yWJmRtp
 1AekMSYqeRLBpaXmWnUGKMGHaqi4LCONzi0bUNTIqTNPg+FoxaLFb28KhknTKu1Gq7ooQPUX
 XI=
IronPort-HdrOrdr: A9a23:7f+izarkFi2yX1KyejEfnR0aV5rdeYIsimQD101hICG9vPbo8/
 xG+8576faUslgssR4b9OxoVJPrfZqYz+8W3WBzB9iftXfd2FdARbsKheDfKn/bak7DH4VmuZ
 uIHZIObeHYPBxWgdn35Q+gH81l4tWWmZrY/Nv2/jNBQR5nbqd44xw8MAaUFUVqWBJLbKBJcq
 Z0nvA3wAaISDAwctmxAGUDUqzoot3Gk4+jXDs9biRXkDVnSViTmcTH+9/y5GZkbw9y
X-Talos-CUID: 9a23:/2fVO2+czjs7FN1IJlKVv3w7XcYlKXPk8C7dOxSEMWlEEq+lYGbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AYs590Q8BU+IfUKHA30ILmBeQf9hC6vWzVnkiraQ?=
 =?us-ascii?q?foOjHMAxqFw2W0DviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,145,1779148800"; 
   d="scan'208";a="504182351"
Received: from rcdn-l-core-10.cisco.com ([173.37.255.147])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 Jul 2026 18:08:57 +0000
Received: from [127.0.0.1] (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-10.cisco.com (Postfix) with ESMTPS id 6136818000A6B;
	Fri,  3 Jul 2026 18:08:56 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Fri, 03 Jul 2026 11:08:51 -0700
Subject: [PATCH net-next v11 02/12] enic: verify firmware supports V2
 SR-IOV at probe time
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-enic-sriov-v2-admin-channel-v2-v11-2-5b739f1fe9e5@cisco.com>
References: <20260703-enic-sriov-v2-admin-channel-v2-v11-0-5b739f1fe9e5@cisco.com>
In-Reply-To: <20260703-enic-sriov-v2-admin-channel-v2-v11-0-5b739f1fe9e5@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783102134; l=2904;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=YVWsyqYoWW2CBtx69JGJIcwhXeNE01ExeOEUnkKHohk=;
 b=cAsunPHnoSfG+Tb9TScq9r4lRcQ/vSmP7DyFze7MrUTLrQ7Hwmb7v57QV6fy5dC+HkG+V6Mxg
 EykJMFNhRqzCJVvJkaBq/yK0Pe3QQuEB0boDST9yNFZJKmeycsNi9Go
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.130.254];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.130.254, [10.25.130.254]
X-Outbound-Node: rcdn-l-core-10.cisco.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[cisco.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304637-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cisco.com:from_mime,cisco.com:email,cisco.com:mid,cisco.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6251704C3D

During PF probe, query the firmware get-supported-feature interface
to verify that the running firmware supports V2 SR-IOV. Firmware
version 5.3(4.72) and later report VIC_FEATURE_SRIOV via
CMD_GET_SUPP_FEATURE_VER. If the firmware does not support the
feature, set vf_type to ENIC_VF_TYPE_NONE and log a warning so the
admin knows a firmware upgrade is needed.

V2 VFs are only ever enabled later through the sysfs .sriov_configure
path (enic_sriov_configure()), which rejects ENIC_VF_TYPE_NONE before
calling pci_enable_sriov(); there is no probe-time auto-enable, so
firmware that lacks V2 support never exposes VFs.

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
index b65796d96efc..6992411bd3b5 100644
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


