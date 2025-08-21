Return-Path: <netdev+bounces-215502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6862EB2EE1F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EA937BBDC2
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 06:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D16126D4E6;
	Thu, 21 Aug 2025 06:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nUruEqO6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561F326CE3A
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 06:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755757380; cv=fail; b=lRYCTfwhpKdK10BA0qU5oLAwvdeUsKvR6W0crA2CqjkLM+toOumm7+AjENL7xjw/elnkL5mERcFvoZxY4hIu+O9tJYALZMd/sIxwIfunfrZ2BpIPnBfKWRE7y0ZzLoqvDybGVXUzVOsG9gTH1OAZhBjXQgZ/z9828Gn17n54hEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755757380; c=relaxed/simple;
	bh=fJEKmpPf83xviXYzdYxkcXjvT0yXn+8vgGh7VwspY1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Un50+7GlVqTJYTg24cVWxJUYtEqiMy0OWX/AeLHX3Wfh/p+fwsnYv0Nkt9VRw+xCjjhF4AZ03p+48vBSjhiwdXmgGJP0rSZw1uO2m5IwwX0kJazqmt1BhRVKJZE9+Hmo/mV2JaEWAT/IrRnQPkXz4GMfzxHMPLM2/yXDiPkvqUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nUruEqO6; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755757378; x=1787293378;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fJEKmpPf83xviXYzdYxkcXjvT0yXn+8vgGh7VwspY1k=;
  b=nUruEqO6hc9Z24YPMEgQeSPsXsqqgkO6CutBqEtsPc9nvr7HL/g9e7m+
   K4Rf4CDV0sliG8PWWi1u1tPv3ggluoaIpSEQOOnLGjwHzFhX/0QRsiOan
   xXzR4HKXKilAHaW+h/9j2gUHhYaVx7ZfKx4XDnWpUlq9osaVpUL+722yC
   LBidhrb8dS+M6rKT1bQlt0/diWq2mmM5o2bIC4SHKNDOkb59tVl2yeT1g
   doDNA+JfU8nd2O5i6zid7bvh6kIe9jJ0lQ6P7rGFgB0Yx8cKssBm3NmkT
   3cMK7ZJkWTBqB+8CbRIJPRd5M+zT7zx0JPPE7bJ/0Hmfko5GXYc40S/mY
   A==;
X-CSE-ConnectionGUID: oirtu0QiR8OdZanxwy0OWQ==
X-CSE-MsgGUID: nlPS21+1T3mfoVMtfKjDkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="83456203"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="83456203"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 23:22:56 -0700
X-CSE-ConnectionGUID: SDkGRgX9SuuwjqDgO4pfxw==
X-CSE-MsgGUID: a8kXkKkNTUSIv7JmctwMhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="192011826"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 23:22:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 23:22:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 23:22:53 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.67)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 23:22:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rX2RGNwpkad4PWh9+bv3RRrzYCLZK/OF9AjaGdoSMnuudyyeBsL03XKg25jeATpG4w7t7UYDvcVonlJYXukh5Lm/iwzZHD6CVHUvIvXzyqg2rW/Pf1fODW3Rdwhs52w2bTJEj5zjhY0OVSpbYE13OrP32o7eUGvZrNT81+XHH/DNzQLJZwP37GbsMS6p01de0cit3HqPTwIgHXJYOAEafa8LjRDSqjZFU54MPaxFpgOpxxcic5maXkenM/QbGEidii+vqxcShFPYRduzSDCO06HfR1+7sare6lHpuun4PCeuEeYN1cBdoLIp8wOHRKI6nWBzCzDEJtnzTFQTl8aTRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYjM9Zx8CLtpdyCmf2G6ciA00EZYbkLd3dVcDoh4Ulk=;
 b=KOc4sDf9SW1U+XidOF5tiprki5hJ2CqUohjPFTz9+JFd/+weL/3KDB0dsiGoSmkyfaV0GZ8LclKSqn/AnfzXY/IotQRIQN6yAvkysNkFCI1uhYoP9YI2KZGaSJNs6ZuU9+6/Smnb9caO4ot0DV5l3HmYuS+m/zK1CgYM11qbohuyE0xKOMcRrROUG1RBrGkeZkjPsPacHvjIKJKQtTFUKOzotrkZwRD694HefE5eZO7pMEtoHgXI4PyGOvckKwXl/VwS/aA/Oj4bPNPdPAIHilq6f8kpaNgdfCxEauGHTc/quXjKj9R8t60P9TFyKKUeDyRSYguPSGImkErIDvN0ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF67C992ECC.namprd11.prod.outlook.com
 (2603:10b6:518:1::d28) by SJ5PPF6E07EBAE7.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::832) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 06:22:50 +0000
