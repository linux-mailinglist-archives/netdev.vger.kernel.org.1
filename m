Return-Path: <netdev+bounces-109343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF29292807E
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 04:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E473B21AAB
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 02:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF8D1D530;
	Fri,  5 Jul 2024 02:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BYUMsSyQ";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JTkfMwMk"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2021BF31;
	Fri,  5 Jul 2024 02:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720147120; cv=fail; b=jKWn9Px+uMq5J4I0TpGrW+qLF1c5EtanrfH5Lw6+nyeky5NfyHxbNTS1O0ZI1+IRSOl/WcNm6yqEfBF6QX4TGpxOJ5ff6PuhdQI9J9fxNZO4g4nm/6ok7AykwWyIJgQHd7U9BHQVv37LFCAXKTjJMirZJ/Xje4U+5H6XjSVyGz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720147120; c=relaxed/simple;
	bh=ge+d5/+zs/64SHqypjJPnwFbyJ+e/DZccopCHONQHr4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bfs4+Vp3QaNRhHTnBu1dDEKP8vKxsz7vm61a8LFaDGrgrpyqWXHB8ATJ7thNYadhQTGnqwjFwzHr5pGq1xN0IGB10ejaTu22f75gTEJACJvbD1EgjlwrDNfDSc2HlNVuaT6BiQkCZYQG36XUHn9MeJdKXX1AcamBAvfLY0VuuxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BYUMsSyQ; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JTkfMwMk; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720147117; x=1751683117;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ge+d5/+zs/64SHqypjJPnwFbyJ+e/DZccopCHONQHr4=;
  b=BYUMsSyQBQuViHQRJn1fxDAX1KE4ExcfIDoQ4TxQWLgHAl8+oiPa2TsX
   kGugAxaLzr+CTeybtyybooP94oEinn/5QcPnOOi2r8N4/BIjAf939JF0C
   sFWnpRpBpTYei8lcm2fDXWyXA15MpbzsK6zGkjQ9rRFBiLy03MZd1OngF
   bq1iPqBYcLeJh+iDU1PwCFFFu3xsAppmo3l3cKFAIxnGzmbVYnMv6wuz/
   Y48XC789WPh+o/pyT0NK3lsAaoOVjGdA37g4HZVRTRy9gHN78IllPN6dl
   Igi7xumQ/+94VjjO0dSPY7tHs0hG5uLq7RPFIS5MpC9xUmHWhKGf2Tn7f
   w==;
