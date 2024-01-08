Return-Path: <netdev+bounces-62385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEDC826E37
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 13:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C5C1C223A2
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 12:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650F84A99A;
	Mon,  8 Jan 2024 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M4OMuvsk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C11495ED
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6NSFUYA4WwYY6uC4ZpaxP2xgieZCBR/yPlxD78pwSkSHdVgiB3GsZsqURU8ayndnTZ6SvsQd0nDWPbdf9vvY3kfQZ16S94/VnkBt/c6lMZkxdRvHWbUDaITSrMi8E/CZ1uv5U9wEuCl37qB61uSmYUrMAwOaZZ5yOqU/QW/mm3X0fnAp8Thw70b+nid7wQ8JGTWgbPQBf/karQ10B5giIS6/7IkwI0jX2pdxmXjvKaG+O8i+i/UuvlDtllKDt0CIbghaif5XHpdlhFvpoRhjO14HYn6N0aN/Jf8tPKo6wKmGYiJ4s6NoiUgjfHq0YrvKaYelyDxj014y7q6BXn86w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSKF8xfUQ5QFOZqtO5SwbY3CJ+WV8sAjrSwqsjDq5wg=;
 b=AGQK/8+0sEgzGsk36kY3qs1OX/YTUPL4YU+7UzAlO8OGAPNPrdhnMJvFKDMYB24TOkl5Z4gNgEvYrYqfsEGIb7b0gypzWR/lTowMCmQeRsfPhQ4aiskaY9tn6IeIxcocCezyFR8L7vOOxjc+Y3MKj10aeD3fPbzhPKVF1DJ1k+A9DdsMbzd1ZV2tAt/BXIljCqdUH5SRGMiP43Ne+Y6Y7QaQpw3LmAEzX7IFkse6Wy1K3Pshrrk+GGD5OtIgjm53AMF++tdrmxQ6LzBHpgidPF547UFDC3GzPm+jlb3elulDXwXQJ2l4sPvxTa8l9RDrvt3nsG//ntQEt5ITU9y+qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSKF8xfUQ5QFOZqtO5SwbY3CJ+WV8sAjrSwqsjDq5wg=;
 b=M4OMuvskWZ2Hh9M8dAG2uJq3jCsIzFXVcDZepgQo7cd8XtY8BoGm3uKzw4mVys55XSL2+Cu5EZ1c5t/js57B6pDGRCPZySPqoe+jeIOEPOEkBdlm8bpVdWKWl1tK7858GCBfizOnVP5Qe3cP3IVQxNUd9VTYbniLR6M5SKykflX4NgEtQF1VUUXqJOqw5NKN10j8lnJku1zkryCTWTooDIcekVMp8dE/5DL7/+Pd2yaalvAeJghMCM5zbso7yC6g+CicNSY7a+WosOZcDPk+OsfPbswwUvkyt1JhvDH81pc7qpQrrEnvH62zz0ZQaqEhCqSFxfMwISES/WESL2n42A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 CH2PR12MB4954.namprd12.prod.outlook.com (2603:10b6:610:63::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.23; Mon, 8 Jan 2024 12:31:00 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::1442:8457:183b:d231]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::1442:8457:183b:d231%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 12:31:00 +0000
Message-ID: <effce034-6bc5-4e98-9b21-c80e8d56f705@nvidia.com>
Date: Mon, 8 Jan 2024 14:30:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 10/15] net/mlx5e: Let channels be SD-aware
To: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>
References: <20231221005721.186607-1-saeed@kernel.org>
 <20231221005721.186607-11-saeed@kernel.org>
 <20240104145041.67475695@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20240104145041.67475695@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0338.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::14) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|CH2PR12MB4954:EE_
