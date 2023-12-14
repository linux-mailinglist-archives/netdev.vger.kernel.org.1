Return-Path: <netdev+bounces-57382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 594D2812FA9
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5AD1F220F9
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4F43FE53;
	Thu, 14 Dec 2023 12:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OOxQcW8Y"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2048.outbound.protection.outlook.com [40.107.15.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15715B9
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 04:06:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUZ/ke2OzOTIO52TrjN3cmJQ1OP/qCSdLTffiJ8oxSjDfAYarvd1SXO+0GMfKdfrt0hMX77XRkyGt8CToQjO9AevlfG8ZLgmljggndoRnp3IrnMcP8w1FUpT2+vz6oCgE0cnu6ml66/2qk67aIBGGnZ3N+QAROsy39+/DJGpMTM9X63zaK33Kn27gxrTPnPoQhR/p0u0hXwcWnb7AsLk5rOUF2+Y/VZEiTJT0Hd3zqKMe0bb0381r2/Hpd0r8QlpZJBkawPedYvSgpfv45u/CtqIx0CwK/wqfkLhf8+szBKEVN8Hru0XikaqF7j2Ws6mKUzigvyX6vWrPLOxwwDkqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbYoDfDyEZfs2fPSPHrCLNmMvp7f8utsA2RI/R+tLP4=;
 b=dkeDhL4ncYulKpvMg1M/NIwVVo6AHMmP34Vt7FgdF0oa27b0bYOdctIWdof3o3VpNm3+zS8sLpIKpO+IMk4HzU0iGKB/6xrwWndKWjVrk24R8m8wMMoDTG6GeDpwH3ogd7ePANF6CYf8IQgu3Llv9Oo9BdhHOH/Nsg8SOMRNqsDrRJQXsQgJl4/Om3TjlPvqBdw+uKnnfsRkQqlZJZyTgzH7zgYoEjI2+jwQ7EbaaKoyr3mfOa77rQW2utLI0nmQ7KwK10R0p2NfjGcIFWBqwl5pr5cL+nmH+W1pLbHxMs8JRntRm5ddaDfl8PXvzHIEn9FRE9fCERujkSHnEBVMNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbYoDfDyEZfs2fPSPHrCLNmMvp7f8utsA2RI/R+tLP4=;
 b=OOxQcW8YGCPkgzTHm78zwBlL6iCkKDNwDTuxD7VqxTnbdCFnN7k3smJG91SE1fynag32rYVuv1SWocDqLMh8wLGYkN8YEcq4nzE1Hpu9H+KAQ6BIPKamYVVDY8lrp1T5/IC/R70mpSz2ygeC4lohhoHj8ZOhVyJfnCKriEOGXeY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB8092.eurprd04.prod.outlook.com (2603:10a6:10:24f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 12:06:31 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 12:06:31 +0000
Date: Thu, 14 Dec 2023 14:06:27 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next 6/8] net: dsa: mv88e6xxx: Limit histogram
 counters to ingress traffic
Message-ID: <20231214120627.7iw37bumqddtqyon@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211223346.2497157-7-tobias@waldekranz.com>
 <20231211223346.2497157-7-tobias@waldekranz.com>
