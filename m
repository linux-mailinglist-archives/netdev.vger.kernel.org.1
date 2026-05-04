Return-Path: <netdev+bounces-283779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FiDDqRz+GlCvAIAu9opvQ
	(envelope-from <netdev+bounces-283779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:23:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F574BBA7D
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFAA83058E11
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 10:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3795D399358;
	Mon,  4 May 2026 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="mvmNFzx3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B771239B4AE;
	Mon,  4 May 2026 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889925; cv=none; b=Ax217CMSjTvnVAFNdAHQKD0gsDoumfb4iTpRgoNqjzEOhw9yeSWxpMAXf2xPz0hsDnJj8vY9cmgFq3ud5Cc7WR0x4vl+vIccsC3GUnapkl1/A7Kt9D7fx0+VjQLjOiLNjVT7q39MPJTBKKSIsps9KDI8m8/uk6YvTZBkFERONSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889925; c=relaxed/simple;
	bh=g/kHGK6gNkmvMbW+pgFF5YPLMuDW93pf3DI9OeSYaV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EeZ8VQoNFmqORSej0xLb160sWS1jX5HATuTDvmivyhnWNBagFMfOhSUVSPfhgMRl2a/8U+qvtM+prPv9yB9AcDa6gIGDn1j5Mm6Oeh90KSR1FNuCKrsUUtNusDn0LOUp2ESp2z7czSJsS2zeGTgoI3mPkkJAsCutKxar0s1lM2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=mvmNFzx3; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6441K7Nb2086247;
	Mon, 4 May 2026 11:18:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=7v1hZfrJd
	ZqHLDyRyZvoUqYTyz1P37PEbE1tEyF6GX8=; b=mvmNFzx3a3bRzO6jST13sHxhi
	Gf0ulM9BL7fpznQ5EjMk3p7mkjnbF3i25XiK8UDohheK+Wt5ls+bqXrmpF9TdiBE
	Xwimr5lvKg+J06lpOb/Wu8+BFnYDpHLwiLBUSYWhbt9/epjt6YyAYDveIIEUc6Jz
	hbPhgMerWiupFiHLj5KJjoXwFg+MxvTNJhkqI8/GkhPTRk+rQxhg4luF4R5ZKhu5
	rAw3rdsAr/l/JP/ZZsPVloCTZl5ki7nEUFVgMh1NM3Po8uQivfrZpvOyhUnzZUOu
	jtGu+LjCR4N6swJ15fy9giL0JbsUL3AA91pHtgJEsb2dYubdEOBY3cFJC/zJA==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4dw9affjsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 11:18:15 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 644ACGaJ005922;
	Mon, 4 May 2026 06:18:14 -0400
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 4dwckwq08v-1;
	Mon, 04 May 2026 06:18:14 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay01.akamai.com (Postfix) with ESMTP id 1405484;
	Mon,  4 May 2026 10:18:12 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/6] selftests/bpf: tc_tunnel - validate decap GSO and encapsulation state
Date: Mon,  4 May 2026 11:17:59 +0100
Message-Id: <20260504101759.3319427-7-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260504101759.3319427-1-nhudson@akamai.com>
References: <20260504101759.3319427-1-nhudson@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605040108
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEwOSBTYWx0ZWRfX1dxjUmeM1R9A
 /O1/686YIwiV6uoBwOt7LNPLqnJrLg0SOcW8Qx99iX7Gb9Gxv09xWfNPLdvI+wsq5T72/VvNaLB
 878onvt0A2fWYK0WBVEL1hLdwUTvGE+onVia/He78WGUFM7DOXt1+Xy9uATF9EsAxvtTS+d89sN
 65fdxg+7Nhb2OVA3WcPRlAENGIWj+PpMR/7ds5IBcC3sYoZJ6PU8cXujLVD2VgX7VRnP9VAdLDM
 5vp7Kmzmcvjk8Gz9B3sXn1+q7rSTzqHP/ByEHrRnu05TnLYlAWKsjdDmcfxgWLp7di0N0QJ3AT6
 wHDuEhzYIc1TYK5kdkuTcoA5Smzt1nV101VmYfIiCWx4irkLHO+Bo/NIMOM9zkL9qp2sgfV87A4
 qSqVwAyVX5E4Wva/Uy/IfIeVR5abE5J33UOc+TAUf0qX5B3Q3p0/N9zoKLYj7qpIE7/NLPZJTSo
 HnjE5fL4KPRkPVFapKg==
X-Proofpoint-GUID: 5hbf47s9HXzXTwJ18NrRKGh0PTIgm2tk
X-Authority-Analysis: v=2.4 cv=Pf7PQChd c=1 sm=1 tr=0 ts=69f87267 cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=4OENtXgxWbduB0e82o7S:22 a=X7Ea-ya5AAAA:8 a=2QDB-QWHral9ImwuqTYA:9
X-Proofpoint-ORIG-GUID: 5hbf47s9HXzXTwJ18NrRKGh0PTIgm2tk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040109
X-Rspamd-Queue-Id: A8F574BBA7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,gmail.com,iogearbox.net,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283779-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:email,akamai.com:dkim,akamai.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]

