Return-Path: <netdev+bounces-104821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1DF90E872
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4082B23158
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 10:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00237132115;
	Wed, 19 Jun 2024 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LDObccKK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="MM+ICy/K"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DCF12D758;
	Wed, 19 Jun 2024 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718793480; cv=fail; b=BVQlhUmY8cMJrXrRZImKdQUzqolZlcBCUC8UG8CTqk8co8CUVJLlTUEFxG70QO0CIkoXmUYRTeXfG65OzxMlj8saugZHoIu74QMvuhOIIK3Sf0nHANbJnqMum99Ve61TRe9ce2RrJ8eiKZyI7ciTcLZ+2lKvetteSj95Kkd7Pkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718793480; c=relaxed/simple;
	bh=2IJfa1/56Eq9btZ7tDHyOki6BNEbZdgaa9U3MowBpEc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZaRsRe/gYn/fXVFkA8ZiMq+VeBgqXIEddzoA/uwjM499SDO8zEwuPchRQU2ucb5NMBa4att49P6Mlj8Q5qmA9UsX0zXB1mEOpHpqUAvWlm4EoZdlgNep8H5YoHAoTZ5wtbhY5z+iUTbl0Ol/CODKzQrLzG0moUPMxmxk7ZjXYnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LDObccKK; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=MM+ICy/K; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f74302d62e2711efa22eafcdcd04c131-20240619
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=2IJfa1/56Eq9btZ7tDHyOki6BNEbZdgaa9U3MowBpEc=;
	b=LDObccKKb+i+7R7A80GQ8kw4rIrCEjJzUP3+MIrp2dBN9XdEbPcFAiZB95PqqsTpb28SN59hjLrqBrJItQJJ9Fpev3360xP6jV8kv+SLMzR42v4XuM/0kOMXJ5uPwRTynnnnpUU062AERPcXxztexY8AF7ZvMKgLtev2CisQB1E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:0e167666-87f5-4c37-86f2-f796744d3746,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:7c4cc788-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f74302d62e2711efa22eafcdcd04c131-20240619
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 584164972; Wed, 19 Jun 2024 18:37:45 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 19 Jun 2024 18:37:43 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 19 Jun 2024 18:37:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcRkfrND7xtfkIVVHiyvXJZRlzB97JZKiiWsY3Ql1THNORsKx98RJF80OmfTGquPNwaMjPP5YyVTPFWIKjrIyMGHIzjrT71/VcFTt+1ceY+n41lCiCFc3KA4nUxsWgkuO8EjuSXufkt4glzQA3IrwRRdbOoV4QVRZWrb5+iCekO+SzPTTKcLpy5kIvtfZVZWyT5ajWJ+EgKix6UCKqkYC5Do4iRZrIHJnDzMbfkhBX9BqpqGZNaXxzGZl6fIqDAcMRQuZgdhuOrYM2cO0j5lkuHVinIMzi1CMJW3W3UY8NxPEQfp4gT2mlM4NLVUWjbfRTZnYjtlcpXhsZ01OZ4yuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IJfa1/56Eq9btZ7tDHyOki6BNEbZdgaa9U3MowBpEc=;
 b=TQJ8rpAwIuCLcg9n/l3TTukFqjWQwjfGb83JDklUgTBQcbbPtA4YAh4MaFo4Cfoq/FulC5KGJysY/nES37IdLNrjcKzD43MneV66LqGipqCf/0OFJ0e0oavvlhpQHYYAglqmnXqhTLrzA7EIUVrU5zy+NLTCON+VMIYFTAqf51rZtRJwoEAGm385B5Br3onKpn3NSlg/4beRFcU77SXehCvpuysHpeppKTZ3W2VePGJkKtpndKy+USqHApfJ579ZYcjAVVtOZCOw+49mx9XrMNfa2/4XACcyyNFCPwfSn1fS8iebsfFU6D4dTHjcd//ycdziQJXr9awSO4oyD445jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IJfa1/56Eq9btZ7tDHyOki6BNEbZdgaa9U3MowBpEc=;
 b=MM+ICy/KU5PYZkDnU2k9Iu46lUrIVfHanpdT8UYCgF5R29e8Mk2XDd70DLbwfMKb1NS7uYlrYrqJso0jYJoZGUr6QERy0UCuQqUjofmBdLsEyPanoDjXjUEXvkjx66K2rCpkoOtIxkTD+Rrxu6JTu9DSbtay6sdg0Zitki6PY2M=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by KL1PR03MB7257.apcprd03.prod.outlook.com (2603:1096:820:bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 10:37:42 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 10:37:41 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next v7 2/5] net: phy: mediatek: Move LED and
 read/write page helper functions into mtk phy lib
