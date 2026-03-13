Return-Path: <netdev+bounces-267270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9Z4sItZzs2k7WgAAu9opvQ
	(envelope-from <netdev+bounces-267270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:17:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1AF27CA01
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9694D3080123
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180451D516C;
	Fri, 13 Mar 2026 02:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RMrZjCkP"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010057.outbound.protection.outlook.com [40.93.198.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B572B1A267;
	Fri, 13 Mar 2026 02:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773368276; cv=fail; b=DiS3/tGNnlzykRFk0nFR6t7gZOFIMFTXGaNnRGa8ewoZvDDEi7XKrmk2SKc0q9bm4/fJvLakaxRUCgx/0YCOWmACmyW5ZUcO2Np9EnoMKKf0HDyU3WqCH0LvzNY7YyuMJS7DRF1y5IPfMfYgDkSPrhbnCZvlRihp+Ex2pofkN4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773368276; c=relaxed/simple;
	bh=a8EwH8DndYZIJcTIScD3d7ado1wDGvC4kUo/RcfJV9c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qA7Bf1W1bnfE/6xbl95oKSytTWzkzc5YZZxrQtqHUFK3z0MR6RVvxgfsDXfCoFuoYeARPqPEXtECY6pDW2TcdjU+wuYs7vHhEsILZ6zgNJstMiLxMuv9tlGWvOlRjbSNcc8MTIK9qzQLIoBg5ZeJZqVYLY2gcw1ZNI5T+4igtKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RMrZjCkP; arc=fail smtp.client-ip=40.93.198.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BendSNvu+bGm8Ww8KV8zWJ3eueY3gkHQuVv3XZtkfB63nYDVim4wvds10YyDFkQEchrkbdQLrl5uXcFl0SBoHXJDFQbrXZ9gax+Qkd7M3NKYP+rmBGevNzx7EahTvsNvmKiEtVmY+6vZQWP2KiWTruIRLqu5Fs93lnvjJpxKyZCOntAwhSbfPseMYzFg/8jCQxuD6lTWV2hd0fjsRJG/9zYXte9HpJS8Pf8/kWVM0iosjurMk/DhUPb1HFBBLV1xdcxIDKctP+XIWTk5O44LtoaqX4UDTZdtH4yn04+XgKr76BdiXSVLSDswk55hl03zmxBfu8ISg/HJfG+LBkaPBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8EwH8DndYZIJcTIScD3d7ado1wDGvC4kUo/RcfJV9c=;
 b=Ji9tYHj+PpR/L753yc08N/9IY7MXQKWEZLp65If/v531ozBEwlmKb0PF5r6iwcVzuA/be0Hnzi2VHillp8nQd3Rp2SVMkwQ9evbpVjIYuDVf8uX0kYGzeaHqPyoG0mOnUWhbB9h5TuTimHqghq/zEAVIaF4q1VX+JHfsyHJt51FUgNBTPzDHE10QG7OJWM9sxizpPUtRNOB6BZ6dQI/KKfTevpaHUNwAEW7Zb2rl9DLOwh+4J9W19JKzbGZZ+0RHUqZ3qlIGSCljyUREd56BJlUl89SbNANqEZ+F5TzHK5tP4Kx4xc8VVQ4Hbf5QOCHTag+NhxE0qxmNsbIDyuqHPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8EwH8DndYZIJcTIScD3d7ado1wDGvC4kUo/RcfJV9c=;
 b=RMrZjCkPJtcTpC0hh1XthETVA61GiXTxqR7p9/2vvL0qRES4HSaefkBvU3EWcfqrt6I97ijHf7I6xkzILkN4ny3VxLVuH1ff0m6CjWG9Pw5WhGkWB3N9dYBLcOeLpdqrLTvqEVLIXqtWarFlscYxPRsCnoODfZpeXYnmNDl5BS88Q4itmFg6SLEJIakU8ree9ipoQtFPzX1i4jhJbCfKPI7JucXAdU1uG/WM+0CVtjPVr21Ye2NgFIJTGift7/biaMvesX4qX4FvFot0KU4vN38Es42dkz3UaIz31vfZrkiYt3GaxbGPKwjzCOOJSlVx4Nme9QzxK587EzWbU7pZbw==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 SN7PR11MB7975.namprd11.prod.outlook.com (2603:10b6:806:2eb::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.6; Fri, 13 Mar 2026 02:17:51 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::caa6:2f2c:cd5f:90d9]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::caa6:2f2c:cd5f:90d9%4]) with mapi id 15.20.9723.000; Fri, 13 Mar 2026
 02:17:49 +0000
