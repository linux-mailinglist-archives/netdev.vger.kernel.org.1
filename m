Return-Path: <netdev+bounces-115037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D53F9944EED
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 17:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32073B21B8A
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360A01369AE;
	Thu,  1 Aug 2024 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hzVSIt+O";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="C5ncQCZu"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32301E868;
	Thu,  1 Aug 2024 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525447; cv=fail; b=r5ZtUp2vReaNUYEOJ27v5qC/vztnwZnTAvDKxMKovm2pSbMhARwQuNud7bvc03RGg2FmuIstLcebvS8dYt34BzrYND/JMXpQRxR6Np6uxzZP1TvSVAl9cLOjhP1a597Fw2X6KoNS0GTOHXieFP6VIWZWF4zTljps59jPIDOnoso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525447; c=relaxed/simple;
	bh=s//kEDgiC06UpnHzF9afaGBxl+01KGRQSmo8ud8mKvE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jx9RnlUwqj8jGk/RplZCVuhOV6DjxbcTbi5aQZKpaSDc7sDcNneAwGgs2JhbJc8Xf4Kn1DHSlTd8l2gvCTOvSl4GzrJQhOxAdn8/WF3cLxKSEk4UGF/vOJISXzuF/Ed+MhNu4jrEMN7IMxKoba4zUGrpLzFJayGk0NMno/MymTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hzVSIt+O; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=C5ncQCZu; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722525444; x=1754061444;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s//kEDgiC06UpnHzF9afaGBxl+01KGRQSmo8ud8mKvE=;
  b=hzVSIt+Oj4uIBide47VFUJOf4/pBDDrPSYBOHnFlA+fyu4VzfO4oAXzN
   YH69O1mUq9OJLtoXr2QgiHjiWRky5AGkWfrAgCQnf6G4IlXOS1TZMbMz5
   baJq7+agNFNxN+CUSuG2GlFv5Caaj3sT6UI7rpYUeEGj1CN7QudcHunNk
   W1+6FjmZiiHnjiRf2ujrdDgOez+mJcaSDHnDS63JYpHlbenpD4V/TGvrw
   bUypOCMf16HeI0l4JwV3Rr4LRg4v49eoG+Juk2lD656pfEQb0mfc/qO8V
   lOmCkSENtKMewUteJ5MeRdIJXAGzGbcazm75eJ+GrD6+0vOZyWOEgzl4d
   A==;
X-CSE-ConnectionGUID: AF6GxuWhR6myq1XhkFyKew==
X-CSE-MsgGUID: KXevuanVQ4KHOxKTaKk8aQ==
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="32818574"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Aug 2024 08:17:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Aug 2024 08:16:48 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Aug 2024 08:16:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bu2QJVqRAGM+jJEOc1FTtNdBx3xqU38Bq1RqEwF9lWlIbdEdR/H3PMGJ1gDyR7rcYvU6WTX9rYkOIvc+IhzW/p0AVut6R2epPsSIJx9DmUQKBvQtM41rUKwv772X96c6xLlTRA98cVRSVuBgAnmBLXWTnFc5fSWSDYWS7FDX7z4+PHYKtoMeT116bRK8wGo1VdHBpYkOTi/JWiWoa0mdIRZ0gol9HgcjufCO5nPB6QnBIW2Og2s9xQ1pHXyaWvBlUdZMySFy+JKQFBCTQEaFgWQr3aqGXrKyx4PChJ9Jl34AIc2DEED3lrn0IGV+++xd1yJnWdjMerRKtMSek3qgZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s//kEDgiC06UpnHzF9afaGBxl+01KGRQSmo8ud8mKvE=;
 b=Rb3YegLOxLaBnHHGiinNP8QUtPVpO9Jv6IrMGfnxjyy69UigGhHWNjCixO+CppU8ehU3hE8OzPnjwga6wsCN8jTpvT+nhm+pgyQvqKQmzJ9xq4bPXd2AQsz7ZWc4du80Q3knhS+Y8N7O3qphuY0BC4Vlq/oz+Ieldocg0S0ezcE75vEcYQ8hn1DAszsuKgP5f7gJzx9QwUT6lyo8SOrtohiXEEesgOIRCX9udIV1bhUPa5PUV7VTwjX/bTde5xnn0eTq6L7Oz6+l4DM3zOI3X+1qbefPJ5KmOj1rFFaXxb1pW85Oyl93GFBrSzJo3mXbmWLQIgLSUNaGhqISiFKqlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s//kEDgiC06UpnHzF9afaGBxl+01KGRQSmo8ud8mKvE=;
 b=C5ncQCZumCJclwPb7nq5jDJzbg18U5N444sV4H4YxywwIf/Tvjjv5grhIu+ZX0lILta9S32oV8rDO3yuZedlSqXyvrpY9Ed6xpdMROpdDhnpKH9Roox1Q4KzF5IToxRlR91lCz1QCxsYPrbY5KjcW73YX7KjV428hQGsesuCjtWQ9dn4G8Zuj/7n3BdoMAIb+ZYyZr23kBt3lANDT2ArmZLsOqW44bwGYRTrhThZcwGBT8ghKyRut9bFr1HvlOtytY1C3LPQx52ylky5OfulsXPq+iyQaI9UeA2LzJIh35bQ5Nf+BTFEHVzHzJ1S6gVEVh1A7lkebQGTfgEVMujyug==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by SA1PR11MB6895.namprd11.prod.outlook.com (2603:10b6:806:2b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Thu, 1 Aug
 2024 15:16:44 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%6]) with mapi id 15.20.7828.023; Thu, 1 Aug 2024
 15:16:44 +0000
