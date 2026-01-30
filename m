Return-Path: <netdev+bounces-255030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI0hIbk+fGkxLgIAu9opvQ
	(envelope-from <netdev+bounces-255030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 06:16:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCBEB7423
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 06:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4268C300F9F7
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 05:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FF1346777;
	Fri, 30 Jan 2026 05:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="I/9lZOYe"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C1233FE05;
	Fri, 30 Jan 2026 05:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769750197; cv=fail; b=fKFW53SKJ3NJ0DmXYFyp8PdG3mo9SvLGzFXkPPGFMf7pcte3yTE1mbS/6oiPBIYEHSsbhVta1kNCxCRMlhbCX4H+elIJ0AhCKNcpotPzEHGIj1G+s2XvSY0oENKW6chHpHELpcqIebtqDq+vDpdPV/Fo+DOmAm/MT81q0C3+8kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769750197; c=relaxed/simple;
	bh=ss32nGpZWAdnq+YoxLMhV8aRAgHLUlLczn2xdYPPHzI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mOgqcIGqwFcSc/XhU05ND7ZEwkI5kC0numDt84KIPJssx2ic6SdgJMQdxKxSNCNzFPJegIe0mKFrzFpOKKza8+GWSbVG8HHEWWwAIhcKzEH+fDKqI5aqggVtMX+sBZoyKcSL4AZ//Y8u29pcTb5XjWiJjBLgz1czjSN1L0zVbxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=I/9lZOYe; arc=fail smtp.client-ip=40.107.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhzVnM0NgNdsanfClWwp2U0HkofWryJJ/QtB2BYCJcbMILS9pk+5UlsrmqtNd99pZb2FsJ4lv3doGnuU5ntm6cd1Oj6lirVS+ZGAnzp3DElcX3NI2nl1CA3Ifc7nXtiDhoDqpNLQsJ6rFP5cyaQ2BV4SMFwU64ZXfl6iGti5zY71GLJrYKqsXyq+sgctUprgAMZrp02WZdLy7O3Uc/6L+8PFRCcHqY1JpnfxTGYrXkSU0tt9aZK1rEV6/HfkMTKtsDSSeMnoF17DFHsJFIX1sZsyCyBnRQ16P1sfd6hwDBfM95QdbWa2l/J36bHRO5sum5oAr0st633PDbtc/QDuWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFXSSuq8GTE826ELmBnum7pQUHjtXTgOUDsl5+0IsBg=;
 b=uil+gLIVXWV/OW3Tc0gLowMXe4nm/lM1jTyeeKDjWgaVu9Sa5PZLv8jdiUeS4vzG+NdoF+CenrAi1UbdkN5b4FcV4+TvopnvAPTFeXjLhB7FuEgS1GSdhQNRY9SXkKYPZ+7xHOtcOzn0EGTyNzOLK40WnX99i23wUrhLHGGbiuQH3gBMVc8M612+NPXM+F9iQMGwUkRHv/VRSueQuleq/DVib1dBO0Q4Gs3lPCKvGKo/ka7Mn/IEvaoSWvqXpuAcgsbd4ynwhtyL6ZaliEWR72mGkpQOltSL1bS5pjCkbsDV9rvmlQeTaUKTsjicVG3rzo9tQsTNv6BLvGVIhjYNgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFXSSuq8GTE826ELmBnum7pQUHjtXTgOUDsl5+0IsBg=;
 b=I/9lZOYeceMnRxyqGkZlLY06XjMPUu7HCKMBWrfA+NVjO4btfa7mVgICuMWCA5pXf+xwKQFyT54QhiqhG3XQsFWVHkx7iEa3OMb8/QBUqr4valf7nOivkVhKhOMD9Q+2KalMlLcX+7EDYxfQ/+TJSZuDAYkKhjyNEAVhGDLvnVID0n4klHL1pnoNq9CDHKzSObR1QnLAhlEVv+qmwEjs7wt+yinYxu0D3Mfd+Ec48IHi6eoCXHTDvwLN9PkJPffYmQz7bwmdXYV5xWu/S8U5q/A2ulriz4+ETEyFmR0omYvpTdsKWBnusILGnHu/c+egU7gFWBCq08cmkm7LYrxL1g==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 MW3PR11MB4554.namprd11.prod.outlook.com (2603:10b6:303:5d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.7; Fri, 30 Jan 2026 05:16:31 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::caa6:2f2c:cd5f:90d9]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::caa6:2f2c:cd5f:90d9%4]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 05:16:31 +0000
