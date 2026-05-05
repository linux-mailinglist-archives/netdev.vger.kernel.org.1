Return-Path: <netdev+bounces-284501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GroBr8X+mlYJQMAu9opvQ
	(envelope-from <netdev+bounces-284501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:15:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A95BB4D1136
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D86343060CF8
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 16:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EDD48AE39;
	Tue,  5 May 2026 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AqXqj9eY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05E248AE30;
	Tue,  5 May 2026 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997357; cv=fail; b=VVhthVk8kFJpOXWFFmcZL06fWUpIqUgRVeN1i+D8NJSbEOgkrg0qRveN56FUPYyrsqzVTStKjfTyj09eA1dPxTATDtQbPM9tFXnYjyvDdPyosNr05iK0bHixoklZL/hh4LcNYNMKNcOfdO61XHwbHgt6yIiT+Ci+EmZtmJZx+0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997357; c=relaxed/simple;
	bh=zwrQ5xwiHGCBlm3D6XOoc2wRMLfyKqFDhum1WRjD9UA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A19SeAs0il+YmlkmuBPsX2UAOIFsXrZfOclZlzUJEpUpAEYXgc2LyMvgRb1LRTLu7YHhWEkhUOgimzu3fk6J556VTpnUmaAX/x965yhSDKTQ8YkawpvmnonwVPhgPKbVAkixEHCMuvHLKpCc2cDvahoaF1ExLBWPCpIR3xY7KH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AqXqj9eY; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777997355; x=1809533355;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zwrQ5xwiHGCBlm3D6XOoc2wRMLfyKqFDhum1WRjD9UA=;
  b=AqXqj9eYAs8v7SfaNAt6DxEHf1881f24Jd6Heay1bnKK7sbbSzYHGDoN
   BlbHA24LHO+cNu/tzeRm4c4fYE/HO0W4mjBQa0979gX8y+H9y4wF66ncA
   e1yvuJ92dCBNrwL9BOkOkO2VVJAy3IjWaCa8l3XPbsyocEQO6kpHWAT2M
   ArU/uo6L29ZXVqFiDUfSnTrnolxRDZpLp4LO2RzDoi/iMFC1SKgqWbnRv
   4IfP4iMKXfWtCdNovmLo6XCiTutlkvYQgD8aOfZIa8g1XNgeKyANBFbMs
   UtR0jrq+1daoLHmDxB5aME4xItQvoD0Bs6NsLN76XZDhomueezH9rt1l/
   A==;
X-CSE-ConnectionGUID: 54B1XTWnQkm7n53yrc2shA==
X-CSE-MsgGUID: LXyi7e1hTDC7/z+/vr5zcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="81434143"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="81434143"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:09:14 -0700
X-CSE-ConnectionGUID: cbDzjHYRQeWbrN8OlhYmug==
X-CSE-MsgGUID: ll5vdo65RC2zFohVbFax+g==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:09:14 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 09:09:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 09:09:14 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 09:09:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrymHWBvZAsTrN9HEt1btjiCdHHJuGzSMDpVPRHtMXt3E2RUZCuCoY1SIZwsKoY0d4GH4v8fDpmrUPmW/znhveVdSdTLE8zrzeoCu0LtCi8+mnDgfMutZdLfWsmEra7BCcgMy80yL2vZ2o/De5EOx77+Q/66E+0y5YSBX6UKNO+EphHwnDM0OvsLBwqeKFp2YL91czrpBL1B6a7LhPmCSLDUw4nehSpzoXUaaY8Cj/flWDFCPMDIPDu/x+bBCVcj869Sqx/VTd6Ydmn6AsWTjUZqOM/Y2q6g/xMR2pe5soxocvGE6YEeHZnuLYu/60yxx47rSXUQMCgnm8Gn3z6ibA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BE0w/sd8mFCcuuITJCZ/m7VkTFNFVKl6kzgYtsHLL4I=;
 b=ds3cNtkgzIRi5R1Pz23f+bm6ivDxqkvb/m7aOmHC2BNE4VHP2UK1jdEjg3EiZCZa4oKdYi7MrIAkPqGp+dAYJWRXQKAc5CayDxy9Yj/IFwHj3hLlWFmsrla1H6BFJpWSom1uZnfkNmM5iBcfwaouo4x3nKdY5CejZrh205nD48IfnMROUpGDxjuuaM9FAfXl37ry20QfI2Y/eUYRFuEGpFQiS4lUYj+8DGWUwhI7u5rXGSE8+EP2iIhC7CAbIGC1R3caYRgHFkis+tdFeqbnIym3VwMB0+HoUq/OxpdJ3zhsn1UJMp3MyFFRp7NcqZ0jpkbUiwnRqVAK2Dt4zY1/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH8PR11MB9829.namprd11.prod.outlook.com (2603:10b6:510:3c3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 16:09:11 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9891.008; Tue, 5 May 2026
 16:09:11 +0000
Message-ID: <dacc8ed8-ad35-4458-b9be-dbc5d738edb7@intel.com>
Date: Tue, 5 May 2026 18:08:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] gve: Use generic power management
To: Vaibhav Gupta <vaibhavgupta40@gmail.com>
CC: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy
	<hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Willem de
 Bruijn <willemb@google.com>, Ankit Garg <nktgrg@google.com>, Tim Hostetler
	<thostet@google.com>, Alok Tiwari <alok.a.tiwari@oracle.com>, John Fraker
	<jfraker@google.com>, Matt Olson <maolson@google.com>, Praveen Kaligineedi
	<pkaligineedi@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260504182139.604925-1-vaibhavgupta40@gmail.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260504182139.604925-1-vaibhavgupta40@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0047.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::36) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH8PR11MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d1321f-15be-40f3-c013-08deaac0a4d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: /ts/TjQTgGocKldOxayglSOZB0w6g1sUa0PKVuAS3OD5L+YV7jx0YaN5fjeZkwE6nesF0jOQnv2wd4TQdDH75cxUg4xbhIO8/Yz6dSX7uUCJWwa1F3R0D2UWeiFUiupnRl9W0blgIuJmb3OJcDQ9+o+GVi11kly70I1Ke7JGrX23RnZ2IuJXJd/GCeoFfPLlf+TKeiin53cSUaTDZoTGnlpajAC1ofaLa4b5hCmIkUUwj6L0Ep+Fr+wpdYjwFzGZM/Q3kJLT9rOKzlT9gU90Wg5oa+BAiVpDfEmbJs6L9rpOCKStKw+bASO8wO7SDJvXmfh2IuUjmxJSX47pgTfj8U8irGPyEOvQ16MezXGnxKf+7hBxt6O63iv/AycnPuy5z8W0nFMBoOyEzTgKEUl18CMUjDSMoyMonVdWysOTgc8ORWZU16LBG3np59AT++jzEqoGFI9zQiEQTWGLgx455gosVnkBa49YV2sTrNlYwSQQggh8KtQUzRKKpVR09rlgU5B0aYP1cHYWDc7D25wz/zHAc+AxDvaCJ3JEqAs1tIYm7fGbUHNEwnEUf/td7Wd8WAnJhdiVcujSby1tKK86LKjvnJk5Gco/TSBTbHp0cw8Whcxo3AcaSy2beR27py7RDbw4r/YgiDIg7Xxmpe22Cof8XROppZyFKatyUxgE+ky4NTRo4rneZnXI3+bBuOhs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTFSTlFKbWpBbmorUlVDMEFucWVYSTZySHkxeDhURm1YOFF1Z28xRG5xYjFK?=
 =?utf-8?B?ZklFUTNiWGE2b2I1Yjhtbk9xUSt5ek84enhlczBTOE5yK29uOGdZQ0pZSXc2?=
 =?utf-8?B?ZkU0UTRpUndTSjZ6bjJIdlRyU3dVK0xScnkraENpYkhWbEJtWVBpUW84eVFy?=
 =?utf-8?B?dlF2QnBjQkVmQmU0MDNZRStZZE5TUzhJSGpjTDlPMG92dkc2NWRMVG1HZnRo?=
 =?utf-8?B?djFQTjgrakk5WUxCcGw1NDF2L00wS3hTeExMWnJkRllCSnpsa3ZBL1ZySEVV?=
 =?utf-8?B?S3d6S0w1UXVlWEJveGhHd0h2M096Umt4aGVDcGZDY0NQenFtbTZvaEpiQmYr?=
 =?utf-8?B?UldDRkM2RzV1NkYxS3RiSUE3bU5vaHRxcHhqdDJvck1hdVdvcC82ZmorcXRl?=
 =?utf-8?B?K2RRNHR3Wk1rdWJoSmFQUHB3RmxkdVlacXM5a003WXpDNmVXOWZaM2xMeFBB?=
 =?utf-8?B?N0hxcExkZDFlMnhUazN4RzQ3OXN5Z3VTYW5WNzBwNi9yZktCNUsxRnVseXZP?=
 =?utf-8?B?cmZ3dk1wYklLRmJOYmV6Z0ZPK05DK0ZDTUYvV1E0cE1NWThESDIrbmk1L0J3?=
 =?utf-8?B?bGF1Qld1aVhqdVNCWXRDeHVxemRRVHlEWTJsTWo3MWZDR2U2NjBQb3hpTWxj?=
 =?utf-8?B?SWNTcUg0UC96d005U3I5YVhYWDhod1BIQW9ISlpLQzhZUTVBUzZ1Z2EzZk9s?=
 =?utf-8?B?YjBRYmZsbFUvYXh2UWFrcGpPQTRQUFBuajJaUzRRQUFOVUNvMHpNanlwejhB?=
 =?utf-8?B?bklTaVJyTlFiaFBrZXdQNVdEYXljQ2Z5MTlnc3BEVzB3aWtUc1FobVh0OHNj?=
 =?utf-8?B?bDBNZ0hYS0FyV3RmM0p0TjhtK1dhTFZ0OU1JKzdLOW5pc1BDUDBlcnVjeTdO?=
 =?utf-8?B?MFRHNUg1SWorODFQa1dwWXZXUW83YVRySWMyL1hTcmgrRGt0Zy9uRDRPQTRr?=
 =?utf-8?B?bzVkekVYNlhvRkVXWEE1cUxOb2I1T1lRbis0b1N2MFMzT0o2VjFSVkJJVHdF?=
 =?utf-8?B?MkxqRzBEcVEyRlRQejhNUzI5WlIxdGhoYkZKd3hYSENWeXovR2dETkJSZFFo?=
 =?utf-8?B?NGFMY2VwVWU4REhqZmpoMzQ3c3FOWFNGaVI3UDI4NW9hQmVoWitrVThDNjc2?=
 =?utf-8?B?WVJqWFNsWi9mS2thR0ZjZzdLUHY0MmllNHNrRG0rcVl6U0lMc09GTzBkK1F1?=
 =?utf-8?B?WEdtT3c4eEVxeWg5K25mYkgxTjBBRk40RGc1Qmx6alJNVVk1dHFIbnZqQlIv?=
 =?utf-8?B?V2czclRKa2twQ0ozUUZ3UWV4M3B3VTkyZTI3NWNlcXhNemtFa3RXbVVJR1Nw?=
 =?utf-8?B?eUlmNHB2ZFY4b2xCNU1aV25LaG83WGtPc05NbVloY2JYYXBtaUxHeVVOcXlB?=
 =?utf-8?B?UzZUaFkxUTBZRmZzMkJqQzBVQ1I5eSszV3RHSXM5bEQ5blRpOEtBdk5PYlRT?=
 =?utf-8?B?RVJNTStPK1VlZEQxQi9qY0xUZ3RabGJhZHc5REdRVENwWCs1TjZPWDVyUkVU?=
 =?utf-8?B?ajlGa2FrYlRiRU53dm9KVGhlM29WQXBSeEdPY01WY05IMzJFZU95akd4bHpt?=
 =?utf-8?B?cVlDSUVRdE1jTFZRbklKTWo5UHVLbE1TZU9IR25mdXo2ck13TElIdkZRQTFh?=
 =?utf-8?B?MzR2QmJaS0hvcmRwNUhsdWlQZzhtSkcwTjFobjdETGt2UWRTQkY4VXFpSXJF?=
 =?utf-8?B?bnp6UzZlL2xnVXFnSjBvSzBBSWIrRVM5QzNxU3p2ejJoelVsemhzOHc4MUVK?=
 =?utf-8?B?V3kreElVYm5rMXB6WTAvRlhObXFaOElqTHVuRkJKVTVCeGFXLy9IUEdzb2R2?=
 =?utf-8?B?SUhjdHlaLzRwZTgvT2JJaHM5NUVldUdSWEEzS3ZyL1REQkdMOGU5ZEM4UlM2?=
 =?utf-8?B?cXF0STdFNlpNQkpMS2hMb09SRWY1amJaeG9IWGFmMWYyaUxQNG5uK0JFUnhE?=
 =?utf-8?B?dDAxWWpNV05PMWhEejRzV1U2S2gxZjNaSkQxODFEWmYzelJ6NnRsc21jVEJB?=
 =?utf-8?B?ZlpkaFU1R3lQclRWYVI0QU01VkY2UUl1SjBFU0ZDYTQ4SEZ0aXJ3YnpQNFE0?=
 =?utf-8?B?azdEUjRTTE9aTnordnJqaXpsK0p4Y0tyc2ZBOVkyYmhwUU9CYnFQdDBVYytR?=
 =?utf-8?B?ekNBRXNEbkFVeVdpODdsMEFuTjkvVnRPMytkSWJsdHZnL0s0YWJpdUhEWVh6?=
 =?utf-8?B?ZEIzNWovd2xYNHh5akNlbThCclVNZGxUWDFIZ2Zuc0JtT0JuUnh6UmNhbWdm?=
 =?utf-8?B?YXpuaU9RWU5odmtXcjFueXlqR3B1ZDBDaEQ1Wi85SDZuazFzY2Q5d1JOYVdB?=
 =?utf-8?B?NUNxY1BLR1hKdXlkNml2OTR3SkhrNlF6SUFubmg0eXlkRWhLV252S2RPNjNP?=
 =?utf-8?Q?nxu+SH0nARpLxVZY=3D?=
