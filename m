Return-Path: <netdev+bounces-272172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJZDEbZuxWl1+AQAu9opvQ
	(envelope-from <netdev+bounces-272172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:36:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C453393BC
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BCA9306633F
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643EC426EBB;
	Thu, 26 Mar 2026 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="dc5LdI5X"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8A4425CCB;
	Thu, 26 Mar 2026 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546295; cv=fail; b=IaqzWkP/O0vQJaTZo1FyRKQ5114pJ80Bh/s8DexbBcqq5E3d9Eww+xtkPbjU6mX0nk2G40q9cVLGz8og2SGKFCoQSiMIrPZRy/H+BhtdYNe0jofup7zyPimCby/zYRiWlTz8pa/vI03gI3PBBfedvRxdi0Op2XMXex+w5v67urU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546295; c=relaxed/simple;
	bh=eF7A/iTum7m/NgB0SLzgyaiZ7y+UcJdefLTw1gtpuSI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bgw0IorqWsomMc5TDrCupcKtS4SvbdiraqKRV4B2fiUZ1E7E68a8SM8Y9uLRPjK3tHYfLY79hzIjO0FBoy29hwzstxD0eZpkzhO1t4eskhP909eNbHhz+l3TVsWQylW8iXhEJJWiS2tR2Fiqnqy+86Sz9cCHPhGQ0t5wZB2LOwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=dc5LdI5X; arc=fail smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QH0jrW2439110;
	Thu, 26 Mar 2026 17:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=jan2016.eng; bh=ivCRiqIvKPHwBKAuXgxWJv
	7TeOBsMApkQ8JWdcNYypg=; b=dc5LdI5XQ9hd97DKgx6kuhywlYXoX0PM3ZISUb
	G8VVO1EH0j61MHUDr3mLgc4wIMHnd0cxkgi1GP0zaKfgeNiMXQRD3h99Tz6ePCH4
	ziwpog5iBpJdWhqFDexXr1mkLeyHrWVbyjD7gBAsDW/1Dr0HzkSomiFd0ZeyYLvI
	GgQrYE9RHyWwnULE6dbenGXFICnJ8ZwfO6XwsSl+tGLnQnj+vzKsXyRK5PbsEl2b
	TrsyPu0czwX7LTKxZ2XpMhM0LK5UGuN1MXsQA1NGvWsJC+MlZs6e3J2N0HVIblxo
	3anygRs0HUZ+HWqsMq+RWK1E+nLOvXvMw+gwVf1fBANfaDrw==
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19])
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4d1kfc6w0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 17:02:58 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
	by prod-mail-ppoint2.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 62QGnhHc010216;
	Thu, 26 Mar 2026 13:02:57 -0400
Received: from email.msg.corp.akamai.com ([172.27.91.21])
	by prod-mail-ppoint2.akamai.com (PPS) with ESMTPS id 4d1pnufkrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 13:02:57 -0400 (EDT)
Received: from usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) by
 usma1ex-dag4mb2.msg.corp.akamai.com (172.27.91.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 26 Mar 2026 13:02:56 -0400
Received: from BL0PR07CU001.outbound.protection.outlook.com (184.51.33.212) by
 usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 26 Mar 2026 13:02:56 -0400
Received: from CH3PR17MB6690.namprd17.prod.outlook.com (2603:10b6:610:133::22)
 by SA6PR17MB7297.namprd17.prod.outlook.com (2603:10b6:806:41f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Thu, 26 Mar
 2026 17:02:43 +0000
Received: from CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::98fa:4f7f:dbb7:eb55]) by CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::98fa:4f7f:dbb7:eb55%2]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 17:02:40 +0000
From: "Hudson, Nick" <nhudson@akamai.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "Tottenham, Max"
	<mtottenh@akamai.com>,
        "Glasgall, Anna" <aglasgal@akamai.com>,
        "Daniel
 Borkmann" <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "Andrii Nakryiko" <andrii@kernel.org>,
        "David S. Miller"
	<davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] bpf: allow new DECAP flags and add guard rails
