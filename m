Return-Path: <netdev+bounces-295056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BJMtL2QcIWrr/AAAu9opvQ
	(envelope-from <netdev+bounces-295056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 08:34:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1134863D431
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 08:34:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=selector1 header.b=klb+6wyI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295056-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295056-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28065301C883
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 06:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979D63D75A5;
	Thu,  4 Jun 2026 06:29:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B8A3D6CDC;
	Thu,  4 Jun 2026 06:29:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780554547; cv=fail; b=UTr02/ubN3GbgTw0Q5QQy0bezNDo1EUYNW/VzKv8SnCC80kk1PoKXpmjekSMhRaunRJi+1wpLVcQtUZ5496YbF0GukSsBfEK4nK5GxuyqqXF5E1uSvvfkiBhPv9g3EdhLUlTXo3qJsaRIzp7HU5QwYkF7SIqcn+asjUWUrCbQ9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780554547; c=relaxed/simple;
	bh=tEwRBkQSn0M7iHYx3PzRuic3uyh7LnQmhIauWzCyk9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QCbednEbfhEmh6giUNwV9pwIQPACEizbZAglHGDBHZjVWRwUdVPmDyFnnixx5M0wjudPtC+PjfwG+dDZD55763GYUckG1mULOPIVpZ8A13xmmJ8xipsbA5DTG8I7ju2msfJbBqercDGx3YQoIl3SCoccm40T94om8L5J2/PVL9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=klb+6wyI; arc=fail smtp.client-ip=52.101.53.54
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jO8yIZ4ntwmLbc/hIoeZ863Y9Yg7+J/14bevBAFO6Xj8AVtmDKwKt8F1fWBMlKGpcffvir6wKV1GQ12fvCDnMzGGK+y1zm0Q67CAcIcneaCP7562EQhAnVgQUmfuxgO7zJnKWGWqnq7S/8bokB/JVisTNvyUW5pnBk9ps5qfHIS/e7GbJUA1VYLe2mRWHFVqjCqMazm4Sg0Bv8E4h3qkuG3vEqI6rLg98xWXvqTFAcLtrBxQ7HtFEgqjBjFnoexejqnJjiYo5eFl6+0Wm4uU7YEdTpDx5H1br6D6yjA9FriwPCjNOwMoDmXzwYgDhZtlCVwdxR+K9vM01fJ3eImjMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEwRBkQSn0M7iHYx3PzRuic3uyh7LnQmhIauWzCyk9A=;
 b=Az/UOPfzQ95LZwxqUGFwYmnmY+SAoxumgT2V6bP/pFWa4RuZF0rU8WlH3Pa1VQijet8++EJiaz8BSYxb/B6dnHBYRAFnVUJJnX8ifKDDUjlGUb6H1VcEGhBJ5dbWjawdMPoXfnUnuc7fOst19lr43loxurPkCpMTwyX2cwtszTVOE8hpbBqropShPWmvhqU6dowuTQq65YDMjMHYbzShP1F9mg/RxqLTaibxJLGgpYeQHjJU/cm2ukzsghFtf59scIzQoeGyOu+R9qjz4t8Y4gccMHnstCNjsLZhQQcAE6+AvarYk5tHcctcdz+ZZXaHtZFEeX2Wl0+7d2nIAKhl3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEwRBkQSn0M7iHYx3PzRuic3uyh7LnQmhIauWzCyk9A=;
 b=klb+6wyIrY7T3DjsVcS9XFL1TNSIpO0SoOMAXJQib/U0yj7YIYUfxvR3AGG6RdiuiyM98UTEJtQ7MDctNVI2WzsgLsAXvxde7oPmJ1WfQEjaUy7Hl36wBiFkQlGx6sORmJ1KFq5Stm1VJyCvFHIb57LD5l5MRxQpZrGb8M7kg5eEfFJeaGg7vg2dvo7IhdHCmMWZ09vQgybedCvOtHIbboo2BqBupBmdXoD8nk11Bo1vY05u6DhpnaLrkSTA2SZuejJ/UjezRZTtjQolMeSa/PAgdDLeVg8RGSiwmiZsDCeBYKJfUuYr9608I1bYWVZ4etdhz711DW4W0TxP1dk4QQ==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by PH7PR11MB7450.namprd11.prod.outlook.com (2603:10b6:510:27e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 06:29:01 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 06:29:01 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <Selvamani.Rajagopal@onsemi.com>, <conor@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <Pier.Beruto@onsemi.com>,
	<andrew@lunn.ch>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Conor.Dooley@microchip.com>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH net v3 2/2] dt-bindings: net: updated interrupt type to be
 active low, level triggered
Thread-Topic: [PATCH net v3 2/2] dt-bindings: net: updated interrupt type to
 be active low, level triggered
Thread-Index: AQHc8eDGO4Y2rMyEmEeRgmYw3vsZ4LYrecyAgAAPEwCAAmo7AA==
Date: Thu, 4 Jun 2026 06:29:01 +0000
Message-ID: <a5abb9b8-6ebf-4f95-a684-fc889b98acea@microchip.com>
References: <20260601-level-trigger-v3-0-da73e7010532@onsemi.com>
 <20260601-level-trigger-v3-2-da73e7010532@onsemi.com>
 <20260602-rebel-snide-5036c97e410d@spud>
 <CY8PR02MB92493D2E5491AAE5416C05A283122@CY8PR02MB9249.namprd02.prod.outlook.com>
In-Reply-To:
 <CY8PR02MB92493D2E5491AAE5416C05A283122@CY8PR02MB9249.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|PH7PR11MB7450:EE_
x-ms-office365-filtering-correlation-id: 8cf893fe-2112-498b-856b-08dec202912b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006|5023799004;
x-microsoft-antispam-message-info:
 lkVpb9/IHNrcBpn2rb+IneY7A/CxxHdCuMbwbIGtCHsyyV8Rk7v1MeCWXvLEDfge3laZLrSsiSFL3RCr8FGNzOJgIKovSCrZ4iaAilBMDJ16wSg/Rl+g8FlxX+Vyr2GjVXh5isSG195W9T5NycdhgO7KY9Z5bTtlQUAgJJPd1bossgOMjP4LOGeugXYcmeEr6WlvXz+oNj2Zl8eohI7iHBVhX3o3Fqnb2XO3oP5ySC6zg3D5f/Z50mGcCepTOWWyPOAFC+CG9vOVquSMU9ABwhvsFGo7hMli8YKqAUko/D34pMLefLEA/m57BahUwzfO2ErwRwomIELOFX2PMNJyS1C99An4gJu6MI45bSRP7SCOlutiTmvtYCMF1ereOWA3y6i3HO1cEA/xjJLhVpUKDZI9+nB78PyvrWgXuTrQxCARX4u73Ja2ywSuQqErk1XElOU9+0t9flxTpH6DOb1j8k20qCUxbQQOCZ8/fmWFoL+50R6aAdTK5BHl348MBT9R3cTKL5J5qy+6PGi7DX7GStzYy6+p0RBXErn37XMSOOrflL7Y1FxEwY/cD9Ims6Wy7e9hdkvjdoxB/WgsUM+zhzzcDWq/Z2bEEJDm/unfj7kHdXIbE+H6d0qF7bBP55TzxKJfxkqOdqi5u7X9EwfM5eZOlSxPrrNKIaLhOUNYSW4TXH6ebXtI5FozRwtODr/sywBIv1sFGE/e+K8+AhXnOi1bBSqbrsd+C1QGPBO0vH+dh2CtKJ29DbFmzuAgYNGD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dTQ1cm9GYnEwNzhJdHdTRTZRbnB6MkVwRmRtRzBRNTVabVRyemdpWFl3VU15?=
 =?utf-8?B?UDg0UGVYUUMrYWtSeFBvQWVubWdQOHVOdlV2NWhmWjVJc2VScGh5TmcyM0R0?=
 =?utf-8?B?UkZLcjhpUlF6QlJ6ZmRrMEFGUGtLbXB2U2kwTkZ5bjdXcDNtNGdMU0I1N3Y5?=
 =?utf-8?B?a2tSL0ozbHQ1ZFZYblh2b05kRVY4bENZOStHVmxSSkZxVEFrQnJObS9qSStZ?=
 =?utf-8?B?cHVoMjZ4VFdiNXNEcngwc2NDRGpoV0NwT1MwVjZqbzdlc2FJeUxxaFh5VlY4?=
 =?utf-8?B?bXNKM0VyVDl4dzM2SXdtRms5TUNxNmlsN29EN2huUGxhcmJpKzFWZWpBNFNC?=
 =?utf-8?B?NnAxY0ZqWHVMdDBxckVpNllZVkp0REdzM0ptaC9iUnNXb2hmajVFUlprR3lp?=
 =?utf-8?B?VHhkYlNCUW1MeHp2RFhscWd1dGM2YWlTRjluL3hGcFZuQTlmQWpuOVZPMnBN?=
 =?utf-8?B?QWFoa2NqT2NRbHRFejE0ODNJUHZhQm44Mi9qOWNkTTEwU3FBRU9MaGpMQ1o5?=
 =?utf-8?B?b0tYNUg5SC81R3RoQ2E2bHF2MUF3QW55UWFteVR3L1l6RFYrZzlONEtIQzFU?=
 =?utf-8?B?b2pnV1V5czhiNDNtYlBGMXUvZEozUWZxK21kbVdHa3cwWk1RMk1MZWt1dlcz?=
 =?utf-8?B?ZzdlUnVvYW9RRFlKekJKWitNSnFlM1dqU1ROTlcwYzV5dWplSldhajdwTWdC?=
 =?utf-8?B?TlRmVnN2MmZ2aG81M3VGbkNHNGFyYzArQzhxSCtkcDNGVVVNb0kyd2VyRElW?=
 =?utf-8?B?U3dsSHRWYVhERGhYbzZnNUNyTGhORkduT0RVSmNIWk1vZk5HaW9kYnpWaHlj?=
 =?utf-8?B?SVh6VnBMd21HTHZIV200U2V5a2xCclZ3TVF2bUlYZjg0Sno0TlVqZlhZTnFP?=
 =?utf-8?B?UHE0ZFdZbllyRmxIK1F3NmkxdG14d0tEMzdRZ3FXUmJrUGZ3R09ublpMZDBs?=
 =?utf-8?B?MTB6aVBNNzkyS3VhSThiQlFjTHZHUHVHQmNhWmJqQWVDZk11Y3czWXZOYzdr?=
 =?utf-8?B?OGZpYWphdTRjd3puUElnK0dNZ3JFSjU5OGkxb28wYnpTVnB4WHZOWHd2UFlK?=
 =?utf-8?B?QnhwSlc1TGdmcGFlRjlNNnNLcDNPWXdpRmpTU2dxS3pON2ZyM2puR1psRmdt?=
 =?utf-8?B?ZC8rdElGVExvYTByQm1UNm9xZmVQNDlSWjMvVnJPWjUzQnQyNlp6cE5PelE0?=
 =?utf-8?B?RUxSSVRkZ2c3S0ZwbEUvbmtyTG15OStqWUl0RTJkMGFuTzZVKy9LT0QvSW1o?=
 =?utf-8?B?K1BiRHVKQmpON2ZobytqNjZnSEtINVppVFdSTkVHM1FubmdvVkp0ZGt5MzF0?=
 =?utf-8?B?Y2tWUndzUDJ1UzNML2VBcDYyQVhEVkdRNi9DTUFPdDFzaFBwNlY5T1lNRGZ4?=
 =?utf-8?B?cWF3ZXhsSFZVVXZjOEtoTzVBVTdySlRnRGZQdE4yRW1Pa05ESm0vcS9kMk1K?=
 =?utf-8?B?Z2V1NDhZZENhL05LN3d5OTlua2lqREtwS25ZWlZVdVgwQjJ0VE5xbmNMTlQ4?=
 =?utf-8?B?T3ZRYlVvaEw0Vm9VZXozT1ZxU1doQ0hENjF5UUswbnU2L0ZmVGZ2OFFCRVkz?=
 =?utf-8?B?WGtUSWtra29sVmdwZEFxSU10QjNnKzhSZVI5UUh3dVZNbktoQ29vUjRob0h1?=
 =?utf-8?B?UjExWjU5bmdsRmZ3bVp6VWhJdTIvbjVndmlEZUVXeUpzaGVXaHRGYkNEb015?=
 =?utf-8?B?SnRLckFMbStLYVpYWFpzQkFOVEVoQWwybzkyalhlTjRibGFPQ2RsNDRXK1Bx?=
 =?utf-8?B?cUxLdWk5Z3V5RjBPSjR2elJIbW1jM01Hem45VVBZMTRucEd6Kzh2NTN5ZWJ6?=
 =?utf-8?B?RWRPTmU4RnNrZlNHNk9vcGVWbDFBVHNuQWZzaWRpZ2dETk1qQXdXY2U3SCtR?=
 =?utf-8?B?Wk13UEQ4VGdHVUlaS042QXRYYmV3WU15bmNNTW1RTVI2SGQwOE9pbFEzMjdC?=
 =?utf-8?B?NUNzUG5reGp3RGJxd2l1OURHbWdud0lpM2tnUFVWTUFJbXZRRWtmVUpEVVln?=
 =?utf-8?B?cW9PaUtGU0VJSWRReHo2SjBVRVZjK2o1Wld4QlE2eUZOaENPV1BERTFsZ1ph?=
 =?utf-8?B?aFFYVzNyakxZbnZJbXZ1OXNBUnIxQzBISFJxZ3JYbjBnZ296ckV1NHdraHNu?=
 =?utf-8?B?RFBTL09xSnJaSTF0S09WWlJpZWk2UkZ2NEVoOHNGUDYraFlCcWJYZkRUdm8y?=
 =?utf-8?B?cnFQY0xBWFRobWhEVWc2blBNUzZBSG1kUDdIZ0tnc2JDYkhnbmFXcVhvSU5K?=
 =?utf-8?B?VHhDUXc0WDc4L3YrUTRMdEpCTW5NOEFmcSttRFdzMDY0dlprS2ZJdTV0WW9a?=
 =?utf-8?B?UWpRTDRidHNNNDlIbkRmK05ISTJKbUVISmhPSW50THF0cWlpMVdsTEJwVXdE?=
 =?utf-8?Q?dcNrKDlFy0AM/Dxs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08BD1A58811DCF4B9862EDB03B843D44@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf893fe-2112-498b-856b-08dec202912b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 06:29:01.4060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bBYNskped9MpqUjpDHnLzqVCc5edowjDrGcj+0Jkvb8iXR1bRoRapIfXQGa8ArXghihJeXfjPrVbqIqQ4/Tp9YC+k/l7acxRKMnnWcT3rH809jEDKupDnDMMKVC1Qxkb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7450
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295056-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:conor@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Parthiban.Veerasooran@microchip.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[Parthiban.Veerasooran@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:mid,microchip.com:from_mime,microchip.com:dkim,vger.kernel.org:from_smtp,onsemi.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1134863D431

SGkgQ29ub3IgJiBTZWx2YW1hbmksDQoNCk9uIDAyLzA2LzI2IDExOjA2IHBtLCBTZWx2YW1hbmkg
UmFqYWdvcGFsIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4g
DQo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gU3ViamVjdDogUmU6IFtQQVRDSCBu
ZXQgdjMgMi8yXSBkdC1iaW5kaW5nczogbmV0OiB1cGRhdGVkIGludGVycnVwdCB0eXBlIHRvIGJl
IGFjdGl2ZSBsb3csDQo+PiBsZXZlbCB0cmlnZ2VyZWQNCj4+DQo+Pj4gQWNjb3JkaW5nIHRvIE9Q
RU4gQWxsaWFuY2UgMTBCQVNFLVQxeCBNQUNQSFkgU2VyaWFsIEludGVyZmFjZSAoVEM2KQ0KPj4+
IHNwZWNpZmljYXRpb24sIGludGVycnVwdCB0eXBlIGlzIGFjdGl2ZSBsb3csIGxldmVsIHRyaWdn
ZXJlZCBpbnRlcnJ1cHQuDQo+Pg0KPj4gSGF2ZSB5b3UgY2hlY2tlZCB0aGUgZG9jdW1lbnRhdGlv
biBmb3IgdGhpcyBkZXZpY2UgZXRjIHRvIG1ha2Ugc3VyZSB0aGF0DQo+PiB0aGUgZGV2aWNlIGFj
dHVhbGx5IGZvbGxvd3MgdGhlIHNwZWM/DQo+PiBNYXliZSBQYXJ0aGliYW4gY2FuIGNvbmZpcm0g
dGhpcyBmb3IgdXM/DQo+IA0KPiBUaG91Z2ggSSBjb29yZGluYXRlZCB3aXRoIFBhcnRoaWJhbiB3
ZWxsIGFoZWFkIGFib3V0IHRoaXMgY2hhbmdlLCBIZSBpcyB0aGUgb25lIHdobyBjb3VsZCBjb25m
aXJtLg0KPiANCj4gVG8gYW5zd2VyIHlvdXIgcXVlc3Rpb24sIEkgbG9va2VkIGF0IHRoZSBkYXRh
c2hlZXQuIEluIG9uZSBvY2Nhc2lvbiwgaXQgbWVudGlvbnMgIm9uY2UgUkVTRVRfTiBpcyBkZWFz
c2VydGVkLCBkZXZpY2UgYXNzZXJ0cyBJUlFfTi4NCj4gV2hlbiBzb2Z0d2FyZSBjbGVhcnMgUkVT
RVRDIGJpdCBvZiBPQV9TVEFUVVMwLCBkZXZpY2UgZGVhc3NlcnRzIElSUV9OLiBUaGlzIGdpdmVz
IG1lIGFuIGluZGljYXRpb24gdGhhdCB0aGUgaW50ZXJydXB0IGlzIGxldmVsIHRyaWdnZXJlZC4N
Cj4gDQo+ICBGcm9tIG91ciBzaWRlLCBJIGNoZWNrZWQgd2l0aCBvdXIgZW5naW5lZXIsIHdobyBp
cyBwYXJ0IG9mIHRoZSB0ZWFtIHRoYXQgcHV0IHRvZ2V0aGVyIHRoZSBzcGVjaWZpY2F0aW9uLCBQ
aWVyLCBjb3BpZWQgaW4gdGhpcyBlbWFpbCwgY29uZmlybWVkIHRoYXQgaXQgaXMgbGV2ZWwgdHJp
Z2dlcmVkLg0KDQpUaGFuayB5b3UgZm9yIG5vdGlmeWluZyBtZS4NCg0KWWVzLCBTZWx2YW1hbmkg
aGFkIGFwcHJvYWNoZWQgbWUgaW4gYSBkaWZmZXJlbnQgZW1haWwgdGhyZWFkIHRvIHRlc3QgDQp0
aGlzIGNoYW5nZS4gQXMgSSBpbmZvcm1lZCBoaW0gaW4gdGhhdCBlbWFpbCB0aHJlYWQsIHVuZm9y
dHVuYXRlbHkgd2UgDQpjb3VsZCBub3QgdGVzdCBpdCBpbW1lZGlhdGVseSBhcyBvdXIgdGVhbSB0
aWVkIHVwIHdpdGggYW5vdGhlciBwcm9qZWN0LiANClRoYW5rIHlvdSBmb3IgeW91ciB1bmRlcnN0
YW5kaW5nLiBJIG5vdyBoYXZlIHNvbWUgYmFuZHdpZHRoIHRvIHByb2NlZWQgDQp3aXRoIHRoZSB0
ZXN0aW5nIGFuZCB3aWxsIHNoYXJlIGZlZWRiYWNrIGFzIHNvb24gYXMgcG9zc2libGUuDQoNCkJl
Zm9yZSB0aGF0LCBJIHdvdWxkIGxpa2UgdG8gZ2l2ZSBhIGhlYWRz4oCRdXAgYmFzZWQgb24gb3Vy
IGluaXRpYWwgDQpkZXZlbG9wbWVudCBleHBlcmllbmNlLiBJIHJlY2FsbCB0aGF0IHdlIGluaXRp
YWxseSB1c2VkIGFuIGFjdGl2ZeKAkWxvdyANCmxldmVsIGludGVycnVwdCwgYnV0IHdlIHJhbiBp
bnRvIGlzc3VlcyBzdWNoIGFzIHJhbmRvbSBzeXN0ZW0gc3RhbGxzIA0KZGVwZW5kaW5nIG9uIHN5
c3RlbSBsb2FkLiBPdXIgdGVzdGluZyB3YXMgZG9uZSBvbiBhIFJhc3BiZXJyeSBQaSA0IHdpdGgg
DQpMQU44NjUwLg0KDQpUaGUgY29kZSBmbG93IHdhcyBhcyBmb2xsb3dzOiB3aGVuZXZlciB0aGVy
ZSBpcyBhbiBpbnRlcnJ1cHQgZnJvbSB0aGUgDQpNQUPigJFQSFksIHRoZSBJU1IgaXMgaW52b2tl
ZC4gVGhlIElTUiB3YWtlcyB1cCB0aGUgU1BJIHRocmVhZCB0byBwZXJmb3JtIA0KdGhlIFNQSSB0
cmFuc2ZlciBhbmQgdGhlbiByZXR1cm5zLiBUaGUgaW50ZXJydXB0IHJlbWFpbnMgYXNzZXJ0ZWQg
dW50aWwgDQp0aGUgTUFD4oCRUEhZIHJlY2VpdmVzIGEgZGF0YSBjaHVuayBmcm9tIHRoZSBob3N0
Lg0KDQpEdXJpbmcgZnVydGhlciBpbnZlc3RpZ2F0aW9uLCB3ZSBmb3VuZCB0aGF0IHNvbWV0aW1l
cyB0aGVyZSBpcyBhIA0Kc2NoZWR1bGluZyBsYXRlbmN5IGJldHdlZW4gdGhlIFNQSSB0aHJlYWQg
d2FrZeKAkXVwICh0cmlnZ2VyZWQgZnJvbSB0aGUgDQpJU1IpIGFuZCB0aGUgYWN0dWFsIGV4ZWN1
dGlvbiBvZiB0aGUgU1BJIHRocmVhZCBkdWUgdG8gc3lzdGVtIGxvYWQuIA0KRHVyaW5nIHRoaXMg
Z2FwLCB0aGUgaW50ZXJydXB0IHN0YXlzIGFzc2VydGVkIGZvciBhIGxvbmcgdGltZSBldmVuIA0K
dGhvdWdoIHRoZSBJU1IgaGFzIGFscmVhZHkgcmV0dXJuZWQuIFdpdGggYW4gYWN0aXZl4oCRbG93
IGxldmVs4oCRdHJpZ2dlcmVkIA0KY29uZmlndXJhdGlvbiwgdGhpcyBjYXVzZXMgdGhlIExpbnV4
IElSUSBzdWJzeXN0ZW0gdG8gcmVwZWF0ZWRseSBpbnZva2UgDQp0aGUgSVNSLCByZXN1bHRpbmcg
aW4gSVNSIHJlY3VycmVuY2UgYW5kIGV2ZW50dWFsIHN5c3RlbSBpbnN0YWJpbGl0eS4NCg0KSW4g
dGhpcyBkZXNpZ24sIHdoZW5ldmVyIHRoZXJlIGlzIGFuIGludGVycnVwdCBmcm9tIHRoZSBNQUPi
gJFQSFksIHRoZXJlIA0KaXMgbm8gd2F5IHRvIGRpc2FibGUgdGhlIGludGVycnVwdCBvciBwcmV2
ZW50IGZ1cnRoZXIgSVNSIGludm9jYXRpb25zIA0KYmVmb3JlIHJlYWN0aW5nIHRvIGl0LiBUaGUg
b25seSB3YXkgdG8gZGVhc3NlcnQgdGhlIGludGVycnVwdCBpcyBieSANCnNlbmRpbmcgYSBkYXRh
IGhlYWRlciB0byB0aGUgTUFD4oCRUEhZLiBUaGlzIGlzIHRoZSBwcmltYXJ5IHJlYXNvbiB3ZSAN
CnJlbGllZCBvbiBhIGZhbGxpbmfigJFlZGdlIGludGVycnVwdCwgd2hpY2ggcmVzb2x2ZWQgdGhl
IElTUiByZWN1cnJlbmNlIGlzc3VlLg0KDQpNeSB0d28gY2VudHM6IGdlbmVyYWxseSwgaW50ZXJy
dXB0cyBhcmUgZGlzYWJsZWQgb3IgY2xlYXJlZCB2aWEgYSANCnJlZ2lzdGVyIHJlYWQvd3JpdGUg
aW4gdGhlIElTUiwgdGhlIElTUiByZXR1cm5zLCBhbmQgdGhlIHJlbWFpbmluZyB3b3JrIA0KaXMg
ZGVmZXJyZWQgdG8gYSBzZXBhcmF0ZSB0YXNrIG9yIHRocmVhZC4gSW4gdGhpcyBjYXNlLCBob3dl
dmVyLCB0aGVyZSANCmlzIG5vIHN1Y2ggbWVjaGFuaXNtLCBhbmQgc2VuZGluZyBhIGRhdGEgaGVh
ZGVyIGlzIHRoZSBvbmx5IHdheSB0byBjbGVhciANCnRoZSBpbnRlcnJ1cHQuIERvaW5nIHRoaXMg
aW5zaWRlIHRoZSBJU1IgaXMgbm90IGZlYXNpYmxlIHNpbmNlIA0Kc3BpX3N5bmMoKSB3aWxsIHNs
ZWVwLCB3aGljaCBpcyBub3QgYWxsb3dlZCBpbiBJU1IgY29udGV4dC4NCg0KT25lIHBvc3NpYmxl
IGFsdGVybmF0aXZlIGNvdWxkIGJlIHRvIHVzZSBhIHRocmVhZGVkIElSUSBoYW5kbGVyIHdpdGgg
DQpJUlFGX09ORVNIT1QsIHdoZXJlIHRoZSBJUlEgbGluZSBpcyBkaXNhYmxlZCB1bnRpbCB0aGUg
aGFuZGxlciANCmNvbXBsZXRlcywgYW5kIHNsZWVwaW5nIGlzIGFsbG93ZWQuIEluIHRoYXQgY2Fz
ZSwgd2UgY291bGQgcGVyZm9ybSB0aGUgDQpTUEkgdHJhbnNmZXIgaW4gdGhlIHRocmVhZGVkIGhh
bmRsZXIgdG8gc2VuZCB0aGUgZGF0YSBoZWFkZXIgYW5kIA0KZGVhc3NlcnQgdGhlIGludGVycnVw
dCwgd2hpbGUgZGVmZXJyaW5nIHRoZSByZW1haW5pbmcgd29yayB0byBhIHNlcGFyYXRlIA0Ka3Ro
cmVhZCAodGhlIGN1cnJlbnQgU1BJIHRocmVhZCkuIEhvd2V2ZXIsIEkgaGF2ZSBub3QgeWV0IHRy
aWVkIHRoaXMgDQppbXBsZW1lbnRhdGlvbiwgc28gSSBjYW5ub3QgY29tbWVudCBvbiBpdHMgYmVo
YXZpb3Igb3IgZWZmZWN0aXZlbmVzcyANCndpdGhvdXQgaW1wbGVtZW50aW5nIGFuZCB0ZXN0aW5n
IGl0Lg0KDQpJIG1heSBiZSBtaXNzaW5nIHNvbWV0aGluZyBoZXJlIGFuZCBhbSB0cnlpbmcgdG8g
Y2xhcmlmeSBteSANCnVuZGVyc3RhbmRpbmcuIEkgYW0gYWxzbyBjdXJpb3VzIHdoeSB0aGlzIGlz
c3VlIHJlcHJvZHVjZXMgb24gb3VyIHN5c3RlbSANCmJ1dCBkb2VzIG5vdCBhcHBlYXIgaW4gU2Vs
dmFtYW5p4oCZcyBzZXR1cCB3aXRoIGFuIGFjdGl2ZeKAkWxvdyBsZXZlbCANCmludGVycnVwdCBj
b25maWd1cmF0aW9uLiBJZiBwb3NzaWJsZSwgY291bGQgeW91IHNoYXJlIGRldGFpbHMgb2YgeW91
ciANCnNldHVwIGFuZCBob3cgdGhlIHRlc3RpbmcgaXMgYmVpbmcgcGVyZm9ybWVkPw0KDQpCZXN0
IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4+DQo+PiBDaGVlcnMsDQo+PiBDb25vci4NCj4+
DQo+Pj4NCj4+PiBGaXhlczogYWM0OWI5NTBiZWE5ICgiZHQtYmluZGluZ3M6IG5ldDogYWRkIE1p
Y3JvY2hpcCdzIExBTjg2NVggMTBCQVNFLVQxUw0KPj4gTUFDUEhZIikNCj4+PiBTaWduZWQtb2Zm
LWJ5OiBTZWx2YW1hbmkgUmFqYWdvcGFsIDxTZWx2YW1hbmkuUmFqYWdvcGFsQG9uc2VtaS5jb20+
DQo+Pj4gLS0tDQo+Pj4gICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L21p
Y3JvY2hpcCxsYW44NjUwLnlhbWwgfCAyICstDQo+Pj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L21pY3JvY2hpcCxsYW44NjUwLnlhbWwNCj4+IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9taWNyb2NoaXAsbGFuODY1MC55
YW1sDQo+Pj4gaW5kZXggNjFlMTFkNGEwN2M0Li43NjZmZjU4MTQ3YWUgMTAwNjQ0DQo+Pj4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9taWNyb2NoaXAsbGFuODY1
MC55YW1sDQo+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9t
aWNyb2NoaXAsbGFuODY1MC55YW1sDQo+Pj4gQEAgLTY3LDcgKzY3LDcgQEAgZXhhbXBsZXM6DQo+
Pj4gICAgICAgICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+Pj4gICAgICAgICAgIHBp
bmN0cmwtMCA9IDwmZXRoMF9waW5zPjsNCj4+PiAgICAgICAgICAgaW50ZXJydXB0LXBhcmVudCA9
IDwmZ3Bpbz47DQo+Pj4gLSAgICAgICAgaW50ZXJydXB0cyA9IDw2IElSUV9UWVBFX0VER0VfRkFM
TElORz47DQo+Pj4gKyAgICAgICAgaW50ZXJydXB0cyA9IDw2IElSUV9UWVBFX0xFVkVMX0xPVz47
DQo+Pj4gICAgICAgICAgIGxvY2FsLW1hYy1hZGRyZXNzID0gWzA0IDA1IDA2IDAxIDAyIDAzXTsN
Cj4+PiAgICAgICAgICAgc3BpLW1heC1mcmVxdWVuY3kgPSA8MTUwMDAwMDA+Ow0KPj4+ICAgICAg
ICAgfTsNCj4+Pg0KPj4+IC0tDQo+Pj4gMi40My4wDQo+Pj4NCj4+Pg0KPiANCg0K

