Return-Path: <netdev+bounces-304222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Od6AE6SARmrFXQsAu9opvQ
	(envelope-from <netdev+bounces-304222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 17:15:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0721B6F9473
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 17:15:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Bv3Nj3nH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304222-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304222-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E98693229876
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 14:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39400433E6E;
	Thu,  2 Jul 2026 14:54:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624C2433E65
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 14:54:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783004080; cv=fail; b=Qe0jMG8PUWX5ne9niY86pamyB1hl1c09cD7SRiZ9mpPbKSPGf9g/I/Gaimx+l39meUcRD/+rocQRElHbhs8/fNIjgakPnwz0ntKzMFgwpiKS+P7kS9nMMpk65b4DW1D8zPXeCYU8KaS/aE8LBSBjai8cIvm2mArrtCvAYs8m8VY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783004080; c=relaxed/simple;
	bh=GLDK1z8AB7TtauH+TZN3jyZXz+3O8aqwKrAXWngKjmM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BUZ63U4C0lxWcKsnsO8Ud+q2YY6jpaV8ta6RLJgwRiQ3UzWwPWf+Mq2YxfCyz8B1XGs/znhqnFRYhjdNIsPpmFoH2sYhShaz0/rHpPtYa6Y4Cb6NY7i9bB7U0GGYovsQ0TQhj//M7bmQHrx+GgYOaq0iHQidmgn8F25IXFix6LQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bv3Nj3nH; arc=fail smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783004079; x=1814540079;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GLDK1z8AB7TtauH+TZN3jyZXz+3O8aqwKrAXWngKjmM=;
  b=Bv3Nj3nH4514uGCtc4iAm/Hh3DnGy/MpCRj1IzqYSubLdimU7v/EV2Rd
   DwjkMCkvoM4jLRINyaqu6FXBI87Vg4sd1aHNjwAy+DOBcW389u+DVQZy8
   w6ow/QvoVniyy2Aql1gHVGPbKiPPUxmGr61HqvxX8BKqbVBWOmaK8RC0+
   I0CO3Cq1Q4z9bdeUVuM4tPgzJJwlxhjUhOttLM1wPgPGAWMhVjUUvijvA
   PSYg1JLvsmCzXb53aniMt6VCBw4KDlD8ICmbLq7NPSQtD0hCtjgviSMcV
   okBk8pEqA7jOhb5VPkQI98oRNEWRf/keDwWhOw8Ar/noYpz9DLBUTaqZE
   A==;
X-CSE-ConnectionGUID: DjFZEwvdTyiCZrUtNyf99g==
X-CSE-MsgGUID: z5tySKXgSECGA5fRHdntqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="87674521"
X-IronPort-AV: E=Sophos;i="6.25,144,1779174000"; 
   d="scan'208";a="87674521"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 07:54:38 -0700
X-CSE-ConnectionGUID: YGk8/E63Rem7EyLS51KN1g==
X-CSE-MsgGUID: 7huq7qRVT9aUytFSKFSrRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,144,1779174000"; 
   d="scan'208";a="246517171"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 07:54:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 07:54:37 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 2 Jul 2026 07:54:37 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.27) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 07:54:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPhzIHH/L2nfisIJw+bMX2uAHfH/meTeklwCpsVm9TFg3g7f/MTOOvmD34TQ+SXYufzGZY0i5jfV6+IbNzjojwkEASyTkQUwtlPBD3UHs7lIfkrW3EIXnroqGR0UQhtoF1UHX0nEI21kx9vlzXsCO7kx4gkKca4vJe4iod/I64GS3m6gmH6NYo1xCae6cEfHuPj651hXsGJ2VlWE+kKo+HbDx0LRWphnZCEsPB1gu/aM1U6bzI/y9HcGjJKT6cDHmIOrWZIvUP9xSQD7ywKiS23HXq8iNw2kvMayn8qeBKpWZKyf1c2VUuxBazixsOX4M1n4LE0VPkJ1GyjOAMA62g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLDK1z8AB7TtauH+TZN3jyZXz+3O8aqwKrAXWngKjmM=;
 b=TfOBt9Ctii7rjOHsq0UaPIcDKKUCWzQydrfKF3FmPGpTf3eTBtGc6vJQ5BFp20DWt9H7Xe5WMCOKYz26UbmD5bjMn4wrFI/RoFazo4/ZXuF07JOFl81h4mDhk+Vit0nqOkjJLkV2dulwD1SfU1ITkDvrfe2DFB4S5S+6bxh0LHm4b8x0WxUOV6WecbVB+vVGDQyRn6N/tb/leZYS4eKDsJ/lcXO63UnFdQi/69pX+L84T002PznF3Bm7xgrBv5h0URuXskJlU+sohgc657r19NdkwtLidU/emSdBwnzm0Lx9UTcAs63qjafr/tti4dC1aRFn+OGT01TsJ6QqdZuqkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6900.namprd11.prod.outlook.com (2603:10b6:806:2a8::7)
 by PH7PR11MB8035.namprd11.prod.outlook.com (2603:10b6:510:245::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 14:54:32 +0000
Received: from SN7PR11MB6900.namprd11.prod.outlook.com
 ([fe80::65da:530d:6803:83e0]) by SN7PR11MB6900.namprd11.prod.outlook.com
 ([fe80::65da:530d:6803:83e0%4]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 14:54:32 +0000
From: "D H, Siddaraju" <siddaraju.dh@intel.com>
To: Michal Kubecek <mkubecek@suse.cz>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>
CC: Andrew Lunn <andrew@lunn.ch>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Das, Shubham" <shubham.das@intel.com>,
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>, "Srinivasan, Vijay"
	<vijay.srinivasan@intel.com>, "Lindberg, Magnus"
	<magnus.k.lindberg@ericsson.com>, Niklas Damberg
	<niklas.damberg@ericsson.com>, "Wirandi, Jonas" <jonas.wirandi@ericsson.com>,
	Siddaraju DH <siddarajudh@gmail.com>
Subject: RE: the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?
Thread-Topic: the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?
Thread-Index: Ad0FbzNABPoQ31JxTh+QV3XDba1IJQACWbSAAAchFbAAAMJTgAAAOH5gAIQ6zYAAEk8pAACOSSdQ
Date: Thu, 2 Jul 2026 14:54:31 +0000
Message-ID: <SN7PR11MB69003D33489DB1D6B17EF72A9AF52@SN7PR11MB6900.namprd11.prod.outlook.com>
References: <MW4PR11MB6912A234CAAAFD25EAC7C8909AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
 <2994edfc-0894-49c9-abac-6daea5e12075@lunn.ch>
 <MW4PR11MB6912BE7FEDE5C509B6C5D5DF9AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
 <2baa5a77-3305-4ed9-b56d-ba27cecc1911@lunn.ch>
 <MW4PR11MB6912BABFEED268D38B4BC2BB9AEB2@MW4PR11MB6912.namprd11.prod.outlook.com>
 <1b3975a8-788a-4b81-94ec-3ab5708b251b@bootlin.com>
 <jwbx3t5mxv6drv56ttu3iavtbv34csqtdewdgal4jkutx4zpgs@uya4traf7und>
In-Reply-To: <jwbx3t5mxv6drv56ttu3iavtbv34csqtdewdgal4jkutx4zpgs@uya4traf7und>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6900:EE_|PH7PR11MB8035:EE_
x-ms-office365-filtering-correlation-id: 760f1562-40b0-4f6b-6692-08ded849d31f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|38070700021|22082099003|18002099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: bcVrcwxlO9+NqsbivaK942DQTjdjKfwCRWRCDTSnff9gqADVQwluCSNCW/NXfLREjn+5f06enFbWatex9qZXKF/GRuA0bs+3eCGMwIDE6rV2yRfZIYeaJBVhTqQ+ifaQIxr2YA+xYlEGmyK4zTAzutgKBCPw8tXDwB6MnM1wJD8uHZP3GLHpKhdACsNd0WnfMvQUrydIlUARX7lLNF3Wz9gC1Ui4/Df3fI1avlod4WlKfNfu7xVF/PtQjFktsiZI9bnx/RcHKPZXqTDo/u1ix++p6j0fZMpwWeF57dJundOmVhItiHuVQog+qB81p4FKylzYkmUvLkeEXrW81qFnDlgCKa+MDCejMnw/KUBU5OLp0ZCII8g9/Z2mhnAJ9zOIeuiRNJ7WIl1TDa9zoXxS3ABnIXDfF+/8GZv9Dya05OUYdV/Ekr39+avaQiCfDZ3x6GbGTZmRpAI19aNAqKhPR7nXM+P3i2APGBhVEw/+fu+LkihrPzrRd9IlUzkpwHREnLnuEu30ukivtbl9ng3Xb583GDxpZMuZuEdc6SgKls/3x4GeY9mZLxObJCosD2bHRdBFMdXo6G9fh1RH9rZyxzjXNV5fXqYulQJSXAQTn2u5W2q+4GXFyB1y7v/O8UQFnbOcLnG0RAuUJARjlrnqTcnaTKTukQOGmBSBlXnPcjcQGtLzwYmqCM+0/fiz7nqCXjz3BW/9jwRGsquQIivtFcw/iitn2V0In7TjXM3TOis=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6900.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CvzWJnqrp0Yltsfg072u/GbRxalAGPR6OijEYJVYFmdTw/Uq9MK6+HXPngyK?=
 =?us-ascii?Q?kF1v/cVqvNqFmE9+zZXpwOD6MPTDJYgofWwjqvvvp+z4RAI3AkLEZ6XfZ+e8?=
 =?us-ascii?Q?OuiwL8p244XU2zaaGbEnCHiadRVhjQfdt/6lQTzPclXbcJ2YQKAGK4rJqEc4?=
 =?us-ascii?Q?ZnJJTGjklbHk1mv+EZpXJAMIcOADw5KRfZSs7j9AiG29IMPOuuhCR9sTl55F?=
 =?us-ascii?Q?02ye19FCaV5R+LBd/qaLyCXWaj40QFNiWf8XtHILbF7X3J26CWZUl0+7omjm?=
 =?us-ascii?Q?luSJiar3qT6vjUjSqcZr8lbVEEWGmU/rqjqBKcdmysYKTcSYtG28HQouXWm6?=
 =?us-ascii?Q?v1dwGG/JyVzESZcNN1PKLgcUl4aLxMzdKIyANLhEjeYcUhbvvcSrUnJvcjSJ?=
 =?us-ascii?Q?OhZv65Mpgl6gbaNXjly8PujW8nKlTl0Tll8gQGEPfFP4ihPBZAwLsEtx+3k6?=
 =?us-ascii?Q?upAYR06ZP0dR+q1k75xS7SSXsD2lsgdLCbP/PGQ9i4InPxZ81O5GEph9/HpD?=
 =?us-ascii?Q?DHCsvZ/yVWzuc1cz7p+pzKMld+6PX3OBvVJkgppnK5065WN4QJDaOcx+9FmH?=
 =?us-ascii?Q?5ZuESoBfFd/gm6p0luwmNpDMboVmHuW+NvxmNsAU7SXowUw32hydyGWnh72V?=
 =?us-ascii?Q?OBJBZYt8z6fw5TLZn/h7dWT3+FhhZhc+y2QXaF+zXYFQOi/oxgtBYDhOp07C?=
 =?us-ascii?Q?J2RtWHWz/NUjpi5zf4YficnFeQQKu71OkMZC2Mim4bQILmIwo4PQYJKURYn+?=
 =?us-ascii?Q?1/HWimiof2F1fguyqbnjZEfmNvI6U9fb7bkDZU1+8wpLdhyMX6dto6CAHAgt?=
 =?us-ascii?Q?hvpRHdhc6bz7NGtXyit98z/afrGvxw1mfTagM0BvGXd5Eok2buH03fyGb6Ey?=
 =?us-ascii?Q?8BgP7JQPD/LIF6cmw1XFbTQXIf412mY1XW8WlHcSvfuqGGyiP/7BAkK3T1NV?=
 =?us-ascii?Q?rN/DG7PDiRpDt6Ve4824RB3H1H2XBnhBiJyL5n6GvMOCgsuSQGJsKBF1npSK?=
 =?us-ascii?Q?Y8vnT6Wq/Q5Gn5KbxaN3p6LIQlxNmnml1l2tXTc2D169esBKaA4QNfOM1OI7?=
 =?us-ascii?Q?gCqap5qUhPzrTy2CaQyQo9yUx3xtM9DRXPptWbvuxiVRT2Xw87uQ7EsDEZxZ?=
 =?us-ascii?Q?n7aTohYWmkyi+2nyIvUSVstcVPxG8PjXqxxVMrPtCcCbatfL+tgsYfqME1bJ?=
 =?us-ascii?Q?93j9BxpN2pkJNkKjJ8GVOh2i7kyzKHsM3apk8M0JnSAXarcZ87bPHkPyGHhk?=
 =?us-ascii?Q?+GPOKNElckt5TA90NKHxoEAal/mqxigo3MQ1nuRbT+C0dAjVgafRMXwIIrGd?=
 =?us-ascii?Q?2o0sHDRi3p8djpnizD2uM+ZK+MBA0skhfObiFL0PLt7EbWzOCrSt5iAk8aYZ?=
 =?us-ascii?Q?Z51xG4is4o9nf3Q6T1OgcW/w/jaMegYdnz82PQJLw/EqKt3dtyGNjp7PbMG+?=
 =?us-ascii?Q?hAWCJOzzLCvPEKlWi24vnOXxBm+Ujgi8QKpD4yHKnpj6YVZodSn0gxqKZb0Z?=
 =?us-ascii?Q?Lw7dDriWpQBxVnMypWhqNt7iEj+Xzxyy/9QxrwAwlzPscLDIbpBTyWc/6JMt?=
 =?us-ascii?Q?M5rkoi8+AVR9s9Jopqn3S6oWOEZv6lv+yg252BnW52wr9LOniKt0VaF0BWcn?=
 =?us-ascii?Q?PyKRbHgdJCCbbpyN+srPhFeA0uad311fMBHa8fl8/6JXR2myAGogxE4LhsDl?=
 =?us-ascii?Q?nO99gcA5qpSBXVOnbmNJOohrirU6nPnrjACtxn5CNbtVEQJ3sSnP3TOSwviA?=
 =?us-ascii?Q?r2SMaVbf4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Y1/iJWLN4Dc5XpDjdx7AAk0dh8I8n+2qiN5JD6Enf4WB5YDiHqOtSN/fFQPva3IzrVk/zOfm0VGkVmbqSMHkMnREL4tSXdlzyHZdVfmq2V+63T7I4LqcA/UoRCg2G50c7Q/8WPCmZwoEVfMzHE/x3J8ZHyCR8KGmbHrRTjp8m7e47iHbTYc1lVa+jZJ8Vjd1Z7gUa+feQ5hgnAhStf7YCY8HKqfimGw82iUCCzRJPSvhUc73Uqv5NX91eWUp+y0CNXYREgLhItwYpotBCPuLlfMR41g8uIatrH31s9oTD9rseCSvCGrSMZETQgb/lInnO3pKfVqKCQavngsijQeJzA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6900.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760f1562-40b0-4f6b-6692-08ded849d31f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 14:54:31.8198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /WypQUffUcbjkwznJijWuML+TCniuX0cbGOE4MsILvrIt5evd0UYdJUB1sVcugJZdA6M09vpO2n5HALmk3We1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8035
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304222-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[siddaraju.dh@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:mkubecek@suse.cz,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:shubham.das@intel.com,m:balaji.chintalapalle@intel.com,m:vijay.srinivasan@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:jonas.wirandi@ericsson.com,m:siddarajudh@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,vger.kernel.org,intel.com,ericsson.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:from_mime,SN7PR11MB6900.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[siddaraju.dh@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0721B6F9473

Thank you all for your inputs and Michal for the detailed summary.
Keeping all the points in mind, and to avoid complexities with
generated file content, we resorted to static help/comment strings.
Since these were straightforward strings, I went ahead and sent the patches
with subject "link 10000baseCR to SFF-8431, Appendix-E SFP+ DA".

- Thank you,
Siddaraju D H

