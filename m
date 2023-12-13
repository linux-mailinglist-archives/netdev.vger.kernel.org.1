Return-Path: <netdev+bounces-56968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF78811789
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE33D1C20C9A
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 15:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1CA315A2;
	Wed, 13 Dec 2023 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ud6hlO0H"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2080.outbound.protection.outlook.com [40.107.105.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC9C10D0
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 07:28:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhIuWNsbQFTvBM/0ljZiCa1hs22GirWSt4We5FnFdDmkPA1+NHNuayxR3MyeqPV9X5jHynEMMXhq9wisc0YQiEI+BnRXqimisg2KLg3S1lYsrenXadzz8Aj3AmUYUaEkE7nL2U2ZenHjoXpbN7UzbIBj9QQsDhRgMv0cNXluKeIVXIPI0kp2JoZ+tp6LZIfEit/LbluKpa6mwrxOgMzntLGr5a77Ko0Y2D3BHyz61EFZC5ole6FEcQ3Kr8EKy8YjlHavqRCm8LxcPoM+SgAOhLzKn+RSUWb4edXPdUwXflrqJqGsO/+u+wROWJSBXkAtp+nwayjtMrCR6TuJQLgvBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bQm2v1WTcXy4yM1HiXTuDC44KXNaWK8GjXXu1gAr5Q=;
 b=eddQdKj36griCBSO1aIcFLA7tKVTrqX4xTL5QcthcEauFqHcVO8/QSfnmswAcCP8i+38fYcVRk8qVG+cs4nVfq/SupzY+lx7iLniu50B3J3pRZoQ/5gYRHCjc01nWZ/GwrfJUFh8keJjMYo58tTJiUh4TZI+iLcCCldDsGvSJTwwZhn1GcWSTHq59hASn6H0mUyyCPAZy2S8dAb9wjd9pQT8Lo/hbNbyyMseHeQR1SnTbicTL6QgW9foWtoR8VnBDpitEVGHapaSP1feRnnNOqOka4HGHcq/dNmnmV7hoHXuu88g4lbrzsR4ZNyftuvH7CjD6Fgu1jwBuJ47/Ivs2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bQm2v1WTcXy4yM1HiXTuDC44KXNaWK8GjXXu1gAr5Q=;
 b=Ud6hlO0Hq37YwCzuCrFgrrlbByuCqSoj6+7OO7i73gG4wAf7IOlKqZmknTrrDRSupzphmDapQzEI/UDRRYfpNvNnjrRmSVvoH08sS278reNV7ygdKipGad5kGGAZbGGp8g6Hs62TpCzLVky7ncVjC7VS+uOWQknbG5gFReG2MsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DU0PR04MB9273.eurprd04.prod.outlook.com (2603:10a6:10:354::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 15:27:30 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 15:27:30 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next 1/2] net: mdio-mux: show errors on probe failure
