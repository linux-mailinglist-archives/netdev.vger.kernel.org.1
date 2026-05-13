Return-Path: <netdev+bounces-287655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBHOBbKiBGogMQIAu9opvQ
	(envelope-from <netdev+bounces-287655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:11:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8348C536CFD
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E4CC31EA68C
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EBE4CA274;
	Wed, 13 May 2026 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="K8cXbqVD"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DE248A2B3;
	Wed, 13 May 2026 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685432; cv=none; b=T2gbcmGI0VpRGVUngy9HToWkAeJmTxMe8N9e8I8yjrQ+OBIrbYxKXrixhJVrzgQkN29Hpbyq47QR9UEyCoHkZqcHN1YdLaFeCmhBwDNyyumMgEMJ9TJalAJ0Onz4rIbQXZasxF18E+j0a1GejHJyT8tAXYIPHU0i4CcCeDaYFcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685432; c=relaxed/simple;
	bh=ZXSTJ7b/38rgvmYO873buvlool6i84d5a2ZJr/9ipT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QeVMnQnpJenJ/DkBbkA3IluoTh7Jh/7/RtSGtDZ2nmao6NR+nEeeBuXDHlahuPy3Z4IIQbsSA+tQ6rc9BS66FjpcPZ6Mli/bkn4Fo++G/N7/j/q/vLYQSuYt8n4cAyxiY96ZjaEm1WX47djNzN9vA+I2kFy/iQ2eu3LHSh2TQCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=K8cXbqVD; arc=none smtp.client-ip=173.37.142.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2512; q=dns/txt;
  s=iport01; t=1778685430; x=1779895030;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Ks0lsgTrBdaqV3gPaDF/jXpyLgWa4qOq0Cl3j1wSwFo=;
  b=K8cXbqVDsezk6vXedQNFZs90DTuq7JG6/OrX0aS/Fgxvm3BLD58gk63i
   elC+k8RA68m06HP4ONT8ZCkaWlZkEsYhCB1nb2RqoDu6tK6IEH8ztsyFo
   CYYQlLGOZXKSR85yK53oEIIAj1LRFt3QMLT9FAUaHpVXRy2KQhcE29Vvk
   UfAqkbqh7FLWGibLrYetkdkKGAnrtPm32SykzV+LlnYJUnNct7Rwu/YsU
   Fa5G1nKL0mjqyggsxl47ybT/LLFyS7bP9/GI4jTuRut9f1DClAqooUCAS
   lqwInt86EgAoojSo6Hez81nEEJm7GAfWT+gc59hMDUaI8wI9angmLO28/
   g==;
X-CSE-ConnectionGUID: IQ6p2cuGRaWMtEcw5YwUTQ==
X-CSE-MsgGUID: lxTTmaoLQFiRH0JwJwW2IA==
X-IPAS-Result: =?us-ascii?q?A0BFAgCnlARq/5D/Ja1aHgEBCxIMggULgleBUENJhFePU?=
 =?us-ascii?q?4Ihnh2Bfw8BAQEPUQQBAYUGAo0yAiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQsBA?=
 =?us-ascii?q?QUBAQECAQcFgQ4ThlyGWwIBAyMEUhAlAiYCAkYQBgESgwKCdAOzDHp/M4EBh?=
 =?us-ascii?q?H3ZRIFkAQsUAYEKLoVygmcBgXCEBjuEQCcbgUlEhH2ECoQUgmkEgxwUjngJP?=
 =?us-ascii?q?4ECHANZLAFVEw0KCwcFYVIzAyAKCxISGBUCFC8PBBYyHXAMJxIsFzNYGwcFg?=
 =?us-ascii?q?UuCBXIUMQQhgQKEX3gjLANOgUMDCxgNSBEsNwYOGwQ9AW4Hij8dD4E/cT1Sg?=
 =?us-ascii?q?mgpk0CDMo1da6EOhCaBZKAOATKXZpMFLJhaIqNPMTeEaIFoPIFZMxoIGxWDI?=
 =?us-ascii?q?lMZD44tFhzMHycyPwcCBw4CkXOBfQEB?=
IronPort-Data: A9a23:sunFdqNaoVEpGJjvrR14lsFynXyQoLVcMsEvi/4bfWQNrUomhjEAz
 zEcCGiBbvrbMzb8f4xzOdu1/RtTuZ6Bm9ExQXM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFTmE+kvF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WVjlV
 e/a+ZWFZgf4gmUsawr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj69RXUllsNpA3wO9IJH1j/
 uNFGS8wUinW0opawJrjIgVtrt4oIM+uOMYUvWttiGmGS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2MzMHwsYDUXUrsTIIk3gOazhnr/WzZZs1mS46Ew5gA/ySQui+i9boaPJYTiqcN9mlakm
 mfP+EDALBAgFIS91hiazSiNr7qa9c/8cMdIfFGizdZmiUOew0QfAQMbUF+8r+X/jEOiM/pbJ
 k0I8y0GoaU49UWtCN7nUHWQrXKZuxcOVsZ4HOo95wWAjKHT5m6xBXUORxZCZcYguctwQiYlv
 neAmd/zCCMstrCJRX+D3rOJqzX0Mih9BXcLbyICTCMf7tXjqZ11hRXKJv5nEaionpj2FCv2z
 jSisicznfMQgNQN2qH9+krI6xqqq4TFQxAd+AraRCSm4xl/aYrjYJangWU39t5aJ4qfC13Et
 38elo3Gs6YFDIqGk2qGR+Bl8KyV2stp+Qb02TZHd6TNPRz0k5J/Vei8OA1DGXo=
IronPort-HdrOrdr: A9a23:I0f3WaBgZVcb+CjlHela55DYdb4zR+YMi2TDGXoBLSC9Ffb4qy
 nOppomPHDP5Qr5NEtLpTnEAtjjfZq+z/FICPcqXYtKNTOO0ACVxcNZnOjfKlbbdxEWmNQtsJ
 tIQuxSBML9CF5igd2/wgWpeuxQueWvweSEifjTynF1QRovUaFv6A9lFh2We3cGIjWufaBJc6
 a0145guyeqf2gRY4CQA3kIWPWGmvjw/aiWGSLvw3UcmXOzZfTC0s+ALySl
X-Talos-CUID: =?us-ascii?q?9a23=3A/aWCJWg0SeH91c4GP49utRquFDJuU0SD1C3bPmC?=
 =?us-ascii?q?CAFlMVJCeVgKh555Yqp87?=
X-Talos-MUID: 9a23:8B8rXQlE5rRwputNpqspdnpmJPtU5q2pLHkjkK8m4+ubFzNPYRa02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,232,1770595200"; 
   d="scan'208";a="738864270"
Received: from rcdn-l-core-07.cisco.com ([173.37.255.144])
  by alln-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 13 May 2026 15:16:01 +0000
Received: from [127.0.0.1] (unknown [10.25.128.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-07.cisco.com (Postfix) with ESMTPS id DFE6618000488;
	Wed, 13 May 2026 15:16:00 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Wed, 13 May 2026 08:15:38 -0700
Subject: [PATCH net-next v7 01/10] enic: verify firmware supports V2 SR-IOV
 at probe time
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-enic-sriov-v2-admin-channel-v2-v7-1-68b9f4141f4c@cisco.com>
References: <20260513-enic-sriov-v2-admin-channel-v2-v7-0-68b9f4141f4c@cisco.com>
In-Reply-To: <20260513-enic-sriov-v2-admin-channel-v2-v7-0-68b9f4141f4c@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778685359; l=2560;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=ZXSTJ7b/38rgvmYO873buvlool6i84d5a2ZJr/9ipT8=;
 b=MSKkInVxZuIElMBIkob/qj/611krs0sY/clVnTdAZ2FS2XmDRI22UTRTEdkjdd/mJK+zM9ZtT
 sThThUrX8M5BQHMTetSwfzm3MREO3L8HNb8QS1y5rKCX0uHClBsEyEN
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.216];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.216, [10.25.128.216]
X-Outbound-Node: rcdn-l-core-07.cisco.com
X-Rspamd-Queue-Id: 8348C536CFD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287655-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[cisco.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cisco.com:email,cisco.com:mid,cisco.com:dkim]
X-Rspamd-Action: no action

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


