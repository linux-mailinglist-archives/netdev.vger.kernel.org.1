Return-Path: <netdev+bounces-28453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3EE77F7BA
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 15:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285C3281555
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 13:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57D71427A;
	Thu, 17 Aug 2023 13:29:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3E814269
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 13:29:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5030E3A96
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 06:29:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPAuLxYktN4+hUWYwzvRdG0FlVgt1IcIEl2mfwa8FZfO6lMVlNHZCIonK61Hp1LxUVYvAoylDEsRroTmwio0NkrUyV8CGnMNfnIJEKq1/o7ZSxbAYPnYd3gM1k5eW4gaNK78XehsoFLIlFZKyBZAGzSrA1XEMZWAoL9jvYVUoSu+8fhe2o+1OlJFYFiNFzyavvLug3mLoc5VTGaRN414er5MArW3BjrfT7t342EMAhrUXf/nL1Tp5CRAceKCS1NNAL6ft4UJlAox/51x7veMQdW3iozqEMbR2RXgN+FkbdyRnUYoONKycdtvlHcbiqrhjd7RxkXEBiOfVNAsH8CtrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b8jTgbyI1rLvLsXH/Qi6eKOHblSHqFuDJ3oQxjj+9I=;
 b=mB9+slvusHKZ1gM5jasUNyJOYEpxKBBGIuT/6eHsSKn6s2lnt0MyJJM7Qcd47Jh/VcDERgs9Ni0t5aMBsywi5FsRLPDU7GPSPChESs/94anpkf2ObNMMEp1RQaCWPw1j+mbMsy7hUpF4j3jWEJfWiheQkLo8rSkpGyYkEXOhMzxLzIVl2qlW9QQdEb2i+LCiQyV124omASMlCS+Kk/LPtApkdZGpEyuSvqWQRxrnyVv68iReIio0S2DjHxIrlj/Gl/dwykDjD1bhmZ63zUlADXGq/YcqyNCZdRx53OhRbqFkN02f7bwRyS3US1j6GEEKs3aOzsLKFSHIk8TH5vyYwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b8jTgbyI1rLvLsXH/Qi6eKOHblSHqFuDJ3oQxjj+9I=;
 b=X2tZ9XOmqaSWm1V5J4aUr1oV2m1adsXIvOTFpKC/VWrqUOw93mxK3cCDXR7vQRfo4TyxQXwGsGdqg5f/ZOD5nwhxNclciFyfjA5sq8snH80fW44VgRxhxB45/29PTR19VsAYvajOfM/zwBYxm65D1VwJIouv6vtb8sZcnZwZMLZiJHaHb1T7Xyk8LspeD5D3RM2ktbX+E/BxeT/5WBtPHutmiUFBKWPxy0jasuEK/CWA7eEp2rdqRzw5Fq+BcNLUbk9fzSuPgbKnwg4P0OS+NVvrrRC/Lzn5LgfKxTuUl0z5OF2zzbsEEfsSZ3vGUlmsyO9awgsPsc5VTFFkhT/p3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DS0PR12MB9040.namprd12.prod.outlook.com (2603:10b6:8:f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Thu, 17 Aug
 2023 13:28:09 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 13:28:09 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v12 08/26] nvme-tcp: Add DDP data-path
In-Reply-To: <1a28b970-1954-a482-5906-c6ee96b248f0@grimberg.me>
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-9-aaptel@nvidia.com>
 <1d5adbe9-dcab-5eae-fff3-631b91c2da94@grimberg.me>
 <2535y5hwqkg.fsf@nvidia.com>
 <1a28b970-1954-a482-5906-c6ee96b248f0@grimberg.me>