Thread-Topic: [PATCH v2 4/5] bpf: allow new DECAP flags and add guard rails
Thread-Index: AQHctt07v3rmA5GaA0m7mwuIUZ9nP7W+CuqAgAMMA4A=
Date: Thu, 26 Mar 2026 17:02:39 +0000
Message-ID: <2F9D17D5-2138-49D6-B9C0-67D556D32E14@akamai.com>
References: <20260318134242.2725749-1-nhudson@akamai.com>
 <20260318134242.2725749-5-nhudson@akamai.com>
 <60a0b32d-b02b-419d-9d71-3293261333cb@linux.dev>
In-Reply-To: <60a0b32d-b02b-419d-9d71-3293261333cb@linux.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR17MB6690:EE_|SA6PR17MB7297:EE_
x-ms-office365-filtering-correlation-id: 76f29a2e-5c33-4d2a-9b78-08de8b597d12
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|6049299003|1800799024|7416014|376014|10070799003|366016|4053099003|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: sXlU96eOKaPCJi+v7rAY+uQuUvfyhG6wie87R9NN8nyoJnf1HSwOcputMWY4+KMaN7l9d7mX60CGAGdKkt/lMNvZBq8XjJ3KPVCZsRqcWKfXsfKy0vFILKEOiibkHkKOqJqaE/2dNSxw/73nIs5p3S12hGkpYZe5Xg8oHOnGSrjo7OYs/rJ4sY1o9m20N+1/8OD/pMeUDWWnunlh0wUTBVeGKfxtyuRfmB2U5q/snaOgMwuJFg4D5VKU3KcUo9DSbihajeevbLY9XvY1j07AyUNsmrNNq2SxmGSYF6kSoBGRZfj4MySa2apPaz6zMlX9/jylQU0Z7CEWtM/zdjsyQqJD1V21ijwtNxbgVYNyGUMVdigLURzYBCpKf96oQQ4/ZwyWLqEmwB5EwRPr7FfYHJcgrmd1HDD3V6+W8j6a4dlhyUKk9Y/EFYsTJUrQ/EXEM8oAtUiET0MaudAQQJagfdKh1ozntRdjrYx1AJ2sHSNz476yj9aI80LDYpZPLi2CRGYrC1deRCWS1USw7L5KFsZK1MaSpEshVV34rVOF+Mq1YGBfZf/ECBNsw1E638X8wwxi34WzPNBLbdTEzflIIk382y2ONKOrG4ph/wmsNGUH/ObmpZBQlillNJ27gfBQgtFBdy6zQwEF2ZtM53Fx6W7CUGulVTZBks3Gj533kaY0eASu5f18U4Ro7OwzhTo2bXznWy1Pdi/uS2Ad2gKEbPGmfdq68gAdDUFTytyidLRUemZGQnf1fYceI/CfvEmaop/fVxKdplVvTdK947Yi5CJmlsn8iMzNYq+pHppA4Io=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR17MB6690.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(1800799024)(7416014)(376014)(10070799003)(366016)(4053099003)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTM5cXQ5d0lFVzFwMFVLdTNRV1M4amQxS3FyODg2bGZSSXpCZlh6Z3crWE9P?=
 =?utf-8?B?TEJKUTVOSHUyWVQrZW4yRzhEdnVMU3BOSUh6SEFqUStKN0dpSlF3NW5LbFpL?=
 =?utf-8?B?bXVLUnNiWkhIUmRRYS92YUZQa21vbEU4SHpRcGlWSUQ2Qlp6ZzhpTDkrNlpM?=
 =?utf-8?B?RGtKMVA2VU5ISVBXV0E3aDJyc09KWVZtTTdFam5JWFhScFQwek5OTHJFZlJU?=
 =?utf-8?B?MjNmN2JHaXBxTG5zSWpvZ2x2VElyNnNodFAxakN2L0YyWnE3eFliNDAxZjBi?=
 =?utf-8?B?ZTFvWEpGd0Z3OGJqUGN5ZWJURkJBNlZ4Q1U5V2dUOTdzTHJhenF3L1MrWDhu?=
 =?utf-8?B?Nkt6d0hFQ2Jua3NoanJFTlNMcFhTam9SUno1TFA0cGJOb2NUcEVnNUxTRVkw?=
 =?utf-8?B?eTRIdzYvSlhMTHVVYU9ZNGQ5Tjk3UFVMQ3lRQTcyUmV2UTdoSkpWTHRqWUJw?=
 =?utf-8?B?WVZIalJoR1FHTlUrKzYyb1N4dGlUaUprSkFaaVJLVGpBMEVDa3ZPclIzT3Jx?=
 =?utf-8?B?ZXR5amtGaWVBbTdjaUEzeWk0S1l5ZHJkRjFJeW5XTG5vSVlUK01hQ0hOdllG?=
 =?utf-8?B?bjFOODhCMVVWZmZiUTVWclV3OFc3Z3hnczZqQ0pyNytYRXpvQzc1U3d6VEhU?=
 =?utf-8?B?WlJTQUp5QTZBN3RXd2xQcmpXWi9WZ096OVN3M2tEVzBVNWNrdncwUEtXdGNh?=
 =?utf-8?B?Zm9jai9lUjF5N3FLWGhKNVlWUUxHTHRuL3JlNWtGK250UHpibjdNOVRpUDlo?=
 =?utf-8?B?Y1NxV2liZmJLRW9UcHpNU3I5aEpSMCttdjJ4aVB1VGJwVlhkYmFxcUVCMlEw?=
 =?utf-8?B?ZWh1L2F1Um5md1dZekd4RG95Um1NM1FTUzZqV0k0TVpnVnozWjljK05TMHZ2?=
 =?utf-8?B?YXUrb29DU3BxNmVOcng1ZmZwU2MweFRWZy9lWkEwZ3l6bmZRSjRyUVZnbElJ?=
 =?utf-8?B?a3hKNk5SRTNRS0VpZ1d5bEMveXVQTEw1VHlOSFBHUTcrMjFWUmhGYllJQWVv?=
 =?utf-8?B?L1d2N3dFbkhlS1h2SVA1TmhiTjlJT2I3SzNoL3BXMjZGWVNlTTFIUFJ3UUJL?=
 =?utf-8?B?TEhuVHpJMmxDQytzRFRjMDk3WGt6L01TMFRNaUhxS0xSQUgrSG4rUU1TdVVG?=
 =?utf-8?B?NjFyTEs0OC8yZmE2blZOQlBtdiswYUNxY3pCMDlwUWNzWkQxYURiRU5DT01I?=
 =?utf-8?B?b0dDN0lUT1ZkZXQ3ZGdYM2gyQkNZdEE3bm9ZSUs3THc3cExzWW9SeWs1SFFW?=
 =?utf-8?B?SEludlpIUFdGeHJEaFNDaFBMWXVDSENuRGhHdDlaaGZjZCtGODhFOXdydDJV?=
 =?utf-8?B?c3dVSHJXWU54NmpGdnNWZFh5ZitLVzJ0K2s5ZmJEVFNTZjRsSWpQb1MzVHRt?=
 =?utf-8?B?ckYwbDIvZnhXTFh0NWUxdWtTT25NQ3JCWVZCdjE1c0JtQllicWowWm9OZnNr?=
 =?utf-8?B?WlVNRlNVdm5ZcTdQYnJwUzVPQkgvai80UytQL0d4cTVHcExHVnl6UTdOaCtx?=
 =?utf-8?B?SUNteXcwWnVmY0tYbTV0dEdwd2gyZS9Yc0liU2hCaWlvRmQzVE9aKzFQM2Yx?=
 =?utf-8?B?aFFhbWhnbVJqVzh2NmQzaGpGRzBQenBDOXJlMlY2TWkraXpUdjZ2bTcyRlpI?=
 =?utf-8?B?ZkN1bEZwVjdVdEhFeWdjOTh6TGxJbkxBQWNxZGptRWVyeEZXaERDZERvMWxk?=
 =?utf-8?B?eU9RL040UGZncUNRZHFraitvZmxaQVp1U0ZBOU1VdXgwbkNxM2taTEY1dHFm?=
 =?utf-8?B?NndxR2loK0srV0RFcXZ3N3BON0ZUUEU5Nmx5cWdDbzErSTZER1lTekxSMzZx?=
 =?utf-8?B?bzRHNnI3cDRlcHNGczQrb1p6d1R3K0RJVzlYOGtUYXZHNkZYVUVTTy9UNEto?=
 =?utf-8?B?dk1KWHlvNmdydDlEL1k4N2R1WmhmV1BSbThwWm9YcDdNeUJaVk12OGFsU2pk?=
 =?utf-8?B?RVRhL3F1WmY0Snk3V2NWdnFqeGoveTVQQnNVdWFRNFJIWGlFbGk5ZUozNTd1?=
 =?utf-8?B?M21qZ24zVUY5eExUQytiSmN1SEJvSHZBdS9LRWxKRGlKOGg4S1E3UUxNdXN0?=
 =?utf-8?B?V0xMRG5UTE9CL3dXVmU1dDBPWkZKVDFMNmg5UkxlemxoWUhYWXdpTzFSVklt?=
 =?utf-8?B?RzJIMmxFSUt0L3N6ckZ2anMyMlY3ZEFzOHQ0dDhkZlA4TmhTdFp1MXUxZ01y?=
 =?utf-8?B?eHRieTJMZ2hDTkZjOENJNkxpYUpWWUI4L3Arb25DS3NrS0EvTUgyWGhJeTNw?=
 =?utf-8?B?YVJDcjlRa0YvYU1VSHlIRi9tRm5hVkRTN1dzcFZwSjk3dlR1MTIwakdoQXAz?=
 =?utf-8?B?YXlkTGdwcUpSMzA0QnNLN24xUUxQMzZEWmx3VndsN2crRnAwaXN2MU5qVk1O?=
 =?utf-8?Q?OHpR+gCGhM16uVmTvy2nm0cx5iEYbXMyXCoY726bnq8wy?=
