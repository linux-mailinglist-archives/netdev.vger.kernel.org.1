Return-Path: <netdev+bounces-287575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGMBKvhtBGprIQIAu9opvQ
	(envelope-from <netdev+bounces-287575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:26:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20025533049
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E300A30104B4
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABE1406296;
	Wed, 13 May 2026 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="uxQhabWo"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023132.outbound.protection.outlook.com [52.101.83.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F1540758F;
	Wed, 13 May 2026 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778675177; cv=fail; b=bxSHkTSMg3JJiylcVcT0AJ6Cl8zE6Kh1wtd8ZBXhv1mOmRVjZ+aIzuLbr8wPOR1NJwjkqL24/NO/+J36w1Ar2tSXXl08RWAPXRmNW182waHMO20fHYZoAwxc1tiIrK+i/EkO7oxMjYrGdVdBuJFFwQ46HsMogENBNO10BZkimN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778675177; c=relaxed/simple;
	bh=j3NLKEPEEuPIYCmndZcLaMhw7mOFzYuZZl9oyw1cXUI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YFBC70vZf/0V8Xhn0PpSbinVuLC7w6jk6DCNHeAqenfdw90cAyy4O4Cm6mn92pdGVvbeu2abNBLSjLuLnjgoPNDIl1woYEr3VGmq9C/k5EJ/EjsTd5j0dkk7MkvIqwlx7ZBowcoUN+X7xOxd3MtuRFZg/M/BSf8EshDw2LQ9dRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=uxQhabWo; arc=fail smtp.client-ip=52.101.83.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqQK/zI8FTzyAbTZJcmCyTrHqZitcQxRawYa4nmUTL7Ruq7vcmoTSMHp2YjvsmJoxPizkdejtDn/6c0UgQuUn3JmO+NjlyRw+3B9WPJAVhW7oNEk2/HUNj+xC3roV9FUh6bw3UIWS0+hsIa+EcJkhHlJKHVwaTmLHrXXVEIb1Xsz/mhuAym0wWeMhAvJakvGeXzErYR6YmiSP1y56PXFnVKjgYb2C5sbFyynN6uuRIjcfnDNirdBiD75XmXKf4LWlFnBrXc2bV6tF9bBrKG5aiEnJVKs5lOKTdqAnLnjpboxI9jWbfGWk5yg3R7HsmCBrAp8iYs50LpdU1MH5kxaDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQlZ/OjZycl8mO0qhkBjjI22KpQXTTVRLDnf5qieSXI=;
 b=kgVjtJaXmOvVkgvhpZ5hMPPAHPDrTmg+TJDgFYOx+sNLQ6HggyoY3wWSQuKDlfkUti2kP216W3S6FTDr5+o0rp0jWY6CVzBc/FT0TyM05GDnihnB4wmqMa2jO9g8JhrZ+9gs00oquSYRteWFHKiVh6QivOPlvDqJdeLOgb4LWvvOHV5c75BKZi3p3JXbut2uW6zUJMweITBn/aTJb7y8+ZofbVX/qR9ghWfmH6eyszhigyLScb46G375J9GsZyb1KPkXHEWYYGBhGx7FIiaDrRc994E0Foe/qIKogeGHc5uhWJnwBlD2MQLWO36grLtZ9n95yE2zstqOgebcNWJwGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQlZ/OjZycl8mO0qhkBjjI22KpQXTTVRLDnf5qieSXI=;
 b=uxQhabWoxjKwPJhsunr/5GaUYSF0QuaQ2SpuprNymZN8SHq+qRV5B7zWS4IqJK5El7OML1AQizlVkKmesc8T4CLdBMT1c5FM6S7R1WeWwD+p/Om8b9w68jQChvn1T0xFO/418aG7UT9LjI1bNHwHIEvFfemb5rHJt+I6ishuNcz/pu3LhrLmMd+WX/0Vxpde+KE3Q87oheT+yWt1vQTcC5Q5LDvPHjSHclnFs6adjs3wW6ChbGge3eearStuDFtz4KIO8hwNMCiVsUXLBb+IF0LHySxndIGIDnb+VIXtsz/JGrdt6m6PE9PDZlkHOsnqrDO3ltc3IynTpFmLvxBLmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com (2603:10a6:10:2ad::14)
 by AM9PR08MB5906.eurprd08.prod.outlook.com (2603:10a6:20b:285::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 12:26:09 +0000
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f]) by DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f%6]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 12:26:09 +0000
Message-ID: <383d1b22-7749-4278-a856-b8e29bc06e73@genexis.eu>
Date: Wed, 13 May 2026 14:26:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 11/12] net: airoha: Support multiple LAN/WAN
 interfaces for hw MAC address configuration
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Christian Marangi
 <ansuelsmth@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, Madhur Agrawal <madhur.agrawal@airoha.com>
