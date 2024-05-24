Return-Path: <netdev+bounces-97951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5678CE465
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 12:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6147B21513
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 10:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9011085933;
	Fri, 24 May 2024 10:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WwaT9Zp7";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TlJL0mJh"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B65328B6;
	Fri, 24 May 2024 10:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716547750; cv=fail; b=ibOI23JtXbQ7tuxbucvQkxCx+1gMsHtwyrGQu1XvXnf/fwZZjCpDTdMfVO+pfSG1QFUEuTO4jtEvrHgKin7X18CuVXA/GVJk6S8FZys4tTgtDdY/ACJzV1Sq0S1TengVZlYqL2BYyaeD2N55jkOYLHDozwiT5B4JMipGWggQvg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716547750; c=relaxed/simple;
	bh=OqdB0CkHhAFbeC5DWWgFlkdd6DwBC+JlRS+/P08Tsn0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jLXMwxyssOvym2mq9Z4HL/moB0P3t1Uw0y6kVFJRJKD8pD5bSW2PbTxaaHPgg1PydeXuBaqiWXmM6pG/1UjLhkEKmQFpuxlLid4l+TOaJFO63dyZGAxDKDTZxSjKSczQ+8zchdBt7YZX5O3LpbJIhAAlMRkuyt+tafYYTW0V5eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WwaT9Zp7; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TlJL0mJh; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1716547748; x=1748083748;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OqdB0CkHhAFbeC5DWWgFlkdd6DwBC+JlRS+/P08Tsn0=;
  b=WwaT9Zp7Gv9zrx2QixEGboZM07YzzIIk3SGOlmus0xC2DZQzlwLV/AXw
   hiJ1wqPlyHNaz5vz9wHkBsoQWlkAmb4NS8lo8ZAlu9Tb2aYbJ4Bv8SHsZ
   q+L17XDSeLTI/HTTp363SRHYfXo/gPX9qSCFt0HBqGxCO4HmYqtl4xn2C
   nDuNqtmQunjwgvktVFB1yGhCKaYPSTUN2dfin78vMCGYWY18CVTGJSfWp
   /TneRZX6srDRTa+/p5Qx2H6AsC845Ev5wf00gppPLJxpPMduoy//UR9kO
   P7dRn/Uv4/i0Y4NDSupebCzLLU4P7lNlGiOwRfW1Yq8WqFm3lExfj4IJ6
   w==;
X-CSE-ConnectionGUID: QDEc2fEdTPilu/W3Pl/Izw==
X-CSE-MsgGUID: gKOgb+MWT6OkzFuArzbdjw==
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="256906505"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 May 2024 03:49:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 24 May 2024 03:48:36 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 24 May 2024 03:48:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmSccBDBASffeMqfnp58/pdgstKBPS8O179acNozDnH2QdYy+mqOMXQl9UmWdMw4lY4v1hljh+XohP/VukDzYE1H0g6HieeZvAXGUc50iCir4keJYNw8SOtQG5B04xOdoOo10EP+GE+wzRwW3zDMGCZcogd57K+zyQca/QbsJixm6s/LIeJtVHn/6WR5I9vaDnWs27GL3h1g+3zSuY9vpyfY7qYxXVHuKh+dmBEZcWBQ8KQPTCCMR7VjuIsP1VVoC6OcXlaqy6gjSanUhg0X2UlWwO8xbtdsEeBfXv8sc30KVqlkkHJGw3L9/49QTkim4dUOKWAqq7O/m2l5G8tRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqdB0CkHhAFbeC5DWWgFlkdd6DwBC+JlRS+/P08Tsn0=;
 b=WxG5xv6T1bWCxkOfn0rL5W97wn+n+JVeTepFGIodXO3SV16OVi+LosoTvov7UbvMPxLoeySe1qBRedcM+ilUjutxWWiEaNC9R90jmtxOlzbZtztDcwfTf4E6Ggkjw2TsBx898tZUovYGz02ep/1OeYmy7NJXSDB4SuZlA4MA16SlS8VuSSl7xPCJyiLSEpRbkuSUB1y3VSXyTlmTJCoByGBnqGlQqDJlpwo3TB/N1TAebt4iY1qvH+yww9z024g6DGnGlTYBlAB5fzBVaBfldfGBsjpDsuu+6qAqcungiNWG066hAkG0XuFlqQp5s9Yrw1DQIC4lNDSkm+ymYDe58g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqdB0CkHhAFbeC5DWWgFlkdd6DwBC+JlRS+/P08Tsn0=;
 b=TlJL0mJh8Gmoc7NPzjo+WpaI+igDCMXzq0kB5Hwj15MNwtt3jhpT14N7H4OtXHxjPIYTLIwSnJRjVR2hkpCErBz2Ox61OMX0XsPv7COx6toqZwI3eicK7PFPT5vzR0ERP9AIaGn+glgT2EiBqGTwaTcOJalgzl1VI8AFqSahBI7Eft4lE8rspmFe3vHPaDZWeTAU0jGb7aPoLKhRfh7f2/+g2cNgJfiHX82yjBeU5cDMIn02G1ze/PkUWcKloVO3A28PMkxo3r30U5Ae7XC+RKAAuWySvwg4LA8y05QHtq2eObfJAA5C8n0kHqcWs6Rb+jBQNOLoNKHqJcakITrQ9w==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SA1PR11MB8474.namprd11.prod.outlook.com (2603:10b6:806:3ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 10:48:33 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%4]) with mapi id 15.20.7587.030; Fri, 24 May 2024
 10:48:33 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <steve.glendinning@shawell.net>, <UNGLinuxDriver@microchip.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: usb: smsc95xx: configure external LEDs function for
 EVB-LAN8670-USB
