Return-Path: <netdev+bounces-162355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F25A26A08
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 03:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA58F18859D8
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 02:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D4A13B284;
	Tue,  4 Feb 2025 02:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fsgloXEG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C744523B0
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 02:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738635740; cv=fail; b=N9FPW4XFA/PwSIS2bqhD/BI48pSxZhbkzQcSiegiCAeOsu59HWvOFponAQGr+VjCTMIAuH7RClNWpvtn/pPi5kWn8zaDiRqySWq9DZu+ymlDqt27IxVMERIyK0cFiD6Zqh8tiSn7t+NJkk2mJJ/z6pZ7u0Kn2KIKsjqcqFYEpgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738635740; c=relaxed/simple;
	bh=MEfwaV6Y32pVFG7bnAZ85Tn3/N/v8y7Pqgn+SDNezVs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aBMQf/p+TNRfVlDmJxS66CCRdsOFdfjryxPgREgCpI7kpyAgJ5pgu61zdF/CPajdJRbRS+4lBvd9CGU6/Q4BloAsDHIzKybeu4N1fyLXk+DoxVnrqrkOOLejE02AH/Jh3iHRy5HGrprUxEBZcPYxQC8Ft9VMSregBBo3Eg4FVoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fsgloXEG; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738635738; x=1770171738;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MEfwaV6Y32pVFG7bnAZ85Tn3/N/v8y7Pqgn+SDNezVs=;
  b=fsgloXEGixCHaZQno37WNWzyKhvpdj09wZbZg/oHbegIvWQx7eZWmfQ7
   idjAPQp9s8Hqd17IuB3vuotExzFW9sVdff8Mu/lTcwp3aUynjiBpsKWeW
   UjpY/HDcD/9PaFtS7Kl5mvFXTbJOY6mhZzFILFWuNtpKn+t2yNArQazey
   t3OKqTqGAytE53xIms+c2EoWPt61DpD726syLDGZ8hswfqeEvoLiB56z6
   KGTADrrtOtI93do4Om0AONo0QxjlwIdmv68Tu2AuZz8gA2S5t9ooQFixY
   nnmbuL4VUR69CGoTszpFayhS9Au4M8mUm/0uvVPkR4SCIpWfUq1RQ8anY
   g==;
X-CSE-ConnectionGUID: b2TWHjrxR7Gjr6GGwgo4pQ==
X-CSE-MsgGUID: o0tZAs1XTwSv+ilXHJxzpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="49403659"
X-IronPort-AV: E=Sophos;i="6.13,257,1732608000"; 
   d="scan'208";a="49403659"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 18:22:18 -0800
X-CSE-ConnectionGUID: FjJ91I6/Q2GYcvCKggHEBw==
X-CSE-MsgGUID: sn4/rPlxR8e4qSsL7r+RhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="141304583"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Feb 2025 18:22:18 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Feb 2025 18:22:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 3 Feb 2025 18:22:17 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Feb 2025 18:22:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbwq72VRxLOsmcdYVm9Jz1cfKxG5eH7cpkr8n7nmcfT7OCjT6AykNN2MqIeJxN9US2Uko2fldK3A34J2vpN6WRFmefzQQXTMBH7G1aq4OtZE36U53wiZhk9FO3xRQPELEOlo4cXkdnoCM5FS5jctwMFjbuzubWPJUtDPGfT25fLQzANLjT0ZLJzx50KmBChrALT8/3eFGTmfx5WQ1az3yy1iOidNIlnVPhTYj3nmUcGM7qCC19SrWj7+ppRWPZW5zPpLTJIfNIcaizc0Q+ozprZKnlcy5umTkheH8uO4ALed3WGrBg0KAXe++zS/ZjOkLW53RyE5EMEm8R0DW/QJVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEfwaV6Y32pVFG7bnAZ85Tn3/N/v8y7Pqgn+SDNezVs=;
 b=SpCxy9RT+63ua28iKZMLQHlZcY3bfNmesLQvWCTXnFHlkLwXz9sjTaIJlB1kmRmcIMWOQ+8GuAxBJ/Il4QGjZwNedmNGeTkjwP8vNW3Z1Kksae/OwnI8sRQF84gwDy2ZfDN8w7Da3oy48kWlzGA64ofxXPwbfX2/hX/0s7z8JzZ5NQX8x8t99hMwEqBshZkmnM8EK6ChoWraDZpA4iQ0Oyirtx3x8xfiQF/RX8vO2UT48ehbqq3t+OUYVKztmMk738O81uAD79miQ3dGq7Eahuw0KwMVtm1dj5BjpV4g4dZjOj+1uwJWSWjhHfscD4s2y1yK76O0hiTQuFNVfKnd8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by IA1PR11MB7368.namprd11.prod.outlook.com (2603:10b6:208:420::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 02:21:48 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%7]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 02:21:48 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Chittim, Madhu"
	<madhu.chittim@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] idpf: record rx queue in skb
 for RSC packets
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] idpf: record rx queue in skb
 for RSC packets