x-ms-exchange-antispam-messagedata-1: oAYe/9oxrX+5Dg==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQSGGC8SjpfeEvrOwqYzBN0NUqI6pmRTkU/XzyGKUSHCT6tt5MeGq2/eBrjUVipzOP5459Tip+cgw+IV8hICrKlIx5MdlBzRqg/mEGXcu2ByGGxzSgIGPDJpVCJKi5/zgADrfvaB8Kke77MA774BCCzcGcdOQxEBijiQxffJxUxCCwSbC9SD23Zb0hvYiGEuBjv0Rml/Xqn1adQ2rdOH8OrQBir4Yvgc9JwOCupoE5sTgDsvG/Ye7XdhFLqKDrc0aiWvI1GPboteNxhokfXXgv+cRy9RNx5WdYDG2V4B5G7qfB3TDDDIo/6X3sQnwOxlOyxwIjELLedDRr2zVR0IKQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcknUreyZU8z2xQbrjWC7yzzhxSoWtsY3ucksFiC/2A=;
 b=A1Bk69XYL0PInwn2eikujATkaXdVcbABmPS8QAMYCGxOnmEcKOSg2N1By6pAxFmYn1Us4d0dOVslckGIfKBXJXBOgZRdIHnkc6oM4JlKASyOaBfPO4UkfrkK/2o2+TJJLZQ6qKC09SfUILZLUGBDuhpo9QVDkjKpZdjWpBa2f4qVBBlIFw3qVPL01UEM/ITaoysZjyYTWD2W1SuFv57uFZgwk3rh1gjcSEAYC/5lUx5wIOXXH/yz8FgJW7PaNbbtkmEXuTRp4KvVjN1NasFw41r0K1dz+L1lfhPEBiH9FJRovQ8YrTnnfwWY1Vpifj9Bf8AN1X5RpgIfYT4RgNUCCw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: XuKqRZJHQMIdpIbVKStAzZ2XSUZyzgRa0vLeP7qnDsdbJwwXiH71e/Q8jWQCRvTil4h4Ku06lQCRSmXx22Hrq/ejdLXvPt7fVo37mH5FvoWlLRth3fj+DQKVLnw2BF3ckzMQcVdV9jyLe0dhRbCcfY7y3b4GGknHML9GwJA6LVW0EwfN0c5Ttl/YkUDBW+v8ykguAdmyhjtwecpVWKH5rzSaET/OH+9nuoTdJycHdKbXfngO27BkBy7m4wYLTWGl9Y37+oON7PrF6aJ2suyQ/CLppojFT9SQolgPRAhr/78cxne0BMSO/9l82/sEwbjfv+7aFwmLcC0kGxPpKvigNw==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CH3PR17MB6690.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 76f29a2e-5c33-4d2a-9b78-08de8b597d12
