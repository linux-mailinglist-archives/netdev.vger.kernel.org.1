Return-Path: <netdev+bounces-150106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D48D99E8EAE
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 10:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37C91883D04
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 09:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFF2215F5F;
	Mon,  9 Dec 2024 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="bDbLJPgf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F191D1EB3D;
	Mon,  9 Dec 2024 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733736399; cv=fail; b=DI/p7f49QfDipHqj539BgnG8lNUzxGDJf3LjW51bpm2MnoGnFYY2uMnie0pXxU0T2NHJEMqYdraDkuCtlQ2s1EUGOawkQJtZUkJGj66q+dwDm+BwrSp/x1g0WDYhiiy6ubbit1a0KCcKDGJtzEqHliXrUpiDzwI/8/WaEYzKYow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733736399; c=relaxed/simple;
	bh=CbuhDWPXzjOwEsijlFTTxEiiT3XvXFVqZUm+01wpcF8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y2ostN8rli8O7v3WMzQ0ZMng86t72g5P0cYmXjeoWg/DN3dhvYXidIsGydJmKPa1fODRgjOpqbqWDPorTImtWEQlpKwg7Du4hubWsF56IWSCfN1+FvH9nIwUhypKPbwCvZVFBL8x7sgohLQ27PAPOMPdl8bKWvGdg81ednSPxdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=bDbLJPgf; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B96xonA004934;
	Mon, 9 Dec 2024 01:26:28 -0800
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43dus5g8dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 01:26:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wriavM5MOeTAUrVWK5oJuTKadxSxpm+t7umWl7WLZxzlIES55zhpZBmkD6h9bZu+SPMcBtgKYGR0rm7g+AatQ+vAtR6wOJY6YbG/kBJsrCVsgPTRPzqYGze+Cpide6IIYI/yRz+2cF+MXaCXRs6o9ERL/KPxqdBNOCUZ7JuuMFCwxYc5xQtsJsdNP71Hm9dnGeeqpTaHeoVuZdNqROTMBuGyoXm4MEoJzTKVwHvl4ky0y9IuOBGuFRdMkAQ6REC/ONBu70LcPXtqRC5glp11y1SDpujBCNXuODvx1bLhJjO2OlGfWzuXiLGaUQ2YQyedxEuLsHOrC2rwiG7VZfC58A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbuhDWPXzjOwEsijlFTTxEiiT3XvXFVqZUm+01wpcF8=;
 b=gRibqMbQ5CmRENe0hyDyPRiPPQ748yMk8TEbrle3+IIgQSNNgX1KQMd7cYRmV4gCOwLBetjmjqf+7A04KooHyhdiTYTRp4yYeRoC3CaQPgJ+k52DF2klLdkUKVcQqa7EAKV/p8Xx2X5EJCM6lQdKfvW7Hs6d7M90U0Nbz4PVfxPeiiA9Sg74C0/KLV4eJ3jhVR5U9W5NJS+5ugx04LZ2VqAexj4EQO4ZSbN3igeC2WPq4DwfHVty7Eiy0NmVs9oZPtwfF9Nb69e9kENamauStzLvWd1vwTlr7eTj+6Q5AAB7AggQFruaBWDmtRuAp/gAb9Pg1OZOH2rwwb06K+CnDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbuhDWPXzjOwEsijlFTTxEiiT3XvXFVqZUm+01wpcF8=;
 b=bDbLJPgfpfHg6gXfTAZ2GmZQQgtrR93+VaiRr8ueT3bSw0/kzkgO8U4sgj3K7P9XYamEPQ5Exk4bpRvTi/bzI0bumwb5Zf6t2nhEMW3uxKra1mysH3Nrb5MVsfR7YqqH2iOitw8UYeYNF9AYbLHAlLqpF1OWkpLJEHhNTq0QOa8=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by SA1PR18MB6020.namprd18.prod.outlook.com (2603:10b6:806:3dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 09:26:25 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30%6]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 09:26:25 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Linu Cherian <lcherian@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "kalesh-anakkur.purayil@broadcom.com" <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [net-next PATCH v5 2/6] octeontx2-af: CN20k basic mbox operations
 and structures
Thread-Topic: [net-next PATCH v5 2/6] octeontx2-af: CN20k basic mbox
 operations and structures
