Return-Path: <netdev+bounces-13283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A7973B1EB
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 09:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8876D1C20DF2
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 07:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A2417E9;
	Fri, 23 Jun 2023 07:41:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D753FE3
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 07:41:48 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2128.outbound.protection.outlook.com [40.107.96.128])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745602683
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 00:41:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j60TOs8m6/Ir6tla3u7E6wZLY50btIemiqMLI6a83LJg+aV/gVVTU3bv7SqM3YGZNzgDu8ucEzEgUtjm0Q7kvp3BWToI/AugMXckPnNgzK/39KXseEOXxhVgK3Psv9bt3rq5JzI+vrEAXB0wSW6/cldM+fz2PAzb7x3WdPiQFbL90njADrW/iQ5fKgC/n74b3C1IGhIs52a+IljvicwqCwwARgJ2mOKAkolBZRhbdn77ytj1T3mHkd+ilvpUZnxfp+VJaaMV0EJQEOOznuqluqck8d5MOsFx65d0BUorhbJtsLVflXbwA9q51XIFyZtROt8aTUNP4YIVHn49Cd74Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ju2TNKiv1wBVqRKXp7jBLZ2hAHLiV62V0zW5rs43jlw=;
 b=OPIGym+xiydCGeNkvlF8pGTsUQ3wXtkziIRAKedkkI8XUJWoKtdh91/UUJCH1pcekN/Q4ZSi8hL+YuWMSO1MkL29ucSKioEdw7p8RCmLG3hYbarpyUyydzMI3232as6+BROfeP2nn6qj7kv+poZT41aemNl5VHhJp/bCvmMYh1+LUb5LfnlFAG1HGY+dkHmoDUrSXx3U2ATuGMn/daSFiLgK9ZNU0aDeVQV2PLHw2cwKrgeukgPD+eE85k6FLunW9YDdD1FIuY0RgC9kVsl/sHmjk35mE67Yt5WXzSV4V882eE2fRcCSftwpq169UGpdyciKpiQLNgcnRoAVhXhtcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ju2TNKiv1wBVqRKXp7jBLZ2hAHLiV62V0zW5rs43jlw=;
 b=R2xoEsbvm0b3TMgCzUg9+6VWV783aojIUhONNKYi+8olDBiGpQVU3EB1Hr1zV/6wd8LZ7Yfm2/622uLPaCDD4BJnKZAZq2QOLbbnVq9RqymVNmvj2suOmroBAoUMqXTLXawvFyHNdTV9QeegVHXp9CYM9Odw/a/9JQo/swx85PQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by LV8PR13MB6375.namprd13.prod.outlook.com (2603:10b6:408:18a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 07:41:44 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 07:41:44 +0000
Date: Fri, 23 Jun 2023 09:41:38 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next 2/3] iavf: remove some unused functions and
 pointless wrappers
