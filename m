Return-Path: <netdev+bounces-17462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE1E751BC0
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 10:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0BD1C21308
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 08:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7268F883E;
	Thu, 13 Jul 2023 08:37:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60778883D
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:37:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2090.outbound.protection.outlook.com [40.107.92.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B602D6B
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 01:36:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyoZWTUjDeBdZfzQZ/0ODSy9MibvtXYH7MkNHzOuVDoBd8gxMdrAcmrdqrevG6nu1XJKSZzjqKJw7ieRjKH1SOyehRKplQN131SCh8b1hm40Med52PRp8A9JaCuCoPwzvP7ZviPz38NXxRjaK3LtkcfKO5eDoZQXBlOJR5/DfNuJ9XOzqhJ+UWlTj5Jh7UHQx0wXk9UoiMMwZMU0e5jEX67QII7CgtSa1NRcjAEncRoYMlD5C5Bz3gzVF6YR63vYE4HtjQNwcYPYY51lYzs4e+FYRmGAr4qAPl6GAPiiFp3wh0d/A2hzhJ76qSHRNJAYMTRK/N9XnIbidd0ZlPAPJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INMxC4kUWBLRWsvXv9RmAKffnFGspFDPsMJsmVJ0qig=;
 b=k7rObdVjD9sbk882Avjl0Kg2xxkuUxuLrYveOVYb4y6XEaE3pkHRCIvWNoONRLtbK7L7A/7DJ/pnILkgfy2ao47WtnAGO49AICE3tvQnrC2fHTjcOFCVpg6WAmN7/xWo1wTJY24liWPnf3Dz3oWxmqyiHaj9VXYsUjuP4lf4exOy32rJr3Lj0CQetmJeUaCwKocx8sH0wl9A/7mGM9ptcW5I2v52DYpP6QcfFuun4LCZEaaNynIYBrUQJWFZNUdEH1cvhQ5BultoHiuJ1QeUJ85+CwSS1DHlkkGrUZYSAHqXja14wjfHyNlDfDD3VQgb3KYJsgRqxCrGA9YK5Tyk3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INMxC4kUWBLRWsvXv9RmAKffnFGspFDPsMJsmVJ0qig=;
 b=NBXdixU0zUN6qHGdPb56sN8d0FCdzJkfPQVMlTPeqM/N1owJtEtw7Kbu2QO/poGNuDdWK5Eha6Ki6ursLNIGW2vnSu+LV/4aAl4PMWHmzHDx0yiRv8UPhSywlRLW+4T9vcxYhPu3PbtP1eZdqYzUlidWD9PuzHc2B9xupb1f3Ho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH7PR13MB5866.namprd13.prod.outlook.com (2603:10b6:510:158::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 08:36:22 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 08:36:22 +0000
Date: Thu, 13 Jul 2023 09:36:14 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
	shaozhengchao@huawei.com, victor@mojatatu.com,
	paolo.valente@unimore.it
Subject: Re: [PATCH net v3 4/4] selftests: tc-testing: add test for qfq with
 stab overhead
Message-ID: <ZK+3fv/gXRySSY42@corigine.com>
References: <20230711210103.597831-1-pctammela@mojatatu.com>
 <20230711210103.597831-5-pctammela@mojatatu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711210103.597831-5-pctammela@mojatatu.com>
X-ClientProxiedBy: LO2P265CA0304.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::28) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH7PR13MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 311a2f24-89c5-4b6d-6031-08db837c3cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wdsh5S/dk93TW+th9XyojTtT/f+A7n0LDUoHVId9wBxYsxP997xBWX1QLKH6ojaV88ueUNtoMF330kIP13lkw2VDy47wipyqdmAEHkaskTFIkWeZF3E50RrfK2V2bfapg1X06PBAdGIecYa1GNas1Ljv1RHzaByMYI8tjG0yCgYAg+wskb7FZmC2g6b4PvGpc2YHNC5p6PVy9k5s9IrycCBPIdoglTq5LYWRCJAAtCbeWDad57dEibsfXsI6b9GwkUX59hafCgq3E4aEO4zzij4GCnnjn9PdxTGdGyloQf4bJpyjNDQDR7eTpi+7Y93mdViEXSHi/UPYE8+bzcnADPzS/QAL774+MwcHT2Vxf7K+H+zc0ChsZQoLalkDO6q2dWv80/ye/bD5QcbS82FS/hibhltyL6nmRQCOCLfvLGJQmwUtv7PX+mvyBOycPc1+sOKX5Lx8yfxDM/ttcWIbCzwM3eQ837LE2rBbZ+qBZ71GSIiMEh8oFMi3JVaEY8QK5EaYNj4x10oIWipPv5aoXrSfXAJeUFkTsCHEAf2WUlqymWI4WTBWJ3O0UUkxvENNv7++t/Fi+nsSC0baRJtwVHDSd5xUZ69cnYRbt1cgt6o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(376002)(346002)(366004)(396003)(136003)(451199021)(44832011)(4744005)(41300700001)(2906002)(316002)(7416002)(8936002)(8676002)(5660300002)(66556008)(66476007)(6916009)(4326008)(66946007)(26005)(6506007)(86362001)(38100700002)(6512007)(6666004)(6486002)(2616005)(36756003)(478600001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0ck4GYi1gxM1oAjXvLhxmp+mAK7e31IhAgXm90bqbzwkwEkiy1xm6cVCHWXX?=
 =?us-ascii?Q?s1a7NG/oR8T02fs2VCB3LCiShpHp8CN3v/kYoEoKX+jWefk+jvwTL7Uk8cOr?=
 =?us-ascii?Q?U2LDtEql8bxAgOnNsRjsb0nOV1gWqHyP2pViL3nYSAWY8IhWW9q8uJQszgNt?=
 =?us-ascii?Q?hrKIrJ7CwqHLsdndJEMDrxb3Hy7KYfUBmLQXQz3eWi7egJQV7tk0bOEJbhE2?=
 =?us-ascii?Q?/PaZ3KflnYj0qfdr0aUYjnVeK32MP3yvXtqBCuiv53PphN0yQ5DYNdc7owGF?=
 =?us-ascii?Q?t+wUFgJhTEfxQ/aGqyOEkhIsmREi9S+ta6IUUCTmmtAkHNg/ei3sDXFkpt9F?=
 =?us-ascii?Q?5NkUhqxgbTO1rQKCAyazENxLrzECGJaa6HbRdcZDzMYNcgDd6HrDETAaLgmg?=
 =?us-ascii?Q?Hr8BOyxFSXr5kcCm4Xm2uh4hMYECkojXmqPATxSTT8Bh7mDYnnEVqc+MT3ym?=
 =?us-ascii?Q?lugxof4xQ09W7QMerEZAblYhdiAmOazX3ElfHYxlj7sUwDKoh+vSf99tRDzN?=
 =?us-ascii?Q?OiHUXsaJ0vUbK0Jv49OWyGR3PNMdD+4dqlpWlgg9i3VCEQvhnFBoerRJozuL?=
 =?us-ascii?Q?twT/XMiTMC2iQN4A/thkJZn/sc0U3zwDlnM571M9znHTNFOnDs+ZkswfC7xH?=
 =?us-ascii?Q?oNSVgoKzluBjf6E4Dq5IcE+zkcY8yxO+ssd5v1WxcIpgNBifT6ky2aw5qfAl?=
 =?us-ascii?Q?bCKE6F7jULxezv8h0CLxMAf1HLb3vwtuSg5hNvDUCwn5vg69BA6cBhn0r4nx?=
 =?us-ascii?Q?MetR7GwR5S2tdHxUJmdYshsnlDPEtv5xd1VbmSIsVWrpA25sUlUJkvMfj/hv?=
 =?us-ascii?Q?iaFNZDAi2cbjl+XShwfe75HARRpVXSbo0/YlRtCtOGq6W+aSRNZaZ6vH20AU?=
 =?us-ascii?Q?a9ru5P6c9Yw5TOq7qi+ItMayy++9TE57/sB7xBkZxK9szNGSHdNOPqgmPVWo?=
 =?us-ascii?Q?HEtGoJ138/2hQ6caH/xziH5LOXuLWeI7wml/U2QC7usioDg/X3IGN9XmHaCo?=
 =?us-ascii?Q?/EafC6SqXXDM1hYftCbRiYOgn46Cz6vbrJaLIX2RezSmaDGNUywkvcBZp79D?=
 =?us-ascii?Q?2hd9yTgc/thZKuNrlh25UJqFmb9D6Jn2qtB5eGD3EscEGL2a5ju7EkgrzGWw?=
 =?us-ascii?Q?DahVz4kc34vvLBfjGx6PFygygGL4O1EIFQ3qAOGN+B/01c0QCip1h2tSg+1F?=
 =?us-ascii?Q?ASzcZUbpV/6DEonS61pimApsmlm4ejiC3Be7AbxlIB93jYYlIYUbjTSfNPMd?=
 =?us-ascii?Q?CR1IWX46x9XXkoQMeZDuhSlCTRgG+zgqwSXBxOMwhvCp5AxFeYW73u+bdVA2?=
 =?us-ascii?Q?vvxQrVwFoCWXP3xkxWEUixTNCJRp+G4EmaTi2/1vF0LRiBurw6vor0uutHsV?=
 =?us-ascii?Q?fsRFWsydHgwe1+okyRgENw/YcGS1GZhfPFSr715BjCKy7CbDMMEs9aIK1Gyk?=
 =?us-ascii?Q?NL2my0Zkq3YjVZJGdXxUIVGafJBO8fV9BJXPlERriA9U48b2cbNd2QXX7rsq?=
 =?us-ascii?Q?0W8Y/S0/75Q3EDNMwcVtVy4YMdfUf3SsjTDiNCPuRZnpa2AWqOB0Hxm9Dj6R?=
 =?us-ascii?Q?fpRU5Knsp8L3yGK8dSufB77KzNupNgTpS/z1AEBW5xsAznR3YUHgSfV++nun?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311a2f24-89c5-4b6d-6031-08db837c3cb3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:36:22.2059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzZUyPsdcgYL5pQMVuW7kw96aYezl+0oLe9ea74QtQYvylTK2cj1AeQgp3UCwMPqeOccLE0bfgL/pmp4/b0/rUKphxtkDyitBr7WNP/UGlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5866
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 06:01:03PM -0300, Pedro Tammela wrote:
> A packet with stab overhead greater than QFQ_MAX_LMAX should be dropped
> by the QFQ qdisc as it can't handle such lengths.
> 
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


