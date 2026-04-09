Return-Path: <netdev+bounces-276848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOuBKIZH12nDMAgAu9opvQ
	(envelope-from <netdev+bounces-276848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 08:30:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A25E73C6988
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 08:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C810C3008690
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 06:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D722331211;
	Thu,  9 Apr 2026 06:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kzxGyswZ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="E8RDONwc"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5071F0991;
	Thu,  9 Apr 2026 06:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775716224; cv=fail; b=RokpnRmILMu2g3j/SZiryAb1TOSD4ygDVlcGpAS5hO8kU0WeQvnst28F8dIhojI97/6LzqOpU3r3STuOLkNoimwkAvq4yEQy340tCB9WSqw4hNQCXlo+J8ZBLhkAbiA+YlkuZxc5JQUxWQilgwgDfOTIqhIktSvFu5du8yi2YGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775716224; c=relaxed/simple;
	bh=LZOVMzP+yPk1R+mEJBd3+hVRaiX3FXuh7IS+w/Cd2i8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XZRXjvimpbaAVxwqy1ITdeen5rjgdNDgpMjHvdxHxu1+LgTUOWk54Q63T632+Sqc0Ug3zgnnNzZ1qQqUc3zatwzzSVp5euwpMtCeJVoi7mFBpkf04iCVHqh/LwDFaa5EypG5G3uM8zBsY2Yc7tYbBByJsPXUTiM8W51Wjip/Ndc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kzxGyswZ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=E8RDONwc; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 913ab76433dd11f1ae70033691e9ac7d-20260409
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=LZOVMzP+yPk1R+mEJBd3+hVRaiX3FXuh7IS+w/Cd2i8=;
	b=kzxGyswZnGx5et9XN0+YcWpLjQWj4x8ceJCqOwMFiwyhRYbm6vVcm3hqaHdCeUnZYSuH/EdlZSwpXWEVfBESPTdsgIfZoEtCR1S5KpvU0XXApWt+Rfx7e8cG9wR6QTHmm9supWFOO9doEEfQN6jd8ulP5byxcA5jR33Yl2LMqig=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:da8cb710-c425-4d69-8481-671b6380e383,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:0ce8a7d5-060f-4ecc-9ee0-121eeeb4a682,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:-10|4|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,Q
	S:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 913ab76433dd11f1ae70033691e9ac7d-20260409
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1201319780; Thu, 09 Apr 2026 14:30:14 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 9 Apr 2026 14:30:13 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 9 Apr 2026 14:30:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8MLzKpQnwGidVCS82EeLoDfZ4qcn2MUF4f+4RcCUrmPJ2Gd1xl4b0X4xgaMSGWXuf9BUW8fki+L51vFXxBR2669hZZr7LXyCQmrYdLZdQn7iw6zhd7BBecaFincmoKXFbPUfxzL0PkC7uC8JxesXVKKES7byPdXexhHUc221fJP8eFRKFmBGQcm1hUCkturFVSeWxffHmtWtedgvr+ijVJw1ULruCL8sCs6cjgLzvT3u+3zU6EV6HoIupIeZRk99ILP9iA2HhtyMPGnSR0Mm4VQ4JbvuGMuavM5SkNh9D2pGpkvrGnJjfVeosYdqP1H0hJ/eamxEp1+Yecjy8FCRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZOVMzP+yPk1R+mEJBd3+hVRaiX3FXuh7IS+w/Cd2i8=;
 b=lCZsPd5JBHbADfnfoer0T+L1rAlCZ9rmRoy4bUzwImtjY7kZcSLHYifisYgwWPHMr7sVcJXW4t+mhP9OlEW8S7r+1hbAgpa+xs4b7+NaLCvsnDSwRcU166OESn2VRtthLsR3lUNnSce4D2X9YOJQ5tzBa5zF4boMsnQblc0UpS1D++1EJHNgVQy8PL//lklCxPMivijrFujPHZWaBUpV3Ax7HRky81hFjkY2w7r1AGpE0zxCHpKEi0AVHidb7cAP/AcvdOZDEhpJhcp7gOiI08wfBRxGsBc2ndAx5KPkDVs4pOph5wtcUsj98F6A2dfjnOohTt56+mromqD0F2WVQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZOVMzP+yPk1R+mEJBd3+hVRaiX3FXuh7IS+w/Cd2i8=;
 b=E8RDONwcdGRYYDjbYVgOp2/jh4gsnje9o5M0Mk85os176igWevoWsd2nSfkIlonb4pfIyuFnNaTWEsQY0ckrLz05i132QRJ5BiXNxSJ94FKoMwwP/pAFkc8sr4etDHYfVVij8XXfiw01feV68hHSblCiGe2WwcJxtG816HI8ca4=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYSPR03MB7979.apcprd03.prod.outlook.com (2603:1096:400:477::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 06:30:08 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1fe4:fb59:1b1:1646]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::1fe4:fb59:1b1:1646%6]) with mapi id 15.20.9769.020; Thu, 9 Apr 2026
 06:30:08 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "aford173@gmail.com" <aford173@gmail.com>
