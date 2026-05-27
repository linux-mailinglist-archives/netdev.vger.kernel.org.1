Return-Path: <netdev+bounces-292095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEgLHrKAFmq7mwcAu9opvQ
	(envelope-from <netdev+bounces-292095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:27:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A70025DF6D2
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F2C33014250
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 05:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2C42F49F1;
	Wed, 27 May 2026 05:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="ZSnWy3WZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF6E250C06;
	Wed, 27 May 2026 05:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779859630; cv=none; b=Ys8NC/heWBAq2t46gqM2cfl3ipsNyba99A25o63vIwDWuyW9tEI0RSzI23WU01CgrpLh7+h5itQxd1FGhaO313tWIEPdni2D2hA07kjC1iV/vWZ1eYlnbpCyqGE5d1tKiPs6oxpacyi4mhNQvfwAHqe0eWajh0aSUO1rUx4Gwrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779859630; c=relaxed/simple;
	bh=K3HIturTWW4nvncpD8a50KSIe/3ajJxJCIDMqFq8vvA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bpZ1JM+vWjHgUy4OuwSJyk3GKk99gQw2+vjf3qcVWkjwFmkNCr2hHSpYQzupZw/jG9IpbVc0/v32OEQhiNrZfAVRnPv6l2m42nzCdT02NqDQwS4c7R4yQf1fwkzPjnJAqWHVjdX+heEcbs09s88eTpsJzV92pF7uGcpsT4xBTxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=ZSnWy3WZ; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R4tvgN2228738;
	Wed, 27 May 2026 05:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=L/Oi87Mh/
	PXWoPXQ4jtjhntE0HXE3WnQw4TTpobWTCw=; b=ZSnWy3WZynGBcVp4sdTa7lkeF
	gxTx/PybkWwg5qd2KWJCGipepk0SqOYCq23VPDoyaYpSNocOWgjohofenpskeIXC
	ZYYIS4AVzD/ROnfgjZJaUnbCXUSUR045hkFeKQS6YCvbtpvAYOcwXutMhYK1YWOr
	4pbUU5p7xr2WB2FfKxe9Z8/QvqVlADGrbXQyhhy2jf6xsqmOGK7jTYR67XFIJYiv
	7QhSSxPUIYO0TGAn8mR0J9kRAEx/Ytk2RymHbkYGEQ9AiiaCHk+pdqJcaVPYMbB2
	eoyw7CcWQwO3IFQAoH1YYxvWVXcVqhyZAYirHNBtrgVkflN0GUbr31EMIwEMg==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eb376d8d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 27 May 2026 05:26:30 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 26 May 2026 22:26:29 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 26 May 2026 22:26:26 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <horms@kernel.org>, <david+nfc@ixit.cz>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <yun.zhou@windriver.com>, <bongsu.jeon@samsung.com>,
        <oe-linux-nfc@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] nfc: nci: fix use of uninitialized memory in CORE_INIT_RSP parsing
Date: Wed, 27 May 2026 13:26:25 +0800
Message-ID: <20260527052625.3309581-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA1MCBTYWx0ZWRfXwWUTEWJ/fThv
 N3Rnib7XV8hE62iGAC35iOdC1xoZe3hzdlIz+OGn7iQ2SfbXOJ4MEs7jcrjeS3Z97m5l37+vec3
 BV6rgbn5DQEe03mehjgn5Y6Kp3P6Eom+p6pf8LRspmSas6lfVdWE4g99Ucxv906u3oe44sdocE+
 Q6xcLXBr+XGMusyfZWNd2Amm0EtGqrFzOWh3FYo6O6lwdF4nKIxXyASM5QLoezP1NX2lqCuMazP
 G53gSwZFlRCylqLKWO4CwQ7E/4BGy1xQ4/4v5/veV0QffdauZY39kz7XZJ5TOQFEeYshemVGEGP
 dG+yUb3saDMjmQQOMCfgJPC0z+0RALbV/nOvItGLTwmCW+DI7aWGgkx77sau8UzHRskDrlvpH+7
 EWWjvh1HLPeFZoRMXwFFrgv8ugkA3BvYLrHx09SWsKLvGhln/1q/Uh2tYMPGC8boonc/XP40+Hv
 XfBQHHD0uiNArFBzNIA==
X-Authority-Analysis: v=2.4 cv=M5B97Sws c=1 sm=1 tr=0 ts=6a168086 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=IDFcQ0WGl1NcD2azA7sA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: yIjUwoTfFDoIJPzrpZYp7cstBzS6DjZq
X-Proofpoint-ORIG-GUID: yIjUwoTfFDoIJPzrpZYp7cstBzS6DjZq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270050
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-292095-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev,nfc];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: A70025DF6D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nci_core_init_rsp_packet_v1() and nci_core_init_rsp_packet_v2() parse
the CORE_INIT_RSP packet without validating that the skb contains
enough data. A malformed response (e.g. injected via virtual_ncidev)
can declare a large num_supported_rf_interfaces while providing
insufficient data, causing reads of uninitialized slab memory. This
is later used in nci_init_complete_req(), triggering a KMSAN
uninit-value warning.