From: <Tristram.Ha@microchip.com>
To: <bastien.curutchet@bootlin.com>, <olteanv@gmail.com>
CC: <Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
	<horms@kernel.org>, <pascal.eberhard@se.com>, <miquel.raynal@bootlin.com>,
	<thomas.petazzoni@bootlin.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maxime.chevallier@bootlin.com>
Subject: RE: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
Thread-Topic: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
Thread-Index:
 AQHcq8BZxyCiqHlsBEeDQ14VW7yu3LWftUwAgAAtaoCAAANygIAAH+SAgACs27CABX1SAIAAhfyAgAJuqICAAB8cAIAAEK4AgAAReQCAADL0AIAASjAAgAFhKICAAH9iQIAAA5hQ
Date: Fri, 13 Mar 2026 02:17:49 +0000
Message-ID:
 <DM3PR11MB8736E9D0EA3DE91853A2E41FEC45A@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20260305125149.ejju5ptrkviqi3sm@skbuf>
 <a3a915af-5190-4582-a3e6-4ebf92a7e35d@bootlin.com>
 <DM3PR11MB87364DB5439A20F44AEB690DEC7AA@DM3PR11MB8736.namprd11.prod.outlook.com>
 <0658868d-671c-46a2-8daa-26420cdd2975@bootlin.com>
 <20260309205401.bk5fpw6kqnmlktbu@skbuf>
 <dde60639-af13-4653-9a34-38c4bd98b149@bootlin.com>
 <20260311115356.windefb3j4kkuslg@skbuf>
 <c3812b1f-50b7-4663-92f5-14c5c6b483a2@bootlin.com>
 <20260311135610.oox5ahxcyvxkuegw@skbuf>
 <c9c990b2-0fe3-4329-9a1a-e29aa0c9a6a6@bootlin.com>
 <20260311212404.xsx55lh3gnuze253@skbuf>
 <cd3acaab-5b77-461e-bbcf-de475ee29280@bootlin.com>
 <DM3PR11MB87360F40688561859B685425EC45A@DM3PR11MB8736.namprd11.prod.outlook.com>
In-Reply-To:
 <DM3PR11MB87360F40688561859B685425EC45A@DM3PR11MB8736.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|SN7PR11MB7975:EE_
