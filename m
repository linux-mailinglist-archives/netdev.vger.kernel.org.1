Return-Path: <netdev+bounces-252758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBzsBjxJc2mHuQAAu9opvQ
	(envelope-from <netdev+bounces-252758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:11:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B876973FF0
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BC783072570
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5607372B46;
	Fri, 23 Jan 2026 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="dGkXlTUh"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011050.outbound.protection.outlook.com [52.101.65.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDB8314D15;
	Fri, 23 Jan 2026 10:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162859; cv=fail; b=N9m90hfn0+wokDRmwYSxDGOmcfl1MxNgwOLWs8LhKURNbqWBv2p/rR0ZjSmBt2V9/elQsjgrLigMC3y5WU+u6HMW2IIiUJXCQfbDNL4WZWUD9uifoXqq0hlHh4rlQwBL7RP7xFah3NrDvRUON/rWIz3xNWkMVJYEUKs0cTL+dsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162859; c=relaxed/simple;
	bh=Fd1FaxLYEz6xZ2AGiIP3sdzQ6XTCI7FMlSaiA16alto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9B/OjK0VdYVPTFXoHp8ZGQ5blEBEVixLCImFQNExptFx5ZSEjm39tlLaHgjsH7QK/68pPOIgIyCyWY+y0SJRHs6cu2buouZABAgflIdd9GkRkQIXv88kkVr58HT+jiZpxSe7JFsc7r+vy+4Bv0xUBBZHsAN5nCiDowfFqXEIGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=dGkXlTUh; arc=fail smtp.client-ip=52.101.65.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvmDIYB9BU9R6zIOFGqUudhde+knFIegSCsXF8AgAsfHhUcatXHbRX4ZpaLJD3KweoUsu9inxXVoDOvTqAhFepI80Ib97MWVZGpRBGwTwOtIg7PNBiHW44li2A11/GXtc4TAVwqU5fcU1ybyJl/4XCr13cHwd87aY9JAnG+z4gBUGqIkkJTQeWzMW1Ln0l71E/hPxGYkQY16Tc8lW71DqlvNYGP9hpnL4BkVibWwnFbuek6tnhvvmUicRHC9qdC0HSpqQ72lH0xEmZ3PEYzUUtRl0ep340P52QWPf67ToDMGhGVz8TmjH7McsBeENsRj0CEwOLRuxRCqXhR75yt6RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgF6wgdKGyAN98Mpvcl/dfVxI+c9B559KNGTjPo0tKc=;
 b=pubAcLuPOKcG/7DlrYDClJKrOMAQW4E2n0A/bIA5BXTuzmQOZEnllRxnIAQZInLFR937/7B6k00OP6Mh/bRw8xwuURx4jVQyJuJP21eP8QnSs+uF/Q5R8iFJ3QadxTo6xP5KiV/4U6KpcFwPInIIlyxBIcg5vP2pttW0jdh9uaEem4OwatmNIne91ufvkYeE8FmA46bV9cl3KrsZOE+nylRuGMcGOMPSM81lhfJdbBpDjlwxtelndukHPKT1sVUCck1vQKinjWzW8+tjzPFbWnI8MYD+B9Sy8dnkv1wvrf7zSwnIC3vGjbdJQCXTtPZ+6oEqTxo3WFI+W8W/8qkkFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgF6wgdKGyAN98Mpvcl/dfVxI+c9B559KNGTjPo0tKc=;
 b=dGkXlTUh90mVKaSGdyLjlRe8ms0VE7LIsuOLuG3AypcchGKIWxBJyyrMauQ3lIgN387VdThH0CCtAYcgx1t4e9e/btZVybT19ux7ooZWnKjTb3ww43b+LvGi//UhPuKiBQaxZ3tiNMYA4QswO8KsjkrXxQsFGCicnYAxqyVgczuUJnBGrHT8ZNVTvJ9M1CXERf76ZMuNf9V2cJ+14TshkUTOjoIzxCBThGCrnoDX2s3PqQrvUUfApUqGheP7cjT1IUvCyHMyPYt2wxONmh1JtDRVGRHvRzdhzTTvNGT8KkoL0K1C0oWphhD3mAffqPSwYEy+OaBm8r6n2r9/T33Ejw==
Received: from PA7P264CA0026.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2df::6)
 by DBBPR07MB7498.eurprd07.prod.outlook.com (2603:10a6:10:1ef::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 10:07:29 +0000
Received: from AM4PEPF00025F99.EURPRD83.prod.outlook.com
 (2603:10a6:102:2df:cafe::ad) by PA7P264CA0026.outlook.office365.com
 (2603:10a6:102:2df::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Fri,
 23 Jan 2026 10:07:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM4PEPF00025F99.mail.protection.outlook.com (10.167.16.8) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.0 via
 Frontend Transport; Fri, 23 Jan 2026 10:07:29 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 953D11C004D;
	Fri, 23 Jan 2026 12:07:27 +0200 (EET)
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
Subject: [PATCH v11 net-next 02/15] gro: flushing when CWR is set negatively affects AccECN
Date: Fri, 23 Jan 2026 11:07:08 +0100
Message-Id: <20260123100721.42451-3-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F99:EE_|DBBPR07MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: a5262f2c-8b97-43e5-9dba-08de5a6737a4
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MWVpYXNWL1ZoM3VQSUdpaitGS01tb0lPL1VMUlRHdkpXMkxRenVpczVQZCtJ?=
 =?utf-8?B?dzFHNjN2RUM4UGNVKy9aZFFTMTRqazBPaEVkL3hYeHlLZVVjWjJoTkVQQmVr?=
 =?utf-8?B?aUNjS3UrYlBNUCtLNmRPNWN5THpySzUwMFNraTc4TStUWjJWUWYxU3JtTStx?=
 =?utf-8?B?N3hPaDRtaHNRdUNUb2pGd1JYenIrSVNrb3owdFI3TGV5NVRZSEZGNGE4V1hN?=
 =?utf-8?B?c3BoamQ0TnFzRFNnWVZPSWplbWo5emY4Ris3bVBnUXc5aWI1UmQ1TUVZRTRX?=
 =?utf-8?B?MTNQTTZxYVM2b2xKdnh0ekdFNkFOazNXdzQ0UzNBYW5WRlZkd0lmQmJOMzM3?=
 =?utf-8?B?RGZHQThpWnYwL3o2Y3ZrOG9CMm1KekxWUXBBWmxZdDd0eHlWSEJ5QmIxUVRB?=
 =?utf-8?B?MS8wSFAyMjVXTVNlRWRoUDNkZlNSb29hbUVoT0ZOOE50bEg3YmhEeER6akJQ?=
 =?utf-8?B?QzhzM2tBNTBRdFlSK1AvbnpDL1pXUkV0d3B6ZUdrbjBWU3lRcXduTlRYR0E4?=
 =?utf-8?B?Y0syZkhwS1pOZWZhNnhqWmVXSlVtSFdSeGV0SlZENXlLYUJrTWQ1dkdYdDRj?=
 =?utf-8?B?ODBEWUYrMWVUZkVjNUNLYjR3Wk0wcHpReGs4aVY5U3o3cDlHS2NJVXg2Tm55?=
 =?utf-8?B?WEtnd29wT00xemc1aFJscEMwVXhVNFcvSXRLZlhkKzlqSUhrcy9laDYrVW1P?=
 =?utf-8?B?cExaMHF5V2V2NXhLNWxkNnozV3dldlJpNlYxRmZBQXN6UzhPanMyUXhOcjRU?=
 =?utf-8?B?UDN2aVMyczFvM2h3UjFDR0w3ZzJTUm10enBsTC9UWHIrR0lnZGNUZk92aHEw?=
 =?utf-8?B?MTV1R0pQdzJzOEZKVDNobGRxKzZTSnJuWlQ2bHBnRVpjWUJGeUw1YW9nNlZP?=
 =?utf-8?B?eGdlS3hnVGdYclRBVnVseVYrK2tHYW9IZFZncWpNZzVTcjhQd0FvRjBvcWZW?=
 =?utf-8?B?aG5HcFJYelVFT0pwN0RjL2dHMEMwSmovNFhHaExrUkV3aWVMQTNUZDFmQnlB?=
 =?utf-8?B?dFY2c0E5MHNPNDN0aEI4a1RJSEwwN01Kc3l4ZmdIVzcyY2t3MkpNcnJTeFY0?=
 =?utf-8?B?Y3FVblNOOGpjcWVBRC9WRUtXRmZ4bHc4MlY1eld5dGo4a0VhRklTOFhvMkIv?=
 =?utf-8?B?UzI0Z0duNmRUQ3NuNncrcVNHZWNpUE84aWVsNnErU2l4Z2tmL1RXUno2SHZx?=
 =?utf-8?B?VG9QdnBDalVFUm5LOHhFV2Z2OXhqUTN2YXlsMHUvWWJhSkNNRG5rK1o0RUg0?=
 =?utf-8?B?L21walM1MEkweitpQmhEOFM5MitoS2crb3kzaWVUejJkRWgyNHVGRlZsWlM5?=
 =?utf-8?B?M0VDNE9VQU9iY1IrTE9KZjhqRXo1eWxoMk9FTFFZOXB6VkVmRW40VnkwUG8y?=
 =?utf-8?B?TUZkNmg2TzJIWHB6RXhrOEJWenkxUjk0ZjMrZTNoOUhWdFZDY0NrOTV0Tmpm?=
 =?utf-8?B?WlJudkUwenJtL0dRd1o2QW1QMUQySTV5cGlIc3Y4RFhvZjF0MmRLaThqQnZy?=
 =?utf-8?B?WlEwdjk3aVhJeVdlTUJsR05EbkUyaDdMU2hVNk94cHdsUHgrS2tkSnlSSlJE?=
 =?utf-8?B?bU5sNjJoemxNN0YwbzIzQ1ZFM016YURYWjl4b1ljQnV0ZTM1RmVXNUdwSk9L?=
 =?utf-8?B?QjZEUVQyYzNqOGQ4UjlzaC9sTHI0ZVA0enRScGw1YTEyb2NtSXJjUEdFeG51?=
 =?utf-8?B?NzI2L2d4WFpRZTBPTmFOL3htMHFWNElSam5sMzZuSFhUNlBlV2Q2Yk41VFVw?=
 =?utf-8?B?UHYxUFI5eFd1QU0yR2RteDh0SEdtRHNOVFBsa2p3K3VubnJlSVRuMG1sMTRM?=
 =?utf-8?B?UytrU0thbXVQVm9NZFphYkN0SVVKVnZUaDZmRmZBWXZNR0FoV295NDJ3bCtB?=
 =?utf-8?B?R2ZiOS9TLzNENTBkbkFVZVM0bXljK3NiU2tpKzZyZ2hwcmRiWFdkclJZREs2?=
 =?utf-8?B?eEpvcGsrSHFycDVzZ0FDdjBTUktQYVM1N3hWSXYvZDBsVnJuUUprNFlUbS9w?=
 =?utf-8?B?cmdBYU9CRXQweDZCbTc0eVltRE5CUHAzTlY4S2w1ZVRIcmhGUENPSDk1akVs?=
 =?utf-8?B?M1VQQ09nZ2wyaXhOc0QzbWJJQWFvZzBPVmFqOE1zUFVUaE96Y2ZEb25CanZm?=
 =?utf-8?B?ZC9JRnlMZVlJUFhXSE5DdXhlSzQ1Tk5FdGRQRWZkOXRNejNwaElXTG5VREpj?=
 =?utf-8?B?RENPeTNyaEd6cEx5Mmp0bXBHYlJ3Tmpxakl5d1NDZEs2NlE4c0JGNldVdzNF?=
 =?utf-8?Q?jgMqToneliDROCxuR5UCDpWjeTy48P14WdZ+Vc2GQw=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:07:29.3864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5262f2c-8b97-43e5-9dba-08de5a6737a4
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00025F99.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7498
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252758-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B876973FF0
X-Rspamd-Action: no action

From: Ilpo Järvinen <ij@kernel.org>

As AccECN may keep CWR bit asserted due to different
interpretation of the bit, flushing with GRO because of
CWR may effectively disable GRO until AccECN counter
field changes such that CWR-bit becomes 0.

There is no harm done from not immediately forwarding the
CWR'ed segment with RFC3168 ECN.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_offload.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index fdda18b1abda..9bd710c7bc95 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -303,8 +303,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 		goto out_check_final;
 
 	th2 = tcp_hdr(p);
-	flush = (__force int)(flags & TCP_FLAG_CWR);
-	flush |= (__force int)((flags ^ tcp_flag_word(th2)) &
+	flush = (__force int)((flags ^ tcp_flag_word(th2)) &
 		  ~(TCP_FLAG_FIN | TCP_FLAG_PSH));
 	flush |= (__force int)(th->ack_seq ^ th2->ack_seq);
 	for (i = sizeof(*th); i < thlen; i += 4)
-- 
2.34.1


