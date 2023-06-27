Return-Path: <netdev+bounces-14321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 707FF7401E3
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 19:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F77281048
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 17:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775E113086;
	Tue, 27 Jun 2023 17:08:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F0313064
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 17:08:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2859D1708
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 10:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhKzYn39jv/R3rpsf7woKeo/tyBzv8am7E01A1aIhUHeiNGpdwuiOtHjjknnXhlVLHXAL8uy+Y83eep1y2L+Nr202hle/S5iyhp4Q2ntcaIm5cYeFg8UAmBCR1BvfVwxDtxV2EBJrVmtB1ni3m0HzDVFdeh6tUtQXLJfvWbf+COQ7CB8fAXsEG9qE9bbm6+lmnDxbKdl4a7RoHFdIJJMcR6GO9474UqMTui7006KAZmpVG42yDsRac+a2R28wbgxEx3Uz+YongEwoqt7aa6iTtmRBQ/xPFhgVfGxH2yIv2+Lt5mf3iLdonnLqMPvS98+Ot0UAsDUSjw1IfqSIpTLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sR0W8Zp7pVeQeMA+2PL+wEpk/yhUwK7BzOYy4yFCy8c=;
 b=cKDatxLZeTJVa6wHT0RtZf72Ff1Niy1rt6BswCT1VYqLiMALLl090DMH1knqpTjWb/VmrgzjJwOjaHLVjfr1ik0+uHCJAlcPfLnohQJlrwQug6IRJPgkMdfIX14MmmEW0YAk0BTKNMuowueB00jcy6ZxHAVKKHN/XDFUBw40TblG2BpcpMwIKkDl8gIAZVVAZwQorFQU9IwVP+HRz+BRjhaF02Z7hCKVwUMzeDhkpaAPqKji8f+nmDHpRrDyTb30Ra21Eh1qfA2OfuNzLn3sL7+e9BEoYSqkeXabUrOnrX41gf5qlVieTIir3WqVo8cg2ebBzI0Xi1/qpCU5+AMhgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sR0W8Zp7pVeQeMA+2PL+wEpk/yhUwK7BzOYy4yFCy8c=;
 b=DU+l5eK+nWDZP/+qXsNRyR0inoCUIj1kXF/wqIwJx5H9DBFLM/A8mPahJvWiTAAf3TKog3i4M8hRNzGZMKKtHKgb166i1NFvNaBIKAoirWB2lZAgjndWI7GhwHA0X89h48U3rWr+xK9fR5Eh8ZxgpR32OTAJVlEj/BjJWHtC2hvpzRxdBorC0xNQDGyIZLmM5S2YYzw2dlQ7SCmz4dNKesqpgUNx7Yfth+WnQMfoBklnQpBnT+7fAdq/RSn8WkOV0SxkDaLV1yTfR9kVpF8MBPazxQmWE4al62tmbt/UoUF1MO1zgy1CkSMEWmQX5hs9p+u0iV/s3xfCvoHUbnvncg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SJ0PR12MB5438.namprd12.prod.outlook.com (2603:10b6:a03:3ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 17:08:21 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ecb0:2f8e:c4bf:b471%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 17:08:21 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: netdev@vger.kernel.org,  Gal Pressman <gal@nvidia.com>,  Saeed Mahameed
 <saeed@kernel.org>,  Tariq Toukan <tariqt@nvidia.com>,  Jakub Kicinski
 <kuba@kernel.org>,  Richard Cochran <richardcochran@gmail.com>,  Jacob
 Keller <jacob.e.keller@intel.com>,  Paolo Abeni <pabeni@redhat.com>,
  "David S. Miller" <davem@davemloft.net>,  Shuah Khan <shuah@kernel.org>,
  Maciek Machnikowski <maciek@machnikowski.net>
Subject: Re: [PATCH v3 5/9] ptp: Add .getmaxphase callback to ptp_clock_info
References: <20230612211500.309075-1-rrameshbabu@nvidia.com>
	<20230612211500.309075-6-rrameshbabu@nvidia.com>
	<20230627162146.GA114473@dev-arch.thelio-3990X>
Date: Tue, 27 Jun 2023 10:08:14 -0700
In-Reply-To: <20230627162146.GA114473@dev-arch.thelio-3990X> (Nathan
	Chancellor's message of "Tue, 27 Jun 2023 09:21:46 -0700")
Message-ID: <87ttussuip.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR01CA0022.prod.exchangelabs.com (2603:10b6:a02:80::35)
 To BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SJ0PR12MB5438:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ea9fcb-4bf3-4b89-218e-08db77311c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+UD26NeF2dg3tuHc9UaA/xwgL2KeZ02pI7CjtK9b1hNNNJncLOsSi9AJ73E43A9Tf04ywnqlkTKQeoL8a60hI6nZys1aK2nOc8/dGaXS/3XRRInuY+lsP9/T3nIOxfQdvn/oQgtdtt5otB2haRcuY7hrf7zZ33AvqtW4Xw7zjLRxWE1x0PREOSPFExK2/GW+DfeZa9jvG0cn11gvhiTZws6jpOqVtNNXu72GTnddyBm7jNkA8dpgQ7hlwxG9YMlldH72uCW8GfMjrHpkVz0qvHR4CBIDLLnwfQGpPCQblZGJ3znz5A31+3emgfZmah1ELNnmEnpAc5phizxpPBxJeSIkuI7lIFBn48mkWp6wLrxHpnIFZLudsvVpE2yzXOnHJJiGxV9Gas2d43sTJpTX5LxwdESq2vFwZ5q7/bIUQ6/50HbwdeDEiQZgHbcPiyg3o+OpOWDtSpD7zR2wSRiyNhp0MAJP/IO5w/DV4RZ5zBsElo82f6UJ8b49h7S6C5KR3XMH6GugnloGy5Myi+Z8RsyJ+S/RbFZe8/uBYAlDaN5jDeB+ZNQgXssMBt6MAjMTYuy2Ga7Rslc6c4wYP6s9w87Ds83tPkcXkHNt/hgJxQZvg7MtLNkPDVdORXGBtcwkY0gfzVQ6XctCFZmeA6OcfA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199021)(45080400002)(966005)(54906003)(6666004)(478600001)(6486002)(83380400001)(2616005)(86362001)(66476007)(6506007)(26005)(186003)(6512007)(66556008)(2906002)(66946007)(4326008)(36756003)(6916009)(8936002)(41300700001)(38100700002)(316002)(7416002)(8676002)(5660300002)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rmp2VnR4VjVmNklTalQ5MXBNM1UrMGUzNzYyU1pmZTJVdUlyK0VEYkEzcGRB?=
 =?utf-8?B?aWdhOCtya3NmMHppM0pnSUlTTnhrb1RtNmJOQWJtV3Rpd0RWK1BlcHhmY3dT?=
 =?utf-8?B?VDVUVTk1TkFmZE1NNE1wY1NtT0RVakF5eVRidGhsdElLK3ZLSXppUXZhSnp3?=
 =?utf-8?B?dmw2ckJ4dkhaMWxIcGE1cEVSQTF1NE9iZ0tqWEV2RmpINEpHYkRXK0dnOEEz?=
 =?utf-8?B?eTc4RTZkQ3U1NDdjWHExc3NLaTNBa2d5QTRPLzhPd3ptWkpFdnlWUVlpU0N6?=
 =?utf-8?B?TXRXLzA1ZW1IM3lzdy84aXpEZDVqNy9PenY5YmlUOVRaVGZqVmlaRGU0WnJy?=
 =?utf-8?B?MjJOczFlMzVFTm0veWdBeFpvOEU0V0ZZL3ZjVSsrenArczZnQ1p2YVZHVmhP?=
 =?utf-8?B?Q1EraVRIVDVsa0J1bTlHQStMRHlFYjFjaUVhUjgzMExiSDloRFhGcnhYRU1a?=
 =?utf-8?B?SUc4MWw5Nk5JSXdVM0JjQ0tidFVEb1lZYXo4MzlyQURMT2p0ZW9CQTYxQnVs?=
 =?utf-8?B?aTJRbVpXYWtrRTc5Q0tncmlmS2ZwU04yc090dWRmd1FKVHFldW8yRi9ERDM3?=
 =?utf-8?B?ejFmSzZKQU9zMzNiM0d2NzFGQkxDNWRoVE4yNk9qQThxNEoyRStZb0JQWFhO?=
 =?utf-8?B?Zy9YQXg0VzFpVkVWdWIzcEkzZnM0dWNRZlN1amdDRmdBMWt3WFg0cVhZTVgv?=
 =?utf-8?B?ZzNQTmxwR0JqZ0tzM2hwb3RiTkd3MUE0MWVzYmd2dlk2anFtSGdjR0xCNzRM?=
 =?utf-8?B?bXJuNUx4c1FaMDhzeUZkRjRMU1JhMmpHVTh5bmI1ck9LWjBmRUZPMHAzaFh4?=
 =?utf-8?B?NWRxMDhrNllMWFhhT21OM0R0azg5aHFQbXA5UGhUZGFMZm1QNmRGWFlFWUsx?=
 =?utf-8?B?QWU0TXN4Y0RlWjkzN3BMUHhmWjQrS0tyd0dOaXZaTzdqZWFUQ09HTkZ2K0cz?=
 =?utf-8?B?UndxM2p3S0Z0WnpvMjJkM3VKMVJMdFE4RUMrdmoyWjZRR0F2TVU5eHVkVUlX?=
 =?utf-8?B?emdYZE5kMXhrRGNhSUVJSjZaZ1NPcVh3Z0VaN0NXQmVHNWwydzNqdjE5YkVP?=
 =?utf-8?B?eWlydjladHhHTVdaYVdOTDBrcGQvZ2s2cU1UMGxBWlpKNnZDQU1FdHAxS0Ji?=
 =?utf-8?B?MktyQlJpRkl5NFNadTg1MGxPeHZLRDZNWDVjcEd1d1pUdU96aFFlQXpMSUdW?=
 =?utf-8?B?TnNpUmh2K2srUkx1My9NWUpoQkwxemZGK3JlU3FLb2p1ZTFCQTZmcy9MaEk5?=
 =?utf-8?B?WHlNQzc0RUJJcW5UMlF0akl1MEtWV0s3U3RTcGZrT1F5K1JsbnpXdHkzWFh1?=
 =?utf-8?B?T2JoaGJVbjNFSWxwUGxrSjZoVG9WVFZRckpDY0pzaTZmOC9iUzNIVCtOVVBy?=
 =?utf-8?B?Vkh6dzZIRUF5b3g4aFIybnZvb1hPendHaEQ0LzYwazFWd2VMZ0ZuVDdsbzFJ?=
 =?utf-8?B?OWVUMGM4MUpSNzJLOGRIMkRteERZL0hvcDRUNUpKaGdRYVhwUDdkWmdMSVAx?=
 =?utf-8?B?T3NRcjVISDc4blFRaDRkemphbmY5U2ZuZjY4elRiNFRzSjlIZmhPM1FyNzFh?=
 =?utf-8?B?SHVKTHRFYUZqZVFKdER2YWNnODdUbVNZYUV5eS9hcy9YeDNNb2c1RDZyRlgv?=
 =?utf-8?B?WDBGb1BqTVVkZGxGUUtzc1Z3NDlxSjlLVlg0NlhiOENhM1dnWlB3WlRxMFdJ?=
 =?utf-8?B?TDlQdEZubmh2WDV5RkJldGN6eU1IUzBubHpUbE4zSlQxbW9ndThnaEwvbjh0?=
 =?utf-8?B?ZlBPb0dzSGphY2Rsbi9YZWJ6aFFvOXBXVzc5cUs3bXVJS2JxSlpiVzF4RGVk?=
 =?utf-8?B?NWhOMm9VL1RmLzhTbmY2RG12dkpKQVJMU25vSHFmU1Rwc2ZEVE9QU0ZjQ3o1?=
 =?utf-8?B?UjJHN3JIWHhjWE9IaEVyWk1tM3JsVmJxTlhUWTQzL2lpQ21Yc2hYRDc3Uktm?=
 =?utf-8?B?bEhRcDhGT1MzdkpQOGZKeHF1cE1ISlIrS1I4ZHRPajJxSlVIaHRPWmxvWnV4?=
 =?utf-8?B?eVIvR1RRbW8yd3ozMmlCWEt2bFpnNGJDQk9XR25BZEdaY2lJQ2JvTkNJbkFP?=
 =?utf-8?B?a3N5ZjBKSGpLWnkwNXk0dm9YV2tSVDNWcVFoenVISm9QaGp3NVdKa29HcGRJ?=
 =?utf-8?B?dnpGS2RwTFh1OVdxcU1vblFRRXhjdi9QWFFoZzhERStIYVl1MGpXcWtkYUpn?=
 =?utf-8?B?SlE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ea9fcb-4bf3-4b89-218e-08db77311c3f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 17:08:21.5818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXnc5VzNmuYbZjZ1N+qw/lSpgbi1BUlyJXvvGxzxZFjsPEJfoo3KK5ZZxMB+VMwUX2caLEt4NaCrOW/BiNPDpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5438
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 27 Jun, 2023 09:21:46 -0700 Nathan Chancellor <nathan@kernel.org> w=
rote:
> Hi Rahul,
>
> On Mon, Jun 12, 2023 at 02:14:56PM -0700, Rahul Rameshbabu wrote:
>> Enables advertisement of the maximum offset supported by the phase contr=
ol
>> functionality of PHCs. The callback is used to return an error if an off=
set
>> not supported by the PHC is used in ADJ_OFFSET. The ioctls
>> PTP_CLOCK_GETCAPS and PTP_CLOCK_GETCAPS2 now advertise the maximum offse=
t a
>> PHC's phase control functionality is capable of supporting. Introduce ne=
w
>> sysfs node, max_phase_adjustment.
>>=20
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: Richard Cochran <richardcochran@gmail.com>
>> Cc: Maciek Machnikowski <maciek@machnikowski.net>
>> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
>> Acked-by: Richard Cochran <richardcochran@gmail.com>
>
> <snip>
>
>> diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
>> index f30b0a439470..77219cdcd683 100644
>> --- a/drivers/ptp/ptp_sysfs.c
>> +++ b/drivers/ptp/ptp_sysfs.c
>> @@ -18,6 +18,17 @@ static ssize_t clock_name_show(struct device *dev,
>>  }
>>  static DEVICE_ATTR_RO(clock_name);
>> =20
>> +static ssize_t max_phase_adjustment_show(struct device *dev,
>> +					 struct device_attribute *attr,
>> +					 char *page)
>> +{
>> +	struct ptp_clock *ptp =3D dev_get_drvdata(dev);
>> +
>> +	return snprintf(page, PAGE_SIZE - 1, "%d\n",
>> +			ptp->info->getmaxphase(ptp->info));
>
> I am seeing a crash when accessing this sysfs node, which I initially
> found by running LTP's read_all test case.
>
> # cat /sys/class/ptp/ptp0/max_phase_adjustment
> fish: Job 1, 'cat /sys/class/ptp/ptp0/max_pha=E2=80=A6' terminated by sig=
nal SIGKILL (Forced quit)
>
> # dmesg
> [  133.104459] BUG: kernel NULL pointer dereference, address: 00000000000=
00000
> [  133.104472] #PF: supervisor instruction fetch in kernel mode
> [  133.104478] #PF: error_code(0x0010) - not-present page
> [  133.104483] PGD 0 P4D 0=20
> [  133.104490] Oops: 0010 [#2] PREEMPT SMP NOPTI
> [  133.104498] CPU: 13 PID: 2705 Comm: cat Tainted: G      D            6=
.4.0-rc6-debug-01344-gc3b60ab7a4df #1 d68962f26eeefb0e64d3dd104c3eef4a1ac5b=
0d5
> [  133.104508] Hardware name: ASUS System Product Name/PRIME Z590M-PLUS, =
BIOS 1203 10/27/2021
> [  133.104512] RIP: 0010:0x0
> [  133.104563] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> [  133.104567] RSP: 0018:ffffbc38c5e2fdb8 EFLAGS: 00010286
> [  133.104574] RAX: 0000000000000000 RBX: ffff9e3fc8e62000 RCX: ffffffffb=
b386100
> [  133.104579] RDX: ffff9e3fc8e62000 RSI: ffffffffbb386100 RDI: ffff9e3fc=
43ef968
> [  133.104583] RBP: ffffffffba7795b0 R08: ffff9e3fd106c0f0 R09: ffff9e3fd=
10418c0
> [  133.104587] R10: ffff9e3fc8e62000 R11: 0000000000000000 R12: ffffbc38c=
5e2fe88
> [  133.104590] R13: ffffbc38c5e2fe60 R14: 0000000000000001 R15: ffffbc38c=
5e2fef8
> [  133.104594] FS:  00007f24dc5e5740(0000) GS:ffff9e46ff740000(0000) knlG=
S:0000000000000000
> [  133.104600] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  133.104605] CR2: ffffffffffffffd6 CR3: 0000000104352001 CR4: 000000000=
0770ee0
> [  133.104610] PKRU: 55555554
> [  133.104613] Call Trace:
> [  133.104617]  <TASK>
> [  133.104622]  ? __die+0x23/0x70
> [  133.104632]  ? page_fault_oops+0x171/0x4e0
> [  133.104641]  ? exc_page_fault+0x7f/0x180
> [  133.104649]  ? asm_exc_page_fault+0x26/0x30
> [  133.104662]  ? seq_read_iter+0x375/0x480
> [  133.104670]  max_phase_adjustment_show+0x1e/0x40
> [  133.104680]  dev_attr_show+0x19/0x60
> [  133.104692]  sysfs_kf_seq_show+0xa8/0x100
> [  133.104703]  seq_read_iter+0x120/0x480
> [  133.104711]  vfs_read+0x1f3/0x320
> [  133.104721]  ksys_read+0x6f/0xf0
> [  133.104730]  do_syscall_64+0x5d/0x90
> [  133.104741]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [  133.104750] RIP: 0033:0x7f24dc6e1b21
> [  133.104763] Code: c5 fe ff ff 50 48 8d 3d 25 7d 0a 00 e8 e8 11 02 00 0=
f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d dd 99 0e 00 00 74 13 31 c0 0f 05 <=
48> 3d 00 f0 ff ff 77 57 c3 66 0f 1f 44 00 00 48 83 ec 28 48 89 54
> [  133.104769] RSP: 002b:00007ffea4af1b88 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000000
> [  133.104776] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f24d=
c6e1b21
> [  133.104780] RDX: 0000000000020000 RSI: 00007f24dc5c4000 RDI: 000000000=
0000003
> [  133.104784] RBP: 0000000000020000 R08: 00000000ffffffff R09: 000000000=
0000000
> [  133.104788] R10: 0000000000000022 R11: 0000000000000246 R12: 00007f24d=
c5c4000
> [  133.104792] R13: 0000000000000003 R14: 0000000000020000 R15: 000000000=
0000000
> [  133.104799]  </TASK>
> [ 133.104801] Modules linked in: overlay xt_mark snd_seq_dummy snd_hrtime=
r
> snd_seq snd_seq_device tun hid_logitech_hidpp mousedev joydev xt_CHECKSUM
> xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp nft_compat
> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables
> nfnetlink bridge stp llc hid_logitech_dj hid_razer snd_hda_codec_hdmi
> snd_hda_codec_realtek snd_hda_codec_generic vfat fat snd_sof_pci_intel_tg=
l
> snd_sof_intel_hda_common snd_soc_hdac_hda snd_sof_pci snd_sof_xtensa_dsp
> snd_sof_intel_hda_mlink intel_rapl_msr snd_sof_intel_hda intel_rapl_commo=
n i915
> snd_sof snd_sof_utils snd_hda_ext_core x86_pkg_temp_thermal
> snd_soc_acpi_intel_match intel_powerclamp snd_soc_acpi coretemp snd_soc_c=
ore
> kvm_intel i2c_algo_bit snd_compress drm_buddy snd_hda_intel kvm snd_intel=
_dspcfg
> eeepc_wmi intel_gtt irqbypass crct10dif_pclmul drm_display_helper crc32_p=
clmul
> snd_hda_codec asus_wmi polyval_clmulni mei_hdcp polyval_generic snd_hwdep
> ledtrig_audio mei_pxp iTCO_wdt gf128mul drm_kms_helper
> [ 133.104921] ghash_clmulni_intel sparse_keymap intel_pmc_bxt snd_hda_cor=
e
> sha512_ssse3 syscopyarea platform_profile iTCO_vendor_support rfkill ee10=
04
> aesni_intel wmi_bmof crypto_simd cryptd snd_pcm sysfillrect intel_cstate
> sysimgblt mei_me snd_timer spi_nor intel_uncore i2c_i801 e1000e snd
> intel_lpss_pci cec mtd pcspkr mei intel_lpss soundcore i2c_smbus ttm idma=
64
> video wmi acpi_tad acpi_pad usbhid mac_hid pkcs8_key_parser dm_multipath =
drm
> crypto_user fuse dm_mod loop zram bpf_preload ip_tables x_tables nvme
> spi_intel_pci nvme_core xhci_pci spi_intel xhci_pci_renesas nvme_common b=
trfs
> blake2b_generic libcrc32c crc32c_generic crc32c_intel xor raid6_pq
> [  133.105024] CR2: 0000000000000000
> [  133.105029] ---[ end trace 0000000000000000 ]---
> [  133.105033] RIP: 0010:0x0
> [  133.105046] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> [  133.105049] RSP: 0018:ffffbc38c5aafce0 EFLAGS: 00010286
> [  133.105054] RAX: 0000000000000000 RBX: ffff9e3ffdfe5000 RCX: ffffffffb=
b386100
> [  133.105058] RDX: ffff9e3ffdfe5000 RSI: ffffffffbb386100 RDI: ffff9e3fc=
43ef968
> [  133.105062] RBP: ffffffffba7795b0 R08: ffff9e3fd106c0f0 R09: ffff9e3fc=
4d8fc80
> [  133.105065] R10: ffff9e3ffdfe5000 R11: 0000000000000000 R12: ffffbc38c=
5aafdb0
> [  133.105069] R13: ffffbc38c5aafd88 R14: 0000000000000001 R15: ffffbc38c=
5aafe20
> [  133.105072] FS:  00007f24dc5e5740(0000) GS:ffff9e46ff740000(0000) knlG=
S:0000000000000000
> [  133.105077] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  133.105081] CR2: ffffffffffffffd6 CR3: 0000000104352001 CR4: 000000000=
0770ee0
> [  133.105085] PKRU: 55555554
> [  133.105088] note: cat[2705] exited with irqs disabled
>
> This was also reported at [1], I apologize for the duplicate report but
> it does not seem like there has been any movement on this from what I
> can tell.
>
> If there is any additional information I can provide or patches I can
> test, please let me know.

Thanks for the detailed report. From this alone, I see the core of the
issue and will submit a fix to net today. Thanks for the additional
follow-up. Missed the LTP fs testing report.

-- Rahul Rameshbabu

>
>> +}
>> +static DEVICE_ATTR_RO(max_phase_adjustment);
>> +
>>  #define PTP_SHOW_INT(name, var)						\
>>  static ssize_t var##_show(struct device *dev,				\
>>  			   struct device_attribute *attr, char *page)	\
>> @@ -309,6 +320,7 @@ static struct attribute *ptp_attrs[] =3D {
>>  	&dev_attr_clock_name.attr,
>> =20
>>  	&dev_attr_max_adjustment.attr,
>> +	&dev_attr_max_phase_adjustment.attr,
>>  	&dev_attr_n_alarms.attr,
>>  	&dev_attr_n_external_timestamps.attr,
>>  	&dev_attr_n_periodic_outputs.attr,
>
> [1]: https://lore.kernel.org/89dfc918-9757-4487-aa72-615f7029f6c1@app.fas=
tmail.com/
>
> Cheers,
> Nathan