Add skb length checks before accessing packet fields:
- Validate the skb has at least 1 byte for the status field.
- Validate the skb can hold the fixed-size header before parsing.
- In v2, bounds-check each variable-length rf_interface entry and its
  extension parameters within the parsing loop.
- In v1, verify the skb is large enough for both the variable-length
  rf_interfaces array and the trailing rsp_2 structure.

Reported-by: syzbot+46ca2592193f2fb3debc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=46ca2592193f2fb3debc
Fixes: bcd684aace34 ("net/nfc/nci: Support NCI 2.x initial sequence")
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
v3:
 - Use skb_headlen()/skb_tail_pointer() instead of skb->len to bound
   checks against the linear data region, ensuring correctness even
   with non-linear skbs.
 - Defer all ndev state updates until after validation passes, so that
   early error returns do not leave ndev in a partially updated state.

v2:
 - Validate the skb has at least 1 byte for the status field.
 - Move the fixed-size header check after the status access.
 - Add Closes: link after Reported-by

 net/nfc/nci/rsp.c | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index 9eeb862825c5..85c3ff2b78cd 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -50,11 +50,27 @@ static u8 nci_core_init_rsp_packet_v1(struct nci_dev *ndev,
 	const struct nci_core_init_rsp_1 *rsp_1 = (void *)skb->data;
 	const struct nci_core_init_rsp_2 *rsp_2;
 
+	/* Ensure that the status field can be accessed. */
+	if (skb_headlen(skb) < 1)
+		return NCI_STATUS_SYNTAX_ERROR;
+
 	pr_debug("status 0x%x\n", rsp_1->status);
 
 	if (rsp_1->status != NCI_STATUS_OK)
 		return rsp_1->status;
 
+	/* Success response must contain the full fixed-size header */
+	if (skb_headlen(skb) < sizeof(*rsp_1))
+		return NCI_STATUS_SYNTAX_ERROR;
+
+	/* Ensure the variable-length rf_interfaces array and trailing
+	 * rsp_2 structure are fully contained within the skb.
+	 */
+	if (skb_headlen(skb) < sizeof(*rsp_1) +
+			       rsp_1->num_supported_rf_interfaces +
+			       sizeof(*rsp_2))
+		return NCI_STATUS_SYNTAX_ERROR;
+
 	ndev->nfcc_features = __le32_to_cpu(rsp_1->nfcc_features);
 	ndev->num_supported_rf_interfaces = rsp_1->num_supported_rf_interfaces;
 
@@ -87,15 +103,25 @@ static u8 nci_core_init_rsp_packet_v2(struct nci_dev *ndev,
 				      const struct sk_buff *skb)
 {
 	const struct nci_core_init_rsp_nci_ver2 *rsp = (void *)skb->data;
-	const u8 *supported_rf_interface = rsp->supported_rf_interfaces;
+	const u8 *supported_rf_interface;
 	u8 rf_interface_idx = 0;
 	u8 rf_extension_cnt = 0;
 
+	/* Ensure that the status field can be accessed. */
+	if (skb_headlen(skb) < 1)
+		return NCI_STATUS_SYNTAX_ERROR;
+
 	pr_debug("status %x\n", rsp->status);
 
 	if (rsp->status != NCI_STATUS_OK)
 		return rsp->status;
 
+	/* Success response must contain the full fixed-size header */
+	if (skb_headlen(skb) < sizeof(*rsp))
+		return NCI_STATUS_SYNTAX_ERROR;
+
+	supported_rf_interface = rsp->supported_rf_interfaces;
+
 	ndev->nfcc_features = __le32_to_cpu(rsp->nfcc_features);
 	ndev->num_supported_rf_interfaces = rsp->num_supported_rf_interfaces;
 
@@ -104,13 +130,22 @@ static u8 nci_core_init_rsp_packet_v2(struct nci_dev *ndev,
 		    NCI_MAX_SUPPORTED_RF_INTERFACES);
 
 	while (rf_interface_idx < ndev->num_supported_rf_interfaces) {
-		ndev->supported_rf_interfaces[rf_interface_idx++] = *supported_rf_interface++;
+		/* Each entry: [rf_interface_type (1B)] [ext_count (1B)] [ext...] */
+		if (supported_rf_interface + 2 > skb_tail_pointer(skb))
+			break;
+		ndev->supported_rf_interfaces[rf_interface_idx] = *supported_rf_interface++;
 
-		/* skip rf extension parameters */
 		rf_extension_cnt = *supported_rf_interface++;
+		if (supported_rf_interface + rf_extension_cnt > skb_tail_pointer(skb))
+			break;
+
+		/* Only count the entry after full validation */
+		rf_interface_idx++;
 		supported_rf_interface += rf_extension_cnt;
 	}
 
+	ndev->num_supported_rf_interfaces = rf_interface_idx;
+
 	ndev->max_logical_connections = rsp->max_logical_connections;
 	ndev->max_routing_table_size =
 			__le16_to_cpu(rsp->max_routing_table_size);
-- 
2.43.0


