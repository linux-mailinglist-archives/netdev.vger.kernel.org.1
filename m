Return-Path: <netdev+bounces-94810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B328C0BD4
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 08:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B6E1C20F4E
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 06:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7098413C830;
	Thu,  9 May 2024 06:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qLm4lh5J";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RWoCmAWG"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F53637;
	Thu,  9 May 2024 06:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715237954; cv=fail; b=rb+JRwwJR4fosEb7rjOWMzydh5dnceNerl47dVPolKRgxstcyZvVC0qhKolUg6+oMXcldzfhakh4g/vj8s6SdHtYwVZ1EAsPIVbfN+xgX3joTqonVgabCdh6SH3La7PdvFxoL64wA7xYUkQ8l5BN4q14i7I9nBedn9+y8nfvNHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715237954; c=relaxed/simple;
	bh=/J3YqBiAfxGjPSa2HOMfGv0vGJuLnpGdDIXOdtL3+1s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e/0aEpGe6UJu8Eokw+aiQJCydkENlwzr1jfassgtiVg8KGNkXDh1c4ZjYT3DfxJhar+por+X2qGnIStPqoQ8gwTuuoaYP6ZVgqiXv4ZAK/h9GLBEF4w80QhfPEZiEkLwPW2CKyElLzBCvndzFpbNmfGWR1VyzzfpgbmUyPEI3hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qLm4lh5J; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RWoCmAWG; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715237952; x=1746773952;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/J3YqBiAfxGjPSa2HOMfGv0vGJuLnpGdDIXOdtL3+1s=;
  b=qLm4lh5Jb2Ow1Uw45QhJb6/9FpqHfN5fH+SToHgkrFpxcHm3Fi/cCbrF
   jRAyKqYAWPoY7huVnMG8ZXYPzCaRoGDDNbaKz7LgcPRM1hOVkE+Mfes6a
   QzRYHBWW4Cd9RPcXk0Urdn3s78zMv4irqY6EhkVRItfwqngTQh1GFw3nP
   2F+8qLe/R6pcPv8Vy4mtyU3Fa4fteJm70KOTuartpJ3xmz6Bh6bnAESjk
   z6qxNaCTz0YItD7OlyT2GwBWgJEKIbA5FXesPJTKnN61diLUhQUk8hyOb
   FzbS+uSenRlyLMh7xqDZX/HZpOdndCnasC8qmnTv834TXWT2OnB85r/rx
   w==;
X-CSE-ConnectionGUID: GNRYmCwMS4CgryDxK7uw2A==
X-CSE-MsgGUID: 0zaFJhDWT3+Ro1W3vTEymg==
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="24281477"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 May 2024 23:59:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 23:59:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 23:59:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxqTx9PARRmpg5SiegZTn+szta+auvBpEc2ExPIZLmiO8RN8HZXa7knk79txTad5JZS9pPsDdEPZGJ+HFqF/N10+2AySh2ZGyIvMYcJBBrD9FjAWGhx379CGOAtB9yDGYczB0PAPrkwvqSeTiYhQVoMOlY+J/jLNaJ1pdA0P1LpgXIbKbq1C90A8zZdW348jcC2b/evJSq7Tp6Nay7pftTCgSbdTkAGDkt4iT9uZ0WsxHBJYQMU7zF42H1vA84RHMIouXa6PuJk8+PVJf4V8VHahWKQXXCyVnJE4Kyso0VZPd5tH8tiplaA9J3CQozZYSyx/+93dtRkrLDr2WgxYXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/J3YqBiAfxGjPSa2HOMfGv0vGJuLnpGdDIXOdtL3+1s=;
 b=KEI9MtUq8WODcXxEYYNHfhn57FVqRKJFUYE+bx21brWwroXLXYbS3XIBkqm7kqgwfhHJHeXrmNaYnyEPc26adTKPQGvHrB+oOabD9jRr4qarJVqgsxR69UpwHJ7drAnZAw1mePTppDRfq+FV27cURXFtlZFQ4vi06hvu4TF8HflS+rq8jkz34gNpqVQhoRXz4Ue09IUIAD29NvLZ+2yHSYxcTvYH7txnLDb/ynmPtiXBY70Sv1lZyNa0eEmM9OncVwEQbO/MDn3dRYKK8i+0BhpR4rMig4lFjKYeh/hEk/ktdL6oRpBc3ZqlmNEHEINc5H8rmHAMM04qNlLpvCPjcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/J3YqBiAfxGjPSa2HOMfGv0vGJuLnpGdDIXOdtL3+1s=;
 b=RWoCmAWGb64jbJGtAkhfQqN0Bcyze0fqYxpJJwaYfbgzQxysV02aIrLTPEQH1B2rLFo6N8Ok8bCCVGJKShNYYGPQ85Epyy4+n1PjnXwLsotY3nacwiqWT3N6Qr5GScRlVF/JTPmQtdt1cU2lCow9GC0DkCZYw0xp8UJWKG03wRY4/KHfyBMdsyCSuGlEv5Q96Gg5g9ocgQD1Ix6ESF92Oy3Wgdfo924Ay3oBQAeqmAa0e/PMufiUZH6kxY6rnifXKHcWiHqCCFMg2iM4rLT5HigOuHr6HY8yIJcdjCPeemx0Z1kGdgFdEbpxmkyGOQXsoaZ5awhjC4uCfu1SOrzr+Q==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 06:59:04 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f%5]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 06:59:03 +0000
