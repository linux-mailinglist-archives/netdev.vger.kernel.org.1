Return-Path: <netdev+bounces-56872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB0C8110DA
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 13:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628FD1C20E4D
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 12:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C411028E0F;
	Wed, 13 Dec 2023 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SMjoDvJa"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6476CEA
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 04:15:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4KFeOKm8NQ6CB03B2SclEwpHPvMzxTqKBTRB+BcBA2qDoDN3Ov1V4zsAyu67zHmGyZVhVbje+cUAz1FAi0wHjY6JW/WUewRFWG3CW0oy1ah2E619qQyL6OjyP05/VE/ZlfgVs8YzQ3UWHZ0pM8G2ezka2rhruIn5XYwxwZZKPPT6YP6IG1Z8z7ihvCeJJcJXCYC0UaT6hRi4siRmG0+tU+iohwX/sSHHLtEzlJCjCWIn0c2hTPCeqQGuRJZcW7hM6SaHlIx4Q0Tfg6wAk4YKKJOePCIQxCtsWDMa3rTOOA1VUxKfiIRAz5eBcIZt+Sdi1OTxz/Uac2YJTUXjb9Pyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pblnng4JDMhImAMffgV4XBnZaVXqkC8eoMQLbNPb+qc=;
 b=l9G3nTyP390u+cOcaso/wZQDhvYm2NJNybhb9EZ51t5FKyc+mGnEMUerOBYogN/11pj6MeR08q/qvXSWjTI7BPefFtkNVdxktvWVJkeDn7OGhEyIVoz3JrQnjtsMHbNpN89QVfxH17tEhjaq8AGKqWDGXW9g/kpsrSoe0QtAYFL0d6WBIOiw2Lhhii3Yk2boHQwkEhjCmIlZS3zuw1JxytVbrdgLrTN9yyKNbhrqQ+eQCtv4+MgJIBgLKoHasbSlMeIhnNPIUvX02y75YjR6k1uq2SzhMwF/QzQr2zqayWi8O/+Fdqg6Q6BpDzq63+TYkqLOJqDAN8KCsw6ODdhjWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pblnng4JDMhImAMffgV4XBnZaVXqkC8eoMQLbNPb+qc=;
 b=SMjoDvJa1FVhpvvEMcmPzIkLPdtDcG0K/6jIYX17mpBx4AZODQG/0YhPcu2hcu2zX7s7oZBJ8nJAnFmAb/L4oOkDPCJ2C0sm3EnVXPxgCOhLgg0ILsBGvI6FPj9uZROfEn+aXdCdRgtbDp4QJ+wZOvCCvlehy4QgxuJjER2Btgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 12:15:48 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 12:15:48 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH net-next v2 5/8] dpaa2-switch: do not clear any interrupts automatically
