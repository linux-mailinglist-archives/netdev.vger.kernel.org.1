Return-Path: <netdev+bounces-154917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F63A0055B
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 08:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825611883A4C
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 07:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8502014D2B7;
	Fri,  3 Jan 2025 07:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Way/5CoH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC9F4C62
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735890499; cv=fail; b=serF8TGz0DeHJnSEPmx0zLbgVsasX8JOqsGFF14WqmrBaTCYcs+E0QOirc1ghS7MA2eCNCEXdpFJ+fviUV1r4wBw9MiZHKOyHYHwcomAIXauwdyy0AGX86bdP3mZ5ZZq09CIzH/UhDzclaZM8+CVKvWBcI+60CkwkKrLFZDcYks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735890499; c=relaxed/simple;
	bh=YMPK8BH7DmaoakVax03HxktuE5MOtNnApb9lJ58b/Qs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XVk3uzia3FHqhTRpU3BClpH9EcmsykqlsWS1a30o+CIONJI8I3Rs8f5fTh3kWoyQ1iI5JDtTgbwnKCtm5waPkRm+u4btKLNNTHwcZ37lRHo7ACk3UEVBNSBMboM5xZhlTZYy1ciy5nKh/+Me09gRrjU2sDBXt73Cfz/s6GvQU0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Way/5CoH; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5037Cddw008347;
	Thu, 2 Jan 2025 23:48:02 -0800
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43xba581p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jan 2025 23:48:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bU1GMSUNpL2Tg21Ar6omb/AfNKS7xFDSYArC07/NIKX+VkBmdPuM5y7O9Sbua+GtG3yaL1Upe7HkgeoV5jojVDaY5E2IWEdQR9lTJ0WRnmv/ybiNgpOQNDAUmYExznFk7Dx0tZszusp+EJazAjNyzxbR3hdC5IkNX0AkOM5nNxirlBFDAun2inK9OlKcm3Zo0ZIhXZxL/upEfr2XKRx40ZtWJK3K5ba14q6pQ3WDxsLmrOmBSX2yEqFr4RQekoVWOw0BZTs+jvwIKcMH94iCsMKeh+LJc6jvFC4+qYXbeRD6lqxVUOcxOHGqXcE3DdP7y0lgDl++aspcs7S5by8c4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMPK8BH7DmaoakVax03HxktuE5MOtNnApb9lJ58b/Qs=;
 b=XFZ7K9SW9pWeCEKGQBrhoTKqh4hNVZlBA2dzeXvPFrwWiRXjCunOggMsOOSCZ45MZzFlwAJxuXtmSHHy9v1pqacRU6O6ZbrkjD8RnAAEix/2kdBgOv06WYrs0O5SwH1A1B9QuV0OJflq+xENrBvOJGkYClX+LTj1tW3CQXZzSASzyAKTMb9+f5q8gDyItPXOlqPMQNPShnqY4FNtwhMFGS/NqvBeug63QXGni9idrUuk4V3odms5jb8u/oJRLw0cLz0YqSlNPYACBzBrWSDU0Lt3E1iNt9DCbp9/NSDOcYiaKKZIDqZPcluqKRixmzJUQqxuoM8p3WnxQYFeeHKx6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMPK8BH7DmaoakVax03HxktuE5MOtNnApb9lJ58b/Qs=;
 b=Way/5CoHmiG/7xXwyVyjYQQJiKFe9MA34EUJ6J1IJMI6aLCkXxvhYnNlPvkAvTrw/G+gM10SyMxobNuHOPXu9wcB5RknQaMX1y7en7HWfnMczydkc/urCvw1j6ufMgH/v+tHbruoTA6L+QfQPZITRyCM2dkLwTx+P4/wYPJwlag=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by DM4PR18MB5076.namprd18.prod.outlook.com (2603:10b6:8:48::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 07:47:55 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1%5]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 07:47:54 +0000
