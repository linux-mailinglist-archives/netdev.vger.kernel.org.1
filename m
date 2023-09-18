Return-Path: <netdev+bounces-34659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3C57A5207
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9025A281509
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 18:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9420F26E02;
	Mon, 18 Sep 2023 18:26:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059EA1F19C
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 18:26:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEE8F7
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 11:26:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gECuaMk+1kzIw/pot8Ctkd6ev4PLuQYK14MmLldVKbtwEVT2XvfJa8h9WGwW1YBrZjqdOBtETcxcJbgpxu/8vb0QroyzIQXcDhRgIPutuR6BaIlP1L/4QOOCX8whNyTEF/HRHS4kI8c6lyUvRz3CyUdRvxt1R4CfR6cO55djTIzUyYCPm42Rgf+ondU0v9qMPFfiNCrfLJucR8uuD3qM5QMDTBu4lSlF0GYmHxBXaZpCnYWedNzTcbt3mv9b90WL2z3Lsbbj926JXy5GUjwjMthzmR18+eKgsl6eztU9PyIfBO8ZEpnHe+tM1Yr7C+kU3JhXFDUWr2lB9MBqZ5FEMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2Zknf/DzMaAhfneK2ttFgbttkMEma38EQjD8Gqapig=;
 b=Or29/yEHrlakkiHb25wzUgVGMkn2WB3uOlFeMaxITCrE2+R2hMJJems0k3aEHmgYXNF+Rj+dFS+RpVFG+rasDZhwhdNP3mp6TTdADp2ZuWloohInMFyrrEC5JYRJ71/b/L4KvQyC2+ZMDOR9Z9wcSxcS89/MYkDbkUiE2evUVgdbwuJ/7IyvS8CRytc1N753zn+UttEA7RhlOq5SzcRiFj7a3PQQJCSb6wndTXpC3SNfQl632BsRkygsBQs2TPUc+y4Vr74qRq9CdHMO0Ruw0qmdEo8y/vSpNdCMmyIkTSCPqCPr3JaTG+dejYdvumK4kJq85m2TlJo0+ZaOIeKbxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2Zknf/DzMaAhfneK2ttFgbttkMEma38EQjD8Gqapig=;
 b=apHZ3BqelMTjaPsJwFj9QNNbTb3CxWYXmdyRpr1hOwOUp7xhGZb3G6Zzwymou7GUwh+Lz3wm0hMxX9a67R38utFBRVQL56ZdatslE49vSk9DNyYKDrYBwF4Pjatx/a0yzu1OY+14lcWg5CIS519UB9A1I8xkwHkPLQj3DUmgmmWvBVoqFHHyahJvhKa4Rd06bc24x92J5ycDy2RvYHm4PCM4Yt8YkCvk1ToY7hb8cdZCbeuRuvx+uZMeQlPXPbik6qL/0Gobis4u6/TyxKalkWLhV8DQxH+EFWfn+V4M+dwIsF81a9/5jmyvbqrpSneCnTh/rmoP76/z4i+SJrbiwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA1PR12MB6846.namprd12.prod.outlook.com (2603:10b6:806:25d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 18:26:12 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1%4]) with mapi id 15.20.6792.021; Mon, 18 Sep 2023
 18:26:12 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v15 06/20] nvme-tcp: Add DDP data-path
In-Reply-To: <ef66595c-95cd-94c4-7f51-d3d7683a188a@grimberg.me>
References: <20230912095949.5474-1-aaptel@nvidia.com>
 <20230912095949.5474-7-aaptel@nvidia.com>
 <ef66595c-95cd-94c4-7f51-d3d7683a188a@grimberg.me>