Date: Wed, 13 Dec 2023 14:14:08 +0200
Message-Id: <20231213121411.3091597-6-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
References: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0068.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::23) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a1a69b6-f22e-493f-5346-08dbfbd53ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vwE4l0WJkSwgh5oAuiCiMIlxNDI3uJWpEs4YUIybFkybgg5fXqa3C0yx98PUzRyhdrQ+Ro+YNCawWVzJQy2Pa7BALmzz5WFiOms/EII24v0h6SGdQN6CFzHcKFn3pp1cuy6v1kELBcWjY/hYheEOKAZn2CQxzbpkwebJaEE/0kkqSOdubyyenjUZa0PK7MAvgnxYoTcQGfI1/XkgOCcaCgoYH3dmxJt3ccoVTKeAnfSzxmYDS51c1Ei82hV3dnj+fVJPlwnuSTOLvzDyAW6IVvcsdFLG/1mHylMi6qqMFiuRV6h969H2PrhNa0De4kqIqQYVDDeLvHJNL247Cfg2o8Z4CYIlMqPIyT/Trgq2CKTKXhmVxRhVXnjftoevCC+UJY5gKqg3EQl/m3btrK2gOkoPveBJ8XCXQKINpVwRhO7Jvr+s4JB6L/sX0VDWPeKrSqPeEgMp2D+c9IaRo62G5NtRluA6Q59bJzgv5lhtZ1k7K0bAdcspd4KPjeE0PsAc3g2Vvx5x9NKyWAefZ1oLrC37h9nVRgUl2IWOulg75FUwK2/Qb5gJEBB1D+5e1a6K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(2616005)(1076003)(86362001)(83380400001)(6666004)(6506007)(6512007)(66946007)(6486002)(44832011)(478600001)(4326008)(8936002)(8676002)(36756003)(5660300002)(41300700001)(2906002)(38100700002)(66476007)(66556008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mEHwTfXD9aO9RNaZEmzcswGwpauDet+WZdCw0IDCTBeXD0WU3W8a8EPQWpow?=
 =?us-ascii?Q?wdTzvFKV537N3dUHYt9CIKg0qUzh2sF9DvZ0kM5mNED12MV/buLA/1UHuymu?=
 =?us-ascii?Q?unuKgIKGMOIHD4WZkW278ZBiiFNlI/NzxOmPyKgD3SCtwqyExv8IK0cC7+Sr?=
 =?us-ascii?Q?07tL1WIBI/CsqUGaQdCA1pvUFVeBhANkmVY1ah6gTB622MOtgHJE1ZkBuJM4?=
 =?us-ascii?Q?0/ud3d0i8GgHP5vcbQ6LPkMVGZn9TOOZa5Q8NUkY5rdK6aJAwTmIdiFCWKl5?=
 =?us-ascii?Q?BigBASt9WYzrmSvt5sq0GehAm1HBeaXZ1AfYUobxhB1RizDhP6wi7nT0Lazg?=
 =?us-ascii?Q?97KVgh9+LsOwqwEFplwopt1MgLtD5VYFZecoVb7CDdrujN0wP7eruXaJGYTm?=
 =?us-ascii?Q?xJ5FIgR/pYyvIBnS2BdnMrPKfmjNuFICKDamW23gWZmmFA7ZY31XoQ3+0hAH?=
 =?us-ascii?Q?q3j4rEBHrU46BQeKjFbNEfJ/eY5x5kjfPc5Kfai7NxtUyTCBTi/eY9YmXcJZ?=
 =?us-ascii?Q?SaYfU+0XKyc5EYakJWdD8UjiJTtwF4wYlTBi457/JEL4lJOzLVNakHfhv0O7?=
 =?us-ascii?Q?ovEjadDGu/E9O8ldf0issHSxpCQId7LxLpB2JEN6zvsc5hy/eBcPq23BiV0J?=
 =?us-ascii?Q?XJ6geaT9KR4h0/q9sdY3myYF1sHsroGFvYDQNu2uXh6LoBfkT7V4xsMd8uqw?=
 =?us-ascii?Q?plIluP+TqgJ0Qy8zTQ6ebU9F0fi+NFxY/UVpChifEOJJ+y8swxV+FqpxjwDZ?=
 =?us-ascii?Q?ExpZ+YPLfvhc/QrO/EvoGZj14liRl9T8k3fjS3eK8I5NDBVhI4Rb+A/3JGxL?=
 =?us-ascii?Q?rPqwJJXn9dc6xB2qC25WRr2HIco96KCVT+iXST7mMtRRLlXdp7DMDVRbeZ4j?=
 =?us-ascii?Q?xbM22Ub26I+dgN5vbDFUQVbw4lBiAXrNcSVqlXFPYSEK64jmzfBdgmFncBSh?=
 =?us-ascii?Q?4+VKIub5mWpfFB+Jd+GT4gp5Th7G9iEszcGgeBs+XrFtklFrDR/h4QAlVI+D?=
 =?us-ascii?Q?LuVu80dGSa9Fag7gG242imXKYL9bq3CW0EK0yrcQBHj+UB0lbZd8gzi7ywi3?=
 =?us-ascii?Q?5KRu8W2XOj7YlatBy1CxOUjvbJEZOaLvCMsRw/gRA+JXy0s1UmJdmb5YZ0+y?=
 =?us-ascii?Q?HydOjsIVzFabt+Lgl2P/nE4RrWwY0NmT4pPMWR9tm2Klur7vNdXybNpLp7+l?=
 =?us-ascii?Q?/FopuEdFrnbHzYhyUgaKNfwnxKHlfamIQEZ1fhjMQobeWEV9+ITjFn795lH4?=
 =?us-ascii?Q?De4rqUoHDPbjtaFeThaUN5Ab0UgcBuPDGPnHBd5lljEZYIWqijtbANqUsAcX?=
 =?us-ascii?Q?30in7Xu/ErZ6kN253NmxhfgnH7uDWparMeg9I7YtnYiRK9PdFtpDd7mbQ/jA?=
 =?us-ascii?Q?UWzkr/Rc+jaTC7jjFyLaIECv+e5jcxTn2H1NTcilxnwXgyyDrjCbGzSzP/IV?=
 =?us-ascii?Q?GSiZMiznJQylLOCy4EWIQoEwagT9wA1SydfBVzinjBJ12AshetHwgD8dNMQe?=
 =?us-ascii?Q?Es81ErVSYcqItuHCQ86CRgWRhb9Ya4M3Wi/+02HCpbY8RWzgAe5WvAjgGv0D?=
 =?us-ascii?Q?cNJ+utDDuGfKoIOObmPBTAL9xSFdV7lUhekQx7pv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1a69b6-f22e-493f-5346-08dbfbd53ddc
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 12:15:48.8657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NqY+X8C8M5pUfohWM3FyrAtf2UJPkpeKWr52AIiDm4G5jQK4x0g+kcn/5zktA276yTBgeN0giaFccdiL9MyUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894

The DPSW object has multiple event sources multiplexed over the same
IRQ. The driver has the capability to configure only some of these
events to trigger the IRQ.

The dpsw_get_irq_status() can clear events automatically based on the
value stored in the 'status' variable passed to it. We don't want that
to happen because we could get into a situation when we are clearing
more events than we actually handled.
Just resort to manually clearing the events that we handled.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- add a bit more info in the commit message

 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index e91ade7c7c93..d9906573f71f 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1509,7 +1509,7 @@ static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
 	struct device *dev = (struct device *)arg;
 	struct ethsw_core *ethsw = dev_get_drvdata(dev);
 	struct ethsw_port_priv *port_priv;
-	u32 status = ~0;
+	u32 status = 0;
 	int err, if_id;
 	bool had_mac;
 
@@ -1539,12 +1539,12 @@ static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
 			dpaa2_switch_port_connect_mac(port_priv);
 	}
 
-out:
 	err = dpsw_clear_irq_status(ethsw->mc_io, 0, ethsw->dpsw_handle,
 				    DPSW_IRQ_INDEX_IF, status);
 	if (err)
 		dev_err(dev, "Can't clear irq status (err %d)\n", err);
 
+out:
 	return IRQ_HANDLED;
 }
 
-- 
2.34.1


