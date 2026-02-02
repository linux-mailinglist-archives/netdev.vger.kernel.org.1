Return-Path: <netdev+bounces-255692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBIJI6YHgGkq1wIAu9opvQ
	(envelope-from <netdev+bounces-255692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 03:10:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC2DC7D87
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 03:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E373C30038EB
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 02:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E7820010A;
	Mon,  2 Feb 2026 02:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HZB5d5jI"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013035.outbound.protection.outlook.com [40.107.162.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C191E1024
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 02:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769998242; cv=fail; b=ZJKbLWHcjZA8/Xv/PwB4t5PDKcz4qWsppzLQMas5lAsj710zSrcx2nc25bFKinrjpKOtjAKEbPa1jiYCB2lKTjZ3qo7KE4WZeDeLTYYfQEsZdPWBvtAKQ0ST/lY1frNqgxiCWdsHWXiLiFJoKrhpggBDcL2b9R5/W2DjwZoUADM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769998242; c=relaxed/simple;
	bh=+LGn4bN8sWy9Jv9M7Jzta8NXepDXtnQuVgYfRN+t4Ig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LZIw6nrd/WQ79Vfugd0LBuLbQvFS76TDO2SI1eydV01bXd8jr+TpbKfDtAyCcohHCX1shfJxmrbZqJV8ueQkMQ47BeFrcFgWm2hc9wgyzWkgqh2Y+mX3zIV2ffjsjs8UHZsEokLVcBAByxLmRBhg+2ANP3s9uW336NQkUBgv8Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HZB5d5jI; arc=fail smtp.client-ip=40.107.162.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0EnzDmEKify/AMQVmCUbzrSgYkUlEqu9Wazi8ulz2ux7nNIcg6pb1d3dBGvo5s/eK0yf+lfGFJWGDQM0DcLRmWmbkHoCVtIKsSw2v0sXe6WLoiclfVQ01X+vftK2iFyuixoY7pj3yCerbb5vjofczlE3cwX2PJZmH0Oh/K8DlRno7eO3MosmauLAggdy1WeZY2s+/ReZ49nhon1smfK/jKhJh8qvn9ILzoSIdi3H/+qh4Mr3eRCXs2ZGZ5d8yUH0RIAXtOLDzlywl/BpwTRdHzPTcHZ8oO5F7Jo+pFB5jI5UfEeAE3yoL6lF8UTdNkI2crfYAnjI+yJ3LvAQYrmhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LGn4bN8sWy9Jv9M7Jzta8NXepDXtnQuVgYfRN+t4Ig=;
 b=CWsaDqXZE2njp62amnHvQ5L8O8t+3XyLp8LqaGm0XGcb4PWYNu985mLrJSxf+kEup1/FonLO7NXzdisDRQKfUP2PJseyKIHt4WOjm4NJE9bb8fHjQuvb/KGvU9uK5f6kE267I+hTGF2A5C/sijkgSFf32mDA13TxNCRsl9PvmPT3vvtmQqzjLvGVzlg3oBEh/90BA078NgwA4YPfDW8Uje+IDEDher8dZnHqt+f579mLO41vDOh66FovPHPMvEaKuhFgVY6iLatE5PQLd3BxXhDhk589ZYbqYudojhr77YWNW7vpN4XJfUcFotQLybl3uAhZF248fnC7d4iorBwVtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LGn4bN8sWy9Jv9M7Jzta8NXepDXtnQuVgYfRN+t4Ig=;
 b=HZB5d5jIWMDhIbnIaaoic+fMop4c/51hqNVfJ2WTxLns1cUVihs4OHV/bSQ7rqMACZ2c9WWTLd5ytgWdksfo0R9cDVfVAjYnXQkfDHfSFS2xIkmsVkb2wCCd2Yfq+9lQe7RqSqR2CqjOUl/Fkt/0OgHC+FCB8RMwZY0/Caa9EeZvqsFZBrmvuLIZkCXfZ6aT8nOMo4lsJOMujZErLLJV7OyUF00Rh+4+uc9TqT25k19gj40hZnI4Wk++qmmEaxC+cbesFvq2PDKleG0oTMJpvH/NVCnJWR9onpuRa0fpFlayXU+f9kzjPiBH0J22TYbeE3VjTlf5otUjAJHYMuNRsQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10601.eurprd04.prod.outlook.com (2603:10a6:102:488::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Mon, 2 Feb
 2026 02:10:38 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.008; Mon, 2 Feb 2026
 02:10:37 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Frank Li
	<frank.li@nxp.com>
CC: "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net 1/4] net: enetc: Remove SI/BDR cacheability AXI
 settings for ENETC v4
Thread-Topic: [PATCH net 1/4] net: enetc: Remove SI/BDR cacheability AXI
 settings for ENETC v4
Thread-Index: AQHckfI4XxkGnJnVBkaXPPjM5sgc07Vurizg
Date: Mon, 2 Feb 2026 02:10:37 +0000
Message-ID:
 <PAXPR04MB851083A107C6058E3A55956E889AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260130141035.272471-1-claudiu.manoil@nxp.com>
 <20260130141035.272471-2-claudiu.manoil@nxp.com>
In-Reply-To: <20260130141035.272471-2-claudiu.manoil@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA1PR04MB10601:EE_
x-ms-office365-filtering-correlation-id: 862fcb49-0a6a-4cc6-fe4f-08de620041f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2pdHVsBF3HXgQZdSPhgTEhsTpW54vrzTpaCDoktG6qo2cu8929go2SMWHnod?=
 =?us-ascii?Q?NZnT0eHtqHc2EZ5MQuxpt90+UUDRCy7r8F4JUbL3cRCZ1qiwHUwdxU4F6r0D?=
 =?us-ascii?Q?dM4L5sTO61X59ezaTW8Nvqc0lRr0SasvPk1N1xLmI4A3uuwUkx3v1m6YlK05?=
 =?us-ascii?Q?XP0DIwLEvRPaalMk7bTwoSiU1VYJwviWVrwHN6oZUgpx3KeWNk8Tj4L0c5c6?=
 =?us-ascii?Q?SEG4QHlR6ld7BXQbQrywyd0T8escj5yDLsn8zRrQvl6IpInzOLAnT92pW4Yr?=
 =?us-ascii?Q?wpbPFcssDGleRwyLwv8K/vcPQOol727Myl1TSKJJ7ofbOBL03biOcRMukG7/?=
 =?us-ascii?Q?lrV3nT3WjcQjgnTg84Ezr3IsU7B672mLURA3a/GHNE3X9VEKfqq1lR6XJKM6?=
 =?us-ascii?Q?pOvg8JsFK7O2xipD/tVHui3vW8JqXiai/NDO6cnNG3qtDyxR2pMhmJt/11Mu?=
 =?us-ascii?Q?GeEh5obBMrxNfly9nx4DkHf0PRdbaFGYqsk1QS0P6rKGJCLpMlHcXs5qO/Ql?=
 =?us-ascii?Q?FL0RlosBSmVKS7Tm4nXNI/oqy2jNDj2VkYzBr60zr8Xz2nLzCJ/GaZmYfzaS?=
 =?us-ascii?Q?VplaowKds6apoxQqb/Bi96GqST0EZWt/B4KWdYuq9OSpPLjlPLnAnuM69vP0?=
 =?us-ascii?Q?jpu0R7OX8HxQcSmXsldjhLCUbEHhKMcNu1bEDUCBPF8TeucTqyTkYu+1ODxe?=
 =?us-ascii?Q?vRUitN7shyitAUtitth/3sNMpuClTGL/X35R64E9uF3K1MB2JiYNsAlGTHew?=
 =?us-ascii?Q?3yOeAcFSiBEkLDmo0Bl6Zf6fBag9SVJaVOL2u0acelwhtRDgrIk+2Lvw/zYM?=
 =?us-ascii?Q?KlOOBdFdSe5yDlcRLWk9f+55VvnMyHHBk5aFMe2fbZc0sD7QE/lS+yo5o4yq?=
 =?us-ascii?Q?MbM3qvJWlnWf+qMa41VqOWY7CBZFsOWy6KoQta2Ziw/fRQEg+wB8fB8JuT4K?=
 =?us-ascii?Q?c5JG59hVNFW7L8pv5RFRv/Pt6VclWzZHDdPCs1y6B/8+PeuTP1jN58DTI9jD?=
 =?us-ascii?Q?pR43VDJawubZohzAveBL+gFC49N6Ea9shQSzXQ7tt7MaXQ5gxU4F0bB8EySS?=
 =?us-ascii?Q?YgOKjAOxhEX1D+1QZMrV+nsrun7aDJRaiQdFPXCAAeg1utWAD6evo2kTyTz3?=
 =?us-ascii?Q?cHdn9m0fIoufHKOcbuwGsENpJRcdX92aft1vzTAmF9NyvqOa+N4awTsS6lRo?=
 =?us-ascii?Q?5plU8pwwktObH6nVrSaioWFJcVEiPT/5JPkYWwdIsrlcZLFBrhPHcjQ8AXvt?=
 =?us-ascii?Q?xbI70SY+cvSyJurb+Lj6OVViwP91Zysz9a3zIyxjyxSOSOyZAAnkwMJ55KWX?=
 =?us-ascii?Q?A5IVs5GtLOD3Y626yxnsdq1SzLTIhX4kks7mxDAFmKukYKrywbEkvRnJtEH9?=
 =?us-ascii?Q?3I6nrq5TmmFjkbHH93cN2IySKuCZGenJ62G472Y//++yldB49/ToSLRT+H6B?=
 =?us-ascii?Q?ch+QtXmiPs3n8ARiz9VBntOvF+E7TzJuRUOnk99I8o0J3C/QrXF6QagJCNyC?=
 =?us-ascii?Q?z591hrV3bXl33RVme46yUV1EowsPt6YvIJZTRyQPXsdrdlZ980lMpSGre6RH?=
 =?us-ascii?Q?r+LVb7EVlt7qlduwkXOyjnigD7JNa7a/tFbuDUhxE0AQaHwMTo6Ag7VVZFTW?=
 =?us-ascii?Q?drd4sqEafJO9+XysZhGVbuY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?k9pEjHtAq5oZ0mycPASM0k7SaVl7bzwclc1MThAzP9KVAxRh85AnGoTvYzol?=
 =?us-ascii?Q?fG1EPKxn2tphjYQB/s5sXauSDXd4UbClvCT9gEMfbUDi5VqsSr0zz/MyaOC4?=
 =?us-ascii?Q?AiRtPF4YQZiXYfXQcXh4Qc64kJo9fdIMVitCU1728lJcB9nXs9Gvq1vJylhv?=
 =?us-ascii?Q?nyxuOimoyxFTse6+SmsTLUyGqhYc5tB/HfZJPhk7V/1rCrsiArvFoEASUWaM?=
 =?us-ascii?Q?hBqHk9xB5QKdtEixZynNco5CXZX2oZn1u9wmcgV5481HWgHb206c3mUqpdgy?=
 =?us-ascii?Q?b4NLxZ6yhkkg5hrX18vwydER4GIx2j/a0FgXEz/Hj9vQC1pKLaBPXNCi5pzS?=
 =?us-ascii?Q?Fs1WEEb+svhl3FADNlniyV0P9F0MmKdqqbv0sxpGfiJu1XT1+L6VvjnTUdNh?=
 =?us-ascii?Q?quHKvWqaFK5zQLj2B5Ak7ZA+3iL1/yr05et0hMy/fky/cTamzkLikXgor6X4?=
 =?us-ascii?Q?Qp5rbbVxiSU90Zix2SiQEYUD6K7SE0OUJ/7zTFdBZ5JwTjm2EvAmb3CJGit8?=
 =?us-ascii?Q?XuLAGOvG+mwTCVPancGfQY2n1G0YNpghtKKbBCAQDX9ntzt4ETY8jW1TH4nO?=
 =?us-ascii?Q?4ix/JwU2GMgtPdYYye54nXEGK4PqxUcZo2aMyrJNs8vGHPYF87Y23lAyLo6f?=
 =?us-ascii?Q?xVGKIpzeVS2ucpfuc8VequVCnXy+TcC+JIZTBka8M3jPjGqE2qgudbM1kha/?=
 =?us-ascii?Q?uGwUA3SAXs5z5q0nz0PgvoX6KjGx3UaiS25AG54RNKp7kLne9wpN8l8nPd67?=
 =?us-ascii?Q?omjjkCCFRNYfhxoziPx9+c0zoFfGag+zjRmMXlkWnTrh0yez4+/iu0F59b32?=
 =?us-ascii?Q?X98tHVA48YJAlLwjjquXxrbMmsJ/NrJb5rnIywnXrLXxjtXVMe8B18o6+YT0?=
 =?us-ascii?Q?Lwn/tyEtvcYlMRF2OjstPOuohAj5zKuAvX4JGmRWKSZQhQ93/khf4mH94a1a?=
 =?us-ascii?Q?O4kb4xX+5zOYp0zt8VIHUIa4KJVT6wHIy3RgthUddrSNcz7PwmZIYouXzjlM?=
 =?us-ascii?Q?AC5JPJhtV5CgAsWS88zprWMU46EDurY6AMVKelJzfzFEhoyWHzUYcVmXCWq7?=
 =?us-ascii?Q?J3vFqk91PnBxXqQZ/tPatyacq8SuZ8KzIZTbIU5xuli47b38qHanH5OpYphG?=
 =?us-ascii?Q?RZF9csXhgCYO1X1FyaSLiC80FFdCwTF53EzpsUxNVA65SE+hnA0ZZz8P0oQE?=
 =?us-ascii?Q?cGIzry28JCkJzB4Vqlqx9cpk1UeaNY2RMWLFsu4WYD5TP4T8pVkfcjh25Vuv?=
 =?us-ascii?Q?kU+JJBWKJBpQWotmbvuuUzAvAwrUyH5vwOjmiOw6shTr92y8WDNQQkZTlWD+?=
 =?us-ascii?Q?pGk4mjhj+p2yJQpzltMvQJ5Ocmxr64XU2WR+OzGgYvz0zipfcwkddnpx5WQi?=
 =?us-ascii?Q?rHYSgtEAFRM//SWpTV/9217Yo5do1z5oe/csDb2CrP2fvLvn3PzOuXw9jI+G?=
 =?us-ascii?Q?5u5j64GmQDMfS5oUSHW+l03tfKmmPQhcna+tOhydgDPKEv/BYG3/SkM1ko9S?=
 =?us-ascii?Q?zuTN5CGWa2YuXMp7O7qH7WprBJw2kZX20FqCbJSFpWk4MzNKTeiFJk5ZjmpV?=
 =?us-ascii?Q?5hIBVQlGsiYQ3y4oZ+zmuH2p3Tmxmv/bqh1z4jXB88Ae3BawTvFg94u7fjPq?=
 =?us-ascii?Q?C779VUl5lny6mDbK7MzIjEif/v0Dd9F45xup7YAFDXnLP1xAl57AHHUh10pw?=
 =?us-ascii?Q?xNH0+26D8uu66IZ5lAJtU8yPGczCohZR8eCUVMMXENySFMdC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 862fcb49-0a6a-4cc6-fe4f-08de620041f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 02:10:37.8646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5io6VX652rX/mDwYH+sYVSAmdyeuR3FeIJouifJI6mVPtBY5cG2Y/i/Yq2cydVqkCAc4pfIQjE6yTfCUFwHjCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10601
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255692-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 0CC2DC7D87
X-Rspamd-Action: no action

> For ENETC v4 these settings are controlled by the global ENETC
> message and buffer cache attribute registers (EnBCAR and EnMCAR),
> from the IERB register block.
>=20
> The hardcoded cacheability settings were inherited from LS1028A,
> and should be removed from the ENETC v4 driver as they conflict
> with the global IERB settings.
>=20
> Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENET=
C
> PF")
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>

Reviewed-by: Wei Fang <wei.fang@nxp.com>


