Return-Path: <netdev+bounces-55423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD34580AD28
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 20:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B740A1C20B19
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75164F601;
	Fri,  8 Dec 2023 19:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RYEvIwqk"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27FC1712
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 11:36:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7Y7FknJhAtdZmzEwTU4s1HMem2Vj8Z2gP9jA1tdH9InT5OyrBCrU4GBJ83irHPcb2qvqho5Cua+TFRuBx3J2I7XlpDXzd7+/jEn0GiJRZPZ9pLcduukbIBbCBZOhgw9nM50SyVSWKPT7uvOjudO9vRnKNV2tTLWyyCt+Jw8kQ9zqKHQPxrsgeF+I/CuF+QJj1jh3RIX3Q6RhKiDHduVxV6yW9oRxOCxvzItIk44yyUWTMg0mxKdWiORomLaoeQxXAqyzm3VEZZoNUIM/c31ElLvwEKQqVy2qkmeozMt6E7L6mG/Jz5R2Ft2OHklDwaveAHz1BfZlQFYcR+7cxwtjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXj9mnn60bcqUhEuemsfc+VvMMgJ+weiN/8/DPHM9Pw=;
 b=YLFICNz1CXc6XBIkziHJ1l72hNoGvLUzl5qUWPYOJtSErlXlBxM3TOG1OJmq5JuqqXFDnPEgHKz27kHe7nOmBUKCugwLCKVqfRL0hKd5zSHBQznZAd9ztno2RdzX41IGjdOAcGIYzka37RycnJ69cme44JQmAQZlHalWz4jTqqGAZ2d2YnPp2YAU+PP+oJW7WdrU/Tku8e0t2xv5jrL+8/nJkItoNImis7H6xFgXc2MUSRxqWbh4dIsmdTAVzybtcxBBTm9UJOP4APEaa/FWKdG6M9V8OY24NQY0U8BLJf4fRRN6aP34mTH6sxupTu2g3D8JVs38/y5NMqi0uPtLkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXj9mnn60bcqUhEuemsfc+VvMMgJ+weiN/8/DPHM9Pw=;
 b=RYEvIwqkzWy7u/9r08mUz1oXv2+t6g6SgH4PsJ2lmCwhbOeSZMQZYOP1k0c7EmoDkfpyXg/sk0da7POhSj0La2lpXH3QgyVejFitN7TDwUeqvIjXg5aYmXgHyCVyqMarRhE/o083y1hFJhqG6xn5MWQf1Oh9LugQppnoDAnqfrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by GV1PR04MB9213.eurprd04.prod.outlook.com (2603:10a6:150:28::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 19:36:52 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 19:36:52 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Madhuri Sripada <madhuri.sripada@microchip.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net 1/4] docs: net: dsa: document the tagger-owned storage mechanism
