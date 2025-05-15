Return-Path: <netdev+bounces-190716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C70AB8653
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 14:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170B818889E2
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 12:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714C32989A5;
	Thu, 15 May 2025 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pp4UYLh5";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="NE+Tc6u8"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80346227BA2;
	Thu, 15 May 2025 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747311928; cv=fail; b=PMOZ/7w1dFtgxouscFJD9paK5DvkqEMTt4mJxhImpLpTJ36SvhMvIIw8e1LIagQHXbEUPzbv+hlp5OfxFqlfQCMpxd8OPDtX3cdNBg50fOyVxxGp/bdMkQT7aohU3z4kdT5l061Ct8t9Elch/AdbWMwjOmjrXW8eeYE3pQqt8ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747311928; c=relaxed/simple;
	bh=GZbqNgYpMpge3t5MxV7mBgoqvodDcTKkAEdnuS4/CWo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xu1Y9YVkTB3dZjImMtxBs206v+7h+odthi4M59/EeYr0i7yuQeMl8QivuUVGKwrqSoz4cOh3zpulFCtpW56g2rOfI5XSUn3oUPOLU8TMaVtl4wJINbwl8Nwu3BjwCEzuzmimec3PbdRQIj2v9tv0ybb9QyhDCpL8tj7VS3RRi7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pp4UYLh5; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=NE+Tc6u8; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a9c48070318711f082f7f7ac98dee637-20250515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=GZbqNgYpMpge3t5MxV7mBgoqvodDcTKkAEdnuS4/CWo=;
	b=pp4UYLh56KDEsCAVByIU7+GXUNgZptsShxNBzEbSC32nc1ShUMr7xxmEmGqesDIGJinlpeteoEhf2rn5oCmW7qBQsMc6pg48vaRHgdjLJp82bt4qHaF1anefYEKVLFKmpN7crIqtZnZyFErkjfInob762RUG+TKq3mP3ibsrlVA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:4f862ced-ddf4-4153-8cb6-fcacccb223b8,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:21dacc73-805e-40ad-809d-9cec088f3bd8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:80|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: a9c48070318711f082f7f7ac98dee637-20250515
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1253097499; Thu, 15 May 2025 20:25:18 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 15 May 2025 20:25:18 +0800
Received: from TYDPR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 15 May 2025 20:25:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6o0CKpzPTswXJ4k0jD8ntcd2/irkK/RPEP5LU9lgXeYCz1H+3Hmf/2+k5j8yo3dhTUf1nFqip4/fjpPxLICW5ll8sEgV0Ssu7znpTrZzfdI41io/XHTIpZnyInZ9AFRDrHXPiCsPJD8Mv4BFvkRqdDwzZ3VnpvWxv2d+XsDgvb8Vr2vFn3/XnOGH8HIIKXBa254zv2k3PphkKHLqK8xvys73tYmkyhMGIGAMNdvUHhm7uMB4NoYSQe9XtegjDEBrsiRB1XcUNVz52B14xitR3IBhsWywZH9RHyheOTT+cTBob0/N9hvyD73jHMrrRiNFffWiSjrprQCzATRc6Ovyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZbqNgYpMpge3t5MxV7mBgoqvodDcTKkAEdnuS4/CWo=;
 b=ZzeIEvuHL8w6S5T+V30oqM9OjNGk331hKhp44LRGMOl+COcuIgHuGdOQZ85mWitDvTNpbzvwOYAjiXdE8nFV2uS1y+kZOdyjp9swfo1aJl71YyzRjB1fz/x/9kz9lJ6NemNznm9EfVk9jClqsCUVkYRdzyZPsn7juYp2u9stZ0dYt5M3lLWPurSwXZUKEx1LyIBbAkJPtsp96TwloKJZ9CDOjbYwohClUqKtC5tmvCHiVOy3Qn6cGQl+vD/3PxQtUSKTgXNHg//BDpef5xMtc6DwtrtTKKznurN56Rttbl/ZPzXhp+LLKBuwe3KEyMVWxE0TRvc3nc4ihDJW+JAxKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZbqNgYpMpge3t5MxV7mBgoqvodDcTKkAEdnuS4/CWo=;
 b=NE+Tc6u8wcTKCidQpCiw21iiqwjg6AHCBOiZg6yRLi1wVyDBUgjpEq9m/TjLSOOLdtU+noDPk3y3x9lH+ZtL2V434EHbMyFLA7a4191uw7BCz9/1HLrIl4vgpFNhSrZEgAJwigZV5khVLh9FTTKjq2uuxd8+pSiNyJqwK6HMXjs=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by OSQPR03MB8623.apcprd03.prod.outlook.com (2603:1096:604:291::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 12:25:15 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%3]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 12:25:15 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"davem@davemloft.net" <davem@davemloft.net>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "daniel@makrotopia.org" <daniel@makrotopia.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"balika011@gmail.com" <balika011@gmail.com>
