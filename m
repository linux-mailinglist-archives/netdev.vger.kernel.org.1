Return-Path: <netdev+bounces-268045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IApvIFmzt2nUUQEAu9opvQ
	(envelope-from <netdev+bounces-268045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 08:38:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D12F6295BBD
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 08:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FB1B30427F9
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 07:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B624435028C;
	Mon, 16 Mar 2026 07:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eKs2MSVJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BBE34FF50;
	Mon, 16 Mar 2026 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773646532; cv=fail; b=HnRqd8sGOb873xGDarj9JbfpbNQqGNZsMrkyfmjYd2IyVYmgEX4QbOs0CD7jDCXgcjn0vZITknOYWmuESU1uDd4sp5N51jdEcZy2Q3NhiEJEKUPHQVBkiV7ufY9N3G2qMUGj73/tqE5misIkJN5QeOVUMqBtehEEmoqBNYHF/Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773646532; c=relaxed/simple;
	bh=DqHb8tjZ+fVtOvN6PrQBQRl9MIjiOxz8xYZQcF4M5Fg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tA+21WgLsNJOvXV7tE9Q2aS+pAdUXldI+FGkTVu2eyQWWnelU6o3TNSU5SYu6jH57kDp1kd8sbZpgObDFUGe749H41HlU5qTpI3CwdbAZJVeE1bCpPE0rbyFPOklYEse2GGInHZhaEC8ejz/b/leNHQ/OnntjGJQcppIvtYzHrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eKs2MSVJ; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773646532; x=1805182532;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DqHb8tjZ+fVtOvN6PrQBQRl9MIjiOxz8xYZQcF4M5Fg=;
  b=eKs2MSVJx5oWMV1YlfT0z84Y+SRtgPo5OIGe1eHdQUPQ52EOIiA+RaAc
   KfwXTo4Ip11tikgM7odidCN3p0kWt4C5DfCpHZx8VfdqDjk4E1lU6nczx
   TmrqE/HMm142XFyH0Wiyl/IxQRDfYyI08b2yCkk0uoWT5/uikEhQH37an
   1Bwln8LMOl5z5Dp2jII3UML00E85ufVX19ySAHwjK4JkxDT6DwW1IRLN4
   3mtI4kBBxK78OROrclljSSZuYurWs47IydPEP5oig0uakhjwXbfQN+Too
   RC+M0dm1ArHNFQ6VMnh8WxEQlL5agpz7VywZr7UIoEvhrdn/LR8coEjLa
   A==;
X-CSE-ConnectionGUID: TyAO35gVSlOESLZaO2XG1g==
X-CSE-MsgGUID: 4Fatl845QpKnLGDMtKJxaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="92040128"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="92040128"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:35:31 -0700
X-CSE-ConnectionGUID: a9UM6hpaT2KjPmoM4aRKBw==
X-CSE-MsgGUID: C21CcKtpT46FOMV/AmR37w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="226498944"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:35:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 00:35:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 00:35:29 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.12) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 00:35:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBrlGkHDN5jueE9UgKAtEtYWpSHGeft+B1ynWK4YScAWk/amf9tdSCvNggsdzt17W1rzB7JWwTsR/E5k4sggRbtSGGNP4WLBRLSdl55FzA0EPAptK+Bg7XfI1Gt3UTptbISHtthL9PcfdEZmpNFwCQ0A3qQ+HS/020CMgkLS2bui90YSgp2DVgMxJt8J8zoIeJ6iArGXqszmNb9yRUdwHNAniIiqRavoYCoXIzaq3pVW66kvpFkb3e8N3qmGHt3UaOmr/fGp7WuYwhwLQ/4OVAKMC1s/maYNXMf7bzQCrVB0w8lyUtTefY13G3xloHdVoEbpGI1WWd8psMu9UXYwCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7IPOrGnXcOH0Ro1L2enHIO6lNnNMSijNX6DXBPRUAo=;
 b=nwRc31rNs1Wi9h9oW/Pe/EF5xhTvbwfwWPju3MwGzESXDpiH8zhK4EjyW3bsdtMDje033V2kJkQ71aAVhXkjYWspUs6z8xBGHGByB27m62ol1sAQdrLgrSGOw0kBB1DGSO8x7RMp8LzOmtInAw1NpeC2G7g0u4Sy+OuBZHS7ACwEksnawskzC/2uERbtcJUlPG/GEN5nENxkq0Tt49NkhMx/AjSc/eQsrbeGLpY4mnxH/P6WPNIDhrOLZ0mQW+lJ9nPNCNCfwkx+XhNgvtVPQV0zmoJ0pFsZlpKenkm4Ig6lMRpul7Pv8AQrRewE8ApH/9A9qPz6fCR4QSE1uljrXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ5PPF263E38237.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::81a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 07:35:26 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Mon, 16 Mar 2026
 07:35:26 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: I Viswanath <viswanathiyyappan@gmail.com>, "stfomichev@gmail.com"
	<stfomichev@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
	<mst@redhat.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "ronak.doshi@broadcom.com"
	<ronak.doshi@broadcom.com>, "pcnet32@frontier.com" <pcnet32@frontier.com>
