Return-Path: <netdev+bounces-234638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1B5C24E35
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 686B84E92B1
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 11:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD67346FB7;
	Fri, 31 Oct 2025 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNod5t4E"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA22032C94B;
	Fri, 31 Oct 2025 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911875; cv=fail; b=FxLDy0dMcmyBa4TknQlozTTeAmJckdDxmSg9aTFZjUJDXp83aX7gNpG5Qb+gwEZjer7z3jQjnCwzg1WN2tymSCLlDfOWca+dcrToEA1UACBnpVRbeG2KE5xZdd/+qFFVso4BkGu9vkRDfJ0mVystwdQ7W4CX2aIjFduWby2FpJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911875; c=relaxed/simple;
	bh=4MF2sMgwEwZbwDuAkC5Bs98rTkz8nm16fDvWRToipy0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qIPjidUZEv3fXLqS+7K74dtRuHYL2N02Qhqf4FZP9F3Kjb1R5KNHJvEJyqBtTYyx/7RQEGKG51et8tqLqnFXaCK7TVIncNgEwCLSCrHPsmE7hvkBl7Br4GpTM2H6Sm/hsrbxmAmiMmCjacHshQFs7/+fy/S9bjwCzHJ1rw+RG7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNod5t4E; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761911874; x=1793447874;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4MF2sMgwEwZbwDuAkC5Bs98rTkz8nm16fDvWRToipy0=;
  b=nNod5t4ETtNYjVcKinbgJT9aRiQaBNyQpVKbZSdItY+AlSfr+YzBQzPA
   YOxU6AWK25YnFrx7ctbuBYNrfcUr9bxBMPinzYmighmplBSCaPZwe7XZQ
   GK1Ply2VgYjRjGut3ZdCiJ3GZzB0hxLR8PNzvAovUyt46wPGQAeU8VJcn
   sA0ZGjsQgSbOiaf5s6PMn2/2eieFCJsJN8z8jGMkPSX6Q24sL3XQfvy9r
   MDN1YLE0nMLF3megTeV0U7LRJFCl5SCZHxpG9CG0vLlmMXQ7YBgyXyvYt
   /kccK0Yyj8xxhyyxQwuTIEBrhBm1I2nGWdbnm3wTlTB+muQaZwyKZuJpz
   g==;
