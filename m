Return-Path: <netdev+bounces-251916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGxLDofzcGmgbAAAu9opvQ
	(envelope-from <netdev+bounces-251916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:40:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1F8595AA
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D17A6A88055
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD943AEF2E;
	Wed, 21 Jan 2026 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="VXIpQhFX"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011052.outbound.protection.outlook.com [52.101.70.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F3B36A01F;
	Wed, 21 Jan 2026 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005948; cv=fail; b=B6Ev1dvB1tOio4YPVM2kpsGT8QyYXNjBW8n36DyprYKXVpeuhI95ZPQdnMAGsdu/BC+Husm1Di3Yi/AfBy+RZsrWZ4NKmqMhtdYXJlkn/U6T7NlXCU1oVQJC4pVsIBNdv3ATnKjir95GtyMwrW4dDHZ2DTMQdveYjTYMNhkmgqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005948; c=relaxed/simple;
	bh=fUXhPl2buXOUfqJrvGtSiSYBOys6NdS9c5EsGSKR1T0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eYRN8/DdLCxiKIS1seWhVhH7lKlNfYhRTdu67iZMyqfFxwWrnS2DkfC+nd+qD5AeG3O7ylbROTVqq4YJ3mDMJPKHucypT9BeHjlRlV+f3BYKK1JA86EIjkljrU/U293yRjF1pRMiID8pB5Oxhqo15dOVhfy1UwvZZa+ur5ptBSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=VXIpQhFX; arc=fail smtp.client-ip=52.101.70.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHW2YYLKX164pszIFJu2/SAE+ppE7r+DyepMGBqO9qDWL3/5GyvAOar2gFx5g7zrMuj4eTW5wETTRAe1mmmdsUvVun00BvZ/+UZN4Rt8uHMLOOpvGFqoTPa0Kt4BAumwshZpy5K0ZLVlQXtj2PL87YL096QhKmCww5wGdoOO3Pwo134QC0UCvf2pwIBGo3la2MAAh4LOssQGBybiFpNyc4yoIr5SNyvZsXsH0BQ2ZqjGTKs2a0EuH9P0fTDApZW4dGgh1vWEpDByWkCESlHE6f9EyImtCH82HhlSScdgCDWuxnkXVCam44Ffw4CmAb8hGXk0x41El3bj1qTQ/2Yw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0PudwTCwvDJ+fG0ZC/20F479ZfLKSqWst6zGvFMLG8=;
 b=uuOgNAla2gnDSTeXme3nzcU7jDU+l3rLbpW3SBqUH1hSYbkWqLIMc96HM5/R/1bzaXNQex6t7DcNsE/lRPF9AbBDamf+68RIsg77x3a+5H+SCvLLbQgAvIj2Hu40ozo6yE7XrdPT/Z2VG1o7VU5y1KnYTMpXNAdBFeGmQ54HpzgN+RnmNq5FQBkqxyKhwZskyju2tw/jnZmxgzq/iDn17//3RbHQ0KpU38luv9WxBTQjdoIGaMubJ7hXtp8VPmCVyvD5Qsh3S7NziqeeX8VU1HrMQcZN0Nh9CnTgJ4epXTpENw2Vho7EN1+lJEIEEcJP5vw5aw8ENBUY4wAErSuPoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0PudwTCwvDJ+fG0ZC/20F479ZfLKSqWst6zGvFMLG8=;
 b=VXIpQhFX5eSzbEz9dYu46xS9rUYMqIDniAC+9RJvdbAQNdn7+cxZdSBy14dbIj6zh+FVSmn0j3e08yCBK77DfLBnirppvl7nI/WCqhfrhzxkj6xk6ujIu1TVffE0+lH0UTHjJv484l0kOeTkyv3qLomHl+ge3MYKAsedQedzTMV72b158zzL4NuXYrp7n7s+r3qh5VwfHr4o8uWwIo4Kxpt8l4uPESwh4/6CX/nOZti652OiSYnCQZTV+p7wrDmsO+sN8ZvoD4osUhk1HmVp3r3Wa/TJXE3//I+RdkqEcu/D5Jd26poh/iyu0bILQrbbsnwy+9EOJTihSgk08D7iUw==
Received: from DUZPR01CA0237.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::20) by PA4PR07MB7647.eurprd07.prod.outlook.com
 (2603:10a6:102:c7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 14:32:20 +0000
Received: from DU6PEPF0000A7E4.eurprd02.prod.outlook.com
 (2603:10a6:10:4b5:cafe::67) by DUZPR01CA0237.outlook.office365.com
 (2603:10a6:10:4b5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 14:32:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU6PEPF0000A7E4.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4 via
 Frontend Transport; Wed, 21 Jan 2026 14:32:20 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 764262051C;
	Wed, 21 Jan 2026 16:32:18 +0200 (EET)
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
Subject: [PATCH v10 net-next 01/15] tcp: try to avoid safer when ACKs are thinned
Date: Wed, 21 Jan 2026 15:32:01 +0100
Message-Id: <20260121143215.14717-2-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E4:EE_|PA4PR07MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: c9990067-ba8b-4ddc-68ea-08de58f9e265
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NkQ3SFdrdFlHK1hSS0pxOVkrQUU5SFJDMzQ3NVA1dnZWTDc3QnZXN3IzTTRW?=
 =?utf-8?B?Ui9Jc0NRR1pEcHdLQ0VNelUvVmJ5SlQ5NVJqOWQ1MWFxU3JMdG1ITzJONUU2?=
 =?utf-8?B?M0pxOFpSK1hlWmVsQXNaNE02OE9WT2thRFpqOHBybFZTcFJGcTNZTmJpdkJ4?=
 =?utf-8?B?cHR4N0VVTUdnNUlxQjE0UUEzVlpRVlJJRDdQNlhEKzBPMU5wSkxiVk1tVEMy?=
 =?utf-8?B?YzF5NzhhdnBreEdQWlZCZEVEU0lNUnZjZ0hTUUxhNU5RaXRpNlZpVEJSaXJk?=
 =?utf-8?B?QnhsbDdUd29rSjdTKzBpWU1majdJQUh4YUN0cS9xVEFqSXNYemxCZlZ3N1p3?=
 =?utf-8?B?cmgyQU1YbzdTTEZuTEpGTHdnakJ5bGl1R2IrSG1JK0hORGJEa2xqTWxSN3oz?=
 =?utf-8?B?ZzFwN3dKWlZlMHlJS1Y1WVUrV0krYTBobDNlc1BYK3lvYkx2dzVkQVNOT0hw?=
 =?utf-8?B?T0Qza3g2L0Z1Y1luekhGOWJjMEtRRzZISkJLTjdQZ2dUYXJjVzFYZWFFN2pT?=
 =?utf-8?B?SXV0d3laSkVENWdmQ0lOUmtOcGpSd1VOQ1ozSndVd2lZREVjc3BlRkxNSi9P?=
 =?utf-8?B?VHRDUHEyb2tPaDZZSjdrSk5GUTk4bW1GNU9PUXJ5QlVxWHNjM0gzOG96NlFD?=
 =?utf-8?B?Si9iRjY4ZnZ1T1JXOWtqZDJjVGQ1Sk5zU1JXWk1TTmtwbEs5aDh3MUxqb0h1?=
 =?utf-8?B?WUsrWnFrM0trQzhNTmUrV1AvcUxSYnBHNFFoT0dEQU1heElPTVBYQjBNZGdv?=
 =?utf-8?B?RTB3cWRCMkg2SVA3UTV6ZnZVRElZd1JGYXBvT3BZbXlray9NU3dRU3hxMmRs?=
 =?utf-8?B?VmRZRXBON0R3V2NNU3RnTzl5cmZHa0Q5ck5XZWhzT3o5Z0dOZlpxWDFtTjdV?=
 =?utf-8?B?eGNrZWthU3AwWFF1VEMxWGhmekZZNXRjSE9IMk53UGJuemVtZUQwWWJuazRp?=
 =?utf-8?B?RkxtOFlmMUpXQWd0ZG9Ub0U3YS9OYUxpUFBVclRpcjgxdnoxQlViNDZ4T2Ji?=
 =?utf-8?B?d0hOR24wUzVXc1crZzRDODFUaEpVOHBFYWhVWmhPdzNUUSs5Q2xXR0ZZU2pZ?=
 =?utf-8?B?Z2ttNXNvTXV3RHFKNzRTNVVodHNrbEV4NnhQZXY5TmpLWGE1TjMxN2ZHTmdJ?=
 =?utf-8?B?VTg1d1pYS2xOdnR0aE1wTUdhcmluY2dldjUwS1owcXFzSHlSWnpGSjJlRjZi?=
 =?utf-8?B?TUptcGF1eEw5dUF0SEtQVEpXQmxRdktzMmJ4WlRObndvQ0l2Vmp4VkcxOERH?=
 =?utf-8?B?bjdBTCtYb0FjK29WeWdCTHhSdUVhbnFjM2x6SXpMNHdJMitBb1VKbE91aS9p?=
 =?utf-8?B?d3NMZTFWL1RtVWVicC8reldIMGNHRWZXWFQ3UXE5U3RQbHlMWVFvZWV1ZGVs?=
 =?utf-8?B?SWN4QXhjc0RNUEhBWis2d1JHd1BLRDh6YlV4S0RNVlVub2cydURhc0VxSU4v?=
 =?utf-8?B?QTFvNENHY2lTVFpKZ3Bvck1mUEZJcGwyYWVSak5mNTNlUWs1anZKTXMzekds?=
 =?utf-8?B?MkZmT1FFSXc4cTF0UDRxdkw3QTVOS3owQnFIQ1o1V3RyUnpxUVdJMis2Q1Vq?=
 =?utf-8?B?UjlXNis3OW1LS2gzZEw4N2k1U3FCYUhJdjJPYWc5QVV5WU05akxJYzI0MzZp?=
 =?utf-8?B?REllU3Q5Z3g3bi9UaXdQL0M2MUhqay9LVk5hTU56MzBJSy80UGpBUnFDQmN0?=
 =?utf-8?B?M3R5QmQ1bjFpNVp1akJPQWRXaWovWnVaNUkrdzVGZmFaZTAydU9IdTZ3d2Zr?=
 =?utf-8?B?KzNkSndjdndPUnNHdU1WbU1MbnRTYXRXUnAycU9vOVMrR0Y4QkRPSmVTeVpY?=
 =?utf-8?B?eW1VSHl6dElaem05V3QxSXg2c1VzcVgveFpEeng2OWFmUnVmMzFpbC8wcHYw?=
 =?utf-8?B?aGZXUVN0c2x1Q0d5MHU3amNESjI0emdFKzZCUldlQXZ1dFp1NkhLSDk5Wk5B?=
 =?utf-8?B?Sm9UK1JRU0x4cmtSSVlHNHhKcE0zcGlsQ3IvZXd2Y3l5SnBWN3d4bEdkK2RZ?=
 =?utf-8?B?MlVlQ0ErVm56V3g4Q0ozQmhpd29tVERJeGtBMFZjRjlZTkw3SVpVNjluVHZF?=
 =?utf-8?B?cmo0NDNLWUpoak02VTNmMzlWQnNpUm1rY09CZDVQczJQaTlhOUljYm1Ya0Fa?=
 =?utf-8?B?S0NXUkJnQUpTNGFiS2FRSlZrQ2twWjdDTW5VaEVManRsUzQrNjFxSEhYazBO?=
 =?utf-8?B?eGovNnJuQ2lpQU96dlh4bkR3RVQ5eldoSTNac281ckFkVElqVFROZGtYU0g4?=
 =?utf-8?Q?m+3u0Xqgv9vhpmBsOAH2ZdFJ+hej4cEPjC6Os6IYzA=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 14:32:20.0674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9990067-ba8b-4ddc-68ea-08de58f9e265
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF0000A7E4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7647
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251916-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
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
X-Rspamd-Queue-Id: BF1F8595AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ilpo Järvinen <ij@kernel.org>

Add newly acked pkts EWMA. When ACK thinning occurs, select
between safer and unsafe cep delta in AccECN processing based
on it. If the packets ACKed per ACK tends to be large, don't
conservatively assume ACE field overflow.

This patch uses the existing 2-byte holes in the rx group for new
u16 variables withtout creating more holes. Below are the pahole
outcomes before and after this patch:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ecn_bytes[3]; /*  2744    12 */
    /* XXX 4 bytes hole, try to pack */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 177 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ecn_bytes[3]; /*  2744    12 */
    u16                        pkts_acked_ewma;        /*  2756     2 */
    /* XXX 2 bytes hole, try to pack */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 178 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v3:
- Add additional min() check if pkts_acked_ewma is not initialized.
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  1 +
 net/ipv4/tcp.c                                |  2 ++
 net/ipv4/tcp_input.c                          | 20 ++++++++++++++++++-
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 26f32dbcf6ec..563daea10d6c 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -105,6 +105,7 @@ u32                           received_ce             read_mostly         read_w
 u32[3]                        received_ecn_bytes      read_mostly         read_write
 u8:4                          received_ce_pending     read_mostly         read_write
 u32[3]                        delivered_ecn_bytes                         read_write
+u16                           pkts_acked_ewma                             read_write
 u8:2                          syn_ect_snt             write_mostly        read_write
 u8:2                          syn_ect_rcv             read_mostly         read_write
 u8:2                          accecn_minlen           write_mostly        read_write
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 20b8c6e21fef..683f38362977 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -345,6 +345,7 @@ struct tcp_sock {
 	u32	rate_interval_us;  /* saved rate sample: time elapsed */
 	u32	rcv_rtt_last_tsecr;
 	u32	delivered_ecn_bytes[3];
+	u16	pkts_acked_ewma;/* Pkts acked EWMA for AccECN cep heuristic */
 	u64	first_tx_mstamp;  /* start of window send phase */
 	u64	delivered_mstamp; /* time we reached "delivered" */
 	u64	bytes_acked;	/* RFC4898 tcpEStatsAppHCThruOctetsAcked
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index d5319ebe2452..37a6e0aa9176 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3418,6 +3418,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
+	tp->pkts_acked_ewma = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5191,6 +5192,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_interval_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_last_tsecr);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_ecn_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, pkts_acked_ewma);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, first_tx_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index dc8e256321b0..7d573a3bea2a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -488,6 +488,10 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 		tcp_count_delivered_ce(tp, delivered);
 }
 
+#define PKTS_ACKED_WEIGHT	6
+#define PKTS_ACKED_PREC		6
+#define ACK_COMP_THRESH		4
+
 /* Returns the ECN CE delta */
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes,
@@ -499,6 +503,7 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	u32 delta, safe_delta, d_ceb;
 	bool opt_deltas_valid;
 	u32 corrected_ace;
+	u32 ewma;
 
 	/* Reordered ACK or uncertain due to lack of data to send and ts */
 	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
@@ -507,6 +512,18 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	opt_deltas_valid = tcp_accecn_process_option(tp, skb,
 						     delivered_bytes, flag);
 
+	if (delivered_pkts) {
+		if (!tp->pkts_acked_ewma) {
+			ewma = delivered_pkts << PKTS_ACKED_PREC;
+		} else {
+			ewma = tp->pkts_acked_ewma;
+			ewma = (((ewma << PKTS_ACKED_WEIGHT) - ewma) +
+				(delivered_pkts << PKTS_ACKED_PREC)) >>
+				PKTS_ACKED_WEIGHT;
+		}
+		tp->pkts_acked_ewma = min_t(u32, ewma, 0xFFFFU);
+	}
+
 	if (!(flag & FLAG_SLOWPATH)) {
 		/* AccECN counter might overflow on large ACKs */
 		if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
@@ -555,7 +572,8 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 		if (d_ceb <
 		    safe_delta * tp->mss_cache >> TCP_ACCECN_SAFETY_SHIFT)
 			return delta;
-	}
+	} else if (tp->pkts_acked_ewma > (ACK_COMP_THRESH << PKTS_ACKED_PREC))
+		return delta;
 
 	return safe_delta;
 }
-- 
2.34.1


