Return-Path: <netdev+bounces-56012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A68180D3C3
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07675B214F5
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919D24E1B8;
	Mon, 11 Dec 2023 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AW1lCSj/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA09692
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 09:29:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oj+02D+YAmt3liyJcNENnMRfpy1LGviZuxSoK6LvjD4mWD7IyzquygOnYAsgQXlqXmrySvTYWtbYw6eBn8yD1fK3hKiWMHIdWGo9VC5801lFIKEjfxGed09oNWLsw6gYhx9rxVe1hvQM73XVmib2MWhsc2yiIN9BxH+0PzvZ3zh3uNLgnJtQ0wZqezoXO9dTmwBCCVQAbWr/5kmqHXAZETX5dQmsQQBIRyc5vGi9GaCUmqyYACU/HYAxDmr/0xqW5rwDyeOXpgO1ciHYg5Wak8f5g0GKCAkWBBe5dNPYKxWqVZSHX2Kl0jQXrgVgrmmA4meNsDtATZ2L6pDt8xzNVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obsWSGwPsUAXNj/pZfd40ghX5hgu2k0LcpbONXWmxxY=;
 b=ShYwo8UA9V4I/8ho9tPQkJW7l3n3XXZgxgfw1XXe0u3kDFTws795cH+IR3xR4LVTbGIUI7A6GRXu8ZwR+rAv+VUHcOQz2CC3wcz5gyszQu5RqFyisu75u3K3PAnxwW4P+mkAtYGfq14Bult3U0e7NkgFIwoQp4X4iX+G9z094aB5pxxI7XoH20lxxhcTeqoROa9zitirvSBmaZdS1exKE8gtBFb8tRa004Ka/QcGB9cAghyNlC93TwhIKbqoRnLPyXkeLI729X85a0J5yaiLaGFZNtYQgtlnM9XFAaR+UZvZaQQIVUF4MLDQS6x5th6C3cGQtqy2qwwkKT9+fy8VzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obsWSGwPsUAXNj/pZfd40ghX5hgu2k0LcpbONXWmxxY=;
 b=AW1lCSj/g5ipSKhT3qbMzLrW9yZdrm6tLkSUWuNBRJFJ02sENCP6UX5yLAbZlUMLpFxsrmXOpDR3qZ3Lgh6wZrLN9CUlAEFaHXtHacn+fA9lwqz4F73edC/XiibjToNk3uUVKAoG/oMYo5jItF2d3atRRzFlXLtkvQuZvLawgcSzjWpI2nzueOQ4+agklYoNzjVQYVy0bGPeWIsOTZtFmipZQtZ0Ruyx1K7R6NqO7I8wlTRg75wKAtA0RRzQ+wXHtuzK6Wh9e6PyesrzMZ3lJWV2JhHg0W3uZ7D1koG0nHnHNBJvFptZ3N2eobSafEAz41CYoMstVPXGiS2QT0wW0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 17:29:17 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 17:29:17 +0000
Message-ID: <97e6efa4-8d70-98e1-f5af-1d34672c2e2b@nvidia.com>
Date: Mon, 11 Dec 2023 19:29:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v20 05/20] nvme-tcp: Add DDP offload control path
To: Aurelien Aptel <aaptel@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, hch@lst.de,
 kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net,
 kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, brauner@kernel.org