tc_tunnel only partially validated decap state and missed some tunnel
cases. In particular, IPXIP decap checks were not exercised for
IPIP/SIT paths, and non-GSO decap encapsulation state was not
verified.

Tighten the test by:

- setting DECAP_IPXIP4/6 flags for IPIP/SIT/IP6 decap paths based on
  the outer tunnel header family;
- requiring needed DECAP enum values via CO-RE enum existence checks
  so missing kernel support fails fast;
- validating post-decap tunnel state for both GSO and non-GSO packets:
  expected gso_type bits must be cleared and skb->encapsulation must
  match remaining tunnel flags;
- removing forced TSO disable in the test harness so GSO validation is
  exercised.

This improves coverage for decap tunnel-state regressions and ensures
sit_none/ipip-style paths are checked correctly.

Signed-off-by: Nick Hudson <nhudson@akamai.com>
---
 .../selftests/bpf/prog_tests/test_tc_tunnel.c |  1 -
 .../selftests/bpf/progs/test_tc_tunnel.c      | 91 +++++++++++++++++--
 2 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
index 1aa7c9463980..67ba27d69347 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
@@ -438,7 +438,6 @@ static int setup(void)
 	SYS(fail_close_ns_client, "ip link add %s type veth peer name %s",
 	    "veth1 mtu 1500 netns " CLIENT_NS " address " MAC_ADDR_VETH1,
 	    "veth2 mtu 1500 netns " SERVER_NS " address " MAC_ADDR_VETH2);
-	SYS(fail_close_ns_client, "ethtool -K veth1 tso off");
 	SYS(fail_close_ns_client, "ip link set veth1 up");
 	nstoken_server = open_netns(SERVER_NS);
 	if (!ASSERT_OK_PTR(nstoken_server, "open server ns"))
diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
index 7376df405a6b..853bca962910 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
@@ -6,6 +6,7 @@
 
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
+#include <bpf/bpf_core_read.h>
 #include "bpf_tracing_net.h"
 #include "bpf_compiler.h"
 
@@ -37,6 +38,22 @@ struct vxlanhdr___local {
 
 #define	EXTPROTO_VXLAN	0x1
 
+#define SKB_GSO_UDP_TUNNEL_MASK	(SKB_GSO_UDP_TUNNEL |			\
+				 SKB_GSO_UDP_TUNNEL_CSUM)
+
+#define SKB_GSO_TUNNEL_MASK	(SKB_GSO_UDP_TUNNEL_MASK |		\
+				 SKB_GSO_GRE |				\
+				 SKB_GSO_GRE_CSUM |			\
+				 SKB_GSO_IPXIP4 |			\
+				 SKB_GSO_IPXIP6 |			\
+				 SKB_GSO_ESP)
+
+#define BPF_F_ADJ_ROOM_DECAP_L4_MASK	(BPF_F_ADJ_ROOM_DECAP_L4_UDP |	\
+					 BPF_F_ADJ_ROOM_DECAP_L4_GRE)
+
+#define BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK	(BPF_F_ADJ_ROOM_DECAP_IPXIP4 |	\
+					 BPF_F_ADJ_ROOM_DECAP_IPXIP6)
+
 #define	VXLAN_FLAGS     bpf_htonl(1<<27)
 #define	VNI_ID		1
 #define	VXLAN_VNI	bpf_htonl(VNI_ID << 8)
@@ -589,9 +606,12 @@ int __encap_ip6vxlan_eth(struct __sk_buff *skb)
 		return TC_ACT_OK;
 }
 
