Return-Path: <netdev+bounces-99158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FEB8D3DC1
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 19:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5A9287B03
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 17:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0326184110;
	Wed, 29 May 2024 17:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="H8/1oJ+8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D76DDA1;
	Wed, 29 May 2024 17:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717005092; cv=fail; b=FXrzl//oxUJ73NQZtsf04yIlYVsxX/Ux5ngEoV46omdoq3yD/+3ptndqyDCiJ0EhwObKa66mjq9WUWKbMZm0yqbB/uvld/4hrs4gdjovRHcvm5HOCtdpE8Isp63ykzdIMinr27svzhn9573WHsBLFukIjfWwYx5zXP27+6F64Uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717005092; c=relaxed/simple;
	bh=NQBbn/TGu6vcgVl9vUpySz6VPAtm64Il5nPwsK6HveA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WsWc2l8R/NWegTrDxMtkN2Was+sSdujFCpMQq01KvIlrIYdlu6CCUhCuUoBErgnfG420GhngjnZejn+jPEk2qYzGNOzCtz7lCkfN42MoBWz37wvBdlOdhSSMh2afvdM+KixRQk0ViRt4njb0DBXisbavpCBYAgff8yX50Y3XvQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=H8/1oJ+8; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44T9QjDH015558;
	Wed, 29 May 2024 10:51:03 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ye1r11usv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 10:51:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwtJH4HvTcUKIP7nU3UjuGUIZlbo529u5kkM4tqN+k3hT/KSkMp5Oml2ePTFR7Emdk2sGH8IayqLoihjLFZdLSVQn+7jTjnoZx3DneGSc+7oeas7q2le4spFYcpWSZLfHYhhlQzdPmBww4IQp+p60kBDP8+G7wXknJOrUa62fQeaC8zH8R4WTxdqxgL6gY8B2fyJ2zstgoFjSKU7aUaneMlnRmmBE/mRdd/YHS/gWECW3qJSwHkoVVvQCXfQ8MHzfHXkLvRzXjzlUQXLX8j9tV75hAjlPAUs+eWpQdYcXXW1ju+TBIHeB3cu3fdCoJFh7A8XjvqAcKnA0yLRrz9a6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQBbn/TGu6vcgVl9vUpySz6VPAtm64Il5nPwsK6HveA=;
 b=FriiXOHCwcxfEZRWpHQ7HvbBppdzT0oKwY/VUFcO9SEPTBhZj5z93vvTWsToLyUC6jRLHd1sw3KotS/R8UpsFp/QBePVo/VPBDHacHdGdig9ruZX/k4hEo4D9vBlyReWP+4KERgrUNYov/0xClvtuXCbMME6xPsmX4oAwmI+sWxUf1rMuBa0l+MifKhyEHmbMA/qf8CXWhPpeYB/205mlAG8W21LV8kqK6owQ2J12vCCsZ3IU/qycpGGvAp30iKHOb+4K+xQwbnwEXM2N0Kax1HlFovGAnWhQouRslighio7irbxPEL1gX2AhZhxyOGj+0ruUDRBMckBOTfkrdjxjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQBbn/TGu6vcgVl9vUpySz6VPAtm64Il5nPwsK6HveA=;
 b=H8/1oJ+8q5xQXB/P7uTl9VCbMPd+vnNwM5wxksBfo1rtIA9ZlquRqiCxE2c96R9JUgLQeej6OTXLrSSvtKkxvjBEhcExkIfYqw+XE/wkXWvYoB/L5GPDhdNTa7p9ZIZR2Mr4uzNcjyR/lip9P209YbPqexy5nXmSz2j+QZYwe4Q=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by PH7PR18MB5354.namprd18.prod.outlook.com (2603:10b6:510:24d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 29 May
 2024 17:50:49 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e%5]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 17:50:49 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: =?utf-8?B?QmMtYm9jdW4gQ2hlbiAo6Zmz5p+P5p2RKQ==?=
	<bc-bocun.chen@mediatek.com>,
        "daniel@makrotopia.org" <daniel@makrotopia.org>
