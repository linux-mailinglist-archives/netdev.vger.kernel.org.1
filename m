Return-Path: <netdev+bounces-255515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCeXIGGBfmlQaAIAu9opvQ
	(envelope-from <netdev+bounces-255515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:25:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BB1C4205
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8334F302DB57
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 22:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B3F38A9AD;
	Sat, 31 Jan 2026 22:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="i5bb08F3"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011037.outbound.protection.outlook.com [40.107.130.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631DB38A734;
	Sat, 31 Jan 2026 22:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769898327; cv=fail; b=L/BXo9VcM/efYwOE0E/qG2VtVdoAfiUNK2UwP9/RE1Tvf/KvP/M8wyPO5ShkiZ5C/0bnQBUQ3h7foT6VXzNpuroTnHOdUOE1bsHLr+EjmxFDn+FiArIMEQmwZ4nS9iYzDlVkGkjzp3DkdujTynNA0FbLuuqXv2N9bDXwWdwlvvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769898327; c=relaxed/simple;
	bh=0ZwQVvw7wtL9PaUnN1IJfmaR1FgUT8fY4NmzrP6+mz8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Lmo5lzfpxkm2M2Ejks4AhfVvayne0UN8AFyXxe9N7PK2nam5k0YvLKPhmp5/onb1HiFBK6He+6ig3acAUEAiHIM61StEGWQ3hGqg5qW3NNzZV45NoR7s6sIkYd0tBtuMl6cLlZAZreGigjQY4uefTbomjRFqTzd1ARA1RimJ1mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=i5bb08F3; arc=fail smtp.client-ip=40.107.130.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deyDGX4oFIK4lZutB+44/sXXw5AS/WJ+q9Y+JturaI7aphBk5Av7zm0DjKcKsQjI3glvhL/ixN5fF1zzvn+3FJCTc89sQPQCaLyRCdvcJzywjCJoH6hlKczfWw7e7seHJLLm268RCnwAb+uHpZ731YLl7dYSBJiCSqT8uh7CQSkac7EPTOE3xXci2cVhT2mRCXC3PSrVHojak0uCCLBhvhIpok+oyq9hpHaYQKcisQaPGFSX1GTY2o4Ao7wz6Opg163szgZM6RhTf7Zn3Tz0fiah7iIy4SxDTKLcwliJhpSzuD5EFie0W2TTvI7TjSPRjQC6qim+KQ6OWv+nnlGGvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkl9639b5LyVIZCD0+JGxcuRNYyGll688v8nkW1uGiw=;
 b=M/EmIe5Kejd4rYE8hJXjzGjdVGO1Uqk6BDd7v0qYscBAUMNwYyLAOAVbx0QlqYbHGlHF5OCyR3ev3+vtoN0xyYB7WqfAATfRttN/ETc+G4GOjOHCuXpUTkZkHy3yiL+W2UKTKr3ZbOjjXu0kSqAb7+5KTzFQd/f2b7OwssDaXJ6OSxrqXKrOa7SeWIQD058yJVu9zgDkpJE7Xk2nHGHHO62jnQmnuTl/vrt1jZHnTjEddiO/v8+2gycB1uQqNwBv+FzT15+uL3KOTwcKOenPXCys6sPWyN2+WLVFa0T7VlIg+7n48uezWhgVeo4xBOUQLrRAh/6N4e3HmHef5P0APA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkl9639b5LyVIZCD0+JGxcuRNYyGll688v8nkW1uGiw=;
 b=i5bb08F34Wom3A5O+MExBwrH1mCmLzpB7uLhc5iVHAc3LwBhDzFgpRwwbCFaAiFlHdjg6b+/Bp+SJTL87LX63heouUzII3XhKPPz0wHx9GXgNJWlki5a3QYVCgOn1bzpmvBrJXWzAV93RfGyOAAF1OHVXYh3/BEdEagExENGvBYloMkCeTK0BbFwcmPY7lfBfOMNO+ZzVE3PLgpK9K+CNJinun4djvFIq8pcD0pcZabYRgqFKjE4l3kDoyH/x4rKBD7Ny7xl3yZxcwBo2iS7Y4xoxyx1d+VxTk2Fty1zLtY1XO/JgKszZ4Q3NIbph161eTX+gDHbFDFsk8A4YGYZqA==
Received: from DU2PR04CA0060.eurprd04.prod.outlook.com (2603:10a6:10:234::35)
 by DU2PR07MB9486.eurprd07.prod.outlook.com (2603:10a6:10:493::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Sat, 31 Jan
 2026 22:25:18 +0000
Received: from DB5PEPF00014B8E.eurprd02.prod.outlook.com
 (2603:10a6:10:234:cafe::37) by DU2PR04CA0060.outlook.office365.com
 (2603:10a6:10:234::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Sat,
 31 Jan 2026 22:25:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB5PEPF00014B8E.mail.protection.outlook.com (10.167.8.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Sat, 31 Jan 2026 22:25:18 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 066B223906;
	Sun,  1 Feb 2026 00:25:16 +0200 (EET)
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
Subject: [PATCH v13 net-next 00/15] AccECN protocol case handling series
Date: Sat, 31 Jan 2026 23:25:00 +0100
Message-Id: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8E:EE_|DU2PR07MB9486:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d81e15c-718d-4f5e-964a-08de61179d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020|18082099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkRMSVorRXE1bEJqUFpqNWM2MXh4cFJGUXhnSkdHVWtOamRuVTZIM2IzLzNh?=
 =?utf-8?B?YmFxRjJZTlFCRkNIcW05T2pTQXpqRkw1K2JjdThPalB3U0lVZ1g3U3FkbUtU?=
 =?utf-8?B?QzdhVmcwVlY4ZzRiMVBpaFZuVXNLbm1kb21saSsyUmgzcStIQWdqMXlGemM4?=
 =?utf-8?B?ZUVVTCt4djlpOGlrTDczRnRQaW5kbDFkcERGWHZkaWkxVUF6UXJPYjA0aUJz?=
 =?utf-8?B?NzZWMjkxeVBGektGdVNqQlFDSHFEVFVyRW42UzBmSWJyVTlXalFRVExOeFc5?=
 =?utf-8?B?dzlDQzBUNnJKMXJTWkhNRWNVN3lwNXE0YThadWprWW8waUdCdGpoMWZiYmJk?=
 =?utf-8?B?eHZiaVRxZnNRQTJqSkxudGt6VlZlRW5qQ1RlT2JmYzhlc2U4UnQ4NXRyTXpX?=
 =?utf-8?B?ZzUzWnk3ZVQ3TUl5aG9ub0FNblBtK2h4Q05iR1FwOUNLR29hYzJ2cWtDK2d2?=
 =?utf-8?B?WG1GNnpnYVZKdmw3T3hGSGJWMktqYkxSUTl6SVFaVU5PeHRBaTVLR0ZSd2Ur?=
 =?utf-8?B?d3N3SVJoYm9ITldkS2NvMCs5VjJydlErSzY3NlhTN0ZxdFNsdVFQakhBVjV1?=
 =?utf-8?B?LzlzYXJZRkQ4SW1jUWxTOTlaZkcydHdSNEpnWEp4WFVZaHRDMVhaNzRFYlNU?=
 =?utf-8?B?UE5nM2o1RHFYdUc4aVcvdldhb3B5TWxCUXZwMUtJemIwTlJvT1Y5emxEVzdO?=
 =?utf-8?B?OTVWeW9LWUJpN3lIMjROK1lEdEFCdVdvdTJaWHBIYlhZKzZOTml0YTFHYk5H?=
 =?utf-8?B?bkpKQXNqTmNTWEFNbFljMzFOZ2lxN05wdThNL1pFMHMyUkczSnhNT0NEemZk?=
 =?utf-8?B?akF3ZGppSXVzdEpTRGVBRUNZVlQ5K0ovQnNWbndDaFlMY3pmdEh6N1h2V091?=
 =?utf-8?B?NkdFODlKR2R5ZnBkR1Y4NlFxbWdzTmZhMENxR0FhYnkrdXZERDNZODR1RVAv?=
 =?utf-8?B?ZGNaa2lwZy9qTGh4REkrZExrVUREREhBNVMvMXV3eUplYk8rRGFLWmZmS1Ru?=
 =?utf-8?B?L3h3UXczbjY0ZENUQUpFVDRxZkxnSy9OaERtZ1JQTzg3V3NjV2QvMER3WTFK?=
 =?utf-8?B?QTJucFRRWTFwNFhoZHRmOTNBaVFZN3RzSityK2loZUtvM2kvTGdPU290UVVa?=
 =?utf-8?B?cVBCT0Y2eGlxcFF0eDVvRmJ5UGNWVkE2UnBOSHBOWW4rNjFHaVRWZnBhcmNW?=
 =?utf-8?B?T216RHYxVHdENUN4Y0tsMXhQaUM5V1VvRnNJRjQyRlo3ZVV2VC9XNXZ1ZVFq?=
 =?utf-8?B?K0ZmZStXYTUwRm9DWENqdkJDd3dRYUF1bGc5a3pJVlIrMmtCbDNLV2N3V0NP?=
 =?utf-8?B?R2dZZGZVUFdteTBwK3k3QnlySWkyaUk5VGZZWUJsWkdSaHNVcGxpTVY0S1V1?=
 =?utf-8?B?MzBmeEtnd0JvaW1ycTd4V0NjL053eDNpVlVOM0RlaDMrdEgzM2JsTk9hZENv?=
 =?utf-8?B?NGdWeHVJcGhvTU5NdmtLQkY3YlNDUkM5Zkx1dHRwbElybXh3aXJ0emJ2L05S?=
 =?utf-8?B?ZHZGZnhlK3h5aTRBUUQ5cEZlVlpTaTVOdW8rSGlSclRsaW9nazBieGFVVjdn?=
 =?utf-8?B?by9CWnRhTTZIMFhmdGpZYVhUUFhBZk9FV1p1MmdUTmI4dU9pR1M3M1RHUUNP?=
 =?utf-8?B?Tjk0WUZzYStnRWlBd0hNU0pyeUJzdnF5Ny8rSHB4cGJGaFp6dUlOZ2FCNFAx?=
 =?utf-8?B?TTVBUTdtZ3RBQm9lR0toMzlaNWdaRWF6elZSV0puZGo3V0VKMThPdkpvZHhS?=
 =?utf-8?B?UitXSWlvSUxkT0l2Vm8xL3cvaGJ1YytXejBBUnl2aG4waS9tRjBQQTVBUXJG?=
 =?utf-8?B?anloNTl0VG10eUNXMU94UXNzdllpVXpWaUk2OHMxSmV5MXVpdTJRY25jUUVn?=
 =?utf-8?B?MTJIa1lrQnNpTSsxNEhnL3pUNVlDdk0rdkMrTW4vamtUZ3p2Ym1BOHFPaVcv?=
 =?utf-8?B?MjcxdmV2NDVMODc5TVYrSUpGNEVvaTJFVTU4QmVYT3ZBazVlSEt5enkrU1JL?=
 =?utf-8?B?WGdpV2JLODB4UWkxU0ZwZWkwbm1BMVFxZHZra0NHQ1ZTOVJ1YVltSXZLR1Jm?=
 =?utf-8?B?N0pCTWhaeGFNOUZpbnlpbDkrT3h2R296SWJEbStndXJRU3ZNTFBCN01VTytw?=
 =?utf-8?B?OVRvTDZVRzk1K1JjZW5MZTErS3ZTWktIUDMyNkcxSnNySFppUm1lWk00UlU3?=
 =?utf-8?B?UGllZ05Sd1NvWnRvcldmb24zUXdadWxDamFQeFY0L1VpMzRBTWl0cGd3eFkw?=
 =?utf-8?Q?N7aPF5N/FLgqVxmJD+nrv1mCeW8PerterZMGukwvBg=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020)(18082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WBNWq8t1Y/H/VvTAw+U0bNz5eNdXJ4Q6U1NDorAbFQcNLWBHdtvyD5WWUZfbJ3POVWD31bixK/GHf/Rgiw1F115miz2OKi0+bxoAwpDTkcoxt5DdBr+HCMmZC8JzRpfbyP6UBhMe/OLu5l549IUKCfopf1e2Wy+eQ1x/8LE8amwkHdQ0L1Aff/pjGhDfkmSefzni4qPSfA9bWzImM288sURCoHdnv9Xx7n5AUQLmnJWALRKmTG/4REVo5xcWZlw/mcCP19umSSfDAJPw+YY7nG0HCLY5Y4bxDol06wHiZIdnQZwzap/HdDyv9G0rupiJ6mxLP2oRTRadeXlcOiFy6F6TJZaen4hur3fc/rDUX1RfqeEeWY6lhwmBSYQw4+F1s4SAq3fj1GyaszQ8vLotvwjjSqdtjizxSmaIIMq2lreuh2TiP4Nu9kF4Ks09vA19
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 22:25:18.6210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d81e15c-718d-4f5e-964a-08de61179d79
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB9486
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255515-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D7BB1C4205
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Plesae find the v13 AccECN case handling patch series, which covers
several excpetional case handling of Accurate ECN spec (RFC9768),
adds new identifiers to be used by CC modules, adds ecn_delta into
rate_sample, and keeps the ACE counter for computation, etc.

This patch series is part of the full AccECN patch series, which is at
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Best regards,
Chia-Yu

---
v13:
- Add INET_ECN_dontxmit() to clear any previosly set ECT bits

v12:
- Update patch #10 to set AccECN error flag on request socket (Paolo Abeni <pabeni@redhat.com>)
- Remove new blank line at EOF of packetdrill test case in #15 (Jakub Kicinski <kuba@kernel.org>)

v11:
- Modify accecn_opt_sent_w_dsack to indicate valid prior D-SACK info in #12 (Eric Dumazet <edumazet@google.com>)
- Update timing in tcp_accecn_client_accecn_options_lost.pkt (Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>)

v10:
- Update commit message in #4, #6, #7 (Eric Dumazet <edumazet@google.com>)
- Set AccECN error flag on request itself via tcp_rsk() to avoid directly chaning on listener (Eric Dumazet <edumazet@google.com>)
- Mover new tcp_info fields at the end of struct (Eric Dumazet <edumazet@google.com>)
- Update timing in tcp_accecn_client_accecn_options_lost.pkt (Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>)

v9:
- Add 1 patch for 2-bit tcpi_ecn_mode and 24-bit tcpi_options by reducing bits used by tcpi_accecn_fail_mode and tcpi_accecn_opt_seen in tcp_info (Neal Cardwell <ncardwell@google.com>)
- Add missing comma in patch #3 (Jakub Kicinski <kuba@kernel.org>)
- Update patch message of patch #15

v8:
- Add apcketdrill patch #14 into this series (Paolo Abeni <pabeni@redhat.com> & Jakub Kicinski <kuba@kernel.org>)
- Add helper function in patch #10 (Paolo Abeni <pabeni@redhat.com>)

v7:
- Update comments in #3 (Paolo Abeni <pabeni@redhat.com>)
- Update comments and use synack_type TCP_SYNACK_RETRANS and num_timeout in #9. (Paolo Abeni <pabeni@redhat.com>)

v6:
- Update comment in #3 to highlight RX path is only used for virtio-net (Paolo Abeni <pabeni@redhat.com>)
- Rename TCP_CONG_WANTS_ECT_1 to TCP_CONG_ECT_1_NEGOTIATION to distiguish from TCP_CONG_ECT_1_ESTABLISH (Paolo Abeni <pabeni@redhat.com>)
- Move TCP_CONG_ECT_1_ESTABLISH in #6 to latter patch series (Paolo Abeni <pabeni@redhat.com>)
- Add new synack_type instead of moving the increment of num_retran in #9 (Paolo Abeni <pabeni@redhat.com>)
- Use new synack_type TCP_SYNACK_RETRANS and num_retrans for SYN/ACK retx fallbackk for AccECN in #10 (Paolo Abeni <pabeni@redhat.com>)
- Do not cast const struct into non-const in #11, and set AccECN fail mode after tcp_rtx_synack() (Paolo Abeni <pabeni@redhat.com>)

v5:
- Move previous #11 in v4 in latter patch after discussion with RFC author.
- Add #3 to update the comments for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN. (Parav Pandit <parav@nvidia.com>)
- Add gro self-test for TCP CWR flag in #4. (Eric Dumazet <edumazet@google.com>)
- Add fixes: tag into #7 (Paolo Abeni <pabeni@redhat.com>)
- Update commit message of #8 and if condition check (Paolo Abeni <pabeni@redhat.com>)
- Add empty line between variable declarations and code in #13 (Paolo Abeni <pabeni@redhat.com>)

v4:
- Add previous #13 in v2 back after dicussion with the RFC author.
- Add TCP_ACCECN_OPTION_PERSIST to tcp_ecn_option sysctl to ignore AccECN fallback policy on sending AccECN option.

v3:
- Add additional min() check if pkts_acked_ewma is not initialized in #1. (Paolo Abeni <pabeni@redhat.com>)
- Change TCP_CONG_WANTS_ECT_1 into individual flag add helper function INET_ECN_xmit_wants_ect_1() in #3. (Paolo Abeni <pabeni@redhat.com>)
- Add empty line between variable declarations and code in #4. (Paolo Abeni <pabeni@redhat.com>)
- Update commit message to fix old AccECN commits in #5. (Paolo Abeni <pabeni@redhat.com>)
- Remove unnecessary brackets in #10. (Paolo Abeni <pabeni@redhat.com>)
- Move patch #3 in v2 to a later Prague patch serise and remove patch #13 in v2. (Paolo Abeni <pabeni@redhat.com>)

---
Chia-Yu Chang (13):
  selftests/net: gro: add self-test for TCP CWR flag
  tcp: ECT_1_NEGOTIATION and NEEDS_ACCECN identifiers
  tcp: disable RFC3168 fallback identifier for CC modules
  tcp: accecn: handle unexpected AccECN negotiation feedback
  tcp: accecn: retransmit downgraded SYN in AccECN negotiation
  tcp: add TCP_SYNACK_RETRANS synack_type
  tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN
    SYN/ACK
  tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion
  tcp: accecn: fallback outgoing half link to non-AccECN
  tcp: accecn: detect loss ACK w/ AccECN option and add
    TCP_ACCECN_OPTION_PERSIST
  tcp: accecn: add tcpi_ecn_mode and tcpi_option2 in tcp_info
  tcp: accecn: enable AccECN
  selftests/net: packetdrill: add TCP Accurate ECN cases

Ilpo Järvinen (2):
  tcp: try to avoid safer when ACKs are thinned
  gro: flushing when CWR is set negatively affects AccECN

 Documentation/networking/ip-sysctl.rst        |   4 +-
 .../networking/net_cachelines/tcp_sock.rst    |   1 +
 include/linux/tcp.h                           |   4 +-
 include/net/inet_ecn.h                        |  20 +++-
 include/net/tcp.h                             |  32 +++++-
 include/net/tcp_ecn.h                         | 103 ++++++++++++------
 include/uapi/linux/tcp.h                      |  26 ++++-
 net/ipv4/inet_connection_sock.c               |   3 +
 net/ipv4/sysctl_net_ipv4.c                    |   4 +-
 net/ipv4/tcp.c                                |  10 ++
 net/ipv4/tcp_cong.c                           |   5 +-
 net/ipv4/tcp_input.c                          |  40 ++++++-
 net/ipv4/tcp_minisocks.c                      |  43 +++++---
 net/ipv4/tcp_offload.c                        |   3 +-
 net/ipv4/tcp_output.c                         |  34 ++++--
 net/ipv4/tcp_timer.c                          |   3 +
 tools/testing/selftests/drivers/net/gro.c     |  81 ++++++++++----
 tools/testing/selftests/drivers/net/gro.py    |   3 +-
 .../tcp_accecn_2nd_data_as_first.pkt          |  24 ++++
 .../tcp_accecn_2nd_data_as_first_connect.pkt  |  30 +++++
 .../tcp_accecn_3rd_ack_after_synack_rxmt.pkt  |  19 ++++
 ..._accecn_3rd_ack_ce_updates_received_ce.pkt |  18 +++
 .../tcp_accecn_3rd_ack_lost_data_ce.pkt       |  22 ++++
 .../net/packetdrill/tcp_accecn_3rd_dups.pkt   |  26 +++++
 .../tcp_accecn_acc_ecn_disabled.pkt           |  13 +++
 .../tcp_accecn_accecn_then_notecn_syn.pkt     |  28 +++++
 .../tcp_accecn_accecn_to_rfc3168.pkt          |  18 +++
 .../tcp_accecn_client_accecn_options_drop.pkt |  34 ++++++
 .../tcp_accecn_client_accecn_options_lost.pkt |  38 +++++++
 .../tcp_accecn_clientside_disabled.pkt        |  12 ++
 ...cecn_close_local_close_then_remote_fin.pkt |  25 +++++
 .../tcp_accecn_delivered_2ndlargeack.pkt      |  25 +++++
 ..._accecn_delivered_falseoverflow_detect.pkt |  31 ++++++
 .../tcp_accecn_delivered_largeack.pkt         |  24 ++++
 .../tcp_accecn_delivered_largeack2.pkt        |  25 +++++
 .../tcp_accecn_delivered_maxack.pkt           |  25 +++++
 .../tcp_accecn_delivered_updates.pkt          |  70 ++++++++++++
 .../net/packetdrill/tcp_accecn_ecn3.pkt       |  12 ++
 .../tcp_accecn_ecn_field_updates_opt.pkt      |  35 ++++++
 .../packetdrill/tcp_accecn_ipflags_drop.pkt   |  14 +++
 .../tcp_accecn_listen_opt_drop.pkt            |  16 +++
 .../tcp_accecn_multiple_syn_ack_drop.pkt      |  28 +++++
 .../tcp_accecn_multiple_syn_drop.pkt          |  18 +++
 .../tcp_accecn_negotiation_bleach.pkt         |  23 ++++
 .../tcp_accecn_negotiation_connect.pkt        |  23 ++++
 .../tcp_accecn_negotiation_listen.pkt         |  26 +++++
 .../tcp_accecn_negotiation_noopt_connect.pkt  |  23 ++++
 .../tcp_accecn_negotiation_optenable.pkt      |  23 ++++
 .../tcp_accecn_no_ecn_after_accecn.pkt        |  20 ++++
 .../net/packetdrill/tcp_accecn_noopt.pkt      |  27 +++++
 .../net/packetdrill/tcp_accecn_noprogress.pkt |  27 +++++
 .../tcp_accecn_notecn_then_accecn_syn.pkt     |  28 +++++
 .../tcp_accecn_rfc3168_to_fallback.pkt        |  18 +++
 .../tcp_accecn_rfc3168_to_rfc3168.pkt         |  18 +++
 .../tcp_accecn_sack_space_grab.pkt            |  28 +++++
 .../tcp_accecn_sack_space_grab_with_ts.pkt    |  39 +++++++
 ...tcp_accecn_serverside_accecn_disabled1.pkt |  20 ++++
 ...tcp_accecn_serverside_accecn_disabled2.pkt |  20 ++++
 .../tcp_accecn_serverside_broken.pkt          |  19 ++++
 .../tcp_accecn_serverside_ecn_disabled.pkt    |  19 ++++
 .../tcp_accecn_serverside_only.pkt            |  18 +++
 ...n_syn_ace_flags_acked_after_retransmit.pkt |  18 +++
 .../tcp_accecn_syn_ace_flags_drop.pkt         |  16 +++
 ...n_ack_ace_flags_acked_after_retransmit.pkt |  27 +++++
 .../tcp_accecn_syn_ack_ace_flags_drop.pkt     |  26 +++++
 .../net/packetdrill/tcp_accecn_syn_ce.pkt     |  13 +++
 .../net/packetdrill/tcp_accecn_syn_ect0.pkt   |  13 +++
 .../net/packetdrill/tcp_accecn_syn_ect1.pkt   |  13 +++
 .../net/packetdrill/tcp_accecn_synack_ce.pkt  |  27 +++++
 ..._accecn_synack_ce_updates_delivered_ce.pkt |  22 ++++
 .../packetdrill/tcp_accecn_synack_ect0.pkt    |  24 ++++
 .../packetdrill/tcp_accecn_synack_ect1.pkt    |  24 ++++
 .../packetdrill/tcp_accecn_synack_rexmit.pkt  |  15 +++
 .../packetdrill/tcp_accecn_synack_rxmt.pkt    |  25 +++++
 .../packetdrill/tcp_accecn_tsnoprogress.pkt   |  26 +++++
 .../net/packetdrill/tcp_accecn_tsprogress.pkt |  25 +++++
 76 files changed, 1680 insertions(+), 102 deletions(-)
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

-- 
2.34.1


