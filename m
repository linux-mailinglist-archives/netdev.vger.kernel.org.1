Return-Path: <netdev+bounces-303160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ANQfA7a6Q2rifwoAu9opvQ
	(envelope-from <netdev+bounces-303160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:46:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6338A6E4610
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:46:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=ZAnko1jy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303160-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303160-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2624312B1D9
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF52C3F44F3;
	Tue, 30 Jun 2026 12:41:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020131.outbound.protection.outlook.com [52.101.196.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B3340E8FC;
	Tue, 30 Jun 2026 12:41:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823313; cv=fail; b=K/log4SJWMjIlogeo+IVlhUp2Uzx1RB4bGaYbXHYmrQ/HcgYXrpcAox/vGtG2qxap6dbducKRQXuY3fkS2/SWlxZf3CodnKRAiCaswjZfLw5yzVoZrW8dEbj8aNHJZBziPm1/uqCRHiWTijjMo0m7SaPZgI1tC5ne3kK64ptpXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823313; c=relaxed/simple;
	bh=HQ5oRlnokZ93NXq53btkQvwDykQ5Q/V8j2dRTwEdAyw=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=D/Ugk7bbpYBY0azKffjWmvl9CwT3aTbNRZCKMdwNVaivRzBEa8syzjpBG8oMNRf+5Vb1Z9jvcjEbyFvEeIa6WDOfU46qsxvAMhEQ1JZ0pb8lo366aoT1y83pcJH8WhhqWtHoXYc41iSUD98YheIGPLr78v0NQyyNm1J766uDLeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ZAnko1jy; arc=fail smtp.client-ip=52.101.196.131
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yO5LQOeF2ffGErUntv4O5VvwpCBj6LZbCzvYmCjuZUjAXh92S/2xLGY/rI9sPYz0IhbWrrkiBn9TjEYAvoJUoT8N47K83dvjT1KVdaEZAtPxEwsBOs5kPk04uIOXidSDE9X3JqRCVBWvCMa8ZRcEjEFwDbaUms0PHbYaKHSKXs2pOffOMB0031gb+g0OD+Nvvr+eZA6QWjMVkB+OySyoNP7j77bJ7X1Y+kuaJObgx8wru1m3ziy57Qyjr4r6NwYuBcYLk3J0nGMuW5vyVMslT33m57BFYsO6Ig/ZX0DPD4qFncBOi0+ZwM7kCOdTWIEB0p2XTYrqhvLWLDOGBhlAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7C+ij/IBqb9IZNxaIQnRIecNlJiRn+rTnBLg8PMsxc=;
 b=kRT7v9I8HkuKLZdmbb3PFa7YUkXvnwZjCsOu4YtlQOoSI4I1xGYZqrJ/UGFeAWiY+CWUoX6C5LWNCIVhNlw1tJu+n7e9ngeCPuMT36Zq/R+MMT36yS0Fz1ooTF/vsquOCZvjQA07fbb1BPTHKw2g3fRGhlIU/RgQDHyYNl7akuYLBfXjphI+jpkiXUXo3DPNNv967qMPG3xq5a6uMW9DCvEmpsv3pU7J6UVyF04po8MXG6HTDwVWatIXudFZcKfoXaBEVzJuy8fwqFrZyVw5hYTEYJ5oifyRzrQRbSefFWrbVrzKQKVEiFQty3QAgGjHPTidyhaUg2j+Q8JVz8LKqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7C+ij/IBqb9IZNxaIQnRIecNlJiRn+rTnBLg8PMsxc=;
 b=ZAnko1jy+jox8I1RSrafadGnYwseMZiTg3V2deRttUe4wwhgd6OqKpWFprdMY1xJNC+mZzg16V4auAIWq1E0eSYvv6G2NX8NmeQ2dNYHRKCBbTLIpE89U2NlLE1PVdJTCnvhSs+3t24s8kD7Vk0FfdJ/PF5aX/ChW0dcFMw7nF4=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB3588.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 12:41:45 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 12:41:45 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 13:41:44 +0100
Message-Id: <DJME47JZ4KWH.2S9HL3IL5FBK2@garyguo.net>
To: "Niklas Cassel" <cassel@kernel.org>, "Gary Guo" <gary@garyguo.net>
Cc: "Bjorn Helgaas" <bhelgaas@google.com>, "Zhenzhong Duan"
 <zhenzhong.duan@gmail.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, "Damien Le Moal"
 <dlemoal@kernel.org>, "GOTO Masanori" <gotom@debian.or.jp>, "YOKOTA
 Hiroshi" <yokota@netlab.is.tsukuba.ac.jp>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, "Vaibhav Gupta" <vaibhavgupta40@gmail.com>,
 "Jens Taprogge" <jens.taprogge@taprogge.org>, "Ido Schimmel"
 <idosch@nvidia.com>, "Petr Machata" <petrm@nvidia.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <linux-pci@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-ide@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
 <industrypack-devel@lists.sourceforge.net>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] ata: don't keep pci_device_id
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260630-pci_id_fix-v2-0-b834a98c0af2@garyguo.net>
 <20260630-pci_id_fix-v2-1-b834a98c0af2@garyguo.net>
 <akOvhr-X1Wp9iNd8@ryzen>
In-Reply-To: <akOvhr-X1Wp9iNd8@ryzen>
X-ClientProxiedBy: LO4P265CA0042.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB3588:EE_
X-MS-Office365-Filtering-Correlation-Id: 817cd1f6-5a30-49b3-8874-08ded6a4f1e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|23010399003|7416014|376014|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	8r4Om6DjTyyFamzwaUIDNRUMn+7ZtiSS59PXScodezdPog0ImzQwk/wTH2yC+zFD47JN1hjFfRQM7TMSuoKwF7+mGG1hgIHq7wLXVlzADieQiZQfKCQPHPMxQo90AfRVWKa52lsTtGoJ+jX5SgC0f11pSOOAcQAmvpCcHWH1qU7efXAXkzPaJpAt7M8OdJuA8Oje+86o5pRXzkO+UKikG1CevuCCqONZUZsPhI3el5Msd0p5Svk/PkxdyrmcebA1EPyKEwOlp+v8feyQPIIjB5CLl+xcFzXT6Xe2PcCf5oxShquOOZDaTxMAcgfrkn01iN9uCbM1ywnSAU91aySR1VRenexOab0DMvnsKmkMNVwh15xYyV9XoH0wwV1d+vIj2Hx4p0RRGoKY/Ixw5Mrha3odfHmtDpCSrF7FVKYHYksjmDDyVFaoUSu1se4p3mWzO2/9CnI8H84avbzbDorMRNfIbojeIW3Ne+pHzpIB+7NAvM8unC9KHGrPWqdMkFxaX1WI4kpeLWIk8CrzGI2cPpT54HlnLHofPqxa50yzD4hWqw49w4RkKra/OLps/hX/toyT1W5CawpWnR3z5JLVwd8UHZiLk2rA42+4GtX/J3HRGT+ilyK8HMomye3YyMhOvWskhcy3+M3uzXiSKAUr+5R1ORvsTgmRwd5Lon2E2Sg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(23010399003)(7416014)(376014)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkQrQVp6Rnl0ZlZJOHhzUE80d1d5VWl0YVl1T0UzakkyYjEwbFFKQkdPdkRF?=
 =?utf-8?B?SXVxUURnVWR3bVF5Tlpyb0FvQS83TWEycFAvRGhDZXhxcE1BQTd1MVNRbE1C?=
 =?utf-8?B?SW5JV1RpWDNUWnFHdHJBeXIra0RGQkNSUHRVNDFBMVFzc3VlMlpOdUZCcGNs?=
 =?utf-8?B?cW5TZFJKQXJ1Y0tWUnVuZU1qdU5kVlZDVlQrY3lTNTd6WEZiaTlZb1cyd05E?=
 =?utf-8?B?T1RYem0wamhxbnk2ZzVJdUlEaG4rQ0ZHZGxPZzZwWjJmcGZiY1pTTWtKY1Fo?=
 =?utf-8?B?WHUrdjBPekk3YWMva0doS09Dc3Ixa1JGUjl3aGhBRlZHcXpRb2Z6ZmU0VWRD?=
 =?utf-8?B?TjV4dm04WjROdkQ3QUJWc3QyR1JHU0lmQVU4cmI2QWd1OUhlTXJDeE5IK0ZG?=
 =?utf-8?B?VEw5a2s3RTE4dmx5dlZXRTVLcU1Wa2p2OURPaVh6Y0lWWFdaZEo3TVJUeU9p?=
 =?utf-8?B?SFlMbWVhRUFpdzFoVTZwUG9SMmNRRVBwNnV4TXg4YkJocXhLNDFwb1BhVy8x?=
 =?utf-8?B?WWluZ1JUejZsV0g1V3FOQjVDTzFCOEVEbEljWmZaTDVjOTNFTnJnbS84bndE?=
 =?utf-8?B?TTZkYnRTb3Q0Q1EyK0lPSFRpaCtHSzBOekZjWVRpWi9lUmhSU0lNS1piNUxJ?=
 =?utf-8?B?dmpXY3BDeTZLRjR4VnVCcVJUNkViVHc2OWRnSTFYdFFnNGI5RWtvNEo3blk4?=
 =?utf-8?B?M2xkY2w3bVlHS0ZjR3A1dlBIRHYyNitDRDd5emNhK1JhREYyZEZkL3ppSTg5?=
 =?utf-8?B?QUtTcS9YQldxaDQ4SzdYaTFCZkJjTDZWempQK284dFRMMGlRSGxWL1VOSDdo?=
 =?utf-8?B?cVRPZkFzcjFUbzFDZzdUTDR2bG1iNWdOQ0xjaWJHY0hjK1g5NnNoeTZOeGV0?=
 =?utf-8?B?d2twbzk3MUNtZDBpUXpobUY5YmZFNndrVllhY0RoNGhhVHExZ1l1Q3N4Y2JB?=
 =?utf-8?B?ZDNXRm9pRDNPZmE3QnlVekJ2dnRMdEcwbzJzcGRoRlJza2Z0SjgvYlJFMStQ?=
 =?utf-8?B?eDV1eTBocEcyTlRBR1FLajBuRCtGR2ZuQk1tSmFQS1FLeFZnTy9PUjJQWVZt?=
 =?utf-8?B?ODFYakRYbzd2c2VGaEhVU01uTTFBbEt2eEt3RzZhc09kRGpHcmNRcDFmeHNt?=
 =?utf-8?B?ZWo1aWg3eGs3Y1c3Y3dvd2tlQ1oyblNzaHhMdmVMRDdUU25jbEs1bDNOcENU?=
 =?utf-8?B?UC83YXpERkdwWTB1Z2hEcFhvNjdMWFFldGJaa256b2RpNGdBRnIxYXh0Sldk?=
 =?utf-8?B?b1dMV3NmYm1nUmFnZEo3RkQ0SFNnUzc2a0gzdWY1b1p4dHpTRW9SR0h2amtw?=
 =?utf-8?B?NUt5bDFXK2lPcGdVTitxNVV4TUNodG94R1JDQkh4aUs1K0hoenNINk1Gb3g0?=
 =?utf-8?B?UG5IMWhTYWJxMmpucm9UOGlidnBTQjM3MGsyS0VZQmJIR3p5eUlVa3c3L0pn?=
 =?utf-8?B?S2xWMHdpMmdmbzhyQmI3THJkSzFnYXI4M2FrQmppc2NWb0dOcDE0aDBhNDM1?=
 =?utf-8?B?SVNzK2JLL3BsZERBUHFQY3R5eGE0NHU2bS9Ra0JRTzgzaWNQTFplc3ZuMHZJ?=
 =?utf-8?B?VnFYUkNIdm14UEdYblFjYkhkdTYzenU0QUhwUVhscDdjRTU2Zktjb29LczVh?=
 =?utf-8?B?b1Q5WmVaSU5kWEVtc3ZkQlFucU8yWGI0Wk9PTmdCUjh6a255WHdEU1dDZTBI?=
 =?utf-8?B?NER1aUZFMmZXMmJiR25JOFFoU25saDRwMFBNV1JEUlIxdXAyK0VocG9WaGlT?=
 =?utf-8?B?U25vNzYxUTVHb2xTd3BxQ2NGYkFrUVByaDVNUE1BcXBtVDRpY01TOXFJMjRv?=
 =?utf-8?B?cGxWTENpd1ZlczNzQ2JVWnFKODZlY0krV0NpNGt6WmluNU81R3oxTkJXVkFp?=
 =?utf-8?B?VG40eHRobHVwNnRTZDNmbzBHS0FTdHVXa2NRUXMzbXZOTE9oemhLMUhVSlYv?=
 =?utf-8?B?clMyWWNOZ251YmRvR0k3N2s0L2t3N1FPaHBodTJtTENaVzN1Y3cweVZaMnNT?=
 =?utf-8?B?YzFLVFhUSzlLTk5jOFM3MVFjWnRlRzJIZnNndkJlUzNYZnBwVHhrb2VpYlV6?=
 =?utf-8?B?Q2EzQnJsb1lmd1dJWVMyb3plbFJBbnZKdmJ1VmlHM2liUGFWWjJPb3FRM05U?=
 =?utf-8?B?NkZUaFNzN3h6bTJ5VWhJYXRpMXFXRm40QjR1SzFOV05HOE1BVm1ISjdEaDNz?=
 =?utf-8?B?bTlLL01LK2FjSFhPVU54V0Q1L1FBOWt5VFMvOVVSRjRacDZUT1pHYWlhWGpu?=
 =?utf-8?B?Unkwc2p5c1ZNRWxIQWRHTHh2VmM4TEVoWUhhaDRBUWlvRStJcUxJTVZTYnNP?=
 =?utf-8?B?VXRVQlQzUzNxQjJHQ1N6WDlKUHB4S1FBajI0M3hKb0lvczB3MS96dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 817cd1f6-5a30-49b3-8874-08ded6a4f1e1
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 12:41:45.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Rn7PqwIAojPxy9sGOOASpGL858uEzzzfzdt3AkmFDhCVYnKR+WfeazsYPmPJKo+faQuF2IV9INYBw9ErlRQjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3588
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303160-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[gary@garyguo.net,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_RECIPIENTS(0.00)[m:cassel@kernel.org,m:gary@garyguo.net,m:bhelgaas@google.com,m:zhenzhong.duan@gmail.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:dlemoal@kernel.org,m:gotom@debian.or.jp,m:yokota@netlab.is.tsukuba.ac.jp,m:James.Bottomley@hansenpartnership.com,m:martin.petersen@oracle.com,m:vaibhavgupta40@gmail.com,m:jens.taprogge@taprogge.org,m:idosch@nvidia.com,m:petrm@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-pci@vger.kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-ide@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:industrypack-devel@lists.sourceforge.net,m:netdev@vger.kernel.org,m:zhenzhongduan@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,gmail.com,linuxfoundation.org,kernel.org,debian.or.jp,netlab.is.tsukuba.ac.jp,hansenpartnership.com,oracle.com,taprogge.org,nvidia.com,lunn.ch,davemloft.net,redhat.com,vger.kernel.org,lists.linux.dev,lists.sourceforge.net];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6338A6E4610

On Tue Jun 30, 2026 at 12:59 PM BST, Niklas Cassel wrote:
> Hello Gary,
>
> On Tue, Jun 30, 2026 at 12:09:01PM +0100, Gary Guo wrote:
>> pci_device_id is not guaranteed to live longer than probe due to presenc=
e
>> of dynamic ID. All information apart from driver_data can be easily
>> retrieved from pci_dev, so just store driver_data.
>>=20
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>
> Please write a proper commit message.
>
> The commit message should be detailed enough for someone to realize what
> is going on without reading your cover-letter (as information in the cove=
r
> letter in not part of the accepted commit).
>
> 1) Explain how to reproduce.
>
> 2) Explain the problem.
>
> 3) Explain the consequences of the problem. UAF? Crash?
>
> 4) Explain how you fix it.

