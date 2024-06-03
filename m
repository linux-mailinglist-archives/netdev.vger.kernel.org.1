Return-Path: <netdev+bounces-100044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B9C8D7A65
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 05:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20A7A1C2084E
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 03:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A64BE6F;
	Mon,  3 Jun 2024 03:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IMountaC";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="kPymu0x1"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F982904;
	Mon,  3 Jun 2024 03:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717384555; cv=fail; b=VEQ8dQ7qzGiVonDccX6sciTIEvpBBqON9ignasg4xVZc8+4jMS/qVoaoa38+NbmfTpfUDpVLSpwKWmlBuJyhdRZIlj6AsUWTbHb6iM9vW+i0VANR6sArhgKOgdyCLsviHATJRHw3dtyD10PRnE1Evqgqe+W2mXH5qc/Ec7cHr4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717384555; c=relaxed/simple;
	bh=tjN/XBUQiV2NukJ+g6/9Et61Zis33OpyRIBj8ZqcDi8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MAWXmjButM/2F3pGpscheb0qB2MUpDzC62cHsh//yXWB8wxtm//TCOzPy6thJjmx0JUOETmil9gD23KcqFYXDW+BKYgTwbSlWkP/a1PrG8JVXeGMAuL7LAtG0zuOx5JQMXKYafmrpRui02E41q/TBR3w1fdJpSWYgoVLgbxe2sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IMountaC; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=kPymu0x1; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8eb80f86215711efbace61486a71fe2b-20240603
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tjN/XBUQiV2NukJ+g6/9Et61Zis33OpyRIBj8ZqcDi8=;
	b=IMountaC2bZrmTrBUUTgN99o1Ttwi8xMlshYKBQyGjyPsfgrS03m6OzyVL4yQGJq3+b0wMNUTpwSTV4K2ezfh7uNxRDoabw5+FxJf3w2sFe1wXeogAS6eUTeDUPft/JjANpAQARNxYIAN3+ZioQT4XY5T/vofJRSA/yUrHOKb6U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:57e76191-6fe5-42a9-9601-32fee75ba928,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:393d96e,CLOUDID:9ea11e44-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 8eb80f86215711efbace61486a71fe2b-20240603
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 961076710; Mon, 03 Jun 2024 11:15:41 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 3 Jun 2024 11:15:39 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 3 Jun 2024 11:15:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLWf0fywuQimmszkDBkTu4OxU24wV0JU+i1czsIuvs/pUhk8EuaEfxBHKkqYcFaF8opgDW5HB/IwJWmAq2bnPPpK5rbLmLINd9oERF0gbuBuOsU09KBDCeCOnRU1GArhxebSpjn+rFnjtvD6S9ITfhLE8vy/BuKMY2qu/AlIjVpteYs88HFZ0fasugZ7Uf1z27AsL+tbWt9qKlFF6DnaptfwDwOxQpDQF2ZHbTYTRe9/z5IDniu3bWsy9KaCK+e6WpheV0j1So8q2kKkNY5fSzu92SnuzdsMQRV8hyJPMX0wM7PI8hRwhr2++4RSTt/MkT3FypqhMwVcufF2x8NhSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjN/XBUQiV2NukJ+g6/9Et61Zis33OpyRIBj8ZqcDi8=;
 b=PG/DSHVfLcCDWhA/4RfGPGus5JnK//xt0q9pAfOvADmhH4spWg89v1IXNkD+gTc6v/9DoyL2E+TRdNOJCJGnyc/HCUujPJkXLid90h6lFf45/TJt/BuNUGLYQtf1lboVAth35/dWffJhWkCL0i4qGnqvDr52Yt2zg05tAYm/N4qXW3vAztauDsL7ERCZCl7Lcv/NixbbIW7hpQiAJ2iME54ULDEwjWmS/cpgcYYHWAcDJt5ROygDYJpUJH4VO6qK2TkLvwcMV1q0+Jyd2i+K+wp+fnc6hhwCDuYBSdO2qRH545sRB3MTyTVxlQR5VQ+CbV10Bvlp1weSYscRjR3Skg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjN/XBUQiV2NukJ+g6/9Et61Zis33OpyRIBj8ZqcDi8=;
 b=kPymu0x1R2nIympqFvR1aJvtbi4u7H77RWJOiNJQrvGqjB0MRGqE/axIzAxXR8Tp6IiiI1E5+urk+6saaVB6bjAekyvzJGjlqWxxrRWrqHLClQGnmt08WNZqkresDlxm8T/7axkc8BBXCuyJdBnTGDzQw5mP0qn71kbl3s5944Y=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by SI2PR03MB6664.apcprd03.prod.outlook.com (2603:1096:4:1eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Mon, 3 Jun
 2024 03:15:36 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%3]) with mapi id 15.20.7656.007; Mon, 3 Jun 2024
 03:15:36 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dqfext@gmail.com" <dqfext@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>