Date: Fri,  8 Dec 2023 21:35:15 +0200
Message-Id: <20231208193518.2018114-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208193518.2018114-1-vladimir.oltean@nxp.com>
References: <20231208193518.2018114-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::16) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|GV1PR04MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9ce0a1-370e-40a6-c204-08dbf8250756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yBkxGcbw4KO8dTOvIt7/SJ1oFK646Xb/0r0P0ZsjyuEQBzXPunt5JDZiIGTztdoXGZZ+DqB5m0nfBzRRphatgJ5lZDBIZ8ap40Vj8OpIrFOMwjQQZjh4DOyJlvRt92NskErkTWzE4vebQi8V+hakCTORmmP9WtEz5FDSL2T8GoegpEpm6L8MUmKVB4moGGxXqteGDkBcxKM5jZIcOiou/W89TcMADWq8eI8O2QyrrjRlUO6p85h60PPZjKk2rCcqrShXxD60ALSWBoC0cjzr7fw6xnvCE15OoNM6Q8A0yd/pw1FSlEOaBoepOIvUsP2P2IVMRCy0B8WgS3q0QKhiOixn9sAD6ozTZ7jzPOqIsCR/Awu5WNC71TrTsZZJ6n8JZWNSQKxoP30aR69hhzEuNlJ92cZ69TggYWDWbx8V7/0JFX/YsIhuWD58EBdnU0SC+n+WHxg1LG1Zhm91ec6UVrq/wZg389XA5DRaJXiBkKPN3XopVDkBr774JRL5ExpRZ4jHPXno7VkR/hMrfboDjbMuzWnbfM8GVwbZmNL5dKbzRxSvryoiiXWkGFrXMXGvyGtjCq/Du2VwfyI1pvDQs0ty1RxeEw5o4KiLRn/xx4pi0NBTfVDfNvbToPyF+kx4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38350700005)(66899024)(8676002)(6916009)(66476007)(66556008)(66946007)(54906003)(86362001)(36756003)(38100700002)(83380400001)(1076003)(8936002)(2616005)(26005)(52116002)(6512007)(6506007)(7416002)(2906002)(316002)(478600001)(6486002)(6666004)(5660300002)(41300700001)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3YDsMTxXpyGp5ADeeYA2PS3vd5NSaeDFS8rZCoRzYwhbYyIKKWz43Ti+GBIQ?=
 =?us-ascii?Q?+aVlzsSD4ykaOJkWZ8IYco2TcjYf0bcGwYLplg46d/R+YUgVgq8A4+JG4Tqq?=
 =?us-ascii?Q?USNbyklbVV3PkIsZTfBp0kGa7IxXN2RNr21MQAcvEeennKA0hgSdfCkO6AP8?=
 =?us-ascii?Q?jewfDZwOxycEBAL+M+S3D0f8Ix97jq+wtQQ8zTyZ/wLVB9SLg6Dw1w4m7yhc?=
 =?us-ascii?Q?yCXSZsnDXusTuuhsqkSvxrIq/JBvLGOI1R/mTQAqUKw6dflImvVqC+PXyPYE?=
 =?us-ascii?Q?Zv4zkyBrT4SIOqJZmcZUe9Se7NlVLIAa3Sfk6lLW/lAI18nfe55RPjJFB8Yh?=
 =?us-ascii?Q?tmhyre2DD27lMvqeF/kuBWQkcAkwyJKf+sSrp72wu0bNNVW9waFlZsoJprEc?=
 =?us-ascii?Q?j5FIVRYg0dNazXz1glNlHWp936VoznpIiUqL8mgLPJlL/SldO4VmQ0Yi1ymT?=
 =?us-ascii?Q?1XBc5vmc26wS6HRS7hx/aYMJ0bhtuM8DM4AsySpvF8Q+lUeeGxLtN1W4+iTK?=
 =?us-ascii?Q?8Tms3OlBKDLr0OAhEO2XUZvtHcbyxZfu++k5se1FHZ7UNXu0zPhd7VXfRaoI?=
 =?us-ascii?Q?gVSWoHvl6tnzPWc29G57hX3EyT3R6ARd6JGthjRGdl/kLgnD3omvE3VIF15e?=
 =?us-ascii?Q?TH29Qmf4m2F6Ume7aFpaqdc8w1xgr6R76i3svGMP6JzpEdbbjwNvH29vsHLT?=
 =?us-ascii?Q?+RnptodG0IX+Lgrszi+eDHaMI7HV5zJ/DH7CgsKcaFT19C9c8b/KZgAJ+MTJ?=
 =?us-ascii?Q?8QgjNOeyE4rX+m+Fgcyj9scLh6MWQXbbxzjZeJ0xx0xZqFUAZbNWtQToS+63?=
 =?us-ascii?Q?zZsmPlWlqADVaHfbRmKJcA5Af0iSoR7EKYBiN43X1HSu3Jjc1UTy3D0WOEhu?=
 =?us-ascii?Q?gDqYD/ItpjnO8/0jFf+TQnqwucqtBa4mFQr3yOGM/bxDvF1+KIcEiKHivIdy?=
 =?us-ascii?Q?N0J87ikE78XDWAswMTrXyMPXrx+eio61+89i7bE2bPXbZxrnknAlL6mFMklR?=
 =?us-ascii?Q?qIdYagG7sYXnClPAori9LxR6tcOiqpIFNWLDiVCvgQ9tBkmT2te0R0idMrF2?=
 =?us-ascii?Q?T8axIwUQ5zGPuQJfxvGtBMksTNJWriJA6khuxYB9rxSeQzp4vooZgDeq00fY?=
 =?us-ascii?Q?vqoULHiTyvdcsTNxbaShB6ZaOBXKKjd3Z+MvnTZPXUv99mzOaMsjYP9prwt9?=
 =?us-ascii?Q?6/NjiuV530urfiIoWTkgBO/K6ASI95aFz9CnqsMH76B2IKSYgwieBCoYliIl?=
 =?us-ascii?Q?BcqkKIls3RIraFUoJmlvFtC5AsAMOFaZ9Mfa1eOZVO+Y0d+o/jJS18A1ze4P?=
 =?us-ascii?Q?yzMb/SeJPn/b2n4gfxBouSRGRVgeY43UIvzC+VB0rYeKlOQQHpQ7NQOUVUzp?=
 =?us-ascii?Q?71/WFn3Lw4HdOJdMc7s4bH69d5tHVwedeosP5hw87xiAHMm/fLmm7QFDIQj2?=
 =?us-ascii?Q?VhaH3D3mMw50MmfqPnxh3OKWgRkrCGUwMpCGrrsyls17IotKxJiMaxaGuA+P?=
 =?us-ascii?Q?wMguoPV4jt6LNRIAfk17qdogOkc7cYQzXfBJvVEmx/lxr/nSg/DdD9Re5UN0?=
 =?us-ascii?Q?75tvEoPIMnEf9mZ68Q/4l6VwDjhqtv0hE7G829zWftPcO5EoL8QiT8XspiZS?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9ce0a1-370e-40a6-c204-08dbf8250756
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 19:36:52.5847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9MhR3WUvDqXJTt/3h6btLVHSDIRfG1nHQ7LOqqHsjxb0oFWD8w8S/CxkS0aLate5IpmuJIWRLq4/4vpye8EWoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9213