Received: from PH3PPF67C992ECC.namprd11.prod.outlook.com
 ([fe80::8435:3b39:7eee:480]) by PH3PPF67C992ECC.namprd11.prod.outlook.com
 ([fe80::8435:3b39:7eee:480%4]) with mapi id 15.20.9031.023; Thu, 21 Aug 2025
 06:22:50 +0000
From: "Singh, PriyaX" <priyax.singh@intel.com>
To: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kubiak, Michal" <michal.kubiak@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>, "Buvaneswaran, Sujai"
	<sujai.buvaneswaran@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] ice: fix incorrect counter for
 buffer allocation failures
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] ice: fix incorrect counter for
 buffer allocation failures
Thread-Index: AQHcCHzKm0URyTWIbkCtGiy+UHkQJLRsqjpggAALXmA=
Date: Thu, 21 Aug 2025 06:22:49 +0000
Message-ID: <PH3PPF67C992ECCA25302AB283AF3CBDBDF9132A@PH3PPF67C992ECC.namprd11.prod.outlook.com>
References: <20250808155310.1053477-1-michal.kubiak@intel.com>
 <PH0PR11MB5013285B7475C7F6ABEC1E4E9632A@PH0PR11MB5013.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5013285B7475C7F6ABEC1E4E9632A@PH0PR11MB5013.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF67C992ECC:EE_|SJ5PPF6E07EBAE7:EE_
