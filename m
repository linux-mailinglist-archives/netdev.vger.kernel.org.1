Return-Path: <netdev+bounces-188483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 934EDAAD0CF
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 00:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1194C826A
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 22:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5517C7261E;
	Tue,  6 May 2025 22:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b1KgjpS/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2074B1E60
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746569482; cv=fail; b=ZtsOeQMkfzP39TMUeU8LFn4Zsj3hHhho5luwAQqpaoCtdj75RurMpEnYoBrfU9JymDj+6QzdCPj5DXUg3aMDv6HBVcqfXfSbs2xCLNdE6aG2dkX4TRjbWQk0MXwnBovLILcIc3UuxHZRCZNc6PbgNuvb12c8NX5VMYehEKRC448=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746569482; c=relaxed/simple;
	bh=OUtaGpMh1pL836c6qe841har3jW/PODV7+HPDxjWJiE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QNW5XtuoNnh98z3p6QhISkA/pzxD8+sV10ToUlONL5BUpho0Khaq2yI5AY/YEnqMVtmtAmax1E+6vxLRktIqsFYR8oH+1hJ4LcIumF4edSl0nIJAm0tqYJ22zR6QxtvM5LasUGYmuoJ52J25eciqDjoEBGzKx1OCf2hTYKjAKtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1KgjpS/; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746569480; x=1778105480;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OUtaGpMh1pL836c6qe841har3jW/PODV7+HPDxjWJiE=;
  b=b1KgjpS/UG7n7G/0r+COjYuWxUlkd1r0ADamgWH/yJrSllG+KeX8UYld
   1PhK9KgqVlplzZz0EcnxP/gRhGQzQueQh93429WZUV/NcGM29QXkXgPDZ
   OryQhH8yR3+TlosPyauZWd/6K26GrScVCEQ44NrfhDFkZw74krwFtbwZy
   2CDvDGj5tUirNDjQpsJo6FXYnsJTkEqUK6vJFifC2n/FE1HwT/EsWzR9u
   7Iji3K6XFixe2/KqaxgNZ1LZ+Www9O+a1h4dWrUqTc2Xf20pON3Rmtj9s
   aKXn2qu4myOl1/19ak+zHOFKr31w4nVC5e/ThhbvwR7iAjpoQ2uzb/eQq
   A==;
X-CSE-ConnectionGUID: NpA3AcP7SAe9BJiMzV7/BQ==
X-CSE-MsgGUID: bCOMzGlySxCBUJeHAhE46Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="52077002"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="52077002"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 15:11:15 -0700
X-CSE-ConnectionGUID: VSenI/ReSki9JeUDcVeo7A==
X-CSE-MsgGUID: inrJMBcxRguUX0Uqh+aw3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="135465275"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 15:11:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 15:11:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 15:11:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 15:11:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAMc8EDoyBp3KeOuPNgLqDdGyrrbe7xkX8hMYiJTycxvQZblpZ1ojmzILpS0c33MTpTJyuaZgt/L9LOkELF6T2cqCdlJKa3A1Xv7zlJzMMN3Yhimjb0YoPQLL3CBAzVVMyIeHQsBUWl2TI/KbjkTTJlVFD/WxLmMVV62/74z9g6cP1+7YzD+2yWL3p9jHj7WHBo9apIpWQgl8ywqQQZS3RoGUo/wi2ttlq0CCmp8jzCoe+hbRFZDqs2HQblr95E0R8pVTH52egkIOskZXtNzOwRd36+VPAuei9PIrGBz84+BRYozKXP6B6i+7Z4O10Dw6AbzPVM1dj4eHAgpkPesWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJqqcfrDabvkF8JaYvNdYcQTQtSD2dd/NA9n6qxDP9Q=;
 b=fIkeNF18TzOkM2I5p3lQeNhM8kaDI72+J32QIm6jPmcStE/cZQvkwGxsrPdzBfnlHpbsDNhtTen3q4wcv8y+jatW0HvjNPnzua8xDyKAMBbxsRk99nY9VlBbaeE+9ixlx1CRo5rsDCAlyZ8jpPupOFxGB5b3qpdaadN39hNaU4sWLwvkbplFnj7JT4lz705T67CRq549Gk9RkXOx1Ii7oCe/UTtsWdLRCXo9JDzUsW6F5eOaywRjdoeTczF3/+pdScWV1LQaqtTfK77s5nlKsV+J62+Vop/3ycSvK6G/vxXnaepbNu1ZvWkyOjfpROmEKPJouIwwXlcFAkw/mjoWVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by CYXPR11MB8692.namprd11.prod.outlook.com (2603:10b6:930:e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 22:10:39 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 22:10:39 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Linga, Pavan Kumar"
	<pavan.kumar.linga@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] idpf: fix null-ptr-deref in
 idpf_features_check
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] idpf: fix null-ptr-deref in
 idpf_features_check