Thread-Topic: [PATCH] net: usb: smsc95xx: configure external LEDs function for
 EVB-LAN8670-USB
Thread-Index: AQHarFGdKs4gtKjRMUij/lf1SheVtbGjdfUAgAEOQ4CAAECjgIABckuA
Date: Fri, 24 May 2024 10:48:33 +0000
Message-ID: <0a523bd4-952f-4f2e-a60d-2899ae7d1316@microchip.com>
References: <20240522140817.409936-1-Parthiban.Veerasooran@microchip.com>
 <9c19e0a1-b65c-416a-833c-1a4c3b63fa2f@lunn.ch>
 <f41c1acd-642a-4449-a03c-1ba699bd8441@microchip.com>
 <5853e477-be38-40b3-8efe-93f20c57e6fd@lunn.ch>
In-Reply-To: <5853e477-be38-40b3-8efe-93f20c57e6fd@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SA1PR11MB8474:EE_
x-ms-office365-filtering-correlation-id: 2792c7d2-992f-4787-587b-08dc7bdf0eb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NHpxOWJsNUxaOWdDaXhtRFZzcThhY3FvV3dMVzExLzdLUFk0aGJPQWxvZjhh?=
 =?utf-8?B?U3BpbTljSk56OU5zWm5tbzRzbkZBVjZMdE1jeW5EQmVXWWJYNjNOOVlxRG9K?=
 =?utf-8?B?UU5sZW5XS0x3UUE0anFUaFlNbkc3bVIxUzNUOThiK29PRmZXVWNaM0txQ0VW?=
 =?utf-8?B?c1hmblFaRjhEbWZIcjlybTdpLytVbDVma1pZUVJGdStDM29ES2RYVFVaY3JM?=
 =?utf-8?B?QXZBODdMZkhQTFJKTUI4dHo5eW5heGlONjlNV3RPS0VKZGFNbm95Ym15SmU0?=
 =?utf-8?B?SlJTV1NkdGh5S1VOTElURkJBM0I1VDdGdzFEMHJHcWJkSnlSWHpVL3h4dnRv?=
 =?utf-8?B?MUpKWkh4YnpydHpXOG4yOEM1L2tEMC93Y3hTOFRsT0RjVVI4SGRYUjlJbFh2?=
 =?utf-8?B?YzBVU0pEaHg4YWpXNXNEY29DeThLejJ3TkdpejBpV09KU0hERG9UWlhqVkdO?=
 =?utf-8?B?MWJRMnM1K2V3L3JlVVN1QU1mMnQ1WS9YSUg2aGdDOTJxdGRySXd2MEVwVUd6?=
 =?utf-8?B?RlNTNHJIcDIxZ21BSG1kM2JINXJkOWd4SDJqM3ZRMWNOUGJyUUtCckpGMkg1?=
 =?utf-8?B?VnBPdE1TYkQzZGxlYmRZQXZKWXUwaittbG1lSzU1TnBZZ2RZR3g2M2RCMjdk?=
 =?utf-8?B?WTJXdURtaUpqU0RpK2FPTXluMG45aDBJRXF5WWNDUHpGakpTSjM2Y1NRS0RS?=
 =?utf-8?B?clppdlU2MWZHaFpoTUE0VUk5M3g1WEM5bGRZb0t5RmFqM3RnNm9BbHEwemdp?=
 =?utf-8?B?a0V6WVRwM0lwRGpkVGRmSldVWU9KWFBRMnMzSEVjWlB5ZFlJNDZRS09aRU9F?=
 =?utf-8?B?SlBmY2tHc1FacGFoeXMvT2kyMzJkUVFPTjJrSGV6U1RvbUJoWTZ3OCs5SzJX?=
 =?utf-8?B?VXVabWc5bC8xYU0ra2NxL1A1Z3owUytwTVpReFQyemVURTYrWUV6bE1SaUpk?=
 =?utf-8?B?SUhVRVBoZ3lJMjl4N1l1Sm5wMlNUTWl1bVhYL05MNVZCemY1VXJqanNtWk5w?=
 =?utf-8?B?dEgrQnBQeG1mMW83d1ZjZVJzSjFDbHZyTXFlTkhHYlAxQWtLOHRaRUNpU2Vp?=
 =?utf-8?B?WVdLUnVmMzAyZUVTNjd3Z2twZkkwOTZKV2kxREoxOFU4SjIrQnRLaXQ5aVZV?=
 =?utf-8?B?dHVPRFBsVkc4OGpydVgxNjBTODZKT3ZXSEpIVlF4TlduZWJGYWdOVzlCTVB1?=
 =?utf-8?B?OVlMTC9iMEI3UXFQTldaN0JUZERPdDh0SEJIc1RqbnJEOXhOSzZUSTZwUzQ5?=
 =?utf-8?B?NjNuU09GTWRxWTY3QlVEbG96NzNkWG9hcy9oMzNlU3J5ajcxdWF2aEtvaWRB?=
 =?utf-8?B?ME0rblNDcmx3enVOcy9IOXBoQmJhZEdNQmVISndRSmhTN2l0aE10aHB6Tlhh?=
 =?utf-8?B?bFFWUnFzOWF5bUNMeUJHZHpyWUhTSWVNM2hxQ2lnUytxeUFGL0F5TVBaR0pT?=
 =?utf-8?B?ZjN1ZExUS0R0eDl4cjdET2U5dUpGVGFpYlViNXRmT2k3VEtrdWVwWm5iWnVa?=
 =?utf-8?B?RXRkS0N6djJFRUJJdmtYbGsvckloSXpTYXE5bHZlUERUcVhIQ3YxcnQza1c4?=
 =?utf-8?B?cXFldGtqL1pRUCswTk96ZkZPRzMwY1B6Y1FzdHBhZW16QjFuajhSVVJEaFFm?=
 =?utf-8?B?bHp5dUpqWWh2VEtYYkFVMmNRWnJ1bkhHeFU0UE42NVZNZVN5SC9VYmdxMDZE?=
 =?utf-8?B?SXlNdDVuT29JUWplOExqZk9hSmZhdWdoYnFSL2JkYmJwWUpmdlZwR3BMMFJv?=
 =?utf-8?B?SWRXN3loTEZHR1pzQ0dyWXdYU2hZT09lMUlIT2JJOVpCak80RVZQMmlUN1BO?=
 =?utf-8?B?R3dpN3NjL0tzaHRoNWs5UT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2lGMlBsOXFTTnpRNFg2M0xQYnF1WGNYdlVnbkhwTlZ4NlJmMmhzLzlrNDdB?=
 =?utf-8?B?NWg3Y1hucG9DeTBtYmxmZEVVMHdkVG4wbWZHUDlRLys4UU5kUzNiNkd4eWF0?=
 =?utf-8?B?SlpMd3J1SnlMQ3dSNUN5SElTQ3FGdU9DZFlNdXBTcWVVM21ibjlxRzBzc1FK?=
 =?utf-8?B?SStsaHBEN1EvSzY4YUMwWUpVYkRwYmdRNFkxWXJnZUtEY1pOc0xxK1NqMEhv?=
 =?utf-8?B?UncyVnZzbHdIZkVlemtYWnNPU29lRW8yWnBtdFNYVVVJSVNKdGhyRTFHdjVY?=
 =?utf-8?B?ZTZGSE9HZ3VjaWc0TWs2TE5Day9hbkQ5U2FINSt5Q2FUMzhUN2F5UFRxSTR0?=
 =?utf-8?B?ZWJab2hLZ0tGdFluRVduWXkvdEFnT2NkeEd0ZzNTbWc1bGFEZGdhaG9uMzZW?=
 =?utf-8?B?d1c2enM4VXRMaEp5Q0VtY3NhUVdETnlZZVFlTEpRbnNmR05IdVROOG94a05E?=
 =?utf-8?B?ZElLUTFaNVlzckNHSE1vbDlDSk14SGREcDNNOGtGZVVhOCt6d1dKVEhnejky?=
 =?utf-8?B?eFQ3L3hyK0xpYm41Rmw4THlrTVhhSU9iRDM4a1dxa0FjLzl1TTdDcUIvclJr?=
 =?utf-8?B?bFUvcXY4d2VLVDVaaGxkbUFNSnRuVm1ybHFzOWM1REtMbE12UDNZb3R5blJZ?=
 =?utf-8?B?NE0wY25HUXVrdEkyUnVEY003dXd5NmNsNG1XZFNQUE9aMmRWR0RkT3d2WHBP?=
 =?utf-8?B?R2diYllneSsxSy9GN2orNisyZFlXUmU3Tm5xWmVqVHV4eE5TV2w2dnE2NEV4?=
 =?utf-8?B?aEZ0c0pqZlQwSU5tcDhqK1RFbGl2SUNEQXhqNkdtOFZhWUl3eTBvcUdaYmh0?=
 =?utf-8?B?UTljdkJkUjVhZ0c3UTl3dS9sYW9Ma1YxSXJobk01Q2pOeFY3NlFvZ1VIV2ph?=
 =?utf-8?B?bTJoVERWUXk4dm94aGFUOTRkZkVvR0NObnJzdmZuWWtrQ3lpdGJDR0VYc3Br?=
 =?utf-8?B?WmhyRnc5ZXFIdnNQN0h3UVJRcVJsaUFmYy9PNDJic0Y5OHZQdjBaRnBEOHBD?=
 =?utf-8?B?WGpDeEk5ZHFZbmdjR01TK2UyRkVSTWZNZW5rVmJGUHBQbXFXQUZvMEdra3ZZ?=
 =?utf-8?B?ck5KbS9BK2FyeGQzTXE5UWtyR3ZoTEFZVWJmWEtXVThaL3IrSnZUbnZGWTlX?=
 =?utf-8?B?dmZ4OWpqNWdaL0RuM1hjY2x4MGdQc1MzZ3dlYU9jS1RlaTFxSjZZaHRCK3hF?=
 =?utf-8?B?OTR5dnhVYjNSQWVtUlp5VElnRTM4cnpBRGRvU0U0bDJkcjRLRUloQy94YS8y?=
 =?utf-8?B?RTJLVlRuM2hJYzhaL0Iyc0xFQXlQQ0RwS3dxVXBVM1g0SGw5ZVNRSndKNDlB?=
 =?utf-8?B?TTBrWVdGdS9rQVRKK0R1WXlFamJGVUFpK3hRYTdXNVoxWnUvL01rRE91RVVC?=
 =?utf-8?B?RHJjOVJLV3YrcU1jUStJNUIvTjlBREhQOVpKSnRhL281VitGVzNONTRJMXlJ?=
 =?utf-8?B?WWxNZ1lmbEZ2YWtGUVAvZ1p4UXpaeVdMRnRXKzdZdmR5WjVZdVZUSTNId1Nu?=
 =?utf-8?B?WFJ6aEs2UWlHbVVnZWlCU29SbHI5RmZ5VUQyZjJ3ZHY1WG5ZaDlRczhvUEYw?=
 =?utf-8?B?RUV2Ym10WCtTeXNaYVUya2Z2d3FGNXdlRDNBZjE2U2J5UE9KYXNFUzdRb3FF?=
 =?utf-8?B?U3d0Q0hpa3QrdG56MDNOeXoxS0lPQkptcFJCT0tBa2RzYVV4ak5XRHFzbGp0?=
 =?utf-8?B?VEhlNWFON1BhMjhQcUZ1UEtXYkFEdGszcWFXNzdHeDZ3cGoyT1BqZm44eHJJ?=
 =?utf-8?B?NzdMZ3l2aklzZFNRZHdhek5sbjBtSHBUcG9pYzdFeUhsVGdlV2V5Q21panBB?=
 =?utf-8?B?UklWanJjblIxcXg1eDUyM1pFWUVnMXg1QVVrdTdLaWJUQXc0bHY4bGttbFpC?=
 =?utf-8?B?YXpNUS8rUDJMYXJySnFtTTZZRFIvSUFaTGo1TGtxam53b1lXbnZBZjFDSEo3?=
 =?utf-8?B?YitoRm5HaXRCdWFYZGxsSUFQdEJFRVJMZGF3L1Y4anNpU2RoYlYwRURCSzl5?=
 =?utf-8?B?YXBkVzJ0c0hOc2xjcFA3Y1RObG5BeUhyWUtaNzdqUkNuMW96NWJSZlhQMEJi?=
 =?utf-8?B?dTR3cnY1SjM2RXBCZzd1cmlaMXcvVHVCUFVrQlI3czc1SnpTMXVrNzdQck4w?=
 =?utf-8?B?Y3g2OFkyck1LbHlnWk5kSVNzbmNVRDR4MXY1Y05hVDR4NTFLcGUzbFRWR0g2?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CCDFC4DD02FA048A8F2F9DCF58A9647@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2792c7d2-992f-4787-587b-08dc7bdf0eb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 10:48:33.3884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r40dJR3evLESSg+RXzY7cJiG2jvvtXKc6NYTfkqLThVgyGMEgDhMbyN629f3E8HW7bFstQNbzdJxpqUSuSeIwwhU59kZyyeN/NupDX7faCaAuzaNGnyg1+jEXIvEWTtX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8474

