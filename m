Return-Path: <netdev+bounces-173819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB8AA5BDC3
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 11:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 506EF7A48AD
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 10:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B91236426;
	Tue, 11 Mar 2025 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k/VXw5L6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834222356A3;
	Tue, 11 Mar 2025 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688679; cv=fail; b=ojtg4ht/E219g8LF6zeDa1NEC93Ct18WO6FbrEX981NZXIkLiHGDrHrKQQuQYt3WSLtJISZ2UQY1IWq5IDGMFom3sPgW+xBAds6ye4pr0hNTPfi/HVt8B4Oy3KMjY69CXE+NGnztmMb5JeRPkDG1PtNIdSdS4rbBW5m3dBytpo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688679; c=relaxed/simple;
	bh=ZxRaocE2LAONj0aSKDOvv5ZmgMbP7et4rfuT8mHaKzA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c7UnXlmT82HITKyChjMQRsDLhi0y4H/eNfI6IpawMoe2Af/XPZnEqw1JobG7jlAsVKEHLclSwrA5iIHDa9s2W630hnUXQTj98ni4dFK8h3F91q+siFdWzfTfPLtOqJRfRw/OvB/t1dPcP+SCJP4IGu+mPI/raMPVH5KF3dGDMmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k/VXw5L6; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741688678; x=1773224678;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZxRaocE2LAONj0aSKDOvv5ZmgMbP7et4rfuT8mHaKzA=;
  b=k/VXw5L6BspSKny4TM2jsBui0+gGT8XWxJKEEGIAO5I+8sbuMjXeQqBl
   +67uOArk4LUGd8pCwIqr9RPAeYDqGwzCrRT1ufsJjm/wBHnm+Ig2p90Yy
   bsDKJONEAEhAaSaUtWhpJ0ckWFxtJDBeK27cjmXmdfe4XXNR5XyCmUD6c
   fveh5de8CH9kom4LS0ZkN5Ygk3nEeKofcXrMbzBtCaDHED0diUtBVIbws
   lQR54bXmG5zwypm6Ys+xzBGssniCpqAf/2QVqckRQwR/bKRlSpvMdFV7q
   Mwf78suPSIiUfpgKZF4vTVKLQDNZ5i8woTrnPps4dR+fYFGlIPOap/ohW
   w==;
X-CSE-ConnectionGUID: EfZT/qobRnOG+a2eepPOeg==
X-CSE-MsgGUID: neBtltiOSQqDoI4qkBPKcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="52925365"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="52925365"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 03:24:37 -0700
X-CSE-ConnectionGUID: T/Iggy1aTkG7jMCg6rGeRw==
X-CSE-MsgGUID: HErPFiF+R1KWQeh29Zu6oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="120765898"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 03:24:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 03:24:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 03:24:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 03:24:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwPiP/a+3BrVQVGtTI5LMIPigYHb4xypwiBUzAXfb4wJv0AQRKzR0nNlBqpgILfpA5wu89cUishXtVmHB8qE1uPbk2rh4Lxv1IA8WQAw7RyIEkf48h5w9NpPnSoji4nmUpdIMjPEkBwiBsCrhWxdafEAKPNN8Zyt6j6Wsqncj3aKhE/lUhRw+Lg5DZckHWzX5dFyqcCK7nqRpP8xXRKjM8R8kqPcHgPSz31DtEsfqKRHZnubtVPcwyBt+BNVm5Ns5SfABuUQGh0Ho0ShngDWXQCMAXaCl9cyJSKtSbTBSJ2DlEjSAgj7Bnd42I6fulZ0AQB+jboEkv+pdUWx1YOjKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxRaocE2LAONj0aSKDOvv5ZmgMbP7et4rfuT8mHaKzA=;
 b=HhMPyQs4g3eK9t25dkLRCVYaPBVv01xguSyZ0sIk1g0b4aYE/vzneMZZmV0ABdDDbxAckDcPUD9r3mlvzmdZCi1Xqk6L0YY/plLGkQ36OkfdAyvXgdeVctp1NoFMCa3JBAXiA2TjVuwFw3p/bhK5veyGjamCQUVAFo5JFiwTo9wKumQWnEJkBr+FslFz6jM7oFtkj+Np45LDcj1b1XYNyghTwQw2UqVdDg0+uAQm444oSSARc2sGDyn3h6eTmRmw55Ywnd2eDuCOve4ZSJ9wum91ka5wL0fdEXfvbHb6jhuyquRotixdboYS6xHnFrEMRTqHGUhFFKK3p+VDHhw1LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by SA1PR11MB6807.namprd11.prod.outlook.com (2603:10b6:806:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 10:24:04 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5%6]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 10:24:04 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Simon Horman <horms@kernel.org>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Michal
 Swiatkowski" <michal.swiatkowski@linux.intel.com>, "Pacuszka, MateuszX"
	<mateuszx.pacuszka@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 1/6] ice: fix check for
 existing switch rule
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 1/6] ice: fix check for
 existing switch rule
