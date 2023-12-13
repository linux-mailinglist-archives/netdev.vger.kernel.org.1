Return-Path: <netdev+bounces-56868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD63B8110D5
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 13:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7A21F212E8
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 12:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41F628E09;
	Wed, 13 Dec 2023 12:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DXUmSPSU"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A33AD5
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 04:15:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ee1FOyhHOaUQu/EOEpdkisTOaRWreXEiPvhbdXn1L5U1NHdo3o8PlB3CrDCGoj2bCVsx9IntybleLnvMT0VZs8s8mJaVxNbnJIDLnqe938S1KUiY59U1o8E+PXBYcTgiw17C/wa6+qaaM+Z4Hx8576rwO0tXm0zV640kqiBNsMsmWxMzKjXZMKvJlf0xArh/kSpY6JaIoS1Q7vYwZg7RdSvUUWWOVQWf4/mTcfAvwZUlnFHSmz/OM3wVCvdfgvnmDZ7kiIV6cHe3KpjeR6ck0gWu6E8oosP9NP7hYo8OwmQMRTx8B7nPWqVKIp6bel+yhBQwObibaEtINsA366FwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDogeUIRi9EZaSlWJMHVs0AQuhh8PfHgnNja3tZYgfs=;
 b=SjikAPt4RY1Y4IUiwakx+7dX7jdOyLwy8OQZs8rim0dMA51CNKFcaQGN00GvfvCgJf9934t4oVqSJ6cp21UySWvQqut2aye3kmmjHyfj5Ofx8hsctlW+RAQmpBOfGk/p9jAVg26n9pg77tKfW5hZ9IZYhTMS3kzL7yPFoGGHEFGmaKJTj+xvQXDJTCwxUvrvRGWuUdhUKW1UXW2/fja8bgCYZ+HmVa37zVTf6HV/y8UNYoYRmHf/fyAWZUs9RsVTjwQyaQP86ZEsJxlI5UqdCPARttm6Tms3ziVNQ5YlDJuPAd2FQX3gBKMcKz+/Pbp6sm/xDYzIgR9napG5QM++Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDogeUIRi9EZaSlWJMHVs0AQuhh8PfHgnNja3tZYgfs=;
 b=DXUmSPSUNPXBpIkNOO2w9QX4WjnlQLlsv9Bou26Kb5Ju+9b+iq/pyaQc7ZrRQEjw7xAh0k4HcPp0eV0GsFovA6+LlqvdBIGS51Kp+PcGAwqJASvPi/HNqlbprg5NqDvZ22/xy0+SMcb4fRpIn3FHhJUE/Ivw1bRE7qvWgN+YVmg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 12:15:40 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 12:15:40 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH net-next v2 1/8] dpaa2-switch: set interface MAC address only on endpoint change
