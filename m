Return-Path: <netdev+bounces-53478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA508032EA
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 13:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BBD31C20A2F
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 12:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EB120B00;
	Mon,  4 Dec 2023 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bNjezLkD"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2073.outbound.protection.outlook.com [40.107.13.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0ED83
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 04:35:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0iza3Kbrq+2PkyStDsVSiXQzuf78mLFHDDgp2eIFvZzQxrXC25nig8M+b4qPWJwUyi3RpP5xmVg4J+MN7BsAjRIA1sW1wJ4Fd55DHtNErS56mR5x7941KyN7TifWW0jRS3NyiCWx0oLU9EsCFZrHEVBGbhn0drRX6sM+oUPY+14Ho9RY5oCZpHvuMqO7UWEK4RMVjoKSrK3zuZ/+EhjulDKkx3M5Gt1hzLDpxJshmV5LnwTHli43qkv7iUOwCTnZ1vYHajZjsSI/qDfJG3JCnDjPr9hOdZrhmnqZoa4IE3DAiki3v6RdyIjBnwk6ivlhKYgKF5gnTprwwEL1uKi1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaE7pSXLrWAFZIRoaldcEMxP0rF+kuft1jrNb+6D6Kg=;
 b=J1usLedaMWlMJKbtJl76LZv7XQ0aqul5sJyqCLEjnDqhX5xXZutGUyfqUPw1TvqoCJ3MPuPNJXgC7KpPNA/5Xx0YjGGFr2P4c1S5bjZBfSQKsVdJt1rLGB5YzxHxjxrwGx6gHQsiBf+cQ6wQXi1G/UvNdeL0Cw74Y3F/Q96FbUrC0Cx/U94LjfGz2rZo1UW0UfIw6ljLN2TicoQEwmgSofda5L9yZiRMizZRl/1pkIQk5uPFyCAt78wnwW25n+/4Ga4Oq/IHsjH26SctKOOwIuK/PyV5HwdRbfYXwJmtrPcJ3XJF52KCHPmRFYPSdtLSIqnpRAeUM7Zd5yekOUmlpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaE7pSXLrWAFZIRoaldcEMxP0rF+kuft1jrNb+6D6Kg=;
 b=bNjezLkDpsrJirwllNsmADsJE8uDCgQk4CAM/dmxwuHmTXg+Fy9g8EOKDk6WgYRUrcHj5Nl4voF6XoqS7/P+97uLj3smlOAT1UuaqPwgMKZzcnGzPUWkmaKhdOueuRanEYVzt+inSlecCNKJud0FjeTSMkRHiJtLLIvsITXS4yU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS5PR04MB9895.eurprd04.prod.outlook.com (2603:10a6:20b:651::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Mon, 4 Dec
 2023 12:35:35 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.012; Mon, 4 Dec 2023
 12:35:35 +0000
Date: Mon, 4 Dec 2023 14:35:31 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
	vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v7 net-next 6/8] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Message-ID: <20231204123531.tpjbt7byzdnrhs7f@skbuf>
References: <20231201135802.28139-1-rogerq@kernel.org>
 <20231201135802.28139-7-rogerq@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231201135802.28139-7-rogerq@kernel.org>
