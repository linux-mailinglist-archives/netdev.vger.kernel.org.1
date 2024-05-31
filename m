Return-Path: <netdev+bounces-99828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D23D58D69B2
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 21:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C211F217A7
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 19:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E3C20DCB;
	Fri, 31 May 2024 19:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zqaWfS95";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="J51wZAOy"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAFE1C6AE
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 19:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717183365; cv=fail; b=CDy4c4SwZpRoAAPRNHULGoEjuP8DCZTCxLWKlyWxR52K/hG19Y5HLU5RuHTUaWsU8E9EtvvInuTdVPxFnyVxhLdmzRCPyHAuRE109jsUl36kbhXv0PqWzI0zBq1uZuBLtfd0+0qTrTPcrStXb1NxSlgzwz2cGvAVaY/RTXzhw5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717183365; c=relaxed/simple;
	bh=qEuzVMcariOurt5023AOLWIoEJLwF4hf0lAy4nXo7B0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NKQo46xO087k5QOVUp52DTh4p2rd4ME5ihc1WHOt83WTjiHxg6VAK43R8HsmyOKCe8+SpLGIoNBwLKUFG1LP0HI8/FmH6kGZuPH+8NBdtUX6k9L8rYyxZYT6UF/qKCLcPP/1P11KI4o646HMihiKWfzhwWVYiRfzFRr3oWse+q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zqaWfS95; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=J51wZAOy; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717183363; x=1748719363;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qEuzVMcariOurt5023AOLWIoEJLwF4hf0lAy4nXo7B0=;
  b=zqaWfS955ZxPWgciHDkuvU3I8f66cXdvo7vA+bmpUNfbXqOpDYQqsel4
   ImfgZcdCw3lhB1mF5UcI5frVjtaidEV/MTmOWHyi3zLlb52pMa/PIQKJd
   /w3b5oG0/oEY5b3ADWYMEU/CjlX7Veg6M3tsH37skm/v/S42XKKNJjuaR
   DgVJfEuMpkEhL6apS8v+dAkIdii0NQCjBI4KofuWNhOrSBHzdCtQy8rX4
   3xsMyuBkVdQIrOTRmMVNvCk452xlpLUqWtfqpZwpbwnhnLIxUVq6sppLx
   mdOTnfSEyRv4I1cw1Pb814Cfy6m98nT8vaEzHa9f+lNyfKlKW/1ePSbQ+
   w==;
X-CSE-ConnectionGUID: ckiF1CeZSMWBlbZXoguXtA==
X-CSE-MsgGUID: 2e5x6jEXQLG5K2d8u53iaQ==
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="29181176"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2024 12:22:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 31 May 2024 12:22:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 31 May 2024 12:22:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJjPQNvuxZwHcfcDSS70b8ZgyG6+HU4xz8vlIaqgDzHo0gGxh9e7EvDmEMXmS4PJumWjcqE3EVgQ96JebQN8F3ETvYM3suW90pMgkKe3jf5DKKwUtA2EJH0BCuySqBush1CDGBRq/ef4iD5IszYwNKSp3TiwVIdlG3EQXMckx6QEN0uGRAo+mOHr1LypGJfttcmExkfz0tQdTh2N7SDlhoBkYYkS2OGTePBoKg1M2sV9W33TNzZk6pgE8odLQa/MbBT0+xHi/p434F1UHMZwVww/7d0594JJevTops/5r9RoSadKAPA+9YdryPDrQUEqiL4lnbb3zKWpWA+YlqjZww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lh/mCkpA30aYJLjbVWjln5VpKJfJSxoNiRrZEPOHehk=;
 b=VwHx4AMQPMRa/9DLXyOMvp72vp8pdk11v2NLBLAgAWC5lmSoTzvSuMEaNr29miI548lD4skjc2MKHqGl1rR+DIP1EyuLj7X9av0YFqaa6yUNjFh1ZdMeesr11xPCAs+yxEajIIiFWEsp8XJz09ZFjwCSg/7lglbktkBLY+Daa1meZKGISksJFKReMHvCMe3TnYC2xaVV0rrJ174HTfygVu4SnwGuk/rIg+nMTgHWrV+3p6ERzvplCNE7F+lTPq9R/ChoNMVzmCWfm6fPIilGf2/ksOfL0EZOwO3jDGK0JhWbcvL40kjCBQhIWN+0NcMdcCdKdNAJ2w2nSCx3gxgjvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lh/mCkpA30aYJLjbVWjln5VpKJfJSxoNiRrZEPOHehk=;
 b=J51wZAOyra59cJRrUyASZtKhrxBLEcwd4So2kCCccS3egx1lEotp5BMkypksAWI5tbPUH/JBbTJtqkAo13MIsQWBmVO2IurQClqqSYGwaACSddJDDxDj6m6ibEqB/wBtnGH45OzgBaKWMrumhXIX8JUUlfU3FJFNtWzxsv4gwoyUgmnGW56XY3RvpD9d/NnYWbRVaZyrAlfGdK8EkijGNYMk+PZEkQfp+XkwjCj6iGyTxQDM0VKomXHGPpekM7Stv53eJf71dk4ZYrcV++in18v8ZabDkR9In/NudewXaxlOjjo9g8X27uN8n9+kBcDm6vrw4doruqF/QNnCldowQg==
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by MW4PR11MB6713.namprd11.prod.outlook.com (2603:10b6:303:1e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 19:22:24 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6%6]) with mapi id 15.20.7611.025; Fri, 31 May 2024
 19:22:24 +0000
