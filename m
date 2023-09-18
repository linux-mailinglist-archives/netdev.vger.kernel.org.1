Return-Path: <netdev+bounces-34558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0047A4A30
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 14:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405921C20D5F
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5671CF98;
	Mon, 18 Sep 2023 12:53:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D6138F8F
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:53:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E95A9C
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 05:53:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWuyc0gTHcKVxqVb3ViueykzCYjd10Ca6DWxcVrMdCbTitVkeo2lY+tLOIgV53rrlxhLjQj9zuKtSvsbNyedhpJEpFfpApaRrvdja+eLcN3yduK22/Q8ztFopwv2Yt2ToCQrwk+XxdeoAFu0Bk2XtK/GvQpN3EPUgeQH2Cn+ikjWlj++KZrfgv1xPbU7p4EdSSOg4BssXPImc79esqVfBIybKI7NOZ2HZKxRD51GOpmBt0kxXNRwXFrFGtA2lDTeIU82ajbbj1nBl2DpSEQazB1bnwUd90PsxjbnivPy+Hi0aLzTdNU4Zfgnyzion90r9OnZzduC/KlEyHDY5hbtug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+Gw8IQdFJop4yJkAYdsTY8wKvmey3kKhuS6J5jPVzU=;
 b=P3DqFOgSZtiPK6cEo3rNTA9FEBMeUkFXpsx7bMtGnV1wJKTuFQ+qh6Bng/6cYJ3Uc+R1DEyz5HYd724A3fhTZSCsTnnmF6S6skV79ujtMKsgIdu7ZKP53mxJNOz8y70+qJ1hx4v1KmN7fECJBFgdcUJahsHSPH/wg0dSgaXFxZAvGiiqrn4tzCXgH+qLPYRO+p7DOqoKEztm77Xc8W+edjhRF395g5Y8UxMnx8QX99X2xn6RENj90jnXk7GNH0vm6jEFLBSJu2wNXeODtIz1OfQSYKfUD76/BI1k6YgeJLP8Rg8uk0AsqK+jJ77P0phd2kyG00CRutHv5w0AQJggaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+Gw8IQdFJop4yJkAYdsTY8wKvmey3kKhuS6J5jPVzU=;
 b=XnaGoCYMBP5v5My+CPtj7aEj2DPOSgBC2T13uOO63FilFI5UtCBwKNFIGSOoJ0VBpYdmbjtDlPktuKsTUZQCTG8sj6R2ACTA53HgS691SFWzBsufI8/geAAjz7E18oLpKb/qx4ons6k1E7wjF7wG1w7tekDrVKjeAEtYCDuzUD8QeaEox7T8w7Wjvq7bBvjZ2L9iJ/ELt+VXhn/C49CtT+UVnoDnk89c/ZvSURvjqbh5+2MDA1M9N9S0tkmnW38zN6E3yfJtOQklwt5jlZ3uZLsozbydUkbG0/dtoEa6M4iRxZVPX5sJeoIden/alyWTLszVxTujiYc1Vu2037KuEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 12:53:41 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::54a7:525f:1e2a:85b1%4]) with mapi id 15.20.6792.021; Mon, 18 Sep 2023
 12:53:41 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v15 05/20] nvme-tcp: Add DDP offload control path
In-Reply-To: <93a30515-c85d-3942-29d9-ad6bb0e869e5@grimberg.me>
References: <20230912095949.5474-1-aaptel@nvidia.com>
 <20230912095949.5474-6-aaptel@nvidia.com>
 <db2cbdc2-2a6d-a632-3584-6aeafc5738e2@grimberg.me>
 <253edj2h20j.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
 <93a30515-c85d-3942-29d9-ad6bb0e869e5@grimberg.me>
