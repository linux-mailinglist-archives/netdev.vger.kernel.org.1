Return-Path: <netdev+bounces-269017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGiTB5Gsumn9aQIAu9opvQ
	(envelope-from <netdev+bounces-269017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:45:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8307B2BC47F
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E56D830EF0AD
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411EE3D9045;
	Wed, 18 Mar 2026 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="NvQA32E+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818B43D75D5;
	Wed, 18 Mar 2026 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841396; cv=none; b=ZbFyrx8GytbkAdTNNbTMIVwGi2ZVMXRk7D0UYyYtcBW+DuWuenjFZXZ1G4R2pPkfhEdGpWuSwkxbK9fY71/h9py0dBzGvLCd7R2IBjTeGr4tR7cDVFddIYtDg3zQRc3KmrQ46wMSYKG4St9qvK3Ea8iKPhaGAm/KyGwmHmwdRUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841396; c=relaxed/simple;
	bh=ZKEJ1Q3SIhqnzcSqEUIEYOpQdr07qmFYHHPdzfvlWjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S8xJxAdvzgJtOA4qEYKO4kOfjq7yg7LiWDLsnRTmw8DlSP5C/P5usrTVtKDmz8To31zw7YlsMgFmJuu1TszKxTChNINegG6ewEjknTB0ZI+ChiMOw6yZGV+JXyhIbAO46tUYD+RnthvxxSvJVUshFud9a/4CZV4IHdqLNVt+Q+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=NvQA32E+; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IDM1P22800004;
	Wed, 18 Mar 2026 13:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=BbH2Q59mx
	h6L/+EB3khl9ClAp03IRqXyf3B9Zu7SneA=; b=NvQA32E+RvbgJfIlMB2KHGvyi
	wvTpYJdXkYDTzYhAUKF6ZRHOBGSHV5NQxSK/zLDHsW725ZJ5C2wa4mWg1+by8L3N
	XoMqJ7Axy3FE1FQAMdXtk7nXjfOLB3PGCB0LdoSpGfAQ2IYAaBwrlkpJv6YCW3oK
	ouj4aAqXNP6G3Ln7x46bjUxD/+OJa3uMMLQtwjbyUTccJAMy0PnEDaxRhniGk6Rg
	WufkgGbUjfRScmEVeQbBEMb0uS9/fMGPQPqmIe1TH/0Ubmz2ZX0QciOB71koj3L3
	mPxxaRnsoiru4ch0k/uLnR7MK/+B0gXP6z1s9xvNJqopt1pZ5T6Tu3lVgq4Gg==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4cw06x4a81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 13:42:48 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 62IDYabu007789;
	Wed, 18 Mar 2026 09:42:47 -0400
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 4cw30x86g7-1;
	Wed, 18 Mar 2026 09:42:47 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 7D2E595;
	Wed, 18 Mar 2026 13:42:46 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Nick Hudson <nhudson@akamai.com>, Max Tottenham <mtottenh@akamai.com>,
        Anna Glasgall <aglasgal@akamai.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] bpf: add BPF_F_ADJ_ROOM_DECAP_* flags for tunnel decapsulation
Date: Wed, 18 Mar 2026 13:42:39 +0000
Message-Id: <20260318134242.2725749-3-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318134242.2725749-1-nhudson@akamai.com>
References: <20260318134242.2725749-1-nhudson@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=552
 suspectscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2603050001 definitions=main-2603180115
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDExNiBTYWx0ZWRfX7Zb8usBCW+PM
 qotQ3EXAELBFJ6q6Ev5Z2vkMPePDCGWykR4DdjGKBqHzXqjR15Gz8DtufrRN9EuXuqT7Si0v7q+
 V3kJv986pv204tEizvh3JaK6yT7uJY1FDpe52lR6+gRZzRFqTsbv0sKXSUlwC3lIxkrF9OGHSNM
 c0nJOgpxcQTicI3pkUNoD0DpOTY04un6bMZ+5jSPlqsb/oJHgAZhQWojMbJmLzHaHlGFAU2j6+1
 ESfsniPBK6zcOge8GcMmTXrrI8o3YPVr/m9SodiwxdMcbK8rg9sAajmuKpvUoJA+nEzohKbvINJ
 fEuzJoZGwvTxXtigH/gZpHF/N+eNzSbaR5N/SpyoH7frptKjZHXfChKJvOv2AB0fWy7Yr7WYtJN
 rSpYHC9xdlrNAjTMUjhIxVpM9djDIdNN7L9af2teltHSuibmYz5zKc7kUGVdG9zLrwT44pH21dA
 LZMyA+hY9MuKfyqf3Ow==
