Return-Path: <netdev+bounces-20475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF3375FAC6
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 17:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD001C20B97
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 15:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8981FDDB7;
	Mon, 24 Jul 2023 15:28:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7675AD507
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 15:28:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D68E61
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 08:28:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQ/YxBBJOzMLuqgnz0GmxlD1X8/7YnxprB9r8WLCRhaOVxG9acAaREoJri0cDKHRWUoJIA9jQ0LlRCyT8EgCqpWix7kkUoH4G6CKSXw8L3gqEtZZZT9lHXpnACWY4KZ422WD+awmrJSB/EJF1Hg8slaCxLW7+oiUAQM/1rVNslqqx+AlupZeMfphxGtbdXjLN78G5UCOUpI3M35yz68lkhKVaCEMEKgucu9BpZN+4MPcm5O03bPreGx7ieJ90HXWDXYVPyrVXn58NwUtKL1rYpb9EcO4XQGkzpNnTrjRgHFVWUXn77nmiz0CO9TlQFTsXgp1iRDsZ9Am/8a16oD9Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saaVJH0netRgdS/1Cc8GFdxBmYZUmfmmEYJNa7v3/bU=;
 b=EyvlLygza0VZ0NYsAYZ4+UMisqvPWU9tlfqgHjNDy4w0I9RH60wzfPuwwJX6dBE0yxvXImeBRyelkonLW+zyUsNCby91zSRLWwIpYIPYFgfzujEJQ57R1dQ2OzQytr3x6gx40k7r+kXAgRoyRay00lRI1/WPBwcx/1Fe/a6sn5bATvWofOyGSWq2dpqBIk3skhC0E7EC49zB9KLKVohuTrXr2l6WAOXLTH4T33F4h2eHoQ2LiO69ICET1QfA342zWKW4spVwZjS/xXhMx7OJQOlOBh6qw4QOOUB+ZAiXLgZKP8nnHd3hhHIdb0eLmlMY9Xzq5PpFFddFTknAxSVWIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saaVJH0netRgdS/1Cc8GFdxBmYZUmfmmEYJNa7v3/bU=;
 b=au/TjIDBa06bWkRvU2UbhGnkjZOzNTb48NwfHb1pk87ImL5j3VHJE8llMc+EVy4XPTUpsuYqLlfn5u/pMcLL35P1/puCHzxYMxzqRQB+pzV1XZpEmCb4kmbYn8WN9f2zd+v/ovr7unL7m9ueC+CP2BalKiri6LTJ7seP/5FIdw8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM6PR13MB3785.namprd13.prod.outlook.com (2603:10b6:5:244::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 15:28:31 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 15:28:31 +0000
Date: Mon, 24 Jul 2023 17:28:17 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, mkubecek@suse.cz, lorenzo@kernel.org
Subject: Re: [PATCH net-next 0/2] net: store netdevs in an xarray
Message-ID: <ZL6YkU/ecwI9lL8u@corigine.com>
References: <20230722014237.4078962-1-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230722014237.4078962-1-kuba@kernel.org>
X-ClientProxiedBy: AS4P190CA0068.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::28) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM6PR13MB3785:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a2fc4d1-b968-4eb4-83f0-08db8c5aa298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eIukwHC1dMFLCNA0LUB1cACL/ElQ2/AHILDOdxLweQ/g3jIQy2zqbO5lBKe+ZhT9P5RLhDgP8J5E7Y70wxXMdNpd6u0chBDZ/6v5dNkVDGi4V4FkQbaFHyAnBuSbvxX6V4im48I38VBlySuOYufjG68Db4zCAeUB0S0LvvMG+s0wD+ijuUZmrOx96UuSAGuORknZWT3nhRdpHZUHOVju/0QJ6h1k2eY5G9pf4a11I8MkbQWZEpdbJPuuFAPD4pyp/VrjAtQx0x1/N9+DakIY7K93hZ98+amB6IzwURoUJPZpJ51B7XJCO/2ZxG23EQHfgTSXgZje9BSa1RsNMk9rcgkTzgJPPMAfp9iLShKGrj56VIBQv3qG2sARUEfASN94XIUTNp25bRuatECG8ohd/Z4Svjy/jIM6qjNASuOZ+iaFQOQmuTcoJ/SnvG+bVJN6E1SZ6yqF9/cfTvsko+KiVwZYgNTbT5q9KNxkdXfyCiUVIpCNA0iPXv7wxe8XC5+HrebTJm/GKifSQ8H7kPXErbHTdHpOeAhHAc37/zYFZJ1QJhhYn7g6Yamc3XJR2cFu4woFxgc+EoP/qOVVE9bw0k4hNqqzSdMqBNt0WxXUkPo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39830400003)(376002)(366004)(396003)(346002)(451199021)(6486002)(38100700002)(478600001)(6666004)(66946007)(66476007)(66556008)(86362001)(4326008)(6916009)(6512007)(316002)(41300700001)(36756003)(2906002)(2616005)(4744005)(8936002)(8676002)(5660300002)(6506007)(186003)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r2oCJsf3E0cano/veM5QWf1/OQzMdolUshfAfe3Rs4IMprdMoaR1I+M6IZ3+?=
 =?us-ascii?Q?MC10jSXwR4lOuXN576GbuczY7F9t2060HX8kDVXx0ZhZXuH/EiJN1LebR371?=
 =?us-ascii?Q?AON21RnD70bSpwk9ic10FuU7lDm9uD5GdSkvt2d4VpsylTpajqukycnL0mAu?=
 =?us-ascii?Q?LZJ1F0+9lh56ci9IJzAg7pLLwlpucX89cnZUWIHZ0YTwp/DZvjd9pXesx+1b?=
 =?us-ascii?Q?ed37yJdJY3MI3RzXo2gp8f/M3kib/vos+3kKhH33TY7Nc9lGEIH1dgWW9cYh?=
 =?us-ascii?Q?GhoytdaGHNcnaHfO8BDsrxFMxuPbncWdfiVEs27dTyG8omvY1KbqaNXilMBp?=
 =?us-ascii?Q?ob4G0vPZQQ64uYNH9ChXgfLaapyuf1j6mPkT3tbnt12s4MOBAIXWpGE6cgUy?=
 =?us-ascii?Q?KgkUGHQuwYcyxRRRFWuJY2Ksdt6kSAFDjaBkYy9uC8PEvb3LD5BIiM8mGJaU?=
 =?us-ascii?Q?Qh3GhcOkUXd2JGITi83HTVNG9iWStb9bfFEKEXZLQMphBreumCeTCs0jKXQx?=
 =?us-ascii?Q?29kVgN0RAuMzotuWoJz4mes3TP0mTbJKXss66wERPASBddHewWeZ7lpb9mi4?=
 =?us-ascii?Q?KtPDlHLfOSrcWZUWkHPtaXfFEBkcvkGSOUo1AoakZZ7cowM6TAAELKWZlVxa?=
 =?us-ascii?Q?D9jXY+6Dn8QvjcwqAEpFUtnX7JZm459d19rygcDHTfiV/mzorlo+MHVxv2cG?=
 =?us-ascii?Q?s++mIra5UYWVivDfRez/tianmFfEFXRv48CKWfZXWDQ5vE7hnt6ezD580/s4?=
 =?us-ascii?Q?uTTSvJDpJbFCUWTjk5RkMQ/vKbv52dhpnQYj+C3N3DV0pdacaix5dLWVHewm?=
 =?us-ascii?Q?eKRTUSqKt7ME94l4pNxXOqn2Sp879I1+XRA0QeuUeUrxLojQV2gj2frKvcNk?=
 =?us-ascii?Q?Q/5RygE/Wfcw5e5rnE5TKAyeqGH+widE0DgtZP7iqJARiVQZ2GLBuyYHvKU8?=
 =?us-ascii?Q?l2B08Xa1+nRpfu/NNJo9g2iy6u8vlsvNWb920pp1BXwdOLRVZnY77+fLQiY9?=
 =?us-ascii?Q?tl5H3WgO4adpo2LSLwIZhJPPYOu+0834npjLpY+8c7OveZsjJ7xFt1uzPhX6?=
 =?us-ascii?Q?2v/5YJG4hmjk20ioFmutuFx1TmJ+NKWmPM/inWD3TwbHqklRD4PjbGL4HZh2?=
 =?us-ascii?Q?iuIIO4LLvXXpbPYHt9xOjX1P1yfSTTyQl1/IsWrkdtpji5N3AcZwL1RvVNVl?=
 =?us-ascii?Q?DlfmF07Gq5CsNmxzwKZUbiOWqM8TeX3YnMdVblr2NA+cFXe+aKC6nPUcfOmt?=
 =?us-ascii?Q?Wl5ekFVMEyK8D0y5EN9g16i1oFaUFMNshMRBenXIDgktTL9snl5GVIjxXbJ8?=
 =?us-ascii?Q?in3y8g3nx8AHqSN9U6CYoe8LLVKgADtl+emW+dKqAWDM+MmMl5WtuXjIgEOV?=
 =?us-ascii?Q?Ye2VaUqcO2JisTMwPA4lyRx2OhxiRU37Dnj8WNJxPoT8QYnl3eOTjJq9+E+V?=
 =?us-ascii?Q?umIarikAIsbTNSXm2joCtqA7sGHq26/8piQrY+kz1WNZibEEd9IracXSFJxt?=
 =?us-ascii?Q?ihqOS/hK13IDmGMcGVc6yhLfCCBnRNGyYQzU3pxxDfEGUbKh2YccbC4GpHpi?=
 =?us-ascii?Q?8bQ1LKfaKsGujD5q2arGRkj8jPOWvBfpYysd9q7iVdhq0ZV2WsFYV9wAbsfc?=
 =?us-ascii?Q?1B8TlJKCScyobMDRo3eA1+h8zb7yxxWAp/xijQ6OI14T3+Lr7pvedXNE+vb/?=
 =?us-ascii?Q?QdtjDQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2fc4d1-b968-4eb4-83f0-08db8c5aa298
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 15:28:30.7758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zIsnTXlwWGvFu/q9M46laTJ7TP3b4KhgwPZthzTaYEsxFTUo25/kOOi2JqDvx67MsrRLAlHkc9Jo3SJgSDgBNyDtru+n31rcrmYq52Er4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3785
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 06:42:35PM -0700, Jakub Kicinski wrote:
> One of more annoying developer experience gaps we have in netlink
> is iterating over netdevs. It's painful. Add an xarray to make
> it trivial.
> 
> Jakub Kicinski (2):
>   net: store netdevs in an xarray
>   net: convert some netlink netdev iterators to depend on the xarray

Reviewed-by: Simon Horman <simon.horman@corigine.com>


