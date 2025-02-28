Return-Path: <netdev+bounces-170609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DADFFA49447
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62C93B12B1
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 09:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9921E256C61;
	Fri, 28 Feb 2025 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yj5Wh6DQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8B6255E39
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740733263; cv=fail; b=Lng/PQ7CJlRkkvkkfLngUrfjenweflWvIwAx5YHevKgcFJUVH0L0D1hYcdhHHHukhfnH7liWjn+qMBtTwlgZDLptgRzTU14xPb4NiCI2hGdGsv0cQb6ZgXLTZF+FHzuEGKAqoMic9k58nZnYb1UQqBjreSNerg7xUQshhCK3Cds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740733263; c=relaxed/simple;
	bh=VM1a5JkQsI3eVSoKbMWOPJzzeHMt1JvBe+ys/JDX1eI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l3h0pAyzo8qdw95QoJJY1pGqGyXY8zmuVBUA6K323f//niReNqSlWb/TDHjuaVys+H8V/2B/KTqLWnZPNznaVHOVhfYvVZ2TMCwvDogC9nXui0WkhB8RfMzAOk4rRbRpcFxLsZ0Ooj+6Wwq8iwGtrYU30XWcG1Y1IoleFkBA1P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yj5Wh6DQ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740733262; x=1772269262;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VM1a5JkQsI3eVSoKbMWOPJzzeHMt1JvBe+ys/JDX1eI=;
  b=Yj5Wh6DQC07vObFpr3n+B4TLXLyECVfK+w0DL2jU4FTDdulcUdsq0OW/
   OTrw2XV8J8zNUDOiKSWnOsPzUhvVUhZjLUcOHGmjReTrtKIJxoMDrvR9c
   HJLjZ6L+m07KqvwCtN4YTU2YH+J7hdXOn7vilK+8iwyurYer3r9umQrw9
   BGyHxsScmqzzZd3PbKIxZH2U+EFZxYonApm7aZcwfSMVgQ+oVOTtBLGn6
   EAS/E6hHL7Bm8mDVOWJRXrlxydckorNePKYt/uN7YeK2wGpDCjm5pOHV+
   e4xvnntQeNAHUU2wlb9EdlpzoVM49lcm6jloFMy0HqbJLNhzYLqLHFdfL
   Q==;
X-CSE-ConnectionGUID: TuWdVLEwSv+qUd8Ee1/PlA==
X-CSE-MsgGUID: +bcJH5BNS7+z7SQi1dxULA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="40897676"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="40897676"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 01:00:57 -0800
X-CSE-ConnectionGUID: e7UUHg2JR7Gw1+d53EbvAA==
X-CSE-MsgGUID: +GJU1EFgQn+J4sUgFsiGIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="117048657"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2025 01:00:58 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 28 Feb 2025 01:00:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 01:00:57 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 01:00:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqicxtQAkWoiGiHqV+r4K/Kuf6NcX9f2pSVX9vpn9DIi/CW5kZBtX4tnjOonP+6gSNcNXugqtgIVRgWmKMF8t6CF50kUTdS3H2XyN9yKwxdMPk5Tk4exLrQ8s9hUEPwhoib53UVWzuV4BCLf31RjWl0m0COxqlJjVqPA6n2IQ5AFFORm8ZtfKDh1X5biuiKOXeI8stUZYKRzBJfg0NJX3heCkrcjk1xaIj1bU64qwEuJpl4STb2qfUU/Rly8i+5qmV/umPmhITSOYmmmB5ZjC0x/wiJ1jm97Gg/dJBjvPhuowNNHTg8CxewYtlsUuw9yzKDta6W4pKF9cw444vH3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VM1a5JkQsI3eVSoKbMWOPJzzeHMt1JvBe+ys/JDX1eI=;
 b=swzDibk2F7w80W2fr762rpkwMtEtcmiK6Ckivd+HpxbSB2uaPmZYo2H0gYUiALy62jI9ppC+AOixeOXYdtSAZvldOSkUpJIALvloT25xi+UNZgF7+Fa+lggzgxIGpqo8HdsgyXd8i02/lbpGWimr6Ukv7fxdFkkerUjtLacmGaP4U3TFAP/ujvPQWWCJQawZAl/LWtFt3+wVfgj+8hP4VY55zgAXqDjjkcULOjWOTsCaq+f2W3xM5NhEo/U61w8nmlxFLjt7ArZWQh5xpQCanveWaankRN/Z6UCcef0n1suqiZqeT7sXjrXn76YiKcTUnCLvqsP2gRe1zo+sLGFoZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by DS0PR11MB7191.namprd11.prod.outlook.com (2603:10b6:8:139::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 09:00:40 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae%6]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 09:00:40 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, "Damato, Joe" <jdamato@fastly.com>, Gerhard Engleder
	<gerhard@engleder-embedded.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 3/4] igb: Add support for
 persistent NAPI config
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 3/4] igb: Add support for
 persistent NAPI config
