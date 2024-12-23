Return-Path: <netdev+bounces-154073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 128E49FB382
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6CA165F46
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 17:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD9A482ED;
	Mon, 23 Dec 2024 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mzxs/Z5H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7704F198A25
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734974013; cv=fail; b=XwlUmmeKXQCgE1DyQjui8n1XvTVlG8UJOToEelwgGXhUqwNWFkUeH8oJ5HCWKNkT7rt1uwidpDFuw9F8qwKTxWVdBrlMaUUTdLHY0b/vTELW8FRzaHAzCefVLPYoZHgUF9BJHZkzMVBiKw4EUYVOEOqpdcTtxtQpSMl6XBM0Tng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734974013; c=relaxed/simple;
	bh=fsN4fKtBOBpSOcbUcEH8jLEuSLtSl5J4mqNDwGbhjZ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dNjwOjYH7z+/L+zX8zojHWvYZ0WcV51jxKAY0FD4VqgpBZOY3pOoBwgNdWoW9qzbtfuWOR2NRBXaVAOxmm3gGzxr6RSonzl0Lq1bBI5P+aWoCHNz7g177AXa3Tlp/6fEQywU5MX1pY7DKxn4XqRxNVEGleWuGlKKFU8yQhQnP9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mzxs/Z5H; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734974012; x=1766510012;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fsN4fKtBOBpSOcbUcEH8jLEuSLtSl5J4mqNDwGbhjZ4=;
  b=Mzxs/Z5HAzC4qCNmiUmx8iLRCg5Qsfshkxa7VPPLaHFAs52my5y+R5uW
   l6PtO1CW/iOUD34NlDWfygHN0ZrulNxM+p9ppqunzn5iCfW3CUeYjLseC
   5QCtA7noTGuDDrM26a27cw+IShQ+fg9QqIPMHBx4sIZSJ0oRe3G332KXG
   /RGy5uK/+Vlqvo/MGZZQCd+0DhyWjTREy/q3amabUfDAZDyETXLo5l7Eo
   Ob1AsnKGesXK1Q1S/P1Hr+7DnTNbiKaHDegp1bLEciVLEagbX06zATyAM
   0b4ia0cFCU18XIqdl4g7op/yUGfJKGyzMbadeKprkfgLxsZZDVw4Jc/Cf
   w==;
X-CSE-ConnectionGUID: hQpwJ9S0QbqGR9nRT4MW/Q==
X-CSE-MsgGUID: tCzwSsZMRVu1+rfKBG6FlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="35603242"
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="35603242"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 09:13:31 -0800
X-CSE-ConnectionGUID: egdwESYoSLKEn6lOwSxySQ==
X-CSE-MsgGUID: NhoXhV/jRdyRzKgheBk9ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="130230593"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Dec 2024 09:13:27 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 23 Dec 2024 09:13:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 23 Dec 2024 09:13:26 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 23 Dec 2024 09:13:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDRnI/ExYvgeQG8uZ7KMK28jcvOjSYMNswQCZy7ecIfAycwNoqx3LfgwDTpUR5X1yFfdvwZQ/huAVj0k1mZfGdusKOuXbS8lc/MvQ2sKHIYWWPfdMYxOn0Q3txQHcV+0j+XzSrXfKNz6ZJ8dbCV6IH0aMw7z80zRtEfyThrdda9UKiA/KTfYXd/Akxs6duKfyiusCaqDWsfzWdCokyUW2q72Gcd3Nas+npT75ZsI8G3SiTX21FT7Wm1IGg9xabTnJI514xrcwzpQK1p9f/syk7UtEVjs5xmKrPBXiMKoe/jzhl4p2Z7rgl2WY08/Z8jLKZ9V7wsGJCg78ha77aZ5Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPuWvsaHvD8sIbe5mAM87b8Ldagga8g4w7K9h4jjkHo=;
 b=IFNx5ZYua99Y2jc8hFu/Rt6xWUvO8+l+DScO9VThyArRiGtZgT809sxE54AbNl6Cmfq9htPRGz2R6KqELf3C//Nca/QOm0sXptlVtuAepW/j9fLKgMHoGa6g3q0b9ZJ+XCZmRUHbOHfZrlYYByvLgaPWC8iM4j2FtZoQ/tXRJBwgrmi8ZMs+fZNlw+sexANEzUAcjD9lSM6K82i6f+tzmlU2VZsiuV1Ek0WV9H5gcnn6427mzztHXICmH8WQ1lrJu0KFlCnvyPDDLRSAHzcFb/vD+2HZlI3+A6nlGHm0rw3yv/zWNAT7uYwCTOszRGVJ+L8FJUWGg9qJF+rnBTbODQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by SJ2PR11MB8345.namprd11.prod.outlook.com (2603:10b6:a03:53c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 17:12:48 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae%6]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 17:12:48 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Nadezhdin, Anton" <anton.nadezhdin@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Olech, Milena" <milena.olech@intel.com>, "Nadezhdin, Anton"
	<anton.nadezhdin@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 3/5] ice: add lock to
 protect low latency interface
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 3/5] ice: add lock to
 protect low latency interface
