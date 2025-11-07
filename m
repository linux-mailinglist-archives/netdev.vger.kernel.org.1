Return-Path: <netdev+bounces-236720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D431BC3F645
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 11:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B13184EBAD6
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 10:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9006D303C8B;
	Fri,  7 Nov 2025 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kMIf1iyq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BFC305067
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510832; cv=fail; b=hfvwkEKP51YWoEX6atBHDtg/WeC/2dAh6XWFOgj9/liRvkvV7Oz3Oh6Ir6ViQpFrISaJKiR8my3KkcjfLGVv8GQYFIVQZnsFP6QOKgfOLArO3XHYqJaEvU4wJ4qhSPQup0Dvnyf+z8Y+kYzcUc+2qcquIs9SHmdZbrnkmUhOlXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510832; c=relaxed/simple;
	bh=lYzs5AS1LPI3PJEe8QUFjD91a1cVptMRQuxQBOk+41c=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K/zrTu8cano3oepL1peSr0gPDgGt++QVj2NwLyz06jCJ24AKdVi8eS/z5f6MajoJPUbS6psIR3+ojgGYCNglrAQSfqUQPVANDcDCHkptENi2Mpimy6Xi28Ntd7BHWFn5qrGIAXOKVofzXOyggvPoIKrk9MMKC82/CvrsZ10zNHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kMIf1iyq; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762510831; x=1794046831;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=lYzs5AS1LPI3PJEe8QUFjD91a1cVptMRQuxQBOk+41c=;
  b=kMIf1iyqNAPBCz4RT6mXSthhn72BcRf2aXym+W13rPM1E3hi6GX48MED
   cop86bsblmpNGeiL5g1e2wH8C4Vh2YhTFlZqGqlwRU482Mmv7eQuX8l2+
   Ei+9wa9sb37srlYP/MOmfuU/z1DBNrp94cJ06HLc6jn4YQQWieo8QPjW2
   ZtniIdsnPiwTfevs4lYTvHBwNACK/8EVJG8+XzqMWbcngJG882ctvAOi8
   5R+NEYTo4VLOOU8r7C//2sWtJNFsXZEwMjrF951P0/OyK2jioRMmOH/Fu
   uBo6OK4x+CtVnlLlURHoyK8ORELZCiLXRVwYxS4pQtP7dq6XsqH/VoaCc
   Q==;
X-CSE-ConnectionGUID: dSynDmDaStqJh1HKb78KuA==
X-CSE-MsgGUID: sCt+W20AQj2LP+DYZKhjTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="90129771"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="90129771"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 02:20:30 -0800
X-CSE-ConnectionGUID: xHNgpHecTsyP67yGnfYakQ==
X-CSE-MsgGUID: VPUW2HodSuujvnr0j3wgxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="187848245"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 02:20:30 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 02:20:29 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 7 Nov 2025 02:20:29 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.13) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 02:20:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMX989mqpCybKKcdlgo0SaPDN2S2ZVoNMNBrPnNQ9P4igZYgoZGajVzzArcgUgwWNi9t52OIK6UOzklxnLOVxuHRXIUM6IPmIH1fevXuIcOZn5aDbJWA2Mti0lyUIdlPCstyWBwgbb1Rhv2DpxWGlBmxvQseP5tPHD+4rKlS/hf4BfixTPjL1cG36d8E/Hu4/MYXrnVex9EjP+qG6CyjgCTrbWPngXAuOcOhbuZ6NoS9JvVOvgFX+ddfyOwPvKBuWnqVADUrVPM1clpP8kxrLCi9ij80WCyUMIFMmiWYlETLco1ecXYm3y8ELqpmE2gC5cc1NYRCHSBaAwnH8KwrbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYzs5AS1LPI3PJEe8QUFjD91a1cVptMRQuxQBOk+41c=;
 b=BkQKV3D4ugTscz79Y7U85Onwm77YHK2TQoWOVCpZqv75jo7tqN2zSP40ZKXUZIsSKXzRtrjIRzusVwsP9VNFUvVgt4ry7AVsVRYYfpJOKLwR5ZGOr8FD1jE1tez6Cx8RuvNrrPlr98Dqh5JrfwPtGJ978z4i93Ae4fRzNIzUtlkpkLT1G0SP1dOsXZMvL4leitTLYjsFUk/0DvkOLlQANk2FJHuolFfZQoiJgQx0efGKwYmqVcbUgzv9id8WicaLjh17Uu3JgyBcMEeJFDho5NvpZpfWkt4qyRjAdIglWQ+52MT/ZnDtDXQO2rh4F9YpFV0DPQDREExwTMyGDmIa4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by DS0PR11MB8763.namprd11.prod.outlook.com (2603:10b6:8:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Fri, 7 Nov
 2025 10:20:22 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 10:20:22 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next] ixgbe: avoid redundant call to
 ixgbe_non_sfp_link_config()
