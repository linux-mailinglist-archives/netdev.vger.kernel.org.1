Return-Path: <netdev+bounces-300060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gMwGGylRMmoaygUAu9opvQ
	(envelope-from <netdev+bounces-300060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 09:47:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4150697426
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 09:47:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="dKjzY/DU";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300060-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300060-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFE54301AABD
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 07:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC063BE635;
	Wed, 17 Jun 2026 07:47:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062213AE1A2
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 07:47:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781682469; cv=fail; b=Lw4gSNdjz8CilY/TqWua1yL3AELIlErvPozId8pTB3zO40BPpSC14UEjpk+f07gRUPmg8SOxrE6Jp3jWJBcpqKd3hdVZD6JeQ6lSoVLy7VfkVO8f7m19pdORnQ7tnt5WleOhm3+591wbcRhPQx+ICPj9vwtDNU8XZK4ieTuFsCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781682469; c=relaxed/simple;
	bh=JrUU/L/+CK8GH0pQBSL5oOchP/bqq6IbVODrlbO8MwI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mlqanEcgwm/86DjiejtoLuJ3Hiv1THDix8EoHXtBbR5h6hDcEiLDaKUJiDF7A5j6I91yQi3+RcdgRUsf9gYprS00KPJYr0Jc8VKt7aKTqayXHzJDQ7RjKKm5iZ30x3SQrx7UTxFfgwnZK6SZq06KJy5OL/xsnVc5PV0QHWWkswM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dKjzY/DU; arc=fail smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781682468; x=1813218468;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JrUU/L/+CK8GH0pQBSL5oOchP/bqq6IbVODrlbO8MwI=;
  b=dKjzY/DUxchfiBDcThzD0IecQE5auQ2cuMKjtvzVHI0S7224NatsCd1L
   dnV2w/jJpivb36+ta8Zpj6I+H1cyaGhTC3wvtG7w+FsKUsVO7hEYaFwh6
   aRTKDGti3Tk+EsLrGsvFCOuIvw16DHd4iBJc7rT0VSlAx/7EyZWQsgtch
   Hx9PwL4kP1Xskq0BkV6aRu7+USEr3GUXs/EFmTOUfUbTskLGhfj7Rgmif
   D0fI6GkpYpMZqmd41GftmW+e1yh7tNQHLNbbn5YCQBq85u9fJh66A9uKv
   g2m5GkaocG1CC/gB5zK4qOyCWxHYpOz6t0LUkMkKE37HEeT46akhLVoJa
   Q==;
X-CSE-ConnectionGUID: ohfR88gsRkC/IvS1ZH+UwQ==
X-CSE-MsgGUID: Nkh2zRdYRFuTGhQ67PKclw==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82560359"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="82560359"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:47:38 -0700
X-CSE-ConnectionGUID: 76aH5tnlSIGrxdVc3EjPew==
X-CSE-MsgGUID: yG5A3oOmT6ipp9KP2O51nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="246859390"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:47:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 00:47:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 00:47:37 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.29) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 00:47:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTLMniVlzII7aq1VNLiZU9ms2bg5qATbLOqSSGw9NZt0qYmyLhziHg/vBT8//aLc4f2BQT2XVKhY78rCFEp1vLOZObb5EIQHM/sGRocHYjwPDCOUefBgtRh1Qzc1KqxzejqC1bId32TFqUyCzSMX8VUPlAAmBAan5RnHZQne5Ft02Dhr8j0El7trk6NOM9TKopoIl1ojX3+44hFlLD92WQL9GlA+NWdHr8FqilCisO2Ry8EYr4cqa12yLN+IccX6NPju/bsKXWGQs0mJa/TWp84d3Lp9lEG6wRqmUejT6upjtTCYPdCzBFz1zP6zX8DytgmWkEK8PQeh8d9ebnh8DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gKG06Pv3Gb6BsvEvZP9GdD1zXQPU29kA9aYQZcuac4=;
 b=yv7yIrqxWHo1AZUcey9YF9Ew1dBoyh4O2jEjpo4jtgKRw1Bm3hjCqDAed3Ipub16raHLYLnyf93rrt+04Whbyovhnt9fb1bTVHVVMujVtG8sl+o5FafyopgeBmFJpdJ/ntZ4jYabRpWR3YOlrIp3cfcJxGXZAOVSVvvLagmNK8H2QDrC+ni453p87KBHJk+Ydqwqmi+VD9bQW8Bv1dhI4+rm0ymoJJaH//ioCo2urwHswqH42DeCr+cKVFEESKC5gRxkJqRpLsxMWsxiPP7Bb2qq7xAQIYB53byvqx4TIOd7DKUfJad/yX8J/SQc5Of/AeH5A5Hzf/hEZt5fof6OwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH8PR11MB6903.namprd11.prod.outlook.com (2603:10b6:510:228::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Wed, 17 Jun
 2026 07:47:29 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 07:47:28 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Robert Malz <robert.malz@canonical.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH v2] ice: retry reading NVM if admin
 queue returns EBUSY
