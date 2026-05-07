Return-Path: <netdev+bounces-285158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCKPLJw2/GmUMwAAu9opvQ
	(envelope-from <netdev+bounces-285158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 08:52:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 290524E3BBA
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 08:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1030E301E7F9
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 06:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02901345CC9;
	Thu,  7 May 2026 06:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b="GCJloFyn"
X-Original-To: netdev@vger.kernel.org
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020102.outbound.protection.outlook.com [52.101.171.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B7929898B
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778136729; cv=fail; b=lqBGCNBqWvEm8/Im0qxFGcEYvqMyzRhBWY3r5c4dT/O3IYZ15n3E+sFVx3phYvN+UXGN8X2iuXVleWF2AczgaRgTOTN5baNk3uTwOIv4hcAN797s2fz1i63Tjuf4d9QSVFbOX0u23KK3XLEbSSAKDMUMYK2X+LzqBstDeXJdpnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778136729; c=relaxed/simple;
	bh=XNWSpF9q5nlFgAOJWv38DCAEiUAO6YblPaaquNc+jyw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nuQzMUxMk38sX7o9zOu9O+5YDd19E5KJa07WtwvLzY8zRIijUxBMifrFYGf+0zy7cWb3erxEPwMQ1zyQU4In69gBGywD0GoznJNlrEEg+cAIFBpkc0/A0NmTe/Rz+4A+P64BgyU1GSY/Jtqb8tfVbgXpJCCqOzwaSTs1dJvVuhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=GCJloFyn; arc=fail smtp.client-ip=52.101.171.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schleissheimer.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlPF3T17peEM8A107snng2ewguSC62bgfVdEn/3eMTaYjGcWkE54xsvyi4UkkSgxHe/js9AyWT2KHtz+bfLFg2z7oAm8f9oQzy8pQs4NhklPLxescVhF3FxLHtz9NcrlVOwJk6OPHETr83R1tU6QqsIqVwKeTNYJddI7jTOG+5u7USNKoHZdvn+Rh0Ma63tkkRUZrJnTKsItAgBmMf4gUi0yIUZVVx/v/iVMVB/zMQaM0W/qakBY5+BEgThfAINkuWtNYSo+HAaQB34MUNtFsyvD8Pww/k3D9CtgngoqKWW2Fi4Q9yL2jWLpSTnCY5A5SnjP30NJshIJZqcmv/BNLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bx9+RXYNESx3nBQTPxbXgDED1v6vWAgNqbZ7aUriAw0=;
 b=nDlFYmnvE9Y02XgXRiwokVMX6OnuqnYAMiLF4rPWD2f1RwEHTv6HEVkBxFD2H+7F59WiHO2yyhrdpGZCMigMtjTOprZGOsiKCoK25heQPwgxNwR4CE6Qp1FG85rNfD2BS27ySWUNzb6rtPgVCRTrjqh9coXDtB9HMAOBjNIzh5Kb3nC8ZM+H61yuU6AeBfwDpZsPyLYWhP1WFHwVxNosfJ+zXeJ10TuDpOV7kTalD0AbwdLVP1S1ADQqcGGQ1HuEfXbt2Jg4Bcmhi4aKGnEIgpQ9+VA1jCvXafJuCZDDkKwRTspCfSoFjrPfrFkVqmUQFznZkid48BseSjNKvZoAVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bx9+RXYNESx3nBQTPxbXgDED1v6vWAgNqbZ7aUriAw0=;
 b=GCJloFynkhPDr/kWAAi2wCKwxYg0GzplVm5O82WjGdv55s3XwBswudcu1F/RwUZlWWHPDm1MDxXIUZHoJVII/dakBV85m3mbudCrUGydxfdcQkjCWdaqS5aRckchzcIQdxszp1FjpH735D2HaH7D7uqzVNeWGVRcf7UBEMM5LxY=
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:52::10)
 by FR4P281MB4956.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:193::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 06:52:03 +0000
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9]) by BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9%4]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 06:52:03 +0000
From: Sven Schuchmann <schuchmann@schleissheimer.de>
To: Andrew Lunn <andrew@lunn.ch>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: AW: assert in phylink.c with lan7801 and dp83tc811 since kernel 6.18
Thread-Topic: assert in phylink.c with lan7801 and dp83tc811 since kernel 6.18
Thread-Index:
 AQHc3HSt2FaNRg+Hc0Clgdk/8rilD7X/aQMAgAEuzo+AAFoaAIAABvoAgAAD+ICAACpjCYAADeQAgADrfv4=
