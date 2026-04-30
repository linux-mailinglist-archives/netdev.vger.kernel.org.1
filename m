Return-Path: <netdev+bounces-282825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMunAvJH82kMzAEAu9opvQ
	(envelope-from <netdev+bounces-282825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:15:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A42A34A2A6D
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FA3C3009CCE
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 12:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFE7402444;
	Thu, 30 Apr 2026 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="fQ3h/K0T";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="fQ3h/K0T"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023100.outbound.protection.outlook.com [52.101.72.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB8B377034;
	Thu, 30 Apr 2026 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.100
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777551308; cv=fail; b=SHwhRDIldHhBlzmLBrRzskbhWxuda/0Ihg4EEb3FdZIeOygwNRqj5JA/ecCV9WAu1FDpuQWsGMP2wgaNs0irph5KxhfkpjIAdqHNRlgQUprJYktlVhQm+Vr6wNSk8ZMMbhgYju+QKADaNa/BLHXKqLAFl0dfU+Sr7ZUB4IoegS0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777551308; c=relaxed/simple;
	bh=W+XRLYRkX7jayok+GMg+mg/MoxXXMukxFdTPZCdf6WM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IYp5mSPI95DfjjOKQWGEo4zVCq9dVpWQAXj8m6tCNPWIlq4W4vgZv80Mzld9PdyuE9l/tW0EuZ6LXG5lcmBPGGwFd0vuviKyFzEm4ZIgmwBqU1VxXeAHLZplRBUNh1xpPdSxf6lPJWXqadgdEalLEv3VMp/XubDxHPJSEFip+Rc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=fQ3h/K0T; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=fQ3h/K0T; arc=fail smtp.client-ip=52.101.72.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=SCkdtjuhZI3FjNujnmdJhSCmFcSBf/oP4/8jhxsL8B0HxH1PeOmxh7Hckxsi4dHciJUsiqMIiz0RmDseuPIAqOHZpP3EdFnJXG9ligJ2lkV7JH6D4C5ZULa/I2OPQYEJS/6feD2sNY2YP4eg9xRcgjf1MMx//elyTjcFo3G9t1B3xvWjhC3NqXMS8PAjEU5eVB+j0OllpVNOg/ZPKtLyL3z3kkBEU+4K5Rlx8sZgcFbf16Q2sOqNswxVjrdiwKSr8cIoKqFZInDvA9ho9qod7n7wDefQOGTqxLKYQuO1xDsyeZzLxWZlgjDak0pWYRMRQi6eZ+lcU/vWbKLgjpNZiw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+XRLYRkX7jayok+GMg+mg/MoxXXMukxFdTPZCdf6WM=;
 b=VVb2e3KeDXRTh8m7TWm2R2CE7/2hVzkGiwei+5e2yKdAhNBe4/EayutqvxbH7qUUcJJxXcDt7+E8/GyyQZZ8HFbVBObI9W2rlX0lLCKLf4Pixy6F1Pg9s/Krdh8bIvWVv+b87mMSOj9brQK1KKVboUen5JTap6MazhAcZBN1YbIRzhNHFudTQA33UvDx7p9NmMc3colmUbABwd0I4tZwwFbJkSzAmKr3BvX9W8q0pMgxInsyQCNCQX1iPwavSkE+4Ia4CpT10YJSKqLR7n9gfG/mJwQMo2k8BnxCQplWYdXTkMygZVqALHoyK74qunDEzs2az0pLBExmiobmD+lmfg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=davemloft.net smtp.mailfrom=solid-run.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=solid-run.com] dkim=[1,1,header.d=solid-run.com]
 dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+XRLYRkX7jayok+GMg+mg/MoxXXMukxFdTPZCdf6WM=;
 b=fQ3h/K0TT3rArw1u5N3bTycd2SUHCoxVGOWNMDjG/Ro1fctZRjn1Iz46dmzLGVwhfEdtyGQBmY49KqntIoGLbPou3xjO/HnfkdBhFRTaJ8L0GEvKnLn1GQFc8Ye5lOfg9UvodGmveya9m1ckNd8o3o6Lz4cLhvCtkrUcgibUyY8J43nyBKq+C6qdlqR4it5yMNLKUJYeMCPiYsUptCzIw8fA+zRNAyGXBoFObJm8smqqb5KkNYrs+noYMsgRhNUyiA0Y33wnMByjJLrHxDzO5Z07rbHnENbp+qDOc63pSHYN6iRVWoEeCa8+P1J/M6eUPan7FnO2DLxOlEGz5AybGw==
Received: from CWLP123CA0065.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:59::29)
 by MRWPR04MB12118.eurprd04.prod.outlook.com (2603:10a6:501:9a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 12:15:01 +0000
Received: from AMS0EPF000001A0.eurprd05.prod.outlook.com
 (2603:10a6:401:59:cafe::1a) by CWLP123CA0065.outlook.office365.com
 (2603:10a6:401:59::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.31 via Frontend Transport; Thu,
 30 Apr 2026 12:15:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF000001A0.mail.protection.outlook.com (10.167.16.230) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.22
 via Frontend Transport; Thu, 30 Apr 2026 12:14:59 +0000
Received: from emails-9989122-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-243.eu-west-1.compute.internal [10.20.5.243])
	by mta-outgoing-dlp-291-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 3E56980432;
	Thu, 30 Apr 2026 12:14:59 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Thu Apr 30 12:14:42 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvFeyNYcvNpJUoyiUbLlXl/CLhtx2uKc1OJVKf5OFZkIkIc1A0ltZzpFIlOOTpcN167enZ1/wtHxtVdRC02+snNgEkfVO83LjB7YnKN4lqGRaLomt8o5JDWpALg+ZMvBUMSqFxbzQEFbfTy7LbeNYinAikJiRvsaDQFRckMcJ+9cYyjBILl92I4hn26goaTXHxpf/2+jvnIR5+UnieweNdTCYuQqAnbqMRHnisms2p8P9UeWHOLCO9vFJZzaMKI2UtARGuiwhv+uZsWmwG+O1z71QLygqNHbO1pQ9R9vSmMuNYPu7TA/wK4+jVra4LtjWVTN9cz6bOcR5XR40cO4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+XRLYRkX7jayok+GMg+mg/MoxXXMukxFdTPZCdf6WM=;
 b=lq75OTHT3+A4ZMRgjzS2RA1RtUvgF5FAKiirkCs5Gn/KaOTnHe99hhyeoX5p9XoJhy/nnFxrKByjoIGQlcpWW5byg0JJTA8nwR0MK9Ogm4/XyzthrBBovD98PGWkxKZxZxgYkPR6sx7wVECLFt7OQhtHu/kl1n34vLBNOphqdrTmMzrrzyddt3knY5mZKSYdXqII3ytnjxsPXwqZIe15WqD7nXP1hPZEtF/bS8pqJYk9U/BHkSgbCRdCkjqihmq4/M4mv/UdkJ6LogBs5xY3BF5TjF9/bhX4EeWSm/riXpmfiCmdK2PqB+WJoDtbFIeGcp0Z6BeT2OzXuU+Jos+9pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+XRLYRkX7jayok+GMg+mg/MoxXXMukxFdTPZCdf6WM=;
 b=fQ3h/K0TT3rArw1u5N3bTycd2SUHCoxVGOWNMDjG/Ro1fctZRjn1Iz46dmzLGVwhfEdtyGQBmY49KqntIoGLbPou3xjO/HnfkdBhFRTaJ8L0GEvKnLn1GQFc8Ye5lOfg9UvodGmveya9m1ckNd8o3o6Lz4cLhvCtkrUcgibUyY8J43nyBKq+C6qdlqR4it5yMNLKUJYeMCPiYsUptCzIw8fA+zRNAyGXBoFObJm8smqqb5KkNYrs+noYMsgRhNUyiA0Y33wnMByjJLrHxDzO5Z07rbHnENbp+qDOc63pSHYN6iRVWoEeCa8+P1J/M6eUPan7FnO2DLxOlEGz5AybGw==
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24) by MRWPR04MB12046.eurprd04.prod.outlook.com
 (2603:10a6:501:94::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 12:14:37 +0000
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b]) by GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b%2]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 12:14:37 +0000
From: Josua Mayer <josua@solid-run.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Frank Li <Frank.Li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yazan
 Shhady <yazan.shhady@solid-run.com>, Mikhail Anikin
	<mikhail.anikin@solid-run.com>, Alexander Dahl <ada@thorsis.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Conor Dooley
	<conor.dooley@microchip.com>, Krzysztof Kozlowski <krzk@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: imx8dxl: Add SolidRun SoM and
 HummingBoard
