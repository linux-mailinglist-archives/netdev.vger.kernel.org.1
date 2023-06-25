Return-Path: <netdev+bounces-13805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A9F73D0B9
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 13:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22897280CA2
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 11:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66932112;
	Sun, 25 Jun 2023 11:57:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AA81103
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 11:57:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C95DDD
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 04:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFlP9NSduD2MVoZhVxKQbSAwWT/hh8XDqvvOBbEwYm9dzV/VfjyKKKysKR7Rygg2r3zt08Q8tTI4E+klbYbrKoXzukmSd9JK7kW4rXorR+vVczejFOKbU30S2CPoyfoqKYYztX//QHiub67Tj+R+huU9o0Qm5UITi7i8LFQNaZn3V8drlcfsRtwF8ronxKkDFz94eqnwAkVIOIoZJraBAjAFiyG/bZPFXprVfoLMPsWQpStWZZyVxaFlP+tjb8XntRPFwa4OtRB3uUSIvYh02Atqx8fzlyXOU/Lj438YwRJTBRzN7G9kJ1va6n+k7e6j+h8ne7EZx4cR359mxCuFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zg+YzOifBTY/KU2PJ9uTW6GhJyDCmtmp4xQlsa6SKJc=;
 b=n6AnHIt9Ly30INtHYNVw6z1ogzt9/soq918+xkhMqueJQ3h67/9/FIzBEKWBgZOVj/JA2tUc9E/6/m99KylLIXaM6agYguXCuIbdgm2j0IUz2sljA01ZlYMP54b9Wwh9TznkILfnuqGde75enXOd8kh3AVVQabg4tlPiuZEvXDhNB2NmLTlNaIQ3mfmNokH3ecVEVCuETaCV082h4WzLJbRD9bsB2b3yWsghnNiIz8TUPJzjsXwBFpT465hRdAAaIFijSqUDkphqBW4g521sptXEiAypBEalRt+0U0aFQjUeXCNAX3qSRlvCdma0ybcJNpJh+iaKRFFrMen2T4YthA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zg+YzOifBTY/KU2PJ9uTW6GhJyDCmtmp4xQlsa6SKJc=;
 b=aGvbrCpxixSX50wNaaAKYeq4GDOTzO5uq86x0BCVnEgjoMxXpE1ApZmsLtadxkFP7MmPGEWRTpDc2iXnoUp2B52eRoLvBgYt2aZxxgRpk+GHKCTtazSvGTB52HIPdLQGNm6UHbLk3r4Iuzo7VLfnSJHsDWGULO12BxSqz1JaUwj3VPQu4V+IRaRjlJyM/jlHmeKPNwMMLQu5Ym/VQFp0J5S4mJ5yxwULS7rC19CgFfUR6v4blJ87p8hkf5TqIIw04DSIDA1sSmU1lFmY5YCTRCDjoUcBNC3KDqFXF7jKN2pdKmv7Rhdn3bG7zmzHvNo/lze4u75oK58mFaXzUSU3Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by SJ2PR12MB9006.namprd12.prod.outlook.com (2603:10b6:a03:540::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 11:55:42 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::66d8:40d2:14ed:7697]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::66d8:40d2:14ed:7697%5]) with mapi id 15.20.6500.036; Sun, 25 Jun 2023
 11:55:42 +0000
Date: Sun, 25 Jun 2023 14:55:36 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, petrm@nvidia.com
Subject: Re: [RFC PATCH net-next 1/2] devlink: Hold a reference on parent
 device
Message-ID: <ZJgrOAmhIycWSKtU@shredder>
References: <20230619125015.1541143-1-idosch@nvidia.com>
 <20230619125015.1541143-2-idosch@nvidia.com>
 <ZJLjlGo+jww6QIAg@nanopsycho>
 <ZJMYsyw06+jWVR5i@shredder>
 <ZJPqS0Di6Cg9JT3D@nanopsycho>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJPqS0Di6Cg9JT3D@nanopsycho>