X-ClientProxiedBy: VI1PR06CA0121.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::14) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 144d1ceb-6cac-4cdb-391d-08dbfc9d1bd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a/IbSahal0KsmJyOAf77Y9FH45XXKR6Nkr3AeXlR6BT6ff34TzAe5OCKo6UHkkf/XsyaT0D1o1tS8COF/FmXLRPfCN9IfVQjUT59Rn/KfgM4Qi5rtIoU0KBoBO9Xo8CzAHENHGeE1oWFncD0+GiM6w/sMABQvXikK6WSCUcicvIN9VX/yA8xBbhVW3OfDKrQ7sqrlOEpCileGo1RYocywVBxy5TKtzZrrx2LgYK4yQ2+li57tJuZyhjZssXophMYBzpd+rLOfm9X3365q838pWooxHDkMpwKTuS2kd4Xz6TAE/BnZEZtQDcZ8P2M6V1nGV1SRnxei8bJFOK8rOC42ra0GqdL2i+1THYVy2CiJ4jz+ITHpUGoHghSBUOn0yjbdqaBIoHs9W2iMR2qVJCDyl/f6cxhWSsSnWOrMMTTCpgkaNZ1uOZljhApLJL+bxRiwbHbRZvefnvXDIC6xkHi0z22VnSWNTNfuiF3Qju5Z6oxIqy78CV8ikSH/Cwac8031Px+9NOZhWlGFzx6/KKsIzdf6oG571dmYh9NWE5Ix7KDsdh2eT0r5NmI0N+SaPU4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(1076003)(6512007)(6506007)(9686003)(83380400001)(26005)(33716001)(4744005)(8676002)(44832011)(8936002)(41300700001)(4326008)(2906002)(86362001)(5660300002)(316002)(6916009)(66556008)(66476007)(66946007)(6666004)(478600001)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1VmhWJ2I9vDG4mxWlcoVU+OlDEu1wVAQyjeB5YZkQ7PoyMfXevtdvpgtGlIK?=
 =?us-ascii?Q?oL4+2oUhWDAm63QYIX7lLS1NXtpYSxaZR0QkoGEj7inaLFeNT8dCEm731S8d?=
 =?us-ascii?Q?psXlJ/fy0f9ZAv5k4YpOfL+Q6UsEmGlnD3O2+FCR6jjaVxjQHx1SDFc+Z9Jm?=
 =?us-ascii?Q?jdzdhMURLDmhB72c+ANK8IzMqhyuNWcV3c4iqyINcKTS4LnO6cMi5Qnr5qcr?=
 =?us-ascii?Q?MazPT+H88xYBfFRU9bxG6XgIfp6fcixOjJVp83hPnrz/BqzIOjCOOAqfr+M0?=
 =?us-ascii?Q?fOCFA+EwY73s1a+9JUDY1JJWaK4hhNTKtEBCp83YPpzkKNKEXpLIdN+XKkDb?=
 =?us-ascii?Q?b6Dklmzh3wIqLY74JAcnYDurt5pG7WbKS5DunpMlaN98Julo5KnmF+7RDh8s?=
 =?us-ascii?Q?KNFRVT75XpUPyAPAOG78uK2s4Yxs+8dKDJbEwEeWMtSvH3rFz7CWWOZMfrvu?=
 =?us-ascii?Q?yeWDcbpuCkuu+uboSnvVfGLhHCC4ctMG+PxDwjPko4FvZBO/nEHyfznVbHob?=
 =?us-ascii?Q?+lSt24mrJsg7StPQM0UMi33rz4yzoTtcSTU22kgKTBsr4bxvgKTcQLu1T9bb?=
 =?us-ascii?Q?Q3DatdORXLHMQd2hChySvVQYuXsb0sMcVqvBpE6qujToRxKcl6g08cYI/v6c?=
 =?us-ascii?Q?gGA4ADfup7KI7fwFB9ahofQX11H86d9q8t8Da1IcgjV5r7Il8/KFQEKJ2CPn?=
 =?us-ascii?Q?aFh3NvuZhBbzadkcHlPWV4xlinyJxJVUP7+qOFeb+t3Ap8J8uinLEcwIYz3o?=
 =?us-ascii?Q?deKCbFtiTv0/eboPqYpA3PKIcOX87iVfjuVgYjxRdKCc02VjfLTAnzaBJxKd?=
 =?us-ascii?Q?JwzkZG81XmzmclqSs0Rq4lNzkGaIFb0iircfdSJWB412D0dgxHO+d64fNOZY?=
 =?us-ascii?Q?fXrzCc/HF7Iu9NfhmMXXH8L8L7HX/52m/DntxdKyS620Hwn6lEikjjvmZBF5?=
 =?us-ascii?Q?e5wQytjKPVoSzu0b+p8xqewNuDL2rMxkpULPXCiXaHcwjCzA178kCHUnZ7wO?=
 =?us-ascii?Q?II4X4hI/He5SxPdQWusLIkC2Ww9broM9SOmHj6mQ4Y7BkBjU0diQCoFX53TS?=
 =?us-ascii?Q?MFKU1yYt7+A+wKdMRvxtg6K81GBSQ4F0IC1SeV7+nveGX9i1Loyd5vc+n5mJ?=
 =?us-ascii?Q?6pVRJjriVtLhw6zQ+e/a7O66UYB8FLzo9Q0uvk6KGttEAkJ2vPJaubAvIxyB?=
 =?us-ascii?Q?9taav0lWHqioEvL+fF72n1o2AH8yZiKqLzPv3wLPoSwNkLXZWZhCW2Hzgigv?=
 =?us-ascii?Q?etZCrGiifXePLAWGz3deoEhJG2G1W2wrVoqH00/Cud+2uNhUppYkF2/oqfSu?=
 =?us-ascii?Q?7ZiS3z0n9M+JdeT2kWNiWRpEskq7NNnTL7Xpzc/LP2bXF3IWRGmBBiwEqaca?=
 =?us-ascii?Q?31fNysImg2p8+zod91O+dDt18qPrYE8rADiI5GG+EeRAfj0heptbGaf6m7Ld?=
 =?us-ascii?Q?YD3lCtJFVWov3NY6xvVCvGCvg4rObigi1cWObDUnmUet8prKVmmSGOWt84Pd?=
 =?us-ascii?Q?5Cd+gzIH5b5LGWIxIK0zDL2oTvAITWQNARcvsx0+OPFq80KJxZtBFggyTooa?=
 =?us-ascii?Q?tbk1lL2Xf35i55WltK13n3Doai1eMIGbruuBLxRxcjk/3AKOOL6a68RmuRSc?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 144d1ceb-6cac-4cdb-391d-08dbfc9d1bd1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 12:06:31.7609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LumgvUKuavkXX+6qQTrYEWYPMZ8H6YOQHE3B2kHEMbz9uGPQl58Xdg88BIxPhQhL/8+8zZ0jazlCgWx8KztOPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8092

On Mon, Dec 11, 2023 at 11:33:44PM +0100, Tobias Waldekranz wrote:
> Chips in this family only has one set of histogram counters, which can
> be used to count ingressing and/or egressing traffic. mv88e6xxx has,
> up until this point, kept the hardware default of counting both
> directions.
> 
> In the mean time, standard counter group support has been added to
> ethtool. Via that interface, drivers may report ingress-only and
> egress-only histograms separately - but not combined.
> 
> In order for mv88e6xxx to maximalize amount of diagnostic information
> that can be exported via standard interfaces, we opt to limit the
> histogram counters to ingress traffic only. Which will allow us to
> export them via the standard "rmon" group in an upcoming commit.
> 
> The reason for choosing ingress-only over egress-only, is to be
> compatible with RFC2819 (RMON MIB).
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

