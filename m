Return-Path: <netdev+bounces-141420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A579BADA0
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB771C2128A
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 08:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB071AAE27;
	Mon,  4 Nov 2024 08:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="uRe8nEv0"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED65D1A3BA1
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707511; cv=fail; b=r5sZc1NNiK0wVqLNXmb3R8rl5DlieFprvvD6vG99fqbmXu/hy855f66KoJP6jN9gNtTUwuyXdj8XXiNn1g0Gbd9s8KbC4975P4MrQnEBKKKC+WnlGss2gQF4SOoHAzJMFFFUeba+gf8lr6Gp5V/LQ+VPg6sOwJHlFRKevBdebJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707511; c=relaxed/simple;
	bh=mq7rZ+7AHEK3RXn10tJGzUddFIHMyQnezT/W2ifJsh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YxMjYj6FhAEbk5q0hoA2DPWG7NZUGjAMkqOaz0Y3RhA6fBXrlIRqd0p3WDaa/v2xYbBSIqZz+W166OJPdCaHdeG4F4s9pb2eaMmy9x6DkEJJdvFDAZw6qVYHGpOywmLHFWsm3nj/mGisPpJruSqAyq7A78RiKpLK1O4keyfjy4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=uRe8nEv0; arc=fail smtp.client-ip=185.183.29.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
Received: from dispatch1-eu1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5879D80E88
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 08:05:08 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 8390E340068;
	Mon,  4 Nov 2024 08:04:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tr6/EJcin0KmeOkHn/97PTzrDqjhWxT9D2MY4JlObr5Ihv9tsYuKCTxuO5l3A1+lRrxFHyoAiKG6UO6d2Co3T1kZbTzgKpe0gWWPCX6Au9bnBdJ29EwsyMyxBfnD+l4xZNL+db4q9r0EEOgCIKooQvoWAOuv5bZVuAJnWk5SN9ZpodzdwbZt7roxIFPZ2/9PxLtf0PisKk1EfRGg3ndXNVuEXGYXCOZa14sf51Wmw/xhiYW18fqB4PWtHnzPKErPXr50FFmdTwOIEuPmgLv14tk60kZ3dHrPA8IiAFF7FkbWjEoVyRRZnFnx0qsWWFvTNak23k3oLDRG1nvCRJifUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AU55zyXM/S6+ag7LI3NSAug29n5avPYjQfhAWqIaJQc=;
 b=Z6FgQl2spEJC4nvr5ZoZDRDCy8xrzaItbvD37VGC05J/4kxR5fOzHO+oGDnBniWtRs19n79B1u3v0AzTRPI5y/ce5xp8lBpvQT8Gz/XheRDit8ouYYOdvilMOJMSM8yCZHI2lFlbhZzkUG0c+sBV9XPX/jEy2G+oKxxB306ZtuwvdlsTbslp2ZbQpfwd9ScdeOO10PJtjebdtFwq2SMG369Fy7KdLB7a8xcPxwNQBBsCVABy7trpfG74sX3iY9bEMSy7ZV+kqtUiNMZQhmYnpxnRCJhG1UX4yTmTZmKXA8fBcrfSYIBQemke5V3vWlUkcvDQKcbEsuHpOdtuQRTaMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AU55zyXM/S6+ag7LI3NSAug29n5avPYjQfhAWqIaJQc=;
 b=uRe8nEv0Ypg5jJtlHrPkSWe6UkvsiXCrzIdeYFyijGE5MSjfazfj7wCyH1ECU67dcRrbEq+mpiBZBBxxQPjAqP73gNA1SLo49Lmy0iGOlj6ILrON2pKowmNveJDx9VRnZBk+ANpEIgqPyavJXKshVZI8kD2RVHflJ6KHkGFhKAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AM8PR08MB5553.eurprd08.prod.outlook.com (2603:10a6:20b:1da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 08:04:58 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 08:04:58 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next v8 3/6] neighbour: Convert seq_file functions to use hlist
