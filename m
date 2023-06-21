Return-Path: <netdev+bounces-12650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E2E738598
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D951C20E13
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 13:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E79617FE1;
	Wed, 21 Jun 2023 13:46:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499C117747
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 13:46:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2096.outbound.protection.outlook.com [40.107.244.96])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C6019C
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:46:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liwsyOHTkk0PP+mxjbCQTIQf+zLQMaI5qWOecMNuEJgMVBt4xfFUDY4z1AglebG00QrcA4NgtxyIEev2cOWU9XMPTMVIJ37z/I90D4/F/c0fTXni/kGwmMLvhwfS+aE4fR0zEUeKqzHpehj167j0/qngG9ZjOKSDEAXkP2zMDhXmGJ/VgIrqBhx83jmxYxqNAJJ7nuBviSD8aqTqGMowVsx4TWFIGwMRJUQ3vNe7iQfgJMiEnUuV7i+OEG63Glhwg30T4kktBJ+uTZ8i40aqCuM67fY2vrMKy4E+aIrX/YxEUTSNS/2648jTTlYFufIR8Mmn5PEh0xpL23gxY5Ojnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuIRZbk5O82CiENWcuJjIkGaGwGu16m0B0Q/tQcaPGM=;
 b=D6BZKtmwKleHUbirwBZykvOphEpwvXl4IZo6nqQeqDsEky8MOir7RCPaA2bF0gW6/HSxwku9ViNFlNCD6ASEGVdXAaQ4Bh/cz6SrmyWoXIkaMICM0rhyxBdQx0wTZgeMdlX9PlTsVDfuIRJU3MTC7a3rdxyvji2GMgBy0+ylFAqWNomBrGsdcBH3c8iPC7H5pBpT48es9auzdSkHEOBdZ0Tfd6Kuf6fLWHylc1416KHVeJF0uL/mHHJCIvzp9cZxRPKSspFIfyzlhqOaAzVTLVrKQf89ocxZVcUNbEMee7TIKbE5WAbbedRl7zHsKhrfDFenkZI5bTHE2xW+ez9/og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuIRZbk5O82CiENWcuJjIkGaGwGu16m0B0Q/tQcaPGM=;
 b=MMxceuhcS2j4E0GtYsK2lJKQeo3YxRYA5dYvtlPoHa7QhH4+chJoLzN9C9J1T7RaCIiwk0eUmoET/E/EdrVwU3zM4qscVOl3oipoCqCVqjbkh4nQD8xa3Zmxk9BFf4A58nykUsMNIqy7SxePyxKK0fBp3/d85ZYuYQ3+QmikIuM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH0PR13MB4617.namprd13.prod.outlook.com (2603:10b6:610:de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 13:46:04 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 13:46:04 +0000
Date: Wed, 21 Jun 2023 15:45:58 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH net-next v1 3/3] net: phy: marvell: Add support for
 offloading LED blinking
Message-ID: <ZJL/CCUs/VuNCIDW@corigine.com>
References: <20230619215703.4038619-1-andrew@lunn.ch>
 <20230619215703.4038619-4-andrew@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619215703.4038619-4-andrew@lunn.ch>
