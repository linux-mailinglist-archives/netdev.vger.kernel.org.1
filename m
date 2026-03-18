Return-Path: <netdev+bounces-269020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA2MIxOtumlVagIAu9opvQ
	(envelope-from <netdev+bounces-269020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:48:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 321632BC4D4
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94D4731A39D0
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192C43D9057;
	Wed, 18 Mar 2026 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="ZR3hDlBt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41EC3D8917;
	Wed, 18 Mar 2026 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841409; cv=none; b=moG2kQn5dRb2B44ZNKnMWZKUFchSOrGN26JUwZsIDqsPQLyEJUCg6I8h9VZk3z3/A2lqG9DAxuK9w/oY8Qy3R8g73Ab5ANojy070Swpa/7pJzhzZEfH06Yh2QWh3SzvzI0UPGgOt2zAyxKPPEfF/k6MvRYKV01CpzyTZf33Saj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841409; c=relaxed/simple;
	bh=+2FhGu4bv5TPwZmq8KPd4Yzg432t12XwMMlgwv2ZJpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SoWvUdhXDvXuKGQIvq/qJfkHqqpUiGE1/F0JIaqYZw3LlkmTmwjGwqKXSIkMKjqgWLZu+4ovgf7Z84oomRV61iNGGXa+9W2rQ2+M+bEMtrH6AelLEEsQTvNVz7IPzsCy9R8fpbox57BCcL6/OYpjXch1nL7y5qROIgYS8/1R12Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=ZR3hDlBt; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IADinF957995;
	Wed, 18 Mar 2026 13:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=ce3qw5wRH
	2Snv48qPdphagY8RIiQ3mMLnOEfc+YtVdg=; b=ZR3hDlBtTAF0cItKGZYielcmm
	NCIlpHFj8RVar6RUU3jRyC1miDY/GmMcX6cd0MACD+ck3PaQcI3B42JXe45Zg97z
	vkndo+LAbblKnUGsPTTyM3SIdj8s77ReKNKiYmXeqHElR2GWUIMQTj6CbR7N4LyF
	Q+ex0YwfZBQK+SV6ocAtaTLg7YVy9cFjeF5sw7WnSCypG/tlFLrJOOw4m2EghwMe
	26kNQlW63cWRInQ+S9Rq16V/VhrbL5wUUqtRUypN38U86uinD5upvGBQhvfV+XLM
	CjYPA2/w/MCCPAml+ial1uIcNZjSpDk+pej3cxlWEZR7C5GgfV17OvQRkHv+g==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4cw0kmrkbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 13:42:52 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 62IDZ06g006365;
	Wed, 18 Mar 2026 06:42:51 -0700
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 4cw5n9fs2s-1;
	Wed, 18 Mar 2026 06:42:51 -0700 (PDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 062F79A;
	Wed, 18 Mar 2026 13:42:49 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Nick Hudson <nhudson@akamai.com>, Max Tottenham <mtottenh@akamai.com>,
        Anna Glasgall <aglasgal@akamai.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] bpf: allow new DECAP flags and add guard rails
Date: Wed, 18 Mar 2026 13:42:41 +0000
Message-Id: <20260318134242.2725749-5-nhudson@akamai.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2603050001
 definitions=main-2603180115
X-Proofpoint-GUID: A5toxlEtRJ0dK0Pct_l6c06thpxZpyHo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDExNiBTYWx0ZWRfX00bnBkFPMqSA
 buwAU3or0FN5PHhHoOaDPweMH9P8PxxmSIbqFnebywoz5dZCLovkRxLTJXyonmQJEa9RIBKYatV
 82XH8k5KYj5Old4sIdEhb/Qtm3yrcysaVIB/EeALI9U+eLkQc/ai3+suHa7r+Z+MuPLi4mCYepO
 Y+BkUliF5Sqimk7BKORj0pnseXn1PkOMmigXhYlGjeI7XseHk1Xhy5JQuRsnvn3TOga9hTVAJls
 ZUKUiflJPgAs50DLtEXgLLrwedEj92r2Gda48VdY7lXLueRjdizg8c5PKyJlEwkZwxEL7qSsZTf
 zqEtmK9GHukDblM7QiyAKAzqEWqrilyztfTihbjyIT9mwsja0LttCnR0358CxPwGOPKQWG081lk
 gnTTOKZTF7hhkTRqZ4/t4BDrkNwhlIxf06kdRSusKYiuBzm5CspDxge+UZeU7BskqtxpU8NFv9m
 f4HsdPWoCUEcLEWtvOg==
X-Proofpoint-ORIG-GUID: A5toxlEtRJ0dK0Pct_l6c06thpxZpyHo
X-Authority-Analysis: v=2.4 cv=ZMznX37b c=1 sm=1 tr=0 ts=69baabdd cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=4OENtXgxWbduB0e82o7S:22 a=X7Ea-ya5AAAA:8 a=AKn1LIXN5h1LY4S_jUMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603130000 definitions=main-2603180116
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,akamai.com,linux.dev,iogearbox.net,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269020-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:dkim,akamai.com:email,akamai.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 321632BC4D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add checks to require shrink-only decap, reject conflicting decap flag
combinations, and verify removed length is sufficient for claimed header
decapsulation.

Co-developed-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Nick Hudson <nhudson@akamai.com>
---
 net/core/filter.c | 47 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 7c2871b40fe4..47aec44a9cd3 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -56,6 +56,7 @@
 #include <net/sock_reuseport.h>
 #include <net/busy_poll.h>
 #include <net/tcp.h>
+#include <net/gre.h>
 #include <net/xfrm.h>
 #include <net/udp.h>
 #include <linux/bpf_trace.h>
@@ -3496,7 +3497,9 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
 					 BPF_F_ADJ_ROOM_ENCAP_L2( \
 					  BPF_ADJ_ROOM_ENCAP_L2_MASK))
 
-#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK)
+#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK | \
+					 BPF_F_ADJ_ROOM_DECAP_L4_MASK | \
+					 BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
 
 #define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
 					 BPF_F_ADJ_ROOM_ENCAP_MASK | \
@@ -3743,20 +3746,44 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
 		return -ENOTSUPP;
 	}
 
-	if (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
+	if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
+		u32 len_decap_min = 0;
+
 		if (!shrink)
 			return -EINVAL;
 
-		switch (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
-		case BPF_F_ADJ_ROOM_DECAP_L3_IPV4:
+		/* Reject mutually exclusive decap flag pairs. */
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) ==
+		    BPF_F_ADJ_ROOM_DECAP_L3_MASK)
+			return -EINVAL;
+
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) ==
+		    BPF_F_ADJ_ROOM_DECAP_L4_MASK)
+			return -EINVAL;
+
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK) ==
+		    BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
+			return -EINVAL;
+
+		/* Reject mutually exclusive decap tunnel type flags. */
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) &&
+		    (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK))
+			return -EINVAL;
+
+		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP)
+			len_decap_min += sizeof(struct udphdr);
+
+		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE)
+			len_decap_min += sizeof(struct gre_base_hdr);
+
+		if (len_diff_abs < len_decap_min)
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