Date: Thu, 7 May 2026 06:52:03 +0000
Message-ID:
 <BEZP281MB2245BB0FC7DA18B285BD564CD93C2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
References:
 <BEZP281MB224533D524B27CFC6E47B447D93E2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <57fb63c2-7a05-4bbe-ba2d-fc61ce1e3ba1@lunn.ch>
 <BEZP281MB22458F571CC8251C141D933CD93F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <7778cd41-cf36-4524-a347-408a8fb0bde0@lunn.ch>
 <f9b8840d-94ba-4bde-9ace-fb81eb733ff9@bootlin.com>
 <eba96f21-78e6-42bf-938a-6d4037d0a305@lunn.ch>
 <BEZP281MB22457317618130F28E84E3B4D93F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <24815161-68ff-4f3e-b0e1-286871b9686a@lunn.ch>
In-Reply-To: <24815161-68ff-4f3e-b0e1-286871b9686a@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=schleissheimer.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2245:EE_|FR4P281MB4956:EE_
x-ms-office365-filtering-correlation-id: 1f6b0b3c-0f3e-40a0-c919-08deac052524
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|38070700021|56012099003|22082099003;
x-microsoft-antispam-message-info:
 o60QFQuNC6IMN+QRbRBjz4ap5ok0OC5hdbzrclukPJZJmjM79iWDlRuJIAIEVeUkQqdhgqJHQtDdvIa85ppa9S2P3FWIq6GmWpJLg0xkwkp6qbG9W65nVm3tx2vVtkkMh7Av26Ql1x7bpckogoPGFvzKJdut6+IKdSpeooNqDbIMzohuDrbhRl+1cjG4r0R3ox76lnzDEo70C3TnMoTgEHA20tQITnnzjVAtHsIQxUobjP64zC72Lq7fs0ODvmt/o/duQ2oCK+3C6+SJft04S2AliOLK2LcDOomH8AaiAfeYByGy0XX+WGy/cGmNYmguwSBhQe9yU5O9t2tbGDJY6MAwI/lyjoJsJbXffCrCL4To8E2s2iq4i1yuKqT6K87R6/44YVxJ4n1Vg8A9vTHTmrlbCvCYV4AiOhs8n6zmmKuhdMM1+feF7FI3r3LecDjVTWYaduzpV8ABVyrtD8rmscjm47f0MvsUzlBkJhdcJJrY75akG9derdf8tOGd0SG9ASAj3ubEua/FYaq/OyXRxS0sBSU2fKI3OKRALA6K5R0DB5sgJGVDvq2Oc9gITMWZJPuQeCiUp3W5wJZ7EcYRKE0cBPerortwNpiplTEfjPyFJwpmk2eOownfYVDiFjjgJlfzB5hHGovM50PRLWwR+2D4Unsk/I9D7kzBBcVBb9TTc+GL6PreNYlMsGdTjSSjlcCYoaWKqIC4jx+FuFBkNw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(38070700021)(56012099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gV0RTSj4Y5LfBCthzNPeh+u5JkLfSxWS/gu5jXEUpaJWBIHTwAlN9VeAE+?=
 =?iso-8859-1?Q?4vjpBcqgKu2RhzkCESQlDXK9IIcoYQlF2s+JbblW6yFJfTBf2qfHy2fAlE?=
 =?iso-8859-1?Q?jBy0QfNnZqvwUutSVTAL/0CglnzrAdh4woMtyhLReQUvppEERQ3Pp/dX2Z?=
 =?iso-8859-1?Q?L5IYUR6pCJOPcKNdPQVnMAGFP+nvArmPZNC91Wa0LH0X3Xq4lCzjMYZKCQ?=
 =?iso-8859-1?Q?/2MZtxUpB59R7i1+0WAyZjTPVAFNzFDpO7Kv2F+TdHruFJZvEXsvb6KxMt?=
 =?iso-8859-1?Q?GCFBlKzq13xSO+aqX/AJqD0yUGWJpbtdGD8oGcMqQG8Ve0gHdaPMR6bGNI?=
 =?iso-8859-1?Q?3xg/XyhFbxRaN8xNOAbFcqF7lUTPo46rmHTbWBaWdDgxSwRCKeic618cE1?=
 =?iso-8859-1?Q?SpvlnO7bRH0xABDSVF4xwVRfugGhY8KL8UGkwSUn2/ZBtRdw1YLGP1AJJX?=
 =?iso-8859-1?Q?Ncm+5XFXpsc9jh1HNArtYqYDhajktCdsD6gWnpuiM+Po9ma75EfkUryoNw?=
 =?iso-8859-1?Q?zKF6wbCrbpz42/H3QhhbAQNPm0H4POBB0C9Z7bOEuPupUG3C9/HVtHA3pn?=
 =?iso-8859-1?Q?abIfrDXR7JtSL3GUIvNt/9WOG35JLofA4oAvjwmdJZ19RxBvgQaO1ZWyEv?=
 =?iso-8859-1?Q?AgaalD6bIJkdyZzpTH84jOQkEQ7xGkFwbXbS+s7eurWMVOenZD8IRqVTJZ?=
 =?iso-8859-1?Q?Ur7giZQoKwaCUXALW0NhSaBG0AvSb9Gqv8W25zA6p1M8XI2HYd7F4QFqKW?=
 =?iso-8859-1?Q?lEtG8pyWuw5FORhub6pKyzqQy7YzMrNvY3G8i/oUV/V+ghF8FmFaxdyuQy?=
 =?iso-8859-1?Q?Ibx6liVmHrM1RP/IPNIlwuxm7ry6P9kQsUH1blhN7UHFvCGdcNVes0hcOO?=
 =?iso-8859-1?Q?6wgLbqNWd9hgXKM0K+AoKm0VMdhcvpJD53tfx2fg+sb9eZOD3kzEVbFy/0?=
 =?iso-8859-1?Q?vHNSyI3sqLMBE6RxbucOvaEpD0pzOmd3yQwCA0nzPluEwYv+4VAJOp/R1z?=
 =?iso-8859-1?Q?nDXK8h2U34UzPHcTZBmJABjUBAimTGmI0U1PqVIPadRL2L+xMlWxOzOUoL?=
 =?iso-8859-1?Q?/ArAmkgJZt9HBSlJsmpgyZ+/cIDFvZ0OMsnmTqLhw7HI0ye4IfFAWAuyPH?=
 =?iso-8859-1?Q?NeD8hc+sFlKSOxos+a+P2qsOHGCa9w+8iM7VfFe5CExAqaARy4/wYIGDst?=
 =?iso-8859-1?Q?iBEvszAcLJASWf+xKMKpb1ExLuCobyZkBPT6VM0s0qNHkfd0Z6+X8kZNaA?=
 =?iso-8859-1?Q?BMj8FRtFBQszVOvawweHSImQhtZ/MpQPdmOY/oMRo/CuhHQ+TCuWBSAvPz?=
 =?iso-8859-1?Q?8AyOKIYRyYE8K/TY86lEHdQOgQIT8i0x3dnoIEeN05pBrFS3lylxgekVAw?=
 =?iso-8859-1?Q?GwBYlG9TzaszMa6Ow+OO/Ai3EpJfbS/lPfeIMEw4FI3Fv7RY+nObf3TtZr?=
 =?iso-8859-1?Q?evOkO9mqxcqC1kUhJ0K6z0uaWDZeRfIHFqm+9tvjNgBHuHf7BA1y3A3dMQ?=
 =?iso-8859-1?Q?k3KwDUTYVBPbdmcd7LfJbL4H5C6kC4tq561Jc3UChxS4WlqL0kCxr9b/70?=
 =?iso-8859-1?Q?obrT9OVwOTiN43rnymCBneuJzSwH55lCdtBGUMPgXfseQiP4BAhDEe4Af8?=
 =?iso-8859-1?Q?E/ppqUVdUC/XIhloJ+mEFsrg2s3dgy+g6Hpvvj8Hy4MgiTPyS7lM8o2PrQ?=
 =?iso-8859-1?Q?mTCHBriZbu+F233b0nD+m9QLI5Mrp3xAsLp02XZEIDPPyriDw9h+PoI8hx?=
 =?iso-8859-1?Q?7ZXLtDZ8c0PX9KpQejhPpk0puba/fGsC5+Cg+LLWyK57YyzkJ9OhfhMPy9?=
 =?iso-8859-1?Q?6yudBaUtkQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6b0b3c-0f3e-40a0-c919-08deac052524
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 06:52:03.0403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 384t2avI8daHW/JD4NMe6V6mixwlWEpAPqzhEQMk09t3gVQ6kJfGvPurrY0rmSw0jHjqghml6yUodGxes3MMGCyT56lcrlMp9VfI6NoN+Vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4956
X-Rspamd-Queue-Id: 290524E3BBA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[schleissheimer.onmicrosoft.com:s=selector1-schleissheimer-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[schleissheimer.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285158-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[schleissheimer.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schuchmann@schleissheimer.de,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Andew,=0A=
=0A=
thanks for the detailed explanation! Indeed adding  =0A=
.get_features=A0=A0 =3D genphy_c45_pma_read_ext_abilities,=0A=
to "dp83tc811.c" makes the network work again:=0A=
=0A=
[    2.253619] usb 1-1.3: new high-speed USB device number 3 using dwc2=0A=
[    2.342774] usb 1-1.3: New USB device found, idVendor=3D0424, idProduct=
=3D7801, bcdDevice=3D 3.00=0A=
[    2.342810] usb 1-1.3: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D3=0A=
[    2.342820] usb 1-1.3: Product: LAN7801=0A=
[    2.342828] usb 1-1.3: Manufacturer: Microchip=0A=
[    2.342835] usb 1-1.3: SerialNumber: 00800F780100=0A=
[    2.353766] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): defe=
rred multicast write 0x00007ca0=0A=
[    2.466961] systemd[1]: System time advanced to timestamp on /var/lib/sy=
stemd/timesync/clock: Thu 2026-05-07 08:03:39 CEST=0A=
[    2.500632] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): regi=
stered mdiobus bus usb-001:003=0A=
[    2.500675] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): int =
urb period 64=0A=
[    2.500877] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): phyd=
ev->irq =3D 37=0A=
[    2.511949] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): PHY =
usb-001:003:00 doesn't supply possible interfaces=0A=
[    2.511990] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): PHY =
[usb-001:003:00] driver [TI DP83TC811] (irq=3D37)=0A=
[    2.512005] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized): phy:=
 rgmii-id setting supported 00000000,00000008,00000000,00006000 advertising=
 00000000,00000008,00000000,00006000=0A=
