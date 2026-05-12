Return-Path: <netdev+bounces-287257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MLWGa9rA2of5wEAu9opvQ
	(envelope-from <netdev+bounces-287257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:04:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7991F526ACF
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2AD130A11AF
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3033955CF;
	Tue, 12 May 2026 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="MLG8gJ1X"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023094.outbound.protection.outlook.com [52.101.83.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35433955D4;
	Tue, 12 May 2026 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608193; cv=fail; b=E7H7EnsctM8iLcm+Dv/qNLKWmlcgWtaVKFZDS2jql6leUqOjBGTT7S3EOhDGn1PzasVmiHilGRwtiNgZsyTK9Ku5mdjd2qaS+dfU1bBteOzCwLrDHMalwM82f4YD1TF6HucYZVX8W8GvL4T41B3byjIRZvUHGFA4TXhaK6Ll+gY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608193; c=relaxed/simple;
	bh=SLaQyQ1Rm1D25QIWQc1k2l+5z94OZDjfeQ1H1Ds6sfY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NiMxcDKZxDddzkdSQyfHMfgRxACVi7UFCwW+GDW7rRi5MOczWIj3iaHHGGCTZ4Wm+JzEUr/7u81BL6+4oXyQF+WrM+dTo+PntYbgpvEp29U2UQuhjdgZ0+Mc/28rrljPLW8ZA7ZmN40NEnar3zKxWJJcxA4Y4QLTD6gy/Pvd0Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=MLG8gJ1X; arc=fail smtp.client-ip=52.101.83.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/ZUy8HqpKm18I/YyydISLE1rOYGteBHb4SorW0WS8glfQNpcsoOXJ67KPHxrxXqdlPo96B0Kz5xIbi29uz8TaiKJxsqNKqdTakPainCndS/QRG31J2G62PDPyh9mLuJK7yXMvpIPl/EjNuwwJgl5h1yBVgDFVFu6SCANA5H6NhV6P6SNMb6TrdaECkMiX1KCFYugxqEWGBMVOOgTsbD7zFGUEpJNgnA0KulSq+3joF79sKgnqNjuiT6/sWP0yCTdyGXDie35ipXp/wiqpotdpKWBq0ce9Y9+sjaW+sJocyn7QGAcsNyyFKVoVJCEWZVHEWJrMyHusG2fS8W9bpdGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTQUKqM283xGtHTfjYygHRu4ql5sawTzbHkoS2BzFwc=;
 b=VDui0+Q+4KrBCKork/noYnSUbQv8KAQe80+69qZmJu/JIJxFPzbBJup6lge+VUvylKOqA2pGiRidoG6Yqh6RVNnjdGYsaiWtZay5ILSkBHxh7YB50YI4+WK+y5bB5xPA8SNiEe8L97Uy9JRLwqOPth7qeC4o2NTWLuoWGCiihAbC3KbViv9WwZ2ianpjWOdYEogdqXAYXQ6w5kFBz8g1MyJBqAQeGhx+VDblytwBQzG8+y4Pg4xRjTmmxSZCGB29TlqPndR+vjOtGPoOCzGA5i7WWwSdz0OLe2TZbaiXblum9/YIpW4R0lildqo7O7AfVzpLRzpb9t9F34h8Dgdzpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTQUKqM283xGtHTfjYygHRu4ql5sawTzbHkoS2BzFwc=;
 b=MLG8gJ1XoMG4M4LLgDS8bzTwyMwqVxBAqz1p3wbIoo1PEq5TZqGUP1QYBa6TJU3SwPpQ31Jitw3mZRCf0UGDBYD5tkOQG/ukohHT4F2P0xfNpG90jNqw7yM2oGt9UPDCA7woaXZ8fpMD2/aZ4+YQjmLsIlLOhXk+ZQ0bCIbhzSNU+jSKRHoH98qEpwrw+IpK6SIxpO+gKVLneo0lNG+FQccwPyKuY+NDe1r7kaVWiweTZFElGp/Jq9YXdKW7YxRDc8SSBLGkKiXB6hU8XwUhWTQ/LhUFAqM4K3FPM1Q7nrHjPYkedcXRvu+XfLDpkc9jHDH3hTJ3FqwWg0kyWpsvzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com (2603:10a6:10:2ad::14)
 by DB8PR08MB5324.eurprd08.prod.outlook.com (2603:10a6:10:11e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 17:49:45 +0000
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f]) by DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 17:49:45 +0000
Message-ID: <f4a11830-8a3f-4cc3-ab82-e6f02ca34ae8@genexis.eu>
Date: Tue, 12 May 2026 19:49:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 11/12] net: airoha: Support multiple LAN/WAN
 interfaces for hw MAC address configuration
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 Madhur Agrawal <madhur.agrawal@airoha.com>
References: <20260511-airoha-eth-multi-serdes-v6-0-c899462c4f75@kernel.org>
 <20260511-airoha-eth-multi-serdes-v6-11-c899462c4f75@kernel.org>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <20260511-airoha-eth-multi-serdes-v6-11-c899462c4f75@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF0002397A.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::370) To DB9PR08MB6697.eurprd08.prod.outlook.com
 (2603:10a6:10:2ad::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR08MB6697:EE_|DB8PR08MB5324:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e5cbffd-da1f-468b-e47a-08deb04ed9be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|11063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	PJEAHGpnsS7dms6zLVE9GM/XXiq2aRmj4VSje2BrZYymnthasd21C/YCb5s3JaBpzGwZfmERooUibYjx6VrTsE/JMPccDcu2VGeB7kztDlrMrf/Wp4X9n1NiJiZsMdxDrPb/D0E0/YlepJGp21Hh3FIx1I9VN2M7hLDbOa4xKEmY+qo2XPAK7FSh4webFisusthJHLibIBImFZSeqc+dEfI9zGf7ze8fXa3or3bbEMuagXSpGf1MNH7fNrwX4p1+hsDuF4hlHQslEqEkOkYIb3Cpfsj/s2F3YwHTaJc12LsFqgXfTzVo0M58uoNd1G8wUGFhUeZxVmZAV3Ef+ysQr0+PJz6sVaEeCRbHtAOEL67otzHoZvd8Uc15/SLyFbROqTojCRobC6PYezEUbGfuz6HfArguscCPpC+QO5MlgcnhzRvqV035n8r9vDnSUBqfHk8aF/FAz4M1o2I75kJIo9FG57f/DXQpj0DCdS+Q1zoV92b3HcEBO90yKpmoklQ7cXE/WScq5LV/EMKjSuI0At3jMbD3LKiXQ3XR0Zq75V27yZa8noK+dd5vVFTdBI2ELI8mvfNJ3RLF4Bp7oNubaO2aurRZZj1dcsFqnWDY+plWtq3qFoq73dKGTmQI+4OsoJn5hdvRs3yEaqKq+pIs0eH7rT7RYulVpM9o6IJixmHB9x85I7NWuieJlFIpvoGm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6697.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(11063799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SElOR2pkdG1OZW0xMmk0NGdvZVVWUFVMbFJqS3lHQ21PY0hweHdiZDlpeGFP?=
 =?utf-8?B?UUpOUXMwcWcyMmpJUi84WkhzN0pMcFJ4OGQ5OEVqUC9vV0dPeWgwNXluSEgx?=
 =?utf-8?B?WW5DT2RRUTRwRmR1TldYZm9CRUhJU0lKaU1KRjkreDVMaFcrVjNLb08wZ3Zq?=
 =?utf-8?B?QXczM2E1ZitONEZBMjA2VU1KZi91L1dnVFNzdXFmTXFpblU3VlFxVFFVeFN1?=
 =?utf-8?B?dDBtS2s3OWdmLzVDRW1mMlVBS0FQNm1YdmtYS0oxWG52Y3NzU1R3YUhlc2ll?=
 =?utf-8?B?Z3ZDamVpcFRnSW53ejFXakF2NDQ4TTFtR3ptd1FtSjBnK1lITW4vQWFEMHlE?=
 =?utf-8?B?am1uNlF0WVFwQklSRCtnRTg4WW5YbnN1QjgwU3dyTDZYUVRKeUpZeGxSakht?=
 =?utf-8?B?YmV3SjFlTkQyMFhvZm5uL2FXdGFYUUJwajFSb1RBYWlCMW1XdCtWbTkwQVVQ?=
 =?utf-8?B?SFNEUC9yd2RXaEtjT1JOU3ZzRnhoa2thNFJzbFREU3RucG5IbVVYVU82Lytv?=
 =?utf-8?B?Zi9VZGVNdEZkYlZJR2FYcXM1UGJMZkl2ZDQzMnovckdOVUpXSy9KbWoxSjh5?=
 =?utf-8?B?VUZ2TzFkWHNNYjZod2I0bkswYXNsSk9wVXYrMW8yL1A3UlZGQU4zQkt5RTlL?=
 =?utf-8?B?ZTJvOE1vUkc2YUJaektJZ0U3aVdCMW90L0xmS210b21yV3F0cENmZ09QNmRL?=
 =?utf-8?B?QVlOSlZVdTBya2ZzMzBpc0wzRlVaQi9LTm5jN3c5SzR5aUk3cGZvWWRqZFk5?=
 =?utf-8?B?eTBQaEZSYVh4cWxkbmdHOVpKdnhIOXhib3g0RTVCUDh4QnVQM0tOaHRjcG9x?=
 =?utf-8?B?b1dUOVcrZ0VsbjhRM1hIc0lOWVZWbEErNk1XRllSM1J1eDdvb1RSRVZvYUI5?=
 =?utf-8?B?eUozbEhmeTVnL2lFbnhIUXorRzhvSVJaZlNqR1U5MFdNUkRCOWkyQXhPZEo5?=
 =?utf-8?B?K0pwbCtLU2dmTDI5dHFhZHVKZlo0VFE5MkwwYkE5RW5YOUhXaTB4NmZrcVdS?=
 =?utf-8?B?T1RtL25VVmZxQjJ5WXR1bXVtaS9FdytnbW5IaFlRcXJEeUQrajJ0Um1EQjhB?=
 =?utf-8?B?MEo4SUgzbFdaMjFmTVVEZjFHV0JOZklJaTZiVHc0cit5Ri9TbHVTS2ZNNGR6?=
 =?utf-8?B?VUZEV0NHaUNoK3ZPbmxYSkttU2tBWjJ1cXNGY3o4UHB4c2crSEJxOGhJdEQ2?=
 =?utf-8?B?WUdhUWFKUndJb2hzekZtVlJYd0R3TEFiSFE0VHJMZndqNUQ5T3MzT0lWZ3pU?=
 =?utf-8?B?Rml4WmI4YmdyTU5uYXdrNnV5NHVUeVlMckRjeFNBTVhCd21ndFpVZ2RpbUNv?=
 =?utf-8?B?a2JCU29yelRvWUZhT3B1TzUyVldJT1BGTDZzOGlhZkxZTWdJYW9HZzVmSEtE?=
 =?utf-8?B?K3gvS3UrVUZIRlcwdzFSa3Rlc1lSNGdqNGs5eGUzbkJaSisyRDJVZEhuMmZq?=
 =?utf-8?B?dHFFQjc3QWt3a0dNQ1ZIV1QraCtFVnM0aTFRU2JqeTh0K1FwU3I5bkZ6YW80?=
 =?utf-8?B?KytlRWxCa2JvZXUzeHJOOFl6MWF1QjQ0d3dWY1J5ZXkwbEcrWGxvcTd0MVhi?=
 =?utf-8?B?c0o3RUNYNWdYSk03dFdFT0dpdFV2MmNsNFBqcE5saUxDRlhnaFFKR2hMalJE?=
 =?utf-8?B?aEJ6bnN0cTJCeXlaWDk0N3pFdHdjdTlSd2dEanNyQ29CeHVsS0x1THljaUFx?=
 =?utf-8?B?Unp5YURkc1EyV2xLZUtPd1Z6TnpiL05CeENsb0k1K29GV0J6azI0VVdDdWxt?=
 =?utf-8?B?SlpuOXpGS2Q5RDlnYm54NHRkanB2VklISlUzQXhMTGhINjJJVXRLbmwvZ1FR?=
 =?utf-8?B?NFpURTRBZVVkc0tJSFRxRDdtSzdJM29leFJjcFJvTWxlS2ZHeldiV2pKa3F4?=
 =?utf-8?B?dlNuRis3SjNoMko0Ylp2VU4zR0c4WDQ1WEJ3RFZaU1ZpanNad1pFSktLd2Jo?=
 =?utf-8?B?RUlvelBUam9wdUR6Y3lWRWV2Mm1ZRUh6aGs5UmwzeHVpWHkrT2hiNnppK3pY?=
 =?utf-8?B?MWdWcVc3cVVGclBmM0VNMVpQRHRGaGUzeUVhMWEzTFBvT3YrOUlGb0dvWndy?=
 =?utf-8?B?aTE1d2FmcHdidG9aZ0t5dlZjWENoMlZmZW4weE0zaVhTY24ya29TWmUvL1p4?=
 =?utf-8?B?UWVkNEQwUWJDTVBCRUltZXp2bTRWLzdlTFhEdzFWUTAzMGJEOUlxY3VOOFFK?=
 =?utf-8?B?OGJxd00ySXZjSXYzVlpnMzhmNDBtUjdxM2VSUXlZTFJvbXRSdkZVQ2wwWDFw?=
 =?utf-8?B?NXlsZHZ1MHlRVitFVnZKclF6K0Y1aVRCY1F4emtVemtyd0pGSXZNclV1UXFW?=
 =?utf-8?B?ODJ0TnZvV0dJMHAzWnVCZC9QZ1hYWmtUSmNYT2ptNUFNTk0zQStwM0tzZXRu?=
 =?utf-8?Q?qyHiUWKWADweKx7I=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5cbffd-da1f-468b-e47a-08deb04ed9be
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6697.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 17:49:45.2933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLzGGbXntPEluqWXGJSSn66lCUDNNdbtye0iCgkXomEmVpKpAZTj+NsQ42HNi/8LeZrLlU65fH3adMDvvQtbxEkkP6W1qmAatORg9/yKQbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5324
X-Rspamd-Queue-Id: 7991F526ACF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[genexis.eu,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[genexis.eu:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287257-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,vger.kernel.org,airoha.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[genexis.eu:mid,genexis.eu:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,airoha.com:email]
X-Rspamd-Action: no action

Hi.

On 11/05/2026 12:49, Lorenzo Bianconi wrote:
> The EN7581 and AN7583 SoCs provide registers to configure hardware LAN/WAN
> MAC addresses, used to determine whether received traffic is destined for
> this host or should be forwarded to another device.
> The SoC hardware design assumes all interfaces configured as LAN (or WAN)
> share a common upper MAC address, which is programmed into the
> REG_FE_{LAN,WAN}_MAC_H register. The lower bytes of 'local' addresses can
> be expressed as a range via the REG_FE_MAC_LMIN and REG_FE_MAC_LMAX
> registers.
> Previously, only a single interface was considered when programming these
> registers. Extend the logic to derive the correct minimum and maximum
> values for REG_FE_MAC_LMIN/REG_FE_MAC_LMAX when two or more interfaces are
> configured as LAN or WAN.
>
> Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   drivers/net/ethernet/airoha/airoha_eth.c | 75 +++++++++++++++++++++++++++-----
>   drivers/net/ethernet/airoha/airoha_eth.h |  2 +-
>   drivers/net/ethernet/airoha/airoha_ppe.c |  4 +-
>   3 files changed, 66 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 16c0ff9999da..533ffe20f833 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -71,20 +71,67 @@ static void airoha_qdma_irq_disable(struct airoha_irq_bank *irq_bank,
>   	airoha_qdma_set_irqmask(irq_bank, index, mask, 0);
>   }
>   
> -static void airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *addr)
> +static int airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *addr)
>   {
>   	struct airoha_eth *eth = dev->eth;
> -	u32 val, reg;
> +	u8 ref_addr[ETH_ALEN] = {};
> +	u32 reg, val, lmin, lmax;
> +	int i;
> +
> +	lmin = (addr[3] << 16) | (addr[4] << 8) | addr[5];
> +	lmax = lmin;
> +
> +	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
> +		struct airoha_gdm_port *port = eth->ports[i];
> +		int j;
> +
> +		if (!port)
> +			continue;
> +
> +		for (j = 0; j < ARRAY_SIZE(port->devs); j++) {
> +			struct airoha_gdm_dev *iter_dev;
> +			struct net_device *netdev;
> +
> +			iter_dev = port->devs[j];
> +			if (!iter_dev || iter_dev == dev)
> +				continue;
> +
> +			if (airoha_is_lan_gdm_dev(iter_dev) !=
> +			    airoha_is_lan_gdm_dev(dev))
> +				continue;
> +
> +			netdev = iter_dev->dev;
> +			if (netdev->reg_state != NETREG_REGISTERED)
> +				continue;
> +
> +			ether_addr_copy(ref_addr, netdev->dev_addr);
> +			val = (netdev->dev_addr[3] << 16) |
> +			      (netdev->dev_addr[4] << 8) | netdev->dev_addr[5];
> +			if (val < lmin)
> +				lmin = val;
> +			if (val > lmax)
> +				lmax = val;
> +		}
> +	}
> +
> +	if (!is_zero_ether_addr(ref_addr) && memcmp(ref_addr, addr, 3)) {
> +		/* According to the HW design, hw mac address MS bits
> +		 * must be the same for each net_device with the same
> +		 * LAN/WAN configuration.
> +		 */
> +		return -EINVAL;
> +	}

Maybe this information should be relayed to the user somehow?

MvH

Benjamin Larsson


