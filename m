Return-Path: <netdev+bounces-117662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9AA94EB6D
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F8B0B20B99
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 10:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52669170854;
	Mon, 12 Aug 2024 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VROIVk+l";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vNcqCONj"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62411DFFD;
	Mon, 12 Aug 2024 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723459566; cv=fail; b=K9dflXWo+/nNK77L54sTuUMHGbaoErxpFAWF/0+Q8QFaoXQ9Xykkhpn0uq1arhurAGKYAPJa1+73M97dT5PC6eQQmM7myREhjUeiUHS2WKhP6pVuKkNvee0UEjN0OQ0MyWe8Dfj7A/AYPsUd+r3iRJRO6ucVuxkALpt/Giww9Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723459566; c=relaxed/simple;
	bh=qPKq/Tm53067KxDfRkgNiGUp2F6CicTzNRuXsSITXGk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gjY8Oi0+I6/l27loUFBisq3SmbxUfpgr0v23BWmdFOmA0X1PbCGbEtw1F0e9Xr4icSQHjH+SHFQioXf0NUs+BQGQozq+D423IJV+uc52Gc9fD6NSiDLQrpZJto7h/NT/tUpGboHlJ+nnrI7OO54LlxkWXXZpoMXlGN/2uIPn9d0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VROIVk+l; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vNcqCONj; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723459563; x=1754995563;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qPKq/Tm53067KxDfRkgNiGUp2F6CicTzNRuXsSITXGk=;
  b=VROIVk+lpHq4EQeETdGgn9uDOMlhZt9w9fgehOzMlH7O2Q8wtC+J6kbI
   1UgvUNHzAEFqxnBXEZ20HjzCh0KL7nE1ChGbIEsv4ZoOpMLGzLvhX2fTu
   mQJ8Gw3hRmShYXdoSySgx/535LGcnKxUioEsAq2or9jFmgjpS1RTOIDd5
   5Z7av2gXBWpKqFMyI1TjsBGDPBlQuDxeJkeylyEs0CS7MiLbT2ygQkavA
   H2Gs2jdCSv//vTpDyAGseTHpqJWev+EMlo/QgMHN6WiEgZPexALjL7BY4
   aJrqViyLuIKrQ2viWCMCiu1WVUw2Dg1m5DJw2In0xh/ZzBo0GZFKKGHLO
   Q==;
X-CSE-ConnectionGUID: h19uvOgxSOOW/6flx8/0pQ==
X-CSE-MsgGUID: fNw4hN5ZTWKDhsD9Tn3+qg==
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="33282048"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2024 03:46:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Aug 2024 03:45:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Aug 2024 03:45:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+LMXUyzDiO4Y5OIkEnLTDBIuphC2WacUUFpH98GO9EuE2hokF3ssjuIXqSN0SF0+g5ZAH03BTXMZarZ/4//2Y9FFHkZWO3vbied/IwY8rJrtekK0gOsO9nyjUeh+CcMhERx6cUKKpZL1bA3TdemnwGn9Nr8DqCMb5jFPYYOsCx9N8izlyHkczTA3ozjPt9XUt6K4381lPh6GZPSyOki40hnO2lMP3IYCacVVZ5wy0RVAVkV0CkuzuC9+O9cxt3/DSTPdOfBRToq4zh2W5IPCxe8gHW01Np6AGq9dukBqZkkx4UzY6GksHkoE35VLHZNmLF5nYkoOmrXfXxdzdzalw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPKq/Tm53067KxDfRkgNiGUp2F6CicTzNRuXsSITXGk=;
 b=LK+R8GfRKT+q7aHn6EKj7QWigLr+YZiB5I8K/ky3AmhiikOwt4vqZvhryHt3ML5z0zc3dkPpU5PlrVgZYtFtrhr2MPscpjBXjmjbcOJgalZ8GVY0ctTLXK0Cv3xFMEKpti4me4+BYXAi/7OHFVgwng8S49wtnA/ZurBoN0C6HGlnUYZ4IBF7+0ILp00g3sgS8D/9G5DoT3KfmYM/3wkmPQO09oEQg0lMP7jD7yi7xjDmeT66K98+sqG+x5j1qkqpQ8GafHmO+xhtJWGIE2mRyRR5zLsYN3p78ytKLOeFgDyH3u6R5Nncs3289yrpg8EUsrqV3PjD7gcKSA4Fc2Uj/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPKq/Tm53067KxDfRkgNiGUp2F6CicTzNRuXsSITXGk=;
 b=vNcqCONjQqHobRVLJ+j8bS8Pm3PSI9cOcWE3Gvxgdghkp/Jgg1r89bOvS9GyIthm/7hhg628SlvSTdWwbHbGfF0Qyi0AMN5QND9YPVpem2MnbTigqRD+nYD4fvwyEL8VLv++zAiiUZyzFAA+1C0LMMRBEtBwWlzCwRVBxAQA1uQV/w1BJhIr9873lpFa6ivb4sWmCpOYjk+2UoxZwmsIFxoWz9FDZb2t+3blEkWcU8EDO/3u0RhRxXPKq+/WfNh/paP6iks2ufdadzXDMsSzS849ZaddJEoXdwaZPFVUCF9pUpYCLFi3n7V122B0RmyLfdJZMEt7xzgK17EyocWbfQ==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by SA0PR11MB4750.namprd11.prod.outlook.com (2603:10b6:806:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Mon, 12 Aug
 2024 10:45:50 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%6]) with mapi id 15.20.7828.023; Mon, 12 Aug 2024
 10:45:50 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<linux@armlinux.org.uk>, <conor+dt@kernel.org>, <Woojung.Huh@microchip.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <f.fainelli@gmail.com>,
	<kuba@kernel.org>, <vtpieter@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<marex@denx.de>, <edumazet@google.com>, <pabeni@redhat.com>
