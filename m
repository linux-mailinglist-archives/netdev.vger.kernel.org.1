Return-Path: <netdev+bounces-94567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAD18BFDF2
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9997282877
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4366A338;
	Wed,  8 May 2024 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="o6YxyeHh";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kn3RcuWX"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37495820C;
	Wed,  8 May 2024 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715173529; cv=fail; b=uovpHsz69X8mTluKKV73MIQlYG0krAGDGCV266LMNS//pqONf4qt811kaxYhFT9jhJ5yv5dg5Sb7b+dH7m6DxuZKMQjTrJUpUCRpolvY1oeWhWOezkkgzJw/PeotObFzDSxQG0vw/huVAPVrBtRzvtWxgq1x3PpjzUPyldrsltg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715173529; c=relaxed/simple;
	bh=i4bIF7sW0y+LdtoMRYC4BvSRDdPDSIOS+nlt6VcT4is=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PotbECGlCf2iBphKwvXiueHK28Led/gzllSehl6Z1lpfGgYlOZK8OJ95JsvZhC/YwRYdTy3MMobD6VK/HxP+x626UfIruAJ+GO4ic5VJ2TrBKxZcAuRvJnd4k7M65kBGgOkVtcdep1Ue5Nxe2SvohXNTWz8iWNgmpUQY6H8vQCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=o6YxyeHh; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kn3RcuWX; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715173527; x=1746709527;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=i4bIF7sW0y+LdtoMRYC4BvSRDdPDSIOS+nlt6VcT4is=;
  b=o6YxyeHhPTiEVRuU1THWGn2J2q62C1aHh0ayDErjt+X0pQqtvNfTox2X
   hx5ZqSmDZEtrN7KmvI9zTGkRFE6KlOMYRVeTQV6EeNcJbiCbuDoTSoxlP
   5AYB1FxwVwCm85aY1WHg0thM9oG3UL9B9F5mdXUzlL+btuav3RqfmgpHx
   5U5OQV1nAep8+GYSuh4NlOKa5QrCXJBQwVSQ88pLNOwrmMbUXyllk5JZY
   8DyAOaSx2CNwxcBjtiQwlS+23WhtodPoi7SnzoMXwNLLJC4mRzs05bOf0
   1zRiAlHuUL3kADBcA49B27TO6ggxeibViN2DuZtIXSnL5zXtNXbvXwJ6A
   g==;
