Return-Path: <netdev+bounces-19606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D631B75B5F4
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 19:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8FA1C214F7
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 17:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB49182B8;
	Thu, 20 Jul 2023 17:56:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB925182A4
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 17:56:11 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2102.outbound.protection.outlook.com [40.107.100.102])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EEA269D
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 10:56:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfywXxv+idsKhuJZ8Hug3UxWsOwcqnkT7ygMvQJ4U79Wmi8QL1fkwZDk2H4lPQ3PKuMzdXBDRuKELMLNM1db6h7Xc0FSYIqqmyBb86LCPFR3OUKHsyoPXdIXfYp5AxyuHikjrtRgjxR8dn32lDcNqdyRdKjkm9r4tCdJMWnA1Yb5ZPlRY7nJqnphOES2hJQ846wYIA4Ah6J1eFvu6S7hxSkXxnlcGHAsTgtmpCMjtI/1qebPzlNFSzsIdWmRqBnnLrrzq2/jaIqvRcUdzgbMUlKI5FR510xTr3Gx75ktiyQ2RfyFNa5dTAoa47aEGqJ93bZTV+nBsl9jH0fq+h+eZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AW+9/7u8Tpfiy7P+nDstmqqv5endWVWGQIupZDF7exc=;
 b=UP0wRB9cidBdJpqoZq5BIz7iZHxWa6B54Pr/lfbllEV6HfCs+p6lmU8DFmgTdjIvmT44FEW4DqZFyr1Mkf1d7cljmH3Q2ERUF9PGdnRcS9bXvtF3wbgzE85NeJF9Pxhyr4CswJ1dO5L3nTGwhUqqoqxgnsy5OUrRH81dBOsx8k/+lmqILjan5yOUPu7PSXizCGnNdVOWYX1oQWjrrCCUF6wLj7vigKwdkgQJElXcW+HGh/BI67t2wC1N9jFTfFA7m5SRvb3kz+uDkjyp7mJZ4ZlM2pZxCAOEL160VCmWLLTbSn/ovRqcy+4Iikpztfdv7l8baCHRWnPDKrYNXtbhYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AW+9/7u8Tpfiy7P+nDstmqqv5endWVWGQIupZDF7exc=;
 b=fPH6zji79az+wtv/u+EQhCvjQRohytTLQPUz3dKBVJtjRd7nAQL+nt3AhBUw6ORv0g5L7K/xisc02aJqyfLgxB8VSoYmbqLIMs/nZzDBpURDLtCs6xKNvlmzdd7TkBP4UYR2jNX7+6NfL0I8j3QwjA9R8VhhyarI0HCogZkuLUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH0PR13MB5898.namprd13.prod.outlook.com (2603:10b6:510:165::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Thu, 20 Jul
 2023 17:56:05 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 17:56:05 +0000
Date: Thu, 20 Jul 2023 18:55:57 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, nbd@nbd.name, john@phrozen.org,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi@redhat.com, daniel@makrotopia.org
Subject: Re: [PATCH net-next] net: ethernet: mtk_ppe: add
 MTK_FOE_ENTRY_V{1,2}_SIZE macros
Message-ID: <ZLl1Le1JiuoC8DIc@corigine.com>
References: <725aa4b427e8ae2384ff1c8a32111fb24ceda231.1689762482.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <725aa4b427e8ae2384ff1c8a32111fb24ceda231.1689762482.git.lorenzo@kernel.org>
X-ClientProxiedBy: LO2P265CA0243.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::15) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH0PR13MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: c004cc90-1010-48ef-e364-08db894a9666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	67MrXwX0AwGoSLCxDAGpMObyKr7RuB5wxL20mYaCgItJZEA+WlkNTek2xOGv5BGHdwMPJsvmf+y0DsZKILTHXClDIQY3YKKujMktw3uEo7V74NmwgswGYmXxWoa0FrKiiYlfkPQ4JAPaQj0Wu75pbl2p07SePqqi5FnIJLvU0RPv8slHX/PP7wcQ/fk64ROaXtCNObXdNPR1xbthTJEw0Z7a251uCpCh2e441JpHptEtn8IWOQPKZAzPtu261oxA9GyfVtxgAQwSt1Zjj+gDbm2I7OUsXLJzRNte9guLSjEv1/ZD4wlJFQF0PT9bgspFYl0+fUleOohHHt6Tscun/QuPA50Lut/HNECbBPgBlHhArC14pGdrXsnWdzAw5DyejHY1ocg+OXpagzCAMROWU+luC3lKZk0Sn4gd7N34dCkysANRu+q01iZGpv9871bRSvK5Nrx5NkY8ZF/yLx4EKH2/pYH4uulyTok0WzYaVFIEw1G7lPQfkpe8gSK8fX1qX6yYswcEqC+N2+zemgBJzuK/NdPTMNrbI5SIYq35ArMjA7C4cAiztnXEXtEAXI6E71qBeiLZ0N9nFilaZPKV/ne6mr1jO35+p6BOadNA7vU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39830400003)(366004)(346002)(136003)(396003)(451199021)(8676002)(8936002)(41300700001)(5660300002)(4326008)(66556008)(66476007)(316002)(6916009)(66946007)(2906002)(44832011)(478600001)(7416002)(6666004)(6486002)(6512007)(26005)(83380400001)(36756003)(2616005)(6506007)(55236004)(186003)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K26WhafGb8Z0WlaQJvgLhs3IuQATxfRcG8CvPsfJO7NjqdqRQP82/1xYXz1U?=
 =?us-ascii?Q?cqrH8Jd2GQVdefrhkT5cDgdXBzFemG9tQ5WwTaD6yLuBkJOywpf2P/RJSZ0G?=
 =?us-ascii?Q?H4rd+74Mueg2HpgvdiSuDPED607tIKhP9ey8eU1QUwv+5/V3v1OewsgWT+jD?=
 =?us-ascii?Q?ioNFT/9mBwaqOoeWPHGV1mUtI8VulmV4TA6pDdey2vOsCTZgHlOYR7FqvwQE?=
 =?us-ascii?Q?wANPKZOgQro0r5Z6mKlzBxXRNf9H50EHu5J0070t7E3b2R5TgtbVDZVLyKLB?=
 =?us-ascii?Q?VTK04e/ZE25lB1vno2xaZ8NmPSmr8mUykceAh7S+4FWCU1xgG1bRlc7C6dMd?=
 =?us-ascii?Q?MFKfHR0OmtZYxcKW1ZWDwhcfspoG+q4G2AT83L68QM7alWjr/0z0OoG+A/bR?=
 =?us-ascii?Q?PMt3jL2OnrrALUBB/w5ckbqkUiIKmUfI09G2VHwBvjnFUZ/cbkdoLPLa+y7z?=
 =?us-ascii?Q?wphVvAiTWw6zMKNU7jmJFIfnH5xGToqojAkjhCExGyTxr+QQVG72aQfCB1WC?=
 =?us-ascii?Q?YZE/PGVSkxtWOmfwcmhmBwtT1Nnojw4G4wK7ytTj7ft53cWcGg9xSJ+zbfnE?=
 =?us-ascii?Q?Sh4TQji3vZSvApC/qehZCLXulqIPE6sCG5oWfBp59KIvYqQEFCZKNfZ3wHPz?=
 =?us-ascii?Q?3G8JPgcd9BMZKkH3bVyrGhnwAu1b8FMJoQ1wdeKAI2dYCU22Gk3WpqvzXMF8?=
 =?us-ascii?Q?Nh2CgkqxoKHPzGlbpEgOvxys/+wUcdxwh564o5JXoB2mC/LEF20rjvXgwfyH?=
 =?us-ascii?Q?xPgNWThW28ndNmG6OlyvqG5seW6ooPv1hSM8vN9WwFSvnSrK+FBupuUssif8?=
 =?us-ascii?Q?Zk5mWv5GhD53zESxfSmSWURS7DBJ4dtU8EbWbRMVcKr1GhfnaUa+j5SHTKdM?=
 =?us-ascii?Q?qjQITluSM2nWo00SBNklbay640ANCEGYwVcTuexVI3/Z81soJm9XMBW3Kk+W?=
 =?us-ascii?Q?PPf/GHSlmnLwJTrkB+dPrjhq58Qq6Hnfub/A4OD0a6Alahx9DY5/A+g4YsLa?=
 =?us-ascii?Q?HY85sOKsFtF/61EN3rCdO2MOuA+CEPJ2pLcmZKw/9iSJCdk1gmes0hORjmfa?=
 =?us-ascii?Q?tLB7H+YYv3lggzmvLbX3GGABPSO650e5G3LgsyXef1WVZvSUaq6rqn1+VaoV?=
 =?us-ascii?Q?Ojb5+i7ck7rzbDY/0kimfIDRBvO35fNCs/Ey9Y5gvUrgNcSlR/Xq7EFaEdLz?=
 =?us-ascii?Q?U36T+R9zaE3u+rt46QwRzUzWtPpzlufkoyoh+pdKkA4hTuXetpQ7xJTk3EDi?=
 =?us-ascii?Q?Hf2+Q/vwXMuQOJa7FgzPj6DtrS2CBbf9qXPNXsMwwROCIuRlghNLdk+OCmob?=
 =?us-ascii?Q?v+oymWGubIAllIFQYy3+3riO8Youfix84saUm1UR9XoGfxPQVP0UF+dPUq1t?=
 =?us-ascii?Q?0Qdfgl8aAdLOTUrYBcncFPN9a5GxGcHfdHLi9kvXlUA1M0K1rK1it30qEfEm?=
 =?us-ascii?Q?5WZrvThDwG/X0euRzGaQ9kKbNXzqA0iPWVX6h34CAMzf2hfst3Xy+0gsdM63?=
 =?us-ascii?Q?ioeEdyErTalf2BHFvGYzDuA18JdnuWK4lVqvb+MFwg1+iQ0jieKoC7dE8vCP?=
 =?us-ascii?Q?yKTjbFDRgEuwekZJU+vKxxSBtjWDJA2ORisa/aAKhq1KTvpOxbiz3w3mFEpV?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c004cc90-1010-48ef-e364-08db894a9666
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 17:56:05.0462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsBDnLd2Hac2ugBrFkUgoMDqcXx/JL8iyPlzs+AIAY7dTqiAc2/KPWXEGvlocwacfOwl2wHXVWc9lSmIcUFlxiY9HUSfVIUCZ0siQZnrKlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5898
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 12:29:49PM +0200, Lorenzo Bianconi wrote:
> Introduce MTK_FOE_ENTRY_V{1,2}_SIZE macros in order to make more
> explicit foe_entry size for different chipset revisions.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 10 +++++-----
>  drivers/net/ethernet/mediatek/mtk_ppe.h     |  3 +++
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 834c644b67db..7f9e23ddb3c4 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -4811,7 +4811,7 @@ static const struct mtk_soc_data mt7621_data = {
>  	.required_pctl = false,
>  	.offload_version = 1,
>  	.hash_offset = 2,
> -	.foe_entry_size = sizeof(struct mtk_foe_entry) - 16,
> +	.foe_entry_size = MTK_FOE_ENTRY_V1_SIZE,
>  	.txrx = {
>  		.txd_size = sizeof(struct mtk_tx_dma),
>  		.rxd_size = sizeof(struct mtk_rx_dma),

...

> @@ -4889,8 +4889,8 @@ static const struct mtk_soc_data mt7981_data = {
>  	.required_pctl = false,
>  	.offload_version = 2,
>  	.hash_offset = 4,
> -	.foe_entry_size = sizeof(struct mtk_foe_entry),
>  	.has_accounting = true,
> +	.foe_entry_size = MTK_FOE_ENTRY_V2_SIZE,
>  	.txrx = {
>  		.txd_size = sizeof(struct mtk_tx_dma_v2),
>  		.rxd_size = sizeof(struct mtk_rx_dma_v2),

...

> diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.h b/drivers/net/ethernet/mediatek/mtk_ppe.h
> index e51de31a52ec..fb6bf58172d9 100644
> --- a/drivers/net/ethernet/mediatek/mtk_ppe.h
> +++ b/drivers/net/ethernet/mediatek/mtk_ppe.h
> @@ -216,6 +216,9 @@ struct mtk_foe_ipv6_6rd {
>  	struct mtk_foe_mac_info l2;
>  };
>  
> +#define MTK_FOE_ENTRY_V1_SIZE	80
> +#define MTK_FOE_ENTRY_V2_SIZE	96

Hi Lorenzo,

Would it make sense to define these in terms of sizeof(struct mtk_foe_entry) ?

...

