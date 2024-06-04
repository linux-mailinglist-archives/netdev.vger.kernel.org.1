Return-Path: <netdev+bounces-100748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FB58FBD85
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 22:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ACF41C2098F
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 20:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7085914AD3A;
	Tue,  4 Jun 2024 20:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JZkKKcD9";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="r3isngP+"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E5714B07B
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 20:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717534253; cv=fail; b=JRw3hgo440teE4eL5zY4oY5zF4+v+eMOuZ5iIkdKAW4uOmg/VXTZ6nyOh/I7TR8yEn644zHz4fNewe+sl5R+kU4M54zPcZ6YjJEQ8vW4APiA/Z/p4F18XCjzMjCRSDppWe0cOyLtMm6BaX8TLijVQ5RZX6MH1yOo7M7yeuMNfP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717534253; c=relaxed/simple;
	bh=ZzQKdhfh+9zr3Nz1WXU8JtzF5hY3ZvQ/DT12dkdrJUY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P+0CvPZFnrCBNUAvIZIWfvqqlYcdAtotqeO7keTSoyPco5db8Tf5c/vmg6ziiUnzfQTBk/Jkoz616IMFjfHYWEhQ2RnpBLWvkWPV2etMhnpEXdiCWUzMTRC6VC1JhFkyAxizjPqx6BI7mUjBgoj9xVtDYLFkm2kDCNPBuxVYuGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JZkKKcD9; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=r3isngP+; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717534251; x=1749070251;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZzQKdhfh+9zr3Nz1WXU8JtzF5hY3ZvQ/DT12dkdrJUY=;
  b=JZkKKcD9UA1g4aaoo0WlP3wBcLDMWLUQoii/am7D2KFxNdGDC1fBbrup
   5TXaSPfq14hVUcWQIRKXi6p+XOZRZqkbK5FV6CL1jVB8c/jJbh17V12t4
   skxq5Wzndbi0JkXKcUdu+S0BsFKrnCG8vx57emfbzOuHjFsVdMrgM9DET
   4jm00d4qoZS0pcLwIfaYrage3jTcyp3HVZWBc5NtMM8qsafDPAXg2V4ln
   6l0+ay2d+ai1HYAKUShdEEpaCcGkvC8zNv9jtmEOS0s9Rtl1Ueqc+apH0
   AHuLTpqhwJ4SECT3Zb4prqF9ZDSNfKSRBIQAF/Mt9hyNqfF0ggfHsZbFL
   g==;
