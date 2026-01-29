Return-Path: <netdev+bounces-254721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJckHF44e2k7CgIAu9opvQ
	(envelope-from <netdev+bounces-254721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:37:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF63AEE1D
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2F7E3028783
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FB0385ECA;
	Thu, 29 Jan 2026 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IhwwdSxd"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013064.outbound.protection.outlook.com [40.107.162.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D60E385EE7;
	Thu, 29 Jan 2026 10:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682919; cv=fail; b=galG/DAclyStnUTX9CQr1Ut+AttB6Mz8PKXwmJk6HGFcPRITVdN7krc+i/9T6GY8lxepEZJJGwrrXK3FYNPMS6cro5+F3xfdZu77s+saqao5wjKHjGKw7V2ZBxyuFAXwEPlh1XOrNBYC+ZVRbPCw/DMlNBWg2Lv6SK46d+9W0a4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682919; c=relaxed/simple;
	bh=+FI2c+V0tYja//tX8lopvOZsJRTg7EwIyVpmjXVeeFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t6k39xlZfxxNF1rtJrdKyNT8EFiDkrnytYPFJL3Mw9HSRzGih/M5RO+NBrau5bf4egA9k5cLggH7eeobVtch/rYegSofN4AyqBbMTj+9KLjxTQ+tJOYRG70FE/3BHmAGgwWHkYoe4wMeEbq3ghZJBQn8+p5QD9NAAktTN7U5Gsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IhwwdSxd; arc=fail smtp.client-ip=40.107.162.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AM382Jl5r2NxmlpWgEyNY7Hj8nTUcgVZkvECHEX0FpvCIQ3IirAhZK0RI2d8ltVPIVR0vqQQymEzrENpEgbKM2IM0Cn7hJwDmxUs5NjgIICV3LnFABTF0P/j6NfS9ZaX6Vn9sRVSGotG9BWulNszc7Gyvbs+4ZQJVMG14IbV7H5ArX0aPQKLIYa/zyjxNI4waU6vPZbFDm+Dd2fB1KaXI3CKyJw03eMgBYZQM38Fk8XzfPU8FqA4rmbRj1eGuhgabLZksN7toWu+hjyiEi3s27jg9Z+n07/4aKgY2JOZ7NS/1O+bjsKX7sjAnzXo1T1I3q5Q9I8rMoZjSf9NbXFtGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjIQafaFCqUBwxjoVs7S0Di5YfvMO/xXu531O9Znxyw=;
 b=Mvbv5AHhARsb8saCrV5hLDDp0iK+nO8adeWE4ZYKcT4RWpULhTxPtvUIt2gyaYs65bWUvbYgph/+LDO/8O+NmLO/dIeaTDFcai3aojp8ghnM0sDyTZncsh8bk80AOj8VXT/wCBYcVR1TCIWWGYcIP/m1uZI3aOHxClEoD4mugzNfi6IfGx3THC5TRLu/bHY9Tt2p4wLes5h05ZXAGUKsD1Y8d+mESNQGutHGB9+KlllKiLYXDDlSeQgDvVAcMfboh63bE0OaxsyOsm2Ewza23iUbztuZDVsrrVVOlZoXnsv6qtapCYg6J7SjkiOpygAamNo/RCCqDgAmxspk4P1+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjIQafaFCqUBwxjoVs7S0Di5YfvMO/xXu531O9Znxyw=;
 b=IhwwdSxdXYwFXhtWH73eg/6IZxINrSQneuwN6Wvoy0+SlFi8ZsgurH7I4OVC/RC7KK7GkF8JVVxKKtKCIqmx9oTeqpu0Gcwq8WqFJrPE/iAOi4Y6bFzYCanHKa00AuYyUP/bJxnQNfoObbpwyfW9n6xCeLMcwAQK2eMhj7DPyqoGyrv5A1u43US7iV7qHzGUQB+sWWSnr15BNHPB/y3P3y4NgZe0M1OCN5tJvLso8UUjeZm+rUkwj7dauGYh25mXzl6YePQn74jQeSey36Bf4Gea+Q7iC5uyXsU/M2kXLoXYWZI1Gw8A1CGKaikFz935MG3KVTN67zyxc57GMHNo7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10843.eurprd04.prod.outlook.com (2603:10a6:102:480::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:35:13 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 10:35:13 +0000
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
Subject: [PATCH v5 net-next 02/15] net: fec: add fec_rx_error_check() to check RX errors
Date: Thu, 29 Jan 2026 18:34:34 +0800
Message-Id: <20260129103447.1893129-3-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: db9bf957-4315-48f7-8ac0-08de5f22159b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BElJy5jh8Csnk1tuPj5KyuWr9UtYHBlfm9LNvPVbBborvwRId8+h/NrP73Mw?=
 =?us-ascii?Q?W7hZ9VlJp67YqsCwasGnMl4LhnVBXIhqWJA5CQm7s4DksOgPHYS8kIW5Dsal?=
 =?us-ascii?Q?xAuVkrpK8Jv1ZrGlKE3VwQKbJWnEgC4G0DpjbQNp63560p0xwwTltHGyrM4e?=
 =?us-ascii?Q?Tp3mDeXf8w8FJkI0MMrfxdWux7LS5nLFz9gu6FPpGy9xcwRPpXT/jJruJIKR?=
 =?us-ascii?Q?YrvHKHZYPJSijiLjLcaclh0Lcmr6iL76tXqCCo/y7B+yoyOUG5EeS4PIjlhQ?=
 =?us-ascii?Q?lsyLvmcbc/sQ8ADny8lp+v2Ln1ldpB6fadwsiSmk0zvMvxCPQwNNztCS4Bqx?=
 =?us-ascii?Q?uxreHHxvXuTCQf/jUu6E+c7rwH2EjNnzkZuFh2VDCEPWRAxmkwDyUtULrU0T?=
 =?us-ascii?Q?5vHvgB5IgvhaKdU4wNCI0VrigdJxjxmqjmqTdCT1Q/nyNXx4gyGDdyWdQ7BK?=
 =?us-ascii?Q?49TOjOFVON5istuTRgNsVuNpLWBFHARATzTQPYZgpjrAq35KLxusIeG2qo6w?=
 =?us-ascii?Q?u11pgpgMHpp2lWj1M7rTAb5R9V05BJem8Cn4A49unUWF+C0e89w8aH8yttfM?=
 =?us-ascii?Q?1Oe3qX8Whh4qLQE4CsbsTDrCA0uueUtKcHd38efyQi09wpNUhtkuHzkHPS+j?=
 =?us-ascii?Q?GtRkjEQdG6dmA8dKNo93saiTLjm7TFTnzQv0/wF2qyuJRGv/QxE7yFV0MG3D?=
 =?us-ascii?Q?lWgr4nkaIVDujUTJ12SwzOYwMfVSNb/UWxcSrrGDk4utJjoIlw0SavPxwTHx?=
 =?us-ascii?Q?PdYw/p79HKsWrsms/6eJ2i+g1mDcOFzbrgiuHtIZ2QtD0w/VmJgVBFcr4NMe?=
 =?us-ascii?Q?4P3y18do2pAWo3n93evLJdhoSsZdBgNbRfrGlFJc//PxYvBDCv/w8I0gCVQE?=
 =?us-ascii?Q?SiIacbAdSR0ZdL2he7afKh//bM05mggOraqzhLZXmfNfsoNEGZ0o1jXpjdpg?=
 =?us-ascii?Q?X4SsFlSRMloobGuRo/n6g/SLx4sb6b/AwcHFqxC2gm8PYNMKUm0gYpML0QQb?=
 =?us-ascii?Q?/RQbbS6uKVCK8xYouUK0disHSisCjC+KbhmxkiYUy7LMoRxPBuUpGhwTtJSb?=
 =?us-ascii?Q?6dQ9uXmXNMl1umiw6OsC4MXVDOMrweBmiefnqXaGrEo5BqJ3NK6rawA23Loa?=
 =?us-ascii?Q?n7a2/AjdxEJEYjJcrYh73WZ4APHhiMxbjfEWL8M10xa5dJmJuZXFUQGc+n7U?=
 =?us-ascii?Q?y8ZRebBThv2eBnYIQXQqMBcqsbYK8GAbZmmV+rECPTATkuWLLxSzry9zzxYv?=
 =?us-ascii?Q?mC49Dw+TMoRQSyNSTKYmwWfU1+n7mxuwTNf+SDO5C4rc5MiQQrn6vu8fe9g0?=
 =?us-ascii?Q?hAJNXrAjQf9MKd+I94yeFB6wz1NIsCYkCqdvz9FfrNdTSzA3Ts5IiWlUj0dS?=
 =?us-ascii?Q?1ecziBfZ+VU4Vhc8vSsNU32Un8cYzTLhcjKU4ZvwHZq5Diw0StnenBU7jJFL?=
 =?us-ascii?Q?AnIV2b9cxZHF3ZYNZRrRhhJed3Tja9pTylHB+gCpDztXw0MeKEDB2ajeqJ3E?=
 =?us-ascii?Q?Bv/X4KlReZwFxf79dlIVCe2KB3k6hsdul1ZgK0vxoAz02vz92WpTNNjEZbFn?=
 =?us-ascii?Q?+0AahZaMjQNiXWQPMngJpn6rywnCWnCLV+BokFfptBI6VRWMidZGctMxOYxU?=
 =?us-ascii?Q?mVPZrdkQ+E9iPZs4LSlIHxdQ1FdX0SyzFUTgDEhiDHXZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4suJsMv55cugT83tU3A3YCl8vW6p+lm/jOTMMpwY0uFV8TGv93IdntjTl9Le?=
 =?us-ascii?Q?GVLiH1vy3RYxK5YQoBwiqdE/HXTgKgW3lUb067fK8NPE/Ybc2/ZUNPA/DBBZ?=
 =?us-ascii?Q?kk/Vie8EP1XbcRMMYodSoYqjc5h6C8GSgt3Gw7wsCzENjAVDNbKv6rMwIu06?=
 =?us-ascii?Q?2y4ErfKuYlAdj+MreEoegxw71LOpceU1k6pdzxAnu8509FHlx4JEWucOFWsc?=
 =?us-ascii?Q?n9PW1oBviJyIkUWLghZS/f4KEfqBh/GyQxAdeRY7W/QP/+rK4IA75960IpGS?=
 =?us-ascii?Q?vfuiiJupxMed4K/Dv+k1XqaQH+PnlIoXCEx+uIpltnOx7QGSF1XSl0cthw2M?=
 =?us-ascii?Q?Cv1/UG6wxzGwD+MI2MDKy4xobI3lws5HE2cMPAAvQE8VWHaJJD/bg7B4fbDG?=
 =?us-ascii?Q?QnKS8TXcgaQbKOy8PZlkiDhzo+Ly1LBOHNDhQe5rSro8voTL7xHkqKMhU6T+?=
 =?us-ascii?Q?yQqWZ6VkQ52mmsA5gJxXZQNWWnh2EAWSK1frSY1WNC2d1xIlthg7hBi6siNp?=
 =?us-ascii?Q?gnw7WlsAybGFisA0/0hntGc1i35TA0Y2Cp4Y6GwghQTrtvKs1iiv5XcVQwMw?=
 =?us-ascii?Q?t2/XjUl53dzMTfpTOqFnVeVdCALIjh/wp7ZkznF6C/f9+5DWwaEIJmzHaIiB?=
 =?us-ascii?Q?Zxc/DBiSupEXurZIwdaR1Ktmq12BBUWiKqFGFyPYCoQ2WexeohAqbN3/xfov?=
 =?us-ascii?Q?VlCCMcZub6KkMWKxj1BthbWzsKesCHbM/lf9HvCh5kAz2aCiXdtvpFGv9DhC?=
 =?us-ascii?Q?wioZRmTzC1irdIN6QPYqIMX73EY5KWlgvJEfJKStXFZhQ8bOL5TzHeHs64c7?=
 =?us-ascii?Q?uCtzRqp6HHOj9zXRrQw3smxi5lPPMP2fPEnjfqT/g0OyAFSiiiShge8OE4yZ?=
 =?us-ascii?Q?GLTw5u2q3eD3BcLEFyLcFiVLzuVIzB+cpYh2TsDLtmxoJXWxSNRJTAG0pgq6?=
 =?us-ascii?Q?6dozyeJ9EGn6zHoMNnS5xxuWzJLo5HI0M3JqHLDfPtVX2w+4qrY02s2IhZ+4?=
 =?us-ascii?Q?aBtKN31Ek9UKdeVbsZY/IgjCObvc6fXesqcO71e5E0V6QCE+T3BefoVU0StV?=
 =?us-ascii?Q?fM3wLmQqHwV3ZOhL4MD2s0CLNrBNHF75lPmremqdkOG+6oNUXMXCSML4keMD?=
 =?us-ascii?Q?CVsOWarOusInwo5pyQ/2CZnYZsnBrbt/sJfNXRLiEp81nesDfBCB+pZCyWLV?=
 =?us-ascii?Q?Cfo5DbK+cK86B6a8NCrS5WSd1zkcglEqfFGzFr/y45BuQ/74YmNWzRNhf3e6?=
 =?us-ascii?Q?jjmhw5klwQplFAUtCfz2osJVsrmB57phihpFdL0OEkPpwUnsP1N/lALDGP3L?=
 =?us-ascii?Q?jBdc96bgccdEDLRfAcmDe5SGnybLB8OFWwYTrhuO9Ah1JGciLCgnN469F7LY?=
 =?us-ascii?Q?5coUO3wt2gbTIgfPj963spiiImuXOZdNhZjb5J2nmDtzndRtVfZgIQmFhFYm?=
 =?us-ascii?Q?sUU+qQqOhnKYFIbvmnxyVHWlNTAyDfyTXfOAex9Tmx7VHNoH1eBrUbiofnt0?=
 =?us-ascii?Q?DZ6aqUMxE0IW029cF/rwDEDdpR6ufMTCv2pt8WSheJZ+P0RtqLAP+Qy1hqNW?=
 =?us-ascii?Q?s+4pGRN2rkXipsYlpJQ/SW3+G7/0i0iCvhFQqfoB8Pn4J6rIamcNr4tKQ9eK?=
 =?us-ascii?Q?G8/CDPNHoaDi07L/crsIJ3wNAQgZ8JikSe73khnA5xQ0Tkv2KAYBzIxZknAR?=
 =?us-ascii?Q?5AJT+erhAx0T4LBhja1HbMGujktoWWQpmdapNhhALYEP0vqjFMMTV5ecV4/1?=
 =?us-ascii?Q?N25bPRj9Bw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9bf957-4315-48f7-8ac0-08de5f22159b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:35:13.2820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqg4rb4tCpLRyLgCEN3rlZO9voV8ux3fdr4TJKCY2lBKMpmnGvKUj9Pos6YcfjUezKESQ4roqpzk04oaen8lnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10843
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254721-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 0DF63AEE1D
X-Rspamd-Action: no action

Extract fec_rx_error_check() from fec_enet_rx_queue(), this helper is
used to check RX errors. And it will be used in XDP and XDP zero copy
paths in subsequent patches.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 58 ++++++++++++++---------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index ce433af02ad2..ee4a20d8c438 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1747,6 +1747,41 @@ static void fec_enet_rx_vlan(const struct net_device *ndev, struct sk_buff *skb)
 	}
 }
 
