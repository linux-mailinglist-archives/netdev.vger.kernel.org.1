Return-Path: <netdev+bounces-244406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4BDCB6950
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 17:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F5D33001C3C
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 16:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E788E307AF0;
	Thu, 11 Dec 2025 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="McVoyFdj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479011C7012
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765472247; cv=fail; b=hA2UJ6+CDr6Z5e3TjXjTRiyBW/h2skcaqIYVkeIKPbRjMVEpWSBhz8IwMr26cR1ShUQZDGLrXUoapAPrO8gdmXY6SzPNxtywGF7+zsYUdmXii8OLk5dss5vUCEjs86Py0QrtETZJAsZeVgF/je2SMAx4nzVJBTtrlsZlN1MZeAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765472247; c=relaxed/simple;
	bh=3hkWG6T+qRkOvx2CU9EiQ9k0RJI7NdDHCs47n3Eghxg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QkEeOZXu27guUChUzF7NUcvIZwvyDh+54pa44kp2R3N43Oj4jkpzjQtdTyyYAlXTksRQIBBChGEJ9Xx/ow0LugbBRkb7WGCwn/C3zKVL6fKWSlJt4N6mWzKNjGjeGvoOSJ4cyEzW0AXmRWJ4oNnz0DbljH0I/aZv5lTNa5W9bS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=McVoyFdj; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBAnSBg2374334;
	Thu, 11 Dec 2025 08:57:19 -0800
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020089.outbound.protection.outlook.com [52.101.201.89])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ayjjfj5h4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 11 Dec 2025 08:57:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omlPv0zXrNMOrKimpa4N3sN4cvt4FMvoPe09mBqgDIda0/huzCt8ccxSBJivPUdL+NBZaoeOG4zqqeoDXvn49UNaPtHQWXpLDlJFWbypdNnoyLIwCvVpNZH764vSdYUrI/TCeZGg3Jvs+gAaklIuhzrccdnILYlaAOwm7vQ/It+pgQqNqAGSRGF2fkYMOUGvkLD/Mv3itKuHQIaI11rm1hn6AIo1G2YHKohFYiH1xeRTMejml+qbqzik+P1FcgdRQQlCzRaXZ9zkHloEPMxCQMg8f2e1h2jpR/BLhGnk0SeFp4BG61XfnTGMEYDdp06v7Xnu1uBjMhoKZK1L3ja3Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hkWG6T+qRkOvx2CU9EiQ9k0RJI7NdDHCs47n3Eghxg=;
 b=noXZHabq/PVONj7H9aUYUpkS9IJXHjOECefxO7pknhhKTWg2k+pLDekYpxRnynKa2KqlmkbXS+LcNGTCADHj4Gl8XNWN9N8kH/EKQZ6jcWeY92pWDLQ7OloHdnJVNJOW2EaDam04D61rmImGS+nKpKf3q4B7ePgOpFfkV4YuFIRplIc9Z8whka2QJQte95yfXsnWtQa6L80ZGtXPlpo3BW06V4C3Qfe6ddB5bG1GbZ5C+n1RxFmCvLamdoyeuLc6C0stbUqb9aUVMbSnv5tWJg/L6jO41lw4nFK57tp7sRgvXnC3iKfRbpjPdNc6as9qPnCGYYRM8gcKKwNWq08mCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hkWG6T+qRkOvx2CU9EiQ9k0RJI7NdDHCs47n3Eghxg=;
 b=McVoyFdj7jvOI5/s/XVTZxdo0dQGW9K1cB7pKWnCVCsZGWdmTwaLLAessE3CkprLGtIsnWW1on4xFdlo1OEC1IISRUqhpKzfG60cZYrzLzBsQD4cCDsrcf9+wK19Ba5qvr68aJXP/yKMx2OsIYI8NWRHFfQJ/LcchBgHeFNwOdg=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by IA1PR18MB5491.namprd18.prod.outlook.com (2603:10b6:208:450::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Thu, 11 Dec
 2025 16:57:10 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::ad08:c104:6b33:ef04]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::ad08:c104:6b33:ef04%4]) with mapi id 15.20.9388.013; Thu, 11 Dec 2025
 16:57:10 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH] epic100: remove module version and switch to
 module_pci_driver
