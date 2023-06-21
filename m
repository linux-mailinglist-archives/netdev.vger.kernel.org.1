Return-Path: <netdev+bounces-12700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8CB73896C
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B278281632
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D661951C;
	Wed, 21 Jun 2023 15:35:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650CE19506
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 15:35:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC8C1A4
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeCbqxmvuby8JCLRAlc8l9S/xqsbiNX8jzgqpLdnutcufixiImVKRJ8bGVYf50OdVjlyectPMXSVSvRUjwKsJECSNyaEyafgQ4T7EJ+ecVZt/gCJE7RFIkpI0GSCTYPubIaqXzcqvO4l0EAYn5i9pcyxzRAM7qefZZEnNasC5hL83MFkZWolK6lgbP4uiv9VwTAi6reNsTjVE+QfZZaWzF+EJah2ZS/9HvUY/812yKCl+O46Q86tnusNqt475UctK1puIqWPdi40+Z7fY7jhjWTOlw4cAA6PDb/uAYG4kbV0B/c9InXgEafgmocp2fMtXaQ9wuAEb0MGccevjgxDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SOh3bVO11DCUcEDH9eq04XlcnthGUN3f3dFQIkXT5E=;
 b=UnTrkQJCIzmER6mLC3OsfXehgaRPKcPUAevQ55jA8X2S+75bPxoeSKq9Q/Kxuqz1naTm+simBAvpZxYuGfrFcOyV0ZpuvLIWI7OtAfB8/nAfZ1IlKZeMvosD+bjcNUSD11GlfWRoJvb1jVNYC0X7PeTiB2FF3HFHJh/pioHBElbMvX476rAuY1L1zR3kuyytELXwkJxIiXcUvLYJGli4JE/pvUG1qnl2QnIkOkpEozWhyshvedEU4GmEXgWHnjpq7RaiWizjldQLhM8laTzSuYugZdNetwzNd3Jag0ywgEIO+Mrcjtc4bWGFrupVaUJC7VRqttDVaetVpU+kIQ2Fgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SOh3bVO11DCUcEDH9eq04XlcnthGUN3f3dFQIkXT5E=;
 b=IkUKAyRjWGUqEq/kXiFvWRVQ6aOFKFhDzoUi8IhMiwl3bywb3AZ/IkJMBM+zmEShNVTkhzJvOrTuev6BfZ41pwVrVDjEhSmo65XBDDUPIJbnaYs+dSX2TN4mi6qD3vfsa74dM0qgRKokAPeUbYeR408kM4mPp3Ml+BY973TX9Z6a1E+wFXYauqi1bxaTuzzfs4v+QtUzii2Bxq6Uy7DX6YBlDtUv45ExuDTa01ffl0sjjw/3277zD7C4PnkhzznMP9n5n4E4fLrSMj96MGfcV/NfYdIFxu7iQsnn3mev5u6Qs5c5WNdVf3PqYaGfrOJZPyaKL4AS30DmujrEfQGitA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by SJ0PR12MB6854.namprd12.prod.outlook.com (2603:10b6:a03:47c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 15:35:22 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::66d8:40d2:14ed:7697]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::66d8:40d2:14ed:7697%5]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 15:35:22 +0000
Date: Wed, 21 Jun 2023 18:35:15 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, petrm@nvidia.com
Subject: Re: [RFC PATCH net-next 1/2] devlink: Hold a reference on parent
 device
Message-ID: <ZJMYsyw06+jWVR5i@shredder>
References: <20230619125015.1541143-1-idosch@nvidia.com>
 <20230619125015.1541143-2-idosch@nvidia.com>
 <ZJLjlGo+jww6QIAg@nanopsycho>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJLjlGo+jww6QIAg@nanopsycho>
