Return-Path: <netdev+bounces-235767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02141C351AB
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 11:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A111F463E99
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 10:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCFA30149E;
	Wed,  5 Nov 2025 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjYRKotq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283F1301007
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338554; cv=fail; b=H0X4XJbNZGF3RwyVxzaBi9FES5FoCJ1b1Keq/wLchILaz7AdaueSItgMQ5xJt2qHxJ199zKBESJbSz6l9q6V2E5ap/ox9WMmu7ukKq7bNaHTbEsfomVLbnlSdzSTaeMprO0NfNzu5CbEG2x8Dt91kCf+kMSfFZsu6F9Xkd0HGyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338554; c=relaxed/simple;
	bh=D3HevGbdeHlXSbKorSaZ8lrVU0qQbPXjw5m5m72EZ3A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NHHpn0+vIsnnepQcE5acZb0+LPKd8b1Q6AYyFownU1t+mpwTYnCBHs0KXWgBVOQN4CpsAMJtU5UnWSWkJm0wR+DFwYUEIZzzbNS7odhuNuNP6pTBHN5KvX3vb2+cZ9cnDDmEOqyPsjtI9dtPsRSU4apZVPl7s77QjHnxiOHsK40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjYRKotq; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762338553; x=1793874553;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D3HevGbdeHlXSbKorSaZ8lrVU0qQbPXjw5m5m72EZ3A=;
  b=jjYRKotq6Kr46xbJNToo0WvYO6jnWTjoTR00QqxJiBqRpsBvxG4n3vUm
   X5TZW4/e3r0SMmHNJW/fojTg/7+lixSNeRzmpSqBcyoIhvjVDUMjKgD37
   IsqwM5vhWSU9+2usH5f5zyiuPppnDG8teOQru6D4kDy66+z+cJHxcpJqb
   LH+5ytTpywv3+VFkqVRZQgRgZpee3W7kwh6e56yRF4dyLPoAr3xHE0mBv
   zd+Hys1iM+bYo3qJnOY9Mz422uJyhCLdl51nBHhxqRFURZOmhh11FosYQ
   OYRnGqGDw9q6BL9rlK3B/C+YflzSIojdsfyhBap7zxW2OF/a3O8REl+Bq
   Q==;