X-MS-Office365-Filtering-Correlation-Id: 34fc64fa-bf3a-4f95-7300-08dc1045ab9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qPk3iezY5qspp/RemaOHael0+nuAAbJhk7+rYcN/HQRLEx9opi/DuvGjJmh55Fhs+xFr6AixVoGQy6uNTyv7mM0e4NHFPVG9CbBEpEKcHPySGhi8DrA86vM98KXUT0pRJ+fjLZL5inBrTQm/2I6TBN22kKBMFbC3II88kog1FvLalL3Vc2s1yWFXWf8KqA8+2f5RMotuL65iDdJc2S5ZHp9F6gtK46i2TSSerqT/BEpaoHukdhQxm86DiHlnLk9FnEBNJ6ae8v4n3tHdbhyOdZSoePPZurP2KFrovbYePKhIvyMVytTIYI2oIftqDnWRX/Vw9R4aUZH2dIyIo+zvFLIeu/HvhH9fw6yMKPk3exgsA9mqTnacAyJd6cUfRCFEPDdReOH8DtCq3+fJyxMrYWwqElAhrrjWcODqlAUngQqlUgvEUt2kY7Vly/uvH4R6wNq4usIxtHUdRVRHf/xqv3gTySRTAQo+JHemyArxebN6IbUV7D37SLGoTPipfZqsOJJs6LiActElW8IRGOb82pmskVl2hZhsu5rO4PMCFqxhRutv5YSrOEFAkIJF9F8B42jNZ2UgAbXP7QFl+U32xMXSE+auNMAvUUWVd/dSE/YnYLfmUcJ4CPPwdAkN695TQ5kH2tunVdA2yoG7f8LonA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(376002)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(86362001)(31696002)(36756003)(31686004)(38100700002)(83380400001)(6486002)(26005)(478600001)(53546011)(6666004)(6512007)(6506007)(66556008)(66476007)(66946007)(110136005)(54906003)(316002)(8676002)(8936002)(4326008)(5660300002)(2906002)(41300700001)(2616005)(107886003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEVReEJRSXhsRWpwZHpUbFkxUEk5UER2MVd5NE1LUlo5K3FJVUo1V3RwaitM?=
 =?utf-8?B?amk2ajdUV1NSY3pST1l1THN0aWxkemFhUUsxbjFBcTU4S0RPMm5OZEZDeU1O?=
 =?utf-8?B?LytBbk5OdlFxSUNTbmRCWVNGZlRHMC9wMHd2MGNyamRkNmxHUmQ0VDh2Y1Rl?=
 =?utf-8?B?cW1iYk44Rm5CQjhYRkxwUDYyQmM3U1pWUHc5cWxVK1hsMXIyTUJiWkQxWDJR?=
 =?utf-8?B?SWRmcjh3V1Y2Q2dtNlpwMVNhT3NNcmdSUXlXc1UzUXUxUGlnMmVyM2FsQTAz?=
 =?utf-8?B?cGdVMGkvd3FYSGN5T0RDWTgxWFJJTGtNZFpuSEY1RjJQblZSTjhFR2hocFZj?=
 =?utf-8?B?UXRaTzEzY2tXSFhFT21EZ1R2VWJJSFdJK2JXaEQyaEhjQjdBemZlbjdLb1ND?=
 =?utf-8?B?d1RUMGRHWnRMcXlZYXBBSXNWM3gvMXh0c3B6c3lkMVg4Mjg0T1RsT3BvR3Z6?=
 =?utf-8?B?blZPeWYyd3Q4OVVGOFkrUVptYUZHZHVKcDFQY1dKT2RBOXVJTExOWXN0eE9q?=
 =?utf-8?B?N1Rua3JrL1pRNmJhR29mMWJ4SW1wZmRYaHBNa3RVL3VrUC9CdUNkVG03akdR?=
 =?utf-8?B?TUZWUXc0SHIvRk44aTd4TTFRNXdYMmdFK2FHbm52MTJtTk9QYXpUNmlEZWdM?=
 =?utf-8?B?SGdnY1RaS2xCODFrRkRQWjhLVmd4Z1M0c1BLUUpaZ3hZdW9oY1hpS2UwWEJF?=
 =?utf-8?B?cFFKY3piN1FBM0Q5dVBTRGRuZnltYWxWRTRoVTJGTnR3U2NCc29SYTZyQzZM?=
 =?utf-8?B?b3dWd054dy9odmtIMUlUbnVGdm0zdWp6WVExVk5WTmhqZWdCNmVGTHZzWHRi?=
 =?utf-8?B?OHRoTHVHQTN5aUNZR2EwV0pKenN1WW1tUDdDdFJwT1FabUNjeC85T2wvTmRP?=
 =?utf-8?B?TkNaNGo4ZGJqMExQdFNaSTlJUkhmb3kvN0VDL1BKdmJSVm80S1J6V1ZpcUtB?=
 =?utf-8?B?RlFoOUttdForaDJUM0gzS0FjYktBY05zNWtpZEQ3RTVvcUNndFBDSXVEQWNl?=
 =?utf-8?B?MW8rdFcwTklyOG9vTGZVcEtRZThBTndoZUszbDJsYjNmTmhPM094MldPaW5n?=
 =?utf-8?B?TW5mdEhvS3l2ajVFb3Vxb0lwdmp2eEZDVHlnYmtHT0UzdDkrb0tlVnpncW45?=
 =?utf-8?B?M1BJRTZCdnNzQ1VPbEgvZGw3RHMzblduQW11eXVORGRVOWo2V2VmUVJrbkN6?=
 =?utf-8?B?ajdhY25PWUNOWFZYUzBkZnV4T3libjdKVmxWZmV5WWlURHJkMkFDdUQ0RmNP?=
 =?utf-8?B?YWNEaFFKMHdaVmlzKzNQd1dwZHVhZkJoN3A2S0U3REd3anplYnVyR2FtaWtS?=
 =?utf-8?B?N29QMXZDR3VNSElNbVFGSWt3c3NsdDl3NytZVGh6dXVVNzhIMGtZZTExakpu?=
 =?utf-8?B?Y2RaWEwweGw1cncxalRCdjJuSHpQQ0FFb2xGNVBkeXNJa2FGemRDL3lIeGJh?=
 =?utf-8?B?UHJJMDFEVWpNckRMS2dMUzdyc1hZRlI5RGlCNTNxOWRVdXVtNjZqMGc3Unli?=
 =?utf-8?B?aFR0UjdEUm9pbTNEZldMWDJsTXZIOHJpeHBnSFBTUTFkaTYvVjFvdElLRTY5?=
 =?utf-8?B?YjEvNzJOYTBCeXh4UXZOT052Mk9hWEVwVnc0eVVtQlpnVDBoQ0wwRzNla3Za?=
 =?utf-8?B?aG55ZE9CUjFHWjZheEx1TGY3dkxSMXF6TGsxZndJYWNBK3dZQlNlS3UyV1B2?=
 =?utf-8?B?UXFEZnErcGV3MURKWTBUazFDR1Jnam1kbjlsSjhPUVFHbEFmOHk3bjhra2Q0?=
 =?utf-8?B?alkwRm5EL2lDTlptVWFPRXdLUlViWndRRy9uOWpYV3JNZ2RjanFobzdyV1M5?=
 =?utf-8?B?bEdmenRsaWFCQTlvanFCNDIxTXpTSHord2VHNTYyc2hMY043S3lwNzA2eHJ5?=
 =?utf-8?B?YVRvckY3azJpWnpNVXBoWjFmT1M2YXhFdTZuRHhOeW1WYzR5dUo1MEpmL1Vw?=
 =?utf-8?B?RGNIWkw1U09nNmhoOW5zYjU4VmxoQmhvTUdMNlJldk5KUUdQK0hUcDE4WXQ4?=
 =?utf-8?B?QzBoVXBzaS9mZHlCRklGbzl2ajhIVUNsR1RpaFZzclJhWEJ3VEEyYW5FQjBu?=
 =?utf-8?B?d01aYzk3UUxiM0xKU1pIUksrV0VSUVhVZWFwSFVGVXhJWm12SnBsTGVURVQx?=
 =?utf-8?Q?zUrnF72U59JU/PM4jybVNl+lu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34fc64fa-bf3a-4f95-7300-08dc1045ab9e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 12:31:00.0237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpjDF8QkHV2vKkfSX5LP3ld9G0Hn54rlSR5Jy4NP+Lgxqq+MIIT6k81zOp8asEMB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4954

On 05/01/2024 0:50, Jakub Kicinski wrote:
> On Wed, 20 Dec 2023 16:57:16 -0800 Saeed Mahameed wrote:
>> Example for 2 mdevs and 6 channels:
>> +-------+---------+
>> | ch ix | mdev ix |
>> +-------+---------+
>> |   0   |    0    |
>> |   1   |    1    |
>> |   2   |    0    |
>> |   3   |    1    |
>> |   4   |    0    |
>> |   5   |    1    |
>> +-------+---------+
> 
> Meaning Rx queue 0 goes to PF 0, Rx queue 1 goes to PF 1, etc.?

Correct.

> Is the user then expected to magic pixie dust the XPS or some such
> to get to the right queue?

I'm confused, how are RX queues related to XPS?
XPS shouldn't be affected, we just make sure that whatever queue XPS
chose will go out through the "right" PF.

So for example, XPS will choose a queue according to the CPU, and the
driver will make sure that packets transmitted from this SQ are going
out through the PF closer to that NUMA.

> 
> How is this going to get represented in the recently merged Netlink
> queue API?

Can you share a link please?

All the logic is internal to the driver, so I expect it to be fine, but
I'd like to double check.