X-ClientProxiedBy: VI1PR08CA0148.eurprd08.prod.outlook.com
 (2603:10a6:800:d5::26) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|SJ0PR12MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: c123662c-21ae-4808-861e-08db726d2073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/yCN8hp4yw4L+mrEF9R4h/54gMdeYVzQTkhHE/RZUBXXy/vg7A913jin02edkccQv0/3f8Rev/XKS9Vp1kp95LnktUKhnzg1mw/7xw6IlnP720ZlzwvlUXvW5kDgLJF2eGJus5fz3hSRAkPpGx2MpQsdoZ/H/w2seq5ExpgwBsvhrErCxCsY2ATX76Z7nB1caM9e4E6qLNyh07Y9nOGky0l6JsPvAd+9xr0ybHAoH8BdunvXR8UWMba1bh3uicqXi6Dit2V4wGsLTxC4G3Gj4fo3SEYpRsLBYZTYgUle0OXKCGpKwx3Hn7byghTfWddM1d8zQ3aAOaUD7rpF0es70ssxGINpxRat8MhxqMPWlnR7VgAp/npyfPKovc71uZ0/qdAfXg1faGkqPLDGkrYAVGmGs+hbdwg0ppkeMgC28KgaatnoNURVi3g569uEos4mSVbJtuGaGMCzHPolBvBTzo3DdDgOtsR2YDPfTixhLfxGH/xsimiEAkTALXPlTytD/fPtQPb9UpBjMSXKLc4SHbuGkvbID+OJdN8xGw8+AzZaIJ9AELkCKwJKB/f+t5p+C1IPthZ1q/sRaANrU1hsVnH2lZ7oFvQZ0fgY4H2Ze4w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199021)(26005)(9686003)(2906002)(6506007)(6512007)(107886003)(186003)(66946007)(41300700001)(66556008)(316002)(4326008)(6916009)(6486002)(83380400001)(6666004)(478600001)(5660300002)(38100700002)(8676002)(66476007)(33716001)(86362001)(8936002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XNkwt2+C/NftJbhdzjJRcGO647bJy9Fmb4ZYNw2fcUOyMiGKqnAfHZAESPfk?=
 =?us-ascii?Q?6GilESiurpMlmJJzsW0RJY5tU2qRtBYTuackNTGF28N355EIEs8nds868LgF?=
 =?us-ascii?Q?nlrnGg5K7j+nXE9nnOxQgMKN2lvJdZD/9OH9WHLo2YXdXURsQB/zMslD0WoU?=
 =?us-ascii?Q?LvAfIFWqTpRpXUxHupIKhw9UoWBzlAk/WGoUp1La7TV+f/Zw3VtCkpYIERcb?=
 =?us-ascii?Q?9KJYcBsz/WHufSM36KaekcAoj9Dly2TYQ1c/zEWrbClYL0NSWCSWYJpNfOJv?=
 =?us-ascii?Q?9f3EUN4bfteq++ICO6Za3pYmcXH+7XOXEZNGSWCFSFSYYqIouKJctJq9Ft/M?=
 =?us-ascii?Q?qaP1INwfNNx/zTh2bkcBJsEkwvYZu7/JTfrPSiY5BKSlcPKdQnfyNdVWwLya?=
 =?us-ascii?Q?+FDczC1SrtLU/PhmopWBfKC73h8gkepJ1JL6cNxTpWlGYiY9gVXYJ/vzdJiO?=
 =?us-ascii?Q?8D9cH8tMuJKDH45TA7MGMyS4IjkeWxf6AIVpkujQis9DJKXKLMWKHIqwJx8H?=
 =?us-ascii?Q?dFRCoMwXN6LchjdxBYH+AA3ZHJsInwD6Ux4Vl8oJQqhncNM9AG0U/NtxCgqT?=
 =?us-ascii?Q?6Nm0SD9krGMEprF02wMRKggBTcEFq+ysUZHyWzmrxcEOy+V26B2PGVA2iWb5?=
 =?us-ascii?Q?09ymSsF0QKb6SZ799ZydudyPZMjwR5MSCDguoMxtIXIz5UZB1qvlc/p1iYE5?=
 =?us-ascii?Q?Uzhl5lVnNqBY00XJiRkVzGuahreRSUCBZZFN3cRgSIx0cwu6QzWzjxFcmFdV?=
 =?us-ascii?Q?2q+kBn8iDzz24Bpm3MUXHpQlY483DIpLhpFnBB1oRyTcqakA1ntpKItBMmfE?=
 =?us-ascii?Q?ltgNsievYr9+ekgdkgruuKVKh/xM9ouZcpQYuRkPx6+gxYwgHk+Dz/qDN4WY?=
 =?us-ascii?Q?cClz8NxfGWvNLtgQu1eWx2oFnTsZ2IVchCFa8zVUCYDWBVNVfI7L72Eu4FWS?=
 =?us-ascii?Q?OrrkDUgBSU/nYZYY2RHK6FCx61CZgonvBBLw2rAKBLY6RB9v0OU16qBND0gg?=
 =?us-ascii?Q?AEzFCMizTXFwMh/qbsdx1iQc2phFXgTiCq66K2jpH2IyA0apCjNA33xwlrTV?=
 =?us-ascii?Q?/ZqS8UTL7G5R91HVIELHhNeexs4pGR0J7pSVSa/hq9Ng8wqPXCO1Llsjql2E?=
 =?us-ascii?Q?N+8nBugrCHmFo1HHxY7oGzN3ofDFbetnQrKnpE6dfl4jqyTKIhkAaiu0E9dA?=
 =?us-ascii?Q?GHe36eEZGKmSxbF2os039lDZwI3UrGbCfW6OyTOVF9xp/ZhBazZarT3aOf0d?=
 =?us-ascii?Q?WulsAsEBzwKxAnUqadXAT64kx1aHsz+MnF4WlHxE0d7Lt2YuUEqInz+ntW3Q?=
 =?us-ascii?Q?ApDtwwCuHuqUl5I2J0cBZtJd6vBtAKSDVtCupPpR2SiIQfhNgqddrMiY+xso?=
 =?us-ascii?Q?g+vozJVHVCqH+zxhU04r7KlEaHyDixuwoSpWZLjJuQDwtniQrf6flzSB1n00?=
 =?us-ascii?Q?OEoUUw9oULKExMLFkv2qgvmKWXfJVkxYElpF/McCU4FJaQ0jFzeCe4SR0gF9?=
 =?us-ascii?Q?4zQIAgndlYgaFHnn8OjNuWskRydxPU6DiqhZrdvHVq4tC/+SGYsVY6LGz/wL?=
 =?us-ascii?Q?HyngVNtXFncrCK40s2c2+CbZ+L9wf29XQ5jxMxZ9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c123662c-21ae-4808-861e-08db726d2073
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 15:35:22.6167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8eukfLGvgFGXtWhl8Mu6zfx40Su6dkQSeCZls797Sxwk0YW5+gNM/qnzeAOUZAA2PWeYBAQJBScHLbrUNZFPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6854
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 01:48:36PM +0200, Jiri Pirko wrote:
> Mon, Jun 19, 2023 at 02:50:14PM CEST, idosch@nvidia.com wrote:
> >@@ -91,6 +92,7 @@ static void devlink_release(struct work_struct *work)
> > 
> > 	mutex_destroy(&devlink->lock);
> > 	lockdep_unregister_key(&devlink->lock_key);
> >+	put_device(devlink->dev);
> 
> In this case I think you have to make sure this is called before
> devlink_free() ends. After the caller of devlink_free() returns (most
> probably .remove callback), nothing stops module from being removed.
> 
> I don't see other way. Utilize complete() here and wait_for_completion()
> at the end of devlink_free().

I might be missing something, but how can I do something like
wait_for_completion(&devlink->comp) at the end of devlink_free()? After
I call devlink_put() the devlink instance can be freed and the
wait_for_completion() call will result in a UAF.

> 
> If the completion in devlink_put() area rings a bell for you, let me save
> you the trouble looking it up:
> 9053637e0da7 ("devlink: remove the registration guarantee of references")
> This commit removed that. But it is a different usage.
> 
> 
> 
> > 	kfree(devlink);
> > }
> > 
> >@@ -204,6 +206,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
> > 	if (ret < 0)
> > 		goto err_xa_alloc;
> > 
> >+	get_device(dev);
> > 	devlink->dev = dev;
> > 	devlink->ops = ops;
> > 	xa_init_flags(&devlink->ports, XA_FLAGS_ALLOC);
> >-- 
> >2.40.1
> >

