Return-Path: <netdev+bounces-125117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C1496BF5B
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDB5285C60
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46761DB53C;
	Wed,  4 Sep 2024 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fyiUi3iK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB661DA303;
	Wed,  4 Sep 2024 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458257; cv=fail; b=Vgn3OOdH7sg66zIIlkWOGFvTZ6Y8v2vB5kfNpyyxlwJugQr7LGanTabnmB3ETjBMcejbcHMnSxawk5sdTQro9LRVG/9yocWlxUwdyAYb2bKLVyACnY2PWKgbeV32uU8BxDP4i8ajPnVI2xcMz4XKMWPCWQF6FsaPIbJVnZTaPHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458257; c=relaxed/simple;
	bh=yPnEwE5A89ozDBbe0kPetZ2paKuqqHf62ZTTREEovkg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uzLR4KPznnRRQ/SvgsfCGhgbfye1EwsMHREtoZH3OoU8Ba3TRHz7BnN/DqQ+00B87wgCzxAEWaCWN6LqYVGIpBFnR8353jK06XaDNNpCUAAmb9IkOYHcUFnQteAuWKzkIgTLoCGnqhk4vE9vc4HvqeouPQsZAt3peIIdY2yVgTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fyiUi3iK; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725458256; x=1756994256;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yPnEwE5A89ozDBbe0kPetZ2paKuqqHf62ZTTREEovkg=;
  b=fyiUi3iKzTIKwvZDle/IsRwArIiBiCB84FV27RwqzPFhQ63EKK3ocb0J
   lPjR8OlZkpbYxEcivxu8a+Ak5P5KDxNS5/nSWYNk2NuyQgyrF0UpaIR0O
   sLbyh+vAWdXYRUChJYLy5iuKGrzibbssYKpssB4boAYAOclTRdd+7hvtu
   hbpgzeXc0+V+ZH1U1pWYJ5EspjPfc9SNMB4aTCcmAx5Sp5JShz4ecZQlX
   4c40awDesdkHuhd0cwGbhJGaWgBwZP40pWT0w1yVnj12zZeoVgN7AMXsi
   pjtJsIFQrvYo7n3LqSwSivey/Qx7NfDRzlpmNWhhITIFiahawnx9xV1ww
   A==;
X-CSE-ConnectionGUID: bZEwLxJ/QsqMiSgd/mZ6GQ==
X-CSE-MsgGUID: pow26WmUTPexw94XV9tT4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="49525303"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="49525303"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 06:57:35 -0700
X-CSE-ConnectionGUID: 1UtK+IGmQuuHvaTndtjUUA==
X-CSE-MsgGUID: pCJjVtrnQbuUhu75SRzpWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="70156456"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2024 06:57:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 06:57:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 06:57:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 06:57:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnb69f9l8JN2f/67zOrNVNecygQzA1umop+Nym3i8dTS7qW6HoS11Xgfi3R6ebrnrSeX7/gaxCyu08truUDxHYSwBFu00RqvfGoa6jI8LUhIMw7WIIntHdUlPSbsg3vle78Qa/ZMgZBiHsrvhf4Tl4ypl8QeMm3uo/f9LeNhQGyQ0xhabgF6kt5i/KMqLNtkBEXKZTR1BlGbRGmZ9geUcx7RWpTsssWpC3grKD2RHVpspVviGvA4IqXIgGCiezpR54AmpOSew+F1RIAnCQPCubqPtPWEAANeL+/CjYn70ccshnHpUm5bsGZzPK2TKMt8P+msoytfZ03R6yh5nYG7UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPnEwE5A89ozDBbe0kPetZ2paKuqqHf62ZTTREEovkg=;
 b=gUypAiCOKLGoppNGu4nP0anGDUeeLc8aHMT/eO9/4DoFdh5J/awObvSWcQGuegKBtzmnm3wrrECG87wI6f3ALRGZjSfJcr7qSw8O/OqF2pJTHfIJQCceSS7ff3bjC3EOQjRmzl5mVj5xcOeyvwXKbAmN8ZTQsTU5WeqY+yjSAn/7g1ycnfevz43qXwkt6VsqdyKik+BkZ6yaBCrUWhfFXPp9mIkNEumhbjlRv+cd4AldEuvmUFpRWGZ9009Hyq1Ne66GH0+MP1RYk6X91t4mfFkZ8haXzyPr1/u+rnHc0OFM0sb2S77UJLiybE0LwcuQFWlXrV5mg5I2QG2xRevE6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 DM6PR11MB4628.namprd11.prod.outlook.com (2603:10b6:5:28f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Wed, 4 Sep 2024 13:57:32 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 13:57:31 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] tools/net/ynl: fix cli.py --subscribe feature
