Return-Path: <netdev+bounces-289298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OsIOTQRDGr6VQUAu9opvQ
	(envelope-from <netdev+bounces-289298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:28:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E468957913E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E58BF304534A
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 07:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898513CF02E;
	Tue, 19 May 2026 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="nQHhfAjP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C393CF66A;
	Tue, 19 May 2026 07:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779175309; cv=fail; b=Ga9oMPkzvCGL4ETzlaxmiJ0VsjlvtoslMkMoscCcXku+iSTAKwz0/6bo1pU+XsJuJTCDlUL5E8UNe2Ncm/ygdEKPR4S/MfxznkzN/k8Lphm5Tk9YS3R5T5HgT1fk3x4KuCQbXqJUyu4e70yCqbJe5IuO4Ghl3LsqS8aLlzLu+H4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779175309; c=relaxed/simple;
	bh=Gu5eI/2zWOz1dCdEFpLa7ppoLiPVahDYqQgOOpNfhHI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nNbtw5UdBJUpwXk1/GH+XizoHRV9B/R1XfMoEZDat5Mn2zuMpACvRljex+ugjDo56xaMTGx3FEkSjxZthmnvJWHwQZrutHVqfJeHMBhiiGhubnQjkOZb+4zZu3s/A4OrVXt0U3Vd5x50nCYIT3o4FhSN2RYXO1Qrghv3JwLMPjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=nQHhfAjP; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J6qfAQ3008990;
	Tue, 19 May 2026 00:21:29 -0700
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023075.outbound.protection.outlook.com [40.93.196.75])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e8jyw83px-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 00:21:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVtSlP6JKTSx8ZFNkaI62ys/BB+NZLSV468cmBYHV+Ehz6Xb14TceZ7g2fSKYs09U+x3665QbDNYQrtx/sFdCAL1xBbRoY+RizwAcn74ggk+phSGay29qMVEzC1AIQ/cYdq/dktSlMYE7sU40dViBe6KUGfL5Bpwk6pomw1NHY4bAIpjPmn8QZ1qfqplmFlBYVtQ/V18qIxyG0IJhIudofX6ppv2OT3J9+EY1okRkyMHHid2VqDiZKU2P1BLO+9/c9uY5MT7M6Yg2IA03r9Cpxo8r4qa8hOPE07RpknyuSFT3U7YREP3Nf2B1jdJTyAj38vSPB3howrH5ZBNqSPPIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gu5eI/2zWOz1dCdEFpLa7ppoLiPVahDYqQgOOpNfhHI=;
 b=qRduT8OP0WuHc+Kp9ODWn5v+skHFDOw8agT/dn3cBAxMXY5ZMCO/eHlNom4BTiEeYb8JldexwXB/shOLS0Eky35kWeHE7OKjymClIyjwcvqhKulcWUJG2Lc6qwbqIYeuw1IaNPLOzwRrQVUYtYQ/VDqRZsVykIXHA3pQntXo+K5A3SCUEk+9mwzfZasS73OGk3H/Xf1MOWTEEFVtrOyO2Tdsv8DiQYaTGLPwlU73mCkC0hdt1L1m2ygtePl4DZ/PsCOqTnAp1gdrLQ4+E9XnPxl4Mis5CpwFuc8WyPfRK65S7K0ejAsw6XJDPeRHspqvseJ5nqoDXw9Dfu835yxNrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gu5eI/2zWOz1dCdEFpLa7ppoLiPVahDYqQgOOpNfhHI=;
 b=nQHhfAjPkRpnTPhLODgCq5eWHfduVTlbrQj+En0BVOQZW/vQhxsk2DWomYJH49+vrhIoWCTcVy4jCy6lmBwvibH2qlufiQKQxEGVioK9tWWMGYBYs6a500D7bkSX8uZK7y+Kfh71P7P4d+QE1BI4uLkk+Dcj4Hk/pbJJUY0YFlw=
