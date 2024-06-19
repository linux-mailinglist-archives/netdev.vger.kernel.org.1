Return-Path: <netdev+bounces-104798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B298F90E6A0
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 11:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E36B281793
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 09:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998CC7F498;
	Wed, 19 Jun 2024 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Tlp2IR8r";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="h2GJj+7d"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2157C082;
	Wed, 19 Jun 2024 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788505; cv=fail; b=JOx1KcV0YldptrqYY0Oq8cvKB2yONRRJa/OH3oysl3EZuqgHdFA0HhpgrRA9H7L4fhgNHoAaYOJtRR4yFqYm73gEJlXgMDs9napcx/mgxPbu6CHYueXPX433qf1XhoaiOsG2gGEQevMozF5iHSp+2aXdFadycrI+0Op1UVgU980=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788505; c=relaxed/simple;
	bh=Iwd9tG47tYmZxeCUONYNlYNda/j0EagF3ptpvMUKlZU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b1qZDLC7ipcOFaPE8MysI36pN1Y79TQH9bssOudjHrgoMQHUFm6wSfbojk98O1HweFrco4nNhDuIwqpspu9fIBOKH+5gTMEZ7Q4nJaw95JOjpOXRGLIxL9K3h8wH4iHpa2bZx1YDu9Rf/aePeo6Oo7tzDtrBLV1S5pkc2HU1dE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Tlp2IR8r; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=h2GJj+7d; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 647ee9d42e1c11efa54bbfbb386b949c-20240619
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Iwd9tG47tYmZxeCUONYNlYNda/j0EagF3ptpvMUKlZU=;
	b=Tlp2IR8rp61/UlzCDsHlUq46loXGCyk6gIG1q38kumXr5ab4OeU4n4NrxILBHntJIi4M5JXOoRSCVwksfo1ksXt/hEjyAZZuEZMsPYucPL1Fya0HoOOcS8H9QaShCMGbUpR5bLN7kC7DU8Iqm92yPD3Xf8N0Xckd+qxBCC9yr/k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:ceb3570f-67b4-402a-b780-7437a3a62dc3,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:393d96e,CLOUDID:67712d94-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 647ee9d42e1c11efa54bbfbb386b949c-20240619
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 993716753; Wed, 19 Jun 2024 17:14:55 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 19 Jun 2024 02:14:53 -0700
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 19 Jun 2024 17:14:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtlHFnNY2EfH7HZhpKaA1COHfZHs0L0o80RSgcFG2P8PDzG/kwivuTRhYbpf3LZ+eUwJy0e4+Cq1SvwVAJVVEAQ2xV4q+rOui3/W2sCXbsN9x7Mep6k5f2YGHuQgYtxuxYSKFsOfty46SFThx/ulz9NA7G9ofLTOnpQF3zxRydtk0CsiAryUEQtaNCKaxlxtAcQKxJ9vSXBpJoot1k8du9VKlcBcDIOoJByBAA0FdXjUxWJAnXT/bykSXxjq0ZMb3Ig25uZ9QauVGLrRzCn/idNvCY4kwBX02ooisABPfT+O6wXvotqNuRYsQqQ/yZGT+19vv0lBB4w8YYl6yWZJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iwd9tG47tYmZxeCUONYNlYNda/j0EagF3ptpvMUKlZU=;
 b=ml2mFN16zb+DQCsVv/2BDfK/8eRG3Ya9DDKkt9LxPLia7CI3tA6rncWyUx1fod3BkxcC+1aBV5aGehyxZlBJguv/Q5jdVqUb9t1y79LqUVVIvQzfa3zx0hN9AxTo53CPK/RXP3CArokASxP8RxfeskWiLkzz83QIJrzCQVlJGXKTy9D76wH8OBd+S9zUuGjTlKET4jFHukWYteyAHc0gjn0M/sv6zabpzsLA7cOHNOYb4C2esDZpH1uYFIt/slUZs2hvFYHGknyFu7h1tuAu2tVTLKca3h11oLrYMjb5lONpDYcInn3nBHr+QF+mFue7S/SvgscYv8e6fG3ekOM5hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iwd9tG47tYmZxeCUONYNlYNda/j0EagF3ptpvMUKlZU=;
 b=h2GJj+7d7NmMqrxXVUSMAQjt9n3y2Kdsm5ff9Qhdq7eTkgJ+fU6HKJPavqDD3uFWgKQvj4EkADEZffPPQMfJ8wvhMxWFmo+KmcRI+G0TKq17U/yZ2vjoopIKDNFm1mbnA4wfNYXaPgOistTWz2HpAFU6RMeikFtV29s1bW/610U=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by TYZPR03MB6790.apcprd03.prod.outlook.com (2603:1096:400:201::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 09:14:51 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 09:14:51 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next v7 1/5] net: phy: mediatek: Re-organize MediaTek
 ethernet phy drivers