Thread-Topic: [PATCH v2 3/3] arm64: dts: imx8dxl: Add SolidRun SoM and
 HummingBoard
Thread-Index:
 AQHcyB1El0M7TqUrrEi06prfauJkr7XWrZoAgCDoD4CAAACCAIAACDOAgAAELICAAAMOgA==
Date: Thu, 30 Apr 2026 12:14:37 +0000
Message-ID: <8069b214-69b7-4a03-ad06-c2e9ed939000@solid-run.com>
References: <20260409-imx8dxl-sr-som-v2-0-83ff20629ba0@solid-run.com>
 <20260409-imx8dxl-sr-som-v2-3-83ff20629ba0@solid-run.com>
 <8efbafe3-0a8a-4005-960c-e8fe62cee719@lunn.ch>
 <bd2e73c5-2e61-4ea1-ab3b-42a6573b31f8@solid-run.com>
 <20260430111924.nvwohy4nexzyiyyl@skbuf>
 <75e338eb-afd2-4e2e-9b93-e9fc36871854@solid-run.com>
 <20260430120341.4sqmblbt2hqoklsb@skbuf>
In-Reply-To: <20260430120341.4sqmblbt2hqoklsb@skbuf>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-traffictypediagnostic:
	GVXPR04MB12057:EE_|MRWPR04MB12046:EE_|AMS0EPF000001A0:EE_|MRWPR04MB12118:EE_
