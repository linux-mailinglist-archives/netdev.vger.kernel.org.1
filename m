Return-Path: <netdev+bounces-261035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKlvAYwyn2lXZQQAu9opvQ
	(envelope-from <netdev+bounces-261035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:34:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5788C19B9B8
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD1D9303B4E1
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C612D7DDC;
	Wed, 25 Feb 2026 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="HRkJVDro"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BB02701B8
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772040781; cv=fail; b=DSGCWs/yi14vCPB+CpQgYFSs39DO8hqVr3i4hUVp/Jndmk7p/3Yu3QMQVWHsFzyBQ3t6L8JHzKX/aFYgUB7LXD3/hxeuQayelhQuUXzgG+jXgQ0q5gBBtY0M/ln040uMWjVonjw/jhbUruPlhTyJ6lLuVlLrWdGYLKaiZQ34uzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772040781; c=relaxed/simple;
	bh=yXzZln//zSKln6CJ1yDEpCdh0Gpi8pdp+deduY1LufM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eRFMRUFE9XfxOfLIkN12Uywc9D8Fe+k8HnvJDsZyOSpTylMhr8YxXUywJSYrk06YpcqCReq/PvPbQ5rMbahTgkBRjmY632Bk7OXi1xZX8f0snaobDcZaN0gudX9gsfewfEr17J6J+QPVF0x2Tr0LTlrDSKzUntni3aOQrM1b8Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=HRkJVDro; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PGTtdI1364308;
	Wed, 25 Feb 2026 09:32:36 -0800
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020101.outbound.protection.outlook.com [52.101.61.101])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4chqcyt3bw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 09:32:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwDJZzUIAgAdDmQ3e7bCsgC64No7eJzuXnK8Nf+wp0bolWZw5WE1EJ++MVLerOsE9IohSlJ2j6U3V4N4NFmxC3Grt2QNbGGbCW1bjDHtiLYyQnJxjXmQwGH+F6ZptSuLbawMZly9C8jHll0jjMC7B6yObg06m5+QderYG+ixa1sMEjBz/IMpNjIq/X64auVEAaA9YYsHzxg3HWo5eH06Arb9Q98zi3pRnOYQa/fnWCzZoFNFGFwLVFbpuAxvDGr126PxlVUDRnfBBJpoKQvlGu2QmYsSvr2NKx2hikxk20yEgP8TyaK1+YQAhPtrJxh6b6P/SGsJcfULzP3gbHJqQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXzZln//zSKln6CJ1yDEpCdh0Gpi8pdp+deduY1LufM=;
 b=LoRbcFoUfG5fw8M0ksjVA6S/rGjnaG6t52KSFnEPK/nHgAD8/u6IEQxo1SJH7h5fZB32Ne/rxNhk2nv1OBOjznVF9tWy4S9REdpXZ5ROYnK3DH0jMM7K86AyEZLfc8YwO6pCLmwBtUTRetBo1RCY2avW+M+3UqdrCFtPFfCoA9BDh8JfDCHNs4IPinmheo1puKZqpcae0GQ+XmVmAoaIO2YfDjy7bNL2s5s/OhahfSykDcuR3gqTr7rN7hDqA3MKIlxTa1axxjKA9f5X1sUomHy85ENIS+/SUHqE1vT+XkgpbQhivgvx1e6ymI7Z/A7/mwSmT1b+luB0UFrkzqSYSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXzZln//zSKln6CJ1yDEpCdh0Gpi8pdp+deduY1LufM=;
 b=HRkJVDroH/x7xOlirtvpJ4TKsV/VMkI9AYoRBXsoZu8c3Q78y7pppJRHDewrNHV6rCBwBrmpusMeCgPoYOYCuDHt2R53Bi89N55mvK1N+UGevUYjr+OUF7S6b7RvTKpDp3pbRc2Y51DrrWNqO8sOGQSdU368ClX1XHyZ/Th10BI=
