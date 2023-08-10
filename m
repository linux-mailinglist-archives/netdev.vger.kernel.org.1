Return-Path: <netdev+bounces-26398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C9C777B3E
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859061C215F7
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 14:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF121FB49;
	Thu, 10 Aug 2023 14:49:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2089C1E1A2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 14:49:07 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8B6211C
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 07:49:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBJQNDsWc5gowCzFvUbDMv2gdBjBnmtjR/UkTdkMBRMXpndK6KYyw/uPOTsJqYS5skxttfYeRx4q1eMwJdru+MuJv7jhLFSQ81vj38jKshO4yEZ89ICq29YqOrJFiQCWFD1rPXGApHTBlA/o48hITI96LNhsUeUBo1y0IuGd5yomtkDqqF9QkEQHw1V+wfa5VQ4iq+egPfODb13iLBem+iB2VkFonzVv2vf7RhaV8DPUKJY5ToUpflaf32j+MVg+ge7e922ce41QehUSeQqie/NbVnW6o6xfyyH+KlJP1JRNsTkRv1Wg/qewsz1KQKaAQyX6Jrw+uCrSCe5QtyYzkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2w6lTE9/GFWoKjh0sw3ntrUVHfC1m3pvIc+5NZObf4=;
 b=LcjgAnLwp3Ot3OCplVWkLfz7b8rgs3FxMD+fOGh2H5IByGwPhH+YyfEmh8Y9iPd6QexBjfCDB3yD1LmYS95o830vuR3dbJIOhR+uuu6vhwuo9kqVptgoSyVTTMc+D3FaYWUhM7bb6kGka0AmaIyPrrvsJM4lypM6nwOjKZejjo1pA+LEHWi9FKEj46InrjQ3intAUlcZv6fa3tJIcobddgBzDg6h00BFSMYYnLpoE7BMcCz6xC/jr6ewgceDoFfq4oKCPS6EYTddM5igk7m8GhoK8i0riSvIn4n2fa2KAbVdlkPjbxkkMUwBP1ZM6cP7Tyk7Ic9NZ1hnYGRMDWe1fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2w6lTE9/GFWoKjh0sw3ntrUVHfC1m3pvIc+5NZObf4=;
 b=J7azHTngrjIBt+JkvNMR6rBMVQuzxPu7ZG411ip33LbKFjR4t1O/B2jDH1jq0vyZNtMPSahEpbPKShl05FB7Q7QGN61zw9MWjD7ttxJ6h4AL3mni/YfLmHtuzuq/ozXbYQsI6YtCugp1R72IgKXXHspe6g4ZuTKqDPDMBplwlcOxqSVW8kIP6DFzsaBZ+y7awnCvKLj8HcXE99NzV2r6lGrd1DCJV17d8wak4PcNvfzOsxm4MkNml1ijZJF2SYfGyzea5BYE3TpCIMabPRQM18xHl7kVPB911BibFA4jAy229To3R7IXf1lx7aHcyi7918u2anzC6lidO7RWyFJvBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 14:49:04 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 14:49:04 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Yoray Zack <yorayz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v12 09/26] nvme-tcp: RX DDGST offload
In-Reply-To: <2a75b296-edff-3151-7c6e-22209f09a100@grimberg.me>
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-10-aaptel@nvidia.com>
 <2a75b296-edff-3151-7c6e-22209f09a100@grimberg.me>
