Return-Path: <netdev+bounces-19763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B137975C226
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 10:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26F91C20A75
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 08:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9314B14F70;
	Fri, 21 Jul 2023 08:55:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859537FD
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 08:55:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113D63AB0
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 01:55:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/HRLV1MkgdwRXVkrDA+D2zIVAYoWwJQyuiIrIa9u1Gce75U0h3uWUvjcVI3a5NAnCz52RitAktfbAT2AcG6tzC5p9STiJnPQSXAsQeIAmfA0q6qlA514h8sNk5ryBCFRk7GNR9usShAxatAi452Qlv6aTT0mIOHEfUh3NE5x60+UzNW+Y1pgH9VJgs5dtDhXZbPUTqgc8wKWbc6bRloAvQ/WvnnoBvemjQB5+cACGl5e9DpdFhbb/lOFxgSF4Kz4NmidVmkz5oEebsYCeqXDi8GrkP4YsTWpkxsy47HNt7fNrh77J9KeOKmwN8FTtqnRPabcyyDGi1YFaN1I40f7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l82G15P6sdfjIp2ZmDbFKEOCYPgTBzdVeTJvhP0+r3g=;
 b=Pu5qCpqbxmzv2trk2jSsvFZaf0wub7fMSvrvSTW3XxSiWlGNVayfbSGstoEpqx+QiJrjKbMY0hSAFyTtYZDJaV9RRJH6rdZw7LOAMEBv7D6+ME/ebnXasY27TddVVXiUNKfSibVAiQ3HV0zFt9nKi9wkjpgSus1Kqzl9WO497KIBs8g7LG8phDn4nIhf5fVdOyExCOW+wnKZsEa3SRcn/auFajBhwX08cgBq2h3jg2ku7bDmm+mDI4E8hC8DzlCPwWl1JOJR28nPsVLhmldx1JTy5nWVHXoLPjohCqlLeJpLTSte+o++3616g7ev8yv0ralJbcYzOTmwxnCUIyPOwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l82G15P6sdfjIp2ZmDbFKEOCYPgTBzdVeTJvhP0+r3g=;
 b=apEeWmCDTv8KUIhKsjyQGsMd3pV5nziLjNJ+dqkduLJ7ablGLTSWDeitnUtgC9XbQ+R2ZmCvWoLscsVEJXhmRJGqJTTYP0qUnsb5TUZu3HStBnPSC6p7Myoz8SHam12yMp7CplC6jXpuUzmeKk901eX5PTDfWhTs9cH+VEx95jY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH0PR13MB5472.namprd13.prod.outlook.com (2603:10b6:510:12b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Fri, 21 Jul
 2023 08:54:38 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 08:54:37 +0000
Date: Fri, 21 Jul 2023 09:54:30 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: kuba@kernel.org, donald.hunter@gmail.com, netdev@vger.kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH net-next v3 1/2] tools: ynl-gen: fix enum index in
 _decode_enum(..)
Message-ID: <ZLpHxiQT+1IAogMK@corigine.com>
References: <20230718162225.231775-1-arkadiusz.kubalewski@intel.com>
 <20230718162225.231775-2-arkadiusz.kubalewski@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718162225.231775-2-arkadiusz.kubalewski@intel.com>
