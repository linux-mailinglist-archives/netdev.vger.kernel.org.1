Return-Path: <netdev+bounces-251921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMDbAmzrcGk+awAAu9opvQ
	(envelope-from <netdev+bounces-251921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:06:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D4E58EBC
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBB89A6DC45
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47355296BD4;
	Wed, 21 Jan 2026 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="qahE6F5z"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02ED4963D9;
	Wed, 21 Jan 2026 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005957; cv=fail; b=ue0KVHK2edIFlFCL4B7npF6t/ulDaWX5/zBqAGJMwNOv2RdMmid7grzvJ4DK5nnRhws6GKne90Xvi5aJJi7F9R4AzMwiiFHH3/StZrhAu15Tc1jRS0FWFKn071PeqFnhooj05twjI3qc2czkVS5LiqnecpxABwSen54G72Zgtwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005957; c=relaxed/simple;
	bh=eWdPQbJ3RccYAsV6Bdn/8jyQGiK/bE7gpdijbfbGJ7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9RCQngIS7p1YMrSMgrQjeaDH30rmvlNi5QjifAd5c9riIDSwZTO0pk63Gh4V+oPh7Ksqj08cOHoAfQf3kZj4z6eZvkRG5H8yJp3u75Z8wCrnPB/FwPy5sv+z+YyNyRjxzRXjTS2Ry6tbhu/jUw4uMYqK5VuKp3EiuHCYTmSM0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=qahE6F5z; arc=fail smtp.client-ip=52.101.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0LQqYl4rgMZKXuYuLTLZexEMfFwQb3/Dumcfo1MGCOkV5xpK076DS1nolEC9VXp+wpy35E5gKEvpvw0IlHjqxyZ0YqJDrOxxOp2sj4vZ2bYikWAUlr5hB/3E8LUBkN2RxBYJS56lH7nethlAdNECVFI1V352sHXvOtqabA8ox1PJoY4zFwqBMTP2FFfctJjh3cYsuRKRLD1Yq42cAOakqZohZNypI8mPc9xpZHRLedsQf7gwXjHbWMBrX96Y0NWf2ksRCZZlVauxpe8liIdW4TlGG6t1kwhRZ89sITALsUytAdAwDD1ii8XQztMPi/JDADpBc9EpqQRyPrRRRvRbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVQu3PoQzkZh7snZme8YzD3Okpk8J3/N9M1Xhw13Twg=;
 b=ESwSQD5OB3NgJ/AwlasS1eMPzcnFNPcVf4BNn9valn9Qj8GZMpkyGVifRKokwM3xGoEGQxDVgja/oCC/JoGgRz0Oa0EYakKAcFUcl696e1aLsGYY/5KOH18kiPOzdbDDM7f9usW2I7nilK3NaYNewC6W3DpacjGVW31edz6EZrdrPXrqhxPugdxzSSoFz1aiY8NrjDaAMdn6bFoQmnWytK+QmVHH8kVa+TbfIiMAAuEnVHfG24bL6oMbBK3vyGK84RmQDGp10BFLg3yWbGxZXhr1CteHlRWjw9LT0ZGXNoaE/UuaPfFViq4k+K7FProYligsAG3DckMGCa5Hqgn3hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVQu3PoQzkZh7snZme8YzD3Okpk8J3/N9M1Xhw13Twg=;
 b=qahE6F5zk4rtuUnV23EF/JgkCxCLLIegHcXQvmI0qNPhdp6MpIHgysln3tR+IScujqxJ9Ma/TKKnIQo+co2lZAngl7myVrcDdQCFJ7XdNThxQRtJ2njQR56zt5zd3Xf1mVYQ/CkbuyadvAtWUrFkfDCuG6MXmpQegC4zs2KjFFfnsC+q9EbqtaDQKLJcFQmBeOedmP95VJOBedh2/F9gq2hNOSZ91OWiYJ0d94bHlHyYmKFuKHbIlZJdeO7nmO/W2sb7zz5D1c4NB9NrGTkuDOT+4KRmd6z1q4kAh5eHnIWgO0Mi5PCDQyC4GsUhCzVpqbeoyZ0zTZLnxTsbD0RAiQ==
Received: from AM9P192CA0006.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::11)
 by PR3PR07MB8241.eurprd07.prod.outlook.com (2603:10a6:102:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 14:32:28 +0000
Received: from AM4PEPF00027A66.eurprd04.prod.outlook.com
 (2603:10a6:20b:21d:cafe::b0) by AM9P192CA0006.outlook.office365.com
 (2603:10a6:20b:21d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Wed,
 21 Jan 2026 14:32:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM4PEPF00027A66.mail.protection.outlook.com (10.167.16.91) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Wed, 21 Jan 2026 14:32:28 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 657E22029A;
	Wed, 21 Jan 2026 16:32:26 +0200 (EET)
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
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Olivier Tilmans <olivier.tilmans@nokia.com>
Subject: [PATCH v10 net-next 04/15] tcp: ECT_1_NEGOTIATION and NEEDS_ACCECN identifiers
Date: Wed, 21 Jan 2026 15:32:04 +0100
Message-Id: <20260121143215.14717-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121143215.14717-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260121143215.14717-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A66:EE_|PR3PR07MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd9ae20-0dbc-46c4-0bd9-08de58f9e75d
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dGxiQ0E5Mm83MUY0UFZ3eVZNVmU5NVlDd3JCRTVDZGRTWFo3VGk4SzkyS3dH?=
 =?utf-8?B?amVIcVZ2cE9XSG0rNlZUVWI3NTNhYW16NUNDSGE3SEZFcGFTS1J0cVpXK1hB?=
 =?utf-8?B?SlNkdTdib2ZWREhaTVZsYmlYL2pxUUNrTUdtUE82TUw0UFlmc2ZWNUExNHNu?=
 =?utf-8?B?Rk1RWmdTMnFoSEpXKzU4czFxWmQ0UDhUWGdnZXFpbTVsa2p5T0pvOUwwbDRC?=
 =?utf-8?B?Y2RmSExMUDVVbVlnSXl3eU95NzZhQk00ejExRmpjcjBsZm5MRittbmV4aEVo?=
 =?utf-8?B?WEswVHNLOTFEenZVUzB5a1BRY3FFSUhESlBnN0xLNXpESDA3eW11cFN4WElH?=
 =?utf-8?B?anFzSExYY3JvRXJqazkvbFoybVZqOUF3QWdKRVdlYkltVkRRRFdZaVp4bi94?=
 =?utf-8?B?bldlaUZZSzJ1S2ZjMis0OVFTcTJWNnFMaTl3ZmdDTDQxMnd3WS9zUXJqYTNL?=
 =?utf-8?B?Q1o3UGdGKyt4M201OElndGh0c1F6dkVacUQ4MThBODYvL1lnRjJXbTRXeFZB?=
 =?utf-8?B?Z01pdk1uWThNNFpTTk15VWpLOEVaMXdTTHV6ODVKelhRaExlVmpXLzIvalI3?=
 =?utf-8?B?aEdIc1M0ZktLbmp0cUpMbldQNnJYWVBLaVAxVndVamF6dGM4VUxtbTJScjB6?=
 =?utf-8?B?QW1jcjBsaFZKV1A3YTg5ZzJOWHhEN3RPR2VRem45TW1iL2ZrdFRhNDdwOUJY?=
 =?utf-8?B?S3lXRzBBZisxZ095cHdpWjhWZldMOFQyeDZwLzh1ZWt4Sk9iWFRQWGxHRUVX?=
 =?utf-8?B?aEc4aHpSUVU0MU8xcTZrQ21NWnRncmpSWENqcE1sMkpQakF4ZHBqTVd4NzIr?=
 =?utf-8?B?bHVQeXBXazZMOTBvTyt1alEwNjRiZEY1Wm9meHh1QWw5OTBwK0dRMDB1UXE3?=
 =?utf-8?B?N2N2M2RLRHM2dHozY0gwcWNMSytXVWNDU212NVBmY0luQ2owdkNOdWtOb3JL?=
 =?utf-8?B?MWZxa2xURjFZKzhzOHhvVFZPbW44V1RLbTJ5cmt5ZmVnd3F3dEd5UGZqSkZS?=
 =?utf-8?B?Q01URy9YbjMxajdLcWQ2SU9QKzViYUViSU1XVEFCVThPZTc3Vy9wczlkWkIx?=
 =?utf-8?B?dGFLUndnUHp0VHVKWWY5eW51TXNXNXVQci9McEg3YTRHdDlyRk81VFZQVzFL?=
 =?utf-8?B?THE5bzltYXlYVUp6ZDIvV0h0Ri9BcnJQLzUxeUhJNFA2S0EyYU8ycjRwNXEz?=
 =?utf-8?B?TGlrRENlZlVXSUVqTmdWUlhKdEtqaDd4cmZNM0gxdVNZdW13QnV6Qyt2OGxk?=
 =?utf-8?B?V04wWGlHUGwzS0FJMWRoL3ZZUUZTUUZlRmdmaUNDQ3dMV0swT1ZKWWVKeEEw?=
 =?utf-8?B?TWwrdWtqM2sxckRIQVp6MGt4eDZHWEFpUCtaYXpOdjNGNmYwRzRkendpQ3VO?=
 =?utf-8?B?UVQ1dHQxbVp2WUJSb3BURU5wbS9wSkR2RFhLRFRUZStoeHRGSm1sZmIwVTl6?=
 =?utf-8?B?NllHc1Y2NXA2UHJETVppbTNwQ1BEbThzdU1MTFhqU1ZrSVRKcWwyRVRLRlEy?=
 =?utf-8?B?QWhlVUZKQ1E1Q2Z2d3ltckRYSVNsVWRWd29lV1pzU2hHY3JWVDV0RXU1WUtZ?=
 =?utf-8?B?VFZWZlArajRpbmpyM2dTcklqRTdaRnU0b2lEQTBrMHNLNEVQTlEyemsrU3Jp?=
 =?utf-8?B?dUx5aEs0LzFxM29pOExRa0NDcDJwSlowVDFNUDFpSFVEK0gyWUFWV09ZcnRy?=
 =?utf-8?B?UG9GdHN1SUpacEhXd09TZlBGWTRsYlI4bjNqOFZ6b3FBenhEeWtoYm1lLytI?=
 =?utf-8?B?azJkRUpadVZvWDlJa3dWT21WYmtNNDBuWjlDMGpXWmZaZ29OQ0tRaTBqMDBO?=
 =?utf-8?B?WnRrWjZtenY2blV3aHFVaW45QXVrdzdOTEJTSDUrVnhBSCtlN0tNWEJaNHkv?=
 =?utf-8?B?MVNDMTVPd0J1aGk0ZWU0M1VCclFubWxmaFpLUXVjQ0NObDZoREl3QkliUFZE?=
 =?utf-8?B?c25udndxUk5uTGExbTEwOW9GbG16Z3ZtTkpBMXdLYzNnQnBIeVlWcmtwSmlQ?=
 =?utf-8?B?WlZubmRHYVhadVlTMUNxTllOK2lvSjlSa3htWW5FVEUwNDNNSHlWSlJ5cGxV?=
 =?utf-8?B?YWhLaVdiS1BMb0R6Ri9hdmR3aVdZQ2p6U2Zob0RtWU5RR1FiT0hFRytvZUpI?=
 =?utf-8?B?VFZsczZ3Tlo1RWVNMStmQUtwTzZkVGVHbkVjREtHR3NwcXdIbzZ0UHExMkZH?=
 =?utf-8?B?RVpRNmxiNGhhRUFuaDVraGZBOEM3K1UycUtkTjdGQWMyOUc3MXlhaEZqV2ox?=
 =?utf-8?Q?FQUCXYnvRurR5vbBYNl3kiMBRMc6LPO9IlQ3pMgwG8=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 14:32:28.4195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd9ae20-0dbc-46c4-0bd9-08de58f9e75d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00027A66.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8241
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251921-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,nokia.com:email];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[nokia-bell-labs.com,reject];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E8D4E58EBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Two flags for congestion control (CC) module are added in this patch
related to AccECN negotiation. First, a new flag (TCP_CONG_NEEDS_ACCECN)
defines that the CC expects to negotiate AccECN functionality using the
ECE, CWR and AE flags in the TCP header.

Second, during ECN negotiation, ECT(0) in the IP header is used. This
patch enables CC to control whether ECT(0) or ECT(1) should be used on
a per-segment basis. A new flag (TCP_CONG_ECT_1_NEGOTIATION) defines the
expected ECT value in the IP header by the CA when not-yet initialized
for the connection.

The detailed AccECN negotiaotn can be found in IETF RFC9768.

Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v10:
- Update commit message

v6:
- Rename TCP_CONG_WANTS_ECT_1 to TCP_CONG_ECT_1_NEGOTIATION to distinguish
  it from TCP_CONG_ECT_1_ESTABLISH.
- Move TCP_CONG_ECT_1_ESTABLISH to latter TCP Prague patch series.

v3:
- Change TCP_CONG_WANTS_ECT_1 into individual flag.
- Add helper function INET_ECN_xmit_wants_ect_1().
---
 include/net/inet_ecn.h | 20 +++++++++++++++++---
 include/net/tcp.h      | 21 ++++++++++++++++++++-
 include/net/tcp_ecn.h  | 13 ++++++++++---
 net/ipv4/tcp_cong.c    |  5 +++--
 net/ipv4/tcp_input.c   |  3 ++-
 5 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/include/net/inet_ecn.h b/include/net/inet_ecn.h
index ea32393464a2..827b87a95dab 100644
--- a/include/net/inet_ecn.h
+++ b/include/net/inet_ecn.h
@@ -51,11 +51,25 @@ static inline __u8 INET_ECN_encapsulate(__u8 outer, __u8 inner)
 	return outer;
 }
 
