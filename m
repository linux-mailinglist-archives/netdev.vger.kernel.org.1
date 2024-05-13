Return-Path: <netdev+bounces-95836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3C98C39EC
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 03:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8129A1C20C61
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 01:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7710111AD;
	Mon, 13 May 2024 01:45:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D834112E61;
	Mon, 13 May 2024 01:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715564704; cv=fail; b=TIokSi/ZnW4780BLkZfd1QVxxRMAk/2YdIr9vwm1JlFM2XG15rEz+adkApw5bLU9EHlmo2ZDFhEgHTGulU2pczzM3mpn1G70Xo4MTI2KD2XIaezZ63wGB9h1hGD1u6ACbjW70OKaDDp6UF0TtbNHEuVgcJXjz7CZQHTDAefWvcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715564704; c=relaxed/simple;
	bh=9kQp7chxLku0YoBb/yihbp5JOCkwg1Bpql0C3Lgsmks=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dVT/liIsfKfKa+M5pEWA3/oga6RnBI2xbnZG0gXWk3cMU+MmKTCNFfL2UEXeCRZOhEOU/wkaGzeQ1YQjza5VWX/hMAmTnXRaEId9pYNGM4s9/VO0uC3rOGsoWo2vTw83YrMg3ywcTKK9rdp416O8WpHgcjRfkoPerJslWO739Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44D1WFjw018312;
	Mon, 13 May 2024 01:44:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3y1yc498vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 01:44:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gT81RaqPz40I3uC+P0O9NRT51V5IeeWqC2nvc4mCR2XC2Jg9HV2SonIBWHrQzYWlbYg+zIT/KB9axAaoFbfDzbj+3LysRnVaec76vRj0PHdU188Dcn7TM2I5MBFjZLcMPK5+/c1Utbv6xFj2anwBEZNC9IbF0/0OZ5cRStgQ+ahyCI8ef2pS/fsxurFHJhrNb4xdue7Mnq7lVGhmV8aKrXmR0qfPnEc0d1A5z0WQbZoFrFIf+O18ZQFXyns+8FgagF95d4/v0jVLvRNWH85DW5y8OfmziOsTYWlB3fFAML6+drDWrmp/2zhnQ9X+NkvejWYphP0oAzDYeH6/bhYF2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7U/FU454mXXiGUGE8gRICRpl58C/COVgoQ6mkFGN+ac=;
 b=EOhFdcLR+lsntMJf8X6PmfYF1pmbuKEBtSzHNvRwCIh2ByicAeplqIw3RpIUqA2KHRVXaJuBenAD+SPnxqgGXbNo4S2mRY0iWd+TiP7MWtMHMK5lh48NlK+66/E5+FJJCgErv62QvFEn+S7wfLgdrvfhvaGOPgNW9dXSj4eqYRBqaoyF2DDX5rl5I5dRpmF6QX2V1Y/dPQRZQjbSdrt8tnzFTVO3NOrL9ArKbqxG1lVl9KtsBwufVZKh9b0Q7ts2v6dLxQhFwp+H/EL5zr2hFi71gpchDLxCPH78nO2riQTDdpJQQLqllF7J0koC7jWARRGQssgr+ZW7PJJI8KT5PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5769.namprd11.prod.outlook.com (2603:10b6:a03:420::8)
 by PH7PR11MB7477.namprd11.prod.outlook.com (2603:10b6:510:279::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 01:44:05 +0000
Received: from SJ0PR11MB5769.namprd11.prod.outlook.com
 ([fe80::4ebe:8375:ccb:b4ad]) by SJ0PR11MB5769.namprd11.prod.outlook.com
 ([fe80::4ebe:8375:ccb:b4ad%5]) with mapi id 15.20.7544.046; Mon, 13 May 2024
 01:44:05 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
        bartosz.golaszewski@linaro.org, horms@kernel.org,
        rohan.g.thomas@intel.com, rmk+kernel@armlinux.org.uk,
        fancer.lancer@gmail.com, ahalaney@redhat.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [net/net-next PATCH v6 0/2] Move EST lock and EST structure to struct stmmac_priv 
Date: Mon, 13 May 2024 09:43:44 +0800
Message-Id: <20240513014346.1718740-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0189.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::15) To SJ0PR11MB5769.namprd11.prod.outlook.com
 (2603:10b6:a03:420::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5769:EE_|PH7PR11MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: f2cc099c-f71e-4490-34ec-08dc72ee2c75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|376005|366007|7416005|1800799015|52116005|38350700005|921011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?sccdwY8WVyt0Rl7Vds34NSaS+N538G/mT1fuRVQHFpaxfGWViFsjiphsSb2D?=
 =?us-ascii?Q?y09/HuHof+5catpLowe2CWGYJkpJdNV1XCwMNycqxEa0mwC190domO/ZNqFi?=
 =?us-ascii?Q?zLpqcLKMRnleG6jkH2EbsjHLqssq1WyKLxh5WduhPeMWor8Nky3RkLXyPG1s?=
 =?us-ascii?Q?ElNfDp0g72JxqYd7PumJ/IYBanYoHOagtVbeje0cSF75fuXciXHJU1SCtXyR?=
 =?us-ascii?Q?m7K7lAnD3ozJNmEFaxEPm99GYvFiSrnZv/X3vFXsQzUHG9hOygpEAm2Eo4Yc?=
 =?us-ascii?Q?S8SVefJOLQ/l9EJuVB3IA4XmAlX5RdV2Y68d4pfSV0X+zgnLYG0wZrj2G5/L?=
 =?us-ascii?Q?KEe9VmTHmZ7ikZWJSxbsTyOdW+S2K77lR6HpoNqGVqOFUiWM1NmByGEHlbun?=
 =?us-ascii?Q?5zvmOV5qetOyXWcb7CaPyD1u1MaSH5aRoUx3g1syLuDkVYKSaCRCLD/j89iC?=
 =?us-ascii?Q?tiMcuzyHgaU6u5Itu9Cp6qWZqOQDGPaiO5YXIMovjexv5rDzxxCtOVpVmjAy?=
 =?us-ascii?Q?nViIbx9HCDsLlqE9q4XBTcw7ok6gQhcp32x0yDs0QYvQyQ25WrwVyyHa1y9u?=
 =?us-ascii?Q?GBbMwBWhsd5ogDCXPg21jZDabiqmcnLPj7bgnDUcjtJLH4zkVOimv7F8wXtk?=
 =?us-ascii?Q?O2f0myfrybdY5+2ZBJsAuXA9bCEtv5Q1BhvkSrfkbL1MZbfG3RCboY9u657O?=
 =?us-ascii?Q?NynTWXKGpdikZ9EC2UjWC6YvTVOpu8K4PyRUWZEatZtiwhLCEIkCXEC5iCgV?=
 =?us-ascii?Q?ycLX4N0+7hI6BXxaZAwFmUIvRIdoaBcA/+DqQApMIuRi9FQ94+HP6FyxL9Wy?=
 =?us-ascii?Q?ZPoqIAzR2oAC6CS+wYOtRSqKZD3LkjG6leAMC3htpVXByUuDVZ2RuboQmsKy?=
 =?us-ascii?Q?Cfk9uMwJcO/oYtG2dljfes/RWrA6SoEUBQl2vNwxMgitkX+UxXgZKyr+trNn?=
 =?us-ascii?Q?HtEwk6eOW4QBgWT790g9i8WAQLiiSkX304sCBsQ1H9lxjITtf34Epd/xxWei?=
 =?us-ascii?Q?uOWJG9b7a6ZtRhjBt01AUoW2U2voeO+twaaE46VoGU1zBI1DtO0taeZxfxv/?=
 =?us-ascii?Q?yMVZVDHt+1y/Ts3gubzjysqKy4dTdiurzhkIKZx6yeeYwKrpTGGoVOxRtiE7?=
 =?us-ascii?Q?CUk8L3zZPmZwvHqY3MZSH/hlzzlYLWFb+K5sHF4K1OfM9kfFg7L5/svYvJtL?=
 =?us-ascii?Q?9inZNHyTwP72682WmY80LN6zSecJiyj305pOY/dEHivgCs/r+gvV3QuohppE?=
 =?us-ascii?Q?s7/lkPG+J7kXVrwVOrO2zwRlrk899o0Nj/oYaLyHUFFaSFJWJlApJI2BbYmg?=
 =?us-ascii?Q?1H4N9/dF8wWIEAHay/lkEhaLLtxwrrOn1AxebBWqtYhTtAoquHcrHX7jhcGm?=
 =?us-ascii?Q?FYMDZA4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(52116005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2+BSDQaRoViGquNXhOJrvgDrl/KqvLTK12c0Tt37vF+FK2CsRDsPH59Cihmu?=
 =?us-ascii?Q?4XiRc4Hy4BqHZIkS37vuHWU4tgBgLhWQqArr+7sW25KKWg4/mD9j1LmBU/q0?=
 =?us-ascii?Q?5UzT5BMb0wx+2Wba/7ELRpF9+s3vN+Gof/fZSakhagwxDXhwNaZw/fhd/41q?=
 =?us-ascii?Q?Z61zGzqB7+nbWhh61DAyEOv2cwo92JQXZ8GEHUPzBI6c4FmyqlLmNwCyashn?=
 =?us-ascii?Q?eb8ka+Hd8MIT+YWSixz/Xpnz/X2DeLZMgUJeyXRWP81JggLdQqiEkL1paWs3?=
 =?us-ascii?Q?apK+zzGMr32D+80dVrg8MBZ6528X6w8G2DKAcC2IJTaV5y3lKjRl+Nd3j3z4?=
 =?us-ascii?Q?tIT5FcJNXAhqtpil9Ol7EeU4UlmgeG32rgL3eG4nce/k1yo5HkUuv0YPQ1OP?=
 =?us-ascii?Q?rPLBaMw+dRaMW41jRODN8JbQVHYrV8hsBN2G886z40GSErGgefDd3gpxYZOr?=
 =?us-ascii?Q?HEX6yVxSSzsfKqcwKMhbE6QtzV4WaSPMNRbO9a/9oZnzr/7FM8rDpCQnpnZF?=
 =?us-ascii?Q?TWU60WCgxo6jXI+NEomN9uT52d/oFOYvYGENy9VagoKDV7ZvwsKcXw2u77pr?=
 =?us-ascii?Q?Ims/RbFdejYxPmlcogbFMXlRpO4UM90pPNTbkSDisfotY6DqAo8/8+ojFMR/?=
 =?us-ascii?Q?LLIUK/fF47SE9+rK2Y3y1N9tYzkssT33THKRTEUyx+h3Hrx2YcA56gKB0+CC?=
 =?us-ascii?Q?4I+T+xHIpecHfpmcwIhgJhp1XdGZ5DaaHlXhzeuR8kJgEv4Me2IubWlLdkCl?=
 =?us-ascii?Q?ek+ySM0Ra1t6SZ+77NSNFxBHa1OOdJ6uWygq857vdiADmRT35VUG/32i9pCT?=
 =?us-ascii?Q?WXHfxm1wY5JMQctS0hExErqrbkEb1rXEk+eQ5/HmbNLwVho6GaI90YgxHkSO?=
 =?us-ascii?Q?q2dfVi83QFvMp294xkyBTQcIqafa5pALHrgOiGz0TXY65X1E9PWgGNzEBgMb?=
 =?us-ascii?Q?V74u2CXMNSvIA7XnXNO6tOrQuuFLpW6YCfeR1noyt4ZlssPrG6DrToHoxi5N?=
 =?us-ascii?Q?7bduZWbCBa31I6JWYU7ZL7SMF29gDujiwTXdqTVr6fJbTDCCWu6KFx+nYApc?=
 =?us-ascii?Q?3nMYp6Rrwx/dcPmhU5jI3QmSTsl25qiVxhbDG2b/Z4vo96DyjjI/4wv3sZMj?=
 =?us-ascii?Q?b+7zXeTbFHlStjNk/lYby2ylm7dm9n6SRx3bHMxrG/Ivoz+v1GZni7JRe+W3?=
 =?us-ascii?Q?2cvn1xdmgyeBB8XmToGjsr1LP/xiCUBGNTc8sLP0Zz1aGEZFJ/r3aTctNmlT?=
 =?us-ascii?Q?LZcGQoBrVrKWqxsyWbI4rdFNQ9DqaFc7mm38FWB4u4h0IkxnGW4/22h8F2wD?=
 =?us-ascii?Q?xAoCzoQFpU4KcGnxHx1hz4xHS28XhQfgZY5lP3iW9uvjLNm2g4qAiXmklM0x?=
 =?us-ascii?Q?KqNJ9wO3kS8ERqcZPI4zMAQJeD4Wfm2kSvn6fMDHeuKt+mzQHqKcmSbKMTaq?=
 =?us-ascii?Q?GDbIByUYmMDjBxmghYj0XevCm3Xhkfwewa41iPIn2iH5Sc69dsLYjdJk+UUH?=
 =?us-ascii?Q?Svy/R61BW/6BBuIlZyEJdxyNmg0mrC9Xwyz6vFH+Fx6ai6MkT4C5X/g9LFYE?=
 =?us-ascii?Q?K1FFaEL67Q7Cc8UkjjicYtdQ0XAGe1anP5XIPSmyXBzzwSZ4eDuKUttsh2hg?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cc099c-f71e-4490-34ec-08dc72ee2c75
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 01:44:05.5940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3F5Pd0Wss97kfdjuoHRA7+IZuBnD05iAifNJ7iH9B1rYc8E29zI5D2qPX6s8evikTVw7mO+mcCWBR0Zpr3PvEozl22E2lFMbLVIY8jLPUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7477
X-Proofpoint-GUID: -a_5WC4HFM_6J4ePV54uYYaURIM4NtFl
X-Proofpoint-ORIG-GUID: -a_5WC4HFM_6J4ePV54uYYaURIM4NtFl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-12_15,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405130010

1. Pulling the mutex protecting the EST structure out to avoid
    clearing it during reinit/memset of the EST structure,and
    reacquire the mutex lock when doing this initialization.

2. Moving the EST structure to a more logical location

v1 -> v2:
  - move the lock to struct plat_stmmacenet_data
v2 -> v3:
  - Add require the mutex lock for reinitialization
v3 -> v4
  - Move est and est lock to stmmac_priv as suggested by Serge
v4 -> v5
  - Submit it into two patches and add the Fixes tag
v5 -> v6
  - move the stmmac_est structure declaration from
    include/linux/stmmac.h to
    drivers/net/ethernet/stmicro/stmmac/stmmac.h

Xiaolei Wang (2):
  net: stmmac: move the EST lock to struct stmmac_priv
  net: stmmac: move the EST structure to struct stmmac_priv

 drivers/net/ethernet/stmicro/stmmac/stmmac.h  | 17 ++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 18 +++---
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 30 +++++-----
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 58 +++++++++----------
 include/linux/stmmac.h                        | 16 -----
 5 files changed, 70 insertions(+), 69 deletions(-)

-- 
2.25.1


