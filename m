Return-Path: <netdev+bounces-243192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC93BC9B365
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 11:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B59F3A2211
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 10:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3681258ED5;
	Tue,  2 Dec 2025 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZhlluuYt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5998F19AD8B;
	Tue,  2 Dec 2025 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764672368; cv=fail; b=CGGlDRH9WPRr0+c9l1fxchUKp4IJHKXu8LyZ4x+nwTPC99gyBqmXi8dwmJ+OMVrO//MjSz9sZEIiWUj3TA6xVe+lev6AGt9abpyoCcR0f8hC7e+tFNZH5pYIZ53GrFaYGYRpjVCEqHoh6/X5IAQI2/KK3s/DBhR3lS2zNcj4i6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764672368; c=relaxed/simple;
	bh=X4myTZr8H/qHBElMgqeIB69OG+cMI0Z30oWV1Bq6TFo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HYGfJ/AaOtdqeUcF+mI/LCKwOjd0aGOFdIrakcT36H1JFr78Gb3Nl7iIJk27J1t1jyQJ6+/yNXMR1ECI+77kZT6JJYtjDW9nqFgpAV1OspL51cqF4Y86O6V0wixB6T0vrNvmfWGB0MSou/M6EE9mloibPzyh2wwzkDmhBvmK3r0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZhlluuYt; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B29a4Ob3455979;
	Tue, 2 Dec 2025 02:45:48 -0800
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022107.outbound.protection.outlook.com [40.93.195.107])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4aswmcg35v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 02:45:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJTjObOcJnlQ4I0hMy7sxDfGidv7OHnDdkLvOMQDbu5TxjfURdorl17oveMqg+3YPuiL9Or4gojRC0g0IAjJWZEwrd9YK9A395x1q1ZXgaaG1SdRXjRbOATbIhl7pWmzk9WBkVSJhJEED9PJIn9wnNJzpdQkgzzwPNud0QN5zB02kg4A/4SqfkgT9QYIWC+NytDeLKqEzEMG7iu9tWKqY6Irn9FXCeNljJBJ1m890BTDDS/wHBBcw5FIHznvIK4SrPffAxdMzjoH063xc4WDN7uZZ2ZZ2qEtlfp1DRG4E6p92WDCBYnbr8ecRazF/wY3qQ+XLwd5Rut7fThytxIhrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4myTZr8H/qHBElMgqeIB69OG+cMI0Z30oWV1Bq6TFo=;
 b=tvGOwGEzqc+p+73FYfa4B8GZdtdKQr782Dn6M+vigGaMSLW5/Fw+yMUATGsloT+m7E+FAZfILtNxhoelzK5b4Jt0hia1r817OeL4xYwUM70bXC/EL+cZ7OnUGz61eQDB4KMv1qq9xAE77tR9cLG1Qgh6lfa8s9s0PyOMDXSMMX1uMhdKJk5PA72iuYJJ2xCvxDIIBABAGgyP62XJ7u9HLBNORLVOoJAHaiJv53fUwJUugmIM1IdtAykZF4sz5DzkomWhR4mqvixZ1pA2AWyjM7UbR76jSv8yqgezn4DT0ddab2cpFMJSOI8eP3CuSp5QpRYYgdPm6Y2oXDcYJakeSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4myTZr8H/qHBElMgqeIB69OG+cMI0Z30oWV1Bq6TFo=;
 b=ZhlluuYt4CbYDrgBlZp+cAAZthWUngD9cW+sbL7y0EhL8c6VLNxb5Mj7y8Bc0SvBy1NYGQDz34U3+NEi0I1792UCPXRQ7coIdGjKlt3kVfg1C5ZumQdQf2/Avl2SH9iJ6YTBCGMRQtdAN3dDFKTGZZmNY77yONYnHGYpYrEMF7A=