Subject: Re: [PATCH net-next v5 4/5] net: phy: mediatek: Extend 1G TX/RX link
 pulse time
Thread-Topic: [PATCH net-next v5 4/5] net: phy: mediatek: Extend 1G TX/RX link
 pulse time
Thread-Index: AQHaskSf1DfXvyWrZkOPqw4pAUjQdrGvkmKAgABeO4CAAAKXgIAFcNmA
Date: Mon, 3 Jun 2024 03:15:36 +0000
Message-ID: <e25de8898d594d14ade148004fdddb1f2c5b47f7.camel@mediatek.com>
References: <20240530034844.11176-1-SkyLake.Huang@mediatek.com>
	 <20240530034844.11176-5-SkyLake.Huang@mediatek.com>
	 <ZlhTtSHRVrjWO0KD@shell.armlinux.org.uk>
	 <a6280b885cf1cffa845310e7e565e1dd7421dc66.camel@mediatek.com>
	 <Zlik7TfUsOanlBMV@shell.armlinux.org.uk>
In-Reply-To: <Zlik7TfUsOanlBMV@shell.armlinux.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|SI2PR03MB6664:EE_
x-ms-office365-filtering-correlation-id: c49aa148-3589-4f91-5969-08dc837b703f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?cW94VXlQcExHM1VEMXhTZ3I1MldEMkRxUGZuZHlJSEJOS1NNYUlRMWEyVjlY?=
 =?utf-8?B?ZWljd1FCbzhoUlpFWjdrRVgrZXh4aVpHUDJnUlRsMEJScExxMmRud2NrNlRx?=
 =?utf-8?B?c0tRTGhpOGRma2IrMldaRmwxTGIxWWxUM01jTWx1U0Z0b1ZzdmZRdXQ5dmtN?=
 =?utf-8?B?VVR1bHRkVmdxTDQzd1hCSmsycFhBUndlYmNhek91Y3dFQ21EUE1lTlRRUGRI?=
 =?utf-8?B?R3JCbU1MTGhzQTlvRFErUnd6N1ZGRWw3VzFZWTczT29uR3dPNm1SOSs1ZmUr?=
 =?utf-8?B?YkU4QXFsRWlZOFpiN29mNFRCUTBqNnNIMUhnREJTT0dNcUJ3QnhjWUcyMHdM?=
 =?utf-8?B?THVBc1JEcWRhY2cwa2JINHhwZmF0UmpBUGMzc3IwK2hlRmRTbE5rQXlkTm8z?=
 =?utf-8?B?am5KWHZtZVZvUTd2UHpMc29jR2RmWmJIbzJzTGdUeHNDQnRlaHp1UUhVQUx2?=
 =?utf-8?B?MjhJOFIvd0VscU52TUdZZHJYNlVBbkhaT0tOdCtZTzBFZmpzY2owVUc4Zzd1?=
 =?utf-8?B?VWtBU1ZHV3FkV3dhUGlvZzVVRnpMeVZ5cW5WUXZRQzJSNGt0WE1ZNnc0ZGYw?=
 =?utf-8?B?U04wV0hUMktudS82eG9yUUZycnFoSnQrR0VBQ1NkYWdzUkgvT3ZwWEhEOTNt?=
 =?utf-8?B?cnZmMmZYcWV2RjYyaGtZb2ZxVm1DZVpJTXd3aE10ZzFqWTJwWUZlWDdsNVZ1?=
 =?utf-8?B?MytyRUxQQ05TWUhHcjdndU9YbnBpTk5YSGZmRzJVc3RqajNLU1VSWjBZaG1S?=
 =?utf-8?B?QjRRNUZsb3NtLzBMdndncmtjdDVTbjZsUnl6RFNEaWtrVGRhNWhxa0c4OHNG?=
 =?utf-8?B?S3pnbHJsVWFmL2ZNazlDUUltT1llRmc2UTdwV1pZN05RZWNuaGNtMTB3SEdM?=
 =?utf-8?B?TzBNcXNKY0xRb0RRb054NTFhQjNtMmJ1UnBRT3hvM0UrSndDc3NTQzZ1a0dx?=
 =?utf-8?B?cE5Sd2NlUjl2VWM5VzVEWm4xZEdPZTVlRFJrVzllYS9VWU5Ock1Wc2JkR2NH?=
 =?utf-8?B?L0twK0gxZGlnZ1NKd3FES0JzQk9PYkJYaWwwanR6K2tKVkU1VzVJc3FmV1g2?=
 =?utf-8?B?RnMrN2s5WW1DeE5JUEE4a2M5eW12MGh2NWNKWVkvSkJ6endudlA5bFZHY1Yv?=
 =?utf-8?B?WjlkMzNNeThoMHdZVXhUMW5lNlhsaGNXUWZ4MWxIcGJTdWhVWlovWXV5eXNW?=
 =?utf-8?B?RDJkRW8rU1ZYeUVmTW93YkpqenR5T1hiV0JTckM3SXZoSDRKZUxVQ1pTU1U5?=
 =?utf-8?B?aythclVjSi9RSjE5a0NmSkY2a0dWOTM3TmJOWWtYZ04rUnorK3grOVp6RnM5?=
 =?utf-8?B?WE42K1djcjRZQzdXR01VU3NEaStFejRQY29CZWNWTzNCSGQ2QWN0S1hxYThK?=
 =?utf-8?B?ZWFDS3RpaVVxSVF3QnlDanJFY1dQSzlhSmlwRmVFMnZqZjFoOGlIT25QWldB?=
 =?utf-8?B?STFMS3ZPcG1hanhQaEZzOFMwYUdPZXFnaytTYnZycFhxL3BqbTdWM3ZVcExM?=
 =?utf-8?B?RkNZbGNWeXZNOTBDTk5KSm5lOWk2aUkxNCtGd1VjMFBhcTBUR0JuR3pnTDVE?=
 =?utf-8?B?d3ZMWlExbmZCaWNrRDMzQi9XMVVORDJGS0ttdDFHMklKTXE4RHpEQjVFWWNL?=
 =?utf-8?B?N3lYSVBmTjZaUTVWTzNGUWZtQ0Qvbkd2Z1ppYmxzYnRCTll4cmE4aVhhOUdo?=
 =?utf-8?B?alRnTHE4bGV2UWREeXd1ZXh0R3BCb2RJVVV1K3NSdXRnbDhoR0ZxRHJnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUgvNjIyZHQ5dHYraUJiY3B4Q0YvMzNxbFNGM3pVb2h0a3hPL2xPWU55ZHdD?=
 =?utf-8?B?Qy9XRDZXYjAzK21xRTFjYlNTWUxuWTNKVnp3Y2JsZTg1NU5IaTdyZmdKa053?=
 =?utf-8?B?QmYvSU1qSTJPK3cwTWFFR0Mzc0dZbW9GRTdHa0hXaVppSTJic0t0c05qMXkz?=
 =?utf-8?B?ZERYYzY4eXYwQ3c2QlVlV2MyMXJscUp5VGpsNXVwY3FPZ2VtYlVoQWs0elY3?=
 =?utf-8?B?bUFmOUVKQngvVTFBcHJjU0JHRW82S2Q1QlVtbER5azVUZWY3T1VacUI0ZmtI?=
 =?utf-8?B?TmE4RGFNZFpjdjk1cXlLdjJOVDdVczN4UEpxTlFVU2x5S2U3SFduM1dMTTBz?=
 =?utf-8?B?WVhVc003NWlyK2g0aXl5ejZ2UEVnZks4bEp1ZHlCcE9NclZMMW9NWXpoTVBn?=
 =?utf-8?B?VGlxYW04V2Q2SHpEK0lBb1MyZ0F4a3ZyeTVRUm5TNmo2a3lPVDVnaFNzL2Zk?=
 =?utf-8?B?MVh5UTl6N0Jtc2xyWVh6Z2tZN2ZBbUxDeTR3cGZ3aVBRTzIreFIxQjJ0TGtZ?=
 =?utf-8?B?VFVQeXIxU1ZSZ1ZwTXVMVnFVUzFkWlZ3TFlWeFNrbkc1RVI5dWQ5T1p3LzNw?=
 =?utf-8?B?bmYzbGtvNVFRVnVlc0JJc2paMVJxMVRuNWJ2eGZHbGZrTnUxUGhsSnVGM3l5?=
 =?utf-8?B?YnNLWU9FTzduWThwVTBaU3lTL1VGcWFLdElvUWhnS0ZMVHZ0ZXVuejNYenRU?=
 =?utf-8?B?VEtMZjRUOUQvS2hyTVdoNzgyQ3pNb1NYTXROSmp4NlJ3NE4zUnJPak5TOSsx?=
 =?utf-8?B?VnUxcXRmUXkySE1mQ0xpeFJpQVBOZWF2M1FuQnZqZlQzZWZSTEJKdE5CUlNJ?=
 =?utf-8?B?Y1FKQ2J1YWpBcFVnZS83NDFhRUVkVjgreHlPVU9JTXFvaFNxNEUreFZrZ0sy?=
 =?utf-8?B?ZTAxS2p5TmZ4NURKbHQ5RFh4VW1EWDZ4ZGtjM1JpbThjOWMzclhSc3MrZlB1?=
 =?utf-8?B?SWlFYmlZMEtPT1hGaGdwbW5xWFhPWW5CNWZNZGFGdG9FZlJrNDhJNUhLREhl?=
 =?utf-8?B?OWJ1K0ZsZW1DMWVDd3UrZ21zclNDeHJVN3F0Wi9TN3hvK1hyUERNVTFUa3hG?=
 =?utf-8?B?SGdzVisrTHJrZTRQYlZsR2UzeGVCY2xQUlBWQjlpcmNLZ3ZhNXBETzgySlBo?=
 =?utf-8?B?eUhGS2lJcGpqelpiYjFCc2Y4TU5uZzdLMEN5dG9jempua3Bza0hsOHhpZ2RB?=
 =?utf-8?B?dGw0VndUekxNSDlwelJmTk55Z3o3K0VzTElaRTRrbDgvTi8rQ2FEQXVuRHhP?=
 =?utf-8?B?d1pxNkp4TXV5ZFBtTVcwWHRwSWtFY1NWcnQyMFZyRGJWa0lXT1ZYY3JFTDM2?=
 =?utf-8?B?R2hjeWFCbSs2bUtvazFCK3hUWVVzR0JheGJSaXNhMXFnenhoRk40R0FpREN1?=
 =?utf-8?B?V0RyZUdBUXIyV0JLc05mSTJWNzNlUElHYTh6cThQQldOZXd1SUtPTWlBLytN?=
 =?utf-8?B?NDFvQ0VQYXU0bHpmQWhPbUxkWUR6STE5bWNjRm4zekkyR0RyR1JYYVlleWRB?=
 =?utf-8?B?Ti9Dck9GT1VrQXU0VGo0by9ZMVhleUk2em83djQwUUpFZmhhMkJreVowbDJK?=
 =?utf-8?B?YjdMVnlFRHQ1S0VFTWR0Zms2OXV2MWt1RXRCUVdKbXBDd0hlcm9Lak1ocnli?=
 =?utf-8?B?b29LOVZ0SVZPSlRmT0IyMjRtd3hycU9yYm5xK1d5Wm05anZvOTNURnAyaVB2?=
 =?utf-8?B?azczRUtPMDl5L3B5SFJ0b2ExeENycDN4WTB4eDAzbytJdjhDSS9TUWhQT0x4?=
 =?utf-8?B?K0Y0SWhZSTZ3WjBtbzRiOVdWbE5xQ29nL2ROZXZ3RlIwclN2eWZPbmI4K3hi?=
 =?utf-8?B?RUpTRENOM2NjRGdPbXkyZXBLWlVFQktlcXYzY1BWT09wK3pPSGl6aExadUEw?=
 =?utf-8?B?YnpITEJoZi9tMGdkYjkzcHdENDJDSFJ6MXJPT3J2bVZWNVY3NjJMbzg1Wllk?=
 =?utf-8?B?SmU5RVdZSzZFWnJMdVgxZCswMHFlUXR0MW5zMDltSDdTU0piVTZPR0QrU2FG?=
 =?utf-8?B?dWhmN2ZvMFE4SktvN2hFMTYwTkdCV0xGRlpKYzhlNXBIT1JUK0Y0UGoyM3Nk?=
 =?utf-8?B?VnMrQXkvdFplWCtIVFJ2UE9xSHJWUzgyY2UyMnZJeklVZjZ5cXkxTVdPRmpy?=
 =?utf-8?B?Q3VXcTBDT2gyT3dUVGk3S3VqVUlxSGo4bGgxd29FaE43WThKeFFFNmJGbHhB?=
 =?utf-8?B?TlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D8F6BB86AEBE64980297D698873E538@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49aa148-3589-4f91-5969-08dc837b703f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 03:15:36.6951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dKQek5LzHq0F0HdJ90eyie8wLC4ZWf7cNFGuiaFl0QkxqegKZzVhgrRYWWBZRLLBb/pRY0CdfzPZXxF8tbY5k7iE4JZ0EIiLaDJglYTP1mM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6664
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--23.095000-8.000000
X-TMASE-MatchedRID: 6E41RGmUyPrUL3YCMmnG4qfOxh7hvX71PbKer+BoZT9SHuP4uj8E9MkU
	hKWc+gwPyGJ1SiZNgOOsXAiB6VK48AbbLE2rYg/9wvqOGBrge3shmbYg1ZcOnr84twmKEd99h7Y
	HWQOgdatTJAVIzm0QDfuOXQK6723esEBAuoaUqK8VglQa/gMvfJnaxzJFBx6vgrAXgr/AjP0rjL
	21lsVzzmQpRnC/bR8n2Ve+TyBQvVNdInhzedP5B0K9qlwiTElfcuFRT+prg4Z2uoAH5rXwwpsnG
	P/L/vukwaEJiZ/MeXjhO0aDgiTHpabzNnoSkjMBOcjnbzvq8999LQinZ4QefKU8D0b0qFy9suf7
	RWbvUtyrusVRy4an8bxAi7jPoeEQftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.095000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	EDF9CB44174B8077995C3698339ED70F01AF69B416F495F365998E38F422884A2000:8