Thread-Topic: [Intel-wired-lan] [PATCH net-next] ixgbe: avoid redundant call
 to ixgbe_non_sfp_link_config()
Thread-Index: AQHcLYpHboZbgWrCmE6fnsV5lSjWDLTnEO0A
Date: Fri, 7 Nov 2025 10:20:22 +0000
Message-ID: <IA1PR11MB6241C4FF37EC08A94577F1188BC3A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250924193403.360122-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250924193403.360122-1-alok.a.tiwari@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|DS0PR11MB8763:EE_
x-ms-office365-filtering-correlation-id: c3c5503c-7bb2-4b5b-4a8e-08de1de7427b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?uo2TJmxasxePCXo26jw15iiamXdTXgbK980PAxd5scW31NKR6Ef7TDg8tJWO?=
 =?us-ascii?Q?sC3YohGndrcPYdlAtMO+E0KFo7QB8yNXIXe1U683QmLtDKiRN1Wr0y6/b7ef?=
 =?us-ascii?Q?c2Cf4ExQZ8GnC5pa7PX08eUgrU7JQdb1kkYAhMlhA1CyBdvh21+Ear6z7Fs5?=
 =?us-ascii?Q?DLp94hqDpX4Q+4GbCmOSPcoW3guqrARRyw83WAFUPwA7x6ciiD1tCN5/DZti?=
 =?us-ascii?Q?ImQ6SLDjeZsOGJN3MQNrz3iDGANEWJ2hQVf60q9HtN55dZr2/kWtCsB75nhS?=
 =?us-ascii?Q?mFps1H+s4SqFADrgGByzwvcGuybJtJvKMZdg8DzXum01wgX3TMvsKb6zxg5i?=
 =?us-ascii?Q?koi29VcxTgI2SnV06/7BMPcJH2wphImQMOoOu6YpL/HEm7UaKcnlaYqxvlnI?=
 =?us-ascii?Q?90/pTErIz2WKXPKWqjhTpvVHekm7qQ0ASlzzQvuTsUH1cDF9dgIxgAJhmDdS?=
 =?us-ascii?Q?xGOKWxbWZjK/sxDbj1Wv1oncq5KmpYM4GCEI9ngX3Qhl/+3VrEkX4rFMg7WM?=
 =?us-ascii?Q?G4OGtpMd1L0My0FrDkCYdW8czBwpIC1cZzYOYyS/v6IcZvZNPNYmbwH4LJEa?=
 =?us-ascii?Q?VfnTDxSbivWL3HyjtLH/EUZ/4guIHLOcErszvLTuh1TV5CCEbQGxZI8YGKPs?=
 =?us-ascii?Q?7RpybxYqux3YuycFKJEQCbkjdAtdy3EoF2C5WvVaL9S5qWWmXRE14vWQU1ec?=
 =?us-ascii?Q?hbTcepvxmbMmmrxfx9ocAqusGu1vBsXLQE7tzY0xsyePE3SyDfT9qdmMW2p0?=
 =?us-ascii?Q?72fA8LnoFAhwFI9pGFrUStG/gcAVLjr8RklU0LwCZY5lmvHznsxFRayUbGfA?=
 =?us-ascii?Q?wyLl+C600hTMVnczaCwmEODtPQ495lMHTwvGClgq1OGZsqcRGCQciQ1yZJ9k?=
 =?us-ascii?Q?ww5aE457hAbEdyBwJmb4TBuvXlREbIFl95JditJWk0DWSbRtQr3VehdrXvsn?=
 =?us-ascii?Q?1hpryHaAU+m/rxgfZ+l+2MWm33VQbAg4Lfl+CzMIxA2kSrgJoVJsB4bKchbj?=
 =?us-ascii?Q?CrnVURf6RbuYqpg34mfGYMJp0C0MwxN4wE423yuu7SqXtQRCb4AqT/Exkcd0?=
 =?us-ascii?Q?i6lBrMDgbBdnsVjLWScgEDYOfSeoVg1NPH71MGFc2LlDrv8rjQFpx4FOsYTH?=
 =?us-ascii?Q?v7CIBHZw5ieXoCQeLuOt8Q9ZSUg9pEuP1fzWq/630Sin6zhZK8a0b6h3KJFQ?=
 =?us-ascii?Q?RP5ULGFMLhBKrJSZPBqd99fuaWIDXSOLzFBOiZQmtTgJuMHLp3nf5YZbKJ51?=
 =?us-ascii?Q?fsfERcQygSCUNsd0GV+NHroqXtWVbQR09TBIb8FTJeVLk/0y48qH+M8ymnC2?=
 =?us-ascii?Q?T7xm/FIxoamtLSHp8MN6ypA5yBtKMuUyp+xSYOFWjNKkzngd2RDshjK0Qxv0?=
 =?us-ascii?Q?XzHj4xLKMCdiLkvAly4sFMB8D/XwAwkLtxc+DK39zKr3G+f1aGcFq3AeO9gs?=
 =?us-ascii?Q?R9MkZGH27KvZwzL4JXGYylrADZ3dYBsNW1JCNxAAjUu0m6ZR8WIl3vS/O3g8?=
 =?us-ascii?Q?GBJY1PakeVFKwsp6Kr+bmYZIEUCX49W4dwELag6bqHLttFuQ4IVwZT/psg?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vdmJKsx+i7Jf4vhZsPP+eNFDdaE+xH3x6n29DtT0BZUoKxWWz/jK3/PX99Po?=
 =?us-ascii?Q?uoaJqzdY7SLY3QMA4dFNi4+5cPWzqg2IZ/4veVZzxk2xzPT/cnRTUNE399OK?=
 =?us-ascii?Q?fGcaghqhiqNhjFJsrs7qzqrWISBI39Xnp1WPdESlOYIJIzVIMptxg9hgpLxS?=
 =?us-ascii?Q?yPYnzhLqU57i3ho3ARdXuw0acco8mKnQU/eDJkI5U91k2F0TntameDTTxJuQ?=
 =?us-ascii?Q?c7z0Cs52hj36sQcMuNwUmCmdg3ndept9GJfwnhJ6HmBODobiNEeiVFliHsEQ?=
 =?us-ascii?Q?7YiDQPYc1b0e/armFk7DzHvKmCxKZ9nIRpECOnaAeB8CiBg9pVhVg1Q4ihk3?=
 =?us-ascii?Q?n1Ydhpn+fzg0VLY8Seb3n1AAZW2V12CQevdmv9Ujh/QuP08XRB5pTOp9SC8P?=
 =?us-ascii?Q?ep9p95lMVlN57GNmgZzSk9L+r3OgX5xzL6wyARqM9Ye8170q3zihUvdGP0Gy?=
 =?us-ascii?Q?6IpBUpY1/NUXLRG0YpLpJ/HQRFTzs60O3ZlDfbnfYgRNCxS6g2vSUmU2isJl?=
 =?us-ascii?Q?YY9cgrf6+nYUuvf8UlwYR4bj3//BYEJgGCbsCgGFcu4YGN6X4rrGaBwi/2Z0?=
 =?us-ascii?Q?PI5sjDA9oZbh2skmjDYGBqFTauH27wiv19KyYunUJULnMpWvQFvlJ0LMoyu6?=
 =?us-ascii?Q?hhNOFe5KShKiLK5S1BKJG/twXiQdwkMP8ORmGRrKCRHwadOidIbesBuYx631?=
 =?us-ascii?Q?ZCZtA1Z0h97iisJ5j25A9wsnGbNclQwlt1zyXVhyh9rRNI4HWxRW4Z57DKPK?=
 =?us-ascii?Q?Vjiy29HfXXl/gAUldAw+ZpTFizpYsER4xiuAAnlxK6V8ezVesW9MfDRbXouZ?=
 =?us-ascii?Q?7mnOvzQC6RsQRBfWsVjqrLLN0CShjP8/PuzVwxQdTiISXdUsKerbAkBDYGij?=
 =?us-ascii?Q?zObwcpsHqKMMZF5N7eYqj105tM3B/08IF+ywm8bVoMA88jyh1mFMifU+6txd?=
 =?us-ascii?Q?PrVhP7J0qREg0ckzQoLvcHcd7XrVr4lmBREPb+BTWyAoLyaXl/MB+u64TZrp?=
 =?us-ascii?Q?A2MCidv/5skT75eONnwkTiZ71R8IeVHLHJUmC2qSoap9FOqcRxrzmkBUGufR?=
 =?us-ascii?Q?nKWNQXD+52pF8AFLz6hP61q0iWzs6EUxg/eDn7HrCSfZ+6yd2gc+9Y2ieXhU?=
 =?us-ascii?Q?EEVANIzxftAVPiuLj40urxm8bYuadDUxYALnQAq02y3IMzq8q7SMT1OA0Oc/?=
 =?us-ascii?Q?hSJn4gWYeZW0VFf5B34uBezms/+hAQN8ILgscRzDgE0WHFflJPwYOajQn5EP?=
 =?us-ascii?Q?VrxQY95TDo9sBlqqkJkut6ColNZWBp/sj2qo0B6kMyCpxYNUucPaoY7jDKki?=
 =?us-ascii?Q?tGpROtrfBwwCVODrUQfuXPpYDG/H1M4xbIKlBXqZsp2JkKxweIUWmm9DKpk4?=
 =?us-ascii?Q?ka7LJeFQhlKXenU9pU2Cr86uDNhLhi7R1scoJwidkhM7rW+o6fc0jlRERuoJ?=
 =?us-ascii?Q?+kp9t6sxrHD4WRQXVVwO5sfYvb3xFHIn3+JK92x9lBVcm/K30yALfwouIljp?=
 =?us-ascii?Q?fIAQHsAnMs+d27Chi6L921Yo5i2QgKFld+Jsf7Z3KkIRM5je2LpPGvHaOrws?=
 =?us-ascii?Q?eRSEN6BJMmT+zSgDLtXmyaYaoEdZ+CFGqoVcCCXY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c5503c-7bb2-4b5b-4a8e-08de1de7427b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 10:20:22.2690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /MDPt3iJ/fIzMlks9TL8uT+UiTDGK4WAS2EbLLT6/Hdzbgs2bZHNemgR5MmBTYBAjQF7wZ9o+ZnVidCtpEgrtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8763
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
lok Tiwari
> Sent: 25 September 2025 01:04
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; davem@davemloft.net; =
edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; horms@kernel.org; =
netdev@vger.kernel.org; intel-wired-lan@lists.osuosl.org
> Cc: alok.a.tiwari@oracle.com
> Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: avoid redundant call t=
o ixgbe_non_sfp_link_config()
>
> ixgbe_non_sfp_link_config() is called twice in ixgbe_open() once to assig=
n its return value to err and again in the conditional check. This patch us=
es the stored err value instead of calling the function a second time. This=
 avoids redundant work and ensures consistent error reporting.
>
> Also fix a small typo in the ixgbe_remove() comment:
> "The could be caused" -> "This could be caused".
>
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