+static int fec_rx_error_check(struct net_device *ndev, u16 status)
+{
+	if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
+		      BD_ENET_RX_CR | BD_ENET_RX_OV | BD_ENET_RX_LAST |
+		      BD_ENET_RX_CL)) {
+		ndev->stats.rx_errors++;
+
+		if (status & BD_ENET_RX_OV) {
+			/* FIFO overrun */
+			ndev->stats.rx_fifo_errors++;
+			return -EIO;
+		}
+
+		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH |
+			      BD_ENET_RX_LAST)) {
+			/* Frame too long or too short. */
+			ndev->stats.rx_length_errors++;
+			if ((status & BD_ENET_RX_LAST) && net_ratelimit())
+				netdev_err(ndev, "rcv is not +last\n");
+		}
+
+		/* CRC Error */
+		if (status & BD_ENET_RX_CR)
+			ndev->stats.rx_crc_errors++;
+
+		/* Report late collisions as a frame error. */
+		if (status & (BD_ENET_RX_NO | BD_ENET_RX_CL))
+			ndev->stats.rx_frame_errors++;
+
+		return -EIO;
+	}
+
+	return 0;
+}
+
 /* During a receive, the bd_rx.cur points to the current incoming buffer.
  * When we update through the ring, if the next incoming buffer has
  * not been given to the system, we just set the empty indicator,
@@ -1807,29 +1842,8 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 
 		/* Check for errors. */
 		status ^= BD_ENET_RX_LAST;
-		if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
-			   BD_ENET_RX_CR | BD_ENET_RX_OV | BD_ENET_RX_LAST |
-			   BD_ENET_RX_CL)) {
-			ndev->stats.rx_errors++;
-			if (status & BD_ENET_RX_OV) {
-				/* FIFO overrun */
-				ndev->stats.rx_fifo_errors++;
-				goto rx_processing_done;
-			}
-			if (status & (BD_ENET_RX_LG | BD_ENET_RX_SH
-						| BD_ENET_RX_LAST)) {
-				/* Frame too long or too short. */
-				ndev->stats.rx_length_errors++;
-				if (status & BD_ENET_RX_LAST)
-					netdev_err(ndev, "rcv is not +last\n");
-			}
-			if (status & BD_ENET_RX_CR)	/* CRC Error */
-				ndev->stats.rx_crc_errors++;
-			/* Report late collisions as a frame error. */
-			if (status & (BD_ENET_RX_NO | BD_ENET_RX_CL))
-				ndev->stats.rx_frame_errors++;
+		if (unlikely(fec_rx_error_check(ndev, status)))
 			goto rx_processing_done;
-		}
 
 		/* Process the incoming frame. */
 		ndev->stats.rx_packets++;
-- 
2.34.1