X-CSE-ConnectionGUID: FdkQglmbRVOhZr2f31ra4g==
X-CSE-MsgGUID: MUfEvFt5SgOUdl+opUMnNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="67065120"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="67065120"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 02:29:12 -0800
X-CSE-ConnectionGUID: XAUZQqxJSNmpqPoJSvmH5w==
X-CSE-MsgGUID: t0pPS5rsRJ2FV/R3HiXNKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="191775962"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 02:29:12 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 02:29:12 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 02:29:12 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 02:29:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QO0CBvWf8L2Yxzmvy566MBniP+PjXHeHQWUDcd85kW7bJXpQhDztg9F839tCwkqZuFtDwJeCTpDybawJhSJVkuGMcYfjgF9hdVk9+SKLsUlquiZWpQtfc75D8vtkfu68gcDfkbXmSwZ8l3kp1kg6awkoiv7/eIh4OOP7b+KmRaUi8/3qbIaUAXEKEguE72eWMYOjHaOc0vd53Tigbl/F5g+67+sAnSiMdORLBcq1AvLQJPc2HLDwSDQFFSgKpYvCzbNAxbEn/iCEHmg+F8VLupDI6Tx1UFjOSxMtS6dEpeTViv6uc9S6PVGom466k+56oqC8bbR7neJwEv8v3I/c8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3HevGbdeHlXSbKorSaZ8lrVU0qQbPXjw5m5m72EZ3A=;
 b=KBiLMBxnFW1LPUw7ZBwrHy3wVKnYAkvmsNJGhIT253O2HSHpvhKEm/F43smhFvkfyUWDlQBbe1l3kfPtzvZaJ6vEaFJSGkuHolnXUUakki6DRYMvOVZjtA59vYcZpkxK8exDN5CToZMlFMdKst6GRzpTNXp9q+EcRKaogoNkQ53cyRUkHSW3DuLLjPOQK6W/saH/QndpFqAwYHcNqYq2URGJgufJHq4RQJuc8nUBWdrQDFi0PPmej5KJyDcWldqpEVDKPqTad3CxUM4LmjLvG1BXUJLskda7k7mClCIEDFZSo+SNliEiY05kKHbkRYehaj36k7kMx6ogQSZ1C7sW3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV3PR11MB8766.namprd11.prod.outlook.com (2603:10b6:408:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 10:29:08 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 10:29:08 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, ALOK TIWARI
	<alok.a.tiwari@oracle.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "alok.a.tiwarilinux@gmail.com" <alok.a.tiwarilinux@gmail.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [External] : RE: [Intel-wired-lan] [PATCH net-next v2] iavf:
 clarify VLAN add/delete log messages and lower log level
Thread-Topic: [External] : RE: [Intel-wired-lan] [PATCH net-next v2] iavf:
 clarify VLAN add/delete log messages and lower log level
Thread-Index: AQHcTZ0IkgEDbSYX0kmbwdo5tWm1RLTjsEmQgAAIgYCAAArhEIAAEdaAgAALMGA=
Date: Wed, 5 Nov 2025 10:29:08 +0000
Message-ID: <IA3PR11MB8986BCA52B33D7A426C139A7E5C5A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251104150849.532195-1-alok.a.tiwari@oracle.com>
 <IA3PR11MB8986153AC57FBE801247FD50E5C5A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <9e736c4a-bafa-44e6-9152-3a9de078ee4c@oracle.com>
 <IA3PR11MB8986C6192990882A8B0C7C99E5C5A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <a59e78c0-f3fa-43a7-b34c-d7a85291b587@intel.com>
In-Reply-To: <a59e78c0-f3fa-43a7-b34c-d7a85291b587@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV3PR11MB8766:EE_
x-ms-office365-filtering-correlation-id: c031ea9b-d922-4b1a-1124-08de1c562780
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?b3FSc1QrWmJWc3grSERPSjlmdTk4cXFKTnBHWmN6ck9oWElhS0Z0cHdoWmxU?=
 =?utf-8?B?QkpKRnlQTnFDeWI2bWtkQkpEaUxXcUxGbWZPdlVNeUFnQ1dFVHQxTTZtaVJ4?=
 =?utf-8?B?ZkRtdWhSK1BId29rSldPRDIyajFSTm5OcFNQOGhBSjhCbGdQam9CRmpMYS9h?=
 =?utf-8?B?L2JEQjdtMWlTTkdEdlVVRFl0LzBRWXdtVUNQQnIwK1dlTzZ1L1o4MG92QU0y?=
 =?utf-8?B?alZjRGJuNVhIVy9kUFh0ZzVQZzIzM2lyWmJNUmJnSFMrZHh2YU95Z1RkOEx2?=
 =?utf-8?B?UjdQU2JEQ2tTck1MTVA3UnNsYmhrOFZzNS8yZGJVemw4YWc2Y2tKOXdiSmFJ?=
 =?utf-8?B?T1BwOWlnMWVneThPWUNLSWtBL2lpV25iTHROb2l2c3VjQUhyK3dreVdKWTNI?=
 =?utf-8?B?Nzl0QVpoZEczanlaMVlsbE9CaGViajJIVzUwZWNWTVNDNHZub0ZxeU0yMVQ4?=
 =?utf-8?B?cUQwWk52RjdCNWorZGlFdVJlbWpmc0dOWFlMb2RTbW9ITzFNWnhtWEN2SnpG?=
 =?utf-8?B?MnZGZWFKc0E1OVMyM1ErdmV1N2NxRHJ4UFlGeEhibzdIRkhHQkx5c1Vwek5T?=
 =?utf-8?B?bzdMUWM2blF3Qk5EUkZCanNENW52dGlOcXFxNHREZWs3NUZ2cEZqU0NLR0JH?=
 =?utf-8?B?dERndzBnRk5UUDZlaWo3UGErZDhXWUF6RVR4bDExNTBJcjhKZGpNVkRRTlhP?=
 =?utf-8?B?Z0RZcWRwcDJwY2Z6MlNrdlhzeVp6TVpwVXE0ZzF4Y00va1FmRXpIcW9lVlQx?=
 =?utf-8?B?TncyZTY5YTRXM2VjYWRPTmFlZTBWbEhOYUUwSCtMRC96VDRQaUFJL0ZCNjl6?=
 =?utf-8?B?ZHB6Z3JLSWw4OU5QVlFOaVp3MUNGbGllZHNrdWdXZGNJTjNDdGdzWnBDWThP?=
 =?utf-8?B?TWFjR2M4OHMzVkVhbEt3TmVQMXNMUjZZYTV1Qk5pMGI3VlBYbmV4WUdXNTIx?=
 =?utf-8?B?U2hHUlZJZ3Y0cVJ5OGFoUU9vNlhJQmdpNGFXM3lwQXl1amFmZzlLcTkvWlF3?=
 =?utf-8?B?dlg3M0ZDYzJwMndkZWRMQjBOVjhQd0dXbjVrT20raUpqVFMyc3B6bVlNOUhu?=
 =?utf-8?B?S2trbEp0U1pjV2lkMlFGK0Z4Z0xzSkREcEpHaXFSOXN1bSt1WXNVNUpIYmtt?=
 =?utf-8?B?aXEvbU5TL292N2ovVUVEeGNRaHJncE5ucCtqT1JnbkhuK1ZUM2RLSE1LMU1x?=
 =?utf-8?B?M0d3TmJpc0JRSlRvN0FvSkE1ejQ0M0FPU0pKdFdVY3IxRGp1MG1EOXo5aWE4?=
 =?utf-8?B?WDRIYWo5ZTJFc2xiSEZhbjB2NyswN3JwQzNQV25rRm9kNzZwU2ZaTmVhVDdh?=
 =?utf-8?B?MlljNURJdlVnNGY5ZzZJZWVwQUtGQUUzNXpYeWo3bnFFdEd2OEJHaDFmL0RU?=
 =?utf-8?B?c1ZQbitVTkYyVWo0cXJyYkd1UVVnd1AxRzNaRDdMdCtKT1BhTVBqdFdqYTFR?=
 =?utf-8?B?VkxwcFcrYUxlNXcvek9YSHpCTVhGTThoN0NDbWVjcS9YZURlM25pRTdML1Fa?=
 =?utf-8?B?N0pKV0x0SllEMjZJL2w0OU56emh2RW9ZcGRxaEsrQ1VZWC9CWjB0V0hrSUZB?=
 =?utf-8?B?VVJFTWUzNnZsTjgxNXIvaUYvbHM0RVl6Rm9UUTV0VGs2MThkQXZBTlVqVVNo?=
 =?utf-8?B?b2ZjMmQ4amxVTHFkR0lMcGlBNmFZTHNIS0xpY2FkZ1poa3ZIaGJUTFNnSTlj?=
 =?utf-8?B?SHZWMEVPL0pyM1lpR3VjZ1Y0MnVrTWRxOXBvZm5yU21nTWZxT0dXY3lUMmw5?=
 =?utf-8?B?U3dFT1Rqays4bjU5Unl0RkMvbEpJcVFKZ1hzaXZ1RWVFVVpVNkp4NHhSMTNC?=
 =?utf-8?B?bm5mYzVYbTZHY2FFeENpdTllSkxzdG1ibGlvdCthYTVXOE8welF4NHlINWQz?=
 =?utf-8?B?NzA2Q2VNeG9wbXlmcXkzaGZublkzKzF4LzlqNzgvcUlCZ0tESmRsc0xnM0x0?=
 =?utf-8?B?YThFZGlGWjJvbyt3NEhPVjJ0R3Uyb0R1aHBiWEN5K3VlYmcrd0EzalVwWTBs?=
 =?utf-8?B?eDlOVWdGWTFoWS90NE9PeVNoRjJhYW1yNlcwbG1IQSt5QnkrUkRqU0dwMHFC?=
 =?utf-8?Q?jx1KbF?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUJSS0pWcFNkb04xZEgzZVVHY3hvY2g0NjhrMFFmS0pUN1c0VlNSdDJIZEhz?=
 =?utf-8?B?elAvTXlhUnZudjJsS3NuSG5vWVpJUjUyN0ROemg0K0V3UUdvNXZTNGFGdkJS?=
 =?utf-8?B?aGtJWU5lYjZ0OEZYVW4vK2t5S05pUkIvWFZjKzFpMVZtMWI2ZS9jVTUrczdB?=
 =?utf-8?B?RTMvenR2RFNNTnVveVZzM3FyWWFiNXVMeDcybWdVNUxEQXN4RGxMbzcrRmc0?=
 =?utf-8?B?VzZiYlBOVzZuQm1tYjdTOStDWS84RHpTUnRaRXNwaGVmWEtXbTlQSGwrN28r?=
 =?utf-8?B?c3NqWmMxUE8xWCtVZFFNM3ZiQVR5QmhQZ0JsSVgzdjVrYzJiNWRMWGJ5cytP?=
 =?utf-8?B?MlRTVWRFWkt3a2RNOEFyY3lOc2tLQXNNY2NSWUtjU21STnFOZFh2N2VwOEUz?=
 =?utf-8?B?SEx1aVZzWWZ2Tjdqb2ZiU01ucWxHdlh5OU5vZFp2YUp3Yk9DMHQ0eEVZNmRL?=
 =?utf-8?B?WG9EcE1CN0gwWW5DaTN3R29TRzBtSVRaVENDMXI0WVRjWmxNVGtRclcyejds?=
 =?utf-8?B?djNUSUZ5SG53SUZseGp5cjAxRUxVWGlzU01JbjRCbFl0MGxNWVJCRmY4SXNE?=
 =?utf-8?B?MDFOa3JnNXdIVksxNlJWWWg3Rm1Sb2lHN0RRN0NJMWMxSlVEUzc2L0JNVzZx?=
 =?utf-8?B?bWwvYW1xeUk3NDNSQ3JoVHBuTGxONCszZFlKNzdHN0QyRjU2MnZoYm1tWTRR?=
 =?utf-8?B?UEc2MnRFNHNNV3RDY3cxbGFKY2dFa0VpVHpPYmQzZ1lpUzZjSzBYWlp5a0dT?=
 =?utf-8?B?RnhtWG41Z1Y3UG5YOFhHREhQcDF6ZGN3bVhuUkQwNC82V0hJNkVPeXhWZjBq?=
 =?utf-8?B?S3hFRjZuRXNRZ2R3YUVkV0IzL1pPOTRvNWVUZzladGtlMFhTNnM4ZWFPZk1l?=
 =?utf-8?B?Q2YrVDJVR2RZSTZKellsM25RTXdMZjNveWtBKzAxZHlUdWtjalBWalFXNk5G?=
 =?utf-8?B?S2FiaFlHQVFmY2J6VENFVmxVQUgyNStTR1NaREkzbjA2ZE8rdUJJYnVIN2pD?=
 =?utf-8?B?cFpieFBxNDQrcWNpeXBsbE12Nm5EaDUwZ2JNaXlQZXlyQkI3azJ6NUtyZXlk?=
 =?utf-8?B?dEJCeXU2eWcvU1lLK0NhZVB1OEoybUxTRG02VjZmT3FvTmRETUJmK01paHc0?=
 =?utf-8?B?SSs1QWM5YnBZWDdpQ09FTFJXcUZueDIrMUMxR2loNG9vMktHV05DYU9FMWFB?=
 =?utf-8?B?NlUrWlU5TThLTE1mK1RZM1JMbkptVXhoMGtEUlRpY0lYTC9ETHZRcGxQUUs0?=
 =?utf-8?B?WDlhSSttZ09IYmVYcjNwWXNLajl2ZHN5VnVwMXdKYXcwLzh5YzNocCtHNjRx?=
 =?utf-8?B?dkgzYWpNcmhBNjRhbkZkMXNGeDFRbVNHeE1UazhHMVBtMXlOZkloMTVRbUdC?=
 =?utf-8?B?RGx1b0lUbytnQUdhejB3L3FNN2pJNHk2cURmbWtpbExuV2lDaG1HVGZVY2lr?=
 =?utf-8?B?OGlBYUxZT2tGWFBUa3JkSHFHOEdvUEJVRmxRU2lFL3FhNFkrZ1k1RnV4RFl5?=
 =?utf-8?B?d1JZU0FyeE14ZEJISXJQbFdjeVl5ZTdhN1ZYMUQ0WWZUejJJbCtGTUE0MFRu?=
 =?utf-8?B?c3lOZHh2U0VYaGN1bHVEb0dMZE9ySERrbnFPeCtjdnRVR082b2VLSmJVRW9E?=
 =?utf-8?B?Wnk4cGc4cklSL0JrZUJKU3Uvek8vMkFESmg3Q3MwYmNVL3gyaFpZMjZqN0hO?=
 =?utf-8?B?aGcrMk4vbXIyY2hvVUxrWHRsalY0WFpiQlF2WWsrdUFwUkNBZS9YaDFVcjBE?=
 =?utf-8?B?MGRQWmEzZGtSQUZuYndjRkNXaHR6TEEwbDRKUHNZQ1JRL0w5TklhMmg3WmZk?=
 =?utf-8?B?NzlKR0JzZXdwdGxORG5oODl5STF5QkltWkVDcHFJcVp1VFJGUzJCMUFmK1Z3?=
 =?utf-8?B?UWpwelpXWUFIMHAxOGtJN0lDNUI1cmlxSXdHRlpaUUx0MjR1TGZCLy9uc21C?=
 =?utf-8?B?OXZyYUNhcFdDRWxOdFFGdjBYaUVhcUZEWkEwMnFrZGFRbUoxbkl6NWFoamg0?=
 =?utf-8?B?clRwNGxFY1dyNXpwekZoRERpLzdEdjBYeFFEVndZWFU0bWYvZkMxZnl4a1ls?=
 =?utf-8?B?MVY0OFdKUkZWem1SbjVPdmlkdzl3TGZlaW0zcnltTWFqMUZQbjZIMmZERVJ4?=
 =?utf-8?B?ejBhYnQ3M0ZWbldsRnlpMHhZUnFiWGRZNFhNVmZEb3hYY1NkQlhVZVpndDhZ?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c031ea9b-d922-4b1a-1124-08de1c562780
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 10:29:08.8413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /VfgYVxHd82DbTRRuWLtH+Wuux/jV6QeuH9NQUncjMdENYhr436fY1EA0IZXdOlSAuMOeKcJPtaRkdRVoVGEqOYmyzHFLERnzJ/NU09unsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8766
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2l0c3plbCwgUHJ6ZW15
c2xhdyA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBO
b3ZlbWJlciA1LCAyMDI1IDEwOjQyIEFNDQo+IFRvOiBMb2t0aW9ub3YsIEFsZWtzYW5kciA8YWxl
a3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+OyBBTE9LIFRJV0FSSQ0KPiA8YWxvay5hLnRpd2Fy
aUBvcmFjbGUuY29tPjsgTmd1eWVuLCBBbnRob255IEwNCj4gPGFudGhvbnkubC5uZ3V5ZW5AaW50
ZWwuY29tPg0KPiBDYzogYWxvay5hLnRpd2FyaWxpbnV4QGdtYWlsLmNvbTsgTG9iYWtpbiwgQWxl
a3NhbmRlcg0KPiA8YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNvbT47IGFuZHJldytuZXRkZXZA
bHVubi5jaDsNCj4ga3ViYUBrZXJuZWwub3JnOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpl
dEBnb29nbGUuY29tOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgaG9ybXNAa2VybmVsLm9yZzsgaW50
ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcN
Cj4gU3ViamVjdDogUmU6IFtFeHRlcm5hbF0gOiBSRTogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENI
IG5ldC1uZXh0IHYyXQ0KPiBpYXZmOiBjbGFyaWZ5IFZMQU4gYWRkL2RlbGV0ZSBsb2cgbWVzc2Fn
ZXMgYW5kIGxvd2VyIGxvZyBsZXZlbA0KPiANCj4gDQo+ID4+Pj4gLSBSZXBocmFzZSB0aGUgbWVz
c2FnZSB0bzogIlt2dmZsfHZ2ZmxfdjJdIFRvbyBtYW55IFZMQU4NCj4gPj4gW2FkZHxkZWxldGVd
DQo+ID4+Pj4gICAgIHJlcXVlc3RzOyBzcGxpdHRpbmcgaW50byBtdWx0aXBsZSBtZXNzYWdlcyB0
byBQRiIuDQo+ID4+Pj4NCj4gPj4+PiBTdWdnZXN0ZWQtYnk6IFByemVtZWsgS2l0c3plbDxwcnpl
bXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0KPiA+Pj4+IFNpZ25lZC1vZmYtYnk6IEFsb2sgVGl3
YXJpPGFsb2suYS50aXdhcmlAb3JhY2xlLmNvbT4NCj4gPj4+PiBSZXZpZXdlZC1ieTogUHJ6ZW1l
ayBLaXRzemVsPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+DQo+ID4+Pj4gLS0tDQo+ID4+
Pj4gdjEgLT4gdjINCj4gPj4+PiByZW1vdmUgIlxuIiBiL3cgbWVzc2FnZQ0KPiA+Pj4+IGFkZGVk
IHZ2ZmwgYW5kIHZ2ZmxfdjIgcHJlZml4DQo+ID4+PiBXaHkgdnZmbCBhbmQgdnZmbF92MiBwcmVm
aXg/IEZvciBtZSAndmlydGNobmw6JyAgJ3ZpcnRjaG5sIHYyOicNCj4gPj4gbG9va3MgbW9yZSBj
bGVhci4NCj4gPj4+IENhbiB5b3UgZXhwbGFpbj8NCj4gPj4NCj4gPj4gSSBhbSB0cnlpbmcgdG8g
Zm9sbG93IHRoZSBjb2RlIHBhdGgsIGFzIHZ2ZmwgcmVmZXJzIHRvIHRoZSB2aXJ0Y2hubA0KPiA+
PiBWTEFOIGZpbHRlciBsaXN0LiBJdOKAmXMganVzdCBhIHdheSB0byBzZWdyZWdhdGUgdGhlIGxv
Z2ljIGJldHdlZW4NCj4gdGhlDQo+ID4+IGlmL2Vsc2UgY29uZGl0aW9ucy4NCj4gPj4gRWl0aGVy
ICd2aXJ0Y2hubDonIG9yICd2aXJ0Y2hubCB2MjonIGFsc28gc291bmQgZ29vZCB0byBtZS4NCj4g
Pj4NCj4gPj4gSGFwcHkgdG8gZ28gd2l0aCB3aGljaGV2ZXIgeW91IHByZWZlci4NCj4gPj4NCj4g
PiBUaGVyZSBpcyBvbmx5IHNpbmdsZSBtZW50aW9uIG9mIHZ2ZmwgcmVjZW50bHkgKGp1c3QgNHll
YXJzKSBhbmQgb25seQ0KPiBpbiBpYXZmIGRyaXZlci4NCj4gPiB2aXJ0Y2hubCBleGlzdCBmb3Ig
ZGVjYWRlIG9yIHNvOg0KPiA+DQo+ID4gbGludXgvZHJpdmVycy9uZXQkIGdyZXAgLXJuIHZ2Zmwg
fCB3YyAtbA0KPiA+IDQzDQo+ID4gbGludXgvZHJpdmVycy9uZXQkIGdyZXAgLXJuIHZpcnRjaG5s
IHwgd2MgLWwNCj4gPiAxMjQwDQo+ID4NCj4gPiBQbGVhc2UgdXNlIG1vcmUgY29tbW9uIGhpc3Rv
cmljYWwgcHJlZml4Lg0KPiA+DQo+ID4gVGhhbmsgeW91DQo+IGJ1dCBrZWVwIGluIG1pbmQgdGhh
dCAidmlydGNobmwgdjIiIGlzIGEgY29tcGxldGVseSBkaWZmZXJlbnQgdGhpbmcNCj4gaW50cm9k
dWNlZCBieSBpZHBmDQo+IA0KPiBoZXJlIHdlIGFyZSByZWFsbHkgdGFsa2luZyBhYm91dCBtb3Jl
IGFuZCBtb3JlIHN1YnRsZSB0aGluZ3MgSSB3b3VsZA0KPiBqdXN0IHNheToNCj4gVG9vIG1hbnkg
VkxBTiBhZGQgKHYxKSByZXF1ZXN0czsgc3BsaXR0aW5nIGludG8gbXVsdGlwbGUgbWVzc2FnZXMg
dG8NCj4gUEYgYW5kIHNpbWlsYXIgZm9yIG90aGVyIGNhc2VzDQo+IA0KPiBJIGhvcGUgdGhhdCB0
aGlzIHdpbGwgbWFrZSBldmVyeW9uZSBoYXBweSAoZmVlbCBmcmVlIHRvIGtlZXAgbXkgdGFncykN
Cg0KWWVzIFByemVtZWssIHlvdSBwb2ludGVkIGEgcHJvYmxlbSwgaGVyZSB2aXJ0Y2hubF92MiBk
b2VzIG5vdCBmaXQgKGJlY2F1c2UgaXQncyBkaWZmZXJlbnQgdGhpbmcgZnJvbSBpZHBmKS4NCkJ1
dCBhbnl3YXkgaXQncyBiZXR0ZXIgdG8gaGF2ZSB2aXJ0bGNobmw6IHByZWZpeCB0byBwcmVzZXJ2
ZSBjb25zaXN0ZW5jeS4NClNvLCBJIGNvcnJlY3QgbXkgb3BpbmlvbiwgYW5kIGFkdmlzZToNCg0K
VXNlIHZpcnRjaG5sOiBhcyB0aGUgZG1lc2cgcHJlZml4IGluIGlhdmYNCiAgLSBSYXRpb25hbGU6
IGlhdmYgc3BlYWtzIHZpcnRjaG5sIHYxOyDigJx2dmZs4oCdIGlzIGFuIGludGVybmFsIGRldGFp
bA0KICAgIChWTEFOIGZpbHRlciBsaXN0KSB0aGF04oCZcyBub3QgYSBzdGFibGUgY3Jvc3PigJFk
cml2ZXIgY29uY2VwdCBhbmQNCiAgICB3aWxsIG5vdCBtZWFuIG11Y2ggdG8gbW9zdCByZWFkZXJz
Lg0KICAgIHZpcnRjaG5sOiBpcyB0aGUgZGXigJFmYWN0bywgbG9uZ+KAkXN0YW5kaW5nIHRhZyBh
Y3Jvc3MgZHJpdmVycyBhbmQgcmV2aWV3cy4NCiAgLSBEbyBub3QgcHJlZml4IHdpdGggdmlydGNo
bmwgdjI6IGluIGlhdmYuIOKAnHZpcnRjaG5sIHYy4oCdIGlzIHRoZSBJRFBGIHdvcmxkOw0KICAg
IHVzaW5nIGl0IGluIGlhdmYgd2lsbCBjb25mdXNlIGZvbGtzIGFuZCBncmVwIHJlc3VsdHMuDQoN
CkkgcHJvcG9zZToNCiJ2aXJ0Y2hubDogVG9vIG1hbnkgVkxBTiBhZGQgKHYxKSByZXF1ZXN0czsg
c3BsaXR0aW5nIGludG8gbXVsdGlwbGUgbWVzc2FnZXMgdG8gUEYiDQoidmlydGNobmw6IFRvbyBt
YW55IFZMQU4gZGVsZXRlICh2MSkgcmVxdWVzdHM7IHNwbGl0dGluZyBpbnRvIG11bHRpcGxlIG1l
c3NhZ2VzIHRvIFBGIg0KaS5lOg0KICAtIFB1dCDigJwodjEp4oCdIGluIHRoZSBzZW50ZW5jZSAo
bm90IHRoZSBwcmVmaXgpIHRvIGRpc2FtYmlndWF0ZSBmcm9tIElEUEYvdmlydGNobmwgdjIuDQog
IC0gS2VlcCDigJxQRuKAnSAocGh5c2ljYWwgZnVuY3Rpb24pIGluIHRoZSB0ZXh04oCUd2VsbOKA
kWtub3duIHRlcm0gdG8gaWF2ZiB1c2VycyBhbmQgbmV0ZGV2IHJldmlld2Vycy4NCiAgLSBBdm9p
ZCDigJx2dmZs4oCdL+KAnHZ2ZmxfdjLigJ0gaW4gdXNlcuKAkWZhY2luZyBsb2dzOyBpdOKAmXMg
YW4gaW50ZXJuYWwgaWRlbnRpZmllciwgbm90IGEgdXNlcuKAkXZpc2libGUgcHJvdG9jb2wuDQog
IC0gS2VlcCB2aXJ0Y2hubDogcHJlZml4IGZvciBhbGwgdmlydGNobmwgcHJvdG9jb2zigJFyZWxh
dGVkIGxvZ3MgaW4gaWF2ZiAobmVnb3RpYXRpb24sIGNhcGFiaWxpdGllcywgbWVzc2FnZSBiYXRj
aGluZywgZXRjLikuDQoNCldpdGggdGhlIGJlc3QgcmVnYXJkcw0KQWxleA0KDQo=

