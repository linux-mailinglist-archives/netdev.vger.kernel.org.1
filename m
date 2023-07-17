Return-Path: <netdev+bounces-18246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583D3755FAF
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 11:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495DA1C20AA9
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 09:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E780AA93D;
	Mon, 17 Jul 2023 09:46:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15B2A927
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 09:46:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D7DE5
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 02:46:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AA2y8ihugE/0vrVffjJ0KIAvbENRR/vC2MF3Eoy2+RwrLdwAdMAv2xMHNMUUvchPg3ZD2wq4N+1OMwVMoVFK0lHxKi8i42hiT0ER5LefaOTWWhY7BDxfE5AFqHLKJTW9FdbwRy+IBeIy/YBfWzMC/7P8jmmXYhG+zbkJO6Fnt7lkPrhNbCWskIzLBT0idN4oHYLmas+o6UN0dQBJexXI7xHYAXW4qHNofpGLT3q6N1sbKvEnDHdRpX8kce/vYjKHwxbgjotcMaGiwdO9QytcmDF93b0y23VoHwT3xgOizgps1p3Z6Emv8Qk0yeK20PkemHVggbDkzNYAg1OFTfbZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+elP8oTv8g3H4q+v/grn0braelL5lh8JtPcT8NOBkp0=;
 b=iUaSt0ry+xSqwkpFO9pBpVgcvDn8XBOiMvFCVZN88N+88RO7LvqOa7VXY57ozQVt3htTA/MSLBa6Y8vh6VzyjYUOsit2bLSujCNTxmkktHdXdvdmZLrCRUW4fGfFY0z4XdTFIuhvJ0f6p2aA3or3t0+FgDW+Hs9yz3IRYacb2uEc2sHGmA/k7WJR/kUVHo9QDxkDGagSLqnh9B8Kjl/v8MTZB/iST0TBxZlIi12A+vDOW/fB8qaNRXRSCfH1QCy/ttoWYuFu9gu/drxY8AsLbTgDjo8F66SOaZr7jI6WTQ2bgUNnVWUleedBHYDTSw1hgBMyfJiOO8BkgbFE3F4cuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+elP8oTv8g3H4q+v/grn0braelL5lh8JtPcT8NOBkp0=;
 b=EnFNRZ4R5UVM75MeSgxYp2KKJvyv9APD6TPBuNvqcoscCDZ4hiygYGVOu3F+UVukpo7LVLj81ro+QpL1bMD1zyaw5GYGtE9orKx4hf5cOUBpXC3eh0EUmt5KFfZFNPibrNshR86ELzwE1Scy9pEE2BtOHP9Q1GfLN68iztTEhFkfHFPrwmwMyg2hHXFMP8o87qtdPn+mWvmrytEVGieW8Jg8hpTeKf9MsM4xncBetCfQt5WmS4We9QiVsa5YJ6UuC/OQmAvPL+IJ/7LM4gjOAaDG20aj7OUPcfTA2tTGbwNPD+l41t/+cu5l6YpWMJyIxe/7xun8NVB87V2nxCcLWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 09:46:00 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 09:45:59 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Simon Horman <simon.horman@corigine.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
 aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v12 03/26] net/ethtool: add ULP_DDP_{GET,SET} operations
 for caps and stats
In-Reply-To: <ZLJxfcKFwGN24jEP@corigine.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-4-aaptel@nvidia.com>
 <ZLJxfcKFwGN24jEP@corigine.com>