From: Suman Ghosh <sumang@marvell.com>
To: Francesco Valla <francesco@valla.it>, Andrew Lunn <andrew+netdev@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Russell King
	<linux@armlinux.org.uk>
Subject: RE: [EXTERNAL] [PATCH] net: phy: don't issue a module request if a
 driver is available
Thread-Topic: [EXTERNAL] [PATCH] net: phy: don't issue a module request if a
 driver is available
Thread-Index: AQHbXKg8H7jgrRampkW8GAv8A6L2K7MDOUkggAANmwCAAWb/MA==
Date: Fri, 3 Jan 2025 07:47:54 +0000
Message-ID:
 <SJ0PR18MB5216A8D227B2B3651DB9AC0DDB152@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20250101235122.704012-1-francesco@valla.it>
 <SJ0PR18MB5216590A9FD664CF63993E95DB142@SJ0PR18MB5216.namprd18.prod.outlook.com>
 <4771715.vXUDI8C0e8@fedora.fritz.box>
In-Reply-To: <4771715.vXUDI8C0e8@fedora.fritz.box>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|DM4PR18MB5076:EE_
x-ms-office365-filtering-correlation-id: b24cbe94-811a-4d54-7924-08dd2bcaeefb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YVA1ZzhvU3FnN3lGb1R2RHJQQ2RGQlB4akJNZnZucHlidTV5Uzk5MThlUXBB?=
 =?utf-8?B?K3BmTWFiQk1ORUdXOUlzdytzdDMzNUYzNzNvcUltWGZpMUZlbWNNNFVTNEtn?=
 =?utf-8?B?dmNEUEdSdHpnYnRWaEJETVdKUXA4UkxYWWNucDJYVUdzVCt4dy9BeWwwMUQ0?=
 =?utf-8?B?SXVkeVJWaWptRWMyUkRzbHowY3ptMmpZajNFcEpsenU4R2xjZlFGaVhsamE3?=
 =?utf-8?B?M3lFQW5iOEFQU1RoazlLMU5nd09yZGl0TEZiS2lDRG4walBFdmVML1JhdDZx?=
 =?utf-8?B?eFVnM3RxMmRiMVVhaE13VHFOVzdadEtoaVpiSzFpM1hHNWJZT3RneUlWMkRo?=
 =?utf-8?B?Rmh0V081UmIzNXBreWUvQldibFFOeGFnSjFWQUVvSWhZalZ0Mi9aOXRybnVS?=
 =?utf-8?B?WThuQ1crc0d1VHhYeWdvSHNJYVc4Um9zM21iRUxNZFE2WW02eVlPbEI3eERi?=
 =?utf-8?B?cU9SUjRNRnF0a1hscnQzenVERFFRejlJYkhSN3FRVXJRMDZ4OSt5V1BzVW83?=
 =?utf-8?B?QkxpQ2hPcUo4dXVCdXNrZ0p6QmR3aHVhbnFTME1hVkU0MEttVXJOYXJNeVBr?=
 =?utf-8?B?SGdNc1ZSNXlvVkJQaUZaaUNJc1NDYXV6Z0JJM0ZaQlk0dy9zUVovTTA2cnZz?=
 =?utf-8?B?bXZ5aTNSTmlUbnhjMUdXV2t6RU5nVTJ1c2RKKzYvQmhlZFhaOW5mZGN4TlN3?=
 =?utf-8?B?QXh1VGlGVDlFV2ZuRS9aTEtkc1hFZ1RIa2N5NkZwZlNsSTFZZEJQcVpHVDls?=
 =?utf-8?B?WEtQS1FVK3ZGUHB2Mlo1U2piMERxOWhtNG55NHgwSXhVSFQwblRzc3hwQy9V?=
 =?utf-8?B?bHllY1Vub0o3ZkVCU1czalVJZnVESGFYRmdXdEIwdkJ4dGdWS0hpRU1pTkVv?=
 =?utf-8?B?TGU1MStHYmliYWxDT3M4Ni9PS3VpUkpHMFpjdGx5UXoyS29YSjZWc2wydEFU?=
 =?utf-8?B?RUZUc0dsSDlsdU83WkJjdndSMG9DRG1yS3JKY0RCMXNmUUxpYXZLUnpsS09Z?=
 =?utf-8?B?WDdGVVI4TmpnS3E4UkhiaU43THp6VDV4SjF3MFdwNURRaGs0UXptUzMwNjFT?=
 =?utf-8?B?R25nbUp6SjRFV3IyS1p5MEZCcUl2bGExbU1kRG9xZ2hUY1Z5UVZDOXIyczhn?=
 =?utf-8?B?STMxWFlPL3hONkdNWTQxU2JleEplc0dOa25lUmxuY0NTWHlhWlVvZCs5eXZv?=
 =?utf-8?B?ZHFjb2RGdW5pOXFNZFJsRGQzRis5SitsUzU4ZjV1YUo5WmhhZzJuQ0krbmlO?=
 =?utf-8?B?d05sZWRXeUJDcUEyTTIwT2xENDZJSFFXalgxSFZsSC9zY1JDRUxVWHdjYmV6?=
 =?utf-8?B?Rm9SWkdDQzZSbFg5amxxRDYxd1hUNlR2WHB1SWlUUU1VcE5yKytFMTBlcUhM?=
 =?utf-8?B?WnhzbklITktKbk9XeUpvWGxpVWRIMjMzK0NQQjlVNzRRTWtQWkJmNkt3UHcy?=
 =?utf-8?B?dkxZRTRoNExUazBBNTZGM250L09QQkI5Z3FaaHQxcnhuM2haVDhsNWpaeGs5?=
 =?utf-8?B?dWdFb29WUmlyNU94OWR6RlJqcTFyeHp5d2xBQkt4czlERWQweUZCRjl2NlVN?=
 =?utf-8?B?d2ErWmZGb2RYTUZxdWZqTHk0MHIxMWh6RVZRUFVzSjBmMXlqdklLdks5enVV?=
 =?utf-8?B?blA0VVd0K0NXTkdFYTNkTlNZOFVOU3Z0dmp3OUpJRFZwVjlacHlBUU1MbzRR?=
 =?utf-8?B?Ynp1amRMSGpjNWRVQ3FMazh1TzUyKzBJR2twU09nT1JyZlpycy9wd2c3bTAw?=
 =?utf-8?B?blBYenc4dVNNQmVrYVBvMmZLaHpxK3RqQy9MY0R1b3Nvd2FOMnBJRFpHZVNP?=
 =?utf-8?B?blNLa0x1QVBwVDVlcExjaS9zUkV2ZHI0QmlqYnpKVWg1bHlaUXVxbmpWOGN4?=
 =?utf-8?B?Ykc0TkhYZFpVVzg4UEdVMGNheEdWdmxCQlJUeFEzV09sYmZMVWtFVW9kQldQ?=
 =?utf-8?Q?DP248dQbovOM//EksThG+bY5iZvqzkBq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bTFuTEhHdXR1aFFrZDVBZ1lPRVJKSzBzK2pvc2Jrcm9XWDdFWnM0UnRJQWZ3?=
 =?utf-8?B?aTdiUVE1M1dVVitDbGNtQzFDUnhpdUthSmdWSU93UThIVjFjY2gvMk5yNHoz?=
 =?utf-8?B?Rm44UHcwaEZJbFMwMVRCMFNSbmNmSUtaTk4vR3pnRnNnUENCaHBaRVhNWng5?=
 =?utf-8?B?SVVqUUZnclVMRVdCSWFsR3hLWDlZdUgwZ3dBd2J5S1p2TXpYUmRKVnR2clo5?=
 =?utf-8?B?Z1IwU01sTkx1VVcya2NyTE43NXlHUmpEK3UxWkRjSlJNLzhRVkE2QzlIaGpM?=
 =?utf-8?B?NG9QOHdHT3AzL09LaWNTdWdqT2N2OFBiWVdpeTFUUXVCRHVaa0hlM3JPUytp?=
 =?utf-8?B?SXVmR1FIWFRhNmc5aU5Bbk5jTDJUMFZxOUhUNXpkMlBKME1ReFkvM1NCZk1j?=
 =?utf-8?B?ZStBUDNwNVNJM3BGa2liZ29jaGV4L3d0clFGZzVpL2tWRnRmUEFDK2JrYmFj?=
 =?utf-8?B?aUQ2d21nUnhkVFU4ckY4Y3ZubXdGTitvTjN2MHdWd1dqdHZKK1RyQVZIVzBR?=
 =?utf-8?B?SkE4dHN2c3F0alF6UmlQR0hScG9qNFdCTzRVS2VpeUNYMDczcHF6N2EvMmdO?=
 =?utf-8?B?ZTY2Vk4vaFhyRHNFN200dE5QMG9zL0p4ZWJINERwYjM5VzBQMDJyZDRMZ3Zn?=
 =?utf-8?B?NmJqeTZ1TDl5ZE5ZdHUxY2lhMW9KRG9BakNBbUt2ai9aa3psQzFINm4wekRs?=
 =?utf-8?B?Q1k4ZjV5RC8yN1I3Y2h3Wk82WHkzZXh4QTJrSGdmckdNQzgvYkk5eTUraTBB?=
 =?utf-8?B?b0l5N1llNnU5WmpERVBJWXhrVGVidDJiellOWndWN3RaUGJIS3U2bHhudk8x?=
 =?utf-8?B?dGg3dG9BY2VBVDdzS0ZJbEtUcXVzYnlPd2NPK1Y3UmJTcStVZVI3b2VSaXZh?=
 =?utf-8?B?RkRDdVJySURCa0pVRXZYdkduajFIRThuRGJSaEJ2Z3I0ejFBR0dFMjhONjI1?=
 =?utf-8?B?dUdPMndodjV4L0xiakVZTkU1ZkFTVkVlSmN2aW1SVE9JMXBtMHc5QWFVMG1n?=
 =?utf-8?B?QytNelFVWEVCUjVKYkgrRW15bkt6RU9waTZCSDRBd09iK2krUUxMZ0RUWjlI?=
 =?utf-8?B?VVhlUmFrVWp0ZitvL1YrS29YV2JsVHBIMnprNUFPNzJKZkNreHk0RHhrT3F5?=
 =?utf-8?B?WDFsbEhIQnlXV1A3LzVaa1dXMDlhNDlYbys5YjNGc3ExakxCOVZNTVdPZnU5?=
 =?utf-8?B?TVBqUEJFQ2NBMkt5Vy8wMFI3MC9hQ0ZVSzV1Q2tWdGpqSjFTSEwxUFZmUDl6?=
 =?utf-8?B?NFQvcmNzTnRVQkpCc3dhSmlqZVc2SlZlM2VwMldYQUsrVUFvbmd5OFF1Wk9l?=
 =?utf-8?B?elgwVVpHektGVE52MDBxYkRUL1gxanZsckpCYjFXZmNUUHl6OXVva3Z6elZw?=
 =?utf-8?B?K3dneFpEZWQwUTdDQzNYdWdTNldwc2t1UzFmOUtRcmlrYlg5Z0o1OTdBRzUy?=
 =?utf-8?B?L2ZKSmhUMlhyUGUwR2t4NFVWS3o2YkhEUVh4MUtNY0hrWmpocjRjTEwvSXFH?=
 =?utf-8?B?Ync2MmFpRXJlMTNSSSt3elFFQTRQSjFEV1R0MGRETkVQcmNvMUhBNFNsS3Er?=
 =?utf-8?B?VlBMZFlwZnZTSCtCZXd4YXBpL2tSd2xxYTM0NlU2aVlsN3JzQlpaRlgwTnhK?=
 =?utf-8?B?UWZtQTVON1ZjM3o5Mm94eXhkd3VVdTRiM1JXSElLZ0VIbzg5NUY3Z0ZlaXNi?=
 =?utf-8?B?YTFDelNjbVZoWmQzRUFuSDVpY2M3MGxublN0cmoycGRFQ2hTNFNYZWFRSHNR?=
 =?utf-8?B?S2VSU1NhZnVVQjQ0bXhNWTIxT0pBL1RFWE50bnl4RysxRXdiOTZEV1A5Mkhx?=
 =?utf-8?B?ZDg4K3QzcG1wOGVsZGZIRGVpbmErdXBIaTltWi8rdUNMb3hJcU16dTRCYWZD?=
 =?utf-8?B?dFZoU29JMDM2NU0yaHNvbGVhTUUxTGVjT3YxWW1ybTdIN3pGdERMVlJ3RW1i?=
 =?utf-8?B?RWN2ZWdQMnZ3RlU2RXBISEVTZU9hM0dUSGZFUkM5eC96Zmh1MDJtUHR2YVA1?=
 =?utf-8?B?ZlZERkVQZUZCbnByUXRPNWw0bXFidTJsaEVMZmIxOGhGOTRST0NqdmJwUDZZ?=
 =?utf-8?B?TVMxTXdzYkdLMytrRFJZQ3ZUVTFaRHk3M1czNzBSZ1Y2WkdNNTdwT1lZNkt5?=
 =?utf-8?Q?3eC2VdrppQ+djn1eSOXrDkn5P?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24cbe94-811a-4d54-7924-08dd2bcaeefb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2025 07:47:54.9285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jdst0m7s1PjGh80XQCzTU0gmVT94dkGSZinceN8YQDLEZt5b2B9t7Bh8rct2aWnNixhhLAp/gkDG/++xvhZ5IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5076
