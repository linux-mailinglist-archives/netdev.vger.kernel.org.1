Return-Path: <netdev+bounces-25176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E4677320B
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 00:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C9B281447
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 22:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CDA1775B;
	Mon,  7 Aug 2023 22:01:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28555174FF
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 22:01:04 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D208E8F
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 15:01:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxCJVpJv+E6w+7CnwqDMb/DITBaC+6Wd8YAsltimaMrB1jMISaRmD77ftm1zAQiLPERT6s6JlRnWHrrjlwVg1OxvktiqecwJphQ6dwcInQwEPOWE7Fm0EVLSpezJsXFZnx2SHOJgqFdX+eOieq2RN64l0hrCKi+51zNpdWdwbhlBzpmjEWCAKdBFmiueCPW+br9iHSOiP/TzMkQ64xxeM86WY0y3/SsqlCPnHiOBBs7PEeRnokr+UP5n9qpd+5ObKb2ak8OKyFK2Ws9mRJM0kRqsTeOmRem8UKBK5jXn8DyO9e0frz3nqbTL/dJJsUHpjM4tQTVTjlBhDIcphZXV6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/A4iJDthGn08wA68Ljq3cElllffvUC4g8nKtDzyGdMc=;
 b=HKFvFLze7MngTABB5Qb4EnsebOy+buuVTDCFgVHM4m7VUJpSwrwJtbap0j82uvlUjIGSqaLu6+m9f5+39qngZPZMgUKyMOA9Im4RydimhRVrFSRTLzKKkaG767slWIFJ+8pBk3N2Jsnad1Zzkp2hkx3Hf5R1MEjROX5JflFQxZuBrsbnU+9bCqfXZ+Qr1qf707kwTfrm7v6WhumcvPeVMfY0HJlU5GR076nfMMSumYk2HrVyCAl9k1uWyigfab1oQY8zgo6QsV0VHkxNK4P1kjGC2bEWkTCylK/3mN8cv8Iof1y7/6JQ77nVU4iZFNrbGJuxz/KG9gczqYqfsqkBLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/A4iJDthGn08wA68Ljq3cElllffvUC4g8nKtDzyGdMc=;
 b=Nr6XIaibDOnpdpvD4Q9PqhxxR4qBv8xc22usrfOOvv7L9hfcyeM1s4FgvZD8Yx2axP/DfT05RtxtAsZNLebTM3n/u+NTfCNAJZoLnDhuUh8n17Z7HYLZUzqIwDvqLOaJvJreyEJIJn+yGaTfP2ZWldNOV98vrsUHElhFIsrOTfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DU2PR04MB8566.eurprd04.prod.outlook.com (2603:10a6:10:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 22:00:58 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 22:00:58 +0000
Date: Tue, 8 Aug 2023 01:00:54 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH iproute2 1/2] tc/taprio: don't print netlink attributes
 which weren't reported by the kernel
Message-ID: <20230807220054.ghrawyp6xp4xk5bt@skbuf>
References: <20230807160827.4087483-1-vladimir.oltean@nxp.com>
 <87r0oea9se.fsf@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0oea9se.fsf@intel.com>