Date: Mon, 18 Sep 2023 21:26:06 +0300
Message-ID: <2537congwxt.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0236.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::8) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SA1PR12MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 017be0dd-b41a-4c4a-4cd3-08dbb874bcbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FMQEV6KcyYd+1PEjeMurrRzez0VTUQePCFICkJP5Ib2+wK5GiYimV48ktcAvdjQHDhNP5xz55uZCAymhLnWAvZLiw9UQtvgItzEwfXdG6s3MimhkSZzLcraLOtHAOm+b7U5E8QwrWbDJQonMRNUm3r4rztWapdyqiqJzgVxmpHih1wzV3RGEM+tag2EFfB2SbRlKSeHjd5mXdNASoQmifCBWJdE9NIeeDZWuF3LGhP8zgOJR4b677kHDITh3CEabkPIgTNW3U7AUZ6YVZscbm1WnZClWzvnXQn9bxW2A8KhO4HQeXmAZUP7V0eqe+MvOt3ent5xcHW1PYj9hPMessEatcborm7JHve1mTWfUHiy5pjh/b9G+z2mpqOCm05gzEbZ5T3eYLgT7fEGtWiaXpfLNjplXJO8zMVWacUTnXCHkDveysBxv+glp7IR12yXPx6cbARs7WAp5JJmCKL4FivEonNdR2DD6WHM21DXTVoCT+KVphtN8tnK8izSaLKYkfBTANMvqDmP6j79OGbMa3JWIwQIRobtm7Qwr8T3r4qpQuS1bb+njOECbtU+GHC8Prc4LFsVZ5EKMevAHr5TvB7fgqQJLFO73ohVbzw5CLGg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199024)(1800799009)(186009)(36756003)(86362001)(38100700002)(478600001)(5660300002)(66946007)(66476007)(66556008)(6666004)(2906002)(8676002)(8936002)(4326008)(966005)(6486002)(6512007)(83380400001)(6506007)(7416002)(4744005)(316002)(41300700001)(26005)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?44BvMKIlam9cHM1LPzSYDeLIbb5OcK4gMo9KH49YjGCqEr1RHZU4ZOwEcqtp?=
 =?us-ascii?Q?+km1xwJRhMRxE3MYmawzfXpKqMrSEvvbC0R2m3y7L483drinmrLrjK/khIwY?=
 =?us-ascii?Q?kAl5Pl+jNReES4NSeUn7IBbaVtBhMLs3J2PjgC319o/fRPDl+petomlQjBlb?=
 =?us-ascii?Q?s4Qx71mR1VKY2wjE2I4Yk83zyYBdnKRjn896n7IHkjS4PfETj9ISV3wzcyLo?=
 =?us-ascii?Q?r8Uvu8lUwf48GBTTox47rw5qkfkyHL02TbzEi6cgNXxb+sB12FoKymTW75wB?=
 =?us-ascii?Q?m9mrBjw7R2laNIPYGiN0FW6hPjCzybU5fACLYcaDX2AleAm+bOidGz5SH2uN?=
 =?us-ascii?Q?iyDybuokwwHMRT8KANsLhsHguNu7/I0k5r8dI8AGuPbTzC+F4LKTnpu7nl61?=
 =?us-ascii?Q?s6cLwwtwQY2ggs8qt36KPNGcZ5xrDS+dCpMbhioRtlBejyR9qUtg86G+2Neb?=
 =?us-ascii?Q?MRIWuHvK4ecMee61GSAIbHi1f49PIviaO8mpRu8L0CBz1KHyU7Ba/yvHqIlF?=
 =?us-ascii?Q?QwsDJ0vZzjnOQFgF3T9qSPT8q3YLSI8Dqqf3Mk6Qn6cLmMHi8TNl9FjA0MdK?=
 =?us-ascii?Q?HKYcRlw7eKym6c/uLSSb5kknrexdOs5crUm2zV5f3vhICjLM+C7Hl8jclmVG?=
 =?us-ascii?Q?gmk/RkznjgIWWDG0no3FMW2AbOCjQ3OMD1Abvgs52yCIPnPy9nS56HPyA4kb?=
 =?us-ascii?Q?AfjnmA6uA0KFWyjjwYUCZ7sjC7DUxOmUWjjQk8WAyudy6CA+JyMRciWylRLf?=
 =?us-ascii?Q?zswz8sM+kiWhiEaPXjg+IcWqxupfNk/2aD4/YN2GzQ7GAESuMWbqGI67/nwz?=
 =?us-ascii?Q?2avr1Frj4PJGVU9GIL9ENhJtoZzu6P7cQSyiRB5GZG4k/8jUvRCg3pP/9a5d?=
 =?us-ascii?Q?s6lP9ndM7c1ksrcgWv855QLM895FIGxYIPki4IbG11wyFDSq7bTCfRL87wyj?=
 =?us-ascii?Q?S293uYdaE5tpcKWrpopL8Kn4iq6eUBTDwXDA9aQfS2fp4R/GH9ojVqik/F7s?=
 =?us-ascii?Q?VgEHlSyGNsNBFFBInkz5igXnlpTzm6HERKStVYafUpfpSMs9GiunbECfCzUu?=
 =?us-ascii?Q?gOzOSeyhVvYeG1wMR8aVBILmjo7xN2rt1kh5bVNKNKqQsF23KdJws0YyOxRB?=
 =?us-ascii?Q?Ggqy7fEkeEzmIy2MlUssfr8jh1H50Scx1abelis5oL2ITKr+//fonE68QJdW?=
 =?us-ascii?Q?W1SlbHMdB3VlcbAjwSsE0NiddWEwVRzMtJlallv1jRIWsqtqYnPGzlfeveYN?=
 =?us-ascii?Q?RGDMvXLwhfviJ9tkvwr5j+dPFTkCS6N5Bmf2wmD9lHPKToGi1O2RXjgZB51Z?=
 =?us-ascii?Q?odmMCZhl7qhgr0L1k+rrrg+gzGhMVxudiGMN/Is9a9X3Rsuoo2IQr5E7mh1u?=
 =?us-ascii?Q?OcUC5O7WvQ9jz5DIGAOTZ7ck7tSCPylpDLqfCC+VlLykCfjsFL6A3tG9bgkf?=
 =?us-ascii?Q?GZYqTAB8EzwHP9mGGFmja7XTK69Uua8nXtfIU3CkCmbEvn86k0SGzcvhIvef?=
 =?us-ascii?Q?C26H/PiwXPmHSNy/LdvJfZFNNmzCsGB9dj/r8cUN7LS+f62tVmF9vLy9z2lY?=
 =?us-ascii?Q?g22XR2P6LBCxHD47dySKSUMYDPEGAsmg0cI1mdDx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017be0dd-b41a-4c4a-4cd3-08dbb874bcbe
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 18:26:12.6983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOTT9GFVoDE1WyrA9lYHfP6piFNaSokKNIB/MsXVlIxIs+nr+Uk6GIZoyhCFK5mhvrzZlQH/1+Gd4cesCrwS/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6846
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sagi Grimberg <sagi@grimberg.me> writes:
>> @@ -1235,6 +1330,9 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>>       else
>>               msg.msg_flags |= MSG_EOR;
>>
>> +     if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
>> +             nvme_tcp_setup_ddp(queue, blk_mq_rq_from_pdu(req));
>
> Didn't we agree that setup_ddp should move to setup time and
> not send time?

We believe we haven't reached a conclusion last time [1].

Moving the setup_ddp() call earlier at setup time is less efficient (up
to ~15% less IOPS) when it does the work on a different CPU.

1: https://lore.kernel.org/all/253h6oxvlwd.fsf@nvidia.com/

