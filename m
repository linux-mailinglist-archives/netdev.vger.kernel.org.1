Return-Path: <netdev+bounces-273970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Fq8F+PSzGlFWwYAu9opvQ
	(envelope-from <netdev+bounces-273970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:10:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B55FF37683B
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A66E3177F9D
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BEE371052;
	Wed,  1 Apr 2026 07:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E5nFnIwJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE8F36BCE8;
	Wed,  1 Apr 2026 07:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775029985; cv=fail; b=RHaGIP7LdW8t8ZHAkTAZ07l8AdFMHthZ4hCcwJwYtL+ZDoHViEyFHx9sOyxDDD7kaCRnQZlek8KTYnD3U23+mNpbYxI7BjBlBQ9hRTavkLwFKszrPsaKu+QXCnO9tXwwvENANx3OTJ+kWtdzMPFD/2f3GGKoLwu26+p2vt1hQmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775029985; c=relaxed/simple;
	bh=sPa0+BoLYaSDfofvlwHmmIEBubwDX1fbMg9Mw5jZGSQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MuOwcZDDnpgGe+3DQsix8clJ53Atm7Cq4pJ8iOWX1s9NneaRc1l1DjZYzEMxx8yp/jvb+IYhgd3NkdKbPMa3R5Of2yNS169xWVcDwfK1gcdltBr1k30eCtxyx1yr28eLL2m9sxosR52sewmMFX+VwOB7nwi82yYePsLVIcLSnbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E5nFnIwJ; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775029983; x=1806565983;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sPa0+BoLYaSDfofvlwHmmIEBubwDX1fbMg9Mw5jZGSQ=;
  b=E5nFnIwJVOL0tJivV+R2WynAM/TXrafMunQgWXAHVG+cafCaMnam1uF+
   FcCohz8hMIIhnjMrYM2myUe26pix1bTbFyZ/bxNmrl/d2xe8EsrBzQKzU
   3SojmMZgblb8mPM/VWRELMvnRj8C6N+HbATkGYro0hbCMnDF/2AyET2SF
   6/pnyeHAl0v9gBoc48bEVzpBj0axiodOKeZh3c0CVgh+ics33R4pWIB0F
   9/Ops45e2Nm9YhIlQh6hJb53asjlTAaARLY4m8p8g/pNja2VzQFcxiGdI
   H9Dcmzit72/0UXvxScZ2o2OlH2L0fCcZ7/4BFq7qvvdkb1Rp7opBEkq1R
   Q==;
X-CSE-ConnectionGUID: 0ZIRhpjkTqicgPQtzr49qg==
X-CSE-MsgGUID: DWbi/Ai0S/eDjGsRtLyMRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="93452087"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="93452087"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 00:53:03 -0700
X-CSE-ConnectionGUID: U76yRrP8TC6Ah4ad+0vH7w==
X-CSE-MsgGUID: CrjHQAODS0mqG9QQn0LpQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="231021356"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 00:53:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 00:53:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 00:53:02 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 00:52:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fb2r3Z/wDfWLZKznvbtSQX/+mYAc89dXasLSVjmzC6vg3VtBSCcmLv8juO/PUdWSNCUF7YjXcrYq0OsugVlZ3nIRroQ5QOoJE+ssxFDGWrXMgvKKqzvrYmTxUIlKBdW7vjZCBgcI7vk0DQD4T43tby/kJ6sMTYDvv40AWi/LyWRrumRCXl5ZFjmpkAThnu/AIgizsuIXCwBxN9k7fmQha7q/nnZF2Luo/6QIzNFFF8/6R8wpCee7z8cbA37MAWrpr4IHZlNjWaj0wyrygp08NhVYYZViaymuxQ15VVadoNRk2KvsbVEIWtmweYWa4P+2NV7sVcRPKY68sZx8rrojcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnLqsmTednL/LzWrMhLmFWMLEPubVcbDGhO4xzbcn1w=;
 b=OnUEv9+gq1Qvi/BN2Wx6SFipuLatmeJSj8PiIgpQYBU6FzC5SknJisyBMY7kNryJSf318GyRITCLi2Fdh5r9Lq6YLfQ9a3yA8kaK3xwHL12PAhq79JxZaMvf5m1RZUMuQRWaMFsVXAu1TQESIjkYZ3cb/IPrh4yAI8UofVtGKRJv4cDOPc+fuP6F9HyZdfwgmqg9APoo3YS2/C/Yo6mylmhS26okPR3uYWtyKtHn7WME0Fhg/gd3WWj2GwV/yjUz78DSxfzN25foM6HWHcb9CvuLL0nhh7y6O3fCs73vyb6ZHNF5YTVvo9qeftasnp2ywCMxziZmgxLbDWiQt7GPFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV3PR11MB8556.namprd11.prod.outlook.com (2603:10b6:408:1b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 07:52:54 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Wed, 1 Apr 2026
 07:52:54 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Daiki Harada <daiky0325@gmail.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kohei Enju
	<kohei@enjuk.jp>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1 1/2] igb: use
 napi_schedule_irqoff() instead of napi_schedule()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 1/2] igb: use
 napi_schedule_irqoff() instead of napi_schedule()
