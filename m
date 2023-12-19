Return-Path: <netdev+bounces-58872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420E68186D2
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 13:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95C62B245D9
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 12:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE41E1642D;
	Tue, 19 Dec 2023 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LONXTg3l"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2060.outbound.protection.outlook.com [40.107.6.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6F2168C5
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APEJpFMEKu5kCUqFf5rqCH4RgiPuJp9uIp+Aa+NQnAZXK2+1KF7oT/My306JG5iR5OBZcg4jD1DYryVVcaxIYN+GjvoiXEosCQtJEI+NA5WiDeJTxZ/UOwFRg7I2S8WtHdCDuymRTE1X3iNvsIKJFuUhCY9muX247YeL9YzfJZiW47C29oJdw8HfRCXzJgDNcyXT2IovKSdwOhRkG/noXnakcjXQL+0xHTi+4Bd18V+eajd+lIZn/NMXFzBQieIYJ6MIoKl9frCw1LES1kid+GkfARRTjhUWwl0vkCpnr/sCzDUbK86xEJEowCdaDKB3cpuNdFR73RLCKqoxZh2Cnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dgF/63d3qSSplgp/EVJW74AB/STl3usbIE/0lTk2ic=;
 b=ESUnQzSOomBAmCGDNgoOhuRoQdhHazDkhuf1JH2hjC9hsIFcaHOmRql6D9POUfrlgYVH7y+/YV5VDM6rG2DAW3FhEDyFibI3w5YS+VHySVHzm/F6nJTMm36IebdnEjDwCg3JofVFAUXL4mn+NxOp92IHkAC053CmDwdkqk/2vMd4iTfz34AF5DgpxIEykHEPe9VA3RoT4iUVVsGG+EJIMXsJM5WwYJ6uR3b7Y07NcK8Nnkp6pmkAEKnTozlkM++MgN5gKw9zHxxi1t4mC/EhF6nA7OES0cEyS2Tg1JKWy5hx1qV/2vc4SzSx2C6M872OHbYnOv8Jg8uDf+lh2iCnNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dgF/63d3qSSplgp/EVJW74AB/STl3usbIE/0lTk2ic=;
 b=LONXTg3l4oLD2vw3s4bxQDTxkH27Y7Szoopb1CTNa1khJKIlOgQx4ojOdu1Ju8yYAyUGzjPbWXBDGdriPnAyoginbPykKkO4+gRrGFPh+Mz4ERTEGvT3YmK9n0sfhQjc1QG+gvHuJNu9uS6RaWW5+VQ7k/R9tqumtiICIO8LdmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AM8PR04MB8033.eurprd04.prod.outlook.com (2603:10a6:20b:234::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 12:00:01 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 11:59:59 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v3 2/8] dpaa2-switch: declare the netdev as IFF_LIVE_ADDR_CHANGE capable
