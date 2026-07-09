Return-Path: <netdev+bounces-306077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6gzUHBBGT2pHdQIAu9opvQ
	(envelope-from <netdev+bounces-306077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:56:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 798E872D64D
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 08:56:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=XQksD2ro;
	dmarc=pass (policy=reject) header.from=windriver.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306077-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306077-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 812F230115AA
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 06:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8573D47C3;
	Thu,  9 Jul 2026 06:54:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8BE3D331A;
	Thu,  9 Jul 2026 06:54:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783580055; cv=none; b=kDMHThoLwc2Lk6bS5Wl/1AiKqYJrTYc76iq+ctWNF4iWvZqbdselxwDOQC2wlp6MxgbJ4ELC0FLMFeB5zrue3uzCzlAluogXTIpQx7om/aeSILNd5ZDV7HpX4YX21rIeGJGRtqhp7Xwk8GZWdyvNJQxfdBNz2t5nSXrmXInABRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783580055; c=relaxed/simple;
	bh=DX4gZvLYCixv4NhF0nzmT/YM8ujz+348uaicUVX4ZZM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=knAm8fcafDFCVtAMUSoEL7o//tk9xeg9uq2ZNvfKtVoQUeZc0jTBaPuhlJKHfaEtDPwyRwdkmyuPM3xVV4SXMpM1A1rnZGWfUyOZVPDY/r6qgG/o40z76nsTGGbYC1vivi7gNenLWEvQa8TADiApZJDbrC9aj9cgAX16C5nfp0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=XQksD2ro; arc=none smtp.client-ip=205.220.166.238
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960vMr1594988;
	Wed, 8 Jul 2026 23:54:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=KLcYoZ35J
	aJVz5ZvCLMLfrYs9ZHDHT/cvVXGYK25lcg=; b=XQksD2robUEZRvxOq0u47Qlew
	4s9V5eptjB1UvjKTw3QSKY98WX8XXEXTqIULNId21Uuxmv+ywkv8q83spDpoHm4b
	qrEbeyftJWwGxlNyhi6sPkR0epil/OzhtcFfrLcVc7S11PBByuw3eayw6NAuE+8P
	sg2znA9gSbGfToU14Cm97GGcJWXUHDrag7R7qcm15tU1GvVHFH6OuGAqPLqKG7nj
	TLDZtQT6aH+qrdpYnLf9/S7FNuhcQXDz6F3CePpHwsANAO8TKms9bZ+drjQsr/7l
	CR/i/AXuUYAI+Tbf08QLMF7pDc2iC24dh+LiRkiTqXDMyti7iCe+VXoFJ+E1Q==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fa1atrdfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 08 Jul 2026 23:54:03 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 8 Jul 2026 23:54:03 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 8 Jul 2026 23:54:00 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yun.zhou@windriver.com>
Subject: [PATCH] net: erspan: set lltx to avoid sch_direct_xmit deadlock
Date: Thu, 9 Jul 2026 14:54:00 +0800
Message-ID: <20260709065400.3467803-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mic7Nga850FZECk8i4CSelo1n5o2sWeY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA2MyBTYWx0ZWRfXwwTl07marXzW
 OuzbcbfcxO8a4KfGO4rt6srZRArFyo7qD2XE1IL2FLJ4N0UuMtvtPGlx6el3epsD+cs9KWa9+Rj
 XFvelny6HIvnd8WYbehi1Aj13kmgj7jESkrvZFujrZjdcJnJ0z5+DMiGr2eWSX3iZns7ShnI925
 PkKKvbFguv+mIh/WpCRj5LcMemV3z+UZUmZSHgDoArV5pIbqYpoTJASWHnr7cEU51v83zSq9YG4
 oQmPwwmy0M3lfXe9NP4AdBvezbWWA4jGp1SkreiONi8HGSwWggYZw/V7Mo4jYA9sR0zzlFAhpL2
 vemPOJviO05bMpLfAxbye5UaD1yVATFA8Xg+52JBUTiUPHbQhKX1c3OIUPTG6ZcQtQG0+O9TIug
 +GbOgGl/Zxg73mOum8aOBdCRbNprsCmGN0M8G9rownBHnYaqI4FbzAGM1V3aAWiJ1E2NK3yQ2Dr
 qEpmtPU14JOTLu5tkdA==
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4f458b cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=edf1wS77AAAA:8 a=A1X0JdhQAAAA:8 a=hSkVLCK3AAAA:8
 a=t7CeM3EgAAAA:8 a=JjHGVKUl6pe_7mdbYbAA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: mic7Nga850FZECk8i4CSelo1n5o2sWeY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA2MyBTYWx0ZWRfX5EGyYexGJKf0
 dnui8TCSpazIwm5UyUh23YN4RBl7n/UPxqeUHTXgPDssKC8yaPPifkyckFwj693MkS0KrU+Wdws
 Lv+kz+1f3ogJvUSvYU/cETafmDz+Wok+tOuJ4+SPWJpNv+656RGq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 adultscore=0 clxscore=1011 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090063
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
	TAGGED_FROM(0.00)[bounces-306077-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yun.zhou@windriver.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,windriver.com:from_mime,windriver.com:email,windriver.com:mid,windriver.com:dkim];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 798E872D64D

From: Your Name <your.email@example.com>

erspan_xmit() re-enters the network stack via ip_tunnel_xmit(), causing
nested acquisition of _xmit_lock on the underlay device while already
holding the ERSPAN device's _xmit_lock. Both are ARPHRD_ETHER and share
the same lockdep class, creating an ABBA deadlock:

  sch_direct_xmit [lock erspan] -> erspan_xmit -> ip_tunnel_xmit ->
  ip_output -> __dev_queue_xmit -> sch_direct_xmit [lock underlay]

Set dev->lltx = true so HARD_TX_LOCK() skips the spinlock for ERSPAN.
This is safe as erspan_xmit() has no shared mutable state: o_seqno is
atomic, stats use atomic_long_inc, and dst_cache is per-CPU. GRETAP,
the sibling device with identical xmit structure, already sets lltx.

Closes: https://syzkaller.appspot.com/bug?extid=9bda1b9fbb7fbdf9b62b
Reported-by: syzbot+9bda1b9fbb7fbdf9b62b@syzkaller.appspotmail.com
Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 net/ipv4/ip_gre.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 3efdfb4ffa21..9fbff16cda1d 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1363,6 +1363,8 @@ static int erspan_tunnel_init(struct net_device *dev)
 	dev->features		|= GRE_FEATURES;
 	dev->hw_features	|= GRE_FEATURES;
 	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE;
+	/* Skip TX lock: xmit re-enters stack, risking ABBA with underlay */
+	dev->lltx = true;
 	netif_keep_dst(dev);
 
 	return ip_tunnel_init(dev);
-- 
2.43.0