X-CSE-ConnectionGUID: EEbITJUsRN+oMtVk+LCjUA==
X-CSE-MsgGUID: 6QS51YNTTnmS/aXBFTheXw==
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="191474742"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 May 2024 06:05:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 06:05:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 06:05:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivcLl1LWtjVi1uq5xBf401KCsXZXbJuUae8T24dIiyII71yvKmWIINc9kScJKLD/Y3kecHF+x0X1jdubRCTdYRvrkc00JlZEln5xXKMp8281IqdYfnz/9mzKDRUyW9Fj2UCZp/uwGNe7KxlcrZYN+9sq7q8p8R+JlM1UAjWli9d6Ak6nMc1a38mBFOTU1ex1gWg5SgDT9ecX860HmQhSj34a8+IlwUX1z7EKHE2F2EVvHrtwQwvS1cqJdu6Xu8ukAiH0T84XTx/1BCzilRdMAEPJmMQVATnEwWy9l0sClgExn7uar9yJfNMXhvUSHrW9GIxuB0wiSl8vfEzW8QAmlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4bIF7sW0y+LdtoMRYC4BvSRDdPDSIOS+nlt6VcT4is=;
 b=cWUMeDysFEEl4NHXKaghIoNbDjAt71HcbxrjwmRoyUqlcKycLbEy/msX4EXJp3ZyjHr2l7fhOtSloKK7V9eKGRsG4nmreap1chMqiSswLr/lZQMfxxsYTnTUPaff0cSAto5K0W93akOtLrrX9wiHKignBXaoZxqp5ucu1110sJGNts3BzaahzRsVtivqjFTRbXVETx0iUnvp9+c0fiwPRdsmrRFif2t48d7gWQ/3dm1JgUMyxFDxVNg1qYlF+ppnVxuh94POBl1uEnj1O9jTh6UriXrAhjh0o11MvQxa0lM2jMO2sk6Dpkfw+DUSILfU6F4iDfcQsTTdJrc7wqU6Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4bIF7sW0y+LdtoMRYC4BvSRDdPDSIOS+nlt6VcT4is=;
 b=kn3RcuWX/5HdQunOTJCOma8+DLUuEzi6HwEcpZ1HZbe+6zsNa30TjmWJkQAHN+HM2khtyxsvZjgJqmetP0fr3EcNcq/Eh2XOje34ChGuRuog92aBc3xnw4FqpbtsS6ftamyB0GdPAZbkIVakbakkMCHRRmC/qcNBDcJoU/hWLlD6HFXT2rO8wA4GsYKhU+lrWnbr7HKAJSQj5OH883cVGHb04xve+PJjvYX2+zpgWrgNr7KyH1T5+Skvhbbs6H97yR3c2rW1+2C9I6ECX9PsqJdonn36Y0EGL0YOgEOhEZLqt8H4r2U/5R3UkfyQPOKfdYIxnKfTFqyLgncjyJi9Tg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by IA0PR11MB7282.namprd11.prod.outlook.com (2603:10b6:208:43a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 13:05:13 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 13:05:12 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Topic: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Index: AQHakY/2Zb5TFJZ12UCHjfgce9+PGrF0voeAgAA2YoCAGHimAA==
Date: Wed, 8 May 2024 13:05:12 +0000
Message-ID: <2d9f523b-99b7-485d-a20a-80d071226ac9@microchip.com>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <5f73edc0-1a25-4d03-be21-5b1aa9e933b2@lunn.ch>
 <32160a96-c031-4e5a-bf32-fd5d4dee727e@lunn.ch>
In-Reply-To: <32160a96-c031-4e5a-bf32-fd5d4dee727e@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|IA0PR11MB7282:EE_
x-ms-office365-filtering-correlation-id: 31b74264-8afd-482a-fae1-08dc6f5f7f54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dWhOWnVzcGxSc2dhNVp6Y3pNY3ZSZmxQZzBZdEdoQzhFdXpML21abUdmeEdL?=
 =?utf-8?B?VHNkZzg0ZEJGR3paOHR4S0tueXUvZXFva0V2NTg2TlVSZzg3K3c0ekI5dG8z?=
 =?utf-8?B?TGtxdDJ6SURwMjk5WWNIRWk0R3M1cGREN1VsaHhMVUZ0b09qS1BGaStqOEtp?=
 =?utf-8?B?d2lsVkEzYWl1dHJsZ1hZdnJVOTIxbnhQL09idDhsZUwybnZYY2tXRGNvTGNn?=
 =?utf-8?B?ZzhobkVnUkpOY0hUNmVpTUN3YlhIWWFGaDlGeVRNOGQzS2hiU21qb21JSVhG?=
 =?utf-8?B?aVJEajhZUkJUSXkvV3BPV1c2Z1Fvb2ZGcndCc1BrUlp0N3p5QjMvaFBzZ0hR?=
 =?utf-8?B?cnZtSlRhbjBnMk9DYjJ1ZnR6QTlzNE5XUDdlMWx2N2dRMW1KSVpaaHJ0Q2la?=
 =?utf-8?B?K2dVWm10SFIrL2d0bEZIbFdhM2xndVg3bGdYZVFyazBCcFd2eWNma09PT2FC?=
 =?utf-8?B?RUpFem1zWXVkdndqVDZxbE9sSHpJNWdzNDhIakhJZmwzVGg0czcrVFpIRzNF?=
 =?utf-8?B?b1hJckpCZWJJakFBU29HS2JXK1VwdHRXdy9KaWhFVkQ2K0tMbG8rcnVObGpH?=
 =?utf-8?B?cnJLWjFrM3BGWDYzUDFtV2F1T01XS0tMZVZkZlBsSjk1WWZ6QnZXM0RzeXlz?=
 =?utf-8?B?ZEd2aE13bndtblluOVFrSjljZGxXQzhPekJnOWFrZUpueDhoOEhnM2RibTBa?=
 =?utf-8?B?bWVzV2ZNMVJYNENIL0JBb0lCdnR0cExJNXVsS1MwOHNsUTIvbkJLaEFLb2ll?=
 =?utf-8?B?QTYybllVQktjM3R4Y0JCemFLQ2E3TExEdHJpM0t2aFpUR1VxU1dsc09LVDk2?=
 =?utf-8?B?NHIvWms2Yk1QQ01QalUwS1dmajlwYm5pNU9ZYXdHbXhVTmlDc203dG1GQ2hO?=
 =?utf-8?B?UE9sSjE5aThxMlJQalJVMEIwQU5UQXltVWdaTEFVUUVvRno4cW10U1hrSnBk?=
 =?utf-8?B?THN1OXhxdFlML3JhNVcrSnoxdjRhRFZmRG1Gd2c1SVd0UUpZazZaNWFuYVE4?=
 =?utf-8?B?SnNadVJzSnNCWjF1VUtQdXNYMTlHeGhmdVl5MU5XWjVrdmxaZ3JnenFCQ0tQ?=
 =?utf-8?B?YktyajRJOXNjR1FVVmlhbVBtVlJRVmhlM2xXbGx1MUhjRGcxT1Y1bmFTYk55?=
 =?utf-8?B?K0loSFlxdlpOWUwyV2IrYW9sWVFRcDJjby92S3RwV1pJNWFCRDY3bU9scjl2?=
 =?utf-8?B?SHRCcERtMnZQbGxGakFIMGlZVVF1UmpiNTh5QVJ3YVduTEZzeTlXYWVrTHlr?=
 =?utf-8?B?bFo3dzJWQlB3WE1UM0VaVTVjamxicW5Dc2lleTRnV0V1aHIwQnh0NXBIOG4v?=
 =?utf-8?B?T0FkM2IyOFEyQWdLYjVjcmtUZWhycXBuNUlLZ000NFU4eXZkNG1VK2xvanhZ?=
 =?utf-8?B?aytYaWNnT09CL25xZmh4K3RuVDJIcWx5OXlHWTltNVV1aVloOElxay90VnpR?=
 =?utf-8?B?VnNIU1AzZElqM1ZDQStmK0xVcno2VmVGbHRoWEFWdVVBZVJOREEyYkFObkV4?=
 =?utf-8?B?emhlYzV4eXA0V2k0MkxFTzNleVRkdGE0dGFmVHdDLyt1R1hrT1IybzEwRlVE?=
 =?utf-8?B?UmtEa0k5Rk5nS016eVAzV3kvUjhhMkZaUjlpRVNQdTVHT1FUMm55Qms1K0Fx?=
 =?utf-8?B?QWxuSVRLL1R4WUNZREdEdk5DMVZpNldiWjlxZ21DL25uclEvZ0FUbEs5emN1?=
 =?utf-8?B?TEh2VlNYWTFnRUpXMHhaMWpPZkt0bllKM2pIZnZaWFBkaStJbk1LWTQ3Q2NB?=
 =?utf-8?B?YjN2eDRSM2tDL3hMVlV4TWI5ZUlMY2N2RldPNlNGWHJNREUxcElwdmdaYno0?=
 =?utf-8?B?Rm44N3c1TE1jWEFmWkd4dz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXR5VGRTVnp1RXI4MFdLeXNjb1BXYWlzUzFoWXFzVE51cko5Uzc1SGRWZ0JY?=
 =?utf-8?B?dHZ6ZUNKclhZaHV2RnNHdDNPaC9CVWw3MEVoTWxuU2RPcmtoUzluSGFZTXhE?=
 =?utf-8?B?eWRBVlZ3ZXh4aGl0Y3B4TE5wZWhPcW5NbXZvMmc5SlBIQXRkelFyWGgrWDMz?=
 =?utf-8?B?QUR2U3ZaTVZ0Zkp0bWgwTmpmaEpoQlRxNHB0RmdNSEpkeTd1V2tMajBtVDRR?=
 =?utf-8?B?cEVGMk53ekNYQzk3TGNmc0tjTFlreEFEaVpBZGx0ZmxPc0Vzb2F3TnpIeWtF?=
 =?utf-8?B?RlBrNzN6dm5wT2xCUjJDVVo0OGZkbUtSeWtFWTVzZk91eFlVWTJ5a082MG56?=
 =?utf-8?B?Mk1FZmdXNkozREc2T1doK2srQlFNdzFac3pKZU5ROTdUSzZ3OGtEK0IrcS92?=
 =?utf-8?B?c3BBV2FvdFJ0K0U0aHlYVVdVOUJYbGlUNFpuR2kzWW5pTjgvY2IwTENiNjhr?=
 =?utf-8?B?Wk1rdURqTWMvU0Q5Zld1RmtyNDAwSGlETnJDdEk5aUpRYXRsRk52ZzVSak1Y?=
 =?utf-8?B?dGdZSWgyYWUyTFhoUm5PSUw3eHBtU1FtbEQwL280bUcrU2xpVnJyN1hxTE1K?=
 =?utf-8?B?QTFvcGNSai9mN0NLb243QXR4NlZQd3VNQXNzeUtxMjdyWDVyb3FNUmJlZXZ5?=
 =?utf-8?B?OWR2aE1PSW5qQmFFZlB6bUZqdTJ3eWxvVHMxTEFEZGpEcmphWFp3cWZHV0NH?=
 =?utf-8?B?OEVtRisvcENvdVJ0ZVNXc01rajV1eE80N25HLzhmUEtsaFo1MHVMS0s3amNB?=
 =?utf-8?B?ZjM3dDRFbW5MZGtBSFRpRFh2V003L24xTmFjQ0svNFZaVS93dnN6SEtzRXBI?=
 =?utf-8?B?aVZSSmllWGt1RmlVdWFOVGxoN0pYTG9UVjZDVlFzZjQ2eXhXN0x3Ny9rcGRG?=
 =?utf-8?B?RG1hM0pRNENWdVp5WVhBM0VXTTAxUG43SmhLQVNrZHBvRVptdnMyWEh5ZFRt?=
 =?utf-8?B?MWd2dXhxM2tBcXhWV1J0Sk1wdEFRT0lZZlFaLzBNOHg0bitZRlNFK05DUktT?=
 =?utf-8?B?RzNaTW9jU3p6UXdZT3lOTEF6ekg2TjMrcjI2WVVGYm84b3RIMVNudnpZNEJa?=
 =?utf-8?B?azRuMDJzVlQzNXFtZDI4MllVQ0lWQkd3dy95bDBxYlVPRzRFcDhBSEVRR21I?=
 =?utf-8?B?amdhYVFtQnVtZXFCSFBwL0l1UFBqQmpMeUlSYWNOa2VsWkppWlppb2pyeit4?=
 =?utf-8?B?QmdrbXFvNVhDZ3RXSHZ6U3hIV0Y0YTR4S3c5TThCd0JTWWxmcW9ieTJ5ay9H?=
 =?utf-8?B?UFBxclltSG9tc20vTk5MVnJBZ3pCZ3VPYk1IbGNCRE5wYTNUR3VRbndhRU5p?=
 =?utf-8?B?MjhmbVZQeElsaUp1Q0RkYXBDNSs0U3BZVVVWUVNwcDJDcEVqZVdRcmRnVmQ3?=
 =?utf-8?B?Y0NBdjcyUjdWcGFxQUxHSmt6OWNTc0JpbjlSR25BdUtxVHZ3ZURRT3hrYUFn?=
 =?utf-8?B?T3ZMNFlkK21wS2NuR056V3pOcGNOUHgyLytmMjBTODU5UFlJd2pJbmpXc2hE?=
 =?utf-8?B?S2pwcW5sbjZWSjFjRmhleUxqc3VOYU02dVl5eGhnM2pDb2dYZG5oUHBxUGFX?=
 =?utf-8?B?MzBBamIwSU54cVVzY09XRlJSK1U4eWU0T0VrRVNNdzBlZnlGR24vU2crWTI0?=
 =?utf-8?B?ckJmV2I5dHpscEt1SkVacFhxS2lSWE1hWWQxMDkxOWVDUUliSGxKNk04aWlB?=
 =?utf-8?B?WTF2bkF0Y1NaY2kra3JRclFiV3VjZG9PbXNZMnRMZ25kc2dmaG01TE9sTmQ2?=
 =?utf-8?B?L1VUazZmWXVNZkEwaFpPK3pHb1lhZkpCWExmR1Z3ZEZjWEpuczRhM2FTdEN5?=
 =?utf-8?B?UnZtWldJd1c3cEU5Q0JmYk82Z1BINWVtNzNxaTZtRFJIZVlsdGJiT1d2Z2p3?=
 =?utf-8?B?OXFiVURCWCs0UHpXdnZQY2dSdnl1czVPSC9HUDg1SHFFU1RRcnljTWp6bkZx?=
 =?utf-8?B?bFZxcXNNdUFESFlLamQxcW13a1VqREZoZE9SMkMxVnA4TWF4V2lpd2pvdG11?=
 =?utf-8?B?TWpzVnAxNGhockoyMk5KVC9RRE83a1JnMTVCZEJybVRabDhLTE9CZE5pREJ3?=
 =?utf-8?B?TUVrUjc2LzZ6N2hESFpiZHFHYjVaS0xGK2FBU2lqbWdXMmF0Qk9VMVBlVjh0?=
 =?utf-8?B?TE1paGo4aHpGeWVnbGJSdEdRTHErSWxuWDZ6QjBCMzdDS0tJbE44SnNzZ1VM?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B126008D30CA8646BE86FF2A69AB7EA7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b74264-8afd-482a-fae1-08dc6f5f7f54
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 13:05:12.8589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7eMSq6EuxnrfD4UzJlRwJIUBiYQOONO7zoH/0fAeBgodHsbt8RIO1icGZxCRUt1MoE0inRU2W2+vp9zaxT5ePIe7AFou9arsKB9XbcRVJoncG4B35itokNQVtH1C/Qxb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7282

SGkgQW5kcmV3LA0KDQpPbiAyMy8wNC8yNCA0OjUzIGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBNb24sIEFwciAyMiwg
MjAyNCBhdCAxMDowODoyM1BNICswMjAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4+PiBUZXN0aW5n
IERldGFpbHM6DQo+Pj4gLS0tLS0tLS0tLS0tLS0tLQ0KPj4+IFRoZSBkcml2ZXIgcGVyZm9ybWFu
Y2Ugd2FzIHRlc3RlZCB1c2luZyBpcGVyZjMgaW4gdGhlIGJlbG93IHR3byBzZXR1cHMNCj4+PiBz
ZXBhcmF0ZWx5Lg0KPj4+DQo+Pj4gU2V0dXAgMToNCj4+PiAtLS0tLS0tLQ0KPj4+IE5vZGUgMCAt
IFJhc3BiZXJyeSBQaSA0IHdpdGggTEFOODY1MCBNQUMtUEhZDQo+Pj4gTm9kZSAxIC0gUmFzcGJl
cnJ5IFBpIDQgd2l0aCBFVkItTEFOODY3MC1VU0IgVVNCIFN0aWNrDQo+Pj4NCj4+PiBTZXR1cCAy
Og0KPj4+IC0tLS0tLS0tDQo+Pj4gTm9kZSAwIC0gU0FNQTdHNTQtRUsgd2l0aCBMQU44NjUwIE1B
Qy1QSFkNCj4+PiBOb2RlIDEgLSBSYXNwYmVycnkgUGkgNCB3aXRoIEVWQi1MQU44NjcwLVVTQiBV
U0IgU3RpY2sNCj4+DQo+PiBXb3VsZCBpdCBiZSBwb3NzaWJsZSB0byBjaGFpbiB0aGVzZSB0d28g
c2V0dXBzIHRvZ2V0aGVyIGJ5IGFkZGluZyB0d28NCj4+IFVTQiBkb25nbGVzIHRvIG9uZSBvZiB0
aGUgUmkgNHM/IElmIGkgcmVtZW1iZXIgY29ycmVjdGx5LCB0aGVyZSB3ZXJlDQo+PiByZXBvcnRz
IG9mIGlzc3VlcyB3aGVuIHR3byBkZXZpY2VzIHdlcmUgdXNpbmcgdGhlIGZyYW1ld29yayBhdCBv
bmNlLg0KPiANCj4gU29ycnksIHRoYXQgbWFrZXMgbm8gc2Vuc2UuIFlvdXIgVVNCIGRldmljZSBp
cyB1bmxpa2VseSB0byBiZSBkb2luZw0KPiBVU0ItPlNQSS0+TUFDLVBIWS4gRG8geW91IGhhdmUg
dHdvIExBTjg2NTAgTUFDLVBIWSB5b3UgY2FuIGNvbm5lY3QgdG8NCj4gb25lIGhvc3Q/DQpZZXMu
IEkgdHJpZWQgdGhpcyB0ZXN0LiBJdCB3b3JrcyBhcyBleHBlY3RlZC4NCg0KU2V0dXA6DQotLS0t
LS0NCg0KLS0tLS0tLS0tLS0tLS0tLS0tLSAgICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KfCAgICAgUlBJNCAxICAgICAgfCAgICAgIHwgICAgICAgICAgIFJQSTQgMiAgICAgICAgfA0K
fCAtLS0tLS0tLS0tLS0tLS0gfCBOL1cgMXwgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gfA0KfCB8
IDFzdCBMQU44NjUxIHwgfDwtLS0tPnwgfCAxc3QgRVZCLUxBTjg2NzAtVVNCIHwgfA0KfCAtLS0t
LS0tLS0tLS0tLS0gfCAgICAgIHwgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gfA0KfCAgICAgICAg
ICAgICAgICAgfCAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgfA0KfCAtLS0tLS0tLS0t
LS0tLS0gfCBOL1cgMnwgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gfA0KfCB8IDJuZCBMQU44NjUx
IHwgfDwtLS0tPnwgfCAybmQgRVZCLUxBTjg2NzAtVVNCIHwgfA0KfCAtLS0tLS0tLS0tLS0tLS0g
fCAgICAgIHwgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gfA0KLS0tLS0tLS0tLS0tLS0tLS0tLSAg
ICAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQogICAgICAgIHwtLS0+IDFzdCBMQU44
NjUxIC0tLT4gSVA6IDE5Mi4xNjguNS4xMDANClJQSTQgMSB8DQogICAgICAgIHwtLS0+IDJuZCBM
QU44NjUxIC0tLT4gSVA6IDE5Mi4xNjguNS4xMDANCg0KICAgICAgICB8LS0tPiAxc3QgRVZCLUxB
Tjg2NzAtVVNCIC0tLT4gSVA6IDE5Mi4xNjguNS4xMDENClJQSTQgMiB8DQogICAgICAgIHwtLS0+
IDJuZCBFVkItTEFOODY3MC1VU0IgLS0tPiBJUDogMTkyLjE2OC42LjEwMQ0KDQpUZXN0IGNhc2Ug
MToNCi0tLS0tLS0tLS0tLQ0KICBSUEk0IDEgKFNlbmRlcik6DQogIC0tLS0tLS0tLS0tLS0tLS0N
CiAgICQgaXBlcmYzIC1jIDE5Mi4xNjguNS4xMDEgLXUgLWIgNU0gLWkgMSAtdCAwIC1wIDUwMDEN
CiAgICQgaXBlcmYzIC1jIDE5Mi4xNjguNi4xMDEgLXUgLWIgNU0gLWkgMSAtdCAwIC1wIDUwMDIN
CiAgUlBJNCAyIChSZWNlaXZlcik6DQogIC0tLS0tLS0tLS0tLS0tLS0tLQ0KICAgJCBpcGVyZjMg
LXMgLXAgNTAwMQ0KICBSUEk0IDMgKFJlY2VpdmVyKToNCiAgLS0tLS0tLS0tLS0tLS0tLS0tDQog
ICAkIGlwZXJmMyAtcyAtcCA1MDAyDQogIFJlc3VsdCBvbiBSUEk0IHNpZGU6DQogIC0tLS0tLS0t
LS0tLS0tLS0tLS0tDQogICBFYWNoIExBTjg2NTEgdHJhbnNtaXRzIDVNYnBzIHdpdGhvdXQgYW55
IGVycm9yLg0KDQpUZXN0IGNhc2UgMjoNCi0tLS0tLS0tLS0tLQ0KICBSUEk0IDEgKFNlbmRlcik6
DQogIC0tLS0tLS0tLS0tLS0tLS0NCiAgICQgaXBlcmYzIC1jIDE5Mi4xNjguNS4xMDEgLXUgLWIg
MTBNIC1pIDEgLXQgMCAtcCA1MDAxDQogICAkIGlwZXJmMyAtYyAxOTIuMTY4LjYuMTAxIC11IC1i
IDEwTSAtaSAxIC10IDAgLXAgNTAwMg0KICBSUEk0IDIgKFJlY2VpdmVyKToNCiAgLS0tLS0tLS0t
LS0tLS0tLS0tDQogICAkIGlwZXJmMyAtcyAtcCA1MDAxDQogIFJQSTQgMyAoUmVjZWl2ZXIpOg0K
ICAtLS0tLS0tLS0tLS0tLS0tLS0NCiAgICQgaXBlcmYzIC1zIC1wIDUwMDINCiAgUmVzdWx0IG9u
IFJQSTQgc2lkZToNCiAgLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAgIEVhY2ggTEFOODY1MSB0cmFu
c21pdHRpbmcgYXBwcm94aW1hdGVseSA1IG9yIDZNYnBzIHdpdGhvdXQgYW55IGVycm9yLg0KDQpU
ZXN0IGNhc2UgMzoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogIFJQSTQgMSAoUmVjZWl2ZXIp
Og0KICAtLS0tLS0tLS0tLS0tLS0tDQogICAkIGlwZXJmMyAtcyAtcCA1MDAxDQogICAkIGlwZXJm
MyAtcyAtcCA1MDAyDQogIFJQSTQgMiAoU2VuZGVyKToNCiAgLS0tLS0tLS0tLS0tLS0tLQ0KICAg
JCBpcGVyZjMgLWMgMTkyLjE2OC41LjEwMCAtdSAtYiA1TSAtaSAxIC10IDAgLXAgNTAwMQ0KICBS
UEk0IDMgKFNlbmRlcik6DQogIC0tLS0tLS0tLS0tLS0tLS0NCiAgICQgaXBlcmYzIC1jIDE5Mi4x
NjguNi4xMDAgLXUgLWIgNU0gLWkgMSAtdCAwIC1wIDUwMDINCiAgUmVzdWx0IG9uIFJQSTQgc2lk
ZToNCiAgLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAgIEVhY2ggTEFOODY1MSByZWNlaXZlZCA1TWJw
cyB3aXRob3V0IGFueSBlcnJvci4NCg0KVGVzdCBjYXNlIDQ6DQotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KICBSUEk0IDEgKFJlY2VpdmVyKToNCiAgLS0tLS0tLS0tLS0tLS0tLS0tDQogICAkIGlw
ZXJmMyAtcyAtcCA1MDAxDQogICAkIGlwZXJmMyAtcyAtcCA1MDAyDQogIFJQSTQgMiAoU2VuZGVy
KToNCiAgLS0tLS0tLS0tLS0tLS0tLQ0KICAgJCBpcGVyZjMgLWMgMTkyLjE2OC41LjEwMCAtdSAt
YiAxME0gLWkgMSAtdCAwIC1wIDUwMDENCiAgUlBJNCAzIChTZW5kZXIpOg0KICAtLS0tLS0tLS0t
LS0tLS0tDQogICAkIGlwZXJmMyAtYyAxOTIuMTY4LjYuMTAwIC11IC1iIDEwTSAtaSAxIC10IDAg
LXAgNTAwMg0KICBSZXN1bHQgb24gUlBJNCBzaWRlOg0KICAtLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
ICAgRWFjaCBMQU44NjUxIHJlY2VpdmVkIGFwcHJveGltYXRlbHkgM01icHMgd2l0aCBsb3Qgb2Yg
IlJlY2VpdmUgYnVmZmVyIA0Kb3ZlcmZsb3cgZXJyb3IiLiBJIHRoaW5rIGl0IGlzIGV4cGVjdGVk
IGFzIHRoZSBzaW5nbGUgU1BJIG1hc3RlciBoYXMgdG8gDQpzZXJ2ZSBib3RoIExBTjg2NTEgYXQg
dGhlIHNhbWUgdGltZSBhbmQgYm90aCBMQU44NjUxIHdpbGwgYmUgcmVjZWl2aW5nIA0KMTBNYnBz
IG9uIGVhY2guDQoNClBsZWFzZSBsZXQgbWUga25vdyBpZiBJIGhhdmUgYW55IG1pc3VuZGVyc3Rh
bmRpbmcgaGVyZSBvciB5b3UgbmVlZCBtb3JlIA0KZGV0YWlscyBvbiB0aGUgdGVzdCBjYXNlcy4N
Cg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+ICAgICAgQW5kcmV3DQo+IA0KDQo=

