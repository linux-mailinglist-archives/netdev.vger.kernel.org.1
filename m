Return-Path: <netdev+bounces-298571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z3KjBADZK2o1GQQAu9opvQ
	(envelope-from <netdev+bounces-298571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:01:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACF46788B8
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:01:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=XVuPreGT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298571-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298571-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 129973001FFD
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2743655D8;
	Fri, 12 Jun 2026 10:01:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071421DF748
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 10:01:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781258486; cv=fail; b=HeDIoyNXYdSAoLL2qAQo9d2tJi4zzDLclYD0SfdBGECFSW/VFPymWdx7/Z0jdsHGwIUlOO3YG11bfhVv9tpnO1P0YHiiB8RalCEpiTo+vYELNirIKV7cQFhNBT5R0Vo5atSv1iO/GUUoN+K6HxlHvHcaTQEZuGEwplW2PtzRUVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781258486; c=relaxed/simple;
	bh=+Km2mclHezGcvej9xOkPOHFcRkucSIgEAMmK5YzbwZU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XY0SXXEw0446kdl+/GfA3WDhhMsX7Zl7HSmfAusIL3mKIbbTFZB5AESSlWV8XbbVFAxNT3lysc0HPwY/PA2209vANeWehJ/7qGWTHPqXfuYUbg1rBYsm6soeSLIHoy930cRSYzZN0R7EFG0+ag8mnCqtzHT7bl64Q8calGw7/Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XVuPreGT; arc=fail smtp.client-ip=192.198.163.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781258484; x=1812794484;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+Km2mclHezGcvej9xOkPOHFcRkucSIgEAMmK5YzbwZU=;
  b=XVuPreGT2EbriVXjeJXCbljIyiCICdLLPo7wZDM17bHuaedZJAyKof1x
   rcunPRLCHsv3MEDvKzE7kP7Kw8+YQnWz/kZ4b96n6SAgqmHeZqo/fNfjs
   g6BXL7Y0UOJ4c4u42n2dz8Nlsy/Uuul2/kMd9K/WghdcCG11CGi58td+9
   hdFV+vjvnZ6Sy7cxgHLVDr24xvkV4k80+MA/ZkX1E3t4xqI7AAI8woFlS
   gFAQk0m7CoDU/Bu13LMTAQFmsbYCXTfUMeheEfwYzf6asOuxC/kQ/r9jG
   e5hYLzKKIPiyC+4sk226xoP1WcJWWK1O1muyq0T6yKQTqL4lTFUObdslc
   A==;
X-CSE-ConnectionGUID: tYICtOp4QPqR/WOdQIiqQg==
X-CSE-MsgGUID: eCNrqRHdSFG1DlIUJopKOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81931145"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="81931145"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 03:01:23 -0700
X-CSE-ConnectionGUID: N3+TSYvlQ/iaQFEUDx2wKg==
X-CSE-MsgGUID: z3sg5KSKTHOzrjK2ObVzXw==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 03:01:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 03:01:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 12 Jun 2026 03:01:22 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.17) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 03:01:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GY20Db1K88dMaeHjVbKBFIkqbenvcc1gSICZ4/xuW2D6QaShY99NeyLZh42431Ggh6yvjjZ8ClFY77KZsh/lnd5DycEIlZ6+AphM1YGi2yiRbXe3B3OtEVSG53dFM559LLBIXEddnceTAmvsnTBLFggFLR7liYAK96sbf05D3oQQDLyI2+7ed1lz6BC6NokcYVdDrEjh39LKiEDMBbbc9Iw5w9fXqk8KFts1nGd4Lc8IlfXToK5ywgrxbfeMZUbLMDRedWRLvDZl09GOE/pJCC48SkpFwB1xVPn2D12/I/bfJvfz4G6OE+giLvJYBgd25GVFuhK9b4Vka4MPt03n6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWAzBuXPFXvk93arknjMdM276lHIXGAa0XSLjspyazw=;
 b=mIEnyFB6DBSsX6m5jXiHWjH7mcmLcovUKkebuSoHTXsQnmGF2hVSDUKoGAWBRcDQfwr5b1H/KjwEeoH61tHe1roY/4iFl4ZTF2cAzPy4//AxWczFOexj5+USYIRwYbQ/6uaHdtSugwnBHNUvjGCTBrHmYYAgdpj5RWCzc3Vk6N29Zr5pKA2vc9Uq41xlbUlkcc65PpO+zdwPxEHH2hLP92oN31XwQOz7p7mW34YYX+FFSvEEqK/BHhe/AcHbWfMXoXymhI8VaLNEqrjjQ01pz1ZzE84HjWCyiE0Ns956UubVq7/ZgYcO/p5sO2sO2mMYuM2Di3rdqdGegtK2L9ElDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by DM4PR11MB6144.namprd11.prod.outlook.com (2603:10b6:8:af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 10:01:13 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 10:01:12 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [net] net/sched: fix partial tx_queue_len change rollback
