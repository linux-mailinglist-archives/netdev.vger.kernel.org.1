Return-Path: <netdev+bounces-122866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3712D962E0B
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 19:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA37F1F251B2
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 17:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4888D8BF0;
	Wed, 28 Aug 2024 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teledyne.com header.i=@teledyne.com header.b="fU31c1xx"
X-Original-To: netdev@vger.kernel.org
Received: from us1mail01.teledyne.com (us1mail01.teledyne.com [140.165.202.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC3642069;
	Wed, 28 Aug 2024 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.165.202.241
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724864457; cv=fail; b=RugpYqSaJzINeofzsGq0gRqnsQ5BkKfzWhLSC6hIakPcoe4dMQiEFuP+XPiYLd/ONoqiiN22oWfSIipwDIV0Bdb00+L8O4sIsxhQiGPaBDgNaWlH3dEh0pEGsSKORCOz/lSlnMG2mRXmJA8fiEHwv+ezSzezvm4LpHw8nlB/R7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724864457; c=relaxed/simple;
	bh=wgxnoX+8tNh5s8eMWbiagyvg/de5932uzDEul0t7YD0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E8VKCu9DgTd3mZkVNyrOpDH69GZLdv/2O1844t1IcUeiw525ShMYMr80z9/o7VjFYnJCeWDsvodd7D73ar2yiYHYGuRJNaBLE2gHVS+bKRq6z2T87XbxV7vMXeZ26Zpq44N9Jh7Bvu5CCUNTmszpp6s4MUaaUnoc3Efu/4x7L6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Teledyne.com; spf=pass smtp.mailfrom=teledyne.com; dkim=pass (2048-bit key) header.d=teledyne.com header.i=@teledyne.com header.b=fU31c1xx; arc=fail smtp.client-ip=140.165.202.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Teledyne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=teledyne.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=teledyne.com; i=@teledyne.com; q=dns/txt; s=TDY-2;
  t=1724864455; x=1756400455;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wgxnoX+8tNh5s8eMWbiagyvg/de5932uzDEul0t7YD0=;
  b=fU31c1xxjzZk3dRImZDQuoqJ4+3GtUCExnxOm1E3Vs7GUzUkFFVQvCKP
   9GNS2HTzcxyWcK1K4DpVGzSYq5Eg25WEiAnaGYk17oa+BPvZsQiUaAhjm
   kMvIZLK4glOwOTPYBqgb+HrZnkwXgaptcgvccbSNKucep8Yhf4tNkl40i
   YSuAhbVGp/CRKsn02sgDVPehpM9H+d3ElgSeADlU8BAu8W/kzY2UMQuWT
   ZzbfRN70zRVWGAu4Ao9BA0+iy5aof2L0us5c3otIOZDXpSeMVE1ygzU1o
   I6oquEOI1CnjBQp3AZmOJy3b3CO5hLJFzYX9XfRhLp3k0htGN4yY8V533
   g==;
X-CSE-ConnectionGUID: n/B19tviTJ2eb5WxcpUVBQ==
X-CSE-MsgGUID: 9+rxcIkfSnSEFKGTvquTkQ==
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:aJeGsq5iBEDmDsAJvTAxDgxRtCbHchMFZxGqfqrLsTDasY5as4F+v
 mYcXmjVO/qDZjbyKN91YIvi8hkFvcXTydMyTQFvri81Eysa+MHIO4ilIxarNUt+DOWaFBg7t
 51GMrEsD+htFiWA/k/1atANiVEmiMlkk5KlULas1hhZHFIiFWF4z0o+xobVu6Yw6fChGQSBp
 NjulMPWPV6hylZcP3kdg065gEoHUM/a5nVB5jTSWdgR5AWCzylPXMpFTU2MByCQrrd8T7fSq
 9nrnOnRElPxp38FFt6jm7DnRUwGKpa6FRSOkHdfR5+5iRFEoCEouo5jXBbLQR4K49kht4kZJ
 ORl7fRcey9wVkH/sL11vy1jLs1LFfEuFIkrg5SImZf7I0XuKxMAyhj1Za08FdVwFu1fWAmi+
 RGEQdykg9/qa++emdqGpudQassLKo7BZdIDpHBc72vUB6sZUZvbfpvg3IoNtNswrpgm8ff2W
 vFALARXSS/vJjhlCg9OTo4yjaG0i33yfyxepRSeoq9fD2r7lVApluGzbZyPJoHMHp09ckWw/
 woq+0zCHhwCNNGZjwWE9nGtgPTngS7/VY4DErD+/flv6LGW7jVCUEJIBQDg/5FVjGbvGMhPI
 G0X9BEoloUc12OXUMDgYx6B9SvsUhk0HoA4//cBwAiLxrDZ/C6dG24CCDVBAPQts8kxXxQp2
 0WPktevAiZg2JWTRG6R+6m8szy/I24WIHUEaCtCShEKi/Hop4c0lFTDSdFnHb+di9z+Azb7w
 zGS6iM5gt07k8cP2qOn/FbOxTyhvJ7ASAI49AzTV2Sk9St8ZYW/YIeo6ECd5vFFRK6fT1KGu
 HEf3caT9voDJZSMnzaKS+UMBPei4PPtGDbYiENjHoRn/Tm//XOqVZxN8DZ4YktkLK4sdTb3b
 Ur7tQpP6ZpXO3W2K6l6f+qZBsg3yKHyGMjNWffTYd5DJJN2cWev/zxkbGaT0nrrnUxqlrswU
 b+DeMyhC3cyE6lrzDOqAewa1NcDwiE42HP7TIr+yxWhzKrYY2SaD6oGWHOKb+Yk/OaHrR/T/
 tJ3KcSH0VNcXff4by2R9pQcRW3mNlAmHsmztdRSbeHGJwB2QDhnF/PAh68sf4FpjqJY0OzP+
 xlRR3Nl9bY2vlWfQS3iV5ypQOiHsUpXxZ7jARERAA==
IronPort-HdrOrdr: A9a23:UTJJf6CDhbTdp2HlHegXsceALOsnbusQ8zAXPh9KJiC9I/b1qy
 nxppkmPEfP+UwssHFJo6HjBEDyewKgyXcT2/hdAV7CZnithILGFvAF0WKP+V3d8mjFh5VgPM
 RbAuRD4b/LfCFHZK/BiWHSebhA/DDEytHRuQ639QYqcegAUdAE0+4NMHf9LqQAfngjOXNWLu
 v+2uN34x6bPVgHZMWyAXcIG8LZocfQqZ7gaRkaQzY69Qinl1qTmfHHOind+i1bfyJEwL8k/2
 SAuRf+/L+fv/ayzQKZ/3PP7q5RhMDqxrJ4dYKxY4kuW3TRYzSTFcdcso65zXIISSaUmRMXee
 z30lcd1gJImjfsly+O0FzQMkLboUoTAjfZuCClaD3Y0JXErXsBert8bY41SGqm12Mw+N57y6
 5FxGSfqt5eCg7Bhj3045zSWwhtjVfcmwtqrQc/tQ0pbWIlUs4mkaUPuEdOVJsQFiPz744qVO
 FoEcHH/f5TNVeXdWrQsGVjyMGlGi1bJGbMfmES/siOlzRGlnFwyEUVgMQZg3cb7Zo4D51J/f
 7NPKhknKxHCsUWcaV+DuEcRtbfMB2EfTvcdGaJZVj3HqAOPHzA75bx/bUu/emvPIcFyZMj8a
 6xJG+wdVRCDn4GJff+rqGjqCq9MFlVdQ6duf1j2w==
X-Talos-CUID: =?us-ascii?q?9a23=3A9pvRJ2v5CoSRMQzdgxPigOt06IsjNVeEnWvOInO?=
 =?us-ascii?q?aU2tjFYKFQketxoldxp8=3D?=
X-Talos-MUID: 9a23:eeg8bwlweYWGKm7G8VfXdnozd9146IWtBnsLqrgomOa4KzVtBzSk2WE=
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="190768336"
Received: from us1-vpmsg-mbx01.tdy.teledyne.com ([140.165.245.30])
  by us1mail01.tdy.teledyne.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Aug 2024 10:00:54 -0700
Received: from US1-VPMSG-MBX01.TDY.Teledyne.com (140.165.245.30) by
 US1-VPMSG-MBX01.TDY.Teledyne.com (140.165.245.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 12:00:53 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (140.165.200.224)
 by US1-VPMSG-MBX01.TDY.Teledyne.com (140.165.245.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 12:00:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFzLurRWChGSCznPFOsVfhaH74H89dQgGabyzTk07xA4M4PJte6hL0bXRRIzmc2sMcEEQ/+z2XLk3z0QrTQso5E949wai9QBE9tVqAmOZmvkx4Q0yC0mbWBP/dG4FQAqm5iYue6E/NGVkqZx7+fqOadOPLPaBnD1x1piYjU2MbavMkOW1eDBGt/ojKZyaFF7Ab7bPecKImP51vrevXdOTr3hBR0Zbla3i8M/hvhbSY2Qc4pQ8YGnkGresL3Em3woylU02mf5Xb88PEN1R4lF2bepZmy5VIv0FDtWqKEDUZNnRVryTy5FvXKyQVNS1WzAbQY8Tts/8+eflwRnJXwGzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgxnoX+8tNh5s8eMWbiagyvg/de5932uzDEul0t7YD0=;
 b=H7Lu8bGT341Hi+3xXUdi2vn0p68ZgDzue5moW0CQk88RQulWLSA+wykRZi6vO/5aWePOzES/f7Eb1Atg4AhIFe2AbJj61/AFYZKGeWEmwBxV5gLyZN2RpnRU8PN2+iIuABC0mmbsKz7Wn+dEok7dLNlnvZI8e3fliihUNhISuj/3Tq8VGay44OwYM9zVo0FJo6up+p3j88oxdIfRfc15j3VSNqelteAawb49LQZBiLmJHymfryW3blPODh8nw1DRIKKzBRkJ2lDAzkOQ/4peoIun4xH8pLAe4Bbx6wVvWqwSZ/aSjHe2R8VIQH4418iNAxCU5FsDkgsaI5PsOz4S0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teledyne.com; dmarc=pass action=none header.from=teledyne.com;
 dkim=pass header.d=teledyne.com; arc=none
Received: from AM0PR04MB4131.eurprd04.prod.outlook.com (2603:10a6:208:65::17)
 by AM9PR04MB8260.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 17:00:50 +0000
Received: from AM0PR04MB4131.eurprd04.prod.outlook.com
 ([fe80::df93:b4de:db7:18c2]) by AM0PR04MB4131.eurprd04.prod.outlook.com
 ([fe80::df93:b4de:db7:18c2%5]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 17:00:50 +0000
From: "Wilkins, Stephen" <Stephen.Wilkins@Teledyne.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Conor Dooley <conor@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
	"valentina.fernandezalanis@microchip.com"
	<valentina.fernandezalanis@microchip.com>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Russell
 King" <linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next] net: macb: add support for configuring eee via
 ethtool
Thread-Topic: [RFC net-next] net: macb: add support for configuring eee via
 ethtool
Thread-Index: AQHa+WGRtuxNF9GXck6FjjyHd9mH/rI82TaAgAACCNM=
Date: Wed, 28 Aug 2024 17:00:50 +0000
Message-ID: <AM0PR04MB41311656237FCCCDBD3A497A89952@AM0PR04MB4131.eurprd04.prod.outlook.com>
References: <20240827-excuse-banister-30136f43ef50@spud>
 <3c5a3db5-a598-454e-807a-b5106008aa40@lunn.ch>
 <AM0PR04MB41316B50F68C83A73E57A82F89952@AM0PR04MB4131.eurprd04.prod.outlook.com>
 <08d191dd-bc70-4292-8031-d1d41036e731@lunn.ch>
In-Reply-To: <08d191dd-bc70-4292-8031-d1d41036e731@lunn.ch>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Teledyne.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4131:EE_|AM9PR04MB8260:EE_
x-ms-office365-filtering-correlation-id: 2abb46ea-a97b-4b12-64a0-08dcc782f80d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ek5ktcBFOeqIqP/zSEiryZMpHcpSKsQWTQ9NjpPho0BVkP0FkTJ6xwGKpo?=
 =?iso-8859-1?Q?Qxw84APEzjDfhQQXtKd6aBOEFfQpoRmHfgjZu5OTtwHbP88oWIjEbjkY7r?=
 =?iso-8859-1?Q?KrC/u0erUmkGa9G8yYv6nCfjeRx8njCadAaoCLbBkbg1D3T1VlimZt4bcA?=
 =?iso-8859-1?Q?kpk/vkxBq25BnbXgvRdCofwiR6WnlZ20KU2GWh29iabUs4tbjxfbLqs6Lx?=
 =?iso-8859-1?Q?AsHjKtLtIzknBiP3Of7258ZeAZit1vTCWx55o6ULTKtS2P9joRX8CnrwZo?=
 =?iso-8859-1?Q?GywTJePOsiQuZJT33+REZG/n+8gTvVM3PjbWWTfoU6YZy4hftbeZwh0IPV?=
 =?iso-8859-1?Q?I/3HwGQBsw7aSqtxVhRjR2g0qL+38NfdT1vOGB/F3qWVRcVK2374cPfC+l?=
 =?iso-8859-1?Q?+KCPm1u8gsGpuZE35wY0c+j0DqM3859khfXA2mC+m9IBS7iu+TDuY1eGbi?=
 =?iso-8859-1?Q?p8m/FBkwHH0Y4J+futUWsRCpcvabdcSQTLzjMJMjkCWSgpAXA3uTETupCL?=
 =?iso-8859-1?Q?9srtiFvCPIhIlVYDb/+d7GDHNbKH4TMiiGKTKTtpBrc5ZW4avKXB9xU+W9?=
 =?iso-8859-1?Q?AbI5QtHIeOFaIFJJ/CC+ZPrjZbCL3LgovmNMH1oOQOEFEJNwSsbLp6V70N?=
 =?iso-8859-1?Q?ERh4SpGac7mFqmjFWYl0ax51uZ7zc/bkxR3XSiwyri55ObJkd5E+R7hSai?=
 =?iso-8859-1?Q?+jM5JUKxQsHIm7kGxv2Qh7r0vMNyUBO91NoT2xxepRAimg7q9EooSHAmK0?=
 =?iso-8859-1?Q?KYWnllqTHIKhKaogxVa33UAJxqjlJrguFOFUJDTC8Beo5dlTObvJFPzr1F?=
 =?iso-8859-1?Q?I3quyE4p+hiXTELhxIhGXQTVb823m+fxWjJoomDbEZdjUdE93eNEtZObWn?=
 =?iso-8859-1?Q?zkdko3Y8SxGMIkosRsUqK9xexqEUtqMroW00D2z23qUxlX11I+T5YB33+P?=
 =?iso-8859-1?Q?bfYXB5h3BJv0aQACJpRODvhnpgghH/cVNjL/8NOcISI9QVuEVlCsdsIx4t?=
 =?iso-8859-1?Q?sIdh7F72RCnam60NSnLr/xpx7POgvLe6VswIbesJXppMmcabxy5tWjhHD5?=
 =?iso-8859-1?Q?r+LU72Foen2bS+MnQ/op72ZyRQEf5TGEe/W8ufjPZDRGCNzhawikvSkYVb?=
 =?iso-8859-1?Q?q2sLf0VECFljy632gC/4peORQmEPisWu2mTF7OJxC5Ib8jQOHCb4HvpIzZ?=
 =?iso-8859-1?Q?FGlScjw0Eg+bLx5coI2PFKqkx1jLQMmVyMtdAMW4scWP4UXHCkIA85SkFy?=
 =?iso-8859-1?Q?Xe7BgBF/jxYcl9AbGwZ1vJjkzluqK66MWx3KkjePnaJENoQZITTr1/9+lS?=
 =?iso-8859-1?Q?1jo50TfGqMRAqeolRjDNA4HCMQOTBom4nv0jTrlT9SI3YDvqoKNen6yeFC?=
 =?iso-8859-1?Q?D1n4sS9Wq0UUSZZ9i6KcUIJyGNhPItBF/cGCm11ndS9i4qs0XKiWCGzYkV?=
 =?iso-8859-1?Q?Gaof+gAcjgtg4jlNM4kd7+5ZhPKNHvHH0zgYdg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4131.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MBvBiQ3+PtLUesrJ0W21KZQ7c4O4KKWXlUoMvxRWS32/hOFsafDL0gCaMB?=
 =?iso-8859-1?Q?xWq6mmp1Xx9Hnw+LO/aI7ufGtCLFGwnedl0mfA51Lk96IS5+IBp+p/D3bg?=
 =?iso-8859-1?Q?dwdkFB784EM6AHmAK5/dzgMp1N98ipbMoOJMtGIzqWK83Z7Wv0bd2OsKT2?=
 =?iso-8859-1?Q?zRZo/KGvXN/98ENVw1rvmRahMaPyDWmOfR+FM5UUakf9zKo3ckBydZnvxg?=
 =?iso-8859-1?Q?byzUgxpEbcE+VKMDsDI4yQ5vZbD5xVApqGhgdL+cxPKm+s8US8X2QRe9QH?=
 =?iso-8859-1?Q?NlmZXwmcImDiHDr0V5qcCzo2p+gasawBxpevzeJoE0yCwWMDml9YrS5nXz?=
 =?iso-8859-1?Q?zh3Hm+q0X6qYwe3qsY9W2zaRhgECLzqFjV7lAW1GnY8NPj5Hcuu+A8JMPm?=
 =?iso-8859-1?Q?4KaM7/IrquWEmZ3jCJ8tyldYMOIIn2V2Wpv1lLakpH86Dk4g7LDSokwr+u?=
 =?iso-8859-1?Q?PppNNMPR11gj/7L1VY0OVgzahFvfc/fe5Qn4VGkw/UsqPn+KrbKQpl2coe?=
 =?iso-8859-1?Q?F3m6V95CYTUXETAXPw+OV6Zt40CnhqVyFHAk12NdQdcNOjzcuQ3lU9KpxX?=
 =?iso-8859-1?Q?ybh7/goZAj2ij8UUxaVGKSg6BvxOXJAQ8R0QA/JiMda/ISklGgVgOb59ST?=
 =?iso-8859-1?Q?GTLcsP26Ra8IYgJSdOPiCBxGUrKYRR34IVwI91caYefCDCVotWOckeV2lU?=
 =?iso-8859-1?Q?yYgm3d8EV1uDa59hpafdazjKdMoOMkdxZ1pHv87Ias3gxvML5PsmnqnDm/?=
 =?iso-8859-1?Q?BF39YkZNQHX8Ln9bc0RAfY0jf1Hb/2J3kd/0NPW17c1hPNTbUDYniy2JQB?=
 =?iso-8859-1?Q?GVzU1as1MfUUV/KBAPX3186ftEcCf61C1elHUiowolJj5+RxDOSSGuBlDN?=
 =?iso-8859-1?Q?xOPiycZiYVUCByNvd3clrK6JNZwwmwKxHpibrBHsc3gfPyc3uuu0ZBgydd?=
 =?iso-8859-1?Q?baNqOJUEq7TNmuUkEn1qXrlJ7id1EMA6CHlLZkisne+IRdHlJFcKN6krFE?=
 =?iso-8859-1?Q?x/807FL4rrKFP2VKm/WjKS1AiuQ2JwEjBd0PlebsD0ndNgLynrBDW2SKr6?=
 =?iso-8859-1?Q?byF4H3Bd6b29D4q91v7xwIYjHH7BoLfnnS3ELyfpikHOmaoYs308Y5Se3u?=
 =?iso-8859-1?Q?rfHmHPkcqYh/xiNxHUNEcUms2Ve5xsaURhXwPB38zSPlaq5UF3Ftv69Y3Z?=
 =?iso-8859-1?Q?N296yOe8bH8InDmMfzsxPnPTq6ePJXa2OissAsK6t/fVea6lUn3/oJSLG1?=
 =?iso-8859-1?Q?MMWkC8SLifP8EcTKyORrTXT4UF5WBqJKEdCor0DhcErlClbDNOK7NQCpXG?=
 =?iso-8859-1?Q?livggnLHXZAKJ9kIxlh/L/fTBGxK9Tm/TZkLhulpgvgq7upbPWztfE1o3z?=
 =?iso-8859-1?Q?Bj0wl7HB7PjIK5sFbbfqNI/0zgHn1o/xJtvQp9SNpV5aC9YS/5/gz8twRs?=
 =?iso-8859-1?Q?UAqsf1223PL2w3V+xZGJzJC0Iiw47hz/VnI0xKFHTtQVNyErbeATCQsOr4?=
 =?iso-8859-1?Q?3HAly50/afhWGpW+/TBB6OpYAAJe6YCl4YLdU8EeK+HSgfprRU21MzNEUJ?=
 =?iso-8859-1?Q?+8pajuP0vrdhRyrj0qbOOCAVT+yQSeEQNJJv8e54N2Hiwo+mH0Yo2VSJ5y?=
 =?iso-8859-1?Q?qfDwHlgiI5+kA0P61l5VuQZKVUqWSc1LPHBzAd/SA/X7WvvarJb7nGVg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4131.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abb46ea-a97b-4b12-64a0-08dcc782f80d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 17:00:50.0935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e324592a-2653-45c7-9bfc-597c36917127
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QaHASCGTEpRijVYkIPwuP/8IxBJPAtDRPm438YlD3udMmd0p1eHv+uAfjX6NB6ZDw03OcYDs7C0DgPEH/2A5KrNmeFjLYgKm/ra49/wsGJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8260
X-OriginatorOrg: Teledyne.com

In my case, it's not that I've had an issue with EEE not working, it's that=
 I've found on other products it makes the Ethernet link more susceptible t=
o link down events during some harsh EMC immunity tests, and we have priori=
tised link robustness over power saving.=0A=
=0A=
I don't know enough about the Cadence MAC in the PolarFire SOC to know if E=
EE would work correctly without extra setup, but the initial feedback from =
Nicolas implied probably not. On other platforms, I've used ethtool to disa=
ble advertisement via an init script, but I think the cleanest option for t=
his project is to force the PHY to disable advertisement via the dts, at le=
ast until EEE support for the macb driver is fully implemented.=0A=
=0A=
Steve=0A=
________________________________________=0A=
From:=A0Andrew Lunn <andrew@lunn.ch>=0A=
Sent:=A028 August 2024 17:18=0A=
To:=A0Wilkins, Stephen <Stephen.Wilkins@Teledyne.com>=0A=
Cc:=A0Conor Dooley <conor@kernel.org>; netdev@vger.kernel.org <netdev@vger.=
kernel.org>; Conor Dooley <conor.dooley@microchip.com>; valentina.fernandez=
alanis@microchip.com <valentina.fernandezalanis@microchip.com>; Nicolas Fer=
re <nicolas.ferre@microchip.com>; Claudiu Beznea <claudiu.beznea@tuxon.dev>=
; David S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>=
; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Russel=
l King <linux@armlinux.org.uk>; linux-kernel@vger.kernel.org <linux-kernel@=
vger.kernel.org>=0A=
Subject:=A0Re: [RFC net-next] net: macb: add support for configuring eee vi=
a ethtool=0A=
=A0=0A=
---External Email---=0A=
=0A=
On Wed, Aug 28, 2024 at 03:47:21PM +0000, Wilkins, Stephen wrote:=0A=
> Thanks for the feedback.=0A=
>=0A=
> In my particular use-case I wanted to ensure the PHY didn't advertise EEE=
=0A=
> support, as it can cause issues in our deployment environment. The proble=
m I=0A=
> had was the PHY we are using enables EEE advertisement by default, and th=
e=0A=
> generic phy support in phy_device.c reads the c45 registers and enables E=
EE if=0A=
> there are any linkmodes already advertised. Without the phylink hook in m=
acb, I=0A=
> couldn't use ethtool to disable it, but I now see my patch is only a part=
ial=0A=
> solution and would also imply support that is missing. That's why code re=
views=0A=
> are important. Maybe I need an alternative approach for ensuring the PHY=
=0A=
> advertising is disabled if the MAC layer support is missing.=0A=
=0A=
In this particular case, do you know what is causing you problems?=0A=
=0A=
I agree that if the MAC does not support EEE, the PHY should not be=0A=
advertising it. But historically EEE has been a mess. It could be the=0A=
MAC does EEE by default, using default settings, and the PHY is=0A=
advertising EEE, and the link partner is happy, and EEE just works. So=0A=
if we turn advertisement of EEE off by default, we might cause=0A=
regressions :-(=0A=
=0A=
Now, we know some PHYs are actually broken. And we have a standard way=0A=
to express this:=0A=
=0A=
Documentation/devicetree/bindings/net/ethernet-phy.yaml=0A=
=0A=
=A0 eee-broken-100tx:=0A=
=A0=A0=A0 $ref: /schemas/types.yaml#/definitions/flag=0A=
=A0=A0=A0 description:=0A=
=A0=A0=A0=A0=A0 Mark the corresponding energy efficient ethernet mode as=0A=
=A0=A0=A0=A0=A0 broken and request the ethernet to stop advertising it.=0A=
=0A=
=A0 eee-broken-1000t:=0A=
=A0=A0=A0 $ref: /schemas/types.yaml#/definitions/flag=0A=
=A0=A0=A0 description:=0A=
=A0=A0=A0=A0=A0 Mark the corresponding energy efficient ethernet mode as=0A=
=A0=A0=A0=A0=A0 broken and request the ethernet to stop advertising it.=0A=
=0A=
If you know this MAC/PHY combination really is broken, not that it is=0A=
just missing support for EEE, you could add these properties to your=0A=
device tree.=0A=
=0A=
Otherwise, you do a very minimal EEE implementation. After connecting=0A=
to the PHY call phy_ethtool_set_eee() with everything in data set to=0A=
0. That should disable adverting of EEE.=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0 Andrew=0A=