Thread-Topic: [PATCH net] tools/net/ynl: fix cli.py --subscribe feature
Thread-Index: AQHa+xm+rQvODc3iHUqUpEiKlzlpGLJEag0ugAIX14CAABLfAIAADmYAgAELOhA=
Date: Wed, 4 Sep 2024 13:57:31 +0000
Message-ID: <DM6PR11MB4657B165FF053036E64E08279B9C2@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240830201321.292593-1-arkadiusz.kubalewski@intel.com>
	<m2mskq2xke.fsf@gmail.com>	<20240903130121.5c010161@kernel.org>
	<CAD4GDZySRpq97nDG=UQq+C4jBdS-+Km4NjGNob7jrbtBW+SmOg@mail.gmail.com>
 <20240903150026.34de5a1d@kernel.org>
In-Reply-To: <20240903150026.34de5a1d@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|DM6PR11MB4628:EE_
x-ms-office365-filtering-correlation-id: cee81ec6-2bb6-443b-0ccf-08dccce9857c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?xipysVd3s6d4mAAlm+116yfeOsq5jLi7yF3OiF61+v7Ur4GFQ0IMx6yrIlUI?=
 =?us-ascii?Q?exiBJ3tfdgKPsDcDMEW4+zLM8/Th9TlM2SS1FNV7F5T+3t0jPxDyb9aqAZ/p?=
 =?us-ascii?Q?GhqJaLGer4OvR10L4SFFWoLfCCh1INUV9yijh6Cd9WuY6FMJ/lvG/ZMuCR3t?=
 =?us-ascii?Q?RDY8WT//jA8kGwTqIqiv6bNcK2SPENNoSy2ToNZu9czPnqWd+uXvvCxZYoSL?=
 =?us-ascii?Q?zLDgsmDc20EhzQiRlYmvcb0ek7g26IiSjSz6WWGbNBds8ymRdNfRu1rSXtD5?=
 =?us-ascii?Q?+nEYc2D8Aizpv3CKP5oiuvSdHiXu3FukYUBtHb5g24jyhNvGOmm/WSlC8V8H?=
 =?us-ascii?Q?1Bz++Kd5IB/OQ178AP/IwgN/DMkoMbvZOjh0G4ixar9saI+frflVGF0rH4A1?=
 =?us-ascii?Q?iBmgRoaI6CI378YFGxPP4mzoRmQFLgTam6bxSMPTZp10f6EsZz6AOcoCFVzB?=
 =?us-ascii?Q?trAOglEjk9MDDE2iCmh7cn40nYe+3DIs+hImpyIqUfH4agT8UjZ9LFOizf+k?=
 =?us-ascii?Q?qcFArg1yZzKCLmIhAvvksCtKx2o2rmqRCTw2TxvkmV9btgen3VUf9Eq8UVi+?=
 =?us-ascii?Q?/BCGbOxOAYmZgfrBKevggr548DyscrLiXMZOtGjDh/e2nOroo1ALV/8cTHcm?=
 =?us-ascii?Q?LFe6yTPL/Ww0N/20Wm//DEjCKLQb2lZrnhZPATICcLwosNjPEPXnzvVx/oWB?=
 =?us-ascii?Q?nKvC8881YcGRPJO3xixbGfWQs4h9Bz/ojyz2+35wJSS5Jq3hHr3Rdb3O1Mas?=
 =?us-ascii?Q?gVOYDZB2jnBz+tHXZNW2Imk6m0A2jcmxkuhticMf8o14bRbwE1Tr3gw51utK?=
 =?us-ascii?Q?jded/ZVS30VjcVlVbG6Y50rAH3U1mU74VGJ55fGKSHrTe/BWUZhd2iM1orPk?=
 =?us-ascii?Q?im+ErTNWHnr1PrrP+azGBMMcgHS7qDgvVHSjvwsNM0CcerZDSh+bpCJZ5SF2?=
 =?us-ascii?Q?1fOn0azoF7S72XqQZD888qYSegmeZC/ZrBcrRf2HF1A1typGSA0x38DQgNz8?=
 =?us-ascii?Q?pcpAlBagSVP2O290NIzb5fdrq5saJpB6EQVqjWbWcJjKuJnV+eVLD+2xYY8i?=
 =?us-ascii?Q?7xEjtxDlhtHF7hw0OiwVCsiLJHSIPKh1hASVpUZy/z0hSgngGN2xorGSRjVF?=
 =?us-ascii?Q?G4CEEqOHsb9DcxQmO+4rvvDo1IzOCgcT7YaXGEH3liG+rzep6lLhuysMtv3m?=
 =?us-ascii?Q?DdRC+0UulpcVhtRG3mv2IM19XzoxKi+UPLm5JnYfg0VcryU7QqeT9qfZmdPk?=
 =?us-ascii?Q?tFpvlDkmHZlLNmxT3NBza0ONkmZ/pwIIKmmlgeIDCzQuvKfgZH0imUqU+OIY?=
 =?us-ascii?Q?eSnekBbWYhPnESPGbhuC9+2LN08BYX7mE/w4PoQIH5qL47tsTv3m2+y29m5S?=
 =?us-ascii?Q?KqC8zPO7XKNUv2V/qZDf6Fn78lfZrW4Ha8wLsB8gqzR+eyAomA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JPsEzxEkDgIg4YGgSaO5eWy0dMPhLZT1L4mFpz3PFqsvscaF7abutUaegwjr?=
 =?us-ascii?Q?qcoTfImbRyvQC3GWWQCDzv3MPXioJatYeKPuauSatAwnLkyPwd9K/9hP+OSf?=
 =?us-ascii?Q?9D1xCWDrom+EBOuhGRMlkha9/Gb2bCucV8AyypjrrP5QCsekBHoJQs2wPbaK?=
 =?us-ascii?Q?xdnTYvOnlB3F0J1tEczh00ofiMIuFXuA7e3sboGRt2zFkcJQHkmB9zjCvOo/?=
 =?us-ascii?Q?j0WSBGLuvmC9T3JPYgnVBlRfGtl9D9W6f4BCk6YeyCesfX+w7FDP1+NN4BBD?=
 =?us-ascii?Q?vdmqPFwYV7XPwoKnYWX21nTNC+rc2CD+DP+QG6e2sKzBlNWnIpWkXUbUKK9C?=
 =?us-ascii?Q?fIyy1BEgUPz2/Bhne1Y7iZ4OFRBN4B6l+zroZcKP/ckaPrMDOMlinm9Opi6o?=
 =?us-ascii?Q?CWQJhm7eEKufPfX7JbZacaCRlw0R+8MxWbSkWCDzEVrafpUisWNjkZuTy5cT?=
 =?us-ascii?Q?uhYv9fly98fvtHgmlaHH06+OhjwTSQIRwnVUt2jFymSxyNRSbyViIr3+AOT0?=
 =?us-ascii?Q?zTTqSi5TQmuhfSc7FXn/dUo9E0T0yLOcBpo9tDXt/g1eB6GZIsROIcJIXPXv?=
 =?us-ascii?Q?9hlERpk2JsAsfagkzDswCIRDjgaPuCzHNbEDsuOXSIEFQ8wUfMuY0xZnO+4B?=
 =?us-ascii?Q?PD2mZT7o5Uz7rBXJbplFGac3X/WoY+hLDpRkDSCHqm4H27hAAHMnNHHFyfNA?=
 =?us-ascii?Q?oU8Oh/1dyJUUweFOGuFbtNei1sT+doxNU2RXE6aEGGYafEmUANHF4FwBNq/2?=
 =?us-ascii?Q?o+rDuPVxGSMaNi22Pwsfkg1N4RQCPeBI8iLGtlqVGy5Y/OupN/YB3qbPBp6U?=
 =?us-ascii?Q?SvVi0odiTiZ1LzvtWR8gODHWnCnam4VvNbf2HvUL3zZqzt1ruYsvf8nR8Yr/?=
 =?us-ascii?Q?HhP0FpBgbkQHlZ3SL5cFjeoRwZOH3hWfiMr8nt1o+waFF3t4cWc3ApZB413+?=
 =?us-ascii?Q?c/KcdGlD0axTL7VOispKh/fED54ok95cyfbMxN5/Fql9LfsvTI8CDxyPehix?=
 =?us-ascii?Q?b4A+Guknw8ipg26x6H8weTM+6HN+9qC/C7UE/UIP2iBEfWw/rwp64igCLxnC?=
 =?us-ascii?Q?qHU8haQlMRsa0tqo9y3E2LuTzD4dXkVV/dLpKF1E00JmLTTK+7IyRCyvz0ks?=
 =?us-ascii?Q?9AZWjtELDzM4d0u2mjaRv8W0NMDL+ATGPL0n4zCBDQ+L5Lnr4K4EaSJql67r?=
 =?us-ascii?Q?N87O3A0+FHzaMaiAjvE7Png2K+Zal0TLEUzODhTSewOjc3WjP7EaeoPQ1C4M?=
 =?us-ascii?Q?L8ZI49l8pDX5t5sbWQ33eecNWzGUSji0dRSw5Eubt72TNjmuZm667/Cie2CI?=
 =?us-ascii?Q?NZruxiVPMRR7jgRDD3lJgrZill5j+VfZwdqHm5XRpmyShqYqtUEVGTiEfuCe?=
 =?us-ascii?Q?os091M5+5xP7bMDC1ECYinYYp3VZo1Hbxw/TsAWGRZKuYdU0jx1DToZ1YlEo?=
 =?us-ascii?Q?GMxiuuRKQRJ78EXL7ASgjiF+McSspbdkoiH9FVRfOaeeUhBkqH4d/prPpw3A?=
 =?us-ascii?Q?3V6ZkBJ1ijUPcquypyu6OVf6RnfYF5mvxyEpTLflq0SFkwoGoFGZlDWL6Nf3?=
 =?us-ascii?Q?PUPY31VD1wRsxN0+lw1zzJQnC6/U+Xg5BSvrml7Hzd4lLuU1vDfqx8KSRgK5?=
 =?us-ascii?Q?rQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee81ec6-2bb6-443b-0ccf-08dccce9857c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 13:57:31.8254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VVuYSr5zHGSEnS+NVRsRgCi17JjFBdnLawgaUbTWV56U+miXbZCc5Z7okhziLpT+hZDS0S0KwBX0Db+RBvjmsqg+qheNuV7VkfgGU2yJ1p4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4628
