Return-Path: <netdev+bounces-54255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB218065EB
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 05:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE5B1F21610
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4EEDDCA;
	Wed,  6 Dec 2023 04:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nqI2kjGx";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eI6e2A6q"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8011B9
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 20:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701835202; x=1733371202;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=wsicBRZJa+pR6CZduRyZfgC7ojlAdxgvd3LQ70wiZP0=;
  b=nqI2kjGxWImwRN45de6dE2iujOEHcYNoMnT1R7VNEHr14PbqbnDcoP2j
   lpjZWFEAqTfyGr37vLExcwTfGbkRijeR30hHipfb98F+X7asu9qVrmWxD
   9SXtYaUx0AgUoUzBzk4rsOjKdrr+aBzi0nwgCBZQRJjJRO6gST7T/g+CM
   xRvkdz0QFxyLBbJ2F71K24MtTRdBAip+ptCcZHswRqbYinIa/cty0LKTg
   MfOWgzg3Vp01cLxUmSEfPOaiNEzC97jqqYdl8AXTjhEeQ25jD12Kmv7kD
   uUR8wniR1fbY+SQQVP4SzNC8tbzR72OvINXux0uyL//JUjR5E85LacK3i
   Q==;
X-CSE-ConnectionGUID: APmyYAXuSTqQ/3ShhI58qw==
X-CSE-MsgGUID: 8HWXM9Y7S/uGo9txors9Sg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="12834832"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2023 21:00:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 20:59:36 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 20:59:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEK9stdlZl5/mDej8agrxOZsgLDfiDlQ+L2HafuktFeRczxNw64gI0D2qh7s/mHK9e87RspMILqJ7VggocM9EIYHkyrmshaQn4AmVNErJQ8tWtF/CFOdLP50hIbnf6dDW5aku1Ikq/y6Cyvv95UN1N7UCTbLuZJoIjkx1IYYSIfn4nMUcRNd+65kn62inI5VRrvytd56HeQp+ypBBCXQHR9f0cbw+RngcjQKEoG7ZzinFiuAUrjzfK9BHu7eoP+ev2xViQxBh/iJ7e8ynVF6ShK9D4lOiP3TnJBXqMV58nmRgndWON5QXM7FKTxVBQ8wVdYijnHpfRHOJKqJ1y6+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=all6E2O636XjBSYlJOO8ze6d5vqNGC5p05jhPXpDQoA=;
 b=eS4EmejK3/X4lS7HmnSQneblvlJl/L8CJ7V4UHYDphmpUSCkH6MMJ1O+/ax0HYiHrBCEl2htSP9gm291D1SIL/RoPwzsQkIn+7xudlkjOQ5KAQMzzSU+G1QJqgqxQL4R13GW1xBTueYQvsRl52112Xe1tspWiOGzcCB5k7Pa82UP6hy8xvzOgQkiTTx5wdVQ0J235YqcCeEDqdR/8zkcSyX6rIscUPva1ds+9rPSmKn5n205q4tXGTixVbc4YbRcDSgqn43loYIWz+mWE5cEKvlLWJJlKWgbVscvIt4SS0v/Sondn9You1YbZ8vA567+MEOz4O9MJbF5vIalIrJAxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=all6E2O636XjBSYlJOO8ze6d5vqNGC5p05jhPXpDQoA=;
 b=eI6e2A6q+WoELOcpUT2kgNccTBhVTbOZH+hKCRJ0sogP7c5FJPk1XRNL5LcE97nIyVsuIxmMMnyG+Uc5M+maOH+arJ0E7c41lAh/feCtS/3OP805ZJhqQIyPdF0niS7MmnE9et/6juFKm/JZ7nvoMuDX8Yg+UhWs31GTpgR2IaLEXHZbYK+PjruhVIFgUqYz8rq5/H0mL0IYEVIvTrwwQ19jAPgWr+6xIdZfK1BqUJ0ZGHqhXpJr5CPvNoc8T0URb8hB4AOjSCkOYOeIcyDFRbyHO3H4tnn3RQDQFsh1+fFlh8RSDupYGxbMJfo7ZrzUWSZMdQIEiAZbObhW4QertA==
