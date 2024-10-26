Return-Path: <netdev+bounces-139366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 021699B1A13
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 19:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847CD1F21D6E
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 17:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55291531EA;
	Sat, 26 Oct 2024 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUSGM3S1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9485113D521
	for <netdev@vger.kernel.org>; Sat, 26 Oct 2024 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729963753; cv=fail; b=fIZYJ5eALnktEp6FRXDwIJtrtMXoLrU9Le1DPWfi3LI+ovl3/1WwAgkBC7RzfUj0KSU7daTs3kO60WqURFv+BFNej8Pom5qIAcfUOLcmUGw9LonVlsxXj5unTwVIl5PXpFVdOUaZByPtS3QGLsUQVfcpJBP4rR+ngXnTzZ4LgDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729963753; c=relaxed/simple;
	bh=/LQJ5EM0srQCHKsWHbeUprB1O9Jbe352ThYN1KTTKNM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qaXSDiwnrI/lMVO3bzQLFWsoGhOf5641c0hjBYXF97khlVX8QygWlTQXBrax7WchlcI7vIesusnN5nfazRKduaGb2ytYT+09wBRpXSZntALe1m7WmEx3KCZTUsx2NnEu6QLG7jAoqu3nZREA2OqwnCNyFobTir4se2L1+c2KuBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUSGM3S1; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729963751; x=1761499751;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/LQJ5EM0srQCHKsWHbeUprB1O9Jbe352ThYN1KTTKNM=;
  b=RUSGM3S1MEiAks6RRa4uPsIWzInjMherlvwKhilN13cpNk6ROhWEE93N
   6jenpJW8/MA4w/RjK9zTkaWZ29qTuEysIPaY6UKu3q6ccO5OSWpM6f1Hq
   bZdJooYHPqMIcx1q9Fvyhbfys6/imerouOqQ+/f2UfDTe5xcEcDh3epYn
   WsDram4WKDcu0qsxKjFqOATLxFB+wpEx0kBqZlBfD5R4Okhb7FWSGoe+M
   sBNrDlcnmTCljCMzr70NeilXD8yCpN4ZbJGL06Ri+4C7kvYworROxrgLn
   riL/51WNHFMaty7BbKoIZFgNLeQdiedr9Rxz2LCBHvT104MgbQHdo7f84
   Q==;
X-CSE-ConnectionGUID: RWSHGiSNQ76ybFFe5BIlEA==
X-CSE-MsgGUID: SX9blicjTVCn9CRZ824wKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11237"; a="40990028"
X-IronPort-AV: E=Sophos;i="6.11,235,1725346800"; 
   d="scan'208";a="40990028"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 10:29:11 -0700
X-CSE-ConnectionGUID: Ut7q/83VRwiW+YNcmU3jBA==
X-CSE-MsgGUID: OtIxvmDeSsyDmBtQHtpRHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,235,1725346800"; 
   d="scan'208";a="81166584"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2024 10:29:11 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 26 Oct 2024 10:29:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 26 Oct 2024 10:29:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 26 Oct 2024 10:29:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXI1sMVoe52eSN61AKbYZcRlpfkvfvBi4FZnUYfABp/IBeXXY9WtYgAM6xlyXM1tALotZzxISxCLklarNSLFiVP/nQbmT8UYeikvgC1OzDlQD206CFWj+/8kAupKlNgGuujASsOXR/wo7mCFahQcyxPghc4j/XkV+e/a97HtE+SIPz2cBeajPbDeAr1Beyb71ww+ZNhqCKq7I/V2WiPGG9zg5If4GE0fOHafmaXw33p7zSocZ0ZbmJlGTUY+Dj0hUO+aM5Vp1vSG0wP7UsN4v9CQJM/nTgqP5aeBFTQQ91gYM13xjqVmE8dOKgpQGU9hI1odvyNocNhp0zgEoZOJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LQJ5EM0srQCHKsWHbeUprB1O9Jbe352ThYN1KTTKNM=;
 b=ptvnTPJdHCy+lTbb1wNrNsTgrSMozWaDeSEf7gCm4QllFvnhMm3vcIHYPPqrtgbxHhFwXp4XTvSMBNzW7gpSLKCRF9Rd34wMsGpBUzu3ua99hS/uliZGxDnrBjZ52zasPWHX8ScqGtYyizdqTXBoVVOCCTbm9svumthKqZEZCRUrV5GGgKrDC7a6Kxb/AKoasL2FVDNaIOgG1kFcArbM2Fguht/PxAsFqnqNCmbWh87M/135lEkZVoitlMYk7gj7pBF6ApdomWqKj0tuFum8pR7eufliJso+q7VRWRGhCOtYJ3u8Pg8Pek610QCe24J++yrtaI2dc83eX7cO8Dirxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15)
 by CY8PR11MB7315.namprd11.prod.outlook.com (2603:10b6:930:9e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Sat, 26 Oct
 2024 17:29:01 +0000
Received: from IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::f302:c534:2d71:822b]) by IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::f302:c534:2d71:822b%4]) with mapi id 15.20.8093.021; Sat, 26 Oct 2024
 17:29:01 +0000