Thread-Topic: [PATCH net-next v7 2/5] net: phy: mediatek: Move LED and
 read/write page helper functions into mtk phy lib
Thread-Index: AQHavX543grjkC4X80W7mzpSDXaiMLHNq0+AgAEcEgCAACcKAA==
Date: Wed, 19 Jun 2024 10:37:41 +0000
Message-ID: <362fdc698ce87ea2a19f38a65a000cb37272f8bb.camel@mediatek.com>
References: <20240613104023.13044-1-SkyLake.Huang@mediatek.com>
	 <20240613104023.13044-3-SkyLake.Huang@mediatek.com>
	 <20240618082111.27d386b6@kernel.org>
	 <680c25911c9a564960a371870bdaf59aa9d3b991.camel@mediatek.com>
In-Reply-To: <680c25911c9a564960a371870bdaf59aa9d3b991.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|KL1PR03MB7257:EE_
x-ms-office365-filtering-correlation-id: 447c4048-cf19-4471-516f-08dc904bd8d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|7416011|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?ZjM0RDI5Vzd1K1NzYkRtaGNiRXpCcnRRWVVncWpuN1EwMkQzVjNxQ2J4aGY3?=
 =?utf-8?B?ZENCdmwwamxGeGhhTnAvc0xBcWlacFd3bFVha1Z3VG5SbnAxOTFiS0xxRUth?=
 =?utf-8?B?ekNDUjFERVhRVU81NjRKcU13NDMyaTRvR1p5Wm9vOVc5YTg4eFJ2MkY5VmE2?=
 =?utf-8?B?K3RsMEFYVXY1UFI2eTFkeDV0SFd2VkFleXEvNU1SNUErTkptSDgxN1BjYTNa?=
 =?utf-8?B?aERkYXpEYW9wM0g4L0l5dVp1K1hZak5Ba2FJU0xZZ0dVYWpDT1h3QjBkOXht?=
 =?utf-8?B?VG9HSHVBYXZkM3VBL2d5YnZqU2poc3Q4cFk5R2VRT2E5YTRQVEQxa1hoUS9i?=
 =?utf-8?B?b2lIM2RwSXFJT3EvSWFVT1VMUWUrRXBMMnVnMHc1U0NsRzlncG95STB2anRD?=
 =?utf-8?B?M2lzQ00xeVBQT2VBUitraUNRWjFDVjlpOHZUakIzMmhKb1NpNDEvcUsyWExa?=
 =?utf-8?B?enFjaFExRHdsdmJkOXkzci9rY3VzYzdiUW1nQlk1NW5BUGRTcVJzVjdwWnNQ?=
 =?utf-8?B?ZDhOQ0xHVzBGZG9DVE1ON2dpVzJBcExzaU90WW1Od1dXQ3c0Nml0NWtXQkV6?=
 =?utf-8?B?bzlmU1dqV3BNYmpBRnlVSTNLWEN2dHBlNjh0RUJ1bXlHSnhFdllGNWU2SGox?=
 =?utf-8?B?TE5LRURDT2JCNWF3VWhKUVliVnppZUZ3cWJ4ZEVNNWRJS0JTciszTHdhc3Ro?=
 =?utf-8?B?bUY4N080NDluTDhLM0NoZ25rcU1oVkQvNUJvRHJqbm1rMlg3RzZIbUZ3bHU0?=
 =?utf-8?B?TS9OS1d0ejRzMEJHaGhZSFF2WkJ4MXd0OVhjdXlEQWczOCtzVDN4MGpGRXV2?=
 =?utf-8?B?SjQvODVZbmZ3NUlZc3BmOXdOV0wwTEx2NHhXa0h5OElCKzlKRTNFaHkwY1pK?=
 =?utf-8?B?czg3MlJhTGUvMEQwR3Y1NmM0NkRaYmJVRERqT3NVQ1FvU092dzkrd3FxbVli?=
 =?utf-8?B?Q2tBbndTMExaejY4MWRjUWI2d3lTYmNYN05tMTRRdkJvc1JBTUF6amorM2U2?=
 =?utf-8?B?QzY2NXBUR3BrSm0rZVBTUlNrWHhIL1M4L1NQc0ZjYm8yYXhvcGRpSUJRZ1U2?=
 =?utf-8?B?eEgrN21KWDRCUm02cHlDbEpRWU5jZUZqMDJxVkhjMnY0WllmZ3F6eitVT1FY?=
 =?utf-8?B?bkwzWUF3OUJQWHVJL2x5NEJEOGtwNHBDR2JKNUZBdnJXTU8va2NrN3VTNmVx?=
 =?utf-8?B?cWhzekZuRitUZUFReVVMcFF0ZEZNQk5qbHdmdjlrcjAyMVRWb3QzQXZxZ1Ns?=
 =?utf-8?B?d1Z5R2UrT0VieWZQdU8zRUQ3OTl3OU1TdVBiUlBjNkxFRXJjT1EwNm1XOHVi?=
 =?utf-8?B?czBGU1JFN09POGNTRFIyZkFaaFFNMXRTMU1tQ2psTG5RMXI0TjQvQkpCQlh3?=
 =?utf-8?B?dkdHQ2cyUXJkNGw3MmJxeUVEVzAvWFgwNXN0dWxrMXFUT0Z3NGhUUy9oTUw0?=
 =?utf-8?B?MGlaT243U3AvUjJYbCsvSVpVYk9GdFVtdVZIMGVKNjVYVnhiWVl4elhkOUxQ?=
 =?utf-8?B?VTNPL0lqc1o0bmFUcndGcU91QmtVZEgzSTd3SXZyUmxLc1FOV1ZpZm5NNDNF?=
 =?utf-8?B?bWRCRkNRdFM0dk9wR3g4cjB1MDUrdnlLV0tOcTdLVWhPOTZic01tMGZBZnE3?=
 =?utf-8?B?VjBSL09OZ3NWWUY5TUhCeUhPa1pXSHY3N1FTR213ZE04NXE4c1QybTRmdy9C?=
 =?utf-8?B?bVorc2lZWGF5MU9oUTBhdFU2cTBGMGlnRXhDSWRiVDdONWUzcEFKQkVHNnRz?=
 =?utf-8?B?ZStPcU91WlhUVGxuTE4ydUtid1ZpVDhJYmdBaW5PdHNDYTI3M0N3U0lXc3l4?=
 =?utf-8?Q?3rWcrTuCP7y/JI/F9qgHAwXsjQS65bmoaUaMg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVg5QTVRaDVwMmpIaTh6RHVkVGFyMzlCTi9ZbkNzQUh6UXY5bWU1dllTczlr?=
 =?utf-8?B?VTlRZmpUQ29yd01TMmJRRSswUWk0eEtqR1pYQnB0NWZFay9kWnl6d2RpREl0?=
 =?utf-8?B?aUVucEV1Ty90Q1F2cGY4TzJmbDhydUVodjJBVytoWlkvQ24xNEpmeW40UldU?=
 =?utf-8?B?OGVLNis5Yi8wR1Q0eWhDbElEcWozMTdZYTJEYlA1V1BRTUFCRG5Nc0k2Ujlo?=
 =?utf-8?B?bEpLZHBkaXVkdE1xTjFvYzdaNGkxbGtLa2NaWkxBWitiWjFlS1RlWXZHN0dO?=
 =?utf-8?B?Z0s4QUVJaktqdmVPU2JZZ1lkOHBnc2d5cjBxamxxekdBQi95VGNPbXpjcmRI?=
 =?utf-8?B?QUU4UUd5OTUwakx5amU1Tk9mZytiZXdCT21KcnZTdktCRGZ4OHBENURSdjVm?=
 =?utf-8?B?cHRnemVUc055NUJWL2FIYnRlZHVkdFJiS3NPbW42T2pHUXIxdkk5ZmFkejZG?=
 =?utf-8?B?aEM4Q0MyaU1kSmJ6ZlZDMXpkTHhnaEF0WEs0MTVvMk1ocUY1dW5MUzRWK2pM?=
 =?utf-8?B?bEhweGJWdk4rc2hncDFwM3VzWjBhclR4NmU2NFF1Z2svV05BUWtnSXVyZzdn?=
 =?utf-8?B?Ly90eG43OUo0eGtuMTZtdTZjdkhKUTY3cDkzbzkyMG5MUFZhb2h5V3AvYm1U?=
 =?utf-8?B?dG9BWXFIbElvRG5QNFEzYnFUYVBCbTVJWGJUanlNY0F6MjFKa0JyTGZLZ0JV?=
 =?utf-8?B?L29lenJqQi9OOVdyeWhNY1U2TG9PSjlPNno5RUlvUWliVVpyUDk0WGNRZjRu?=
 =?utf-8?B?ajR5YUlLcURwK0tRNmhhMnpJaUZmYkhabnlLMnRrVlRSbEl2dVUrTEdsdXFY?=
 =?utf-8?B?a0NHa2lEUHRMWjVxWmc1djJUMitVaDREUHJSNnZlbjRFeERlVEhsOFlSUWpu?=
 =?utf-8?B?YmprZWRxTDNSNHJxMjRUUGFtd21VUFpKeU1Udzc0SDFmYmZqb1g3SFNCV0U0?=
 =?utf-8?B?OEVUMWtTbmlPT29IZTd0NDFEUTJlc0oyeUlvcDRKVGIrZi92dm9CcHg1WFBX?=
 =?utf-8?B?MTRTcGJHMy9zaFRod1kvbGFGaG0wYURJa0pnT3Nxa3hod1lCN2luZ3F0TjMw?=
 =?utf-8?B?REgyVHV5SXJESU1ZNGFXMDkxaEZzczR4dHVtMEtwZkR4dkZKZzNMaUVWUzFH?=
 =?utf-8?B?UkMraERqVVBZZHVTOEFSODFxNEN6Q3V3OTJWWHRFRXdTMDRwQytMdlE1Yit2?=
 =?utf-8?B?RGppTjFQdlRGbWRvNExiSGR4T0xaZysxNUwrMyt1b00raTNBenlsT1diY2x1?=
 =?utf-8?B?UCswZVd0Mlh6R3RMWmp1QncwZVNLUm9wcUs5aUJ5ZjZVUWQ0ZnRVd0M2OXJx?=
 =?utf-8?B?b3Z3cE9aV0NMZHl1aExKSm9OYmZsTmxaL0Q0cnVmZjhLUFFjbzZySWFsVFcv?=
 =?utf-8?B?b05RNFBIWlEvWU1ENVRyUXdiRzZCSG5ITDBVMDNHay9JNnl0S1pGUjd5UlFF?=
 =?utf-8?B?WGNjd0k4Wlc3Z21kYmNKd29QaXZEMW81MkFWMjBxR3V4NXYzK3NKUDVBVWNi?=
 =?utf-8?B?V2FDK2lnRFJPbGNmL2U4ZnFKUnJJWEcwV2tST2lpNm85cDM5OG4vTS91WE5H?=
 =?utf-8?B?a2U4STVhNks0QVdnaitic25adlQxbE5vVjJiVkhzalk2Sis1SFl2L245M3Bl?=
 =?utf-8?B?YWFKZmtkNktvT1d1Szg1MWRsc0FzUzFUcTU1Yno0bkEyREV6amhDWitHb0dR?=
 =?utf-8?B?Q1JlSGE4Tmdtd3NCb3VUb2d5OWF4Zmtsd1hSc1oveHQzMURzWlBiVC9mcTNj?=
 =?utf-8?B?ZFVJOURPT0ZJU2tCdGhYWFlrMHNrbnlncUhkRzR1a0VsdnpDanNBZWVDSXBG?=
 =?utf-8?B?cGRjL0w2NUFFMmt5Z29lS29Cd1ZWUm8xdWc1czFXMDM5a2JmOXV1R1plaU5q?=
 =?utf-8?B?TXNTNlB3cXNXQjNtSUw1OWFWS3JQSkExVzhQbTAyeTczNFpMMkJvRytabWFQ?=
 =?utf-8?B?dHlXSjRKb2tKVlRLdkV3ekVsZFdJemZVbURGNUpucm5lZlpyUTE2bVJZM1VK?=
 =?utf-8?B?VVJ0RlVTN2w3bkdtV1QvcEJibWNwOE5Sbm9ZTU1JUi9wM1IxUGdiZ3VYc0s1?=
 =?utf-8?B?dmdEenY2V1ZGUHpMa1oyNk5NcTdtdEVOU1FGSG9qbjhHcCtRTDdNbVZKN01G?=
 =?utf-8?B?RWYzaUJGWmg4MzN3ejdUSmpoanB3NmdTaHgwVlErMmc2aUp5RXVta2M2ZHhi?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57517D6D8730EC4B9E4D9CA41299DA48@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447c4048-cf19-4471-516f-08dc904bd8d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 10:37:41.4032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hRUaAOm+PydlLPCTzCJxZA1ksU3ZFMaiCViUdc/EYRVk2B/beVTCZds4uc2jnV2NRi18SRji7v2/qXh/s9HyNQ0GsKiVV46+RwNWWZBnc0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7257
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--17.378600-8.000000
X-TMASE-MatchedRID: Y6GLOewO+JjUL3YCMmnG4rfB4/679SKYjLOy13Cgb4/mNRhvDVinv++1
	giXGd3Eefdd9BtGlLLzx1uczIHKx54/qvvWxLCnegOqr/r0d+CyWXqxvAbU4cslgi/vLS272Cf2
	h9A2gFAVmg/B0WkZ5phxcQNyFG36ZYNYpM1IG3mTAJnGRMfFxybBH/AqZyGLZ31GU/N5W5BD85U
	8A04R6EwzxaSlSFfefY2foQLX8qVh0JDl5FtzfIV2dJ3kmJGGWfS0Ip2eEHnylPA9G9KhcvZkw8
	KdMzN86KrauXd3MZDUD/dHyT/Xh7Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.378600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	15E71DA1B73FF84C0F1F684B5432B94D39F04ABF935FAE9E63A5B029DB28D8662000:8

