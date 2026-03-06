Return-Path: <netdev+bounces-264604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sI1vNIspqmmQMQEAu9opvQ
	(envelope-from <netdev+bounces-264604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 02:10:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F3721A291
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 02:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBF313012BE8
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 01:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F18830F7F7;
	Fri,  6 Mar 2026 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GSk5kq6M"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013049.outbound.protection.outlook.com [40.93.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7C430C61B;
	Fri,  6 Mar 2026 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772759430; cv=fail; b=jwAysTPTnghDjUntI1jejHsA5KuAfYPdawwYwKb7SGyw9q4AimfuNIVOIjSNXMWm0J67ZzQme4LTo5MCc1uGuAC4ns9R0+wZxzJCxAQlp+Uqvm3+QKw62sJ/KSZFP27xoC/nKnii8ZEuf5evmDSgLcFMX08eTBxiKDObf4MaaoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772759430; c=relaxed/simple;
	bh=dh1i74IeOMwmORVbdCtzRopM54jpdhBGcOFKj15ELtM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GRtiSE8cNSlX759f6mcqzTCWl/H+d7703PSqzp06oXVxpaFB1wWZ/1mwnKKyp+4R3vRowQ/iDX8EY4KUnwmCHyAtUyd1UnRKN0oXGU5WpiSHbJfM1f5NfbmDhDyF9ZgncL7GclpecaDrwsZ5MzYJIBDsO1+WkIexdkyu6lk7gdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GSk5kq6M; arc=fail smtp.client-ip=40.93.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKrD7gVX4yzC4nHlqhEnKkkyFjGnCP6IZela2rLJlR03WE3SAYUt8RiX4VsaUex7TRtxzBAQ8MqGUf5hFri/88hLkzDc13MOC6Y/KSwWVeNji8xH316kffSy4mHQBwDAmCuoHR4xdeCmSJ8UxvbK8cZGMSeWcAyPZTZnC2rtxXs868T4m7gVA5tVH9Kj6a4/RoIf+saxBAnmkaVhNaTej8Adx7KV3t91WEc3Yfiz/YRPhpJo4KK3kHjE7WKlkThL+EvIRc7YHDsBne95lwlYNuoFRInEZnsXJiICq9AiLidLE7fGLEneA8ebjk7ythqvXGTD0n+IJFD0zL4pNqAYgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dh1i74IeOMwmORVbdCtzRopM54jpdhBGcOFKj15ELtM=;
 b=muDwimYXYrS9PvsRBNum/1qP3H8VHvojNyN8EI9SAmV2OWe8lv0T6rrqtBmMY+BxQFAyXxo2WUx3nQNfwduiyf3mommAy2UdjOVgumD3KMVCBK2jU2+sf3HsA0IGVSH4sB6yqBwvrVf9jtNOEmVdxeOCSQRo4wTTaYPHVbzwWukGIZhyMZz5KsSH+tEZ92B0f2dY81N3L8440GrAnAbbW7+TzzDE8lgIAC5Wb3WuDJ+fu5UPbMUI+h660dxfGxtx26wvPruKurHmlflcHYBvQhlklmRlinMGeIpyBrTlHy6ExZTaZDVxi5Z+abw99rdz7odzUJZyHzWpuSm8vKiOCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dh1i74IeOMwmORVbdCtzRopM54jpdhBGcOFKj15ELtM=;
 b=GSk5kq6MGXuGY2F8tvSNA4/EY/0FwWddH8eTMkkbZCzWvD3WriSHEa44XVU865hZhwOD3sjAfSl+rZzBN4F5EZ1Is3TETXlM5WIxrir+IydqZT1NzsUo+hXzjLz4Lu8vVXXbEHtIkCK034WuHMuNSqS8M1bOxcvh54pKwbRxdC6mT7yyo+YkOig7zSSjSKZMzZp4YR2fUUgd+m3jTv1k7Y/Si2oO0GnutE0pQpSg1LVyP543nFFbJBnZfNrq69uik8dL18h2iJ2HvMkyqMawE7oS8/YwsTC+JyYZXQManDWwJ9vr7suuQGI9WpgnXff8OceBXeZ8u5xYO/BKhnKvFg==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 CO1PR11MB4932.namprd11.prod.outlook.com (2603:10b6:303:98::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.22; Fri, 6 Mar 2026 01:10:25 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::caa6:2f2c:cd5f:90d9]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::caa6:2f2c:cd5f:90d9%4]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 01:10:25 +0000
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
Thread-Index: AQHcq8BZxyCiqHlsBEeDQ14VW7yu3LWftUwAgAAtaoCAAANygIAAH+SAgACs27A=
Date: Fri, 6 Mar 2026 01:10:24 +0000
Message-ID:
 <DM3PR11MB87364DB5439A20F44AEB690DEC7AA@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com>
 <20260304-ksz8463-ptp-v6-1-3f4c47954c71@bootlin.com>
 <20260305095656.vlyaztv6nbdqrmil@skbuf>
 <98944cef-0877-4fb9-83a0-92bbd3852f66@bootlin.com>
 <20260305125149.ejju5ptrkviqi3sm@skbuf>
 <a3a915af-5190-4582-a3e6-4ebf92a7e35d@bootlin.com>