From: <Arun.Ramadoss@microchip.com>
To: <vtpieter@gmail.com>, <devicetree@vger.kernel.org>,
	<Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>
CC: <o.rempel@pengutronix.de>, <pieter.van.trappen@cern.ch>
Subject: Re: [PATCH net-next v2 4/5] net: dsa: microchip: add WoL support for
 KSZ87xx family
Thread-Topic: [PATCH net-next v2 4/5] net: dsa: microchip: add WoL support for
 KSZ87xx family
Thread-Index: AQHa4zU9Cny06wc7m0u1laYnqmFVXbISheeA
Date: Thu, 1 Aug 2024 15:16:44 +0000
Message-ID: <bb881ded575d6a438d81944e6152763a321fcb22.camel@microchip.com>
References: <20240731103403.407818-1-vtpieter@gmail.com>
	 <20240731103403.407818-5-vtpieter@gmail.com>
In-Reply-To: <20240731103403.407818-5-vtpieter@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|SA1PR11MB6895:EE_
x-ms-office365-filtering-correlation-id: 8c99095c-8a79-440b-718d-08dcb23cf43e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VFl4SkhwU0ZjejdDdWhnWkp3WDZ4VG0xcTZDcHZySjZjcmM0UG9HODdGMkVG?=
 =?utf-8?B?NjhCRmJPRGVNZXFWTUlYOEgzWmlSQnoxVGthV1YvNHEwRHM1T1VGYlgwZjlU?=
 =?utf-8?B?LzVLTW1Ec3AwYVEybDc1UXd3aVZzYU85M2hta3lQODJEKzZ0RXE1OWkrSnpl?=
 =?utf-8?B?QTNVQ2sxRkRvVzJ4UzY4Z2VCR2dXQ3M4K1JWdXMwN0Y3NXFWZFVmQk1LdUVm?=
 =?utf-8?B?UXFrbXhwVG9JMEZQMnpjQjZNM3MrUHFob0dOZWVqQUhyV0dGanR0ZTN5TmpG?=
 =?utf-8?B?WFhSOTZjU2t1U0V3SHUrTUtoOU1BNk5kK0Rxa3VoYlVjbkdyOHZYOWJSZ3Ex?=
 =?utf-8?B?ZEhOVWcwYm9TaEdaeEN6ZlU2Z2NRdCtDdVRDaEVKOEFoSitxUUhrODZTNGNh?=
 =?utf-8?B?WHBQQVpHQWllaERJTUc4YTRyTjRSWTNqWGlzUjAwUXZObVhkVEN5UXE4U1gv?=
 =?utf-8?B?RmlvTE1NYmg4ZzJyWlNTQzhWYUJLZ0ZZRm9iYkdCdHFnQ25tYk5VYWJQeW9E?=
 =?utf-8?B?MVlWYWpFOFNUSGtnOGlCbEptb1ZteEdBbkZndWt5Zk1zZHo5V1BNeUJ2VVdj?=
 =?utf-8?B?cnczelNjSkxXcjRHVldRVHlmUFBHWkNUd0xrTnpSUjNkMWJIbmxnN1ozVFNy?=
 =?utf-8?B?Y3hEQmZGemljeWJOWWt0a0RMeHVTM01mME14ZW1WYWpCRGF1bC84akNoQVAw?=
 =?utf-8?B?UE9DOFpuOVNrMkRKakJod01KNlBCdmlNWjQ5VHRubkpkT1gzQzRGK1RvczY0?=
 =?utf-8?B?R3oxSXdKcXpOcVFJTGg5OW1KYmNLeGNWWHlEUytmek00NEZzcHkyYk5PWE92?=
 =?utf-8?B?ZEJsazBmS09nSDV5OWgvWUU2VG05ZE1PZnBZRk5Td0RKUzJGNzdTM0wxU2FG?=
 =?utf-8?B?bzdaUFREdXUraitsNUQ5UithSVVFa2RDQ0ZUaDhBVjN1NEZ3d3c4VTMyU1lC?=
 =?utf-8?B?d2Q1aisxbFlFNENKS2I5bVJmVXZFcVhjR3VwelU5WmNlZVU4bVV2UWs2WFRh?=
 =?utf-8?B?R3lvUlNSSXRPMlF4UlZuVVJ6WEZVc1dwakJpZGFwb0JvV05CSDlkajNhVG5x?=
 =?utf-8?B?UEJlOHJUQ2VHN2MyK0ZPdVdVTDkrQS83UDE4MXNhNzhNTUVBN1ZURkRlMVFZ?=
 =?utf-8?B?NnY2L0czbTRvbEdnRjJWUDNnT0MrYUtSb29kcGJDREcvdkVjeUppaGo0ZXZQ?=
 =?utf-8?B?VnBpb2FwVVE5UlRWMm1YM3lRblMxLzRwK1ZWTTlra20xbGlocHU2NUV3REhN?=
 =?utf-8?B?Zm1jM1BGVmtIM1NlUXA2SVI5WTVPN09jekI5TGFTc2U0ZGhGck51d1JzaHNa?=
 =?utf-8?B?Z1Fsbml6Tmt4QmlWZ0JxbG52SXJycE5KYjI4TmJCYXhxQ0VzYUw0dHJScTF5?=
 =?utf-8?B?bUx5SC8yTStHMHNyR3dxTkpMMitPRllxMENoNkZJNFdzb2VhSXNuWCtHNTBK?=
 =?utf-8?B?QXAwTkhtdXJhYWR5bUJHdVVmWEtjQUR4VmFpQUovV0hsUDdyeStJZVp1UUV2?=
 =?utf-8?B?Znp2SkFGUnZGQXo5Mk9OQUxtb3liRXcxcVRYVUQvWUVpdUxiUHRJeFNXT1N6?=
 =?utf-8?B?OEVhZnZRcHNQd24ydXo5Y3pmRkZxcndkS1NJMVRSSEF1cTdON0VGMkxtek9K?=
 =?utf-8?B?RDExSHl0elNjTG45ZjF5Zm5MamMyc0lLVEJvRzVPNkFjWlRqT2NHNm01d2Vo?=
 =?utf-8?B?ekFvbnlzVG51UGcxNUhBNDdwY1ZwR0k5b2NhTEpRSk8yWldIcDBsbmlTQWg0?=
 =?utf-8?B?bGdLOStWbk41N0NpMHdQWGtGMDhpeHFLUjJjWVZjazdVY2tVZjFYam9oVmpQ?=
 =?utf-8?B?ZFE5YXdVT2VvdjVwUkxSY3JNdERrZHE1aWEzTVdLYy82cG9XbU9PUWRVT0Vl?=
 =?utf-8?B?TFVTYkZRQ3BXMGlkajN2Qmp5K2t0akhOOHVJT2hyRWI5TEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3pMTTYrbkVoNjNnZU1aWHZyWWtZOTVKZE80N3V6UFNySjJycFlHVldvYjRX?=
 =?utf-8?B?bEJBcmZVZFcyMUw0N3NhSENRdFlpZlE4cm0rUGY0aEdQYmMzdTNET2psVUZP?=
 =?utf-8?B?aFZEanB4WGJSRGZyS2JFdStGOXAyL3U5bW8yS1grczJYRTREaHZNZzBZWDds?=
 =?utf-8?B?MmVDR0tibDA4b2NVZGx1Tm9xSjJYZ043VFlEZDFuS0hRNTcrWGhZZ2ZkaGw1?=
 =?utf-8?B?eTR2UkhuTUdORDc1RFRlTzd5U0QxcWkzTzAweldNYmpXZnVoaU1nSjR5ZDFx?=
 =?utf-8?B?eHhmMURPdXRvZGNXT0xPYWJ5cEdjSmZmTDZFUkdWSGNpczZQc2pwVEVIWW9M?=
 =?utf-8?B?RUIrNVB1d2xqTkY0blptRDJJMU9EaXo5VHN3NGNyaTVRU2svd2JMaFplRnhC?=
 =?utf-8?B?Z1V1eWUwNk00MXRMUG4xL1dibXdoUlk4TzlmT1JoWWVrZVQwK09WbGNzeFVx?=
 =?utf-8?B?eWFKTEg0T1FJbDMrc2NSY3pYSDFIUEZVenZvb2dxckhvUGJqRzdERlh5c2tH?=
 =?utf-8?B?THBjdWNLNGZGRGMvblQzZXZJOWloRjNzODZjMnM2SjN3SkI0cU9mOXVSL1lK?=
 =?utf-8?B?SXU2dGJBZm5MTmIvOFc4byt3RFBxREJDN2I5VzR4K3kzWndKS1NVSWlXVlBD?=
 =?utf-8?B?UU5vWENnVHJGV3o3Wm5DQ21DUTB4WFNIZy9raTB5QjZLMWgxWkpIZXJJb05l?=
 =?utf-8?B?YTAwNlZQYXNjRi9mUmV1SCtvZXBRdldaUjNBQUtGL29CbFMzUWRuU00yMW1m?=
 =?utf-8?B?TUdpcTFvQ2k4Qlo3M0NxMDF2V2Y1WmZsZmNFSGJQZXRXN01KQkVtLzBuRzRL?=
 =?utf-8?B?MDQ2S2tpVWJVaHcrUHpYUDFLUTc1ekpJb0sxV1F4S0lQcTN0T21CeGtzL0Ez?=
 =?utf-8?B?dkkzQlp3bHRLbmlESXpZZ1p0dGxqTy9zcTZNVXp3czlTQVBlL1daSmdITE5v?=
 =?utf-8?B?M3VlU2VWT0N5ZHJFS1RYdEZ6NHJtdDJLQmhna3pUVVIxZ3J6cmN3Uk1ud0g3?=
 =?utf-8?B?aHRBMmtKaUhRS3NITHlDTnZHNVMvZUdtUWtYeHFydmU3TFFVbmhtc3Z5Mld6?=
 =?utf-8?B?elNoeEt2YjRPNnRqbTdaSXRyK0kvU21HbUFPR0d6US9HTW1NSzFiMzdkakJS?=
 =?utf-8?B?N29SaVlHSmNheUkwVXErcnhwOHdPd0RCUkE3UGhMemcxNUlHMXFxcnZFbkpT?=
 =?utf-8?B?YWdySnZjeVJvTUdTdFI0bDNKVml6RXRMMTVxNWpBYjNMeVlOdzYvRGhMOGxM?=
 =?utf-8?B?TXVyNHhXcUlVNlAxVDg1QkxBMGdja3IvSjVYVGRiNXAxVkcwS2hHTGVMYjcz?=
 =?utf-8?B?WFJKRnZkNnF0aDY2ZVhZWlRzOHUxYzRvdjBidFpzMGFZTnVlQVBzWmIweTdT?=
 =?utf-8?B?SmF6eEo3ZWtiek9oYlorTlEyckVya3AyU2NlMHZ5b1pyL29VUjdjNUNlVmh6?=
 =?utf-8?B?NWduQlk1K2sxYS9mTks5eVYyaEsyUFBRZGlrcCtncXBlNElZZzJxeWlJM1Rt?=
 =?utf-8?B?QVBVZnd0a1NEVHhBVkdGYzg5ajgzSkVOSFA2bHl4cDJ4REZYcmdSVStWaDEv?=
 =?utf-8?B?YXlmanVxNFBKOWJmelE5aTJHR1BMdFZCU0JidkZlbEpvcWFIbVhUSkZnNkd4?=
 =?utf-8?B?bmpjQTl4Y2h0Ukw4ekphYWwwNXlVMmJVUkZxOXArU0UxY0QrK1NvNnBUY2cx?=
 =?utf-8?B?Z1ptREVxY0V3QnovaFZSeWhyZ3hBZlFSV1gzd1lIRzdtRFd5MVZTanppL0wz?=
 =?utf-8?B?L1NkMUJJRHJ5dTdpSDZYVHhCRFFaLytuRFBZSHRnNGZXcmRQQVZUNkZ1NjJL?=
 =?utf-8?B?MmxIc3VMaUlWRmg5RDZaSGN4TU1sNXVvdjZqamNyKzd3eWx3Y29JWmVMVm1q?=
 =?utf-8?B?cCthZFBJMU8wUlgzYmdVSHRSRXNTcTl6ZlM5RU1tRUhGWTZCY3ZuOFVUbnBH?=
 =?utf-8?B?YzVNZ3NsbHdia2J0WlVVdUF2ckE0T29QdWp4Rk13VTJtRWFjYzgvQnY3UGVV?=
 =?utf-8?B?dHJyRzE0TTJZMG05KzFQQlh6RVBYM29TSVU3U2M3a0JpZ082NkU3c2dqb054?=
 =?utf-8?B?UndUYUNYa0kvQmEvcUlDVEFyZ05zSEdwTUNQWVZKamlUeElod2NvM0c5blgy?=
 =?utf-8?B?NWJCZ1ZhVWNZVmlmMVZYNW1meVpHUDhjSS9FSUZQaGhFOTVMZm4xNlZrcjhX?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <698AA07AA78E1F449601C5F791CDFCCD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c99095c-8a79-440b-718d-08dcb23cf43e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 15:16:44.4741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hmSg8q3JfAuCSFRtG//n/oL1LzokhL8RngPMdRMTiabVU/3iaU2AAhNGik3EHIk2bE/+B2jCp16qM5C7K/4ufqVJn6xtcSO2DKCsM8aMEkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6895

