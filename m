Return-Path: <netdev+bounces-236883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9ECC4161D
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 20:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF533A139A
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 19:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905F2274FC1;
	Fri,  7 Nov 2025 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mosyDwtQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E000B25A2B2
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762542400; cv=fail; b=fopokLChnY+b/EVl0EDUxvLm5ODinLDTxScwXzP6LYq5yUcU6CPAEyaEyDsf+edmmxwGS8SCLJBAsjvUmhMjI62tb9ByLvcqDEx15kuP8RAv97T9SsraKQIKUb5YOv7BQ1l6j3kePrB3MVwPH5qxdolXoXx7CMLAf2OrUGolRyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762542400; c=relaxed/simple;
	bh=5U13MUZO7teFzCbVCWEeCa2Opc/gm6rPvUmLV7jEL7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bfl03VdOqM4nzmjXD8reikOMCKOEBwLedtLl2OCCUTZBQpznp0C7XVPPdpMfTflSj6kG+7We/oDQN+lB4RB6wR187hJUi4Sn18Uw25DK50J+P+rDoxOYsbNPhsclEhBAl/+NUBP6u+nWn+jy+YIwEFB1fYZDVt8Hs5kwgtPZR+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mosyDwtQ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762542399; x=1794078399;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5U13MUZO7teFzCbVCWEeCa2Opc/gm6rPvUmLV7jEL7E=;
  b=mosyDwtQFI+1/RWgeMqWGJrAhweT+R0JcxpaAyF/Q/DaaysX9awOkQEB
   DOj3HHJrKvj3LgqYf+ZigFC3b9vRH6h+OjjpjG32f70N+VjAoBtGjUIno
   WZ4HIfHYYfFLTmYKA/DVzi/LN5zowe3LDCgPrlJoRny+RCr1U5NQWbu3B
   JebaB++yYL7grtA17nXtu0M91dLpL3dpuRbFH0YojDF05IIliI4LOmAUP
   S6JIznNjmkNLdB8YuS84JIhAygeN0o6Wck0NffGrEfO1y8lDoq+v8Bm4e
   axwF2mM0vgQZQdikjy/BjCSHNgMstHbknyqZJgF/ham3jc56/KXPt9lj+
   w==;
X-CSE-ConnectionGUID: EOzPzxGZRFO4v77CKOctHw==
X-CSE-MsgGUID: u4m54QI9TGGLoPVVKW3DGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="87327925"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="87327925"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 11:06:38 -0800
X-CSE-ConnectionGUID: XIjZClK8Slme5nNeWSIPZQ==
X-CSE-MsgGUID: wNZoZzCZTFOXwlzWofbk9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="192205549"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 11:06:38 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 11:06:37 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 7 Nov 2025 11:06:37 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.36)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 11:06:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWYMKpxG6yxAwU7PN3rxU9gO3nKQP5x8wxrEWh0g3HS+PATv6ncS0HFFxqaNozD9OApyMdnKwQ0w3qSOVBOV9zdFTF09Gcv6R4k/sJvqKlPn1k0Vi06r1IyPqAp8AdRrp7/f5qNOL6x0mXJ+bPHyUHbia0w179rxFaJulKV8afgU5j8PHr6loiBEOFyLoJP1o/ZbXRtBLuZH1Ipz25XJNHrt6E5pzylL5LsFoVrJZkATUHJFj+0xXyaGz+y2DdsLPsaCeVTg34bUhTiY9zwl1e/metYk/RGKxTqHkEjpYg/J3sfAq8E4j/u4EqD2k0mjJLBni22wvH4p544eOyz0GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jOhLmBl5jZtxBCPZ+wBCKLE3qrLivgRK3q8VvAUVTw=;
 b=nHp1bObr6ajls7sV/AC5nTCMubXCNTOYoL8QSJC1XHDDQjxyTk0EE56Pg9nlppVdrPm//Bd1D1nq+0LjhbyH06QJ9tcbN7nMWR3LvK/kMs6Ubr9IUWqjL7DuDxRp8pbd14uZzhbO4iOyDBJmi8ZMcMK9y5mWAYawSjoV4ZJTLqTQp/2F+xkrARHOht6dkU/j9tHPnWs68mls2JSofP6a/JS8v7RwBqM9eGZRD0k3qO1cJFqfvoPyw4E1sLsaVUjsHiFhks2ZeXGmdNwxALxdEU0hAMHHWfBL+UpC2OEZHGCq0x/38HySEA6dT/qvf5p09/zI4qWSHAij0cnsFUL9Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DM4PR11MB6430.namprd11.prod.outlook.com (2603:10b6:8:b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 19:06:35 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 19:06:35 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "alok.a.tiwarilinux@gmail.com" <alok.a.tiwarilinux@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH net] i40e: fix incorrect src_ip checks
 and memcpy sizes in cloud filter
