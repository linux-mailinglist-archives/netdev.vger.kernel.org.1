Return-Path: <netdev+bounces-251917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFGVIrfucGk+awAAu9opvQ
	(envelope-from <netdev+bounces-251917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:20:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7C65914A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8829A886FE
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0BA49552C;
	Wed, 21 Jan 2026 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ZoWMg/gs"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010019.outbound.protection.outlook.com [52.101.84.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A570D49550E;
	Wed, 21 Jan 2026 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005951; cv=fail; b=cq1KeA58+kuNueMK5R9Q9RjetKORegEFxi7GH4CegCTMNjciupDx5EKkjDoHvhbvDTP0eg7Zh1Uq5EmhvzHfLL0Gwo64sZxRq8iCoky3WxNhTzA3ds9074QJIu4ZAyeBeNERRVTVszZPAizJW+5NtxuU5IjNdeJIbMXxtQuAIpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005951; c=relaxed/simple;
	bh=Fd1FaxLYEz6xZ2AGiIP3sdzQ6XTCI7FMlSaiA16alto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDfpbY9UE42mCQivPbQeMT0Z+xqeISHcNv+63dBkcm54BR1FTt3bCAuVDzVtbpVzns0zjmN1qnaQTvhaKdWAR+FHQ4YPPf39vbhmizi/67pMwcof4dEu3nW4cw1HfSHFe/x9j09mqI2ZoGEaFMdQBXhmzMArP4IT/BM19L8jjhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ZoWMg/gs; arc=fail smtp.client-ip=52.101.84.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCC16va4jozT4CBS3S6cbzFq/mumqkhuZXk5cMUUnHYbx1SlngbPuUrtM5NVlm/oSionG/Fc73ajEBCc0goJhUCcxpXnGnsoKEF20IAnTP6UDEemz5kKWywrcDhHYnB5SFKtXLzgag1ICX+Hzg8ZCpNb8PUB5TiSnFHW2q6NexbRyhU01j7qXbiR9DrP/QQB9sPriBcH0Ru4nfD5tXYa3XQIiJ8wK5k4Rz4/7toc/TJ+P4gP/GhdfeEUsRC+4M3bPtpMIFcDGFb+LE9UBtZhHz/Rw4zDx6peqFJ2bMoAdliErIq3vUN1qlPDyLFw0etGkDmTQXNH61pBCJcDXHxwzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgF6wgdKGyAN98Mpvcl/dfVxI+c9B559KNGTjPo0tKc=;
 b=b30NKbb/bpTJiT9xjtcpanElu2nVI6k95p5SUfc1JfJPCfvWTxPk/k8PTSzevBgHBtV7D6GeNP4GufX4Rb1LgP6HbOqpNUG+QOnnUgzrTmji1gI/KOhWRlkZOMpbR3MTDVB4h7YnFgVLz7z9KBxwnfGAqeNDNPvtZpsBNDfJZ03FwUntRaDgTHeb+OCKaojEUCdHIY6Hu52//7H9dVSVnDaXTY3O3M7lmLW/ly1I+lTtJrWPYZCc6RCf9nBkYKQyjrBz5qcvjgzjGJpzNpiDpiBuiG4Wyk87Kh5BVBv6EtyM7T8NZwZmbCDP86IvY8wFjZXOUqEGpjplawKU69wrJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgF6wgdKGyAN98Mpvcl/dfVxI+c9B559KNGTjPo0tKc=;
 b=ZoWMg/gsiLZ+D3GwRv6Zgzfa/kSXlOEGxCrHCDhJyJi5QcwHmKF6LZo9oH6r+lCmxGXYFatPZU+UEL1mjbssjwOxRb/Xa7Au79ruuHYn+XOL2WmQD5agUuwlu+ezGVgCeCUwh+soIq5bBITWLuidCFB6FXombcJMr0m/LYiaCoQaj0EY29pToD73DlfhzmxqZetINygNS/0rEkVPVddN/sC2YZCbzfaPi3I/320ulpsn6ti1Q6hsIGoov6DzgDpKsMZEnGioVpDUs+m29/E9xZvvnmvnhXpU33iLcFQtoTUb1lOAP1BrthMtMz6Vg3JLlIAEL1ZMExDNJqKKFuQIog==
Received: from DU7PR01CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::11) by AS5PR07MB9769.eurprd07.prod.outlook.com
 (2603:10a6:20b:679::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 14:32:25 +0000
Received: from DB1PEPF000509E6.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::c9) by DU7PR01CA0016.outlook.office365.com
 (2603:10a6:10:50f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 14:32:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB1PEPF000509E6.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Wed, 21 Jan 2026 14:32:24 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id BEE002051C;
	Wed, 21 Jan 2026 16:32:22 +0200 (EET)
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
Subject: [PATCH v10 net-next 02/15] gro: flushing when CWR is set negatively affects AccECN
Date: Wed, 21 Jan 2026 15:32:02 +0100
Message-Id: <20260121143215.14717-3-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E6:EE_|AS5PR07MB9769:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e918d26-f8bd-4513-09de-08de58f9e4f5
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MWs5aUhEWlRGSnZScTI4Mkx6Mzlwd0xGbnF6NFFDei9uaklYV3BtUW50SHJZ?=
 =?utf-8?B?K0RBUGJMbzl2SzZsQmhBQlFyYW5Jajg4ZzRIUkJ0Z01vdlVnOVQrSmxXVUR0?=
 =?utf-8?B?RzZITjk1dU4vaEx2QUF6R2lCbzMrTnhMMGlvQlZLVXNDRVMreXRKTUtDckdX?=
 =?utf-8?B?STl2eXQ4Y0NlRmVaL2Ixd3lFMDdOS3h4Zm1xQ0Y2bnRUYWVudXFzbmd2c283?=
 =?utf-8?B?eUVpQjY3K2xjVUZ0QkhVdEwvTHJ2Vm83eVNzNk5GWkFoVUFqb0dhejJENStu?=
 =?utf-8?B?VWFpb1hQZVgzKytHMWF6SzZrQ0l4Qmo4TktPeStNR2Z4TWxiVXJNbmwzaUd3?=
 =?utf-8?B?NzRiY2liOElkaFREcmdDWS9pUm9peE1zb0VDay9HZzlkVTVJYncvZmtHNEEv?=
 =?utf-8?B?ZGo5WHpTYmNncDlCQ0V1UEc4MlE1THpjTXdveGcybnFGM05Kck5kMUFIQmZB?=
 =?utf-8?B?YnUwRkdUNUdtTGIzR0N2YUZ5cGFTYXFoRytWVE41TjVOWW5nNzVUakRoKzRM?=
 =?utf-8?B?QlZ1MmhjdnNYV0dIazErWjIxTVZ5NXdyckw4K2VJTjhFS2N6YTJEL1JxeWZ6?=
 =?utf-8?B?L2UwbXhyYkljWXo3Nk9zb2lSS0VUcGVZYUFkeEgwcmk3eXZ4TVBTajZXSFhj?=
 =?utf-8?B?UkRCNWE1SG5XZDg1eGRPS3huZzFBRDJvbVNoeWRtVWdlbS9LN1dqdjZ3OHRR?=
 =?utf-8?B?M3ZrdjM0QTc0M1pkaGRlQmtEUzduaVgzVGZmczFsR0ZWalI5eitpT0c0Nyt3?=
 =?utf-8?B?MU1wNWR5SC9lUkUzY0JtT3pJeGdmcWY3emVtdEJkWmR4U3BlRUtxVm1Dc1Jj?=
 =?utf-8?B?eWFiWkE1blAyWmtzZVNLRlNmT0N4U2M3cVFJNXUranRra1JJTm9IQ3VxVkxZ?=
 =?utf-8?B?SVhGZkdvNXgzRkN5Z1hGczBUUDdEWWQzZGcyU3dGS04zVnJRTHRuZWszdVNq?=
 =?utf-8?B?WXdtUXNETTV5TGV2NEpMUG1PRGh4TzEvbTkybnRWellKS1lhWUZqN1gvYURv?=
 =?utf-8?B?TFFJZklvamZCMnE2L3RLT3lpelNySlBuNStML1NKNXZmaTVONnRLVmNoQklx?=
 =?utf-8?B?UG85MnVjVFNsbURMUTc1eFYwaHdGcURzalJONFFUdHBsUWtUcWZhdnJ3cDIw?=
 =?utf-8?B?YS9YOCtYV3lnOUdoeFZOOHhPTDVMODU1SDVadk11Nyt3Zi9UZ3E2V1VkZWtC?=
 =?utf-8?B?ZytCV1l5ek1SN3E3cXkvU2RidkFNZ3JTRlkxbVJBUjU5NUprWHM2TzF1Rld3?=
 =?utf-8?B?WjFkUVJDV2hsRjNYS3FuSGE0bHEzWEFUQlJyT0JBMXV3d3YvQ2dQV2RzT1A4?=
 =?utf-8?B?NThSRHpSdEs1SjhaMDNyQVo5V2pEaVpmWWw4RUMvU3dheHN3ZVdwbGQ2eGZs?=
 =?utf-8?B?Zm41MGdCWnJwL2d3Qkk1aEd6RUh3K21zbGRFckhpM05mRnRmNCtGNFZPTG1w?=
 =?utf-8?B?bS83YVdhdEs2bW9rUkVOTnNNbzJGdlA2ZDB1cmc0SlFnUzJ0NldwaVdzbjhW?=
 =?utf-8?B?Q0RVeXBJTkx5NHBSRTJ6MlltRU93T0pFV0UwcmVQeVk1WGdQREMwWkh4Wjky?=
 =?utf-8?B?amRNdWJKM3lqNlJXWnJKWDBlVTZrQytDOG5sd1dScTlQM3lkQVU4S2o1Zmt3?=
 =?utf-8?B?VnRoZTd6eHVTeXBTa1hlejMyQnNNOGNQZi9QKzgwUlBTTnNnWDNMOU95eGxN?=
 =?utf-8?B?bWIzeUJTam84Y2ppbUJEQTVEdExFZWRJWisvL3NoNmFCYjFMdTQ0YnQ4M2J6?=
 =?utf-8?B?NmxDR3lhcHV3dWt1K2VhUHBFTVdFWEFKU1pvMGZTYWp5a2c0QU5DWTZKWkVO?=
 =?utf-8?B?Z2NKS3ZsV3g2M3lHNzN2UlF6Nm1LSnJFY213MjM2MWxrN255SXM5N2Y0VkNt?=
 =?utf-8?B?OU0vMlFBZUNGdXZEcnMwcWx4VDZXNkFpMUkrTWI0K1NpamExOTRNdDF0eUlC?=
 =?utf-8?B?NFlsU0ZJRWpkaFppMW9WUHNkYzBKRUdKQVhmZjBkZW9ENWtJYWlVMlU3aVFt?=
 =?utf-8?B?VCtIek5qSW8weHVTQzlhZnlNNFVhTFBjNGcvK2xGdzFROFdVRFJoWXJPd1N5?=
 =?utf-8?B?R3BRdUlMRDBpcHRIZkdIS0RHcVk0V1ZPT2pGVjMzeHVXTDdSMXhWQ1liUzl6?=
 =?utf-8?B?WTVpUXpaWlVlRW00cUMzdEVXak5iZCtwUTk4ak8zbVRmNDBuNit1RENUaitW?=
 =?utf-8?B?RVZEVGdrZjlCRjgvaXlieXRlQ25neDR6S0dMbzk5Q09MTlVWemw0VEcxRlps?=
 =?utf-8?Q?doQmNkjUd7Yqo4p4IS0V9niyVvjiLDI+5zPEFUDVqY=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 14:32:24.3727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e918d26-f8bd-4513-09de-08de58f9e4f5
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB9769
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251917-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 1B7C65914A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