CC: "bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v9 7/7] pcnet32: Implement
 ndo_set_rx_mode_async callback
Thread-Topic: [Intel-wired-lan] [PATCH net-next v9 7/7] pcnet32: Implement
 ndo_set_rx_mode_async callback
Thread-Index: AQHcs+CUdyGGjCf9KEWpGI3KA7aNNbWwxxZA
Date: Mon, 16 Mar 2026 07:35:26 +0000
Message-ID: <IA3PR11MB898646CE49657F125B5A0349E540A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260314182809.362808-1-viswanathiyyappan@gmail.com>
 <20260314182809.362808-8-viswanathiyyappan@gmail.com>
In-Reply-To: <20260314182809.362808-8-viswanathiyyappan@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ5PPF263E38237:EE_
x-ms-office365-filtering-correlation-id: a4ebf12f-7429-4fa7-98d5-08de832e9734
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: f/SDTvp3h5C+8RY9p5JWkiBnPYHmcpbo5AuFfviJcX4e0Z4frre3r3KZd8QjRWiRo8DfWvK64wm2aTYX8/578qrzxHvm+CPdDZoydNZ0VPzeYbVBn2xriamskfv28U/avJh5OBVviVO/JECVgiTtx4wYsKbzqqZ6Ivx6cb0iw6w/sFmCQt3UnADVdQZCHrGf9rGc5KXZZSbOPMZn6l6r4uc2xDyCZ3ME+MxGEwgwiBxRkf210VN1HEVNE2tEitoEyCkbJIcayFT5VkDWoW8Q4FMGqhiqPTE2khI3Kji7kV9YfGe79UWHHNc0sTxRzu/EwhPNZb+oBe7MCbcvc3HyXYXi59ekMrTI6/i08fybZPHOoYJwfEe+S97hq2AezrJl6MpptuLKBqUKHXI0AFiJoJYpENTpBK/hMTMK59EGt4ka5OWhXjGebKLkc/5AQpAFu9T8l/mmnyWD3Mz9bF1Dlbg9SgqFxxeS7i6jb4b8bcTpidXm5CnBaYNB42BDGZLcZcpdwg3//Vuw0iLJqbHU/4XYenIy6io673qkukYLRcSKS2mC0BGnLCKKI3wkZz9nwgjyn9xgMV3O/X7+3BxdLeJPYFz52enbWdNnlswiQNidk/lJwv4jEzxU6I0e2b4+93Q+u158VPkq0tNOEzqwvGjEJ8D5/CtpvxQUnWWAgr3RHBlC38g4/dcNI7LoDB0r+fvOxMM0iPug/6zQvyUtXZcIUzgPmJIubRSx/2TuQWu1ju7kzTfTM9dfDnrxhEiMOtNcO5Z570EGb7uCxOLgmb0OLKj82FLlxmYoED8g5w1xMPo7Lom4/WsWMoo/7BvM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m+pm+tuv/HRz9qkCxj0Tr+m791JBIxhN8lQRTdnvjo6BwbMRV/MuczEiANXg?=
 =?us-ascii?Q?J014cnfQeJ7k7HEIqvNy/XqChWO0XUutWqXZBl3Vj7DDjeuMyy3L3GSCWjF0?=
 =?us-ascii?Q?AiYt5zSe2dwffUI2W5Rz3PwjfsvDqQNWSfcPr57lOS9RppZFdhqYAItBdrc5?=
 =?us-ascii?Q?Z0fAwd4WKnpUa/BT6lV3ToNGNQhEKqgNED0oOnSuHTiuyMjDx/885gnjqnew?=
 =?us-ascii?Q?yutUgZAffm21Snm0pHF/CCDzlIRYZHYyjyvRl4mShyaUsysP65aeWvjCmIlj?=
 =?us-ascii?Q?8y49FOHtoRS3dJfj8fCOTBDI8xzVATbdq22Mvyz5FlRWyQfgNJ8tp1Vidtk7?=
 =?us-ascii?Q?O37rMURGnFk31AwsEyc8udpP/MAHagSxEd7plavcJb0L267bvOsOOpWehH3a?=
 =?us-ascii?Q?KWN7zBIp19G31Prg3Aq7XCW/EM9ZJKXMOWiZROP9ANjCo7obDmsqt8/ouiNo?=
 =?us-ascii?Q?ZnIRhL4SB60T83E1cWzTF1OCCEJZqfTPq/50OsKYoMnPYWj/LPYHZkK5LgYC?=
 =?us-ascii?Q?RiAG6xbar4oiTocby74GhmkfIIPuLdm9b1dKk2AzxjGDa67p71IgAX6WFeoW?=
 =?us-ascii?Q?18/Fm1A7IOqAWYOx7lnYnU8ktXIXI2feJvmkF7dVWf9eq9PrDaX4e4LKSZD+?=
 =?us-ascii?Q?lmGoPxpD2FslA2oaR6NPzZuoTIbpwcD5JTIGelrDgIp5b8n1CpPrgBaLMZig?=
 =?us-ascii?Q?x4Wh0hbTh4GKRxCoZJrLPpJXnAgLJPvZJpA3x0XaGpO0sk1Q08MxKXwEsWJP?=
 =?us-ascii?Q?Ha6UVqMCs+FYoYnSORGTG+PGcEkqKpAs6yIwTaF/MUVuT/F+BBNxIU6WNE5k?=
 =?us-ascii?Q?CfKQzguMMLPWwFI+D6tpNEG9PIIsbElgusse1pddbReGFd4VXe7IyFgNBJWt?=
 =?us-ascii?Q?85TzCg/AHFjZb0qBdPj0WDFFYDVX5viUCm/eubmtb+kLni4DPdM5aTO0aoXF?=
 =?us-ascii?Q?9z9/2dzLhXH2JQ1WhGT4+Bkoa8IJFEe+u4+9GKnhKoh8ED47/LXxPeYpjqaO?=
 =?us-ascii?Q?yYsrJxCPlgMfMAWy+pO0TB2Vod9qJEPdP4L5ClJg0B+XXkJ2hmNgkUKIpmvj?=
 =?us-ascii?Q?AJgCswxhw0gJWvObZC+bBuY4qKlej5cwWfdhgiqbcjVyrwzYXqTO7qpuz/XL?=
 =?us-ascii?Q?CNl638FukXDhQYMgSA2t4Wp5VXsmFsYF3bKE/XGMzFCqltUE8GtxGEvQ6RcZ?=
 =?us-ascii?Q?ZcPkGOUqXDak071rzs14P+O6SOssPYYl9W0WBUVvK3LuIARV4K1vmJnd/jWI?=
 =?us-ascii?Q?UHuyi/t2SxI555A0R4FeEBclZaJ5RqA7T1NvOG4y2wo/iSYFSUwsMJhMeLpy?=
 =?us-ascii?Q?VW9aI8JuD6PzgmyidKO2xAY0maKgT9B7greM+Wk3J5mdyKr3BGfFKdo33EJO?=
 =?us-ascii?Q?vb7dRGr4g51pGLJNRhufjkpJGJLv2XETNbUfFYpdWqmL3n8+R8wFjknHf5bx?=
 =?us-ascii?Q?USQ3kcBHQMU+H/wirP+Ow8BHD2iIYZkzKTIDe4Y38qr8D039cZ7UheA8nmJF?=
 =?us-ascii?Q?fJqZva1hKiK4Xb6abiwnZ9svdycy7PbBmIA22BlTGN7nrX/T6b9UZFOGkj13?=
 =?us-ascii?Q?VQ+eAMWpEDPX7evfoKcLUv4hw07Jkodtrglvki+cxC3/HXfZ/YWfhRU+dyyu?=
 =?us-ascii?Q?en+HPZTVxf6tW2qvcmlkUbnaHGMFVOQ+dEskg4zsYLBAAdSAZFnzwQE47fj+?=
 =?us-ascii?Q?f2zfyyF9VAcCJyPUbsu6yr8qOmT5DAigCa8uU5x7odntZE2q81csqgWII68E?=
 =?us-ascii?Q?Rz6/BolgA5rQjFjeZIOGXenlRTCxQG4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rTZZ98dMWXr9GbBP1yzeusqFTykHAPOkHry0UJIWn0VtHIGzQ024+xEMtbcA7tPnpYx70gI3Q/FJkKr/M02wtMrggNaXzp1kowWa/swkviEQywVrBNh0MbgrEBS3fGIhgSyJW2QtVuCo7gbczAtGxfWKkUAI5Aw3jLnBP3PFksUBXgX8eKwpaIpuHRVtRu5SgCjhiyWfVIKawNjGPvI2dwO6Ee7F8l26hjB0G5PZicCeZbWH0amzq8W/hZk1Fb5ECEfzDGCD6D864y+eCERqYug8KwKdFqfcBBhwxgZxFJWsz9HgB91KcExgaMtc5dA8rSGupFp/fkC1g0C9GiQaXw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ebf12f-7429-4fa7-98d5-08de832e9734
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 07:35:26.1350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kUEwouE9UZCF+AytWnJraafuCfidpy9ZuVxUuU51xuEPz819moysmq62gTWgQkCpn5Dn7WX+NBoyTiKqhwLECG3nkp/iInGXEnB+KafL+qI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF263E38237
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268045-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,google.com,redhat.com,lunn.ch,davemloft.net,linux.alibaba.com,intel.com,broadcom.com,frontier.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D12F6295BBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of I Viswanath
> Sent: Saturday, March 14, 2026 7:28 PM
> To: stfomichev@gmail.com; horms@kernel.org; edumazet@google.com;
> pabeni@redhat.com; andrew+netdev@lunn.ch; kuba@kernel.org;
> davem@davemloft.net; eperezma@redhat.com; xuanzhuo@linux.alibaba.com;
> jasowang@redhat.com; mst@redhat.com; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; ronak.doshi@broadcom.com;
> pcnet32@frontier.com
> Cc: bcm-kernel-feedback-list@broadcom.com; netdev@vger.kernel.org;
> virtualization@lists.linux.dev; intel-wired-lan@lists.osuosl.org;
> linux-kernel@vger.kernel.org; I Viswanath
> <viswanathiyyappan@gmail.com>
> Subject: [Intel-wired-lan] [PATCH net-next v9 7/7] pcnet32: Implement
> ndo_set_rx_mode_async callback
>=20
> Implement the ndo_set_rx_mode_async callback and update the driver to
> use the snapshot/commit model for RX mode update.
>=20
> Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
> ---
>=20
> There are no calls to netif_set_rx_mode in pcnet32
>=20
>  drivers/net/ethernet/amd/pcnet32.c | 65 ++++++++++++++++++++++++-----
> -
>  1 file changed, 53 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/amd/pcnet32.c
> b/drivers/net/ethernet/amd/pcnet32.c
> index 911808ab13a7..d5ad96985d68 100644
> --- a/drivers/net/ethernet/amd/pcnet32.c
> +++ b/drivers/net/ethernet/amd/pcnet32.c
> @@ -314,8 +314,9 @@ static void pcnet32_tx_timeout(struct net_device
> *dev, unsigned int txqueue);  static irqreturn_t
> pcnet32_interrupt(int, void *);  static int pcnet32_close(struct
> net_device *);  static struct net_device_stats
> *pcnet32_get_stats(struct net_device *); -static void
> pcnet32_load_multicast(struct net_device *dev);

...

> --
> 2.47.3


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

