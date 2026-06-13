Return-Path: <netdev+bounces-298948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hUxWFbA4LWpgeAQAu9opvQ
	(envelope-from <netdev+bounces-298948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:02:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 804F667E668
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 13:02:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=NvR1ZPA+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298948-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298948-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D8F5E300789A
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 11:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B533C3C07;
	Sat, 13 Jun 2026 11:02:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EC43C76B8;
	Sat, 13 Jun 2026 11:02:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781348523; cv=none; b=qtS8G8jQpFQqzvSKGnZDgRs5wWl0QLzE6WQ+gAOxr2u9i6V80bZNZpV8i4rNqUr/LIjPH58LmSgsDe24IRxZnBPbHJm6EdlPL5KJ9OTgbSRjXj6pPPEdpVkbRljwBJDEQylcNP/1lvZ0oF2RyFkRJ4DXVjw8UuG/dh2ZL2Miw0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781348523; c=relaxed/simple;
	bh=HW3pTJwO4RJ6zuUfrZ7jfvSLwOxOYXsdIGhg6Slp8EQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+0aIIhxspNI+hTqiHhcHxDUuQOCFB79CanMme3Gwtv+HhRmcq2c0gHuxEUWkD5tEf5UXPpfaxmXpGhOcbM2dQ3pfTrF0fBKYkABTXqAbtJmtuZqiKyYqkAd/4vj5dKC+umD3rYQsl7rXIn5B4c0xGcqtpLjpBr7eXhaWsj0ZyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=NvR1ZPA+; arc=none smtp.client-ip=205.220.166.238
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65DAtWmg172328;
	Sat, 13 Jun 2026 04:00:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=3w27mQHgCYp3ZLBrBbJrDMh8cjmCK8zeyg+YIAs8c6o=; b=
	NvR1ZPA+RAWVFmDlScoNEwKjyAiVXBQGTs2RUI4ncH3NUM+lOVW8dJFwGUSc8LnC
	ZXmRqkfwHAf4P3TEV/CHP/feCibZGTEMhKekn2Yc/KI9XgdRTD7IHWd2M8wCow1S
	coX2LBiBT+g6N30EF7z+P/dH0SB5DJU6dQ96TiuVDuO5RjMB01iaeBiPAHZ62CFp
	ZJhKgilZVV77N6YQsujD8Umc1U9b91OJkJCQh+x8iAwiOnSXtbrDnAVORc41Bsnz
	PUlxAet1pAhVKaNoDpfDrBOIGY27kI+J0ERTTIvHymwoUv9nqZ4SB06Fp1dthhny
	Ctj5jil80zZofFLkijxKLQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4es2g0865k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 13 Jun 2026 04:00:59 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Sat, 13 Jun 2026 04:00:58 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Sat, 13 Jun 2026 04:00:56 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <qingfang.deng@linux.dev>,
        <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yun.zhou@windriver.com>
Subject: [PATCH v3] flow_dissector: fix uninit-value in __skb_flow_dissect() for ETH_ADDRS
Date: Sat, 13 Jun 2026 19:00:55 +0800
Message-ID: <20260613110055.2318264-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609023752.1245848-1-yun.zhou@windriver.com>
References: <20260609023752.1245848-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ZJ/nX37b c=1 sm=1 tr=0 ts=6a2d386b cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=vesAdP9fBmeZQYaB-p4A:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDExMCBTYWx0ZWRfX2e/TwwfB5vWH
 W9psfsk6zbu+kZFWWMxugXFSTJh5CJ7l50BjJi1dy9M+3PJDHTx3gMsghel820LV9eSFD6r8ke9
 P2NJN0VHLH168DeB+IQQCJT4+SC8ndERQAHKLRY/nqKKldp63O5Gx3778KlI7fvLM4o0SBrHJH2
 AGrHa/410BA512xY3eCKI3eNFEpaw+XobDc9TksCV3et6iSOB21weL/I+VHdL0/DlTQfkoZqXmx
 bhkMyeR530ZKcyXIyaTaIe0qc33BUtPAxB+B+dVmMICkVDOLtOrjjroRiTMJRspLNHYid66BT1H
 YBpIryqmbJ80rIs0o+OPTUbSvvf+dWMJFicn4pHifk9YnBtXbUD3XhQCrqUlTLXR0WLtOcezjJ5
 y1dzmuVM7xuUlCOblYaq5MiHa11hLulxXwo8dJVvhZ+qhRuiXPpw7AdYaDZoJxAR/9iuBTUxF8F
 0k3QySkQMw/yL2D/Sxw==
X-Proofpoint-ORIG-GUID: mjPkkr0OXS1QJei-msV_adGYkTBsUGrK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDExMCBTYWx0ZWRfXy1531xnE+7Of
 TqAN+SLIhJJyj4BgVom3ebCbmHEGConZqpSTL1Aigp6h3NorAXQvf6Qu5SYxtX1acEOo6Yv6HYh
 75lMiENybrHVY6K68SPTcFDN7MO8KM5unwehaDeK8ppB/ztsYLsZ
X-Proofpoint-GUID: mjPkkr0OXS1QJei-msV_adGYkTBsUGrK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606130110
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298948-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:qingfang.deng@linux.dev,m:jiri@resnulli.us,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yun.zhou@windriver.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,windriver.com:dkim,windriver.com:email,windriver.com:mid,windriver.com:from_mime,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 804F667E668

__skb_flow_dissect() unconditionally reads 12 bytes from eth_hdr(skb)
when FLOW_DISSECTOR_KEY_ETH_ADDRS is requested. This assumes the skb
has a valid Ethernet header at mac_header, which is not always the case.

The problem can be triggered by:
 1. Creating a TUN device in L3 mode (IFF_TUN, hard_header_len=0)
 2. Attaching a multiq qdisc with a flower filter matching on eth_src
 3. Sending a packet through AF_PACKET

Since TUN in L3 mode has no link-layer header, mac_header points to
the L3 data area. The flow dissector reads 12 bytes of uninitialized
skb memory, which then propagates through fl_set_masked_key() and is
used as a rhashtable lookup key in __fl_lookup(), as reported by KMSAN.

Rejecting the filter in the control path (at tc filter add time) is
not feasible because TC filter blocks can be shared between arbitrary
devices -- a filter installed on an Ethernet device may later classify
packets on a headerless device through a shared block. The device
association is not fixed at filter creation time.

Fix this in the data path by checking skb->dev->hard_header_len before
reading. If the device does not have a link-layer header large enough
to contain the Ethernet addresses, zero the key so the filter will not
match.

Reported-by: syzbot+fa2f5b1fb06147be5e16@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fa2f5b1fb06147be5e16
Fixes: 67a900cc0436 ("flow_dissector: introduce support for Ethernet addresses")
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
v3: Replace skb_tail_pointer() - skb_mac_header() length check with
    skb->dev->hard_header_len check.

v2: Adjust commit message and comment.

 net/core/flow_dissector.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 2a98f5fa74eb..0b235ec0743f 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1173,13 +1173,20 @@ bool __skb_flow_dissect(const struct net *net,
 
 	if (dissector_uses_key(flow_dissector,
 			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
-		struct ethhdr *eth = eth_hdr(skb);
 		struct flow_dissector_key_eth_addrs *key_eth_addrs;
 
 		key_eth_addrs = skb_flow_dissector_target(flow_dissector,
 							  FLOW_DISSECTOR_KEY_ETH_ADDRS,
 							  target_container);
-		memcpy(key_eth_addrs, eth, sizeof(*key_eth_addrs));
+		/* TC filter blocks can be shared across devices with
+		 * different header lengths, so we cannot validate this
+		 * when the filter is installed -- check at dissect time.
+		 */
+		if (skb->dev &&
+		    skb->dev->hard_header_len >= sizeof(*key_eth_addrs))
+			memcpy(key_eth_addrs, eth_hdr(skb), sizeof(*key_eth_addrs));
+		else
+			memset(key_eth_addrs, 0, sizeof(*key_eth_addrs));
 	}
 
 	if (dissector_uses_key(flow_dissector,
-- 
2.43.0