Thread-Topic: [PATCH] epic100: remove module version and switch to
 module_pci_driver
Thread-Index: AQHcar8wAfqvjg1ZA0aiYqhlGsrfCw==
Date: Thu, 11 Dec 2025 16:57:10 +0000
Message-ID:
 <BY3PR18MB47070F7D806327202FEB4066A0A1A@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20251211074922.154268-1-enelsonmoore@gmail.com>
In-Reply-To: <20251211074922.154268-1-enelsonmoore@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|IA1PR18MB5491:EE_
x-ms-office365-filtering-correlation-id: e7f72edf-3a6c-4578-3943-08de38d6535c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bTRtdHc4VjgxcUtDaUR0Vk1OMmloZW1XSmgrMnd5YmlnWUNZZFBUSjFzVnpv?=
 =?utf-8?B?Z2kvWWp2U1Z3NWpKa0RTUEVkemMvSUk4d1lMN2s0NHorVDNoWTl6Rm8vK1ZR?=
 =?utf-8?B?RzZmR3ZhUTVJTndMZUVpekkwMEl0OHF2T2x2ekhENVF1dkx1eVJZbEJLT3RL?=
 =?utf-8?B?aHF1WUFJdVQ2QkptT01GdGg0Mks5d0oxY1dHZWJWdVNtZjBRa0VWcUxHM3NF?=
 =?utf-8?B?ZEhDRlp5a1R1RnN4ZElCT1hwVytlNzl3alVPTjJYRnJjV2hQZFovM3FpU3I4?=
 =?utf-8?B?ZGxFRTdZKytsY1NGeCtBOTBkYnM4TnNrcXhBL1Jrd3hJWHRYRm9KRnZqTnNS?=
 =?utf-8?B?S1lWVWNYR3ZDYjRBSGU4OWVsV01Hd1owNVVCam1kSU14ZjVTZ1liT2RXbEdT?=
 =?utf-8?B?L1FFOUY4LzhNSEx1cjZBQ3VCSWVZN3FhMW5RMm9Ic1lSYUNGUlVQT2tyWTFE?=
 =?utf-8?B?dzB6VU1xRXpldlZ6a2ZnR3ZIdFE0alhPQWY2VzZNWFIwTzQwYWdGaFlRQ2l5?=
 =?utf-8?B?N2pvU1lmOTh4N2U2ZG81Rzl2NmErQzB6K05aTTlKejdaeis1dEZSSUtRVEx0?=
 =?utf-8?B?b1JRaEhUZ0hkMm9zZTJNQXRmb1ZGRG1lZHB3b2NzaUVmayszSWt1SC9kNURu?=
 =?utf-8?B?TXZ4b21nRmd3a3NBQWNObk4vbURVMSs1ZU9sbDA0OGtLMFFTN1NuUTIrVkp1?=
 =?utf-8?B?RDgxdFM5RmhkRjU2blgrNTZnVkMzVFhFK1FqSkJYNXJ3T0pKMmxkR0FxMWJo?=
 =?utf-8?B?My93cGp3VUtaaERkangrc0d6Zy8zWkhabi9saUF1U0l6dndVL3RtUE9IWjZm?=
 =?utf-8?B?QndOYVQvQ2hWeHduZk5HVVZNRkpxTWZOL0dPQmsvT0pvV01ZcXIxdzhpSDJY?=
 =?utf-8?B?YUdQMWMxcmZQRjNqb0tvMjRhRzRGVVhaaWZjNXRWRjk4T3gzL1duMDFqQkcw?=
 =?utf-8?B?UnZ6YUV6SGhheFZ5YTQybXRDNERocXF4b09ZdlFVV1ZwWDNsejFpdEJyazJ1?=
 =?utf-8?B?d0djMUdBREFvUWN3eG5FUDlDcU9CeEREelZrMmJDekVxa1Y1ZXRHUmxsamNB?=
 =?utf-8?B?SGhZNU8vem9VeTNTbFUwNFJ4Tm4vRmVFZDU2OGhCa3hLUzVIbzJOeE5nN25v?=
 =?utf-8?B?MzE5ckFQSTZLMzJKUS9oV2NndTdDMTJicjZIMS9td1FpOWl2ckYvRE1yLzFW?=
 =?utf-8?B?Y0dLSEFxMzVEVkJka2Y4WU80UVE3dkRaWVdVa0lUcjdLTWtaWlFMektQcjNX?=
 =?utf-8?B?S1lPbDlIdDU2eHUrWVpIeXM3SWU2VElnU0V2T1EyeEI1bit4N2hVcFkyd2k5?=
 =?utf-8?B?akRBQUxYYTNVeCtWM0dUK1pHYVFhNUJzSDhrYkhkampVMm9TQWI0Wm04VVRz?=
 =?utf-8?B?NFQrRHlGNWpFMWoyQ2o2czlYTTlkajdNYm1ZYjRkMlhCVWdleUNYaUVYYnhO?=
 =?utf-8?B?Zk1SaVhHR1lOUTRnNXFVMlI0TFc5UVVFdGhIVHZIYjhYTUh6NnMyaVN2cVRp?=
 =?utf-8?B?QVJ5VjlEeWdNUzBvYTV5YzZoVkh3ZXhvRnJuZmQzUlBlVFkwSGRjUzdYR0VD?=
 =?utf-8?B?TU5NeE9Nc2NhOExvK0tnSlA0TEp5M3g2V254RUpGUkhnSU1LV21yMi9wWjFD?=
 =?utf-8?B?VkFTSmIybnVCRUtoR0pucEJ3L1Rta0E5SWFDMGoyRDZLZjBIdnYxc0Z2eUJT?=
 =?utf-8?B?ZzJwSm15YW1mb3hFbWQ5cGp2MCs0Ymc1VGlEbkVQVkVYbm1PQ2MrSUZ0Z2do?=
 =?utf-8?B?UzcvZXI1d1lmd1lmcUJsaThyUXB5WXpWQXZIQzh2eE1TVkw1Mm1Zc2ZuMVdS?=
 =?utf-8?B?a21SSXNjV2h0UE1lWWtvdENMV3N4ZlJwVGJtdytBU3lpRndnZ25mV1VnTG5F?=
 =?utf-8?B?bFU1MkwxbTdpWUd4bEVDQm4xNXhqc3hMR21jTE91K0dPM0tjeTgxeEM4L3dr?=
 =?utf-8?B?aXphbXh1M3VCSTlVY2tjVkZOVkdTS0czS3ZaSU8xVlN2MDltMUxRZjYycXo5?=
 =?utf-8?B?QW8xRmNSaDZraDlhS2RCVWlMajZZUk1CYytWS1UzRkRMNmF2ODBPYmxydzVP?=
 =?utf-8?Q?HvUWtl?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFZMaVdjT0pFS2p6ZEtQQlRFcitZN3c2aFNneHQ4em9xdElnQTZFNmhzcUZ5?=
 =?utf-8?B?MXh0MTA3UWlSRTN0V1ZSeUpsVW5LUlhQZlRPNldZVU5zeEtzVEtFNk9ldG5j?=
 =?utf-8?B?OEp4M2V6OWw0Y0xhMGFBNlg5eTBKUTVzK0VRdUpiSWlvbnFEYlBxZ1c4bEQy?=
 =?utf-8?B?ajhJaW1YM055bVFtemp1Nlg5ai96YUQ2RG1kTGNmTDRvdUVRZUY4MWFoZ2E2?=
 =?utf-8?B?RGJ3dWpBd1lUT2FqUEtqZFJ1Q3BFVTczeTc2TUlKajc2WE1KckJNT2JTS1dO?=
 =?utf-8?B?cCtYa1lMNGljQVQwdi9jRDdKdDRzYUNFWVRvNElYcGVmQXhJaUR4SUFOTmVJ?=
 =?utf-8?B?WDdjUmdKOFJVZzl6UG85Y1FDY25FaDJkeEw5R0E5Rkc3OGVrVXNFMk91N2Ex?=
 =?utf-8?B?Q2Q5RzFERmtneDdHcFhOaGMyYUg5QmRTQ05SWW4yN21ZbklQN2pvYUFWdzNm?=
 =?utf-8?B?dlRYOEFQUGVITG9vYUF5VmwrTU9pSnM1c1ppbFFmV1IwUGtSRXRSZlVIZThx?=
 =?utf-8?B?blg3dXB0YzkwZ20xalphVzZpY3ZpNC8xVFJTckd3UXBBTzB4dXgvUkMrYlBq?=
 =?utf-8?B?MzI2UjVINXVkMW55ZGp2QVkxb0hEVXVnb1VEWE8wRlA3c0hLbStSNGoxSng1?=
 =?utf-8?B?eElPWE1ZSUMxOUhsV0RvZmE3N2NiM01RWEVuK2FHb3dRb3pVRkduTkw2M0p6?=
 =?utf-8?B?ODR2ME9vZkQ1VTNmaHR2dFRFQzdBOVBsZk1HMC96K1BDRjRHeVFOZXVsVVgw?=
 =?utf-8?B?Tm90OWdmWmJ0a2l4Rmg0SDBLMjBMaHdZV1hKY1BNOVE2YkowQmR4MnpodHB0?=
 =?utf-8?B?K3NTZjVCOTVHbzVudzhnRVNLeVBscTRuZmFtYnpXSDQ4TDRlVmxmZ1kwNWdo?=
 =?utf-8?B?dFJkRjV5bklNZDkzM2NnRXBHSUFUTDVXek1Gb2sxL215Ky8xb1FFM3Bsc0Z3?=
 =?utf-8?B?UE1WU3o1TTNkM3FBVEFFUkZ3ZDhVQ3N4K1Q5R1JJbWtsSmhrL1NNb2IzRHk5?=
 =?utf-8?B?K0xvQzN6NFAzVjhIMXpIb0ZocHZJa2tVb2J5N1FZWm1XM2dCaG5XV1o2bVgv?=
 =?utf-8?B?SEl1M1VwTlVhYmtxcGZjNmpyZ0NRQnQ2cmp5SXI5c0k1cWNsWHFyT2lRb2RF?=
 =?utf-8?B?SEp5RDJBc2toZkU0UUdRS05PV2MyK2FuRkpSTWduZHRQMnFvM2hZZWxkcytO?=
 =?utf-8?B?K3VCYkZ0NDZmVW9ZTFN6U0twS05PMEl0RGpCcW1sM1RkblY1aVFDTllQVDFV?=
 =?utf-8?B?Wi9ZcTNBbjhmUUFzUWRyZFgxOFZGWG1OVHVHaXdGQnNyQ1FFWDJ1R2tpbjhD?=
 =?utf-8?B?Q2YzWjZXdzJTMWFzYi9vc29RUjJ2cXAzc0ZpL2p6Z2FWanRBeUdJSU1YM053?=
 =?utf-8?B?dTVvNXIrdjRtK0EzV2daeUV0V1gwZTBuVmhYNEZGMHp6amtLaFd5Q3Z0RFVi?=
 =?utf-8?B?RDI5dU1YSGhHWDVzY1RnOVhqeDhvT0h1bTB5NDZFTjRUOUxHYjlWZG90TDRW?=
 =?utf-8?B?UFBKc25yMitWWkdNUDIxYTNzRlY0VVE5ZlZXT1JhVzJ0bUtYa25mU2FsSjNM?=
 =?utf-8?B?U2lremhlN1VpbVhUT0toZHRrQ1A0N0hISnpMSkF1aU0vNHhxenZQaU5QWmNs?=
 =?utf-8?B?cmJTSHZTenU1a2YzYnp3L3NVVDZaaTZYVGROYkMxczZwL3pPd2M2UFM0aU9I?=
 =?utf-8?B?L2lGU2haYTRrU3RISCtyb3p1QmtPSEtqZi9mSWJobGxtSXFRZ2szdUxTMXRQ?=
 =?utf-8?B?dEtSbjhMc0VNYisxMUcvdVg1cS9DdUJQQjRvVlpGNm5KUkx2VUk0UXhMbm1K?=
 =?utf-8?B?OG9laytmOE9BVTJ2UStOdDEzczNKWHdid3l5MGppVlE5S0VXa0RXeWswRC9m?=
 =?utf-8?B?Uy9ZRmh1R3RZUlNOeWxBRzczc1JlQThpVm42Y21ObG5lQTNJZVJFYjhQellZ?=
 =?utf-8?B?ZDJvU3F6UmJLcDFLTVFpWnVvRisvMVhpK3hrV08rOWJRQm9UMEFZdmFGZVRn?=
 =?utf-8?B?TDVOVTdyVTVORkZScVQzc01EZVNmSlV5SmljcTc1ZS9CaEErUUg3eHY0N3Fx?=
 =?utf-8?B?WWxtem5XSkFoektzUkFmSUhnQkJ3Z0dCcEZQUmZtdTJIYktLMEtMbzN2NnE2?=
 =?utf-8?B?S2J1ak8xMkdhNmxoN21NU1daVTNxOHF6WHRLWjR6WnZxYU5GaUk0U1lQZm1J?=
 =?utf-8?Q?HWKNaa9gSpHTnmI9/rXzJHY0WyTsc/3hsMmy2a275lny?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f72edf-3a6c-4578-3943-08de38d6535c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 16:57:10.5802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lL4fExdjZcuNqfAjAlTfztKwjmeaNiFi1VNh2uG13+wUNvnJEI9GcdiEp6hhrc1hKi8lDBjg6Zc075z1fz+r3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR18MB5491
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDEzNSBTYWx0ZWRfXwJMsZGQwJTwp
 TjjOm4SNMbyVpnSH7sb+lUW827EfivryjfV+jxjb49STPfLDVGmr+ygX3DBJiePQn8G3MsUbX93
 eJ8zFep5kLqxJe5KOvTqI1oWIy8QmV+7sXQtREWMVHY5GZuzavhusGRTbFQibhguYM339+B2teX
 RTrFs6SI231QidhZudZvWU2zOWsKNkj8wlHXESzf12Uo+ASJy2jWRCQC5Udhup4l3WKA7/6E1Ei
 5Wjsy6N6JP3E1QBYVG2TWiq/rCN9S3J+lq1lkevsfqhqsayumG+SMCFqROXp4/Xggx5GqF9CG6s
 Wf46fnxYZWjP6/zRDZ1Yd//MqYy03900YmWZzP4iHs0XNgsyhogRCuhqMR4pcOV8+PUn5r4UqRt
 Lix4T1FiJzLixmL9nW6EVErv6CwqYw==