Thread-Index: AQHbY7jGAyw0AWe76UyEiItYvHAexrM2jdyQ
Date: Tue, 4 Feb 2025 02:21:48 +0000
Message-ID: <SJ1PR11MB6297CFFAAC86B43C3499968F9BF42@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20250111002957.167327-2-sridhar.samudrala@intel.com>
In-Reply-To: <20250111002957.167327-2-sridhar.samudrala@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|IA1PR11MB7368:EE_
x-ms-office365-filtering-correlation-id: 93a5c74d-712b-453a-6e10-08dd44c2ad6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?RT/6qcavTNujBfgNtqrwX04262zUN0LI7Orr2V1g95+jiIMQ8wNYmsjY0V9y?=
 =?us-ascii?Q?c4miv6YMNCOxfcxm1W9rEy/HQFzkVPv+xtxuVvrk1rq6cz253I33MmCfYfPQ?=
 =?us-ascii?Q?wR7LBapX0dS2ZqfhZrZwvjgvR8QDI9PrMBIW/JcvrFATNoj0zrmTqQJs0oiJ?=
 =?us-ascii?Q?f9pq3ueRRtaIgvWHBNuat3IB7S7TYAqhTmPMwHyo41sBSnisxdziwYcxxDWf?=
 =?us-ascii?Q?RmZjDRcPmG5DJPZvHFlSceyXJxE79x53aa4EGzduyLidTerrPQy1ok7J6Awn?=
 =?us-ascii?Q?NQ7JHFCIK1HLa7ExpEkmxI+hDBFf0wM9N5OZPd60gQckHWOVkghB+c4Fb7PY?=
 =?us-ascii?Q?KLAB46kNHeStx7FfkLqPrii6SH/QFjWXT0xqh6xp+bH+yI90oPFt/lTpdn1U?=
 =?us-ascii?Q?gzOits/0mrpmfGqlnAg65TcQBOHHAu6m0i7tx3tBIlzLq+IXwgGKhr68FD37?=
 =?us-ascii?Q?5C8vUOCThZB8QG0EBOJC5qj3MkZ/qFkeooAkCw+HWpU4ED3Lv0nZoApd8PwR?=
 =?us-ascii?Q?Dn9QmN9oiktsRHH25SlIgtrXfikzupzrk0PUl41HrLOUlymj9a5qCHtu9kF0?=
 =?us-ascii?Q?4rKaL3JJM5D4Vmk2su03pWAEjWlk3MCPpnrPhG1RCuzS3y+unJAeMeEbmRxi?=
 =?us-ascii?Q?RGDMv9qt8790b84SNLDkmQeyNNIsZ9mQHCLgnQIytbtx2xZ5zBtLszc5cxA7?=
 =?us-ascii?Q?63zK6vzXURCE8z4rILM9yKMpl0frgVS4VxaCm6/ZwvAqUo2kNp8+D9UZHRD+?=
 =?us-ascii?Q?iBGxhvVU5hQ4kpCuzjkC/3n1X7e+FnHB7l3a9I6TcW4l85k7G7Vghtg8UZlO?=
 =?us-ascii?Q?J48PoyKySeOugAELTc/RAVTZSSRo1V2z9Q42vqhdRh4egraWRp9nz4YDXfmX?=
 =?us-ascii?Q?lifKVny64Ysx1UkQKMrCyxZku25TgdChBHezvwTdJXeJXrQjv6qKwCecZYRG?=
 =?us-ascii?Q?PsNO1GTk1OT9O4yWjYPlQ/21bkLMPJNtFE67EpV+hpZQwg1/Cr6j0l0twPgm?=
 =?us-ascii?Q?BKaBBjmvz/KuAO2P/UBsWAxDCXtQBGwsoWwZAsQVvaoPawUhmEjsH1N4F/7S?=
 =?us-ascii?Q?kq5Ltjo+1i6IzWZGebohe8GpmceG82uC0BLUuuAR25QHlHX73HPrWBCPqc8X?=
 =?us-ascii?Q?t46lVzzRHXaOvS4hzUzr4kQaGTe9UoAiTR5EGD9LsfC82fGIQeTZfhOjkCqw?=
 =?us-ascii?Q?nfGgZMZDQKNGXGV7x2oWE0OU4jcuon0B/9GOza+Jvw0+MAN5uiVi2jFnuGTf?=
 =?us-ascii?Q?FAeE25oB6PSeK03a8SK5Wy+usH9+pEk1G8wuqkCvRtjB9PXsMDOvN8bT/9rR?=
 =?us-ascii?Q?Ww+P+3HmzvnNkBfBCqAtUezfBBq/OY6+JS4A6h/cwelTJM9YTu5Vi3ffLS5h?=
 =?us-ascii?Q?UyPcxv2oeEKe/TuC12jMfu3wPA3AO8r3hCWsen0ODsorP987wXo/x7eYqypE?=
 =?us-ascii?Q?HOh2YxfjXipZSh2NIOf+P606jzaj0p+I?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lsif3Ini4l3PG4J24pQXaeMavyUZ505RVH7Uwbj0CSSjAcYhLRTLhJ6vP4IS?=
 =?us-ascii?Q?CquqDUKurxpx0oYMTXguNfzkFJYKlplf7us65I+ygWZsmmZk3PfDwPMJvrik?=
 =?us-ascii?Q?P2qrCzOEJwkWgiYb1V+bs6TN2ob+M9gZO7BwqQ8n0Rnt5AYWRE056E/Xh4B4?=
 =?us-ascii?Q?2KO7faRfjhAFKHG9x8TRHJrlDfMOlTDT1m6Ho6+OhsUqf6rrF03xtIFQqRHw?=
 =?us-ascii?Q?4BDDm2gYbCy5s3VkE8hDw3zhEHyaNL/fpgpjT6TDXFEiETxCb0uJTJwByJh+?=
 =?us-ascii?Q?EKyT7MttQ4mTFptS8Cdb+ztYSSciRKG/M37QXb+iEJnQHmgtfC4Jm2IFDI8E?=
 =?us-ascii?Q?dHCnmlYtf7SjE/yp4oiZNJp5ArE2/npo20aOvOGwccvSazpODNVteRtWJntc?=
 =?us-ascii?Q?jq2tFsTqWecdFNClkWv70usdOYcN/nuqPD7ctrhgoFeoOx2qox0fMpQK/pLO?=
 =?us-ascii?Q?VVMwLXcI9OIHTBAN4bBFgmaKfph8+uxXgAQRP2+tSi+5DsMkd9YxE/T6fHHU?=
 =?us-ascii?Q?kv9wcmEZP2nVE6nmkvNXwZ8NgUtPQnAYEOkE2sy9y5s6l0TX2a9gWZFSWULf?=
 =?us-ascii?Q?dCq4efQ2TlKCCoepwR/s/fZ69gIuTHMPxAWjk1gFQ9Qg4XPUDQQysV68GD3a?=
 =?us-ascii?Q?xunC2wQEGeq/6zhzQFquXXqzo3UIhTkqSaG1ZPRW2dEEtG0GbZykwYB7bjxm?=
 =?us-ascii?Q?GhDBOzN3Vfk8a+3Dh4qJ5xN1QaNxj5lcfivpsWkgwLyB3lCZgTf9RPT1v+nO?=
 =?us-ascii?Q?qMxMgoacr8caEK5a2jHMLx9Q4FF30PlFBjTOnhlxe1gJihMMgpW6A232fxha?=
 =?us-ascii?Q?S6M+rLTtUr7E6sgd2IkDDMbLj9IbbSZ1R8Yi/4juC8gXIO7foTGK1DbyS9qu?=
 =?us-ascii?Q?Ckvv2ZS425nA70A9GMwArDrJ5pgqXyWcJmp3EqRxkKhJtRfgzfkuevRIQSyn?=
 =?us-ascii?Q?+qQcv3uDL4wdHm7P4hpAqEfSn0zkQKGuhT7drEVsJs+6RKVKZVwI+iE0p9cc?=
 =?us-ascii?Q?JavnBA9gJYVzmQ5GlPU71F8spgOKM/3IdhGZzGuXy2TcnDo3QcJZUbj3zl6i?=
 =?us-ascii?Q?fQ1ajJJkEJzUqUBsbigNWXU+MljScz/VB6ZnUPuz7ZgETmZZjDLqtINQTLZ8?=
 =?us-ascii?Q?EKdAcrBBcHaYTQZIQOQNDOrVp8w0epUi+icO+VaoN92Fmne3KGozqJopB8ao?=
 =?us-ascii?Q?7FC79CEkK9qjNjzUZygS1h09yl9BStbADZ8FbZfZX96MlQBG/L4iP5zTyLYG?=
 =?us-ascii?Q?GdxpRJKLciU/Dbi30riAz7arlptOxDBSRFUm78fktMS0NmGCsgPgU6+Lk5Yn?=
 =?us-ascii?Q?op4M6hV0seEPFagENrVCJ6hn+Rsdl2CzZ8o02wTP5o03jQqR5q4YPUtdAlDd?=
 =?us-ascii?Q?fFkJQJLOjplBDPGwFtHjAevyE3B/+Sv3hN17YffY+w4OIvYY7r9GOoAPREP6?=
 =?us-ascii?Q?YSDNtDqbq7TQgXwSBgl+1i7S29yANq3Vvy0C+QOQYlUGCjG/hTlB0WgA1MVs?=
 =?us-ascii?Q?Vrm7c1ZDji7ubasloxjtltaJ2oBfDf4XH9owzdodjT7uwYCzL6wJlxCJIWBK?=
 =?us-ascii?Q?JY3qZ1EMXnqpu7OtqVh2X2Epgew8Cwa90vzF3Ol3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a5c74d-712b-453a-6e10-08dd44c2ad6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 02:21:48.0279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z6SgFNbGPPRFkRQCtaTK/nd33Mvz0K6fXQ6h1LZBxEASnBS1bFL8VDKM4QJ5dUs0OZW3pm2GTQh2PCeUgeB/3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7368
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Samudrala, Sridhar
> Sent: Friday, January 10, 2025 4:30 PM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Samudrala, Sridhar <sridhar.samudrala@intel.com>; Chittim, Madhu
> <madhu.chittim@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net] idpf: record rx queue in skb f=
or RSC
> packets
>=20
> Move the call to skb_record_rx_queue in idpf_rx_process_skb_fields() so t=
hat
> RX queue is recorded for RSC packets too.
>=20
> Fixes: 90912f9f4f2d ("idpf: convert header split mode to libeth +
> napi_build_skb()")
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>

Tested-by: Samuel Salin <Samuel.salin@intel.com>