Thread-Topic: [Intel-wired-lan] [PATCH net] i40e: fix incorrect src_ip checks
 and memcpy sizes in cloud filter
Thread-Index: AQHcUAEALay/Ofu6eUC0Xk6uRAWpELTnkoow
Date: Fri, 7 Nov 2025 19:06:35 +0000
Message-ID: <IA3PR11MB898684016DECAB9D679766CFE5C3A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251107160943.2614765-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20251107160943.2614765-1-alok.a.tiwari@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DM4PR11MB6430:EE_
x-ms-office365-filtering-correlation-id: b97287cf-8fac-478d-3ba5-08de1e30c57d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?ho4Mgw3ocytT5EtZ4VaMwsu0xYwsfrjLXTLOJ8L+Gc8scjP7fUH4sgdLxzRe?=
 =?us-ascii?Q?an86faRu+/y/VJ9KlfqGvxvsGiHSj6gwD4wnM2f5ZaK5rFwSDFIfqpsRgQE0?=
 =?us-ascii?Q?Dw2qgPQ+vLik7LnqTd7JNMb3g4zuQcnbtqKfvNLGqAGvHTi3GG62JkJT6OZP?=
 =?us-ascii?Q?4aBv1xhf8glOn2k7kvCD91n89TI9UooIsdsKr39066fRlCCIGLgcnpAXFeBy?=
 =?us-ascii?Q?jaUIrryUw6y8tZ1cWdDfytM815VClRxaoCXIAcuIBapndlw5WQuejzOXQnke?=
 =?us-ascii?Q?u9c6v5a86flmbVERNGAfMxMfWg20wwGVf60x45dfzRGuWG4vjyd06ILz+Jmy?=
 =?us-ascii?Q?i3hkHoToWmeJfXbDaL8lrYmykqrGQtJi3GeLF4aYOokyYSwowFlscU8T8T5n?=
 =?us-ascii?Q?GbrNUl6aijy0M6UqmAM5c+rRAaYSkJfBNWqfn2zjL0SLDqJjfcv7144hKG2M?=
 =?us-ascii?Q?JTeVMhVwKnGLz2q8BceTJG7jDdcZOQ0cwDaG0dH/Op5ysSDZZBjdlw8h1EJa?=
 =?us-ascii?Q?TiKPiqurTRBXmqCIHkE86vQ0VtipXjIxjvrHl9dc/2u+vAXO2w2RU1QcRGaZ?=
 =?us-ascii?Q?4nvqfOcJ7HpcAPFf82ndr/ymVOW25c7FGqJ4944Fll7x9+ZlCl7gr/h2x2Mb?=
 =?us-ascii?Q?qxsCQBv1o+f99GGlY0fPcSu2jgqrZFLjEX3fnlYP/1dECSepdcAZpGQkwPJ5?=
 =?us-ascii?Q?VByWC9cTs85w/RtGTSU+lOrLX+9HY7EfoiYgjjN1k7kYYYEUkO6aAAnxvDfc?=
 =?us-ascii?Q?HdNx3DsiR7XPdBNxmXofwSiIWgDYWwMO9eGs0lcnya/Yb6iUigzHiIE5o5i5?=
 =?us-ascii?Q?bfS++9A9zYUSSwnVoyY3SVOirswyhfMJuUtNyZrzFtZYVSn6LKlVzpPk3T3n?=
 =?us-ascii?Q?AADx7Gox4wWnR5WINV89gGDslJgWbD3J6sACGKDmAIohYWC8B8vS/Rm64KkJ?=
 =?us-ascii?Q?WiuTFA3s0FEpb5o9x0rPFVASLff73/hlWGO1C7LnqVeWJ2QCYe7Y8wHY6x78?=
 =?us-ascii?Q?50PslxEUApQ6B9Wv3dsRKtR6CB/XABDmJx7m5exGrlR0uX3w17F2o6OpgHfL?=
 =?us-ascii?Q?PO8LKTdYB8Yy5zjFx4EO6BbvA0ZsfJCYBb5f7uPBXsJtsX4pFz3M1sP06eSg?=
 =?us-ascii?Q?GBsBCYgGkG0w8LS95EMYnfeu7Z3JlIw3dnQ/832hahnqqb57P0ucJBQ0VZ9f?=
 =?us-ascii?Q?Ze112O/FiSQR5H7GtUmZV1UsTHyc+I5V4cHCOLQW8mKP2WZObf8NXcqwPY8X?=
 =?us-ascii?Q?aYYkBAJZAiNedDIg8fxCZXKTt5JeeI12aCjuQ54Lnzz016DxHwPZ6ggsVjzo?=
 =?us-ascii?Q?Zcus/F30AKhNyKZybKHoXbY4ryoOpSBI9C8C7XGrfyhm+rejF2eIu3KI5rOV?=
 =?us-ascii?Q?PAXCymIckZuRC02U1VfN9+Sd+wkmotdAEgp2/uJFcZHQZpBrORpCAowxgiPH?=
 =?us-ascii?Q?fi0Cz2YwuvyTNvItcUT5aU7cqEakfrAu58n4HOwgTgtOUr+3/SIxpgz5anHh?=
 =?us-ascii?Q?p1mpnnc3LgJjU4SDgThG9tsqjdrGxQHcdVLdiWpGAwbVZDjEhZC6w9+7CQ?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?026pIgP1zWUqbkrZKDsfl2TSLVkDmJZtR26cvPqqzjtjHYsglc7U9AV2bV6+?=
 =?us-ascii?Q?uNYPW6YfKI0iE3qWrqk+tfaWZfeyhYRn/pyfZ7Hb8YY4cXVEjmmGolVLwEsD?=
 =?us-ascii?Q?1Giqz643rIycH4+qK6/kDHaMQYgarfthfnZpPryIhslQ2vHqOjX9QY8KOX5w?=
 =?us-ascii?Q?dYcz0GfvtgnFVzU0zavfASVzfRs7wxYXJAD8tJsPakygPcUkdlT1SN1IPfOv?=
 =?us-ascii?Q?UBFa05Am9r4BRykpF8M3Np47iXldS0l59LEbs3etN/zPx/XN8r6uVkPEJrII?=
 =?us-ascii?Q?X11LYy7Qh2YZMZZMlwxz2dcP46IzlQud2GO8TM/HSLAOqmoGNIcymMrnU6kH?=
 =?us-ascii?Q?FYvHaH7MGpPI9hrDab8PywPH4VKm+83RZ2gmofrAWdd7Uf4Rs0Sy0oq2mWm3?=
 =?us-ascii?Q?x4hWJ/Bfjj8fcV+6YQAPHG5oUreDf3WSeHMKMWqj7YsgnY8OIk/xcNJ9b6rf?=
 =?us-ascii?Q?XjRqDifnZnWD4ZOaY6Ui6Hn9IqSkGYLw90Vui9kjEs18D9n3V6uPuxYrnytQ?=
 =?us-ascii?Q?RxKaohceNxrljHrH0Fpp6tyeSU02sX24vs/xfHwloJ8WveAbBkGdizcp6BqX?=
 =?us-ascii?Q?Crfl2P4Hg7cBwTWaHMn2aAxUWZlJtMB4LeSvgnpro5Rx99gvroJyurKG6hK3?=
 =?us-ascii?Q?e8Vd1BSXk1oSLGwohlGvSEq7HxeyuryzoC9RhUKZJs6wvO2K0J68ogHoWiy0?=
 =?us-ascii?Q?vX0aR/Mb0a7MP8+Z0dMj4HYc9yVgfAYx6kBkWSGUcfTZG/7HAZ2qE7flcx0f?=
 =?us-ascii?Q?qTZ6e9/XY6G3aPeTQMN8HORCA5GDGqIxGQKOJ+bzIiJbN919VDWCTbwQO4PT?=
 =?us-ascii?Q?GJSQq9+hPPUdn2LlZQBzSiAHyBxx21nt0Rkt0r7d6MJr9Bw2PS8TBWGBp9U9?=
 =?us-ascii?Q?4bPSxaNZrjDRSIiPC4yAMwJFsWbsz0JyfppfmO2Ytamf+1nLy8y3YE+F/PWv?=
 =?us-ascii?Q?nVu0mGOkmGhHtThk4VVzx9vKukYTzzUmEqonzRcPaZxvCtNk0Z1gYz4jwKaK?=
 =?us-ascii?Q?Nj12cwpTDPwPbDUHqBTaTbaxm2I4hHZcG4XNeKu7iLhBdq198qGBLtI0/NYC?=
 =?us-ascii?Q?MXqCxa5O3eJNEk73gNLe3TWhcQSr/s4576dO3G0MSOuMsP1s3kb0qhadsFjd?=
 =?us-ascii?Q?cVAwRAhcpLDjDPCKZsNUYXFhYOsjOUN3gcNtkvHriTYDJ1j1zTB1Yazoa4pj?=
 =?us-ascii?Q?yFWwQor6J92RcqXvaoC52fNB2ppxAKLE8OWK8PomEtgOrEQQuFvTUEHpAj9R?=
 =?us-ascii?Q?yss9svIiFoysHa/LiGna20ZQp+2mlfgcGgKeodw8D7QeRYMq83DcwaWlE3SB?=
 =?us-ascii?Q?OW4hdUWit3t8AHOOskTPnO1edktrEQDDqDyQKAwS1+BKToLyetzejL1Wn4IW?=
 =?us-ascii?Q?qAEVe04g+7rjM6mq4zwP74sJqaIQcqtCHJPkDpJrRUHsUERuzN+w9xA3frfz?=
 =?us-ascii?Q?+17VpVvWcQJ8N2Hop5KgGtgmjLepl1WoPkblbxssqqyoVNwk6hVzwzz8yUW3?=
 =?us-ascii?Q?AEmipHjKPdPQxjbK7ovKAnrR7LOT6rr2r6L5WPgxcsN+2ArD7LyIqyR+0lX4?=
 =?us-ascii?Q?bBEtQ9w9JIQc58Uyh5ktAz/tQ6s32DUu+uZON5kh3gMgSRq/DwURZURPX25C?=
 =?us-ascii?Q?3g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97287cf-8fac-478d-3ba5-08de1e30c57d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 19:06:35.3045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C1YnBpX65KzYMBmqIxy0za2F5BA5BxkW1jQ6+rkQ0tOT+/75FtRDtQdxzaS0jtM2QdZvWsFjpnJbdYxwmM7Lsv5UGeywhxmvBF7+BuV9GVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6430
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Alok Tiwari
> Sent: Friday, November 7, 2025 5:10 PM
> To: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Lobakin,
> Aleksander <aleksander.lobakin@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; andrew+netdev@lunn.ch; kuba@kernel.org;
> davem@davemloft.net; edumazet@google.com; pabeni@redhat.com;
> horms@kernel.org; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org
> Cc: alok.a.tiwarilinux@gmail.com; alok.a.tiwari@oracle.com
> Subject: [Intel-wired-lan] [PATCH net] i40e: fix incorrect src_ip
> checks and memcpy sizes in cloud filter
>=20
If you let me, I'd propose the title:
i40e: fix src IP mask checks and memcpy argument names in cloud filter

