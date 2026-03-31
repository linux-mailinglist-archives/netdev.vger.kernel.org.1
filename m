Return-Path: <netdev+bounces-273580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKJxIDewy2kpKAYAu9opvQ
	(envelope-from <netdev+bounces-273580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 13:29:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1BF368C49
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 13:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1269A301E4A2
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E324B3D6CC0;
	Tue, 31 Mar 2026 11:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UghncXF/"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013024.outbound.protection.outlook.com [40.107.162.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD9A3D5659;
	Tue, 31 Mar 2026 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956530; cv=fail; b=o6Var+7iZJ2dKDkkq8LTGqEMVHDVtfuEJjpAJ1yHhvROuXFobhISae/G8LGs8M0bnAElf88GZon7sEYN2K43Px/Kav5A1vb2fzuZF2BWnQtCbMr3GkJpeusv/IOPITLIjZJC64UYtcJHbSx/oGiRmd/V29Q4Mo/5g0NBD0GjO5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956530; c=relaxed/simple;
	bh=AQF6fKQ3U0xxBvqjXP8A5bWi/pyNbR1EqSHfqurcpo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Se4Bs1UrfW7YkRTdDNz6vQbnQaH/4GEj1ZpKZ4oEYOFaCD3Lon86fCzPpzl4DZ+Bl3NthZFgXw8QCfDWLQgxhfJbZaAvMSaTpkAhOPJhtR//z7ef43pY3rHjMSxuveYig+m4kIcqHnPCU1zmvLGmABbEv7WpQTrSu3XT9aN55RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UghncXF/; arc=fail smtp.client-ip=40.107.162.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YliiO0INl74SAPnpx8sqAoQPIGpQFaztVM/0QfPLRC19Z+52pnAVJNrRqKvFECPADgckubPwOAxTW+O1aWsvKGDC0Nkoy2TfOd7MIEEMCQ399R8Q7XDmiTJeXG2Vj0fsFIxxEn3WlxfdbQ9q7Ocxc9NlEGzoeD6xHTz/Z1cCU+G+/H08LltRLqmlPQQsjwKx1HTD15MFfkoRQ8BLkvD5tffXm8qcj8AFK+gvkOrXm/CWHVQnY5dj8cEGwcP0dsuHP1tUGBrN/2U6uS/CMAhCId84to54LCw8X/EgzVEjAUBp+uQRu2R3oeyLAASSlgzaoZz4HTdlcmDbGRqfokzQWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wObqie/YDWtvO5YnynND+nUbxUgSABloC8mbIsWMtlU=;
 b=anApVQUBm/M+xNnwIpOBT2VQ9eSWp1cVGF9phWbkVIWRkblfzYS31/jW2aVKRmGe/pFyfDgFkmfTGPBNoVbVbfFRDnx3gTOJSquhOkE0b7IEncpkHRQJaAo7FBw60QWl+iP/a8Cyt2b/yVpjtgioGlnWFSLoALvUikjZdq1wHuh+3chUQj1jd0buvoFxUtvvorL6Y85HutgDqBeBc/mzAmM/tPLD5oBO4rvp1C04iFh0ZMnnPViPkn7Wk17EPe0i4MmNJu/dyMbMv3CwWAgOO2cdfgwRzK89Vwvgyx01nDFTSwiKXht++4IIB7343Sg6L3OOaWstaRNyWM1GeTeJRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wObqie/YDWtvO5YnynND+nUbxUgSABloC8mbIsWMtlU=;
 b=UghncXF/7efn3jf5Xt92lmc3cF3c2eEplxh4D+dLp7siYjLfOUujz16EJKFeVnp3xwdgueKzFSBlgb95vdCgszYlun3rWY5c+xiW201wdoT9lXFnH945X1Blq8VRWa+tTzCsqY+pzEvPDGatAPM/MovbmIFGOdXxp0OvaGVaPSfFSp5HTPv74UsQLqPCvcDy9cwAEkCPWku1uNVoGPPc4nm+9YWClhDQvyTr+auNQDbbd55/L4GFxhscNttySQ98BmujWCiZOaF7YrhnJSnA0vyWHPYDBETWUlDGg2Fag4dDTV8hG8R8CMTHAy5fejPnfdd6hceAR+m8ibi7qzV7TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by PA1PR04MB11406.eurprd04.prod.outlook.com (2603:10a6:102:4f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 11:28:45 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 11:28:44 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v4 net-next 02/14] dt-bindings: net: dsa: add NETC switch
Date: Tue, 31 Mar 2026 19:30:13 +0800
Message-Id: <20260331113025.1566878-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331113025.1566878-1-wei.fang@nxp.com>
References: <20260331113025.1566878-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0151.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::14) To AM8PR04MB7284.eurprd04.prod.outlook.com
 (2603:10a6:20b:1dc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|PA1PR04MB11406:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f869553-f039-4930-1a1a-08de8f18ab20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|366016|7416014|1800799024|18002099003|56012099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	Q4EFVJxZqKiFDeMo+j/ZiIOzq6reokzDohpKhHB7M6mFZWGQQC4kulE0779cIe89ptlIMZ2qGbCkOFW6f2FXwTeCWiULLAD/omezKC5gbkr/QXppZbwGdqR5jVGDuHMkGIzBD6ad/rhdnk1HbPXFAG9eQbRRAWzBLLPLbPYFZI2Q2f0fD+iaJnD4ULMrfEStEQaHZoIWLLFSJvPWQyfacgnIhKqGT5qwjqyYEjNGG1i5PnQ8Cw+4pC7fcN6iZTef9tNl9ip4gQGEc7qNtrkHWdW0gmh9whJkaZb2HcpIOoAMlDnJirfmYPeYNsu68rg3XtEB60BCD1CwHmnMp6UPrwnBh3XLoVkMxheAL2IhDPXxyeQmcMSqZxh3hEgNQOR0k153TfkeqPHcxJ1FdJQmKWnzmhuL78H2pH/tY4+xm6r51qbicTw6aBPXUFDPG9aS6wbaV5Hq4cQEnpxQRZg7SBiLoUqz0BjoSHNTWUSB8z84lfMiLqVwe/43jz6jzi7mvIZT5M0td8u5Lrnd3ThYT4l07YlYkf+BiY7EFEuvtFdm2WFbcvMtt7Oz+m9tItMtWViA+6ZXTpRstAGDUTVFgLJhZlOAWT4iR7YGQBPgHclVq3MyL+c8obxkbwm0YNVW16tviH9CZFCVNvX/hCWA2mEDsSSdOufcKYF61wNnxzIlDybNcGZzhzeO4O5mXWFw2g7Kh9MsOSnZhDXOU9xOTnw2hBlgaRxjmizNEGV7uXd/sFbMv3H4wdyZtuC1y1k1tpK8VhoqEsHJG5pAgqcfQA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(366016)(7416014)(1800799024)(18002099003)(56012099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3nz7t1SSMk29DFJRJktLPZqRWrJ/PxFfuTYd+X7CmqeCnK9iPXbkXNA5VRPu?=
 =?us-ascii?Q?f5ezTbmer4JV0yTSXDpYyF/l3D9P/GBIy25RvyHeMRXN1/fWeU3jP5Q3eqBD?=
 =?us-ascii?Q?b/rpHyRsCmTtMPgcltj+MCVglDEJzKWD/HW+qockwgGz9bLjKrkgzXJN7YFu?=
 =?us-ascii?Q?tqb4G9VerYYRLVcreOdI0bGTGf1CnUjabt89x10r+azL+V8h20Ni146JbJMt?=
 =?us-ascii?Q?LZ1tnKjmkJN9M5NoCrnirbZvoipqfNJHMQbFGHOL1S/jJRoe3m+Id7Lc4AUR?=
 =?us-ascii?Q?lVsSMEfrPrTakT/zIEWj88wCylJ0MlwPJ4gnjiE8FgfeWuNcNFhTXPAeIBCz?=
 =?us-ascii?Q?hWLHudQ+MXJjbCIq5lU5KzgoOWjJHTUCovB2r4Ejn7prN5/4Y8zcGm54yo5T?=
 =?us-ascii?Q?23FWM294lBeQmNu/EjUNbrXZxtDV7FVM0Kh0af1jM6Ejj7kgFWlb+XmocOn/?=
 =?us-ascii?Q?40Hwfmu+yFYrkULVrS/QGrJ3Z+KVcbFG4Uj9VGPl8TsSCg6uatmkScd5YOKM?=
 =?us-ascii?Q?TvRc1VGwTMnfIc1UbW9qPiJu2bmYc/mAIrhh2F3pk8WAKjA1JkkgeGfC+TAz?=
 =?us-ascii?Q?CxOWVeU0wMtyugeuWcPOFdv27eZhAvgQGJjFqinn4GEqhgREMScYYyPLnS48?=
 =?us-ascii?Q?2Ol5ZPW4a94YvCfVFoX99+W0jcddKlf8/3njOeJC5kgGX0KAWq2pNo7Z9ZnH?=
 =?us-ascii?Q?J95V0k+ZIK9PUPRq19nhAnLnt/u+ZSFyRmEw2aicYPXrgsGnAFIKYp4SlfJ5?=
 =?us-ascii?Q?C0Eht2eZMhij4WBUn39Gk7ZfDtNqPOp8+2bWfio9mIQWcCexnEFj75s226fp?=
 =?us-ascii?Q?/xTqBXWBfrVoUj2iEZBFfIh+wiXpH6WieqYntjjYKLD5qfZK61SZkWtL0G/x?=
 =?us-ascii?Q?3wcPfMLdmxKKBwQvtfbhGQmyKM9CNjRlpiH5MUTQg2N9mEQ7Xa/bVm2hP038?=
 =?us-ascii?Q?Bqtlb/yBGBEEpQ6ZXrzjpHFFgq06T62ZnpduxNPZ36z2nFUh6FGvY28jirjc?=
 =?us-ascii?Q?ufQU+NmbMx8gmBVErNNgffBvCImZJ3Kfro129pyzOCryCelUR+Lu2q/mGDm3?=
 =?us-ascii?Q?3gK2vSsw/HM43/As95/jXuFBDPAgIvqGENh1nPP+iuVBGgsCf51G7VBYjw71?=
 =?us-ascii?Q?/zCRspJtdIxhArsmQB3k/VjsQayoHj+hH21cOlP4xgeDZM52drH572oZ50ac?=
 =?us-ascii?Q?H0lPAYYyjUAPbj3nP7iMpIyZem48CmeDTR7SWqcdKB0bTdkaBUKzPSlRKqkt?=
 =?us-ascii?Q?RJn6Oc81m6XYsfn9+anmfpAon8fGqhkqFTQM2Uqop3nj4ZzijXZm0Dou8+Lp?=
 =?us-ascii?Q?b3onP864NmpOAnKqraeN6Cj5jL7RwOs6VQTEsRG8R0w7ppOnTQINMPaJyVvu?=
 =?us-ascii?Q?dJcC+86tpT6rtIDs+H9b/FyJAOeLJfm7+PaBVZtt7QPBhamafI3kMD12oQKs?=
 =?us-ascii?Q?NhIMGx8llQndnUJ+qJVEeln1QQizSoBiXtWA2DKhByy+Ub2NN2Ef1zm/agqX?=
 =?us-ascii?Q?MDKNLrxGZ1Xpyxa1Br3SPpd+iGCKp+hlw8geF3cICyjCThJ7Kkz7dyY7YTU6?=
 =?us-ascii?Q?hG8IyF7N98Iuuu5mSnnaO2CIZHIh3jxNOMGWIe9tD5C0GiVJl9EjMcADIsHc?=
 =?us-ascii?Q?itnVk/061BIN7MM89A3NB7vObJRdzwy1TIsHEgXBGBY0Ph0LzzMATiOuqBx/?=
 =?us-ascii?Q?Cy54GRGat7o4uUHRgPt1c2lUlktgTOOqOTX17tKUaZxzM2BE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f869553-f039-4930-1a1a-08de8f18ab20
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 11:28:44.7159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRte1K2Pifkhy3b0kiGcScqZl+lxHrdfw+aNOx/qsx5YNdjRM/VlvJ3MRoY53RkzhP8utXDPT57qFm1cN9qIkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11406
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273580-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.2:email,0.0.0.3:email];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.1:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,0.0.0.0:email,nxp.com:dkim,nxp.com:email,nxp.com:mid,devicetree.org:url]
X-Rspamd-Queue-Id: 7D1BF368C49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add bindings for NETC switch. This switch is a PCIe function of NETC IP,
it supports advanced QoS with 8 traffic classes and 4 drop resilience
levels, and a full range of TSN standards capabilities. The switch CPU
port connects to an internal ENETC port, which is also a PCIe function
of NETC IP. So these two ports use a light-weight "pseudo MAC" instead
of a back-to-back MAC, because the "pseudo MAC" provides the delineation
between switch and ENETC, this translates to lower power (less logic and
memory) and lower delay (as there is no serialization delay across this
link).

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/net/dsa/nxp,netc-switch.yaml     | 130 ++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
new file mode 100644
index 000000000000..5577f3ef987f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/nxp,netc-switch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NETC Switch family
+
+description: >
+  The NETC presents itself as a multi-function PCIe Root Complex Integrated
+  Endpoint (RCiEP) and provides full 802.1Q Ethernet switch functionality,
+  advanced QoS with 8 traffic classes and 4 drop resilience levels, and a
+  full range of TSN standards capabilities.
+
+  The CPU port of the switch connects to an internal ENETC. The switch and
+  the internal ENETC are fully integrated into the NETC IP, a back-to-back
+  MAC is not required. Instead, a light-weight "pseudo MAC" provides the
+  delineation between the switch and ENETC. This translates to lower power
+  (less logic and memory) and lower delay (as there is no serialization
+  delay across this link).
+
+maintainers:
+  - Wei Fang <wei.fang@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - pci1131,eef2
+
+  reg:
+    maxItems: 1
+
+  dsa,member:
+    description: >
+      The property indicates DSA cluster and switch index. For NETC switch,
+      the valid range of the switch index is 1 ~ 7, the index is reflected
+      in the switch tag as an indication of the switch ID where the frame
+      originated. The value 0 is reserved for ENETC VEPA switch, whose ID
+      is hardwired to zero.
+
+$ref: dsa.yaml#
+
+patternProperties:
+  "^(ethernet-)?ports$":
+    type: object
+    additionalProperties: true
+    patternProperties:
+      "^(ethernet-)?port@[0-9a-f]$":
+        type: object
+
+        $ref: dsa-port.yaml#
+
+        properties:
+          clocks:
+            items:
+              - description: MAC transmit/receive reference clock.
+
+          clock-names:
+            items:
+              - const: ref
+
+          mdio:
+            $ref: /schemas/net/mdio.yaml#
+            unevaluatedProperties: false
+            description:
+              Optional child node for switch port, otherwise use NETC EMDIO.
+
+        unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - dsa,member
+
+allOf:
+  - $ref: /schemas/pci/pci-device.yaml
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pcie {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        ethernet-switch@0,2 {
+            compatible = "pci1131,eef2";
+            reg = <0x200 0 0 0 0>;
+            dsa,member = <0 1>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&pinctrl_switch>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    phy-handle = <&ethphy0>;
+                    phy-mode = "mii";
+                };
+
+                port@1 {
+                    reg = <1>;
+                    phy-handle = <&ethphy1>;
+                    phy-mode = "mii";
+                };
+
+                port@2 {
+                    reg = <2>;
+                    clocks = <&scmi_clk 103>;
+                    clock-names = "ref";
+                    phy-handle = <&ethphy2>;
+                    phy-mode = "rgmii-id";
+                };
+
+                port@3 {
+                    reg = <3>;
+                    ethernet = <&enetc3>;
+                    phy-mode = "internal";
+
+                    fixed-link {
+                        speed = <2500>;
+                        full-duplex;
+                        pause;
+                    };
+                };
+            };
+        };
+    };
-- 
2.34.1


