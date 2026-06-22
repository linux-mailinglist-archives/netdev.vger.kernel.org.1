Return-Path: <netdev+bounces-301023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kf71EpUJOWoTlwcAu9opvQ
	(envelope-from <netdev+bounces-301023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:08:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A896AE8A2
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:08:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=schleissheimer.onmicrosoft.com header.s=selector1-schleissheimer-onmicrosoft-com header.b=Th4j84U9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301023-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301023-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=schleissheimer.de (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4B8830045A3
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4963A1E7E;
	Mon, 22 Jun 2026 10:08:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11022086.outbound.protection.outlook.com [40.107.149.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409F43546E2;
	Mon, 22 Jun 2026 10:08:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122884; cv=fail; b=lWOnESiAIrAXL13xHPrMBCH/dwA7Z+tOCG6RJum++hYIpskB/4H8C+hB2SHdvbwJyDSy5J71fafxTOY3Q30HluVbSaueiCg1IoLeeNdsxovmsdxpWJs3+2WdlYfpbUr8gJrfUlLjuRZ7dVWK1msMw3Oe+JYzAaBT+a+4bVqZPsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122884; c=relaxed/simple;
	bh=lxQ7LdeiyCoIV+0GgChktwVs/J5YAXSDk879WJfexKk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A57NEENz3x8YTokCxXJbwqRRE56rP7XZjp2Sd10uHeJe3Jh+Df/FW9OWgesgXvwe6Xi0wkPBgd3Csz3ELksmyA7XsISGVtj1tA7F/a2+M41wrHx2yg8LioLVAefKgUQjzo+erwkFiRz0kf6qvMiqHi/FLBhmYeN50vc3Fj9eoR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=Th4j84U9; arc=fail smtp.client-ip=40.107.149.86
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDoRVQu4T0jk2msYBLjGg+Xhc+75Gy9Owj/vigK9Wo4Kqfv7/ryVO1YmGa2HrdwrPGSxHt/DyqitdH7YIi1rhFfYteu8IqSncnJL/rgILK+qdwYWaQjzKqvlgI0m6US3Y7ckDTiaX8icJkSrQpo6pTrPKQX47yEPFGqjXvYA4bLeNS3/TaPGB2eHlxRa9uoMhM1v3ruaGe3bOAx610LFKSmhA4eoPBKBX+WK1BRy8cGb3RqfxbCqMODfPY/JrA7IPWniYOqGlzhLVcnZntImYIVvrg1wLzGaSogTuq4zRHD8WNohMNSEu0X0LC2z3EPjoOAZzOVHa8LByUT8yskvJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sv0/LYeFgN4I8uPReQPcKF4hmwV/rr3KGZMPGY4fses=;
 b=NgAbHKcVwelUhNZuspqts0ZVUWL2VoOtUXsvy+Vtc8UGSvWairgxQiwD/6v9TY0KvRDukxDQhijTq8DHv95GNylMaIGaf0VejSr1s0JEAxxPJl3X5H1dkZLRIPm3Tgg7ZFdcD9LmCF9/tLddt/O4wzz7Ed7IyJQBgy7q3PcZqapsm3yxx0ARjKQMI+vo2KZvv2urCeVlgKdnAFLMdy+iiAFVFvgnxgcY4RK8qlJqGnbwPl6rRM5HH5hf1NqJy7WfA0Y9vJvh1DNaTYmAL7t8CniGQKFGtP3tP9Tr3Wnu6R5BmHWYL5XR8WRM4HIWrj4H5djWJU5ZzZQ7hlGeaX1VXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sv0/LYeFgN4I8uPReQPcKF4hmwV/rr3KGZMPGY4fses=;
 b=Th4j84U9CPbTpirYnH7rW0CSs9cp2qfw2gIpJpBiu9xg796WmCqfWZPDXgwrzeVPkInM1G3KIdY+IZ1gMK5i9tsT7QqfSaACb9ahTh6v31HlBnMOXU+4eatpTuNejhrRo2kmXpfxJhVkXnNSEqYS6zY3dSRr4+83YEiYVhJGHVU=
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:52::10)
 by FR3PPFBCCFF56E9.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::189) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 10:07:58 +0000
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9]) by BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 10:07:58 +0000
From: Sven Schuchmann <schuchmann@schleissheimer.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
CC: Thangaraj Samynathan <Thangaraj.S@microchip.com>, Rengarajan Sundararajan
	<Rengarajan.S@microchip.com>, "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>, "Woojung.Huh@microchip.com"
	<Woojung.Huh@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: AW: AW: AW: [PATCH net] net: usb: lan78xx: restore VLAN filter
 table after device reset
