Return-Path: <netdev+bounces-97917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBF18CE06F
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 06:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660CB1F21B69
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 04:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7C0383AC;
	Fri, 24 May 2024 04:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="J6rCFt59";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="HYHx/spw"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4430B3C00;
	Fri, 24 May 2024 04:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716525891; cv=fail; b=eXYoZH8Hm5PGEpClyDpvlfhYELqCW+1WDZRMBUSx77/WLiJj1FJLyiUh9gXhW1ZMCaMvENehMqgn/AZl38JFR8dIMageLX1h6Wv4J/igcYJ3BHXPuQcAwmt9gCVXQEnecINV1/jndlU8Jn2r4o5/VGXXHbVraZ+R/04ut7/g2t0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716525891; c=relaxed/simple;
	bh=IhZXl9rp+Zb9kI6C6GlFuUxlBWMPuWObFhMRbn+zBLo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aAh/tziN+DSP7eVgp8aIHhay1RjI2FzI1741VyO8fj9dtb9tymC2Pa5czrirF5fgxFBFJ+pJZ+YIxVynFCaKgF8eSei+162uY1WMKWhlJHtw745kIuUQCnHMpEFwdLn6pUQ9FZwIkrSvyUGz+7eDQap/lFP0aMpOOYtXpG7tVAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=J6rCFt59; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=HYHx/spw; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 56c99a30198811ef8c37dd7afa272265-20240524
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=IhZXl9rp+Zb9kI6C6GlFuUxlBWMPuWObFhMRbn+zBLo=;
	b=J6rCFt59X/3Qb3WKLUc8u7OUpqnH8hY7cZLer8M4yikGeDdgjtY9MLq1R3Jg4sKZDNeQNqI6AnDS4L/Q60KNm9KEmq5vGF1jXhCjsKWfFHzSB2QQiVnGt+MKaMi3XXtez68tiW05ULCHfhao0bRzjJTu3VKIls/Z8V9hzdKpoWc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:d6732d84-c838-483d-89f4-cc2478fbc72e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:4b64c187-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 56c99a30198811ef8c37dd7afa272265-20240524
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 968643339; Fri, 24 May 2024 12:44:43 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 24 May 2024 12:44:42 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 24 May 2024 12:44:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkaNSZF+mAO/nR5WCnIhOyVSDStjD1gND4dNRkcFWrUb+zqOCThBDyB1cYpmhDOgT+a6dnDsF/4holGougqAVnEcLri4w1b3wnKxkL+KhOE6x0MrhNRDoLlCacEGYqNZpZtWqdvvpiEdBqMJDc7/YNn2pT6A+kTQc3vu1LKENbKUVJ4YqLjXXJ49A3Bf863kIT0d+RWV3FEFiCIfp/OGFSpHxGJRK7Hp+W/OKK6BQQ7v8TafnBER8C0tUEjP9cBEfBwEhbBffO931fjnE7wFQbwuOWv0Il5L+NMUg0dp3KV8RVlkx4lANzJp1G8+dT12fJVNy1iQzccApwjSxcQ0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhZXl9rp+Zb9kI6C6GlFuUxlBWMPuWObFhMRbn+zBLo=;
 b=OKZS2RbS98mg+DJX4y0pcbTW4O4pjCLzVTL4t+pBku9W5LbWeA1y+iWmeoGcu1FLBQRORHaNcwJlaH7f1NkwmbSJTvQ/hd+ni3W2ifhMM+tQZsMblrtt2DUzqtidu9glEruY8d4dWDdv8CXZDl1ERmNpxs+LoUWzEYLfF0YLSoD3SR0YJQtkC1bBY+f1TchgMIDql51tYBVAkCEEoItOLfV3NauPV7QNkuPvLMuQmU1KrGe8hBnhaTEOWRdI8ru5S8jLB/JG3QpV17KNruKpegujKMlCqZDZEJ+qw2kaB2y4KekXc0ktLZKqJl/jexxpgkCFKTbASUP5jchz3THgIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhZXl9rp+Zb9kI6C6GlFuUxlBWMPuWObFhMRbn+zBLo=;
 b=HYHx/spwx4dXKLlQ7DzuI8JJyVgvceM796qliImTn9BgOrN5QJmDWUNPOwwm2P2NjPLLrApycnBgLLAjfWI+hK+wNRchSyZhAr4MRZ9SWdkuUa4RcxXXbXqSHwRvn56ZcvFSMoDpBsjpAG/oI/LYo3yTvyQLHDViK6nK+Rlue3c=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by TY0PR03MB6498.apcprd03.prod.outlook.com (2603:1096:400:1bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.17; Fri, 24 May
 2024 04:44:39 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.7611.013; Fri, 24 May 2024
 04:44:39 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dqfext@gmail.com" <dqfext@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>
Subject: Re: [PATCH net-next v3 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Topic: [PATCH net-next v3 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Index: AQHaqqo0nm3iQO4q8kqKvRUSCwrNqbGgH9UAgAE5fYCAAJnpgIAD4ZqA
Date: Fri, 24 May 2024 04:44:39 +0000
Message-ID: <f65d90f7d044a507eed31feeecb907b9a5f8d05c.camel@mediatek.com>
References: <20240520113456.21675-1-SkyLake.Huang@mediatek.com>
	 <20240520113456.21675-6-SkyLake.Huang@mediatek.com>
	 <1158a657-1b95-4d7f-9371-41eec5388441@lunn.ch>
	 <ab5df65ebd52dfd54231b9b12657d47218df8f25.camel@mediatek.com>
	 <8af5b5b0-84b0-4603-8190-9661038d3ea5@lunn.ch>
In-Reply-To: <8af5b5b0-84b0-4603-8190-9661038d3ea5@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|TY0PR03MB6498:EE_
x-ms-office365-filtering-correlation-id: af6a6eee-8572-4d92-6d1f-08dc7bac38bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?SkRhMlVFdVVFMFN1aHRRbTIzZjFoM0docjVscWdmL25rUmMvS1BqYlBSaGEw?=
 =?utf-8?B?L0drWHN0NUxiWUUvM1Z3ZUNwNWl0U0k2Mm9MOFcyNityWDI4UXRIbmFEczZx?=
 =?utf-8?B?ZlpIK1lVK0MzcVNXR21zSEhNTExQRnNoK0NRbmF6QStZdStJWmF6YjhYUVBp?=
 =?utf-8?B?UWJhb0tzMG9jR3IveXpaeUdSam1Xa3RHNzEwOWxSUUJic3BSVHM2bFUwZEJn?=
 =?utf-8?B?Z3RVd3J0WGM1b3dETkpEZkdobmV5WDRsY1lwVXh2bUszU2JhaFk4M1daaC91?=
 =?utf-8?B?bEN1bHc5QXRmNjNLek9pajk1bmJoMGpKZXhFQld0dDdlZ2JhMkp0N0FqYWlV?=
 =?utf-8?B?UGt0UmtSSDZ6aWRBTkNIUmkxeXo2YWFGVlRnRFZSRkZTOVY4K0RPMDVhTk5E?=
 =?utf-8?B?U3FuOVIwWktPQmR2bnIyOHk4ekdNdUxJdmJhWHJTZnNzRUE5Wjh0T0N4d05t?=
 =?utf-8?B?NEFOODlDRDA2Ui9kd2ZSOFFmU0RnSEh1ekZFMG9qS2QyYjE5a1h4cHJvZDdI?=
 =?utf-8?B?NjdmeGR5aXBCYklyTE04V2FURVdSSFQyaExGbFJiQ3pDa0kwaHQ1c0NzdGdJ?=
 =?utf-8?B?RStPb0VadFdGUUlhRjN5bGhUNnpjOWlrL2FvR2RNaWZMRmljdnI5REJXTmtK?=
 =?utf-8?B?RVdyU2pqUlRkb2lvOGxkVDNUbml2SE9kWmJsV0V1czBCbWRLVUs0ZlQ4TFlW?=
 =?utf-8?B?bWYycE5tWVNseTZ3ZEQ5VnBNdFlNbEdZOGxIMm5FR2ZGbHg4VVVaOVIzRURr?=
 =?utf-8?B?aWFxMUlBeDJucERzc1g3NFlabHdXSUdsb2xDZjIzRHFnWkFFaTR0Zi9nN2My?=
 =?utf-8?B?NGxHcEVnMjdxUWdaenllQmJjNnllVmRnaTlQQXViRnVOSS8yNGd4QUkzdHph?=
 =?utf-8?B?RE9jQmxsQXNxTmpvbllOMnliS3kvZW9yY0dCWG10dzQvRlliRnByMW92T0Nq?=
 =?utf-8?B?SDFjdzhxaE9sMENZdnNGTTgrMlNPRlRmRStOc0NaQVlxYkRaRFl4c1ExRFlU?=
 =?utf-8?B?MXVrRmc4QWl3WlJXMmkrSi8zejlMN2NWK0ZpeTU5OEZwS2lBaElZeWwwNDVk?=
 =?utf-8?B?SVF4OXFUanU2YkZXb3M0YkdhWHMrLzdBaGQ5QUV0eWhXU2pvbDNna0JzdUhx?=
 =?utf-8?B?NGtPWGpyWjBvR0Fwck9YQTQ3SUZKR1dkREZueTZZQXdnQzg0UnMwT2dzUFFm?=
 =?utf-8?B?NGxQVkVYQ1ZXQmVGb2krU0xENlpEY2dKenFQUmxhSGZxaVA3VVdOMGtwTktQ?=
 =?utf-8?B?RE9OTWZhci9FV0kyR2VXU2FIaWVheWM0OFowdXRrODl4NFVVNTN3M3U3MFNP?=
 =?utf-8?B?eW1nTS9mRlUvbXNpckRsSytwV3RUVnlQUGtoeHRwMElsWHFobXBuOU9HNzJQ?=
 =?utf-8?B?MDBsZmVJeGdXT05pdHEwcnljK2tFWnFReUlJY3RzQmZrcHJuR0Y1YVlIekNB?=
 =?utf-8?B?SG1xdXhiVU9WaFpJZWFOZTFmdXlhVTc1UDJkYXlVYjJUQjhya0crUVdZaC9B?=
 =?utf-8?B?YTQrbnE0Q2xoWUZHTEpBNVBmZHlhaGdKdGJnbEtEYzJsWlVrNGFqaDcvWENT?=
 =?utf-8?B?c2kzU3ZiQ3p6S0Rrb005QXFEYWNYYTJVOUQ2OE1ETS9qTUYxT0ZlMldaSGY2?=
 =?utf-8?B?RWVSaEI3ZU5PVUJSbjcrQzIycWlHV0I1U1FwbkhpckZkSEFjODF6a1llWW1s?=
 =?utf-8?B?Vk43ZFJlNDRXRFM1c3I5Ung2dGFlcWdHM1oxenZ2SmE1R3NVN0JXZk5aY3JB?=
 =?utf-8?B?WFNnQjY3aGt1ajlKUHB6OEx1MDlic2dlMGZDUm5UbHkwbllGZmdPYnVMNVY5?=
 =?utf-8?B?aWNxTElTRTd3c25ka2t0UT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTVvQ0dOdDdQbWJEcmlabHFKWFNKS09pTXFaZkNuNWhkNUZONmRlMFFXdTlJ?=
 =?utf-8?B?WTFXa05DZENoaXMzYmxmRnluWTVnUTdDdmZHZGRNWHJsa3huY1hzZXBFZDVu?=
 =?utf-8?B?aFVFUFpwdGhMZmVuQTBTeUVaRXJsOVNyWTdTd3g1QWtWZHp4N1M2UVpmajVW?=
 =?utf-8?B?NFlBV29oTG9DZ3BJL2ZkdWZnZVJXRkhFWjhZcFNMRVhkSUdjU05WME9QU1Ro?=
 =?utf-8?B?VEU4RTBGaHVxOWUvdWN0YVNVdWtHVDQ3R29Xa0NSYTlaaUxjUWxQM1V0cWRU?=
 =?utf-8?B?cXFpV3ltK3MzUnhmbGZMRWhrT2xWNUpzWXMreGZWUHhLK3lLR3U4NjZqcU9X?=
 =?utf-8?B?VGd6eWdZdzl2amNFdUZYcjhudHUrdFoveU1FRTYxZnZseVEwZkRWNWt0TUt2?=
 =?utf-8?B?NWsxUGljMjBHZlc4c3JWenRLTkVrSTREY3FZbzJqL29MUkx4azVwczA5WE51?=
 =?utf-8?B?RmZUc1pwditZS2YxVFNzdXQvMWp4V0hrSzQvVUYxOGFhN2p2aVdnZ0tyOGF6?=
 =?utf-8?B?U1pxcTB2cWNRb2QyZVhjWFlyNUIzSE0za1o3UFVaWEFCazAybGJXbmM2YVRW?=
 =?utf-8?B?QkF3VU9GSFI0Sk1BZE8zVU90Rzh5Uk9FSnpoRjcydkVveHR4TUZncWNmd2RR?=
 =?utf-8?B?azFzekZzckM4S0g0c3FKcnZ5aVNOZVBCeWJlRmRsd2ZsYnhVYXo0Nm9HS2l6?=
 =?utf-8?B?NE14Tkx0SzdVR1k5ZFAvL1lzUUFyLzNpdnR5ZENxSkJJNFhURnNPM0VvUVNk?=
 =?utf-8?B?UkhOS3FWQ0ZWeFcvVHhpNmJUWjJ6eS9heVNpTGhCSzVYOVgra0dENFgwVjgz?=
 =?utf-8?B?N0t4OGFpRGtKT21CbU5OK3lWeTM2M1lrQ2ZvL1MrL3h6V0o5SCt6V3dOS2pR?=
 =?utf-8?B?dzB6V0x0VzNZelhuRENUYnM0MTYwejc2YzZUNTcwakhxM1NHSVhma2ZwTDRy?=
 =?utf-8?B?RkhHYW5tVENMMXgxT3NQcE5jUGR4WDl6UVUyOXEyRXF1enJLWlArLzRZRG1W?=
 =?utf-8?B?bFoyWmVEcWNxYWkrZm9CTEpqRTVkbG1MV1BXRWNMbEwrblVnOVVHN2VONWRw?=
 =?utf-8?B?dGdGYUlPdi9rUW03Ni80UnVrTURETkwvelZ6WE10eVZTNzQvOTByWXBSaWQz?=
 =?utf-8?B?RmhoRjNpUHM0dkhVM2ZrQW4wMnJYNForb0t4WFRxRnk3NEpiblhxUnA1cHVn?=
 =?utf-8?B?aHpRdWNUZkdkcHNSd3Q1dUFmRHZPWDZlQWk5c25ZY1p4ZlFLWlZqWkt3aG9p?=
 =?utf-8?B?Ri83QWFyNmVqcEhaWGl3d2lwaFV6QlAzS08rdU1hYXhSUWdveGFFdFJOb1Jo?=
 =?utf-8?B?a1VEbnFBT0ptUEp3OTIydk40bnI3aUFiSXVnOHd6S0d2emY2RStEZ3pUcWVl?=
 =?utf-8?B?aUhuTUlSSyswNHd6ZmxxaldlU00vbWI2UFpxcmdZT3FZMXZmK25FSE93UzVj?=
 =?utf-8?B?c1RXRlZDakFzMEZXVjRjZ0JjWjBoZXpxbzh2UGd5WkFIUWtnU2RMdGp2K1hl?=
 =?utf-8?B?REN1cm0zMzBlTkp3ajlyT00rNWRYeDd4NmVsWURqZVk5MEhLbDRqc3NwdUtV?=
 =?utf-8?B?SStwWWMwNnROUkU4a1pZZXYvMGxBQ08vbU44cGxkNFlLa2VTcjduV2VkQWNR?=
 =?utf-8?B?ZDV6WCs2ZHk2UFNnYzF2SndUSUZRcm5BaG9Qc3R2MGNYRjRyYjR3UHpvWXJF?=
 =?utf-8?B?QkpxNjB1bVdhWjlRT24vTmQwbjR3VWE3Z1l5THhWd3FrL2RWUmVwZjViUHZD?=
 =?utf-8?B?WDNXUGdlMi9sNXQwTC9oVzdKb0k1K1lrSkVWSGhjaVVUNFhGYjU1ejlCek5z?=
 =?utf-8?B?UXV4OEVXNFRoMU1FQU9HcUxjb1F6c1dKNkpvN1crY1kxTzlSTzU4ZThLZGp5?=
 =?utf-8?B?K0hXMDEzdE10ai9ZQStpb3RySHNOeXVLOW1mQkEvK1g1cmV0MGRpNEswYW96?=
 =?utf-8?B?YVAwQk13cUsrQk1VQlZZUDduYnNRbFRYSGhSR3FPM1ZXcUFQYjdObUpIdWlK?=
 =?utf-8?B?NExyZzlTSnJEV01TRjZJNXQyV2c2ZWUvc3I2NGJCN0hiSXVZMEJrbzFuTS9z?=
 =?utf-8?B?TGNRT1BDOE10aHNHQjJ1THZIeGFQelVVWUJBS21UdlpSMkRkNWNyeFU2UEdY?=
 =?utf-8?B?MVJSQzA5MFJNNlNWbm1VZ01VTmNNZWFXeDZTZEVPWURicEZLUFFRRWxBSm1w?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCADD620305E9F4082AFD191DDFFF00B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af6a6eee-8572-4d92-6d1f-08dc7bac38bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 04:44:39.6307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t17oGorcmMKn9y8lZfLIwvC45scXZRuvjhfiQLccQYIOK/CoXq3GcpALwgOyDtP+OH+aOlbrqr5+Aqx4OegAm9Jb9iS4f+puofP70UXY4Is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6498

T24gVHVlLCAyMDI0LTA1LTIxIGF0IDE5OjI4ICswMjAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICBPbiBUdWUsIE1heSAyMSwgMjAyNCBhdCAwODoxNzozMkFNICswMDAwLCBT
a3lMYWtlIEh1YW5nICjpu4PllZ/mvqQpIHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyNC0wNS0yMCBh
dCAxNTozNSArMDIwMCwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+ID4gPiAgIA0KPiA+ID4gRXh0ZXJu
YWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMN
Cj4gdW50aWwNCj4gPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+ID4gPiAgPiArc3RhdGljIGludCBtdDc5OHhfMnA1Z2VfcGh5X2NvbmZpZ19pbml0KHN0
cnVjdCBwaHlfZGV2aWNlDQo+ID4gPiAqcGh5ZGV2KQ0KPiA+ID4gPiArew0KPiA+ID4gPiArc3Ry
dWN0IG10a19pMnA1Z2VfcGh5X3ByaXYgKnByaXYgPSBwaHlkZXYtPnByaXY7DQo+ID4gPiA+ICtz
dHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGh5ZGV2LT5tZGlvLmRldjsNCj4gPiA+ID4gK2NvbnN0IHN0
cnVjdCBmaXJtd2FyZSAqZnc7DQo+ID4gPiA+ICtzdHJ1Y3QgcGluY3RybCAqcGluY3RybDsNCj4g
PiA+ID4gK2ludCByZXQsIGk7DQo+ID4gPiA+ICt1MTYgcmVnOw0KPiA+ID4gPiArDQo+ID4gPiA+
ICtpZiAoIXByaXYtPmZ3X2xvYWRlZCkgew0KPiA+ID4gPiAraWYgKCFwcml2LT5tZDMyX2VuX2Nm
Z19iYXNlIHx8ICFwcml2LT5wbWJfYWRkcikgew0KPiA+ID4gPiArZGV2X2VycihkZXYsICJNRDMy
X0VOX0NGRyBiYXNlICYgUE1CIGFkZHJlc3NlcyBhcmVuJ3QNCj4gdmFsaWRcbiIpOw0KPiA+ID4g
PiArcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiA+ICt9DQo+ID4gPiANCj4gPiA+IC4uLg0KPiA+ID4g
DQo+ID4gPiA+ICtzdGF0aWMgaW50IG10Nzk4eF8ycDVnZV9waHlfcHJvYmUoc3RydWN0IHBoeV9k
ZXZpY2UgKnBoeWRldikNCj4gPiA+ID4gK3sNCj4gPiA+ID4gK3N0cnVjdCBtdGtfaTJwNWdlX3Bo
eV9wcml2ICpwcml2Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICtwcml2ID0gZGV2bV9remFsbG9jKCZw
aHlkZXYtPm1kaW8uZGV2LA0KPiA+ID4gPiArICAgIHNpemVvZihzdHJ1Y3QgbXRrX2kycDVnZV9w
aHlfcHJpdiksIEdGUF9LRVJORUwpOw0KPiA+ID4gPiAraWYgKCFwcml2KQ0KPiA+ID4gPiArcmV0
dXJuIC1FTk9NRU07DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N3aXRjaCAocGh5ZGV2LT5kcnYtPnBo
eV9pZCkgew0KPiA+ID4gPiArY2FzZSBNVEtfMlA1R1BIWV9JRF9NVDc5ODg6DQo+ID4gPiA+ICtw
cml2LT5wbWJfYWRkciA9IGlvcmVtYXAoTVQ3OTg4XzJQNUdFX1BNQl9CQVNFLA0KPiA+ID4gTVQ3
OTg4XzJQNUdFX1BNQl9MRU4pOw0KPiA+ID4gPiAraWYgKCFwcml2LT5wbWJfYWRkcikNCj4gPiA+
ID4gK3JldHVybiAtRU5PTUVNOw0KPiA+ID4gPiArcHJpdi0+bWQzMl9lbl9jZmdfYmFzZSA9DQo+
IGlvcmVtYXAoTVQ3OTg4XzJQNUdFX01EMzJfRU5fQ0ZHX0JBU0UsDQo+ID4gPiA+ICsgTVQ3OTg4
XzJQNUdFX01EMzJfRU5fQ0ZHX0xFTik7DQo+ID4gPiA+ICtpZiAoIXByaXYtPm1kMzJfZW5fY2Zn
X2Jhc2UpDQo+ID4gPiA+ICtyZXR1cm4gLUVOT01FTTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArLyog
VGhlIG9yaWdpbmFsIGhhcmR3YXJlIG9ubHkgc2V0cyBNRElPX0RFVlNfUE1BUE1EICovDQo+ID4g
PiA+ICtwaHlkZXYtPmM0NV9pZHMubW1kc19wcmVzZW50IHw9IChNRElPX0RFVlNfUENTIHwgTURJ
T19ERVZTX0FODQo+IHwNCj4gPiA+ID4gKyBNRElPX0RFVlNfVkVORDEgfCBNRElPX0RFVlNfVkVO
RDIpOw0KPiA+ID4gPiArYnJlYWs7DQo+ID4gPiA+ICtkZWZhdWx0Og0KPiA+ID4gPiArcmV0dXJu
IC1FSU5WQUw7DQo+ID4gPiA+ICt9DQo+ID4gPiANCj4gPiA+IEhvdyBjYW4gcHJpdi0+bWQzMl9l
bl9jZmdfYmFzZSBvciBwcml2LT5wbWJfYWRkciBub3QgYmUgc2V0IGluDQo+ID4gPiBtdDc5OHhf
MnA1Z2VfcGh5X2NvbmZpZ19pbml0KCkNCj4gPiA+IA0KPiA+ID4gQW5kcmV3DQo+ID4gVXNlIGNv
bW1hbmQgIiRpZmNvbmZpZyBldGgxIGRvd24iIGFuZCB0aGVuICIkaWZjb25maWcgZXRoMSB1cCIs
DQo+ID4gbXQ3OTh4XzJwNWdlX3BoeV9jb25maWdfaW5pdCgpIHdpbGwgYmUgY2FsbGVkIGFnYWlu
IGFuZCBhZ2Fpbi4NCj4gcHJpdi0NCj4gPiA+bWQzMl9lbl9jZmdfYmFzZSAmIHByaXYtPnBtYl9h
ZGRyIGFyZSByZWxlYXNlZCBhZnRlciBmaXJzdA0KPiBmaXJtd2FyZQ0KPiA+IGxvYWRpbmcuIFNv
IGp1c3QgY2hlY2sgdGhlc2UgdHdvIHZhbHVlcyBhZ2FpbiBmb3Igc2FmZXR5IG9uY2UgcHJpdi0N
Cj4gPiA+ZndfbG9hZGVkIGlzIG92ZXJyaWRlZCB1bmV4cGVjdGVkbHkuDQo+IA0KPiBTbyB0aGUg
Y29kZSBpcyB1bnN5bW1ldHJpY2FsLiBUaGUgbWVtb3J5IGlzIG1hcHBlZCBpbg0KPiBtdDc5OHhf
MnA1Z2VfcGh5X3Byb2JlKCkgYnV0IHVubWFwcGVkIGluDQo+IG10Nzk4eF8ycDVnZV9waHlfY29u
ZmlnX2luaXQoKS4gSXQgd291bGQgYmUgYmV0dGVyIHN0eWxlIHRvIHVubWFwIGl0DQo+IGluIG10
Nzk4eF8ycDVnZV9waHlfcmVtb3ZlKCkuIEFsdGVybmF0aXZlbHksIGp1c3QgbWFwIGl0IHdoZW4N
Cj4gZG93bmxvYWRpbmcgZmlybXdhcmUsIGFuZCB1bm1hcCBpdCBzdHJhaWdodCBhZnRlcndhcmRz
Lg0KPiANCj4gQWxzbywgd2UgZ2VuZXJhbGx5IGRpc2NvdXJhZ2UgZGVmZW5zaXZlIHByb2dyYW1t
aW5nLiBJdCBpcyBtdWNoDQo+IGJldHRlcg0KPiB0byBhY3R1YWxseSB1bmRlcnN0YW5kIHRoZSBj
b2RlIGFuZCBrbm93IHNvbWV0aGluZyBpcyBub3QgcG9zc2libGUuDQo+IA0KPiBBbmRyZXcNCg0K
T0suIEknbGwgZml4IHRoaXMgaW4gdjUuIE1hcCAmIHVubWFwIGl0IGxvY2FsbHkgaW4NCm10Nzk4
eF8ycDVnZV9waHlfY29uZmlnX2FuZWcoKQ0KIC0+IG10Nzk4eF8ycDVnZV9oeV9sb2FkX2Z3KCkN
Cg0KU2t5DQo=