X-Exchange-RoutingPolicyChecked: Ci31pGUV01eEg0DoMk5qBnCS/xIGwfnwJ+Z2wol6B2/zVdemnVzdod62sONjk16/12u80s5J0gfSc0g0tMXHSvF/4qtluvdiIXxyLGKQ31pDABTwynCvqPrXMl/GxoGPMx936RxqaPdcOTw/KefZzvlBrOD36iBbaGW7KwNzKkxHKyrBTpxycBgaG5vTA8AsHuHP/561SmJPsrEyf+xrZx2GQnP9CUCz9ilmiAP0wq86FxtopAIJt4YhME+FARRE9rIFlgsdAprTm4ADrfYrGiYb9CB7v06/2AVgVnjxrzxfN1ZUdBnQeKAjTE9/QEneya8Bnj0hjIPYJoRhkN/xQg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d1321f-15be-40f3-c013-08deaac0a4d5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:09:11.1750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uo0i2JXZArGyTrd7SQRwNmxRiOIZRM74urLn8mEkkmubH1c38sEcfRlC+eL1z8qTJVEaQNMXOtFNUDs+8ZDHuDLWzCPODWAMO57jPl30Tr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9829
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: A95BB4D1136
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284501-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Date: Mon,  4 May 2026 18:21:32 +0000

> Switch to the generic power management and remove the usage of legacy
> (pci_driver) hooks.
> 
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
>  drivers/net/ethernet/google/gve/gve_main.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
Thanks,
Olek

