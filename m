Return-Path: <netdev+bounces-18248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA98755FC8
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 11:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C312814B7
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 09:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D97A93F;
	Mon, 17 Jul 2023 09:49:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93085A927
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 09:49:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A541725
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 02:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/WEhD67qKnbxg/9gGJ7+nPeKxy/JK8F04bV2YTj7ybQrQStGpXOlDfn7eKPl5liMXLJ9xhFnZNGjGqXDpoltwomgx9CZIB3lh65waMBF2dgwAwzxgZNEXvKWOE92z5ValYi4JZrNRZ+T0Cyt5i0wAXNMNi/3eVyf3nixbUaSx0m/IwIGTFf3xEs7CyG1gZG0qeKoL8INrRgJjZxGIR154pkMv/Xvw+o+TDvL1h9mfVwRsI+zykpBTRnxa6uuDYsBBrYfLNCISKh6w7xLRjFHD5rbPcCMSNFl/WX8gnQogmUs8nQ9K7XrafODbUQ9vSmHn/uSO6x7kTNf220tLYDtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYaurTqmCY/i3dQYwFLhA3nJMYfK20TDb0NwjuGMZ4I=;
 b=MMDm+HfoCcg9c/dKtvTHslKTI8eoA4omAiyCPRhBNviIC5rVy/uQA4twI1AqDUreHc9FIsYnaztCInXoLEx5ooraG8ZYKEyp/qoWx1HmZ4S3IdLnOi3MocLd28C0kMTMmcujwJRuowBrwH0CeKuYwcn4ZQwzK4z3oVyzefZimqXRgYWJET8iuITxd0CtKj1Gu5m8m1GoRiKiEdppMYOORBTp1LgrDUDovhb+lZ3XKPfxLj2BvjJ8CT9irx98UABVGP/qAR0S1P0Wo/RuJRbjTxGO7eTELmQmgRIE8imiZpr8SU7M2adA72T1u5PLTQo454I9uZKZXo27J1t9w2w4uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYaurTqmCY/i3dQYwFLhA3nJMYfK20TDb0NwjuGMZ4I=;
 b=V6VQVgFT8Sg8NNKrYTn8nkwR9s5cORudAC2pumIIH//yo/YLCObXz0MzeKtlrRmvzUrlFFZ5W14eiZrir1a/ACuA1vY5D1BeVIZn9WR664gV4V/de/rhUWtqCGXivKm2321jVWZ/d+znEqRL6qc9cp7shEM6k47c1MtFm+SQBgjTGIRX1o1K3bXjglvEqwn3XnWEVt+4KE0X4llZLnw88wQLyL4GQ9Upr1VnvUJA9d2O7avXPK4bboAqbXqsapLIjIKW5oiBeESQdzWcruMBpzzm7oi7SdrU44WO71Uy6h45QSN1AuXgzb4GiAPqq6m6+ZTyRQwb2qMuoky1uKcd4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 09:49:03 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 09:49:01 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Simon Horman <simon.horman@corigine.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org, Yoray Zack
 <yorayz@nvidia.com>, aurelien.aptel@gmail.com, smalin@nvidia.com,
 malin1024@gmail.com, ogerlitz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v12 13/26] Documentation: add ULP DDP offload documentation
In-Reply-To: <ZLJ109eXtIge6eJ9@corigine.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-14-aaptel@nvidia.com>
 <ZLJ109eXtIge6eJ9@corigine.com>
