Return-Path: <netdev+bounces-303986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ASErFO8CRmpXHwsAu9opvQ
	(envelope-from <netdev+bounces-303986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 08:19:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C1C6F3BFC
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 08:19:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=selector1 header.b=yNmqG8PO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303986-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303986-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82C9D300D16D
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 06:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6460F375F8A;
	Thu,  2 Jul 2026 06:14:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0C8375AC6;
	Thu,  2 Jul 2026 06:13:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972840; cv=fail; b=IINt6kOhMKHv7tJGeak79FKMYeZZY+U5jmrbGFT9L7lvvmpvY6uCPRuCM9wFyIq7pKfydFwifU7Ls7WEzRNegEK22p2jJbiFjGbBoQjq6v6PlJ+EoYI0XCsDk9LEGLcsH47VXPVCFdVJbohrYvmzpMDv6trgcKdWO3aJZT7uoQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972840; c=relaxed/simple;
	bh=fuAQSeYto/ttDs6+rks6T+oQIMtsRrIZsmzN8pV5xTY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LcRLvEK7ZgIp690wbysQGz/6Mb8BpdmLPhDsATVOxmpkLQ5J8Jc2OPQ6DMloHglEJ+7cTBLZiBLAQzN0lv3mhylRz2CNDWO/6guC7vhQX3KJDzQB96JXncblBg14GKqh8ABClR3E9Fm2HFepQixd4CDmSz9+6oLAKvBygSFbIiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yNmqG8PO; arc=fail smtp.client-ip=52.101.61.5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fu+cpBMUVgoVAWFIVFwpo8QHTyOf35Ku92Fx9D4ebh4JJn5gTRGsobJylUF2xXzrH5tUT1SiZcSCuAcCw/XodNS9Cw4/NaYWD/oom/RB6aPHhP3Cb50N4+cD9+OMh3nEUsQtZRtQHD5kpwXXVDDk8gTgJtz21Ius2UWqb3l4Fo36TDrSdYRxzXJdtJJXfS2gsdn5mPL0+fc+FcrllBzCgiBFc0XJxWKXyXxXlHfr8fYs52piGgi0psfOapr6iCJoso5iIOnnwpNgHyYX9IiSbhuGaqKMqdUXiLD0XmlOjhWF2f/euhAP0AeI+dzJhMihGokKBKB903V0BTfau25YUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuAQSeYto/ttDs6+rks6T+oQIMtsRrIZsmzN8pV5xTY=;
 b=LYxWoomiWCEbYxTn/hz083JAN+WRMqwRbogfsN+uhRw13wreTCmDe9n9whO0qKK0zHZ6bt8+VL817OLCmIsZfUjBmwMdh88hH8oHrZckuRgWzbFCnw90whtbgoxS0OiDH+rf1BTf1mTWouz+IaAI6IJofKtsRnjz6fhUHWOpo6V46HZbii7f9eY3hIW5N/egnqI9r61loM3ROsT2tna+4ec/s6OVWj+dZEFc7tHohZcptHhfUJuex/0Fup+JDn6XG6399QK2OrJbn1UIoLFNMYWe5o+0pae/HysjFKH3fFi5i/Mr+IZzeUs8ii6mHFtNviBZFvmBY9iB2tp1SiQCCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuAQSeYto/ttDs6+rks6T+oQIMtsRrIZsmzN8pV5xTY=;
 b=yNmqG8PO8Uc6Cv8YGi3YXZdL9tKR69JoVo4LJ3N8L+nVeJUqpHLOuQaawdQpxdundpd+HbtrLpxy7pP3dVD6/VHKgsDRQiUa3N+/pYh/Zzwogp13WkU9LAZSl/cxE0iBCLDE+yd1EsOtBzjP8vm2ATu7G3LAHY8LUE93ufrGi7oOGLe82BcI1jpEYzvwY9U1a9UHmpVWCzuz4kmqcAl2rZzUdkciLevadl5Q6EMJpjpUnbLNpV7EjPkbemy3dOmHp62bcj0l1XF1kYUGi9/i4RfBCHFwMABhha0FqaHzwkbj9x9T9x9dYNXGNQ0h+rKm+eac0/Dd4+gz6APGZGN/Xw==
Received: from DM3PPF9623118BD.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f3a) by IA1PR11MB7944.namprd11.prod.outlook.com
 (2603:10b6:208:3d8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 06:13:53 +0000
Received: from DM3PPF9623118BD.namprd11.prod.outlook.com
 ([fe80::ad98:5674:dd4c:875d]) by DM3PPF9623118BD.namprd11.prod.outlook.com
 ([fe80::ad98:5674:dd4c:875d%6]) with mapi id 15.21.0139.018; Thu, 2 Jul 2026
 06:13:52 +0000
From: <Manikandan.M@microchip.com>
To: <linusw@kernel.org>, <michael@walle.cc>
CC: <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <srini@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux@armlinux.org.uk>, <richardcochran@gmail.com>, <arnd@arndb.de>,
	<linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v4 1/7] dt-bindings: mtd: jedec,spi-nor: allow the SFDP to
 be exposed via NVMEM
