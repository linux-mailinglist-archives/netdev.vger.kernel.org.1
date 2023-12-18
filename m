Return-Path: <netdev+bounces-58628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8522F8179FB
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 19:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171EA284B70
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 18:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC3649899;
	Mon, 18 Dec 2023 18:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WWY8ucFo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905A2481BD
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEOvV0OqYj5mh3fDuGkGEb8LMIzEZzGibw2DKNP41RoJULf16DMgMzHfB1A0jvD/HRoKI5AT30m4CT+5XBqw9/e44jSjVORe6xd5JibBAWop9fA4tYw04BNKd0AFz/h0ob9oOABtfbedky9pnhK6iNIcQbWAnBKaYmdau/5PK0zkDcIzZyr23RCi45cybd+Jq3jcwd5eqitjYxVjRF7HAqUqvKDx8EyWTsOyZchubawSLejg/hgduJEyPAktGwAdGHtuWtHi4rX05m7TLut9wLJI7ZBIcEaViWwNda5STWouzzDj9A9ceDj6YaxDlNfWy7SQDZJ23uiW+V9Dr2MYAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cXF8qrtOX+Je4MwBn58ywKW38naLcAPtnDb+k+TBGU=;
 b=EIHNFeuEkrQhIIaBqaAXB7i0o2ZiBK76czsQ3cRDE1OQGQeYXfLnYfy2IMe5XImltmCLOLzJZDK3UsoKk7yPWsYubuGySuU5tqhjiFmvjwZiWjV4W799TcAVaujgkwqxgP0fNmuktRnStbOJe0iv/h4+0rZVmy3sOXTqwqeyD4fOxyKbOg40ZLTBWu22MYi4IxdJzO7psuK54p7goWpVn+2cTxlgEj5182eUSSBNYnMwPq0XWh2G75eMh7sJFAeN1gNaBZI1uXvmFP8vrwBUu7jIfgKzX0blcl+FbHqTp4uF6rz8mljkYXZpNwz1Lk2ARhTADN+DRybI4C8wthz27A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cXF8qrtOX+Je4MwBn58ywKW38naLcAPtnDb+k+TBGU=;
 b=WWY8ucFop7thpzeKN+LGKWrR+gJq03Z0C9st572G4/Dfx3gTLHaN20QnbnroXry4pXGr8pQrSho6tA/d/E9lpahbkKLHEDSV+tiHxz2fgYJIb0N6Ib41aOmJjqVCn7wKcGbNPLcNcU4rrYh5zqNMbwy6dHmwh8k2p3bb3cHeNq1lS0uOzW3v8qA+9R/la1vy4BWCTYBJjZjN1/UnuaqD4+FN9PucNcKpfvVcf2cjJi3PVCsO0CFGRSOeqekYsBnk3g4Tn6XuRX7CMngig7PirCrIE2cOHtXxYumn4a9T6nzz5v1GzJ8LbK/AiPRGRejVS/q3k/4m7/jEUf1Y5EN/rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 18:47:21 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 18:47:21 +0000
