Return-Path: <netdev+bounces-173730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4DFA5B6F6
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 03:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562223AF2B7
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 02:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8566C1E520B;
	Tue, 11 Mar 2025 02:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b="CepyYV5+"
X-Original-To: netdev@vger.kernel.org
Received: from mo-csw.securemx.jp (mo-csw1802.securemx.jp [210.130.202.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0081DF27D;
	Tue, 11 Mar 2025 02:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.130.202.152
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741661642; cv=fail; b=g05o6T2sVRsT8tVdN5Nl659GeH6Q2YYSxMGH267QtAiqDoJoMhWd3ToVq3Ieb7o22XKczef1HKjqykz2b2GfTCcnLxlkCzj54L8TsCMhKKYd6tPT8R3yX6ybDx02MrcCTtJ03+/WvqBnp+A77wJ4L6H/nO8h91T8y8fC4k5cnSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741661642; c=relaxed/simple;
	bh=kOyMXra9tx1tiz15mH5EirzFVKukx7gMLdH5u3dYsNE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iqaptPG57kTXa0C+9fL9bOVBueC5jxW1ek3Cm8O7UMUOVU5C6kYaQU8Q/7LE1zIa4hXDuz0GDuLUpTHBR5w+lylsVYLXJWkJXlxqIHrdgcqIlOjV+ZlxQPflSuBrkSWkeyvH81BZaPnf3V6AmUo/VlJn7ywPrs1007OnizxII+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b=CepyYV5+; arc=fail smtp.client-ip=210.130.202.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key3.smx;t=1741661511;x=1742871111;bh=kOyMXra9tx1tiz15mH5EirzFVKukx7gMLdH5u3d
	YsNE=;b=CepyYV5+aTHQ8hfuYC2XupdKKlftNwn5kYKg5jWfqwdBBPXHSrLViwwO1TLUp6Yox4iv2
	+4TZtv7DBDPMi/ycEPtGChyYhk1QVGhvxSPti8KUuT9xD4ahs698RjzddLIFeA84OKCq0iujxUM2m
	0yKM0RqV9ov/y3H9jjYKSDYWSTca7PzlrJjGDWOC1HCP/UrBSi1f/+uH4wNz2KByTlEI9PqlT7YNf
	lqlBUqrLrqrglhiBpkenVdG7JcLaXH/B6zzwg8z2Qf0avE6lexxqECPWnuXOujb/DLeDWBHUjJbpA
	Xm2lbVll4qqUD+75dSVT+J4tE1hJqOcME3SNvoSNIw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 52B2pmaD2906371; Tue, 11 Mar 2025 11:51:48 +0900
X-Iguazu-Qid: 2yAbuzQy1XRZSQHHOT
X-Iguazu-QSIG: v=2; s=0; t=1741661507; q=2yAbuzQy1XRZSQHHOT; m=nSx6m3gyVmsSceJkTgkJU4th1Rq2yCpeQUqzRA80AgI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 52B2pfFw1419632
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 11:51:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eE5fK+hYesmD2Ef2aPUuVw7upfU5gRF/P2qMsmxJhSGE7Bwr3w1XcF85N66SXBXhgBj++Fwe+XZYA2Vd8AXZ6kWG/uEaw5aLwT0jhKbeDkVWEGFD8Xr1klqpgGfZS+M7l0LJs1BHNb25lZRluPrZETa73oB7rchrxU2KrVzdoZzf3q+uEfu+3C4yUc+tblnmSGVg/zws68f3NCJl4jYr+30VmyJCW67/yqUFdjCM4PWY6vlQkj+ceYleak7ub9dke9UZMWH/2NnZ5GfNOt1JAAta4M5XQBEc1XHAGtL/Dug7ZmYxcyM73tdu083NjOAmpGbyQCvG0s7KYuqWL6aVhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ecrAQ0g+Q+kzOINfhj9FoHm6E+mIMSLrB4OWo0S6es=;
 b=ZaKxlW0W5HH54bPyjX1EVqV+sotu2YWU6cGXl4joa3+8hSPaZy2PWgaMR953Ui2WZkRz28UO76XiMdHqYizf8clrDlLRU28OVFfydH77Z43u/AGwSdOdtzEdJpZlMLEbVKwW7cwJzpDSXFHikt1RkB7Wi2/qWxXLiVMhu96Ib+tQSdWAe/nk1Z1DmPlHuR5PwAKiMK482Cu7FavRhiZ84btQ1ibJY9BTfC7T4VsCg72X4U3gkMp0F91hqzahKTqvcXzIJmgt9cMfX/k+TZILNtTItU8p/IArk01bb7mvkLIHn3jA3ureYPOAWBRZQUZ+C+SR4qdXAr1tMkCqWhOTiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.csengg@gmail.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <heiko@sntech.de>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <vineetha.g.jaya.kumaran@intel.com>, <biao.huang@mediatek.com>,
        <xiaoning.wang@nxp.com>, <linux-imx@nxp.com>,
        <david.wu@rock-chips.com>, <christophe.roullier@foss.st.com>,
        <rmk+kernel@armlinux.org.uk>, <netdev@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>,
        <linux-rockchip@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-mediatek@lists.infradead.org>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH net-next] dt-bindings: net: Define interrupt constraints
 for DWMAC vendor bindings
Thread-Topic: [PATCH net-next] dt-bindings: net: Define interrupt constraints
 for DWMAC vendor bindings
Thread-Index: AQHbkIrfy9b5BBS/D0ihD4P7fHbQtbNtPxyg
Date: Tue, 11 Mar 2025 02:51:37 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148181E9FA1336D0D3CE9275A92D12@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250309003301.1152228-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: 
 <20250309003301.1152228-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY3PR01MB11931:EE_
x-ms-office365-filtering-correlation-id: 301f50ff-8626-44e8-ccfa-08dd6047a45f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Mkt5WjdHa2dPa0tLNTZYdThxNzJvVjhlQ1MzQ1dTek00ajU3aHI5d0V3?=
 =?iso-2022-jp?B?ZHFNakxuK2l1bzJ3blVrV2pCTmU5Z1NHZHJlSFlNV0Q2a21lK3QxZ0s3?=
 =?iso-2022-jp?B?OE54cWFiTmtmYklIc0FFSWVOK1cwWWhrWkFwcHNzT1NKQnJwa08wcVRy?=
 =?iso-2022-jp?B?bHZuT2hXbEFFb3FGK2FBT0YxQkQ1dmFNWlZ2N0FYVmptWGVZdHN2S0hO?=
 =?iso-2022-jp?B?aEI4UXNvaWQ4ejZnRndIV0F2OUt0S1hHTlB0ZWx4SVIxZVR4NzNiTExE?=
 =?iso-2022-jp?B?RzErRUhzVU1UQmNXKzRxMlZBeTNZQlUzU3psWWo1NElCY0IwTGZMWGxs?=
 =?iso-2022-jp?B?VUcxRWN4NnRMV1pxQ283cVE5N3dWS2dKa1NuYVlnU2JUZFNJUTBCRVN1?=
 =?iso-2022-jp?B?VzVQSzhjUmhydEVkcXNQU2NaUk9Hb0ZMVTZVUUlGa2UrcUt6MTNZTHJ6?=
 =?iso-2022-jp?B?ZFBxZHF6bnVLbSt0TkhDR0lVd3lGSTk3Rll2dTNkZlFlekRWbkxVUU1X?=
 =?iso-2022-jp?B?VlZNeWZsTDBsRWFqMmtXM0NwY0huYVFEL2NJTmxXWkc1SXMzbVViMExO?=
 =?iso-2022-jp?B?bHQ5UTQwRkNZQlpOZTFaOVpGM3IwV2txVGRUYWJEVm95Z3oxMUlReENj?=
 =?iso-2022-jp?B?Y3V1QXN2cnB4aGYvYVAxdFBPVkxITUxZQjJOZDRtU25YZzAvWVJiR2xD?=
 =?iso-2022-jp?B?QnRZMzBRWTVma3JFVFZFcXdoWkJqSzRjNmkvaU5DSFFTN1Z3S3Q1N080?=
 =?iso-2022-jp?B?Zm85SCtZdXo1Rk1wc1hhbmpPcEFtdVdBVXBNREtQMGdWTWJxeXdwVndL?=
 =?iso-2022-jp?B?SEltbG9vaU9DSGVlN2lSTVo3RmlBTklOWnFGRFlWRXVtS0JhSU5kUnpN?=
 =?iso-2022-jp?B?ejc0MUh6NVBmSHdMUEZleUw5bTBNeVkrbFRudGgzVnBrZEZZbWhBVzFs?=
 =?iso-2022-jp?B?YnBkbHptbmp1ZEpVVDI4RjgyQzQ5K0U4N0ZnWjJyS2haWUpJYTRXN0Uy?=
 =?iso-2022-jp?B?MjlEZ1A5Q1I1c3VJU3oxQWlLYnFjQUVjcHBlZER4ZFNZSkd0cTE1Q1FK?=
 =?iso-2022-jp?B?ajF4elNSYWlBYmNwa29ieEdoNjVFU2FwNUlUeDhuejZRa2hiTzdkbkVX?=
 =?iso-2022-jp?B?bUxDeS9XUFlURytGSWM1Uis3dXhsTzV6TE9BNEdSRmJiWFh0cTZkekx1?=
 =?iso-2022-jp?B?dlNPbUVEZU9ibTFKU1FBeWViVEZlMStnSHNqNkRjRVRiYVpteEhWcGMr?=
 =?iso-2022-jp?B?VmpTWTdaU2RFbGN4dTFuNFcyM2lwQ2pLYVJmd2NPL0oxd2FLVWlERUhC?=
 =?iso-2022-jp?B?YmxiUEIrUlM2OWpJN2lTV2MzUGY1dHhPVVd4VFFReTNYc2Q1ak8xdjg3?=
 =?iso-2022-jp?B?SWdwNlZlVVhnZFpMVzNaNTFKc2ZUYkVrdWlHUmFRKzlsK3U3bkxwRWdy?=
 =?iso-2022-jp?B?emFyV3Z5cEY2a25wQ2lKSGF3MjhpaEhBbVpPUncrT3RKYU1WWlBObzZl?=
 =?iso-2022-jp?B?S1dYVUgrcVdMbGVKUW9WcDlzUm9RekdyWStia1doUVNhNTR6VnZRYmx3?=
 =?iso-2022-jp?B?UmE1aXhqd3NOOWo4Z0pnRjN2bTNRNmsrZUFOY0hjU0lsbEN6MHM0SVUx?=
 =?iso-2022-jp?B?byt3R0FHdmxIRzE3U1g1dVBzOStzYUVVUVVmaUVRa0VPd3RRK1loZXVa?=
 =?iso-2022-jp?B?L2QvMmlZejBXcUx2OXJnODZvS1hSeklYVy93eUpYTldxS2NxcVl2bFFy?=
 =?iso-2022-jp?B?emJjRDNMeEEvTVdBc3pjT1dlRm8rS3FubHdROG9PUDFWVnkrWGpNMWc4?=
 =?iso-2022-jp?B?OGdOWHIxVk8zV29Fa2xuKzk0OFp4QVIwMGZnSldJNm44dDhOS2dHcW1E?=
 =?iso-2022-jp?B?SHl6NkI1NzNySkx2dzliRVdtblVydTNtbnpmRzZNU2FKTDJVb3AyaXFz?=
 =?iso-2022-jp?B?RUM1ai91OUk3dUZUL290TnYzV2pEbGZOaUh3d1pHUkJ2bTNta2hWMllp?=
 =?iso-2022-jp?B?M1Bzb1J1Sy9EREFnRWFaaEhHblpRZFZuUzdlc1lMb3ZseCtPc3l5cEJx?=
 =?iso-2022-jp?B?bnlSRlFVcVNWblNvRG45RXl5T1p5V1A2cWw5MW96dlZlSnFZNHF0WkYx?=
 =?iso-2022-jp?B?RzlJWTNEMWZobDBFRlFLNG5DV3lOL1VmcURIeTlGOU96bVpUWXlSd1N3?=
 =?iso-2022-jp?B?RHJJPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NmthQTJyT003Y3ZFS1BIckwwTVJJRWtYZXovVytBUXU1N1FnVDRlZWow?=
 =?iso-2022-jp?B?enUyTHRkSFppeVFORkE2blBLWUNNUTlkNWRSM1I2TFMxajZiVXFTc0hl?=
 =?iso-2022-jp?B?N3htYnMzTEduRmdpQ21VQkQvUzFHV3Y1TS9aQ1ZuVld6Z1U0WVRadTcr?=
 =?iso-2022-jp?B?QTZhVS8wOFc5bStTY2NXb0ZQQjJZSXJkNW9MaGs3RXBiOUtBU2pnd01z?=
 =?iso-2022-jp?B?NzJFMndJcXpTTlBRWnUrbHRweG5IN0dCR3Q2VS9jOVhDU0lhSUNIamVv?=
 =?iso-2022-jp?B?R3dGWVE3UllPMTR4U05aK2FUS3E3MVVqKzdTWlp0V1ZsbTNOR0pVZWZ4?=
 =?iso-2022-jp?B?UGl4d0RNS0tqdDdwakRCMXdtZERrbDBIOXpvNDBKTTVsaDc0cG9Jam1h?=
 =?iso-2022-jp?B?UlhVMzBRVmFmcnU2aXhnMktIVkVvNjc3WGtyUGFZaG5zLzNIakhYUHZt?=
 =?iso-2022-jp?B?SkZQN3ZUYnNMWEU0LzV1WExkcjMySEtjRUpOUTZWcjZxRzJsK0dtZFRO?=
 =?iso-2022-jp?B?enFVblZHVjlqTmJteGFLeDYyZzkzMkY2RjcrK3N4SnJoRVhjUkk1bUIv?=
 =?iso-2022-jp?B?bU0zMXRVS2VpUHdlalE2ZWw5TGlESVJiQktoY2JIRkNlRXIzWFBJemQz?=
 =?iso-2022-jp?B?T2Q1SDBDZDEwemkrcmgvaHVPSXhFOUxuZGJzM3luTjVGZTZaMzhQS1oy?=
 =?iso-2022-jp?B?YlZOL2p3UVI1VHhiV2J4U05Ja2Q5YXd5V1lMVUxhMktrK0hscjJWNity?=
 =?iso-2022-jp?B?S3dCY0RtT2FuVzlEWFpXL1cvazFCelV5QW8rWXREMlUrUm1YT0ZsbmFR?=
 =?iso-2022-jp?B?Y2EyZlJGNGVySTA2dyt4ZDd6QlA0STZIVi9LNUdTekZ6VVQ4b2pXRnZN?=
 =?iso-2022-jp?B?NHdFeVF2YkZaWW1sVjFlWE92ZjVaVkpVdERhVWpUS0NHdGg3Q1JGaXBH?=
 =?iso-2022-jp?B?dy9HUWFKeHQxY1dQYmpwczNYVmZuZitJODJ2UjFnU0JNVTJDdjd6N1ZS?=
 =?iso-2022-jp?B?QzhqQVNiM2ZaUGZlUVF3MVZBeWQ4YTNKWFVJY001Wmt3WnhGMm8zemlt?=
 =?iso-2022-jp?B?K1VkakdGWWx3cVZtYzNzTWxjaHhaOHdXL2JnOTF1U3JJRklpMDBCRVh0?=
 =?iso-2022-jp?B?WDZuN09EMzc2YnJ0S2U0WEtHeXJsNk95V1NrTVlRa2Q0aXp5WVZ4TjNh?=
 =?iso-2022-jp?B?QjVGL0tudGdoUldscVRCV1dtSEVyay9NbUY1RjBiaW5GWVBMdW1adXFU?=
 =?iso-2022-jp?B?Nml4UTJyQlFKQ2NLUzljOThrUW0wRzJJb1djNDBoUWFGb3BqQ2pUNGV3?=
 =?iso-2022-jp?B?UG9aMXI0eXl6TVpUUjJkcy9DQWw0V0Y2TXV4VXZ3azZkaVoyL3lwTEp3?=
 =?iso-2022-jp?B?SVNlODR5R2FYNG9RQ2xPL1VlcG8zb05xSjFNWjcxcmg4RUlBL3BqR2Ju?=
 =?iso-2022-jp?B?cXhrcDNmUWZDWU9vZEpJOWtsTHJTV2Zrd2ZjUjg3UzhxTmNpZW5HMGxE?=
 =?iso-2022-jp?B?ZGozYnJJcXJCWGpiQldYVWVqeWRSK2tJT2psMDFvSUpaSG9teDZqS3pE?=
 =?iso-2022-jp?B?WVhiYmJUWG5ZZGNrcDlSanl2NjdiMVNpSXV1VlR1aEZqbmRaWGowcVBI?=
 =?iso-2022-jp?B?OU5wQ2htbUZtdWJPekdvNlUvcTBELzJTNGZzUUEzUW1VZmJ2SVV3RXU1?=
 =?iso-2022-jp?B?UGVPVi91QzdROUU2ZVc1MlhUZDhLdDE5N1RzZTJqRzJVbG9Ba3MvSjZn?=
 =?iso-2022-jp?B?Vm1reGd5TmlVcmVreW5JYW55NEU0Y1FRRHhoQ25JVXlYUzV1emRKNEFT?=
 =?iso-2022-jp?B?OVpSUmJaeWo1bmUyblRqTjRscFovRnJVVStZTm5kc3ErZ04xTEhJL3Jh?=
 =?iso-2022-jp?B?Q0g5bEU5WUdVc3hpb0dmdExMdVYxMCtsTk1XYXFJcVFidmkzbnN6MzBH?=
 =?iso-2022-jp?B?MjhaT1F4OTZpWkY2emY5MHZLMDEzOThtU0JhQ1RqL1paN2tOTUJ6NEw3?=
 =?iso-2022-jp?B?eUVCVzRLUEhwTWJGQ1I1clVWMjR6T0NlSTdJTmkzT1IwbVNPaFBUM2cz?=
 =?iso-2022-jp?B?OWJtdVhzcGZjbys0NzJSM1RGdVpVUXNKeWN1eWM4SlJHblVEZXViVDk0?=
 =?iso-2022-jp?B?VzZRZWhTeUtrRkFtZ2JTdHl5YmJIbU5aN3pWRmRvQWRhVjd0aXpubGU0?=
 =?iso-2022-jp?B?L242OUMvWVhPWGlwTGVudkNpVWREUDg5ZFJxazNqeWZKaVRJckN1VzlQ?=
 =?iso-2022-jp?B?SzN5UlNEK2NBTVh5Y3ltSS9abUhZMDQyYmZ0REhTS284TWFML09uUkZV?=
 =?iso-2022-jp?B?aWtOdFgwd1ZoZmljWDFNYkJST0lGRHArMUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 301f50ff-8626-44e8-ccfa-08dd6047a45f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 02:51:37.2972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJkWU0SXAJ01J31i0RVe49Fed6AkGM9zbgO1L1qUvXxW3KzKbnYQDJhBuoLtounV8zRx5hvnGNf3wSG7lFypCehKjCiTG9mxh4wa23DhFQkjIu9bdqnKnJYzLRy3v+xT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11931

Hi,

> -----Original Message-----
> From: Prabhakar <prabhakar.csengg@gmail.com>
> Sent: Sunday, March 9, 2025 9:33 AM
> To: Andrew Lunn <andrew+netdev@lunn.ch>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Rob Herring
> <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Neil Armstrong <neil.armstrong@linaro.org>; Kevin
> Hilman <khilman@baylibre.com>; Jerome Brunet <jbrunet@baylibre.com>;
> Martin Blumenstingl <martin.blumenstingl@googlemail.com>; Shawn Guo
> <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; Heiko Stuebner <heiko@sntech.de>; Maxime
> Coquelin <mcoquelin.stm32@gmail.com>; Alexandre Torgue
> <alexandre.torgue@foss.st.com>; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.M=
N=1B(B =1B$B!{#D#I#T#C=1B(B
> =1B$B""#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Matthias =
Brugger
> <matthias.bgg@gmail.com>; AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com>; G. Jaya Kumaran
> <vineetha.g.jaya.kumaran@intel.com>; Biao Huang
> <biao.huang@mediatek.com>; Clark Wang <xiaoning.wang@nxp.com>; Linux
> Team <linux-imx@nxp.com>; David Wu <david.wu@rock-chips.com>;
> Christophe Roullier <christophe.roullier@foss.st.com>; Russell King (Orac=
le)
> <rmk+kernel@armlinux.org.uk>; netdev@vger.kernel.org
> Cc: devicetree@vger.kernel.org; linux-amlogic@lists.infradead.org;
> linux-kernel@vger.kernel.org; imx@lists.linux.dev;
> linux-rockchip@lists.infradead.org;
> linux-stm32@st-md-mailman.stormreply.com;
> linux-mediatek@lists.infradead.org; Prabhakar
> <prabhakar.csengg@gmail.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH net-next] dt-bindings: net: Define interrupt constraints =
for
> DWMAC vendor bindings
>=20
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> The `snps,dwmac.yaml` binding currently sets `maxItems: 3` for the
> `interrupts` and `interrupt-names` properties, but vendor bindings select=
ing
> `snps,dwmac.yaml` do not impose these limits.
>=20
> Define constraints for `interrupts` and `interrupt-names` properties in
> various DWMAC vendor bindings to ensure proper validation and consistency=
.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Hi All,
>=20
> Based on recent patch [0] which increases the interrupts to 11 and adds
> `additionalItems: true` its good to have constraints to validate the sche=
ma. Ive
> made the changes based on the DT binding doc and the users. Ive ran dt
> binding checks to ensure the constraints are valid. Please let me know if=
 you'd
> like me to split this patch or if any of the constraints are incorrect, a=
s I don't
> have documentation for all of these platforms.
>=20
> https://lore.kernel.org/all/20250308200921.1089980-2-prabhakar.mahadev-la
> d.rj@bp.renesas.com/
>=20
> Cheers, Prabhakar
> ---

>  .../bindings/net/toshiba,visconti-dwmac.yaml           |  6 ++++++

Acked-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


