Return-Path: <netdev+bounces-252287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PJHO/gGcmmvZwAAu9opvQ
	(envelope-from <netdev+bounces-252287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:16:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9730F65D41
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 371EF827E35
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003B644CF3A;
	Thu, 22 Jan 2026 10:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PTPdAqIw"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237493BBA03;
	Thu, 22 Jan 2026 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079465; cv=fail; b=XlWNWBzctWItX0smFZSM0YNZtNDwOiAjgZUqnCT1nySVh8WmxGoi1jm5nMM2VI7tjkrTfcJxlAzcxJPkYSUeoQcYMppnjdX1d6Phjw6Hj/f/mhLV8XDsjSmu8eJivAGhBwqQN4nml/qZFtoRE6M8jLyCow74VHSfliCnOPaFTdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079465; c=relaxed/simple;
	bh=zqg3AoXpgXHlAlV7P+6pQujGgR9MDEPMwogeGOjSt6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=arQ2KIkiHIz78aV9RbyYhkez1WbYFfg4KktWCpn3gg1zsAB+ML+kNbjWzPPlpRHtbFps4xiNX3Mlc8qdL8AnGLCzzH6jdBntT7QjVdpAb932zN7H+VMgPd5ZYhVx41SVd+ZGtJtbKJJxQwfHcrrjBrQDgMEJUnuapnCVHOI91tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PTPdAqIw; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jErzEmluzk4m8RNsL9TKmLzwkMj4q9drw/rR3sduXa6kKpbwQKpr5wWpwD99puJm8ILxrc28xO41WrF7gnFNrpT8ltq2TlKDrBEMSp+FhzkNHoCorcWJ1TVr3Ou4rsQwvkdRa4cM5dXv0driCzqvUGFDhf6z8WdnmlEs7dWuOWZFXLVGaM5yzjrxe4w1/ZJlXZhNa8y3UN4vcTuLlQrVhN+MxtzZv/k1GnApn4o3XqTcxJz7PNA5lOWpAzOrthlfZ8LR/I9nObJZ0obGiH1rZPtyi2Wjj+evfMAt3c5gsHQIvWBLUdtHA1jACPWKXtIdjUEhMOZyOpv8txYG4Jd0tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jU6KegIpTI6mEErexqu/NeyVmgQ7tGnBBv4MZzE5QwU=;
 b=ilASefaZrl1+X9Cds9ysJA1ZpqNAdZXYeirU/HLNQTEZuVw40YqKkHcshitHw9DNxMelMzZ2O+X/EgffD4Ych/4hC5yvInmqdS+RfnxhD+jr8k6IAmHuBPRa7PQUAUYbZ1pU7J20g6IDcGCioQJGVBzNuJrOnMDXdWJgbTiiiUH8CAkc640UWO8DYNe9joKPmm6IX3e336iGaQCIYOxcSL45u4l9iAj0i60N8g7IPqKSmpyrXXMMP8HYudp4dhZdQjXLGfudWvbtupRp0wQOx8ZMU82ZX1cBwbCw0NMGlR8LMGKzinG625FUYpgT5vdh2DcvC4sLh2UY4kuS9HDiuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jU6KegIpTI6mEErexqu/NeyVmgQ7tGnBBv4MZzE5QwU=;
 b=PTPdAqIwHhMsALNEA0wxxgXNznObXlSFi7XplHkRcOg9oW+vV1YPVKWggBLUBpQf8B/s33jPqq5pbwhnvHirbnHtMDWqIRUDgSP5tcLYiyC8l1RzBAeszI/8wE5dPE5QSiSZYIabzw7VWfXl9kh5AFXKWfwLQ7EKplfYQ7/bDD4QjRMtRfd4JphjxzGiTqAYApro/rwtx3ZUYXAiqema5OIuXliiR4FOohPFULCDEvZDcZ/PUzzojFQmhNdboFitXga1Q0FclnBDDwA/iDxmUvdXI8i8kJqX7nMX0LB23F9RrAeJpRRDqSVSSYjP43DOblNru3urphyZpkY69txwvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM0PR04MB11853.eurprd04.prod.outlook.com (2603:10a6:20b:6f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:57:32 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.011; Thu, 22 Jan 2026
 10:57:32 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 net-next 14/15] dt-bindings: net: xpcs: allow properties from phy-common-props.yaml
Date: Thu, 22 Jan 2026 12:56:53 +0200
Message-Id: <20260122105654.105600-15-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260122105654.105600-1-vladimir.oltean@nxp.com>
References: <20260122105654.105600-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0029.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::14) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM0PR04MB11853:EE_
X-MS-Office365-Filtering-Correlation-Id: dd24ad3e-79cc-410c-1632-08de59a50aa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5AmHtS70u7OxvpNml0Qph5+ncjunwljut86rpDF9u4oD+8UhQGbQkzJrr6B1?=
 =?us-ascii?Q?8idWpHfn0KpmE8MYKm8MUhsW5rblnvZlLlFfl3DXdw3u729tVPyxi05B257X?=
 =?us-ascii?Q?MsigMAzl/NectouJEAhvc6Am3A0sALG4j+WhrbfqOdTQlF+EmlDdiZwSmrcW?=
 =?us-ascii?Q?aktMrobOJ4QTNVFt7Lz9Zakjdcugi49RJRD+Kr5G0Z9FzHVbOyzCtDC9KQtZ?=
 =?us-ascii?Q?k85w2Ujbwkd1i8JXLD7+CPJZeg737nhS36nb/Amq95VijpOz543DyDITRIyw?=
 =?us-ascii?Q?bOZ8/q/jOpblSJKkYyfI8RTZ8wx9oifUhjM0Xtv3iNCxImRZp6TdZL6b5KAP?=
 =?us-ascii?Q?z+Dh8hoO5BFjrbpFjDBtpx6xLHCEUP33+hflBf9sRxagAhTclw/iZZAvSot3?=
 =?us-ascii?Q?K6niAiAtATD1tPcuT+2KvAszFTOzKfmWvKqFgLhNCSYaW9myF3fZW4riOlAU?=
 =?us-ascii?Q?PMsn6YfPSIws4Hl8yRjjYozVP39RJczn5MTXkhH8g1SN4raditCCSqNORtZM?=
 =?us-ascii?Q?FvJHWXzXOqQB+QysXD06lnEUHMEgy+uOPcrbaQVBOnoTHlQ2JeorNSW4q4kx?=
 =?us-ascii?Q?Vee2IqkClECbyZ1xdkinUTGUE4T7ACVDzFxkbfg9aHMHLhlu8TFhVFZuVXCP?=
 =?us-ascii?Q?zczOX2Hx15bDnRwLZwHgsjuytomC6BAmjvsmCrLQ1McDbFbGMqxD7T71GScM?=
 =?us-ascii?Q?vfneT+5dkQKZMYkipHRsjggXCY4KbH+SGdnRpcLoevoIVgvpHFRe9XS584EW?=
 =?us-ascii?Q?CXc2b237r6K4h8ZessON+ZtU6rAutXcTHg1MkayMjACtyot306csiniV8zbP?=
 =?us-ascii?Q?jJpntr//nV537R9xZpFh5rrosxDrp8GtnoXgo941eZ2v6GCCbSutHcxtOIkY?=
 =?us-ascii?Q?PgvJJ+ycvPKT3duMUbypKZWRERcNQcNAYhS4bIIgflIZxf/3MIJL4UjDAAv+?=
 =?us-ascii?Q?AHoKc56dA4gl8msYTw3Ylhf5Y7HDlWt1ZTvpdEYhsM6zzaOzdEbh2NDddWRx?=
 =?us-ascii?Q?jaWXE0WDZ82GJ8qCR2RTO3B43CFbINZL1hV0TH9OtsOKRr+V7w0P2iZc4Mtg?=
 =?us-ascii?Q?wJJRPHxuAKo4cKdNo33q8ZrpxPlQUakOtiX7ZwZ0nOyIPdtzBr8gx0yhr8Xv?=
 =?us-ascii?Q?LX6LKfOxCYkH9jAgFX8X+MKjP3Qp0gWQmnmF3pUHajZVbs+AMd7q48EED3iC?=
 =?us-ascii?Q?IXY1HU3ufrTIdL+Q5N/8prmQR4Xd9OSizK4Ay2u67mS9nitwEFOFWzO3dcB2?=
 =?us-ascii?Q?dDIXndHf4ZB/RE6fIuwvAl+jz2dPwtAABcaIwyDs9ZOnwTztO3W6NvUATqoB?=
 =?us-ascii?Q?8Z3p2TL9glIrHLZKgHMXJh4lsZwzGLO8u5zLFtx8iixJ5eRKGby7O2v4sPf7?=
 =?us-ascii?Q?qbc0D30ULoExcebZ5to3lNoYoCOCwoX5KvHmO4261g41SujPcZJhrWXDMZcL?=
 =?us-ascii?Q?zfHseALhrbo+zgPg843PcEoAW824YCLEnrwkn0YYNY4rNy4W6mzrWkIBggo3?=
 =?us-ascii?Q?d0sA8sJzsUOOXz1kXSoxT9NXOSyrQPEmOhJYuQNBRHE+bx2K2uZUZ01hRtXS?=
 =?us-ascii?Q?fXw0xgv1YiWgDUZxUhDmDDh2Uxnx06tlcFbYUY8OljvYMz5sGulbJHxt1n09?=
 =?us-ascii?Q?gshdm82q3YKpv98j0Jq1mFE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2oeUFcaR5JlDp4XOtFPs4gVkXIupjheMZxkaQRAswEsf0gR3CcITzb7YyNxK?=
 =?us-ascii?Q?H/nCY68+w9/9gg88tRfvJakShcJzfA16i4X3wv5Ar7tWlVqClscThHWzvrz5?=
 =?us-ascii?Q?Hs+V1Y554eLuOPRzlfjkmKxkz9+ZLZ6EGdE8fF6G0m8SnvlqLUDKTS+4QCwr?=
 =?us-ascii?Q?IE+qA+WeZXHREzueeM1q6BrlQTlgWdWYfP/4ATYCLyftDA62jD5snTWRJaT+?=
 =?us-ascii?Q?MVXEyTkBXh30JNqGOsHEnCNF/FgFLwU5NIgW+qMXGCp5xq5KEKT/UteCtXlb?=
 =?us-ascii?Q?AFahFYQrklJDpg58CQxVlfydLyK7IpUBxWM+IoNCv+eFW/TLRFkGVkpHr1y1?=
 =?us-ascii?Q?Fpkmk1TRtC6Knrlg1Tf9kpRtDnHWASw9Tp/AvGWSwMWDD5AAFRlu6ieM+BVx?=
 =?us-ascii?Q?KDqmmEMvuwAGYvbFAF1W2pSDQX9Rxc5Pglb+9MQfhtCPGnQ6DNbZh2M/K+R8?=
 =?us-ascii?Q?5hKybAc+Vi0vJWreDFdtl/ggy1RiRSrhMPSqNlgbh8W0EbGCpQ1enPY7bxUw?=
 =?us-ascii?Q?EkAxXD78VxOptTYdxV9X+Tf4bQgzQ1x8uNxcMpsCUs/7cINJDGurDI1CHB2/?=
 =?us-ascii?Q?ggnWYBxZltVfnw6ORaVyG7+dL+ADetao9WN4d9hOZMQLmIsOzRcwHBF8WqYo?=
 =?us-ascii?Q?hUHmkocsx/kWmzdi2eMEcKbZM2Xcy4A/e2yTA1ghrSAMnD9euWiWjVaTvSo3?=
 =?us-ascii?Q?BwX9tzAcU6GZ0tvh54nK9GWYfBjqXwd89g3jgdx1KdwtboAQQQPvWY3ApXVv?=
 =?us-ascii?Q?BgrzMJeIdbn+CTOazKKcL7QdBqk7UJcNTaqu7vWGakDzSRSoHBQl/JtTjRDQ?=
 =?us-ascii?Q?CLz+qhJ6inocmpq+okD1PmU1MojsT5Q3tYaZv6EyaZ7DE+LyJYWS5yVFsR8G?=
 =?us-ascii?Q?sga7H8A1Wz78khojZ9guK8u3Y0micqHHs8qm6FyKYOuy1QFyxMp2PfwhKCHl?=
 =?us-ascii?Q?My8wd385KgDkprGlmW6x/FpdLSQYxQw0h49MS9zXYP2yEFJyTzBXg9uQRDZf?=
 =?us-ascii?Q?s0KO8ROsT2dU6JebvuK4uV0/jggsrw7FLISbss9FN54XBEqZL2y4bSLM8xeM?=
 =?us-ascii?Q?tNuOlR8LcxZFft8av8pepZFUROTCHXaA92a4UQG3td7KLR4O2QeOU+m8jaUk?=
 =?us-ascii?Q?WC+Bx94gmOztVJ4McVrclFe6obQnLOxnBBjs3uU0gaQ72+zAWtCG8ebpSJgA?=
 =?us-ascii?Q?F/JS09FJ7QzQsVdLc1m4ThEkAY82LWymrBVplxRQacNSvAswZq8IdIKqc9Bk?=
 =?us-ascii?Q?WBGElnQq3Wl9IXiWXTuK5cRuS2cSzuu51Lg2bPnYlNTpYaxLUcircKywOhvb?=
 =?us-ascii?Q?Xu64sVx5E7rQR/Xp7uYf8bcXErCzkL7sT/ddOa+xa3HdxdGfO+BCSLoYzz7t?=
 =?us-ascii?Q?iA3iTRuKkXuwX8x2H/LZz2A4rB2fe5xQeh+fQ7/O3USIn6mo8c1C59FTOnKh?=
 =?us-ascii?Q?fKhC0N0UyenH0R5U64uwV1N1NHVYW0u0A7bGGixNKBoS5/P2BQ1SKX9RFVTK?=
 =?us-ascii?Q?UWmE/iINCGTFinas7cMPtWM3N6jYB5AxfEcDxbgsyvI+OT/cJSz4hWqncrVS?=
 =?us-ascii?Q?dEwZvioHnlwzzmdVl0ADe6XugyMG9KIy7hrLKNCfKs0HQbHUcxx62vGMO+Gr?=
 =?us-ascii?Q?6gV+7D1pqsODimVUo7Jdla/UyJMy3zZDiFQ9Ci6yIosT6imGXNvnvKmbiC0n?=
 =?us-ascii?Q?VF1AlXN8trX4OxB0RPnoMBsNfs2z/tm7YJRIdFqBLO7wF+qZKDi1CrcjAIvU?=
 =?us-ascii?Q?jmAtiDcPCw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd24ad3e-79cc-410c-1632-08de59a50aa0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:57:32.0307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZ7GLZNp5UVFoJEv5gt9q12MFHMSzTCPi8MC+kndrrIxNgk95KZ8a4+rOpEHlOuZZnJSRv2XzWhM1KRgvDDxVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11853
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252287-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,linux.intel.com,bootlin.com,trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 9730F65D41
X-Rspamd-Action: no action

Now XPCS device tree nodes can specify properties to configure transmit
amplitude, receiver polarity inversion, and transmitter polarity
inversion for different PHY protocols.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: add Rob's review tag

 Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
index 46e4f611f714..e44253deeeb4 100644
--- a/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
+++ b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
@@ -22,6 +22,9 @@ description:
   by means of the APB3/MCI interfaces. In the later case the XPCS can be mapped
   right to the system IO memory space.
 
+allOf:
+  - $ref: /schemas/phy/phy-common-props.yaml#
+
 properties:
   compatible:
     oneOf:
@@ -110,7 +113,7 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1