Received: from MN6PR18MB5466.namprd18.prod.outlook.com (2603:10b6:208:470::21)
 by SJ0PR18MB3913.namprd18.prod.outlook.com (2603:10b6:a03:2ea::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 10:45:45 +0000
Received: from MN6PR18MB5466.namprd18.prod.outlook.com
 ([fe80::bf0a:4dd:2da5:4ab2]) by MN6PR18MB5466.namprd18.prod.outlook.com
 ([fe80::bf0a:4dd:2da5:4ab2%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 10:45:44 +0000
From: Vimlesh Kumar <vimleshk@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sathesh B
 Edara <sedara@marvell.com>,
        Shinas Rasheed <srasheed@marvell.com>,
        Haseeb
 Gani <hgani@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew
 Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v1 1/1] octeon_ep: reset firmware
 ready status
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v1 1/1] octeon_ep: reset firmware
 ready status
Thread-Index: AQHcWhAtgAe279Pq6Uipm99EnqeCn7UCAkyAgAw4jFA=
Date: Tue, 2 Dec 2025 10:45:44 +0000
Message-ID:
 <MN6PR18MB5466C31F8BAB1ADBE1D8BD07D3D8A@MN6PR18MB5466.namprd18.prod.outlook.com>
References: <20251120112345.649021-1-vimleshk@marvell.com>
 <20251120112345.649021-2-vimleshk@marvell.com>
 <aSSAtY6C8QyRoW42@horms.kernel.org>
In-Reply-To: <aSSAtY6C8QyRoW42@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR18MB5466:EE_|SJ0PR18MB3913:EE_
x-ms-office365-filtering-correlation-id: e87daa4c-a354-4516-6535-08de318ff24c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UFpzTDZySko1S2NjcHFKci95TTFTSVdZbmI0YWhhUStUbGtjNDRnSjJKcEJM?=
 =?utf-8?B?bWRsNlNmM3kyT2prRUQ4eWsyTFpzZDVnOXlWcEQ5UUxzbEpSaG5vdFA0bTZX?=
 =?utf-8?B?SnhMMTh2QVBMWUQxVXdwUWhsT3RaS1N1SWNOZCtzUHNDQkJCVjFnVFpqMXpY?=
 =?utf-8?B?Sld5UDF2dFBVdzB5MU5BdTJmS0NaS3FIUGJxL3NoT215NjVFTFkrbnp6UzBr?=
 =?utf-8?B?MytUR3VlZEtBYlJhT0Q1NnZZakhnbVI3bkEvZnpVSGZkcGpkcERzUzJ5d3N3?=
 =?utf-8?B?SzdIcmZDSlc2ODRYYnlnaFdmYjc3R0tkRjhNdGxPMDRjYms2M2htd3hmcStD?=
 =?utf-8?B?RXVsd0pxWWU3dS9XSDZiWUpLaVhyZ0Jzd3ZrK3BEMTFzYWM0S0pmc2crT1FX?=
 =?utf-8?B?RHppNjNWUGplQkNhdVFkWmYyTXpxUklSTExqbVVwaFM3RXZJcDlKbjhwbnp3?=
 =?utf-8?B?UWZjUHp6Y0VhcmRYemE0OXRoTUowVEVnbXEwdkpNMHRaU3BSOHo3R1h2MmRH?=
 =?utf-8?B?aHRNQWg4bXRxT3BuVXJvaHkrdUkwclJsMkZwbUFiMlh6Z1RRbUNyME1jLzVE?=
 =?utf-8?B?c0pkOC9xbUFXWGhJL3hqZnU5Qy8yc05FdjQyV2pLYnBicVc5NFNDakpWTXRm?=
 =?utf-8?B?N25Ob3BmSUVHTllhNDFMTGRuaGNwbmU2SzNyMG1HNDJPYWNrQUdka1FkZ0xO?=
 =?utf-8?B?cHNNdG9jMEs5L2NoNVB3RmFxQjllMmpaZy9iMHFiajd5YTl4a29nQkp2R2pQ?=
 =?utf-8?B?Y1M2QUJ1blQxQnRQRk9sZjN1b3NKWWxYUEJoMmRFSzQzMGF0MEtTRlNOcmtt?=
 =?utf-8?B?RUdFa0Fnd3kvTm1LeTlKZ1RETkZTVnlDVmE2SGlOZ1FXQWQvWnNLODhWVUpy?=
 =?utf-8?B?U3R2UEMrQUptdTNvQ0NyTUZRcUtlc1VFNU40dDVaeEhoVExxQWMwTmNaOHo3?=
 =?utf-8?B?YUhZYW1FRWg4Q3RGMDd6OGpnVGZIK2o1clVLenpRMDE4emxqMzRiRUtlYnZP?=
 =?utf-8?B?TW94aDhFTEN0MitiUkgyUjZHbXh2KzUxSjRXUEJMY2dEWjNpeXIzNTRhVGx4?=
 =?utf-8?B?bnNtNTRpeGhDMExZRytQVHFCWjVpWXBiMTBIN0JmNENiOGtMTDZORlhTdk1K?=
 =?utf-8?B?MDV5UDF3NUphSnU0eHdUaGp5bXBkL0t3ait2cG9RK2JRZmtSTGRPc0F0bHJZ?=
 =?utf-8?B?RlNXaWZhSWJmNmtlWUZuZE5jTzlIZ0JleW53OVlYZlZpd1NpOWdoN2pWWXBx?=
 =?utf-8?B?djducDNQQWNDWG1Kdk9Wck5pK2s2V3Zjb25jR1Qxdm9LRXhzcVM3SWx2cXJK?=
 =?utf-8?B?eUZMZWw2cDlNYXVPelcvTW1Zb3BQN3FFZDg2NWR5em9BYzdQWXhVYWIvK0VP?=
 =?utf-8?B?dnVaaUErQ2lNa2ZBTmZJOWo0Rzc1MytCL2tLOVpudHk0QWFRaW13U1NaTFMr?=
 =?utf-8?B?RmEwRFIvM3VIKzBHN3JlS3h6R3ZzaGhHOXZEQlpUVzVsbWkvVkdHbzdCQk1K?=
 =?utf-8?B?SzBZdXpNa2lENGhNT1p3T2dFMTNCcFJMck9hSGxUV1dnTlQ1MklhTmRFMGZF?=
 =?utf-8?B?T244Q3hpWDZxTUtrcmNMZ052USt3ZnVqVXJFTjh2UlpYM2p4dHAvc21XV1RZ?=
 =?utf-8?B?bzBSRjZ0VythUDJ0TjUvbXJIdGxYaWxVZStIczE5T0IxUlh2VnAyMks5YnNy?=
 =?utf-8?B?aTZEK3RXU3ZHZjBVZjdxcXpTNlRVakh2TFZBbE0xdFE0NDV2R1FxYUczUEN5?=
 =?utf-8?B?ZzhxdW4wNUM5QWQxeFo0U2ZaWWFKTC9JZlI1dDNERC8vZG5rODZYUmlTdFUy?=
 =?utf-8?B?TDQyRnpvVGNlZkJ0aDJCR08vMHJxd0FjaDFFcWxwSXhzbEpaL0pGbXlVdGcz?=
 =?utf-8?B?WmljYVF3cndkVm9pSHM2R3VDSEp5Q3pocy9Ga0U2M2NTTmdSRTNwdnBGaTF6?=
 =?utf-8?B?OGRka1ZXcVVmSVc4ZjZDeFQ1WXlVVlNIR1g5cDA0NWFiUkZKdml5QndEQm1W?=
 =?utf-8?B?dXR3MFhqTHdBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR18MB5466.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UFg0OWVSSDYrU3ZtWW1XREg2ekx1LzFscUg2dHFKS0R6YjFCRDY0VWxCRkxZ?=
 =?utf-8?B?OXFtSnhJQlNmYis1ZVMxOFdDdnpVWHlJb1Nhd25NYjlTWXJ5R1A3SjlMeVNH?=
 =?utf-8?B?VVcwNjY0c3lDSWF3QmF2bGpkKzljNDZIVTNKZmd1amJRWTNLakc2anJFWndp?=
 =?utf-8?B?Y2l1cTBXandaSWZHb1U0UmR1RmJYdXdBcHcxV0wvNEVvcG4yRWUzMzhxdURC?=
 =?utf-8?B?TFp3aktiT2UyeUtodzM2aHhYZnh2akg5QllMQ3dnay94bzczZU9nQmhhRnZ5?=
 =?utf-8?B?MSt1Yjc4bjg3c2JjdEtsNWtvUk5EOXJpWDRaSG9IbFAwT2E4azFCemlQSDJW?=
 =?utf-8?B?aWZ3aVJwSmd6bW0vOWthN056S1FMdmV3Q2RYbHJLVTVaRjMzVmkzRjFENUR4?=
 =?utf-8?B?citId3E0MzVpNjJCbE5acUtyYmVkK3lSenJjZGJVemVFa3ZDYXd1NVF2b1pN?=
 =?utf-8?B?YzJZWTZZSUxLYWJRL3grN1puMXJlaGFpamJZcXV4U3VOUytBbE14SGdDV29j?=
 =?utf-8?B?b2p6ZnFSUnQ0OTQ0eTA5MlZuRndNM21PaVREYldlSzlsank5OUdnWGIwTFlZ?=
 =?utf-8?B?b2gySDEzZ05CZFhLMXh3U1Bxa3ErZGZrK20zVFZIRUNtV0p3ZnpEMjd0WkRT?=
 =?utf-8?B?NGt4VjNFMHNGV2dWN3FvQlhaQWc1bUpZdFZtTXpOOWFkSVJCenFRVXZRUVdx?=
 =?utf-8?B?c0xXQlRvU3JiTDk0YmJoNGc1NWk3MG54YkJLMkRlNUZuL3N5b3l0MXZ0MmUr?=
 =?utf-8?B?YXYwV1h6M1laeTRUNlZaQ3huczZVekF3ZlJZM1dqY3A1WGlCb05sU0JiT25W?=
 =?utf-8?B?RW5xZ1lXWnAxMUpkSW1wVEhTNjdQNmZpejYvY3g1ZDQxN1JxSVR2L2RXaUpR?=
 =?utf-8?B?aVFGcmRqNGNFbDhNTkR3Ry9UdGxCWHNGUXVXK1kzOVRLS3FGRklVYUUxeEJk?=
 =?utf-8?B?Skw5WjRXY3ZQMFplVmFUQkRaVE5MMzRvRmRlMDd3MkZNODJyQytVRVNKT1cz?=
 =?utf-8?B?T2RoM2tzVXpDYllPSXNOZFg1MzRibElFUDNtaEp4a2VRWGtSbVNTakMrK3dX?=
 =?utf-8?B?WFZMWktHMGk3TDJIanlFeEZwTFJXMkZ0Y1c5ZVdCVElGeGtDb2poUGFka0FE?=
 =?utf-8?B?OW02MVJmYjFzSW1YWHZPTWNXblRSR0ZuTkl4Q1ZtVDczdU9OL0lTZGoxeW5W?=
 =?utf-8?B?UWZNUC9lMkRPU0pKekkwSXZKZ2s5UG5JWm5HUXFXZWU0L2VpRzBRZGhKRjMw?=
 =?utf-8?B?L3N5U3pWbDV1V1JGaEZTTTJhOEJUVzg3YWlwaUo5dlF3U2Y0NU1nTkcrbEkx?=
 =?utf-8?B?V0Znd3pyc0FBMGNzWUx5Q2grWUlWSWN4d3J2ZklxQjhKb1ZTUVMxcGdiQms3?=
 =?utf-8?B?Y0tKVkFRc0NxUEtxVThGRittNjIxdTRoc1RoRkZNMkhjL3p5cTMxUWd6bkhi?=
 =?utf-8?B?S1l4VWoyeUZBcTVoa1RmWTE4Vitnckx2aG1jRC9ma05SL1FrVGowd1VSZ2Zn?=
 =?utf-8?B?OFVOYXdrVnUyQ3krUzZNSjkwMEFPUTJCYm1WSkRSdnJyY3l5bkJnZVBkZ05G?=
 =?utf-8?B?TUxkQW44NU0xVjgxZ0tqVjUwa2ZBVFQzRldKYy9MUHB1d0YzTTZjeUtXSG9E?=
 =?utf-8?B?VThsaFJEZlhwU0orbmR4MUFRY0tWOFNXcmEwZ1Zac2o2OTNsaGd3QVRyQVc0?=
 =?utf-8?B?WkQ5UGN5dUNuZnhCa0RsQXpYMkd6Z1Qwcm1pYUw0SzZDWFJUd1F0eE1Sdkhp?=
 =?utf-8?B?dVdjdmRncm9XV2V2WUlIRTFKMlh0bVkyMEoyTldZbFJwSkwyTkl1L3RhdUkw?=
 =?utf-8?B?TC9UNU9hcDBMUHpIWGErVXl3alpOYnc0U0JUaWQ1VVlpNWlCTUpCakdld2l4?=
 =?utf-8?B?Z2x3OXZJZDF1Z3kzb1k2YW9yaGJreUFzbFlDUXRqRHJWMWovYnVGMi8xNXVM?=
 =?utf-8?B?QWVGSHIyY0dxTWwzS0lsL0tOeXR2K2xmOE9PbHVjVVdqQWo1Yi9xWjgybjF6?=
 =?utf-8?B?ZnBpbElCY2tuVlRiUlhzWkp0ZzJodzJyKzhZS3Myc011emRhVHNoeEt6YXlZ?=
 =?utf-8?B?Q1pSTW9HQldla3hQb0ZyZ0thenlSUW1UbkJjU05sSlZyZWp0RkFmQzFVZ05C?=
 =?utf-8?Q?GUcKvXlqrsir+wYxOB0yw/O9U?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN6PR18MB5466.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e87daa4c-a354-4516-6535-08de318ff24c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 10:45:44.7778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t+3gCmBUyh4NczSYYUi190AuSjhOnUHMreWyGpJptv0xtd3kRfMTdvTnAl/VJU0X6pc0eR2J4Hxt7gzhCpFJLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3913
X-Authority-Analysis: v=2.4 cv=KrlAGGWN c=1 sm=1 tr=0 ts=692ec35c cx=c_pps
 a=8M1Omf0bnxBxzy+yzgHWvw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RpNjiQI2AAAA:8 a=M5GUcnROAAAA:8 a=XqIoi9OfijjE5HhLyxoA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Aj0AcNOjmRZ53GwivMGL7kRcxpzj6Q3q
X-Proofpoint-ORIG-GUID: Aj0AcNOjmRZ53GwivMGL7kRcxpzj6Q3q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDA4NiBTYWx0ZWRfX9gciZfUnM2NE
 oSqiw8xhsVUDvfzytbtshP0U6rOEdKtJqsNUp5+yfzT1RtgpOToiJczXgWO9MjUpfNBWNRzoeZQ
 +VKLBNp3kf6SdaW8miJj6y+LhHDe2IGrqYyFB0QaJTGd/611KZhEUPfk+u3jOR5GiKzt9CJkI3Z
 mFbSuMQlaLaKvQat1SUTb74m3JU4gYdaH8zsjOIVmJODREB+hEm4ML9n6ghvZie/Y2RN/WVpGU7
 2i//DpWTHFRwP2wyI9elWE+NgqvRJ+A3n/cQplltthbt36uzIfNaomfuSIPwp9uBPkFwI2lEjRA
 iI1R4OtqHrOOzpqzThSZZIeEogxIMpcVniDdjrQPwOzn9SyqYp733kUK3gcq2oSXMKRURL5/Q4f
 qdv3r56X4vdf4jFLX1gMdmqEXAlAOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gT24gVGh1LCBOb3YgMjAsIDIwMjUg
YXQgMTE6MjM6NDRBTSArMDAwMCwgVmltbGVzaCBLdW1hciB3cm90ZToNCj4gPiBBZGQgc3VwcG9y
dCB0byByZXNldCBmaXJtd2FyZSByZWFkeSBzdGF0dXMgd2hlbiB0aGUgZHJpdmVyIGlzDQo+ID4g
cmVtb3ZlZChlaXRoZXIgaW4gdW5sb2FkIG9yIHVuYmluZCkNCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFNhdGhlc2ggRWRhcmEgPHNlZGFyYUBtYXJ2ZWxsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBTaGluYXMgUmFzaGVlZCA8c3Jhc2hlZWRAbWFydmVsbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1i
eTogVmltbGVzaCBLdW1hciA8dmltbGVzaGtAbWFydmVsbC5jb20+DQo+IA0KPiBJJ20gYSBsaXR0
bGUgY29uZnVzZWQgYWJvdXQgdGhlIGFzeW1tZXRyeSBvZiB0aGUgY245ayBhbmQgY254ayBjb2Rl
IGJlZm9yZQ0KPiB0aGlzIHBhdGNoLiBNYXliZSBpdCB3b3VsZCBtYWtlIHNlbnNlIHRvIHNwbGl0
IHRoaXMgaW50byB0d28gcGF0Y2hlcywgb25lIGZvcg0KPiBjbjlrIGFuZCBjbnhrIHdpdGggbW9y
ZSBzcGVjaWZpYyBjb21taXQgbWVzc2FnZXMuDQo+IA0KPiBBbmQgZm9yIGJvdGggY245ayBhbmQg
Y254aywgSSdtIHVuY2xlYXIgb24gdGhlIHdoYXQgdGhlIGJlaGF2aW91ciB3YXMNCj4gYmVmb3Jl
IHRoaXMgcGF0Y2g/IElPVywgaXMgdGhpcyBhIGJ1ZyBmaXggZm9yIGVpdGhlciBvZiBib3RoIG9m
IHhuOWsgYW5kIGNua3g/DQo+IA0KDQoNCkR1ZSB0byBhIGhhcmR3YXJlIGJ1ZywgdGhlIGZpcm13
YXJlLXJlYWR5IHN0YXR1cyBpcyBub3QgY2xlYXJlZCBhcyBleHBlY3RlZC4gVG8gd29yayBhcm91
bmQgdGhpcyBpc3N1ZSwgd2UgaW50cm9kdWNlIHRoZSBmb2xsb3dpbmcgbWVjaGFuaXNtIHRvIHRy
YWNrIGZpcm13YXJlIHN0YXRlczoNCg0KSW5pdGlhbCBzdGF0ZTogMA0KRmlybXdhcmUgcmVhZHk6
IDENCkRyaXZlciBsb2FkZWQ6IDINCkRyaXZlciB1bmxvYWRlZDogMA0KDQpUaGlzIHBhdGNoIGlt
cGxlbWVudHMgdGhlIHdvcmthcm91bmQgYW5kIGVuc3VyZXMgcHJvcGVyIHN0YXRlIHRyYWNraW5n
Lg0KDQo+ID4gLS0tDQo+ID4gIC4uLi9tYXJ2ZWxsL29jdGVvbl9lcC9vY3RlcF9jbjlrX3BmLmMg
ICAgICAgICB8IDIyICsrKysrKysrKysrKysrKysrKysNCj4gPiAgLi4uL21hcnZlbGwvb2N0ZW9u
X2VwL29jdGVwX2NueGtfcGYuYyAgICAgICAgIHwgIDIgKy0NCj4gPiAgLi4uL21hcnZlbGwvb2N0
ZW9uX2VwL29jdGVwX3JlZ3NfY245a19wZi5oICAgIHwgMTEgKysrKysrKysrKw0KPiA+ICAuLi4v
bWFydmVsbC9vY3Rlb25fZXAvb2N0ZXBfcmVnc19jbnhrX3BmLmggICAgfCAgMSArDQo+ID4gIDQg
ZmlsZXMgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9uX2VwL29jdGVw
X2NuOWtfcGYuYw0KPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb25fZXAv
b2N0ZXBfY245a19wZi5jDQo+ID4gaW5kZXggYjU4MDU5Njk0MDRmLi42ZjkyNmU4MmMxN2MgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb25fZXAvb2N0
ZXBfY245a19wZi5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rl
b25fZXAvb2N0ZXBfY245a19wZi5jDQo+ID4gQEAgLTYzNyw2ICs2MzcsMTcgQEAgc3RhdGljIGlu
dCBvY3RlcF9zb2Z0X3Jlc2V0X2NuOTNfcGYoc3RydWN0DQo+ID4gb2N0ZXBfZGV2aWNlICpvY3Qp
DQo+ID4NCj4gPiAgCW9jdGVwX3dyaXRlX2NzcjY0KG9jdCwgQ045M19TRFBfV0lOX1dSX01BU0tf
UkVHLCAweEZGKTsNCj4gPg0KPiA+ICsJLyogRmlybXdhcmUgc3RhdHVzIENTUiBpcyBzdXBwb3Nl
ZCB0byBiZSBjbGVhcmVkIGJ5DQo+ID4gKwkgKiBjb3JlIGRvbWFpbiByZXNldCwgYnV0IGR1ZSB0
byBhIGh3IGJ1ZywgaXQgaXMgbm90Lg0KPiA+ICsJICogU2V0IGl0IHRvIFJVTk5JTkcgcmlnaHQg
YmVmb3JlIHJlc2V0IHNvIHRoYXQgaXQgaXMgbm90DQo+ID4gKwkgKiBsZWZ0IGluIFJFQURZICgx
KSBzdGF0ZSBhZnRlciBhIHJlc2V0LiAgVGhpcyBpcyByZXF1aXJlZA0KPiA+ICsJICogaW4gYWRk
aXRpb24gdG8gdGhlIGVhcmx5IHNldHRpbmcgdG8gaGFuZGxlIHRoZSBjYXNlIHdoZXJlDQo+ID4g
KwkgKiB0aGUgT2N0ZW9uVFggaXMgdW5leHBlY3RlZGx5IHJlc2V0LCByZWJvb3RzLCBhbmQgdGhl
bg0KPiA+ICsJICogdGhlIG1vZHVsZSBpcyByZW1vdmVkLg0KPiA+ICsJICovDQo+ID4gKwlPQ1RF
UF9QQ0lfV0lOX1dSSVRFKG9jdCwgQ045S19QRU1YX1BGWF9DU1hfUEZDRkdYKDAsIDAsDQo+IENO
OUtfUENJRUVQX1ZTRUNTVF9DVEwpLA0KPiA+ICsJCQkgICAgRldfU1RBVFVTX0RPV05JTkcpOw0K
PiA+ICsNCj4gDQo+IFRoZXJlIHNlZW1zIHRvIGJlIHNvbWUgaW5jb25zaXN0ZW5jeSBiZXR3ZWVu
IHRoZSBjb21tZW50LCB3aGljaA0KPiBkZXNjcmliZXMgc2V0dGluZyB0aGUgc3RhdHVzIHRvIFJV
Tk5JTkcsIGFuZCB0aGUgY29kZSwgd2hpY2ggc2V0cyB0aGUgc3RhdHVzDQo+IHRvIERPV05JTkcu
DQo+DQoNCkNvbW1pdCBtZXNzYWdlIGRlc2NyaWJlcyB0aGF0IHdlIGFyZSByZXNldHRpbmcgdGhl
IGZpcm13YXJlIHJlYWR5IHN0YXR1cyBhcyAiZG93bmluZyIuIA0KIA0KPiBGbGFnZ2VkIGJ5IENs
YXVkZSBDb2RlIHdpdGgNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3Vy
bD91PWh0dHBzLQ0KPiAzQV9fZ2l0aHViLmNvbV9tYXNvbmNsX3Jldmlldy0NCj4gMkRwcm9tcHRz
XyZkPUR3SUJBZyZjPW5LaldlYzJiNlIwbU95UGF6N3h0ZlEmcj1iaGYzTjVDcjlORmJad2wNCj4g
YTZFYlpoWXBSSGhRemZycXhNaXBZSVpwQ01ZQSZtPXl6NlgzRkFSRUc0bEVuTW0xTlo1dGxFYkE5
M0xOcA0KPiBtQXVCLW9BRDB2NXRGNEZwdC0NCj4gQUo1U2NoTWg0SGFzMzJVaCZzPWl3cHV1Zndm
eXBQakxaNk93SW1NSmR3c1ZSV3NfeWxub2k4TW4zM1dCDQo+IEtRJmU9DQo+IA0KPiA+ICAJLyog
U2V0IGNvcmUgZG9tYWluIHJlc2V0IGJpdCAqLw0KPiA+ICAJT0NURVBfUENJX1dJTl9XUklURShv
Y3QsIENOOTNfUlNUX0NPUkVfRE9NQUlOX1cxUywgMSk7DQo+ID4gIAkvKiBXYWl0IGZvciAxMDBt
cyBhcyBPY3Rlb24gcmVzZXRzLiAqLyBAQCAtODk0LDQgKzkwNSwxNSBAQCB2b2lkDQo+ID4gb2N0
ZXBfZGV2aWNlX3NldHVwX2NuOTNfcGYoc3RydWN0IG9jdGVwX2RldmljZSAqb2N0KQ0KPiA+DQo+
ID4gIAlvY3RlcF9pbml0X2NvbmZpZ19jbjkzX3BmKG9jdCk7DQo+ID4gIAlvY3RlcF9jb25maWd1
cmVfcmluZ19tYXBwaW5nX2NuOTNfcGYob2N0KTsNCj4gPiArDQo+ID4gKwlpZiAob2N0LT5jaGlw
X2lkID09IE9DVEVQX1BDSV9ERVZJQ0VfSURfQ045OF9QRikNCj4gPiArCQlyZXR1cm47DQo+ID4g
Kw0KPiA+ICsJLyogRmlybXdhcmUgc3RhdHVzIENTUiBpcyBzdXBwb3NlZCB0byBiZSBjbGVhcmVk
IGJ5DQo+ID4gKwkgKiBjb3JlIGRvbWFpbiByZXNldCwgYnV0IGR1ZSB0byBJUEJVUEVNLTM4ODQy
LCBpdCBpcyBub3QuDQo+ID4gKwkgKiBTZXQgaXQgdG8gUlVOTklORyBlYXJseSBpbiBib290LCBz
byB0aGF0IHVuZXhwZWN0ZWQgcmVzZXRzDQo+ID4gKwkgKiBsZWF2ZSBpdCBpbiBhIHN0YXRlIHRo
YXQgaXMgbm90IFJFQURZICgxKS4NCj4gPiArCSAqLw0KPiA+ICsJT0NURVBfUENJX1dJTl9XUklU
RShvY3QsIENOOUtfUEVNWF9QRlhfQ1NYX1BGQ0ZHWCgwLCAwLA0KPiBDTjlLX1BDSUVFUF9WU0VD
U1RfQ1RMKSwNCj4gPiArCQkJICAgIEZXX1NUQVRVU19SVU5OSU5HKTsNCj4gPiAgfQ0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbl9lcC9vY3RlcF9j
bnhrX3BmLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9uX2VwL29j
dGVwX2NueGtfcGYuYw0KPiA+IGluZGV4IDVkZTBiNWVjYmM1Zi4uZTA3MjY0YjNkYmY4IDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9uX2VwL29jdGVw
X2NueGtfcGYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9u
X2VwL29jdGVwX2NueGtfcGYuYw0KPiA+IEBAIC02NjAsNyArNjYwLDcgQEAgc3RhdGljIGludCBv
Y3RlcF9zb2Z0X3Jlc2V0X2NueGtfcGYoc3RydWN0DQo+IG9jdGVwX2RldmljZSAqb2N0KQ0KPiA+
ICAJICogdGhlIG1vZHVsZSBpcyByZW1vdmVkLg0KPiA+ICAJICovDQo+ID4gIAlPQ1RFUF9QQ0lf
V0lOX1dSSVRFKG9jdCwgQ05YS19QRU1YX1BGWF9DU1hfUEZDRkdYKDAsIDAsDQo+IENOWEtfUENJ
RUVQX1ZTRUNTVF9DVEwpLA0KPiA+IC0JCQkgICAgRldfU1RBVFVTX1JVTk5JTkcpOw0KPiA+ICsJ
CQkgICAgRldfU1RBVFVTX0RPV05JTkcpOw0KPiANCj4gTGlrZXdpc2UgaGVyZS4NCj4gDQo+ID4N
Cj4gPiAgCS8qIFNldCBjaGlwIGRvbWFpbiByZXNldCBiaXQgKi8NCj4gPiAgCU9DVEVQX1BDSV9X
SU5fV1JJVEUob2N0LCBDTlhLX1JTVF9DSElQX0RPTUFJTl9XMVMsIDEpOyBkaWZmDQo+IC0tZ2l0
DQo+ID4gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbl9lcC9vY3RlcF9yZWdz
X2NuOWtfcGYuaA0KPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb25fZXAv
b2N0ZXBfcmVnc19jbjlrX3BmLmgNCj4gPiBpbmRleCBjYTQ3MzUwMmQ3YTAuLmQ3ZmE1YWRiY2U5
OCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbl9l
cC9vY3RlcF9yZWdzX2NuOWtfcGYuaA0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21h
cnZlbGwvb2N0ZW9uX2VwL29jdGVwX3JlZ3NfY245a19wZi5oDQo+ID4gQEAgLTM4Myw2ICszODMs
MTcgQEANCj4gPiAgLyogYml0IDEgZm9yIGZpcm13YXJlIGhlYXJ0YmVhdCBpbnRlcnJ1cHQgKi8N
Cj4gPiAgI2RlZmluZSBDTjkzX1NEUF9FUEZfT0VJX1JJTlRfREFUQV9CSVRfSEJFQVQJQklUX1VM
TCgxKQ0KPiA+DQo+ID4gKyNkZWZpbmUgRldfU1RBVFVTX0RPV05JTkcgICAgICAwVUxMDQo+ID4g
KyNkZWZpbmUgRldfU1RBVFVTX1JVTk5JTkcgICAgICAyVUxMDQo+ID4gKyNkZWZpbmUgQ045S19Q
RU1YX1BGWF9DU1hfUEZDRkdYKHBlbSwgcGYsIG9mZnNldCkNCj4gKCgweDhlMDAwMDAwODAwMCB8
ICh1aW50NjRfdCkocGVtKSA8PCAzNiBcDQo+ID4gKwkJCQkJCQl8IChwZikgPDwgMTggXA0KPiA+
ICsJCQkJCQkJfCAoKChvZmZzZXQpID4+IDE2KSAmIDEpDQo+IDw8IDE2IFwNCj4gPiArCQkJCQkJ
CXwgKChvZmZzZXQpID4+IDMpIDw8IDMpIFwNCj4gPiArCQkJCQkJCSsgKCgoKG9mZnNldCkgPj4g
MikgJiAxKQ0KPiA8PCAyKSkNCj4gDQo+IEkgcmVhbGlzZSB0aGF0IHRoaXMgaW1wbGVtZW50YXRp
b24gbWlycm9ycyB0aGF0IGluIG9jdGVwX3JlZ3NfY254a19wZi5oLCBidXQgSQ0KPiBkbyB0aGlu
ayBpdCB3b3VsZCBiZSBiZXR0ZXIgcmV4cHJlc3NlZCBpbiB0ZXJtcyBvZiBGSUVMRF9QUkVQKCks
DQo+IEdFVE1BU0tfVUxMLCBhbmQgQklUX1VMTC4gV2l0aCAjZGVmaW5lcyBzbyB0aGUgbWFza3Mg
KGFuZCBiaXRzIGFyZQ0KPiBuYW1lZCkuDQo+IA0KPiBBbHNvLCBhcyB0aGUgYWJvdmUgZHVwbGlj
YXRlcyB3aGF0IGlzIHByZXNlbnQgaW4gb2N0ZXBfcmVnc19jbnhrX3BmLmgsIG1heWJlDQo+IGl0
IHdvdWxkIGJlIG5pY2UgdG8gc2hhcmUgaXQgc29tZWhvdy4NCj4gDQoNCldlIGNhbid0IGhhdmUg
YSBjb21tb24gZGVmaW5pdGlvbiBmb3IgZGlmZmVyZW50IFNvQ3MgYXMgY29uZmlndXJhdGlvbnMg
bWF5IHZhcnkgZnJvbSBvbmUgU29DIHRvIGFub3RoZXIuDQpJIGNhbiBzZW5kIG91dCBhbm90aGVy
IHZlcnNpb24gdXNpbmcgYml0cyBoYW5kbGluZyBtYWNyb3Mgc3VnZ2VzdGVkIGJ5IHlvdS4NCg0K
PiA+ICsNCj4gPiArLyogUmVnaXN0ZXIgZGVmaW5lcyBmb3IgdXNlIHdpdGggQ045S19QRU1YX1BG
WF9DU1hfUEZDRkdYICovICNkZWZpbmUNCj4gPiArQ045S19QQ0lFRVBfVlNFQ1NUX0NUTCAgMHg0
RDANCj4gPiArDQo+ID4gICNkZWZpbmUgQ045M19QRU1fQkFSNF9JTkRFWCAgICAgICAgICAgIDcN
Cj4gPiAgI2RlZmluZSBDTjkzX1BFTV9CQVI0X0lOREVYX1NJWkUgICAgICAgMHg0MDAwMDBVTEwN
Cj4gPiAgI2RlZmluZSBDTjkzX1BFTV9CQVI0X0lOREVYX09GRlNFVCAgICAgKENOOTNfUEVNX0JB
UjRfSU5ERVggKg0KPiBDTjkzX1BFTV9CQVI0X0lOREVYX1NJWkUpDQo+ID4gZGlmZiAtLWdpdA0K
PiA+IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb25fZXAvb2N0ZXBfcmVnc19j
bnhrX3BmLmgNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9uX2VwL29j
dGVwX3JlZ3NfY254a19wZi5oDQo+ID4gaW5kZXggZTYzN2Q3YzgyMjRkLi5hNmI2YzlmMzU2ZGUg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb25fZXAv
b2N0ZXBfcmVnc19jbnhrX3BmLmgNCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2
ZWxsL29jdGVvbl9lcC9vY3RlcF9yZWdzX2NueGtfcGYuaA0KPiA+IEBAIC0zOTYsNiArMzk2LDcg
QEANCj4gPiAgI2RlZmluZSBDTlhLX1NEUF9FUEZfT0VJX1JJTlRfREFUQV9CSVRfTUJPWAlCSVRf
VUxMKDApDQo+ID4gIC8qIGJpdCAxIGZvciBmaXJtd2FyZSBoZWFydGJlYXQgaW50ZXJydXB0ICov
DQo+ID4gICNkZWZpbmUgQ05YS19TRFBfRVBGX09FSV9SSU5UX0RBVEFfQklUX0hCRUFUCUJJVF9V
TEwoMSkNCj4gPiArI2RlZmluZSBGV19TVEFUVVNfRE9XTklORyAgICAgIDBVTEwNCj4gPiAgI2Rl
ZmluZSBGV19TVEFUVVNfUlVOTklORyAgICAgIDJVTEwNCj4gPiAgI2RlZmluZSBDTlhLX1BFTVhf
UEZYX0NTWF9QRkNGR1gocGVtLCBwZiwgb2Zmc2V0KSAgICAgICh7IHR5cGVvZihvZmZzZXQpDQo+
IF9vZmYgPSAob2Zmc2V0KTsgXA0KPiA+ICAJCQkJCQkJICAoKDB4OGUwMDAwMDA4MDAwIHwNCj4g
XA0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCj4gPg0K