Date: Tue, 19 Dec 2023 13:59:27 +0200
Message-Id: <20231219115933.1480290-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219115933.1480290-1-ioana.ciornei@nxp.com>
References: <20231219115933.1480290-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0004.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::7) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AM8PR04MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: d2334d4a-3ba8-4b66-b655-08dc008a06b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4aDTMlCCLiThqUhFPk5CT2zxo6pAL7cUpZCGeq2fezVHBXlJCWaoWTDUCMsTIz1pTMsY+IZiwMchmaYfvy6zGxuPttr5MYU4DjnQp1WLiEz8kiqV/EGUJd1Yomcl++N+w1PuE3eIxjXsCbxH3B+fdn6jFsFSJDyVvnck/DzxiQoOjGnvMB9lyxxsMdm2VipQ45JbL39wZ6fSE+vlrRkcf4P7mvEC4Im84IR7sbRGfGUXtkjOZISPMyPlgpcR9cQ4sVaOnj7QXsgYzMHUA8l+lBGH4wszFNzF8d4KypSLeZk/7fWwm3MHfuIPJsfE/GDIWDS4G85OEikGqVuwFliW5/pDhbFzTeB63oFi5lTH5ns3LzH68TJq0Y3ZTVDEUZrkHIlOJFVSZu3VZnz0fG8cexcGwu9aRJC2oalafr5S+BxJzXLAOwyVOzQc81Pn6/hKMNDqIjQh/G91ml/zKTJ2Sv86XvyY7Mz1McK1OYJ00EHmYeuyx2HvKcI1xAvB1yhZcGDh2CG2FOsKKKfKh9izFLLlZjGrfx/XIPIe1CalNNaT17PsjUZyIUaqDibxFs2n
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(1076003)(2616005)(26005)(38100700002)(8936002)(8676002)(5660300002)(44832011)(4326008)(41300700001)(4744005)(2906002)(66476007)(6506007)(66946007)(478600001)(6512007)(6486002)(54906003)(66556008)(6666004)(316002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EIq/T8q+2CdV/s1ZE+3HwNbSLKapK60r45VyaVoqHz6AzUaddLVd28CSSd2k?=
 =?us-ascii?Q?Crd9KxheptEPFXWVCINm2SbPEsLZTJe/MKPR8RdfyRU+8ALLvfNoOLoHmVFF?=
 =?us-ascii?Q?C/ToxCIxgjR2ABVLbQcxHETBGQazXDdBqAVUCw60EPX4AhGm3T0fWnLo30jz?=
 =?us-ascii?Q?rh6j6qCtrBlK9MkZPnR4ywqewWKxZG13xHt1TyXRPq4oJFTfCXbTGADG0EET?=
 =?us-ascii?Q?Qpblo3aEECsVKkb+VURcU7/Oaga4qGnzMT7XgPiEBSd8AV3YvFBGn9e8Ox1v?=
 =?us-ascii?Q?Cmd+X+75ayjvpHyheX+hLaI1DJwJBZEFgzk+eGJeknFTGJFqfvONzL2oJK/a?=
 =?us-ascii?Q?q/vl3EuAz1+uE4AqHHuTyGOifYwdo3GA7+Q+g/TuAQIezVlQdDBxhW90FiUE?=
 =?us-ascii?Q?zaHBqXzDiMnBFAHKxHL3nMXlqw03QkyAxSXHsU5A00bFEKLneFjd6mAd2pdZ?=
 =?us-ascii?Q?M3kmQdQmuNAZliQgDj0ZnKobzFGgWPDGR3RA0phdk80aIxmdjqZ1yjAGJOBR?=
 =?us-ascii?Q?1ak5LOnORbrhk9FhOymbxuYgb1/sW3V1E17zbl4il7YgpAAJDL/xriyZhhJt?=
 =?us-ascii?Q?0zbPuts4RSzPnRxlOwlBQXAFIUdsQVXMhKMS5toi/yMWiGKLQmiwKPF1b+Ev?=
 =?us-ascii?Q?Bt4PK/YOt0uC9ykTdhY/MsGIQQlonTaeE4oX38kVHa1DY+59hZ1CTPApOQaw?=
 =?us-ascii?Q?HBtI38kg/UB5MyVSvFkAXFAl+MOSLBQBDdsYGQz/SnL7l1HECuJ/+eNh95XQ?=
 =?us-ascii?Q?AFM+jt1Dw2qYOxKyeGKOE+uJze5aZRbtOO9whk216d0Yb7se6YbPwDLlsLch?=
 =?us-ascii?Q?RmSWJz9W+w/02iFW8NsUf5OgYKRCTvAewnm3QAmOJ6R6OnbKAu2+j4JvccgI?=
 =?us-ascii?Q?6GjupEOrblMHBn3aPlbT6aYIlFlGgf+CBcIY//vi3TWQ3/Adm7t1Dr3kPkHF?=
 =?us-ascii?Q?9cMDFmaan8YrUr7xSL8Ssr/mj1bqRAD1uq5U816Yo2lpoBrar6LqfXGhEMEZ?=
 =?us-ascii?Q?j05F4WXnPkua8fykLwao/529Ms0H95GNiojygEjo0Ry2IeFHyQ/pAzOmB+a3?=
 =?us-ascii?Q?8ZYD7uAlZybns0GMDP5i53qbLrghaYv/1eubyhjfBD7UlVhTuXNL+i+3P1Q4?=
 =?us-ascii?Q?rBn6h6t8PZbT4QZaEMrUhi8Nv749RzpkwtmhWLxsVVn8ontoJ0gbew3vmQRt?=
 =?us-ascii?Q?mnsoT7IlODdvVCLNSaAUfJzwZ+uA2BBxM1/fNaqukanSkHPzznX74lh3gdBn?=
 =?us-ascii?Q?Ymxwl/iQjnl3qgaAn1O69Jwsg0MOkx6pEptwLYESayiL9DBg/Ffm2MOpqQBi?=
 =?us-ascii?Q?5KV+mLjyzcPlCTO3AJc3+zBPpLdWvBERJ+FERXndRPHRJ7j4H4MSROytpgTr?=
 =?us-ascii?Q?E2GjLHJa8UQ5ZnQto8qqNw9+CVfe6XautHodnWThnDe+IjhP2ZCCAS6a1H6E?=
 =?us-ascii?Q?4tARrGSeKMnWwJv8v5zSvoJ2IAZn1olzEHy4iIUm+Lur13NFKwdg9jdVMPIF?=
 =?us-ascii?Q?bccpeh+AlohXPAs4VRYBHcgNT7GPtF9e4Z8z4KUroCw+5zkDzyvDkuOkmj5D?=
 =?us-ascii?Q?rjuPO7Ior1lkP/TyH3CWaDjV7xnH+7E4vo3xBnpy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2334d4a-3ba8-4b66-b655-08dc008a06b0
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 11:59:59.8877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsIslvMYSEgU8yCsyWGvQACa2UDwJVPVgrVd9vGVvVrqUIEcNXUqz+J7UD4wleF889z84S19vTTvrhHxktO+ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8033

There is no restriction around the change of the MAC address on the
switch ports, thus declare the interface netdevs IFF_LIVE_ADDR_CHANGE
capable.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- none
Changes in v2:
- none

 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 811e2cfe6c93..a41d5c7428ab 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -3293,6 +3293,7 @@ static int dpaa2_switch_probe_port(struct ethsw_core *ethsw,
 	port_netdev->features = NETIF_F_HW_VLAN_CTAG_FILTER |
 				NETIF_F_HW_VLAN_STAG_FILTER |
 				NETIF_F_HW_TC;
+	port_netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
 	err = dpaa2_switch_port_init(port_priv, port_idx);
 	if (err)
-- 
2.25.1