Thread-Index: AQHbT5h2d07MahqB30ixVtWpdsCDVrL0G7iw
Date: Mon, 23 Dec 2024 17:12:48 +0000
Message-ID: <IA1PR11MB6241F331348234405D7E15798B022@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20241216145453.333745-1-anton.nadezhdin@intel.com>
 <20241216145453.333745-4-anton.nadezhdin@intel.com>
In-Reply-To: <20241216145453.333745-4-anton.nadezhdin@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|SJ2PR11MB8345:EE_
x-ms-office365-filtering-correlation-id: b1342fd8-c398-4f42-e0f6-08dd237506b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?vwciPtxdMyEwBgipbo2ViWjrSALPrnlrn8yoKo/eWyLAmZ+0VjrQEZl2XqfI?=
 =?us-ascii?Q?oUZC+KeG6Kty2+kmmc/spPADni9tQkAR93Q23LqGSilH0y5CGLguWG8t43em?=
 =?us-ascii?Q?91xJco5WmShJFq7Ocu5qc5TRRoaS5LrB6y+jY+QFus/aHGVihK6ivA9WHmSm?=
 =?us-ascii?Q?5NPNsYwM1PWaaPi1kzacqN+j4x1PZR0+MJMnOWOjCSMpNhBbl/n15aH4S04R?=
 =?us-ascii?Q?VuZZ9H4lTXC+XMFCx20lreE03Xrwsnsl+6TL8JR+Vh1xK/rWKxDE3j9myUAf?=
 =?us-ascii?Q?sOhXQutGB5M3M1J4F1/AtKZKXy+8Qrk1QMUq/xFx57icfuG30uvXJEV++yHv?=
 =?us-ascii?Q?k+wCuH0cvICv7oOvgSk7lRmFmKyOACU5An9K39YjZdeHrc9L8oFuRAjsaqUm?=
 =?us-ascii?Q?S2CivabPIlVZahPzYt54HywxjEsBu1wBwmK1Slm7WkKukCE4PsTfmr90hoax?=
 =?us-ascii?Q?2naceLPclcI+uWjJYGtCeZ4ynCSipdvWOsvWZxUdMX+BojpHxjXlxbSodSGZ?=
 =?us-ascii?Q?GC3IJn1LpPc2AGgPngqNt7eUMuo/kjRd5PnhuKSkuSpXcl+nZyDUZJaxwx2V?=
 =?us-ascii?Q?pkC2FGYKxqt4OpNVbKGbiR403j6w5gypfOn8JAoz2imvOUSPwrYqWwYoF+KP?=
 =?us-ascii?Q?Gpur368XuPxfPMJfXpmqlf/axohsS5RU+NMVgbsOLiDmAXzpbYJeIpMX+ZMi?=
 =?us-ascii?Q?dV8NuG3pkk0pxqiax4PO7QaP13P+0XRtr7E0PDwjJyeQIOnzrwx7NcHkmp3K?=
 =?us-ascii?Q?yzqu7Y7FNlUS1NjujxtvsOc7sVaUu91pM+sXQ0Elorge85JshXQ2k9rdT4hB?=
 =?us-ascii?Q?Ln+IOo1nHaIx8DwYT+K6+dkvABY1xjleHn67K48tilZ2sy4mUVJaprdE32sA?=
 =?us-ascii?Q?mUp3cHCpO11nZEnDAYr3HaSV3dZxHDgJonyJjs3+uEPr/mzWHBxt+a5d0V6m?=
 =?us-ascii?Q?Hv5nmbFiQyMewrLapVm4kH2Kgb51O0uwnaTA1pngFpD2PAtuswwLOK9zVkL8?=
 =?us-ascii?Q?rarmAiD4iJ1qI+ZZjEluJLU0CtFwY9ZxRvO5+DKB84LXBUsPxalpqVmlZLMe?=
 =?us-ascii?Q?AQNPRptWdN1s263gz5rA5ur+jptM+z1FGf76G9TcVa8GgQlkzRv73EpwNfnC?=
 =?us-ascii?Q?ztrpacnUIUn6NXzNoI+tu+Ci5F/ZvyQWVUs7mqColVvFpp2voQhLEAPUUbbq?=
 =?us-ascii?Q?mOqZOWVJhetszhrnEZva1iJ/zgRkwTnKUP5wAO2rAZIcRBCvy34E8ta9QIM0?=
 =?us-ascii?Q?w4gvM97uoFerVC9q1ZyOraEFNzmIB0KDtTb1nIXq7zSr27YldT160LlbR0wj?=
 =?us-ascii?Q?j6D8fIRj25nr37ELzIGVFtFPvLNBQv0Y2muOsmckZwlmqjNR4N450MwOF6QQ?=
 =?us-ascii?Q?S2eKPg8lkFQiI3uXFWoWSSH+TBolpG3kiKcAadi2rC+Dvk1UZzyagzzF3Dbt?=
 =?us-ascii?Q?8/qBHiOU1a+3ifnE22wjU2Q7dGLbv9wT?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ncDLilol6tPNR27MikQ8RNeRro6y7edRD2hv3leTwog9yPW1oKbi4oq2Uygn?=
 =?us-ascii?Q?LijF5QfkU6RmMYjrU0X66/mcCLJSdOmOB03agI7baFrKh7QV114u2hIOr+kB?=
 =?us-ascii?Q?Jzyo5X2BqBZTa3S3iFftHvEiUfrheweJkfQqv1smXl2GjNVWJms+FLiMN/0+?=
 =?us-ascii?Q?EQdoNH4eLikOUVchP/tVwNY2RINEA0o71yY3hDxt1hsBZDU+hvUkZoIEKubB?=
 =?us-ascii?Q?0dK0idXxLpQEf0pwEZIuA8cNz8akp2ZVTChXjPTSnuYht375DjHFIK1Nvf5E?=
 =?us-ascii?Q?/vKIqVzT9+hnYi8oWKusv2I7mcus72YQ2GpU+O53sCO8ZL8HosWejDL3sOZJ?=
 =?us-ascii?Q?JxEz2F5lLwg2+utmpH4ATjg15jIo1KrNYkTNR0axqUkj8G4x4WavEwqQYjzE?=
 =?us-ascii?Q?tNRFg8PQo8aCqx2gdSHJskh69Jzc/cGDp4Iccsjrj3CtEeYHTIUgECakm80W?=
 =?us-ascii?Q?LVb0v/q836GGyAijQjiGWLfdFGu1bTXaEdLcE6wkae2/8pFVw0nggcIVcwNS?=
 =?us-ascii?Q?KEee7ZRTsiQoLO7zHvZp/yFHRpzz4qx6fvfLDUY2kldwweTYZ6im25FYvNL9?=
 =?us-ascii?Q?K8YFVL9gTOQ/PS9pAu0posP/YMLSx8Zj7BNg2uYoM0t9IpU+zphRC7vd1ILv?=
 =?us-ascii?Q?F151TNhotKpYruJVgtmAFzD2rPa8U3ZBnY8vE+a/Hz7GUV4FXALHYnZE8jgh?=
 =?us-ascii?Q?qW6CVnr8iUdkWMB6s5D7YBQg81cksrrhyhnuszkQUPuv481mcqRpn3eP0y80?=
 =?us-ascii?Q?n+xV1Fq1jdapRsnPLlFltvLCOewHb/tIaOENnLoNrBy5M1ESXofKFgGGrsKq?=
 =?us-ascii?Q?MpacOFosQEtggaxMkF68C1j97y10nWw+stmLctQW1ql9pimdTyVsAcIIfaPE?=
 =?us-ascii?Q?ppvts3Y+gGFmUJ5NIPLJerinBDB8ADn/tMXmvkk2ROFIq+JzDVWzRt/IsbkG?=
 =?us-ascii?Q?Yu2aCjmI+dHDqwcIYCsGOfWejmZCQCVP99xvbUIzRM8cz7mDZpH5sc5Xfdao?=
 =?us-ascii?Q?gg+fGlkPfhWNDAvT4qGjCXo/0b5iKb9EtWyVXK6piSfR3h/AwDmsiHirWuM4?=
 =?us-ascii?Q?BJDimFusm2kzvFJgajdPP3w+EHmtoLy4tcT2gmcoxIFF8TgAgOoSu++7LfFg?=
 =?us-ascii?Q?y7tMlaRVqwKbapo386pbf/kGgmJMu1+Xn19Hd7nV7XlJ9zqYdY9Fpz2ScCUS?=
 =?us-ascii?Q?oTeXxwGJzcX/JXGhco+pYlRyTdMHxbR5doiJ1SifBYM+QSb3ip8zNWXm5kqp?=
 =?us-ascii?Q?+NQh2NN6F1qvIHMlE9nRTDD+AvyYbhpLRe45PTo26IeEXQnqVYStv3dj0VLh?=
 =?us-ascii?Q?hZt29HbfEjUP2C9BuQ6+h2FR/aT4iN4j2KTeFrDijXqAMnBjCHg/Lt9ILB8B?=
 =?us-ascii?Q?BZhW36qbCS2GSbnCUjdj1AEuqVjpYGpzgZ3QddYGa+uqfGexT0wXrmAT9yg7?=
 =?us-ascii?Q?VMJq4kuD9vlO6Zib4MI7RMYup2kGxAHUQIcwYr0nay14rHS0JFueBoXsWWhK?=
 =?us-ascii?Q?sfrdAkibAj5ucSQDq/UGYfVBpLTO5HFef8ACmIqqGWSV6GXEccKTeZtMBCsk?=
 =?us-ascii?Q?IQhLa8JlSVxXcENcnfGxcgLC4AvOFxQB0n1TsUU6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1342fd8-c398-4f42-e0f6-08dd237506b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2024 17:12:48.6851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y46j+jaCPrNMqfCJt5nw/badZJygSWdnkZOlo3dBqxjWKsgw+9mfSgpki1ghkzCZnIRnNScvo6xYRzPyFHSJbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8345
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
nton Nadezhdin
> Sent: 16 December 2024 20:24
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com=
>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; richardcochran@gmail=
.com; Keller, Jacob E <jacob.e.keller@intel.com>; Olech, Milena <milena.ole=
ch@intel.com>; Nadezhdin, Anton <anton.nadezhdin@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 3/5] ice: add lock to prote=
ct low latency interface
>
> From: Jacob Keller <jacob.e.keller@intel.com>
>
> Newer firmware for the E810 devices support a 'low latency' interface to =
interact with the PHY without using the Admin Queue. This is interacted wit=
h via the REG_LL_PROXY_L and REG_LL_PROXY_H registers.
>
> Currently, this interface is only used for Tx timestamps. There are two d=
ifferent mechanisms, including one which uses an interrupt for firmware to =
signal completion. However, these two methods are mutually exclusive, so no=
 synchronization between them was necessary.
