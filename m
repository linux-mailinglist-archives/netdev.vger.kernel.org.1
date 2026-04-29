Return-Path: <netdev+bounces-282326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAxfG6nN8WlrkgEAu9opvQ
	(envelope-from <netdev+bounces-282326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:21:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 06227491C89
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A2723003634
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4693837A4B9;
	Wed, 29 Apr 2026 09:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RBxSMqjx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7FF3BE65F
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 09:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454470; cv=fail; b=XHyU5mjV6PemBS2uHZpfWFe9X6KJTMJJFuDCGGnLQDY4BXjSf4QpwqEuBgUTx9y0pczAo3KtDXzVewBsVHPqbcC/mamwr/JTgLHSeGKmH8/+PgWK+dHR0/OpuwWoKEWcXV9tYgZRzDB+lzAkjrPg48rpZPjNC0z7ZkwgNMdfPXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454470; c=relaxed/simple;
	bh=SCdoTeBEogNn4eHv9OSLJIasY5Z9Luk2+Tk2Hgp0yv4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nX6QsEDvarnY88863Z9YnHiDwpzOx48KsdVvwGStiFegzxrmO9sPd/RixNUu1r0KQDOWZCmyeHVEFYrEpVcbml1niWTGWz8BJAT09VnWyyHKiI798avzGBgnYvvpQR/vPhjnDtPBrxwqZEYl4EqDEyyLIqnNeaUtAl4Z6RSZifQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RBxSMqjx; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777454469; x=1808990469;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SCdoTeBEogNn4eHv9OSLJIasY5Z9Luk2+Tk2Hgp0yv4=;
  b=RBxSMqjx49gQv9AU2bbtXO7jg+EI4YVfgRhXZB3VmK7h6qyLrolR8sNr
   4oSyY6CX/moCjaUjFQn7dpVNQk2uDsFrY4UkW+OifC0A8at1WUP4dERdl
   vYMFGZAGMxUBJNNaYc80/z4nKebnAalmw9dIya94cyqTD37ahnIffrbSa
   JnvIsdXfCQqnHD1i/h5t/mNQUMK3At3ORWLr3qVkakaU5GfioKiGSF1ch
   ssZz9PhKAIaIPgzPdD3u9R/DbJVr89ptVJ/veqvOfq08NqdQcU+UHkDug
   5lsVUuooFLQfsaiLhrIIzkBZYlr4JD6TXJvgof6ZO/7fl+NYP8GyuFpGC
   w==;
X-CSE-ConnectionGUID: Dk+gjlmwRvuh4S+tbELdIA==
X-CSE-MsgGUID: JCB+IBgUR1S/bMhbTSYSnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78489953"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="78489953"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 02:21:08 -0700
X-CSE-ConnectionGUID: UcFLyum8RKGXFdyAJLa8Lg==
X-CSE-MsgGUID: 6gQHcgvAT4OzUw2DmJZNvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="227707035"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 02:21:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 02:21:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 02:21:07 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 02:21:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3qZtIptZUJpEaUmAVfDWKqGd+hHi66cCIjoUJkeel3Lf3nv2LGEe9ubDYShbzd1dXfQSF4sO6OBvEDNxFdleyEHXqNy3qpULPZWCMgqfN4NmmB6VAJWNGhxgwm1dpCNHTn1twzH1j1lAPeJym0LObSTTQTo5tWpXy+oOJn8XXnm4/SnRhsvERu56BhWSD+URetIDbOa0LOU6my5yE0cwse/9QrkxSOCG4GUUbaqBozT4N6oqP5BM9DQAq51qCOlgKGwCWIh74WgXd6U6BYNms5RuT/0YT/v1tUWYk8cMuk+uTOuIWz9pT1jdzdtn8lk8FbNpwVRnkAO90lHvC/ZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAjChpaH+QLWC5R7n7HsZv/Pm8VD9lE7M3W34yhW4jc=;
 b=Eyk4SsfoVMCka8eCACLY8FGanpZSnFzYLx7tzyH4vtqwraU89d2QehIUQPXQKRw0rm3lsW+QiUKZCmM1BCuR4XwBDWVMIr6OcnpzO2C/m8j8vBUn8SBGrEN6Eykq8OXLNlPi+fHeukhYoMW45K6R7hh3YceWXpy4XtGZBqzMVOZ2LJfSVsntFtqr60E+ChEapjEK4yjdr2jmVDEC/7ofu9tuscT3wm7eIQShu7b5Z3ZpF4lfbdFkgxZJra7m/etLYs8BuSzgPGmrS1kNgbdk12RWFOWNeh6g4tCvJhmjshTy9Q/w+xLuGiBALRxXuUT7EGM4xvxebR3WWqDuK7q6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by BL1PR11MB5303.namprd11.prod.outlook.com (2603:10b6:208:31b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 09:21:03 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 09:21:03 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Greenwalt, Paul"
	<paul.greenwalt@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 3/3] virtchnl, iavf, ice, i40e:
 add extended generic VF capability flags
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 3/3] virtchnl, iavf, ice,
 i40e: add extended generic VF capability flags