X-ClientProxiedBy: LO2P265CA0154.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::22) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH0PR13MB5472:EE_
X-MS-Office365-Filtering-Correlation-Id: 97de8f8c-f251-4051-1257-08db89c81ccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FtH4V9S4lkInbt0YmbX9zdT+g33g78SkdeWetFjG82O8U3qy9tmfjfbSMWEtD9SVvlblXIZuyKG5c1nW3IS1Zst0CEe+pccRhHUYkycK44WKZqFdmrUDeYRBGSdT5zHG0JoavHBLNup0US5Dv1OKvJO2xH16OPid8d7HVLc2ZNWCqWA4i0FxClaMc8DMyjsffs8+WoRucVXMv+PN3ajUIr+x85dhC3HmZEElJkG47+oJsl510tE1FP5DhonBkBiLPv3nzHSMyiKYr4gjA7O2kWKgGxKNFnVmJfTmrADoiRgQltogKv3luA60I7MtaiJbiTOkDrH+NcfD5xMg7zXwzX/sj9PzBrA/X9jihTkld0U0fnU9wmQ6o4+ZPH8/269MBjWEy99y4MqCNfUWDil3dlbWkXeXaykoSvRx62zGQ0nkgn/5A2iBVQlUVc/zzZ2JyQm3zS1BYphORN80TJpOcJ3cydKa2xVFQj9cIRsJOf9okPdKWpTY/XF1y7723l9/T/KYbqlm5RKT4jnclx6yA+XM4nGmBU0pkKI/b3ZyLowrgfEeVYEw5uQnr9iCEFomNF7y6r2aGULDkgwQVz92igEALh/jqW4Stthxn6DCi9oUwHWPV28bQTKcWCAk62R8LpGlJ5YO8kEV0V074C/UhFURhIipkd+l+ctVFKH5rDk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(39840400004)(396003)(451199021)(66476007)(86362001)(6916009)(4326008)(44832011)(66946007)(41300700001)(478600001)(316002)(6512007)(6666004)(6486002)(66556008)(186003)(8676002)(8936002)(5660300002)(2906002)(36756003)(55236004)(2616005)(26005)(6506007)(38100700002)(558084003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oEZxCaQW7SgvPT8qIJBY6pduVEb5FANqZUYAPK5bBXXGVXUjqgQn9+CgNWX9?=
 =?us-ascii?Q?QxNYdxXwA345tx6RANN4tAvcmFdGdx8seqPE972f2ONWfLohu7NdXV7CSXvi?=
 =?us-ascii?Q?gs74t0sZLmuCIHekTU0XtZB8l5+sbSK8Bw9I7155AXBqmdAWFQSHAG4SJyEC?=
 =?us-ascii?Q?1snpWxJl+K8fuBvFJRLHMq3obDuRoPN9YB1MMQHRrHVTeXY2WfkgCkbHQ4sh?=
 =?us-ascii?Q?udUewymmsoqGq9gIFb3gdJsHgC56FcOJZ+UAXqG5NyX0FotFHDSYOMhcFaN9?=
 =?us-ascii?Q?ukFWa5wxtt8axNxaKJkU+vbHEACPHIQVC26A3ErvjEuI4gVuSK0+6F99N2IT?=
 =?us-ascii?Q?9qEP69LSJC4LmKdJDzemULWn5algv+RmibD94nq5UIcK7jWfBk4wvP83biuV?=
 =?us-ascii?Q?n4ppHG4PVABy0D4lsYTB86E4d7pfPjI0qYsG/cSXUT6EceO+C+kq6fMTIhbW?=
 =?us-ascii?Q?HFPYy2ulZVRzfx4lEkeyOk16jCxBi9J/sPkD4R5++m4fq55Fv7qjtep1zr8n?=
 =?us-ascii?Q?4+yveRVYsMKE/lroEPIQ0Vf75t3bFa4yf7sflvrJ9kaD37C/gdrPoRoaz7bR?=
 =?us-ascii?Q?almC4D2OCQbOfSUiEtsgpA+He8cgkq2oKzXwFN55PxQFzkhOgBSsYA4H3fT3?=
 =?us-ascii?Q?eCnW594Qwe1gsLuxvQqjmZBniPP5C9T5GQV1xkXLTx/ijoJyy57hhuIJ7PUf?=
 =?us-ascii?Q?wWy6L7+omJgjPs06YcFolUrXM7+9FRxw9FP196XRtva9++zyat2WPFo9C0V0?=
 =?us-ascii?Q?z6sY2gLL6iemnFng7vhQzmO+wQsuVDu5A5Xst6opOtJKtKsIT+SeVpziTLzi?=
 =?us-ascii?Q?QaGkMmC/v5uXJUUij1Hh+25p5GC5skl3OwQjDm1UJ6LnlqteSCyUFukN28WN?=
 =?us-ascii?Q?WCWA0SpNHmhkQllgEKPhj395j7d4q9ZiKhf+ArrCL9xPoHQNeMpwzzoJM+3V?=
 =?us-ascii?Q?Sj/uGBhq+5L5TszN+8//Traba9pDrqSm6OeK77xOR6wfuUFx/9ZfXU4R1Xm/?=
 =?us-ascii?Q?qeVng7h/XOCjJRNRgVwqo3u8aztbFnLfb+kzSo5WiwSxSXdMwJdpOUidw7oC?=
 =?us-ascii?Q?qFCvUkJ81DaT0tnJTFoUhiDdIUHeacZpYHoU4JBF0JPGe+o1cDyJUdwOIThz?=
 =?us-ascii?Q?jrKeIthvRZ3Vp0OXbIwF+jAwnVrk51EXEJw3KbQGV05iekgIMhBAoqBxrD/w?=
 =?us-ascii?Q?504VEUE3fMN5x0nvrg/Ly8MZWhVWkcT6a2lqlKc2GNLFlggIrrnyjmhYzHxw?=
 =?us-ascii?Q?kS3Ikp3vUuck/rXx/afWUapAdMPQ+WUjYY1ZRFvs5ZgEjoxm58KsF+m0X3jK?=
 =?us-ascii?Q?COkFHEeRdMepLuxAJ5SynHPxOdKNaU6hsjlv4ocBeu4Acm7T7p0Hm0QbkRXe?=
 =?us-ascii?Q?e9Xk/dzKno7+J8ECPkIXgnDcyuBXOjMKkvJLGArWyQ5IRJMMLVYENj7CCsT8?=
 =?us-ascii?Q?1nacR05wWp2LVbOivY21Y7nCYWBqBHkRSVRj/Yhib/uwteuqJkas8tEJNzqP?=
 =?us-ascii?Q?FK5gaNMXWxKmaP7OpCDuFM2Fr9mHFNpMj/n5sXs9J7kB/FcNV/OpupGJ+fZn?=
 =?us-ascii?Q?4CeY8OQXoe2CLbozbvOl595n1rUuqVg2fvuKY8FKEU1ixaIhemF8xPvijBkg?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97de8f8c-f251-4051-1257-08db89c81ccd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 08:54:37.5114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ukC/qc0Bv1HdQGBm6txFTZ1XQnTRsoMWNr8cnG+uvZCa2OTuaPwJB0gIaY8Gi/3bDgMD61D5ZiIyIiG4GZZek+gnt8HqIzSXZYD9CZZwuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5472
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 06:22:24PM +0200, Arkadiusz Kubalewski wrote:
> Remove wrong index adjustement, which is leftover from adding

nit: adjustement -> adjustment

...