SGkgQW5kcmV3LA0KDQpPbiAyMy8wNS8yNCA2OjEzIHBtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUaHUsIE1heSAyMywg
MjAyNCBhdCAwODo1MTo1NEFNICswMDAwLCBQYXJ0aGliYW4uVmVlcmFzb29yYW5AbWljcm9jaGlw
LmNvbSB3cm90ZToNCj4+IEhpIEFuZHJldywNCj4+DQo+PiBPbiAyMi8wNS8yNCAxMDoxNCBwbSwg
QW5kcmV3IEx1bm4gd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5r
cyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZl
DQo+Pj4NCj4+PiBPbiBXZWQsIE1heSAyMiwgMjAyNCBhdCAwNzozODoxN1BNICswNTMwLCBQYXJ0
aGliYW4gVmVlcmFzb29yYW4gd3JvdGU6DQo+Pj4+IEJ5IGRlZmF1bHQsIExBTjk1MDBBIGNvbmZp
Z3VyZXMgdGhlIGV4dGVybmFsIExFRHMgdG8gdGhlIGJlbG93IGZ1bmN0aW9uLg0KPj4+PiBuU1BE
X0xFRCAtPiBTcGVlZCBJbmRpY2F0b3INCj4+Pj4gbkxOS0FfTEVEIC0+IExpbmsgYW5kIEFjdGl2
aXR5IEluZGljYXRvcg0KPj4+PiBuRkRYX0xFRCAtPiBGdWxsIER1cGxleCBMaW5rIEluZGljYXRv
cg0KPj4+Pg0KPj4+PiBCdXQsIEVWQi1MQU44NjcwLVVTQiB1c2VzIHRoZSBiZWxvdyBleHRlcm5h
bCBMRURzIGZ1bmN0aW9uIHdoaWNoIGNhbiBiZQ0KPj4+PiBlbmFibGVkIGJ5IHdyaXRpbmcgMSB0
byB0aGUgTEVEIFNlbGVjdCAoTEVEX1NFTCkgYml0IGluIHRoZSBMQU45NTAwQS4NCj4+Pj4gblNQ
RF9MRUQgLT4gU3BlZWQgSW5kaWNhdG9yDQo+Pj4+IG5MTktBX0xFRCAtPiBMaW5rIEluZGljYXRv
cg0KPj4+PiBuRkRYX0xFRCAtPiBBY3Rpdml0eSBJbmRpY2F0b3INCj4+Pg0KPj4+IFdoYXQgZWxz
ZSBjYW4gdGhlIExFRHMgaW5kaWNhdGU/DQo+PiBUaGVyZSBpcyBubyBvdGhlciBpbmRpY2F0aW9u
cy4NCj4gDQo+IE8uSy4gU28gaXQgaXMgcHJvYmFibHkgbm90IHdvcnRoIGdvaW5nIHRoZSBkaXJl
Y3Rpb24gb2YgdXNpbmcgdGhlDQo+IG5ldGRlIExFRCBpbmZyYXN0cnVjdHVyZSB0byBhbGxvdyB0
aGUgdXNlIHRvIGNvbmZpZ3VyZSB0aGUgTEVELg0KPiANCj4+Pj4gKyAgICAgLyogU2V0IExFRCBT
ZWxlY3QgKExFRF9TRUwpIGJpdCBmb3IgdGhlIGV4dGVybmFsIExFRCBwaW5zIGZ1bmN0aW9uYWxp
dHkNCj4+Pj4gKyAgICAgICogaW4gdGhlIE1pY3JvY2hpcCdzIEVWQi1MQU44NjcwLVVTQiAxMEJB
U0UtVDFTIEV0aGVybmV0IGRldmljZSB3aGljaA0KPj4+DQo+Pj4gSXMgdGhpcyBhIGZ1bmN0aW9u
IG9mIHRoZSBVU0IgZG9uZ2xlPyBPciBhIGZ1bmN0aW9uIG9mIHRoZSBQSFk/DQo+PiBJdCBpcyB0
aGUgZnVuY3Rpb24gb2YgVVNCIGRvbmdsZS4NCj4gDQo+IFNvIGFuIE9FTSBkZXNpZ25pbmcgYSBk
b25nbGUgY291bGQgbWFrZSB0aGUgTEVEcyBkbyBkaWZmZXJlbnQgdGhpbmdzPw0KWWVzLg0KPiAN
Cj4gWW91IGFyZSBzb2x2aW5nIHRoZSBwcm9ibGVtIG9ubHkgZm9yIHlvdXIgcmVmZXJlbmNlIGRl
c2lnbiwgYW5kIE9FTXMNCj4gYXJlIGdvaW5nIHRvIGhhdmUgdG8gc29sdmUgdGhlIHNhbWUgcHJv
YmxlbSBmb3IgdGhlaXIgb3duIGRlc2lnbj8NCj4gDQo+IFRoaXMgaXMgd2h5IGknbSBhc2tpbmcg
aXMgaXQgYSBmdW5jdGlvbiBvZiB0aGUgUEhZIG9yIHRoZSBib2FyZC4gSWYgaXQNCj4gaXMgdGhl
IFBIWSwgd2UgY291bGQgaGF2ZSBvbmUgZ2VuZXJpYyBzb2x1dGlvbiBmb3IgZXZlcnlib2R5IHVz
aW5nDQo+IHRoYXQgUEhZLg0KT0ssIGl0IGlzIGEgZnVuY3Rpb24gb2YgdGhlIGJvYXJkIG5vdCBQ
SFkgYW5kIGFsc28gdGhhdCBkZXBlbmRzIG9uIHRoZSANCmJvYXJkIGRlc2lnbiBiYXNlZCBvbiB0
aGUgcmVxdWlyZW1lbnQgSSBndWVzcy4NCg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4g
DQo+ICAgICAgICAgIEFuZHJldw0KDQo=

