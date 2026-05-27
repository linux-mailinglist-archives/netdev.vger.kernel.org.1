Return-Path: <netdev+bounces-292341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDcCAxEKF2pB2AcAu9opvQ
	(envelope-from <netdev+bounces-292341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:13:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A8A5E6A3A
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACF36300E5FA
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7253644C7;
	Wed, 27 May 2026 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VumemsVA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D463F380FE9
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894425; cv=fail; b=Em9UKBzmP6Fp8LNYPBDQRfvuRqSoIUjhdeVMY2tTw3cPtvUQAjsiXzO1jb6yckC/w+5KzeVmaMfR1C7y67oC6FIKzLc+BM0hGOzalltNzVA61qEeN2G/IpyeouTF6KCNeRpT3AvPoBM72Rye1DVBMcBWqnHdVUcPse1LveBQkFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894425; c=relaxed/simple;
	bh=u5E2z+yhbK7hyM2dq1efp5YVpX0WWq1/jQ1XWYMWmzE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZW+qWQxUhkAb4YPqh/5d9VY1pb0FFCSNFNXzBZVqZr0K0tt+X5ZU5xfv/uHHGYpSpl9afCNZh5D1B1bev1CobUMx8eletdwthxE5TgHpBCd9sd4uUkk70rh/L5eEqe2m5+Mq9lF1TzWnsiMOSst1/gKuF3AIHraXBHvO3ySj4i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VumemsVA; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779894423; x=1811430423;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=u5E2z+yhbK7hyM2dq1efp5YVpX0WWq1/jQ1XWYMWmzE=;
  b=VumemsVAIqnOzDYruU8YTm3l5c85GNmqgaq5jYst6Y4MJccVf8MfmeQy
   yJLgbxB2IoMbr61xfI3J1dwAQAGLMatpD7mIctKRA9KcSX1cG0HJ7WRiI
   18lRl1YK6LrzsG2Lg60WNOq8YVarwVER7ksM50AY/UVKcyMXjcHLMY+pQ
   W8RxBejmPo/uMRMHf7l1DpdNk19TpTYX9q53U2nTXxGnU3oFnnvhgm47q
   4k8GJ1Im2kqi0YVuTFAnH1vJMsvGsCApkv9T+rd5GAAzyaL6vaokF+/W7
   fEbPCbbUhfVm9ZsAa3XxQLA2niSA03J431ZVgN+YYR+YT+rGB0nYi5EYW
   w==;
X-CSE-ConnectionGUID: YHqVghVBTjSux9/KY8eucg==
X-CSE-MsgGUID: 5Khl/Y5kT067G7wcVwvahw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80836958"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="80836958"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:07:00 -0700
X-CSE-ConnectionGUID: HZd15pZ5R0yQ3qAotKbeKg==
X-CSE-MsgGUID: zsGaaqcPRzSXhUqYiBp+9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="246293366"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:06:58 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 08:06:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 08:06:58 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 08:06:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5G7BfxvssZezNma3gh8zv2k4YmeGv4VS+4eznLaVByMFmi2RRKxCJpt3peoGErplgbk9bEwc3I9i3GCaw4Iy8BZdEzo438L1CZeM6xbAvYBY1aMMOXCZyy/PQMwvnuszXPnHa8JFM6q+q2CdtwB6i3c9ijO3HVIecV56E1DRcRjoy2JVr8uHDAnADf5A9B3X03GiMOsOwFQHUhy0VI+em5OFA4gMGy1g5m2AsCgqqYjLzsp6+/ZpnMkCFIMafDengE97PvoBHsdJxnQNddkXoCur9/0F/AQoWUsUi6YrFQu0FCaXInHCSDVBKg0rOGxijp3YzwK9ngS2tynvt8u1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5E2z+yhbK7hyM2dq1efp5YVpX0WWq1/jQ1XWYMWmzE=;
 b=C4RkJJXjqpVcItChZ+tcKsuamUPPcsR9aCtLw1ny1dhUiKWk4BHDJ3VWuwXJVtiAa0Ru4HLm6K348QgsFaHiP+vf0YwXyMR6CyoEV4dTXzEw8pJOZRCP1/5hIQ47Qt5o4wPcbleXZV0LTOdPizaDl718LGpmgcMh31OPQyaWaS89Q9Y/bjGJMAzREwVEOzOqIKSLC7d1zPh4qXX2Tj1ktGJ/ewXFFGsCEgO+LdBEe0QKc/+TRVR5aluP39vEFbRNzbDK7eU0LbpBejlCSyKYFKENTgM26p5SSKkw/FQSTNKm5WU8yPP8IxGjdvf/wzTzXF+2BBcNol3CK08YxDh1Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by DM3PPF8ABC16DA2.namprd11.prod.outlook.com (2603:10b6:f:fc00::f36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 15:06:54 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e%5]) with mapi id 15.21.0048.016; Wed, 27 May 2026
 15:06:54 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Olech, Milena" <milena.olech@intel.com>, "willemb@google.com"
	<willemb@google.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH net] idpf: fix mailbox capability for
 set device clock time
