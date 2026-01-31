Return-Path: <netdev+bounces-255516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ID2gDGaBfmlQaAIAu9opvQ
	(envelope-from <netdev+bounces-255516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:25:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD792C4216
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64DFD30059A3
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 22:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F8638A9BA;
	Sat, 31 Jan 2026 22:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="owbuM1ep"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011025.outbound.protection.outlook.com [52.101.65.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D5F38A9B5;
	Sat, 31 Jan 2026 22:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769898339; cv=fail; b=al73YqPWeheETLOpDNqMnH+xO6b5QGJWGbvdHIoKOeSxAbbRVNexp0nDGQEcHcG/6DFTp3jM/VeVJz93EYiQhwlZvuZ15BrUez483IZpVtn32Q7OK9BPrwcrca5HNtUlKPfYHTqImde3QhxQ/JEJDK/NgWzD2Wu5Ql3hH8fd33g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769898339; c=relaxed/simple;
	bh=Y53GIpIaRymNvINdh26usa+y82OoZlD7pBQO6dbKmvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bE360LhQQJg/TvM0ED4/pGWvHbX97RN9TdBUifA65hOpbZErtZt+qh2tninihwQ+0HULnj+9b2JPQZpWoyxTZxMKyS9uDKtnUTR22QAUQxZO/5IYAJ1g8pP0C+4VYflHde7ciz0kyyu5TIoLZkZ9JPsvYSxBU+dPiOOXJCTAxAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=owbuM1ep; arc=fail smtp.client-ip=52.101.65.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJD4ylLfpiTtsNieG1QIo5q0ljROIv5Zuc2tAlNqGmRz5hqSg7tNxsZwcc3c4uokJxc53sJiWtJJU+LAGYiryIkflPErlzMp6PwyiEzUfWE80w4aG5aggdJoZQaRdo9cotil91lmq1wJJAvny6n2uNGOmMAcDOYmkVa1x/y7nXdt/4KxAc7QTNhIkfEmMbBVYEzwAO5ixBpuuYO7zQEakIJvenqB8W6oH9ZgmIjmor53o44nJ8JxmWo+qsg/SSXlbrtJJybGxj6IG71up8DVq9cTf4iXg43Wtr33f2vJ0td0WNXhtRCt5j37iKsm+11JGt1F6qjjPUEMfICz7glzQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeGgc3GXbA+Z4BT0Ec6uTTEwrP8IgHmAp3mG4AHt7UM=;
 b=UW6V9SzN8/pHeqc/FK7DdwPvZCzlsde0FC5/2Bx8EFqSGQXjBpNZYYOkiVRiWVulHHczOxnEHBgekKSZKx6cUdEg8aK/WOr4Dyi4q0Zp5ViTADnlTwZwQ/8FGv+P+0pinvnRAOuuRnnKe+owdWLh5QI4b/y7ZsbFpBe0Tmdx7mNVW+8U4ZOVxw1C5Ru5XgVGmd9RBCtA+CuDFVhmsBE0mOPvmFvc7JibsX1kKIG1VX2v5eV0rU3XEUPh5kfVsdAskMQuevliriI03y5ytjiAtHs28tnrpM4ouSfNOjM9nQY8DjJErAiXDVRq+LAgpnBi/AcpYsEQf50reV6TRbzIHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeGgc3GXbA+Z4BT0Ec6uTTEwrP8IgHmAp3mG4AHt7UM=;
 b=owbuM1epepdzJd3AroU6+1JzfBYONVN3LbnVJF1kJM2x+Qi/ISKwAUtjG5Nllg7tUsM5iZ8SGx8NDBndU8ymspTjTgJop0zFWUmPEvwLFoAZURm1EHXVl0BH2C7f6h4hQi7Ty54SgvtNwM1Odg+p/x1wzMdwMJFgKuMPu5RF5kdmarDvV32mcPBOXqxMIBN81mci7vZ3bPGxDfnP9KAZnXQkvMn28mcMRefUAl5od2yrCA89AW9vRwv6dp8fyas1kOYYYT6Ucx9OVFM/pQvst6hNscbK1u/hdBgNRI8IZb1jcxrCv+1cl7U8l9MiSpgNgATgQjsi4uHorcxtEFzJVQ==
Received: from DU6P191CA0057.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::15)
 by PA4PR07MB8414.eurprd07.prod.outlook.com (2603:10a6:102:2a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sat, 31 Jan
 2026 22:25:33 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::6c) by DU6P191CA0057.outlook.office365.com
 (2603:10a6:10:53e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.15 via Frontend Transport; Sat,
 31 Jan 2026 22:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Sat, 31 Jan 2026 22:25:33 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 864EB238DD;
	Sun,  1 Feb 2026 00:25:31 +0200 (EET)
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
Subject: [PATCH v13 net-next 01/15] tcp: try to avoid safer when ACKs are thinned
Date: Sat, 31 Jan 2026 23:25:01 +0100
Message-Id: <20260131222515.8485-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|PA4PR07MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: d39d0baa-443d-43b6-5fed-08de6117a61d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEtkaVJ0VFVPdmM4U1hTeHlMWFA1TFcyck43M0ZDa1dabXN0STNidklTQnhX?=
 =?utf-8?B?djIyUkgzcFpYMGhWcFlRZjc3Nkk2Y3dpd0hUSUQ3Nld5bHpXZlpwdmUrYkNF?=
 =?utf-8?B?R2YxeDM3UFFScG5GNmlKSmI4V3FKNks0bzRxdlBvRGVpZHdualQvRE0zRTdq?=
 =?utf-8?B?Nnh3Y2pLYW1Fejh4QzZHTGZzZDFTeWpzdlhDbmFqR2d1NTQ5SktLY0pHYUVC?=
 =?utf-8?B?YnFxeWx0UmpjR0RPbmRnVk1rcGxkTGxmb3BncVNjcDdlNktkZmFNZG1LUW1i?=
 =?utf-8?B?OHJMRVBHdmQrUitydUx2N3hDUWFkNmZ2QmNKRm80TTZzKzR3d0cvSG1iaU9X?=
 =?utf-8?B?MDNOMUpaSnVGb003SFlzKzdjTjhxY0g3WUh0dkczeUJiTllxdmRMTXdhUXZi?=
 =?utf-8?B?ODMxeW9TeTN4djVEQTdKYmpSMDZydzRGTVVZNUVHUGxRZzM4QnZicUpLdVdl?=
 =?utf-8?B?S1d5VmFMT3pBU04vRENuai95akE1WUZ2Tmx1ZWxFR0htVWN6V3c5MXpCR2hF?=
 =?utf-8?B?VW1CdnNldGpibmRGa1VGa2xHdFZ2emxMQUVFQ0RHMkM5RTBzMlhWWk1SNmtS?=
 =?utf-8?B?NUJBOE81UWlJNjZzWnZKZE54S2J5WWpzVFptTkRpWWtMa0ZXaGEzblFMWXJX?=
 =?utf-8?B?K0ZXUTd5akE5TmFQRGlVVVBpNUJYbUYzSUk5TC8yY1dIS0Q5MG1COTkzeFQ0?=
 =?utf-8?B?MnpaN2pweGQzeHcyazVaWjNIZ2lZU09pc1JBRlpWSVNnallFSzNNd3NlMzA0?=
 =?utf-8?B?eXpYZGNQRkdMenFyQUhRYWFZeEJFZEhxNXhiTW55US9pRXNpNlBWY3hHWjVC?=
 =?utf-8?B?RDRuRkFaTWpvVTF0UGFQelF4L0VCbW5LVW9mYWY2Y1ZieEtwdzFrUEtJWGIr?=
 =?utf-8?B?bWxKcnVrSmhHUWtpZldDalVnNkdJVGw0TlcxMzJqb1lUQ1JZdlRYOWxIYUpS?=
 =?utf-8?B?TGRMcmthcHUvRXRWSmZxa3ZBYVRXK0htUkRLQTV5WXNQMTZJNzdneUFJaVVm?=
 =?utf-8?B?Rkpkc3ZJRU0zNGpwTHFlVkplMEdlODdDUXFzVXJpRjJqa0xPMTZYUnZmREFD?=
 =?utf-8?B?RFV2VjdGYzZFWExVT3NhVDdYMEtuRW5vUUd4VVZjSVczQloxek9zVGxXaXRI?=
 =?utf-8?B?RU1veFdBZDIwL1g3aDRlYzlyQlRLU0xGcmNnWWkySjcrNk53c29oSlk5d2g4?=
 =?utf-8?B?aXBrS1lwYlg5b2dlTzBWZWJJaXNuR2Z0QkFkODJndjRzMWp2THpqdVJERkZP?=
 =?utf-8?B?NDlCYmt4RkRnQ1JrYmpmRTZCT0RBbkVkU1hGN0Vzc1I2WlRVVEhIQnFhakN1?=
 =?utf-8?B?Yk5KYkQ5RHVtODNwNTRNeHJtSzlnNkpMLzVnRXVlWnJJcFdlTXVENXpuYm9D?=
 =?utf-8?B?YWpwb25GbHVXY3NjNkx2blJraFBxaDFqSGp5aXVhVVdYSWRDcmg1Q3BxQ2tY?=
 =?utf-8?B?U01RZm4vaXEvb2F4N2VmQnVGRUJnZ28yQmFlLzFHZ2hxSG9pWkNpOEw2VEpM?=
 =?utf-8?B?d2g2bjM0cTdoVXhQeFR1ME5RbldKRTMvVmVpRk9kRmpRUGpVc3hiRFJsUHU2?=
 =?utf-8?B?TFlRNU0zREc5TEkwUVBWOHJxMnNyS203VXZNRzZLTGgzZEE0aW4weW9GNml3?=
 =?utf-8?B?Q21CV3llRFZOTkdkd3MzZ0NobVVKbnVEM3ZpUzE1NkJ0ZisyeTFISmRrY1l3?=
 =?utf-8?B?c255dlJ1eDhUekI2Ky9MaStIT25ZVGMrOWlyL3BmblZ3VXNkWFFuSGFJNU1P?=
 =?utf-8?B?anJYOUdMcWhjVTFYZFFTOUNQeHQ0cHFPS3hQUGxMdHN0SURMK0VhWEZVYVUz?=
 =?utf-8?B?TVRUREdiK0N4TlhKYVJpVGFYZFBzRFN0VkorRjdRUmdtWDJQSDNZaFVkUzNj?=
 =?utf-8?B?dnZBVkxteUx6Q0U2TEhFYXRTTDR4RnIxK05USmZPUCt0ZEwwaEhSK2lqZjlK?=
 =?utf-8?B?ejJQc0xreitDTW02QXdQOG9WQ1pRcmdlc3hXOUFyRzMrQzNxZllmbkl2RGtK?=
 =?utf-8?B?ejlyYk9ZVVVEbE5ncjZRY01SaWRGY2VhUEtxMUYvVnhJKzdCeXRuK2JFY25r?=
 =?utf-8?B?MStYVVYxdXVEK0ducFJINWc3UW1pbkFXVC80WHk4TTR1bzZMOHEyN2VKWFZi?=
 =?utf-8?B?a2FrNGN0aGpQRTJ5REJzNVQrVWhIQmFKbDY3dUJsTEhMYWhMdFA4U3ZiNTRE?=
 =?utf-8?B?RjY1ekJiMFlXR3R5U0s5dE9SNThHak1pMGdqazkvT1VlYlRPOGdURWxSKzZx?=
 =?utf-8?Q?3LEWUuNh6wOcyXbT/ZgAUhR/02z/ibBe1UoG29SXsY=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0zXZl+9IgdgX2FyxiTcTnDFnf2sjGIyamf72j/e47pLliB3Hv9NbDgvA4jciKIEh1DwhNrnPX6RwTBJuRTHTHaUQiQBtFKxEyK57ba9Z9TTCt2DZjriOMxqAe3BhFS0jx/UZz5JW4MXhI1QOAoss6XNdqlBf7yV+01Fke2bCGFgnkDj5IMRVJ4dGZrZ9Xzek6uojgxFaQlzCwFiS9O+fr6CyacqH/vDdfAa5nrDk/CKtfIxtGYklhx7kjpXW2Yr9K/PQXsOCd2/8x23b9bYa8IJZg+YiwM0tGqDWxLomYHsRGcx/bCjtmf6I3b9S0EeD0qFoqoLY0R7sqTlZUmJIpYorm4vPzhmGnmH3Z/ljh4PtA0IOmxvy12+bNou1d4vXNuTD7hFByT2YLPUUQEqmMwTqKjm4VF/uL7W9HsfO8wJEkcd30fSRALfg32Y2VjVY
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 22:25:33.1469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d39d0baa-443d-43b6-5fed-08de6117a61d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB8414
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255516-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BD792C4216
X-Rspamd-Action: no action

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
index 367b491ddf97..fbc514d582e7 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -342,6 +342,7 @@ struct tcp_sock {
 	u32	rate_interval_us;  /* saved rate sample: time elapsed */
 	u32	rcv_rtt_last_tsecr;
 	u32	delivered_ecn_bytes[3];
+	u16	pkts_acked_ewma;/* Pkts acked EWMA for AccECN cep heuristic */
 	u64	first_tx_mstamp;  /* start of window send phase */
 	u64	delivered_mstamp; /* time we reached "delivered" */
 	u64	bytes_acked;	/* RFC4898 tcpEStatsAppHCThruOctetsAcked
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e4009158b908..6e5bb1ab2962 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3479,6 +3479,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
+	tp->pkts_acked_ewma = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5252,6 +5253,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_interval_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_last_tsecr);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_ecn_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, pkts_acked_ewma);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, first_tx_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index a2a872382fc0..38852e04229a 100644
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