References: <20231122134833.20825-1-aaptel@nvidia.com>
 <20231122134833.20825-6-aaptel@nvidia.com>
 <debbb5ef-0e80-45e1-b9cc-1231a1c0f46a@grimberg.me>
 <253plzsis4h.fsf@nvidia.com>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <253plzsis4h.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0046.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::20) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CY8PR12MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: eceb2c16-cfc3-4a58-61b5-08dbfa6eb3d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aruSanjmdTLfdLijOnP5ypn6Xm/Pti25DKr4AG+n6Ojw15CFCYfynGz7OaVoAe3PCRkDkbqu2+ex2cwWTxvR+GfV8B64a1ZqQtSROEHDYgbOnlCWJx74IbtTHoko2xXOTjpT3uQQK8YGvP6CcO2IHTdieflCKxiCXqA0Ddp/86Zo4ecegpuyCNvGbVzhMYJc02+HS+LnQHHT0YsX4KO+aLarDX2GOg8t6e02r01FsQkAdGdYglZROzJEpI838naQ8eV2BdvhU5zE6UC6BHPkIIe8tEbBGJzIgZyv03y2n2NieKIbfvNjJkgZXW5QyAkBvjTK2w9tUCsYo7Bi55CClFnEVSxXWZSxaiBRhzrD+BXwX2tA9y3vyoTBVdY7M7wNPhYozIjIdLu2J60lK+GfYMtc3tjeBuJZfVkpcmdYlzU/vdZmAWwYqKhIG9+eruSZ1qO9RqtsUyAGeJ9+UKDrcjednVXXoEFdUXtyE5NyGLpf25MtYaZSvffUzAc8jNz5M60lu2SGVWPWkeSPyXKZibwlN20max0LhJdoxnvMqILEzBcMQqKZtDJBdIhN8JZoq71frIszkmV1l52Ph9Hu/4HCl6YOE76kEpuqGF0HcOFP/YNWdrI+n0aolXnhBqkVHcErGjMugxYnyEgxTWMYOgsbUAhsTTP6YUXiHTcWY9V161iTRj/Ga2W0Wng1M/KVwU3u8bY2ncDDw5iiMZg/BQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(2906002)(41300700001)(478600001)(31686004)(921008)(66556008)(66476007)(6486002)(66946007)(7416002)(966005)(110136005)(316002)(38100700002)(6666004)(86362001)(31696002)(8936002)(8676002)(4326008)(53546011)(6506007)(6512007)(36756003)(5660300002)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFFCMUh5RVdLL25teC9XZUZqOVRqZU9EYkpESVczdkZKMVBSdVhMRWNsVDFq?=
 =?utf-8?B?Qnpob1o1LzRDSytwUTgydFJNcGNNSGF5SXpZd2lwU0s1VHloVktPUGhOL0NZ?=
 =?utf-8?B?eUFUUG5mZWlxY3E4Wmxqa3BBbDUzUE93cmI0YkxjOCs1K3Q0RHNCUmg4b3RR?=
 =?utf-8?B?WUNLTlQvZ1N1QzdNOXEyY3JVck1EazRralA3aEt0eWQrOE8rSDczMDVCN0FU?=
 =?utf-8?B?TEd0ZDZvdGo2anJKTXhhQTQ1ZnhjTnQxUCtrVnZJRVlNTU5SS0llaElRRERw?=
 =?utf-8?B?c2RqM3Z4WmZnMjQyMUlOQk1EcmN4Yld2RzFqRnVhcjdlakNJd2dZSDBhdDRT?=
 =?utf-8?B?N2tXTjY2M2RmbFcyZDd5YVRmWlQ3Q01mbkV0bTZMWDd3SmpMd3dWQzFnYmhG?=
 =?utf-8?B?S2Rmeitmd0JsUWszVk1aSzBCaFhKWkVtUHl1eldPQWc4WmkvTGNtY2xVdVN6?=
 =?utf-8?B?WXpSVFpoZzFtVHFsWXM2Y2loRnlxUjh4SWt5Y0x5RDcrZ1kxSzRzL2J1Tm42?=
 =?utf-8?B?NU1idXpTSFhVWkxDekNIMENRd3hsMlhjN1VzSEFPNXR2ellnRUVCNXZrbzI3?=
 =?utf-8?B?WVAxd3NRSDJBTGpKNVVrUzhUTkNkcWQ0T1M0aHRKcVg3aTZHWXQxS3dWQk5P?=
 =?utf-8?B?TVpWeVdPS2Y1bTFxUGZvYkNSTWxBUmNQTUp5ZnpyTWc1Nm9mWUI5V3RMWnpa?=
 =?utf-8?B?TjhwUG1obDI2V0l3R1pHTWdLMFUrOTMxdktVR2VobmJXNkJaZS9yZ1V0WWNv?=
 =?utf-8?B?Und1bUQyK2QzNGJBRWpGdkhQWURvT3Q2Uzk2QitLZnB2UFYxbldWTnU2TGUr?=
 =?utf-8?B?eEhMZ01mODZLWXplSUE3RW9Haitubmx5K2x3RlpRVnYybkdhT2lIdXNrSkVN?=
 =?utf-8?B?Tm1Tc0lucVJpcE9LMDRRc3ZpZVpKckRNNmZuTkNjaU1tcDg1UWlKUWxGSzk3?=
 =?utf-8?B?Y2ZPaHhaR2x3aEJPaWhwcDB2cXlFTGpLcm13WWprYlhrR0Zncy9yRXJHZ3d2?=
 =?utf-8?B?bW15QWI0NGdmWG9pUU95RWNvdVdEbmFrTzJtRW5yR01mbzJmUXJ0cjlRL2tw?=
 =?utf-8?B?Z1dkU1hCeUEvelVaY0MxK2NYbE81dlczU2doa2dNWjQ5emRVT0FCUjhVMXdY?=
 =?utf-8?B?cEFaYUZtbW8zd2NoME1DNkhmR2pIYkZENFErQ0ZkNTdCcFJRZE9rYmhQZEJO?=
 =?utf-8?B?TjExbHhVOFlmNC9tTU9sQ2JVQmtpT3o1WFJVQU9JS0preSsxMUkzV1RoZGVK?=
 =?utf-8?B?YTFIWXFBMG5qOTZWeWhVaEFjZFBaQTBPUzU5VUphbU5UTlZHbUdiZW10c2xt?=
 =?utf-8?B?cytWdDE1QU9PaXJXaXFIVkFGZkY5eFJJcnRQYi9ldGxSTkZjK2Z4ZVlIL2Yz?=
 =?utf-8?B?YncvREQ3Q2xYZTVMYXd6b2hpbnh5NlJaWjVOSi9Da2F6MnZFUHBYRDZ3TUY1?=
 =?utf-8?B?WndIZXprYjNmRXNEU2xyR0Y0NjRQV283a1NlSWk0V1lhczljNkhrUy9hMnVl?=
 =?utf-8?B?VGhLK2VTZDlKQWVnUm5DYlRLdUhwTzRHLzJYb2hYZzdJTEJtMlJzdXQwRFll?=
 =?utf-8?B?Um1WQldJbDZEak9Paitmd1lab21EQ3ZBc21CalE0YkpRdGMvRUNLM3ZCa2d4?=
 =?utf-8?B?QVpoUk5EYllnQXJaenNiOEpWd0xsbVFsUEkyQUM2T1FuS2JqKzVvd1d5Nnds?=
 =?utf-8?B?TVk2MXA0L1U1TTlBa1JJbWdGQnBaN1VlZDBKeUsybW1qTGhGaWhJNUZSY2Rk?=
 =?utf-8?B?OUZsOUhsY1cvMWdOV2U1dlpDSncwcjR0Q2RhVlRpbFVWY0J4blY0OGEwZlNF?=
 =?utf-8?B?bldSZGZsaUZXRm5YaHZTZTlLQmlMckptajNlRGZjZ0dDN2diZytHZjltSnpn?=
 =?utf-8?B?TDZHRno4aEJOc2dQandxU1BxK2l1K3E1OEFRK0ZZaDZUOVZPZ09IcU9BbWZo?=
 =?utf-8?B?ckRBY1F6UXQ1ODJyZndVeGh4ekdUNGhrc3F0c20zajUwY1d6dDV5Q3FMSFkv?=
 =?utf-8?B?T2pacWxVWjNtM1hFMXg0S1VaMTlOdHJjdUh6Y1JHbXp4djU3aVRGa2VQWXMy?=
 =?utf-8?B?NDV0R3JFREhJYmpOVGtEdVo5aFljUGZTeTk1bnQvUnQrSkZlcVJaSGhOakRN?=
 =?utf-8?Q?/NY5etgFkAOvYopvcBH+/RtCo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eceb2c16-cfc3-4a58-61b5-08dbfa6eb3d1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 17:29:17.5673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 422fmtJDJoR9y+kJ35ZIjdV+0U+kNu8NobbvPzoKjlgGCRB6SIK9kmfV8uhOqLzIE0G79Rd3VoHRUemVaCJRuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7099