Date: Wed, 13 Dec 2023 14:14:04 +0200
Message-Id: <20231213121411.3091597-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
References: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0106.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::47) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1a1295-80a4-45f0-9eaa-08dbfbd538f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U2YYzLlBq4Ug/Jiuodj0f8DSHXqDvdOQTvfrpsUEUBDBtsYFhMkxoM7jDPXM33ja/uzmZ1/Wg0qsjjLzEvR2SkWAn9Xlc9IK06IHU0ELnFbDJLL3F8AQ2y340TJaWISPq6rhzAu55MRZV0jfex9PN+zjzyJPtNKnbe1pW6Li6MjmJ3X0hELqMqymFtfVKu9yKLXOo4nR6/st4qi2GANuFCe8Ny1ZV4mwd4iksPJjPavvyF3IhAjHeEqtPjSsZZ5DaVjzpSUPHsjQgOvEqYz8PLFRFHU2uprufbtb6SYAJAUwYiWbEzcImy6kuT7t2TW9LgTJA+HMj4q1dL9f+1l/Ql0+vNPVd2ZVspK5VB4klTeOLQLP24w0m0vSpdARZq9xCuBZnG4sJx7QphNkEyR2q4OmVyo2x7JgGx5pBq+3DU5kfSvSlDuXiSeIYAKdHgCvWmaS/LZ/LPCnEs1aOVIPaL7ZxntA2QwDgB7SKdf67E9oZYsdzm5cNy73k25E8ESeQxFKxhule7DWtw55l/ORbuflTIiS7tOi8HPv+Rdh9cB37TO4skKkefhwlq1IqLvr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(2616005)(1076003)(86362001)(83380400001)(6666004)(6506007)(6512007)(66946007)(6486002)(44832011)(478600001)(4326008)(8936002)(8676002)(36756003)(5660300002)(41300700001)(2906002)(38100700002)(66476007)(66556008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ryT3IBe+zI/VCw+w9pdAnYPExXZCS3/at4HQsrB4KX9Cn008/fkVfKXmc2cU?=
 =?us-ascii?Q?Cb0wUpqIoL3ph8V0TGmI8LfodAk5e6KZhJFrh6sxEOFasegBSIajIcq0KLwB?=
 =?us-ascii?Q?gk1SkF4Jw72682msPXogvEdPJsr+mY5GOpY9P7GG2h+Qt6x+bc3GS7b9bw8Y?=
 =?us-ascii?Q?+xJt5xXSYE52GVrMUBrO4ZNmAHAyTfx+mBlYgaKteXi60nl58HWW/c+S8DmZ?=
 =?us-ascii?Q?N7/3M2BRH5ezY73oLaAf+IUPbRhOigpe9cDzAETZ88vbi9FVYO0BnpMxJZoL?=
 =?us-ascii?Q?LfxDeC8UfBEr79h316+MyHZ7AVUa07nktYFpmfymVXfJ1s/WcpJBLi7Ajxsc?=
 =?us-ascii?Q?nkLdPYoVgPTxYEb4gDxg3vJceJ3ZzBxYC6K02Grz1bjQtBmuC0U8OL7+wKSd?=
 =?us-ascii?Q?rPOp3pIeG4s1SLz6V2rgcHlQHhPLV5VuJO9v5lSVR6YaZ1foUdPUi8jxiHgG?=
 =?us-ascii?Q?O/2jN8pPmH7+PjCVxpSw9qyxUhX1T4Su+EqWctDcgGHLCSKzPxd8fXc0zYPA?=
 =?us-ascii?Q?3VLBtT6Ziw0IipypxBfYyUOPiXDSRYMN608evFl3UUxfZej6cg+j3L57kePo?=
 =?us-ascii?Q?Awq/16IhHDW6MEYoNA6H6nrRnCe1p0GMxiojeZ6Of3a3w2lq9J3AWkqh+BuI?=
 =?us-ascii?Q?YpdJd16cI+sYa/Zh/REBJX8zhLnnhCyZLKqR7mD11mOkDEohLFlmvJelFMm4?=
 =?us-ascii?Q?hmRqdpg4YfcvudTqaoAP1vIosVPKZe2c6W8Ybld4p4q9jvPINR1OA8qyZ+GD?=
 =?us-ascii?Q?HpJuj6SDYYMxJomc1Un/vtUBpX0kA74q1YUhHiTfMOaePq+tfoOzM9szWkZE?=
 =?us-ascii?Q?5s9Uf1udVy0ROhKJsqk523rR9OcY85J7b2irZhZ3VrxCHgXLNuhnOL13kA8P?=
 =?us-ascii?Q?TEfIpOwZehcyPBm3zzmQHTCBMiUTUwY79YgA8xBhPccEg1QglTqEvoNndPtT?=
 =?us-ascii?Q?kQHHZjPrPyPB9NaPA9Akz8qVz0cyynOfG9BaXcQ68IwCjPrlMk/ut0HPElcD?=
 =?us-ascii?Q?fRG/VpMz4dGriD94JHhTliQXbEi7WqJ1jjOLj+01VbW2jlWdcH85pZEP8yrf?=
 =?us-ascii?Q?RJHOr7lQqOUp0kSTB/5p1hjB5CYayix0FMsshgeY4jx+/tm/sp3tUlGb0l+p?=
 =?us-ascii?Q?tFBqIlUmseja8yUzwpFr18OAnRN5sCPc4gN2Y2MM/TDPSONKug8AMfqb5B5o?=
 =?us-ascii?Q?QqefSrrdfnLA1IKvqMKLGPLcTsxPOFaKfu8irkD8NXaOoYspjqAZnZp5K8t8?=
 =?us-ascii?Q?/1FNz7phm1aCVViHdY5WW6zr+o5N9hX8vCN+cjUllpgyQwGhVuir8aqtoo4t?=
 =?us-ascii?Q?4/sy+m8Spg6MsRg/yijVRG8juVZnpe/bYxOjGFBPQcT5GCiu1R4vPQ5aD6Wr?=
 =?us-ascii?Q?NFpvzAjI8iSA3DjuX1sz7+5QsJ7l2B1CTrBysxLxYcXnrjtxIPwNj6ZDLipx?=
 =?us-ascii?Q?i4S/tG8Vh3Ecimcy0IZP8pqfxxnwbnE+5aOKTVDR67U+e5AccsGGp3Cq5ufA?=
 =?us-ascii?Q?w5ngLlSw9wEGIEizXcvyNKcreRT3oHAWCBgYyY+6Sj/Xxq9OKwKK7KuhhQpF?=
 =?us-ascii?Q?vRxn+30IsGooMPgIC6N99MmpN9QTky89bz+qvrCG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1a1295-80a4-45f0-9eaa-08dbfbd538f8
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 12:15:40.6859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ehFwjf+eo9E/kzSxGkTjjX9ldcVNCW7cp4cnUELWBDn9vohCjme0bbVmeqB8wbtE0Q2v9QzwLBn1u+0QKBPyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894

There is no point in updating the MAC address of a switch interface each
time the link state changes, this only needs to happen in case the
endpoint changes (the switch interface is [dis]connected from/to a MAC).

Just move the call to dpaa2_switch_port_set_mac_addr() under
DPSW_IRQ_EVENT_ENDPOINT_CHANGED.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- none

 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 97d3151076d5..08a4d64c1c7d 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1523,12 +1523,11 @@ static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
 	if_id = (status & 0xFFFF0000) >> 16;
 	port_priv = ethsw->ports[if_id];
 
-	if (status & DPSW_IRQ_EVENT_LINK_CHANGED) {
+	if (status & DPSW_IRQ_EVENT_LINK_CHANGED)
 		dpaa2_switch_port_link_state_update(port_priv->netdev);
-		dpaa2_switch_port_set_mac_addr(port_priv);
-	}
 
 	if (status & DPSW_IRQ_EVENT_ENDPOINT_CHANGED) {
+		dpaa2_switch_port_set_mac_addr(port_priv);
 		/* We can avoid locking because the "endpoint changed" IRQ
 		 * handler is the only one who changes priv->mac at runtime,
 		 * so we are not racing with anyone.
-- 
2.34.1