Thread-Topic: [net] net/sched: fix partial tx_queue_len change rollback
Thread-Index: AQHc+klneSUPRXcCQ0Wby2Bn5CJUTbY6sCGg
Date: Fri, 12 Jun 2026 10:01:11 +0000
Message-ID: <PH0PR11MB590250068C3C8C0699716E4BF0182@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260612085438.834763-1-zhaochenguang@kylinos.cn>
In-Reply-To: <20260612085438.834763-1-zhaochenguang@kylinos.cn>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|DM4PR11MB6144:EE_
x-ms-office365-filtering-correlation-id: 52fdf9b9-f521-4424-c90e-08dec8698879
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|38070700021|11063799006|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: Fp3G42SZ2PqB2/e3U1gg5u6ejTIuRsxhdwDq9JoHh5/sVdBLXZiiuKZd0QDzkzfMusXkWLkAAxeKJpomd18ThS5wP7fz5N908v54q3rBtc+wWu7oCAIsEZy5jr2V9CHZoKqP3FFgSvAk7xJ0vCRD3kURPyHakL4NXUwfB5qf3UivEF3GKsb2Io4gWXNi9aRMaPXFZ/TGvrW65TBDc/iuIhTMlyFfjxNPv5TCzqK3eWedM/hljlnefW6UmnK6nRXPfZ4dEiksTPsSf36eTJgvFyb0hLjUAZZnegCfIuwfpGwzngPlYmb/vQdBEBmAhIPL2Z5pE5a/Q20T3SxffQ2URLwkesWYywAAzeyZXC8HDUoAQ/Z6OacJe4GpTfdHA5SnWL786BCAtk9FDLIoapRyDnWlNME8vRH22EgqsRS8roovJum31CxuVavQGmnAtzaO+a/Pb6qxFcQGKTKgXtjPcfo5fxGklYUbOHJgk6alEZB20jRgHIZN1/11NwKTM9encNhl5ioGSYlmImuD4Pg5ZrSKUKrorwVignSlosKcFxCwPr3XO8VKnGDvgO0DvU4oxzNkihQ5YnLAUE6nyFAc9uf3Tu8r5cttjr5CggPM2bKz6xAQmiYfMN+AiAmOBb0wQzUnxjJbUEJLOQPzHHr9g6JuoCYPjYmjkUGACh3E8o8MtcPQMEEsQyiFVFJDjxxgYiiWswKfnaI3U3rgR0i5waUdLjONs6rC8jBNl7hrzpHOze24joZH2cKTgknmDP27
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NEB9a/KBa0kmQWZkF8jY/wZzK08W8dHteQu5EYvdDgwXsyXBsw/WnbgE0l0I?=
 =?us-ascii?Q?7Am7CIEUjNvPeegytpmtHO7edAnIhRDZPcrmwpl6k/Qq+dQ38LdECNCG+kgR?=
 =?us-ascii?Q?+hOpqcc6oviND7YUVmIy0yPkxtmMx/br67676GhMznebvgb3DfvAf/MjlG5e?=
 =?us-ascii?Q?0gSnk/m4BEETO1r7rmlHdfOjwu26f84wbvUKrShlm4Z5Rcf5v5x3gI2HU6Tn?=
 =?us-ascii?Q?UEOloB1aaOop9cEgEZkJBWNseg9JfOc+LVvic1J9Xpcq1OY2ytY/rdG/Nr16?=
 =?us-ascii?Q?PLCvB/sCsRLFqXrslf8cKohy0X0opLJx+6RfwsZAetZVnVOhWbTCTLbHHD5L?=
 =?us-ascii?Q?SeY0irnYzgLeHQ3A3+HmOFyFS/BlghDlGxc5g4j/L1QGexLeUWLQF8pKDZ84?=
 =?us-ascii?Q?yrCmYEFgLVodvD04qkTQ+XW8ANbMWLMwz2r8VhTbKQcJxyopNiStR6VedZsU?=
 =?us-ascii?Q?WLbLQbEt0b7Jx14/CyMkg3MapH0nuIQIQFZcVzfpQaytx5hYlWRx0xJB1zrH?=
 =?us-ascii?Q?thVxRaR7IVA/h5kGfOz2+hg46w4HoFf1ZUSPVfd4vjn1IF6aVgkLYAJcVUbo?=
 =?us-ascii?Q?kKwYyLbEXlY7+24cM8lda/Dw1Nhr7rLfW15TqzqARshB4yfqTG0mPvYDMeNT?=
 =?us-ascii?Q?KgD7NIjYLnTec2amPE5av57oO4GECuj3L1YgLK38cNp2G2L/V4p3v8ByMCKm?=
 =?us-ascii?Q?LUTC+PIRGnDHzgDOKomZ4Lg8Dy1vNowl+QUlxkMGqPL9amyY/IFrMp8ccpTJ?=
 =?us-ascii?Q?r/1xYVMkOetZ5DmWZOosaOlAZrZGaikZ918gpx8KF+h/tM9u4KuVH1Pd0d48?=
 =?us-ascii?Q?0+HjSTk2hqW0mT/Snw9m0505pklmNrA2/yXxrs43NRVP4ZKv8AZ7Tbf7sZgZ?=
 =?us-ascii?Q?OBJLPXeoSSTOeOM1e3aNdf5m3QBkiu18Gc2GAaRVEC2UDSTCq0lph/Gm0WsL?=
 =?us-ascii?Q?c1Nq9kivGDhdcbAKBPEBqvsLgi6OEJf3JpCdZVGsk02l2xOT3+obAGHN+VPE?=
 =?us-ascii?Q?6CW38dm4M/r9cTD8KULMpIUztnF6JH42lGADW2y92wdSYbzZFSA4kwp8A8HG?=
 =?us-ascii?Q?n2/OFMkH+jnDu1sIwHqBcKKule4zFGj+N1Wk0ZYBYyzo1ejdGFd1ETe+hJi3?=
 =?us-ascii?Q?wUrocuvIBYMCCv0a5GdXRllLyeqsdPO+YfXFtIJomzu8/4eR3kfbbpovtmco?=
 =?us-ascii?Q?7u07b/Iyoo3YeE2PRpZkHVT0hMDtTl+dWS1sasvKGk+Hy5NKl+Sh1SP4NV3S?=
 =?us-ascii?Q?OFdoB+LWSCG2mx6S4/8n3ik7M1TreR3671/cmq1OVzrM4PWwg0dO3VbZVwlM?=
 =?us-ascii?Q?W99G0btjenIsplS3VyuCZTN/7I05yHAS93Lw0bXQPJUStnKyRKFXg7DMWKJC?=
 =?us-ascii?Q?58lS8g4GArqCnfIsGt2p5HasBgFtuno2Q/Pup3+G5q6XQJJgNbvBLDW5Dto8?=
 =?us-ascii?Q?fJeemi40ro8x2O4tKoZM/qPAls0N4f83FJUaQo+Pn/K70x5gZ2XLvGX2VsXy?=
 =?us-ascii?Q?cH68lZ7aVETbaqsRnA4q/1Vk0ikInCcV9jvtB2AtnWhSilRMCSLCZ2JHJ/Wk?=
 =?us-ascii?Q?iooYgV0633PPD7uwMZB+J8yEBtLVVja6Gaz7Oor3Khn9EkJED30DiILlSYwh?=
 =?us-ascii?Q?eog/u+NRKTEA5J3MivvpnP5+JSGyZxe0BwkYn44nii3cIf4IH3aw3z6WFJkm?=
 =?us-ascii?Q?favWUtScqwc9Vc4Uyur1/3sDKapUItaHUwxeT9MklH7Gc9uJFp7vK29rLh/P?=
 =?us-ascii?Q?UwfmUhp02w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Y+Lo7mNpeT1mC/5+AhoOl+OBaZKryyvUh8yuy8TrNsYJmYeUzM4GUoYol6JAIXIyfC2dY86yHF1vfvpxLR++m172uYlKr4JGwRlZPSKHXt+xEPbBRlgViEwcEeX1kLKR6FdTZiziMTkpwbaSU1SkUvyp5J/y8yJFwQ9KgW2d6UbLIPGvW12O4EGajI96xrD6JfCGsz9b/Q2WVp/jLwNau42tyFuo4TH8FhwzAk2lYn2ByeEcHGSSF7+WE/QZyxahqwL8p7SIcR+VGH5fl+APPpo7kXGMY8I2RWF/SqyU0sEgeEPD5SmBNos9zwBWzsNHSrPV4LUpBrFynQcV96tpZQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fdf9b9-f521-4424-c90e-08dec8698879
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 10:01:11.8814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0YCiyKYlROyfDyrHj2alFECXVNuM17+KzBJvX7TygF8RmacvBb9Z4raqvjscgwsnX9GAXil8xgQ83YijS3RV/MkwxHbUpGqw2KQa8hxj2Wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6144
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-298571-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zhaochenguang@kylinos.cn,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9ACF46788B8