CC: =?utf-8?B?TWFyay1NQyBMZWUgKOadjuaYjuaYjCk=?= <Mark-MC.Lee@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>,
        =?utf-8?B?U2FtIFNoaWggKOWPsueiqeS4iSk=?=
	<Sam.Shih@mediatek.com>,
        "linux@fw-web.de" <linux@fw-web.de>, "nbd@nbd.name"
	<nbd@nbd.name>,
        "john@phrozen.org" <john@phrozen.org>,
        "lorenzo@kernel.org"
	<lorenzo@kernel.org>,
        "frank-w@public-files.de" <frank-w@public-files.de>,
        Sean Wang <Sean.Wang@mediatek.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        =?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: RE: [net v2] net: ethernet: mtk_eth_soc: handle dma buffer size soc
 specific
Thread-Topic: [net v2] net: ethernet: mtk_eth_soc: handle dma buffer size soc
 specific
Thread-Index: AQHasX5cqaDOSKO1+UOevLBWKIgzS7GufW4w
Date: Wed, 29 May 2024 17:50:49 +0000
Message-ID: 
 <BY3PR18MB4737EC8554AA453AF4B332E8C6F22@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240527142142.126796-1-linux@fw-web.de>
	 <BY3PR18MB4737D0ED774B14833353D202C6F02@BY3PR18MB4737.namprd18.prod.outlook.com>
	 <kbzsne4rm4232w44ph3a3hbpgr3th4xvnxazdq3fblnbamrloo@uvs3jyftecma>
 <395096cbf03b25122b710ba684fb305e32700bba.camel@mediatek.com>
