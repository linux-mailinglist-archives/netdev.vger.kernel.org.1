Return-Path: <netdev+bounces-91197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF778B1A47
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 07:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9C61C20BBB
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 05:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922123A1CC;
	Thu, 25 Apr 2024 05:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="XQC+XrD4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7BC3A1B7
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 05:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714022444; cv=fail; b=JDCGJBiz4rKAGakuAsJJ0CKB3mweV/s+xCmwPrLtumXyKwMdMv8dYJFdbuKfUgjPrhS+gqA6tsPaIM2AYj5BUkoUIDgSZUzPZ+TFbTtus+dIATYMBJeqpNvrCH4Mte3DmI88JJA8xwA5XuUKstqQdsh5hBiX5GQ7iOA24Bg6Nfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714022444; c=relaxed/simple;
	bh=JBFKlq3HKXOzPsYZCsk0cYxman2DYNRCusv2oIE9jlU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UNECu4W6dkrgxJ4T8Kqqg8R9dWALQ+h8NxIrmaAry0ulHwQ03tNJtzTnxZdQo+aWPuH4RFGDPq3hBiOJU2KlgY+PKNYrm/bHsuLqNdJIIhwlt1SzUJ1BNjYqADVp6RwhEAj5DYHYwPeRv3DYfwRs4kIOg7aYzOTk50vH97zehvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=XQC+XrD4; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OJQJ4C011467;
	Wed, 24 Apr 2024 22:20:38 -0700
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xpxn1bvye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 22:20:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEJDV058PIE5XTIKe0WS359V5If0308hPz+/S8MggV+801vreqj3n936dvMzW/ZigFYwAaEEOvC/Wovz6Zs9Zfhp8hXAdm9uIGEq8tzKqA8NOyYE8YraPgwJccFiYDUjSWnc0/fGpazZifkttVXA6dZrUTWp91yfU9v19z+EG+75H42HA1V2wTKw/HhyaHMznjhUHpmx4rQf822bDZmrHo2Z0tN+iyU0ZIAmiH27L1fO/XqKRq4jjrOBDdZ7AP6htxcNQgujl9llaQWtumCxTJ2+OCKMaHN3qTASGLkOEJu5H4w4oLCUtbpo+tp5D/bLDgpmUrzKf5sBDy1fcojNhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBFKlq3HKXOzPsYZCsk0cYxman2DYNRCusv2oIE9jlU=;
 b=Gz+DGZyXAfXGYKdLsnVO4de+PM25l+XB/YxqByJcE7VX0wElrEehnhsh9UacS7AYsgK4dkOquVNrvjCVT8RkBfp/sqxqkNOTFyX8MLvDEU5xvAfJw6QkZPDhHJuN1TkH7PDRMv+i6B9hlUmooOlSYwScJD7howNLXJWXposwj5sJDbTa21xD/Y9MIRTBLZwdpS2pvUN5VZUBk58cvdgr3LVkVVIYvJFIdfiEz+NVVGQJFO3dy3ePbiHKVHBSmnskBDmLryaTP1W/pqmLv4DFYyndSrpKqLP+JG0DRdwg9Pvy/Jp7/Z7jgIAjs5Ff44Kbmv+jKI2DioMj98UXA0feWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBFKlq3HKXOzPsYZCsk0cYxman2DYNRCusv2oIE9jlU=;
 b=XQC+XrD4bZl5baB5YcIWAc6Fd7v4FCmMuLye3FGjNub9v1bAShFFSSlt85QLYT6p7wxDxu/YrbijDrNDwYbFZHRjXE0p6PNwohsCILb2flmBw2h4LxTorLRuBF4j5Mo56tyedsXK08/GWePWeqvVCJCheUUPd2nkT3qEIRK4Lqo=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by MN2PR18MB3590.namprd18.prod.outlook.com (2603:10b6:208:26a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 05:20:36 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916%5]) with mapi id 15.20.7452.049; Thu, 25 Apr 2024
 05:20:35 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: =?utf-8?B?UGV0ZXIgTcO8bnN0ZXI=?= <pm@a16n.net>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Michael Chan <michael.chan@broadcom.com>
