Return-Path: <netdev+bounces-279700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGJ6GWAD5mmBqQEAu9opvQ
	(envelope-from <netdev+bounces-279700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 12:43:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9A3429702
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 12:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE240309298A
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118F739B966;
	Mon, 20 Apr 2026 10:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="SR+yiB+R"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5688F39BFE6;
	Mon, 20 Apr 2026 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681688; cv=none; b=jHtaKqb99r6vnkXesmDzyy+q6k9VksB+RGaPl4ZVQg9cV3AtYAFxwq0hYtx7ATF2FbrdoVqrab7+iyeVO0OuhPTgv0ZJPn+ISED5zgdjeOQG0JHS2OmYmuQ4Cf9m7nKoVLYAxvTG8htKK5GMDGk8qeWXFW1dBaWjy+wBpzhA4VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681688; c=relaxed/simple;
	bh=iw3pkpi0rpWv34W0Zy1IDNbxE46IPAKhAcqKQwIkudY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S2poJKU7ZQdOAbEQXulBXi530NSCy6jLvhCg2AExzPcwlowl4TX36/3NKRETVYtAytbWz3vueMN4SROY+DloKF5f2uBUiHff7wMn4k6AZY+6/hLwOFd1PAC31dxPaL62v+jtrq4CG8qKqy1T2EVODGLWB/wWKvc+2/AA0Ij11y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=SR+yiB+R; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K5qlub4070610;
	Mon, 20 Apr 2026 11:41:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=tvzeqXY17
	UbphjoJsIOIquKsB7eKxzv9kuXvY8AZYjc=; b=SR+yiB+Rs/77x+c64J++6YZXf
	Y9qKQR82eGoQ5xpfBn31VP9ufjQyeHZT7b5j88isG5WH/PaaO+IUkA3ymQDQ4Xka
	c89US3zIjvZh5Z/ZIAL8qVibpJqVk9p5ocAv7o2X55fxVSKWzLjg6se6U0IVAaS0
	Ubogmi5QHkXUpNizcec1qt8pQvLO08/fib7+AyqhL3VOXPK28seErSyJ3oPflg0N
	hbTTGOUP/0F44bBbQM4OyPwrjdcyP+v0IpXe5ZGnzYLwFRiXbpRSIubUwWZC7WZN
	JzrFP8iEzI6wluZ+rYeuZLUVXHGWJsM5mn6Ne8msV4sVEd6rGvpi2VQZl44NQ==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4dkxtrdqxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 11:41:02 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 63KABenD011853;
	Mon, 20 Apr 2026 06:41:02 -0400
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 4dm59tfe72-1;
	Mon, 20 Apr 2026 06:41:01 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 36B938D;
	Mon, 20 Apr 2026 10:40:58 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, Max Tottenham <mtottenh@akamai.com>,
        Anna Glasgall <aglasgal@akamai.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/6] bpf: add BPF_F_ADJ_ROOM_DECAP_* flags for tunnel decapsulation
Date: Mon, 20 Apr 2026 11:40:48 +0100
Message-Id: <20260420104051.1528843-4-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420104051.1528843-1-nhudson@akamai.com>
References: <20260420104051.1528843-1-nhudson@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=596 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604070000 definitions=main-2604200099
X-Proofpoint-GUID: XBGK0q8qpQYiNYtDHlNLXol5-jGHssVx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwMyBTYWx0ZWRfX3ACW7QQg01H6
 6G0hG36Rmwii2LjmvSi8xcvCtUfWOGj+3tdLxLLT9noq4WvLo7o2SaYxHV5oNR8u38cuKPD5r8o
 zEXQnM2uLu9zDP77QJ359VyAULITRXZ5znBW5Lm3fyf/abPAT3oW75Awc3goeKDt2SaZoLM+2qR
 vqpzLA2iLinQgZ3WF4EzE0fqIqziLTCOp9McLH9pZzIlV21Hx/W0r+QXH6zulDDmWSOM5kmRBJ7
 b1YCGjlV5XbgnTCTAlHHMzFPpk1kYnYF6xuwLnyzm1L/+sotk/aFort6Nh+jOMR1ut5wcfgVYC0
 NwzLvI6MIX2nH4P98G1ttnPioqH7GsuKchk8bNH/5kYI8qbGsZiJd+PLPHYoX9Td++y7aq/boWV
 CnIsBIdE79+bXxexUt5ephIUr2Bc+0n4yAI8Ql/wG5AySfUd0YMlXykp+TyYNykk0YeJr48qpLd
 R1+AvSQiUaOgQ69iyrw==
X-Authority-Analysis: v=2.4 cv=G70s1dk5 c=1 sm=1 tr=0 ts=69e602be cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=VcQvXEo1OZcA_IiPcy3B:22 a=X7Ea-ya5AAAA:8 a=KfGVUnEDJfcTcdlxACkA:9
X-Proofpoint-ORIG-GUID: XBGK0q8qpQYiNYtDHlNLXol5-jGHssVx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604170000 definitions=main-2604200103
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279700-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: BB9A3429702
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
index c021ed8d7b44..4a53e731c554 100644
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
@@ -6221,6 +6247,10 @@ enum bpf_adj_room_flags {
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
index ca35ed622ed5..f4c2fbd8fe68 100644
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
@@ -6221,6 +6247,10 @@ enum bpf_adj_room_flags {
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


