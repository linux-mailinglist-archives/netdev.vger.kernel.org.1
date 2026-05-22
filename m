Return-Path: <netdev+bounces-290639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id b30XFA68D2oyPQYAu9opvQ
	(envelope-from <netdev+bounces-290639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 04:14:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 555425ADE7B
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 04:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61E1C3009CE0
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 02:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918642DEA61;
	Fri, 22 May 2026 02:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="ru/mf5y0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E370195811;
	Fri, 22 May 2026 02:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779416074; cv=none; b=d5CQgOYdWnaXowetULuhLISnDa82+PUlDf6JTnQXGWAiHeFh1Liv1m3a1btf1qJS3LyJp+dG4b4RA8ZAxA4FY/uoCahKrhaFxhOhnG2VCdjGN/L1Am3hv+Pn7TFNf8rx1UhnP0rUyUqMJxCG06iWL8LzTTxxbS8zInUO12HvPgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779416074; c=relaxed/simple;
	bh=uVT0UYfjmARRspVlfhCK2KjIXfXcpqoS85lYRZ4A1lw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PIohEALus/n4A1yJrdtgWf6QQh1njnDBB0N4omPA7z1uSIEQYc3wbC5JcbWs0nQNVVIV9QoiqIwczc6IMLvCMNqofOLmYo6PBQ4iKX7VvVcUTKygE4M+Q6jzaJ0GCIkGZedynb5Q/M+qpl0Y9OEVlA4ld7bdXS/oVNO2UegcIWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=ru/mf5y0; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M1ktvY2227173;
	Thu, 21 May 2026 19:13:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=QWjgR4nHf
	yMzPDpZe/LEvyeetyk93z6y2gam877WXco=; b=ru/mf5y09+YJZEYSBsBCta21h
	0PdhxN3ty4T8z1W0Kiu+UX+WpRaZrltn4ZiafPo1+itjHE5Z5d7brgY4W9dlG/sC
	L/PJ0D8zhXJSQcTsCrNcKUIQHP0AzYpVZ0155cYxm5nFwmdMCINvYnNyjvG54ATN
	WZsEOd7st2TText7OofK8ijoM8iIt2w3FLfQuW5HkRJCccyfD8bGvTVpEYdiGUlq
	C2UEyjLvbbwAABXp+w3mxsMmQB5/VURoX8Aiwp2HHe0VrWrvvPazO6xDs5VpHFhr
	3s3wZZjxqxSqDBNeKJEV3pi5UcRbg9uyriBktz/Fel8xzXbgTFjOAqDO3m5dw==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e9rdtt12p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 21 May 2026 19:13:30 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 21 May 2026 19:13:29 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 21 May 2026 19:13:27 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <david+nfc@ixit.cz>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <bongsu.jeon@samsung.com>
CC: <oe-linux-nfc@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] nfc: nci: fix use of uninitialized memory in CORE_INIT_RSP parsing
Date: Fri, 22 May 2026 10:13:26 +0800
Message-ID: <20260522021326.1164807-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Kq59H2WN c=1 sm=1 tr=0 ts=6a0fbbca cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=iKiJcTA2PjBS6x5JeXcw:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=IDFcQ0WGl1NcD2azA7sA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: gMtoshG9AkdvHPvg-GOD0ejgUWKL5ggt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDAxOSBTYWx0ZWRfX1BJ7ApCYmxDg
 bnX98p51mi4Gl2RI2DHGzzpKjjxAbermkrZF3gOmw2a/Hb6YTiGxmpF1htBwwwCnttOTk6LodLC
 vV15AUx3F7JV+hV9PnnWTt26+1tUNHyxK2teK0MJFYyx1CPsyPmmWDoO0tffB+Y6Top3ftqfC15
 N3qIevnaBjV6awOr17SBwHLOoGTaGGkkMlaUfgV2n0GSURCOt69MvZLQ65bWcddomtcJMqaQd5M
 g+xWaLEPQ2EejnwBXBiGqMMNJUl7g5iXSSUVOvx9QuHYB1Xhii3N0lUPrI23NHZbQMO38iLSQ5g
 ld6QPX+Cy+sor5CF32WOCls+eHovR9mQQBqfklx8+Puv28/6Ndgt617Ben0xEZ3jco00SuaGM2x
 VSATyLf65RGFcEN+adi6mWuPL9Djexhz2VY6Mbm+KGS2Wn3UIsnqSghnUYg+e7UpK0CU/Uef5TE
 gBE6JJuzm1hdxPeRgMg==