Subject: [PATCH net v4] net: b44: set pause params only when interface is up
Thread-Topic: [PATCH net v4] net: b44: set pause params only when interface is
 up
Thread-Index: AQHaltBN4A35pT+L3Ei4NwaMRWEgbg==
Date: Thu, 25 Apr 2024 05:20:35 +0000
Message-ID: 
 <PH0PR18MB44741DFBDDF3AA7ADB9F2DDADE172@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <87y192oolj.fsf@a16n.net>
In-Reply-To: <87y192oolj.fsf@a16n.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|MN2PR18MB3590:EE_
x-ms-office365-filtering-correlation-id: 849d2e94-d3a5-43ea-b0f6-08dc64e76fe3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WmxFRXVjcXVnM1RPQzlnaFVZVWl0WDgvMUdhNWRLaWZhVCtNeTR6T2VaR0cr?=
 =?utf-8?B?TXIzTlE5amNOQzJTY3htaXpueWw4eHI5NmtaeGxaVktqQ1d1b1RVK0EvcHhs?=
 =?utf-8?B?NGt5dHYrc0NIbml3SkhHNWh5Z2FaTmtIYWx0NDQybmVzOW03UG9BZWFKT3hu?=
 =?utf-8?B?dkRDdTEwdDlzN3RPb1c5dDJsWDBybEErOFN4NUJpcWVQL1l5YnVIbFNRaFhN?=
 =?utf-8?B?U0Z0RDhqeTRrRmczMk96Qit1eVlLRzhmL3BDQ3BoVUdQLzdEM29ycjB5QlM2?=
 =?utf-8?B?ZGxFbUs0bnovUHhCNHY1RDQ0c01hL200dElBU2UwOWtzVkQ2UjZXV1dXdDZK?=
 =?utf-8?B?NTlRVFRDM2VsYVhya2ZjMElheU5rZlJTTUgyanEwai9sWmc1VVhCZzlIUEJs?=
 =?utf-8?B?U1Fld3I3ME8xQ3ZXNlkyMkNYZGdaL2s5aXpmS1poTytTOGIveFJpdVRUa2N6?=
 =?utf-8?B?bzhkZW9BeUR4NisvZzVETU4zSnU1ZWFSdmh1cnFBamlacG93OUVyTGxVd3Ir?=
 =?utf-8?B?c1NKRlVWZDRmRGJRZ3d2bVZneG5abmR0NjFLR3dUSVlRUkNNQTMvMXN2T0RI?=
 =?utf-8?B?RldSUkpQQ0xKUHExcC9yZkJ6S1VMaWNWbmFtdFlqdEIvRmJjWHJYTkdZR1g0?=
 =?utf-8?B?K1RrVXNHWVhERzZ1OUtka3NkaStRQkI4a1RkWldIMEgxcHEyRUNEbTR2cDho?=
 =?utf-8?B?QSt4UXRPVTQ0Q0dGOXNlZGJrdi9XRWFTY3JLeTlMS2FBWVI4VzZBN1cxSHp6?=
 =?utf-8?B?OTNwZUpwTVJvc1dvcTNLQUh1a2ptc2c0czV1bVNLeC9BaktxRFBGL0dtSkhB?=
 =?utf-8?B?bDBJVnBVdHZWdWIvUmgvOVJGTzloOWdqaVJidFdnbVczOHBmOUpET083bkF4?=
 =?utf-8?B?M0MzVFdrMnhsTkdMRGpONmROQ2RxQjMwaU5neVpUOFBaWjhJVFh6eW51VjYv?=
 =?utf-8?B?ajF6Ym5rbFRDRE9hOWs5WW8weVJJZVFEL05GQXJCTlJFeHZ2VDhxNURQUUhU?=
 =?utf-8?B?Y3JzSUR3dTA2ZzVPcFNDTzEzZ1pWSk9OMjRsV3pSLytLcytGWjRmN3BiR2pQ?=
 =?utf-8?B?U3BXaDdjOWtqT0JMRnF5cU5VcHFWZ0pWZVlCZWszUkNBenRjeXlKdUNLbGFp?=
 =?utf-8?B?SThQUFRmWGVYdEpabGo3VXVOeDVKcTN4d3crV2txakNaQ1JlYmNLT0ozQ2hn?=
 =?utf-8?B?MU16ZG4rK1JvcDhGaUZtN2loZ09PN3AyMDYxNVFKY2x1RUJSVExnNjFyWC85?=
 =?utf-8?B?MWpRUnB0SDVxOStxU0xhNVpxa0kxUitrcDJXUnZwV09QYjE5ODhMdzd5U2Fr?=
 =?utf-8?B?UzFBY1N4SEtPbW9vSEV1VlVlbFIyN1lISjNncUE0bEIwMDdKSVBtQmxoSlY4?=
 =?utf-8?B?QktyUHZZZkp4SDNEejBFbHI5eHErZXFxQW1nVEUvdGRjalREOGlnOWI4U2RX?=
 =?utf-8?B?WWRza0VMQlA4VGlUQktnY2Myd2NRMU9BSXlLR2FvZXpZWjd3a1hhTC9xKzFU?=
 =?utf-8?B?KzRUQnlBQUttNFpmTDAxcnFvbEM3UHpuaTJHaTA4Q2RtRGVkUFdIQm84ZEI2?=
 =?utf-8?B?NFlrNFVEa2FiYTNVa0tsTjZMSDdpem4vS3FEaVk4MmRHeEZFalQrdFM0b3g1?=
 =?utf-8?B?N0VYcUc1cnMrVVNydXRaWmo5MUtsbDV0WFVMN08yTVZqWkdVSHdLa3lqNWVK?=
 =?utf-8?B?bEFPb2k3ajBFYjBJa29tdkN3QUZOMTM3NmVYM3Z2eWl5Q0N1WmxTbUZzcjdT?=
 =?utf-8?B?UFdpa09lWTNsNlNQd3dwNDdiajhsdW1lWlRkN2c5M1d6SWFNMDlKUzYwSGhw?=
 =?utf-8?B?QW5LTWI0L21wZ1J4T3JKZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NnNHRTFDZ2NiblVpbHYraDY4emlRQ2V6Y0U1WjFxbkNnazJoUWhqMmtUWHVH?=
 =?utf-8?B?VkpsVDVGQU9GWVBPT2UrVkttL25jMUo0blNnUDJrak1xNGVRZ2VlTXZ6ZldX?=
 =?utf-8?B?MU1GMmh4SkxDdXJqYWVCaktMQ0ROMXg5bm5lYVVDSUMrejhjKzA5MG9KYytU?=
 =?utf-8?B?OXh2SG9NRzFWZmVpcGFZcm83Z3dHYlBMQ2ZkbkE0SUhkK3JlVTE2NUMyWGxp?=
 =?utf-8?B?V0JiT08xTHBHbVE4eVQxRnIwbjFQZXBwQmNlYThhVWI3L0xwZThwUW4wbDVV?=
 =?utf-8?B?cFd5SlRnZC9GeXpUMFhHQkxpMUk0eUNHM1ZqWWd1Vlg2d2liNjZ4R2hSRkZU?=
 =?utf-8?B?eDVtNlVrdVRyVW9YN2hVSXRuTEtEOXlzdy9rN1F5T2xyN1VqS1IwaGQwRENC?=
 =?utf-8?B?cThuNnp5VittdUFySXVJbndpY1BBZktZSjNtUUNBdGMzSHJtYUxud0RxZ1o4?=
 =?utf-8?B?SmdhaUZ1VmJFWXFCc2pJTDBYY0IrZkkvK3pVQmlSTXAwOHcwczBUV0lGVlRw?=
 =?utf-8?B?MGx0OHdnejgrYWxlYURTU2F6OTVsRytpdmFjOUk3YS8zUmFuYldUUkF1TitX?=
 =?utf-8?B?Ym90TTJjNmhqM3ZWTlV0S2Z6cXl1a2o4bzZoT3ljWHFiTENyRXd6QWk5STE3?=
 =?utf-8?B?WXFXeHduZTI5cnFJK1FBSk1qRVZ6T2QvKzVuVEpDdDRGK2tJVHZvUzdFdy9W?=
 =?utf-8?B?dVJ3S2crMW1uekZnZU9IaWhRVDNmQTBMWnZWVldsZXVVNTVubDAxOUhrY3NM?=
 =?utf-8?B?NVJtOFZaWlJ3QUtyWVRnYUxCbElkNW9rZERTdm5BcDdGWFRPL0Nvc2g0K3l4?=
 =?utf-8?B?eU9OTGdvTUt6Ni9IYVNEQWtvSllZT0tkbnhmODcrSUhWa3dET0s3SG13QVdj?=
 =?utf-8?B?SGhkb2dlT3NFeGRtUWl1SGtWRERrd3Q0TU41cVFVeEZNM1RNNnY1MkhzTHJY?=
 =?utf-8?B?M1ZVU0I3b2YwcUw1VUNuYmZ5UkU1NXFSbkhqTThhaXByd0hLMEQzS1M0Y3Q1?=
 =?utf-8?B?RkdnaXRhU1NBMDZzMG9zcnFaOC9Nd1Q4anhDdzFuejYwM3JlSkoyMzhhRHVs?=
 =?utf-8?B?dlVVNXQ2UHBGQVRreXV1SjdBT3pqa3FIQVo3Z3pRTmdOcEdybkxkbE9oaTVx?=
 =?utf-8?B?VkZ2aUdmV01wTFA5RDJtcEJvYmt2WG1LdFI4dzMvMFJyelY5c3dhUVpJS3ZH?=
 =?utf-8?B?eWprTTVtU0dxKzl3ZE9ZY01TeWQ1RlY3bHFMcks1amdISktwMVFMV1NVRUFu?=
 =?utf-8?B?R0IwVHRMOEMyVkt6WGFFemY1V1BEamQ2QmpmUTFLVHBtQ1owMmNPRnFPS2s0?=
 =?utf-8?B?TmxVRXQ2K2p5bm91bmJ0dklYRlF3bnlLVXNsSTlOenJPbENqa0RyUWFGb3pC?=
 =?utf-8?B?TUhZanU4VmlBYjFIaDB1MnV6ZEU1VlcrWlhXMjkvdktqVHk3aVI4MzI2aXBM?=
 =?utf-8?B?bk1zRWVzMGRYSXNqa2ZxblUwdHdtYTN5UDV6L0w5VTBHRm1hcFhPdkVUOEF3?=
 =?utf-8?B?RzNiNDloaWVSQTB0ejBFOHVBaDV5dzBKM1FieVNuRWdlUjFKc1M4RzIzR3hZ?=
 =?utf-8?B?ZExUd21qZTFXTVBVYVYxQW5jNFBZdEo3MXMyWDVDck0zb0dSMWo0cjduN2FR?=
 =?utf-8?B?WUlpTkg0c0tsL3BpNkMwMHdLRkxWUVYvaXV3RWtka2R6UmVObm9OSjE1TmRL?=
 =?utf-8?B?cXFRZE1FMHBESVFObXI5NUFvZUVZUDRCUzV5YlVlOXora1pITkJiNGo3aDFB?=
 =?utf-8?B?azQxNGltK2JTUENLc0FtMzk1d25WTzUyc1NUYlRvTWJHWTNVMFF2OStMS0tC?=
 =?utf-8?B?a3crN25MMGlocDdYdmViTTdaSHY5VUNkZ3lGVmlQd0tWSC8zWWtmUnNxWE0y?=
 =?utf-8?B?WENhUTdkNVdvdUxwamx4eFFrWDR5akRQTlM4SGt6TEREV05xaGRQam9vMjBG?=
 =?utf-8?B?emdMN29ULzJNUTkvUjc2YVNLUVNVeHRYRy94Lzk3YWlWaGJocXBzV3ZvZ0hT?=
 =?utf-8?B?Q3VqOXNsbjg4TzFoamR0L3doOFk5WmNPRVl5amlMaitZTEpVcE85eXlCeGlv?=
 =?utf-8?B?MUNENmJXR0ozOSthMVJVOFVNZExNOXd1Wk9wMVAwMXhBTUNxVE5OM3pUSUZY?=
 =?utf-8?Q?EHVY=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4474.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 849d2e94-d3a5-43ea-b0f6-08dc64e76fe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 05:20:35.7057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ya5ZqLYtR5y22DeLHZh85CybXc+hHE+0qCiS7ep07A2xVww2xKIKqg0e2QxF9opXcQhxMsTni+6C0zqVXeWG5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3590