Date: Mon, 17 Jul 2023 12:48:55 +0300
Message-ID: <2538rbeswag.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25)
 To SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf6a337-bb40-4891-21ff-08db86ab0c47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BlIvaEMGMXl7QOFV3juMVCRwtF/ONzQ06FZ4yDtFsC4k6n36tAQHEffxh0GUdFRkztdfhjR+DofBSRUvx+fxEoMhmqDwK4pdxcSNmJqnsmMnf1NZdVd2yrAU3WIVOZX1lNb7QcAoaYq3lst9S9yBfib5r/Jhoc40JDZgXk9WrZ0zahSoKZy0Nu8KZKC2E0z5MnV+NXZ+nh9ZBX97uXJqvZlM6cg1fCSElSEdqHFMVWSIql2zRQfBFTUQSTzvTBCKp+e5yLq2gzqD5Ihhwo28YSpBsWberFPPEEeUZVExhKdfJZ1vPnirvOcGc5+EUiXJ2wxuSCBfI7q6Myc/NFdGWoNvOpWOZ3C3GliHZE9CQgU/IVJLbPYfMIygUBZpIrcjaecjbX7kVur72U6AR/f0CUYouaNZ81EYmA+lF/UichOWIQm21GnbfM32ui3KJB8rhvZ2UVbmeZcmS7eRCdzX3Pn++rTahktU8oA7RL+wILD9J2RxRY+QcMyesldDizdovEGNSVojZ73Mb9iKGhV08iSGWGVRtLUggfi0xhqjZfaMt6TEXgouZkNV30MxWGnc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(2906002)(478600001)(6486002)(6666004)(8936002)(36756003)(4744005)(8676002)(7416002)(41300700001)(66476007)(316002)(6916009)(66946007)(66556008)(4326008)(83380400001)(38100700002)(86362001)(6512007)(5660300002)(26005)(107886003)(2616005)(186003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y1+q5EJw2IKT9fqCG861I6iw4yBqUzlVq48h0Ma1c68preMMb3Dxq8nivgKd?=
 =?us-ascii?Q?KxRzdMlSEf38HYRDMxiEYf6TqKZjqtQXa72Mip/4Bvzn2kYbsonNqILRerXJ?=
 =?us-ascii?Q?BHGTQE1OZ+EJek7YY+AZdkwyhymnRco1uYtNz68R1ljXS1cdFwEKmEad9erV?=
 =?us-ascii?Q?zT9vv5NHFZzRgKSKYHLg36C4/yw+TdeU0ysPSwHjgnW7kyc5JQQ7ttpjMFvX?=
 =?us-ascii?Q?OvNoZ6FPP7DGA1gBaGZuwXcd0w6zZXacc8kd8k2XQJ3UWR2oEyYD7vC8g9Pa?=
 =?us-ascii?Q?mh6K3KCZct2F7MQTyACLpCirankwt9IhcPSds3fT8A51mrkZNqPGEeHcOgVb?=
 =?us-ascii?Q?9KSlqG1Gx/omhCkOEhtkcXycueLYDiymvIPW8mSdtqeHJjHEmmRXdEyUcAd0?=
 =?us-ascii?Q?2TjhSALgfujCuyB+D1fWfk/ByBfGB8xuAKLSRDfiGOCG91hCAVLkKWGwKJm3?=
 =?us-ascii?Q?myU/NVerhuDRdpdHypb1hDJ3YszJz/75wXWB3j/6AKQmu9edE8oL7Ze1aYfX?=
 =?us-ascii?Q?Qk7KbKDjGGjc6hsTfOJfXrYRHGExEVNGIMvoHw7FQOPQfOfeE/ph7b/MHLU1?=
 =?us-ascii?Q?O5YALqmfgyLJDFZbLqCScu1C5Wj68eTBqzlUwJlqCO06/bycGKDWJ61Zu7D9?=
 =?us-ascii?Q?S6bVBm0Q4UpYZbO7JZlKB8QOzcqYx5naowgv/yxiiLLBn50KvUGOlnu59xez?=
 =?us-ascii?Q?Nuk07JeW/PJxEnjTQZQ0WWTCtSADYXYWq+k7DpjbfIFvEnp9UJJsPCtm/miW?=
 =?us-ascii?Q?Ypa36MSf6CxSo03u0O+vvxjAh044boYRAXvoo//NUvffVGLebsxCGWjJHELg?=
 =?us-ascii?Q?q04yp0LJRXpKH6ygAkp1NmrDMUtAa6bgq4kyB+YWfFBY/IbnMXa9vrF0dJX6?=
 =?us-ascii?Q?S7rZ4zg1jqHCLgQ7mwtQM1v7/IcDFUHYxQDAvmmHenySMg02JYa64hYdkJeA?=
 =?us-ascii?Q?/fkCbI6VV0N2mXa9zAHpLMWKB6bTWT8gEDiVKWkl+6XK8LCOFiZcFxrJR6MY?=
 =?us-ascii?Q?IKs2scTqVwu5aDKybrhP+leZlTxKDSXp4Leu7OIbuTvHVlk8og1E95sAvwC7?=
 =?us-ascii?Q?GbtOTt0ihys58mgChpuVAEU+DuDutViO0+JB2YgLBHmiN6SiQvr9PU+A5mlJ?=
 =?us-ascii?Q?P+mdwYaudTqrzffDb1ZMl5W5uDZt80Imfha3LPO3676e0fSX6ydM5cSCsFHZ?=
 =?us-ascii?Q?NJBPuj/N2Hb5NGDQyeGSTfuTUbMfkzJgk6YAqxoNmhUf6B6f5Ol9+Vlpckad?=
 =?us-ascii?Q?FoMCRwUrW/oO/NHbd9X7N/t6qXjRO2fmWepP4ZPPl1Mv82fn0jHNr4sWg045?=
 =?us-ascii?Q?RbYd3m4pVcayo99/yFrSGp4uWtUXjWzZDGbJbgJr9BQAMVtzMMdzens+eflA?=
 =?us-ascii?Q?PCRdCJBLcFFDH5/OBljIv5hA+B4CNYkOdVeeB2+zXDWvZyF7XoF4wx2pJ3ae?=
 =?us-ascii?Q?28ZeXroLJUOW30OaPB+aGXuES8JSDmFLpOylQNJE+10Avb4gILreQsVRS+I7?=
 =?us-ascii?Q?sSD52H7veGjZaDhNzDDZfmaP8sNHwPqDOq4ox056nrGhaVNyg0dt3HvIhDrY?=
 =?us-ascii?Q?s0001wYqYQIfg+8iIQyxi6jCRwQNLQdbBzOYFeJ1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf6a337-bb40-4891-21ff-08db86ab0c47
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 09:49:01.0027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPsm6xNrfRpmgRRzKMPQR1RcL8eZ89ExGwt8wDsiJvapWqCpOi5vaZ3y+Sdweipcg2XvIE/xygX+2KhH71c1AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Simon Horman <simon.horman@corigine.com> writes:
> 'make htmldocs' seems a little unhappy about this for some reason:
>
>   .../ulp-ddp-offload.rst:74: WARNING: Unparseable C cross-reference: 'struct ulp_ddp_dev_ops'
>   Invalid C declaration: Expected identifier in nested name, got keyword: struct [error at 6]
>      struct ulp_ddp_dev_ops
>      ------^

I've fixed all the warnings by turning

    :c:type:`struct foo`

into

    :c:type:`struct foo <foo>`

Thanks

