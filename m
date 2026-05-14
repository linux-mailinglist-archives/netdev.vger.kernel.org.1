Return-Path: <netdev+bounces-287825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OLyJspgBWrsVgIAu9opvQ
	(envelope-from <netdev+bounces-287825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 07:42:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0521353E0D1
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 07:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0C6E3016510
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 05:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B96138889A;
	Thu, 14 May 2026 05:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RiX8qY+X"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BFA349CDA
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 05:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778737351; cv=fail; b=GP0hNrQChp2SgnEbtIFn58AnY85Ok4xoJ3LyTP+drxG6kzhRSKJo6tDUKJrdTJ38r6x41XyXAHQFrzCZWlonCmmSdppCAdUp8yYBQUMZlDo8Cf8g+K04WBGER2sgLeyK45ylLVIbe8z+Vv3pIosVZIXCASk+5zUSxzIBCTw+fSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778737351; c=relaxed/simple;
	bh=mE+P8/JxaBHlwWcJ/T+oO+fEa1dvl6PAK4PrdtgYAYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rxfTTYZwYBvvazLEk9hgGJFRzJqvjKo8qvecVaFK/c6eNN0CoFnASWKdigMvraSBcsWMhHoKkduW/Z6YQ7vyBt0pIDEGURB0RjAdNg8ZcIZD1oG/AOsS7XEf/d5v+r3nGTgwWUDK6cHMClrxSl0lXn6szqBD+OusFcVK2R5/42M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RiX8qY+X; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778737349; x=1810273349;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mE+P8/JxaBHlwWcJ/T+oO+fEa1dvl6PAK4PrdtgYAYE=;
  b=RiX8qY+XOjTKDcwLF1mrIoEeRzpeQ78Bv2G9iDeoYj19Uzjmfnxg09SG
   FVwQghNAKd017YNh4ALDJpQtG6jCouMEW6RMu6w4nU/nRwb6TWvMX/Sk6
   567CX7jVCnybaAMvlAXNq7ugUc5F45sN2QKGp/YyyAvpadagNYXH6WhA/
   2hHSG/4+4CCFCD8eZWFqiTrN7Aj3Z0kTJqla7DJ+Hd0q0iWkDltwCyeI1
   4x0jR1xQ4iAUlmXFoQgN0rOAR5dYo1pLHyirw6SiAAj6Z3Aj0i7gQSm/Q
   se+4SnMB2NNqPq8FBhsFEI5DpxRDbDrnv0k3gPQVkaCUK6IBAo70UuHDz
   g==;
X-CSE-ConnectionGUID: 6E+L8uj+S0uzfvczuumZHA==
X-CSE-MsgGUID: Sa6/q+jjSgah7ted+sLXBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="83544640"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="83544640"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 22:42:29 -0700
X-CSE-ConnectionGUID: SrajgG9NTxyFU1NDuzhHwA==
X-CSE-MsgGUID: eHRTqtc6TQiGj/K1eBiAZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="237308391"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 22:42:29 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 13 May 2026 22:42:28 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 13 May 2026 22:42:28 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.44) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 13 May 2026 22:42:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4QFU6z8tGpVUWUPXXYl94U8ODG724sjNRQkt2c1n2V8rp6jkI18YZmJoP1fnnQCYyTQ0ooiczou6GMq4XS89kikk25W4+hW5zb+EIJ5R8z59hAKLXhrm96Xx0PwwTebe7ymuPzYd4T8r3p9HHIgndbbaj5Se+jzbVwgWSKMNi0mYqDDu5pWjiX0+BcCHApZnlRtv6NFq0xA9vs/ZIOJV/DKXzd90/pD/yDtZZ8/fDR4VQUIwoO+efBUzatZoDE4pvRzQOEWPA/2bBG9Op7eI9tgs+Nz+xw+1dUNMQxRbu+bf0FLzDNQERyWy2cjwFTWDgp4C65cIh8oCgf7lKPUZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTrMh8qePkBPXF0sYw8FLRFeJ2RSEXe4/jquAf6T3HM=;
 b=gzquTyyDo0GXi0CGeqiOWDMrj8OhSUCUW+7NuAgmDMKwl7Fq/AOkx30tDOYJIIRA09emR58QEELVaKH4OESrag/g+GBYCjdvLEAk9wVh7PCgFxgzZ4KRoWZiI5e1WFedeynanwYKfrj/afl3TaOazKuhnQuoQEYKU+/tNgZigKmGca3o6eu2/hyWJ6WKtbjwkrAISfM8xfVATm46h0aUH9lmEYuQDJKCO89VL4y8s1Q5zzClKe00Tc0DtrhUtwLKiCgOH4E41iSWTPzlDMKOqB/a3gJ8bWI00nyKasHfDVCpg3DD1sfQZNe3WR8es2r22r1ElGtWaMIS6r55KirFFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by LV3PR11MB8457.namprd11.prod.outlook.com (2603:10b6:408:1b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 05:42:24 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 05:42:23 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Temerkhanov, Sergey"
	<sergey.temerkhanov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH net] ice: use READ_ONCE() to access
 cached PHC time
