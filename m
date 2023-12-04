Return-Path: <netdev+bounces-53505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ABC803657
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 15:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B095AB209B9
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 14:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BC0249ED;
	Mon,  4 Dec 2023 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m0+WDqAN"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2078.outbound.protection.outlook.com [40.107.14.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AA2188
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 06:22:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPswtSWDybsrorTdsMVT3Nge9rUSqrPpDald8CpOkPwJtAnjdULNtQNrPIp96tQfQz8TZw836ObPTUxr5qybH853thL7OTM16uHHIBjZQCN9BWLuu2p/jTptCWGETsiIUYf/EG2MqGdgEZXEmWh3+FNImY+G1atD7jqZ9U5lkbxcMQQx1B81kWe97/kV9Xvu3acXMUPKV0OWfpWCMGFneFs6L1WzYNJKfC+6g0VrJSqllApCXd3kN33YsZFffRwi4ZwL6aA4ezrMdeyfSvC172nOlPb9o6cOo6E/SbN352DSMErvA5NPoEqyg9tbwZj7wvIZYt+6CGPcj1vOVqAyCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9+8Fyar/vbX5JEYOtVvoVUiqhYo2ZcphWK4FpNCBsg=;
 b=lyWRGLZzE7HR+ltNm4j9ECrHC3xfcAYF1LtU7VLUcf8UiAcnbRTRHtWkip43mWkJRsR9U9LNB1RzDCBkq7sP1zLKv2EDKiUit1v4uosV/2qIpAn8pLNfsdJIy7Mm/J2IZcixAgrwHYR3NntKSCYE52SlebRCuk1rUfy/tLXWAVSBt36Zl8PIA5eJwdql/8JYCIbXLqqBA/I5kXlGS0Q1mTV53UQtNyJc0A8FCXGdRckOniACPHMqr0s27XTzrdf5aT0lsHsfwtNHte4dj35w2ucD31uJUA+VJZZsqVSRQxSnILBTZhjwbeJntjPk9TNHmHx2Yu67t9WuPLxK97/KoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9+8Fyar/vbX5JEYOtVvoVUiqhYo2ZcphWK4FpNCBsg=;
 b=m0+WDqANOJXfJzZ4QJB0c0CsyjyOJkXQ1Kd+tCImpH9oHICWw72rUyyhE0PW3L2Kg5g+W4TrJmFF+KtlWFfQAnpvEb21xOPj9Hhbk7OvzH/0/8c3laHnvgjayRqyfVPd62ViIM9jHNQQHC6Hq4NfsfgPIK+uT1tQuF5+93ypNLY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AS5PR04MB10044.eurprd04.prod.outlook.com (2603:10a6:20b:682::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Mon, 4 Dec
 2023 14:22:05 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7068.022; Mon, 4 Dec 2023
 14:22:05 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH net] dpaa2-switch: fix size of the dma_unmap
