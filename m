Return-Path: <netdev+bounces-45433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D26907DCF4D
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 15:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D320B20D40
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 14:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB78107B1;
	Tue, 31 Oct 2023 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jzxzOe7I"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC11EDF65
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 14:37:53 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0ABDA
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 07:37:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGpHINfz/nmpwWt6S4knX8PQ3Sn5NXWVkvsaAFj27St+IUgASZTqSPYdNkmgt7P6Aw7JU4xenOFEueTiLhrsJWv1C/WUa1Hvv4rS6z2koEUG4jVRCcjCWX1FWgfInmOGuhwi7OPxbq95swYC1usOQBBP2dE6Bwn8LbF//wJWTxAq07129Tpq4uQuVWzgdfn5aim7scuBLt4FIAn8QwP/w3US8DhkhaglP/t7RQLcJGfUY6iGe/e3+PUCmJ0FbB1cQA5Ds6I1i4leEFcCtDrce8AOq8iI8XQc0SSiNc3Ocu0CzuvPiaa2oOUpe+7NE+C0moYVkeUn2wk0YJlbdY+fIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lE+vExUOurk0s7YJ1HPC0F4C0l1psAorc2YCu6bFkUQ=;
 b=XsVYOypq+PibjWUcaq7uUT616CQB9/lXX8gabq82gfpxGb0xOmvZKlI3Far6svI3oBjLWIuit25MqjerlBDb7bUw+FLW6sJvN/+TReMY+E+DTrVacHDsVu1h2vDr+fqZ4+rEHFjoosYY5ZTxgCli1JU0c5b+e3456tnq9uGmPjPh3IgE7SwKRiZnLnY+Wi8DEcdILpNc2QyTZxg1+LMEmI7bS0O9qa1eR3dDhpS/QEasdieEoLnm+hbAIOJlgGAVnF/odvD8cvEm3cOykEGPQFf9mh9QyLMU41XYGDWu5OJmlMBmz5nxUiJmBuBKHXEuMfwtk8PLaE+ni5Aaf0zWjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lE+vExUOurk0s7YJ1HPC0F4C0l1psAorc2YCu6bFkUQ=;
 b=jzxzOe7IRWgIhYtvc8jOMf+CRB8ea1reWNJXcvt428gsktf+Ridquae91Xf0QtyhtnNhfS3BSKzDW//S/ViJ2l/NZ61aPdG5GftDks8kUimEUN9DeUcxPlGTFtsQOZT3SJb5EgkA19qfCwa8U/3uGkqkUUsSPfX/7Zyk9q9n/ddIKuaFBtopfDbMVZeogDIi31c+Jv1KJgv8Supw4sJwamTa+ALv4QSHCErXQma3izE61JCrNFmLBok/TOu+j/V60b9ouafc/aRXmPx0w/M19StB2M+vcI/3vYOOJP0r9pBnHLT6nrq13T4NzVfimEF/gGBwhfyaxlguJhJmMH423Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by LV2PR12MB5943.namprd12.prod.outlook.com (2603:10b6:408:170::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 14:37:50 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::6f24:e252:5c2f:d3c9]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::6f24:e252:5c2f:d3c9%7]) with mapi id 15.20.6933.024; Tue, 31 Oct 2023
 14:37:50 +0000
Date: Tue, 31 Oct 2023 16:37:46 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, stephen@networkplumber.org,
	mlxsw@nvidia.com
Subject: Re: [PATCH iproute2-next] bridge: mdb: Add get support
Message-ID: <ZUEROoKoo/hQsCSS@shredder>
References: <20231030154654.1202094-1-idosch@nvidia.com>
 <f5823dfb-4ba7-f32c-d8a3-9b8b7cdb7c5d@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5823dfb-4ba7-f32c-d8a3-9b8b7cdb7c5d@blackwall.org>
