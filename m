Return-Path: <netdev+bounces-283585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEG6B1ww92lbdQIAu9opvQ
	(envelope-from <netdev+bounces-283585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 13:24:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 409024B5408
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 13:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 444B93001CC1
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 11:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0E9319847;
	Sun,  3 May 2026 11:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="MLuD6GMa"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-7.cisco.com (alln-iport-7.cisco.com [173.37.142.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02699346A19;
	Sun,  3 May 2026 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777807447; cv=none; b=Ny9qmfdPfFhqtTPvTSE8sV8U/+t81hPTu1IV0aKj8xBjcADPhmwMGqag2OWvZlw52rU7xxDh6w5Q3EkvdT2ofq6FYvx0qrobNbzsihxw+K5F/KvyI3Sl6e6dTv5AfhwYN9YzKyW1lgtwjGqIQavHjvY2DIdsmZkG5Rl52PiVQpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777807447; c=relaxed/simple;
	bh=ZXSTJ7b/38rgvmYO873buvlool6i84d5a2ZJr/9ipT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tPXkAKtjQMqI38CSrjEYKQhmU6RRM7YVtpVp4NBkc4FoPc3AowVE/MezzUzKdnVkkZY8MLLvFgr3S3hAaFphwdO9la1vsn9oEwhZsx760+24tQwHGB6gQYOGFpGiKzE1V16sP9Xk+/96qQMucMwhXAXitXOii7umyoXvYvs1Zl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=MLuD6GMa; arc=none smtp.client-ip=173.37.142.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2512; q=dns/txt;
  s=iport01; t=1777807445; x=1779017045;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Ks0lsgTrBdaqV3gPaDF/jXpyLgWa4qOq0Cl3j1wSwFo=;
  b=MLuD6GMaI8rHxvjQHupQGONv1lbgGhh97oxJC3+GwORfK7RH+hj4iIyY
   ObC61GwCXYS1zg6VnLhFaW7U12ZJI/40NWBvfP81cD/SA8ApPmwyCa/h7
   k8jkNGuRrJ2YWWwO2kNPvgztS6N3OaQeR0tByXqQKkEOv4M/I5X3IVDLJ
   yI1fWyFRFBu0B3WcZ0Cbs+CzRqey/9D1UA7QyiZo/DS5ZBscBjhc24+9r
   DsSIcFZmyRIRcFawJqRoGmR0JAqFFUCYn14rKVk0bKO7KYjr9wPNftWQ1
   72KnN2gAPQGjMWUakmiVW8VrhDM3oT+nOiUjzGKUVEjVHA45N1aVP1wlV
   w==;
X-CSE-ConnectionGUID: lQA5TbGNStSS7yP/F4q2ug==
X-CSE-MsgGUID: Lhapr4DhRfS+NUwg/wxuaQ==
X-IPAS-Result: =?us-ascii?q?A0AnAADQLvdp/4v/Ja1aHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?laBT0NJhFeIHIc3giGeHYF/DwEBAQ9RBAEBhQYCjTECJjQJDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThlyGWwIBAyMEUhAlAiYCAkYQB?=
 =?us-ascii?q?gESgwKCdAO0Hnp/M4EBhH3ZQ4FkAQsUAYEKLgGFcYJmAYFwhAY7hD8nG4FJR?=
 =?us-ascii?q?IR9hAqEFIJpBIMcFI8bCT+BAhwDWSwBVRMNCgsHBWFSMwMgCgsSEhgVAhQvD?=
 =?us-ascii?q?wQWMh1wDCcSLBc0WBsHBYFLgwBtFDEEIYEFhGB4IywDTnIDCxgNSBEsNwYOG?=
 =?us-ascii?q?wQ9AW4HimYdD4E/cT1Sgmgpk0CDMo1da6EOhCaBZKAOATKXZpMFLJhaIqNPM?=
 =?us-ascii?q?TeEaIFoPIFZMxoIGxWDIlMZD44tFhzJPCYyPgEHAgcOAoFzkACBfQEB?=
IronPort-Data: A9a23:EpWWr6LKuZk+I1EKFE+RDJQlxSXFcZb7ZxGr2PjKsXjdYENShT0Oy
 WQeXT+OOPiOY2b8f48nPo+1/UpX7JXRxtVjQFEd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCSa/kvxWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVnW0
 T/Oi5eHYgH9hmYvajt8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1qNWhrAYc33N1rOloR5
 MRfBmwUNA2M0rfeLLKTEoGAh+w5J8XteYdasXZ6wHSBV7AtQIvIROPB4towMDUY358VW62BI
 ZBENHw2N0Wojx5nYj/7DLollfupnXn8cxVTqUmeouw85G27IAlZj+O0aIKPJIfULSlTtmKYr
 3rco0j5OB8hd/qi1jXC7WKxj9aayEsXX6pXTtVU7MVCjFSNy2k7BBQIWF6/pvelzEizR7p3L
 0EV5iMphaQ//k2iSJ/6RRLQiHOIoxsVSddMO+I97w6Jx+zf5APxLmsZRDdpa9E8ssIyAzsw2
 TehltXlHzFw87uYVX6Q6J+QsDW0fyMVRUcabCUJSwot+dTvoIgvyBnIS75LFK+zk82wGjzqx
 T2OhDYxiq9VjsMR0ai/u1fdjFqEoJXVQgMrzhvYU3jj7Q5jYoOhIYuy5jDmAe1oNo2VSByF+
 XMDgcXbtLpIBpCWnyvLS+IIdF2028u43PTnqQYHN/EcG/6FohZPoag4DOlCGXpU
IronPort-HdrOrdr: A9a23:+OmI46FGbMcXnA8+pLqEHseALOsnbusQ8zAXPo5KOHhom6uj9v
 xG/c506faaslsssR0b8+xofZPwI080lqQb3WBuB9eftWDd0QPCEGgh1/qA/9SKIUHDH4BmpM
 JdWpk7JdHuAV19lMrgpCu1A78bsaC62ZHtqOvAw3JqVA1wL5th4QBwFxqBHiRNNW977OICZf
 2hz/sCgSa8cnIKacn+LHwEU+/f4+DvrvvdEGY779pN0nj1sdtug4SKaCSl4g==
X-Talos-CUID: 9a23:S5MAd2F92bwZ1GX1qmJjzWdJJsoKVEbB90yPMnf/JzpwEqCaHAo=
X-Talos-MUID: 9a23:94MlBQaKhr73iuBTkz/lnCs+GMdS7Z/tLn0SntIZq9SNDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,213,1770595200"; 
   d="scan'208";a="731002636"
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by alln-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 May 2026 11:22:56 +0000
Received: from [127.0.0.1] (unknown [10.25.128.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTPS id EE384180007C5;
	Sun,  3 May 2026 11:22:55 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Sun, 03 May 2026 04:22:38 -0700
Subject: [PATCH net-next v6 01/10] enic: verify firmware supports V2 SR-IOV
 at probe time
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-enic-sriov-v2-admin-channel-v2-v6-1-0af4fbc2d86d@cisco.com>
References: <20260503-enic-sriov-v2-admin-channel-v2-v6-0-0af4fbc2d86d@cisco.com>
In-Reply-To: <20260503-enic-sriov-v2-admin-channel-v2-v6-0-0af4fbc2d86d@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777807374; l=2560;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=ZXSTJ7b/38rgvmYO873buvlool6i84d5a2ZJr/9ipT8=;
 b=oSM8F+SQt9tLJdFaI+2P7sK1nhrmX8yujytbRf3JpyExVl96gZ1JbjcCAO3xTd8Lf0UxHz3Ff
 h0gma6X5Xm3B5J8rwax/9PLpRh4A2d/nyUz8/aUR+TP1FusgHzpkSq6
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.216];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.216, [10.25.128.216]
X-Outbound-Node: rcdn-l-core-02.cisco.com
X-Rspamd-Queue-Id: 409024B5408
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283585-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[cisco.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cisco.com:email,cisco.com:dkim,cisco.com:mid]

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


