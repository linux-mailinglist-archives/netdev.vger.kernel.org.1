Return-Path: <netdev+bounces-118177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F91950E2E
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 22:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529FF283E14
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 20:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB9E1A38EC;
	Tue, 13 Aug 2024 20:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="px8DFY+h";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZO+kMwbq"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F401EA84;
	Tue, 13 Aug 2024 20:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723582485; cv=fail; b=V5sUOCIItD3xjdYUyvF/4SEXUI4QpEXGAV/6eaVEFlcVz07JHjzOSwq6l8u6YgLp8QQ7WZya+dM1nUtPSCDGU9e+IL+ggMafQT4oAWrav6CWDBCFpJyqP9XBCzsbU4281KgeueppgYvLimlKQgNPj03UF+WHpslZ8vBhPrnRfTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723582485; c=relaxed/simple;
	bh=TYQV+jWMFOHT4AiBVKOAvnJTcqZukj/Nx+rETOlzZ7I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cn1pIAjd98K47WwO+ihqRWjIly/kWPpjvHS1bvB2QBTgqyd/xsQlF4bLWrQMA46aDr+pINFCItOaavrj4HkYlJje30SwEXkOddezbxfk5iPpwrsU7gmqhL3zDpc2uQ2voU8k7gEHj6WCQglzrsuP8tUi4pFGBtgMYUNuQsFLRP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=px8DFY+h; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZO+kMwbq; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723582482; x=1755118482;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TYQV+jWMFOHT4AiBVKOAvnJTcqZukj/Nx+rETOlzZ7I=;
  b=px8DFY+htLJTEBJsZ/7W2fSMGQ6sTXX4aKh02OZ2V1mA6FBrgLJntSr+
   eacTYbgHuMmHl6GcytkY8pNqX3uyVGvVP9xa4KcRQiiXRBal71qzQiBBc
   uvWcOU8aXfxnFaNTT67OyC/2VjCAgOEGO3KGTtODDcHXFkR4wyuJjYKJI
   vPo3zyRsAJJK23cfE4zZkd5DuCNYq73P3U8HFzPK8tSK39Gt21v0wT3sB
   kp+JvrOaffOmC90z56gQ3IXZJNAqXGpuGLEAAd77iZjfN+R0F4ElbGszJ
   bF0GxUEGETxfKLroUUGPRr46z0v5oDb4bCzX94err+jADVWiOA5fo32a2
   w==;
X-CSE-ConnectionGUID: timMms8LRLmAz6sXxSi5VQ==
X-CSE-MsgGUID: 1VdXusRGREKdnh18KQv0gw==
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="261369378"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2024 13:54:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Aug 2024 13:54:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Aug 2024 13:54:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akR3BVNPTeIgWXFTnnrkelXm9KiiN3b3M+LoaEm5rz2j5T6dVRL9sOLE54TDybfEA35SxH1TU6KAEXkh8/zpYMPy9uNQk43sAHAkQLe6UWwvO3DuBcAkls7GnR7K42qDrZZHzuOei5urYNDQCUm0a7rJC50JCNZF1NA75WJqPTYrvHPhfMSR+mb1Ri84K69lxYkVDx3PyteenKsJeQI7HUB7+dIzet7IrSYhGLMsNj6Af1dNYr1R592bnL+pABpIcXRvCFFBFAXgJwoYNqE/l05H/yxQKpzDJyfkxx8KBYXRdg0lsJeLgu9cyWyA0praWgptCFWrf9x8z5bK4RvjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQX9JDEL+lFzkM/LnhLAMueXnFPvYDWP4dtEnwhxbeU=;
 b=ozKSsSTygRVrodhkRQRlt8j1E89yNMUVCm5ndx5OXdZ76cQ8i6aMdpFcR+0gVI57qvl0QiUl3/22LP3dHBLkX1IVb5T7AqaYyfsdkQgmOOCCKddgwx97ZaCoc3OTN2dEGdqGPwfJed1AA2C3RbO2XKCnJP1Vz3jpWgkc3BCyrNXDTPVsMG0LP3X53x/Sad2cP7WvzDaLDK3mF+sSw4jixsnpkWbSQALxKS/RXkStXagXBScggFlq8wKSRONfZXlLuZuGTnOKy94FgUzE6ka4TJJpzJXy5ulnLsf6DcfL2j6UeEAQ5afH1HIdz/GKJDFJrfuVVH5ljz8ZSc5cmspYtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQX9JDEL+lFzkM/LnhLAMueXnFPvYDWP4dtEnwhxbeU=;
 b=ZO+kMwbqoCarZeWV8zCS0QGv/PysCJnTg+z5DfMXGD+PFXSBp2DT8MoyZ42d8jO3GxYpEV2g1p/n4W5JnUUoVfeVgAk4WnkgBEX2ir/Hm/TlUsOJldRGDrMs9jRjS9PVY8KrpkbMeiDuMC8kbQ3eXvydgG0ok3jcyN7Ar7CNTTpzHOU9w1ZOq3rwWf9dVgUzJxP7n2ylQzxHreytSFKD1fg3dy8WVjQbplLCYFdoDHhSQIO6VdisnleXc0uAv5U2shB/AP9a7GBup0+YOC4JzilXpE/EafSUuiGrPVzVz3AfR7Gn3hkGZa2Ydtedfwdo05yxgkWAoaK0iTpBN/JT9g==
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by MN2PR11MB4517.namprd11.prod.outlook.com (2603:10b6:208:24e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Tue, 13 Aug
 2024 20:54:04 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6%7]) with mapi id 15.20.7828.023; Tue, 13 Aug 2024
 20:54:04 +0000
