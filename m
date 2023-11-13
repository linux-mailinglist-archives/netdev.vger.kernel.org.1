Return-Path: <netdev+bounces-47378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2C97E9E01
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 15:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C771C2086A
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 14:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857AD20B1D;
	Mon, 13 Nov 2023 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ca7hg33M"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E255208A7
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 14:01:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC994D63
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 06:01:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlSnEMM6h9POTXnfMpgs4qfh+soqMHP0I3+p4koPVDjbK9jXossz4MXIJjUAmbEcwEX81orpLXqq76rEO1TgKRW6B4hStNg+E7H2d/Cw8m6QpnI48+54s+HnANqkRzW3UaT1HgwjlqnjxndMNF1awLofQT6Iz7EKNujgE1uUp8NrlPlFUJvjsYdA3ZGm3zrAQ4nwVxielbXqkrD3wznAksWRDOw3BErgqOp2dn97aXKbLK0179VoqfNa2s8VXL08ba1JEnTpl1uqi5oA5zmXGLOtU29tHSHIZ37S1eXvAVwpuq6hgzL2ShLSwo1Bp2S6PlDnNbQcDpksiF6ac8FJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Od31lEac9VCVNzHjVhIHt6EqpbYR03b/zaMD3chUQw8=;
 b=MyRMqp+xm1g4Rced6rSo8J68jKQmjlp2lBweCP1d5+dIufFc7lSQflebq8lqoJyBlTlFFDHDjFuyhc4p42YidYhmaI9GHBNUQFdQynQjYYMgvzoebtofmh1GlJe1T5QwfrdKiBlBaHFCK6J0H8VieRcB5enxSMN04duJs98x3cfK0FsoBfPa081+1vvWRFovsXsQx174cRRiLmmLcsuQQm6DEge3WWz0AvIlZLybYGvg1y80eTdRyw3KOPDDmLf1b57ZDlpdSFZuwX00XrtAnTQV7KJ6fY0RUWzaTvbgCLXkWCfxyZ2UHx9SLzLzvrmBwSQ/+nB0EEoBivy6EVkbXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Od31lEac9VCVNzHjVhIHt6EqpbYR03b/zaMD3chUQw8=;
 b=Ca7hg33M4j4EFx1UFvgwy9D0AaIT0TaiQjMN3UwCLfXP/kUCmehg3qSQxtczy3clzzuoXHnqQ1UgQohu89ACSqIcWdyCCdJtYEwEb6ck42hX3dlmosC5LDhiCOTfLtSNAw8y8SwhKL7KOpYRTWLSmoz/zVDAdfwauXTjYgm451kYDnjE/tj8fMIBd7z8cLi7eRmKqpAKba3WyndIPh3Ykg/cfiM7l0yNe5f3qIGt24hCrsqOlisRlwNg9wmh1EMF8Hz6q2AC9XgnUs9rf541SLQp7+RvF7HFeHBwJxXGb8eykh7KhnftM9D2td1ShOHOJqpCnPUGX0+utvdbHY8y5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.29; Mon, 13 Nov 2023 14:01:28 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::8cde:e637:db89:eae6]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::8cde:e637:db89:eae6%5]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 14:01:27 +0000
