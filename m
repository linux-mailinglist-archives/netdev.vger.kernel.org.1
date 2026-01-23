Return-Path: <netdev+bounces-252761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4P/ZGI1Jc2mHuQAAu9opvQ
	(envelope-from <netdev+bounces-252761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:12:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEE0740C1
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C138D30A347E
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A490374190;
	Fri, 23 Jan 2026 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="EXpmarZc"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013005.outbound.protection.outlook.com [40.107.162.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C642283FC5;
	Fri, 23 Jan 2026 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162874; cv=fail; b=iqNVbLzpEDz8m4wPj8+e6j8n6rygB1tlZNCJI7Ys14T64bqtw1NmtUQsgZH3MzaG26ZuswlGn5uXNfHFI/X0yTchqeNGRGV0OD85FsnfF++sib/GqZP1E5zvmrpXymaxPyBq/2M+xIrxaHFxdDYsDYtVuDPUkUiBz3Bx0vHbnog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162874; c=relaxed/simple;
	bh=KTf8Q9CQcPUMQQLmoQ5u81rk3noWRcWUTroiJqZNLF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEsOzd6DbuX2UQyrccpiBUc45TrfFHYaIEh+0OJGUjUtbPt/xu0Mx0Q2fov8Vahxsd8sHv6zXnzD8IPeunR91qsWKzI6/sYEFZKVdSTTTdGmgIpyFHzDhI4ePi9CXzIxRrn+bKH0mMAOvoUG+1+Qut44uUUzpud3GvjzX6vcGzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=EXpmarZc; arc=fail smtp.client-ip=40.107.162.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hf3x1IGjE0dYnD13+0KNd821CGPiq/ajx+U9b8+rDRaENv97WJXem+azjNSr5QL6ZbYpJmUoFJLvdJ3KCD9zkIOKyy8rZVtuscZLWCvTmZgRM7OJ7rp5ucCpBRXD1U7XcDRXFt9gY0aiW9wEpNeTFQcJMt2NrmRGCbw7Zs4fyecBnRvycLbpwgmDhDyPdQip7wDZFR0hte61e/hR3WO2UKKJg+paqWZpp57GSMshOVOjCuho9V1ZB8XpAe7m4MTVDyB/TdByolGkNxZCrCZ0I5LaRkjOxqmj7FacB3xOk4EOBg+8GYUqL8xyaYMbKDKTzfDiCVcLYZxYoLn9aUDpyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1jIO5JCbz6bw+e9destp2P300pOskm9/vZvAWNarMY=;
 b=Jxr02/Osdij9lhVC+H+2gonzi1AHu+/BNJpcJDBCoQ416ZaVlfIK3JiFKTJVqkxK7Igl2luW8cYdzSpllWQo8X/1cR13PU+0JJVOxXvkVOxFadHXLu62v4aB5UBO+39fV+ywTwSEb3a6rPjQ21HLACyQ4a/8poX+Fq4sFUN9TdXRmqUt+anJdkri8nMLuU4B5jKXXd2wvhK8t0ETpYjoeSjoLcUeOQTVsQP8NFPXBASNkvZ26V9LlZoP863/Mb9zVvOyESCsWuD5OJsUuwxAXtVq3MqM7x8EeCsKKUqTM46hWamMWTQfCEyF/tOlqj5KIp1GE3yxX00Dr92yxknX2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1jIO5JCbz6bw+e9destp2P300pOskm9/vZvAWNarMY=;
 b=EXpmarZcCJcl9R9Wyhy+1SPbao2THwBCFwmFnNs592lFUwdSp5sQHavPJD/9+UxqCftM6EP7IdtRRhYQPaTSnhG+ojBMXBLMaRv72XAJ/VWwEBOraNtvgBjIL+k980WDJHUmonPeo2BwMyEwMx+z5b5aaKfh+YuE8lTE9Uj6guLuQCfXuKFNj6UYQJPiXJjhQ+qGhGHJ47i/fg16Y4bDmPsWf1J6cLZ1sSV+VxljWDrvygk+2ljz0+eNFdqW+kb2+CqH+Ub9DZqoUkyx5c5ICi075xo9FoR+Y4swo1DpkwVzrVFTh+iCXoGJ3nWux0HrpNlttQLFpLENRIrEMzu0Bg==
Received: from DB3PR06CA0002.eurprd06.prod.outlook.com (2603:10a6:8:1::15) by
 AM8PR07MB8279.eurprd07.prod.outlook.com (2603:10a6:20b:326::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:07:33 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:8:1:cafe::43) by DB3PR06CA0002.outlook.office365.com
 (2603:10a6:8:1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 10:07:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Fri, 23 Jan 2026 10:07:32 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 4613F1C003E;
	Fri, 23 Jan 2026 12:07:31 +0200 (EET)
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
Subject: [PATCH v11 net-next 04/15] tcp: ECT_1_NEGOTIATION and NEEDS_ACCECN identifiers
Date: Fri, 23 Jan 2026 11:07:10 +0100
Message-Id: <20260123100721.42451-5-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|AM8PR07MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: 38152297-edbd-4679-ab4c-08de5a6739b2
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NWMwUmh0QTR4b2c0S1hwbUIxbWp6MTNoOHM3c1lxMFpubFZDejk2dWhPcCtG?=
 =?utf-8?B?RDZ0QWJQK3VHdnZpeStMWUsxQUNUek9jc1JtRDA1OGJrNC85VFg5bFYyTmxP?=
 =?utf-8?B?OFZQSStUNllBc3ZYUDAvWVNJdC9vR0dWWGNlSUlmSlAxNUJ4Wld6WXVFMXlD?=
 =?utf-8?B?NHdLNnFCcTJBT0FFb2ZHemZyN1luelFQNHVNSS9DNUliVFAyeTkrbEZEVlFQ?=
 =?utf-8?B?d044aUJQaG5hb0gyUlFUMGhudXlWMXR3dlBZbEtaNlRqcUl3bi9GSGxEcmNj?=
 =?utf-8?B?SVY0ZHZPWU9hc3V5cWU5MnBDbnNqNjRQWFJONzZlc085bVYrRldTczdBcnVH?=
 =?utf-8?B?SG1iZWlBNTJhNjMwUXhESU90NEFFOVJPeS85OCthS0ZiaU5qQVR3K1pVSGoz?=
 =?utf-8?B?bHJmdVdrRlFXREYyb0IrYWJrME95aXVrM1FiR1pqWmp1ZzkxQ2tCNWwydWpR?=
 =?utf-8?B?TnJrM2FJbmdmUmJhV3RIVWREc2Z2c3ZsOExnSnozRFlwS1YvajV6c3YxaGtw?=
 =?utf-8?B?ejI2SE5JK1h6dzBEbWpFMFk2N29JWC9LWnVBdXd1YjNyUmVmSnR4R0FhYmNi?=
 =?utf-8?B?MkZFL1R0RUZoTGJON0RXeGE5a2dCbkRBUWR0VUh4UjdrZ2U0UWgyVXBITFZs?=
 =?utf-8?B?RGh3UE9UZ1ptOWh5RHFhbm1FS0d6WnpNcld3SnBSZFhFb3h4RFdNeVJQNnhI?=
 =?utf-8?B?N3RzTFZTNDY0ZWZDYVlTMmtGZ3JzME5iWmFXU3hjSlc4Wm9iL0RQc1pIU1dp?=
 =?utf-8?B?N1JGaFIxSHN6NEE5VDVUazdIOEVGd3pNT21sZ1RZNUIyVUxjYTVnVjVBc0tw?=
 =?utf-8?B?akZmaHNTQXBTN3JYWFZKdnowbEZGWTA3UzBhZytWaG1PSnBQenZBMW02bjVE?=
 =?utf-8?B?TGZpR21SVEFEMnQrQTJvOXptalY3UVdOSVNCRXFxcE1OR0Urd0ZQL2VldnVp?=
 =?utf-8?B?eWd0YVlhOThhMm5GY0tKTm5oY3ZuSUQ0MmlwWG1YS1ZpMUNCZnF3YkJqTXhk?=
 =?utf-8?B?QW9wbXJLNXJQMDZOa1lpSGJUNXFTV0VDL2hWejBJcmlHVnRENHI5RWhJaWJR?=
 =?utf-8?B?WVRRNzhpYUFaK0hRZU0vTVdmdzJJTzh1T2lWODNpYXlyeUU2TnNsbVZ3ZVJT?=
 =?utf-8?B?ajFTTnVCeWxpWUhlbXR2eGhBYlBnSXZ5S2x3NnQ2VTdiVXBWZWd1dklPdi9l?=
 =?utf-8?B?VWN6MFA5aU1mS3ZwNzBmaFJ1N3pITVhSMUY5c1hacEF5Z1BDV01hK2g2NlZt?=
 =?utf-8?B?Sk01bjdNUjdpZ29TRzhQTWNRUHp0UldNSkVHRjZGMkkwTDNtTEdCVlJEaGs5?=
 =?utf-8?B?QjB0SXNaVGlZSSszbTZxMGRYR05zUklMMktGSXd6S081bUVmMW1ubnNkQ1M4?=
 =?utf-8?B?c2FHcWova0FrZ09zM24xeE9td1hKRzBFSkI3Z0hIM2MxZUZ4WlFyYkVNWHNP?=
 =?utf-8?B?Wk5pZU5SNFlOcEVZczlsSjZPMExnVkNlRUZSNE4rUnRiR2V6QXBjalZqdEZl?=
 =?utf-8?B?M3FyV0hxZmZ6VTQ4MVVEeDJxUXJDTGdBNlJNN200YUtLYXBXbXZuYnZ2M3lB?=
 =?utf-8?B?ekU5Z1owWit4ZzZ0MHd6c29SUGpUU3JOL08rb05wMWRBamU0SUNXSWN3TkxR?=
 =?utf-8?B?NEtLbHpLSEloNStLcHNkcWhqL2lWVDg1Lzh5RUpGTjhTNUUvQVN2MVpjMEh1?=
 =?utf-8?B?TWlVVklBVHhEVkRiR3lJMUtqTjFIdzV3S1Q3NWZ0cUd0M29QWndnZElPSEdG?=
 =?utf-8?B?RzE3aE8zUDJVN2JWNmlhelhBdkdtMnV2Sk5ZbVpWM0ZpU2xTTkExaE11R0tF?=
 =?utf-8?B?Z2lpaHI0aEU3SG03WWhJWms5Y2JXNkR5anhHdUxGMUo3V3ZXZm9GemwvaEtm?=
 =?utf-8?B?cG9acElHelc3K0I2UTYrR0VHdm5rNC8xZlNsVUNIeFY4dTBpWnFmTzQvU2JD?=
 =?utf-8?B?VnJXV2gzWjFJUGtIZDNteTdkTUJWYTdUb0xuLzNSeEY0RVN6a254SFRyWnZz?=
 =?utf-8?B?WTkvMzFCUUc3OVhCYXNMaG1DYUo5Y1NJZ2NOTUlHaU0zZFJzQjVlQ01ZbTNa?=
 =?utf-8?B?ZmI2QjYwblhVZW9UdS9LbkNxM2RlL3NRdUpwUVczV0lTWkpEZEZkUU9vY0JD?=
 =?utf-8?B?a3ZsS0U0U25HUkdXVGxMQ2R5bVBLOVRKMnplOU8wenA0SGhWUElBc1hMRThw?=
 =?utf-8?B?dEdxWGJlVE5laHNFMlROSThGRVpKd0t1SERNZFBlZE9oMjBGTFhEckdqY3Vr?=
 =?utf-8?Q?CyBSYthDJkqWsMbUXxE99yBvaThNPBKNBe+2M208Ak=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:07:32.8506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38152297-edbd-4679-ab4c-08de5a6739b2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8279
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
	TAGGED_FROM(0.00)[bounces-252761-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BCEE0740C1
X-Rspamd-Action: no action

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
index efff433de9a4..ba347b87a63c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1204,7 +1204,12 @@ enum tcp_ca_ack_event_flags {
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
 
@@ -1345,6 +1350,20 @@ static inline bool tcp_ca_needs_ecn(const struct sock *sk)
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
index 5fe0e1d2c076..cbc8e28fe492 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7420,7 +7420,8 @@ static void tcp_ecn_create_request(struct request_sock *req,
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


