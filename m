Return-Path: <netdev+bounces-47617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E7C7EAAE1
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 08:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334741C2089A
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 07:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E60111732;
	Tue, 14 Nov 2023 07:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NgLS3n9N"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E23D11718
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 07:26:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BACD1
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:26:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTw/Foha1DjtS41sUsjSaRojedatqnyuAxHF/j4PkxvEKTmb5jKSZdtilLklEFYEMjbzVSGY6UMd+DkHaW/dYOm2Tw6Wi0iSu2wZ0j5qmtqVMQ/B7uWnhOJOcG5BjbW/GCKR0HdRpDGI+ZboLNy8zrlUkHAohe+2sO+NYmiuuAeB6ooM+SefnP7+WOuevtM2KSj7qMTXAh2x+BaMFoUIKK7Nx4u8mnrKsWHaRlyhDIquN2CzZqiTyo253kf4FP9Z6tbloz+sdY8q/DpaqU88E3CGiIv2WryJL+iOrho9VSO7i4npmQhG19OB8yl9MI85KJxBc4MAygOISgv6feDK0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YTGriSMYrl5+w+nfD9gXAucFAGKHwThBB1PM0tX5QE=;
 b=ZV5Ro71WB15Nckiiyz14APfQ7yRTtLM2KBzhBfxa4fazZ9xtADnqSnXclHp94GbE2u3UiRsVCNjM3RLhnN+Jg9rxEAxGnprs5lBRzOE0pGSoMLG7SlvGZYY0hRd8rrVLMI4h8NGdgzR1XnHTS8foVwYrjy6r2Wg4/Smv6cOrBM7JPQ6Y6fNlUAD5wsbdj3JEAcIy4kTbNGwiMv95TDjXfQKPP3BTXq25n/VBovD2B4hnH4KRKxWM8qYfvPNp+sNWjouWqDiITWSf67+H70yYPYP3LjW9FVslbc2irMryuXed3xr8Ra2C46L1oJU6uNJu20ApchEC/rBNuXpbveSYjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YTGriSMYrl5+w+nfD9gXAucFAGKHwThBB1PM0tX5QE=;
 b=NgLS3n9NvvFn4QF6uZySPpFvRr3mkVRPyin99xTgI1A/bocHldmUHYhnTarupmvJGQI8JDkc8Klk1bOV6lRjJWlacOG5uk7UwgtVJ9EUYVHvHRag/iOPD125qHBndaqqAa63izl/xhBk/73Iwy0B707sd3hEXB5aref0RSgZDqGWUsfy6vV5wrVikZT/KNgtgWxQxqkD+hKOrSfdwZMYZZjYRaFEsjEAJl/PUJr6lAEatAJvuS0wcg5jQSYOrY4iQXiJS5u0d1lTZL7JVAvgnw3fx4dnvyM/0myootecdLezDESZOY2ntG4zCQRn9Elp4gfPyzv+LqE1bXnym/4rlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17)
 by PH7PR12MB6763.namprd12.prod.outlook.com (2603:10b6:510:1ad::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Tue, 14 Nov
 2023 07:26:25 +0000
Received: from SJ1PR12MB6289.namprd12.prod.outlook.com
 ([fe80::b92e:8d27:9bdc:6899]) by SJ1PR12MB6289.namprd12.prod.outlook.com
 ([fe80::b92e:8d27:9bdc:6899%5]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 07:26:24 +0000
Message-ID: <e5855cdd-7f78-4fd6-94c0-17813c781b4b@nvidia.com>
Date: Tue, 14 Nov 2023 09:26:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: Fix undefined behavior in netdev name allocation
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 Vlad Buslov <vladbu@nvidia.com>
References: <20231113083544.1685919-1-gal@nvidia.com>
 <20231113230902.7f342501@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20231113230902.7f342501@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0145.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::13) To SJ1PR12MB6289.namprd12.prod.outlook.com
 (2603:10b6:a03:458::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6289:EE_|PH7PR12MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: 945e1603-d5ca-453d-5360-08dbe4e301e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2PMfbUzt17IQ1jDY+GvI5yxataWzoKud44XofyxJHwtDfoboTl11p0grQAqBhIcyJAP/gOLix/os3WGUS2CvQ5THEqzO9lPVQa9OLICewJrEQkyS/TBAvEO1ZPcj9p/2wSCqz1pjzf6ADwTkY2tmrIO7FSRyETIVUdzsslpZ9J6kIZAYyorbJ0AhM8N7eXzuvoVtFKLqiPEeT6tlEniL3xqyN7NNtZa45wnF+06pBbjXLM5b5UI2IJEpjtDZKhLGTC62G/Vz+KTrwAs5qE1ia4AZWnxRUWfNL2xTamuigjZGtZ+oVAV1MeusSxjykDha2DAj2vAXW87dq1hWHlcIVogff45aNPnInP5W82QqK/sM6red6cWAEFQqMJjClW38KnPfM0D0cRhp3G5KOtBRTdcyzdSamBxGOhZm91QDioMznpsAv489IMJIZr+FCgMfaKEmLXeOYkbKeOb4iGgKYgNMGNLYv3y/kClRueblnkFz4/h7cCgRmtE11B779DPOX3Bd4PxeESGA+DBW/2VqK/eXCSpHyyvHMQLTjx3cZIDAEdki+VqYwnOys2GdUD7Q+Ydoru83Tgmex3PC7NTnmJ4jUzLGX7L9yJMYxVhJqjoUjhV2ioFDStIgGN8B+nmA3T+pXe0Cf+2WnNZKIvdu6A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6289.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(346002)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(31686004)(478600001)(6486002)(2616005)(53546011)(6512007)(6666004)(6506007)(38100700002)(36756003)(31696002)(86362001)(5660300002)(54906003)(66946007)(66476007)(66556008)(26005)(4744005)(107886003)(8676002)(2906002)(8936002)(316002)(6916009)(41300700001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3J5a1ZhNGEwTUNTS0trYkRwcm5zeEFIekkzRi9Pbm9aRDhVMCt5d1ozdDVy?=
 =?utf-8?B?UG1VcDNjNkh6bW91a0ZIelU3VFJTU3dRdDJSWDBPVm13Y252cjF0STBLZmZG?=
 =?utf-8?B?b3pSL05zZDhDdDZuWEE5YUtad082QWpCMVNqUWNTNE95eVRkM3Z6N1NhYm9x?=
 =?utf-8?B?aTdXcVN6aWRORjA1eWdGMXZ4SFUzTU1jbWhRTCthM0tCYVJJT0hrZnNIODd3?=
 =?utf-8?B?c2x1WS84QUwxeTh5UEVGVXNUWjN4aUZGRkRGV3B1c3o4V0FCWE9CV3gya29X?=
 =?utf-8?B?QzUrdVA0UFl5ZTdRQmJQenFoRnFZL1A2T3Q5eGFIZC9IM0gzTG90eUx4U0Fs?=
 =?utf-8?B?SlppQWxETHJUcjRaNFM5OW1JNmNZajB1ZDFNdExnUlQvWWNRTmptK0UwVDln?=
 =?utf-8?B?VXk3TW10OXpxMFlSZjRkUC9NN1RsUSttNG9nTWVPeFp2Vmh4Zmk5VnZlRyt4?=
 =?utf-8?B?Tkxldk5FRWdPd3o3T01oZkJaa3VaWE8wbnlRUDNBWkFFbEF5ZmpkcDRxd2Q2?=
 =?utf-8?B?K3V2UmdDQVBBRGNySno2VHFYSTJzMFpWWVB0dHVNOHM1dVFob3RtRVhBWUlL?=
 =?utf-8?B?TjlVVU8zN0JuRkNvdjBZUHcwQ21mWFIvUTEwWnF0Vm1panZoUFdNNmZIcWtN?=
 =?utf-8?B?QkxwMWZNc05KRnBLQ3RwQStZQXJDcjNiYmo2NFV5TDJ3WGtMalpYTHArVGxK?=
 =?utf-8?B?RU5HemxmMFpmOTRjZGlFRmFMVXN1WHdQUFZiSVpIQU5FVnhFVW84ZTBjNzBW?=
 =?utf-8?B?bXV0N0Y1aWwxeWdRR3pCbXNjNFJ2Ly9lNHpia0psZUt2OWltWFhoUFdZb3Na?=
 =?utf-8?B?SWZzczcxbmJxR085R3U5S3pWbFZpZ0NKMWJIaDFZZWovOFhBREFGc29pY0dM?=
 =?utf-8?B?aWhXTFp1aER6R054ajFGQzFQZ3AzYU94UWd5SkkxUWxGUlNwV3FPeVVwK3Ix?=
 =?utf-8?B?MnRpNklDWFRjYkZlV1NpZERNYnpaa1AxbnVrTEx4RlBaVDdQY1VlRUlZUHMw?=
 =?utf-8?B?UWo1SGJuSEt3eTRlWDEzdS9uQUFaWUE3eGpDMGsxWkZ6NE4vcWlZUDJEK0N6?=
 =?utf-8?B?QjJONHkwS2JNRkZaUzE3MXZRYVJWVUwwTmJJckhwYmQxcTU4ZHBmNGp5UjIv?=
 =?utf-8?B?SlFUbGJIRHdCbjc1Ungvckw2bTJuS3ZHQ01RY3BnUEkwenNKcHh2UVBETzFW?=
 =?utf-8?B?OGZsNUZYcGthU1VlV0toZlI2VDNKNCthUDk2UThwSmg2cjBnc09IejJyazdT?=
 =?utf-8?B?cjU4ZnNRZS9mSzcwWWFUL1VaMllHNG1ZcThDTDNLU0xhazFJTkNrNmp6Q3Vk?=
 =?utf-8?B?NTVadThWNXBVZUVtUk1XMFhNdWdJZDVZQ3JYRUZHTTdFL0RDeW1xZnJCVFl1?=
 =?utf-8?B?TEhBZXJWOCtnVkJaSnZDTFk1LzlmbjdzQTRpSCtwNElBQXZHdGJnb2I5VHdP?=
 =?utf-8?B?VHhpTGJhb0l0bXRHOUtuQUs4am1iU3JycDIyYjEwYlY1REVxMnlsR0h5eU1x?=
 =?utf-8?B?UGJML0c3QzYwVmg3bEJWWDVMMUZQSWgyakF3UVR0SWk5OGtvMzNTRS9pWDND?=
 =?utf-8?B?Y1JiOHQwZUpIS0R2dHhJK0Q0QTlOckh2bktpZ1dmRlFpcFVTdU81WWl4ZlE3?=
 =?utf-8?B?R2YyNE5JQjkyTFdwczdRdzRtZUJMcmZUK0dUdnNHRzRuenpEMWpCUkwzSVhI?=
 =?utf-8?B?T1MzUTM2WUpkK3NqbEhyRk9iWWJDUkdCZXhCV0dGeWNWcW9QdS8ydTA2R3hN?=
 =?utf-8?B?N1RHSzBYcDQ0ZnVCbjRNNVNrenlHWHNRSTMrM1YyMDFhaTVpeFV3em9iNVg5?=
 =?utf-8?B?OGJBRUVTa1NidG01eFZhOHBJWFkxS0FZcE93MnlZaENYWmh5YU1idldzT0ww?=
 =?utf-8?B?djd2cUYvWDEvR2MwYlhMNUxLdDcvQTJMYUt2UGM4YnJzWkg5dmREeDdxcWhz?=
 =?utf-8?B?REwxYXJNb1VOMkhIaTUxUVliTURxZVJ6UzA1RnFHVVYzT0hUTlZTVUM1QXli?=
 =?utf-8?B?TnVzeXArZFo4L0N0Z2hKTWk2NkRiMjhyMGczczN1V29CN1ZiYktpcy9zUjBG?=
 =?utf-8?B?M3BOSXJFbmVPUytEdWNaYmorMkZES0YyVTB2dDlKVUZoZUQvRCs0MjE0Wk04?=
 =?utf-8?Q?5I9JyZALx4sj7KxMyUvKebjCS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945e1603-d5ca-453d-5360-08dbe4e301e0
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6289.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 07:26:24.6067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Th/MJjsHlyOn2zzsDswyptm5MLALqYI42NCmor8e7kZbd4lTYt27+RP++dmAXE+i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6763

On 14/11/2023 6:09, Jakub Kicinski wrote:
> On Mon, 13 Nov 2023 10:35:44 +0200 Gal Pressman wrote:
>> Cited commit removed the strscpy() call and kept the snprintf() only.
>>
>> When allocating a netdev, 'res' and 'name' pointers are equal, but
>> according to POSIX, if copying takes place between objects that overlap
>> as a result of a call to sprintf() or snprintf(), the results are
>> undefined.
>>
>> Add back the strscpy() and use 'buf' as an intermediate buffer.
> 
> It may be worth mentioning that it is fairly common to put the format
> in dev->name before device is registered, IOW this condition takes
> place a lot?

I'll mention it.

> IIUC once we cross into 3-digit IDs we may crash?

Right, the bitmap and names get out of sync, it results in sysfs name
collision call traces.

> 
> With that and the right fixes tag:
> 
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> 
> Thanks!

Thanks Jakub!