In-Reply-To: <395096cbf03b25122b710ba684fb305e32700bba.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|PH7PR18MB5354:EE_
x-ms-office365-filtering-correlation-id: 0d0f38e3-9282-436b-f15d-08dc8007e023
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|1800799015|7416005|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?V2t5SDhWZ1hudnFJczN6YzhHeEtLYUJ1OEgxQmxud2VtNGx5WHUwRmxMc0ZM?=
 =?utf-8?B?TmN4cmdheU9IWlI2VG83VXZrVWdUbFR2S08zTzdWeHpuai9zdnBWei9NME9x?=
 =?utf-8?B?Y2ZQYXBtUzduTUJlQUlSRGo2VUlNY0piWmNGaTUrb3pycmM0d0JrWDFySWpL?=
 =?utf-8?B?ZUxPRTJNajBkVGZBQytKdlpuU05IeGxabzhYdkZKWUxWUEk2U0xsNmRFVTFj?=
 =?utf-8?B?VVl1d016UWZUM1Y2ZTFZbjRQRkF2ZlBVbHQrSUxkSFpvWHZuYWdGZDRIZE1B?=
 =?utf-8?B?dmFLRExmc09wUWpxamJicW1OalBuakdFVFpWTDNQZmNiR1A2WTdzcE95cDQx?=
 =?utf-8?B?OUtpclFWNjZneDgxT2JuV3EzSktTWlI5UUQwUmxoa1pwU0VaOS9KUUFUR1h1?=
 =?utf-8?B?YW44OFd4eDRNc3ZWVFdMdEdOd0RQbUdNUW9JMm5rRmRkcG5ad0JrbnNYK0tS?=
 =?utf-8?B?a1M5cURDa3B4ZTVIeXJhbnRBNlVGdW1oZDdWNUtON0wvNDJDZlpZTit3L0wr?=
 =?utf-8?B?aW0yVjdJQTRoUWcybXkzWnUrSy9kbUVCeW0vRDNRU0RheWkzNW1WaUtvTW1z?=
 =?utf-8?B?K0NlRk1tZFo4M0I5QVIwWkUrTUdOWGRuVGxzL3ZWVVRmVWN6ZTE3UHl6QVlD?=
 =?utf-8?B?YzJiLzE1c0cxY1QxdWNLaFJwUkR0a0xta1ZKUVVSSWk2ckQyamZaYTJXZWhQ?=
 =?utf-8?B?NWxlejRkL2tNZ2dBaWR2OXpxMi8xTUc4QXNSS2FrdWhlTTJZSHhiWUdhVkRh?=
 =?utf-8?B?ZGUyUTAxWmtoNklHcDJqaytXbVFwam43Ynd6S3N4UkcyTzdpYmV3ejVJMGhv?=
 =?utf-8?B?Tk42ZDBza0praXIyaVM4a0JmVGRscnRPd0ZudFpEbG12R092UkxsdkNDRmdR?=
 =?utf-8?B?eXVUaTdFVEF2czRqZ1lvSlo0bFBRaDBqeWpEOXNvWDNKajJkQzBKNEYxS0U3?=
 =?utf-8?B?TmlSekFQdURXTVo4R1VyeDFBaGNNQmlXY3U0dmIvT3JYV3o4Q2ZDRzl1OFdk?=
 =?utf-8?B?UDZ3aVk4eVE2eVdoWnRKQnJYcU1LWm5aZlBwUTFlUXl4R3lpaFd3Qjg0K1pT?=
 =?utf-8?B?RUJaVHRwdC9rb1hsTmtscXV6MVhVV09rS0pGdDg4UGo3dUhWbzJLc3JXa1ky?=
 =?utf-8?B?aFB1R2hBTEFGaWoxR3JjUENtd3owbWNUOTVnUzJTeHZwQXA0b09vMC96VzRu?=
 =?utf-8?B?Vnp5RUdacDlDbEtrQWlhempoTFhyRFdSYnRSR283OWdJR1NERGNMZ2lncmp5?=
 =?utf-8?B?MUw4TEdjVjYxQUE0b1A3NkdTekhxTnBOWXNMcDRFSExnTE1oZS9aTzhsZSs5?=
 =?utf-8?B?VkRLSnNQMkpWaEdCblFyUFd0R09vUDlqS0JWaTJmQVFjSnhTenBpdElBVmdw?=
 =?utf-8?B?dnNsUG1EZzRDcnl0U3BJWDFRVU9uRWZCVjM4cFhPQUdtR1JEN0pNdThZU1Bs?=
 =?utf-8?B?Y2Y1OXRDNkNFdlFHZXhQSVMxazdGMGNRVGpEMXZ0c2dhbzVmdFRzRjRsNDVH?=
 =?utf-8?B?bU5JcTdLazVYV0ZyY2NMWkdSdzRqSFE0U2hkYVNGLzJtVXBZbHh0R0k1cDlu?=
 =?utf-8?B?blRWUzFjZnFiSVIzOHZUblRNdDdKM0Q4c044NmdEQXFjKzNsZVZhdjl3VXNt?=
 =?utf-8?B?V3pwTDNleWcvNGhLS01aam5qOXEzZTdJR1VFS0NWNG9EejdnU2pWazJlQWdQ?=
 =?utf-8?B?OXNkMllONjI5WmJ2aUwxb21Ld252dE42WFhCMHFQZzFTQkVUVXY5WmcxL252?=
 =?utf-8?B?RVRJZ2xBcTA3dEpGR2JaVmw0VVhvRk9BUjlDQnhxVWdwVjZvdFBzZXEwTTAy?=
 =?utf-8?B?Q0hMK0hlVTBGSkhncEhZQT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UEtyZGlBd3VNZUFwUW5IZXAvckgzdURVQmJXak5RL2JGcFVOWGpaTHg3Y0Zv?=
 =?utf-8?B?K0VBcDV6aElGU1VrQWl1cFZmV3V5MHNRUzlUSEZibFMwT0tveEZXaURaUHds?=
 =?utf-8?B?L2ZESWpFazQwYkxqR2NhZjg0ekVsT1hNaXQ5TVdaRmRVSitJamkrQW9WYVFO?=
 =?utf-8?B?a3pBaTFmNTJNcnZweVU4UllqblRvWXNxQUs0ekU3ZjJDV01mK2J5MGhNVG1R?=
 =?utf-8?B?NFltUjIxald6b3h6ZmJRY1pyQmU1RHd0MnZ2Qnk1dXo4d0g4MzBsbXRUL2hm?=
 =?utf-8?B?cGp2VERHaEhLREVqdjAvaGE5ZzMrZEQvb05UNERoaGZsbW1naWhvYW5pMWU5?=
 =?utf-8?B?ckdoeXJlRGdFdTFzZnhuU0xJV2VaWEsxWXNpazBJeDZrSTZSOVM5NWMyZVRo?=
 =?utf-8?B?bWxlNFpQMDNmYzVoS2h3REVjeng0dzV0WERYVCtDNTBETktPVVliZHo3Q0xZ?=
 =?utf-8?B?dlN6eCt6RkF1ejB2VXhiWnJGUm1lTFFyVzNFY1hLc2pGN3BVRFNFSGgxUEZG?=
 =?utf-8?B?QXp0MFpEM3RxSGxtZ0MrYU9ibWdUZ1dhc0xTMGZwSEFBNEx3bjhHL1ZidVQ0?=
 =?utf-8?B?eEU0bzRiWjErYWJpTnQ1S1MrZVlzT2tQcXVwcWpxdDhnM09iSHBENmdoTWxQ?=
 =?utf-8?B?Z2NzcVRZOU8rNUlaTVpHQVcxV0U4R0xmNUVJRlNmbE84QjhqbjJjNDI1Zm9o?=
 =?utf-8?B?YWtKdDU5VWI4ZXh5RzVqSTlheHljZEtpeEc2S3pFdnhKRWF1SWs2K0ZRUGsy?=
 =?utf-8?B?M1FWUzB5OFBoRCtMU1MxTWFRSWlZV09JSlRZaU5VeElXeTBqVVNLNUUvTWFj?=
 =?utf-8?B?R3dpazdyakt3cGtKSUR5NmVXTFBlWVNPbjd1R25IRkVIWWpSZW5CRXpQUWpl?=
 =?utf-8?B?Q3lUd1pJVUI0MVUwSlhPZG1VUWR4TkdpeGhYcXhvZU5YUEs0R3U3QldOMlIz?=
 =?utf-8?B?SjJtejFlY0lLTHFBMU02eXd0d2x6cGNzK094N2ptbnhPUlpwb0RGMUpqS0NC?=
 =?utf-8?B?NzM4bUVjQ29EZ3lTSFo3QUpaOXgvRGR3bHpTbFJvaDBhbmdZbTZqaXpGMFU2?=
 =?utf-8?B?QitpV2lURnowN3hBNTdObldRQlpZNTU2aElTK2JjL3JHTTdvKzlPZzlrRTVD?=
 =?utf-8?B?bkdrcTZKWHpnR29MeUlJeEU0ckRZd05MbVZHZ3JJMFdSaGFxN3p6V0x5MnBD?=
 =?utf-8?B?alhjWVFaM0hmK2lLTUx3QVVSclUxbWE5REpBZ3dta09DNXFUS0VSR3UxQVFr?=
 =?utf-8?B?T3k4NHJiRDZsN1JqUGlrTFZ2K0R1Vk5DZXRGSHh4UTVSZFpxaHp5RE9CQ2VW?=
 =?utf-8?B?d2Nmd0wzL2hLdjNDMmUraFJGTCszeS9IeWxVSER4MmdTY2ZRRmd6eWJTMUVy?=
 =?utf-8?B?c2IvTGh3MGgrTUo3ME1RSVBxTVlpZmVESHppTE9UQlZkZzJSU2FVWDFNd0R3?=
 =?utf-8?B?NGNXTm95eDB4NDVJdEZab2Q3eUUvQ3ZIa2trTnArSVhqVU9jODBYYnpXY2Uz?=
 =?utf-8?B?VVZ2QzNaczdSdTJJS1hNa29TVzFwWW1MLzk4QUZIbkJLWVlMQmJnRU83N3d6?=
 =?utf-8?B?L1dySUhXNFo1Y2F0Znc4U0F3RDdKWnQ4VCtGeVVZNGVXLy9FWHZUanpldTVG?=
 =?utf-8?B?dHllS0JBNkxIWFBVNmFzeHczVk5iSjcxRmpnem9YTlEwV2xjOWRYcTU1WEUr?=
 =?utf-8?B?T0FUUXlWUmNKcnk0RkZaL3hRWTNCeTRLT2htYXJxR0hOTkhsZHZ6dWdVeHJk?=
 =?utf-8?B?VnJZREZ6a3FSSUZZVWx1akE5cHV5Y1pIbzk2Tlh5a3o4NThET2tRb1ROY1c1?=
 =?utf-8?B?WkxEZ0F3TW8xOU9MMmFMWDFYSy9TQ29Pc2pBdmFic1JPRTRyNWVZU0hsanlX?=
 =?utf-8?B?NmFWc2NLL3ZXbFRKa0t6RHNTYnM3SnR6ZkwwdHdPcXljNzRiTDhFKzg3YmJ0?=
 =?utf-8?B?TVV3Ykt3ak5HbHZXWnpjSUpMRlhURHpMSnl1YTFkSFVGTGxzamlMdVAxRDUw?=
 =?utf-8?B?WlR6MlJ0WDl6VDMxbTZQaDVGOUlOeVpHVFdoeHZ0WjlmT3ZlejE0VTgxOTVs?=
 =?utf-8?B?NExRcUFUQjhXTmgrNkJVTFlteTBONHpIMmoyVFAxTmloTXJkdkt2OXhxQXNK?=
 =?utf-8?Q?ofBFVzo01yO5htREHnkvJszfQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4737.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0f38e3-9282-436b-f15d-08dc8007e023
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 17:50:49.3174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P+KzVVKNM8SNwm5k/oYwriTMSqiJSfXQro9EzzdRGL4yCBcvwuIEMGTFifxzrpxkhJmeh/CUAd+JJJX1a83amA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5354
X-Proofpoint-ORIG-GUID: LLRG8wAgdD1qUZQKzSWc4nRgg0MFJGYF
X-Proofpoint-GUID: LLRG8wAgdD1qUZQKzSWc4nRgg0MFJGYF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_14,2024-05-28_01,2024-05-17_01