Thread-Topic: [PATCH net-next v7 1/5] net: phy: mediatek: Re-organize MediaTek
 ethernet phy drivers
Thread-Index: AQHavX5bSPDV//9KbUadMzR6v9edj7HOy0KAgAAMBoA=
Date: Wed, 19 Jun 2024 09:14:51 +0000
Message-ID: <5b1e6623678f04672ec316d9ca36e54b27d1ba6a.camel@mediatek.com>
References: <20240613104023.13044-1-SkyLake.Huang@mediatek.com>
	 <20240613104023.13044-2-SkyLake.Huang@mediatek.com>
	 <ZnKXc/UglBxayJtv@shell.armlinux.org.uk>
In-Reply-To: <ZnKXc/UglBxayJtv@shell.armlinux.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|TYZPR03MB6790:EE_
x-ms-office365-filtering-correlation-id: 544dde1b-3120-452f-5f7b-08dc9040465a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|7416011|1800799021|376011|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?UkxOcnNaSWVzbzBvc3dveE9ESXlaU25yak9MOTY0Z1pNWUI5U0lHNUdGVjI5?=
 =?utf-8?B?QWk1MDF1OU5lR1g2VTFxTEM2QXdBc1d1WmU0S2duRlFEZXhUaTBrUXdiUGpQ?=
 =?utf-8?B?SlpJTkliSk41UGZqaWR6VWlrS0xXVFY0SDZ2RG1KZ3hkSW5GYVRJVXJUWG5V?=
 =?utf-8?B?ZW9lWFlYTVIwcytvRlNTK2NmR2MvWmh4WnNvYmZZbVZUMStXN0ZuZnVmWlpI?=
 =?utf-8?B?SFp0QmIvUXRjaEhOdWNlSEFDbjFYZGpqa1MyQkwzaVZMN2syWWhnRkg2UlZD?=
 =?utf-8?B?RG14aWlaY0dacEp3V3JVaGxWamVHdjZxWEd2V3QwdFRScHBsMDZOVEZ6Y0N5?=
 =?utf-8?B?dVJyWWJtYjl0a0IvMHViaDNIaU1kTi9pN25sSTl2NGJ6YkpHOG16dDVYUjFW?=
 =?utf-8?B?eXpKRXduSUlRTkIrYk42RmNHdkl3NlJRKytXckxoaDgvWUNiMjBKSWQwcGg2?=
 =?utf-8?B?RGNMNlV5WWtTczQzbnJrZ1dBbGIvcFJjalNFa1BwTkpJQVZ1eFllWFNnR0Vs?=
 =?utf-8?B?bnVGL3lSUEVkU29zWDdwZndJQ0thMFBNenA1c0Z0NktVOWoyNm94V1BiUnJy?=
 =?utf-8?B?bDJWbzVJc2FUSWZRSE1ocG1ZUUZWVmlMakJWMi9pSGs4ampuZXBqWnRxRVVo?=
 =?utf-8?B?NnNIaTB2MnZKS2tmNGduTDZOVFJuNzlXSEMrYUxEYVlHa0UwdmlFN0ExTW5s?=
 =?utf-8?B?bW41bnk0cDQ1eXQwSHFrRnZKOXpzMmJBbTdvRy9scFYraHU4K2FJL2MxKzZ6?=
 =?utf-8?B?ZFoydXc5QytuS0FWZHpleHp2aWkwbGhOaTdYNTlUSHEwUE0xeDJXdUY1QU1W?=
 =?utf-8?B?aUtIMGROVFVPc09wM0VlTDhrOHczdHV6OW13b2JuVjFSQ21QTFh6T2pZZExO?=
 =?utf-8?B?WlMxK0VJK28rVi9NVkk4c3F1STJIUk9aMitnMVd5ZXRnRmJjNWhOOXI4ZlZQ?=
 =?utf-8?B?Um9UV3NhNXR4YThMclYxeTdxN1NQaWp0ZGwxd091TktRSElpZEwyWjdmalE5?=
 =?utf-8?B?R2huWUlIUHlOWnBXRjFGdTVVaXA0eVcvbVRBUTJEbitpdkMwMVBVcXBiK3BF?=
 =?utf-8?B?MnNySFA1VjlaM2lGNkRGNmhGVDF6ZFZJT2dkUzh3eXBLVS9TUFI0c0JqRjJl?=
 =?utf-8?B?VHlCTUM3dkVBV3c0N3RJTytZOXVMYnVFUEJNa2srY1p0NnFJU3Vadk1zNkxv?=
 =?utf-8?B?OXlmU3NGRWorczkyaWdJcng4QW5ZS3lxL2hMekx0bzJNaU9zUXhLUzE5OWd4?=
 =?utf-8?B?NDl5NkkxRi9PY2lQVndWMk8wWWVpQkxqUmxrdERLUGpxdlc1bnlnS0J0aUJa?=
 =?utf-8?B?L0ZBMlJ1T3ozSjNGL0k3RU92RDgwNnBDenRwQUVTMGRZY2txaFFGeU92a0Zv?=
 =?utf-8?B?YVU3K0kxbFV2S05SNmVxdVZiT1RUZEh0b1ViSHR1MXFadUcvakc3Qk40bStr?=
 =?utf-8?B?cktJb0NxK2FXT3ZYK0E2ZXhJTFVMaDJXNGtZMTZKTHBEK1Q4R2kxSW1tQkZB?=
 =?utf-8?B?alk4VnpPTlArTjJ2OWo0Rld3QjZaNmlaS2ZYcU8rUHlSZGtsa2l3SDJlOWIy?=
 =?utf-8?B?ckZTaHB3Q2dQR3dHWFpydkdVSExBY1FxcUYxVERsMnRPTUlVd3QrRUdaWkVi?=
 =?utf-8?B?VFRXYW14NHh5RjBDWUsrbmNnQjUxRUZ3SWRLUmp0MzF5RmNURUhhOHU3ejAv?=
 =?utf-8?B?VXJqZ2xrWlNyU3g3ZUlzaXFIelFLcitQTXdhb1VDSXFseUY1L0tGS1pJRkhW?=
 =?utf-8?Q?D/27mL3QID/fIfAVloK3MCDHPbdRtZLkNiYh2qK?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUNiQkxHaFkxaDFpVzVGMjBlZlFyTktLQXBPS25GWXV1Z0hpZXdFYTdEUmlx?=
 =?utf-8?B?RDZSUjV1eUs4a20wWEVhMXNXTXVrWGlsVE1wVUFJL1BBWjMxZHZ1NU9jWi9y?=
 =?utf-8?B?U2hMaTJzSkM0ZHIvSThRamJzSDBsOWhIZlJDNVkyb25MejVFUTdMa2NsdDhl?=
 =?utf-8?B?YXY1ZUxsZXhaRjFuempCck1jSi9BNFducEoxeWMzaGNQUzJQMjhqZENMeVNQ?=
 =?utf-8?B?aEdLalhyb05FTlhsQUprandSTXhzcHM5SXgwK0h1dko0d1hVaTRHMTQxTnEx?=
 =?utf-8?B?bHo4VjJnTHMwY1E4cFRuYnQwcU9lM3ZCMUxYdG1ZQkpyZ29YQy9JVDhKbVFC?=
 =?utf-8?B?SWtkczZuRUJadlhEQ3ZERVBmYXJ5MWpIazZBakIzU2VCZWxEd3ErcFRHR0k2?=
 =?utf-8?B?RzdmODNkK2cwa2QwRFl2Ums3NGFGZXRtMEo1Z21rRDdqN2d3TWhKY05zS2RH?=
 =?utf-8?B?TjVZOXNmUWZiYXlvYWg2eUc1OGNmZEYzOGtPSklZYk4yMHFSdWZqcWJHVEs2?=
 =?utf-8?B?SHVleE0yQmFXMkdWODVjNnJRVGxERWswNFRRZnlEN1pHWlovaGJDUmlnN0dN?=
 =?utf-8?B?bm9KakxBVlVGTnJDYzVWeElydjYyUmY5dmJMcUxEamR1eHNHbWd6S0YyNjd2?=
 =?utf-8?B?WmFKWkp6d2xyZmdNT0FkbHZFWWxoRXBaeEFseE54V2dwZDlpUTdzbzh0RkFq?=
 =?utf-8?B?cHJuUytpbHZHSHgzSWtoOFk0SGd6VVBqQjJUV3BZTDhEaEVIS2EwT1FHZ2Yx?=
 =?utf-8?B?bUtmNUhkNTRRNDdneGFaaEwxZytScVorTVhqdW5OM3Bwa25UVWcvOXhSS2lt?=
 =?utf-8?B?WThRdWd2blJBNXBPVHJBT1RicWN0NEt6ZXV5YjRSWjdicHhQNXY0eDAwQWcy?=
 =?utf-8?B?UDZoR3lvUlQ3cFBEelpjcEFHbWNWTlg4NU01alB5OElKdGJhSWdDQVFxTU9Q?=
 =?utf-8?B?ZGlOYTRkNTVWc2ZucElkTzRpckJCQitLSVJQYTkzcTNyY2JTUWt1NFhzMHUy?=
 =?utf-8?B?Um5wQlFmL0MxQTAvVTVycFhJYnhXOFROL2F0cHhhcFU0OEFyVVREMUxQM3ho?=
 =?utf-8?B?dzJhaDBFb2hFQjVHM2VSNGRZdHhYSGFnVDNtMWJTQ1FZYUxUc2RpK2cwendM?=
 =?utf-8?B?Rk9PdGhRdDcrRzdvdmh0clFJQWV2ZWRORzJIMEZla1praE9BYXo1ZTRJd2Y2?=
 =?utf-8?B?Yk5XMjVjamZCQWorMlVyVWZxelkrT3lHK3dici8rOWZrR3VjNi9XTXZ5VUJB?=
 =?utf-8?B?eXdrWFQ2b1JQcW5sbkVOSnhISXd5YVdra1Y2b0kzKzVqZlZ0eVBGTHVUamVK?=
 =?utf-8?B?SnpxZHBVak1wSlVSTU8yaVRoMFRaQjJFVUk4dENXcW5hUHNqbTByc2lMVktR?=
 =?utf-8?B?ZmorNHJBSm1PNnpkcjhqeFVNUHNKczR4YW9yTmdGb3BuUGw0M0c1aFU1RnpN?=
 =?utf-8?B?cENmZUVaZ3JZRHhUU3lFVFdEdmoycTNESDN2bXRVTlNqUnJjWUFrejhEcGhj?=
 =?utf-8?B?WmZBUElVaStSTm9qa1hMY2NQUTlQbUpaWHdzdlJLTDl1OW5wSHM3UDgvWk9X?=
 =?utf-8?B?ZWEvVDkxOS9GQTNIYk5SU1N2ZHFvOGJHQ2JzSnd4RG5uSUp6cGg4d2tVRytV?=
 =?utf-8?B?SlRhNDdHVEhFY0lZMXJ5TmlrblBLRGhmWFRFemhQV2ZuK292ekdaZ1ltWjVO?=
 =?utf-8?B?dFNUYXZlNmNwNzQxZ1lwWFVMWmtMaUx3b1VNNUZnVmVxc2dTYTltbzhKU3NZ?=
 =?utf-8?B?eG5tYnNTcXN2QjdvUlNYcjk2QzlxQ0JDcWg3eFErZkdxOC9ud2lWdm1ZTXpS?=
 =?utf-8?B?NStpUTZjd09JaThGWU9aaC9nL004UGhZN1dEUk1Edy83aWVnMkxFZ3BLM1Fk?=
 =?utf-8?B?R1RhRU5qdGZPS0dwY29UYzZncmk1R1QyU0hIdi9TcTJ3L0RQL2tJUVA0NGZj?=
 =?utf-8?B?MUEyQVhsMEVPNlZiWjhaTFZVU2hGbUhIWVUxNHNUTXRlRUNNaWxybkV1TUlU?=
 =?utf-8?B?ejNQbW83VVpJMkVoQmR3TGhnbFdwSDdwK0xYS2RBTDY4WXpXRkVveWJGOC9k?=
 =?utf-8?B?cEg4S25lcmJ5MVA0eE9ERjFpVERDaEcyem0wMFFSK1VTOEZ4T242Q1k3Q0xy?=
 =?utf-8?B?LzQvQ29yVnAvNnlZZmJXVG1HdHk0NExTVFRKUkZUa0ZRMEx1OUREQktPbGNV?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83DE73A68ABDDC4C912B8E88B6FE5E57@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544dde1b-3120-452f-5f7b-08dc9040465a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 09:14:51.2306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HLRfCgkaE5d6hpcKRs77h05btX07mzawdFxG81TDWuONXa4Qk0qFgtyddWlSysLh9qPz5RascXN9P87py8fNTcSA57GR6psBy1hdC84TyZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6790

