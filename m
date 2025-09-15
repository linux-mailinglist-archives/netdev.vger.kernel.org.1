Return-Path: <netdev+bounces-222962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0F6B57495
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 11:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2156A4437F4
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 09:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30062F39AB;
	Mon, 15 Sep 2025 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Rpe6RteS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4F82EFD98;
	Mon, 15 Sep 2025 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927882; cv=fail; b=b4BCBDRf4TeHB4y5erxi23kfpkHeGMr5jNEM1nUEGtqSZ35MADzI9dvCJz/SVx53MQ3UOf9+kP/LJzPnbKMEVUzZ3xeJSpeAKnsa0hI0myUAwpAvy6L4AffikAZwnXtjaB1m1GghInZL3p5EVHwP/YaWaIDvwfijcxFW9RIsjNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927882; c=relaxed/simple;
	bh=QQlyoJJJeFhnNUltHfxnFZP0logxEHL7+IQr0tOzY8M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uujKV97p/sesxOgFPK8JlgJhUXKm5KmkXqmK7x0VIl/v5jxQVJpqE0N1cgUvyAyTDs51XQQRd1OfF/fVkxVhUVBbOqbIxpAN3Dnvp1OTUaW+XBXxO3/MOAxCujy/rQeOZ9k3icjTcnQ7ebSlp3lf1GBAApBhkmswjquIZtz7+a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Rpe6RteS; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EMjYP0010971;
	Mon, 15 Sep 2025 02:17:39 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2132.outbound.protection.outlook.com [40.107.244.132])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49584kas3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 02:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7cdJK+jJgXlQRQ6+HS5eJwSf+hJCA7XrhQmHYBAQ7V+g3WZDjW1sAXWyMXpqMfOudW/I8KzF/wQ3m2XkOioGaMmT9+YKYKfePxTcAF9khM5+vouasdcl50f77d6t+aFfSaBcBU8GGTf06s25r74q5KQnfaerBBzHA2LqLZDCgw8zRk77gs4A+3QFi/XTVRpfTVqZMutNKHtEdf81TKPz+i7sJQMK5TrdJFtp/XGdCNrTKZ1bzXBkrPBXWiRdszs6mR/0+MsVcZH1YrBsMBnKwyGJDziuPM/fdV0EegqFcCCPEYOF4ePWlRR9HDxowdcc7sQGq9nEYfwDLotu5NSUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQlyoJJJeFhnNUltHfxnFZP0logxEHL7+IQr0tOzY8M=;
 b=vN3FebQndY6+Vbv27Of8eo7du5ElVSN2nU4P5b1nXcHkVDrtJvNouF475qjUOd2AmkrFYyceQng4z1fsUyufn1/AzNVUyCyp9cDDadp4Ob6GAQZI6x9SKXAFW4G/TKFokqSp9XadFpdwlZe/DcII455WhIbmNidemsD4TGJMxc3sFL1dfhDXBebN81+zh3VUmkxhvoRLqpHvVDUoRm5irkcPfxPhwAvT4IljrU7Py5hSrxWuyBv3A+XRdE/iyj3RNhhPUBUVA8diV9OHNzOJRRmP4srRySFbATzRnluBhCo8D1wFzq9IjX4VoAgWxOe0AXUPHSQgBxGAogYfYy0hrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQlyoJJJeFhnNUltHfxnFZP0logxEHL7+IQr0tOzY8M=;
 b=Rpe6RteSb98az1L0vWquPqwtrt97/tMgKK8Za7s+tZFtNNr1b7SVBY7HEaycKRc/edL9m9oqrxMLPh9BdMMN2/W4aXflV/NyFR3XwjT3QIIiTkKDdtTnOfxSOWkurwZdP470KPFlm9ugH2q4kSZQNDl68fskBXPRuV7IBcpFURs=