From: <Rengarajan.S@microchip.com>
To: <horms@kernel.org>
CC: <linux-usb@vger.kernel.org>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <linux-kernel@vger.kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<UNGLinuxDriver@microchip.com>, <kuba@kernel.org>
Subject: Re: [PATCH net-next v1] lan78xx: Enable 125 MHz CLK and Auto Speed
 configuration for LAN7801 if NO EEPROM is detected
Thread-Topic: [PATCH net-next v1] lan78xx: Enable 125 MHz CLK and Auto Speed
 configuration for LAN7801 if NO EEPROM is detected
Thread-Index: AQHanE0W355Z0SUftkipxbImkHa6jrGGx1uAgAe9mIA=
Date: Thu, 9 May 2024 06:59:03 +0000
Message-ID: <d5727bf3d176e3d71abeba7f7c3aa86cf96262cc.camel@microchip.com>
References: <20240502045503.36298-1-rengarajan.s@microchip.com>
	 <20240504084931.GA3167983@kernel.org>
In-Reply-To: <20240504084931.GA3167983@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|SJ0PR11MB5865:EE_
x-ms-office365-filtering-correlation-id: 3fa80f32-ccd8-4788-2fc8-08dc6ff5830c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VW10K0JCbk1kM0lEWnpSTlQ1djZwenliVkhnRzVyNEhCYzA3aW00UUdVVVUr?=
 =?utf-8?B?S3VUUGpRaVJCSTRNZ0tQR1lTR2xVNDNhdWozZ0JicldCYUtDQkoycEVWVXd4?=
 =?utf-8?B?R2RWUTlnM1Y2WFlDRi9JV0M0M3lqSXlac01zZ2REdFI0U3ZoMjNESnAzd0xn?=
 =?utf-8?B?ZVlRT1VlYzZPYWk3b08yN1F1dWY3MmNPR2habHY5TTdSMjdtc0JiLzg0bmxF?=
 =?utf-8?B?NTkyeFhQY3NoQUd0YTRNWEMxSWJoVWZWdlE2cmszZ2gxSHNROTVDN29keWNh?=
 =?utf-8?B?NnpTVThFb2h1cHZsUWtpcWNvN0NyQkdOOEgvM2F1OXFkRVN1a2JYM3A5QWcx?=
 =?utf-8?B?bGNxaWVQQXRwSmVublZtbTF5RHNheHNUa3BkV1RiTS94cU9YT3J3eHVuN1Mw?=
 =?utf-8?B?MDYvY0Z5WGMzcVpmNTVqaE9CUmdLWENJa0NxYWNOSUpJajlOczZ4eEtUN3dy?=
 =?utf-8?B?OVhKaTdFeWx2N1J4U1BOQ2tNYUJydkxXcUFQVjV5K012S0hWS1l1bUpIVTBW?=
 =?utf-8?B?M0c4SmNvdEZNWVNLS083cERwcWRzWERTek5ERlFtMms3aEI2ejZZR2dmaE1K?=
 =?utf-8?B?UzJQUnlBaUl0aVhlSEtEZ1BFbHcxNlNDbmhpUU5FdndLbnBGbzVMcDVDVmNs?=
 =?utf-8?B?U2FFRDN5bnAwV2JmY0RRSnBZSEtwcTd4Y1N6ZGhmaU5HRmVZRzF1QUNUSFEz?=
 =?utf-8?B?NUdrb21yN3ZYQzlYbjFCZWgydEEvbHRiUFd2RzhWaEYvVmtKQmdkcUJWd0Fz?=
 =?utf-8?B?dVFsSHFLbnZpeEpxaGZTeHpqSE91T0grMjI0d2ZUclBkcDRVME5aaUtHZEJm?=
 =?utf-8?B?SWkyVkl1bVJrM2lKS0dQaGZHQWl0UitrOEtKVXliZEFvejRYSXR3VWptZkQv?=
 =?utf-8?B?VHVpbnp4L2dMUFMwckRPUmdYY25sdEdFMisycVMwQnRHYTNqUWpiMjVQSVZz?=
 =?utf-8?B?ak5PV2Z1L1dGd3RzY3JZSE96OGtMNVBRMitjMTdKMnRIZHlGcnNta0VzTVBQ?=
 =?utf-8?B?V2RvVFV0Zm1FMklxc1BrZ3JTdmJ0Y1ZaaExkUTNHeitDRXd5N013VDIrcVhi?=
 =?utf-8?B?WW43YW83djdOSmt2RmZYejNOWG1JUGdMZUFhNXdjZUJqT3c0eEQ2ZGZpNVls?=
 =?utf-8?B?emNQRFZ3UHpvQUQ2KzJTYnVOZWNadG1IU3BxaEZxODF4MXBWS1loNFlibUYw?=
 =?utf-8?B?QzJYdXFMT2d5Zk9SMENLUlVETmcyc3JUSkQ3bmVtT0t2c1BycnMxSnRnNjIz?=
 =?utf-8?B?RDlCYVdXZUtQOThIeXFIOXluaDVXVXhvVmlTYUFydTF0bFdlOEZ6MUZ4Y0dW?=
 =?utf-8?B?WnczVFp2aXphZ3V5cVN4bjFnVFpqc0ovYVVDbEJ3YnNJc2VxMHhmaWViMk9L?=
 =?utf-8?B?eXM5OUovK3VGMmt3Mnlldnpua2dienFqdmc5WGZoWTBwUDViVGhkN3Y1WXdh?=
 =?utf-8?B?bmJiZSsyQ1RTd0pXQVp4WEgxNllJQU4rRkJUaWxTK05SZ3hncE5JMFBsZmF4?=
 =?utf-8?B?bG81Yi9RVWErSTVDZ1A1L1RvQlJCMjVjTU9hQzVJdXRLM2hPeS9rZzRhVHJy?=
 =?utf-8?B?RnVPMnQxVlZFY0tCUUZ6NnF5aDl2ODRBeWNXRHBkSjhaNmljdHUzdVBtcXdm?=
 =?utf-8?B?UWdwMXdmS3BLeFU4YmZDUU5EOEkxUzZvTmM1L1VrM2xiS2hLTHo3MEM4UW5a?=
 =?utf-8?B?dG5KTmhia0JxZm5LbTJmUHJXaXZTN1llMHBDZTRnNzFxaFFSN2VwVW5NRitB?=
 =?utf-8?B?VlZkWmRJNzZ2aHhWdnYvSEFPOVBycEFYWTZLdDcrT0d1ZUJMdHpRYlp1SzR4?=
 =?utf-8?B?MXVnQjhScllnTEJaZ0ZIQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXVFbmNhRjNoRkNMazMvV2lqeEk4MHFrS242bVJJYUllODZVWXVLcnVrUk5H?=
 =?utf-8?B?U1k3VldJaW5BcWxOZzROMXhXQlU5SkVzV1NKRFRLK1lPYTR5UHVOT1BiaSs5?=
 =?utf-8?B?WmJFVzBQVG16M2l6cFZpR0c4eTdzNGdGNmNNbnZOSm5CWkU0aVBRb1J6SFBu?=
 =?utf-8?B?TTluekdqVEV0Nm1GdEQyOWJvc1FQa2xhRzZkRDJ5ZkpIOFZOWlFTeWk0ZjVH?=
 =?utf-8?B?NHNvWkFxTVIraUJVZDZrZUZ3TE1yWlpCc3JweUlNWXowWGNuZDAyZlhVYU0v?=
 =?utf-8?B?blF0aTZaQXp1bCszc01DdS8ybTEvM3d0NkFHc213VWJkcEthSVhtK3VBK3VD?=
 =?utf-8?B?L21wQUE2cHFveXQ4aC84c21oZDRPeVN2WWk3QW1iRUw2UUM1anVrR2QyL3Jk?=
 =?utf-8?B?T29RVlJETlJKWW4rRThzcHljanRTdXk2NHJNeE5rQzFMcUdwaXVGanB4Y2Fp?=
 =?utf-8?B?U09qS1V0aHBSVFRZTFpZQk5XUlVHT3BGVlZvQ1gzNDc0T2drSkFOTjBSNStw?=
 =?utf-8?B?dG5CTVplR2ZtcjFhaERTdWNzeFR5QUcrSXN6RTNCNGxLcFkwNTR0eHJVaW1E?=
 =?utf-8?B?ekEyTXdtSjQ2ck00dTlzdkRNdWRxbGx2QWswdWFRM05aQTZTSUhnOWJYQ0RB?=
 =?utf-8?B?Y2QvRVdFTVp6ZUZXYzJ0WlpLVmVPRGd2RWFFblNCS1ZsSy9hUFZhSnpFUFBu?=
 =?utf-8?B?NmNzWmVqV2xUTGRIV2U3K2g3V0tlaEg0RytEZUdROHVXSUc4aVkxL0tPQ1ZS?=
 =?utf-8?B?V0dRQlJScjBzbzM5c2RSRk5BSDA0aFVCeVVpaUNGME44dXROdUJVcEJ5N1Nl?=
 =?utf-8?B?bzNSM2U1WDZGYTgvTHZZY2tDdUhPVW84b05UR0NDeUlGVVp5VmJuNTFIRDdU?=
 =?utf-8?B?MUpQMXRyNktCSUJVTWhEQW9ORHlKMXZuVVdrMFJvZGltVzFBeW1IemZESWVp?=
 =?utf-8?B?emRGUm5hcnJZc1l0SFpxZEFhM05DelBDWkNyNkJWZ211MEdCazVDeTFYUExP?=
 =?utf-8?B?OWQ2RVNwdlVpRWxTTXhEMkpTTk9hYlBneEgyZHcwbE5QSDZ3WUZJT21SRGU4?=
 =?utf-8?B?OFJSYXk0WHV4UU5VelRnMG11Rndkb29FcHZJdGMwRG5haXU2Q0h0SUlxZ1Bv?=
 =?utf-8?B?Sk4vbmVhSnZnRVVyTnJ2M296a0I3WGwveUNwN2w2ZVV0MUJ4TnZmUWFwa2o5?=
 =?utf-8?B?Sk9lcjRmNDNqRGc0azBVT1VmSmVaTlNJa2RtM090YitDV3BKMW55dDhPQlVT?=
 =?utf-8?B?YlhqNjlhNDNGbkxyZmRCSmFNRmltNnZxbjRrQ1lTWXhJd1pOMnhxS2V2blM2?=
 =?utf-8?B?UFBuOTNQdkJVbEFFTUY4OTNGZnNhM3UrYlpkaU04TGNYcGRFbXluTHpLejZT?=
 =?utf-8?B?OVdGWDRDSTl1NVFNYXVjY2tYMTk2aFhUU25nTEE5Ym5maCt5Y1hWTm02Tnk0?=
 =?utf-8?B?bXBNWDYyaldTdXVDUkd1L2poUFBQL1E3Z1BEQk1NaUZVQTZrYWMySkd5L3Nh?=
 =?utf-8?B?Qnd0Vi9jaTRUalhLbGo1bEdJc29IYVBsNGtIeVhRYVBiZ040ZzZtOVl4bC9X?=
 =?utf-8?B?SkVZeWZPcSt3eFFGVkJ1YTIxTnRKbHk2WVJkQnU0YU9WU0phY0ZCQncwNlNv?=
 =?utf-8?B?N0Q2Q3pMYzN4QUlISzRPVUFsYzFSTG9qZkNLNDh5V1JnQm5WSlNNTCtOb2JO?=
 =?utf-8?B?YzBXU0t4Z1FZUE5DcHFUdFEzd2ZEbGRsbkUyendQTkd6TGtvWlo2YSs1U1pK?=
 =?utf-8?B?Qk1hQVNCaDBIUm1yeEN3czZTYjgxNWZqbTV0K1BlTHYwclp0SWhnQndyRkR4?=
 =?utf-8?B?RkxIT3dWY1NZODlSNWF0b21yUTZGUVBBUHN5ZzMrUmZ0eVZ4OG5UNmVJZkkr?=
 =?utf-8?B?STZKQzZTaExDbTcwYmVPNC80MHhMQTlXZFp1cmJJcDFkc2tjbHlaeDNNaUt0?=
 =?utf-8?B?Z1hzWlhxcGViUlZsUXNNR1JCcll0SXFJMnM2bW5KUTMwVDR3TVlZTGp6emp2?=
 =?utf-8?B?dWF2S1hPVUZXRFNzLytSNU96cCtCd2s1NU1DS2I5a2NBOWFWVWd1OWlFTlRJ?=
 =?utf-8?B?cXNXc1hodE1nYUJPTlZMbm5pdzRuNDRiT0gwVTNtZnZpTkNIaXdqbThua1I4?=
 =?utf-8?B?dXlsOXpFVzNkeThYSmVZd1hxa1QvWW5tUXpkSGQvN1Z4Wk9yMGxlUUQ3b2Vz?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A02E314CC4E4014481DDDD30960F12C9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa80f32-ccd8-4788-2fc8-08dc6ff5830c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 06:59:03.5513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S/pyyqjWNeNSIq24lDQZf7Upnt1WC7ZO0hDFLeRplGHgcMqk6x8Pb+e1j11sI/HquBaMbQFVnxVxpISeP9r99jL3LRv4Tx1n7ZfSJHr5HPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5865

