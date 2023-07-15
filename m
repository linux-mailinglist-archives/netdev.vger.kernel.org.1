Return-Path: <netdev+bounces-18066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 119EE7547FA
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 11:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FF51C209CB
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 09:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADA315C6;
	Sat, 15 Jul 2023 09:27:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A777FA
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 09:27:26 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2095.outbound.protection.outlook.com [40.107.102.95])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F7FFC
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 02:27:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKURCBvTWESGlQwMU6M3DE71XZtKD9T93Dnwopgt1YKig0QqvcbMhZcRm6/oohzzqkWr9k4cMjYpEqSc/LmktWKhm9ih1p2Y/f5e88uVQ5y1QxG6xaSdDbtHNgEk3+Dkd8XHkWIHBtf7gSOuCTvll4qFiOHnt/hylcKqkHpiMhv0SZjNSl4uq4HfVjGPFXRxe1AG000mOt0FufQmI8E6GzqZivYW1HAwEt1yFVxLoxglccpF9EVoOo+0cpT5QiyDusjdRtTelZyLdSJV4gA6ws44d1d2XHVgHw56BluRHxDd4fDXi64vGr/sWmhtmzZ/rUoZhAU9Ny4e99wDX9RPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/H3tqAkq28LiBozkkrEQSbKVP6jANIR5IxBoyF9jtQ=;
 b=LMhaQbcz9LhiXwayy8mGYRxOTONR1cTXmFQSdG15bxR6uDfZUquWKQ7mKYAANJK59A0hfk7NfQ57ErSMrWm9DsDY2YBixSKy1/GtewVGYE/nh0EtEiK86HbKNOcz+kCN3cd57bjT4UedBth0vnUkYTV6BrVoPedM3IDRyqmsq8lLAm1rKCiejM8F6lyKz5OB1mOU4mkKRD4BWOy02j1WEJOpNdb+rj8aQZUj5P1+jOyJ2+Kfi1qAa/K5zmEVJIgDOufJIiFQAKHnkcM98/dfuvbnSVxdSy80Fuw3/ailzgxV0sKs1W45ww0Vc4KL8CTfjKfDw9Zudd/2KZ4Sg57ZOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/H3tqAkq28LiBozkkrEQSbKVP6jANIR5IxBoyF9jtQ=;
 b=AkjGpnFc/q0427iTnFZYE+nJa1/HuGmwhM53q5cX033dbgMTw8V942ffM+w5CBc3nekTX4iBk4qeYga9OgIex9dAu1gfAI8/xkaiVBMxlxwl8E+qJbT2WV4TT1bPeDZTML8z4Iorgt+5lRLuPzQN+TKabgSHadXqmt7y7iDKd6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH0PR13MB4618.namprd13.prod.outlook.com (2603:10b6:610:ca::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Sat, 15 Jul
 2023 09:27:11 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 09:27:11 +0000
Date: Sat, 15 Jul 2023 10:27:04 +0100
From: Simon Horman <simon.horman@corigine.com>
To: =?utf-8?B?Q3PDs2vDoXM=?= Bence <Csokas.Bence@prolan.hu>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH net-next resubmit] net: fec: Refactor: rename `adapter`
 to `fep`
