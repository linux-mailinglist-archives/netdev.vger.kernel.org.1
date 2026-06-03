Return-Path: <netdev+bounces-294700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tlhlKYr/H2ottwAAu9opvQ
	(envelope-from <netdev+bounces-294700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 12:18:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF5363680B
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 12:18:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=k4DqaNoX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294700-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294700-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B3FD3033D0F
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 10:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B44734678E;
	Wed,  3 Jun 2026 10:11:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BD23793A9;
	Wed,  3 Jun 2026 10:11:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481517; cv=none; b=dVOKjfiCRylB/wTGuh05LWuMNkecL1pUzUE+z3bs6M3jtTsUx20NaQcWcfRNorUgrtfsnyp+0Xor8STLL3hSnpiVsdiIHLTd47vy1bcRXn+Kri1Ey6tV/sCwbDoLiMtlbnJr0Qoze+27p49l/Oj5JYbYxfN7tPAuVspepqYZk0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481517; c=relaxed/simple;
	bh=VT/AbgzpwYIdPhfFF3qxpBYkIgtvk7ie5bjkw7neSEA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tK6ow+VHHfcocL3E+J6EfH9aR7flkTp4zImq/dTTgD7k6sgeXwO7bH6cXhwuMEwG35UCmXSeFMTMDQL6upbyUryCEpaZf55Osb7crO6IP+bMqDj8gpxhAWmEeQo+kqmyRQMJqrNYK68Bx28l+rmPmGADeN/7pokQh3rFh3KF4kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=k4DqaNoX; arc=none smtp.client-ip=205.220.166.238
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6537IvW83578562;
	Wed, 3 Jun 2026 03:11:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=VVkAIEvTk
	THyvXbfCeU3GSS56DtBCaIdoHwLo1O9pmw=; b=k4DqaNoXHPq2kB2J4BP68jUxW
	b7iXzOGdYPp6BxRyNTQR7lIBm6n/Ki6p2l9JC3SS9LzYydcnqWbcQUJ/2KI51qtw
	USvBjhKKsNw5OfEsZI6ISy9/0dBtEDo2rUl1ri4hyk+mADEyivWN9YYddKNqSHYy
	VRwO7LuRyQ1od26MA0zXRprnA8sI99kAHMd9yhXzlXrsHHFTghasXxSnTpTGJB97
	7hSNcf2eSja6eE/lDdMe/boj3IIu9W0uw0y7A0vXjQQh6+KzK3GhPwNVL9hwTcQc
	BGdn5s+aJMJLv0OE6kmRWjyUcZwogLoiPELQ6VLcwWxc7iE1wbDxZGIVKnVOQ==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4efu61xbrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 03 Jun 2026 03:11:39 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 3 Jun 2026 03:11:38 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 3 Jun 2026 03:11:36 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <edumazet@google.com>, <davem@davemloft.net>, <jiayuan.chen@linux.dev>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yun.zhou@windriver.com>
Subject: [PATCH] net/sched: cls_flower: reject ETH_ADDRS match on devices without L2 header
Date: Wed, 3 Jun 2026 18:11:35 +0800
Message-ID: <20260603101135.1954370-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mPj7jRwkllWKyBWx00nTd6lqlZC709dd
X-Authority-Analysis: v=2.4 cv=PLg/P/qC c=1 sm=1 tr=0 ts=6a1ffddb cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=cvSxm1HUZ1WmS5hy66IA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: mPj7jRwkllWKyBWx00nTd6lqlZC709dd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA5NyBTYWx0ZWRfX1BGA6LYb+NyR
 ATrH92v3bV69vOfwqs6ZF0GVl1DhPIrikDkttVewE4wHoWyk3U5QWw6X8C9cCsfj5LNXCfJQHDd
 75w7pOVCAoJfGhPFnU4OEBhfK1mBEoioUZNzKVZoJaMUswsBljwk0vhEPpo/zeHzso2FYIvZ9M0
 zBes8JGVR/XkBglSESeDP9+k57+cUbjZxnN3IK5ibfGRb4ZwOKgp7Tf0mnMD+Be4a8pfNMCdtp0
 IQJp25crogFhNzU8n0Gyk/y2qQNyujpXSDn0KSiSK9pDayp1tRutgoRqR+BbSJdU8aX5iWS6lNE
 J7cib1vclZCrbRlZo/7QAtUF4LohrOmHG8cBJ/gREegExfgg9K4dy6RqXEKVzZK6RByPT3LJHcU
 SgTEqguV2qNFL4raIeg2vJPThxtx8gfCt5tgYmyLK1J8/geelhpKkJZ47B9G0YBpW+MC1fHhxM+
 BPbV7QGsBI1XFRlAG+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030097
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294700-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:jiayuan.chen@linux.dev,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yun.zhou@windriver.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,linux.dev:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFF5363680B

Reject loading flower filters that match on Ethernet addresses
(eth_dst/eth_src) when the underlying device does not have an Ethernet
header (hard_header_len < sizeof(flow_dissector_key_eth_addrs)).

When such a filter is installed on a device like TUN (IFF_TUN mode,
hard_header_len=0), the flow dissector will attempt to read 12 bytes
from skb mac_header during classification. Since TUN is an L3 device
with no link-layer header, this reads uninitialized skb memory, causing
KMSAN to report uninit-value in __fl_lookup via rhashtable_lookup_fast.

Fix this at the source by preventing nonsensical filter configurations
rather than adding bounds checks in the hot classification path.

Reported-by: syzbot+fa2f5b1fb06147be5e16@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fa2f5b1fb06147be5e16
Fixes: 77b9900ef53a ("tc: introduce Flower classifier")
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/sched/cls_flower.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 88f8a32fab2b..187cb6a60309 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -2465,6 +2465,18 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 	if (err)
 		goto unbind_filter;
 
+	if (FL_KEY_IS_MASKED(&mask->key, eth)) {
+		struct Qdisc *q = tp->chain->block->q;
+
+		if (q && qdisc_dev(q)->hard_header_len <
+				sizeof(struct flow_dissector_key_eth_addrs)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Device does not have an Ethernet header");
+			err = -EINVAL;
+			goto unbind_filter;
+		}
+	}
+
 	fl_mask_update_range(mask);
 	fl_set_masked_key(&fnew->mkey, &fnew->key, mask);
 
-- 
2.43.0


