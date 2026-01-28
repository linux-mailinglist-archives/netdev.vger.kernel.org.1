Return-Path: <netdev+bounces-254305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK07ANYhemmv2wEAu9opvQ
	(envelope-from <netdev+bounces-254305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:48:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCE9A31E7
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B25B304AD81
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7872361DC8;
	Wed, 28 Jan 2026 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="oAJ6bE4Q"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D8D34F46E;
	Wed, 28 Jan 2026 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611481; cv=fail; b=us80/1eusZ7g6W1B3rYMH7Ci7AoWHp4RAnRVCwrgJQTOu1kho96HhvP8anX98PWVEtulx6OZCekyIUqQYIvBQhv5+BPl7sSZTAt2Jc/xIQSSLQt1EjuWkcoci4Fez/BLMXLq65ZIseIQYDPVAHwX5k5yuhNmb+GKifwkseuoW9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611481; c=relaxed/simple;
	bh=ezCnE1xV/pDtEaFxQjpeLGUr/fJqi4NQIkYzXu+TD+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMqHhSXkzigGueDh0wgfx7r/RgtBPzg3Uk92DBQmYCy5RjY6nQf0D8LWrj4068KjlYlpOaZLctdEjO4PutxSWpZlVbFa6fC5sESfi5JrrLeNnJG+qh99B37joizum6v0GU3rplw7AXwUcwFicAr7hdio8D4JikfRvfHlFHOKooA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=oAJ6bE4Q; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vldfi/lHvlQ0Lszkn2iNZTUNSNxQ45Yl6qIURlUU/wOw0/4Z+okkwVfqRsOy/8EB4lRLgw0SsR47p36Jd+n0fLmzBCKKOBf3nhP2jgiRarW7XWw2XmgQIgrT3GYooKJaY7LWgNsbCxkV3s5cHNw1XBX8y7BAjSF8+mDhfUquagUcKOTtw8Z0WPvB3a4/kLFe2FjxJ4bYUV96av2IRKGYcQVjJHo9G0MwQ3kEeF5QoP37R6CLPd3ceGEhg3yaKk6a1FLFCH6rnP8O4Od8u3D9iT1NhijQ89Ew3+9W5t/jYeDwOvdQ8mKoGfEPQRpNOwQfn8qzIAnEHynGuAZdomQQcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNmkDRYyZ6wm0GJb37/6NHrfr5yIsJM2LTcCAUh3xpM=;
 b=OjAIuw8D8mL9i+M2EBcbZz8ya3dRbvSSr2xjrg5NBo8+TKZ32yodHIaL7W+3Qas2zK3hp8SebiU7LVqvwxsNBGDPZUWY7NIFVSYbLrxtErR6V3ASdut36Mp76Z+sYyv5sFZo0qW2etsSObaSby40NK7iZzU+ol/SNwLv9NipP9xCgNgGh2lOZ4ewzCCW/PsaXLttNeym09DeQnmdjGJi6B3lB7A9wrA4fLJ413+9Z7Tj6PZpG7PNnZRcbUxgD0mkSZEUXzsRNCNGms4zg+zcgHj92CGYx2K5CqXUsGCPl2FZlx0XR5gDeeQ5RopmL0cKJSySQVDCehjaPh7f1n989Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNmkDRYyZ6wm0GJb37/6NHrfr5yIsJM2LTcCAUh3xpM=;
 b=oAJ6bE4QEs3Cs+PnzHJI1X6WRA9gUcsdqJniv4oZpPoD+cocOz5L8RjTUD46ZRKy3wY4geRevtLhrNPOk5JWmbYq6q/Ym2hYyDQmKj6kFDemh3qZxEYm/Ce8m84lRQjGs3CfyEARR+KvLKd09hAMNzkCvyOfAWA/wg1/pqNIBKCdHZv7ya/mNWitKr5mNODUWHmMWcHfyHwsrgzQPYoAOJN2L7AfyVsIJyUFNxk/5s0g5VQA+S1MwnFab1R/nBUizFuyjaTUpfMVeGmkBls5Bq1oRWMXw7ToPf5wSIQqYshy+iiCG2yVUg4O861IA4UZPiQ0dUckGYh1kmjlipzx0w==
Received: from DUZPR01CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::17) by VI1PR07MB6319.eurprd07.prod.outlook.com
 (2603:10a6:800:132::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 14:44:33 +0000
Received: from DU6PEPF0000B622.eurprd02.prod.outlook.com
 (2603:10a6:10:469:cafe::e8) by DUZPR01CA0048.outlook.office365.com
 (2603:10a6:10:469::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 14:44:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU6PEPF0000B622.mail.protection.outlook.com (10.167.8.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Wed, 28 Jan 2026 14:44:33 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id DA8DF20541;
	Wed, 28 Jan 2026 16:44:31 +0200 (EET)
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
Subject: [PATCH v1 net-next 1/3] net: update commnets for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
Date: Wed, 28 Jan 2026 15:44:24 +0100
Message-Id: <20260128144426.15870-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128144426.15870-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260128144426.15870-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B622:EE_|VI1PR07MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dddacc0-95b6-45f8-0399-08de5e7bc078
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VWNhME9WWmlZU054VXBpRnU5SGR0YjJiLzFMa3ZVOGwzTUtsTjNjbDE1Q1R5?=
 =?utf-8?B?RVZkbEJWZ0Jtb3Y1ZXJka2VubjRjeURQV0dDd2JVU2J5S3NwN0RMZEh5SVV1?=
 =?utf-8?B?VFJSaUJyYmpaUW9NaUFKd1Z4ajF2TXNNQzVGUVJsUTVRMmRpSk1rcVlRN09W?=
 =?utf-8?B?eFViRXpwV0tSTE9qVEVpRDRNY3N1YnhSZlQydzBUOTBoN2IwdDhFMW03cE5N?=
 =?utf-8?B?ZjN6ZFh0b0ZYbExWb0N0T1RPVmdSVVNubTQwbmJEdUNZV0VYMkYwdFJkTEFi?=
 =?utf-8?B?Z2xLSVJSQkZ3RWQyVkx0ZDNGZFZRTVpmR3lDaGJpZlJaV08rSHRnVHNZNjZo?=
 =?utf-8?B?Tk02Y3ZGRDJGZTQ1aEdFdjhPbEhPNFdlbkQrSGJ0UGV3WElYV1hnMGJxVmFR?=
 =?utf-8?B?c0J2ekhKUTRybHFER2FvTXY4Z2ZXcXN2dHZJNTdhNUdETTU0WVR6L2duZ1hn?=
 =?utf-8?B?SUR5SVg2SkVoci9wMXYzakRzUDRlZUxNM3BlQlBjRngwT0VvMEZZN1RXY0ZG?=
 =?utf-8?B?WU10Y0paVko3R3BEUmJ1SVphSVBIVWRVSHRibG8wQlJPY1NnOS9ZQmpzMHFo?=
 =?utf-8?B?Q3Ywc3hMV3J0YXdQdDdLQUdOQ0d5NHRzNVRPVGtHaUZPMTU0NUI0NitXMVpC?=
 =?utf-8?B?T2VydVArNFE2N2tQMUdLTHVwY3BZUUJhNGFpRXVLWjFjTHB1Q3Y2ekVpS2lr?=
 =?utf-8?B?L3Bxa1BjSEx2SWwyTmZ6NC83WERjd2wrcWVuQmFFaE9mRVlxL0F3cGxITmtJ?=
 =?utf-8?B?aHZscTVkWkhsVGJNOWlaQ3BDZUowcFQ4REt2RXM2ZHZtWHZjN3l3cndkYlNv?=
 =?utf-8?B?dzdBdHI3NmFMVGszZXRIdEJGcWlXU2xXRE45eTMxYVJUM3FVZS9MWm42a0w0?=
 =?utf-8?B?SmFnQzFLZUZnY1k2WXVXUVBCaEQxMkY0RlZqclFZVTRCVkN3RUZsOWMzQUl4?=
 =?utf-8?B?VENWNkIxeVFNT0hneU5zMUEreEFKV2tzdSs5b0NiZlZRV2s1QVVJNW1aY1Rk?=
 =?utf-8?B?MUhWMUlBVDVxR1FMbTRIRmZqeXNGOU9pMjdTdmNla1oycmVlaTYybFQwVTdi?=
 =?utf-8?B?VXRNR1YxYWwwZ0F5Um1MbHgvaDEyaHc3QktVSmd5Q05ieUJETkJaK1piL0xC?=
 =?utf-8?B?Y09VbkE0eEM3aEV4dlM4QWhPT3lOai9PTXhIL3krUFZpYjVCWWR4LzNaNk8z?=
 =?utf-8?B?ZUNBUTBkOWthL3d3OE4rNHBaN0hWTWR1MEtzMHU5YU14RmRPVFowdnNGUllv?=
 =?utf-8?B?UllCOWFacm5ad0VSdHdVYUdrS2xUbmZXVVlObGdnZTBSdDdqOEEyVlNYRndE?=
 =?utf-8?B?NURLUzdBZ01heU5iejhzRklkZGxnbjQycG4yTmcxZXJsZDAxTERQUmVXbm5t?=
 =?utf-8?B?RXR6RWxaQi9xNGM3QUZjTEUvNGxIUmlBeEdjTlNjSUxqdnYyNVo4WXFrbC9W?=
 =?utf-8?B?bFY0QVF6d1Rrc01qZUh1bzMwMXpsWVFIajZJQ0dBRWJGc2tIUnpzSFc2bG1m?=
 =?utf-8?B?QWgwK3RWV2VOWUs1SjNUTUxPMmRVK0FjbE5lalZOK1dVY3hwNDZ6ejJjTnNQ?=
 =?utf-8?B?S3h0c1FNS2R1Vm1zZHA1bHJHYytyeDVLT1NJY1RvN01PcEl3QkQ5K2FtN1V1?=
 =?utf-8?B?MXVYZ293bE5nWXdVN0VvZkRVS2cveDFWZkQ1NTRZRXQ5b0V1VzBNYktJcHJ3?=
 =?utf-8?B?THFyb000VWRIQVhBV0MyZU1CM2QvRnk2ZE1ZQWZVNzZta3kvU0JBbWxyVjI2?=
 =?utf-8?B?MU1hN2FCb3BLVDdzTm15bC9LYWlyZ29TT2dxck43SVZsMzNCZGZpbVFQeHBx?=
 =?utf-8?B?ajUyQ0E5REM5VXFVaTZUU2RXUHF6SnpwZFZQSDVPZE1ZTGttU1VxcDJQRmw1?=
 =?utf-8?B?Z0htTTl4UG5vS0tZNk54eHpoenFmek5wa2Y2S0RRZzd3a0M4UUlZK0hlOEFl?=
 =?utf-8?B?eHZNWlFIUFZuQUdrcW95U1dZVHpJbnRMbzZuVUI2YXNwZjhtajFHbGFBbHoy?=
 =?utf-8?B?dFI5ckFUWVgyemNzQUZXYUpWSnJkUUkxMzNIdy9CazdwMzVxS09LbTkxaG5Z?=
 =?utf-8?B?SGdvOTNUMlBQVVpZSUdxYmE2bVRtRzMrS1lLd20xTmpqaXVFbktubjdadDkv?=
 =?utf-8?B?WVNrcEExZVhzaWMxaFZqeHIzdHJBT1JGdEdMQzdFVUxPdy9kamdTNHNpUU8z?=
 =?utf-8?B?RTFpVk9jMGNLb0ZMUmh1SGtnY3ZjVmsyVHNKQXZHZmd1SitZK3ZLVFNVVXY1?=
 =?utf-8?Q?mGv2RtazDfU97O7d6u3wS0yXf1VxalkBZj0kydrbic=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 rLTNfczYAiUBXwVdtKC568hPyniOK0emHMF0UjW1x3qHajX0Byr2XMrpD+hPIlMBB8VsIvhgdzejxMG4xOmvt9C7a8pnp9jCjpyPUVHxn4tsPUPxakqyQYY+UY5JH04KH7YCBMj5W2sRmQ2c4VVlm2Z+pn3Aq9qDFOzS6Me8ApkbdJX/gp8T1+4onKYru8xKEWl0UrvtDUbIzF3ZhdZkjmaziqmB1YN9+sG4uJ+i6Z3HRMCZJlbEKXRSAl15DEe2Q+/lf/gZ5XjOGewF1xeT4DdgIBDOeKar57wErLnC0wjDUHWUqHg2hjzMjTHMl/XL8MXxH6v4Qnnei215HrFYr5dLiY9gEzdyspii78M6DP3nt+mUOR+n4VUBNnMpqtTHyficCTufZxKc06B8Tt/bsEFDDWjPUWl/Ts2KX3zPbM6OW1f5Fby7s9VWJ5bpJh72
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:44:33.5284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dddacc0-95b6-45f8-0399-08de5e7bc078
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6319
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254305-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NO_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9DCE9A31E7
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

No functional changes.

Co-developed-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/skbuff.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index e6bfe5d0c525..30a8dc4233ba 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -671,7 +671,13 @@ enum {
 	/* This indicates the skb is from an untrusted source. */
 	SKB_GSO_DODGY = 1 << 1,
 
-	/* This indicates the tcp segment has CWR set. */
+	/* For Tx, this indicates the first TCP segment has CWR set, and any
+	 * subsequent segment in the same skb has CWR cleared. However, because
+	 * the connection to which the segment belongs is not tracked to use
+	 * RFC3168 or AccECN (RFC9768), and using RFC3168 ECN offload may clear
+	 * ACE signal (CWR is one of it). Therefore, this cannot be used on Rx.
+	 * Instead, SKB_GSO_TCP_ACCECN shall be used to avoid CWR corruption.
+	 */
 	SKB_GSO_TCP_ECN = 1 << 2,
 
 	__SKB_GSO_TCP_FIXEDID = 1 << 3,
@@ -706,6 +712,14 @@ enum {
 
 	SKB_GSO_FRAGLIST = 1 << 18,
 
+	/* For TX, this indicates the TCP segment uses the CWR flag as part of
+	 * ACE signal, and the CWR flag is not modified in the skb. For RX, any
+	 * CWR flagged segment must use SKB_GSO_TCP_ACCECN to ensure CWR flag
+	 * is not cleared by any RFC3168 ECN offload, and thus keeping ACE
+	 * signal of AccECN segments. This is particularly used for Rx of
+	 * virtio_net driver in order to tell latter GSO Tx in a forwarding
+	 * scenario that it is NOT ok to clean CWR flag from the 2nd segment.
+	 */
 	SKB_GSO_TCP_ACCECN = 1 << 19,
 
 	/* These indirectly map onto the same netdev feature.
-- 
2.34.1


