Return-Path: <netdev+bounces-130698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AE298B389
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 07:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C911288AFA
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 05:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8E81925B6;
	Tue,  1 Oct 2024 05:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="RUqflphP"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7384F881
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 05:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727759447; cv=fail; b=SU3GVUpQcvLQ5FQ/Z80tBmS85tiDeKCCePEL4wb6MXN99x3AiIOyzn47W9ufj8FfWgw+gGK+oh1WBLCpD9MjrtAgfou83aoVCoFdUaGNh1WssixiRJRKwFjWlOkl2rMa9cAg79bgYB8sGQywGgbWD03CiDM27y9fJt5vmnUu3i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727759447; c=relaxed/simple;
	bh=Ns5iCiWHipVo2PoiRk5Q4nLHaLOFVkacDAgoAnechgE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JakMK0gh3Y3YolYgK3BAMWU28V/aPYEWTPlHRTXhUNa7qJYoKl/+6XwskeBGEPW+24cvLpQ9h2hDanR8hAFQkCv9fp51cO7cc30i2l6mCn7Ea1gi+snoKpMBFWNfeHq+MYy3wBeujDDURugy2CYyRAOD9re50XozMzJlWgSi/Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=RUqflphP; arc=fail smtp.client-ip=185.132.181.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
Received: from dispatch1-eu1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B2453341434
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 05:10:43 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03lp2232.outbound.protection.outlook.com [104.47.51.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id D1F2A6C0060;
	Tue,  1 Oct 2024 05:10:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PO+Qd3YK7AGRWlO0tpv8ZEvz8eGDst23DwdXd61yxUuJ9zbV5kTIwYFoEns3SUBOlsngKIGNrS2hCYfGeMYi4QM//z4j30/nPdznpFErWes7J4YE1lZ38ZecOxh26gIDd5GinY+6e7rs1zaXEGf6Y8mG6bgixFlCOE+xlavg8Z4xbn3fr41XjLo8yT83HoC5U60djhdxlEWETwWazQWx0Xspu6kuiZaQSMUefiUTFC5yQB0uo2hTvBRptF0ZoejTeDolWIqnqkhpGgU5xWUDY/M//hLtq6SPpp6mgwtUiCdvE9lBo4F8CbtUW/ojNXUWjySTrepODKDFBcjXQ1QP9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfMQ2UCBhn5RFlVKxxsoVKIAFAI0r7UamUXp3sMB+4A=;
 b=q9Ik7JI/6EEk23xqaq6syQqw9g70wo7WTRSFGtF+i8XXwGgwm7JPKiimv8eW51JOe6XyT60YGgF8xoLFlxLZ638LXD7ddtqBKIT4295tEynAwfUVa+/vAg3ETlxpd9OilXLtuG1s+4d4wZjPGcMd5SPrwwaElztsrxuCLS7hv5YuYyVPdcZCPyWCczN86Z5h/cnBMK43+kOyesqorBX7tj0y79y8WQEoxF+5PYNToMC5uee7Kzn8Z5L2gAwsDklumc9K09WSMDHKq+5U9+O/olldOKuk1eK+jzJXBjpbnVuQ0WC8kJ3jLW1RYwl49L+Sc2zEtvWavUYCuNMNL+DFYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfMQ2UCBhn5RFlVKxxsoVKIAFAI0r7UamUXp3sMB+4A=;
 b=RUqflphPI1bhcNw87S9IfUVdCeW8lgEWhiQBAS+FJO50ZUhdgZkuhjuekeu74Q8XviM51R3X5uGpYferaRwDglTvbnkYrGqxMafGMrFQirhWPV8YNfQ13DksApsNipi6kFduoNmpcKrlJlCiZWItG8cfjg55da69zsli8YhHAJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by VI0PR08MB10425.eurprd08.prod.outlook.com (2603:10a6:800:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.14; Tue, 1 Oct
 2024 05:10:30 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 05:10:30 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next 0/2] Improve neigh_flush_dev performance
Date: Tue,  1 Oct 2024 05:09:55 +0000
Message-ID: <20241001050959.1799151-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0042.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::30)
 To DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|VI0PR08MB10425:EE_
