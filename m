Return-Path: <netdev+bounces-254734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFg7DXs6e2mNCgIAu9opvQ
	(envelope-from <netdev+bounces-254734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:46:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F34BAF093
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CDD33049943
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F82138A9B3;
	Thu, 29 Jan 2026 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="en/3qdV0"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011044.outbound.protection.outlook.com [40.107.130.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CF4385EFA;
	Thu, 29 Jan 2026 10:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682982; cv=fail; b=kC9l2TOeEbNkGkS+CMMh40pEsd/LMMADd21+eUE7b5cRXf/QJsuyDl9j0+zM2tnvQ15taRS5Ul9nSKqk+0HvuI0z0uNrGn3mQVIKhsYlHQSYAYMw8uooYjtlOtANFaBGbdHCcRgNQyCxM8T4cRsPp8C7wiNcS+E1mPYd1GPL1XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682982; c=relaxed/simple;
	bh=3GNW++XKl95WXlMt6RbU0ejqYDQbQk3Js+5CesmOpMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KPX8zpdhDTqzRXuKz28AhTApicVJ9+MLr/z0aINkfCIo+wtryW7/CGdhg3MVdFfXPU9B0cV4+3nIZ1vSSbB+fituSxKnOHArJEt0srAFpoYdH1NflZ7THyuxtGiQobQmR4fo05v216ALyfB5W+F7LYyi7Dqu+qKhcAw0A2VdGTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=en/3qdV0; arc=fail smtp.client-ip=40.107.130.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBCtYKRv8TWA0eodcWe58SMooF6gs1KBspqQ3d2Mrxbbxg2zByICvzV7qV/EB2k6HrwtsqqVl26eUn6YIuyqMlRs+SKxivnfIYvKkVYoCx1a1X9tmp9zMYDqK+Fh29U299BejtT9yMtDQFv7EONLO8ZJspYPEQfEX2rS300FU1mR7fzmL9YF/71cNCOJh8jQTbH7THc5roGscs51+kp6XvULiAP5qpGT9CfABoWH+eJsvWeMED7gPxRizLGLlxm5KcDxqiCaAwfBZLUOe1Xea0kCbJ78V9MClNwfGQAAkKzwsLJW8iEnf8LzeTL3KHmOlrLshnFY7sKUHoJc/MQ3Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWbu/zBtj3FWdldgXZ88ZUIcH3qXSjMkfqsQUNmGoAg=;
 b=kyuVdBKgReXJpd32qdB+cwI7ms6JuxJmPbSDiPTDuuovztnvM8mbBZsflpy8t7o+HDjkOoZonnSH5pXifBG00gcpMxtjXGCwKBa/Iu/VADZD5NW5DT13959Dnmhm+n1hlVqhUM+gtXFOE8SOPF5CQYKZ7tgb9padl7sE0FM7TTe53X3Dtj4CZ3HwxwyKsVfPyzb990ph25JNXr+yWgy1Fl90lbEXteviipUOb9t5hJ5Pe5jLWfFjZjL5GFaNgDZuwcW+mE56N0Yk4F8L5qbswfYRpJS65JFU2zb35vRGMYDL5bWxH+vbOobjKe3FIqFLa1Nfjab9Ojg2vPTHNmK2mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWbu/zBtj3FWdldgXZ88ZUIcH3qXSjMkfqsQUNmGoAg=;
 b=en/3qdV0VuMDTrksKpDHRadWnJx4vmEn4rQldf7fqbZ8h/VxBt/YwDhcz1M+BvcoSGaL/Kg22lkSHKVzJWsB3MPEWA5Uqp2XW9HkOWhZoSZpE95KpA3MbgMr6V3XogUOIQUQ0GDbe0nS9Nv8GT0gB28Z/TMMlIV7J9aZU3Rw7dIKrO0zI49wfE9oBUh6fo+QK5mgETuCpaSIwI8Pou0q9HcIDHPeGdBIHTFL1OZ70hTIl+szs+dGkHs3Hq7qKX1c5qwYkWsKEqmjK2h8IM8X5S9choZyf3asqmHiMkhqKMuzRvAdcQezdtCjmBgFXaUFQLODhghva3wJmgpb2I5T9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10843.eurprd04.prod.outlook.com (2603:10a6:102:480::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:36:17 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 10:36:17 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v5 net-next 15/15] net: fec: add AF_XDP zero-copy support
Date: Thu, 29 Jan 2026 18:34:47 +0800
Message-Id: <20260129103447.1893129-16-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260129103447.1893129-1-wei.fang@nxp.com>
References: <20260129103447.1893129-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10843:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cfc07ff-8c6d-40f0-a5c4-08de5f223ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YbEYgUzNoFDV9UrM+zmqphK1kDmQoUpcTddlFNcmgNNRHDp4/OF2VWwk/xce?=
 =?us-ascii?Q?JGIh025+6Ae1Awpf6MHv9jNr+VAvplTbvkLHojG9Xr4+7td5q84O2iNU2W34?=
 =?us-ascii?Q?0sxu+pINYq4vk2bXABNBY4viME9tmzzm2LIK0VguSsAK9Cz8t/W+8K+ViX4w?=
 =?us-ascii?Q?XQ7xjM9HBEz18RJG9cO126k2OuZsw6guhcyHn7H8rbM6VuLF6lwOZWiU4c3S?=
 =?us-ascii?Q?dMdnDCqXf3iL5jte2W9hMNNir3ZVSd7eQIl0LjAPrlZaPM+Jfw/g5wS3RM+n?=
 =?us-ascii?Q?qmO7y3HogvBfXbm/n//apV1vDECvXC57WEb9oK/3evtSI8HNZfYqRmYcmP1k?=
 =?us-ascii?Q?uTPWymEFTxI9Mtg8HcmyLaQuZ/MVw/vumI6pQLgggw3ZetvKCsoEw8UAjg5K?=
 =?us-ascii?Q?i4XQg6tQ9ZYdGvX/TGcvU7tXRrUgFfHZOVNuQgplRoXPgG3uke55oBF3JrdP?=
 =?us-ascii?Q?Mqs6KuoqR5UwfohCLldVVpcmifg0OvvIXhABZW0HPUDSf7Iw7sXS8OgC8TtV?=
 =?us-ascii?Q?6ARKIMMhX6Tsedq6ui/WLA2f8Cs97qwwWQnY387lonfMI1559W9VkRtR/NYX?=
 =?us-ascii?Q?ZACT4EmBmejw2qAwUfU9wLM7n1uHZUy/rnLosTmpj75i3qC5vbXxfEUIHEn0?=
 =?us-ascii?Q?SLOzeLGC2Fpq6xCrHLKqHc1AJ2nb07WYmChDBpIGcyFQAvDJS4cnSAF9d9uT?=
 =?us-ascii?Q?v9E8gXSWu3HTIqkNH1sW2TaiAum59EVc+c+djm3sasQi9Jdlet6N8NK4XHIE?=
 =?us-ascii?Q?dF2Q2ST7UTN1zNHvnOShQfbC0x9pRFTwotzW2WEF4ABm3J2EdyZbZ7RIdeWV?=
 =?us-ascii?Q?WUkP09A+6n5EEF3Ya4MW0sOjusRwQqHhci4ALngocf+Xm+kmSwooXcu2vkgA?=
 =?us-ascii?Q?j32dd4RiOAWaezNnPzLy8x9jNIA9wfhp+H2a4w1TFVc6fCRDZ3wNwYYNymNp?=
 =?us-ascii?Q?aeC2wSDh4Ybabc4QI51PwhnGechNSIpehGJ4paydctwoTA5w0e5H31dX8S0/?=
 =?us-ascii?Q?UUaofng1x1H6TJbApClQGmvUEeUeyHG6u/W0Ymf304eXnR3kLDyP91jp61ZJ?=
 =?us-ascii?Q?HS8+W56Uw4TZEJ42H6dHay7wlmLyN43AWa/cgqVngsWKhVOYVDl2Z/RTI/0M?=
 =?us-ascii?Q?G2t6vF5WnkPuLrosCpDCrmIUdkojkzN4d+2euHr3ThNRepH+QBOYlpLW+gJX?=
 =?us-ascii?Q?CHBf8N1GU3BNHWnY3PgopdVQzMGqVnANft2FTLzOkMWFyeIU7bNiTs0T9EYc?=
 =?us-ascii?Q?6ApV4X3EX20P64eRto/16jVhKDah1NbJpzHbLR3+itCeQ13VD9eul6wh5fvu?=
 =?us-ascii?Q?2QOXNcho0Mr/INQbNo4ovmyEKBQV/RmyunpF7mEqme60nTsjdaMXayyGeNqc?=
 =?us-ascii?Q?Ef+ExBYw5TC1okDSnOsNLC4phQHKTn2kE2ErWkueyREEw4zP+0oGgsEqhzTD?=
 =?us-ascii?Q?jPIoapoOcfGhvLDHnJJLfYsE+rnfbamI1xBk6stfDWQYnqQVOcV7aRC9RVx4?=
 =?us-ascii?Q?E+D/07FVoUuE0i2WQaBi0L9INZxEcHJ07cyKtZsA7eQtYCC94kM3XuOiIGZb?=
 =?us-ascii?Q?FJp7UyYn5Hxx9lNknwjLmXa2lSgk1zLBxP0uWcAcOv8JccdfcoLxx7Hqvvvn?=
 =?us-ascii?Q?tD3oVDF5xfFv6Dkr0wuEsGqxr0LWZTJgZchAshhT1Xg+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tIqoBpK82X+cjGZdOx+5q5er+NzcQoh2OPgX5CKauRKeD5sZC2Z46ZGa0CLS?=
 =?us-ascii?Q?DnlGDhPJKz0mnteWZa8KrXv+oiSzyxHTRXklLZUi3uHLq6ECKIdje4GZ2y/W?=
 =?us-ascii?Q?uGpjiz395JENXQHoR2EOMaE9uEA/bXx1iLbaqBG2HTEOjCGrKHPbtqHSz0Lh?=
 =?us-ascii?Q?MT/I0uZvx7t8WKlTyOBDqe8YU3byEdbS/PmRzjHd71a4NcNoHqqGzUeIc1Xn?=
 =?us-ascii?Q?4yYRDwc1+knlNyI32I7YjbXhysqCTPsT8rbF2oRpekuoUR5OD0rp/JTQ5wXL?=
 =?us-ascii?Q?d0xqPVqJO/8DlIhNYptP0XROKFpCrwajxzlbiQcf2WznC04qZxjuq6Nl4SsY?=
 =?us-ascii?Q?O50qt4QMU9xpQNcmUa32/Q5T54mu5+0gsCxaLXndahA8++NeADSlnYPCudsq?=
 =?us-ascii?Q?Mhe4H+17OxWc5ZAKHZEe7mUAljJxcao+ukjTkYK5tD97AUWm5s0FsACgtC7/?=
 =?us-ascii?Q?UNDI+msgtRa7YEtQKvXWKH/AkXAFuy3Bo825MuC/XogPo5JaHdRmom7P9+q7?=
 =?us-ascii?Q?jF9km+5e5LTS6Qc13aHqSfYeD6rkxxwwqZCtwLiZZfaB7iHrb+pdmO6BCdpt?=
 =?us-ascii?Q?qEDAKIUSoBIrBN4fwSu7N6L1UUUrCjfl8KnzlEP2pYxUm4H3q5hyXK7y7QSq?=
 =?us-ascii?Q?fE+7j8HbrI7zG/dYCMy52/duH09A3GyS/6P06Y8I/eiesNBR6mjrU8PRhBZr?=
 =?us-ascii?Q?rplpwWd2M+3yte0n0DipxtizN/9wU1vpt4vcdYpaU13QI5pZnOBC/sZ7nmwj?=
 =?us-ascii?Q?VrubPFs3NjOBOC6aFlQ/5cD0NebObBwRaAqV0D5alqXHNxIcPZXYdfsEXas+?=
 =?us-ascii?Q?Lkku7iBwYyHFiMq9adYVT2qFMOuQTLH4ZihNiuCX/NzQ6y9w7KIF4KplLnQD?=
 =?us-ascii?Q?G6qA7uHfg9qddpOvbFcaRdKnGLx9Bpqg6vL25F0L3BvFC7ZGxQkfsAptmd8u?=
 =?us-ascii?Q?Ia10YJpwybSNmAVpFV+ZAWBEcuEbnl1pOaYAxmNB/u5aQIgMh0NkejG+ysWE?=
 =?us-ascii?Q?SzP/aQIa5JZhqNF8kXQ7eqJ9zXq4h8wLike8mCglEKQmizwavCBtEABnoh6V?=
 =?us-ascii?Q?3W+O+A2Iykex+u8zDgLBassuKoCNbC3V6UXdR8I2WDXtkUDX+XRsdE93NiyZ?=
 =?us-ascii?Q?mNoy6vQ+GjZNm6kmFx7fWl0R7QjM2adOjUCzfAFe21W1FM4E+eHA2AoZu8Vr?=
 =?us-ascii?Q?Qxu237upI1Ov7YQfPNsuNIoRAYpuf9rNX0c8h858WcuJfoAh8QEJxhUN2M3d?=
 =?us-ascii?Q?dx85AWealLcnDOJbxOaXz6bq41s7yeBlzCvBCRQNHLnoQ2izgGxVOrT2peEI?=
 =?us-ascii?Q?6zRmdvOyTO7xAmnai5Mg49kxLztbSg2d9YL4YgGyvX+FiIu9PDFqVNKOnljw?=
 =?us-ascii?Q?Yg6cUOGmP4yqspkBvwad8/fS8NpjIHGBNn7bYe1V0y7J0n5rUC8c+WDRWN9u?=
 =?us-ascii?Q?XEEkItC2Cl0lLPRv27HjWnFOmXwmjO8LePvx9UiAP2LHlq0LPpV0mA1PjBBA?=
 =?us-ascii?Q?vXpQvrogORADelwVbr1mtgcIcTxyhEBwtjG2XtKy9F84+UhGUsTAnitXeqyr?=
 =?us-ascii?Q?XjHPSLJ2fI52uDHudCHG0DB7TARStmmiKP+3cIfCy7uJNkHWq2n58G+tl9yz?=
 =?us-ascii?Q?7uLWbxa5fAlG0UvssEGT/MOMXYDWTgLVGYGdYp9B1+SFw+KNtH6Nv30gKeV0?=
 =?us-ascii?Q?fPhmQl3Zg2zxOWnkxVAudlVqbGU0p51JgDTqcU2hR0BpFOjbINtb2o2gzNWv?=
 =?us-ascii?Q?JLJTMtBG6Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfc07ff-8c6d-40f0-a5c4-08de5f223ba6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:36:17.0272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbtbeY9Pcbd+169gcbljLaeyPHjCNFL/aRSWyqJ8GCTjOjRmpOizy0tLnh46kyFnsVt/9cbRa0wXjlMEUqC97Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10843
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254734-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,eth0:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,imx93evk:email]
X-Rspamd-Queue-Id: 6F34BAF093
X-Rspamd-Action: no action

Add AF_XDP zero-copy support for both TX and RX.

For RX, instead of allocating buffers from the page pool, the buffers
are allocated from xsk pool, so fec_alloc_rxq_buffers_zc() is added to
allocate RX buffers from xsk pool. And fec_enet_rx_queue_xsk() is used
to process the frames from the RX queue which is bound to the AF_XDP
socket. Similar to the XDP copy mode, the zero-copy mode also supports
XDP_TX, XDP_PASS, XDP_DROP and XDP_REDIRECT actions. In addition,
fec_enet_xsk_tx_xmit() is similar to fec_enet_xdp_tx_xmit() and is used
to handle XDP_TX action in zero-copy mode.

For TX, there are two cases, one is the frames from the AF_XDP socket,
so fec_enet_xsk_xmit() is added to directly transmit the frames from
the socket and the buffer type is marked as FEC_TXBUF_T_XSK_XMIT. The
other one is the frams from the RX queue (XDP_TX action), the buffer
type is marked as FEC_TXBUF_T_XSK_TX. Therefore, fec_enet_tx_queue()
could correctly clean the TX queue base on the buffer type.

Also, some tests have been done on the i.MX93-EVK board with the xdpsock
tool, the following are the results.

Env: i.MX93 connects to a packet generator, the link speed is 1Gbps, and
flow-control is off. The RX packet size is 64 bytes including FCS. Only
one RX queue (CPU) is used to receive frames.

1. MAC swap L2 forwarding
1.1 Zero-copy mode
root@imx93evk:~# ./xdpsock -i eth0 -l -z
 sock0@eth0:0 l2fwd xdp-drv
                   pps            pkts           1.00
rx                 414715         415455
tx                 414715         415455

1.2 Copy mode
root@imx93evk:~# ./xdpsock -i eth0 -l -c
 sock0@eth0:0 l2fwd xdp-drv
                   pps            pkts           1.00
rx                 356396         356609
tx                 356396         356609

2. TX only
2.1 Zero-copy mode
root@imx93evk:~# ./xdpsock -i eth0 -t -s 64 -z
 sock0@eth0:0 txonly xdp-drv
                   pps            pkts           1.00
rx                 0              0
tx                 1119573        1126720

2.2 Copy mode
root@imx93evk:~# ./xdpsock -i eth0 -t -s 64 -c
sock0@eth0:0 txonly xdp-drv
                   pps            pkts           1.00
rx                 0              0
tx                 406864         407616

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  13 +-
 drivers/net/ethernet/freescale/fec_main.c | 779 ++++++++++++++++++++--
 2 files changed, 748 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index ad7aba1a8536..7176803146f3 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -340,6 +340,7 @@ struct bufdesc_ex {
 #define FEC_ENET_TX_FRPPG	(PAGE_SIZE / FEC_ENET_TX_FRSIZE)
 #define TX_RING_SIZE		1024	/* Must be power of two */
 #define TX_RING_MOD_MASK	511	/*   for this to work */
+#define FEC_XSK_TX_BUDGET_MAX	256
 
 #define BD_ENET_RX_INT		0x00800000
 #define BD_ENET_RX_PTP		((ushort)0x0400)
@@ -528,6 +529,8 @@ enum fec_txbuf_type {
 	FEC_TXBUF_T_SKB,
 	FEC_TXBUF_T_XDP_NDO,
 	FEC_TXBUF_T_XDP_TX,
+	FEC_TXBUF_T_XSK_XMIT,
+	FEC_TXBUF_T_XSK_TX,
 };
 
 struct fec_tx_buffer {
@@ -539,6 +542,7 @@ struct fec_enet_priv_tx_q {
 	struct bufdesc_prop bd;
 	unsigned char *tx_bounce[TX_RING_SIZE];
 	struct fec_tx_buffer tx_buf[TX_RING_SIZE];
+	struct xsk_buff_pool *xsk_pool;
 
 	unsigned short tx_stop_threshold;
 	unsigned short tx_wake_threshold;
@@ -548,9 +552,16 @@ struct fec_enet_priv_tx_q {
 	dma_addr_t tso_hdrs_dma;
 };
 
+union fec_rx_buffer {
+	void *buf_p;
+	struct page *page;
+	struct xdp_buff *xdp;
+};
+
 struct fec_enet_priv_rx_q {
 	struct bufdesc_prop bd;
-	struct page *rx_buf[RX_RING_SIZE];
+	union fec_rx_buffer rx_buf[RX_RING_SIZE];
+	struct xsk_buff_pool *xsk_pool;
 
 	/* page_pool */
 	struct page_pool *page_pool;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 10a02fde3887..94ee71958f35 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -71,6 +71,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/selftests.h>
 #include <net/tso.h>
+#include <net/xdp_sock_drv.h>
 #include <soc/imx/cpuidle.h>
 
 #include "fec.h"
@@ -1041,6 +1042,9 @@ static void fec_enet_bd_init(struct net_device *dev)
 				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
 						   page, 0, false);
 				break;
+			case FEC_TXBUF_T_XSK_TX:
+				xsk_buff_free(txq->tx_buf[i].buf_p);
+				break;
 			default:
 				break;
 			}
@@ -1475,8 +1479,91 @@ fec_enet_hwtstamp(struct fec_enet_private *fep, unsigned ts,
 	hwtstamps->hwtstamp = ns_to_ktime(ns);
 }
 
-static void fec_enet_tx_queue(struct fec_enet_private *fep,
-			      u16 queue, int budget)
+static bool fec_enet_xsk_xmit(struct fec_enet_private *fep,
+			      struct xsk_buff_pool *pool,
+			      u32 queue)
+{
+	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+	struct xdp_desc *xsk_desc = pool->tx_descs;
+	int cpu = smp_processor_id();
+	int free_bds, budget, batch;
+	struct netdev_queue *nq;
+	struct bufdesc *bdp;
+	dma_addr_t dma;
+	u32 estatus;
+	u16 status;
+	int i, j;
+
+	nq = netdev_get_tx_queue(fep->netdev, queue);
+	__netif_tx_lock(nq, cpu);
+
+	txq_trans_cond_update(nq);
+	free_bds = fec_enet_get_free_txdesc_num(txq);
+	if (!free_bds)
+		goto tx_unlock;
+
+	budget = min(free_bds, FEC_XSK_TX_BUDGET_MAX);
+	batch = xsk_tx_peek_release_desc_batch(pool, budget);
+	if (!batch)
+		goto tx_unlock;
+
+	bdp = txq->bd.cur;
+	for (i = 0; i < batch; i++) {
+		dma = xsk_buff_raw_get_dma(pool, xsk_desc[i].addr);
+		xsk_buff_raw_dma_sync_for_device(pool, dma, xsk_desc[i].len);
+
+		j = fec_enet_get_bd_index(bdp, &txq->bd);
+		txq->tx_buf[j].type = FEC_TXBUF_T_XSK_XMIT;
+		txq->tx_buf[j].buf_p = NULL;
+
+		status = fec16_to_cpu(bdp->cbd_sc);
+		status &= ~BD_ENET_TX_STATS;
+		status |= BD_ENET_TX_INTR | BD_ENET_TX_LAST;
+		bdp->cbd_datlen = cpu_to_fec16(xsk_desc[i].len);
+		bdp->cbd_bufaddr = cpu_to_fec32(dma);
+
+		if (fep->bufdesc_ex) {
+			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+			estatus = BD_ENET_TX_INT;
+			if (fep->quirks & FEC_QUIRK_HAS_AVB)
+				estatus |= FEC_TX_BD_FTYPE(txq->bd.qid);
+
+			ebdp->cbd_bdu = 0;
+			ebdp->cbd_esc = cpu_to_fec32(estatus);
+		}
+
+		/* Make sure the updates to rest of the descriptor are performed
+		 * before transferring ownership.
+		 */
+		dma_wmb();
+
+		/* Send it on its way.  Tell FEC it's ready, interrupt when done,
+		 * it's the last BD of the frame, and to put the CRC on the end.
+		 */
+		status |= BD_ENET_TX_READY | BD_ENET_TX_TC;
+		bdp->cbd_sc = cpu_to_fec16(status);
+		dma_wmb();
+
+		bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
+		txq->bd.cur = bdp;
+	}
+
+	/* Trigger transmission start */
+	fec_txq_trigger_xmit(fep, txq);
+
+	__netif_tx_unlock(nq);
+
+	return batch < budget;
+
+tx_unlock:
+	__netif_tx_unlock(nq);
+
+	return true;
+}
+
+static int fec_enet_tx_queue(struct fec_enet_private *fep,
+			     u16 queue, int budget)
 {
 	struct netdev_queue *nq = netdev_get_tx_queue(fep->netdev, queue);
 	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
@@ -1487,6 +1574,7 @@ static void fec_enet_tx_queue(struct fec_enet_private *fep,
 	unsigned short status;
 	struct sk_buff *skb;
 	struct page *page;
+	int xsk_cnt = 0;
 
 	/* get next bdp of dirty_tx */
 	bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
@@ -1560,6 +1648,14 @@ static void fec_enet_tx_queue(struct fec_enet_private *fep,
 			page_pool_put_page(pp_page_to_nmdesc(page)->pp, page,
 					   0, true);
 			break;
+		case FEC_TXBUF_T_XSK_XMIT:
+			bdp->cbd_bufaddr = cpu_to_fec32(0);
+			xsk_cnt++;
+			break;
+		case FEC_TXBUF_T_XSK_TX:
+			bdp->cbd_bufaddr = cpu_to_fec32(0);
+			xsk_buff_free(tx_buf->buf_p);
+			break;
 		default:
 			break;
 		}
@@ -1619,16 +1715,37 @@ static void fec_enet_tx_queue(struct fec_enet_private *fep,
 	if (bdp != txq->bd.cur &&
 	    readl(txq->bd.reg_desc_active) == 0)
 		writel(0, txq->bd.reg_desc_active);
+
+	if (txq->xsk_pool) {
+		struct xsk_buff_pool *pool = txq->xsk_pool;
+
+		if (xsk_cnt)
+			xsk_tx_completed(pool, xsk_cnt);
+
+		if (xsk_uses_need_wakeup(pool))
+			xsk_set_tx_need_wakeup(pool);
+
+		/* If the condition is true, it indicates that there are still
+		 * packets to be transmitted, so return "budget" to make the
+		 * NAPI continue polling.
+		 */
+		if (!fec_enet_xsk_xmit(fep, pool, queue))
+			return budget;
+	}
+
+	return 0;
 }
 
-static void fec_enet_tx(struct net_device *ndev, int budget)
+static int fec_enet_tx(struct net_device *ndev, int budget)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	int i;
+	int i, count = 0;
 
 	/* Make sure that AVB queues are processed first. */
 	for (i = fep->num_tx_queues - 1; i >= 0; i--)
-		fec_enet_tx_queue(fep, i, budget);
+		count += fec_enet_tx_queue(fep, i, budget);
+
+	return count;
 }
 
 static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
@@ -1641,13 +1758,30 @@ static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
 	if (unlikely(!new_page))
 		return -ENOMEM;
 
-	rxq->rx_buf[index] = new_page;
+	rxq->rx_buf[index].page = new_page;
 	phys_addr = page_pool_get_dma_addr(new_page) + FEC_ENET_XDP_HEADROOM;
 	bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
 
 	return 0;
 }
 
+static int fec_enet_update_cbd_zc(struct fec_enet_priv_rx_q *rxq,
+				  struct bufdesc *bdp, int index)
+{
+	struct xdp_buff *new_xdp;
+	dma_addr_t phys_addr;
+
+	new_xdp = xsk_buff_alloc(rxq->xsk_pool);
+	if (unlikely(!new_xdp))
+		return -ENOMEM;
+
+	rxq->rx_buf[index].xdp = new_xdp;
+	phys_addr = xsk_buff_xdp_get_dma(new_xdp);
+	bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
+
+	return 0;
+}
+
 static void fec_enet_rx_vlan(const struct net_device *ndev, struct sk_buff *skb)
 {
 	if (ndev->features & NETIF_F_HW_VLAN_CTAG_RX) {
@@ -1802,7 +1936,7 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
-		page = rxq->rx_buf[index];
+		page = rxq->rx_buf[index].page;
 		dma = fec32_to_cpu(bdp->cbd_bufaddr);
 		if (fec_enet_update_cbd(rxq, bdp, index)) {
 			ndev->stats.rx_dropped++;
@@ -1932,7 +2066,7 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
-		page = rxq->rx_buf[index];
+		page = rxq->rx_buf[index].page;
 		dma = fec32_to_cpu(bdp->cbd_bufaddr);
 
 		if (fec_enet_update_cbd(rxq, bdp, index)) {
@@ -2047,6 +2181,268 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 	return pkt_received;
 }
 
+static struct sk_buff *fec_build_skb_zc(struct xdp_buff *xsk,
+					struct napi_struct *napi)
+{
+	size_t len = xdp_get_buff_len(xsk);
+	struct sk_buff *skb;
+
+	skb = napi_alloc_skb(napi, len);
+	if (unlikely(!skb)) {
+		xsk_buff_free(xsk);
+		return NULL;
+	}
+
+	skb_put_data(skb, xsk->data, len);
+	xsk_buff_free(xsk);
+
+	return skb;
+}
+
+static int fec_enet_xsk_tx_xmit(struct fec_enet_private *fep,
+				struct xdp_buff *xsk, int cpu,
+				int queue)
+{
+	struct netdev_queue *nq = netdev_get_tx_queue(fep->netdev, queue);
+	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+	u32 offset = xsk->data - xsk->data_hard_start;
+	u32 headroom = txq->xsk_pool->headroom;
+	u32 len = xsk->data_end - xsk->data;
+	u32 index, status, estatus;
+	struct bufdesc *bdp;
+	dma_addr_t dma;
+
+	__netif_tx_lock(nq, cpu);
+
+	/* Avoid tx timeout as XDP shares the queue with kernel stack */
+	txq_trans_cond_update(nq);
+
+	if (!fec_enet_get_free_txdesc_num(txq)) {
+		__netif_tx_unlock(nq);
+
+		return -EBUSY;
+	}
+
+	/* Fill in a Tx ring entry */
+	bdp = txq->bd.cur;
+	status = fec16_to_cpu(bdp->cbd_sc);
+	status &= ~BD_ENET_TX_STATS;
+
+	index = fec_enet_get_bd_index(bdp, &txq->bd);
+	dma = xsk_buff_xdp_get_frame_dma(xsk) + headroom + offset;
+
+	xsk_buff_raw_dma_sync_for_device(txq->xsk_pool, dma, len);
+
+	txq->tx_buf[index].buf_p = xsk;
+	txq->tx_buf[index].type = FEC_TXBUF_T_XSK_TX;
+
+	status |= (BD_ENET_TX_INTR | BD_ENET_TX_LAST);
+	if (fep->bufdesc_ex)
+		estatus = BD_ENET_TX_INT;
+
+	bdp->cbd_bufaddr = cpu_to_fec32(dma);
+	bdp->cbd_datlen = cpu_to_fec16(len);
+
+	if (fep->bufdesc_ex) {
+		struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+		if (fep->quirks & FEC_QUIRK_HAS_AVB)
+			estatus |= FEC_TX_BD_FTYPE(txq->bd.qid);
+
+		ebdp->cbd_bdu = 0;
+		ebdp->cbd_esc = cpu_to_fec32(estatus);
+	}
+
+	status |= (BD_ENET_TX_READY | BD_ENET_TX_TC);
+	bdp->cbd_sc = cpu_to_fec16(status);
+	dma_wmb();
+
+	bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
+	txq->bd.cur = bdp;
+
+	__netif_tx_unlock(nq);
+
+	return 0;
+}
+
+static int fec_enet_rx_queue_xsk(struct fec_enet_private *fep, int queue,
+				 int budget, struct bpf_prog *prog)
+{
+	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
+	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc *bdp = rxq->bd.cur;
+	u32 sub_len = 4 + fep->rx_shift;
+	int cpu = smp_processor_id();
+	bool wakeup_xsk = false;
+	struct xdp_buff *xsk;
+	int pkt_received = 0;
+	struct sk_buff *skb;
+	u16 status, pkt_len;
+	u32 xdp_res = 0;
+	int index, err;
+	u32 act;
+
+#if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
+	/*
+	 * Hacky flush of all caches instead of using the DMA API for the TSO
+	 * headers.
+	 */
+	flush_cache_all();
+#endif
+
+	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
+		if (unlikely(pkt_received >= budget))
+			break;
+
+		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
+
+		index = fec_enet_get_bd_index(bdp, &rxq->bd);
+		xsk = rxq->rx_buf[index].xdp;
+		if (unlikely(!xsk)) {
+			if (fec_enet_update_cbd_zc(rxq, bdp, index))
+				break;
+
+			if (fep->bufdesc_ex) {
+				struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+				ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
+				ebdp->cbd_prot = 0;
+				ebdp->cbd_bdu = 0;
+			}
+
+			dma_wmb();
+			status &= ~BD_ENET_RX_STATS;
+			status |= BD_ENET_RX_EMPTY;
+			bdp->cbd_sc = cpu_to_fec16(status);
+			break;
+		}
+
+		pkt_received++;
+		/* Check for errors. */
+		status ^= BD_ENET_RX_LAST;
+		if (unlikely(fec_rx_error_check(ndev, status)))
+			goto rx_processing_done;
+
+		/* Process the incoming frame. */
+		ndev->stats.rx_packets++;
+		pkt_len = fec16_to_cpu(bdp->cbd_datlen);
+		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
+
+		if (fec_enet_update_cbd_zc(rxq, bdp, index)) {
+			ndev->stats.rx_dropped++;
+			goto rx_processing_done;
+		}
+
+		pkt_len -= sub_len;
+		xsk->data = xsk->data_hard_start + data_start;
+		/* Subtract FCS and 16bit shift */
+		xsk->data_end = xsk->data + pkt_len;
+		xsk->data_meta = xsk->data;
+		xsk_buff_dma_sync_for_cpu(xsk);
+
+		/* If the XSK pool is enabled before the bpf program is
+		 * installed, or the bpf program is uninstalled before
+		 * the XSK pool is disabled. prog will be NULL and we
+		 * need to set a default XDP_PASS action.
+		 */
+		if (unlikely(!prog))
+			act = XDP_PASS;
+		else
+			act = bpf_prog_run_xdp(prog, xsk);
+
+		switch (act) {
+		case XDP_PASS:
+			rxq->stats[RX_XDP_PASS]++;
+			skb = fec_build_skb_zc(xsk, &fep->napi);
+			if (unlikely(!skb))
+				ndev->stats.rx_dropped++;
+			else
+				napi_gro_receive(&fep->napi, skb);
+			break;
+		case XDP_TX:
+			rxq->stats[RX_XDP_TX]++;
+			err = fec_enet_xsk_tx_xmit(fep, xsk, cpu, queue);
+			if (unlikely(err)) {
+				rxq->stats[RX_XDP_TX_ERRORS]++;
+				xsk_buff_free(xsk);
+			} else {
+				xdp_res |= FEC_ENET_XDP_TX;
+			}
+			break;
+		case XDP_REDIRECT:
+			rxq->stats[RX_XDP_REDIRECT]++;
+			err = xdp_do_redirect(ndev, xsk, prog);
+			if (unlikely(err)) {
+				if (err == -ENOBUFS)
+					wakeup_xsk = true;
+
+				rxq->stats[RX_XDP_DROP]++;
+				xsk_buff_free(xsk);
+			} else {
+				xdp_res |= FEC_ENET_XDP_REDIR;
+			}
+			break;
+		default:
+			bpf_warn_invalid_xdp_action(ndev, prog, act);
+			fallthrough;
+		case XDP_ABORTED:
+			trace_xdp_exception(ndev, prog, act);
+			fallthrough;
+		case XDP_DROP:
+			rxq->stats[RX_XDP_DROP]++;
+			xsk_buff_free(xsk);
+			break;
+		}
+
+rx_processing_done:
+		/* Clear the status flags for this buffer */
+		status &= ~BD_ENET_RX_STATS;
+		/* Mark the buffer empty */
+		status |= BD_ENET_RX_EMPTY;
+
+		if (fep->bufdesc_ex) {
+			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
+			ebdp->cbd_prot = 0;
+			ebdp->cbd_bdu = 0;
+		}
+
+		/* Make sure the updates to rest of the descriptor are
+		 * performed before transferring ownership.
+		 */
+		dma_wmb();
+		bdp->cbd_sc = cpu_to_fec16(status);
+
+		/* Update BD pointer to next entry */
+		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
+
+		/* Doing this here will keep the FEC running while we process
+		 * incoming frames. On a heavily loaded network, we should be
+		 * able to keep up at the expense of system resources.
+		 */
+		writel(0, rxq->bd.reg_desc_active);
+	}
+
+	rxq->bd.cur = bdp;
+
+	if (xdp_res & FEC_ENET_XDP_REDIR)
+		xdp_do_flush();
+
+	if (xdp_res & FEC_ENET_XDP_TX)
+		fec_txq_trigger_xmit(fep, fep->tx_queue[queue]);
+
+	if (rxq->xsk_pool && xsk_uses_need_wakeup(rxq->xsk_pool)) {
+		if (wakeup_xsk)
+			xsk_set_rx_need_wakeup(rxq->xsk_pool);
+		else
+			xsk_clear_rx_need_wakeup(rxq->xsk_pool);
+	}
+
+	return pkt_received;
+}
+
 static int fec_enet_rx(struct net_device *ndev, int budget)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -2055,11 +2451,15 @@ static int fec_enet_rx(struct net_device *ndev, int budget)
 
 	/* Make sure that AVB queues are processed first. */
 	for (i = fep->num_rx_queues - 1; i >= 0; i--) {
-		if (prog)
-			done += fec_enet_rx_queue_xdp(fep, i, budget - done,
-						      prog);
+		struct fec_enet_priv_rx_q *rxq = fep->rx_queue[i];
+		int batch = budget - done;
+
+		if (rxq->xsk_pool)
+			done += fec_enet_rx_queue_xsk(fep, i, batch, prog);
+		else if (prog)
+			done += fec_enet_rx_queue_xdp(fep, i, batch, prog);
 		else
-			done += fec_enet_rx_queue(fep, i, budget - done);
+			done += fec_enet_rx_queue(fep, i, batch);
 	}
 
 	return done;
@@ -2103,19 +2503,22 @@ static int fec_enet_rx_napi(struct napi_struct *napi, int budget)
 {
 	struct net_device *ndev = napi->dev;
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	int done = 0;
+	int rx_done = 0, tx_done = 0;
+	int max_done;
 
 	do {
-		done += fec_enet_rx(ndev, budget - done);
-		fec_enet_tx(ndev, budget);
-	} while ((done < budget) && fec_enet_collect_events(fep));
+		rx_done += fec_enet_rx(ndev, budget - rx_done);
+		tx_done += fec_enet_tx(ndev, budget);
+		max_done = max(rx_done, tx_done);
+	} while ((max_done < budget) && fec_enet_collect_events(fep));
 
-	if (done < budget) {
-		napi_complete_done(napi, done);
+	if (max_done < budget) {
+		napi_complete_done(napi, max_done);
 		writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
+		return max_done;
 	}
 
-	return done;
+	return budget;
 }
 
 /* ------------------------------------------------------------------------- */
@@ -3406,7 +3809,8 @@ static int fec_xdp_rxq_info_reg(struct fec_enet_private *fep,
 				struct fec_enet_priv_rx_q *rxq)
 {
 	struct net_device *ndev = fep->netdev;
-	int err;
+	void *allocator;
+	int type, err;
 
 	err = xdp_rxq_info_reg(&rxq->xdp_rxq, ndev, rxq->id, 0);
 	if (err) {
@@ -3414,8 +3818,9 @@ static int fec_xdp_rxq_info_reg(struct fec_enet_private *fep,
 		return err;
 	}
 
-	err = xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, MEM_TYPE_PAGE_POOL,
-					 rxq->page_pool);
+	allocator = rxq->xsk_pool ? NULL : rxq->page_pool;
+	type = rxq->xsk_pool ? MEM_TYPE_XSK_BUFF_POOL : MEM_TYPE_PAGE_POOL;
+	err = xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, type, allocator);
 	if (err) {
 		netdev_err(ndev, "Failed to register XDP mem model\n");
 		xdp_rxq_info_unreg(&rxq->xdp_rxq);
@@ -3423,6 +3828,9 @@ static int fec_xdp_rxq_info_reg(struct fec_enet_private *fep,
 		return err;
 	}
 
+	if (rxq->xsk_pool)
+		xsk_pool_set_rxq_info(rxq->xsk_pool, &rxq->xdp_rxq);
+
 	return 0;
 }
 
@@ -3436,20 +3844,28 @@ static void fec_xdp_rxq_info_unreg(struct fec_enet_priv_rx_q *rxq)
 
 static void fec_free_rxq_buffers(struct fec_enet_priv_rx_q *rxq)
 {
+	bool xsk = !!rxq->xsk_pool;
 	int i;
 
 	for (i = 0; i < rxq->bd.ring_size; i++) {
-		struct page *page = rxq->rx_buf[i];
+		union fec_rx_buffer *buf = &rxq->rx_buf[i];
 
-		if (!page)
+		if (!buf->buf_p)
 			continue;
 
-		page_pool_put_full_page(rxq->page_pool, page, false);
-		rxq->rx_buf[i] = NULL;
+		if (xsk)
+			xsk_buff_free(buf->xdp);
+		else
+			page_pool_put_full_page(rxq->page_pool,
+						buf->page, false);
+
+		rxq->rx_buf[i].buf_p = NULL;
 	}
 
-	page_pool_destroy(rxq->page_pool);
-	rxq->page_pool = NULL;
+	if (!xsk) {
+		page_pool_destroy(rxq->page_pool);
+		rxq->page_pool = NULL;
+	}
 }
 
 static void fec_enet_free_buffers(struct net_device *ndev)
@@ -3489,6 +3905,9 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 				page_pool_put_page(pp_page_to_nmdesc(page)->pp,
 						   page, 0, false);
 				break;
+			case FEC_TXBUF_T_XSK_TX:
+				xsk_buff_free(txq->tx_buf[i].buf_p);
+				break;
 			default:
 				break;
 			}
@@ -3604,7 +4023,7 @@ static int fec_alloc_rxq_buffers_pp(struct fec_enet_private *fep,
 
 		phys_addr = page_pool_get_dma_addr(page) + FEC_ENET_XDP_HEADROOM;
 		bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
-		rxq->rx_buf[i] = page;
+		rxq->rx_buf[i].page = page;
 		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
 	}
 
@@ -3616,6 +4035,33 @@ static int fec_alloc_rxq_buffers_pp(struct fec_enet_private *fep,
 	return err;
 }
 
+static int fec_alloc_rxq_buffers_zc(struct fec_enet_private *fep,
+				    struct fec_enet_priv_rx_q *rxq)
+{
+	union fec_rx_buffer *buf = &rxq->rx_buf[0];
+	struct bufdesc *bdp = rxq->bd.base;
+	dma_addr_t phys_addr;
+	int i;
+
+	for (i = 0; i < rxq->bd.ring_size; i++) {
+		buf[i].xdp = xsk_buff_alloc(rxq->xsk_pool);
+		if (!buf[i].xdp)
+			break;
+
+		phys_addr = xsk_buff_xdp_get_dma(buf[i].xdp);
+		bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
+		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
+	}
+
+	for (; i < rxq->bd.ring_size; i++) {
+		buf[i].xdp = NULL;
+		bdp->cbd_bufaddr = cpu_to_fec32(0);
+		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
+	}
+
+	return 0;
+}
+
 static int
 fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 {
@@ -3624,9 +4070,16 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 	int err;
 
 	rxq = fep->rx_queue[queue];
-	err = fec_alloc_rxq_buffers_pp(fep, rxq);
-	if (err)
-		goto free_buffers;
+	if (rxq->xsk_pool) {
+		/* RX XDP ZC buffer pool may not be populated, e.g.
+		 * xdpsock TX-only.
+		 */
+		fec_alloc_rxq_buffers_zc(fep, rxq);
+	} else {
+		err = fec_alloc_rxq_buffers_pp(fep, rxq);
+		if (err)
+			goto free_buffers;
+	}
 
 	err = fec_xdp_rxq_info_reg(fep, rxq);
 	if (err)
@@ -3951,21 +4404,237 @@ static u16 fec_enet_select_queue(struct net_device *ndev, struct sk_buff *skb,
 	return fec_enet_vlan_pri_to_queue[vlan_tag >> 13];
 }
 
+static void fec_free_rxq(struct fec_enet_priv_rx_q *rxq)
+{
+	fec_xdp_rxq_info_unreg(rxq);
+	fec_free_rxq_buffers(rxq);
+	kfree(rxq);
+}
+
+static struct fec_enet_priv_rx_q *
+fec_alloc_new_rxq_xsk(struct fec_enet_private *fep, int queue,
+		      struct xsk_buff_pool *pool)
+{
+	struct fec_enet_priv_rx_q *old_rxq = fep->rx_queue[queue];
+	struct fec_enet_priv_rx_q *rxq;
+	union fec_rx_buffer *buf;
+	int i;
+
+	rxq = kzalloc(sizeof(*rxq), GFP_KERNEL);
+	if (!rxq)
+		return NULL;
+
+	/* Copy the BD ring to the new rxq */
+	rxq->bd = old_rxq->bd;
+	rxq->id = queue;
+	rxq->xsk_pool = pool;
+	buf = &rxq->rx_buf[0];
+
+	for (i = 0; i < rxq->bd.ring_size; i++) {
+		buf[i].xdp = xsk_buff_alloc(pool);
+		/* RX XDP ZC buffer pool may not be populated, e.g.
+		 * xdpsock TX-only.
+		 */
+		if (!buf[i].xdp)
+			break;
+	}
+
+	if (fec_xdp_rxq_info_reg(fep, rxq))
+		goto free_buffers;
+
+	return rxq;
+
+free_buffers:
+	while (--i >= 0)
+		xsk_buff_free(buf[i].xdp);
+
+	kfree(rxq);
+
+	return NULL;
+}
+
+static struct fec_enet_priv_rx_q *
+fec_alloc_new_rxq_pp(struct fec_enet_private *fep, int queue)
+{
+	struct fec_enet_priv_rx_q *old_rxq = fep->rx_queue[queue];
+	struct fec_enet_priv_rx_q *rxq;
+	union fec_rx_buffer *buf;
+	int i = 0;
+
+	rxq = kzalloc(sizeof(*rxq), GFP_KERNEL);
+	if (!rxq)
+		return NULL;
+
+	rxq->bd = old_rxq->bd;
+	rxq->id = queue;
+
+	if (fec_enet_create_page_pool(fep, rxq))
+		goto free_rxq;
+
+	buf = &rxq->rx_buf[0];
+	for (; i < rxq->bd.ring_size; i++) {
+		buf[i].page = page_pool_dev_alloc_pages(rxq->page_pool);
+		if (!buf[i].page)
+			goto free_buffers;
+	}
+
+	if (fec_xdp_rxq_info_reg(fep, rxq))
+		goto free_buffers;
+
+	return rxq;
+
+free_buffers:
+	while (--i >= 0)
+		page_pool_put_full_page(rxq->page_pool,
+					buf[i].page, false);
+
+	page_pool_destroy(rxq->page_pool);
+free_rxq:
+	kfree(rxq);
+
+	return NULL;
+}
+
+static void fec_init_rxq_bd_buffers(struct fec_enet_priv_rx_q *rxq, bool xsk)
+{
+	union fec_rx_buffer *buf = &rxq->rx_buf[0];
+	struct bufdesc *bdp = rxq->bd.base;
+	dma_addr_t dma;
+
+	for (int i = 0; i < rxq->bd.ring_size; i++) {
+		if (xsk)
+			dma = buf[i].xdp ?
+			      xsk_buff_xdp_get_dma(buf[i].xdp) : 0;
+		else
+			dma = page_pool_get_dma_addr(buf[i].page) +
+			      FEC_ENET_XDP_HEADROOM;
+
+		bdp->cbd_bufaddr = cpu_to_fec32(dma);
+		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
+	}
+}
+
+static int fec_xsk_restart_napi(struct fec_enet_private *fep,
+				struct xsk_buff_pool *pool,
+				u16 queue)
+{
+	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+	struct net_device *ndev = fep->netdev;
+	struct fec_enet_priv_rx_q *rxq;
+	int err;
+
+	napi_disable(&fep->napi);
+	netif_tx_disable(ndev);
+	synchronize_rcu();
+
+	rxq = pool ? fec_alloc_new_rxq_xsk(fep, queue, pool) :
+		     fec_alloc_new_rxq_pp(fep, queue);
+	if (!rxq) {
+		err = -ENOMEM;
+		goto err_alloc_new_rxq;
+	}
+
+	/* Replace the old rxq with the new rxq */
+	fec_free_rxq(fep->rx_queue[queue]);
+	fep->rx_queue[queue] = rxq;
+	fec_init_rxq_bd_buffers(rxq, !!pool);
+	txq->xsk_pool = pool;
+
+	fec_restart(ndev);
+	napi_enable(&fep->napi);
+	netif_tx_start_all_queues(ndev);
+
+	return 0;
+
+err_alloc_new_rxq:
+	napi_enable(&fep->napi);
+	netif_tx_start_all_queues(ndev);
+
+	return err;
+}
+
+static int fec_enable_xsk_pool(struct fec_enet_private *fep,
+			       struct xsk_buff_pool *pool,
+			       u16 queue)
+{
+	int err;
+
+	err = xsk_pool_dma_map(pool, &fep->pdev->dev, 0);
+	if (err) {
+		netdev_err(fep->netdev, "Failed to map xsk pool\n");
+		return err;
+	}
+
+	if (!netif_running(fep->netdev)) {
+		struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
+		struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+
+		rxq->xsk_pool = pool;
+		txq->xsk_pool = pool;
+
+		return 0;
+	}
+
+	err = fec_xsk_restart_napi(fep, pool, queue);
+	if (err) {
+		xsk_pool_dma_unmap(pool, 0);
+		return err;
+	}
+
+	return 0;
+}
+
+static int fec_disable_xsk_pool(struct fec_enet_private *fep,
+				u16 queue)
+{
+	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+	struct xsk_buff_pool *old_pool = txq->xsk_pool;
+	int err;
+
+	if (!netif_running(fep->netdev)) {
+		struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
+
+		xsk_pool_dma_unmap(old_pool, 0);
+		rxq->xsk_pool = NULL;
+		txq->xsk_pool = NULL;
+
+		return 0;
+	}
+
+	err = fec_xsk_restart_napi(fep, NULL, queue);
+	if (err)
+		return err;
+
+	xsk_pool_dma_unmap(old_pool, 0);
+
+	return 0;
+}
+
+static int fec_setup_xsk_pool(struct fec_enet_private *fep,
+			      struct xsk_buff_pool *pool,
+			      u16 queue)
+{
+	if (queue >= fep->num_rx_queues || queue >= fep->num_tx_queues)
+		return -ERANGE;
+
+	return pool ? fec_enable_xsk_pool(fep, pool, queue) :
+		      fec_disable_xsk_pool(fep, queue);
+}
+
 static int fec_enet_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 {
 	struct fec_enet_private *fep = netdev_priv(dev);
 	bool is_run = netif_running(dev);
 	struct bpf_prog *old_prog;
 
+	/* No need to support the SoCs that require to do the frame swap
+	 * because the performance wouldn't be better than the skb mode.
+	 */
+	if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
+		return -EOPNOTSUPP;
+
 	switch (bpf->command) {
 	case XDP_SETUP_PROG:
-		/* No need to support the SoCs that require to
-		 * do the frame swap because the performance wouldn't be
-		 * better than the skb mode.
-		 */
-		if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
-			return -EOPNOTSUPP;
-
 		if (!bpf->prog)
 			xdp_features_clear_redirect_target(dev);
 
@@ -3989,10 +4658,9 @@ static int fec_enet_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 			xdp_features_set_redirect_target(dev, false);
 
 		return 0;
-
 	case XDP_SETUP_XSK_POOL:
-		return -EOPNOTSUPP;
-
+		return fec_setup_xsk_pool(fep, bpf->xsk.pool,
+					  bpf->xsk.queue_id);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -4140,6 +4808,29 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
 	return sent_frames;
 }
 
+static int fec_enet_xsk_wakeup(struct net_device *ndev, u32 queue, u32 flags)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct fec_enet_priv_rx_q *rxq;
+
+	if (!netif_running(ndev) || !netif_carrier_ok(ndev))
+		return -ENETDOWN;
+
+	if (queue >= fep->num_rx_queues || queue >= fep->num_tx_queues)
+		return -ERANGE;
+
+	rxq = fep->rx_queue[queue];
+	if (!rxq->xsk_pool)
+		return -EINVAL;
+
+	if (!napi_if_scheduled_mark_missed(&fep->napi)) {
+		if (likely(napi_schedule_prep(&fep->napi)))
+			__napi_schedule(&fep->napi);
+	}
+
+	return 0;
+}
+
 static int fec_hwtstamp_get(struct net_device *ndev,
 			    struct kernel_hwtstamp_config *config)
 {
@@ -4202,6 +4893,7 @@ static const struct net_device_ops fec_netdev_ops = {
 	.ndo_set_features	= fec_set_features,
 	.ndo_bpf		= fec_enet_bpf,
 	.ndo_xdp_xmit		= fec_enet_xdp_xmit,
+	.ndo_xsk_wakeup		= fec_enet_xsk_wakeup,
 	.ndo_hwtstamp_get	= fec_hwtstamp_get,
 	.ndo_hwtstamp_set	= fec_hwtstamp_set,
 };
@@ -4329,7 +5021,8 @@ static int fec_enet_init(struct net_device *ndev)
 
 	if (!(fep->quirks & FEC_QUIRK_SWAP_FRAME))
 		ndev->xdp_features = NETDEV_XDP_ACT_BASIC |
-				     NETDEV_XDP_ACT_REDIRECT;
+				     NETDEV_XDP_ACT_REDIRECT |
+				     NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
 	fec_restart(ndev);
 
-- 
2.34.1