Received: from SA1PR18MB4600.namprd18.prod.outlook.com (2603:10b6:806:1d3::7)
 by MW4PR18MB5063.namprd18.prod.outlook.com (2603:10b6:303:1ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 07:21:24 +0000
Received: from SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9]) by SA1PR18MB4600.namprd18.prod.outlook.com
 ([fe80::a9ff:1d54:811d:cff9%6]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 07:21:24 +0000
From: "Sukhdeep Soni [C]" <sukhdeeps@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Igor Russkikh <irusskikh@marvell.com>,
        Egor Pomozov
	<epomozov@marvell.com>,
        "richardcochran@gmail.com"
	<richardcochran@gmail.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v2 6/9] net: atlantic: implement
 AQC113 L2/L3/L4 RX filter management filter management management
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v2 6/9] net: atlantic: implement
 AQC113 L2/L3/L4 RX filter management filter management management
Thread-Index: AQHc3uLCWQ8+maS710uc8M18ABHFBbYKL5wAgArPUaA=
Date: Tue, 19 May 2026 07:21:24 +0000
Message-ID:
 <SA1PR18MB460092172DD3174444B3EE2ABA002@SA1PR18MB4600.namprd18.prod.outlook.com>
References: <20260506135706.2834-1-sukhdeeps@marvell.com>
 <20260508120156.3060-1-sukhdeeps@marvell.com>
 <20260508120156.3060-7-sukhdeeps@marvell.com>
 <e6e4737e-e178-4d1a-a8d1-a45cea1db3a5@redhat.com>
