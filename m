Return-Path: <netdev+bounces-273693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNKME/P3y2kXNAYAu9opvQ
	(envelope-from <netdev+bounces-273693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:36:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EC336CD17
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D6103002D36
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3F23DB62F;
	Tue, 31 Mar 2026 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cw3oJN6I"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F382D329E4B;
	Tue, 31 Mar 2026 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974171; cv=fail; b=EgB4W1xtbj37mR/8QE509YXJkn+etPLN7+gwEeXA6CAuOkVVEv9v6Dky7yVI3z9KSNfFFVksuSYACf4EZ/RrhmmY+YmfMZhcCU6i+DDV2UWcFLjJ1ZRxJJ6tQ7qmev3RJcUMHCcygO/PN5fJBhTW1v9xlETYVdpYD2NFGxngLFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974171; c=relaxed/simple;
	bh=JVVYNj73Ml00hHZnn5m0H0X33YNBG1KOWpYI8rr02Y8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eG6r7Nv23sJFtMjYyPfJ4hFkyw8yESkANlYPf2IubOduiAeKMB9rNj5vDWCmz+a/A8uKKlyknLAUiIqglLU7ttmdp/jmP4y/LV1l9DCYmAUHljr8l9kEiFRIA5UHBuIffdJYEofhGUMePt6YGgoOcecuuAUXG70l66Jw/v6mrlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cw3oJN6I; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774974170; x=1806510170;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JVVYNj73Ml00hHZnn5m0H0X33YNBG1KOWpYI8rr02Y8=;
  b=Cw3oJN6Im8szkRlOW5XeWidlTRv4gdtE7HNOl6KsRf2Bmqbu6ixXPpu/
   NQoBH8GazudKVRja3uGsgormI0Gp1mAtrcHwWBH16RlclEXmbFHKXvchH
   eR+h6OpZ6BI7L8KlaY4L7ihADJ2UiSqQFpYVqET/yEom9nQSP49XzmNca
   SUX5oYURub9VKBC9TWURorXM3V9rV4AWeseK8Kh85gjuYPDjvqGbdztuU
   cazOAr0C9lm2QXKWPAPpuKpK8XpxopGywim3OrDydxcXA4SH2xPZaCRBX
   ciJjL7VhoZHqi2OyBOMWpK7ENbFY0ZeFmqpGZ02MCVJBvzV+/eej2vVQI
   A==;
X-CSE-ConnectionGUID: 9Dqcwv5uTC+ng5qTXo7I3w==
X-CSE-MsgGUID: ahv5l2CARrqSJFA5H4nf3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="86608391"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="86608391"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 09:22:49 -0700
X-CSE-ConnectionGUID: g1VpRBIpRvSq/MS6bL2iwQ==
X-CSE-MsgGUID: +WWDYvCwT820HS7AS+X3jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="249624550"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 09:22:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 09:22:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 09:22:47 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.12) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 09:22:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNB/koRYDxMMJlOdaTs9jEY3vnFvtL5Q3gw+wTqoMQ6uKEy2fTmlrzSxo9YJYoyt676mDLdtO1KRcCauTrCJC9HRocLy63GoF+oRAe0GXUv0TmyBmKbhUVlMlCLexlVc3Z9MSHILXgcUn7RFCNpFhNA8EN6upUSzW5NTDUp3JUNS8RX3itD3Jf/Wdz+wCJJIZY6LqMPAShEg6UyP2hJpt3TGgQmg3yr4AC5NNiE87y+FemX2e8O+pKKw7c+BFG1vglBDAKMnBDrIZ73p8oeUf4MDIxxYwC7ScGAzgg2GISAw1EMbr0cw33MgXbX1XBslrlDCYeT1vr9WUAlGzkkZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVVYNj73Ml00hHZnn5m0H0X33YNBG1KOWpYI8rr02Y8=;
 b=LLuTLjaJ0v1jtRGmdj5MtnBUm0+PtAU5bOJQ7fuJtQXjQNqDJnPtnDrHBreiPqxg0/3Ta3xouRcvlvD4b4Jk7jBAEu2H4P8JSoXs7Ljh7z7KLZNLOTniRv7Gjm0o4oLeVSpFmLAHDZkAFN/k3nNynNnpL0OKqH8rQZEV1HtPUb8NZXfvLmzI844BN/MyUpQq5HT5LOlf5Hh0eUydWYMU7tNf8SHJ7IOpT2FBht32uKZtuWbPhwNiQzPHpfGek02vrsnPamUWkf7LLc6XR5/rK6GwEAd/W2g5mAbOE74oLEqrvsSjXYOsGIsHKcvlGcOc61nY7P2ZWbg4HdYNDuS/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 16:22:37 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::6f05:5b37:2440:556e%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 16:22:37 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [Intel-wired-lan] [PATCH] idpf: Replace use of system_unbound_wq
 with system_dfl_wq