From: <Tristram.Ha@microchip.com>
To: <andrew@lunn.ch>
CC: <Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <marex@denx.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 4/4] net: dsa: microchip: add SGMII port support
 to KSZ9477 switch
Thread-Topic: [PATCH net-next 4/4] net: dsa: microchip: add SGMII port support
 to KSZ9477 switch
Thread-Index: AQHa6rVcEZ4QnCCduEOREErJuDT1TLIiQrSAgANopCA=
Date: Tue, 13 Aug 2024 20:54:04 +0000
Message-ID: <BYAPR11MB3558D74540EB07F85B07ACD8EC862@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <20240809233840.59953-1-Tristram.Ha@microchip.com>
 <20240809233840.59953-5-Tristram.Ha@microchip.com>
 <ede735e5-cbf1-48ea-a93e-1b4f21a48a4c@lunn.ch>
In-Reply-To: <ede735e5-cbf1-48ea-a93e-1b4f21a48a4c@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|MN2PR11MB4517:EE_
x-ms-office365-filtering-correlation-id: e367c5b8-fd11-4890-6886-08dcbbda111d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?x2wZ1pTAsjMv4S8m7s/wFzolqzuF1rVAqLkqKay+iED/J5Ymw+9pReyPDJKv?=
 =?us-ascii?Q?OI15kdg8ozcWRWatHx1Dc8zCJB2O4IsgQs+JFD//WBI9ESdD9VgFA73sEe3i?=
 =?us-ascii?Q?Xx+a4YSC+O0IPWmWSHEZmolIrTL2Y8vWRg1sGgyENoFVtOqJnT09DEn8HcnY?=
 =?us-ascii?Q?TstN+Fiwqg1S61zdia19QlPfh34f+lgmFECLIOxyB6rgdgDSAdlyXnX3MkGU?=
 =?us-ascii?Q?P1jVXx/KO4jfQvy6BBTnKSOZcNndGsZCB/2VIiAma/voEwKe1zdstO9e0nEr?=
 =?us-ascii?Q?SLvL6BTE1YN1P5vjWFO54sVIQBXaPtLNy2RrUo7CItkPMxxbePbFHiEocwkM?=
 =?us-ascii?Q?JfsS8LxP16GtTXLRwb7QWhotCOIR6o4W0KmV10FVxqi8N1wY937njR6aBbzW?=
 =?us-ascii?Q?t5iWKvtAGkEMeAMzyAKtd7UnhWTKkKOu/+3lRRxH1m9P6PyN68wDSOcnpLcL?=
 =?us-ascii?Q?HiDAnszFTKQa25vRZSRtKmrUjDbd81KosQqOy+GAw/GI4zo0u+l8cflAaeYM?=
 =?us-ascii?Q?l/UXDsY5jFxF+lr7Fi5+KDLdrQ57Ftxue1pX52cU6TYLrbcLrxLzboYpplC9?=
 =?us-ascii?Q?osjLvr26SgydtTt7r6LXAYr+wE+W+M6XLxBnyDQZs7F5abOtdoKIDcANDx8Q?=
 =?us-ascii?Q?HH5/i2CbnZyJbjRZAp8n1qaymD7IKJeSU/kx8vo70lPtGzc/kso77AV3J5+M?=
 =?us-ascii?Q?kjoMK9zRr9R0GIdsulxwYyc0JNutghBfYS0yYwNk2WrjQuHjyuXorsTqrM8b?=
 =?us-ascii?Q?rasWerjynz7DMMbVwcPE8893qU4gQMvbNeY3SrtHPZ+uRaPOwyhEQfdAp08m?=
 =?us-ascii?Q?/bXB6CK2M32V2upYeis0u0q+RkP39yOBiulA2+86Y0/DfPRzNmYkGfpZbOXN?=
 =?us-ascii?Q?lQEc4eTxgRzDVmgKjNKBT1swosAhG3E/JJGZuzcLYzV/cvS63+h80NmCaCBg?=
 =?us-ascii?Q?E3EzZj/44REzshK0dRqYLewMjDV+vK9jG/4oNlLtcC382EXjyvFH3FAgWq1S?=
 =?us-ascii?Q?eLFCALnpDWxLidi1q2ROq4ISD4S493DoLHZj7tBni8/z7u3RJO1TueidfkiO?=
 =?us-ascii?Q?PvEHb4g1k4BirvR9SNvdWbSSBdkby5CRDeKIgyXLLZWzD0gFpikfubTJfyGg?=
 =?us-ascii?Q?lOcatle4ZZiLllMKr0vn+KwJXGcWQWXc/nxSlvq0zgTXjQEirnXUe0kPqpuK?=
 =?us-ascii?Q?dTRSMFdIwgFms/4NIFtKF96pxczjWKxfiVVk+8EL96ZJ9a3nEBPk5WPbi/mO?=
 =?us-ascii?Q?nRPRRbrz9i9JzM4k+DreTJBU+u2MAhbXC/wkq0XPyfbnrKeUs4DMLWNpqLAR?=
 =?us-ascii?Q?7mfKpdVWh+YWS0mT9LQj+uHgRkxq5bUmufRnWKCJ/Z44K+2yvGU6ROk8vEpA?=
 =?us-ascii?Q?Zn4yKWJUnRkKID8fvF2++BkNekAQr7LMxBg6oTYNlaJrdbYSNw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xhAAwW5L+IbQoL6JQH7ngPK535MS66tSY2b0XRTBl5nYwAtd2E2j8pxET/9X?=
 =?us-ascii?Q?pQvqvhuvAk0F/USRzTFlZeVqWU2mCCsacQov8k/LfH/ZIiEhLiw+3CWSRHyf?=
 =?us-ascii?Q?EIcXKUMs2EGXTlbu28vb+PcTD58lPKCpZgRJ14A7PcLmiuNnUTE694BqmPRe?=
 =?us-ascii?Q?IhAq/sy51wq3XWwcFIT7tnrnvwmvXctQNf95QWIbBc3X7hIjxtGm+lrrc7zb?=
 =?us-ascii?Q?oiIApvYAATP5ByVpgW7zqoRG15MFGA4n1J0lEJlVPcwr91Yplx9oylkQACfs?=
 =?us-ascii?Q?CHiuQsQizzDZkJ9IMZm33M6LEkjjowzgHcDtvON+uGStGUIk7s8a5ID8ay57?=
 =?us-ascii?Q?Kyo2fbz7OC6nU9XLUOXj8p7VsaK798SkQdHrJJgRDSnEcYjrSuYHzkZOXc5k?=
 =?us-ascii?Q?VzOPaE+Xo/9mAKzSiIkRZI1nCacKF8EaqdmmxtcJQANsdRkhCWOwHdyKMP+v?=
 =?us-ascii?Q?GpSMGlz37DGK19tg7wzSSYbIajLU9147pLNxLvS7I+bBxz6PwoXsztTLazq5?=
 =?us-ascii?Q?MCrb5HJgaA6tu5mmi5a2QfeURC9M0S6M9e7P45ONd+Rng9w6gwxy3dlbb7JD?=
 =?us-ascii?Q?XEW3p0+ldEpBXpdmQpIHaYuDYqyuIvPhBy9sDihyDCFAQb/iWcGOpL30Fxk2?=
 =?us-ascii?Q?5DblX953LvDFvKX1Zn+FjB8hN2nejh6aoBF+I82TqjFSyMTad3ZGO7Q8dvM0?=
 =?us-ascii?Q?kzMowFXFhRSSYIPipFJY/m1m6ijkl9xPJ4kfyquT92Fuprin2irwij5OjoG0?=
 =?us-ascii?Q?//jM/cPfsV51BKLoensRfXoN0lieScD/kWjUejyUTPXWRWUM9adn5JA5+TUq?=
 =?us-ascii?Q?AMPft2jVdp74L5adRT3jHP9W8h/sPmJe1vBILbTiVJrbWUbRtD0UOzqjs3Fo?=
 =?us-ascii?Q?3zNEXCd7JGT7/FZwpmhxa4DBqeOtOyBZw7xOB3HBkjce6jZ4S9WtjczFT6ao?=
 =?us-ascii?Q?6voR0VZj/1XuG3FTpmi5yQWXL43Q86+RgOlgR+gr51ySTSCJ7BHyrW33Hkco?=
 =?us-ascii?Q?EB2Zu1Jo5JEzuDsXnwPWXVem2K59jE2ll+hqW8TdWylH9/0IfbojeVIPG2ls?=
 =?us-ascii?Q?QLu4tHKan2ytQurxJqQolHnvDVSJqxx7nTgKcefN96DS9xF52JcpFcj9yYXG?=
 =?us-ascii?Q?cgKkMCiV5B1v9buFQFF9wtBkn7njcvgiYL0oO5Cv6Q1kXii+zEXkJs1GP7pt?=
 =?us-ascii?Q?L5caWSj2nG4GYg71BMi62fr8GR+VkcHBOeGgJIQDk3dAuKr/YhU3XXVakb1R?=
 =?us-ascii?Q?GfDBOmV1szZtpvFIZ8bctfKZfrz8157F6IaFaBy/CYwuCua1cPKvIapFaVFh?=
 =?us-ascii?Q?PNhFCn6Ahddc6n2tIiCcWpDnbfsusmtrZOKOjVct5MYqXSN06PQbvlubMWEO?=
 =?us-ascii?Q?6Ynn4/gPzJpPVzqWQ9mfeuoiNYpB7CGMqBdtio+XddUi81JUusTpiy1LSk/K?=
 =?us-ascii?Q?AIwiAfwJxJWnWGoLr+4PraeoToHBQKi+v0YjVvnwY6og39pv+l9MGne2ZwhG?=
 =?us-ascii?Q?I4w66eo7ApOEmm+qnYkXwr+NAuGEpcbJx2zTPBpDC1kUbCJCz99MXwybwXK/?=
 =?us-ascii?Q?+DNxzHthumTSSL5rUSV/EOGPGaQR7xW7x38uoYuV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e367c5b8-fd11-4890-6886-08dcbbda111d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 20:54:04.3989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cDWkwGUif+wcfNITvUon8AzF+rOq05RlCSS+wlL1TYYqUYAfwCWtbpndQH4ugIC8SaNBrqUob5Gxyp35JR4eh1UYhYnry48BhNiEdS6xw/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4517

