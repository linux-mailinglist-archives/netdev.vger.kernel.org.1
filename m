Return-Path: <netdev+bounces-260636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKQ3C5D3nWlzSwQAu9opvQ
	(envelope-from <netdev+bounces-260636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 20:10:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB9B18BB27
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 20:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F8A4303908B
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 19:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0792F3620;
	Tue, 24 Feb 2026 19:10:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022127.outbound.protection.outlook.com [52.101.96.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3B32F12AB;
	Tue, 24 Feb 2026 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960203; cv=fail; b=X2vNmNvoI3qoSm4eEDE5xUb65N3HQSgkjYGZvz8o2mSGt7wIkYdTOhhhL7SSg5Qhesqr39bdvEe04yi/+d4CF77XtUI8M4hEbVCwU8ypoNUZPcuQ5MWR5XH+TbPovdt47FzIO1oAanZMWpO5O9TSSXdSlUAWhpxQUBWryYA6jdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960203; c=relaxed/simple;
	bh=T0PiaHL0JASDoIjmJGAfrZZ5SPMWTdt5Yo9F04lF7y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jWEEJRotpwHnzT5skAIhOUidRDAhg/B5uZs8srwRKAFCgScRlS5/H+aaUsi2sUzpNnyH8kqcNYBOVCAEo9ujhxuCB3feCmFY1N4zLhRcfJNtpGz85ndv8KI2hyeOvhyo9rRy2C9OHFinPIkOLWEwWBAIAAHcSv2GhjirYYsCf+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDgKLxWeDAlPwLOT+Z0SgOEzwFFDRPbMYViMMqjD1yMHq+hikelNU4VlOspyG6QBQ4HRGQBoxC0VYnak/aT2ZOqXoDmuwrKN4p7LZHnPYM3g/NZcpVeoyB5qCTe7MFvEEKIzlVnMr3zsBhLcaYJLaPBIzu6jthKyYbzONSCdQODluXOzuLZz3LXAAz5V2i4O/2yJ66jDrRjAJ5xcxk68UFrMqGZfhbDCsvcBNOanehF0Ud2yvesW+o9N+yhcZTg9gZvV2lVmW4Kby1TyGsXuuFtktLSql2ICEeAWO4lby8C9ldR4aCNnLr+u92AOQ1qbx78XT8fUA7Y3SvUEhLGemA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kz0Izp4SN6ME7ombVoXW/lE66Fs++XNFrACm6tKVSWY=;
 b=hSkBRiPOhQkI+QlyKGyqW1L6adoY4OdomB6i+/zlg52SkIESpxtHZkLFmSN6ca7u4R2aB43CC1NrfayxZl/E2vp7rQ0rF4T86JToytW4fVEUbAUFAZ9jqPET6Dz6ToDTjtkxfaM9eAcoF525z9VjhFE+DbhJtAppv3a/7TT6AmdRzSd4WyGcLgDA4XfNV4qlEUsbSW1H79gAbdQSo2xQBGsWfNHtaM/kaOdCbM9zUyM2dp92cTxrjwAb/IKQr6YN1ficnUpDJ1i6PHF5dyCfVhLRlO0XIKsTg+WGruAg2FCi+mwFXvHJZ90P4ap5xKoE0ySYnnfwEbyLpkONRwbRbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB3811.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 19:09:58 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9632.015; Tue, 24 Feb 2026
 19:09:56 +0000
Date: Tue, 24 Feb 2026 14:09:50 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: ronak.doshi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	da.anzani@gmail.com, sean@ashe.io, mproche@gmail.com
Subject: Re: [PATCH] vmxnet3: Suppress page allocation warning for massive Rx
 Data ring
Message-ID: <chvcem67j3qf7iou74x7pyux762yk5mi2s53e4fc3de4khovty@tnjaziz4yzmi>
References: <20260223145604.4042568-1-atomlin@atomlin.com>
 <58a37819-78ef-44c0-8e85-fce42ac569af@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58a37819-78ef-44c0-8e85-fce42ac569af@huawei.com>
X-ClientProxiedBy: PH0PR07CA0077.namprd07.prod.outlook.com
 (2603:10b6:510:f::22) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB3811:EE_
X-MS-Office365-Filtering-Correlation-Id: 3635396c-dee6-4a51-3e4c-08de73d84c5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjIvWlRzTE1hbXFMNlRycjVWeUFtdXdpNEFuUXVjQmJkM1YyQXhlbFlpNGFw?=
 =?utf-8?B?aU9FZHBvRGcxTDFOcTlQeWsxaFA5L3lmOXpXb1VIbWVHbU1vMUJNSEFERDRu?=
 =?utf-8?B?L01MWmZIUzRIVUlnVktvekJ1SG5OQXdsNmMrSXdQODdSZEZHMkNuZ2htVnFO?=
 =?utf-8?B?aG9RdDBFbFFacW94S0p1RFhJRDA3Y0owUndGSUpFakQyWWJIczU0Nk5DYmZt?=
 =?utf-8?B?cTZXN3NDVjhJVTNzWU5peWpyY2t1aXdqSW5kK3g4NHl3NTRWNEJFdWZYcUJG?=
 =?utf-8?B?QThOcDhvRWsxNFVLL0ZvcXhmUHo1RWpTK2VJMHk2dGJzY1lHUVJhU1dyOTFh?=
 =?utf-8?B?THMya25meUFmaTlFVnJhYTRnd1l3ZUxPdGpNOHVRbVYrUXlPazcyazBLMHBY?=
 =?utf-8?B?TXkxa0hLSUVSS3BsaHBiTm85YXpoWEVLK25Ia1VDNzVqWjNpd3B0dDNnd3ZT?=
 =?utf-8?B?dEtRdFRDT0E3ZkVJQmF0U0JCVWNha3hDVWN3eTRxN2tkdjNXa01QZzhSVzNt?=
 =?utf-8?B?bSt1amFmN1YydXJKTGcwWlh0OXJrN1QvckpNWmhOYlNYVndDbU1TSzNqQ2ls?=
 =?utf-8?B?bGxUZE1YM1NFNGp6ZEEyWm5kV2JxM0RuMStBdlBabU9DbEFROVFwS1Z3eHlw?=
 =?utf-8?B?MmltQ2JocFFCa0pPeENmbkM5elBEMTUzQTJkbGxVNU5FVnBZY01OUC9WZWp2?=
 =?utf-8?B?b3F4Sjhhcm1WTk1jYTQ1SndBNi9pbHJaREI2OVhieUxha2ZCR2F5QmthM2Fw?=
 =?utf-8?B?MU1ISGRYcHNQSDJjQWQ3S1pENENjczFxUWUrSW0xdzE0d3JZMkt6Q0NZekI3?=
 =?utf-8?B?TTh0bVBNNzZLOW41K2NTc01RV2dpNVlyZHdsLzlWMkNJOFJ4M05tWU5mRFlL?=
 =?utf-8?B?T2lCTUlHSndXZkMwdGJFc2ZTaHFqWjlsdmtlTDRZY083VlhLWmhweU9QczZ2?=
 =?utf-8?B?S3JGWW13UC9sRmV6RzBLcDFkSE9jWWhlUkJ6em9KVWZVNVp1algrK2ZVN0R2?=
 =?utf-8?B?c1BSeDZ5cU1HVHJ5S0VBVEJnNXc1VTBPK1FyQldzM0xENk4rWkl6WlNlcVlC?=
 =?utf-8?B?cTh4NjcvV080TjlLZ3ppNER1OEljZWFscktUeGlkQk1ZWVdDSHc0cDF0N2Yy?=
 =?utf-8?B?a2R4cGlYNXV2eDZPTEtEYkNBS3duT3VuNVYzT0hVRlFmR2taUWJXME9UeWdj?=
 =?utf-8?B?eUFaVk1NTmoxczFYU0RBUDJhQVQrTkMybHZzSWRvMWE4b1BCTlpDNmhUUzNp?=
 =?utf-8?B?WHR2TWp3RDFiWVNObHpSL3VsRWlMdjdKSXQxbXI1SEMrdFMxTzFUcERkbnRT?=
 =?utf-8?B?TzgzRk9HZXhxWUdWaHBmQmdub1J2VHlEMkJjNFo5RW5GVTBncDVEUGtOZ0Vu?=
 =?utf-8?B?bGNRUzQwSUU5NGVzdUlDZ1lkbXdiNUtpdzNhMmk2MXBIVkpxbW1lUFNjcDE3?=
 =?utf-8?B?UVVFWTl3aFBQNDVJZDNEZ1BOQitLekFYeTRZcUgvZVRjTmtKM1J3VEx3ekJt?=
 =?utf-8?B?c09yRlpQekkvYjhLMXNkMm8rNmpvcnJuS0loS1RsZkxFenloeWtUaU43VHBC?=
 =?utf-8?B?U3BSTmlGYkkxczMyM0VsTW1CdUEwV0ZiNTV2QzhLcmREZHUxNlROMTZTQ1pW?=
 =?utf-8?B?WVFLUktYNVc0ZE5XeVdRbTh6NVc3S2tUNjU3dHBNdVlaUVZUS3lCTmVsTVdu?=
 =?utf-8?B?TmU5Yks5ZXVqYUJVWm1XVXpISm1XQkZlcnh1SDF3a3V1NXJ1T2V4MldkWHNw?=
 =?utf-8?B?cnhLNWsvcXh2VXMwTW5hUU9sVndlOXFsS2l2Wk5oZ2hSTWM4NklmUlFGcksr?=
 =?utf-8?B?N0M0YktXWVdjMHZjZ3kySnlXRml1dm1ISTltamNFd3oyZzNlZEtUWlNxaDZu?=
 =?utf-8?B?ME5QY2U0ZXBSNTQ5djJVZjlYelpPWlluc3IrcENHNW5Yc0FITjhjZEpTVkpB?=
 =?utf-8?B?WUJ2eGFhZHJVaStEOUxVUC9lc20wZVhhTktKNlJ4azFGV2dwS2U5anBqUzlT?=
 =?utf-8?B?Q2d3ODY4bkYyaHR0YzJ1MkpsWTIvNDl6R1hiVmR3R0s5NFJWV2YxYmFSOVp2?=
 =?utf-8?B?YmNvY0loS3BCcW9od3dJYisveDJJbC94WDQzMko0VTlFbVMwTEhRcXFYckd4?=
 =?utf-8?Q?uCAM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHlmTlFEOS9qb1htWWJwYzJiU0V2MWJxOTJ4L1MyOHRlMFpMeUhQV2RRN1Ji?=
 =?utf-8?B?bEs0dEFhUTQvTUJFREF2SVRCRDBnUzdFVHJKT0lKYTkwN3V6SmlGVk0wd0Q0?=
 =?utf-8?B?cFNwbkZvcEdNUS9Pd0RlMGkvaEtKK3pZRHZtSDZPSkRZS2crUktvNVY1bkFm?=
 =?utf-8?B?RDNlODcvOHUwTHc5MWlvcCtFODhhR1p4SHc0UHdnZ3ZYRTRDaXkrc0hpWEFk?=
 =?utf-8?B?T29DSnZpUVNLTlVqRzByd25sdU9pTDA5eVNmcXd6dnlTNVJJclV1SVlFYU5l?=
 =?utf-8?B?UFFWbnZxcTVTejloSUFwbm1vb0czK05YbFN5NWZZZDA5V29nbmlWc3FQVVdX?=
 =?utf-8?B?cDNjN0kyNXRTWWlkOFNMandHNDVhdFk1MGhLUXJBK2NUTkFhTVQ1ODd1Vjdt?=
 =?utf-8?B?NG92aTRMUktxYlAyWHIwTmh1WWJjN3RqcVdheWhqTytzUW95THRPeTdDS0tt?=
 =?utf-8?B?QlZiVmltOExrLzVQSFd0OGRvaVBwQ2R2SWxXclFUSmxXNWFWV05ORmcxUTMz?=
 =?utf-8?B?VUxORWVLZEE5NjMzaU1SWDJ4OFRuY0lsY1BBK3JlTHN0bW5SS2NUVHc3U1p4?=
 =?utf-8?B?anZRUWxDbDhHb20yY2Yxc3JNS2F4bENNVkljVkxNZXZpRWZLTDZEWFBGYkp4?=
 =?utf-8?B?bDJUNU9PaDdpUWpPOUFEaTVxc2JVZXBXK2QwNVZPbUZzOWdlS1QrTVczZWFa?=
 =?utf-8?B?RWhLY2QrYk1qU3Z4UmNPYjQxdGgrVHp6dVNiTEI0TUVVWFFHeWZ6ckhFYVdy?=
 =?utf-8?B?dllzYkZYdWRaYzI0VlZtUU5rT3h6YXVEMGZROHFiM0VnUURubHVHWjZqSnZB?=
 =?utf-8?B?RVVHSHdSZGFxUlRyVHFtWDBnOFRCZm5wODRUTTNYYXNNaVpEdG9oQ0Faa01F?=
 =?utf-8?B?SStVUUxuazlIbU9Id3ovVWpPRjVyWUkvQXVmOTl6dFYvaWhLV3dKSU5QMzhX?=
 =?utf-8?B?cWZpNzJBS0xhT3ZuNlpiUjk2b0pPd2pBNnNPTitZMUF1aEVkV0oybGx2SFVu?=
 =?utf-8?B?YzN2Zy9naXF5MlA3L3psdVI0NEZBdjQ2SmZsdjNTVUZPbHMvRnRaZE85a1Ez?=
 =?utf-8?B?Z2wzZktCZ1ZrRE8yenpyWXZmVW1SMVNoc0xxVnJiNVg4aktLYnFlK3RBaDV6?=
 =?utf-8?B?cHlTRXo1STZSbUpIM25oSm5yN25GVWo4Q0ZRK2loYTlaeldyWWpHRHNHSTFq?=
 =?utf-8?B?UXlqL0JFK2tsVEsxQWw2eVdzTzZzaWRBL3FLLzZtb3NNc0pOUVM4UHdtNFJj?=
 =?utf-8?B?QXU1REIrbUZOSE9Sdi92N1QwcnVRZ2FBcjFxUTF5dHBBd0tldXFNU3liTVN2?=
 =?utf-8?B?UW04eHVsaGJFakxrWW1Xa0hGZlI4RlpvcncvankveG5PRXlaNFg4U01LUFFS?=
 =?utf-8?B?eUg4RkRWRy9KL2N0b3VOR0hmSVFwak0rUkc0STV6MU91bTVYUCtOLzBDamhW?=
 =?utf-8?B?NktDMG9POXo5RU80TGlsMEFxRXRyY0NXTm5LS1Nla3FjVDZwK3JEcTlraEpE?=
 =?utf-8?B?MmlNVnhob3FYUUtOb0tPYm01L0J2OWM2MnlLSUtRdmdpMjAyeXQvTm5vd09T?=
 =?utf-8?B?b1loKzJJRXpjZ1l2RWUzTDhHNGZ1ajdveDYyRUNpeGZiRFJvVG5tUXdVSU9C?=
 =?utf-8?B?Wnl6amxtVDNJeE9ZWG9zVUcvbHROaXdTamdQcE90bFdNb04wYmpRTXl5YktU?=
 =?utf-8?B?OWVnUDI2a0NrMkM3bldobVRFVGpqeWVWUUkwQWwvdVQ1UStPSFh3emd4dkpr?=
 =?utf-8?B?dExkM3BpNVBqSjFzd0ZSdmJ1QTdZTlNjZXR2Qy9vbmZheGxLREJ2czd2ZHo3?=
 =?utf-8?B?dVl0WUZqanpoTzZ5czJML0hEd1JDdnVmckJkaVBEQ2FoNm5aazZJbC9sZDcw?=
 =?utf-8?B?MGI3L3p6MjRKN0RKUVpWOWFWa0FBWkdHdEVXaHlPWk1FemZwR29tRFlKT3pM?=
 =?utf-8?B?a0F1SEJ0QVpCOTZNVW4vSFpwZ1pna2E2L2twQlZSMmxHamtrR2w2b3pyK3l0?=
 =?utf-8?B?dk1MS3FwQ0xtU1ZvTHBLRHpPa3lONWdqTkE4SkFyM2I3bThRdEtLRVFYcjR5?=
 =?utf-8?B?UnAveTFaaTZlVUx6RmEzL3o1R2swd3paTW1SWFRuVGcvaTlmbUJ5WGtxcVl4?=
 =?utf-8?B?VUtObmtCTGpCSmVRaHlWcnE0YUxIQzJsRWE2UHl3dzFQWXBURE41U3BXeDV2?=
 =?utf-8?B?NjZRNWpJL29wM2VqQjZDRVI5d0tQdlNXV3pVRlBGNTRuREJ3QlQ0d2tVQ1A1?=
 =?utf-8?B?MS8wbm9mQnRJSS9WTTdtVGd2WUk0aXJkU2R1U1o0d2pNUXg2cSt0OGJlY3F3?=
 =?utf-8?B?TGkwVGxsQjFjUzdhM3hlbGYzTnA0SFp2NVl4eHI3aitmR0tuazdyZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3635396c-dee6-4a51-3e4c-08de73d84c5c
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 19:09:56.8240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBDs7clMtijjOFsJIPZZNPXbyjgRtrRTH1r7IKSHJPzwZ//0lPNabWCz0bFnsXnfpjQ68DDkJs3pSdhfiSEzyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB3811
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260636-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,ashe.io];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email]
X-Rspamd-Queue-Id: 9EB9B18BB27
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 05:02:55PM +0800, Jijie Shao wrote:
> 
> on 2026/2/23 22:56, Aaron Tomlin wrote:
> > The vmxnet3 driver supports an Rx Data ring (rx-mini) to optimise the
> > processing of small packets. The size of this ring's DMA-coherent memory
> > allocation is determined by the product of the primary Rx ring size and
> > the data ring descriptor size:
> > 
> >      sz = rq->rx_ring[0].size * rq->data_ring.desc_size;
> > 
> > When a user configures the maximum supported parameters via ethtool
> > (rx_ring[0].size = 4096, data_ring.desc_size = 2048), the required
> > contiguous memory allocation reaches 8 MB (8,388,608 bytes).
> > 
> > In environments lacking Contiguous Memory Allocator (CMA),
> > dma_alloc_coherent() falls back to the standard zone buddy allocator. An
> > 8 MB allocation translates to a page order of 11, which strictly exceeds
> > the default MAX_PAGE_ORDER (10) on most architectures.
> > 
> > Consequently, __alloc_pages_noprof() catches the oversize request and
> > triggers a loud kernel warning stack trace:
> > 
> >      WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp)
> > 
> > This warning is unnecessary and alarming to system administrators because
> > the vmxnet3 driver already handles this allocation failure gracefully.
> > If dma_alloc_coherent() returns NULL, the driver safely disables the
> > Rx Data ring (adapter->rxdataring_enabled = false) and falls back to
> > standard, streaming DMA packet processing.
> > 
> > To resolve this, append the __GFP_NOWARN flag to the dma_alloc_coherent()
> > gfp_mask. This instructs the page allocator to silently fail the
> > allocation if it exceeds order limits or memory is too fragmented,
> > preventing the spurious warning stack trace.
> 
> This seems to be a suitable solution.
> I see many drivers appending the __GFP_NOWARN flag to the dma_alloc_coherent() gfp_mask.
> 
> Reviewed-by: Jijie Shao <shaojijie@huawei.com>

Hi Jijie,

Thank you for your feedback.

> > -					   GFP_KERNEL);
> > +					   GFP_KERNEL | __GFP_NOWARN);
> >   		if (!rq->data_ring.base) {
> >   			netdev_err(adapter->netdev,
> > -				   "rx data ring will be disabled\n");
> > +				   "Failed to allocate %zu bytes, rx data ring will be disabled\n", sz);
> 
> Here, it seems more appropriate to use "failed to".
> 
> >   			adapter->rxdataring_enabled = false;
> >   		}
> >   	} else {

Agreed.


Kind regards,
-- 
Aaron Tomlin