X-ClientProxiedBy: LO4P265CA0052.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::15) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|SJ2PR12MB9006:EE_
X-MS-Office365-Filtering-Correlation-Id: 2708f65a-a548-4f6d-2406-08db75731a3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8H4umkVPymWYtw7Al0bGGJivahPKZS/SGlc3Fyuv5asYmEfiDv7CHe51PWZJk0GDoEDiYSxAmFy59iVw/f/KhNixB9oeVhI+LKgmQDwInC87iWn0nUgfahmoTSuyBAs6LIpEgIKy05yy+rdE+ND2AArMzDnFtiPTyBYHrUzBfcFVNMiRJxPgxxz6oJuztpjtdLBjm+XIJCltaYXQdrT0GTPSerk3CD8ENw/B6D7lkrJghTDzkJ0rLfPTNkGk/hh1p8KYbaV+xMnrZzHrW0iuZ2Ud9yPTZUaKSbYy7BWJ99zohkLKlczhD8Wg8Y+qKRzUFeN5WAOUD6NnWI2u1qu7Q9XMwARUStPpzXVZ6lpUGaQPO2ZqyE3P35C31QOrjnaTQk/av3KGLAGFjP3aj9Eb0+JrO+icchqEjgZEtNqI4yPch+yZlgmoWsCd61V6CRkHoiVdy9va4cnpC56i7JzOoiIoIxu5qXw1uJbVTcZVUVAbEmk2GgPNAR1z7sXtxavvS7IBcbg5+3IRgXzIUh63vaGtHIT547I1IWd6NaB2H7h7NKQigTAO7sfT9R7UHb//
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(38100700002)(83380400001)(86362001)(478600001)(6486002)(33716001)(6666004)(41300700001)(66946007)(66556008)(66476007)(316002)(8676002)(8936002)(26005)(6916009)(4326008)(6506007)(6512007)(107886003)(186003)(9686003)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oYn0YN3eQ8SVSXNJA6XMfQ0t2x0gL7WYX/v7pveAsj3hWJopIkYKjS1D23B0?=
 =?us-ascii?Q?Nh6qwdWj78852i/yUQEgmA2a5SFQ3ptalAc1Iu9k3EXkyKceNmiVqcb3mUTt?=
 =?us-ascii?Q?rOCd5zoBwOUd8J07NDn07cA4y6Soq4+SXMbBvF4jr6S6CwEA5KUBnsRzJXE2?=
 =?us-ascii?Q?JZ9Q2AXyPcUEU/nbBhc68kbue3LXJuaapSQsxO3Y3ypxvhqGBNn8yO2pmY1v?=
 =?us-ascii?Q?Vb7TIcjdw2Uf03UaY+DjO0q7GvmbvriL3fouI1Bjv8Tw/IX8DOC2WYFcxWwh?=
 =?us-ascii?Q?gNGko6GupcALK/uzyrPDVsYbm690+l4S6aOnYbT5ZfCp6M7OsIZ5bpgf4aBK?=
 =?us-ascii?Q?Oht9T2HvVHYSPv+k5Ysb5A2Psk9sBENpvvAyWP1nnPmB3+EVBbuGF2fKDh/9?=
 =?us-ascii?Q?cBXeqqjqUfK3WTJ1qj4+6jmexRuRyZOXX8Qx8sV8l+dRcZrr7HSLd95+NExH?=
 =?us-ascii?Q?soyPwSX9Zt94mX9yKywlGpiTUyoRg/3CzvegCFfKPat3AXkPdIXRg0AQNJRX?=
 =?us-ascii?Q?7aBVfLcff//oC+KgLoXWi25R36qJKjytreKk5b8AB8c6mhkjOssvy7Q7FJcm?=
 =?us-ascii?Q?/QOt8KuaVlohDPNLwIdqWS/DB6HJztP7Wv8X7q1aMRv3h84cIkzGlgbVxroA?=
 =?us-ascii?Q?/LVBuFYvZPuZLNT8vFYVdSe3ndK8/UqEyX5QAiP2frFvV3UzL7vaENSTpTxV?=
 =?us-ascii?Q?bN5OOFEn7dPScvy5soF4owA08g+3yoBkDaNhAHj8i/y3UL6BKK7m2D2NC0D5?=
 =?us-ascii?Q?zdvkib/C/JcTvL1rKQcquxWC4sVaho1qsr/RZIiFQEdTymL96XCNXipMbMPR?=
 =?us-ascii?Q?ZTez67cUFxIkesAF8WLl91/Xo8MR3TzfVaSSCfEyYFHWwiNg/XBaahgeEyN4?=
 =?us-ascii?Q?gR5HBzfbrzqbSl0O6/sYhJ70/8a135yYAz2cjo9yhK0rHF16D51S+6glzNmA?=
 =?us-ascii?Q?5ISqk2pBgUMeL0G1oa9Igb/V32W10zMltKkwHckzEJbAtE7bXbGOhjU3E9ve?=
 =?us-ascii?Q?wLf2sLT1zWOrOWd4KW8pcKpWiBMdjyEBIiVuqd31VPCwwr9P7Vk/hPXwmboG?=
 =?us-ascii?Q?K50KBnUnEVriajNp5TA8u+iVUTII5v51nmaKE6xEDlTDFO9dQK9S3o1c63qm?=
 =?us-ascii?Q?f6k16bMhsgYIui+CNfchs5YHouL1g4PKqXNPo/J0N5779oDCZPpEjaeBb+9z?=
 =?us-ascii?Q?ZxuUh0JyqvqOz2qayBdZc3AsXNAeWBfjXvGo+YFehRu4Ez9rsJ6lADtrCGn/?=
 =?us-ascii?Q?KE6yGzR3nbUvebWnioVmnlilr3lLjFexu0WKxL6SJ2lnUScBRrAh431OSM/0?=
 =?us-ascii?Q?S/SCljwe7udbhiY4YgAI1rBk9gxBDu80GD0qUKdhhyB75RJ6mRPQ7qnFaqEG?=
 =?us-ascii?Q?ZIdfJOLnfpMNuV4gATH0L0ZS3P6c6Th4YNnhBqjpLeqULqHspWqnVevrgfvs?=
 =?us-ascii?Q?fvni5rocnQY5v9gMYYdKLJ9vzH6zbjjeImI5SHsM4fe0i92zUoY4Gu3Yvlfy?=
 =?us-ascii?Q?d+xh6peRxOu68orNVicN16VijOJN29RN8FhQCELHkpXCmLT0i6qAyf72epG/?=
 =?us-ascii?Q?bsj1d6cxwAIlNTGPRIrS8sp0atjDFWIGU7Yw8ujT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2708f65a-a548-4f6d-2406-08db75731a3a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 11:55:42.6261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0tczQm6aDhKCGfSUgwPC/60osRgR2ksxRKbm7XumGfyHX2IMbu1XcmheJ5MvnYmCUcRZIiHB7ihSjUiVC6G8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9006
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 08:29:31AM +0200, Jiri Pirko wrote:
> Wed, Jun 21, 2023 at 05:35:15PM CEST, idosch@nvidia.com wrote:
> >On Wed, Jun 21, 2023 at 01:48:36PM +0200, Jiri Pirko wrote:
> >> Mon, Jun 19, 2023 at 02:50:14PM CEST, idosch@nvidia.com wrote:
> >> >@@ -91,6 +92,7 @@ static void devlink_release(struct work_struct *work)
> >> > 
> >> > 	mutex_destroy(&devlink->lock);
> >> > 	lockdep_unregister_key(&devlink->lock_key);
> >> >+	put_device(devlink->dev);
> >> 
> >> In this case I think you have to make sure this is called before
> >> devlink_free() ends. After the caller of devlink_free() returns (most
> >> probably .remove callback), nothing stops module from being removed.
> >> 
> >> I don't see other way. Utilize complete() here and wait_for_completion()
> >> at the end of devlink_free().
> >
> >I might be missing something, but how can I do something like
> >wait_for_completion(&devlink->comp) at the end of devlink_free()? After
> >I call devlink_put() the devlink instance can be freed and the
> >wait_for_completion() call will result in a UAF.
> 
> You have to move the free() to devlink_free()
> Basically, all the things done in devlink_put that are symmetrical to
> the initialization done in devlink_alloc() should be moved there.

But it's a bit weird to dereference 'devlink' (to wait for the
completion) after calling 'devlink_put(devlink)'. Given that this
problem seems to be specific to netdevsim, don't you think it's better
to fix it in netdevsim rather than working around it in devlink?

> 
> 
> >
> >> 
> >> If the completion in devlink_put() area rings a bell for you, let me save
> >> you the trouble looking it up:
> >> 9053637e0da7 ("devlink: remove the registration guarantee of references")
> >> This commit removed that. But it is a different usage.
> >> 
> >> 
> >> 
> >> > 	kfree(devlink);
> >> > }
> >> > 
> >> >@@ -204,6 +206,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
> >> > 	if (ret < 0)
> >> > 		goto err_xa_alloc;
> >> > 
> >> >+	get_device(dev);
> >> > 	devlink->dev = dev;
> >> > 	devlink->ops = ops;
> >> > 	xa_init_flags(&devlink->ports, XA_FLAGS_ALLOC);
> >> >-- 
> >> >2.40.1
> >> >