x-ms-exchange-crosstenant-originalarrivaltime: 26 Mar 2026 17:02:39.9436 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: dcfdlSv9z+SN79uoo3/7kAryu5izSbTev7ckB3OWOzIUQ7644b4GyGm6UhO98V0Ef5dSoeOwLhAHlFQvlJS15A==
x-ms-exchange-transport-crosstenantheadersstamped: SA6PR17MB7297
x-originatororg: akamai.com
Content-Type: multipart/signed;
	boundary="Apple-Mail=_80013E3B-CD77-4F22-8978-CB9DBC6651A2";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2603050001 definitions=main-2603260120
X-Proofpoint-GUID: qTPJ9n3lRqUVJ5rndlZmT6KiR_4tCfui
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEyMSBTYWx0ZWRfXxCKeGzQTNyP4
 fWknTYxstYDoB29P6qB6kph1/uYl5ZsLvVu76eqShbeh5sKQHXgFCSEuji+Iju5eqFahAiAC9vb
 A+xONFb14YAD7ehjTLwNmgjstydb10eT6BiBLW3gDnxHgMBtxRc5xUiTmN3sKld8zjoUx9B9nQ1
 nDg3G4MWD3lmDu+sF/z3TDV65IJx1bLnSHtib1w1NyRsQUQ/5AJBUlHkZGR72GTXmPgK+nndiW8
 9CxFstoLphRxeoGgElCrF+yVWpixBbGopaR+nyECJpCO+JVBApp4Vcl1gYyjBqLGjEjaLfh4EGB
 i6cOmX2XhLdQKrSb66ErV4RzpN34pi641QRXLjwZ6hxFB8CbFmQD45VpOCgkf5RCG+J5MSxog/3
 XHHfhVRmB3CRHePHbXOIW2Vkcvoozb3J0yJYP5BnagPWHUEbiZRaMXeOFODvQX2oH3V0zz07+k7
 113FN5UcsgJR551ZDpg==