Thread-Index: AQHbShxrHNM0p0casEKAWUitqpYzuQ==
Date: Mon, 9 Dec 2024 09:26:25 +0000
Message-ID:
 <BY3PR18MB4707F24DEA004322270A5009A03C2@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20241204140821.1858263-1-saikrishnag@marvell.com>
	<20241204140821.1858263-3-saikrishnag@marvell.com>
 <20241207184117.4ec188c7@kernel.org>
In-Reply-To: <20241207184117.4ec188c7@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|SA1PR18MB6020:EE_
x-ms-office365-filtering-correlation-id: bb1c0a9c-c7c9-4aa4-d712-08dd18338d84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TEloeHNucFpxbEFtQUllQXdLZmhLanZ6TTNONUE3SmczWVBsMXdlUVNTQTN0?=
 =?utf-8?B?SXcvN0k5aHZNVzZkSHRmTzNWY05VeS9tZi9tdHBhellYd2RUYm5yVkNVRGpF?=
 =?utf-8?B?c0dVTTMyU1pyWVhGWm5KcmF5SGRkUDdBWTByTG9lbVBobEd1OW1abkJHUlFX?=
 =?utf-8?B?bGN5WVZzaXNoWkRFYmpBVUd6dzZYVHpsU0FXSkw3UGViVkJPSGdSNVc3UTcv?=
 =?utf-8?B?ckJ5QlJGZXlycW9JZkFlRUp6ekROZDBFV2M1V0YzK1JwZGR1TnA3ODk2QS84?=
 =?utf-8?B?N01wekx2eEtHYTNpMjRGYjNJN0hmbEVUZzN4S1cvSzRRSHg1Vnh3aW9QMjh6?=
 =?utf-8?B?eVVYRU1JZGtLSjk0UFl6WWxKUmxBR1A0R082Vk5VZmhxeDcvenZIOTJGNTZG?=
 =?utf-8?B?QnhWck5icG9jNGpuT3NMMkdvNWtMaHNvcTYrcHR1b3JHbktKcWhXQUlicmNt?=
 =?utf-8?B?UjVrUlpUWk1kSVdjcDVVaEM5RzNPNmNDYWlCL3htUDFFNW5GWk85cWJkS0Zv?=
 =?utf-8?B?MFpVVng2SGlGZ2dzemRGQkFpaHNLRDdDbHkxTnB5VmpkbSt0NzgrRjZCbWJt?=
 =?utf-8?B?RXRoUkUrRjZzM3BMWWxpb0N6akFFT1ZqbkFzck5kZDFGOTBhaGtpdHRBWk8v?=
 =?utf-8?B?Qk1rUDY2UkdtQk9oUXlqVy9wbTAyQUVldXFXQmlvRzRSY1VjNjN4M0lGSCtp?=
 =?utf-8?B?Z0I3TzNKMFRvNVBjVzhMWTRGQ0xVSHZ3dkQ2MGdYQkIzYXYxRG5ZTHhGQkNN?=
 =?utf-8?B?RmgvUVo4cDhsV0VpZy91K0ROUWR4RFdWWGhUb0txR3pQeXJWdGxnVUVZMW03?=
 =?utf-8?B?QktFbmJOa2IyVWx3VkJURjRVT0I1SHBra09kc2ZhWWlrT25VU3g2WXNqVGRh?=
 =?utf-8?B?cmk5SEthOUdqN2FhNlBiQVZ4eC9GQUU4RnAvNDNGS3JvY25XVTlEWS91c041?=
 =?utf-8?B?Y3h6TWZTWnhUaWhqTHFKRWZYUlRXc1NZR3NRSzgydE1QMmNoK3k5TkZ2NGNa?=
 =?utf-8?B?djFqU2JPNlVGR0VsWm84Y3NmVGZLWmgwdUFtK0xaeEZkby93M3VoUkVkK1dp?=
 =?utf-8?B?MEZVQnd4QUVMMzBOczhKRHVGUGNUWkdKRFMrVGJRVnBOSi9DK3lIamRKM1Jy?=
 =?utf-8?B?SnM5bkk1dHBVNG9tbkxCdXBuZWcycDhJMWkweWRxd2dKenFsTExsYUxwODc2?=
 =?utf-8?B?alNWeEZkTksrbHc1QkxJME9mbHMzUC8ydnNab3JyMEFXcnk3cHd3RkhRbjl0?=
 =?utf-8?B?RCtTaXJzUU1oOEZWVjJlS3NpUE1UOGd2MVVVOXc2OTlrNkhlcUhxL2NpSEZD?=
 =?utf-8?B?RVRlMVh2cUoxM1NaY3FvVTBWNHpaSEw4N3hsZURVZ1hDTi9YOGpMbjhrbHlV?=
 =?utf-8?B?UnU5NXkyVWlkQVIwNjhRWFlaMGJvYjV4T3BRNTJuYzhhTFhHYkxoaGZkWWNO?=
 =?utf-8?B?R1lla3gwWnFzRFkxRHVvUVR4UTA1ampZb1Z0d1JTdEd3NGJ3LzI0b2ZySUdG?=
 =?utf-8?B?N21PR2N4ZGJrUys1RTBDVFRJTjFITmlRRzVvSlJQZzhndnAyVjhZNTM3VHVQ?=
 =?utf-8?B?bEJxenVqeXFuUkNTS2JBYkNhQmZkZDBDU3Mxc0tUSkRkOGh6eUpqeHJ3a1BB?=
 =?utf-8?B?dm9aM2pmVmE5ay82b0NrdFdXcUJtMFFkMytqTERLNk5ZaG5Yc3Y3N25jNlZP?=
 =?utf-8?B?Vk0rZWlEVDBiUml1NUNVSk81OExmOU1qRUFDN0xsZDVtSStyMXFsUml6ZjZL?=
 =?utf-8?B?Rmp4eXJQc2MvRitsUzZlaHdrZkU4VlZHMzlKaEZkWDNiTlZvRlZSNmJLbG1C?=
 =?utf-8?B?enR6Skx2TjB6SXlSMmNqV0o1UUVoNWw1Q25NbCtJZFlpdC92b2hrNFNZRW5O?=
 =?utf-8?B?Z01JUTJYbERwd3I1S3hScnZpMDJvZ0ZlMVJ6VUZ5eExBWlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3dZY3JaRTJaSTl5NUVMVUVDMUc1OWlXYmg4ak5IRk9JNTBoZ013SzNzLzVR?=
 =?utf-8?B?UHdZby9EVjlHSVhnMGN0RC9JK2pWRU5ha1BaMEkvZ2NTeGZSakZJNHlxckN6?=
 =?utf-8?B?QndVMXVjL0NVam03OFUzeDlWZm9ScGo2ZEw3SHVkczJZMU52ODBGNXJMTFlv?=
 =?utf-8?B?c0k1MitJM0hkeXV3OXArTFUzUmpmdWF3OWFaK3ZoQUswSmtpaENKVCtmdnFG?=
 =?utf-8?B?V0lUQk5MM1dsTFVyMTliUnRlODZSaWRSRFFpV2pGbU05TktDdE92QXV2YkJM?=
 =?utf-8?B?Y0N4cElLa3g5UVJvKzNWeVozenBuRk13cUlPR0RQeG5LajFSeE55dmJ3a3Jx?=
 =?utf-8?B?Z0pBaXBlRlBTUERiaDFncitNcnpnWmJydWZjQ0M1WVorWlBmQ1RYYXpHV3hi?=
 =?utf-8?B?UHZCY3dNWEZjMG9WN2tWSEpRR3lCRHpWQm1xS2FEY0dSVFh4ZzRWRnNHL2hQ?=
 =?utf-8?B?cFRtNGlQTG9rZWlLbU15bVU3T0NaM2ROdHo0alpQTUZQWG5pN2crcVBOR0hL?=
 =?utf-8?B?SkhialZSeEtXVEs2M01RR3dVQWdhYkZBMnRERktIVkNhV0lWVk93UkF5T0Jj?=
 =?utf-8?B?TXpucSt5NHNaZnhXOGtqKzArTGZYZFVIYjI1SkE5dzdRT05QWkJRam5oQmFo?=
 =?utf-8?B?T01yL3k5ZVBzNitHa29uKzhuMllhZktwRzU2bkxQOHJPSVNRK3FuS0pYK0RJ?=
 =?utf-8?B?dDUxdXRvd2JkRytMZk83c1Z5bXY5SGo4cTlkNWpJNmlFbFJ2U0EyMnJhS3Ev?=
 =?utf-8?B?T1hMd0FJbmJ5V0p2WCtHNGZERFc2SEtyYndUdC93SnY4OVA4QVpLZDhJSU1Y?=
 =?utf-8?B?N2ZIeVIreWtmZFhFVjFlUlV4TGMycjFld1ZubDZGN2JlMGRvbmhEanpQcVFh?=
 =?utf-8?B?cUFYZ2ROUE1BV3BGZXhPdXdjOFp2OEMyS2RLNkJod3dtNzQ3bEMzTC82Y1pl?=
 =?utf-8?B?TzNzSTY3dVZVZzQrNnUrTTBxVm1meTZZT1JzZWkyYWZ3VnFRTGVPNWYzVE8r?=
 =?utf-8?B?MzN6dW54aFNDTU1VbDRRU3RSMDEzT1dhbklzMHNURVh1YmpZU1JYYUJlR2N4?=
 =?utf-8?B?TkFQZDhuTFY3eVV4Y0xiVW9sYlpEZGZsZDNDaDhUWjluVWRocDQ5QmpZOFl4?=
 =?utf-8?B?YkJLM0JuNU1YbkxNMXZiaXRteXpaZldCbjlBMGJyankvQll4a0xoK2k2Vi9T?=
 =?utf-8?B?NVpQWVhNZ2dQK2d6VDlKajQzSTNNdWJGUEpqaWJwVkdEelRUNnhwb2JRdlJI?=
 =?utf-8?B?QVN2MXlKQ0RKV0dobXNidkJGOEljcmhYQ3lsRkcwOVRiRUZwM21sRkhMWFFp?=
 =?utf-8?B?NkdnTEphTnBmY0Z4QmJZa3JETHlqa2xXUWNCV0ovaEFlYVJEUnRmVmFHckxH?=
 =?utf-8?B?RGthQnhSVnJJUWtFQVFnRVdXN1ZsNW0xNEZVZmRjb1djd1VNWG9IU1JxSUlK?=
 =?utf-8?B?S1lKTDZRdzhaMDMzZjhrUTVwSU0xekhiM3F1NU5TY21jYjJhcTJXZklJc21j?=
 =?utf-8?B?S0o2WHQ1Q04xUWxJYzVDN1ROSkx6c3lrb0lEaTMvQnhVMDMwWWFJMHFwT2ta?=
 =?utf-8?B?aERKOUZ4R25LQUtEM3EvMTdqZEtzcW5wVFB1ZmJxZlpWQXpwZjhIc3c2UkVO?=
 =?utf-8?B?ZGxHbWlERk5qZTlRVi9wbkZibXBESVp0a2h5eXpwMldPN1VWOUhMNHlzM3pL?=
 =?utf-8?B?K0RXOUw1WmxGWU8wa1N4c0dCUy84RlFYaWJHNHZPN2l4cjZwUExuL3h1UVVu?=
 =?utf-8?B?Z2ZPV2l6U3MyUUZjam40TEpjWWpYRWRRRG9wd21vQkt1Q3dvdHd2L0xCWVdj?=
 =?utf-8?B?SlZCZFF3Y21hSDVUcGpuVmEreXpHcFJUakRjT1hXZXF6VHB1dVpPZmM5UEdG?=
 =?utf-8?B?ejVYVmlGaGpocnVQcXMvNDB5R3JVR291K29ybnlVMWVLbXJ0TVVwcHpEeFVU?=
 =?utf-8?B?Q0JvZjdyWExMR1dpb1d0TEU3c0habDk1V1VDeTNSUFFjVGZNRTZSdHhEV0FV?=
 =?utf-8?B?QnA0bG43ZmFTUlQvVFloNDc4SkZ6OFMzWlNaa1d3WXV4YWtpMkxkZXVnZTFY?=
 =?utf-8?B?cU9yN2FIdHRvRHRpRk5oWFZJM1hIckhTVHcrZzVZQ3JTclVoNFNGdVo1bWV2?=
 =?utf-8?Q?LtS+FsUQapgGScWz8cxSMB4LR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1c0a9c-c7c9-4aa4-d712-08dd18338d84
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 09:26:25.2962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7mW+OYpOJdl9HDhesaDwWk7CTZTDY2inhSKqs+Rj6BoZgvw2f7/HAj64pFeh2/RKVyeDgjf79fV8nekYMqxRMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB6020
X-Proofpoint-ORIG-GUID: vbl4Ax1I8kJF-0FRAedaLbGONfMCeYgL
X-Proofpoint-GUID: vbl4Ax1I8kJF-0FRAedaLbGONfMCeYgL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiBTdW5kYXksIERlY2VtYmVyIDgsIDIwMjQgODoxMSBBTQ0K
PiBUbzogU2FpIEtyaXNobmEgR2FqdWxhIDxzYWlrcmlzaG5hZ0BtYXJ2ZWxsLmNvbT4NCj4gQ2M6
IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207IHBhYmVuaUByZWRoYXQu
Y29tOw0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBTdW5pbCBLb3Z2dXJpIEdvdXRoYW0NCj4gPHNnb3V0aGFtQG1hcnZlbGwuY29tPjsgR2Vl
dGhhc293amFueWEgQWt1bGEgPGdha3VsYUBtYXJ2ZWxsLmNvbT47DQo+IExpbnUgQ2hlcmlhbiA8
bGNoZXJpYW5AbWFydmVsbC5jb20+OyBKZXJpbiBKYWNvYiA8amVyaW5qQG1hcnZlbGwuY29tPjsN
Cj4gSGFyaXByYXNhZCBLZWxhbSA8aGtlbGFtQG1hcnZlbGwuY29tPjsgU3ViYmFyYXlhIFN1bmRl
ZXAgQmhhdHRhDQo+IDxzYmhhdHRhQG1hcnZlbGwuY29tPjsgYW5kcmV3K25ldGRldkBsdW5uLmNo
OyBrYWxlc2gtDQo+IGFuYWtrdXIucHVyYXlpbEBicm9hZGNvbS5jb20NCj4gU3ViamVjdDogUmU6
IFtuZXQtbmV4dCBQQVRDSCB2NSAyLzZdIG9jdGVvbnR4Mi1hZjogQ04yMGsgYmFzaWMNCj4gbWJv
eCBvcGVyYXRpb25zIGFuZCBzdHJ1Y3R1cmVzDQo+IA0KPiBPbiBXZWQsIDQgRGVjIDIwMjQgMTk6
4oCKMzg64oCKMTcgKzA1MzAgU2FpIEtyaXNobmEgd3JvdGU6ID4gLSByZXQgPQ0KPiByZXF1ZXN0
X2lycShwY2lfaXJxX3ZlY3RvcihydnUtPnBkZXYsIFJWVV9BRl9JTlRfVkVDX01CT1gpLCA+IC0N
Cj4gcnZ1X21ib3hfcGZfaW50cl9oYW5kbGVyLCAwLCA+IC0gJnJ2dS0+aXJxX25hbWVbUlZVX0FG
X0lOVF9WRUNfTUJPWCAqDQo+IE5BTUVfU0laRV0sIHJ2dSk7ID4gKyANCj4gT24gV2VkLCA0IERl
YyAyMDI0IDE5OjM4OjE3ICswNTMwIFNhaSBLcmlzaG5hIHdyb3RlOg0KPiA+IC0JcmV0ID0gcmVx
dWVzdF9pcnEocGNpX2lycV92ZWN0b3IocnZ1LT5wZGV2LA0KPiBSVlVfQUZfSU5UX1ZFQ19NQk9Y
KSwNCj4gPiAtCQkJICBydnVfbWJveF9wZl9pbnRyX2hhbmRsZXIsIDAsDQo+ID4gLQkJCSAgJnJ2
dS0+aXJxX25hbWVbUlZVX0FGX0lOVF9WRUNfTUJPWCAqDQo+IE5BTUVfU0laRV0sIHJ2dSk7DQo+
ID4gKwlyZXQgPSByZXF1ZXN0X2lycShwY2lfaXJxX3ZlY3Rvcg0KPiA+ICsJCQkgIChydnUtPnBk
ZXYsIFJWVV9BRl9JTlRfVkVDX01CT1gpLA0KPiA+ICsJCQkgIHJ2dS0+bmdfcnZ1LT5ydnVfbWJv
eF9vcHMtPnBmX2ludHJfaGFuZGxlciwgMCwNCj4gPiArCQkJICAmcnZ1LT5pcnFfbmFtZVtSVlVf
QUZfSU5UX1ZFQ19NQk9YICoNCj4gPiArCQkJICBOQU1FX1NJWkVdLCBydnUpOw0KPiANCj4gWW91
J3JlIGJyZWFraW5nIHRoZXNlIGxpbmVzIGluIHZlcnkgc3RyYW5nZSB3YXkuIEFGQUlDVCB0aGV5
IGZpdCBpbg0KPiA4MCBjaGFycy4NCg0KQWNrLCB3aWxsIHN1Ym1pdCBWNiBwYXRjaCBzZXQgd2l0
aCB0aGUgc3VnZ2VzdGVkIGNoYW5nZXMuDQoNClRoYW5rcywNClNhaQ0K

