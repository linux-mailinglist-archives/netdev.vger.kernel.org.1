Return-Path: <netdev+bounces-302105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wQkWLQsgPmqEAAkAu9opvQ
	(envelope-from <netdev+bounces-302105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 08:45:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CAE6CABB1
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 08:45:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=YJi1X6Mi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302105-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302105-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41DDC300CE51
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 06:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7912E888C;
	Fri, 26 Jun 2026 06:45:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABB725A655;
	Fri, 26 Jun 2026 06:45:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782456328; cv=fail; b=twlmOqFpXlimRT846CJ4H56JLy8mWHTD1OXK89o4j2LmiHDylAe/QHE0xFblRp2A4Z1eTC/7fSVNsrHPQBXugBDbU0un8Kj7KVWnt3RcUBt4OtQQFaztFV0vARdkpvRkX7B0WA/8tSZjM2LGrQyMI+yARZR4vAbMCppRF5Cxs+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782456328; c=relaxed/simple;
	bh=Ram7a/MhXMBRriBi6/xD7dovT6/MQ3ZAhQE9Vr5aja4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZBWPazd2f6FpVcu89pSIx6+U0fJPXtqC2HkDJKf6dEN+ME5x5MG4pTGUWOWDLCb6vpsE+Jo5b9x4ifR/N3OY1saJOMjlDepFjdJBST8ryw9FdGd6mRHBgpwPCqBrAeKLvmgvLnnZeITUSgj4HBlG7ITEBmNJaTqL3YDloPC8BS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJi1X6Mi; arc=fail smtp.client-ip=198.175.65.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782456327; x=1813992327;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ram7a/MhXMBRriBi6/xD7dovT6/MQ3ZAhQE9Vr5aja4=;
  b=YJi1X6MixovYNxXk+vt/V401YbgVMV9YcwTB5nqWtKEsf/xoTvV0mjG0
   v0O/ntyTOnKbdBonyg8Yey+95mSqC8ytiwto2HA0iErCYwdw2lFpVoPWL
   C+fcK6oIrmWV9sdQ7/+WRyilhfCIdvKraMekH/vipPIRrh8opUifNyWCx
   9wTw2DwTxzLVQnQ4keLuYV6T2pX/a2NJTBqmN/bJHYk01m4J8C4yD2ytJ
   1aJEFrKg3tMeHv/cNEgFO4lxTlcn4DFG0s2mnE9S3z9T5wvKjAHxP90pW
   KPA+t70eL9JFlfmEwlWo1wqGKptMPbIRYex0yY5hSKrg7acDH4yCUT5Pm
   w==;
X-CSE-ConnectionGUID: AbQcyA9ISQaAG2DLf9EWEA==
X-CSE-MsgGUID: 5t5oEym8RIiPqzfYhXZdRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="87151246"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="87151246"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 23:45:23 -0700
X-CSE-ConnectionGUID: S6za2vdvTBGksHKdOzWRtg==
X-CSE-MsgGUID: yIRKqLWGTiKSoMTp7Qmblg==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 23:45:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 23:45:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 23:45:22 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.66) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 23:45:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7T4Wxc2/OmGC61KmR/liE7gwtRyeTMdx1/vzoNdWSc3Rd1Vxo/zk4WaiSq50L6YJzflElPChqVpYBWal0KAfbO6N1N20+gxCC+Iv19IfxC5da9mQGy0VqfywYi/hHzYmjTPvE3+rYq859Cb9vT5zU4bAMNDwPN8nQDJp6uz2bYWghKCMWxQAFhtvVWg52ovFGP0/3ZZPp17MFFQW3j+9R3B157ip5xiIwHdGbOBgdiUmOhqXyHUg5cSKVL4fS3FM9r2CbI4IMeKWsanQo2VLD92MmXtg0A8R5UDLeLSaYXrhfjgCjQA/ngGlx4wtDOcRi3Zpc7wnntdno2I6ANCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4iUZk+RS9bLMcSctx50whUPmmK2swVZxPR47H51icA=;
 b=wF198Op7CqheD9lp+ZBMRIQMnnGjGKq7QeIv2uPKDrjAft4RjV9MkxopMzYBk/HqxAVOS0qTrpl7qZUgh+aAPfgMPYZNnJ9CIXyieoqzvacB7kmU6ILiEu3XmmUeSjFlcSVOxhF3F8ZIUMl4znr4lVALhK3D5c6ZB9GcfuRfEnNfdLAzDEeOP8sEL2/jsMLS3BZyHpsT4NfaOOOQHZyCiZq6N1hZJCWfjQf+3JeNsX2qO7y8uhloce/PPYzg6JwOBK1xxYVIaE/NT4yRCJlRsuoFIIe6M3ZCNkfnfzuQb74ZnAfNv29zBkI7LPEukoCoYczAAcEJdYTxafdL1sBB/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV3PR11MB8484.namprd11.prod.outlook.com (2603:10b6:408:1b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 06:45:14 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 06:45:14 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH] ice: propagate ETH56G deskew read
 errors
