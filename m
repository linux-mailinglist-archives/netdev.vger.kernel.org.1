Return-Path: <netdev+bounces-290309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBNKMN7SDmr2CQYAu9opvQ
	(envelope-from <netdev+bounces-290309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 11:39:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3815A27E5
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 11:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91C7D30A391D
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 09:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8AD2FFDE1;
	Thu, 21 May 2026 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fO2IctyY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88327346FA7
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779354604; cv=fail; b=emshxf4CrBXzAdJj7ZYRWgz6+Vm42Vr87Y8Dma/Q77VUlTPy7o/IB+SZY1y+//yZc3URhftvxDtP/wxDlR1i3kKt2aR8QdT16fgdw70NpPMmKEVbxYtgprwwYgrksvSMnCOGrdaaR8AoN/JEi5VT5CPaHEvXBB6F0chELiyhf+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779354604; c=relaxed/simple;
	bh=rO36S82N4xIFsaYrPvu5gMxAQ7xBngxx0qo4/A1pKmM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s0ku2oa2hZzi6f8ARzPiY2isNSbTh1AN8ioFKFp0ogpLc22Bfqy7cHqyrI2wdeHKXtLGwenKK+P3z9maryOOB83bBvtqRI2pMxcnYkqKYqBAWtbMN6tSHMrC7WdU+uzGN2AvN6RMp3r7d/w0tDEUDESwFrJSjvw2QOY6GBXq86E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fO2IctyY; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779354602; x=1810890602;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rO36S82N4xIFsaYrPvu5gMxAQ7xBngxx0qo4/A1pKmM=;
  b=fO2IctyYJR2cVvIX68RTauteAtcMBPQ4ePPxzkl0YcDQcrVsiwnU7wZF
   Z0YRDmX0Sjv/XiIfHyTNZoXG73m2Cb9Xm68lEhhoqEeZCoIYlLsR+ApiH
   r9V7pZWc8KMz/tZluQ3B0SJVegxNrutdYByaTZneyNwEg8YYdamc3JsLt
   wX2+sPGwjTFbkJlITBs5StnH7NB0IsDceD/oHNWZWTpUo3kCfShnWMta3
   L7OcSBYAzffptvygh+jLWFKhcEc5EcedcsqdXaXg8dM7qMJGocH7h11GH
   OzGZJrXcVdRPqZCphxVk5+AlPAY1R1PXN75Y3QqDq7FPlbablkDxrAwpc
   w==;
X-CSE-ConnectionGUID: cUDBDqhVTYSX+/U9K3Y9bg==
X-CSE-MsgGUID: 0yFmTrsoTnewdzlclRXrLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="97697011"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="97697011"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 02:10:01 -0700
X-CSE-ConnectionGUID: JC4Mu2+XQN+gbUi86FRN/Q==
X-CSE-MsgGUID: 21NTL9RITO6LffzyD7weZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="242275284"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 02:10:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 02:10:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 02:10:01 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 02:10:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nx67jmJONe5uqRkwBKXGNSm6gkXypFUKkp1tGSW/aHEo+0EUEFhPZa9F51j4lMg/IZAy8ZoOrs1ftcvbaK71u7w33s24us2xcMO1xR3lA1XxBpNvV3L6Ic5S36ZOK8hxDE3chtL9wQuWxLcVsfGBok2Pfj7s71AWqlx+RPjt4gB6mLmAytBll20oir95HB+z9x4Lceb1gTaeP3vRcNbmLO+96O+ucMk3dO4SbgjD5UDl7iRfAxnanDWys//TK432kaS6rA6RdgRX6oKUV0ejvXeAs/Mnh0Yav1oqrnyves/78TJjSRZMwDUKvwmS5QfItgYdVgBgVWrRA5L7bbjk3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+CGMYBsqD0HuywLYzHrqCK8dIApvWOg4VFJ1vO6l/0=;
 b=Xx/6ij2CWkFsi9RascIOf5IQ1TecxeeqvefIP+PqTBHs1cTtXw4fR8dnRLfDN/r0SS57AQ7LIs5JQRTdWbBsGlpW7plRBpCNYJoNHTRbpCLs+KIOTxV+4VLKlCbTWEB0UTu/zrkkqD5p4LBOyoccLm0av1Q+hxWvMKslaUwfUPv8bt+sVd+aiMkKGuLMPn2RsnjYdT0lJgoYYsivTh3zBmefZAoC0aUwvLgxcLOQ9zaSI+hAAzShT9f4/DnJeqCHYJBHi5AzpMqhHlbRb8Jr8Mt9Tyj0xPbJbFDe3/Rhba7zSegZ44I6Kp27kxH2mWdh/Z+ACcPYED3xVXfhAr/l2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM3PPF3E6742BA8.namprd11.prod.outlook.com (2603:10b6:f:fc00::f1a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 21 May
 2026 09:09:57 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 09:09:57 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>,
	"e1000-patches@eclists.intel.com" <e1000-patches@eclists.intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Ilichev, Konstantin"
	<konstantin.ilichev@intel.com>
Subject: RE: [PATCH iwl-net] idpf: add padding to PTP virtchnl structures
Thread-Topic: [PATCH iwl-net] idpf: add padding to PTP virtchnl structures
Thread-Index: AQHc6P/dEz9u0tdJvkW3+uhIr6bm+LYYMDjQ
Date: Thu, 21 May 2026 09:09:57 +0000
Message-ID: <IA3PR11MB8986DD03917F2DC45EFC77C8E50E2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260521085428.117991-2-przemyslaw.korba@intel.com>
In-Reply-To: <20260521085428.117991-2-przemyslaw.korba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM3PPF3E6742BA8:EE_
x-ms-office365-filtering-correlation-id: 5dfd2b8d-1527-46a7-4553-08deb718bb06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|11063799006|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 5pv9Yrq+sEJig2+EntTP3VJcxTQkG7W4hKzhMrRQ2NcMMLMWmoJw43XtiwQd3gvz4EnZHl6dCF+x48lk0IXAdbrAnqj85UVnyMev67B2ljPvxROly6k+lJklv6R1+mXLOfGt39VkorxXnSy3Cu2EnyEZ1BYfuIXIUEf6u0qVVLtJBdK1A2wfj65kahCHZn639AVwqMZDm8SwhTZG/KJnDHmN6NEKn5MNiaZ2nJywOAlju4ZEsyggsOud2gvjncipXjvc40pR/aWfPBvltl6nzvIli1EvleQ3RWs7Fjt2Zdx976uiRS4NXKMAIOcHFg2xU0skCQDRgcG2u4NoDQoF7hUb2Z+sGa/bZlAaDdJM4IfQIxvQSnnoLuygEo7qUjlUcua43Ha9AAV5vxu81yyVbzHOVaLgPlO0omq+GV4rR/MZtzOONxODTjFXC1/5VKqgyGXbm9nDd7/Ld0LJVqwN1fT9hEj/fNeiGRdOagUapZkKTypoyoIGbKM/7TBolKPqaEY9rL7HG+3GPd/UpQXpLviJQMbwTtnkya/KFrWQkBVgSQ2aUBMMFYPKP0x3oeh8YinR50S8O4ePhp2L1Wr4l5yUhmcZJEG89fiEIxqXCBkZkrs0Lx45g6HOzftzk0zQINpFs/d4hEi2zI1XqDyw9olF8/ODgUaViPWomQHOGAiaRKvWqKh1inC+abExliCGFb2c3y/wMmduawNKmU2cOQ83q9IfyOEe4IUdnM1A27R15IDdw0pQqoMJYEaSZnuH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(11063799006)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QG8gtw2K3NnGgd8/rcvThhsXG3dYdwmFlo5zG1+3AV1UdrV6jTmEoL7IPM1p?=
 =?us-ascii?Q?0tDkQXWLuhPpRJFh8491jLcu0a2gCwJS+kpcQ8pUWecuA8x/vswws5teZBeA?=
 =?us-ascii?Q?JIa05Yh7DcdHJ8n1kbhAOHh8K3WYd48uDW8n0GBLTDZQJDAm8O3z3tO9dVSS?=
 =?us-ascii?Q?oMirwZdgcoNoEqghf7Gik3hnxexwnuS3yn9ObzpIAT3KVbOp86DOFPcNqmqe?=
 =?us-ascii?Q?Lo7mFTJejN7FRX+NDovrmYbJjM+c9qEzKEJ9T3P/3d4Dwy/352aAVC9wDcLL?=
 =?us-ascii?Q?ae0AqpGLNuNUtzfhSXzEBtkDeVmo0V77PK+GheBMcNdhyDtjnOu1Q/5qpeyc?=
 =?us-ascii?Q?sS/10cqQgCwtbQbu7qILoWMD7mswbe1poTollZkzzPrDIg5EugXgmENS0XMd?=
 =?us-ascii?Q?7NOcXRKJ76vbD7PKTMaYrDDkQ9pTGbE7la17VO0E97gyX3KLO4c4GPZG6DSX?=
 =?us-ascii?Q?ffuwNLS283iWWLf2qdJBIUudZhmsYOjBoWAuF+P3PCTGF41LN0Rn2hMtmDeV?=
 =?us-ascii?Q?l1QvxKZtn43r4IEELzDS49YU5FI6DnJQ4YLaLjglkLLaqSk4P8ByDOpSjOV+?=
 =?us-ascii?Q?JchEkUh7prxXu4sU89gJLIbhuOnXwQMyWW91CrN6OBKB+8Sln1WZGPHfX3p8?=
 =?us-ascii?Q?lfuo7kWdb0Oq9FDAYWSTuRllmRSLn6SUJj4mX/hJ3c6ULPRzVeQlr5sD2fhp?=
 =?us-ascii?Q?JNseNQmwGhjMmNJRgbu2ZWa0vhSrTm+qWUDdjSA95AK/kovv56pzQU+mhxFk?=
 =?us-ascii?Q?5k9qnoG2I24uMaVWVXOuKDB0dahQSY1EiRLN5PSyYql1zuQ4fLDQPhfinz0n?=
 =?us-ascii?Q?LQVtDd2n4iW+noEJgaPpODj3FCcO3EoWtt5hSKfP0BqmIRo9kCkbi6xHCknz?=
 =?us-ascii?Q?8Y0ebIMC/uXVOZ6XaqwcA/ZKuNNtPLqBRNDfuNs2+8j1h40x6harUbUtk2LH?=
 =?us-ascii?Q?HfhBi474C7OE1Ez2KLubY2Q8W7qbK/8c5uU1iIxP3V7kw/RVOTiJrljS03YC?=
 =?us-ascii?Q?Rxge+6+vR02W0uYzIjPb6LLwdAVyWFDCMfS68JL/XyiZ+gQv8KwmmW0Q3LgW?=
 =?us-ascii?Q?ItwFY66ODjxhWjYI3of1MQvLTC6pguCixF7SbW5gSxik9MBlomstQ7gVPgX/?=
 =?us-ascii?Q?l5JBMEeptHeQmi+NErELYtir2o1nkyoYeEgx9z5ERI5asAUKQM03ZBxMi5nN?=
 =?us-ascii?Q?ZmrwNFkBWkQtRDSWg7AKvI/8Lw3hTZonn/MY6zqEtFTI5OChCE3y3bOKQLBr?=
 =?us-ascii?Q?BO19UcvUSFlnheJ2jXQ3th2NWoqeXz4SzJW1yFnBox2VyIUf8sHLddiJru50?=
 =?us-ascii?Q?GAJ0DangQKm5kQyG8vnTz5Su6aPY+6YdAdxJGmmzxm2VawfMxh2SP70GqVu8?=
 =?us-ascii?Q?CXAx3A2AANDLX+fKeyzd5EPdzoGAROGgz6F2B3Il456K81CoIvmCv+p4iNqD?=
 =?us-ascii?Q?Fh6L1Jy+fHAuTvKUeMoMY7qTSfapdZ8R3Q3G49/PTPFtBhP1clXbXVJWHc/a?=
 =?us-ascii?Q?Jwkqu2GFl1vO9TVkFg8jbxsCzbaZZIVq/UGGSkCY9mvPX8jdRHGi8u8UJu+N?=
 =?us-ascii?Q?7EGAzBy7tl76ojx12Pry2hDOWtjajNBi2v21zwL9kDCN7X0UMGBEVHcmluQk?=
 =?us-ascii?Q?0ArTzENOBe0HIlWAZ6JzgHDDxMTZyh4WZcA5xUtsUZJRvZ/dsmk/R15iRJ11?=
 =?us-ascii?Q?r8wAvLTiRLje+Dwieu13NuzLPjAMQK4R2gpbX9+lzHpQl+jVczo0z/tJD4ER?=
 =?us-ascii?Q?yFWlz1ah9oYK0E0u8YQFtOsdPkqtBEU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: P2Np3tPNtYKNeq7mOhJQUz4Uzopno6eARgPs2FaiAodkLF6GAfNmFc2d0OB/riT5Z9w9y/46P2DzQTfTzSrAKUNB3eTouwYupX+Q9CfWHXpcdwVizBzwoM1r2j07ZZbk9j9kxtbGti3aarjG1g3fbxMt5x/Bzxmxxnh6GyWEcDgGC7iJadMGqTCkFAkb+zWlBe+xJ+IUUvQ7zdDEJFnIEgXyadC6jNtf+HDzDnDgQXG7Zsmfy+I7APVYtiFDfC3p2yv96x95Xu+oTQtkPTLmbhSzeHrS0V2aYEe/e/kRoSkYtOar/abpOVlfVaRqC6OL+KZ+EqQ2m69N8tFKh4pTkA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfd2b8d-1527-46a7-4553-08deb718bb06
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 09:09:57.7917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TqA9RDu8jnyLb1HySaC/l9j8vG+w+MBeTrqdpI134+XQ3A4AE7WaGANM8amx6rIKbxyRcPmAN3Ij6Jw5qQtYg8NB450zQH5gzMKtvZEoUYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF3E6742BA8
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290309-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,IA3PR11MB8986.namprd11.prod.outlook.com:mid,intel.com:email,intel.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3B3815A27E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Korba, Przemyslaw <przemyslaw.korba@intel.com>
> Sent: Thursday, May 21, 2026 10:54 AM
> To: e1000-patches@eclists.intel.com
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; Ilichev, Konstantin
> <konstantin.ilichev@intel.com>; Korba, Przemyslaw
> <przemyslaw.korba@intel.com>
> Subject: [PATCH iwl-net] idpf: add padding to PTP virtchnl structures
>=20
> Add padding to virtchnl2 PTP structures to match the Control Plane
> expected message sizes:
> - virtchnl2_ptp_get_dev_clk_time: 8 -> 16 bytes
> - virtchnl2_ptp_set_dev_clk_time: 8 -> 16 bytes
> - virtchnl2_ptp_get_cross_time: 16 -> 24 bytes
>=20
> Reproduction steps:
> On ACC, run: ptp4l -i ACC_pf -m
> Observe: failed to open /dev/ptp0: Permission denied
>=20
> Fixes: bf27283ba594 ("virtchnl: add PTP virtchnl definitions")
Please add Cc: stable@vger.kernel.org

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/virtchnl2.h | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h
> b/drivers/net/ethernet/intel/idpf/virtchnl2.h
> index 02ae447cc24a..ba953dd5fb67 100644
> --- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
> +++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
> @@ -1572,13 +1572,16 @@ VIRTCHNL2_CHECK_STRUCT_LEN(16,
> virtchnl2_ptp_get_vport_tx_tstamp_latches);
>   * struct virtchnl2_ptp_get_dev_clk_time - Associated with message
>   *
> VIRTCHNL2_OP_PTP_GET_DEV_CLK_TIME.
>   * @dev_time_ns: Device clock time value in nanoseconds

...

>=20
>  /**
>   * struct virtchnl2_ptp_adj_dev_clk_fine: Associated with message
>=20
> base-commit: 4548d565aa80aad80274e2f3bff4d7cd914c703e
> --
> 2.43.5