X-CSE-ConnectionGUID: 5JyFMDykQeWiFxUXYtC9oQ==
X-CSE-MsgGUID: s7DrBYUnSICQlrMR5w5xsw==
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="27604553"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jun 2024 13:50:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 4 Jun 2024 13:50:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 4 Jun 2024 13:50:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5QDZHlfRV7QGKy3UhMoy6kq3WvKWylewTLBspvpYbvo0hX6zmoSIMoZujjKXmnFO9pbX/d/3BCbq0t5v250I0aaJfvW1ubC5JYyszj74Q3vlxiLE+9kojCaD7+FEdEohrFhcDXacNHz2QDs6SvxepXMfEHRn7q3IAhNO5kfEV0HMIOHISEOZpGaPmx7zus/r4m8YegTyPhCVnHI42uhdBWa9DqPaYpoaJd1QpHflgrvzC9RxScaqEFzxJvsgIxl+L4Easzdst3fdGfZcK8ZxU4+bv0nla6IqKnMmOjOL31kJ35Q56RJTJnDZj46Mb+470AgDCAHIOUEcrbWDsWiEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rLxouZrpz9sf+ZvSjbWzeGZuwZDwaS4Dxhb0yLM3D4=;
 b=ItxmZ0Y6un8S9HhAkWZINlds22OS+cyZg9qPej5QeCePTKrDKOSQLCmS+qBIbf/5YyRJ+rC0Hz5hoHBGGs/emPBRS8weOsPZXsYrNgFhnyFy0mR7npcFo3GEIzH3u77QXA5A7ZQ26+8G0nP3dQ/3BVpQrQHndUY/+39jd24V63E8/oWOGNoBtY+iGQbobqKQUbulLfzefEknkeyhbj1TVQ7OA14YKATEGwTQtWQnVlkiiRQ+rYU3uGccPTA8zI1p2Sca306F2YqRefw7Pwbp2kVSG/J7HjdL+WMmeCzB+oYIJq0qoxHZwBQ+U5cDVzuVtYCQebf7gsLG6U0K0z+i3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rLxouZrpz9sf+ZvSjbWzeGZuwZDwaS4Dxhb0yLM3D4=;
 b=r3isngP+jTuoHoJIPKBkXBMHdX88KqHobXYjaL5p6B9ylpB6UGEO7cXxtcwINa+IVeH+W7XIQXhYVsrNaglDM1/wLhok8TXmgbwUDIdThSJLz2L6rDRYpjntzsttG5YhCH8pceD2j/D5pmFH4z8CXWIsFuWtmtg6uK+hlI7gvA5ohcAVZXzdDkbS5HT/zxpRxxtMu+UeGRz3COYVMGIZexp1XUvoIM8MR69MvkFFvS1eTwG2CntD6hW8BnIqniPptGj8lhyjHi9vJ0N8CX/rnywUTN+9JhUqA8mmUsLVnh2CEKtF7WwNXcKzsli6fcvkale/OFGGji7JAOHUik8DLA==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by MN0PR11MB6058.namprd11.prod.outlook.com (2603:10b6:208:376::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 20:50:45 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 20:50:45 +0000
From: <Woojung.Huh@microchip.com>
To: <enguerrand.de-ribaucourt@savoirfairelinux.com>, <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <horms@kernel.org>,
	<Tristram.Ha@microchip.com>, <Arun.Ramadoss@microchip.com>
Subject: RE: [PATCH net v5 3/4] net: dsa: microchip: use collision based back
 pressure mode
Thread-Topic: [PATCH net v5 3/4] net: dsa: microchip: use collision based back
 pressure mode
Thread-Index: AQHatmD6fvPGCU/j3UG5oMJuiamg1LG4FNNA
Date: Tue, 4 Jun 2024 20:50:45 +0000
Message-ID: <BL0PR11MB2913E413DE94ABE68C475052E7F82@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240604092304.314636-4-enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <20240604092304.314636-4-enguerrand.de-ribaucourt@savoirfairelinux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|MN0PR11MB6058:EE_
x-ms-office365-filtering-correlation-id: cf9906d9-fed1-4b5f-764a-08dc84d801ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?3AViKcOFY7PhbA8vCrNyAWmnWbAftLcQNv9fXrO4wgkggeHZZmUVY8xn4zDw?=
 =?us-ascii?Q?Oo3NPUrsIBF7VSmrK7CXrEKWr2/gt2ZT+unqKVwLPS07jmo3Tgsx6+D8y4ck?=
 =?us-ascii?Q?mNpqPidyBSj3ahe+vpsXlXXTVUyL24dlka0Ym5bNRBwwOBsOXAo+Jv64Qops?=
 =?us-ascii?Q?SWH65Ljn5L2tM4D2gE9sc6aBAxFxYFokR5Ropk08pWjWbCyiHQc9cczVfQQG?=
 =?us-ascii?Q?GHvTjeQMcFp/XlCWTqmNMrhLoxJZEXE6KKUKDuk0qBreSHtWflRYs2GhzhaM?=
 =?us-ascii?Q?PxxsBLUUYAyL6yjeFA/6ECDbZaLzWebIkdF3oSNgXsjEwxmn5NzrUykV2TMI?=
 =?us-ascii?Q?nqHwG1Zf+MBZrjJDgCwYZRAxi9H10QICWIFwKkHdSxQf6M/k/JniwWe6gw75?=
 =?us-ascii?Q?0gunbdqbyRioUD/hYeo/vko7hDlGt769XHV6/H0Pc7Op5lhN0+extkeF/PbH?=
 =?us-ascii?Q?e1eeFdIFTQW2jgwT2bDUOQM6QrR8sa1fXuLhfOuldKmVMI1Azjte+EeZ9arR?=
 =?us-ascii?Q?Abu7YzkvvAP0zBmR5CxXEAEreTgjEF0hFyAeFChnFvHWh6j2WYFuAFGYTJ+W?=
 =?us-ascii?Q?9gD0rFjHVj40qxQxQxbk0+9xLbwU91a6+Cptngwzlyl8WolsnDO0khgmDjvi?=
 =?us-ascii?Q?jN3WxAk55Gf0wAqjQKxLDCFqVct7kQIKqRCgdv1D4OPHDWBiH7J/jHpXZSii?=
 =?us-ascii?Q?qkJwbbhPLuaeM2iHwUkqrurj74aYqU7P1Gi2RohHQmpSxkJQ0YNaT4SKfqzE?=
 =?us-ascii?Q?r5CTgcE3pIUKMzaVP9SM5hnkYmffi//W8+/CFlLOTbgD4bE7zcUd9+IJnv4X?=
 =?us-ascii?Q?pte4st4pcd5THEam3PRGQF57wkp/YpMLjfBlG4NMxTKlwxXTsrloSl0YK7L6?=
 =?us-ascii?Q?EJ9eCasgi1vQ5R4ZPqG156BDG3lUvYf67gX2Ql9IKcqSyZMgNvfcgULZK6gV?=
 =?us-ascii?Q?i0+DcdZpSiu7yd3sb08xftQpsPWCDo2NLAekT4we0BlmYIXyto3H/q9qiEat?=
 =?us-ascii?Q?U8XcJb/DNvv+nBn70e5y5yWw2nMT7cXyxxMy92YbTDDISeNyyWqvr8grP07f?=
 =?us-ascii?Q?EERiTvSlaKk1f0sRP4AitRzJTaalym3U2ILjtuVGG/VaKgvX8NTsqkHVuejQ?=
 =?us-ascii?Q?XL4ZJXnW3Xn/yOsC3EiI2A5MrjaS1BtO7bY2FVfc3Ish9ZMlJX5XUp0ffWyW?=
 =?us-ascii?Q?Q6ZzAU6oP6Glu1I4JMkX/GEo28C4rZVrVjRKLjyhYaJtjXGf9/XsaUKL6vEg?=
 =?us-ascii?Q?p3AvekcHi/P2eCZtOlu7gRdq/lJUbZ5tAEx6hAjsMnlGIa4sc2cqqVE9TFZJ?=
 =?us-ascii?Q?D2ln7KRtrSRLdTh5RlmXKJdg5NZG+tNfiOWVlmSreFcCwA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2mKaSwEDgVq3FsFhi5AddW5k+P1bQea+7/7zps6+csGz0a7DPjueLadVkrFS?=
 =?us-ascii?Q?Xooft1QKjZD7hq7BsIbfwdKf5MFVeFgLPinJmwZ36y1XcUHUA7nB6HBrUc5r?=
 =?us-ascii?Q?vrc/AWIB5PJej+MPeraeJeLmz8dIbqNQ2hO85lK2O5Flv747N58PgrFjwCjr?=
 =?us-ascii?Q?SHc/vx7yRASeGmafLwlUAsasv2D3xTxXW4KbTOoSV51gI4WDP1i0XeVse2SJ?=
 =?us-ascii?Q?deUlJzRY+ep0cUVCR6X8p1TY1OKiY25eUmDQJjxSVdKZlTvzXo524U0FiVMU?=
 =?us-ascii?Q?jvyBMxZkZ3Rxtz5wm2cPvXsfMrpQoYgn+LE599zFIHvIO8pUUsM+mYaA5Kgq?=
 =?us-ascii?Q?UiCfAuCSlg0ANF250rji9EMpSHj3h55nlFcrB4IIF+XXsWUzAls8gxlFcR1D?=
 =?us-ascii?Q?QlA2Q1oM0bmdga28Egayp3hpJjNO1i0F7/cdx9XioSKOImkDO95qOaE5Z0o1?=
 =?us-ascii?Q?prDCwgWPYXjpbnpfbFL3AvhR38Uemsbyl5XB/tUZmu5PGTelfLMnZemxH48Q?=
 =?us-ascii?Q?aAu1YBWY0v8UDJ80MGzEEgwFy77juxZ6SVhUd6HDCKj2jkC2S8DR69f5dOTU?=
 =?us-ascii?Q?JR3WNiPsdhHD+b10C/AXSgXoU+Eqb6WwWOu+CWbjR+HXNVCG72I/5773Mc7w?=
 =?us-ascii?Q?4cmIh1SrcgV0lk2pj4BIZ8poMCUCtLYyS95U3OggbkHmzyFBE4Zf25H3GI29?=
 =?us-ascii?Q?8oB0qNd7LMwDs/97hFGhtynyoZWinKFFdmkksMrwGWsx866UohusAAS8Hnf9?=
 =?us-ascii?Q?TWDoF81TMuLTHHzw5zxMAgR85dKuS7+YYFy8BaI2kdrfq8MIYV39DSdIXrg1?=
 =?us-ascii?Q?TFv7TIF4RDy7YdwEv6TcX6sUEuBRmRpKlElYfmnDJgpd18RJ5YWm2MRzMwGS?=
 =?us-ascii?Q?YqcaAPL3FC24CnnyKHUl8k7nOxUpfE/M0hu2pQ+gy9NiYSnRQRUbuPzvDroj?=
 =?us-ascii?Q?qFrku0JcDL2hrnXT3VsL7lLy2Zsb+90LITproNGt9BSInSpVoIYbAvdmc012?=
 =?us-ascii?Q?7kNvNqpSVqTD0UBnqcOJ1BmccuLlQd2lTtcfELxKsoxYoyjqBEcXr421nnaF?=
 =?us-ascii?Q?njXBhYcF4XHMbgmX0dNDIc/cJ779j+fwUIqsYMcPJCKans43bdkGpPMzbZt+?=
 =?us-ascii?Q?CXQNuwj1Of23tVFk8jK2m7xQB4nsr6NPh8tKUee34iHkuSVJjgySQrgH7pcl?=
 =?us-ascii?Q?F5NJinOADb1fQWYbWjq2kjH13+TsIbuSL3oOtm2Q+6JUYG3dwh5dBD2OyRE7?=
 =?us-ascii?Q?JF4d+m30ZtdbNBt4h5Tryn+Q7zHfeAAF7gX8RltWNey2NG2AEAMvWHxyQ/UH?=
 =?us-ascii?Q?QOQjmC7Gi0kJElQSrEk37EERLXCNRrhAI0C4kyJ2Yv+f54cMGxljQyC2GcWx?=
 =?us-ascii?Q?rnIjNyWrl0DRLCgxNEt6P99qmL6Zo+LIVJCI6jbDhzC4aoaQJXe/sk8lTrba?=
 =?us-ascii?Q?IFhkZ8GmYrkaqBw/AokD34TM+sTfyMJN/nUdm7h/jBHUCcL1nkKJlu6wTjIy?=
 =?us-ascii?Q?uVvpnFQfZxV3FVAuEuY0tSxf8e1zY9e/n9G+WwxDq9KStClopRPJW7WbYKFK?=
 =?us-ascii?Q?X7oPG+R+wtbsVMJBiMKPKYoj6OC2OXgkTZ/bUXpb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9906d9-fed1-4b5f-764a-08dc84d801ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 20:50:45.6064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6lG0/USNnsfpPsKHnYL0S9vdNdLe4dRGI+k7XIsD5e2COnA00PDNcA2BWwdWB3mhC1l5qZpoeZKOMtSOniHJ5LzKaM//gX+aqpuLXQPE80s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6058


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
> Subject: [PATCH net v5 3/4] net: dsa: microchip: use collision based back
> pressure mode
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Errata DS80000758 states that carrier sense back pressure mode can cause
> link down issues in 100BASE-TX half duplex mode. The datasheet also
> recommends to always use the collision based back pressure mode.
>=20
> Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477")
> Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-
> ribaucourt@savoirfairelinux.com>
> ---
> v5:
>  - define SW_BACK_PRESSURE_COLLISION
> v4: https://lore.kernel.org/all/20240531142430.678198-5-enguerrand.de-
> ribaucourt@savoirfairelinux.com/
>  - rebase on net/main
>  - add Fixes tag
> v3: https://lore.kernel.org/all/20240530102436.226189-5-enguerrand.de-
> ribaucourt@savoirfairelinux.com/

Reviewed-by: Woojung Huh <Woojung.huh@microchip.com>

