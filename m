Return-Path: <netdev+bounces-262587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDsEO1RcpWlc+QUAu9opvQ
	(envelope-from <netdev+bounces-262587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:45:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8588D1D5B96
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 10:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D50DA3008335
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 09:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF085333434;
	Mon,  2 Mar 2026 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJdImrAX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC57430BA1;
	Mon,  2 Mar 2026 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444753; cv=fail; b=MNuiB4qlzy9cclMMfEItb707YB30e368j4g1/SfmG4nysOcytdFy1VIpCr4RiqS5h8F04ykhYkVpcuUKFWWYCMah4fug1DcF9mSSJqty2c422kSh6IctsgrOQqygYOJmvai92v0ru01smiuQHcjEgdnhBJVDHrWshnfkhs2Z4ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444753; c=relaxed/simple;
	bh=8gF4az0ZMT70bR8aA5R4e3kQoB4TDhJrp+QhGFkZeh0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GV5WPBx9K75pja0XdxdbiaJOJn+XNUySsj2Zw+anuogsH3007jxuznwcv0nxs708k1ULdLNnWO5MMjBwNq+GOZadrGHnt9JCMbjEZiUAzS36dfXOSJ31GgvyA/keSXPXa1ENal/px3a8LJe7RQlPKzq4NFI57JKoiqVJMzA9k8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJdImrAX; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772444751; x=1803980751;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8gF4az0ZMT70bR8aA5R4e3kQoB4TDhJrp+QhGFkZeh0=;
  b=IJdImrAXEE7AI2GFbb+DFczz/xbsoaP6wbFAm8587niZgENU0bWZo6XR
   hrEpw73uqk7WoxFPU2411Jv6N7vLfHeRcSUg1IHcV+XcvPATtQ6jezgG3
   ts9V0fNMOIjGXTUFs1Y3kaoycWVeO4IMPNOjallKsb+mR9IaJHNowofe+
   6G5T6Sg3QR/R13pmzeOL0BvP4axRw0QwLGqow7o46rHof86y+2hK2xztt
   5MrqWZMzI+k8ptQ7nXvI1hhF5V6Ty0E5sm6IklDndJO8l/K98Dqgy3pPY
   AbhSQixBdzEp1/xufwPERvS6/Gg3ytzkUJhZtLva/fE38yuzL1iBjvRdh
   Q==;
X-CSE-ConnectionGUID: i2JqfRR2S5CBIcXjWFKtnA==
X-CSE-MsgGUID: wM84S4stQ7egbbSTByIWJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="73356610"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="73356610"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 01:45:50 -0800
X-CSE-ConnectionGUID: vmZixAr/TKyfiRIre8sxGA==
X-CSE-MsgGUID: hHqcHWWQQ0GkJC4yFmtGtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="221754274"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 01:45:50 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 01:45:49 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 2 Mar 2026 01:45:49 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 01:45:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMod5eogduxkOVcml8XAsGeVK3y5VcFmO/gAF94+Pt+QkDI0WySMXiIZTFFh7Liqjx/Plat7sr83Z8VeTJrSJW3u/hlRLLNraNDweYZ309v4L8zhG3F4XMr3Af4mCFRCCAYsIz2CmhuM6/tlX1732eb+LQI62YK9N8gBQzbnHBxIw2Ewd8cCjKRsiB80Jn1v/W0K+XOIFogQtF/ox7geRLOVE7jLDrIG25G2dl72PvMBQZzwaVOOt8rWbQrLqby9mkAxR3Q+DutilQkqDOm7+DcuBPIJkejQNK0bdr0sHEsUbjDQleiFGKiI9KCDkMhwDrmltdXszfqPu27jUgtGkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96NbYimysmyANlBuTkgdPGvbhyf3TBsfUOhW1jY45zg=;
 b=Yqrriktj39JP2O7wIcjNDGVzsLvRWMNnpn/qqN3qIE94ASz8j6lYZaxphJe48GqnX/d6JERKLt3ff/pZAOspptHJGJa9Ehp5fmJfSZaggY5KavSoyp7oTe9UH0XSkvswG6iGGV2erKA68GoN6L6GAyEfg6V536CJEy5IlCapVXMTmEBt6mZGzRBM3WDoaP0lc+2xZhZtRHPsW0QN9Vwy3/ub1CRl2OwPo79OAvMCUVWVV7SQ5G87qTXe4Vaa0/7ShVqOsp3s3GCsxcYlyXdOPDUPUMB1PNT/u7hx69EyIslMkj2vFX7UC8zMLzeMMxeOR22jYauhNGvXitJ9Lda+ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH0PR11MB7469.namprd11.prod.outlook.com (2603:10b6:510:286::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Mon, 2 Mar
 2026 09:45:46 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9632.010; Mon, 2 Mar 2026
 09:45:46 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [Intel-wired-lan] [PATCH net-next v1 1/1] i40e: Add missing
 header
Thread-Topic: [Intel-wired-lan] [PATCH net-next v1 1/1] i40e: Add missing
 header
Thread-Index: AQHcqiOWEm5wFikWMEKfzZ1MCPCZdbWa/k1w
Date: Mon, 2 Mar 2026 09:45:46 +0000
Message-ID: <IA3PR11MB8986BF4BB6AB02FDB0F84658E57EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260302090305.2193349-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260302090305.2193349-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH0PR11MB7469:EE_
x-ms-office365-filtering-correlation-id: 0c871eff-5586-4e18-dae2-08de78407a9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: 9H98jJkVIh89URFSsf52gaWOiQM8PC+WFRESa+A6aA3g0O4bp3qLxnNEuzkwMCouJHUVjKPGDvN7TPIvGt8LmUjnaTvJ2oesi1Zn7uXWWJx8GEpjuVjaqD1hJVyPPoYvrxHPTKzxk2kqVzKeStW2nSDR9laalfQZz+zrNtZ5VDb3wAq28ftb2O06++5PJ5KJhs52EIrEUwKtpqd3YZlwAhFfoPdRWIWRVgvPESa03n2V1XYOjYKtPIfnbe+q1v+4fLdSbkc/RwFd90aGyuwJwh5Vz64+J9hKqdOMRgw4+CrvMZm/UrcHRy6rv86JCQFgtf9+WNUQQGd/bwxJXx8Kjl8eXEvV2nZwJz+lYYp/9toIDv6vxH+fqY+B4AGvJTiWPD0C7oE2a/sQFKeoaVSwFptcvZLPQjukxE67CT9iU1IwSJ+O0FwZO0z3PZIhs+dIa7Af7ai8aKEL+ReOuANCcIK6BX+ID/HTzr3z21Z4hahkNBsez4PZBX21cFEwuOMYBPtZFlHLHbVfG1Soi7No0Ym/rO1CyssiVn1QndzG0B8KOpFqCVprW6QjkuJWB2KZGZ4tcKE979b5wFfchV5roPwNYcQwrQKGAn+13eCSmrYQcsQEY0MpUvwEiR8SEgB8NlwymP1JKxtfi/8NPVLinhMkKonKzZBhjgIacVCsP/pFkUvyKEZC2z2nerx30lxDBXtCf6xQmzGmj87yMozn5cv0yCKZKwz5esXfKSAz+WA9bMc5yMctuWHJOPOoZWEqAYg0jyM1dP4eOlcgA+Yjpmeo2O4L5s3uKaNI5ycJCcs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y2ziUto/8dBq4ObxCfVNsNaP8ZYc+z6ki9NXKxloEugIU31VkxG2ptEo85v3?=
 =?us-ascii?Q?AN0XblxwPa0iSgkCU6sMSMOvXEX53C22ZJDnuUZfYNWNzirs9hIIBPvZ4u8e?=
 =?us-ascii?Q?mRv3rIT5Y+2opXrhijEnv7s29Zs/5OK0n25lvnGICSRJz9/uw6BVAWVGyMYe?=
 =?us-ascii?Q?FyqspkH2bNK3oVBqT/xcTYy/OjQoACw85u8Gt/5txuPIxGTH/I5/QzQd0saF?=
 =?us-ascii?Q?YBLAS3t1vTz8erbjNk/ulM8bDjLMnwSbNxY86kK23hm6KXzDOLG3t0K5UYQV?=
 =?us-ascii?Q?i/p62d8hSQfuFC+jRqeZBRHlyKmxrXglE3p4k39C+82uiSlvbIkLE5qTTT1I?=
 =?us-ascii?Q?ikBuAdTRKHoWKThmYX3GA7SpbaH98/41FYJwymlZkxRswILMvmlg5+6WOC/e?=
 =?us-ascii?Q?UWUzn/e62vSFEdBJ6L0dp/V721Fp8+ztq6bj8KAEUptsnWPWhfMn+6fwMaEF?=
 =?us-ascii?Q?eLU1wuQSUMtfdQBRaDNpVBmRNHeaiQc+wnhGdUQU3BHuxcPBpI+bf6wp5KXU?=
 =?us-ascii?Q?VaEpWBD+ptzCtIaHZX/dpfb7yDQtCcK5HGY+1xrheETboTCpa3db+vQlepOz?=
 =?us-ascii?Q?ErwhMTOFLzruS750MKARlwAMin7MO587DAeNV3HDMBVtdYHVARXTIe/tcPit?=
 =?us-ascii?Q?qU/tjHMGoIAqUlmJzwYnROfWbrpgDYIkO3kDy7cWSmsyswt//CnsVLMTpRmC?=
 =?us-ascii?Q?SA9NLf0it1zqlAHObRHh+2vt9P5opiuexHiLbVZItuqXpfY6G+hg42yZ59sa?=
 =?us-ascii?Q?r75aTDFD0DeiWPUbsNn9eOER7hY4XMk8MjzgqFUpJoVHEBZmcWN6u8+NgxC9?=
 =?us-ascii?Q?4tDsd46nDFAySBI35fh+YidV8e/VsNllPxpzQFdRey0j8CK1DDpO3SMYBo0z?=
 =?us-ascii?Q?BFUFH5FX9oO9PpchfFV4/o7Ea/q068KQkJWWJYhiEtkJi2EunFzPmz0SV6me?=
 =?us-ascii?Q?2SxaE1zwLly7RM3RDUcOKJMbWez4u8qe+zMnwnrmB2izIE6XdFzyfTntTRKj?=
 =?us-ascii?Q?kgXLl9vAWxGs84m1HJ/P2MnABkW98LSJqsTuh73r4LJGvWigLsToSKf3OWA8?=
 =?us-ascii?Q?FnebEJWHkSxRzNiDOwR371FsAvrcIVIfbvDiXRTCdFG6SpVi4pgDjID1wi5n?=
 =?us-ascii?Q?BxT+EnK7bt/x/6+WGgX6QQwCkHLjfkw4P1uklGYWOgBXcvp+X2++2fVRmYCt?=
 =?us-ascii?Q?UB8XAWCLt+Lml6VxrK3mx1y7FDwI+k+oR42pQA7+ojvTBFwCnem6FMyL/62j?=
 =?us-ascii?Q?ebGDjebf1eUlsRMXecxfZH6isP8lB3VAwcwIMe/YlVl7muKIl9Ez0weK0S5c?=
 =?us-ascii?Q?oSAdeF7PdOnuIs2lBTAXYUTeISm8J74sCkW5MwKWprsUSxAWue5IHp0RSWBV?=
 =?us-ascii?Q?/Ybxs9OnKRx/IQJ0+niA0wHQMc1/k3uXdJTHv0JvCUz7ogkZTZ7/c7SjZtsQ?=
 =?us-ascii?Q?kCHDaZdBzOdx3MSO7+nJ1/2V3QOUyD9ymy1VQndHoVCP4V5YRrgJ2PBFI7B1?=
 =?us-ascii?Q?nWFq8w/viCYOMGgqo8Amc6mfyZU96wJ2iOSMyJaVy9Y608y/tlZ/f7mclvw8?=
 =?us-ascii?Q?XuHEsQVFD20dmFQz3686GFyxZvjOnexflgCak6vtA3GnYiGjeZP13rxGgRmo?=
 =?us-ascii?Q?EKCdlK7VosseMTnXKksIXPVhbJwXR/wdMY2dnpeQNwP6BcufWqFJnwkbSVIC?=
 =?us-ascii?Q?pfS7fk8se1jZSBHPdyRHKM2SkuDvMM+FmpBSpMDLddHgYwmbES6mNsA46CY5?=
 =?us-ascii?Q?g3xu8oQ+Bm3Iwj9dKUnQ461+AvHSRiU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c871eff-5586-4e18-dae2-08de78407a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 09:45:46.3281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 30ifEuq9DzJcNDSoZUWow03B4nJWLbQNsXrD/yJTIEZSUmSejfWXhJjXrfZ6VoZ29CvdxfFxwEGnL1MzDMXA/Aoxn2U5ldhfsrsGhDxIFpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7469
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262587-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,osuosl.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8588D1D5B96
X-Rspamd-Action: no action



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Andy Shevchenko
> Sent: Monday, March 2, 2026 10:03 AM
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; intel-wired-
> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>
> Subject: [Intel-wired-lan] [PATCH net-next v1 1/1] i40e: Add missing
> header
>=20
> When cleaning up another header I have met this build error:
>=20
> drivers/net/ethernet/intel/i40e/i40e_hmc.h:105:22: error: implicit
> declaration of function 'upper_32_bits' [-Wimplicit-function-
> declaration]
>   105 |         val1 =3D (u32)(upper_32_bits(pa));
> \
>=20
> This is due to missing header, add it to fix the possible issue.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_hmc.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.h
> b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
> index 480e3a883cc7..967711405919 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_hmc.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.h
> @@ -4,6 +4,8 @@
>  #ifndef _I40E_HMC_H_
>  #define _I40E_HMC_H_
>=20
> +#include <linux/wordpart.h>
> +
>  #include "i40e_alloc.h"
>  #include "i40e_io.h"
>  #include "i40e_register.h"
> --
> 2.50.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

