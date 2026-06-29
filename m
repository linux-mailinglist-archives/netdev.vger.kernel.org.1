Return-Path: <netdev+bounces-302740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JuslGnusQmoq/gkAu9opvQ
	(envelope-from <netdev+bounces-302740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:33:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4356DDC4D
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:33:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=NvjibTw0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302740-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302740-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cisco.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE1FD303CF77
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1B446AEFB;
	Mon, 29 Jun 2026 17:26:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C8E419311;
	Mon, 29 Jun 2026 17:26:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753967; cv=none; b=ucgpQYQYN6jgaq9cZPpNCKiPnzRlhTUe+AXLBI6c0FwZG+DTTJY1YCuPHe6QgEA4e4BAjyTfsztlSnC2uV8UEYaU4lEun4MHUW7NISWKV/VMUQCaQIJjgn3EjmdWeCvJU7URzNk68sxVGRDSc//YVV5BQC4YEU2BGwkZhibSmoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753967; c=relaxed/simple;
	bh=YVWsyqYoWW2CBtx69JGJIcwhXeNE01ExeOEUnkKHohk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JmkT6LrXWsKTBI3jnKLzMkjs+rsqYqtWKSLGlrnX2vLGvNL2nd/B1RZNm2UHTO0qGB21hw9O1aGrEZWT69FaLbD+J+3Dsvqi3axiPZOKZoClqiXzz9vEPtZWYNC2Yf6B/iJKL8JeJibhI9EsZwKtYvusCXsavdzjDjymfNtolUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=NvjibTw0; arc=none smtp.client-ip=173.37.86.74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2855; q=dns/txt;
  s=iport01; t=1782753965; x=1783963565;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=oTv31BzNQWB8toTQcOW/4vIULMI6fm0ZPo7b9hMRs+Q=;
  b=NvjibTw0KkgToQ+r15t7dAgHTa+JxyyIP7F4us44B6xJ5mkGX29Ca6iw
   5pYdgM45SGUk23Oi8yVYh7I+P2MdyyaMg4YTGWfTWCbmHIlXDxOtNgzQs
   7ie3XSutseNZ+bvnBS4oz01DstKDCRLZhVx2tkYT2DpmQjgYdTtyWiBYg
   C1iQaOxTJivrsGcM9zfyv15XtPytYADettXWl+7XxNcXTkwITou/WW69R
   68zdQRl6VWyZwhxJnzIXhHXdZIMrfo7B0OjmpGWn1goHR1KxjyFKUJPvk
   S1yB7uVnIK5RbGJVzHlQk+EOME8o1u/NtXZSpsjYxk0iCo5jSsSL5VzLl
   g==;
X-CSE-ConnectionGUID: KEe4vVFeQmaGaVUnYu7HFg==
X-CSE-MsgGUID: Asd8LFKxQmqypxi+stsL4Q==
X-IPAS-Result: =?us-ascii?q?A0DHAgBUqkJq/5D/Ja1aHgEBCxIMggULgleBUkNJhFePU?=
 =?us-ascii?q?4Ihnh6Bfg8BAQEPUQQBAYUGAo1LAiY1CA4BAgQDAgMBAQEBAQEBAQEBAQsBA?=
 =?us-ascii?q?QUBAQECAQcFgQ4ThlyGWwIBAyMEUhAlAiYCAkYQBgESgwKCdAO4c3p/M4EBh?=
 =?us-ascii?q?H3ZRoFmAQsUAYEKLoVxgmoBgXCEBjuEQScbgUlEhH6ECoQUgmoEgxwSkQYJP?=
 =?us-ascii?q?4ECHANZLAFVEw0KCwcFYVIzAyAKCxISGBUCFC8PBBYyHXAMJxIsFzRYGwcFg?=
 =?us-ascii?q?R2BFS8EIYEEhH0jHwM5f4EwdVhmFTA1gREeCoFSJwMLGA1IESw3Bg4bBD0Bb?=
 =?us-ascii?q?geMXRcPgUxxPVKCaCmTQIMyjV9roQ+EJ4FmoA8BMpdnkwUsmFwjpAA3hGiBa?=
 =?us-ascii?q?QE6gVkzGggbFYMiUxkPji0WHMw/JzI+AQcCBw8CgXOQAIF9AQE?=
IronPort-Data: A9a23:hWE8kKPdsJFrWe/vrR14lsFynXyQoLVcMsEvi/4bfWQNrUorg2RWn
 2EcCziHPauCNDbxKdt0a4i3/RgPsJOHnINhT3M5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFTmE+kvF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WV/lV
 e/a+ZWFZgf7gW8sawr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj69ZDAR0oA6MVw+N+Lmhwy
 PopNW8tQB/W0opawJrjIgVtrt4oIM+uOMYUvWttiGmGS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2MzMHwsYDUXUrsTIIk3gOazhnr/WzZZs1mS46Ew5gA/ySQsiOKzbYCLJ4PiqcN9t12U9
 kbo3HTABwgLLMyeiiGZ6Vbwv7qa9c/8cMdIfFGizdZmiUOew0QfAQMbUF+8r+X/jEOiM/pbJ
 k0I8y0GoaU49UWtCN7nUHWQrXKZuxcOVsZ4HOo95wWAjKHT5m6xBXUORxZCZcYguctwQiYlv
 neAmd/zCCMstrCJRX+D3rOJqzX0Mih9BXcLbyICTCMf7tXjqZ11hRXKJv5nEaionpj2FCv2z
 jSisicznfMQgNQN2qH9+krI6xqqq4TFQxAd+AraRCSm4xl/aYrjYJangWU39t5aJ4qfC13Et
 38elo3Gs6YFDIqGk2qGR+Bl8KyV2stp+Qb02TZHd6TNPRz3k5J/Vei8OA1DGXo=
IronPort-HdrOrdr: A9a23:Kp6+e6me2VfZbNec/Z/aIg86qinpDfLa3DAbv31ZSRFFG/FwWf
 re+MjzsiWUtN9xYh8dcL+7VZVoLUm3yXcx2/hyAV7AZmbbURWTTL2KhLGKq1bd8m/Fh41gPM
 xbH5SWZueAaGRSvILW7Ba1FtA4zMLC0qy57N2utktFfEVGZ75t6gFhBh3eKE15QwFaGYE0fa
 DsgPav3wDQHkg/X4CcGmQPWfTFqpngkZLrZgNDOjscgTP+9Q9BLNXBYmKlNtB0aUI1/Ysf
X-Talos-CUID: 9a23:IZyBx222jEArB+JuvnrQn7xfOe0oLmPj4nrpJkaXAFhUToyIFn++9/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3A/3I7yA1jW/nb9QgKWkwnCm6OhzUjyr+iWGQjsoU?=
 =?us-ascii?q?/vtCVLTxxeCyBlxDre9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,232,1774310400"; 
   d="scan'208";a="502652657"
Received: from rcdn-l-core-07.cisco.com ([173.37.255.144])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 29 Jun 2026 17:25:59 +0000
Received: from [127.0.0.1] (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-07.cisco.com (Postfix) with ESMTPS id 4FADF180000B5;
	Mon, 29 Jun 2026 17:25:58 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Mon, 29 Jun 2026 10:25:54 -0700
Subject: [PATCH net-next v10 02/12] enic: verify firmware supports V2
 SR-IOV at probe time
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-enic-sriov-v2-admin-channel-v2-v10-2-62569af83417@cisco.com>
References: <20260629-enic-sriov-v2-admin-channel-v2-v10-0-62569af83417@cisco.com>
In-Reply-To: <20260629-enic-sriov-v2-admin-channel-v2-v10-0-62569af83417@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782753956; l=2904;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=YVWsyqYoWW2CBtx69JGJIcwhXeNE01ExeOEUnkKHohk=;
 b=Fe2Vi6PFy+RaSWKGeSTV1R3caTBUWbg59bHt2Je+9B4XdP8AGk5LnxCigVVoVlD+I1HXw1213
 0Zmhm3bE0gVBrVMa4Jyll96DV0WQWhunJKDbRut92+KwcoD7pQ1IRdN
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.130.254];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.130.254, [10.25.130.254]
X-Outbound-Node: rcdn-l-core-07.cisco.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[cisco.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302740-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,cisco.com:dkim,cisco.com:email,cisco.com:mid,cisco.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E4356DDC4D

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