[...]=0A=
[   10.336369] lan78xx 1-1.3:1.0 broadr1: configuring for phy/rgmii-id link=
 mode=0A=
[   10.336397] lan78xx 1-1.3:1.0 broadr1: major config, requested phy/rgmii=
-id=0A=
[   10.336422] lan78xx 1-1.3:1.0 broadr1: major config, active phy/none/rgm=
ii-id=0A=
[   10.336432] lan78xx 1-1.3:1.0 broadr1: phylink_mac_config: mode=3Dphy/rg=
mii-id/none adv=3D00000000,00000000,00000000,00000000 pause=3D00=0A=
[   10.337360] lan78xx 1-1.3:1.0 broadr1: PHY INTR: 0x00020000=0A=
[   10.341302] lan78xx 1-1.3:1.0 broadr1: receive multicast hash filter=0A=
[   10.341445] lan78xx 1-1.3:1.0 broadr1: receive multicast hash filter=0A=
[   10.342409] lan78xx 1-1.3:1.0 broadr1: deferred multicast write 0x00007c=
a2=0A=
[   10.345161] lan78xx 1-1.3:1.0 broadr1: phy link up rgmii-id/100Mbps/Full=
/none/off/nolpi=0A=
[   10.347681] lan78xx 1-1.3:1.0 broadr1: start tx path=0A=
[   10.348201] lan78xx 1-1.3:1.0 broadr1: start rx path=0A=
[   10.348730] lan78xx 1-1.3:1.0 broadr1: Link is Up - 100Mbps/Full - flow =
control off=0A=
=0A=
I think it is worth doing a patch on this also?=0A=
I am not that experienced in sending kernel patches but I could try...=0A=
=0A=
Regards,=0A=
=0A=
    Sven=0A=
