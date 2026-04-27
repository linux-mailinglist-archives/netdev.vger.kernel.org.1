Return-Path: <netdev+bounces-281365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BbvMwJw72mHBQEAu9opvQ
	(envelope-from <netdev+bounces-281365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:17:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E584742C2
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61B143064670
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 14:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C063D3321;
	Mon, 27 Apr 2026 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YdTPUL8k"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EE33CD8C1;
	Mon, 27 Apr 2026 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299287; cv=fail; b=dlzxQ4aDU8MWNc7j5r4XK1YVFN/avMtTIBi701TMQL3tIwYNi1uZAR8AS/ArCav1y6bQdTBZYpoxfZ1QSpYt/ej/oEAgPqtDJLNYz5vPbu7qUEpZx9LQa1veo9e2BhgFfL2M7MBlwZd5ZmAHtcQc/Wu7SzqH+pnYyjVyIyRivSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299287; c=relaxed/simple;
	bh=9n+eDmHaKFbsyPtNrulv5UMa7JwxIgrYeCiBUBzHzZQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qLpJ0xMi7ZGqddgwIscH9DiRgVtYOyKVug8862cQdg8z4CZPjH8+EXSMKAY6AoBIMUPFciZ7XYCoksOM4/J47je6kshncHRq49poIgZtdD6PsCTMzpWD1Zz1YqyE9Rw4thq+qYYO3fUw2/e0IH7e1V2RQuv7VgY9U3MlDmK/2G0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YdTPUL8k; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777299285; x=1808835285;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9n+eDmHaKFbsyPtNrulv5UMa7JwxIgrYeCiBUBzHzZQ=;
  b=YdTPUL8kUOlIPQ/8guBD7Ms5XFJ6q028sdescqfbjCmwJ72LIB4WuFo1
   skQfJCB+oWmJARwkJGlHtRW4+dpUYQ3CXG/CLlQuXfj1j71bG5uHd/vmv
   PezYunXrGqy21zBGttBD3olr6vLFCQS3QbXejjmHh9o/Hk8L3ScxwCoyG
   zcDwm2r0OBBqAaC66oSbMA4aQwvpQvP9M6Sr0GiiJmGmujYs6vul8dq8z
   BkT60UorLe8VTIjKE/29tobMYq0djCSUTAwunPyxMFjfqAUCLG8lBVh2J
   sA0A9IKg619MkabBNzO/JyiUnY/yeMgOvYixGyO1zz3yCctOM17yZFQbZ
   w==;
X-CSE-ConnectionGUID: +wUpMuulRqmB5nbyT1y3Jw==
X-CSE-MsgGUID: hNBHeaKBQ9i5uE2x039bDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="88786060"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="88786060"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:14:45 -0700
X-CSE-ConnectionGUID: PmgY7etxSmmFlwECRLPCWA==
X-CSE-MsgGUID: 9B6n8ZMGTO+shf5qR++7LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="227131398"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:14:45 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 07:14:44 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 27 Apr 2026 07:14:44 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.39)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 27 Apr 2026 07:14:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AeTkTOxdCYmYz9iI8X6QlHkdvdnUZbWoHy1/iDOgx/9G/iY5bifPgMQ888zwbaHORn23xsBlcqIkn3CpjuXN6fjJi3rBLxP9ekFHYO98tkvqGERC6ntplr2Tt/fEDVw4svv5RDBnCbcKuI69Jqt26A8pO6mMvo9O/mulc2riVEtfZyEPmeE46GettXux0JlFtMy5EJl365jf385lHDD5I+JP2ShZWCJFmTgFHjlillJIInplGaJagac2vM/QFgDhCbbhlxSZgHwa1t6sYPnVXbC95vr9+PNjD3j3dtYPZG3U3zboKJKHoavOcQgWB1ROdRTtuajwhJq+l1H30yBsRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9n+eDmHaKFbsyPtNrulv5UMa7JwxIgrYeCiBUBzHzZQ=;
 b=OAvAl/MdfbomGqJ+X/eFQoyClF/SZQY1D9nXQE7ZdvegGMEJ9x6VoxreB12e87wqovZe7xK+fauURjLBzd1oI3kwUNIvVJJyy6kIH08WUlFUMUZQ40/JRvZpA3C4BpnxmU7fiOyZ7qW6c/XxmucpXIHnpQhru36gj/uVCztQKkWzIzRLEEbmKpDVRj46SP9uJQfYqrUndMSrx+9WFyJwZct/0rRtignsCFBmoTveVzfV612clEtojt0227d3qHXHzYqWgXeLasuXgXfK6sDQF9gwy0RXGzIpf/PLz9jtb97TeulIl+21Yjw7SqoOMJaPQBFkzz+X/VygrZxsg45gqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8)
 by MW4PR11MB7079.namprd11.prod.outlook.com (2603:10b6:303:22b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 14:14:36 +0000
Received: from IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::7b0c:7df:21b8:dbbf]) by IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::7b0c:7df:21b8:dbbf%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 14:14:36 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Vecera, Ivan" <ivecera@redhat.com>, "Oros, Petr" <poros@redhat.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] ice: fix missing SMA pin initialization in DPLL
 subsystem
