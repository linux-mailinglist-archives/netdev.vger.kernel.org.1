Return-Path: <netdev+bounces-255525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA6vHn6CfmlQaAIAu9opvQ
	(envelope-from <netdev+bounces-255525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:30:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E37D8C438E
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E14C23086934
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 22:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B1238B7A0;
	Sat, 31 Jan 2026 22:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="BZCUIssD"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013027.outbound.protection.outlook.com [52.101.72.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C8538A9D2;
	Sat, 31 Jan 2026 22:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769898361; cv=fail; b=fuaa/Rnuh0H5JuQ4HKb2MLa7+qn4JzdAScUKPTeGj1R22MuUpDfapYNP5eUnLf928abuTK0rjA9QaPcyqtQvmt3VIf6Nl2FJrl/oEZ/3zz/iH3WAxcM9eu4KipjsCQDttqdTDBiqNcF7AWBkWRll8L0ir1sZxZ8j7WNM3ih0C8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769898361; c=relaxed/simple;
	bh=aCGsXc0ECY/51S4/B0Qg3jxznul6XwrSFbVpn24dnzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lm0Ci7XSluGYhAFJMPo1n3rUq998uOXNo3LXfGCMHRtO04KXS1YE/ncxe/liFaXminRBhT4cAe7SZsXZW9kmNsfhXeiRtRRunQ/NNfogv8J5BQiYPfsvObXv0HGj7srUDyWeGJmbjj9mZ48je4Qs6MaLjKAmRUVNVhuRWIdX4jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=BZCUIssD; arc=fail smtp.client-ip=52.101.72.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsH4sjBpJlW2LztceX1XdhVKDa/BUg1uwJIVKlFfkHRa5WsHwCAnSdP7rs7Vjl9kU4RaAnrfRv8hMU7kDqobC/YlPJioOSsLHmYdT72eCzQ4dxY+VToTET6Zcq5ELaWT/AqAX2M+HHB/8C3IoMiS9mjdj4W19HCXuxXpNFCeTL2Rdbd0yDX3MuatsjhznkNsc0JcxWXwe0HBDGqZAvdVzJ4YEeJCJwN8x4edgzARUfgJ4fP/I2mFQ+x9XjFSd9jpFvyhNKLylwIKJ2EcRS9TZj/IfSEdmtir8ti5wjFZY/1wKjhayJ+ySoXV54dqgTOlWt/UlhTBwvjKrDJI3CBXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wyfNjdHTW6TPKt9tvUN3NKTKqjlo3f7bHppT8NJiuk=;
 b=Biluri/RqE2K4xXUpEVywmzk4zLFS85Qwx0m98dBOvS0NQtGoZDXeVSq6mmgEWLvVytFd6sOFoz7wNn6ea4b/TD5fiKBhodhPoYOhwZ82DmOxqCFeoIofJvavA290X60SCZFa9wVSuqM701pRwpUUAJhZCLf8Cd1xKUpDLoyzsfy0WZl49d1sZVo4LMvZ9FyEp6EAZIthu/L81XH4/yHXNh+FOWb4/C22R0IDJZciDUdt8O5vXygC5X4WNX2iNJpfdSJ9kC80R9fEfSIyqLetIsbSuyCE4WlYUNbugeE9/iALX2xdJ5zRdN1crDQhCePQEQNKae5vv7PQx1USOMftw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wyfNjdHTW6TPKt9tvUN3NKTKqjlo3f7bHppT8NJiuk=;
 b=BZCUIssDovAURzSGySldUycgnjYO+UBZGcTiuVWhaV2y52RZYTQR5u1HiN8Ajsyz/hB6HK8575yThaPmC8+ucfhuVIxL+gV0sdG3nx5So/VJY3o0F0kmjBVedUxxo0zJM7yFe+iW8RWbF3nAydA02lZvpTTI0/JMW8ecr88Gq3kCPUag2WN1dNgSnjz01enaW50khb7EJk3chDvWLLgMypTP2ufPwoyI1K1HHtOq4T9bLUvfX+KAvnwNLQN5nPDfkugkcy3O6BVvQxbw0ApsvoPqaXfOBci/7/iGC613PIOPaCeksowpxanbqIxXvySI0kDZeiFmpu8i2dr0IVeAzQ==
Received: from AS4P251CA0030.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d3::18)
 by VI0PR07MB10827.eurprd07.prod.outlook.com (2603:10a6:800:2c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Sat, 31 Jan
 2026 22:25:53 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d3:cafe::af) by AS4P251CA0030.outlook.office365.com
 (2603:10a6:20b:5d3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Sat,
 31 Jan 2026 22:25:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Sat, 31 Jan 2026 22:25:52 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 0CA0C23906;
	Sun,  1 Feb 2026 00:25:51 +0200 (EET)
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
Subject: [PATCH v13 net-next 11/15] tcp: accecn: fallback outgoing half link to non-AccECN
Date: Sat, 31 Jan 2026 23:25:11 +0100
Message-Id: <20260131222515.8485-12-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|VI0PR07MB10827:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c8c45e65-b7f4-47f9-2464-08de6117b1b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rvLSd8zSvJwI10J0EZ5IntWD8gUM9Y94LD9Po+om/+9fyRWwBPnpEmLasmK5?=
 =?us-ascii?Q?epcrHZLeACH8pmxXT2iFpaso+5xCf4doNST7u0261aalY6VdvMOkZNas7vgB?=
 =?us-ascii?Q?fvI+C9+BGDlBmafkt29Nf29bcpuk1F4W4ya1vwr8GenCwgbUIMADFRF5dtkI?=
 =?us-ascii?Q?4EJeg6LqVX+x2N7ZAYp2sbqzGzUGOuUnMlYtFEtMp7LuPqrPpCosMZYnC4va?=
 =?us-ascii?Q?mF+6WHMoVReme8gBbVbkJKAedTLl9aAxxwU+bBa5EsNAjN9Q/Qc69D4oDpSu?=
 =?us-ascii?Q?GIQagLCG26rECEYjSm/XI3ZWFOP9WHGBOpVdOYpEp3NYTPk1Bwk6+yypZgZy?=
 =?us-ascii?Q?k8SpVQuERkhJ1rqLFo574/SPO2koT9UB5n97tqSJaxLrYjq6gnH7b8lxzaW2?=
 =?us-ascii?Q?FYmiPzSZOLhNSPoL2j3TnEVPRfmmcB/MQtDf80g52vpJVetwKmBQZpAAQfMg?=
 =?us-ascii?Q?0qs0S7ojEX4CBiCQt1MV5lr0MGR5sZyTCuWbsVNrLk3zKjh8SyKlHsZZMd/P?=
 =?us-ascii?Q?g0Aw4r0Yz8lwbrnzrDAiXhyJlSD52ebslhOpy5na/YIuasmzfRGr/I36sPHV?=
 =?us-ascii?Q?vAsBcrMNTUHbXVlV2odi46RKfiSfJxX1TIIP5FSswpAWDzEgRMPRRRwqGxUm?=
 =?us-ascii?Q?eqkR0HaB5PwrKqJ3AzTv47K2163uPxPMcE3FqdprZvVqAo0gX859XrFconJN?=
 =?us-ascii?Q?/Yvrcs8ZJcPJMnIe+Gf35tzULZmQJcj5ENyWWLdHhOtD1wRaEgwjvRAdOkzf?=
 =?us-ascii?Q?stmt7ZznbSaGv5Q9Nkf8THceYRao0H/PHwl/0sWIpUdUM/1OVItQTEzAtFRs?=
 =?us-ascii?Q?X9IfV+59bIAvMkj+wvZ3Tju1SqpirBllGMv1iBMxDWtJQObvyNAlEDP83hg0?=
 =?us-ascii?Q?Ifc9IPJ0a6HxchwS3ItMqofxTkYL+M7/VP8QqUYXf21B7uJHPym1ve8gF/UI?=
 =?us-ascii?Q?yfvIJ9vpYPJ20htJ7PZkO2iE2gK4RYj+4SfXnebQbVhJBIQ9K4rxKOPb8lB1?=
 =?us-ascii?Q?iz92SSpILXLMyn01C4kSAZBJCjy9e4SjVCyGFGUuY1UF3zrYDQm25TjdZ2n7?=
 =?us-ascii?Q?wVu2ir7QDFKa3ZoJ0ZYzNzOYp0rwFz8X+ejgajAlIz8lR60DstCMNiKXPuvs?=
 =?us-ascii?Q?aRu0funDcQVJ3Drv3CJk5EvdP11LsR68oB3F96AALbXT6maG3ceNRItpigU2?=
 =?us-ascii?Q?08z2IOIZzu9kk14ixlSjL2V+3JTr2Hh5wG0pzlcQZmBCptxR7Uk/3Xv8O481?=
 =?us-ascii?Q?M/xE5FgSkRUR93EHX299EEXrFGKebYrItlIhnMYjYiIvSLjyEchsvqreT5hN?=
 =?us-ascii?Q?/sMr7N1sSs7WKcm58FT1bUwp4UzkHuArhhpDe6a3Nt/GBVvm72r3uYBs/eFn?=
 =?us-ascii?Q?ns9CazOtkqwNIPqTHd+g+AIWLB7aZOaV+6ZXG42zYdGw/DTnWlkX4uECG7NP?=
 =?us-ascii?Q?9ymnXXrbxUFYrOVvKupHAMAN6bqssmdGsZUwCIyKzDrnidNmojW78pJQgjtJ?=
 =?us-ascii?Q?bI+yI8YgUfV/QnJMyciLGvHBo3P4Td9QUkQcOTur9edCaFgFLER2P+95broB?=
 =?us-ascii?Q?tDaVwwXBPLVNHSq9pXq/17dRgL/cs9sfqzL0q8kBCC8rfr1I2h2LYtOYZ1nn?=
 =?us-ascii?Q?Jt1vDs25N3GouHKAEWdpwf9XMhiYlrpLT+qitoS9TZcBYyJ9ip+cSdHKKmSp?=
 =?us-ascii?Q?yXH2ZOVE0qWOxWAcGUWqaNO51t4=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cebIjgKNJzU/5DCkcEio+aTb/niffMvvqXUEsbnsXK9xT0TI5qR45pmmMu+VF9+kjMsS9L+S5OIcfXoBO/zjofGAZSZtetaTGQL6vGHIG866ykErbkzfjIy7pKqut/IucKETg8/5VX98/+RrpQiIhBBGl19wB0ocLAtnZVRMfwdedLnvJ7LSGYv+CtvWgJ5mtzR0iIj8jN4OIvzMh8RnilZYNN71FICu33vtQWHBzlqzWgkIHwCb7FHiCUkNoH/RbvfrVjf3My2uYtwmFkp6Bq3ZxBe1EAv2/eJO9d84qvqC3c6F4P6MX0upz6kcHjH8uI9BWApxyPmHljZKV4KqD4og3b5AjamvOiKIIkk5E5nr58P9Q7VKxi/ZSTr5OcS1NOUFJZ8p1RUjjULqxS3l1LBN225L/dHX7mqPV0zE9Lfdtim858x8yjWtUculjcpZ
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 22:25:52.5952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c45e65-b7f4-47f9-2464-08de6117b1b3
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB10827
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255525-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E37D8C438E
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

According to Section 3.2.2.1 of AccECN spec (RFC9768), if the Server
is in AccECN mode and in SYN-RCVD state, and if it receives a value of
zero on a pure ACK with SYN=0 and no SACK blocks, for the rest of the
connection the Server MUST NOT set ECT on outgoing packets and MUST
NOT respond to AccECN feedback. Nonetheless, as a Data Receiver it
MUST NOT disable AccECN feedback.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v3:
- Remove unnecessary brackets.
---
 include/net/tcp_ecn.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 796c613b5ef3..49e0b865fe02 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -175,7 +175,9 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 	switch (ace) {
 	case 0x0:
 		/* Invalid value */
-		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV);
+		if (!TCP_SKB_CB(skb)->sacked)
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV |
+						     TCP_ACCECN_OPT_FAIL_RECV);
 		break;
 	case 0x7:
 	case 0x5:
-- 
2.34.1


