Return-Path: <netdev+bounces-266635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBKRI7BjsWnsugIAu9opvQ
	(envelope-from <netdev+bounces-266635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:44:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D785263C57
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31F3430DF767
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 12:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB065359A96;
	Wed, 11 Mar 2026 12:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PiModL0h"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2042717A586
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232939; cv=fail; b=YlpYIX2Fo65DLREFUo7xULJx0N8XsNhmzp+woVvPCJ5AdrfPKkzdLBjh2RwEpa+Zn4Fs57wjaZBRijLE6KswfUQFEol1N6aTiROex9LzeLG52jAtDKy++tp6lIcAxj0/y194L+0fcw9NJYhnTxfVk21y7/lTs38viEpHheYWMpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232939; c=relaxed/simple;
	bh=RmbV249OUMbWKnlo2eYt5D+QRUdey8hkkQ+u8YPStZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lUjQdv7h1NPrRH3Mnr7F8tG8TBykWd81ITCpzr4GnlTZAnhlmFb4twZIt5ivztH8bUKe7dCxcuejuWtABw+f0cAQBCtGGuO1yYSy7UWm6TTzXYZ4MuhyR/KewwGSaBkh+RoAqKUvwvwDeT3W5K+P8Xv35aBB2pxWh3fwixlLyO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PiModL0h; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773232937; x=1804768937;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RmbV249OUMbWKnlo2eYt5D+QRUdey8hkkQ+u8YPStZA=;
  b=PiModL0hm5TysV3khlxZ9Wekd/IUemhM1bWQVLpjkuXB1u+bmTJMfqh5
   OxCwVYunkcA3GuKUva8X9WKX2CFFYJ/VLdRlX95KQ1sM/4oIagxG+uJ2j
   zhBdxpDvsstOr3PeVCQsH2J65qQYWZ4dI9QiADDIj5OImUDA6z525KHQ+
   G1EywTfplmQx24eHzlB9cDEVoV4mOUDr9753RONydGQDTGJv3gxpMMY3Q
   2sfzIKL8sFrflH3fK/NsYS4GRyf3orUpfE2whvjb3mEpTlCbsbROJ6J3v
   qywb7aiACU6hPPdhEDAikimY4i/O7eoipjP1hgGVeDB17pWPUbneNJ/iv
   g==;
X-CSE-ConnectionGUID: x364QK1SQwCBh5eZh3IB8A==
X-CSE-MsgGUID: jSCThj9CSmiZqc7nhst0QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74417540"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74417540"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 05:42:16 -0700
X-CSE-ConnectionGUID: 1f+7G4psSvO6MnvqGrWE1g==
X-CSE-MsgGUID: kdwbvvLIQKWjDQGRzPsxfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="225409183"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 05:42:15 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 05:42:14 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 05:42:14 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 05:42:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAuG3s5330UE6lPfX1qVC4N5K/D5+PyVj88ROVu1qWazJ2g2IHShA0bRC/KZepioYhFHo6U/Hm5fwsmrqYS8TeLPs/PwCd9XGb2I3cP2YG2KmUnFvK9QUKcgheYxf+Qirlir9YLA7ZlPstGLF8TzJfxfGZuexlVwMOe9OBWt4hMgmeAFBW19146Rc6jfRzJNaB48FfKzNhyZ2+1Pe/31u1IKARqmWp4nR7j67Aj04onAJEkEK3aD7NOPIBILm26oYiuFnPsVhn+wrYLTB/HY4b7i8dux7FHNaHiPx662sCvh9vY5a+c4jpD+70TqbWAtrxDfZADT5qNOQuMGhHKl6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJdxcf18osN74YRWKS0vnaAtHPv3gsjlr78HCiuC7nw=;
 b=Nx0JyHyIc8nKRCnEL0cBrHkIJ8qI9lCoGIbVR+XZEd2tH6j+MivB6V5pebnYMuh6lAQrqlugrHt1MQYHcV0NnOssyDuIzAaDVECjbw5djpn2Ge4jj5JuwZI3lfgOPo/3MFxyRRBIIRjBm8uWlajncm1FlYybOT0fX8KnotVv0iMkV7E44f5MxjBp9vTN+bC1xggXv7Uc+loD+ZHsUPsnOrW8m7hW28kUSyymPM9sdJJSsEJazcU0ukRTfBMBHAF+rjC0hfflYKs14MlsSTMfFJuLwcTkIbwdwxAyb4ydBfhajbkq9VxWgCSZzLMxwHBqxOGZd091QE9N69sXAdFO0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10)
 by DSWPR11MB9559.namprd11.prod.outlook.com (2603:10b6:8:36d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Wed, 11 Mar
 2026 12:42:10 +0000
Received: from PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305]) by PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::ff04:50e9:d186:6305%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 12:42:10 +0000
From: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [PATCH iwl-next] i40e: PTP: set supported flags in ptp_clock_info
Thread-Topic: [PATCH iwl-next] i40e: PTP: set supported flags in
 ptp_clock_info