+/* Apply either ECT(0) or ECT(1) */
+static inline void __INET_ECN_xmit(struct sock *sk, bool use_ect_1)
+{
+	__u8 ect = use_ect_1 ? INET_ECN_ECT_1 : INET_ECN_ECT_0;
+
+	/* Mask the complete byte in case the connection alternates between
+	 * ECT(0) and ECT(1).
+	 */
+	inet_sk(sk)->tos &= ~INET_ECN_MASK;
+	inet_sk(sk)->tos |= ect;
+	if (inet6_sk(sk)) {
+		inet6_sk(sk)->tclass &= ~INET_ECN_MASK;
+		inet6_sk(sk)->tclass |= ect;
+	}
+}
+
 static inline void INET_ECN_xmit(struct sock *sk)
 {
-	inet_sk(sk)->tos |= INET_ECN_ECT_0;
-	if (inet6_sk(sk) != NULL)
-		inet6_sk(sk)->tclass |= INET_ECN_ECT_0;
+	__INET_ECN_xmit(sk, false);
 }
 
 static inline void INET_ECN_dontxmit(struct sock *sk)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 25143f156957..d643dcb0a93e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1203,7 +1203,12 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_NON_RESTRICTED		BIT(0)
 /* Requires ECN/ECT set on all packets */
 #define TCP_CONG_NEEDS_ECN		BIT(1)