CC: <pieter.van.trappen@cern.ch>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 5/5] net: dsa: microchip: apply KSZ87xx family
 fixes wrt datasheet
Thread-Topic: [PATCH net-next v4 5/5] net: dsa: microchip: apply KSZ87xx
 family fixes wrt datasheet
Thread-Index: AQHa7JTUj0lWJtr2M0OrmoRoNPOKzrIjcRwA
Date: Mon, 12 Aug 2024 10:45:50 +0000
Message-ID: <e93d13b451a263470e93706faa3afbfe2b5cd57b.camel@microchip.com>
References: <20240812084945.578993-1-vtpieter@gmail.com>
	 <20240812084945.578993-6-vtpieter@gmail.com>
In-Reply-To: <20240812084945.578993-6-vtpieter@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|SA0PR11MB4750:EE_
x-ms-office365-filtering-correlation-id: c38371e9-e364-4349-0b09-08dcbabbee72
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TXI0VjF2Vi91YnFNQVJBaml1b0xSTVh4bVpXanRaRXhLWGJqZkxncytIallO?=
 =?utf-8?B?S3pEZ1FuUzdHTE4yRTU5cDFkcGpETGFQZWlKNTN4RW1LVDdCYzJ3TTNscEhm?=
 =?utf-8?B?dzhtMzA4NDN5a1NaNUVpck5DTjJtWUtaQXNtZHlFMllMb05HTHZ2bjlIQ3BM?=
 =?utf-8?B?MWJybFBEdUE4NXY5QlhWZUJsWEF1V3BLMEY2bm1ENHZlcTVKd1UxODJ1TndS?=
 =?utf-8?B?QlpiOU0zT3ZQNHlSVFZBTWZEODlkSVE1NkNSN3BmTjg1RGpZR0dLR0ZTUCtm?=
 =?utf-8?B?di9qc3N0ZVZnUWcwRURzbFM2aFdPbENQa3ZOeXVMemprRlJQbVRjK1ZOMDNM?=
 =?utf-8?B?Z1VQbmNvSk5KN2pMaTZwbGVPYTBDRSs0M3IwNVM2SFlDbFQxR2JSTHljK3N0?=
 =?utf-8?B?RE9kNWJqalQwZjhsSCtzL0twSnpweWhWdm9lVDA2VnA3ZDVRUzNyVUl6S29h?=
 =?utf-8?B?Rm5OQTVESGdYbUFnZEZoank5V3JlQTh5Q3lRdzhWemYyVExRdi9qaFRWR3ZX?=
 =?utf-8?B?aHo3U3dSYkpLYnl6VE9EWXovS3VHek9abmlVdS8yTlh0a3h4d3hoS0hxQWNE?=
 =?utf-8?B?VUY2L1laVHJ5K3BUQm9UNTBFb2dqci8xdjlSaEErMjNTV2I5dW9Ndk5kcDBU?=
 =?utf-8?B?WjFzcnNDemEwNWliZllXa21hVHZNbDUxWTErU1lnRE9vK2FYQmlqYlhGWG1E?=
 =?utf-8?B?L1U0STRmWUluTGZ6YU5FRHM0U0czcm43NWxnMWE4amhINDRqYU8yODV3U3ZX?=
 =?utf-8?B?Z04rUk85dTRHa1J0Ni82WFZDQWFMeWMzbUpHTTVXeXhWeFcrWm8rKzNPNm1X?=
 =?utf-8?B?M3pOVnkxTE9VUStwcDU3aXV0dmhhRjBnNDBBeXMxT3dQWXpaYTNEV21tUlZs?=
 =?utf-8?B?ZnpxaTg1WFJMYnNoMUFUVjdtbFNQL1JDUndyWVBSbkhkcmpDTGpiVEE1d3l2?=
 =?utf-8?B?UERPalBqZFBKb1FzMGQ1OU0ycjM1K1ljQWR2Nm9JajJGNGNQV0JTRjY5MEcx?=
 =?utf-8?B?MmhOdzVId0hKSmlUbVZjMTlNYVRyNW5obzUwb3ZTWXQzZ2d4djcvdWdtdlBa?=
 =?utf-8?B?Sy9idDAxZktOSnkwRDBpbWtrM0ExWEp1NHhyRWd5eUVndm4vYTcxUi93ZmxE?=
 =?utf-8?B?UG0yMGJWNUxFNkFQZk9NZjEvTVVmUzY2T2hCWU9xWDVJZm45NUVvVnB0MlZI?=
 =?utf-8?B?dVFNMWFyY0Z5bVE3eldIVk5jMmFZOTlHdlh0ZXl0a0RxZ3gzVjQvWXpNTXFG?=
 =?utf-8?B?OE5iRzVDK0lZRXl2Z0lGNkloQ3BLMWNPSXlQQU5sRTNQZm5YUll6dDYvNUt2?=
 =?utf-8?B?VisyeVdEclZDSVk5bkcxMFd2MlM2cFZaMmdwNUVWdVpXc3gxOG90Sko0bm1Z?=
 =?utf-8?B?VmwvZU10amZHakF6cVJPNks3bzR4N3ZMMFR6VGlJTk5UejJzdnpEbkx2KzdV?=
 =?utf-8?B?WmdGaXl5VVZCcUE4OW9VRlF1azZhbXhISVJMV3Y2MThVYVJEKzdHSGhTWExl?=
 =?utf-8?B?TkxLbzFBOHhPMExVcXlzakR0cWFQWks0SU05MTNRWjh4cEVvZkwzZ1dFbzhk?=
 =?utf-8?B?QldJNk9CWk1KUlZ4TnpxRHVKUDl4NmJDRm91RDZwUVQwSmRQR3pVazhuLzl2?=
 =?utf-8?B?eE1IMG5qTHR1NWlYWENtZzJ2SXh2Y3l6U2FMRzZibDdZVEczd1BIdnJxZEhi?=
 =?utf-8?B?a2V6cHg5L2JGa2xHQW0yQkFpWFdoZ3JHWm1rS3UwN3plY0xRNlpQcjVZclgv?=
 =?utf-8?B?bUlKQVh4VG0wV1JINk9PWStOcjYxdjBwRlpOVnN5TlFva2d2V0lQZ25pK3BS?=
 =?utf-8?B?NnFoQ0pKWGZFdFZ2dEVVYzg0VWxRWGVoMXQ2YzdMMnNWejdvM1lPTEcrWTJ6?=
 =?utf-8?B?NTNuMkJoaWQ4VmJxVGFnU05ZM3FrUnVXWXgyb01zNVQ4UDFTYXY0Uld4Lzh0?=
 =?utf-8?Q?w3F90Uzr83U=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkptQnZuemxjOUlxRU01TVBmUE5mL1gwMWtMdGE3ZTN3V2UwWkJKbldHelk3?=
 =?utf-8?B?SWNLMkZQa3ZpSllyZDVZMjdOcTU0Q0hCSFdJQnU4OUdzK1BXQWVKVzZvdEN3?=
 =?utf-8?B?aHhaSHQ4YUpxV2U4amlaTUh1NTdMQmkxcXh1OEs1OXlweERhWGlpZzRiQWJw?=
 =?utf-8?B?Rm0zUEdUVE16aWhZT09xWWdHTU54UVU3SnZOTnJoYWdtU3FVMm1QSi82TjYr?=
 =?utf-8?B?ZmZXVUc3NUZTOFUvL21kNFhUSm5SSVBIek5JMS9wTlVwcmt0Qi9yR2IvS1Fm?=
 =?utf-8?B?ZnhTRU5uZXRINVh4SCs2ZW5SZmRlOVBkN1RDMDFxSTYwUE9kL3h4ZzBzRU83?=
 =?utf-8?B?Mlo4ZGZNWlpJYVZsa2FGd21UVDlNZHU3MEtmenlZYmhCb0I0azdwd0FXUWlS?=
 =?utf-8?B?QWJmd2ZremZxMFNwQjlZTHIrZmNRcytIbnVpNzNLYURVcTkxUEd4OXVNRUdm?=
 =?utf-8?B?VWxONVNSRURhMWI0Tjh2VFRFODhONXBqU1B1dGVtc1owellRdCtVbDdwcHBi?=
 =?utf-8?B?dFVsY2RxbkR3eTVKNVBlOE5Qa1lML3BrMkIvdzc1NHM2Uzl4R0Zpb2FkUHA3?=
 =?utf-8?B?L3N2NWV0UTZDS1NrSDBKNHB0VWtoS3BmNEZyTnhMVURycUNxQmJaSjhVS29s?=
 =?utf-8?B?UEFTcWwzVjNabnQ1dlM0cXE2QmNtNTI1MEJkU203SVMwTzdPMHlyRTJKVU5R?=
 =?utf-8?B?aHMyZ2JiZVc5OWl4RlMyUW9wK2ZDWnZsSlE2Y2p4Z1RUT2pmZGNELzM1cGRl?=
 =?utf-8?B?MzZYTTlMN2lhQW1nN01BRzFLZVNTZWNRQm5VdWdHTlR2bGdLeHJRVEZ3clNw?=
 =?utf-8?B?eGxZVXFQaDc4d3FjMFhrNnNHTHRYeTY4VmRpZW9YckF1SURPa3RLZzVnYWdo?=
 =?utf-8?B?dXVnN0xSZ3VKYU9vREVSOFY1LzdrOEl0VGpxOGgweTBDRkRyWlRHZzgrRHVC?=
 =?utf-8?B?bWgxbzRVRVVFbmpGOGtKU3pJWVdGcFV4WEMzR2FsMXBxS2ZBWTNOa083WjRY?=
 =?utf-8?B?Rzl5b2RpanY1VU55WDlXQzhwUGVCVkNFYzhuWUhIaUF6dnN5YkgyMVBnWHll?=
 =?utf-8?B?Z21LWVowOXlxTGM4Y2xmZDIrbXBVVW9HNVF2ZzMrTUR6Rkc1UWxkajMrdXd6?=
 =?utf-8?B?dHg5MnRWV3ZCQXBzZTBRU3BYL2p1cTQ3aEI5UWlnSnRzTndIK3lOcWVnN3dh?=
 =?utf-8?B?Ti96QkNXbGxKRVp2WklqRFo5QjczU2VQdTZCR2xmSTdpaWlPd204WWV0Mlc5?=
 =?utf-8?B?ZmRKQ3lXendQV0RvUzIzcUJac3NTU1dOUW41d2haWE5UWjIyRjM4Q1ZhVW5u?=
 =?utf-8?B?OE11WlVoc3J3UkxmKzFDTWZ0c1ZleTFmTDgvU25haHhISnVzY3BiOTF4c21p?=
 =?utf-8?B?S3ZwMjNsVzlERURoWEtjVE1UekJDaVF3NlRlZVlPTkZpcXRaL2duY3ZBTjc3?=
 =?utf-8?B?Q3ppTGk1dmFZNk9vaVk3ekZldDVMUnd5dVNMVHArTWNRbHpUbU1wdU1lNUoy?=
 =?utf-8?B?eElPZm1zOEMydXIrNGtaY2kzRlA4MzlsUVlKNFdxWGZmV0VjcWprYmNxSHIw?=
 =?utf-8?B?QmUvOHBoWEZZaHpQbXdyMzlPV1Aza1NpdmRGRlY0MHo1K3dIeWlTTnFqRmdI?=
 =?utf-8?B?ZWtCQWVYbTJkWStDclRoZDhVWXg1UjFKZDlFYWlmQlc5OXZqTWZXY0d2ZjQ3?=
 =?utf-8?B?S3BDS1cwWGRqWmI0ZncxbTFVMmJ6NXRMTzg1N1BoL2RlZngyMVlWc2Y5TDdE?=
 =?utf-8?B?eGUwZGdvOEtMSkFSSEdlbVB4UEo3enBsclhFQU92MzFRdnR0NlpRU2doTjdR?=
 =?utf-8?B?WTcxaVdDb1VoWE1ueU1qQWpybHdzZHRJclUwaCtjR0ZjaC9DaGt1UGhTQlUv?=
 =?utf-8?B?TC9iTTNsTktEdCt3R1ZPNVFmdDRGWGpQenV0cFlhSWxIRDVlVmE0QUFEZGYy?=
 =?utf-8?B?aXF2dUhpUHl4UUtPSmIvRW9sZ240Wm0vUEd1RDZZY3dSZE8weFYzdUlTWnJa?=
 =?utf-8?B?MFp5UU5qbVpMbmxBMFBidHlaTTZsaFFoRlBlK0ZPdzRmdjlUaFRhblJHd1Iz?=
 =?utf-8?B?SVZ6c3d1NTkwM2tuN1oyWm0zVzYyQ1ZudXdMcEVLdWgySDNmVHlqV1hNWk9Q?=
 =?utf-8?B?TzJvMitybmRkaG5ja3dpL29SNkwyVEtIYTBqS2Z2b3U1T0M5Q2FqZ09IKzdv?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4822C294B675034E8E580653B482F2F6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c38371e9-e364-4349-0b09-08dcbabbee72
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 10:45:50.1477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0P/LKRLXy5QjNe2c3Lu3dPoCRxbji7jo7liBmGJngoETt/pP5EkaEOycsCAMFG2t1FXYdCp5EppbKN2U9gbUMkjLpqV3IBy+GRmiwb7qbU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4750

