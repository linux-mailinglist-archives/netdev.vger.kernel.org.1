Return-Path: <netdev+bounces-294296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 39UPFusIH2qxdwAAu9opvQ
	(envelope-from <netdev+bounces-294296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 18:46:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF3D63059A
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 18:46:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="beN/i/b/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294296-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294296-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82A70304ADD2
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 16:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A92371CE2;
	Tue,  2 Jun 2026 16:39:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF3437189C
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 16:39:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418344; cv=fail; b=jqkA0YEeFPl8A7aj/Q5+y1Hq0I8iZmnwpfLr2x6gXyyWRK7HaeVgtpUI7HXkDj1hsrKawN4cj4bKrLghHm0cibNxxZV29QDnkyue34XXdvszNQ3B9zzKa6CWjWTdROIMK9Op6diMhDtG+gzUC3VDEglXyXeTxdhN9enR0UmUtt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418344; c=relaxed/simple;
	bh=9vPdOw8dF6KX678CA4Mt4NGIf6tZR+qE8iDT01DaXXQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j46WpvlWBDqTmrnPaFFr6RMK+NELBvMF6mIwk7lSh7yC/Xm6Ky6S5HUAg01x44DFuVEbUs70AcrPxxNlq3jUo9MsCDn3H4whxCXc+KVSg1vdx+6IHRYhY84am6kWSQFh3iXh8zT+C2SfBWyTv6BQCepqTdZQ9khLwepGxV6UBIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=beN/i/b/; arc=fail smtp.client-ip=192.198.163.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780418343; x=1811954343;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9vPdOw8dF6KX678CA4Mt4NGIf6tZR+qE8iDT01DaXXQ=;
  b=beN/i/b/R299DFTYdJblpNFLEy5GqpK7dBlFVQkTcIjd1bDOJRnLXM9x
   I6XgSbHH/ZkLcYyC+4FAkGwkYlCks2ZXmoIkARVfPwfkAJLROIOZhCFkG
   edyWposWDtrSLtCFq/Jz3lEoZaYKSqnQpAdLT+ZFfE5NrZ6qtWpcOnLsQ
   wP3JZhyZp5/raaCqJ6pPOk+BGy7jIvJHe/Ol54PpJQSRvblqiz02oG82E
   PjbSOSSlQ6wF9uGTQqX20O1NDv91tkd7wLYICEElVjcHMXMwKTsqjrmp4
   PRiLM+rHW8MkEVWYqhsdymebR4+aKvKEqINQ8k4PjIEj5YmK9XQsoKqSD
   A==;
X-CSE-ConnectionGUID: M9+Oi9xCSGCw4Dg5MH1JYw==
X-CSE-MsgGUID: tkkekh/cSuOLiizFJ9Bl7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81241181"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81241181"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 09:39:02 -0700
X-CSE-ConnectionGUID: 71+qJ95lTWy5pNNSe4IuBQ==
X-CSE-MsgGUID: +7kdAJ9CQFG1Ma2MhTGDPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="282071161"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 09:39:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 09:39:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 09:39:01 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 09:39:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMpowz8m+MNa+d/yHPxC/4TLfnTODNmioaECgE6mVM2LwIVt/MVYay/r2OIMGTu3qhWb+qdhhLMuL+2AomPy0/sLgQgxic60gr2g5pNredj8Ocj72SHPhWjKltQdZJARWRnmF6KKHs6W/PsY/C3s0hZOzoecDamYhwLN+3nbpFcnru+F61c70ZDq7X+66X78BbIAXukVFE6uj1ctnf5aEditOacRoTczP2q9DHrsB1mGyGY972+AVEWQisNSBXVSQZPSC5SVVWhXJdWmDzwc8kcWaSUavH6PoAUF0cbmJRDscfEVsvX2d2pafG4ZNlVaMSqjFBp1V8otIfAF/oi0iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isdMR8MDJ0Rlk2OYzhH3DSz3HVDjRRYCxqZW02qSa+o=;
 b=hIirGxuhjLONCFDsKrY13VOzFh98YAgypB1tYSPLwtDjFQQuQ3Q9rPYuOTvE3DT8op9zSzkR6cpHef/ihn9BxHsnFUlR1N76lPHG2JCrWb8KTbu7O0L/wYVXz1jwAyQv7UDMDSMHHJVXuBM18S05XW0R8vCZPpFoGzpsoNkyrK4M6JxwZSaRhg62ubTNgHO7vHZVxD0srSpPFo5ac9VcWFIMrJ29jYcIJ5tM6l8xwAcfFrY4rCWuYUBuMnRJjiLzViXaRZv8z2TT2xW0iTkxhFJ2XiLiDIi7tkicK2SrDrIWpq5GrZ7rkVx5cSjCpY2CoZ/38KhQR8xo3iP1g5IX3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by SA3PR11MB8001.namprd11.prod.outlook.com (2603:10b6:806:2f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 16:38:53 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%5]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 16:38:53 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Greenwalt, Paul"
	<paul.greenwalt@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH net] ice: fix PTP Call Trace during PTP
 release