Thread-Topic: [Intel-wired-lan] [PATCH v2] ice: retry reading NVM if admin
 queue returns EBUSY
Thread-Index: AQHc/dzB5yryS4GEQ0+nHgDeJbfmarZCWVRg
Date: Wed, 17 Jun 2026 07:47:28 +0000
Message-ID: <IA3PR11MB8986729EE79F3F3FBAAC68C9E5E42@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260616220827.1647052-1-robert.malz@canonical.com>
In-Reply-To: <20260616220827.1647052-1-robert.malz@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH8PR11MB6903:EE_
x-ms-office365-filtering-correlation-id: 4afcd493-710b-4887-eb49-08decc44ae3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|38070700021|18002099003|22082099003|6133799003|11063799006|3023799007|56012099006;
x-microsoft-antispam-message-info: 8awXkI6x1Mb62EY/qTqarp8htAjxwJs1hrxK5C9RDBJ8w60SN1w+mNw/0DTMw4xi3swtdTgqU3MwsWeLTmTTudYYYhuUNjJ+h198e9rbiANPtPJ8soLuIr63zodkUDXqftcThAhAZyVO1WkAT9MU4BBt/ozoP3n0cYO50Kspf9mUHMN9pKWnEGO19Ra77f+LcnavdljLbJyum09n80lWtSAfbT8lumHHkHxyh2J3e0HT5thCiLSnSSvTXZUwjnADrcHlgu65ZEJA2K25A3R7z6gLgcGAM0hb+RXYpFizAWlOVbXNUc48rbSaDx79HbztclHyA4N3dxpQ3jTbLbAJUFdmBIm37Rv2rL5YlO9B/wp8VC6fuLJtU4DyHfReX4yrXItrvtFm7aXA/kUtwhhSE6XUCmnEic2S0iicdbsm6rLnpY4zOBI+BXxrj0Ri1qUJ1FN0sIFMwzbKiZ/97RjfRfdg3JnSmQKK/q/Uhk4z3E5w5UW/ruYpvhg5gdDt93sAe328bGiAG8KJxNaY1H/5pXuD9IuOkh3EbyDWvaGCstcSxcesQ2V5H/Otmd/ibqXQzleUR2+36NJUeYC8O+55jPG4mV3ceWUVhrkfHHm4sec77NvrvMvYetsIlDhVz9SsRKQUAkUx7w29WI3y3HS6QguEt2NFheHYPJeV/mfZHh1CdV80G4IWUuwYYRimBaP6UJTHOGXpcKoT9DUHaFV/3rzZR9/vmQzu5E0QTB9sendz7FKzMGfJYWvz83WDaP5V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(18002099003)(22082099003)(6133799003)(11063799006)(3023799007)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ErHWicq5in/EIoBBekmbX1G9d/jg/pvIJMnKArhQfKTa4SXo41f+K9HNFKZv?=
 =?us-ascii?Q?6sLmcutmkZIw22etBcVe7NjpOFb+OA5BSJAFX28392ainrfXMxaqszHnen7V?=
 =?us-ascii?Q?emo7qwRZ0zgDrC+Kf3cCf4WGz3RlWYRWI3l3UkrtFSHorCp+hObo7SucyYA/?=
 =?us-ascii?Q?YFmtYIuv4pDD4SFRcEoh40gOo8JLoajhHzUM1nufTa2TG1pv6vDAsoL1Ug21?=
 =?us-ascii?Q?Clg3t1IK1ww49NVen+qbhjlpggugJdiqbg1/ovvzO0d02zvP8B0oACqP7j93?=
 =?us-ascii?Q?SkT2d4oO3V3E/mz9dZzNfOT+6EDrC/K3tLfil6n55Fj7Ejkbc4xmoRBFgKKx?=
 =?us-ascii?Q?F42lttar4xito0cqKTYFE8ruBIxqInKAV7eWnhQH85z9XklkS0da8JcaHCWL?=
 =?us-ascii?Q?sGemj6CjVWEcKFqIqWe5MO58FDXd02E6p2wJjflDuyMwoCvGT2pUHNyEgFc+?=
 =?us-ascii?Q?RxkrEjahYynaGzgovN7PgE6rXkKH5+Qom8gWS1qXP+9d8ek7uk9IuCoouURZ?=
 =?us-ascii?Q?VJh6VzGwzgkcclAV6Y1DMfgqIrFulaEzVaSfCl3Eshw+HOkaFuGZEbW6k7Wz?=
 =?us-ascii?Q?Vl0/QY4q6gdIWV2xhYFO6/+Ce1x36XWRftKOnNysqu+Z228ZIzbaQBVH4rA0?=
 =?us-ascii?Q?8Qmf2w6K0n4s4vxS2CjzEqB3j7oRINqL8811UMPF3z6yZp9PiaTPepEo5K+7?=
 =?us-ascii?Q?X4mSu0b77MQWBt3JSBekId9HPmQ8q35/R1Bm0/RfHiTvNu/pAL8iVjc0TwcM?=
 =?us-ascii?Q?yxJYb1IXg+TmrOqiv+XBhsUUaT11Aw1nj8uh26Oev2eC7d3lQMEyU0tk/aMr?=
 =?us-ascii?Q?4HZh8hbeu3JomzdyqGkbUbCKUwkNeoae8Nvondf3ypAxKtrHW6dr0RSHdrFH?=
 =?us-ascii?Q?/2APY9zcknmE+0UygMKrkkmDdeMhoPzx9rHh8tGriytVWzf96UklDe5qQvsb?=
 =?us-ascii?Q?azHFMVBWXn/yrsRxo2fdukQqPs8Hg4nEn2cVF+OnXOOSpQ0ETHl1VzXZJkAW?=
 =?us-ascii?Q?NGU29NehB4j2teaJguTCnTQEX2M16lJaqHmNJvtxWMlheijb/wzV3oXo1/nW?=
 =?us-ascii?Q?QpViR+m7QC0p0x6EfGSWSNdPvBmPfCRErE0cuDPZuLB7DnEWnJTTXYZnStr4?=
 =?us-ascii?Q?3n0vWMbogaRnxMBvs1QT5tVGYj63hLHMWpbB3IsIGUVFhKtl6DAYo+CW2xoy?=
 =?us-ascii?Q?xTu8TGcK5KALie2peYawsPq0l7zbYjZfeXuPFYFzyZIihGlqUTzMMHtUQx7p?=
 =?us-ascii?Q?j3v8EPo/ycHH2BefeKx3EoGW+dwwJTi6pTNh9YdrA5RdgZFwHZ93Cr5/zN0l?=
 =?us-ascii?Q?68o1qft5ZBNsZK0CbhM1CyLDsiXe1AjmPP2hOilFHTsEJX9c3ZShK/QzSwqs?=
 =?us-ascii?Q?4qT6//c5Z6QpyQvwc2UHCbX54BOqqgySs14iSUaoxP1aCHSHzIsBlkRe+zUe?=
 =?us-ascii?Q?oXmtreQ8EcQWY59CHUEQhFi5NVIn1jSFYXcOUbHWqE4IrzlkYKpoMjg7zw4M?=
 =?us-ascii?Q?mDX05F2qySuOgNAJvF/ILhKluKMpUFP489PPoHeYUNrvZxJUt51IF3eQnGOm?=
 =?us-ascii?Q?ttKvYRJR94OjSLXrNfn4jNLUMmpAerebAPMUxxIyIJxklWqPmSGa8JzHV/2r?=
 =?us-ascii?Q?umVILOBvO1h84ktlgeO9XMrJ3KsTG+UgMV+MpRPrCuOdpMqdFDqOi5SNMCpw?=
 =?us-ascii?Q?B8VNkZb+8/yeOyAGuybWkmHzUw7SFgyH47ZMAYLpqRf4PU5j6U9981D17bFi?=
 =?us-ascii?Q?m5r3lDfWL3Z1hwKsEFicm3YJI9kYea0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: k2X+UkNB9jirxUl6DAKO9stUOsKrRuqzAMNrEt8Y66idGV3Lg/X6pU9c0eefePJWSNBEadXj71tODwZY0kdZZnThJyYu1EeZTyjMf4B6dXrBKKQfVb/7NzFuX7H7PWEC2t9z7ivfkvwqnnfoBc7OW+edYzzlTatRBdg6pkQlxbglhy88TAqF3gUZNUyfUAcXuZdfodCbDn42jpB1UbFfrNatsufCXc+UsLPZlgnbdKylvv+bQ1/vD6is/CfkPyW39ama51LBEHzO/a56sFXwAfWtOpYiKi2RWsmnnVFaRkdg6fKg5gWssoXT+ZBoLsDbv1MD416gi2bCgd4UE1xilA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afcd493-710b-4887-eb49-08decc44ae3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 07:47:28.5978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O9gooKNywsYwBILQ4iNVPnyN7Im4IUHoFbPz8R5BUtTIxU6tu6WJJ08y+eJRwtShTwjLd2PWH1Bd6P+feW1S+DSPBY6E+VLmZAgbyLXkDcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6903
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-300060-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robert.malz@canonical.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:from_mime,vger.kernel.org:from_smtp,osuosl.org:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid,canonical.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,2603:10b6:208:577::21:received,10.64.159.146:received,10.22.229.24:received];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4150697426



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Robert Malz via Intel-wired-lan
> Sent: Wednesday, June 17, 2026 12:08 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH v2] ice: retry reading NVM if
> admin queue returns EBUSY
>=20
> When the admin queue command to read NVM returns EBUSY, the driver
> currently treats it as a fatal error and aborts the entire read
> operation. This can cause spurious NVM read failures during periods
> of high firmware activity.
>=20
> Add retry logic to ice_read_flat_nvm() that handles EBUSY responses
> from the admin queue. When an EBUSY error is encountered, release
> the NVM resource lock, wait for ICE_SQ_SEND_DELAY_TIME_MS, re-
> acquire it, and retry the failed read. The retry is attempted up to
> ICE_SQ_SEND_MAX_EXECUTE times before giving up.
>=20
> Code was extracted from OOT ice driver 1.15.4 release. Additional
> change was made to reset last_cmd in case of retry to make sure that
> all commands are retried properly.
>=20
> Fixes: e94509906d6b ("ice: create function to read a section of the
> NVM and Shadow RAM")
> Signed-off-by: Robert Malz <robert.malz@canonical.com>
> ---
> Changes in v2:
> - change ICE_AQ_RC_EBUSY -> LIBIE_AQ_RC_EBUSY
>=20
>  drivers/net/ethernet/intel/ice/ice_nvm.c | 25 +++++++++++++++++++--
> ---
>  1 file changed, 20 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c
> b/drivers/net/ethernet/intel/ice/ice_nvm.c
> index 7e187a804dfa..b3120605d66f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_nvm.c
> +++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
> @@ -67,6 +67,7 @@ ice_read_flat_nvm(struct ice_hw *hw, u32 offset,
> u32 *length, u8 *data,  {
>  	u32 inlen =3D *length;
>  	u32 bytes_read =3D 0;
> +	int retry_cnt =3D 0;
>  	bool last_cmd;
>  	int status;
>=20
> @@ -96,11 +97,25 @@ ice_read_flat_nvm(struct ice_hw *hw, u32 offset,
> u32 *length, u8 *data,
>  					 offset, read_size,
>  					 data + bytes_read, last_cmd,
>  					 read_shadow_ram, NULL);
> -		if (status)
> -			break;
> -
> -		bytes_read +=3D read_size;
> -		offset +=3D read_size;
> +		if (status) {
> +			if (hw->adminq.sq_last_status !=3D
> LIBIE_AQ_RC_EBUSY ||
> +			    retry_cnt > ICE_SQ_SEND_MAX_EXECUTE)
> +				break;
> +			ice_debug(hw, ICE_DBG_NVM,
> +				  "NVM read EBUSY error, retry %d\n",
> +				  retry_cnt + 1);
> +			last_cmd =3D false;
> +			ice_release_nvm(hw);
> +			msleep(ICE_SQ_SEND_DELAY_TIME_MS);
> +			status =3D ice_acquire_nvm(hw, ICE_RES_READ);
> +			if (status)
> +				break;
> +			retry_cnt++;
It looks like you added the retry_cnt increment but you didn't add it into =
the loop exit condition.


> +		} else {
> +			bytes_read +=3D read_size;
> +			offset +=3D read_size;
> +			retry_cnt =3D 0;
> +		}
>  	} while (!last_cmd);
>=20
>  	*length =3D bytes_read;
> --
> 2.34.1