X-Proofpoint-GUID: L8yeWxJpoPtPLDDghaDCXQD-tVqAgc43
X-Proofpoint-ORIG-GUID: L8yeWxJpoPtPLDDghaDCXQD-tVqAgc43
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Pj4gPiAJbXV0ZXhfaW5pdCgmZGV2LT5sb2NrKTsNCj4+ID4gCUlOSVRfREVMQVlFRF9XT1JLKCZk
ZXYtPnN0YXRlX3F1ZXVlLCBwaHlfc3RhdGVfbWFjaGluZSk7DQo+PiA+DQo+PiA+LQkvKiBSZXF1
ZXN0IHRoZSBhcHByb3ByaWF0ZSBtb2R1bGUgdW5jb25kaXRpb25hbGx5OyBkb24ndA0KPj4gPi0J
ICogYm90aGVyIHRyeWluZyB0byBkbyBzbyBvbmx5IGlmIGl0IGlzbid0IGFscmVhZHkgbG9hZGVk
LA0KPj4gPi0JICogYmVjYXVzZSB0aGF0IGdldHMgY29tcGxpY2F0ZWQuIEEgaG90cGx1ZyBldmVu
dCB3b3VsZCBoYXZlDQo+PiA+LQkgKiBkb25lIGFuIHVuY29uZGl0aW9uYWwgbW9kcHJvYmUgYW55
d2F5Lg0KPj4gPi0JICogV2UgZG9uJ3QgZG8gbm9ybWFsIGhvdHBsdWcgYmVjYXVzZSBpdCB3b24n
dCB3b3JrIGZvciBNRElPDQo+PiA+KwkvKiBXZSBkb24ndCBkbyBub3JtYWwgaG90cGx1ZyBiZWNh
dXNlIGl0IHdvbid0IHdvcmsgZm9yIE1ESU8NCj4+ID4gCSAqIC0tIGJlY2F1c2UgaXQgcmVsaWVz
IG9uIHRoZSBkZXZpY2Ugc3RheWluZyBhcm91bmQgZm9yIGxvbmcNCj4+ID4gCSAqIGVub3VnaCBm
b3IgdGhlIGRyaXZlciB0byBnZXQgbG9hZGVkLiBXaXRoIE1ESU8sIHRoZSBOSUMNCj4+ID4gCSAq
IGRyaXZlciB3aWxsIGdldCBib3JlZCBhbmQgZ2l2ZSB1cCBhcyBzb29uIGFzIGl0IGZpbmRzIHRo
YXQgQEAgLQ0KPj4gPjcyNCw3ICs3NDUsOCBAQCBzdHJ1Y3QgcGh5X2RldmljZSAqcGh5X2Rldmlj
ZV9jcmVhdGUoc3RydWN0IG1paV9idXMNCj4+ID4qYnVzLCBpbnQgYWRkciwgdTMyIHBoeV9pZCwN
Cj4+ID4gCQlpbnQgaTsNCj4+ID4NCj4+ID4gCQlmb3IgKGkgPSAxOyBpIDwgbnVtX2lkczsgaSsr
KSB7DQo+PiA+LQkJCWlmIChjNDVfaWRzLT5kZXZpY2VfaWRzW2ldID09IDB4ZmZmZmZmZmYpDQo+
PiA+KwkJCWlmIChjNDVfaWRzLT5kZXZpY2VfaWRzW2ldID09IDB4ZmZmZmZmZmYgfHwNCj4+ID4r
CQkJICAgIHBoeV9kcml2ZXJfZXhpc3RzKGM0NV9pZHMtPmRldmljZV9pZHNbaV0pKQ0KPj4gPiAJ
CQkJY29udGludWU7DQo+PiA+DQo+PiA+IAkJCXJldCA9IHBoeV9yZXF1ZXN0X2RyaXZlcl9tb2R1
bGUoZGV2LCBAQCAtNzMyLDcgKzc1NCw3IEBADQo+c3RydWN0DQo+PiA+cGh5X2RldmljZSAqcGh5
X2RldmljZV9jcmVhdGUoc3RydWN0IG1paV9idXMgKmJ1cywgaW50IGFkZHIsIHUzMg0KPj4gPnBo
eV9pZCwNCj4+ID4gCQkJaWYgKHJldCkNCj4+ID4gCQkJCWJyZWFrOw0KPj4gPiAJCX0NCj4+ID4t
CX0gZWxzZSB7DQo+PiA+Kwl9IGVsc2UgaWYgKCFwaHlfZHJpdmVyX2V4aXN0cyhwaHlfaWQpKSB7
DQo+PiBbU3VtYW5dIENhbiB3ZSBhZGQgdGhpcyBwaHlfZHJpdmVyX2V4aXN0cygpIEFQSSBjYWxs
IGJlZm9yZSB0aGUNCj5pZi9lbHNlIGNoZWNrPw0KPj4NCj4NCj5Ob3QgcmVhbGx5LCBhcyBpbiBj
YXNlIG9mIEM0NSBQSFlzIHdlIGhhdmUgdG8gY2hlY2sgZm9yIGRyaXZlcnMgdXNpbmcNCj4obXVs
dGlwbGUpIElEcywgd2hpY2ggYXJlIGRpZmZlcmVudCBmcm9tIHBoeV9pZC4NCltTdW1hbl0gSG1t
IGdvdCBpdC4gV2UgY2FuIGlzb2xhdGUgdGhlIGVsc2UgcGFydCBidXQgdGhhdCB3b24ndCBtYWtl
IG11Y2ggZGlmZmVyZW5jZS4gVGhhbmsgeW91ISENCj4NCg0K

