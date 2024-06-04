Return-Path: <netdev+bounces-100747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136C38FBD84
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 22:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33ADB1C20933
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 20:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641C314B07B;
	Tue,  4 Jun 2024 20:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hRK6XPJ/";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BL/jwwda"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8449514AD20
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 20:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717534231; cv=fail; b=NlYW0jbNBvvjHSWyM5NDNExp+5vwJPiSABjKtGObheoZC0fFJNg2kZ6E+EE18b65uqt2iVJGy/+V2PRe2nl4WMNsEA1u7L2M4uod8Jp+uxMD3Ft7Q/j92OvcL4P0iovvVwcVml80sCx/mDCjzFDNIu9rVF5PqGqOxVmbc1itIZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717534231; c=relaxed/simple;
	bh=01kBWldcy6UyhDe8P2XmYGoc8aznAEFaF4KoVmkMCPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BhahEyydOmmIJcntlHPijX6XuIGz/VOCuP+WIr8A8pH/d3bQid3qQceVltZajuxrwe5p2oDDmtmrd7Pma1mllitxcgB5+x7y6Cg4OtB6Eg0v8O8CjYB29+dgLCh58aKYXclDpf0kmbDA+n0xtnjdxM+H3JWMsAgO3+9xj5nZwkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hRK6XPJ/; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BL/jwwda; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717534228; x=1749070228;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=01kBWldcy6UyhDe8P2XmYGoc8aznAEFaF4KoVmkMCPA=;
  b=hRK6XPJ/V9B0tF8tr2igz6D3f79c2V++KVzkmtSESeQNGLkD0bJkXWRs
   zRntQyrLq+wjeEz9z2tNH4czP79wMM4dhTPE8fmpOV8UMMpO3c8uHWrKh
   AIFi2M3BU2MhqS0ujh0V0xa2BZP/X+C8IZrvS2n8n3Y1f1Vkmevyyxg6u
   3oUMaTCaqVbfaMUaxWLTB6Uabu5Z6jVrNtK2AnhQ29URERh73thIHIIbH
   I/YZ3W0189zzZIjIvkrBGVzwy1W7j2B9TVuXmZz75hpKDYaxcVfzU0wMN
   A1T+kMMgUw0gvd8d5O3gp0v/mobjsQgLvG0RVJ/IKRffC328aAwb39Zqu
   Q==;
X-CSE-ConnectionGUID: hUkbq9oXQHiWjQszauGjUA==
X-CSE-MsgGUID: g/VxIBKhSm+84n12t1jiYQ==
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="26977440"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jun 2024 13:50:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 4 Jun 2024 13:50:01 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 4 Jun 2024 13:50:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B63rtivWU7I/sxsmhaOfuBSN8YOkaBWwzakkI/0iX52o7nzTKrboRMUl/LmT2ivVBkSNG02Nd3YNpJOB4cBS1IttqUUZ+ugAM148mMURpSmklr7t1ZGwqqpaZftKyAovalhAYBVW3RPxw/lL9b9AAAqDbZuAt9L2PKFjKH/597qvnotQdYw9oJ101QLBmawi0SDDqyy+/GcNjlLwL+fjTsZ5NroVwZbZ9tlLc+7LHnB94Ae4bGDvpDuvtr6SHrGuPSw0YnZXXEMem7ZmhddBQH7P6RQLBlWVzndB3FdTvm9uTPAeSgymKApLwcFmye4sa2EB2RE1263uBMvhKE3DQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=264Mb7P3RhvrgE6UnaTy/Jd4ZbU5IO4zgc1GSyhcDio=;
 b=b+ZEijsPazjcOKQXd3BMj1hQiTiSRB1ywDsVMiiofZZyjbgYGWW4kYso7kEaRuEYxFMxVPMPjasQRcC/qDS21eMJsZvAcFB/lAy29Z6MZYkzyP56+MG5Q3W8SvXaaGd7zQ+K+qeUljBZYqVvCtXbFPZEjPepVQjshAL1jSouu7KSL8f/ycGK2DyB02xOfy7iHmv6SVDrYbPQ3EzS9oLVFGbqklPds0mcbCZqWiq0KL2Jopgl5lUb5JIQtQvmEhTpqJDIzL2tCaroup9r+HEusGAMQxiXYKDMW7LBvL/+NaBs22lUz2VZYcCBPyYvuuKNnbMXq/65l0YhP8bqmV/h8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=264Mb7P3RhvrgE6UnaTy/Jd4ZbU5IO4zgc1GSyhcDio=;
 b=BL/jwwdaHy6rSoGwC8yaA3l7+2yvdNog9CypiesmXCaHmTfl5YF48U+u/kZeMLlAL7tHDM7VyIdYQifHwvm7fZsReik7u3x5Jd5QYfloBjdqw+Kqet1c13SixflYtnEo+YoiAPzp/0I2RXHVGK8gKPqHnwhNh4rC37wa4LMIvbUwwz8kMPIBcIASZ7mBw6fmL2mN0XZejbRWj8SeBI25gCi16i0y2o81NJuMU7CoZNDrIt+EPOo36Kpw3PyqN/tmxgEHJ87+PYNpYlKJ9EIDqjoRKd/FxZqBkpyu4YDcmbn5N1oQ5l218r7qJZWaQZRzrG2SQiSbdPyIGvKAIhkPIw==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by MN0PR11MB6058.namprd11.prod.outlook.com (2603:10b6:208:376::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 20:49:58 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 20:49:58 +0000
From: <Woojung.Huh@microchip.com>
To: <enguerrand.de-ribaucourt@savoirfairelinux.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <horms@kernel.org>,
	<Tristram.Ha@microchip.com>, <Arun.Ramadoss@microchip.com>,
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net v5 1/4] net: phy: micrel: add Microchip KSZ 9897
 Switch PHY support
