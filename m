Return-Path: <netdev+bounces-272618-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJkyLuayxmmiNgUAu9opvQ
	(envelope-from <netdev+bounces-272618-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 17:40:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E1E347966
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 17:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F05B13116E25
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC6840F8C2;
	Fri, 27 Mar 2026 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ExhTgTOt"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012006.outbound.protection.outlook.com [40.93.195.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CF7364925;
	Fri, 27 Mar 2026 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628672; cv=fail; b=be8zhwlgQ0VDpgxJkVK/5eZC1bGL6cef8AhGqUBxVFu/9Pcq2+6ktdWTGsjzg1tsyWtC45e4fv+L1Pv/6hJmZJZSroPObsDJ/8KMsQNQ9C4uJU8xYECtXV7WrBuxFBGFCd9vMCC77XQZSQ8jqbNhEHb9Znr4N1EOdWYIYjbv1Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628672; c=relaxed/simple;
	bh=2WYU67tBez3mgvaKxhTG1Kec+sv5rcPkPpPng4/a7FQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PEBI5Gdmh8xR4qRLnMzkVqmQQtu/RO7Uyw7HDfrco/EtebvHMKJkA/6rQdYCuLMBhy7pEtF2wR3KOEiZmFJobswLb/3L+VE0xHYnxava1ioe/cuA5Cr/uxQVHiNd4BBfvW/Eo6Ul0vyk18xr73DRX3RKC1D6pRDJDoxnh/ZswjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ExhTgTOt; arc=fail smtp.client-ip=40.93.195.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvmvBwmhctaNdqubcca+WLEVHC5XiObvJBbu5CEhq3txTBzMyjFJPgXXb1JgaTMFHjbXA10ciehmtD3hA//CWPJVE/sMyW+WtAyibu1xpIvGfxl6NrpfYXaRY5zyCOQ6UzAZE5/GeBbSKHb0tSUNf41T0XBa7BkLnmQgiEyUkWrDtP3Ud5maPl4Zf306BTgPhTWbBx52SEM4FYjk9+pq59OMy4iDPBQEH8WD8hPAW/1atRl9r9yPgo+jR1bOx4nNmZ06tNTLF42zNQ9mESt84pifhrM82rz/52qSZIErecYEFhuC5E0Y/2+10a5H0C/yfj8uBVok4z7i6ZbzaZBOUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgbGnEfC8jeBxr5RQo/B6GlpONGcN27rW852PaiVwaU=;
 b=FK65kZW8Y81AJciHKVchHl4nyZYLx4veqmeYgf77rjhFJfiHo/OWTWc8nUVUcNq/Q8FWPalnAYgJ/4PZtGm2tpvh/XwqbCy5Og40hCmRTJKyPanuRarkf/e3Syp77PTwnooX8eVk5200vQJAJZrxYHZTgawnyJKeBcpCWP4rRMSJgBkdkFN+xFT5bB2uk5hDQitm59V0zmS456V5HJ0TVuFBlH33QMCSzhaC3/21aBkGhhWkD10BpxxfLLnfVLxYaLKutR2xe3MGiZlfjQfuEv6XszhIUBDUcV3axw58XmG6hjUufNHzz7QJNSwMp0cGi4I3QhnOB9pyZppvfERX3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgbGnEfC8jeBxr5RQo/B6GlpONGcN27rW852PaiVwaU=;
 b=ExhTgTOtzbVWAYP7q/IQHSC1ZcelrJYS4VLaf3evMj3L7AFM60UPkEXHCPO7tzd543KxhlqJX7S+L8RYTgUMq8YAOHsa8lCMfJalvWqHXXNHMC7RzldEdZ63uHfgebIOyiB/E9NH37GHnMG+qPD7aqZkTD9M0iMM5S9XuIVpmfqlzbiK53BezCy3mTcBgSejVS3uk4lJkLw2sO//iZb2qhoxgrEHM/+qxkQAeEVJRZFUSfQEWHqC+3g7Y/pglfKfKHS3L4i1WBp95vxkE99jyz1+SxX+lSX9ZxEmYvHs5jYc6VfjYJHp05iTbEUhrYciy7aVQRMIA0e4m/fJnv4IjA==
Received: from CY5PR11MB6462.namprd11.prod.outlook.com (2603:10b6:930:32::10)
 by DM4PR11MB6262.namprd11.prod.outlook.com (2603:10b6:8:a7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 27 Mar
 2026 16:24:26 +0000
Received: from CY5PR11MB6462.namprd11.prod.outlook.com
 ([fe80::10d1:11dd:5088:7559]) by CY5PR11MB6462.namprd11.prod.outlook.com
 ([fe80::10d1:11dd:5088:7559%5]) with mapi id 15.20.9769.004; Fri, 27 Mar 2026
 16:24:26 +0000
From: <Prathosh.Satish@microchip.com>
To: <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC: <arkadiusz.kubalewski@intel.com>, <jiri@resnulli.us>,
	<mschmidt@redhat.com>, <poros@redhat.com>, <horms@kernel.org>,
	<vadim.fedorenko@linux.dev>, <linux-kernel@vger.kernel.org>,
	<conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<devicetree@vger.kernel.org>, <pvaanane@redhat.com>
Subject: RE: [PATCH net-next 5/5] dpll: zl3073x: add ref-sync pair support
Thread-Topic: [PATCH net-next 5/5] dpll: zl3073x: add ref-sync pair support
Thread-Index: AQHct8it2yiZboqfgE6YpfihCIpUhLXCnKHA
Date: Fri, 27 Mar 2026 16:24:26 +0000
Message-ID:
 <CY5PR11MB6462E28870C343F05E53B34DEC57A@CY5PR11MB6462.namprd11.prod.outlook.com>
References: <20260319174826.7623-1-ivecera@redhat.com>
 <20260319174826.7623-6-ivecera@redhat.com>
In-Reply-To: <20260319174826.7623-6-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6462:EE_|DM4PR11MB6262:EE_
x-ms-office365-filtering-correlation-id: 5371d3e4-6da3-4f6e-9b71-08de8c1d50a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 a4YTQEVED9gIB2bRkkXDHpRU2BAMvElzJiELQx9oSmL9XH0MCMtjyZMzhvO8x/7THEGS3uovsXbfa8waUdob9YVEfLd9qlhF6ISgjiPW88iIMU43T2o05rIsy0GfTum+YRdSkww7QypKmbi/AABDrYc0f2i9i/PjvAyal8oOqJ/uMYmurP13DMwjMIdQOMYsjQt6D+lmP6B9NX98m0F27AfnQz9J64GpgceteEHRnmlVi0KKF8spWmktcsUCo8beWMR/aXIQCRGkxQgerWMXVuh+5Tzk/nT4n7nIrdJ5PvwGt2iV90TaatzOkAxmlpaRCfsbm9j5Dtmc1oyvyvyRLl5XaM+rM9sxyZ0Z4iH5of6VqPklomo4HZiaYpf3dQ5q59ITe4T0NWYU5hUMpZv3I3qeh0RiwDPTLig8z4OVUUg6tzt2QMkg41zB+ndHnLZnZwsJnmx8ZtTDZvHowB9bJak4jfcGN2MHgX1nk0gdRL2EmJ++3pUgTJEFNsyCqLWaz+q/l9jRHBo9Qed5UGCGG8PXnemVEbjzpE4fRtxr6E/MZww2OJ7r7WPIuULKl9bKu+jYa3NJg38wizx/KIggveqr7CuSLiK8hXz63lJu0n/dgY6uDCE20duosVG2u9fDyvpvQz3vBN0Pbu5MDwB0BnbP/0P60+jOUW3ReIr24/MKpzpokqWSFIYcR3/Mu0wCGbDW/T876Ga4UwvAfkrkY67QsHiji9PV1zml5N86MAs8gx5ePyqVxw1O2gY1fklzw06RhvhaBotOD/0dNfrTrSNCfCK+sge9Ub13OWCNn2Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6462.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dTIfB3w42G+BYbnggU3ZrRiCZY0ZrnpXaBTwUiL+MKZrJ8qRRlEEOPNsZiOJ?=
 =?us-ascii?Q?uOLbTnhxsu8SKn4bQVMgRGnonth7gh2MDUj7eiFV/Ouxmtk0QazwrlxQNnNr?=
 =?us-ascii?Q?KrSvD/UbY4uacl8TFRYg7sn/FfkdpUtPoJHdnFzU3NmRp7m91OOtkjJj5I24?=
 =?us-ascii?Q?0Lcb0eF39rQACc8uZNn5elQIeudlPGgX8Eap3jAWLd/kAOPhhio/lJp8fzyl?=
 =?us-ascii?Q?MadQkNamPTNUhE7By8tdd115zvloB0cfatBQmrTnyhke76xajbYOdiR62PW7?=
 =?us-ascii?Q?JsBQhezynT8uIjGyz05A6goYl2UjrRfQmaJx3UOd/UzztH6o8gVDjyN8pr8b?=
 =?us-ascii?Q?uaqzG8GNPdwQprGLNTJY+vHjinQ4Ty9+HqCD1sRjiSh9Kmw8hg6qIaLAwZ+7?=
 =?us-ascii?Q?PU+DFFBjRaQGkQYtIXis5gHBBsrhwWNwiG5XpW3H0fstKAEbGPFLKJbGg+qg?=
 =?us-ascii?Q?8cahSaxlwsjTlfxOHMTkpHl08pF7mcn1F6UxtCeqF0OX1L6E7Vot0ZXRh2sQ?=
 =?us-ascii?Q?SN5xP1F/eDR0Wl01JU7k0yvROdvYeYatB+VqGapmnBKpOPGWIL7DpEcSVY+L?=
 =?us-ascii?Q?q1k6NV7WUUvgkKWRIY5YDrUUB42lasQo3ZRAMB+7fiAhTL5cr1xeYAVBzxmU?=
 =?us-ascii?Q?m0032XKMXm/A85VanALcAat70hneh8IcZLQGgrHIoGFOoMn5HvXX1ZiTMsFv?=
 =?us-ascii?Q?TTStlqD5tzwbn94pABrOJISJ3fQUs9MR2wsWuDs/1aPvSMB6FGsA254FpIY0?=
 =?us-ascii?Q?18UBkgJMpvThFOG1OmrqKIPaUsx/Bex1Vk4SxDxKA/muOixbsT+Bea/XykEW?=
 =?us-ascii?Q?ONk1uvhrvfCC5fhIghY0ULG0/O/UYJxEI/r89OGr/caQ1tkkZ/G/ylfkGQbc?=
 =?us-ascii?Q?Pvb0CZfYKGvxlITJk/7vUK3LiUJ91h8S1Roy6FmPG7dvvHOoqQimTAIO5hyr?=
 =?us-ascii?Q?rir9ejpqRHTiiHqwZUux9Pc3u4IA/OFI0YsRq00bd0sOXkoDKAvduhyLjiwJ?=
 =?us-ascii?Q?naELPdG/sPQOBS7OrcwCjwvkw3QaVnpxPDndhnrJ2Ty7DQIg43ZNVWhb8Z8O?=
 =?us-ascii?Q?uZ0x3pKurG3GLZXBs+NjSnw45/SO7+Y4sxlw3Hm9sSkcK2tiYw/JEE+EaFCr?=
 =?us-ascii?Q?ndRZN4p771GNxl3aIEXey36ZVq07OWvJ1f9tM+2LqIrJ0GvWQlVnZQTatRsT?=
 =?us-ascii?Q?2XwaF/g2RhRjE4E7iswVM9lAhN1HwZRsmF+VGDt3K4cltG0nfvGYMn+oiJs3?=
 =?us-ascii?Q?FAF/F4OjtP1sUYOinqkAsTLfnLs+oaI/Od+EcoiJrVoyQHXOPeB+jEBaiyHI?=
 =?us-ascii?Q?tKtDeFoGwBJAOYi8zV8X/PUowH6Z2rJTXYhXuSABk3kYftgTt8DQfP5MXX3p?=
 =?us-ascii?Q?fmAYpm7XRJfFuiAKaOQwIVI39v66Lap0uyObMKI3SnXVoTSrAb6tgq7J4Upn?=
 =?us-ascii?Q?2wPvCK6lG7EZDgru7D6wfmwiFUEb0ULXQKw2oR4qkrGveKSqa0JIFtvHOJdr?=
 =?us-ascii?Q?snmJX1kVofhDtoqaz5dIkQG6Ru9g/mw2YVjN+sR2tv8npJCHCiZQaB5gm9LZ?=
 =?us-ascii?Q?q5VYbvY013GEK2GyaVY0gybbL8BXEe8jkqHdgcmTyNu2O+DKL6vAH+C2ckT3?=
 =?us-ascii?Q?d/fIFRdzHrcuAOf+lj8rZe227qxLuRq+qwg164YUriX9rahdRJT0ROUF0SyK?=
 =?us-ascii?Q?kS3HuwaVZmofQVZxg33Oh1u5aZ0RXc0vnmfRN9TdMRQspiba2gJOrwrXpXfu?=
 =?us-ascii?Q?4ju8qN3mTquzaKQ7yGMjYCmvbDSFTCg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6462.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5371d3e4-6da3-4f6e-9b71-08de8c1d50a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 16:24:26.7939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODMMcWVl5LGBoE5iygmPfomn0UDrbol/Ctc5fLS7WLH5ZvV/Ad6n4m8tIQuyRkzE9TRyAhZrL5dLMnb5WCblf3wpVKuuBleyvHWkRRAh5FM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6262
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272618-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[Prathosh.Satish@microchip.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,resnulli.us:email,microchip.com:dkim,microchip.com:email,linux.dev:email,CY5PR11MB6462.namprd11.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 35E1E347966
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reviewed-by: prathosh.satish@microchip.com

-----Original Message-----
From: Ivan Vecera <ivecera@redhat.com>=20
Sent: Thursday, March 19, 2026 5:48 PM
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>; Jiri Pirko <jiri=
@resnulli.us>; Michal Schmidt <mschmidt@redhat.com>; Petr Oros <poros@redha=
t.com>; Prathosh Satish - M66066 <Prathosh.Satish@microchip.com>; Simon Hor=
man <horms@kernel.org>; Vadim Fedorenko <vadim.fedorenko@linux.dev>; linux-=
kernel@vger.kernel.org; Conor Dooley <conor+dt@kernel.org>; Krzysztof Kozlo=
wski <krzk+dt@kernel.org>; Rob Herring <robh@kernel.org>; devicetree@vger.k=
ernel.org; Pasi Vaananen <pvaanane@redhat.com>
Subject: [PATCH net-next 5/5] dpll: zl3073x: add ref-sync pair support

EXTERNAL EMAIL: Do not click links or open attachments unless you know the =
content is safe

Add support for ref-sync pair registration using the 'ref-sync-sources'
phandle property from device tree. A ref-sync pair consists of a clock refe=
rence and a low-frequency sync signal where the DPLL locks to the clock ref=
erence but phase-aligns to the sync reference.

The implementation:
- Stores fwnode handle in zl3073x_dpll_pin during pin registration
- Adds ref_sync_get/set callbacks to read and write the sync control
  mode and pair registers
- Validates ref-sync frequency constraints: sync signal must be 8 kHz
  or less, clock reference must be 1 kHz or more and higher than sync
- Excludes sync source from automatic reference selection by setting
  its priority to NONE on connect; on disconnect the priority is left
  as NONE and the user must explicitly make the pin selectable again
- Iterates ref-sync-sources phandles to register declared pairings
  via dpll_pin_ref_sync_pair_add()

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 207 +++++++++++++++++++++++++++++++++++-
 1 file changed, 206 insertions(+), 1 deletion(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c inde=
x 276f0a92db0b1..8010e2635f641 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/netlink.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/sprintf.h>

@@ -30,6 +31,7 @@
  * @dpll: DPLL the pin is registered to
  * @dpll_pin: pointer to registered dpll_pin
  * @tracker: tracking object for the acquired reference
+ * @fwnode: firmware node handle
  * @label: package label
  * @dir: pin direction
  * @id: pin id
@@ -45,6 +47,7 @@ struct zl3073x_dpll_pin {
        struct zl3073x_dpll     *dpll;
        struct dpll_pin         *dpll_pin;
        dpll_tracker            tracker;
+       struct fwnode_handle    *fwnode;
        char                    label[8];
        enum dpll_pin_direction dir;
        u8                      id;
@@ -184,6 +187,109 @@ zl3073x_dpll_input_pin_esync_set(const struct dpll_pi=
n *dpll_pin,
        return zl3073x_ref_state_set(zldev, ref_id, &ref);  }

+static int
+zl3073x_dpll_input_pin_ref_sync_get(const struct dpll_pin *dpll_pin,
+                                   void *pin_priv,
+                                   const struct dpll_pin *ref_sync_pin,
+                                   void *ref_sync_pin_priv,
+                                   enum dpll_pin_state *state,
+                                   struct netlink_ext_ack *extack) {
+       struct zl3073x_dpll_pin *sync_pin =3D ref_sync_pin_priv;
+       struct zl3073x_dpll_pin *pin =3D pin_priv;
+       struct zl3073x_dpll *zldpll =3D pin->dpll;
+       struct zl3073x_dev *zldev =3D zldpll->dev;
+       const struct zl3073x_ref *ref;
+       u8 ref_id, mode, pair;
+
+       ref_id =3D zl3073x_input_pin_ref_get(pin->id);
+       ref =3D zl3073x_ref_state_get(zldev, ref_id);
+       mode =3D zl3073x_ref_sync_mode_get(ref);
+       pair =3D zl3073x_ref_sync_pair_get(ref);
+
+       if (mode =3D=3D ZL_REF_SYNC_CTRL_MODE_REFSYNC_PAIR &&
+           pair =3D=3D zl3073x_input_pin_ref_get(sync_pin->id))
+               *state =3D DPLL_PIN_STATE_CONNECTED;
+       else
+               *state =3D DPLL_PIN_STATE_DISCONNECTED;
+
+       return 0;
+}
+
+static int
+zl3073x_dpll_input_pin_ref_sync_set(const struct dpll_pin *dpll_pin,
+                                   void *pin_priv,
+                                   const struct dpll_pin *ref_sync_pin,
+                                   void *ref_sync_pin_priv,
+                                   const enum dpll_pin_state state,
+                                   struct netlink_ext_ack *extack) {
+       struct zl3073x_dpll_pin *sync_pin =3D ref_sync_pin_priv;
+       struct zl3073x_dpll_pin *pin =3D pin_priv;
+       struct zl3073x_dpll *zldpll =3D pin->dpll;
+       struct zl3073x_dev *zldev =3D zldpll->dev;
+       u8 mode, ref_id, sync_ref_id;
+       struct zl3073x_chan chan;
+       struct zl3073x_ref ref;
+       int rc;
+
+       ref_id =3D zl3073x_input_pin_ref_get(pin->id);
+       sync_ref_id =3D zl3073x_input_pin_ref_get(sync_pin->id);
+       ref =3D *zl3073x_ref_state_get(zldev, ref_id);
+
+       if (state =3D=3D DPLL_PIN_STATE_CONNECTED) {
+               const struct zl3073x_ref *sync_ref;
+               u32 ref_freq, sync_freq;
+
+               sync_ref =3D zl3073x_ref_state_get(zldev, sync_ref_id);
+               ref_freq =3D zl3073x_ref_freq_get(&ref);
+               sync_freq =3D zl3073x_ref_freq_get(sync_ref);
+
+               /* Sync signal must be 8 kHz or less and clock reference
+                * must be 1 kHz or more and higher than the sync signal.
+                */
+               if (sync_freq > 8000) {
+                       NL_SET_ERR_MSG(extack,
+                                      "sync frequency must be 8 kHz or les=
s");
+                       return -EINVAL;
+               }
+               if (ref_freq < 1000) {
+                       NL_SET_ERR_MSG(extack,
+                                      "clock frequency must be 1 kHz or mo=
re");
+                       return -EINVAL;
+               }
+               if (ref_freq <=3D sync_freq) {
+                       NL_SET_ERR_MSG(extack,
+                                      "clock frequency must be higher than=
 sync frequency");
+                       return -EINVAL;
+               }
+
+               zl3073x_ref_sync_pair_set(&ref, sync_ref_id);
+               mode =3D ZL_REF_SYNC_CTRL_MODE_REFSYNC_PAIR;
+       } else {
+               mode =3D ZL_REF_SYNC_CTRL_MODE_REFSYNC_PAIR_OFF;
+       }
+
+       zl3073x_ref_sync_mode_set(&ref, mode);
+
+       rc =3D zl3073x_ref_state_set(zldev, ref_id, &ref);
+       if (rc)
+               return rc;
+
+       /* Exclude sync source from automatic reference selection by settin=
g
+        * its priority to NONE. On disconnect the priority is left as NONE
+        * and the user must explicitly make the pin selectable again.
+        */
+       if (state =3D=3D DPLL_PIN_STATE_CONNECTED) {
+               chan =3D *zl3073x_chan_state_get(zldev, zldpll->id);
+               zl3073x_chan_ref_prio_set(&chan, sync_ref_id,
+                                         ZL_DPLL_REF_PRIO_NONE);
+               return zl3073x_chan_state_set(zldev, zldpll->id, &chan);
+       }
+
+       return 0;
+}
+
 static int
 zl3073x_dpll_input_pin_ffo_get(const struct dpll_pin *dpll_pin, void *pin_=
priv,
                               const struct dpll_device *dpll, void *dpll_p=
riv, @@ -1100,6 +1206,8 @@ static const struct dpll_pin_ops zl3073x_dpll_in=
put_pin_ops =3D {
        .phase_adjust_set =3D zl3073x_dpll_input_pin_phase_adjust_set,
        .prio_get =3D zl3073x_dpll_input_pin_prio_get,
        .prio_set =3D zl3073x_dpll_input_pin_prio_set,
+       .ref_sync_get =3D zl3073x_dpll_input_pin_ref_sync_get,
+       .ref_sync_set =3D zl3073x_dpll_input_pin_ref_sync_set,
        .state_on_dpll_get =3D zl3073x_dpll_input_pin_state_on_dpll_get,
        .state_on_dpll_set =3D zl3073x_dpll_input_pin_state_on_dpll_set,
 };
@@ -1190,8 +1298,11 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *p=
in, u32 index)
        if (IS_ERR(props))
                return PTR_ERR(props);

-       /* Save package label, esync capability and phase adjust granularit=
y */
+       /* Save package label, fwnode, esync capability and phase adjust
+        * granularity.
+        */
        strscpy(pin->label, props->package_label);
+       pin->fwnode =3D fwnode_handle_get(props->fwnode);
        pin->esync_control =3D props->esync_control;
        pin->phase_gran =3D props->dpll_props.phase_gran;

@@ -1236,6 +1347,8 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pi=
n, u32 index)
        dpll_pin_put(pin->dpll_pin, &pin->tracker);
        pin->dpll_pin =3D NULL;
 err_pin_get:
+       fwnode_handle_put(pin->fwnode);
+       pin->fwnode =3D NULL;
        zl3073x_pin_props_put(props);

        return rc;
@@ -1265,6 +1378,9 @@ zl3073x_dpll_pin_unregister(struct zl3073x_dpll_pin *=
pin)

        dpll_pin_put(pin->dpll_pin, &pin->tracker);
        pin->dpll_pin =3D NULL;
+
+       fwnode_handle_put(pin->fwnode);
+       pin->fwnode =3D NULL;
 }

 /**
@@ -1735,6 +1851,88 @@ zl3073x_dpll_free(struct zl3073x_dpll *zldpll)
        kfree(zldpll);
 }

+/**
+ * zl3073x_dpll_ref_sync_pair_register - register ref_sync pairs for a=20
+pin
+ * @pin: pointer to zl3073x_dpll_pin structure
+ *
+ * Iterates 'ref-sync-sources' phandles in the pin's firmware node and
+ * registers each declared pairing.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_dpll_ref_sync_pair_register(struct zl3073x_dpll_pin *pin) {
+       struct zl3073x_dev *zldev =3D pin->dpll->dev;
+       struct fwnode_handle *fwnode;
+       struct dpll_pin *sync_pin;
+       dpll_tracker tracker;
+       int n, rc;
+
+       for (n =3D 0; ; n++) {
+               /* Get n'th ref-sync source */
+               fwnode =3D fwnode_find_reference(pin->fwnode, "ref-sync-sou=
rces",
+                                              n);
+               if (IS_ERR(fwnode)) {
+                       rc =3D PTR_ERR(fwnode);
+                       break;
+               }
+
+               /* Find associated dpll pin */
+               sync_pin =3D fwnode_dpll_pin_find(fwnode, &tracker);
+               fwnode_handle_put(fwnode);
+               if (!sync_pin) {
+                       dev_warn(zldev->dev, "%s: ref-sync source %d not fo=
und",
+                                pin->label, n);
+                       continue;
+               }
+
+               /* Register new ref-sync pair */
+               rc =3D dpll_pin_ref_sync_pair_add(pin->dpll_pin, sync_pin);
+               dpll_pin_put(sync_pin, &tracker);
+
+               /* -EBUSY means pairing already exists from another DPLL's
+                * registration.
+                */
+               if (rc && rc !=3D -EBUSY) {
+                       dev_err(zldev->dev,
+                               "%s: failed to add ref-sync source %d: %pe"=
,
+                               pin->label, n, ERR_PTR(rc));
+                       break;
+               }
+       }
+
+       return rc !=3D -ENOENT ? rc : 0;
+}
+
+/**
+ * zl3073x_dpll_ref_sync_pairs_register - register ref_sync pairs for a=20
+DPLL
+ * @zldpll: pointer to zl3073x_dpll structure
+ *
+ * Iterates all registered input pins of the given DPLL and establishes
+ * ref_sync pairings declared by 'ref-sync-sources' phandles in the
+ * device tree.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_dpll_ref_sync_pairs_register(struct zl3073x_dpll *zldpll) {
+       struct zl3073x_dpll_pin *pin;
+       int rc;
+
+       list_for_each_entry(pin, &zldpll->pins, list) {
+               if (!zl3073x_dpll_is_input_pin(pin) || !pin->fwnode)
+                       continue;
+
+               rc =3D zl3073x_dpll_ref_sync_pair_register(pin);
+               if (rc)
+                       return rc;
+       }
+
+       return 0;
+}
+
 /**
  * zl3073x_dpll_register - register DPLL device and all its pins
  * @zldpll: pointer to zl3073x_dpll structure @@ -1758,6 +1956,13 @@ zl307=
3x_dpll_register(struct zl3073x_dpll *zldpll)
                return rc;
        }

+       rc =3D zl3073x_dpll_ref_sync_pairs_register(zldpll);
+       if (rc) {
+               zl3073x_dpll_pins_unregister(zldpll);
+               zl3073x_dpll_device_unregister(zldpll);
+               return rc;
+       }
+
        return 0;
 }

--
2.52.0