CC: =?utf-8?B?R3VhbmdqaWUgU29uZyAo5a6L5YWJ5p2wKQ==?=
	<Guangjie.Song@mediatek.com>, "robh@kernel.org" <robh@kernel.org>,
	"kernel@collabora.com" <kernel@collabora.com>,
	=?utf-8?B?U2lyaXVzIFdhbmcgKOeOi+eak+aYsSk=?= <Sirius.Wang@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, Laura Nao
	<laura.nao@collabora.com>, Nicolas Prado <nfraprado@collabora.com>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?UGF1bC1wbCBDaGVuICjpmbPmn4/pnJYp?= <Paul-pl.Chen@mediatek.com>,
	"wenst@chromium.org" <wenst@chromium.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "sboyd@kernel.org" <sboyd@kernel.org>
Subject: Re: [PATCH v5 23/27] clk: mediatek: Add MT8196 disp-ao clock support
Thread-Topic: [PATCH v5 23/27] clk: mediatek: Add MT8196 disp-ao clock support
Thread-Index: AQHcGNelXPSfqVm58E66r9ASuZOvZbXMoqQAgAA8LwCAAX5+AIAAzK+AgAh47oA=
Date: Thu, 9 Apr 2026 06:30:08 +0000
Message-ID: <e147ef12bf73dc28a497c9b95c10faba7b293eca.camel@mediatek.com>
References: <2d418383ff2d6ff40ffb3b4f8e2b0c0e665c3b58.camel@mediatek.com>
	 <20260402100538.27291-1-laura.nao@collabora.com>
	 <04a1848e3ffb43fae727ca0110d57e81fe88a4a1.camel@mediatek.com>
	 <CAHCN7x+K25H-QWLDA6SoGSzxv9koO0wFOrjfWNePc+0AfjCVZg@mail.gmail.com>