Thread-Topic: [PATCH net] ice: fix missing SMA pin initialization in DPLL
 subsystem
Thread-Index: AQHcnPOCFwWOgaS7aUaA4TIFUgRN37XzT9Tg
Date: Mon, 27 Apr 2026 14:14:36 +0000
Message-ID: <IA0PR11MB7378CC610C2866C216D1B9AE9B362@IA0PR11MB7378.namprd11.prod.outlook.com>
References: <20260213141651.2231124-1-poros@redhat.com>
In-Reply-To: <20260213141651.2231124-1-poros@redhat.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7378:EE_|MW4PR11MB7079:EE_
x-ms-office365-filtering-correlation-id: 3059f913-6080-4ed6-cbad-08dea4674fd5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: gHYQ1xR3dLWdT7MWF0nAS+a1shGLgpzqsCzhddmxpwMW8hkLQa1lW8o2zl/HI1/kc8cxHMkTMh/II6nAXyb3pyvoGpobZkhd2ad7zaFtcfHaPhhPzwua/CLAls/q4+yYTg79/d7+jDXn3+8q0Nsqf6v41oI5FMg6KdnR34KkiQkY+fBNM71e0/rNVt2h4K8GeysMtwlNWlcSDLcEc27cKsOdBAqBkFqr8ebpIp/ARMaqS86Cg7bpNZDVvRxkEMIyRFqxTXItp2Q38k7LG4hVo8P3D+JQjkO6mGQ4jr4M4GpTk2io2QDodwbKmnTMNUQjjKGl4+lAYrfsK5/0wLJthDtJr+SxDSqSH6cnpdASk8mEwx87CNutPGwl2JC+t8kiy5lp3A7ESlCh8p+s5bG0oSguNz6wd6Qth42FQXf5snB9ZHEmINSoht9XpUr+07YO2oplO3i4B4ys0stlFHNpRLfdcxpEhUNC8cESOBMBRa+rR9+RNAdjXI00HAh32WoBYKb9QkuwtgATodymLsbVRtS3bKGRYb832aWISUcc4P3SSOZjI0r6kWSJNeGeWhofGD5loNEIfg0Bl5N/W/n2Itt7IfQZXr1jr017/17HnqpodATzN6Wk8Lvq2xo3ZuX9yPYqY0BbJ3L9T8FrOysWEnkhT9aNvTurHaXwlyF0n0nsBPDCJwmC7nTwJoTOxnzXF1d5sdRAc7lscyuGdmDh/OdfmGKMw8yQJVGLWLT5ZBpEpLkvzCPz7zWu8Hgr2GbT3axujkFtgCpK2BW2TZbekJNBO8FR+QYLzVsHsHrDBYk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7378.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0ZxODIvYUVVb1BLMWsyaDJJUVNrbHNWUEN4c05PaTQ1aFNRSkV5Sk1QRkFE?=
 =?utf-8?B?L2FBQitEaE0rSnJWdVJ6dzJudHF0a2lGNGZXc1NFcGdjeEdLL1B1VHc4RW50?=
 =?utf-8?B?bTY2RU1HcG5XZVQyLzBsQzVnY0ROZkNjWkxYZ01RK0djMEdiUUtpNGU0Wlpt?=
 =?utf-8?B?REhTOFFWMGZjQUlsci9yVEZaWWRjakR1VmJaZS9ibXJvM1pNUVM4cGVTUmdx?=
 =?utf-8?B?NWh4am93bnhDYklzYVpLd00rd3RCaW9RUFZITUJuT2FWcnV4eUNPR0FjM2FH?=
 =?utf-8?B?Rm5aUVVtUXZ4ajFFMWJUcjJ2NHhVMTdBZnc2ZWI5NDYxc1dzaVBOQ2VyS2R6?=
 =?utf-8?B?YUNLT2VFclVvVGtzbE5MR0JjWk42RFVVUnNnZnFGSFNKN1ZlSHBPMkxWb1VL?=
 =?utf-8?B?dGVKajAwa0pnbDVvQmxLZGk0S1RGSnhaa1BCd21mUHpDRlFmWmd0RjMwVGdu?=
 =?utf-8?B?d3RkMWpRN0NhTXdTbWMwUHVySkpidEhrRnZGTk8rRStCd2tKbkNJRkVIYVUv?=
 =?utf-8?B?U3pIVWt2R1IzVHFnL3pIK3VsSi9tOG1HeGRkbXRjTG1tblkxMEUwWE5vWU1U?=
 =?utf-8?B?Qk9XNjFpb1kyOGo0eVB5ZjJFblV2U3dPR1FCeFVmck4vOVI4YUpnc3piTGV2?=
 =?utf-8?B?aGYyTEtpczAzSkZ2Q3dWQ2VNSTdpTmpDbWpKR2dsRUJPanJIaEFrZGwySlhk?=
 =?utf-8?B?TGdhSXh1WHFFQWk4TVlYemtrOTluU0YxbkQrWmlDbW9zZWJUUkh0UVlidzRZ?=
 =?utf-8?B?VEVnTjdZYlkvMm5YVW9kQ3RodWdKdUF4RW5ySW9xOG9QOXQwV24yTDBGdTZa?=
 =?utf-8?B?L3NqUW9yQzJxVGYzVnZzb1MxcjdURlBLT1lXQXpDUUgvb2FzQ1ZBdGs5a3hB?=
 =?utf-8?B?MldZc1BjdzFnZklPdXdpTDRQWEsxNnI3eWRSbExYd29DNFZRdGEwUUNneEcx?=
 =?utf-8?B?a0FXOVpBd1poSnFrQWlKUXNWVS91ZWFoNUJXRGpHUUJtRGpCNk1zYitBWG11?=
 =?utf-8?B?NXdYZDBHb0FrNUZYb2lOTVM4dFd3dUFOTkllU2FoWWdqRkpjNEE4MHV6ODVL?=
 =?utf-8?B?cUFoeVFuUE1VbUFMOFlVaytIc3JkUERrS2ZHTjViSmRHc1RTZkRzU0gvTTlS?=
 =?utf-8?B?TktkZUJvakJJSXRtSks0dDFCdDJJdHpLTUw1aVhFcFRhaWgrUzJIdVhwc2dl?=
 =?utf-8?B?bGtkVzRzMEk0UTd4VGE0SGRjN1VZeU50TzVac2V0d1hEOEpwNC85U2crQXZT?=
 =?utf-8?B?MTE4Ylg1V0dESnM2d1kxTXEwdElIV1B0U0FlMWdjVi9IOW1hSDBneE5oWkJU?=
 =?utf-8?B?bHh1bnR5dGxGT1grV2w1OGljNVJrdWZLNWVIcVVIZ3EvYmhGTytFRlRDdjcr?=
 =?utf-8?B?akkzNmdiaXJvUDl4ODRpK2RwSmJYVWJQelgzeGd3ZkZDb3poV3NwMlJOV3dO?=
 =?utf-8?B?d0xrSVJPbVZDRUNYQVlSdzhHRS9Db01EaS9QazJxTklxbjlhT2E5eDF6ejhv?=
 =?utf-8?B?a3JLcFBmYUFpV25PYWphSFRTbTY3QTkrVmdzVlhtSHkwSTdTbmZYRDROVUNl?=
 =?utf-8?B?VGRuYnhEQTE2RU9IM3B6bjZrd1lQZmFUekxpMHQ0VmoyOU1TUlE3TWgwZStw?=
 =?utf-8?B?U2ZPaGR0SFpIZzl3eks3eHJ3ciszRThZSUg4VnNWVUZnNFFyc0tIeU9ISzBZ?=
 =?utf-8?B?YUNaTzJoUCtiNnl3emN0NStOWWtTUXF3U0V5Tm9ubHNNN3lLN2tIbHhXODFP?=
 =?utf-8?B?cEhidXpzdUE4NGxqM0tUaEt1eTNHb3F0SFcrTmYrTWJjWjVJL1hraWFNVFpk?=
 =?utf-8?B?QUNFVDE1bHh6czJUejlTeWFoYkY3cFRsWVgwZTNtTnlOTmpnY1RvVWx4eG1p?=
 =?utf-8?B?SVAzZU1lMXZidm81REdGaDAyYW5TNStKaG1FYUFyNVRqSE05TGdxWnpJZy8z?=
 =?utf-8?B?bEI4ZmVjZnVRUFdTRDR1TWR0KzU1OHNMa2JxbW9qVmI4c0RHTmowVFFtSGN4?=
 =?utf-8?B?aldZZTN5V2drQlByYStXbndacEhlL2w3WGV3OGZlcm9OaDZ0OFFzZy9mZDNh?=
 =?utf-8?B?L1E0YkxoM2dmbzdsSjFuTWtOTGJKaytSUU5jUUhvdk85KzFjbVNqdGt0eW1D?=
 =?utf-8?B?VWREQTNCV0w3Zy9sckNMbG80dm10d0RCMjBFSEg5UzdGZ1UzT2w1UXZzRG83?=
 =?utf-8?B?Sk5waGpzVVJiMFFPMnJFMUlqcGppeHRVQUdTTUJaaHJyZTA3RTAvS2lVZURG?=
 =?utf-8?B?Y0puQzZNWi9yKzlyTGM4c1U1NUpNNXlYK0YvWlNoSVBaNHkwWU1FSjIwWmRt?=
 =?utf-8?B?TFRPL1k0aUIwNjQzM2w5Y2JYblNTdG14WnNBVDh0RkNmSlQ2OFBITGM3NUR4?=
 =?utf-8?Q?RUiUTJrPpuBnmSHA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZvLUd4I+rxMUWNmwszedgXIxhjRzghHQcGGt8AaFYOTHT0MI+Yhzbxyw0tust3IUan3iEmBPzNqkpdF2No+cN5sJOezjxqG0hAJrv4Z4xFKqDUaxXyCrFAqfpi7+immzmNeDXe8FeYGtYJ6z99bYpH3ltp3VsckpkwJbHFhO9CmY5a8e15HUU8UkMBK53LXyJdwAUmACR1LH/fn5jGhNPpMmk68IqUAYuQ+4Ms8++Bq3iBpA10kT9SWUt7sJIGFYBIqr9XwUkCjAOoiExgrAqBi43ZtfKYyO2eRMAExj315aolPCELTiGcveKBk6E67DZTe/TdkNvwccJS0xOWwQJg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7378.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3059f913-6080-4ed6-cbad-08dea4674fd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 14:14:36.0556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RKAIviEs2RKc+HYF4Iw2ck7cMdZ1QiChkp2XsovBCkwYDlEORefwy5PCM22DH+oPuIbbcsFUibQVFwuPaK6sJgudbNvYqjBmabwNjhSPPSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7079
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 39E584742C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281365-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,IA0PR11MB7378.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arkadiusz.kubalewski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

