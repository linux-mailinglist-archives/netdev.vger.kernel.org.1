Return-Path: <netdev+bounces-307298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PeKjAl5yVWo7ogAAu9opvQ
	(envelope-from <netdev+bounces-307298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 01:18:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5958674FAE5
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 01:18:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=MhlxwvUj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307298-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307298-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 906EE3010177
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 23:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D18381EB4;
	Mon, 13 Jul 2026 23:18:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012002.outbound.protection.outlook.com [40.107.200.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8929E2E8B9B
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 23:18:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783984716; cv=fail; b=eoeZGLIrZN/qYIXLbGfDnzy2kK5rlmcf4qU5sbXYaN35kpJwoem52lsJoIRqZWtGW6Sq3OD9GIKUPOSCGo16wVQSt8JsL4hmqTOpKFBR2ph9sRH8QN4MwWQ+5U99dvqwjp0NYrDz7Pg+STv3JgsN73fRXisxZwfG9UYif4HNM4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783984716; c=relaxed/simple;
	bh=jMejcH8E5IKVPEdOqvW6GlIKY8DdapoegXuXyqkpjPE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ut16j6p8I2/fD+5ObNZlJifd0REO/PfGT9s9LV7PVyVJSVLjiBwvadWIAENx42NSaUMBHIwjIGFapjyBiBmGdtd5j1aZ0LY8OrBZQ8/3rpzIdzoabHnwNSCQlpJLj0HcSR58yVOh93YPB9wZl7IvsZltAYjJKk/CI8I+E7PkSwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MhlxwvUj; arc=fail smtp.client-ip=40.107.200.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMikOa8J1Rk+uIH8DTGvwlHAVWc0yijK0KP1YyKw0XX8Ox7Gmc+auGOd+YXGtDyY+EqP0dIym5c5ljJ+O+R0zElS1J9Y/za6o1s/qQH2s/8zEhIFt2nnUE2WJj0cpyHzZgAJk4AOw/q/UE2dbXIfv0l3k/S0Cp1+nGF1qLpR3zK5b/++u6/GXMW1/D4Ay7xQ/TR6aAeBuAb9vSHYWyx/EQI/c3K7gxA4Q9o2rUAzF1MGmNYnr2/GaUPI84RX8N+ZdV84L5eozbrBCl2W0Qfk+kx+tjDkFCTjE6DS54ZbSzr7m/xDPbEuMf0+aw/4+1RzSnDjUOhF72g8hdOPBaZH/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvbKuNcks80DTtEjnkNZv8Vo+Gl+GebVkU1EGHMdPaU=;
 b=lWFrkVed/z2GxsqEG4WPHxmmAOSwfcjXN+w9JO3+uP1ZXlJlTCQbccqkaQRi58xi4i5CmU0DDR2qcTN7NeXP6IB1o/9AOFkqrIj85956/3NzD+6q7ehGMnA+E14eatMI5TGo7gO7NFe4SOl+7mab6D/0r9qzl85e/5sSEdJ6oxOa8crTxkqrdAINJw/okcTst/uIEpdQNgUpJYknGDT7pQuIoSYuAn1KF8G1VMf2JeaDKru28ibhrpks2Yesxd/vMlcjByCAv42VW7pLVfDbS4XrRZ9P4YkhTz8svsFvXwhQeciztyeOzuIjktm5R9TTIUgUpkZ0t3yI1FG7YOSXZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvbKuNcks80DTtEjnkNZv8Vo+Gl+GebVkU1EGHMdPaU=;
 b=MhlxwvUjR7jL8BstuwYqE5yCDpDwu6mH+GB6BtHaR+uOYDgLdHU2gGsGhf8rlKet18Sej49wbbimFdPj4ztZLglGeRuPkuA8GH0FB4f1/uOLHCFCBus9i+2N0Dcp6QuFaJofQTI382GXKC2hsii8vkIX9JH4Om/5bNsdDHWEzDc=
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.18; Mon, 13 Jul 2026 23:18:26 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 23:18:26 +0000
Message-ID: <0d410deb-c670-4837-a87f-d4e8f3c73259@amd.com>
Date: Mon, 13 Jul 2026 16:18:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Ethtool is missing C2C link modes
To: "D H, Siddaraju" <siddaraju.dh@intel.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
 "Das, Shubham" <shubham.das@intel.com>,
 "Srinivasan, Vijay" <vijay.srinivasan@intel.com>,
 "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "singhai.anjali55@gmail.com" <singhai.anjali55@gmail.com>,
 "Brandeburg, Jesse" <jbrandeburg@cloudflare.com>
References: <SN7PR11MB6900E94E718175AACB2309109AFD2@SN7PR11MB6900.namprd11.prod.outlook.com>
From: Eric Joyner <eric.joyner@amd.com>
Content-Language: en-US
In-Reply-To: <SN7PR11MB6900E94E718175AACB2309109AFD2@SN7PR11MB6900.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0001.namprd16.prod.outlook.com
 (2603:10b6:610:50::11) To DS4PR12MB9708.namprd12.prod.outlook.com
 (2603:10b6:8:278::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|SA1PR12MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: 056f53d6-dd65-4cc1-721e-08dee1350aa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pbgZmwbx9fuqvZyHmFjOcPvUY8b0o4PnHyvdFMEygwwjfvI370VcSBf/329Bkdu47JhLA+y1mhnlKqumOWC464FlRr5mBirCTZtBVNkfLN80eIwRBjNVghE6aiYwFFfB3Sa1Z4hCyfMr9XW5LrUIBRp2t8qOdo59P4XdGf+ddsBjRAeM/IuKWiKPdVEl2uKX/68uihaAvqv4O+BE3agGxxapwCX92D2q0Ae2fO3y9fLYeLI7Z/eJ+73kzf/bmWDUdZoWdty9Pr3NZItCRhWVPUuywPP9JOM9amXG+ZUZfVAdwUWPeAcZN/KhC/Et8zlwt/vnBh93vrfFTcYbQ2k7T8N6RH/6xUvNPJtgTbVCHxyTA8kbb+WxnsQCtLmzcSdJbQfGV0NoznoXtB0RJPejhVBUrNx5XikLbzIEKQZRm9rqSytCh8m5sHyKuCc4jEDrzZNkd0ulNCzjJMrGkJuPwMH2OAfqPBN4X+S/dGQOQYnMp0DTrpJJr93Ypxs8+8q0PwCtV+HhsrU40FSW4qEltF/Q/k+oHkYIxwQex6b0o2BmKGKuWjCOuMgRt3N/eMrceW+PdDSPtoloOYlBbYp1mxB0l3R8Mrh8MMDIKQkNSSmF3lIUmJ9AgZf/k1Yh2gSSDcuYhfwRoXHtbgy7jOE5yhrDVTfHGROP07ssscBxRK8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVdyYW5uN0txalJna1VZZDE3cnhyMEVjcTE4VU9BUUErR0RVaUZLSFY0YzFZ?=
 =?utf-8?B?V3VwN05ZZzFSMjM4dTkvbXd1ZkRTUkRxR2c0WnpWMld0L21DSmVEdytVRHUv?=
 =?utf-8?B?b2NSdTBsUHRqQWlXOG9Sejk4RFUyRzdwaUh1S3pkdDRKcUFlRDMwSitNanQz?=
 =?utf-8?B?NXkyK2ErdFhPOWkyNVJNdjhScDU3U3VERXFsYm96RkkzUmVna0p3NUZYOWpD?=
 =?utf-8?B?OEc0dE1VcTYrS2YvUkd4SDg1QXZFZHJaS3E4LzluOGFCZ0QwTGpKbm5la09l?=
 =?utf-8?B?KzdlbU1aKy9YZ3diYlVwc3hUd0I4SHFlUkhSQjZ0YzRQRXJvUTF0YkRhZmo3?=
 =?utf-8?B?UitIMmJNN1l1M0s3ZmRWdEFWeDdVYW4vWW82S3dXTmpJVDFIa3IzU0ZuSlRw?=
 =?utf-8?B?WHJ5b0FPTGZ5ZlR0UVJ2NmhZazQxZ3Z3S1FGaUZvUHVLRjVNcnFrMW1EMkxs?=
 =?utf-8?B?RDV2NG9OenhjVkFZS0VPR0RMSjd6UzA1dXk0S29STVQ2OHFBRTZ1aFA1REF1?=
 =?utf-8?B?d0hsYnpzRUhpUDdFMnk2Y01TOHJWOE10V0F6a3VOdWlRRUhaL29oSE9KR2R1?=
 =?utf-8?B?LzJPU2gxOUVkOEFjdGowcDFYVVo0ZGFEVGpxL2tnODllT2RTanU3Q0EwZU1p?=
 =?utf-8?B?UVYrK0ZTYXpYaHRsNVNYSEJaRnR2TXZpVVRkRGZIdjBrZUhjNHRMNGc1Zm5s?=
 =?utf-8?B?WmFGaVhTL0VweFlKbng2WEZSS09welA1dGZkZjBZVG84NS83b3prMmRLcWZr?=
 =?utf-8?B?RnJ1L0NydHBJVERqVTdJWFNDajd6WkN1THJYQkxLQWF5Y2tmd2RIZHA5L05q?=
 =?utf-8?B?WmdiVzZBS3dvMlVuWW84SHpLV1dnUXZKTFptcytmdWZxZERvQ3NpWlhNNWxR?=
 =?utf-8?B?TEdwQnVpbytMUWNURXdSenlxdHJEMjJxQUdndDREcWtpQzhwYnV0K0RUNllO?=
 =?utf-8?B?bzYzRTJlMmJZSFdRZkFhSjREVklxV1VzWnJNZnUrL21jc2pMWFp0S0hmTUIz?=
 =?utf-8?B?d21VWmhjZElQWEJvL0VVOUpYbkRyUDdGRUNydzVoejloMFBxMmZOLzdWcDZm?=
 =?utf-8?B?UzhscDBldXp6ak0wTXdUQlFFdnJCTmRFSTMvekxWM2JzU0tXM2tmWGwreUJN?=
 =?utf-8?B?dkhOcmV4d1AwUWNqOG5TcWNzNDBobmVRK2ZXakxDaFJJV1lJM0ljakVScjUv?=
 =?utf-8?B?cFNtTExSSFRmazVlQTl6bm4xZzdlTzhpeUdvVUYzaC9YdUNpSkFtc2lqODk5?=
 =?utf-8?B?RE02ZFVERWNzR3d2VERUNEZHOU5jandzeHlJOC9oNXRLdC9ZelcvSjlQRXRi?=
 =?utf-8?B?a21FZWx1TTREeDJySGU0MGRhVVU0UEFWNmNLSlB0b2ZjanUxQ1R0V1V5VjFl?=
 =?utf-8?B?d2w2SURSY1E2QnRSbDhGNUs5S0Z0enVKaE9Sc0x4ZG5RL1FxTVBKRUFkanBF?=
 =?utf-8?B?RVp4aVE4Z3lrdnpjVStobTJWeUZ6aDA3cVVaS3daVUJ3bzlLQUVjQVovK1U4?=
 =?utf-8?B?Wjgrd0t5RFRnR09hVzY0RGVKdU4xYk9QNzJiM2NqcTg2MTZDQTVmYkJYN1ls?=
 =?utf-8?B?VUNDZnYxQSs1M3NvMVRHQ0krT1gwQXd6Y0RxUWFnS3Z2cjRBbDNEK0QrQUVz?=
 =?utf-8?B?aWxyNWlJaWR6UFpPSkJtVjFvcjdreEI3Zk55RmZhNmhTSW9Db1pxa0JmeFdl?=
 =?utf-8?B?bkJzK2hpUTdTcWtyY3ZwU3g0azAxZEVGL0NaaXdnQ3M0VXZ3cElrRTZ3ZHli?=
 =?utf-8?B?RUpDbElWY092RVZ5R0NFbGpLMS9zWUU2NTBvbk50T2N3am5DRU42b3E4TEli?=
 =?utf-8?B?S0g5YzFiRHRCQ0oyb2VacEpISmV0T3I4UHRwVnhnQU9CQzZUQ0l4T0dMUlVo?=
 =?utf-8?B?U3V1M3I5b0RLWk5KaElxN0s2WEhqUklkcXV0R3dFNlJ0U1prSGdHVEF5bTZ6?=
 =?utf-8?B?dHYrYlExVW5FblZtcmtDQkdMTElrbkpHZUFjNlYvTjZvM1E2OXFHQXZ0VW40?=
 =?utf-8?B?bmdzNVc2bmFZL0gwd1VDZjFrTjBOVkNkVjc3TlBjVk1vTVgyajJwN0dEaFd5?=
 =?utf-8?B?T0t4bmhvYklSUUxId21pMHovamliMW1HK3RISnU1R2psdFFqSmk2eGpWV01T?=
 =?utf-8?B?OFk5YS9jdXhnUGFjZElHWTI5TmtRVnpjaUltZ25qY2svaTkrZzVwVmltZ0JY?=
 =?utf-8?B?aklCWWlOcGtITGR3K2hPc2xnNTh4Qis0ZmhrK3R5ZVRJUmxCZld0cmJTRmNo?=
 =?utf-8?B?ZisrK2tvRFIxdnB3aEg0cVgydzR5bm5QUlFaS0Z6d2l1R094NkY0MjdjRzE0?=
 =?utf-8?Q?fo1CWqY41RKUJqZ/nz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 056f53d6-dd65-4cc1-721e-08dee1350aa2
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 23:18:26.2149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGPTb6sX3xx1trM1T9aTK2T5mAUV/9FAVN40yJcSKouMIY0NOt6uVCjR0R1dUdjx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7272
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307298-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:siddaraju.dh@intel.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:mkubecek@suse.cz,m:netdev@vger.kernel.org,m:balaji.chintalapalle@intel.com,m:shubham.das@intel.com,m:vijay.srinivasan@intel.com,m:sridhar.samudrala@intel.com,m:jacob.e.keller@intel.com,m:anthony.l.nguyen@intel.com,m:singhai.anjali55@gmail.com,m:jbrandeburg@cloudflare.com,m:singhaianjali55@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amd.com:from_mime,amd.com:dkim,amd.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5958674FAE5

On 7/10/2026 2:45 PM, D H, Siddaraju wrote:
> Hello Linux Ethernet team, Maxime, Andrew & Michal,
> 
> The IEEE AUI chip-to-chip (C2C) is the accepted standard for connecting
> chips that handle subfunctions within the OSI physical layer. Just to
> pick, the C2C is widely used when connecting Ethernet SoCs with retimers
> and PCS SerDes terminated external-phys to offload PHY sublayer functions.
> 
> With the existing ethtool link modes, we were not able to fit these C2C
> interfaces on any others (we fitted **SGMII interfaces to baseT link modes)
> and we see this as a gap. If you acknowledge this, we plan to send an
> RFC patch to define below listed C2C link modes to ethtool.
> 
> 	10G_SFI_C2C		SFF-8418
> 	25G_AUI_C2C		IEEE 802.3 Annex 109A
> 	CAUI4 C2C		IEEE 802.3 Annex 83D
> 	LAUI2-C2C		IEEE 802.3 Annex 135B
> 	50GAUI-1 C2C		IEEE 802.3 Annex 135F
> 	200GAUI-4 C2C		IEEE 802.3 Annex 120D
> 	100GAUI-1 C2C		IEEE 802.3ck Annex 120F
> 	200GAUI-2 C2C		IEEE 802.3ck Clause 162
> 	400GAUI-4 C2C		IEEE 802.3ck Clause 163
> 
> - Thank you,
> Siddaraju D H
> 

I'll piggyback on this thread because I have a related question about missing
ethtool link modes: what about entries for various Active Cable types? e.g. AOC,
ACC, and AEC for the appropriate speeds.

I see some drivers (like i40e and ice) detect these and map them to SR or DA/CR
types, but I don't see them do it in a consistent pattern, either. I couldn't
find anything that suggested a precedent on how to handle these.

- Eric