Thread-Topic: [Intel-wired-lan] [PATCH net] ice: use READ_ONCE() to access
 cached PHC time
Thread-Index: AQHcvbq6uRqaPaO+pECYF9wHXGBlvLYNTPBg
Date: Thu, 14 May 2026 05:42:23 +0000
Message-ID: <IA1PR11MB6241F71A16782BFEEDEBD5368B072@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
 <20260327072332.130320-9-aleksandr.loktionov@intel.com>
In-Reply-To: <20260327072332.130320-9-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|LV3PR11MB8457:EE_
x-ms-office365-filtering-correlation-id: b9aca38f-988b-46c6-600d-08deb17b92ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|4143699003|38070700021|18002099003|22082099003|11063799003|56012099003;
x-microsoft-antispam-message-info: SEEcKy+R+rm2Sz48akkf4+4IiKrVPJvrwA1SxrnIGputMTkhyvRVn3qbwgBFX858MeiujV/xFUaco+qNGrH3flwA1lKskBF+0yXXjNAt8PfJC2KZpSP3kCsKb4hgU6JTsHDGOOpY4QFy1jwxopBzr06fVtPXJ43HUydoHtxIU5CF46yhV+INudCut6AyF6af4YgPw/lvMkRKY+rrxIL6TDa5L2NbPQ5+drx5Yzkc6trNND/JyzBxLzCXOLVljBLfTbsQfwRA+QgCtuC5R8DwVbxBBzxai8MA6beh8f4kcolnjqVQbkKFgXRH6cDxXI2dyhI20je/v+uKeGYfaY6E7ZlSEXYkoHpwWqaJIl303afN+7hodgfO0n1pZ97eLzC5N8dZ1pyvJhwklkj8/BMuUjcoBms7vUtzRjifObbqcP98CMTAQykoSZc6WBoyPInIbq3YspmnWJWXjxTeebeOmC1vKALerav4f82QzY4Mg0xwmdQgmlQxoaJkliNSX3mEI0Sk8rhsFnGfIyqdSy7pmApxqxTpLCzJHo/t8ncQxLoghUEESLEfwftqXViR/6g2yp7wc+VqXu8nIa42AwQp5ZKFlLqbznQmgWmNeGtOg+1G4cXYsSwRzTQ53ALr5YKdNLZqF8X4HmHamYzvBTaOBJD4CyS1fYfMImltbq1XeHmNDdgb8FtEfiB+D9FAFy7aF6zTcfOetLFu2QVgv+QKV0rTEjCe2Bi3I5GviEcfld8MQFDszGiDhvpVg8YrHnLZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4143699003)(38070700021)(18002099003)(22082099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JfQTEyI4wPRv4w5+Y4EgogrnqsJgg3Cve9brBZ/VwFuTg4ljc7ZR/BwrCswv?=
 =?us-ascii?Q?6yjeahNuhFYdZSpBMLFuSF9ddCPGg03cxkiniRvNgC5DSGQVy+kLjcq3rH2a?=
 =?us-ascii?Q?wE1eF+foiJiBLh2z0zZiO9puY1pSo1zu/yaU8hZNqNkcNuSr82oG5D0MHgaU?=
 =?us-ascii?Q?PTEm1u47HlkCG/b9c1cVgThUXnFYcmRUWtyi6zUKbR/cTcS2ZMBEtruRSpcN?=
 =?us-ascii?Q?NGHCPUHkD91y8pf31uVFI+71f4lf+HBhhA4XBrf8fleeFOJ0v8uGiFBuPZyE?=
 =?us-ascii?Q?7B0N99BzZBOx/7SvZ+Z/+QQBJfoUXcetsq/SgkE4WL1Vo+/xTsbmXmzY7sYp?=
 =?us-ascii?Q?5UPjySoRdszSC7U1g0fqEII1ifP8T/gXPy+8H9afgF1zjVXmRWfzmbAnkQmm?=
 =?us-ascii?Q?Hh5xbJBdQN3Bnhe/0fpmd7lw3VdL+8tzT1HqfDHNe6gFtS1VFOk2YnaSC0zj?=
 =?us-ascii?Q?qU3JGn3dY+zOs5C3fx+rg2/W2XVevEXFCTzvOpbXMLhXEZ3TnjbRnGcUgGld?=
 =?us-ascii?Q?h016VJDcJEg/dfae08Aa4LH3MpB5MoXrJkfi7El+KWo9N7YnnvqXQGRy+sbd?=
 =?us-ascii?Q?SDQ5PBr8W0OxrD5tqAcnjAFE4C+HN9EAc5y6mC7/WlaTnLb2aL7gbdbisc7B?=
 =?us-ascii?Q?PlIccXHMb/bLvAU36ZN4/vod/yIbqDHTRMWPQkMl7dUiu8Tv69no91Lpu3V/?=
 =?us-ascii?Q?3EcswHIkU9hdRPGqJtCKN0Nje/FIDUKTskovPXPJkY8is5BEjVdWoSOrI4qb?=
 =?us-ascii?Q?2Fbo1hzz5UEA5S0GJVyNUDM0GSfkFULa1Ao5FofkHywWcQEG9kCh6ASyOVEE?=
 =?us-ascii?Q?RrzN8QwIBt5jKkr5v+N6UEX0zcJ1B1qeXP+99VNFlUwSrQYN3sspYsJnRmRe?=
 =?us-ascii?Q?Imz7ZI/o64z3/nTuoqlUEPvwrGPY5Rv9YzA6fTT1jOHQls/WlyufExAv78yl?=
 =?us-ascii?Q?kyqlt+k8Ik7VE8Evr9Zb9x0U6XapuwMyNcnwlq+3oyI03bF2ztEb1B9nxXXm?=
 =?us-ascii?Q?fyCvr8S9eDwPcUGmNj/iJNT0LZ1XjpnoUeh//gMoZJjkUKoH+YrpF+B/sGvT?=
 =?us-ascii?Q?/Gdvo6VurAzqZ3MrLAO93BmSGUAktqRMKaZuvrXLLcRjQHb0ai3f5doeXTcD?=
 =?us-ascii?Q?HahSkCGVJ314Pf4uH7ymTMpesozv2kUHM3G54Ci6xAbhbcCwulQNYlORXK9z?=
 =?us-ascii?Q?t+A208ulzWVJdbyTTwyveftE+hKVvVg2E+yOZocz51K91Vi1heDkf0KCJX2I?=
 =?us-ascii?Q?aFYlzmdKWDit/p2W+9DwE1kUCSwBmV4xYSwGk/DbLyN8u4eM9c3liof9a5WT?=
 =?us-ascii?Q?mCNbLu3PShYUYDJ9kcmAf8NOa6YyxD2vhuBX/p//3h9yIPJaPUs5XtzvpF0b?=
 =?us-ascii?Q?3vkzOPpkmkF8XFBgKUExrOmfxcb+NPhWpDOQf2AW8E8ZgfTwCvEMMqk0ZY0p?=
 =?us-ascii?Q?tcoa+ly7wv0DPKcX2N1W8tSxEojMTNtXxV+KNqOnO4CD+lCnvqArbajkEC/q?=
 =?us-ascii?Q?5UQSoUvLyVJQY7mb5OAdIBLOgAdxvRIHsok9im73DxKzy1xbxERuCFujWzfj?=
 =?us-ascii?Q?ViH6hPU6NPIMxzeuxLRvRDnsMT6UfU9tI7+G9xgUPdnc8ppiU4/64Cwlt6RG?=
 =?us-ascii?Q?nRe07fz6oORPEeEm9AZcUwc616XVeEvMO+SRsbKXtiY0mjcjrSZkQUGR/Gj+?=
 =?us-ascii?Q?Ra5jDYLfrVP8tPEGRAM/nBUDQOfZtWqVOnwd1911WdDt7b7e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: V6Q+3YXEWg6S6uT1JWVJOAPfNaCGJgNIMP1Y3M98jNCBtMftFb5gk9hhP9Eaw7gJBn7i8UgaxcTYnBuhgkuS+p4JruoOv+zcbMP2L41N5hrs3c6ljL9qm2WU1dtK8Nt6EGZvxXIwqITXSJ/HX7uVqvOie0iSp5gsgjBV4XOQhmOguIc4KI7pR9MnoxgMARNklY7mkLUYOsZUOBh3USu/Bb+1+ynNsJUCTsPxqmspGVh/4d6elNACCb8ERCrbzDTHXeBjQ4I36dQCDxmWFpVJJszAjgkxySIMoQumGRki6ggSk0Gnm2oswe3JfJaV+t6WLo/shBBTJ1v5CZ0H3zUSLg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9aca38f-988b-46c6-600d-08deb17b92ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 05:42:23.8008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VtlviTdn7r19wdBWPjIa9eybfDwTKwKqsv1lychSDH8ZI9GMJFZCzM7YgFzcn+fFLLZyZ+fUUgEO0LeYvXHVLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8457
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 0521353E0D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287825-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,osuosl.org:email,IA1PR11MB6241.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
leksandr Loktionov
> Sent: 27 March 2026 12:54
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org; Temerkhanov, Sergey <sergey.temerkhanov@intel=
.com>
> Subject: [Intel-wired-lan] [PATCH net] ice: use READ_ONCE() to access cac=
hed PHC time
>
> From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
>
> ptp.cached_phc_time is a 64-bit value updated by a periodic work item on =
one CPU and read locklessly on another.  On 32-bit or non-atomic architectu=
res this can result in a torn read.  Use READ_ONCE() to enforce a single at=
omic load.
>
> Fixes: 77a781155a65 ("ice: enable receive hardware timestamping")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>
> drivers/net/ethernet/intel/ice/ice_ptp.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

