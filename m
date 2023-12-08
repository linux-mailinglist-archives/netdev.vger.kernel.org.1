Return-Path: <netdev+bounces-55426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A01F80AD2B
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 20:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707761F210B8
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0978A4F1F7;
	Fri,  8 Dec 2023 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mqc9pjoL"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6721712
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 11:37:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dd4CMtnKm/a5zOsHNy2pgcNQZQ+enMFiBh0xsN6L2W4cIEJghf41LfqE5ASo8oPwM29utad01W1zcDwFjfgPIHnlTtZ1550rBjUOWg2UJPFzaFEHv05wi4XczBNpc9xS3TWgjlW8MpmqETeITmpTQtSugzMu0IaLRFer7+5qP23WmfYpOnQf0S4sWMae4j6FCPiio2K4Ze1hs0D6I3l2o6Oe2Ad/1bJkXl37vv2jfIh80JNxh/w3K7uuIr6p0+hbx9BhlLZQQqXYycwoJeBsq+F1jWiz61IVmHdt323TNviqMbuoBNC41q6Yqt2nszvP8tI2XXyFFM7fAe3pGRz73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQcGMvpZiqBNTz/bJM6WqARp5rVSYM3EiQg6T5fIsx4=;
 b=IKNZYhe44IsFPz+yAWAFV433eqLg191KFiafCX06RQz1f8SLTBYQTPAjnjcT60NL7GEd2dfUkvix9d5i/m5sL0bUd5Rv+75yVvnpIjFBxmpyw3Is9f6Ig6caRexOjLRMuoFfDyQoD2/WB+gOFoSsIUKg1lftuESMmyWhmVy+DA1+yG5NhLoQ7Wy60xWdukljcPjKZ/P841z+bxmTY9ygoaqoQ+Xk9I3e/GS+TiaO7Ji6I/sH4K69/djta+ROtKWa7Gtp8xxGfTA8FJm2Bod2mvMRzQ/DTfblbrz2TsrPNz5AgZiOz8N3YacloGxAecMnwAl6GO8Cjk2RdOf6gu51nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQcGMvpZiqBNTz/bJM6WqARp5rVSYM3EiQg6T5fIsx4=;
 b=Mqc9pjoLlXvTGz55TuLOgYrlDdd0TWXeLaHbelUumnPKq8iMRE4lp2+WOhewbA3/Yhy2GEqhXAIps4hFEAhGyYoICN2S+DEukHK772tlu0IgtHZoySIm1ZlhtXnbjAHdvHsrwlZ6u3h8+VbdmqP4w/BJGMCvVFLytH0TbkRXb1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by GV1PR04MB9213.eurprd04.prod.outlook.com (2603:10a6:150:28::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 19:36:56 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 19:36:56 +0000
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
Subject: [PATCH net 4/4] docs: net: dsa: replace TODO section with info about history and devel ideas
Date: Fri,  8 Dec 2023 21:35:18 +0200
Message-Id: <20231208193518.2018114-5-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0b0112c5-f298-4f67-1ebb-08dbf82509b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rtrfxTZdTzwAWEx8IE4DiZUXa1VcAR8Hw2Wpfg6P+3d0TkiUHa18JlAuVoZPg7L17qb6H9rMh9/+FKequ+A1Hmw5Rb8IdDkHQxHR5Oso1xn54RBDlYDB++xLczTxxJ1qdZPzeviWZRcBCE0uKx+4aLJQxwhB4gysVWHEyosGCzA7XvDc1f12cCMGUYArKF7D/KtxcNvvq2hBWhosFfm54fjXyQ4jBQ0fWMth5j+pql3bfEtVRLlOAXJMLYFEgcRurOQi1t4VL8FIcucDH1H2LmZvyoxAeBWM2f1uUdALkjhZAHHNasfuWHa+AEVvns0P8GFgZCl2KNeoVkbQ4ybFK65uZnpyOurn/aKSQvgj92thazADZlSdnEPkjBUh9i+zBBmg6Lkp1mn9bo2ahw/GRsp5t4n+Fq9Si4Es8h8a/wOWDq5s0+txhDAJ2m+X7TIMBMrzDo2dNqpMR4Jt1W2u+7P6vkifAwpmUtcYXZMdINlaz+Z+rqc534SIzc4ajfQTcanQIFd2Nyr79lYmKBcILof4Siebpqqh+cQxBqbR3W5MX/u9nVRNNSrrcFBDMSu96Fb3oKsXaRi8GKhLnfakjGySQZ2HMF0Bav7zo7w80jX+pTW0HIoP06wM8RWTRnOKUD9goHbXchzJr3eF4mTdPhZ5RS3swmiKo2s9uQflyAE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38350700005)(66899024)(8676002)(6916009)(66476007)(66556008)(66946007)(54906003)(86362001)(36756003)(38100700002)(83380400001)(1076003)(8936002)(2616005)(26005)(52116002)(6512007)(6506007)(7416002)(2906002)(30864003)(316002)(478600001)(6486002)(6666004)(5660300002)(41300700001)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nOX9e51ststhuo7z2+DCrVUIRL2UWMKkhyphkuNpfiokCg4Vc3nhQqmVBVgL?=
 =?us-ascii?Q?ZyEl3DSnpMQvnokNMfrq1+hvm7rlZzPokWWbMxUpuh7fueHxOLj22+U8SQe9?=
 =?us-ascii?Q?ces6CxpMchaTElvH4kwaXk71k7ZNsirIqQcHVaHnm7IDLrafxzSlcA2c68JD?=
 =?us-ascii?Q?pc74GekUIfPUqlLJ6Mws2H3kgK9XQqMuMAO4IHc0zN0sZf3p1pO66/dmbtR0?=
 =?us-ascii?Q?NIIgL7VrlD/dWG5suWDeIVVqgEwRW+OzlCcy6GT06rqdO7oZRx/J+3h99DKw?=
 =?us-ascii?Q?zHA9QBVB8TiwYL+Cq4B2qH0mz2x/XADEm7KFRjPOMcL7bxO+HnRDS+eF1q+F?=
 =?us-ascii?Q?tqMdGh8swQKmWPaC6Br+iPyCVv9R/zZU6CcL20wEMCOfwLutyLFa9APOFrUs?=
 =?us-ascii?Q?6poOG388S/UOfABAD7M2Ej5FFrJAY1U+HqBaKZv12oftLIdI5MPmYhxk2W4S?=
 =?us-ascii?Q?v5edSTaBAp3UUQUZTwSKxBUyHnP9MMcyztTE002TFZAx97tz2JbKTo+CHrMB?=
 =?us-ascii?Q?5EpJqb2DgdmxYOV4tJwfR6BXyK7EF2Ed5Sj2xeZXwseAqY47oko9oASKWlMh?=
 =?us-ascii?Q?1dv0AxtkVrACDRIrbftYeJ/CUJUNg3haNb5NpscHBzGLMXsZrqCpHGLxzLsl?=
 =?us-ascii?Q?X0vh4ZZwzWnyweTTQr+BEMX3tqVwpa8zeiYg3fjCo+mLtf5gNFXSMSON9fBG?=
 =?us-ascii?Q?qdIIEg7KbhjzmNO/9eGlbtX5G1V8n4cvpW0J0p3oJRDnEEsk/ohu4l/wWNKd?=
 =?us-ascii?Q?jDWeyDdmfsBV7oaybikOMbEKa/Hoj/cOm6WzCot5P8J/B3qOEmyPan74nBTt?=
 =?us-ascii?Q?Hc065niXA1RZl1rEYsCNxDMOh2yPZ/pTrcSbMZAcJ3YvjI9ZdoCy4s09o2f5?=
 =?us-ascii?Q?+5Oz4RnaqR1SdVrLnHNGQo7aG588NXjaovf9VjujgWmqw7gDA8UbzYOcQhQz?=
 =?us-ascii?Q?mOoHlam2mmff9t1s5a/2FY+ENVt0vB1EwCFRQ5CKnfen5S+/x4BjYpsyDHIo?=
 =?us-ascii?Q?e+5DyLsW6Hsx8OOK722AK5lgu3AzHfm/wI+RinkQgg/CDfAJGN5WKRi1aHwT?=
 =?us-ascii?Q?/tjPOBHCO9WHfAiaC6tEDxuUDDElJXHcf5eTn0CkbS/ZDhgcnSVYmChx+gJk?=
 =?us-ascii?Q?miywlVo5d1W/CNVz4TbIoqpsPvRA53ufYsS0DHgj2MTlDaOtHyvw8dFLAFez?=
 =?us-ascii?Q?P9iPywAywDelZurGg+FOwXl982LQd2O/OP+NdVaFhCx+jcGz2ZAB5OaBQopH?=
 =?us-ascii?Q?/b7GvyrKIQW6ROBs+IpU71UXRgE+m+W4ItMPuptD4bISy7VlpVCZc6H9An/F?=
 =?us-ascii?Q?rzNcVMiithhw08dQgv0cjsf/eeit6EXsXqW7WebIiciEXRxTYlKIo3eIhQZH?=
 =?us-ascii?Q?YD1GSPxsdDeHuuQ1/AJZl5zY6ts4FZifUVKCe0tJ5+CC4bjaeYVst4ihwJEO?=
 =?us-ascii?Q?o4jlHmflcST6t362rDo4de9MdSA3Mk9uPLw24LxJA4KlDHWDgsgRA1Pzk8zG?=
 =?us-ascii?Q?EPL5607NT1+zhcM9T+bRU9l0ULb1oUWUvFOQ+0olh5xbV9jyXJ0nZ9KcinrN?=
 =?us-ascii?Q?DbthKJYSS/y0RK7TUlLzqzr7SCkr7RdPRUcGYwRGh+ixDQ8yoShF5BArQCBn?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0112c5-f298-4f67-1ebb-08dbf82509b9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 19:36:56.5309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpFOzOQRk3kFbYNoQ+gfg/XV49OD+bP2/dHkot4tGL2f64gAmnreAA8mY2ht3/AzBP9Qdw4WSQlMRyobWs7sdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9213

