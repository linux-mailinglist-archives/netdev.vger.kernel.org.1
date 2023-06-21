Return-Path: <netdev+bounces-12663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943FD738603
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 16:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6BB1C20EBB
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 14:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A9E182C0;
	Wed, 21 Jun 2023 14:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBF517FE1
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 14:00:26 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2116.outbound.protection.outlook.com [40.107.95.116])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283241BF6
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:59:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mk+7IdVvsQ2MVSKMTAaM8HvYwJxEmTDKQQ3OB4FYR0L5+Gr2A+A5Jne9tTOqjC+Ykk78wkbT6wufMWEgEEXAbkeo2xdLCw4KP/WFnaFZiErGEfkIWOmkY8Q1ZKbZF9Tnmvu1vAUfyfv/Xx3SjIivByNYWldBBTdI2xwo8oU3DOVYIMPfABS8BcyHH0GyrfPZ39fi5I8CN3aAgFqfeY/KMomLYIV0NgWo6xDA9wAm1exgBTiTleQ0/v7L+S040m/EMZsUYgGORvDKVXnIE5sFQFvnrlpT7WyC8k7N4o0ay37M/wnsD98WqAXz7EXE6SpVPk6aYL+tsv3X8LeAEjjvsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUjP1Kv4lz7WW9fnXIpokp2PvQ39LiWasH+FB6DFd8I=;
 b=LfKGmTtizo7XV5ypaZbgzRwr+tMQPc76w4aGabX8m85PPXlNRzqizzgbQddihCb0H5eGefmX1vrYiEvs7gVOEk3vVAKZFQb9VWkb77DLFMHEtgGx9aYJsZLkIq9KkzxnVIJZZdejBC+Fpph8EmswBmRRVmo947UIXpV7iZbjTaJFSkJPWpTvj/rUHQDoeoZsYW/gNo8bqcCoTSK6jEx1QbEa20s/yfVnzHqIF3PpZ/ZSGV1AqvjFUIHeUZBRZGUoL74d4MXSDbhBwXamSGA1bvzRTvEIVMukjQWx+df51qlZUY4zfY///kctGigU0a1jzyciWe2sYK046K8qVZqwJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUjP1Kv4lz7WW9fnXIpokp2PvQ39LiWasH+FB6DFd8I=;
 b=QybnFooTK/b2zeaTmM0hefzW93gFP/WfiFZNiV3bkNXyxKrwqFbUbEoQL/NAUrewMnv3xOZqGkCJFPIuUm6VcbzVT7gJOBc3Nycdx383W+olYdY86Upqavda8VEjKt+pmTvuPrduQRITWD8sO4KvsDOreocbV6sWoth7tT/T8VM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MN2PR13MB4118.namprd13.prod.outlook.com (2603:10b6:208:26a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 13:59:44 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 13:59:44 +0000
Date: Wed, 21 Jun 2023 15:59:37 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@intel.com>, jiri@resnulli.us,
	ivecera@redhat.com, Wojciech Drewek <wojciech.drewek@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: Re: [PATCH net-next 09/12] ice: Add VLAN FDB support in switchdev
 mode
Message-ID: <ZJMCSfZK9kfixep4@corigine.com>
References: <20230620174423.4144938-1-anthony.l.nguyen@intel.com>
 <20230620174423.4144938-10-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620174423.4144938-10-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: AS4P191CA0026.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::17) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MN2PR13MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 559eb7f0-7226-4ecb-7759-08db725fc420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8CYOYVhssUZV84adg+n9fJfbTKn0seQzxdGKiSDZ3VPWcuC0JOvFfLeiqxxhUWSN9uftU7rcAbuC7EJXJPZPn67KU+uvUlsjU5vbJd8K4R11US1AkVyGATadasJ0/ksoH54Wbxs1tktyY2NU8SbNX92TPT7gfHnYLbb86H3n57unmgkyWdDAEILPirclvlCji6XIFgLk6GCDQtQI03cd1bMjpngn/bQJHGFH1vZ9XHf55l5w3UTrCiQgCXOKQEVYd99m4DD36KJ3JD2uB1zytH9aAQAkpCtbbjSRjkKEG4yPeNkNYF7sGNi3CHs5wFf6LkT1+aNm7pb297LvrEyVxVkfO882rjtCg/90Q5T4Qit7Gv9SCFAinz/iFUsnMngsW/Fmj0ueJBE7jJi+N/Fwtb7SSqIv2s90ev5sH9AgcXB17ZHU/PvPpGRXwna3Py3pu47uOFUSarAqh7A2lxPJNclHwnjzPGyjEYcWHXwmttZqbwNEVpEWyEQGcmvHvV+FjXndn5BweQ1KUDknqY+1EXWFxdw8qTZhAe2zgxJn8Zi3C7RrCHO8AEaq1B2FSZnR8WYBUTnXASegS/WI25z3aFY+9gyIfM30LJl43Lj7G0Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(39840400004)(136003)(346002)(451199021)(7416002)(44832011)(6916009)(66946007)(4326008)(66556008)(316002)(41300700001)(66476007)(54906003)(8676002)(8936002)(4744005)(2906002)(5660300002)(478600001)(6666004)(6486002)(186003)(2616005)(6512007)(83380400001)(6506007)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yDg0iU3/USFvS6bid/quI4ltRzmAR7TGOEPhD42G2komIZQQJnLIlYRSM127?=
 =?us-ascii?Q?9GqG5ATC2hdGEONS0NI0PRTVnUwpP6krVCL3nc8Qr2W53O9ZLvoVP2NmviUr?=
 =?us-ascii?Q?AS6mSots17l5l4XclnitdzfvhSMmPOTJOIlGXKrvmVL/s1r2fCjlYjSlw4lV?=
 =?us-ascii?Q?OGvOzt9BbKZ6pdj3dWDTiraOuDEfL0TXUsp0Sspem41dvqnak+IepatJfFhk?=
 =?us-ascii?Q?s8EqTq34PhKlF4YMxtIekPi1lAs6XFeL5O0JopwHVbBsOsOvsr2gdwb7QDmX?=
 =?us-ascii?Q?IGzBm+0GTTUFTvC6W8vqZXnA7hH658YPT8V1DR4dr6oCjgM7+I+Hk2FS8NW7?=
 =?us-ascii?Q?7mR9efm+ymTJoeJCaPlfmnostlv99w55/JGdgEtxzjfiTGyFRgbwKxEsT4hK?=
 =?us-ascii?Q?VjOQkcjd8wbdMe48JciKtFqzzmTPsN4Bg+O+GlqnrPBOHoR54i/BT1rJJksq?=
 =?us-ascii?Q?aI/9UGtjz40q80hjcwLnAA+ezQNKoZT3smhV665Ra0d03Oo9h6gxPsxoM6j4?=
 =?us-ascii?Q?iHKBeEt6VdxCkp8Pc8m5lRa+42y1ViH84VClEqqyGGm46QETgwWu+IQqTrSj?=
 =?us-ascii?Q?w/DXqgDrCxf8gG9M75GSn17LtJ3Td+8wU8Ivjb3H2hbuoQZ9Nwc09B64e9Pa?=
 =?us-ascii?Q?EqNhf+1YWHlBDqv/KX/shv9hekU+dgJTYpumVSRVaKDgoPPkU9+YvRcK9Rv7?=
 =?us-ascii?Q?Ch+3Eb5saPOY262qDA407uqJmWsoQhrSIqEcBnD8iFPSvXo6UM13oWZIGTFh?=
 =?us-ascii?Q?qPM5Nmsb0cHOKIaDdlH7wK789MAAaVebKP95S35hrHGGyytmUvFnO75FINOD?=
 =?us-ascii?Q?JLU7lOThRrN9r2DdF8RxGISwPzC3XcZxYEVlXwTfI0odyMN2d80IskHZbxsj?=
 =?us-ascii?Q?22wj2tmH6e9PTfeOhWJ1+m3a0B1+EcM2DCEn/xpIyPwvqABDf4Q2NQ3SlDNY?=
 =?us-ascii?Q?hpHjO6hHO4S3LHFFPg9qNaZLmToJPcu3xx0uirxbg2NZbZT+PxezONNz0QYR?=
 =?us-ascii?Q?bAeJGWb+awbheTbcc7jxormW3LKs29tPmHWXsVPKy6ZjAkFqATwZIBm+0z0a?=
 =?us-ascii?Q?2Qn5j8mzxrZqxuQpuL5t/Uej/wR205rMUTJTnaa+OgpnZvTsyHIwsMqPDRsB?=
 =?us-ascii?Q?9Ps4CdTNQWdJI5Q5C1EFMbEN5C+nCpCfWBU5hqz+EDemu696aQnWfFqCSGAu?=
 =?us-ascii?Q?BTXAMBB/MNqrnq5TsEQJKQzZX2vdyT8dUqUlgLc+t+lduB2D3SNeQ8fSIuMu?=
 =?us-ascii?Q?wmVBFbyXDOSjbd4DZwsFuOh+fbmSPWRmuG00xL1Kw9NAe2iyozKB+lCvNFp0?=
 =?us-ascii?Q?V5vt6ZzJoH6gpYSEaOsQkU6SuI+AsSZMNn66B5BQXY15exrDbBxvZauZ2Mp7?=
 =?us-ascii?Q?YuzghL6qLLeAiFmlBlnN1w6R6iYtV+VqXMDrXcaOiYahYNPt1OXU7XmeKJwX?=
 =?us-ascii?Q?jvdRRKmgQgTkeHUrzwZpsMMKJNk1e+scFBXu7n86wpzuqnHDdjACX9m76oNL?=
 =?us-ascii?Q?31YTgn+h1TNd4Fj1I5vLd+QIDBvDkYuFwiiOdjYx3vNsG0SIpcI3bPEyoHyf?=
 =?us-ascii?Q?R2pp/1ZuWb157UpIx9VHh4v4TFQOtZPsnBwKjUXMfKOO9jhQuNSZLyI13R1o?=
 =?us-ascii?Q?bTkfaOYdrwyVie09Xz5kP6Li8CwLIYqbgJ95GllgoboZBsFZNfGhFZ8WnJq5?=
 =?us-ascii?Q?Ww0OOg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559eb7f0-7226-4ecb-7759-08db725fc420
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 13:59:44.1932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cm+gYaaInOaTZU/K0pPj+YDoKOK5ASEAmfSxYK0oPo+n2/fuijuozSqfbAB1wizokV9zTZOoAnJVeUDsDTwhcf2w5urV/2j4o6PAmXDBFiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4118
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 10:44:20AM -0700, Tony Nguyen wrote:
> From: Marcin Szycik <marcin.szycik@intel.com>
> 
> Add support for matching on VLAN tag in bridge offloads.
> Currently only trunk mode is supported.
> 
> To enable VLAN filtering (existing FDB entries will be deleted):
> ip link set $BR type bridge vlan_filtering 1
> 
> To add VLANs to bridge in trunk mode:
> bridge vlan add dev $PF1 vid 110-111
> bridge vlan add dev $VF1_PR vid 110-111
> 
> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


