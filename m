Return-Path: <netdev+bounces-255524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBtPGqGBfmlQaAIAu9opvQ
	(envelope-from <netdev+bounces-255524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:26:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 86556C4268
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3C5D30091DB
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 22:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B534B38B7CB;
	Sat, 31 Jan 2026 22:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="SvvME6wI"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0621D38B987;
	Sat, 31 Jan 2026 22:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769898354; cv=fail; b=DdAo2rD4olDc1rDbvpYvuu4sPkd581sUSF8Vb+x01yOcxCI5ye6fuQotM0V0CGD8ebKUAOUwDub56Qb7z3uNKiTH24iAB2g1rcwhj5xdgpyyJPJQxKPZTIFpPCkOGcTK1QUHAZQyjIPFSTWDVq2ir1Q+bjUJKU4gfIgcfemGIE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769898354; c=relaxed/simple;
	bh=NOjgHNUrR2eTiioWi5DbDNX9/+lA1farWyPYGGCaByE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARfoTz2jpCi75nv8FjNwqytoysprUwnHZ2kYFhdgpWnhnIzx24z/p4PaVdBumsDeDp35ystgugLoDIoQNM00pew/lYLnEN3NYPWNfMCBCnNwAY5bJ+Cq2s8Q45xIUBVIW7gHfiR6YVXi5djrmYR2Y4kKd4rFIBmnKatCy6TasPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=SvvME6wI; arc=fail smtp.client-ip=52.101.84.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lz8F/GHLM7RG/WZeiNa90AJHyLOEMPvQtup1O6YABK9D5BqahhaLiXOP7z6vXdYjAaPi7BcHDJhIJAy1eiMImD6aSUfTN86hXm1YB2s8sEvinbpJQ4+vsy2W12FPAHoK38j9V6thGGWtc+Y7S4oi1ZegOFI4wKnPy4lnG7d/TulrxTXw2ZCKJz5JOEIs8virP1wPj00wZG4EhOM5lsRDSdbX6OP8C6y6DMdI51Y99ux1dt3yKSO881blxxL4dTvElbeouTRPHYJD/QzOJrdaGG6lGApOfHY6tnHy72ZX6J9XVgRdDlRFNghVbw46TeZge+VEWjvGYeoH5IGjIG3MuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q90k8aAuiVl/K7KlBMwPy5+SxS2q7dMI2+RXkwhEjK8=;
 b=E4eHUkN5J/UhGU3DOY/H0fi9R20Nlcokif7MZDA35k0sIz4RLWOOC/qxsrzVuxO8C0BtVDxmvhZ7+VTn3bf7rDe/Ol0Djl/v+gbjDYW5BHtMhe9gKy6fQBZHdZTULxLunRXSphphV8mPZSwiFdO3f6sOiPropineLGdi4yA5M0SQHgj6QDntZFrgD3fcfLLCWcg81lYKx+R5Y+0Q65pFQlYRe/utNHAaRb939UrFF9G9ZCfnnAjr4qIkYlXuA20pB4XQI2JIkpo0xF7qxnVgzbrLHIfWcPLcAYy7mpSyeXZivjCyRDczTenv7k1VWmTJexPwEa2CV34w7cg1A6odqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q90k8aAuiVl/K7KlBMwPy5+SxS2q7dMI2+RXkwhEjK8=;
 b=SvvME6wIKz3tuq/1X1y1wMVyOkxGZwldQAIMgBvIEGKIwcUWrKYdiq8YWF2bTlQqcktNnJ2qcsq/mx7uafTY7EdZIwjo2qvpmdgQnpc+VgHv+Dsv4TcdK9bGNGOc7/vea+M2FBB0B4caFczMmNXX+2I7kZuJ8vi1bUJJNzsLCPZ5OHXZRj6RI5DGhZh3w9frhBKvSKAtjpq4gHySnZsHOIxAPkDrmrlMYmlBdQ45uBDpsDl7tBt3JXmBNeyi/n2YU+U7wSVNjlwP3H5vCVONd7290fvlvEWlFSeKG4YMdJJhsxyflkdft+iKqOfCaN9E1Akqg3bwjMdrj5/Z/LZChA==
Received: from DU6P191CA0033.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::8) by
 DU4PR07MB11494.eurprd07.prod.outlook.com (2603:10a6:10:61a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sat, 31 Jan
 2026 22:25:49 +0000
Received: from DU2PEPF0001E9C3.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::bd) by DU6P191CA0033.outlook.office365.com
 (2603:10a6:10:53f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.15 via Frontend Transport; Sat,
 31 Jan 2026 22:25:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU2PEPF0001E9C3.mail.protection.outlook.com (10.167.8.72) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10 via
 Frontend Transport; Sat, 31 Jan 2026 22:25:48 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 516A12396C;
	Sun,  1 Feb 2026 00:25:47 +0200 (EET)
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
Subject: [PATCH v13 net-next 09/15] tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN SYN/ACK
Date: Sat, 31 Jan 2026 23:25:09 +0100
Message-Id: <20260131222515.8485-10-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C3:EE_|DU4PR07MB11494:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1aadfae7-4554-40b2-4906-08de6117af7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yREKG6m0pbv43ce4/t1SgewzPUxkTsCwDuGhcrf98CukLrwBx8bKZ0zi1JAH?=
 =?us-ascii?Q?/xHXOhliyof1uZqYDT/+XK53JIrQUdX5TwZI1fbl2ZuZ8y4+fXB4/MMk01xz?=
 =?us-ascii?Q?H0lbBwYKatGNV4ig6NNmeble3BiPtiKR0gXT40v5T3ZVCBN1HcIH7wZVsa1E?=
 =?us-ascii?Q?YXmDXiNHvIVHtJfXKCh2h/GPd9tr3zFzsl0CPb/lHGRdB1r3btX79Ayiisxk?=
 =?us-ascii?Q?yNHIBUery7ZEjVQJsQ/0fkY3qoh6nU0KtLauYtxJ4ZSuNl9eJrh19cecePhA?=
 =?us-ascii?Q?IMglY0jUPRSwgy0EjlmBg86bUfi6sb2w4L9dKd7JxeqGDU1jdjJaScuCHJYJ?=
 =?us-ascii?Q?lpVbR3jjCa4Izw+/Uppuki5GJbn1rSyyu3ZbL4Y5qIXavMejhzEZ3KGANQ8Q?=
 =?us-ascii?Q?+wAROs+o7bw5s0wQeAsa8a48uNSMovGRajeg4TuUoT8WnZY+QSmhxuXRQYBA?=
 =?us-ascii?Q?wL3/5XNB1YeBk+tZaI0YPsaYjZ6+gahf0a343VkW0nQUzTIjTgsUVTTTzZIN?=
 =?us-ascii?Q?XUede8ZjRi5i87B3NXUymeCwapOFrEjEhqYHDEa89nsroylHHMFlOIpBkzKM?=
 =?us-ascii?Q?g1t5BEpgEAlpq/XZoINcRBWOxd+esUHT11nXywSjYqvYQ54cUL5Cl6Kpcs/g?=
 =?us-ascii?Q?es4Ki83jF6ZLVAsudy1S+tyxNM/ZSVEaAK3n6ll64VQ8J8EXOihIcIqLdUym?=
 =?us-ascii?Q?HozWonyZihQd04K09BPw6941EJNLwnGCTZCd4RM1emxbDeHkmym8isH1Hj9c?=
 =?us-ascii?Q?UaGRKcIkHFmBnukXqT1V4bIys20jVLOCsfhpiEatz6xTQ2MLwwLWkKJlQnQK?=
 =?us-ascii?Q?RvgkgdCSfXBGbFqSkC5vqu13U7PCNTkq1Wbcm16g8E5spradDjCAyWNQnnz8?=
 =?us-ascii?Q?FREFKwQ1Rr7HcKPG65ujfeUz4CQ+Y5fiVikX7vbprRDDrlfgTY/RVuZWzyez?=
 =?us-ascii?Q?J83DIRhrxUai0BZrhPM8GDv/dTul9ScSe8rNFuNxZbM6IvCGio6Y7YIYTcRQ?=
 =?us-ascii?Q?gfKGdzz/SE3d3c5Slhi+t0Qxg/SNYukxMfHQPVR8CPssNw1L4EiXkNU5HD9n?=
 =?us-ascii?Q?iXoZqbsMiH8uvjRKSlgHh6m1TjZv23WeOEUpYEsMYHBVmJf4RinAZp9B5QJA?=
 =?us-ascii?Q?zAKNGWsjkKHktaX1iDmLUT+Pb3uxCAgREwhuZMFvfsTlb2c+jX7KqkxYd7CP?=
 =?us-ascii?Q?olkb3RD0UlFMIuIcNJfEWRQq9whkqdqrNqJrUVfJzFALowgJgdgIECHHbPEs?=
 =?us-ascii?Q?1CfCKfCRFt4LKZYZtcxC/FtzEBnVQxNEnnA+5oSVZat3DAaKiE3oRMZ7Pd5w?=
 =?us-ascii?Q?ZiBF52zmt0kE/DQBSAp+tXkAn35/qeZoU5PZFViCM8pOPE4V+33nkIUSNEUc?=
 =?us-ascii?Q?MiYzbeRI5+f1wWQ4wI/xVEMSPTf0B01NWNYfI843pbt4NFWyN3QRoOUG1yvZ?=
 =?us-ascii?Q?x/1UCUmkt962kVG6w4SZSD/ywVZjnfSoe6M7Zg0RuwZ+DWZJ5lkl81vG4OYm?=
 =?us-ascii?Q?5YGJjTTHtILXc9fQuBiYNqkux5K6nlNUjvSx44hUdY+uqYj8kccJXp8p6uPx?=
 =?us-ascii?Q?Q6zX9EoJsVTuIza3q03iM61wcdtvFNby4RaXHrVLskgPA++0RwDowFPz3OiW?=
 =?us-ascii?Q?5z/iRIuRwrml/g7sdshNmhRug/9IKI20vcSDy2WnFtyMxJidjUmhvaVX4txG?=
 =?us-ascii?Q?pPTM7JIPmIy5N6ln+ULObtgUj0k=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b2KUrmlmJgQzsLn4HQmv7aAgLW65gIC9OVBjrK+yNfgoLsl1pqfyjW5eQERdjmnMTyKR3f2Z7LLyELvFiSa7cLd7qa/2THrm7QNrkFY9/VyKg6wSKEn9JSpO69ooke/s59UfL9X/ubMgg5okHLcW5BsudFzor3ioH+1ukE0uCPGEUP5/eObcNnfOdLQf07LEseNfSznGnHIf9icQtYQLwb8zAzJQf0zGWn6W3EV+x+NL9bSGWxfPQumnuuHk9ceqwrtUfPK8czW8KpISH16ilGOp4rWYfzCToYe2KZBm8NT236FmtYby/UXPt773vKhYgm3rPtNZQjFd4TsBMcR9c4AO5Yw71wwTCesNDzzsm5HsmrOfq9kDW7quoxXzRMTH9CpQAZ3byZoOs2fSD75D7x2BE7x/Qaw+GYD4yEjBmnbO5Pa/rwgYPPLlKbSoOFRC
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 22:25:48.8892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aadfae7-4554-40b2-4906-08de6117af7f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF0001E9C3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB11494
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255524-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 86556C4268
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

For Accurate ECN, the first SYN/ACK sent by the TCP server shall set
the ACE flag (Table 1 of RFC9768) and the AccECN option to complete the
capability negotiation. However, if the TCP server needs to retransmit
such a SYN/ACK (for example, because it did not receive an ACK
acknowledging its SYN/ACK, or received a second SYN requesting AccECN
support), the TCP server retransmits the SYN/ACK without the AccECN
option. This is because the SYN/ACK may be lost due to congestion, or a
middlebox may block the AccECN option. Furthermore, if this retransmission
also times out, to expedite connection establishment, the TCP server
should retransmit the SYN/ACK with (AE,CWR,ECE) = (0,0,0) and without the
AccECN option, while maintaining AccECN feedback mode.

This complies with Section 3.2.3.2.2 of the AccECN spec RFC9768.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v7:
- Update comments and use synack_type TCP_SYNACK_RETRANS and num_timeout.

v6:
- Use new synack_type TCP_SYNACK_RETRANS and num_retrans.
---
 include/net/tcp_ecn.h | 20 +++++++++++++++-----
 net/ipv4/tcp_output.c |  4 ++--
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index a709fb1756eb..796c613b5ef3 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -649,12 +649,22 @@ static inline void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
 }
 
 static inline void
-tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
+tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th,
+		    enum tcp_synack_type synack_type)
 {
-	if (tcp_rsk(req)->accecn_ok)
-		tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
-	else if (inet_rsk(req)->ecn_ok)
-		th->ece = 1;
+	/* Accurate ECN shall retransmit SYN/ACK with ACE=0 if the
+	 * previously retransmitted SYN/ACK also times out.
+	 */
+	if (!req->num_timeout || synack_type != TCP_SYNACK_RETRANS) {
+		if (tcp_rsk(req)->accecn_ok)
+			tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
+		else if (inet_rsk(req)->ecn_ok)
+			th->ece = 1;
+	} else if (tcp_rsk(req)->accecn_ok) {
+		th->ae  = 0;
+		th->cwr = 0;
+		th->ece = 0;
+	}
 }
 
 static inline bool tcp_accecn_option_beacon_check(const struct sock *sk)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index a1596fe8dd9f..22728daed436 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1106,7 +1106,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 
 	if (treq->accecn_ok &&
 	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
-	    req->num_timeout < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
+	    synack_type != TCP_SYNACK_RETRANS && remaining >= TCPOLEN_ACCECN_BASE) {
 		opts->use_synack_ecn_bytes = 1;
 		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
 	}
@@ -4012,7 +4012,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	memset(th, 0, sizeof(struct tcphdr));
 	th->syn = 1;
 	th->ack = 1;
-	tcp_ecn_make_synack(req, th);
+	tcp_ecn_make_synack(req, th, synack_type);
 	th->source = htons(ireq->ir_num);
 	th->dest = ireq->ir_rmt_port;
 	skb->mark = ireq->ir_mark;
-- 
2.34.1