Message-ID: <589628ef-60c3-6828-80d4-d142b5ffa7a4@nvidia.com>
Date: Mon, 18 Dec 2023 20:47:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v21 06/20] nvme-tcp: Add DDP data-path
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com
References: <20231214132623.119227-1-aaptel@nvidia.com>
 <20231214132623.119227-7-aaptel@nvidia.com>
 <1b0b08f9-3e1a-106e-15ec-46cfe07b1e28@nvidia.com>
 <2538r5ridsb.fsf@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <2538r5ridsb.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0211.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::7) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CY8PR12MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b1c7004-6f44-4295-9f6c-08dbfff9c4c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o9gsioSxq1s/AuTo9FhukJnDCWtIop9AI+i8lz6meorjDHECjzym7y6DFQWzPx8/ofYBsPOpVirzfd2ED0UvXiDFhTWqwQz+dUfohKK7RTyCygX5GyyGj2O3jGMWrzI1Of0ch9GHsKJ9C7NVrZhDJ1HZaYiIEbY2gCGamF9h9vn4MO6C7DwUjJtOpmDPclCkrA6pp85uh9zxhn8vmju15JGm+erc/wYU3ojb+iFmkS1wUC7h0hB16t7ck98W04ZJ780Vy52XBLDuGhFkUNlWzFigAOzii0AeqnsclEJvJ5Zoe2k+rdnNz2THm0Uu86mbLDVKqCUivNr8IaJjIKATFaFixf+5ht6b7xUyaEcGwGhZdOaWrjN92MvxvK8gOwlqAJ8IiPjc0KVFdvvxoP0lmc9OlC9ticEp80BTDIuLaMgGCTAW1LsZ5KR/yXdkfXy9I4AvhH/ycw8wCw2p28Ubi4QmML3KEkkGLsYPjCfYG2G+CSgt4K0hOxElrIDUQHRjXDHVCD6ks1UBx4G9SXBK5Vep4sNQzwCZJROvUIfmsArIyvL+9JkRWNU5ESKfcTVQ3ZQNo9iK6x8+zQAZpLC4Fx7grJqPm5t8qBYATpaTDJLz9XgaQfRiw7ZepebAZ4N8/4s5Wh3UoeIJum4aK92SzK2XkYSFPwtXMSkcBUcT4so=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(136003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(83380400001)(66946007)(66556008)(107886003)(2616005)(478600001)(66476007)(316002)(38100700002)(26005)(6486002)(4326008)(8936002)(8676002)(6506007)(53546011)(6666004)(31686004)(6512007)(7416002)(5660300002)(4744005)(2906002)(86362001)(36756003)(41300700001)(921008)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWJYNkpySDhHVVJsNmF6eThUNE9xQTRscnRWMFFoU0p4a1RSMUFtRjJwaUNI?=
 =?utf-8?B?ZGkyWkluRXlUY3M5UGFJVVVrV1ZDWmRHOXBQeW54cG1IRVpjRjlOM1h5cU1W?=
 =?utf-8?B?SXBjVzYzY0E1RFJxd3g5ZU43SVM1Tnp0aGJ5blBmb2gwWnVoZ3NTL0Y4RFNY?=
 =?utf-8?B?cXcxOWpQMURmNTViNnltU0ZSaHZDcXBNVXpZLzQvdVJoaEdlbnNGRGptb2kr?=
 =?utf-8?B?dzlBT1I5NHhoRGVETGtUN2pKVmU0S29BMzBBNFNpbDBhNngxUmdremRUWCtL?=
 =?utf-8?B?aHovSGd5VzhOcnhVT0ZzeHZjbmlZYi9mU0owUkNMK1NsSGZmcjNnS0gzTzFL?=
 =?utf-8?B?L0s2VTQrQW9SclAvSjJpWTVlUzNYV0NjN3R6NGZqVjh2eXZRK3IwelhPZ3RO?=
 =?utf-8?B?b0RQaTduY1BjM3lrQ0haWHFmMy9mN2JIZW9rSnhIYy8zT2NzRmZyTDV6OXlT?=
 =?utf-8?B?SWFrb09TaHBtSGZUVUNEMGNQenVnVmtIL0dpb3FvMkczUXVPcUlsQWViRkZx?=
 =?utf-8?B?UzVLMG5kZ1BiZ0JJazdvSUJxQ3hnSk41c290Y1lUbkpWRlk2aytEZTZaem50?=
 =?utf-8?B?K1p4bDVRR0xWU3VrZUw5UVhKdHJuaDlvSk1UeXd3QVlMcEdidXlFYVpleUFn?=
 =?utf-8?B?aGtGb3crR2hFM3FRZjV6OUpCUW5rTVNsc1JEUmVYeDBPaitROFU4TGFkcVVW?=
 =?utf-8?B?TDcrQ3cvanhvSWFPTW5EMnFjbG8xY2pHTlFEdCt1T1lrNlBSVE9UdnZFSlFH?=
 =?utf-8?B?ZVh4THFqc2ZCWmwxSXFKSnVPRlZwcDlQT2hoVC9BeFgrTlRvMmRWRGh4M2tp?=
 =?utf-8?B?K3hxR3B2Q2tuRnRucHhtVVY4WmZSMTZvN2crTDlhVkE4RlUrbkprVDVySG5X?=
 =?utf-8?B?OXBIWUdHUlU1cy91b1dXajVIY0dqZ0ozaEhUWFROdlJxSzFJVi9ieldaVFRi?=
 =?utf-8?B?NElxVFhOczdKYmVWRTNWYkJ6TGVFd3RnTFNOUUFuaXA0a2w0YW05Y1hkUjBt?=
 =?utf-8?B?SGdxcVUvdUI2WGthZW5KVUw1QjhIbmhuR1hPSThQYlBUZUlvMGg4eG9vbUhF?=
 =?utf-8?B?ckwzSXlpU05wMEQ0WndsZ3BkQWZxNEZ2TlBqYzdoU1oyT0ZsNDk5Y0YvaUFP?=
 =?utf-8?B?ZHoxRXZaZXRMN0xBSzJTVExnZHBwQmRoS0FLRTJHK2ZzZHNEMnE0M3ZVZHdj?=
 =?utf-8?B?dmNVSkZaYUV2eXA5THRudFM4ODdqck1pd0pDb2p6RUN6aDVMbWV0RWU2T2RM?=
 =?utf-8?B?NzJ4R0lBSHBiYVRCTmgzQ3FXbWlNdEFxZjE5bHR0aGFkNVFxWkFMQjZHekVR?=
 =?utf-8?B?R0FzSzdDN25xNU0yRGEreEIrazhxejltdFZyMU1YekN4ZE14eFFwV0pHNTlo?=
 =?utf-8?B?OC8zRUk4Z1MzU0NkODFwbTE0Q1hIczBIN2dMcWt1SXNvR2NsVlVZUnd4VTdy?=
 =?utf-8?B?OVgrUTFiQ2g2K1FiNDFISkZzWUhNdEwrUU1ETFhVYmZuUElmM1M4cVJ5bUFT?=
 =?utf-8?B?RGptZVhnbE9xekRXT2hqNXNxTEpQVElMQVFacVZEUDJrd241U1JXNW1FVkdk?=
 =?utf-8?B?aGY2YWJGRmVUcGFtdGlLckVZTTN3anVRdXFKc21WWUFqWnBZZld0eGpWaGw1?=
 =?utf-8?B?MDJZR0lpcDRBa2VJc002NzRiVVRNcjZYUWppTU1JM1dabkZ5eUVsUDVyVlVD?=
 =?utf-8?B?WHJrekpuSTc3MTE1aGN3Q3FIck1rZktDRnZhMVFmS3kzenNTUS94NnREWkQx?=
 =?utf-8?B?ejYvdkNZNXVwQlM0bkU3UlRvUGd3TVdmK2RBSGR2T1FXaHVLV1UxUmdKM2tx?=
 =?utf-8?B?TUVna2daMHJISjRLOEkxbW1zVVhrbnRvRlR1NzRJK2hnbjFXOFg4Q2NhQTZR?=
 =?utf-8?B?SW4yUlJxMHlzeFB2WTQ2R1NoSHlXZzNOSk42ejBraWZyYjdEckhnalV3MCs5?=
 =?utf-8?B?cytNL1FKejN0QnUvM2JRYVVsaWZ4UzhEMFFXNk5BZ2lUR05sL1pSajNoaTdQ?=
 =?utf-8?B?SnZiTTNVNTlscU10MGgxZUVxSm5lUC91Sms4Mm5jSDNLeDVUcFpkWDYxM2Rk?=
 =?utf-8?B?TmRHUUpRckN3VFRWOGdScHpLNDdRcnV0Y0tPOE1XeHFCZVpkbEJvVEQ4MCtk?=
 =?utf-8?Q?jfMXapgxSvwsbQEGuC91b4MKV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1c7004-6f44-4295-9f6c-08dbfff9c4c0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 18:47:21.8333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1IZhaW1zU0sJ8IGRNSljVYUFUWfd+0tpAeAn+y+ohkYcqunFfvuyztEjWBEXR1QYIHeLo+yjLRS3lXoWoko1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8297



On 18/12/2023 20:08, Aurelien Aptel wrote:
> Max Gurtovoy <mgurtovoy@nvidia.com> writes:
>>> +
>>> +	if (nvme_tcp_is_ddp_offloaded(req)) {
>>
>> Same optimization here:
>>
>> if (IS_ENABLED(CONFIG_ULP_DDP) && nvme_tcp_is_ddp_offloaded(req)) {
>>
> 
> nvme_tcp_is_ddp_offloaded() compiles to "return false" when ULP_DDP is
> disabled and the compiler already folds the branching completely.
> 
>>
>> if (IS_ENABLED(CONFIG_ULP_DDP) && test_bit(NVME_TCP_Q_OFF_DDP,
>> &queue->flags))
>>
> 
> Same, I've checked and the test is already optimized out.
> 
> Thanks
> 

Ok looks good,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>

