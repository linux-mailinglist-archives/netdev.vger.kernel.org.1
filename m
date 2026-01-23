Return-Path: <netdev+bounces-252763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WD50BKJJc2mHuQAAu9opvQ
	(envelope-from <netdev+bounces-252763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:12:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3A4740ED
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E46130B6572
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E845E33A9CB;
	Fri, 23 Jan 2026 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="UNbaxTVB"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012064.outbound.protection.outlook.com [52.101.66.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AFC36C5A3;
	Fri, 23 Jan 2026 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162876; cv=fail; b=XZzXfK1IORvBOuKqezasOnNB0unv9GSWzocy9RDeRMW0bpNTa3Pf8Nn6s5Wkyk84TNj8aBJ7l/gZMORMX2WH1MTCYejZVkbR+JIEEEdNnDqDdPregDvR1wNE9YyhlyrBUVtq18nLMzEB6gFJxp2D1ub+153uEcEXuF9114VF1Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162876; c=relaxed/simple;
	bh=XhSD7sbLg+s26YHRJBafUmt3NkgHcuaPlhthpzW4jHI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mzYMnntzjOtHX96zCeF3oOIwJQIk1S17su2CWTWhQlufNUl+uIgnmFUuTQY+Kyr5ZbNc4DZDmsNoeriWsEBSRubCoYrG+NFeSDR3OeHlLeX/UiWh7NgRhLfw7xhSayCi9cYrvT76CMPYnytfU2ude0r5KCESE2P0khpbCywWMIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=UNbaxTVB; arc=fail smtp.client-ip=52.101.66.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c598AzSf5BTPur1t13g38RJrrgAhub+kAJSO+7AFfU55ukNEXsR+k+QzSfDqVU/ZE1eEZZ2HfQcqq0UaP78ToNRCGj9cIni/XLfNc/3ndjRTWbChgcs/c7yav5dEdmEr9bgVZvv1PXsDxb4snO3Hs4Zwj6mNU8T1eMm6sXaoGUpcl+XT8+7NbBtGcgfQ01vOTko2RaHgoni86OcjFPy9TtUTtzalgMBLClOyqfAd6jhXCxcIsbStvNWkTIrS1EgPNGHW7LuU7eJ3UBHWP24Vu2sSJ+srbiMFnwseGg2x/GAaCVio+5+HbdPaHG1iUniPH9cPsTPw+yE6k3depW+trg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdQuke5vAkEXscSinzji/dUPaVbt5AKpW+6/eM1Bscw=;
 b=ezbNtI2nZoHOkNYuLWizpF3fzlH/HXZgD/c8MjuSwfF6JF5UZe74sxYHq2cSNt4BCelrY74QS6vXQlBk9U65Srzg6HE/FL5/Zg7DY9Wx9occn3rGsL1gj6GNFcxJkoxA4piiKpXvwdXqDnJino7Dzvk5phjMJmQbdGp+2qcBjqba48W7Ykvh3P7hcc1toL5FF6LEpZnrpAd9JnjyEX6mo+QhsUDqZWlwBxnXxee9T0I2323VCP/Cujsd1qWUtCReGxQuprvKA8JtJBrIpWtZz8kNE3xB7jPX6xqx54KDf/ZGpil4N7VysMhDs95nOOYFCZqjZCSNi5B/wiI50DTDvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdQuke5vAkEXscSinzji/dUPaVbt5AKpW+6/eM1Bscw=;
 b=UNbaxTVBXCQvOQifAS/IqEhqRlg5aXT7B2LMNG4QcMXVASOU5lgcFpz4LXEw7r3VDNVD1FVq+L16BVC+0NLbkYxeYhHw69XQBoNib0xQjy4cZbJYWAWXFLj2QwWE3AWfriTmYHS90Q7pErRTNmBrhyaqVutlir6/ywNcndDfru4L4mJg4ulWaoLbWdlCUJj5Wb33wTjHEKlu53QXCYL6g+CY3CUoE7T+8Kte4In8TpBI53CVFxQl+ZZhSNRv7XSUsxJFysm/uPXQCY0w67+jPyh980e+IBxLYDwFIfprEBRbulTY8SgwaWYIDGubC6LcPcPJuDczATICHPKMsw2BRw==
Received: from DB8PR04CA0012.eurprd04.prod.outlook.com (2603:10a6:10:110::22)
 by AS4PR07MB9657.eurprd07.prod.outlook.com (2603:10a6:20b:4f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:07:24 +0000
Received: from DB1PEPF000509F3.eurprd02.prod.outlook.com
 (2603:10a6:10:110:cafe::12) by DB8PR04CA0012.outlook.office365.com
 (2603:10a6:10:110::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.12 via Frontend Transport; Fri,
 23 Jan 2026 10:07:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF000509F3.mail.protection.outlook.com (10.167.242.149) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Fri, 23 Jan 2026 10:07:24 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id EB5231C003B;
	Fri, 23 Jan 2026 12:07:22 +0200 (EET)
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
Subject: [PATCH v11 net-next 00/15] AccECN protocol case handling series
Date: Fri, 23 Jan 2026 11:07:06 +0100
Message-Id: <20260123100721.42451-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F3:EE_|AS4PR07MB9657:EE_
X-MS-Office365-Filtering-Correlation-Id: 2837f6e0-f861-44ff-e462-08de5a6734d2
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020|18082099003;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SzFsdnZ2VDRlTDJnNFh2aHp0d3ZYWS9vWEUyeUsrTnlWVmtRYmFPeG5za2N6?=
 =?utf-8?B?cE1qc0Y2dWIwcytHNkNxNTVwNkN3bkVQNHllTTI4bmJPUGNYR21MTXRIcFFT?=
 =?utf-8?B?M2RVQ0J1czkyQ0hYV1F1QytGQUZjQit2TWxNU3BWaTFKMytyaEV2Y2NlT2F6?=
 =?utf-8?B?S2JlMTVzVkJZbWg1UkttNU5mZStnT3BwUzJlZDVMM1ZPdXpGVGRKTzRTRkR1?=
 =?utf-8?B?a0Vpd1V5S09TYkVkcm40dHliSFJOL3F5a2ZYdVhqV1lNekoxSHF2ZXdTOFVz?=
 =?utf-8?B?K2h5d0VHRFRVYzhOVXlnRGpDait0MlhsMWZ5SDBoVDB4NjZObDJXcnBNdk4v?=
 =?utf-8?B?bmpoOGlKdmRuRUQrT1kvUDBxUGwvK29yd0IzRE1US2RaYmNDbFA2czRUVXhp?=
 =?utf-8?B?dk02c01uMVZrK1Jid3RBTE1DbXMvRVllUzRVcFYxNjlqdTlNaDZxSVR4NllB?=
 =?utf-8?B?USt4U09qNnoxbnFaYmdQNGpSTlJDWHhsS2pOQU9RNVBaZXYwOEVKUjYxS1hs?=
 =?utf-8?B?bjBMT0ttekRMVTZmYzNGRzVFWnVUWmc3ZW1vLzY2VnBPNytNUjBMbCtXbWpD?=
 =?utf-8?B?ZFNFcW1JbTIrRHhVU2hydXB1ZUtwcFhoVkYvUFZIem5PL2h6V2hTQjR3Mi9G?=
 =?utf-8?B?aXFDQmtoQ3VWUkMwZ09qVjJocmxVaUUrb0YwR3BxUlAzV3VoMk1UanRDQU1u?=
 =?utf-8?B?NVJPb2pSbENCUDdDTHp4TXhYOE9QS3hNYkprcWdtSndXaGw3S0NZeStBcmxT?=
 =?utf-8?B?bTZoZ3E0S25MSzlMREhSa0xqYkEyMTlBQk81b2lOMTFXcDVJb2JwZ1owU050?=
 =?utf-8?B?dm83Y3hRM2VZTzdsVm8zNU1rNE1hMUNpTTZIb3NNcmt0TTQrQms5bFhFWksv?=
 =?utf-8?B?RXcyc05aSUs2ZHB3MnljdnNaN1k4RlFRcXlBWTlveXpPV2R3NnhwU1BqZjhy?=
 =?utf-8?B?QnhpY2NqenMvdWJBV0h1ZHJZU3ZvR3dlZENMWm9DSTcySlFUNlE5R2hJYjhT?=
 =?utf-8?B?U3hHbGJ4Z2pEYXFiK05KeUlKMzZlNXdXUDFpeC9TcTArWWIwRTBMaGgzZ2FH?=
 =?utf-8?B?UUhFdFo3SFg0UWVhWHFPYmh1T0RoRUZlUENmUXdhL1U5Nld2aEpVUlNVSWs4?=
 =?utf-8?B?SHRzb1lqaDVRUTVIQ09DUjNPYUxxRjdxWjFjNGtQQzFmWDlBaWtyQWNGQTlv?=
 =?utf-8?B?TUlBZXB5bEZFcm90eUlwYlBWNys1R2d5Y2VxaVJZcHh2aEdrUy9JQ3R6OE5C?=
 =?utf-8?B?YWVtdHQ5S1BxUVcvaytSWlFzTHVpTWFTcThaL0w3UGcyRVY1YTM2Sjh2WUZj?=
 =?utf-8?B?V01TUHFRcTBLaDNwdUZGeStzY0FwM1hJbjFMQnl4REVLSC84ajE2bU9CTXdx?=
 =?utf-8?B?QWRMYUQ0ZkFNMnptQzA4QW5NZ2JtalJ6STR6SktNbDEwQVliQVpGeWFoRDlT?=
 =?utf-8?B?eHRLcGVlMFVDdWowSnpLMi8zckovYTA1TGZvL1A3TWZLVERVKzI3KzEyT0JG?=
 =?utf-8?B?am5HemNkM3UwTzBYMWdjb1RSZGFLZmppcEdSdndEMDEySU5XeDB2WHVKTTRQ?=
 =?utf-8?B?RlgyLzUzZ1hldjgrRXRaQ2VFZGt2cVRzUytHSlQ4ams5NjRlUFNEMmh0bGdh?=
 =?utf-8?B?ZnMwN1pWS1YzcDZzajhONXExUjNldjU2YS9McFNtQjRQQmo4VHRVUXJoVnd5?=
 =?utf-8?B?dXdCMlkyK3NGd0Fwb0tLbXRoUmJ5QjNQT3Q3bXJ3ZzBwdGlvbTBZVXY5WGp4?=
 =?utf-8?B?V1FTZTVNWjJoaFdUaGsxTDlNRW1VUnZ6WDhHZjUrYjlsMmxJUzAzRDJtb3ZB?=
 =?utf-8?B?S3I4QjZRUFBnN1NoMjJiNUUyazFCRjFmV203YW5WN1pCd3lTNjhXYVZsQ2R4?=
 =?utf-8?B?UmJkZWFYeXVoQ1V4STV6R0ZKdm9aa21MaG1iUVlMRmV4U05JTUc4ZUhpRVBx?=
 =?utf-8?B?SjNpaWY1Um5iRjRrM09aZ1ROWFBQeG15Y1NMMFVCKytFMVZ6MzljRzFieEI5?=
 =?utf-8?B?MlNuRmhWUkpLYUFQWXFvR3pqbWo1NXp0OFh6WWE0cHh6SFhSTlhnQjZXRGM5?=
 =?utf-8?B?cEh0dmxuL0czb0hBQ1A4VjJkSlVsVGc0b3RqMGxQK04vbXhYNjA2aXY0VkFl?=
 =?utf-8?B?eHZQeGRjZStxTDBxZUlBOENQQmhveDlMTXZRMUVIdDVpYW1pUEFJMkNOb3pK?=
 =?utf-8?B?cUdWTWhIWk5yV1BXOVpPVnV5eDIyNVIwb1ZIeXMxUTdlSmN5TTV4bklCekhC?=
 =?utf-8?Q?CC4AC8EqxNv7IBM/LI2RVaF+EhoIlVsBgpZRqY30J8=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020)(18082099003);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:07:24.6502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2837f6e0-f861-44ff-e462-08de5a6734d2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB9657
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
	TAGGED_FROM(0.00)[bounces-252763-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 8E3A4740ED
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Plesae find the v10 AccECN case handling patch series, which covers
several excpetional case handling of Accurate ECN spec (RFC9768),
adds new identifiers to be used by CC modules, adds ecn_delta into
rate_sample, and keeps the ACE counter for computation, etc.

This patch series is part of the full AccECN patch series, which is at
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Best regards,
Chia-Yu

---
All 58 packetdrill are passed, please find below logs:

TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_2nd_data_as_first_connect.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_2nd_data_as_first.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_3rd_ack_after_synack_rxmt.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_3rd_ack_ce_updates_received_ce.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_3rd_ack_lost_data_ce.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_3rd_dups.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_acc_ecn_disabled.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_accecn_then_notecn_syn.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_accecn_to_rfc3168.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_client_accecn_options_drop.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_client_accecn_options_lost.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_clientside_disabled.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_close_local_close_then_remote_fin.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_delivered_2ndlargeack.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_delivered_falseoverflow_detect.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_delivered_largeack2.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_delivered_largeack.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_delivered_maxack.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_delivered_updates.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_ecn3.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_ecn_field_updates_opt.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_ipflags_drop.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_listen_opt_drop.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_multiple_syn_ack_drop.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_multiple_syn_drop.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_negotiation_bleach.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_negotiation_connect.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_negotiation_listen.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_negotiation_noopt_connect.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_negotiation_optenable.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_no_ecn_after_accecn.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_noopt.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_noprogress.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_notecn_then_accecn_syn.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_rfc3168_to_fallback.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_rfc3168_to_rfc3168.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_sack_space_grab.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_sack_space_grab_with_ts.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_serverside_accecn_disabled1.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_serverside_accecn_disabled2.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_serverside_broken.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_serverside_ecn_disabled.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_serverside_only.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_syn_ace_flags_acked_after_retransmit.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_syn_ace_flags_drop.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_syn_ack_ace_flags_acked_after_retransmit.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_syn_ack_ace_flags_drop.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_synack_ce.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_synack_ce_updates_delivered_ce.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_synack_ect0.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_synack_ect1.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_synack_rexmit.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_synack_rxmt.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_syn_ce.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_syn_ect0.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_syn_ect1.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_tsnoprogress.pkt
-----------------------------------
TAP version 13
1..2
ok 1 ipv4
ok 2 ipv6
# Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
[PASS] tcp_accecn_tsprogress.pkt
-----------------------------------
Total: 58 cases, 58 passed, 0 failed.

---
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
 include/net/tcp_ecn.h                         | 108 ++++++++++++------
 include/uapi/linux/tcp.h                      |  26 ++++-
 net/ipv4/inet_connection_sock.c               |   3 +
 net/ipv4/sysctl_net_ipv4.c                    |   4 +-
 net/ipv4/tcp.c                                |  10 ++
 net/ipv4/tcp_cong.c                           |   5 +-
 net/ipv4/tcp_input.c                          |  40 ++++++-
 net/ipv4/tcp_minisocks.c                      |  45 +++++---
 net/ipv4/tcp_offload.c                        |   3 +-
 net/ipv4/tcp_output.c                         |  32 ++++--
 net/ipv4/tcp_timer.c                          |   2 +
 tools/testing/selftests/drivers/net/gro.c     |  81 +++++++++----
 tools/testing/selftests/drivers/net/gro.py    |   3 +-
 .../tcp_accecn_2nd_data_as_first.pkt          |  24 ++++
 .../tcp_accecn_2nd_data_as_first_connect.pkt  |  30 +++++
 .../tcp_accecn_3rd_ack_after_synack_rxmt.pkt  |  19 +++
 ..._accecn_3rd_ack_ce_updates_received_ce.pkt |  18 +++
 .../tcp_accecn_3rd_ack_lost_data_ce.pkt       |  22 ++++
 .../net/packetdrill/tcp_accecn_3rd_dups.pkt   |  26 +++++
 .../tcp_accecn_acc_ecn_disabled.pkt           |  14 +++
 .../tcp_accecn_accecn_then_notecn_syn.pkt     |  28 +++++
 .../tcp_accecn_accecn_to_rfc3168.pkt          |  18 +++
 .../tcp_accecn_client_accecn_options_drop.pkt |  34 ++++++
 .../tcp_accecn_client_accecn_options_lost.pkt |  38 ++++++
 .../tcp_accecn_clientside_disabled.pkt        |  12 ++
 ...cecn_close_local_close_then_remote_fin.pkt |  25 ++++
 .../tcp_accecn_delivered_2ndlargeack.pkt      |  25 ++++
 ..._accecn_delivered_falseoverflow_detect.pkt |  31 +++++
 .../tcp_accecn_delivered_largeack.pkt         |  24 ++++
 .../tcp_accecn_delivered_largeack2.pkt        |  25 ++++
 .../tcp_accecn_delivered_maxack.pkt           |  25 ++++
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
 .../tcp_accecn_serverside_broken.pkt          |  19 +++
 .../tcp_accecn_serverside_ecn_disabled.pkt    |  19 +++
 .../tcp_accecn_serverside_only.pkt            |  18 +++
 ...n_syn_ace_flags_acked_after_retransmit.pkt |  18 +++
 .../tcp_accecn_syn_ace_flags_drop.pkt         |  16 +++
 ...n_ack_ace_flags_acked_after_retransmit.pkt |  27 +++++
 .../tcp_accecn_syn_ack_ace_flags_drop.pkt     |  27 +++++
 .../net/packetdrill/tcp_accecn_syn_ce.pkt     |  13 +++
 .../net/packetdrill/tcp_accecn_syn_ect0.pkt   |  13 +++
 .../net/packetdrill/tcp_accecn_syn_ect1.pkt   |  13 +++
 .../net/packetdrill/tcp_accecn_synack_ce.pkt  |  28 +++++
 ..._accecn_synack_ce_updates_delivered_ce.pkt |  22 ++++
 .../packetdrill/tcp_accecn_synack_ect0.pkt    |  24 ++++
 .../packetdrill/tcp_accecn_synack_ect1.pkt    |  24 ++++
 .../packetdrill/tcp_accecn_synack_rexmit.pkt  |  15 +++
 .../packetdrill/tcp_accecn_synack_rxmt.pkt    |  25 ++++
 .../packetdrill/tcp_accecn_tsnoprogress.pkt   |  26 +++++
 .../net/packetdrill/tcp_accecn_tsprogress.pkt |  25 ++++
 76 files changed, 1688 insertions(+), 101 deletions(-)
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