Date: Mon,  4 Nov 2024 08:04:31 +0000
Message-ID: <20241104080437.103-4-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104080437.103-1-gnaaman@drivenets.com>
References: <20241104080437.103-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0206.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::13) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AM8PR08MB5553:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ffd21a-b9be-48ba-5f38-08dcfca7600b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6K9ewSZVaUseAEx2rcIlrqtm2MENKTA5ncOBMW+JmozDTtei4DS40Q/lOgmd?=
 =?us-ascii?Q?DH+mqlb/oVXGLO1uwACXBSgECt/HQz3SmuvUojpjQjDPOGmfmmwf9IzNcyUa?=
 =?us-ascii?Q?rVurNnBOiisdLyF2iEULhsINqJYA/fVv4k3rWEgGralLRZGTBztY1bmSXXvd?=
 =?us-ascii?Q?nHigVZhaiHNHn21xPoybQv9qGg+bKXdfYTJycGK/F/HH+EAoS7x966NorUYk?=
 =?us-ascii?Q?0H0bl1pOHTAHZKWK8UAHCfvNTs8Jxf2pcW86BLRCsAjuNUR/F34STZF0ulEy?=
 =?us-ascii?Q?T+YmKeRb69LoFl0xVjOVwPhdke0Q70BdigbmBqoCfEqIOutF1N+wMzL2btAG?=
 =?us-ascii?Q?9r66s8U0qox4pj1QxqOeq4XMRmKYq5+yKYClzSRl1pK49ExJe+GGdGu4qREp?=
 =?us-ascii?Q?g80R8wqlbZiiEDHUbdc/ru7AFu6o5cu4awpCIw52+3JFrsCpRqwRIszd6jwM?=
 =?us-ascii?Q?PGmPaZi/1TgQDOKYGfFdooIuo4zAF4WH/3n/XEiXqWHoYX03jCkgrkReJCNl?=
 =?us-ascii?Q?CoCQ0L69Se5zkiUmq9yPScMXohXJGX5m1cCVgmNMRaRjjyuWUFitDmmuBD3l?=
 =?us-ascii?Q?ZS6/ABxJ6uHfA4GqBC98TKTHj5zAETg+zs91y/IFFstzkGsTpsIMCqCP2LF6?=
 =?us-ascii?Q?3EiQ7tmRvFG5bv6fG33I7JSlcKc2oUfNFvDUvDnX9YCOl4y29scHdUL/cFoI?=
 =?us-ascii?Q?4Onhxu29iHs1JJjnAdDTikKmObFJUFF4Jofy6dbbU17OEPggbbv6wH/AOVI8?=
 =?us-ascii?Q?TD6J/+HmgyENbncwtD6jERKKI3VGTWNyGhhFLHGHPGOiBDHTyrdqyPBkVeMj?=
 =?us-ascii?Q?ZRn4+bDyQT5LBmKXDCiieqpIIymwC6D5ki9NQYQZlL8dRACu2QZvcHKE5yD7?=
 =?us-ascii?Q?1E/Gz2rDoTN5Qjw64aM+DQCB0atEcmT0KTsgWbD7NhmPIM8+zQ1A3Y5bbJ8P?=
 =?us-ascii?Q?XApp7NFt25FGF4ShaG1dq/fqIMw8vCj/5QU49kE/oTT95k84YnCRsBlvz4zV?=
 =?us-ascii?Q?zrTlT7EpmhujkdDPjO7IDd2FIcbzttIhzolEelANAYH/JB/cA+h+Lwl+/zh8?=
 =?us-ascii?Q?qz5lnPQbiT1VXZ3aHBedzbCqSpo7HNJjAqmepw6YTKBPP4PrtxD9Tonn1EMG?=
 =?us-ascii?Q?RETwpus2WriHj0JHCi7tIN2HSTjCIRrHBPMjgLU1W1tJyneSIICtBEkCbkLF?=
 =?us-ascii?Q?UGsS+b2Q6vj0tBNxg7DsveYtAc+g3UcbgfUq4y/FctjOKw+5wuNX78y3hv14?=
 =?us-ascii?Q?y0wb6xNraDcgZ/TA+wozpmmHYh8ETW4NGMu8AUj2YPh5o/fX9d2gqFz7uEeZ?=
 =?us-ascii?Q?VgtBEnVZkrWKV0SZT4WqtEzdfHVozV6lrBkswmU6D4soknQFCE20lWmCOoR9?=
 =?us-ascii?Q?Sq2voss=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xSZlO+GJEtSLACwhYGMGCz7MoXj3QTMbVjCN6j63mvht+RFrn88CTWpOG1jC?=
 =?us-ascii?Q?qxBV8VN2+Bj3u7uAD6R9yKC7c0bdH1sYNkKeCG42LdwQotQboYeO/uFDOyCM?=
 =?us-ascii?Q?1e9j8DGfYYKHc5JVsX2qtiItIyUZa5EwX1bTaukP7NipdobmWgUnGTKPziPc?=
 =?us-ascii?Q?vOSXmFak/uUYqTjyaRr+iRK+AiDK97OrXOFR6m2+SWYVxtCQ7L3K1ugEM/gA?=
 =?us-ascii?Q?rJ7W4mM6ZoBYGwRaeJDsBEk/eaAlekfcgXWpEX3cnjbn+mBlyeePsqvFlDei?=
 =?us-ascii?Q?ROF/C5mT0sn4DXRkvtQWkhyqXjD2iSKwFyRXwwUQBfB1m06zY1EfZkZ4+3Fw?=
 =?us-ascii?Q?iMrrFU0ZetHEoJSEEAuQIyj0J8SirYOXhzEriA9oeZAqs7oRWKsE36BtIiw2?=
 =?us-ascii?Q?SJSg+GHi0N7Xpw4ippKrjze1H3FwRnO9KuLbJnsGAKkUaTxtGrhu87qNCorx?=
 =?us-ascii?Q?TmgywwItzmVZkmijyk5X5DXECLVnNDQqSPLBQMzHu3VnRQ6VhcMUunHmCo/9?=
 =?us-ascii?Q?6P0uRSNQXCh8lIHhWfjvwpm98ZF1WYyhyOQJh1pQgMOb23YIzK9V9YsyJCSE?=
 =?us-ascii?Q?S7Pj7/wMjmXCvlT9tn5i/APk0Jb1zdO0BssxsTkgT98dOJj5Wey8i/YV+iwa?=
 =?us-ascii?Q?edf11WTGTVzpSUJGKva80HOAPU/Sgw470YDDHGuvN/5Z5Dn+qAWeOj2Ya/vL?=
 =?us-ascii?Q?UvtxylBI+8GcXTRjRUABoFPt3v+39IT6fkUdOTvX5U3Zc+cYj3RTBJjFgl8X?=
 =?us-ascii?Q?TiKiqKFzWRnEZJFD4S6BHkRSDFTtONmXiSytovV8B9hzU6BgkxZlktNMp7Gs?=
 =?us-ascii?Q?Ss/OTDNqlohsg8xyWACDw47KDKtJBd9sJAiia0xKZdDfLK3GiMejXOujYHxW?=
 =?us-ascii?Q?vBqbwIq2OTUY7zlAmHKu3FjHTm2D6ZvK8rsKhO/egqLUdNPaM7cjit5CddaK?=
 =?us-ascii?Q?VH47MlUznl+TIhXfPRuE4QJU04OsJFFRP8VQnmEGBw3R2D1QZoJZ5ZZQ9ExI?=
 =?us-ascii?Q?mH8bRM4MW+wkUa85VlU3fRTfNi1Poz0JB6JEAaDuYDt2n80w5xX6Qy5Il8Uc?=
 =?us-ascii?Q?NCnDPwvrkwhPzG2zM9e9taeZgTh0gLsBFxgwYi6dfgOSBgjuTg/04ZgSKVsl?=
 =?us-ascii?Q?/uQgbNeKCkfZwmxjx4YCLAeexelGiPPyg0fUFdEi9tWyYdGmA70TzVJNHvf1?=
 =?us-ascii?Q?Fmb5KghCNx8yTbKRaJ2I2FnXGYqeZ8uKm3CpfTOs5RSAh5JYwVdyPbZlFGRv?=
 =?us-ascii?Q?sWkwVvZpR7kgjicpDteiZ/RI1wUMkaY+cB/sT5IPZZQecHQOQ2rOxj0/e7zj?=
 =?us-ascii?Q?kHYcIdyIT4US9bP0LOtbe8d/E6YJu6wIjiwNNkUNgfDN58C1t9w4oV8xrzSo?=
 =?us-ascii?Q?vrpkvgwrIp7cRu0PlU43Jt7+LP4N+uOU+ifMc9X8yzHzZDLmgnXziJgJUefR?=
 =?us-ascii?Q?OgE1K3GV2bWFowbpVmJUMZqhECNae8nsbVJHMdAGGeS8/Cxm4gsgVftNEkJg?=
 =?us-ascii?Q?CPJWYfnofTEheZqFtX9pXQI1GhuwVPAcSYXZk3oY5AFwWQgqD2gVn03GTz4t?=
 =?us-ascii?Q?9gE2xdjZ7R6RdtFiFK0c0g+7gLqhC2SWsxZ1t+cBcSjrzfGyIUwisvAiEkff?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UcnqMcJRDJnYjk+vq0fnHfY8/qRUdx9LCqi91gp3rADTA0WlsA5+Dpj8fw3P8Bn3O1fOLd4usNNiseN/+xnTiWZHi+ttMOViRgxHZlCwM0F6b961WqwhC9O1C8umkjR2kNIUzr+VzILCEQl/qrA1ISDurEXTmIypxPkIMiIPEFaP52gBpAJlQOMvs0Wdz1SSNwkjS2r1FTensDlsgqjr2WiRVBV4UuLsW3Ai1NVoU603QNJ8vSeuzbcYmO/Pm9G9AIohCS7Afte57ZYjF05Wqj/kXbPWTQCaoel4hKj6dQE0X49/UOhhgsuSn1Nz/PI5r1u9QjZT8ajKgeuQnr2CG3zZi+qO4ZixDVRy9NMiT02Sexp8bZgq7VPA62zRGmS4j/gZYx4W9rfcsHBM+lWHJM2zWAx5UwLKDUDBDkkQDOen89Cra1wiWOMDkYHR5uHUWKZK2DWvPuI4mOPw2AtJ1lVh1mWQDK4HAqFC7Ny6Cppy5xdVxlbSQ6eRohiepA5Gnpr8JkEAXCDwrZikYgYipo0/ZYiPnpJRnkaT2pIwHzJumAteBFPReJkvFv8QxWX/GOf0xrPdtAbop4N+HvtwKT1OxVX0ut3QeL/WpX5PF4mPNZJEu9+lHz5UGCLSheXv
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ffd21a-b9be-48ba-5f38-08dcfca7600b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 08:04:58.2289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFaM9SfUfp143A4iWLHIc8HmlRE2DyS7ZxElab+FLwLRw8L0U9NOXsR0BYxevOJo6fHfF1B9+Cn7oeiSzCQKzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5553
X-MDID: 1730707500-TgJ1FTVn3Qh4
X-MDID-O:
 eu1;ams;1730707500;TgJ1FTVn3Qh4;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Convert seq_file-related neighbour functionality to use neighbour::hash