From: <Tristram.Ha@microchip.com>
To: <enguerrand.de-ribaucourt@savoirfairelinux.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net v4 2/5] net: phy: micrel: disable suspend/resume
 callbacks following errata
Thread-Topic: [PATCH net v4 2/5] net: phy: micrel: disable suspend/resume
 callbacks following errata
Thread-Index: AQHas2ZgRTJcrl+8QUWBqUy02CDO37GxuF6g
Date: Fri, 31 May 2024 19:22:24 +0000
Message-ID: <BYAPR11MB355807D7460030E897709AA1ECFC2@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240531142430.678198-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240531142430.678198-3-enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <20240531142430.678198-3-enguerrand.de-ribaucourt@savoirfairelinux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|MW4PR11MB6713:EE_
x-ms-office365-filtering-correlation-id: b208eb6a-73a8-41e9-5ab4-08dc81a70057
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?15ufSje8lED+IY6kz77dEsbu5BI+u9ZIqjFMEWyVdkILNhTAQxm3BKAWqYyY?=
 =?us-ascii?Q?RiTchd4KOEEwlSu7MS2A/DiWujeD2J90/A7tx7W0LNevHTSgq3ljlxfGMp5e?=
 =?us-ascii?Q?qDkStbUqjmNxzkvpnMjvHnNdNY+mEnGaiQ/MUhyxYPNlC7rDqE2lUj+9+2Jp?=
 =?us-ascii?Q?ucum3mL2OflBtJqYE9jfVN003ZYHnn5yKbywYWctq+m966FOCXlMFQ7RWVTW?=
 =?us-ascii?Q?Dfdq0LY4x/uosECKQmWV/ZzHAJgKephZaPgxxmUnczdKXgEwDkTmeVW8spUN?=
 =?us-ascii?Q?uRZILpu2IUHy/Jyn5Qq+XW5FascUvcQxiqAsH3JzZeTCcUp+//E31AVsSvkl?=
 =?us-ascii?Q?fazhJ2TkkTpBwAxM51MNAxwCdY6Momww/xPqe9YcpBQNSYJJ227kgZkm4T3T?=
 =?us-ascii?Q?TMQaQk2ikWDAhJY5UwZyBoTecYYHrJJIYPl9sLlk6EsACEnUKIC40t0RLlZ5?=
 =?us-ascii?Q?/sdGffuob/lg4uZW0vqCXETRa3HEXjpIMcFFhJpeAODg5dCkFOQuu/MxQIX5?=
 =?us-ascii?Q?ChKzU5bxnYNR/nkGurHKFSN2j5KI7hcqOt48lzVVKn/dAYLG2QBcmBf8zzE/?=
 =?us-ascii?Q?OQVhJJxyl/JDxQgU1DJ6pVancJEroyaIvw72Z+ORSjcy40zNIUhtIsO3h3Nh?=
 =?us-ascii?Q?30ZlvCwc4Grf/LPncM7KfkqZJLN2wmZmeD1J5PeYeHH5qbuaLBv2Nd8mR9QL?=
 =?us-ascii?Q?OFq+vpXYC+dXb1Z4mPFaMqQlo1efGfMA7HK0Jw28eWooU6VZbXMbKEIwD5Op?=
 =?us-ascii?Q?kd5/6X7iwYNaAliFurJbMfSg6nFAbm730r5dtLfjY9eh3tZCY/8VRPuhYAQi?=
 =?us-ascii?Q?iVTfJzPhcHqODfWOhPt88fdtg8j3MI0TrjzL/PAOFKtLA0Cb9rvLuZd0dDQy?=
 =?us-ascii?Q?4BevFnj1x1gwgS3dxkSkBp8S+VrW/Uv8UJPnI5SJHhOjmbmh9j++mTbPOc+B?=
 =?us-ascii?Q?Ko3E/RP0qs5bwHaX5+NDiItzPlzswipQI+p9oowOFnfg0iUhLeV4bXJKUM1R?=
 =?us-ascii?Q?3kODvluRElnLO5uhCylJ7tS4DeM8iI3dR5mRvYK+8Qc5H82wOMJ3Ycq2GYWR?=
 =?us-ascii?Q?J4giO7op/x5a3VxPW2kef3EZ1A5E1MCfvMkbuYVzEwfMWgr4tYjeRw9Bx20U?=
 =?us-ascii?Q?2XjksC7Gu+WBwkuYgQ/ieMusP6cUPSkaBzOLyy7MylJzBE4E9bk/I7lk3bP6?=
 =?us-ascii?Q?zNUSC0GdPLBT1pL63b5N278TK8TWB2PQDTNXKQPv9Fmk59DDHIVAWYgCT7xA?=
 =?us-ascii?Q?MIAQctROQirXAgLLGFSa6/cIXjfbsa3vMeeQ2vCOxQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eQyd+AoKRwyiWCw+7k+3XYm5bnnANJ5eiRiGLrAOk7XBndzMMMGRf3tmS8b2?=
 =?us-ascii?Q?BavBJWlFArtAmoouFVWErX/SJG7jiznp+y8HKcQqUCatLJ1WqNK7jEzKQXgg?=
 =?us-ascii?Q?W4PU0CfEQzoakKpOwyq8QcdqegM3qyrgxsTpg1V20+mn90Meu42qd0b1zLwP?=
 =?us-ascii?Q?5xeE/SkXqymSSzTT8m51LhlEvxjmn5OtaHBbOdLKpZBClSfJRDjJYYEN5+p3?=
 =?us-ascii?Q?hY1QF+1ng8pkTeIcARwuxlmBA1pG6FrJ9G9uuxXsxeUc17h9NSr+tCDYFFKJ?=
 =?us-ascii?Q?3DxGQ29lCSjl6g7XXOIcBAuQ+At6UWTq3wucGScsAw1KCeKX1cPxek3R4vRk?=
 =?us-ascii?Q?22uj+DsONt+FtQmDlWP5g3iN7WKEkLuKwybsjkKemh92OQNlOCpnpccajrKN?=
 =?us-ascii?Q?R2d9CqivcJQbHFiEWxwoLTAFStexv12ADQSmTSjrfKa/mAt7FUSoIdJPw61X?=
 =?us-ascii?Q?G5bEUmTGRGVmYlZ4uPByHn45BcpANWadTGWZo7grJWIZU3fz8fg8ymVKXmW8?=
 =?us-ascii?Q?B2x6IeCxC+VU934i2c7QcOtmDJj+xWQ55VDGIrEomiLjVVIiyS6cQ6n74KY8?=
 =?us-ascii?Q?Nn1eDC5j7AGD9hthOfb9xdHMYnPVpYpsI5/Y5n3g8wUbk7gT5Y5qYymimJ1p?=
 =?us-ascii?Q?pDGCnA05t6MISRKwswIclp6tiTQLGPhvoal+u3bLSXWmUkHKnYuSSqhYUCDj?=
 =?us-ascii?Q?+wnipsR79vplyZPoYFhuFP3EmExLGEOoNhqS7kpBuUydvSHZOSUUX3krnQ/U?=
 =?us-ascii?Q?vJjyxn45JgXVHbZV4G7fywO5H8e8t4BIoug38verOYNkGj/vgo78dFNBfLqY?=
 =?us-ascii?Q?THekfAUZVe79yN53jLFIWhh21h14FPXw9Nl5J0lVrOAU8sAUXFZcrxBmELhp?=
 =?us-ascii?Q?O752p5HxSSR4EOeyfPCicOom8jl1qKZmvTF/WAQ/YTdRk++c8kpVdOAC58h3?=
 =?us-ascii?Q?+bG/Zlf5w17cVlM7MwYaaoDqp6DhSdHBtQ9iosAqnx6q2MyknBUnzDmbzyUa?=
 =?us-ascii?Q?RyRFocDb+XC1z6hRl+6MpWbfHztfRJFncAAnNfZGttYYl9+0EwwWqaSeCBRa?=
 =?us-ascii?Q?s6k8octNYJ9075sob9AyFRKuR7RF2qtrd18al/PinXCfOSyQQ4uPpAMtIUrb?=
 =?us-ascii?Q?GQtq2SjQCZBlNSWNQSX+428gD35SoSOGiQQHEXrCiWCmWcu+UQqjY2zb/tpO?=
 =?us-ascii?Q?Frfv+KUFP4oe12ofvclAMSmzgqrcojTaYiyXIImNDYxXcOQ/Z/V3bCJL6Ssk?=
 =?us-ascii?Q?df/JpJ1cyb+bv/wWQPM8ic5TFUrqDLQ/rbyoP7ucx9RVibtxPiv9PAsNkDXv?=
 =?us-ascii?Q?M9evCHkYtACnQL6ASOJxZSzuT415AqfaHDDPAAHE90EroUqjjqNoA0PEQ4Ic?=
 =?us-ascii?Q?PmxzwHzWYPHkB63KABKYrrsS3QQoEGZCbGofAimOOgGfSRBIoPOF2wQhWNWD?=
 =?us-ascii?Q?+n/6/B8unbrVbHWNJsFrpf1EfYl6avwDBdXIwW3LvEzXlJLm/J2LVdcuCaav?=
 =?us-ascii?Q?7PHNSavy+ptbQGBYNByCoVYFm+OKS0tx4IvqvvemlHnk1Dw8Pm9YRGVQUkY2?=
 =?us-ascii?Q?e6ljHfrgCMwESavE6p/n2jI6oH8A28Az1HI1XbkL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b208eb6a-73a8-41e9-5ab4-08dc81a70057
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 19:22:24.4481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vx8/tAgrJANYOmoaGXHhoUKsv4uo/Ndv3X8sVnubVmXwSAJuh0RptJryqqUdk9OzImcVkWn1aKvkZ+gdvRWgWkwoPRkKVRYWRk1c6SoyFkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6713