Thread-Index: AQHbfsAlYUtd5C00+Eec2jtMefB+aLNQUX+AgB2QXLA=
Date: Tue, 11 Mar 2025 10:24:04 +0000
Message-ID: <SJ0PR11MB5865BA9138DFE20CA24C05328FD12@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20250214085215.2846063-1-larysa.zaremba@intel.com>
 <20250214085215.2846063-2-larysa.zaremba@intel.com>
 <20250220145537.GY1615191@kernel.org>
In-Reply-To: <20250220145537.GY1615191@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|SA1PR11MB6807:EE_
x-ms-office365-filtering-correlation-id: 3291ce57-2fdc-4e2e-bbc4-08dd6086d98b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?qVja7i81xI8L1F/wE76kZusTygFRHXEpvOLvvxczhJSSdo9/VGq9OyKHyhdR?=
 =?us-ascii?Q?28aKBwJi6fMN+qmAloD5riHvZLSByG24r+L+S/HzFjm8CTOTiFYGVcOpzkZT?=
 =?us-ascii?Q?CkjcBZEkJLtUJTDTlXaD/ZCVXdNUgBUrIv5p189AMGy5z0LAfA5PASh9eD9F?=
 =?us-ascii?Q?IQFPAQgUY7OzrjMTNpO1a7FMJ+OoEAMF2fnUDuul8no+J7+4hBiEY7X5prHB?=
 =?us-ascii?Q?k5pBcaO4NX++L7XMcBw172yyvHKNyR32YLIpaBcOejnehQ+Qz48amNyzBr69?=
 =?us-ascii?Q?KlqtrxT7Cc48Pt2t7kpLzE1KmGnQAwsR0LL34mps78fDvY2JGWSMQn6A8OM3?=
 =?us-ascii?Q?h8V9OZEEvbm7tGY1li7JQWYtyXFyHMtsiQe39XUVdzGu96tBqKIMWO4FPoE9?=
 =?us-ascii?Q?3z+936NVmXWKabfdLq7PPE35IJVGPQZgld0I/0ASF6GVEp4p4Jr+gcxcRznZ?=
 =?us-ascii?Q?+Atn16GzoCm/TIsTHsORGSHfQIciysGiNt0fzUXBayhN6VRx54clkcq6lBtv?=
 =?us-ascii?Q?3ygbnYagz9lJwZBIOXrb34WvjDPqRXLx6oIsfehrj53CcfXHBdgp/O582L3O?=
 =?us-ascii?Q?KIAJCXR56/nB0w1bX5Xih0egAsmy5bUvMscaYTpAclskiuOL2RBLO4gjMaI5?=
 =?us-ascii?Q?IIXOdNqRo22By8dX+RO6PAB8JAQv9MCB3GMfa37J2iu1kkudijG8j2Ys6fEH?=
 =?us-ascii?Q?H99h7ZyOGcQh6PmTVapoC3dtsgY5K5qXgWmdytq0LnRxoglJIe2GTsCXEQ9c?=
 =?us-ascii?Q?BB8y+4JyfslC5u9Lh450DTPDLIrHSDmeQSMCLzduFlfU+BBAz4uWU8JSp919?=
 =?us-ascii?Q?kbPHIDwSaanF4fsUCfFCUkFZ41bkkGaPEWVJ2NMWV0muVrVcgR4MD/cpaqNK?=
 =?us-ascii?Q?Rieqw+xDoV0cRJj8xg2E3EGwiUFtyClXY2RI5HA10/BelYJtIFGa3vuU2zgJ?=
 =?us-ascii?Q?h/jws5jzq0sNxjnw4lZb7/l3o3WM62yj5zyH63uahFjugsunY89Y/otObo6c?=
 =?us-ascii?Q?G5NGv4PinPBxLRVkIV5XDViE/8wyuxwf54enOa/eanAt3QhnwDuz7Zdb6xYc?=
 =?us-ascii?Q?rM9qzXUNOvHH0qXOFkEfhMnKahHlD2T8Od32tFhKCwYSKEmF9Rih0FiMj+l2?=
 =?us-ascii?Q?MJWSOH3p4GQ1SVp4InHUuEiBlqnilcun6lONiorka+LILEPa+2CQFBXj3vqD?=
 =?us-ascii?Q?hSXkJYMobiyJTXisw9zmx4jtEXnVuHEkYhDWqNmkdnTxGZVUxVO5e2vIoa/H?=
 =?us-ascii?Q?RyIi1maD8qMBn5c7uvXH6uhQ4SrlpNrgsUZYcQwE/uum5IZEnc7ky1+Dj6ec?=
 =?us-ascii?Q?59868JV71MyYbCh/PPEFcAQq66kJsJXP7jBI6hsgI7Np+JtanehtyTnb80/e?=
 =?us-ascii?Q?zEiSz2Guzw/yh+6FQPwKzauMmGR4yovopLb/oKC+I9X1d7Or4NcWUZIv4R8s?=
 =?us-ascii?Q?KhMYk/VfyRCvAvb+QQFxCfvPj4lEEiqd?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X32vqNdc+uZwNcS0ntOSR7yTQa2NJysP86/Y3tb8hzEWAKcByYt48iwkCvy5?=
 =?us-ascii?Q?Co6j1eIXG4gfAE/jce3A+XXX2krhZhyRZIvZs3I2JGgKiOYkqoGc8nTvkUpd?=
 =?us-ascii?Q?cVhc5Y8BwvRLKqHjAn3ttm6jfnASelGxtIS4vvtQSyjq9s+tML9l/5xB/nUA?=
 =?us-ascii?Q?KDRk9YQeNGmrS5s3H1FMJc3twGAPuMQdl775f6JmNjStBQ1cupHOW/vVeZfh?=
 =?us-ascii?Q?FLqR1oYZD1apt9X0LwxxJbXFVZwYgMj0R+2BMyZjkT39QM/2N6Gk1NMfAOhE?=
 =?us-ascii?Q?9aqIf0Q1A5kmbNSDcSxVofSAG/W7wT0zowyCceI8TIludCpZUvUqk6Rbb1Fh?=
 =?us-ascii?Q?Ybi9boRalaaO4eE2vsufjOPHTaLYndQHx3+zLcRWDX0cQWPSPvfbXr5XMEzE?=
 =?us-ascii?Q?paTbBR4oNN1WhOWTEFLLnDzZuh19jX1Rg5hHnvGYCbxVIz8yfcPQ5fM49/xw?=
 =?us-ascii?Q?LVr53NOCuI+bwdxyaWnFbBXEbPlcwHnlUMVNIlPm4UpDRnwIPE6hJtUIB2Nt?=
 =?us-ascii?Q?N6gBqQ3AJ458CZm1Xnswb4qv0mD1+oREmHgcaYigqlwmAbkDt/FBgU0/vaWN?=
 =?us-ascii?Q?nWiXjV8uYj9MAVOfH2OP/cmPlYAVLJaqZfG443QA41VhxKX6i0Q4ZKPjPutN?=
 =?us-ascii?Q?S+zQ8dJ5umjkhH7+CwUX56cV5Z4Yut5+KfObI7sp4QEKP/hn2uFRQVSD2KmX?=
 =?us-ascii?Q?8B3fe8eOb2ExnFM67744YzwcLTZEc0EQyfSE5mZyhjOuWsojXzotxDrKGViy?=
 =?us-ascii?Q?71ALHOnHOSnpHTRcOUyWTH/4TqoaT9kNw3NvIB4cp0kDnpEizJAGAA8O/mOK?=
 =?us-ascii?Q?L+v2LO+pBt99/kRbhaOe9w++g+uEZbkyn18V3eP4EtLL+qb6KE2bjDYvvxIM?=
 =?us-ascii?Q?ozLlbmba2i5L4Z+Fzm/11hZcsYdmAe5K3F4o18i5b4rEA1pzBqGAdkYgxMsY?=
 =?us-ascii?Q?hK5IzZZw/sy56HWhxvVgau8wOFNPILIDem4fhLlzfDJBwVY+GoS1FzxCYjep?=
 =?us-ascii?Q?Cna3+PgLSzHjpwhC1LkU6U6HKnM4BRMbKNzqJyA6gsXRX5zzBfx2TQIPa/+5?=
 =?us-ascii?Q?KdB5HRbawvDK3mJmRIBDm1kAUOivybox9ar297qPg7LbgfufdgG7si23gQKw?=
 =?us-ascii?Q?GMs2kzznSj4Mnvk0ar8oCXb8K3QObqnjtgeWi0Xft/Wlz9ngNH14G4BEMVkJ?=
 =?us-ascii?Q?CDijgCTi/GRnIOtsvzm1Il4qZ8PNFutc+O9DEdOtmTjxuauCLeoXHpSUFNDA?=
 =?us-ascii?Q?GGBEWMYdbg4Wepda+EfbejvKm2DbsJ4dp/1zQXLdcJHzxaYgdY9STnewDSXC?=
 =?us-ascii?Q?QBY1GFfk7+Jpnml2KNYLiyf112FsTUydeE7+iSa8701o2KTNeuyCkrAjiQTs?=
 =?us-ascii?Q?/Ra1rqU17VNpcc1a/mcLFMjprqHsPU3BN+Oa/lfDDAkeKX3IVichB4BP+uny?=
 =?us-ascii?Q?xt7skMTskAJ+pFnnaknNJkqCXeb3bCtIqliNSHm7nFG3Yjt0K8OFZebI9Qbl?=
 =?us-ascii?Q?PptNzNjOAhaXYYh0AXnrtksmAIfqtszbJ2gGsPRENxBbEgxVeagW8wDjVJ4g?=
 =?us-ascii?Q?GQl/O2TQXcfEElpdc1H4exq5JUZpEN77d+CcPQMG4Sft/My7cCygsXkGAMPB?=
 =?us-ascii?Q?pA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3291ce57-2fdc-4e2e-bbc4-08dd6086d98b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 10:24:04.7654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eSYcfip0dQfcuQ+KGuvSN5juDXWe+KXQYI+pCp1jkGlx0BIUamgKq2E9e3kE9MH0FuxaY9n6CgsVJYrtNu5tX8ZMuCEdPWndJ3CMZk6j5wU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6807
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Simon Horman
> Sent: Thursday, February 20, 2025 3:56 PM
> To: Zaremba, Larysa <larysa.zaremba@intel.com>
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; intel-wired-
> lan@lists.osuosl.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
> Andrew Lunn <andrew+netdev@lunn.ch>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Pacuszka, MateuszX
> <mateuszx.pacuszka@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 1/6] ice: fix check for=
 existing
> switch rule
>=20
> On Fri, Feb 14, 2025 at 09:50:35AM +0100, Larysa Zaremba wrote:
> > From: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
> >
> > In case the rule already exists and another VSI wants to subscribe to
> > it new VSI list is being created and both VSIs are moved to it.
> > Currently, the check for already existing VSI with the same rule is
> > done based on fdw_id.hw_vsi_id, which applies only to LOOKUP_RX flag.
> > Change it to vsi_handle. This is software VSI ID, but it can be
> > applied here, because vsi_map itself is also based on it.
> >
> > Additionally change return status in case the VSI already exists in
> > the VSI map to "Already exists". Such case should be handled by the cal=
ler.
>=20
> FWIIW, I might have made this two patches, but I don't feel particularly
> strongly about it.
>=20
> >
> > Signed-off-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