X-Proofpoint-GUID: yAq0fjVtqRJT8r4Wmpq7faEIU4tU0Znk
X-Proofpoint-ORIG-GUID: yAq0fjVtqRJT8r4Wmpq7faEIU4tU0Znk
X-Authority-Analysis: v=2.4 cv=c4Gbhx9l c=1 sm=1 tr=0 ts=69baabd8 cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=4xFXqd-_BHBjZVyr95gr:22 a=X7Ea-ya5AAAA:8 a=KfGVUnEDJfcTcdlxACkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603130000 definitions=main-2603180116
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269017-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,akamai.com,kernel.org,iogearbox.net,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:dkim,akamai.com:email,akamai.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[akamai.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 8307B2BC47F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add new bpf_skb_adjust_room() decapsulation flags:

- BPF_F_ADJ_ROOM_DECAP_L4_GRE
- BPF_F_ADJ_ROOM_DECAP_L4_UDP
- BPF_F_ADJ_ROOM_DECAP_IPXIP4
- BPF_F_ADJ_ROOM_DECAP_IPXIP6

These flags let BPF programs describe which tunnel layer is being
removed, so later changes can update tunnel-related GSO state
accordingly during decapsulation.

This patch only introduces the UAPI flag definitions and helper
documentation.

Co-developed-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Nick Hudson <nhudson@akamai.com>
---
 include/uapi/linux/bpf.h       | 34 ++++++++++++++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index bc4b25eb72ce..2ef886dc9685 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3010,8 +3010,34 @@ union bpf_attr {
  *
  *		* **BPF_F_ADJ_ROOM_DECAP_L3_IPV4**,
  *		  **BPF_F_ADJ_ROOM_DECAP_L3_IPV6**:
- *		  Indicate the new IP header version after decapsulating the outer
- *		  IP header. Used when the inner and outer IP versions are different.
+ *		  Indicate the new IP header version after decapsulating the
+ *		  outer IP header. Used when the inner and outer IP versions
+ *		  are different. These flags only trigger a protocol change
+ *		  without clearing any tunnel-specific GSO flags.
+ *
+ *		* **BPF_F_ADJ_ROOM_DECAP_L4_GRE**:
+ *		  Clear GRE tunnel GSO flags (SKB_GSO_GRE and SKB_GSO_GRE_CSUM)
+ *		  when decapsulating a GRE tunnel.
+ *
+ *		* **BPF_F_ADJ_ROOM_DECAP_L4_UDP**:
+ *		  Clear UDP tunnel GSO flags (SKB_GSO_UDP_TUNNEL and
+ *		  SKB_GSO_UDP_TUNNEL_CSUM) when decapsulating a UDP tunnel.
+ *
+ *		* **BPF_F_ADJ_ROOM_DECAP_IPXIP4**:
+ *		  Clear IPIP/SIT tunnel GSO flag (SKB_GSO_IPXIP4) when decapsulating
+ *		  a tunnel with an outer IPv4 header (IPv4-in-IPv4 or IPv6-in-IPv4).
+ *
+ *		* **BPF_F_ADJ_ROOM_DECAP_IPXIP6**:
+ *		  Clear IPv6 encapsulation tunnel GSO flag (SKB_GSO_IPXIP6) when
+ *		  decapsulating a tunnel with an outer IPv6 header (IPv6-in-IPv6
+ *		  or IPv4-in-IPv6).
+ *
+ *		When using the decapsulation flags above, the skb->encapsulation
+ *		flag is automatically cleared if all tunnel-specific GSO flags
+ *		(SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM, SKB_GSO_GRE,
+ *		SKB_GSO_GRE_CSUM, SKB_GSO_IPXIP4, SKB_GSO_IPXIP6) have been
+ *		removed from the packet. This handles cases where all tunnel
+ *		layers have been decapsulated.
  *
  * 		A call to this helper is susceptible to change the underlying
  * 		packet buffer. Therefore, at load time, all checks on pointers
@@ -6219,6 +6245,10 @@ enum bpf_adj_room_flags {
 	BPF_F_ADJ_ROOM_ENCAP_L2_ETH	= (1ULL << 6),
 	BPF_F_ADJ_ROOM_DECAP_L3_IPV4	= (1ULL << 7),
 	BPF_F_ADJ_ROOM_DECAP_L3_IPV6	= (1ULL << 8),
+	BPF_F_ADJ_ROOM_DECAP_L4_GRE	= (1ULL << 9),
+	BPF_F_ADJ_ROOM_DECAP_L4_UDP	= (1ULL << 10),
+	BPF_F_ADJ_ROOM_DECAP_IPXIP4	= (1ULL << 11),
+	BPF_F_ADJ_ROOM_DECAP_IPXIP6	= (1ULL << 12),
 };
 
 enum {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index db2c520d0e92..e9a5c67ff5e2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3010,8 +3010,34 @@ union bpf_attr {
  *
  *		* **BPF_F_ADJ_ROOM_DECAP_L3_IPV4**,
  *		  **BPF_F_ADJ_ROOM_DECAP_L3_IPV6**:
- *		  Indicate the new IP header version after decapsulating the outer
- *		  IP header. Used when the inner and outer IP versions are different.
+ *		  Indicate the new IP header version after decapsulating the
+ *		  outer IP header. Used when the inner and outer IP versions
+ *		  are different. These flags only trigger a protocol change
+ *		  without clearing any tunnel-specific GSO flags.
+ *
+ *		* **BPF_F_ADJ_ROOM_DECAP_L4_GRE**:
+ *		  Clear GRE tunnel GSO flags (SKB_GSO_GRE and SKB_GSO_GRE_CSUM)
+ *		  when decapsulating a GRE tunnel.
+ *
+ *		* **BPF_F_ADJ_ROOM_DECAP_L4_UDP**:
+ *		  Clear UDP tunnel GSO flags (SKB_GSO_UDP_TUNNEL and
+ *		  SKB_GSO_UDP_TUNNEL_CSUM) when decapsulating a UDP tunnel.
+ *
+ *		* **BPF_F_ADJ_ROOM_DECAP_IPXIP4**:
+ *		  Clear IPIP/SIT tunnel GSO flag (SKB_GSO_IPXIP4) when decapsulating
+ *		  a tunnel with an outer IPv4 header (IPv4-in-IPv4 or IPv6-in-IPv4).
+ *
+ *		* **BPF_F_ADJ_ROOM_DECAP_IPXIP6**:
+ *		  Clear IPv6 encapsulation tunnel GSO flag (SKB_GSO_IPXIP6) when
+ *		  decapsulating a tunnel with an outer IPv6 header (IPv6-in-IPv6
+ *		  or IPv4-in-IPv6).
+ *
+ *		When using the decapsulation flags above, the skb->encapsulation
+ *		flag is automatically cleared if all tunnel-specific GSO flags
+ *		(SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM, SKB_GSO_GRE,
+ *		SKB_GSO_GRE_CSUM, SKB_GSO_IPXIP4, SKB_GSO_IPXIP6) have been
+ *		removed from the packet. This handles cases where all tunnel
+ *		layers have been decapsulated.
  *
  * 		A call to this helper is susceptible to change the underlying
  * 		packet buffer. Therefore, at load time, all checks on pointers
@@ -6219,6 +6245,10 @@ enum bpf_adj_room_flags {
 	BPF_F_ADJ_ROOM_ENCAP_L2_ETH	= (1ULL << 6),
 	BPF_F_ADJ_ROOM_DECAP_L3_IPV4	= (1ULL << 7),
 	BPF_F_ADJ_ROOM_DECAP_L3_IPV6	= (1ULL << 8),
+	BPF_F_ADJ_ROOM_DECAP_L4_GRE	= (1ULL << 9),
+	BPF_F_ADJ_ROOM_DECAP_L4_UDP	= (1ULL << 10),
+	BPF_F_ADJ_ROOM_DECAP_IPXIP4	= (1ULL << 11),
+	BPF_F_ADJ_ROOM_DECAP_IPXIP6	= (1ULL << 12),
 };
 
 enum {
-- 
2.34.1