Date: Mon, 17 Jul 2023 12:45:53 +0300
Message-ID: <253edl6swfi.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0222.eurprd07.prod.outlook.com
 (2603:10a6:802:58::25) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c4964d1-536f-40e1-0d0f-08db86aaa03f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FwdCeETbJXNxrOAPk5MAbEFx9pC09M1XlPxReW8mwJIdFONnHB62a2tR/tlDicpVKhR9qLgFC24qNnh4d3AwSJAKrp/1VyCgBBnDb4CB1Hnskp3Q99rsDLnIwORtVifVjDz6kqCxaVfx/tzZCRGNVIbTNY28pGr+K6ZOTPBDu4ot4wjHE7DMOuIE4h6jTVoXvlP000oc+lwzxC0LUNBomFQb1QLd7kK6RkB1uG/cyg5P9it/z1tXr3Oz3MJf4+4A9DfxIjwp0DWt8doqqRY2SFC7evJpe3pDDFRUqIvjcj9eA3N0bJIq400H/qIGTpvt8HRE0VLg+atLAXpG8iomWENAnnzsxc0kmkhN4WodVS7lCy2gPFGE6y7nUQG5+T3WHeD60q2yzRLhPbowqPzc99A2KEMob3CusKh4MLDfxzzB0yZo3GJUUV4q2qB5cnipzuQv7HoUK7Y3DwsyRKz0DFxHSniyKz/DoAWO4baiFlHHl5lapcCWuZTVSzhZyPLx4n7TogjnRo2gBoUn/NySmyyZ/OMrGeeILEWG0m+hAw52IcFSbPgWcYkKqCfb6beB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(558084003)(2906002)(478600001)(6486002)(6666004)(8936002)(8676002)(7416002)(41300700001)(66476007)(316002)(6916009)(66946007)(66556008)(4326008)(38100700002)(86362001)(6512007)(9686003)(5660300002)(26005)(107886003)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F0zorCxwVky0JfR5AbV6xRnx6UJKIq+f0qO/pIMX9MZavEffTaotaRxoq8Os?=
 =?us-ascii?Q?KJWR/IZu6uPWNTyLvn/NsTjxmxpS5qrcCtcid0eDUEaJgzGtonV1NQTm2Vg4?=
 =?us-ascii?Q?jyD8+SrDxgopFgjwoUxpDaEMJeErAozeqM/goZkrO44PBnWkTvb+zm4G+7N7?=
 =?us-ascii?Q?EXaRLBbJ1aPos8Er//1XD7YLt3peW7BLKj4rx6b3VPY2J2Iuy2bo1De5dJWx?=
 =?us-ascii?Q?nQ/vvcn2zf84FEs8xYqDNLuQrD2oEoJpyJ5vACC9b0OqwCrAG4khf7YmiIVC?=
 =?us-ascii?Q?bPLPb1ua4Y0GsvFXJIoXzkv7eDx8evhm9LvHQx8hiJbvE+nPO6HjbCXu+Rtb?=
 =?us-ascii?Q?h+wctCtKQOimbTVMzKpg1PPui//QFvY6oFIuyH9ncjUu/VvelSPLGwVb7OWT?=
 =?us-ascii?Q?qVh/f8tKEiSsw9i3HwrS4UIpgHHnmOpOoCS/BSlYwK6tMz/t2xH19KhPoUnu?=
 =?us-ascii?Q?QYrE+4kLj0zG6EtdJQZgIjEJ0z6+/7SZ70uD0oPm4XzQMKybbHJnsRZDmiAh?=
 =?us-ascii?Q?fe9JnDBuD9rRgijJdRQnb1IUfVhNBFMoGn/6iF78jbHU9CALjQalcOJl4/0y?=
 =?us-ascii?Q?i40/Z0Vb8u43/Y57s0irmFauAKJ8/zM/I1CPZlXKSxaPxuTy9H/Iky3RPaO+?=
 =?us-ascii?Q?b+W7auYEswhrcYWef/D7yiH1ZtmaMw2EUEr2FCqKdBJ8DoCURMOeg8ybuXrC?=
 =?us-ascii?Q?ohnZv1hBRMWRCdb6ZCIG6GkyXHk0GvQ3sLrNwt+DwFBPkDfqDwXYwFBzfsTv?=
 =?us-ascii?Q?4bdT4yPyYE2tL8NTZ69aVUCCuL603oTEHQ3/aVWInybqh35hQM4BowUYd/vg?=
 =?us-ascii?Q?SmW6nOXoDDvIjo5woClnLdRojOcXI2exenlM0SRsZcuttNb9QNIul08R52Hv?=
 =?us-ascii?Q?s/F/z/fwBt/vqSzm3xl/u1WWxCVz58Jc8qCXVFBP0IfytrrLMU2hmlzi0cZo?=
 =?us-ascii?Q?BCkXh2aGY99QuMg4ud5twp7t67mLRymOu5ssiqUbBlMuoUrY9RIzaoxGF/ZP?=
 =?us-ascii?Q?DfcVGmy7nijUZN5zYCCYIA1YboD5Wo1AHvtVYIaBkgCUKCY7Qnqdiz+srP+Z?=
 =?us-ascii?Q?BMuFuBCfdW99lvoxo90UKBML90M9ntgRXFr9UbxaPrC14U7wykUws+J5+8Zv?=
 =?us-ascii?Q?aCjHMT4hea9HbVGzvs1ytU1AFiUJcFEAf2DypCNgqIUtMVAewdyh4otwiRLq?=
 =?us-ascii?Q?S9WSbk3xNIYSGdhvq2Wt1NFgVpgEPIt1RDrBsJE67257XtKUcYcOsteKyIb+?=
 =?us-ascii?Q?hDGh3KjBznUbUihsP/4yEJ0pT1bXYaDuX0Uf33cKVbf+htj7HeaTodLeHy4J?=
 =?us-ascii?Q?mTxXCelvJEXevePhwtJDshJRbf82YpIBuRIZ5eHqMw/Ckz3X3xpYxKJsS/vC?=
 =?us-ascii?Q?UVxIetD3t+4Hf/GN3ZZpufmWP14r3urwoa/xNp4EAF3CxwJos+Y4jUC0k0th?=
 =?us-ascii?Q?8m3jVglaV3hX0yzW4T5tYbk7BNkGDY0tecexALSYnNc+sxHsxIKaDNaF0SHy?=
 =?us-ascii?Q?iBtTehCfa/EUHscFi+QFaD3kAePKButja0ma25iusVOUosU3DjLA6gV1cHxr?=
 =?us-ascii?Q?VBZVgMtD27meYQM736qG75Kc604tLAvWATGEg727?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4964d1-536f-40e1-0d0f-08db86aaa03f
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 09:45:59.6413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDU85LyTOJEedkJoG5evVqO1FFkBRNAE+gPViCkYhExyoR1Hi1Z/XdeVmd8449y1twXqUGI9M36O2sUUiDid+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Simon Horman <simon.horman@corigine.com> writes:
>> +     struct nlattr *nest;
>> +     unsigned int i, attr;
>
> nit: please use reverse xmas tree - longest line to shortest -
>      for local variable declarations in Networking code.

I'll fix it, thanks