X-CSE-ConnectionGUID: ozhI6j6RT9O5R6jwCV74nw==
X-CSE-MsgGUID: hmFND9uXSc2O1CuIMT5OUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="81700390"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="81700390"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 04:57:53 -0700
X-CSE-ConnectionGUID: GjtH5qcsQRq68u+cDAD9BQ==
X-CSE-MsgGUID: 6e1Tn5dYQL2N+fY5T3Afkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="191366846"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 04:57:53 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 04:57:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 04:57:52 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.62) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 04:57:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3Y7x5Q214UzoGq8/JYzBJk5eSZd4kUCPsxS9hLYcQqZcGWzCG7ikdLarwQfZQMJ8Lg4nE4Cb0CGTh+sh0EFCyZiZcEE8IjwduJjWmUmxIyv+dmInYr9DwY352pIkxN40KmkJ1D/sceltOG9wSIDyby/p8dBouSFhWBRHSfGO83y+1JIupW+O/phEWpzTTJHoa6gNeSaMDUaZK1W4HQ1uEy3ovXfnCFpcphueVC4WB9gWj3j7nUwTvbPyE0FgbYGyC05IcC2wnspWn+18+RwlYMO+6TnnZpoo1spNhyXrv9JXT2LwIkI81iGRBlq7/6aq01ejk2OMSeI1VAdwTkMIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o47lWunulQ6gCElXId2CsEymJwY145WQJPrWqV1L7MQ=;
 b=FnVxZO0rBTz/kXtW2uNih01Ksv+Gm8q0lPfvvkUvQ1gDnWX8n6IwUxVi8DqblUcq2Eeu8uOey7BHOHCOwP7x4/pGAFo5IeGekhOi4T8FwLVyiL5PbFB66NnRWLr5CWLeBvr8jfpjwwkzsJHzUnxSwgWC0zJvGaeCzhvxsPHwcfOaWDuasGjJ6lPb6bvh1i/zGImuoxwn0sd5uEiXQr71hAEb+/ohGj4rkk6koYY85a/b5t3TB6qEjaLAdVNWvwkb7dmQwDtrZ9gzD8dchMbK5rJOJXl30tLh2GWfCYMmjTA1K2n1pNR7UpgG0boF1Cz05bYxnt1WO9+nMW4urmAW+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV4PR11MB9491.namprd11.prod.outlook.com (2603:10b6:408:2de::14)
 by DS0PR11MB7651.namprd11.prod.outlook.com (2603:10b6:8:149::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 11:57:44 +0000
Received: from LV4PR11MB9491.namprd11.prod.outlook.com
 ([fe80::f110:9a4f:b4cb:2eeb]) by LV4PR11MB9491.namprd11.prod.outlook.com
 ([fe80::f110:9a4f:b4cb:2eeb%7]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 11:57:44 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Schmidt, Michal" <mschmidt@redhat.com>, "Oros, Petr" <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
	<corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
	<donald.hunter@gmail.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 2/2] dpll: zl3073x: Specify phase adjustment
 granularity for pins
Thread-Topic: [PATCH net-next v2 2/2] dpll: zl3073x: Specify phase adjustment
 granularity for pins
Thread-Index: AQHcSOlOSq+LRASU0UuWRzCGNxvW47TcJ7qA
Date: Fri, 31 Oct 2025 11:57:44 +0000
Message-ID: <LV4PR11MB9491DBE02C10DA58295EC06C9BF8A@LV4PR11MB9491.namprd11.prod.outlook.com>
References: <20251029153207.178448-1-ivecera@redhat.com>
 <20251029153207.178448-3-ivecera@redhat.com>
In-Reply-To: <20251029153207.178448-3-ivecera@redhat.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV4PR11MB9491:EE_|DS0PR11MB7651:EE_
x-ms-office365-filtering-correlation-id: b3c2c5b4-8f65-413b-0d59-08de1874b3b6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?BM5xWx80WggackKxWZ54ghuE+ZlLo9uv1s4eHnKiVogS3RbNttTnaHDHK1EV?=
 =?us-ascii?Q?VW5C+PkyK8YWIRUtTrbNIG/5bXR542FN9KHo6alEjV3doRWxLtYcbPRZnsM7?=
 =?us-ascii?Q?MdXo/9BWkIkdkKaAcFWo5LcSx6b+4pssdz2fzejcBWXRE6VoAkBAXDyccDmt?=
 =?us-ascii?Q?+naAQFz3/NZ9RSw0LU+hes4JTNGyZ3p3wOc5WIuCBFY8vVJ71m7fdPRAJ8jE?=
 =?us-ascii?Q?wFla9zgOEhBCFdLbaNlhD66vvvA4INbttaXQY9GPLn+z1BJxa4vnbdt3KD2O?=
 =?us-ascii?Q?W2AXbJhuWSAog6hcG0tFOYdnk8LgFtT50OgMtvfw9H2zNwm+29Np6aXu7ebY?=
 =?us-ascii?Q?fa3hpMCf+j6XjqmE77p30PyGZvjzL+j2/26Nz1xRf72r/uBEHVXgBh+4ER/W?=
 =?us-ascii?Q?moXZNpD76ALD+KJ6Kavi9uL3Uy0jVZZ2OjWRrexMdfJmkzTaojC7qelS6G7C?=
 =?us-ascii?Q?ffY/7eBA5XThFipf4auzg1YIB1lX16cYhwVNnuvvRCunal1xowdEKNx21HDv?=
 =?us-ascii?Q?263cC7OebncUyfyupT5Bz/mDXLpjbDlDlBeH05MIz2pi6y/wlBAsV4wuuvWK?=
 =?us-ascii?Q?bYpUhwt4b2o+JIFkIVbpncrpXKd12EtKCrO8sSxumdYC/mBHRPNgoj4+9eQf?=
 =?us-ascii?Q?DfHccV+HN+Jr6e+AV4K6TULx9j2gtWN2r1jMakBldls5OfCWG0c9VeG5KRrK?=
 =?us-ascii?Q?3InEzK8w6Agpxm8CmBAbCCtV8BRVjqwFottYNsnjD2op+Pc+WcRw3mM+XZLc?=
 =?us-ascii?Q?LSneLSy6uLXoy7gOD4u0LzT1/nIUJDseaY1TgPlnLoTn8qmT6w2cHUGj+2/C?=
 =?us-ascii?Q?zVcfmRYcOqNAgyuEifCbE/OmJsTJaL1M+6S/puqNgKLzHTspxZLA6pEsBz8Z?=
 =?us-ascii?Q?oIz6Om5tg6Bri2GR1+X8QCwlHyDV4C66lVb3eEOAx4qoagjDtcHL7PZOsKsO?=
 =?us-ascii?Q?tp8YAgCuBD9hMIZTWwOYLJkTsOehFuWwKYO5WtgWS/LPx9WfPFJoJf8GIXrz?=
 =?us-ascii?Q?oP2zb+v4/dkogYkg/YgxkW6vXHAa8iMczrPqYlpe2SI5xQDcJwNflJ0xJggf?=
 =?us-ascii?Q?C7OAHtI51urAX6AcOKb82dvfJaRbmVJBj8tcPsoEAgEehlOcmZ7HcmqmWtiF?=
 =?us-ascii?Q?YLPIu1lRd4XnXPVP7yEMreYMQhT1uOFOnrjEzgcqgkWy1Nru7uBRl77k0QEf?=
 =?us-ascii?Q?2SgR/CMVPJgIQDwudazFtFbro42htyrxZsr9NKPh2JmdJmaZEwFkbJeu3oDw?=
 =?us-ascii?Q?Wt9UjYOmIEHqpTKJa8dgN0m3dXp7t4nmtFFoYN6AbQQx63Fknvo9QVT/IHTh?=
 =?us-ascii?Q?BAQxO8dUq8xSZaWH5cbRr1vgSbxd29xgl+UHchGWPUXoycJHeGHEQpBMFOsw?=
 =?us-ascii?Q?H9fNkvG7nTF7ZBoOA3JAtegrpwjBT00hn0n4jbF5nJKXADBgbgwXig0CM3KD?=
 =?us-ascii?Q?T/Rw0yat8ihp58bd/dy5P1Wan4h+UuIkNFbtD8fq8PUsQqsujl0IKPTekdNW?=
 =?us-ascii?Q?shnT2HRKsD5dOZjnlN/ZGb3NcqJDceBq2HoQ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV4PR11MB9491.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HdPv0T/ojzgBmnztOd6BNBnLpe3WAR6QMZdVXbRoj/IE/g8O91FrtMGDWcMv?=
 =?us-ascii?Q?wC6PEj5G3iui4jXc7gBs8v66O0FzgOQcG+ey3hLnnrjrtXjhubdaj6jZgZjp?=
 =?us-ascii?Q?bPJ8lONw/zJPQXdZFF52FCskUVnlOM6xBY0EdrEUjax+iU4n+DAn72kN6hFv?=
 =?us-ascii?Q?8eQkbEfZ0+uRE3rYqeu0cnuzcI64TmawLbAM8nSU/p7Ul4CBciJyuMLB6hi7?=
 =?us-ascii?Q?5hUupixEzvbzHLyr5ceIUWR7FFpWloY+ILTnrl2nHAjYi6NQXGdhLICSHHUt?=
 =?us-ascii?Q?QzpWAzqCPk6ydMNQ061vaMaqfgxf1umaypC3itx11CfXWvsBZ9kCcMMVTORs?=
 =?us-ascii?Q?AY8Z3ugCUn/7GKktDJQYlGai3PWoAQ5AbRTvyayy1t8+g1KYDKM+LhlCuQPU?=
 =?us-ascii?Q?HlIAnalmLs9CKsEj3IxOdlwlV0klsQRPiY7YLq6ALvklD96b7vIthBUs4aUG?=
 =?us-ascii?Q?eRN+G+zNIzurdp5Yl2XRAtiDefvfFq3uQFMEtIXEShTUz9bKJFOEWwD4LZKV?=
 =?us-ascii?Q?4Cb2d2ZmUNQt1A2d/YKvQRg6xT1ykDBRKiarrxx4kqEALRcaTchMp12FflF+?=
 =?us-ascii?Q?spw4RjSrzJuYkPfgP6IfDjPHi8m9oSMhiZN9xg/X4bCyw3ADOQrz86U1mBjt?=
 =?us-ascii?Q?pEJYv3OD3+UgOlBA4wmJcmdFD9ayfAtnnAk8IVRcrO0463M6tilBNjTxyZcz?=
 =?us-ascii?Q?lnNhu2omr+wrBpcMrfyBXMLNIqlcnZLB+zX3Cf0/CQrEijNkN8je0CK6zRF6?=
 =?us-ascii?Q?dEdyp4ELgjUexvLaBG1fT5ESngSAGEejyJ2HuR+C304zI36DPPF3y0CzxxZv?=
 =?us-ascii?Q?vqjsOeW1+5sqRSicWXk8PvVHzoS+3R8websepTf85/P0Ixf8/qleSrRtwDHP?=
 =?us-ascii?Q?jUOXCB2blPmrTyJh6XJkoSIzfB3CDZc3Xh5+BlLyKooLMdHs5cn9UIbxHC4s?=
 =?us-ascii?Q?3CpV+BTqMKfpSmMPzHdhkzSiUjLCykj0rJQUHVZDqyJGxrvyJABVU0Fe7ttC?=
 =?us-ascii?Q?quXZVKJu8BUotC1fpbTTMkbXXmqml3sQtEM622aK1r4DnIQ9c/gyQVmiivwc?=
 =?us-ascii?Q?CNhwhwbEqbRrLTjDisUngl02VM32XxN2KmI0ss5C2MzmE+5MFQjMaSzSLNQj?=
 =?us-ascii?Q?MK2XHEzNTcJKpwYDhyVtnOJe6+0mojQoYWlb1xV1MnNQBQxLgGPSB6F0nUj1?=
 =?us-ascii?Q?rS1x83ptAlnubE8ZvZVXdsk1v1EaxqLJkgAjA9BjGYhkO/CRkDP9PKlrhajm?=
 =?us-ascii?Q?v5ZCunkDBxi0C+cWzgSJ96cCY/NrSejES71hKOMPHmOtlazhs/AFjFKq4Ea8?=
 =?us-ascii?Q?W9PRxyrJaaWNo5IA72Nfr9PeLe2z2ruIxvJ5xEf/639L75CEgO0aXvUoWZSf?=
 =?us-ascii?Q?SzcOGwZRRKJl2bRCYBKoDHAamMSZ0AwssZwBKs+X4LoqBqMv3WCBDGLqeEQ9?=
 =?us-ascii?Q?0zSpwnBdzck5/WG5uWlfzeGnVu7ahE3mWL2eOZSNdneetQLZi4vEKIrBmO3I?=
 =?us-ascii?Q?bknRYJG7jDN3WHXIIH1xNCDBzx9kPKPvQ03tqH89T6VBPrvm8kE+lWfsE0Gm?=
 =?us-ascii?Q?cL742v6YwdjmsgdU2NNrBy59Ihg8iHPyGif4d6pWhtsUQ6GBRbTbACo55q+a?=
 =?us-ascii?Q?Mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV4PR11MB9491.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c2c5b4-8f65-413b-0d59-08de1874b3b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 11:57:44.3256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: voa8ZfUAj80A7qc7z2PvhEFM/Q+PRC2TX1yrTwOQMuoPK6MksDB0JS0Iuah2p3dRs5mTHzIrdrLKwp6tAAdsThKRUkfsEXqxh5UMuD6eH+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7651
X-OriginatorOrg: intel.com

>From: Ivan Vecera <ivecera@redhat.com>
>Sent: Wednesday, October 29, 2025 4:32 PM
>
>Output pins phase adjustment values in the device are expressed
>in half synth clock cycles. Use this number of cycles as output
>pins' phase adjust granularity and simplify both get/set callbacks.
>
>Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
>Reviewed-by: Petr Oros <poros@redhat.com>
>Tested-by: Prathosh Satish <Prathosh.Satish@microchip.com>

LGTM, Thank you!
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

>Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>---
> drivers/dpll/zl3073x/dpll.c | 58 +++++++++----------------------------
> drivers/dpll/zl3073x/prop.c | 11 +++++++
> 2 files changed, 25 insertions(+), 44 deletions(-)
>
>diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
>index 93dc93eec79ed..b13eb4e342d58 100644
>--- a/drivers/dpll/zl3073x/dpll.c
>+++ b/drivers/dpll/zl3073x/dpll.c
>@@ -35,6 +35,7 @@
>  * @prio: pin priority <0, 14>
>  * @selectable: pin is selectable in automatic mode
>  * @esync_control: embedded sync is controllable
>+ * @phase_gran: phase adjustment granularity
>  * @pin_state: last saved pin state
>  * @phase_offset: last saved pin phase offset
>  * @freq_offset: last saved fractional frequency offset
>@@ -49,6 +50,7 @@ struct zl3073x_dpll_pin {
> 	u8			prio;
> 	bool			selectable;
> 	bool			esync_control;
>+	s32			phase_gran;
> 	enum dpll_pin_state	pin_state;
> 	s64			phase_offset;
> 	s64			freq_offset;
>@@ -1388,25 +1390,14 @@ zl3073x_dpll_output_pin_phase_adjust_get(const
>struct dpll_pin *dpll_pin,
> 	struct zl3073x_dpll *zldpll =3D dpll_priv;
> 	struct zl3073x_dev *zldev =3D zldpll->dev;
> 	struct zl3073x_dpll_pin *pin =3D pin_priv;
>-	u32 synth_freq;
> 	s32 phase_comp;
>-	u8 out, synth;
>+	u8 out;
> 	int rc;
>
>-	out =3D zl3073x_output_pin_out_get(pin->id);
>-	synth =3D zl3073x_out_synth_get(zldev, out);
>-	synth_freq =3D zl3073x_synth_freq_get(zldev, synth);
>-
>-	/* Check synth freq for zero */
>-	if (!synth_freq) {
>-		dev_err(zldev->dev, "Got zero synth frequency for output %u\n",
>-			out);
>-		return -EINVAL;
>-	}
>-
> 	guard(mutex)(&zldev->multiop_lock);
>
> 	/* Read output configuration */
>+	out =3D zl3073x_output_pin_out_get(pin->id);
> 	rc =3D zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_RD,
> 			   ZL_REG_OUTPUT_MB_MASK, BIT(out));
> 	if (rc)
>@@ -1417,11 +1408,10 @@ zl3073x_dpll_output_pin_phase_adjust_get(const
>struct dpll_pin *dpll_pin,
> 	if (rc)
> 		return rc;
>
>-	/* Value in register is expressed in half synth clock cycles */
>-	phase_comp *=3D (int)div_u64(PSEC_PER_SEC, 2 * synth_freq);
>-
>-	/* Reverse two's complement negation applied during 'set' */
>-	*phase_adjust =3D -phase_comp;
>+	/* Convert value to ps and reverse two's complement negation applied
>+	 * during 'set'
>+	 */
>+	*phase_adjust =3D -phase_comp * pin->phase_gran;
>
> 	return rc;
> }
>@@ -1437,39 +1427,18 @@ zl3073x_dpll_output_pin_phase_adjust_set(const
>struct dpll_pin *dpll_pin,
> 	struct zl3073x_dpll *zldpll =3D dpll_priv;
> 	struct zl3073x_dev *zldev =3D zldpll->dev;
> 	struct zl3073x_dpll_pin *pin =3D pin_priv;
>-	int half_synth_cycle;
>-	u32 synth_freq;
>-	u8 out, synth;
>+	u8 out;
> 	int rc;
>
>-	/* Get attached synth */
>-	out =3D zl3073x_output_pin_out_get(pin->id);
>-	synth =3D zl3073x_out_synth_get(zldev, out);
>-
>-	/* Get synth's frequency */
>-	synth_freq =3D zl3073x_synth_freq_get(zldev, synth);
>-
>-	/* Value in register is expressed in half synth clock cycles so
>-	 * the given phase adjustment a multiple of half synth clock.
>-	 */
>-	half_synth_cycle =3D (int)div_u64(PSEC_PER_SEC, 2 * synth_freq);
>-
>-	if ((phase_adjust % half_synth_cycle) !=3D 0) {
>-		NL_SET_ERR_MSG_FMT(extack,
>-				   "Phase adjustment value has to be multiple of
>%d",
>-				   half_synth_cycle);
>-		return -EINVAL;
>-	}
>-	phase_adjust /=3D half_synth_cycle;
>-
> 	/* The value in the register is stored as two's complement negation
>-	 * of requested value.
>+	 * of requested value and expressed in half synth clock cycles.
> 	 */
>-	phase_adjust =3D -phase_adjust;
>+	phase_adjust =3D -phase_adjust / pin->phase_gran;
>
> 	guard(mutex)(&zldev->multiop_lock);
>
> 	/* Read output configuration */
>+	out =3D zl3073x_output_pin_out_get(pin->id);
> 	rc =3D zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_RD,
> 			   ZL_REG_OUTPUT_MB_MASK, BIT(out));
> 	if (rc)
>@@ -1758,9 +1727,10 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin
>*pin, u32 index)
> 	if (IS_ERR(props))
> 		return PTR_ERR(props);
>
>-	/* Save package label & esync capability */
>+	/* Save package label, esync capability and phase adjust granularity
>*/
> 	strscpy(pin->label, props->package_label);
> 	pin->esync_control =3D props->esync_control;
>+	pin->phase_gran =3D props->dpll_props.phase_gran;
>
> 	if (zl3073x_dpll_is_input_pin(pin)) {
> 		rc =3D zl3073x_dpll_ref_prio_get(pin, &pin->prio);
>diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
>index 4cf7e8aefcb37..9e1fca5cdaf1e 100644
>--- a/drivers/dpll/zl3073x/prop.c
>+++ b/drivers/dpll/zl3073x/prop.c
>@@ -208,7 +208,18 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struc=
t
>zl3073x_dev *zldev,
> 			DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |
> 			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
> 	} else {
>+		u8 out, synth;
>+		u32 f;
>+
> 		props->dpll_props.type =3D DPLL_PIN_TYPE_GNSS;
>+
>+		/* The output pin phase adjustment granularity equals half of
>+		 * the synth frequency count.
>+		 */
>+		out =3D zl3073x_output_pin_out_get(index);
>+		synth =3D zl3073x_out_synth_get(zldev, out);
>+		f =3D 2 * zl3073x_synth_freq_get(zldev, synth);
>+		props->dpll_props.phase_gran =3D f ? div_u64(PSEC_PER_SEC, f) :
>1;
> 	}
>
> 	props->dpll_props.phase_range.min =3D S32_MIN;
>--
>2.51.0