From: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v2 iwl-net 4/4] ice: Add correct PHY
 lane assignment
Thread-Topic: [Intel-wired-lan] [PATCH v2 iwl-net 4/4] ice: Add correct PHY
 lane assignment
Thread-Index: AQHbGyAF+AlQjiSKBku/BfycemKQAbKKEDAAgA9SkCA=
Date: Sat, 26 Oct 2024 17:29:01 +0000
Message-ID: <IA1PR11MB6219A2079049AF36228E9FC992482@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20241010142254.2047150-1-karol.kolacinski@intel.com>
 <20241010142254.2047150-5-karol.kolacinski@intel.com>
 <e2ed6973-cccb-46be-b847-3f18c85b3bf0@intel.com>
In-Reply-To: <e2ed6973-cccb-46be-b847-3f18c85b3bf0@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6219:EE_|CY8PR11MB7315:EE_
x-ms-office365-filtering-correlation-id: abe01aeb-e30e-4fdf-2c1a-08dcf5e3ae79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YzhXcmFqamtSdEl4MWIyc1dRMllSK3g0TjRLR0ZOQVdrRDkyMUxJdloxcVVl?=
 =?utf-8?B?NVpYOHF0Z3J4SUt0TytKK204SkFxV0JZcXV2bVF6aXRzbDFNWUhjOWRueERV?=
 =?utf-8?B?NXVmWG9ncnlyLzZpZ3E4QmxBNE9DQmI4QjYzVmFSZTNCVFhvQmpXWm1VRGZx?=
 =?utf-8?B?UU1GampRNjh6dGdhTlh1VDFLZ0U0L08rdU1HZ1M0cUlMa2dnTWVBb0R3aGw2?=
 =?utf-8?B?SUdvZTdUZWd3ZUx1MEVxUGdMWDkwekxvT3NhR2RNcWJYczA3MXpqVkcrL1NG?=
 =?utf-8?B?SlZsT2JFVk9EN2o5NzMvUmpUZEFXcHJwTU15dXN3eWt1U1Z2ZzRpTjVDY0pn?=
 =?utf-8?B?ZDB5UmVzaFRzSzlnTnpyRCtpaGpPUGx2YkhnaFlGZTN4MTgzUG01UHpuUG0v?=
 =?utf-8?B?WFZIN1VKbzR5U0lCSnZoSHo1dGJxL1Z4SkRHd0hyR1RKN2tubkdwdStMQVBh?=
 =?utf-8?B?Ynl6UjJkZzZXV05XSnZ4YzJjRkpGMWd4dGRYQWVFM0kxSDZSTzBiQlFhbS9L?=
 =?utf-8?B?NUJJb0xZSzRZaFJzbTJJOVpqVXZxbTZpbm84SHlueE91ZlNjVUZGbWNiZnZh?=
 =?utf-8?B?MlU4WDVYSHBUeVJibjFZcUFPV1V1Nnd2VXhqdlBuOHFBVTlLbW1HTHRQcTJL?=
 =?utf-8?B?SWhUSUZhSlBiWXg3bDdRWURubmRKcFJpWWZCU2wrL3hYMXRMN0N6SFFETDFH?=
 =?utf-8?B?RWF0RVFIRzlLTWlTek9QcFNpajdmbUhRVWFxcXZ0RzJRTWhOY09mVDJUVGtE?=
 =?utf-8?B?SWxWNUJxRVZnR2pYNk9wNEJnbm54SkZvQ0lha2lwRkJxVldLeldZeTBPZENE?=
 =?utf-8?B?Y3ZNVVJsYkR4eXFMWStnK2V1LytNT2o2VG5yeTkyaCtQWk80d1NGaFhJVFcv?=
 =?utf-8?B?Y2NVa0JtOGJOSWErV0RyNU1BM0oxV25CVWNhazYwcER2WTlGckEwcERET29Q?=
 =?utf-8?B?VSt0dnlZNWZCWEFCaDZVRDBPWW5MM0hERGRvaDRtQmluaVJZbU9Ea3h3R1hN?=
 =?utf-8?B?c1A0ZVowSjVKZUpoNHF3OWJ3RkM2MzhZUndhUnVneEljQWx1WnlhMWpuNWxB?=
 =?utf-8?B?NUUxSkVrV0dSL2ZENTNCd1hIQlVrckRUZmVIVWx4UGgzRDlMZTBUaytYbzBW?=
 =?utf-8?B?cmFYWG4wWTdKK1NqTWI2ZXFQd0kvTjRRTDk3VWV1NDkxZG9oVzk3eElFNzYv?=
 =?utf-8?B?YWd0TkhOUlJuRmtNWm9EOVRmUTFZWUhtRERYei8vYnh4SDRHaTdJaG9sYUI2?=
 =?utf-8?B?SzZjQ0x3SG0yT3BVckZWSUZucUxuNmhhQ2phTmUxdnR4QS9qQ29VTnRQUHB5?=
 =?utf-8?B?cHdGWkRwTnNhTUpJL0haTitIRkc3Y3BqVnVmaXRENStkVjBJcEdQcnhXTEhP?=
 =?utf-8?B?MXh4R2FjVXBpT0o5a2FsZlNqd0UxdUNzUmYzQldyQnU4UlNaamdZRUxRSTBy?=
 =?utf-8?B?dEx4WUxjVE5wR0RJWTgweDBBY2xQWXQ5aVlEZkNaUVpuRmprMm93RFh2NGR2?=
 =?utf-8?B?MDQ2Q3VPNUV2RGpHdHRsdi9aRDNEcG9rRXJ2MGZsa3kreHRLaHRUNGd1ZWVi?=
 =?utf-8?B?ZFRETUlqWVlpaytuWWE3ZjIvaldyQm4yQUxsVkpHTEJ2VXN5Ukd4b0U4UzNq?=
 =?utf-8?B?N2pMWUdESWJxK3hQTGN2bFoxcEVIOGRKS2J2ZmpCU2NWQ0UyOFNCTlplS3dX?=
 =?utf-8?B?Vm96VU1tT1cwQzRjNU0zNWpKZEk3SXFxRlFzWDRqSFg4dFcrYW93cnY0SXdH?=
 =?utf-8?B?THE1a3pWdG10UTRTUzJXZjFhOGsra3dQWk8xSUU1R21CRUUrMkYybVNxbld1?=
 =?utf-8?Q?xCaYWLg0Nszz7UmRwlryw29Hc8/jo3j+eEQeo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6219.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWJjNklrS2pKTU5abGxyRGIwUzRzU3NHejBzWUJITys0UUZJcitIQlQrREJQ?=
 =?utf-8?B?TDQ3bnhNM2J3TndMUUsrODNSbEUrNVI1Z21sWWJQRVRmWGhyMmZpWEF1RWZy?=
 =?utf-8?B?SHljenFtV1Q3U01FeGNCaExDN3FYMmRwTFpIbEdSYThwTXRZN1diVFlNRGhl?=
 =?utf-8?B?SGJpNTZCN0xvN2hxeGlyenQ4YnN5ejhjZFNOR2syUEdZNnl0T1VVYWVTK1VB?=
 =?utf-8?B?ZU9iYU9Fc3ZXci9ibS8rdGV1Z09qMUFDak93cW5tYWlYNDAwUGFYVXUrcm4z?=
 =?utf-8?B?Nm1sMFdVdWhTVDZKR2Yzc3cwVUxqS05kemIvREQ3cWp0M1hMRSt0OEcvRDQ3?=
 =?utf-8?B?UkVKRFdLTUxEWk1Da3lxUTk2WWNMMDYxTGUxWEtUVEpaWEUxaDlyQ2EvejNk?=
 =?utf-8?B?aFEyS3hoaUkzbzFra01FaUpGRnJMOG1QRndvUFJGaFdMdmNZTFlSMmY0Sjho?=
 =?utf-8?B?bFpPdk05TGlCL00zbjdYS2UzdTdicWVVMVh4L0dsUEN5dmhJdk9Qa2hTa2hP?=
 =?utf-8?B?VWVKR0RRK2RmUnk5c1lqdTUxdlYzZXBlTTVPSldYcmdvMVlVb2dHbXRkZkNH?=
 =?utf-8?B?YjJ3YkY4MkJ5R1FoVWFYcTcwM0RhUENpWkxrazE0a1E1OFljb2FtWmkvd0FI?=
 =?utf-8?B?U3lELy9hVDJyVytFcFZCdUFsS1ZSVnZVNFlsZlV0S1lzOFFIZS9nYXJFUmcy?=
 =?utf-8?B?WHZUdkxjSWhnSnEwbkMzbzVOSDNKQUFLTks5VXJiTEZaVTNZNk9NY01DWmp1?=
 =?utf-8?B?T001ODJ5djF0SERRbS9wbHc2Yld6MmdLOXZIZzZJTHVNdWduQzFaRks3ckFt?=
 =?utf-8?B?RithdzRodmkycDgvYmVISnBoWGgxNXBlOUtDRVBUeXhDaEpMaVR5UDV0ZVRa?=
 =?utf-8?B?VnNjTDRVQ01lZUhCdWRRQ3J2Y2R4L0VsM3FYZHU2MktmcytJdGxscElhTG1u?=
 =?utf-8?B?ckVVMFhrZHM3UEdrL0dqOVlxcUc3R1U0MHRCejR0bWJpZ05odGdQUVZpY0pN?=
 =?utf-8?B?MC9Fc29nVzVYNEJ0U3NONFpSQisyYlVqKzI1Q1FkN3ZkTld1Z0pBTk9ncE5z?=
 =?utf-8?B?NFgwZzFyV2IwUzhmM05tb2o0cFlEVi81NGJEUGhRNWRzZmJPQWhSaGJjUWZN?=
 =?utf-8?B?WWVkbkkzSkdYS2lZcW03K2JMSzJHRERPdFlmaExwMHpSWVNXd2RLWURJblNn?=
 =?utf-8?B?YkQxVWl2SWYwVHpLcFZHdS9zMG5mZmduWE9mLzFENmZJY2d0SGRaOU5JTGE5?=
 =?utf-8?B?RjJOcVR3SlV6R0Vsa3RBbkJGSEdEZXUvNW02R0pzdFMwcHJFVllUWG1rTUov?=
 =?utf-8?B?L0I3a2RqcmZNRTRwZlVLNG5KSTkrc2ZNOVlHdGZ5aENyKzFhOVY1Y0VSdG5s?=
 =?utf-8?B?aFVUTlBjb092M0ExZ3FyRmZnc1Y2d3dzaXBXREJyeFdNKzhCa21NV0c0Z2dN?=
 =?utf-8?B?eHlnaENJcnhaVnc1RkhyWGVURFRHTE5vSXdMRWZma1ZyY0NpdVhnMTR1NFo0?=
 =?utf-8?B?YkRUdktsU2ZKd0pBRFZtUkV2K095Ryt1OWNzYmpSWHZNTzVtNzBzMDNSRkw0?=
 =?utf-8?B?Qk9rd0RwRXdydEZnaG9DM2NmK25vNmFxK0UrSm5qZzhFd3JZdWdFWkVUNklt?=
 =?utf-8?B?NW1ZVlRWODB5VXpucitXcDVoMXc1d2gyZmlJdE5wUXh6N1BrL3IwU01zb1pu?=
 =?utf-8?B?Y3NGRVRVNnBvaUQxcXRwaG9JMDZOME8wSjF2bVd3U1dwVlRyYis2M3Rsd1lp?=
 =?utf-8?B?bTJBa0EzZzNSVmwvS3NHS2VJMGhSeWVhN0xRWWE2K2h5OWpwSC9ZZ0pPSXh0?=
 =?utf-8?B?dS9yMHYvSjk4K1VKenp0bFhvajF1dWUxMjJPVk1IdEtjN1RCR3B6ZWtWRUtI?=
 =?utf-8?B?akc1aGo5dXJSSzRvMHU4Q1djL0lHYmRFUHEyUlF6VEJIU0x5dHo3eHFJQ3Zi?=
 =?utf-8?B?TFdLMThheG9VTkRLT1lCNzVqSjE4NjF5alVVZVRtcWVSNStFTkNUbmw5YTVW?=
 =?utf-8?B?KzFHSGZkWUlGVDNvWCtqc2FQSUdrblowZVlhcmlseE1pSzZjOTJIMk91c0dt?=
 =?utf-8?B?dUg4MC93Sm8vVWsvdnFFbmZPejZIcFJpeWpLYTZKSGF5NlVqdWR5UDJPelds?=
 =?utf-8?Q?iuZdB5Y15AiNZylRp7/WlxnWg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6219.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe01aeb-e30e-4fdf-2c1a-08dcf5e3ae79
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2024 17:29:01.2915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uNRjMBU0/qOnNhyJJgmX7LqmgQBAnc5HDRNno++R3J3baIF2rspnyuVwkltKua/XRP6vze3JqGxwDOu+xd09SPI9yCzOxuEuV2nfsrEI7SI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7315
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYgT2YNCj4gSmFj
b2IgS2VsbGVyDQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDE3LCAyMDI0IDE6MjkgQU0NCj4g
VG86IEtvbGFjaW5za2ksIEthcm9sIDxrYXJvbC5rb2xhY2luc2tpQGludGVsLmNvbT47IGludGVs
LXdpcmVkLQ0KPiBsYW5AbGlzdHMub3N1b3NsLm9yZw0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVs
Lm9yZzsgS3ViYWxld3NraSwgQXJrYWRpdXN6DQo+IDxhcmthZGl1c3oua3ViYWxld3NraUBpbnRl
bC5jb20+OyBOZ3V5ZW4sIEFudGhvbnkgTA0KPiA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+
OyBLaXRzemVsLCBQcnplbXlzbGF3DQo+IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPg0K
PiBTdWJqZWN0OiBSZTogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIHYyIGl3bC1uZXQgNC80XSBp
Y2U6IEFkZCBjb3JyZWN0IFBIWQ0KPiBsYW5lIGFzc2lnbm1lbnQNCj4gDQo+IA0KPiANCj4gT24g
MTAvMTAvMjAyNCA3OjIxIEFNLCBLYXJvbCBLb2xhY2luc2tpIHdyb3RlOg0KPiANCj4gPiAgLyoq
DQo+ID4gICAqIGljZV9wdHBfaW5pdF9waHlfZTgyNSAtIGluaXRpYWxpemUgUEhZIHBhcmFtZXRl
cnMNCj4gPiAgICogQGh3OiBwb2ludGVyIHRvIHRoZSBIVyBzdHJ1Y3QNCj4gPiBAQCAtMjc0Myw4
ICsyNzIzLDYgQEAgc3RhdGljIHZvaWQgaWNlX3B0cF9pbml0X3BoeV9lODI1KHN0cnVjdCBpY2Vf
aHcNCj4gKmh3KQ0KPiA+ICAJZXJyID0gaWNlX3JlYWRfcGh5X2V0aDU2ZyhodywgaHctPnBmX2lk
LCBQSFlfUkVHX1JFVklTSU9OLA0KPiAmcGh5X3Jldik7DQo+ID4gIAlpZiAoZXJyIHx8IHBoeV9y
ZXYgIT0gUEhZX1JFVklTSU9OX0VUSDU2RykNCj4gPiAgCQlwdHAtPnBoeV9tb2RlbCA9IElDRV9Q
SFlfVU5TVVA7DQo+ID4gLQ0KPiA+IC0JcHRwLT5pc18yeDUwZ19tdXhlZF90b3BvID0gaWNlX2lz
X211eGVkX3RvcG8oaHcpOw0KPiA+ICB9DQo+ID4NCj4gT25jZSB3ZSByZW1vdmUgcHRwLT5waHlf
bW9kZWwsIHRoaXMgY2hlY2sgZm9yIHRoZSBQSFkgcmV2aXNpb24gc2VlbXMNCj4gbGlrZSBpdCBp
cyBtZWFuaW5nbGVzcz8NCj4gDQo+IFRoYW5rcywNCj4gSmFrZQ0KDQpBZ3JlZSwgdG8gYmUgcmVt
b3ZlZCBpbiB2My4NCg==