In-Reply-To: <e6e4737e-e178-4d1a-a8d1-a45cea1db3a5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4600:EE_|MW4PR18MB5063:EE_
x-ms-office365-filtering-correlation-id: 1f814a67-e46a-45ee-1413-08deb5773bf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|11063799003|56012099003|38070700021|22082099003|4143699003|18002099003;
x-microsoft-antispam-message-info:
 so6PGf0RzjupIkBZ1VdoJ50z1i72rN8+pKvnsyNAhnqXr7XUCkxqQ35QD6OE+/qsZJgIdskYJNd6PtiPCy7WnQ1fmu8YlhW7mxXWl/fWisNRVcaNqjtK1O6/3rJpy+DneNMfd2YbbkR5fyK5WzL1qfajYbFPhypECCNKbj5nsmmqIiUoAjZkNXgGeM58xD2JRyYuF3QA1t/o7bEW+t+6N7KOApQSF40HH5TgbZjRsFIkhKb4zKmsU1ZZhVnC+XozeYxR06wQYcDacnVh7ic4rVV+e/Tl8YzsXTFvCFq2dmRCr5RdowItzKwD8vWvgUu2lzwfKqwgjuZtcI3DAhwmZUEYrrf79qltiKkytV194kT200WUexon6tGdARK8mKlDRxGcvxBhRi8QxjwhJCgnvSWeWpfeN6KxVGUJcMY7nMMqA2z777JfvyWTGtcPHIDvn59gT3q4AeepsJ2T8J6bjXpKgsa1ZBFvawgzKcXchEsZQEdxkmJYWy86WlYOSupw3RZu+aTyrbntrx2Vl+VA/x2zG/efLz16UcSzhqi64Fu7XVZ18ja7kgl38RC7vF5YSoTpXGtzrRPk6LhXp3wynPBH6QvlWjYAJWdwSxaUsOi3Dm8BPb73XK3HMUBsl+OPUeAdEVjH/TdrGOPNDycGgx/mlxJY6xZ6yk0P+t7BTQTJ18fY9iiUsP5iETYmUWL+t4j3iqsv69bhgKRmVGmaG/y+e1mbos7/wO+x918wIEgxr0hOG/U7TDqCjgAOJ+OK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4600.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(11063799003)(56012099003)(38070700021)(22082099003)(4143699003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TmpBS3B1L2JkaFZmc25PYkdwc2hURkZkby9odVQyMDMyWnlHbzk2V014MjZU?=
 =?utf-8?B?YzFlc3BaTVNVazJTT2E5ZE5tTEdtMll1VldYaXNhNXdoTEVlcnhnRDlWa2tv?=
 =?utf-8?B?WEJmQ0VrN29RYUtBM29LRzAzYTJGVTE0S3VqczdGY3prWjBNS0Q5N0ZwaEdF?=
 =?utf-8?B?dS8vOWs0Vk5BV0tpYmFEL0QwMXJiWGtYbllXQ1BiNTV5TmhCYzQwb1QwK25I?=
 =?utf-8?B?UGY2Y2Y4OWkxQ0NkdmQrQWZOazlNS1NGQ0YxK1orWk9rRldsMkpqSkpVUHdm?=
 =?utf-8?B?RGw5Rm0vbHVXeFpYcy9UQ3J2dG1MSzJNR2svTDdadDFkSTY5UXpWUS8wbnhz?=
 =?utf-8?B?VnZwNXcrSWd0M0k1b3d4VmNZOFZMOWxPUjhmdEZpQkIzeEZhUXp6VW13Mnd3?=
 =?utf-8?B?SjYwSkR4b2hFR0pWeTRNcUFDNm9ZejJqLzdVNjkvcFVIazlsSkpoNCtNN0RE?=
 =?utf-8?B?d3l0YXBOTDE1K0ZmWWhDZnBlVG53d1hsUDBSZzUvVFJwK0ZoSys4bi9BZmg4?=
 =?utf-8?B?RVRZRmdWWXNhU0NvWDJzSVM2NmpPS3hFd2s3c3pPdnF4WGNBNkJFSlJDbXdN?=
 =?utf-8?B?UWlEa0pscFJqUStZdDk4OS9qeWdRZ1ErS3JDQWdvNDU2endxMjBqTVR2dmlu?=
 =?utf-8?B?eEZLdGdzMmpLUWxlZDdCSFJJQWJNMDAwNHJtNCt0VytTWlRVY3BDbERQRlY2?=
 =?utf-8?B?NE4vdjg5Q0ZCdGJlek85VyttRHhIbEN1bHdPRmljMmZRTm1Jd1U0SzVkOXI3?=
 =?utf-8?B?Rm52MDltQzRLd1NMVjFzNUlKR0VkU0ZmUEdCNnc4ekxTMTQ1VXJhVERNV0hY?=
 =?utf-8?B?TjNLVDlSU3NEdmVYanJ6TWdwcTN2MURkdUdGOXFVV215QUNmQ0RhYmFZdEo5?=
 =?utf-8?B?dXlmS3UwWXAyNGVKR29kZHpWM3ZtbkNaeVRDWk1OQWNsaDFJdWN6U2xvUHhK?=
 =?utf-8?B?OFRuR1FBbU5ncmRpaGJndWdFZFNGcXVVV001UThVV1FqWCtWWW0rd01qU08x?=
 =?utf-8?B?R21ndUlOMjlBbUVTaFZZNEtOTlBIb29JWWh2ZnYzUm91T1ZXQ3B4RncvTWV1?=
 =?utf-8?B?UDRhdDExalNVNHl5a0xTWVFtaXV1TCtnQVRmVnQwTVJVL2ZmWDJLN2FjdVpD?=
 =?utf-8?B?Y3JKWkRtRzV4OWRZSWdYandpOTZNY2hoL2hSY1F6TU04MXR5dHEvcUZkcE85?=
 =?utf-8?B?REJQTWg2Z0lTWktqWEJVUldpNDhrWDJyT2U1Y1ZOWGJtcEJGTDExOU00SGRi?=
 =?utf-8?B?UDBoWUJCUC9Gak9TMWoyd1RVZHJONXVINmN1eGhlcU10R2VKcTlYenBydklK?=
 =?utf-8?B?dzlNVGtnOThqc1MwWnNGaHF0T3JwdzEzUThJd211WTJwV1pYZkJnSlFPV3ZK?=
 =?utf-8?B?bVlxbm1HbDBFaVlNWU0vRC9udzBLdmtoVm1OT1dEcVVNN3FoS05CdFlWZGcy?=
 =?utf-8?B?T1R1YWNLNExKWS9lNmRWall4TmMwcllBV0JOWksxNVdqZTVTT0VhOFZIbHQ1?=
 =?utf-8?B?Wm41OEdkRUQwd0dBUHBwRThzaS9VZXRoSGhteHpOUTFFQ1U2c2lPcXFab09P?=
 =?utf-8?B?SlN1Zy9QUndNSng4ZFFNZ0ZXVFNXbmdhVHBrTzAxSXMwYXdhUGNrMHhUc21k?=
 =?utf-8?B?RDJYb1JXNHVGYmo4aTlFNE1wM1hSQ05uZDBLd2pTUVlpSlo2OEhMVmxMSHZa?=
 =?utf-8?B?VW5weTlKZmRxeFptQWl2VVphTTZNdW1FUTZLd1RuZGx3OHRJcTI3Qks3YmZa?=
 =?utf-8?B?emhjTzNzYVQzOG1LV3p1ZCtpSXNYSkprbUtTa2pETG9KZFJNT2FVait4WnNU?=
 =?utf-8?B?SDdXRjF2SHM5YmFWSExnUXA3ek9KQ0dsbUFqTEo3QWRsS3hrK3FDYWJoY2pJ?=
 =?utf-8?B?STVrZ0k0TlFONWVGdHN4NTJkZVdaZVV6TjJkbXQxYWc2eWl1ZDVveUVlcU5a?=
 =?utf-8?B?Qy9USmd3ZWJLVnVYNmlOTEJ0RnVqRUJKR3Q3T3U5R3l1RUdDZ0RaamNKeDYx?=
 =?utf-8?B?b2d0dUhCbTVLYzZsVEdqZGJiT0JIVzVMYVhQL0VBeUgrZStZRWpQRTFKbk9H?=
 =?utf-8?B?bnlGdmc2TU9qT09OaGVwWldydFI1TVNJcmdmbnZtaUVtY3J1bkJFRTMxdi9x?=
 =?utf-8?B?SW5VVzc1RUEwSUF3NkthNFhWOE9ZQjd2Sk4xS3pDVFp2RDdoVUo0Rno2SGQr?=
 =?utf-8?B?SFJ6ZGhZSHI0MmV3RmQ2dHp0MW5EeVhNa2RpU3VOR2ZpTFA5eUx3eEo2dm9o?=
 =?utf-8?B?QUtaeTBMNEJLNktMTUlRVGREMTlVb1JxYWNMY0Jsamx0K0grWTFTOGYvWGdp?=
 =?utf-8?Q?QtSHxQaokZB6QUy7HN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Ow3XZEKHnstaj5HujeoHjNc2bjuYfgL+Z/5vykdEAiKy4lDysAfBzOSVt5GvE+pnGCnbWvQnAOU0AvQ8NtZVfabTzDpq+bxRmDzAgyna8RG0crW84JhdpSaD0U3nEJpjNr4YB3O4a6tJSU+sXnC8FbPZHNjPzxCXXBnWaeVJ+Gg+asTBk206XpnCeCq7+eKXs0sNTU16EtFv4Kll7rzJpRfsZPSlvlhj6l8qVEG6FfkynX3giQYBeqxL8ziX3zOSZLGT3/L17O4O7BcbgLph/1zjVHJrVwhlFbCz4KxzKDhT8GTr7qkkqNuW8IEORQQZ5rC7jPq5XxqUQ06W2QAbYw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4600.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f814a67-e46a-45ee-1413-08deb5773bf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 07:21:24.4670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SjAnp/Vb9vooK+vWOhcJVTkX3qeAH1d0/0wLL1R+BC9V0YtToMtOU6Dhs0tze9+L50ZYUJAC/BQ4P4a6Ipts7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR18MB5063
X-Proofpoint-GUID: wO_vAzP8jTIcsJHCsarsKVeQthBKrlYg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA3MCBTYWx0ZWRfX2BTgMJ+jqky2
 3rkp0i9IdCloqMJdkBKOwzYlADqJErWvUH3+NtgRZ7PkNuaRjbhtQeL5kmVJ017XrxO4sjf+exH
 e5eaFD/9Bz9c8k8f+57fxFuP5admxOKCr37hUFjKadZaQBg1seSZOZrxtNAT6ola8VcHhDisH3w
 9Kw8uzE/VqegRoBrBiMM8av66oHZUK4cIM0N1T1tRlH5CHPD222ReBx12nCizSxqme63mQPoeLp
 Jf5FRRMGvcCefmHuauy0XGx3HWbH0qJMhjzOplH4I6Ud6BzzEyw2oPYkno71IbVxQnawCm53KLs
 KxEyoLXcg7uQVj9vn3Cr0Su++jtwNUYplleKXModb4bEGqx1gF/B+X4M/qZUiuf46Y5XxaNJZ8y
 n107BM9voiOlQ78nTI9TzQTOkXgLECKxO40v+Z0W/AfkTitQtzIuyC93nGkqDFTdXfM8UXOvcjd
 2iRb7el7mhWMSgk1nZw==
X-Proofpoint-ORIG-GUID: wO_vAzP8jTIcsJHCsarsKVeQthBKrlYg
X-Authority-Analysis: v=2.4 cv=QbNWeMbv c=1 sm=1 tr=0 ts=6a0c0f78 cx=c_pps
 a=ZwnHHYtbhvZyeoWvue1Gvw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=lr1LnH6PHPkJUHyyX3EA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_02,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-289298-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sukhdeeps@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,linux.dev,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E468957913E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gMTIgTWF5IDIwMjYsIFBhb2xvIEFiZW5pIHdyb3RlOg0KDQo+IEBAIC01MzAsNiArNTgwLDM1
IEBAIHN0YXRpYyBpbnQgaHdfYXRsMl9od19pbml0X3J4X3BhdGgoc3RydWN0IGFxX2h3X3MgKnNl
bGYpDQo+ICAJcmV0dXJuIGFxX2h3X2Vycl9mcm9tX2ZsYWdzKHNlbGYpOw0KPiAgfQ0KPiAgDQo+
ICtzdGF0aWMgaW50IGh3X2F0bDJfaHdfbWFjX2FkZHJfc2V0KHN0cnVjdCBhcV9od19zICpzZWxm
LCBjb25zdCB1OCAqbWFjX2FkZHIpDQo+ICt7DQo+ICsJc3RydWN0IGh3X2F0bDJfcHJpdiAqcHJp
diA9IHNlbGYtPnByaXY7DQo+ICsJdTMyIGxvY2F0aW9uID0gcHJpdi0+bDJfZmlsdGVyc19iYXNl
X2luZGV4Ow0KPiArCXVuc2lnbmVkIGludCBoOw0KPiArCXVuc2lnbmVkIGludCBsOw0KPiArCWlu
dCBlcnI7DQo+DQo+IE1pbm9yIG5pdDogcGxlYXNlIHJlc3BlY3QgdGhlIHJldmVyc2UgY2hyaXN0
bWFzIHRyZWUgYWJvdmUgKGFuZCBlbHNld2hlcmUpDQoNClN1cmUsIHdpbGwga2VlcCB0aGF0IGlu
IG1pbmQgYW5kIHdpbGwgZml4IHRoYXQgaW4gdjMuDQoNCj4NCj4gU2lkZSBub3RlOiB0aGlzIHBh
dGNoIGlzIHF1aXRlIGJpZywgSU1ITyB0b28gbXVjaCB0byBiZSBlZmZlY3RpdmVseQ0KPiByZXZp
ZXdlZCB3aXRob3V0IHJlbHlpbmcgZW50aXJlbHkgb24gYXV0b21hdGVkIHRvb2xzLCBwbGVhc2Ug
dHJ5IHNwbGl0DQo+IGl0IGludG8gc21hbGxlciBjaHVua3MuDQo+DQoNCkFncmVlZCwgd2lsbCBz
cGxpdCBwYXRjaCA2IGluIHYzDQoNCj4gQWxzbywgd2hlbiBwb3N0aW5nIHRoZSBuZXh0IHJldmlz
aW9uIHBsZWFzZSBvbiBhdm9pZCBzZW5kIHRoZSBwYXRjaCBpbg0KPiByZXBseSB0byB0aGUgcHJl
dmlvdXMgaXRlcmF0aW9uOiBpdCB3aWxsIGZvdWwgYm90aCB0aGUgdG9vbHMgYW5kIHRoZQ0KPiBo
dW1hbiBiZWhpbmQgdGhlbS4NCj4NCg0KVW5kZXJzdG9vZCwgd2lsbCBwb3N0IHYzIGFzIGEgZnJl
c2ggdGhyZWFkIHJhdGhlciB0aGFuIGluIHJlcGx5IHRvIHYyLg0KDQo+IEZpbmFsbHkgcGxlYXNl
IG5vdGUgdGhhdCB0aGUgcGF0Y2ggc3ViaiBjb250YWlucyByZXBlYXRlZCB3b3JkcywgcGxlYXNl
DQo+IGRyb3AgdGhlbS4NCg0KRml4ZWQgaW4gdjMuDQoNCj4gDQo+IC9QDQoNCg==

