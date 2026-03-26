Return-Path: <netdev+bounces-272087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIDQGoZBxWkU8wQAu9opvQ
	(envelope-from <netdev+bounces-272087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:24:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E93336BAC
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41D89301C3D2
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869D037C939;
	Thu, 26 Mar 2026 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Id7H0Qsj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF8637C0ED
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534498; cv=fail; b=BQh83pEhH/5CjYI8PNLttZakjC2FTpdfC04Qynq27rktXsI4H5yYYt+hO+Ku0g8Nx5xVRMl54OFOw86Cyx4/bQtLT1SFMuMOaYqhvPB+8U1Q2N+Zarn6ZuOuBeRUgboUI92pRgzQlD3cR35+PQ69fZZd3eeI8kkzvZj9XmGEV+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534498; c=relaxed/simple;
	bh=mENSxwXgYYLwM5g1D2vzv2oAEjidB1WAluccvRvVke4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S9BC5FsLbeDXxPP/CsZiFXbqclsujQZr9FBbQ1SBfPkaqE1EeSHdMi5i09I9GgRcsyHds/m6LkixpkPr57+7sBPp9yeh/Uf72jpg7DzrtByoEhfR+Yv8EC/p4Zpzrk4y65o+a5AomcN9VAF1UrfqGDFye8M9XbODTcag8Vwaao0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Id7H0Qsj; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774534493; x=1806070493;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mENSxwXgYYLwM5g1D2vzv2oAEjidB1WAluccvRvVke4=;
  b=Id7H0QsjEsZVvZLTveYSlKEmkH/qKdIH6DjiGZQfyOWghUNi0QvD69UX
   ufmTrBonjeyDmW/1MhipO9EaOu4K/6LQnho2S/rg6UuH+br13Ex84sXq+
   JVMT6jHSjA57JxW0aMEnLmP56tMHu91pFM15T8qapM7svIXEMKRU80hoi
   eXyuyGX6kewbIOwh9d5aVP8QP+4pVAJ6tSAgUc8h7ywmzkExJxHx+25XC
   F3XZ/zJJvosHItvR4rmpL0KCvX1xngamJGoBLqWKZu7wdI1i9/Zn/XhJ+
   mpsrL5Dibwb469LxpbagriS8XpDqPzsUKj3r2+UwK13gZvNMjEKQHhKnw
   A==;
X-CSE-ConnectionGUID: 27mfZb/AS9mQMsx007KhKQ==
X-CSE-MsgGUID: 7YTvuTxzR5evbYq05bDEMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="93173400"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="93173400"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 07:14:52 -0700
X-CSE-ConnectionGUID: v4UnXm3/R12p4ADh5dPi1g==
X-CSE-MsgGUID: Z9hRKhcwToS5cDWN5u/zuA==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 07:14:52 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 07:14:51 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 07:14:51 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.18) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 07:14:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J94xc7d3z+vupVzXCl15YTeVxh0+lCWZJC0taleULkVSl07y+leTXdcmxUw/WV0+GgtYY+iH0KnLNfywi1n8ele0h/h3bjdghLqIUFc3saJNIoUkzyKDwutPyKudslTBfhjcgpB+sK2qq+JoQuTdUlTGqjzn7nVF376OuQuEa2E/AAo+qAXv0vxilZ4sRPUm+vPEacXQMMZErq1i9xuPiyKk4FrzNA6HyrZB9qOrVssNmvOcUHJzNtDF9tJCALGmeDeX/otswZ6xEVq+Z0j++aJJGslbj7ewzGPSECA0U8gDFDkpVoZxVUv1EgR6n1D/tztMNRXDWgflZS3T2s1S1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mENSxwXgYYLwM5g1D2vzv2oAEjidB1WAluccvRvVke4=;
 b=Zx50ni1Cu7RPuajh8ml9Uu87xlhyehxkIbelfxaCqzmcYhQ26dGVlojcytxcZQ5Uu4MZTWip1ZoXaKhaxRpiTLCaJGz7aMujSKw9VvDvLaQJiLqobeK6JEvKZeRx6c6HWcO+vNHPILTr+zlKw2eucIhgB5HgkmoakiDOwkuRvrjw9UWdRotgRPytJY4oqT6QNjKIvben4EwGTUJzEGOTsSHOwQys/AwXJxLjk6L0egSIMAdxIRFjFaaUiPuHWWwaXDLc96uQcPm5VaFM1dpkY2HUMVwpjJO+8AnHvzVwElQwcnnjIZYGO/ruxFdcQvicDiUn5F2FfqWQkrJM+36VvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7921.namprd11.prod.outlook.com (2603:10b6:930:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 14:14:46 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Thu, 26 Mar 2026
 14:14:45 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Wieczerzycka, Katarzyna"
	<katarzyna.wieczerzycka@intel.com>
Subject: RE: [PATCH] ice: add missing reset of the mac header
Thread-Topic: [PATCH] ice: add missing reset of the mac header
Thread-Index: AQHcuCcw3dXM4dpPhkahPtZ3hifVDrW3t80AgAktbsA=
Date: Thu, 26 Mar 2026 14:14:44 +0000
Message-ID: <IA3PR11MB89868A515B9A16BF1959F546E556A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260320050518.422303-1-aleksandr.loktionov@intel.com>
 <20260320180410.GA151863@horms.kernel.org>
In-Reply-To: <20260320180410.GA151863@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7921:EE_
x-ms-office365-filtering-correlation-id: b5a934e9-c961-4112-fd21-08de8b4207f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 9FiX0xeMLXepp2OQVqrKHh5oe+Yft0kzSG60Q6EQamQaAzNSnmAzoXS6G4Y9saxjDP3PXeTxzrAf8iMK7LDDH1Xwr6wjULYXEznSe3B5O8jWK5xo/zgGZXXEGRKl8XXJsV9szSapw/bXa++XQHB5k67W8UKgQav5Gn3o3zibSsBYhWJw9w83boFVHQ4SZO1vNDLuRTQKoCtygRehtXxxsZro3NzGsNcuNwrQczk/0/ZCceG47VQGIc5EjeGQDM08HJUqNbQ0pApyVkr8H4Cl9kj13wti0aaEdOdPlH5WgxKMC5s7OH4cM+Z6jE+RrInj+pDoRi3O4ITjbLJWK/XtwlV1lH1mvLJBrlo8bGNMVmNc3vBUlp8uWp9dMpWj644u1GKKItQoxE1DlkSHQ+Yw/oMhZwNFbJWe9mXD3yPjj0qhDfER7d3VWqH1/JFVAGqP5MGQIIKKHonrCc5iLGtG3/pvXN8H/GI83kdmzb/WCQ9I93kXI2tOFdASfWNuXKkuVQnWO3ww9gytCA08irgzLQmIYWLyhTo/FG3qfGzSU9PzYbZMmXAwNCOrwgsZFLG9BhzhmBRQzPI+VXUU/eSCgcsK911hpRPPjEpvxKpg41JXP/RBDCBRJvqgNaeTBWFgpzhjZb0uYLDWvmsKYN17JWIbyotrhuYaMfVmCrniWJKTnth6CxVjNk2WMWYZgijpRgZ6BK9InLv6K6W7q+adzWrydDm7/hUWCJbc6iV97zKvm8oTZ2XIBK5uG+jmPk6QyysZGhmtP0wMU9vGujEe0C+leCmVHN3RjziN/5jdabQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ze3MAzce3yu2FBL+TkQw0yH487PlXnJp8GAtJJokk2DJys3O1lo8TjwducTG?=
 =?us-ascii?Q?bzLGzlHj4kMcTd0Bl9Y2+FTdbmtkWSb90wBfEe2bCdh8LFZflC+Wj4hhw/e6?=
 =?us-ascii?Q?9K0lJGdDPpCXDH1pDDNWQRdiT9IMT//Q2G1pVv0m+V8LcadKSd0KS13q3Kms?=
 =?us-ascii?Q?peOFSSugsg9Tl93VBXDxyh0d6gU2hXoFJ7/4VHpgoLMYWbDdUKrQ2e1t+JXo?=
 =?us-ascii?Q?f/owdaJMH7TgBd8DDDMnHpmNPsc44Bn6bNNTP6XzgBo5GCTxcBqWI0oO0Uj2?=
 =?us-ascii?Q?gPqq4TKlVP2pVYxtzA8lnGf5ZWteXpe+GlVhD2ALRKa0ndTX114gjOKNTk1s?=
 =?us-ascii?Q?PrbxfPXSyE44ISM9YDO27Fc//gxQSTFM5njki0d1ObhM7tjecw14vBbN00xH?=
 =?us-ascii?Q?wPjDUQOgPmQWd7N0jft/50GTqUcUUP9rrRl+ym1lOXgfmiOYYQgEsdATpYfR?=
 =?us-ascii?Q?TKgCw2Emo/9iAHlLSB2kJjYAcJVJcPMbB99GNCzZDLB7/gix2m9BOE1b3RIV?=
 =?us-ascii?Q?LpzwuBIt1ffw5ngU5oCzS+49nd03spUJM/Il2we6Jlq1+2hP0mxLGShXt1Ny?=
 =?us-ascii?Q?wc7X1Ts1qndUtiCU3BcTfp3brnS2zG9byG45NTL+4zyKy26eVj7OPz6Hx/ek?=
 =?us-ascii?Q?ESM6BESTMXc/mymhzv41+R6ywMFcvLnp9JuNCmq7vIoX515hDUeDKgPJ9ZNv?=
 =?us-ascii?Q?fMm6tsMDyia/OyZdShQuDJmxC8NSyOt7KjRpNgHRNu6i1T1YPUefo3YLSAuQ?=
 =?us-ascii?Q?FB0f7VnC/o6HmyApuG1/yR4Y6Am6qHBOTfKxux/hxy/rXFdr+skxEwN4Vbgb?=
 =?us-ascii?Q?JovsQcrVOzlCKWoTgOZJpnjH1We7psdmpI+eCwS1sYfdpvM5nG4/xJUaSS7j?=
 =?us-ascii?Q?geB2ZxOvQsu5fsDdJtWX8YxAGOyD30ifSxT2cJyCvRIpGSVZ9WFLq8239TrI?=
 =?us-ascii?Q?QR7wBuiMvopo456enUnnxHvAXkGIzIkReBEK/yuVcUTUjWDQcDthcy/KtZr6?=
 =?us-ascii?Q?rKRx4/4Xh1p+//ELczfaHZJttzsPxZpv3r5vbSTC8PVtKFgNWnvKXWk9jcbt?=
 =?us-ascii?Q?W0jAspK5Jnf3Jlax0qhuj6qa3Es7OcsbLCLaLXwZX76cfIl5q5In/QG7G8lG?=
 =?us-ascii?Q?TXRLS3IiZ3RYIVwBgUbN/SUqLFIOcEzfA807/9VMojusxguSAmynwkSgee5O?=
 =?us-ascii?Q?uMnG3h7YdYf8lmfaIcd4KfQTb4Ad+JArTAbJUfFZvR8VHBCIcsKIwaCa6mK5?=
 =?us-ascii?Q?5feSBkxtfrNPqyFijT2UQILNMIiYpwT37Dc7q3vYitp80fI+cJGLxGTIn9GZ?=
 =?us-ascii?Q?shZGgkdyPlPbYUu0FODKXVxwI8rmjqXAmRHd66JkZk20LQUCFPf+tm0XwgcT?=
 =?us-ascii?Q?aLOB5zoRd0gOJJyhWZGw0fhseiUPrg3xkPHPWAu9F7pTVhntSQmcPhhuphJG?=
 =?us-ascii?Q?LeruvxcP28PLV4d/Xq1eIWwKuI++TAl2BMdoEFGJZMZE8gSKzcDyZzED03Ow?=
 =?us-ascii?Q?GFwv0AxECeLyEH/mHKcRS9mi1uyD/RmOuCc74x5h4fFOAXIZ3WLlzMGDtSUb?=
 =?us-ascii?Q?2yjTGHH++zMNyN7Lg2OwEF20mEl1XUoxxnqWibwRe0nkbRTj4C53SrrRPBKa?=
 =?us-ascii?Q?PG9Km/kPMoYbKX6KvEAe7NwXwH5vES8xrhJqOUH6DMgMXLDnKRFDffU5lzkb?=
 =?us-ascii?Q?ORU0gUSQszkwIkaTAzc7wo6cKfHZ83kPvIFzVwQ/vrd+vOjAQtG/LhxfXdqR?=
 =?us-ascii?Q?LsK43EYMr6A0slhxUOleE9HHCPbQPj8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OHUl0LUPIofAaZsfuK2gwO4X8GnlIarLiVvf+7jpuPse5h1V1cxOWhZIxzAeIwtnAFL5fYTO6n+94XuPYKMxcsQ448q8PfOrJUMJkXiBKHzcVx0JJdXZcK/KiHp93zeHjtIgTq92DFvx0OnVagxZAmXSN6SSkCCRLhCbD30g2B3naSiKn5QjSP6Ci4wxR1d7LAiYz1q+f50ATQ6sUPPLBFjEqmbO1Kr0l0AVwUGhFScbLVhJz1NfhzIqPKilrMp0PasTbnknwFqQvcVvykfu3Zh5VPC1buACRQ9ylgnwIik44NdHpSHRVvH+GqFJL4EMJ7GMqK0OKT/OpUPaHPxEJg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a934e9-c961-4112-fd21-08de8b4207f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 14:14:44.4909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HpHYQKmJ28sbXpAN3mdOjnMwErU7/AKKgLuaNcoA136dNBhQotZj2xu+DMhKQ4ObvjpdxQXq9AgdktGiDA0CHX1fuag0gzkdI457Cl9RoOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7921
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272087-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C2E93336BAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Friday, March 20, 2026 7:05 PM
> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org; Wieczerzycka,
> Katarzyna <katarzyna.wieczerzycka@intel.com>
> Subject: Re: [PATCH] ice: add missing reset of the mac header
>=20
> On Fri, Mar 20, 2026 at 06:05:18AM +0100, Aleksandr Loktionov wrote:
> > From: Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
> >
> > By default skb->mac_header is not set, so reset prevents access to
> an
> > invalid pointer.
> >
> > Call skb_reset_mac_header() before accessing the mac header from
> skb.
> >
> > Signed-off-by: Katarzyna Wieczerzycka
> > <katarzyna.wieczerzycka@intel.com>
> > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>=20
> Hi Katarzyna and Aleksandr,
>=20
> I am curious:
>=20
> Is this a bug? If so then it should probably have a fixes tag and a
> bit more of a description around how this can happen.
>=20
> If it is not a bug, then is this defensive? And if so, is it really
> necessary?
>=20
> ...


Withdrawing this patch. The bug justification and repro are not
strong enough to meet the bar for upstream. Will drop for now.

With the best regards
Alex

