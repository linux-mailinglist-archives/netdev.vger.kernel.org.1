Return-Path: <netdev+bounces-20391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4EF75F4EF
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 13:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21B3281516
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878A45690;
	Mon, 24 Jul 2023 11:29:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D046127
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 11:29:31 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04D7E66;
	Mon, 24 Jul 2023 04:29:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkVjdBJX3k/gP6xiIheD8L5J97i+7AkvG/4VlA0nZdCvBxU3I8xshrrwpPb2Vn2BtNWfX04Otzh8cr3TZWvrdok+SjrSS8lE4SfTA0Ugf8gCRCPQ0dAPjiYoPjIF5yotUpTn2FoJD1/bEbP5g0WH7s9swYT2+yfx6eW2aQaGWj9sV+NJpwxDqR/w+uIvfpZsrPitQT1ExnqzPwAC9Drq28jNb4wsNAiQVcQmhDDZKQ74AcOvgrrgAxk1tOK76UJfet/WlhPsibxa3RoUPffm/196Ez2cckzqK9xWOX67pPAeQiFb283mfAXKo9vpnGIGBX/OWuW5Z8ouy7wCZkivtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfDxM/8CZVIVty73BxML3RHhZHP6SB7ImKKL5KwP88Y=;
 b=fONhOxYtQfvTL6iQisMJ8CDcrFi8cg5DC3Vzv0+7BYOlaNBFEJGZg9V6uRiCi8iNley4gIimSPD2xZ0XHIJOSDqM7EduN2HQ9pYe3ZqgKnwmaT4oror8GBpQm5Za9xxTPCglnrGmSuLpwdFDblopIvgHTZySiji1hguMujLPo3UTQBoTP9uT2ehzNUfIz8RvUIDblc7ZB2LCzgKucpMttw3VeXtkzdJUJh05K6c0BUOwS5Z5psVd+bpZ02h9zu3t6tbCVvbIOKXWQ2/UL2v9E3Llk95fh8uTzEvQhvlr+YUDpPyx2Ck6dyVOKN52luWDsA1v2WtCbrbvbHZVHGMnAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfDxM/8CZVIVty73BxML3RHhZHP6SB7ImKKL5KwP88Y=;
 b=q4jaHKEUjmAnDNHBtsspXN0Na7kxoNTAlqCh34s8a/XfrXc65A21VVuXDZ8XNpld1pzr7YixcYMp7NNFGh7ReU1qT4IflTN7JsbuQ897wgtWBRK7ZqOSrwyO6vMdsn/ZCsnwuhMmoEvGwbFImpXud0YJHjiEQAvHAko5GdtfFeLLpnnUO4AOVQ/iISi8822vVzuEYxxamje4PBIIJz0m84auYEdyQ5GdQN66uaC2AVEGAMjRfQgE61yt1E7+e2kCXwSoS+6NX8haurBJM6c1BVHsg97LWx1UJyChTH+O9ESY6weor7U+S+/XpfLslOpSIf+ugBJVIh/Lu+JZmHV8oQ==
Received: from BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22)
 by DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 11:29:28 +0000
Received: from BL3PR12MB6450.namprd12.prod.outlook.com
 ([fe80::8dd4:fb0b:cea7:fce0]) by BL3PR12MB6450.namprd12.prod.outlook.com
 ([fe80::8dd4:fb0b:cea7:fce0%4]) with mapi id 15.20.6609.022; Mon, 24 Jul 2023
 11:29:28 +0000
From: Revanth Kumar Uppala <ruppala@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Narayan Reddy
	<narayanr@nvidia.com>
Subject: RE: [PATCH 2/4] net: phy: aquantia: Enable MAC Controlled EEE
Thread-Topic: [PATCH 2/4] net: phy: aquantia: Enable MAC Controlled EEE
Thread-Index: AQHZqb4zE0+3gNH5y0S+VfOwBdv5qa+gPJ8AgCiqUtA=
Date: Mon, 24 Jul 2023 11:29:28 +0000
Message-ID:
 <BL3PR12MB64504E1E36E01EF76ADB3946C302A@BL3PR12MB6450.namprd12.prod.outlook.com>
References: <20230628124326.55732-1-ruppala@nvidia.com>
 <20230628124326.55732-2-ruppala@nvidia.com>
 <57493101-413c-4f68-a064-f25e75fc2783@lunn.ch>
