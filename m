Return-Path: <netdev+bounces-306449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MSOPH5aVUGr81wIAu9opvQ
	(envelope-from <netdev+bounces-306449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 08:47:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D04737CFC
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 08:47:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=H+t77rXN;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306449-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306449-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFA2C3008E23
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6143A5435;
	Fri, 10 Jul 2026 06:47:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D371223392B
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 06:47:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783666067; cv=fail; b=KkSB7uynlaxLkuSFpRjsbFNA9ZZpLZS2PD3/RFJngZMpAiyOc5nqSWYmwiiUxGYz/sMN3AmWjlTPVE86l+ZEii+RyWK27cpZJHFK+NbPTvC6ad8GJbJJ1mM+xQfNwmsJCwc2kUud0Crx3UtGdGj0GdYYghcOmblubQzmSdru7I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783666067; c=relaxed/simple;
	bh=UfE+Hm8ndkZ19/VVW/OJ8vL0HZRBCLgBz/wNosecaLM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T/09i++KgXWG3UY7Fji+u54s98UMkraO8qHaLwRocTNsblAg5PzmoujJ1QNAF7FRyIKZrEWk8k0pabdr0oZQPx7oZULeuvhxuTfUEmXIETQqtF92vku2IU/kTIAk24+n0jaq602J+pzzkehwQ3ExmT8Dr75RCxHTb9h45ewBRCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+t77rXN; arc=fail smtp.client-ip=198.175.65.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783666065; x=1815202065;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UfE+Hm8ndkZ19/VVW/OJ8vL0HZRBCLgBz/wNosecaLM=;
  b=H+t77rXNzqrLP0yWzVdKc7ZogrIdzsgWcHTP9dJL9TUjw56a1OdWwKdD
   KPdPBGNuCYzxzxRX1Mhr+zyDqZSw7e1ZU4xHMi5jjy7Fy5cEoMgWe3V3X
   Pb0z4fQoAsKtyEXAB2S0guYYR8CAOnL95Dnz3YzqJg1dvRq/gzmrkDALM
   gZb4xiqUkQfcYEuniJtTydraZDTcL2zHV15/uwzpC2S5H111A7lIiaE8t
   76hBlvH5kAxnaPeUSCj+pWs277rVsFKqZRiJihrJ1Qi/YCmOX21jHzYEV
   FmW7iUTmci31XWwVb6e+VlxKXveNEMpJ1ZfXsOH0iEW4Y83rT4HdSwi7E
   A==;
X-CSE-ConnectionGUID: gmbHJ7OtRYCgGfqj3AW0PA==
X-CSE-MsgGUID: pcr+Ci5zRNS0o3wN5qV5EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84461616"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84461616"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 23:47:43 -0700
X-CSE-ConnectionGUID: Fjc1+dHLQRCHQeE2Zy9q2g==
X-CSE-MsgGUID: a2hPzF6dRTq0YS+LnRogCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254906384"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 23:47:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 23:47:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 9 Jul 2026 23:47:42 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.6) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 23:47:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDW7KtzA6qAc4mFLo9n/yMnR5rsFHXe/VI7MRWRXs25fTtUaaC6EKh6UUQfPWzDXbjNtTZttOMht2r0/YYNuZcJQjyAtypAZCE14LxI/IbO0o8xZZX9S3BPSV4nRQMgSb3SEcMGBUY4cheNryFZ2ZKfgQh7dWQeQA9G4NZusIcgMGO88NzxhcFAi3qpZ6Mm6ToKZeD2mrqmm0HYseuDDqtmkcTFd6EViOOfUY/NjDTtb5vOl3cnsebQ2F1+oz6NMJFiZMJ08t20WDb1VIP8ibMCkYsjOeZd81p4j+2gqoz5Xcs9wxzdUGkHtt07bzpA1LktEPUa03jekPy1dBTfBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyoS0s8kIVN+SODeiEemca2WvrbjwN9JGIcbrAyy66c=;
 b=VHjg2f9rZMJEZ3iQwiyzKo4DnJ35sX7j1JVh3cuMlu38OyF93kldHx3pMaUHRkNO2tgBOK0ni+vjVwrtZyIgxnFwe6pRdmu6I5MFnHetgI1eeCmgDqSvZRYMsk/d+qWm8UVtxuO6FkH1DVe3RxcrLPaMtg30Dw6RLIlwPzG9neXhSQmTIHiIHpBB6vPZznBcNZPe3esmyx5dTRaR7KI3cPQ1O/M+0caClXVn69wXsSlZi8MEBGdzMpATTWjbPzrrhtHm+18a9sLqN2Si3rrJ4XcqUcQ4gxAfTHGNmm+FdgZQ39yDsov8a5RPZrOGfcf0HDNvqZ5NDODnse6gOcXHww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW4PR11MB6981.namprd11.prod.outlook.com (2603:10b6:303:229::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 06:47:37 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 06:47:36 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] ice: fix uninitialized
 response buffer in ice_acl_create_tbl()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] ice: fix uninitialized
 response buffer in ice_acl_create_tbl()