Thread-Topic: [Intel-wired-lan] [PATCH] ice: propagate ETH56G deskew read
 errors
Thread-Index: AQHdBLq0Sqknd5/1kE6xpzDSa06qKbZQZK+A
Date: Fri, 26 Jun 2026 06:45:14 +0000
Message-ID: <IA3PR11MB8986ECF123D6E955AE4FF3BBE5EB2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260625030305.85304-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260625030305.85304-1-pengpeng@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV3PR11MB8484:EE_
x-ms-office365-filtering-correlation-id: 894dcc44-7031-46ad-7ef5-08ded34e7a26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|56012099006|3023799007|11063799006|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: RS0FYKiyx+AecrrRuNHkYFIQIGItJWykXJVnSPxoneTTA5DOc1sLIxD5ZqkNQrKj3DPwQeDDuGmyJ5ss/+Pq0ydPjC3U4kVezwlcFNe1hI44jDHiKBRBfs/fbqTV3WXY5pVKdRrgnHJRuLUashc3ZxxqPEJ6jlKu57vuxLQsaCc7YhjoxPHD9Kvz6SGEoGupFES15zaoZMy7sE1YHRlqvB9Ae7xl0YrebJwpaddH4FMk26vSoKlCw3VoKc3TUVlB9A7nJ6vdqB1F0+qYuEEYZhfnS2qXdyt6a2ay9y5m/zVfTwxiAX9UqCm+W4VrJ55dKxgBhoa5uVOdTxVZb+nzoveyQbmVOutw8p0cExtFp5BERLf1nd2oUJemZQ9phO085rdBFgkP6igG/BHW80tE26OgJXlLx4L5ed7dtnz57/403aqlUbviZrWH2X/eOPYVay8bz+n45aAOcLjlu2ERnKPrqVRzeKPQZ5REHGQWSgNDMSqwK5pRkI114xGxJnvw2s6yLGNHFIKADTRceddodgTDz5WPqqy+7WRyUIZ2Ib+HtNGE4h5YpAj89LMeERB1oEadVJVS2B88M+GqTs2+KuIQ0jMmyLsIiZm316veLe93q+tf3t587fqJxWB1iP0UoiWDF46i94QHOeyomF/a2XuI39Hu8UQmR5XA0eAyvYDKcOsF12jvTN0cOb2qY9L+AODcdX2GH1QkTMZsO19pcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(56012099006)(3023799007)(11063799006)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e6XnzdX5su0ChZW2h77rS9/nhsN5x/nmolDZSvXRmVnLxjv24IQcgc2k/jNh?=
 =?us-ascii?Q?ReaIfEYAsMQ5T2K1ge4YCfv7JIfRW3SBBlSpJbWZ4/TCGOoCkDyW+7bMxKUK?=
 =?us-ascii?Q?F2g1iCl7C8I7l2Eqx72LDtGpMbYpWI9lX83oThfFjIdKqV+Ok7iaiVU03hQi?=
 =?us-ascii?Q?58byRxmRDDkAPTue1Rf6Kbzj52SkoZR9Rl9B93OW8q3k+GBWujBz/w/VbTfg?=
 =?us-ascii?Q?qz0gYRMbrXA0tfRL3/gAc+014SWEiYfjPUFORyN3Qkq15/IorULQzWwCZLTh?=
 =?us-ascii?Q?BJGllNXOsyXgH5OwkS1UqPR4XeJXzzx/NX08YYQuzGSEbUj+dRAwl6VAM+mM?=
 =?us-ascii?Q?0rzcApF2hpGkYMR9wdlQnAOkY9ZLzxTZfjitSFij5Eogtd0Ijek32GYZ8k24?=
 =?us-ascii?Q?mrwt3CETpMZm2RKeTX20F4Ubf4Awp2vw4UbHpiL0irZfesGfHAx1OSp3kxCb?=
 =?us-ascii?Q?3DX1e31xGssSjqthYezSKTJvqopW1aFEhUoBjvhy81yFhXNl/iBuFBZ6r9YZ?=
 =?us-ascii?Q?gLpCmDxQEaslZ+A1lvwWxaL7Ftf+tlCzQRdf2WoTM7FG757DekjiYZm44A42?=
 =?us-ascii?Q?du+QRXkPBicOYul87ZcJA7JnInMgPPebt6qLvks52zqSQZmrgMf3BgSnSo2b?=
 =?us-ascii?Q?lU5e0KMjKnw/oCF2qoYEHvvs/Hv4ECJJkEuHirNGSyy0PeOEHJLR8ecI3af8?=
 =?us-ascii?Q?21B+AKnF5lTXQmxa0zEt3pOiVhcn1Waa4Ty25aI38pUF/wDfCp1Z3wB4DVQ4?=
 =?us-ascii?Q?wOCxcigDUULSim3LyEHLSy4kkO+6+CX4Fd2/EL8kBBy9dTnSL+J0AQYO2Nsu?=
 =?us-ascii?Q?rKRPzXUCS7boFpmHnyzBHhIxVl4+nQNP63ibgNqyKrKoq2w1wdlw73FuhjCV?=
 =?us-ascii?Q?4dFvmkieHSXbevpGwJQdMjFkgYXH/zd6vwXqrTvnC5nPo6O6W25n41921lDX?=
 =?us-ascii?Q?Fwl9reR+IYv6aZexGLpp/tO3YRCCUQCwZs6P8zDqVg99BGIDuv+VmgWSVvkC?=
 =?us-ascii?Q?YQ3sbmSKu6h71Ur2lDy6G4RQTtV/M1YiVwmpRl7hh0ssF2C6FV8KgMOHCRKF?=
 =?us-ascii?Q?OpqMw8SlmJRKlGoxUR9ZiuQ/yQ1vwRzFfXbMpq3287X8QrUcYYQo+tehiggG?=
 =?us-ascii?Q?ilvm9vH37drOwJazLwbog7xMNP8/L6XLIwcJ1Dnc/pc5HqO8YWVGkcF5Ke/c?=
 =?us-ascii?Q?m5tb2v6VnevWVATbK6Dub5NAGYDdcY17xGGuI6LrVTLz+rRrq3lN/J1M/i7j?=
 =?us-ascii?Q?rI7D2WvyYldkC+heNSxXRH6gYQhPkfvTf9jq/LOuw5gCdIm8+CmjaNulahWs?=
 =?us-ascii?Q?wnY2assljZPIvYAOXZwBJZuOJsmb57krolyNbQ1GCQFWJFaYEk89Sm57/UoU?=
 =?us-ascii?Q?ly3HsajC8/QuaGXcuQrUnONnIV9NvtacyGJkFzyYqDO4p28FPT9aD3yFvcud?=
 =?us-ascii?Q?mXO5SXMmFNuIk709uGSfVT4W75C0AfdOXe7OCIRZV0to/nfwKbBiiU+9cCn0?=
 =?us-ascii?Q?JTW8JdODm6NFWGU6IxdR014NZLDC0XBxbYQ7phGSDNL1qvzxeNhQMNEYWi52?=
 =?us-ascii?Q?QnuT4ZOSis8PG9f4rtnOkmQcnKgwZciJMp5PGaQvqDxtKXn4OTf2GbBHn03+?=
 =?us-ascii?Q?tP3Crl3FKyKmq7jrovnVUEV5GQ+I+sO3WLDxTJuq5NCwnFeIALCS5JAbTqdl?=
 =?us-ascii?Q?Hh2fNCxs9uSqSx+bMjV//jp8zk81+5GcQEF2a1ykegY/w/0QjWIgBjsu8CvO?=
 =?us-ascii?Q?jCJq2UmH6qB1svrWaEm687iNLBvV/og=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: n2HSvbIuKrqwkN45+GY17gwhhGCMp+9UvxTxhOt5njZ3FnPr4vJZYXh4vefDiPpuTKKoRxLlexuckPCkJxV/oW7EhhhrpPwDsrViAyVZzWdMrFc7bqU2Qc3TPVDCQ4fHFAq/DQ+XbKv7jzviIlsHXUuqjD0nuqEUYcVFL0Oh1gALQPPpYkzYbaicxNRkcs3J7RgxFBJ+W1GGeMsHrTFS47q3JKQK/m3Gwz+SJEZ8OAiSg9i+E80vwhCsTiv8GxpnyMWykFpwHfhkBn1r+pk3GNZJRrV5o3RdB/KruMEsiL2aFl6AW31AVLLVrXVwjNiKgsC0tesFb7TNyBSvQmO6AA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894dcc44-7031-46ad-7ef5-08ded34e7a26
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 06:45:14.2986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x2U6dy8U1jMqich9KcGrhUoA8MTKdICB0PjmdBt1DzCrT4tHXnm3uByZnCy/seKDzVohymmL8Qx2WVASII7xTUA9Fb4gvMCKh39k+Cae8aM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8484
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302105-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lists.osuosl.org,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82CAE6CABB1



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Pengpeng Hou
> Sent: Thursday, June 25, 2026 5:03 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>; davem@davemloft.net; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Richard Cochran <richardcochran@gmail.com>;
> intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; pengpeng@iscas.ac.cn
> Subject: [Intel-wired-lan] [PATCH] ice: propagate ETH56G deskew read
> errors
>=20
> ice_ptp_calc_deskew_eth56g() returns a u32 deskew value, but it also
> returns the negative read_poll_timeout() error when the DESKEW valid
> bit never appears. That converts the negative error into a large
> unsigned deskew contribution, which can then be folded into the RX
> timestamp offset and programmed into hardware.
>=20
> Return the deskew value through an output parameter and propagate the
> read error from ice_phy_set_offsets_eth56g() instead of using it as
> offset data.
>=20
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