In-Reply-To: <CAHCN7x+K25H-QWLDA6SoGSzxv9koO0wFOrjfWNePc+0AfjCVZg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYSPR03MB7979:EE_
x-ms-office365-filtering-correlation-id: 0b3bd1ff-c88b-4061-d2f4-08de96017217
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: i3pACNjrPasYRu+hH5/MejvYzbLGEW1KyHJUf/S7SYPFzX0s7f0PTefp5mjz4F/0jFphw1MpAiPfEzh7CJyRvnLmM+/hGFjWyvuyBWqqBXNaD3cg5WNtZ33+lmY6r5qH6VzPMZ/fASn1gOB5UtOoLssQeHVqX+ReSh6hk/I3KRYd7qGm1r0bEoVsKtt4Tw79mK+I0JF6CQHIke6VfflazBLTlmrA1GXTbu0Ok48aQUrgRt0o+8W/I+GOIJ0fGgqlOjq6T5wnWTnQxK991K5YSrzEV9ESmNaoypVP9B3Iy0afr+LukT9DthaCWRL0xNxmYWeJb1NUbIPvH5QlklCkAdQQvrt8AiXgy5Yxhxp+fwh0l3cZBP7zi9Wd/0NMSnejNPAlkz+q/z9SI/36Km//Cs4ccWdByibusT0j3zwKpD0Qf335wL6FxZPMx9LpPnnpabVx2mDpPoofEbQkl7/38zsOati5t9C44pSzBiLh0pLO276HcYrKx4pjA43L81stfSIxmWHv8QfdK+hHMM6wZdv6x9L1oJSg0h//xATZCDQvZqkYICT7lKZDRnLbdLirR5Q7IOLjw9xKslF/EVbkbI3p+Er6TYiYtin1psHoS31BJDM0N5q6NyBnOGHK3+ko6+eKAsOB/n5rqBN7JAAnjgkhwrp4s5ePdTxWCNpHgG12SrCKr8L4xpIrutJClPe4b/Riy4k7BWLCbFixyEG/Yyl3hgzQPpLZI8wJ05LdXM6jddIE3gHDHthoAgQLlT0Rjv0aCV0BjbuhAbObXMbyNs/yafMFghQ2d6U3iwYhrnM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWlFOWJ5MVlLWER4UlJzK0dQa2JEckhkYjFEOUFyNStTSDMyMXdNOGo3K1Y5?=
 =?utf-8?B?WUFhVlI0N1lUZHZtVnBnYURxdkpldEtubWMrZVFKUGV1VHlrYS90Vi8zNVJt?=
 =?utf-8?B?NFdHNE53Rk40ZERjY2t3ZktMSjd2a3BsY1F2TmRDYWJXZVFGbkFOUzJuZmtQ?=
 =?utf-8?B?Q1psMWhscEY3a2xYeG5UZjNybFVOZFRac3N3Uy9yeUpHZDY0U2ZoREF5aldC?=
 =?utf-8?B?NzFQTThMUHV5TDNvcjY0MUVmTWRLaFZRd293ZXByREQvditleGxaNDVINXcv?=
 =?utf-8?B?UUp0VzVLY1NlMGJ3ZEdSdy9Gb1l2cVF6RzNockJEWGpkMzJhVEJyOGhZUnpE?=
 =?utf-8?B?aGN3bGNBbTlpOEFsWURiK2J4NjdSMnR2MVJOWFZVTTN4eHlrSHBRQVg3dTND?=
 =?utf-8?B?aEVtVjhLMVZ5NWkwNEF0MXFBdGFDSUlabEtwYlNzUk00ZGg1TnE4KzZmdG9F?=
 =?utf-8?B?M3lqZzFPZGV4YlVlYUpBWklIR1N0MTJFZ3BvTkJybkdHN3VlY3hoWTR2Sm5X?=
 =?utf-8?B?Yjl2YWwzUjlQN3ZXTUJsK0xJS3B0WW5wWjhaa1QxSFd4WVVBZGdKSGk5eUNO?=
 =?utf-8?B?MGowV05Sbm81d0kxQmFBZHNkTDhHdzdYbzU4VmtzK3E0ajdRaTJJR2pFZ2hH?=
 =?utf-8?B?RCtYaXZqWUN4ZGZzRnUvS083RVFmUDB5ZFdOZlg0ODBQQTRhYmNmanA3NWRE?=
 =?utf-8?B?d25HTDNWN0p0OWhSK25uNkEvVXRaeUFVNGNETEtBaUJEQ3V6aVN4MmhxYVpi?=
 =?utf-8?B?UlBTMjMybHZQMzQxS01XWklKNEtoQ2ZsOHlVNkFhMTZaQUlWYlBoRHJMNDlL?=
 =?utf-8?B?OTFDRkNLRkNibmhIY1ZBUGRqOFZ1R3ZOYmdzclNXTWxudVhkVWp4cHFJMlZw?=
 =?utf-8?B?cEZ5L3Rtc3FMYzdZMldKa25LaDlJSWVPMGQxWnR2NVY3dWIwY2k2V0ZTOGpT?=
 =?utf-8?B?T0VlbEZFSmZUN2R2ZnlXT21uN3ZnQ01mbWl2cTFSNmxyQzZCcDExNDZteXJZ?=
 =?utf-8?B?ckZBWXFFRlV4K1BldW5lMUFuSnFFQ3RVQzFaT3A2UjNZcEtKTGZRL29jV2l2?=
 =?utf-8?B?QjJ2WUxTanh4ZnJDREQ0SHRhNzdvQ2Z5UTRham4zNVFOTDhMTW82VXdOajhk?=
 =?utf-8?B?djRoVEdlWjlUcm9FTXdRYUJzSjdFNng2UGFDSlVzSS9VbEhMT1N1TDd0MlU2?=
 =?utf-8?B?WU14dktTREI4V2RxSno2VzRjUVhXTE1zOEZHcGtoUkx2ZXZvL0FwaHJheGI3?=
 =?utf-8?B?VnVUNy95Y09nQ1BaMHREblB0d0xvdWhkZnA3Q3AyaXlyMzFPcXg2Y1RJS0gw?=
 =?utf-8?B?WHV6dmNidngvKzlxNENLNE9ORmY3bU1wNm1heVlXaW8wQ1BWbDVIZFI4TWJh?=
 =?utf-8?B?Z1J0R3FQbmt6cmJOQzU2cXhsWDgyc3lETUtZRFJzMGNmWEY1R00rRFpiSGor?=
 =?utf-8?B?aVJWdVJIdTM0clpOTFhYak16RnlEOTh1MlJVd0tLUjF0UEVLdngxV2QvOVhr?=
 =?utf-8?B?bS9QbWF5Y3lnaTVwZGplZ0Nmd1ZFdlg0aDRodEFIb2d0SXVZN1Nwcy91cE00?=
 =?utf-8?B?U2xvOWN2VGI4c3o4QmhkQVUyM0c3ZmpwTys4Y2lZNjZnZElMVFkxaldxbEVB?=
 =?utf-8?B?aUhFRUtDYkYrRE9VcFdES1hYSFRUYUlMY2JQRUpnME9zMGN3MHVhcDJQc29H?=
 =?utf-8?B?SDVPeG9HRU1oOTUrbWFDZVozdWZva2xnTTZaSkdTZ3Z0OUxiaEZaeGw1Q0sv?=
 =?utf-8?B?RUpoTHhmSU9hK2syS1Q5Q3pHRDg3REMzOVhoM0d4Nng5N0RiY21aS3oydzc1?=
 =?utf-8?B?bTlub3kxWnJMWmcrdlF2ZEJZSnRROExlT0RIQlExRy9BSDJlaE5TQ2NVVXRr?=
 =?utf-8?B?VGdRcGMxUml6bXMzMzAxaG9UdmNRTTFZTTJZYXNEV3dUdGxtTXlhWllBSW9u?=
 =?utf-8?B?OVZSSmRtMjJ5SnNlNEIxSmZ6YWxBUUErWUNVaUlGU1AzL2p3cXhSNUpQNnhH?=
 =?utf-8?B?RC83a0hiU1ZORzB4RmhERkxTZW5DaUJMUE9QZ09rVmNuVU1pS2ZCWlJlOEdW?=
 =?utf-8?B?akgrdEFKWDBlUE9EYjRiUTV3TEs5VmI2a25GMlJuektiNVNFNFlVMlFmdWpY?=
 =?utf-8?B?eXR3NVRKZkFTdDBxRDBGbHU0bi9pN2NlNTBFTXNvOU5ydHExeUdmYzRFRmJx?=
 =?utf-8?B?bW1iYXdwcVhma2FhaFFkcTJxTnZNU0FucnZRLzltdUVSYjJhQVJuUzlMVVZS?=
 =?utf-8?B?bWZzQTlBVmxKZ0RxelZRc0dhU1RDV2U0QU55blpGN05MR05ycjlJRVRDVEhK?=
 =?utf-8?B?Vk12SjJQaXZ5Y1QzM3YraTNNS1psMUJmdThIb294UVlQc0NtdWt3b05ZRWRB?=
 =?utf-8?Q?+NHELGKAUM4O0A/0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D19BC27179C92E479C449BB205AEBA66@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IdWsXn/9YMBIiepgOVInD7HdnNZ9OC3flzD0vqjKhS3P++pXU13dHlzvO2WoOFyPTkmJEFLWuvxIbzGEgAztMFxi0y7zAQni8QG9pS7s9XYTsFc5VFsJkhllF2eYV2O8uHl3SV+TEMGMnYvAT1M68Q5MGX/Iy3qcMeaquDtQaB8gpYR+91ct3CGjCUq/Ygh8Z9TTlT9XR3PIEns7HVL4zv3NCj3eKhLJZtvCZ+F3G77XwKk/yWL8SYCM/7yLVCpbw+SqrU8mxQeRE9sxHTafHYnIGEiRpPvstTOxWQCDBr0aUgTYbHYjAgYuqBZDXO1h/3SXlz3/N2ktDOkH/99neg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3bd1ff-c88b-4061-d2f4-08de96017217
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 06:30:08.6298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CHSlrAFts0E2dA7cbF9NGzzOW/soWHb55Y8g8nmjXYH4KDQHRnpUBHAguHBn2h3dipvyW4k07bve8hoQnsU8YlU3O0Pv7mN8sO6zv6pOmCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7979
X-MTK: N
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,collabora.com,lists.infradead.org,baylibre.com,gmail.com,vger.kernel.org,pengutronix.de,chromium.org];
	TAGGED_FROM(0.00)[bounces-276848-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediateko365.onmicrosoft.com:dkim,mediatek.com:dkim,mediatek.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Jason-JH.Lin@mediatek.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: A25E73C6988
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiANCltzbmlwXQ0KDQo+ID4gPiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lk
DQo+ID4gPiA+ID4gb2ZfbWF0Y2hfY2xrX210ODE5Nl92ZGlzcF9hb1tdDQo+ID4gPiA+ID4gPSB7
DQo+ID4gPiA+ID4gKyB7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Ni12ZGlzcC1hbyIs
IC5kYXRhID0NCj4gPiA+ID4gPiAmbW1fdl9tY2QgfSwNCj4gPiA+ID4gDQo+ID4gPiA+IEhpIExh
dXJhLA0KPiA+ID4gPiANCj4gPiA+ID4gV2UgYXJlIGdvaW5nIHRvIHNlbmQgbXRrLW1tc3lzIGRy
aXZlciBmb3IgTVQ4MTk2IHJlY2VudGx5LCBidXQNCj4gPiA+ID4gd2UNCj4gPiA+ID4gZm91bmQN
Cj4gPiA+ID4gdGhlIGNvbXBhdGlibGUgbmFtZSBpcyB1c2VkIGhlcmUuDQo+ID4gPiA+IA0KPiA+
ID4gPiBBcyB5b3VyIGNvbW1pdCBtZXNzYWdlLCB2ZGlzcC1hbyBpcyBpbnRlZ3JhdGVkIHdpdGgg
dGhlIG10ay0NCj4gPiA+ID4gbW1zeXMNCj4gPiA+ID4gZHJpdmVyLCB3aGljaCByZWdpc3RlcnMg
dGhlIHZkaXNwLWFvIGNsb2NrIGRyaXZlciB2aWEgDQo+ID4gPiA+IHBsYXRmb3JtX2RldmljZV9y
ZWdpc3Rlcl9kYXRhKCkuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaG91bGRuJ3QgdGhpcyBjb21wYXRp
YmxlIG5hbWUgYmVsb25nIHRvIG1tc3lzIGRyaXZlciBmb3INCj4gPiA+ID4gTVQ4MTk2Pw0KPiA+
ID4gPiANCj4gPiA+IA0KPiA+ID4gVGhhdCdzIHJpZ2h0LCBteSBmYXVsdCBmb3IgbWlzc2luZyB0
aGF0ISBUaGFua3MgZm9yIHRoZSBoZWFkcyB1cC4NCj4gPiA+IA0KPiA+ID4gSSdtIGF3YXJlIEFu
Z2VsbyBpcyBjdXJyZW50bHkgcmVzdHJ1Y3R1cmluZyBtZWRpYXRlay1kcm0NCj4gPiA+IChpbmNs
dWRpbmcgDQo+ID4gPiBtbXN5cyBhbmQgbXV0ZXgpLCBhbmQgdGhhdCBtaWdodCBhZmZlY3QgdGhl
IHdheSB2ZGlzcC1hbyBpcw0KPiA+ID4gbG9hZGVkDQo+ID4gPiB0b28uIA0KPiA+ID4gU28gSSdt
IG5vdCBzdXJlIHdoZXRoZXIgaXQgbWFrZXMgc2Vuc2UgdG8gc2VuZCBhIHBhdGNoIHRvIGZpeA0K
PiA+ID4gdGhpcyANCj4gPiA+IHJpZ2h0IGF3YXkuDQo+ID4gDQo+ID4gT0ssIHdlJ2xsIHRyeSB0
byBjb250YWN0IEFuZ2VsbyBmcm9tIG90aGVyIHBsYWNlcy4NCj4gPiBUaGFua3MgZm9yIHlvdXIg
Y29uZmlybWF0aW9uIQ0KPiA+IA0KPiANCj4gDQo+IElmIGFueW9uZSB3YW50cyBtZSB0byB0ZXN0
IGFueXRoaW5nLCBJIGhhdmUgYSBDaHJvbWVib29rIHdpdGggdGhlDQo+IG10ODE5NiB0aGF0IEkg
Y2FuIHRlc3QgY29kZSwgc28gZmVlbCBmcmVlIHRvIENDIG1lIG9uIGFueXRoaW5nIHRoYXQNCj4g
eW91IHdhbnQgdGVzdGVkLsKgIEknZCBsb3ZlIHRvIHNlZSB0aGlzIHN0dWZmIHB1c2hlZCB1cHN0
cmVhbS4NCj4gDQo+IHRoYW5rcw0KPiANCj4gYWRhbcKgDQoNCkhpIEFkYW0sDQpIb3dldmVyLCB3
ZSBzdGlsbCBuZWVkIHNvbWUgbW9yZSB0aW1lIHRvIGRpc2N1c3MgYW5kIHJlZmFjdG9yIHRoaXMu
DQpXZSdsbCBzZW5kIHRoZSBuZXcgcGF0Y2ggaWYgbmVjZXNzYXJ5Lg0KVGhhbmsgeW91IGZvciB5
b3VyIGhlbHAhDQoNClJlZ2FyZHMsDQpKYXNvbi1KSCBMaW4NCg0KPiA+IA0KPiA+IFJlZ2FyZHMs
DQo+ID4gSmFzb24tSkguTGluDQo+ID4gDQo+ID4gPiANCj4gPiA+IEJlc3QsDQo+ID4gPiANCj4g
PiA+IExhdXJhDQo+ID4gPiANCj4gPiANCg0K