Message-ID: <ZJVMsrDoy6tB9flD@corigine.com>
References: <20230622165914.2203081-1-anthony.l.nguyen@intel.com>
 <20230622165914.2203081-3-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622165914.2203081-3-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: AS4P190CA0042.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::19) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|LV8PR13MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: b9cd2bfc-8773-4d97-111a-08db73bd4af7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1mPMP4w2Z7xP5E0yvgy4g+cUC250BzExGkG7Gyv4OclgGlwBAZpneggpUQEtaaEwvwcZn76RLdpC4Q1JVZRoLWtobz9FcRfllbqC61j/nZ7h96sIGQ1fdP5rwQAhx/RqD6q8bE+JBbVSGrL11Z02BrPNX8DTJGHm01tAv5I3oV/+DvXZEt3Ryy74xRL1yXsTAGEpgKocrVtA6jl3ZV8COGtES8kEsvPvJjfo4NeTuHKVhO1IPhgY6a43eUwDay6lf1di11rY45m/dORUAXG8wunyjEZzJWg/xuuzbEcG2suwgWXQEJpFctszzXuPknFMeSTYwXTqlpxJ3WWcsOck61vwRkcyg1MpnNqp446IU/ibanmww5xICrSvhZZhw1bRrVG5GhS7ACf14zDQpKm7BPnhG9Z1P0U5rACcWE6jHaf9AgJjDkVy3VMZa5J7atudrOwjkq4SzhKJPOFL34BOOKrJ2btitW41WeC/CYqPYjKZ1VjR6jmbCVOCmsF6U1w7adbXKiaMlG053Cvsdcm24eI+nard7IyFFD5WJQU5tkn+Zy93bPWg9uSdhWlomV9Ag8/IRojaEm5/EZS5+DYAP+ZNYZCmxVy7ZAXHTqtGwmE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39840400004)(376002)(346002)(396003)(366004)(451199021)(5660300002)(478600001)(6916009)(66476007)(66556008)(66946007)(6666004)(4326008)(316002)(6486002)(36756003)(86362001)(6512007)(6506007)(186003)(38100700002)(4744005)(2616005)(8936002)(8676002)(41300700001)(2906002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9PtQA9HDve4YjDPXJSvKnwCIloyT6M9R3t7bIEQu1ZYB+z+uqDuhrgFBbNO3?=
 =?us-ascii?Q?6eVYFVSQFzIPyJXyNluRSrxvhvg5/AZQ7BKEeXjtXmhaVFA8sKKBZkvRFa44?=
 =?us-ascii?Q?x7xSkep0DCes+auX8bThLlbYusvBCJZzpzAtFhXydr1GpjttQjqMLt5fATuS?=
 =?us-ascii?Q?9qcgVDQx2tttG86YTDLHEhsk123kilskYX2lfwmrCC6bekT3suwhoUvbCQtm?=
 =?us-ascii?Q?zAWs1GFWehqm/qAHbHG7X7NbasDdwICljU7VCGRck3VbzR9/Cl5sE1DXK7A4?=
 =?us-ascii?Q?m+bnR35D3BjBtJ2yHQzmmmote1bSIVWs5JiD0rASLR2KhBgI/UdXXRvJ/hM4?=
 =?us-ascii?Q?RRj7zBSs99Dz/H6v+SzhUVCQ5QOejfK4jdtmI4uKffSfcRpL2KkRJPum9ZM2?=
 =?us-ascii?Q?SVQOGpYrUyoZ2aWejN6+J4kOOTHOBEp/mqDT/faEYSSL4n3fVv1ADiMuYVni?=
 =?us-ascii?Q?fa2SMaHvwNQL69F3zeXYuY/xbfBMLjK3+yRJGUG3XB8eac5vgzg90uWSiqs/?=
 =?us-ascii?Q?4VvqbrmqJa1C56KNmrGipqFT0l0sslSDG6LHMNaEIUI7G51tMM2VzMmRNaUv?=
 =?us-ascii?Q?G6q9jWfYKf05i/qmUKmkS2IfW/A1yBaRMnHQB+mRmtNbB6GHk/G3Q9+t+QZT?=
 =?us-ascii?Q?zObWMB25a52A0jqiQ+pE0OTJiqy08Nhs4kQ8rrBZqr5i6ShUtPFzxZzNb6gC?=
 =?us-ascii?Q?gvaJCEVQftrSvK097e2pb6du1w/YJdI2rqsTByo7I1i+7ggiHMZ8duOTf2zY?=
 =?us-ascii?Q?UgWegCGHuVDzTVfwmSnNw8wE5iV86xYl1RAwl+rRBdnqcPI6mW20Za4OBWLx?=
 =?us-ascii?Q?8eO5P+PVW3oJEr5pb+eu/H6mwXkomBwSG4gTosDFn2BJCKx0ins81X7f2St7?=
 =?us-ascii?Q?XvnYBxDi4x+qqaqdP1AmLsMqfHynFF7uhYYSKwpMgwjjuZPtuca3YspM3iWl?=
 =?us-ascii?Q?ZG01r1DUsI8VdD25Yj/GhGEzz50DqveLOIvK8z1pTKt6+ontVR8/JHAoH6NT?=
 =?us-ascii?Q?fLUtMwidorjpqDb7cRaF6OGWJNxvpzIzPujpqMeQNC8m1DCo8jXzqEw6yn8Z?=
 =?us-ascii?Q?oGodw6fQK6KKk9sc4gdLFsmlsptopjNCQZUNIEtNF+oWRpol6Ub8GSFlKBGC?=
 =?us-ascii?Q?IkTrFq5EtLg1/RTWZKG+UBZIJT9OoDv6+QLDDxeTBt1vn2fDfyuXj7E8ALG3?=
 =?us-ascii?Q?mEXeT720nif24HwS4MnFrKE2neZTgqj9hO7ikC1alR2c8hpSeSZnWzdXdVC7?=
 =?us-ascii?Q?VVHk4nyu4iUXoftqKcG/2+Z8WsbRnF5Zp4e/TKFy0sRrfGy92ROo3+n71eBW?=
 =?us-ascii?Q?3ia/iedIs+LLvON6lKIYfz+odcmQuuX+ucVbI1o9AYAOaByt2O7e3TUxKnbh?=
 =?us-ascii?Q?iyE8fWExBlTPdu7ulHg13oAQTheLSNAMuh1EL8sfxvxVlqJnKA3VdQKaPjDI?=
 =?us-ascii?Q?UMCikSBw68aWGwtTLmOel+3cwJpyiNg2MbFsbl4FB7x9DZBCkxX2RDGUDfD5?=
 =?us-ascii?Q?0SxRCgklLV0lLGrgwXnJC7nR/wMe6vmOP8UGkL/+caE1Rae5HEToLsaNbGiM?=
 =?us-ascii?Q?dFA+1UkZ/Fvb6+iJ496HeGdDFfMxtPJ7M6i6YTx2utmL72cs190l7Sk+Q6Zd?=
 =?us-ascii?Q?JBG4zn3iOzn3Q399uycFDOuJT16dCe0jr7OGlZ/KWRmq4ptb7QER7ciKLVNr?=
 =?us-ascii?Q?ZGMt/A=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cd2bfc-8773-4d97-111a-08db73bd4af7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:41:44.7633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxfGSfhhOJYUcLWsyI30IhY+se/b/hMEu6leeoEIPRbH1IIx6OPzGry2WaRzDjyfvHjk5GOw3Mr2PRMzIWJHi//OXloFufwjh622K/Zxd3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR13MB6375
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 09:59:13AM -0700, Tony Nguyen wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Remove iavf_aq_get_rss_lut(), iavf_aq_get_rss_key(), iavf_vf_reset().
> 
> Remove some "OS specific memory free for shared code" wrappers ;)
> 
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


