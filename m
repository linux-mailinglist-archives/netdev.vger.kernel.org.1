Return-Path: <netdev+bounces-278957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KljEBSW4GlMkAAAu9opvQ
	(envelope-from <netdev+bounces-278957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 09:56:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D046840B3BC
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 09:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84F313023DF8
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CAD3859CD;
	Thu, 16 Apr 2026 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="i34IzY2l"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8744D3BB57;
	Thu, 16 Apr 2026 07:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776326157; cv=none; b=AB9Z9QovWPjv+/R+Idkj8nfPT20xf5XgXhsUKZpkPAZtR94iRe9F5ytWEBEdRdpi0gqbQMvtIbZLyeZ0K9WSmGtaKAbiqUZk7luTenaPWUC1twQN0Rmj73rkQ+lXYxYI3kB2plT3NK5niqDhBsfRv+KuLIWCUBv4LEKeVbBufWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776326157; c=relaxed/simple;
	bh=AOrgGm18RpXJx6dzbMiEiZQi+s36OnXKGXf1n/IitNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mSUvaq4I4i7qU1+Hw96WqSEB4/PWwXpLEVlXHCSWSoDyQbwXgHloqJcCKmjKex9aEIUBdLPsqA3KDqqErw4ddhAtUe/1WV14g4t2JEiCFTm0dg26eDEj4ubg1rxnCPi/D1FbWV2Vne4g6ighsEEzYL8ARJ9ZsUs20W9+XBwtZgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=fail smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=i34IzY2l; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G68NSf3779255;
	Thu, 16 Apr 2026 08:55:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=ebf5Q0PaD
	nQoiYyhcMGVsZMGw3fN+UO6cglPFawnc8Q=; b=i34IzY2lm9zp7JUvTu8YU1ztZ
	luI3W8toom1jBOtIgrttx11mYmTiS6GPrEqKBN17zRGHwLeXYDsEjoCXhYYAzzRq
	GERaHYj2ZXYpeYbva5hIkxb6mgMDDUUxUlChMOhogo2EqaboOSyLJvN3c/f33zqT
	Bb3Ugq1+KGtT0ZZn7mcw3q6xguSsKuk1tBbF054TntAuKjYajN6qrhG8EIlDWttP
	fq4O8ct33T1HAkpsREKzIq99KIjloQsNc5Whwa58LKjwg97cASM/sVBJwJYX66iK
	/ygcbwV4quYra9K53L6IyVm1oA4yz/qlUxdiU0DIeuXpTRQ1PypR1OBcCBs2w==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4dfegxnmt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 08:55:22 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 63G7fftw011505;
	Thu, 16 Apr 2026 00:55:21 -0700
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 4dj2yre0b9-1;
	Thu, 16 Apr 2026 00:55:21 -0700 (PDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 58DE68D;
	Thu, 16 Apr 2026 07:55:19 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, Max Tottenham <mtottenh@akamai.com>,
        Anna Glasgall <aglasgal@akamai.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 2/6] bpf: refactor masks for ADJ_ROOM flags and encap validation
Date: Thu, 16 Apr 2026 08:55:10 +0100
Message-Id: <20260416075514.927101-3-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416075514.927101-1-nhudson@akamai.com>
References: <20260416075514.927101-1-nhudson@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604160071
X-Authority-Analysis: v=2.4 cv=fKsJG5ae c=1 sm=1 tr=0 ts=69e095ea cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=5uIk5skAYop0meUMGpPt:22 a=X7Ea-ya5AAAA:8 a=XTcGtYan5i681LpXN6wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA3MyBTYWx0ZWRfX14lAy8Tgui15
 //DhoIprac7ic6PBlgY5Q0eO/BxonUXKzpHbNXQBe1Kb63XTKeg/uJ6B9ZciHeXm5eTa/Q8m+9k
 KFKKUijdw2SM4Tr8RX1l7XmEpCIh0PYW1sP7E/SLzQeKmIJsqPGEKB2P5G/8owRGgFbS+8dQfTF
 kTvO94szxl8G4yU3KuGjQturbjLj2fcPjoEnUmixbAChrkQYNC9MkJXkPkEAIOnbFPb19qWYLXT
 umlU6QeFYPETsmO17ihmm0Yc6FzP9ximVSJSTWlUHGu0k3+wBgaW0gWbvy5EDak/DmQU5+HKTMp
 hPg7ojQ9wTc1ptbrHfMBpn61n1qPxtCnGwK+5GpCc+LbjPJH/42iiR91z2ChQl5lK+yOY70fILu
 RBexWDHu1k+MYfpFi2mSK5/sFJmDtmQVAcIYaghmk97ehKyP/M7IH1YCE+YoU0HeMARPTCEIjMe
 8kOXbiDRsbBJMf9uFGw==
X-Proofpoint-GUID: R7xemJ62Bu0xBVX9NJQuJ-tdP3JHa9L9
X-Proofpoint-ORIG-GUID: R7xemJ62Bu0xBVX9NJQuJ-tdP3JHa9L9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160073
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278957-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[akamai.com,iogearbox.net,kernel.org,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,akamai.com:email,akamai.com:dkim,akamai.com:mid]
X-Rspamd-Queue-Id: D046840B3BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Refactor the helper masks for bpf_skb_adjust_room() flags to simplify
validation logic and introduce:

- BPF_F_ADJ_ROOM_ENCAP_MASK
- BPF_F_ADJ_ROOM_DECAP_MASK

Refactor existing validation checks in bpf_skb_net_shrink()
and bpf_skb_adjust_room() to use the new masks (no behavior change).

This is in preparation for supporting the new decap flags.

Co-developed-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Nick Hudson <nhudson@akamai.com>
---
---
 net/core/filter.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 78b548158fb0..4e860da4381d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3490,14 +3490,19 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
 #define BPF_F_ADJ_ROOM_DECAP_L3_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_IPV4 | \
 					 BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
 
-#define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
-					 BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
+#define BPF_F_ADJ_ROOM_ENCAP_MASK	(BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
 					 BPF_F_ADJ_ROOM_ENCAP_L4_GRE | \
 					 BPF_F_ADJ_ROOM_ENCAP_L4_UDP | \
 					 BPF_F_ADJ_ROOM_ENCAP_L2_ETH | \
 					 BPF_F_ADJ_ROOM_ENCAP_L2( \
-					  BPF_ADJ_ROOM_ENCAP_L2_MASK) | \
-					 BPF_F_ADJ_ROOM_DECAP_L3_MASK)
+					  BPF_ADJ_ROOM_ENCAP_L2_MASK))
+
+#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK)
+
+#define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
+					 BPF_F_ADJ_ROOM_ENCAP_MASK | \
+					 BPF_F_ADJ_ROOM_DECAP_MASK | \
+					 BPF_F_ADJ_ROOM_NO_CSUM_RESET)
 
 static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 			    u64 flags)
