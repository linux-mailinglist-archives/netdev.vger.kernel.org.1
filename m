Return-Path: <netdev+bounces-304466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SU1VMQqCR2pMZwAAu9opvQ
	(envelope-from <netdev+bounces-304466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 11:34:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B69CB700AF5
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 11:34:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=selector1 header.b="pqr/k9oq";
	dmarc=pass (policy=reject) header.from=microchip.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304466-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304466-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C47E1305AAD6
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 09:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E38E3B14A5;
	Fri,  3 Jul 2026 09:25:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011053.outbound.protection.outlook.com [40.93.194.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066CE37DE98;
	Fri,  3 Jul 2026 09:25:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070720; cv=fail; b=WQYW5LhVWgSpYcjRO38Vt62iup3o6DpgW4qnqLUCS2oO+BSORWHfBBMUeRehe4vST9SewXSfkhhroXMK63zDKMf5e01m9cDM46hVcm+G5D+8nDgEaVPoNVby9fxHcjS08JDPpVMDtJ79nxADDE3B8H817Poz1L2CZmqt9tK18iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070720; c=relaxed/simple;
	bh=UgLhq7k12hMRKps5npOFotutqPfT/sVRkZXcjJgMs0M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lJIL/wf6G6Q3s/KlGcqL77cCG+WchiKgSBHrWIBZhSMK7iRPY8tlQw6uJvL1RO+KITA9yzcIi65+suQvG5j1Qn1UD8qiJT9eJI14V//KrO5LB8L9kHpG3K9KXymcOINeHv0kDbzqF4mIO4DgVuU/f6FYqH5yj6lh/U7FgCxzsh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pqr/k9oq; arc=fail smtp.client-ip=40.93.194.53
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0dHSOldu2TPzU+GxFbhcSNFpz2EeGAE+gEU1eDnndwi3tsfxkjjiSqWHPqDO4Q5fnnT59QBRcG3cBf+t5+ZNP/MkrtXzYjrbiLrBNABdKUkVQ2LYZwkm0W1pExPMUzn4UjlSbFWSeznP3mKbNZWMk/vkhq8UXRqNeC2ZjgjxxbH862qkxJHmsBzTQBPXU8VY2JakfuB8U4nhKBroL1gy2Nrj3FSgNNkxDBGJeCqDMJh/QpTIrYacN3o4rDB/StGuu9lN+JMOALsQ53mMWvsGTNsIkYQvhk8I+MBeS7khs42jjJYsBh7CUU5F0A5RYe5Om8tTSysd85Jii13Eq7Ggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgLhq7k12hMRKps5npOFotutqPfT/sVRkZXcjJgMs0M=;
 b=jdFW7rDh/9Yjm4qPpzFn0Dtpo/6jLTDUrnOhohKffd/eD5s0ODkLTDoA9GwlLev0uamEjx7/fOLaXj0sdTenIoDeJVMntGqYBG+zE6/eDV0fMrnT9S9v+1iGbIyGhYDZMkg85yRvDDlob9MwWTYT/NO5PJ8Cvux1Lxrgj6bFdXGf10FU3eTWTV0wC4qYFiysu8w0mts27tsBWv8Facd8do026LZ75tL72BHwFD01/UHOe1ZVomrX3Dj63Z0TbXHvpiRt7ckLJ1trevb4FqhPuPocjjzRyZyrepq4hQ0JiM4Ci4RgTm0qgi8Cgeod/2ma2spQK0kU765HgDFheghD+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgLhq7k12hMRKps5npOFotutqPfT/sVRkZXcjJgMs0M=;
 b=pqr/k9oqLq7EDzIO7ZIkbgHklkfETuJ6lHttt/Jirn5kUQlLp8UG0+Tb5N1RIPCp9LHnnalLIfjmwXGht10+YjG2U+wSIivSglSDFrg0bj566J7ZG6xEfq8LzAGCtHm9J/umSAO3s138ZvP70bwGp2j9Q+DuYGmtUjQmySIPGSY5BjW0pn/rhqHsCnXwqlipKXXXlFVWP4rKk9U2WyR31YKNOD1G9htKH47NDIpfBpnFnYOuL4cRXjFNXidlWz6ssDQ5TwGtmrUJQV2fHX5h/ecHd/kC5yUpWtcUqMI8m9GYGoGrZB42gz96Nhy6lMmxvnrcHSwlns4H1WB4qcw10w==
Received: from DSWPR11MB9715.namprd11.prod.outlook.com (2603:10b6:8:355::17)
 by BL1PR11MB6049.namprd11.prod.outlook.com (2603:10b6:208:391::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 09:25:16 +0000
Received: from DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139]) by DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139%6]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 09:25:16 +0000
From: <Thangaraj.S@microchip.com>
To: <nb@tipi-net.de>, <enrico.pozzobon@dissecto.com>
CC: <UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Woojung.Huh@microchip.com>, <netdev@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v2] net: usb: lan78xx: disable VLAN filter in
 promiscuous mode
