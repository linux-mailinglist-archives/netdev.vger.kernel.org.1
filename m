Return-Path: <netdev+bounces-99835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2318D69E9
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 21:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B58161F283F8
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 19:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A181158D83;
	Fri, 31 May 2024 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IbP1QkvH";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TDz5LhmN"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC6E157A74
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 19:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184380; cv=fail; b=jMAD4adltoR6Llv7fnaILFoDz0l6YnqI4anSPDJ0Fe3xevzxbQxbLLAmS6JLxyUH3dKhqN5mokxi0wHX0dz8atETb03tjOcjGT6IcKpriksDhacOax3pCc41fV/Y8tSjz5zwXujZU44ip8+Buf/fdEEAVxrYEEgftQ/CgJfSWBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184380; c=relaxed/simple;
	bh=Tjz4eE2pARmW74ucSgYJybMQfDwAiMajldn/hp2mNcI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b0/IoFlfvquDmK4RpETnyQjUoVDsOycV3jWlxYv9QNcRj8zqU/t+EL6uBYAROGvua42Rmc+ONZweScXjxR583EKntMejFBqaqUl0PhTUnBd40DonXpiQtYmmqzoPaxr1ryIDL2lt7GAV/VyZHOROpu/tsnF57A3bcK8dd0mtMSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IbP1QkvH; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TDz5LhmN; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717184377; x=1748720377;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Tjz4eE2pARmW74ucSgYJybMQfDwAiMajldn/hp2mNcI=;
  b=IbP1QkvHtsOS6wCtjQpofMitNUXcgBxlaHjKMpovdIeK8gXT782wV2Oa
   LnxP4QhdTkJahkreBk5EX5XGOztIJgYvGsyPLHVIi3wIE0IPMeOgyaidW
   Ya2A4Ahj0p/Qed2EKozv8IANid4d/Pr3bMp7cgXzut7oAVHSGEtovqD/v
   V87LFKDvVHwzF69sP/NxTzaAGdBRBMnJranJN1aXcGy6cOJUFl3JOZiPK
   TYOHzjCsAA/cGexwTgA7lIhIhdrwXL2ly9lP8qHiWcCIF2cGTJ0MYioZL
   wdZLbtfN/OcMScrScOJPbc7X/urWiX3KLwncEaXzgqIgqMcOUkB0HQg3x
   A==;
X-CSE-ConnectionGUID: TkDV8UP5SUGm/Zts4xIX9Q==
X-CSE-MsgGUID: 3jynWM04QOeU9aNg1QLaUA==
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="26826420"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2024 12:39:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 31 May 2024 12:39:14 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 31 May 2024 12:39:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWuUTGaHddv5u+mxOjNGANfH3B8LLBqp6jHl4l8tB71qU1HFvO3ydL+NKybpfWyjqi1JKee5ecDTokXxjIYerYT5Hq5WlYftI7R6GuvYcZTZqsa2cd9tqiyvy1IUKm0zlDoiuIlsj4p/xOKvTIz+6uCzmEVLizKdTDmVQwHGPSkLe3HHgRdwV7QnoLCNTU7YJGhaoQdDim0bmlzO/0ETvLLkGicNUsGFyV22xfiJQFl98VNelvz9mcr8kvUH0lrq5eos3xWq7ZaCHmTWYUTrUJaKmgAy+uxFNO3qUymZePniW4pbaOQeDZmPC1et6l+/Knl6xEfl5fnknouiLt5x3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GH6Wmd5aFMTATv09liNYGplU18GgeRsM210bsKHic/w=;
 b=RXKA8auVTIovt2+61+aTuYX7DvsaHz1Koe8Xrvy6mIBHp2xxRPly0NGVf8OB1TkcxkrJfdO5QYdKZ2XbHRIO7QmUXTBIxn4vq/KUKLlvgFEEAwF40mFj1RqxL5mRTBPU5TD/VBowgJ2G3r27/QxSvIKhJYTBXFd2is5mqe0alUrraT5W23Jv9NlsZmzQXLHz1AKDd9VGA+0ZupqMvoWBM1IvvfTkr10vv9akPLbWWP2J9sRMIc1g4PocR/omXhQ+4S3A6N1Z1y0v/4eSazXngKyAGjgCkHehE3a8LRb0R4yF+JnTcYTU3CjyhaH4YU1bO9F6okiF3fu2BZ+QknppOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GH6Wmd5aFMTATv09liNYGplU18GgeRsM210bsKHic/w=;
 b=TDz5LhmNrBTk5dPUMTLYIrEhZiSQc/UzSsFQEDNrp5y1ctgVmu8qlQplk4RxIz5gxZ71plQwJnsevqHEydewpNse6j1PFIDogD/vGh6zWMWn04vTY06UC0d984OLi6N160srDsV8qzIP5bWz5AeVFMOtZ9zw30WxFGQsjnduvOwPF8Eg3KfSfHmjweXYTU8Dp5QW3PuXfm97lkSc4yBfU/8X9Cnw/X7s4S2eEokIfpWwdINlraUxfktnBZkCCXp9T3lLE36w6LDVLP0IJABr4CEfEaD4xmToEeiTwmOyOnfcq3KWg1h100P9r8vMZZMmfqAMFTN1Q1oEMmM3VEHkwA==
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by PH8PR11MB6904.namprd11.prod.outlook.com (2603:10b6:510:227::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 19:39:12 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6%6]) with mapi id 15.20.7611.025; Fri, 31 May 2024
 19:39:12 +0000