X-CSE-ConnectionGUID: 0sIjsnTXQF+rl9vtOHyQdA==
X-CSE-MsgGUID: eRdCXOcZSfOTUm2F970zbQ==
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="31502207"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2024 19:38:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jul 2024 19:38:34 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jul 2024 19:38:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pcl0YQmWkHZdQyl5+AbcdSszk+YGTbus6bJpQkzLjlnjwdQK2SaAK//qFNOwYVbzBJrblD5wXlpCayxZQXNI/24VjlQN/5IGhc9lxLruHma2uijP4CobkKbOa85NR3OW3Y2YEFxGmufzif/Tcpu+eadvM7k+QXW0G5rwi+wrQiyfjaV+K1fHYZHh7tBuJIOFkSrcWF6jnGZAiKL7SveLzd4VqVPK22I8p4L2doXCDH2+oigXM59PWOTdG9nBkCCeXuLjuCo80hbJY1/kUQoG4eKIqUppOipa+ncaHI57zhgcrwO35Zt/WA9QBRJT4XwvIHA/p0bvbj00Fi1ylShVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ge+d5/+zs/64SHqypjJPnwFbyJ+e/DZccopCHONQHr4=;
 b=g7hmJO+QqKVVH3sHRoADH7pCqVFGqCe6Etk6+lnVofUKmYM3Ey4pkRx6hHoHn85JCwkJoSSlR7GD0OKI1b9ELl7yS8Nj0YFHUUcjkA5GScTCdE6staIjBATvUX9eDDFM8S7GY0bJN8mUJE98eyo1LmMbCMkAhner8PTyYxeKBHSfOszU6/HWKMip9qOXM7CtmLkvq8rfcp4YHl+JI6OpnHXGbuXnoTBxFMmT/h3V8QgSWu65GuZ1WxM1+ruYBzdqKDRU5/yYqnggS2uo2aFTB9WwSaqer62eMQOP2cLsKujHgt6dlCMGDpHfZ2oU5X0g6hLWY1uJeuNhTJ5WTNp+OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ge+d5/+zs/64SHqypjJPnwFbyJ+e/DZccopCHONQHr4=;
 b=JTkfMwMkryQlaHUdYc0cNZ4+NvKuL3DKgo1rt3ZpBJUgOSNWosdC1Vmok+fk7BP5O5R2q7e47+PGePE9ffXHq9HDktgnxc9/gKJ+zx+KIA09rIGdo80bwCLBv6Jv+bMZaCg9FwNgSHM3bTAnNzzfB+APRFW0WcnzrLp9yepkHPWP7Oxb+ow5l2NN4DWA0KnGRHfLifaOefaXqCRmE6DtWDGmTMWuGOiKUsR2KdxSnqKP97evXRIV3RQCUmAlYhuV6n1LO5RKQmp8x6RQBR8SQ5fkM6mCeeH9CtQslgLGg69uT+/A44XbEjDyKPVInebDDhOaK+wTyO1UkPiE1cSd5A==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by MW5PR11MB5907.namprd11.prod.outlook.com (2603:10b6:303:1a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Fri, 5 Jul
 2024 02:38:31 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%3]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 02:38:30 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v1 1/1] net: dsa: microchip: lan9371/2: update
 MAC capabilities for port 4
Thread-Topic: [PATCH net-next v1 1/1] net: dsa: microchip: lan9371/2: update
 MAC capabilities for port 4