> Fix following issues in the IPv4 and IPv6 cloud filter handling logic
> in both the add and delete paths:
>=20
> - The source-IP mask check incorrectly compares mask.src_ip[0] against
>   tcf.dst_ip[0]. Update it to compare against tcf.src_ip[0]. This
> likely
>   goes unnoticed because the check is in an "else if" path that only
>   executes when dst_ip is not set, most cloud filter use cases focus
> on
>   destination-IP matching, and the buggy condition can accidentally
>   evaluate true in some cases.
>=20
> - memcpy() for the IPv4 source address incorrectly uses
>   ARRAY_SIZE(tcf.dst_ip) instead of ARRAY_SIZE(tcf.src_ip), although
>   both arrays are the same size.
>=20
> - In the IPv6 delete path, memcmp() uses sizeof(src_ip6) when
> comparing
>   dst_ip6 fields. Replace this with sizeof(dst_ip6) to make the intent
>   explicit, even though both fields are struct in6_addr.
>=20
> Fixes: e284fc280473 ("i40e: Add and delete cloud filter")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 081a4526a2f0..c90cc0139986 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -3819,9 +3819,9 @@ static int i40e_vc_del_cloud_filter(struct
> i40e_vf *vf, u8 *msg)
>  		if (mask.dst_ip[0] & tcf.dst_ip[0])
>  			memcpy(&cfilter.ip.v4.dst_ip, tcf.dst_ip,
>  			       ARRAY_SIZE(tcf.dst_ip));
> -		else if (mask.src_ip[0] & tcf.dst_ip[0])
> +		else if (mask.src_ip[0] & tcf.src_ip[0])
>  			memcpy(&cfilter.ip.v4.src_ip, tcf.src_ip,
> -			       ARRAY_SIZE(tcf.dst_ip));
> +			       ARRAY_SIZE(tcf.src_ip));
Please consider the sizeof(field) tweak for memcpy to preempt review nits.=
=20