From: Chenguang Zhao <zhaochenguang@kylinos.cn>=20
Sent: Friday, June 12, 2026 10:55 AM

>When dev_qdisc_change_tx_queue_len() fails partway through updating
>per-tx-queue qdiscs, previously updated queues were left at the new
>size while netif_change_tx_queue_len() only restored dev->tx_queue_len.
>
>Pass the original queue length and roll back successfully updated
>queues on failure.
>
>Fixes: 48bfd55e7e41 ("net_sched: plug in qdisc ops change_tx_queue_len")
>Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
>---
> include/net/sch_generic.h |  2 +-
> net/core/dev.c            |  2 +-
> net/sched/sch_generic.c   | 26 +++++++++++++++++++-------
> 3 files changed, 21 insertions(+), 9 deletions(-)
>
>diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
>index 11159a50d6a1..fa5cae1b1e84 100644
>--- a/include/net/sch_generic.h
>+++ b/include/net/sch_generic.h
>@@ -704,7 +704,7 @@ void qdisc_class_hash_remove(struct Qdisc_class_hash *=
,
> void qdisc_class_hash_grow(struct Qdisc *, struct Qdisc_class_hash *);
> void qdisc_class_hash_destroy(struct Qdisc_class_hash *);
>=20
>-int dev_qdisc_change_tx_queue_len(struct net_device *dev);
>+int dev_qdisc_change_tx_queue_len(struct net_device *dev, unsigned int or=
ig_len);
> void dev_qdisc_change_real_num_tx(struct net_device *dev,
> 				  unsigned int new_real_tx);
> void dev_init_scheduler(struct net_device *dev);
>diff --git a/net/core/dev.c b/net/core/dev.c
>index 0c6c270d9f7d..bff2760a301a 100644
>--- a/net/core/dev.c
>+++ b/net/core/dev.c
>@@ -9934,7 +9934,7 @@ int netif_change_tx_queue_len(struct net_device *dev=
, unsigned long new_len)
> 		res =3D notifier_to_errno(res);
> 		if (res)
> 			goto err_rollback;
>-		res =3D dev_qdisc_change_tx_queue_len(dev);
>+		res =3D dev_qdisc_change_tx_queue_len(dev, orig_len);
> 		if (res)
> 			goto err_rollback;
> 	}
>diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
>index a93321db8fd7..d4c62e1f2a75 100644
>--- a/net/sched/sch_generic.c
>+++ b/net/sched/sch_generic.c
>@@ -1400,13 +1400,14 @@ void dev_deactivate(struct net_device *dev, bool r=
eset_needed)
> EXPORT_SYMBOL(dev_deactivate);
>=20
> static int qdisc_change_tx_queue_len(struct net_device *dev,
>-				     struct netdev_queue *dev_queue)
>+				     struct netdev_queue *dev_queue,
>+				     unsigned int len)
> {
> 	struct Qdisc *qdisc =3D rtnl_dereference(dev_queue->qdisc_sleeping);
> 	const struct Qdisc_ops *ops =3D qdisc->ops;
>=20
> 	if (ops->change_tx_queue_len)
>-		return ops->change_tx_queue_len(qdisc, dev->tx_queue_len);
>+		return ops->change_tx_queue_len(qdisc, len);
> 	return 0;
> }
>=20
>@@ -1443,9 +1444,10 @@ void mq_change_real_num_tx(struct Qdisc *sch, unsig=
ned int new_real_tx)
> }
> EXPORT_SYMBOL(mq_change_real_num_tx);
>=20
>-int dev_qdisc_change_tx_queue_len(struct net_device *dev)
>+int dev_qdisc_change_tx_queue_len(struct net_device *dev, unsigned int or=
ig_len)
> {
> 	bool up =3D dev->flags & IFF_UP;
>+	unsigned int new_len =3D dev->tx_queue_len;

Hi Chenguang,

RCT is violated here

> 	unsigned int i;
> 	int ret =3D 0;
>=20
>@@ -1453,11 +1455,21 @@ int dev_qdisc_change_tx_queue_len(struct net_devic=
e *dev)
> 		dev_deactivate(dev, false);
>=20
> 	for (i =3D 0; i < dev->num_tx_queues; i++) {
>-		ret =3D qdisc_change_tx_queue_len(dev, &dev->_tx[i]);
>-
>-		/* TODO: revert changes on a partial failure */
>+		ret =3D qdisc_change_tx_queue_len(dev, &dev->_tx[i], new_len);
> 		if (ret)
>-			break;
>+			goto rollback;
>+	}
>+
>+	if (up)
>+		dev_activate(dev);

please add newline here

>+	return 0;
>+
>+rollback:
>+	while (i-- > 0) {
>+		int err =3D qdisc_change_tx_queue_len(dev, &dev->_tx[i], orig_len);

please don't init at declaration when the retval is checked immediately aft=
er,
separate them

>+
>+		if (err)
>+			netdev_warn(dev, "failed to revert tx_queue_len on queue %u\n", i);
> 	}
>=20
> 	if (up)
>--=20
>2.25.1