X-Proofpoint-ORIG-GUID: gMtoshG9AkdvHPvg-GOD0ejgUWKL5ggt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220019
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-290639-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev,nfc];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email,windriver.com:email,windriver.com:mid,windriver.com:dkim,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 555425ADE7B
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
v2:
 - Validate the skb has at least 1 byte for the status field.
 - Move the fixed-size header check after the status access.
 - Add Closes: link after Reported-by

 net/nfc/nci/rsp.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index 9eeb862825c5..61fbe31b427e 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -50,11 +50,19 @@ static u8 nci_core_init_rsp_packet_v1(struct nci_dev *ndev,
 	const struct nci_core_init_rsp_1 *rsp_1 = (void *)skb->data;
 	const struct nci_core_init_rsp_2 *rsp_2;
 
+	/* Ensure that the status field can be accessed. */
+	if (skb->len < 1)
+		return NCI_STATUS_SYNTAX_ERROR;
+
 	pr_debug("status 0x%x\n", rsp_1->status);
 
 	if (rsp_1->status != NCI_STATUS_OK)
 		return rsp_1->status;
 
+	/* Success response must contain the full fixed-size header */
+	if (skb->len < sizeof(*rsp_1))
+		return NCI_STATUS_SYNTAX_ERROR;
+
 	ndev->nfcc_features = __le32_to_cpu(rsp_1->nfcc_features);
 	ndev->num_supported_rf_interfaces = rsp_1->num_supported_rf_interfaces;
 
@@ -62,6 +70,10 @@ static u8 nci_core_init_rsp_packet_v1(struct nci_dev *ndev,
 		min((int)ndev->num_supported_rf_interfaces,
 		    NCI_MAX_SUPPORTED_RF_INTERFACES);
 
+	if (skb->len < sizeof(*rsp_1) + rsp_1->num_supported_rf_interfaces +
+		       sizeof(*rsp_2))
+		return NCI_STATUS_SYNTAX_ERROR;
+
 	memcpy(ndev->supported_rf_interfaces,
 	       rsp_1->supported_rf_interfaces,
 	       ndev->num_supported_rf_interfaces);
@@ -87,15 +99,26 @@ static u8 nci_core_init_rsp_packet_v2(struct nci_dev *ndev,
 				      const struct sk_buff *skb)
 {
 	const struct nci_core_init_rsp_nci_ver2 *rsp = (void *)skb->data;
-	const u8 *supported_rf_interface = rsp->supported_rf_interfaces;
+	const u8 *supported_rf_interface;
+	const u8 *skb_end = skb->data + skb->len;
 	u8 rf_interface_idx = 0;
 	u8 rf_extension_cnt = 0;
 
+	/* Ensure that the status field can be accessed. */
+	if (skb->len < 1)
+		return NCI_STATUS_SYNTAX_ERROR;
+
 	pr_debug("status %x\n", rsp->status);
 
 	if (rsp->status != NCI_STATUS_OK)
 		return rsp->status;
 
+	/* Success response must contain the full fixed-size header */
+	if (skb->len < sizeof(*rsp))
+		return NCI_STATUS_SYNTAX_ERROR;
+
+	supported_rf_interface = rsp->supported_rf_interfaces;
+
 	ndev->nfcc_features = __le32_to_cpu(rsp->nfcc_features);
 	ndev->num_supported_rf_interfaces = rsp->num_supported_rf_interfaces;
 
@@ -104,13 +127,23 @@ static u8 nci_core_init_rsp_packet_v2(struct nci_dev *ndev,
 		    NCI_MAX_SUPPORTED_RF_INTERFACES);
 
 	while (rf_interface_idx < ndev->num_supported_rf_interfaces) {
-		ndev->supported_rf_interfaces[rf_interface_idx++] = *supported_rf_interface++;
+		/* Each entry: [rf_interface_type (1B)] [ext_count (1B)] [ext...] */
+		if (supported_rf_interface + 2 > skb_end)
+			break;
+		ndev->supported_rf_interfaces[rf_interface_idx] = *supported_rf_interface++;
 
 		/* skip rf extension parameters */
 		rf_extension_cnt = *supported_rf_interface++;
+		if (supported_rf_interface + rf_extension_cnt > skb_end)
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


