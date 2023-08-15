Return-Path: <netdev+bounces-27727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EFB77D064
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 18:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44B3281388
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 16:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885C7156C1;
	Tue, 15 Aug 2023 16:53:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7600EEDE
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 16:53:49 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A8910DA
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 09:53:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4hxZspqGyvZkRV1IryRSrnkC8VKa3QnyJMLBd9pM/fSLKb+tmKCGk+Nx3wruMDAmpfGThEWkcJnDs7zrRqC3hdgnOIeHXLVkxaq5NeIeXULJMVpIWOt4fbPHussLRApJHI/PhpStV78GsqKDgyOsyrRlEYpH2qn2SXtyUsam3uSqTJAdUb1Zm89WYGcm3MtNaHTDLnhvPc9UvrA1Cportl3DCEN/nzjj1cL0Vp11h/WULTc5xvblbjAP8etSJPM9YJ8NHwZF64UVAaKaoAiIpWnklRL6lfDHf96anone2n7JL1TCJHJz6a6a98NH6XBaFTkTX79nQKVF/3HG5g3sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEAhaxmnGmk3QIPh2hfBeUwkELzDN9fE2Dbfoh1q+hU=;
 b=FtLR0mIR0Qfs+Jw+NWXiyalivx7jI9DlCPYLbbN6Vuzfd3fDhmEGdpJkI7KXBJhIGljUJV6qtnum2OfiA1/mf4wZuai4JcE3v1LkzOVRKTd2lBVGeNsFTFX+mn1urPA3KWwgLxJWr1eX6DPpe6D5x7X30Si4UIFg+CMH+Rdn1rymsRaMOmLbUlOhec1hMOGHKdUYqkcWpWOcuJbgkq3cg96BI/bbDu2TAyHgCcyNVA2sPDWkvE84TlcJUGZigNOdVCjnKjZpKufm7SrIRwVtxLQVhLt5p74IxHPqkPv6TBJ6qZhuCq/08a6PPEw9MnQWdsHsp/1wT4q4hwj6rvUuBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEAhaxmnGmk3QIPh2hfBeUwkELzDN9fE2Dbfoh1q+hU=;
 b=aEDXdxi5+52s30JyzQR5odyJseZgxAh05uMyZkZ9HihWGxxoAOQ9n9Pvzg26B4jbrc7EChy0kQ4q/0R2O6FYhug+4g85BvBjq3jP2p17WgPQq2mbC2dxeWhOLSL3vUSGrv1pUAxo4QxIhRy942UTxNVOoOtpZ0gpjJs4a5F/N8hdaRLA2BaJirh1rmHIOPdLb7+oOhAveOLSe98mMTGv+FkiANuC3xv5CGPiBIPsuf7kwTYRU2gMfDFl2IyNqL3nKluNGctPCx/EP2GxlfpC9d+m6QRIr5MTi1kOFmOgctQ6uRicWXYbnEAYYHktRmc1Yh9PgTKqkWeSTrkUqFzqng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Tue, 15 Aug 2023 16:53:44 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f%5]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 16:53:44 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Gal Pressman <gal@nvidia.com>,  Bar Shapira <bshapira@nvidia.com>,
  Vadim Fedorenko <vadim.fedorenko@linux.dev>,  Saeed Mahameed
 <saeedm@nvidia.com>,  Jakub Kicinski <kuba@kernel.org>,  Richard Cochran
 <richardcochran@gmail.com>,  <netdev@vger.kernel.org>
Subject: Re: [PATCH net] Revert "net/mlx5: Update cyclecounter shift value
 to improve ptp free running mode precision"
References: <20230815151507.3028503-1-vadfed@meta.com>
Date: Tue, 15 Aug 2023 09:53:27 -0700
In-Reply-To: <20230815151507.3028503-1-vadfed@meta.com> (Vadim Fedorenko's
	message of "Tue, 15 Aug 2023 08:15:07 -0700")
