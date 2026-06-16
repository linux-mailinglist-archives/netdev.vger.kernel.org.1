Return-Path: <netdev+bounces-299830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +fY1BEZCMWplfgUAu9opvQ
	(envelope-from <netdev+bounces-299830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:32:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B06768F59F
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:32:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=WMxehVeN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299830-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299830-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6114303CC3F
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5399A3624D4;
	Tue, 16 Jun 2026 12:31:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDA9361662;
	Tue, 16 Jun 2026 12:31:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613096; cv=none; b=eeoJf7XKdfXFwOjwRaNXun+GEJ5dGYXPEEEmRLyZaFCTkJUCDQbjaOR/C5L26SPnlN3sJrXGsB/1z4exI7QIafJX4PnGY0ofQqtbnCvxGfZNony09yFwaiEDVuLxIBWDEsFhHgUPcRVK5N5ykaZXf+GCMmNHggrVFpQK9Xm6qsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613096; c=relaxed/simple;
	bh=muXkly5qKrjaiT97CHDyop6lLCZWfg35npgqM0qgMYQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rMhEVMnWip0rKyJo9YHtvW4VARur28Yp0jrpO+UAD4n4a3PX4ZhGTO5D9j2IxL2aWHuBDUEiL3UVMnzSRI2YFbn4ErMIiV9iKSSHDfdsy4zUFZ38VR3ifRPSJQlXte7e5synAKj1Kb0uo0196kcuC3yym98l9oeos1g6xA5lXgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=WMxehVeN; arc=none smtp.client-ip=205.220.178.238
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GADXS52683725;
	Tue, 16 Jun 2026 12:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=Ett3BQwWy
	iSAE88v7iGkgTRZbBVeQovANuLqlij8Qpc=; b=WMxehVeNzRViGhjHsu1Le9Ywt
	Qraz7WKbvCPV84l/6nAWZ0uqZvdA9Cq5KV2qLzEPj3ZqTxkkxDdvQtQI6/tXKM7u
	HWQgHMDc+D+W8rIMbZcy1i1E0gv3ulGvebd/JEIERGiEfHwfIVOGT48Jy6+Y+Yqs
	Ak5YXT4qpjUZG2jgUHzDH3nidIm/WhA4wNYPng+iBRRnC80/u8BiRSfq2xwoheJW
	M0+VPwuD0G5oHTo8oN3zWJy1nBjbMZaLNtGWYB8Z0+BnZgaA/YVAtgnF3BSouoXd
	xj49f8P9Zv+nNq3Lra+EZGXuKIbzJgcE1wFV/er6z/VI3AwQYOkUUwqF3aTRA==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4erx63vqgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 16 Jun 2026 12:31:01 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 16 Jun 2026 05:31:00 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 16 Jun 2026 05:30:58 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yun.zhou@windriver.com>, <qingfang.deng@linux.dev>
Subject: [PATCH v4] flow_dissector: check device type before reading ETH_ADDRS
Date: Tue, 16 Jun 2026 20:30:57 +0800
Message-ID: <20260616123057.482154-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=SvmgLvO0 c=1 sm=1 tr=0 ts=6a314205 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=KJq9PGNaTw6kngS7AtAA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: _RKJA3YIfS1BFPggmvT3fe5jFv1j6dy8
X-Proofpoint-ORIG-GUID: _RKJA3YIfS1BFPggmvT3fe5jFv1j6dy8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEyNyBTYWx0ZWRfXwDYs8JugErB+
 T752p0jxasw4d8F8+BRVWgdJ196vjHUwGZUuCn5jClcESPf16b9AZVSL/ZlTVT1ZsolWtSu1uC0
 VMLZNEnxIb0/sMkkffhdmzMzSg99GCTKRoZo6rXOWyy7/417FHqv/SL3WkXco7YiOtNsw8KL+uq
 fAKXM9ADZ4MXhNGBaSj/AyX2+spkB8Y6YyPg4klYBDRQNMyOrqr/KYmf6n+wudHtVRa4opTM3fV
 /x5MUZlNSSFgVBclYoLsVZz40PAoti1nNwwEF7+GceRJo+nsY3gBdTNjqIT01ysV1s0HLXF/jLR
 8DygQH0XUhtcnjTWmyJvH94bXvQoDBmEkBsF6alY9rPRESXzNEqX5lzDCNYBfjVRrH/jAudvInZ
 mmFgV6fWLwfgbQEAt30LQ36nT1o6FK9adI1AAFFr/3CvkRORtQ3C253B3l3lgZn4gpQTWresa58
 OWf5THVtN028iiwTCjQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEyNyBTYWx0ZWRfX3n5SzlGrtXMF
 CfGF/zAx6tk5siK1XKX5k1PSdC5BNUSGQcwC8LLSueAUeAPhC6/nf+B1yMSgwxIREXCgQFqRqkN
 B1u8d8QGI48OqbYPjsSkDTh2LGEE8lP5lLkqbT4loE1L3jH48sRo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160127
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
	TAGGED_FROM(0.00)[bounces-299830-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yun.zhou@windriver.com,m:qingfang.deng@linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B06768F59F

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

Fix this by gating the memcpy on dev->type == ARPHRD_ETHER, which
ensures only true Ethernet-framed packets have their addresses read.
This is more precise than the previous hard_header_len >= 12 check,
which would incorrectly pass for non-Ethernet link types like IPoIB
(ARPHRD_INFINIBAND, hard_header_len=24) and FDDI (hard_header_len=21)
whose L2 headers are not in Ethernet format. Additionally check
skb_mac_header_was_set() to guard against the pathological case where
mac_header is the unset sentinel (~0U), which would cause eth_hdr() to
return a wild pointer.

For the act_mirred redirect case (Ethernet packet redirected to a
non-Ethernet device sharing a TC block), zeroing the key is the correct
behavior: the packet is now being classified on the target device, where
Ethernet address matching is not semantically meaningful.

Note: on non-Ethernet devices, the zeroed key will match a filter
configured with all-zero MAC addresses. This is an improvement over the
previous behavior where uninitialized memory could randomly match any
filter.

Reported-by: syzbot+fa2f5b1fb06147be5e16@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fa2f5b1fb06147be5e16
Fixes: 67a900cc0436 ("flow_dissector: introduce support for Ethernet addresses")
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
v4:
 - Use dev->type == ARPHRD_ETHER instead of hard_header_len >= 12 to
   avoid false positives on non-Ethernet link types (IPoIB, FDDI)
 - Add skb_mac_header_was_set() guard against unset mac_header sentinel
 - Document act_mirred and all-zero key edge cases in commit message

v3:
 - Replace skb_tail_pointer() - skb_mac_header() length check with
    skb->dev->hard_header_len check.

v2:
 - Adjust commit message and comment.

 net/core/flow_dissector.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 2a98f5fa74eb..8aa4f9b4df81 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1173,13 +1173,21 @@ bool __skb_flow_dissect(const struct net *net,
 
 	if (dissector_uses_key(flow_dissector,
 			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
-		struct ethhdr *eth = eth_hdr(skb);
 		struct flow_dissector_key_eth_addrs *key_eth_addrs;
 
 		key_eth_addrs = skb_flow_dissector_target(flow_dissector,
 							  FLOW_DISSECTOR_KEY_ETH_ADDRS,
 							  target_container);
-		memcpy(key_eth_addrs, eth, sizeof(*key_eth_addrs));
+		/* TC filter blocks can be shared across devices with
+		 * different link types, so we cannot validate this
+		 * when the filter is installed -- check at dissect time.
+		 */
+		if (skb && skb->dev &&
+		    skb->dev->type == ARPHRD_ETHER &&
+		    skb_mac_header_was_set(skb))
+			memcpy(key_eth_addrs, eth_hdr(skb), sizeof(*key_eth_addrs));
+		else
+			memset(key_eth_addrs, 0, sizeof(*key_eth_addrs));
 	}
 
 	if (dissector_uses_key(flow_dissector,
-- 
2.43.0


