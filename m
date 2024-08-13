Return-Path: <netdev+bounces-118244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CA4951058
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 01:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7122F2834AA
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 23:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF681A0AE0;
	Tue, 13 Aug 2024 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TYm2v0fd";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0TfH9/zi"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD38B153BF6;
	Tue, 13 Aug 2024 23:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590933; cv=fail; b=vAeMj/e5TBDqGhRULACM5TOC7lKXIhpfqd0zKG9dr+yE2/oQ2woUDUjPGDC5zigA9mvPr0SsV33TXpYYnCrbJoEl6/Hq34bMxkoomJlSTfzxNz50MJcU4+JINF54csRX68inMy5JrytcHuZc1ee7YDsj76tfZjDUZdSuCyo5v3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590933; c=relaxed/simple;
	bh=ojDaqsnO7LvK6AD0zcQb1+aZSLO1QC/2jvWWMOC/eog=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=riQWzRlHUf9zQ0+w2tBXZ+XHWparMA5e6IKN/ch/tw+YjGCCfYwm10FGXS1Us1pLG6lPe2WNzju+qfULCy/5lMY2bKxGyxrO4VI7JfZHhtIn56eXGUzWz6wWiaTKqrwJB42PPa2RO6HELyZeRNjcfx85MoQUh6kjri357qVKfRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TYm2v0fd; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0TfH9/zi; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723590932; x=1755126932;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ojDaqsnO7LvK6AD0zcQb1+aZSLO1QC/2jvWWMOC/eog=;
  b=TYm2v0fdL6tpGldy4kwfi7dR1z4NBBIi7T5aElncRO6hkket3b/01c7O
   ymsIkFD9VHgzYCiaaPa/KFH6ow1L2mZR12Tgdh5vHG9V0Hochup4QmYCr
   iiMtEXYxmxJAYEdhNUrko8NB1gel05/jkJaLBPRwXhT037Q86qyAWR7PB
   Sb85uWZyFe3Wjer4pUeEcX9rXChsUjjUTJ7Y495ZireFSXhn0MvTWnm/O
   r0EBDKmzWp9rcEzah3aeXrbGfw8RoaUF5IND1M4s3L3KgsgGemB2p9KeY
   jq+XYdc50ZodzqMahaUPF81dAUOMLMeYd4iGo0zH8oF5PIi0kpiK+vUip
   g==;
X-CSE-ConnectionGUID: T7e6xKG6Sca0RzVP9MhHhw==
X-CSE-MsgGUID: XZCTIZoTQLWRrAPZPDBjLA==
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="30463090"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2024 16:15:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Aug 2024 16:14:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Aug 2024 16:14:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f52d8Fv0nVd9KkDIqtVlgCaexzjkCWbGLc4veAvLGgNYoeeQF1L/kgfD483SB1veqRDBWyhiIoCJbpAAaCmQ5i52Qn0/EZUOVz+0Fwb6iSSTpx0CwIVIXYJdrJJW5vwgf9d/Q5jQMsClZ40gSSBBanDyk7kSJxAbXrhLEitYg4qG8AWWzyz77vCtcek4kwyZHRXyaPNUGzJlrnjAmfdmfshUpRZt9JbJf54DaRwgWCrnc95t1XsfGgbvhav7D5H0/wxfQKHLiZn+wmXlD//bijUbPNGnhGPwosrVOM7/3PHiIopuOZGzXjh/xuhlNYW6Wfp5d92r6uUIi0OMfssxRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojDaqsnO7LvK6AD0zcQb1+aZSLO1QC/2jvWWMOC/eog=;
 b=X+jRLksQL1k8liPBkhEm7bAUeRrzhWASJAHJPhuncdWcJhdqd/FM+yIkatxQlhMLj51XddQ+QdsQ40YnA1rVb1pH+s/yNgA7BE5f/J1qoW+lDZXD8LK4aYiOCVvrZHejH4/bhh3RpfWUcLMCG7+yzsJ401lljHfrff0VzLtkagpfOgLPBI6k1xAE9x8GUjg8gJsyPcMBK2Z9JJwhFIAm4t9RbQvkthSyITWjStCsNcMXXNpno+Q6ixuPOpYwf1l/7+ZlbLHiMwemV5zPKDI7IC3M7PTQkOW8WM3HLAseM+EV/z3CSzzTrwHawBt4/iDjBZqudalhgLGP8h89yK8yWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojDaqsnO7LvK6AD0zcQb1+aZSLO1QC/2jvWWMOC/eog=;
 b=0TfH9/ziJsHGs0wLERBy+KSa+FIfXbTP5G5P3Ue4lG7S5/w7KD55s4+HEscHssuIFmRJR39ZQEqRJr50JTyj+3y1It04v9EOicAcPuNKLVfnYUCRtzjIV1c2yTZ/BxWcVYf45jRh0ciFLaQnq4vkxCRzR727gQA6JeFHSz3A+F8d0OW6Hu6PvsHkenuVHUEOFPf/Y4cbowLBOgFgl+ipL9bVrRUIRpKfHGvf3l7GUZeFwyXVu7E2GJ+jnYNWIN8ajWwfl123Kis3ne1v4v2f9VseuybPyM+rQo0xZwA2PkqIIvP2hym3dSfMdT9tfWFKv0NyViebY41ewh08mN1CBw==
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by MN2PR11MB4680.namprd11.prod.outlook.com (2603:10b6:208:26d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29; Tue, 13 Aug
 2024 23:14:49 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6%7]) with mapi id 15.20.7828.023; Tue, 13 Aug 2024
 23:14:49 +0000
