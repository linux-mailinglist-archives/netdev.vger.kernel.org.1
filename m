Return-Path: <netdev+bounces-301956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZiopHPkgPWrPxQgAu9opvQ
	(envelope-from <netdev+bounces-301956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 14:37:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B478A6C5A1E
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 14:37:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=selector1 header.b=y3bLbB5D;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301956-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301956-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 444E43016EED
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 12:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545C23E1D08;
	Thu, 25 Jun 2026 12:36:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012014.outbound.protection.outlook.com [40.93.195.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377783E274E;
	Thu, 25 Jun 2026 12:36:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782390969; cv=fail; b=Sen3YSn+GEDTBdqerxCXlLbTjTbkO407B6arGPQPE8lGQmuDlpsWLMgswBZopaRmZkf5iThnXVCaYljGf5PrSR5BOkBKDNSEjNj8gBMEYC/Qi4yNjj3isb3muPKeO8XSACA9oSlWj8nOF/alcM2iA/JdA1IEKA+4ReABu4Qct+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782390969; c=relaxed/simple;
	bh=W68GcemP5aslLTvHK9FrvmlZJGarzs2hFBypKnmXT7k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EP2oFF+QCp+TQqOq6RxUfnGf2RAb1KJmcVhHw6Fs637quAwmCxzBrheIRu/bfBQ/ms2d0Qz4KohulE4xZ9PYCVdBsA2qIXAtf9CnqyFz7z6Y6QMeRMTuhmfGP/fQPgfXvLclj3Xy1sX/Flag7951sSI/bwGigxZJ7FeSeBvNw+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=y3bLbB5D; arc=fail smtp.client-ip=40.93.195.14
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXEP8/4u6sApxbW40JXPf8kOQmwpvVS9Me/JA1d9UWOaphA/OmANPNOfQH3xEBDoCV4wAOkr2vsP1QiUnRwhe9bTlO1tCc8XLd/nDHAQol4G3vAs5d/JRFrhOnO9IAU2VTZJKAjaNoRMT269z/nMWJtjZ4rvr2Yp/qoIUZ1/hvMRQtj11jhEAi38Y1Ys0LrIALUaU5ivIoNr6JCb9ltRWRDRX6MViugB8aviIJGgBgGzmahfUflQNpu5SwFtoWPu7URsczsHlkM6QuTrJqWKYDO88WnsUEPtWpB9Zjx3k/QK41cvv4WJzN8l6Lk8HW5E/TV/+ti98ylbZniNjvWtQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W68GcemP5aslLTvHK9FrvmlZJGarzs2hFBypKnmXT7k=;
 b=XqIGxzy36yVfpBysCTCbL/rCSJhW3DQ1c0lP3pEW/x3TX0Tr1I2n32c6Mty/i6jOqDDFFMq/OkpTwxw2bNS3VXvmo2nUAHnZphhyA6KhG1q/0HCtf62Drq38zDGUDBhb0O4tRJo+m9IM8DVosbFU5hXp2fPOtvIPpDiCZOjemPAAF2S6fuMjR4uyUMDDwXvizLAlPVeezBxXbkFQ3DJVoUcSZhplGSGbN5SadiKQ9mUDmjTnqQQwVgDAzAi19MjH8baN/7MZQcukh2/BswXTSEtPCv+N0UhUgQXkwxK9lhfdILu2tEr+rSAjJuGkN0dNDcg26pC2V0/VlhHZ7aOspw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W68GcemP5aslLTvHK9FrvmlZJGarzs2hFBypKnmXT7k=;
 b=y3bLbB5DLAwZCf6NQktf49Jo+fXmhGt6w3mHZDa5kA88n4+m7YSjkqYjPjFdTrgf2h3MFHUoFCtApRHazKZ0CGwIDoPU8iSDI5v+WA71pidzuutTaolmIzpLG5+YxXVPmHUg3R2RxgUhmQfclbn8QQhgXPn4vJhNFf+6h6FYxiIA5DKQe8E9XqnEmR1NyXpaUY8Xn6XYduGoxDv/r2aDVAm4cbty3uzi3cvrpY57te4iYGGyQMPqTqVozxaVyk9TLV7Vq1GpyvROcMzsU/4/OArPn8onPBsO1mSJ9EKZBn9rqrP/OQySOyUugU21txSLBBaa93BJpXkJTfEwGiZilg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 12:36:02 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf%4]) with mapi id 15.21.0159.013; Thu, 25 Jun 2026
 12:36:02 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <Selvamani.Rajagopal@onsemi.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Pier.Beruto@onsemi.com>
CC: <andrew@lunn.ch>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Conor.Dooley@microchip.com>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH net v5 1/4] net: ethernet: oa_tc6: Interrupt is active
 low, level triggered.
Thread-Topic: [PATCH net v5 1/4] net: ethernet: oa_tc6: Interrupt is active
 low, level triggered.
Thread-Index:
 AQHc+e0XZNEa+AKE3E6e8zsz3KcUMrZAt0IAgAMKGgCABla3gIABk9YAgAAH9ACAA5akgA==