=0A=
=0A=
________________________________________=0A=
Von:=A0Andrew Lunn <andrew@lunn.ch>=0A=
Gesendet:=A0Mittwoch, 06. Mai 2026 18:40=0A=
An:=A0Sven Schuchmann <schuchmann@schleissheimer.de>=0A=
Cc:=A0Maxime Chevallier <maxime.chevallier@bootlin.com>; netdev@vger.kernel=
.org <netdev@vger.kernel.org>=0A=
Betreff:=A0Re: assert in phylink.c with lan7801 and dp83tc811 since kernel =
6.18=0A=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 phylink_dbg(pl, "phy: --3.4 supported=A0=A0=A0 0x%x\=
n", supported);=0A=
=0A=
=0A=
=0A=
supported is a pointer, so you cannot get anything useful from=0A=
=0A=
printing its value.=0A=
=0A=
=0A=
=0A=
> [=A0=A0=A0 2.771616] lan78xx 1-1.4:1.0 (unnamed net_device) (uninitialize=
d): validation of rgmii-id with support 00000000,00000000,00000000,00006280=
 and advertisement 00000000,00000000,00000000,00006280 failed: -EINVAL=0A=
=0A=
=A0=0A=
=0A=
> But I do not get what phylink_is_empty_linkmode() is doing...=0A=
=0A=
=0A=
=0A=
The supported value is a combination of a few things. It indicates if=0A=
=0A=
the PHY supports auto negotiation, pause, asym pause, if the link is=0A=
=0A=
using twisted pair, fibre etc. It also lists the speeds the PHY=0A=
=0A=
supports. There is a list here:=0A=
=0A=
=0A=
=0A=
https://elixir.bootlin.com/linux/v7.0.1/source/include/uapi/linux/ethtool.h=
#L1963=0A=
=0A=
=0A=
=0A=
Decoding 00006280 we get:=0A=
=0A=
=0A=
=0A=
ETHTOOL_LINK_MODE_TP_BIT,=0A=
=0A=
ETHTOOL_LINK_MODE_MII_BIT,=0A=
=0A=
ETHTOOL_LINK_MODE_Pause_BIT,=0A=
=0A=
ETHTOOL_LINK_MODE_Asym_Pause_BIT=0A=
=0A=
=0A=
=0A=
So Maxime was correct, it is not listing any link speeds. From what i=0A=
=0A=
understand, it is a 100BaseT1? So you would expect to see:=0A=
=0A=
=0A=
=0A=
ETHTOOL_LINK_MODE_100baseT1_Full_BIT=0A=
=0A=
=0A=
=0A=
which is bit 67.=0A=
=0A=
=0A=
=0A=
phylib asks the PHY what it can do. For BaseT1 that would be=0A=
=0A=
genphy_c45_pma_baset1_read_abilities()=0A=
=0A=
=0A=
=0A=
https://elixir.bootlin.com/linux/v7.0.1/source/drivers/net/phy/phy-c45.c#L9=
71=0A=
=0A=
=0A=
=0A=
either the PHY has the wrong value in its register, or the function is=0A=
=0A=
not getting called.=0A=
=0A=
=0A=
=0A=
The PHY is an dp83tc811?=0A=
=0A=
=0A=
=0A=
https://elixir.bootlin.com/linux/v7.0.1/source/drivers/net/phy/dp83tc811.c#=
L387=0A=
=0A=
=0A=
=0A=
It does not set .get_features. However, dp83tg720.c does:=0A=
=0A=
=0A=
=0A=
https://elixir.bootlin.com/linux/v7.0.1/source/drivers/net/phy/dp83tg720.c#=
L654=0A=
=0A=
=0A=
=0A=
So try adding:=0A=
=0A=
=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0 .get_features=A0=A0 =3D genphy_c45_pma_read_ext_abili=
ties,=0A=
=0A=
=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0 Andrew=0A=
=0A=

