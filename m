Return-Path: <netdev+bounces-304650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t5+iBhj/R2o2iwAAu9opvQ
	(envelope-from <netdev+bounces-304650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:27:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B2B704ECC
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:27:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=G4qSAURq;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304650-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304650-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D430A3021E91
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 18:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D7430E0D5;
	Fri,  3 Jul 2026 18:18:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42432C375A
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 18:18:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783102701; cv=fail; b=tYp//CHAXndouuwr8IBhLmBHHmr3oAb/BM+28f0e2mKqIOVIwkBJxephnRh5zwREb1/+kIZKaQz3u0aaa3WIuPU6vje6WGJmcaA44Ni9Tu8CizhhLPVdx0mtUGgrhhlFYf36GEI4tErVRrEAKge9RzG5c85LwcyShsReLU+zrtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783102701; c=relaxed/simple;
	bh=J+ndoHE6GWfgSGRERdVwktyNQQiSOwqLejkERlbA7JQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=npNsLemZF8Z/wVUVINMhLABgKO6cNjF5YwhJj0Ox4gutOC+tY5Mg0d07JANq1E1yXiQv11gEVCnRs4gOMvMKGT4T2jTR2P21tMIFg8E/ZZToe7dVRcn367aJCiroAk+BNKFp7TxgC/QYT7oKhjp5wrFKQrTRmnZuNDzXlUg1SFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G4qSAURq; arc=fail smtp.client-ip=198.175.65.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783102696; x=1814638696;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J+ndoHE6GWfgSGRERdVwktyNQQiSOwqLejkERlbA7JQ=;
  b=G4qSAURqKz45AYcMF0yEp28Ev3bFKSdOwIMH9aZmnEe4qE2NJnGMf/+h
   c83ghB0qF3h4JOwZW4tuByg8Whzkumtjfk3Wp8MTxYXj6Ex+Vz0WCxm3o
   +fpvR86Yim3n9DpETKoBGVnU8CUB6f8GhRcFOD0WB7Y3lTDvq5as0ijP0
   QHbYpBnkpCeOo/BbvPIMgDVu7GM+1E+/OHrcLuEAoop2Nh3pNdFRtn2Vu
   XF4YvUQkplJBOnFFBwkBsnQMJCEowK+6ipEGPApdrmnFQI2tgjk1zs0lv
   J/lnekFHUyrsfo4N7uBo17V3mJ2aRMgIITBn/dCMcUmebYidyiOvfHE9N
   g==;
X-CSE-ConnectionGUID: 3JcvA6PeQqO3H94PMiNFAQ==
X-CSE-MsgGUID: kv1EBsqUT3GUoPQx3g07uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11836"; a="83948695"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83948695"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 11:18:16 -0700
X-CSE-ConnectionGUID: +7EWBAESTui0QwFzg+F5Rg==
X-CSE-MsgGUID: GC7Xrc16RDWyJK3WIuL+VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="252697910"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 11:18:16 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 11:18:15 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 3 Jul 2026 11:18:15 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.12) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 11:18:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jiJ1o8JBwrj6KD0QCib4u2bGC6U1PI5Tozg6MTkkugc3tCfdKCjpo3gl+4KL5KC/iqNJizM58Atdledk0aHGPsHw5nu8iBt7QFjJxJnkjnwzZn168ZHGrbTZT3ZoTt+1LI2bPxPrgZ45cM2YePb7HOb5wIjt5EFL5obU911Dpsfx6hlcpDntjI2LU1GqNKp/EMwdoHtF2TZ+chWCNOPtdBoH6v3794GlX/TaDXjnerywi+1Y8PnhjSXINTGh0TbOym4ln2CF4W2ELoAPO3nJAT0NHBQuTpOD41gJdc57lf+kw4NG1B8txWfzSpwT7V/VNN0sD+wTMII3otq5gTh3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+ndoHE6GWfgSGRERdVwktyNQQiSOwqLejkERlbA7JQ=;
 b=eGhaxEOSY7O8cDzQ+RE6vnQQycCjiHv54F+J5d0gYmL5/engeksoxtq9bMYeX23xI/9irRgIm0/qbmr0Wi2SDE59XJGtmrcsmgCuJFIh+nkaywAybzyseCFqbzH/Xu1xDT98UCKnnycnJLG9Oygu2/apVgGy1v/axzhLwBV8mFm2cOYaymqfgSQF3tF5ANfGzhWoHBVU18ZhH1TcWPw5DLqzeYKilBGUzJuCaXQozPjoLtKJnzo+Vayg5Gvf8yEOUfoGctXtXXGP7wJgm6Ycd8IMXTb2V9Og6tdLYWd2AosGIA2IV2eJkL5zZRPzQ0MCbBZor7hsc5IdTYQnbOKiMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6900.namprd11.prod.outlook.com (2603:10b6:806:2a8::7)
 by SJ0PR11MB5021.namprd11.prod.outlook.com (2603:10b6:a03:2dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Fri, 3 Jul
 2026 18:18:06 +0000
Received: from SN7PR11MB6900.namprd11.prod.outlook.com
 ([fe80::65da:530d:6803:83e0]) by SN7PR11MB6900.namprd11.prod.outlook.com
 ([fe80::65da:530d:6803:83e0%4]) with mapi id 15.21.0159.018; Fri, 3 Jul 2026
 18:18:06 +0000
From: "D H, Siddaraju" <siddaraju.dh@intel.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Michal Kubecek <mkubecek@suse.cz>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Das, Shubham"
	<shubham.das@intel.com>, "Chintalapalle, Balaji"
	<balaji.chintalapalle@intel.com>, "Srinivasan, Vijay"
	<vijay.srinivasan@intel.com>, "Lindberg, Magnus"
	<magnus.k.lindberg@ericsson.com>, Niklas Damberg
	<niklas.damberg@ericsson.com>, "Wirandi, Jonas" <jonas.wirandi@ericsson.com>,
	Siddaraju DH <siddarajudh@gmail.com>
Subject: RE: [PATCH net-next] ethtool: link 10000baseCR to SFF-8431,
 Appendix-E SFP+ DA
Thread-Topic: [PATCH net-next] ethtool: link 10000baseCR to SFF-8431,
 Appendix-E SFP+ DA
Thread-Index: AQHdCjKZOnuy/lyO1E+kBZrP8uUH1bZad1WAgAGh7LA=
Date: Fri, 3 Jul 2026 18:18:06 +0000
Message-ID: <SN7PR11MB69004F5688F0AFFDA9039DFA9AF42@SN7PR11MB6900.namprd11.prod.outlook.com>
References: <20260702145326.1024800-1-siddaraju.dh@intel.com>
 <e9349915-df99-4d93-bb2b-f17686266a38@lunn.ch>
In-Reply-To: <e9349915-df99-4d93-bb2b-f17686266a38@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6900:EE_|SJ0PR11MB5021:EE_
x-ms-office365-filtering-correlation-id: 4340cad3-96f5-494c-d65b-08ded92f6dd6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|38070700021|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: 4TAwQjVzjgT4fELuLDsK5Kxjh9H3R3q1mHE6cqwx0Jyz8HTDBTw/TZZSgFzqfy9h3WlKHZ4ynk5w7s646Va4iGvIOYviKGDdUkH9PfdKJlfw87SwqiYzYGBZN13u5Jliz7LQ61w6eEMNYjWXCqEBXX1u00xi3AsihS4/OtlVENMoCPUQoPBfYVMb9Jt4I1UjXiEilPRdk20yI785eObkfFsJRbEXWv533AfAeNA37lmBe7GjO7Fox/dd7oduunpFAFnEe58G7Rx1jrUdW4cRWb/letQe+F0OV3v4TDJW8dKUzZpTw/8iun7hvdK2Zt5px/EoAt2uFw0oAbpgLk8Prw5T4rWjHrQlpm/O0h6mzp9LZalNZvAaydDPNu1q9sz0HQHKKjXlqmVkhvFVIFnKQwxxzAii1kfQpdH4dLbed4IcqBwIriAUmYDygtjXoeqP3DBRZZKxKNtvHycBfQ6zwUFU+biuk3Hq9GBUnUwt92SzgPBPKjRCKNrkUUchtVNPzz32INLNlANieOA5GXjhZG2V2R9CHyXntZvSOLE7aQVFLYCylKypAN6CGchRy5ha74OmrHBGosYhyFSYTigsmiGdLE+D6MoluuHoEgcYlZLUm+UG+qBAEqz0N6S9XqU2C4e2O28DDqr51xumoat982VT+bUnFWJ6VMCKUdMq9vtk9ct4hXQ9yLfEItZgDQbv0NzHTbNYEH4L2oEmTqJcS3i/FEmjibh5DZVnHflOtlU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6900.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8vKPPM2iSNoEULemP/dzKMlNYF7Iseyw6FKkKS0KaKQmZTExjcb5yoUBxcB2?=
 =?us-ascii?Q?i+YsV3hPGfZxG8Hs6yRyg45OwAI0oWGWjC4NqI37gCoqU6lnArxf9sC/mqcw?=
 =?us-ascii?Q?DbCVIEJzqf/J1hLJMy1AV7U+p2kehHzOsB9YyhW/PCxnwszO6hBh4tIa5CI1?=
 =?us-ascii?Q?cBL3nLEyfHprr6Ft9GChaFprRvgZEAEJreLJOjO+YEQbIKMx0fx1zCuVKJBD?=
 =?us-ascii?Q?evBllua8MngXHA4+TnFtSdv9YjKUuXmbwX7fEQ3baKKn1sV3FybQTBRg6pQV?=
 =?us-ascii?Q?4fhFi6nSH2K3viJgvAq0xcB8Z32Qg1S0g9CsRyzlK85MAoTyBvawfBJZ1FGo?=
 =?us-ascii?Q?32yijvbrybebvaRNae6rZDjqjyh7P8QAj2ZVyvu+qSwo2caNoSAgJCFm6rk8?=
 =?us-ascii?Q?NG05gcxLzdLRCBx1LxSr3T8yzmYjfjG+9vioecZXEU66/FJhb1pMDVH48x1c?=
 =?us-ascii?Q?rL8oKRwwHNWur7qq6GEqhC6S0S1ddFZRgNt0ugB1llZNtIL5RY0rXIkCBDsm?=
 =?us-ascii?Q?iN1yAXnNd9pXNRSHzTkIu6oRAPmrenYOiXYGZH71KvZNJ8Hv8nBWqH9PJ4PD?=
 =?us-ascii?Q?lyuFw+Q+oV93CHU/D0wSxkEgnYDOIIMejFFnDMi3lmSSCwT4AAIq7FdBdG2k?=
 =?us-ascii?Q?VLqblcey2FQn4Xe0banGgIB6mGy8Ldm9kwOoI+m/mlcvc8hVuhy/ENqk41lp?=
 =?us-ascii?Q?ke8jzUD0erU6dREeqPjshUZ/o86XhmYSpkfN8Kbalmqnnuaeg5gqtnVjg5zP?=
 =?us-ascii?Q?hZpJwYq2sW4XH1OqB+L64feEGVaNZ0LvRdCdjs662kDaAyg12ETeEBmJJKuY?=
 =?us-ascii?Q?zsuWaoHJA0LbXWQJ080mBZ0ji60VGziya+0RmKVUvBK6FKKqb9lMkYNedBNK?=
 =?us-ascii?Q?YEJvqqhZLXGPGLop12Ck7QcMgCagqU/prhgFZmbta2eB1WivlbjL4ampI29X?=
 =?us-ascii?Q?JhyWYOi/uqamHiO8nZtF8djCWCO3oYOxH74C/i0lUO9DCfeO0y15a/wcVD/X?=
 =?us-ascii?Q?BDVeS2tNqFDVCzCjxbO3dEGe2qJbn6qyvkF8yVjpDpKvkhFUJbBSKIizpHOn?=
 =?us-ascii?Q?POV6lvyzA92Y7gxnNI211RWTW+iRYguAD21ZTnYllcZwbUMoae3x/cU9qZ/w?=
 =?us-ascii?Q?oLVhGKSYeOgmVQ16XSzgNPZGXfkMyT88hanRsRDQXYwt+7U2PMf6YuRnSwmJ?=
 =?us-ascii?Q?uczdH2L6dMXhZWRSAdMe3txrFke/dRIHbH5tIGarKl+KAcuIWqjLxzoiDPKW?=
 =?us-ascii?Q?XBF4f8dxaygZ213UnSfwrJTDDst/f61TJzKsVS7u7oEBlOmHfUbRAY9MHiQq?=
 =?us-ascii?Q?7SGqfNwn8IFkw2QiWt+Vv0kMOzBVOQdES6XABXvsJwvzqQ+LiKCOpxkNEGri?=
 =?us-ascii?Q?IeoXHvrOlK6YiRFJOPKO2uXuOxvNIqzFWn8xt11yV4vC+oGO2Q8mmrhAiZNH?=
 =?us-ascii?Q?a82OPfAfYAJbLKwsDHi5l8IFBPXt7EtVWV2Y5Wli6fhcFWpla89rhow6CnnO?=
 =?us-ascii?Q?o/lW+8wGoP+Tjqdvt7Vq4GbrCTCDJt+lwO7mf4vYn+Xjxm6y+LFuOC/Yo6oQ?=
 =?us-ascii?Q?Rdq63vzGno7r+9mUt8Rv81IJfNXAyXc3ZEbhLHTSRsgj395MQoaOl/epYplu?=
 =?us-ascii?Q?tY6EgIFkZj4NXrh7C/c7bqc5AFim8rjyUMCammANyc08T6UHcOX5zSeek5Pw?=
 =?us-ascii?Q?JT0OmREHlfSf+YKgivp4izkAULPgx6kqExHbw0x6CFDH3i4sTck8dv7wUcGc?=
 =?us-ascii?Q?VkRiinOjaw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eUZX9ptZMtgDSsCDUuPEti9MrHIziPiElhMOcCEXaQZP1UrW7OUuvUvhYQCHuNPsnOdnqN1urk9I1GF2Omtg11cEkwYyrTeTSUPpeuAdYPGtnvYQcOBjwE+nqG67X/6ZTfN0M1Rergmz/MY6fro+iISNVskHwhDKdzHzekkvvySyTe+8SpLzWarv6zGkXaSb+EeZmwDC6gL3KnO2DBMMN/DnwtrOLe4tWdu2TB3w3xIZ9W0Ufvsozo4+CFThNlAM0dugu9yW4GNEiVdTiX1PnZ1jP/fEKYJH3pxOnE8H02FzZQMLp+mR/KPCJX2TjBYq1z+cv4wZIalxaPdeIZS4NQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6900.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4340cad3-96f5-494c-d65b-08ded92f6dd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 18:18:06.2232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Wj03VKW+yVEWMp5+myD/yLH7aSaX11ixnqEO56cEjkwc21SFpljzgH4hyCzYj+PWM3y5EQvFlQKWy8M7YhxmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5021
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304650-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:mkubecek@suse.cz,m:maxime.chevallier@bootlin.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:shubham.das@intel.com,m:balaji.chintalapalle@intel.com,m:vijay.srinivasan@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:jonas.wirandi@ericsson.com,m:siddarajudh@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[suse.cz,bootlin.com,kernel.org,vger.kernel.org,intel.com,ericsson.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[siddaraju.dh@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[siddaraju.dh@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63B2B704ECC

On Thu, Jul 02, 2026, Andrew Lunn wrote:
> Please add a link to lore, it makes it a lot easier to get to the discuss=
ion.
>=20
> Link: https://lore.kernel.org/r/[Message-ID]

To be honest with you Andrew, I was so confused since this Link: <URL>
was exceeding the 75 char limit and I attempted to at least link it
through the subject. Thank you for taking time to re-clarify it, Andrew.
It's clear to me now. Have sent v2 patches with "Link: <URL>".
Please make some time to re-review.

- Thank you,
Siddaraju D H