Thread-Topic: [Intel-wired-lan] [PATCH net] idpf: fix mailbox capability for
 set device clock time
Thread-Index: AQHc3xvEP+hn3pRbOUOVGo6FMVldOrYiFcyQ
Date: Wed, 27 May 2026 15:06:54 +0000
Message-ID: <SJ1PR11MB6297B7EF97D30E9200A8CFB99B082@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20260508185123.2422760-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260508185123.2422760-1-alok.a.tiwari@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|DM3PPF8ABC16DA2:EE_
x-ms-office365-filtering-correlation-id: 931805e6-838c-4111-ab76-08debc0196d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700021|921020|6133799003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: OCV13GOWqHr21hgSL4KAE7Np+swaVZ8TY1+nCGtbXYDBlfnXgUzaqo26F3rJ7jA/g2p6dHQVzs5wALRFrshyTFlH4o5wpi39rBMOr/ZWnB/8bC9Q/sznY10H2z5n5I6F2N2N68Bh3hs04qFAavvQehPvO7G+gxJDH9dBIcU4Oop5APUIDSY71m63qZTz1LC8LmBslPEUZK7Fv0ptHtwCakWkDwp7Ti3sOu4y1xl6jUo/Jybvw5cJ7/MkQ86o2b63wYLroiKZPMfdlyQXHJdOq6sGuoHWIU6FJkXvH8v7RVZJbK0d0xCPfFJXmDpClOXM3PkH54KEgRvkmMReBTSPxLyrG8kYqseLdsKXc9sxZc+DeHUp46rUoby9C9vh38cYTo12dsp2wXL4qz0hjucbxx7Aml01H1x7UZ3kmhwHyyQxiOhvOiSVJsEJcIAd+AVKUNpV2+JL94a094oxZuTAV19fMph49hIcN1aiTwccWR/M+65jhuDf+oFYsgzAcutHFszr++RDECOuNSyx9Uuz9SP1yDpF8A/gINeAQY2T0Th5UJH+sTHsEdM/3g08fZledw7MWxCVzR2qSiGRJ5pJ58rSF2G8zxGHpos37maVpdwGx0XAIbxsvks+K80Gpg+euth3vOgh1NYQ17SUHms0g1LPXey+KrZ4k2z7xolJmvo3jDM9HsDKuMK8aphhzbPQ9iDborbW0sjQqfkCecHcl/4mwdkeGMw3GFlKOY/o/Ym+sONrt6FtxmM/Uv2zlE8b93BQ34mca2VFlfXBRNe6wA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700021)(921020)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eZm6wztL9RoWQVRq9Y0RW8smlh5lpvjaIaphC8utH2SY/z3oaJLs2PP5W4R3?=
 =?us-ascii?Q?NSo1wg59LaoL3hl9QNctY5/mBwjIEKuWrKVbsQAuiATcxQYT7QPOdxNPLtan?=
 =?us-ascii?Q?9Wcqr5cQWsOhJhoKwdTtKcwUt6wVLnrB0kal+71znlgKQLtmaUJliwL6V87+?=
 =?us-ascii?Q?JJLwWOOh1pq/cjPyE72chxEPQg91ehgeUwxSoFxBVrfaiZhBTd8q2AjW28sH?=
 =?us-ascii?Q?RWnU6weaFfwbhpVv5lvLzbXlTceV4X5abbQwxrMoZmQOHCKiEX6jLg7Sudun?=
 =?us-ascii?Q?CBYsP3xa5prc7qw3DMXJVQ32Phz4omHjeCXeRfvmIsc5fzF0Nw0oSHAo7OvL?=
 =?us-ascii?Q?ngMWKdD+PHzkJZTcMO4naNuPbwp5POH381ol+NBYr1aWa4cfDJHdlnwxCSpF?=
 =?us-ascii?Q?MHQ0FPhKSpJXCwt8I/4sQ0v4rXVtYuJHDngT3B7G7RQB8ACskMNOG8BKNc72?=
 =?us-ascii?Q?8MP35ZMT2S+w5YDttAUmVtkXg/5cQRpIa2BnXDog2wC2rlYu9hFWIqjOU3IR?=
 =?us-ascii?Q?7Y4im+35tyxTOMJf/QcwMOvyOb30o5ySq8i+PB+t9xU0SnnI4BAt/UWHAGqf?=
 =?us-ascii?Q?SMVa46mHCfHNMbvFEuN0fk7iL1ur4qAi8sal+0qY2pRjkUyzRZV4Qyc8UtL/?=
 =?us-ascii?Q?rJr7T3a/QIIPs44Jkno3LKeSGAzVBzzhtL59jPoZso413KxWOSMcXryFiaoA?=
 =?us-ascii?Q?Ul8a1hrl1luARYZV+NACY2aeKjsG0VlIjOLprJ7EERldx8D6LslBXLUAM5/a?=
 =?us-ascii?Q?6bzoVYJoStu4EfxjkHpzIfDeGchDTC8xejR9LN9NvLInMWu8dgXqbM2p6+zj?=
 =?us-ascii?Q?/NhEpGjgiLaO3VvL2tNGY1NqMOTRM/m6kO7ZtVhuaeFncJhZIu39+w4/8LpJ?=
 =?us-ascii?Q?HhQBLFJX384Cy4MgT884TSZYgE8NHOAi5Ms2yxiSWGpZjINSoX0REDXmJM7y?=
 =?us-ascii?Q?nfHZQwXG4fbdh+fr8TtwhsPtl2AyCWQF3xW6c+ReRT5kHxDZcTo/ddQYplaF?=
 =?us-ascii?Q?K/3/jDl7Yn4+Z1M8/FqpfucmrgixIipJFV9UATRw5Ln08q3wtbCV7JrBFvk8?=
 =?us-ascii?Q?/cLU6A6eGHHjOLUQv5rQDxCeqVLwH11eOdL3ZZpefE606OWE/V8t1m7w/FL8?=
 =?us-ascii?Q?HLvST1EUMPPwfU4XUeba52H1cw/fIUTVeI4VYuyspEaThGLu/FtM24xRvPqy?=
 =?us-ascii?Q?XMSnUyBplzLi5/xDt/t1AuhQdcblrB2CqPIk0Wm70q3ctp0svY8k3he2M4/4?=
 =?us-ascii?Q?68QsnSh0FySu5f16n+Tm7StkSVya370WIAnSieIamPA6WGqiA4JmYxBq8h0y?=
 =?us-ascii?Q?hjDfQvjBMhytURL+LnscVpdMgprlGnBm5TdQruYh3psDD/6IoZEJm8AayU31?=
 =?us-ascii?Q?AoXUmT/UqwRPw7TsEYXKaY/UCu1BhxLft3h4PBcAOI4fERFMsvt2Iz/vUfVy?=
 =?us-ascii?Q?U7Uw4WSElwBsUeRXPjXIVGBjwt0Ao7KvY+jaHSP0luzk2MZSGQp7OPMWdekG?=
 =?us-ascii?Q?lckHrCzgMkxMlVAy9aY9H/ZWpUjnw/8AZlbiSdBi+6+n0kjZAz1/d9Vt2WhF?=
 =?us-ascii?Q?adzG/pAsjf2bkoQgfYcGI5XnbZRLtmW2jy8X03ITfwZ+d89olws+HZxJsez2?=
 =?us-ascii?Q?MEfqd/C46zBro4Lj/8vAaA2c9YUyc3mn6hkvWITTgnBwZqIen2XJGifDmcq+?=
 =?us-ascii?Q?e8+Hv5XFEWfhT0blN84GoyXXUhE2KBMkemAH9J+mAIG1zSH1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: M2I2esrU7O7FR2Sp9ploExB88ocBr4XoUorB7v2MJBqomkByLiEVj1JR/Vd0jr+ZYVbmG0fAJPjsFAX4mjyWft6I6NT5+ZcR7UXp1tZQhCVAMyBgRuEaSzajGS/HTMdPclwZDtUaci83CZpqoszI2xGuJ+oPVtX4v4vcnIkbz+1hW1GGR6MJlfIv/fptf58a+LW+yPm8ELK6hoEHxOW74BRndl794Mg7oSrIlE92LQ/Xi0EkcXeZoKa1y9EWQUXwP8+kkMJ+j8/er8DjRwYQoc/fXUiMFJ/dR+8C/HVuKLhB2PzI13JigBCI2s6tAMYKMqoEaf8MqbZk2uCpVXukdQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931805e6-838c-4111-ab76-08debc0196d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 15:06:54.4448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4E9odjjKNNAGsiQtxLWMPQ9I/ExQViGbQjpnUjwAPQYOqxmUOXtgg/XkmD97Cxo55OoRa91ByRa2RjHmXVNNJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF8ABC16DA2
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292341-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[samuel.salin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 70A8A5E6A3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Alok Tiwari via Intel-wired-lan
> Sent: Friday, May 8, 2026 11:46 AM
> To: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Olech, Milena <milena.olech@intel.com>;
> willemb@google.com; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel.org;
> horms@kernel.org; intel-wired-lan@lists.osuosl.org
> Cc: alok.a.tiwari@oracle.com
> Subject: [Intel-wired-lan] [PATCH net] idpf: fix mailbox capability for s=
et device
> clock time
>=20
> The current code incorrectly uses
> VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME
> for both direct and mailbox capabilities, causing mailbox-only support to=
 be
> ignored and potentially reporting IDPF_PTP_NONE.
>=20
> Fixes: d5dba8f7206da ("idpf: add PTP clock configuration")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
> I did not hit a runtime failure directly, but this logic is inconsistent =
with the
> capability definitions.
> ---
> 2.50.1

Tested-by: Samuel Salin <Samuel.salin@intel.com>