X-OriginatorOrg: intel.com

>From: Jakub Kicinski <kuba@kernel.org>
>Sent: Wednesday, September 4, 2024 12:00 AM
>
>On Tue, 3 Sep 2024 22:08:54 +0100 Donald Hunter wrote:
>> > On Mon, 02 Sep 2024 10:51:13 +0100 Donald Hunter wrote:
>> > > Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
>> >
>> > Any preference on passing self.rsp_by_value, vs .decode() accessing
>> > ynl.rsp_by_value on its own?
>>
>> .decode() accessing ynl.rsp_by_value would be cleaner, but I am
>> working on some notification fixes that might benefit from the map
>> being passed as a parameter. The netlink-raw families use a msg id
>> scheme that is neither unified nor directional. It's more like a mix
>> of both where req and rsp use different values but notifications reuse
>> the req values. I suspect that to fix that we'd need to introduce a
>> dict for ntf_by_value and then the parameter would be context
>> specific. OVS reuses req/rsp values for notifications as well, but it
>> uses a unified scheme, and that's mostly a problem for ynl-gen-c.
>
>I was worried you'd say it's ID reuse related. That is tricky business.
>
>> We could choose the cleaner approach just now and revisit it as part of
>> fixing notifications for netlink-raw?
>
>That's my intuition; there's a non-zero chance that priorities will
>change or we'll head in a different direction, and the extra arg will
>stick around confusing readers.

Sure, fixed in v2.

Thank you!
Arkadiusz

