Return-Path: <netdev+bounces-13277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DE773B1D3
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 09:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C7B28194C
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 07:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB347138E;
	Fri, 23 Jun 2023 07:41:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89D617C2
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 07:41:27 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2101.outbound.protection.outlook.com [40.107.95.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FFD19BF
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 00:41:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/OifthQ0h3mVtxDpl3aHgFmWqhUo6Xt6WLDt5OSTayWOPiYXuGg62mk/ihiCk+BlKXl+N+ZazoKwoiITVVno1l/urCt5v4ZFzo3a5CsjsTZW5kXa9NBQ1BjPqESco03PU4wI86QTHfoLyjNGzXRzpMR448+zCzEtDW9uY2Cuq8y07aOBTa0MWd4dgOgKiJgyTpgnvBdYWj0yCJRsN4oSajOlE3Cmxc7FVkhRTVm1EGZibRzR9pNtKwbkgufATTrurFMuQFV1ig5spQfsq5FSPMkTBZ0ES+H4zs+4oDlX0GJEGHmiksiD2Ti4aQ4ZdLfPQSP0mmZiavV9iy7BhQVzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZEftT/Td3v20z7EKffFniIyncUySf/c1eD8co5L950=;
 b=PWFlB/HhWmSObwzX077CO4ht04TPHBDYOsWKZDp+s4sQznPBSOVI24bPSARDAp895TqbJlXa8qTJTBhd1LWrFSzPWtLk1vQ0PHQXoSQhusZ2jg4BKwOAEYV6xIp+o1tjFNL+LU+CPOh15S7fDCaRplQ4kfTxql6RWMayt5X/fa9dwmIqmwPMTyRgcPZcJ4zU3Z4V/huERh80M2mTddOe6SHLcGCS2kBGf8O5mlKXnPtDF9Xg/FElyOky8vViCgvmT2ufcat8n5ehTM2JxGSwtzYHUrLj0i8j3F++N8DL1wKzuEkllX+fhXyHCyl1qmGtV2xOf4bqsOcyplUt7RX4uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZEftT/Td3v20z7EKffFniIyncUySf/c1eD8co5L950=;
 b=b0tSxh7vWQP1eqtICjyHpCH5LdVg7tV77bm0vBpbkt80ywM1g2RMnAbb8hmGmEiyOPRd/Zqzqko5+f4RZptnzjwf7Tn4lV1L0A4cZccEATbyV6Ey+iaG2hSGZeWCmsjjeRDXKGKjuf9O46tZNJZnFLPMLrGmpQpN2TymK+8SO6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by LV8PR13MB6375.namprd13.prod.outlook.com (2603:10b6:408:18a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 07:41:23 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 07:41:23 +0000
Date: Fri, 23 Jun 2023 09:41:16 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Piotr Gardocki <piotrx.gardocki@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net-next 1/3] iavf: fix err handling for MAC replace
Message-ID: <ZJVMnAVwKx2b/13s@corigine.com>
References: <20230622165914.2203081-1-anthony.l.nguyen@intel.com>
 <20230622165914.2203081-2-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622165914.2203081-2-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: AM0PR04CA0082.eurprd04.prod.outlook.com
 (2603:10a6:208:be::23) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|LV8PR13MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: ca90965b-8ac9-41ff-f22a-08db73bd3e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i+SAJnCrazoAaFmOhizjm5qF/yqCQpfpOTsSdS1JWOf3MPGfwHHB5Ka+11QVpbgre4KVgDFu5KN1OQT4FIlUsQbbokOsiJcn32HEPOufF11gRS+wXnHzwIiFyb4/fFEZ7nhCHV0dBNDEDOL2uVbWv0BSNFKJAZuzrscCbyas2rTSBF6aN+k2FE1ATaEvC5hOx/58G2puFuLDXB5n22mdDSR9lCNVialfEPlNF6w9jOznsk7RXf6wo5fNUBfNJjps1rM8XtxalLXat4j1Gk1ewRIrkgIduFqFiXcwLIE8mOQBPpUq1YZVkx78REHel7msdHOJMZBNecgMjG7gIMMnCisgNLlCpaXcbbj+sGGGTRfe41TH9DLHMr9iP4+4n+Of0U/g8Jcfef4XQdHzXaSlBhFy6bc+SC0KR3UYMK6oEZwJtz9uRcWeN2VxrEQL+BFpw4NwaopwKc4+UQoFhHiw8siXguxJ87IUTgWN6xC9I2CeLuKZnfsJwaZJkW3W9wRiVjYsdvoEOS4YF6MzNXpnMXkhxB+5Qt/nRg7Nk4Sd2xWB/iuqVd4naglkEGBNMvg2Myhif0xcGjA0ZhojMtCFFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39840400004)(376002)(346002)(396003)(366004)(451199021)(5660300002)(478600001)(6916009)(66476007)(66556008)(66946007)(6666004)(4326008)(316002)(6486002)(54906003)(36756003)(86362001)(6512007)(6506007)(186003)(38100700002)(2616005)(8936002)(8676002)(41300700001)(966005)(2906002)(7416002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fw1a1mlNwbduMYn+aTUTdupRgKmjn4LOMb/SyfcgnSHdV0Lj72fF8y4eVPts?=
 =?us-ascii?Q?r0ttqDq3qyzmroG2eEyyjQWAyeasbamLqLUis4boQGYkNzJ8c7uxjzsKToAy?=
 =?us-ascii?Q?kAKjK/M1isSQUiwcmWVfG4rFkMS8MHRbktZaQjnI9vnFLk0IysEA+2/UuXkH?=
 =?us-ascii?Q?KuGzp/6aKjjXKoDFwo6mg23yksGGobX2VSmfgnsRtY95Ozj38YF54CzWPWfR?=
 =?us-ascii?Q?4v2SKwjQb+OtMopx3jtJGzv9mJZ056qqhu5nAzH4oHebJ5VhgRBtKTs+QQ4b?=
 =?us-ascii?Q?TNeEvPmOqjpDa6OnxsZgUtWPZFFzwBxQGAOqC7VhMlprApelkHOmZv9q7qYg?=
 =?us-ascii?Q?IzJWgXh5Zup5gSsSCoPgZOoHGff/aL9nZ3gMoZEAAkAhZ6/7PycU7QOncShX?=
 =?us-ascii?Q?OhsVX62iNiqA46UnbRM8bqJ2TOGwhos/rKja821sK2PgkJUS+iRLsv7tYDXD?=
 =?us-ascii?Q?os5zTAQzaruvsTRoWYh3YBcjN2OXy6vS1tGBp8p/2hYl66nPuE2aPPHoRbNy?=
 =?us-ascii?Q?Ega9XfFktwASeA2uw9mkWFGqNmntkmMKwTQSQK6uTvG6WMgdS88fj5dVBN4V?=
 =?us-ascii?Q?vejP8vnMgQzjHwKGK60JvGlpmB731syetu+tauWmw/3/325l7iaK5aepAXoM?=
 =?us-ascii?Q?ttv7WBe6kEiw4n81vJw9c4TOi2FlZqpDJYOfsfpnLhz4ZYsQA8VfLyrwScWe?=
 =?us-ascii?Q?BNrZcYMgZ7tZJjcnjVPQJsHgu/f5ZEDlq4DgfjmnKy86Asq22fm5tdyTBIsq?=
 =?us-ascii?Q?kxADZ7Es1F+guQNIQzqQHTRT2Vq9DMtDzNDICi/T423GoYdSjj1OsOW+X0M0?=
 =?us-ascii?Q?sCGdWIvZLSe/1MqX93CdGeW0wBlGYARoeWxiKfMxYjF8HPVTLObGukmt5jWd?=
 =?us-ascii?Q?ie3vRKmudZaeY4KZBzzEKGSgqmoIPyLZKWYZ++/F+HzUeYtIERixL38DidKy?=
 =?us-ascii?Q?cZ4HtlpEkwa/LhVXSWlEN0N1Znd8Xa7h6tt0AUKR6jiijUhU4fsOfxWUPLPx?=
 =?us-ascii?Q?FhHAvBkjxkSvPOtZg1/2KU0ERcVc6FFpBhYZP7nyFlufHFZrZLxHAXaKBEav?=
 =?us-ascii?Q?+ci9cwScXYAjz5D7zqgalhY+WSpdRPTEH+pQod6gB0IQQTcm3Dg0ai6qkWCh?=
 =?us-ascii?Q?SQ7kaJbuIAzJLek/drYj6U4zY5i31JqY6Ozm/IHgi9s+dfDeLcSVT6Yv9LKj?=
 =?us-ascii?Q?BghHhtT2RGZx0dvoSETLyx31UaC6oB7UxUztsCiiCFV3aDqZfaUMGNTGBR2Y?=
 =?us-ascii?Q?bFY8Aj/5w+wEAzcdNRCqljnu8QLJ+I/+fiOPDt5DS2h1qo9i9sN1FCuhGM1F?=
 =?us-ascii?Q?VqMo3pcMqM/kx6mcLG12szOdqGmKJrAyz0lYWBR2eb0iU9s8WcArPaNQLdLk?=
 =?us-ascii?Q?sRId80eoySLweKTVW7i41of5oSDt3XLPWlRUTkjoi9TOud9nerazsKD2wYFf?=
 =?us-ascii?Q?ohs+FTx2CIxzFAuQzfej5x762eKhzIZWtdcpC6bX/CbKea/C83uPTJ7NxWEs?=
 =?us-ascii?Q?hutdnVxnuDauGtLqFbe/uQ05WTgKYG+dVa4v30N0DEwyEdKUTfTetQ64KmE9?=
 =?us-ascii?Q?ZGZAKohWTfoQifLVYgpJpzeDwxTy7x9z/Gvbwzi6qoGm2Ce4jBjuk1HGuQwK?=
 =?us-ascii?Q?bsPW4wygG+nlaOlhhoymBBQzS3Ko/kAzXG93dsavbGQune503hSsNGLrLYZ2?=
 =?us-ascii?Q?2N8XcA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca90965b-8ac9-41ff-f22a-08db73bd3e13
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:41:23.1514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPVTF4EitrwgOzUGfpjxDf1/RcneAKEmuf0i2Jh5q/mbkjuZ3pWiM8PsieQEiIYsewLTsrG7yJHnc4IoIch/Sb+c5Puh/64+b2BNT2oSFxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR13MB6375
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 09:59:12AM -0700, Tony Nguyen wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Defer removal of current primary MAC until a replacement is successfully
> added. Previous implementation would left filter list with no primary MAC.
> This was found while reading the code.
> 
> The patch takes advantage of the fact that there can only be a single primary
> MAC filter at any time ([1] by Piotr)
> 
> Piotr has also applied some review suggestions during our internal patch
> submittal process.
> 
> [1] https://lore.kernel.org/netdev/20230614145302.902301-2-piotrx.gardocki@intel.com/
> 
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
> Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