-#define TCP_CONG_MASK	(TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN)
+/* Require successfully negotiated AccECN capability */
+#define TCP_CONG_NEEDS_ACCECN		BIT(2)
+/* Use ECT(1) instead of ECT(0) while the CA is uninitialized */
+#define TCP_CONG_ECT_1_NEGOTIATION	BIT(3)
+#define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
+			TCP_CONG_NEEDS_ACCECN | TCP_CONG_ECT_1_NEGOTIATION)
 
 union tcp_cc_info;
 
@@ -1344,6 +1349,20 @@ static inline bool tcp_ca_needs_ecn(const struct sock *sk)
 	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
 }
 
+static inline bool tcp_ca_needs_accecn(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ACCECN;
+}
+
+static inline bool tcp_ca_ect_1_negotiation(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_ECT_1_NEGOTIATION;
+}
+
 static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index f13e5cd2b1ac..fdde1c342b35 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -31,6 +31,12 @@ enum tcp_accecn_option {
 	TCP_ACCECN_OPTION_FULL = 2,
 };
 
+/* Apply either ECT(0) or ECT(1) based on TCP_CONG_ECT_1_NEGOTIATION flag */
+static inline void INET_ECN_xmit_ect_1_negotiation(struct sock *sk)
+{
+	__INET_ECN_xmit(sk, tcp_ca_ect_1_negotiation(sk));
+}
+
 static inline void tcp_ecn_queue_cwr(struct tcp_sock *tp)
 {
 	/* Do not set CWR if in AccECN mode! */
@@ -561,7 +567,7 @@ static inline void tcp_ecn_send_synack(struct sock *sk, struct sk_buff *skb)
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ECE;
 	else if (tcp_ca_needs_ecn(sk) ||
 		 tcp_bpf_ca_needs_ecn(sk))
-		INET_ECN_xmit(sk);
+		INET_ECN_xmit_ect_1_negotiation(sk);
 
 	if (tp->ecn_flags & TCP_ECN_MODE_ACCECN) {
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ACE;
@@ -579,7 +585,8 @@ static inline void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 	bool use_ecn, use_accecn;
 	u8 tcp_ecn = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn);
 
-	use_accecn = tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ACCECN;
+	use_accecn = tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ACCECN ||
+		     tcp_ca_needs_accecn(sk);
 	use_ecn = tcp_ecn == TCP_ECN_IN_ECN_OUT_ECN ||
 		  tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ECN ||
 		  tcp_ca_needs_ecn(sk) || bpf_needs_ecn || use_accecn;
@@ -595,7 +602,7 @@ static inline void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 
 	if (use_ecn) {
 		if (tcp_ca_needs_ecn(sk) || bpf_needs_ecn)
-			INET_ECN_xmit(sk);
+			INET_ECN_xmit_ect_1_negotiation(sk);
 
 		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
 		if (use_accecn) {
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index df758adbb445..e9f6c77e0631 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -16,6 +16,7 @@
 #include <linux/gfp.h>
 #include <linux/jhash.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <trace/events/tcp.h>
 
 static DEFINE_SPINLOCK(tcp_cong_list_lock);
@@ -227,7 +228,7 @@ void tcp_assign_congestion_control(struct sock *sk)
 
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 	if (ca->flags & TCP_CONG_NEEDS_ECN)
-		INET_ECN_xmit(sk);
+		INET_ECN_xmit_ect_1_negotiation(sk);
 	else
 		INET_ECN_dontxmit(sk);
 }
@@ -257,7 +258,7 @@ static void tcp_reinit_congestion_control(struct sock *sk,
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 
 	if (ca->flags & TCP_CONG_NEEDS_ECN)
-		INET_ECN_xmit(sk);
+		INET_ECN_xmit_ect_1_negotiation(sk);
 	else
 		INET_ECN_dontxmit(sk);
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7d573a3bea2a..922f10bc3d57 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7310,7 +7310,8 @@ static void tcp_ecn_create_request(struct request_sock *req,
 	u32 ecn_ok_dst;
 
 	if (tcp_accecn_syn_requested(th) &&
-	    READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3) {
+	    (READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3 ||
+	     tcp_ca_needs_accecn(listen_sk))) {
 		inet_rsk(req)->ecn_ok = 1;
 		tcp_rsk(req)->accecn_ok = 1;
 		tcp_rsk(req)->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
-- 
2.34.1