In-Reply-To: <57493101-413c-4f68-a064-f25e75fc2783@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6450:EE_|DM4PR12MB7528:EE_
x-ms-office365-filtering-correlation-id: d522cf5d-506b-44fa-a38f-08db8c393de5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 sl/1CppLdhOh4ePSakoe3BR0ZvMNq45VYKA/zp6QB0NqjWj6Fw4Ibi+BJwyxDWI3QFB3x1YedLHKoh1nBFjB9qgUFV4ofbzJTB2E4RG0bkarjYdfIPP1PvECHtSkBfd6yuyQ0SS3Angazut3+lgSeH6wn1beT92QXBwzSW3exefHvxm42am3a5BHvIgjT/sAcppljbXFGBAXs3DHrtp2Z+fjZdTVQLMk78BBZqwRRPciCi/23qqEb8+1vTg3tmp0EU9swto6ug1R/Iq0DH8/dUh2sk/abEAb28J7JWkzpAcJmMCh5wBcvfsmyclrUqwkPecvvn1i5UNouN/z055F07l70qo+lNb4FCR3nLCOxFyUGHRbj1hVogRI+gTriOJ7+t/yyQigxv+8ipLaxBZkzINyLuPyNw8hatjFKbV9j+Io+FVjV8G/+V5W+DiDuxC8dK8aYHkMZoKfzmxs4tVjGKXkFxklBiQBgH9E7OH1AQQmDRn6CuKyRcA4krK1hYlPCwQWpdGV6GmA+DZh9a+BpfnLp9FRRhfUcepzOs82NgKrYxvsgtmlW/MgwNdVp4xlBwdUI49AHPoB4Fe470PPbo/5hTRaT30yH0ekB5KqVom81Q6TMZkqecsZBcVTL+tT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6450.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199021)(66556008)(66446008)(66476007)(66946007)(64756008)(8676002)(8936002)(6916009)(316002)(4326008)(86362001)(76116006)(33656002)(38070700005)(66899021)(83380400001)(122000001)(2906002)(41300700001)(52536014)(38100700002)(5660300002)(478600001)(55016003)(54906003)(71200400001)(107886003)(6506007)(7696005)(9686003)(53546011)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0sb8CH1Pw6Es8nz37ury7M3A8Ctyhwp+M5ISaCr28XeeZhT59VD1NS46zBWO?=
 =?us-ascii?Q?e9QiDynoGHOARDFN5QeyhZJ26A55ylm63snxtypE1g3hw0t1f4e43beqK7a0?=
 =?us-ascii?Q?8SX+YXMsx6m0ZO5Mwvma7mEMd3GqijDkMxvQx1fUJVw5OsiX+bZjErdy6Qc3?=
 =?us-ascii?Q?VLhBOM1wrVCUt2os5cF3p+K5ffv8iAGyxCiGn0joDwiExEjFj+dvrIuSa4a9?=
 =?us-ascii?Q?9dSZmD8e3LdR4qF6b6/ESH0R+OL66hV0t49HFm/LF/qp563fTQRtsqmI4rKL?=
 =?us-ascii?Q?I76bPIPJbKMqOKooPjy4R7fnWaq3zP18XcQe9JomS4aW2JtG3q81uYnqcLMy?=
 =?us-ascii?Q?fgCMOiUar9bDGATLOIi/tg/ac24kdJZzVjArwdj80JBv/8XRUQ1m0Fhx/qrf?=
 =?us-ascii?Q?gfIy4ZPUIWs0MjCvyEx5gOXEmBZuxCJcRMcOXFG1Qb3DGwfdKC551edvqgLC?=
 =?us-ascii?Q?2/0VehMYALQ55n5yvkKlU4GTKQq9MufTFuEAdr9iFlH3cF8crMqRqF8WHx4O?=
 =?us-ascii?Q?Kl007Z1dgITLENP+jHjSHZd0mkDd7l2w2HSlW09s5if17asfulP4lhLT1W+3?=
 =?us-ascii?Q?dcYLIDAOamNIGExtH2eWvvtVSjBlEg3q/DGqZvRQcDKcsLliNa8oSFSytQtV?=
 =?us-ascii?Q?aXU6g6gflY6x1xZkOx5/MYrfaZis/3CcloOj67ZYtDiIrF+TpzoDYTehHceE?=
 =?us-ascii?Q?50HgrlxJDeNi8BpG9kd1/Iyis0W+B8Dg9tBDoVWyE4PaozHjM2KJ41UmzdSV?=
 =?us-ascii?Q?vjdCVViO4ZN+CGI4O/91nMlIqGdaE9WHnoJj1Rv3aB5vY3Mm7ppoiRPPTbiV?=
 =?us-ascii?Q?beE6GxPjG9aIqKambKFOLFqSYLuqg32BcJyQw/ecgDedwUFc8MStaJkTSyjv?=
 =?us-ascii?Q?DhdxgMnpDMB4mexfrbAynWYJYEYiffIVIZ7Jz7JRZ13zBMpik3llgGzbXuae?=
 =?us-ascii?Q?NSx0oKwmvXGDMC4Emd1TmWNDr8DAjaos5Wx9ix4tvTj259/NJd8fqnBQzGam?=
 =?us-ascii?Q?DPq6Xx7RgkgLXlrS/XSBpTecvEkEnmC/JrmdH7zcw15EvX003FAQIhbSBuB+?=
 =?us-ascii?Q?Ll1DZtQlRpxbiJs0+BR4iroNqhFcT+M4QpSHMCgfHSN0CW6vNQutIfxRt/Hx?=
 =?us-ascii?Q?KGqC5PpVvmnp7+aKd+BINOyFzaqogNH7P28KeVn4qPI/9t3Fs3E6K4yQ4IrN?=
 =?us-ascii?Q?GDsj0RCbR+e5lehYQbf04YoRBo+8c6IC/xRHT7RJ3sC9+8HVI5zc7ypplXrN?=
 =?us-ascii?Q?uImstMROtSAbwwbddN0TgcIK1kQhgvxaAJYYFUZDEnXJmW48+7/xsMWiJtil?=
 =?us-ascii?Q?3+0FMMnAZlqrB9CVqYrPh2I/6mMPKGKO0dYCjUUifXCrJayKGNjI2Oa5dNdc?=
 =?us-ascii?Q?j1ijQ6P9rdDruXExUon5L6O7rV651dv2T90/N+N5w+L2oKEqWKSccDREZveD?=
 =?us-ascii?Q?zLPfCDpOdcBAeRytZJmMBv4iusBjJljAEYeR8G+G+5MX0KryWkFy/IQipKhj?=
 =?us-ascii?Q?TzxST9xiRH7YGyzzNgimVGZrviCQNCU6nyzKLWLwIfr8ACyV9Vejy8HHKDAD?=
 =?us-ascii?Q?BLA2yVF/MGZLGUDxO2/BhGRKEFM3m4+85LtC7/Yv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6450.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d522cf5d-506b-44fa-a38f-08db8c393de5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 11:29:28.1999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PkPOmG4PLIlnjKX1OCo6ajP3EWgv9ESR7eFzzTiIqY7oAQZPe2au1Cm2iQB5MkBtG1ntvn9GA1ryuvMElCWwyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Wednesday, June 28, 2023 7:24 PM
