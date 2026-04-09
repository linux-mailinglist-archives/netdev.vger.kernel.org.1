Return-Path: <netdev+bounces-276893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MewHppn12myNggAu9opvQ
	(envelope-from <netdev+bounces-276893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:47:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC083C7EC6
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC5EF302F25C
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 08:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8162834F48A;
	Thu,  9 Apr 2026 08:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3T2KDsc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AD3324B1F;
	Thu,  9 Apr 2026 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775724353; cv=fail; b=sDoYHRs7L2ycoBC3UX/g4WCuCfEz6O7ob3OjoI6RIt2FRo8YbxnB1+ut+o3zl/bNaYPd7OaRYkCQ0i1jxNIG0spNYRORvmle9ihoN7jAmWrc0LKyXYXwJrZSvdFCXpO7jP1zqMrPdiwS6pnQ7uzgfxAdjP+ji1Rrl5r7TN38BlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775724353; c=relaxed/simple;
	bh=xVk6CScZ/o/M4m49uajIRQ9ODy56pZ04B3W2G9bLrNg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aLOIQK2RqYl4uZsV/uG2AhyndC5VAXQi9hb56IUP5VTpw/+TOYGgLgjDIxzRUkaMif7xQkUVFlI77DXCaS8ZdGiWXiSyDhiV3G8y/wFn/RHfwJWVWqpgzQOv6j/8agyn5RyCDim+AWYKQd20SdWvnlnG52Qg/bzvw7PgK6yu5ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A3T2KDsc; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775724351; x=1807260351;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xVk6CScZ/o/M4m49uajIRQ9ODy56pZ04B3W2G9bLrNg=;
  b=A3T2KDscnQIbysNyI373oHcv+DBEJv5jEI34Bj+U2K7RP1NvVFU5TWy2
   75odnp1rkpt22VF2hNse0eeDWM0kzEKV6fieYAf33vULx6seIbGD4J8yk
   ZoEZ4c1rtJYzjhG1jUutg2mVyxYxbxUlKjPOPS5cE18HgkvJZAeEdC6CR
   Qrgt+l/iIOXtc02++n7RYPuBxbZ6XxcpxwVyxqBMR+/1Jtk/eZjobtqn2
   OsqG34jAPwg0s/AxCuwBIr4I/v7T/tgriFzfK66gEP9PM7VRyD/vqeC2z
   YC2OCs99OMuMi/zeV4puWU+nWYNewnbg1R0xk2o41R7w1VSuav53sqNDt
   g==;
X-CSE-ConnectionGUID: 5KbACg57QyiEo82aZiqTTA==
X-CSE-MsgGUID: 1r9jqMgmTU6Gq0elrYhIBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76602122"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="76602122"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 01:45:50 -0700
X-CSE-ConnectionGUID: EI45RLxvT2yXT0gwddSGLw==
X-CSE-MsgGUID: Eyh94OKISH2Zphlwe2+K2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="259157534"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 01:45:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 01:45:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 01:45:50 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.12) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 01:45:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJhXADgaTQXufN67WUDJDEBYbqi1XTSz5aBNjq7XLlxJV2NH8LpIRxNecTCIXVWMp5eJY0AGQqGxW/nh3kX3hZQWhAl3TmRd919ZiGbuldE/YkF3l3fV1D8ciEluXk9YxCkOu1sD9cepjb4RD1idC7zLZ8txkZXt6f8/RZjXZzhz2VSUOSC9IEhBx+2RqBNwiCtYSeQhIJ4dWAuowIO+YbJAlyNlc/Asfwfddpk6hJzuuWiwEkbY0xLbjsFosvjQAd2aQlXnHQ8bsp7bdU4xXxDzMbRJthUniz6bTT9/pvs3FLXHkyGBdrEhZgBOXDt39KJ4+IhGeY+G7cVbjGRGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5xp+LPdsxy14qtIIOAb9BI9SmsmquXjpws6x+2+Jw0=;
 b=IFiifgSZYN2Pw9B8VpChQr5WJ5felAMah/TKFHGjhiXWbFLqFbFoKf6pEtT0edNnCGCWJfyW/eJ1hdhhj0vPWxb8L8jPPKfFy3yWdtt0FExm6b36Y+C1PsLNqLdKjNV4PZ9rqbN9f8SL5lJZPZ8PZlmLuUIro2aWsdG+y7hG/7BuhxqEROErWPMYlv02A+agC9CEg65RFFXqgN1Xopg51dlCWNTyWEyR02TzTPaLf3IIy6Ktl/TRHRQNR3t7c6pKhpF0P5RjjZf6YecdiDUaMI4qCbAHwk5Gpz8r7l0HjAnx4RTVD6bPi59g9J/Fq88UEINFLtV2n4zm2gUy4r6Atw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS0PR11MB7960.namprd11.prod.outlook.com (2603:10b6:8:fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 08:45:47 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Thu, 9 Apr 2026
 08:45:47 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Matt Fleming <matt@readmodwrite.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@cloudflare.com" <kernel-team@cloudflare.com>, Matt Fleming
	<mfleming@cloudflare.com>
Subject: RE: [Intel-wired-lan] [PATCH net] ice: Fix missing 1's complement
 negation in GCS raw checksum
Thread-Topic: [Intel-wired-lan] [PATCH net] ice: Fix missing 1's complement
 negation in GCS raw checksum
Thread-Index: AQHcx52Wus8Y9aTtgUiaojGbSlgRrbXWawWQ
Date: Thu, 9 Apr 2026 08:45:47 +0000
Message-ID: <IA3PR11MB8986EA00649C92EE3FE6FBE5E5582@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260408190214.1287708-1-matt@readmodwrite.com>
In-Reply-To: <20260408190214.1287708-1-matt@readmodwrite.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS0PR11MB7960:EE_
x-ms-office365-filtering-correlation-id: 09a15001-0af2-4712-c6cd-08de96146538
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: uMU6VE6rAdTzRnvL3i0cHUrpNmY0kBAxt1QSlf6TsS5hGIprOPAC6RaLUM6JZYNQ+ryyJ0aSjIbc+ChlrYFzimGy413XwF1oOBBcNki5uVcR3lTR5UP8O+quE+trE5gAdAWi7hOhr+q2N31JPg0qNHMSU20n0CAWSFmhNYJQ2d5D7dMGXea9ceJ2IQkmWQ11012q/vVR65BJJOgta13MivQURTbYHx7FkLP2CbvzbauM4KOoZQ+nXPdS6mSnGCLFJ6lOs1w4uElC/CLQXlVGcrY6XfhretFonuXTb3w+1tfU7Ez8P73z/VM40JW5JfX/GPcdd5EQLD+R0soHTS+WBX/Mk344TtWCKoA66arVGgz+YYPT1oVhvL04PKIMotd1x+KiJFnhhuUl4q40/6XVU7Qu29Gmt8bW/f1rUE21Rk3DGuiEjD+u9RZA4KJGA5B6pQGstRSRXw7/GNFGTfRAtKm5YIwa7FVkXC4/XlSzh3eQeXLG831Wds4H+h7o/yBJSH2jqSlbJUkNhsBQobBdbVYouzPudlMzQtiyMly71eY2iFfDYlk97I6QRUaFuK8lUIkeTvQ1TzzSxTMXpE9UJUU5LpJWh9a4+EKQxiHteOcSMc/TEtbL0lf541GwrBCeSvXymhjgpS+jMTaRAPnfHzwBbm/fZayXSFJ1IHFwY3EwqFuD5z7Kneq3JGIS158d69POEIYZUuMcPda0U6chjMHf6cOtiBRmUFlJGMhsdg0K6mG8EarXkexAT7tddNw+AaGDPtt7vxjk3g26r6tcAOYqsscXeF517fwDSNCeKIc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DtLE2m6bQuACpsixN5fdZbqoqd4nTaO6q5THFscnNi1RenXVSLmnEvDAf7/e?=
 =?us-ascii?Q?hNqu/zHHjyduxU4J5LAtxUUYNwKZ8BK6C9DAne2YSgXx5bpHissrja2rahUy?=
 =?us-ascii?Q?uXxYwXXlMYahtWzSuCk1pLS8tLbg7RvlMKI4rtWXGXX5/Q455KhQkGjylbIr?=
 =?us-ascii?Q?wwmqViDt0He6duNN2wkRH5YS/keigqdxxTiKegMBma/J6zqUypm3rBiEXdnM?=
 =?us-ascii?Q?UKMcDzJEx7lXfpG4WUPPT8VLhlmIrHJww4Ti9LJ1+2qEuKd/qhTRyo6jFlbD?=
 =?us-ascii?Q?vHM4hocFrffK4q8fIRvuEHULsi/Jhnor0x47TFPoZD7cbyt6gy1iqPkkAQkN?=
 =?us-ascii?Q?1k3aI2ZZrx8xQPFtN00Ms+zBZCf5vKxWIDk9IOIKhwyOs8I6+uHQH9DJQR27?=
 =?us-ascii?Q?pH7hI0StiA7/2tUHuW9EpwszaH8vR4/HuNBv1hbtmtQm1t3G3/BxX0gEl+qr?=
 =?us-ascii?Q?qbM7OfBYvsvgSyiHmDMf5mkYbTqTSOaKWBHEyHuaXTV+fhRbCxg0SbPWd5J3?=
 =?us-ascii?Q?b+IdU/meNAxfg8KHEpR018GT0L9oqZ65APfVxIgf9pncmKg212lw6xATx6NN?=
 =?us-ascii?Q?0kg9GlT2ulQpS9puwZ+W6owczaBitrLDt1MmJ8vz/j1L96DYtZ8Dv5V9ZMrz?=
 =?us-ascii?Q?LFiyONn3j46SzytV4xEvWzoAtCK6b7FCgSJvfOftoIpwNPUNsHy/amCNLolv?=
 =?us-ascii?Q?MLrJ8g9wgdlpDaL3lNsfpBVEv0YhzQ9q0S4hx2pt9apl+QWMjPndPcuDX5aQ?=
 =?us-ascii?Q?GeZ0Cv5F9U+vqeBFgzG+fAYdsHhe7iDrPx4WdKr59tsF+CpsIVT+OKsL9S12?=
 =?us-ascii?Q?Pte6n4JstOzeK4OC4q0KWpux+hWemgAXa+YRtb8HeWGLHEXpS58Tnrwf3Oes?=
 =?us-ascii?Q?EOrVtm5VZd8wi0PDXFmAWWNSns8GKXPs30ybpDcOs+urw/ZVnaLnHFRb3b5Y?=
 =?us-ascii?Q?Z/O4rvuhjAHGbko6YgvHmwDoH0G6yzltNE24WlzWegAXPA5YqQ818/0+5F5o?=
 =?us-ascii?Q?0K3mv4fj/aynJhTIaPj77dzV82C6MZN0Tmp7Jo2wmY3Dg11KXZ8dBkhzonsb?=
 =?us-ascii?Q?uZahKRL++R+TW0aUQOg1wJDSq5hSWE2G8ZhWjK0EVFDP6/uu+rqRVD+v0uGp?=
 =?us-ascii?Q?cYZA8W3NCsc8G/0PJj95YtHDzHg1DcaTr7wVV1F1Z1BWjgthd0BbuOIEUTxt?=
 =?us-ascii?Q?t4NcIU6rh07SAJJ3SLaHRsH5DaJhyHrJ2+fMZJJj7mteYTXV4iLiXkmDgMbJ?=
 =?us-ascii?Q?pQCyMTjN20Cs3Crb9UM/1LWLEVXzG2jVeShKvhRWmUqW5Mb+hC5M6YUfHA8d?=
 =?us-ascii?Q?rxbsMH9JzhCQKx7vl15vALImz3nakh59bmyGrwOW7PcmzXhaFHROw/+V7BZz?=
 =?us-ascii?Q?ZS5kOBEJipZa9UUoGh+ju/YlcKRUaFvTfbPz1lTVSRk8X+PBMk/4Kl6yMbeW?=
 =?us-ascii?Q?OF95Zeq03hADTOrHWx9ATumd5DRa47hrLSETcFHtdAelJKVe81xJJRdq0WXA?=
 =?us-ascii?Q?QgUlGmA2+OIcyEcxe5Ntg89Y/dbCC66CqAliXxIw54jud54nncS4BXb+PzWY?=
 =?us-ascii?Q?tQ+LAX2bddMk2R6+AJHkxG0C1LtMvaXuhsUXZFi2Kjmm5HsO93yoATBv0JY4?=
 =?us-ascii?Q?g4s+eNK4HiqYYrBVfesUp162JHdGSKIqgoWgd2EXdEC1TyltwcpDNjj1/IEZ?=
 =?us-ascii?Q?t7i2Mo4y5k4fd5C7ytiptmoEd+OKmfb4RMdaLT8YF3DLFaDnAx43oWVdP5uJ?=
 =?us-ascii?Q?5Z2yNhVG0EDeCIfctoOjgJQBDfRk9aI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LTdZO9Nw6+PqywxrNzAHoI6v20qb5Hstz6lHzqRRVX+AD6R89BVt2mpUj7j/KySlp+QRI6Hoy+MmR5x536BB2LpNOvRKFMolaZP/b6QWJJeo4TESg255/0Eaq2IC0fSwMuRHgfj95GVHgsEYSC7F0YQE88E7opQv9Gvft4P1b9CL0FHyQpuYb+zEjfSUNliGUQcsjD0TX/OqKJ3bwcns1dQWMrAjGP4uZ29PdcpbQReSmZh/LP7QIK37NKyOlf1ZQFzW+4tQL6hsLByieCeI9+mBnum+/zlIvaQAcyYOmOrBMYtgkmNByGbKR73DO06sTSrGfy5QcegZ2XiMIywu8g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a15001-0af2-4712-c6cd-08de96146538
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 08:45:47.4772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jndmgqwHoMrQC3UxoW2RFB7zYxQv+HCQJDDFCkpZHRvl0cahjHnIBZ/GzB59qHNyWiOPSERvR/5hrM6ReFME9zU89+PhWchXg1zOQ+/lGUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7960
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276893-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid,davemloft.net:email,osuosl.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email,cloudflare.com:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: CAC083C7EC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Matt Fleming
> Sent: Wednesday, April 8, 2026 9:02 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>; David S . Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; intel-
> wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; kernel-team@cloudflare.com; Matt Fleming
> <mfleming@cloudflare.com>
> Subject: [Intel-wired-lan] [PATCH net] ice: Fix missing 1's complement
> negation in GCS raw checksum
>=20
> From: Matt Fleming <mfleming@cloudflare.com>
>=20
> Commit 905d1a220e8d ("ice: Add E830 checksum offload support") added
> Generic Checksum (GCS) support for E830 NICs but omitted the 1's
> complement negation (~) when converting the hardware raw_csum to
> skb->csum for CHECKSUM_COMPLETE.
>=20
> Without the negation, every CHECKSUM_COMPLETE packet fails the fast-
> path validation in nf_ip_checksum() and falls through to software
> checksumming via __skb_checksum_complete(), which triggers the rate-
> limited "hw csum failure" warning. Packets are still accepted (the
> software recheck passes) but hardware checksum offload is effectively
> disabled and the warning floods dmesg on systems running nf_conntrack
> on VLAN sub-interfaces.
>=20
> Multiple other drivers (idpf, ehea, iwlwifi, cassini, sunhme, enetc)
> also apply ~ for CHECKSUM_COMPLETE. The ice driver was the only in-
> tree user of csum_unfold() for CHECKSUM_COMPLETE that omitted it.
>=20
> Fixes: 905d1a220e8d ("ice: Add E830 checksum offload support")
> Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index e695a664e53d..c177579e0114 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -92,7 +92,7 @@ static void ice_rx_gcs(struct sk_buff *skb,
>  	desc =3D (struct ice_32b_rx_flex_desc_nic *)rx_desc;
>  	skb->ip_summed =3D CHECKSUM_COMPLETE;
>  	csum =3D (__force u16)desc->raw_csum;
> -	skb->csum =3D csum_unfold((__force __sum16)swab16(csum));
> +	skb->csum =3D csum_unfold((__force __sum16)~swab16(csum));
>  }
>=20
>  /**
> --
> 2.43.0


I'd recommend adding Cc: stable@vger.kernel.org
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