Subject: Re: [PATCH net-next v3 2/2] net: phy: mediatek: add driver for
 built-in 2.5G ethernet PHY on MT7988
Thread-Topic: [PATCH net-next v3 2/2] net: phy: mediatek: add driver for
 built-in 2.5G ethernet PHY on MT7988
Thread-Index: AQHbxL8peGP41B3wrU2TqJUvH2W3iLPSCbIAgAGVnAA=
Date: Thu, 15 May 2025 12:25:15 +0000
Message-ID: <cbf06762c32abd39a309a125f8c4ce678a8e6afd.camel@mediatek.com>
References: <20250514105738.1438421-1-SkyLake.Huang@mediatek.com>
	 <20250514105738.1438421-3-SkyLake.Huang@mediatek.com>
	 <aCSI5k7uUgAlpSsy@shell.armlinux.org.uk>
In-Reply-To: <aCSI5k7uUgAlpSsy@shell.armlinux.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|OSQPR03MB8623:EE_
x-ms-office365-filtering-correlation-id: 8de30469-b08f-4cb9-176b-08dd93ab8bdc
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RDZ0VzhqWExYRW05V2lJT1JHejJZUzhYQVBKMXZqa3JtRjlBMkM3cllNbVd0?=
 =?utf-8?B?WjVSMTdhUWUzTzQ5aWtwZHY3U2ZUSDU1bG9HdU1OcEszS3huZW9COGdJdWNs?=
 =?utf-8?B?bGxDTlBxVUZva2k1MEZvZy9KaURqMWUrc011UGFMSjlwQTVsL2JpUHZ1Z1p4?=
 =?utf-8?B?SzBZRUJLbmo3bzVDSDNHbExML1ZIN0VNa2FsVjc4RVUyaUhZUkJwZndHMmRL?=
 =?utf-8?B?MGdnRVpYRlgrT2dha0R5QkxVcmRNUW9QNFFTWW5GbFNMckdieUxjQ0lDdkJO?=
 =?utf-8?B?Nm1tc3IvNFllbFFGelR0VjhTWmpGUmVuMnVMMUxTT2dOR1hmbHZucG80VHZ4?=
 =?utf-8?B?VVEybjZHYUw3OTVFZW5WMk1ma0t1ejhjTzBjUmcxNHE5SEV3WDFjWnBpTkJF?=
 =?utf-8?B?TU1aeStDam1yZDloMVpkYXRtWGtBRHdXT09QUC9LSzAxc2xibkt5dGJjUWdZ?=
 =?utf-8?B?L2tlM2NwVWVMZ1R2elFYcXNQb01hQ0I3RDN0QTRtQmQ5Z0VqS2tjZGJJUGtB?=
 =?utf-8?B?a0w0cGM3cmx0c3NKVUpubktkQUZEMHlsOEJocUVLTktoQ1ArZ2haRFJLTHF3?=
 =?utf-8?B?NUZvb2JmRWxJU1dKVWRWUFptTGJ0NERSVDVGZlArbmVSYVl4azM2dDBpenI4?=
 =?utf-8?B?eTNxK2Fxb0t1MHRmYmVqbDJTSWdYaWpYVHh3dWJwdVNaWE03aGJlQW5la0lJ?=
 =?utf-8?B?UGFheUp2Mk1KYmhSaFpmRS9aN2liaDJNeEJheE5sU1BqV1Q3dmxjTFFoWnRD?=
 =?utf-8?B?Mkt2TG5jM0lsM0hkNGdxRFJ5cXhFVGx5cEd4OWVOS0VReDVLVkwySUpWZnZq?=
 =?utf-8?B?eVFOeU9QeGVtYkVYZzUyYmw0aTdQM1AzM2hiVWRTUy9jWEVEcURPMHBlRW9q?=
 =?utf-8?B?dkhFRUFXSG5OY25UNzJQR3hTVXJSWnRFMVFDMmZrdTM4YWQrejhhWHlqYlV1?=
 =?utf-8?B?N2Q1Z3VCSXJxNUU4Yzl4c0hTbktwRmxKZUR6MHBZSFdqTnc0MkZnOXc0RlJv?=
 =?utf-8?B?R2dMeWxiNVRoRXFKTi9Qa3NlT3BzcEdZWENKUUxyamt6blFlR25YMjRWWlBM?=
 =?utf-8?B?WkxtZ0NTemtUSS9pVlN0U2szK3pwd2lMQWkzVGV5S0lrMHN0WmFzTDNLdUQz?=
 =?utf-8?B?RGVPUEhqb0d5QnIveERjTTM1dnRYUFRxNTRBTmlhVHFxSStLQm9ESFBmRHFB?=
 =?utf-8?B?RDRIbWVVWmZpM1N2bkFuVjdIZ2RTamRsNTJJNmFucHI4YTRxYUpwdXhxTnQ1?=
 =?utf-8?B?RFFpeVN0eHBaQlBORll3N3RwZW9KZW1uUjlYUHlvaElveEhLV1d2ZGYyL0d5?=
 =?utf-8?B?eEVzVGhmazhRRzFENjR4UDhZaTVGdFA5Z1ZTVThwZDUva2ROVzF0aDcvc1RE?=
 =?utf-8?B?V21WcVVsWGpTVTVtaHdicThBQUVON3pTVGFrREt4d1dmem1kcVVnYWtleVNx?=
 =?utf-8?B?M0kwSUVuYlN6SHJxVDRMbFRTb0FMUUJXdHhNK1BqMGlFN284VVB2Z3pwR2lW?=
 =?utf-8?B?TU9jeVBRNHNkSlFDcDJ2Y21oVERQVnVsSStweERpb1ZnNndrSVZOZ2VhZC9j?=
 =?utf-8?B?OEl5QnMrVU9selZLcGxnMjB1K2lJWk9ZRk9aaDVycVpjZG1YQ3ZRT000RUFu?=
 =?utf-8?B?Ynh2b2tXM0ZaTFg3L3VDRGxKUXErMXdUdTEwVFdSN1Q3YW4rZFBuZ0E0UnBo?=
 =?utf-8?B?d21xNTlpY0xwUTU0ZFZWWnlnN1ppSE1TTisrSWgwMTRLZTJDLzZnYXc5dUJk?=
 =?utf-8?B?enY5b2FwL3NHWHUxUHNYcHFMT2ZibGR1VmNwUUpCUzJzVFg5MlVTNzdZRVp4?=
 =?utf-8?B?bmprOGNnRVp3Y2FOZHVhUW5FMlBVa29ZaXROLzBjb3BUMCsxZzZQWm9oM0FO?=
 =?utf-8?B?UTVFelNrTzA1ei9VK2U5SlIwbkRkNEJDVEkwN3Bkam1hSDhVeDNKbEg1UWF1?=
 =?utf-8?Q?PMrAl5wzASw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkFzbWlxRThuMWxwUVYrVHExYS94UjRCTjN1WERKNUtCeFZUTGtNbzZQWXph?=
 =?utf-8?B?T3p2MkpnUmFxV3J6eTJJSlVRTTNTa0FjSndvRTFGZHRDOU1OWmZmMm5UTk9M?=
 =?utf-8?B?OUd1RU9sdnFhTTMwQUdWQ21FRm5ZeGltRnJMTVRvWVFjbEFIbjBSMmdXQVVW?=
 =?utf-8?B?Qm5veDR6T2gvdzVTYXBRZno0TFBBY0lTeDdWa2VVU1k3ZFZRc0VwNk1mR3dY?=
 =?utf-8?B?cTl3aXE4Z0ZxQTl4dlVqRjZHbUZJTkZuaWZqei9JVTkyb2cwQ0JybjY1NjZ6?=
 =?utf-8?B?Q1EvajExSzV2Q2xCQ3hVU1RMWW1xSFI2TTdDUVBZL1RiNGxwVWpnUEtCQ2pP?=
 =?utf-8?B?SkkrR1RTWFhuSkV3NURSbU4xTU5DYTNKeU50RG90eS8rWURrM0NUVTZ6aXhC?=
 =?utf-8?B?dmd5TktTMG92TjJMcEgwRWJ4WHozb0lLT1NldW1idkI4Z1poNEtEdEVuNklJ?=
 =?utf-8?B?ZXplNldJR2hQaXRCRHFsWlJUK0kxbndyMldIOHgvaFNrVGNEOWJvaDRaaVpH?=
 =?utf-8?B?SGpEUnozakM0RTJFNGRnd1JEdVZsd3FxNy9KNkNWanVQSEFYc0lGT3VmUFdL?=
 =?utf-8?B?RjZnZUcwYVVPOEpubkEycGJncXFSaTQzQ1pkTjA5SEFtcm92VVVEN2RGMUtl?=
 =?utf-8?B?SHNmdDRGbHFYdXc5VFdlU2hYbWpCR3NZTW8wNDNYZU4wcFpCRExqdi9abGNw?=
 =?utf-8?B?UlRMc003ZytuclZ0clgrcU5pWFdhTmptOFg5cU5SZXZRcjI2eERJeWlGTm80?=
 =?utf-8?B?b0dmY1BiQlFxQ1kwbzdBeC9WUWp3OTFvcjlxblpVTUdWekVzUFNxaXNpQm1O?=
 =?utf-8?B?eWxNUnBoeTU4aUI4TmZmRFBrR2Fia1h4N2FMSjErK1RieXBaMEFqYzNNUkpW?=
 =?utf-8?B?TGFDTU9XWWsrRXo0NEl0eFR5MXZtc3JDQ2NxalNjL3JGTm80bE96VUhWL25X?=
 =?utf-8?B?bWtweEdQK2xEQ2ltWFR6UWpkZ3VYbVNJK2tzKzFSeGtPWmJjS2NRUVhYWkp4?=
 =?utf-8?B?aFBFUEt1WnZjUDZYQ1ZoWkJZZWZnVTllU09SODdmSENzaFNsa0Z5WEhVb2NT?=
 =?utf-8?B?eGpDbzdjQzFIeW1WdFloaTMyS3B5T1VSY01LT0o3S0tTano4TTNkN3lqTEIx?=
 =?utf-8?B?VkJKSHdJWHBxbGxMZTZZM01RRjR0MUJMWHZGWmROSk1GaFB0YUtURDBlVDhR?=
 =?utf-8?B?bUFEa05xQVIybEx5bzRUdWVqWFRSQmgwbUZxWUF5aHJCdVFpSHIybE1EQTVD?=
 =?utf-8?B?eERkNjl0MmpUUitITVU2WFZ5M0NIWk8rYzRLZmg3UEI5OUJKNHg0WlRPUmVP?=
 =?utf-8?B?cHZuWi82eDl1ZmlaeldUaFFidTkrUHNzcEhkN0xVQ1FXK1JFejBTMGFKWTk4?=
 =?utf-8?B?US9WRXFraE5GbHRMUmcrakpsODJTRWE4VGRaQlBiMDdNb2NHalBzOVRuRStN?=
 =?utf-8?B?ajBjR2NOSyt2WHozalZubWRnWXJoR3Qya2NKYUpnZDNzK241NThBLy9EUkVS?=
 =?utf-8?B?UTlrUGVOdWt6ODRidklrMWNkcjJFUEVKZzUwM0dOWGVONGRiV3BXeGcxSFdS?=
 =?utf-8?B?bGFVVXY1MHE2Qm00Y1hHNFp4d1REMjRQQnFxcXhjN1prMWhzaWZJY1FteVdM?=
 =?utf-8?B?R0tqZStxdDhoRjk2d3laNUNUREYwSEY2UlpLODRxS3NtQzBxNkFyVEVuSCtU?=
 =?utf-8?B?T2dGZm5DMXNFNVFHakR6Z0RISjFSa1dLUWQrREc5SXhPeCtzTmd2Mnppdlpz?=
 =?utf-8?B?d0xTR3dsMFF0MkdueDZGQzRtMVBNdjFXNnlneTFCRFFpdDFGM1BsOWFxZU9h?=
 =?utf-8?B?bHRJY0NFMEdydkRER0pLY0EwYmk3Z2czMHIyTWN4MTBLNlNxdlBiT2pEVGZ1?=
 =?utf-8?B?VCtDOTBybnlYRmtyd1hwZUxHKzZsdk4vbURhRDJDZHlYa1BjbGc1U0VpV3k0?=
 =?utf-8?B?Rm5jOE9CZHRvalk1azkxakVVUmwramFkalhKNnNma0lmMWZjdjdCWTh4UG15?=
 =?utf-8?B?d0p3MDBxTlA3QVU3c201M1lSNHBCM2dtaDlvNzRYSC92MmxPLzdqMjBwZDFj?=
 =?utf-8?B?Ny9tRGIwMVJNWGVPMUd3RUlaOUphdHdnbVdZWC9LZ05HeXJ4alp3N3dsZThH?=
 =?utf-8?B?Mjd6QjhHNStMYlcrZ2JLMlgyUFNyMDlENU9uc0Q2bGsyb1NnUkUyN0xRR2cz?=
 =?utf-8?B?SWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EF63EA80E9D8A40AC42C90F7AEBA74E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de30469-b08f-4cb9-176b-08dd93ab8bdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 12:25:15.1533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xhrgklBEg8onxqivv2emoJJfzCPMODAbFuMd9Gn9GZvB1FMvwAAoJ4izR9POPQB0ditowyaijftOWBATijP7GMZV9ZLWac3ParvS6TzTrn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8623

