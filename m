Return-Path: <netdev+bounces-54045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 092BA805C9C
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 18:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB6D1F20FA2
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5A66A32F;
	Tue,  5 Dec 2023 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jzIyvZjj"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2081.outbound.protection.outlook.com [40.107.247.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516F1188
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 09:52:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTJWNLD6BKq9BGWYihk8VGsh8sKGJ7KYTi3FrHkbuLiYGLtpEXcqVoZWIE8HgUCUxg5iQ3cDvf5oVh/9WgSy63Nh86qLlWGKEHfakft9dMk3P+rFen5N3WGg1NIJRL0al0qyAzTjhY2yvq8lH3F0R6BtiplUwTJck1jjXrFsMz1Ym8ZTWfbpipjsJO6/XSfILAjnLjOrtBEAbyxI7JKywFMTvxK6o7MYF7zNfV3vHXjqGy9EyE4cfcxC7GTlgGqFgp4k5C59SpKbSWrnfp7POR855m/jF4umHnVoIcJBXEOg5g2f/9I28hDfOXi0xhzbVbleXcllKTltA60xzLFxQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4pVFLfohkTG48p5HgW/lP3xMSD9DLsXahENziL9DEc=;
 b=ltdQ8+JgJftl/LvOnQUiWUK0pogdTaUwdK62AB5klUMAq709k+EyI/hqRSlWfrW+30DBact8WfJ20woRhf4RidN8+96alO+jfYtPClx9/+D5AsMkyZSQoJfH2u9l3VuTCayBEzDwpnuEPmjdIhpId8yakbqO8wbU5/ROVWkm4WhSxL+y/op4p2+4vSLGOPzVOzxUfX/Bbm2oXmhSR51Xg/Xye11BLin6dDK5BUMU+ulDtNxhAEg9jvZkCulDDoqpAopv0OOdi12omIXNMMGk068fyOAnoqPRjiI13HIb7SvtFDtXkUH4oP+8H15W39FluQ5FqqsO/XH1xPFpcvAF5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4pVFLfohkTG48p5HgW/lP3xMSD9DLsXahENziL9DEc=;
 b=jzIyvZjjkhHz7i09RN5L4eAKd9uSMbBet+VZ/+XEdYlEOuwwvuiKS2sWemwMRZPRbqmOhpxxDj7IBCS/x1iFbSZ+HI4AuGmp19Dkqa8fLP/WY1//j4Hi43KfTSh4eVStHqH1sfoBZO66pHUGOrvAUqdSahFrlsbBAUr5eWLF5lk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS4PR04MB9315.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Tue, 5 Dec
 2023 17:52:03 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.012; Tue, 5 Dec 2023
 17:52:03 +0000
Date: Tue, 5 Dec 2023 19:51:59 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 4/6] net: dsa: mv88e6xxx: Give each hw stat
 an ID