Message-ID: <875y5gl01k.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0049.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::24) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS7PR12MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: c30f8345-6080-41a5-54c7-08db9db02fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9s7wa78AvnRgB5WaabTLT8AII8FkgKGCaHPJSV9Y8ZQCSlQBwgJciMqbUOmGEH7RyraIVoPd4IP6ker+Iw69hiLcfCuzkskzEaiMztCLKcKGHoEJa7RlIFrxFpnUBc/9n5m/Hr6yHr+bPXwfr2GO5c19YvCcCx27gYW7rBKhHP0T28VnHPYVMUZMP4N1vhy1uKv4UpTOa7QOTL46tZj7F1Ik9UQkS13a6u7ktiYsx00V2Xa68T0940mZyywETBfvBPfQWOcjWG/T8DUYbfoxrlR1X9+wjnrsiTLzodHVB6EDPN/whwlHPWGzfXU3mQXZ32mqSOobWNeoF9NrPk6C6mjL2wG7JIh3rSZmukDI5xpaEkTkFCrU6gr1aP2B4m03kOh/t8tiFtgRkc4aVecGq/Ygtd2zrYpquW1821q8s8p3zNEmDmgwXi0GtaWin06k6jemQ00dWveJiDI5Z0NOhU9okKB70zSejbxOeoyImnv9rfMQW+WSAjr5bL338lAtQBSa01kyTS+vNsTZC++C9ypyAbHpqE4VzvD9V+X2WDuWx8xwHZ4Zi1MxhgrtRMnz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(1800799009)(186009)(451199024)(36756003)(54906003)(4744005)(66476007)(66946007)(6916009)(41300700001)(4326008)(86362001)(66556008)(8676002)(6512007)(6486002)(8936002)(26005)(6666004)(6506007)(5660300002)(15650500001)(2616005)(2906002)(478600001)(316002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oqFCUPAkyNL4WLwKtUTwFlybFGK022UM68YkC2jAelz/ekiyzqnU9+NGcD0q?=
 =?us-ascii?Q?tH5IB/Mk1ea2mZ6zvzwlhDlU2zwHbE0QnUmunUwgVqJkxLodGX5/ajZ8QF04?=
 =?us-ascii?Q?Y1nELg0HaNnaYLh3DJnBNI5E5QsyRio9FXCBkOfFA8jT/1v//xrkfUIFfkGA?=
 =?us-ascii?Q?MvtFJ1QWI++0zFKzwDMq4kUgSy8IA6bJHHbOaTmFgdJsU3dGRBZnP4kidjaU?=
 =?us-ascii?Q?3o+/SoHyYz2cVU6Wt+QCJjKA7i2l81iEWTpKUDBmjYboHr6OzGAjifbW9MTh?=
 =?us-ascii?Q?jPISSaVCZmwUNeVEevhOQIQ/dUbIiL28XqWiUh5Be92YL9mLJRe8KAvi1S23?=
 =?us-ascii?Q?Okaxk2raAB3GwLu8M60CYnRZSyZICCEsg+qSxAuRqqO7+JdAUo0SRXBovVh7?=
 =?us-ascii?Q?7aSmMCWQUm+h3fpEl8OfMNhhvi/vGQQhRqszdaC5PRM4/C/0UfV824xhnBQJ?=
 =?us-ascii?Q?bm3BbU439j8qV+C0+ZRVl8/Ut8Tsh9AoeeJ+8P7cHQUm8LlWIvA5Y9+zldxd?=
 =?us-ascii?Q?U2zfRTls0WFkxbznZU752nF4QW9oAwAq73vq+y3v3UFwDduL/Yu3952bn8bl?=
 =?us-ascii?Q?NshzGN9NHpnwNJortqhyzc9paQm6Q6F6+EgLpAOYgP96KZqlqjpxK86xkD6B?=
 =?us-ascii?Q?1fbhQKlZjVH0iaxy7b2ZfH6LGQ4GL8jwVoqSQTcmCEzKofgl/cC9oDMCSC/3?=
 =?us-ascii?Q?OVzvI/CZYP/Kz2VNmrNJiYY2mFVVa9LmCVSmdtwuBqPPFGwUMA+lKL1wjZo6?=
 =?us-ascii?Q?ZNkKXMa+SszZjO+KNrPdeLOnU6RFiLPyZrw3q9gJRVD2vHkEGqdkidUHDQEN?=
 =?us-ascii?Q?NSfWx9Zbn9FWvHgyXerJCKr5Lqt9g0EIEckfcqn1cSeTjzCOfn202xIr0pKv?=
 =?us-ascii?Q?PPCB3oEgDvTvQC4RLwJl2YA4CYdZixkbSu4HYGYjC+mFKVqn9cFbUsV2oZlz?=
 =?us-ascii?Q?4hfhUH5wGm3KY9cDEC1ImLkBvhJnr2WB9v1g6OAvNx395k+u5clrvBwYLNbw?=
 =?us-ascii?Q?CCZEhJLXT1HxqrjMkONRZLh+GfBW1x76IhvcDOFJrNtcRlI+4XNUsxows9iO?=
 =?us-ascii?Q?Ry5ncj2hJnabQYLKe4ck75Fco+FRel7RlOvlZAcTPt4YZr39HE9IkJlWtsHf?=
 =?us-ascii?Q?43zyR2Roon8vW43guKJmu7vzielS9i1dgxGQf1eYbKCEqA0mGQAv8yOZEQUj?=
 =?us-ascii?Q?Oww9yWBrI3VtmtohcZLtiVuFOGdiV8vRSQ7V8/JLVLDkWJxT5iD6fhycSCnV?=
 =?us-ascii?Q?rOc/fMKJXlFdmCbNH/5JZ2LpxiqTPWwy//xqqJjW5Vw29sz9zLWZ0enXq9cr?=
 =?us-ascii?Q?ruvsfNhQE5AaptScyeuvyvj71NnigwVMl0e4rSEVK/cGnfQ1lTgag0b3PmPy?=
 =?us-ascii?Q?NeDP41YyVSuZAgoZEX0cn9QaEZ0lf2qHBBkEW9SqLPLuYwrvG94wmP+RvW5l?=
 =?us-ascii?Q?ykimibd85/7QHrk9g4sJB/lga+rpXGl4BgRr9Kw/2OBlcOVH82JjcTMZ78FC?=
 =?us-ascii?Q?VO93qSy2QkUO+U9EBn0+jOdb/tjxQu/gqAsTMgax3AeUwznf/M+r6cL9EL3B?=
 =?us-ascii?Q?7L1EYDMfU0wUomh+bnKruUTDoTfqm4AILFPK2rCPD5fa/hMktXQGdgr8bHoX?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c30f8345-6080-41a5-54c7-08db9db02fb3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 16:53:44.5527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44Q8ngDtPt+/VD+ObPXo0HQrIHw6yB4f8NIK5HmQ1ODyJIoR/VfVqZe5HNw6rCBr6L97oqz/1AQimox90+mrFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 15 Aug, 2023 08:15:07 -0700 Vadim Fedorenko <vadfed@meta.com> wrote:
> From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>
> This reverts commit 6a40109275626267ebf413ceda81c64719b5c431.
>
> There was an assumption in the original commit that all the devices
> supported by mlx5 advertise 1GHz as an internal timer frequency.
> Apparently at least ConnectX-4 Lx (MCX4431N-GCAN) provides 156.250Mhz
> as an internal frequency and the original commit breaks PTP
> synchronization on these cards.
>
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---

I agree with this revert. This change was made with the assumption that
all mlx5 compatible devices were running a 1Ghz internal timer. Will
sync with folks internally about how we can support higher precision
free running mode while accounting for the different device timer clock
speeds.

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>