SGkgU2ltb24sDQoNCkFwb2xvZ2llcyBmb3IgdGhlIGRlbGF5IGluIHJlc3BvbnNlLiBUaGFua3Mg
Zm9yIHJldmlld2luZyB0aGUgcGF0Y2guDQpQbGVhc2UgZmluZCBteSBjb21tZW50cyBpbmxpbmUu
DQoNCk9uIFNhdCwgMjAyNC0wNS0wNCBhdCAwOTo0OSArMDEwMCwgU2ltb24gSG9ybWFuIHdyb3Rl
Og0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFRodSwg
TWF5IDAyLCAyMDI0IGF0IDEwOjI1OjAzQU0gKzA1MzAsIFJlbmdhcmFqYW4gUyB3cm90ZToNCj4g
PiBUaGUgMTI1TUh6IGFuZCAyNU1IeiBjbG9jayBjb25maWd1cmF0aW9ucyBhcmUgZG9uZSBpbiB0
aGUNCj4gPiBpbml0aWFsaXphdGlvbg0KPiA+IHJlZ2FyZGxlc3Mgb2YgRUVQUk9NICgxMjVNSHog
aXMgbmVlZGVkIGZvciBSR01JSSAxMDAwTWJwcw0KPiA+IG9wZXJhdGlvbikuIEFmdGVyDQo+ID4g
YSBsaXRlIHJlc2V0IChsYW43OHh4X3Jlc2V0KSwgdGhlc2UgY29udGVudHMgZ28gYmFjayB0bw0K
PiA+IGRlZmF1bHRzKGFsbCAwLCBzbw0KPiA+IG5vIDEyNU1IeiBvciAyNU1IeiBjbG9jayBhbmQg
bm8gQVNEL0FERCkuIEFsc28sIGFmdGVyIHRoZSBsaXRlDQo+ID4gcmVzZXQsIHRoZQ0KPiA+IExB
Tjc4MDAgZW5hYmxlcyB0aGUgQVNEL0FERCBpbiB0aGUgYWJzZW5jZSBvZiBFRVBST00uIFRoZXJl
IGlzIG5vDQo+ID4gc3VjaA0KPiA+IGNoZWNrIGZvciBMQU43ODAxLg0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFJlbmdhcmFqYW4gUyA8cmVuZ2FyYWphbi5zQG1pY3JvY2hpcC5jb20+DQo+IA0K
PiBIaSBSZW5nYXJhamFuLA0KPiANCj4gVGhpcyBwYXRjaCBzZWVtcyBhZGRyZXNzIHR3byBpc3N1
ZXMuDQo+IFNvIEkgdGhpbmsgaXQgd291bGQgYmUgYmVzdCB0byBzcGxpdCBpdCBpbnRvIHR3byBw
YXRjaGVzLg0KDQpTdXJlLiBXaWxsIHNwbGl0IHRoZSBwYXRjaCBpbnRvIHR3byBhbmQgd2lsbCBz
dWJtaXQgdGhlIHVwZGF0ZWQgcGF0Y2gNCmluIHRoZSBuZXh0IHJldmlzaW9uIHNob3J0bHksDQoN
Cj4gDQo+IEFsc28sIGFyZSB0aGVzZSBwcm9ibGVtcyBidWdzIC0gZG8gdGhleSBoYXZlIGFkdmVy
c2UgZWZmZWN0IHZpc2libGUNCj4gYnkNCj4gdXNlcnM/IElmIHNvIHBlcmhhcHMgdGhleSBzaG91
bGQgYmUgdGFyZ2V0ZWQgYXQgJ25ldCcgcmF0aGVyIHRoYW4NCj4gJ25ldC1uZXh0JywgYW5kIGFu
IGFwcHJvcHJpYXRlIEZpeGVzIHRhZyBzaG91bGQgYXBwZWFyIGp1c3QgYWJvdmUNCj4gdGhlIFNp
Z25lZC1vZmYtYnkgbGluZSAobm8gYmxhbmsgbGluZSBpbiBiZXR3ZWVuKS4NCg0KVGhlIGNoYW5n
ZXMgbGlzdGVkIGluIHRoZSBwYXRjaCBhcmUgZmVhdHVyZSBhZGRpdGlvbnMgd2hlcmUgd2UgZ2l2
ZSBhbg0Kb3B0aW9uIG9mIGNvbmZpZ3VyaW5nIHRoZSBjbG9jayBhbmQgc3BlZWQgaW4gdGhlIGFi
c2VuY2Ugb2YgdGhlIEVFUFJPTS4NClRoZSBjdXJyZW50IGNvZGUgZG9lcyBub3QgaGF2ZSBhbnkg
YnVncyByZWxhdGVkIHRvIHRoaXMuIFNpbmNlLCB0aGVzZQ0KYXJlIHRoZSBhZGRpdGlvbmFsIGZl
YXR1cmVzL3JlcXVpcmVtZW50cywgd2UgYXJlIHRhcmdldGluZyBhdCAnbmV0LQ0KbmV4dCcgcmF0
aGVyIHRoYW4gJ25ldCcuDQoNCj4gDQo+IC4uLg0KPiANCj4gLS0NCj4gcHctYm90OiB1bmRlci1y
ZXZpZXcNCg0K

