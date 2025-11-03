Return-Path: <netdev+bounces-235168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E99C2CDF9
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 16:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EED418C1F43
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 15:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C420C316191;
	Mon,  3 Nov 2025 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXY1A/q+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43506315D45
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183737; cv=fail; b=GwuKQF5x43jnl0VJjB3fLjZ6fXdvk49K6PBYqVdSd9YJtXzL6SJvDGRL8Jgi1KlW4XKInTuJeEBspbBQ5rRTcrn5SGZAJ5fZv0qcTslVuSW5XqPKxjU2yzmLUCTqy1W1Idy+u2uqp4bYX6KXAFLkSz462ddHOjresT9yzWWAG94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183737; c=relaxed/simple;
	bh=CJfWBZxbY5wra22a0bwA5G/8t0qOPWY8i6acwuVnccU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UztYGx3rO08wp4qOM5odNyOuLiHxkFQ0Sn4Xq5AoLmIPO/CtreIKVm91bA76e+9Cp4O9MabtzKE0DATW65C4yUcNocXBvbFsndIbh0HscvikfZ5OfGjIs3ErfKu0Og9PMxNQbelh/X7IJsv3exaWXrQxxxiDchmdnW/+dHzAzU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXY1A/q+; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762183736; x=1793719736;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CJfWBZxbY5wra22a0bwA5G/8t0qOPWY8i6acwuVnccU=;
  b=FXY1A/q+t7orZPevRGbno8i9ftfdaZIXHpXlmID2BShTxv5xvNlCAJQd
   AXJyp2gwxk05oAhCiM3V111YlqLsJa/pcJbGMtr3qJweS8YrSUazIaQw6
   Fp3r1qyoj656IYd/mPYvxGbAskisrN9E5rXRVj22rL2ZUaX6Ju0Ai4VnK
   HxdtvYYUc1zddIjpYftl9kyAKOrkllSQrQCgPGuLVxedNsDU9PxxG5Ezy
   U63+AfjRIDqYkwvsTc0QUU65YWhm5G8tIz0Zq7McQLwdfQzmmQ+hyOnkC
   Thn9nxSxUsqY+YUUDI8h0iQdRhkNZ3ZjzgfuxuYnTemhPCfXGuUAHL/5r
   Q==;
X-CSE-ConnectionGUID: aEHHEyx7SO6bKvcSbaFW7g==
X-CSE-MsgGUID: Z1osChwnRmamdXmpmoV9/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64356886"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="64356886"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 07:28:55 -0800
X-CSE-ConnectionGUID: Wvc2wUZ/T6iCMt9PfkjlrA==
X-CSE-MsgGUID: sEGFp94CTJ+3HSpVyEbB/A==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 07:28:55 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 07:28:55 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 07:28:55 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 07:28:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbpx5p0PjroOJ5dUtRJBm2t+hViH3blxTC861Sg043tGyzZEPzebLhlXh6LECOh1jm6zl2xqOZJgzjMHSez4mN7bFz6cExBiMqY/K49LTrbtWwCAwxnO3prk+QUxVlhvKGhqaQczNfE+Z7m5A9G1KCBcrjjOeZg5jA+loOw52940TOMNSiZIUYbx87bdG36s+Klj8sFiq7Azn/5VqwxStzrhE//oYbcd3Jh9zHeJnncRiaWHOUM7bdFVBbmJzT+iBLPon026mrJhnnPYoL9uh1ZxMrqhMsDg22yX00GDm3N3zVQe3/KA+u3LUT9Ca76ZGRnn5FcPdopBkPwA402KPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJfWBZxbY5wra22a0bwA5G/8t0qOPWY8i6acwuVnccU=;
 b=EZ48kkVpGoiIWjK3AQ4gJ3CIQjFdVhQY4ElUPAK4cL6IC6U7w8emKGMmtwymTopdl3JdHcmYewnsXfv3LySWacORVNhsjCLyffOvvwtw65NUJffdZV0p5ZvId0B5pqq/gEjeKnfJy6vJk4KA1gKonzljz96WMJYw00lV51wuvj7JR0XaPTXGpSe6o/Jb3buEDIO48Tqad+bzvpeK9nCQJ3JETcW9TEpHl0TFfv6h4JOUkfgV5YfdVvhvtcOGQEnOW29r5Sfi7nLR2Jfi2d2bPlSuFK5RkvHeui2579yNC4ICpAB8zQtcef4at7aq3dlPa5Ulyxfwsxs+MdZHnjQbWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by MN2PR11MB4726.namprd11.prod.outlook.com (2603:10b6:208:269::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:28:52 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 15:28:52 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Hay, Joshua A" <joshua.a.hay@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v9 10/10] idpf: generalize
 mailbox API
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v9 10/10] idpf: generalize
 mailbox API
