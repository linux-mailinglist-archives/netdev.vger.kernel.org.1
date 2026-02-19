Return-Path: <netdev+bounces-259432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLhCJ5vqlmkzrAIAu9opvQ
	(envelope-from <netdev+bounces-259432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 11:48:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E80C715DF84
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 11:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDE59301950C
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 10:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673C626D4F9;
	Thu, 19 Feb 2026 10:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="N20y6eB6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC9A63CB;
	Thu, 19 Feb 2026 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771498095; cv=none; b=YTQ8NS/ufNwspLKFl7EAkdo6npsfVIr2L58SbkDVhVF0noq3UdctVfhJ87irbfszhuTkPyjIhHDEP6oUgR9nmGvXGaRPPpHmui3dZZoCp1W4KITNJaDeh4I/91n2B8jmxkm1KscCYi0DoWZG3cCpXI0YoIU3DiPRw//WSWYIfD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771498095; c=relaxed/simple;
	bh=1rQ3iDwODxhhWuq9K7ehWpSZnSznUU/eElSYNXYEJB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DIRTiqvOqQ6YmRwrEYZWPXSQJ4yiAO7NtsfpNIxdeMj4p36Z7l0FUjS+nILrJv6Sfr0t3cftwxVUD//b+RdtRPSlGYrGIAtLvGAfOXhLtV3l//RNwlBkEBcwwvnD3901HiH2PlAGdO0jhQlUKaJMysiW+LonlmMzqFK8fZA4F6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=N20y6eB6; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J3UtC42868091;
	Thu, 19 Feb 2026 10:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=XfKg/nB2u
	uIxTDqUglp98RtSed1x3nFSI8IIkE/DcXc=; b=N20y6eB674AQKU1HehSVSd2f8
	mMiGCDX+Ypb8GrLwhbpN5MA2QkOpvlINEdpCOdbqkNXL8P4XaepydgcpVtarZPZc
	rX3IYjlSXS/kDdqLomqg3D/RdzObz+/6/s6EPyO3fWGTi1DilKyIolNnsRA2y3xR
	2W5mzkoDZkY/QKSBdhjP8Y3w7TtUdMz/5lD+/BxWHjN+kFGJMFX7Lp6DOJ7A3p9I
	oNMZhturWBdoN7QwOl121tl/zD8x3W6jEjHzMNQxQAPWKXtZvYaRt+9aCzEm0rIl
	bVNh9NJdFazSrv4PzOQ50CKEh4vXgYdvebBAXxbEIpf8eNIjHYUSvC4jkOKhg==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4cddy4xkhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 10:47:22 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 61JAYIRb007548;
	Thu, 19 Feb 2026 02:47:21 -0800
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 4cdx0vgq9u-1;
	Thu, 19 Feb 2026 02:47:21 -0800 (PST)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id AFA8E83;
	Thu, 19 Feb 2026 10:47:17 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: 
Cc: Nick Hudson <nhudson@akamai.com>, Anna Glasgall <aglasgal@akamai.com>,
        Max Tottenham <mtottenh@akamai.com>, Josh Hunt <johunt@akamai.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jason Xing <kerneljasonxing@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        Paul Chaignon <paul.chaignon@gmail.com>,
        Mykyta Yatsenko <yatsenko@meta.com>, Tao Chen <chen.dylane@linux.dev>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Anton Protopopov <a.s.protopopov@gmail.com>,
        Tobias Klauser <tklauser@distanz.ch>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC PATCH 1/1] bpf: Add tunnel decapsulation and GSO state updates per new flags
Date: Thu, 19 Feb 2026 10:47:09 +0000
Message-Id: <20260219104710.1490304-2-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219104710.1490304-1-nhudson@akamai.com>
References: <20260219104710.1490304-1-nhudson@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2602130000 definitions=main-2602190097
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA5OSBTYWx0ZWRfX9hSgdNnXi0Qb
 BhSQqc/vUI7PTa1Y1ah5MU3fvCGvvwVvLkGQMbKII35epkqe+y3PBhEUxNIx2QhSZb3Xj2R0dg8
 BWi5j1YTmwNjXAXengQEXxBEVAESX3puo01smzHhv1gK+C3yp6Mxn+hb4xfyJH5VhTus/aPm3qA
 s1AqxSXOSX+Q3SfiNRdXu5KRW9cpc29swzygVBt8O3mlMpu4UWgAUSFPIROR9hzr7actiEP0ijn
 KTKQnvf01IaFgkXKysg6ReqpUAqIzet2n8lBp14TCcYnzI7bOWW4rzz8gRFLtIFP7hYGWo5h+Vx
 cq/2eKfv0qGIIY6jksFGz/i2GryZYgydacNQZUvv1mH0mb4Rob4kVRJ2ri7RuPJiVQ2nUY3mqf3
 ZQ3jZiIV4hTvjwsnfLtXuK4QuewDg83oFINbQjbLaNiGmez2w6NKmj2GuYcTzX6RvEc0Xf0mfps
 bHyQTqfmYHk5kKsCEgg==
