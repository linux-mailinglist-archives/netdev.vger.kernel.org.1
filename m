Return-Path: <netdev+bounces-252772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHjVHG1Jc2mHuQAAu9opvQ
	(envelope-from <netdev+bounces-252772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:11:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14668740A4
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0138300B53F
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3D738552B;
	Fri, 23 Jan 2026 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Cfsj3NlN"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011059.outbound.protection.outlook.com [52.101.70.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A632933A9CB;
	Fri, 23 Jan 2026 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162894; cv=fail; b=tJoI/oqbjrAp6LE9QCFxVHpN4Gv231K5/wTutnIisA/gtlNcc8dPThskvcWnDhbaOINXrsylfOmLPmz52YcJBgpMaMjfEjOVixJnj6kFNuF22+eDXYhyMkyqF1uKMIF6wvYve/IlRtDO/D+BluSdg2nYFZtfLVjlB9rF+9DRG6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162894; c=relaxed/simple;
	bh=M3ZYKnMvp3AoB/8br71RPfiSaENig13x9XU2KeKqaNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+gCRb3AMdTgdocG4J8/uulufSXQhZ4NaLp4uBjOD7FuhTMHKHTOJRZqt06H9QXQonLlozL8YYU/IrPbPC8wTVHs4pRQTrlbNU5Sxq7aMUZ1l25Yw1cp5565Kooae29my1nZioZi/PucVbQ6Ytz4ZDxdYaXs+L1OH4GvQtUYKaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Cfsj3NlN; arc=fail smtp.client-ip=52.101.70.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikJUW1hNJ5pSdBn1yHT96nlzXcu2KTUFbrtOwXJicFvd7P5X+35gQbfX1uGNaNnI+oXGJWcUpxyHWyLg8FLEfbaMLmEm/qcIdiHrj2KVoXMhU3Q8rs1qNq/hmnsd1pC7hrYPBfBz9SNim+zgXyz+knBzJ0i8YEDqrEgpQS1VXWnkJOybEy6hRK/p6f4bJpggFHX52EZXfVqVvv9YZow4b1QzKuxsdtjBA6WS3Nvqd3m7mVwTXqboD8E96MfDiMV6w2fjFmvhzatwKu2gyKw35JFBQGeVX0q6zzPV5zPcNT4IgTzZbTMHPi5MpjR2xfVA2WkLH03ZHLrWLCoJSEFq5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlM9jds6t0oC36MQfY5bBXdcVGgoe+XOrH/O1YzPG7A=;
 b=NUEpx/QkvoNtq/Sxv7S2fabtRDwVb/uQjC0xA2ESE85yNNxlVemnjbI3nfOiif4TAJlkC6cclvyIXCBtQ4dke1OYIZl6ulYN3z3euC93UslslQu2A/zCSPhIjTHDsOYlpJkwJUwNKHPgDHvckgWYxLfzl3p1pnU43ZUCT5Qrz7wslbj2Q26cwl5WjGEU0qlXdtma+h+gjXAq1kNfbawLP2G4ZYbeSeE+MtuD9dV/F2MbAvBd3UB2Fu6lxRp+/tHaJgATvgxR3iicrg+Q8yDI2NcHKxR4Itx8p40E1loUvo8GZROpX7HyIP6H6GfvNOlvQNlpjZoqMvw9m5nKH5sCng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlM9jds6t0oC36MQfY5bBXdcVGgoe+XOrH/O1YzPG7A=;
 b=Cfsj3NlN2Y3D2rR7X3MVq3mJjn1klck3b8w7xYuBlX9zjnJrL9crXQTBAp+wWX7eC/ZY2zklHL+c4owEPB13x+YZqJQSLsII4DND6/wpaTnfsPYzRJk6L4hcHdl2znA6IygazJKeo1VzAx4SmzBp8IJnoYRBYxY5WtqH1oJl/dwOzhQjgnLyhDZgACCDV0wTTkmEfaCICTPgsBmvX8qYAQoCGCdxkoZYbtqhtC7Or0JPWVJt+bjeMyq/NXWoceX6JWwHpsKSPZXrxiykW8lKBCGMppJi5En8/Eyt7L6dMSK5129WjUUtFuYEKLkjfkWKat6StKsvIHoe4FByW0BEYw==
Received: from DU2PR04CA0214.eurprd04.prod.outlook.com (2603:10a6:10:2b1::9)
 by AS5PR07MB9986.eurprd07.prod.outlook.com (2603:10a6:20b:67f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:07:53 +0000
Received: from DU2PEPF00028D03.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::e5) by DU2PR04CA0214.outlook.office365.com
 (2603:10a6:10:2b1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 10:07:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D03.mail.protection.outlook.com (10.167.242.187) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Fri, 23 Jan 2026 10:07:53 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 146C21C0031;
	Fri, 23 Jan 2026 12:07:51 +0200 (EET)
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
Subject: [PATCH v11 net-next 15/15] selftests/net: packetdrill: add TCP Accurate ECN cases
Date: Fri, 23 Jan 2026 11:07:21 +0100
Message-Id: <20260123100721.42451-16-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123100721.42451-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260123100721.42451-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D03:EE_|AS5PR07MB9986:EE_
X-MS-Office365-Filtering-Correlation-Id: 23894402-996e-4328-968e-08de5a6745d0
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QmtvUCtVNDlMV2tyVU12WDFaclF2T0wrK3hXd0RNcVphUEpkRHl5cE0rUk1u?=
 =?utf-8?B?ek1JT0MrWFI1MWJUQzZISFJBcFpRbmdKTkNBQk5TZEhvTnVvNHlLYng4TVVS?=
 =?utf-8?B?WStNRzhMTmlCY3ZhaG51NUxzZG9RVTJRb1ZUZ1QzeStDM2p2RkZaMENpdUtW?=
 =?utf-8?B?dnVaMGlGUEFHU3V4bDBQZGIvNmVobGU3dkZsVkVGVzBOSHhQaU1LYVBRdkV0?=
 =?utf-8?B?cWM5WkI4cWt3TmY1eHM0NDRqZS90L0VQZkJlRmV2NVFRWkF0ZUp0MndKUlRj?=
 =?utf-8?B?aXhRUkxPWUJGQmtWLzNUZE8yeklHS0k3QUJza2Z3UHEzQTJkUnN6d3NsNDBo?=
 =?utf-8?B?aStDMm4waXFVbDJRekI2M3dFODVkNnRIQVRtUnYvTEVTZHNjUzFYWjZrcVow?=
 =?utf-8?B?Y1owQ0YxelpQMWxrNk1ta0JYeUJDbWZqdGxGeHZDT21LOGcxZWtLU0M1ZEZG?=
 =?utf-8?B?N2VuY3AvZk9kSXZVVnNBWWxlYlFnRGNQc3ZFNnQyWE1wNHZtRTNYTGpBeE9n?=
 =?utf-8?B?T21EYUk2M241QWk4ZWllQmQyOW9SaVJSZ2JtbjMwclBvM000WEdGN0l0RWFH?=
 =?utf-8?B?S2QxRGFhNlFMTDJ3ODVjcTMwaWdUK2FCYWl3ZThKMzVoa1A2L0JWT1UyN2FE?=
 =?utf-8?B?YzNqejYzNGtJQjYvWnQ1ZkRYdGVvbjdOa2tIK0o4R01KcFlDRHNieVpJOFJG?=
 =?utf-8?B?a2NUOHdUVXBEQTM1bjZ2dEVDRDcyT0tFUmRIclBQWSt2aGtOZnIzT2ZvNXNa?=
 =?utf-8?B?UGozOHRqb2x2OU5NbmVORFFpUjVCQVNtOUpHZkRQQWtYbVFJdWJsWVgzUEY3?=
 =?utf-8?B?OW94UlREUzRCYkF0Yzl2QlVSaTljQjUva3p4SU0rVkZZUXd2MXRTbWJGWVRl?=
 =?utf-8?B?bXlLdUxMYmNGdnQ4b2NVT2dPbXJnN0pSeUR6d1g5UFFXRWpSeVUxUDJTZHRp?=
 =?utf-8?B?NG1aNU0xdjhkdDNEWnpEc3JVakl4d0RJMlBkSVJGaVlFT0J4ZGhKSWs4Zkwy?=
 =?utf-8?B?TnE5VlZNdUVOU3JjRHZ3RWxzUTlPalhhMkE4Y2ZsdTk2NXQwMHhwb29MZmJv?=
 =?utf-8?B?UjNVZVNFQTNVa2tTL0VuMi9ObFJxWVV6RWdOa2s2aWE0dStYT2s2ZGpBOGlH?=
 =?utf-8?B?YXZtYTcwQ2lYaXh0K3A5VHJTWmhFRndMektRRWhwZ01oZCtWMGNpN0dqekdR?=
 =?utf-8?B?T0pjLzJYNWYvaExyQ2x0bU40ZVEvcmZxeS9LV0pOZk9SZTZPTHA2M0ZDYUI2?=
 =?utf-8?B?YVMwd3VjaTg1Mk5HWDBVL1VFYWhsb1R4a3FRNWVlM2Y3M1A5ajRUeEFSRE4x?=
 =?utf-8?B?Q21UVDdISTZyUE9UV0ozNmEwVjBsL1NZRGdId3F1cUtYamdnelRTdlNYVzBM?=
 =?utf-8?B?N1I3SGpyV1htRjQrd1VTb3A5QWVTb3cwZE1seENqRitnVVdaNnpLTTFNdGV0?=
 =?utf-8?B?K1d3aGQ1L3RYTzdWcHlkVWdUT0ROTVZ5T1o3NWM0ZGVCSzByZ2E4dVJOV05M?=
 =?utf-8?B?TmxRWGhHQUcwRHY4Wk55Z09UTmM3WTRyL0xSR0JLZkVKcG1rZjhERkw2Wkdy?=
 =?utf-8?B?UE54dmtpcHVLaDZpbDhEQWJFL1BRc2xKY08wTDB1WlBBWEY3aWdsNWZnRDkv?=
 =?utf-8?B?dU56SzJseDhpVm9RQ2xQOXVVNWs3RW13eTcrNXRPTVZnTWxsNjczV1VJSTFK?=
 =?utf-8?B?c25pWndzZU1lS2Q1UnZLRUw3eWF2MExDVDYremlVQ3hvZm1peldjU0JJK1ZR?=
 =?utf-8?B?VEtZcTI2c1FGMkNKRzlNRHhCMlAzd3A0NWhWRUJVUEtFcU5WL3NvK3dRU3BH?=
 =?utf-8?B?NFVGMUZFUTFFQlNKS3h5eGMwRzB1Z3BWcExRWGJxaHM2aVZxendvb2REa3h0?=
 =?utf-8?B?S1RKRkVLRWdScXZqM0lxSFpJTEpnQXBCODZxSFFmSGxGNG0rTlkxdU93ME5J?=
 =?utf-8?B?di84S1AzZFB3bUlNUWJHN0ppYTg2OS8vSU5rQVgrT2QrOHNxcGNYbUVSQWdD?=
 =?utf-8?B?Z3V1RGZubXlhRFdrRmJFaFNnb1Q0aDBUd2hpVmZmdXo4cHFubExuWHZrMDdT?=
 =?utf-8?B?SWpKL2pFV1hSZXVDc082a29OaC9XMWhET1YrK0oxQVdCMGtYZmVMREZHdjZr?=
 =?utf-8?B?SVRtNWxYcHBwZk5mWTd1bnBMRHFwbFd5NG9lT3dkbHNmdWg0V285V001S2cv?=
 =?utf-8?B?M0x3NE5SZ2lFSld3YkprNERLTThEZVN4MVhPTXM1SlBaQkZ4Z0Y0WktBME5u?=
 =?utf-8?Q?RjSq6j3l1sBGikyvTqi5JBxexZQ4FWMISbcyNg0Y5s=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:07:53.1753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23894402-996e-4328-968e-08de5a6745d0
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB9986
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252772-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 14668740A4
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Linux Accurate ECN test sets using ACE counters and AccECN options to
cover several scenarios: Connection teardown, different ACK conditions,
counter wrapping, SACK space grabbing, fallback schemes, negotiation
retransmission/reorder/loss, AccECN option drop/loss, different
handshake reflectors, data with marking, and different sysctl values.

The packetdrill used is commit cbe405666c9c8698ac1e72f5e8ffc551216dfa56
of repo: https://github.com/minuscat/packetdrill/tree/upstream_accecn.
And corresponding patches are sent to google/packetdrill email list.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Co-developed-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>

--
v10:
- Update timing in tcp_accecn_client_accecn_options_lost.pkt

v9:
- Update commit message

v8:
- Change patch title
- Rename all AccECN cases with tcp_accecn in the prefix
- Move all cases under tools/testing/selftests/net/packetdrill/
---
 .../tcp_accecn_2nd_data_as_first.pkt          | 24 +++++++
 .../tcp_accecn_2nd_data_as_first_connect.pkt  | 30 ++++++++
 .../tcp_accecn_3rd_ack_after_synack_rxmt.pkt  | 19 +++++
 ..._accecn_3rd_ack_ce_updates_received_ce.pkt | 18 +++++
 .../tcp_accecn_3rd_ack_lost_data_ce.pkt       | 22 ++++++
 .../net/packetdrill/tcp_accecn_3rd_dups.pkt   | 26 +++++++
 .../tcp_accecn_acc_ecn_disabled.pkt           | 14 ++++
 .../tcp_accecn_accecn_then_notecn_syn.pkt     | 28 ++++++++
 .../tcp_accecn_accecn_to_rfc3168.pkt          | 18 +++++
 .../tcp_accecn_client_accecn_options_drop.pkt | 34 +++++++++
 .../tcp_accecn_client_accecn_options_lost.pkt | 38 ++++++++++
 .../tcp_accecn_clientside_disabled.pkt        | 12 ++++
 ...cecn_close_local_close_then_remote_fin.pkt | 25 +++++++
 .../tcp_accecn_delivered_2ndlargeack.pkt      | 25 +++++++
 ..._accecn_delivered_falseoverflow_detect.pkt | 31 ++++++++
 .../tcp_accecn_delivered_largeack.pkt         | 24 +++++++
 .../tcp_accecn_delivered_largeack2.pkt        | 25 +++++++
 .../tcp_accecn_delivered_maxack.pkt           | 25 +++++++
 .../tcp_accecn_delivered_updates.pkt          | 70 +++++++++++++++++++
 .../net/packetdrill/tcp_accecn_ecn3.pkt       | 12 ++++
 .../tcp_accecn_ecn_field_updates_opt.pkt      | 35 ++++++++++
 .../packetdrill/tcp_accecn_ipflags_drop.pkt   | 14 ++++
 .../tcp_accecn_listen_opt_drop.pkt            | 16 +++++
 .../tcp_accecn_multiple_syn_ack_drop.pkt      | 28 ++++++++
 .../tcp_accecn_multiple_syn_drop.pkt          | 18 +++++
 .../tcp_accecn_negotiation_bleach.pkt         | 23 ++++++
 .../tcp_accecn_negotiation_connect.pkt        | 23 ++++++
 .../tcp_accecn_negotiation_listen.pkt         | 26 +++++++
 .../tcp_accecn_negotiation_noopt_connect.pkt  | 23 ++++++
 .../tcp_accecn_negotiation_optenable.pkt      | 23 ++++++
 .../tcp_accecn_no_ecn_after_accecn.pkt        | 20 ++++++
 .../net/packetdrill/tcp_accecn_noopt.pkt      | 27 +++++++
 .../net/packetdrill/tcp_accecn_noprogress.pkt | 27 +++++++
 .../tcp_accecn_notecn_then_accecn_syn.pkt     | 28 ++++++++
 .../tcp_accecn_rfc3168_to_fallback.pkt        | 18 +++++
 .../tcp_accecn_rfc3168_to_rfc3168.pkt         | 18 +++++
 .../tcp_accecn_sack_space_grab.pkt            | 28 ++++++++
 .../tcp_accecn_sack_space_grab_with_ts.pkt    | 39 +++++++++++
 ...tcp_accecn_serverside_accecn_disabled1.pkt | 20 ++++++
 ...tcp_accecn_serverside_accecn_disabled2.pkt | 20 ++++++
 .../tcp_accecn_serverside_broken.pkt          | 19 +++++
 .../tcp_accecn_serverside_ecn_disabled.pkt    | 19 +++++
 .../tcp_accecn_serverside_only.pkt            | 18 +++++
 ...n_syn_ace_flags_acked_after_retransmit.pkt | 18 +++++
 .../tcp_accecn_syn_ace_flags_drop.pkt         | 16 +++++
 ...n_ack_ace_flags_acked_after_retransmit.pkt | 27 +++++++
 .../tcp_accecn_syn_ack_ace_flags_drop.pkt     | 27 +++++++
 .../net/packetdrill/tcp_accecn_syn_ce.pkt     | 13 ++++
 .../net/packetdrill/tcp_accecn_syn_ect0.pkt   | 13 ++++
 .../net/packetdrill/tcp_accecn_syn_ect1.pkt   | 13 ++++
 .../net/packetdrill/tcp_accecn_synack_ce.pkt  | 28 ++++++++
 ..._accecn_synack_ce_updates_delivered_ce.pkt | 22 ++++++
 .../packetdrill/tcp_accecn_synack_ect0.pkt    | 24 +++++++
 .../packetdrill/tcp_accecn_synack_ect1.pkt    | 24 +++++++
 .../packetdrill/tcp_accecn_synack_rexmit.pkt  | 15 ++++
 .../packetdrill/tcp_accecn_synack_rxmt.pkt    | 25 +++++++
 .../packetdrill/tcp_accecn_tsnoprogress.pkt   | 26 +++++++
 .../net/packetdrill/tcp_accecn_tsprogress.pkt | 25 +++++++
 58 files changed, 1366 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first_connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_after_synack_rxmt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_ce_updates_received_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_lost_data_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_dups.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_acc_ecn_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_then_notecn_syn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_to_rfc3168.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_lost.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_clientside_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_close_local_close_then_remote_fin.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_2ndlargeack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_falseoverflow_detect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack2.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_maxack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_updates.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_ecn3.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_ecn_field_updates_opt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_ipflags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_listen_opt_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_ack_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_bleach.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_listen.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_noopt_connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_optenable.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_no_ecn_after_accecn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_noopt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_noprogress.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_notecn_then_accecn_syn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_fallback.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_rfc3168.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab_with_ts.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled2.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_broken.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_ecn_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_only.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_acked_after_retransmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_acked_after_retransmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect0.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce_updates_delivered_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect0.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rexmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rxmt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_tsnoprogress.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_tsprogress.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first.pkt
new file mode 100644
index 000000000000..07e9936e70e6
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first.pkt
@@ -0,0 +1,24 @@
+// 3rd ACK + 1st data segment lost, data segments with ce
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
++0.05 < SEWA 0:0(0) win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+// 3rd ACK lost
+// 1st data segment lost
++0.05 < [ce] EAP. 1001:2001(1000) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] WA. 1:1(0) ack 1 <ECN e1b 1 ceb 1000 e0b 1,nop,nop,nop,sack 1001:2001>
++.002 accept(3, ..., ...) = 4
+
++0.2 < [ce] EAP. 1:1001(1000) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.001 > [ect0] EWA. 1:1(0) ack 2001 <ECN e1b 1 ceb 2000 e0b 1,nop>
+
++0.05 < [ce] EAP. 2001:3001(1000) ack 1 win 264
++.001 > [ect0] . 1:1(0) ack 3001 <ECN e1b 1 ceb 3000 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first_connect.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first_connect.pkt
new file mode 100644
index 000000000000..76b8422b34dc
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first_connect.pkt
@@ -0,0 +1,30 @@
+// 3rd ACK + 1st data segment lost, 2nd data segments with ce
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] SW. 0:0(0) ack 1 win 32767 <mss 1016,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
+// 3rd ACK lost
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 write(4, ..., 2000) = 2000
+// 1st data segment lost + 2nd gets CE
++.002 > [ect0] .5 1:1005(1004) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++.000 > [ect0] P.5 1005:2001(996) ack 1 <ECN e1b 1 ceb 0 e0b 1, nop>
++0.05 < [ect0] .6 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 996 e1b 1,nop,nop,nop,sack 1005:2001>
+
++0.01 %{ assert tcpi_delivered_ce == 1, tcpi_delivered_ce }%
+
++0.002~+0.1 > [ect0] .5 1:1005(1004) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++.05 < [ect0] .6 1:1(0) ack 2001 win 264 <ECN e0b 1005 ceb 996 e1b 1,nop>
+
++0.01 write(4, ..., 1000) = 1000
++0~+0.002 > [ect0] P.5 2001:3001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.1 < [ect0] .5 1:1001(1000) ack 3001 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++0~+0.01 > [ect0] .5 3001:3001(0) ack 1001 <ECN e1b 1 ceb 0 e0b 1001,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_after_synack_rxmt.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_after_synack_rxmt.pkt
new file mode 100644
index 000000000000..84060e490589
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_after_synack_rxmt.pkt
@@ -0,0 +1,19 @@
+// Test 3rd ACK flags when SYN-ACK is rexmitted
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.1 < [ect0] S. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// Our code currently sends a challenge ACK
+// when it receives a SYN in ESTABLISHED state
+// based on the latest SYN
++.002 > [ect0] A. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_ce_updates_received_ce.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_ce_updates_received_ce.pkt
new file mode 100644
index 000000000000..d3fe09d0606f
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_ce_updates_received_ce.pkt
@@ -0,0 +1,18 @@
+// Third ACK CE increases r.cep
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
++0.05 < SEWA 0:0(0) win 32767 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ce] W. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] WAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_lost_data_ce.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_lost_data_ce.pkt
new file mode 100644
index 000000000000..d28722db42b1
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_lost_data_ce.pkt
@@ -0,0 +1,22 @@
+// 3rd ACK lost, CE for the first data segment
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
++0.05 < SEWA 0:0(0) win 32767 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+// 3rd ACK lost
++0.05 < [ce] EAP. 1:1001(1000) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] WA. 1:1(0) ack 1001 <ECN e1b 1 ceb 1000 e0b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.05 < [ce] EAP. 1001:2001(1000) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.001 > [ect0] EWA. 1:1(0) ack 2001 <ECN e1b 1 ceb 2000 e0b 1 ,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_dups.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_dups.pkt
new file mode 100644
index 000000000000..a4d808116e34
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_dups.pkt
@@ -0,0 +1,26 @@
+// Test SYN/ACK rexmit triggered 3rd ACK duplicate + CE on first data seg
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+
+// SYN/ACK rexmitted => two 3rd ACKs in-flight
++1.0~+1.1 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+// Delivered 1st 3rd ACK
++0.05 < [ect0] W. 1:1(0) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
+// Duplicate 3rd ACK delivered
++1.05 < [ect0] W. 1:1(0) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
+
++0.05 < [ce] EAP. 1:1001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] WA. 1:1(0) ack 1001 <ECN e1b 1 ceb 1000 e0b 1,nop>
+   +0 read(4, ..., 1000) = 1000
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_acc_ecn_disabled.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_acc_ecn_disabled.pkt
new file mode 100644
index 000000000000..509838d5a4b2
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_acc_ecn_disabled.pkt
@@ -0,0 +1,14 @@
+// Test that when accurate ECN is disabled,
+// client uses RFC3168 ECN for SYN
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=1
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEW 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] S. 0:0(0) ack 1 win 32767 <mss 1460,sackOK,nop,nop,nop,wscale 8>
++.002 > [noecn] . 1:1(0) ack 1
+
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_then_notecn_syn.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_then_notecn_syn.pkt
new file mode 100644
index 000000000000..10728114b11b
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_then_notecn_syn.pkt
@@ -0,0 +1,28 @@
+// Test that SYN-ACK with ACE flags and without
+// ACE flags got dropped. Although we disable ECN,
+// we shouldn't consider this as blackholed as
+// these are dropped due to congestion
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
++0 < [ect0] SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] SA. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+
+// Retransmit SYN
++0.1 < [noecn] S 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
++0.1 < [noecn] W. 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
+// Write with AccECN option but with ip-noecn since we received one SYN with ACE=0
++0.01 write(4, ..., 100) = 100
++.002 > [noecn] P5. 1:101(100) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_to_rfc3168.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_to_rfc3168.pkt
new file mode 100644
index 000000000000..04d928f0d44d
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_to_rfc3168.pkt
@@ -0,0 +1,18 @@
+// Test AccECN -> RFC3168 fallback when sysctl asks for RFC3168 ECN
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=1
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SE. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < . 1:1(0) ack 1 win 320
++.002 accept(3, ..., ...) = 4
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] P. 1:1001(1000) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_drop.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_drop.pkt
new file mode 100644
index 000000000000..788af6bea69c
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_drop.pkt
@@ -0,0 +1,34 @@
+// Client negotiates AccECN and starts sending
+// AccECN option in last ACK and data segments
+// Middlebox drops AccECN option and client
+// reverts to ACE flags only
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+sysctl -q net.ipv4.tcp_ecn_option_beacon=1
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.05 < [ect0] EAP. 1:1001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] EA. 1:1(0) ack 1001 <ECN e1b 1 ceb 0 e0b 1001,nop>
+   +0 read(4, ..., 1000) = 1000
+
++0.05 < [ect0] EAP. 1:1001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] EA. 1:1(0) ack 1001 <ECN e1b 1 ceb 0 e0b 2001,nop,nop,nop,sack 1:1001>
+
++0.05 < [ect0] EAP. 1:1001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] EA. 1:1(0) ack 1001 <nop,nop,sack 1:1001>
+
++0.05 < [ect0] EAP. 1001:2001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] EA. 1:1(0) ack 2001
+   +0 read(4, ..., 1000) = 1000
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_lost.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_lost.pkt
new file mode 100644
index 000000000000..f5839c2e682d
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_lost.pkt
@@ -0,0 +1,38 @@
+// Client negotiates AccECN and starts sending
+// AccECN option in last ACK and data segments
+// Middlebox accepts AccECN option but some packets
+// are lost due to congestion. Client should
+// continue to send AccECN option
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.102 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.1  < [ect0] SW. 0:0(0) ack 1 win 32767 <mss 1024,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] A. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
+// Send
++0.01 write(4, ..., 3000) = 3000
++.002 > [ect0] .5 1:1013(1012) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++.002 > [ect0] P.5 1013:2025(1012) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++.002 > [ect0] P.5 2025:3001(976) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
+// First two segments were lost due to congestion as SACK was
+// received acknowledging 3rd segment
++0.1 < [ect0] .5 1:1(0) ack 1 win 264 <ECN e1b 1 ceb 0 e0b 977,nop,nop,nop,sack 2025:3001>
+
+// Since data with option was SACKed, we can
+// continue to use AccECN option for the rest of
+// the connection. This one is a rexmt
++.02~+0.5 > [ect0] .5 1:1013(1012) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++0.1 < [ect0] .5 1:1(0) ack 3001 win 264 <ECN e1b 1 ceb 0 e0b 3000,nop>
+
+// Send new data, it should contain AccECN option
++0.01 write(4, ..., 2000) = 2000
++.002 > [ect0] .5 3001:4013(1012) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++.002 > [ect0] P.5 4013:5001(988) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_clientside_disabled.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_clientside_disabled.pkt
new file mode 100644
index 000000000000..c00b36d6a833
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_clientside_disabled.pkt
@@ -0,0 +1,12 @@
+// AccECN sysctl server-side only, no ECN/AccECN
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=5
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < S. 0:0(0) ack 1 win 32767 <mss 1460,sackOK,nop,nop,nop,wscale 8>
++.002 > . 1:1(0) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_close_local_close_then_remote_fin.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_close_local_close_then_remote_fin.pkt
new file mode 100644
index 000000000000..f9c27f39f354
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_close_local_close_then_remote_fin.pkt
@@ -0,0 +1,25 @@
+// Test basic connection teardown where local process closes first:
+// the local process calls close() first, so we send a FIN, and receive an ACK.
+// Then we receive a FIN and ACK it.
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+ +.01...0.011 connect(3, ..., ...) = 0
+   +0 > [noecn] SEWA 0:0(0) <...>
+   +0 < [ect1] SW. 0:0(0) ack 1 win 32768 <mss 1000,nop,wscale 6,nop,nop,sackOK>
+   +0 > [ect0] EW. 1:1(0) ack 1
+
+   +0 write(3, ..., 1000) = 1000
+   +0 > [ect0] P5. 1:1001(1000) ack 1
+   +0 < [ect0] .5 1:1(0) ack 1001 win 257
+
+   +0 close(3) = 0
+   +0 > [ect0] F5. 1001:1001(0) ack 1
+   +0 < [ect0] .5 1:1(0) ack 1002 win 257
+
+   +0 < [ect0] F5. 1:1(0) ack 1002 win 257
+   +0 > [ect0] . 1002:1002(0) ack 2
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_2ndlargeack.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_2ndlargeack.pkt
new file mode 100644
index 000000000000..6d771234124a
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_2ndlargeack.pkt
@@ -0,0 +1,25 @@
+// Test a large ACK (> ACE field max)
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 14600) = 14600
++.002 > [ect0] P.5 1:14601(14600) ack 1
++0.05 < [ect0] .5 1:1(0) ack 1461 win 264
++0.05 < [ect0] .5 1:1(0) ack 14601 win 264
+
++0.01 %{ assert tcpi_delivered_ce == 8, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_falseoverflow_detect.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_falseoverflow_detect.pkt
new file mode 100644
index 000000000000..76384f52b021
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_falseoverflow_detect.pkt
@@ -0,0 +1,31 @@
+// Test false overflow detection with option used to rule out overflow
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
+// Stop sending option to allow easier testing
++0 `sysctl -q net.ipv4.tcp_ecn_option=0`
+
++0.002 write(4, ..., 14600) = 14600
++.002 > [ect0] P.5 1:14601(14600) ack 1
+
++0.05 < [ect0] .5 1:1(0) ack 1460 win 264 <ECN e0b 1461 ceb 0 e1b 1,nop>
++0.05 < [ect0] .5 1:1(0) ack 14601 win 264 <ECN e0b 14601 ceb 0 e1b 1,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 0, tcpi_delivered_ce
+assert tcpi_delivered_e0_bytes == 14600, tcpi_delivered_e0_bytes
+}%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack.pkt
new file mode 100644
index 000000000000..8bce5dce35a2
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack.pkt
@@ -0,0 +1,24 @@
+// Test a large ACK (> ACE field max)
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 14600) = 14600
++.002 > [ect0] P.5 1:14601(14600) ack 1
++0.05 < [ect0] .5 1:1(0) ack 14601 win 264
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack2.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack2.pkt
new file mode 100644
index 000000000000..5f2b147214f4
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack2.pkt
@@ -0,0 +1,25 @@
+// Test a large ACK (> ACE field max)
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 14600) = 14600
++.002 > [ect0] P.5 1:14601(14600) ack 1
+  // Fake CE
++0.05 < [ect0] .6 1:1(0) ack 14601 win 264
+
++0.01 %{ assert tcpi_delivered_ce == 1, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_maxack.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_maxack.pkt
new file mode 100644
index 000000000000..fd07bdc14f37
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_maxack.pkt
@@ -0,0 +1,25 @@
+// Test a large ACK (at ACE field max delta)
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 14600) = 14600
++.002 > [ect0] P.5 1:14601(14600) ack 1
+  // Fake CE
++0.05 < [ect0] .4 1:1(0) ack 14601 win 264
+
++0.01 %{ assert tcpi_delivered_ce == 7, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_updates.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_updates.pkt
new file mode 100644
index 000000000000..cb1e70ff2d26
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_updates.pkt
@@ -0,0 +1,70 @@
+// Test basic AccECN CEP/CEB/E0B/E1B functionality & CEP wrapping
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{
+assert tcpi_delivered_ce == 0, tcpi_delivered_ce
+assert tcpi_delivered_ce_bytes == 0, tcpi_delivered_ce_bytes
+}%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+  // Fake CE
++0.05 < [ect0] WA. 1:1(0) ack 1001 win 264 <ECN e0b 1 ceb 1000 e1b 1,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 1, tcpi_delivered_ce
+assert tcpi_delivered_ce_bytes == 1000, tcpi_delivered_ce_bytes
+}%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1001:2001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+  // Fake ect0
++0.05 < [ect0] WA. 1:1(0) ack 2001 win 264 <ECN e0b 1001 ceb 1000 e1b 1,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 1, tcpi_delivered_ce
+assert tcpi_delivered_e0_bytes == 1000, tcpi_delivered_e0_bytes
+}%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 2001:3001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+  // Fake ce
++0.05 < [ect0] EWA. 1:1(0) ack 3001 win 264 <ECN e0b 1001 ceb 2000 e1b 1,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 2, tcpi_delivered_ce
+assert tcpi_delivered_ce_bytes == 2000, tcpi_delivered_ce_bytes
+}%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 3001:4001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+  // Fake ect1
++0.05 < [ect0] EWA. 1:1(0) ack 4001 win 264 <ECN e0b 1001 ceb 2000 e1b 1001,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 2, tcpi_delivered_ce
+assert tcpi_delivered_e1_bytes == 1000, tcpi_delivered_e1_bytes
+}%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 4001:5001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+  // Fake ce
++0.05 < [ect0] . 1:1(0) ack 5001 win 264 <ECN e0b 1001 ceb 3000 e1b 1001,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 3, tcpi_delivered_ce
+assert tcpi_delivered_ce_bytes == 3000, tcpi_delivered_ce_bytes
+}%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_ecn3.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_ecn3.pkt
new file mode 100644
index 000000000000..6627c7bb2d26
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_ecn3.pkt
@@ -0,0 +1,12 @@
+// Test that tcp_ecn=4 uses RFC3168 ECN for SYN
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=4
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.05 connect(4, ..., ...) = 0
+
++.002 > SEW 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < S. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > . 1:1(0) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_ecn_field_updates_opt.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_ecn_field_updates_opt.pkt
new file mode 100644
index 000000000000..51879477bb50
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_ecn_field_updates_opt.pkt
@@ -0,0 +1,35 @@
+// Test basic AccECN CEP/CEB/E0B/E1B functionality & CEP wrapping
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.05 < [ce] EAP. 1:1001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] WA. 1:1(0) ack 1001 <ECN e1b 1 ceb 1000 e0b 1,nop>
+   +0 read(4, ..., 1000) = 1000
+
++0.05 < [ect0] EAP. 1001:2001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] WA. 1:1(0) ack 2001 <ECN e1b 1 ceb 1000 e0b 1001,nop>
+   +0 read(4, ..., 1000) = 1000
+
++0.05 < [ce] EAP. 2001:3001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] EWA. 1:1(0) ack 3001 <ECN e1b 1 ceb 2000 e0b 1001,nop>
+   +0 read(4, ..., 1000) = 1000
+
++0.05 < [ect1] EAP. 3001:4001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] EWA. 1:1(0) ack 4001 <ECN e1b 1001 ceb 2000 e0b 1001,nop>
+   +0 read(4, ..., 1000) = 1000
+
++0.05 < [ce] EAP. 4001:5001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] . 1:1(0) ack 5001 <ECN e1b 1001 ceb 3000 e0b 1001,nop>
+   +0 read(4, ..., 1000) = 1000
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_ipflags_drop.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_ipflags_drop.pkt
new file mode 100644
index 000000000000..0c72fa4a1251
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_ipflags_drop.pkt
@@ -0,0 +1,14 @@
+// Test IP flags drop
+--tolerance_usecs=50000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 1.1 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++.02 ~ +1.1 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < S. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] . 1:1(0) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_listen_opt_drop.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_listen_opt_drop.pkt
new file mode 100644
index 000000000000..171f9433e55f
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_listen_opt_drop.pkt
@@ -0,0 +1,16 @@
+// SYN/ACK option drop test
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.02 ~+2 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.02 ~+5 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.02 ~+8 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_ack_drop.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_ack_drop.pkt
new file mode 100644
index 000000000000..0f65cf56cd2b
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_ack_drop.pkt
@@ -0,0 +1,28 @@
+// Test that SYN-ACK with ACE flags and without
+// ACE flags got dropped. Although we disable ECN,
+// we shouldn't consider this as blackholed as
+// these are dropped due to congestion
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
++0 < [noecn] SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+
+// Retransmit SYN-ACK without option
++1~+1.1 > [noecn] SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// SYN-ACK maybe getting blackholed, disable ECN
++2~+2.2 > [noecn] S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++4~+4.4 > [noecn] S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// Received an ACK after sending 3rd retransmission, not a blackhole
++0.1 < [noecn] . 1:1(0) ack 1 win 320
++.002 accept(3, ..., ...) = 4
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_drop.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_drop.pkt
new file mode 100644
index 000000000000..343181633980
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_drop.pkt
@@ -0,0 +1,18 @@
+// Test that SYN with ACE flags and without
+// ACE flags got dropped. Although we disable
+// ECN, we shouldn't consider this as blackholed
+// as these are dropped due to congestion
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 3.1 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++.02~+1.1 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++.02~+1.1 > [noecn] S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++.02~+1.1 > [noecn] S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.1 < [noecn] S. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0~+0.01 > [noecn] . 1:1(0) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_bleach.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_bleach.pkt
new file mode 100644
index 000000000000..37dabc4603c8
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_bleach.pkt
@@ -0,0 +1,23 @@
+// Test AccECN flags bleach
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] . 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [noecn] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++0.05 < [ect0] EAP. 1:1(0) ack 1001 win 320
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_connect.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_connect.pkt
new file mode 100644
index 000000000000..5b14892fda51
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_connect.pkt
@@ -0,0 +1,23 @@
+// Test basic AccECN negotiation
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++.05 < [ect0] EAP. 1:1(0) ack 1001 win 256 <ECN e0b 1001 ceb 0 e1b 0,nop>
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1001:2001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_listen.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_listen.pkt
new file mode 100644
index 000000000000..25f7cb2feb25
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_listen.pkt
@@ -0,0 +1,26 @@
+// Test basic AccECN negotiation
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++0.05 < [ect0] EAP. 1:1(0) ack 1001 win 320
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1001:2001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_noopt_connect.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_noopt_connect.pkt
new file mode 100644
index 000000000000..50e08c492a69
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_noopt_connect.pkt
@@ -0,0 +1,23 @@
+// Test basic AccECN negotiation without option
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < SW. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1
++.05 < [ect0] EAP. 1:1(0) ack 1001 win 256
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1001:2001(1000) ack 1
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_optenable.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_optenable.pkt
new file mode 100644
index 000000000000..2904f1ba9975
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_optenable.pkt
@@ -0,0 +1,23 @@
+// Test basic AccECN negotiation, late option enable
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < SW. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1
++.05 < [ect0] EAP. 1:1(0) ack 1001 win 256 <ECN e0b 1001 ceb 0 e1b 1,nop>
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1001:2001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_no_ecn_after_accecn.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_no_ecn_after_accecn.pkt
new file mode 100644
index 000000000000..64e0fc1c1f14
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_no_ecn_after_accecn.pkt
@@ -0,0 +1,20 @@
+// Test client behavior on receiving a non ECN SYN-ACK
+// after receiving an AccECN SYN-ACK and moving to
+// ESTABLISHED state
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
+// Receive an AccECN SYN-ACK and move to ESTABLISHED
++0.05 < [noecn] SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
+// Receive a non ECN SYN-ACK and send a challenge ACK with ACE feedback
++0.1 < [noecn] S. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_noopt.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_noopt.pkt
new file mode 100644
index 000000000000..f407c629a3f7
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_noopt.pkt
@@ -0,0 +1,27 @@
+// Test basic AccECN negotiation with option off using sysctl
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1
++0.05 < [ect0] EAP. 1:1(0) ack 1001 win 320
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1001:2001(1000) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_noprogress.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_noprogress.pkt
new file mode 100644
index 000000000000..32454e7187f9
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_noprogress.pkt
@@ -0,0 +1,27 @@
+// Test no progress filtering
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+  // Fake CE and claim no progress
++0.05 < [ect0] WA. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 1000 e1b 1,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 0, tcpi_delivered_ce
+assert tcpi_delivered_ce_bytes == 0, tcpi_delivered_ce_bytes
+}%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_notecn_then_accecn_syn.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_notecn_then_accecn_syn.pkt
new file mode 100644
index 000000000000..6597d5f2d778
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_notecn_then_accecn_syn.pkt
@@ -0,0 +1,28 @@
+// Test that SYN-ACK with ACE flags and without
+// ACE flags got dropped. Although we disable ECN,
+// we shouldn't consider this as blackholed as
+// these are dropped due to congestion
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
++0 < [noecn] S 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// Retransmit SYN
++0.1 < [ect0] SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
++0.1 < [noecn] . 1:1(0) ack 1 win 320
++.002 accept(3, ..., ...) = 4
+
+// Write with AccECN option but with ip-noecn since we received one SYN with ACE=0
++0.01 write(4, ..., 100) = 100
++.002 > [noecn] P. 1:101(100) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_fallback.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_fallback.pkt
new file mode 100644
index 000000000000..0f97dfcfa82d
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_fallback.pkt
@@ -0,0 +1,18 @@
+// Test RFC3168 fallback when sysctl asks for AccECN
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEW 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SE. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < . 1:1(0) ack 1 win 320
++.002 accept(3, ..., ...) = 4
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] P. 1:1001(1000) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_rfc3168.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_rfc3168.pkt
new file mode 100644
index 000000000000..9baffdd66fe5
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_rfc3168.pkt
@@ -0,0 +1,18 @@
+// Test RFC3168 ECN when sysctl asks for RFC3168 ECN
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=1
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEW 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SE. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < . 1:1(0) ack 1 win 320
++.002 accept(3, ..., ...) = 4
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] P. 1:1001(1000) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab.pkt
new file mode 100644
index 000000000000..3fc56f9c6a6f
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab.pkt
@@ -0,0 +1,28 @@
+// Test SACK space grab to fit AccECN option
+--tcp_ts_tick_usecs=1000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++.01 < [ect1] EAP. 1001:2001(1000) ack 1 win 264
++0.002 > [ect0] EA. 1:1(0) ack 1 <ECN e1b 1001 ceb 0 e0b 1,nop,nop,nop,sack 1001:2001>
++.01 < [ect0] EAP. 3001:4001(1000) ack 1 win 264
++0.002 > [ect0] EA. 1:1(0) ack 1 <ECN e1b 1001 ceb 0 e0b 1001,nop,nop,nop,sack 3001:4001 1001:2001>
++.01 < [ce] EAP. 5001:6001(1000) ack 1 win 264
++0.002 > [ect0] WA. 1:1(0) ack 1 <ECN e1b 1001 ceb 1000 e0b 1001,nop,nop,nop,sack 5001:6001 3001:4001 1001:2001>
+// DSACK works?
++.01 < [ect0] EAP. 5001:6001(1000) ack 1 win 264
++0.002 > [ect0] WA. 1:1(0) ack 1 <ECN e1b 1001 ceb 1000 e0b 2001,nop,nop,nop,sack 5001:6001 5001:6001 3001:4001>
++.01 < [ect1] EAP. 6001:7001(1000) ack 1 win 264
++0.002 > [ect0] WA. 1:1(0) ack 1 <ECN e1b 2001 ceb 1000 e0b 2001,nop,nop,nop,sack 5001:7001 3001:4001 1001:2001>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab_with_ts.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab_with_ts.pkt
new file mode 100644
index 000000000000..1c075b5d81ae
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab_with_ts.pkt
@@ -0,0 +1,39 @@
+// Test SACK space grab to fit AccECN option
+--tcp_ts_tick_usecs=1000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,sackOK,TS val 1 ecr 0,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,sackOK,TS val 100 ecr 1,ECN e1b 1 ceb 0 e0b 1,nop,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <nop,nop,TS val 2 ecr 100,ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
+// One SACK block should allow all 3 AccECN fields:
++.01 < [ect1] EAP. 1001:2001(1000) ack 1 win 264 <nop,nop,TS val 3 ecr 100>
++0.002 > [ect0] EA. 1:1(0) ack 1 <nop,nop,TS val 160 ecr 2,ECN e1b 1001 ceb 0 e0b 1,nop,nop,nop,sack 1001:2001>
+
+// Two SACK blocks should fit w/ AccECN if we only need to use 2 AccECN fields: check ect1 arriving.
++.01 < [ect1] EAP. 3001:4001(1000) ack 1 win 264 <nop,nop,TS val 4 ecr 100>
++0.002 > [ect0] EA. 1:1(0) ack 1 <nop,nop,TS val 172 ecr 2,ECN e1b 2001 ceb 0,nop,nop,sack 3001:4001 1001:2001>
+
+// Two SACK blocks should fit w/ AccECN if we only need to use 2 AccECN fields: check CE arriving.
++.01 < [ce] EAP. 5001:6001(1000) ack 1 win 264 <nop,nop,TS val 5 ecr 100>
++0.002 > [ect0] WA. 1:1(0) ack 1 <nop,nop,TS val 184 ecr 2,ECN e1b 2001 ceb 1000,nop,nop,sack 5001:6001 3001:4001>
+
+// Check that DSACK works, using 2 SACK blocks in total, if we only need to use 2 AccECN fields: check ect1 arriving.
++.01 < [ect1] EAP. 5001:6001(1000) ack 1 win 264 <nop,nop,TS val 5 ecr 100>
++0.002 > [ect0] WA. 1:1(0) ack 1 <nop,nop,TS val 196 ecr 2,ECN e1b 3001 ceb 1000,nop,nop,sack 5001:6001 5001:6001>
+
+// Check the case where the AccECN option doesn't fit, because sending ect0
+// with order 1 would rquire 3 AccECN fields,
+// and TS (12 bytes) + 2 SACK blocks (20 bytes) + 3 AccECN fields (2 + 3*3 bytes) > 40 bytes.
+// That's OK; Linux TCP AccECN is optimized for the ECT1 case, not ECT0.
++.01 < [ect0] EAP. 6001:7001(1000) ack 1 win 264 <nop,nop,TS val 5 ecr 100>
++0.002 > [ect0] WA. 1:1(0) ack 1 <nop,nop,TS val 204 ecr 2,nop,nop,sack 5001:7001 3001:4001 1001:2001>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled1.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled1.pkt
new file mode 100644
index 000000000000..6b88ab78bfce
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled1.pkt
@@ -0,0 +1,20 @@
+// Test against classic ECN server
+// Not-ECT on SYN and server sets 1|0|1 (AE is unused for classic ECN)
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] SEA. 0:0(0) ack 1 win 32767 <mss 1460,sackOK,TS val 700 ecr 100,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <nop, nop, TS val 200 ecr 700>
+
++0 write(4, ..., 100) = 100
++.002 > [ect0] P.5 1:101(100) ack 1 <nop,nop,TS val 300 ecr 700>
++0 close(4) = 0
+
++.002 > [ect0] F.5 101:101(0) ack 1 <nop,nop,TS val 400 ecr 700>
++0.1 < [noecn] R. 1:1(0) ack 102 win 4242
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled2.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled2.pkt
new file mode 100644
index 000000000000..d24ada008ece
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled2.pkt
@@ -0,0 +1,20 @@
+// Test against classic ECN server
+// Not-ECT on SYN and server sets 0|0|1
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] SE. 0:0(0) ack 1 win 32767 <mss 1460,sackOK,TS val 700 ecr 100,nop,wscale 8>
++.002 > [noecn] . 1:1(0) ack 1 <nop, nop, TS val 200 ecr 700>
+
++0 write(4, ..., 100) = 100
++.002 > [ect0] P. 1:101(100) ack 1 <nop,nop,TS val 300 ecr 700>
++0 close(4) = 0
+
++0 > [noecn] F. 101:101(0) ack 1 <...>
++0.1 < R. 1:1(0) ack 102 win 4242
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_broken.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_broken.pkt
new file mode 100644
index 000000000000..a20d7e890ee1
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_broken.pkt
@@ -0,0 +1,19 @@
+// Test against broken server (1|1|1)
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] SEWA. 0:0(0) ack 1 win 32767 <mss 1460,sackOK,TS val 700 ecr 100,nop,wscale 8>
++.002 > [noecn] . 1:1(0) ack 1 <nop, nop, TS val 200 ecr 700>
+
++0 write(4, ..., 100) = 100
++.002 > [noecn] P. 1:101(100) ack 1 <nop,nop,TS val 300 ecr 700>
++0 close(4) = 0
+
++.002 > [noecn] F. 101:101(0) ack 1 <...>
++0.1 < [noecn] R. 1:1(0) ack 102 win 4242
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_ecn_disabled.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_ecn_disabled.pkt
new file mode 100644
index 000000000000..428255bedab7
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_ecn_disabled.pkt
@@ -0,0 +1,19 @@
+// Test against Non ECN server (0|0|0)
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] S. 0:0(0) ack 1 win 32767 <mss 1460,sackOK,TS val 700 ecr 100,nop,wscale 8>
++.002 > [noecn] . 1:1(0) ack 1 <nop, nop, TS val 200 ecr 700>
+
++0 write(4, ..., 100) = 100
++.002 > [noecn] P. 1:101(100) ack 1 <nop,nop,TS val 300 ecr 700>
++0 close(4) = 0
+
++.002 > [noecn] F. 101:101(0) ack 1 <nop,nop,TS val 400 ecr 700>
++0.1 < [noecn] R. 1:1(0) ack 102 win 4242
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_only.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_only.pkt
new file mode 100644
index 000000000000..e9a5a0d3677c
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_only.pkt
@@ -0,0 +1,18 @@
+// Test AccECN with sysctl set to server-side only
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=5
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_acked_after_retransmit.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_acked_after_retransmit.pkt
new file mode 100644
index 000000000000..412fa903105c
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_acked_after_retransmit.pkt
@@ -0,0 +1,18 @@
+// Test that SYN with ACE flags was Acked
+// after 2nd retransmission. In this case,
+// since we got SYN-ACK that supports Accurate
+// ECN, we consider this as successful negotiation
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 2.1 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++1~+1.1 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++1~+1.1 > [noecn] S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
+
++0.1 < [noecn] SW. 0:0(0) ack 1 win 32767 <mss 1016,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0~+0.01 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_drop.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_drop.pkt
new file mode 100644
index 000000000000..4622754a2270
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_drop.pkt
@@ -0,0 +1,16 @@
+// Test that SYN with ACE flags got dropped
+// We retry one more time with ACE and then
+// fallback to disabled ECN
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 2.1 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++1~+1.1 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++1~+1.1 > [noecn] S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.1 < [noecn] S. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0~+0.01 > [noecn] . 1:1(0) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_acked_after_retransmit.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_acked_after_retransmit.pkt
new file mode 100644
index 000000000000..ee15f108cafe
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_acked_after_retransmit.pkt
@@ -0,0 +1,27 @@
+// Test that SYN-ACK with ACE flags was Acked
+// after 2nd retransmission. In this case,
+// since we got the last ACK that supports Accurate
+// ECN, we consider this as successful negotiation
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
++0 < [noecn] SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+
+// Retransmit SYN-ACK without option
++1~+1.1 > [noecn] SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// SYN-ACK maybe getting blackholed, disable ECN
++2~+2.2 > [noecn] S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// Received an ACK with ACE flags, state should be set to negotiation succeeded
++0.1 < [noecn] W. 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_drop.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_drop.pkt
new file mode 100644
index 000000000000..3807e7fafafb
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_drop.pkt
@@ -0,0 +1,27 @@
+// Test that SYN-ACK with ACE flags got dropped
+// We retry one more time with ACE and then
+// fallback to disabled ECN
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
++0 < [noecn] SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+
+// Retransmit SYN-ACK without option
++1~+1.1 > [noecn] SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// SYN-ACK maybe getting blackholed, disable ECN
++2~+2.2 > [noecn] S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// Received an ACK with no ACE flags, state should be set to blackholed
++0.1 < [noecn] . 1:1(0) ack 1 win 320
++0 accept(3, ..., ...) = 4
+
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ce.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ce.pkt
new file mode 100644
index 000000000000..dc83f7a18180
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ce.pkt
@@ -0,0 +1,13 @@
+// Test AccECN ECN field reflector in SYNACK
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < [ce] SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SWA. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect0.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect0.pkt
new file mode 100644
index 000000000000..e63a8d018c37
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect0.pkt
@@ -0,0 +1,13 @@
+// Test AccECN ECN field reflector in SYNACK
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < [ect0] SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SA. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect1.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect1.pkt
new file mode 100644
index 000000000000..23c0e43b3dbe
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect1.pkt
@@ -0,0 +1,13 @@
+// Test AccECN ECN field reflector in SYNACK
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < [ect1] SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SEW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce.pkt
new file mode 100644
index 000000000000..44add14c57f4
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce.pkt
@@ -0,0 +1,28 @@
+// Test SYNACK CE & received_ce update
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [ce] SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] WA. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 write(4, ..., 100) = 100
++.002 > [ect0] P.6 1:101(100) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++0.05 < [ect0] P.5 1:101(100) ack 101 win 256 <ECN e0b 101 ceb 0 e1b 1,nop>
++.002 > [ect0] .6  101:101(0) ack 101 <ECN e1b 1 ceb 0 e0b 101,nop>
+
++0.01 write(4, ..., 100) = 100
++.002 > [ect0] P.6 101:201(100) ack 101 <ECN e1b 1 ceb 0 e0b 101,nop>
+
++0.1  < [ect1] P.5 201:301(100) ack 201 win 256 <ECN e0b 101 ceb 0 e1b 1,nop>
++.002 > [ect0] .6 201:201(0) ack 101 <ECN e1b 101 ceb 0 e0b 101,nop,nop,nop,sack 201:301>
+
++0.01 < [ce] .6 401:501(100) ack 201 win 256 <ECN e0b 101 ceb 0 e1b 1,nop>
++.002 > [ect0] .7 201:201(0) ack 101 <ECN e1b 101 ceb 100 e0b 101,nop,nop,nop,sack 401:501 201:301>
+
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce_updates_delivered_ce.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce_updates_delivered_ce.pkt
new file mode 100644
index 000000000000..5fd77f466572
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce_updates_delivered_ce.pkt
@@ -0,0 +1,22 @@
+// Reflected SYNACK CE mark increases delivered_ce
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_fallback=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
++0.05 < SEWA 0:0(0) win 32767 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+// Fake ce for prev, ECT validator must be disabled for this to work
++0.05 < [ect0] WA. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 1, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect0.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect0.pkt
new file mode 100644
index 000000000000..f6ad1ea5c0c4
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect0.pkt
@@ -0,0 +1,24 @@
+// Test SYN=0 reflector
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [ect0] SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] A. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 write(4, ..., 100) = 100
++.002 > [ect0] P.5 1:101(100) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++0.05 < [ect0] P.5 1:1(0) ack 101 win 256 <ECN e0b 101 ceb 0 e1b 1,nop>
+
++0.01 < [ect0] P.5 1:101(100) ack 101 win 256 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] .5 101:101(0) ack 101 <ECN e1b 1 ceb 0 e0b 101,nop>
++0 read(4, ..., 100) = 100
+
++0 close(4) = 0
++0 > F.5 101:101(0) ack 101 <...>
++0.1 < R. 101:101(0) ack 102 win 4242
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect1.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect1.pkt
new file mode 100644
index 000000000000..7ecfc5fb9dbb
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect1.pkt
@@ -0,0 +1,24 @@
+// Test SYN=0 reflector
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [ect1] SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] EW. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 write(4, ..., 100) = 100
++.002 > [ect0] P.5 1:101(100) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++0.05 < [ect1] P.5 1:1(0) ack 101 win 256 <ECN e0b 101 ceb 0 e1b 1,nop>
+
++0.01 < [ect1] P.5 1:101(100) ack 101 win 256 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] .5 101:101(0) ack 101 <ECN e1b 101 ceb 0 e0b 1,nop>
++0 read(4, ..., 100) = 100
+
++0 close(4) = 0
++0 > F5. 101:101(0) ack 101 <...>
++0.1 < R. 101:101(0) ack 102 win 4242
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rexmit.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rexmit.pkt
new file mode 100644
index 000000000000..9e0959782ef5
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rexmit.pkt
@@ -0,0 +1,15 @@
+// Test 3rd ACK flags when SYN-ACK is rexmitted
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.05 < SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rxmt.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rxmt.pkt
new file mode 100644
index 000000000000..a5a41633af07
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rxmt.pkt
@@ -0,0 +1,25 @@
+// Test that we retransmit SYN-ACK with ACE and without
+// AccECN options after
+// SYN-ACK was lost and TCP moved to TCPS_SYN_RECEIVED
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
++0 < [noecn] SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+
+// Retransmit SYN-ACK without option
++1~+1.1 > [noecn] SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.1 < [noecn] W. 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
+// We try to write with AccECN option
++0.01 write(4, ..., 100) = 100
++.002 > [ect0] P5. 1:101(100) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_tsnoprogress.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_tsnoprogress.pkt
new file mode 100644
index 000000000000..f3fe2f098966
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_tsnoprogress.pkt
@@ -0,0 +1,26 @@
+// Test TS progress filtering
+--tcp_ts_tick_usecs=1000
+--tolerance_usecs=7000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,sackOK,TS val 1 ecr 0,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,sackOK,TS val 10 ecr 1,ECN e1b 1 ceb 0 e0b 1,nop,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <nop,nop,TS val 2 ecr 10>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <nop,nop,TS val 83 ecr 2>
+  // Fake CE and claim no progress
++0.05 < [ect0] WA. 1:1(0) ack 1 win 264 <nop,nop,TS val 2 ecr 83>
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_tsprogress.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_tsprogress.pkt
new file mode 100644
index 000000000000..1446799d2481
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_tsprogress.pkt
@@ -0,0 +1,25 @@
+// Test TS progress filtering
+--tcp_ts_tick_usecs=1000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,sackOK,TS val 1 ecr 0,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,sackOK,TS val 10 ecr 1,ECN e1b 1 ceb 0 e0b 1,nop,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <nop,nop,TS val 2 ecr 10>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <nop,nop,TS val 83 ecr 2>
+  // Fake CE and claim no progress
++0.05 < [ect0] WA. 1:1(0) ack 1 win 264 <nop,nop,TS val 3 ecr 83>
+
++0.01 %{ assert tcpi_delivered_ce == 1, tcpi_delivered_ce }%
-- 
2.34.1