Message-ID: <ZLJmaHtU5VmENl25@corigine.com>
References: <c68ee91e04144f0e8aa5569613a73fd3@prolan.hu>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c68ee91e04144f0e8aa5569613a73fd3@prolan.hu>
X-ClientProxiedBy: LO3P265CA0019.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::18) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH0PR13MB4618:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a5e887a-eee5-4837-036c-08db8515aa9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GCim5JiZ3PrV5ssXBWMMYCKAupGHeGeRgGrq5kB2MW4QweMbrR0RnHw/VfPXNj+3N4/iiasOqjWs8j9bdlcnvzOUKDCeuKS6rYlCX5pWZkTZBmzIO8KcG6zzA8lxwmLfmsXrZBZC+opYzdGvLrMby04RZjjInk+IeoeZ0OuhiishrV97Uda1PTwdiebqXDPpNVKxPcE6W7OTOUjufiOoJ8GydMEq65OAxvtJcTASeaGi2U6l7mO4OP/OztYoSClMKO5u48QVDL5RtJX4KA1DxYLLr28NgZEA2vEnDZyWxicBZepLzBfZANVh016LO/QnWU6Ct3xJ0fmC5AxGSrN8cHHjaz7ZChz3/jYF6XN2LSEEI/Q5vmDn4uaVRYtpYooXyhMtYvlvNjX0nnuybF3PwCzs1Jd8vWSUyQmXfp+EM0vU4gHF2AVU2tZz9AG7+78yOlFnjdS0p+n5qkB4iwtWW+uFiv4/pJqLBub41qErO2nqWAU6zyUkzp/5OIY9F94zWPWGYHfnTK/tky8ar/IM2wc7RdHfLANwUR1sBTdTymDqXADmiXYZshx410PgC4P7/HuQcVA88j3hH4lvbmFzmg0+9XT6HexpvE5Hg6DTmt80VgE+lfgJQujEhaa532UTg483BiT+mBACcVj7ttSDYudzYgzMzxVU5iwGxKF5l/o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39830400003)(366004)(346002)(396003)(376002)(136003)(451199021)(6512007)(2906002)(2616005)(66946007)(66556008)(66476007)(6486002)(316002)(6916009)(4326008)(478600001)(54906003)(6666004)(6506007)(8676002)(8936002)(44832011)(5660300002)(26005)(186003)(41300700001)(38100700002)(558084003)(86362001)(36756003)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MC9XeE5hOVZuanNiT2N1bVVSY2ZlV2t2UjNrMTJ6TFQydFF1UFRYVDBYVmZH?=
 =?utf-8?B?aHB6MnUvUm04V25DT0hqOUxIUXptb1VXK01nMDV1RzN5QVNWcXN6R1BZejFj?=
 =?utf-8?B?RVNlcGcrUm1aNnlsNjNQR2p4UXF0T1kyMHpXWXhoMFVDczlsSlprQ3hlUStH?=
 =?utf-8?B?UjZaSnBTMVN0Ti9oVGpKd0VkU212eDlaemVFRHFVd2FRZ2RGZlJYZmdwZm8w?=
 =?utf-8?B?eUI1SU91V3NhWEFpTEhkY05wZUNnRFEvNGpjVFZzVzhTNExjWENCbUZHeHpm?=
 =?utf-8?B?S0FKdlZYS3ZSQlFLeGc1S3psQmNDbWxPMXlwQ21zeEQrRnRRTmo5WWRRMVJr?=
 =?utf-8?B?aVJNTHJsUVJjQzFmVnpPVlRlS3BNYm1VVWVVSkp4RXVtM1VRelZMZDExTE5l?=
 =?utf-8?B?a2Z3bk1oSmxyUlZ2akVLbk4xQTZYRXd5U2cwMGhnblhXOU1EY2dFcFlybTlp?=
 =?utf-8?B?aW93RjlTcnZjVlBxcFNiVENBVHNETlBROHQ4RGVFOWlOby93SFRCY3RsRXM1?=
 =?utf-8?B?aU90RjQ3bzM0ZWNLWWFVallHRjNkRlcvankrY243WXpndWI5alpqWGZLNjBU?=
 =?utf-8?B?UkF4SHBpTmdCcTlmMzQwWmowY21wQ1FRL0tXNnpTMnB1VWpqYmk1V3JYYnVJ?=
 =?utf-8?B?QWxHRE1nbjRCdldONWkrOXpxbkZWbHovYlF6MFJCeW9yMXZnVDVhKzJ4d3py?=
 =?utf-8?B?YU1sckZOb2w2aTNCUDgrRkpKSXFUWjlPMC8rNVpzRDVNd1JPY1BpRzMzY1dt?=
 =?utf-8?B?eERTNmhtZmRURzFMT2J1V1FNUVRmcGFqWEc1RGNZRE9uRWN6OEdMTFpBSU1N?=
 =?utf-8?B?cGpVMW9YUTNlWkd4STJzRE1saFFEWm51SjBMNU16UGYvL0tWN1JtMUg1eXA4?=
 =?utf-8?B?b1cxRENVZ0REODRCQ0hMOG16RStVbWxqNXRnV3BoS2sxR2JPZnVqaWJIZUN6?=
 =?utf-8?B?djUrejRSeThMam9MRlFseWlxMzVzMnFLOXNQRWR3aTB1Q3JJK0NzeFUydGlo?=
 =?utf-8?B?YjZZWEdQdGFTaW11SmREOWlQNk8rbDN3dDV0MXd0RHVRcVpuektyaUZJNFQv?=
 =?utf-8?B?clpkMXRiRmQ2dmZ2K2tTUUl6Q0I2UlJMOC9tL0JubDhtWmV2YTk2bjhPNThv?=
 =?utf-8?B?b25xZGRVeitvcUJqZlRjUjI1blRTZ285Rm5VOSs0TFk3VTU0TWRDdXhiaTJy?=
 =?utf-8?B?SkFnK2hEYkRWbGdCRGxKUEdERDlyV3dSbDZjekFvclF4WmQrMXR3aUR1Sm9n?=
 =?utf-8?B?WUM4YU01MzA2Zk44VUZPVjB1UU9tM1lWcFpyb24zeWVLWGl5YUphZEsxMCsr?=
 =?utf-8?B?U1dJZDFrMmxNK21iWnVHMVk0ZFdTR2p4VCtCN2pqV3FpTi9UcDFVZDVVSnhT?=
 =?utf-8?B?YVkwR3JVS2U0c3B6cnV2TUpWb3RVa1MwYWpjOUJzU29XK3psUnJXem9rSE5S?=
 =?utf-8?B?SGZhUmc3bTgvV0FBQTlLTHlCV1BpdXppL3oyMnZ4TUU4U2EyL3cvOGg2QVpU?=
 =?utf-8?B?TXNRZ25jc0lRQTN5dy91NDZVZGwyTkx5b2NGVm94SHFwK1V6UU45NWdST2lw?=
 =?utf-8?B?QmxwN0NlcWNWQVZwZW5zSUNWMjlFVWczelRzbXpaYlZTaVZjTXVQanhSTTVq?=
 =?utf-8?B?NklmTFVnSVBJbzV1Q0tQbG9ENThqNFB0aHhZTlZFTCtBejdEbkFjM3czMG1K?=
 =?utf-8?B?Vi9zYjVXSVFMSkRLUmV6bVZwRmROYXpweSszRk5BNm1lcWlKQnFCb0QrY29N?=
 =?utf-8?B?bU1wbXdPU2dzS1JOdmFyYXJWYnJWYTNMVG5NUW9hNW5pakw4cFB1UzBHdTZ4?=
 =?utf-8?B?WG1ITVIyYkRicTBmdmUybmxMNCtkVityeGx5ZC9RaDVERHhJR3N4Q293N215?=
 =?utf-8?B?RFVqQjBPdkJxT2dtWmNObk5ITDJBWkRESCtwcVRDdk9KMGVySnVBWmJZY1Yx?=
 =?utf-8?B?Sm0xVG80Ui9XbmQyc0VUUUNrTTVzMnI1OFZnYUhBRWVGZHNvTzU0WkJVdy9P?=
 =?utf-8?B?aGEwWU5LL2lLT21neXZNZkZZT2UxK3pjaTJIcktXTnJTZExpRkVJNk9taVdW?=
 =?utf-8?B?ZlhUbXE4TytITU5OOFY2blN0RlZQU2w4ekxGR3hrT0cyakdidXRuSGNiU3o1?=
 =?utf-8?B?ZE1qUGgyZmVRUGVPQ2Rra2MrbVhrcVdZMFc0RFFIeTltOVVRM3lKRWVXam13?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5e887a-eee5-4837-036c-08db8515aa9f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 09:27:10.7430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mCdATZLApVypKdmpXkdWuJ+r9i5kKTHY7mNk4qsDxp9Y4ZeSNYxKoJDjWP3KjtcoDajiY7AjQPFK0kX2OztgU/8+Ns4O5t3qNdpf/Pawgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4618
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 11:09:33AM +0000, Csókás Bence wrote:
> Rename local `struct fec_enet_private *adapter` to `fep` in `fec_ptp_gettime()` to match the rest of the driver
> 
> Signed-off-by: Csókás Bence <csokas.bence@prolan.hu>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