X-Proofpoint-GUID: XGZH-0VHeWNorX_uk9L6haesx-gG0g8D
X-Proofpoint-ORIG-GUID: XGZH-0VHeWNorX_uk9L6haesx-gG0g8D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_04,2024-04-24_01,2023-05-22_02

DQpVbmRlcnN0b29kLCB0aGlzIHBhdGNoIGZpeGVzIHRoZSBwYW5pYyBpc3N1ZS4NCiBTZWUgaW5s
aW5lIGZvciBmZXcgY29tbWVudHMsDQoNCj4gYjQ0X2ZyZWVfcmluZ3MoKSBhY2Nlc3NlcyBiNDQ6
OnJ4X2J1ZmZlcnMgKGFuZCA6OnR4X2J1ZmZlcnMpIHVuY29uZGl0aW9uYWxseSwNCj4gYnV0IGI0
NDo6cnhfYnVmZmVycyBpcyBvbmx5IHZhbGlkIHdoZW4gdGhlIGRldmljZSBpcyB1cCAodGhleSBn
ZXQgYWxsb2NhdGVkIGluDQo+IGI0NF9vcGVuKCksIGFuZCBkZWFsbG9jYXRlZCBhZ2FpbiBpbiBi
NDRfY2xvc2UoKSksIGFueSBvdGhlciB0aW1lIHRoZXNlIGFyZQ0KPiBqdXN0IGEgTlVMTCBwb2lu
dGVycy4NCj4gDQo+IFNvIGlmIHlvdSB0cnkgdG8gY2hhbmdlIHRoZSBwYXVzZSBwYXJhbXMgd2hp
bGUgdGhlIG5ldHdvcmsgaW50ZXJmYWNlIGlzDQo+IGRpc2FibGVkL2FkbWluaXN0cmF0aXZlbHkg
ZG93biwgZXZlcnl0aGluZyBleHBsb2RlcyAod2hpY2ggbGlrZWx5IG5ldGlmZCB0cmllcw0KPiB0
byBkbykuDQo+IA0KPiBMaW5rOiBodHRwczovL2dpdGh1Yi5jb20vb3BlbndydC9vcGVud3J0L2lz
c3Vlcy8xMzc4OQ0KPiBGaXhlczogMWRhMTc3ZTRjM2Y0IChMaW51eC0yLjYuMTItcmMyKQ0KPiBD
Yzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBSZXBvcnRlZC1ieTogUGV0ZXIgTcO8bnN0ZXIg
PHBtQGExNm4ubmV0Pg0KPiBTdWdnZXN0ZWQtYnk6IEpvbmFzIEdvcnNraSA8am9uYXMuZ29yc2tp
QGdtYWlsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogVmFjbGF2IFN2b2JvZGEgPHN2b2JvZGFAbmVu
Zy5jej4NCj4gVGVzdGVkLWJ5OiBQZXRlciBNw7xuc3RlciA8cG1AYTE2bi5uZXQ+DQo+IFJldmll
d2VkLWJ5OiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+IFNpZ25lZC1vZmYtYnk6IFBl
dGVyIE3DvG5zdGVyIDxwbUBhMTZuLm5ldD4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5l
dC9icm9hZGNvbS9iNDQuYyB8IDE0ICsrKysrKysrLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2Jyb2FkY29tL2I0NC5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
YnJvYWRjb20vYjQ0LmMNCj4gaW5kZXggM2U0ZmIzYzNlODM0Li4xYmU2ZDE0MDMwYmMgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2Jyb2FkY29tL2I0NC5jDQo+ICsrKyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2Jyb2FkY29tL2I0NC5jDQo+IEBAIC0yMDA5LDEyICsyMDA5LDE0
IEBAIHN0YXRpYyBpbnQgYjQ0X3NldF9wYXVzZXBhcmFtKHN0cnVjdCBuZXRfZGV2aWNlDQo+ICpk
ZXYsDQo+ICAJCWJwLT5mbGFncyB8PSBCNDRfRkxBR19UWF9QQVVTRTsNCj4gIAllbHNlDQo+ICAJ
CWJwLT5mbGFncyAmPSB+QjQ0X0ZMQUdfVFhfUEFVU0U7DQo+IC0JaWYgKGJwLT5mbGFncyAmIEI0
NF9GTEFHX1BBVVNFX0FVVE8pIHsNCj4gLQkJYjQ0X2hhbHQoYnApOw0KPiAtCQliNDRfaW5pdF9y
aW5ncyhicCk7DQo+IC0JCWI0NF9pbml0X2h3KGJwLCBCNDRfRlVMTF9SRVNFVCk7DQo+IC0JfSBl
bHNlIHsNCj4gLQkJX19iNDRfc2V0X2Zsb3dfY3RybChicCwgYnAtPmZsYWdzKTsNCj4gKwlpZiAo
bmV0aWZfcnVubmluZyhkZXYpKSB7DQo+ICsJCWlmIChicC0+ZmxhZ3MgJiBCNDRfRkxBR19QQVVT
RV9BVVRPKSB7DQo+ICsJCQliNDRfaGFsdChicCk7DQo+ICsJCQliNDRfaW5pdF9yaW5ncyhicCk7
DQo+ICsJCQliNDRfaW5pdF9odyhicCwgQjQ0X0ZVTExfUkVTRVQpOw0KPiArCQl9IGVsc2Ugew0K
PiArCQkJX19iNDRfc2V0X2Zsb3dfY3RybChicCwgYnAtPmZsYWdzKTsNCj4gKwkJfQ0KPiAgCX0N
ClRoZSBhY3R1YWwgcmVnaXN0ZXIgY29uZmlnIHRvIGVuYWJsZSBwYXVzZSBmcmFtZSBpcyBwcm90
ZWN0ZWQgd2l0aCAibmV0aWZfcnVubmluZyIsIGRvZXMgZHJpdmVyIG5lZWQgdG8NCnJlamVjdCB0
aGUgcmVxdWVzdCBpZiBpbnRlcmZhY2UgaXMgZG93bi4NCk90aGVyd2lzZSwgdGhlcmUgaXMgbWlz
bWF0Y2ggaWYgc29tZW9uZSByZWFkcyBwYXVzZSBmcmFtZSBzdGF0dXMgKGI0NF9nZXRfcGF1c2Vw
YXJhbSkuDQoNCg0KVGhhbmtzLA0KSGFyaXByYXNhZCBrDQo+ICAJc3Bpbl91bmxvY2tfaXJxKCZi
cC0+bG9jayk7DQo+IA0KPiAtLQ0KPiAyLjM1LjMNCg0K