Thread-Index: AQHcQuFUr82wW64GTUyvzSXDc5tqtLThJpTw
Date: Mon, 3 Nov 2025 15:28:52 +0000
Message-ID: <SJ1PR11MB629769B69419605BC04244019BC7A@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20251021233056.1320108-1-joshua.a.hay@intel.com>
 <20251021233056.1320108-11-joshua.a.hay@intel.com>
In-Reply-To: <20251021233056.1320108-11-joshua.a.hay@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|MN2PR11MB4726:EE_
x-ms-office365-filtering-correlation-id: ef255110-3887-4f5e-e0a4-08de1aedb1d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?zaZUKUrezgcTqkN+m0uiYiHidxMUvnB6ITPFJSqFgOEzKAFnqiWJOOxoPQH/?=
 =?us-ascii?Q?7eih/H6vSy19imGMpv8qY3xvzas8Z38BdyQVcV6e4d9i+/elhnBwSCbbswyj?=
 =?us-ascii?Q?Fk1peqVHnL/2xBm1Q0+ebQJ6bze9N4Eikuqq1uPZdVn6hBJU/WO3vKHlhymY?=
 =?us-ascii?Q?iQuP87snhpLK4ciit7kxfgwfIKYdDDVv/1J6l64a2Nbf3BfVS81/XXF2rJui?=
 =?us-ascii?Q?X1+SpditRD1GY5/z0kAdkW/bZe6QufLbBJDYkH+PFPotiW70pGw3SQd/aKiL?=
 =?us-ascii?Q?GBOM2ip+Fw88ZAu70t6Zsxdc67JOmEEoK3v/M4zldexYAs98QZu9Z+ZOE0Fj?=
 =?us-ascii?Q?SV//Dhf2+89amPnrAIHdgz+U5B7O+5ybcgKqlwVJEqzYwM5lBANdhP3rzgBa?=
 =?us-ascii?Q?axINl0zO40nzcLLMosAaZh/Ux3BQVgJkcrywXw8UpIgTgev1Qyv/jj4UIKg+?=
 =?us-ascii?Q?w1yW1k/BVQ+QudITUlfMipop6AvX+zSdYyLMa2OXKtbRUXtxS5Ea08nIztfp?=
 =?us-ascii?Q?xvcf7SEuIGGOEjioUIBTukfeTA2P+TkLU1IPCQ/kXA0XhbOqijttJAMUsOZT?=
 =?us-ascii?Q?xARXTpKPsYBK9YBf1rhdv5jA0EaO4/pG0hSDKTx5mR2TALLrfJ7co1v7Zwvn?=
 =?us-ascii?Q?HYaFHwUwp42jTl6Lb5o0cOSzmMxypchFfZY9mRzbzzEhPgriw6CrxAHyyNjh?=
 =?us-ascii?Q?Qqi29IKzLWWjMrrc5ztYwy7/KQW0BIzFPDQE4x7LHF1R3EB7yaZqdIxl5sC3?=
 =?us-ascii?Q?4L9BByfpGnxry2BN1NjZaiKU5a8lScv4vgF1OgHzf2w4xxxDHee5bcASuH5h?=
 =?us-ascii?Q?SnkxXW7BFC8Wfal/y6QVuj9C2eEfmJqYILHvcI/OS+Ffuca3/IvRzkbaRtlF?=
 =?us-ascii?Q?/vpZ2pEKpYlRNR+LhjZNs1jTkfdb3PaT9ADFF4C+hhrpfVWQV7u74wgbAH6h?=
 =?us-ascii?Q?TXMTpmMWTxbMOzlFWrHAhlR6nW0AnNLdd7ns2ifKHdGhpC+vFbGGOo4s2VKe?=
 =?us-ascii?Q?b64r1qzTaxaoWOuFsIx0KEFvzCVaAT9xFFBcEXxtc/85HT0K59L6EpHn9vL/?=
 =?us-ascii?Q?mWpC7HBxRTvqD+9D/NRcs2iAPbsdKavo7pfwTJyQV+/Vwcn7nwrnbguvIKVW?=
 =?us-ascii?Q?1b4qGI146RMq3CSy+NL0y2v8hbbQQ3sNVhJlVpHt2LduLFkSyizJ8nbvdBIG?=
 =?us-ascii?Q?CyL9hfHVLxK7KuFG/a/1thfBIKL7kZXfgrnIyT9QUPKMHkSUH93HBx66KWyV?=
 =?us-ascii?Q?s0A38cAyFUnMjgzVLKDsY4XA1VUB7x2ErOLVc+bpvtSyE/jnfq6nL5xxjJQa?=
 =?us-ascii?Q?ktcvGyyZ3k+GjNYCtaVuJZub/A79bv79e54Ijvhpo9bMaSuaG+N1Mi7+HhKl?=
 =?us-ascii?Q?jcTP+qPbn+q12OR4sfc2ttmOttBViUxvKtVw5Wal6pbs2GswJS21jEoyUNLa?=
 =?us-ascii?Q?jq/Lhk1uAUTq1P5YR+pDllPtFx1zyKjZZuDNaMAT64z7I4Nd5f5LgCkRQCgB?=
 =?us-ascii?Q?Dsn27ffW4lAiWLxAKidGnLdmJ809mFqM6O8o?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bT0k8ss51MkwUaJMvbMf1/0f9PT1JxYndqNBoyAAwSQOPa7veRiy9n2QVSRf?=
 =?us-ascii?Q?6hGDazXCB5Eda3KLBe5AZ9oZI2KCb4CYW3UAuAATXwiNccAihIyL5YIt1wGH?=
 =?us-ascii?Q?XVpG/+Cl3yiv3tlZZVsaPcpN9CjC8VWZ4+IqsRNFnU8Pe35iuU3Nj92eTZfi?=
 =?us-ascii?Q?Yr2LVXAnDphwyrVLQI6r/0evEM5fCwyiv3vgyE9HSPRjSke4aIb02r7eXBg8?=
 =?us-ascii?Q?LdB9TWQ1fwz2J4Paiw8N8E3ZDOX4N4/bzPHSl5ttPtjbHbEo9kRYLrYXDh1o?=
 =?us-ascii?Q?9NG0NbZIFU+HGAzPzN/ulT5pEotx7gxmHxlgKMUrO/ghMuxkHRJU/ye3KArd?=
 =?us-ascii?Q?0LBvjfxIYSaHdGvYea63B8FduI9ETRf3a06IJwgxO/yC8rDkqY2O6Z8a3pm2?=
 =?us-ascii?Q?Yd/XsRiE+46EhFYrS19Q6GLN+x2MhBoQL37gm4GGXCk7EBKwYQ6CcAeshLy1?=
 =?us-ascii?Q?YU439R0T9BZ9EgnLVb4RfLOFUfu0y/h99fsGcR+gpa9nMcQClWVcCFT8VKiO?=
 =?us-ascii?Q?NUyFotZ+PTMgMy1B7kJ0hwfX415TtrxPf0iTLxLH5QHvYC8yD9JVBulFRXvl?=
 =?us-ascii?Q?rkyVS2IEE9HrRjhvn14P4qK13YuPROnS1KMf7sGcyQAw+XB3f6IlNkFB5dsc?=
 =?us-ascii?Q?RnGe/ZLFDDiH1icSBW/RMopo1MWsj1tYhIpMTv2peOyXpZTP7YtOKXIw1HrE?=
 =?us-ascii?Q?9aTvrSdBxt7Q+zmxqhPncrwyvMMsZaQ5OKB98E5o+Xjmu2Hl4eehaz8BHlRA?=
 =?us-ascii?Q?jWB97ExbdyWZ09T1d3Psgy/PlFREe+hM3gYn5HH4aAfXTt0dZoScWaRFgxuA?=
 =?us-ascii?Q?dpyLYs6rw+aY0olU0SWWJjIO9rZxG54BRrf5EH+96RYUgvvsWhTCaCUFFGac?=
 =?us-ascii?Q?lZ1ZVlnih/vsQUcvBCr2SsbNbJ088IO92deW7IY5P7PdNKBPx4ECkGzmj+lH?=
 =?us-ascii?Q?HcTuf59xWnLVO7ldxExcjH4Klz2+ZUgem3IVpb7H8MT7tkMRuEysy3npCxjC?=
 =?us-ascii?Q?0iULuzLk7wZ2YMnNgLwrtgAxg748cCS/hQEtpFCXrfMlwfzzRH7ilVCjqUqM?=
 =?us-ascii?Q?pORA0VIjfcMEx9XTSBz5IyQFn8odLspqxiNk/Z1Uvu4O/jEYNKG8D0mLoOSp?=
 =?us-ascii?Q?8SKYu9Nh/gYhEUiVxYa8y7XuDvzdtCv+bFmGIL2ighRZdreW4D6X/o5Sm0Cd?=
 =?us-ascii?Q?NYZkFgJK7c+CrZrsXMJoYGemz0i/eSvrKztLJ2x+Mix/rZJz1Dh6ErBtjOkA?=
 =?us-ascii?Q?vNUgOuAkpY+WXwNh2erqgofcZPbmVWjQhQvYECWMOYJacAFK8k6JkT0MxyHl?=
 =?us-ascii?Q?/z6nFw4CFrBqmGwSCWOnPwCAGNT/Y51cXfclylUpjkjSJgLQQT6cUNWcC1Pr?=
 =?us-ascii?Q?Hzf/5rE30YHexLJf5Ef5G163Wlff5Q+IduSUbbj+tQLsta1XoXjYd0pKGPyD?=
 =?us-ascii?Q?BmQp/RnSv5xmwhWjuLDgMwvEEaDTti0bRdQq5tBmWBqr/Wr/RCs0VewYkpC9?=
 =?us-ascii?Q?uSvpNsZsmAyUQclDxekleu5vuip1t0drPZfewkndbEs+WZBueFWpPXCagOAj?=
 =?us-ascii?Q?qmgaBJoE8gQQlxDgbyFRBGABIyTX95MnjYAHkfWy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ef255110-3887-4f5e-e0a4-08de1aedb1d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 15:28:52.5984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +I0ey3+Zsz2ZWkjSLChmLiVR5F6NMNIsYJj5Eb1Tm4pz5E7px4puWc8azERZRx9kBZZUExY/acLegXVotHXWkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4726
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Joshua Hay
> Sent: Tuesday, October 21, 2025 4:31 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v9 10/10] idpf: generalize mai=
lbox
> API
>=20
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>=20
> Add a control queue parameter to all mailbox APIs in order to make use of
> those APIs for non-default mailbox as well.
>=20
> Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> ---
> v8: rebase on AF_XDP series
> ---
> 2.39.2

Tested-by: Samuel Salin <Samuel.salin@intel.com>


