Return-Path: <netdev+bounces-276282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAdSNAXl1Wm2+wcAu9opvQ
	(envelope-from <netdev+bounces-276282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 07:17:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8AE3B7216
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 07:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30C9B3018294
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 05:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B44355F47;
	Wed,  8 Apr 2026 05:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hhdo7sAz"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013024.outbound.protection.outlook.com [52.101.72.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE00F3502A9;
	Wed,  8 Apr 2026 05:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775625461; cv=fail; b=B+isn535RD/9stPjerHvsb9GMqlNT7u5f7v3qYQBwkIF5gfnvAW9TOpqp0vjBMNBP+g1v3tBQvgRLze3nex/Dt0KJjOcf5M970aI3AXIsR8Y1n3lzN6sgnkyTXUuEkoip7hRifEjIRmd1ApZ4bcZmjjo3AGBYDT4p0JLVeT4grw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775625461; c=relaxed/simple;
	bh=IjYTjTVXjPgD3Kaz4gwdqdntQuNHrIGXaj8ykDT4hjg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=abVRgW54ZFRlkJdCr3V61yt2w4QRUJAwJYFAtrhU+NC8Z8ACB+tA+m3UEm03JXyQBpIsCPttK8oboIBt7VRliolTkYMmolAT4IHizN/u4B2WjBhE8hKxD1Tldjs5MaHHxvDqPGHxHaKzMbrL6QIJeG6amr3i6L3XkJ1ah/M+/gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hhdo7sAz; arc=fail smtp.client-ip=52.101.72.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCw1PmIEB8sRtaM0fvGUh7YNc5fTnErAtLf56b8X3t+4h2/NwzmHj7K4rczhJS6fOf5ZHplXbgL3nDOb8WTs7Ro5UeZVTDv/8hWvuU1GaDg3d9vnIj9oVtc7hX9mpOEHxReO1GAcNbhENOwfUzyNXDbv5Y5+uF+wqTCuiVyyvDTqrQDosl5grZhDNB30tAJ5pW24fySvvkFhKccw59DuAGbzzqOW0jFDSZT8e4RPD+RjJPBNB9gFd30eaylf1Ons6uCGVP16HUMd+T0+/pmt6/7amKH6w471PpvWQY6lesvZYP+6XT29ZqwNUAoM81xdVhXsV+Ckt4JJOL+SngmbEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76T2GlnkAJ6UVdITgUauzWRuMlHP5lkfIWNovJKp8IE=;
 b=NLHABAwwDlrrWdbdAMmpnI8qVUj5WmIQo1pAHV/0wPO4blrY3eYkGF2k2V3ywT+CfIOTo01tDs+3rX9zRYlOcihYUHwtsSwx6BH2ii4ObYj1mT4WTcyfjUKmAlLqV/A1TxmjQH3p2/hKGxaQ3k9aocddN1RUHDLdyDpG66MoCEp37uVUURdEInong/mLMws4sVPXmr1UHfx+WKdcSs8hBzF2ewr7nGh350ApCDmOIGYVJpltlJ0FAhBqhNxaUf9FH8YlVo4oqIdYHtMLO3kdh01RVwpqWyuqUWvY7z2pMLXWR9Ao5RKodWykuob3BQ7ImybO32NTY6rFho1kDc8pLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76T2GlnkAJ6UVdITgUauzWRuMlHP5lkfIWNovJKp8IE=;
 b=hhdo7sAzgh6rPXkP4eFXnkRJ6AIU2LEsNatqHuHiJzN/ld32w6lOJ6qMA7+2WqSzzpTfBTJjqGwDD9bpy5xfPHTSZ+8cEiC8diJ5So4OsUHcRK+QcR9jtiUkF9ZeLLUb1Dcs3M6g0AftbeZMyJW2oWvaeoTV12gl98gqMVgHoryPOzAJnjTJlzya3hfuHpYYIhVh8KWV7/vEWhdDw2UY221FDtSZGTh+F1cdduUGSsUidjGjWn/mtVFHBTEMVQsIj98ZJihsGJmUPmOM64bkmOp1dAiBdvbxdCHzDtK/ymRbEpRdhl4eOURKVonkM0ju2JkXWqD9aTKNcSjBExV+fA==
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by DU2PR04MB8759.eurprd04.prod.outlook.com (2603:10a6:10:2e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 05:17:36 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 05:17:36 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Zefir Kurtisi <zefir.kurtisi@westermo.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH v2 net 5/6] net: enetc: pad short frames in software
Thread-Topic: [PATCH v2 net 5/6] net: enetc: pad short frames in software
Thread-Index: AQHcxgXGQ5BZ4CSSRka5nShFLNvpkrXUoceg
Date: Wed, 8 Apr 2026 05:17:36 +0000
Message-ID:
 <AM8PR04MB728480C9569F65217A5DC849885BA@AM8PR04MB7284.eurprd04.prod.outlook.com>
References: <20260406204122.167237-1-vladimir.oltean@nxp.com>
 <20260406204122.167237-6-vladimir.oltean@nxp.com>
In-Reply-To: <20260406204122.167237-6-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR04MB7284:EE_|DU2PR04MB8759:EE_
x-ms-office365-filtering-correlation-id: f8e53383-0905-4189-fd31-08de952e2594
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 bdlS9ICPKd/exdxrFaICVHflwxWJvDUrUm4hjHSQLGeTh7GYC/jiBWvrflkpKdX1TNE328Fr2jhG9u/m5hUW6NytiaOy72P0mi5gZm1+MPrNQ1Y0xaPXb0ePZCHRqjcSXOUgs0ynbX3ZgVH2x4yHgMEwOAROOFuVUjiejhC3BSS4LXw2WLICRt5k6fcXj0m+IFsDGu/825gmOwmEhH1x7YRuh08PfG7c+Etk8Kg8i/+07qSA+m0SYg+ltw12kNpNe8Iqdi2EzvKRvH0ejQAHoxSopFPRwq+VMlcgemdLUVMQQLyih4+qseumXP42bCKdVRXLT6STwvk1PQRl4ivBbkyZI2KYQFpOxUwikAoCsSFeetRLePlyOXwi40KuTCVYvOV7Lk0faDs1Fchpd+7suZrhvUeX05qXCa079brszw1wEHiJWbhEAsUTjxKWm6dS1czxc/ZdvpKh34vaBad3YQT+PmKv7SPfmmBraJrgQNz/MjTgLoR4wSUDi2u8/KWO0+HgXsFqC/eouA/cdhb1IcfV6gd2bVX1dD0oqlQR9rlSsdbT3X2lgZAKwaCTxjnJs5Gy7WD+rgXcQ8m8xe5zkyDkYeGFqKDonBgyWl3JotUI8LqPuDqqcFHTgrVvD1oXfvxH3v8OKf/YTyreYlVi8eXvg50WJwiwKfObTD4QHPovgdZCutYUHgw6p7/IkOy7E04huX6jcPCmvaAsNSJpvwjpidazXuIVY7AiXhS0YudJHmG48LjCrPQ6qWoCD8bx
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aylf9i3NtWyk0UzjPmCylbEnkxnAK4Rb2k0tqS2n0/t5IQhC/KcbVPXRKu2H?=
 =?us-ascii?Q?1HsOM9QzX5NPDMqcNjd4pooOSPfacjUT+bQpLs3Ux1diVl3JFbdUtF0MWpRU?=
 =?us-ascii?Q?OmhKH0HF1re80wAKY8aNUBtWEC0R6DYh0IHj/jWhLEJS29S8Qrik6SzmkkJb?=
 =?us-ascii?Q?DIBXznNrU5bsxEoiG9EJidsH37vkwyHwmmuvs8nIA8RErx1OSsHU1kkrxLRl?=
 =?us-ascii?Q?ujb+P3ySVzfE5UQ7PjRq3UtG3NUG3i4EbivQe/I/LEs43LQ+Yp8wVzgooSE7?=
 =?us-ascii?Q?fPVzmuNFtHfUVl+F9s4czzoP2ECV7iNOp3ph0uxLJzu7OCEr5FywIczUJl1Q?=
 =?us-ascii?Q?S4dWD2ENAUa8G7vR2m4Uf4J6poGCYmdqa8iAAIz2bY658YlHGXtRx9lH5FcT?=
 =?us-ascii?Q?WfGjx51EfMiEbrOoLpZvxP9/RnZ/9Iy6gUf3rtYi52FejuHiuckQl9ZugrhX?=
 =?us-ascii?Q?goAaTQ585dSatrt8W6+B/csA59pzPHYnhqObYEx6AEBeANsQgQ8AEzAUD+Hl?=
 =?us-ascii?Q?b70Dfn4HVA7gGsB2WOfdsCTJM3SgUB+EbA8T58kGWGO1OGparJAXx+G5OHyq?=
 =?us-ascii?Q?bTjJuBtyFhsSbNnZLTs6QHgYMi/n9e5XUxTk+6WG0sZunLZ7+FshpAgJjB8c?=
 =?us-ascii?Q?cQNYrcgWnwZ+wMC93gABZGAmKaDSzzWqdksfd+0jHk6qOG3iKmu5b1SSSG/b?=
 =?us-ascii?Q?d63ZQa00wNITN5R3sULV6EnQ2mHWcgKFYZcKLCMux1BYrQLR6lO1LKFx0kAu?=
 =?us-ascii?Q?2cX15P87/JHqNudXrQQ9iP8bQUy/7SXsDXIJlgiNe0ceuzIadHbSmwuEHqck?=
 =?us-ascii?Q?M6JTh/UG7KB3mGGTYvXI4moRTCIqf6veSgsofCs7kmCyMxprvEEZppHmFvo0?=
 =?us-ascii?Q?K8HYch6U8KQtITOsx/F1OQ6kB4utHJsbyJGQfOmyCk2bEfNObD0PujHhZFEq?=
 =?us-ascii?Q?SKai0QaZl4ixxXIUb5R65T7DFnVdY1mm2qtRUPSqlhM34I1BWKiCBulmL3l0?=
 =?us-ascii?Q?9hCY8AEFeS3A6W2LeHKBfcM93TuT4huIIxgqkAR/xawhrM2OPnE7dkCPr1sh?=
 =?us-ascii?Q?LTVQHVlKQQPeTMZGxuxYNPwtXQot7uTp7K5DQhtkDdylBnbIHWrhc2u9yUWy?=
 =?us-ascii?Q?PQaY7QNNGY8IBk7ZdJ2b9WhTyq+Lq7eLpOKNrJXZ0GqA5IJD9SHNV/5RPmb8?=
 =?us-ascii?Q?oYAHcUwbUh+yuhUb6JAbsfhI4RjfFxWq0o+QDnjtEmmL+8cUOOs0hF7/OqlW?=
 =?us-ascii?Q?c6T5veGruh8WMwHbkV8oo6jmx65tHXWW2EYlRCJj9PVRKAK1RtEZVb35FfMM?=
 =?us-ascii?Q?lwUDto8K9OCQfQYEBok/g/5OKvArbSquOi0G7Uh0cfk+dUf8p3p1VAvA+ch7?=
 =?us-ascii?Q?FXt4f+K3JubZfuDNvJUfbX7ebgUnH8OYB0CiQz/k0UerWno53hsjXWjWhL9E?=
 =?us-ascii?Q?6NYFo90DbIh02ogBhF4DK9q7VPMDIHB621aoyOKIEtq6RC3kTLDnW5l/zWhS?=
 =?us-ascii?Q?iGFS+PNGSK2wnvI7YK7BGMGGsqgOVffRGHV/+u8Wjj1SQfM6YDW2Oj7Ey96E?=
 =?us-ascii?Q?t+IE3lq2uo/5giaoVn/47CI705kAFcL5F0XEL8/HYccCfaBKUQFfOhsb8ejT?=
 =?us-ascii?Q?6z6JpN2FuM7p4LLl+nK02DRZttuVOHkdGhnZVAe0Fv8qBwNgWeb/cY6YG11n?=
 =?us-ascii?Q?Le+KXqtW++0X892nlO1vvRZ6Praim3otFOeX5K52Z3oSDp7W?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e53383-0905-4189-fd31-08de952e2594
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 05:17:36.4208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3BZE4omoEsfWrNGjZWw1tGyRDJAwgdsbT8t5Ye1PURHlQhNLO/QCrFRUkEPho0Eb783lTwE1/DwRBn+/T90/sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8759
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276282-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[westermo.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,AM8PR04MB7284.eurprd04.prod.outlook.com:mid,nxp.com:dkim,nxp.com:email,westermo.com:email]
X-Rspamd-Queue-Id: 6F8AE3B7216
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> The ENETC does not support BUF_LEN or FRM_LEN in TX buffer descriptors
> less than 16. This is written in the reference manual of all SoCs
> supported by the driver: LS1028A, i.MX943, i.MX95 etc.
>=20
>   Frames must not have a FRM_LEN that is less than 16 bytes. Frames of
>   0-15 bytes are not supported.
>   (...)
>   The first descriptor in a chain must not have a BUFF_LEN that is less
>   than 16 bytes.
>=20
> I don't think proper attention was paid to this during development, we
> found the text at the end of a bug investigation. Therefore, the driver
> does not enforce this.
>=20
> But the frame length is out of the driver's control, and the network
> stack can actually send packets with skb->len smaller than that. The
> result is unpleasant, as will be explained below, so for simplicity
> sake, we just pad anything shorter than ETH_ZLEN.
>=20
> Zefir Kurtisi found a case where transmitting L2 WNM keep-alive frames
> through ENETC would soft-lockup the host through an IRQ storm. He later
> distilled this into a small enetc-killer.c user space program which
> sends a packet with MAC DA, MAC SA and EtherType IPv4 (14 octets in
> length) through an AF_PACKET raw socket.
>=20
> The IRQ storm is actually a curious effect of a chain of events.
>=20
> The hardware behaviour, when an invalid BD is put in its TX ring, is
> that it would transmit the packet as normal, update counters, raise
> completion interrupt as normal, but it would just not advance the
> consumer index of the ring (TBaCIR) to signify that the BD has been
> consumed and is available for software to free. The ring will also get
> its TBaSR[BUSY] bit persistently set to 1 afterwards.
>=20
> It deserves an explanation why the behaviour above would lead to an
> IRQ storm, since ENETC interrupts are message-based (MSI-X), and an
> unhandled interrupt would typically just be lost rather than retrigger
> itself as a wired interrupt would.
>=20
> NAPI processing in ENETC has 3 steps:
>=20
> I. the enetc_msix() hardirq handler disables RBaIER, TBaIER and sets
>    softirq processing to the 'pending' state.
>=20
> II. the enetc_poll() softirq handler for the IRQ vector walks through
>     the TX rings affine to that vector, checks which ones have a TBCIR
>     updated since last time - enetc_bd_ready_count() - processes those
>     completed frames, and clears pending interrupts in these updated TX
>     rings by writing to TBaIDR. (I've excluded RX processing due to it
>     being irrelevant).
>=20
> III. After the softirq handler does its round of checking all RX and TX
>      rings for updates, it re-enables all interrupts in RBaIER and
>      TBaIER that were previously disabled by the hardirq handler, and
>      exits.
>=20
> Because the TX ring with the short frame is skipped at step II (TBCIR
> wasn't updated as part of HW malfunction), its pending IRQ is not
> cleared in TBaIDR by enetc_clean_tx_ring().
>=20
> But because enetc_msix() disables TBaIER at step I and re-enables it at
> step III, another MSI will be fired upon re-enabling it. This is what
> completes the cycle and the driver goes back to step I.
>=20
> So the driver misinterprets the mixed signals it's getting from the
> hardware, and ends up causing a software-amplified IRQ storm.
>=20
> Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet
> drivers")
> Reported-by: Zefir Kurtisi <zefir.kurtisi@westermo.com>
> Closes:
> https://lore.kernel.org/netdev/b3d9136c-2803-4203-b1ea-1f9e62de80a1@gma
> il.com/
> Tested-by: Zefir Kurtisi <zefir.kurtisi@westermo.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v1->v2: handle the BUF_LEN limitation too, independently of FRM_LEN
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 13 +++++++++++++
>  drivers/net/ethernet/freescale/enetc/enetc.h |  2 ++
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> index a48ee3040b80..c70df45422e0 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1050,6 +1050,19 @@ netdev_tx_t enetc_xmit(struct sk_buff *skb, struct
> net_device *ndev)
>  	u8 udp, msgtype, twostep;
>  	u16 offset1, offset2;
>=20
> +	/* Hardware does not support transmit buffer descriptors with a total
> +	 * length of less than 16 bytes, or a first buffer size of less than
> +	 * 16 bytes.
> +	 */
> +	if (unlikely(skb_headlen(skb) < ENETC_MIN_BUFF_SIZE &&
> +		     skb_linearize(skb))) {
> +		dev_kfree_skb_any(skb);
> +		return NETDEV_TX_OK;
> +	}
> +
> +	if (eth_skb_pad(skb))
> +		return NETDEV_TX_OK;
> +
>  	/* Mark tx timestamp type on enetc_cb->flag if requires */
>  	if ((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
>  	    (priv->active_offloads & ENETC_F_TX_TSTAMP_MASK))
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h
> b/drivers/net/ethernet/freescale/enetc/enetc.h
> index aecd40aeef9c..819e643538b1 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -21,6 +21,8 @@
>  #define ENETC_MAX_MTU		(ENETC_MAC_MAXFRM_SIZE - \
>  				(ETH_FCS_LEN + ETH_HLEN + VLAN_HLEN))
>=20
> +#define ENETC_MIN_BUFF_SIZE	16
> +
>  #define ENETC_CBD_DATA_MEM_ALIGN 64
>=20
>  #define ENETC_MADDR_HASH_TBL_SZ	64
> --
> 2.43.0

Reviewed-by: Wei Fang <wei.fang@nxp.com>


