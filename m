Return-Path: <netdev+bounces-254818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKaCFj9re2mMEgIAu9opvQ
	(envelope-from <netdev+bounces-254818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 15:14:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E53B0CB2
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 15:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D5D33011BC6
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAAF3806A8;
	Thu, 29 Jan 2026 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="f4S6/9WV"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020119.outbound.protection.outlook.com [52.101.84.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3AC3043D2;
	Thu, 29 Jan 2026 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769696037; cv=fail; b=lzGl9owyiWI7NnoGnKqgllh2LtCkHfjwIOM/w0k8e727nyPyLTmnmZ13fU7gD5IRQK3bwxQYGY4ekanUpPyxUv3l4RhvNn/fwQFoSCrMsU3XoO1O1bs+si5LmI87n7QKitIFa4j7rYKmCVxBghdcTp/UasxHB28PuC1e0vFOkK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769696037; c=relaxed/simple;
	bh=0PogtmBN1R54yFv7mWIftTu+wtF6eyOdTO9+fKt4p7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=X60thuCfcK5TZf+Eu6QW1eDHSym/BKJ5BwaLWGsSpUel7elQDFhohPx1rW/EEMAjYpB1rJfx05gafKTBV18LWzFCkIYjSEWIkrSCq1qtb50A8C0B1M6HncmfN7Wzcmh2oBNbEmliDPUlbkw2WQCWFLiLsVYGXSuKETnbB/C1FXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=f4S6/9WV; arc=fail smtp.client-ip=52.101.84.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A99vur9RYJS0o8ljogeNoZRpUsvtCviGcBFfJNneQNfzYJLYzyD4bXYwY6n8T4UBrc5dFQ7mZBIn8rFptdprUgifnldGd73HX1vBNz1AtjkiFEapWK0ffAEQWSN7O9sZP4LI2wqpY1FZ5RqEdKXwNQXr1emstGEqO/uToQL2Lx7uM6rWXhO1Rxgo3s6M8CPkj+yCWG46nExKXtJLr/GAGR/9SkWebuYJTq4nFC9Vs4Xrocg0KbjgjHuGPuzvOTXqJvrCfB1bFaxJjZBgjU4osL2FRsSc7gpWdE4rJcjbAHrkpLs67QN1R7xB1Df73Fihgr+ZrmLnUYK/mnbqLAqKQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLuMZDs28VpaQRN7EEI0yT/+WV5kn2toEMzlLxu/eOI=;
 b=h8iI8/MNtiV9eU0R2GdEoBRAuCIONYiM43+FWGOR08SkM6Td/0JPsvqaE9+Uu/5f9pAmW9LZbqz3Yidgn77QKAj8+zq0co3zKvEOKzX30DkJSlcjC8GvZ8rYQ9OTzQ4xMtLA5VUk1IWLSV8WkJH/O7konvf4hr7uejMYF8pZHCtuuoHu7nbSh6k1Py/YM5oNiOgm5+FqLy1U/1Vf2BIvtNaDQT3fjedJ34v6Q8SeCTn1bgtR4Rv4P6ko6Qeo8Wiw6K5RWebrPQdmz6RtX3l2KKyWmCHyJ7Waf62tBN4foByZVZsBaR+B0Y3Iqnoh5IzqOi94lE7q/pDlQLL8caEo/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=kernel.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLuMZDs28VpaQRN7EEI0yT/+WV5kn2toEMzlLxu/eOI=;
 b=f4S6/9WVQTMurYOoMR4jEd707UuE0eggBP5NvvaXhqwgWsLMylsnfhrx3/kha97y1vB5ekCvpgHSvMGxEncC8KuZaVMAjBePn6pTzrsU5Sqkdj1a4cO8oUPMf8O01RlzQUy5MZzhopkq95mAYwFjpu88YsNz3xBnSEuK5p/2trz/ZbLpl9ps6uOkG67vbFTRkFy1mydtusaytSF/2kRXywGMIGxg4O2mtJ3nCD+0PfDG91Vu4gjPl4XTgPVOXO7JPi42n2h18T7RLKWjsQvZR7NlpuVF4VyDKOb4KJaCJcOYG0sUd1BxHSCjpM24tLmzHQhC2pnOAhaNlwb1i087Mg==
Received: from DBBPR09CA0043.eurprd09.prod.outlook.com (2603:10a6:10:d4::31)
 by DU4P195MB3180.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:615::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 14:13:52 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:d4:cafe::42) by DBBPR09CA0043.outlook.office365.com
 (2603:10a6:10:d4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Thu,
 29 Jan 2026 14:13:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 14:13:52 +0000
Received: from llp-tremmet2.phytec.de (172.25.39.70) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Thu, 29 Jan
 2026 15:13:51 +0100
From: Teresa Remmet <t.remmet@phytec.de>
Date: Thu, 29 Jan 2026 15:13:34 +0100
Subject: [PATCH 2/2] net: phy: dp83867: add numeric io impedance DT
 property
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260129-wip-t-remmet-phytec-de-bspimx95-132_upstream-v1-2-8deccd658d16@phytec.de>
References: <20260129-wip-t-remmet-phytec-de-bspimx95-132_upstream-v1-0-8deccd658d16@phytec.de>
In-Reply-To: <20260129-wip-t-remmet-phytec-de-bspimx95-132_upstream-v1-0-8deccd658d16@phytec.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>, Benjamin Hahn
	<b.hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>, Jan Remmet
	<j.remmet@phytec.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E2:EE_|DU4P195MB3180:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f9e3d2-a763-47ec-f07d-08de5f40a1a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTkrRFJidWhOS3lncVRKZE1Wa1RQb2djU2c4MW5WSHVTY3NSUTlQenZMTEh0?=
 =?utf-8?B?UGU4d3UySWJ1WkplTVZvRXIrejMxQ0NsKyttTmFZU291RnJPUkhHR2s1Ly8x?=
 =?utf-8?B?b3lCdy9wZDBhUytNdU9oZFBoMTVIV2V1R3ZJS3pKZndXQzM1WkdVcnkyMldj?=
 =?utf-8?B?NUNheG9jQUl0OHMvc2k3cUo3am45STh0NWtZcXd5Z3IwL2ZEQTN5dXVyY1RC?=
 =?utf-8?B?SW1odmwyTnZRR3pMS1V0T3JQdXlocjNsY2VsR2piSVRmVXJHc3JzZXRQdk9F?=
 =?utf-8?B?anEvWk1udG0yN2dpQjd5VzRFaFMvTXdRVnd3c2d0UzZYYWY4MnF4NUczZFV4?=
 =?utf-8?B?VUNkY0xNWVpZRTF0aTg1V2pFdEd2QXhOUS9YZzBLVjNhN085S25FVUNMTFNF?=
 =?utf-8?B?Vk93UG5YV2ZRWmlVb3RkZzlYNWNaclRCbFBEUTlmbU9VRWFNNVZEOVZiSVpm?=
 =?utf-8?B?Uy9WVnB0clptVDJWUEhzWSt6SjVJeVBPWndGejErSkhlMXdkdzVYNnorZTND?=
 =?utf-8?B?cU0vZjh6UnNrMTdDTTdvWC9vYWpJMlp6eXo1QitEbnBkUlEzWXkwT1RaNUdQ?=
 =?utf-8?B?Q3FKUHdtUUtGbUNiUVd6b21WeFhjRlQxMU1HM1ltL2E3Tno5Q0xYUmtucjJi?=
 =?utf-8?B?MXNZeEprSkExTUdMV3ZtbVoxbURZQUMwcURCdmVOZ29QVS9TdjZnNWpqNnhi?=
 =?utf-8?B?YnVwZU9vQ3dQcFp6dXU4bGM4Vzc1MmJ1cmtHZm9Xb3RIMU8xQXg2dlNWNklp?=
 =?utf-8?B?a0Z4V09DMFh5WWhLTXNCdENTTGhzZGoxUlRWdHJXaVdFR2RpelVYcmEyaldX?=
 =?utf-8?B?Z1VPQUVURGZjcjF0aTFZK2pWb0RhOUFOcjRKbFdIVnNZbjBsdVJ3NHZMeUpm?=
 =?utf-8?B?VjZzaGpmcTNlbGdRVUl4SlJaQ1kwTjB5NnQ5RmJJZmV3V0ljNnFtT01Fd2dH?=
 =?utf-8?B?RjR1U0F0UVJKb29PWXRubkhkSDlqbVM4YUFVZ3lIbXkwVDYwSFVraDBuYndP?=
 =?utf-8?B?dGFXbitSVzhjUEh0d1J3cUtwMDFzaGpiL0N2eUJIcndodlY2V0srSmNJd1dl?=
 =?utf-8?B?aVc3RXUybmlOa0N1NEhxK2VPaTJpRGhHaERjT1FWbndvMHRGVWs3WlRZUG5z?=
 =?utf-8?B?aWhpdTdoMGxsOTJFd0pLM2dtUFM0SHBvanM3TnZxS1VKenBFam1DV0h3ZXdx?=
 =?utf-8?B?YXNwTGV1M295ODFwaWdJLy9tUFNOampUbnJDTVRhY1pIZURRN0ZqSWx5blI3?=
 =?utf-8?B?MjNML1pOUFU2Y1lkUEhvdWhWOWhFRk10U3Qra0V5RlhlRkdQYjdDMjgyb2NL?=
 =?utf-8?B?aU9hVlh5UHpWZjlHRzRpNk0rQXRjTUFwdmgvQ1UxaG5IbER6bWIzVERNZVhw?=
 =?utf-8?B?M2tldkdKYXJMbFFuNDNSRGV2b00wWENUQ0lrbXlvQU1oLzh4UlpZbk5VTHho?=
 =?utf-8?B?ZXpGeDZLOURCUjE4TllYVjM2bmZYeU96ZVM1WWlvejJBNnk2N3RMaVVSQjZv?=
 =?utf-8?B?SnNDWDJ5QkZGRnRSWkVadGJTSTVnMGU2UVlnSWg3cHhWdzRkVVcrUDhCM25R?=
 =?utf-8?B?ZVJ6dVJKalhIM2VRQ3MwblV1Sks0akVhaEdyVjhWY0FrcUw4a3BOVnRZNEh2?=
 =?utf-8?B?cVV4aFVkUDJadHNndlIvVCs2T1JPbjdRaVNVM0NjajdPMTBOVkdxZUM1eXY3?=
 =?utf-8?B?Tk14RHczMHcwTE9LQzJkdjFZU2lvYm9VNFhRTGhXRk5NWmp5RXoxaXlHbGhO?=
 =?utf-8?B?YyttM2NWMzJkbjNUdDBvNlRkR2NFVzd5dE9lby91YmljZjFwUkwydThwWXdC?=
 =?utf-8?B?WGJOSWR6SHB0NnkrdW1oc1V3cGNMQXhydVVPL3BiNU51SnpPWTVGejJVdmF3?=
 =?utf-8?B?dW9JV0tvRGY5RjZyRloya05lNnRTTjg4ajhDZUJTNGRldklBU2dFMnByWC9m?=
 =?utf-8?B?dGtJZDdkaExFMUJmTHBvelRidTNpcUNuc05vRUhtZU0rS3gvVEZ5ekRaZEhl?=
 =?utf-8?B?RGFkSHN3dzEwcXV4Z3M4Mm5sR2xwMVU0T25OR0k1YVhES1R4TmJUdUk0WVJi?=
 =?utf-8?B?b3FGMGQvNTRUK1FScjQwVGl0WDk4ZmYvTG1EdzVIU1ZzQktXTXRJSGdSL1lS?=
 =?utf-8?B?YnppSFFHR2x1OFdSMTlGOVBobkJPUjFRUldpVW1oZ3JpV0dQOEt1RERNN0RZ?=
 =?utf-8?B?a1R0dWZINmp1UDVZUGZ4d3ByUlZLejVlbEZpYm84VzhTcUZzWW1LckVTeFp4?=
 =?utf-8?Q?1sRbYVSBwSAkbkJ4gaLQMb6aQoFf2OtBnrqaNteGUg=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 14:13:52.7103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f9e3d2-a763-47ec-f07d-08de5f40a1a6
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P195MB3180
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[phytec.de,quarantine];
	R_DKIM_ALLOW(-0.20)[phytec.de:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254818-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,ti.com,gmail.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[t.remmet@phytec.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[phytec.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 03E53B0CB2
X-Rspamd-Action: no action

The DP83867 MAC-side IO impedance is currently configured in the driver
either via an NVMEM cell or via the two boolean device tree properties
ti,min-output-impedance and ti,max-output-impedance.

Some boards require an impedance setting different from the default,
minimum, or maximum values, and may not have NVMEM storage available.
For such cases, a device tree configuration option is needed.

Add a optional device-tree property "ti,output-impedance", that passes
the raw register field value (0x0 - 0x1f) representing the range
between approximately 70 ohms and 35 ohms. Because the actual impedance
range and step size varies depending on the production process, no exact
mapping between register value and impedance can be made. The values
are determined empirically.

If the property is not set the existing behavior is maintained. NVMEM cell
has still priority but ti,output-impedance is checked before the
boolean min and max values.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 drivers/net/phy/dp83867.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 5f5de01c41e1..b06d851c3487 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -516,13 +516,22 @@ static int dp83867_of_init_io_impedance(struct phy_device *phydev)
 			return phydev_err_probe(phydev, ret,
 						"failed to get nvmem cell io_impedance_ctrl\n");
 
-		/* If no nvmem cell, check for the boolean properties. */
-		if (of_property_read_bool(of_node, "ti,max-output-impedance"))
+		/* If no nvmem cell, check for the device tree entries */
+		ret = of_property_read_u32(of_node, "ti,output-impedance",
+					   (u32 *)&dp83867->io_impedance);
+		if (!ret) {
+			if (dp83867->io_impedance > DP83867_IO_MUX_CFG_IO_IMPEDANCE_MASK) {
+				phydev_err(phydev, "'ti,output-impedance' value %u out of range\n",
+					   dp83867->io_impedance);
+				return -EINVAL;
+			}
+		} else if (of_property_read_bool(of_node, "ti,max-output-impedance")) {
 			dp83867->io_impedance = DP83867_IO_MUX_CFG_IO_IMPEDANCE_MAX;
-		else if (of_property_read_bool(of_node, "ti,min-output-impedance"))
+		} else if (of_property_read_bool(of_node, "ti,min-output-impedance")) {
 			dp83867->io_impedance = DP83867_IO_MUX_CFG_IO_IMPEDANCE_MIN;
-		else
+		} else {
 			dp83867->io_impedance = -1; /* leave at default */
+		};
 
 		return 0;
 	}

-- 
2.43.0