Date: Mon,  4 Dec 2023 16:21:56 +0200
Message-Id: <20231204142156.1631060-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0113.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::42) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AS5PR04MB10044:EE_
X-MS-Office365-Filtering-Correlation-Id: 018cc788-e446-4a07-7c14-08dbf4d46414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y+6QCWuKfpIqyaocDag98HYKRghdnZP+SqOtQG+a1UHb5PWZP4ruzB4t6+a30nYz2erm4zU2xCcZ50T79glmi/sWyBuVhOhRLwAW8kFsImYCC7PSPsJZ1zG43/No5IVbVmrqy9d85zYpn0ZLLQ3qgIj7KOy9AMrulZgPTHbhh2ZGclzn9sGeY2H14cV2GSX7l37OD+veElrCmZrQCuiTiCZ5TiirEWvUjPSwLGWzC8/e35NLneAS2nNAK9vKyj5EhKflSkAYWOxHPVcnfc3++IBhNhXPMQtU6h1kbCIVp4x7+rZVYv+ENg12ZTNf34stf2YEVzpDnIAzIfz++wB/MC/NyBzlJYdtdwB5275+wSmi0YJw8vCvyCQ6XYZRcD+CIGtrtASUtdRfQRS2GGKAbD1NPRlanqbqzs42F5JU2EVithsFqZUtx1h0TWxivLWY9oilD7LN+KRICjlV7fPTJKy6Opx7THVeeZrof9aKVRDnTHPBdD9b0z/FtPTcCq6pRpTnFTpK6fUSrjoLGTQ4d11jYwlFYDfaZ6WYcEucHS7icWkCoyGYy9PeWThGj4DV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(396003)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66946007)(66476007)(316002)(478600001)(6486002)(41300700001)(6666004)(36756003)(5660300002)(2906002)(8936002)(4326008)(8676002)(86362001)(44832011)(2616005)(83380400001)(38100700002)(26005)(1076003)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?90AlpJj1vMkOtt4roSpYsOtH+8q28yvOHEBiOgmYl8zXTp0NvsZMmMseVLvK?=
 =?us-ascii?Q?hzxmxffc3iPMlwivDN7iFKnWJKf7sONhLScV6NldiNbv1AdoVtscQ/h/4qYY?=
 =?us-ascii?Q?wya2vnK4Z3aIm3dMRQQAnTDZsiFN+heyVHcqa6K76uARI7omvYSUQv/EnCyL?=
 =?us-ascii?Q?/rqtN7zTz61WTUakKkMfJuKVC4sct5VwJjDNB5oABQxaEBVCoLhtL0YuOd/2?=
 =?us-ascii?Q?OdYhyKkAvtv8rL0ik9JZPFx4rC48BSXNr6lpV0sWmVn2VNBfxdFd6qloynNS?=
 =?us-ascii?Q?EmTigUQ4zexCeTL8AZWbYadm9WdRQeLB5j2GN1lGFpPjg63mW26+m4KbL7bd?=
 =?us-ascii?Q?aSKwa7Q40gvvrHnzYWYUKuk3rIzHi2Zy3yDvOUa080mNKNpMAevEMKeT5esj?=
 =?us-ascii?Q?2VxdphMkdc+yA4glDn1v4Zm3PAbvH9RVgs42Osq61VFLLW533JxCP7sqsqBR?=
 =?us-ascii?Q?+Z1BvrNg47DGMMjL2SV7u659fCiN5NXy/wPEnI/6eUdMlZS1ACgiVATTcin1?=
 =?us-ascii?Q?+tvzGCTf6b1Co11YlYsrm4LYIp8H65cD05MWDq6jIPEAxXXNyOowb//Nq7Ph?=
 =?us-ascii?Q?K3VpYckvC9cxCWkMKyWLOR95NAFa07r5xjf6KXwuHsZaftFfxrpP7IjhG5cI?=
 =?us-ascii?Q?kZBzB5L9hhg/na9FisnaXqSl1j9OMaxWbv6XeDEnVl2huvt/HxT0VZ5lySQu?=
 =?us-ascii?Q?HWcZBEAt6FqoLL6v4T3LtcjHn0XocAqjHFiS4w4jRNWQlL4O588D4Zt5LUVi?=
 =?us-ascii?Q?7y68g5Mq3FtbDGZH/ApeakAPJMC7OA5ArwEG9YqYqpHdyFPTQDTQXbYV6cle?=
 =?us-ascii?Q?M4wZmjl7uFGvhvz2d9ts4ws1mSmMKX9hcQra+8petLiUjBavU4ibwx35HI5Y?=
 =?us-ascii?Q?xkHuUOfUdqmUQCmq4OCGkflt6DQodzVM1JE6uU8wcqBOMdL1Y0a7hJvUUSve?=
 =?us-ascii?Q?DW5jtpQZ7bpnJvb7A0fHa+bkIuAJhtrsH4JlisCsjzE445uSIXYqXBpsfSYF?=
 =?us-ascii?Q?zx/dn5RHQ8xgyfD2qnIqDS64DL6og9unLry3UR0wEl/rR460R7+gZoIH3INI?=
 =?us-ascii?Q?K2DFpJCIP17Bob3C2T0bnSgxfUjJzUiR2ddc88RPdM09/CJLBhaJEtn4L7D9?=
 =?us-ascii?Q?lttS3fuxTwcszdq+U5sYpt7F6tWa6qrzRZsKPQi34OQWq4xk90U4S8gr6Ekf?=
 =?us-ascii?Q?IKt1NnssWpLBOToIWy1lJ1OBOZma+vOxplAPfNhuF5d0VhrfXMlXhClnJuac?=
 =?us-ascii?Q?Egedua35+6O500SyJ3VWGPMk9zgOWYqMmU1VxC7ML8WDVn61IJTZ+UMq1X3O?=
 =?us-ascii?Q?CyMRVRsYwRhqXuQyZrsWFbwD98wihqlo2ovpWNWt69mmy4kxWWngn2yyijya?=
 =?us-ascii?Q?7pbsCsYReGcZrjk1nOUPz0WIK7k9lgpX29rHH3DZf2h/vgFYMeEXlRoC7yKt?=
 =?us-ascii?Q?UXBDlXPKLtI8SLNMuQVxCl7QpQrYGwj+8PRz8xE0LchQT3b8OOwa1D0eDgKV?=
 =?us-ascii?Q?iwOwWa3NERTWXec8Icpgy7F3ncvcgWptIoehx3kAU0JVcM60/FHDC5QJuF3d?=
 =?us-ascii?Q?pNGs8HgSIlssJ/nwsfb4aZ1E8q4w+PCbggJidI3w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018cc788-e446-4a07-7c14-08dbf4d46414
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 14:22:05.3944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1OCrRtbqLog7NsZvFMQ9UwiGRlR9fGbpWX7et2alYUPMNY8YV9Ap9sUFz/ZUuIlJVvE/QIRoVci77O4X0L0Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10044

The size of the DMA unmap was wrongly put as a sizeof of a pointer.
Change the value of the DMA unmap to be the actual macro used for the
allocation and the DMA map.

Fixes: 1110318d83e8 ("dpaa2-switch: add tc flower hardware offload on ingress traffic")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
index 4798fb7fe35d..609dfde0a64a 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
@@ -139,7 +139,8 @@ int dpaa2_switch_acl_entry_add(struct dpaa2_switch_filter_block *filter_block,
 	err = dpsw_acl_add_entry(ethsw->mc_io, 0, ethsw->dpsw_handle,
 				 filter_block->acl_id, acl_entry_cfg);
 
-	dma_unmap_single(dev, acl_entry_cfg->key_iova, sizeof(cmd_buff),
+	dma_unmap_single(dev, acl_entry_cfg->key_iova,
+			 DPAA2_ETHSW_PORT_ACL_CMD_BUF_SIZE,
 			 DMA_TO_DEVICE);
 	if (err) {
 		dev_err(dev, "dpsw_acl_add_entry() failed %d\n", err);
-- 
2.25.1


