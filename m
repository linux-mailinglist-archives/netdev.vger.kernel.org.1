Return-Path: <netdev+bounces-21906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED3C76532E
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 14:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B765D2817DB
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 12:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500F616436;
	Thu, 27 Jul 2023 12:04:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424B713AC1
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 12:04:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2106.outbound.protection.outlook.com [40.107.94.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC273272C
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 05:04:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLpbD8nT+oPZvTSq1DgEucNd6FG7x1pL6galieF60VKPfV3TME+Hz4NWixIAhmjVz7MD+3W3dOKV7Bq6SfBOK09gJIk8OfvOvbmMFox3otICPt1XWRsQX/E7GjV31FYgX2DBPSHorh9xnF5csDW7uqm+a6uaXO6boDlXORnpa2hQHsClgW5Mj7p5PLiWrTJKafHGpRGX0qtlkLyUvJ2HL633yToJS1Z9gT9l8lWWs8llBy083IBan9lnqR3Cz9XaFEyeQMp+y/Q/UUG4ELAojeIqcoB8YtqzFfvbYe3aKgDbXohQaIjO+0aXf6xzwgTwn5XW6/7o+bvXZgAT4833Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aqsditGr5QAqh/nZbqjAGQ+HTaagt7D3ha/uFIXpVk=;
 b=loUREkwaFq3Rh9mnDlki0lD65FJsX0Gv5ZooAJYxMdPQn9fHtcg7Sjqtb/TQ+UQuSKjZ4dlHKdSoi+DC7GZTSDKcSKn7ZHaoUrur7IAojpIxwWbA0aNt8JzrMX2CiLmg5JqmOa+nN3y9ld1okQjAGC841/rqAGqH4qy60XmxkepacmmPg8bJ/hMg3T/8i948dyIp5ASAQJz/db3EYYS8x70kwleWUQE66OdTU05ODvRxsZAMsrDyBb02Jx+ezZXjbkexDn+Gs3fui5xnPdpldijDvII1i7jv9JoTwnLEM7DNYlUCCMR8YW4ld706SOGtP1OwqE046giiA5skmiPlcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aqsditGr5QAqh/nZbqjAGQ+HTaagt7D3ha/uFIXpVk=;
 b=uzFVkGpYZ9M293jpQQClyrclsusPI7w4vicPmAEqvGWzLgSg9lofUc9ZLO3opZxgBirpkpa7RvDpIe7a5TTiDa3o8iv2N/hNQkKxNp1Yoh1rNa/b3NnB1f0CJoUSq0fMf/dlA/Oi4R6rYmIcjf/NaBBJ51Nk22AgVIhuEJ6ZgW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH0PR13MB5098.namprd13.prod.outlook.com (2603:10b6:610:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 12:04:15 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 12:04:15 +0000
Date: Thu, 27 Jul 2023 14:04:09 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Patrick Rohr <prohr@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Linux Network Development Mailing List <netdev@vger.kernel.org>
Subject: Re: [PATCH v2] net: remove comment in ndisc_router_discovery
Message-ID: <ZMJdOYFWq19m0Bq8@corigine.com>
References: <c3f90818-3991-4b76-6f3a-9e9aed976dea@kernel.org>
 <20230726184742.342825-1-prohr@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726184742.342825-1-prohr@google.com>
X-ClientProxiedBy: AM4PR0302CA0017.eurprd03.prod.outlook.com
 (2603:10a6:205:2::30) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH0PR13MB5098:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d1c126-30ef-4b78-fadf-08db8e999912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j4giz1k09wntHcfKvbqegkBV+oXpYM0W+m5/IPDM5L2aItIBuuzqJM6heCQSWmivyfbwyPj3trqdT6sxtN5vUu+Lm+MlaAieq7IAH3yglv5ESq20QH0kvoIo9+M01RwOp6mcyWgTc0EKq3MSUsQWr1ATX6Tgemlz5b+8j8vyCHS6rHeS9SPc6TuT09ZmJj5iDblTwKCP1i23qaIo4vDoEu8KlCqTBhMUYoHfkYzH5LswSNmoqFvC+8JZnlZrKkSJxqIWJyRVjAO645+cibp4NSCazkzf90qIBlOEL2c9rw1M+qliBx8EnEEV+NGPe5I2oOwvU2okGHNDUnWMrqHC8wRtTzEN8FzDKcfxz/dXI4YLzUm/N/LAm+aIpSS+qwY1PphHkTyn5akL7r7ACuNw0FhY/UII3ZYaQgV4ka6oECbN6oYV7ZseE0c1p2pL90jU0f4+t9DfPiEKTF/ma5Ow+Ej8p+Lt+PtdzLgoPJesjFe+fMT0SHLresSmZ8SC8tXBCZUMdiWaiizXRiEG97h8JECyMiMfRWriAEbMbkQeTlaZL5/X1k6xsTUZGp5gIBrPOkZkpCnWKsOXzp9PE6SXsjO8xIfZqQ+OMxZ0n7OTDtU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39840400004)(376002)(346002)(451199021)(6666004)(6486002)(478600001)(6506007)(6512007)(6916009)(4326008)(54906003)(66946007)(66476007)(66556008)(66574015)(2616005)(38100700002)(186003)(44832011)(8936002)(8676002)(5660300002)(316002)(41300700001)(86362001)(2906002)(558084003)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UePlD/w0f8YvH7bM5ZPp6tFEa8EzTMnuE4Hnplx2eeZpE1wWz7s912XoFj6L?=
 =?us-ascii?Q?lcs9+O197+vs6njRaZ6jvh/nG2aAfbnv4GJW0v3H0EGvgP+iHZt1eXcZ2Ofb?=
 =?us-ascii?Q?B1/z54jsZrZq75eKH4n7ilaDhDepmLCP/JUnuA+C/oBgyeA5rhk45Qb9/wYn?=
 =?us-ascii?Q?o11t3IBCRao2n/R9nIZ7ij8x9PdYV52Cf5TNGfOTpgLiMClMCSEpLr0Z4ESU?=
 =?us-ascii?Q?o1U2zhG3YLIgkqhkkgShkKZSfubtNms6cqmGJ3rT7BfvObIYFHtF4bu8GME/?=
 =?us-ascii?Q?5GzZnr+rZZwMoezMxgjKhaWc5a7ezCcw/7kKnzbDZsfTx6/3Q26MH5DYdERR?=
 =?us-ascii?Q?bGqBFF56wih2dqDj799rBhEzFI2nDmQANyOybyhbZaPaT1MFEf3NLq/zUQK7?=
 =?us-ascii?Q?Tbp2OI5pFGwjIBMqxey0hY6sja5kdAmu+d5TKzs6G7FjymcNcZya8xX9r79I?=
 =?us-ascii?Q?ibQGWtNSWNjATRLioNdH2XJQF1TMKLY9QnZzMANXnMaAac3npS+6f1uCU8oL?=
 =?us-ascii?Q?8g283eusN/2L5+lcaWqpTKfQWEFKA2LBLG7tHcRcFssJAFn+Y+d4TQlAILVZ?=
 =?us-ascii?Q?cUYpji5FVWBzSBRfKEz69/1cdZktxHzbAe11Tg6P+zMOcK/zp9ieTEmyK57l?=
 =?us-ascii?Q?vYpZhXjsl3RMNHyGb38ji26kPxwuzJUBqO8lRQo+RJEXBBLkf9ghYBWrdfHV?=
 =?us-ascii?Q?RC26F/k2eN+olGVzwKg/9T/81+m6rZOAKTKSWQcw0V/vqlDxBap9kf6DR7+i?=
 =?us-ascii?Q?VcduqzevkEcLGEmL6/pYVWBGW32TahFtKJAhPWacoFGvn1UI8pp6utJ+taut?=
 =?us-ascii?Q?4LqVGHWqCZ5D6wq6fEpH1EMX0WWG6yrCPRKLRHkzTd1xaBxKl5Xx3mpgbm4S?=
 =?us-ascii?Q?QVQCINmdph8nLjyGhtmqYcjK0uQeI/PjxoXQvLy5Hscg3aGzZR4L652ivI0c?=
 =?us-ascii?Q?KkT4pKfQJh7QydoN+SbvChbs7tWzjb0LJowEevtkIUovombaeC+CpwelzbR6?=
 =?us-ascii?Q?VykVJkfnHTW2nRjOhMmeVJQ1PCP4nrmOqxqgC8OLKCIDRtP/JFCIoX8R3MN5?=
 =?us-ascii?Q?uiEGM0pY9WT8NdP7htAfxTkjF4HVVSNgWKb/c3b6HkCdLfms/FJYTLLRjVNG?=
 =?us-ascii?Q?oVCcxhvC7K814vdXroH6p/hsmqCbuz0r1p9W+s0PELXCXieDO0lIJg2Madon?=
 =?us-ascii?Q?AWrdx3D94HCY1VDpucmw8OTqWHd4Sl183mFJZNF5iSDG1HsH0WQBAIQl0Drt?=
 =?us-ascii?Q?YiqrmKId/eO2hYSeH6ijczVAkBq61mPc4kDT/mIjghzGUMsCTxxih3DZrv0t?=
 =?us-ascii?Q?q3ot5uMCduqNVhN4QA8WCndV1tTL62mcE37GnqIr5nR0Z2DvbJ15Qz5ESlNF?=
 =?us-ascii?Q?Zd9Z9mlkilNedbpIhGfVTUk7BOl0MeZD4IFo9SdV3tgWCaPtgQddq7PlShm0?=
 =?us-ascii?Q?preu3fIlgz+0TUfTz/e1j+FKT0TiMD9KNiwx2mjNpyMLJb3YK44pgkZg54bI?=
 =?us-ascii?Q?2SCKDtKh+insqgopnSOhgCHGJgCgwYSZoojiyRqSZ5nnF/75OKt9TSwN6sN5?=
 =?us-ascii?Q?HcL6DXmBLrQAHVrC8xjgITBrs8kYe+KzO5d7n9lwCQKrik47YxlEzkTYK52Y?=
 =?us-ascii?Q?sC3cTe0+xqaskgNrhLgQjmw5XhwZ4hj46jkgD+FPy1BaC38RgMpIFyGZG+AR?=
 =?us-ascii?Q?/hQLCA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d1c126-30ef-4b78-fadf-08db8e999912
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 12:04:15.3820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2mfft2T4RAZ7R5uUjRHRBAHNRxL5O7nyf8PlJ+IWvc6syG3Tt1qG/9/Q+8/GjvmSXX+IajofQDkoq8UuiGTUbKUOvsPki7jGHhAbmY58zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5098
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 11:47:42AM -0700, Patrick Rohr wrote:
> Removes superfluous (and misplaced) comment from ndisc_router_discovery.
> 
> Signed-off-by: Patrick Rohr <prohr@google.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


