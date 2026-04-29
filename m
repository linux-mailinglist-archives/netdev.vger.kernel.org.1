Return-Path: <netdev+bounces-282325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBMtG1fO8WlrkgEAu9opvQ
	(envelope-from <netdev+bounces-282325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:24:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3A8491D4D
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89A38307C80A
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21B23BC664;
	Wed, 29 Apr 2026 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+QAqt5c"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D633C0633;
	Wed, 29 Apr 2026 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454426; cv=fail; b=R2NbsA3sGV4WJbOH4gj4rBEM0N+R0F2QvOy/aQylYTdMEDJS0hV2GY8JsOIpqoNJd091KYl+QF2g26ZuKRoKpcxdMc7XC+65+cH4xJX6UN+11BfTnqHqzcR/iJsWNn6cBvHEJgVNTinxHjOPtlB1gwhtl4O6+GYsEfKue1XLiik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454426; c=relaxed/simple;
	bh=uQ3P8sUKieSyK3zHIwnbcvbXYhu8SqSh5NUDqtamOpY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U9kdSoOZnAwxZAtbvQJ/I+jd9JkozNe0gSEjGQcR44KOH7YvHW1S/wetLAXaxM2SirOtPR87jmS1H5gLcvfUB+0TYvKp1cYnDvchfpAubHwTK02aei4L0XNqkrJAY8/gSM3JD3ACCtBoDYAGNarV/fqX9gtOXkf/1jAIi/xOmpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+QAqt5c; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777454425; x=1808990425;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uQ3P8sUKieSyK3zHIwnbcvbXYhu8SqSh5NUDqtamOpY=;
  b=V+QAqt5cxNghpu8CN4DkmbMZhLHHvJQFCtl2Qfwf/WXpaYkZGSv1cYy1
   AGuwoDjHzIQLt15tpHfGRbI1yy2NAHBWsHX/5AAqD0G8UIUtP9sJsdMVF
   pIPC/y0kFAGSnQe+6OFyKdZuf4Hr+8Fl6wxfxllja5ryuY5lN80u+Kh4h
   AqJSTYlHgys9tuGfTQR/VaM02ytXlD5VQUE8cKdk46FyCkHGaHSF9z7Fa
   TRBd0CQEPwptZQ/2Lv3JGDwGZ6dJbqNXDJp9cDSj7ja/UVxQ3NsOt/xdK
   x2+IUfiJbWK282nAqra7EVTVjRSTYz27WPkKnXReDb8mhCT1Ubyt7ViNA
   A==;
X-CSE-ConnectionGUID: ZFKiZgHzSku9jaoZyYGNEw==
X-CSE-MsgGUID: 9VYFx9K0TGKfxzBQrIxJvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78394750"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="78394750"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 02:20:23 -0700
X-CSE-ConnectionGUID: zIUHFDa7RZO06N1ayZcxIw==
X-CSE-MsgGUID: h39YCb5CQX+fDrwqg9tsgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="235995448"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 02:20:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 02:20:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 02:20:18 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 02:20:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hna15JFday3I2mbW90DUMc1nqoNrkXk80rEIhgvicR+kexWZkMHw+FXa9/PASA3KjHxtstHEVUKXIOTp7Z9n273pY+ftX9C3P8tR/AT1YlpPtT2z9VkC7bZWyzhheJpi3Rf5gGJl+qrq65ZAoepTxFtdr9SGpcz1omeWZWcpK+7SPVgT6+qbsnvB0VfF+8IpAwF5YlBi0HGJ4UjfNMJuKosdeecPQpfUM/BaPRkkx/L/O+saSE/xiYSo7qxRoNpw2VaZHi5HtfTftMVeqtuH8wLHSZUGOaFTflOaV13liggAXvJ9RxgnvJYVsrOy/rjzRCKy4XwQmGFGKZ6Z7OHJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlY0Xl1vwtQZOpx3EoAiMICHQuIi864MPMpNUSo0lhw=;
 b=mMdVcK9FEiTl3rzxPEeExzxIHsi/50pWUbn/HqDggExN4Zv73Gi/pCSDl77jXsPfHkuGbDnn5rnLUonqlYZghgGdhEKnUdFL11dAXmP4Gz3c2z338NglFvGtbgolVcxSvn/Uir7XlyosPtVtrq59qzKAP+bSSUC58hS5guv6YOjEijJp6W8oebppZsoEsyOMYXVKyjLneA7PaiRFCFNG1uDix+35h7z1VHBIM4AYu8BiOBe5FG+NwwG9wnc77hZZX7eUXg2DI22BkbayBHipJwQBKtfUrsoi+4zKTlub1sh9WAWq94KOdlAYhjiPwyZH8FPkygfRmPTRFttbefEWaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by BL1PR11MB5303.namprd11.prod.outlook.com (2603:10b6:208:31b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 09:20:17 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 09:20:16 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Mohamed Khalfella <mkhalfella@purestorage.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH] i40e: Fix i40e_debug() to use struct
 i40e_hw argument
Thread-Topic: [Intel-wired-lan] [PATCH] i40e: Fix i40e_debug() to use struct
 i40e_hw argument
Thread-Index: AQHc1zs9P+7mdJc4K0my/Fkz+QaBfrX1xEjA
Date: Wed, 29 Apr 2026 09:20:16 +0000
Message-ID: <IA3PR11MB8986EAB070E14E70EEC5088BE5342@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260428181450.2622899-1-mkhalfella@purestorage.com>
In-Reply-To: <20260428181450.2622899-1-mkhalfella@purestorage.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|BL1PR11MB5303:EE_
x-ms-office365-filtering-correlation-id: 1b5c87e9-632c-4af0-5d62-08dea5d086f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: OE+QGe0X5HkyY7GKKgEwdjONY9PHHuVz0KLnMyJ260LwCtK8e9qU+1n8ZRYdBRcgzev3c86zNwtz/goCnHr6Os/SbgFjv3GxIu02Drtv01mrwHcggPJngio4X8rG35mfDr0+9yNPfOa9LfJAZEjKtOMdiVqEQVOTDtFDgxq+HQ2TYlBcg1dZ9+yvOBUD/WHZ75GScCf5BXV4l1ByoAbEVU1VKo2zvdg7jHPTU9NUnHtKJQZEMNYrCspqhpEPbu3K9AlNRNsDYp94xHBKmGr4KyqYXUcHgzRiefUHQGQJepIsHTrpgcFi+QkHpI9YRBiR1dQ+rZAxlBW1NB+Tryd4v09z+0+lQhmCM/zumDs2PvEOsDMEJ4SDy/cY4rSjaoKaSc7PBkHYksISBGpQqrkfea92ZfciPVdlR9H+vyPO0dXuJhT4uO9XXD2fDFbfqxvrYdUgtAKyAbiW+wCtxFTyLcOqmuSljap/MGBGRYCRsVDmELrvBjBFXQfL+J12T7KkKlkV0YGR9rBLjtR6yp8MbCSmoBMeZjV86qMVa/wY+Y9zGgfuQ2b8ng3R2ye6V+r2kXu8HBjSclbTfgk5x0IZFldNIV2AVUlopG7LTLipRAz7yDURJexEij09gbqwl74xSY5ZoGfns1If/Gj9+h5iQEUZNy4yYi4fWdPrhEEn8PQnGMfFcgBzqMIrLjLGrwy+2afQeX3urxSkTpmgeJdooBb1iMT/k3pDjbEIHyA1vjjpb+mv0JKsJdm4SAZEndj0kAaEuYMa2d00FHPCuaHuJNsuB2p561pZOJRjdfo/PDg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V1CSylOdEg2banCz0E+Qk9AylJexS/2HNvJREKSqyJky3xfAUQhJaTxmGePe?=
 =?us-ascii?Q?waaWm9iRjOsEIgMAkdEIu7VgpReWhsvADxd7msxvYvjzOYQyf2UCGkbVIavN?=
 =?us-ascii?Q?sc9IP4eC00gksF8cBIfF7B4bc4dmYt9yMD6kVLDW/uo95JN89ti4rRlTpkh2?=
 =?us-ascii?Q?9clw1YNpmydSzAKS69mC5ttQY3JPOFNMpD6nZ6s/9+OMv7ymfz4JHzrLwzfc?=
 =?us-ascii?Q?f0paf5/+aZgv9/bJABh65gYOSu3CDhPpOXeK3ejmcFPi/Wd+ioo6vaoJAZUh?=
 =?us-ascii?Q?JyVsGr5kJ7ImEU44dF9ePt0v4oVkR682ecb85HPjoQ8dQh6vIqD5EPWNDfKt?=
 =?us-ascii?Q?tQdJu3Mxrr0JRnGbvocKO43peHN2XF0HV4PA5xLRk2wRSO7G+qI1FsSzuG1z?=
 =?us-ascii?Q?bf0XP2LfrWAShxfm4Z+fRrppi3qWVKzxUk35+n6wY10bDAK7VmAM88FmA21N?=
 =?us-ascii?Q?1oyQhIxajl+IK3xmAEoDhtE8cHnsb86nAwRpbsPWp6Mm3gwIsIdMcTYarHDY?=
 =?us-ascii?Q?QgSMpgns/qyeZM1HEe0xtx35v2PdpT7xvezJkTLN6LIiJDTJTNPYIlQ/9Vsn?=
 =?us-ascii?Q?kiTVQpFiT/TR9qA3oC/WNiGtlZ5giCxAoySKaIjFcOoqBASNg10x+H0pFt6l?=
 =?us-ascii?Q?IDfns/2fG06lLFCKuUXPu7jUgSWX+jPMpQdlhfp0A8f4o4nxV61+I9wkc8rL?=
 =?us-ascii?Q?yb0N0wg1RHt8DDX1A7GcpgtK1KVBZq1He3cPRVsmGkmVM6GPN32hSsKR5q2q?=
 =?us-ascii?Q?hs27UjcaPNjOdm7nxVBKz26Cu5Cb198E9mXyll4JcXXRxk1O45yS2oIrq3Oz?=
 =?us-ascii?Q?88CX5E47d95VaWoNq7XO9sSuCxtYtRQTVlhM6bpeXOTxfYIv0LEhM9gw0mfL?=
 =?us-ascii?Q?ZmTPvMA59sgpireHsxyr3whQnrmNbvooXGCha/dh9QlK/l20LSETz5dd7qLz?=
 =?us-ascii?Q?NRy7TYLfvaXk8NqIFhuJlbBlfIIj8eY++qPgfWNsEXszZ8I82iiWEDwV7O9r?=
 =?us-ascii?Q?KM937iY+Maz/TjEmoEwyUxRkAHFhuHLLHZMzA1VGKPh7/4sGbnMYSWvrxVDi?=
 =?us-ascii?Q?B7GUeMJpuFNInXzTMSKyme1Nl5V+QORbV37F7YqpE+8+SzZ9FGHyMTgbFSgH?=
 =?us-ascii?Q?bTu4H/24sXo4mP+xek/rsXXMJ5yfRks3MjQTiemYUP+NoH9LNZMKsJ3ME1Wv?=
 =?us-ascii?Q?XPIMzLWo5MmWbcVrHtCbNGNjHQ5Qn4PyTSpiVZqE1YdWnXeeK7kSiXTTchGW?=
 =?us-ascii?Q?Jl4/ljQDew4AtWXH49XMUrvTlRC1il9htEkNeuv/PJbyCbOZ0aVjl7XSx/yo?=
 =?us-ascii?Q?Vyg3F/q82ADuj65SaBisPbBbYB4myrYasSanMvbgQgoeFLuNW9kmEp6DBj9B?=
 =?us-ascii?Q?pvBsI262DWfLVb2x69AXbaaOWkps8NxHQSGdwPjIMvsPlpcsJKnICq4Wa+Zc?=
 =?us-ascii?Q?XGT5KCAZNA6OjRzoK8C89+hYeUbwoLOApCfDVDvz48qrEjX9NT2Nk9Nl0tQR?=
 =?us-ascii?Q?0y1QGH3Lfy5D2dws2aNvQRSdk48xCfK1ocl1gppjZyU1PJG3Rh9EcFvBEu3j?=
 =?us-ascii?Q?KEWP8mnIrQ/tuzSGoedaYEa/+avLkcwPwS4qvzQWG29uvZoP9POStdPtRlai?=
 =?us-ascii?Q?tyy2NJCAoGA2pqbryCuoVa5xWx/SP4ekJ9vLcV1hpbKrhCiXC0j5mW87CuBw?=
 =?us-ascii?Q?2msZOEnlmbXwN16y+9JQVjwBLYboy4dKYznFEajDn4y+lUqW5O5tawXkmMkw?=
 =?us-ascii?Q?3b2JBU7CXmGUqSm8CWiLzwPBEPCxfPM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FlNOnZZ6OUu3TiQ+nRdZ79Ajk1FcCT53cUVJvAktTyCXr3p6c1Z/BE+4Ue22ZNpdFB33VC1MsCAb7PN1fNooNJStPyTmVAdpusLQ8stMDfMfUb9r0XJVSj8bjl5bPvAwp6KVcxYPvpmDotlLLu8h8pEy8B5FQFvwRHX/Q2Bh8qBZsFpLJIBtrUw/CojusENrT5xcrsD5ces0geLiH6PQ6doA7JFOIOwE0VYf5Hi5o1HRs/b/7/ysJzVF7SGkewWQ2dAoXPGn0BgI8JYVmIXKTzH6EVtWzV91wnPJBYP8g3nhewfBiX4F+6dHzGf75QeeOx5u43r/BHsBi11R5rB8GQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5c87e9-632c-4af0-5d62-08dea5d086f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2026 09:20:16.8970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IrQlvOrna1NchQgT3mmGELYxOeygJNiR2ObUJLRgYJx3UHH42Gg78Lp3D+3oh+/2R4sYCxnpA284iq7jXHXPmS+ArgPeih5i0/AJNGObsLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5303
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: CA3A8491D4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282325-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purestorage.com:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Mohamed Khalfella
> Sent: Tuesday, April 28, 2026 8:15 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; David S . Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>
> Cc: Mohamed Khalfella <mkhalfella@purestorage.com>; intel-wired-
> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] i40e: Fix i40e_debug() to use
> struct i40e_hw argument
>=20
> i40e_debug() macro takes struct i40e_hw *h as first argument. But the
> macro body uses hw instead of h. This has been working so far because
> hw happen to be the name of the variable in the context where the
> marco is expanded. Fix the macro to use the passed argument.
>=20
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_debug.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debug.h
> b/drivers/net/ethernet/intel/i40e/i40e_debug.h
> index e9871dfb32bd..01fd70db9086 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_debug.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_debug.h
> @@ -42,7 +42,7 @@ struct device *i40e_hw_to_dev(struct i40e_hw *hw);
>  #define i40e_debug(h, m, s, ...)				\
>  do {								\
>  	if (((m) & (h)->debug_mask))				\
> -		dev_info(i40e_hw_to_dev(hw), s, ##__VA_ARGS__);	\
> +		dev_info(i40e_hw_to_dev(h), s, ##__VA_ARGS__);	\
>  } while (0)
>=20
>  #endif /* _I40E_DEBUG_H_ */
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