Thread-Index: AQHcwSMmF+rqm1qaS0ymJ8GNUovbGLXJ1r/w
Date: Wed, 1 Apr 2026 07:52:54 +0000
Message-ID: <IA3PR11MB8986F7FACEC1C5866FBA0146E550A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260331103924.36422-1-daiky0325@gmail.com>
 <20260331103924.36422-2-daiky0325@gmail.com>
In-Reply-To: <20260331103924.36422-2-daiky0325@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV3PR11MB8556:EE_
x-ms-office365-filtering-correlation-id: dd0a824d-11b0-4ea1-013b-08de8fc3ae7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: TA/vL9egpCFQR+xs8YHPF59uzGkcFn14Q5fR6TU7m2tBhzDjKmjoDjF7Fpazu1HhSZlpH89OVQzb4ojLIcMM1wquqPBWRi4Nf7iUo1do8RC3T4gwBSQPD7rIGsioPx3cEGt0y+tgpvmfVYo2tbxvF89RLli5V2gmjQ3KemZ4uGFDsOOtqXUbAovryirhgHHRQOfObZY8kcMF25OhjTh0hwQwJWGDnLk95jW/VRVx62ejJGIUm2+VYb1UB9cs1v4camWzofsef0OYwK7UdOBoKNaUwZyktG8PI3ZWQyq8q8YgfTgIzLxAg+Wc+U7S1cO1p9IAdVpt10MJCu48xOBZrBMJ8imNkKiP2IDPN8OZzzgGNjaWOJSk/pPdlWiCTXmiB7nVMd3OFx7Oy7E9JW+bxEotnkuyGfQb2ndnPYrJL1NF7oYc+3W+ew9ISKFkGs+Ai4xpgISCn/NEcKUdgRaSxb2L2rmQ3EuZQ8+tz7JmCwwrmhRonwioIt2NxfTUg3gFbXxo/eNRi+HmaTPCmeYS8ARHJZ4rOD4UN3QlA0B6HFslG14nPKl51RsPoLu9cFGswjdeYVGWc2hMuIizcgjv9hRduN0DdB+iKAgZb88yS//UREjZDp6eyAt4jyQveu7PTVg9uh2RJNs/jdrHXThSddpleGMSDUvsPYPOdpWSSpr/LXBrIQcN20qA572vA9aoUVkQTTVIvO32tqnwRQe54qB+OqIejO8lzFC1XtxV75IMlYS9SPAIuMWshfU1qB58sO0M+eMv740LZHZiQAPgkQf06q9vVKrf1gpwWj5lusk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xefpktewHjBaZvaXHh4Mwmjuebl6/fQaMwSKqOFoZAtzCFow444Jq5z7PkR7?=
 =?us-ascii?Q?jZXIvRL3s1zgedjhx8dduEgBuJVtRgXaDIZnR9YZmwRnRvBW1kbrJJ8/gq0x?=
 =?us-ascii?Q?UcFOxyH+gMJ5HeeL+VyVVDx77nL71J9G1buSprbxqy4KP83xlokFyM1laSn2?=
 =?us-ascii?Q?DrwDnoTRKAw/W1Aow3RM6BPZJaiFsVU7QD9CmIqH9qqqqDW0OLOuGEmHLRYA?=
 =?us-ascii?Q?LDCj/jva57SdGymAj0drp3CnY6QiH0wOxSAQTyNSJXYDiXm08UEpDWxlGTH+?=
 =?us-ascii?Q?BjsqkW0Xlik2YvKUbup7+1Ka25QXWZuxVIHRNWW2mlo/0MzA4aS+E2e3npLs?=
 =?us-ascii?Q?zLB6a058laQuhky3JYJYe0qiG744YQ810PgwaGh2lGAhi3jvJj0F3OcDvsCk?=
 =?us-ascii?Q?zl6pHLOS1C/ZFSsWq+8kPOXJxroiQeumiccI8ekzFLECFCq7NPBIEHd5EjqV?=
 =?us-ascii?Q?OhnGi+tEJojESVnNugS1pZMjHsaqHkzgkgKAqbxXHvXs/fnt7fCi6EEsgh1f?=
 =?us-ascii?Q?T9dBxSrZCwNomkVbhlIzmq5NKvS9pZtegH30oyseorKPPhqKS3J7WZqTpf/D?=
 =?us-ascii?Q?s92uVKPz2GXnKiaiuVbReKHzmYYucF2l8yiwjLX/Yaaf0m8z0N+8ChZWxGEG?=
 =?us-ascii?Q?wRm0tuNZ38M78OrdYgFQfLpzxC6sJ42Umk1bFE2YQGTivBre1HHKBnBvYLDH?=
 =?us-ascii?Q?fkEUbqpSXSK5YZmqJn10kpLxniM+Y8drndlst8o0X0lGwvT1rSt2hTw6Ve4/?=
 =?us-ascii?Q?kX/tl/ng6jbJjxjIV6S+UPdVdRjT7VPvNPqP1x+gN3KXWyQ6/Qh4ufb722e5?=
 =?us-ascii?Q?Pnea+VaNJR7pb24j3sW18gckRoja8wgF9yJXthzcw5m3gDzzgJFHJ85+StaQ?=
 =?us-ascii?Q?6R75x8A3sUEw+5oagsTc7h9DCU6mO14Se3mOEBthRqcPW7epkSuHcu4THaH1?=
 =?us-ascii?Q?qz4K7V46CZhFrr/aQvuLNx3cO5UQoQywMQqdBnf/GZm/pi5xUM29APW/UVHk?=
 =?us-ascii?Q?+cfxS7C/ULs9oR9a1sK/S19co8ctHVLh3PANXTo6oY7mPdYJ+dRcoJeOkG9x?=
 =?us-ascii?Q?Wxt8v5da/PjE5FyskX0d/O9+rotiIN+kMHBss/XF2TGQfhR3SqaJaGWwKvYn?=
 =?us-ascii?Q?ybXJkURHCXnLpf8v6eQQt3x1ZMv7z1g3zrOEuvgBMDHzUOD5UyZdFg+BoWyb?=
 =?us-ascii?Q?pEDEh1hjksGh/LQQj+6kypDfjy9HsVIZSQlxrimB6ll+os9rCoiw6KMNwV4F?=
 =?us-ascii?Q?sKHrNg9pTzFs/Cu0pc8cEPnTKBTGaglggnxh5PVzuq546bxX3z51m36O7AkQ?=
 =?us-ascii?Q?9tfWwx+OI0xu4S9zYT6T2dyQ7YTFBFcnXjF5riVfbLjAxVUIia6cbGEFE8ur?=
 =?us-ascii?Q?clH8KYSXouvrpnDjKO7UeEG0Jg8ix45qdJjDLiJsZwtrCtObJ4XvXAqLfzyN?=
 =?us-ascii?Q?i2N6iTcX5xu7PepEdQPzH5grXzE1e56F7Fkr4blyL0+GnuNutfb7jHoiNhCS?=
 =?us-ascii?Q?Agowm8vjenV5KVsEim01Q/pZ3kKKVcXWlK2QALK7x6QJTvAuuzM9oLgYOi43?=
 =?us-ascii?Q?NcLmWNpfNHOlzH60NPo9KCVevKdeqJmq6QbwZJruNxq5vvVsIaZancIK7geG?=
 =?us-ascii?Q?kKIz2yWaeYSO7Y9hMSAKA+sBNPg52gpDVujP64paFm7J6+0yqR93Z5+WlxBx?=
 =?us-ascii?Q?/majRCmoioCezlOuYXXTBtMBKzEjE3A6Dlqff3WM3qvmUHTXGeUFnZobhIUh?=
 =?us-ascii?Q?oWdYGJ88tcgeOXNCzXbSIysmRhbqkLU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: s5WP+/vroNbRYCA4wgInk9j+fANoG0LVNOVReVN04dL412LV7JYiIxcKrDZwea7FT9ftOlGF1YWlk31buzp9+SUrOqGi+SAsj4BUI5kBJm1mrrYc4r8omP+JgkYvghFZYp+yTGLkONXDnoRuIN5hhNXE+pI/g0exdSxnvvdpzvTyyJ0FQPRlFdUKERByDOuAy2Uyry6slfjULIgzSmom3pEyr4Wg+QnyCDZIdBXvYL/ip2q/dONGzdvr+1SkvY2I7bbdc6Q4lBN6Hex3CMB+ODRxU9NhltBVmciwD97DXbXEj/n89vEJ5fwCvqoQRmeoa4ijGz74+coabK8ikBb8oQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0a824d-11b0-4ea1-013b-08de8fc3ae7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 07:52:54.1732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9CIwo1Bj/NMIcKfk3xTCe+i6xmj3qUbjVY2WIttLakUbCcNXImqXKyWPNi0Oo2lApw6hGntdwuWD8zekyoogY18oiCz+3szVCC0Et3e9xfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8556
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273970-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.osuosl.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,IA3PR11MB8986.namprd11.prod.outlook.com:mid,lunn.ch:email,intel.com:dkim,intel.com:email,osuosl.org:email,davemloft.net:email,enjuk.jp:email];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B55FF37683B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Daiki Harada
> Sent: Tuesday, March 31, 2026 12:39 PM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Daiki Harada <daiky0325@gmail.com>; Kohei
> Enju <kohei@enjuk.jp>
> Subject: [Intel-wired-lan] [PATCH iwl-next v1 1/2] igb: use
> napi_schedule_irqoff() instead of napi_schedule()
>=20
> Replace napi_schedule() with napi_schedule_irqoff() in the interrupt
> handler path in igb driver
>=20
> Tested on QEMU with igb NIC emulation (-nic user,model=3Digb)
>=20
> Suggested-by: Kohei Enju <kohei@enjuk.jp>
> Signed-off-by: Daiki Harada <daiky0325@gmail.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> b/drivers/net/ethernet/intel/igb/igb_main.c
> index ee99fd8fd513..d7a6ae938cc5 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -7158,7 +7158,7 @@ static irqreturn_t igb_msix_ring(int irq, void
> *data)
>  	/* Write the ITR value calculated from the previous interrupt.
> */
>  	igb_write_itr(q_vector);
>=20
> -	napi_schedule(&q_vector->napi);
> +	napi_schedule_irqoff(&q_vector->napi);
>=20
>  	return IRQ_HANDLED;
>  }
> @@ -8199,7 +8199,7 @@ static irqreturn_t igb_intr_msi(int irq, void
> *data)
>  	if (icr & E1000_ICR_TS)
>  		igb_tsync_interrupt(adapter);
>=20
> -	napi_schedule(&q_vector->napi);
> +	napi_schedule_irqoff(&q_vector->napi);
>=20
>  	return IRQ_HANDLED;
>  }
> @@ -8245,7 +8245,7 @@ static irqreturn_t igb_intr(int irq, void *data)
>  	if (icr & E1000_ICR_TS)
>  		igb_tsync_interrupt(adapter);
>=20
> -	napi_schedule(&q_vector->napi);
> +	napi_schedule_irqoff(&q_vector->napi);
>=20
>  	return IRQ_HANDLED;
>  }
> --
> 2.53.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