X-MS-Office365-Filtering-Correlation-Id: dab963f6-7359-4489-4c5b-08dea6b2198a
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 ILdGEhIPu+onAwWod2X7pbjAoCdAKHsFfHXlgXiwrQCTfLryr6Opl20acKp59GrhATPeOe/L0lW7uZFu5f5gkoAtL1GpaQhc+FTRGg4d0IF1GcqaAaNZzZsPvFERP94jbBOinjeL8iEB5w4zU5OgjJbm2FM7cJxzImKd1HOBmIMmyJgWZ21coZDQAA6+FxXq6yAwS2E0x25+0jom/w2IcI9WuC86GE/kQgQHWcv0VOo59p736lYxKXiiSHVRdhWUAA8LEZ4Z0H1GU8aF04Z30tjwnCbK/9eGNlHNZWRPD7KabMbwqRF0cN9RVWYW19qVNIKtHs/xzUD1AR7IoIGfP6h/CHdZCDtSX6m7RxNQ6898r+FvTWC2MoGyN5DTr3QG4oXRnkblUMO56sY6f7HtrmZvH9YZo3M+jV1lv18Bj+7Q8MEjx7jFu2UKJ3EXjedMKvepxytJXSOwPSEaIWBg9YlF1x3sDn/DHsxxdlb+I0yNdxXsEG/nV8abm+7p9mc+PIZo3BLhCkWtc4StI8vULHnvmw6JNDUPemKsTDhF3WJDDikHGoE7cyDr52uZoeK9waMt7u5jC6T/VpgutmqBdwdQ87HXZZFn1HXV7/aAd6CPsAA9WHS1UtP6qf/pxeEWBkFu6CuJaEOPl7/w3yMHa3ExXMN9IAwBWNJqJnE5ch+AZZsO+sAeW1+L/P5UWAkCsJrSBg6Hy11mvOhBeglfgcmQrfC0xNP4KkPZgRa5am7xlpn5plqfMuSYrF/PNY7sP6XWfSKISBpWBto5prC9mkrlyaFYg4wk5tbHq6ehOJc=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <50CFF5245F8BCB4694B8A08D67C28A60@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 S4nCex11+hI0DaxTvFdInk5thWNhYBCOscWpmqVR9J0P11B1DCZ0qLUH192X2FZmch+ujJUIW5mGzLkCydKW/CeFGXMnU26Fq/fAJTj2VlKmZNbbkfcIkNTZRRK27rDntdlCeRdqh5nRp/owpo1WDnW6sCN4J20oDnUBjqOkyKthXy33F2TrzaSfAPrHh1yhZGOsHDNrVQL5QjcO3D2UlnQ+q1ovpZ+IIJi9YpOkxA0ncBJx3lX9kmvSbnvYnurUQtxktduYfgkTxBaaypZkg0srSDPQ/1PeGm0jAQcM2iR1gxf8ehPAJXd3YbnWyfIsuKHNLXSKqZYOmcFf3lJAqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12046
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2-6.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 53186ae9e25f4e8d94f637f185115249:solidrun,office365_emails,sent,inline:32512691e92b3a6b496d43564ee1f81e
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A0.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5528a950-1baa-43a8-20cd-08dea6b20c83
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|82310400026|376014|36860700016|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	m1UMSchpSfl0ljgkUN/tmKA6Iz0BbkXcZp60a3L+8Dhs0VfTibejw4XTfqYmXiWk3goDk/wAxAJ1SRKtJdmoH6FIoOwY0C8z9ihr2E2VtVYP2gD38MufLHaHscI+JBxkKVzlOh2hQIjWRhYl7GeayU4Q6Z2JrMjLlmQs3b7jctmsBLvvVDq7HIka4ISDTOI9Po3xlqRNMaEYxOGqc4W1TJEcEZp5WmHXxXq07M80dLu6z8n1rH+9Q1ssM9bPxq1ezkTMERPmS3GDbZAtMxp5iVriLbMVBIsIpjPOrACRtUQRcd1jBuVuYmkHy/fGcvNQUv7NhhT2t9AOnGgvPYGHuDGE16S0QZt7EsHamVd/jkqDlUV0pfpWbAJhcx0BW9YdYjR8YRPA9s1OisEKGRzrFFUGXAXDRivUXKexAhoawQPsTENqo8C6BLZJf5dvFtM9GK/0YmesLpv/ywbRcFjMBW5Fnnxc9I8t45cVx4WRozg5ss5l54ZmUijaLtc8jerAul+rwYAcsXJp/safaGEST6fxP/tUPGZ77bzqMlB0GaKdRCFGcN/kcHJF5zzzrYCN9fir6Styi/sXgKApfUBIGzUrXYKXeDulFcrla3Vig1IRr4c2c76AUiFKeslR1BIxOKKFacHjdpXK4V+ohmvrBMljEPfLHXasQNV4dK3O8U0itUacvbO2tcIj2IADeLQN63TU6HNOoLkM93MidweMHaoPh+vWQWDPN7s3mMToOe65ohDrhMYQfxe9lBD15tpxl04qPyBD58VXyA9WtmIong==
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(82310400026)(376014)(36860700016)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kZwqcRrJLbc5WQd6SSzSmAjBkxdjaynpICoiVcSohjnVjHjyp1O9yOga95QipQ/AhLFv5/6/Tez5aIGi12f7wgiq3Cb5xPT0KivdyEh+SRb0NqwKP2BbGSSDeNca0L4vtYL89YwdEUJtedQy5znP7Mj29u34chZNtz8bg1yat4f7CQbxNICFb2mD93efhz/6BavAaAfMsCrMwKy4ZnFFqSYGD3mSNo00zrjogepF+APxwZysI8YMtlrWCKZTGnx76JeYYjleusNreozb0eCmvRLBwk3SNGbariQ9kqvfi7qL3OwDCWxEeLH7jFXxes1XRN8GJTnEB2qHEtSAzbmV40NMgR4P7M8AMAS5uIkcJwcNLKIf/YIj8AIxKsVDx3BB7iHvTJtG7+9F6iSl2Z+T8okY/xiT6TzdlBsxUHS4D/NUps+Scf3cFchw5Vy0GcIK
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 12:14:59.5154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dab963f6-7359-4489-4c5b-08dea6b2198a
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12118
X-Rspamd-Queue-Id: A42A34A2A6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[solid-run.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[solid-run.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,nxp.com,pengutronix.de,gmail.com,davemloft.net,google.com,redhat.com,solid-run.com,thorsis.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,microchip.com];
	TAGGED_FROM(0.00)[bounces-282825-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solid-run.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

QW0gMzAuMDQuMjYgdW0gMTQ6MDMgc2NocmllYiBWbGFkaW1pciBPbHRlYW46DQo+IE9uIFRodSwg
QXByIDMwLCAyMDI2IGF0IDExOjQ4OjQ1QU0gKzAwMDAsIEpvc3VhIE1heWVyIHdyb3RlOg0KPj4+
IEFsc28sIGNhbiB5b3UgdXNlIHVkZXYgZm9yIHVzZXINCj4+PiBpbnRlcmZhY2UgbmFtaW5nPw0K
Pj4gUG9zc2libHkgLi4uLiBJIGFtIGF3YXJlIG9mIHN5c3RlbWQgKHVkZXYpIGJhc2VkIGRlZmF1
bHQgYmVoYXZpb3VyDQo+PiBmb3IgbmV0d29yayBpbnRlcmZhY2UgYWxpYXNlcyAoZXRoMCwgZXRo
MSwgLi4uKS4NCj4+DQo+PiBIb3dldmVyIEkgaGF2ZSBub3Qgc2VlbiBpdCBmb3IgZHNhIHN3aXRj
aCBwb3J0cy4NCj4gSW4gL2V0Yy91ZGV2L3J1bGVzLmQvMTAtbmV0d29yay5ydWxlczoNCj4NCj4g
QUNUSU9OPT0iYWRkIiwgU1VCU1lTVEVNPT0ibmV0IiwgS0VSTkVMUz09InNwaTIuMCIsIERSSVZF
UlM9PSJzamExMTA1IiwgQVRUUntwaHlzX3BvcnRfbmFtZX09PSJwMCIsIE5BTUU9ImxhbjAiDQo+
IEFDVElPTj09ImFkZCIsIFNVQlNZU1RFTT09Im5ldCIsIEtFUk5FTFM9PSJzcGkyLjAiLCBEUklW
RVJTPT0ic2phMTEwNSIsIEFUVFJ7cGh5c19wb3J0X25hbWV9PT0icDEiLCBOQU1FPSJsYW4xIg0K
PiBBQ1RJT049PSJhZGQiLCBTVUJTWVNURU09PSJuZXQiLCBLRVJORUxTPT0ic3BpMi4wIiwgRFJJ
VkVSUz09InNqYTExMDUiLCBBVFRSe3BoeXNfcG9ydF9uYW1lfT09InAyIiwgTkFNRT0ibGFuMiIN
Cj4gQUNUSU9OPT0iYWRkIiwgU1VCU1lTVEVNPT0ibmV0IiwgS0VSTkVMUz09InNwaTIuMCIsIERS
SVZFUlM9PSJzamExMTA1IiwgQVRUUntwaHlzX3BvcnRfbmFtZX09PSJwMyIsIE5BTUU9ImxhbjMi
DQo+IEFDVElPTj09ImFkZCIsIFNVQlNZU1RFTT09Im5ldCIsIEtFUk5FTFM9PSJzcGkyLjAiLCBE
UklWRVJTPT0ic2phMTEwNSIsIEFUVFJ7cGh5c19wb3J0X25hbWV9PT0icDQiLCBOQU1FPSJsYW40
Ig0KPiBBQ1RJT049PSJhZGQiLCBTVUJTWVNURU09PSJuZXQiLCBLRVJORUxTPT0ic3BpMi4wIiwg
RFJJVkVSUz09InNqYTExMDUiLCBBVFRSe3BoeXNfcG9ydF9uYW1lfT09InA1IiwgTkFNRT0ibGFu
NSINCj4NCj4+IEl0IGhhcyBiZWVuIGNvbW1vbiBwcmFjdGljZSBmb3Igc3dpdGNoIHBvcnRzIHRv
IGJlIG5hbWVkIGxhblswLTldKywNCj4+IGFuZCBJJ2QgcHJlZmVyIHRvIGtlZXAgaXQgdGhhdCB3
YXkgaGVyZSB0b28uDQo+PiBQcmVkaWN0YWJsZSBuYW1lcyBhcmUgaW1wb3J0YW50IGZvciB1c2Vy
cyBpbiBwYXJ0aWN1bGFyIHdoZW4gaW50ZXJmYWNlcw0KPj4gYXJlIG9mIGRpZmZlcmVudCB0eXBl
cyBhbmQgYXQgZGlmZmVyZW50IGNvbm5lY3RvcnMuDQo+Pg0KPj4gUmUuIHRoZSBUMSBwb3J0cyBu
YW1lcyBJIGRpZG4ndCBrbm93IHdoZXRoZXIgdG8gdXNlICJsYW4iIG9yICJ0cngiLg0KPj4gRm9y
IHRob3NlIGlmICJsYW4iIGlzIHByZWZlcnJlZCwgSSBjYW4gY2hhbmdlIHRoZW0uDQo+IE5vIG9i
amVjdGlvbiB0byB5b3VyIG5hbWluZyBjaG9pY2UuIEp1c3Qgd2FudCB0byBwb2ludCBvdXQgdGhh
dCB3ZQ0KPiBlbmNvdXJhZ2UgRFNBIHVzZXJzIHRvIHVzZSB0aGUgc2FtZSBuYW1pbmcgaW5mcmFz
dHJ1Y3R1cmUgYXMgYW55IG90aGVyDQo+IG5ldCBkZXZpY2UuDQpVbmRlcnN0b29kLg0KPiBUaGUg
ZGV2aWNlIHRyZWUgbGFiZWxzIG1vc3RseSBjb21lIGZyb20gZGVlcGx5IGVtYmVkZGVkDQo+IGVu
dmlyb25tZW50cyB3aGVyZSBhIGZ1bGwgdWRldiBpbXBsZW1lbnRhdGlvbiBpcyBtaXNzaW5nIChs
aWtlIE9wZW5XcnQpLg0KPiBJZiB5b3UgZG9uJ3QgaGF2ZSB0aGF0IGV4Y3VzZSwgeW91IGNhbiB0
cnkgdG8gbGVhdmUgdGhlIGxhYmVscyBpbiB0aGUNCj4gZGV2aWNlIHRyZWUgb3V0IGFuZCBzZXQg
dXAgcHJlZGljdGFibGUgbmFtZXMgdGhyb3VnaCBhbiB1ZGV2IHJ1bGUuDQpUb2RheSBJIHdvdWxk
IGNsYWltIHRoYXQgZXZlbiBPcGVuV1JUIGhhcyBzdWZmaWNpZW50IG1lY2hhbmlzbXMNCmZvciBp
bnRlcmZhY2UgbmFtaW5nLg0KDQpUaGUgYm9hcmQgaW4gcXVlc3Rpb24gY2FuIHJ1biBhIGZ1bGwg
T1MgZHVlIHRvIHN1ZmZpY2llbnQgUkFNIHN0b3JhZ2UuDQpTbyBJIHdpbGwgZHJvcCB0aGUgbGFi
ZWxzIGFzIHN1Z2dlc3RlZCwgZm9yIHYzLg0KDQpOb3RlIHRoZXJlIGlzIG9uZSBvdGhlciBib2Fy
ZCB1c2luZyB0aGlzIHNhbWUgZXRoZXJuZXQgc3dpdGNoLCBhbmQgaXQgc3BlY2lmaWVzIGFsbCB0
aGUgbGFiZWxzOg0KYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtYmx1
ZWJveDMuZHRzDQo=