T24gV2VkLCAyMDI1LTA1LTE0IGF0IDEzOjEzICswMTAwLCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkg
d3JvdGU6Cj4gCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwKPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9y
IHRoZSBjb250ZW50Lgo+IAo+IAo+IEhpLAo+IAo+IE9uIFdlZCwgTWF5IDE0LCAyMDI1IGF0IDA2
OjU3OjM4UE0gKzA4MDAsIFNreSBIdWFuZyB3cm90ZToKPiA+ICsjZGVmaW5lIE1US18yUDVHUEhZ
X0lEX01UNzk4OMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoMHgwMDMzOWMxMSkKPiA+
ICsKPiA+ICsjZGVmaW5lIE1UNzk4OF8yUDVHRV9QTUJfRlfCoMKgwqDCoMKgwqDCoMKgwqAgIm1l
ZGlhdGVrL210Nzk4OC9pMnA1Z2UtcGh5LQo+ID4gcG1iLmJpbiIKPiA+ICsjZGVmaW5lIE1UNzk4
OF8yUDVHRV9QTUJfRldfU0laRcKgwqDCoMKgICgweDIwMDAwKQo+ID4gKyNkZWZpbmUgTVQ3OTg4
XzJQNUdFX1BNQl9GV19CQVNFwqDCoMKgwqAgKDB4MGYxMDAwMDApCj4gPiArI2RlZmluZSBNVDc5
ODhfMlA1R0VfUE1CX0ZXX0xFTsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgweDIwMDAwKQo+
ID4gKyNkZWZpbmUgTVRLXzJQNUdQSFlfTUNVX0NTUl9CQVNFwqDCoMKgwqAgKDB4MGYwZjAwMDAp
Cj4gPiArI2RlZmluZSBNVEtfMlA1R1BIWV9NQ1VfQ1NSX0xFTsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICgweDIwKQo+ID4gKyNkZWZpbmUgTUQzMl9FTl9DRkfCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICgweDE4KQo+IAo+IFRoZXNlIHBhcmVucyBhcmUgYWxsIHVubmVjZXNz
YXJ5LCBhcyBhcmUgb25lcyBiZWxvdyBhcm91bmQgYSBzaW1wbGUKPiBudW1iZXIuCj4gCkknbGwg
Y2xlYW4gdGhpcyB1cCBpbiB2NC4KCj4gPiArI2RlZmluZcKgwqAgTUQzMl9FTsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJJVCgwKQo+ID4gKwo+ID4gKyNkZWZpbmUgQkFT
RTEwMFRfU1RBVFVTX0VYVEVORMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDB4MTApCj4g
PiArI2RlZmluZSBCQVNFMTAwMFRfU1RBVFVTX0VYVEVORMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICgweDExKQo+ID4gKyNkZWZpbmUgRVhURU5EX0NUUkxfQU5EX1NUQVRVU8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKDB4MTYpCj4gPiArCj4gPiArI2RlZmluZSBQSFlfQVVYX0NUUkxf
U1RBVFVTwqDCoMKgwqDCoMKgwqDCoMKgICgweDFkKQo+ID4gKyNkZWZpbmXCoMKgIFBIWV9BVVhf
RFBYX01BU0vCoMKgwqDCoMKgwqDCoMKgwqDCoCBHRU5NQVNLKDUsIDUpCj4gPiArI2RlZmluZcKg
wqAgUEhZX0FVWF9TUEVFRF9NQVNLwqDCoMKgwqDCoMKgwqDCoCBHRU5NQVNLKDQsIDIpCj4gPiAr
Cj4gPiArLyogUmVnaXN0ZXJzIG9uIE1ESU9fTU1EX1ZFTkQxICovCj4gPiArI2RlZmluZSBNVEtf
UEhZX0xQSV9QQ1NfRFNQX0NUUkzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDB4MTIxKQo+IAo+
IC4uLgo+IAo+ID4gK3N0YXRpYyBpbnQgbXQ3OTh4XzJwNWdlX3BoeV9sb2FkX2Z3KHN0cnVjdCBw
aHlfZGV2aWNlICpwaHlkZXYpCj4gPiArewo+ID4gK8KgwqDCoMKgIHZvaWQgX19pb21lbSAqbWN1
X2Nzcl9iYXNlLCAqcG1iX2FkZHI7Cj4gPiArwqDCoMKgwqAgc3RydWN0IGRldmljZSAqZGV2ID0g
JnBoeWRldi0+bWRpby5kZXY7Cj4gCj4gVGhpcyB3aWxsIGF0dHJhY3QgYSBjb21tZW50IGFib3V0
IHJldmVyc2UgY2hyaXN0bWFzIHRyZWUuCj4gClRoYW5rcy4gSSBtaXNzZWQgdGhpcyBwYXJ0LiBJ
J2xsIGZpeCBpdCBpbiB2NC4KCj4gPiArwqDCoMKgwqAgY29uc3Qgc3RydWN0IGZpcm13YXJlICpm
dzsKPiA+ICvCoMKgwqDCoCBpbnQgcmV0LCBpOwo+ID4gK8KgwqDCoMKgIHUzMiByZWc7Cj4gCj4g
Li4uCj4gCj4gPiArc3RhdGljIGludCBtdDc5OHhfMnA1Z2VfcGh5X2NvbmZpZ19pbml0KHN0cnVj
dCBwaHlfZGV2aWNlICpwaHlkZXYpCj4gPiArewo+ID4gK8KgwqDCoMKgIHN0cnVjdCBwaW5jdHJs
ICpwaW5jdHJsOwo+ID4gKwo+ID4gK8KgwqDCoMKgIC8qIENoZWNrIGlmIFBIWSBpbnRlcmZhY2Ug
dHlwZSBpcyBjb21wYXRpYmxlICovCj4gPiArwqDCoMKgwqAgaWYgKHBoeWRldi0+aW50ZXJmYWNl
ICE9IFBIWV9JTlRFUkZBQ0VfTU9ERV9JTlRFUk5BTCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIC1FTk9ERVY7Cj4gPiArCj4gPiArwqDCoMKgwqAgLyogU2V0dXAgTEVEICov
Cj4gPiArwqDCoMKgwqAgcGh5X3NldF9iaXRzX21tZChwaHlkZXYsIE1ESU9fTU1EX1ZFTkQyLAo+
ID4gTVRLX1BIWV9MRUQwX09OX0NUUkwsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIE1US19QSFlfTEVEX09OX1BPTEFSSVRZIHwKPiA+IE1US19QSFlfTEVE
X09OX0xJTksxMCB8Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIE1US19QSFlfTEVEX09OX0xJTksxMDAgfAo+ID4gTVRLX1BIWV9MRURfT05fTElOSzEwMDAg
fAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBNVEtfUEhZ
X0xFRF9PTl9MSU5LMjUwMCk7Cj4gPiArwqDCoMKgwqAgcGh5X3NldF9iaXRzX21tZChwaHlkZXYs
IE1ESU9fTU1EX1ZFTkQyLAo+ID4gTVRLX1BIWV9MRUQxX09OX0NUUkwsCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE1US19QSFlfTEVEX09OX0ZEWCB8IE1U
S19QSFlfTEVEX09OX0hEWCk7Cj4gPiArCj4gPiArwqDCoMKgwqAgLyogU3dpdGNoIHBpbmN0cmwg
YWZ0ZXIgc2V0dGluZyBwb2xhcml0eSB0byBhdm9pZCBib2d1cwo+ID4gYmxpbmtpbmcgKi8KPiA+
ICvCoMKgwqDCoCBwaW5jdHJsID0gZGV2bV9waW5jdHJsX2dldF9zZWxlY3QoJnBoeWRldi0+bWRp
by5kZXYsCj4gPiAiaTJwNWdiZS1sZWQiKTsKPiA+ICvCoMKgwqDCoCBpZiAoSVNfRVJSKHBpbmN0
cmwpKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKCZwaHlkZXYtPm1kaW8u
ZGV2LCAiRmFpbCB0byBzZXQgTEVECj4gPiBwaW5zIVxuIik7Cj4gCj4gTm8sIGRvbid0IGRvIHRo
aXMuIGNvbmZpZ19pbml0KCkgY2FuIGJlIGNhbGxlZCBtdWx0aXBsZSB0aW1lcyBkdXJpbmcKPiB0
aGUgbGlmZXRpbWUgb2YgdGhlIGRyaXZlciBib3VuZCB0byB0aGUgZGV2aWNlLCBhbmQgZWFjaCB0
aW1lIGl0IGlzLAo+IGEgbmV3IG1hbmFnZWQtZGV2IHN0cnVjdHVyZSB3aWxsIGJlIGFsbG9jYXRl
ZCB0byByZWxlYXNlIHRoaXMgYWN0aW9uCj4gZWFjaCB0aW1lLCB0aHVzIGNvbnN1bWluZyBtb3Jl
IGFuZCBtb3JlIG1lbW9yeSwgb3IgcG9zc2libHkgZmFpbGluZwo+IGFmdGVyIHRoZSBmaXJzdCBk
ZXBlbmRpbmcgb24gdGhlIHBpbmN0cmxfZ2V0X3NlbGVjdCgpIGJlaGF2aW91ci4KPiBQbGVhc2Ug
ZmluZCBhIGRpZmZlcmVudCB3YXkuCj4gCkknbGwgbW92ZSB0aGlzIHBhcnQgKExFRCBpbml0aWFs
aXphdGlvbikgdG8gLnByb2JlIHRoZW4uCgo+IC4uLgo+IAo+ID4gK3N0YXRpYyBpbnQgbXQ3OTh4
XzJwNWdlX3BoeV9jb25maWdfYW5lZyhzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQo+ID4gK3sK
PiA+ICvCoMKgwqDCoCBib29sIGNoYW5nZWQgPSBmYWxzZTsKPiA+ICvCoMKgwqDCoCB1MzIgYWR2
Owo+ID4gK8KgwqDCoMKgIGludCByZXQ7Cj4gPiArCj4gPiArwqDCoMKgwqAgcmV0ID0gZ2VucGh5
X2M0NV9hbl9jb25maWdfYW5lZyhwaHlkZXYpOwo+ID4gK8KgwqDCoMKgIGlmIChyZXQgPCAwKQo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+ID4gK8KgwqDCoMKgIGlm
IChyZXQgPiAwKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjaGFuZ2VkID0gdHJ1ZTsK
PiA+ICsKPiA+ICvCoMKgwqDCoCAvKiBDbGF1c2UgNDUgZG9lc24ndCBkZWZpbmUgMTAwMEJhc2VU
IHN1cHBvcnQuIFVzZSBDbGF1c2UgMjIKPiA+IGluc3RlYWQgaW4KPiA+ICvCoMKgwqDCoMKgICog
b3VyIGRlc2lnbi4KPiA+ICvCoMKgwqDCoMKgICovCj4gPiArwqDCoMKgwqAgYWR2ID0gbGlua21v
ZGVfYWR2X3RvX21paV9jdHJsMTAwMF90KHBoeWRldi0+YWR2ZXJ0aXNpbmcpOwo+ID4gK8KgwqDC
oMKgIHJldCA9IHBoeV9tb2RpZnlfY2hhbmdlZChwaHlkZXYsIE1JSV9DVFJMMTAwMCwKPiA+IEFE
VkVSVElTRV8xMDAwRlVMTCwgYWR2KTsKPiA+ICvCoMKgwqDCoCBpZiAocmV0IDwgMCkKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPiA+ICvCoMKgwqDCoCBpZiAocmV0
ID4gMCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2hhbmdlZCA9IHRydWU7Cj4gPiAr
Cj4gPiArwqDCoMKgwqAgcmV0dXJuIF9fZ2VucGh5X2NvbmZpZ19hbmVnKHBoeWRldiwgY2hhbmdl
ZCk7Cj4gCj4gRG8geW91IHdhbnQgdGhpcyAod2hpY2ggd2lsbCBwcm9ncmFtIEVFRSBhbmQgdGhl
IDEwLzEwMCBhZHZlcnQpIG9yIGRvCj4geW91IHdhbnQgZ2VucGh5X2NoZWNrX2FuZF9yZXN0YXJ0
X2FuZWcoKSBoZXJlPyBOb3RlIHRoYXQKPiBnZW5waHlfYzQ1X2FuX2NvbmZpZ19hbmVnKCkgd2ls
bCBhbHJlYWR5IGhhdmUgcHJvZ3JhbW1lZCBib3RoIHRoZSBFRUUKPiBhbmQgMTAvMTAwIGFkdmVy
dHMgdmlhIHRoZSBDNDUgcmVnaXN0ZXJzLgo+IAo+IFRoYW5rcy4KPiAKSSdsbCByZXBsYWNlICJy
ZXR1cm4gX19nZW5waHlfY29uZmlnX2FuZWcocGh5ZGV2LCBjaGFuZ2VkKTsiIHdpdGgKInJldHVy
biBnZW5waHlfYzQ1X2NoZWNrX2FuZF9yZXN0YXJ0X2FuZWcocGh5ZGV2LCBjaGFuZ2VkKTsiLgoK
QlJzLApTa3kKCj4gLS0KPiBSTUsncyBQYXRjaCBzeXN0ZW06Cj4gaHR0cHM6Ly91cmxkZWZlbnNl
LmNvbS92My9fX2h0dHBzOi8vd3d3LmFybWxpbnV4Lm9yZy51ay9kZXZlbG9wZXIvcGF0Y2hlcy9f
XzshIUNUUk5LQTl3TWcwQVJidyFpRXBOSU5ONG1hcDl5ZHE2cGhPazAzNE1IeFpvNnZoQkpKbjdV
NVhGY0VNSHRoZHhKcmpoZ2ZIVWRzSDVSM3dKQVV5eVBlX0RsRklpdVJXRTBHRTNVejAkCj4gRlRU
UCBpcyBoZXJlISA4ME1icHMgZG93biAxME1icHMgdXAuIERlY2VudCBjb25uZWN0aXZpdHkgYXQg
bGFzdCEKCg==