Thread-Topic: [PATCH net v2] net: usb: lan78xx: disable VLAN filter in
 promiscuous mode
Thread-Index: AQHdCVrhM8TwHwQcjUewNeORXPxyHLZaG0KAgAFrxVA=
Date: Fri, 3 Jul 2026 09:25:15 +0000
Message-ID:
 <DSWPR11MB971547088066C2CA91638F3BECF42@DSWPR11MB9715.namprd11.prod.outlook.com>
References: <20260701-lan78xx-vlan-promisc-v2-1-fe3b18066728@dissecto.com>
 <aef78533a81c88a362885c24928a7c60@tipi-net.de>
In-Reply-To: <aef78533a81c88a362885c24928a7c60@tipi-net.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSWPR11MB9715:EE_|BL1PR11MB6049:EE_
x-ms-office365-filtering-correlation-id: fcf23763-a3a3-4954-7152-08ded8e4fe12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|38070700021|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 fXz5RNaSwEXkdOHuYAN08NFx5tOwAuPGoTKxXvjkx75XHlWkAS4n7EJ/P7Sq/0Th1bN3b2OCcw/YAHRLJfesVnkeyEqjqm0WsLVcrIu0jY08cXaaP4g+TpFRvO5PcDvNrOmQtItEwCha40NfGTEXXtxRqqZ5JzqeVjlabx8IHyEC2zQotlyGSqKIQs6s+JacalHq/VCt2biOdEOf24TG/39NMNyXJBcBfPdfgYGNz/DwwETumVaLVF9wr5Dja8GuT/2PdxTe+vNcSlMx48zwtatoPGsBTSWwJZsyuyIrgk5MeA/9+T5XgmIacCxmOg4laU/pin2TBXw2CTeYROB0rscHUbYrnHvMw1XvcXP+A3p3s+bOxzOt+BUwamIXLMm6VwL2fLM5fJ5siXRST2a3zmm0tgKKHD7+KJvCh8j/GLTRL1aoRtLZTj0WB4jXM7/RV6IXT1BASudFYDtA0jX4YhgqDV9I8HCeuJjUdJ0baszFWybNk0GK898xnJvaTogyu3ljmbqwSYQtufTEiVV5DuP7PvPf4Q8gtHDyZDYU9dVfUuv1/GZlMfZhB3NenJFUexMVPBK83Jhac6SJEC51U9TmmVSnClIG0Os8yTfku6m2223XY2YQ/Qu9gvQ7eDOAzq8qHGzZyiQI1ePPqaBt26V8tOavYK6OPcjAoiEOxLEWDqYUfJ59VFzaSH/HGdXap/BhraCQoP50wox9HlEHBxnxVZnqCsUWGnpqbhq5CPQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSWPR11MB9715.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(38070700021)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uuc1JMPcHfXhrl2BUNogFzpD7SpUJDVmkq+rOqwTfXYcKf0BAt713MZbEPDY?=
 =?us-ascii?Q?AzGuo2DRur2zD84ckXNYTisiCItyuuBkY0/aTICAn5tBbYfG7ms4tzFB13MU?=
 =?us-ascii?Q?mU3XHhsqIrilWh7Em04Q78ci1KVX1oVleS98B8YEzesSps9pHDSCMEjvy5TQ?=
 =?us-ascii?Q?AyWIW+ry09KwWvn32ntB4IYo0vLzry4rWEoDfy2cCxEmbyDFeKDydddFClEg?=
 =?us-ascii?Q?MQRAJESmJTDE0QY+u8NLTJZ7n1x+ap5fGPVrVQHpEf8irNQWnJeabt1OaPND?=
 =?us-ascii?Q?mo3oB9gLTWQgmsc8Ojt4vqf5Y3N1H1vw7BWCteAqZ2vxAAGn2RlQgJCM00xw?=
 =?us-ascii?Q?j0NQ6RT8lG3KPnHXBXimIvkWwS86bke/bVKbjOkp1sXuASyguOmWV+AXEdOw?=
 =?us-ascii?Q?fLw0HFAeoY1QCMsoc4pERYdN7jJfYikvvQ3oo+c6uEOB0iYghYaPJSym+Pgy?=
 =?us-ascii?Q?DMBQofyCfU121ddz8c7S+eLGCkG0tM/y1XTh1Dh68tjGLTxZ9RhoDyJbOat3?=
 =?us-ascii?Q?YL6uC1y0NLdokOFIBos508qGQPqhwwYjei8PjufFyzW4RJ0wYesrC7PHEpml?=
 =?us-ascii?Q?Xj7qpgE1MK66rw66+ClQFwYS69NRAj1ysfFTbMHHperGHumupOTzc/bbmTsJ?=
 =?us-ascii?Q?gzsutN0d794cyT3IWqUnb2Ah1c6D+j7all4/Kdp/op7Cy+vu4cyKc8NNv98n?=
 =?us-ascii?Q?w0k+9kt+YiNwUQ2WIJnFnUwkdUGEnOVTXjloBwquNFklerup87bKqdvUrWXc?=
 =?us-ascii?Q?S9IrZoIgoSSXntw82FFNGM1j+3/eg/do4FyvHpT/i1t2GdB+E2QxqcbIEKdK?=
 =?us-ascii?Q?81dmzLxju5i+AcZOXTNLPWMjQMSNVQ/QuhdAAi/R0Jy9Bd0jczbHs6X+hpfT?=
 =?us-ascii?Q?TD2L3rBJt1PNlWKrNiMJPfFpslov9389KD1OqaZG42hJWezA3rxhpDb6p5ZI?=
 =?us-ascii?Q?ZGL5ex5/MGUasd188DLcSK0p91GOtVkmgwpiC8cWiz9XUpXeVS0ApkKDlpkb?=
 =?us-ascii?Q?Tay5AcwHmL5/Q0iHwXQtpExIJFkDp0wkV9Tm/qFePte79CC8O0i3EWgVqdvs?=
 =?us-ascii?Q?z2JO445RQIbqa49iQIW0OSINDUXTxDAcY6GgchWefpqzJT9sKmIs+aY0K5iF?=
 =?us-ascii?Q?L6G0UfyHxWOy6L4ug/pHdTewVr5/AWbPgVIYDBpY2huJ4wI4+Eo1o+QYfu53?=
 =?us-ascii?Q?5J6lUWm/7Uujg7YcJOYL+0Kwqjf9rn1m8u2BpQsTWUl7lVeaU8cAwnF1v49m?=
 =?us-ascii?Q?QkButYQ3Yfb12oNEPBr52vMJGARiK5tV6d0YiCWGKiXBNmD6irUO9an6yy0U?=
 =?us-ascii?Q?9bcKsAmJbR/PNSekgZgANfCd1YWPXh/o5wzTldpqhugLT3slt/koF4bVcX8U?=
 =?us-ascii?Q?lOHOPdgOS5xUd4OL60NuAa32fLAt0mL4dBWfpVW5S9KLGP7S3rsos2aLDkoW?=
 =?us-ascii?Q?50B8rw6nEHM3eU1TcvOXjgt/VpjtciZHhINUXi2LbN3dkJdtjB8nSuCXqQ7V?=
 =?us-ascii?Q?vtHnVwoAsMyhiWzZOG8xkdR+6dJ6qflxdeYI71tOh2xlbGRU9jCPvBC07q6T?=
 =?us-ascii?Q?l/1F/pd/h2cH5q3DMA0rSU5fL/J2zig8a5GKOswkPqI+TPev5MV4ywSNHyR4?=
 =?us-ascii?Q?XdL4jIf/K+x2CiSx4wWdGxLrcw75sMTIIwQhPvUrnGxDqXHUfF1rLzQNne0P?=
 =?us-ascii?Q?buN5MiynuVZQyYITKLP94Yc8fJrAw+30Gkc4AgVWJ/Pph68QdeCfQIMGv0pQ?=
 =?us-ascii?Q?zsSpVOlClA=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DSWPR11MB9715.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf23763-a3a3-4954-7152-08ded8e4fe12
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 09:25:15.9914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R1FiVT7K9/kIhkJCJ889e3nXcUtELxellSjkGLN1AfOzVYJJg/QxYWhE8yKi8fii6etAy4+rHfywbTunDy7FgqAUJ7r4EtVn7TDHZbqlRhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6049
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304466-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Thangaraj.S@microchip.com,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[Thangaraj.S@microchip.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:enrico.pozzobon@dissecto.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Woojung.Huh@microchip.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,microchip.com:from_mime,microchip.com:dkim,tipi-net.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,DSWPR11MB9715.namprd11.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B69CB700AF5

Hi Nicolai,

> AFAIU the findings from Sashiko [1] on v1 are either false positives or p=
re-
> existing issues unrelated to this change, so LGTM.
>=20
> @Thangaraj / maintainers:
> The mails to Rengarajan are bouncing since a few series - does the
> MAINTAINERS entry need an update?
>=20
[Thangaraj Samynathan] Yes, Rengarajan has left Microchip. His name needs
to be removed from maintainer.=20
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
>=20
Thanks,
Thangaraj Samynathan - I53494

