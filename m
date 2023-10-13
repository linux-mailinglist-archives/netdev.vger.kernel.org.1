Return-Path: <netdev+bounces-40722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A47AF7C877D
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 16:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B0E282D5F
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 14:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF3718E1A;
	Fri, 13 Oct 2023 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RUYlAvmw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A09EAEB
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 14:07:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DA7C0;
	Fri, 13 Oct 2023 07:07:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4YrLT4AInApHiJ49hAuMVaWLCEDbZ1MywG3+8U7JVFuzMEn5DHGg69VKGfxxtxYDGZnftJrTVeP27Ue2ayZK2EhpPsOVvj0n384+/rF0h/GuDeH/Q7bDsAEI4D3PJsSbnQcRTscAovYeiM39CYyrdzVH/JVjnllCS7FSKF1FpLWE4GyBe+w9cBW6Cf1xnwXePmgQiSLuPoAeFmolBnwUMLHISneet/TSLLdJl1Rl4ZVOjWSeIIfOwOCYUDKvl+S8goW4cDbNlVA9je44YcDuZSJsKLrCKdfO7HxO/RHylcMtJsgDAI16NFe411XhOMnooElTDRzgXbDdIusy0RLCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SmrNOZPd0Sh7vaiXEJBsAPn0bFyNhXp6uAxuJr4lnA=;
 b=d4WZw8PWCh2CVk/AIX08Nmm+fF765eMzjYlV7NLRldiOrnlhN19NYpDOcIYDoOjDeP4L4gjk0I/wFvXdTF8nWGXtHKASzbxyHhvweuqD2xV20IiDh2IQMk+K+DxdBprsJ9svHRXxrbcKKCnZ5B7+e/BJqA2UolmKi25bswJCvidZb1Zs/tDUKap+lfgajIBJLt/IOJJ6tNckO1vo6e2pfR4R6cHfnYWJ94xXr/O2oHSNiOj7zi7J/bwDSYhC3HuGphKVJpSPJMz6iyHE8wxBpTdUx1ITeFFjamcZ6x0XtUJhloG6ecaztnSGP4C2wv7XHFi7SsvsOu+g+8+CGOPNnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SmrNOZPd0Sh7vaiXEJBsAPn0bFyNhXp6uAxuJr4lnA=;
 b=RUYlAvmwQsbuauijZizGnkJF6lEpcMB91c3/T9KOtTeT1HmL2omWrELcB2CN+vW7PPme0wbXfQ6+lCnbZgJXHTg5fZHa0J6ukryS/tdK1tEu+8iVYzIIAacHT7cHpHp9iAIxVGv4ZfEK3HLtquTtVDh5EvV9aml2+5As+jt24W+SKhCOto2mkeh+hH36QPkWdvG1INsNj5iCJ8mJjqOI5FGUOctBs5JZTdjS6SmVk3csOKtyckyCiMhLswjmV0GtiMDmzjz2Lgut78hYyEwU6NQdrgJcO72exHnrc185HQfIsE/sLUeGkO0m5ygPAMjNoiOSKZQCA+5PuCahMUh+1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Fri, 13 Oct
 2023 14:07:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 14:07:46 +0000
Date: Fri, 13 Oct 2023 11:07:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Cao, Yahui" <yahui.cao@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Liu, Lingyu" <lingyu.liu@intel.com>,
	"Chittim, Madhu" <madhu.chittim@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"yishaih@nvidia.com" <yishaih@nvidia.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"brett.creeley@amd.com" <brett.creeley@amd.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH iwl-next v3 13/13] vfio/ice: Implement vfio_pci driver
 for E800 devices