X-ClientProxiedBy: BE1P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::10) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS5PR04MB9895:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f93ac3d-6974-4cc8-9e51-08dbf4c58320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Wf4yj5ojFiVKDnO7zokVgTGpn8+vAEmt5oCc1K4CkMyLTU5r2EH1mc//jsUJNWtGdeU6etEs0sQxSdljG9FuJbcV7Nsm6f/MeLAJ0MQUhdzUoC7RYm6gf7zQc9UuVcJRpRtzorkuW8Cls24qrXr1vY8cJglcapPjr+qdy1Pet9XmpSMIkm1TL6SGZzeoFFu0JGBsv7aTOpQjLsnQs9o/tRQ0UOr2fjfx4KIYHTh8lA7CpnJYhir5kU1CaM9qjkgNh4baa5kBiwgqesFImUZLx7eEou15Iq1XW/i1rA0VSxyoSS2AbxZbQ9P6jwDzNdVlcB2WLUfkm2e3HJZJoExt21HPbyQhGtcCyu0/U+WxaJeWvzwbu1gSITRXAScqnPV86yr62uve2JOI4/T9jrN9ygqndGq/hHF340SfgqQLBdW+JtKjpfm2fc0bhz0PStb0K0wPqoEofYTVIdIZDBv+Wz9mxlf+h/yu35NhH6chRmg9gWjCZ2UxpuQ4YvJNeSIiVTOzrUOiKtMZycYT2OwVLi0TbLnmjKiGWc/w128VqzW5z0dJCuX280RfGThd+oEB/qSYyTUsixy3aI1WNpBY7Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(39860400002)(396003)(136003)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(26005)(478600001)(966005)(6486002)(83380400001)(6666004)(6512007)(9686003)(6506007)(1076003)(316002)(6916009)(66476007)(66946007)(66556008)(38100700002)(5660300002)(4326008)(86362001)(2906002)(8936002)(8676002)(7416002)(44832011)(41300700001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2NWMldTZGZtRE5aQWgyaWNMUlVtQTgzVFREb0xaUzkzTGF3dkQ5cTdLbGhu?=
 =?utf-8?B?RXUvMUNqY2VYSFVFL2RuOTJCeWdkYWs4ZVRkcHlGZDd4WURHYk5KWUxyek1m?=
 =?utf-8?B?cHZYZjdtbkdTQ3MySkNIeHVTM2NhUDhuZkRCTUlqRUV0UUV0ODBXNjVxSFpQ?=
 =?utf-8?B?aGZ6LzdlM05YM21HcVJ5Mzd2T3dIakZjQklvSVBJM3V4OGIrancyeG5yZzc3?=
 =?utf-8?B?NURsaFFvWlRxS3RFNk9MNUJSbnpmMFVmcjFPd3g3ZVdTUVVJemZkS0h0bStY?=
 =?utf-8?B?T3FjSmdDdS9Qa1B3eDFaUzB4L2t1Uk14NlhFK0FTazdpdUp0eFI4SzBSejFH?=
 =?utf-8?B?NWRUd0JrdDR5M2JGTHdjdjJsRXBVcjRpQVRHTnNJZWo4ZmFEczVWQ05OTzlI?=
 =?utf-8?B?WmJGZXpFRnpWYUcvSXJnb1JtQS85Sy9oSXV5UTU3YkR6T2w5QUtHaTZNdGhu?=
 =?utf-8?B?dlZTbzNvZ0I4ZzBXVEZpekhkNDlSeURXNS9lV05WTDRrZzJLZEZXMVNPbjF4?=
 =?utf-8?B?K2lOejU3THh1eXJjUThxMGxJcTZNeGk0RkE0MUgxdzN2T1ZlYUQ1QlJMRCtX?=
 =?utf-8?B?N0x5THhvRk5TL2kzeUNVSVV2SzUzRVRJRmlSWk5PcGt1QXFxVXpHdnVxUHo4?=
 =?utf-8?B?d2g5dnp6VXdEa3ozM2hkMTd6RzhUNEttT1UxSkhJbVQ5b2ZMcEl2MU5ZSElK?=
 =?utf-8?B?bGppM0Z3cGlBN1VucWFVa1hzaFJ0WVJZSkhMY2NDak1qQkpkK2R3Y3A4Z3FM?=
 =?utf-8?B?d2NIN0J1bzlxSm5jekl5NlRRZzhpaG03RXorU0Mvc3Q1NGtidG5HZ1J0dVVv?=
 =?utf-8?B?RG9BMCtoZFlRSXBlbWVUcnhYcDZ2ZytCZkxDUU91c29RNU4vZVhFc051V2VB?=
 =?utf-8?B?Z25qZE00WkdFWWRUa3A4dUJDTnZJRHpzRFR2aTFjYVFOS1o3ZFFtRlVQemJt?=
 =?utf-8?B?R1dTWXErMmNlSVdpWGNmWGhlZkVzaHdESlVsYzZQZlc5SW50YzV5blRYdXpR?=
 =?utf-8?B?QU9nT2RKbjVXUFh3WGtOdDlOdDU2NnlUWktjcGtBRUZjSmw0RXdwYzY5SDFP?=
 =?utf-8?B?M2dCbEVJMGxTTG4zYmxPTElHR0wvRjN1cjFGLzlPNnlMOHZhdGprNitPUWRW?=
 =?utf-8?B?SVRCZExMZXZIck9SU1BlbVdGcmRPa1ZDSHc5RVVzZHhGZlVVYVlyV0EvcGFX?=
 =?utf-8?B?UGFQSHE4djB6M2Jzd2VSSUd5cTdMTXRtWlFvSnh3SFZPMk1GV0dhODEyajR2?=
 =?utf-8?B?Q2F2UUNNQkxRL2FERDcyR3N5cUZIR05OalBDY05PZlRmUytlZWduL1JLUzJn?=
 =?utf-8?B?eXJ4R3AzaUcrRmY5T25ZT2x5V2ZHcEJVZ2RIMXducng5U3puM0VwWFdrOG5y?=
 =?utf-8?B?ZVFiS0FOcjNBd0d0aFMza2ZVRzd0VWQzTVQ3aWdSYjRIempkRVRYZXNwUE12?=
 =?utf-8?B?T2w4UnVhUzJMUmhOeW9OL1YwaWl2RWRUT3FzUjM0QkQ1WmhtdnkzTklTbFpK?=
 =?utf-8?B?ZFZOaU15YmJUNGxJbmxyQmxqeTYrc253YjRpOHZkdEhsWmNpSHk4dW9DY0t4?=
 =?utf-8?B?ejdIdUhBWEFVZTJjM0lZd2NLaDlLbkdKdGU1dE5jRVZiZFZaeCtPVkNpK3pE?=
 =?utf-8?B?QkV4M1gyT3lWRzhMWG9NbTlvbXVKaWVwcHJwck5Od0wvNnRlUzVEZXdGQXBI?=
 =?utf-8?B?Y2plcjZVWXVidGFnVXIxMlMwOGkrRXkvZktMRUcxMXlnb3dwNVlWSGpZSkNz?=
 =?utf-8?B?eHpuVk14bjlyS29lK01iNU0rVXZZRlB1b3FKSHl3Q2w1aXN0OEY5Rjh6Nmtu?=
 =?utf-8?B?dTBHSDBPTjV6VWhIZ1daVFc4UWk5a3N2c2p3eEFob2EyS3FndU9iOGZLRFFs?=
 =?utf-8?B?TGRBVUZpWHY3c0p0THZsZmF3ekJRbnhYeGpRczhMTmQ0RzJyY2hZQ254Zndn?=
 =?utf-8?B?Mm10cXlGQVkrU1M0QldiSDRuekFiWXAvUlRsUzl5WWd5SURqZDVKWkRoV09T?=
 =?utf-8?B?MXJ4bjhhMzVtYzhsR1hEcTFVeGc4azd0ZEwvUnhBRlBLSjZiMldJdTg2eFhu?=
 =?utf-8?B?RXI1M0MrdHBobVVjSHBraUw1NGRkaEtMMGFxMmhhV1BTc0YxdXlNOFpocWxw?=
 =?utf-8?B?MU9RRFVvaVkzekZhVThvaVJrbkhURXNRcllPSHQ5TityY2hDaWUyN0t0NHp5?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f93ac3d-6974-4cc8-9e51-08dbf4c58320
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 12:35:35.0102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jfj0/XLgLjQWz9ikYL4H8nsnAgHOBa1/Xyv9WUSrmSw7Z/kzY0uJLL2gVqkXu3WAhAOoOCX9jZq1P8mD+u6IZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9895

