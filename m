Return-Path: <netdev+bounces-38214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C952D7B9C90
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 12:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 77495281ACB
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 10:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA644125C3;
	Thu,  5 Oct 2023 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YhG+izNe"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211498821
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 10:45:17 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::601])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4417222C92
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 03:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dl3AkIuVe+0Acg9FxcOEFcisnrcJa+VDGC1rOrNYRl/ewwkZpffqWW6qT2GSK4CwtaGRcs+MN00nosOs56vAT45ambKvWDBwLeByJJjGI0bLLdGvHMVsH8RUbz/0vr9TGkOYNRiSBOaEQK/ejFUH6jK1UwoxM2dXBEtu9SuiJ9R3wDBYGYRjar2K6XGI6U44/DXd9yqMVs2YRhwIUwO5FvnxCaMDSTA/UE0NkoI7Xap06F6Md+lUZljJRanbAhzSCeXHjFhsKLn62hdVJOy9zESqp+by4+SRy7okiSTYvGyB5jtlcca/vrppi4JHr/BwJbD4heEZNru4jvBXMXZz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IV59ZjP3Oq17jDgoQQIbHE9er8WjRMYwcVO6zhDfSKo=;
 b=ArbHfdl+m8INHPLrPTIG/Me0bSApHiBrOkITQ+isgyy3Y3ztAhPjql/tdNuAKin4o38Z9mnAQrTjcgkcsU+jjxEFC7SDbCW+IWvSoH54Rsuy6Z9tan6X81c7hdCwysnYbp3leCeK2op6xKlrtYWNy5U165ALqe4HCR+mcGuaEgGkRpmDJM159PWMk57teCvjO57+PmSIJk3jFiM+Yg1MER6kZKZH6J8Cp/QL3c5ZWLK7kILhNWL2Y7hRyuTMAbvgKqXyXENgChYaVqYNskGNR+8Vdo5dGkHG4pY8r81y00xsQH2U8LbAzlrb412V4r1ap1OebtREUsJ9FKTw2aUOOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IV59ZjP3Oq17jDgoQQIbHE9er8WjRMYwcVO6zhDfSKo=;
 b=YhG+izNe9YDO8Qs9FdObxNNrJc8kzPIP5MIeQfjE3IThFAYyYeYunhHUhQKh4RLunS52n/NMa7epK81X9ADjlElF3GFCXqGGCoLy0uTHXefB3k3D+BBUUDbTl0DkBcWsH03LLTmv8erazoUdJL8AA6GU5KQCIbgS1DHdO6vxs7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8526.eurprd04.prod.outlook.com (2603:10a6:102:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 10:45:00 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::992:76c8:4771:8367%6]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 10:44:59 +0000
Date: Thu, 5 Oct 2023 13:44:56 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org
Subject: Re: What is the purpose of the first phylink_validate() call from
 phylink_create()?
Message-ID: <20231005104456.sytvw32f2r2qnpuk@skbuf>
References: <20231004222523.p5t2cqaot6irstwq@skbuf>
 <ZR5/ADvrbMKcKBSy@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR5/ADvrbMKcKBSy@shell.armlinux.org.uk>