References: <20260511-airoha-eth-multi-serdes-v6-0-c899462c4f75@kernel.org>
 <20260511-airoha-eth-multi-serdes-v6-11-c899462c4f75@kernel.org>
 <f4a11830-8a3f-4cc3-ab82-e6f02ca34ae8@genexis.eu>
 <agOUgVn24Ls5jiHq@lore-desk>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <agOUgVn24Ls5jiHq@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF0001DC2F.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::116) To DB9PR08MB6697.eurprd08.prod.outlook.com
 (2603:10a6:10:2ad::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR08MB6697:EE_|AM9PR08MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: c5380dec-c4c0-489b-5466-08deb0ead020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	FhdIAkq37wAtndTGNARgCgtE4H80ZVQJSGdmDfIHdaOlbdtFK/jVbwQy3ZXSkb07+1X0RKD1n/XV/D9iCnJZGW5ImigOEnVIXGG3U4BVEJNYn+SPHQRy3BgLDBVr3UYHqlbhE6Sg2XyvC+gHt0DNedtsoSsfYZd2jtScdqqidPhohHbSEZfFwRHWXhe7ZEJ73D+NFcyhPMi2Y+WAUs3JvU+jzFwumalwgzeLgZMTRPmEPuklBjG2kNkBsva0hWE44HtMqMh8bSOSorNTw6X0FTe5lffjfrsWUSGzztHpaWqpWjyFKCGDrCG7KehZetNrvA7r1KN2tDdbgmgTWfpkOQj5JIY9xtyeVSfGixRZw83H2qwTgSwA4gV7JYP/K0fgjpdIblT3N1m/aC/VLxCDtX8RsHcxamGRLZeeBP+MdfV6wkCT5tqKFmpKLEmYDktrAumkuq8aCq73zWf4nz0dudtYEKo31pxfuoUHCW5Q2meCgNpMxDhNoA9INBeHN63r6GDo6j99JkvB/n/+hKZpybH5KtY2KT0woC2m3JkUBAPKheSfREiOTWfTNr25QzZCcBPTD660Lm2jWkjtQAtrlG8QuZjPFEQIlNG/pksgFadNSgeZgprSQ8LRBn83jm8RWQOfJmGRgt5H8GUv7AfHZPddjGTaxciKKxCSzQ/7Q2StdaE/5jFI9wYMfOvPP/ln
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6697.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(11063799003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVBaMm5hb2tEbmY5Z1lpSHJRRTJIVnZ6dUNOMWF1SUFwRDFIN0tvN2FiVHdO?=
 =?utf-8?B?RW8xSElsM0kyankwSkVrUklOT2Z4R0VkeXo1Y1ZjbVFKNmZBblZGWkJwYXFW?=
 =?utf-8?B?VUwxcTFCMW9GLzZHVzQwLzNERWVwZ1J4N2FFbUVrUW5GYzE1YWRnN0Q0czFp?=
 =?utf-8?B?RmtMVE85VmtidkxibW44aEJ5SlFOZGxPNTVBdWtiTW4xeFRTWm9IbjVEYmdw?=
 =?utf-8?B?aTZ6UWZKVm1xcERYM3h2YTNQTldqa2RRNGtWR1pBZlRvdU9RNFZQbzJFY2VN?=
 =?utf-8?B?UFViNThZY3JvSkFRd3dZU2JMQ1pnVk9odzY2QmFqK09PQ29QdW5HdEhJU0Rx?=
 =?utf-8?B?ZHJqaEZEaW84bFdITDVabmpXdzJZSnlLWjZmQzNmMVAzYUdpWDlRb2Y3OTdq?=
 =?utf-8?B?NERCSldFaS9PRFRQcFJ0c1JGSkdwTFRBY2lEZnNsVWRzWDAwN1R2b0tlQUp4?=
 =?utf-8?B?QVZyS0RxMVhmam9qNWRQR0M5L2ZsZWZRcUp0MG5KSy9qeWRjQjl2QVk1czQ3?=
 =?utf-8?B?eWJyT0FNSlBLdE96K0J5MVFNNmlhdXBoRk1zNDhrUXYwM1g4NDIvZUJqaFVD?=
 =?utf-8?B?NkZBbkZkc2pHSzVlZUhTa21ObUFhbXhKRmx6b3VmOGNBRVF6QUtsVjZFNU5Y?=
 =?utf-8?B?UkdnYzc1UzhFbEN4c3AvOGV6b0l6UHRzT21NTlVHcXRhYnRsRExtV1ZkbWhC?=
 =?utf-8?B?UWNFS3NkK1JzWEpkbHczYis0TGw2b3lraXJZUVc3VHF6ejdiMmdHM2VTbHlM?=
 =?utf-8?B?em1LOEdUaGxaek9MN1ZtL3V5VHlGeE9HTTJQLzYraFlHQTNsSk85Q1BlYjZL?=
 =?utf-8?B?YVREL2R0TFhWaGg4a3hjZUdLOUxlc29JTUdjYitwRE1HdWFQL2RidDZtWDZ0?=
 =?utf-8?B?d2Y4UlJ2L2pUK0prblV6bWllZ1had2hCb0xOYUFWS28xc2lsL2ZFVjhTSThW?=
 =?utf-8?B?MSszOEkyaXh6aXowaUxhRWR5UVNnTkljM01LOUdheU1iSFNwWHJVRGN5QlJW?=
 =?utf-8?B?T0ppUGV2cGlnenNqQVg2SitNaFA1L2UyV1l4azNEL0xCQWdYN3licmZEQ24x?=
 =?utf-8?B?ZW5YQmtXWDJWQjVxMDBqOUttVEtoSUpWSlZpN2hsc3pLZis0aWYxNGpNMHNT?=
 =?utf-8?B?eW92UDhrb3hQRURQWHJ2L2R4WDN3SFpUVkx6MWQ2L3ozcEJBOFNjaVBlRFBS?=
 =?utf-8?B?S04vUkw1ajhrZ3I5anQvQzNFS0VhS1B0eGo3ZVkraDRkZkpnenEvNDlPNjhJ?=
 =?utf-8?B?MW1QY2ZiMHpsVTBkbmN1YWVxMDFHQW14WldHR3RUT091YzA0aXNHZVVBYUlD?=
 =?utf-8?B?QVpXUlBzRkRObmN1Ui9jbzY3aGI5L3RtT0VwR0xDWmlVL09zditLL0JwMmp4?=
 =?utf-8?B?b25SMlpSNjVUS3ZBSGtTUUhLSjdEaXIrSVQ2TXVRSVFsbEI1K2lMT2ZVQWhm?=
 =?utf-8?B?YUhsTWVTekRGbU5mZzFELzJrczQzL0RVYWs1N0MwUVB1em91WWZFWGhtUFhv?=
 =?utf-8?B?WWM0SFBJdEh4V0RhTkptLzk5UlJzSmhhMmRoMnhPNml6dmJyUnlFbVJhVXRi?=
 =?utf-8?B?L0hZWFZvaVNVM04rVHFPRHpZUkJHakZTRzAwd3lkT05CUVlKWUsvK1pFWkZt?=
 =?utf-8?B?TGgvNFJYamlVV0J2eUplTUxQcUZtRkJDc1BHNk5sWHpXcC9BdGt3RGJxWXIw?=
 =?utf-8?B?YUdNWnVmOUprQkIzSTFxamZZWDY4T1hGeitpTUw5cGJacDk4dld3R2hvODlz?=
 =?utf-8?B?d25vYjY3MjA2UURCRE53Q2dlVHpSTTlpdDg3V2xXWmg0WGdlczFkMytZajFR?=
 =?utf-8?B?a2pCTEt1Z0hDT0pEYzRvMDFzRVJzZmRUY3hFOEw2cFg3SVI5TFE5eHJLbmxk?=
 =?utf-8?B?Yi9zcE04blBIdUdLN2dUdHZuOG5FemZRc0FzSVMzRGNXQlRKK045b2YyQWFB?=
 =?utf-8?B?TmoyejhoZUt6VEJOMWlXOVpmeDlYWUYxRER5OHRlYTFKMko3bVJrbVMyS1p3?=
 =?utf-8?B?MjZWek9YOCtML2VabElhV0lRVFJic2VlN2gyMnlxc3M3Nm9NSDR0UzJyVG1p?=
 =?utf-8?B?YkFhVmduc1pFSERBYys1dGkwc211aUNldVVneDFhRXR4RTFBdEl6TFJRb21o?=
 =?utf-8?B?NndQVkN0M3FoR3dwZmErdENSS0dLNG4ySU8zRUxaaGx3NElCRDdDSUFxSEcx?=
 =?utf-8?B?YVp0bnQ1cFpzSm9VdGd4ZHluamQxWEFIemIwODFpMGdJb1hrQ3BpQVo1Yk9i?=
 =?utf-8?B?K0ZTTncwcXlHaUFyZlYzMThuaUFxMWRBK3NXVWVCQjRSakpESjdtMVA3dFE4?=
 =?utf-8?B?MExxdHpPcVM3UGxjNHdOUnM2Q3dOMGcrUjJMeHF6MWhSV3l6ZGYvWU9TRWRK?=
 =?utf-8?Q?f1mPpISs8jBNVYOU=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c5380dec-c4c0-489b-5466-08deb0ead020
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6697.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 12:26:09.6243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFCXV9g3rw7ta+xbP7sF7pQMOttI7R/Dzk3+vo1Sdw7GiDNBXtWhHKiCg/ROXL1WZuvFSmQ0AcqavOgkUR4u1LYO/ll7oGe6/vBQeFPqVt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5906
X-Rspamd-Queue-Id: 20025533049
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[genexis.eu,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[genexis.eu:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287575-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lists.infradead.org,vger.kernel.org,airoha.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin.larsson@genexis.eu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[genexis.eu:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 12/05/2026 22:58, Lorenzo Bianconi wrote:
> On May 12, Benjamin Larsson wrote:
>> Hi.
>>
>> On 11/05/2026 12:49, Lorenzo Bianconi wrote:
>>> The EN7581 and AN7583 SoCs provide registers to configure hardware LAN/WAN
>>> MAC addresses, used to determine whether received traffic is destined for
>>> this host or should be forwarded to another device.
>>> The SoC hardware design assumes all interfaces configured as LAN (or WAN)
>>> share a common upper MAC address, which is programmed into the
>>> REG_FE_{LAN,WAN}_MAC_H register. The lower bytes of 'local' addresses can
>>> be expressed as a range via the REG_FE_MAC_LMIN and REG_FE_MAC_LMAX
>>> registers.
>>> Previously, only a single interface was considered when programming these
>>> registers. Extend the logic to derive the correct minimum and maximum
>>> values for REG_FE_MAC_LMIN/REG_FE_MAC_LMAX when two or more interfaces are
>>> configured as LAN or WAN.
>>>
>>> Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>>> ---
>>>    drivers/net/ethernet/airoha/airoha_eth.c | 75 +++++++++++++++++++++++++++-----
>>>    drivers/net/ethernet/airoha/airoha_eth.h |  2 +-
>>>    drivers/net/ethernet/airoha/airoha_ppe.c |  4 +-
>>>    3 files changed, 66 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
>>> index 16c0ff9999da..533ffe20f833 100644
>>> --- a/drivers/net/ethernet/airoha/airoha_eth.c
>>> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
>>> @@ -71,20 +71,67 @@ static void airoha_qdma_irq_disable(struct airoha_irq_bank *irq_bank,
>>>    	airoha_qdma_set_irqmask(irq_bank, index, mask, 0);
>>>    }
>>> -static void airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *addr)
>>> +static int airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *addr)
>>>    {
>>>    	struct airoha_eth *eth = dev->eth;
>>> -	u32 val, reg;
>>> +	u8 ref_addr[ETH_ALEN] = {};
>>> +	u32 reg, val, lmin, lmax;
>>> +	int i;
>>> +
>>> +	lmin = (addr[3] << 16) | (addr[4] << 8) | addr[5];
>>> +	lmax = lmin;
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
>>> +		struct airoha_gdm_port *port = eth->ports[i];
>>> +		int j;
>>> +
>>> +		if (!port)
>>> +			continue;
>>> +
>>> +		for (j = 0; j < ARRAY_SIZE(port->devs); j++) {
>>> +			struct airoha_gdm_dev *iter_dev;
>>> +			struct net_device *netdev;
>>> +
>>> +			iter_dev = port->devs[j];
>>> +			if (!iter_dev || iter_dev == dev)
>>> +				continue;
>>> +
>>> +			if (airoha_is_lan_gdm_dev(iter_dev) !=
>>> +			    airoha_is_lan_gdm_dev(dev))
>>> +				continue;
>>> +
>>> +			netdev = iter_dev->dev;
>>> +			if (netdev->reg_state != NETREG_REGISTERED)
>>> +				continue;
>>> +
>>> +			ether_addr_copy(ref_addr, netdev->dev_addr);
>>> +			val = (netdev->dev_addr[3] << 16) |
>>> +			      (netdev->dev_addr[4] << 8) | netdev->dev_addr[5];
>>> +			if (val < lmin)
>>> +				lmin = val;
>>> +			if (val > lmax)
>>> +				lmax = val;
>>> +		}
>>> +	}
>>> +
>>> +	if (!is_zero_ether_addr(ref_addr) && memcmp(ref_addr, addr, 3)) {
>>> +		/* According to the HW design, hw mac address MS bits
>>> +		 * must be the same for each net_device with the same
>>> +		 * LAN/WAN configuration.
>>> +		 */
>>> +		return -EINVAL;
>>> +	}
>> Maybe this information should be relayed to the user somehow?
> netdev_err()?

Ok with me.

MvH

Benjamin Larsson


>
> Regards,
> Lorenzo
>
>> MvH
>>
>> Benjamin Larsson
>>