In-Reply-To: <a3a915af-5190-4582-a3e6-4ebf92a7e35d@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|CO1PR11MB4932:EE_
x-ms-office365-filtering-correlation-id: e278fbd9-4ce7-469e-3822-08de7b1d25ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 W4R6nzf66wXOXfdVU2wcxv6C12n1hHHc4kLbuOGmPHl7RSy4QCXU3/TnC1igVvC41sBskhvDYas94QUXli2C+nFaxB+xC5/FEepTIJW46Xead/8/VQBUnMGX+3kILcfYAE9jzYJhsEjzIlsktgB69WL1nE5JmIfhDFte8Q1tjuuKGY1CfBHfibJJuLmvDG0L7nd0LTNxcxniiVFwtWGVjcwFONGaqT3/gEtdwqAcS3CRuUc+JepFfzw9DATK8pHiYXKzIepR0U9816XfigZ+u+SrBBSUsim/RfPdIIglOwVGi9mJ6BOvdN7DMHXY5lKynYt5jw4rLOVpdbkOXNw3rtLz2Kxkd/yA276xJ5dUMhRSwURS1j7k1tOPYVlQ/eUQeiC/Z5K3TDywAd0yRQrcGLTuYISSXOD70A2FdoZS/LAP7ExC96ZT0ergtEIUURNQICOSVElwzuukg1T5E1kodeTeE/Aw0BEx0hh7NIwH4vGxIWQrbAOi7J9M3xzU1yEKpJZLetyrQuzfgOV6f5KM+EyJXBjpCXnb0oF5IIluAKBxec5zb0QPsbdZq57CRjdIl3GHyINLJwtSQuU4R3bSwyScEUBIUQHCYGiX/mB2IZ8A1+ZXvppfgxASX1AjEk1yXYuRgY2mHPnsnDv6PNFfxXI+6OgtuyqoQ+lAgYeQ85SmxsnpFchlP6yi0xoAGpNNS3t12+SJJ5yBzH7Vlvuz2u7k8nfO5FuYKs9aI5EcI3o9QzobJYZ6y1QHDMQ0xOR0hyMA85i4gvKkt3zZwUo4UOt1xI+fU3sJaLMKfFysXMo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXAxTHVrNndZdFNPWjNIb0w1QzFIdHBpSDhmSG1pZmM0Sjdac05aWHJ4a1pO?=
 =?utf-8?B?aEpLTlY3dGxYckt3UWszd2NWTGRDa05SVWhTbElYZks1OHJHMFgwMnFxcXNu?=
 =?utf-8?B?ZktqeFZnSWpFbmMvbEUrN0hVRDYvaGpxdklFSlpLZ0dVTGNyQVNhMEs4b2ZX?=
 =?utf-8?B?MnpHNEtmQWRvZjZ5SFFYZitHU0VGV01oMWtLblB5ZE5vY1lGejdmWHdjR1Fa?=
 =?utf-8?B?T2ZLdnBxWlV4cEFVRGZmUFVEb3VzMmRVZUNLYzNMdzdvUFNHVE11aXlGRncy?=
 =?utf-8?B?MDNDZDNyaitoZWt3UWZ3anVUZk51aW1CVjY4MHdyUkptbElKV3Bnblp4T2ls?=
 =?utf-8?B?RWlwcGEvSU9mMnAwdC9NNUR1U2gvbDhXdVgwVC9ONXR2SXF5M3ZmckNRVlM0?=
 =?utf-8?B?bHVIVmNNR29hbWd0ekQ2ZzJxZktvS3MycEd4dk11eGRYUU5DVWxmWTBUb3NJ?=
 =?utf-8?B?K25rSCtKa0RiQXd1SXVoeTErMmdTSDhheWY5REN3QnYyOXA2eEV4WWNCUFA0?=
 =?utf-8?B?T2hIVWR1NWVVa05iRjRQVS9XNlFROFJpanpqSDhMTmxNamExZThTbjFyc2dF?=
 =?utf-8?B?Qi9sS3lxWHA2SWNTdnI0VUxkaS9NMU9ZUUxWQWYwSklGUU40L0gyczBscGYz?=
 =?utf-8?B?bHVZZFUwS1NHanR6ckNoNm9JYktkOFBoV05jNHFRUnN5UzBqYnhxWWszOVZT?=
 =?utf-8?B?c2t1SksxbnN4a2h2OFlMdWh3SGdEZUJQc3ptSWsrMWh1MTBBc0p3VXF5N3pX?=
 =?utf-8?B?MzhCelkxOXdqRmdleFN1dHBJUVVhS3hud2VOSFNPdUgzdlVmTGxsV3hCQWJ0?=
 =?utf-8?B?SnRUY09LOTJZSEJYbHhyQU5ZVlJ0NkRVZmlFL1ZtSVcybHd6TjR3cEZ1YVh4?=
 =?utf-8?B?QXBKQ2J5eHlSTmVMYnVQK3lKS3RuQ2FTek8rNlNWWDEwZVIyY1dJeUlpYmJh?=
 =?utf-8?B?a0NIOHNKNHdWSU1XL2VaMXdXTGt0VEFKeHlYMmxjSGpmRUdhVXE1K011cjBK?=
 =?utf-8?B?YmJZVXBCeEdVdW1DSk1GVVNEODBCSmNWVVRjRDF4VXJxWWR3dmFTMURzTHF1?=
 =?utf-8?B?T1RlRWx3bTV2djNkcVNlM1VhM2EyV0FqS2JFdzhBTy9TZi90Zjl6RGZ6SWpq?=
 =?utf-8?B?WitMTzZySkNLRWNWNEdjbWN6U0wxamxsRE1zaHpWZDJOUVlFejRXOXpJNU5J?=
 =?utf-8?B?UjRXK0k4VXFtYW1TbFE3QkVGS1RlZ3JaU2RBbFZIM3VIanBuSDYwK2NrMDhS?=
 =?utf-8?B?bnFiWjZvUVZISCtWemd5ZTZDeEt4M1JuZEoySXBiNXczVnhpUlo2cWM1N0gy?=
 =?utf-8?B?T3dBQitoRUlXWTQ2TXpCNi9aTlQ0RE1xRHVUVlVWTGpCOGhxc2RRbW5aNzZv?=
 =?utf-8?B?TDRpazduZGhwN29TOHhlMWFlR3ppTjFTU1MvTlUzdFJTOGtleEpYUXk0K1F2?=
 =?utf-8?B?dGh2Z3ZKU3FlTTV1bXcvRElsN0duZCtHZXNpTVd6Ujl3a1JkWFRFZDJCYkd6?=
 =?utf-8?B?TG1MTXk2TVE3ZUM4Z0RFOFZscDNBYmt6eCt6SS9xZllnQVczTDM1dXpPT2Fq?=
 =?utf-8?B?YlBKdUw3dFo5Zk1HNTAzQXhMak5vU0s5MmR1L2g0d2xyYnl3V1F6ZVVmYnQ4?=
 =?utf-8?B?azY3U3hMMnhYWDBFbTJVSXd5dCtHVjhZRkNmSjdFd3RTT0FBUmFUd1lEL0l5?=
 =?utf-8?B?SEV4ZXUrSERvYjFrMms1TFNlTk9HM0NMYUFxSC9JeVBKbElqOEFiWVgvUW9S?=
 =?utf-8?B?TEhGc1Y5SGdJdHJWbzVwVWZIWW9OZDZ2YjcxWm1aVjVlWlkvYjQ5eCtzYkc4?=
 =?utf-8?B?WGc3VjRKeWVleE1DMGR2VjBRbldWMGxjOHY3Y21iZVhzdVo2Unp0dlFxaUFC?=
 =?utf-8?B?VzMxYTRDWXdpSGFGdTBJQ1BFVzU1L2d4K1VHdkNhQ3FkVUJPMEdkNmdLcUdm?=
 =?utf-8?B?S0xUaXpSSzJUekIwV0tMbFBzai9nWVRmRkd5L1laMVlxSlF6akZsMG1WSXAz?=
 =?utf-8?B?bWkrQzQ1VmNsQkRoOFFwU0RXMGxSdzhhTDRyak1IT0lPdWsxZmY1SytuMm94?=
 =?utf-8?B?akh6Qjl5blU5cmdqb0hzUEphYnMwT21TY0ZPYjlaRFBGUTNVWFd4aUxYME9z?=
 =?utf-8?B?RjJPRGdzamlxaUVpN2ZqZ2lTRjEraktQeGxzSngwenV1OTE0SXNGWmJNTS9q?=
 =?utf-8?B?czQ1QXdvekZUS0V2aDZlT3JNSHB6eWRaV1Q0L213Q3BKdmF1d2JOeXFndEM5?=
 =?utf-8?B?azN1NDg2RUtkKzMvcm0vSWpHY0RnVWczZUczamxQc241a3owQVU0bUVRZ1R0?=
 =?utf-8?B?cHZHVUdJTnFxOHR2bHpjSjQyY0kyN3hGSWMwYXdrUHNpbXVrQ0ZoUT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e278fbd9-4ce7-469e-3822-08de7b1d25ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 01:10:24.9919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A7cSlaiLwx2gaJn/t7Zt8e88Z0d2lTor+2nrMjXLJiEzxnaopz3XDC35WjgsehpKzvy9GcDcn3GhtL8XHNIr2HU/bHKNdTPzXYELwPktWbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4932