Thread-Index: AQHbqvsMxqS1HBaagUKUEyc1clMAUrPGUOmQ
Date: Tue, 6 May 2025 22:10:39 +0000
Message-ID: <SJ1PR11MB629726A0C8891B756CF0DFD09B89A@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20250411160035.9155-1-pavan.kumar.linga@intel.com>
In-Reply-To: <20250411160035.9155-1-pavan.kumar.linga@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|CYXPR11MB8692:EE_
x-ms-office365-filtering-correlation-id: 0e5f4619-aed8-4c6d-0558-08dd8cead5c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?C98pguumNoy51i+waUt3H5kwt/PuH7nnBADc/Yg72nrpIlOtq0oBGyDgYFUn?=
 =?us-ascii?Q?dSfXimXXQLTCzzF4+9/sgQVhRGAymXmwlC0CeQbED1q4f2u7UtjKQ4r0NDm9?=
 =?us-ascii?Q?WMfeLVOAbMMUYfnPXHSt7UPRM2guiNGlEqeYmmGJe68NSTZKrNFxFdR15AtM?=
 =?us-ascii?Q?lNux6vnQnO4xl4DcTPkqqccL1RmhdNRdJCIzHQsXkCY3hERDnHNFj1dbIpyk?=
 =?us-ascii?Q?8JCbeMZVzugI7SiNipHuof8bo9ErFq5+L/aEqXVz0u6n2yGkLuUZ7oNuTRjU?=
 =?us-ascii?Q?MJ35ICPFB5TpGfj5kYzIJOGRIihhvt04z2Sp4N5Ehk+dG86TnuqmqsJWW0fH?=
 =?us-ascii?Q?MTsIWzTnjTYDPjleQ9OPEyXueoVQKtknloXtVcGzhs4yqfJ3eFwNMwbdoLF4?=
 =?us-ascii?Q?IxwZ8j/onAUoFLJCEpPNmDB9NzCnPtxVhFd7h0oWYnyUYTxAqL8ln6Htannr?=
 =?us-ascii?Q?VKB7HIUuCV00xT4nBd6Q2x/ERRWzEFUGLGW0Jzrk5Bcp++y6zxGpSvmdrCe4?=
 =?us-ascii?Q?kLtxOWV+4iUIuLLMvY6BJ2CB654Mx57GYpHPVnX9k36L9yFD4Z0KoRSitjc4?=
 =?us-ascii?Q?lZzLxpoX98rRZ8kSFEjUmLGpeRelm846Or4E8aFxWYqyqefArV4b3sucyEw5?=
 =?us-ascii?Q?OnqRPO4uIlFO7skaQaZWTQHE2AdFDwYAIx0TsV/F/XqI8yT5DqhsM27+c6cv?=
 =?us-ascii?Q?9sVNuPXT6KYPRoVi3mC4xnuIzfy/wlSb/2KETasTpLjfZM1JCqLR3tCEKfeD?=
 =?us-ascii?Q?9wEBx1qgDZfg5/ceAI0a9LynrhMNwAs9CeXHOLQVurxbVin+2EFiNmgCCv7h?=
 =?us-ascii?Q?YQPNunx8gY5rSdO/Tr/2vNwbvafrXgYfyckj+fGfm56nU2zYnDv5YimnxJVd?=
 =?us-ascii?Q?JnaIAi1QE7/WCRpQXSEogu8MK0+gJDLpnZmVIWCdDmAJpBxqN7I7CtKIqfSj?=
 =?us-ascii?Q?Vsgx54KUCu7hILg7aoA8ycLQwy6nNkFj7tBezg9LiD8MG8x3bkkzjKS8NioL?=
 =?us-ascii?Q?c4rKDqzuCRlO5uxkSmd2rrjjlBDBJv/OjoXWpOQp+aHiXFhTUSiCgWtoBhgB?=
 =?us-ascii?Q?CD/pETbt74t0MUsZbJfpyBsZ2N1fAY9nEggTs14X5avsiy12NvBdfyON3M4c?=
 =?us-ascii?Q?Gapp8U+E+Mjc0RsygcUjRcI1Gma+dsUuv3qccJgrVHx3aa+5HtE4PB30q0Fh?=
 =?us-ascii?Q?XlROSW92qCebLS23ignay2J91580yPcMajQC4N67Jo0ETAzDvTliOKGa5mmP?=
 =?us-ascii?Q?XgxCjhbEurKmb6fFJYHIJehTIOKf7LXzVi3d6EKIZRa74+m62eFEw3DN5Rnu?=
 =?us-ascii?Q?Jpq67XtvJ3X9tyxJUVNDmp01k7H1wj7BuroTCYgnccnxeiDHPejcelBR3ru6?=
 =?us-ascii?Q?Q7agrqd6vbWFdLuVJ/A2i8sHqdofou/zW9Uncrx4upWvEPPLnGQMa3r87sqQ?=
 =?us-ascii?Q?H2F6y/ki8ZySeVMw5QGXkpxsuq2uJs9xwtj+/QTuqjyB2dj2G6UqqCMpATo6?=
 =?us-ascii?Q?0dVGjWqfKQEgGWk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6IMSEah3PojgApxuyJVUKvVPKc0noh/l/6mJT425fx0zDFTSIs4KGklYBMFL?=
 =?us-ascii?Q?2sjsGonmHN9hSwBT6Z/FAxD5o2RVXoaiOH5l7ZtkVkxt27252dos1zZ7l5P2?=
 =?us-ascii?Q?aANM3Iyzbm6J73PpZ0aOgM0bDjnz3kPFYQd7bLaIh9bAS9SA/65ptEp0vaDM?=
 =?us-ascii?Q?5NAU3P/51QE6CotclvzwYCuEYbrgHyGREv8s5BV0u23AuYq8M1aFlZFGwjc2?=
 =?us-ascii?Q?pye4krnQ88lixRNWvcgXxkBnoN9aOoaCtqsDJPVR51fXtP6lRkUDN2d5gCiN?=
 =?us-ascii?Q?1DL2wBGcKBeYKLVclxIHbNwyPOdHZa6G1y7F21rK0AS5werW2KzQaG43tJGm?=
 =?us-ascii?Q?rD9ZsgnA5nmWrfhXEspkMO7n+/GXANmD8FclZHB+TyNZ0yexaX1ey7xfyUoN?=
 =?us-ascii?Q?NIu3amrRpZqabOhtBGmu2Cck2YD00SnzDN+7aia44FS9Zi5NNir5iI/ac9Oh?=
 =?us-ascii?Q?gfjZRL9gcD7/txcNV5etu8u8B7YBaPM9dsAc7I/0fDGVO4jh1ZjHI33omGgy?=
 =?us-ascii?Q?pegNRtH6vfbTuHwTJaIKt/Kab5nU7qQbBwf9t5+fyWTNQ0YrL/sjFp/QJDeS?=
 =?us-ascii?Q?wtvWudHGXl3qe60VSADpKc/fHW2AuGOVtA2LiXGw4FAJHUVxfd//toevOCr9?=
 =?us-ascii?Q?s+xzr9Nv0J1Rr+jEjTRrbW2+lw+4uN3pfWx/NmKJBTNpzSiW2tkq7g9wP/6C?=
 =?us-ascii?Q?0+DJxd6eP7XRqEigAi5M3G95xxyEjH2B6pAyQT4Nx5agzKCvH9Wj8ZGxA422?=
 =?us-ascii?Q?HzH+1CwnYdQgsJWcz66bqwE154YEohAmUiPapthM6hb2sZ7/Xu4s/joVmfDK?=
 =?us-ascii?Q?jC9m4F/TUDFqf1Ic9wee5mqQYyum63D9GDq1QCrzpaOsZQeaRLIVhCINyWuM?=
 =?us-ascii?Q?+j2OWoASvjPr94SBmJauQAf1fBuRFV6U8F9MOI4QgH5TNGYKHk1Z5bmAg7bp?=
 =?us-ascii?Q?mH/mh0S6YLArwNv6v9L77V52eIM0wtfN3bW7Kgp2I3dPHmOpa46Z2yHjwGVe?=
 =?us-ascii?Q?it19/lX5rxTAOEwmglwjTqRFvtj0Xzy5pzxZateT2qjrzayvrDnaB33WMuPJ?=
 =?us-ascii?Q?S/NvBUO+/Z/noNynDEhXxTIINPe8dwbjmA8i/WhqecuUcaHqnf7Ha0m/Ute7?=
 =?us-ascii?Q?ZdqYRmTynZUQJ9akadcmruGiwN4sJ69e/BAJjB/+V/Gc9oeeUZYRE7an8HFx?=
 =?us-ascii?Q?TD07betCESNqOGPqSvbWwH2Bw5w/p8pofaY5ncE7rB9Rmc4YENynp7oc1UWl?=
 =?us-ascii?Q?Tza5qhldOnutL9CuWhjHlpRljHuL9dFrm6pHtIeqBRsw0UW3W4XeNqg9Mla0?=
 =?us-ascii?Q?KZqRT5Onwx2KbDg+4NrC+u2HKumgszmeh04Vp0ryreXdnJuVb5GLPnxHCxZB?=
 =?us-ascii?Q?3j3cFuOgV/yI1Erel4q9Yf12INvQIg64epeR2Ut3bxVYSz+NJzSOiNxIgK/h?=
 =?us-ascii?Q?SBjJDXrzrrn/UysXHvWfiMnI+MxWAk3og56RZyEGz9DZjR1BNuc29nqBjb46?=
 =?us-ascii?Q?sOdKdjI7VC3SZSSindOw4FajieRvNn5AMuQWT4s/dk4NC8s8bbgc4+gCEXUQ?=
 =?us-ascii?Q?59C0xmLjWHq6d0sDYDqd3s+ncZ66LzvqAsbvskW5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5f4619-aed8-4c6d-0558-08dd8cead5c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 22:10:39.2921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +U0AOLWLLZQdZMv47toKPEqD7AqNkY/Kmx4gyL70pf9odYcRoVLem8zBisYw8vBGnnbSM9K7n8L/Zn97JUR2dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8692
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Pavan Kumar Linga
> Sent: Friday, April 11, 2025 9:01 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Linga, Pavan Kumar
> <pavan.kumar.linga@intel.com>; Chittim, Madhu
> <madhu.chittim@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net] idpf: fix null-ptr-deref in
> idpf_features_check
>=20
> idpf_features_check is used to validate the TX packet. skb header length =
is
> compared with the hardware supported value received from the device
> control plane. The value is stored in the adapter structure and to access=
 it,