Thread-Index: AQHcr86Xy2U0MgoCgUGFZQFkE41emrWoFskAgAExmsA=
Date: Wed, 11 Mar 2026 12:42:10 +0000
Message-ID: <PH0PR11MB49044CA89B5D8780D477561D9447A@PH0PR11MB4904.namprd11.prod.outlook.com>
References: <20260309141220.343224-1-przemyslaw.korba@intel.com>
 <20260310182458.GQ461701@kernel.org>
In-Reply-To: <20260310182458.GQ461701@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB4904:EE_|DSWPR11MB9559:EE_
x-ms-office365-filtering-correlation-id: 84857f32-f952-46c5-149f-08de7f6b9ce5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: QGcJGyjNxaiM65WNy6RRzX1wG4BoIPrwRCEZmhElsPLwe9J6G+/VT/LdWKj/i3fJenDH7gr+P251C6awfEZT//jEaAnvoecs0g6xI6aCNR4hMwJtimGhTXMOFxX2TRT2MqKcFx120nnUrW2zMY3FEvpZPnfqtYFRASN7Pq2gF8gXV89MStKs5HwuAduZiSFFRs4Fk5jWBlNINT82h27tvBlYQtLl8ENlqLJGp4nXA1K2Lu+XlKP+8e4fJAzgrb72awBbAB2Wh0elXK8crGenGa5VMbCsSvkv4gb8O9PRcxIgGrr2PXS+5xtkqp7LLV6uyR9buscHCKUhX2xgHzu6umURVulTktcSBxfAcdQF4HIDc2VrkbBbXaTpc94J2j2m3qp2YFnFke1EdVsSu2tMeS+dMC2o0pykzmm9c6NRSEVz5lSAbAhgE5k33Cfvss2Xlv0gJkdu28qOEHaAHcdUHWUH9PFc0RTP1EdAKNIZYPDnCxdru0F2KLE5vqq99X3g2fExwMBqM/C75hvS5wEtGe5mTDJjoDZ6tXXqiCQqdPfahnenjfVDgY1UxdPElEc/PQNQbgoV2avKKc49zOYky84mRR+qUtFdJRAcQr01cZqQ3sWhlklqJhAR0/91dz7JS3K4WOCdIiHrjlDnj5NjF3wMgVcZTbAN3lJDFodbEw46MO2+i5wH7epDett4OPv1JntnCwvM68epP9p1YWoEeziq0dwlvbgPMSxnzX7maLD+MvrjwNnxNHA8zkChDzEC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4904.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BmPC7Gzu7QJ6VhXjS7+ETFPwzX4EkgE0/4LK01OCgxkQoZ8KPRuSPb4zuHQc?=
 =?us-ascii?Q?yJfZsDHAaLUXKs3Vr0K2MVsjl1jxnbA2zMlr3AueRM9V42OzE4ChDkgJhXJV?=
 =?us-ascii?Q?W6LdNH2S2P0zyMO38ADXq2ArBC/hyZWeoxoBq4uJXe3Jntq3EKiyYevYz6BH?=
 =?us-ascii?Q?QebpUxKx0DkF5lVhq+lTdJV9+UOTdFPX8eQIjwfnfYgeJz9JNqptREZRqZ7m?=
 =?us-ascii?Q?fh3/xhu9Wp4e2x+hsC/AX86aTSX/zI9OblLoEQuq+7GohYuNbD9Zh6feeX5H?=
 =?us-ascii?Q?Jtvf2vx3cRswECp6q/NkSolLxYK6KR1TR+A+S8xu30zZU0hgYqk+triMLOoC?=
 =?us-ascii?Q?qnZ1jxguqNCxBkDxYo9cNHl+ONbo0bE6Zvk0aMqczuJ/BzJucRwMNv/u7F5E?=
 =?us-ascii?Q?1AoSj+3IynEahmCoTmU3LeQC+LbeJ0BF5oCEnE3bimWMBEc2nHrDLDlDOKmf?=
 =?us-ascii?Q?+albLLgJRHywpd10kCVR0piWxsFRzSEd3Lbytfzzb/TgKANDOx0CW0w8dhQP?=
 =?us-ascii?Q?G80AiIIlzRrYYev89/TJek40NlPJBK5voA5pzNcMvDbRddJsF4f1YCcZxdvm?=
 =?us-ascii?Q?APu8d2hrSlbNUmrvScgYV/L8sfqtlKrs3fbhdD/+FK+euiq5sdRMQtQUA0Gi?=
 =?us-ascii?Q?gacaJhSqnu2hxseF0nn/Mw7XXXvTphJDmP3M7zdMVBJq7qGhoQlC3Z+sHPsC?=
 =?us-ascii?Q?dtgJc763zLRsbz//SkNsscsYlHaWxbQz9VlI0vldY//ewDEFkDGlo9Nak5Ht?=
 =?us-ascii?Q?a/MfGYck3Tz9GAuoWEUEcRqKHGN5Q6PwyLffThc8sjtf0pC5nMkFnTAOX6Jn?=
 =?us-ascii?Q?39cyOjhlku5EDYseP6C9OGjPyALvwPpXm1jGgnr+D2OFoQ9Yo5yhQckoVI7z?=
 =?us-ascii?Q?GSoxlo+hZKojQnesL948O7IN0UBGXb6ttGxg4MbB+paA13gsCf1rkEArD2Vb?=
 =?us-ascii?Q?KZmYV2nIpQfGtN09SGhDK4m4UsZuIXNB76YQABAuZcFmkqUHqRYZOlvwyKY5?=
 =?us-ascii?Q?UI5jhS8CoJuHixuMr19KurB87DiqgL1E1VdWcwimqXGw776lM2X67BZl/wV/?=
 =?us-ascii?Q?J3evxUHUWWyoJWOJviYhsmNO1UZVJcB6Xk6g+sYtDet5CI0a3fUklFK61noS?=
 =?us-ascii?Q?ycoU6qdP6JYxADPE+PFAk9j0aLVUV1yhpk63kae8Jgzqx0vKVkPNnZxoIgZ2?=
 =?us-ascii?Q?zyuLbGu8y52CEAC6u8eiDCRgkAGuZ88qGbIRUXGBBrQViwx5vZkvJyJOadDm?=
 =?us-ascii?Q?CM1TGcn+iugpLicFlwo75peleGBEPLUNZUHpl/SGWuw5Gg2AJGuR7+G2nnrc?=
 =?us-ascii?Q?2JWnS3fnQEqI9jlQlWs0Lj8GisQOodF8a62xcoTw9ZWwuBMxjiN8Nrue60L4?=
 =?us-ascii?Q?qTXRIQqPNrpnziztqKZVlrSXc3lobHuKeXyyuySKBclmsdiOsT7rcPlwkklx?=
 =?us-ascii?Q?RS0Lb1my3fmYmelboeJJ+d1g1s5eBSzIZYA9ojC8zEwZulNVOs8bB9bspikB?=
 =?us-ascii?Q?wPS1LvAazSXnS2CBW6z0MY1p4/iuT5ajVt8YbFXW1ONfR38L3KopK2yUMpZP?=
 =?us-ascii?Q?CVTxLDS20zyTq8oBasHWSSed+FBTOoST5ynu7ZQGXvLah5cG1bXs4zmPEIUG?=
 =?us-ascii?Q?JXo6Xbg0gU6Ggd1ajQvOZLvs8GL3nC3vS8XvZhvDbTE30D515tm+GSOD2fBa?=
 =?us-ascii?Q?yRHSFbTd86QGDj4smJrYbNRfCw3SFgRNEVMbBZI/p6ah/pQi44kYUtWOn54D?=
 =?us-ascii?Q?ahTnu6+3AQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Zlfqat4ENcswJfH+P3v/cCHwQ0na28dCyGkG6ay2DdgkbdTwZF4EyGnfTqIW55tXcRDX4y61oh7nE7FBUGrKC748VJKI4fDDs8V0pAJUbJIhi7xeSN76OyPPAImgAb5/zqMLzPFeV173SS0WHUR7meg1PvF1HlZLhKJVUu1sg1b0erYXw8EP+Kg0QYr4weODvYX+Su20fPI882Qh+Y/cZcHmv41jg9MCbjPne2Q0mxfqdA2n96RWT7zNx8c0oGWFSl4Xyy89c6RrFFcMvfn/M4ZZi0rwC52Vyd8WuZlT4xToZs/Bfb/5IAnWhDhtNxTidLxcg3pFlz/o3K8UQiJEDg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84857f32-f952-46c5-149f-08de7f6b9ce5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 12:42:10.3368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V4Ua5tR70gI7q9z162EwtnhrTkFRB6ZA3ITGhjmL8IpjVTrcwpEmV/YA1ocSQYEgGrN4bccrdlmvmKemE7GYyqo6cxv2Xm5IDNUcsbjKWX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9559
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 2D785263C57
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266635-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,PH0PR11MB4904.namprd11.prod.outlook.com:mid,osuosl.org:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.korba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_DNSFAIL(0.00)[intel.com : query timed out];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Tuesday, March 10, 2026 7:25 PM
> To: Korba, Przemyslaw <przemyslaw.korba@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Nguyen, Ant=
hony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com=
>
> Subject: Re: [PATCH iwl-next] i40e: PTP: set supported flags in ptp_clock=
_info
>=20
> + Jacob
>=20
> On Mon, Mar 09, 2026 at 03:11:51PM +0100, Przemyslaw Korba wrote:
> > Since upstream commit d9f3e9ecc456 ("net: ptp: introduce
> > .supported_perout_flags to ptp_clock_info") and commit 7c571ac57d9d ("n=
et:
> > ptp: introduce .supported_extts_flags to ptp_clock_info"), kernel core
> > now requires that the driver set the .supported_perout_flags and
> > .supported_extts_flags fields in PTP clock info. Otherwise, the
> > additional flags will be rejected by the kernel automatically.
> >
> > i40e does not support perout flags, so reject any request with perout
> > flags.
> >
> > Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > index 7bcea7d9720f..8d7958692235 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > @@ -601,10 +601,18 @@ static int i40e_ptp_feature_enable(struct ptp_clo=
ck_info *ptp,
> >  	/* TODO: Implement flags handling for EXTTS and PEROUT */
> >  	switch (rq->type) {
> >  	case PTP_CLK_REQ_EXTTS:
> > +		if (rq->extts.flags & ~(PTP_ENABLE_FEATURE |
> > +					PTP_RISING_EDGE |
> > +					PTP_FALLING_EDGE |
> > +					PTP_STRICT_FLAGS))
> > +			return -EOPNOTSUPP;
> > +
> >  		func =3D PTP_PF_EXTTS;
> >  		chan =3D rq->extts.index;
> >  		break;
> >  	case PTP_CLK_REQ_PEROUT:
> > +		if (rq->perout.flags)
> > +			return -EOPNOTSUPP;
> >  		func =3D PTP_PF_PEROUT;
> >  		chan =3D rq->perout.index;
> >  		break;
>=20
> I am a little confused.
>=20
> My understanding of the cited patches is that they add checking of flags =
to the code. So code like the above isn't needed in drivers.
=20
Hi Simon, thank you very much for the review. My understanding is that the =
driver needs to set the supported flags field, otherwise requests won't go =
through kernel. The test I've been doing confirm my theory. Here's also exa=
mple patch, that adds supported flags to drivers: https://lore.kernel.org/i=
ntel-wired-lan/20250414-jk-supported-perout-flags-v2-1-f6b17d15475c@intel.c=
om/

> > @@ -1340,7 +1348,9 @@ static int i40e_init_pin_config(struct i40e_pf *p=
f)
> >  	pf->ptp_caps.n_ext_ts =3D 2;
> >  	pf->ptp_caps.pps =3D 1;
> >  	pf->ptp_caps.n_per_out =3D 2;
> > -
> > +	pf->ptp_caps.supported_extts_flags =3D PTP_RISING_EDGE |
> > +					     PTP_FALLING_EDGE |
> > +					     PTP_STRICT_FLAGS;
> >  	pf->ptp_caps.pin_config =3D kzalloc_objs(*pf->ptp_caps.pin_config,
> >  					       pf->ptp_caps.n_pins);
> >  	if (!pf->ptp_caps.pin_config)
> >
> > base-commit: d5fbc991435eac7a1ead7cd2ddb5a743528718bb
> > --
> > 2.43.0
> >