X-Rspamd-Queue-Id: 29F3721A291
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264604-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[Tristram.Ha@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,microchip.com:dkim]
X-Rspamd-Action: no action

PiBPbiAzLzUvMjYgMTo1MSBQTSwgVmxhZGltaXIgT2x0ZWFuIHdyb3RlOg0KPiA+IE9uIFRodSwg
TWFyIDA1LCAyMDI2IGF0IDAxOjM5OjI5UE0gKzAxMDAsIEJhc3RpZW4gQ3VydXRjaGV0IHdyb3Rl
Og0KPiA+PiBIaSBWbGFkaW1pciwNCj4gPj4NCj4gPj4gT24gMy81LzI2IDEwOjU2IEFNLCBWbGFk
aW1pciBPbHRlYW4gd3JvdGU6DQo+ID4+PiBPbiBXZWQsIE1hciAwNCwgMjAyNiBhdCAxMToxODo1
MkFNICswMTAwLCBCYXN0aWVuIEN1cnV0Y2hldCAoU2NobmVpZGVyDQo+IEVsZWN0cmljKSB3cm90
ZToNCj4gPj4+PiBAQCAtMjg5MCwxNCArMjg5OSwxOCBAQCBzdGF0aWMgaXJxcmV0dXJuX3Qga3N6
X2lycV90aHJlYWRfZm4oaW50IGlycSwNCj4gdm9pZCAqZGV2X2lkKQ0KPiA+Pj4+ICAgICAgICAg
ICAgdW5zaWduZWQgaW50IG5oYW5kbGVkID0gMDsNCj4gPj4+PiAgICAgICAgICAgIHN0cnVjdCBr
c3pfZGV2aWNlICpkZXY7DQo+ID4+Pj4gICAgICAgICAgICB1bnNpZ25lZCBpbnQgc3ViX2lycTsN
Cj4gPj4+PiAtICB1OCBkYXRhOw0KPiA+Pj4+ICsgIHUxNiBkYXRhOw0KPiA+Pj4+ICAgICAgICAg
ICAgaW50IHJldDsNCj4gPj4+PiAgICAgICAgICAgIHU4IG47DQo+ID4+Pj4gICAgICAgICAgICBk
ZXYgPSBraXJxLT5kZXY7DQo+ID4+Pj4gLSAgLyogUmVhZCBpbnRlcnJ1cHQgc3RhdHVzIHJlZ2lz
dGVyICovDQo+ID4+Pj4gLSAgcmV0ID0ga3N6X3JlYWQ4KGRldiwga2lycS0+cmVnX3N0YXR1cywg
JmRhdGEpOw0KPiA+Pj4+ICsgIC8qDQo+ID4+Pj4gKyAgICogTW9zdCBvZiB0aGUgS1NaIHN3aXRj
aGVzIGhhdmUgYSA4LWJpdHMgbG9uZyBpbnRlcnJ1cHQgc3RhdHVzDQo+ID4+Pj4gKyAgICogcmVn
aXN0ZXIsIGJ1dCB0aGUgS1NaODQ2MyBoYXMgYSAxNi1iaXRzIGxvbmcgb25lLiBUaGUgb3ZlcnJl
YWQgaGVyZQ0KPiA+Pj4+ICsgICAqIGlzIHNhZmUgYmVjYXVzZSB3ZSBvbmx5IGl0ZXJhdGUgb3Zl
ciBraXJxLT5uaXJxcyBpbiB0aGUgYmVsb3cgbG9vcC4NCj4gPj4+DQo+ID4+PiBGV0lXLCB0aGlz
IGlzbid0IHRoZSBvbmx5IHRoaW5nIG1ha2luZyBhbiBvdmVycmVhZCAic2FmZSIuDQo+ID4+PiBJ
ZiB0aGUgYWRqYWNlbnQgcmVnaXN0ZXIgYWxzbyBoYXMgImNsZWFyIG9uIHJlYWQiIHNlbWFudGlj
cywgdGhhdCdzIG5vdA0KPiA+Pj4gZ29vZC4NCj4gPj4+DQo+ID4+PiBJIGNhbid0IHRlbGwgd2hl
dGhlciB0aGF0J3MgdGhlIGNhc2UgaGVyZSwgdGhvdWdoLiBUaGVyZSBhcmUganVzdCB0b28NCj4g
Pj4+IG1hbnkgaGFyZHdhcmUgdmFyaWF0aW9ucyB0byBjaGVjayBmb3IuIEkganVzdCB3YW50ZWQg
dG8gcG9pbnQgb3V0IHRoYXQNCj4gPj4+IHRoZSByZWFzb25pbmcgaXMgaW5jb21wbGV0ZS4NCj4g
Pj4+DQo+ID4+IFlvdSdyZSByaWdodCwgSSBoYWRuJ3QgdGhvdWdodCBhYm91dCB0aGUgJ2NsZWFy
IG9uIHJlYWQnIGNhc2UuDQo+ID4+DQo+ID4+IEknbGwgdXNlIGtzel9yZWFkMTYoKSBvbmx5IGZv
ciB0aGUgS1NaODQ2MyB0byBiZSAxMDAlIHN1cmUgaXQgd29uJ3QgYnJlYWsNCj4gPj4gYW55dGhp
bmcgZm9yIG90aGVyIHN3aXRjaGVzLg0KPiA+DQo+ID4gSSdtIHN0aWxsIG9uIHRoZSBmZW5jZSBv
biB3aGV0aGVyIHRvIHNheSB0aGlzIG9yIG5vdCwgYmVjYXVzZSBJIGRvbid0DQo+ID4gcmVhbGx5
IHdhbnQgdG8gZ2V0IHNvIGludm9sdmVkIGluIGludGVybmFsIGRyaXZlciBib29ra2VlcGluZywg
YnV0Li4uDQo+ID4gdGhpcyBkcml2ZXIgaXMganVzdCBiZWNvbWluZyBhIGhlbGwgdG8gcmV2aWV3
LCBldmVuIGlmIEkgd2FudCB0bw0KPiA+IGNvbmNlbnRyYXRlIGV4Y2x1c2l2ZWx5IG9uIGNvcnJl
Y3QgQVBJIHVzZSwgbGlrZSBJIHRyeSB0byBkby4NCj4gPiA+IExpbnVzIFdhbGxlaWogaGFzIGFk
ZGVkIGEgbmV3IGtzODk5NSBkcml2ZXIsIHdoaWNoIGhhcyBzb21lIG92ZXJsYXAgd2l0aA0KPiA+
IHRoZSBjb21tb24ga3N6IGRyaXZlciBmb3IgdGhlIEtTWjggZmFtaWx5LiBOb3cgaGUgd2FudHMg
dG8gcmVtb3ZlIHRoZQ0KPiA+IG92ZXJsYXBwaW5nIGRldmljZSBzdXBwb3J0Og0KPiA+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDI2MDIxOS1rczg5OTUtZml4dXBzLXYzLTAtDQo+
IGE3ZmM2M2ZlMTkxNkBrZXJuZWwub3JnLw0KPiA+DQo+ID4gTWF5YmUgd2Ugc2hvdWxkIGdvIHRo
ZSBvdGhlciB3YXkgYXJvdW5kLCBtaWdyYXRlIEtTWjggc3VwcG9ydCB0byB0aGUNCj4gPiBrczg5
OTUgZHJpdmVyIGluc3RlYWQ/IFRoZSBjb21tb24ga3N6IGRyaXZlciBpcyBiZWNvbWluZyBqdXN0
IGV4dHJlbWVseQ0KPiA+IGNvbnZvbHV0ZWQgdG8gaGFuZGxlIGFsbCBoYXJkd2FyZSB2YXJpYXRp
b25zLiBXb3VsZCBpdCBoZWxwIGluIGFueSB3YXkNCj4gPiB0byBtYWludGFpbiBjbGVhbmVyIGNv
ZGUgcGF0aHMsIHdoYXQgZG8geW91IHRoaW5rPw0KPiANCj4gSSBhZ3JlZSwgdGhpcyBkcml2ZXIg
aXMgZXh0cmVtZWx5IGNvbnZvbHV0ZWQgYmVjYXVzZSBvZiBhbGwgdGhlDQo+IGRpZmZlcmVudCBo
YXJkd2FyZSBpdCBoYW5kbGVzLiBJdCB3YXNuJ3QgZWFzeSB0byBmaXQgUFRQIHN1cHBvcnQgZm9y
IHRoZQ0KPiBLU1o4NDYzIGludG8gaXQuIEFuZCBJIGVuY291bnRlcmVkIHRoZSBzYW1lIGtpbmQg
b2YgZGlmZmljdWx0aWVzIHdoZW4NCj4gYWRkaW5nIHBlcmlvZGljIG91dHB1dCBzdXBwb3J0IChJ
IGhhdmUgYW5vdGhlciBzZXJpZXMgcmVhZHkgZm9yIHRoaXMNCj4gb25jZSB0aGlzIFBUUCBzdXBw
b3J0IHdpbGwgYmUgbWVyZ2VkKS4NCj4gDQo+IFJlZ2FyZGluZyBtaWdyYXRpbmcgdGhlIEtTWjgg
c3VwcG9ydCBpbnRvIHRoZSBrc3o4OTk1LCBJIHRoaW5rIHdlIHdvdWxkDQo+IHF1aWNrbHkgaGl0
IHRoZSBzYW1lIHBhaW4gcG9pbnRzIHRoYW4gaW4ga3N6X2NvbW1vbi4gRXZlbiBpbnNpZGUgdGhl
DQo+IEtTWjggZmFtaWx5IHdlIGNhbiBmaW5kIGEgcXVpdGUgYmlnIGFtb3VudCBvZiBkaWZmZXJl
bmNlcyBiZXR3ZWVuIHRoZQ0KPiBzd2l0Y2hlcy4gRm9yIGluc3RhbmNlLCBib3RoIEtTWjg0NjMg
YW5kIEtTWjg1NjMgc3VwcG9ydCBQVFAsIHRoZXkgc2hhcmUNCj4gbG90cyBvZiBjb21tb24gcmVn
aXN0ZXJzIGJ1dCB0aGVpciBpbnRlcnJ1cHQgc2NoZW1lIGlzIHZlcnkgZGlmZmVyZW50Lg0KPiAN
Cj4gSSd2ZSBhZGRlZCBUcmlzdHJhbSBpbiBDYzosIHdobyB3b3JrcyBhdCBNaWNyb2NoaXAuIE1h
eWJlLCBUcmlzdHJhbSwgeW91DQo+IGhhdmUgc29tZSBpbnNpZ2h0cyBhYm91dCB3aGljaCBzd2l0
Y2hlcyBjb3VsZCBzaGFyZSBjb2RlIGlmIHdlIGRlY2lkZSB0bw0KPiBzcGxpdCB0aGUgYmlnIGtz
el9jb21tb24gaW50byBzZXZlcmFsIGRyaXZlcnMgPw0KIA0KQWx0aG91Z2ggS1NaODQ2MyB1c2Vz
IDE2LWJpdCByZWdpc3RlciBmb3IgaXRzIGludGVycnVwdCBvcGVyYXRpb24sIHRoZQ0KYml0cyB0
aGF0IGFyZSBuZWNlc3NhcnkgZm9yIGFjdHVhbCBvcGVyYXRpb24gYXJlIGFsbCBpbiB0aGUgaGln
aCBieXRlLCBzbw0KaXQgaXMgcG9zc2libGUgdG8gc2ltdWxhdGUgdXNpbmcgOC1iaXQgcmVnaXN0
ZXIgZm9yIGludGVycnVwdCBvcGVyYXRpb24NCmp1c3QgbGlrZSB0aGUgb3RoZXIgc3dpdGNoZXMu
DQoNCk5vdGUgYWxzbyB0aGUgcHJldmlvdXMgaW50ZXJydXB0IGNvZGUgb25seSB3b3JrcyBmb3Ig
S1NaOTQ3NyBhbmQgTEFOOTM3WA0KZmFtaWxpZXMgb2Ygc3dpdGNoZXMsIHdoaWNoIGhhdmUgaW50
ZXJydXB0cyBmb3IgZWFjaCBwb3J0LiAgVGhlIG9sZGVyDQpzd2l0Y2hlcyBsaWtlIEtTWjg4NjMs
IEtTWjg4OTUsIGFuZCBLU1o4Nzk1IGFsbCBoYXZlIG9ubHkgb25lIGdsb2JhbA0KaW50ZXJydXB0
IGFuZCBuZWVkIGNoYW5nZSB0byB3b3JrIGluIHRoaXMgZnJhbWV3b3JrLg0KDQpUaGVzZSBzd2l0
Y2hlcyBoYXZlIGxpbmsgY2hhbmdlIGludGVycnVwdCBiaXRzIGZvciBleHRlcm5hbCBwb3J0cywg
c28gaXQNCmlzIGVhc3kgdG8gc2ltdWxhdGUgdGhlbSBhcyBwb3J0IGludGVycnVwdHMuICBCdXQg
S1NaODQ2MyBvbmx5IGhhcyAxIGJpdA0KZm9yIGxpbmssIHNvIGl0IGlzIG5lY2Vzc2FyeSB0byBh
ZGQgc29tZSBzcGVjaWFsIGNvZGUgdG8gcmV0dXJuIGEgdmFsdWUgb2YNCjMgdG8gaW5kaWNhdGUg
Ym90aCBwb3J0cyBoYXZlIGxpbmsgY2hhbmdlLg0KDQpLU1o4NDYzIGlzIGJhc2VkIGZyb20gS1Na
ODg2MyBzbyBpdCBzaG91bGQgaGF2ZSBhYm91dCB0aGUgc2FtZSA4LWJpdA0KcmVnaXN0ZXIgZGVm
aW5pdGlvbnMgYXMgS1NaODg2My4gIEJ1dCB3aGVuIGl0IHdhcyBkZXNpZ25lZCBpdCBoYWQgYQ0K
Y29tcGFuaW9uIGNoaXAgdGhhdCBvcGVyYXRlcyBhcyBhIDE2LWJpdCBuZXR3b3JrIGNvbnRyb2xs
ZXIuICBCZWNhdXNlIG9mDQp0aGF0IGFsbCByZWdpc3RlciBkZWZpbml0aW9ucyBhcmUgZGVzY3Jp
YmVkIGluIDE2LWJpdC4NCg0KSSBuZWVkIHRvIHRyeSB5b3VyIHBhdGNoZXMgdG8gc2VlIGhvdyBp
dCB3b3JrcyByZWdhcmRpbmcgdG8gdGhlIFBUUA0KaW50ZXJydXB0cy4NCg0KUmVnYXJkaW5nIHRv
IHRoZSBvbGQga3M4OTk1IGRyaXZlciBJIHRoaW5rIGl0IHdhcyBhIHNpbXBsZSBTUEkgZHJpdmVy
IHRvDQpzdGFydCB0aGUgS1NaODk5NSBzd2l0Y2gsIHdoaWNoIGlzIGFuIG9sZGVyIHZlcnNpb24g
b2YgS1NaODg5NS4gIEl0IHdhcw0KdXNlZCB0byBsb2NhdGUgdW5kZXIgdGhlIFBIWSBkcml2ZXJz
LiAgSSBkaWQgbm90IGtub3cgaXQgd2FzIHVwZ3JhZGVkIHRvDQpiZWNvbWUgYSBmdWxsIERTQSBk
cml2ZXIgYW5kIGlzIG5vdyB0cnlpbmcgdG8gZXhwYW5kIHRvIHRoZSBvdGhlcg0Kc3dpdGNoZXMu
DQoNCg==