Thread-Index: AQHbgS+TPif4S1pqHE+PeOHJK5k+DLNceRsg
Date: Fri, 28 Feb 2025 09:00:40 +0000
Message-ID: <IA1PR11MB6241B773BF4CDC93C36DC9408BCC2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250217-igb_irq-v2-0-4cb502049ac2@linutronix.de>
 <20250217-igb_irq-v2-3-4cb502049ac2@linutronix.de>
In-Reply-To: <20250217-igb_irq-v2-3-4cb502049ac2@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|DS0PR11MB7191:EE_
x-ms-office365-filtering-correlation-id: 29912860-3235-4ba4-5b41-08dd57d65ffe
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VDY5L1prZ0Q2T3ZtMktCeS91YlFPc0ZoUHJTL3JxQURWcTFoeFVZWWRUMlJN?=
 =?utf-8?B?cVlFQlkrRFppcVI0d2dnWGdoempLOTJRcjM4R3JNN1BQTWRTamJLQXFtSnJV?=
 =?utf-8?B?N0dyNE5sVGtmMXQ3NHY4RVp0THJIRE4xNFZONFdjZTNYVk9EUkNZV0hHNGVo?=
 =?utf-8?B?ZVhPYURwZ05PUjh4TnBTeWxSNlNkVkRzMVhTZGpJQ0Z3UzkvL2dITldWeWpz?=
 =?utf-8?B?KzFiOUtZV09ZL240eXo4amJoNEVJR0dtQnY3Yk5QTFpHY1VxdXB1MmJ0STVw?=
 =?utf-8?B?RjJEY0E4eHM0ZEl6Z21MSWNYQWxacEcrNCtndGRrUFFJaGE3eDFTUFcrL1I3?=
 =?utf-8?B?aEF5Q1BXQ3VVNnlIZEFYVVFWY2s5bk1GYTJLVTlQTStuYnY2YmlTUWFLU3Vn?=
 =?utf-8?B?ODN4UmpzSEErS0dCQzZ5T2NkRTlJOHNGakFMZkRYYmMrNm8rWFhZcEhmRnR1?=
 =?utf-8?B?M2RJN1NtK3MyaE1UZlBpZXJ3eVNTYUdNaHF0dHRSeEdYNEJ2cHdSc0JJRVl0?=
 =?utf-8?B?ZmdQVFh0MXRzM3laSVlJc09QTzZqQitIVFFxenRMWlAwcm9MdGdlQUJkZEFP?=
 =?utf-8?B?SGh2TVhodTBhZjQ1cWFxMHBxSWgxMWRIMUMyTStLT2ZvYnlwNE5Ja0J3ZWd3?=
 =?utf-8?B?SERoMWVkMjd0a2dZVnVxM3FyTU9ZYlNMM0FzRzZmMCs2bnk0cTZoQnBheWVu?=
 =?utf-8?B?NTJ1YWt3ODNENmFqcFZheDNDOHIrTmNDZHRYdVhIMTM4NU9KZjZEMGZHZm5D?=
 =?utf-8?B?d2czYUdmOG1tY3B0L3RYdUlod3gvYjZ6eVB1TzdvUUJPSEMyNTVHanhza09H?=
 =?utf-8?B?S1E3UHNmYk4zQjE0elVSNVBrVDd5cEVhUVVkL0RkNFhmRk1vNkhYVGpnemlz?=
 =?utf-8?B?SThTdVBBTzk3NUdGYWJZRWRzOHhEY0hmalp6anVjWEZjMFNoYVExaG50MTl1?=
 =?utf-8?B?U0dtczhPcE1wNStPYmJYTjNYbHpZNzRRQkpESXlUYVlFTFU5cHlKQVRJbGxW?=
 =?utf-8?B?K2dDSUtPQlZOT3g1OTg1dStqQUtZdXhwQU9tb2NmVWlpQklSakU0aGlOQlIv?=
 =?utf-8?B?QU1MemJqRjNDNldGVzRlR3psQ1gyVjkydFh5dVhPeW1lRXRNdHVHOVF2NnhM?=
 =?utf-8?B?aHRTc3dQMEQyUFFVeXNkbUhwUVdtRU5hQkdlcFBBU2FFcjBmb3NTTlgrRDlL?=
 =?utf-8?B?WmZpY1h0ZG1EYkl5TjVvUzE3WWt1UFdVaUpYaldDQ2FqcVNoNndLOHQ0am9M?=
 =?utf-8?B?L0h6NVNKSGhoK1dWZ0hYK2RHc3p4WFExLy9oaXAvODFKTklKNER0UTlHTjVV?=
 =?utf-8?B?ajhMSkN4VFlScWYwTkVNUnM2SUtuQ0V0eDQraHlHcUlGcVo4OUh1N2dOM05h?=
 =?utf-8?B?UUI2a0hNcVJ3UTdabTl2ZmNwTnFiWk1YeVpFb2JYRjJVSVd2ZG1ST2Jyc1c1?=
 =?utf-8?B?QnNIbi9tT3ViOUhtQkQza09oKzZkNFFnblhpNFZtSldNZXJZcnVld2ZObGI0?=
 =?utf-8?B?ODRoZFJ0dEZSUlp2UzBudXozdWFYaDQ0Z3VLUkFId2Zmd2I2b2ticktJNmJY?=
 =?utf-8?B?THFyYnI1NmxQNGRqUytyRHArVzNmaEdyQzJqMGFGYUNpcmJ6Ujl5K05qV0g3?=
 =?utf-8?B?Y0djVWJCWTFveUd3K2JyUFpZbDdmaS85cmFBSDA3VmVtQ1FSQ3JMV2dTU3Ry?=
 =?utf-8?B?eldSRWdJeWU1ZngyUTIvcmlSZG11aFRxWThtNnZXZ2MwWlNKaEJta242SmZ3?=
 =?utf-8?B?eGtlcWFMdzAzdStTTi9vMklUUkVHZ3J2ZFlJMnNpTkl6d3l0RnF4NGE5WUNI?=
 =?utf-8?B?RExxRWZ5bDNqVjA0aUZWSWZCeDQrejhmcllpclhPSFlEMG9JbkJjQlhlUSty?=
 =?utf-8?B?bEtTOGorV1RHRk03am95bDh1Y0E0Wkd4NlI4SkpON1kvNE85RnQ0Y2tSTW5K?=
 =?utf-8?Q?SJh3TmFO/Z3yrEupN8SvULkuzUDwBOUA?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEI5L3pHdEpXTC9xcC9pd1VOYVJrNDJHT2VrQTNOWS9LcWlOblQvUkcrMG9C?=
 =?utf-8?B?L3lRcWV6a3lWbU1CZjlSeHNpRjllV2tZVkNHeWY4aVBUUGZSb1hBZUpucXpB?=
 =?utf-8?B?L3R2LyszdGdXSEZISFFJaXg1S0J1eEd6Vlk4L2RUdFBubmt6OG03NGFaSnR4?=
 =?utf-8?B?cGJIOFRJdUE3SkdhRUFremM4cmhjeUFmQXl2NmFSem9JN0lkOThncExrQTVW?=
 =?utf-8?B?dkdWTWthRE1uZEt6dE1oekhmUHh2dXprMkRaZUdZVEtITlJBREdRS3IxMFZm?=
 =?utf-8?B?WENpZXJuSUdUQnB6cVBmY1YrR2dvSnVBQ2NUT1RhU2JQRHdUN2Q2L0RCODNL?=
 =?utf-8?B?WTJ4TDJ3TUprdmhJV2dtWkozeVNpS1h5aE5DKzBPbGFSTG1JZW54eWF3N05a?=
 =?utf-8?B?Z0xLd1VmaHM4MG5QWitOZTY0azNHRm0vU3R0MmZ1NTBTcUFyb3BTdUx4WFhp?=
 =?utf-8?B?bzIyRU14OFArSnd6MVc3VlkxdGdtd1p0L2N4b3hQZ2V2UVA2b3AyOVFFMW1w?=
 =?utf-8?B?bzVGbG5Ebk9xaUtNcTR4ZzdhZy9wLzVvc093cFV3bFNLMGVVcXA5WnRWY1Br?=
 =?utf-8?B?Nlg0VFdVVGxPa0Vsall2UCtLVUVIMW1MeXZRLzY2ZXRoelZXTEpqYmxmdGFM?=
 =?utf-8?B?RUMzL1pJWXVJUElqZTg5NTlENE9qZGVZRkVDeWRYRHRXYUNmdTVkTUJQQytP?=
 =?utf-8?B?L1Vob25rTHNJVENLM2pvTmZuUkwybHZDVDZoams4NXYybzRKZ0J1VXk2ZGFW?=
 =?utf-8?B?RVREL3RtMitHeUlwMlVZMU1FMDBvUWFCK1ZlSGViRlVZcGU2YXc0R0hxREIw?=
 =?utf-8?B?c1oxYkgwRy9uQlN6UGpHT2h4WHNIRkZmeEs2K1NTSWRKb0JhYjV1ZDJxMERL?=
 =?utf-8?B?aVY4N2RaR2E4YnFucUdlakxxbGExM3lhMEFuQXV0UEZMZ09sRW5tVURlZHlU?=
 =?utf-8?B?bU41aEUvTjZVOXRINksxWFdjNlgrdTZUN1FFcUtDTEV3RUpQbEppZkVkRU55?=
 =?utf-8?B?V09jY2hjaUFmRW8wRy9IM08wempERE9QSTg4a29TR0JUaDBCYmI0NUxUTVcx?=
 =?utf-8?B?TFU1VW1acWFxczRPR3pJMTExUzFBUjlPMFQyNTZEbytmREcrZ05vczBxbUtm?=
 =?utf-8?B?ZERxVUdPN1BaeFpqaFJaNnRqcEdzQXN5L2dJWDBvdTZqZ1gzdlVzeDFUV3Iy?=
 =?utf-8?B?QkNtcmZaempzMkxQMklPcnRoMmlKekQ1eUl2bnkreXFkWVNsMk5PL2pZNndp?=
 =?utf-8?B?MFk3cFhlRjg3TXZjcjA3UU8zK2JEeEZjOFp5MVBNOU1nM0dGSHVBeGN6Zm5P?=
 =?utf-8?B?TmRKQnZjM2tCQ0I0Qm9uQXUrR09aaEl6SVZZbEhtcUsvUHM0Mk5KektsdUo2?=
 =?utf-8?B?dWJJYUVLeFJ6SEl6aXNhRWl5OW9GdHRtS29lS1phWmxsRkk5WVFLajRYblRD?=
 =?utf-8?B?eWkxMHg2MGZ4Yk1uNWZCNTlnTmtiaDE5QlpORmh5NDR1c01PZm5ZRUdRR0t3?=
 =?utf-8?B?Uk1QcW01QktIU1c3TkhiTWw2bE4rQklyTTdudjcvTlZiY2k5Vm93N25Ydmt2?=
 =?utf-8?B?RW5tQ3ZQWld2VjAvWEhhVnNNam9OdldhcUtLc2NlRDZSMitSRWZsdHppcXFu?=
 =?utf-8?B?MnB5VmN4OVdkdlFqa1JRYVZzVTJoNVZtSEVmbnJkdjB1LzZKVkFoZ1I0ZHdl?=
 =?utf-8?B?dWlpeE9RNnp3a3FSTU9mUnB5UDhvUFJlL0luZmcvNzV1ZHJoZW0wWXFoVzB2?=
 =?utf-8?B?TzhnbWtlM2lHcW0zTklWWHdzNXU2ZXR4eUZ0RGgrSG5CZmFvQ21OaXp6NWdo?=
 =?utf-8?B?NmcyUUhqemlVazJma0pMdDdSZ2ZUeWFnbXMxQWIwMmtiOUNLbWN2bjg2U3o1?=
 =?utf-8?B?UHpXT2VWOG1yV1Bad0VMeU5oYzU2YWZ5UmZrUzRmUmNWVUh2UGs0N0xnVjBq?=
 =?utf-8?B?dG5zQVRBWDFrNDhqbXZqdEdVTVZDcGI1eEh2cXA5b2lhSEdMVEVZUDJrTzhK?=
 =?utf-8?B?dk1sNi8vYnZtTTBpTDFWellqS2RNelBMZndEV3A0ZmRyeWVOTE8xOGVBYlcw?=
 =?utf-8?B?UU05ZWNtR2VSTE9UNDQwQ004anBZNkRjSTQ2bmttL2VQZllZemtGNnlCQjJi?=
 =?utf-8?Q?AjGWl+kqrzmLgGMEqjKlV1b76?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29912860-3235-4ba4-5b41-08dd57d65ffe
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 09:00:40.1194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8wfMDIth6zeDVmQMf8FCpGFnyjxvJLh/8OUa1croTI6xSGmKy8uXs6uiLHG/9UruQiR6y1gBHPr5TdiiVD272A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7191
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBLdXJ0IEthbnpl
bmJhY2gNCj4gU2VudDogMTcgRmVicnVhcnkgMjAyNSAxNzowMQ0KPiBUbzogTmd1eWVuLCBBbnRo
b255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS2l0c3plbCwgUHJ6ZW15c2xhdyA8
cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT4NCj4gQ2M6IEFuZHJldyBMdW5uIDxhbmRyZXcr
bmV0ZGV2QGx1bm4uY2g+OyBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBF
cmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBr
ZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgU2ViYXN0aWFuIEFu
ZHJ6ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPjsgRGFtYXRvLCBKb2UgPGpkYW1h
dG9AZmFzdGx5LmNvbT47IEdlcmhhcmQgRW5nbGVkZXIgPGdlcmhhcmRAZW5nbGVkZXItZW1iZWRk
ZWQuY29tPjsgaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7IG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmc7IEt1cnQgS2FuemVuYmFjaCA8a3VydEBsaW51dHJvbml4LmRlPg0KPiBTdWJqZWN0
OiBbSW50ZWwtd2lyZWQtbGFuXSBbUEFUQ0ggaXdsLW5leHQgdjIgMy80XSBpZ2I6IEFkZCBzdXBw
b3J0IGZvciBwZXJzaXN0ZW50IE5BUEkgY29uZmlnDQo+DQo+IFVzZSBuZXRpZl9uYXBpX2FkZF9j
b25maWcoKSB0byBhc3NpZ24gcGVyc2lzdGVudCBwZXItTkFQSSBjb25maWcuDQo+IA0KPiBUaGlz
IGlzIHVzZWZ1bCBmb3IgcHJlc2VydmluZyBOQVBJIHNldHRpbmdzIHdoZW4gY2hhbmdpbmcgcXVl
dWUgY291bnRzIG9yIGZvciB1c2VyIHNwYWNlIHByb2dyYW1zIHVzaW5nIFNPX0lOQ09NSU5HX05B
UElfSUQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEt1cnQgS2FuemVuYmFjaCA8a3VydEBsaW51dHJv
bml4LmRlPg0KPiAtLS0NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdiL2lnYl9tYWlu
LmMgfCAzICsrLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+DQoNClRlc3RlZC1ieTogUmluaXRoYSBTIDxzeC5yaW5pdGhhQGludGVsLmNvbT4gKEEg
Q29udGluZ2VudCB3b3JrZXIgYXQgSW50ZWwpDQoNCg==