-static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
+static int decap_internal(struct __sk_buff *skb, int off, int len, char proto,
+			  __u64 ipxip_flag)
 {
 	__u64 flags = BPF_F_ADJ_ROOM_FIXED_GSO;
+	struct sk_buff *kskb;
+	struct skb_shared_info *shinfo;
 	struct ipv6_opt_hdr ip6_opt_hdr;
 	struct gre_hdr greh;
 	struct udphdr udph;
@@ -599,10 +619,12 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
 
 	switch (proto) {
 	case IPPROTO_IPIP:
-		flags |= BPF_F_ADJ_ROOM_DECAP_L3_IPV4;
+		flags |= BPF_F_ADJ_ROOM_DECAP_L3_IPV4 |
+			 ipxip_flag;
 		break;
 	case IPPROTO_IPV6:
-		flags |= BPF_F_ADJ_ROOM_DECAP_L3_IPV6;
+		flags |= BPF_F_ADJ_ROOM_DECAP_L3_IPV6 |
+			 ipxip_flag;
 		break;
 	case NEXTHDR_DEST:
 		if (bpf_skb_load_bytes(skb, off + len, &ip6_opt_hdr,
@@ -610,10 +632,12 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
 			return TC_ACT_OK;
 		switch (ip6_opt_hdr.nexthdr) {
 		case IPPROTO_IPIP:
-			flags |= BPF_F_ADJ_ROOM_DECAP_L3_IPV4;
+			flags |= BPF_F_ADJ_ROOM_DECAP_L3_IPV4 |
+				 ipxip_flag;
 			break;
 		case IPPROTO_IPV6:
-			flags |= BPF_F_ADJ_ROOM_DECAP_L3_IPV6;
+			flags |= BPF_F_ADJ_ROOM_DECAP_L3_IPV6 |
+				 ipxip_flag;
 			break;
 		default:
 			return TC_ACT_OK;
@@ -621,6 +645,11 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
 		break;
 	case IPPROTO_GRE:
 		olen += sizeof(struct gre_hdr);
+		if (!bpf_core_enum_value_exists(enum bpf_adj_room_flags,
+						BPF_F_ADJ_ROOM_DECAP_L4_GRE))
+			return TC_ACT_SHOT;
+		flags |= BPF_F_ADJ_ROOM_DECAP_L4_GRE;
+
 		if (bpf_skb_load_bytes(skb, off + len, &greh, sizeof(greh)) < 0)
 			return TC_ACT_OK;
 		switch (bpf_ntohs(greh.protocol)) {
@@ -634,6 +663,10 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
 		break;
 	case IPPROTO_UDP:
 		olen += sizeof(struct udphdr);
+		if (!bpf_core_enum_value_exists(enum bpf_adj_room_flags,
+						BPF_F_ADJ_ROOM_DECAP_L4_UDP))
+			return TC_ACT_SHOT;
+		flags |= BPF_F_ADJ_ROOM_DECAP_L4_UDP;
 		if (bpf_skb_load_bytes(skb, off + len, &udph, sizeof(udph)) < 0)
 			return TC_ACT_OK;
 		switch (bpf_ntohs(udph.dest)) {
@@ -655,6 +688,40 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
 	if (bpf_skb_adjust_room(skb, -olen, BPF_ADJ_ROOM_MAC, flags))
 		return TC_ACT_SHOT;
 
+	kskb = bpf_cast_to_kern_ctx(skb);
+	shinfo = bpf_core_cast(kskb->head + kskb->end, struct skb_shared_info);
+	if (shinfo->gso_size) {
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
+		    (shinfo->gso_type & SKB_GSO_UDP_TUNNEL_MASK))
+			return TC_ACT_SHOT;
+
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE) &&
+		    (shinfo->gso_type & (SKB_GSO_GRE | SKB_GSO_GRE_CSUM)))
+			return TC_ACT_SHOT;
+
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4) &&
+		    (shinfo->gso_type & SKB_GSO_IPXIP4))
+			return TC_ACT_SHOT;
+
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6) &&
+		    (shinfo->gso_type & SKB_GSO_IPXIP6))
+			return TC_ACT_SHOT;
+
+		if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
+			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {
+			if ((shinfo->gso_type & SKB_GSO_TUNNEL_MASK) &&
+			    !kskb->encapsulation)
+				return TC_ACT_SHOT;
+			if (!(shinfo->gso_type & SKB_GSO_TUNNEL_MASK) &&
+			    kskb->encapsulation)
+				return TC_ACT_SHOT;
+		}
+	} else if ((flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
+			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) &&
+		   kskb->encapsulation) {
+		return TC_ACT_SHOT;
+	}
+
 	return TC_ACT_OK;
 }
 
@@ -662,6 +729,10 @@ static int decap_ipv4(struct __sk_buff *skb)
 {
 	struct iphdr iph_outer;
 
+	if (!bpf_core_enum_value_exists(enum bpf_adj_room_flags,
+					BPF_F_ADJ_ROOM_DECAP_IPXIP4))
+		return TC_ACT_SHOT;
+
 	if (bpf_skb_load_bytes(skb, ETH_HLEN, &iph_outer,
 			       sizeof(iph_outer)) < 0)
 		return TC_ACT_OK;
@@ -670,19 +741,25 @@ static int decap_ipv4(struct __sk_buff *skb)
 		return TC_ACT_OK;
 
 	return decap_internal(skb, ETH_HLEN, sizeof(iph_outer),
-			      iph_outer.protocol);
+			      iph_outer.protocol,
+			      BPF_F_ADJ_ROOM_DECAP_IPXIP4);
 }
 
 static int decap_ipv6(struct __sk_buff *skb)
 {
 	struct ipv6hdr iph_outer;
 
+	if (!bpf_core_enum_value_exists(enum bpf_adj_room_flags,
+					BPF_F_ADJ_ROOM_DECAP_IPXIP6))
+		return TC_ACT_SHOT;
+
 	if (bpf_skb_load_bytes(skb, ETH_HLEN, &iph_outer,
 			       sizeof(iph_outer)) < 0)
 		return TC_ACT_OK;
 
 	return decap_internal(skb, ETH_HLEN, sizeof(iph_outer),
-			      iph_outer.nexthdr);
+			      iph_outer.nexthdr,
+			      BPF_F_ADJ_ROOM_DECAP_IPXIP6);
 }
 
 SEC("tc")
-- 
2.34.1


