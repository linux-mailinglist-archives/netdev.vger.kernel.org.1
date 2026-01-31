Return-Path: <netdev+bounces-255520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCUmDuyBfmlQaAIAu9opvQ
	(envelope-from <netdev+bounces-255520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:27:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB29FC42F7
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03673305FFD7
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 22:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF5438B7A3;
	Sat, 31 Jan 2026 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="lhjU7Ue8"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011029.outbound.protection.outlook.com [52.101.65.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5689C38A9C1;
	Sat, 31 Jan 2026 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769898348; cv=fail; b=VFAVbNQvkVfLQg413FTF7/H2X1Y125Hf3x1fZIjRPPCoTb20gHD5yH2GwBzCjcXbdQKrhe+rlB6K0lm8aYRPxO6YWFnTIRRpT9ASevENSq0sKwFYofCpZuTnA27TI1p9KarULaJKmZjxzvRA0ueIMy1Qc5sfD3y/pZWbuWBXfqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769898348; c=relaxed/simple;
	bh=UZKusTYGKBNsR+p1cWCQuxj0agzXS47OlVX+Rl3Uh6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzEEgUV3FfIgiDOXTx59uITlnOLztcAQXGbqLbjJP3277iDhOP/KF2p0+gZRtTnrLQfvq0KtTkifjC0WjhYYwV00FIBwX3CTAX2MHIk+m6h5BAOC5hTjpJ1s38Q2KPf7k0FXG3IkUvoNfmHwHpKyVW2r61FJILW0mSd41wiCLZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=lhjU7Ue8; arc=fail smtp.client-ip=52.101.65.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7Wm87oJFmJsCMjvwB+mcF+kkezexwdT8tslUDCmiY4r8CBWBfVfaLT9iFw03no34EhOl+VPyb2R3ykLahyIXiLwKCoMHSnq0ObjJxyqNJINT7afbf4/u6Spqs1KO7IVNrPit/dJPVA/RcGeHPnyO4LwiW04D0+ZHp8BS/kSPwqpynSSwkgMzFZpMu4yKHfImbWYxo3inaR6jm730VctbvZHiAQyg+XEb4qvACTCQfaf+cxECbbfF2aTzbgIYzK1nqngLBaHfmMO/3oPgNBEbQomzMZUcXDZcIIPvTYo4pSPkkl4lTNdpw554UXgVBWxoRZ+VK1aT6IpFZjJDFfPew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86eKZY8UsqJAg8PU+paZvLEf6RQnbBtPGl/dPqew/lM=;
 b=duDHkByIvDUDO62FftwTFaC6/Nggpx+QCQO8G+zqxoD225C/RjgVGywlLOQDCCINEPQ8fDLMEdxmPnd1fkwzpi8eEOkU9j6EFzZyCd537MquSQM3MJI15+DLpFvgE8jE6uSFLYLjUNhi3y1tJdsFycYEyFcQ7cSVlfDhq5Qh4J3+hEs7mpgVxc3J+EM9HdUL50FmmZickDzR6TLjXJEx38yjdkpJTtsJWRiUfLzteBeDC3kj5bcV/zL61gPn9HX6bSimqKM3bzB60iG3ri7D/31GuBB3cuYIZhjX1960vA4DQFvDFJhGsMyufLFbwQpaIB2aEUQqcUpgYrNhcjBZvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86eKZY8UsqJAg8PU+paZvLEf6RQnbBtPGl/dPqew/lM=;
 b=lhjU7Ue8rcMD8ojCNnqw78p1D1A3VQ1LNd8wXbzJy+VWyG+OkfzS6D91JZ/xV+IA2lL0FH4eiBu+meNoE98Knvk5a4mWlYwyuSMSYtqmPbIZ1RojD3xdA1I5E3jDnpCnNG9eaSwBcYxQJ6oSfKDyORahlrSu0y/gP0TnWtblJAn1AjVrBf5KPQNWVE1sD6gHdvK3h0tb0OgZIgYgtfNM3NPUluUf/x51B02TfeZBQRho6U76EzAeNJv97AdJj6si+V5r1bAh2GJgeDPdCnwOq+sczbgR8MgR6hxFD6swX5nDVN5i42qRlAtRb7MGpt02lw44e3R960JbB93gbGmrwg==
Received: from AS4P190CA0027.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::16)
 by AS2PR07MB8955.eurprd07.prod.outlook.com (2603:10a6:20b:552::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Sat, 31 Jan
 2026 22:25:43 +0000
Received: from AMS0EPF00000193.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::68) by AS4P190CA0027.outlook.office365.com
 (2603:10a6:20b:5d0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Sat,
 31 Jan 2026 22:25:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF00000193.mail.protection.outlook.com (10.167.16.212) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Sat, 31 Jan 2026 22:25:43 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 979E2238FF;
	Sun,  1 Feb 2026 00:25:41 +0200 (EET)
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
Subject: [PATCH v13 net-next 06/15] tcp: accecn: handle unexpected AccECN negotiation feedback
Date: Sat, 31 Jan 2026 23:25:06 +0100
Message-Id: <20260131222515.8485-7-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000193:EE_|AS2PR07MB8955:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7e5ba5be-64a1-4835-dc59-08de6117ac0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1ISIqV5rXc7l8u+8u9C3iN68efCtP43nguyXRVW3HytLbmigblxPl/OfVmjM?=
 =?us-ascii?Q?+1hA8bvY1A8SFs0KDRP17wbVV6nAVfbmYgTLEbin8aoqJgweoNxStCdpBC13?=
 =?us-ascii?Q?klZvOrewsY4JQLg7IbUyVysVVu63+8HKZU5pwSpHjwvbprHYfZx+v1KLBSSD?=
 =?us-ascii?Q?QOXqLJLLoOrdMoPomRVEh8UpQF26W44Xi4/idpB+389kfOxfIPJbCGbjQnU9?=
 =?us-ascii?Q?A4CUk9QFeQrJl/iuKSITLC6LXuVlln+uLVhjX3HVM1AC40bUIZ6w/HVp7kbx?=
 =?us-ascii?Q?7ivG3sBuiUWFYTYj7YJ0TbBGufnK5CJJADVShtqF3F4q7fw68Rr3D/nEcoMw?=
 =?us-ascii?Q?pPrLwJTSBRbng+YLGFlX950DEkkTi6YIBBQWqgOJl09i27Msfdpsd8O8roEt?=
 =?us-ascii?Q?RdrqLDMVoF18rCchMHbPsf5pJoOZwnV2KEWxC+ALDhdx+a6dD1tw7RmPmxsF?=
 =?us-ascii?Q?wuprv0bqLlNeXZ3tGpsK62ws9nOcP/LGVhDtQnwmSLgilU0vNSZTgPgT2OAC?=
 =?us-ascii?Q?lhv8/OQEvxrhpcQxSrPBw8yEcvPNhJYyEa9BDTELGOGz9onlE5uD9OLpf2Zp?=
 =?us-ascii?Q?bJ8DPtS1dzX91Vjd40zD1jxjXbzxkFSe/BuEngdnd6ZoGqKj/8BgThIqbVjD?=
 =?us-ascii?Q?J7vewMC3EMZeh7nKf1N8Pl79PneGKbGqqYdUREHWMQXo6YxiUHn6LhP6p+XM?=
 =?us-ascii?Q?c0FsCaqfEdXMag710RLm4mScHJsOfmouHdQAwikjyUuLgZyudOa/VzcMpV9h?=
 =?us-ascii?Q?Q8o9AkByDWWp+8Q41q+ig8/pV7tTC0nBjVqIAB9ThGSmHoIpK+Vw2gi/58Fe?=
 =?us-ascii?Q?8wgR0EbdHGFGisSCNJIkschY231Yqv6H3qYXfIMx7s2lFkvASWaBVx6HeEho?=
 =?us-ascii?Q?x6mEgWyDgPpHMxb8LMUvBgr7XovjSki9ToN/oIGzPbK5bJgCMoPFEVrr2vjN?=
 =?us-ascii?Q?4ACH7MD8Sh27F2VKu+ZMHukgQgjQSbmVjRrvRTEVC/ornpS5Yh5WbqGJABOF?=
 =?us-ascii?Q?VgAGWp0oQe1mU/d+x4Hr3ZXrg2q6gVY+2Pm1f5g+iOaXFSBSBFRchSCtyY23?=
 =?us-ascii?Q?JOm9WCodybIHRl+yormgd7XZYL1vijw9HLOrxpuf2lJAa9+Ll87lPnjTQKLQ?=
 =?us-ascii?Q?MPajsPaPG9ygFzgD7+fQVdDvu4GIiu+8tNPSi7G2elux1GMMgEMd+guSwuEk?=
 =?us-ascii?Q?SlVb6QAy8bbtTF/uDHW7X8eF6UB1lkYGIqwTYgtXpY99GDUsb496cV94prNA?=
 =?us-ascii?Q?4Yk2KuClvbtaxNIQvz6vGAnp+5+W77rcTtgxyTWq1UBiPOerHEp/KQf5SV5h?=
 =?us-ascii?Q?Y43Vw4yOfq27nG764PwoXKTPoLTxct091kUZSyiJABk2Uz94KIPgWpUpHNl0?=
 =?us-ascii?Q?MnLRDJX3UK0i98S20x0HnXcTyWmr1LuAfcq89BLGFvDYtgzywwTb7vCTvSCc?=
 =?us-ascii?Q?0YXs9yLyx9BhNvRmj15Jw5vFjRCnkbDcv9DQs2w/35ESosBIqXOLg5+Be0PA?=
 =?us-ascii?Q?WtfzDWHKL1EKBZMwFyjE9EeocREhGNXdiSzNpSG0V9GPHCZbhNNdFLn6ZGuc?=
 =?us-ascii?Q?u9eledMSzmNLgegM5oW0zbxlBtQaODx2iSeUObVzzHdTwaR536si+JeP13d5?=
 =?us-ascii?Q?Gwg/h1KDodcjpJ6tLrQPuFuorkVrn+lZydFMeC5xi1BHLZ9TjIyaW4VNU1Mh?=
 =?us-ascii?Q?6ngEsIKr/qkeqUHqNjzeO+A48sQ=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cdXcrAEdCSLJ/VCYjzLlHpNk7+PefhCNcQO1m6k8/3l7OM/WQM7ntsCPP6699wXHA49F4jPkAjdz+oyhZF8H8oyKdtoB5Y6RdbbQEU/djF3ipU9XyxJiVdH0HcCPP5Gfo9M8zMYJb1hc35v/MnUX05UT/5bVMebGiPumJ9yzFHksrGHjuaY2nzCndV9/i5x6QogR6nhGwmvEOWHWHDVZXhMeN8HcRpTiaZRayGf7pRg27V8CwKF98h/ocgY5ALfhAwQ9eoz+8Y+oXEfgbdQrsFlJpHQC9lhPIhrM0zhcfIXJ9zliyO3f6IkSeLVakUCa4kA1hIREDRHeKeFpr5RKf5GJWOGFoHNK1LeGRYkao9VwRIg5cgAUP8J1awZqB2xYDv5pTTFSRftyy1NQm4mdf1eRjlsegwt1T+ruYFkiatOXDXqd/Z4vsQdSOCgblio6
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 22:25:43.1308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5ba5be-64a1-4835-dc59-08de6117ac0e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB8955
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
	TAGGED_FROM(0.00)[bounces-255520-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: CB29FC42F7
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

According to Sections 3.1.2 and 3.1.3 of AccECN spec (RFC9768).

In Section 3.1.2, it says an AccECN implementation has no need to
recognize or support the Server response labelled 'Nonce' or ECN-nonce
feedback more generally, as RFC 3540 has been reclassified as Historic.
AccECN is compatible with alternative ECN feedback integrity approaches
to the nonce. The SYN/ACK labelled 'Nonce' with (AE,CWR,ECE) = (1,0,1)
is reserved for future use. A TCP Client (A) that receives such a SYN/ACK
follows the procedure for forward compatibility given in Section 3.1.3.

Then in Section 3.1.3, it says if a TCP Client has sent a SYN requesting
AccECN feedback with (AE,CWR,ECE) = (1,1,1) then receives a SYN/ACK with
the currently reserved combination (AE,CWR,ECE) = (1,0,1) but it does not
have logic specific to such a combination, the Client MUST enable AccECN
mode as if the SYN/ACK onfirmed that the Server supported AccECN and as
if it fed back that the IP-ECN field on the SYN had arrived unchanged.

Fixes: 3cae34274c79 ("tcp: accecn: AccECN negotiation").
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v10:
- Update commie message with full texts from RFC.

v5:
- Add "Fixes" tag.

v3:
- Update commit message to fix old AccECN commits.
---
 include/net/tcp_ecn.h | 44 ++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 2e1637edf1d3..a709fb1756eb 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -473,6 +473,26 @@ static inline u8 tcp_accecn_option_init(const struct sk_buff *skb,
 	return TCP_ACCECN_OPT_COUNTER_SEEN;
 }
 
+static inline void tcp_ecn_rcv_synack_accecn(struct sock *sk,
+					     const struct sk_buff *skb, u8 dsf)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
+	tp->syn_ect_rcv = dsf & INET_ECN_MASK;
+	/* Demand Accurate ECN option in response to the SYN on the SYN/ACK
+	 * and the TCP server will try to send one more packet with an AccECN
+	 * Option at a later point during the connection.
+	 */
+	if (tp->rx_opt.accecn &&
+	    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+		u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
+
+		tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
+		tp->accecn_opt_demand = 2;
+	}
+}
+
 /* See Table 2 of the AccECN draft */
 static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb,
 				      const struct tcphdr *th, u8 ip_dsfield)
@@ -495,13 +515,11 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 		break;
 	case 0x1:
-	case 0x5:
 		/* +========+========+============+=============+
 		 * | A      | B      |  SYN/ACK   |  Feedback   |
 		 * |        |        |    B->A    |  Mode of A  |
 		 * |        |        | AE CWR ECE |             |
 		 * +========+========+============+=============+
-		 * | AccECN | Nonce  | 1   0   1  | (Reserved)  |
 		 * | AccECN | ECN    | 0   0   1  | Classic ECN |
 		 * | Nonce  | AccECN | 0   0   1  | Classic ECN |
 		 * | ECN    | AccECN | 0   0   1  | Classic ECN |
@@ -509,20 +527,20 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 		 */
 		if (tcp_ca_no_fallback_rfc3168(sk))
 			tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
-		else if (tcp_ecn_mode_pending(tp))
-			/* Downgrade from AccECN, or requested initially */
+		else
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 		break;
-	default:
-		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
-		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
-		if (tp->rx_opt.accecn &&
-		    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
-			u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
-
-			tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
-			tp->accecn_opt_demand = 2;
+	case 0x5:
+		if (tcp_ecn_mode_pending(tp)) {
+			tcp_ecn_rcv_synack_accecn(sk, skb, ip_dsfield);
+			if (INET_ECN_is_ce(ip_dsfield)) {
+				tp->received_ce++;
+				tp->received_ce_pending++;
+			}
 		}
+		break;
+	default:
+		tcp_ecn_rcv_synack_accecn(sk, skb, ip_dsfield);
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
-- 
2.34.1