X-Authority-Analysis: v=2.4 cv=IayKmGqa c=1 sm=1 tr=0 ts=693af7ef cx=c_pps
 a=ztQKeGOog0QVs0B1QXIMEA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=mL-yUJnIAAAA:8 a=M5GUcnROAAAA:8
 a=4nJQeu9F3iIzwz1Uu5EA:9 a=QEXdDO2ut3YA:10 a=-rmpMQN8dmorHPTw4RtK:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: iiK80uGLc9FaLX5hWUt11_2YsVwAU5ig
X-Proofpoint-ORIG-GUID: iiK80uGLc9FaLX5hWUt11_2YsVwAU5ig
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_02,2025-12-11_01,2025-10-01_01

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEV0aGFuIE5lbHNvbi1Nb29y
ZSA8ZW5lbHNvbm1vb3JlQGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDEx
LCAyMDI1IDE6MTkgUE0NCj4gVG86IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEV0aGFu
IE5lbHNvbi1Nb29yZSA8ZW5lbHNvbm1vb3JlQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogW1BBVENI
XSBlcGljMTAwOiByZW1vdmUgbW9kdWxlIHZlcnNpb24gYW5kIHN3aXRjaCB0bw0KPiBtb2R1bGVf
cGNpX2RyaXZlcg0KPiANCj4gVGhlIG1vZHVsZSB2ZXJzaW9uIGlzIHVzZWxlc3MsIGFuZCB0aGUg
b25seSB0aGluZyB0aGUgZXBpY19pbml0IHJvdXRpbmUgZGlkDQo+IGJlc2lkZXMgcGNpX3JlZ2lz
dGVyX2RyaXZlciB3YXMgdG8gcHJpbnQgdGhlIHZlcnNpb24uIFNpZ25lZC1vZmYtYnk6IEV0aGFu
DQo+IE5lbHNvbi1Nb29yZSA8ZW5lbHNvbm1vb3JlQOKAimdtYWlsLuKAimNvbT4gLS0tDQo+IGRy
aXZlcnMvbmV0L2V0aGVybmV0L3Ntc2MvZXBpYzEwMC7igIpjIHwgMzUgKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCj4gVGhlIG1vZHVsZSB2ZXJzaW9uIGlzIHVzZWxlc3MsIGFuZCB0aGUg
b25seSB0aGluZyB0aGUgZXBpY19pbml0IHJvdXRpbmUgZGlkDQo+IGJlc2lkZXMgcGNpX3JlZ2lz
dGVyX2RyaXZlciB3YXMgdG8gcHJpbnQgdGhlIHZlcnNpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBFdGhhbiBOZWxzb24tTW9vcmUgPGVuZWxzb25tb29yZUBnbWFpbC5jb20+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9uZXQvZXRoZXJuZXQvc21zYy9lcGljMTAwLmMgfCAzNSArLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzNCBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9zbXNjL2Vw
aWMxMDAuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3Ntc2MvZXBpYzEwMC5jDQo+IGluZGV4
IDQ1ZjcwM2ZlMGU1YS4uMzg5NjU5ZGIwNmE4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9zbXNjL2VwaWMxMDAuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9zbXNj
L2VwaWMxMDAuYw0KPiBAQCAtMjYsOCArMjYsNiBAQA0KPiAgKi8NCj4gDQo+ICAjZGVmaW5lIERS
Vl9OQU1FICAgICAgICAiZXBpYzEwMCINCj4gLSNkZWZpbmUgRFJWX1ZFUlNJT04gICAgICIyLjEi
DQo+IC0jZGVmaW5lIERSVl9SRUxEQVRFICAgICAiU2VwdCAxMSwgMjAwNiINCj4gDQo+ICAvKiBU
aGUgdXNlci1jb25maWd1cmFibGUgdmFsdWVzLg0KPiAgICAgVGhlc2UgbWF5IGJlIG1vZGlmaWVk
IHdoZW4gYSBkcml2ZXIgbW9kdWxlIGlzIGxvYWRlZC4qLyBAQCAtODksMTINCj4gKzg3LDYgQEAg
c3RhdGljIGludCByeF9jb3B5YnJlYWs7ICAjaW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPiAgI2lu
Y2x1ZGUNCj4gPGFzbS9ieXRlb3JkZXIuaD4NCj4gDQo+IC0vKiBUaGVzZSBpZGVudGlmeSB0aGUg
ZHJpdmVyIGJhc2UgdmVyc2lvbiBhbmQgbWF5IG5vdCBiZSByZW1vdmVkLiAqLyAtc3RhdGljDQo+
IGNoYXIgdmVyc2lvbltdID0gLURSVl9OQU1FICIuYzp2MS4xMSAxLzcvMjAwMSBXcml0dGVuIGJ5
IERvbmFsZCBCZWNrZXINCj4gPGJlY2tlckBzY3lsZC5jb20+IjsgLXN0YXRpYyBjaGFyIHZlcnNp
b24yW10gPSAtIiAgKHVub2ZmaWNpYWwgMi40Lngga2VybmVsIHBvcnQsDQo+IHZlcnNpb24gIiBE
UlZfVkVSU0lPTiAiLCAiIERSVl9SRUxEQVRFICIpIjsNCj4gLQ0KPiAgTU9EVUxFX0FVVEhPUigi
RG9uYWxkIEJlY2tlciA8YmVja2VyQHNjeWxkLmNvbT4iKTsNCj4gTU9EVUxFX0RFU0NSSVBUSU9O
KCJTTUMgODNjMTcwIEVQSUMgc2VyaWVzIEV0aGVybmV0IGRyaXZlciIpOw0KPiBNT0RVTEVfTElD
RU5TRSgiR1BMIik7IEBAIC0zMjksMTEgKzMyMSw2IEBAIHN0YXRpYyBpbnQNCj4gZXBpY19pbml0
X29uZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmVu
dCkNCj4gIAl2b2lkICpyaW5nX3NwYWNlOw0KPiAgCWRtYV9hZGRyX3QgcmluZ19kbWE7DQo+IA0K
PiAtLyogd2hlbiBidWlsdCBpbnRvIHRoZSBrZXJuZWwsIHdlIG9ubHkgcHJpbnQgdmVyc2lvbiBp
ZiBkZXZpY2UgaXMgZm91bmQgKi8gLQ0KPiAjaWZuZGVmIE1PRFVMRQ0KPiAtCXByX2luZm9fb25j
ZSgiJXMlc1xuIiwgdmVyc2lvbiwgdmVyc2lvbjIpOw0KPiAtI2VuZGlmDQo+IC0NCj4gIAljYXJk
X2lkeCsrOw0KPiANCj4gIAlyZXQgPSBwY2lfZW5hYmxlX2RldmljZShwZGV2KTsNCj4gQEAgLTEz
OTMsNyArMTM4MCw2IEBAIHN0YXRpYyB2b2lkIG5ldGRldl9nZXRfZHJ2aW5mbyAoc3RydWN0IG5l
dF9kZXZpY2UNCj4gKmRldiwgc3RydWN0IGV0aHRvb2xfZHJ2aW5mbyAqDQo+ICAJc3RydWN0IGVw
aWNfcHJpdmF0ZSAqbnAgPSBuZXRkZXZfcHJpdihkZXYpOw0KPiANCj4gIAlzdHJzY3B5KGluZm8t
PmRyaXZlciwgRFJWX05BTUUsIHNpemVvZihpbmZvLT5kcml2ZXIpKTsNCj4gLQlzdHJzY3B5KGlu
Zm8tPnZlcnNpb24sIERSVl9WRVJTSU9OLCBzaXplb2YoaW5mby0+dmVyc2lvbikpOw0KPiAgCXN0
cnNjcHkoaW5mby0+YnVzX2luZm8sIHBjaV9uYW1lKG5wLT5wY2lfZGV2KSwgc2l6ZW9mKGluZm8t
DQo+ID5idXNfaW5mbykpOyAgfQ0KPiANCj4gQEAgLTE1NjQsMjMgKzE1NTAsNCBAQCBzdGF0aWMg
c3RydWN0IHBjaV9kcml2ZXIgZXBpY19kcml2ZXIgPSB7DQo+ICAJLmRyaXZlci5wbQk9ICZlcGlj
X3BtX29wcywNCj4gIH07DQo+IA0KPiAtDQo+IC1zdGF0aWMgaW50IF9faW5pdCBlcGljX2luaXQg
KHZvaWQpDQo+IC17DQo+IC0vKiB3aGVuIGEgbW9kdWxlLCB0aGlzIGlzIHByaW50ZWQgd2hldGhl
ciBvciBub3QgZGV2aWNlcyBhcmUgZm91bmQgaW4gcHJvYmUNCj4gKi8gLSNpZmRlZiBNT0RVTEUN
Cj4gLQlwcl9pbmZvKCIlcyVzXG4iLCB2ZXJzaW9uLCB2ZXJzaW9uMik7DQo+IC0jZW5kaWYNCj4g
LQ0KPiAtCXJldHVybiBwY2lfcmVnaXN0ZXJfZHJpdmVyKCZlcGljX2RyaXZlcik7DQo+IC19DQo+
IC0NCj4gLQ0KPiAtc3RhdGljIHZvaWQgX19leGl0IGVwaWNfY2xlYW51cCAodm9pZCkNCj4gLXsN
Cj4gLQlwY2lfdW5yZWdpc3Rlcl9kcml2ZXIgKCZlcGljX2RyaXZlcik7DQo+IC19DQo+IC0NCj4g
LQ0KPiAtbW9kdWxlX2luaXQoZXBpY19pbml0KTsNCj4gLW1vZHVsZV9leGl0KGVwaWNfY2xlYW51
cCk7DQo+ICttb2R1bGVfcGNpX2RyaXZlcihlcGljX2RyaXZlcik7DQo+IC0tDQo+IDIuNDMuMA0K
PiANCk9uZSBkb3duc2lkZSBpcywgdXNlcnMgd2hvIHByZXZpb3VzbHkgcmVsaWVkIG9uIHRoZSBw
cmludGVkIGVwaWMxMDAgdmVyc2lvbiBzdHJpbmdzIGluIGRtZXNnLCB3aWxsIG5vIGxvbmdlciBz
ZWUgdGhlbS4gDQpSZXZpZXdlZC1ieTogU2FpIEtyaXNobmEgPHNhaWtyaXNobmFnQG1hcnZlbGwu
Y29tPg0KDQo=

