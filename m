Return-Path: <netdev+bounces-15184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACB0746125
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 19:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82E51C209C7
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 17:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D659101C0;
	Mon,  3 Jul 2023 17:06:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB02100DA
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 17:06:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E367E3;
	Mon,  3 Jul 2023 10:06:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dt+EBWB+TmfG27LTYDFw7Gh86DJqooIXATjrKMta+rZbGwZcQyIaDfbS2maCcvDA1M36Lta66VBEmuo1ksH4bRXF0RAOWsxKjPzgwKvXO7bSM3NFVJTxJM6D1J17IO/VTqf1/xyzykHZEFoA6oSGR1pLg9s20QhVRfNRWOZ5p2Q8o5q27+bVCZ6JFC4LFgqO+b/o3nYw7+QNwEYmLpFf9qX3KQ0oe7qJpcYCYbhhejuQML6zIMqCJVcEcr3MDeUoLroCYgtzUb5wCuGTlq077cKY/EovM7U1rQ4MMnow/zIiy3SNZx4thYXFeTkqeuA3OsYRnT9U26RzcN64b1CJaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qNH9EsmIubunpcLs9wI/Ce7XnQM7kdVXjyeXUzDY+0=;
 b=NpGmwX44Y4FPy3TOyKojFkU2qLs/46UMTtZ8dlMtAp7id6zYaSjUXzqhVTs8o0NkIhvLn8zizh2lLL85QleWmCzNd2cwWS1opJsM1glwv+bmo7N7zwOCJPsNk8Y72mhWbLgHtHh2k3a/dBDz7pJzUR5IeHKX/AMjsx22uY2vA2yEOmYvBb2AXCznnuXRRVLQsplbd6ZreFskbWz6Af3/N9yqBq96ZoVP2vfjU6OCwEWQ8vxvNz3INJICL7k41RJgOye7A0BM2l6huhkEaiwJomx3oeh/Y/wSeTVq2QazeZhIoYxA4sjkfrnAxScAzpmNaKFaOb76im5h/T3Z0vHmLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qNH9EsmIubunpcLs9wI/Ce7XnQM7kdVXjyeXUzDY+0=;
 b=MjkGV/haxsaAXnlOHlJOx6DaoTcOPyAci69A40WmEGPlvGDF2VK4z5jNGI8VP61mno0XezVQXN534vaFRKUhoy0XutQ22qS6I2CzIeiUxLvr9K54zUlaHRnbf3SvsiHlsqBgxqKZXiJlzdgbndX95YI9ULYSSROjP8UZYPQBFEgAOaH/YEDNsfccl5oSrz7jsHlNmeLzabOr4znPKgvjAaC1M5QoGXhc8R44lO4g08YU14FdhZag/f4KUDkdAgzCyQtlkoX4fs2Niu/oBHp0THVlxU6A5IlpxlmOAE1HKwYs2gcBdjaVAO1PKJckhl683enezoRZheoF4l0g3uU2Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 17:06:46 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::66d8:40d2:14ed:7697]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::66d8:40d2:14ed:7697%5]) with mapi id 15.20.6500.045; Mon, 3 Jul 2023
 17:06:46 +0000
