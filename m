Return-Path: <netdev+bounces-23625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F7C76CC73
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 14:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227121C20F7B
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 12:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3346FDC;
	Wed,  2 Aug 2023 12:17:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAD9187A
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 12:17:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A014BE1;
	Wed,  2 Aug 2023 05:17:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E07kC9a1Vw/v+tn8r5pxdf8ZA0QKLyZGk4ts2L8n74tpWWBVIGV3gk7GXXS2F+8G5cmF6ZyPBaXEQTccCDvuU8nLbvyoIJmSTawAIKr+LAEqpx68vnkNaKIS1WVxxugYeOi5A2nsuCC9Ck2czy+fBAUCGn7W0iwaAIyoOpxng3SaSgNnfUIgpO2ruX8vSkdoKP7I/DUBDr810GX4en7rc3vSWKKd0GA8MffE0IQjdiOF4+hW2zn++r8D0SXy1hMJnBNAr/3qH9nsK7OVGvNn5JiJ7LDd0aTl+x41PclnCmEjoPAZVEJt6d08MyMC3qe7y+hcKH7RKlMngsKIacT74g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYHajiT0V0Cp2OgghZjUS1aVIlkurL2gLai/n3461OA=;
 b=gRIsaETzVEkmdAIC8f1RzMVZgLlVmYOii3DZnu1mezj9jm8zn8vzh+M5d3fy5A+KgrvgzLfZIc2PMKBkK7XcXVZhqwTKAwO6gGmMwUDh/BVA6x0Q+hbMHViapGmPucVpXiD/uNsYhsEakTKbApS8uQY5/Mke0jJ7LT7q3SHuf1iOqR4nTA0QeO+Bh2oTlggGBpLDuOyVNbnhl5Eqt8+9RELaBre65+UyOPqKftxsC5FJ4/YUuTHcsWxD4q5E1gFFEqolKe/tSmZvWafEMKA1B2jY5OdLqBpLBbe6t/Az2XH5X0S7GwrbnQDO14gewZWd+J2pv1bNaLKLyIJ/w6WrYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYHajiT0V0Cp2OgghZjUS1aVIlkurL2gLai/n3461OA=;
 b=N8JrN4GskEp2RXTKQrEIhKo5/MlTPh/w5SJVpOAtX9Xc7yaGXIkYhWEdOv0HY/RJBztrdxm0hTDgmx3smMuPXBKzXVj+B+Kv6tt6uoi4+InxFPffnatvS3nuBZSgdqSRlibgIs3H9i8GE0bEjukszr6vmHB7NnDMxM1aQ7em8CV1IQolqwA4KLncr20rfG+n/vqD0BPSz84/SesmPWisCVxeqj2XQCWfRB/aiqO3fD9QZIZIWSPczZbbmBvXIu1e/fD76y09Kxs9pWdHYwXbaZ28tS3bcuctTrSUeKZr6UUznE5lx6Ar9kDLEjgEeMbj10gcWBix5G3lseRF835Qeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 SA0PR12MB4558.namprd12.prod.outlook.com (2603:10b6:806:72::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.45; Wed, 2 Aug 2023 12:17:52 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::2666:236b:2886:d78b]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::2666:236b:2886:d78b%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 12:17:52 +0000
Message-ID: <df565ce5-3de1-c9a1-abd6-d8efb9444433@nvidia.com>
Date: Wed, 2 Aug 2023 15:17:42 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next 2/2] net/mlx5: Expose NIC temperature via
 hardware monitoring kernel API
From: Gal Pressman <gal@nvidia.com>
To: Guenter Roeck <linux@roeck-us.net>, Saeed Mahameed <saeed@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>, linux-hwmon@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>, Adham Faris <afaris@nvidia.com>
References: <20230727185922.72131-1-saeed@kernel.org>
 <20230727185922.72131-3-saeed@kernel.org>
 <9479d3cb-0e1c-a55a-ca07-97f4205c46c8@roeck-us.net>
 <a3a996a3-81e3-5476-6cdf-ca034a7398e4@nvidia.com>