Message-ID: <dc40af68-80a2-4821-b674-12462086973b@nvidia.com>
Date: Mon, 13 Nov 2023 16:01:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: Fix undefined behavior in netdev name allocation
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org, Vlad Buslov <vladbu@nvidia.com>
References: <20231113083544.1685919-1-gal@nvidia.com>
 <20231113095333.GM705326@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20231113095333.GM705326@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0189.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::33) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f71a23-c9a0-4393-0d66-08dbe4510763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Bl74UvQZ4E8zKiQwRXNIPvVJiZ5DZnzw/CVjoiaNVJ7yGhGpARMprNDtJ0IVr6f48gYVNwrXPUCrpri2n5rBPOPBnr5qGBVjOLn+7pmj9sreuTdc/0Om3QZYQQrTRGYchGssQQV198PPvrkzg1/hIoi46ON+WvCKkWTTTphIJylR5APwtQZ0wMxT9Hx07QzRHGAwmslqfeQOMdL3QANBjp7Fbh4eLYn6HCvAQ5jZPZRt+PgoWmuUtjrdK64FvcppzDF19HqvqRjYoYeDIoK1gNKAlJwwUOpVhk3ILzj5401ykPlmHTRxNXeGrJFhPvnophjn4qr4oYyM+HDpCsBzsVN6darRWjsDwtaJu5pIsuekQYCn7GZdmNY0p/HxEyJMxL1LYs9lAUopdwcFUgDGCovUKpQIvWRASOKrSJPA5/KXW6uJuveehyZaJpmbCi3iRWNqPPSNviOCZw1rfwxxMNFIXxvjrzgjzSWIBsLDuZU9m2qhy5Dj9txc86DfxCbS9pqGrQjYL6SkmQivcjY76sSaJrgOs3MxNBBsvAxq3dBw1oS0RLHfh9i6a5fCrDTVPZhE5cfAoGYlWir7X6ds4ptHweVsK89wqevPlw8JCFDPms3v+C3xsw0FAVaDYYJKq2mdDG1yEx6RoQzkxg5n5g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(136003)(39850400004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(26005)(107886003)(53546011)(6506007)(6666004)(2616005)(6512007)(5660300002)(8676002)(8936002)(41300700001)(4326008)(4744005)(2906002)(6486002)(478600001)(6916009)(54906003)(66556008)(66946007)(66476007)(316002)(31696002)(36756003)(86362001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2RvcjVKNUVicFRBOFNQYVZxS1hwRC85SktCOGRRRU02UGxHYUVDcmFQcjBx?=
 =?utf-8?B?SGUwVDFEMDVpUUxpSXcwd0pYZjN5UWtaQ0x5Z2tnWlJVckJkazVRSmtIQTJw?=
 =?utf-8?B?SkhrM3ZCZ1d0eTR0RnVsd0kvc05jM0szby9UT0h4cmpkUlo2YkdpdXJITmVh?=
 =?utf-8?B?WGNjYitNbW9KZWNXUC8vdlNrWmVIWmcwMCt5d0cvd2VVamlQb3l4QWFwdEps?=
 =?utf-8?B?WVR1NnVOUnA1aTdqRVRQSmMwak1GSTJGL2ZqMTFLcG11MTc0TzlFTWVoeXNE?=
 =?utf-8?B?Q2lzNWJNdTBaZ0E0ZStVTTlZOVh1L1BuN3h6amRaMGJkeWdaUnJaUUExQmlE?=
 =?utf-8?B?Q204d1dkNVd6NkNlSis1c2R3Y3d5UjhNUjNyRFNDZEpCZGZEUXFlVTFsZ0xS?=
 =?utf-8?B?Q2lHZ3JPQy9zRGtjQ0lMaVpnZ2dSbEtOVTJFQkJEQ0FOTHErbXNNY3FDQzlw?=
 =?utf-8?B?VGVnUHRQQWN4MndmK0FWRjlHTUNhSHY1MDJGb0lPVXlEWGFLZ1kwOCs1cW1K?=
 =?utf-8?B?bVpFNkh0bEpVZEYwVXM1cEpiWFVyWHhTbGoxb3F4eVdCVmVZVUJoWDVEU05a?=
 =?utf-8?B?MEZacHBVSlc3dmZGaTFtbng0M0lPUHMvbE51eUJmbXR2a25NTTAyU2R4Q2c5?=
 =?utf-8?B?ekFjdDcvaDJEajJ5SDFqU3BsTmcxZUpIcnlPYVZmVWpHOHV3UG9oSmVyVThv?=
 =?utf-8?B?RUcrc21vL1g1Q2FvUTRQMHZ5end5TWllWmRLV1BCaFYvNG53NGpkRzRFQ0dh?=
 =?utf-8?B?VUl0Y2RxeHRqeWViWnZiaFc5ZVl0c0MxbStoakNXV0Z2dlVTckN2ZXNOaW9o?=
 =?utf-8?B?eDN5TW9xUmpUenNmaEE0RWJTaE5ZaG9LMHZKZ2ZNMUJqajQzd1ZJb2xPZExi?=
 =?utf-8?B?TUk4VHZlWFRFSnF2eVkxTjlFS25VV0JCbGlpamJ6MmRXN3FEd1hRUjhjaTZ2?=
 =?utf-8?B?RFFJTlJSR3IyTkZoNjVIWVlzd1BYZGljam9TUFRKUFZrVXRveUxEUTFOcjRx?=
 =?utf-8?B?dm81MTdIVHZLMnI3Qk9HOWhxWGg5QWtSSStZMXRIMWRwWW5iYzJFSnlJWXlY?=
 =?utf-8?B?Y1hVSGVtelkzQ0tQVmtxdGsyUzc0YkxMZXl1ODBDVWFSMFNVTGxtR1oyVnJJ?=
 =?utf-8?B?YS82dVdLdThGemZLaWsySDlHamRoV0kvMVllN05oOXUzc2YrWkN3T0hublFa?=
 =?utf-8?B?RTFHTUNIMFFkQTB3NWtBNG9UT05oeUpoZ1NMcllGSjhnamp0VUZzUkZzMHJJ?=
 =?utf-8?B?QnBHVnZOSjk4VjFST0ZjVkRZNkhlTDFxTk5kSytrQzc4UmJyTTFxZ1pNbnVj?=
 =?utf-8?B?TTdEbWcxT3pPWHo0U250RlVpeHppYW8wTkZkWEFBbHI1Nk53MnpnY2cwd3da?=
 =?utf-8?B?R3o5d3c5UEJLRUdkYUVnVVl5RkwvcHVVeGlDZ3lYTjM3Nm9UUUFGWTFUbmZw?=
 =?utf-8?B?NFVmL3FCMldaVGVZaTduajU5M1lib1RQbkUxMGp2ZmIwQ2pJZGw2MXZTY0tI?=
 =?utf-8?B?a1R6RnhhSTRUbTFQRWVRcElpV1NWQmhSeXY4aEhTYlRhWHg4MWRDNy9lekI4?=
 =?utf-8?B?VjR3S2NZS3dNaDN4dXdJMFNqdVFaczFqdEJheEpheWVvMlo2WkZPQVljejB0?=
 =?utf-8?B?TXlsN25ac29GK25hR0pmOWZRMjVBZURFZzlZdXQ4Sk5wUHBvdmV0bzZqdDF4?=
 =?utf-8?B?eVdSc0J4OWpYRG1qNG45OTBxUmdhbjlvTVgzRWh0YnJINU83aXpHTi9EN1ZJ?=
 =?utf-8?B?ckdjWVRZUHBlQy9IaVhpOG9qQlF6VHRhSC9KSUVUMjhoUDkzOU94ME45Uk9o?=
 =?utf-8?B?VSs3UGhMU0RLclJTWVVYNG9qYmwwOWxMaGltUVhjY05vcHlRbWd5WFNrNHhN?=
 =?utf-8?B?SVlTL2RLdW02dkQ2M1ZrNmhiMnRwNm0yWHE5NjRGN2NtSlltVWQyM3oxa0Z2?=
 =?utf-8?B?cHJpUzNFNjJyYldpT2JCMGdXdU5zbGU0a0trSFFVYmdlYkp2QnpsRU1NajBz?=
 =?utf-8?B?clhYdkFhMXl1d0ZyUFN2d0VtR0xWWTUrYm9jdDQ5Yjl0Ykh5WnNvdlZ5UW56?=
 =?utf-8?B?dElyN1hwVXNOcDNLRVBtUS8yeE1hVW82K2U4SjMzMVE2UGtPSHY4MytRdk5z?=
 =?utf-8?Q?Q5/KrV61w0gzlgXtY3+uZCge8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f71a23-c9a0-4393-0d66-08dbe4510763
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 14:01:27.3209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Th5QCDm/l5N7RG5jsHL54+fmeHpSokLGi+6YrHyHgQiUMlcqqNYVShAlBI7N1Iql
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955

On 13/11/2023 11:53, Simon Horman wrote:
> On Mon, Nov 13, 2023 at 10:35:44AM +0200, Gal Pressman wrote:
>> Cited commit removed the strscpy() call and kept the snprintf() only.
>>
>> When allocating a netdev, 'res' and 'name' pointers are equal, but
>> according to POSIX, if copying takes place between objects that overlap
>> as a result of a call to sprintf() or snprintf(), the results are
>> undefined.
>>
>> Add back the strscpy() and use 'buf' as an intermediate buffer.
>>
>> Fixes: 9a810468126c ("net: reduce indentation of __dev_alloc_name()")
> 
> Hi Gal,
> 
> perhaps my eyes are deceiving me, but I wonder if this fixes the following:
> 
>   7ad17b04dc7b ("net: trust the bitmap in __dev_alloc_name()")

Thanks Simon, you're right.

Should I resubmit?