X-MS-Office365-Filtering-Correlation-Id: 84050881-5932-4377-00f9-08dce1d75ebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x0zXhT2f8iBKXGQqy53x4FRjoU48NRMLjuw9PReShle4cEUJm5J0QHRpu+uN?=
 =?us-ascii?Q?yip7brNVYMIE6fFfT54rbE5pCPVnLmogSIcWF0MgnrUBS3E1dyaEdjGYFL9w?=
 =?us-ascii?Q?QbYO43GrJstcfW835o/XSMjXj867y+vZWWN6WFK3zPejZiIP17c42PMAANRF?=
 =?us-ascii?Q?7i1R18R6XrXtewXX0U7fANZlVTjMc2f/nIpVBdD0Yh2AR2ifS14HqyMnF++Y?=
 =?us-ascii?Q?xh1zI/fS2N2uHcuButT+WNQ9d3/cNChvXJv6OTNpVF8qkfoXXHIKkozYaCIW?=
 =?us-ascii?Q?xGTwYxRfrQ2pyyMqOfeNM1EGsn2g7dmM/wbENUw3dwySSfKIeWygT+NJvZiu?=
 =?us-ascii?Q?RMpPZJ+9y4cF2P+CqPvMizAdqNANTdNwvNFUn0/70psfML+Qs2ZFJFlQgkRk?=
 =?us-ascii?Q?aMBIl/CDrmYeencpERtiQbkfa+IIwaq8l5/sx/SEh2tl7diu94eFz1VwcKZw?=
 =?us-ascii?Q?hoEYWyeBy9o8UyvCAZCjAAIlLVLs9Z1XWFFtACMtxABYbizTlTzul6kN2WZ8?=
 =?us-ascii?Q?Hh2BAQB1uHwqYtlk0OHYNlcaK2PulGYH2wvRsTS3kiJ0LFQqm4PBSCnkM6NF?=
 =?us-ascii?Q?47ouqZkSVwrPC6398FGN46bIoHlxFm+482gnQ3nQdvDoa1i73XfdfY/XaByt?=
 =?us-ascii?Q?EwKuJaB6po5WKjf07/Gi2u+kmCQHLT64lCkUZxxi44fWHWWf4YCKPnENsUoB?=
 =?us-ascii?Q?5Ime1SGgCUKT4MPdtgpD67815NbMS0AwxyZd25gGxM6wCBnE+Z10+z3tKuZX?=
 =?us-ascii?Q?zLcTXFY6AHQ+ndy6gjs8hv1AHT7N0/7ZFlFuqeCrgeeUnRruRjRliF+1UWr5?=
 =?us-ascii?Q?ZwI2dN4Vuxsfztq9zjwOnJSNIQPg6lW04YfqaZsr6OEjSAdEleofZIioUIz/?=
 =?us-ascii?Q?bTVxtcbAe2CzUqW3X82XGz29v7NpDblxDonGLpj9SbmHoEXe49QMl7bqklvI?=
 =?us-ascii?Q?XTmW0Nv83qjVocMYkjFTEWk8V9EKFVqEcy0qWC7PD8nUusmITwnaHDwWJEa2?=
 =?us-ascii?Q?s+DEwaXy8VxxigChvVmb+uYmCgXVNFZoNGmb0jbiwso98P3BtIlfsdTwwhEi?=
 =?us-ascii?Q?Ny0j1WPcQK4wtuA62inoP/QclHIi8jumx3udTbnnneeI5BLwn751er5rFoOI?=
 =?us-ascii?Q?r/riS/Vd2P/w10Zrh3qn/PkQSyl04D7UDfC6Awz3LjKSN2h9Vi1mcPmGcW6K?=
 =?us-ascii?Q?Nt5QNESgD/pnhaZN/jDmaAAKlly7JO3owUFuiXTN2Inw1IiPATp4ps9uDOon?=
 =?us-ascii?Q?aQ0GJe5QzqkenQZbLTgHRqRv50p7USHwCH4LYk72L+cpzrHzgowYu4nvRwY7?=
 =?us-ascii?Q?mZSBhBKO1xqswQfq1nAVyKuxje4qIfcH9/314rdZPxaWyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DK3MBEV33uXfBFE4Ymk7lBM9I2IS/O/4YBVBq/q9qu2dBYMPw3x9QqESqU74?=
 =?us-ascii?Q?6ZjPz4C+0JBId1Qg/JmNsIiWiDZRsNBAK6VTBvafLcaM5XG2Qs7QuhEdweLr?=
 =?us-ascii?Q?V2GfVBukX98antvCryYXMdxLDoIPcMqMLj1Vy/0Ii0823BWHBCocwFARXp8Y?=
 =?us-ascii?Q?2sJyn/KFzTqwehPnZ/34JxZkrMFmkua9MHM8nSmp+ohY2bGnCMB9yBuK+Mue?=
 =?us-ascii?Q?N3oPfC3VN45pMupCUvhnYjyH41yrBOKjpPHBirnkT9UrsaTyEXY2XrYS8QP0?=
 =?us-ascii?Q?y0rvfPuqtdswnkJXDR0poW7rjdwFAPTc9sLPoTF7Sa3XbE/bN8kTJMUcDtFC?=
 =?us-ascii?Q?thyVoD9eU2XODT/QaKq5mkADgaQzmbhJEfVDHvH7+uX1/72MM5UlIN1+1Hab?=
 =?us-ascii?Q?p/X1rpVD5Uk6AleMujVOodlXMjP0sTXDWGWYTV6+FxCaa/Yb4oDFIaagBXqq?=
 =?us-ascii?Q?xgZ1TWKobhvBVbP7mP9457pQ69kjmZdBsX2b5MMxz3/A3GV5G6KDQ2OGjg6L?=
 =?us-ascii?Q?6Bpo4hqyY5jF/cLQg0AWgr0xO2Hjek77avVvwR5L9kcgpkLIyqKSqJmB7miF?=
 =?us-ascii?Q?ZYUnU+lSMhK/CfTkNwFr+2PGlMSGwfdoOc5q1Sar84p3lnLjScreHB6M4rME?=
 =?us-ascii?Q?ZDeICGBCW8M90vsNG3cuIHUSsTh0kWcYV01AiyeXnWQ9s38+Is//jpKtfqGu?=
 =?us-ascii?Q?OMMI+xy8ErkPPQ09lI39ypzq+5c/rZIZw0n7yRo/03uZnAAhoFYtwktj+BZ7?=
 =?us-ascii?Q?UfEHHUG7TA4AHu8mAh/oiUBfWQbG7KNluazMt9I6RSJfxSjqFZHIau+5StMn?=
 =?us-ascii?Q?5LV352Jg0wjKaFTAe99hIszlbA7FZqqzX8N3Ge6txyd9PXQNEbKdsPE10hKd?=
 =?us-ascii?Q?wmw/JOnY5ju4eZcgDxpSDH84aZDvJniqG5w/68ozFuSb5YL13PNDeYNFtLcA?=
 =?us-ascii?Q?Qpl7OvMQ+XsljvZBVTnv3rqn/ZxU9bW+IiTVgrRhF/RyolAamTajYJFuTu77?=
 =?us-ascii?Q?ymsuIny3mML05jXrVjR151NY6nFr6RAt7Vnu9zgWr4RaiKZRj0wZEsE+Ebl7?=
 =?us-ascii?Q?7EgmSGEon7dferNFaqd02FE3NdukTmm73UGQJy9xwycJ5SA0EQDrSVB7+I6j?=
 =?us-ascii?Q?U/nBx3LcYexSU9u/rqorLDjfzfxzjoFhDFvQCyMpTMXQgjdFnM/sMmx33SPk?=
 =?us-ascii?Q?/drBy+ys3aND65zdzckUn+2iDC7WZ+vRhWNflNb1Vj/86FljowXDuoO81YHH?=
 =?us-ascii?Q?8DTRNn//QHKeGpGk6Ljd34Es+iTgxjap+PTrX3BWRKOnysXmcbEjkveSJeDe?=
 =?us-ascii?Q?RSnMnGAPTZuS6tWke3Pe1Du13nXm7mcbQ7rM0xC51Zj+KkFsLKyTTDtu+Jse?=
 =?us-ascii?Q?21uFiK/dSvpHT4cbi1acqHD5N5leJBsBexbK3DyRM7Vbh/LaBLbbfjSAab8w?=
 =?us-ascii?Q?s3k2QjHJv7HAuhf+7DTjOXn+w0CGxk5xwXvszmnloKxDYNExM99amxZvZ30N?=
 =?us-ascii?Q?/5gesoQO/d5Od4WOj6Ui+5j2Gs0OKRggrOHTVbqDU2mJQKwZI/gvB1iJAGOP?=
 =?us-ascii?Q?RCROcBgmmhQ+yx8bzkYh5/JlckfBOzVEXSnLvOG1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EUrEnv73cOV1zuW0j/LCm5iQkqRqUb6gpjkXtwa88aWHF1vxwudnoUkWKjU5ojes/2aJ1XXiAnPLOhZchIBRLxseXuwGXApA8vbzvy6nIGvCXhZVc442SQ13VfBXaolaCHLGMc3AEUkMNFKq6O1LOytJAQb+MHQ76e/KzLZqCnGcZvKBy8zFD6JIMb5yhIXoq7iot/uRjilqW/KUCkPTHTn7FFyS5uPOoQP4t2UGgxR+NgynoMZ1cs9tFzsR9M3mu219l8WsQVzuDbEudIHqXA32+yOs6K/X+a0jToz+dFQQHIwMTbzQ685d74HLRMq2Nu6huQpkH40nT04gg+5M++20zrjuCUOZLGtNtKBDk/fuQBf90lYI+xgMyyx83wxazicB2PySJrqZaNtA2+/OVS2O2ljjbwMnexBL1g0CNyuVId77DdtbIteKAwok62K2dj1xusGgw4c8jDmALIJnxBF3AiGZ9c+k8ryEVEGsbgnGf0LiJFntutv5TVGLRaewKBpeIrbM9AXGUX+VKCatbsc7/JLxdzBTp7h0QXLEwPas539KbD4Wi6GTA+g39YvU17hP9O5YUt36kU8TALPhwkDrNDsmmWeA9ayuGrul0gkdafBA62A6PvzPBZj7yfl3
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84050881-5932-4377-00f9-08dce1d75ebb
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 05:10:30.4886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bY9SnU/+x9cB73zrvU9ALHhcUWSPgaDm9uJSIeN671wj7xWkobsclmnQJFUZv1RbkJ1IKm1hBQUEbXqXkLw45w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10425
X-MDID: 1727759435-eRY4FlHCkN0b
X-MDID-O:
 eu1;fra;1727759435;eRY4FlHCkN0b;<gnaaman@drivenets.com>;18cd01b0b368a0fec4275fdb61cf0c87

This patchsets improves the performance of neigh_flush_dev.

Currently, the only way to implement it requires traversing
all neighbours known to the kernel, across all network-namespaces.

This means that some flows are slowed down as a function of neighbour-scale,
even if the specific link they're handling has little to no neighbours.

In order to solve this, this patchset adds a netdev->neighbours list,
as well as making the original linked-list doubly-, so that it is
possible to unlink neighbours without traversing the hash-bucket to
obtain the previous neighbour.

The original use-case we encountered was mass-deletion of links (12K
VLANs) while there are 50K ARPs and 50K NDPs in the system; though the
slowdowns would also appear when the links are set down.


Gilad Naaman (2):
  Convert neighbour-table to use hlist
  Create netdev->neighbour association

 .../networking/net_cachelines/net_device.rst  |   1 +
 include/linux/netdevice.h                     |   3 +
 include/net/neighbour.h                       |  18 +-
 include/net/neighbour_tables.h                |  13 ++
 net/core/neighbour.c                          | 221 +++++++++---------
 5 files changed, 138 insertions(+), 118 deletions(-)
 create mode 100644 include/net/neighbour_tables.h

-- 
2.46.0