x-ms-office365-filtering-correlation-id: 4e0942c8-18f0-4c1a-599a-08dde07b2743
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?sMXthBg3K03qsb4/9/7VHUfm8jHpfuJvE3gLd7auk7rS9kFJ0I2ToqJVWfEN?=
 =?us-ascii?Q?KW2+EuqexSD8rvi4pVKhMLMnJqfKovwCMk/HAJJubkkZxHcTuml/+q0lr1jq?=
 =?us-ascii?Q?1dvN1nyBqC1YgdazQ04cdr78McjBqqXOthu/jlGV8bwqbFvjFn5Xz69Ccqol?=
 =?us-ascii?Q?Mig3uScIj1C7LjHeY5EQlHPHgA8N6gFYovhxG03R9bsX9NlMyiB7OJH/+1qV?=
 =?us-ascii?Q?+VANRT8GMv2S0h0UKp1FkuNY47JnpL8TCzGOltiU2Iz3P+H0wrTx5sLfs4RG?=
 =?us-ascii?Q?sotOL7PbNGAur1Y9jpuMq9GYITRhQWULAcJAsd0lcU0CZhT7tU49QPVDtR/H?=
 =?us-ascii?Q?ynQ/Azf5Nk96ud9fqpVAtaPybdYQzmSeCgFyB4h1Z1aZ+lnDU/xn1JekMGzQ?=
 =?us-ascii?Q?Ymt/p29ayrnh6KDxBfTF7i13gKBflHRYCFmxBwAFJH2YfQDOp5q8eAFIAleQ?=
 =?us-ascii?Q?VbYRoPqvwOET3VjSkR6hql7DioybFgEzcknwtcVIQsP3SbET4nE+3cxnHsHu?=
 =?us-ascii?Q?pedEOmS7/IjU8QGlceRpsRBhU4pAZ8wxYLBlC5vXpzFwNGnASnr7UTo5W9RV?=
 =?us-ascii?Q?AMVXk9xbeqIuvKs/RJk05/QVxGf17nibVFnOtiSTmvBY3W4e10SI+L+XhJrb?=
 =?us-ascii?Q?iIghgFLvnXBAwcAbFc9a31LsCuG7oFVbW8RU9QPveyFojceWA6BKIq8G2REa?=
 =?us-ascii?Q?jJEM0ckW9xmqh4pe91C2L/x/1LpjnFmb/5dyLoTrtaZgq/asfqoxWPnkkF1a?=
 =?us-ascii?Q?2WVW+k56rQzy7PRydNdBiAWuY0ow9EX8Uc+glVVV3Wg2OJ2eMvmJJH3wsAl7?=
 =?us-ascii?Q?EGeICrtR08tPraEj7nFk62Br3wx1c06lR6JkhmnglztYwMXM5TUFF0uo/XhT?=
 =?us-ascii?Q?PadSF8v+I4FdSPq2V2FVnIGQIzOtfZT48/HfIkESfzMQ+EjN9VT1XK1v/KwA?=
 =?us-ascii?Q?stUxe9H2FozWkZKJ+jE/dySSH/AHDz1/0jmxyidbv1UTtgWErE1U9pMZz8K5?=
 =?us-ascii?Q?f8KfFXWnrIDNB5oMbzsGOJkeh9kz3ZpONTeMZ8oRtrjlBT/qTO6FgkAe8x3Z?=
 =?us-ascii?Q?hHUdGbQ1TkR+v2LHr5ntatWZZ0L5DFn8WTWvlmuXfJ8ZNkfr1w+xtilQwzts?=
 =?us-ascii?Q?+8V8Pgml261uY7oRGEUjnUeSfOnnR4mk7UYr9mcqndnb8zX2dFvR1qqt5jdV?=
 =?us-ascii?Q?Lz6wyakJhr8TI/IGlP5t5/ewf203FQE6Pl4o6eCcKG12WPKVHiH+pz1ZvwWC?=
 =?us-ascii?Q?tr2FNvZjPu4w+puyCzkXKpWegixJh9r9Wuvm9/jaP+aW5uOZNs2S5SUOeuix?=
 =?us-ascii?Q?6WwKJ6oOXNTYF34QWnFiKGjU2ab7AWJrW76wrwzSjzK7ZtNvVWbtYn3qUhMj?=
 =?us-ascii?Q?l+U8xVe4SVP/DHkpBxGemqDj7jn87772TwqM8O2ZUk4Pqj44dqru1X330uTF?=
 =?us-ascii?Q?H2h550/768mFVXGaGibQ1trYfeZGiRVn5U06Ety0w1TiIxtFTRL/NK/8yERs?=
 =?us-ascii?Q?ZByc1Qcz10pXAro=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF67C992ECC.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F5qp7R568rljSdakst/79cDtIM6nAeQ+Yh4yroWJiCja5sLCGPwW+4xKZkCD?=
 =?us-ascii?Q?JV/ovCKCFrcFTx30aZuu5UiXR+6U0oDTw1pSrAdfZe1TMLSmT/AOSOK2qAPV?=
 =?us-ascii?Q?M+oGRvJDAMzHRI0UpISgISzZB1tRS0klJUVEVgddqAs96QlLm3j+kCez8OPu?=
 =?us-ascii?Q?dx095nACnb/4XD7JAcuH+kPmBoV0D82RgXtLi7mXLqbjFf0g0BOOELMEH58p?=
 =?us-ascii?Q?k/uxxV0Ck+ouhZnq8fPxMvjbRsajE7OY4waILha5aPa1TZQ97iC+PtOI/PQf?=
 =?us-ascii?Q?91uDg2Db8ErntTrcpFl3kyp0EbBKLpf/yUVKPW7MKpiFBnonbt/Vw5izeQgJ?=
 =?us-ascii?Q?mKIhv8mlBX6vp2oFPn0EQUHX5JiQEm/MgR0E8+jkxYHAU5CYEN+JzCG7Qo5h?=
 =?us-ascii?Q?iTeooWjMWEMfRpmnRElBOm65Ep5RHtBThNMLtrG1nw++3crmZ5cHm4yUIfbV?=
 =?us-ascii?Q?rYqdp/4urSmf5QBNTy967rkZsIGKQuN/wh+DsAcxUrHSWn0AqTa5mN/RmUW1?=
 =?us-ascii?Q?y6tVKBU3q6oaFC6dCy+wGy5lGAmRGsXnwpFMuc3nn5q5bIOX4+rnXCZ9ruGD?=
 =?us-ascii?Q?D6unIZGnY0M95MV4s/RPLJ6eKa34Q8ZLCZEwMwfTxQf9hLDpRibXKf2FGkyL?=
 =?us-ascii?Q?KUJCpFYnzSckvWwgyIe2qjsugrWFX21rYQnyoBTPhEObXP5imW0vvudS6t80?=
 =?us-ascii?Q?wntpGnzGsPaBzTZYKa33LmstbFwCmFV0fswW6kAjNNck7+PR0tdX/gpwGYrX?=
 =?us-ascii?Q?IXZj/cgXw3n0+cQzHdaprcldK31wEFS5rgtdTzH8g1h4Ed1wsBam0LKo6SJP?=
 =?us-ascii?Q?LH718hHMT8N8FUT9lWslSelIGHX0l6fqPCdLON5A7r0LJjfwcLS8pBJRYGWw?=
 =?us-ascii?Q?XmMYd1HMk0/1ln4b5ySSc6sMrOploImhAkZU/vhf/dyhJlj5gH3cr2EF+g+h?=
 =?us-ascii?Q?Qg7I3TxOAvbmJGONSVFW2hMnfTBE7dzSKPjKzUqQgnh9x2rikMM+gfVxaEYf?=
 =?us-ascii?Q?ebv+Y58bOdxtwCu8xRp247bNJMXS0XFLBEvyTDHBoPLNjGiLUjx7WT5C2S1a?=
 =?us-ascii?Q?iSVWD9DGKXpXXoV1O5yzkuL4quPZZxL5mgs2vI2dCds3tmQFUOeM59Og3wks?=
 =?us-ascii?Q?vlKFNz2xvLC08uqYRl1Q00YffqbXF361Q+X/LwU1a3r/fzWM1rt8n5UQZB1g?=
 =?us-ascii?Q?p49adXDRwxPhgSyWceZLJx2ezwAQ+B/MDnMAD0zh9cKF8TAve0hYO2kQTUel?=
 =?us-ascii?Q?A8RK8If7nMQnlc4paj27imFyBjetoc1axL8U3VrM1f0EpUX8eMJyA4FawJSC?=
 =?us-ascii?Q?buo5OBtaCP6UUAMfkIMvhf7auzBhFEpIGCFQW+7K7rXvZBTTS1ZQY8QFATVW?=
 =?us-ascii?Q?JJaLTsHtoVcREPkHgSzSzkp9wqwPQeZ00xb0+4E7r/c8SLallZbe7ohk19hF?=
 =?us-ascii?Q?oXCfS9IUYXe6Li1I08gBnnAE/6SG1sMjslPA9CpzXlqvmpgplEIIaXG5ybIZ?=
 =?us-ascii?Q?W1ZK6R00op6+mOFFyHPI9BLgD5ub/AJdknCPo1sfsOeBQm61ZTjyMdhgUTVD?=
 =?us-ascii?Q?y2fUXVhyQQAzqJ9/iFkY+Fl1ZpbVY47gglo9yYCp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF67C992ECC.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0942c8-18f0-4c1a-599a-08dde07b2743
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 06:22:50.0754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bSWQsxIMlxrOBGCu+htsxUqUGIGaqc1hKU6k8phF9wygWE8qwOliubKSbWgr/Hnt2WfC6wgaTQq3Wcez9OS24Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6E07EBAE7
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Michal Kubiak
> Sent: Friday, August 8, 2025 9:23 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>;
> netdev@vger.kernel.org; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com=
>;
> Lobakin, Aleksander <aleksander.lobakin@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kubiak, Michal <michal.kubiak@intel.com>;
> Paul Menzel <pmenzel@molgen.mpg.de>
> Subject: [Intel-wired-lan] [PATCH iwl-net] ice: fix incorrect counter for=
 buffer
> allocation failures
>=20
> Currently, the driver increments `alloc_page_failed` when buffer allocati=
on
> fails in `ice_clean_rx_irq()`. However, this counter is intended for page
> allocation failures, not buffer allocation issues.
>=20
> This patch corrects the counter by incrementing `alloc_buf_failed` instea=
d,
> ensuring accurate statistics reporting for buffer allocation failures.
>=20
> Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side")
> Reported-by: Jacob Keller <jacob.e.keller@intel.com>
> Suggested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c
> b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 93907ab2eac7..1b1ebfd347ef 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -1337,7 +1337,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring
> *rx_ring, int budget)
>  			skb =3D ice_construct_skb(rx_ring, xdp);
>  		/* exit if we failed to retrieve a buffer */
>  		if (!skb) {
> -			rx_ring->ring_stats->rx_stats.alloc_page_failed++;
> +			rx_ring->ring_stats->rx_stats.alloc_buf_failed++;
>  			xdp_verdict =3D ICE_XDP_CONSUMED;
>  		}
>  		ice_put_rx_mbuf(rx_ring, xdp, ntc, xdp_verdict);
> --
> 2.45.2

Tested-by: Priya Singh <priyax.singh@intel.com>