X-ClientProxiedBy: FR0P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::18) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DU2PR04MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: a86bf58b-8b97-4114-3961-08db9791c7d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GE2Brgb17EK8gYHMTLv57qu3qmqbbDeeko+UoMH3DzWtQrDTjz59wlR5ptcWVy+ajcSbAsseWAcePj/4XRInlZNBMCuPATIAcIz5K7RCglo19wtZtmaH7Nqxt7EKV+isNmMoy3WA86Zt3IBg0niT3FF1YOA2/vLx76tkgPu8KCZgPHjbKufGA98C4RKC6YbVSYuv6sVK0rwrEXdeGApKUMsOCjO6JFKgw/wvulGELKMNBjSKwY/nXW1BgdXaG9visKvGMNU1H8CosvxIemkDjsgAyQjKOAErG3R1rcK1WTkO6SWjzysNIE8JMsQO85BJ3tAVpBSZNMKAldINP/sVc53AGHJHodEd2Y4t7ahVJ4LwHBsx7Kwx6qCHrwngmOvGdwiyWUmDOFtIsxH4etrAZeHQuXm457jbNVyaEuncLlmclReserlfu6Slso5m8B32v2ETOASOy+n1kmP6X+fyrDFMg5afKDDxUzsh8uxbobD4OdJBtS030CmRe33I0ejBx6Js5sXe9aaoYgqM+SG9onD57t6t6yzox1Op5rXArg6tthzp+1y0qpUMF5dxiSR6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(346002)(39860400002)(396003)(366004)(136003)(186006)(1800799003)(451199021)(1076003)(41300700001)(26005)(2906002)(5660300002)(44832011)(83380400001)(8676002)(4744005)(8936002)(6916009)(86362001)(316002)(6506007)(6486002)(38100700002)(54906003)(478600001)(33716001)(66476007)(66556008)(6666004)(66946007)(9686003)(6512007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yHHGNepSsvmctoIMeRGpVYyPvfdVXDpO8+GaOvFpRjNT+BWuB1lmpZH7FF8y?=
 =?us-ascii?Q?CBXddDHoeiqrgE7UONLOSnEDqrwJBFC1tbYD2tSpSTWbiJtcCDsO+45NJkHV?=
 =?us-ascii?Q?XsF5Yic3JWB9/aWEuDzFMAFhiqG1FA6LHNkkN/r69KiFdFF32825CUhxt4H0?=
 =?us-ascii?Q?BZoe3UV/2Zi0G14J8VdrTMM9KpiAX0M++xjnV1Esw0O7tulY/FFnDp8Fq77J?=
 =?us-ascii?Q?dqN3UiGWFnbXnU3iHyh9NU5FGqnMMdwsUEnrl3mTFLmBi0EtkYyMPZJdCMI1?=
 =?us-ascii?Q?N7jlEtVPJv8A/Jm81wXyeWpkdSNXxkG0vUm4uVkj9wgx3GqB2q2QKi4oPB6n?=
 =?us-ascii?Q?qF191cwfcpZCjjFG5maQ2i/FhjJ7iGiymVnxnm4Wkr+tmK0veVZTLo5y1//8?=
 =?us-ascii?Q?gEeiz0fLgeQG5LL4Af5Z8KHeBJI9bImYTl0NouPSrldaZKN3D4Byg5ERfeRD?=
 =?us-ascii?Q?CI4e9VDSloiXBKHdHAGRhHGkDD0vBNwSWWJTXsDyPXnonXEZQwJYucqj4VLE?=
 =?us-ascii?Q?VJbQ3M68i5+czUITyhIWpYNCYHpPyVdvW0xMIsLGmDY9XTcURC6H0z089zuS?=
 =?us-ascii?Q?iTdOCvgaFYwSaNJhe/jqq5CWbM2xQ2NdVHXX6Z3CIk42MzEzQ8E4TE1Ux+Bs?=
 =?us-ascii?Q?RUrmHOrUG/AxkXsXVtIqJngssOz9YIM6FbNySnTyYL5aXzt5fEIrzgaPyJyL?=
 =?us-ascii?Q?t7Ka7MYxyyHpAn4EGQThIejTMAcmSBJeA/hZRpbabAjjPWLJlFvVESNTu9YA?=
 =?us-ascii?Q?dF+DoMHxFXPBhOKeuhL0tK1EdbVhPciASHdVI19T6/M4H6ABokWoF2/wajR4?=
 =?us-ascii?Q?ipMo86LNNwRCQYi4aoxgPfLOTznQtAnwmzvYoAyQomiN0eWbINq6s/mEveKc?=
 =?us-ascii?Q?f3zYdPP3NrrReKCfoAxJQfT99f0h8UB8Hy2iYQFd3iaGy28Sy+1jA37giQ+T?=
 =?us-ascii?Q?+ShN9c1PGc8TUzwzJEhkxILU2R8xbRz61T8JTKDFk0f4BC4fxNxb9L+heY1z?=
 =?us-ascii?Q?0R8RYIzJFrLp2j5suYewh/TQdc+syvHwk8pTTyD9XB949O0YqXpA+HKaizMp?=
 =?us-ascii?Q?IkcB0I1hc07meCX69LwbgSntkNghIM/MjmT/0x4oBSLJT2TYxYlj8FeNwulc?=
 =?us-ascii?Q?zWk/jy7bj2qFbS+Dh88dUWYaXXHs0r4JrCBRHfGvxhefXSek5U0OtGNFTx5S?=
 =?us-ascii?Q?L0+1BEqJKWwDLIT6O3dZeKnwHJCy7sgSVHAAoa+5cuJMvgHfjdWW6dUZC0ZE?=
 =?us-ascii?Q?hOD+JBMsHMn/RhRU2oKci/IfqwQTdboHflGxtDLeEsXWmLtj8DMMHuIQW6NB?=
 =?us-ascii?Q?+ju+aMUw3uSjtdK28VGI3V0wzuPBUJnPlLXKB5HZiOI/TJk5gB6IZOzyCNYT?=
 =?us-ascii?Q?AQxPAmolElnMyCAKQwaBx6h1XNTXV9+tu1PsuS2Dr3AAfONcrrIkTVROanM0?=
 =?us-ascii?Q?ONjYvm8fwnBsXCTYQZ3kmfw1Hzot4V5Z15BZXmBZ//tDcNIeumU3dCtl5y9Q?=
 =?us-ascii?Q?ek5rRAbt5Lww/hyedFAnJ0qNEL/ETwbaodv+b7oBBv+JBiwRYBIdI74Y9wgH?=
 =?us-ascii?Q?UmnlOte7QCZQI4zzogb/p10HFkcxwSn6tw+NulfXLjC2k3sakA/1djXqboGL?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a86bf58b-8b97-4114-3961-08db9791c7d8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 22:00:58.3376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5SlmKDG7UrkTMsw9u7uVtk5YVZRHeXvT6NKnlwaUeuRW31CkUeedMW/LMBFnfbYxg+aLHSPh8v5jjjRo20Stg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8566
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 07, 2023 at 01:15:45PM -0700, Vinicius Costa Gomes wrote:
> nitpick, optional: as you are already opening blocks for each of the
> fields, you could move these declarations there. (same comment for the
> next patch)
> 
> For the series:
> 
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Thanks for the review. I will submit a v2 with your comment addressed
(all variables defined within the smallest block in which they are used).
But as for "same comment for the next patch": the next patch is a single
line change which keeps the control flow the same.

