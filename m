Return-Path: <netdev+bounces-120994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE3195B5D8
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99181B20E06
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9651C93C1;
	Thu, 22 Aug 2024 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLM0ttbH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760431E87B
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331767; cv=fail; b=BQv1DMBuazq1iFH0bSRGlztCn5MIEFzMFQUNL4kHB6rsdgIcxPWZI7IpqANm6Pfhx9JV8+oLagytv4fYAHlcr8f+XJtf2rVpCNZ29CHLy1BW8xg5BIatxKiW9NsHsTKCZnRLYOQ9Pqmtj8zzMSGOlWRmpcA+KbSxwSkeVRKXCXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331767; c=relaxed/simple;
	bh=XcLyxajVVdMnyHQ8aZesktZiJa0pbDWzP0Mp23SgBJg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uKzB92vpq12g+DA97RdezrK+TM558c4KRAoaUm2N8QAXDcN8EDkdQ4a0VKkhC/4EULU2usK7d+iexT/0phNrO7e4z58JrEJpxcARcTF7Qy3ry7ipkT6GM1AUksrxKO+NaP+IjBARzEsb6aCAN+pe0544v8wrHgac/UwDfB58ysA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLM0ttbH; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724331766; x=1755867766;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XcLyxajVVdMnyHQ8aZesktZiJa0pbDWzP0Mp23SgBJg=;
  b=gLM0ttbH3f0rnnfiMjlem2/fVFiDjMbk4S0QYs7J5mkxfmTEjqzTUSuS
   9uyCijuVW/5txfEbjqvaYxaMxJM9TBTdOF8hIZxr/dqZ8IxbLeFccUSe0
   SHWebVbUjiQcaq1tbi/AZiGsSemOUBbOl92A1dFsas7F1eQvq6Ws4V+Ws
   qCmDn4DfaLn+tOqAZHGrDTgBDEWTstcOgfElvxTAE0IvgdKDazTj5nAwP
   e8BRKWPHcKZKkvY+h1hGAedJEM1EZ6sELrPpR4VEDkwdleRAd7jApEf4t
   w4zrZYeCmppTWY33EhR9AS4vp1e7ICRK8KChyoJlbqJ78LaNAhsOP5Dve
   A==;
X-CSE-ConnectionGUID: YJqVHWfWQHeHWeM9lp4teg==
X-CSE-MsgGUID: aBidx0h6TWOp8ZBwNlhqUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22621047"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="22621047"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 06:02:31 -0700
X-CSE-ConnectionGUID: dJYOspuERkiRUrrlUGfY7A==
X-CSE-MsgGUID: JEycMT1oRPOL5Ps8BOxbkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="66361332"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 06:02:31 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 06:02:30 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 06:02:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 06:02:30 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 06:02:29 -0700
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by PH7PR11MB8502.namprd11.prod.outlook.com (2603:10b6:510:30c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 13:02:27 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%4]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 13:02:27 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v3] i40e: Add Energy Efficient
 Ethernet ability for X710 Base-T/KR/KX cards
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v3] i40e: Add Energy Efficient
 Ethernet ability for X710 Base-T/KR/KX cards
