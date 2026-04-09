Return-Path: <netdev+bounces-276977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNzQKgid12kUQQgAu9opvQ
	(envelope-from <netdev+bounces-276977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 14:35:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0753CA7A1
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 14:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B42FF3006207
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 12:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF7134753A;
	Thu,  9 Apr 2026 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="BkA9thBw";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="BkA9thBw"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021082.outbound.protection.outlook.com [52.101.65.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804003CCFB7;
	Thu,  9 Apr 2026 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.82
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775738114; cv=fail; b=su3z6NY7vkNDDx7z1w7vNyAKOkjeDPse24E2sHC/GxmDq8HI79GrZVcUyKXoDemneSQ3aWo5w2bQ8Rr0fbcUH2b1RuXELNcFNoBURYlqX1NyYMwKGfLH+/n8hlFn/wWdSfD7jSDh1OYc6I4bCvTh15kksyKt2RsQdCSxgD0quso=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775738114; c=relaxed/simple;
	bh=9od9vlUbOC23BphhOE9SPn9RMXBzYg8BuBR++r2hNgA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KUdak+wH4x36T7vEdMt+L9kt2n+vLEj49K3DSb2xMHUyzyWJJDfvJ5KkfVlb2z3EwSre48MZzBFRLABPrMX8UOaoz38o4noxzsCPFVxZQu8PNqd30GePo5WtTcST5NDg7hgoFF85DqbVogd87bz5PlafhAWh3bCcbAhigGkzgrc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=BkA9thBw; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=BkA9thBw; arc=fail smtp.client-ip=52.101.65.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=evaa6PB57NBYrKstV7eZh8+1j62nJvBEySAWOydjzgQ3AFAkK3WwOWhVZVN18WiJDB4ybJOgASNIh0AKJyJbweyepE80BLMFi69yI3Io7W/CWohHFQmlYbR+6PTZPVtxRcRiPzi+o10EH5jGOFVu5opIskr+WFzFE73k/m7L99Ld3IlotqhObCsTFnp2MFysSplH7rv4qqbzuugURTlVqrasu3Qd+LnGrO7J2FLr3YIggQXMR/vXV/zaW7JfKtU3IyDnjM0YqbRraKcNfT2txWJkE9qw1NQERvhOFbtintJ0GdCnvo8UDF8Ig6WhQm5tBCVCQ/1Xev0A1vpj/kU8bw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7GIoN/loSqIJIRB4NqP0OmSwrB48AWkXoz/b5LJmEA=;
 b=w/wEvWduz45ixEoLObcM9YPd+rsKRmZFgE+cg9NL6ForQrTp8LLXGn8rc/lKSX5GhiG6jrBi6yCvKI0Ye/4L/JxECj/M8l5jMjzQAhoGDonn4/bSLTaFmWypm8DLqD0FdzSJ05d1Iu+VqBKogUaY0B3dH8d5rQR68Xqce/tqrEIJd9OgcNowWbRxnINvE3D7+Z1XHr7jOssadRrEFhj5DDiCFYeZWpqZAKB9jcK5SF8Sp0qTrr5C82jRiaNvEBGLNumxs5k4uBp1KEfpRuwNBiMpSKGjlBZQZ9F+2W+O1B8UhKYpUafwFyBymoQms2Fp3HqujLOMhopsqz50AvZMrw==
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
 bh=A7GIoN/loSqIJIRB4NqP0OmSwrB48AWkXoz/b5LJmEA=;
 b=BkA9thBwTmPTDwWhd8epfdCrnruwQ2TXSoYyKsJhaagvN15FObv1MUiK881ycNoiASWG8Tjf0I731GeeGTuMX//cPcM0KCpx/+nClqR9XzYqhg7RKmDY0sjnCTQpbD47XFExNCLkpeihCacC9n5bIyxfyqr4q16dQwmbnNTiJtEth8V68Dr59MH1uwF70M/HsBfigwMktjAsri0zb09fwSeVEQU7YTWayBWKy+zjc+84hdd0pxN42U4TlvfOKEIphgV53EK3+ylRX+9eF+a6XVOYoHb80rTAOn0OWi7YzvBpFh0bAWZUU0vSwxo2LqhZuCz2fL8FEmwfDQUiiaMPfA==
Received: from DUZPR01CA0172.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::29) by AM7PR04MB6917.eurprd04.prod.outlook.com
 (2603:10a6:20b:109::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 9 Apr
 2026 12:35:05 +0000
Received: from DU2PEPF00028D0B.eurprd03.prod.outlook.com
 (2603:10a6:10:4b3:cafe::2e) by DUZPR01CA0172.outlook.office365.com
 (2603:10a6:10:4b3::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.40 via Frontend Transport; Thu,
 9 Apr 2026 12:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU2PEPF00028D0B.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Thu, 9 Apr 2026 12:35:04 +0000
Received: from emails-5314529-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-16.eu-west-1.compute.internal [10.20.5.16])
	by mta-outgoing-dlp-431-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id EAC9480F1E;
	Thu,  9 Apr 2026 12:35:03 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Thu Apr  9 12:34:57 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHNeKFxdJN5TcItU9Q/H13yIl2kl5BBKthpZlLhxgtsPpjne8lG7rvNA/IiB2rTLHDXq2/Hh3J5nPZ0wQPvawyM8RsZdYQJxT5CHXpqMEeHkWFpRdQxz4RrtxBboAjE+ApsFzJ4fHus9A2nRv99OGjQEeut1pyPUAv37c+giVNxTOQs0w44RL5SjIFoDkDSha62rgGisem4G7axvaIitqEH5QhjuSc9p3Q92Iq6RUOXZvtQpHIlwwIznnpbClTfZSDIE9DTPRQcpkMb+PzGjrZ7ONOPiQeUbJ4kSuZII4uii/gWXfIUa9EFJzIb5E1yKEbDuytKKpU8eahxSz9m9/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7GIoN/loSqIJIRB4NqP0OmSwrB48AWkXoz/b5LJmEA=;
 b=RlmoJNW6LLxooQ23QY3523bs8CAyxc5MvSGG6ShcLYzSC0+6+bPM7Cf6tvYcQueavHgeEhi2i3cU5X30tipJspa6txKng/eHNehsH8lnSIqMwwchQCaUkbHsDnqb/ZuOuTZ2QQrrh+xAbysEfEm2r8/V+wfxn4WyGAUaAAIhiQELdHJnNoagVH4WdzESplCyYI//DqPABmAvWsd0gli3W7DDCE81v64RmzJvRMVaWLmbI3pO8GLufDcIw8pQVsDFEPylAhlzNhRjzK69fp/N7DusM+kgXGS6HlIsYJ++w+cpjdbxL3IIoU6bYi/kcHWnwSke1ZoInd7OtIsmu5XypQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7GIoN/loSqIJIRB4NqP0OmSwrB48AWkXoz/b5LJmEA=;
 b=BkA9thBwTmPTDwWhd8epfdCrnruwQ2TXSoYyKsJhaagvN15FObv1MUiK881ycNoiASWG8Tjf0I731GeeGTuMX//cPcM0KCpx/+nClqR9XzYqhg7RKmDY0sjnCTQpbD47XFExNCLkpeihCacC9n5bIyxfyqr4q16dQwmbnNTiJtEth8V68Dr59MH1uwF70M/HsBfigwMktjAsri0zb09fwSeVEQU7YTWayBWKy+zjc+84hdd0pxN42U4TlvfOKEIphgV53EK3+ylRX+9eF+a6XVOYoHb80rTAOn0OWi7YzvBpFh0bAWZUU0vSwxo2LqhZuCz2fL8FEmwfDQUiiaMPfA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24) by DB8PR04MB6908.eurprd04.prod.outlook.com
 (2603:10a6:10:116::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 12:34:53 +0000
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b]) by GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b%6]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 12:34:53 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 09 Apr 2026 14:34:34 +0200
Subject: [PATCH v2 2/3] dt-bindings: arm: fsl: Add SolidRun i.MX8DXL SoM
 and HummingBoard
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-imx8dxl-sr-som-v2-2-83ff20629ba0@solid-run.com>
References: <20260409-imx8dxl-sr-som-v2-0-83ff20629ba0@solid-run.com>
In-Reply-To: <20260409-imx8dxl-sr-som-v2-0-83ff20629ba0@solid-run.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 Mikhail Anikin <mikhail.anikin@solid-run.com>, 
 Alexander Dahl <ada@thorsis.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: FR4P281CA0378.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::16) To GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVXPR04MB12057:EE_|DB8PR04MB6908:EE_|DU2PEPF00028D0B:EE_|AM7PR04MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 1da8c3e1-fed9-4c72-a7e3-08de96346ccf
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 8IezhQDwvyu6NFacoYCg0lJ+TJIq9S7dz5edVY5ardExERq/hg+Lhs9QoRdmDwmGBXdvQOzUtyxlCgx+NxvI/nZInsOCno+ICyX/dM/EqchbFlAxu+kj96k6kOq4Pb4+TT+3wnXgQkJgn9B+IYyjo65NQwwfCs4YBFdhm9O/ipxDEaM5i2PgEgdRz4CPyn6rj5gjS8EI2z7F+Qir9jao9YQ18OjFTY5a4QG5mFrIp+fLSUE07KV/TwB9KnG2PylEw9D+hP4hFvMKoVTNSh5xMgb0D+PjOvYZ398i3yMOUKraPpg8KGj8uurJnJpMSue8UQo7XobbBsgnahHZ7oMBfwFRhR/w1JkmAx6YnuSylUOGNL33+K1yWbtpgw3SinLRsJ2fRC7q1F9w/XoFhUMwdhj89EXmfT5E3Xb05FEnfl5yDYLg6230tHklGQVMq2AT4Z4JkBNoILp+S/fAJrvuBjqVLDP6hILN1cCr6eGCaxDls/efm939meguup0a6K3xSSWRAhDG2bsfE92/Vx0xH7eJTMScS96TBsfC6nrpCAe3V/lCY0bntvXe9EFmzJHcR2SNFKQlWwXeVcDAMbarnuDwDt66QqtNROS+YaW9dJigMkry+yUJc3TqFTr3jS5hPVvUlPz6m5pfX4O/v7O1V8+0AVBK3XdLK/tWyYdFtwg3MtqErBSDV+bWbVIyO7uRf/2Jrq0nBbL7qAgND2n3HOGVLxf+Dnd90KhofJ70ZuTcm+fOmXy23sRsl0hC/rwcGDH0/ftJ5Tt9FR5mk2s1vf+Aa4dRO/VI8uH63SsBQDNkTO3hpj0/WDgk4GXHlvOk
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 u82bpdZG15eGhUFXEp0UNumRz29SE6DhNHsHleMW+5bmweBbs9Wpgia3inbbPpiYSQKASxXJafQpP930Fnopb/3FcsNTahm5dAMCEO+Wi0TB4XjSEywiQ9/bKkOWTcEHNyhpxoMoyJnfUiNKyG4m8akFy2iOQPBDHiuzYHakDDqR07UgSAuwic9AQfi4cEANubXpE3lU/L6FqJnowM3bFo3X4gSdZZXXnwMd+QPPVDCvdk9uQRyQIbPeAgfwCneSRve6lXASc2+VIZjSHelkRPAPxxqiYepAJPq2OlPp1gwAPim/TgaA9cvAWotGCG5bZrGdIL6aHZMFy9b6+RoiiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6908
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: be9c63492f87499cac099b2ce6d73fda:solidrun,office365_emails,sent,inline:5c2637788cb1ea3bc6e1f3198e4b9941
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c238524b-bb69-4e74-e945-08de9634665a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|14060799003|376014|7416014|1800799024|35042699022|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	qDJi/i+4WnU0VZzo60l8h9c1AwRZSCBYpMkv5o6XaWlQqUTgcTQrlhXJ7ED5RCO2YFizqANRDK5GpHQ89FW84mc49icI+4Qu0XOZH7LmPugbqsuY7Gc4BRuGgRi+tHzoBX23jkApe2kXiOT2ncHrFy9LjHehysRV9Gxf3FFByG9gqVKyeJ3YtGa9j168OH759hq4Rh+Ehx2q/b2N0/oDvZG3Kag3SkifaSkbj4aqzV06uuA1zSIeu6YGzNxdW6sz4jOHUjobxvj2BWGeOuhcybJ5Tj5yKQ10WAFnrucYGk/SvM2RxFminPKRdyUi9Ynh0GndGwbf6Z1t1Wsx+j8wjqX1U+bsU1DJbfbzhQXkALlq/JHDmzgkdmutV7sFL8GLc1rmI9UambpYSt/pB7OyTOFbs+asEosNG86QbGEGEsE2pT2Xfq9bh5j09MrDml+Xmv2QzIhmGTqRwOHO8Hj3dBTGnvfIPffsGAtCuBbdvngcfNBPZwxXXaNzzpRqnvnTiTshBDVR+0Wg71ak4zNqjACX9cyCsuGKu6y3VWFK58NT8IBto7oqzHA1iwfppzqq+zWVh+xJ3IKLkbqbg8yTbC1KoUzAt45+uJa3VdYYlUa5pM++LlghvPDjyrUI7h4dCjgPyuj9Qxz4VgppSeQ/qijzAJNygQUNtsrYH5o/iu7z33YGCq5eoN+CSlRuEvlGyv822xMZT44TUVOGF/lrXep2OXvciDVyGFn8tuGx4hpClLN411GPOry94wSKOrxoySc6ORPNeuj32G2KOL8HnpaIDpOXuzd0puSY3d++hWYfvOhpoNV9As80wv2agzUA
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(14060799003)(376014)(7416014)(1800799024)(35042699022)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ADjbs9GEH6q1p3C9glabuNv/TOdBRD9wsMK/1jEHgn0sbwnzDjR50RrGl3CrxM7WnrmCikqlCXAn19Rhs66HCqQsg3c0L5i3lJ27PFrKQtKeyL/n/afDPsZ1eFFkbpRwgBEDRPqWd6D8OMz3m4+ERfF1wNcBmnpDgOedhcUilIRoR75etnlnKf1ur7Cs9lwV6Hp99GOUfSZ/nnYqh9in2Jyb7BcSg0TWHqfVQMh553nKvttizedMlzFpxbtL1YSqGugioU2xB9lSTzAgsk9VyPV/3RHnZWppNA97Ow/LOJ1IOeFAY39VbbBG4tfTo82DUiI9t7mopfKaOHEIpctNBknAFD7m9wKDfL+YFTN3fH2Qt4wySrfYABT2bAoBK1OjTFlJ/dCMnMUih3RR5m5Lqen6piuJOBFZ6x2mWYXyrN1RaAtFLwREPYQS7oRngbJk
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 12:35:04.0784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da8c3e1-fed9-4c72-a7e3-08de96346ccf
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6917
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[solid-run.com,reject];
	R_DKIM_ALLOW(-0.20)[solid-run.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276977-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DBL_BLOCKED_OPENRESOLVER(0.00)[solid-run.com:dkim,solid-run.com:email,solid-run.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solid-run.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: AB0753CA7A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add binding for the SolidRun i.MX8DXL based System on Module, and the
reference HummingBoard Telematics.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 5716d701292cf..c7a885159318f 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1376,6 +1376,13 @@ properties:
               - fsl,imx8dxl-evk           # i.MX8DXL EVK Board
           - const: fsl,imx8dxl
 
+      - description: SolidRun i.MX8DXL SoM based boards
+        items:
+          - enum:
+              - solidrun,imx8dxl-hummingboard-telematics # SolidRun i.MX8DXL SoM EVK Board
+          - const: solidrun,imx8dxl-sr-som
+          - const: fsl,imx8dxl
+
       - description: i.MX8QXP/i.MX8DX Boards with Toradex Colibri iMX8X Modules
         items:
           - enum:

-- 
2.51.0