Message-ID: <20231013140744.GT3952@nvidia.com>
References: <20230918062546.40419-1-yahui.cao@intel.com>
 <20230918062546.40419-14-yahui.cao@intel.com>
 <BN9PR11MB52763EABE64389B5FBBBFFC68CD2A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52763EABE64389B5FBBBFFC68CD2A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR02CA0113.namprd02.prod.outlook.com
 (2603:10b6:208:35::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: daab42a6-cc1e-42ec-3013-08dbcbf5c668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FmkHmaJUnH5r9LTTIMWnbyeVyhct0Xl0HA4rdMsXVpV8hSiiChhJUDDMEN9ETv9cL21eH6KK4TDsgNP/mGFbGoIFrBarlrU/JX2d9n7Y/xF6v4CqIa2o+OBcoImcfrsHricDhpz+6QXJQSol0pCDwRna9cN/EGJZyzP/XHFcEPUXt4Y2vQDyo3ooBGOsyrHV+ryRzPwrZSDIeQCVnMxxsCviOOyYhM44g9/6qKDannDLbl36TIXrsgHdTfnoWLmWlYqw9xZWtGy4HzfYUtgjIHLUFlWh2KHk40vKUSR64RPu28tkTu2qVDQfOrKHIOZgd2SRRM37+7GXu7ClUZn1Uyd18MS+hjA0snVC4myu+wwaRkmlgff0IVQdhia+veyLJPcc4bbPaAUy9bVtYzCP7aDYgsq8eZWSi8N0o0llyJNlR4n+tqTpa8z1vEPZsP6N3+CrtZOK+YH6XxkWcjpWfJXkcQ71CfloGqCAt8BjOgfBpMGY+laZsOLK6f/aF32fmdUNcsPOMhNkgzJKmrKubG958Cw4j9+JnIojMeViJ+9pfxO2OAOdI7io4zTXik1c
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6512007)(26005)(6506007)(1076003)(83380400001)(2616005)(4326008)(6486002)(478600001)(36756003)(8676002)(41300700001)(5660300002)(38100700002)(8936002)(33656002)(86362001)(66476007)(66556008)(54906003)(2906002)(66946007)(7416002)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b1hgtJceN56TtryGafyQQ1BCvQD1NiqTyqPSUVN1P/b5XVFvlsLRX8KhHXWj?=
 =?us-ascii?Q?nlyEuuNmlVTKNlnDNOCbcnDcsWqd1GghsvR0b7FBH0cApdx7/kVuWajiIPlR?=
 =?us-ascii?Q?5QD0PXeK3MHqf5aO/ZoiLyWYnMy6A0Gz1upDNK3SEVZD9a9GpPNcg8ZptAAd?=
 =?us-ascii?Q?dd6cu/H5HSZBpPub6zDlq778mZtvPaokRoF4S5KaQTO4pXFI9CrOKkhTq92q?=
 =?us-ascii?Q?qpOHDfd2oUCpy8qymYOe9r81KPfB8skZIDJ/bfTED+3GCUZSU6ESZjtIc54/?=
 =?us-ascii?Q?50iHTExMMeGnlm36lKyCvLbspdLmkOecpjvbOwp7Bd8ZuAut4Q7Cak0+S0n3?=
 =?us-ascii?Q?moaPyI9BxjGAY6DMS1cn/T25Q3HpxbU5UTyhgqYhtSG/Ib6QjfAac7RRkVqC?=
 =?us-ascii?Q?5G8fuYJPkhQKQSl4fvIiqP1HHJjLGLOVVa+Nhd+Y3yRoI+mHwIeN1PEpHkIT?=
 =?us-ascii?Q?BRHD44Z9UjSYGEK6XeQPCl2RFVGWEIq8lHokuVPxMQA4Z0PEFnH5zl8HC5+H?=
 =?us-ascii?Q?d2xaxUaDAdRzOBAJ9cz3oiBN5EsE11/l+TECSh0zb8t+XjJndhO95jLxOjcl?=
 =?us-ascii?Q?p5abkEo1eWIRMwoyVjZaYAXnx+jm/Nbf6S4kqmJm4gYb0VyvaL0if+kkW7/u?=
 =?us-ascii?Q?Ga/S48ps9hWU4wwt3BQEe49ouzWtd6gQKkVSETL7Xfc21J7TeyxyPQBp150p?=
 =?us-ascii?Q?ghmr2tD3cujzpqROIpXaJFXXZ9z2LA/Ms16MQnoZApGT4V+84fImSTITlPGV?=
 =?us-ascii?Q?CjTQqbHC0xRZKJ+1hUPz3puw8+FuGv94enbJjS7rEaLngBlZeJVCZo/KLT3M?=
 =?us-ascii?Q?WOBLXElA3ENE3/mFddX4Yb5JFmVTE3Dc66u+JeuXiyJeON0MrSxNrK6Wlj03?=
 =?us-ascii?Q?MuU5sLDfng5logGXyMJ0D9AC40NYRWlEYkzumhkeuKuXNkzEB/T5Wx2SFrQC?=
 =?us-ascii?Q?H2XuL9zgAkClq5pSMI8kMZrA607lWYbXAIMLdygsbi4kqnPr/2SqSxOQD/zc?=
 =?us-ascii?Q?FLkryoGGeyeTmFc+S3BvQg2fA4nog9w9IEYQKapN8VVcPeDbGP8hgBpKtCMU?=
 =?us-ascii?Q?rE8DKNFHVmLxt/ku7law3QT684dwFD5KbVhacAQXfaeeMGMfOdy/93N7bkjn?=
 =?us-ascii?Q?jash3E3qZof/5jMm5qzdoDn6wMfsuwGhgtEIVtfA/MNV4Q1zBWVnAWEEFh+Q?=
 =?us-ascii?Q?fD60jMvsI6QLsMxfiqAfSe8jL0U3cQFmGaHaevjd9QxXYPsO2NS70l7VAx2R?=
 =?us-ascii?Q?38V+AhWQM2KBV707yHGMCRpS8Z2PizyGOnrzU3NvH35jFyLgLP9AiJOqKiBR?=
 =?us-ascii?Q?gdSeBuijc1mbMv0JWzUnRKS4+iJhTyXKphVz4KbUkgOBDSGjGkQvQaXSzWjt?=
 =?us-ascii?Q?60Zzz8g0bE9jfIN5yCBCUfy4S/O9i1Uq2T7umjMHqMdQnjABgjTa8yT8Z/CU?=
 =?us-ascii?Q?QRG7+wSncJ32gbvdwnTG+AQoNc1mgVaIOuyn8zoSdbkQHlQz8Gu+LEMlPSBz?=
 =?us-ascii?Q?6i8DgeCRT0qfc5PQThk7QibCRwC0CNa7sYJBF5LIZmKL/A7GU4OlI6gsobq/?=
 =?us-ascii?Q?h5TKY+uyc85PBQZ0kRF8wlsWaP+LW8g4+2G5vETt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daab42a6-cc1e-42ec-3013-08dbcbf5c668
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 14:07:46.0732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezTuyIAzcU0gcJ5iBrAbQag1KoBrCjLQ//pffaexeppOsJuOXxHvuhGBOfWcLi59
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 08:52:07AM +0000, Tian, Kevin wrote:
> > From: Cao, Yahui <yahui.cao@intel.com>
> > Sent: Monday, September 18, 2023 2:26 PM
> >
> > +static struct file *
> > +ice_vfio_pci_step_device_state_locked(struct ice_vfio_pci_core_device
> > *ice_vdev,
> > +				      u32 new, u32 final)
> > +{
> > +	u32 cur = ice_vdev->mig_state;
> > +	int ret;
> > +
> > +	if (cur == VFIO_DEVICE_STATE_RUNNING && new ==
> > VFIO_DEVICE_STATE_RUNNING_P2P) {
> > +		ice_migration_suspend_dev(ice_vdev->pf, ice_vdev->vf_id);
> > +		return NULL;
> > +	}
> > +
> > +	if (cur == VFIO_DEVICE_STATE_RUNNING_P2P && new ==
> > VFIO_DEVICE_STATE_STOP)
> > +		return NULL;
> > +
> 
> Jason, above is one open which your clarification is appreciated.
> 
> From my talk with Yahui this device can drain/stop outgoing
> traffic but has no interface to stop incoming request.

> is it OK to do nothing for RUNNING_P2P->STOP transition like above?

Yes.

The purpose of RUNNING_P2P->STOP is to allow the device to do anything
it may need to stop internal autonomous operations prior to doing a
get_state. If the device does not have such a concept then a NOP is
fine.

Jason
 
 