X-ClientProxiedBy: AS4PR09CA0012.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::15) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH0PR13MB4617:EE_
X-MS-Office365-Filtering-Correlation-Id: 625b0cfd-031d-49c2-1636-08db725ddb7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gs+9MhBZrw7gF4Fr8F1+4tFIgZeiFfGogkGePmn6FJBIwiwqFIcqn5wHgCffa1GQPdUh/lhbT0+aPIxBKnoMrdQbZLBsBxqZx630q3fI8tGgC7UnB8a7IUeUOI124bZnMgQ3hT5PCxhs8wAdxcEBHpMu/I1GW1hqIuz/FUAGp+W9/Qx/UVAYeFUeS1FFIspkt5E8BuNoe0lcnlQ3Ct+dKOAsDbfKvvHqcfFXKM6Lx7aDS+XAcax2aYkHng3oodLUdPGfHuh+py2lbX5d4goMnjNeK4dAroBp30c+1uRYlLal1iF8+5IqfPgi1WJS/02ESnA/qQIrVfdARGQG323Ii/XOlAMAFuV0mFhAqu/ozqbMko0cCC0p3HquWmDHLwamqePrmn116G3SYqx4J8BgLVeuYxsBFf6SiAJUcYrNMkNJtpGVTkKU5MbHVxCA06kWzJ5MWZ9/tgKmI5jpsJUkL0BX91gZ+UYBZFS3+u7ZTHhAjD1WYJ3L7IVmg+7vLJw10PomfQ+a07BkAgvBaCSWLL4jnv25G+9COx6V/N/p40GIhDOrLY0lAm6DVJ6xnIGDlciu4m0Wwmcjw35JVq19bCJWCxcDyX7guY0xtwGj5CQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39840400004)(136003)(396003)(376002)(451199021)(38100700002)(44832011)(4744005)(2906002)(36756003)(86362001)(6506007)(6512007)(186003)(6486002)(2616005)(6666004)(54906003)(66556008)(66946007)(66476007)(6916009)(478600001)(41300700001)(316002)(8676002)(8936002)(5660300002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pSoTBQeybWjwz2V74aue4x3mvKX51Z9t6l60j42X+JBJGkweJ7LOk/uhAUr6?=
 =?us-ascii?Q?CVmnM8dy4Fs1YUqn+KCjyuZy7+EKuWJwly04f/ijqLMpTpIP92dgkLch+tCS?=
 =?us-ascii?Q?KEV3y9wHvOHqja+LAfbQYC4uz8pCFVopGMky4POcRJHMZgPYXiRF7jKsnUat?=
 =?us-ascii?Q?JI/EraumLzGuLW2NWOhfF3Bvk6qqNsjH2roNe6sFV3knGaVgTCYdXInyXhRs?=
 =?us-ascii?Q?mQiCoRQCE8Q5HwxNtZe04ATw46dEPwXsBoYlgtWhK92A/RHiSUZZZhAH7MJc?=
 =?us-ascii?Q?OG4kxY8WVaQv5a39xgIQoI8BazPRc+OfiKR9mDb4g/lXVGI9yg+kS1Krm0h+?=
 =?us-ascii?Q?V4Xu4Ar7q4fwQCJO/FWKqKDh3oV6h8UJiaiLTTDXUXBXKCmAih6tQEYqrIHN?=
 =?us-ascii?Q?mpotElZnJ8QbTXe3HhvB3VEwKwAdGwwIOuqrW0ty4YtXDPPT+RTEn6QR96TN?=
 =?us-ascii?Q?Uep0jfqulWZiec05fcBaZzWOoOHz0QHh64aqd9RTkbuRGD/PtUoDrh3eKoQi?=
 =?us-ascii?Q?JchqsUKfNUV1hhrrDbj/iBj0o7A4IgYL9IiICmhMoLNNy9K1lZV9jdB6F6gL?=
 =?us-ascii?Q?M2uXDPr2IAyN5sqchCbfFkQOoE/wIaJnPYKJGnyE8YOaWSwgEW0F9ImWhaDl?=
 =?us-ascii?Q?E3ztdWHlFwPazrZYzOrADot1LATE5R/40KcjtnosJ+8shEzhhd/ETz7d4+wd?=
 =?us-ascii?Q?ZgCB5FCnz+OJAZm0sLlyErG3XoCN8pxyNhipCYmUWAxg7DKOXB4L9xnhIXXi?=
 =?us-ascii?Q?zUtc9tXSQ4DTmeEmPnK9D5g4DlYalJA9r6dR9HFaQ7CPRIeam/FMzEa1uGTq?=
 =?us-ascii?Q?v6X9Ok67vvb1TekEN37v3jlQJ4x3l/w2pNq0ZwKpL5NE9BZPwR/HM1w7zbc6?=
 =?us-ascii?Q?/xir2bY/VKikV8Gt4ilP3Z+f086Q2WT7K7mFTmL6+OSEwXr4eVc0zH7UZAzv?=
 =?us-ascii?Q?YLCid//0wGzxpMNtU46kCwmLSSIk91eBGk0nceg3Sys1sFMDgTCsD0ZcA6Ea?=
 =?us-ascii?Q?OdzggWUp+LT73q3fYdnAAxtgIKrnjK+JOUEuIWZstrqLnxa4fXIfa1yrdPCa?=
 =?us-ascii?Q?AQQj77bxF58cXwXSrIgqCbsYvDrp4Ok2WgEkC1SWRSOl7QIZCTFWN5xVGJcz?=
 =?us-ascii?Q?ajzR4Rwb7ku61aa1kYj7RjIN7t0/6FzPBPGcBylT2QVNdOa+XPP4aqZOZ/Sv?=
 =?us-ascii?Q?H6BAMeDqGwQ6BaEVeT0h/k5OPK3zjY2/hpBuU5Cs5OJC/NEf3kja2bg7dEeW?=
 =?us-ascii?Q?C0vakdpJSmky7AUtaN+rffaOLF0UIWEmxoKbDgA1RlNr0pnKcPO/3UtNB6Td?=
 =?us-ascii?Q?cHPlveASGA18ATVZMvaHM32nznx1rkUmUVXI0dZFJA440F1KtL0REYS6r0X7?=
 =?us-ascii?Q?fpwDiykGbqHv9X0WjauUmtkT9AonHk/Lt2EF8SiOfzWg8dcwqpfsPpDt6k9C?=
 =?us-ascii?Q?F5e/A18n/sG1/kL0uHOe1J8MJ/H8X0OYmYSJxFctt2BL9caoP9oWCvKtoQw3?=
 =?us-ascii?Q?NwUPjnYh1fvJdgoZFSPtDmEj4E2A8C1cNEYQEjLOmu7LJa57dtVA2EaUuD6l?=
 =?us-ascii?Q?sYxMJlbUhvz1ckMJntY/Z99GezmIO1LKzmiy0YS2ouzFH+Al7SCCWTp1kW8Y?=
 =?us-ascii?Q?rwVutQOLevIsNuTYopnAh3+oPSRqbLwsHFMWM7gACyOeHGDwqmX3oc89d3M4?=
 =?us-ascii?Q?WciLEQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625b0cfd-031d-49c2-1636-08db725ddb7c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 13:46:04.4106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIPHSLOAVTaIhIaNe9Ok+bDaD/TAH4dad6WM6969aLKN3k0vIxepF96U4/NiqskznZwhsMC/R0fREbdxRvVUOXCFi7BxpAZsIen8ZCnV7e4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4617
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 19, 2023 at 11:57:03PM +0200, Andrew Lunn wrote:
> Add the code needed to indicate if a given blinking pattern can be
> offloaded, to offload a pattern and to try to return the current
> pattern. It is expected that ledtrig-netdev will gain support for
> other patterns, such as different link speeds etc. So the code is
> over-engineers to make adding such additional patterns easy.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


