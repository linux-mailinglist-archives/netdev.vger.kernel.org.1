Return-Path: <netdev+bounces-286588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOSpHHqsAWoMhwEAu9opvQ
	(envelope-from <netdev+bounces-286588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:16:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4FC50BBD6
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BA32300844B
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFF53C3BFC;
	Mon, 11 May 2026 10:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="IqTE7J/q";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="IqTE7J/q"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020134.outbound.protection.outlook.com [52.101.84.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06C734A3BF;
	Mon, 11 May 2026 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.134
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778494332; cv=fail; b=theiVCNz1J4PcXra5hefmOyI0nL/9NbvU4rfUjRlUKU2L8dDxMjGUo2RFIEZTYHoj4eSbHOdBaLKeICtLFj4TaaD1QLF6pp013X9EWb5qry1Hl3NjpW0H6uJs0+/YYwOuah94Y1TEbpt1VwYZ4/Egpgz4kInAogVFhV7agmgMAw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778494332; c=relaxed/simple;
	bh=pPy2cIWoTmGIz+Y1/FeNVME9oqkbocOhVZWwlGx+6Jw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VMMaj4rsFRsr1nnhTRwPgXP/L0nRkLPYIqP8tJri6gIZMfVUoKlzrhN37MKVlKFKBN5CnxhKnPZLV6nRt/Qyt3XYUrU8TvE/DRZhKLDCaop/2n4kdnrVm3Pf3g2wwwMS2xgkvDMQYmkCELAcPJCPCX0HZOz729fnXhQDObSCSf8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=IqTE7J/q; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=IqTE7J/q; arc=fail smtp.client-ip=52.101.84.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ONzPAaJ7xTaVx4KT5i9xuDjmqEDNpK+fQp/Iak4nG2TWVBkYUzpSctLk4tFdgREyZ8Hk10axv5ca20WOBJiyRzFvR3ThKnEP3jEzuQwdnTQMll6GBtlQ8cpVLNee6k+G4YORccmmag5KDT9qmAOHhNiiGaCbtoC0O/C0bFxxOI7Rv89URen6MaLHcmqKT55Sbp9GqRn4QrTze6AEYawiYAuagve1uZNX4XwYZanBDlDt9NhjjN4AAinGUQWDyxWeFun0V4EHtWL8fW7JSTA+pCBiOjoBzl7ejK1fwoXi9ECpDl0YqcGF/MK6mT5V+hjnHtmRa0H+zdofauecZ/k7dQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkaDxcWa10CrweAFKjBqjDMuZorb4Fm8cvHDO0Femng=;
 b=k5f+LwqEwW8qp5R7YfbMfdhAcBiMMbkDAdlmqwq3OdETSZF9HKQ6ZO/ZESC4o83Dggsa1l2cH9GzR2aGaG86leScDBhXNK5//pZ11MluxwwpLrQu00BF9HUSjk2dG75glGtskaodTkaonJVf5q2DsxaduNcQpg+xVJ4FksVgU0GqWfMO3mW2FaoLKIS4j71Gt1R8jzB1fxTc96lT91Qq9BH42X658siieRubUctgCkRDnt0NvmOhQzmsNQz46l3lIYRgbGZUOlRnHL8pZ0m/xX/ktpps1xv51iuSwuxJumYK0Fz+BsHYyyV8rpNMNG/3x34nT+KYlOhUaAYbYTEFBQ==
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
 bh=vkaDxcWa10CrweAFKjBqjDMuZorb4Fm8cvHDO0Femng=;
 b=IqTE7J/qGfTCKuhwIc2rq6Gw95Ro5SjXfWC6PA8fyicMxPoRt/oUpuI7NAoWKyB97XZmjD18znRd6hql4m4hg54JcwBhPd2sc6tXXoTAZY1dGmJltHKFmWvbmTu/F6HYZ+0Zf3G+oFZR0jdgl4d3pDFSE6Qy8UltSXXWn7LmKFhOfLxnj8gtVyMis9X1EQGbip16l/sHQCxnB5qFVk7Z2+fqkkdyI1nzzY+HnfNOOFzMcYfSeHEp2kaf+VlnLnC7FKS9AKoSlnlurNiglAcuX3THOO+Z6StRKjW+WtOFlhr5FCtbtIVIUQGv9PP5tyZjmheMs3PVbQBi/vRokMRFUQ==
Received: from DB3PR06CA0027.eurprd06.prod.outlook.com (2603:10a6:8:1::40) by
 AM0PR04MB6785.eurprd04.prod.outlook.com (2603:10a6:208:189::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.23; Mon, 11 May 2026 10:12:05 +0000
Received: from DU2PEPF0001E9C1.eurprd03.prod.outlook.com
 (2603:10a6:8:1:cafe::d5) by DB3PR06CA0027.outlook.office365.com
 (2603:10a6:8:1::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 10:12:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU2PEPF0001E9C1.mail.protection.outlook.com (10.167.8.70) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.8 via
 Frontend Transport; Mon, 11 May 2026 10:12:02 +0000
Received: from emails-1572976-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-220.eu-west-1.compute.internal [10.20.5.220])
	by mta-outgoing-dlp-588-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 8609D80003;
	Mon, 11 May 2026 10:12:02 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Mon May 11 10:11:40 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naPObyq1/NBCVm8rRzP11+ORDWC7UbdmN/M0CHgBFYz5pdfK5uCvhP3Dh8BRSFYbj2gW24aVPwlKTusYUx1TYlaGEjKyMlXHQdzdGmNQeCqoK0PMGfJBM+/yGL44RlqNgEeThGHpBgHUcOaROAqznITx7O3C7QDasFaj2hb4jFiGa0D+J+KOiWaqVIALKEZ0mg7E6LEW3rqokO1KOq0UPUFND7857sGQEzmVyo7Gg63eAgG4o0JFaek5Mjh80ZgfcPSp4U0iGqc8icSPeJ7pMPCX40Km70hV9cQnGUwbDVqAew0zHW1Ncp+j7fWuwB/a+TTYKHTLk9rtrtUem0yXLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkaDxcWa10CrweAFKjBqjDMuZorb4Fm8cvHDO0Femng=;
 b=gClMETYXr9tjLPw/BdqZyeBWxo+wGX4XC7MwZ1gvOLmOWv9k6lDEttRLEkjVy3itsqKIhqFHsxojTrencAGuWnpv1IFQeTqeLFMGeTkrOTToUqhkNTlFykccbdIZTf4Avqmpr2rcwYgSkbGwwI33Bg4V6rf1m00TnH00MTc0igZ16nui+YUsOeyGVn8JO/4NSqA0ZwtsUDtU9u5jjbljasSfuOHnCqN6W33DJesAmmd0DEh1OyGF/8/Z4m5NOr4ZcjE1aSvVh1buPQLhD2t96ixSxXO6owybriQN8C5QQ7t9K94ULI63B5LovgHYfAn72EBkMoxIG4dWIC8myrS1Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkaDxcWa10CrweAFKjBqjDMuZorb4Fm8cvHDO0Femng=;
 b=IqTE7J/qGfTCKuhwIc2rq6Gw95Ro5SjXfWC6PA8fyicMxPoRt/oUpuI7NAoWKyB97XZmjD18znRd6hql4m4hg54JcwBhPd2sc6tXXoTAZY1dGmJltHKFmWvbmTu/F6HYZ+0Zf3G+oFZR0jdgl4d3pDFSE6Qy8UltSXXWn7LmKFhOfLxnj8gtVyMis9X1EQGbip16l/sHQCxnB5qFVk7Z2+fqkkdyI1nzzY+HnfNOOFzMcYfSeHEp2kaf+VlnLnC7FKS9AKoSlnlurNiglAcuX3THOO+Z6StRKjW+WtOFlhr5FCtbtIVIUQGv9PP5tyZjmheMs3PVbQBi/vRokMRFUQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24) by PA4PR04MB7789.eurprd04.prod.outlook.com
 (2603:10a6:102:c3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 10:11:36 +0000
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b]) by GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b%7]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 10:11:36 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Mon, 11 May 2026 12:11:30 +0200
Subject: [PATCH v4 1/2] dt-bindings: arm: fsl: Add SolidRun i.MX8DXL SoM
 and HummingBoard
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-imx8dxl-sr-som-v4-1-64381b3bf80d@solid-run.com>
References: <20260511-imx8dxl-sr-som-v4-0-64381b3bf80d@solid-run.com>
In-Reply-To: <20260511-imx8dxl-sr-som-v4-0-64381b3bf80d@solid-run.com>
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
X-ClientProxiedBy: FR2P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::20) To GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVXPR04MB12057:EE_|PA4PR04MB7789:EE_|DU2PEPF0001E9C1:EE_|AM0PR04MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: abbc0dfc-dbd2-4876-0580-08deaf45bf15
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|56012099003|22082099003|38350700014|921020|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 rl6xQYzTUoAol5Zbxi9eB+yPZV0otS3BkIeFlIrJnoIj2BN/Y9ntnnFuNLEe66TIHHjDFCwTt/DDLFSGJDoAtzVPs4HkHnEoZHBKYTMaY7p4xaAXG6kshjMR1KsweuMWoKIcw+JYiIAsHKLEg6BJNVoDhhPCN0LhbNbelcTnXRfv+3bNxEw+Y21KBpXfiHZmHlDuJNkLyQuN++sGF0Uqvn/Jod98qzjEvleHRLs6SNK1DPHTJdJvrXd6wi8R9g4aS84AkxM95OJLp8Mf+EGjBOMNBuN0Fdt6SC97z5xHeLmMUjGn0hmeQqyFPiIXduEut0rMCRtTJatsk2YCsPCfkDQYki4PgBbNIerDQw8za6VDjsNi5kgoHenB456E81e1qGOn4WiXMqTPfSp5LkCUl0iYQzVDBgV+OSh2whGDsQ0tiXc2sMBml/eTVvRq5m24hrX9wH+Hw8EdHyoTID5SgOYc25YvzpnRwYTNU6hBrq3Gm7pt0Do0K/yE6BzM2LTqdibtPqMRn+/WEXHAVyekEEg12syB/AvN7fCX/W4JnBzdtA+xH9I+10UkDtvM64Amo/iA6mW9Yjopk6ShugK3ZkxyuAH5K26e4vNYxzemq7vyh2tC3yYsRlRINQEdAQonptGLoIQSJpToPufA4Bz9kOaqt43b66/MD96K3ENZNvmsyRBl0HaWLJBeQW/0yda6vODRrfS1uPOsZ1PU8b3Rl8pXaQT4Mbh3LNqzstzNd6fFURfnhcbbYe5OVZNEbYWt5IpoX14l/Kavts0O5RcttQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(38350700014)(921020)(18002099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 EsokVOeafFZ0IH3NRBzCarRKJLXP2I/0zw5c8ErbXHN/CndzSRkph/ZpwMi9aSGRXxIAXvzRqKj0DtVN6Hlf5qG5xhYHMsbyG2AHhCtaywVbRUbFASlzdM7kFtEm6kW7iheOJJ+3mn9khpdHxkISKqiP3RWrPKWWYNvawKrap2uQnpNXW+rj95/ilal7zqdjJR0oGcIoYP6dQFn4sejjEf6M0c8Djw3XNLCt1NGOmrJOaGtLs3KzvKDeObRRRzemdtTYMrd5de5Zd7xYrvClCHFfyP+jejUak80B7NWClltmFKJkCeTXbGeKWsIdKaQSK3LOUpqxI7hrt3AYzyCADA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7789
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2-7.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 4a2e6269f9bb4658b9c1e51700437f5c:solidrun,office365_emails,sent,inline:9e1ded0381d41971f98a1151147016f1
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C1.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d4759034-bff9-416b-468f-08deaf45af59
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700016|376014|1800799024|14060799003|35042699022|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	g+wCb7vkcWXdGjURMmikKE1Cdhmv1c9YREbv3euz4G3WArA0me0zujpyMhkURJd6iwmDm9cSnDM+wWqu8kdEJdgXQMlNULJp8cTSNLky9vgZjhHHH2++NSINzyPVk+f5Wqw+cbRf/0Kc7e0jZAakyoPiQifPM6P2BoVD3V9o6jHETI5b9aZGyLdppPhv06RsVRk/RIZeuvw+hrqvWcRJQyYL43IGvKWfoPiBLTRsF7Rg2MA46Ur4chix3QQpRWlpj6gPRJuun3fbZuf19XUoN6qsVOkVtRomk8b7v5OPhZZ/pqrBpQOg5Ck8b/UeHqNWvDAPQR8WyNUliJO8224HoZ52G0fXTZlj2t8qTSWdQWWmqSQJZNP3F7uRlcn5ae4u8y9T/ha/r/Xk/VTDjJD6sfXKMVcHRV0QIWLPhq0y2ypk1OnqTQGPhd0YMImYsraCVpmVmy4ZMApZdgINkex162A11VBI1Crz2hu9NXDUhBWtnzC8vb5C+tjO9SCelLYsosVWtIV9teMXNssGu8WvEPWBoQevO+Q6zSlN6UEOdaDUsbIn8bry7KBGnA6mohD7tcFqeje6pd+GZwczGljx2UpJXYj6+7vjdm+Ne0zupK1ymSfYNtvWTPHzqxoc5l+X9KqcxC0xtTd1kYZnP3K7pLNRpQ3aYBHGlpdnC3/0dlMQKxKTIp5pFggJM1k3+z4cudwzAfEAK6RNzeo3mXqcP8ayvW03alHheaS/S4AOS05eMYKkqkCrbjv1rpZx8sjoXceeA0QbnFCn7EzPWj17WA==
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700016)(376014)(1800799024)(14060799003)(35042699022)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ngpTyZaHFIzAiVgUjA1ymJCl0bLDfp53IzsUremrADK/OdFFGhb9TZqrGc8FZgs8OCTyc6K6R8ywPQ0+8Zk/MbUbRmRa2cz8D2UBx+DmB5SFoJfPHNK2NPtpXSaPiO8YGvFPoCWE8PrHNG4HZAEjzF6oimITSypeWVbynK/bONa00hBX/1nRXH70JYQy00No2LNz+WvYVLVpQKAnAT6PrFC0m/fKYjMmAfB/tc06OsxSTINL8KTkZ6FgxAAjPGXbvSlX7yHEp95Ie928+sTk3wl0jmThpZM0fXt9BI3EKBR9/ct7b0Ivm9PTXYy9Cus7ixBVxUdw2c6lSF16qK1QJbpOmyyZ/lqTB0nvrVCu2+e8Mb2lXjsd8wJjDHeiKaHaOF/Xii44Jh/zwpAGomoYK9rDUFfKHkoahXXCgoP31Q3uG8FShserDyrhe7Ex6bxR
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 10:12:02.6192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abbc0dfc-dbd2-4876-0580-08deaf45bf15
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6785
X-Rspamd-Queue-Id: 7B4FC50BBD6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[solid-run.com,reject];
	R_DKIM_ALLOW(-0.20)[solid-run.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286588-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,solid-run.com:email,solid-run.com:mid,solid-run.com:dkim];
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
X-Rspamd-Action: no action

Add binding for the SolidRun i.MX8DXL based System on Module, and the
reference HummingBoard Telematics.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 0023cd1268075..17cd47e8efce8 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1394,6 +1394,13 @@ properties:
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