Thread-Topic: [PATCH net v5 1/4] net: phy: micrel: add Microchip KSZ 9897
 Switch PHY support
Thread-Index: AQHatmECha3DGgOR9Uuf/GUr++OEXrG4D3PQ
Date: Tue, 4 Jun 2024 20:49:58 +0000
Message-ID: <BL0PR11MB2913D8FC28BA3569FDADD4A7E7F82@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240604092304.314636-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <20240604092304.314636-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|MN0PR11MB6058:EE_
x-ms-office365-filtering-correlation-id: b91e3c31-1d2a-4afa-0be9-08dc84d7e574
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZiMbunq0ZFhBfpVdZTkXR1bO4PzkrabTS1pfMI5Q5zkAWuKL8UMCsEkCtq0+?=
 =?us-ascii?Q?+UDjFDVvukD+LF/ePLb3C0zlcFiRw89w446NDLDzydRFcqL8NUdgfqO2RpDc?=
 =?us-ascii?Q?JNGEljYqBce7FKZXfriZBsFBgFvf/VnCJtuE7ew2z4AJ4QGlgGfxq1byehsE?=
 =?us-ascii?Q?jXkvHALgC/QcDon5jYMhVFkBM3UONgMkEXZw5rG0Pjr/6mhY8yuk0G8rd5g2?=
 =?us-ascii?Q?SuNPCQp9YYQxkkLc9eWLcHZNoylZcbzx+VtYGCahzlTTYKNSACZhcdzuWhxF?=
 =?us-ascii?Q?FTEUfLANWP9YVKSI6QjIM/FKaGzB8EunMc5XtKv0O+JdlxdWIuMpgC4jZM6c?=
 =?us-ascii?Q?Gvw3WTBsabB6kZSzZG0zZ6trQGqsosZv6D+ASLsINMIscYs8owIga9oWgOuZ?=
 =?us-ascii?Q?uIj4y7G2sbbj1I1+T6aQUIOlfs8sty6KM2AK5fCxrTgGy04ZYhwyWEmrpm3J?=
 =?us-ascii?Q?w8DDxsqI6ziHaV/JZJWVgmFZPA1kxTnIt/mTQE+ChwydZtpMlXCcuxjxaISM?=
 =?us-ascii?Q?7rVqk+8a+LTZ74CsRd0fVGAp+AN7hBaPMPlM/h4s5sPsvtB3Ma9McZxo96uU?=
 =?us-ascii?Q?cX4z0U/+u0e+z0ZXK5xmHDomBxWvdexlMy6G7maLpVLdypwbFzZiSdnNTPiD?=
 =?us-ascii?Q?9cGgV+BuEgA2Y0E98EKIL3+FUauiaTEdhtMuTarmNBcCeQu9xRAs4a3S6LqB?=
 =?us-ascii?Q?jtsdP5MOOqnUyNC0DruQXkFszH5DKkdTnwRvwbSPKH0GJi6WGJKQ+RquqxsW?=
 =?us-ascii?Q?jpbfPFYu2xCFEgXEmDYJtyvEzXhggxkYWsFD4cPnfMoAGvRhHJUNlxLuIKke?=
 =?us-ascii?Q?DIqUu7TbJIg/3jvNI9d1HZqQWmYvYWDKqX/UeJHDLJoGDtIkVDYTeB5s4sgB?=
 =?us-ascii?Q?ZzHayaRPeXnl3lWj5AYKDGWqdBEkLMmcTFfeYBLsZYWypDtY7e4ICtBAQY3d?=
 =?us-ascii?Q?e9Gm9yVh9DcJ6MhCiYW3mwOan13AMj5/fvqHt/n9LfpwNOWaKe8rgV+S9yKv?=
 =?us-ascii?Q?pmbjCfi+xs8IoJhUF0SmVYYJihp/z84CyclEQYhCDNB346q9VeOgCJaiZNW3?=
 =?us-ascii?Q?peapMxbkBjwSoslSrQLAxNm9hstGg/MT/LMqwgtWR19z7FsL3iAe+NmoZnTA?=
 =?us-ascii?Q?Esr8H+XxU1apJhuMWRVMTwHj2Tp4JmhVhDECCXHFa/OtdNnO88knD8FeVPPt?=
 =?us-ascii?Q?s/MNmw/nUzAB9B2NR4KUxCrnqAa4s8hdhY9Zh54LJN6lbXbY900YqMqkw01L?=
 =?us-ascii?Q?2j8oMf5WVvg0V8/mGzKCltDyYzk0/Ww3BYtCkKV3SbBotCQFCZPmdxp5z/7X?=
 =?us-ascii?Q?y6XDO460I2Iz9AJr6uG/VVm60ZUFsG6F7/JulfA5aK8GSw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?agTNoq05Y21UKjRQTZWbow/1wEzhFGKo9T0x62viQIqn0WNrx6W1Czb0VjlN?=
 =?us-ascii?Q?a5YZfoHnqpX6lyaZ5Qs44fbaGBP2m3nMx7zXJ1lbGI/Fj7HsOvr36/eUtRkN?=
 =?us-ascii?Q?k63Hd9hF/5CA4tnv6ReDdLHsRKK50+f32pxp4Fou0znSXekGZrLS4rLH0C3S?=
 =?us-ascii?Q?uk+W24ui6CKdN+EzWhg7Derkh8RuurAPn0HH++Tbv4NW1T0seUAarRyEZ8VV?=
 =?us-ascii?Q?sLF+9iR7I6RUeTOSGYo/zQnotazg16bknMLysG3xC6lPrSlF4ViZ/rofcuvH?=
 =?us-ascii?Q?1GUIxy8ATnA/58ksb+4J/2lROsmPqvo/UaglyXNhdnWhP8F+Y0UnLAvpkSRx?=
 =?us-ascii?Q?6qz07uDNtlJdyfrO6ShPQx8VOmIlJPzNbTq9FWTeFvLIBgQzH6v8R67YwSot?=
 =?us-ascii?Q?4A3hugxevViALeUKd/uKwFQH8/dG1imTkI3Wm5kSIp1Clpy9No9+gl2IRk4Z?=
 =?us-ascii?Q?ps4/4tZpqd9nvecJ0X1e0QUv/1Vc70P57h/TgGD/1FgseVdZW9xnskLFsSCY?=
 =?us-ascii?Q?xBcu5YSTE4Z2WYiNhqcRBghwkJEs3nQGGUiDtNgyryirC0ydKOKloYSS1qy+?=
 =?us-ascii?Q?5zfEhe61owT+XZVbgO5YQ7kYxhiuvBLdxHkyltvVRbmPhaLzroUy1RZWjRs0?=
 =?us-ascii?Q?2+OpR3unL6WcBScG8t7qnqtrMysXgO/acifgoD/gIYgfIxjNSmyaaB1/KcMH?=
 =?us-ascii?Q?k3p7pMK+ley6A5EU+R4S3a9HREjn9b1LUZfRB7w8jgqHGI2adTofnBDO5bY9?=
 =?us-ascii?Q?RS+gULhX/yyW6ziYPb54QIw7neSWGX98pDX6wOy4Y1TkzbiemYdhCfoKOEKc?=
 =?us-ascii?Q?agalV6hH4taeAEQeAzBIfFCanVlMAD4aeCIq66gsCIkuwbMZU7Y4FPAXyuN7?=
 =?us-ascii?Q?YZZY9LU7FsE4bVbkIDQdEcQzvTvf9bA7lsspYDFeIt/6rDh3Qe6zNbLDC1HR?=
 =?us-ascii?Q?Or92F1s6owCnClZMh7IHNvepa+Z7tVe8wQ8Z+mbCQijVXizdPMdDKzGRCPsO?=
 =?us-ascii?Q?ajqbwFWnCKuu5sb5Koi9v5G9x/e2uW8YMthnYH6SjqX+rGkGOrytHR8zGU/7?=
 =?us-ascii?Q?c8W1h8rxT2pGmj6rD29gisb9ZvIERCBMosxXgD2Uj5ESNOPt4PVFNlq+tIy2?=
 =?us-ascii?Q?aGAYpn07bwR6m67gawN0ZO0hLgJ9AJag9BGJKiQoDuQLWRA4cFiNQeHTorMs?=
 =?us-ascii?Q?fFhbjLrWH+iZPorh2Dh9Z5CrQE9XyHnBSSkwhHA/CrjPhE1L7oAJ/DBEknDU?=
 =?us-ascii?Q?6sH40PPcoV/uvQ9EvgfXWb8kbSJXGzVys3dFiJodG8yNLvYO/H13EWkmVuGZ?=
 =?us-ascii?Q?h5rQH+1QO9RyapQNO9KM1X4wHBXNjtGN/EqvcKuT6pND6liBmcIZp2/vcdwF?=
 =?us-ascii?Q?tYRv+7LUv3UZSYEN4uzmT0hHcmymU2mgEPVaiGimDrBT2UWB8lXOFQ4DbSxk?=
 =?us-ascii?Q?1kMqdVIiAtoFV3GL70lS1jvMcFXA5Y37bW6jB1iPVV3k0d5X4bhq6fzCUJ1P?=
 =?us-ascii?Q?YXoEG6bG97vmIDAMbWq4TdYB919vjqnYwG+7tPJoXSB8Je1PgRH/jZw/wbQK?=
 =?us-ascii?Q?A7+R+TEF3a+EW8WPrl2No55R/deonuhd/vS6Oq0t?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b91e3c31-1d2a-4afa-0be9-08dc84d7e574
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 20:49:58.1873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vRoKF7iF60PVz6vC9wqudcqmBYyJAN0W2xUF1lX60KYaoCfngvN0QCc6oXGKseBclAnCqBwsHPqCsRksaP0j85J2uzAm3dXh+SjIaKa0WqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6058

