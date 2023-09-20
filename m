Return-Path: <netdev+bounces-35157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182487A760E
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 10:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4891C20D73
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 08:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1B411184;
	Wed, 20 Sep 2023 08:39:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F836C8ED
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 08:39:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2884C8F
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 01:39:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyV7+1fR52kd0OTorwg3oRkTjsi8AaF0d9CTEN19Y9aeGrcttgbz/Igj/l0j6kBD3uD03ZcEEZVFR7OdsJqOIf25Ry+KUGmSTuEQXF24zi/VqTPzJlYsgEB/OiyUj4s3vjheRSzlv/h47WadEoGsLyIKAKX4ncFh1Av08MRm7P5D9ED0yCjY/4s4KnOJeZy/r3EgSBYrrX3X0N88lDlYtDrvVjxlnw3BpeOOA4x/fb8ywwJfcACs8Ncv8eX2JUQse7CTKcOqZHKVZV1IbbDGT4og8nhOjuOQyT5k4FQRGHZpGccQAc05T98Qr5PqAdfEreB+Tb7EFjznWSoJ33Zhxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gC70YUWYKHk8RHYZdMzXHsoMqFAfV0v82w2mv21KKm0=;
 b=hKoTj+bVxt9XUlufof1ht2Ys0TuVNWGLQRTynXnT/Z6/5SyCLs5l+xZpVkAjhcuWjPgYPxJqPEmouDiV3Qf24sgJ5FUS+yZAmtxC8Zsk92QdMxpZoafDO1w4Z3/ugq2q1IrBzXqKelEpzQodzZsn+Z1Z9PJHIVH9o4Kf3RuDODksv8nLm3RAOV+PwCDrxB23oJymPSMLHYpesqr1LvrlizKC50SIhvSAK+vP1hUXgB6Dq1Ha0AG0jHjkcGw0uujERWv5BBX2vbb58BC0iBfi7+XJnX12MKOlIKY06YKSAFDxYdjSpNItPjwymwqsb2P+N6j8SIycSsFVNJhoKfsSFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gC70YUWYKHk8RHYZdMzXHsoMqFAfV0v82w2mv21KKm0=;
 b=CcKD/ELFYzFBBfilDsiF3uCJaIKCMmcQX3s5JoodfoOgpKO827DjKFnomTrnLoTlrStFQXSmQ9DLgKhndAcxeH7X/2MAcgnB7Eoz65HxAu5mG34OlLldvpXk9QYpZw67u6+w7McH/RC4qJI+Ek82PfI66iMHATOl6Tba6R+NnoNEcJ/gkr/H+7bUFYEwCteL4BWrbwHFjngbhJFUq953RcLia2QK0BByew9Wo4+oZKHVkCo9nkmDLKc/xEo4vNcMFdARffzX5F4KrYEQUBiuOjvYWRFk8tMXMRsv2vlXTHB+Ctd1iJUBEj7ZkFqa1/GRFBnmow8VO0ORV68ww+arGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM8PR12MB5429.namprd12.prod.outlook.com (2603:10b6:8:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 08:39:30 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1%4]) with mapi id 15.20.6792.021; Wed, 20 Sep 2023
 08:39:30 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v15 06/20] nvme-tcp: Add DDP data-path
In-Reply-To: <5b0fcc27-04aa-3ebd-e82a-8df39ed3ef5d@grimberg.me>
References: <20230912095949.5474-1-aaptel@nvidia.com>
 <20230912095949.5474-7-aaptel@nvidia.com>
 <ef66595c-95cd-94c4-7f51-d3d7683a188a@grimberg.me>
 <2537congwxt.fsf@nvidia.com>
 <5b0fcc27-04aa-3ebd-e82a-8df39ed3ef5d@grimberg.me>
