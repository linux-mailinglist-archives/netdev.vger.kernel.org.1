Return-Path: <netdev+bounces-256084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMRZLiJYgWkFFwMAu9opvQ
	(envelope-from <netdev+bounces-256084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:06:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37366D39CB
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E01930484F7
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 02:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006CD2F12AF;
	Tue,  3 Feb 2026 02:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HVICsofY"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011004.outbound.protection.outlook.com [40.107.130.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8302F1FC8;
	Tue,  3 Feb 2026 02:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770084250; cv=fail; b=VN9phUNuhyxLs97Fm0TmK2eq+iMn10W76Pv0lMeDX1RSI5NwQ7nxRA346K5LQKsstdcRgrwTyaW2HmxhPU822Tr+Ej6jb3MiDVvtSZ0/ZFDxHTtUEnUUemMAtqAlEun7En//7mL+/PoaPrv5v8VXcj+A4rlVCPgFNo5HcoS/bT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770084250; c=relaxed/simple;
	bh=Y1K+VOV52DehcuGmJ6TIa/WlHJb2Lx5CdLjKxrNsBAo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Znxl8rIocPeIuGmCDfAsjz7QFDc4MlBpwiZBuHy6h6Sk7uaURvu+7uVrR3I0cU8Y6MWdZEsWNHpz//zglTV/FDFdCRte85M/ptafa5cv0uIm/FnUyGzQX0ywm2C4tW/CoQvHf0YBMp3me9GM9sRveSUYyNnkWK/fCE9b2n44y00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HVICsofY; arc=fail smtp.client-ip=40.107.130.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdIn47BrQ3QfdTPX4twggDgzKVYSUh7egAoGKaXfOt43uTPygPjfr5V+lLv0HEdn8Bg40LRwqcrz1Xhj72rrijxs87Ttp49lMpiEaz9EHjtkJto26cHP0LplSws+QGDDkOehqczPpkABL1vrKPEyYX/9qrgacy4/v8fTsMv4JTxzPpCgzpOmEInaQfine5tgkuTlqhQwG27+FFwcYnVxIsdEUNkBzX54PWa19mwY5BIGZtaPKlsWw4dxY4wSIHuhvq4lJAuTUoDuZ2r919YGR5uew8WWJxLnz+7hWVrNv9WqyFyOGpcmXlADJ1JIWQeah+Gab9HgEwvRwgCPcgfuPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPcfyP/4FOXGfQMS6WmKSizsIqJRF8ru6fx5qQaDfQ8=;
 b=oAVI7akTFMGDwEnQp+Yk2SkmpTNuDSqDXapRmzPLAWearg7GWAslKHzf5bnu+az9/mpZvQWBvZ3+qzcAgSm3+O6HztJw9etqkp8ktZvnQls92V6sd6qqk7mpQjVOV4bf50tyF49OzImiUEKvlfKWq/fP7IIcXpMIkozUC/R4z+48KfGumEN8sGVFhfu8dv8CYROiwYZbW+v+Nz2lbBgaEzX5yHchXtyavHH16SaurfDFLTL4cCfQW3pSmGgoVmceHNB8K0Lm78EEGxEF+mXzrGoBy1AdUGctNuN10dcomJcofjrq+3DjYN5tIs526z+SKLtio9IhOM8Tro211U3bIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPcfyP/4FOXGfQMS6WmKSizsIqJRF8ru6fx5qQaDfQ8=;
 b=HVICsofYvLXT7lhwIjRTXO39A70ew8HNaNeIVSO0o0yvm+XdBcOrC+9KViYwJ3TiqiPKA9eSIJ3f6GEpFcamOeFS9m+8Q9Skz5Dbrl48Wz2dPdi5b5o9XEK8ybrSY7HHA41iBvXvWN/c5UHiOA4ULtXpeTRtFS4gx0cXWxpDQYQMx1mCFkceSJLbQfq9kBlZd9Otwz1aRsrMTJzakbM+QWX74PJaAEHvwZ57zsOvGIW2/CGeEjBZmtRJjNel252jpJES2RokEBPqCQL3I0DlCxcEQ2C8uBljOcs580JepXGp59kKvcBJFuKGdP/F0xrtvyDg2sb4hLJ8LV/9GDcnEg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB12061.eurprd04.prod.outlook.com (2603:10a6:10:646::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 02:04:06 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Tue, 3 Feb 2026
 02:04:06 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Simon Horman <horms@kernel.org>
CC: "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "ast@kernel.org"
	<ast@kernel.org>, Frank Li <frank.li@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "hawk@kernel.org" <hawk@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>
Subject: RE: [v5,net-next,06/15] net: fec: add fec_enet_rx_queue_xdp() for XDP
 path
Thread-Topic: [v5,net-next,06/15] net: fec: add fec_enet_rx_queue_xdp() for
 XDP path
Thread-Index: AQHclFAxxh94ggUHY0WiHYv3gtqinbVwOPRw
Date: Tue, 3 Feb 2026 02:04:06 +0000
Message-ID:
 <PAXPR04MB851042D1E3A2C8F9340611C9889BA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260129103447.1893129-7-wei.fang@nxp.com>
 <20260202142655.1847932-1-horms@kernel.org>
In-Reply-To: <20260202142655.1847932-1-horms@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU4PR04MB12061:EE_
x-ms-office365-filtering-correlation-id: e4ff5faf-f9ad-4839-d082-08de62c882e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7lBgc/+ZX/ULIpR/6Lh5ZFQz/+oQXllz8S2yzmgFqfeDVOVCZNcYWOd+NZh8?=
 =?us-ascii?Q?PRPFsDu3AmY3zldnWFkwgfVqs4f5GmAWapx1XehHSbudVWpzZr1ju7xgUNzb?=
 =?us-ascii?Q?irqskAxvQtc+3vf8f85KSh0PzIXEGa7My21d/+DnOhUyHunNm5Cz0nCIpt+x?=
 =?us-ascii?Q?GV/uydmFwh6wCR5qcJLgbB2IQO3iJpBwYMl7zBOg7qDZS9UIhrlik46L5F1c?=
 =?us-ascii?Q?1kJ20yaFBJTod9lmrd8JYPNmKkTnTcsD7d75dZtGODhqO9KgwmNuvNxyWTlf?=
 =?us-ascii?Q?nN/1n6S1WKZMEoCsx8gWEwBh6FpkK5Fqv2ZdDf3N3coDWKZm9Jz6sYnHw2gi?=
 =?us-ascii?Q?rPkMzhteYVB5nHTE9Axtn/53+hUs9g5lGCZPTG4fdGPXhn/DaE1p66YdkWhM?=
 =?us-ascii?Q?G8QynpgVaq5o4tePZdhOE3i4J5IkS1du6dUeb5Pgqq4U9BxO9YIOFQHEjGfn?=
 =?us-ascii?Q?2YzsVLISVzKt6JaZ6Uc0KPA/k7cHA2iWpcOIwYOlw7f6jlPJBC+jQ/Cnavcv?=
 =?us-ascii?Q?u7U8BoXqplMGKtjuAd3xVLNZ57KqiTuN8m/mwqoVMPypt83sBttZ0PPLhxAT?=
 =?us-ascii?Q?owtBW3V0T/F5kscC6B83ZaGuIF3F5vVbwD5GH2aQKkTQjd3wet4NsGybZv/Q?=
 =?us-ascii?Q?GUk3H4oiLCju0RJmwTy5B1LDZfVTTYJzjHdx7tgnUvaKhqxufFpslFAqW/Om?=
 =?us-ascii?Q?khhfj2b80BabkZrOHfNaKNny4WHHiTT5zmCdPLZZaahaqj+hl6zgUDkHb45D?=
 =?us-ascii?Q?AyuGjdYWXsTFoKPx1umYhJRfMOHBoNt0TxjOivqZII7mRHkHz/kMtBeI7NoH?=
 =?us-ascii?Q?C3whKNKzgrwmvruQx9FBnJsmELHFd7KR2bK+uAFF7iIIqjyfbigdQNoCK+VV?=
 =?us-ascii?Q?nKkBnD66DRp8+ZcX2YzIGnb8A5KhD2vl+JVZzioeWP7M3gdXGqBRJ4qCMjnT?=
 =?us-ascii?Q?oFgrwwvStI3MvDW/klv1drNgXesa4uUO3dUL8ae6mGtUOr5svurtPluE166u?=
 =?us-ascii?Q?5gzSC4ZlgSp+BO/cm6D0oPsr/baSmT8rjRbATkpEfk65/H9uoFBm3enSo5qF?=
 =?us-ascii?Q?EDE/OKvMEjtisWDr3Z/+C2KAOs4TSM01/AwFvV66fqICBMcZ7qPyH2z/GBsW?=
 =?us-ascii?Q?bZXCry+OjX2Ak2CrXEpmuNaRsrhutjIPlo05QIe5kKdVoEDkP4lyU3B+2m2R?=
 =?us-ascii?Q?Eg8hplsylfh4M6n1FOulfmKYQy+tUlejX7aUpOGkWhWMNNe/04H6adFh5bIV?=
 =?us-ascii?Q?KwmyVwV3Jfc2G4GYgbFVpVmZ/yLz06cTYcrXNwuCQJjZKZ3/jkThyKGCzD72?=
 =?us-ascii?Q?ImUCVKlCCHQOs6CfmUyHIbahr63i1E2x9Lk1eU1pJ+YkS0dqTBKJvLyg7WOg?=
 =?us-ascii?Q?/Qopi1h+TXmwiypZwq2i8LoJKHY8S1DaLyzZ/P3ZJg0VpV+RNm9aWqX571Zk?=
 =?us-ascii?Q?oBdqT0GwZk7cL+fUkU4/jOJzWGoD425g1Gat/Wt62Vs5fTNaVOgQouCnmJPf?=
 =?us-ascii?Q?Qk6d3PeERowfw+ghX9gSlMNtSLdT3Xw2p3w0BYOnzqXtIwGFzljxqALySunY?=
 =?us-ascii?Q?nELMdLgFIaPKH4GMCslNCizPg9PXcbqnkrFfkMaCK0hqD4OFYkTQD5WMOXVZ?=
 =?us-ascii?Q?LWJbZkVTKE70kuuRgEcpmO4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3h/P/sD8EcwmnnBwC97sIRuE4ekizlPOVoLAvfJTienVBX3D0ce+ng7rWq2h?=
 =?us-ascii?Q?Ey6LRkIGwYEuUNM+O9uPyH1pctjaPdVPwdlPOo1NhOuecDJyynyYyChWzoPG?=
 =?us-ascii?Q?Ao5EX0tWjtHtjpIZ2YbDxbkPOnuonOIzX3Lq43i19QRxQH7OtO92fvrS+6KY?=
 =?us-ascii?Q?FcfVkAMQlDL85KpBKyqPXPfLF7325jvlyyN/do2/lvGD3oPPU2hWf5a8oiTR?=
 =?us-ascii?Q?5ejqxQ6XkNfXYsW0eKlLo/gAFgF6pQdx4PLxXlKCayK3RsbqWGSPX1ByK0Z1?=
 =?us-ascii?Q?mpDVoj/qkSL1FAn0xlwTisktW/EBkqIBpphjkimBJeNB0EUlcVcIq/e/aDmh?=
 =?us-ascii?Q?N/Rc5BEMQ6GGtS959y3rL5tf66UtUv2qliRID2Bfxqbtm7ud8EsYDx7aKFkG?=
 =?us-ascii?Q?p5ON5E6pdAg/n+pY+UlgMn+H0Crx7CpFtckj/TvYl1TEu0AE5UwexrgpjEdo?=
 =?us-ascii?Q?T6I0/lsVj3RXK1xpBvASGFBLIovLxRFFTgoJ/vIgF9U+OI6F2GboGeYaJEYF?=
 =?us-ascii?Q?U1gv1qyWd7zianW0KyO+1wZYJuw2pOFZIDVRny5AaKCiVynzRymPA8nVRwdb?=
 =?us-ascii?Q?cnACfUy15cTSSY0789rVkjvIBoasP2nwdsq9jzgw3f47NCossH8AfqkOjzrh?=
 =?us-ascii?Q?IpUk9S/J/KPfo5pAbY1fkeSaRITe/cQNU4/UeXII8g44Jb0RlWVpCYdI4RR4?=
 =?us-ascii?Q?pSeKkdMJUJBA6fnqRmCZSFHiHSDVALViXQTQVH5D+kRN7w+tedu/a4VqFmjL?=
 =?us-ascii?Q?ltdsGGZr5dFbRUNtp27NYgonuR/Tj3foNAsdBMElJNaKcpvyX7Vkh5dtJmLQ?=
 =?us-ascii?Q?HOaCNxC9oQlfEpjuj60Jx0ucxDaVbncRJ+NGe/k+CN1sVnqjKxNasKDn1a8W?=
 =?us-ascii?Q?HVf/MzFNW8vgOf/RJbol44Yiz6DjXv6z9lX+lsNdf8cu6vaUAEy2yIoUdLYv?=
 =?us-ascii?Q?FwtKdbn1FZwj36DdsyAKPaHSHyx14lZhiPqwxlrRpyg6vO2oxTc8WE86l4a0?=
 =?us-ascii?Q?42GrcD9/s4c0aueAMw7kVveUQnHIPvLfFyKJ5kxVtcoYNMbHOSVbhSgzoLMb?=
 =?us-ascii?Q?SvGBAepQuqxq/ExRJUDLiVufeewUoJf7yVZMSUXKv+jrRzuifyk0vlXqDGWd?=
 =?us-ascii?Q?wR3f011KK4PVV6Tyhay46nFd5HE4ZrquKd+Pr/V7bCOE2vxXwyidrrT/eWOW?=
 =?us-ascii?Q?mxK+RMpMNj2UySBw0kdojf6fXDstXvR7yVjvj5n9M5F9tnBKoVuf4QeejfqM?=
 =?us-ascii?Q?6Chez9w5NWpYkM4Sm+tOebStQa4v5CwUkBTtsJ9cp0QC9uZ0mcpEBNUx808s?=
 =?us-ascii?Q?gxxbEQJtjUCEjW6cpAZ5a2zy72zd9QVWD1u24pxW31ZBtF2Lb2wirdEe7Gvk?=
 =?us-ascii?Q?TSKkyfX0sFXpS+g7Osz74lCEsa1NdQxJSbaeuszkX/uKqaEOc2XoDmI0CW6p?=
 =?us-ascii?Q?kDfR/+hjwoRjxBZJlVAc4qF6IcLcUIbYNqTOu8kfakcI4piACFWVKM+Vcd+N?=
 =?us-ascii?Q?tRIDGjvF2V2gDvPuUTr7LU7dG7whhXsq7kBK6hifGGx/ulZ7qydS05tjMOOq?=
 =?us-ascii?Q?dHBLbkFzTzZbyKZvT/4bxlQ2zho+XpY1/hpcpphtaIHzgPbdV7kSUFshkSrV?=
 =?us-ascii?Q?q8n5NOOuv1GyRxToEv684eTkVab1Bs3mWnJuc6ASk2sd0RUoN7/0+406huq5?=
 =?us-ascii?Q?m7dr4cwPqgyoINDghikfC1fO/grJwOjFhkxilbArfEptdx5+?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ff5faf-f9ad-4839-d082-08de62c882e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 02:04:06.1960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nzb8BZhMA/wenfiMa/tBlDTkzjei6LM3Ve6e5YJGPLECw67fBSFcYfCBR7VAHc7uXgSBbQb/5HCU9fu/FTG22A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12061
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256084-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,fomichev.me,nxp.com,redhat.com,lunn.ch,lists.linux.dev,kernel.org,google.com,davemloft.net,iogearbox.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37366D39CB
X-Rspamd-Action: no action

> > +static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int que=
ue,
> > +				 int budget, struct bpf_prog *prog)
> > +{
>=20
> [ ... ]
>=20
> > +		switch (act) {
> > +		case XDP_PASS:
> > +			rxq->stats[RX_XDP_PASS]++;
> > +			/* The packet length includes FCS, but we don't want to
> > +			 * include that when passing upstream as it messes up
> > +			 * bridging applications.
> > +			 */
> > +			skb =3D fec_build_skb(fep, rxq, bdp, page, pkt_len);
> > +			if (!skb) {
> > +				fec_xdp_drop(rxq, &xdp, sync);
> > +				trace_xdp_exception(ndev, prog, XDP_PASS);
> > +			} else {
> > +				napi_gro_receive(&fep->napi, skb);
> > +			}
> > +			break;
>=20
> When fec_build_skb() fails, it already returns the page to the page pool
> via page_pool_recycle_direct():
>=20
>     static struct sk_buff *fec_build_skb(...)
>     {
>         skb =3D build_skb(page_address(page), ...);
>         if (unlikely(!skb)) {
>             page_pool_recycle_direct(rxq->page_pool, page);
>             ...
>             return NULL;
>         }
>         ...
>     }
>=20
> Calling fec_xdp_drop() after fec_build_skb() returns NULL will return
> the same page to the pool a second time. Can this cause page pool
> corruption under memory pressure when build_skb() fails?
>=20

Thanks for pointing this potential issue, I will fix it.