x-ms-office365-filtering-correlation-id: c2a35c7a-a729-48f6-2c30-08de80a6b926
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 0x44I4GFSS5l43M+tVBQ0JavMYNh5IW4pZmMW74eorVwszvNSzyFv4tE9bRA4HWNezksgzQynMaCMrqYKjKGzb2Alk3UIeN0FgDJl6My3jo3z/yU5h+P5hpZW8d1aT4Fhfi9MkWmfEsQyUvuOZDL4UkCxovOZWdhlaF/VY5OUuwbB2p4qMZmFez2Q0+VD6sbjY1CXz0imnlLKgnxDtUFbRRkguP9HOm7akjjn3pvDFEx8XKRZuyvAKsZnvXgfp1UEfCJ13to31M+RB8N98n8VlZHf4F7/wenBkVMM+1Q6CjiDh+Y2WNNV7/KVWIf2VYaGnYMeQN++HwenpVa0/Ee4I25vBS8wLf5jqs5GeITk1PfrhqDRgNkHfb/BkZ1pNt3YU5nc6xEaSsfgl2mdFlkbPPU6gfPO7TL6lkQ96I+2n8Ig0TF/t2FhPN4NtHtaR73P9jAQdES6edWS00ihia2/1W6EplF0ObGf5S+xGQ7vmC+UQWPT3NTlBAPsbmUX5LVk8NipYICASLtsBx1sdq8ovXaBixbHmVbEJEbR5hx1b5X0NJxn556gJn3Gbsv7f5jTNUjxshzctONCB3HjBmFoTxMkKxAuUSOQyQ8986/F4wX/uVBeGoSY5u6Q2Vi99aqjl77fT9pu/x5hfftSJ5hGv3kJThJr+N8+Qmw4a7chIcddjYz0MkUUhH+MJlzZT+M58iMwIPYvqGowZll1yJmrR1oMnsVKXUBt4fd8queR/vVMgZ8pocgr5HN13d47HTSn/40Nl940urkfhsZpZUEr+PYXtg/OaKSbDKX7AeKHZ0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eGhtN1cxUmFqZ1F1WVl6Nm5mRm9ZSDJDWEFCdXhyM3ZWUm84dkdKaDZPRDJV?=
 =?utf-8?B?bGpaL0xZMjExN2ZlSVdaUCtrcFBmeDRUa3ZuNlkyd3NrMlhKUWowbVVRaFZQ?=
 =?utf-8?B?ZHluM1AzRnU1YVRXODM4ZTVEUU84RmFuR044TTc0ZFBvMkYxeTFLTktmY3ZV?=
 =?utf-8?B?TC9GWEIzNWsrRURUUVlrWXJVVDREc05Md3BDNGZoTjVOdVJmSE1DVGJ6cE9G?=
 =?utf-8?B?VlprQmd1eisxSEwwRUxQVURmdjN4NUdOOUEyV1RndllBSXJUTmgwbitLK0cr?=
 =?utf-8?B?UWwwMllkQUNUMXBwKzRNTktDYVRBSzNmZ1pNMGNtUVVBdjE1VVdBWHJLWWtz?=
 =?utf-8?B?YjJBRktHdlEzeCtoNWQ4ckZDN01qdEFmSElCZndkWTFLVGZ6bS8rMjE5eVVu?=
 =?utf-8?B?a2NjbUNJV2w5bHhiRWllSzdBRjlvRHpzNkNZQWt3UkVuWUFRQzBMejYxME9r?=
 =?utf-8?B?dUc4S2tlSkFkUy9XUUY0dmMxYmJXemhpYmY0Njg4bDA2SHFYRlRiOUxmRTBv?=
 =?utf-8?B?SGFRVHVZOGNKQ2Q1M240SWU1WWFvbzNlQ2o1N25pRzNPZ0hxN0JXbElJQjcr?=
 =?utf-8?B?M2xOVHB1VVV4MDZyMzhCSURNU0xkeXRabW5qZUxrT1MzRWtSMHVXejdoK2J5?=
 =?utf-8?B?WUhhNndjVGJTTWxsVWJTOWRkd0NBUlp1QU9mUFFjRWxIbGJCbUh4UldHaUdj?=
 =?utf-8?B?TklBcEFDM1FieXpkYVlqN0R0em9kdndsWXpHMnR4MTVrZE5aN1Y1YjcyYnRN?=
 =?utf-8?B?amdCZnY0ZlN0ZThtcGxqN2gvTWdUWGdaUVJyelY5bnRNVWtQT1dZZmJjdlYv?=
 =?utf-8?B?ako0bk8xb1AyalRHNVVaaGx4bndFdnFJU1p4NUU4YWRHTE5PSnI0R2U2SDRZ?=
 =?utf-8?B?YkJ6K0JsVnRYcGFLd21hUDlnbFZ0OTVBWCtnYUNYSTAzMmQvMmhtSFRmWE40?=
 =?utf-8?B?aTJXaHl1MUNnRmVMemFtUFhaaHp4aUtvRG4rWWpjSjFrQ0pVUHcwdHVIMHhp?=
 =?utf-8?B?MU81VlM3UW5RK2NJZG9lWEFTUHE4VUNKc3ZJNmVRWW1GSkpBQkpWOVU4RGtS?=
 =?utf-8?B?RGdnanZDdHIrRG4rWW1sQjF0eUNCMUV5VTFHSUZpN0hDWUNWNVRwM1pQZ1N5?=
 =?utf-8?B?UFpLUzROMTUvdDkwZi9YRmlHQjIrRUlOZ2pwazZLbFZQRHpKcktIV1pWZVV1?=
 =?utf-8?B?eUtPNUZpd3ArUjBqcE5MWmdlYkt1OVpPZGY2YVdwQ3VicU0yR1FsLzNWRTZX?=
 =?utf-8?B?S0NIay85RDF5T1crZXVEQU5BdlQ2YjdRN056SFN2U2ZTNGZCWnpqU0ovY1Zy?=
 =?utf-8?B?UkJhVXp2a01ta3RPSk9sYzg2NmQ4a09qYXN6b2xpYUlrL052QVkwM1l6bExN?=
 =?utf-8?B?MGEyUjVlZUNkWHkwTjhvQ2xuN1pudVBLajIwMEhjejRlNjhrc3VZNE9scDg3?=
 =?utf-8?B?c21INmZFQlplcjh2cGFvYlIrMDJWZkpjQWhUbTk5ckFVNitiQXhrMWdLREhy?=
 =?utf-8?B?RVpKR1RZNXZKb2VjNkdrVWtCQWQ1SU5VWS9WRzdKYkZ1aFp4WVI5TVlnRlBC?=
 =?utf-8?B?UUJ0ZEVHTWN3TDZ6QkhRUnVMSFdBenVJRy9MNXE2cWN3QWJNamltM3Y1YzR5?=
 =?utf-8?B?dVhFM0lNektLL3hNdEtkK2thRVZPYzBCRHhiS2NzU0xKdnFOZ0RzakVhMjZS?=
 =?utf-8?B?QVpZbmd0SWt2anJNTWp5TE1FUlpON1dmQ1FPemlxS0ZKUVY2UVY4b1VVRWpI?=
 =?utf-8?B?S29IUWNSMGk5eWw1eks3Q1RxeVo2dXFOOFUxNk5rU3M1VFNlYVY0ZTNTTnJU?=
 =?utf-8?B?QUxUTThzdFJCS2x5TWxWRGtxakZaS2JtcmF0eVlRRUJpcG1qV3BrM2VDdXNB?=
 =?utf-8?B?N0lRMjVkc2lrVERzMWFsUWtTZXE0K0tURXhnREZOSDJUeWtkTVBaeFduUENP?=
 =?utf-8?B?ek8ycVBVVXZJaE1Kb3pqQTJxUWlhUVRzNDhENEpvZE5tSmF0UFFZRk16UWNq?=
 =?utf-8?B?U0pLZHp4L0dvZVpSSjRZVWs5bDVNRGFmTWcySFgzZjZibGJzUGNhODN3M25n?=
 =?utf-8?B?U1pLTWludFFHVlg0cnFWeTlGRmdNbTlHR3h3dVpmd1hjeWNGTHRWZ0JXSXgv?=
 =?utf-8?B?ajFwbUN1bFZ0V3NhQUlLVDFXY3lzQzY4amdVVDFXWXFGMDAyZEY5UXkza2Fv?=
 =?utf-8?B?NlRkeW45cDlULzZRZG9iZEdrZjZXVW51SU1PSW5yZjQrWUVOa3NVZ2t1b0xw?=
 =?utf-8?B?UlA4NVV6dXYvUWFsbklGK3FwVmRzNGxPazJ6aDd2Uk82K1JKTU1hRm92Nm15?=
 =?utf-8?B?M1dYM2VYSmdZVUlrQjIycFFzcnBIWm5VVll3OGFPTXVlR0RvaGF6Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a35c7a-a729-48f6-2c30-08de80a6b926
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 02:17:49.2018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8mIdoyzIxVoMlr7iUV2hutCAvpg3bElDQtjuyieqVgtz6HEak5O412RNKh9x9ZYrC53hvklHXRmgzApel29TYaLRCxf5a7p63RAwDcrIjA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7975
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267270-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Tristram.Ha@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,DM3PR11MB8736.namprd11.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB1AF27CA01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiA+IE9uIDMvMTEvMjYgMTA6MjQgUE0sIFZsYWRpbWlyIE9sdGVhbiB3cm90ZToNCj4gPiA+IE9u
IFdlZCwgTWFyIDExLCAyMDI2IGF0IDA1OjU4OjMyUE0gKzAxMDAsIEJhc3RpZW4gQ3VydXRjaGV0
IHdyb3RlOg0KPiA+ID4+IEluIHRoZSBlbmQsIGl0IGZlZWxzIE9LIHRvIG1lIHRvIG1pZ3JhdGUg
S1NaODQ2MyBpbnRvIGtzejg4NjMuYyBidXQgaXQncw0KPiA+ID4+IGhhcmQgdG8ga25vdyBmb3Ig
c3VyZSBiZWZvcmUgYWN0dWFsbHkgZG9pbmcgaXQuDQo+ID4gPg0KPiA+ID4gU29ycnksIHdoYXQg
a3N6ODg2My5jPyBJIG1heSBiZSBtaXN1bmRlcnN0YW5kaW5nIHNvbWV0aGluZy4NCj4gPg0KPiA+
IEkgbWVhbnQga3N6ODk5NS5jIHNvcnJ5DQo+IA0KPiBJIGFtIGZpbmFsbHkgYWJsZSB0byBicmlu
ZyB1cCB0aGUga3M4OTk1IGRyaXZlciBieSB1c2luZyBmaXhlZCBsaW5rIGZvcg0KPiBhbGwgZXh0
ZXJuYWwgcG9ydHMuICBOb3cgSSBoYXZlIGxhbjEsIGxhbjIsIGxhbjMsIGFuZCBsYW40IGJ1dCBJ
IGRvIG5vdA0KPiBrbm93IGhvdyB0byB1c2UgdGhlbS4gIFVzaW5nIGEgYnIwIHRvIGNvbWJpbmUg
dGhlbSB3aWxsIHNlbmQgb3V0IDQgcGFja2V0cw0KPiBmb3IgZWFjaCBvbmUgdG8gYnIwLiAgQW5k
IGl0IGNhbm5vdCByZWNlaXZlIHByb3Blcmx5LiAgVGhlIGluZGl2aWR1YWwgbGFuMQ0KPiBkZXZp
Y2UgY2FuIHNlbmQgYnV0IGFsc28gY2Fubm90IHJlY2VpdmUuICBPbmx5IGV0aDAgY2FuIHNlbmQg
YW5kIHJlY2VpdmUNCj4gc28gaXQgaXMgdGhlIG9ubHkgb25lIHdoaWNoIGNhbiBwaW5nLg0KPiAN
Cj4gVGhlIGxhbjEgZGV2aWNlIGNhbm5vdCB0ZWxsIHRoZSBzcGVlZCBvZiB0aGUgcG9ydCBhcyBm
aXhlZCBsaW5rIGlzIHVzZWQuDQo+IEl0cyBvdGhlciBwdXJwb3NlIGlzIHRvIHNodXRkb3duIHRo
ZSBwb3J0LCBidXQgdGhlcmUgaXMgbm90aGluZw0KPiBpbXBsZW1lbnRlZCBpbnNpZGUgdGhlIGRy
aXZlci4NCj4gDQo+IFNvIHRoZSBrczg5OTUgZHJpdmVyIGlzIG5vdCBjb21wbGV0ZWQ/DQoNClRo
ZSBTVFAgc3RhdGUgb2YgdGhlIHBvcnQgd2lsbCBiZSBjaGFuZ2VkLCBzbyB0aGUgcG9ydCBjYW4g
aW5kZWVkIGJlDQpzaHV0ZG93bi4NCg0K