> On Fri, Aug 09, 2024 at 04:38:40PM -0700, Tristram.Ha@microchip.com wrote=
:
> > From: Tristram Ha <tristram.ha@microchip.com>
> >
> > The SGMII module of KSZ9477 switch can be setup in 3 ways: 0 for direct
> > connect, 1 for 1000BaseT SFP, and 2 for 10/100/1000 SFP.
> >
> > SFP is typically used so the default is 1.  The driver can detect
> > 10/100/1000 SFP and change the mode to 2.  For direct connect this mode
> > has to be explicitly set to 0 as driver cannot detect that
> > configuration.
>=20
> Is 1 actually 1000BaseX? An SFP module using fibre would typically
> want 1000BaseX, and only support one speed. An SFP module using copper
> typically has a PHY in it, it performs auto-neg on the media side, and
> then uses SGMII inband signalling to tell the MAC what data rate,
> symbol duplication to do. And maybe mode 0 has in-band signalling
> turned off, in which case 1000BaseX and SGMII become identical,
> because it is the signalling which is different.

There are 2 ways to program the hardware registers so that the SGMII
module can communicate with either 1000Base-T/LX/SX SFP or
10/100/1000Base-T SFP.  After a cable is plugged in to the SFP the link
interrupt is triggered.  For 10/100/1000Base-T SFP the connected speed
is also reported.  For fiber type SFP this information is not revealed
so the driver assumes 1000 speed.  In fact 100Base-FX fiber SFP is not
supported and does not work.