Date: Wed, 13 Dec 2023 17:27:11 +0200
Message-Id: <20231213152712.320842-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213152712.320842-1-vladimir.oltean@nxp.com>
References: <20231213152712.320842-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0015.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::20) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DU0PR04MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: 7226a8be-50ce-4e35-e333-08dbfbf00589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KszFC86LYVrKwFUza3jA5uWuU9UeYBJX6OFFAkl1XXl2AIUAK/+02UaHwo/NNUrBmwbGsb26oXhZfEWIhwPjwhMdCguAxYHPxOMSLvtXd/0/D7BuHWECbQkxANcxARDy7sVW0YA/U1PTIjBlD4AFKDleFPXbmfUS0OEC+bWfS/gwaw9dJ0iG5hCptooTqo0f66NGq45a3kus6lof7/Mpm3IH0FJfbw0w6dhsWlL2dmgFzAlUWqfrNEn4TpEaAy+to9QsfUwd7weMVdsF7DqJN9Bthg4OIrIqGfAbUBtwW6ALum2T2/oCuP9Y617pC9IDxuN0pBpzyY2BoPgBkWT/EfOYm9Joowi2lmCzET2WwiN5JkYV+Ahqb1OrTQDGz5Eeod+L0E0flR4NVqUHfLcoKPjOS/PQdAVN58UWKVTs0tOouPNbAJj0Bfma9nf+aJwmrEJoYluH22/EMYE+uOyli2F1JZqM1SZnxq2ja0tpUR6XIulcmmY7Aer1jgRUKopLCnPfhvpI+y0poJTEhfS6PJUhnItWhigLLpLI0hQehoWU6S2Iw1oU1aODggRyAoFh2J8Iev0bFGGXxhdLzo3j8LRuTgwtCviVP+riSnZZbOJ3H2m41qGmnIVuZW8dL8l2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(5660300002)(2906002)(44832011)(8936002)(4326008)(8676002)(38350700005)(36756003)(41300700001)(86362001)(1076003)(26005)(2616005)(38100700002)(83380400001)(316002)(66946007)(66476007)(66556008)(6916009)(54906003)(6506007)(52116002)(6512007)(478600001)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I2MlEdIHcTVuXFQfotTPPJvz9IPAYccP4rmr0KwCEl8oFmtyIkxPD0IKDB5E?=
 =?us-ascii?Q?MZD2YxDcFUAm44mQfKjtS8ipVTwEIVLSztNCYUlXv3TnnI84jcX9gR7ySH4i?=
 =?us-ascii?Q?XCZgZhq9A9wqsvKmICIPZImo6bwxk2gi07uq2N744nf9zZACdkXFIeykoXhk?=
 =?us-ascii?Q?ER25ujoPDJH8N5Rvca808YRQ29T+xQ2bQiAit7f0vDxubacrWr1trSkORN1M?=
 =?us-ascii?Q?E0cxhSsabyQLFQGTreopied6dU/ppS6qtXXpPtWKfNPAQWaxpD5AhdlGWjVE?=
 =?us-ascii?Q?xOGhXO2LEJMyDLmBNTTUMiLoGx0sRTka9ANteb6GJdzNwc8ZYpcKg72jmRFj?=
 =?us-ascii?Q?W78gvr+4Auk6fgnVd3PDQGMfvZIqampaJ1tO+aHHgcTbYquterL8mAEsb61Y?=
 =?us-ascii?Q?qVbqej1IPOHC919WzjPkQwEBibu48Gb/neSE3ro7VpoEukbXpqkw+Y5KFl0I?=
 =?us-ascii?Q?sTPcNtVEDoNmO1xPhp0VDC8ykvmARDIEes/rnZIPfTMVi1x6+ASzhQxaXzws?=
 =?us-ascii?Q?j7188P3kGOeBE5IwFi/06u7F5GtWOsruROyc8ri9SRb2xYOJ5zJZzEa0NFPq?=
 =?us-ascii?Q?CUuJxeQ41rn98fl8j1CaOdqW77oZi4A5H7D+o4WFrYGnU5chGCKmBzHiSzot?=
 =?us-ascii?Q?o1FmfVoqw79n+6bsXJAAljQx/Z7uWDZoIldKimcqvByLIYw62lg2lp765/Ke?=
 =?us-ascii?Q?CPtMbijb82QPw32BB7ruAvGV7MaID87BQRXQd/1sYa+ykitYXr1eE1VmGSIF?=
 =?us-ascii?Q?x4Y+IFm2hnklzscBY8wizo1JPc/dLpaBLG4AOkOnz97E5gQ1futEnfmMtQRa?=
 =?us-ascii?Q?+gh0BUZHI/X5kYXPW1n/Gq/nYGywGwTDE8P/iqNaAd8ir51I+O7tuL6NWpRL?=
 =?us-ascii?Q?P0kTVUoEO6TdGNZVJKNLMWmubV11En9kOQ0blJSLnrjfvWIH2GUIdUuOP+Zi?=
 =?us-ascii?Q?KO30rrO4x0OgK75vnO+vnG5Dl0nDPrhPcxGRzeFUtKbhFUHfsnFO8gktwcqd?=
 =?us-ascii?Q?HQg1fyMPk5fGeyajk1ta4kgXvReApUuuKVBgq/1AI6XLilCC0b3yk8tVvrbt?=
 =?us-ascii?Q?f+dQUzTDgn6WFX3umnKKspfcG/HhGTZJ9ENxRgvSV/IsDQKdOYfXLA0VcYzV?=
 =?us-ascii?Q?nqT7bq2K3UoW8W4xfmKLW0EoGTU7vSJCnXYXVPDjGWa86jYMCLBD67obgafR?=
 =?us-ascii?Q?6Ctoj8k4CoN/MaU+TLRfmgKIBtb30FKI3bYF0TBi54bB1Y9xUOQ5UE27wPTv?=
 =?us-ascii?Q?m7gob6wMvrhv+XHL1aNT071ibyJWvfnmlc9HzTSLvnnb6DypSbytrCbg0Fw7?=
 =?us-ascii?Q?P0aA/0XQzQ2+USt8B5bsrGyHMVUoHflOJx7wFvotcpTlALCENhVQ+G3jY5Uy?=
 =?us-ascii?Q?opuIFjhpVmdmmNSbOigtGADmqg1K6xf4KAaMuY0ZoAyaqgRPzxbO8XoKomKo?=
 =?us-ascii?Q?Wf089uSThIdUr3Xguu1E0zFxiZ7d/wy878zeB/8eYavCrRUFmeheojlpry6f?=
 =?us-ascii?Q?UjJPfu4W8O15lyVX0sFX71Iai9IPjnhIes+SASYNQ6SiAYoZPfwDIVfZFnnO?=
 =?us-ascii?Q?jRM8KbcINJqnjxw5Ow6aUOA9ldz1fkUTVZPUKc60JDxPmI9juHQ0upgfLYla?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7226a8be-50ce-4e35-e333-08dbfbf00589
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 15:27:30.8337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHboGq/O8VPyPx4xlNV3aR6YRkm+WQcaOMqmjyGSieY5GOhP+/BFW9cf/F8fqV3QiOfCFPkOioBShii5l+iXag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9273

Showing the precise error symbols can help debugging probe issues, such
as the recent -EIO error in of_mdiobus_register() caused by the lack of
bus->read_c45() and bus->write_c45() methods.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/mdio/mdio-mux.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-mux.c b/drivers/net/mdio/mdio-mux.c
index bef4cce71287..e5dee7ad7c09 100644
--- a/drivers/net/mdio/mdio-mux.c
+++ b/drivers/net/mdio/mdio-mux.c
@@ -190,8 +190,8 @@ int mdio_mux_init(struct device *dev,
 		r = of_property_read_u32(child_bus_node, "reg", &v);
 		if (r) {
 			dev_err(dev,
-				"Error: Failed to find reg for child %pOF\n",
-				child_bus_node);
+				"Error: Failed to find reg for child %pOF: %pe\n",
+				child_bus_node, ERR_PTR(r));
 			continue;
 		}
 
@@ -229,8 +229,8 @@ int mdio_mux_init(struct device *dev,
 			}
 			devm_kfree(dev, cb);
 			dev_err(dev,
-				"Error: Failed to register MDIO bus for child %pOF\n",
-				child_bus_node);
+				"Error: Failed to register MDIO bus for child %pOF: %pe\n",
+				child_bus_node, ERR_PTR(r));
 		} else {
 			cb->next = pb->children;
 			pb->children = cb;
-- 
2.34.1