X-ClientProxiedBy: FR2P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::9) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6919d7-ea17-4b27-b99f-08dbc5901f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b7RawXMgcikp9DvCppErWBhjE2knnpaT0YGJ1oMnfHmvBm29BcBKdDg6wBkWErAMwHh7q/F3VjaAu02Ua9g0tbGDj/iSwPVgGNRwV/aoBkm2PkR9GLaMr3g4fKoOaitUwcjPCXHytAzDfao/TLCfH4eX2ZqHHMZNtQM8mnLtHaKTm1O39IJGPrhBkN/iaQjt3dCGyH9LFhdn8WY0SYAYiN7yok3vUEYtm24SRkwhI0xKluEVHBXU/TXtEQzRSb8pTfuW+bEqdsT82rgmwsdVK48QhLzA8wUYsB5DMLcQ695IglFBkExjnLVe2O4TFoKJ1heRwdEcepYiHG4ITKi/O5A399uMVvB5Gq7Y3H5AqVXGXEQmJfA6azDwuj16rSk1BC5LqxMWIRc7i1DawrgBjkCjm31hiXXOn/CMR7qtZB7DlihQnnjjzYtVx/FAHHOVTa3C8hRmUXYBfpOCGMbUN70LbDrETPbMCUBZpIcwyCdKNm52TCfOTjztsAOccw83u4jHpmvrrNEHK86kQgDYSYNGApg8WAVl646+V/9/g/k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(366004)(346002)(376002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6512007)(9686003)(26005)(6506007)(86362001)(66476007)(33716001)(4326008)(5660300002)(44832011)(8936002)(2906002)(66556008)(66946007)(6916009)(1076003)(41300700001)(8676002)(316002)(6666004)(38100700002)(478600001)(6486002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OBI+Pr7mvvPpxbto1lO4iAF9vmf879l/TrgwUsZQ2NCy4xqahZ4I0gCAg7X4?=
 =?us-ascii?Q?a9OAut/PUMxBil1vOcmBXgF76qrZheSv4Uwzq7AFoUzhcRESiiyGJoDtnpd4?=
 =?us-ascii?Q?j1Y3QEAe1VobScYQmXCuB95V1TCAi64sXAkZTyPhCxI0xukClYke1rS3XXZz?=
 =?us-ascii?Q?Bhidkouxet5WsnGNFbbJjRwOvR7E/2/zRcZVW3JaCDj641cCIuRE7J1kvBOl?=
 =?us-ascii?Q?U4GT0bYsXVsn2WGgqFJaT3IZvqVhAuX2YgHbKhQ5zA6asAhuuJdd2LOv/zvU?=
 =?us-ascii?Q?u57rWBQiANjGKNE+rekCBOqS6t5Q63ncguVuT91uGsAI+niNZoKDp2FuJlJz?=
 =?us-ascii?Q?/8sxwTcpD9sQ52yHKkj3pp2XZWNydYkRW6YDxRezr5+Dogg9F6I20e5c5YM6?=
 =?us-ascii?Q?HBhXc/LQjPW1VgMmQeCautjVl+7Q/XQ8yjA3mdjWcbA1cLOcMFEj4K3Lcqyx?=
 =?us-ascii?Q?kiUBKxyblJaicnnVG+S7LG9YGZDNH4z6GgpyAvxhAmZTYqDOUNWZbT/iQQNq?=
 =?us-ascii?Q?sYWVJE/MaK5NmbOBnNDL4SGlDaY+nj3Zhuy+cC/lC/Nj+8nkOdO7om+cm0sJ?=
 =?us-ascii?Q?KOT54YKUp/+D6gGs9xzfzpOMUKGBWoinXxA8xOtWlEFNzuQBUloq2pY+0QkN?=
 =?us-ascii?Q?WuzlOv36qAL0iCC9n/0g1OUglqBbdm22Y/w/89lsP6GJwLUF3X/sMR6v4JCl?=
 =?us-ascii?Q?xcxm0+QeiNX794u7JkLpRCkW2lHvtRT5voNNkjtLaaoiBGf93TBeVDv1Z97Z?=
 =?us-ascii?Q?Imfi7JKCGF8tDqY6wbvKAKvPyYdGn58P05iySk2xo7A/n4WJr2m8kN5aNanB?=
 =?us-ascii?Q?Nw7yXzyiuVmRhWsmYhzjsHwsvO6ppHllyK8yKXIxlGj7nFDd4Gho8/ZcSDK3?=
 =?us-ascii?Q?opQna7H9j7MMSup6ASSDrUIUw/XAyB5bDvnVz7ejnfjWjlu3EXWRO6ovWV+T?=
 =?us-ascii?Q?XJBWuacSmpwgIYlVkSPn5FUXQjDFQb2J4AJbzDI6eheOxRM1uyVxf6m9erPZ?=
 =?us-ascii?Q?curz4JPU5YQSiVGTzhSwAz2HWzGU+JHF5LxcmownPzCZuDJ9cqASraeCSBVC?=
 =?us-ascii?Q?/7JyAKOIG2/reP803BdkJ8/8TSLIZC0JcMcCWYiezOzwCVzTN3jp8zKj23MW?=
 =?us-ascii?Q?B28gvecyfirtLmLZBpyK8ceQupuopRfwRiLYPSCPpPcCr+cb3N3j1EGXx3zS?=
 =?us-ascii?Q?IoDYAjDSHEW8xlr6D8Q/St6eV9qXrOtPXj5Fryx63k1jV6Exeoam0C1GbC/e?=
 =?us-ascii?Q?nQiiGO2LNTXOYllfcy1ffoth0uWtXaKyuccdxUhYvRW3TfiCjOGjA/q+VarB?=
 =?us-ascii?Q?7e+lDSAsuEQEB6QmDsIfs6+U9leuwgN9T5SuHfLMtgeQczBaObg7+9ENjVKw?=
 =?us-ascii?Q?3TOansCWvHxLZbcy3DHeGJoTrY1B7bDLfIrfngbf1pWaIQJUb9ObmpuOkMza?=
 =?us-ascii?Q?ywz/A7Xu5681fC+GE1GMTzR/oB7nm0pmFgsDDwMt+BlbRQ//dwux5PR2gGQG?=
 =?us-ascii?Q?h8TVyGxJs0Im4IA9PeW6Rx9J5zl7No+AMyiZNQq/A8toQQKanTh/51FzKJHg?=
 =?us-ascii?Q?cCag2MJ6/1A5YBLoHL0OvQ8CB/DOEhnx4SQ5Mx2ZgBl9WXz2Mqpa6GlBFbH8?=
 =?us-ascii?Q?bw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6919d7-ea17-4b27-b99f-08dbc5901f6a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 10:44:59.8683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTTQ5dLZuAApJG0tnfseDUTzLPS38AYPMrSLLhOtP03A9AhtfmXhm9gqmq6gLFd9Zh52BGNZ/sHYZ0HIiJFiuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8526
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
	T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 10:16:48AM +0100, Russell King (Oracle) wrote:
> You've found the exact reason for it - so that we report something that
> seems at least reasonable to userspace, rather than reporting absolutely
> nothing which may cause issues.

Thanks for confirming. I don't need to change the user-observable behavior,
I think I can work my way around it. I just wanted to know what to look for,
and I deleted the phylink_validate() call just to exaggerate the effect.

> The original code in mvneta would've done this:
> 
> int mvneta_ethtool_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
> {
>         struct mvneta_port *pp = netdev_priv(dev);
> 
>         if (!pp->phy_dev)
>                 return -ENODEV;
> 
>         return phy_ethtool_gset(pp->phy_dev, cmd);
> }
> 
> Thus making the call fail if the device wasn't up - and that may be
> an alternative if we're expecting a PHY but we have none.

Ok, but I admit I don't know how to make phylink_ethtool_ksettings_get()
return -ENODEV just for this case. For example, I'm thinking of the
situation of a copper SFP module with an inaccessible PHY, using SGMII.
My understanding is that phylink_expects_phy() would return true, so
that helper couldn't be used to discern this kind of SFP from a PHY
which is accessible but phylink_bringup_phy() wasn't yet called on it.

In any case, please consider the question answered for now with no other
actionable item.

Also, I now see that patchwork thinks this question is a patch
(https://patchwork.kernel.org/project/netdevbpf/patch/20231004222523.p5t2cqaot6irstwq@skbuf/),
so:

pw-bot: not-applicable