Hi Enguerrand,=20

Can you help me to understand your setup? I could see you are using
 - Host CPU : i.MX6ULL
 - DSA Switch : KSZ9897R (https://www.microchip.com/en-us/product/ksz9897)
 - Host-to-KSZ interface : RGMII for data path & SPI for control
Based on this, CPU port is either GMAC6 or GMAC7 (Figure 2-1 of [1])

I have two questions for you.
1. PHY on CPU port
   Which GMAC (or port number) is connected between Host CPU and KSZ9897R?
   If CPU port is either GMAC6 or GMAC7, it is just a MAC-to-MAC connection=
 over RGMII.
2. PHY ID
   Its PHY ID is different when checking datasheet of KSZ9897 and KSZ8081.
   PHY ID of Port 1-5 of KSZ9897 is 0x0022-0x1631 per [1]
   PHY ID of KSZ8081 is 0x0022-0x0156x per [2]

Beside patch, you can create a ticket to Microchip site (https://microchips=
upport.force.com/s/supportservice)
if you think it is easier to solve your problem.

Best regards,
Woojung

[1] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductD=
ocuments/DataSheets/KSZ9897R-Data-Sheet-DS00002330D.pdf
[2] https://www.microchip.com/en-us/product/ksz8081#document-table

> -----Original Message-----
> From: Enguerrand de Ribaucourt <enguerrand.de-
> ribaucourt@savoirfairelinux.com>
> Sent: Tuesday, June 4, 2024 5:23 AM
> To: netdev@vger.kernel.org
> Cc: andrew@lunn.ch; hkallweit1@gmail.com; linux@armlinux.org.uk; Woojung =
Huh
> - C21699 <Woojung.Huh@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; horms@kernel.org; Tristram Ha - C24268
> <Tristram.Ha@microchip.com>; Arun Ramadoss - I17769
> <Arun.Ramadoss@microchip.com>; Enguerrand de Ribaucourt <enguerrand.de-
> ribaucourt@savoirfairelinux.com>
> Subject: [PATCH net v5 1/4] net: phy: micrel: add Microchip KSZ 9897 Swit=
ch
> PHY support
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> There is a DSA driver for microchip,ksz9897 which can be controlled
> through SPI or I2C. This patch adds support for it's CPU ports PHYs to
> also allow network access to the switch's CPU port.
>=20
> The CPU ports PHYs of the KSZ9897 are not documented in the datasheet.
> They weirdly use the same PHY ID as the KSZ8081, which is a different
> PHY and that driver isn't compatible with KSZ9897. Before this patch,
> the KSZ8081 driver was used for the CPU ports of the KSZ9897 but the
> link would never come up.
>=20
> A new driver for the KSZ9897 is added, based on the compatible KSZ87XX.
> I could not test if Gigabit Ethernet works, but the link comes up and
> can successfully allow packets to be sent and received with DSA tags.
>=20
> To resolve the KSZ8081/KSZ9897 phy_id conflicts, I could not find any
> stable register to distinguish them. Instead of a match_phy_device() ,
> I've declared a virtual phy_id with the highest value in Microchip's OUI
> range.
>=20
> Example usage in the device tree:
>         compatible =3D "ethernet-phy-id0022.17ff";
>=20
> A discussion to find better alternatives had been opened with the
> Microchip team, with no response yet.
>=20
> See https://lore.kernel.org/all/20220207174532.362781-1-enguerrand.de-
> ribaucourt@savoirfairelinux.com/
>=20
> Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477")
> Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-
> ribaucourt@savoirfairelinux.com>
> ---
> v5:
>  - rewrap comments
>  - restore suspend/resume for KSZ9897
> v4: https://lore.kernel.org/all/20240531142430.678198-2-enguerrand.de-
> ribaucourt@savoirfairelinux.com/
>  - rebase on net/main
>  - add Fixes tag
>  - use pseudo phy_id instead of of_tree search
> v3: https://lore.kernel.org/all/20240530102436.226189-2-enguerrand.de-
> ribaucourt@savoirfairelinux.com/
> ---
>  drivers/net/phy/micrel.c   | 13 ++++++++++++-
>  include/linux/micrel_phy.h |  4 ++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 8c20cf937530..11e58fc628df 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -16,7 +16,7 @@
>   *                        ksz8081, ksz8091,
>   *                        ksz8061,
>   *             Switch : ksz8873, ksz886x
> - *                      ksz9477, lan8804
> + *                      ksz9477, ksz9897, lan8804
>   */
>=20
>  #include <linux/bitfield.h>
> @@ -5545,6 +5545,16 @@ static struct phy_driver ksphy_driver[] =3D {
>         .suspend        =3D genphy_suspend,
>         .resume         =3D ksz9477_resume,
>         .get_features   =3D ksz9477_get_features,
> +}, {
> +       .phy_id         =3D PHY_ID_KSZ9897,
> +       .phy_id_mask    =3D MICREL_PHY_ID_MASK,
> +       .name           =3D "Microchip KSZ9897 Switch",
> +       /* PHY_BASIC_FEATURES */
> +       .config_init    =3D kszphy_config_init,
> +       .config_aneg    =3D ksz8873mll_config_aneg,
> +       .read_status    =3D ksz8873mll_read_status,
> +       .suspend        =3D genphy_suspend,
> +       .resume         =3D genphy_resume,
>  } };
>=20
>  module_phy_driver(ksphy_driver);
> @@ -5570,6 +5580,7 @@ static struct mdio_device_id __maybe_unused
> micrel_tbl[] =3D {
>         { PHY_ID_LAN8814, MICREL_PHY_ID_MASK },
>         { PHY_ID_LAN8804, MICREL_PHY_ID_MASK },
>         { PHY_ID_LAN8841, MICREL_PHY_ID_MASK },
> +       { PHY_ID_KSZ9897, MICREL_PHY_ID_MASK },
>         { }
>  };
>=20
> diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
> index 591bf5b5e8dc..81cc16dc2ddf 100644
> --- a/include/linux/micrel_phy.h
> +++ b/include/linux/micrel_phy.h
> @@ -39,6 +39,10 @@
>  #define PHY_ID_KSZ87XX         0x00221550
>=20
>  #define        PHY_ID_KSZ9477          0x00221631
> +/* Pseudo ID to specify in compatible field of device tree.
> + * Otherwise the device reports the same ID as KSZ8081 on CPU ports.
> + */
> +#define        PHY_ID_KSZ9897          0x002217ff
>=20
>  /* struct phy_device dev_flags definitions */
>  #define MICREL_PHY_50MHZ_CLK   BIT(0)
> --
> 2.34.1