Thread-Index: AQHa8hogG4MIbmbHak+ipDhIJP5BarIzQiiw
Date: Thu, 22 Aug 2024 13:02:27 +0000
Message-ID: <CYYPR11MB8429C31FC975FADA9B8C1440BD8F2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240819092756.1113554-1-aleksandr.loktionov@intel.com>
In-Reply-To: <20240819092756.1113554-1-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|PH7PR11MB8502:EE_
x-ms-office365-filtering-correlation-id: 4ce59b2a-79b6-4cdf-82e9-08dcc2aaac74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?H3OecSKRseKFUxifyUMrGA2wZ2sMssHTejI6HH3u5SFPxAfk1zHmlEn3t0yP?=
 =?us-ascii?Q?uHw9PYlrjUyFcZ93FK2cIQRTSuXPRTSidANXNe9WgPG8VXLd3iGjlrbpwAo4?=
 =?us-ascii?Q?w+vv5duW9i1n3CKxbQG6ImY15FzpEMk6Mk+JVgsqPH3InKWYUBghi0O9AuKi?=
 =?us-ascii?Q?nuJw3cpY1XVU6AY2bwF4GCduYRGeMLIzHTk2NoT9CFWL4Xbx9952ROX1E6jv?=
 =?us-ascii?Q?WbnhrYTzpPBW5wr+dwyTTPWUPRRjWaV2yr0r6ORZU15IgrXG3jCpojuCfCD6?=
 =?us-ascii?Q?zutQLyKH6xqkldJucstjlNmDAF7kZ/+dB/OExA81VvFB8TGmpWQlvVS4TiJt?=
 =?us-ascii?Q?V4RTozUBrNIcvpGXFM6XD8TYCMr+HJxNQO9jp5TPOS90axI6CAW21GT4ueRv?=
 =?us-ascii?Q?660dKXRVfTDmSE8gjIB2Fc3H93xsC045XM6Mibeon4oE9wBp7en39xMCJoew?=
 =?us-ascii?Q?kstHIte5nWzKf2MwNFIfPdBBLHw7Pb/Dzhs4nEA+LrdzAFVhaMazFMSvDj39?=
 =?us-ascii?Q?pYS5F/oetsjuNMkehEAn8IzAAzupBcWdbbUeb4tKCV1+xRFRgUAEdsvJCBXg?=
 =?us-ascii?Q?Kb0o/8UNdgZ1Zsk4kiLq9CN0Lev9q1bZM+Y0Hk9by1YXOk99Qvd06or44bO4?=
 =?us-ascii?Q?LN4r14knxpqKhEpXMuFpRAlk2YugProPQIshjwl12bQvHlbN0pCs/15aN78i?=
 =?us-ascii?Q?YjBYeRyI6ZAVULXfcnzylnVpdc7TDQ2ZaoCuYOg6M5djPtk+TYk2eIRvqAA5?=
 =?us-ascii?Q?yEnKmeIjdUbNzTY7eBOvCnXmVGAe7NxfWUSAZ5RNB4raE7HwIbTOpUnxV9Vp?=
 =?us-ascii?Q?RVk4cXSIGJDlwxR+qRkzaGRRioyiFrd60ifAHUTgzblwm3IV7LRFHy9c9iuV?=
 =?us-ascii?Q?6vFx4ZYn8/9EHYTQZdIm70cJYHoNaWQW0fc3Jnzg7GQDtSnIgnrD9JZypSaS?=
 =?us-ascii?Q?v9z4g+4CxAy406JKECTxAWy+tKOO88mreFiebXQsvjrfLpyrFpO06cUX9nMZ?=
 =?us-ascii?Q?9eY2H7c7NNTyk+ymAUXwylMtXXI5jzZ0A4fBjf0Hj9gN1WqxRwSvArAM+Eyt?=
 =?us-ascii?Q?V7+sEWmea2UBz2jjCD/FMK5hNbNtNp5np+hkeS/X+srSnFy06je8fLxzKcGa?=
 =?us-ascii?Q?fPyfID/h/gtL3CncFMEGVz0K2GnCLceJ9ZaCEOZq5mQqZHMfHQj7IVYjek6z?=
 =?us-ascii?Q?UnAX7zMflTT3lsAFydp0iPeZGmqyTVDEOZtwNUnw2cTKlOvFt4a9TnLYqeQ1?=
 =?us-ascii?Q?SRUx4D2H48dkVdtQ8EvlqLymErFJ3Qdg80Tz6TDKWe+m4rWKPxobm7+fnmcV?=
 =?us-ascii?Q?xlfm/P/3o7mgMToXfhQZUmeavgRYtdCYalXe0sl15QPv3eMUPHtG3gsigi3s?=
 =?us-ascii?Q?H3+8z7glk/0tfR6s/eC5jS0jmcGL8m8VgfFGZxUItCBMy6cGLA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WUM6Zy2asxIzsMbangYsF1fSTKL0rXj6cMEKjeJPGvMspHHVmzR9Sn1QYLah?=
 =?us-ascii?Q?0EvbSt1eYJG3Xs8X0PggjaoYMcXh3XVjQBh6Z24SNU2hosARvg4NADDx3tFF?=
 =?us-ascii?Q?CcrjrJqCGMpmaNx7gKQVa8hP9T3pe3xCc/gAhWjC9i9O80MdA4r0lhPRzlak?=
 =?us-ascii?Q?ht77rbPf6gX4S/OxavcvPaMLIeibmaQmOHWrLXWiLX8+zxpwBoPXWphTjQ9+?=
 =?us-ascii?Q?rvfqJkE55vvif6V4HB9q3/q+jhfSgABaz/Ttqm7Xw7TYXF3z8LG2r2WaGCIl?=
 =?us-ascii?Q?bhZNqFQSyr/x/FYzMEADLQeL8ragj3SLNyccJPrjQQX4rcXMxOMLIWThcr5S?=
 =?us-ascii?Q?IN8cD+Zgw3I8cfC1wCy+hu2wvRLlBoLADSrEQznyBAUZUCupu4qJpG8FgcLx?=
 =?us-ascii?Q?cTbAdMLqsoDd3Vn6M/w54VPaf7mrIfj9UXoMuWNlLdqVfOPxc6SsSDj0RkS5?=
 =?us-ascii?Q?RW9Qf+CbYdwhNEe7cPd7loqbAkayF3nk6cmysdkgEFckYQIL4dOtQ0oMtnyq?=
 =?us-ascii?Q?ih+Ol0QDATyRwNEjw5PaBJcb1JBd3r3rxoaT1AD/EFkYnBSvw4deIrhkJnJE?=
 =?us-ascii?Q?JTZ+p8MXrS1fm2DEESicmK9PP/QmiBe/WIDkihj9F2Z6MCnsVgQXv/vx2Crh?=
 =?us-ascii?Q?GQHQjslszdzB/PZbP7w2evljHx5f85h3tYq557Z1mOuzWE27TwBXyWx2DyYn?=
 =?us-ascii?Q?s0Er1wfPUr1VPCQflcCRdK/RdU+z548KVdcyBUTgaeUbffB7xFi37b78hqvg?=
 =?us-ascii?Q?zHgM924IuWZCM0fGuJqGSpBqqLFuFHpVS1bF+wKPzOap6/rpIsu2VhEVRMUd?=
 =?us-ascii?Q?RAZBQa0WQmUKYy7So4kM5lxtNObixC7LTUdSgXPCxrMlv9VT9wO20gfvqltk?=
 =?us-ascii?Q?YTquYLnpfZEEO8onxpWuVVoVNsmCJccgkei+hnU2MhmC3d5TzDonIBUnoHr6?=
 =?us-ascii?Q?nH5APFIGPQOzdORwxLOipjCU2vdJzzlPyoNglQ3rH16ko6mHE55TenflBVzd?=
 =?us-ascii?Q?R7qDF3SGjuZNmKi05Jhc65SCZQ9gg9eegdIiFG0oPD/xKoWKU/hwIUmbBsoN?=
 =?us-ascii?Q?WCZGIj/ngCn/TkAo3IfnwhNSEmMuCgZy0JKK84lJ1vdruKTi2FsXH+L68dEZ?=
 =?us-ascii?Q?KIrZVnziNwfoLFrvyA08d7rhrOLiKY2SECa8BBg0xtWtOJ4IVqgJOv1BDqOz?=
 =?us-ascii?Q?8vQK90fNEqttPHnf3dM5jpSe95LT9qVC2GKOEA0iVzhbmPf+3lX1xi5mBWjG?=
 =?us-ascii?Q?a2t6MRFGeEwEOa14Zmt38R2D/43XKvxbu25gfXpvIB2SLrhy66A/QZ7FhjEn?=
 =?us-ascii?Q?9Z+ApoGNq3oir5f0O2K5+tK08uiZyiDShhGonbCNim0M8ENQ77/5/+SY44Pf?=
 =?us-ascii?Q?twCQl/QeuRRpRjA8XaiKeHAR7o6TqfPlSYCTCndTz9oGHDzWMbxmeZkcGCTa?=
 =?us-ascii?Q?OPGiAGKBDKjv9ckTfr1sm2ajR8wM0AnEO5hoDbBxgh4w4NRI6Rpk2whK9UrQ?=
 =?us-ascii?Q?4Rt5Al9CuckYTQKzfrHl/W96jSMFrGJwVqYeZdBURXuC7SCYcIIVEq5kS8am?=
 =?us-ascii?Q?YeNM2bPWHHHgn2V0/FbFLkx5Bp05In3zgQ1gbzONyCQxzyPODmONCLTKNFfs?=
 =?us-ascii?Q?0A=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNQuOjcI1i0Tul+5oRwc2iyjnrHTcsPkDWfvOfRxg4Sn3HLJkYEbi+LiRWnFZcqbsYHvFMyx4thdrIT7ZkRxp+Z9k+6c4pAIEGMD6FhhTuwXV306pUZIMUsCKVgEUgzO9noxOV3zqkY+/rcIavxfhbhj3mO11Gi6n9P+/mPg2x61GPT8LDxlQlK47dHrZwPXs7Q6IYPeuLOe3gaPkAbdKWwdHJEIevfFW3HRSC4ZDyZfURzr2DP2kpJHEiAHvNqTC3CSFGqNWbUrMerDzAor0DUQnxSsd4lneXdV8yCxsZwGrqjvm0q6Mzod6G8M5+JHn9umzWHl75MMG2FRrfRj4A==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5f39j4JuzVscubu/Ke1exnVuDyABzPIcawWfbnlZnA=;
 b=jFSzVYCDmvVuhCFiYYjQgBhbyaW1fGiY+W19ExAupd92MXVTI40rTFvvNSMgjc6mtoo217V4IxonX5sTaevwQ1zgOR29crdCNNX1pmZXhiCwhfTfS8ThSU9/kF1DtzHqM12rnKXcFyd1RoEiRrSZjj0/5RfB0/1KolgbET8wwQGUIYfpWMANljEOeYUtLo/gDv1PkY3yN8+rs1WgaL7I+bmZBSxoAZPSxQ9PrMjCvvaO/FJd632DuknPWyEaFIrUJ6YO/Vpa0xRjWypNEggoow1bkoIyo/sKVfEFRpVcSUNxR4uJDPD6UEpUqWR2xdKq82sbKyAQAbbkDXjCK+v06g==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CYYPR11MB8429.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 4ce59b2a-79b6-4cdf-82e9-08dcc2aaac74