Content-Language: en-US
In-Reply-To: <a3a996a3-81e3-5476-6cdf-ca034a7398e4@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0254.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::21) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|SA0PR12MB4558:EE_
X-MS-Office365-Filtering-Correlation-Id: be857083-788e-42d2-0cde-08db93527e92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aFsI4uo2PjDDPni8dRFriD9IMVkLjYF5gaCnE4fdGJTmYfFtxtltMaV4twDm66QTASDYJNWrYl5fhEZdSU0GChIJcMyNR/956m39rKax3s+H0FBNn0/SZiCac70KcFpMAA6oAavWHKMcqUlzvdaVrnZDlaR4x/3HtCaFbrNtO/uKjEGDMEmh6Fip6GieUXJ9zvuZqiibJhS4ms8X9hFG8puYkipQAPzHgcq2Y5otYPlAiBkYG2d5ey6sm9n3ZnUkTAshZ+g8TPvPwF4I+dRTSpDajDe5WnGLmoTx+1k/mDp1tIJT0FROMG68Sf8yyTkzLgxdEWIZFVXu1BTrzitVI71TL55EVc0A3tTRGuXuCQv8+D3xCEh+HOL5MBufeNmCzXDl5v984dwCINn3xMHYwXDbbcWjhxcqBHF8AWZ5cYl7xQvQiBfX8iP51W4KnSz9+WFzr0/zwMDuCVMofuPPhUOhKLqkKG8wHAdwJkJ45hVZ7+Sx8fPmW6n0qI+2b2ggUoAAW0nk88FTIJTsx6PrCR/bsE0cmU54+SsDROB15oz/5QOMuMXZgkEGtSoRaOmRxGHE4P7aiQPzx/32I2nqRQU+YjK8Fu/MPse6uEKer+ET0hUFXIXlxv6Iu2NvFA3lsk94Y0C8ai/CXTxNh8IvLA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(8936002)(8676002)(31686004)(41300700001)(107886003)(5660300002)(2906002)(83380400001)(2616005)(186003)(86362001)(478600001)(54906003)(110136005)(316002)(53546011)(26005)(6506007)(38100700002)(66946007)(6666004)(66476007)(66556008)(31696002)(6486002)(4326008)(6512007)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S09aY1ovMkZvbEVkNWhoSTgwT2pTdFBqVEpMTzVWOXFtKzBBbWIzVnhsd2FN?=
 =?utf-8?B?NE5kQUF5ajJOb25LZGNuR1hBQ1VXZ1o4RDNPTy80NjkxUXZWNEhhaHNRSDlC?=
 =?utf-8?B?OU5QWFh2Rk03Q3pMZzY2enhxd01haHlGSmxkVEl3dUROclphM1dtelRQcjdL?=
 =?utf-8?B?YUZJMkxpM0hKL1dSYWJ6cHNqVDBDcmEzNzh1MFZ1S1orM2xxTFpPTVV0Zmwz?=
 =?utf-8?B?MThKM2JrWnBtZDM3cGdlMzhzRTFVRUwrUXVUZmRTMXdHaHZZSE9yQVEyVi9w?=
 =?utf-8?B?c1NnTVVMejVqY0xxN1Iyc1NOa0REL1gzWkVOWnhwQVhYWEt0d3dJTHpwMW9H?=
 =?utf-8?B?djF2WHBGNFZIR2IzZjRYdFFBbUhlQUl5VzJjMVVqM1Y5ekt1YThnQUZHanhm?=
 =?utf-8?B?bFFPTVQ5QlF1WnZNUnBQKzA0eHhBNlhIMFdMRGVydGF1Um81SUM2WGtLOXZq?=
 =?utf-8?B?L1V6SjNWbzMxKzNlNTJWSXdCcXdQRUJyU3RDbXFWUEVad0pmRlhoMGE4WXI3?=
 =?utf-8?B?a1NJcFpKdlJOQUFaTzlRbWFVWmcyL2x2ZXdidWdaeWR0WU9qY3ZuNjFlUFJ0?=
 =?utf-8?B?bit1UWlKSVV4TExCT3d3MXVRb3ozc1pnYmdZOVlFWWRpN2pMWU4zbXdTL0pQ?=
 =?utf-8?B?dzl4SGtuWHJrMENSSzQvUW8zbG1HdFBLWlhkUkpUQW1BaWQ0eTZEZGJ2OGts?=
 =?utf-8?B?dE1jcWg2YkZUR2tzZGhUK3gzbEFLNitjcDJkMUEvaDVoQ2dCTWpKeTFDUmVn?=
 =?utf-8?B?MDJGNDJoSXJDNlo4SlE5MGJYM2JydGRYRTIyblFLc0g2bjZMbThHWmM4SDl1?=
 =?utf-8?B?bVNld3FrSHlOTTRJVnB1bmJUbXVYV3ZGVVFLRDNOYlkvRGN6cVUrMlpxT0dp?=
 =?utf-8?B?cC9VbnNsM1ZVOC92RXNUYzh4a241TXg2RTdBRTNzK3NRd0RpUmpqTmZZWGxV?=
 =?utf-8?B?STJVZ0pLRHhpOWgwcjBOOXBmT0xUL2FLYTJuV3JoY3NOUlhpWVY3TGtodHRO?=
 =?utf-8?B?dE9YcGswcEhDRnp6NnpBN0hxdmVWaHhpd2NnUmIrSlU2K2dkbDN6VkRLUmE3?=
 =?utf-8?B?UlBEZUpoVElhTGVHb0FNVnoxOWhXR0VJYnllNzd2V1dROEtqQjZlSHJrTWNQ?=
 =?utf-8?B?THMzb1VvdVFjVHRjeEZUSWRkU05CZEthWXdJTVJoN2U1UGVPUXlzS0JmdXRS?=
 =?utf-8?B?bkRIaXQ1WDA5UUY0QVMzVUVUNUczL3EvZ2kvbTJTWHRUYXhFa3ZLcjU1ZXlJ?=
 =?utf-8?B?Y1ZMcC9KV01PN0J4TVZTY2dkMWRjdlNHOG9XaCtkT1JodTFaZ2ozeDFsTTRt?=
 =?utf-8?B?OFZwVDA2bzFnZmJRSHUrWDN2SFZ3SGhPVU5nTWdoSUN0NithNTNnTzBqME5q?=
 =?utf-8?B?OVcrbU84cFNueE1ZbndxOXlXbVZhYUp4cFY0TUlQZFRkdDFKYStBa3U5dXl3?=
 =?utf-8?B?UUlXRkxpVi96cXd4OEhVT2t3Z3VqMzczb0NsblJHVjNHNTBjd2NIbzl3RXgz?=
 =?utf-8?B?TkNVTWtsMkRCRXFWUzcxWkI5NHFud2d2eHo2UU5CNXVJZnN6clV0N2cvTHVk?=
 =?utf-8?B?MDEvMDJPRjhZNHJ2bXRpRHRkSmU5SWZ0TUpJbHpScDJJc0ZQblNPNnU1ZC9F?=
 =?utf-8?B?RHkybnhuOFM4dXpqd1c2bUpwaTdWelZJZ3N5bkJlMTJ6SGxKWHlvZklxa1hC?=
 =?utf-8?B?QXUrYmNReGZyY05kY3RiWktpd2ZXWE9jNDNlcDNRNHNUOHJHOG5XMi9oUVk2?=
 =?utf-8?B?Q0gxV0dSRjlrVmdUVEhxVk90d3UrTmtxbTJ3TUpTUlc2Vk9IdEIyOGtYbEdu?=
 =?utf-8?B?SCtKcFpCTzRGalhhbmNSQ1FvK2RSM3VrbUR2UjRvS1dzeHZQZ012dHJpSklt?=
 =?utf-8?B?MEdqV0FNRWJqRmlYNXVoZlYrQlZXUHQ5clpJUUVaekI2bkxIY21IT1ZFMnZ0?=
 =?utf-8?B?YXBRd1dFb1dqbHEyU2d2eGR2R3kxUEZ1TWlEbFg0TmxnRFFMZi9DSUtSQ1JX?=
 =?utf-8?B?a21iTWdWSGdzaVlwcW11QmRNRmZuNGxwNUl1QTgwb0pSaTIzbEtBZ2FBNEln?=
 =?utf-8?B?N2lKc1VwdDJ6c29tMi9kYXZkWmMxZ25zbFV6eDhTTlk0dm5jY0lCOXBNa2tZ?=
 =?utf-8?Q?O9fWfnaHUYldXBUFsJ33QMTkT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be857083-788e-42d2-0cde-08db93527e92
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 12:17:52.5594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRD/VbaIur585Fc87iWfCZpyJ50TEc8igdUoxQVKpe4DTgag9d9RhBj09Iob5yB7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4558
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 02/08/2023 15:10, Gal Pressman wrote:
> Hi Guenter,
> 
> On 27/07/2023 22:54, Guenter Roeck wrote:
>> On 7/27/23 11:59, Saeed Mahameed wrote:
>>> From: Adham Faris <afaris@nvidia.com>
>>> $ grep -H -d skip . /sys/class/hwmon/hwmon0/*
>>>
>>> Output
>>> =======================================================================
>>> /sys/class/hwmon/hwmon0/name:0000:08:00.0
>>
>> That name doesn't seem to be very useful. You might want to consider
>> using a different name, such as a simple "mlx5". Since the parent is
>> a pci device, the "sensors" command would translate that into something
>> like "mlx5-pci-XXXX" which would be much more useful than the
>> "0000:08:00.0-pci-0000" which is what you'll see with the current
>> name.
>>
>>> /sys/class/hwmon/hwmon0/temp1_crit:105000
>>> /sys/class/hwmon/hwmon0/temp1_highest:68000
>>> /sys/class/hwmon/hwmon0/temp1_input:68000
>>> /sys/class/hwmon/hwmon0/temp1_label:sensor0
>>
>> I don't really see the value of that label. A label provided by the driver
>> should be meaningful and indicate something such as the sensor location.
>> Otherwise the default of "temp1" seems to be just as useful to me.
> 
> Agree, will change.

Sorry, this reply refers to your previous comment about the name (use
"mlx5").

The label used here is meaningful, to clarify, when new firmware is used
the label you'll see here is the actual name of the sensor (we'll put it
in the commit message).
For older firmware versions, the index used is not a simple incrementing
counter, it indicates the index of the sensor as defined by our HW spec.

Both cases are better than the default label.

