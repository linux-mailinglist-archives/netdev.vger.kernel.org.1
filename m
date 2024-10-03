Return-Path: <netdev+bounces-131574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D40598EEB1
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C7B1F21D8C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0638156F2B;
	Thu,  3 Oct 2024 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXy0Oom0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B9F146A73
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957025; cv=fail; b=b8avMvdytpXCopccKYyYO/9HFO636yftLOBTnpcej6+DOTSaxMYQnzGbZp7SLRKsHfVuiTxLXBJ1UczwhVJQqLhEv9767DtqLxGqJ7KyNrwt2d+0gNF8HF8qxNSV8CWkJGb1hPbYsovAdK7Dhch5nWAz0iJ7A3tE0rFG5wOwK2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957025; c=relaxed/simple;
	bh=YBCeIFKe2lIRSFaC/uQOsclW3zoDO4DhvDxGASnA6dA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UlAS/xHw6rrGinOvSfYJobitcvOjjeFV3h9LKDBua/mxtUqgzXKzDPQzOXfS4oQes5gL6EarZg1SQNCrLLM9k5YQMUZ4TMTX2FjzaeLVcvEtvWV91N56jT4/2XEEBYV8AcH+SgNeW7MdQMeoQLdr01Tk8/SGq6zMNl4Wi8LPgXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXy0Oom0; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727957024; x=1759493024;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YBCeIFKe2lIRSFaC/uQOsclW3zoDO4DhvDxGASnA6dA=;
  b=PXy0Oom0FRfPCAV/kEBFgMik4zbhe+39Dq0inN74mfXcPTercYQ/Nhfi
   svemXf4ivNowpgU6LWrYj7g5vX74M0OdaVUxY2wJU571l7ZyHV2OCL4jt
   IsYTiKC7pcMCUt0cFMk96Js5ICxwOhvdDuwgSJrpQG+Ts/JTwa0vmFiQ0
   r0RM73lHNlS7uOaC5sSOG5pG5G+D6bdqmf02swwOqcXjL80vWdWpmQgFV
   OsIlWFWj+A5umh2CZyfvrsjc69sPbN4hgEok3uoRxAv/H9u0sTWgT5Uey
   zbxiL5/aOgL0g1vQsaLQYKfSclI541qZ0Yz0BEV1n/u85fxix0paH4X4g
   Q==;
X-CSE-ConnectionGUID: l9+jqGFhTrKMMOsktQ5d8w==
X-CSE-MsgGUID: MR4PCIhNS9yTZ0IbvPRvow==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="27299530"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="27299530"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 05:03:43 -0700
X-CSE-ConnectionGUID: +0J9O1BlTYuzS3nGXc4OoA==
X-CSE-MsgGUID: q1vBzMpZQiSFiyHraiBr3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="73914681"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2024 05:03:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Oct 2024 05:03:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 3 Oct 2024 05:03:42 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Oct 2024 05:03:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHaUYYDRsKsoM9kDOlOn9PdYKZA6B7AMl1I9BRW8vQlKPTEWPY2NJ9S9NAJSyrtq3hIRL9KvKO5dzjvECsBdL8gijCDkC9K8cEcxS6nVMm++Co8Xts4rGHxyhEiOTrihYKVUfHrrxR8v31XZZt8Rd6n2Yj96rlU67x7WZJzY1qJxO7Vmffrr5p8iDfzY27UDsVQ3J7ue8fEM3FKlcQg2pWET60FUEOrhkWivnnna01aB/0yFJa/re6U29LmYMMlvgICyrXAO5dXDlQ+WpW4LJByf6uMc257HFUmE9Y98rfFIHZ8DulhmBu3uBaUA6aQWoIikqAaUSjfsPWTIQ8xPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+1sV0Rbwvy3k6OeB7U4YYswzAFLtAzbNlc7i98BkSc=;
 b=ofo9vilnfHdVqvre4IoYnLoQjV3t9DGUcselrmUWzYNhoB/Ghu06WpTwzARMZNFlPFlJPAgOxo1eGyd22Q64F8d/w+ykgyoqn4ahX3P+by+/QiwXO6ci+lgRAk375rMs5mIfa2uNEv0qg6pvX7jb1LJMEpfFqRmdnge5GlQVM99yAtyTuEg/nxOOIhCNqhd4DJqulEdL29RkWaNoyptmV6Ow4dljCdupjy+fNtPURvon0gX7yRqQ8XtPy225koDp29XjOIhG9Fms0++OBe2iiNvztCozckg2oFDm/A0lF781YAICDzMvei+46WaPITZASA5B9Ijmjd/mXTClmZwdhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by MW5PR11MB5908.namprd11.prod.outlook.com (2603:10b6:303:194::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 12:03:38 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5%6]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 12:03:38 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Simon Horman <horms@kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v1] i40e: Fix macvlan leak by
 synchronizing access to mac_filter_hash
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1] i40e: Fix macvlan leak by
 synchronizing access to mac_filter_hash