Date: Thu, 25 Jun 2026 12:36:02 +0000
Message-ID: <f127837f-e08f-48e0-a3a9-906e1d61d6bb@microchip.com>
References: <20260611-level-trigger-v5-0-4533a9e85ce2@onsemi.com>
 <20260611-level-trigger-v5-1-4533a9e85ce2@onsemi.com>
 <7c89df6b-32ac-46c8-8400-945879037f2e@microchip.com>
 <CYYPR02MB9828CD98EEEB9B218A940E4483E32@CYYPR02MB9828.namprd02.prod.outlook.com>
 <CYYPR02MB9828A1434E6339A6CFCCA74283EF2@CYYPR02MB9828.namprd02.prod.outlook.com>
 <64f4f30e-a987-4289-b36a-1acc977a6764@microchip.com>
 <CYYPR02MB9828E1167750AEA090EC60CD83EE2@CYYPR02MB9828.namprd02.prod.outlook.com>
In-Reply-To:
 <CYYPR02MB9828E1167750AEA090EC60CD83EE2@CYYPR02MB9828.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|DM3PR11MB8735:EE_
x-ms-office365-filtering-correlation-id: 87ad0e4d-3fa1-4912-a76e-08ded2b65150
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|38070700021|921020|6133799003|11063799006|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 dfzyoLtlsr+VacMkTamU23RQp/lUY6LvBxHa9GvVzNKnpj+jI0+yXAggoTFhAWFaPWKDJOu09EsU+059kVm8Lf5FEOv8iXkWLYX884ZzcwO6haWj1VRj2hUXTQ7xe93H/tem04GLTuLRWEhTa7VlVOHOKf/ZrUQmSItSXWxHYvOc1DMnmLL8AJ2GC8lJzivJjjUWJ1W7wP0LTPuPMfZsRby1puDVW1PRlG0m9nAIKWlrtcvyix7x7Il9cLLvgrS48V8e2oH7F0IR1tdf68KFabEjVkOia36J0nBlz1J7dfthL2tXDyZDaD/pUeu2NQMDMchlYSLqAXWABDmWHilmU0XgSbxeZ6C1+DNpHnr+3okw29QhgGy2qdOTZQtHTCEp/VJURl/TkbINjVJy7oGr5pQIjS4JIsSit0AVwRw2+f6ADAi9p/6j7I2XT0DMoJWBRU4OYx2Z+297ZipCmGf1XINOW1GeYZBAkwnAJgaq8IWWpmLTkmOBqRQ0FajZBrlt1N/Gon2qLesIMxh9X1oP79TJJmlWtujAcd4Innrr4UnB2Mdzal3swkWYQPjmJ+xecAsPfKoKeLrgcE9tYNlXAJTSkMOCkZCBfyPkD7R5erzfaW3ozbMrSOCUtzg5U4Y6AL/Oj7Qe4OcyB8BFsx4+hpnkAviSnwaKmfpjLGjFOGmelKZ12Zk5mex4EENCzVn8XFzbxlhWnvoYf5vqcYHhhe/VGCbxGM+o7763ZcpSLQtQveSaqxLl/lExEzmBlrke
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(38070700021)(921020)(6133799003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dndaeGptajlyTmhBaFpEV2hGeTA1TnZsVUg4TXNUaWw0OS9ySHFjUzVDSDB6?=
 =?utf-8?B?V3lVYi9TekExdXhvcXJwV3JyOXk0YXBpejNST1NmL3hkelYvNWNlTXVRWlF4?=
 =?utf-8?B?ckUrWWdOSlpPVlIvODFxREFBNVJSQzlIR3BGVXdkbzk2ZGhZcUZ1RXNyYW9F?=
 =?utf-8?B?bm5hUlNFR1JVclFOcHBDRXdJb1ZvTDFhOThBdHFwTzVJRzRUZ3VGK1RTYWdX?=
 =?utf-8?B?N1RGUXgvWlozN3hIVmxUamNGVVh4K0ZHYThDT0FKTXliMWpRd2prUSsxZmRI?=
 =?utf-8?B?ZmdpZXNVaWVCVnExRFZjRDdNYjJWTlFBTkVMZ3NGYjcrbEtYTUlDd1pEWFln?=
 =?utf-8?B?UTlvSUVJZ3dRajJsUkxVYUQyVDg3bnY0VFpseG55SEJjUGhNeE0zbitSZVJL?=
 =?utf-8?B?VVNPYnBOWWxCd0N4QzM5NkVuTi8wMTFGNnpLU0s0MzZBTzBTZlUxSko1MXVu?=
 =?utf-8?B?YjBWREpjK2p3T25icXR5VTFUVUZXZVJSdGh6d09HdW5FTEJ1ZUxFSTROUWhV?=
 =?utf-8?B?OE80dmxxL1lHZENwdWJRdkpyK1RGNWVRZ2hod2pyU1FsVFlkcHVYSzdwUjFY?=
 =?utf-8?B?a3VyS21sQ0svZUN0ekNtYm55aFNxRm5lVVNSeDk0U1RoWWd2N0lScnVyVnJ3?=
 =?utf-8?B?dTVjVkxPNXZPTUoyTVNmOW0ydDVyYVU1Rjh5V1ViNWlFbnJFd0FockF0S29M?=
 =?utf-8?B?RVBJWDVJc2pmNzVnZ3AzREZ0WktjQVViaEVkVTA5MmU3ejJhazZ1VDV0MTF0?=
 =?utf-8?B?YU5sOGVzRTdSK2tQcFdLRms1K2NCQXc4Y28wN1kvd2JMTHdHcCtNcGpobjI2?=
 =?utf-8?B?WFhMZWdxVHArakNHcjdhYWo4S2svUUNabElpYjdSdUQ3aU1NODEwYjl6Z0FK?=
 =?utf-8?B?c2EvUnVsb0NMMkR0czJWaVlzQWtrSitqTkY3K2R1V1lURHNpRGE5ejBpajg2?=
 =?utf-8?B?QTY0Qkh0Z00veXdNUTFTcGNCdWdyRkRkNjdvRFNYa3FEaHhFczlzU3dYdkZB?=
 =?utf-8?B?ZElOeDJ1b3RjbEtFVlp4VGxMWmZkSUJ5UlFkbEVsL2Q4MzdOSThOZzYwZEVJ?=
 =?utf-8?B?YkFDZVdESWk4Rm5yeENIbVpDSU0xaUFiYUtRRS9KMUpsc0JyMXRVMUdSTWoz?=
 =?utf-8?B?a295alg3ZlJPVWMvMDRIZytBeWJkdWdUdllGVW81ckRsTjJnM0xCTmtTL2ZM?=
 =?utf-8?B?M1RxRGV0c2pmalFIVlJkWlB0bnJXRERNOEVBdWY2WGdOb0JCWEMwMmdXK0k4?=
 =?utf-8?B?b3VPWGxnQzZzRHZ0RUs0aktXY1ZtV29vSWRzYnFCR1pUZmJ2bFY5SUZOdUFM?=
 =?utf-8?B?dXZpbkpaeUpNZWRMVHhsSEM3WjJJZHZjZ040QWpCQ0JQbmpIby9JOXdiRU8v?=
 =?utf-8?B?LzNKTkxib1diWmkwWm9nV2tVSnJnYU1NT2EwU2ZyN3Njd3dOdHZtYjZLcmJX?=
 =?utf-8?B?NDBqQjFnRjM5Tk9TeVE1aEx4Z3l5QXZuQTdySGtGR1U4aEY5SUJKVjJEaEd6?=
 =?utf-8?B?T3hyWUhhVWJrb2J6UVRDSUk1d1BWNmp3WmJDd2Z2Wmt5cVpZVms0dnZxdC9a?=
 =?utf-8?B?b05xZ09pV0ZSYWRwYUVJc0MxSHpzM2kyaHAxNWIyTFhRanN0ZWxyS2Y0ZlBp?=
 =?utf-8?B?TmVpWlRQY3NmbmhiVDQwV3dMWmJBK0QvYjdOdmh1UEI1V09nbFkwaW5idm0v?=
 =?utf-8?B?WllFTC9ZbWlqRzVwVDZtbnFyVExZYUhyT04zampIU2pHL1BFWnBBY1Rtbmcw?=
 =?utf-8?B?Zk12Z3BWbFRZb2IxSTRoK0JiaVRUM3hjT01QRHRzRzY3UE5nWFZzaXo0OVZZ?=
 =?utf-8?B?R2RXUDBaQ2hCN2ovMXZ2WVZNYktrQ0dTV1Jic2hmSnBmZm12NnpxNWh0WUlF?=
 =?utf-8?B?VTg5Wk54YjNNVmhVaGE3MjArT3hLSmZ5OVBWNUV5VFdockJCR2lSWHFRNEt2?=
 =?utf-8?B?MFI1K0YvMzF1THdyWjFzVVByaGUxdzVxU3ZjQWY5UVRlaW56aCtLN1VOVVRK?=
 =?utf-8?B?cUhSdi9hd29jeXc2NTFlMlI4ZWJrMUxrVnp0bURVYlN1TGt6d0gzb0d6dE1U?=
 =?utf-8?B?U3lTM2NIRitZdWM3OStwWkRPM1Q4OUQ4SnU1aUlBMnFDbjZkMFhuMHdGYVZv?=
 =?utf-8?B?QlVOd1JHUy9iYXpnT3lXVEh3RzNab3JrQWRid1F1eHlPaExuK0MwWk1GOVY0?=
 =?utf-8?B?RVVPcEFXcDkweWw1TjlxZFdKUWFCZm9BUzNicHFXKzBNSkxuY0J3MGhSMG92?=
 =?utf-8?B?ZUNnTnhhZHR1V0RRd1Q3cUhaYUtIa3RWMVFZaVdhSjd3UHVQM0lOVGlPak40?=
 =?utf-8?B?KzFmMFpjdFRtSnNKU0p0OGFKYkJpREJybHhveFdDZnd4K3BpK2JLUFY5aDRV?=
 =?utf-8?Q?0JF+JBvAwp4evy64=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF40C355FDC6D444BE0F2E7E76E786BE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ad0e4d-3fa1-4912-a76e-08ded2b65150
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 12:36:02.3178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xQ35idw/fi1gjPeJ1VceDzIQidXjoAQj/ob4HHogn4OnnXouMGy3CKUeSQV3u7Rmjl70KyBoDC7qVMbau1D9sPWuMng51/ZUHbE4s3zQn0ngTT0N0O4aYf4VQSE7CbWz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8735
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301956-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Parthiban.Veerasooran@microchip.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[Parthiban.Veerasooran@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:dkim,microchip.com:email,microchip.com:mid,microchip.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B478A6C5A1E

SGkgU2VsdmFtYW5pLA0KDQpPbiAyMy8wNi8yNiAxMToxOCBhbSwgU2VsdmFtYW5pIFJhamFnb3Bh
bCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+IEZyb206IFBhcnRoaWJhbi5WZWVyYXNvb3JhbkBt
aWNyb2NoaXAuY29tIDxQYXJ0aGliYW4uVmVlcmFzb29yYW5AbWljcm9jaGlwLmNvbT4NCj4+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggbmV0IHY1IDEvNF0gbmV0OiBldGhlcm5ldDogb2FfdGM2OiBJbnRl
cnJ1cHQgaXMgYWN0aXZlIGxvdywgbGV2ZWwNCj4+IHRyaWdnZXJlZC4NCj4+DQo+Pg0KPj4gSSB3
aWxsIGZpbmQgc29tZSB0aW1lIHRoaXMgd2VlayB0byB0ZXN0IGFuZCBzaGFyZSBteSBmZWVkYmFj
ay4gSW4gdGhlDQo+PiBtZWFudGltZSwgd291bGQgaXQgYmUgcG9zc2libGUgZm9yIHlvdSB0byB0
ZXN0IHVzaW5nIHR3byBpbnN0YW5jZXMgKFRlc3QNCj4+IENhc2UgMik/IEkgZGlkIG5vdCBlbmNv
dW50ZXIgbWFueSBpc3N1ZXMgd2hlbiB0ZXN0aW5nIHdpdGggYSBzaW5nbGUNCj4+IGluc3RhbmNl
Lg0KPj4NCj4+IEkgYmVsaWV2ZSB0aGF0IHRlc3Rpbmcgd2l0aCB0d28gaW5zdGFuY2VzIGluY3Jl
YXNlcyB0aGUgbGlrZWxpaG9vZCBvZg0KPj4gcmVwcm9kdWNpbmcgdGhlIGlzc3VlIGluIHlvdXIg
c2V0dXAgYXMgd2VsbC4NCj4gDQo+IFBhcnRoaWJhbiwNCj4gDQo+IFRoYW5rcy4NCj4gDQo+IE91
ciBFVkIgZGVzaWduIGFsbG93cyBvbmx5IG9uZSBib2FyZCB0byBiZSBjb25uZWN0ZWQgdG8gb25l
IFJhc3BiZXJyeSBQaS4NCj4gU28sIEkgZG9uJ3QgdGhpbmsgSSBjYW4gaGF2ZSBhIHNldHVwIGxp
a2UgeW91cnMuIFdlIGRpZCB0ZXN0IHdpdGggdGhyZWUgUmFzcGJlcnJ5IFBpIGJvYXJkcyB3aXRo
DQo+IG11bHRpLWRyb3AgY29ubmVjdGlvbi4gQ291bGRuJ3Qgc2VlIHlvdXIgIk5VTEwgcG9pbnRl
ciIgY3Jhc2guIFdpbGwga2VlcCB0cnlpbmcgdGhvdWdoLg0KVGhhbmsgeW91IGZvciB0aGUgdXBk
YXRlLiBTbyBpdCBzZWVtcyB5b3UgY2FuJ3QgY29ubmVjdCB0d28gb2YgeW91ciANCk1BQy1QSFlz
IGluIG9uZSBSUEkgND8gUlBJIDQgY2FuIHN1cHBvcnQgdHdvIFNQSSBkZXZpY2VzIChNQUMtUEhZ
cykuDQoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9uZXRkZXZicGYvbGlz
dC8/c2VyaWVzPTExMTQ0OTUmc3RhdGU9JTJBJmFyY2hpdmU9Ym90aA0KDQpodHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnL3Byb2plY3QvbmV0ZGV2YnBmL3BhdGNoLzIwMjYwNjIxLWZpeC1yYWNl
LWNvbmRpdGlvbi1hbmQtY3Jhc2gtdjEtMS04N2UyOTBkOTM1N2ZAb25zZW1pLmNvbS8NCg0KaHR0
cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L25ldGRldmJwZi9wYXRjaC8yMDI2MDYy
MS1maXgtcmFjZS1jb25kaXRpb24tYW5kLWNyYXNoLXYxLTItODdlMjkwZDkzNTdmQG9uc2VtaS5j
b20vDQoNCldpdGggeW91ciBhYm92ZSBwYXRjaGVzLCBJIGRpZCBhIHF1aWNrIHRlc3QgKFRlc3Qg
Y2FzZSAyKSB3aXRoIHR3byANCk1pY3JvY2hpcCBNQUMtUEhZcyBhbmQgZmFjZWQgYSBzaW1pbGFy
IGlzc3VlIHJlcG9ydGVkIGJlZm9yZS4gU2hhcmluZyANCnRoZSBkbWVzZyBjcmFzaCBsb2cgZm9y
IHlvdXIgcmVmZXJlbmNlLg0KDQpbIDI4NjMuMTgyMTA1XSBldGgxOiBSZWNlaXZlIGJ1ZmZlciBv
dmVyZmxvdyBlcnJvcg0KWyAyODYzLjE5OTkwNV0gZXRoMTogUmVjZWl2ZSBidWZmZXIgb3ZlcmZs
b3cgZXJyb3INClsgMjg2Ny42NjkzMTJdIFVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9p
bnRlciBkZXJlZmVyZW5jZSBhdCANCnZpcnR1YWwgYWRkcmVzcyAwMDAwMDAwMDAwMDAwMGI4DQpb
IDI4NjcuNjc3NjU4XSBNZW0gYWJvcnQgaW5mbzoNClsgMjg2Ny42ODA0NzRdICAgRVNSID0gMHgw
MDAwMDAwMDk2MDAwMDA1DQpbIDI4NjcuNjg0MjU4XSAgIEVDID0gMHgyNTogREFCVCAoY3VycmVu
dCBFTCksIElMID0gMzIgYml0cw0KWyAyODY3LjY4OTYzMF0gICBTRVQgPSAwLCBGblYgPSAwDQpb
IDI4NjcuNjkyNzE3XSAgIEVBID0gMCwgUzFQVFcgPSAwDQpbIDI4NjcuNjk1ODg4XSAgIEZTQyA9
IDB4MDU6IGxldmVsIDEgdHJhbnNsYXRpb24gZmF1bHQNClsgMjg2Ny43MDA4MjVdIERhdGEgYWJv
cnQgaW5mbzoNClsgMjg2Ny43MDM3MjZdICAgSVNWID0gMCwgSVNTID0gMHgwMDAwMDAwNSwgSVNT
MiA9IDB4MDAwMDAwMDANClsgMjg2Ny43MDkzMDNdICAgQ00gPSAwLCBXblIgPSAwLCBUbkQgPSAw
LCBUYWdBY2Nlc3MgPSAwDQpbIDI4NjcuNzE0Mzk5XSAgIEdDUyA9IDAsIE92ZXJsYXkgPSAwLCBE
aXJ0eUJpdCA9IDAsIFhzID0gMA0KWyAyODY3LjcxOTc3M10gdXNlciBwZ3RhYmxlOiA0ayBwYWdl
cywgMzktYml0IFZBcywgcGdkcD0wMDAwMDAwMTEzYzJlMDAwDQpbIDI4NjcuNzI2Mjk2XSBbMDAw
MDAwMDAwMDAwMDBiOF0gcGdkPTAwMDAwMDAwMDAwMDAwMDAsIA0KcDRkPTAwMDAwMDAwMDAwMDAw
MDAsIHB1ZD0wMDAwMDAwMDAwMDAwMDAwDQpbIDI4NjcuNzM1MTA5XSBJbnRlcm5hbCBlcnJvcjog
T29wczogMDAwMDAwMDA5NjAwMDAwNSBbIzFdICBTTVANClsgMjg2Ny43NDA4MzBdIE1vZHVsZXMg
bGlua2VkIGluOiBsYW44NjV4X3QxcyhPKSBtaWNyb2NoaXBfdDFzKE8pIHNjaF9mcSANCnNuZF9z
ZXFfZHVtbXkgc25kX2hydGltZXIgc25kX3NlcSBzbmRfc2VxX2RldmljZSByZmNvbW0gYWxnaWZf
aGFzaCANCmFlc19uZW9uX2JzIGFsZ2lmX3NrY2lwaGVyIGFmX2FsZyBibmVwIGJpbmZtdF9taXNj
IGJyY21mbWFjX2N5dyBicmNtZm1hYyANCmhjaV91YXJ0IGJyY211dGlsIGJ0YmNtIGJsdWV0b290
aCB2YzQgY2ZnODAyMTEgc25kX3NvY19oZG1pX2NvZGVjIA0KZHJtX2V4ZWMgZWNkaF9nZW5lcmlj
IGVjYyBkcm1fZGlzcGxheV9oZWxwZXIgY2VjIHJma2lsbCBiY20yODM1X2NvZGVjKEMpIA0KZHJt
X2RtYV9oZWxwZXIgdjNkIHJwaV9oZXZjX2RlYyBkcm1fY2xpZW50X2xpYiBiY20yODM1X3Y0bDIo
QykgZ3B1X3NjaGVkIA0KZHJtX3NobWVtX2hlbHBlciBjcmNfY2NpdHQgYmNtMjgzNV9pc3Agc25k
X3NvY19jb3JlIGRybV9rbXNfaGVscGVyIA0KYmNtMjgzNV9tbWFsX3ZjaGlxIHY0bDJfbWVtMm1l
bSB2Y19zbV9jbWEgdmlkZW9idWYyX3ZtYWxsb2MgDQp2aWRlb2J1ZjJfZG1hX2NvbnRpZyByYXNw
YmVycnlwaV9od21vbiB2aWRlb2J1ZjJfbWVtb3BzIHNuZF9jb21wcmVzcyANCnNuZF9iY20yODM1
KEMpIHZpZGVvYnVmMl92NGwyIHNuZF9wY21fZG1hZW5naW5lIGkyY19icmNtc3RiIHNuZF9wY20g
DQpzbmRfdGltZXIgdmlkZW9kZXYgdmlkZW9idWYyX2NvbW1vbiBzbmQgbWMgcmFzcGJlcnJ5cGlf
Z3Bpb21lbSANCnNwaV9iY20yODM1IGdwaW9fZmFuIG52bWVtX3JtZW0gc2NoX2ZxX2NvZGVsIGky
Y19kZXYgenJhbSBsejRfY29tcHJlc3MgDQpkcm0gZnVzZSBkcm1fcGFuZWxfb3JpZW50YXRpb25f
cXVpcmtzIGJhY2tsaWdodCBuZm5ldGxpbmsgW2xhc3QgDQp1bmxvYWRlZDogbWljcm9jaGlwX3Qx
cyhPKV0NClsgMjg2Ny44MjE1NThdIENQVTogMyBVSUQ6IDAgUElEOiAyODA4IENvbW06IGlycS81
OS1zcGkwLjAgVGFpbnRlZDogRyANCiAgICAgIEMgTyAgICAgICAgNy4xLjAtcmM3LXY4KyAjMiBQ
UkVFTVBUDQpbIDI4NjcuODMxNzc5XSBUYWludGVkOiBbQ109Q1JBUCwgW09dPU9PVF9NT0RVTEUN
ClsgMjg2Ny44MzYxODNdIEhhcmR3YXJlIG5hbWU6IFJhc3BiZXJyeSBQaSA0IE1vZGVsIEIgUmV2
IDEuNCAoRFQpDQpbIDI4NjcuODQyMDg4XSBwc3RhdGU6IDYwMDAwMDA1IChuWkN2IGRhaWYgLVBB
TiAtVUFPIC1UQ08gLURJVCAtU1NCUyANCkJUWVBFPS0tKQ0KWyAyODY3Ljg0OTEzOF0gcGMgOiBv
YV90YzZfdXBkYXRlX3J4X3NrYisweDJjLzB4YTggW2xhbjg2NXhfdDFzXQ0KWyAyODY3Ljg1NDk1
NV0gbHIgOiBvYV90YzZfbWFjcGh5X3RocmVhZGVkX2lycSsweDQzMC8weDg3MCBbbGFuODY1eF90
MXNdDQpbIDI4NjcuODYxNDc2XSBzcCA6IGZmZmZmZmMwODNkYmJkMjANClsgMjg2Ny44NjQ4MjVd
IHgyOTogZmZmZmZmYzA4M2RiYmQyMCB4Mjg6IDAwMDAwMDAwM2UwMDIwMjAgeDI3OiANCmZmZmZm
ZmVkMWNmNjA5YzgNClsgMjg2Ny44NzIwNTFdIHgyNjogMDAwMDAwMDAwMDAwMDAwMCB4MjU6IDAw
MDAwMDAwMDAwMDAwMDEgeDI0OiANCmZmZmZmZjgwNDA3OTY0ODANClsgMjg2Ny44NzkyNzddIHgy
MzogMDAwMDAwMDAyMDIwMDAzZSB4MjI6IDAwMDAwMDAwMDAwMDAwMDAgeDIxOiANCjAwMDAwMDAw
MDAwMDAwNDANClsgMjg2Ny44ODY1MDRdIHgyMDogZmZmZmZmODA0YTQ3OTA4MCB4MTk6IGZmZmZm
ZjgwNDA3OTY0ODAgeDE4OiANCjAwMDAwMDAwMDAwOTgyZjgNClsgMjg2Ny44OTM3MzFdIHgxNzog
ZmZmZmZmODA0ODJkNjUwMCB4MTY6IGZmZmZmZmVkMWQ4N2I2YjAgeDE1OiANCmZmZmZmZjgwNDFh
NDNjMDANClsgMjg2Ny45MDA5NTddIHgxNDogMDAwMDAwMDAwMDAwMDAxNiB4MTM6IDAwMDAwNzNk
NmE1ZDM4ZGMgeDEyOiANCjAwMDAwMDAwMDAxZDRlYmUNClsgMjg2Ny45MDgxODRdIHgxMTogMDAw
MDAwMDAwMDAwMDBjMCB4MTA6IDAwMDAwMDAwMDAwMDFhZTAgeDkgOiANCmZmZmZmZmVjYzljOTU5
ZTgNClsgMjg2Ny45MTU0MTBdIHg4IDogZmZmZmZmODA0ZjFlNWE0MCB4NyA6IDAwMDAwMDAwMDAw
MDAwMDIgeDYgOiANCmZmZmZmZmZmZmZmZmZmZmYNClsgMjg2Ny45MjI2MzZdIHg1IDogZmZmZmZm
ZWQxZTU5ZDAwMCB4NCA6IDAwMDAwMDAwMDAwMDAwMDIgeDMgOiANCjAwMDAwMDAwMDAwMDAwMDAN
ClsgMjg2Ny45Mjk4NjNdIHgyIDogMDAwMDAwMDAwMDAwMDA0MCB4MSA6IGZmZmZmZjgwNGE0Nzkw
ODAgeDAgOiANCjAwMDAwMDAwMDAwMDAwMDANClsgMjg2Ny45MzcwOTBdIENhbGwgdHJhY2U6DQpb
IDI4NjcuOTM5NTU4XSAgb2FfdGM2X3VwZGF0ZV9yeF9za2IrMHgyYy8weGE4IFtsYW44NjV4X3Qx
c10gKFApDQpbIDI4NjcuOTQ1Mzc1XSAgb2FfdGM2X21hY3BoeV90aHJlYWRlZF9pcnErMHg0MzAv
MHg4NzAgW2xhbjg2NXhfdDFzXQ0KWyAyODY3Ljk1MTU0M10gIGlycV90aHJlYWRfZm4rMHgzNC8w
eGMwDQpbIDI4NjcuOTU1MTU2XSAgaXJxX3RocmVhZCsweDFhOC8weDMwOA0KWyAyODY3Ljk1ODY4
MF0gIGt0aHJlYWQrMHgxMzgvMHgxNTANClsgMjg2Ny45NjE5NDJdICByZXRfZnJvbV9mb3JrKzB4
MTAvMHgyMA0KWyAyODY3Ljk2NTU1OF0gQ29kZTogYWEwMTAzZjQgZjkwMDEzZjUgMTIwMDFjNTUg
Zjk0MDM4MDAgKDI5NTcwNDAzKQ0KWyAyODY3Ljk3MTcyN10gLS0tWyBlbmQgdHJhY2UgMDAwMDAw
MDAwMDAwMDAwMCBdLS0tDQpbIDI4NjcuOTc2NDQzXSBnZW5pcnE6IGV4aXRpbmcgdGFzayAiaXJx
LzU5LXNwaTAuMCIgKDI4MDgpIGlzIGFuIGFjdGl2ZSANCklSUSB0aHJlYWQgKGlycSA1OSkNClsg
Mjg2OC4wOTQ3ODldIGlycSA1OTogbm9ib2R5IGNhcmVkICh0cnkgYm9vdGluZyB3aXRoIHRoZSAi
aXJxcG9sbCIgb3B0aW9uKQ0KWyAyODY4LjEwMTAwMF0gQ1BVOiAwIFVJRDogMCBQSUQ6IDAgQ29t
bTogc3dhcHBlci8wIFRhaW50ZWQ6IEcgICAgICBEICBDIA0KTyAgICAgICAgNy4xLjAtcmM3LXY4
KyAjMiBQUkVFTVBUDQpbIDI4NjguMTAxMDA3XSBUYWludGVkOiBbRF09RElFLCBbQ109Q1JBUCwg
W09dPU9PVF9NT0RVTEUNClsgMjg2OC4xMDEwMDldIEhhcmR3YXJlIG5hbWU6IFJhc3BiZXJyeSBQ
aSA0IE1vZGVsIEIgUmV2IDEuNCAoRFQpDQpbIDI4NjguMTAxMDExXSBDYWxsIHRyYWNlOg0KWyAy
ODY4LjEwMTAxM10gIHNob3dfc3RhY2srMHgyMC8weDM4IChDKQ0KWyAyODY4LjEwMTAyN10gIGR1
bXBfc3RhY2tfbHZsKzB4NjAvMHg4MA0KWyAyODY4LjEwMTAzM10gIGR1bXBfc3RhY2srMHgxOC8w
eDI0DQpbIDI4NjguMTAxMDM4XSAgX19yZXBvcnRfYmFkX2lycSsweDU0LzB4ZjANClsgMjg2OC4x
MDEwNDNdICBub3RlX2ludGVycnVwdCsweDM0NC8weDM5OA0KWyAyODY4LjEwMTA0OF0gIGhhbmRs
ZV9pcnFfZXZlbnQrMHhhNC8weDExMA0KWyAyODY4LjEwMTA1MV0gIGhhbmRsZV9sZXZlbF9pcnEr
MHhlMC8weDE3OA0KWyAyODY4LjEwMTA1Nl0gIGhhbmRsZV9pcnFfZGVzYysweDNjLzB4NjgNClsg
Mjg2OC4xMDEwNjFdICBnZW5lcmljX2hhbmRsZV9kb21haW5faXJxKzB4MjAvMHg0MA0KWyAyODY4
LjEwMTA2N10gIGJjbTI4MzVfZ3Bpb19pcnFfaGFuZGxlX2JhbmsrMHgxODAvMHgxYzgNClsgMjg2
OC4xMDEwNzRdICBiY20yODM1X2dwaW9faXJxX2hhbmRsZXIrMHg4OC8weDE4OA0KWyAyODY4LjEw
MTA4MF0gIGhhbmRsZV9pcnFfZGVzYysweDNjLzB4NjgNClsgMjg2OC4xMDEwODVdICBnZW5lcmlj
X2hhbmRsZV9kb21haW5faXJxKzB4MjAvMHg0MA0KWyAyODY4LjEwMTA5MV0gIGdpY19oYW5kbGVf
aXJxKzB4NGMvMHhlMA0KWyAyODY4LjEwMTA5NF0gIGNhbGxfb25faXJxX3N0YWNrKzB4MzAvMHg4
OA0KWyAyODY4LjEwMTA5OV0gIGRvX2ludGVycnVwdF9oYW5kbGVyKzB4ODgvMHg5OA0KWyAyODY4
LjEwMTEwMl0gIGVsMV9pbnRlcnJ1cHQrMHgzYy8weDYwDQpbIDI4NjguMTAxMTA4XSAgZWwxaF82
NF9pcnFfaGFuZGxlcisweDE4LzB4MzANClsgMjg2OC4xMDExMTNdICBlbDFoXzY0X2lycSsweDZj
LzB4NzANClsgMjg2OC4xMDExMTZdICBkZWZhdWx0X2lkbGVfY2FsbCsweDM0LzB4MWEwIChQKQ0K
WyAyODY4LjEwMTEyM10gIGRvX2lkbGUrMHgyNjAvMHgyYTANClsgMjg2OC4xMDExMjhdICBjcHVf
c3RhcnR1cF9lbnRyeSsweDNjLzB4NTANClsgMjg2OC4xMDExMzJdICByZXN0X2luaXQrMHhlOC8w
eGYwDQpbIDI4NjguMTAxMTM3XSAgc3RhcnRfa2VybmVsKzB4N2Y0LzB4ODAwDQpbIDI4NjguMTAx
MTQzXSAgX19wcmltYXJ5X3N3aXRjaGVkKzB4ODgvMHg5OA0KWyAyODY4LjEwMTE0OV0gaGFuZGxl
cnM6DQpbIDI4NjguMjA3NzUwXSBsYW44NjUwIHNwaTAuMTogU1BJIHRyYW5zZmVyIHRpbWVkIG91
dA0KWyAyODY4LjIwODA3MF0gWzwwMDAwMDAwMDE5MzYxYzE3Pl0gb2FfdGM2X21hY3BoeV9pc3Ig
W2xhbjg2NXhfdDFzXQ0KWyAyODY4LjIxMjA0OF0gc3BpX21hc3RlciBzcGkwOiBmYWlsZWQgdG8g
dHJhbnNmZXIgb25lIG1lc3NhZ2UgZnJvbSBxdWV1ZQ0KWyAyODY4LjIxNTI5Nl0gIHRocmVhZGVk
IFs8MDAwMDAwMDBhNGU2ZjBmYT5dIG9hX3RjNl9tYWNwaHlfdGhyZWFkZWRfaXJxIA0KW2xhbjg2
NXhfdDFzXQ0KWyAyODY4LjIxOTAwNV0gc3BpX21hc3RlciBzcGkwOiBub3F1ZXVlIHRyYW5zZmVy
IGZhaWxlZA0KDQpbIDI4NjguMjIzMDUzXSBEaXNhYmxpbmcgSVJRICM1OQ0KWyAyODY4LjI2MDE2
Ml0gbGFuODY1MCBzcGkwLjEgZXRoMjogU1BJIGRhdGEgdHJhbnNmZXIgZmFpbGVkOiAtMTEwDQpb
IDI4NjguMjY2MjExXSBsYW44NjUwIHNwaTAuMTogRGV2aWNlIGludGVycnVwdCBkaXNhYmxlZCB0
byBhdm9pZCANCmludGVycnVwdCBzdG9ybQ0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0K
PiANCj4gQnV0IEkgY291bGQgc2VlIGFzc2VydCBpbiBza2JfcHV0IGltbWVkaWF0ZWx5IHF1aWNr
bHkuDQo+IA0KPj4NCj4+IEJlc3QgcmVnYXJkcywNCj4+IFBhcnRoaWJhbiBWDQo+Pj4NCj4+Pj4N
Cj4gDQoNCg==