and the related for_each macro.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 net/core/neighbour.c | 104 ++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 56 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 5552e6b05c82..3485d6b3ba99 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3193,43 +3193,53 @@ EXPORT_SYMBOL(neigh_xmit);
 
 #ifdef CONFIG_PROC_FS
 
-static struct neighbour *neigh_get_first(struct seq_file *seq)
+static struct neighbour *neigh_get_valid(struct seq_file *seq,
+					 struct neighbour *n,
+					 loff_t *pos)
 {
 	struct neigh_seq_state *state = seq->private;
 	struct net *net = seq_file_net(seq);
+
+	if (!net_eq(dev_net(n->dev), net))
+		return NULL;
+
+	if (state->neigh_sub_iter) {
+		loff_t fakep = 0;
+		void *v;
+
+		v = state->neigh_sub_iter(state, n, pos ? pos : &fakep);
+		if (!v)
+			return NULL;
+		if (pos)
+			return v;
+	}
+
+	if (!(state->flags & NEIGH_SEQ_SKIP_NOARP))
+		return n;
+
+	if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
+		return n;
+
+	return NULL;
+}
+
+static struct neighbour *neigh_get_first(struct seq_file *seq)
+{
+	struct neigh_seq_state *state = seq->private;
 	struct neigh_hash_table *nht = state->nht;
-	struct neighbour *n = NULL;
-	int bucket;
+	struct neighbour *n, *tmp;
 
 	state->flags &= ~NEIGH_SEQ_IS_PNEIGH;
-	for (bucket = 0; bucket < (1 << nht->hash_shift); bucket++) {
-		n = rcu_dereference(nht->hash_buckets[bucket]);
-
-		while (n) {
-			if (!net_eq(dev_net(n->dev), net))
-				goto next;
-			if (state->neigh_sub_iter) {
-				loff_t fakep = 0;
-				void *v;
 
-				v = state->neigh_sub_iter(state, n, &fakep);
-				if (!v)
-					goto next;
-			}
-			if (!(state->flags & NEIGH_SEQ_SKIP_NOARP))
-				break;
-			if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
-				break;
-next:
-			n = rcu_dereference(n->next);
+	while (++state->bucket < (1 << nht->hash_shift)) {
+		neigh_for_each_in_bucket(n, &nht->hash_heads[state->bucket]) {
+			tmp = neigh_get_valid(seq, n, NULL);
+			if (tmp)
+				return tmp;
 		}
-
-		if (n)
-			break;
 	}
-	state->bucket = bucket;
 
-	return n;
+	return NULL;
 }
 
 static struct neighbour *neigh_get_next(struct seq_file *seq,
@@ -3237,46 +3247,28 @@ static struct neighbour *neigh_get_next(struct seq_file *seq,
 					loff_t *pos)
 {
 	struct neigh_seq_state *state = seq->private;
-	struct net *net = seq_file_net(seq);
-	struct neigh_hash_table *nht = state->nht;
+	struct neighbour *tmp;
 
 	if (state->neigh_sub_iter) {
 		void *v = state->neigh_sub_iter(state, n, pos);
+
 		if (v)
 			return n;
 	}
-	n = rcu_dereference(n->next);
-
-	while (1) {
-		while (n) {
-			if (!net_eq(dev_net(n->dev), net))
-				goto next;
-			if (state->neigh_sub_iter) {
-				void *v = state->neigh_sub_iter(state, n, pos);
-				if (v)
-					return n;
-				goto next;
-			}
-			if (!(state->flags & NEIGH_SEQ_SKIP_NOARP))
-				break;
 
-			if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
-				break;
-next:
-			n = rcu_dereference(n->next);
+	hlist_for_each_entry_continue(n, hash) {
+		tmp = neigh_get_valid(seq, n, pos);
+		if (tmp) {
+			n = tmp;
+			goto out;
 		}
-
-		if (n)
-			break;
-
-		if (++state->bucket >= (1 << nht->hash_shift))
-			break;
-
-		n = rcu_dereference(nht->hash_buckets[state->bucket]);
 	}
 
+	n = neigh_get_first(seq);
+out:
 	if (n && pos)
 		--(*pos);
+
 	return n;
 }
 
@@ -3379,7 +3371,7 @@ void *neigh_seq_start(struct seq_file *seq, loff_t *pos, struct neigh_table *tbl
 	struct neigh_seq_state *state = seq->private;
 
 	state->tbl = tbl;
-	state->bucket = 0;
+	state->bucket = -1;
 	state->flags = (neigh_seq_flags & ~NEIGH_SEQ_IS_PNEIGH);
 
 	rcu_read_lock();
-- 
2.34.1