SGkgUGlldGVyLCANCg0KDQo+IA0KPiArLyoqDQo+ICsgKiBrc3o4X2luZF93cml0ZTggLSBFRUUv
QUNML1BNRSBpbmRpcmVjdCByZWdpc3RlciB3cml0ZQ0KPiArICogQGRldjogVGhlIGRldmljZSBz
dHJ1Y3R1cmUuDQo+ICsgKiBAdGFibGU6IEZ1bmN0aW9uICYgdGFibGUgc2VsZWN0LCByZWdpc3Rl
ciAxMTAuDQo+ICsgKiBAYWRkcjogSW5kaXJlY3QgYWNjZXNzIGNvbnRyb2wsIHJlZ2lzdGVyIDEx
MS4NCj4gKyAqIEBkYXRhOiBUaGUgZGF0YSB0byBiZSB3cml0dGVuLg0KPiArICoNCj4gKyAqIFRo
aXMgZnVuY3Rpb24gcGVyZm9ybXMgYW4gaW5kaXJlY3QgcmVnaXN0ZXIgd3JpdGUgZm9yIEVFRSwg
QUNMIG9yDQo+ICsgKiBQTUUgc3dpdGNoIGZ1bmN0aW9uYWxpdGllcy4gQm90aCA4LWJpdCByZWdp
c3RlcnMgMTEwIGFuZCAxMTEgYXJlDQo+ICsgKiB3cml0dGVuIGF0IG9uY2Ugd2l0aCBrc3pfd3Jp
dGUxNiwgdXNpbmcgdGhlIHNlcmlhbCBtdWx0aXBsZSB3cml0ZQ0KPiArICogZnVuY3Rpb25hbGl0
eS4NCj4gKyAqDQo+ICsgKiBSZXR1cm46IDAgb24gc3VjY2Vzcywgb3IgYW4gZXJyb3IgY29kZSBv
biBmYWlsdXJlLg0KPiArICovDQo+ICBzdGF0aWMgaW50IGtzejhfaW5kX3dyaXRlOChzdHJ1Y3Qg
a3N6X2RldmljZSAqZGV2LCB1OCB0YWJsZSwgdTE2DQo+IGFkZHIsIHU4IGRhdGEpDQo+ICB7DQo+
ICAgICAgICAgY29uc3QgdTE2ICpyZWdzOw0KPiBAQCAtNTgsNiArNzIsNTkgQEAgc3RhdGljIGlu
dCBrc3o4X2luZF93cml0ZTgoc3RydWN0IGtzel9kZXZpY2UgKmRldiwNCj4gdTggdGFibGUsIHUx
NiBhZGRyLCB1OCBkYXRhKQ0KPiAgICAgICAgIHJldHVybiByZXQ7DQo+ICB9DQo+IA0KPiANCj4g
IGludCBrc3o4X3Jlc2V0X3N3aXRjaChzdHJ1Y3Qga3N6X2RldmljZSAqZGV2KQ0KPiAgew0KPiAg
ICAgICAgIGlmIChrc3pfaXNfa3N6ODh4MyhkZXYpKSB7DQo+IEBAIC0xNTQ1LDYgKzE2MTIsNyBA
QCBzdGF0aWMgdm9pZCBrc3o4Nzk1X2NwdV9pbnRlcmZhY2Vfc2VsZWN0KHN0cnVjdA0KPiBrc3pf
ZGV2aWNlICpkZXYsIGludCBwb3J0KQ0KPiANCj4gIHZvaWQga3N6OF9wb3J0X3NldHVwKHN0cnVj
dCBrc3pfZGV2aWNlICpkZXYsIGludCBwb3J0LCBib29sDQo+IGNwdV9wb3J0KQ0KPiAgew0KPiAr
ICAgICAgIGNvbnN0IHUxNiAqcmVncyA9IGRldi0+aW5mby0+cmVnczsNCj4gICAgICAgICBzdHJ1
Y3QgZHNhX3N3aXRjaCAqZHMgPSBkZXYtPmRzOw0KPiAgICAgICAgIGNvbnN0IHUzMiAqbWFza3M7
DQo+ICAgICAgICAgaW50IHF1ZXVlczsNCj4gQEAgLTE1NzUsNiArMTY0MywxMyBAQCB2b2lkIGtz
ejhfcG9ydF9zZXR1cChzdHJ1Y3Qga3N6X2RldmljZSAqZGV2LA0KPiBpbnQgcG9ydCwgYm9vbCBj
cHVfcG9ydCkNCj4gICAgICAgICAgICAgICAgIG1lbWJlciA9IEJJVChkc2FfdXBzdHJlYW1fcG9y
dChkcywgcG9ydCkpOw0KPiANCj4gICAgICAgICBrc3o4X2NmZ19wb3J0X21lbWJlcihkZXYsIHBv
cnQsIG1lbWJlcik7DQo+ICsNCj4gKyAgICAgICAvKiBEaXNhYmxlIGFsbCBXb0wgb3B0aW9ucyBi
eSBkZWZhdWx0LiBPdGhlcndpc2UNCj4gKyAgICAgICAgKiBrc3pfc3dpdGNoX21hY2FkZHJfZ2V0
L3B1dCBsb2dpYyB3aWxsIG5vdCB3b3JrIHByb3Blcmx5Lg0KPiArICAgICAgICAqIENQVSBwb3J0
IDQgaGFzIG5vIFdvTCBmdW5jdGlvbmFsaXR5Lg0KPiArICAgICAgICAqLw0KPiArICAgICAgIGlm
IChrc3pfaXNfa3N6ODd4eChkZXYpICYmICFjcHVfcG9ydCkNCj4gKyAgICAgICAgICAgICAgIGtz
ejhfcG1lX3B3cml0ZTgoZGV2LCBwb3J0LCByZWdzW1JFR19QT1JUX1BNRV9DVFJMXSwgDQoNCmNo
ZWNrIHRoZSByZXR1cm4gdmFsdWUgb2YgcmVnaXN0ZXIgd3JpdGUuDQoNCj4gMCk7DQo+ICB9DQo+
IA0KPiAgc3RhdGljIHZvaWQga3N6ODh4M19jb25maWdfcm1paV9jbGsoc3RydWN0IGtzel9kZXZp
Y2UgKmRldikNCj4gQEAgLTE3OTAsNiArMTg2NSw3IEBAIGludCBrc3o4X2VuYWJsZV9zdHBfYWRk
cihzdHJ1Y3Qga3N6X2RldmljZQ0KPiAqZGV2KQ0KPiAgaW50IGtzejhfc2V0dXAoc3RydWN0IGRz
YV9zd2l0Y2ggKmRzKQ0KPiAgew0KPiAgICAgICAgIHN0cnVjdCBrc3pfZGV2aWNlICpkZXYgPSBk
cy0+cHJpdjsNCj4gKyAgICAgICBjb25zdCB1MTYgKnJlZ3MgPSBkZXYtPmluZm8tPnJlZ3M7DQo+
ICAgICAgICAgaW50IGk7DQo+IA0KPiAgICAgICAgIGRzLT5tdHVfZW5mb3JjZW1lbnRfaW5ncmVz
cyA9IHRydWU7DQo+IEBAIC0xODI5LDYgKzE5MDUsMTYgQEAgaW50IGtzejhfc2V0dXAoc3RydWN0
IGRzYV9zd2l0Y2ggKmRzKQ0KPiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCAoZGV2LT5pbmZvLT5u
dW1fdmxhbnMgLyA0KTsgaSsrKQ0KPiAgICAgICAgICAgICAgICAga3N6OF9yX3ZsYW5fZW50cmll
cyhkZXYsIGkpOw0KPiANCj4gKyAgICAgICAvKiBNYWtlIHN1cmUgUE1FIChXb0wpIGlzIG5vdCBl
bmFibGVkLiBJZiByZXF1ZXN0ZWQsIGl0IHdpbGwNCj4gKyAgICAgICAgKiBiZSBlbmFibGVkIGJ5
IGtzel93b2xfcHJlX3NodXRkb3duKCkuIE90aGVyd2lzZSwgc29tZQ0KPiBQTUlDcw0KPiArICAg
ICAgICAqIGRvIG5vdCBsaWtlIFBNRSBldmVudHMgY2hhbmdlcyBiZWZvcmUgc2h1dGRvd24uIFBN
RSBvbmx5DQo+ICsgICAgICAgICogYXZhaWxhYmxlIG9uIEtTWjg3eHggZmFtaWx5Lg0KPiArICAg
ICAgICAqLw0KPiArICAgICAgIGlmIChrc3pfaXNfa3N6ODd4eChkZXYpKSB7DQo+ICsgICAgICAg
ICAgICAgICBrc3o4X3BtZV93cml0ZTgoZGV2LCByZWdzW1JFR19TV19QTUVfQ1RSTF0sIDApOw0K
PiArICAgICAgICAgICAgICAga3N6X3JtdzgoZGV2LCBSRUdfSU5UX0VOQUJMRSwgSU5UX1BNRSwg
MCk7DQoNCkhlcmUgYWxzby4NCj4gKyAgICAgICB9DQo+ICsNCj4gICAgICAgICByZXR1cm4ga3N6
OF9oYW5kbGVfZ2xvYmFsX2VycmF0YShkcyk7DQo+ICB9DQo+IA0KPiANCj4gDQo+ICBzdGF0aWMg
Y29uc3QgdTMyIGtzejg3OTVfbWFza3NbXSA9IHsNCj4gQEAgLTM3NTIsNyArMzc1OCw3IEBAIHN0
YXRpYyB2b2lkIGtzel9nZXRfd29sKHN0cnVjdCBkc2Ffc3dpdGNoICpkcywNCj4gaW50IHBvcnQs
DQo+ICAgICAgICAgdTggcG1lX2N0cmw7DQo+ICAgICAgICAgaW50IHJldDsNCj4gDQo+IC0gICAg
ICAgaWYgKCFpc19rc3o5NDc3KGRldikpDQo+ICsgICAgICAgaWYgKCFpc19rc3o5NDc3KGRldikg
JiYgIWtzel9pc19rc3o4N3h4KGRldikpDQo+ICAgICAgICAgICAgICAgICByZXR1cm47DQo+IA0K
PiAgICAgICAgIGlmICghZGV2LT53YWtldXBfc291cmNlKQ0KPiBAQCAtMzgwNSw3ICszODExLDcg
QEAgc3RhdGljIGludCBrc3pfc2V0X3dvbChzdHJ1Y3QgZHNhX3N3aXRjaCAqZHMsDQo+IGludCBw
b3J0LA0KPiAgICAgICAgIGlmICh3b2wtPndvbG9wdHMgJiB+KFdBS0VfUEhZIHwgV0FLRV9NQUdJ
QykpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gDQo+IC0gICAgICAgaWYg
KCFpc19rc3o5NDc3KGRldikpDQo+ICsgICAgICAgaWYgKCFpc19rc3o5NDc3KGRldikgJiYgIWtz
el9pc19rc3o4N3h4KGRldikpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNVUFA7
DQo+IA0KPiAgICAgICAgIGlmICghZGV2LT53YWtldXBfc291cmNlKQ0KPiBAQCAtMzkwNSwxMyAr
MzkxMSwxNSBAQCBpbnQga3N6X2hhbmRsZV93YWtlX3JlYXNvbihzdHJ1Y3Qga3N6X2RldmljZQ0K
PiAqZGV2LCBpbnQgcG9ydCkNCj4gICAqLw0KPiAgc3RhdGljIHZvaWQga3N6X3dvbF9wcmVfc2h1
dGRvd24oc3RydWN0IGtzel9kZXZpY2UgKmRldiwgYm9vbA0KPiAqd29sX2VuYWJsZWQpDQo+ICB7
DQo+ICsgICAgICAgY29uc3Qgc3RydWN0IGtzel9kZXZfb3BzICpvcHMgPSBkZXYtPmRldl9vcHM7
DQoNClRoaXMgY2hhbmdlIGNvdWxkIGJlIGludHJvZHVjZWQgaW4gcHJldmlvdXMgcGF0Y2ggaXRz
ZWxmLiANCg0KPiAgICAgICAgIGNvbnN0IHUxNiAqcmVncyA9IGRldi0+aW5mby0+cmVnczsNCj4g
KyAgICAgICB1OCBwbWVfcGluX2VuID0gUE1FX0VOQUJMRTsNCj4gICAgICAgICBzdHJ1Y3QgZHNh
X3BvcnQgKmRwOw0KPiAgICAgICAgIGludCByZXQ7DQo+IA0KPiAgICAgICAgICp3b2xfZW5hYmxl
ZCA9IGZhbHNlOw0KPiANCj4gLSAgICAgICBpZiAoIWlzX2tzejk0NzcoZGV2KSkNCj4gKyAgICAg
ICBpZiAoIWlzX2tzejk0NzcoZGV2KSAmJiAha3N6X2lzX2tzejg3eHgoZGV2KSkNCj4gICAgICAg
ICAgICAgICAgIHJldHVybjsNCj4gDQo+ICAgICAgICAgaWYgKCFkZXYtPndha2V1cF9zb3VyY2Up
DQo+IEBAIC0zOTIwLDggKzM5MjgsOCBAQCBzdGF0aWMgdm9pZCBrc3pfd29sX3ByZV9zaHV0ZG93
bihzdHJ1Y3QNCj4ga3N6X2RldmljZSAqZGV2LCBib29sICp3b2xfZW5hYmxlZCkNCj4gICAgICAg
ICBkc2Ffc3dpdGNoX2Zvcl9lYWNoX3VzZXJfcG9ydChkcCwgZGV2LT5kcykgew0KPiAgICAgICAg
ICAgICAgICAgdTggcG1lX2N0cmwgPSAwOw0KPiANCj4gLSAgICAgICAgICAgICAgIHJldCA9IGRl
di0+ZGV2X29wcy0+cG1lX3ByZWFkOChkZXYsIGRwLT5pbmRleCwNCj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWdzW1JFR19QT1JUX1BNRV9DVFJMDQo+
IF0sICZwbWVfY3RybCk7DQo+ICsgICAgICAgICAgICAgICByZXQgPSBvcHMtPnBtZV9wcmVhZDgo
ZGV2LCBkcC0+aW5kZXgsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
cmVnc1tSRUdfUE9SVF9QTUVfQ1RSTF0sDQo+ICZwbWVfY3RybCk7DQo+ICAgICAgICAgICAgICAg
ICBpZiAoIXJldCAmJiBwbWVfY3RybCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgKndvbF9l
bmFibGVkID0gdHJ1ZTsNCj4gDQo+IEBAIC0zOTMyLDggKzM5NDAsMTMgQEAgc3RhdGljIHZvaWQg
a3N6X3dvbF9wcmVfc2h1dGRvd24oc3RydWN0DQo+IGtzel9kZXZpY2UgKmRldiwgYm9vbCAqd29s
X2VuYWJsZWQpDQo+ICAgICAgICAgfQ0KPiANCj4gICAgICAgICAvKiBOb3cgd2UgYXJlIHNhdmUg
dG8gZW5hYmxlIFBNRSBwaW4uICovDQo+IC0gICAgICAgaWYgKCp3b2xfZW5hYmxlZCkNCj4gLSAg
ICAgICAgICAgICAgIGRldi0+ZGV2X29wcy0+cG1lX3dyaXRlOChkZXYsIHJlZ3NbUkVHX1NXX1BN
RV9DVFJMXSwNCj4gUE1FX0VOQUJMRSk7DQo+ICsgICAgICAgaWYgKCp3b2xfZW5hYmxlZCkgew0K
PiArICAgICAgICAgICAgICAgaWYgKGRldi0+cG1lX2FjdGl2ZV9oaWdoKQ0KPiArICAgICAgICAg
ICAgICAgICAgICAgICBwbWVfcGluX2VuIHw9IFBNRV9QT0xBUklUWTsNCj4gKyAgICAgICAgICAg
ICAgIG9wcy0+cG1lX3dyaXRlOChkZXYsIHJlZ3NbUkVHX1NXX1BNRV9DVFJMXSwNCj4gcG1lX3Bp
bl9lbik7DQo+ICsgICAgICAgICAgICAgICBpZiAoa3N6X2lzX2tzejg3eHgoZGV2KSkNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAga3N6X3dyaXRlOChkZXYsIEtTWjg3OTVfUkVHX0lOVF9FTiwN
Cj4gS1NaODc5NV9JTlRfUE1FX01BU0spOw0KDQpjaGVjayB0aGUgcmV0dXJuIHZhbHVlcy4gDQo+
ICsgICAgICAgfQ0KPiAgfQ0KPiANCj4gDQo+ICAgICAgICAgcmV0ID0gZHNhX3JlZ2lzdGVyX3N3
aXRjaChkZXYtPmRzKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAv
a3N6X2NvbW1vbi5oDQo+IGIvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3pfY29tbW9uLmgN
Cj4gaW5kZXggYzYwYzIxOGFmYTY0Li5jMGI5MzgyNTcyNmQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvbmV0L2RzYS9taWNyb2NoaXAva3N6X2NvbW1vbi5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2Rz
YS9taWNyb2NoaXAva3N6X2NvbW1vbi5oDQo+IEBAIC0xNzQsNiArMTc0LDcgQEAgc3RydWN0IGtz
el9kZXZpY2Ugew0KPiAgICAgICAgIGJvb2wgc3luY2xrb18xMjU7DQo+ICAgICAgICAgYm9vbCBz
eW5jbGtvX2Rpc2FibGU7DQo+ICAgICAgICAgYm9vbCB3YWtldXBfc291cmNlOw0KPiArICAgICAg
IGJvb2wgcG1lX2FjdGl2ZV9oaWdoOw0KPiANCj4gICAgICAgICBzdHJ1Y3Qgdmxhbl90YWJsZSAq
dmxhbl9jYWNoZTsNCj4gDQo+IEBAIC03MTIsNiArNzEzLDkgQEAgc3RhdGljIGlubGluZSBib29s
IGlzX2xhbjkzN3hfdHhfcGh5KHN0cnVjdA0KPiBrc3pfZGV2aWNlICpkZXYsIGludCBwb3J0KQ0K
PiAgI2RlZmluZSBQTUVfRU5BQkxFICAgICAgICAgICAgICAgICAgICAgQklUKDEpDQo+ICAjZGVm
aW5lIFBNRV9QT0xBUklUWSAgICAgICAgICAgICAgICAgICBCSVQoMCkNCj4gDQo+ICsjZGVmaW5l
IEtTWjg3OTVfUkVHX0lOVF9FTiAgICAgICAgICAgICAweDdEDQo+ICsjZGVmaW5lIEtTWjg3OTVf
SU5UX1BNRV9NQVNLICAgICAgICAgICBCSVQoNCkNCj4gKw0KPiAgLyogSW50ZXJydXB0ICovDQo+
ICAjZGVmaW5lIFJFR19TV19QT1JUX0lOVF9TVEFUVVNfXzEgICAgICAweDAwMUINCj4gICNkZWZp
bmUgUkVHX1NXX1BPUlRfSU5UX01BU0tfXzEgICAgICAgICAgICAgICAgMHgwMDFGDQo+IC0tDQo+
IDIuNDMuMA0KPiANCg==