From: <Tristram.Ha@microchip.com>
To: <krzk@kernel.org>, <robh@kernel.org>
CC: <o.rempel@pengutronix.de>, <davem@davemloft.net>, <olteanv@gmail.com>,
	<f.fainelli@gmail.com>, <andrew@lunn.ch>, <devicetree@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Woojung.Huh@microchip.com>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <marex@denx.de>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 1/2] dt-bindings: net: dsa: microchip: Add
 KSZ8895/KSZ8864 switch support
Thread-Topic: [PATCH net-next v3 1/2] dt-bindings: net: dsa: microchip: Add
 KSZ8895/KSZ8864 switch support
Thread-Index: AQHa6qIxh+siJpmuGEuKW9dXlMMvabIgYi6AgAV0pBA=
Date: Tue, 13 Aug 2024 23:14:49 +0000
Message-ID: <BYAPR11MB3558AFA61335D75C0E1D7CB6EC862@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <20240809212142.3575-1-Tristram.Ha@microchip.com>
 <20240809212142.3575-2-Tristram.Ha@microchip.com>
 <221d19e0-41de-4522-95fa-1adf9024b0e0@kernel.org>
In-Reply-To: <221d19e0-41de-4522-95fa-1adf9024b0e0@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|MN2PR11MB4680:EE_
x-ms-office365-filtering-correlation-id: 6500f710-3740-4d2e-be4b-08dcbbedbaff
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QWpSWHJNSVd3MUNlTWFacUxoTnh5K1Q0NmZIN3ZNQWVJcFkvczViT2tPak1I?=
 =?utf-8?B?UVNpZE9PNXFwQ1NVOFJScUdsZ1RSY1F4S1dkY1YwNGJXZy9LQVRoTXY3bHRT?=
 =?utf-8?B?ZlN2dHhBTVF3cHVUMXpvWGFNN1pIU3lzanljd09OWnJQVUtkYzcyQjJGV29Z?=
 =?utf-8?B?SXp6VmtLcHBXamVNWXUxdnBMZTdzUzI3cmZUL3BSTmxhZzlYcFBSVFE0SUEw?=
 =?utf-8?B?ZGpOb1hQaU5haFdxTzQ2Ti9NaCtWcUhBMExqdnRhckttUFgweXU3MWsvTXMy?=
 =?utf-8?B?RFgzWlpPUEtJS1hwaWVkU2p3RW4yVitiUXhaQ1VwVW9lMnBUekV5RVJoU2ta?=
 =?utf-8?B?dDF3MFpWUjg4SW5ZUTN5VVpJaTQzQ3BvTnlXVi9MVWFqaFU2ZEFUa1B5Yjll?=
 =?utf-8?B?WW9MMWhaMVdsUkNZQUd1UG42bU8zcTk2ZHRQNmV6bXJPMk02ZHR0VzBRUjha?=
 =?utf-8?B?bmRmWi91SVZXbklPNlJCRWRqK25GdEtXUUdBMTlxd0ZKalliQ1lqeU0rR3hu?=
 =?utf-8?B?eDNKU05IbzJQV3Q5cXJDS3krNE00ancwZ3dsRUZpV005MDc0YUpReVNMSFha?=
 =?utf-8?B?L3lEdGFINjVTdm9sb1pSQ2thb04zRmRhSjc2L1liWjB5UzRvZ1J0bjJES2xH?=
 =?utf-8?B?dVR1Y3IvZndYek9sQy9Zeit4eFRpZytjOEpzR1JHNnZoSWhaL0NJNUpDWDU1?=
 =?utf-8?B?MWJlUjREM04zQU9iYnRqc2twOGdUQlFKMmZEclNGTS9aK2pTNGp3bktLa0Jo?=
 =?utf-8?B?QjBUVGVvbzZHeXJrbE5xT0d5OTY2QXdTV3dkdjdCS2x0MFFBNzVmSlBaTjJh?=
 =?utf-8?B?dEQxeWtvcTNaRVlNL0ZhUmpNRG0rZ0cvbzh1VEUzV3hITzViL0RwS0FEc2o1?=
 =?utf-8?B?M2JEMDV1UlpzTDR6YlJvdXk2RGtmbmlnZkRBSE9DSHZQVCs3dFFyd1NERXJJ?=
 =?utf-8?B?VFU4M0kvTXQyZ0ZuWk92clB1UlhJQW1wNmFqQzdEYVdMNlh1aHdIaFdTVWl4?=
 =?utf-8?B?QVdvRWNyRW9BdzRlQ01vd0M3QnJyNnNuYVNRTk1SYkYwTEJtdzZPdGtNTTNl?=
 =?utf-8?B?SDlnV3VPUk5ndDZVV3ZEY2ZDSU1TRlBHK1JzcDJRK01jTWh6MElDclJTZTJH?=
 =?utf-8?B?V1BUVzhkd3ZmSFl2K2k4OXZRcm9mSjEzR2F2Q29DQlpuVnFwaU5QQjBqNjJX?=
 =?utf-8?B?TStxTUJTcGVuQ3hWNkhQL3FYMkhHOW5QQ1N6Y1FyVWl6TGdSVDBSb2RTc3VH?=
 =?utf-8?B?elp4Si9oRGs5Njd1SVE5QXJaT1V1VUZWaGw3VTdXUHNWMFZxOGVBYlRCdUM0?=
 =?utf-8?B?dWdNUHF5YnZ6UGxuYmRHdXZSV1R2K0NxMHBrWkxuNW15UVU1UHUyQ3V6WlIw?=
 =?utf-8?B?cWV4NzVXM1o3bVNsL2FaUVZheUZmN0k4ZXluTjVuckZQcVZmejY5RlRabjNQ?=
 =?utf-8?B?L0pmQ0k1eW16N3dkYXYxRDRocnVQb2dabHY4UFNGZ2xUQTBrcSsxYmVmVUd3?=
 =?utf-8?B?K29jcmNDM1hxaFFrRFpQRktROUR3VDNHSEJIQTR6TVkvTmcxYmxaRUFHTGdr?=
 =?utf-8?B?Slg3cjA5bHpieXJwbEF2SnN2MmtsQTkrMjZkY1U0WHJLUXlUNWh5YnUwNHZn?=
 =?utf-8?B?SUh4UW0yQk9IdzdhNXB2OGMwN2RqUFd5c0d5TmxFNTBxaXB5cGR1ZTQ3V2Q2?=
 =?utf-8?B?RjA4S0ZUdnByQ2NrUFllWGRQVG4ySU8rZks0VTVBOG9lOS9xVXV6WTBuckly?=
 =?utf-8?B?Q2xyTk01V2M1UndDQkZ4TjdBeC9DT0h6ZnFndlBveDJYS2ZPLzk5V2V2VEJT?=
 =?utf-8?B?VTR5K2xGYThRQzlvUGp2cnlXVmhOQ2xYeU1IRU9MQTRuMnpLSWp5dGtSbmlH?=
 =?utf-8?B?aUlQUWFqUmUrZ1RkcytIcnRtamFseml4cWk4U05JV3gvSlE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlZWcVdjS2kvZlQzTE1waGovRVVpL3J5WElIU0IwUGFmYlpBQ1VGeVZIV3ZP?=
 =?utf-8?B?NGFJVWtndVFOUjdERE5UQ0hRa0ZlRXhZUnlEVlkrYllaUXZPdzZTTGtqTktm?=
 =?utf-8?B?cFpNaGozaGtwTTd1N28yYjMyM25BSGlRNUhWQnByc1l2L0RielZNM2VPb0JT?=
 =?utf-8?B?ZGFOaEpoZGFOUE1yaE1paFRmVlkzM2RDcGgzaXA1VlcwYUFHYk5GNERPYnpU?=
 =?utf-8?B?RnBMWEpvZDN2a0xJZFJ2S0hlelJRMXVUbzBKa1JsS05XSHdyeUZvbkRXQXlk?=
 =?utf-8?B?bXk4L3grYmhxUWloQzYrWHdETWFuTUhZdlFlcmNveHpVWDlYcjh3RjhRc25V?=
 =?utf-8?B?cFVOYUg4OG50R0N5bWx5WFZ1MEpLZ2YxSDd4UGEyREh1TzhHeFpDSDUrbFc2?=
 =?utf-8?B?SS8vZkpFMkJmSEdzSHYvbW5DMlQ1OXkvbjJDa1ZQdzBmYWN6WHJsaG1mTnlX?=
 =?utf-8?B?amVOWi94TkI4NmRwTU5XTnpMempDWHN2RWdiNG9uakQvV1E0VlZOREQxL2lT?=
 =?utf-8?B?UmhrVFZYdFRBbHhMejBka050QStadnR2SGNidkwxZ1dxRGhxN05DZWV3S1Ju?=
 =?utf-8?B?ZmRnRDNPNXVhbnJwQloybHZLWVExUXQxcWVJclFmL0VpWnR1OEhPbGRqNWdO?=
 =?utf-8?B?eG4rWGE0RE05eEQvYW1vTWJWbVJLc0hKMERzY0JsVUdzMVpPOEhzUmd4R2p4?=
 =?utf-8?B?VlhkSTNZeFhDSHlWOFFUVWtIdW9hb2xtbHN6dk5JUlRXcUsvbUthc3JqYVRz?=
 =?utf-8?B?TldQTkUyMWZHNWZibThTbUw5SGpVOXZVaUNFRlpITjVRRDVDSUZQRS91OTU1?=
 =?utf-8?B?QlRWRmQ0eUtyLzZmcGIyN2tYNVZFZGRRT3A1QXJqZ3ZMVkVYQWlBTVJWR25O?=
 =?utf-8?B?OERpRHNkbTRtWU9UWU5KS2c5QXhadDNQWmd1MVBzTWNPaWtodXZGZnMwV2Fa?=
 =?utf-8?B?aG1PNHRnaEJ4N2NWZ2JjNDJWaHdqaDJ0ZGtNQnBiM05IVEc0OGxkbG9tNDRE?=
 =?utf-8?B?KzRpUzFJVGNvTHZ3TlA1eTdjUHluYzBVV256RWVaSUowODdSa2hQTlpsN3Q0?=
 =?utf-8?B?RU11VVpDKzJGMm50bEMvbjl6QTNQZllMU3lsZDFSU0tBL0d5dHp5U2ZKeklk?=
 =?utf-8?B?OWc0cTAxOWR1N1FMOHNqNGpPd1MzQi9QOHNsM2hHdHJzVEhxbkEwekJWVW1Y?=
 =?utf-8?B?L3NvYkI4WHV3ZkNqdTJjV2xXR3JBZUpaZ1FmZFh1WFRZb2QrWUNVWEVLVGhp?=
 =?utf-8?B?NHdrRm53WXY4NHdGelpIR1QwbE9GMTh6bzFMaTdFZGxPUHhQSTZDMjNIenht?=
 =?utf-8?B?R3lCZmFUb2RKYlpMK0JyVkI1bTRBc1V5QUJNcEUwY1VvcXJWTDV1YVJSc1Bt?=
 =?utf-8?B?eWFNbTFLb2xlT2EyT3BKZVZaOXNvRnl5RkFQaXdZQ2lsbnBnQ3A0NXk2YkxN?=
 =?utf-8?B?U3d0cWJENnY5ZkREZGsycWZGOVJKWHFaVC9rcVFISUxsazFJRG94aVkrekdn?=
 =?utf-8?B?dVI2bkRzMWZ2b0RkYno0cit1VGx6a01ZSTJqWDg1QzZ5WEROYXY1QjdTUFE1?=
 =?utf-8?B?UEhqQVUvQXAxaitWbi9ROWlUalpnTEJTZDlLK3MzWEJvL0h6NUx3QjF1R2hW?=
 =?utf-8?B?YklSbWlJc0s4UUtPV3grNkN5d043QU1lQkEyeXBEYUVlc3Q3YitJMmpWaS9p?=
 =?utf-8?B?OVJEMTVoWnpSZnNXd29uYlBNOFpkRHVYT1RvckM3NjJaTUNEYXdra2RsdURv?=
 =?utf-8?B?V2lFcXZwdzlGcFYyNWo3YUtrdWNTdDhLenRFLzczSkorVXROWW1Gb0oxMnlC?=
 =?utf-8?B?a3ZQSkZtaUtKbk4vUGNEbDN3WkNZakRmZzM5dDBEWmhVcmcrem1CWXMzT3I5?=
 =?utf-8?B?Q1lDa0lvRHFQVTJkbVdYd1Zxd0MxYlc1MGRYUU9HLzVHeGJIc0poT0xCL294?=
 =?utf-8?B?UEV1eHI3eFNiVXdpY3VZdFlvajJ0eGlFT3N6SGdlY3E0a05xeFh0ZUIxTzNi?=
 =?utf-8?B?MDhUQW5RUGhHK1lzaUFQWnAwank1S1dvLy9tRVBXSDR2QTZuQm9tMklTaThY?=
 =?utf-8?B?WE94a0xVZURSVEVCUTN3U2d0YU1aY1AzdCs4U2pjWFg4UjRHL0JMdlYyOFl1?=
 =?utf-8?Q?LxQ55SbCijEgy84cemacSiEww?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6500f710-3740-4d2e-be4b-08dcbbedbaff
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 23:14:49.8175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N50fEguanhOOqPzONTOWCxAwTBteiRhZE47Tn1gybDItXFNCJ0uf8QTooO42bB5NAaG2asWwgwnoF3Gmws26DrNNUE/QRRYwDePkrYIxjpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4680