It was a bit unclear to me what the TODO is about and what is even
actionable about it. I had a discussion with Florian about it at NetConf
2023, and it seems that it's about the amount of boilerplate code that
exists in switchdev drivers, and how that could be maybe made common
with DSA, through something like another library.

I think we are seeing a lot of people who are looking at DSA now,
and there is a lot of misunderstanding about why things are the way
they are, and which are the changes that would benefit the subsystem,
compared to the changes that go against DSA's past development trend.

I think what is missing is the context, which is admittedly a bit
hard to grasp considering there are 15 years of development.
Based on the git log and on the discussions where I participated,
I tried to cobble up a section about DSA's history. Here and there,
I've mentioned the limitations that I am aware of, and some possible
ways forward.

I'm also personally surprised by the amount of change in DSA over the
years, and I hope that putting things into perspective will also
encourage others to not think that it's set in stone the way it is now.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 Documentation/networking/dsa/dsa.rst | 186 +++++++++++++++++++++++++--
 1 file changed, 176 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/dsa/dsa.rst b/Documentation/networking/dsa/dsa.rst
index 2cd91358421e..305bb471fc02 100644
--- a/Documentation/networking/dsa/dsa.rst
+++ b/Documentation/networking/dsa/dsa.rst
@@ -1200,14 +1200,180 @@ methods must be implemented:
 - ``port_hsr_leave``: function invoked when a given switch port leaves a
   DANP/DANH and returns to normal operation as a standalone port.
 