X-ClientProxiedBy: LO4P123CA0218.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::7) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|LV2PR12MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f172f45-bf56-492b-72d9-08dbda1ef561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WcxRGx3hKjBAJMGP+rV9mp3irOIMQWyQVcEGwVCgCuPG6d6f0L+h7bEo5WVRYmaUpL7JONPvdcQlQXtZFyQiu6gXTD1N9CKNoDKqA52Lhz9YC6vbOl3gVrFz1RGv2qTfT3jgMWqVXe28hFuNFr2rJuubqdqHXVoPl5nZxvi/o0RBNWncpjCeG927c+KPuVMis72RryaAIEorbfwW1vd4jRMgoItNxnItehJCXXIu2PhCKTE/5/MzhO5Uh4yhEQbtpR6bZPyZwZix+jxrPoscseAx1gA+9irdWjN03J+Qa1byN7Tta3gFhI10pj2x6xk3yTequx15OJu1gGnDxMavGRKhKcNqKUDRDjkQOj1n/rB3afEWnjlW4XqJWFtdArIs0kT8qqjRmauBb7w9/XSvTSa9h5kd6NBrksWh+gI8bHHFIxprIHAzxJNQoLhjbMpwqwKvxNxfIYWdy6JpeQ/XWBahRlLBrgxcu9cKMo5vezY+MMEjGYC8QDNFaH2XrGTXjcLyrxIn8xU6C4ODRXedzdHI+O6M1SSfTQQvKC4RAQl3BWa3xqG0ou5Mb3rVc000
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(366004)(376002)(396003)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6512007)(9686003)(26005)(6506007)(6666004)(478600001)(6486002)(4744005)(2906002)(107886003)(5660300002)(33716001)(41300700001)(66946007)(66556008)(66476007)(8676002)(8936002)(6916009)(316002)(4326008)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G1B+jErOfBTZKL6Ao+lNpCH6zKwf1WBdTKN9yboPiA6A2Df3Jf+zZFs1r8uH?=
 =?us-ascii?Q?RBuSKrjaG4FI/Yx50Xi5x3fI+4BY5MsACuTsHlldNttQJl8gvxu2IFUzYBP6?=
 =?us-ascii?Q?V5TN6g1cKyFOK++7PIW3/VrLO5v89Ip1PTsgHk2f72aPZ6tRey7mQXVZgc4W?=
 =?us-ascii?Q?uI30BnUzL+FdpQHeMJM95BUn3xxYUzcVaSpL9QBLgqqzTb+GWpb5XMxdeXfv?=
 =?us-ascii?Q?1i1Hi3ZT5HUAJ49YrijHKjbXvRRL2908QtcEVxdWbu+igG1gAApNf3Z9gLv0?=
 =?us-ascii?Q?B03PrseG9xHvKQVdIZQyncEg4wJ4CKxqGEB1h52DIADufTEpvVBWYurN/z19?=
 =?us-ascii?Q?jgwvTlj4x9INk6nYtzTuAralzNBleBPucVKjkmtU54uOfZIfsQc1syOG/yY3?=
 =?us-ascii?Q?7b1Daz695oJLe2IJ3nOLaoYBCNX4A8s0hYPHygamSbJu893OOuS82XfDoPdy?=
 =?us-ascii?Q?516cTTSvlDX7Gkwsyk5zW/cFKtfaMdLpX776SxdblrrkuAkwK2rqqJwKN9tP?=
 =?us-ascii?Q?pLWEjNXSLL1stLqlg0OcTkzfjPyt9Sm/uKhi+N2wU4KIX7oHZsJJquVc6UQq?=
 =?us-ascii?Q?LmELAyLe3oC86AO9OYjGMbXIjYfDrqWtgoKQm24FSA3d0k692U6PIHf2ofan?=
 =?us-ascii?Q?18rurNnzE6bhpmD+tqtLclc9hldkjZc5nFQu7kDtAWzDfjXkVF3fmsiDeXUa?=
 =?us-ascii?Q?AjObtjCpdyAaFHCDxs0S2EW5j3udRiHCleGxJtA15xRReMrZJ+6ScMkko+Kw?=
 =?us-ascii?Q?kE3IZGM9SLkRK51UYXodM3Ok2aVD6VefSY232VuMAPUZt9l7XfRowATqLzqA?=
 =?us-ascii?Q?PI5nr0nTcssVNnYiJDFbMRFV+cEgQmlm9FfqIUoTp3H+aL6NrVZIVerF1FHA?=
 =?us-ascii?Q?qq9iflnplYZO+6eRy99UbggbEP9rB18J+BDMhc/WwvzN1g6V9AeuMMTVuS5O?=
 =?us-ascii?Q?m1dnSBpyJgPLmNFNyYwqBPCN3KcDMe5XiGbULtomoh8pTKyuOVdPX911VRGb?=
 =?us-ascii?Q?+P3fVJuUdjufHL9foyol11zwmc5Y25y6mjKqsfVziEuI8MVw0AMS4NGTyO8m?=
 =?us-ascii?Q?6HkLjON57X4KbeKGBPZpKSr77QirsNDXSaZH8Tfz2aWx17N5xyEUAu9kEiXr?=
 =?us-ascii?Q?nWsxvS4cIet7LLtOwVcoUnaz/MbUqI9/Oxk7Eao+nzp9Lbg6okUywHRcq0LC?=
 =?us-ascii?Q?pmBDx6pGNPJ82nN/9WNbKoUu4yxsls14q4fPwV9QYgEIx3wK252Gkj9hw4XH?=
 =?us-ascii?Q?VAQkmkrV4WV21blQKQVDiVOOFqO4Bk+wqMFkwO3/BhrTKMhGzcwNMO8+dA+e?=
 =?us-ascii?Q?VyN6VZak21LMkZxx2W5qZRs2v0lvIZuuzorWu/pIjaE+0Ptl/QGJWh+SJORI?=
 =?us-ascii?Q?WWjxkK1/iQOed9xxphGPiC/k7K1NMHOOnGC4++POegKVJ4g/QEcDrwZZRzVn?=
 =?us-ascii?Q?gOVzTbzhCx1CjhdsycDCcB/lhUL1OZL5npxm+NCvzN3/p72Mae9bm/+gpG+v?=
 =?us-ascii?Q?Znj+R65p58961wDXCNPCMEI+OOOhQ+/p1ME3uDax+yjmE/jt0lsdo9N4+e1o?=
 =?us-ascii?Q?lcNNzIbfRMIL4Zy9CiPnku21vg5PSf1D+XQH4ruo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f172f45-bf56-492b-72d9-08dbda1ef561
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 14:37:50.4968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Z1KyDsGoCOpAl3qKrhpyXjub/qHup+3sdWrnCUBmDpl4VTcaDfDkSVEyM5Lq5a/sBwA6xZmo1L/e/TSX7LRcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5943

On Tue, Oct 31, 2023 at 04:29:58PM +0200, Nikolay Aleksandrov wrote:
> > @@ -865,6 +960,8 @@ int do_mdb(int argc, char **argv)
> >   		    matches(*argv, "lst") == 0 ||
> >   		    matches(*argv, "list") == 0)
> >   			return mdb_show(argc-1, argv+1);
> > +		if (matches(*argv, "get") == 0)
> > +			return mdb_get(argc-1, argv+1);
> 
> I can't recall if it was agreed to add only strcmp even if the rest uses
> matches()?

Yea, not sure how I missed it... Will fix in v2.

Thanks!