T24gV2VkLCAyMDI0LTA2LTE5IGF0IDE2OjE3ICswODAwLCBTa3lMYWtlLkh1YW5nIHdyb3RlOg0K
PiBPbiBUdWUsIDIwMjQtMDYtMTggYXQgMDg6MjEgLTA3MDAsIEpha3ViIEtpY2luc2tpIHdyb3Rl
Og0KPiA+ICAJIA0KPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5r
cyBvciBvcGVuIGF0dGFjaG1lbnRzDQo+ID4gdW50aWwNCj4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0
aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+ICBPbiBUaHUsIDEzIEp1biAyMDI0IDE4OjQw
OjIwICswODAwIFNreSBIdWFuZyB3cm90ZToNCj4gPiA+IFRoaXMgcGF0Y2ggbW92ZXMgbXRrLWdl
LXNvYy5jJ3MgTEVEIGNvZGUgaW50byBtdGsgcGh5IGxpYi4gV2UNCj4gPiA+IGNhbiB1c2UgdGhv
c2UgaGVscGVyIGZ1bmN0aW9ucyBpbiBtdGstZ2UuYyBhcyB3ZWxsLiBUaGF0IGlzIHRvDQo+ID4g
PiBzYXksIHdlIGhhdmUgYWxtb3N0IHRoZSBzYW1lIEhXIExFRCBjb250cm9sbGVyIGRlc2lnbiBp
bg0KPiA+ID4gbXQ3NTMwL210NzUzMS9tdDc5ODEvbXQ3OTg4J3MgR2lnYSBldGhlcm5ldCBwaHku
DQo+ID4gPiANCj4gPiA+IEFsc28gaW50ZWdyYXRlIHJlYWQvd3JpdGUgcGFnZXMgaW50byBvbmUg
aGVscGVyIGZ1bmN0aW9uLiBUaGV5DQo+ID4gPiBhcmUgYmFzaWNhbGx5IHRoZSBzYW1lLg0KPiA+
IA0KPiA+IENvdWxkIHlvdSBwbGVhc2Ugc3BsaXQgdGhpcyBpbnRvIG11bHRpcGxlIHBhdGNoZXM/
IG1heWJlOg0KPiA+ICAtIGNoYW5nZSB0aGUgbGluZSB3cmFwcGluZw0KPiA+ICAtIGludGVncmF0
ZSByZWFkL3dyaXRlIHBhZ2VzIGludG8gb25lIGhlbHBlciANCj4gPiAgLSBjcmVhdGUgbXRrLXBo
eS1saWIuYyBhbmQgbXRrLmggKHB1cmUgY29kZSBtb3ZlKQ0KPiA+ICAtIGFkZCBzdXBwb3J0IGZv
ciBMRURzIHRvIHRoZSBvdGhlciBTb0MNCj4gDQo+IEhpIEpha3ViLA0KPiAgIE1tbS4uLlNvcnJ5
LiBCdXQgaXMgdGhpcyByZWFsbHkgbmVjZXNzYXJ5PyBJIGFscmVhZHkgZGlkIHNpbWlsYXINCj4g
dGhpbmdzIGluIHYyLiBJTUhPLCBjdXJyZW50IHBhdGNoc2V0IGlzIHNtYWxsIGVub3VnaCBmb3Ig
cmV2aWV3aW5nLg0KPiBZb3UNCj4gY2FuIGVhc2lseSB0ZWxsIHRoYXQgd2hpY2ggcGFydHMgY29t
ZSBmcm9tIG9yaWdpbmFsIG1lZGlhdGVrLWdlLmMgJg0KPiBtZWRpYXRlay1nZS1zb2MuYyBhbmQg
d2hpY2ggcGFydCBpcyB1c2VkIGZvciBNVDc5ODgncyBtdGstMnA1Z2UuYw0KPiANCj4gQlJzLA0K
PiBTa3kNCg0KSGkgSmFrdWIsDQogIEFmdGVyIHNlZWluZyBSdXNzZWxsJ3MgY29tbWVudHMgYW5k
IHJldmlld2luZyBteSBwYXRjaCBhZ2FpbiwgSSB0aGluaw0KSSBnb3QgeW91ciBwb2ludHMuIEkn
bGwgcmUtb3JnYW5pemUgdGhpcyBwYXRjaCBpbiB0aGlzIHdheToNCi0gY3JlYXRlIG10ay1waHkt
bGliLmMgJiBtdGsuaCBhbmQgbW92ZSBMRUQgaGVscGVycyBmcm9tIG10ay1nZS1zb2MuYw0KLSBp
bnRlZ3JhdGUgcmVhZC93cml0ZSBwYWdlcyBpbnRvIG9uZSBoZWxwZXINCi0gaG9vayBMRUQgaGVs
cGVyIGZ1bmN0aW9ucyBpbiBtdGstZ2UuYw0KLSBBZGQgTVQ3NTMwICYgTVQ3NTMxJ3MgUEhZIElE
IG1hY3Jvcw0KLSBTaHJpbmsgbXRrLWdlLXNvYy5jIGxpbmUgd3JhcHBpbmcgdG8gODAgY2hhcmFj
dGVycw0KDQpCUnMsDQpTa3kNCg==