Received: from BYAPR18MB3735.namprd18.prod.outlook.com (2603:10b6:a02:ca::16)
 by SJ0PR18MB3979.namprd18.prod.outlook.com (2603:10b6:a03:2e6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 17:32:33 +0000
Received: from BYAPR18MB3735.namprd18.prod.outlook.com
 ([fe80::448e:bd83:47c:f8b3]) by BYAPR18MB3735.namprd18.prod.outlook.com
 ([fe80::448e:bd83:47c:f8b3%5]) with mapi id 15.20.9654.007; Wed, 25 Feb 2026
 17:32:33 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Nicolai Buchwitz <nb@tipi-net.de>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "nicolas.ferre@microchip.com"
	<nicolas.ferre@microchip.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "phil@raspberrypi.com"
	<phil@raspberrypi.com>
Subject: RE: [PATCH 3/5] net: cadence: macb: implement EEE TX LPI support
Thread-Topic: [PATCH 3/5] net: cadence: macb: implement EEE TX LPI support
Thread-Index: AQHcpny5dmmdaw7jGEqKEDuUvDK7Dg==
Date: Wed, 25 Feb 2026 17:32:32 +0000
Message-ID:
 <BYAPR18MB373524BEA045174E7E453250A075A@BYAPR18MB3735.namprd18.prod.outlook.com>
References: <20260225091558.51157-1-nb@tipi-net.de>
 <20260225091558.51157-4-nb@tipi-net.de>
In-Reply-To: <20260225091558.51157-4-nb@tipi-net.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR18MB3735:EE_|SJ0PR18MB3979:EE_
x-ms-office365-filtering-correlation-id: f566e048-935f-4685-6a3f-08de7493dbd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 QFzoEl01sRSCEN7v1t1N37cW+jRmTTsGPGsYn+U8pXoJeYGkiQ5YSXWNOS28oqU+twxDo/0uozNv4NNZl9wNoWGXf00Ds7Zuznw60eLftm439pLSxiylg7uRJ9bflo6Q+EzHCiwf7t9RSw/dN9Mj9AAYowoOzH6P2T4qp/80GCnhC1BpMxsek690rIzXZ2GFCzshLnThp9k+AIhBskreMlZRNgkW/LGLOzb77wRgfMebDRYXJewM5L/Nht6KkChnk91QUDhccdTZEK36ZjihCX4EQBSZnxWqK7RBNEWUwkAWrLzeuJN7YS/31wod3kXEt8uv3yz9jdbf8mH0F/JX7bqUuCKVXJ2BePZ2LdqYFatDcK9V6W2dth4/YMyLaIXztG/WV6QOXTrpN6RykP1frd0ujvvMmmM3mL1zg5OraPw1E6+nTEmPabD2npjYgwoum5Kxz4UluHMy2A3VaFD5kggg8fF2EswNK9wo99orY1atXndT1YDSJWAuTY0lO+dTCQbewuzCoSZVlxgurx9qXQE7obV7rhldhoi0tlFsSK6szb55pDlFWmL2ChqCBSD7GOXZZVnBRZqQJBMwqCdiuNc3PJ0zyjiWiTWlvFUoZvoL0x3UyINlaFzN+peXQPbh/GIdTa9g4rMrjFQc6ZW2eh7u4Jtpp7rXBBQeVDfO9P2F6yL9CsyADXseVi23AX6QC8z49BVBZ1vYY9PvfXyAzVRorw37rEs1w4DODGjt3o+yUZnmyx/OIghnRbcSaSjsV/pmDj/LRzRshyzxWnxO7B5sfucEQr/y3GzoDB6bboQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB3735.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dDlvcjE1TmdJSG00N2s4Yk9HUUM5NHQ5TTdwV0ZrNDZmeVhKMFI1NkRyMk4x?=
 =?utf-8?B?cHZDbFZIdkIxOU9DeVhQY20zdnNPamE3TWVNR1hMcUQyQ0ZvQ3lVeWd2d0Nw?=
 =?utf-8?B?TXkxb003clNLNlo0T2tVamhVZW9zalloMjJ6enJDOSsrSEcwNmNHd1l6T1lJ?=
 =?utf-8?B?d0hiQytqVU1NejFYNmViWlkrN1lWazhIYStDZTk3RER1UXhPbks0dDNVeFNT?=
 =?utf-8?B?dkg2d3RxdXhhQXFqWUpjQ0ZKSUFIQUtxekhzb0l3OVVTdzZOK3IreEtLSjJV?=
 =?utf-8?B?OUpDa3VBbmFOT2RPa01nK2RrMWZMaHE1dmUvVUNSOUZuWExlVVZWam1DNGVm?=
 =?utf-8?B?bFhJN0l5VGV2WllzbWlzMFI0L2lwNlMvTE0rRTBKRUdQakl1NitMQ0NlZUV5?=
 =?utf-8?B?WWIxUFRLcEl5TnVOS0UvWG1EdFlHNmRYMmR0R0d2NkhWN0RGckhFakQxTllV?=
 =?utf-8?B?aVhYVUhWYlZEM2hyazNKOFJod3ZTZndSRFRiVjhBSndGYVpqTU82MURoSXpU?=
 =?utf-8?B?VkRZZ01tK3RFQzVsdGZsdFlaM2RMWUVhZ1cza3ZUeGtPM0U4Y3Q5cVRKWTZa?=
 =?utf-8?B?U2lWaUIyV1dqaHVadUxWUFhscENVVHNJZXo1OGtOZ1YvUkNQRVA5QmUydXNk?=
 =?utf-8?B?UUs0RHMraHNXZWRaaTVNdkNPanJ0Ri9oODVMMzE4d0VFakEvZVUzdktaTlNq?=
 =?utf-8?B?eEJDODBGekFsL3IrNVBNaCtmdmpJZ2FvM1psY3BsTk1xQ25jbytYZHI4OWp6?=
 =?utf-8?B?YXhMcklLa3JJK0VBV2dMaENSVzA3OVBSeUJrWlh2OElDTXlXTit3aXlJTTAv?=
 =?utf-8?B?RDQrS25xVmNMaGtCeWYzVGU2cFV5N1lLUFY4c1U1ci9RUlV5Rmw3NksxVWxZ?=
 =?utf-8?B?RUlTV3VmZUhZZlVzUHRYQkV4VWpkM3NWeXlYWWNhQVRjT25MajhoSnNReVBG?=
 =?utf-8?B?TnRac3lrVlF6Z1E1UkRZS3RXNmpSeXNxMXhaQnhReVJMUHNJNUVOdi82aFdC?=
 =?utf-8?B?T0NZbG5QMjEwVVdLcDA5K3ZWd0R5SkRDQk1UR0RPWTFVUkowNFBSc1hacTQz?=
 =?utf-8?B?Q3BIakkyUWN1OFYzajdLcVlCRnhkZnc4SDhZTVN4dyt4c3JnbEJHMkphaWsx?=
 =?utf-8?B?U0hxYjRtNXJGMGtnYmE0MndFREhpcytSdDYzaDZLVURDb01kdEdld1RVTDFr?=
 =?utf-8?B?a3BPK0dkNTRjdVhHN3dtOWtwMElSNE9pMnFkZldqQjRhWlVjSTFMalJPUXZp?=
 =?utf-8?B?eGRENlF4a2ovK3BoNDRBQVR5MW90VEROMEhtV1NNN3NvTXBmYWtSMW40MnFu?=
 =?utf-8?B?Q3F1dEM0SjVxanVxTWhERHpidHJLejlXaThRWW8zdHArVFlQaWQ5bE95ZElU?=
 =?utf-8?B?RjF6Z3VsTnVRNnJFZ0pBQVNGaHdSZmpXc3YzTDFJSXZ3MFgyVDlyanI5T2U5?=
 =?utf-8?B?MlRxZytybFlzb2hlNWVmZ2E1OXBXMWgzb3k3MFhhbkloNVFaZURXaWx1ZUVC?=
 =?utf-8?B?SDJHZWloTlA1NzBEOWI0dURxTUNZa2ZxZVowbmp6K3laV2xSWGVKVDU5c253?=
 =?utf-8?B?UVFVaUg0RUdqNGY3NVhYU242cjRydzNxTldoYk0xZTBEczF4MGlIZTNhMDkz?=
 =?utf-8?B?ekkrK2Y2SWZZaHFHUFVpbCsxR2JxSmpuTGQ3QkZPTG5WNDh5Y0dFcnJ3b29M?=
 =?utf-8?B?K0JnSHVZN25rSkxvV1RFcWRTVW1EYWJyaFJFUG9zZHlodG1ibnBVSUdnZklN?=
 =?utf-8?B?dFIxOXRIYW1zbE9MMEg3VTRtalZ4YTZjalJRd3JNQ2h5NE1GYjV5U1MyK2ZB?=
 =?utf-8?B?TUZKT1F3c01XRDRJOFBGMmJrd0d3RDR6dkMrNkZ2QlpBalR0UGdFY0pIVzBE?=
 =?utf-8?B?THlVTUxydmRLbm5iRlpoNFNiQVZvakNNS3lGc0JhQitPS0ZLU1dKWGlZdlFs?=
 =?utf-8?B?ZWRFaGFNSlhCeVE0R3Z0YUgwbzh5SVQ3N2FnVG1zMjRXTnYrbVQxelVyNER2?=
 =?utf-8?B?L3Y2alZhV1FmUSt3TWxaNFA5bEFsOVB1dXo3dEVmR1RXbHkyVVJXZThHdEc1?=
 =?utf-8?B?QWVUbTArT1pSejl0UG5GdHJkUGNYQVdidnFwbkZvbktxUHdFdml4ZlVlUis0?=
 =?utf-8?B?WHdZZHZ4YjhDMUd2THAzWmV3NXpVQnd3Q2hILzE3REpZY0ZBeEJVWkVqUElZ?=
 =?utf-8?B?bVRHTEVvUXJhRFFxSll4djUvaTNxM0hSNkFOOWJnV3RzVFVTUTdjWWJtKzJL?=
 =?utf-8?B?cCsxTG5KVUNmbXdyUEZXRk9sdjgwcDBFcnZHVzhPRWRwOTlOOGRLbUY3cVhZ?=
 =?utf-8?B?TnZsa0pCSERWK0hKNDY1RDhGV1UxYlplZXF2WTFEcitEM01JQnpHQT09?=
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
X-MS-Exchange-CrossTenant-AuthSource: BYAPR18MB3735.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f566e048-935f-4685-6a3f-08de7493dbd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 17:32:32.9938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zaXOJZ1K3xkaiS5GpNgfj1S/369jAxhcwzkf5657MIFuMquXYkCKJtC2m32gmKAhjZF9uHoCpJi/vBdUTTYxDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3979
X-Proofpoint-GUID: sxyGdhyZdbU-UGEsChNDr3XL2tXTfPkv
X-Proofpoint-ORIG-GUID: sxyGdhyZdbU-UGEsChNDr3XL2tXTfPkv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE2OCBTYWx0ZWRfX7lQlLmi5ARxS
 33Rs84OghkD8iW1oqpbZZ2O6/67j3uAvns0xCRle30gjFNMz82+tZuiEB6fkcVP0b+879TiCVvI
 zxd3yeRPR9hvACGg+HX2uyZ9ommMzshCj/KOIsTh+5Q1FTgpYt0kYevnxyP5L1fGGxIiGCWM4nL
 aLF86yN/ACRB/m9c+HBSwJiSSe8y6UaaR7elHrgvurzEGQs9MRQFwkUBZxjp7SOS8WMF3/+DiBN
 f69ZKAqSBzcyJgSIqWjBOSNuK+ZyhIMCj7eU79rdey9tZaqxmgGfaNDVjQPLDhIqUgg7smx8kC9
 gLv/kEYknpgJAf2XQYESMOX7d4d1qGe3BvRmtbxY0OxDR1/sXAemNzMS/N8pfLfi1NO8sqJP6p8
 RD0GHYNa9dFhpkoPVFi3u6G+840xV9h9ftUCUjMc3gfma5CXbkv8+BHd722LUDC5VQPxvDex+oL
 767sAqevbQJa3EW/AjA==
X-Authority-Analysis: v=2.4 cv=B/S0EetM c=1 sm=1 tr=0 ts=699f3233 cx=c_pps
 a=ONVPZRIUl3/knk75a7oMmQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8
 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=XYAwZIGsAAAA:8 a=20KFwNOVAAAA:8
 a=PHq6YzTAAAAA:8 a=RF00TdSWAAAA:8 a=VJjAw92wvDo0d0djJAcA:9 a=QEXdDO2ut3YA:10
 a=y1Q9-5lHfBjTkpIzbSAN:22 a=E8ToXWR_bxluHZ7gmE-Z:22 a=ZKzU8r6zoKMcqsNulkmm:22
 a=_nx8FpPT0le-2JWwMI5O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_02,2026-02-25_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261035-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[saikrishnag@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5788C19B9B8
X-Rspamd-Action: no action

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE5pY29sYWkgQnVjaHdpdHog
PG5iQHRpcGktbmV0LmRlPg0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDI1LCAyMDI2IDI6
NDYgUE0NCj4gVG86IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGFuZHJldytuZXRkZXZA
bHVubi5jaDsgY2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Ow0KPiBkYXZlbUBkYXZlbWxvZnQubmV0
OyBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IG5pY29sYXMuZmVycmVA
bWljcm9jaGlwLmNvbTsgcGFiZW5pQHJlZGhhdC5jb207IGxpbnV4QGFybWxpbnV4Lm9yZy51azsN
Cj4gcGhpbEByYXNwYmVycnlwaS5jb207IE5pY29sYWkgQnVjaHdpdHogPG5iQHRpcGktbmV0LmRl
Pg0KPiBTdWJqZWN0OiBbUEFUQ0ggMy81XSBuZXQ6IGNhZGVuY2U6IG1hY2I6IGltcGxlbWVudCBF
RUUgVFggTFBJDQo+IHN1cHBvcnQNCj4gDQo+IEltcGxlbWVudCBFbmVyZ3kgRWZmaWNpZW50IEV0
aGVybmV0IFRYIExvdyBQb3dlciBJZGxlIHVzaW5nIHBoeWxpbmsncw0KPiBtYW5hZ2VkIEVFRSBm
cmFtZXdvcmsuIFRoZSBDYWRlbmNlIEdFTSBNQUMgaGFzIG5vIGJ1aWx0LWluIGlkbGUgdGltZXIN
Cj4g4oCUIFRYTFBJRU4gKE5DUiBiaXQgMTkpIGltbWVkaWF0ZWx5IGJsb2NrcyBhbGwgVFggd2hl
biBzZXQgYW5kIHRoZSBNQUMgZG9lcw0KPiBOT1QgYXV0by13YWtlIOKAlCBzbyB0aGUgZHJpdmVy
IA0KPiBJbXBsZW1lbnQgRW5lcmd5IEVmZmljaWVudCBFdGhlcm5ldCBUWCBMb3cgUG93ZXIgSWRs
ZSB1c2luZyBwaHlsaW5rJ3MNCj4gbWFuYWdlZCBFRUUgZnJhbWV3b3JrLiBUaGUgQ2FkZW5jZSBH
RU0gTUFDIGhhcyBubyBidWlsdC1pbiBpZGxlIHRpbWVyDQo+IOKAlCBUWExQSUVOIChOQ1IgYml0
IDE5KSBpbW1lZGlhdGVseSBibG9ja3MgYWxsIFRYIHdoZW4gc2V0IGFuZCB0aGUgTUFDIGRvZXMN
Cj4gTk9UIGF1dG8td2FrZSDigJQgc28gdGhlIGRyaXZlciB1c2VzIGEgc29mdHdhcmUgZGVsYXll
ZF93b3JrIHRpbWVyIGZvciBpZGxlDQo+IGRldGVjdGlvbi4NCj4gDQo+IFRoZSBUWCBMUEkgbGlm
ZWN5Y2xlOg0KPiAgIC0gcGh5bGluayBjYWxscyBtYWNfZW5hYmxlX3R4X2xwaSgpIGFmdGVyIGxp
bmstdXAgd2l0aCB0aGUgbmVnb3RpYXRlZA0KPiAgICAgdGltZXIgdmFsdWUuIFRoZSBkcml2ZXIg
ZGVmZXJzIHRoZSBmaXJzdCBMUEkgZW50cnkgYnkgMSBzZWNvbmQgcGVyDQo+ICAgICBJRUVFIDgw
Mi4zYXogc2VjdGlvbiAyMi43YS4NCj4gICAtIG1hY2JfdHhfY29tcGxldGUoKSByZXNjaGVkdWxl
cyB0aGUgaWRsZSB0aW1lciBhZnRlciBlYWNoIFRYIGRyYWluLg0KPiAgIC0gbWFjYl9zdGFydF94
bWl0KCkgd2FrZXMgZnJvbSBMUEkgYnkgY2xlYXJpbmcgVFhMUElFTiwgY2FuY2VsbGluZw0KPiAg
ICAgdGhlIHBlbmRpbmcgd29yaywgYW5kIHdhaXRpbmcgNTB1cyAoY29uc2VydmF0aXZlIFR3X3N5
cykgYmVmb3JlDQo+ICAgICBpbml0aWF0aW5nIHRoZSB0cmFuc21pdC4NCj4gICAtIHBoeWxpbmsg
Y2FsbHMgbWFjX2Rpc2FibGVfdHhfbHBpKCkgYmVmb3JlIGxpbmstZG93biwgd2hpY2ggY2FuY2Vs
cw0KPiAgICAgdGhlIHdvcmsgYW5kIGNsZWFycyBUWExQSUVOLg0KPiANCj4gVGhlIHBoeWxpbmtf
Y29uZmlnIGlzIHBvcHVsYXRlZCB3aXRoIExQSSBjYXBhYmlsaXRpZXMgKE1JSSwgR01JSSwgUkdN
SUkNCj4gbW9kZXM7IDEwMEZEIGFuZCAxMDAwRkQgc3BlZWRzKSBhbmQgYSAyNTBtcyBkZWZhdWx0
IGlkbGUgdGltZXIsIGdhdGVkIG9uDQo+IE1BQ0JfQ0FQU19FRUUuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBOaWNvbGFpIEJ1Y2h3aXR6IDxuYkB0aXBpLW5ldC5kZT4NCj4gLS0tDQo+ICBkcml2ZXJz
L25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2IuaCAgICAgIHwgICA1ICsNCj4gIGRyaXZlcnMvbmV0
L2V0aGVybmV0L2NhZGVuY2UvbWFjYl9tYWluLmMgfCAxMTENCj4gKysrKysrKysrKysrKysrKysr
KysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTE2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2IuaA0KPiBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2NhZGVuY2UvbWFjYi5oDQo+IGluZGV4IGUzNTIwZTVhZWM2Ny4uYzY5ODI4
YjI3ZGFlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2Iu
aA0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2IuaA0KPiBAQCAtMTM3
Miw2ICsxMzcyLDExIEBAIHN0cnVjdCBtYWNiIHsNCj4gDQo+ICAJc3RydWN0IHdvcmtfc3RydWN0
CWhyZXNwX2Vycl9iaF93b3JrOw0KPiANCj4gKwkvKiBFRUUgLyBMUEkgc3RhdGUgKi8NCj4gKwli
b29sCQkJZWVlX2FjdGl2ZTsNCj4gKwlzdHJ1Y3QgZGVsYXllZF93b3JrCXR4X2xwaV93b3JrOw0K
PiArCXUzMgkJCXR4X2xwaV90aW1lcjsNCj4gKw0KPiAgCWludAlyeF9iZF9yZF9wcmVmZXRjaDsN
Cj4gIAlpbnQJdHhfYmRfcmRfcHJlZmV0Y2g7DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvY2FkZW5jZS9tYWNiX21haW4uYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2NhZGVuY2UvbWFjYl9tYWluLmMNCj4gaW5kZXggNDNjZDAxM2JiNzBlLi5hOWFlN2VjZjlmZTkg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2NhZGVuY2UvbWFjYl9tYWluLmMN
Cj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvY2FkZW5jZS9tYWNiX21haW4uYw0KPiBAQCAt
MTAsNiArMTAsNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2Nsay1wcm92aWRlci5oPg0KPiAgI2lu
Y2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2NyYzMyLmg+DQo+ICsjaW5j
bHVkZSA8bGludXgvZGVsYXkuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9kbWEtbWFwcGluZy5oPg0K
PiAgI2luY2x1ZGUgPGxpbnV4L2V0aGVyZGV2aWNlLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvZmly
bXdhcmUveGxueC16eW5xbXAuaD4gQEAgLTU4OSw2ICs1OTAsOTMgQEAgc3RhdGljDQo+IGNvbnN0
IHN0cnVjdCBwaHlsaW5rX3Bjc19vcHMgbWFjYl9waHlsaW5rX3Bjc19vcHMgPSB7DQo+ICAJLnBj
c19jb25maWcgPSBtYWNiX3Bjc19jb25maWcsDQo+ICB9Ow0KPiANCj4gK3N0YXRpYyBib29sIG1h
Y2JfdHhfbHBpX3NldChzdHJ1Y3QgbWFjYiAqYnAsIGJvb2wgZW5hYmxlKSB7DQo+ICsJdW5zaWdu
ZWQgbG9uZyBmbGFnczsNCj4gKwl1MzIgb2xkLCBuY3I7DQo+ICsNCj4gKwlzcGluX2xvY2tfaXJx
c2F2ZSgmYnAtPmxvY2ssIGZsYWdzKTsNCj4gKwlvbGQgPSBuY3IgPSBtYWNiX3JlYWRsKGJwLCBO
Q1IpOw0KPiArCWlmIChlbmFibGUpDQo+ICsJCW5jciB8PSBHRU1fQklUKFRYTFBJRU4pOw0KPiAr
CWVsc2UNCj4gKwkJbmNyICY9IH5HRU1fQklUKFRYTFBJRU4pOw0KPiArCWlmIChvbGQgIT0gbmNy
KQ0KPiArCQltYWNiX3dyaXRlbChicCwgTkNSLCBuY3IpOw0KPiArCXNwaW5fdW5sb2NrX2lycXJl
c3RvcmUoJmJwLT5sb2NrLCBmbGFncyk7DQo+ICsNCj4gKwlyZXR1cm4gb2xkICE9IG5jcjsNCj4g
K30NCj4gKw0KPiArc3RhdGljIGJvb2wgbWFjYl90eF9hbGxfcXVldWVzX2lkbGUoc3RydWN0IG1h
Y2IgKmJwKSB7DQo+ICsJdW5zaWduZWQgaW50IHE7DQo+ICsNCj4gKwlmb3IgKHEgPSAwOyBxIDwg
YnAtPm51bV9xdWV1ZXM7IHErKykgew0KPiArCQlzdHJ1Y3QgbWFjYl9xdWV1ZSAqcXVldWUgPSAm
YnAtPnF1ZXVlc1txXTsNCj4gKw0KPiArCQlpZiAocXVldWUtPnR4X2hlYWQgIT0gcXVldWUtPnR4
X3RhaWwpDQo+ICsJCQlyZXR1cm4gZmFsc2U7DQo+ICsJfQ0KPiArCXJldHVybiB0cnVlOw0KPiAr
fQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBtYWNiX3R4X2xwaV93b3JrX2ZuKHN0cnVjdCB3b3JrX3N0
cnVjdCAqd29yaykgew0KPiArCXN0cnVjdCBtYWNiICpicCA9IGNvbnRhaW5lcl9vZih3b3JrLCBz
dHJ1Y3QgbWFjYiwgdHhfbHBpX3dvcmsud29yayk7DQo+ICsNCj4gKwlpZiAoYnAtPmVlZV9hY3Rp
dmUgJiYgbWFjYl90eF9hbGxfcXVldWVzX2lkbGUoYnApKQ0KPiArCQltYWNiX3R4X2xwaV9zZXQo
YnAsIHRydWUpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBtYWNiX3R4X2xwaV9zY2hlZHVs
ZShzdHJ1Y3QgbWFjYiAqYnApIHsNCj4gKwlpZiAoYnAtPmVlZV9hY3RpdmUpDQo+ICsJCW1vZF9k
ZWxheWVkX3dvcmsoc3lzdGVtX3dxLCAmYnAtPnR4X2xwaV93b3JrLA0KPiArCQkJCSB1c2Vjc190
b19qaWZmaWVzKGJwLT50eF9scGlfdGltZXIpKTsNCj4gK30NCj4gKw0KPiArLyogV2FrZSBmcm9t
IExQSSBiZWZvcmUgdHJhbnNtaXR0aW5nLiBUaGUgTUFDIG11c3QgZGVhc3NlcnQgVFhMUElFTg0K
PiArICogYW5kIHdhaXQgZm9yIHRoZSBQSFkgdG8gZXhpdCBMUEkgYmVmb3JlIGFueSBmcmFtZSBj
YW4gYmUgc2VudC4NCj4gKyAqIElFRUUgODAyLjNheiBUd19zeXMgaXMgfjE3dXMgZm9yIDEwMDBC
QVNFLVQsIH4zMHVzIGZvciAxMDBCQVNFLVRYOw0KPiArICogd2UgdXNlIGEgY29uc2VydmF0aXZl
IDUwdXMuDQo+ICsgKi8NCj4gK3N0YXRpYyB2b2lkIG1hY2JfdHhfbHBpX3dha2Uoc3RydWN0IG1h
Y2IgKmJwKSB7DQo+ICsJaWYgKCFtYWNiX3R4X2xwaV9zZXQoYnAsIGZhbHNlKSkNCj4gKwkJcmV0
dXJuOw0KPiArDQo+ICsJY2FuY2VsX2RlbGF5ZWRfd29yaygmYnAtPnR4X2xwaV93b3JrKTsNCj4g
Kwl1ZGVsYXkoNTApOw0KQW55IHJlYXNvbiB0aGUgNTDCtXMgYnVzeS13YWl0IGluIHhtaXQgcGF0
aD8gQ2FuIGl0IGJlIGF2b2lkZWQ/DQoNCj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQgbWFjYl9t
YWNfZGlzYWJsZV90eF9scGkoc3RydWN0IHBoeWxpbmtfY29uZmlnICpjb25maWcpIHsNCj4gKwlz
dHJ1Y3QgbmV0X2RldmljZSAqbmRldiA9IHRvX25ldF9kZXYoY29uZmlnLT5kZXYpOw0KPiArCXN0
cnVjdCBtYWNiICpicCA9IG5ldGRldl9wcml2KG5kZXYpOw0KPiArDQo+ICsJYnAtPmVlZV9hY3Rp
dmUgPSBmYWxzZTsNCj4gKwljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmJwLT50eF9scGlfd29y
ayk7DQo+ICsJbWFjYl90eF9scGlfc2V0KGJwLCBmYWxzZSk7DQo+ICt9DQo+ICsNCj4gK3N0YXRp
YyBpbnQgbWFjYl9tYWNfZW5hYmxlX3R4X2xwaShzdHJ1Y3QgcGh5bGlua19jb25maWcgKmNvbmZp
ZywgdTMyIHRpbWVyLA0KPiArCQkJCSAgYm9vbCB0eF9jbGtfc3RvcCkNCj4gK3sNCj4gKwlzdHJ1
Y3QgbmV0X2RldmljZSAqbmRldiA9IHRvX25ldF9kZXYoY29uZmlnLT5kZXYpOw0KPiArCXN0cnVj
dCBtYWNiICpicCA9IG5ldGRldl9wcml2KG5kZXYpOw0KPiArDQo+ICsJYnAtPnR4X2xwaV90aW1l
ciA9IHRpbWVyOw0KPiArCWJwLT5lZWVfYWN0aXZlID0gdHJ1ZTsNCj4gKw0KPiArCS8qIERlZmVy
IGluaXRpYWwgTFBJIGVudHJ5IGJ5IDEgc2Vjb25kIGFmdGVyIGxpbmstdXAgcGVyDQo+ICsJICog
SUVFRSA4MDIuM2F6IHNlY3Rpb24gMjIuN2EuDQo+ICsJICovDQo+ICsJbW9kX2RlbGF5ZWRfd29y
ayhzeXN0ZW1fd3EsICZicC0+dHhfbHBpX3dvcmssDQo+IG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkp
Ow0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyB2b2lkIG1hY2JfbWFj
X2NvbmZpZyhzdHJ1Y3QgcGh5bGlua19jb25maWcgKmNvbmZpZywgdW5zaWduZWQgaW50DQo+IG1v
ZGUsDQo+ICAJCQkgICAgY29uc3Qgc3RydWN0IHBoeWxpbmtfbGlua19zdGF0ZSAqc3RhdGUpICB7
IEBAIC03NTMsNg0KPiArODQxLDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwaHlsaW5rX21hY19v
cHMgbWFjYl9waHlsaW5rX29wcyA9IHsNCj4gIAkubWFjX2NvbmZpZyA9IG1hY2JfbWFjX2NvbmZp
ZywNCj4gIAkubWFjX2xpbmtfZG93biA9IG1hY2JfbWFjX2xpbmtfZG93biwNCj4gIAkubWFjX2xp
bmtfdXAgPSBtYWNiX21hY19saW5rX3VwLA0KPiArCS5tYWNfZGlzYWJsZV90eF9scGkgPSBtYWNi
X21hY19kaXNhYmxlX3R4X2xwaSwNCj4gKwkubWFjX2VuYWJsZV90eF9scGkgPSBtYWNiX21hY19l
bmFibGVfdHhfbHBpLA0KPiAgfTsNCj4gDQo+ICBzdGF0aWMgYm9vbCBtYWNiX3BoeV9oYW5kbGVf
ZXhpc3RzKHN0cnVjdCBkZXZpY2Vfbm9kZSAqZG4pIEBAIC04NDgsNg0KPiArOTM4LDE4IEBAIHN0
YXRpYyBpbnQgbWFjYl9taWlfcHJvYmUoc3RydWN0IG5ldF9kZXZpY2UgKmRldikNCj4gIAkJfQ0K
PiAgCX0NCj4gDQo+ICsJLyogQ29uZmlndXJlIEVFRSBMUEkgaWYgc3VwcG9ydGVkICovDQo+ICsJ
aWYgKGJwLT5jYXBzICYgTUFDQl9DQVBTX0VFRSkgew0KPiArCQlfX3NldF9iaXQoUEhZX0lOVEVS
RkFDRV9NT0RFX01JSSwNCj4gKwkJCSAgYnAtPnBoeWxpbmtfY29uZmlnLmxwaV9pbnRlcmZhY2Vz
KTsNCj4gKwkJX19zZXRfYml0KFBIWV9JTlRFUkZBQ0VfTU9ERV9HTUlJLA0KPiArCQkJICBicC0+
cGh5bGlua19jb25maWcubHBpX2ludGVyZmFjZXMpOw0KPiArCQlwaHlfaW50ZXJmYWNlX3NldF9y
Z21paShicC0+cGh5bGlua19jb25maWcubHBpX2ludGVyZmFjZXMpOw0KPiArCQlicC0+cGh5bGlu
a19jb25maWcubHBpX2NhcGFiaWxpdGllcyA9IE1BQ18xMDBGRCB8DQo+IE1BQ18xMDAwRkQ7DQo+
ICsJCWJwLT5waHlsaW5rX2NvbmZpZy5scGlfdGltZXJfZGVmYXVsdCA9IDI1MDAwMDsNCj4gKwkJ
YnAtPnBoeWxpbmtfY29uZmlnLmVlZV9lbmFibGVkX2RlZmF1bHQgPSB0cnVlOw0KPiArCX0NCj4g
Kw0KPiAgCWJwLT5waHlsaW5rID0gcGh5bGlua19jcmVhdGUoJmJwLT5waHlsaW5rX2NvbmZpZywg
YnAtPnBkZXYtDQo+ID5kZXYuZndub2RlLA0KPiAgCQkJCSAgICAgYnAtPnBoeV9pbnRlcmZhY2Us
ICZtYWNiX3BoeWxpbmtfb3BzKTsNCj4gIAlpZiAoSVNfRVJSKGJwLT5waHlsaW5rKSkgew0KPiBA
QCAtMTI0NCw2ICsxMzQ2LDkgQEAgc3RhdGljIGludCBtYWNiX3R4X2NvbXBsZXRlKHN0cnVjdCBt
YWNiX3F1ZXVlDQo+ICpxdWV1ZSwgaW50IGJ1ZGdldCkNCj4gIAkJbmV0aWZfd2FrZV9zdWJxdWV1
ZShicC0+ZGV2LCBxdWV1ZV9pbmRleCk7DQo+ICAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcXVl
dWUtPnR4X3B0cl9sb2NrLCBmbGFncyk7DQo+IA0KPiArCWlmIChwYWNrZXRzKQ0KPiArCQltYWNi
X3R4X2xwaV9zY2hlZHVsZShicCk7DQo+ICsNCj4gIAlyZXR1cm4gcGFja2V0czsNCj4gIH0NCj4g
DQo+IEBAIC0yMzQ5LDYgKzI0NTQsOCBAQCBzdGF0aWMgbmV0ZGV2X3R4X3QgbWFjYl9zdGFydF94
bWl0KHN0cnVjdCBza19idWZmDQo+ICpza2IsIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpDQo+ICAJ
bmV0ZGV2X3R4X3NlbnRfcXVldWUobmV0ZGV2X2dldF90eF9xdWV1ZShicC0+ZGV2LA0KPiBxdWV1
ZV9pbmRleCksDQo+ICAJCQkgICAgIHNrYi0+bGVuKTsNCj4gDQo+ICsJbWFjYl90eF9scGlfd2Fr
ZShicCk7DQo+ICsNCj4gIAlzcGluX2xvY2soJmJwLT5sb2NrKTsNCj4gIAltYWNiX3dyaXRlbChi
cCwgTkNSLCBtYWNiX3JlYWRsKGJwLCBOQ1IpIHwgTUFDQl9CSVQoVFNUQVJUKSk7DQo+ICAJc3Bp
bl91bmxvY2soJmJwLT5sb2NrKTsNCj4gQEAgLTMwMTAsNiArMzExNyw4IEBAIHN0YXRpYyBpbnQg
bWFjYl9jbG9zZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQ0KPiAgCQluZXRkZXZfdHhfcmVzZXRf
cXVldWUobmV0ZGV2X2dldF90eF9xdWV1ZShkZXYsIHEpKTsNCj4gIAl9DQo+IA0KPiArCWNhbmNl
bF9kZWxheWVkX3dvcmtfc3luYygmYnAtPnR4X2xwaV93b3JrKTsNCj4gKw0KPiAgCXBoeWxpbmtf
c3RvcChicC0+cGh5bGluayk7DQo+ICAJcGh5bGlua19kaXNjb25uZWN0X3BoeShicC0+cGh5bGlu
ayk7DQo+IA0KPiBAQCAtNTYxNiw2ICs1NzI1LDcgQEAgc3RhdGljIGludCBtYWNiX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJfQ0KPiANCj4gIAlJTklUX1dPUkso
JmJwLT5ocmVzcF9lcnJfYmhfd29yaywgbWFjYl9ocmVzcF9lcnJvcl90YXNrKTsNCj4gKwlJTklU
X0RFTEFZRURfV09SSygmYnAtPnR4X2xwaV93b3JrLCBtYWNiX3R4X2xwaV93b3JrX2ZuKTsNCj4g
DQo+ICAJbmV0ZGV2X2luZm8oZGV2LCAiQ2FkZW5jZSAlcyByZXYgMHglMDh4IGF0IDB4JTA4bHgg
aXJxICVkDQo+ICglcE0pXG4iLA0KPiAgCQkgICAgbWFjYl9pc19nZW0oYnApID8gIkdFTSIgOiAi
TUFDQiIsIG1hY2JfcmVhZGwoYnAsDQo+IE1JRCksIEBAIC01NjU5LDYgKzU3NjksNyBAQCBzdGF0
aWMgdm9pZCBtYWNiX3JlbW92ZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAg
CQltZGlvYnVzX2ZyZWUoYnAtPm1paV9idXMpOw0KPiANCj4gIAkJZGV2aWNlX3NldF93YWtldXBf
ZW5hYmxlKCZicC0+cGRldi0+ZGV2LCAwKTsNCj4gKwkJY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5j
KCZicC0+dHhfbHBpX3dvcmspOw0KPiAgCQljYW5jZWxfd29ya19zeW5jKCZicC0+aHJlc3BfZXJy
X2JoX3dvcmspOw0KPiAgCQlwbV9ydW50aW1lX2Rpc2FibGUoJnBkZXYtPmRldik7DQo+ICAJCXBt
X3J1bnRpbWVfZG9udF91c2VfYXV0b3N1c3BlbmQoJnBkZXYtPmRldik7DQo+IC0tDQo+IDIuNTEu
MA0KPiANCg0K