Hi Niklas,

I see this as a contract mismatch between pci core and drivers, hence the c=
ommit
message just mentions the problem (lifetime of pci_device_id pointer is
restricted to probe only) and the fix (don't store it).

Currently as you said, the way that this becomes a problem is when dynamic =
ID is
involved. So the following sequence will cause issue:

    echo "vendor device" > /sys/bus/pci/drivers/your_driver/new_id
    # PCI core calls probe which stores the ID (e.g. ata)
    echo "vendor device" > /sys/bus/pci/drivers/your_driver/remove_id
    # Driver uses the stored ID (UAF)

However, the gist here is that due to the presence of dynamic ID, pci_devic=
e_id
in probe is not guaranteed to live longer than the probe function (in fact,=
 it
currently is not guaranteed to be alive at all, which is what this series i=
s
trying to address).

Exactly how long the ID is going to live should be up to the PCI core and b=
e
transparent to drivers, so I intentionally left this out from driver fix
patches, this should be implementation detail of PCI core. In fact, in patc=
h 7
I changed to be unconditionally invalid upon return regardless if it is dyn=
amic
ID or not.

At the end of this series I changed the documentation to explicitly state t=
his
contract. So even without having the reproducer, the commit message still m=
akes
sense because it fixes a contract violation and reader can connect it with =
the
documentation.

Best,
Gary

>
>
> AFAICT, this is somehow related to pci_add_dynid(), which is called when
> user-space is doing something like:
>
> $ echo "vendor device" > /sys/bus/pci/drivers/your_driver/new_id
>
>
> Kind regards,
> Niklas