I recommend to add Fixes: tag, and proper net or net-next in [PATCH ] to st=
eer properly your fix.

With the best regards
Alex


> ---
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 27 +++++++++++++++-----
> -
>  1 file changed, 19 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 8e5f97835954..bd2e31b816a8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -1736,17 +1736,21 @@ static u32 ice_ptp_calc_bitslip_eth56g(struct
> ice_hw *hw, u8 port, u32 bs,
>   * @ds: deskew multiplier
>   * @rs: RS-FEC enabled
>   * @spd: link speed
> + * @deskew: calculated deskew value
>   *
> - * Return: calculated deskew value
> + * Return: 0 on success, negative error code otherwise
>   */
> -static u32 ice_ptp_calc_deskew_eth56g(struct ice_hw *hw, u8 port, u32
> ds,
> -				      bool rs, enum ice_eth56g_link_spd
> spd)
> +static int ice_ptp_calc_deskew_eth56g(struct ice_hw *hw, u8 port, u32
> ds,
> +				      bool rs, enum ice_eth56g_link_spd
> spd,
> +				      u32 *deskew)
>  {
>  	u32 deskew_i, deskew_f;
>  	int err;
>=20
> -	if (!ds)
> +	if (!ds) {
> +		*deskew =3D 0;
>  		return 0;
> +	}
>=20
>  	read_poll_timeout(ice_read_ptp_reg_eth56g, err,
>  			  FIELD_GET(PHY_REG_DESKEW_0_VALID, deskew_i),
> 500, @@ -1766,7 +1770,9 @@ static u32
> ice_ptp_calc_deskew_eth56g(struct ice_hw *hw, u8 port, u32 ds,
>  	deskew_i =3D FIELD_PREP(ICE_ETH56G_MAC_CFG_RX_OFFSET_INT,
> deskew_i);
>  	/* Shift 3 fractional bits to the end of the integer part */
>  	deskew_f <<=3D ICE_ETH56G_MAC_CFG_FRAC_W -
> PHY_REG_DESKEW_0_RLEVEL_FRAC_W;
> -	return mul_u32_u32_fx_q9(deskew_i | deskew_f, ds);
> +	*deskew =3D mul_u32_u32_fx_q9(deskew_i | deskew_f, ds);
> +
> +	return 0;
>  }
>=20
>  /**
> @@ -1789,6 +1795,7 @@ static int ice_phy_set_offsets_eth56g(struct
> ice_hw *hw, u8 port,  {
>  	u32 rx_offset, tx_offset, bs_ds;
>  	bool onestep, sfd;
> +	int err;
>=20
>  	onestep =3D hw->ptp.phy.eth56g.onestep_ena;
>  	sfd =3D hw->ptp.phy.eth56g.sfd_ena;
> @@ -1805,11 +1812,15 @@ static int ice_phy_set_offsets_eth56g(struct
> ice_hw *hw, u8 port,
>  	if (sfd)
>  		rx_offset =3D add_u32_u32_fx(rx_offset, cfg-
> >rx_offset.sfd);
>=20
> -	if (spd < ICE_ETH56G_LNK_SPD_40G)
> +	if (spd < ICE_ETH56G_LNK_SPD_40G) {
>  		bs_ds =3D ice_ptp_calc_bitslip_eth56g(hw, port, bs_ds, fc,
> rs,
>  						    spd);
> -	else
> -		bs_ds =3D ice_ptp_calc_deskew_eth56g(hw, port, bs_ds, rs,
> spd);
> +	} else {
> +		err =3D ice_ptp_calc_deskew_eth56g(hw, port, bs_ds, rs,
> spd,
> +						 &bs_ds);
> +		if (err)
> +			return err;
> +	}
>  	rx_offset =3D add_u32_u32_fx(rx_offset, bs_ds);
>  	rx_offset &=3D ICE_ETH56G_MAC_CFG_RX_OFFSET_INT |
>  		     ICE_ETH56G_MAC_CFG_RX_OFFSET_FRAC;
> --
> 2.50.1 (Apple Git-155)