X-Authority-Analysis: v=2.4 cv=e5U2j6p/ c=1 sm=1 tr=0 ts=69c566c3 cx=c_pps
 a=BpD+HMUBsFIkYY1OQe22Yw==:117 a=BpD+HMUBsFIkYY1OQe22Yw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22 a=5uIk5skAYop0meUMGpPt:22
 a=X7Ea-ya5AAAA:8 a=o5Hke2zr483Q0vMlU9MA:9 a=QEXdDO2ut3YA:10
 a=aUQEjLJJORIxqg3IqZUA:9 a=ZVk8-NSrHBgA:10 a=30ssDGKg3p0A:10
X-Proofpoint-ORIG-GUID: qTPJ9n3lRqUVJ5rndlZmT6KiR_4tCfui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603130000 definitions=main-2603260121
X-Spamd-Result: default: False [-0.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272172-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,akamai.com:dkim,akamai.com:email,akamai.com:mid];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[gmail.com,akamai.com,iogearbox.net,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: D8C453393BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--Apple-Mail=_80013E3B-CD77-4F22-8978-CB9DBC6651A2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Mar 24, 2026, at 6:30=E2=80=AFPM, Martin KaFai Lau =
<martin.lau@linux.dev> wrote:
>=20
> !-------------------------------------------------------------------|
> This Message Is =46rom an External Sender
> This message came from outside your organization.
> |-------------------------------------------------------------------!
>=20
>=20
>=20
> On 3/18/26 6:42 AM, Nick Hudson wrote:
>> Add checks to require shrink-only decap, reject conflicting decap =
flag
>> combinations, and verify removed length is sufficient for claimed =
header
>> decapsulation.
>> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
>> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
>> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
>> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
>> Signed-off-by: Nick Hudson <nhudson@akamai.com>
>> ---
>>  net/core/filter.c | 47 =
+++++++++++++++++++++++++++++++++++++----------
>>  1 file changed, 37 insertions(+), 10 deletions(-)
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 7c2871b40fe4..47aec44a9cd3 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -56,6 +56,7 @@
>>  #include <net/sock_reuseport.h>
>>  #include <net/busy_poll.h>
>>  #include <net/tcp.h>
>> +#include <net/gre.h>
>>  #include <net/xfrm.h>
>>  #include <net/udp.h>
>>  #include <linux/bpf_trace.h>
>> @@ -3496,7 +3497,9 @@ static u32 bpf_skb_net_base_len(const struct =
sk_buff *skb)
>>  					 BPF_F_ADJ_ROOM_ENCAP_L2( \
>>  					  BPF_ADJ_ROOM_ENCAP_L2_MASK))
>>  -#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK)
>> +#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK | =
\
>> +					 BPF_F_ADJ_ROOM_DECAP_L4_MASK | =
\
>> +					 =
BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
>>    #define BPF_F_ADJ_ROOM_MASK		=
(BPF_F_ADJ_ROOM_FIXED_GSO | \
>>  					 BPF_F_ADJ_ROOM_ENCAP_MASK | \
>> @@ -3743,20 +3746,44 @@ BPF_CALL_4(bpf_skb_adjust_room, struct =
sk_buff *, skb, s32, len_diff,
>>  		return -ENOTSUPP;
>>  	}
>>  -	if (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
>> +	if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
>=20
> This change should be done together with the macro refactoring patch =
mentioned in patch 3.

OK, will send a new version with it done this way.

>=20
>> +		u32 len_decap_min =3D 0;
>> +
>>  		if (!shrink)
>>  			return -EINVAL;
>>  -		switch (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
>> -		case BPF_F_ADJ_ROOM_DECAP_L3_IPV4:
>> +		/* Reject mutually exclusive decap flag pairs. */
>> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) =3D=3D
>> +		    BPF_F_ADJ_ROOM_DECAP_L3_MASK)
>=20
> iiuc, this 'if' and the len_min assignment changes below replace the =
existing switch case. Please separate this no-op change from the new =
flag validation logic. It is small enough to be done together in the =
macro refactoring patch also.
>=20
>> +			return -EINVAL;
>> +
>> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) =3D=3D
>> +		    BPF_F_ADJ_ROOM_DECAP_L4_MASK)
>> +			return -EINVAL;
>> +
>> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK) =3D=3D
>> +		    BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
>> +			return -EINVAL;
>> +
>> +		/* Reject mutually exclusive decap tunnel type flags. */
>> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) &&
>> +		    (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK))
>> +			return -EINVAL;
>> +
>> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP)
>> +			len_decap_min +=3D sizeof(struct udphdr);
>> +
>> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE)
>> +			len_decap_min +=3D sizeof(struct gre_base_hdr);
>> +
>> +		if (len_diff_abs < len_decap_min)
>> +			return -EINVAL;
>> +
>> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
>>  			len_min =3D sizeof(struct iphdr);
>> -			break;
>> -		case BPF_F_ADJ_ROOM_DECAP_L3_IPV6:
>> +
>> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
>>  			len_min =3D sizeof(struct ipv6hdr);
>> -			break;
>> -		default:
>> -			return -EINVAL;
>> -		}
>>  	}
>>    	len_cur =3D skb->len - skb_network_offset(skb);
>=20


