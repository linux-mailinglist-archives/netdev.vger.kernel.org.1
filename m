Return-Path: <netdev+bounces-296662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OIs1DVbyJmpgoQIAu9opvQ
	(envelope-from <netdev+bounces-296662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:48:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C72E6658E5B
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:48:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=BEcMt4tH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296662-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296662-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FFF53036F8A
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 16:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E09F3C9897;
	Mon,  8 Jun 2026 16:35:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2623C457F;
	Mon,  8 Jun 2026 16:35:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780936552; cv=fail; b=PpyMqtTFNZtQLAgvjRNFVID/LDbZeAJsMvxbUyAN8gptoqZYivoioj9YpSq84YBlI1WJaEvgvPtUou8SN3yRmxIOHbVOhxQ0AGQhWY+cd/zDvtCib0O+b5Z57PXHB/1VUPNPIHUXukVQCDPa9tZ5MS+BrKLJYk+BnKokp6IzHGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780936552; c=relaxed/simple;
	bh=f9v9k62514IrMIbhZlbkEIsavcPfA/GktWG99cpAzz4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PDHYCF/udtzDU2Yvzmp4hzi8ewAb5R2OYAjg2icq4ruXIkxdrKCrwpMqOxfGJerC1jC2ulnSg3iW0uBZKzBbq49TiLp/4l2GMvKN9I2CNYekO/e7ccLTa+arSwurfgFbeSHItUAOdhirl7FXcs8pC5Sdb0N9YblajFQQ0TAVBnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BEcMt4tH; arc=fail smtp.client-ip=192.198.163.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780936550; x=1812472550;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f9v9k62514IrMIbhZlbkEIsavcPfA/GktWG99cpAzz4=;
  b=BEcMt4tHXvMaVmv0hG/mlPwUneWFCvy9L3ahWAkXtVMs5PkBZs2xnfA2
   7mv3J/q1T7yfuKXDVL7WEVlyn/wi7mRd2qSCV4asGxprKLPQ6wQqlmCrC
   WvKsN+La8io5VrvDKybxxoPEPfxE3jgTk5RtA3fS+zl1SUYBDTuNydK0C
   c+P6kJGAvmLOjOA8PHX1TmrMTCrFo+5s7RTgAysZ3aRfPLk0XFswxkCon
   A+GDrPI5ZpZ7NvuMyFVMICPRFyAPqLAcAwWpFa63i719Z7s4Qs9q+g8GY
   UL0TIwflBuKyEam2VzYxfE//rtd4XyVI0YSB791IklJSUwUAb3Z8D82d7
   w==;
X-CSE-ConnectionGUID: QIo/8K7RSe6tv8QF4FT4mw==
X-CSE-MsgGUID: 9jDIvnUSQzOKqqa3XgnxxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="69212285"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="69212285"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 09:35:49 -0700
X-CSE-ConnectionGUID: 8o50fqOgTzWOXa312hvhYw==
X-CSE-MsgGUID: bJbwQk4pRmCA55fTaCDTzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="250699134"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 09:35:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 09:35:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 09:35:48 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 09:35:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+cgeSRAKHorgpRKmNmQIsnvnZq/8rf4VwbTFZAzXw4tc23n30/+t7i+EfTpU8zAcpdttqTVFVsMrwSEUQbyqqphtWqcZbuLxjEZygb5WyfxwjQWn+2DVmojJaYc1ky5eFAapx/pZy5BawNKhOst9g5fzdEZOYaZMT1h7L7NYx0guWaofiAfNQaDZS4fpj11MRsXwV5tzngb4QdwBGHT+DhQFj9XetTRfygLxAN1sPvTbOxm62sjfFUDMbpGsMEVoOBIeUrDX3z6ftUOyIxRQhjw+Vr/cgV2DQAWh10vlGxkUaObPj1iCPclEwpvHOCZrY/ACP6sftmTK4UF1RQ2Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTITS9SXwFMxIZ8D9eD2kNSOgIu5qviKdMoyKcOTBPU=;
 b=Z/st1d4Jq8uLAZzfeaTNh8YKSbyKMRxQEQeS6nUicJPMoMt0utU0QhsB6rKtYZ9v8IgWgEhDXzChks2Qv/4jqPpAw1Ut/1zsa5TR98WEQtRugurs3jV91VprmW55n97M79Mj0RPtovOZGhq1lNMm7+2cVg0xYKsTXHMF42T1UCjwFrEDVrojpvKc2qiCFw9+3ynvT5v/1imvA2/HT1aes/TXhUsEZdmm0zAiem9R4PFXb5YLbB1c0s+xQnB0FyKYKcTvnkvyeGvCl0G01Ewee3GvnTqOUN1iEbNyLw+bJvqqAbTXO7GbtN/6+FEV0VYEfZkjDcnB87KFpzEM4j7+eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5394.namprd11.prod.outlook.com (2603:10b6:610:b9::14)
 by DS0PR11MB6326.namprd11.prod.outlook.com (2603:10b6:8:ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 16:35:37 +0000
Received: from CH0PR11MB5394.namprd11.prod.outlook.com
 ([fe80::fd22:b4:e353:a968]) by CH0PR11MB5394.namprd11.prod.outlook.com
 ([fe80::fd22:b4:e353:a968%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 16:35:36 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Oros,
 Petr" <poros@redhat.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Prathosh.Satish@microchip.com"
	<Prathosh.Satish@microchip.com>, "Vecera, Ivan" <ivecera@redhat.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>
Subject: RE: [PATCH v14 net-next 07/13] dpll: balance create/delete
 notifications in __dpll_pin_(un)register
Thread-Topic: [PATCH v14 net-next 07/13] dpll: balance create/delete
 notifications in __dpll_pin_(un)register
Thread-Index: AQHc9qyHpEZfWlA5wk6B3UNH0MiQxrY03CyA
Date: Mon, 8 Jun 2026 16:35:36 +0000
Message-ID: <CH0PR11MB5394E8B56530DE253E731A2A9B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
References: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
 <20260607183045.1213735-8-grzegorz.nitka@intel.com>
In-Reply-To: <20260607183045.1213735-8-grzegorz.nitka@intel.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5394:EE_|DS0PR11MB6326:EE_
x-ms-office365-filtering-correlation-id: 69eecbd6-87b1-4f8b-be59-08dec57bf809
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: socEdVSO0BHkRwiAZ1GgaO+Rz6x/lSulGY2DDMzuY1+RRAkH9MDc6l4yrFcXr/DJll5hgfdvKvGG8JhE1CDLyUbOfj7AbkX7tJ3Sk8QXYeJ3XNfdFIDyzRocDnE654GmRDW+6RC1sMltA4EvAXNTGCHXnANzcyBv3bg2EaVSxjT+dZmTD1Jv/uQtKdBpDkk+oOhoj0eLE/OgUdqQ6Ry+db23UAXDppWmo/QRyOOhV8RUrzAXs59Kj0ReL2OaNE6F+wBsIht4RXLI69CCUJzvc3CdTCnRrFsCyvC3v0Uyw741CgGNy+fDpqUjyhA549+JQH/pqQa06fnACAy4IgBOo9AT7spGP/e+mV23qXQCwYcuAts0KNQW7yb1G7SOjO/M52yrheFISjJWGdOB7h+CuHMWEG0nN/23a8/Tu4KiwP3XX++OCAGMp3O3Uj6FMDZu3Yh3zP8NH7zRqafNI70+wB7bq/uQzYTao+T3S6gbVuLHsyGrbA/0zQAQO6cJCyI92vZJWAPG4VKxofVbJvtgtblksfJVdq+OiTabAJiPLFqd/g2x1qJRmaJCqK2eMJuUicAlKdhTy1C6pHCM1VS6UTw8aCfUAeky+hFFMVPScNAj5hRgWJC3HBjNzDEnYNO92usa6sxJaBpFfJFknpfazVaE8jRGY8Fi6p2Jkvf/Mth+QaowCYKbGCtbc4PmxHxu432WWC3k43T/einuu4kblySimCNRHr1VzSdx4sLRNvZUwWE9l+dH4Jl3nrVBgbxh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5394.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yc5I9Pa/w8kt4sKTt2hgZn+FDzxxMTIzcaWLaLcug7Gws+/rY+kdHsxhTRM/?=
 =?us-ascii?Q?wx6fR22Ky1c7FxgnvoyPtaPBZGoO0OWk5nBEyxMWx0/xw8G8KVcOQFDTi6pC?=
 =?us-ascii?Q?9JVbWA71wGPRjIF2eh3kNi5WlPhZLRygcrSQi2uAYLKLZUdGonveqiYtGph0?=
 =?us-ascii?Q?aYF0bcYBHq97XdfIzdT6ZF10DYLrKg4LeSU3h2JRD7LutuW5QaP8fFpVujso?=
 =?us-ascii?Q?/XB4ULtONkf6MQx3YSxDZHX5+M39tMohZ6tHO1oJMwkxj5k9sQQypPqmueoU?=
 =?us-ascii?Q?VYa1cnBYSkdrWVZWH7SpRSm2aoYuKEV+FMglloQ6YQdktLf1TZtklVvyOObR?=
 =?us-ascii?Q?nYu2PgFzhMUrewD86s4tUQ/UgwtUu3xc0XVycXVT2Vx0YJomsDZXqos4uqVt?=
 =?us-ascii?Q?N13086c0FJ1gDSJnXvq6EJ/cBCudG+hEJjoH4lr958vR7F6+3SSGBoa2U0nb?=
 =?us-ascii?Q?kNAVoikCl4Hvwz2kpC5oOhxBko/R/fjhoaAt4kHOZN1iQqyOGAe9EVVX0Jyx?=
 =?us-ascii?Q?1GJXl7mpvowyOSVJnKxbiKo3GqGuZC1c4Wymf80jI6kB1JEC5LxwJsX91ohu?=
 =?us-ascii?Q?pxyU+rMVOSkrlMfRBs30X6GG9rQgWwtSQDctak9JTuXRc6srtjFxfKnDplRy?=
 =?us-ascii?Q?pBvSsHyEu4U4OEQRTw/90jI1v9LIgLumrF3X/hhdQr+/CHvDjs3d6QfLphUR?=
 =?us-ascii?Q?S4X6DAXUsDYHQuS+WyTfyqMzlXri/vgKewcX9Z89Fp5mD5WVd0dZh+oVppgq?=
 =?us-ascii?Q?SZMRcrWQdvtGcTiPeqJoCdkFGd3mxzabMcwd4vVmwFtiP1OGUqJDirwQ9Ebk?=
 =?us-ascii?Q?ChRdJcE/26GK8QT3qwqwZyhKefwKzjP9kHhUUNtUZORuQr/fjtZcHOt0JrZD?=
 =?us-ascii?Q?rDyUwQlcPkNpKCA00ols2aEx6Zz9nBQPhJsCfH7/JOjNn5afh/lyDzxarT26?=
 =?us-ascii?Q?PHTSpFl16qX1bzKZcXSZkan8TekVA8QvO4mkc7ubEdN13By0LOgF/di1DDBu?=
 =?us-ascii?Q?ZxKXfoKixJO5TosLWi0Kj5RYCaIMG5NLxRF5fHkcnIwxwBUpisX6lIT07pks?=
 =?us-ascii?Q?HtJSdo5JfXB2gOQ8tk1HRo/nP3v5Yee0nrlk/Htpt69tNhG5Prvxgx1N4Ijb?=
 =?us-ascii?Q?OjE0jXEFk39nyDVughqTsxGkFcrxA7FEQAnhNIr/AkK6ETPHnUY95VmYyjq4?=
 =?us-ascii?Q?JabNKQOzAM3Ik3XZHaeH54s6oVC2pNu/b9hcLDYdFgUqmaVFXVC4TO8r8QlY?=
 =?us-ascii?Q?R3LtTOxUGao8mzZska59vhLFiFcUDjLu82NqJmq2Xk2NU4dF7+oBOhfFbJaO?=
 =?us-ascii?Q?T8dzEwt0CHNVyfhQUe5IEosjigKKfknnb4zdHm8FPquNKwEx5kYpI5GivJsq?=
 =?us-ascii?Q?BtdcrlS4ghn1AtpQkSTYrqB635trGdBfLL+m4HtmdqJQd3U0yedXPGGt1V4F?=
 =?us-ascii?Q?qqRqxfNuRiRTGvjv3CJ9XMW7CFZyiM3TRFURUixUSgptbyxGUvfmrhLEu1MA?=
 =?us-ascii?Q?4hC55SSHCXcoc/OaJP4EYUUiLMl+3STzq6n+ReI0Om1UrZ4YAVJ+o3+8TENM?=
 =?us-ascii?Q?4DscZTbEwMza3jpAcRc6WR5GYiPHJGMxEYhk/DvzRKzC1XoWFG9XORAaaRAk?=
 =?us-ascii?Q?7Mk/BjnGwYgdoUhC8yCRrbXne63vmCafQ9q/k7/2y/4buZJkR5+6JPLlsZ0M?=
 =?us-ascii?Q?FOIfoqBcBdagfcCztTVSjaxfYtOH1jRuW9QSyCK3oeMdcDsa8Fn9bqlH0iSz?=
 =?us-ascii?Q?JAKT6HbR8yDPpWDHLJCSm84ynNwacro=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HVhsHDroiCUknLMgZsJyA1ROjFeOgyvwZSqUDYV9nxeGsIH0PMbhh2rKMay5QrQlCQPJQRnlJ41yF0oUiT0j2DQWECMfBkciMX10myxAuZR21vH1CEKYHsI4DBeDDryQm0G2AHAFvxTHKlQXbCZOCUxq4RK+OBBUTDSiCFMFEK+K7aCYx8gXgoDVyaW1wbGLzFocv9sGzxhSRgkK1J2wFVResBm0dLHhD+v9MT0yNlseFq7KdCEkA1pWyTPa9hlKbSK31/JbTWWLYfE2beWw13VA9dyJEfYE2wB5SA8iwPeFhgSMRfioamfnjMUvswxwsZVieqZ9q1IpkHy07IoqKw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5394.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69eecbd6-87b1-4f8b-be59-08dec57bf809
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 16:35:36.5630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2/XAokkAB2Vb1ju7mcfitE3yAwIH0Uz3pFVTxp0rS12lzcBuKuccYWqWykBMax9mWKqfwGIniT7EZVbOBfBWAw+alLBveuUwBoyZ9L957Dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6326
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296662-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:grzegorz.nitka@intel.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:poros@redhat.com,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:przemyslaw.kitszel@intel.com,m:anthony.l.nguyen@intel.com,m:Prathosh.Satish@microchip.com,m:ivecera@redhat.com,m:jiri@resnulli.us,m:vadim.fedorenko@linux.dev,m:donald.hunter@gmail.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[arkadiusz.kubalewski@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:from_mime,CH0PR11MB5394.namprd11.prod.outlook.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arkadiusz.kubalewski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C72E6658E5B

>From: Nitka, Grzegorz <grzegorz.nitka@intel.com>
>Sent: Sunday, June 7, 2026 8:31 PM
>
>__dpll_pin_register() emits dpll_pin_create_ntf() internally, but
>__dpll_pin_unregister() left the matching delete to its callers. The
>counts then diverge on dpll_pin_on_pin_register() rollback and on
>dpll_pin_on_pin_unregister(), leaking stale notifications.
>
>Emit dpll_pin_delete_ntf() inside __dpll_pin_unregister() and drop the
>now-redundant call in dpll_pin_unregister().
>
>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

>Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
>---
> drivers/dpll/dpll_core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>index ea45bb41376c..1aaf62775408 100644
>--- a/drivers/dpll/dpll_core.c
>+++ b/drivers/dpll/dpll_core.c
>@@ -926,6 +926,7 @@ __dpll_pin_unregister(struct dpll_device *dpll, struct
>dpll_pin *pin,
> 		      const struct dpll_pin_ops *ops, void *priv, void
>*cookie)
> {
> 	ASSERT_DPLL_PIN_REGISTERED(pin);
>+	dpll_pin_delete_ntf(pin);
> 	dpll_xa_ref_pin_del(&dpll->pin_refs, pin, ops, priv, cookie);
> 	dpll_xa_ref_dpll_del(&pin->dpll_refs, dpll, ops, priv, cookie);
> 	if (xa_empty(&pin->dpll_refs)) {
>@@ -953,7 +954,6 @@ void dpll_pin_unregister(struct dpll_device *dpll,
>struct dpll_pin *pin,
> 		return;
>
> 	mutex_lock(&dpll_lock);
>-	dpll_pin_delete_ntf(pin);
> 	__dpll_pin_unregister(dpll, pin, ops, priv, NULL);
> 	mutex_unlock(&dpll_lock);
> }
>--
>2.39.3