From: <Tristram.Ha@microchip.com>
To: <enguerrand.de-ribaucourt@savoirfairelinux.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net v4 1/5] net: phy: micrel: add Microchip KSZ 9897
 Switch PHY support
Thread-Topic: [PATCH net v4 1/5] net: phy: micrel: add Microchip KSZ 9897
 Switch PHY support
Thread-Index: AQHas2ZY7Z/8NkNpeEW0OOsk9zrWObGxuiBQ
Date: Fri, 31 May 2024 19:39:12 +0000
Message-ID: <BYAPR11MB35582B2BF1C72C8237E96C43ECFC2@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240531142430.678198-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240531142430.678198-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <20240531142430.678198-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|PH8PR11MB6904:EE_
x-ms-office365-filtering-correlation-id: a43a1c59-8bbf-4eeb-69f4-08dc81a958df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?YNKtPAfkOwblIyF+sXBaMje54cVIxRABuWRBnN11v6SNDitpEz60bwIxCBZc?=
 =?us-ascii?Q?DCkvn6HGJvh/HI4L6SDPgCEg9qKm1dCDx/IMzR1wQughfOppH076uAHvqcYC?=
 =?us-ascii?Q?DoQzGFVGHOiu0sWrsYw+v2NXsTSEH0yhWfQ97H1yb943pwa3PyT3liozN5HM?=
 =?us-ascii?Q?iRUkh7n6ZgbatqXH+DEhdJWcBpZNTuFxfThE8zeA5QCTs+hDGOi90bGS8ZL8?=
 =?us-ascii?Q?UA6CPrRCJvmmWTJyFFmiLO7OJ8kewjY//jaQvEGP3tNfd6acInXahu+F+e21?=
 =?us-ascii?Q?58FmLnm9Q4AQmJvxaoCVakHWRSb9mZ460dkAR6eGgEaiCy1nihuOzNo/U85P?=
 =?us-ascii?Q?bqVQfQ7RfQE8b3+5EEo+Xj5I0jYbGpH0aV3vgLHVo1p0g3ciFG+jHLAHyD4x?=
 =?us-ascii?Q?1WnAPUO1yCd383P07d4JaLhDxIwe6JnZYWZSAVLZpvhO44K8J5LxcBFaiRYj?=
 =?us-ascii?Q?C97DLXHeOKuh03+4Jo1aJSjCljx4QmURiC4CYytv6TZ0Ej96Uu3e2f3Qzgue?=
 =?us-ascii?Q?4U3+vP2/IjTyUNs95MUXlXes+uj3piV6oU/STJZrkEi5TCE4pYpACeQf2gj2?=
 =?us-ascii?Q?Khs4AeoAzEvCBVX6uEo/Z8hHP1DmhYoFfw9dnH+VO8+RurF+FX9C+5/mxLwl?=
 =?us-ascii?Q?lDEAopjfM8RSxlQgYkbMsGco/6krlOLsFeU8W3FBGzaGB4rmQgPhyT1pnRoT?=
 =?us-ascii?Q?bPJgdaqqqv0A6ZZTF5owl5aVO6rLGqaE9zp1NGMgN1cajLR4HDzc64dDECPi?=
 =?us-ascii?Q?HMOmCEOQX5gITTmBb12t4RMzUvwtC/C5TUpfUg3mdC5mUMTrfzmKP96SQhyN?=
 =?us-ascii?Q?Ced+Yw81SgSkmb6fYWFjMdAJsY1wLPYqQSvCYIDDYGDRi99bgOqCK1bgc9tu?=
 =?us-ascii?Q?slNvlt70gzNmC6vj/we14eZoJqIPRHzAolpWNnpPMx6obrqCL3IlIzbH/YfX?=
 =?us-ascii?Q?9vA8wvG7+terwA9sAc6mDzfoEhAilBoAc2FZNAWon47WfBqhZLmWz2V9O/lC?=
 =?us-ascii?Q?izqVWC+Am0urvF38YzYJztOit5d9jfl0ZJqyM+geHJizr8o+zmFC7cIzzSY9?=
 =?us-ascii?Q?hRNkc9W6/DPLKcRNbK6ff+/Tb/sFrtwOHnv/fF35IHsjAQi67RqdtItPul5M?=
 =?us-ascii?Q?MV9gEEVL8SKh7FCbsipjqbwQ+wEfC1tjH8xSSLTfsSV9WzT9Lpud1JyobBGc?=
 =?us-ascii?Q?vpQGF51+ZmQd03bH/kLAAYsgsRQSDMBXGaXkMTdNzYBaS4nH93YMWXQ6f6kI?=
 =?us-ascii?Q?o4CBqdxjUIowI5ZPe54zFk37h5YR0FSJbs6KPwJawe2AT4aDV3F8V/Rb4/Mg?=
 =?us-ascii?Q?6bo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gtpwJJk2EegGZWoI+73t6Gdlje+OUfIkACCJiZS7BCbfZn8uLDpO1nRV0Xal?=
 =?us-ascii?Q?m/Y4HxqnSNCYYR+LBGYRKFL6PZVolsDB/J1Cr6Y62iLEFWY7d1+XrMkOPosi?=
 =?us-ascii?Q?ZsSSvJPXGxlcRbUPpPw2qlpJ0skJbPkW10jpGBAMiyO+uPszefIgXrPTawNY?=
 =?us-ascii?Q?1J9Q8alya7O4atg3PIwt4IkV3cPfXQHdF4fNEn2AtcP3kCWRtfEZ2Q/L4oCn?=
 =?us-ascii?Q?BOLYSXpI3yr/N9yuFYs38Fol+ScJKPDOWTmmZJ3uSxhoaaatz5PaoN+WnpyE?=
 =?us-ascii?Q?08vF0DgGdZIj19bIdBsEcue2eAD3nc9Wv+tH63RWW2jTTaCwlaOGp36ugNGu?=
 =?us-ascii?Q?H8fhOIDpSUqSSFbmUuhJms9NoJpHyA3EZ3RasfQBOdFSDuj3iMS97F9QaZMC?=
 =?us-ascii?Q?95xujIDvqB4cSZutmVqSlYUhyHxa80jYeR0+mqMd3N2xaFWifJ4YTzaJgpBp?=
 =?us-ascii?Q?soFZG68TULwncae6C8HOFsSWasIAkx1gY4SlRngKvZbXD4MJFlHLePUa8yM8?=
 =?us-ascii?Q?SZ1EFAv17mpzQI6HoBk8sDE7dE456WDRe0lOSsStC8SZJIkABLeaQLN5kOP9?=
 =?us-ascii?Q?4zBNgwERGfa9yt+njYuBmPKZxnMfYZ6cQno8+Q2iaSoCmww5ZhvoFNCzXsw/?=
 =?us-ascii?Q?6FQS9HjJay998DKvioTJTdPwj2Xts3cq+umAALLIYSsX7z+S8uGi4I2Vd9Bo?=
 =?us-ascii?Q?H5IKcsWSgntN8FbMEVjxTvVQkb/UOb+OhLeYIbC3y5BWXW6bpuIdYppWq23H?=
 =?us-ascii?Q?ImBBWJaX+w+Q7SpA5wLmzbxbaUyaQMzlOyEBhnxXfMKacen8rKoNBz8OgXhU?=
 =?us-ascii?Q?kbMc8JMw/NcA3W+NP52FNBTdxKSiPeCpk2/Ng7lMrD27nFmQDKW8uCdrIYH7?=
 =?us-ascii?Q?rITqQ5o6OCM3RcnnY3M64pdLZA0YH6yegDGEdQdmFEV+UHtfIKqytARjtQ8f?=
 =?us-ascii?Q?2VhZOhNx/llLtG65dPQyCcUYC/VnbcMaR1RliQWleijz5Y/WG6+ysCjsMYEG?=
 =?us-ascii?Q?oC8e/TyMGFihcAGDj63BN9tnXL+OyxQ7fjtlz5cPa4qB5i0BV3q27RC5KV7s?=
 =?us-ascii?Q?KC9TfYn8qGwGh8m9L7HIr/XHOo+Y6vh4G4IGI74p+PpxzTi3pl+CDSscRdg2?=
 =?us-ascii?Q?7NYse8TdZ/2i3YvN119vHAwfM/ccxaU9LVDAiQR1TWt7cYkhd2AvvN/W7HP4?=
 =?us-ascii?Q?+FtOeiJBgz1dcmjiiEvAgUZU0H/3TjAGFgYPy7CQQpPB5AFvvQthgL7s6MuY?=
 =?us-ascii?Q?rpUmQNCWaegBYDeypVhtcalFpouDpX+60pA6yPrC8/sNoPp/EDSg9MyCaT8U?=
 =?us-ascii?Q?bIbSImWULLZr9Q6rLz3HA9HnH6P0bi290V4AVYydXs7Vmy8xseAcwsIXsAJS?=
 =?us-ascii?Q?aomYIGJ5f4+G6CY8v+NoQ6Tk5FsCE3nkMAGW8vQ22yo4rXEJ1M4Ohq7tZ03o?=
 =?us-ascii?Q?hrHmm0oqoV7SqoQNNsHhIniWFZ+goVMPZGWkYLodVbBWt59E5mXyeAfAt4sa?=
 =?us-ascii?Q?GeRgTAG9+1RZAWtQIiF1x8Ss5etRgEOcZ57hxeUYu/pJKZo9YmQEQX8q6O5r?=
 =?us-ascii?Q?YSBu1dV55Ubcl4gYX5rIqvunBcBlj32tB0S2yyDlq+37hE1lb9rOgS8et8mU?=
 =?us-ascii?Q?og=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a43a1c59-8bbf-4eeb-69f4-08dc81a958df
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 19:39:12.0229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HR3uV/txx3Kg7NyRX6RkXlqMuj+C1rD1DsXMkHxrKVl4ZYJ5nw1v4I4yINIszRdNjIhkAjQy3UcvXtpQAuclgjVLNsvApIFPn8rE3sTlPRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6904



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
> Subject: [PATCH net v4 1/5] net: phy: micrel: add Microchip KSZ 9897 Swit=
ch PHY
> support
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content
> is safe
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
> v4:
>  - rebase on net/main
>  - add Fixes tag
>  - use pseudo phy_id instead of of_tree search
> v3: https://lore.kernel.org/all/20240530102436.226189-2-enguerrand.de-
> ribaucourt@savoirfairelinux.com/
> ---
>  drivers/net/phy/micrel.c   | 14 +++++++++++++-
>  include/linux/micrel_phy.h |  4 ++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 2b8f8b7f1517..8a6dfaceeab3 100644
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
> @@ -5495,6 +5495,17 @@ static struct phy_driver ksphy_driver[] =3D {
>         .suspend        =3D genphy_suspend,
>         .resume         =3D genphy_resume,
>         .get_features   =3D ksz9477_get_features,
> +}, {
> +       .phy_id         =3D PHY_ID_KSZ9897,
> +       .phy_id_mask    =3D MICREL_PHY_ID_MASK,
> +       .name           =3D "Microchip KSZ9897 Switch",
> +       /* PHY_BASIC_FEATURES */
> +       .config_init    =3D kszphy_config_init,
> +       .config_aneg    =3D ksz8873mll_config_aneg,
> +       .read_status    =3D ksz8873mll_read_status,
> +       /* No suspend/resume callbacks because of errata DS00002330D:
> +        * Toggling PHY Powerdown can cause errors or link failures in ad=
jacent PHYs
> +        */
>  } };
>=20
>  module_phy_driver(ksphy_driver);
> @@ -5520,6 +5531,7 @@ static struct mdio_device_id __maybe_unused micrel_=
tbl[]
> =3D {
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
>

I am curious about this KSZ9897 device.  Can you point out its product
page on Microchip website?

KSZ9897 is typically referred to the KSZ9897 switch family, which
contains KSZ9897, KSZ9896, KSZ9567, KSZ8567, KSZ9477 and some others.

I am not aware that KSZ9897 has MDIO access.  The switch is only accessed
through I2C and SPI and proprietary IBA.

It seems the only function is just to report link so a fixed PHY should
be adequate in this situation.

MDIO only mode is present in KSZ8863/KSZ8873 switches.  I do not know
useful to use such mode in KSZ9897.