--Apple-Mail=_80013E3B-CD77-4F22-8978-CB9DBC6651A2
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCCc8w
ggShMIIESKADAgECAhMxAAAAIa0XYPGypwcKAAAAAAAhMAoGCCqGSM49BAMCMD8xITAfBgNVBAoT
GEFrYW1haSBUZWNobm9sb2dpZXMgSW5jLjEaMBgGA1UEAxMRQWthbWFpQ29ycFJvb3QtRzEwHhcN
MjQxMTIxMTgzNzUyWhcNMzQxMTIxMTg0NzUyWjA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9n
aWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcD
QgAEjkdeMHsSTytADJ7eJ+O+5mpBfm9hVC6Cg9Wf+ER8HXid3E68IHjcCTNFSiezqYclAnIalS1I
cl6hRFZiacQkd6OCAyQwggMgMBIGCSsGAQQBgjcVAQQFAgMBAAEwIwYJKwYBBAGCNxUCBBYEFOa0
4dX2BYnqjkbEVEwLgf7BQJ7ZMB0GA1UdDgQWBBS2N+ieDVUAjPmykf1ahsljEXmtXDCBrwYDVR0g
BIGnMIGkMIGhBgsqAwSPTgEJCQgBATCBkTBYBggrBgEFBQcCAjBMHkoAQQBrAGEAbQBhAGkAIABD
AGUAcgB0AGkAZgBpAGMAYQB0AGUAIABQAHIAYQBjAHQAaQBjAGUAIABTAHQAYQB0AGUAbQBlAG4A
dDA1BggrBgEFBQcCARYpaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNQUy5wZGYw
bAYDVR0lBGUwYwYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3FAICBgorBgEEAYI3CgMEBgor
BgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAwkGCSsGAQQBgjcVBQYKKwYBBAGCNxQCATAZBgkr
BgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNV
HSMEGDAWgBStAYfq3FmusRM5lU0PV6Akhot7vTCBgAYDVR0fBHkwdzB1oHOgcYYxaHR0cDovL2Fr
YW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNvcnBSb290LUcxLmNybIY8aHR0cDovL2FrYW1haWNy
bC5kZncwMS5jb3JwLmFrYW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3JsMIHIBggrBgEFBQcB
AQSBuzCBuDA9BggrBgEFBQcwAoYxaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNv
cnBSb290LUcxLmNydDBIBggrBgEFBQcwAoY8aHR0cDovL2FrYW1haWNybC5kZncwMS5jb3JwLmFr
YW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3J0MC0GCCsGAQUFBzABhiFodHRwOi8vYWthbWFp
b2NzcC5ha2FtYWkuY29tL29jc3AwCgYIKoZIzj0EAwIDRwAwRAIgaUoJ7eBk/qNcBVTJW5NC4NsO
6j4/6zQoKeKgOpeiXQUCIGkbSN83n1mMURZIK92KFRtn2X1nrZ7rcNuAQD5bvH1bMIIFJjCCBMyg
AwIBAgITFwALeewU5YRKbvcMWwABAAt57DAKBggqhkjOPQQDAjA8MSEwHwYDVQQKExhBa2FtYWkg
VGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMB4XDTI2MDMyMDEzNDgw
MloXDTI4MDMxOTEzNDgwMlowUDEZMBcGA1UECxMQTWFjQm9vayBQcm8tM1FIVDEQMA4GA1UEAxMH
bmh1ZHNvbjEhMB8GCSqGSIb3DQEJARYSbmh1ZHNvbkBha2FtYWkuY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAx+gvYqVaQAmc/yNlMv3t5CK6FN7++3ZChJpOElnFyZWj3h+VwSqN
5WD4VQn5DL515KovgCiv63DeQ1NuXNu3XKKeakHyssixhIL2hqjlPFnsrwXJ2R9B9hAGIiOBy2rK
Var+w87AFUZ70jsZlI70IBnJOYsPYnZRmXBytTxVWk9V7Nnh10RuUfkZE2Ry+P18Z7glHYoQeksi
hz/9uqRUEqt23qDYBR1J7bB+SSW5A3LmoTEugWYzayxb9iM0vVleEHqeuN5nihGn8Y7nIrs5sIo8
6AG2Bjl0O2VgWWVfqhl9IMQlx1ZxHAicuMvDN49LD1yMkqx+LeBLboiFQQ0MVQIDAQABo4ICzDCC
AsgwCwYDVR0PBAQDAgeAMCkGA1UdJQQiMCAGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNwoD
BDAdBgNVHQ4EFgQUD8PIZa7GFc+oX4RLtUq8oUrOL/IwRgYDVR0RBD8wPaAnBgorBgEEAYI3FAID
oBkMF25odWRzb25AY29ycC5ha2FtYWkuY29tgRJuaHVkc29uQGFrYW1haS5jb20wHwYDVR0jBBgw
FoAUtjfong1VAIz5spH9WobJYxF5rVwwgYAGA1UdHwR5MHcwdaBzoHGGMWh0dHA6Ly9ha2FtYWlj
cmwuYWthbWFpLmNvbS9Ba2FtYWlDbGllbnRDQSgxKS5jcmyGPGh0dHA6Ly9ha2FtYWljcmwuZGZ3
MDEuY29ycC5ha2FtYWkuY29tL0FrYW1haUNsaWVudENBKDEpLmNybDCByAYIKwYBBQUHAQEEgbsw
gbgwPQYIKwYBBQUHMAKGMWh0dHA6Ly9ha2FtYWljcmwuYWthbWFpLmNvbS9Ba2FtYWlDbGllbnRD
QSgxKS5jcnQwSAYIKwYBBQUHMAKGPGh0dHA6Ly9ha2FtYWljcmwuZGZ3MDEuY29ycC5ha2FtYWku
Y29tL0FrYW1haUNsaWVudENBKDEpLmNydDAtBggrBgEFBQcwAYYhaHR0cDovL2FrYW1haW9jc3Au
YWthbWFpLmNvbS9vY3NwMDsGCSsGAQQBgjcVBwQuMCwGJCsGAQQBgjcVCILO5TqHuNQtgYWLB6Lj
IYbSD4FJhaXDEJrVfwIBZAIBUzA1BgkrBgEEAYI3FQoEKDAmMAoGCCsGAQUFBwMCMAoGCCsGAQUF
BwMEMAwGCisGAQQBgjcKAwQwRAYJKoZIhvcNAQkPBDcwNTAOBggqhkiG9w0DAgICAIAwDgYIKoZI
hvcNAwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMAoGCCqGSM49BAMCA0gAMEUCIBZ79THtRc/r
DXpg8rSeL4tPy9/eLjXnJvYW5Ek2SUJ8AiEA5j0Wa0K9P2Vumn7N4F5MpbHW2t/kxsdwUu2Vzp6S
5BUxggHpMIIB5QIBATBTMDwxITAfBgNVBAoTGEFrYW1haSBUZWNobm9sb2dpZXMgSW5jLjEXMBUG
A1UEAxMOQWthbWFpQ2xpZW50Q0ECExcAC3nsFOWESm73DFsAAQALeewwDQYJYIZIAWUDBAIBBQCg
aTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAzMjYxNzAyMjla
MC8GCSqGSIb3DQEJBDEiBCDwj9clNjrPDD6nG25zsiefRa2x/jOBHHbsppJGVUgDnjANBgkqhkiG
9w0BAQsFAASCAQC2pTjy/JJrv/OFqCAkjw5yXSz+3ltxLPsLaAcuYkvcwRLlIqhsQH8JSA7OrfqB
Bjoya1/D7uljHpmFGEDSkYeAqJjSeiKn2+V6oM13Ltbeph11dLSsn+Fu2Z7sH3vAwaSnSuU5tg7G
8I8qDkPu1vnA+B1/gTpkTNBxGxIsVgWJokOf5+1B4GmdXcfhLXae0ABQpi7jb1VpCm+0pSXnoq6A
WxQXSmUNeCZGYec7IjTtAqfZRDvS+fLzTmfgzYS+8BIkExDr89Z+iKtIXlUMotHHo5plR8n4DkS/
Jet/cykEhUBO5n30RxCIMENTsDWIUdSHv+f3L5VcKiyrDd2NsFqLAAAAAAAA

--Apple-Mail=_80013E3B-CD77-4F22-8978-CB9DBC6651A2--