Thread-Index: AQHc1yUPxJ0DBdPHT0ySGOF+3TnaPLX1xJLQ
Date: Wed, 29 Apr 2026 09:21:03 +0000
Message-ID: <IA3PR11MB89860B13BF6848A4A96B4EDDE5342@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260428143716.9653-1-marcin.szycik@linux.intel.com>
 <20260428143716.9653-4-marcin.szycik@linux.intel.com>
In-Reply-To: <20260428143716.9653-4-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|BL1PR11MB5303:EE_
x-ms-office365-filtering-correlation-id: d3f4e511-033f-4b28-94f3-08dea5d0a2ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: DR69Sl0h9pq8ZF0aINIpD5+Cicva3k1CLoP/fCgBNjaK2482pwF6MhBsQP3D1XsiJ3EpHMm98U2BZn0pPf4OIAIQfMoWbexMzaJlL3srs9vw36ADHT1wC9lvlIGV1Sg7gHuayF6hPdVE/h5AygxlgKJcP2trAZjoWtwUEP3A/ZwrFiksN5SWik58PoqUJYTxpes9T1qx6mVBuZKf9PIWVmFapX9kMJLCOu1BWXs4bWXsV1FExS9b43W02335ZMhUG/ZjWkjyFyKMH5GmCOdAAEFEMsrFh6X8Pkj9/q1ntrgXebDlUAG45RvXm1Aq1B+MN2euHzcSryq8ukt7iuqwlPB8WqiW+TKjw0LrM4gHZ6q4jcoUD41hyKB/VgzyyjcSph6zJ74wUd3MagXytOKMMwEpQgLogxD7BOFHw47+XejVTw6EVhkbwHoB36AI/TVR1s45Xjw1bJ+hV+gjMTYOww7gTnUuXhrbrBOqO90VVSpa6p20GdWUaC76pqrbl8QqVUgdl59TsHd0qmLc/DZovOP2ptvHI9ONzNP2JXBmfSHlRIYcQd5IcvygjMYvzfTiSibFWzoUf3s81cAtCq2/hOMCzBznDKopmJ/7PfiXeW5WCzLC3/tGvu4DGvZuXrGYk+0HZjfVPQf5C83NcnHuc0KSF+KcVwOyJWY69qk4vLerBFhN39ibIk/RhWzAO/TUCOOZ/XArbBQNyKdg7IdhpDz0uC7ioDqIxZ+CphbLCvBGmTwVbZQPtCQIi9nXT5/aW3y+PMzqIdvBFtLvmn8CHVLe90znaux0g7LvK73lEpo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hEo2EFzvSyMIj8rbaJDPZs1PpVDs5genZEhqMrANvcRNcBqYR/J+YbzWM8Iw?=
 =?us-ascii?Q?Wi5HhsRRpUCyZsoRedVg7+MQrng0uIPSNn0+FAPRDfWqIqjxkD710L4c6wLo?=
 =?us-ascii?Q?PE7AzUHXzNXKVP776HIDCWT7JBQFMGERjODZJjsRBuaCTfI+2R/nxtYIW8x0?=
 =?us-ascii?Q?FFCJYhXhF6xp78wpBO69LU9X9nbC6XKpofKcvIUzRm+HYiysiWl3HWjUeJY+?=
 =?us-ascii?Q?ipDOmLfKGikPB1IgF9oui+21kZjEXQ2gTXyTHgJQye6LJhALg2hjBAaFcUe1?=
 =?us-ascii?Q?p5rlffv5BkdGUI1zfJAVCyQr21uiUGCru/HpDx1fVc5IRJ1osjzl4EwKEXhy?=
 =?us-ascii?Q?c3y3p2dE6NcaJCVmez58En281pg4t3iWAe8NmMHW/jkq5e9i7cH9+ARndEFG?=
 =?us-ascii?Q?0HHC20OAJBcj7l0oxjArBFmGvOJEStAv19AbmXTiVK9yoxafCrwFmgpLuFMR?=
 =?us-ascii?Q?BN6A3m+jkT3NdlHKzAxuuU6HPVDNKOWefCXCaqZdFpuJQwiEy60P1ZDO2H8p?=
 =?us-ascii?Q?0YtzszbgO1+DGee3i88jlwPd7+sloqOqz2PyfhU32pbBuV4m9Q3NdneidwUD?=
 =?us-ascii?Q?bGbFlZQhF+IrLhTsRwKk3Kh0OCwkcMD/ZV3t/CyXLlEE57vfmuHNERkXxqmY?=
 =?us-ascii?Q?agKVq5rIZ37BO4v7FxKlpGAVF57JKfDaTGx5F6QUDW16BJKjmJ3+m+N4cE2Z?=
 =?us-ascii?Q?UYniAK/DrKasw54k1vpeAP90prF+muDOc+29beHhDsET5rNk0VqaZW6lpc0W?=
 =?us-ascii?Q?8FdCmkBfeknXhFXclteam+mgSPUQk6TFXTpWsqenHVD/I+UUsyYWTAcNJLP9?=
 =?us-ascii?Q?yHMX0e3r06racZN4b0uYYmJ0vutyvr7tk5y/gNoF+SemvaIQ3+oWAi1b2D0M?=
 =?us-ascii?Q?+vCxTWtR+eNFbRdItIemYJTbVT42pDZ0gZ875pWPIF6IxKn/sE6gtyHGeLaY?=
 =?us-ascii?Q?Q+mAKxaQGEAmfcQrTHXBAHhAU0g5itS6XJTxy9FRzYbVZnsB02mzhKsxrUIU?=
 =?us-ascii?Q?O1rcAmSeAEMV6gds6oS99R99ifjidaGx47SYM0sT1D8RBTsA7dIERLGPPCP1?=
 =?us-ascii?Q?8mITwA5ItwOUVit5aV3viyhXkXPfWtXR3Vj0Td9JlYiwQs4S54978bgoMtaW?=
 =?us-ascii?Q?IHgztZQN5cWMT/oADEmsIpD6leXYsMmUzE6UbtGVKeT1aTK0teGdm77Q1tDA?=
 =?us-ascii?Q?yqtWcJMu4Xpv1hPzRQCD5R6Cr2FTTN96iogFEVBeGO5snDapotx7kLuse7M1?=
 =?us-ascii?Q?V63zg7TNMtsKuICUvUW7Zl5ju9dBycIXNJXkpNEqs7x+ZmCFdxvyN0xdIAcj?=
 =?us-ascii?Q?Jp9eOmlXpnGwchH5VRcXihrZrEYdaE13K9EeIUtg7DpgEc/zSRr2fjTvimm3?=
 =?us-ascii?Q?3t2dGAZZQ/o3+dbjtULktmX7MKJqG4K6jsVAM9mC0lpPafaPmQcIAGk2wUGR?=
 =?us-ascii?Q?om86QmFUF0Q04PdEUKRJrBwyq/GvNpCStBZcCZ5P2qnp/pIVDusO2EzY5ANe?=
 =?us-ascii?Q?mj5pSaRJmzeXdBkZye2Vx8rXALIHC4khrk/zwC+M3rkqqg1u7v0SIUNB5KFf?=
 =?us-ascii?Q?TOixMJHl/gj5ar0TPitApvj6JVK5iJHWYG/DdDJmQGqauWXgwUVF/xApYm0P?=
 =?us-ascii?Q?vP7JqI1VCQR0tGPM9RUbHTLQoMHIwnAHPGlO9gxc3H820WG+ux/S/D75Lxjt?=
 =?us-ascii?Q?HJHCwyM+3VMEDSllDVY9n33GEQgTjHv3gqr0ITHBizDpTGECpCowx9a+ob//?=
 =?us-ascii?Q?ds0w3OSbGRLptYDCpaLQ+4UdoOzbMrw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: r4P4SBNnw11Sbvp5o2Sw7oY+M+IPxokOxp+aq+Mw70ozlR4VAkrCO6X+DOGHENYF1hZj7Ik2SHv4kgJmOWQmQP6pQGrji7b/QMx2RY7sRyRLvfrgb8xgmNeldUCfSwprB7VClKSFAMPSguuYv43hEhWaecv2j75ZdYM1xPVBdLRRHy/2hyjFSrgTBMCyXwaOrnZv7ai6mkBJGBse7RE+S0FFx0Zxv2h6WZSzUHxZhpef4JIoqpdanmc412LJbZku8csZqmFJjUHKx53GHFwK3qcGBMOWp7PZrGgIpu/jvPWuE97tfSFcpoo4c4CJ1OoCP7mT+2L6VBqZi7HI8L4cZA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f4e511-033f-4b28-94f3-08dea5d0a2ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2026 09:21:03.8085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WA0eqPStM3zhxuMCfCoXHkDhwOx5xPNyz6/IE6swdMTFObJRI+U/Y6IbigzwQ1sw/Oj/+VYXAVAljVNl1wo0WkDdV9wSMZj71EnUz5IKh8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5303
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 06227491C89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282326-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[IA3PR11MB8986.namprd11.prod.outlook.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,osuosl.org:email,intel.com:dkim,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Marcin Szycik
> Sent: Tuesday, April 28, 2026 4:37 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Greenwalt, Paul
> <paul.greenwalt@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Marcin Szycik
> <marcin.szycik@linux.intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next 3/3] virtchnl, iavf, ice,
> i40e: add extended generic VF capability flags
>=20
> VF capability flags in struct virtchnl_vf_resource::vf_cap_flags have
> all been used up, preventing new flags from being added. Note that
> despite not all bits being defined here, they are used by out-of-tree
> releases of Intel drivers, therefore cannot be taken.
>=20
> virtchnl message size and structure must remain unchanged to not break
> reverse compatibility, therefore the existing virtchnl structure
> cannot be extended with additional fields (e.g. flags2). vf_cap_flags
> type cannot be changed to a larger one for the same reason.
>=20
> Bit 2 of vf_cap_flags was reserved for exactly this case. Its presence
> in message initially sent from VF shall now signal that there are more
> capability flags to be parsed. If the PF driver acknowledges that via
> VIRTCHNL_OP_GET_VF_RESOURCES response, the VF will send a separate
> message: VIRTCHNL_OP_GET_VF_CAPS2, containing more capability flags.
> Note: this mechanism is similar for VIRTCHNL_OP_1588_PTP_GET_CAPS.
>=20
> The new message supports flexible size, so more flags can be added
> without any architectural changes. Care was taken to ensure that no
> out-of-bounds reads happen in case the bitmap is shorter in one of the
> drivers.
>=20
> The new message includes the original 32 bits too, for consistency and
> more straightforward parsing.
>=20
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h        |  19 ++-
>  .../net/ethernet/intel/ice/virt/virtchnl.h    |   2 +
>  include/linux/intel/virtchnl.h                |  55 ++++++-
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  84 +++++++++++
>  drivers/net/ethernet/intel/iavf/iavf_main.c   |  60 ++++++++
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 138
> +++++++++++++++++-
>  .../net/ethernet/intel/ice/virt/allowlist.c   |   6 +
>  .../net/ethernet/intel/ice/virt/virtchnl.c    |  86 +++++++++++
>  8 files changed, 444 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index 64576cba3a01..5d812b0a52a3 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> @@ -343,6 +343,7 @@ struct iavf_adapter {
>  #define IAVF_FLAG_AQ_GET_SUPPORTED_RXDIDS		BIT_ULL(42)
>  #define IAVF_FLAG_AQ_GET_PTP_CAPS			BIT_ULL(43)
>  #define IAVF_FLAG_AQ_SEND_PTP_CMD			BIT_ULL(44)

...

>  	case VIRTCHNL_OP_UNKNOWN:
>  	default:
>  		dev_err(dev, "Unsupported opcode %d from VF %d\n",
> v_opcode,
> --
> 2.49.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