Received: from CO1PR18MB4747.namprd18.prod.outlook.com (2603:10b6:303:ea::11)
 by MN0PR18MB5999.namprd18.prod.outlook.com (2603:10b6:208:4c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 09:17:36 +0000
Received: from CO1PR18MB4747.namprd18.prod.outlook.com
 ([fe80::412f:1737:b585:89d6]) by CO1PR18MB4747.namprd18.prod.outlook.com
 ([fe80::412f:1737:b585:89d6%5]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 09:17:36 +0000
From: Sathesh B Edara <sedara@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Satananda
 Burla <sburla@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        Haseeb Gani <hgani@marvell.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>,
        Shinas Rasheed <srasheed@marvell.com>
Subject: RE: [EXTERNAL] Re: [net PATCH] octeon_ep:fix VF MAC address lifecycle
 handling
Thread-Topic: [EXTERNAL] Re: [net PATCH] octeon_ep:fix VF MAC address
 lifecycle handling
Thread-Index: AQHcIytPs2cyM756WkC88PI+NwzQfLSPx6IAgAQzxGA=
Date: Mon, 15 Sep 2025 09:17:36 +0000
Message-ID:
 <CO1PR18MB47474A8DA6ECB6FFF3A5C02BD815A@CO1PR18MB4747.namprd18.prod.outlook.com>
References: <20250911144933.6703-1-sedara@marvell.com>
 <20250912170214.GB224143@horms.kernel.org>
In-Reply-To: <20250912170214.GB224143@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4747:EE_|MN0PR18MB5999:EE_
x-ms-office365-filtering-correlation-id: 3b49ffa1-ff81-4af7-4a4b-08ddf438b5d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?U1ArSitMZXdydEoxL1dTTnlHTkV2ZUJ6ZFd2azhxcnJINjBSQWJ0akd4eWcv?=
 =?utf-8?B?UlFuNW55TWRlMFBlcE9vbTRCSkQzWGFWQlRDYmUzQmphMTd0L2RBRlJ2OHhD?=
 =?utf-8?B?WUc1MXdyL3pjZzJEQlNSNjUwUUNHQXdWVy9kRnZqaUJFU2RtWjV3S2RnRzBZ?=
 =?utf-8?B?eCtueW0ybGZ2VFJVand2VUJaYTFReGgvVWFtMW1SZkVhNnZKbExuSEVDNjJo?=
 =?utf-8?B?dVJ6SVJjOHpwYmVqc0RPcW9Nd09qZ01xQTE0MXF6bUJ5RnJ3ckxCcjVRWnhM?=
 =?utf-8?B?NXQxa01XSG03bTJvYXJocmdDYi9GeVBDenk3ZXNlYk8rZkhqSzhwNnJ4cWFs?=
 =?utf-8?B?dmp4dEdabTUxMUJnZ0hpTnJUSml0a3lEMzdhbUFlL3RzNVMyWFM4dmQ3R3Nl?=
 =?utf-8?B?cGNKTmZRMXNRc0F6ajZDdTlDNmIvM3JESVVFRldQR3NZSmZGa29MM3JYYTdq?=
 =?utf-8?B?dWU1a1BRSCtpNXNkaUk5TjNaMTM4V1A2Uko2NHk2bzkzWDBWTnIybWw4WkxB?=
 =?utf-8?B?RGZTRUFYeXlvdGlMTXp6TGwwV3NxSnJOQ1N2cTBNUFgxM0dHN3pHa0xsZTJ3?=
 =?utf-8?B?WXRhSG1scndpeldMOEpIVE42YlpVeHdPNEtuMW1WZG1qSWJmbmtTeldxYWow?=
 =?utf-8?B?bjlOeVF6ZkU4TzI4cC9DdlBMT3l2WlJHakg4SHU4aThkYVBmMGR1OG9SNDV6?=
 =?utf-8?B?aGw1OGJSWE5QODR0UEZ2WGRTMk05ZUgvVStXQ3lJeFNuNi9XTmNjbUVlcTFp?=
 =?utf-8?B?eVZzaW9FcHVNQXdubzM2S0IzdEZ2cUluVTJYUHBpYS9rM1JsRHFxWmVCOEVI?=
 =?utf-8?B?emoxeU1kRjFVTVo5M3N6TDcwbGd4MkhoSmRGUlByUGtMRW1MRUt2QXNQeGN5?=
 =?utf-8?B?d0pmS0JPWHB1VEFLWUkrMlZUMUFxRXV1YVYrSGpVazZ0aEI5T3VqeHF4aUox?=
 =?utf-8?B?akNyNXBVZ3hicTlXdFBDbjdMbEdzRGRuVHVNaUY5Sm1uVzFES2dqVjY3ajdJ?=
 =?utf-8?B?NzI5aXZiY1Jrbkp4NHlMNEswSEJGVXhLY3RYY0s3N0NodEx1Mk1ZQkQ3ME9B?=
 =?utf-8?B?bllLTzI3cWxZemFPR2F2NzdKS2V6Y28vM0FLR0NORkFHbmhqVlQwRXZ3a0tI?=
 =?utf-8?B?bjQzVkpVR3RLbjVqeU1USTRGUVZSbGNQVGxYRkg2YUpuV3U2NFRJTVU5dVV5?=
 =?utf-8?B?WWdaN21JbTRIbWZDYUw2MllIWHdpcUpTdVh1YlJSL1NFT3drWlR2WUliY0pa?=
 =?utf-8?B?VzV4TTg5eHA1bndMa1UvS1RYSDJjY1FRS2x3WU50MVBBZm9FdWpUMW1ac1BX?=
 =?utf-8?B?OTBMUmlMbC8rYktwSVpkcUZ2eXBFRTAvWFUycmd5OTB5Yy9TSzUvU01OVWp4?=
 =?utf-8?B?ZnFybi9GbHQ5UFF1SVpVU21zaFJhZHFrTktNQzZQdVVCMUhyMVFpU0IreFlv?=
 =?utf-8?B?ek56ZXArV0Yxc0NVdzdmRDZ0c3FJTXA5dU42S2FTaVZPdzhkQ1AzbDJLRHJN?=
 =?utf-8?B?b2g5Szl5L3JmamxvZHhBeDN1TjVsL0ZPenJFNi9rTXZlZzVXZXN2SVU3NmJT?=
 =?utf-8?B?dHk5bHgzekNPR1EwaFo0QjlWTzk4aEpkbnlvQ081RVErZWlzYmpnMXNlSmd0?=
 =?utf-8?B?NndYNFVJQkNpRngzY1MvMTZURVU1bkFSOEpzMzB4UmVHcFVuZGxqYU9aeXlP?=
 =?utf-8?B?dCs5RjU1ZUJtOXdCcHVwYTFFRCtJY25QTlhmaU5EdUh2WW45M0F1TnpoWE5q?=
 =?utf-8?B?YmpkeTU0MEt0M1Z4NWwzSW9XcGRtUWJyMjdleFBMKzNxZzlSWXBZQTVQK3Qr?=
 =?utf-8?B?aGo2aTlJR1hFV0F3WC9kSWE2MEZLZzBGSmlmUVdvWStQN1N5MVpEK2poLzJi?=
 =?utf-8?B?ZjhQU3R6VnBaNTN0RUFsWXY5dy9VT1cvdG5STjhGSXdkb3dGVUVsSG11dlZC?=
 =?utf-8?B?Rks3cGNLU3NIMERXTndseFpJaEwrTmdPZ0dxT3JDeUd1cTFmeU5KZ2FTOEFj?=
 =?utf-8?Q?iIJZxke/SBgWChJ4v8VuvgXlJw/55s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4747.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eHNQLzNaenBRQ0ZvVWNzdFIzVVQ2Qm93a1RydkMrMm1qakJTeDhFMnpLN3FS?=
 =?utf-8?B?Y3JmNllIQWRQcGlvRE1acmQ3U3BtcDBPRFVIQlRJVWNhdkRVV1BhUUhLbitM?=
 =?utf-8?B?YXpvOUR3YnlETWhxN1JQVzcvMEFDaVVvaHFzN2xtODhucm43MHRIVlRodVli?=
 =?utf-8?B?cUdYQ1YzNUZXY1JRaCtFS3UvbUJKcHYyVVk5aStBYkE2VVMvZm1MVEZ2aE9V?=
 =?utf-8?B?d0tGWmlhZk91WEhZRTU3ME1qMnNqUVg3empMb1F3QVRSZDc3ckZNK1Q4V3py?=
 =?utf-8?B?UThYWmVqTTlOOWpPRU5NSmJhUUFSOExzTytaOGJIV0kvRjhZeEUvNlFVaHFC?=
 =?utf-8?B?QkZYWU5qcDhFU2dteXRkckNWbjhXYURNMDJnMDhNT3Y5TzRJOG51bXRETkJD?=
 =?utf-8?B?RGhmVnFHeDNvcWlhOFIwaHkvZzdaK2R4YjZkbUNnZ2JxWmwyMlEycDNQaWhW?=
 =?utf-8?B?TEg4czQ1eUdOSFVadWZWelJHaXE3S3dRaEZmTS9Jc3RvdTBYcFdjZFl6bzUw?=
 =?utf-8?B?RSsvRm9ncnUybGpTY0VjcTZVVGJYTXpseDhlQ0RMZXhzSVFpU1Z2ZmtqOHQr?=
 =?utf-8?B?ME1Mak90WXlXb1d3L2liR2MrTVZZQUlVTnVHbitZbVFad1BhZDRYZ1NwbEZr?=
 =?utf-8?B?YWtmSDNxeHhRS0hnOG1xLzdPaVFNWU9BSTgrOVlkTDRnUUd6b0p0SlVoblQz?=
 =?utf-8?B?NFl1Z1YyWFloWExOZ3VMN3pYV0t6RWpId0tOclJQVW5UY1I4Qmg4WmZIQ21S?=
 =?utf-8?B?Rlg2Szg3SEhwbG1KUTlWbW0yVElOZW8rSXpaT2NQWk1SMmlyZkJsRnZ0Q1lh?=
 =?utf-8?B?QVczRFJFcksxQTUxeUxQWUFkRksySWxVOWxWb2cxcXZQMU5UdTQ3bXY2ckM0?=
 =?utf-8?B?Z3I3ZC91YkxPc3lpaXZ5ck1menBUakFXRzhGK1RGdUVqV2ttYlg4bXgzMW1N?=
 =?utf-8?B?aHdjbXZZOUNkUlF6UEJyUEJsM1JkTW1IVENGalZuaUF3WThYejAzVGphTTFk?=
 =?utf-8?B?cnVaREdRR2k3RDVlcGRrdit1dVVMbi85M0VnL0x3SFNjcTVsa0lQajBRWjAw?=
 =?utf-8?B?cXVPTFN4UVF6NFE5dHNCdC9Ra0RjM2JYSnBMTzI5bjRwTWlRNml6Wkc1QURI?=
 =?utf-8?B?TXdmdTlubUVkMnd4UWNoYzdOOC8yMG95NXhSaU5OSFFKUWcvWEZ0cmx3TWdy?=
 =?utf-8?B?RWlUa1dwS2tlbjNEblpvRU13N016a2FwTGh6dU55SXdPZTVJc013RFZUMnJX?=
 =?utf-8?B?Y3lWdVIyZ3JMRDcybU5uMWRSUEY2QlFwdU9hNHBPeHEvSjNCS1QzUjhwbHZw?=
 =?utf-8?B?VDdHeFJUUGtIVXBDcmp3bXRIcm5pS1RKVy80S3pVVVJuU0R3RFpab3BXNHpT?=
 =?utf-8?B?N1Q3bDFUcnZadnJSU1FrQnBBUHY4dk1XOGxzamV4MlJpNUNwUm9Pbmg1Y0Z1?=
 =?utf-8?B?Yy9iUWo0b3pFNU9sSVdOdkJCcy90TG9ldFZSK2FLYWF2bFBXVTVYT1VIQlpp?=
 =?utf-8?B?ZUJNUzFkcG5yNGJiaEJnaVlJZXBzcVdEUndtVGEraCtVZjBwMHFtRjBibFA0?=
 =?utf-8?B?cUlhUHBYaEc5ajVNK0ZKUWlEa21YRGdNZXp2YjlpRTRmdTBkdWJWN1JKNG9K?=
 =?utf-8?B?K0RRdFNpTXlMR3JTNHZaL25Mang0MXhhcXBxZFhmZXpkYnkvL1NvSGtaMndt?=
 =?utf-8?B?NE02U0NkSUl6Z01HTDJFYWNLKytna3BGeUUwSkliV2YreTJ4aWlWMVlaMEls?=
 =?utf-8?B?aWtJRHorUk9KQnNQN2UzL3lSek5CbmwweUJWS0RMY3RVemZKemNnMFJVTHhm?=
 =?utf-8?B?YWJhZm9Eb3F6MG56QVU3aS9DdkY1TFdkVkNMSlF0MXNuYmZKa0xCWFFFRmNI?=
 =?utf-8?B?SnpsM3RtUmFrblBYZUVncUVMaWlnTEtXZHJudEt4RVduc0VWNjlMaFU2eHZT?=
 =?utf-8?B?bzY5T1dBQWdmWTAxQStyR3ZOSyszTDMxa3ZobDZ1dXB6Wkt0cWUxZVN3alhl?=
 =?utf-8?B?ZUxjT01SbXB1NXZleXE2TXZhVkQ5dm5FMmtWaUNDL3AvZnZPWUtDd1RYUGEy?=
 =?utf-8?B?UlROajVsamFkT0VJVkt3ejV2cUdoY01BV2RUaG1DNVBHc1NhVTJBZldxWlFl?=
 =?utf-8?Q?KGLQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4747.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b49ffa1-ff81-4af7-4a4b-08ddf438b5d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 09:17:36.2576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XUcPkNAyadbfcQ8fyg8KvcFqRyUSiTSaUlEwINDAGDV1BRdQAVx5Pj4znKgCjlZc1gmj+zGgm2JGXvdAehJ+fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR18MB5999
X-Proofpoint-ORIG-GUID: o_uDSJaRT5qAbPsdVhkDd28kOQq9U9Ku
X-Authority-Analysis: v=2.4 cv=PpmTbxM3 c=1 sm=1 tr=0 ts=68c7d9b3 cx=c_pps a=od1JoUVrHDi6lJCCaeHqzw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=-AAbraWEqlQA:10 a=Ci_g7HwL517mM9nHiiEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: o_uDSJaRT5qAbPsdVhkDd28kOQq9U9Ku
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDExMiBTYWx0ZWRfX+EBucFmNcFRq 8fcrJVTMd0S98WevToAdE+kjKkdPhRG+NXIgBh9lovtm17nSO5r6ViPWW4CPEydPGEGX9OH5VQG jLzpawC1pqXGhAJUuN3FpN3XkkmmGK0hs7GUGAX5+ljys3VNNSlMxELvYxp/ELujahuXOpqpGj7
 MgTAt2fzLcKeRWCiOh7TjjccY2cy1LReB0q0d3jBbV3hhp6UomqPjkc6fgAbtk9AAfQSvhdpH0b f5EawHHCz4CnrC7MgLBK1DbiUPt/eqKKhDdoHNvnBDEMMf41nn6EQtyxreJ1nZt4p34f2WUQvJe 2/ah0hPyeYvkYt5/jKuYUh+5bELCod7C4ji/GtdSmyUy901Q3bFAW538kzs6GBiI8A1O5Aao1/X fMvnhWj6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_03,2025-09-12_01,2025-03-28_01

DQoNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb25f
ZXAvb2N0ZXBfcGZ2Zl9tYm94LmMNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwv
b2N0ZW9uX2VwL29jdGVwX3BmdmZfbWJveC5jDQo+ID4gaW5kZXggZWJlY2RkMjlmM2JkLi4wODY3
ZmFiNjFiMTkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9v
Y3Rlb25fZXAvb2N0ZXBfcGZ2Zl9tYm94LmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9tYXJ2ZWxsL29jdGVvbl9lcC9vY3RlcF9wZnZmX21ib3guYw0KPiA+IEBAIC0xOTYsNiArMTk2
LDcgQEAgc3RhdGljIHZvaWQgb2N0ZXBfcGZ2Zl9nZXRfbWFjX2FkZHIoc3RydWN0DQo+IG9jdGVw
X2RldmljZSAqb2N0LCAgdTMyIHZmX2lkLA0KPiA+ICAJCQl2Zl9pZCk7DQo+ID4gIAkJcmV0dXJu
Ow0KPiA+ICAJfQ0KPiA+ICsJZXRoZXJfYWRkcl9jb3B5KG9jdC0+dmZfaW5mb1t2Zl9pZF0ubWFj
X2FkZHIsDQo+ID4gK3JzcC0+c19zZXRfbWFjLm1hY19hZGRyKTsNCj4gPiAgCXJzcC0+c19zZXRf
bWFjLnR5cGUgPSBPQ1RFUF9QRlZGX01CT1hfVFlQRV9SU1BfQUNLOyAgfQ0KPiA+DQo+ID4gQEAg
LTIwNSw2ICsyMDYsOCBAQCBzdGF0aWMgdm9pZCBvY3RlcF9wZnZmX2Rldl9yZW1vdmUoc3RydWN0
DQo+ID4gb2N0ZXBfZGV2aWNlICpvY3QsICB1MzIgdmZfaWQsICB7DQo+ID4gIAlpbnQgZXJyOw0K
PiA+DQo+ID4gKwkvKiBSZXNldCBWRi1zcGVjaWZpYyBpbmZvcm1hdGlvbiBtYWludGFpbmVkIGJ5
IHRoZSBQRiAqLw0KPiA+ICsJbWVtc2V0KCZvY3QtPnZmX2luZm9bdmZfaWRdLCAwLCBzaXplb2Yo
c3RydWN0IG9jdGVwX3BmdmZfaW5mbykpOw0KPiANCj4gSGkgU2F0aGVzaCwNCj4gDQo+IENhbiB0
aGUgZm9sbG93aW5nIGJlIHVzZWQgaGVyZT8NCj4gKGNvbXBsZXRlbHkgdW50ZXN0ZWQpDQo+IA0K
PiAJZXRoX3plcm9fYWRkcihvY3QtPnZmX2luZm9bdmZfaWRdLm1hY19hZGRyKTsNCj4gDQo+IE9y
IGRvZXMgbW9yZSBvZiBvY3QtPnZmX2luZm9bdmZfaWRdIG5lZWQgdG8gYmUgcmVzZXQ/DQoNCkhp
IFNpbW9uLA0KVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRzLg0KWWVzLCBpbiBhZGRpdGlvbiB0
byBjbGVhcmluZyB0aGUgTUFDIGFkZHJlc3MsIHdlIGFsc28gbmVlZCB0byByZXNldCBvdGhlciBm
aWVsZHMgd2l0aGluIG9jdC0+dmZfaW5mb1t2Zl9pZF0gdG8gZnVsbHkgY2xlYW4gdXAgdGhlIFZG
LXNwZWNpZmljIHN0YXRlIG1haW50YWluZWQgYXQgdGhlIFBGIGxldmVsLg0KVGhpcyBlbnN1cmVz
IHRoYXQgYWxsIFZGLXJlbGF0ZWQgY29uZmlndXJhdGlvbiBhbmQgcnVudGltZSBkYXRhIGFyZSBw
cm9wZXJseSBjbGVhcmVkIHdoZW4gdGhlIFZGIGlzIHJlbW92ZWQuDQoNClRoYW5rcywNClNhdGhl
c2gNCg==