Introduced 2 years ago in commit dc452a471dba ("net: dsa: introduce
tagger-owned storage for private and shared data"), the tagger-owned
storage mechanism has recently sparked some discussions which denote a
general lack of developer understanding / awareness of it. There was
also a bug in the ksz switch driver which indicates the same thing.

Admittedly, it is also not obvious to see the design constraints that
led to the creation of such a complicated mechanism.

Here are some paragraphs that explain what it's about.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 Documentation/networking/dsa/dsa.rst | 59 ++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/networking/dsa/dsa.rst b/Documentation/networking/dsa/dsa.rst
index 7b2e69cd7ef0..0c326a42eb81 100644
--- a/Documentation/networking/dsa/dsa.rst
+++ b/Documentation/networking/dsa/dsa.rst
@@ -221,6 +221,44 @@ receive all frames regardless of the value of the MAC DA. This can be done by
 setting the ``promisc_on_conduit`` property of the ``struct dsa_device_ops``.
 Note that this assumes a DSA-unaware conduit driver, which is the norm.
 
+Separation between tagging protocol and switch drivers
+------------------------------------------------------
+
+Sometimes it is desirable to test the behavior of a given conduit interface
+with a given switch protocol, to see how it responds to checksum offloading,
+padding with tail tags, increased MTU, how the hardware parser sees DSA-tagged
+frames, etc.
+
+To achieve that, any tagging protocol driver may be used with ``dsa_loop``
+(this requires modifying the ``dsa_loop_get_protocol()`` function
+implementation). Therefore, tagging protocol drivers must not assume that they
+are used only in conjunction with a particular switch driver. Concretely, the
+tagging protocol driver should make no assumptions about the type of
+``ds->priv``, and its core functionality should only rely on the data
+structures offered by the DSA core for all switches (``struct dsa_switch``,
+``struct dsa_port`` etc).
+
+Additionally, tagging protocol drivers must not depend on symbols exported by
+any particular switch control path driver. Doing so would create a circular
+dependency, because DSA, on behalf of the switch driver, already requests the
+appropriate tagging protocol driver module to be loaded.
+
+Nonetheless, there are exceptional situations when switch-specific processing
+is required in a tagging protocol driver. In some cases the tagger needs a
+place to hold state; in other cases, the packet transmission procedure may
+involve accessing switch registers. The tagger may also be processing packets
+which are not destined for the network stack but for the switch driver's
+management logic, and thus, the switch driver should have a handler for these
+management frames.
+
+A mechanism, called tagger-owned storage (in reference to ``ds->tagger_data``),
+exists, which permits tagging protocol drivers to allocate memory for each
+switch that they connect to. Each tagging protocol driver may define its own
+contract with switch drivers as to what this data structure contains.
+Through the ``struct dsa_device_ops`` methods ``connect()`` and ``disconnect()``,
+tagging protocol drivers are given the possibility to manage the
+``ds->tagger_data`` pointer of any switch that they connect to.
+
 Conduit network devices
 -----------------------
 
@@ -624,6 +662,27 @@ Switch configuration
   case, further calls to ``get_tag_protocol`` should report the protocol in
   current use.
 
+- ``connect_tag_protocol``: optional method to notify the switch driver that a
+  tagging protocol driver has connected to this switch. Depending on the
+  contract established by the protocol given in the ``proto`` argument, the
+  tagger-owned storage (``ds->tagger_data``) may be expected to contain a
+  pointer to a data structure specific to the tagging protocol. This data
+  structure may contain function pointers to packet handlers that the switch
+  driver registers with the tagging protocol. If interested in these packets,
+  the switch driver must cast the ``ds->tagger_data`` pointer to the data type
+  established by the tagging protocol, and assign the packet handler function
+  pointers to methods that it owns. Since the memory pointed to by
+  ``ds->tagger_data`` is owned by the tagging protocol, the switch driver must
+  assume by convention that it has been allocated, and this method is only
+  provided for making initial adjustments to the contents of ``ds->tagger_data``.
+  It is also the reason why no ``disconnect_tag_protocol()`` counterpart is
+  provided. Additionally, a tagging protocol driver which makes use of
+  tagger-owned storage must not assume that the connected switch has
+  implemented the ``connect_tag_protocol()`` method (it may connect to a
+  ``dsa_loop`` switch, which does not). Therefore, a tagging protocol may
+  always rely on ``ds->tagger_data``, but it must treat the packet handlers
+  provided by the switch in this method as optional.
+
 - ``setup``: setup function for the switch, this function is responsible for setting
   up the ``dsa_switch_ops`` private structure with all it needs: register maps,
   interrupts, mutexes, locks, etc. This function is also expected to properly
-- 
2.34.1