-TODO
-====
-
-Making SWITCHDEV and DSA converge towards an unified codebase
--------------------------------------------------------------
+History and development directions
+==================================
 
-SWITCHDEV properly takes care of abstracting the networking stack with offload
-capable hardware, but does not enforce a strict switch device driver model. On
-the other DSA enforces a fairly strict device driver model, and deals with most
-of the switch specific. At some point we should envision a merger between these
-two subsystems and get the best of both worlds.
+This section gives some background context to the developers who are eager to
+make changes to the DSA core (``net/dsa/`` excepting ``tag_*.c`` files).
+
+Initially (2008), the DSA core was a platform driver for a platform device
+representing the switch tree. Support for hardware switch chips lived in
+separate modules, which were required to call the ``register_switch_driver()``
+method. The tree platform device was instantiated through ``platform_data``.
+
+Later (2013), the DSA core gained support for OF bindings. The initial bindings
+(now no longer supported) expected a compatible string of "marvell,dsa" or
+"brcm,bcm7445-switch-v4.0" for the tree, and, like the implementation of the
+DSA core, also expected that all switches in the tree are MDIO devices on an
+``mii_bus``. The initial bindings and core driver implementation first assumed
+that all switches in the tree are connected to the same MDIO bus, then in 2015,
+they were augmented such that each switch may be on its own MDIO bus.
+
+The early DSA core was more concerned with using switches as port multiplexers
+and with managing auxiliary functionality like temperature sensors
+(``CONFIG_NET_DSA_HWMON``) rather than with production-ready features.
+Bridging and bonding were handled in software. Support for hardware-accelerated
+bridging, by means of integrating with the ``switchdev`` framework, was added
+in 2015.
+
+In mid 2016, the second (and current) device tree binding for DSA was
+introduced. Here, individual switches are represented as devices in the Linux
+device model sense, on arbitrary buses, not just MDIO. The limitation of being
+able to describe a single CPU port was lifted (the driver support for multiple
+CPU ports came much later, in 2022). During this time, DSA stopped playing the
+role of a device model for switches, and ``register_switch_driver()`` was
+replaced with ``dsa_register_switch()``, the modern mechanism through which
+arbitrary devices may use DSA as a framework exclusively for integrating
+Ethernet switch IP blocks with the network stack.
+
+With the conversion to the second device tree binding, DSA's support for
+``platform_data`` (used in non-OF scenarios) was also changed to align. With
+the DSA tree no longer being a platform device, the ``platform_data`` structure
+moved to individual switch devices.
+
+Support for the initial device tree binding was subsequently removed in 2019.
+
+Probing through ``platform_data`` remains limited in functionality. The
+``ds->dev->of_node`` and ``dp->dn`` pointers are NULL, and the OF API calls
+made by drivers for discovering more complex setups fall back to the implicit
+handling. There is no way to describe multi-chip trees, or switches with
+multiple CPU ports. It is always assumed that shared ports are configured by
+the driver to the maximum supported link speed (they do not use phylink).
+User ports cannot connect to arbitrary PHYs, but are limited to
+``ds->user_mii_bus``.
+
+Many switch drivers introduced since after DSA's second OF binding were not
+designed to support probing through ``platform_data``. Most notably,
+``device_get_match_data()`` and ``of_device_get_match_data()`` return NULL with
+``platform_data``, so generally, drivers which do not have alternative
+mechanisms for this do not support ``platform_data``.
+
+Extending the ``platform_data`` support implies adding more separate code.
+An alternative worth exploring is growing DSA towards the ``fwnode`` API.
+However, not the entire OF binding should be generalized to ``fwnode``.
+The current bindings must be examined with a critical eye, and the properties
+which are no longer considered good practice (like ``label``, because ``udev``
+offers this functionality) should first be deprecated in OF, and not migrated
+to ``fwnode``.
+
+With ``fwnode`` support in the DSA framework, the ``fwnode_create_software_node()``
+API could be used as an alternative to ``platform_data``, to allow describing
+and probing switches on non-OF.
+
+DSA is used to control very complex switching chips. Some devices have a
+microprocessor, and in some cases, this microprocessor can run a variant of the
+Linux kernel. Sometimes, the switch packet I/O procedure of the internal
+microprocessor is different from the packet I/O procedure for an external host.
+The internal processor may have access to switch queues, while the external
+processor may require DSA tags. Other times, the microprocessor may also be
+connected to the switch in a DSA fashion (using an internal MAC to MAC
+connection).
+
+Since DSA is only concerned with switches where the packet I/O is handled
+by an intermediate conduit driver, this leads to the situation where it is
+recommended to have two drivers for the same switch hardware. When the queues
+are accessed directly, a separate non-DSA driver should be used, with its own
+skeleton which is integrated with ``switchdev`` on its own.
+
+In 2019, a DSA driver was added for the ``ocelot`` switch, which is a thin
+front-end over a hardware library that is also common with a ``switchdev``
+driver. While this design is encouraged for other similar cases, code
+duplication among multiple front-ends is a concern, so it may be desirable to
+extract some of DSA's core functionality into a reusable library for Ethernet
+switches. This could offer a driver-facing API similar to ``dsa_switch_ops``,
+but the aspects relating to cross-chip management, to DSA tags and to the
+conduit interface would remain DSA-specific.
+
+Traditionally, DSA switch drivers for discrete chips own the entire
+``spi_device``, ``i2c_client``, ``mdio_device`` etc. When the chip is complex
+and has multiple embedded peripherals (IRQ controller, GPIO controller, MDIO
+controller, LED controller, sensors), the handling of these peripherals is
+currently monolithic within the same device driver that also calls
+``dsa_register_switch()``.
+
+But an internal microprocessor may have a very different view of the switch
+address space, and may have discrete Linux drivers for each peripheral.
+In 2023, the ``ocelot_ext`` driver was added, which deviated from the
+traditional DSA driver architecture. Rather than probing on the entire
+``spi_device``, it created a multi-function device (MFD) top-level driver for
+it (associated with the SoC at large), and the switching IP is only one of the
+children of the MFD (it is a platform device with regmaps provided by its
+parent). The drivers for each peripheral in this switch SoC are the same when
+controlled over SPI and when controlled by the internal processor.
+
+Authors of new switch drivers that use DSA are encouraged to have a wider view
+of the peripherals on the chip that they are controlling, and to use the MFD
+model to separate the components whenever possible. The general direction for
+the DSA core is to shrink in size and to focus only on the Ethernet switching
+IP and its ports. ``CONFIG_NET_DSA_HWMON`` was removed in 2017. Adding new
+methods to ``struct dsa_switch_ops`` which are outside of DSA's core focus on
+Ethernet is strongly discouraged.
+
+DSA's support for multi-chip trees also has limitations. After converting from
+the first to the second OF binding, the switch tree stopped being a platform
+device, and its probing became implicit, and distributed among its constituent
+switch devices. There is currently a synchronization point in
+``dsa_tree_setup_routing_table()``, through which the tree setup is performed
+only once, when there is more than one switch in the tree. The first N-1
+switches will end their probing early, and the last switch will configure the
+entire tree, and thus all the other switches, in its ``dsa_register_switch()``
+calling context.
+
+Furthermore, the synchronization point works because each switch is able to
+determine, in a distributed manner, that the routing table is not complete, aka
+that there is at least one switch which has not probed. This is only possible
+because the ``link`` properties in the device tree describe the connections to
+all other cascade ports in the tree, not just to the directly connected cascade
+port. If only the latter were described, it could happen that a switch waits
+for its direct neighbors to probe before setting up the tree, but not
+necessarily for all switches in the tree (therefore, it sets up the tree too
+early).
+
+With more than 3 switches in a tree, it becomes a difficult task to write
+correct device trees which are not missing any link to the other cascade ports
+in the tree. The routing table, based on which ``dsa_routing_port()`` works, is
+directly taken from the device tree, although it could be computed through BFS
+instead. This means that the device tree writer needs to specify more than just
+the hardware description (represented by the direct cascade port connections).
+
+Simplifying the device tree bindings to require a single ``link`` phandle
+cannot be done without rethinking the distributed probing scheme. One idea is
+to reinstate the switch tree as a platform device, but this time created
+dynamically by ``dsa_register_switch()`` if the switch's tree ID is not already
+present in the system. The switch tree driver walks the device tree hop by hop,
+following the ``link`` references, to discover all the other switches, and to
+construct the full routing table. It then uses the component API to register
+itself as an aggregate driver, with each of the discovered switches as a
+component. When ``dsa_register_switch()`` completes for all component switches,
+the tree probing continues and calls ``dsa_tree_setup()``.
+
+The cross-chip management layer (``net/dsa/switch.c``) can also be improved.
+Currently ``struct dsa_switch_tree`` holds a list of ports rather than a list
+of switches, and thus, calling one function for each switch in a tree is hard.
+DSA currently uses one notifier chain per tree as a workaround for that, with
+each switch registered as a listener (``dsa_switch_event()``).
+
+It is considered bad practice to use notifiers when the emitter and the
+listener are known to each other, instead of a plain function call. Also, error
+handling with notifiers is not robust. When one switch fails mid-operation,
+there is no rollback to the previous state for switches which already completed
+the operation successfully.
+
+To untangle this situation and improve the reliability of the cross-chip
+management layer, it is necessary to split the DSA operations into ones which
+can fail, and ones which cannot fail. For example, ``port_fdb_add()`` can fail,
+whereas ``port_fdb_del()`` cannot. Then, cross-chip operations can take a
+fallible function to make forward progress, and an infallible function for
+rollback. However, it is unclear what to do in the case of ``change_mtu()``.
+It is hard to classify this operation as either fallible or infallible. It is
+also unclear how to deal with I/O access errors on the switch's management bus.
-- 
2.34.1