- memcpy(&cfilter.ip.v4.dst_ip, tcf.dst_ip, ARRAY_SIZE(tcf.dst_ip));
+ memcpy(&cfilter.ip.v4.dst_ip, tcf.dst_ip, sizeof(cfilter.ip.v4.dst_ip));

- memcpy(&cfilter.ip.v4.src_ip, tcf.src_ip, ARRAY_SIZE(tcf.src_ip));
+ memcpy(&cfilter.ip.v4.src_ip, tcf.src_ip, sizeof(cfilter.ip.v4.src_ip));

You have my RB:
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

>  		break;
>  	case VIRTCHNL_TCP_V6_FLOW:
>  		cfilter.n_proto =3D ETH_P_IPV6;
> @@ -3876,7 +3876,7 @@ static int i40e_vc_del_cloud_filter(struct
> i40e_vf *vf, u8 *msg)
>  		/* for ipv6, mask is set for all sixteen bytes (4 words)
> */
>  		if (cfilter.n_proto =3D=3D ETH_P_IPV6 && mask.dst_ip[3])
>  			if (memcmp(&cfilter.ip.v6.dst_ip6, &cf-
> >ip.v6.dst_ip6,
> -				   sizeof(cfilter.ip.v6.src_ip6)))
> +				   sizeof(cfilter.ip.v6.dst_ip6)))
>  				continue;
>  		if (mask.vlan_id)
>  			if (cfilter.vlan_id !=3D cf->vlan_id)
> @@ -3965,9 +3965,9 @@ static int i40e_vc_add_cloud_filter(struct
> i40e_vf *vf, u8 *msg)
>  		if (mask.dst_ip[0] & tcf.dst_ip[0])
>  			memcpy(&cfilter->ip.v4.dst_ip, tcf.dst_ip,
>  			       ARRAY_SIZE(tcf.dst_ip));
> -		else if (mask.src_ip[0] & tcf.dst_ip[0])
> +		else if (mask.src_ip[0] & tcf.src_ip[0])
>  			memcpy(&cfilter->ip.v4.src_ip, tcf.src_ip,
> -			       ARRAY_SIZE(tcf.dst_ip));
> +			       ARRAY_SIZE(tcf.src_ip));
>  		break;
>  	case VIRTCHNL_TCP_V6_FLOW:
>  		cfilter->n_proto =3D ETH_P_IPV6;
> --
> 2.50.1