Date: Thu, 17 Aug 2023 16:28:02 +0300
Message-ID: <253h6oxvlwd.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0071.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::48) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DS0PR12MB9040:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a1d80e2-940e-4998-459e-08db9f25cc09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8vc1rNEIdJMDXrZFOPUEHn+WJZgd9kcEd7y8uBaC//PGkWKaQrdhwR/+9fxUlQGc5G8AljI/gVllcE3ISKSOogxcIo35lM6cGyd84IrNj3SiQdxr5G/HvDowHF/nCt2lfbRfewvjZTcg8wTWVrV8b0xhQXNrTUy8tRh+XR3QK9yLVNBIUn8EFgitaC3WPvTODfUnVSOehmwC5i1UsibUdyDukU3J6LQf5Nq9B1oicOqxFQf3fD3EfOeOHOMTZEteOxOFaefgF2Gutuey4DV1pCe2I0su7V7R5/qhaT8h8NezsUtLgjQxa+U2u4+qdMKpiz6Iy4KRux18UwoDTVnIbq3CMSX2C0lOLu7myzS3uEuj1oED/Mz2JbOQBIoovQAKSwrfnSU2XPB6jp3HYQctHWebVbB1C9HGmlOzGPRe8L1zW2mETZLy4kGMD7U5w+B43EV01XMSvBs1gplT7GIG0QiOfsvjtXv3n0PVMC4gInsVehNjAVkAoSzXudLZ+t8ZjLQRY+A5hpESBjLRKMKmts1PTBho1DxFhi1nHqrM5fKuuC+DuQtruAdWzITE5w4/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199024)(1800799009)(186009)(36756003)(86362001)(8936002)(26005)(4326008)(5660300002)(8676002)(2906002)(41300700001)(6486002)(6666004)(6506007)(107886003)(2616005)(6512007)(83380400001)(478600001)(316002)(66946007)(66556008)(66476007)(7416002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ag919E4kBXKENwHl8+hYQSYYaOzYLsmSqmN9jzWWMAmjbGw470xRKs4fK3o1?=
 =?us-ascii?Q?VPGwU6UG08+RpgXoYgxt2SMg+khCMMvBobbitiOAFy/oyG4UPHynv1xW2tbg?=
 =?us-ascii?Q?ckTbhl8yAQPR2K1L3NYIAIAtdEZ1F/5sr7/MVVLmVRYTjoGX4KfymVLkWfD1?=
 =?us-ascii?Q?ILsEjNdHFerM2HNmgxI2rmjeAgZYFfllj1fDPv4lBp4WWXIDtN6DBHtu8yyS?=
 =?us-ascii?Q?B1x8/2LxZMBza1s4rb6R37KVDe24jbtD4RJWb3cqvgm7384JbIXkeiTihuFD?=
 =?us-ascii?Q?64Xk6LBOPtH9wUsC0MZBXKp5auF86uF2UYWotRVEuJIOvecaU943sMfuQbHj?=
 =?us-ascii?Q?OCgLw91ArmuLNdv1OdgdcZFg6ajp+aY9DZLk3WM5nCzUw25OMtfit5hBJ1rD?=
 =?us-ascii?Q?2Jy42w03rRDmBQeW7POpRVUreHUtKGWnbU2GjAEWx//LSBisbrlQ+1IbZsfY?=
 =?us-ascii?Q?SEfiIHgV3WeDAlKZg70sjUU9kRUdxJ7fw79BPrMgo+yLQFeCOa1iFic+90El?=
 =?us-ascii?Q?HwlVi46QF8DTwLb9Edrm08FW1FTr/VQ2vCnXn0cp9Z323lPN8o3NvpPfB5/u?=
 =?us-ascii?Q?Gbi8VUeaj7g48voM9l83Osd+PwX4fr9s/4q+zNx3z0IOIwawMoSzp5LDsdO6?=
 =?us-ascii?Q?k1CCqOAdeMZZpP+tDpNcAhFHMjzLF3bY7JtsiotBNEYoRdX38HF8wVnVUoTv?=
 =?us-ascii?Q?I2Fq2W2CDh9gpv9aGGv6gaSjH71Xvx+M34uwIYKCelHJYFrqTH0m7Vwv3mGA?=
 =?us-ascii?Q?P/7/b75QzFOC7MFWCXXnxM5+nNPxdnStljbtvjAJH80hj9ecwVVUauLTncsw?=
 =?us-ascii?Q?C5JTsYywy1A9UDdRE7cqsb35dGRlPVIVYRBVpvmEhdL6aHQdMsG+D3qy0Myp?=
 =?us-ascii?Q?XHTGkSS5KvzHbqwwA4IR44ojjTx7fxlIWyU4PvLtgirIasNxWtSn4U/Li3JX?=
 =?us-ascii?Q?O3Hy2fUJuXACZXraj3rGejWod1vJPLztEkJUmHbGUwSHj+GSSw14yVaFyhPu?=
 =?us-ascii?Q?aBTx6NRPPtWozdSWKM52fKUrMxk/uxxrnLvBauPHWFHTZP9pFGHpxyJI3+5P?=
 =?us-ascii?Q?UVwiOIWIZy7wYxn3O/KbNXCWqkHhiO991n/VyMRybZdCL/YooMxyY18swvIq?=
 =?us-ascii?Q?yi8W+umZDBN9ShDyfOpASeA03+ln0mbo4CG+a5qPd7LYbKaqi32efHn3vKsj?=
 =?us-ascii?Q?1rrdFYKw0ZB/NAlhcv+WLhTP7aqOqBXA+7pDbjs9SaPXArVuTFAmyUVCjARZ?=
 =?us-ascii?Q?Fe+Ygh7TL+6UZO5Hcwvmnp9eNzimgtMdnJjx7KkmbmhHft4/ye6NL+KfJ63p?=
 =?us-ascii?Q?/oBFTn+26mdltbl3JPv9lgpXCshHXOIWdCWRm36HHIcwm8f95MSCW5L9rNLH?=
 =?us-ascii?Q?GLpqDf7vKIzqPAHT+LVdXVmA62bz1tgegl3IOt4NtDP/CY7S4pTMxims20Kd?=
 =?us-ascii?Q?Ob3AOzEDVuCefGPGD57e58WCyXPz4tMHbcq3yrpC8Y4r/G9xVLDX+i6Q0enr?=
 =?us-ascii?Q?sGO5V6uj3WmG9AX4stm6uH9wedCEmEF3cOTgfP3RV6SzyiHQE/gnM9r7qrlA?=
 =?us-ascii?Q?eDxYoSB+SIz3L1ZRaSg0uG1PpNNCEdWA+KSLMFsr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1d80e2-940e-4998-459e-08db9f25cc09
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 13:28:09.0173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHPKV4eJJrfG+tku9VfiiXrF5ED8V3u1d6sGgNaaHzI5yA8y52OaRkX85WAAd9+AbRDavQqHcszTs9SE9YC2PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9040
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sagi Grimberg <sagi@grimberg.me> writes:
>>>> @@ -1308,6 +1407,15 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>>>>        else
>>>>                msg.msg_flags |= MSG_EOR;
>>>>
>>>> +     if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags)) {
>>>> +             ret = nvme_tcp_setup_ddp(queue, pdu->cmd.common.command_id,
>>>> +                                      blk_mq_rq_from_pdu(req));
>>>> +             WARN_ONCE(ret, "ddp setup failed (queue 0x%x, cid 0x%x, ret=%d)",
>>>> +                       nvme_tcp_queue_id(queue),
>>>> +                       pdu->cmd.common.command_id,
>>>> +                       ret);
>>>> +     }
>>>
>>> Any reason why this is done here when sending the command pdu and not
>>> in setup time?
>>
>> We wish to interact with the HW from the same CPU per queue, hence we
>> are calling setup_ddp() after queue->io_cpu == raw_smp_processor_id()
>> was checked in nvme_tcp_queue_request().
>
> That is very fragile. You cannot depend on this micro-optimization being
> in the code. Is this related to a hidden steering rule you are adding
> to the hw?

We are using a steering rule in order to redirect packets into the
offload engine. This rule also helps with aligning the nvme-tcp
connection with a specific core.

> Which reminds me, in the control patch, you are passing io_cpu, this is
> also a dependency that should be avoided, you should use the same
> mechanism as arfs to learn where the socket is being reaped.

We can use queue->sock->sk->sk_incoming_cpu instead of queue->io_cpu as
it is used in the nvme-tcp target.