>
> This low latency interface is being extended in future firmware to suppor=
t also programming the PHY timers. Use of the interface for PHY timers will=
 need synchronization to ensure there is no overlap with a Tx timestamp.
>
> The interrupt-based response complicates the locking somewhat. We can't u=
se a simple spinlock. This would require being acquired in ice_ptp_req_tx_s=
ingle_tstamp, and released in ice_ptp_complete_tx_single_tstamp. The ice_pt=
p_req_tx_single_tstamp function is called from the threaded IRQ, and the ic=
e_ptp_complete_tx_single_stamp is called from the low latency IRQ, so we wo=
uld need to acquire the lock with IRQs disabled.
>
> To handle this, we'll use a wait queue along with wait_event_interruptibl=
e_locked_irq in the update flows which don't use the interrupt.
>
> The interrupt flow will acquire the wait queue lock, set the ATQBAL_FLAGS=
_INTR_IN_PROGRESS, and then initiate the firmware low latency request, and =
unlock the wait queue lock.
>
> Upon receipt of the low latency interrupt, the lock will be acquired, the=
 ATQBAL_FLAGS_INTR_IN_PROGRESS bit will be cleared, and the firmware respon=
se will be captured, and wake_up_locked() will be called on the wait queue.
>
> The other flows will use wait_event_interruptible_locked_irq() to wait un=
til the ATQBAL_FLAGS_INTR_IN_PROGRESS is clear. This function checks the co=
ndition under lock, but does not hold the lock while waiting. On return, th=
e lock is held, and a return of zero indicates we hold the lock and the in-=
progress flag is not set.
>
> This will ensure that threads which need to use the low latency interface=
 will sleep until they can acquire the lock without any pending low latency=
 interrupt flow interfering.
>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> ---
> drivers/net/ethernet/intel/ice/ice_ptp.c    | 42 +++++++++++++++++----
> drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 18 +++++++++
> drivers/net/ethernet/intel/ice/ice_type.h   | 10 +++++
> 3 files changed, 62 insertions(+), 8 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