x-ms-exchange-crosstenant-originalarrivaltime: 22 Aug 2024 13:02:27.3172 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: pYT4bP4cfYYi9jjq7HAenxVxJmALrG5VVwNg3HPqUdvtwWTn5FGXYgA7VKL3+ne1P5ucB47tUbTyg3SEgMFh7WzFQ3O60hze6bXwUTXlHkI00PGnKN6A+OYI0xjoHScF
x-ms-exchange-transport-crosstenantheadersstamped: PH7PR11MB8502
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
leksandr Loktionov
> Sent: Monday, August 19, 2024 2:58 PM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org; Kubalewski, Arkadiusz <arkadiusz.kubalewski@i=
ntel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v3] i40e: Add Energy Efficient=
 Ethernet ability for X710 Base-T/KR/KX cards
>
> Add "EEE: Enabled/Disabled" to dmesg for supported X710 Base-T/KR/KX card=
s.
> According to the IEEE standard report the EEE ability and and the EEE Lin=
k Partner ability. Use the kernel's 'ethtool_keee' structure and report EEE=
 link modes.
>
> Example:
> dmesg | grep 'NIC Link is'
> ethtool --show-eee <device>
>
> Before:
>       NIC Link is Up, 10 Gbps Full Duplex, Flow Control: None
>
>        Supported EEE link modes:  Not reported
>        Advertised EEE link modes:  Not reported
>        Link partner advertised EEE link modes:  Not reported
>
> After:
>       NIC Link is Up, 10 Gbps Full Duplex, Flow Control: None, EEE: Enabl=
ed
>
>        Supported EEE link modes:  100baseT/Full
>                                   1000baseT/Full
>                                   10000baseT/Full
>         Advertised EEE link modes:  100baseT/Full
>                                    1000baseT/Full
>                                    10000baseT/Full
>        Link partner advertised EEE link modes:  100baseT/Full
>                                                 1000baseT/Full
>                                                 10000baseT/Full
>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v2->v3 removed double space from code
> v1->v2 removed some not mandatory changes, some style improvements
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    | 36 ++++++++++++++++---
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 23 ++++++++++--
>  3 files changed, 53 insertions(+), 7 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