SGkgUGlldGVyLCANCg0KDQoNCkBAIC0xNDEsNyArMTQxLDcgQEAgc3RhdGljIHN0cnVjdCBza19i
dWZmICprc3o4Nzk1X3JjdihzdHJ1Y3Qgc2tfYnVmZg0KPiAqc2tiLCBzdHJ1Y3QgbmV0X2Rldmlj
ZSAqZGV2KQ0KPiAgew0KPiAgICAgICAgIHU4ICp0YWcgPSBza2JfdGFpbF9wb2ludGVyKHNrYikg
LSBLU1pfRUdSRVNTX1RBR19MRU47DQo+IA0KPiAtICAgICAgIHJldHVybiBrc3pfY29tbW9uX3Jj
dihza2IsIGRldiwgdGFnWzBdICYgNywNCj4gS1NaX0VHUkVTU19UQUdfTEVOKTsNCj4gKyAgICAg
ICByZXR1cm4ga3N6X2NvbW1vbl9yY3Yoc2tiLCBkZXYsIHRhZ1swXSAmIDMsDQo+IEtTWl9FR1JF
U1NfVEFHX0xFTik7DQo+ICB9DQoNClRoaXMgY2hhbmdlIGNhbiBiZSBzZXBhcmF0ZSBwYXRjaC4g
c2luY2UgaXQgaXMgbm90IHJlbGF0ZWQgdG8NCmtzejg3eHhfZGV2X29wcyBzdHJ1Y3R1cmUuIElz
IGl0IGEgZml4IG9yIGp1c3QgZ29vZCB0byBoYXZlIG9uZS4gSWYgaXQNCmlzIGEgZml4IHRoZW4g
aXQgc2hvdWxkIGJlIHBvaW50IHRvIG5ldCB0cmVlLiANCg0KPiANCj4gIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgZHNhX2RldmljZV9vcHMga3N6ODc5NV9uZXRkZXZfb3BzID0gew0KPiAtLQ0KPiAyLjQz
LjANCj4gDQo=