T24gVGh1LCAyMDI0LTA1LTMwIGF0IDE3OjEwICswMTAwLCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkg
d3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2Vu
ZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gVGh1LCBNYXkgMzAsIDIwMjQgYXQgMDQ6MDE6MDhQ
TSArMDAwMCwgU2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKSB3cm90ZToNCj4gPiBJJ20gbm90IGdv
aW5nIHRvIGhhbmRsZSB0aW1lb3V0IGNhc2UgaGVyZS4gSWYgd2UgY2FuJ3QgZGV0ZWN0DQo+ID4g
TVRLX1BIWV9GSU5BTF9TUEVFRF8xMDAwIGluIDEgc2Vjb25kLCBsZXQgaXQgZ28gYW5kIHdlJ2xs
IGRldGVjdCBpdA0KPiA+IG5leHQgcm91bmQuDQo+IA0KPiBXaXRoIHRoaXMgd2FpdGluZyB1cCB0
byBvbmUgc2Vjb25kIGZvciBNVEtfUEhZX0ZJTkFMX1NQRUVEXzEwMDAgdG8gYmUNCj4gc2V0Li4u
DQo+IA0KPiA+ID4gPiAraW50IG10a19ncGh5X2NsMjJfcmVhZF9zdGF0dXMoc3RydWN0IHBoeV9k
ZXZpY2UgKnBoeWRldikNCj4gPiA+ID4gK3sNCj4gPiA+ID4gK2ludCByZXQ7DQo+ID4gPiA+ICsN
Cj4gPiA+ID4gK3JldCA9IGdlbnBoeV9yZWFkX3N0YXR1cyhwaHlkZXYpOw0KPiA+ID4gPiAraWYg
KHJldCkNCj4gPiA+ID4gK3JldHVybiByZXQ7DQo+ID4gPiA+ICsNCj4gPiA+ID4gK2lmIChwaHlk
ZXYtPmF1dG9uZWcgPT0gQVVUT05FR19FTkFCTEUgJiYgIXBoeWRldi0NCj4gPiA+ID5hdXRvbmVn
X2NvbXBsZXRlKSB7DQo+IA0KPiBBcmUgeW91IHN1cmUgeW91IHdhbnQgdGhpcyBjb25kaXRpb24g
bGlrZSB0aGlzPyBXaGVuIHRoZSBsaW5rIGlzDQo+IGRvd24sDQo+IGFuZCAxRyBzcGVlZHMgYXJl
IGJlaW5nIGFkdmVydGlzZWQsIGl0IG1lYW5zIHRoYXQgeW91J2xsIGNhbGwNCj4gZXh0ZW5kX2Fu
X25ld19scF9jbnRfbGltaXQoKS4gSWYgTVRLX1BIWV9GSU5BTF9TUEVFRF8xMDAwIGRvZXNuJ3Qg
Z2V0DQo+IHNldCwgdGhhdCdsbCB0YWtlIG9uZSBzZWNvbmQgZWFjaCBhbmQgZXZlcnkgdGltZSB3
ZSBwb2xsIHRoZSBQSFkgZm9yDQo+IGl0cyBzdGF0dXMgLSB3aGljaCB3aWxsIGJlIGRvbmUgd2hp
bGUgaG9sZGluZyBwaHlkZXYtPmxvY2suDQo+IA0KPiBUaGlzIGRvZXNuJ3Qgc291bmQgdmVyeSBn
b29kLg0KPiANCj4gLS0gDQo+IFJNSydzIFBhdGNoIHN5c3RlbTogaHR0cHM6Ly93d3cuYXJtbGlu
dXgub3JnLnVrL2RldmVsb3Blci9wYXRjaGVzLw0KPiBGVFRQIGlzIGhlcmUhIDgwTWJwcyBkb3du
IDEwTWJwcyB1cC4gRGVjZW50IGNvbm5lY3Rpdml0eSBhdCBsYXN0IQ0KDQpJIGFkZCBhbm90aGVy
IGNvbmRpdGlvbiB0byBtYWtlIHN1cmUgd2UgZW50ZXINCmV4dGVuZF9hbl9uZXdfbHBfY250X2xp
bWl0KCkgb25seSBpbiBmaXJzdCBmZXcgc2Vjb25kcyB3aGVuIHdlIHBsdWcgaW4NCmNhYmxlLg0K
DQpJdCB3aWxsIGxvb2sgbGlrZSB0aGlzOg0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQojZGVmaW5lIE1US19QSFlfQVVYX0NU
UkxfQU5EX1NUQVRVUwkJMHgxNA0KI2RlZmluZSAgIE1US19QSFlfTFBfREVURUNURURfTUFTSwkJ
R0VOTUFTSyg3LCA2KQ0KDQppZiAocGh5ZGV2LT5hdXRvbmVnID09IEFVVE9ORUdfRU5BQkxFICYm
ICFwaHlkZXYtPmF1dG9uZWdfY29tcGxldGUpIHsNCglwaHlfc2VsZWN0X3BhZ2UocGh5ZGV2LCBN
VEtfUEhZX1BBR0VfRVhURU5ERURfMSk7DQoJcmV0ID0gX19waHlfcmVhZChwaHlkZXYsIE1US19Q
SFlfQVVYX0NUUkxfQU5EX1NUQVRVUyk7DQoJcGh5X3Jlc3RvcmVfcGFnZShwaHlkZXYsIE1US19Q
SFlfUEFHRV9TVEFOREFSRCwgMCk7DQoNCi8qIE9uY2UgTFBfREVURUNURUQgaXMgc2V0LCBpdCBt
ZWFucyB0aGF0ImFiaWxpdHlfbWF0Y2giIGluIElFRUUgODAyLjMNCiAqIEZpZ3VyZSAyOC0xOCBp
cyBzZXQuIFRoaXMgaGFwcGVucyBhZnRlciB3ZSBwbHVnIGluIGNhYmxlLiBBbHNvLA0KTFBfREVU
RUNURUQNCiAqIHdpbGwgYmUgY2xlYXJlZCBhZnRlciBBTiBjb21wbGV0ZS4NCiAqLw0KCWlmICgh
RklFTERfR0VUKE1US19QSFlfTFBfREVURUNURURfTUFTSywgcmV0KSkNCgkJcmV0dXJuIDA7DQoN
CglyZXQgPSBwaHlfcmVhZChwaHlkZXYsIE1JSV9DVFJMMTAwMCk7DQoJaWYgKHJldCAmIChBRFZF
UlRJU0VfMTAwMEZVTEwgfCBBRFZFUlRJU0VfMTAwMEhBTEYpKSB7DQoJCXJldCA9IGV4dGVuZF9h
bl9uZXdfbHBfY250X2xpbWl0KHBoeWRldik7DQoJCWlmIChyZXQgPCAwKQ0KCQkJcmV0dXJuIHJl
dDsNCgl9DQp9DQoNCnJldHVybiAwOw0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpUaGlzIGlzIHRlc3RlZCBPSyBvbiBteSBt
dDc5ODggcGxhdGZvcm0uDQoNClNreQ0K