@@ -3618,8 +3623,8 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 {
 	int ret;
 
-	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
-			       BPF_F_ADJ_ROOM_DECAP_L3_MASK |
+	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_DECAP_MASK |
+			       BPF_F_ADJ_ROOM_FIXED_GSO |
 			       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
 		return -EINVAL;
 
@@ -3715,8 +3720,7 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
 	u32 off;
 	int ret;
 
-	if (unlikely(flags & ~(BPF_F_ADJ_ROOM_MASK |
-			       BPF_F_ADJ_ROOM_NO_CSUM_RESET)))
+	if (unlikely(flags & ~BPF_F_ADJ_ROOM_MASK))
 		return -EINVAL;
 	if (unlikely(len_diff_abs > 0xfffU))
 		return -EFAULT;
@@ -3735,20 +3739,20 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
 		return -ENOTSUPP;
 	}
 
-	if (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
+	if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
 		if (!shrink)
 			return -EINVAL;
 
-		switch (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
-		case BPF_F_ADJ_ROOM_DECAP_L3_IPV4:
+		/* Reject mutually exclusive decap flag pairs. */
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) ==
+		    BPF_F_ADJ_ROOM_DECAP_L3_MASK)
+			return -EINVAL;
+
+		if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
 			len_min = sizeof(struct iphdr);
-			break;
-		case BPF_F_ADJ_ROOM_DECAP_L3_IPV6:
+
+		if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
 			len_min = sizeof(struct ipv6hdr);
-			break;
-		default:
-			return -EINVAL;
-		}
 	}
 
 	len_cur = skb->len - skb_network_offset(skb);
-- 
2.34.1