T24gV2VkLCAyMDI0LTA2LTE5IGF0IDA5OjMxICswMTAwLCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkg
d3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2Vu
ZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gVGh1LCBKdW4gMTMsIDIwMjQgYXQgMDY6NDA6MTlQ
TSArMDgwMCwgU2t5IEh1YW5nIHdyb3RlOg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9w
aHkvbWVkaWF0ZWstZ2Utc29jLmMNCj4gYi9kcml2ZXJzL25ldC9waHkvbWVkaWF0ZWsvbXRrLWdl
LXNvYy5jDQo+ID4gc2ltaWxhcml0eSBpbmRleCA5OSUNCj4gPiByZW5hbWUgZnJvbSBkcml2ZXJz
L25ldC9waHkvbWVkaWF0ZWstZ2Utc29jLmMNCj4gPiByZW5hbWUgdG8gZHJpdmVycy9uZXQvcGh5
L21lZGlhdGVrL210ay1nZS1zb2MuYw0KPiA+IGluZGV4IGY0Zjk0MTIuLjQ3YWY4NzIgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvcGh5L21lZGlhdGVrLWdlLXNvYy5jDQo+ID4gKysrIGIv
ZHJpdmVycy9uZXQvcGh5L21lZGlhdGVrL210ay1nZS1zb2MuYw0KPiA+IEBAIC0xNDE1LDcgKzE0
MTUsNyBAQCBzdGF0aWMgaW50IG10Nzk4OF9waHlfcHJvYmVfc2hhcmVkKHN0cnVjdA0KPiBwaHlf
ZGV2aWNlICpwaHlkZXYpDQo+ID4gICAqIExFRF9DIGFuZCBMRURfRCByZXNwZWN0aXZlbHkuIEF0
IHRoZSBzYW1lIHRpbWUgdGhvc2UgcGlucyBhcmUNCj4gdXNlZCB0bw0KPiA+ICAgKiBib290c3Ry
YXAgY29uZmlndXJhdGlvbiBvZiB0aGUgcmVmZXJlbmNlIGNsb2NrIHNvdXJjZSAoTEVEX0EpLA0K
PiA+ICAgKiBEUkFNIEREUngxNmIgeDIveDEgKExFRF9CKSBhbmQgYm9vdCBkZXZpY2UgKExFRF9D
LCBMRURfRCkuDQo+ID4gLSAqIEluIHByYWN0aXNlIHRoaXMgaXMgZG9uZSB1c2luZyBhIExFRCBh
bmQgYSByZXNpc3RvciBwdWxsaW5nIHRoZQ0KPiBwaW4NCj4gPiArICogSW4gcHJhY3RpY2UgdGhp
cyBpcyBkb25lIHVzaW5nIGEgTEVEIGFuZCBhIHJlc2lzdG9yIHB1bGxpbmcgdGhlDQo+IHBpbg0K
PiANCj4gSWYgeW91IGFyZSBtb3ZpbmcgZmlsZXMgYXJvdW5kLCB0aGVyZSBzaG91bGQgYmUgbm8g
ZXh0cmFuZW91cyBjaGFuZ2VzDQo+IGluIHRoZSBjb21taXQgdGhhdCBpcyBkb2luZyB0aGUgbW92
ZS4gVGhpcyBpcyBhIHNwZWxsaW5nIGZpeCwgYW5kDQo+IHRoYXQNCj4gc2hvdWxkIGJlIGEgc2Vw
YXJhdGUgcGF0Y2ggKGFuZCBwcm9iYWJseSBzaG91bGQgYmUgZG9uZSBhcyB0aGUgZmlyc3QNCj4g
cGF0Y2guKQ0KPiANCj4gVGhhbmtzLg0KPiANCj4gLS0gDQo+IFJNSydzIFBhdGNoIHN5c3RlbTog
aHR0cHM6Ly93d3cuYXJtbGludXgub3JnLnVrL2RldmVsb3Blci9wYXRjaGVzLw0KPiBGVFRQIGlz
IGhlcmUhIDgwTWJwcyBkb3duIDEwTWJwcyB1cC4gRGVjZW50IGNvbm5lY3Rpdml0eSBhdCBsYXN0
IQ0KDQpJJ2xsIGNyZWF0ZSBhbm90aGVyIHBhdGNoIGluIG5leHQgdmVyc2lvbi4gVGhhbmtzLg0K
DQpCUnMsDQpTa3kNCg==