Date: Thu, 10 Aug 2023 17:48:58 +0300
Message-ID: <253msyzvtph.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: VI1P191CA0005.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::12) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DS7PR12MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d531bc8-948f-4fb6-ea6c-08db99b0f0ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4kTWdRVeM9H+yFf7P17mWOVPKQJg+kWY+5j/Wq8ut3ff4ehLG1IKZcWW2r1gk0O6agZR9pySGslW86zEQLnBOCsdEUw+p5Z+MjyEcvZ+VgRpz9c/9atmRH1SQGfecj+LILiWYytUSh1DV7qkw159Y93iXCDRS00zOq4r6nVSUkoUvPUfsQmulYn9fhoGqGnyWtiInGyi7jFQcUFAQS74HVGgZqxgtVOuOV04cXagvaCElYy6t7+88smBfdNw7knUZ0OG6cdwZmTkdNI2C5xOgsE9v6mCuTGzv6c2Uj/hTJP7HB6bum2WU3eCOhXPshnQibjONdHegCocqc0pVpzGRuMuDPjxopa9PBaWoUXskuDlcACNVf/kvTyWylOa2SmZ2+SsrEu00HiSZCdxltFyfIsBm9Cq1sgsgZ+v4bO/3ldyVN1lwIewT1dHtYJODNhSRbBsp8+pXlHd9ycB8CIuW25ywSA3t/bP0WC0NVt7LySuIjIBgQG6Mp6ugI34tSzEOCmdTM2DxxPP7k6+2ysSOUvOqw8dNc/1WEFgFSMW1mimV22FG0dNpLbPtvDgbiMs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(396003)(136003)(346002)(186006)(1800799006)(451199021)(83380400001)(26005)(4326008)(66476007)(86362001)(66556008)(316002)(41300700001)(6506007)(66946007)(6512007)(38100700002)(6486002)(2906002)(6666004)(107886003)(36756003)(5660300002)(8936002)(8676002)(478600001)(7416002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/TntPU1zNjZwHjnA48l9d9a5HH5scd+Ybd1AzSG2X7N/TtJR1SqLQVRytYQ5?=
 =?us-ascii?Q?lcvZY++SFY+cJDFBRhP+4c9T3yr0y/PBlVVu9IGm6INXGTBP3q7dK3JGhJ5N?=
 =?us-ascii?Q?FoClplHDyKQvV2QAZYB6Byw4WyQ7rvcnTqsJW8cIwMS9K6BcKvZRwpr859Qm?=
 =?us-ascii?Q?SCYr5xvf6f+MRPzG9zCtxL0XP8GNVqYvZF5G+yMDLEEcQbhPukCP4qSY5kaQ?=
 =?us-ascii?Q?T0AqACSafzZvxBYQ5qXVsDjh31EbOPXqVEi+9UXi+1ua7fzKUeuA3/Q2Io1g?=
 =?us-ascii?Q?VLqtYHjt30/UGlj32KE/0XYo4Gqes9OHKk+NO9NHsyrKGJWNnRm8F29caZcu?=
 =?us-ascii?Q?tkvkgYwRCMx1dfNYZZZR9s8ZyUS03KcycehWOXKjH4ubwtOi664Ujr0iAhmX?=
 =?us-ascii?Q?yR/jBFHlFKHLTk6ZGbTNXkag2NmqtpnvnISO4eoQqxwRtrHnqF+OaoNbaHFG?=
 =?us-ascii?Q?92fUQxYcwyBTzrpg12FSSwOvb2hP8eSDzggNEQUtMefQOsijcFgs1y6k4gfI?=
 =?us-ascii?Q?tWwDPs727z6Kq3spUIi+7IG9cztaYo2F/ioL3FrMdd2HsAv230PzrHJvQirl?=
 =?us-ascii?Q?QSKCGtyFNNrFyRuIs4za0zCYLwtore4wP+5/1doYFKOVFOkHco1zt8nxZG9D?=
 =?us-ascii?Q?sShoIYZ95OJh2kH9NJj3uq2On5l0BiwzutfdVkj7IYfI3QQvCy5tENZleTV9?=
 =?us-ascii?Q?SOU1nhO+Lo7xCN6vzp10JVgKq6LH9z22FP06oa/ixQCIyWocGWyZoFOQw23H?=
 =?us-ascii?Q?E3T7qyX0VYWuxseAr3PGhqEWjsw1JmIBShAeVMD/eNkZvQeAAynthxGX2wMx?=
 =?us-ascii?Q?bCINCDe06OIcz16CLkwgr1nB5seM7sVr4nt5lEnN/tEjI6D+ePpxyg5AuL1V?=
 =?us-ascii?Q?9ObrfWzrknorlMGlfw6QmQfNp+NCOPllUJTkILtFYAnVN07ATJrBZlUCIVN8?=
 =?us-ascii?Q?/QGLaPETHiJOBH+9D87VGjeAB+tK0+5SWb1pIHmXHM6YERKtksRsiia9b2gA?=
 =?us-ascii?Q?OeuCuhQLPvQQVznxAFs7cYsiNoOtjpVGMwQyibdbYxpFIh4Oi2P13tUrNb1M?=
 =?us-ascii?Q?08MWfTmfgXrW39ENrqyP7OROrn8RlloQ5LpmFXjA8t6uw0vc+IVuHCBAJJ0n?=
 =?us-ascii?Q?Q49Ea7T1t7hyNfQc1QkxOT2F9qvROKwWGfo9zSRw/eoFcCrN404hearxYalL?=
 =?us-ascii?Q?tPXDhl5frRyyV0VS0m8AGjdgrGS2ZDMn3DyCAe5cmo0u509Wdi4+6QKHZndL?=
 =?us-ascii?Q?+fmJE5g4n4SpIYjTFhX0mqaOdkDXO5TQdTGKNcn45smuuTqWCi6ZcQPeVyH4?=
 =?us-ascii?Q?mtM3S1DcIHdtGldegqoKneXcyGbjGUNtEjWInQ5pa0YW5Hdc5P/W7irgdIfW?=
 =?us-ascii?Q?klwCSHyug3Uo5Tp5Ts9nd1e4L3MPBa8p0zQMjGKr2hg2QWhzOgB1BlsvGNfE?=
 =?us-ascii?Q?XVb7VIkqpgwVgJ32aw0gcCoJqMr9TLaxfEjd9VIkx/l7Bjcsvptj7XUAk9k2?=
 =?us-ascii?Q?y0tX2uufPabapJiKU1DL8JjqbmHrHnY4ARCgpWfT5k36ZdWLaUbGC5uszu5s?=
 =?us-ascii?Q?lxBgFVwUv/pIe03HVYY9DjhA3rASEfz5X24+5Mry?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d531bc8-948f-4fb6-ea6c-08db99b0f0ba
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 14:49:03.8133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnD1tUITzE96aVdqr8qDs7C7sC+hCiRFuXLae9EREavo7B7neVcVe5NyXsX/x3/EbhfeeutSjvEPZ+0RUNVG6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sagi Grimberg <sagi@grimberg.me> writes:
> grr.. wondering if this is something we want to support (crc without
> ddp).

We agree, we don't want to support it. We will remove it and check it
doesn't happen in is_netdev_offload_active().

>> +     req->ddp.sg_table.sgl = req->ddp.first_sgl;
> Why is this assignment needed? why not pass req->ddp.first_sgl ?

Correct, this assignment is not needed we will remove it.

>>   static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
>> @@ -1047,7 +1126,8 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>>       size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
>>       int ret;
>>
>> -     if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
>> +     if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags) ||
>> +         test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
>
> This now becomes two atomic bitops to check for each capability, where
> its more likely that neighther are on...
>
> Is this really racing with anything? maybe just check with bitwise AND?
> or a local variable (or struct member)
> I don't think that we should add any more overhead for the normal path
> than we already have.

Are you sure test_bit() is atomic? The underlying definitions seems
non-atomic (constant_test_bit or const_test_bit), are we missing
anything?

We were also following a similar implementation to NVME_TCP_Q_POLLING
which was using test_bit(). Should we move to a regular bool flag like
queue->data_digest?

>> +     if (queue->data_digest &&
>> +         test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
>
> And a third atomic bitop..

See above

>> +                 !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
> and a 4'th atomic bitop...

See above

>> +     if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
>> +             nvme_tcp_ddp_ddgst_update(queue, skb);
>
> and a 5'th atomic bitop...

See above

>> +     if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags)) {
> and a 6'th... ok this is just spraying atomic bitops on the data
> path. Please find a better solution to this.

See above

Thanks