Thread-Topic: [Intel-wired-lan] [PATCH net] ice: fix PTP Call Trace during PTP
 release
Thread-Index: AQHcvbqpBkx15LDXxkKLSVl3kahU5bYg0vkQ
Date: Tue, 2 Jun 2026 16:38:52 +0000
Message-ID: <IA1PR11MB62411266AAAB73E2C6AF3EF78B122@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
 <20260327072332.130320-3-aleksandr.loktionov@intel.com>
In-Reply-To: <20260327072332.130320-3-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|SA3PR11MB8001:EE_
x-ms-office365-filtering-correlation-id: 0e6f0bee-ead1-4185-442e-08dec0c56e9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|22082099003|18002099003|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info: f/ypXukI1jZh8r3HbRHIpdAQpigC2KRdPJctrdxuCO1E7dW7aJCxSZTmKLY8sYMRQ1Ty9qGkHRzlQwUDeBjT/r6FOxsPB3DGgXxGJwTmQKfTcEOsAxD9jmsbT+dAsopT53mfRXUr0udNOg7Pfi6FUhAdp8flgJp0AoDyOVge2ILrqrphdaVMgHtFpDBs/iYrZncNjK6VTTlBZDsv/4FFwlcK3/MesB5eBhjhwpuyKBa1Zi0J8yWFEOZ/MJ97n3Sm92AkubKgopFXV8B4I/RP6CKFeOK5OskjP0hJ2WUV+6vBLeta/tOngHWhcBthdITKh24bnt/mvaxgaCax87Rev0OszHfYDdeoP9rnnEwLSBJ9jq2vCvKQv2Q2X5D7qARzE1yW91Bc2li2JQPlAultg8BozYRBZc5+FP1PxArk9ujoiy4rSBoExeLGFGg3doVtMtp4B7RTGHTUtNPIdY7L/YKSeLtPyqsBnPLXOto2pQMr2SViuNauPfWVdFqz00iGSIeccrP3yR45xbWNE6qltyit/K4jypT4M7UjzZ+Iu3m3J2wXYDj62sxRFaNk/YOp5U1hIcmbG2ygMDet+lwna3ACcMOzBHJ9Ca70pWSJxjBhubo2gSyN6DuHcv/LK9HkyHFn//kd4OBLNkqtUK5ZqKQXdTsR+iIjVVpyebwzgQjB83hVIn6XmTm8gFRLjzu37Lqp1oRduug1ErBSM5K8qDomAWymyBgCu+yeaKaBccIHGg7HI0zYXkbSvRJXRB/D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ubKgHYpUA/+ZjHK2R+mDEQwHOvYyBNdv++BZtJmZZ1bPJilrRaOoxQagqpAK?=
 =?us-ascii?Q?2wUtiVg31OPWy28zDw9okqnR5ISsxpf7x3VK3gdy1YWAHnCMBcwYPLuVsUW8?=
 =?us-ascii?Q?zZE9UEHOWiZpF/6h8j5SGPxZj6Aacs3ql9UePlV2cDxJmyjX9Vdnx8bD4Jwr?=
 =?us-ascii?Q?94/QiC5T+9/nh9o120NbtkUniN5gOSSaCzTIcbfsVH4Tov/0YriH1zyObmmN?=
 =?us-ascii?Q?cGWuWd1k3GC6ECg0VLnvRDh/yJal4bMibw3wgg6hZ6rsCqg6QR9HSx+hCYBL?=
 =?us-ascii?Q?I103vUYrec0pRlipVIqeCWpXvW1eqHmEc1kc6dAahTtYF4HqQGZyzT+qy/IF?=
 =?us-ascii?Q?ZeZK3jO+9Xxk0sr4ymOb4HHINtoFu7pI4USvAKVTWA7rC3pN3ZGFXDlFUAx8?=
 =?us-ascii?Q?vogSCF0XoiNbQeRuthE9OaaHHCWS9GYepJRGH1AKQTpyingbMGtN/De7PsFZ?=
 =?us-ascii?Q?Gr78BljoYMvphAyFq6tB6s9z4WGGRZtThhCI1dIr3RfUMI3c8R+T7LZm8V1a?=
 =?us-ascii?Q?0z2bHUedT0ilozrKUxh5tnvPDCKmr5BfjiSRIwn/39idivrwvs6sQ3VOujWV?=
 =?us-ascii?Q?QYizh0ITD+EMls6HVcPe/ad0vjfiLVE5WNa209ayTQuAH1Sf5c26oRm1ogfS?=
 =?us-ascii?Q?HCaYwB/jwoz0jNhZ3GqC8MhrVjTzGoK8DsEDqfPNkcRLyaX5qfTlsx3Enx/k?=
 =?us-ascii?Q?EfnDLEKGysn+h4jCNPiHoALoAk4V87nl2xnppk8gKXmMr//0M4UwfggjOt7n?=
 =?us-ascii?Q?gs4jGTgzQnRmVCDjSR78nKjdGCBBbU5J2tiJUb2ezSG7IG2D+R+YX7LmugE6?=
 =?us-ascii?Q?1hYrvR2PfITd4OW7YaRF09ST0f8u38p9xiaxZ4BIr7qSYd87MKMyVPeCf/Xl?=
 =?us-ascii?Q?eTo98u5bCzHZmQPH+yXxxjTeX5SV+rB+KO6Z6X40Jnl7LMwzSzMwFW7q797X?=
 =?us-ascii?Q?TrpNF8Ef83tb9sMGWJl3VhOxHUUv7XeTc4+gTg070Ej9kyixYav9t262Gh2M?=
 =?us-ascii?Q?bu3PDTlf6DXsoYhNvgvIzyNfEQZKlCclFaQQUSfs37YT+aox5FIgfpSc974m?=
 =?us-ascii?Q?+A9YQMZtlZw1aIxmipXMvG5N1SA3ohVgQwk+exSSUn84ak9qYXowCbQx06K2?=
 =?us-ascii?Q?7lk+wqpvqnkp9GsyF7rIJG9/8m3nDRZG7qNx88iHHb1nTP24nDavPl3ne29M?=
 =?us-ascii?Q?+AdgKhuSZfCAA9SLYySv6s9gWxNBRaGEVsANhLb7arhXgrpkNlUdKpEW5C4O?=
 =?us-ascii?Q?KqUiuTEfvwONfSMRTVFHGgwhLioikfHe8D0Ql2sGA8w/zxJYXHhsdNi8YdEx?=
 =?us-ascii?Q?aLA5DQA0jM30ZM11iBM5r/YVO+jq55bua8Fr34kmYfFf1vVk3iFsbxkFWMLu?=
 =?us-ascii?Q?+sB3ScvQP7JDkZzdT3gWGeNBpZWbxcMQwBx6lcbl/Y3KpVjwSZs4ojIfO+2x?=
 =?us-ascii?Q?eOi/KWsqQDWn4mvk4E4OiMsqWIu1pVDWM+X0WnethzzuF6ewUNbDRkGh5qZ8?=
 =?us-ascii?Q?fGMHJNRh/EQNsCUvEi+M+PGHsMbksdhUpaMjHRJMS6RpQpYByiXP84ZlyJ1I?=
 =?us-ascii?Q?CfRmYVBfqy8yTn2qiO7AQmdRuYyZUuWi2vUoWLGSFhfVIigouOGUqeLa7uHW?=
 =?us-ascii?Q?bBAJz+5D5YdKYE2HFUiUwnhNSufXlyZPceEu2TMR40/c4DcKNv52+Gknr5K4?=
 =?us-ascii?Q?nS7iLK0UJxntcAETcTREj/9Xs89WecP/cdoLkjo4T5llgb8N?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KYZPW/1JIzMPdXCvkxmYolLOrGol/lGPYxmzYT0Sdn45HGrdh5UJvZPApicMn0mSyEks1mRecQ4eh7WGPATv4IP7uEth5tLbpv1hPN3RyIprD2DVSp0FBXYYN1qv/TVqgIPWgzeu8xTGBNWNk4TcDhxpJxnQsq0I/NNAAXRPDLTx1vzjnQzbVhIGmwpghito/lToEB1dkhslOg+GQdR8XRC2Wvv/yrgeb5ZWic+KqWRMklRKreDo36qU+oAIcVgDifVeT1m3zVdCDl9iUQeLAfqc6bsICSA4JF6Qw1vsETP1uNIO/3YR4YQgWYM6TK6Dk3XLikbkLBA1Y+OdL8AXrA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6f0bee-ead1-4185-442e-08dec0c56e9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 16:38:52.9090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RPY0koOaQVj36vgLG+EYpIGVvpMJfX1GWkJJTH2/mOZ7pzwlwvp7lDZ4wQQ6Wm9lKMSxfZ1Lm3Vm6qx9ov4rRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8001
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294296-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aleksandr.loktionov@intel.com,m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,m:paul.greenwalt@intel.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:from_mime,intel.com:email,vger.kernel.org:from_smtp,osuosl.org:email,IA1PR11MB6241.namprd11.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCF3D63059A

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
leksandr Loktionov
> Sent: 27 March 2026 12:53
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org; Greenwalt, Paul <paul.greenwalt@intel.com>
> Subject: [Intel-wired-lan] [PATCH net] ice: fix PTP Call Trace during PTP=
 release
>
> From: Paul Greenwalt <paul.greenwalt@intel.com>
>
> If a PF reset occurs when the PTP state is ICE_PTP_UNINIT, then
> ice_ptp_rebuild() will update the state to ICE_PTP_ERROR. This will resul=
t in the following PTP release call trace during driver unload:
>
>    kernel BUG at lib/list_debug.c:52!
>    ice_ptp_release+0x332/0x3c0 [ice]
>    ice_deinit_features.part.0+0x10e/0x120 [ice]
>    ice_remove+0x100/0x220 [ice]
>
> This was observed when passing PF1 through to a VM. ice_ptp_init() fails =
because ctrl_pf is NULL and sets the state to ICE_PTP_UNINIT.
>
> Fix by detecting the ICE_PTP_UNINIT state in ice_ptp_rebuild() and return=
ing without error, preventing the invalid state transition to ICE_PTP_ERROR=
. The only valid path to ICE_PTP_ERROR is from ICE_PTP_RESETTING after a fa=
iled rebuild.
>
> Fixes: 8293e4cb2ff5 ("ice: introduce PTP state machine")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>
> drivers/net/ethernet/intel/ice/ice_ptp.c | 5 +++++
> 1 file changed, 5 insertions(+)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