Hi Sagi,

On 29/11/2023 15:52, Aurelien Aptel wrote:
> Hi Sagi,
> 
> Sagi Grimberg <sagi@grimberg.me> writes:
>>> +     ok = ulp_ddp_query_limits(netdev, &ctrl->ddp_limits,
>>> +                               ULP_DDP_NVME, ULP_DDP_CAP_NVME_TCP,
>>> +                               ctrl->ctrl.opts->tls);
>>> +     if (!ok) {
>>
>> please use a normal name (ret).
> 
> Ok, we will rename to ret and make ulp_ddp_query_limits() return int 0
> on success to be consistent with the name.
> 
>> Plus, its strange that a query function receives a feature and returns
>> true/false based on this. The query should return the limits, and the
>> caller should look at the limits and see if it is appropriately
>> supported.
> 
> We are not sure how to proceed as this seems to conflict with what you
> suggested in v12 [1] about hiding the details of checking supports in
> the API. Limits just dictate some constants the nvme-layer should use
> once we know it is supported.
> 
> We can rename ulp_ddp_query_limits() to ulp_ddp_check_support(). This
> function checks the support of the specified offload capability and also
> returns the limitations of it.
> 
> Alternatively, we can split it in 2 API functions (check_support
> and query_limits).
> 
> Let us know what you prefer.
> 
> Thanks
> 
> 1: https://lkml.kernel.org/netdev/bc5cd2a7-efc4-e4df-cae5-5c527dd704a6@grimberg.me/

We would like to submit another version by the end of this week and 
hopefully progress with this series.
To address your comment, I was thinking about something like:

+	if (!ulp_ddp_is_cap_active(netdev, ULP_DDP_CAP_NVME_TCP))
+		goto err;
+
+	ret = ulp_ddp_get_limits(netdev, &ctrl->ddp_limits, ULP_DDP_NVME);
+	if (ret)
+		goto err;
+
+	if (ctrl->ctrl.opts->tls && !ctrl->ddp_limits.tls)
+		goto err;

I would like to remind you that the community didn't want to add ulp_ddp 
caps and limits context to the netdev structure (as we have for example 
in the block layer q) and preferred the design of ops/cbs.

