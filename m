Return-Path: <netdev+bounces-255521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFXMMg+CfmlQaAIAu9opvQ
	(envelope-from <netdev+bounces-255521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:28:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 789D7C4326
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF04B306827A
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 22:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA67B38B7C9;
	Sat, 31 Jan 2026 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="JaDkRtJb"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012062.outbound.protection.outlook.com [52.101.66.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E961838A9BE;
	Sat, 31 Jan 2026 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769898349; cv=fail; b=dri15QQgShakKS2A1FlVccBFeGyS20g5aCrDJaEDLdAvKLidkEQFQ/UFL8pJdm0QRtkDXtabRR7o1tTwNRU/Okp15jUyWfplvTjBTCW6rxKrwx3OLkfNWvFj7oRqL6JPV96jnV8rCt4cuu5Zjp6J+15/IJf/0tvDbocS6nE+o1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769898349; c=relaxed/simple;
	bh=uJNO/VBFLX3tqcZp/N6PGhGEAq6wlGamdozGtd3ewBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9qD2kapHrZ27RdNjF2tuoOhEnemC9amIbWMgFoHY7IRsC5vKDR58TxC7KL6Ov3V/L+YcIRrXvX41qhaDegAYBsS9K0RuuXekjlQuwrh15vCzRXZo427oxw5kioevjxr4zoOBh1MeIf6GqivsvN+t8c3zmo1hd+jDyBQ+f04BdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=JaDkRtJb; arc=fail smtp.client-ip=52.101.66.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ib3r+ItPxGh+Sb1YQrXm/HhXbXr5Jr24Re5Z0piz9YlUX7WVET5yjaliPOM5CNYUTLDWmQP3vX7A26ukxglqB21CPKRTM6ayhPpM21ahhHD7DHWEQsTtdFzFugW4WXnEZ0DlIm/uVZxszRGdUMiSQXmA2KaDSy4dv3X/uX/4T7wDfFeeRp3gKehzJ/oDXRFe/0YqI6BzQstrRz3XmL9xxu0J1Ldz5botV5tBSk1p3e8ircN0q2DttUaogHaq+rT9Zdb18LuIFTVZRqKzypma3FfDBLHK78UHf7zKIBCXBOgyz+HKt7sjDlsKqbfYmqF+vJf3jSyNiu3jggfIzGJCIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVKEnr5HcUK7GzXUn0ys+1+qWEHbOQb43zpWHETu7Yc=;
 b=HQp+Tff5wHdN4TzuIELuc4LoCP0+mOHIc8Ex8VGSvx/YZD16T032h2Y35zZyFZ7uGXBbXu3PGi3g4O+bg3n6NJd4MtxdMXiKMqCQnAbNb30m4C0ZWBokOKHt74e26wZSgpbUD4FPJl+SUJnPySrcE+NQ7YSyOgg0/h55dqRfYTW/KwXazgNQppHjhRh8lSRfdNNmukziXjvg+Er29Oi/DExoBhA6mKaRRHuT6ayulMl3PoO1Ut/gw8uGk5W8UrkR6PTwjq7vuDaAf9KxzpX+wzaDPeOgWJ3fN5MyFopSrivvfaILMibC+7WDQwhK8b07xI4d8ef4QNPxMAF7hlKW5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVKEnr5HcUK7GzXUn0ys+1+qWEHbOQb43zpWHETu7Yc=;
 b=JaDkRtJblGZfMUxXwkgc+M9KHZscMbB3iw0DI5ZYjYqO55IMrtvhtb/P+dw/VoVYMo3AUV9Jq8EF1gDnWTY92Qao5ZsBGJY1WCc4iioD9KbtnsVjNNKTx4pIQnaJaB7tM8UJuZk2TiXbrLlZ5vYxuJ+YbzNykq6G+aWCALre5KTPU62pvV5+NNFA9ObhfBouz0tXx/0SKvYOS+S9j09kgBrhUcv/4zCLXcrkssdb/EoQOZDjQ3tKCD8pLGzKhoRrmUz6pc7APBRCrL7iqF+T9oXVc01hXp4KdWbOzgM/mKV9isVKWQ97CxDKwiPHx9dv1FYxRm3bE/RQtFToYAg5Xg==
Received: from DUZP191CA0033.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::29)
 by DU4PR07MB10322.eurprd07.prod.outlook.com (2603:10a6:10:5d2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Sat, 31 Jan
 2026 22:25:41 +0000
Received: from DB1PEPF000509FA.eurprd03.prod.outlook.com
 (2603:10a6:10:4f8:cafe::a9) by DUZP191CA0033.outlook.office365.com
 (2603:10a6:10:4f8::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Sat,
 31 Jan 2026 22:25:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF000509FA.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Sat, 31 Jan 2026 22:25:40 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 61A6C2399D;
	Sun,  1 Feb 2026 00:25:39 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v13 net-next 05/15] tcp: disable RFC3168 fallback identifier for CC modules
Date: Sat, 31 Jan 2026 23:25:05 +0100
Message-Id: <20260131222515.8485-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FA:EE_|DU4PR07MB10322:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 27911fdf-684a-456c-c5f6-08de6117aac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wyT91s/BbQ9BC/QUgy2yVmLx5YgL8VSz1jKn/byW1hfQubFtoidPYt7S9nAg?=
 =?us-ascii?Q?t4nObvFwfRhS4RlB0MPLcGL6eMM4K56hUQKNpW+owjCuZHYo3f8GLn9OQ64t?=
 =?us-ascii?Q?FNL6OlADdmnYsWnmoUTYkR5Lonzv6BrMyjUbnQqZlfSFPceigbRYYVC8zanT?=
 =?us-ascii?Q?MpjCFA+KTC/4mFsgekiyl+49wx2KRdgYqSoDAJgW6kqdmAm5pJxXuUjGAXvc?=
 =?us-ascii?Q?HQ7CwvP30+WTaZorO+8FE/rpfuDRgXWAPCVT7DKjsFbj9GUvPo7zNFXTGDkd?=
 =?us-ascii?Q?HXC1RoMXdSSqJJ7gGH+2zWpGOCM/8/rkMyEDpehS6uYJLIPkJtkschbBbkAg?=
 =?us-ascii?Q?uq7+vY+EcgOv72A5BYqWl1g1Xn6qbtuwFh+sAQ4i5W1e+S1Bn7x8pr9kiITM?=
 =?us-ascii?Q?LHo9acw+FobVN+n9sAzNGU9mX1k1Q06wf2vJkfrLG+IkC7NVtCVtrYBBsdYd?=
 =?us-ascii?Q?GYNGrGM1pYjiyGC/7xnisaCO/EPBvtwLRXrQy411tARW8vbwBiK+4sGx2+oB?=
 =?us-ascii?Q?19CZZE5u02Xv8D7TCnd+Kr7zyIdHzw92UhPz92T5eu+61lKkbu/BqSVJnym5?=
 =?us-ascii?Q?fUi3sLwDid4+ICg3aOQmnufi5hV/rqAJZxi5G+zv01uh1l0jbB/lFoWAK/UY?=
 =?us-ascii?Q?DDTbcXBK/1MvOtME8CfXgKMcXMULPXm2EkLXnJN+LffyGW411f6W5doyTFuU?=
 =?us-ascii?Q?wH0nAOiYBe3AnXEsAm4lf8vF6YcP5C/0cD+1esaG4Q+QG3hVXL1VZc8jlUcF?=
 =?us-ascii?Q?v0mbjKKGkJoQgwCNBZTXvDvRZMk1eIMi2SwahcHl2ymQuOjrzIl5aGAZthOw?=
 =?us-ascii?Q?YRV4GFfvUCrRmnj/sS0Bas9t0Qa0NqrpH7pCDK8abx0G8frB2umaxbtn1SaC?=
 =?us-ascii?Q?T2Chtz11zod1ROE1FexDwWhvArO0v9gLu3QnX47NS+ZHPlDN++1qitbYl7Q0?=
 =?us-ascii?Q?JzDxhtpiFoPKgRUIkgnfDZHepmCf6iphkxciVN+6v981di6be12JnB7gAsHK?=
 =?us-ascii?Q?O24AlheyHl5R+2tJv61Y/3UkW+4tprm44AOzg9yCl3K7uKbk2/IuwyVI6fmf?=
 =?us-ascii?Q?XA428p8XgJZ4zbe4pq2rr5KiA/2ztoDopivQne//HQomwIR/ZQskRdqMV/Dh?=
 =?us-ascii?Q?zy/AIGiSOP+qeCT+iYLnCIcR4lSrayfaY5//sK1wt/DOWDQ61RhM+Enm2aHC?=
 =?us-ascii?Q?JFiOnR9+M7SkhqOIV/qU3nHyt58xXhByieFJduYU4fGge3daw5yyFLQ+ub25?=
 =?us-ascii?Q?ZgcAwWRFnsW2nPxt++Cr5wIEqvReMykzqcQwv+vmCxZ0YnYb5Oo6YnF636hm?=
 =?us-ascii?Q?LZWtlt/HWctRhagPryODozj78nO98oP/l50RRrytqqFi32uDaUU2bCw1sLz8?=
 =?us-ascii?Q?FGs8kvQEywdAOR1yBdEUw5qgbarGOI+3xzTW/70k9aYMa/5xYvdC5+AExHPB?=
 =?us-ascii?Q?szBTowJIrEI+TVKUNzsEliUbINV84lpjesc3vwE9dH+GkCph7B62Q8vsteQH?=
 =?us-ascii?Q?sN5EqoEjxlEihsjxJulte5Z7SNbuQWSc9rIUPOd4eS2tACTHf7Gfnqb565QF?=
 =?us-ascii?Q?WSIY+uzr40G+EtEYn+L5FbGtKZcEZKDPgr3Z1H97Ze56y5eykCXfJEE+tJXW?=
 =?us-ascii?Q?p6kiCpcG+VBmyKU2X9cCON2sg3BMf5sEGS8PA6RnWyc4kkeO79wxuObXC65Z?=
 =?us-ascii?Q?tP28Xg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qlpQ5LJfHLBRa9Q+Ln7JKZ5fDWMhTSuSht1AxXuJYKbmJwIUr2aCgSTDEMS78VEofmMrcqmepxiJ+WPiQpuL1FpWo4qkq8fxIA1+g3HuwcF819faJSbTP7tsSuJSj34JXm1e5TjrAKqJOvzkVuFyVXSqRsdtEeJ9UvtXsKUwqHkvuVLb8FMgsMwaoTgzLEVKUZiI4hKCZ9wCzVQLcKWTmiQDrRd6pRqfcKakqDoUkls2h/ITUMvBMJFT/PnbV1Xjp2TfNajU5fBqX9uuYiAyR6TVBOMvxbZS/WJSBMSXShYF0mnTbx1PvB1qfgLBJ/bS02zWh8PhAwZBHrBZPpNGlVXm/1YNKajVntiByclAClaJfnlyw4ABoY3yBenQ+RuUY1Rg8qqw0GfNqGmLLJIdldhJ4apKaSifALZLvyIpiNIG7Jt5GrvaITJIbR2cjz+s
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 22:25:40.9679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27911fdf-684a-456c-c5f6-08de6117aac6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509FA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB10322
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255521-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 789D7C4326
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

When AccECN is not successfully negociated for a TCP flow, it defaults
fallback to classic ECN (RFC3168). However, L4S service will fallback
to non-ECN.

This patch enables congestion control module to control whether it
should not fallback to classic ECN after unsuccessful AccECN negotiation.
A new CA module flag (TCP_CONG_NO_FALLBACK_RFC3168) identifies this
behavior expected by the CA.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v3:
- Add empty line between variable declarations and code.
---
 include/net/tcp.h        | 12 +++++++++++-
 include/net/tcp_ecn.h    | 11 ++++++++---
 net/ipv4/tcp_input.c     |  2 +-
 net/ipv4/tcp_minisocks.c |  7 ++++---
 4 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 90a89a5b256b..ea9ad0a3e634 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1208,8 +1208,11 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_NEEDS_ACCECN		BIT(2)
 /* Use ECT(1) instead of ECT(0) while the CA is uninitialized */
 #define TCP_CONG_ECT_1_NEGOTIATION	BIT(3)
+/* Cannot fallback to RFC3168 during AccECN negotiation */
+#define TCP_CONG_NO_FALLBACK_RFC3168	BIT(4)
 #define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
-			TCP_CONG_NEEDS_ACCECN | TCP_CONG_ECT_1_NEGOTIATION)
+			TCP_CONG_NEEDS_ACCECN | TCP_CONG_ECT_1_NEGOTIATION | \
+			TCP_CONG_NO_FALLBACK_RFC3168)
 
 union tcp_cc_info;
 