From: <Tristram.Ha@microchip.com>
To: <kuba@kernel.org>, <bastien.curutchet@bootlin.com>
CC: <Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
	<horms@kernel.org>, <pascal.eberhard@se.com>, <miquel.raynal@bootlin.com>,
	<thomas.petazzoni@bootlin.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v4 6/8] net: dsa: microchip: Enable Ethernet PTP
 detection
Thread-Topic: [PATCH net-next v4 6/8] net: dsa: microchip: Enable Ethernet PTP
 detection
Thread-Index: AQHcj2xUKvLyAV06gUm3Yyi8usJiXLVqH84AgAAPZmA=
Date: Fri, 30 Jan 2026 05:16:31 +0000
Message-ID:
 <DM3PR11MB873640D9FA5A1CEC9EA36B2EEC9FA@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20260127-ksz8463-ptp-v4-0-652e021aae86@bootlin.com>
	<20260127-ksz8463-ptp-v4-6-652e021aae86@bootlin.com>
 <20260129201720.0a63447b@kernel.org>
In-Reply-To: <20260129201720.0a63447b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|MW3PR11MB4554:EE_
x-ms-office365-filtering-correlation-id: 01d7c0e2-5109-449c-ba28-08de5fbebab2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?uDtyZYEIc32LfjAxyn+DYr2xuFgm/NMyGQHrdmm6qU6hCVR5U7E3c651oD?=
 =?iso-8859-1?Q?sMDhfhSLMf3sFUIuRM3JJGWSpGoOLqMM2AEf+yn8D8BDelY8uDlrzNAxSH?=
 =?iso-8859-1?Q?qto8eCRYpvL73Ki3zlXhaM2H6DlvtxctOrhQXkl4y+KrI6x45wNNlath/b?=
 =?iso-8859-1?Q?svmxWXurfxHwTRV8MWnc3GestOATPtZg6VLIDFDfK22WHs9opDucpXtP32?=
 =?iso-8859-1?Q?nCchlG4sMKeObSRcs2zBfBqTxTot1smXcLpTcQPiydQCYToGq/KjE5zZS5?=
 =?iso-8859-1?Q?eunkYGbHtwMzuVtfdLvteJXsPv4P1L+B0svegjR/Ya+rfZTPSi+PruQPjI?=
 =?iso-8859-1?Q?M7NRb7pGA3A2JlFyFXo29D+rE2eukhba2q9NgmeGANx0o/X6aUFWHiYrdb?=
 =?iso-8859-1?Q?vZTmorcfPevCkLSPpaP6iVn4luoN72a0PaK88HRGJK15WimCNV52Hri3ZK?=
 =?iso-8859-1?Q?FeonME5qnBmO5cHhcEtFhuQPnSh6QVYPaTy7K0QaDxre1TBK1B5Ao0VZyO?=
 =?iso-8859-1?Q?/LphPWTkBnagCVyIlgCDWn9SqF1+8F5gkfXIoUtXfRPi7inw6NThg+ZhUX?=
 =?iso-8859-1?Q?DY5JNWZQYOQpPUBfGQxOwuHHUrTHPrhAZJ5NzDGDCwgISCjGHbUOUIh1q/?=
 =?iso-8859-1?Q?ipYh3+y9oSVOYqUHSTglLhwnCjb49WPqfDdbqEmihkpXwiPnOod6vEpKjj?=
 =?iso-8859-1?Q?U6deLRtOzY2obdO7gO2t1AFarJ5RRopz+l3UryS9fCDXt3LyHmR3GMkhF7?=
 =?iso-8859-1?Q?BAp4tErC1z8MTiDzPJf0RDYeCFlr/q2is7s+2QyPSiaPkoGIBO5wr9xpO8?=
 =?iso-8859-1?Q?H3bExuTeBXNE06HcyuKAz+ISI1i952semVn661dZfsOIk1B4UPBHSQAUHq?=
 =?iso-8859-1?Q?gQncCpY7m3tK3S1uXfuJjr1L3+poE3ttVTIt4IeBbTtgw8cZuAloVAD3xV?=
 =?iso-8859-1?Q?lQTtokA6exkijqL1KGFuChILjPQ4jc8Vy2Rx/65a+1pkGS/At3PEiRed2e?=
 =?iso-8859-1?Q?tmYpVW9VU8sm6S1Cnw7piRkOpERAI/GPaHZilKF17Vc4W/2DcmPeR7xsEE?=
 =?iso-8859-1?Q?zb0U7yeWNc8kCl37BMPmv3wpvng42YPj7W36LQqTxVZhFM8AK55fl7Wv8a?=
 =?iso-8859-1?Q?hwOCX83dsOoUugAfX5F+7wZXYx9+C/OLsE/HkW5Fb0fTMgSkycuck6odZN?=
 =?iso-8859-1?Q?ztmO6+1tSjtbPAK47ghbWyUocoyDnKLg4ZKKGvPjdIJ+ZsvT5HLGs6LWvQ?=
 =?iso-8859-1?Q?LoqOpXf4n4DEMSZ0yhhdF81Ji/yMK002o6jGzmjBUjiy6PRDtrbw+Qh1Vv?=
 =?iso-8859-1?Q?kg/KMt8zNdp13n76DRHjH6Y+MNelO8QE9wY4psb2N7Opode4ZcyLOuBGTE?=
 =?iso-8859-1?Q?Rx7ihbscS2D/I6Cmgug7ZKRI9zCiwisx7r+AJywuAZjzuIEDPXb7MvTrp+?=
 =?iso-8859-1?Q?ZkNlG64L1kZ5BucQOeDDglcj9l8lG39rsO/C+M3C3vPPaRkJhY2ewFXN5V?=
 =?iso-8859-1?Q?1H7/11E5GypmbIkZp8DnTjiPc8Ud/AzDFwFOazvad6Y5P6b0iKU0zzZFDM?=
 =?iso-8859-1?Q?PwSh/tdSHgWeadQ1A5bShgxUP/jEKHDoab4utgRVVlp6kDzM+artJnYrhF?=
 =?iso-8859-1?Q?S4wSK94LUljE62G4nJs9bSvHpUrh8gqQV0J7LihC/l9ErTpIW17RYe8NUv?=
 =?iso-8859-1?Q?plxnjZBrBduLIRgcMQY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?MGaVoQtfrpJV8KJFM9foQ9My0VUiQofKqfuvIaiqCm0aJlaWiqb3D/onA7?=
 =?iso-8859-1?Q?q3wkh/AIkkALOxtBmAci1xVb1P6rsX54fTxL+qU47MSi/koPsXByICqSBp?=
 =?iso-8859-1?Q?3x1bNZpgIxVN1V22CdgY9v2VMzUMiu+dSV2f+tYmKUhsiTqpOIIxWYn0SY?=
 =?iso-8859-1?Q?wSkaGtm13VVQ4Ke5CQWolVZbgWdkR616nNZl/Dk08SJA6WmlK92KPBfhjb?=
 =?iso-8859-1?Q?AwAg6iduH1Ljgk/TQIhGk+apuL788Qx9fpIZZi3zdeHAE2tOOF66kpU23Y?=
 =?iso-8859-1?Q?S80Et84vbHisG9LCttIHB0B1GkUsrF1S5fuBRxwdRgRReDx1nZnKMzNzVA?=
 =?iso-8859-1?Q?Bh9w9AzAy1AKDi0FsveDv6YTtR9aGwycdOr59ph5HZiJs4ad7wy9QWSfhs?=
 =?iso-8859-1?Q?L06gHeggNdN9b3TiLIizw8NB4MT0GEhXenTGGZDIoi5RQUrdsd+SD6v8Dx?=
 =?iso-8859-1?Q?ZS6CJQPsjqXC1/xKk7AP6mypCkHfkohQbB84p1np4mD7qtPg1ecpL54eqX?=
 =?iso-8859-1?Q?oJNz+Id5EDJGV3Q2bcM73Vm1twaQ6vadLXwLveMrHu+EXtNl6L1+2E0O4b?=
 =?iso-8859-1?Q?wFpxSCa0MpSG94/kR4yQPYBGn1xNtnas+ZBYO0tUjrprtivSl2jIYPmE2P?=
 =?iso-8859-1?Q?wbEOj4VdZkKVVwQ+XZkh2jHdX5Y/k1hw5npNObumWMTIagwlbMOu4x1gnL?=
 =?iso-8859-1?Q?dZUO1iPaUkicDeQeOEzYyk+EZiNcSVTsQc50BcCYLp/5QI95PN/GpepVmu?=
 =?iso-8859-1?Q?Jc5bcjUIMGkpx/w+Y3A8UzcKdNghDdXIeTcZ/lcij4ssCfwRzai78rawyN?=
 =?iso-8859-1?Q?xvvTB1I+zIo8Hny6H063SKlQviAwLeAJyl+30VagOU6tQ1FL2D6LChGXuT?=
 =?iso-8859-1?Q?tNMOY976c9TB0v4M8tm+reKzWd44Juj701VvR7RUT86UET396Xgw9hz/K6?=
 =?iso-8859-1?Q?jE6z7fVMUnMtl2PWAd++3v9po76F3IbxrsegxCmEtsWIBW3xw5kdtODRVI?=
 =?iso-8859-1?Q?CfmPbMwGkjtv5jldl0rI9nnnhy8ljU/kE/OI9bdrmITBHzVopBxIYMrM5l?=
 =?iso-8859-1?Q?Mnw1YD09CB9a34lPXSQjRavHUJqMr04RpQxYZW86Gxz5zbm/ph08eKKbtZ?=
 =?iso-8859-1?Q?6q2brhzHTi82bXwlTL4HKipUn5eTXh5q4nHf1qNkcwLvtt5btt9CSdrWqA?=
 =?iso-8859-1?Q?RL4eKUaKxIK+lUO4/ceW8K1kmvEx8GT4W1QEXn9GFpRKxOgsdS7GmjRT1v?=
 =?iso-8859-1?Q?rw/GomrcmH5N1O7LDbdCr/jVv0Xk2OZ9+TaUeRHJ655/Pp7OC36Z/BlSsj?=
 =?iso-8859-1?Q?zqxubEarB8cByMVmCOoxXSddzVm6SFbQXS2Dr7w8rzmMk1x5LEw+JSfp0W?=
 =?iso-8859-1?Q?DtGa61LuPIFj8MR2dyN8tJ3wt8qcskrTt7W6RSRujflRWYkNSTOd87ps9U?=
 =?iso-8859-1?Q?IULUM3/6NAG/1PKVWZvTw+CSSa7pHHWG9phgUby1P7vShMrLGj4hE3RVVS?=
 =?iso-8859-1?Q?9lYXss3bAHr3FVqWVO8PzoYONcX1DE7UacbqBg/IjU8j43BnVhrb/3MkdJ?=
 =?iso-8859-1?Q?lk/IaVLTLAYwPmjmcZWPo7oNopI5JTRLzcAtzyK8aJ7fp7ooJV1HTN9fkM?=
 =?iso-8859-1?Q?DDSzoZYhlrQXur8BgcJGI3yr8JiB/x/h6iHSJ3gCJ7iJa6Z4utg4NJx8fQ?=
 =?iso-8859-1?Q?YWqw6I3cwMr929+B7XvwD5c2IgA83ujjPsKynRRF1rhUsavIQxnX8s2Lbj?=
 =?iso-8859-1?Q?GLQpM3PqGzntil+zKu1SNnUo/mITGsyvApiMBpVic0dk20esNpZSGBmSJA?=
 =?iso-8859-1?Q?/boCHIfKWg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d7c0e2-5109-449c-ba28-08de5fbebab2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 05:16:31.3832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3GssLTej5UOLdPg92svkrAjQn8ftUGNokl0Xom0NZrE3hu2cvVN9jiddo1zGrIhF7GCXaZqFwzxCG/FT+xEo8Rmiw6Tu+1gDfdY5zHCS4lg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4554
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,se.com,bootlin.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-255030-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[Tristram.Ha@microchip.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DDCBEB7423
X-Rspamd-Action: no action

> On Tue, 27 Jan 2026 10:06:48 +0100 Bastien Curutchet (Schneider
> Electric) wrote:
> > KSZ8463 needs to enable the Ethernet PTP detection to fire the
> > interrupts when a timestamp is captured.
>=20
> Is it worth stating our expectation WRT other switches given this
> is a shared function (not advocating to add a condition to be clear,
> just document).

KSZ8464 uses the first generation of PTP engine while KSZ9477/KSZ9567 and
LAN937X use the second generation.  Most of their basic operations like
transmitting are the same.  KSZ8463 enables 1-step E2E TC operation by
default while the newer switches need to enable the function manually.
Because of that the PTP function in KSZ8463 is disabled after driver
starts until the Linux PTP stack wants to enable the feature.