Date: Mon, 18 Sep 2023 15:53:34 +0300
Message-ID: <253a5tjhcc1.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0019.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::7) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: 90b167db-0b98-40cd-10ed-08dbb84648c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7se9JkJYv6J0UMq8W7/ROIH8z8tTVGTA/o47tuePWUrliCQFwoAJguKxZiD7z1WwMhmN/fbWZVsiRLpltsbHjsm93KUhudXjrcu26ovCBTLJAWTc7R1yS8ZusoX/oyhJjRVsUL3GxUaJb8HDIDaRhsh1gY2353jfhlN9FsgLvwbZtn13y6xXg3k9afvRlWT6mycWZYvoqE5Sqt5qpN6OR0hjY0KTvXS0oaMXLZ+1X+DXzUbuPvKH9bUZYYpM8jBgBwC2YM24JtiAr42eGL0zGNAcfjZL04Uk7Sbd2iltTpvWd6Op0Mjh5hfR0cs8KrXqocV7QPxQCED01X2m2PJlOilgIFz98sTXXHdujazXlBAX+wBf7ddKJz1e4VqcjiHngXdOHA/HVrwcSsc8Qh0To3D/tJaavOFcDS0VP5iAf8Wl/wCAgC0w9KzNikBK/9alYmdGut4xra9CYbSnYA6BHOOHMGENnixig8WnfsHVjP6BGJjRbO6MnR8Z6Udf91TgQHcYgHLixQ1uyUecoQTCTML8sC11RETEZ5dfchS3qmpmWEIU6l+DdEp73bsgrWqu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199024)(1800799009)(186009)(66556008)(36756003)(66946007)(5660300002)(26005)(2616005)(38100700002)(107886003)(4744005)(7416002)(2906002)(86362001)(8936002)(4326008)(8676002)(316002)(41300700001)(66476007)(478600001)(6666004)(83380400001)(6506007)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CrTSz1LuaafYD1+4kj0jofx9XBQ7NlP03SdY1uqpfEEKFQxlQdT0VG65rtXb?=
 =?us-ascii?Q?jTP47p1euXh+uoUK8IQtBeiolnacYgd8u0xcozzARidUD/QxR9DHzB6z6b9G?=
 =?us-ascii?Q?z7b6fqHXyIXiSZ0QLZ5uhjSkj1O2VwHou76nq+ARRH5nsKvbmNSeJ7WI8SXg?=
 =?us-ascii?Q?H7hUzsU4u5lfTiH8cwefGC2LflNHtPwiGJuu5kiO+3vzg8FMEXx3hyy5RfdC?=
 =?us-ascii?Q?DbiV3p7le/CA2UTXLf83TkMZi8Q/EMutzBcz1H9xBwwSBcxpBiUX2b/NAtoT?=
 =?us-ascii?Q?gpX3UVpqWJ0AdlD8HRt0Fj078xzJ8JkvbOm4rljrx5XkGFbbeJGkvhLyLKds?=
 =?us-ascii?Q?wbVBsplFravDqpV4gcP+ttc57Jh1hSBVDHeQdSMhI//N3CdWi6Zquvl0Dn+S?=
 =?us-ascii?Q?5ppr6VyLXQOpT5yiqsqtQzbxy9xu22zGxWzIIrpP2Yd4+F0ieYjXgLFHSHQV?=
 =?us-ascii?Q?Rku4j13xunds0uRmjMDoH44sSYxMbEcaGWlCew5DMyDZxLVHzOoov6ZQLRH0?=
 =?us-ascii?Q?BmnW9S/Nu5frJyMTWXmm7tc/oaWjWhj1NMqbPdG6wLy3BL2wA3XD30rTfLcJ?=
 =?us-ascii?Q?wBiRgdtHn0Go5ZlOwhcnx8sqoCrFvTbOlmlI9cBXXpz88gb2rMKJpuJBfq4z?=
 =?us-ascii?Q?aJ6tDqo6ST7ra11ZS5mUBGozvRM4jYwOoin+zEa/jSodoIVC0SyQuY7pAs5w?=
 =?us-ascii?Q?SDTepAp9y5vwW/IGgnmqyVBxVZTnIRqt1z9wBc13zujp6HgnO1BqVP1Begam?=
 =?us-ascii?Q?ZfTjxpWqgF6fQvTaXvp0tcdpyJAg7EEvoEcd8Thf3MzkDQCLLiHoMmoK4qk+?=
 =?us-ascii?Q?WXMYwFgjAooiX244TInRaxwzi4RtyHbIf5oyaZqoogPRZk+eNSP3vWhVXd36?=
 =?us-ascii?Q?82GrjgHy4FF4xS8LcJ/kMth6Si5LE84qIA0nqlUftzvdwO70RT2KCHxFnm2n?=
 =?us-ascii?Q?MFDOJAQ4B0VMhN7l9DM+8V9ZB4dtQjl0DUOKMKlRaPVUWgzh04JOYZRQjPcR?=
 =?us-ascii?Q?nxJYA0P25ayUKC4LPFWica/GQpWQXmA3MiQESt97zORLMnF4LWna2aN16SUh?=
 =?us-ascii?Q?zGebwQWiUXUKk0Jxk9eXvRiCi52L4SFl5EjpRMUNvAuFmdpkfJAeOIX8kNFn?=
 =?us-ascii?Q?LLSfE4j3TVRJsuLqHQvkVQOv4ugKao2Wwe9eG6JH5B7bCA6caLQ0kOgGndvu?=
 =?us-ascii?Q?j/+jgTGcsQF2xkqEQjh5O2G4wImPHE4ZPxwN1a9ifLmZxzS1A4Ghp6xHyI+L?=
 =?us-ascii?Q?nGWyI9uAOxN5LFu9DXiU45vtf8/mavHGNLdcEnktdMZ697xOuKgcVModJz+d?=
 =?us-ascii?Q?b7g9fgp0kk3SAtl1xLOiRC+5dceb3RN2lqN467dpoUWpOZDdkoSHyCwk32ZQ?=
 =?us-ascii?Q?H6M/3eQWQYt60k+mJEM/fU53FC9m8zGjDm4wbbCCKlhPCcSid1OtAlSx1vX0?=
 =?us-ascii?Q?F0pPUo9Ppi4mbwJ2qFnS/M2vncIOhvP0Tjfbl+Bd3XsocKlc2CFQpmgOI6B9?=
 =?us-ascii?Q?iIpraboqjti4iEDsMMgB/zVcEVzY2+HBNTPYYIiw7tiu4WNpxZYM0bjG9Nf7?=
 =?us-ascii?Q?2X06uGa5LvDuOsx8yh3XoFkuOBwctyTo8PjA0q+L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b167db-0b98-40cd-10ed-08dbb84648c3
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 12:53:41.2793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6QkV4BPbd52n/A+bdq16qdppIc8PG5MZ8QdLJi7NR+RAgT3zanaifdwRRIZgn5gdBuXpSnCKTPn0pGMZ0uSWWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Sagi Grimberg <sagi@grimberg.me> writes:
> Perhaps you should bundle them together:
>         ctrl->ddp_netdev = nvme_tcp_get_ddp_netdev_with_limits(ctrl);
>         if (ctrl->ddp_netdev)
>                 nvme_tcp_ddp_apply_ctrl_limits(ctrl);
> [...]

Sure, we will rewrite it this way.

> 
> And perhaps its time to introduce nvme_tcp_stop_admin_queue()?
> static void nvme_tcp_stop_admin_queue(struct nvme_ctrl *nctrl) {
>         struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
> 
>         nvme_tcp_stop_queue(nctrl, 0);
>         dev_put(ctrl->ddp_netdev);
> }

Ok, we will add nvme_tcp_stop_admin_queue() and use it to replace calls
to nvme_tcp_stop_queue(ctrl, 0).

Thanks