Thread-Topic: AW: AW: AW: [PATCH net] net: usb: lan78xx: restore VLAN filter
 table after device reset
Thread-Index:
 AQHc/1ZL+dYj4wyIHkavMkZrzwxM9bZFg8XYgAAJTICAAAseOIAADC2AgAA5uBSAAAuXgIAEdNa1
Date: Mon, 22 Jun 2026 10:07:58 +0000
Message-ID:
 <BEZP281MB22457C80F9D1AC7F788EC008D9EF2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
References: <20260618191109.4086598-1-nb@tipi-net.de>
 <BEZP281MB2245740AE8E3221DD076CE7DD9E22@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <6d638042ad07a8bfb09ff3ee923e7b3f@tipi-net.de>
 <BEZP281MB2245422BB9FBFF4AFE081451D9E22@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <4abfc9b1e8860da93c03639863bd0232@tipi-net.de>
 <BEZP281MB224523ADACDB48D8E3974D4AD9E22@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <f76711d2f45c527f9ce0f5d288631bc6@tipi-net.de>
In-Reply-To: <f76711d2f45c527f9ce0f5d288631bc6@tipi-net.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2245:EE_|FR3PPFBCCFF56E9:EE_
x-ms-office365-filtering-correlation-id: daba37fe-99f2-4121-7f7d-08ded04622c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|38070700021|6133799003|18002099003|22082099003|4143699003|56012099006;
x-microsoft-antispam-message-info:
 eaBvuecnY7pCmwYWWsrMOy9YNkCuEXV+N9pLnfIn2lH7wUqzRuENKIaQmxyxNywF3FsKOcHHTqji8Fsl2CL7rP4ZbqxXuQl/3wDkRv58gJE2TZrXa3ZaXmpIvk2oNsAttZQSc7npF66KroeHO1SE6kxh668jWPa3phwiVeCA8Qz2obHC2esZI/YRmiDRZQkJhkQ+uxYcXP6TNysuF+d4RX6kpfBt+/3Zjvl2rJYTn8SsEyZUgixY+82zc4TO/7K7vUQu/HoDgQaJIlAsfimYyrjWRonG+JYhCPkoIJ0B5fV9GP0fQ+YjX7bUWO7pohWlvOGrDLNroSH0G2m/PUdcFSrLmE199ZOePM0AoF/Dj0XFrRg+iteYPpsvTs4edtiGsIQeTZGIQ38RbeaENYomo0PalmmisM95skCe+0ZMv2mvYzdSfyYM1pSjDokDlTSAmrBlDG6Fe75yrAqXzR2FLP5hEoRTlFXwOSBEZybacWD63MWl07xgaSvi4FpRMPkjyRQ9xSGH4wr04UVb3mPtOv6phwuMSZaY5YSTkJwgbdaix6In/8ua4TwG5S9FeEw8U+++9zVhlaU4izo6igOnLSbEeHIcRunlOjSdD+pC9YTi0c4/f26WypTr/MVF10nCrzgfOqIKeoWQBbTP0dcCIEA8jJmk0bdVed5lTyWMiUeVrtNoNLlz3TG/dDywunRGi64DIvyCgZAqECBdjYqBoMF0q3/ouW6gXhoVw0poAwY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(38070700021)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?aO1uU7kjlR9UXt2f1NSOUF/uD9fjtvwk2S1du8RqV6eCGiAUMX0PCh3URL?=
 =?iso-8859-1?Q?0M76y1CvVXySDeiq3ZGi4icIhSXlAIGkaEwndI0wtIiGV2j3RmwfTiC9Ez?=
 =?iso-8859-1?Q?LWNr2CRKiWuGMgnX9hSJv9BWxeYx0xc94HICdhE/JYwG0MUTfXt4GIjmJM?=
 =?iso-8859-1?Q?aC9tUHTuV73UkPuiQLU/oAhp0Y2/x6JImiZLGG/bBq+BCKyz/cDE0OPq98?=
 =?iso-8859-1?Q?KffF9RIT2xetx3KWRttHwl+dcZURZp6vVKPWFT0r4LBtGIRQj3CTmiWbtx?=
 =?iso-8859-1?Q?HQvysl7v27/22cV+ljsAiocu5xYp1cRP00V3vu7qLSRY86vFpJGvmVNVXz?=
 =?iso-8859-1?Q?LJ0xoDLgd3tjdh/Y07FJoDvkH8rVz21X5Lobb3BEHcdvAJCQbR+8FJ/Gvu?=
 =?iso-8859-1?Q?ZTnz8Npdx8py+/VpWe7NGeF7XM62ioJnMz364BO/G4SdVv2slTX87VaOtC?=
 =?iso-8859-1?Q?KPARea1oR5zU2PYaiM7UIws7Ep6UMQjbZh3+CAJBmjThCY0OVS0LsP/xGO?=
 =?iso-8859-1?Q?9OymmMpJ/mjskqm/vNPjD8nvdYs8WQaBrXx/O38OpImc1wFQiehZtSquS0?=
 =?iso-8859-1?Q?yvZYjy3VvLLHmMxCstaJPsA1pzYaleep0aqHtuJy7is8KLhy+X8JXBQPai?=
 =?iso-8859-1?Q?Wl94nxeS0ZA9o9X682UbLFwyvpNrFmVzRud/5UJSS0ts2ajEZQMxlq9+2P?=
 =?iso-8859-1?Q?P4EMnhjJeiB7h33kA/mAVK1vTHR8MiE4ibENd1j+pDI7iu/DKInKT/8c8d?=
 =?iso-8859-1?Q?kDZ+3nxRsHJH17Ah3gv/DAR3eKfzIUsZVvHlJsPds+/ekdJaWIS/NxN1UN?=
 =?iso-8859-1?Q?G8+Bwv3tLvy31RD1qAo4k5GbqXQozcO5oRiBsTGnt++kFgahIj3CA5nKND?=
 =?iso-8859-1?Q?tZZetNMUk7FRajztuw1m25XKODXKEKNsOkeJXYWpW5CAUkIIRLAn8ArKMZ?=
 =?iso-8859-1?Q?Z/7a+WeqooTl/DrJlFFz8lP9W8QLduQane1x+2a+ln6QN0OoX4RpnaRYJ9?=
 =?iso-8859-1?Q?DjsxaGYhLV0jQmoz/Ob+HMIaTX47NJ4DfBbrWBwGisHym4cKZKbxdW7l5h?=
 =?iso-8859-1?Q?v2Zq6toVr60N67W6c02Q58Zn3cAySs1HJN2gTwQlLmhQpf7wzJNuOcC6dO?=
 =?iso-8859-1?Q?L7W5UJKCiyyox6OgQfZZ/cK4yKPlPPBfX+z6K1KezOSOKqcA+Hb+9MzW3n?=
 =?iso-8859-1?Q?c16QdfCALdXVLoDhI2NuFfw+j658+4j46rTRFy/tOENhhuaUGP/dO/4ojg?=
 =?iso-8859-1?Q?PJJ3C9lqAjY90LC6aus8OHcDt+TLSdzFiRChQcZh5NJkrvZzAHD4rvQhBA?=
 =?iso-8859-1?Q?JYdbUFmIyGnldGJMdZOs+vQlKY+DTt/vizytG/104j3Tgs3Nf1f0SYXI7Q?=
 =?iso-8859-1?Q?BQiEGVKbNIozu8XziC0YdeMcCJN8jkBLYqUrFgD/NJ6Qi5rrGNPfs4axJs?=
 =?iso-8859-1?Q?b7eLITW+tCbKjDYOwo1mkdRX15bmZ7dzVoQ1B+8k6De2t9d6Gp/H02HcHS?=
 =?iso-8859-1?Q?5sfhLJYphzW5COprqIqd/g+z0716hy6yiyt0dQvLKGmePuJEh8NVu+czWX?=
 =?iso-8859-1?Q?6SLXjYQQPo23CBJQXs1JUWV1TGx2jaTWrI1DuI83eI9nCCLotcC0GgPgnL?=
 =?iso-8859-1?Q?frMhNj8tSEcs/ZR5unN+msrLT0ipvGidseWGspsf+bPMkj/AYVb8KurfXz?=
 =?iso-8859-1?Q?P9/bw1B9BC+UIm0yWq+MIKjqQysPYHpzO+eHwrvN334LoHHRLOjun1Q6Lu?=
 =?iso-8859-1?Q?VuSArM9IkiCuzdnIr1dqFNaU4zha3Z9nMJpu3NbtXSsgU8O2jRf2tViECQ?=
 =?iso-8859-1?Q?LOa4nOKKNA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: daba37fe-99f2-4121-7f7d-08ded04622c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 10:07:58.2246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /9LDN9Sw/XY5ZKyU4OuWsBUYW2uhMw7fSQfF3FSx9fB/qNOVYoex4pRK3hPRKoYRUd6jkFrwmNsx8RmcmjW0e2U9Zvjg4YUkrHZo3c0Wh7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3PPFBCCFF56E9
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[schleissheimer.onmicrosoft.com:s=selector1-schleissheimer-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[schleissheimer.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301023-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[schuchmann@schleissheimer.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:Thangaraj.S@microchip.com,m:Rengarajan.S@microchip.com,m:UNGLinuxDriver@microchip.com,m:Woojung.Huh@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schuchmann@schleissheimer.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[schleissheimer.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1A896AE8A2

Hello Nicolai,=0A=
=0A=
On 19.6.2026 16:01, Nicolai Buchwitz wrote:=0A=
> Hi Sven=0A=
> =0A=
> On 19.6.2026 15:31, Sven Schuchmann wrote:=0A=
> > Hello Nicolai,=0A=
> >=0A=
> > looks good from my point of view=0A=
> > (Calling the lan78xx_write_vlan_table() from=0A=
> > lan78xx_mac_link_up() and from lan78xx_reset()).=0A=
> =0A=
> Thanks.=0A=
=0A=
Just to be clear I used this patch which is looking good:=0A=
=0A=
---=0A=
 drivers/net/usb/lan78xx.c | 26 +++++++++++++++++++++++---=0A=
 1 file changed, 23 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c=0A=
index a5132f2f9..a2db38650 100644=0A=
--- a/drivers/net/usb/lan78xx.c=0A=
+++ b/drivers/net/usb/lan78xx.c=0A=
@@ -1571,6 +1571,7 @@ static void lan78xx_set_multicast(struct net_device *=
netdev)=0A=
 }=0A=
 =0A=
 static void lan78xx_rx_urb_submit_all(struct lan78xx_net *dev);=0A=
+static int lan78xx_write_vlan_table(struct lan78xx_net *dev);=0A=
 =0A=
 static int lan78xx_mac_reset(struct lan78xx_net *dev)=0A=
 {=0A=
@@ -2528,6 +2529,10 @@ static void lan78xx_mac_link_up(struct phylink_confi=
g *config,=0A=
 	if (ret < 0)=0A=
 		goto link_up_fail;=0A=
 =0A=
+	ret =3D lan78xx_write_vlan_table(dev);=0A=
+	if (ret < 0)=0A=
+		goto link_up_fail;=0A=
+=0A=
 	netif_start_queue(net);=0A=
 =0A=
 	return;=0A=
@@ -3081,14 +3086,20 @@ static int lan78xx_set_features(struct net_device *=
netdev,=0A=
 	return lan78xx_write_reg(dev, RFE_CTL, pdata->rfe_ctl);=0A=
 }=0A=
 =0A=
+static int lan78xx_write_vlan_table(struct lan78xx_net *dev)=0A=
+{=0A=
+	struct lan78xx_priv *pdata =3D (struct lan78xx_priv *)(dev->data[0]);=0A=
+=0A=
+	return lan78xx_dataport_write(dev, DP_SEL_RSEL_VLAN_DA_, 0,=0A=
+				      DP_SEL_VHF_VLAN_LEN, pdata->vlan_table);=0A=
+}=0A=
+=0A=
 static void lan78xx_deferred_vlan_write(struct work_struct *param)=0A=
 {=0A=
 	struct lan78xx_priv *pdata =3D=0A=
 			container_of(param, struct lan78xx_priv, set_vlan);=0A=
-	struct lan78xx_net *dev =3D pdata->dev;=0A=
 =0A=
-	lan78xx_dataport_write(dev, DP_SEL_RSEL_VLAN_DA_, 0,=0A=
-			       DP_SEL_VHF_VLAN_LEN, pdata->vlan_table);=0A=
+	lan78xx_write_vlan_table(pdata->dev);=0A=
 }=0A=
 =0A=
 static int lan78xx_vlan_rx_add_vid(struct net_device *netdev,=0A=
@@ -3378,6 +3389,15 @@ static int lan78xx_reset(struct lan78xx_net *dev)=0A=
 =0A=
 	lan78xx_set_multicast(dev->net);=0A=
 =0A=
+	/* The chip reset above also clears the VLAN filter table held in the=0A=
+	 * shared VLAN/DA hash RAM. The network stack does not re-add VLANs=0A=
+	 * after a silent device reset (e.g. on reset_resume after USB=0A=
+	 * autosuspend), so restore the table from our shadow copy here.=0A=
+	 */=0A=
+	ret =3D lan78xx_write_vlan_table(dev);=0A=
+	if (ret < 0)=0A=
+		return ret;=0A=
+=0A=
 	/* reset PHY */=0A=
 	ret =3D lan78xx_read_reg(dev, PMT_CTL, &buf);=0A=
 	if (ret < 0)=0A=
-- =0A=
=0A=
> =0A=
> > But I investigated a little more and it seems the hash table=0A=
> > (which is right behind the vlan table in the controllers memory)=0A=
> > also gets cleared. I wrote some random data into this table and have=0A=
> > seen that it gets also cleared. I think this needs to be fixed too.=0A=
> =0A=
> Something like=0A=
> =0A=
> static int lan78xx_write_mchash_table(struct lan78xx_net *dev)=0A=
> {=0A=
>         struct lan78xx_priv *pdata =3D (struct lan78xx_priv=0A=
> *)(dev->data[0]);=0A=
> =0A=
>         return lan78xx_dataport_write(dev, DP_SEL_RSEL_VLAN_DA_,=0A=
>                                       DP_SEL_VHF_VLAN_LEN,=0A=
>                                       DP_SEL_VHF_HASH_LEN,=0A=
> pdata->mchash_table); // from lan78xx_deferred_multicast_write)=0A=
> }=0A=
> =0A=
> with callers in lan78xx_deferred_multicast_write() and=0A=
> lan78xx_mac_link_up(), should=0A=
> do the trick?=0A=
=0A=
I used this one which is also looking good:=0A=
---=0A=
 drivers/net/usb/lan78xx.c | 24 +++++++++++++++++++++---=0A=
 1 file changed, 21 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c=0A=
index d449c1950fd3..6d7d349816a6 100644=0A=
--- a/drivers/net/usb/lan78xx.c=0A=
+++ b/drivers/net/usb/lan78xx.c=0A=
@@ -1466,6 +1466,8 @@ static inline u32 lan78xx_hash(char addr[ETH_ALEN])=
=0A=
 	return (ether_crc(ETH_ALEN, addr) >> 23) & 0x1ff;=0A=
 }=0A=
 =0A=
+static int lan78xx_write_mchash_table(struct lan78xx_net *dev);=0A=
+=0A=
 static void lan78xx_deferred_multicast_write(struct work_struct *param)=0A=
 {=0A=
 	struct lan78xx_priv *pdata =3D=0A=
@@ -1476,9 +1478,7 @@ static void lan78xx_deferred_multicast_write(struct w=
ork_struct *param)=0A=
 	netif_dbg(dev, drv, dev->net, "deferred multicast write 0x%08x\n",=0A=
 		  pdata->rfe_ctl);=0A=
 =0A=
-	ret =3D lan78xx_dataport_write(dev, DP_SEL_RSEL_VLAN_DA_,=0A=
-				     DP_SEL_VHF_VLAN_LEN,=0A=
-				     DP_SEL_VHF_HASH_LEN, pdata->mchash_table);=0A=
+	ret =3D lan78xx_write_mchash_table(dev);=0A=
 	if (ret < 0)=0A=
 		goto multicast_write_done;=0A=
 =0A=
@@ -2533,6 +2533,10 @@ static void lan78xx_mac_link_up(struct phylink_confi=
g *config,=0A=
 	if (ret < 0)=0A=
 		goto link_up_fail;=0A=
 =0A=
+	ret =3D lan78xx_write_mchash_table(dev);=0A=
+	if (ret < 0)=0A=
+		goto link_up_fail;=0A=
+=0A=
 	netif_start_queue(net);=0A=
 =0A=
 	return;=0A=
@@ -3094,6 +3098,16 @@ static int lan78xx_write_vlan_table(struct lan78xx_n=
et *dev)=0A=
 				      DP_SEL_VHF_VLAN_LEN, pdata->vlan_table);=0A=
 }=0A=
 =0A=
+static int lan78xx_write_mchash_table(struct lan78xx_net *dev)=0A=
+{=0A=
+	struct lan78xx_priv *pdata =3D (struct lan78xx_priv *)(dev->data[0]);=0A=
+=0A=
+	return lan78xx_dataport_write(dev, DP_SEL_RSEL_VLAN_DA_,=0A=
+				      DP_SEL_VHF_VLAN_LEN,=0A=
+				      DP_SEL_VHF_HASH_LEN,=0A=
+				      pdata->mchash_table);=0A=
+}=0A=
+=0A=
 static void lan78xx_deferred_vlan_write(struct work_struct *param)=0A=
 {=0A=
 	struct lan78xx_priv *pdata =3D=0A=
@@ -3398,6 +3412,10 @@ static int lan78xx_reset(struct lan78xx_net *dev)=0A=
 	if (ret < 0)=0A=
 		return ret;=0A=
 =0A=
+	ret =3D lan78xx_write_mchash_table(dev);=0A=
+	if (ret < 0)=0A=
+		return ret;=0A=
+=0A=
 	/* reset PHY */=0A=
 	ret =3D lan78xx_read_reg(dev, PMT_CTL, &buf);=0A=
 	if (ret < 0)=0A=
-- =0A=
=0A=
> =0A=
> >=0A=
> > In the Datasheet from the LAN7801 I can read:=0A=
> > "After a reset event, the RFE will automatically initialize the=0A=
> > contents of the VHF to 0h."=0A=
> > Where VHF also refers to the hash table.=0A=
> > But I still do not understand what reset is happening when I just=0A=
> > unplug the network cable....=0A=
> =0A=
> I suspect it is triggered from the PHY:=0A=
> =0A=
> 8.10 (MAC Reset Watchdog Timer):=0A=
> "A portion of the MAC operates on clocks generated by the Ethernet PHY=0A=
> [...] PHY Reset=0A=
> (PHY_RST) results in resetting the portion of the MAC operating on the=0A=
> PHY receive and=0A=
> transmit clocks."=0A=
> =0A=
> So which PHY are you using?=0A=
=0A=
I am using a DP83TC812R from TI. There is currently no driver available=0A=
so I ported this one=0A=
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/net/phy/dp83tg720.c=0A=
which is working fine (maybe I will also publish a patch for this).=0A=
=0A=
The strange thing is that the MAC Reset Watchdog Timer seems =0A=
to occur "silently" so that nor the mac or the phy driver know=0A=
about this reset.=0A=
=0A=
But never the less. The two patches fixed my problem and=0A=
I think they should be mainline. =0A=
=0A=
Regards,=0A=
=0A=
   Sven=