Thread-Index: AQHazhyIY8Lu0f1lQEmzBFTKqOjFE7HnbUGA
Date: Fri, 5 Jul 2024 02:38:30 +0000
Message-ID: <caff641db601d068ceff25b5ab9b54b044a1f8b3.camel@microchip.com>
References: <20240704141348.3947232-1-o.rempel@pengutronix.de>
In-Reply-To: <20240704141348.3947232-1-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|MW5PR11MB5907:EE_
x-ms-office365-filtering-correlation-id: 7d39405d-e408-4d2b-4079-08dc9c9b8eaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dGFZajJKNFhhdUhSb3QyV1hDVzRmNlJHM3RNcXVkT2VuTDFHSEFXNGRMYi81?=
 =?utf-8?B?cDhUY0xDU0xGc2tleVRzWGZ6NnFJYTlWTENqMmZKbFhQQTJId1RZQmkySUVr?=
 =?utf-8?B?WENNemQ2cy9ia1dXOFYyWEdzYlk0dk9WTi8yUnoxOXhTYWlmaCtjenNlUTFx?=
 =?utf-8?B?eVJreE9mSENuZk1Makx6bWRhS1dGL0s5ZHNGNUlYVFJQclV0YlFEVHNVU29F?=
 =?utf-8?B?MWlXM0pEaXVudzExNVVZRDVZaWtFR2trM1NtYWRTdWZySUYwRG9yY05wd0p1?=
 =?utf-8?B?MGxYQm1lWW83QTJFQ04wbFY1TFJKVXp2bG1qRG1mOUpqcHdhNi90a0lTYTdT?=
 =?utf-8?B?eGpzTnFkb3RMeDd3V3ZtTzg1Wi9ka1VnM0p6RW4vRHE5bkUzSVhWalpzTzU0?=
 =?utf-8?B?aVYxZ0RISzlVeGVZajQrN3o2TzdCRXk3T2pVNHpncCtFRzhKNzdUVWJnZVpa?=
 =?utf-8?B?U05RT1FvNXJYRGtUcVhHdnFISTZPSGJ2Z3Q0SzVJR1NRYi80NVJoSUtZQXZJ?=
 =?utf-8?B?cXFhdTdoV24vOUJvT201N05Od3lLc0s1S2Q0LzFoMGJJRHhEVS9vYzVKdEJu?=
 =?utf-8?B?Z0N0dHY4eGNEQmpreVhPbmR0dUNxRGtNWmthUmlnUDc4bWNPcFBhQUhUdFY2?=
 =?utf-8?B?eTJKNitNZnV4Rmh6VWRYV29XNENRd0RDL1BCOHJQY0MwaHcrcmVQVzJid1JF?=
 =?utf-8?B?MnFzWWVDeGxNTzZ2VVhLa2dhNEFZdThCaXNxcUNjZFpLNWJYTTRsWUpLeTdQ?=
 =?utf-8?B?STFDaUUzbHJqNHJoWWZsSzJiNXpFUjNLbDNUN1lSdGlpL0ttVWRMekdFZmZr?=
 =?utf-8?B?S2xsOUdjVk0vMWZja1FOLzlNeGp3SWRjd2h2T3JHQTZmd1JPalRhWlFhMDJO?=
 =?utf-8?B?cmVBajg0ZFpJMGpRQ1BCbFh4eERIRGRJVHhBaHBydnBJaitmeFZaVkRNWCtu?=
 =?utf-8?B?RFFvZ3k2SDZwNXVVSy9RWWVkYWdTUDZFc2ZPY3BPdjlXTkVhc0MwOUQ4bTN0?=
 =?utf-8?B?Rm9jOG5YeEZmaVAzZDVBU1hFWnZRa3BNY1hZYURHc3kzcHhrS25BdGlJY0xq?=
 =?utf-8?B?VU1xd2s3d1BldTRib05nSDV2MlNvMkRwWFRoZnJmQ3lmZm1HVjQrcHNjTW03?=
 =?utf-8?B?WURoaGh3aE9CNFZhUFE1UXg1TzlhYjd4SkxxS00wUjhWQWRZNHRURHlGYncz?=
 =?utf-8?B?V1hwM1pxS1ZZS1dVa3BYQ0FHWThIQTc1L00vdGg2V2ZyWTVyc1psQlF3UjJZ?=
 =?utf-8?B?anJKWUJrUVhCSHlrTmxSTmlMNWVrY053M2lYcFpxU3J3NUJNYnNjSlRyM0V6?=
 =?utf-8?B?c2dDRjFjQTI1OGtjbXM3OGVIWXlDOEFtWFhWNU5YQVV2RWJVSGxIcUZQMDFS?=
 =?utf-8?B?cUF1TUdFdEVLUnh0cTZoVGZOeG5IS0xlWERRSW5UMDJDbERVdHgyeUdlZUtx?=
 =?utf-8?B?NlREWHIwcEYxRHN3Z1JxOU4vVjlRUXNRMjBxbU81SU4rWk5Xcnk4b3IrREtT?=
 =?utf-8?B?Nys1WkhXZ0JVSDlhUlRQU1o2TmdHQmtiRU0ra1EyRWNaa1RHUU9LS1VXRGhY?=
 =?utf-8?B?WWtKNFNvNG5ZekhOcTRTRXFKZFQvNW5CazFFc0NqZ3lCTWRyVDAyU1pLRWp5?=
 =?utf-8?B?NEk1cHdCc3RycFdCOXF6Zlk5b3ZGRlpHOUwzamFDVmJWODdYR1c1bllsSDlr?=
 =?utf-8?B?NmRLbnNlN2ZaQkQzZUtxeTdhY1BzWEdFRVREYXNMenVpRXdzMmNTYWVIM3dK?=
 =?utf-8?B?anlYTmFvNFhGZ3hLM1MzWjgrQmQ4T0hIeVVyNVpxa0VrK09NM0s5N3N5MGpl?=
 =?utf-8?B?c2VlR2RvOWZ4VSs0b2V2a28xM3JIUEIvbjYzbDF4UHh1RXVQZ2pkZlpJNVhF?=
 =?utf-8?B?UWo5M3dKWkU4WXJGbWhzbEpXd1RVOUkyTmU0eFM4aStSWHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ky92akttMkNtdy9ZOU14cllpT1QrYVBISFQ3OE9iZ2hSZ1B2ZGJlNkVWZXVZ?=
 =?utf-8?B?MThpM2R4enNqRjhLMWVtNmkxZm1GUUxmWUNuRVZ0aW5MdzIvL1NLeVBwV21O?=
 =?utf-8?B?OElJK1VDTGlNL0l4U1hJUzV2dWxxcnJyb2NiQXZSS2JnWklmblBwK1QrOTBy?=
 =?utf-8?B?bm5uYzM5MDIzQXhScUdzRTRQSlg4Z1Q5VjVDb1M2M0xFSk1ZdTM4dmdrQnUw?=
 =?utf-8?B?dFhqUEpFYTlrZjlYc0kzVEpGaGRxcVV5TnZ0TnFwVlhnTXhKSEdNVFdMSlhS?=
 =?utf-8?B?d0luTVJRL080YU1SaHJzc2tqMTdEc0JFb1lFTm9EQStKQnczWkhGTVBpMlhO?=
 =?utf-8?B?RFBXd2g0a1grbHpZWThWdThUZU5FTTRsQnphSHJWWWdqWUhtem9KTTlLV3Uz?=
 =?utf-8?B?ZFRvZzNPR1haN3VPdHFDMEhwdDY1VTk1Sk51NzNhNlJmNDVoam0yRTgwRklG?=
 =?utf-8?B?ci9nOG1wKzQyVFRabDlIcUdTcUx4QXFNUDg0NzdncFJMbEpOWEpiQzRPOVhi?=
 =?utf-8?B?c1ByRHl5czBYbzdiKzNOd2syMkkxZHhJYlJVTnU3RkRTUWpSbHVsUldvVnp5?=
 =?utf-8?B?VmZmN05pdWZqSnVEME91Q3pjc3REVzJsbTZHeU04MDNxWlpxUGlBRHFxYWdR?=
 =?utf-8?B?UGdSb0J2TUQzMERSTzRDdzl5M2xGNlhjMEVobWxOSXI4NW9vY0ppdEFzVkd5?=
 =?utf-8?B?QTFSdkNSZ0F5ZjUzK09lK2kwaDhmdFhpZnR2TmNnMTg1cllYOVRRTWlEKzF5?=
 =?utf-8?B?SFlGLzNjK2dQZDJTKzEreFphOFNFK1U4MG8rZUdGMGZ6bTB1bTFXRHNUVHRm?=
 =?utf-8?B?ZndHdGFGWXJFZ3h3S0E0NmxkdWd4TXplZFJ1THIvRUREV2JLK1lLS1ZYblNE?=
 =?utf-8?B?clNvdHp2N1JmNTFvQ2xWTEIvakVoU2J5dDNBN2NHTXF3aWpBRFUrTU84d0dU?=
 =?utf-8?B?YXc3OXFuazVDeFF4TWxqMFhIVEFRdFUySFd4L3lYdXRlazBRZzdVcTZaM0xM?=
 =?utf-8?B?SUhtRXFaLytnanduRzNlMDdtSnpDcDJHY3ZDQkRHRkhqMzhjbXpMYm1TbEhF?=
 =?utf-8?B?L3ZhSDZ0eFJieDJpbFlaQkdTUWZhWWxkdWVrQmxOVm55Z3Nqa3I0V0RsdlJO?=
 =?utf-8?B?NGtPRVZ6ZlRoc0R3ZUhQcmc1bHBiQXBkWmtyOEJjNko0YSs3RHdxZFBSY3pS?=
 =?utf-8?B?dWlxM050SWVHNXpJMDVzeTRWTnM2ME5yY2JmcjNiS1dZOFBYaWNSQ3RreTZ4?=
 =?utf-8?B?UUJwM3RLK04rMm1iRThFdWhLckpHeU5DbWlSTlJjTzl5eGg5U3ZEQ2l5UzdS?=
 =?utf-8?B?SWkxWE96ajRSVUp0T2xjeUxldGx1M1BjTG9JZWJxdXZkd1MrblFjbkFkUWI1?=
 =?utf-8?B?dkg3ZTcyUnV3QnNCY0t3bWpFbWFZWWk2WGhwcVdINUVjSXkrc05PLzFpYkpF?=
 =?utf-8?B?TXZrcTBKMm1ubmVueEJRTkxFN2dSd2tFeEpRamw2QmJwUUYwV3UvRU1ESHJn?=
 =?utf-8?B?ZFlHUmNlbldLWlI3Q1dCZWlNR2Q3M0hBbklIUU1BVnJQeHA1QWdsQm11N3R4?=
 =?utf-8?B?VHZDYW1ZaXVMOStUbTdWcjVvOHhFNmNPVnk4Y1M0c1NZWFZ6MVNpaGsxS0pU?=
 =?utf-8?B?bk5xMitwbkV6b0ZxdEc3T2tjbGxXaWFuamI1N0FvY1pIV0JmNzF2ZUVNYlhy?=
 =?utf-8?B?ZHIxMFVyeE42TnpaaE05ZDZEZDlaRjE0VEszaVZ0YmdpelpzU1h5anJtQVFO?=
 =?utf-8?B?RHFFQWdqb2E5bVVDVE1vakZFL3hIY210NjFvVmRMZTExcWNpT1pDaVVoYVdr?=
 =?utf-8?B?anh3Ri9EWXBBUTVXVHA5cnc5WFUzN1Bib1hIMGdmcGFlbXUyNHUweDF6c0Q3?=
 =?utf-8?B?U2pMc1dkb2JtQlYvS0lud2N3d3dwZk00VzhzWFZQY3hGNWRzVzVsT0lzMGxt?=
 =?utf-8?B?M3J4N0VQK1VSWFlWR3lNMWFIVlBzWUl6ai9sUmJQZDR4ZVZiQkhTQ0g4Wlhy?=
 =?utf-8?B?ekNoUWlLTzVlU0NnM2V2Y3NMMlpHU0FWLzJmaGI5UnltM0xwWTZySi9URXpp?=
 =?utf-8?B?VFRpNWFoZXc2cUg0M0FMeVFjV2gxcUd2bkF6SlhyWlRNcDlPZGIyKzRaWVN1?=
 =?utf-8?B?UFpSdThERUlBR3FPdlpvSlcwNnRTWVJONDVsRWptbXMyY1NSeTZ4cEVxb2hK?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F5D3A0302AD194FB13E5DBF73B6B59C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d39405d-e408-4d2b-4079-08dc9c9b8eaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 02:38:30.7433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IlU2bGUEVa5k+iZ/NWm5lpkUzuN6OBWC2bfsW+Iq9PFoIxQOZJ7KMZT529QF0ES4BvNcMEEivRV3FpWxJnQ8pU38LLoD75x58CYM0s3Wthc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5907

