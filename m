Return-Path: <netdev+bounces-293048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GqoDPhRGWrzuQgAu9opvQ
	(envelope-from <netdev+bounces-293048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 10:44:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B2E5FF613
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 10:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06233315AB41
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72695344052;
	Fri, 29 May 2026 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PSa9/7HJ"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011000.outbound.protection.outlook.com [40.107.130.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED34EDF59;
	Fri, 29 May 2026 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043864; cv=fail; b=BYFQqvUk/uOSmFEe4dQ6d/4Dy9ru+evdg6oXrjJoWPk3PaArDxssyJdyA/WQHRePgPC3Cn4rsNQZAhr9n9MWhjawYLu9KAuIFFTS8ygsuTj8GMOIY0WHvjliI+W+OHZFx681//NUCT90PsrdeT2hLSdCp4KPMpchQo2MidW5o4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043864; c=relaxed/simple;
	bh=QG73wwyEjMSQHASIJ+Gb23pofn1X3TxVBS6zl16ZBz4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fKBPsObcmK79lGyK+2NbotuKYm2SbxlQc0IJjkfWQI0F6p5DpA6WsK+CBm40rXw77N0pu47EFE7KjnR4b4murpnxU7obMuC2HbU+NfOr+AetSLEBoBYzgJW7AHGiVBsVZgjcuSzswNZq9VQEZWaKnlfSbFkNAZ9zwGi6FT7l6LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PSa9/7HJ; arc=fail smtp.client-ip=40.107.130.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4nIg5P7sj2n9H/klbmIrHhiZVXltI5VeDGB3YYDBugoertaVSMs6rTk1jFL4iDsQIp00bVCTY9hau17ZBR3vTgCZlDttCbr2kfsxiK3NbH9v6jyIhHzmjcOqnOiwvDQBpsZUN6WzYwC9J7rYoZG297zKu7NM+GGqFwLyPthtS7TvkHfzTt0kJkYr1ZR13+coV7pPylQ4O4OtRXor5di5p//GXiYGpT1HmKvciJmg7OEccEBQ2wndkxJ7BlbSerpw5WMlDPqV2rbqXWsgsO19/6aS169xCw+lTIY9FYA/6Znm3ndio1jr1aOvKTDDUc1YhcFC6kewCQzSoYSQdkfNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABUZQB7Kom4OfUBJn7kPjF+gjp54m10Y7BHaId5Zb+I=;
 b=sPAN8g6gUB7Yd295upf8MgIWZvs3M8ZT1xkggXY0oUsBBqtDrnUWhM3RGSKEGEedq5PYzCtcdazH1sgxzGPC2fWW2UFAWWO0jMb+F6JcM59lRypbEd43vPtBYyd+bRpOxHshxaYH7PLqQQDDP/+iE++6rBxTC3z1m0LBSTe0b3O3vB0j2wYOjFggz7slyQvousmkhXPNJ3K9Y8acEPVUA+8MLdCJlBuq3NNvYWIG1R0dK5K3+p9GctXhAnb3OhzHpq2W1HTWNjYOsUu1waosfRFGv3LKLDqjRdVTxFizpeJI34ih211v4i0CdZ04xIQL6VVHNmNQhLrwD/xKY3/tQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABUZQB7Kom4OfUBJn7kPjF+gjp54m10Y7BHaId5Zb+I=;
 b=PSa9/7HJWiHHdPFTJyNLE6XBc2UUyBeXENfMZ12eoMGumTx2KKFWH3wpvqA/tib1nFWAL1X+/2C+vhDMCcqWrBNRKhuSSRifiwZoCdHeQJU8HnyZViaQ1bZU8qyKbDyxPJjs34puVjHF4jUyZuSvdpjE/8owx3KimuBX2MH50ZxeaxzJPTU6Xj+bHU2D6qRhQdBMdiXNldSpYZ9fSm6H0ngiIWa2AWIwUrW3zVqeSpJIQGuRx5orDb7b1rgzxbCuucTqOjtHyKw87spKolzxXfcN+xDM/N2QbDOq0aujUw6gLGXe5wi4S6jGedZU06aP188YtolD9VptrdS9zNiCPA==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AS1PR04MB9239.eurprd04.prod.outlook.com (2603:10a6:20b:4c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 08:37:38 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 08:37:37 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>, Frank Li <frank.li@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Nimrod
 Andy <B38611@freescale.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] net: fec: fix pinctrl default state restore order on
 resume
Thread-Topic: [PATCH v3] net: fec: fix pinctrl default state restore order on
 resume
Thread-Index: AQHc7zMS3gJSwsZ+wUi8nDE2rQmTALYkrdrg
Date: Fri, 29 May 2026 08:37:37 +0000
Message-ID:
 <DBBPR04MB750094BCF64765DF8463587188162@DBBPR04MB7500.eurprd04.prod.outlook.com>
References:
 <20260529-b4-fec-resume-pinctrl-order-v3-1-6eda0f592fca@vaisala.com>
In-Reply-To:
 <20260529-b4-fec-resume-pinctrl-order-v3-1-6eda0f592fca@vaisala.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|AS1PR04MB9239:EE_
x-ms-office365-filtering-correlation-id: 95289759-1d29-4f3a-846a-08debd5d8a02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 cgRS+JntTaWhEndGz5zcpf2GP8GJOdwGc1Etw+lBoXgR66kGCv1DBfoU6cJO4abdFtrsewioSPiQvhJKcBp90xYEnYuEE+jNo0u8kDyb3Jw6zGdST1T71MCKUz1VxAxS09YCsbM01WkqNwdhhVwKWYQrWwFdz4z062Avtn4Gp53p4B5WWiM7EXvZC7/ZnkauPpP6VPTc9tT18qWgoguTFeK/9gxkOGL8SUb2jx5Ca0Rthpq0u8pmbiWgcun1L5vKSL4EnvNxpGGzFpSkMszE0h62861HCSznLqA94e63iO+Y/NSvS1pyrOum0mGF4Q1s183AU+CTpSvvSlRwuPWJvVhTOraCjdYDHTSwkeC8IMDH89V6Gm5TNQ8OQxsW9V84Cp5LO9lpJk40PeW9SCu4i3hokDPK7AfhLG3O6XxgxtPFMdO0m7KqxZ0P/5WYOWB+JbnO1RkeQJNM1dNXznmvP8X6+sw3X9vZN/pGuHSlwMUCRIb/R/AJoDS186WnLjNOgonD+Polcv4tC3PL+wixNfjEC9aNJrSgDUMcPMbPSu8Nun/NBRGs3pooAiNTPLV50gDRGjc6TKxSc4mCKTWovsyJJdTZbB5eYGNx0KHpWqdxjRuo8fQR9qvEm7m5Ch9TWQucQOx4H7kA6VJp2WmmUSqvH166buQfGnFyvHI3Bdj5yCvhwFkRczXvaTEAisKamTsvbYabhexwASm/RDjMx+Uj3hd8mD0tQFoikL7/mMeMvc3wU0l8toy0yBugY6Q6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?e8VnjAsucdix7ZdzJibjpGRKZ5oTxP8/DOnlrQpR1SXO6nRAXppwX2JhiaTR?=
 =?us-ascii?Q?bcjAzfpDNqBozD57bkhg0t4I+yP91Tpp9TySj1zlkheH70IsnPaIltCIvAao?=
 =?us-ascii?Q?h7MIxEbNs4QeJJAiETBw0mUv6hFzBzVUGR9V8SYHO9LmPpM6V88OniIYRglI?=
 =?us-ascii?Q?JRkg+B733zteiePocvvi7wkNI8npcL/AnERlvr8A9cw9IiJU5GCC94ihLkuu?=
 =?us-ascii?Q?jvYfnTU4iBFsgNUE+pRcOCSgnSrSGEafgk7s49kzSr2cG4sMm152KdCXu53e?=
 =?us-ascii?Q?CB76smbrhxlMqfz5ku9yIx3Qk3S1/kpPu5n4jaFRwbF1PIl6Ra9W0d4n8xSs?=
 =?us-ascii?Q?7pXA+TWRMbowSDRlehv4Iu8Admq98SDGsDie40yKdmB+famAvo1eRSSFi3rT?=
 =?us-ascii?Q?h8zJL9fRjUQ8TQwQfPIIjsgbWdWu3ojPCohKY3R30YAhxMHrjL3h20gUOFYV?=
 =?us-ascii?Q?FAuHhFO+QP4X1vP0JWr42LPMxAyZaP1187dEnZzo1rBw1CA6+ea+pKbNkrqE?=
 =?us-ascii?Q?8cyX5c8vtfmXQgNxIooC448wCMn2px3e3vL4KAtWtRVhPI9GphEKA3TNn7Et?=
 =?us-ascii?Q?snvzd+0YbSm+z3unhL5hKKM5pvLpwVpNaN3O3L8xUYlTByn4pIwuRcKckHF2?=
 =?us-ascii?Q?bqBVt9NftDUJKoJZqsmqDlLQD5gbthgs417i+T5Vy6vutJxi9KOJhtNVgfSF?=
 =?us-ascii?Q?JTMQ/yvyeWsKIN05VKwgLaCk3ZrEAXWnBqW0IK5iJXwaoDMlMzE91EFl3f3M?=
 =?us-ascii?Q?1UbUlphl8SD4P1IEqY9S/c22wWsuPLgR0lnj215z+Olw38O40mlQ4BKay0OP?=
 =?us-ascii?Q?rzLTMq1s8E0w6iahvYTDhZ9MKW30zQfqKDOzidNzJhjE394LHwCsjKjXgE9e?=
 =?us-ascii?Q?5pQtLYztLDPHwH34m48XHZHuQr7Hg+cPW5L4sAAtdBonVj66XXKFuFzCw+mN?=
 =?us-ascii?Q?C+kwFsk7IMCwzIFT7GgvNSn8d2EqxfjkhYRqc4qJJ7qFOYVDlzfzMBVeJkPy?=
 =?us-ascii?Q?cznXePklUY8aFMKGCc9UMKV3wHY/3eQUUJMoFP57ThDGIFKv38HziOwWRrDa?=
 =?us-ascii?Q?ad+KmCrz30DrCRPiTUWB4noM2LXd9P++GQ2M20yIsZag7atGUWBM6MMUFbns?=
 =?us-ascii?Q?jm87nDbDs4f4TL5q5RVuUHt8DqKNRqd6RAKAsjLvWgw75OWSXqNaP3wt47i0?=
 =?us-ascii?Q?NdSlaSJKfJqc8WwhT5/LEmpvgC568rDmnoOrUB8hiy/Zxx5Se2PAQI82DHxz?=
 =?us-ascii?Q?EWXEgVj62218gO9u+VO9jr4NwqKLj63cIKaFcmUzen7MgefbsAFCyRBIsROz?=
 =?us-ascii?Q?DFiscDIS2LZt38d5TjFpWdGgPoQXBAR1c87025OQ7S2ACFWLJy5S0VjRssMJ?=
 =?us-ascii?Q?oWq8E7nAe1h40tFjxqR5FaQrzTqV8YPUWOyooYXk70WCpUPiI52yVBtNL7Ld?=
 =?us-ascii?Q?FRTtqEsT5eu6eh9D/pVm8vlBCgGjLXAYUEoTtKb1N613SsRvlrcoI+zHSGEa?=
 =?us-ascii?Q?93QJthqEoZ/BixosLqLGNkPPE3UlXS0HVNkNyexkbo0Tlh03vsZAVIp5XII5?=
 =?us-ascii?Q?9ZbO1Bh1fH324zCyZsxoUrYNXujD9trxtBQKVrXbEc+b+u2fl2WDUalPj6UL?=
 =?us-ascii?Q?We1BozrJIdms1mu+J151FkwpupYUl0Xwta8r36EmBJCzpFgJfuIymeKdrJJ1?=
 =?us-ascii?Q?dKEJnkxxXaZ+c+5kIjHsuRaU80J42ZYYqv0LaY7cZSTiFllM?=
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
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95289759-1d29-4f3a-846a-08debd5d8a02
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 08:37:37.8103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UD7OnuUNOSM6yEVoV7XrhemaUk8cHFvGi1+mKRYdpoJjCScbxQET/q1i0glg12eIJw8bQsUFSwjfUby2YTF3tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9239
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293048-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 74B2E5FF613
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>  drivers/net/ethernet/freescale/fec_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index
> f89aa94ce0202d5f28f37362ce70e0943aa14025..6ebde65d7f1b8728a6c5d28f7
> 5cc0b0c4d983969 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -5594,6 +5594,7 @@ static int fec_resume(struct device *dev)
>  		if (fep->rpm_active)
>  			pm_runtime_force_resume(dev);
>=20
> +		pinctrl_pm_select_default_state(&fep->pdev->dev);
>  		ret =3D fec_enet_clk_enable(ndev, true);
>  		if (ret) {
>  			rtnl_unlock();
> @@ -5610,8 +5611,6 @@ static int fec_resume(struct device *dev)
>  			val &=3D ~(FEC_ECR_MAGICEN | FEC_ECR_SLEEP);
>  			writel(val, fep->hwp + FEC_ECNTRL);
>  			fep->wol_flag &=3D ~FEC_WOL_FLAG_SLEEP_ON;
> -		} else {
> -			pinctrl_pm_select_default_state(&fep->pdev->dev);
>  		}
>  		fec_restart(ndev);
>  		netif_tx_lock_bh(ndev);
>=20

It looks good to me, thanks for fixing this issue.

Reviewed-by: Wei Fang <wei.fang@nxp.com>

By the way, it seems you posted two identical patches, which might
cause confusion.


