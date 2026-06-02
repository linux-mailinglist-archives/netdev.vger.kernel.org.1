Return-Path: <netdev+bounces-294317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X3pGFCkVH2rsfAAAu9opvQ
	(envelope-from <netdev+bounces-294317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 19:38:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB471630C5C
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 19:38:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=onsemi.com header.s=mimecast20250127 header.b=NWVYn8MS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294317-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294317-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=onsemi.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A75B302F4CE
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 17:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F803FB077;
	Tue,  2 Jun 2026 17:36:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.151.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDDA360751
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 17:36:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780421793; cv=none; b=luYGwXltCbdnHmOpCwwwKUX9Do6dUSzkY41mQr8V2rlra9lu2bXt4ZueEEhmNOTNv8jmnesymvn/fnKfBrvXVpMK8smKUECKLi6w0ARjCsqFqQ59CP4EtCsULXyPo42fDz5nwXPnkHRPHjBDdxTkCXJXqhr4bjgrbT40uU9UcUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780421793; c=relaxed/simple;
	bh=kU44ua9zCp8ll1fLBy15XMwJwYdnGmtNusO0OU6ty+U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=FGNFt5t4wv40wLYE4dijPXQ9RD+4gh9yM1FBGdfhisFGqCARRCeq+iOHm7z2Lxj65Dp14eqQhswO8Bnw6abQ5sTIkzeft+dHf+3Zf4ZlvvAwnzyO641EZ8wf8yz1UzP9D4sxtjrE4MmOc0R8S0mysl6FVxR/fAPuuhBArQah+0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=NWVYn8MS; arc=none smtp.client-ip=170.10.151.120
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1780421785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zk5vOx05IzPipW4sWH/3wDxd/uENlbEQbtAA/VkpEpM=;
	b=NWVYn8MSJrsIj/1I6xoNLEE/YJ7C66v33LJ8tG8fRqqwzuFiKqxDCBAwX9WxUdUmmMX69C
	iK3WQpw/hBjPNoTbtX+REn0Gi8w2xTVxwCgoDIcwjGMnnz3Xv1ohR/r6oJKKCAU6buJZpS
	HNFTuho0FihSY7t2q3WycpkoR/fWZilKjZz0TGgNGNLj5IMmrGX1gf4L4jfHa9AHI7PTpn
	gWBC+seAE2JAaF7ztS3iln1u+xBOqoUqsMtuGyqCQjdOJfN+sDP5wZqOpDJz4RQAj4mU+o
	x1y0LQbtZQl5vZkmyEshNGhwAUPs8nHmGNHPBZCsmbqqb5wZ3Mf3OUKOmnmB5g==
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013011.outbound.protection.outlook.com
 [40.93.196.11]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 usb-mta-61-Uef7MDb4OBup4M0QNzpsPA-1; Tue, 02 Jun 2026 10:36:21 -0700
X-MC-Unique: Uef7MDb4OBup4M0QNzpsPA-1
X-Mimecast-MFC-AGG-ID: Uef7MDb4OBup4M0QNzpsPA_1780421779
Received: from CY8PR02MB9249.namprd02.prod.outlook.com (2603:10b6:930:9c::17)
 by SJ0PR02MB7549.namprd02.prod.outlook.com (2603:10b6:a03:329::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 17:36:17 +0000
Received: from CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda]) by CY8PR02MB9249.namprd02.prod.outlook.com
 ([fe80::e437:4ba8:6506:4cda%3]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 17:36:17 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: Conor Dooley <conor@kernel.org>
CC: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Piergiorgio Beruto
	<Pier.Beruto@onsemi.com>, Andrew Lunn <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH net v3 2/2] dt-bindings: net: updated interrupt type to be
 active low, level triggered
Thread-Topic: [PATCH net v3 2/2] dt-bindings: net: updated interrupt type to
 be active low, level triggered