Message-ID: <20231205175159.fv2c3qnorcelouos@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205160418.3770042-5-tobias@waldekranz.com>
X-ClientProxiedBy: AM8P191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::11) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS4PR04MB9315:EE_
X-MS-Office365-Filtering-Correlation-Id: c7af5591-6a09-4c50-b837-08dbf5bae334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hUdgJSfYF7nrnOOISnmeb4fNpz+93xYSKaim+hHwWbYaf5CHnJzFKCm9PcTTZJtbmyWJ3I3y5ywLSQdFHtdKmixraxhrK+qfila4G2kUgsRZ7lB5qLvEZ8CWdTdLMRB3n6RSdiFHb5Wlznh9pJja05dZnh78nx5WRqU9ID9w4fXRfEOJcaIDIgCvKJbBt1lG+afRzLwpiSEWb7L3QBDgjKR8VLwFU0SaA94DY6o9lTN+4lrub3fveczvBn2zDZgC5bKbqj3c767OKZ8f5O4th4D4LamPC/fA4A7f08xk2n6+A5plK4Cxb4W8fh1SEBr3VSN0I9t1ITQ7y2TqyjAofrmuUdvVqKhDRUikoDdg6J74O/fJSeggfy54cPcHlCeE2SoFFF9g8mPDi+AXBYKtL55SbkCkg4OkzmuY1vHBRjRgOJSLGr57SuIER1U142oJ2Kk1LgUlhU6yIZXlZEbKRgcHxVgevo1z70p9zEX5m4RuL01uYzbG4GB+kGd/fQxnAJiyLzGbWyO9MGWx+Pp/89HmMG4tQvgUGnnCbTo0ocwvjgeqV0Xzz1+0qoRhojsZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(136003)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66946007)(6916009)(4326008)(8676002)(66556008)(66476007)(316002)(86362001)(8936002)(44832011)(6486002)(478600001)(41300700001)(26005)(4744005)(2906002)(38100700002)(5660300002)(1076003)(6666004)(9686003)(6506007)(6512007)(83380400001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XrZattrvp26DqK2SlD1O5VjtK2IlSgojJcXYr+LL5qP4fXMzWXZ1CSjl7Duc?=
 =?us-ascii?Q?6I1A163wwiUBRh+Pwia1DjmDmekZ1Gl070dtYnZKHouwd1naIIr/15VBFfxq?=
 =?us-ascii?Q?ZFmXq656XdfI8GUd0b20DWNzvEliX+6fLUSB6MjI+6XjbqcUFfln2WFNM17n?=
 =?us-ascii?Q?g3fwjkPiJ7MWIziJ/iGIv5Cc57uHPx85f7A+oTxMfO7812D3AGV7B06lxv9H?=
 =?us-ascii?Q?XoVAcMuc5edjCFWoTMTKDcRjviUg+cLiJOaRCuXfjkMKN4qQLwjmyLZzuG/u?=
 =?us-ascii?Q?rGvnoKaIGilkvstuLxjorCbImWb+VkC4PwZLGZ6fSmuaSkggCGRZ0nRv2/iN?=
 =?us-ascii?Q?IMEiEUc4pXBfoT6db2EHRJuWwLLsivVAVneCaHUbV5XQSVutszO1ukqkLreb?=
 =?us-ascii?Q?KAXhYnD3hb3eTmmVfP6Lbs9iA5As0fP/tIXJC+TlAWMJj7eX4IJApNXXatXf?=
 =?us-ascii?Q?TH6tiOYclgx/lZeOZscfw16iviSoDeDuJGxNxxLYFUkWaSduX85Qnz+gs964?=
 =?us-ascii?Q?3xM3sxO5dNwlYXA53g5VvLkJaCwjIAIQVTzqcwEaWCf5OQL0Ii0EjjNGFecd?=
 =?us-ascii?Q?4DZOJO6paBZDybVthNZ/oYaD90koJryD2+iUhWV5RVUAoMZLPJRTLj9lhqs/?=
 =?us-ascii?Q?WcVBy6ZJCzdUuyeiZOOI3KfsGuJXBz8GwVVbYCFqPPwt/+hFfmAAA0BDIIvt?=
 =?us-ascii?Q?8zpTdkS7oFCVFkf0M+XAlvg5GJiK3wr5mt4vbD8uC8WpOl6rSfzRA5DXOH98?=
 =?us-ascii?Q?eY6v+pqjrOrBWRhF0wpP2LxvXsgoIKL6O20DTbMHcai7ltRLzLucWCpDQ5YQ?=
 =?us-ascii?Q?xcUeMMxiOi5hYAHK5jn7B8rp29D4lqeeD31R+lDrVaHxFlGDq49KzfPb8/ln?=
 =?us-ascii?Q?4anUB978/GNhFHJU+CH8w1LP31lncj54hLnHv+Nbq9lisx7OF9ea6I78Vhm+?=
 =?us-ascii?Q?xDF32bnA5ZTLPU4h+PYgerhuBDsryuWZbyTqXc1G2MzuLXvma5fdzD9Lr14a?=
 =?us-ascii?Q?8iSRMGAOT5/uUybBI7J3G7LFQqbK5Vh8pqHIBInP1db9cKoCR7zzzW95VSSu?=
 =?us-ascii?Q?qWAsKRXGvFn7PyVB/04lS+YQxKGZU7NIAWlEiIybpcG36bd/N3XTAsltSlil?=
 =?us-ascii?Q?M3SkO4Aljw2cES4uFM5dw0Q3PvzAJ8qc94SUptRgKj+1CSH7TduMCw4Cv5hY?=
 =?us-ascii?Q?YAwSugkcH1ZPK+3ltIPFOVyx/mlPQO1DSOBqLXE5NdtOQN4lMYqi0Kw1M8p7?=
 =?us-ascii?Q?QlCfq8kOA2pAk+ZF3ElB9oLXwJPSHclOaOrx9BezgBMXbjSt+YDf6Gnn65tO?=
 =?us-ascii?Q?rdavc68ZV2TSnO+d/9zO1zPpcd3dn8Jvxf+jnF/G/QCXL5G2900hKxB4Uq0d?=
 =?us-ascii?Q?86Bi2n6U6kIzELVJF2NJ6xDqQm3ln1RDkSp42TSxGlNQxGaAw/w78beFg2kA?=
 =?us-ascii?Q?54LuJOUJGfY/+UZ8fWcxVGv8lR+7Z18lfR+XEdStxhov2yIdwdYmPj7tJQfC?=
 =?us-ascii?Q?Q8Ang04356pQhWBG6OD4UOAMhO+43BlaqNIgTtUGLoFisIhyEo0b+rasqEq9?=
 =?us-ascii?Q?2Ql1g9aUixmVZJtmrUmX/aGo8lECCoK0zZbo8v8JYI62ljJr8Y5XZ4VdJDY9?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7af5591-6a09-4c50-b837-08dbf5bae334
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 17:52:03.0668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsxdt+tYTMwXfq8KAiGLB/eMh5U2rHbTQDTzx4lGDeEbdg3og4LMZDal7PVBRdsXsaDMQYsdSsDimsCzqyZ1lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9315

On Tue, Dec 05, 2023 at 05:04:16PM +0100, Tobias Waldekranz wrote:
> With the upcoming standard counter group support, we are no longer
> reading out the whole set of counters, but rather mapping a subset to
> the requested group.
> 
> Therefore, create an enum with an ID for each stat, such that
> mv88e6xxx_hw_stats[] can be subscripted with a human-readable ID
> corresponding to the counter's name.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