@@ -1364,6 +1367,13 @@ static inline bool tcp_ca_ect_1_negotiation(const struct sock *sk)
 	return icsk->icsk_ca_ops->flags & TCP_CONG_ECT_1_NEGOTIATION;
 }
 
+static inline bool tcp_ca_no_fallback_rfc3168(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_NO_FALLBACK_RFC3168;
+}
+
 static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index fdde1c342b35..2e1637edf1d3 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -507,7 +507,9 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 		 * | ECN    | AccECN | 0   0   1  | Classic ECN |
 		 * +========+========+============+=============+
 		 */
-		if (tcp_ecn_mode_pending(tp))
+		if (tcp_ca_no_fallback_rfc3168(sk))
+			tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
+		else if (tcp_ecn_mode_pending(tp))
 			/* Downgrade from AccECN, or requested initially */
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 		break;
@@ -531,9 +533,11 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 	}
 }
 
-static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
+static inline void tcp_ecn_rcv_syn(struct sock *sk, const struct tcphdr *th,
 				   const struct sk_buff *skb)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
+
 	if (tcp_ecn_mode_pending(tp)) {
 		if (!tcp_accecn_syn_requested(th)) {
 			/* Downgrade to classic ECN feedback */
@@ -545,7 +549,8 @@ static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		}
 	}
-	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || !th->cwr))
+	if (tcp_ecn_mode_rfc3168(tp) &&
+	    (!th->ece || !th->cwr || tcp_ca_no_fallback_rfc3168(sk)))
 		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 }
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e823a3b1ad3b..59dafcb45c16 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7090,7 +7090,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		tp->snd_wl1    = TCP_SKB_CB(skb)->seq;
 		tp->max_window = tp->snd_wnd;
 
-		tcp_ecn_rcv_syn(tp, th, skb);
+		tcp_ecn_rcv_syn(sk, th, skb);
 
 		tcp_mtup_init(sk);
 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index bd5462154f97..9776c921d1bb 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -485,9 +485,10 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters_payload(sk, skb);
 	} else {
-		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
-				     TCP_ECN_MODE_RFC3168 :
-				     TCP_ECN_DISABLED);
+		if (inet_rsk(req)->ecn_ok && !tcp_ca_no_fallback_rfc3168(sk))
+			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
+		else
+			tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 	}
 }
 
-- 
2.34.1