T24gTW9uLCAyMDI0LTA1LTI3IGF0IDE3OjEzICswMTAwLCBEYW5pZWwgR29sbGUgd3JvdGU6Cj4g
PiBPbiBNb24sIE1heSAyNywgMjAyNCBhdCAwMzo1NTo1NVBNIEdNVCwgU3VuaWwgS292dnVyaSBH
b3V0aGFtCj4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQo+ID4gPiA+ID4gPiBGcm9tOiBGcmFuayBXdW5kZXJsaWNoIDxsaW51eEBm
dy13ZWIuZGU+Cj4gPiA+ID4gPiA+IFNlbnQ6IE1vbmRheSwgTWF5IDI3LCAyMDI0IDc6NTIgUE0K
PiA+ID4gPiA+ID4gVG86IEZlbGl4IEZpZXRrYXUgPG5iZEBuYmQubmFtZT47IFNlYW4gV2FuZyA8
Cj4gPiA+ID4gPiA+IHNlYW4ud2FuZ0BtZWRpYXRlay5jb20+Owo+ID4gPiA+ID4gPiBNYXJrIExl
ZSA8TWFyay1NQy5MZWVAbWVkaWF0ZWsuY29tPjsgTG9yZW56byBCaWFuY29uaQo+ID4gPiA+ID4g
PiA8bG9yZW56b0BrZXJuZWwub3JnPjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQu
bmV0Pgo+ID4gPiA7IEVyaWMKPiA+ID4gPiA+ID4gRHVtYXpldAo+ID4gPiA+ID4gPiA8ZWR1bWF6
ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+Owo+ID4gPiBQ
YW9sbwo+ID4gPiA+ID4gPiBBYmVuaQo+ID4gPiA+ID4gPiA8cGFiZW5pQHJlZGhhdC5jb20+OyBN
YXR0aGlhcyBCcnVnZ2VyIDwKPiA+ID4gbWF0dGhpYXMuYmdnQGdtYWlsLmNvbT47Cj4gPiA+ID4g
PiA+IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwKPiA+ID4gPiA+ID4gYW5nZWxvZ2lvYWNj
aGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPgo+ID4gPiA+ID4gPiBDYzogRnJhbmsgV3VuZGVy
bGljaCA8ZnJhbmstd0BwdWJsaWMtZmlsZXMuZGU+OyBKb2huCj4gPiA+IENyaXNwaW4KPiA+ID4g
PiA+ID4gPGpvaG5AcGhyb3plbi5vcmc+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyAKPiA+ID4g
PiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsKPiA+ID4gPiA+ID4gbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyAKPiA+ID4gPiA+ID4gbGludXgtbWVkaWF0ZWtA
bGlzdHMuaW5mcmFkZWFkLm9yZzsKPiA+ID4gPiA+ID4gRGFuaWVsIEdvbGxlIDxkYW5pZWxAbWFr
cm90b3BpYS5vcmc+Cj4gPiA+ID4gPiA+IFN1YmplY3Q6IFtuZXQgdjJdIG5ldDogZXRoZXJuZXQ6
IG10a19ldGhfc29jOiBoYW5kbGUgZG1hCj4gPiA+IGJ1ZmZlcgo+ID4gPiA+ID4gPiBzaXplIHNv
YyBzcGVjaWZpYwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBGcm9tOiBGcmFuayBXdW5kZXJsaWNo
IDxmcmFuay13QHB1YmxpYy1maWxlcy5kZT4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gVGhlIG1h
aW5saW5lIE1USyBldGhlcm5ldCBkcml2ZXIgc3VmZmVycyBsb25nIHRpbWUgZnJvbQo+ID4gPiBy
YXJseSBidXQKPiA+ID4gPiA+ID4gYW5ub3lpbmcgdHgKPiA+ID4gPiA+ID4gcXVldWUgdGltZW91
dHMuIFdlIHRoaW5rIHRoYXQgdGhpcyBpcyBjYXVzZWQgYnkgZml4ZWQgZG1hCj4gPiA+IHNpemVz
Cj4gPiA+ID4gPiA+IGhhcmRjb2RlZCBmb3IKPiA+ID4gPiA+ID4gYWxsIFNvQ3MuCj4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+IFVzZSB0aGUgZG1hLXNpemUgaW1wbGVtZW50YXRpb24gZnJvbSBTREsg
aW4gYSBwZXIgU29DCj4gPiA+IG1hbm5lci4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gRml4ZXM6
IDY1NmU3MDUyNDNmZCAoIm5ldC1uZXh0OiBtZWRpYXRlazogYWRkIHN1cHBvcnQgZm9yCj4gPiA+
IE1UNzYyMwo+ID4gPiA+ID4gPiBldGhlcm5ldCIpCj4gPiA+ID4gPiA+IFN1Z2dlc3RlZC1ieTog
RGFuaWVsIEdvbGxlIDxkYW5pZWxAbWFrcm90b3BpYS5vcmc+Cj4gPiA+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEZyYW5rIFd1bmRlcmxpY2ggPGZyYW5rLXdAcHVibGljLWZpbGVzLmRlPgo+ID4gCj4g
PiA+ID4KPiA+ID4gPiAuLi4uLi4uLi4uLi4uLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVkaWF0ZWsvbXRrX2V0aF9zb2MuYwo+ID4g
PiA+ID4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lZGlhdGVrL210a19ldGhfc29jLmMKPiA+
ID4gPiA+ID4gaW5kZXggY2FlNDYyOTBhN2FlLi5mMWZmMWJlNzM5MjYgMTAwNjQ0Cj4gPiA+ID4g
PiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lZGlhdGVrL210a19ldGhfc29jLmMKPiA+
ID4gPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVkaWF0ZWsvbXRrX2V0aF9zb2Mu
Ywo+ID4gCj4gPiA+ID4KPiA+ID4gPiAuLi4uLi4uLi4uLi4uCj4gPiA+ID4gPiA+IEBAIC0xMTQy
LDQwICsxMTQyLDQ2IEBAIHN0YXRpYyBpbnQgbXRrX2luaXRfZnFfZG1hKHN0cnVjdAo+ID4gPiBt
dGtfZXRoCj4gPiA+ID4gPiA+ICpldGgpCj4gPiA+ID4gPiA+wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY250ICogc29jLQo+ID4gPiA+ID4g
PiA+dHguZGVzY19zaXplLAo+ID4gPiA+ID4gPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZldGgtCj4gPiA+ID4gPiA+ID5waHlfc2NyYXRj
aF9yaW5nLAo+ID4gPiA+ID4gPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgwqDCoMKgwqDCoMKgwqDCoEdGUF9LRVJORUwpOwo+ID4gCj4gPiA+ID4KPiA+ID4gPiAuLi4u
Li4uLi4uLi4uLgo+ID4gPiA+ID4gPiAtwqAgZm9yIChpID0gMDsgaSA8IGNudDsgaSsrKSB7Cj4g
PiA+ID4gPiA+IC3CoMKgwqDCoMKgIGRtYV9hZGRyX3QgYWRkciA9IGRtYV9hZGRyICsgaSAqIE1U
S19RRE1BX1BBR0VfU0laRTsKPiA+ID4gPiA+ID4gLcKgwqDCoMKgwqAgc3RydWN0IG10a190eF9k
bWFfdjIgKnR4ZDsKPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqAgZG1hX2FkZHIgPSBkbWFfbWFwX3Np
bmdsZShldGgtPmRtYV9kZXYsCj4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGV0aC0+c2NyYXRjaF9oZWFkW2pdLCBsZW4gKgo+ID4gPiA+ID4gPiBNVEtfUURN
QV9QQUdFX1NJWkUsCj4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIERNQV9GUk9NX0RFVklDRSk7Cj4gPiA+ID4gPiA+Cj4gPiAKPiA+ID4gPgo+ID4gPiA+IEFz
IHBlciBjb21taXQgbXNnLCB0aGUgZml4IGlzIGZvciB0cmFuc21pdCBxdWV1ZSB0aW1lb3V0cy4K
PiA+ID4gPiBCdXQgdGhlIERNQSBidWZmZXIgY2hhbmdlcyBzZWVtcyBmb3IgcmVjZWl2ZSBwa3Rz
Lgo+ID4gPiA+IENhbiB5b3UgcGxlYXNlIGVsYWJvcmF0ZSB0aGUgY29ubmVjdGlvbiBoZXJlLgo+
IAo+ID4KPiA+ICpJIGd1ZXNzKiB0aGUgbWVtb3J5IHdpbmRvdyB1c2VkIGZvciBib3RoLCBUWCBh
bmQgUlggRE1BCj4gZGVzY3JpcHRvcnMKPiA+IG5lZWRzIHRvIGJlIHdpc2VseSBzcGxpdCB0byBu
b3QgcmlzayBUWCBxdWV1ZSBvdmVycnVucywgZGVwZW5kaW5nCj4gb24KPiA+IHRoZQo+ID4gU29D
IHNwZWVkIGFuZCB3aXRob3V0IGh1cnRpbmcgUlggcGVyZm9ybWFuY2UuLi4KPiA+Cj4gPiBNYXli
ZSBzb21lb25lIGluc2lkZSBNZWRpYVRlayAoSSd2ZSBhZGRlZCB0byBDYyBub3cpIGFuZCBtb3Jl
Cj4gPiBmYW1pbGlhcgo+ID4gd2l0aCB0aGUgZGVzaWduIGNhbiBlbGFib3JhdGUgaW4gbW9yZSBk
ZXRhaWwuCsKgCj5XZSd2ZSBlbmNvdW50ZXJlZCBhIHRyYW5zbWl0IHF1ZXVlIHRpbWVvdXQgaXNz
dWUgb24gdGhlIE1UNzk4ODggYW5kCj5oYXZlIGlkZW50aWZpZWQgaXQgYXMgYmVpbmcgcmVsYXRl
ZCB0byB0aGUgUlNTIGZlYXR1cmUuCj5XZSBzdXNwZWN0IHRoaXMgcHJvYmxlbSBhcmlzZXMgZnJv
bSBhIGxvdyBsZXZlbCBvZiBmcmVlIFRYIERNQURzLCB0aGUKPlRYIFJpbmcgYWxvbW9zdCBmdWxs
Lgo+U2luY2UgUlNTIGlzIGVuYWJsZWQsIHRoZXJlIGFyZSA0IFJ4IFJpbmdzLCB3aXRoIGVhY2gg
Y29udGFpbmluZyAyMDQ4Cj5ETUFEcywgdG90YWxpbmcgODE5MiBmb3IgUnguIEluIGNvbnRyYXN0
LCB0aGUgVHggUmluZyBoYXMgb25seSAyMDQ4Cj5ETUFEcy4gVHggRE1BRHMgd2lsbCBiZSBjb25z
dW1lZCByYXBpZGx5IGR1cmluZyBhIDEwRyBMQU4gdG8gMTBHIFdBTgo+Zm9yd2FyZGluZyB0ZXN0
LCBzdWJzZXF1ZW50bHkgY2F1c2luZyB0aGUgdHJhbnNtaXQgcXVldWUgdG8gc3RvcC4KPlRoZXJl
Zm9yZSwgd2UgcmVkdWNlZCB0aGUgbnVtYmVyIG9mIFJ4IERNQURzIGZvciBlYWNoIHJpbmcgdG8g
YmFsYW5jZQo+Ym90aCBUeCBhbmQgUnggRE1BRHMsIHdoaWNoIHJlc29sdmVzIHRoaXMgaXNzdWUu
CgpPa2F5LCBidXQgaXTigJlzIHN0aWxsIG5vdCBjbGVhciB3aHkgaXTigJlzIHJlc3VsdGluZyBp
biBhIHRyYW5zbWl0IHRpbWVvdXQuCldoZW4gdHJhbnNtaXQgcXVldWUgaXMgc3RvcHBlZCBhbmQg
YWZ0ZXIgc29tZSBUeCBwa3RzIGluIHRoZSBwaXBlbGluZSBhcmUgZmx1c2hlZCBvdXQsIGlzbuKA
mXQKVHggcXVldWUgd2FrZXVwIG5vdCBoYXBwZW5pbmcgPwrCoArCoApUaGFua3MsClN1bmlsLgoK
IA==