> vport pointer is used. During reset all the vports are released and the v=
port
> pointer that the netdev private structure points to is NULL.
>=20
> To avoid null-ptr-deref, store the max header length value in netdev priv=
ate
> structure. This also helps to cache the value and avoid accessing adapter
> pointer in hot path.
>=20
> BUG: kernel NULL pointer dereference, address: 0000000000000068 ...
> RIP: 0010:idpf_features_check+0x6d/0xe0 [idpf] Call Trace:
>  <TASK>
>  ? __die+0x23/0x70
>  ? page_fault_oops+0x154/0x520
>  ? exc_page_fault+0x76/0x190
>  ? asm_exc_page_fault+0x26/0x30
>  ? idpf_features_check+0x6d/0xe0 [idpf]
>  netif_skb_features+0x88/0x310
>  validate_xmit_skb+0x2a/0x2b0
>  validate_xmit_skb_list+0x4c/0x70
>  sch_direct_xmit+0x19d/0x3a0
>  __dev_queue_xmit+0xb74/0xe70
>  ...
>=20
> Fixes: a251eee62133 ("idpf: add SRIOV support and other ndo_ops")
> Reviewed-by: Madhu Chititm <madhu.chittim@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> ---
> 2.43.0

Tested-by: Samuel Salin <Samuel.salin@intel.com>