Thread-Topic: [Intel-wired-lan] [PATCH] idpf: Replace use of system_unbound_wq
 with system_dfl_wq
Thread-Index: AQHcsv7J4NzZwpMRNkmTVSSFBKZDsbWsoWaAgAGS2QCAAzH9gIAALXCAgBdbQ6A=
Date: Tue, 31 Mar 2026 16:22:37 +0000
Message-ID: <SJ1PR11MB6297246F8ECC4868C05054339B53A@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20260313150917.271086-1-marco.crivellari@suse.com>
 <0ca7f92b-ec4e-469c-ad2b-648d278bcfe9@intel.com>
 <20260314091048.235a6d0b@kernel.org>
 <878cd07a-b7fb-491a-9cec-8ddbab2bb13b@intel.com>
 <20260316124107.0dd3cc2b@kernel.org>
In-Reply-To: <20260316124107.0dd3cc2b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|CH3PR11MB8383:EE_
x-ms-office365-filtering-correlation-id: 32be1fd9-8230-4208-c028-08de8f41b8f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: bK/mT60iU6W1yfuE74suleVCw42XX9vMbAeYnC+dYP1MQK6dafzl9oHNR8LG8LbcQHRB1U7HzBT4eIXhJaumRYaKAQRsZknjqCfKBB2hGBhnnxzqttCi6YcR5E2MDkjWW0tgg4WLeqcMFXd0XRpNI1K4X9M0AniFqAlaFdrvvyIe5A97JVLZHkyMy+OG5L96qYSW+tRC3sQ5eZCv5bynzK5If6wFsJqZSohfPlV1QSy5ZqwodyT68IQzwsJskXRBxicttT5f8ynE7sBMli3B6xfc0gru4jncc4sWbiFUXsoq3iTEWN5fwNUkiYfZ/wjGFu/XY3v7FUkFSDuofY1zlLgiOakZjj6zGSFSnnjLbRZ1yjCy0mspy26n3hOAtWGXPixu3/3sil1ykOOa+fJ1kit6FYMztAZ+6QNWA35bx55n/g1edkRWYg+ckGEW0sZBdzxikQ2sme9155newMlzxC1ArkDCL0ajheLkRcxEE5vT26x+ZHs1N8v7UxGK+PgD4iJ2vWTURChEponZ4UL7+dXNgoVsLXbq1F9Fl6HX3K6wWrBrstU6HNxgjzAUO5KQqy1Eg98ePgnebhcdXZMG2wtQTb5vYiD1fQYcyR2E6AqnpYDWYq+1x7yqsxgLHDxetuN0yLJ9vWU8zWAEMv+oq/7ZkX9xBeeF9oBNOfrupA4OjkNzIbevBR1AGiewPnqpyRPLr9tJWJa8UESXtR9VdSQEiJCgAZXQ/jtfmZaD8b8Px52IZH+yaIQCHTshokOkkcXazM6QRCwhI4kgkwD00sbhQkotmRzoP8hf8poJwgA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hC0Sue80cHgOV7KAyziSbDmVn5pcEIyKgrdN1ZY7r2dG5LuX/9ZrV9rxklBd?=
 =?us-ascii?Q?ifbx9XqbPncL8eRpcNwn1mfwca+8bD1hiloa7Gki6ffHgX2YWMXAWiI7GAq8?=
 =?us-ascii?Q?whxo2yE9EIVvvcRquhz/dfyL9SWlt4t9fxHweWfAVXYPnLcrWbRqYtAwPhIG?=
 =?us-ascii?Q?hG1qU5+7lViJ1g6ZYoO2XvpzNJOD64hasctt6y3yk33pVLZq1t8WEuGIWTbS?=
 =?us-ascii?Q?z4fpNda97drNHngymNpuL5IAV2kfQOqMz3sFFrX7E6rYCo/LX1zQ8ssYTdcn?=
 =?us-ascii?Q?Pt6Cs/Uc00YIaxX2u9aZM6CJ98IGdv920v6Bn3euI+7P2fJgyIhCJAq6GhU8?=
 =?us-ascii?Q?dnbIvQAFcEJzvlcxNBJPzvwHjM/Sz7vt8bbSCOhHqC0uvmw07ySlDzg8y7XK?=
 =?us-ascii?Q?FQjlEuVVTl24xiGbbFOlbXG51biIfDqENqQg9WfrLWo5M3WYJ0MLjXx/Gbrc?=
 =?us-ascii?Q?8/rAaPxSgxzwaK6rr9Qji1UFbpPK7TPDxVQ51fZ6A9exOIm9JylEttspSt5X?=
 =?us-ascii?Q?iMpPq3dxfo/uDDaQJwS2ThtN9BcUSGnbEeEvAqzpNr3vQH7Yp4p35DVPUAnh?=
 =?us-ascii?Q?sI82VLYg15rDrxqzHUu7hisrCNFBq+1zYAJNZdQdauWmkz1XLuiKL4u3F5Yj?=
 =?us-ascii?Q?ffubyPdsxXzyfnc7XOWXSY0Qlfm5sxP0QfMEUI/guv1qKjR7KWVY84dA6q6Y?=
 =?us-ascii?Q?visHKlJJ0y0ht6aFcBemFGXGrspEtIlf5OlobSvXB4rk5xpnyuw+n9cfYKHX?=
 =?us-ascii?Q?wxqr83cBR4LR+qZU52iCPjl8Z3PJ2y8iFN1bofaWI0EapmOfox/1v+9rPGT7?=
 =?us-ascii?Q?f7WY79K/13fweMztZ81l4TGUJevsPpbgEkRFR1dFQmab9ZNYARYVMlZVCCX7?=
 =?us-ascii?Q?5u3ZZ5IXGva8GBCoh6KMkaW0yq0r+Dq9TnI3w96G2y/nbyRPrfWxbcgBMzk+?=
 =?us-ascii?Q?lpvxQNBw7qBDHN//uzdvDM0i3OzsTEL+65iDMglwjSiWwgtTyDu5ac3VnMQA?=
 =?us-ascii?Q?6DIpZzJMsFT8SXI84zDXO3qEMDCTRur5+efjk6xiNgCUcKiZG74Or+HmjNKS?=
 =?us-ascii?Q?sdLWpyg6vXvzsRWcY3T2eJjRdEGNkZ07LJeYighZDfNykqz/2xC4+LinWrqN?=
 =?us-ascii?Q?XclpX3q2/1+HZP2z7gtgKEdrJ64G7SUF9hXy9plqLHSO7XRfRb+bE7brUfMG?=
 =?us-ascii?Q?EdnScVrw7aCywKrlensmqZCynM7yupJ8F8Bxq1tJAPu/GvDViKdFPp7rUxFy?=
 =?us-ascii?Q?93LWK6BnmbPx9ux/uQ4H+rVOAjdqThnT4Gbm5Z9p4vMi2TRvlw0Zm69arOQ4?=
 =?us-ascii?Q?sa+GLUh2ObOx2vV2ysKh/aNkdFYjYooU+NNxe7WrYzEPtpPjlBaz3LPZXS3w?=
 =?us-ascii?Q?8IalY7nmeYwrtQ6604wpfUJI3XeNz1bjdsLKQpouKFNuBcM8IwVF+aoiAujq?=
 =?us-ascii?Q?uHFBTRszMm2N+NOafx7NfGTa2m2fQNgGjogzNblX1naM6gmrqONaTpYII5KI?=
 =?us-ascii?Q?WGr5dPBQ/+Twqzcn2BVLnTeMTS3vws6z2fK4k/ZMi+QxsFl9L0BZ7YMSS/3P?=
 =?us-ascii?Q?MkcqD+siA/KWViVM/QThZQGsJiDV2572iXAbIyMu/nN3VzkH2Ss3/kc/BXd/?=
 =?us-ascii?Q?Tj/gEhXlgVGH2OLvnySWAm2HglYpgSwWMYWqYKDlrkqunrUq5gFQkTL2WqgL?=
 =?us-ascii?Q?aDOaLaOkCMjT4HEboHaF8YpI2ny1BQSRZXZj+Bxcp6XaZpRjwJShZPkHs4lf?=
 =?us-ascii?Q?gVtIB5/p2Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ie6o8p8dqKsvCozyWiHyOTXElQkM6YPd2wKMXzqb5NoY7bPo0CAr/gSDbqOZ0AgX6Nm0HofU1Hb/UZNJ9xGdfR8VOIg1ZerwDhz4Jm+PaCntR389A3UXcMmVoZQ1Ix8QNYBRu9qKRvNPnyhFBBzHUi9P2uMcZmB5KKMmVCByp67C9rEe5oo8sOngx2AVsyy4jkDIs0e6qFEsmZ0HqgLuaSYQW3QJ3kr9WPzEhsBHup5WK7BJIthnvZ19aLWCSTfa7njfe2Z7tWP9IDJHIfnHvGvd9BA2xSFITT23TdgZi20rvHn4hLCaLJZO0KnN1Fh4enI+nCK8OdnHJ5UY2Ebb9g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32be1fd9-8230-4208-c028-08de8f41b8f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 16:22:37.1330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MMBTkyrq/AaVKUWDwIgmXQAoeMas0V8A2KDxuhyX1W6h2J5V8uOT+dTP6L8nOsFuD1ws1A9lMcun1jbUDlr+qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8383
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273693-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,intel.com:dkim,intel.com:email,davemloft.net:email,SJ1PR11MB6297.namprd11.prod.outlook.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[samuel.salin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 43EC336CD17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jakub Kicinski
> Sent: Monday, March 16, 2026 12:41 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; intel-wired-
> lan@lists.osuosl.org; linux-kernel@vger.kernel.org; netdev@vger.kernel.or=
g;
> Andrew Lunn <andrew+netdev@lunn.ch>; David S . Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Paolo
> Abeni <pabeni@redhat.com>
> Subject: Re: [Intel-wired-lan] [PATCH] idpf: Replace use of
> system_unbound_wq with system_dfl_wq
>=20
> On Mon, 16 Mar 2026 09:58:29 -0700 Tony Nguyen wrote:
> > On 3/14/2026 9:10 AM, Jakub Kicinski wrote:
> > > On Fri, 13 Mar 2026 17:08:57 +0100 Przemek Kitszel wrote:
> > >> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > >
> > > Process question - even tho you are also a maintainer I only read
> > > Tony's tags as "please apply directly". LMK if that's right, I'll
> > > try to remember / make a note..
> >
> > I talked to Przemek about this a little this morning. Since the
> > Reviewed-by tag is used more prevalently in our process, perhaps an
> > Acked-by could mean take this directly and the Reviewed-by keeps the
> > same process of going through IWL. Other thought would be to
> > explicitly ask/state for it to get taken directly. Open to other ideas
> > as well if there's something else you'd prefer.
>=20
> Sounds complicated :S Let me continue ignoring Przemek's tags for the
> purpose of direct application. I guess it's more about who sends the PRs =
than
> who is a maintainer. If you send PRs I naturally never see your review ta=
gs, as
> the patches will eventually come out with your SoB.

Tested-by: Samuel Salin <Samuel.salin@intel.com>

