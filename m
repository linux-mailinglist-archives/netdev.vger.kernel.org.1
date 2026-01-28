Return-Path: <netdev+bounces-254297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKHlBBUgemmv2wEAu9opvQ
	(envelope-from <netdev+bounces-254297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:41:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A35C6A2FBB
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0635D30CF432
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAC835771A;
	Wed, 28 Jan 2026 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="am22sO7i"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012039.outbound.protection.outlook.com [52.101.66.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80FF35A925;
	Wed, 28 Jan 2026 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610912; cv=fail; b=G/RXWhOQAqve01XDAXCb9IEsGUZ2R6AyNG4icfMiOpsJv8wlskBgUaX9eqj482Ti1n+G/JsBc0U8vTJukQndVCv0w51duOF3xjF6iHKflmbee50UYg+uadLwYv86RfwnvDMcOFpxb8dA6fvcWMk7s/prGOm8vAyb7di4C9nCqek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610912; c=relaxed/simple;
	bh=d4IBDGBu6NMSZehTmkZ65wy1qXNZogh3hmvPH1GgtrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qk76HVypdTO3X+bOVh/Kskosy1GJYNmEznJfe9wFvDwHde9ilxAHbAxjzjwodDJmU+3+6QntbTXzfpLDMd/iSUJQkqafHpkw1lhz9SHUMKLa3EqwSAONH+uztHqkUgmxRhEuZFAx2Tn+opWKCbHSzYoYha23adC5HhooUeEdgKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=am22sO7i; arc=fail smtp.client-ip=52.101.66.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9Sn1sQVXWwKI9ypruQOP+4KAT1KMwjecic1AP0Y6m39qNN+djL/MN2L9XLqRTCDyLj/Cj+9VUHTIBY276OLkFRtCzW5SNYp5wxKKKghakg8FTEfA4NFFv9QpLDhEBEVKd8v3QTcggLzCw7lSoNysafJZtXbqKtcuXbgi3CIU2/ifZK+YyTu0q0L1MGqXKBWenbKaj1dEevVtYuzBT3FhfV6qL5VxBKCVAI2e9xBflH9Bo1fYRHAmCzpCKyEDxpFGcSomGmiZ4kGTuNHUNxEihBQ166U9x3LeWyhZNxRSVNnYsN0HgvfbixtR8DKhUfj1IP2V9PFiGEpbSCFqoaR5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRXU5DTfKcnbe55wTGAPjvkihU+6Gn4w/lE/gUN+EqQ=;
 b=CWYvGQcQ21WsNcdAPs2jmwxvjOEjDcrrGHlL5MXHveznWdC5oKodoL8rQSiRL/iMcKB0jXe+wG5H7Q3k0/jOCeypZjb5iMdHW44SlGA61hw1ySz/fA2OmdXXhD3mYAcuESMcOvNeBYS8AuvBFQPJg465PpCWhIJ/HlpDa2WOQDyOO0MptuEi2jguFaO1XEkfOWXpp51nDu2hra/E2k6sTwQ9s9xBkk1kI0Pwjcy4pZFfIOllGnaBF5XKROSRcaL7dmXwgjU88m1JQmXrYxoa+B0ZU5rdPYR3D0XFODKnCCbCy51H3OUi5GtwXGD1gwNsD9sMynpAZcQUsNXzrECwrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRXU5DTfKcnbe55wTGAPjvkihU+6Gn4w/lE/gUN+EqQ=;
 b=am22sO7iuBWi+5PbD1AuVrog3DuVObMVOKbYEGDEffKqZwd9QRh9S5NZ722y/yaYh8XQsz2wWQdCqZ0UtpI16YppcDhufQXKCO3J5m/nBSI0IwxVyd0OEF+Jr+kA4H8SLLzuzAqeY0iW5W7Opopx5fjbh4hBLn1CFAdY4CfGeFGufttR+SOqJz18SgD7nauuUoMYUr9goLIMbjjrb56G46plvsmuEstaoiypur5Ir0/96pvGDLZYrTKwM02ByIt9KnfcX9jG4cS6Q9P7fQ0LZuai9ir8HeXd2i5G31s31BTVAOHjxlFOmT1Y9Pv5x2+9LiLJ12RzPfRzjGNe3y94EQ==
Received: from AS4P192CA0026.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::10)
 by AS8PR07MB7701.eurprd07.prod.outlook.com (2603:10a6:20b:256::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 14:35:02 +0000
Received: from AM4PEPF00027A5F.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::a2) by AS4P192CA0026.outlook.office365.com
 (2603:10a6:20b:5e1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 14:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM4PEPF00027A5F.mail.protection.outlook.com (10.167.16.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Wed, 28 Jan 2026 14:35:02 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id AAF0423672;
	Wed, 28 Jan 2026 16:35:00 +0200 (EET)
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
Subject: [PATCH v12 net-next 12/15] tcp: accecn: detect loss ACK w/ AccECN option and add TCP_ACCECN_OPTION_PERSIST
Date: Wed, 28 Jan 2026 15:34:32 +0100
Message-Id: <20260128143435.15708-13-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128143435.15708-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260128143435.15708-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5F:EE_|AS8PR07MB7701:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: efd87998-11e7-4337-70d1-08de5e7a6be2
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?l/iDjnANF5BEA6hWho5+hboUWVdY0ygR/d3ZhQvQrBdFNHch58IU1Clz5f9a?=
 =?us-ascii?Q?YV+DKgoLD0fxM/7WtAS4gcHKI3GrYUIdMIyrVuQAxGOrp86e48VQD8Z25az2?=
 =?us-ascii?Q?sm/fk4iKVC6qaY29kasUCvnWA0a8+K/dvMa0AMvIaFLlsBjKJMcLNSNu3mHA?=
 =?us-ascii?Q?QxJOUq/c6NwxNLfshNRAYbuxFUaWzc1YLpv3Vxa+FKMC406CWNlUF0Ld2y4j?=
 =?us-ascii?Q?fY1KZj2xLSWlR6CBTziNi3abyHf6AS7a4QXpI0DURwZp8hMVa9d+yeGkZQFr?=
 =?us-ascii?Q?WaUckoGz13FBAhpKt8l93bBlml7E1Zx/vrhutSKBS0FdGYEeONJ2GGaouVMH?=
 =?us-ascii?Q?hN5CF2/gaXVoMFLG/jqBMfC1o7WwdsxhkLHbxFzSrbIIIaeeWLwb/sJbz8k+?=
 =?us-ascii?Q?AkCGvIQGx7/qlJhgR13WcW//Kh+h6eEnhvllMNyTdHw/5bHXTcsgkQralxuq?=
 =?us-ascii?Q?WvQiQeolYeTGKWpcsrlU8cQYPe8mPXIl4PnU9tj0wWRK71aojq3J58PRwW5+?=
 =?us-ascii?Q?mf0/FKjfSwmg91bfZCfBzr03n3jURSUwL4OxxN2nSOkxq92eeAHl9z/4D/gN?=
 =?us-ascii?Q?hUcAQdLfnpno0/j2ePN9kyRILN2jDAwN+k5+DGrMHUtmsMFzSR+9eF5eLmFt?=
 =?us-ascii?Q?57wMf7KoBbVCKIs40ku7Bjy+Pfwwug79HO7fxoBpyYksx5wzL1lpyQzSBXJA?=
 =?us-ascii?Q?A9oC9+9K8sANaZCdXSZqOvamtrSuRNlpJuylocWmOalm3km45DyTAY4EF+Lg?=
 =?us-ascii?Q?mtPK4LPWcHd9/J8nkDbKDQ/eMjE9khuCOfVTI5TjC64bSsxC+YI/U/NDTY8d?=
 =?us-ascii?Q?hhfb6N8i4eIc+z7hrLXYuU/5CoKqU026PZuiOIz+Igjo4emqgU6DTxb53UB4?=
 =?us-ascii?Q?ejWnOS+nBb0R2bqSx63zaLxQqNGbuoBdPso7c2calu5O9xcK5rXpFNZIt+qA?=
 =?us-ascii?Q?qNOc4IHYteUZFpn0bc7YCditS3eEs8F8fSn8CI3N5c6tz7iyvlEufzVtplX3?=
 =?us-ascii?Q?S/xfvWrk1GfZWKw7PDV2Ye2VU8mB2nubwuMOn/W/LHz23rLcU2yFUCvPkqpr?=
 =?us-ascii?Q?Rhxfoc6PNVk0Qph/KWqyTAcwk9uSgwLcceZK3aY6dXH1rn9SP31fVUxBHTHg?=
 =?us-ascii?Q?orzYmfv43uiYYHfBdGdkJ9ujNq775k4RoQhYXwF59VtsVd43NlEL5KNE5ajT?=
 =?us-ascii?Q?+E4kMUQjedHkf2Wdg9KnHUrFrjwS4J/Vf5GA5aqtVBOL+Wpq8y40uL3/3lcL?=
 =?us-ascii?Q?ALtzQQb0zs7yr5hqhZZk7s8HgKngGUVLlsv8dQN/msHL4jLXJPSW4gb5szJb?=
 =?us-ascii?Q?XenNTBX6+FzGp7B5Z7aj4CCScpoxKhDZuevjWDjNL/rtLINZhCoCrUvHsJC3?=
 =?us-ascii?Q?YOl3Mj/KyuvGWHxVjXdqfWOVu5kT6fF/67ggrbpWGPKe0EH41PagQRNZzL0E?=
 =?us-ascii?Q?uwj3+PPjU7XhvTNwveMLuVX3j+dExur32qd07pO98Hgg4c1XSJhhF3DrzyeU?=
 =?us-ascii?Q?PoHfcdPRiLYvFyiEfUfNsxkapW4ISiwAe+kNLErcDSaxWE8K+CRQOJ+w1mpW?=
 =?us-ascii?Q?7TYFz8OnAQhKgZzGAlkUJSlnXJ59zgCQA2DvPrJS9bqudSvf09l/tOKEhX5I?=
 =?us-ascii?Q?ARQsr2U5z+ivNt9uIEMXHnvzwxymjA8iOZyn5vfRbzgBQpu+Dgb3aYpqDEet?=
 =?us-ascii?Q?mhvHTL9ht4hJHWXXEMn0rtsI/3A=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 i7Jz+HiCXYWOrvESGViW8HBmcQfn2V/Pyp0uM0lQjWRvP8Mt6rIrC/vgex2E0hmO+CjIujX/JB6sNoCuh+JPuZuyelDKTxd6Qn1cFHY/VVtefrmm0RFPjJfG0+5t13GIkVrBlfb8ZZi7vHxpLqdp5uBdaRjqxe6D9pz1aG+G/mJhP54BY6zvEHkytZjQwa/zgCPdvnV69eOXWHFdgTMrrD2sdOBEhT/eYsv/17rYhTED7aZwRof3ZnI9ps/UhVrqDo7oUV3OuiSSKIUcRX6xSF3/DuLwJaHMNmW2stL15iCARAc8ub7oC6jO5yIJk0nKvdWr6qCaBGgNTXqLkDjbx68NWC3CX7ebHZ5k5sjjrVlecUuypOftPwGPBBKE0J8ivsgB3WZLlBsHbLaZ0EfHqTW/Dck7OoUrH/AeN/PwII06J6Y8tnIfuaOY5h/oYyim
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:35:02.1530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efd87998-11e7-4337-70d1-08de5e7a6be2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00027A5F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7701
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
	TAGGED_FROM(0.00)[bounces-254297-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A35C6A2FBB
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Detect spurious retransmission of a previously sent ACK carrying the
AccECN option after the second retransmission. Since this might be caused
by the middlebox dropping ACK with options it does not recognize, disable
the sending of the AccECN option in all subsequent ACKs. This patch
follows Section 3.2.3.2.2 of AccECN spec (RFC9768), and a new field
(accecn_opt_sent_w_dsack) is added to indicate that an AccECN option was
sent with duplicate SACK info.

Also, a new AccECN option sending mode is added to tcp_ecn_option sysctl:
(TCP_ECN_OPTION_PERSIST), which ignores the AccECN fallback policy and
persistently sends AccECN option once it fits into TCP option space.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v11:
- Modify accecn_opt_sent_w_dsack to indicate valid prior D-SACK info

v5:
- Add empty line between variable declarations and code
---
 Documentation/networking/ip-sysctl.rst |  4 +++-
 include/linux/tcp.h                    |  3 ++-
 include/net/tcp_ecn.h                  |  2 ++
 net/ipv4/sysctl_net_ipv4.c             |  2 +-
 net/ipv4/tcp_input.c                   | 13 ++++++++++++-
 net/ipv4/tcp_output.c                  |  7 ++++++-
 6 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index bc9a01606daf..28c7e4f5ecf9 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -482,7 +482,9 @@ tcp_ecn_option - INTEGER
 	1 Send AccECN option sparingly according to the minimum option
 	  rules outlined in draft-ietf-tcpm-accurate-ecn.
 	2 Send AccECN option on every packet whenever it fits into TCP
-	  option space.
+	  option space except when AccECN fallback is triggered.
+	3 Send AccECN option on every packet whenever it fits into TCP
+	  option space even when AccECN fallback is triggered.
 	= ============================================================
 
 	Default: 2
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index fbc514d582e7..f72eef31fa23 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -291,7 +291,8 @@ struct tcp_sock {
 	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
 		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
 	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
-		unused2:4;
+		accecn_opt_sent_w_dsack:1,/* Sent ACCECN opt in previous ACK w/ D-SACK */
+		unused2:3;
 	u8	accecn_minlen:2,/* Minimum length of AccECN option sent */
 		est_ecnfield:2,/* ECN field for AccECN delivered estimates */
 		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 49e0b865fe02..e01653bbf181 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -29,6 +29,7 @@ enum tcp_accecn_option {
 	TCP_ACCECN_OPTION_DISABLED = 0,
 	TCP_ACCECN_OPTION_MINIMUM = 1,
 	TCP_ACCECN_OPTION_FULL = 2,
+	TCP_ACCECN_OPTION_PERSIST = 3,
 };
 
 /* Apply either ECT(0) or ECT(1) based on TCP_CONG_ECT_1_NEGOTIATION flag */
@@ -406,6 +407,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 	tp->received_ce_pending = 0;
 	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 	__tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
+	tp->accecn_opt_sent_w_dsack = 0;
 	tp->accecn_minlen = 0;
 	tp->accecn_opt_demand = 0;
 	tp->est_ecnfield = 0;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index a1a50a5c80dc..385b5b986d23 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -749,7 +749,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.extra2		= SYSCTL_THREE,
 	},
 	{
 		.procname	= "tcp_ecn_option_beacon",
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index a4d086ccb18a..9dda1497c149 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4971,8 +4971,11 @@ static void tcp_dsack_extend(struct sock *sk, u32 seq, u32 end_seq)
 		tcp_sack_extend(tp->duplicate_sack, seq, end_seq);
 }
 
-static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
+static void tcp_rcv_spurious_retrans(struct sock *sk,
+				     const struct sk_buff *skb)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
+
 	/* When the ACK path fails or drops most ACKs, the sender would
 	 * timeout and spuriously retransmit the same segment repeatedly.
 	 * If it seems our ACKs are not reaching the other side,
@@ -4992,6 +4995,14 @@ static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
 	/* Save last flowlabel after a spurious retrans. */
 	tcp_save_lrcv_flowlabel(sk, skb);
 #endif
+	/* Check DSACK info to detect that the previous ACK carrying the
+	 * AccECN option was lost after the second retransmision, and then
+	 * stop sending AccECN option in all subsequent ACKs.
+	 */
+	if (tcp_ecn_mode_accecn(tp) &&
+	    tp->accecn_opt_sent_w_dsack &&
+	    TCP_SKB_CB(skb)->seq == tp->duplicate_sack[0].start_seq)
+		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_SEND);
 }
 
 static void tcp_send_dupack(struct sock *sk, const struct sk_buff *skb)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index ed545cb033b6..5899e5bdef35 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -713,9 +713,12 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 		if (tp) {
 			tp->accecn_minlen = 0;
 			tp->accecn_opt_tstamp = tp->tcp_mstamp;
+			tp->accecn_opt_sent_w_dsack = tp->rx_opt.dsack;
 			if (tp->accecn_opt_demand)
 				tp->accecn_opt_demand--;
 		}
+	} else if (tp) {
+		tp->accecn_opt_sent_w_dsack = 0;
 	}
 
 	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
@@ -1187,7 +1190,9 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	if (tcp_ecn_mode_accecn(tp)) {
 		int ecn_opt = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option);
 
-		if (ecn_opt && tp->saw_accecn_opt && !tcp_accecn_opt_fail_send(tp) &&
+		if (ecn_opt && tp->saw_accecn_opt &&
+		    (ecn_opt >= TCP_ACCECN_OPTION_PERSIST ||
+		     !tcp_accecn_opt_fail_send(tp)) &&
 		    (ecn_opt >= TCP_ACCECN_OPTION_FULL || tp->accecn_opt_demand ||
 		     tcp_accecn_option_beacon_check(sk))) {
 			opts->use_synack_ecn_bytes = 0;
-- 
2.34.1