> -----Original Message-----
> From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux=
.com>
> Sent: Friday, May 31, 2024 7:24 AM
> To: netdev@vger.kernel.org
> Cc: andrew@lunn.ch; hkallweit1@gmail.com; linux@armlinux.org.uk; Woojung =
Huh -
> C21699 <Woojung.Huh@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; Enguerrand de Ribaucourt <enguerrand.de-
> ribaucourt@savoirfairelinux.com>
> Subject: [PATCH net v4 2/5] net: phy: micrel: disable suspend/resume call=
backs
> following errata
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content
> is safe
>=20
> Microchip's erratas state that powering down a PHY may cause errors
> on the adjacent PHYs due to the power supply noise. The suggested
> workaround is to avoid toggling the powerdown bit dynamically while
> traffic may be present.
>=20
> Fixes: fc3973a1fa09 ("phy: micrel: add Microchip KSZ 9477 Switch PHY supp=
ort")
> Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-
> ribaucourt@savoirfairelinux.com>
> ---
> v4:
>  - rebase on net/main
>  - add Fixes tag
> v3: https://lore.kernel.org/all/20240530102436.226189-3-enguerrand.de-
> ribaucourt@savoirfairelinux.com/
> ---
>  drivers/net/phy/micrel.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 8a6dfaceeab3..2608d6cc7257 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -5492,8 +5492,9 @@ static struct phy_driver ksphy_driver[] =3D {
>         .config_init    =3D ksz9477_config_init,
>         .config_intr    =3D kszphy_config_intr,
>         .handle_interrupt =3D kszphy_handle_interrupt,
> -       .suspend        =3D genphy_suspend,
> -       .resume         =3D genphy_resume,
> +       /* No suspend/resume callbacks because of errata DS80000758:
> +        * Toggling PHY Powerdown can cause errors or link failures in ad=
jacent PHYs
> +        */
>         .get_features   =3D ksz9477_get_features,
>  }, {
>         .phy_id         =3D PHY_ID_KSZ9897,

KSZ9893 uses the same PHY driver as KSZ9477.  KSZ9893 belongs to KSZ9893
family while KSZ9477 belongs to KSZ9897 family.  They share most
registers but KSZ9893 does not require PHY setup for link compatibility
and does not have this PHY power up link lost issue, so it is not
appropriate to completely disable PHY power down.

PHY power down is executed when the network device is turned off.  The
PHY is powered up when the network device is turned on.  This sometimes
can cause other ports in KSZ9897 switch to lose link temporarily.  The
link will come back.

In my opinion this problem does not impact much as the network devices
are not likely to be turned off/on many times and likely to be turned
off once during system initialization.