Received: from DM5PR11MB0076.namprd11.prod.outlook.com (2603:10b6:4:6b::28) by
 PH7PR11MB5888.namprd11.prod.outlook.com (2603:10b6:510:137::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 03:59:34 +0000
Received: from DM5PR11MB0076.namprd11.prod.outlook.com
 ([fe80::4f7c:a191:fa1e:6fcb]) by DM5PR11MB0076.namprd11.prod.outlook.com
 ([fe80::4f7c:a191:fa1e:6fcb%6]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 03:59:33 +0000
From: <Arun.Ramadoss@microchip.com>
To: <sean@geanix.com>, <Woojung.Huh@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <ceggers@arri.de>,
	<netdev@vger.kernel.org>
Subject: RE: [PATCH] net: dsa: microchip: fix NULL pointer dereference in
 ksz_connect_tag_protocol()
Thread-Topic: [PATCH] net: dsa: microchip: fix NULL pointer dereference in
 ksz_connect_tag_protocol()
Thread-Index: AQHaJ3kuJSyKh7cBwEKdBSNtBVmIlrCboPxA
Date: Wed, 6 Dec 2023 03:59:33 +0000
Message-ID: <DM5PR11MB00769C50DAD42239813F62E9EF84A@DM5PR11MB0076.namprd11.prod.outlook.com>
References: <20231205124636.1345761-1-sean@geanix.com>
In-Reply-To: <20231205124636.1345761-1-sean@geanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR11MB0076:EE_|PH7PR11MB5888:EE_
x-ms-office365-filtering-correlation-id: dbd47cb2-d6d1-4383-b8a6-08dbf60fc1cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bMgV01lS+u4kM4+SZ24iHslLI4AhWNJ/li25hHi47BnHxpqVJbuOcMTiM12Zzo4FKuPQaxnGVd5Kqpt8U3Yr6qU0e3oog4Or1v9SuY31IlK6yyvSuAC9jkz4VOCwvSeUUomBwByVDXQWycjUDntmn21wSoyhC0PyS9j54NXRCoA/GI08229qhPfK+jvGpJhT0w03F8onmecpSr9iw9EjRTpiDHtiP4rFOBrMtZftEPkNjf2h9nEdHcYnhum9Uk1KqNxnvgI5Fl1/k31azlSmKPWs6XrQiLTWtB2a0Q0T5WAvwjZczBgAHUYv/LkunnaZW6JChhJMN5BYJTN11k/Ue4EJ3ZIHemoUUNoakIZWoT0M2QDv5CKlGduLwHxAbmx0d4RkAQqiLSnjhZIDhnKFIqu6SL4xCamfL/FOVvQVm4HBdxiMF226H1Sv6t5pk41ZK4UHI0F2WUQPcoAU+6TAN3c/xEM2AgG7c/nK2Urz98jEIf8A22RCjbwNHXq7PJiM+inliFJpOYnDiuJv7dYtwihG2wCr9HcQ6GIYUCaExrum4RAQmsIa3qcgZWgjz1JISEeGCU2EtYF4tyhJLb6mLfLkRnBqCqe5guj/Laag2PgRqG7P0rMqE4FHDqFOUqAc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB0076.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(366004)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2906002)(71200400001)(4744005)(478600001)(8936002)(8676002)(52536014)(86362001)(66446008)(66556008)(76116006)(110136005)(66476007)(64756008)(5660300002)(66946007)(55016003)(26005)(83380400001)(33656002)(122000001)(41300700001)(38100700002)(38070700009)(9686003)(316002)(6506007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mH0PfJFsf+7fdtK1BIiPFUCJmTX0dVDbVTPg1jL5G+c70B2rWqsdF0yMILH7?=
 =?us-ascii?Q?FoNzV3poxeidioiDWVN6L6I2tqP8fKelRqPhCcS0K8pLdDSZVOtdPztZNDsu?=
 =?us-ascii?Q?UYOkwfUdy3L6dp8zt0odqm1gt0rK770UTfk7B2ZzheZ65xocA1H1EQPOuGu9?=
 =?us-ascii?Q?gfkNXaNe5giJymTCwtCpPiqCxhtRmXCOk3L80wqUTA7zkCgdSGwLj389QG/X?=
 =?us-ascii?Q?V6xNyZMPO4+1BLAOxikUvX02dYfnKXteNBt6s8QOyOSP5cepQ+hzmfNQ9vA4?=
 =?us-ascii?Q?bf+ZmHNBoSzeU+pDlLtm+GLgR+omxs33Q5cPYjjQfNfpyL2LE5wPhlY/pF7y?=
 =?us-ascii?Q?TXOZsAHFpnP1PFtdQ+uLGp9Acap89igzHnAyMSNOvAli8EMOUBMiZaMApxB8?=
 =?us-ascii?Q?hasQWwsOJQ00ZMbLJq73j14LIBZ2U1JQOoaf1RCKlYGvbNgczGv1UfVg4aa5?=
 =?us-ascii?Q?0w605JMku65gLWmGzl9u5eGWztH4L6/aZ5TR64tKKVYstW9c4Mo7iFCmD7NA?=
 =?us-ascii?Q?W7dQGJRAk3MIQBEccTDsgiVuLRZdIcY6ftMroOBdfho1mrP3muAQnGv3gq4y?=
 =?us-ascii?Q?mH+QHl4EZGSHcV/QzlyZoMIZesBrkiDrDbfkTOAaqpyqslv6RbCErMVsgvnd?=
 =?us-ascii?Q?WxcoHmcJmmQXGyQpTmWU035TSiLRzuZ8jZfnxob8sODigmfUEUxUV3+GzlQU?=
 =?us-ascii?Q?hwc7DCyY8ugbhMMVuC78rb/uPmI9HQoDuu1iMn841uFRFtbPBK33oRsDnIBS?=
 =?us-ascii?Q?TMd5f6eoV7wD9FZrx5seprPgixvodixEV812DRj9sUZv4Pf1eeINeP0KGdIm?=
 =?us-ascii?Q?Vg2qbUNQuP3vrz17KqlzGPQIW6DXNgQPFT9bva0L+tQqgXOL8x3h8UTa/3ZN?=
 =?us-ascii?Q?d+ly1ztqk5BFW3mQfbDj9qi0sBPCxvE+41SR3KkyvmvbDsXHe7FuOxcVmE/K?=
 =?us-ascii?Q?Mta0+/QcUClLgi/K4XcT2yqcuJftvMwaWH/Uf0pvzeTwRv4B710bW6jWESMW?=
 =?us-ascii?Q?3ZS/weDp+PvzDczLIC8cOcimyKEraSm3cjE4cFrrIdPrO6Q/OL3GYLBdVlCt?=
 =?us-ascii?Q?u+HOEB9uec25GWDQAYexgmSwiRACbs8auI2RG4ojpLBc6VgAV8byilQMSA1/?=
 =?us-ascii?Q?k6I5HtifiI1VbGmf6kQjaeKELxIZnyA78FPmkGI/S81g5CyrWblWQkSLwJHJ?=
 =?us-ascii?Q?qg9MYWsg0Ix0wKfsuf6c6iGlAllyBN1uveBr4sdUdzjdYylHy6MhwhpAJ9p0?=
 =?us-ascii?Q?oxwakBaxeMUffaXSkLJKpWJW+8Zmq4UIc1OeyMEPdBt3O1p8vZaRq3S4lfU9?=
 =?us-ascii?Q?chttnB5mRBGpzBorRk0QI61L7lseVRFk94tklaeLdoEoyGGJQjv1yDL3P1Ef?=
 =?us-ascii?Q?r68jKNyMGrbBXUcR3IoxdWvs5HAcQHOATCTbzlbyvcJRTa07MOh9TZIG1jMt?=
 =?us-ascii?Q?m8jAkYQrp9eqgIcQNTHWb8qDG8Faw5GL4te3qYuio+IjUeG4+UlKHpmLueTK?=
 =?us-ascii?Q?KHR7mhMGRn+ARe7kSF4Cdf61xLQB+j4d7BhkWW+XmQuw9WRGTBy512IhhNad?=
 =?us-ascii?Q?62+FpNMQ0VDOHUU6Zjoikesh8r6vEqgUbpE7oFwR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB0076.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd47cb2-d6d1-4383-b8a6-08dbf60fc1cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 03:59:33.9316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +5jL9iO/2mMPWvvi8lZwU/SiajMoj8B5aSCtdFnr7VePE4pwPqOqQrgzIxYefNnGIlCS7+yihDdz8udDGULO/MJPQaEu0Sj8dFgtsbZ67qg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5888

Hi Sean,

> diff --git a/drivers/net/dsa/microchip/ksz_common.c
> b/drivers/net/dsa/microchip/ksz_common.c
> index 42db7679c360..1b9815418294 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -2623,9 +2623,10 @@ static int ksz_connect_tag_protocol(struct
> dsa_switch *ds,
>                                     enum dsa_tag_protocol proto)  {
>         struct ksz_tagger_data *tagger_data;
> -
> -       tagger_data =3D ksz_tagger_data(ds);
> -       tagger_data->xmit_work_fn =3D ksz_port_deferred_xmit;
> +       if (ksz_tagger_data(ds)) {
> +               tagger_data =3D ksz_tagger_data(ds);
> +               tagger_data->xmit_work_fn =3D ksz_port_deferred_xmit;
> +       }

Do we need to return error in case of xmit_work_fn is not initialized.

>=20
>         return 0;
>  }
> --
> 2.42.0