Thread-Topic: [PATCH v4 1/7] dt-bindings: mtd: jedec,spi-nor: allow the SFDP
 to be exposed via NVMEM
Thread-Index: AQHdCHJO2Gcoz1g2RUeN8B826tcfiLZXqkWAgACtuoCAACbngIABRB0A
Date: Thu, 2 Jul 2026 06:13:52 +0000
Message-ID: <7ed6a2c8-1a6b-41d7-a2cd-ca39073812eb@microchip.com>
References: <20260630092406.150587-1-manikandan.m@microchip.com>
 <20260630092406.150587-2-manikandan.m@microchip.com>
 <CAD++jL=FkEfpz-LW0vmPpZ28fLfGFMWo5E479Mapz55YUxKNAQ@mail.gmail.com>
 <DJN3HIIAY4LE.3MXU9Q2YFSCJJ@walle.cc>
 <CAD++jLntmnwU3gAQfDn2nd4CQ_7HY6S_kBguVtZvVT1PktFCPw@mail.gmail.com>
In-Reply-To:
 <CAD++jLntmnwU3gAQfDn2nd4CQ_7HY6S_kBguVtZvVT1PktFCPw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF9623118BD:EE_|IA1PR11MB7944:EE_
x-ms-office365-filtering-correlation-id: 08ffef9a-a4ef-4e21-5559-08ded8011731
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|18002099003|22082099003|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 q/yzmjFwLzhLctK7SNYR4sIJw3TgOFOA8sY4Y+xUNOj9FbMpGl19sfrPU48zur8eRF60IpVyE7Vhwu8+vKObn5VCypzBguY/O0gd3zrjL/qsr2feXfF63k7kHht4S/y9baHIl5dokJck8H4X2LtX7dBu8xjl/6xUfDDBe4QkNPL5cc6XBSYHJCVI19xZj/O/xK/0qfUk/5TKCIJHhDC1o0Q0IS1Jbnp6EymOW6D9K36SeI2i7Y9/vga75Qk6ndZ9sGmNm/TmVSXCXJjal9xgJFoBwtq7DxvvhafDeoSmAb6tMTCFMbr5GJ94leIVtZuBPjOWl7Wj8RIJGEELvTmrKdqjNKuufV2mzXsxvjccRjo0k+pKrhzUqCQvFe6VGX5OlMNw8Dhwr/GIMFROsyKqxAgg9ryBFRpquQB8gdl3Q0iN0zm6EpMyyNAfmkUFS0oLjueagqik7cITejgAnKtPisUo/e9iqZiELmZKb8xPqLqpbelaivcCEQEkdWqZeA63BYWAO3htK0L7TUDbsnNficebTC4fzfPUM2ZeM4l7jPCWzglgLjpRPwdL5sFEOq0ziOmDVVNlEyiZWQW1v3MdPQqVuP6ZZX5R96C0byS/uudrPJHWSNqotZ/ZGyFCjR93UNi90vSaZ+vjocdGTbqh/50IV2kFgBft6GLJILcR9NKkDghc2ov5VtF/2l+8nIFD5i2PVu/+hCB2wRulb2i9cyDJeERfl3xTb3GAO+nevqs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF9623118BD.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(38070700021)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RmJqZ0k4a1NINUEyelBqQThqU2p5MDlkMklZTnVSRkh6NGN5NEl2WHJsK3Ft?=
 =?utf-8?B?Z3hBa1VwUE51THNyL1p5dlV2L2llYk9CY3Q1SVdPR3JoVlRYY0taa3hBMDVt?=
 =?utf-8?B?MFRSSjRnNmlDVWVTbnJlMTM5eUx5a1FJT2VWU2Z1THoyTlIvSzBjdmQ1ZmYx?=
 =?utf-8?B?cVVJTDc1UHBocEVLUjVzYTJMZG05NzBEa0pZR1FxdEpYSzNhTWdGVEZDd0lX?=
 =?utf-8?B?STIwT2JwV0E0VmtpUG8xbWZoc3p2dzAwSHh1NUJKaTkzVlpQa3RZRWJkQlBn?=
 =?utf-8?B?b09IOStrOGlYWFdEWUUyM2UzN01CWnkwVERYOUFPUXJhYldyd2xHYS9FYzZW?=
 =?utf-8?B?TExPU1dPMEYzWGE4L1Y3ekQxYXB3RlY3dWZrbmp1QTAxREtQd3Q5TTR4WGx3?=
 =?utf-8?B?QkFpUU9idEdRN2NWdWMwTkVsL3l2SHZ2dnJOc3Q2VkkvSzFtZENyNTU0TUkx?=
 =?utf-8?B?K21hYmZoTVc5bFBZZnEvQmlrWW9KMC9kMGorZmo2aWJzM2taT3prQWJndlJE?=
 =?utf-8?B?TzVLbUU1YVR1RndDaWNkWk15RzRDNmxWVktMbU9uaklwdXVwbVdwNjc5TC9H?=
 =?utf-8?B?OXRGT3ZwU0tpRm9xMjhaUWRScHc0UVgzY3pXN3A2bHBwS3VYRTZvdy93NzQw?=
 =?utf-8?B?aFd1T3cydEdpb0VZUXBqbnFpMHdObklmR1RpSGZNMVlYbUFWU2pucjhYdXhO?=
 =?utf-8?B?U1c5cG9KSmJzZXdxclhKQm1Jb1ZYZHptYkFEbmlTZFhaMUliNkMwTGRMU0o3?=
 =?utf-8?B?eEJxNzlRa3NFK0RWa0haRUh4aHhwUG85KzhxblZsSldNRFR3TFREcFhHZWhX?=
 =?utf-8?B?RytNNEZEZlBDYVR6Z0JGZEQzUGhOSjZSbWRrTlM4QmhTWXVEUWF4dkxsSTJS?=
 =?utf-8?B?bDBreDZkNkF4aVBPYisyYWcrKzhIKzlxdU05SEdCbEkybHoyb2E3UkxCdjNs?=
 =?utf-8?B?eTJDZFBma2U5NGppK0ZxWjk0VEZ2RE1pU01Xa2NFMDlxNEZOSms1UzhvclY5?=
 =?utf-8?B?ejBZWjdwYXRadmQyNUxadjBjSG40dGlWMnFCd0QrUDUzYU5ENllKREZQU2RY?=
 =?utf-8?B?Wm8zNUhVSzV2ZW9uWHlmRHhWV2dZK2pCMUFlclVGK1pEVnM4QkFrV0xNek5k?=
 =?utf-8?B?eUpBd2IrVzg5dk85eTVoRzBFTXJUdWFtSzZ1OWVKNFJ6WkpaR2V6VnkyOWxz?=
 =?utf-8?B?alN0MjhqSWcySnVrTFlsbkNYMnhyS3FVa0hTTzJhd21BdExTYW5xd2ZSVHN4?=
 =?utf-8?B?VU9TeldkaWs0Snp3dlRjMjExVlcrQ0wvdnVVQjk5YS9PZU0vcG1YbTlxdHhF?=
 =?utf-8?B?ZVQvM3FubEFYdkhYYm5mQStERFAxZ25JR1hZcmVHWDBraXRGVEZpMVIrQ2o5?=
 =?utf-8?B?TFVzNWdRN0REQ0Z2Z1prWHBndERmeWd2U3pUUGdBM3RoVjlCNHE4UjJCSWFK?=
 =?utf-8?B?aFBZb1ozcENmcStLYlA4eFYzTTRVekR4NUpBai8zMU5Rd0NmeHdTV0xnM0Rn?=
 =?utf-8?B?UGplMHBTckcwMXVGeDFNSDR2bnlneW94em5uOTl2QjNtSFlMSGVsbkJPZWw1?=
 =?utf-8?B?Skx2c2NSTUxySlR5TDI5dFlxM0VheFVrU1ovQm5mYklmbVFuaTlHVnh4VDli?=
 =?utf-8?B?V1JOR1psVUg3Wk14UHcrNlN0dzZuVFBTUGJUSDVKNDZWMDcyUjFDa3B2RFhL?=
 =?utf-8?B?SjlUMDU4cEI3OE5TNUpiNm91cWJUcFAyQjdIeXUzcXVxek42Zy9kUE4xYWNt?=
 =?utf-8?B?SkRXMEhVSk94Nys4RkdzbzB6YnhBbWwxbllxWVFUWVdEcHJTK1VrRXdEUDJC?=
 =?utf-8?B?MzBFK3pkdnFlVWRvUXFWTHlybFZDMllWOFUxYmZPTTA2MWI3YzBJY0ZYaURI?=
 =?utf-8?B?aUlWOEZ5T3RJTmJtNG8wenBpam1RSnJBMjB6S3JTNkxxY1M1WjVEaVRqQVZJ?=
 =?utf-8?B?NDVXWlZ0aVhsaGhpNmpESitjOEhvc3QyS29VakdwRU81QXZqYXpuWmZDVU0y?=
 =?utf-8?B?ZzFoRnlyYnRUd3RFaFNoQ21zRk82dm9aOHF5a0RLeUtKby9rNnE1dUt2c1Ns?=
 =?utf-8?B?MnhRWkhGNHZKL0lGRW5mdUk1QzlQSGlrUFJnZUxsUmRKMGNRbEVjcmlGSTh0?=
 =?utf-8?B?QVQ1cjd3SXU3VE16WDlyODlzR25jOTFZNmNkZTUvcE9jMTlKUUJQMUF4SnNE?=
 =?utf-8?B?VmwrZ1RmbzlpR3RUQjVrNGZtNnJiOCtTRmNlanNQSmMrbEhCWnU2OGxuWHdC?=
 =?utf-8?B?QllwSVRTblowT3JzNkViQkh0MHdxWnlveGNUSmJVY2s4WWI1byttOUxIMXpX?=
 =?utf-8?B?RUZCNjhnbXowUTdnblM0R09KbW9OZzdsbE5UckZiT3MrZGg0MHRBQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0CF23099F47734987F8123332B2741B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF9623118BD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ffef9a-a4ef-4e21-5559-08ded8011731
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 06:13:52.8513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L/Ox14mD7ug97636SmPDt4fMepKfn9YrcXaS/N2zdzsih9pVIV4EsfFZhT1gNSJwoXeBGXZsX8Ct+L2FBHJDHNDUopC0P4S+UbGCZVmi8kE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7944
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303986-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:michael@walle.cc,m:pratyush@kernel.org,m:mwalle@kernel.org,m:takahiro.kuwano@infineon.com,m:miquel.raynal@bootlin.com,m:richard@nod.at,m:vigneshr@ti.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:srini@kernel.org,m:Nicolas.Ferre@microchip.com,m:alexandre.belloni@bootlin.com,m:claudiu.beznea@tuxon.dev,m:linux@armlinux.org.uk,m:richardcochran@gmail.com,m:arnd@arndb.de,m:linux-mtd@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Manikandan.M@microchip.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,infineon.com,bootlin.com,nod.at,ti.com,microchip.com,tuxon.dev,armlinux.org.uk,gmail.com,arndb.de,lists.infradead.org,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[Manikandan.M@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:mid,microchip.com:from_mime,vger.kernel.org:from_smtp,walle.cc:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99C1C6F3BFC

T24gNy8xLzI2IDQ6MjMgUE0sIExpbnVzIFdhbGxlaWogd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gV2VkLCBKdWwgMSwgMjAyNiBhdCAxMDozNOKA
r0FNIE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+IHdyb3RlOg0KPiANCj4+IElmIEkn
bSBjb3JyZWN0LCB0aGlzIGlzIHRoZSBvbGQgc3R5bGUsIHNlZSBjb21taXQgYmQ5MTJjOTkxZDJl
DQo+PiAoImR0LWJpbmRpbmdzOiBudm1lbTogbGF5b3V0czogYWRkIGZpeGVkLWxheW91dCIpLiBT
byBpdCBzaG91bGQNCj4+IGV2ZW50dWFsbHkgbG9vayBsaWtlOg0KPj4NCj4+IHNmZHAgew0KPj4g
ICAgICAgY29tcGF0aWJsZSA9ICJqZWRlYyxzZmRwIjsNCj4gKC4uLikNCj4+IEFsc28gSSdtIG5v
dCBzdXJlIGlmIHdlIHJlYWxseSBuZWVkIHRvIGFkZCB0aGUgIm52bWVtLWNlbGxzIiBoZXJlLg0K
Pj4gSUlSQyBpbiBNVEQgaXQgd2FzIHRoZXJlIHRvIHRlbGwgYSBkcml2ZXIgdG8gYWRkIGFuIG52
bWVtIGRldmljZSB0bw0KPj4gYW4gYWxyZWFkeSBleGlzdGluZyBjb21wYXRpYmxlL25vZGUuDQo+
Pg0KPj4gQXBhcnQgZnJvbSB0aGUgTVREIGNhc2UsIEkndmUganVzdCBmb3VuZCBxY29tLHNtZW0t
cGFydCx5YW1sIHdoaWNoDQo+PiBoYXMgY29tcGF0aWJsZSA9ICJudm1lbS1jZWxscyIuDQo+IA0K
PiBZb3UncmUgcmlnaHQsIEkgd2FzIHVzaW5nIG9sZCBpbmZvcm1hdGlvbiwgZGlzY2FyZCBteSBj
b21tZW50cy4uLg0KPiBSZXZpZXdlZC1ieTogTGludXMgV2FsbGVpaiA8bGludXN3QGtlcm5lbC5v
cmc+DQo+IA0KPiBJIHRoaW5rIG15IGNvbW1lbnQgaW4gdGhlIGRyaXZlciB0byBjaGVjayBmb3Ig
dGhlIGNvbXBhdGlibGUNCj4gaW5zdGVhZCBvZiB0aGUgbm9kZSBuYW1lIGlzIHN0aWxsIHZhbGlk
IHRob3VnaC4NClRoYW5rIHlvdSBMaW51cyBXYWxsZWpqIGFuZCBNaWNoYWVsLg0KSSB3aWxsIGFk
ZHJlc3MgdGhlIGRyaXZlciBjaGFuZ2VzIGluIHRoZSBuZXh0IHZlcnNpb24uDQo+IA0KPiBZb3Vy
cywNCj4gTGludXMgV2FsbGVpag0KDQoNCi0tIA0KVGhhbmtzIGFuZCBSZWdhcmRzLA0KTWFuaWth
bmRhbiBNLg0K

