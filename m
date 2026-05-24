Return-Path: <netdev+bounces-291169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBCuFSvpEmo65QYAu9opvQ
	(envelope-from <netdev+bounces-291169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:03:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0595D5C245F
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 396EE300383C
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 12:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213D03914E1;
	Sun, 24 May 2026 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="khLHWaJm";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="khLHWaJm"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020094.outbound.protection.outlook.com [52.101.69.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E628F3955E5;
	Sun, 24 May 2026 12:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.94
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779624227; cv=fail; b=JYUmoin5/WwPxAIsmv32MOmMX5IdZb+Xev9dRuUsAehag4aTFUBFtC9CNCzelW9U1k8R0uGIj6XcCYKtGXYcqBHH8YpL1m40b3h5Hi6URflK/4bzmBqW9p8xHxZuXMBziVncY4n3NbFT+CI7Qcbc/Ed/MG0WJEaGQJAbKF6ehTs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779624227; c=relaxed/simple;
	bh=U9+8ZQi7+p4h59dHHmIp16Y+5zK7THnINh0eDybNMMs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PHqGkZisltV7JIZnfxrH2eGAR3ed7YQF30zi1XEfVhUTsfT5DgTdFpWhegYYx+R20wbz5DMVG7KmoYt5v8ssuRy9nMI/RrKemoPBzIusC8cNXItzSEy6RpuIzy8EKioBd4d+LVGvd96d3gO9NqEa57KjRSjfD4PQtOhwekmSrHI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=khLHWaJm; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=khLHWaJm; arc=fail smtp.client-ip=52.101.69.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=oAWGSmKaXdqnIIV912ddv8gg4aqvHjETzOjSZI6Ib/1kDq+Cl2olne13dN7z845bHS6aM4Lm4sabRUL9Fx+bnlKqWisgb09jLwdplFqHREjg8mzHB9F2NZZf/Mbh12jRlkpVu8vcaA9zvUj2CZjc1VIutDkD5MMmsETzPfVDVKYBehz9YhzK6g5nGD8bRs1hU25HAmWZfTOmEKm4v0itsczUhROhA3JThwhixDS5tCkTSg14cfB0ixpq7yp19eXCx46XSbh1ciYKY0sQOJyzSVZaX7ilCmPfFohEwz1Vqq+8h9CYF3pisk99zLJXls3bQhr1MCG893PfrEXHDc5TWg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUcIBQ7BOjGlXNCKPPUTiD+9xzpLuk/GtihA/GvZg3o=;
 b=nfsPco5B+kc3NoYrU+nvnv2fdchD9UZeIfhBhH6JS6mAvNdUDUAXwbuqB8Ue8u1GXvpqR7lBtsEL1FTEC57U5cQrN7gWQlCqktT/VX/J9Egi5UX2qxIb65JBqDRcnobKjStc8ctvUHp2Z/8Xz80gTSNhJmQF2XDwB8vwMPmEPqxFkUwxUMqNHLg07S56fkWMn0ic2Sse/u3HYN/G4CDfacTbTwGcmX6Z46Qx/W3OOfag1k06ET1rKEF+7ZkxVKBuslobIJSA2zQ7NURGmsVtJoeBn8gN1FW5MMvwUcuzxovluNWL3Vw89Qi0rbOsEz7nfQXeWzDr+t1/gsB2f5K7MQ==
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
 bh=GUcIBQ7BOjGlXNCKPPUTiD+9xzpLuk/GtihA/GvZg3o=;
 b=khLHWaJmClBEEJf+jPfCFiCL6rtZcL6Fy/hXDd7pw6XITQ8SdBoTjnstS1VjC1irbGpkkEczQ8OoiVm68kvW6MrlI+GD1j439qVR5bwKlNnmDAFNLP+1R7iePr1rStThAVOsDLv+gH1r3I7kBnLPNg1aa6QZp27RSLAeZHUtQ709impi3BzjCsdzowlUhvEGBlD/k+MZ7iTJQMhJ1hue094QiaS/CUgr/rVSQ3Q3Uu+AatR2fKxva0Tu2LwtzOF7w7xG6iCt3ouubBo13d0lIffO07fW5DH9qnl6Myiiemig6XvheuTXx8B2nGbxjQl2fDEdAXKkX2ChueSzgfGcNQ==
Received: from AM8P251CA0003.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::8)
 by DU4PR04MB12063.eurprd04.prod.outlook.com (2603:10a6:10:645::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sun, 24 May
 2026 12:03:28 +0000
Received: from AMS0EPF000001AC.eurprd05.prod.outlook.com
 (2603:10a6:20b:21b:cafe::21) by AM8P251CA0003.outlook.office365.com
 (2603:10a6:20b:21b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.19 via Frontend Transport; Sun, 24
 May 2026 12:03:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF000001AC.mail.protection.outlook.com (10.167.16.152) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Sun, 24 May 2026 12:03:27 +0000
Received: from emails-3038119-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-217.eu-west-1.compute.internal [10.20.5.217])
	by mta-outgoing-dlp-305-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 78BE07FE27;
	Sun, 24 May 2026 12:03:27 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Sun May 24 12:03:20 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKSpIWEj3ctHCmePvMDUkxGGdFpDF9zEjU+WBlL6NdFtC7cvd/FDNX6hPy1QMEuauCa/pDorcUyVtwqXyNKSjQ4KSvM82HgFKRbkMzeaH4TzmXFadsbv5QNmE3cFvSwwsesuEcK9ZPOdO5Obe3+21SpDgW+bkiBwtIkmOPBySM/bbv7B7ysPMSqXc5l2E4kExjtqMr05Mtje1Eyat1586USKAksGzlsQqvURauPbp26W1smojaJybspYDEeJsJaAsS13UvWhhBQW2kLUD0R00cWF3NVOPmPGkh8pRYDVMtrJhAZxjgxkdV9BYZufHKKByMszuoJs3sWHN9KgcgbGkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUcIBQ7BOjGlXNCKPPUTiD+9xzpLuk/GtihA/GvZg3o=;
 b=yoj1c335elPi/WqSpC56lr/qd/M+Q7y/fE5N/jatXsdvt0pKUaGAezxncW6ONKxPTsiiAY2Ggy0yNfxtSeEi1LP72isCoNm6HePJsVsjtNIwHylo4IGvsA1hrb1ZGxuPHcqt/ap3ai5qXJGuw/DIIz966r4heOKjpzBvciS/uG502yN7j9y9+96RgjV0zIR3Pjc9VsMxI/DokC62QimpSy06t9k+7pYcPTjJQaTibS6MgVY23aum87y8Mj5eBKzuNi6O49Z3Lcpqi2wSXgA6b2iLDRyPEF3eOZ94Mi8RO2VKHY80JR5L60v9L1F8QjQj9svLa7zUbxL0EIIQbDdjmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUcIBQ7BOjGlXNCKPPUTiD+9xzpLuk/GtihA/GvZg3o=;
 b=khLHWaJmClBEEJf+jPfCFiCL6rtZcL6Fy/hXDd7pw6XITQ8SdBoTjnstS1VjC1irbGpkkEczQ8OoiVm68kvW6MrlI+GD1j439qVR5bwKlNnmDAFNLP+1R7iePr1rStThAVOsDLv+gH1r3I7kBnLPNg1aa6QZp27RSLAeZHUtQ709impi3BzjCsdzowlUhvEGBlD/k+MZ7iTJQMhJ1hue094QiaS/CUgr/rVSQ3Q3Uu+AatR2fKxva0Tu2LwtzOF7w7xG6iCt3ouubBo13d0lIffO07fW5DH9qnl6Myiiemig6XvheuTXx8B2nGbxjQl2fDEdAXKkX2ChueSzgfGcNQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from DB8PR04MB6859.eurprd04.prod.outlook.com (2603:10a6:10:119::14)
 by AM8PR04MB7361.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Sun, 24 May
 2026 12:03:15 +0000
Received: from DB8PR04MB6859.eurprd04.prod.outlook.com
 ([fe80::65f7:a733:64c6:60f9]) by DB8PR04MB6859.eurprd04.prod.outlook.com
 ([fe80::65f7:a733:64c6:60f9%5]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 12:03:15 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 24 May 2026 14:03:10 +0200
Subject: [PATCH v6 2/2] arm64: dts: imx8dxl: Add SolidRun SoM and
 HummingBoard
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-imx8dxl-sr-som-v6-2-37932c6eb7e4@solid-run.com>
References: <20260524-imx8dxl-sr-som-v6-0-37932c6eb7e4@solid-run.com>
In-Reply-To: <20260524-imx8dxl-sr-som-v6-0-37932c6eb7e4@solid-run.com>
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
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: FR4P281CA0373.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::20) To DB8PR04MB6859.eurprd04.prod.outlook.com
 (2603:10a6:10:119::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB8PR04MB6859:EE_|AM8PR04MB7361:EE_|AMS0EPF000001AC:EE_|DU4PR04MB12063:EE_
X-MS-Office365-Filtering-Correlation-Id: 509b3a56-be89-4129-133a-08deb98c771a
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|3023799007|38350700014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 cIG7M2Hk5F9M8XHOKiYq0/fsmsETuZUvQDdAU9spK9SEt84N1S7Y9GAp8463o49fOw4dfnU6g6DzcHvIYcIAevtUAy95ER/W2XBPh9Jf9UPYEq8TGg++3POerk9jO9I5awSIC5w+YZpRfkEe4D7UFbrQqf9YuKglOB6+5QrBhzBNd/7CNi9CNEL3N/uSRBjntsAGv800mUTFovLOVOfQUoTdCu3CzzkZI16rkwZMdiENk8e9koufv+Z63/9QHnXYc9mDeAIQcNS4Z3s8HrxzeuMFcFc7qL4j/dKDgftSiKuYlV7Y4CCWOBfoUI7vdKapi3XdfvrvhpjfewOtI85IQZpQk3ZszdCXuXjNT9sZ9Tzn4PPnZbovkBKo8XcJiPog+roq0dAx9ncuiEbk5nXYO7K6a80id+7BcfVbvDn29cguVtgj5M7jHhfNOK1A+S5gbkKedPWrWZYxDDRJ+i0KWwF/R+UgKBU7p8f4qRopOrKa+L7lf6tGq1Qu7xIvAQkIn8BkS0W6H/ugXAYz0HO2H09FZUtJff8p3QZd0zcjfkYqS7QQ1LC1HuHmvTbXAvHw/izKagv+6toB/zULHqkB07o0veUzlXfaT/ltNw6cyMnD/Afd/wQBI2qI1p0/qI/4gp9QBScKnuzvbGu9+p00GT/2qKLu2zeaYJwB7wRUKU0Za5NNxCUR6v34q8tgbAxsWDcfI0S3sTtINK5PTpCXZe9ZrRn1FqXBJo2DQdMSt+giDQFTDLT3hAefFsLy1EaUGgl1oiQaPLD8bSHDMp/uaw==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6859.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(3023799007)(38350700014)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 CXOPMGFP3Uc4G/nefcPDK7RLw0EUeHIv2k4kRClToN882MxObu0pAMWY72eycBZvOt1r3eBchlg41XghHOWQt6Gsk1xS5Lu/ZL+JHZHkZxdup73eWkozp0gtOPMA0tvsQT5TFMik0dGwEdmd8KuE50nwCQZ2dCDRFrwocwVuB7Szx9oNU5NJl1aeHuc4y5sdbD3+dmTm9pYVQGaC20ir9F7S4uR1vu7/Lv85rPSi8LCW3gIiKOP4hK0SbhxTkW18KUi+pqs9dL6mID7a/wQKSgAd7/0SYf3f60qK1Xe+Pe18fzg/YVF1GqY5SCA2thLdbuXljO055VFEzIONI1/l+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7361
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2-7.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 8d4f2c4f6eba4653a3c01acfb3d287bf:solidrun,office365_emails,sent,inline:c7cf8257fb41be27326709d216c75fdd
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001AC.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	22645558-29f2-451e-52ff-08deb98c6f87
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|35042699022|1800799024|14060799003|7416014|376014|921020|3023799007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4jamDpXJ+bFmVj1Dk85T/myfrRfM11/gTI0ygI2Tm45mKQfgv5m1dkn+A455cgBJDhO+Oe1YF+30tVocDIEXAvWEAX1AsxmKCH3HhBpEkcRRLgRs/c+Xzi6lV38aXNE1/zJvgYkQVbVmrKGf7Fu0lv00snwAUBgzjdDDf4hEp8PZCqkEW65ycgjTw5NIOTerrkmxnexdbNFqcpq3ElmrweWmGIPiOhUKFVv6UfZSX0hPX+sr1yAm4M/6AwEYhCV/JFY24IYK2WNofG6SpyqjLpLaCYjIcygXkJlXSUHrSgJBcjkHSWXB8ykmdtgcIO+ahtkrS6HlPUQV2WeEVrEsKl2jx6Z4j/Z/TK0HlPJHFa6Tvajre3Y4q2Tg3VJg+js4ItKwUgkKzn4a15CrhEnm6pFioe/is23pFVuBt2TlIEq6Q5Yx8mXiFYGt6Z3V3TpArU9MpJnfNVGpJcxPKzcTw83KlCd3GaebPZuh+l+uinJbs2DLgMu3TTSXQiEezTYzlWhHpq7RBcH1FGmn/VEp7zl4O/GfvFVns52CJp1orBD98mfJ5D+7S9BJcS6KXakegeIYwNFxCXncFPFldtBTVD4rmx+FVGsLNsMau7nb7aV4FmwJekkcOKNDhVB//dNuxN/Oda230wJdM5rLes7svu7sU0YUxp5+TUlJkwLa5xFIQNAHTBsHxr5X1dhdFrejt1UlROSJ3SSqyMtLxdUq6YHHFyn2eynxR+82PKSjxwICmlAplfqPNNYPq8ehpjaT76GLxClQxDnIKYecnXyvdQ==
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(35042699022)(1800799024)(14060799003)(7416014)(376014)(921020)(3023799007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XqoYjue3Vb/W7L1ADdP5+Ctp5Tn0LV0AaeVt51dCQ5GgUK8JmOa3QmrErZuYW4w9yrHwyiAtZQhBSZhtJS8fLxDKqh52QKuia9PxDdvN2mUIka0hqnM3KDzEP3mojnUf7rYA55J6VkVX9beqJVpY8mX5stkeygxniCjAyl0+c8Nq2jlwEEVJKKO8YRm6ywv6qLdg43ssxpm/+wkdJ54NDugfwi33jNKv7eDn9zl4T0ugDd+OAeXyGMtkqGi7Z/395aVtzbSM7GnjE2SRnz0s6TiR3DkcRgAwCid869XvmbX5ORHfJYJCC1ycBRYEE/w/+eIAO7KTldhfdrmmlViAQ74mx1+uacHJzUGC3ja3AVNOwV1GESje/sWu+yqapHuxnsbnfV5Q6iT9tfMZig0c+bt+fQ+q3USDPZQR9cyPBdIUJqYwdxW0+HDGCCydPC40
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 12:03:27.7132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 509b3a56-be89-4129-133a-08deb98c771a
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AC.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12063
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[solid-run.com,reject];
	R_DKIM_ALLOW(-0.20)[solid-run.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291169-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solid-run.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0595D5C245F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for the SolidRun i.MX8DXL System-on-Module (revision 2.1)
and its corresponding evaluation carrier board, the HummingBoard
Telematics (revision 2.0).

The SoM features:
- eMMC
- GNSS with 1PPS
- V2X DSRC Radio
- Secure Element for V2X Applications
- Inertial Sensor
- Pressure Sensor
- Compass

The HummingBoard Telematics carrier board features:
- Cellular Modem
- WiFi & Bluetooth
- RTC with backup battery
- CAN
- 100Base-TX Ethernet
- 100Base-T1 Ethernet
- Multi-interface I/O connector
- Multi-interface add-on board connector

The multi-interface I/O connector supplies power and provides basic I/O
(Console UART, 100Base-TX, 100Base-T1, CAN, and power-supply logic level
GPIOs). The SolidRun Evaluation Kit includes a suitable cable and
adapter board that breaks these out into RJ45, USB Type-A, microUSB
Console, and Terminal Block connectors.

The multi-interface add-on board connector provides additional
interfaces (5x 100Base-T1, 2x SGMII, USB 2.0 shared with the cellular
modem, CAN, MDIO, SPI, UART, PCIe, I2C, and GPIO). These add-on
interfaces are disabled by default in the base device tree and are
intended to be enabled and extended via device tree overlays.

Note that a few components physically present on the SoM were omitted
from this description due to a lack of upstream bindings and drivers:
- Pressure Sensor
- V2X DSRC Radio
- Secure Element

Acked-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/freescale/Makefile             |   2 +
 .../freescale/imx8dxl-hummingboard-telematics.dts  | 560 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-sr-som.dtsi  | 458 +++++++++++++++++
 3 files changed, 1020 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 711e36cc2c990..7db459f666610 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -111,6 +111,8 @@ dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk.dtb
 
 imx8dxl-evk-pcie-ep-dtbs += imx8dxl-evk.dtb imx-pcie0-ep.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk-pcie-ep.dtb
+DTC_FLAGS_imx8dxl-hummingboard-telematics := -@
+dtb-$(CONFIG_ARCH_MXC) += imx8dxl-hummingboard-telematics.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8dxp-tqma8xdp-mba8xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8dxp-tqma8xdps-mb-smarc-2.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-hummingboard-telematics.dts b/arch/arm64/boot/dts/freescale/imx8dxl-hummingboard-telematics.dts
new file mode 100644
index 0000000000000..3095dc87f188d
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-hummingboard-telematics.dts
@@ -0,0 +1,560 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022-2026 Josua Mayer <josua@solid-run.com>
+ */
+
+/dts-v1/;
+
+#include "imx8dxl-sr-som.dtsi"
+
+/ {
+	compatible = "solidrun,imx8dxl-hummingboard-telematics",
+		     "solidrun,imx8dxl-sr-som", "fsl,imx8dxl";
+	model = "SolidRun i.MX8DXL HummingBoard Telematics";
+
+	aliases {
+		/* override ethernet aliases from imx8dxl.dtsi */
+		ethernet0 = &eqos;
+		ethernet1 = &switch_port1;
+		ethernet2 = &switch_port2;
+		ethernet3 = &switch_port3;
+		ethernet4 = &switch_port4;
+		ethernet5 = &switch_port5;
+		ethernet6 = &switch_port6;
+		ethernet7 = &switch_port7;
+		ethernet8 = &switch_port8;
+		ethernet9 = &switch_port9;
+		ethernet10 = &switch_port10;
+		gpio8 = &tca6408_u2;
+		mmc2 = &usdhc3;
+		rtc0 = &carrier_rtc;
+		rtc1 = &rtc;
+		serial1 = &lpuart1;
+	};
+
+	osc_32k: clock-osc-32k {
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		#clock-cells = <0>;
+	};
+
+	v_1_1: regulator-1-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "1v1";
+		pinctrl-0 = <&regulator_1v1_pins>;
+		pinctrl-names = "default";
+		regulator-always-on;
+		regulator-max-microvolt = <1100000>;
+		regulator-min-microvolt = <1100000>;
+		vin-supply = <&v_5_0>;
+		gpio = <&lsio_gpio4 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	v_5_0: regulator-5-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "5v0";
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+	};
+
+	/* can transceiver builtin regulator (STBN1 pin) */
+	reg_flexcan1_stby: regulator-flexcan1-standby {
+		compatible = "regulator-fixed";
+		regulator-name = "flexcan1-standby";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		gpio = <&tca6408_u2 2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	/* can transceiver builtin regulator (STBN2 pin) */
+	reg_flexcan2_stby: regulator-flexcan2-standby {
+		compatible = "regulator-fixed";
+		regulator-name = "flexcan2-standby";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		gpio = <&tca6408_u2 3 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	modem_vbat: regulator-modem-vbat {
+		compatible = "regulator-fixed";
+		regulator-name = "modem-vbat";
+		pinctrl-0 = <&regulator_modem_vbat_pins>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <3600000>;
+		regulator-min-microvolt = <3600000>;
+		vin-supply = <&v_5_0>;
+		gpio = <&lsio_gpio0 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		/*
+		 * Cellular Modem uses VBAT, RESET_N and PWRKEY for
+		 * power-sequencing. USB core does not currently
+		 * support this, keep vbat on permanently and let
+		 * userspace deal with reset/pwrkey.
+		 */
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vbus1: regulator-vbus-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus1";
+		pinctrl-0 = <&regulator_usb1_vbus_pins>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		gpio = <&lsio_gpio0 16 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	usdhc3_pwrseq: usdhc3-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&lsio_gpio0 15 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&dma_apbh {
+	status = "disabled";
+};
+
+&eqos {
+	/* delays are added by connected ethernet-switch cpu port */
+	phy-mode = "rgmii-id";
+	rx-internal-delay-ps = <0>;
+	tx-internal-delay-ps = <0>;
+	pinctrl-0 = <&eqos_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	fixed-link {
+		full-duplex;
+		speed = <1000>;
+	};
+};
+
+&flexcan1 {
+	pinctrl-0 = <&flexcan1_pins>;
+	pinctrl-names = "default";
+	xceiver-supply = <&reg_flexcan1_stby>;
+	status = "okay";
+
+	can-transceiver {
+		max-bitrate = <5000000>;
+	};
+};
+
+&flexcan2 {
+	pinctrl-0 = <&flexcan2_pins>;
+	pinctrl-names = "default";
+	xceiver-supply = <&reg_flexcan2_stby>;
+	status = "okay";
+
+	can-transceiver {
+		max-bitrate = <5000000>;
+	};
+};
+
+&i2c2 {
+	/* routed to J14: SDA(51), SCL(53) */
+
+	/* regulator@18 */
+
+	tca6408_u2: gpio@20 {
+		compatible = "ti,tca6408";
+		reg = <0x20>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-line-names = "DIG_IN1", "DIG_IN2", "CAN_STNB1", "CAN_STNB2",
+				  "DIG_OUT1", "DIG_OUT2", "", "";
+		interrupts-extended = <&lsio_gpio0 20 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-0 = <&tca6408_u2_int_pins>;
+		pinctrl-names = "default";
+	};
+
+	carrier_rtc: rtc@32 {
+		compatible = "epson,rx8111";
+		reg = <0x32>;
+	};
+};
+
+&iomuxc {
+	bluetooth_pins: pinctrl-bluetooth-grp {
+		fsl,pins = <
+			/* BT_REG_ON: io without pull (module integrates pd) */
+			IMX8DXL_SPI3_SCK_LSIO_GPIO0_IO13			0x0000061
+		>;
+	};
+
+	eqos_pins: pinctrl-eqos-grp {
+		fsl,pins = <
+			/* MDIO to Switch */
+			/* enet0 mdio pads supplied with 3.3v */
+			/* IMX8DXL_COMP_CTL_GPIO_1V8_3V3_GPIOCT */
+			IMX8DXL_ENET0_MDC_CONN_EQOS_MDC				0x06000020
+			IMX8DXL_ENET0_MDIO_CONN_EQOS_MDIO			0x06000020
+			/* RGMII to Switch */
+			IMX8DXL_ENET1_RGMII_TX_CTL_CONN_EQOS_RGMII_TX_CTL	0x06000020
+			IMX8DXL_ENET1_RGMII_TXC_CONN_EQOS_RGMII_TXC		0x06000020
+			IMX8DXL_ENET1_RGMII_TXD0_CONN_EQOS_RGMII_TXD0		0x06000020
+			IMX8DXL_ENET1_RGMII_TXD1_CONN_EQOS_RGMII_TXD1		0x06000020
+			IMX8DXL_ENET1_RGMII_TXD2_CONN_EQOS_RGMII_TXD2		0x06000020
+			IMX8DXL_ENET1_RGMII_TXD3_CONN_EQOS_RGMII_TXD3		0x06000020
+			IMX8DXL_ENET1_RGMII_RXC_CONN_EQOS_RGMII_RXC		0x06000020
+			IMX8DXL_ENET1_RGMII_RX_CTL_CONN_EQOS_RGMII_RX_CTL	0x06000020
+			IMX8DXL_ENET1_RGMII_RXD0_CONN_EQOS_RGMII_RXD0		0x06000020
+			IMX8DXL_ENET1_RGMII_RXD1_CONN_EQOS_RGMII_RXD1		0x06000020
+			IMX8DXL_ENET1_RGMII_RXD2_CONN_EQOS_RGMII_RXD2		0x06000020
+			IMX8DXL_ENET1_RGMII_RXD3_CONN_EQOS_RGMII_RXD3		0x06000020
+		>;
+	};
+
+	flexcan1_pins: pinctrl-flexcan1-grp {
+		fsl,pins = <
+			IMX8DXL_FLEXCAN0_TX_ADMA_FLEXCAN0_TX			0x00000021
+			IMX8DXL_FLEXCAN0_RX_ADMA_FLEXCAN0_RX			0x00000021
+		>;
+	};
+
+	flexcan2_pins: pinctrl-flexcan2-grp {
+		fsl,pins = <
+			IMX8DXL_FLEXCAN1_TX_ADMA_FLEXCAN1_TX			0x00000021
+			IMX8DXL_FLEXCAN1_RX_ADMA_FLEXCAN1_RX			0x00000021
+		>;
+	};
+
+	lpspi0_pins: pinctrl-lpspi0-grp {
+		fsl,pins = <
+			IMX8DXL_SPI0_SCK_ADMA_SPI0_SCK				0x600004c
+			IMX8DXL_SPI0_SDO_ADMA_SPI0_SDO				0x600004c
+			IMX8DXL_SPI0_SDI_ADMA_SPI0_SDI				0x600004c
+			IMX8DXL_SPI0_CS0_LSIO_GPIO1_IO08			0x0000021
+			IMX8DXL_SPI0_CS1_LSIO_GPIO1_IO07			0x0000021
+		>;
+	};
+
+	lpuart1_pins: pinctrl-lpuart1-grp {
+		fsl,pins = <
+			IMX8DXL_UART1_RX_ADMA_UART1_RX				0x06000020
+			IMX8DXL_UART1_TX_ADMA_UART1_TX				0x06000020
+			IMX8DXL_UART1_CTS_B_ADMA_UART1_CTS_B			0x06000020
+			IMX8DXL_UART1_RTS_B_ADMA_UART1_RTS_B			0x06000020
+		>;
+	};
+
+	modem_pins: pinctrl-lte-grp {
+		fsl,pins = <
+			/* modem RESET_N: io open drain drive 2mA */
+			IMX8DXL_ADC_IN3_LSIO_GPIO1_IO11	0x2000061
+
+			/* modem PWRKEY: io open drain with pull-up, drive 2mA */
+			IMX8DXL_ADC_IN2_LSIO_GPIO1_IO12	0x2000021
+		>;
+	};
+
+	regulator_1v1_pins: pinctrl-regulator-1-1-grp {
+		fsl,pins = <
+			/* SW_PE: io without pull-up */
+			IMX8DXL_USB_SS3_TC2_LSIO_GPIO4_IO05			0x0000061
+		>;
+	};
+
+	regulator_modem_vbat_pins: pinctrl-regulator-modem-vbat-grp {
+		fsl,pins = <
+			/*
+			 * RF_PWR: io without pull-up,
+			 * has either external pull-up (R1117) or pull-down (R1118).
+			 * With pull-up Modem will boot at system power-up,
+			 * with pull-down modem will enter power-down mode once
+			 * vbat is enabled -> toggle pwrkey to boot modem.
+			 * Hence pull-up (R1117) is preferred.
+			 */
+			IMX8DXL_SPI3_SDO_LSIO_GPIO0_IO14			0x0000061
+		>;
+	};
+
+	regulator_usb1_vbus_pins: pinctrl-regulator-usb1-vbus-grp {
+		fsl,pins = <
+			/* regulator enable: open-drain with pull-up & low drive strength */
+			IMX8DXL_SPI3_CS0_LSIO_GPIO0_IO16			0x2000021
+		>;
+	};
+
+	switch_pins: pinctrl-switch-grp {
+		fsl,pins = <
+			/* SW_RSTn: io without pull-up */
+			IMX8DXL_USB_SS3_TC0_LSIO_GPIO4_IO03			0x0000021
+
+			/* SW_CORE_RSTn: io without pull-up */
+			IMX8DXL_USB_SS3_TC1_LSIO_GPIO4_IO04			0x0000021
+
+			/* INT_N: io without pull-up */
+			IMX8DXL_USB_SS3_TC3_LSIO_GPIO4_IO06			0x0000021
+		>;
+	};
+
+	tca6408_u2_int_pins: pinctrl-tca6408-u2-int-grp {
+		fsl,pins = <
+			/* gpio-expander interrupt: io with pull-up */
+			IMX8DXL_MCLK_OUT0_LSIO_GPIO0_IO20			0x0000021
+		>;
+	};
+
+	usdhc3_pins: pinctrl-usdhc3-grp {
+		fsl,pins = <
+			IMX8DXL_ENET0_RGMII_TXC_CONN_USDHC2_CLK			0x06000040
+			IMX8DXL_ENET0_RGMII_TX_CTL_CONN_USDHC2_CMD		0x00000021
+			IMX8DXL_ENET0_RGMII_TXD0_CONN_USDHC2_DATA0		0x00000021
+			IMX8DXL_ENET0_RGMII_TXD1_CONN_USDHC2_DATA1		0x00000021
+			IMX8DXL_ENET0_RGMII_TXD2_CONN_USDHC2_DATA2		0x00000021
+			IMX8DXL_ENET0_RGMII_TXD3_CONN_USDHC2_DATA3		0x00000021
+		>;
+	};
+
+	wifi_pins: pinctrl-wifi-grp {
+		fsl,pins = <
+			/* WL_REG_ON: io without pull (module integrates pd) */
+			IMX8DXL_SPI3_SDI_LSIO_GPIO0_IO15			0x0000061
+		>;
+	};
+};
+
+&lpspi0 {
+	cs-gpios = <&lsio_gpio1 8 GPIO_ACTIVE_LOW>, <&lsio_gpio1 7 GPIO_ACTIVE_LOW>;
+	pinctrl-0 = <&lpspi0_pins>, <&switch_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	ethernet-switch@0 {
+		compatible = "nxp,sja1110a";
+		reg = <0>;
+		reset-gpios = <&lsio_gpio4 3 GPIO_ACTIVE_LOW>;
+		spi-max-frequency = <4000000>;
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* 100Base-TX on connector J26 */
+			switch_port1: port@1 {
+				reg = <0x1>;
+				phy-handle = <&switch_port1_base_tx_phy>;
+				phy-mode = "internal";
+			};
+
+			/* CPU */
+			switch_port2: port@2 {
+				reg = <0x2>;
+				ethernet = <&eqos>;
+				phy-mode = "rgmii-id";
+				rx-internal-delay-ps = <2000>;
+				tx-internal-delay-ps = <2000>;
+
+				fixed-link {
+					full-duplex;
+					speed = <1000>;
+				};
+			};
+
+			/* sgmii on addon board connector J21 */
+			switch_port3: port@3 {
+				reg = <0x3>;
+				status = "disabled";
+			};
+
+			/* sgmii on addon board connector J21 */
+			switch_port4: port@4 {
+				reg = <0x4>;
+				status = "disabled";
+			};
+
+			/* 100base-t1 on addon board connector J21 */
+			switch_port5: port@5 {
+				reg = <0x5>;
+				phy-handle = <&switch_port5_base_t1_phy>;
+				phy-mode = "internal";
+				status = "disabled";
+			};
+
+			/* 100base-t1 on addon board connector J21 */
+			switch_port6: port@6 {
+				reg = <0x6>;
+				phy-handle = <&switch_port6_base_t1_phy>;
+				phy-mode = "internal";
+				status = "disabled";
+			};
+
+			/* 100base-t1 on addon board connector J21 */
+			switch_port7: port@7 {
+				reg = <0x7>;
+				phy-handle = <&switch_port7_base_t1_phy>;
+				phy-mode = "internal";
+				status = "disabled";
+			};
+
+			/* 100base-t1 on addon board connector J21 */
+			switch_port8: port@8 {
+				reg = <0x8>;
+				phy-handle = <&switch_port8_base_t1_phy>;
+				phy-mode = "internal";
+				status = "disabled";
+			};
+
+			/* 100base-t1 on addon board connector J21 */
+			switch_port9: port@9 {
+				reg = <0x9>;
+				phy-handle = <&switch_port9_base_t1_phy>;
+				phy-mode = "internal";
+				status = "disabled";
+			};
+
+			/* 100Base-T1 on connector J26 */
+			switch_port10: port@a {
+				reg = <0xa>;
+				phy-handle = <&switch_port10_base_t1_phy>;
+				phy-mode = "internal";
+			};
+		};
+
+		mdios {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			mdio@0 {
+				compatible = "nxp,sja1110-base-t1-mdio";
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				/* 100base-t1 on addon board connector J21 */
+				switch_port5_base_t1_phy: ethernet-phy@1 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x1>;
+					status = "disabled";
+				};
+
+				/* 100base-t1 on addon board connector J21 */
+				switch_port6_base_t1_phy: ethernet-phy@2 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x2>;
+					status = "disabled";
+				};
+
+				/* 100base-t1 on addon board connector J21 */
+				switch_port7_base_t1_phy: ethernet-phy@3 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x3>;
+					status = "disabled";
+				};
+
+				/* 100base-t1 on addon board connector J21 */
+				switch_port8_base_t1_phy: ethernet-phy@4 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x4>;
+					status = "disabled";
+				};
+
+				/* 100base-t1 on addon board connector J21 */
+				switch_port9_base_t1_phy: ethernet-phy@5 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x5>;
+					status = "disabled";
+				};
+
+				/* 100Base-T1 on connector J26 */
+				switch_port10_base_t1_phy: ethernet-phy@6 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					reg = <0x6>;
+				};
+			};
+
+			mdio@1 {
+				compatible = "nxp,sja1110-base-tx-mdio";
+				reg = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				/* 100Base-TX on connector J26 */
+				switch_port1_base_tx_phy: ethernet-phy@1 {
+					reg = <0x1>;
+				};
+			};
+		};
+	};
+};
+
+/* bluetooth */
+&lpuart1 {
+	pinctrl-0 = <&lpuart1_pins>, <&bluetooth_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm4345c5";
+		clocks = <&osc_32k>;
+		clock-names = "lpo";
+		/* Murata 1MW module supports max. 3M baud */
+		max-speed = <3000000>;
+		shutdown-gpios = <&lsio_gpio0 13 GPIO_ACTIVE_HIGH>;
+		/* link fixed supplies to avoid fall-back lookup by name */
+		vbat-supply = <&v_3_3>;
+		vddio-supply = <&v_1_8>;
+	};
+};
+
+&lsio_gpio1 {
+	gpio-line-names = "", "", "", "", "", "", "", "",
+			  "", "", "", "CELL_RESET_N", "CELL_PWRKEY", "", "", "",
+			  "", "", "", "", "", "", "", "",
+			  "", "", "", "", "", "", "", "";
+};
+
+&usbotg1 {
+	dr_mode = "host";
+	vbus-supply = <&vbus1>;
+};
+
+/* cellular modem */
+&usbotg2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	adp-disable;
+	disable-over-current;
+	dr_mode = "host";
+	hnp-disable;
+	pinctrl-0 = <&modem_pins>;
+	pinctrl-names = "default";
+	power-active-high;
+	srp-disable;
+	vbus-supply = <&v_5_0>;
+	status = "okay";
+
+	usb-device@1 {
+		compatible = "usb2c7c,125";
+		reg = <1>;
+		vbus-supply = <&v_3_3>;
+		vdd-supply = <&modem_vbat>;
+	};
+};
+
+&usbphy2 {
+	status = "okay";
+};
+
+/* WiFi */
+&usdhc3 {
+	bus-width = <4>;
+	cap-sdio-irq;
+	mmc-pwrseq = <&usdhc3_pwrseq>;
+	non-removable;
+	no-sd;
+	pinctrl-0 = <&usdhc3_pins>, <&wifi_pins>;
+	pinctrl-names = "default";
+	vmmc-supply = <&v_3_3>;
+	vqmmc-supply = <&v_1_8>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-sr-som.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-sr-som.dtsi
new file mode 100644
index 0000000000000..93a0eb4d7f770
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-sr-som.dtsi
@@ -0,0 +1,458 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022-2026 Josua Mayer <josua@solid-run.com>
+ */
+
+#include "imx8dxl.dtsi"
+/ {
+	compatible = "solidrun,imx8dxl-sr-som", "fsl,imx8dxl";
+	model = "SolidRun i.MX8DXL SoM";
+
+	aliases {
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		serial0 = &lpuart0;
+		serial2 = &lpuart2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	imx8dxl-cm4 {
+		compatible = "fsl,imx8qxp-cm4";
+		clocks = <&clk_dummy>;
+		mboxes = <&lsio_mu5 0 1 &lsio_mu5 1 1 &lsio_mu5 3 1>;
+		mbox-names = "tx", "rx", "rxdb";
+		memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
+				<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
+		power-domains = <&pd IMX_SC_R_M4_0_PID0>, <&pd IMX_SC_R_M4_0_MU_1A>;
+		fsl,entry-address = <0x34fe0000>;
+		fsl,resource-id = <IMX_SC_R_M4_0_PID0>;
+	};
+
+	pps {
+		compatible = "pps-gpio";
+		gpios = <&lsio_gpio2 6 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&gnss_pps_pins>;
+		pinctrl-names = "default";
+	};
+
+	v_1_2: regulator-1-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "1v2";
+		pinctrl-0 = <&regulator_1_2_pins>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <1200000>;
+		regulator-min-microvolt = <1200000>;
+		gpio = <&lsio_gpio1 13 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	v_1_6: regulator-1-6 {
+		compatible = "regulator-fixed";
+		regulator-name = "1v6";
+		pinctrl-0 = <&regulator_1_6_pins>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <1600000>;
+		regulator-min-microvolt = <1600000>;
+		vin-supply = <&v_1_8>;
+		gpio = <&lsio_gpio1 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	v_1_8: regulator-1-8 {
+		compatible = "regulator-fixed";
+		regulator-name = "1v8";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+	};
+
+	v_1_8_se: regulator-1-8-secure-element {
+		compatible = "regulator-fixed";
+		regulator-name = "1v8-se";
+		pinctrl-0 = <&regulator_1_8_se_pins>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		vin-supply = <&v_1_8>;
+		gpio = <&lsio_gpio3 18 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	v_3_3: regulator-3-3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		/* global autoconfigured region for contiguous allocations */
+		linux,cma {
+			compatible = "shared-dma-pool";
+			alloc-ranges = <0 0x98000000 0 0x14000000>;
+			reusable;
+			size = <0 0x14000000>;
+			linux,cma-default;
+		};
+
+		vdev0vring0: memory0@90000000 {
+			reg = <0 0x90000000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0vring1: memory@90008000 {
+			reg = <0 0x90008000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring0: memory@90010000 {
+			reg = <0 0x90010000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring1: memory@90018000 {
+			reg = <0 0x90018000 0 0x8000>;
+			no-map;
+		};
+
+		rsc_table: memory-rsc-table@900ff000 {
+			reg = <0 0x900ff000 0 0x1000>;
+			no-map;
+		};
+
+		vdevbuffer: memory-vdevbuffer@90400000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x90400000 0 0x100000>;
+			no-map;
+		};
+
+		/*
+		 * Memory reserved for optee usage. Please do not use.
+		 * This will be automatically added to dtb if OP-TEE is installed.
+		 * optee@96000000 {
+		 *     reg = <0 0x96000000 0 0x2000000>;
+		 *     no-map;
+		 * };
+		 */
+	};
+
+	memory@80000000 {
+		reg = <0x00000000 0x80000000 0 0x40000000>;
+		device_type = "memory";
+	};
+};
+
+&i2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-1 = <&i2c2_gpio_pins>;
+	pinctrl-names = "default", "gpio";
+	scl-gpios = <&lsio_gpio3 1 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&lsio_gpio3 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
+&i2c3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	pinctrl-0 = <&i2c3_pins>;
+	pinctrl-1 = <&i2c3_gpio_pins>;
+	pinctrl-names = "default", "gpio";
+	scl-gpios = <&lsio_gpio3 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&lsio_gpio3 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	magnetometer@1e {
+		compatible = "st,iis2mdc";
+		reg = <0x1e>;
+		interrupt-parent = <&lsio_gpio2>;
+		interrupts = <10 IRQ_TYPE_EDGE_RISING>;
+		pinctrl-0 = <&magnetometer_pins>;
+		pinctrl-names = "default";
+		st,drdy-int-pin = <1>;
+	};
+
+	/* pressure-sensor@5c */
+
+	inertial-sensor@6b {
+		compatible = "st,ism330dhcx";
+		reg = <0x6b>;
+		interrupt-parent = <&lsio_gpio2>;
+		interrupts = <11 IRQ_TYPE_EDGE_RISING>;
+		pinctrl-0 = <&imu_pins>;
+		pinctrl-names = "default";
+		st,drdy-int-pin = <1>;
+	};
+};
+
+&iomuxc {
+	pinctrl-0 = <&pinctrl_hog>;
+	pinctrl-names = "default";
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			IMX8DXL_COMP_CTL_GPIO_1V8_3V3_GPIORHB_PAD	0x000514a0
+			IMX8DXL_COMP_CTL_GPIO_1V8_3V3_GPIORHK_PAD	0x000014a0
+		>;
+	};
+
+	dsrc_pins: pinctrl-dsrc-grp {
+		fsl,pins = <
+			/* reset: io without pull */
+			IMX8DXL_ADC_IN0_LSIO_GPIO1_IO10			0x0000060
+
+			/*
+			 * boot0: io without pull
+			 * After reset, this pin selects radio boot media:
+			 * - 0: flash spi
+			 * - 1: slave sdio
+			 * Once the firmware boots however, the radio controls
+			 * this pin for flow-control to signal readiness.
+			 */
+			IMX8DXL_ADC_IN1_LSIO_GPIO1_IO09			0x0000060
+		>;
+	};
+
+	gnss_pins: pinctrl-gnss-grp {
+		fsl,pins = <
+			/* gps reset: input with pull-up */
+			IMX8DXL_SNVS_TAMPER_OUT4_LSIO_GPIO2_IO08_IN	0x0000021
+			/* gps interrupt: io without pull-up */
+			IMX8DXL_SNVS_TAMPER_IN0_LSIO_GPIO2_IO09_IN	0x0000061
+		>;
+	};
+
+	gnss_pps_pins: pinctrl-gnss-pps-grp {
+		fsl,pins = <
+			/* gps timepulse: input without pull-up */
+			IMX8DXL_SNVS_TAMPER_OUT2_LSIO_GPIO2_IO06_IN	0x0000061
+		>;
+	};
+
+	i2c2_gpio_pins: pinctrl-i2c2-gpio-grp {
+		fsl,pins = <
+			/* io with pull-up and weak drive */
+			IMX8DXL_SPI1_SCK_LSIO_GPIO3_IO00		0x00000021
+			/* io with pull-up, weak drive, open-drain */
+			IMX8DXL_SPI1_SDO_LSIO_GPIO3_IO01		0x02000021
+		>;
+	};
+
+	i2c2_pins: pinctrl-i2c2-grp {
+		fsl,pins = <
+			/* io with pull-up and weak drive */
+			IMX8DXL_SPI1_SCK_ADMA_I2C2_SDA			0x06000021
+			IMX8DXL_SPI1_SDO_ADMA_I2C2_SCL			0x06000021
+		>;
+	};
+
+	i2c3_gpio_pins: pinctrl-i2c3-gpio-grp {
+		fsl,pins = <
+			/* io with pull-up and weak drive */
+			IMX8DXL_SPI1_CS0_LSIO_GPIO3_IO03		0x00000021
+			/* io with pull-up, weak drive, open-drain */
+			IMX8DXL_SPI1_SDI_LSIO_GPIO3_IO02		0x02000021
+		>;
+	};
+
+	i2c3_pins: pinctrl-i2c3-grp {
+		fsl,pins = <
+			/* io with pull-up and weak drive */
+			IMX8DXL_SPI1_CS0_ADMA_I2C3_SDA			0x06000021
+			IMX8DXL_SPI1_SDI_ADMA_I2C3_SCL			0x06000021
+		>;
+	};
+
+	imu_pins: pinctrl-imu-grp {
+		fsl,pins = <
+			/* interrupt: io with pull-down */
+			IMX8DXL_SNVS_TAMPER_IN2_LSIO_GPIO2_IO11_IN	0x0000041
+		>;
+	};
+
+	lpspi2_pins: pinctrl-lpspi2-grp {
+		fsl,pins = <
+			IMX8DXL_USDHC1_RESET_B_ADMA_SPI2_SCK		0x600004c
+			IMX8DXL_USDHC1_VSELECT_ADMA_SPI2_SDO		0x600004c
+			IMX8DXL_USDHC1_WP_ADMA_SPI2_SDI			0x600004c
+			IMX8DXL_USDHC1_CD_B_LSIO_GPIO4_IO22		0x6000021
+		>;
+	};
+
+	lpuart0_pins: pinctrl-lpuart0-grp {
+		fsl,pins = <
+			IMX8DXL_UART0_RX_ADMA_UART0_RX			0x06000020
+			IMX8DXL_UART0_TX_ADMA_UART0_TX			0x06000020
+		>;
+	};
+
+	lpuart2_pins: pinctrl-lpuart2-grp {
+		fsl,pins = <
+			IMX8DXL_UART2_TX_ADMA_UART2_TX			0x06000020
+			IMX8DXL_UART2_RX_ADMA_UART2_RX			0x06000020
+		>;
+	};
+
+	magnetometer_pins: pinctrl-magnetometer-grp {
+		fsl,pins = <
+			/* interrupt: io with pull-down */
+			IMX8DXL_SNVS_TAMPER_IN1_LSIO_GPIO2_IO10_IN	0x0000041
+		>;
+	};
+
+	regulator_1_2_pins: pinctrl-regulator-1-2-grp {
+		fsl,pins = <
+			/* io without pull-up */
+			/* has etxernal pull-down */
+			IMX8DXL_ADC_IN5_LSIO_GPIO1_IO13			0x0000061
+		>;
+	};
+
+	regulator_1_6_pins: pinctrl-regulator-1-6-grp {
+		fsl,pins = <
+			/* io without pull-up */
+			/* has etxernal pull-down */
+			IMX8DXL_ADC_IN4_LSIO_GPIO1_IO14			0x0000061
+		>;
+	};
+
+	regulator_1_8_se_pins: pinctrl-regulator-1-8-secure-element-grp {
+		fsl,pins = <
+			/* v2x-secure-element power switch: io with pull-down */
+			IMX8DXL_QSPI0B_DATA0_LSIO_GPIO3_IO18		0x0000041
+		>;
+	};
+
+	se_pins: pinctrl-secure-element-grp {
+		fsl,pins = <
+			/* v2x-secure-element reset: io with pull-up */
+			IMX8DXL_QSPI0B_DATA1_LSIO_GPIO3_IO19		0x0000021
+
+			/*
+			 * v2x-secure-element gpio0: io with pull-up
+			 * pulled low by sxf after boot indicating ready for commands
+			 */
+			IMX8DXL_QSPI0B_DATA2_LSIO_GPIO3_IO20		0x0000021
+
+			/* v2x-secure-element gpio1: io with pull-up */
+			IMX8DXL_QSPI0B_DATA3_LSIO_GPIO3_IO21		0x0000021
+		>;
+	};
+
+	usdhc1_pins: pinctrl-usdhc1-grp {
+		fsl,pins = <
+			IMX8DXL_EMMC0_CLK_CONN_EMMC0_CLK		0x06000041
+			IMX8DXL_EMMC0_CMD_CONN_EMMC0_CMD		0x00000021
+			IMX8DXL_EMMC0_DATA0_CONN_EMMC0_DATA0		0x00000021
+			IMX8DXL_EMMC0_DATA1_CONN_EMMC0_DATA1		0x00000021
+			IMX8DXL_EMMC0_DATA2_CONN_EMMC0_DATA2		0x00000021
+			IMX8DXL_EMMC0_DATA3_CONN_EMMC0_DATA3		0x00000021
+			IMX8DXL_EMMC0_DATA4_CONN_EMMC0_DATA4		0x00000021
+			IMX8DXL_EMMC0_DATA5_CONN_EMMC0_DATA5		0x00000021
+			IMX8DXL_EMMC0_DATA6_CONN_EMMC0_DATA6		0x00000021
+			IMX8DXL_EMMC0_DATA7_CONN_EMMC0_DATA7		0x00000021
+			IMX8DXL_EMMC0_STROBE_CONN_EMMC0_STROBE		0x00000041
+			IMX8DXL_EMMC0_RESET_B_CONN_EMMC0_RESET_B	0x00000061
+		>;
+	};
+
+	usdhc2_pins: pinctrl-usdhc2-grp {
+		fsl,pins = <
+			IMX8DXL_ENET0_RGMII_RXC_CONN_USDHC1_CLK		0x06000040
+			IMX8DXL_ENET0_RGMII_RX_CTL_CONN_USDHC1_CMD	0x00000021
+			IMX8DXL_ENET0_RGMII_RXD0_CONN_USDHC1_DATA0	0x00000021
+			IMX8DXL_ENET0_RGMII_RXD1_CONN_USDHC1_DATA1	0x00000021
+			IMX8DXL_ENET0_RGMII_RXD2_CONN_USDHC1_DATA2	0x00000021
+			IMX8DXL_ENET0_RGMII_RXD3_CONN_USDHC1_DATA3	0x00000021
+		>;
+	};
+};
+
+&lpspi2 {
+	cs-gpios = <&lsio_gpio4 22 GPIO_ACTIVE_LOW>;
+	num-cs = <1>;
+	pinctrl-0 = <&lpspi2_pins>, <&se_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+/* console */
+&lpuart0 {
+	pinctrl-0 = <&lpuart0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+/* gnss */
+&lpuart2 {
+	pinctrl-0 = <&lpuart2_pins>, <&gnss_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&lsio_gpio3 {
+	gpio-line-names = "", "", "", "", "", "", "", "",
+			  "", "", "", "", "", "", "", "",
+			  "", "", "", "SXF_RST", "SXF_GPIO0", "SXF_GPIO1", "", "",
+			  "", "", "", "", "", "", "", "";
+};
+
+&lsio_mu5 {
+	status = "okay";
+};
+
+/* OTG port for boot */
+&usbotg1 {
+	adp-disable;
+	disable-over-current;
+	dr_mode = "peripheral";
+	hnp-disable;
+	power-active-high;
+	srp-disable;
+	status = "okay";
+};
+
+&usbphy1 {
+	status = "okay";
+};
+
+/* eMMC */
+&usdhc1 {
+	bus-width = <8>;
+	cap-mmc-hw-reset;
+	non-removable;
+	no-sd;
+	no-sdio;
+	pinctrl-0 = <&usdhc1_pins>;
+	pinctrl-1 = <&usdhc1_pins>;
+	pinctrl-2 = <&usdhc1_pins>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	vmmc-supply = <&v_3_3>;
+	vqmmc-supply = <&v_1_8>;
+	status = "okay";
+};
+
+/* DSRC Radio */
+&usdhc2 {
+	bus-width = <4>;
+	keep-power-in-suspend;
+	max-frequency = <40000000>;
+	non-removable;
+	no-sd;
+	pinctrl-0 = <&usdhc2_pins>, <&dsrc_pins>;
+	pinctrl-names = "default";
+	vmmc-supply = <&v_3_3>;
+	vqmmc-supply = <&v_1_8>;
+	status = "okay";
+};

-- 
2.51.0