On Fri, Dec 01, 2023 at 03:58:00PM +0200, Roger Quadros wrote:
> Add driver support for viewing / changing the MAC Merge sublayer
> parameters and seeing the verification state machine's current state
> via ethtool.
> 
> As hardware does not support interrupt notification for verification
> events we resort to polling on link up. On link up we try a couple of
> times for verification success and if unsuccessful then give up.
> 
> The Frame Preemption feature is described in the Technical Reference
> Manual [1] in section:
> 	12.3.1.4.6.7 Intersperced Express Traffic (IET – P802.3br/D2.0)
> 
> Due to Silicon Errata i2208 [2] we set limit min IET fragment size to 124.
> 
> [1] AM62x TRM - https://www.ti.com/lit/ug/spruiv7a/spruiv7a.pdf
> [2] AM62x Silicon Errata - https://www.ti.com/lit/er/sprz487c/sprz487c.pdf
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---

Actually...

ld.lld: error: undefined symbol: am65_cpsw_iet_common_enable
>>> referenced by am65-cpsw-ethtool.c:755 (drivers/net/ethernet/ti/am65-cpsw-ethtool.c:755)
>>>               drivers/net/ethernet/ti/am65-cpsw-ethtool.o:(am65_cpsw_set_mm) in archive vmlinux.a

ld.lld: error: undefined symbol: am65_cpsw_iet_commit_preemptible_tcs
>>> referenced by am65-cpsw-ethtool.c:876 (drivers/net/ethernet/ti/am65-cpsw-ethtool.c:876)
>>>               drivers/net/ethernet/ti/am65-cpsw-ethtool.o:(am65_cpsw_set_mm) in archive vmlinux.a

cat $KBUILD_OUTPUT/.config | grep AM65
CONFIG_TI_K3_AM65_CPSW_NUSS=y
# CONFIG_TI_K3_AM65_CPSW_SWITCHDEV is not set
# CONFIG_TI_K3_AM65_CPTS is not set
CONFIG_MMC_SDHCI_AM654=y
CONFIG_PHY_AM654_SERDES=m

am65-cpsw-qos.c is built only if CONFIG_TI_AM65_CPSW_TAS is enabled, yet am65-cpsw-ethtool.c,
built by CONFIG_TI_K3_AM65_CPSW_NUSS, depends on it.