Thread-Index: AQHc8eDLvWzkHnbXI0KmrY/VvMfuDrYrecyAgAALlpA=
Date: Tue, 2 Jun 2026 17:36:16 +0000
Message-ID: <CY8PR02MB92493D2E5491AAE5416C05A283122@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <20260601-level-trigger-v3-0-da73e7010532@onsemi.com>
 <20260601-level-trigger-v3-2-da73e7010532@onsemi.com>
 <20260602-rebel-snide-5036c97e410d@spud>
In-Reply-To: <20260602-rebel-snide-5036c97e410d@spud>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR02MB9249:EE_|SJ0PR02MB7549:EE_
x-ms-office365-filtering-correlation-id: 5a2e7b49-d4d4-4023-a2f6-08dec0cd7368
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|56012099006|4143699003|11063799006|18002099003|22082099003|6133799003
x-microsoft-antispam-message-info: 2ZsOy/u17ptcB/hnoWJ821mU5G8G51N/a+5EL9kuyuGN+5NtwaGQ/AnQdvuRgQnvcrhXJarXp4iLKCqDA58uEC/SRw14Qs/CycZvIbSlL6n9y54Cri+hINvj7nU56hi7DMOM7MRq6dc7ILR3Lc9EFj0RO7u3BfJntUk7hygS9PdRulr1pjVJocFHW0rqg0Gf3GLV5q3s4qIRkN8HnatQFzvByhDtDLC3r4r+CXI/dB0Ui/3NoUurIOZ5H1rKCjds2T2sZpmn9+gHCuW4pDmh9glMs6JnwliDfXdFi8AVhqlZiVSsyTLAEZ0qCYh5N3dwKoeHE+7nTHhzYfp3kALFhfVAUF+7L1JcgItk84Wsl9Wmk7gpT7BYBSAcg1SgJooEhkLwmXvmKomJhtr/ElwHgegMMIJv+lB7CPjKieIV0t8jBpX09l/jiSrgL8W552AbmYSz7KRS8WOXoAjBjoBYy6oU7vzG1q7Tp1FYW7DH6/V2AAUh+C0uIazu97ZKxJqB/T9D0hwxQxCRnGxebwJhPSYOkUt/CWsoNV84giaYZZmTm2LQOxQzdrU2YcjR3q5EzCEppZD41Xlg4NKARoY4FlYkSzftD2aq0a9Icn5Y6ZHQHzCVGQhvlx7jx4dZR+eeTdafKpHJzceFkwItlIOLOJ29OrVtnWta00OM0MjKBPy+Opo78GZ1mPo1XFrRBMSnKfpCfnCFLMgC8zyVToREfhjNaMcAyygKApmtxqcPq50gA1uguxH9H9Mopbl2bS+L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR02MB9249.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZuBFIxFqQZjKWclrSozTrVNCtsTSjVugLEw0wVxCmwMG13VE2SBUAAvTq1kG?=
 =?us-ascii?Q?hRCBAmCVDn/AbrBIp+Y3lbkWGF8tav+1S5t+AkhFJrX80Ba0kVmtwowYAhf9?=
 =?us-ascii?Q?zVg+jpSNLxp2Eiv7bQGBqkW28uUcC3f9/ZTJR6JrRMm42JrM/XH7yaQb9ZkP?=
 =?us-ascii?Q?UzQsLcVXWTyfgQuBykdjlsaPgCcG1d+/fEBpZWLErR8s5P/cRwJsLi9ck6Ho?=
 =?us-ascii?Q?8gLFtdwKF4/Qv6ln0EoZcXU3h7VWRJasTw4hXACIe4o0v4YS8yz5qyMC6KT4?=
 =?us-ascii?Q?Xrq5hu+Akoc1YKfOtkAw0Ol0++vVCOi+hsXYaQ/zF1zV1HMQhnJZaX09pDwK?=
 =?us-ascii?Q?yRF5XpRRJKPRX0EXRA8RqNZyKfWVmBteNAQKR9xFsshcuoM47S4zHbQkARKT?=
 =?us-ascii?Q?7kcN9JFiGF+LalMcmPSVjlzoD22FF+bpxAYS7J9sjmGVcnS2wFf0aqah031i?=
 =?us-ascii?Q?u7PC+YzxQcwV+TxF4hieWaK93GEevpdxH9jzGMjB6NX+IS5KJjYP9ZMlnW0M?=
 =?us-ascii?Q?/pbJ8g92bvykbZnVnn7qJVHHOSnZnusSIF/5JwIMxXzANqiWDPodAnQ18l+A?=
 =?us-ascii?Q?cd8OT8wI+vzJcKFuBlFPpc/9PczjtgULfnkxvcgGO4lDq6B/YXMp8je4iR58?=
 =?us-ascii?Q?TPBhHYPlo83IY9BMtP/kmwd956qYzZvOmUzKk+NQy1u3s9W0l0OFPBpshYHl?=
 =?us-ascii?Q?MuNBFZdkX6h/Tfh4FzP6Y/tq6PPJc17+qI529KSfgUEe3nZXos0l7Uk3RkUs?=
 =?us-ascii?Q?kHMGF4dj/zflYjV6llha0QxEo2ATSHFHb8G11qg4KD+Ax17pt6ysAIDKyrGc?=
 =?us-ascii?Q?f+U2hOfUee1aYcQ4WiHHBUy16mMSZkRdumqPf1ry9XFZ9+yUYqP9TkIYeW1z?=
 =?us-ascii?Q?NHHbzI5DTrqHXhRLc2CvBeqZpBeLbUE4YMNmdQa8+38u8aQyIXT+Bv+h1fNV?=
 =?us-ascii?Q?WR3bE22jV/nUz0s3oELB4mRNI8MqRzXS+Pz76pdB73c4006KJSOxSnOyi7Vv?=
 =?us-ascii?Q?UHEnjHPhXBgcyM3RKvvwpoV0Zf6sGABd6KPbeI91cppGPcEEV+s0CnrQgMND?=
 =?us-ascii?Q?OP/zMyI0nI1cBNfaYNew/nYmYJEspuJClO3/FWoAWdaDp/C3yNMDQRO6e30M?=
 =?us-ascii?Q?LUzibjYZDh0MGZicURCMY2ExnP9a1CNM5+ByVK/V36Ol/PjX12C+1zzicr1x?=
 =?us-ascii?Q?OMoy8g2TP506Ne1me/OoXJSS3NfOjccRPYEus9lJzEfSUVbxIR9yfp/3WAwu?=
 =?us-ascii?Q?yChlWwo+IKyVlag2p7LUMmHBU0S4nZjj3CWuUrRyqK09WiN4mJQJ859F+1Wu?=
 =?us-ascii?Q?GLZtIvDwBPXk8SJthdKcd8necznKMiDI40Rza6EwJcpz867LdnFGJivnSBLV?=
 =?us-ascii?Q?M228zxRz/+EH7K68hsjJ+VGFpYdLjpqafVCQKWYu6wQS8l+E89DYY27Pz1Uv?=
 =?us-ascii?Q?sXcaKyh9XNawJf93lQRWwa3ZOYEmngureplQv9UIhqc2iOwDaBuCQfCJsbVY?=
 =?us-ascii?Q?lhrl/RH0cyeJnvIc/BDgqeJ0rTNYhUYA4xgnnbtMrWYiliW4tKOVtDW8FRQw?=
 =?us-ascii?Q?v1GUSZrZdCXRM+VdeKQxvNHb2nAx2hoU5OCgxbsOTYyebR3Dz9L3awudGhk+?=
 =?us-ascii?Q?14uoR3yvioZsEPpHzLN5TU2quAKUzyX7qNpwqR9zQEWfBkvhKBYT9hgfZEMi?=
 =?us-ascii?Q?W/etNrYmAQjW+q+Hx/dRSAFg20DO2gX2Jm79sgnwjINFHzo6lkLBlUkQ/IdM?=
 =?us-ascii?Q?jeR7Sif4wdCQI8Pv+TIEPsTngCfZuQM=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sQNQtz0z65nceJbO3UC11/CeYRaMzNsZeRKP80QSgGNbAD5sXejyudoWXiEQXiz2bpMrs81q0APuSE5GjQIZncjCuj4mKRLynNJgVdilCapa3qsNvLZjIu0qounr6nrG4JKHQL5aG+E4ZUAMUR+2vloeW4pqPYOaS0XZuC1Qx7Idc+ynmL5xdqzhn9TifZBMj8vEdnypWLFyILkshYQmoYRPq/aX25HtJwjVZ5FyfW/qdNVkllbmTjJsMn/XvJs07JXacdi030ABflbvL6gf1M1y4Z5oBtyBTr/ig6YN8EEgVVpf8mmYgYy0WRn7cQf/YFcfOFh9YqsBSea/h8z7VQ==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR02MB9249.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2e7b49-d4d4-4023-a2f6-08dec0cd7368
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 17:36:16.9912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYj1NVfNQttkzEtDKWXF449YBK8Sjs51YKc6G5C+Mdx054ywjHbaG/noPx2B/Il+fHNuD7Nx1nfxA9QT4MDuxMyFzLnFach3vaHMsHpXZCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7549
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: axFMDYWIiWq1oPqvTX7p4H_Cm6BDH6q6YeO9MBVQCf0_1780421779
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[onsemi.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[onsemi.com:s=mimecast20250127];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294317-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:conor@kernel.org,m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:conor.dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[onsemi.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Selvamani.Rajagopal@onsemi.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[CY8PR02MB9249.namprd02.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,onsemi.com:dkim,onsemi.com:from_mime,onsemi.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB471630C5C



> -----Original Message-----
> Subject: Re: [PATCH net v3 2/2] dt-bindings: net: updated interrupt type =
to be active low,
> level triggered
>=20
> > According to OPEN Alliance 10BASE-T1x MACPHY Serial Interface (TC6)
> > specification, interrupt type is active low, level triggered interrupt.
>=20
> Have you checked the documentation for this device etc to make sure that
> the device actually follows the spec?
> Maybe Parthiban can confirm this for us?

Though I coordinated with Parthiban well ahead about this change, He is the=
 one who could confirm.=20

To answer your question, I looked at the datasheet. In one occasion, it men=
tions "once RESET_N is deasserted, device asserts IRQ_N.
When software clears RESETC bit of OA_STATUS0, device deasserts IRQ_N. This=
 gives me an indication that the interrupt is level triggered.

From our side, I checked with our engineer, who is part of the team that pu=
t together the specification, Pier, copied in this email, confirmed that it=
 is level triggered.

>=20
> Cheers,
> Conor.
>=20
> >
> > Fixes: ac49b950bea9 ("dt-bindings: net: add Microchip's LAN865X 10BASE-=
T1S
> MACPHY")
> > Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> > ---
> >  Documentation/devicetree/bindings/net/microchip,lan8650.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/microchip,lan8650.ya=
ml
> b/Documentation/devicetree/bindings/net/microchip,lan8650.yaml
> > index 61e11d4a07c4..766ff58147ae 100644
> > --- a/Documentation/devicetree/bindings/net/microchip,lan8650.yaml
> > +++ b/Documentation/devicetree/bindings/net/microchip,lan8650.yaml
> > @@ -67,7 +67,7 @@ examples:
> >          pinctrl-names =3D "default";
> >          pinctrl-0 =3D <&eth0_pins>;
> >          interrupt-parent =3D <&gpio>;
> > -        interrupts =3D <6 IRQ_TYPE_EDGE_FALLING>;
> > +        interrupts =3D <6 IRQ_TYPE_LEVEL_LOW>;
> >          local-mac-address =3D [04 05 06 01 02 03];
> >          spi-max-frequency =3D <15000000>;
> >        };
> >
> > --
> > 2.43.0
> >
> >