PkZyb206IFBldHIgT3JvcyA8cG9yb3NAcmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIEZlYnJ1
YXJ5IDEzLCAyMDI2IDM6MTcgUE0NCj4NCj5UaGUgRFBMTCBTTUEvVS5GTCBwaW4gcmVkZXNpZ24g
aW50cm9kdWNlZCBpY2VfZHBsbF9zd19waW5fZnJlcXVlbmN5X2dldCgpDQo+d2hpY2ggZ2F0ZXMg
ZnJlcXVlbmN5IHJlcG9ydGluZyBvbiB0aGUgcGluJ3MgYWN0aXZlIGZsYWcuIFRoaXMgZmxhZyBp
cw0KPmRldGVybWluZWQgYnkgaWNlX2RwbGxfc3dfcGluc191cGRhdGUoKSBmcm9tIHRoZSBQQ0E5
NTc1IEdQSU8gZXhwYW5kZXINCj5zdGF0ZS4gQmVmb3JlIHRoZSByZWRlc2lnbiwgU01BIHBpbnMg
d2VyZSBleHBvc2VkIGFzIGRpcmVjdCBIVw0KPmlucHV0L291dHB1dCBwaW5zIGFuZCBpY2VfZHBs
bF9mcmVxdWVuY3lfZ2V0KCkgcmV0dXJuZWQgdGhlIENHVQ0KPmZyZXF1ZW5jeSB1bmNvbmRpdGlv
bmFsbHkg4oCUIHRoZSBQQ0E5NTc1IHN0YXRlIHdhcyBuZXZlciBjb25zdWx0ZWQuDQo+DQo+VGhl
IFBDQTk1NzUgcG93ZXJzIG9uIHdpdGggYWxsIG91dHB1dHMgaGlnaCwgc2V0dGluZyBJQ0VfU01B
MV9ESVJfRU4sDQo+SUNFX1NNQTFfVFhfRU4sIElDRV9TTUEyX0RJUl9FTiBhbmQgSUNFX1NNQTJf
VFhfRU4uIE5vdGhpbmcgaW4gdGhlDQo+ZHJpdmVyIHdyaXRlcyB0aGUgcmVnaXN0ZXIgZHVyaW5n
IGluaXRpYWxpemF0aW9uLCBzbw0KPmljZV9kcGxsX3N3X3BpbnNfdXBkYXRlKCkgc2VlcyBhbGwg
cGlucyBhcyBpbmFjdGl2ZSBhbmQNCj5pY2VfZHBsbF9zd19waW5fZnJlcXVlbmN5X2dldCgpIHBl
cm1hbmVudGx5IHJldHVybnMgMCBIeiBmb3IgZXZlcnkNCj5TVyBwaW4uDQo+DQo+Rml4IHRoaXMg
Ynkgd3JpdGluZyBhIGRlZmF1bHQgU01BIGNvbmZpZ3VyYXRpb24gaW4NCj5pY2VfZHBsbF9pbml0
X2luZm9fc3dfcGlucygpOiBjbGVhciBhbGwgU01BIGJpdHMsIHRoZW4gc2V0IFNNQTEgYW5kDQo+
U01BMiBhcyBhY3RpdmUgaW5wdXRzIChESVJfRU49MCkgd2l0aCBVLkZMMSBvdXRwdXQgYW5kIFUu
RkwyIGlucHV0DQo+ZGlzYWJsZWQuIEVhY2ggU01BL1UuRkwgcGFpciBzaGFyZXMgYSBwaHlzaWNh
bCBzaWduYWwgcGF0aCBzbyBvbmx5DQo+b25lIHBpbiBwZXIgcGFpciBjYW4gYmUgYWN0aXZlIGF0
IGEgdGltZS4gVS5GTCBwaW5zIHN0aWxsIHJlcG9ydA0KPmZyZXF1ZW5jeSAwIGFmdGVyIHRoaXMg
Zml4OiBVLkZMMSAob3V0cHV0LW9ubHkpIGlzIGRpc2FibGVkIGJ5DQo+SUNFX1NNQTFfVFhfRU4g
d2hpY2gga2VlcHMgdGhlIFRYIG91dHB1dCBidWZmZXIgb2ZmLCBhbmQgVS5GTDINCj4oaW5wdXQt
b25seSkgaXMgZGlzYWJsZWQgYnkgSUNFX1NNQTJfVUZMMl9SWF9ESVMuIFRoZXkgY2FuIGJlDQo+
YWN0aXZhdGVkIGJ5IGNoYW5naW5nIHRoZSBjb3JyZXNwb25kaW5nIFNNQSBwaW4gZGlyZWN0aW9u
IHZpYSBkcGxsDQo+bmV0bGluay4NCj4NCj5GaXhlczogMmRkNWQwM2M3N2UyICgiaWNlOiByZWRl
c2lnbiBkcGxsIHNtYS91LmZsIHBpbnMgY29udHJvbCIpDQoNCg0KTEdUTSwNCg0KUmV2aWV3ZWQt
Ynk6IEFya2FkaXVzeiBLdWJhbGV3c2tpIDxhcmthZGl1c3oua3ViYWxld3NraUBpbnRlbC5jb20+
DQoNCj5TaWduZWQtb2ZmLWJ5OiBQZXRyIE9yb3MgPHBvcm9zQHJlZGhhdC5jb20+DQo+LS0tDQo+
IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZHBsbC5jIHwgMTcgKysrKysrKysr
KysrKysrKysNCj4gMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykNCj4NCj5kaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9kcGxsLmMNCj5iL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZHBsbC5jDQo+aW5kZXggNTNiNTRlMzk1YTJl
ZDguLmMyYWQzOWJmZTE3N2RiIDEwMDY0NA0KPi0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2lu
dGVsL2ljZS9pY2VfZHBsbC5jDQo+KysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNl
L2ljZV9kcGxsLmMNCj5AQCAtMzU0NSw2ICszNTQ1LDcgQEAgc3RhdGljIGludCBpY2VfZHBsbF9p
bml0X2luZm9fc3dfcGlucyhzdHJ1Y3QgaWNlX3BmDQo+KnBmKQ0KPiAJc3RydWN0IGljZV9kcGxs
X3BpbiAqcGluOw0KPiAJdTMyIHBoYXNlX2Fkal9tYXgsIGNhcHM7DQo+IAlpbnQgaSwgcmV0Ow0K
PisJdTggZGF0YTsNCj4NCj4gCWlmIChwZi0+aHcuZGV2aWNlX2lkID09IElDRV9ERVZfSURfRTgx
MENfUVNGUCkNCj4gCQlpbnB1dF9pZHhfb2Zmc2V0ID0gSUNFX0U4MTBfUkNMS19QSU5TX05VTTsN
Cj5AQCAtMzYwNCw2ICszNjA1LDIyIEBAIHN0YXRpYyBpbnQgaWNlX2RwbGxfaW5pdF9pbmZvX3N3
X3BpbnMoc3RydWN0IGljZV9wZg0KPipwZikNCj4gCQl9DQo+IAkJaWNlX2RwbGxfcGhhc2VfcmFu
Z2Vfc2V0KCZwaW4tPnByb3AucGhhc2VfcmFuZ2UsDQo+cGhhc2VfYWRqX21heCk7DQo+IAl9DQo+
Kw0KPisJLyogSW5pdGlhbGl6ZSB0aGUgU01BIGNvbnRyb2wgcmVnaXN0ZXIgdG8gYSBrbm93bi1n
b29kIGRlZmF1bHQNCj5zdGF0ZS4NCj4rCSAqIFdpdGhvdXQgdGhpcyB3cml0ZSB0aGUgUENBOTU3
NSBHUElPIGV4cGFuZGVyIHJldGFpbnMgaXRzIHBvd2VyLW9uDQo+KwkgKiBkZWZhdWx0IChhbGwg
b3V0cHV0cyBoaWdoKSB3aGljaCBtYWtlcyBhbGwgU1cgcGlucyBhcHBlYXINCj5pbmFjdGl2ZS4N
Cj4rCSAqIFNldCBTTUExIGFuZCBTTUEyIGFzIGFjdGl2ZSBpbnB1dHMsIGRpc2FibGUgVS5GTDEg
b3V0cHV0IGFuZA0KPisJICogVS5GTDIgaW5wdXQuDQo+KwkgKi8NCj4rCXJldCA9IGljZV9yZWFk
X3NtYV9jdHJsKCZwZi0+aHcsICZkYXRhKTsNCj4rCWlmIChyZXQpDQo+KwkJcmV0dXJuIHJldDsN
Cj4rCWRhdGEgJj0gfklDRV9BTExfU01BX01BU0s7DQo+KwlkYXRhIHw9IElDRV9TTUExX1RYX0VO
IHwgSUNFX1NNQTJfVFhfRU4gfCBJQ0VfU01BMl9VRkwyX1JYX0RJUzsNCj4rCXJldCA9IGljZV93
cml0ZV9zbWFfY3RybCgmcGYtPmh3LCBkYXRhKTsNCj4rCWlmIChyZXQpDQo+KwkJcmV0dXJuIHJl
dDsNCj4rDQo+IAlyZXQgPSBpY2VfZHBsbF9waW5fc3RhdGVfdXBkYXRlKHBmLCBwaW4sIElDRV9E
UExMX1BJTl9UWVBFX1NPRlRXQVJFLA0KPiAJCQkJCU5VTEwpOw0KPiAJaWYgKHJldCkNCj4tLQ0K
PjIuNTIuMA0KDQo=