Date: Wed, 20 Sep 2023 11:39:24 +0300
Message-ID: <253v8c5fdc3.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0019.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::10) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM8PR12MB5429:EE_
X-MS-Office365-Filtering-Correlation-Id: da234ae5-2776-496e-d5ee-08dbb9b51b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IigS4nFU0A1Mhedcd41dF4Fx+7KiBJ9q1irKTBV288w6IG/64guGs3d32wGOK0d69qx8orcVBIvqOQyIUphKm7WgdHOFf688ANzt1R7wBh5NK4faRCSbHjh/8DP7xWn9ZvCgX6xeHZZ1bTcn2wXHxc9LjGRYsKz/QMoFiHyNx2dGTMVo7p98jDQZpkz8/cVtJYo/RfkjbUFeQF6BJLttxD7xyX4pXg2hrKmrZxZ8agjkuGUkBaFVk+gAsCgZA1tWQjjaHz82Po/ton+mip8P74+FEpr2icABvshyh1Esh+5HXhgOhKs9RWc8M+uWE48IkKCG1f1pukU7cWcyYv2drNC8OpqEVXucA3VfQCh48BTelKGKEH55gc//bHDHkZvBybV0dJKp9l/ejDWXI5TOgWuhNp/sOg2T2cqJo2NXfYtj6WqSCWQ9UlHBbuIf1SiFkMBI+I35q3j3OuXJPUdAN2yCGMce52HtEqczABPOOWw8cXgSc/zPCysWbksHAsV6uLh8j9KWQEobq2jNbu/hi7nq0tNsDI5Bov/LStSjYlH/5GlbWJfZwrPZduPz6JjG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(396003)(136003)(186009)(451199024)(1800799009)(2616005)(5660300002)(107886003)(41300700001)(26005)(2906002)(4744005)(7416002)(38100700002)(86362001)(36756003)(4326008)(8936002)(8676002)(83380400001)(6666004)(6486002)(6506007)(6512007)(478600001)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UxFtXR76pYhrS6hTxIj0P63IVSYfraaSXmUEJVn9WWlGLDT1vDZpRFPQwGlX?=
 =?us-ascii?Q?yGA9zM1qQZLoaMB7dVPbVwBZ5LXCBLM9LAxMnzb6ufHPpdhCegWa3GSLBe6u?=
 =?us-ascii?Q?gze3Wo1WU06snwgK4IGIligl9X8h+IMOeGQj5k/mP/91j8L3T+7mF+CCmBBz?=
 =?us-ascii?Q?oll0CQHu9Zxnl6sy9NnN1dcJzmnWjDM3Z0a2Buxpu/iEuv6AYgQULgArnoSB?=
 =?us-ascii?Q?sO1JYDDy0/V4BDo4sa5bR0yXuijT7zMW5AL+XNrPTbiPkiXBgeTygBFTcfno?=
 =?us-ascii?Q?hJdxAUXkLYdME88Eh6hSVZdNWt0BV04g6IlQCgDi7xdKje0pBTokMLCt9WHB?=
 =?us-ascii?Q?e+Ugk3YV0gwqtE7MsadnpsxSFesRMqwYGsyOrjOav6ig3kQ0ySwj893G9wM9?=
 =?us-ascii?Q?GbpISYZOO4f9QB4qp3XrL2Lv3VzmuRXGSu290KjbhQbUVdwb8b8f9wgIQyKn?=
 =?us-ascii?Q?4NuQBbatKMxFjpr8zjiQG69USjmpVOtWbgfLcynV0DWAMBNihcJQFi4+1ITa?=
 =?us-ascii?Q?1Gh117PfcmNNNYaUrNpk78OuP1A29ASxp7N7Rzv8TgNfAwJy84lEcYWZk4Hi?=
 =?us-ascii?Q?lkDHjEYDIVEpNX0L1RyPi9dlhJQjmgq/5sORQa+0H7WNcxehJRf9wwjE6Q1/?=
 =?us-ascii?Q?sZ4SE5eV4pXtNgr3rlbIAwfLVWaLP5pAJ0RzBLnwFWMru95cT2MJ0mwC4YsU?=
 =?us-ascii?Q?CotGQ3fTu7fTWllTRrpE694z5RE8JbLwiMc+V06CsqOoTH9yn4ayxvzm3Xue?=
 =?us-ascii?Q?6Pwl8JTUywEwbtziP1cT++DOUn1dvaqlHNGDeDwB91rAp8dIvwge8g7tK8OW?=
 =?us-ascii?Q?xDEY+V47TZePEJcJuiQYm4hQl3+ljDWE4tTS2R1TOmmmU+7cJCsBQWULFk9p?=
 =?us-ascii?Q?haKuESsTOOOP8jGjC73H6uOqhxbOTpde5Ejhdk5yWFlFxX7RqvqY7sL6Aqh7?=
 =?us-ascii?Q?m/vP6dPoP3ykaLXlSy6hjNHeJ/aMmMexIr3GvG3fpthAq88tg2QCcf2KIYIR?=
 =?us-ascii?Q?AaXkpyvT2ssxShPnyVvVsHSasKJ/ThypPVeWAHm3ts4RuXyvsNl6c8zrfmAE?=
 =?us-ascii?Q?i3ld4ExnEFqhcLMXQ4zjNk2JSI7eTDO40b3gus8ZfF7dgDM/flgdyF+wrzkk?=
 =?us-ascii?Q?/w51qWrXBCZc7Bu9aULvhbv1sGocWhr5b/YatgfhFlh9AmKkCVH3+8ZvM3+M?=
 =?us-ascii?Q?Sv6BKB2YEe6M85wNurbTAtPO6zUWkpKZZcob2Eqf5NT+BPHzjn7FGU+FIZiH?=
 =?us-ascii?Q?QlgzDQ0fBRdCpFeBH5e/3VslI0q3bZtRLsb29+92LFtrPdk3oiO+6dLUQ25J?=
 =?us-ascii?Q?zz07/pK9UMhojpZU0Aw/Z1F4SndYhNVuMuN+XuUcOJQERY/K0X3cqRleBnuq?=
 =?us-ascii?Q?zUMljWCjKjH1R1LQCqrsanUOY71s2/cg0W59sepo2chkOhs1YdfDYgmZkwTz?=
 =?us-ascii?Q?DDDNPPoAQu1exFWuGwb2FpJOWwcxXfGzRbnbbmKr6TppWQ6r1N8YM795q+m+?=
 =?us-ascii?Q?5OB3D+VNQcDhz4leNWKvNV1ANVnjcXQ9nmzzlBbbBbMKB3Xe0lOmSLX8iq6o?=
 =?us-ascii?Q?mzYfs3B8V+CLBRMQUwRY9plFMPPMlEsiy5T47IX8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da234ae5-2776-496e-d5ee-08dbb9b51b38
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 08:39:30.1715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPpDtJiGrW+S+zZFIs4AuXVaghOG7sq4bXg2G6yFkGWfX+OVZTwWCoNsBO78Wv8gnDp4yqDPymwNckbm6a3jpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5429
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sagi Grimberg <sagi@grimberg.me> writes:
> Can you please explain why? sk_incoming_cpu is updated from the network
> recv path while you are arguing that the timing matters before you even
> send the pdu. I don't understand why should that matter.

Sorry, the original answer was misleading.
The problem is not about the timing but only about which CPU the code is
running on.  If we move setup_ddp() earlier as you suggested, it can
result it running on the wrong CPU.

Calling setup_ddp() in nvme_tcp_setup_cmd_pdu() will not guarantee we
are on running on the queue->io_cpu. It's only during
nvme_tcp_queue_request() that we either know we are running on
queue->io_cpu, or dispatch it to run on queue->io_cpu.

As it is only a performance optimization for the non-likely case, we can
move it to nvme_tcp_setup_cmd_pdu() as you suggested and re-consider in
the future if it will be needed.

Thanks