PiA+IEZyb206IFRyaXN0cmFtIEhhIDx0cmlzdHJhbS5oYUBtaWNyb2NoaXAuY29tPg0KPiA+DQo+
ID4gS1NaODg5NS9LU1o4ODY0IGlzIGEgc3dpdGNoIGZhbWlseSBkZXZlbG9wZWQgYmVmb3JlIEtT
Wjg3OTUgYW5kIGFmdGVyDQo+ID4gS1NaODg2Mywgc28gaXQgc2hhcmVzIHNvbWUgcmVnaXN0ZXJz
IGFuZCBmdW5jdGlvbnMgaW4gdGhvc2Ugc3dpdGNoZXMuDQo+ID4gS1NaODg5NSBoYXMgNSBwb3J0
cyBhbmQgc28gaXMgbW9yZSBzaW1pbGFyIHRvIEtTWjg3OTUuDQo+ID4NCj4gPiBLU1o4ODY0IGlz
IGEgNC1wb3J0IHZlcnNpb24gb2YgS1NaODg5NS4gIFRoZSBmaXJzdCBwb3J0IGlzIHJlbW92ZWQN
Cj4gPiB3aGlsZSBwb3J0IDUgcmVtYWlucyBhcyBhIGhvc3QgcG9ydC4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFRyaXN0cmFtIEhhIDx0cmlzdHJhbS5oYUBtaWNyb2NoaXAuY29tPg0KPiA+IC0t
LQ0KPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2RzYS9taWNyb2No
aXAsa3N6LnlhbWwgfCAyICsrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykN
Cj4gDQo+IENvbnNpZGVyaW5nIHlvdXIgZWFybGllciBhbmQgbGF0ZXIgc3VibWlzc2lvbnMgd2Vy
ZSBub3QgdGVzdGVkLCB3YXMgdGhpcw0KPiBvbmU/IERpZCB5b3UgdGVzdCBpdCBiZWZvcmUgc2Vu
ZGluZz8NCg0KVGhpcyBvbmUgcGFzc2VkIHRoZSBkdF9iaW5kaW5nX2NoZWNrLg0KDQo=

