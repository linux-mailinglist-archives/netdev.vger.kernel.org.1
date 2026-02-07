Return-Path: <netdev+bounces-257689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uueiN+WchmlOPQQAu9opvQ
	(envelope-from <netdev+bounces-257689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 03:01:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 408B510494A
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 03:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83A7030214CF
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 02:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEFC1D88AC;
	Sat,  7 Feb 2026 02:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="otQ8XDOr"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013073.outbound.protection.outlook.com [52.103.74.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D8384A35
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 02:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770429666; cv=fail; b=SkwAMwHTDBdrzAtWs8mPewRdcKX2/aHl8aNzMCnUnBoertCbsJ747dhWKGsPqPg8g2d+xzICwOeuGTb9LyW0ivPDE1h2ykZ0vKMfp6wtNsH3UURLGhP45qftGqa/CvqLA53rJ8oAB9Bm0sqAn3uyfzHYmjgFzkeplCZgOBLkbb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770429666; c=relaxed/simple;
	bh=MBhh6yKu/4FkhsQR2HZP97vIVbi+1cLgO08qRBu5bjg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PH4FtgMWWEE573x7+OqZczFSmu8bIpTosDqVp88W7RPDmdk0S/JtNt6GKBCzicyqrLVLW5NjBd/7Dj7zdxReNATHWgztdt6r145SQ3ApkNwZMimfxPydJFN/3pPmRKIYfdOzoT6qDs84Wey2DR96ogKnwFQpam4nVxy9dY52I28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=otQ8XDOr; arc=fail smtp.client-ip=52.103.74.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OoNTwf+C2vEnJHnCL8b0rtLYNSrJaO9WtU4YGS0czQjtkzVssT+gYHV14ebu4uDvGCtI58VcFZI7xQjle3thUPGdinw5AI3xF/eX+tBM9x2LU+EzuI1OS/qCS/+RmxhzZFxS9ObQzhIa504sLjHYFkhuHoQpuhXS2VBANMOSMeTPXJxMhfyJor/N51cuqss8YlTRZK35Et7QSrFgd7k43+lVfi1G3oDQ5Tr/w4elO+P9z1EJC2l6NUR/DZ9mFuWeXh1VJbYtd2QvmmnBCfPV3+bLg715PACZOuVmTRUWerQtvWMtz3JUfMFe/6QiwJs7n5rl9HBljS//bO2Ww7W4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBhh6yKu/4FkhsQR2HZP97vIVbi+1cLgO08qRBu5bjg=;
 b=P9a7K/zxaUA4prWJ69eZToaScIDtJSTcdsuNUkj2zx0xbuFRfmdRN3l4wVI8KnVbV3auoewGEtfHqt6SmfoymOpvkPJTM0PKjtsQ8mMAOFIHR62Ap+kpUpikXS7hv2WQUIRb/avQzd9XwWeHdAAwQPUwNx64QyqAGyUO/YdFTHbgMLxuce6VmSSyj/1T84IHN+9T/i887gD9j48N3ahTpomFncGtHUwSKCEs5aCAavRRhmMRgJqri+tlSDWUE9/s7wPvgGi8kr1x+XiH+c/GspW3U0FRPuyot9t4T/OeNZ0NIhJyTfwflwSSkYLGMeQD+u/+bEoOgzLEUSHOLnoZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBhh6yKu/4FkhsQR2HZP97vIVbi+1cLgO08qRBu5bjg=;
 b=otQ8XDOrc3avY0Yh1aV9gfLqkJ8AndjqJHGCmG7uLJjkzo7zgMEPeRUGZcEAWbzAz/4EqM0f6U2dnexp8LcZvrkv5HhD4o4fFz1TLkaVikcw5RFFDI+D4bspPaXbccYL82gbW9d6WhAN2N3LTTeJri3xnzLQxqVFCRieGKC5Oa4r96L0sWSLGWtV73mil3i36oGBD+4obZaMaZ0N4lTB9D2yhQipgaivIMuQ3K5a0b6MbJc30hiPq0OLOl2Zv4uxJoXUAJJg3I1t/k4Q3OJQOLqnlS4GQS9xgW6W1Y2giL4fK/Y23tOq7agXu5s40fhTWCDIw26UR0z5F0qYeBFAmA==
Received: from SI2PPF4F82E9256.apcprd04.prod.outlook.com
 (2603:1096:f:fff6::7d3) by TY0PR04MB7402.apcprd04.prod.outlook.com
 (2603:1096:405:13::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Sat, 7 Feb
 2026 02:01:01 +0000
Received: from SI2PPF4F82E9256.apcprd04.prod.outlook.com
 ([fe80::aaf5:a5f9:8cca:e41b]) by SI2PPF4F82E9256.apcprd04.prod.outlook.com
 ([fe80::aaf5:a5f9:8cca:e41b%4]) with mapi id 15.20.9564.014; Sat, 7 Feb 2026
 02:01:01 +0000
From: Deren Teo <deren.teo@outlook.com>
To: "jhs@mojatatu.com" <jhs@mojatatu.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [tc] Invalid JSON output from hfsc qdisc
Thread-Topic: [tc] Invalid JSON output from hfsc qdisc
Thread-Index: AQHcl9TbEyZENOmu2UyGu+EXPXdIrg==
Date: Sat, 7 Feb 2026 02:01:01 +0000
Message-ID:
 <SI2PPF4F82E9256898C9826AF17C3AE8AD9F467A@SI2PPF4F82E9256.apcprd04.prod.outlook.com>
Accept-Language: en-AU, en-US
Content-Language: en-AU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PPF4F82E9256:EE_|TY0PR04MB7402:EE_
x-ms-office365-filtering-correlation-id: e08b5651-959e-4f6b-6d48-08de65ecbe4c
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|461199028|15080799012|15030799006|8062599012|8060799015|31061999003|51005399006|10035399007|3412199025|440099028|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?KWcziTyRJC55Y04FO+mwSzVT3xNIzSHcTRwFK6y1s7f+dJSdxajpHJpDEN?=
 =?iso-8859-1?Q?u7zQSSUif4JzbMsj3NIjtgTaTsnSNbQZb/zuiXUnL5Dk9+PwrT/KRdTt/H?=
 =?iso-8859-1?Q?8eZH8bPMg/x+FXgDJoIfE/tORW9b13JGqlI+1TbgSubpnRqszID7+PqSCI?=
 =?iso-8859-1?Q?0KMSx0HzEUlY03B4EZjQ1erbDmrujqAh2ZCfYPtlFqiKaiMUGh2jRgPNb8?=
 =?iso-8859-1?Q?1UuQ+bhJqg+IqY71mh/M82IX+wukTNXKvCJWxawMf+MY3uNi2QVil7KxUg?=
 =?iso-8859-1?Q?MycrWnbbLjygdbzKSQ0NWoUzAiM+HXkUaoxD0mfyaNZcehRyc/magTPcHw?=
 =?iso-8859-1?Q?b2ptCvDrIiYxpE56pFirF3UKDbOKsrx0lrrj8fnkxDvOMWLnriP2QUjhQg?=
 =?iso-8859-1?Q?ADAzyJVKu4PYAWPzMlNvbf/fPsDn7V8SydpDK6OzSnZGiJgAZe+QP54jYQ?=
 =?iso-8859-1?Q?uQI87RNwqlk19xJxFyhQawfQ+dgKtbO4WL9i3uILBqEEo8i1wg7lgL9mh+?=
 =?iso-8859-1?Q?k1Sdh15P3UekYFuPoz/UEjqGLqgay0npsMc96HDRhvGnKsDa8wMyfbr/er?=
 =?iso-8859-1?Q?p3tG8M9F8ymUKx56iO93MsNxC2ZIVzBODMWwb2VBLcNywV59iYS9BdMrQw?=
 =?iso-8859-1?Q?ZDc9neoz97AAaajW2yOjitbfbhR2OWbCTtOq4x1VgPrVYgO+exMoQj5YjA?=
 =?iso-8859-1?Q?vEs9hKMpMRtemqYJ5C2I9IdgZ/76fvo0avHbExV4UoOifFPp3DaAdOhhLq?=
 =?iso-8859-1?Q?Us7971m6sGcv45tBDZkD9VmrvDsg6l70WYzv5o2c9Td/WlxqhTs6GlmoWV?=
 =?iso-8859-1?Q?KD6Grp9LiBF9ZKPs6/ByCDDA5sIUOLckoKE8p3UG47U9Q0oybEyyNsbTaO?=
 =?iso-8859-1?Q?Mgw8w6bVuhsnBk/VKhB0tRC/cDKUqcR2A9Jb5PK03FqOJlSkzsCqfrnxw5?=
 =?iso-8859-1?Q?hMAri1EG7xi2USvl/iNBr2APWkBLPo2IaKfqyXrro0TaFah8MZQd5zd+CB?=
 =?iso-8859-1?Q?FdWxMzG5JVmfEokrI9yT+GwIt28XlTPgCoT3OPCwV8KaOiR5D/S/EFFkCp?=
 =?iso-8859-1?Q?Ma8+cFlw76haNmMm/J6Un7cbt+HUBhHyrB3UKkvnkogEq2Zoi9Z6woXNYP?=
 =?iso-8859-1?Q?OmjDdW175S2NmR1/zNLnP0WM5o6j2Bqub8VzNuyebreQIVjsn+JFRmTXSs?=
 =?iso-8859-1?Q?YrjomyYKCKsep7DU32W1g+tnzsCzsi3QdZcixEkmlpPGNnWYPFUzAzr5pb?=
 =?iso-8859-1?Q?ctx4ymeXsesNozHGUgl7QZyLc82EoXK2laV8txa0W+djJBv6H5WVWLyIRv?=
 =?iso-8859-1?Q?EcVGNg/8RRJeSkNtKBU0dyVVLw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?tlBC0YTS608WbyzcPsIF5E0lpGGdnk+evlwRr3CF6FuiN9qnSwqifv6hdN?=
 =?iso-8859-1?Q?po1cJTHoJ8mbAVCzeqeL4ITTScU1phHgm+KjaJUdx1OJrIHFqHBjROZnIw?=
 =?iso-8859-1?Q?AQFRiT2LHo94mhcWevXlpu5z34390TnHH4kW8m01bcT+0xME/MCBapaakc?=
 =?iso-8859-1?Q?wQDs7Os6/40n0njSFWnYIfZIUBhfNnp501wZRlyeUtm4wNnh78aXSHpR38?=
 =?iso-8859-1?Q?RI1NblnjwjoRWjce4KemMDxNPcJmHbdG0pgfLON1cXzDGI+GlkPrM9+aCv?=
 =?iso-8859-1?Q?MDXWv7kkCzI5pUEsv8PDP57rG9w+6xFU233U8auQcJtvhN2C1O4OhC1jnT?=
 =?iso-8859-1?Q?FowvG+sKRCXD8xBpN2CLB+wyvR3fsge8pwZhULPT8Lu0gPaxeyKV1GxYrN?=
 =?iso-8859-1?Q?yV8c7DTQGPy/8KyNMQgAiDI1ff1X0iDJfp+pC2wh9zXlEvfFjGT/X+Xnu8?=
 =?iso-8859-1?Q?lodSJOrTt9+qTGjabT1J2bIz1YaPoRLMWb+fAavZCDlVCR3/mdvhZtrhy9?=
 =?iso-8859-1?Q?ZkYnIblWiF6yJu15SMHlPPFUgXmV/c7X06ipIBJtRu5uAheu0ao/alHlil?=
 =?iso-8859-1?Q?Q8ytaIKyZTHKHughQjCKt6h5JZnZlVIy80zXRUG2owRCN8aRcFQaG6Z++f?=
 =?iso-8859-1?Q?mlczme4oHTN/pSh2aR41hfkPe7GUIDWhPKmf3nv+g8c4mkpJ0d1Hsy+26N?=
 =?iso-8859-1?Q?2brWOOo5JG1HvZDfXlmvRWY0xR47YZbybldYRNG8dx5snf/rLLVlvPqcXA?=
 =?iso-8859-1?Q?6dvanLQo2UDhC2W3H6lA2OjPqWj+yAQNEK15Gfof4yL1TYU5MfkWmNU6EW?=
 =?iso-8859-1?Q?pSfqBv5vdJbK1Izv9HPGt9dLOojE7e81UmhATyPAIIdDdxwm5s+5Hc4h7l?=
 =?iso-8859-1?Q?WJLO8X2CwGabA/h+02aH8TgmLiibZkZmD4TOC4eFySoxaF73JDtrOe+gh1?=
 =?iso-8859-1?Q?1QJIDPEypwOm/UAgnSEG6v8gazpy8IRaIxw9N7rVdjYAzu0dca67xDQDhr?=
 =?iso-8859-1?Q?MvAnNg+ZAC0M83vgP2/q77HKzMbI84z1k2FrHDn35xo52TNUCoKZfSdWMU?=
 =?iso-8859-1?Q?PT1zItDUZfqnCC/lOPc0S8c3wx39Ju+dnCXSxAbD+ZEA8E63rNhYOYkc7c?=
 =?iso-8859-1?Q?NJS0XiDJOOsGKTAn9NEGCDjdHJGdfajFn/1ECOItU0yPaVgWIKgEm43Eoe?=
 =?iso-8859-1?Q?7smDkfSPi2BLcJGNHghUdL5r/cyVgnP26ZFt2Ikzwo0mQb/rJnql8h/o03?=
 =?iso-8859-1?Q?O/mIUBvmLSP+PHAIyv993jzUIlGyknhyd3TltaFnbxBpgiOio0A0evQkBh?=
 =?iso-8859-1?Q?bokBnhSH5+Sd5AY3fzkE4s0dCeuSA92iQ5zXtPQzYxuEVbzVmk9IWEFnpe?=
 =?iso-8859-1?Q?bzicKeUD3AwgMMZKDVp9cBDsx+f5UhMBel9rHVtNOuCPOV3RvgY+I=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PPF4F82E9256.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e08b5651-959e-4f6b-6d48-08de65ecbe4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2026 02:01:01.2024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB7402
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-257689-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deren.teo@outlook.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim]
X-Rspamd-Queue-Id: 408B510494A
X-Rspamd-Action: no action

Dear Jamal,=0A=
=0A=
I apologise if you have received this email twice. My first attempt mistake=
nly contained an HTML part and so was not delivered to the netdev mailing l=
ist. The original content follows.=0A=
=0A=
=0A=
The JSON output for the hfsc qdisc is not parseable when a default class is=
 specified; `hfsc_print_opt` uses `fprintf` to print the default class.=0A=
=A0=0A=
=0A=
Environment:=0A=
=0A=
- Fedora 42=0A=
- Linux 6.19.0-rc4+=0A=
- iproute-tc-6.12.0-3.fc42.x86_64=0A=
=0A=
Reproduce:=0A=
=0A=
1. Add a hfsc qdisc with any default class. For example, from the tc-hfsc m=
an page:=0A=
=A0 =A0 # tc qdisc add dev eth0 root handle 1:0 hfsc default 1=0A=
=0A=
2. Show the qdisc with the `-j` flag:=0A=
=A0 =A0 # tc -j qdisc show dev eth0=0A=
=0A=
Actual results:=0A=
=0A=
[{"kind":"hfsc","handle":"1:","root":true,"refcnt":17,"options":{default 1 =
}}]=0A=
=0A=
Expected results:=0A=
=0A=
[{"kind":"hfsc","handle":"1:","root":true,"refcnt":17,"options":{"default":=
1}}]=0A=
=0A=
Additional info:=0A=
=0A=
A similar problem was previously resolved for the u32 filter by replacing `=
fprintf` with `print_uint`, etc: https://bugzilla.redhat.com/show_bug.cgi?i=
d=3D1989591.=0A=
=0A=
=0A=
Best regards,=0A=
Deren Teo=