> To: Revanth Kumar Uppala <ruppala@nvidia.com>
> Cc: linux@armlinux.org.uk; hkallweit1@gmail.com; netdev@vger.kernel.org;
> linux-tegra@vger.kernel.org; Narayan Reddy <narayanr@nvidia.com>
> Subject: Re: [PATCH 2/4] net: phy: aquantia: Enable MAC Controlled EEE
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Wed, Jun 28, 2023 at 06:13:24PM +0530, Revanth Kumar Uppala wrote:
> > Enable MAC controlled energy efficient ethernet (EEE) so that MAC can
> > keep the PHY in EEE sleep mode when link utilization is low to reduce
> > energy consumption.
>=20
> This needs more explanation. Is this 'SmartEEE', in that the PHY is doing=
 EEE
> without the SoC MAC being involved?
No, this is not Smart EEE.
>=20
> Ideally, you should only do SmartEEE, if the SoC MAC is dumb and does not=
 have
> EEE itself. I guess if you are doing rate adaptation, or MACSEC in the PH=
Y, then
> you might be forced to use SmartEEE since the SoC MAC is somewhat decoupl=
ed
> from the PHY.
>=20
> At the moment, we don't have a good story for SmartEEE. It should be
> configured in the same way as normal EEE, ethtool --set-eee etc. I've got=
 a
> rewrite of normal EEE in the works. Once that is merged i hope SmartEEE w=
ill be
> next.
"ethtool --set-eee" is a dynamic way of enabling normal EEE and here we are=
 doing the same normal EEE but configuring it by default in aqr107_config_i=
nit() instead of doing it dynamically.
So, is there any concern for this?
Thanks,
Revanth Uppala
>=20
>     Andrew

