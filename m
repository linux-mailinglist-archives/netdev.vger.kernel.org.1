Return-Path: <netdev+bounces-304015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MTvZLTMVRmoUJgsAu9opvQ
	(envelope-from <netdev+bounces-304015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 09:37:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C396F442B
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 09:37:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="LsD/SWDY";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304015-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304015-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93FD33014360
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 07:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55886395D86;
	Thu,  2 Jul 2026 07:35:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C31395AC0
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 07:35:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782977754; cv=fail; b=hVl2RlFKMatiqHZ1ZsnO8JdiEobXcuXpnrG+duUilnMBt5z9mPLgxphB8qK+d+vkzChG445BggiG+vVZNuh8ED1yFYG1sTPJEllU1MOAax8rt0WlsCJf+pO47akhMtB3BVETbUk6CdZe9GN9Qj4cqD1FxKP6ydqQ3yBGh2Gf+6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782977754; c=relaxed/simple;
	bh=WGr1MZggNagXalnNwMWuQX6drXUtceoBLvFpJKFDkRk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JlPEDcJk8pKCWbGWL9+cb7YZQPoE4V44kkVipe0F1mvJ5KoTyBTJF056/HweyP2m2XzmryMPp/bUP+lom40449UKX/Cx7BakstuYknx2uVYYP+OGK+8nNnuRKuMxsM8M7bodyZlX72jEAnk1dxweDTWYrfJqDh144mg/nxW8vQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LsD/SWDY; arc=fail smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782977749; x=1814513749;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WGr1MZggNagXalnNwMWuQX6drXUtceoBLvFpJKFDkRk=;
  b=LsD/SWDYIEKCN+FtJ9IAYnrn8b1NZozCSilSqoY08XHOUMieHLhExcy/
   GJZVX/AQiZ+pGIRAbXkoNfkAY93v0al8Bw34tvJZ99nsRyy8LqeE05GkU
   iKK2wUCKqjXJ4wJN0I8Rw8nLzycGFmyd70JVn6DOoiG8yyTNDgmJ+KfzG
   NMD8vjiGtHNUrLZ3JWqk7Qh/+GlS5/54ZcabOcNnugonLNAuonlBMfdFU
   bV8dS4rl6EjnZeiHBIFxOULn+f7vAaxADPo0zFB3F42iBl9o7NCWLwEPt
   gdnTxU1Mv9iHhE9PnNfkbstFM8dwiY0Dpa7jjSHP1Iow4ifJCzoREaLSf
   w==;
X-CSE-ConnectionGUID: glS/cViGQAOUkM0E/JM8mQ==
X-CSE-MsgGUID: /SZwmamdTdqAi896ZOzp5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="109267717"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="109267717"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 00:35:46 -0700
X-CSE-ConnectionGUID: DPXXP6ekTC+4wYLUXYZ8tA==
X-CSE-MsgGUID: EB26jeVBSqulfWtg8Kwnlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="275991925"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 00:35:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 00:35:46 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 2 Jul 2026 00:35:46 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 00:35:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CP0stGYfxjcpmODhAE12JX/pWElz43OJTgYx0M/2wTLUcppz8Gt2qqlezbxA6QeujjZlFu9zAq/WtbcoaEH8mrfvXt2cPM5PhtRBYeHnqhqh2HuRR8EbO3gtldTPs09vfdLo97BHmJQnjOMGkfmeI9UMhV7aE6kKfzNMhdFEKCDsysqEN3gIpkDNaaxDGna35oNAkKpuE2h1ZBIJACoz/ZPIId50xnS5CKxQAsUvfx7KII1d+j948zuPiioF0bHa0CcctEKqiuSODDG3ePqnONpink8Mkwsh1bP44JNi8GNRA1V714iNgQj9KgV/Ncw5RFrNHN3ey5jXDkFND7ZP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDYeCe4GDUkGDUw0KOvOjtvWg0nljlvohW1+v4i1Eig=;
 b=EJWjSQlFoXTWDgqG4MfqanGs1A9luVK36ceJlMyGgrH2/KLMrS88DqCyvROuA1gLKeyARsiNgBOku1QNo6L/pOvH5SCR/JCpHoaw/q3vVY2TWadyJISwsQsARaYt/nTkv6cL1Em432VNTlwlP6iYfe4M57J2zdx2msPUnuXv6piAsebgPoqbgcaYcms/1mohOGCb5dkeh4NzVQ87f7B3usiE17Lc2yo5ljwKw7dluLxxZQ1qmMbparH6wzkyaMXybeWARa2g3wq29q1BzneJoR/t0YVdm2MLhy9T7do4Mu+UmylSAaUPiJa4WpAib23RKgV8Cz4HOo4z/cGSd75L3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by LV3PR11MB8602.namprd11.prod.outlook.com (2603:10b6:408:1b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 07:35:43 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 07:35:42 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Harsha M <h.mahadeva@chelsio.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "bharat@chelsio.com" <bharat@chelsio.com>
Subject: RE: [PATCH net v2] cxgb4: flower: fix 802.1ad VLAN TPID matching in
 tc flower filters
Thread-Topic: [PATCH net v2] cxgb4: flower: fix 802.1ad VLAN TPID matching in
 tc flower filters
Thread-Index: AQHdCd8x74rAaxoDeEefmBSaTLdjRbZZ1t7A
Date: Thu, 2 Jul 2026 07:35:42 +0000
Message-ID: <PH0PR11MB590242E0F82125E42DB3F820F0F52@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260702044955.20119-1-h.mahadeva@chelsio.com>
In-Reply-To: <20260702044955.20119-1-h.mahadeva@chelsio.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|LV3PR11MB8602:EE_
x-ms-office365-filtering-correlation-id: 2769ccab-1a21-46a5-5ad3-08ded80c85c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|38070700021|56012099006|11063799006|6133799003|22082099003;
x-microsoft-antispam-message-info: YVSuNnBQeHTpTyxIZbmIHp6WToxm3dt7PENcfVNjvcztwjUySkDVHsgGTwvvvQCvd0FTUkMhi7GS3I/5hxltf8pmSC1qXzAIjHX+ZcqIk6PgavnXhRk5xeSMYP2NEnjLx+24QdmZiN7wWHm0kjOYMhw1nmXJpHdNOy0vDUa6+eDXg65Uw3s4tYJAHEiHDadvGxNN1x1iAwmsiRVoBlewMjdmhfhvYl4UxM9nGKeajU/wVjsvnj5I+dhx2XY1OLpJTeWMVITVAF8jhzwM9XMMWELliK5Nc0MJPgHQVVHOjGNS3PYyOtcgSdRsdnvj3hcCaTetznjzj1CYV0+vlPo/yZxU186Kn6O0GVTrLmrkz08rF0MQkD5gGKbkL1CqVK8h8Rn97pqqsWrz9wy9xC8Xa7w3hzZhOV4eG8NRSdeR/9dk/Ddd1nZcGutyrrLzbCUnZf4+78RKX+w/Db8hm6jkwRvNGhNfzxmQS95/W5JpQgMxCIsl5cpwKTkr0EfCPEcb2UGLDsHZdOTrJ8FEFAugugQ3KM0zh3wHusAcqBkCJijGG0R1oo886weXo8pymqxJ0NuwmBalomSnmu2k7i4paOzKo/UKsTWn5CvF83wY++MfaFMHuMKuc6Mhz2fEAEA7lYtwzY60yabl/ZG8TCtnQxDQ9ApufoMT/Uu6dDU75A2VeAhZaBeKXjGlZeB0pZwh4hAPEoVgsntsIcz8S4ps+jIYl0tja9fgB5kbTnJE9JA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(38070700021)(56012099006)(11063799006)(6133799003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mlETX1hFxbQxvqMOO6xZoVYfEFdiYADZ1GyDUPWC1OWOVBLHsoGs7hNeEWYM?=
 =?us-ascii?Q?R1kOVqMBc8asShXTkOI4cbelNXb9eLmpt6+PRi2iadvWAyYZ5fSW/kt3IBFe?=
 =?us-ascii?Q?T906ixqo4lJTURL5vQ2WnKePSqY6lY8HVmZtKV0m2ompx6CR6qrBDnif3UGa?=
 =?us-ascii?Q?H5GX6JBXm5CW2fVZ7Mv2vcCYSzW0HMtwTYES8V58r/6hdtDpMBRghKefN7h3?=
 =?us-ascii?Q?SZvztxObXVw7rSN7fNKgbVKqEWHT4F3glwf+fvWjictYYettc8VgX/6NFP/3?=
 =?us-ascii?Q?a/NdNM48jFhMmI2JGViQwKrxUWcKHSjwI5hvVYTDeL5frzQJxqicsjntmT2/?=
 =?us-ascii?Q?ss8zu8Mj+RHtDbhsFGeO1KCozAwgWik/CZdP3kF/EYOTHW9GpWH0IhR7QrPM?=
 =?us-ascii?Q?wnfdDzkve3owQ1W2v/Cx1WljjPvjnrDUu3jK/oIcfRxbHLYUjXfAbujsf3kv?=
 =?us-ascii?Q?u15x1z1JAskbT8umDK51sPSNdB5RmmxYzGJhjMVF4DIHFDcuOQm6DjT9+Q0D?=
 =?us-ascii?Q?hu/GEA+5dwzgJmzN4D8yXSmSZiYAtjJqfVuyeCUGIWbkJ4boViwPKIrJguT4?=
 =?us-ascii?Q?tDX623NC9au5nPyDOFOaA/Wto3oLzIiSaA4VujtXmZ12vV1da8V3AU3TZQXj?=
 =?us-ascii?Q?F3UWHzJlLkx46jLQmAN9I9Xfa1lwWAofkL4G72GJIUY34aoeIH3o7ECtdiBU?=
 =?us-ascii?Q?xU4MXmjRuUh77M8DFb12ShQM4aC2kXtsgaT+5CyubQR0Q0lHUEgrO4tfLBGf?=
 =?us-ascii?Q?+L15eAoNvBSMUpI+8TFFOdOiWdrQsdh5M4cYKRrCkXaXuTXr0ySAblW9fC2h?=
 =?us-ascii?Q?02Jch2+JJGIdZpL2w1L4r1YLuotWYk4MWLvPm0TK46Zpu2hJdXPL+cUAUtYB?=
 =?us-ascii?Q?+lVScd3ODwqvh4MaF9iS83TV9k08xjtZ6RkFjKZFQLDEKKHVBYfBTwUtW3Rx?=
 =?us-ascii?Q?U6grgYvMzlIb4HxXNMqbeuPyTrFci15wDmikfH+Mm857uAx0LhbGmPJ6eF36?=
 =?us-ascii?Q?fd4u91Kek3MvL9tvn4baQ2DgEN5t9+DzW48K1ob6EvEmZnqqlV+slVVlO4VK?=
 =?us-ascii?Q?im7QXD8VtBAuNFf6WXZ3F3mXATAjPtH7a2txRjIAJrQ8o+81elEdHuPXl12I?=
 =?us-ascii?Q?iDIUqDpmYQzLGdbASVDNDLyq3RBZKNn5DhmkV6AX3w/6S3AzC4Hwbv9/22sY?=
 =?us-ascii?Q?R+efPnkX6X2wIie2Ipt3Eq/UT8ZAbjoHaHbcsNX0iEs6CD1rJGGGPxp93j0c?=
 =?us-ascii?Q?bmcHtPL4LZYUQWOIUU+3V6BklNAwNogvA2/ZbQTNsXZgJD6Ut7qQUOWQuKvb?=
 =?us-ascii?Q?T0BjDCtqXWeXzibFaOWx76lls14ku0xuRwmS3Xtftx2pfcReYJ5VDb1+xnm6?=
 =?us-ascii?Q?yMJyA7CYPSTXxvvilwtlw5+Hx3XnSH4nQqyh6gD0ID2Rr4nocKXRjt9wo1gg?=
 =?us-ascii?Q?rrNb3SJmSlV8NWnCXI3bvertu6RxJalHnnryXY9VDtJYZ64p6lfm6MRTDiMv?=
 =?us-ascii?Q?XQwKs/gjWR7vz+hxVdf4W4719EL/flWLR+0NrduMyVTZ79ycMs/aPcM3tifd?=
 =?us-ascii?Q?jV+g9vSDbDv7/C9+j6ONIr1UZgYjxlucef4yDIUYASueBe4ykCKOJmBCWVet?=
 =?us-ascii?Q?yyA2pAuuYyQlG0W9ceWKQieK4MIeJK+fH4qWFQjgCPmwZ5Ccrdu/kMAi4PrI?=
 =?us-ascii?Q?2tT3Z16PO1k2fBHwz/fnj5y4i8vdiJ+7fbC93Xh3TAbPV8ySBwCxkTvJXPIC?=
 =?us-ascii?Q?D8sdxkrg9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nFDJM3d8vo0Sj+9a7kQQVDIrrSqI7uymUejv/NjHcxDzriZzPkdCFZn6SYTZxvYl0ci/yzeieBvPjhC5tW6jhRnxLu5fbUTaT5O0w7t2BDCa5tisQFdOOnHU4uWYgfkpgAa9uEdTwmNsSUHac0p2HwscCLRFtEzrRSShifcv4FaLUdFn1URFO6xTzXZzyNBRAyiGy/l9c33vnP8sF6M5hcCSEL0WcqcMW4y1CllagRXffHD49N+bBzqLK1YaqfNywP6Pl0cnzmYQH2BaDyTfPrGVUJNw8WplcxHXCbpsJMmyJwFQZQbhgPK2WZYp1idzWSqxebME+4z7gxa7k+e8Cg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2769ccab-1a21-46a5-5ad3-08ded80c85c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 07:35:42.7931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yOwgGK6jQk+bzMifQVuvTmeiVTx7VAgKs4k8T3QJzDBz6GcSSL3SEZkXuDl7xe3ILl5PR5uRN0vvCL3TC5JVCRye/DrOX/sypB90L+inhWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8602
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304015-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:h.mahadeva@chelsio.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:bharat@chelsio.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim,intel.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4C396F442B

From: Harsha M <h.mahadeva@chelsio.com>=20
Sent: Thursday, July 2, 2026 6:49 AM

>The cxgb4 driver does not correctly handle tc flower filters that
>match on an 802.1ad (Q-in-Q) outer VLAN tag. While the VLAN VID is
>processed, the specified 802.1ad TPID is not programmed into the
>adapter's outer VLAN matching configuration, resulting in incorrect
>filter matches.
>
>Fix this by configuring the port-specific OVLAN register with the
>requested TPID value, enabling OVLAN matching through the RX control
>register, and populating the filter specification with the outer VLAN
>VID and valid-bit match fields when an 802.1ad TPID is requested.This
>restores correct matching for tc flower filters that specify an 802.1ad
>outer VLAN tag
>

Hi

would be nice to have fixes tag

>Signed-off-by: Harsha M <h.mahadeva@chelsio.com>
>Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
>---
>v2:
>- Compare vlan_tpid with 'cpu_to_be16(ETH_P_8021AD)'
>- Program the OVLAN register using the ETH_P_8021AD constant
>  and TPID mask as 0xffff instead of deriving the value from the
>  filter key and mask
>v1:
>https://lore.kernel.org/all/20260629184417.31b21223@kernel.org/
>---
> .../ethernet/chelsio/cxgb4/cxgb4_tc_flower.c  | 61 +++++++++++++------
> drivers/net/ethernet/chelsio/cxgb4/t4_regs.h  |  3 +
> 2 files changed, 46 insertions(+), 18 deletions(-)
>
>diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c b/driver=
s/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
>index 3307e5042681..8c5cfa6982e7 100644
>--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
>+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
>@@ -40,6 +40,7 @@
> #include "cxgb4.h"
> #include "cxgb4_filter.h"
> #include "cxgb4_tc_flower.h"
>+#include "t4_regs.h"
>=20
> #define STATS_CHECK_PERIOD (HZ / 2)
>=20
>@@ -266,24 +267,48 @@ static void cxgb4_process_flow_match(struct net_devi=
ce *dev,
> 					       VLAN_PRIO_SHIFT);
> 		vlan_tci_mask =3D match.mask->vlan_id | (match.mask->vlan_priority <<
> 						     VLAN_PRIO_SHIFT);
>-		fs->val.ivlan =3D vlan_tci;
>-		fs->mask.ivlan =3D vlan_tci_mask;
>-
>-		fs->val.ivlan_vld =3D 1;
>-		fs->mask.ivlan_vld =3D 1;
>-
>-		/* Chelsio adapters use ivlan_vld bit to match vlan packets
>-		 * as 802.1Q. Also, when vlan tag is present in packets,
>-		 * ethtype match is used then to match on ethtype of inner
>-		 * header ie. the header following the vlan header.
>-		 * So, set the ivlan_vld based on ethtype info supplied by
>-		 * TC for vlan packets if its 802.1Q. And then reset the
>-		 * ethtype value else, hw will try to match the supplied
>-		 * ethtype value with ethtype of inner header.
>-		 */
>-		if (fs->val.ethtype =3D=3D ETH_P_8021Q) {
>-			fs->val.ethtype =3D 0;
>-			fs->mask.ethtype =3D 0;
>+
>+		if (match.key->vlan_tpid =3D=3D cpu_to_be16(ETH_P_8021AD)) {
>+			struct adapter *adap =3D netdev2adap(dev);
>+			u32 ovlan_reg, ctl_reg, val, port_id;
>+
>+			if (!adap) {

is such scenario really even possible?

>+				netdev_err(dev, "%s: adap not found\n", __func__);
>+				return;
>+			}
>+
>+			val =3D (0xffff << 16) | ETH_P_8021AD;
>+			port_id =3D netdev2pinfo(dev)->port_id;
>+			fs->val.ovlan =3D vlan_tci;
>+			fs->mask.ovlan =3D vlan_tci_mask;
>+			fs->val.ovlan_vld =3D 1;
>+			fs->mask.ovlan_vld =3D 1;
>+			ovlan_reg =3D PORT_REG(port_id, MPS_PORT_RX_OVLAN0_A);
>+			ctl_reg =3D PORT_REG(port_id, MPS_PORT_RX_CTL_A);
>+			t4_write_reg(adap, ovlan_reg, val);
>+			val =3D t4_read_reg(adap, ctl_reg);
>+			t4_write_reg(adap, ctl_reg, val | 1);
>+			t4_tp_wr_bits_indirect(adap, TP_INGRESS_CONFIG_A, 1U << 9, 0);
>+		} else {
>+			fs->val.ivlan =3D vlan_tci;
>+			fs->mask.ivlan =3D vlan_tci_mask;
>+			fs->val.ivlan_vld =3D 1;
>+			fs->mask.ivlan_vld =3D 1;
>+
>+			/* Chelsio adapters use ivlan_vld bit to match vlan packets
>+			 * as 802.1Q. Also, when vlan tag is present in packets,
>+			 * ethtype match is used then to match on ethtype of inner
>+			 * header ie. the header following the vlan header.
>+			 * So, set the ivlan_vld based on ethtype info supplied by
>+			 * TC for vlan packets if its 802.1Q. And then reset the
>+			 * ethtype value else, hw will try to match the supplied
>+			 * ethtype value with ethtype of inner header.
>+			 */
>+

isn't this already fs->val.ethtype !=3D ETH_P_8021Q branch and fs has not
been modified since entering?

>+			if (fs->val.ethtype =3D=3D ETH_P_8021Q) {
>+				fs->val.ethtype =3D 0;
>+				fs->mask.ethtype =3D 0;
>+			}
> 		}
> 	}
>=20
>diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h b/drivers/net/et=
hernet/chelsio/cxgb4/t4_regs.h
>index 695916ba0405..38c585f3b1ad 100644
>--- a/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h
>+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h
>@@ -1921,6 +1921,9 @@
> #define MAC_PORT_PTP_SUM_LO_A 0x990
> #define MAC_PORT_PTP_SUM_HI_A 0x994
>=20
>+#define MPS_PORT_RX_OVLAN0_A 0x120
>+#define MPS_PORT_RX_CTL_A    0X100
>+
> #define MPS_CMN_CTL_A	0x9000
>=20
> #define COUNTPAUSEMCRX_S    5
>--=20
>2.43.5