X-Proofpoint-GUID: qhUUFbONJo5D2hD2Sg4kiFYlDfrJaWOH
X-Authority-Analysis: v=2.4 cv=Jf+xbEKV c=1 sm=1 tr=0 ts=6996ea3a cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=X7Ea-ya5AAAA:8 a=rooXBoYTHu2ir9VGlUgA:9
X-Proofpoint-ORIG-GUID: qhUUFbONJo5D2hD2Sg4kiFYlDfrJaWOH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190099
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com,meta.com,distanz.ch,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259432-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E80C715DF84
X-Rspamd-Action: no action

Enable BPF programs to properly handle GSO state when decapsulating
tunneled packets by adding selective GSO flag clearing and a trusted
mode for GSO handling.

New decapsulation flags:

- BPF_F_ADJ_ROOM_DECAP_L4_UDP: Clear UDP tunnel GSO flags
  (SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM)
- BPF_F_ADJ_ROOM_DECAP_L4_GRE: Clear GRE tunnel GSO flags
  (SKB_GSO_GRE, SKB_GSO_GRE_CSUM)
- BPF_F_ADJ_ROOM_DECAP_IPXIP4: Clear SKB_GSO_IPXIP4 flag for
  IPv4-in-IPv4 (IPIP) and IPv6-in-IPv4 (SIT) tunnels
- BPF_F_ADJ_ROOM_DECAP_IPXIP6: Clear SKB_GSO_IPXIP6 flag for
  IPv6-in-IPv6 and IPv4-in-IPv6 tunnels
- BPF_F_ADJ_ROOM_NO_DODGY: Preserve gso_segs and don't set
  SKB_GSO_DODGY when the BPF program is trusted and modifications
  are known to be valid

The existing anonymous enum for BPF_FUNC_skb_adjust_room flags is
renamed to enum bpf_adj_room_flags to enable CO-RE (Compile Once -
Run Everywhere) lookups in BPF programs.

By default, bpf_skb_adjust_room sets SKB_GSO_DODGY and resets
gso_segs to 0, forcing revalidation. The NO_DODGY flag bypasses this
for trusted programs that guarantee GSO correctness.

