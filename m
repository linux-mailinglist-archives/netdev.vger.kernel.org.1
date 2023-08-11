Return-Path: <netdev+bounces-26765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D48778E42
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 13:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB10A28219A
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1291748E;
	Fri, 11 Aug 2023 11:54:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58A9A46
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 11:54:12 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FA3120
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 04:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKDqRJlkWdwJMXVBqmPcxptTCw0Q06ZZpfVAfgu6duoCT6D0OgYY/+kwe8diNYfhqMB9k4LLI8zD3xx+iNELmRFRUsqIfPiHRlOmRdm5oNfCHUTk85ZvFg1rIuKo4NGucu+jErNzHUzFDbXdqNRq6/GTCLbxiKl+zSfy2pcQ+doiYB70kj7+Y97aS4e3K6XFE8X7J6Va6h6Sn/BkjcEHsM8tFv5X9bLlg6o++2e4QRvyAkxfq7Kxvw4hWRsifwWQKYKnglC6YGvd2QGD9zNhEA6M8ENOGC0OkTBR2PhhTl31txaZHkbwPcL9GzQylr6Lg5FqHc8/7mL7aCOCx+AtsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjpthMGezLFb+SgnaDgZSWsuIqhM2lw0eVxp7fBwK44=;
 b=oCMPpglIAtC7z3sIZgyDB3Fdpit1KZHeh+DoxJdE32hi8tLxRkU9eOJKuEHUXGQgNNiCZdfbGbxc22+tyk4app0O4ds7jxvUXAawWWifQPP6XfvWlI+GcJS2zG2/B9zy9bs7dIdWCMYFKJet8Op7eBrXNF9QJ5mFCSUPVWZhL2qRLhPpNmYFO0QM5OupOztTlw3mhToIrGMwex5e46mgIxoaY9SMY2RYi2M0KA8+5o9r2QcWbf8FsyLZe9Mo3OeW10/FTwCdNb40D21+zrmQk1+tk6wRpo0nu3T59507TALxob+ofb3xtwlc76C1uk/YunDJb8ED+zX1YjMSXnSXyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjpthMGezLFb+SgnaDgZSWsuIqhM2lw0eVxp7fBwK44=;
 b=MeKrLXUADnJ6S4MRXchJSG6O3wN5iedVxHaWnmdQnESnDthKYebtFzRExZaq6CmuAJchEWFpG0uwpCopRtLryy4VTegES/XnjxaLddRyREsnna2nmy1if0LcgI1HsIImXzwxSGDYFmsDvq+36SWyrjqjYzSsDffmSrkInJngu2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB7590.eurprd04.prod.outlook.com (2603:10a6:20b:23d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 11:54:09 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%7]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 11:54:08 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Camelia Groza <camelia.groza@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next] net: pcs: lynx: fix lynx_pcs_link_up_sgmii() not doing anything in fixed-link mode