Thread-Index: AQHbDZi+VcwW3r0xoUaiPLp7r4Gt/LJmgqgAgA56pPA=
Date: Thu, 3 Oct 2024 12:03:38 +0000
Message-ID: <SJ0PR11MB58652BB4D2C5245CABAC236B8F712@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20240923091219.3040651-1-aleksandr.loktionov@intel.com>
 <20240924065648.GA4029621@kernel.org>
In-Reply-To: <20240924065648.GA4029621@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|MW5PR11MB5908:EE_
x-ms-office365-filtering-correlation-id: 89e4ece5-cb47-44db-89d7-08dce3a36a5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+ZZA2rnYpYONqgr7SfNkQBtt13f0VHu20qRTJS63kYnwOTY4CuxUj6aiitRV?=
 =?us-ascii?Q?YkxXbp7mucTrRfNkcea3iLX5iirdz9r0UFBrd/n0ldUDZyJMMq91GhHgaSvD?=
 =?us-ascii?Q?EEmbASW9gBlo6hJR4d18g+Z20EiQjCXu8J+P2Ld4atUlMizXYHDbvZrZBMlZ?=
 =?us-ascii?Q?rs24KFzJd/6QdXPJ2lS/xhaZpLNi7o8X8zJSO0mIt8uprIVKgEqMrsc2FEXS?=
 =?us-ascii?Q?jSAj3CUWlUOnZghdNvgUXgCCsJg9ygm4lWKv5IYUuFmxdPSKRMX9cfXKla8Y?=
 =?us-ascii?Q?YgVtBcwVwWnQNXakS8sZ1Hk0jGjouYLl82LHDUkWw8jftCwXPFh81gifeP7W?=
 =?us-ascii?Q?w2+eWahNw5auKEQKKCzEMAvxERF8uQUN83VLMClljqJpSOx5Q+viPI11aVj4?=
 =?us-ascii?Q?aMqvuHbO1KxxYSqI4OYkq23SulLiL4smobP0HnpxDrwJp/9rT8L0HHF5fIFM?=
 =?us-ascii?Q?hxmcH6SVtFXhXHJkIVwHrSc6mOP4enG0HXkaIRqk6rIbQT6/18fH/IVmDq6v?=
 =?us-ascii?Q?QiLlg2GoshT+nfGI7Auq0uS5eTSaf2MzXa0FLD5Ph38B//Pzn7RFY7ZRhMJV?=
 =?us-ascii?Q?hIVgHN9oCTDGriEEsV7kJUHDWOeHfrr1ziC+rN3zvCrWYcNkAKOcItSAM3rF?=
 =?us-ascii?Q?XKhFV0USrr03oDHOBM0MC3aiJXSfeaGpP5nclnui1mTno4gT7ZHREG8Kr6y+?=
 =?us-ascii?Q?C2CY98C7CEoYLgi5Rc42cfuPlCfC5novnc6AUN8FZXjRx51LYOtGAv6Zrx/g?=
 =?us-ascii?Q?jVjERthCYusMD4CNArNF9rE+wQabaZr7OufJFU0sXCYoG050lMazspn8Cw3I?=
 =?us-ascii?Q?Hdc69/r4aLyTujesEqQZGCwUNPMLlec+n5TiotsrJ4INc/4VIoxWo3Xvu8FA?=
 =?us-ascii?Q?AKp/kzCY4wZ6Ikwh2GNtwwE8vPhgBwQcS2qownQqltVLXJn7fzYQTuuSAE9f?=
 =?us-ascii?Q?MkQws0V5W7xr7mU/1o+V9jrPL+S5fbyRxxYWf51BTo6ergy6Yp9GmmKSkc0c?=
 =?us-ascii?Q?oyG7azjUTqO/NbhJjUFm4KugBdH3yWHC3j2vELbRmRLtFQzloMWXydB+7bYY?=
 =?us-ascii?Q?BVPRxFL1qL2FPairJ/bULPOAEwMNd2IheCU95ng/K9h5dxAeronYwUWv811N?=
 =?us-ascii?Q?W8fkQZ7+HIcxus/W/1+fY4NWNEIcXb5+bszAL3c1J2STxhP2VfdMWVVOG+kv?=
 =?us-ascii?Q?JZYLxxjTuQzl/3U5KAd3zT6KHPSjf9gbtWi+dFM6Mr5TwCmjtdo0X8oXM9Jz?=
 =?us-ascii?Q?kuPWKk4J3nYZCPPg5poo6o7EFwn5Vh4+ON63B8FUbDAyg34fhoF6Wn3vDqIh?=
 =?us-ascii?Q?xHgolScTr3Yxn4nnUVmm0fDyNA2Du1LQRvgZZ6rJiM4Q+Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WEs14KQ8ptyA7b6Cc/vQ+EPkvfG/or1j2HoyUYgfwF7Bm+BEWTY1s0Tly5uV?=
 =?us-ascii?Q?lIwNHUCdQCDKME9/lpE3UefH5qjcK4YD/uk9FZgXrTCN62r014NHgRAIQnId?=
 =?us-ascii?Q?zdNWexsxy2KO28QsM8dDihbu1SjY5mO7FpBXL/zBRfNLeMVpfjPQmnlUOJiM?=
 =?us-ascii?Q?R/re9syFWjCI4ANgTxnu+brUMMFx8thCiGoqzloT3t0MKko7u8KsRXrYx9bU?=
 =?us-ascii?Q?lK8CWBk4AEkBM3ffhQCgOMAr+5414Y4P7+VABDEnu8hiFIDqUxtPcuBhO/75?=
 =?us-ascii?Q?HFpnIWltYLuj10j0sqB5NMIqWEaNt8RHW+G0kpAXPGi2SGTLiQ8hrEMhfBi0?=
 =?us-ascii?Q?aKHhLLRjpHwNenWrzqsqQsfV1UZNacY4eoZTpnikf/m0Sf0doWa+l225McnR?=
 =?us-ascii?Q?D8YHo6GfxnSJQzf48TiGPvHYXPyl1X5fEH2mryMH78LKDdr7oliMVTC3pH79?=
 =?us-ascii?Q?wGjfMLUhUBprLr89BRFBp/o8C/xpH6s5pxw4EoJ5dIV2HeohP9SWuFP0MCtE?=
 =?us-ascii?Q?fPFELbIuiP5g3gtr9noxA6mswJtojq5XvixkrZSKND6LpN7Dg584zOverRRG?=
 =?us-ascii?Q?lSutyNn9uWfwGyQU0BGWglU3LsnLaBz8k4AQmXKEVq18jdhy2yJnyXmJF+Y/?=
 =?us-ascii?Q?Jev8zF5CwUUij/chwCKgsDa2gh6J4MySTHTSs8QcnyKp9ZZNzb/y+VrvuS0H?=
 =?us-ascii?Q?Rvr2pCKRCWtOT6Qb+nVZ3nEbUe9R+Si33iEyOIz6+5SEC/cqVO2d66YECY8l?=
 =?us-ascii?Q?RkPOLiHrzJ/Rf/EJenZ9UOnKh9HiYcSdZswR6NaI+Y2Aq/LL26FaNnYPfxKE?=
 =?us-ascii?Q?vl1LFE6NzoK7kfvainxsTJOQWbCTQWgUNpQX3dfC5FO9N+YbfdDmAGzR6CG5?=
 =?us-ascii?Q?KziGiqnaXklol5fz4cjKShM7uTYad8PLkQJ2iIaeyBCYo+N4PwI1ZxJnxvJI?=
 =?us-ascii?Q?Tt6UrtLHjOtoz3BKfgzDYNSrobnB1WwRbfKmpaHZf+snFDaDZtomEI69SMaU?=
 =?us-ascii?Q?waMgw2R2aTyfVuGzzflpNFs7E7n8efW/YU06oA4I49J9c3KMrXlIxQB/pvUr?=
 =?us-ascii?Q?Pyh8FvM9nnNB81QcLyefkf6dG5EblnQycAcN093G6JBr6gZ45VYmveEo3Wlj?=
 =?us-ascii?Q?H29RUgDiWcuabYW3z7plBdVQrBU1sTUHtJ2211iI1rZcVCpqIbZ7XboT3gUS?=
 =?us-ascii?Q?YwJfeuYeuQDyNnz0a6gv7No0Nj/8ubi1jDzGbB9UPe/Ow0m6XmhvXtaLRdAO?=
 =?us-ascii?Q?yYsQP8DdWxWLcEumPkh9xPudEYPEERXnJobeDiKboCLyJk32TpLnTNcWzPTZ?=
 =?us-ascii?Q?MfXTt1UT0Ke8mLWs8G18veGwU84Dno+ULbofCndlahBz1f8VWr5EPJU/3Dvx?=
 =?us-ascii?Q?MlzBT9GG7vBGNtMEAxL7MAzAq1L0xYQ0ds7We9vN1SrzBhRBEoBjx6Wr41s7?=
 =?us-ascii?Q?ZjlNfxgx2OAHz1RYp1vDDWt00EdtN4bC4IlaIpRY8RVSD9SU85znlH8IoKA+?=
 =?us-ascii?Q?nrLdgrKamR/ygCVYth0/HjoDziopbappBOYnt0d8x2qclCfsAwWlsre/Pseb?=
 =?us-ascii?Q?Ae3W4ZTYZ4OIxzxa5Ut4NJuiraPfnUePLdYn3A6Yv0we+/lWStRfwZcxk0Iq?=
 =?us-ascii?Q?6g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e4ece5-cb47-44db-89d7-08dce3a36a5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 12:03:38.3410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: emK8DysU8HscRYnrh/Lt6sTL2x1mPHw/p7GVbnNSj47zmSCMgeZ7IgDBaFUqG+Cv5VnFarABdY3v6cIkVbxDJYFPTb+rcJ2hphZr8/tTG60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5908
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of S=
imon
> Horman
> Sent: Tuesday, September 24, 2024 8:57 AM
> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] i40e: Fix macvlan leak =
by
> synchronizing access to mac_filter_hash
>=20
> On Mon, Sep 23, 2024 at 11:12:19AM +0200, Aleksandr Loktionov wrote:
> > This patch addresses a macvlan leak issue in the i40e driver caused by
> > concurrent access to vsi->mac_filter_hash. The leak occurs when
> > multiple threads attempt to modify the mac_filter_hash simultaneously,
> > leading to inconsistent state and potential memory leaks.
> >
> > To fix this, we now wrap the calls to i40e_del_mac_filter() and
> > zeroing
> > vf->default_lan_addr.addr with
> > vf->spin_lock/unlock_bh(&vsi->mac_filter_hash_lock),
> > ensuring atomic operations and preventing concurrent access.
> >
> > Additionally, we add lockdep_assert_held(&vsi->mac_filter_hash_lock)
> > in
> > i40e_add_mac_filter() to help catch similar issues in the future.
> >
> > Reproduction steps:
> > 1. Spawn VFs and configure port vlan on them.
> > 2. Trigger concurrent macvlan operations (e.g., adding and deleting
> > 	portvlan and/or mac filters).
> > 3. Observe the potential memory leak and inconsistent state in the
> > 	mac_filter_hash.
> >
> > This synchronization ensures the integrity of the mac_filter_hash and
> > prevents the described leak.
> >
> > Fixes: fed0d9f13266 ("i40e: Fix VF's MAC Address change on VM")
> > Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>=20
> Thanks Aleksandr,
>=20
> I see that:
>=20
> 1) All calls to i40e_add_mac_filter() and all other calls
>    to i40e_del_mac_filter() are already protected by
>    vsi->mac_filter_hash_lock.
>=20
> 2) i40e_del_mac_filter() already asserts that
>    vsi->mac_filter_hash_lock is held.
>=20
> So this looks good to me.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
>=20
> ...

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