Usage example (decapsulating UDP tunnel with IPv4 inner packet):
  bpf_skb_adjust_room(skb, -hdr_len, BPF_ADJ_ROOM_NET,
                      BPF_F_ADJ_ROOM_DECAP_L3_IPV4 |
                      BPF_F_ADJ_ROOM_DECAP_L4_UDP);

Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
Co-developed-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Josh Hunt <johunt@akamai.com>
Signed-off-by: Nick Hudson <nhudson@akamai.com>
---
 include/uapi/linux/bpf.h       | 45 +++++++++++++++++++--
 net/core/filter.c              | 73 ++++++++++++++++++++++++++++------
 tools/include/uapi/linux/bpf.h | 45 +++++++++++++++++++--
 3 files changed, 145 insertions(+), 18 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c8d400b7680a..0cb24ab70af7 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3010,8 +3010,42 @@ union bpf_attr {
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
+ *
+ *		* **BPF_F_ADJ_ROOM_NO_DODGY**:
+ *		  Do not mark the packet as dodgy (untrusted) and preserve
+ *		  the existing gso_segs count. By default, packet modifications
+ *		  set SKB_GSO_DODGY and reset gso_segs to 0, forcing
+ *		  revalidation. This flag is useful when decapsulating the
+ *		  tunnel, the BPF program is trusted, and the modifications
+ *		  are known to be valid.
  *
  * 		A call to this helper is susceptible to change the underlying
  * 		packet buffer. Therefore, at load time, all checks on pointers
@@ -6209,7 +6243,7 @@ enum {
 };
 
 /* BPF_FUNC_skb_adjust_room flags. */
-enum {
+enum bpf_adj_room_flags {
 	BPF_F_ADJ_ROOM_FIXED_GSO	= (1ULL << 0),
 	BPF_F_ADJ_ROOM_ENCAP_L3_IPV4	= (1ULL << 1),
 	BPF_F_ADJ_ROOM_ENCAP_L3_IPV6	= (1ULL << 2),
@@ -6219,6 +6253,11 @@ enum {
 	BPF_F_ADJ_ROOM_ENCAP_L2_ETH	= (1ULL << 6),
 	BPF_F_ADJ_ROOM_DECAP_L3_IPV4	= (1ULL << 7),
 	BPF_F_ADJ_ROOM_DECAP_L3_IPV6	= (1ULL << 8),
+	BPF_F_ADJ_ROOM_DECAP_L4_GRE	= (1ULL << 9),
+	BPF_F_ADJ_ROOM_DECAP_L4_UDP	= (1ULL << 10),
+	BPF_F_ADJ_ROOM_DECAP_IPXIP4	= (1ULL << 11),
+	BPF_F_ADJ_ROOM_DECAP_IPXIP6	= (1ULL << 12),
+	BPF_F_ADJ_ROOM_NO_DODGY		= (1ULL << 13),
 };
 
 enum {
diff --git a/net/core/filter.c b/net/core/filter.c
index ba019ded773d..681dd53ab841 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3484,14 +3484,28 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
 #define BPF_F_ADJ_ROOM_DECAP_L3_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_IPV4 | \
 					 BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
 
-#define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
-					 BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
+#define BPF_F_ADJ_ROOM_DECAP_L4_MASK	(BPF_F_ADJ_ROOM_DECAP_L4_UDP | \
+					 BPF_F_ADJ_ROOM_DECAP_L4_GRE)
+
+#define BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK	(BPF_F_ADJ_ROOM_DECAP_IPXIP4 | \
+					 BPF_F_ADJ_ROOM_DECAP_IPXIP6)
+
+#define BPF_F_ADJ_ROOM_ENCAP_MASK	(BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
 					 BPF_F_ADJ_ROOM_ENCAP_L4_GRE | \
 					 BPF_F_ADJ_ROOM_ENCAP_L4_UDP | \
 					 BPF_F_ADJ_ROOM_ENCAP_L2_ETH | \
 					 BPF_F_ADJ_ROOM_ENCAP_L2( \
-					  BPF_ADJ_ROOM_ENCAP_L2_MASK) | \
-					 BPF_F_ADJ_ROOM_DECAP_L3_MASK)
+					  BPF_ADJ_ROOM_ENCAP_L2_MASK))
+
+#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK | \
+					 BPF_F_ADJ_ROOM_DECAP_L4_MASK | \
+					 BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
+
+#define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
+					 BPF_F_ADJ_ROOM_ENCAP_MASK | \
+					 BPF_F_ADJ_ROOM_DECAP_MASK | \
+					 BPF_F_ADJ_ROOM_NO_CSUM_RESET | \
+					 BPF_F_ADJ_ROOM_NO_DODGY)
 
 static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 			    u64 flags)
@@ -3503,6 +3517,10 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 	unsigned int gso_type = SKB_GSO_DODGY;
 	int ret;
 