SGkgT2xla3NpaiwNCk9uIFRodSwgMjAyNC0wNy0wNCBhdCAxNjoxMyArMDIwMCwgT2xla3NpaiBS
ZW1wZWwgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiAN
Cj4gU2V0IHByb3BlciBNQUMgY2FwYWJpbGl0aWVzIGZvciBwb3J0IDQgb24gTEFOOTM3MSBhbmQg
TEFOOTM3Mg0KPiBzd2l0Y2hlcyB3aXRoDQo+IGludGVncmF0ZWQgMTAwQmFzZVRYIFBIWS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IE9sZWtzaWogUmVtcGVsIDxvLnJlbXBlbEBwZW5ndXRyb25peC5k
ZT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2xhbjkzN3hfbWFpbi5jIHwg
NSArKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAvbGFuOTM3eF9tYWluLmMNCj4gYi9kcml2
ZXJzL25ldC9kc2EvbWljcm9jaGlwL2xhbjkzN3hfbWFpbi5jDQo+IGluZGV4IDgzYWMzM2ZlZGUz
ZjUuLjQ0OTExYmM3Y2VhMWQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2RzYS9taWNyb2No
aXAvbGFuOTM3eF9tYWluLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9sYW45
Mzd4X21haW4uYw0KPiBAQCAtMzI0LDYgKzMyNCwxMSBAQCB2b2lkIGxhbjkzN3hfcGh5bGlua19n
ZXRfY2FwcyhzdHJ1Y3Qga3N6X2RldmljZQ0KPiAqZGV2LCBpbnQgcG9ydCwNCj4gICAgICAgICAg
ICAgICAgIC8qIE1JSS9STUlJL1JHTUlJIHBvcnRzICovDQo+ICAgICAgICAgICAgICAgICBjb25m
aWctPm1hY19jYXBhYmlsaXRpZXMgfD0gTUFDX0FTWU1fUEFVU0UgfA0KPiBNQUNfU1lNX1BBVVNF
IHwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNQUNfMTAw
SEQgfCBNQUNfMTAgfA0KPiBNQUNfMTAwMEZEOw0KPiArICAgICAgIH0gZWxzZSBpZiAoKGRldi0+
aW5mby0+Y2hpcF9pZCA9PSBMQU45MzcxX0NISVBfSUQgfHwNCj4gKyAgICAgICAgICAgICAgICAg
ICBkZXYtPmluZm8tPmNoaXBfaWQgPT0gTEFOOTM3Ml9DSElQX0lEKSAmJg0KPiArICAgICAgICAg
ICAgICAgICAgcG9ydCA9PSBLU1pfUE9SVF80KSB7DQoNCm5pdHBpY2s6DQpJZiB5b3UgYXJlIGdv
aW5nIHRvIGFkZCBtYW55IGZlYXR1cmVzIHJlZ2FyZGluZyB0aGlzIFR4IFBoeSwgdGhlbiBpdA0K
d291bGQgYmUgZ29vZCB0byBoYXZlIHdyYXBwZXIgZnVuY3Rpb24gdG8gZmluZCBvdXQgd2hldGhl
ciBpdCBpcyBUeCBwaHkNCmFuZCBzZXQgdGhlIGNhcGFiaWxpdGllcyBhY2NvcmRpbmdseSBsaWtl
IChib29sIGlzX2xhbjkzN3hfdHhfcGh5KCBpbnQNCmNoaXBpZCwgaW50IHBvcnQpKQ0KQWxyZWFk
eSB5b3UgYWRkZWQgdGhlIHNhbWUgc25pcHBldCBmb3IgbGFuOTM3eF92cGh5X2luZF9hZGRyX3dy
KCApLg0KDQoNCg0KPiArICAgICAgICAgICAgICAgY29uZmlnLT5tYWNfY2FwYWJpbGl0aWVzIHw9
IE1BQ19BU1lNX1BBVVNFIHwNCj4gTUFDX1NZTV9QQVVTRSB8DQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgTUFDXzEwMEhEIHwgTUFDXzEwOw0KPiAgICAgICAg
IH0NCj4gIH0NCj4gDQo+IC0tDQo+IDIuMzkuMg0KPiANCg==