Thread-Index: AQHdD7wAyTCXJtSWNUW2UiuMnYWx9bZmUG1w
Date: Fri, 10 Jul 2026 06:47:36 +0000
Message-ID: <IA3PR11MB89863CD8586EA0167A963C8DE5FD2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260709145904.164375-1-marcin.szycik@linux.intel.com>
In-Reply-To: <20260709145904.164375-1-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW4PR11MB6981:EE_
x-ms-office365-filtering-correlation-id: c48e00d8-6abf-4a4d-8bc7-08dede4f20e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|38070700021|11063799006|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: 8Nndo8232amMxA2K/fWxo88tENBcg7wzIVGuNGrwuoc8kwvax7WmHVOr6YPIR5luBFDlt2IenzbOdF/tPQ5k2RgWM5SjbnLmqd6U8b8kmuSdKSQLns2YflbUXi3vRZCgPAKB26PpWwwV5mwUWoB1SBfunf8mmbNWKzCx3brCq6S4J79/zyWdbA0buYH7Ovo3UvuT5lj1pYumF2Oj1/+jA22fB1eUeQAXToyjPizqokaJcBtrJqzEMSMnhgwcbeXJ/S8drGSZJezbtLQXaZ6oXA2FDQh1i3l0gf4ZxGrmD5bC/O2Q9tqyPsYRzpEMxkcrzelz7X+Eons4XBExx3CaHQS/xSQ+c47NRLRwa25LBApNeHR78bMJqlnoB7WTcedmh63Tvq3D55QZEmoZ3hsLHX5uX4zxVXDz/SVwuZmEnrLBM9cfupWKwM8S2dg06q+yXcopiFzZf9Z4Zke8MNudC+52xNdiIHPUMgQgv/cl0Td6KCsGdHx5CIj3HFHQ4miY1cAO26xatnIGNUQ5X88okmFbDb2CAOp2Qs23EIRdBAT+sCrxdURXRKdf7AEAVy8PDbUkA+jzkwrSjgM2A8wduz9YCSTYd1hmsInc+6rBkaFNqi5juXi+XtEpCOMLSU4hhWrYU3dg2jMd0jV9LJ5CW7V/xEAOiUVCSdtJ40crGyLl1azlTVrTO6HJQtQwaxYmb3oJcVQIAHk3JvV3RVdTKLcjkalbECJCxQNbrLGoOfg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ohx5qZuKoR9SOAVEZAtKd766PD2nydG/QDrt7qL6yu9E0cSmPIzGnLPvFf15?=
 =?us-ascii?Q?MWTUFGWQHQivyxATGMGH1UIOG/3p7MlWENwuuCC+gGfqvWcCisaVivoeDSDe?=
 =?us-ascii?Q?bB2bKII+AEyzxzLvgezV3o2M0842L8MRT9YsJt34FxG8A2k+CH42uYsCFDPO?=
 =?us-ascii?Q?GEKyQ0Tn01d+oXKrmw4LBrlSWY8fNMw4DbY9cEKCx+ADZsJCxZN2f/otPFBE?=
 =?us-ascii?Q?3qTjATjf0DYwVNPZ0iq05BcH2/fhvXr/gGjFrDzguq9AP0nlnzCA0nX4jp98?=
 =?us-ascii?Q?9GKiohSUKZpMh8WrhopX4DcKZY1NUtxBdtrrMfBVeJRaMsdUVXQOD6WWu4rE?=
 =?us-ascii?Q?K1bM2WpVyOGU+X3rFf28mjQ0eBI0bOenhN+G+4+mFqNNROM4eoEY2dZTHXep?=
 =?us-ascii?Q?WHzVuO52AKLEYsHnTkbIbWK2CZ1FhNGAR4nXYGqOWfjTURvABawWre0xtQHG?=
 =?us-ascii?Q?jg4GogQn0yFbp4iZzVg/updu1hL46r8MOgdOXeuTUasKeVlgyrQxUTcSfMDP?=
 =?us-ascii?Q?8p277jZ1JyA6kzs/GeJi/IABP2zzjBt4VTvos5E0Uss++jyNyrsJTTyqPQQY?=
 =?us-ascii?Q?6QQ/SNK2SkUMHzlskL8y/4rVt1qhhX9vgCt7xopa2odYHJe17CdAJfWFaz9b?=
 =?us-ascii?Q?AQeaZWZ1GH3sd4OlXMVfO8AdyeejugftLY1IQwuJnrMMenBQEq4M8VeNQoFK?=
 =?us-ascii?Q?5Xg23QLusFq6LmrL+KPFy8aKveY8SlG1B6S3XRrV4qT0ANAaOXs26AaLfT+W?=
 =?us-ascii?Q?VFgbazdx3AyRoNGpp/AaZ6b6XZGbn+wDk/az1m/m2UemoHl6MFN/7mJG3R51?=
 =?us-ascii?Q?asCLRr6oVUozPQkWekT94/8DbKNxI28PQNeUsulWDBlZ/wfY2ePKVQbl/Jtc?=
 =?us-ascii?Q?V/ijD3Fg2Qejes9woSOk9LaB0md07LEcuT8rNYjUJdMOl4Tt20CZhQBXYB70?=
 =?us-ascii?Q?JDqnpO4qytOIKBZvfPfm06k2ATxKjrGEQXV94sKfDPpEfyP5DfvKKg51sMjW?=
 =?us-ascii?Q?F+1S1ObBon89P4y6+fvmqEp6/Gdxvlkl3cp7MVyM2fi3ReSUwhJSfFdmxcUK?=
 =?us-ascii?Q?foGtstNUmQCbY1VAmF/jdlc6NisE12P2240s+6xK0ERv4ly7LyN3Gl5Hy6cn?=
 =?us-ascii?Q?rlNCBwgyHR00CoggA0EVnJoa24y+RNcYBvO1y6geN90wyItGkID1gcHs0ewC?=
 =?us-ascii?Q?xeCSay0soBosnbPlNhq5bL21ZKLdKzjkjNrW5A2A5k4p0lH2HIVBfuZlwSb9?=
 =?us-ascii?Q?1fc04LRJ07ftKC1Dcztfrz6q1F4oA3sv/J3Ebrsr3306+YuEjS/qX49CjPQ5?=
 =?us-ascii?Q?ca4uYfnS1N/TnjG9PGwDx5Ab3Y3bPc+kYXPayWx0g0jbUoGyDgaa9XiUYyhv?=
 =?us-ascii?Q?mOS9FiRRrWhjopA2yIKpGrhQdSLov4H/LPVd2VSLPyHstXEelR8KEy8klvSu?=
 =?us-ascii?Q?eauL0ON3u+zgmk7/Yp8gVLQgd7kRkQyARE2xHi3BfxL5U5Pe/ruIjO7aF4Pn?=
 =?us-ascii?Q?7X7hPhIY4tej9/ge8r94sK8K4P1A9rMP//hxDD2Q94OqG34ABDbEQOLaiI+w?=
 =?us-ascii?Q?GOrGiGoJb6MleJZkRcWvjt+cTibEJCiPg5I/b0eSJhMcEV4zBnHW7EZ4+ifc?=
 =?us-ascii?Q?Yz8Z6OauMLrjNxTnI/DswX70OI4DktEDJngi5w9bzKmfx+KzQXcH57st6EYI?=
 =?us-ascii?Q?bHpV31i13TO8RggiHbS9yhlX1d4z0qY2Kl3bt3wgaz/Vmqa2QRlHpiEa5MIt?=
 =?us-ascii?Q?3iw61Yc3LuARzOgvn7CJIBvu5qM4mZk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: a/+KFu8XtEb/U6lIpSd1IZlRW5f+7SCzJLIlmF6JKwZ4WfaH0yq0t4NcadZB47w6wR54rxEP3X+BYVv4lsANuKVkPvzb8M4F1ZtdZWK0Uyu66OVAWVmivHXPIhfKtKVwZMXulv4JOXrwSNnwSJymyWYXeWtRVzdAp/QnyG952B91m1IGuzNcF5IbS4Kcw6pSPBWW0k4KHH3yycQHkVAqvTbokFz4LxizaKB2UAOi3ruQGP91/lywGT/FlgVlmQDGLGwtNZnxVJBeZh8Fobp5kh/ReRrYBrGsyM9eGe2W21nuja1elgpAu4+20OdkmhKbrvECd0k/I8CJe0W2S7aQsw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48e00d8-6abf-4a4d-8bc7-08dede4f20e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 06:47:36.8802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AGyrPDVZ3jv/Hga32CA6H+RVOWRJlV6Joz+/iud3vxG7Rq9G5yfz9rH8yie3Ybl7/zonmoI0umok15t8iuC5QhdzOk2G3ire202hUieMl08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6981
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306449-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:marcin.szycik@linux.intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:anthony.l.nguyen@intel.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:from_mime,intel.com:email,intel.com:dkim,osuosl.org:email];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D9D04737CFC



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Marcin Szycik
> Sent: Thursday, July 9, 2026 4:59 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Marcin Szycik
> <marcin.szycik@linux.intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next] ice: fix uninitialized
> response buffer in ice_acl_create_tbl()
>=20
> Buffer is uninitialized in error path. Move assignment before goto.
> This buffer is only used for response, so its content doesn't matter.
>=20
> Fixes: d80ee68614c3 ("ice: initialize ACL table")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202607022231.FWjSU75X-
> lkp@intel.com
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> Tony, please squash this with the offending commit. It's not applied
> yet, so hash is invalid, but I don't want to resend a ~5000 line
> patchset just to move one line.
> ---
>  drivers/net/ethernet/intel/ice/ice_acl_ctrl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
> b/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
> index a76762e3aa46..4ea08bd9784c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
> +++ b/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
> @@ -354,14 +354,14 @@ int ice_acl_create_tbl(struct ice_hw *hw, struct
> ice_acl_tbl_params *params)
>  		return -ENOMEM;
>  	}
>=20
> +	resp_buf =3D &tbl_alloc.buf.resp_buf;
> +
>  	tbl =3D kzalloc_obj(*tbl);
>  	if (!tbl) {
>  		err =3D -ENOMEM;
>  		goto err_dealloc_tbl;
>  	}
>=20
> -	resp_buf =3D &tbl_alloc.buf.resp_buf;
> -
>  	/* Retrieve information of the allocated table */
>  	tbl->id =3D alloc_id;
>  	tbl->first_tcam =3D resp_buf->ops.table.first_tcam;
> --
> 2.49.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