+	if (unlikely(flags & (BPF_F_ADJ_ROOM_DECAP_MASK |
+			      BPF_F_ADJ_ROOM_NO_DODGY)))
+		return -EINVAL;
+
 	if (skb_is_gso(skb) && !skb_is_gso_tcp(skb)) {
 		/* udp gso_size delineates datagrams, only allow if fixed */
 		if (!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) ||
@@ -3588,8 +3606,10 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 
-		/* Header must be checked, and gso_segs recomputed. */
+		/* Add tunnel GSO type flags as appropriate. */
 		shinfo->gso_type |= gso_type;
+
+		/* Header must be checked, and gso_segs recomputed. */
 		shinfo->gso_segs = 0;
 
 		/* Due to header growth, MSS needs to be downgraded.
@@ -3610,11 +3630,14 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 			      u64 flags)
 {
+	bool no_dodgy = flags & BPF_F_ADJ_ROOM_NO_DODGY;
 	int ret;
 
 	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
 			       BPF_F_ADJ_ROOM_DECAP_L3_MASK |
-			       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
+			       BPF_F_ADJ_ROOM_DECAP_MASK |
+			       BPF_F_ADJ_ROOM_NO_CSUM_RESET |
+			       BPF_F_ADJ_ROOM_NO_DODGY)))
 		return -EINVAL;
 
 	if (skb_is_gso(skb) && !skb_is_gso_tcp(skb)) {
@@ -3647,9 +3670,36 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
 			skb_increase_gso_size(shinfo, len_diff);
 
-		/* Header must be checked, and gso_segs recomputed. */
-		shinfo->gso_type |= SKB_GSO_DODGY;
-		shinfo->gso_segs = 0;
+		/* Selective GSO flag clearing based on decap type.
+		 * Only clear the flags for the tunnel layer being removed.
+		 */
+		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP)
+			shinfo->gso_type &= ~(SKB_GSO_UDP_TUNNEL |
+					      SKB_GSO_UDP_TUNNEL_CSUM);
+		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE)
+			shinfo->gso_type &= ~(SKB_GSO_GRE |
+					      SKB_GSO_GRE_CSUM);
+		if (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4)
+			shinfo->gso_type &= ~SKB_GSO_IPXIP4;
+		if (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6)
+			shinfo->gso_type &= ~SKB_GSO_IPXIP6;
+
+		/* Clear encapsulation flag only when no tunnel GSO flags remain */
+		if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
+			if (!(shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
+						  SKB_GSO_UDP_TUNNEL_CSUM |
+						  SKB_GSO_GRE |
+						  SKB_GSO_GRE_CSUM |
+						  SKB_GSO_IPXIP4 |
+						  SKB_GSO_IPXIP6)))
+				skb->encapsulation = 0;
+		}
+
+		/* NO_DODGY: preserve gso_segs, don't mark as dodgy. */
+		if (!no_dodgy) {
+			shinfo->gso_type |= SKB_GSO_DODGY;
+			shinfo->gso_segs = 0;
+		}
 	}
 
 	return 0;
@@ -3709,8 +3759,7 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
 	u32 off;
 	int ret;
 
-	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_MASK |
-			       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
+	if (unlikely(flags & ~BPF_F_ADJ_ROOM_MASK))
 		return -EINVAL;
 	if (unlikely(len_diff_abs > 0xfffU))
 		return -EFAULT;
@@ -3729,7 +3778,7 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
 		return -ENOTSUPP;
 	}
 
-	if (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
+	if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
 		if (!shrink)
 			return -EINVAL;
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 5e38b4887de6..664bc8438186 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3010,8 +3010,42 @@ union bpf_attr {
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
+ *
+ *		* **BPF_F_ADJ_ROOM_NO_DODGY**:
+ *		  Do not mark the packet as dodgy (untrusted) and preserve
+ *		  the existing gso_segs count. By default, packet modifications
+ *		  set SKB_GSO_DODGY and reset gso_segs to 0, forcing
+ *		  revalidation. This flag is useful when decapsulating the
+ *		  tunnel, the BPF program is trusted, and the modifications
+ *		  are known to be valid.
  *
  * 		A call to this helper is susceptible to change the underlying
  * 		packet buffer. Therefore, at load time, all checks on pointers
@@ -6209,7 +6243,7 @@ enum {
 };
 
 /* BPF_FUNC_skb_adjust_room flags. */
-enum {
+enum bpf_adj_room_flags {
 	BPF_F_ADJ_ROOM_FIXED_GSO	= (1ULL << 0),
 	BPF_F_ADJ_ROOM_ENCAP_L3_IPV4	= (1ULL << 1),
 	BPF_F_ADJ_ROOM_ENCAP_L3_IPV6	= (1ULL << 2),
@@ -6219,6 +6253,11 @@ enum {
 	BPF_F_ADJ_ROOM_ENCAP_L2_ETH	= (1ULL << 6),
 	BPF_F_ADJ_ROOM_DECAP_L3_IPV4	= (1ULL << 7),
 	BPF_F_ADJ_ROOM_DECAP_L3_IPV6	= (1ULL << 8),
+	BPF_F_ADJ_ROOM_DECAP_L4_GRE	= (1ULL << 9),
+	BPF_F_ADJ_ROOM_DECAP_L4_UDP	= (1ULL << 10),
+	BPF_F_ADJ_ROOM_DECAP_IPXIP4	= (1ULL << 11),
+	BPF_F_ADJ_ROOM_DECAP_IPXIP6	= (1ULL << 12),
+	BPF_F_ADJ_ROOM_NO_DODGY		= (1ULL << 13),
 };
 
 enum {
-- 
2.34.1