Date: Mon, 3 Jul 2023 20:06:40 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] mlxsw: spectrum_router: Fix an IS_ERR() vs NULL check
Message-ID: <ZKMAIGKBsFZ9v114@shredder>
References: <16334acc-dc95-45be-bc12-53b2a60d9a59@moroto.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16334acc-dc95-45be-bc12-53b2a60d9a59@moroto.mountain>
X-ClientProxiedBy: LO4P123CA0183.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::8) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: b28c62c5-86fe-42e3-51e2-08db7be7e1fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ln3dBIVk6f1A/cUozYHhbaUnKD1yIK2LyobkAlj4ElCrvbxcXSvZU/nVzDehaOysLbGi5OkX3nCGKJdUYaXxw0jL70rZoMOmpvcIuu8pmdceGC/vbifYDtyh08q4kl/m8GvJvnm5XAe/UjfLAc+721+tUxS76iNSnJ21w3BjcsJlfD+zSoGlqKR9Gg8sbfl8OLrRemsWBFcVJd/lovM3+B/N83SjMGl8EqN+K7n8HUlPgIG2BNiC95QqfZaHrt+BoFnBqxrc/OI3o8FQKZ//FwHX3Lww4WdoT23vkHo2gDiuQ9ybUuEacnFITPdlxzf4e19lilz0Gwgbct7Y6yWXVFccN6Ky7S8S0lTxejy0S5zKuCOgfdZTtHQzv6pol4tBev6Xe+bNLHnMIaZhguWm5Pjh7AE6FwUN8AKuN+Sy+mMXoCkifzzurm+n6QvERghZnR/9JwmJiLMIUqimIKHlnQ99hsXeRKvT0eaMyUwhP4W7JTWV0Hif8hdwGmfomSIWDNbd61zSP+ZXWEt8m/AYjgJz4A2Nn/RWJkVQ6o37oGr6LgpfMCiPjvkQsggtWVAD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(54906003)(9686003)(26005)(6512007)(186003)(8936002)(86362001)(8676002)(6666004)(2906002)(6486002)(4744005)(5660300002)(41300700001)(478600001)(38100700002)(66556008)(6506007)(66476007)(6916009)(66946007)(4326008)(33716001)(316002)(66574015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jOBxIy4w7+bB42xS9JPRqkXlJv/ipu/xEhJ58GNF52nGJsJXBGXl8xIbwhsb?=
 =?us-ascii?Q?JYw7bGtAx9HmbBDrmMnurR77RBxTugoifDLig4e90woK26G3Ommr/28qgLHH?=
 =?us-ascii?Q?4wJTdQEe65af6wlvvyE/jMg314+0EKJsUzUl1L5jgFBrgQndNN7QLNj4OD8L?=
 =?us-ascii?Q?snEdCKWQ9PTbz9NQFxFYAaeX+RSQL4+Wd/S6Qv9unFRSGw94wW+qtz8+qK7n?=
 =?us-ascii?Q?7gQuWSpKh30xNHFCjVJRDbKRJDb/rVwFwqary+gstZ4F6YZEDdvLhuhPJDQI?=
 =?us-ascii?Q?fDExAhiY1vyVVRG7wlTKufPw46oUBO5XJlqcn3LNEMc2E/fuPKhu6DUxwOE7?=
 =?us-ascii?Q?r3dHJdiCnibcX7vLqeFmDBRgu9Rp58CtFDQWiz/FX6+i1Fy2h3FjY1rpw/Sg?=
 =?us-ascii?Q?QMNFCReCe2bc8U8J9anYndCbL0SbgLB/GtwP9SYJRNX0UKsfBlJSES/EyQ3Y?=
 =?us-ascii?Q?AydLbo5rVhddyQC4ukAFxcAa589asAjvII9jGQkmOks4CklM7GUdrsW9llbn?=
 =?us-ascii?Q?xcpctTbD53CC5dBydnc6vEVZQbwIpYZX0w6EbHdCN9A9DP+XSVxuTFCLYrsl?=
 =?us-ascii?Q?W6LnwH8sB6sIQ83TWfM+kSnhaz/Vy/o/qWvl9LoERuvGSAILGoFhIL/dAw33?=
 =?us-ascii?Q?KS05cSRAqebu/WQSOi6vPY7eQh0I3sY0LmvQEs04HlnQFCGJHRut6ylQfCBn?=
 =?us-ascii?Q?4jDJ8wu54TyzTBV7VOKhM+zsGYkPX5OwbT6K5qgDPMBQ43tAl6CiduHWldaC?=
 =?us-ascii?Q?uKPmRZoptrXN+g0UUautj2b++8KnwOsXL5Q8zFNBcYHn3podS2HBV+hxCh80?=
 =?us-ascii?Q?tA2P8Hn6phwtRNrSsgYiB+hm9Qz/tppnmdsc6DH4+JVI33IIGd3iGMIyy99O?=
 =?us-ascii?Q?5XLbnde8TP92WAzQ+aJLKdHCkBskh7xKbBCmQKptBFuoCuY01NmotSw6oOiZ?=
 =?us-ascii?Q?RyJIIym5JI9WzY3rz1v9z3FHKZEJCcHTOQl2StwUfOzOI1H13WPeaSNFFT7s?=
 =?us-ascii?Q?U6g3MjRPLasPKk+IxdyWOX8X5SCgIWLbAAPTiWMTrCSVpPOvIQkqbd+qZSmj?=
 =?us-ascii?Q?n0TbvD1232nXYtDaKEIx51OROgGObNM0FKkB+8Ceu5YrYfsn8Hrl0wplvuDb?=
 =?us-ascii?Q?VWA/0hfp4dlwZR778HabJW4lkCOvbvb27NDOsNanFp/6lkvNxewjpwhBZsJu?=
 =?us-ascii?Q?Q2A1k0JSfw0xTW2mNJcv4/YZolV73QjUu91/QDQJFDpv0OSxgYoKaf7kSXGX?=
 =?us-ascii?Q?eS/Onnw06XOfHsPYD4w6wFDc5JZEaTO6wgaAZ7c9HJLjOdYasN6dXkFgIbNE?=
 =?us-ascii?Q?z5IM6/rYCpFBIhMBPV3TcdQdQLcaiqbBobO+mmlPQWsVJJ1YEvIyvswIre0x?=
 =?us-ascii?Q?9pWyS3AqUeYHnAUOx0iGpzWrkJ51QkXffS1Ep0TXf/Jr065yFKqpdGWUV6N7?=
 =?us-ascii?Q?mGtiHV1ToA6Rf5YGsnx+hogxs6H/tap86ZGvfUtSRKVFCzABoLztDNh/6B4C?=
 =?us-ascii?Q?fbEryXiBj42KERwMOfZJgCrrl5lta0OhuNSh6iqjyBDt6iLLHgkoxt6Ao1WW?=
 =?us-ascii?Q?3+NpOBVSMlT9gwHlW45UVAqxn4kS+xP0IQECGfx2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28c62c5-86fe-42e3-51e2-08db7be7e1fc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 17:06:46.3189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISU+eV9azDlzIvD/SUJ8uKm9otVRFezwkT97D/hNDDYVi+Z7XlTJJZr0WsOq0eLUqkLj+LUaNLWITGYH2CAKqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 03, 2023 at 06:24:52PM +0300, Dan Carpenter wrote:
> The mlxsw_sp_crif_alloc() function returns NULL on error.  It doesn't
> return error pointers.  Fix the check.
> 
> Fixes: 78126cfd5dc9 ("mlxsw: spectrum_router: Maintain CRIF for fallback loopback RIF")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

