Return-Path: <netdev+bounces-12674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF08738711
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 16:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E472A1C20F50
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 14:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3211F9DE;
	Wed, 21 Jun 2023 14:33:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E471218C1D
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 14:33:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2128.outbound.protection.outlook.com [40.107.93.128])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B081706
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 07:33:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKJhSOmVuEGTaznAnCm8p1ohIf84npGRf3kWXye0iO1uFaogZeZJcdBOyfLIUwNMn7aS3eUGM6VdCZd4zGJNh3a3CguRlU4fjpK9P/SJrYpkkZp6yHeTu7txnvO/IpLQRT2/JQMSv0pWpdphcIM1ADUzJEJmyxRhDJxK2yavnxRQ4Y+R5dKXCwyAq9ruAKUP7xuw5nW5/YoiA/JoHBQzEFqADEU8Nwugr5r+Ezjgl1VrEEsGyvladGH5xTUEv2RoTbesMihI/yMMif/Nu+VOy9m+M9JVLqYrL5HuUJUPEInyXO01fZM8s4gTrWjxJBNTbPo4HlkcHGKus0tmIAXJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPB0OyvF5uoASHZuBKRUgRSZe0ax4SyvkFo4/0SnYCk=;
 b=dtDycaobZohSPrg9/FCzxPdWuzzm5D0hWoiEBr1JI0qNqqJ7ejzgLrcPRYhUU/zoowPzaADFbDORn8SRyqY27UeQ/i3NKJr1xS0F5oqlqYKb4OJA0Jl++GRRXPGTk4RGxAc4TsKismd4KK2jgwkMFfA3RkKBMsxXNa5my2hY53ENPokq0BKg7WeyfwZI38GJmx8dZaLkNW+91cq7YWLPLWHdpCmldOC+rzuXq6+nDFkfuqCQIgN3FQSSWA53P1wBTLmfJiqB0+e8SMVUEk+4mhlgeZnkO9U30EGGCJOUt5HZLwmFjCNaIyWFSbj27aaVXJSSQfNQ/4VdmNju7TdXpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPB0OyvF5uoASHZuBKRUgRSZe0ax4SyvkFo4/0SnYCk=;
 b=CN0KTW1i7mtDhz8hsdjFIJice+CZGavkdKYzblcdBI4e5YqtlC37TnZJ+aBw2zrVA2S3usUV+IIKN57R6u/aIJWiQu43AcjiMuJby4Awbb1jqgV2a2hMO1K6y3jJxUbbs27ARI+SY4apTr65k0mDyLPcIduS5wxBq48fTlS5w/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY5PR13MB3715.namprd13.prod.outlook.com (2603:10b6:a03:21b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 14:33:52 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 14:33:52 +0000
Date: Wed, 21 Jun 2023 16:33:45 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH net-next v2] netdevsim: add dummy macsec offload
Message-ID: <ZJMKSUixulTv1+xg@corigine.com>
References: <d6841a34b9d69af9ad5a652d5cabe3927868d3c6.1686920069.git.sd@queasysnail.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6841a34b9d69af9ad5a652d5cabe3927868d3c6.1686920069.git.sd@queasysnail.net>
X-ClientProxiedBy: AM4PR0302CA0023.eurprd03.prod.outlook.com
 (2603:10a6:205:2::36) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY5PR13MB3715:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b7136f-a052-4652-52ec-08db726488e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	plTSGbO9S0WsxVC7yGrkvvGIQ9nYALpVxXcwIwidd54dy9Pus89qR63ZbRL4ia1lHTM+KK8vSuKF7r64nyWlLMNwvHz/VE2BvvrXxItHYEyy8gJ/aLZeuBWXXmy66POgf9Ljl8WwIAlCUCfhBSk5YdUZfz999VSJ/qRzavc2RRfseRiLj2jNev3Xw3y1wurhtijLQ7Fa2+qQSYmQ9MFiV5xVeOCqwYhbeIEY3Vv2mibBlWPoa8NOn08kBweIId3oobRp0yNGym7uz1g5ZIXXShTBbFMb4b4DILXupuahR+k2T2DVmYsyzEW2hAhi7peDChqD79K9jk+mrarmjhFiyitdiOMfq9hJJ554fpbiHR+juPBwdG5xBiHqYNAUbf/0ceZrHubq7HyY47Mq5u8qfzNaQuJclXRqxqMbpieSbU6ZFEuXTl/sQbwwcX9q4yv1HKTeaMNYcFZGQtgKZoqdl1wF5+ZebTj0YvFSdEKqDDxHrm/DNiYOSHQCEYQHYxlZO+/icE91T3wWs1ANIWu+JM4Q+J9gc5VFebbOahfOnRWLEdxUexYlewLZ100UMuRPfeMlEtqVwFrBCBSCS4UqcEpr0yDhCa0banxt1jPnbMuFeYTdHFAqSZ9tWBNzZp9ExPtNe59tZOyqgvmlsyTs3A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39830400003)(366004)(136003)(396003)(376002)(451199021)(36756003)(86362001)(38100700002)(8676002)(83380400001)(66476007)(6512007)(186003)(41300700001)(6506007)(316002)(2616005)(6916009)(6666004)(478600001)(66946007)(4326008)(8936002)(6486002)(66556008)(44832011)(2906002)(4744005)(5660300002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l5dhTFe7lYTTMGup2JUazV0Y+XnvlwzGyI/QZY96IuXuSv94sRY8Atdald3c?=
 =?us-ascii?Q?PlqulcgwdSgUKf/T5QOgPFZs6rMCp2Ub2zmVqkUofaGfvrA5ACTNVBKjeBqb?=
 =?us-ascii?Q?qUQcpikcpoYwZsCMR6XfIqjhWwZKZ40gDyYYF1jKTj0p/1kYxCaDMUdN1QO6?=
 =?us-ascii?Q?NHWZTUiJzPjJoW4ujZCXWCJzdlPc7qm+0XEGd7vKcNkCE4975UCmY1bz8b1M?=
 =?us-ascii?Q?HaT8qxm1WHFPatIFmPUkHQH757K54mqr+4Mni5w+asiwB1ejddLdBj6TsWrH?=
 =?us-ascii?Q?dlYwKpAVmS+ukX9XR/w/QxZvT7145t8StHo66R7wl07ROEZx3In6PvL5jgNK?=
 =?us-ascii?Q?d/+wS1iX+vd8bP6orlHtml9HPo/leJRbCEDlcFUaj9BhxarhwN3gqXDR0wi/?=
 =?us-ascii?Q?nQFz5x9dPUmT5H15v1d7VxfDfnmWf4ni07rAfaSP32HYU6ZrOerR9warNKNp?=
 =?us-ascii?Q?7mx/RIiX/pawgVoQc/pv1wF5WyCkiURhc56/5pYGaxSXcpk3bqXAVmgsQkg1?=
 =?us-ascii?Q?CCWHDV2E/JwMDz9jBZYKYsGxp3s6VVE9TaBxrTErt0TIH4UrzLNUwRjgWZRv?=
 =?us-ascii?Q?kAtPcgVyTQARy3X28RSGG3EOI0zTXKhgmgTGZX4GXvlUz5tYHJN8k3Q2w4Oc?=
 =?us-ascii?Q?ux9HxPlfqD0KMZ8bNjqwnVuOW9WUSqzAVJEKkmXeHqK0lYFnGXIdN3HknOJv?=
 =?us-ascii?Q?Eh87C5eyZXw090TTrzwtb1t63T3rhTlU6D2SqXvE02Pa8l2RB2/SdgJ140Zu?=
 =?us-ascii?Q?TD8rQC8gKGP2GjaXtKIsZiXKqhdujI96k/YXWHT0ySwse6KaN2UQdl74oaDd?=
 =?us-ascii?Q?ajc7pmSOupWtS1G7h6TN2LlprgJYzoBu0L0opVIqp0sOO6Mpb0RgJ9wuXyQ5?=
 =?us-ascii?Q?ZR14p7l1UVIJpdqgfMSkmFxqqz78ZVkwgMdmERGWqMu2xbe9ARgSZm1yWMGM?=
 =?us-ascii?Q?0wu65olPaCk/5X4BkiuymmULog70+AAkUspM3uyuCMLJcxowmAqbUA8T5RWL?=
 =?us-ascii?Q?nBvnB7L81xZe2O78jpo48XBjW7ZhGK8N6ZHDthuCFrFG76TmXd/ywpmMoJqk?=
 =?us-ascii?Q?qoPOxNZbJZ1am71Ts0L6pDn1WPxjLb/VaDl+ZJ4IgqsIcpk8ex+lumLGa32/?=
 =?us-ascii?Q?mQPN2IRkxEB3lM5BeV4hcxajHlrBGzYDTE/YaaiCovQE6PY03ZS5RyeXMSpW?=
 =?us-ascii?Q?d2FFOSxV+4w7qoov6Q4JguI9Z0MkcqfAH+FcIOY4QJIaiATAfOmvBkR9kDjv?=
 =?us-ascii?Q?EWqVPU0JiLX5f/lPbdYwBQJz12UeuiVwqMWG6qLFrsXGs4mZPtlgJ1XJgZJz?=
 =?us-ascii?Q?1JhWTtDr2qyljLsBrOb8BH2yroeB+k+pgoXGErxKA5xP+Vddm1GkC9OADwNH?=
 =?us-ascii?Q?Ze/n21lb7Co6kTYUJ+jJBSTSbVrP4vIfs+2sCThC4NN62M+zUdriagE70VBV?=
 =?us-ascii?Q?7rF+gxqul57/S52J0S0Ai8HTwp6fmt8U1z3HzwfFzLKin+0FUiOna5JA/gXD?=
 =?us-ascii?Q?sD8sNIVsAaEIKwDQISCQ2smv9gWcQ0d/F4zYcgo/oXq8A2LHJgvtN98Ch8Kg?=
 =?us-ascii?Q?Qm9j4J2ZVj1142F+U9H3Y+2qyTyxLwyREQmQTkttEwWabVjDzmXtwjGv0j66?=
 =?us-ascii?Q?P1hY7NeTSVGrbR/dRXLYuKDvf+J7MoL1qT29TQ2xELZRDpR5qSg8G95oZWBL?=
 =?us-ascii?Q?p3taRg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b7136f-a052-4652-52ec-08db726488e4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 14:33:52.4494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wiILNb/hncXfyv8zP8QOo8BCqXVeY8QuqwC3om6ocOG5yly9nSQR7fLT8Hsqtp1R2wcPBcRDRbbSiJv+vwB3p9+Z1DB+4yhWxupZGDaqqRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3715
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 03:14:46PM +0200, Sabrina Dubroca wrote:
> When the kernel is compiled with MACsec support, add the
> NETIF_F_HW_MACSEC feature to netdevsim devices and implement
> macsec_ops.
> 
> To allow easy testing of failure from the device, support is limited
> to 3 SecY's per netdevsim device, and 1 RXSC per SecY.
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---
> v2:
>  - nsim_macsec_add_secy, return -ENOSPC if secy_count isn't full but
>    we can't find an empty slot (Simon Horman)
>  - add sci_to_cpu to make sparse happy (Simon Horman)
>  - remove set but not used secy variable (kernel test robot and Simon Horman)

Thanks!

Reviewed-by: Simon Horman <simon.horman@corigine.com>