Date: Fri, 11 Aug 2023 14:53:52 +0300
Message-Id: <20230811115352.1447081-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0106.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::47) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d3b3078-5d23-4127-a1ee-08db9a61abbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8ojSLBt9t9gmdtn6YpWQ84AKA1Bpe3L0H+87cIt/A1IiD8hkkQ1MkZ3R+1bmUVxVzs353i9YjjVnLaROdOFZDnAY7RlFAr2V+IbNcouuybf4cVQsR0r5CKrXN6tRNjd+iUzFu/wdWwFwTVkVEgG9GMKYyZXuGSgC5XCp2LWIQ5XL9RM/y/AN2uDrkiSGafBK+XArnYlPMFUwIMXINMC5LjLrL7ZbZgvb77RoQxIeJh9wRD8m/BgU6cG0EuSi3kHRqGx6tngIDu4+nl/leYVeJqB48ZskiWdWeumm7rk/bed5SLFsA/oVY8Q2ExvlLWfHUJyuIp+dABRDEc99rp98w+rf0WB4tiBL5SdUctcY1oX3ye6aoatCJZ16igj6Eytos0txgbkHOkd5d/+YFAgMLyNFzdpN6fj4q1Ivu5A4q89xzYgAOlUOcVEKF4hCOnezwB07ntkGtRsCXdqHtnLKhLQFoPLZPBy1V7rbs70aHZT/OI6yeiLJ3el6m8EunbXxUlnSKJpOyCmeO4rUh+gamai1YoE++fLxZepsioMXHLdXl4HPzGYCEkpNLYoDcQrfkO4IT4NKJdLz1+RtqEws5vheAgtWq9Qm9eEyyNpcDTGQ/fg7fYQRLPiJeLi/7+lL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199021)(186006)(1800799006)(1076003)(6506007)(2616005)(6512007)(6486002)(6666004)(52116002)(36756003)(86362001)(38100700002)(38350700002)(26005)(83380400001)(54906003)(316002)(66476007)(66556008)(41300700001)(8676002)(8936002)(4326008)(66946007)(6916009)(44832011)(5660300002)(2906002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NXPW1cSiJiL3YmTEATiWsivgh1NFTRjO8YjiU6denQe5YSZhEJfgVTuVQv7h?=
 =?us-ascii?Q?P8FaR/bwnzGvnn9WUdhfnGt7EfEYEORSeOemUe6EWi7IGF1K12qYRKQECuIW?=
 =?us-ascii?Q?P36ayetsGIhgZVqzd/+usvD962zctPDmLYU/9Lslq41jAIfn+2SbWZUmcJ7N?=
 =?us-ascii?Q?ulCBQKfCmi9V4rKbQcuIs5v1hdR8GjWyIGPYLSHYwkFWzP70C2MY8KkwiF+g?=
 =?us-ascii?Q?V83ZMBgrD4xwX4fLAHpay3Gu3tP66ap1gRT9svSeutWjtyYo1XUJ8h770YCZ?=
 =?us-ascii?Q?a++xYVuQiqQvpTS/2gQdbrGYH5NULdqxn6MChHuVQdh4UHaEPnUzyReaGd6Y?=
 =?us-ascii?Q?M2Csnxbexn7Ri5pi6SFWvpxVR7JqWLOBSDpOAgnmcRiITPtkf/5omj36oBdy?=
 =?us-ascii?Q?L0Ho2T8kxokerzLzrG5csPpdjVTJCc8ZklI525LX9wGmV3F5nhh01M2up/iP?=
 =?us-ascii?Q?m3u4KBLj+dp14IT+LrU2IWvsCtSRW9Jt1DwaSGtQp0o4xiZiiW1Ms+/a18vf?=
 =?us-ascii?Q?u1NaejV4IESpyZT3Q/EFBXx811I8A6p2RtlMh8cEf7kKFpyEJ57ETxtFEy7N?=
 =?us-ascii?Q?73C3nN13tuBBsVu7LHufQU00hGUl9KrMTWDZks1htuq9dzVC7OTIZ4HDqDsE?=
 =?us-ascii?Q?8k5tAt6NlAD8ULRdo4E5yQCmn8ns7m1qmguGfVytlLV2fidskz2kIXfF4X4f?=
 =?us-ascii?Q?TKxU/fASxdCnnrIq3PugYOMycpRnayJnC5u011nrZs3+JUra79iZUaa30Ysw?=
 =?us-ascii?Q?waYskIWoDbDpNl9W0ZXeLy9I6YXdIsf1jCdn7ROXfVU9s5xU4tji8S80k4IB?=
 =?us-ascii?Q?FjpSal1EYU78D41LaGyYSVpLhMgUqkkcrhoNh+D4uRhvkI/BCuukYSgumnuX?=
 =?us-ascii?Q?hEkYOiIZRmlo3GUUUBQx0HqURpVmNegt0dBiA0I1tO1GMyCtExI6GzLrOMlN?=
 =?us-ascii?Q?9qnkoJHLD4G2w/taX5KgYuc75c6YZbxO1vcLt+ldkIOe5UHJmzCbVLOFKxKh?=
 =?us-ascii?Q?/l++naW8mu8X6rBwO6iZY9YzniN5aryIsyYfWc4yU95KiVdJqvp0T21477Ni?=
 =?us-ascii?Q?21NmDsLCq6CBKnW0u/M7VkgBEfS2Ts9E9f+TOfSvGOlSa0qb2akS4AFy7pVS?=
 =?us-ascii?Q?tPWgUn8dE/47o5UKcWpZ5fYNbAOKagN8Ww96P+sfMSLzgeyjy6KG8jJ/xL3h?=
 =?us-ascii?Q?71wDEmKNCR4uz2oYqMqXlRToLW0imjF6yYsxOUhBzqL3czfLUg1vW6F6BTcE?=
 =?us-ascii?Q?QonE7r4+MQM+CeflhXLeMciuWs6SarUkMDemhYjdWiTX1IM6dwGnC+yt2I2o?=
 =?us-ascii?Q?WE+12OMcFwJujImFVWOtrCn5vVdVNpjMCifHzB5fYqS6xj9DCyj4xVdpOvFl?=
 =?us-ascii?Q?nSX0d/9y/FUuiuWgAQy4OD3ZMFtm/oEM0I8jA3O9swCipmdLgco8Nqy6sVuM?=
 =?us-ascii?Q?W/YOZjWWVT+NhZfGeXXOJAZlP/6i+MI3jXetblDfxHsfKtaLMhvBxlkMW26M?=
 =?us-ascii?Q?qYas4yehMYrmWuxJRV147Ok9RF/JSV35tRrXX8zx3/d01gC+dQ14aEZDHy6p?=
 =?us-ascii?Q?0wkBQsQ3nwrM1f8vOvWAJvfTmI15PjoaV+XQr4JHVv0qmW39eRHU9CP96OjX?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3b3078-5d23-4127-a1ee-08db9a61abbe
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 11:54:08.8720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I55ITGXrTGJwaP9mF5jI/TuLrorYL8Nm1dW9vWIHu96I4qk4BmYcdFWgkkxSnc8CiGwQJPVcWw1tcBHMWSo1dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7590
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

lynx_pcs_link_up_sgmii() is supposed to update the PCS speed and duplex
for the non-inband operating modes, and prior to the blamed commit, it
did just that, but a mistake sneaked into the conversion and reversed
the condition.

It is easy for this to go undetected on platforms that also initialize
the PCS in the bootloader, because Linux doesn't reset it (although
maybe it should). The nature of the bug is that phylink will not touch
the IF_MODE_HALF_DUPLEX | IF_MODE_SPEED_MSK fields when it should, and
it will apparently keep working if the previous values set by the
bootloader were correct.

Fixes: c689a6528c22 ("net: pcs: lynx: update PCS driver to use neg_mode")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/pcs/pcs-lynx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
index 9021b96d4f9d..dc3962b2aa6b 100644
--- a/drivers/net/pcs/pcs-lynx.c
+++ b/drivers/net/pcs/pcs-lynx.c
@@ -216,7 +216,7 @@ static void lynx_pcs_link_up_sgmii(struct mdio_device *pcs,
 	/* The PCS needs to be configured manually only
 	 * when not operating on in-band mode
 	 */
-	if (neg_mode != PHYLINK_PCS_NEG_INBAND_ENABLED)
+	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
 		return;
 
 	if (duplex == DUPLEX_HALF)
-- 
2.34.1


