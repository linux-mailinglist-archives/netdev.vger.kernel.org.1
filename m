Return-Path: <netdev+bounces-97188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8C88C9C44
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 13:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A46D1C20F30
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 11:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0464653814;
	Mon, 20 May 2024 11:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LO1w7wUT";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="bJqiNGN6"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B3253805;
	Mon, 20 May 2024 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205428; cv=fail; b=EWSudiTJV7vZxIJTW27gomlkFmk0NNPomOIaUE1zmbELT1C1av8WWuQw7PQE3q529+ldXOWL1gSJmQyYA3h2sRqToBAIk1rKTQ7KW1D7icC2pCrtnH910q9IO78sR7/EqYJxUCSB+inEJESW8Gj95aQo3xRBuGi7Vhpaalh+Boo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205428; c=relaxed/simple;
	bh=ddTu6fxbJ+Mxy6eGFceec0/B8afArjLi+W8CDdgN7Dg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nWzFt5dAqDOCajsDdlExlKXIBcqisKn+oTfMs9UKZoAVl4GzEYFeaLAvc0g/CQsAMYFU1+udCn7edkdtfQei06ZIH6q4KDkEcsDoiPMeXPaT+t3jwiJLnVGEiTp7t1z7BlTR0OZzy+ZVi8T7uCVm+PCa6NK2Xnk/YUP16A4I7RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LO1w7wUT; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=bJqiNGN6; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 33497810169e11ef8065b7b53f7091ad-20240520
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ddTu6fxbJ+Mxy6eGFceec0/B8afArjLi+W8CDdgN7Dg=;
	b=LO1w7wUTvYMzyj7vaTak90oemHTmfz8vVnlYJhyc7Q+sJq9C94h9t8CEImjRZMLjnhvWIVfTVO4QLkZPJpUsOClXGExtL18qiTx7OWZwGNzdDi/CKFk45nKJboeUs+4yhhJy6KMK+tGe+s2ZB8b8nLnK5efgW62u/qkVpKJfPb8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:83b0d770-715b-4756-8c94-3e272bac68a2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:a2bb50fc-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 33497810169e11ef8065b7b53f7091ad-20240520
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1125830585; Mon, 20 May 2024 19:43:39 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 20 May 2024 19:43:37 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 20 May 2024 19:43:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSQalWKlafmwpv8b8WAKXUCX16JOZOSPAYwf5JPFhEYKXd8j0+AT/ACNl+9G+6qkXW7j8YLGY54BxoJcYAI8RzGQV3uuk12bmPxr/BSIq7pL5+mmZbNv27m2/+sG+i+Nundof1YplPG1PqMuefP4PtTmqgc6fdF2pdzPpsLVLyKeN+6ijHTrzLQdqS63AXEsk5f2LfU1Tpe4qVk438HLJ//3xYCkOKePsSzxTJCTrJAriiaU29EUxvUh/1EtEvUsXTjXy2X6mGF4e0sTBFjzGsrKhPbZQxLVLF5v2RlrDSChi9NyzZsZ4CazOtVHMxRD54pwPC3yJapTTX0nLnlVEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddTu6fxbJ+Mxy6eGFceec0/B8afArjLi+W8CDdgN7Dg=;
 b=fCmSFdoeTfUludUu6wRA8MdcRHPKQsKi8Jm0LeaA7ILdb6/IrczJDZe/2Q+li6GmAe/J/BC+sXZxOExuyCw8xDLbjmpG83o+llwf7zswquSPmqvNoeyD0WJP3p8kH4CGeVmYGJCh1szBOW/HyzBn2jCejDDKMA7zyMD2rohPzYJwBrLtuvRZNO7H3Ccoa9bqwjR1t43CoZRD9P6CNxGBLCKcdFl1v1ckNF4fD4+iScw23XHk+DqqvQ22cywuOpERkiUFzNlyuI4kCepwSLKAJqwelefKWLWGKnPXXOC40v8YRgatcstlwNYcDOu2lBpx8aUr9FDLZTBG9nuD009dBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddTu6fxbJ+Mxy6eGFceec0/B8afArjLi+W8CDdgN7Dg=;
 b=bJqiNGN67MUAk5N74GTu7UyTReL6igP6jtJB9J9GZ/9kNfkyiBei3XMRHjTvBIRmD6P7K1iOdFgQNk0QlW6T2ay3leQ9iGYOiK2YfV4yBjqlxSpgKB0vAf9aFJPXzD+4RVHc4c47svVsSsnXAy5rWkybLRMBSV15SK/WA6Nfc58=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by TYZPR03MB8214.apcprd03.prod.outlook.com (2603:1096:405:26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.16; Mon, 20 May
 2024 11:43:35 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%5]) with mapi id 15.20.7611.013; Mon, 20 May 2024
 11:43:35 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next v2 4/5] net: phy: mediatek: Extend 1G TX/RX link
 pulse time
Thread-Topic: [PATCH net-next v2 4/5] net: phy: mediatek: Extend 1G TX/RX link
 pulse time
Thread-Index: AQHaqEVGPDfq7KUxa0uqHsmqaT4HgrGcF26AgAPt6oA=
Date: Mon, 20 May 2024 11:43:35 +0000
Message-ID: <f3283f70917b5c1c8d983d9f0e4ada290f9a7376.camel@mediatek.com>
References: <20240517102908.12079-1-SkyLake.Huang@mediatek.com>
	 <20240517102908.12079-5-SkyLake.Huang@mediatek.com>
	 <d4a99edc-e514-4a18-9d85-0355ddf4686a@lunn.ch>
In-Reply-To: <d4a99edc-e514-4a18-9d85-0355ddf4686a@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|TYZPR03MB8214:EE_
x-ms-office365-filtering-correlation-id: 9d1ad1f6-5cfc-43a8-ec69-08dc78c21503
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?eDRxNDNldE1DMy9KVHZpTDA4ZmNVSCswUDQ1VDM4cXU1V3ZVZ2o4SS9kLzNr?=
 =?utf-8?B?dXJwdm5hak10MlNMWTJZSU50ZmxEREYzU1V6QVJia0F4UTIvNW5uWk5CVVF6?=
 =?utf-8?B?OU9JME4zYVVRZ1lnS3F1WXEzVlpwa1FJSjBzVTVUNi9aeXkwQm5JQ041T1Rm?=
 =?utf-8?B?bkdDVWE4REFDTktoV3ErNG51V2pUaU83TnJOelhHS0ZzaStWdWtBTGFuRnlt?=
 =?utf-8?B?VUNEb2lFb3B3MWRDdW9pSzhpOTkwVlhMcFpQN29wRTV0UWh5OTN0eFhDOGpG?=
 =?utf-8?B?RHhzeFlwME4yZEFnMFBONS9wbTBIQkU3NERlK1R6eEs3Q1NVNERWZlMxVngv?=
 =?utf-8?B?dlgwYTQvU090VmxWTjZKNzJ3UElVdW1UZnVxVGlIbGdIbVkzd1hKeTlsVEU2?=
 =?utf-8?B?ci93U0phWnVGYk56c0pmQllCbTFIZFd5YUlvdUYxSVFuM1oweEhpWERiTGha?=
 =?utf-8?B?akNvNm5OZXNjRUJ6MVF0ZHNwd1NLV1dDNHE0K2JQNjVPbTNVd05DUDBMN0tv?=
 =?utf-8?B?UlhjbkZMZkhkcDN5TjZiS0dDMjlyRy84TTAwaWc2VWNoMThCM1AyYitxUXB0?=
 =?utf-8?B?ZjZQS0g0YVN4c0hwVVpTdHdPaFQySUlOUFdZY1Evb1hqN21LUGtNQ01Iblo3?=
 =?utf-8?B?UEcvUVpnUDVEMFdhNGdlWEt4d1RoeGVvSStSVkRNTHNZQllISUlZVXJ3MjBQ?=
 =?utf-8?B?VzJqaXNuS2haVzBIUXJNdE94MUJ1SWRvYkZqZ2JxV1huUDBCZzQxQjlDTTdo?=
 =?utf-8?B?dVI4SVdmNnlwb1hRdlgzbVBIUWRhS2V6WHJra09IeTd3d0xDNmVMakdpWExR?=
 =?utf-8?B?MTQ2a3ZNM0NCN1d5aE84ZWxCcVM1bE9OMDhteHkrU0RoTkVIdk9DbW15MWNa?=
 =?utf-8?B?bGM4bVZEVzV0ZHdkUmdyL3lxcURvVTVhVWIrMGc2a29wb0Jubml5QkVSUWRm?=
 =?utf-8?B?cThjRkNvTTlGYy9MbEpyMnE5K0Nkb2ppQm1INGNjUVBIVkZrTExkYTZtQndz?=
 =?utf-8?B?SVp5TlBDdWs5MG1FYVloZ1FDUEFKb3BKNVZpdXd3SWZ3REVTVFFJUFNIMVlE?=
 =?utf-8?B?aHYxRUhTZkhZV3BHYXRCNDBzL3lKbDZsU2xjYXBkb0RxRzBubVZnT0FFS0hN?=
 =?utf-8?B?ZzNvazg0TFhBRWQwL1k1Rm15Y1JOSXg2bU9sTEdwckxoR0tvOE9wTkVlcDFD?=
 =?utf-8?B?YUJmeEJiTUc0elVKWkZrSG9uTHhUUjB5SXRNS3JsYWYwWXYrdnVRVnU1c202?=
 =?utf-8?B?aUpNR21pVEMyYzdxSWhTaDZoc0JLY3dnaTFMdmlPQjhlTTFTTno3RFlaYzdX?=
 =?utf-8?B?ZVNqSDFCWThldDRraDRNLzlVTkJHUzkremIydE90SFc3bFVLS01zWHBwSXFw?=
 =?utf-8?B?cHYxaWdVNXRkb3dPUzRnRWF2R3IvTko2cHdkbmZlRmtsZmMvMjFZWDcxT0tm?=
 =?utf-8?B?U0IzRGh6YVNEUThlTThqckpUVXd6dzV2T2ZxSFZsUlQ5dGRKS0pzRGxlUlpP?=
 =?utf-8?B?WG5RYU04ZTU5Y1lYRC9ZNmx4UkFJYUF0eU9rcW42WERSVmh2RCswUzQ1SHZD?=
 =?utf-8?B?MC9hc2xGRGVxZjRpc2V0c0JhdHFydlJiZHNJaHN4Y3lCSlNXMzFrUDdScmoz?=
 =?utf-8?B?UlAydDJxTVV3QW8vVUluaExpUWFNc3ZhQ0ZMWlB5Uk52TG5ESldYekJyankv?=
 =?utf-8?B?ajFOc3I0V0tzOWJHY09HcFhYakJOTm5QcG5Id1hRTllINHJid3VQK1RDclE5?=
 =?utf-8?B?Y2JPQ3IybHI1VW1yTHRyTi8yZEZHeFZmcEtWaE9wa2FsNFd2SkdpQXRkeXI1?=
 =?utf-8?B?WlJrWEJUeitWeDlzOTc1Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXhKbEZHMkdBMFI3Uk1UQ1NhNFd0Z2lScFhUZFA3d1FqY0ZYbUI0dFV0R0tJ?=
 =?utf-8?B?QUpvR3ZlWXR6Yi92NThBQnVldlhReitzUFpJWVQwR25nWVZWaWRHbU8rMVp3?=
 =?utf-8?B?dEZWZ0xYMzZZQ1E5NHBwYUw3aWI4bE9KNW1TYWt6aS9mWmpmSmFod0g0WVcv?=
 =?utf-8?B?MXpHYlV6NTBaYlNpUHJYV25XZkZ4RVN4eU5vWTdQZnBIbmFyVWxDc2xWSTNG?=
 =?utf-8?B?SUdSQ1FUa3pyVTdndmNvOEJIUk1vUjhyMDNadkVtUE8zbHBtQVNpOGNPNUpE?=
 =?utf-8?B?cldNUjBqZ2d6RmZwd3JNODk3VU9ZUmJWOCtpb2ltejhTUUlvamhtWjZwbmRM?=
 =?utf-8?B?eUE3RjRaUUFvbDFmSExSNU9oaDZCZTUyNVEwdTgzMEE2NmdMOEdMQXlaMlpa?=
 =?utf-8?B?dEgrbFpaQUFsajlwV1d5UmZlbkZsNjdjV2ZTS3NFV0EwbzcyYjM0K29FL21S?=
 =?utf-8?B?SCtzR25PODlmZ245V1VrL0d2TnRScUxBaG0xbFczVUU3QkdCdVJSSDRQdmY2?=
 =?utf-8?B?R1IzVlF6UUMxVFc3YlZKcHFoQmhqMGp0aDlzSWp1RFdZM1U5T2tsTDdNS2tz?=
 =?utf-8?B?T2dIUjMzamRTdjQzT3VtbUpnYUYzV25BdVBSd1N5WktWejd5SzJtVmdOd0Mx?=
 =?utf-8?B?UzVuYlpBUTJFVndld0FPcjkxVGpuM3QwYktsSXZWMURYVEQ1dFJzN0RZdlRY?=
 =?utf-8?B?QjUwS0kzZFdKb2l2WERDTElFdDJTVkc3Mm5kMEtWZ1pYRFhIbThvbFhPZG9H?=
 =?utf-8?B?a2MwRzlsaTBVRVdqNzVoWGVjd2UvdWw3aFlFbWx3U0YzUGFWNWZqeTg4SWl6?=
 =?utf-8?B?S1l1ZWtDdlZrSVFQbzJkY3Z3YTVGOEMraGNhQ1BDM1p2NHhLaU9yRjgxNFVm?=
 =?utf-8?B?WDVrM0t6OW5BUWxhTDZ0RGFZeVhjQnhhaEFCSTFkc3ZWTlVRNWRtUUtCa0hv?=
 =?utf-8?B?Y0dhU0duTGdERm9IcmRlMVRQN2hTWHo3L1ZyTHJXNENiZVBPUUVpd2Foblhq?=
 =?utf-8?B?SzJ2UlJESE9tUHB1U0ZBT1JtY2xYNThMZ0NsaG9CdEozTktQWFpYVzZVMHlY?=
 =?utf-8?B?Q1RVSzBaa09uMFYreENrYWxRQlNrR2s4ekRCaDJ5WCttelN6WENUaU5QeHM4?=
 =?utf-8?B?dmM0aGhYdlpualBUNVZMWkRYcDRGSkw1RDE5OGZJdXVBNzV6Vy9EcWhtNjNN?=
 =?utf-8?B?ZEFndUVOb1Q2WnM4cmswa0lrQ0JUNURrUHZuVDJDV1VrY1luaml5QWhVbHgy?=
 =?utf-8?B?T0ViQVNPVVBxY1RBNUV5ZUZsZzVtdEZnOFZSQkY4b21jZWo2T0p2bTlvZ25Q?=
 =?utf-8?B?ZmY5M3pqYW5Xbm1HOUlxMjFxRURRRzFhSWVBV1B6NFFDU09OUjBsS1Q3TXk2?=
 =?utf-8?B?UVpjbzZTMzhuUkFHUDNyb1ZLQWpEWlFiZjZLenR4b2dDb010WTcxOGJPYzE0?=
 =?utf-8?B?TzRNNlA2S0o3MERTZFJkcUxRNGdLZ0dOZTAxK3JEL0hVdjgxTTZHcGx4QmxL?=
 =?utf-8?B?Ykh5NW9paHNta3lOSm5KT2wrNm9lRkNwcE5SWFJRVXhubWNSOCtiVTZPOXN4?=
 =?utf-8?B?Nnk3U2ZVbmx4ckZQNk51cHdoVTBjbytocVc5WlZuM1Y0SmRkeEV3QWc1a2dI?=
 =?utf-8?B?bnA2K2psSGpTOUNmR2x0c2JhRXdacHprVVNBWGJaOW80QlRUKzlkeTNIdm5M?=
 =?utf-8?B?YVUzZzlwcGhIVTA3am16M2ZaMDRyTmpOeVlwYlc0Y2lYV1A4c1VhbGo5dEJj?=
 =?utf-8?B?WElsdHhxOVVCeEl5MHFBSnVHV1htbnhBY2tyYU5iYXlpWEdpcmdxMUI0Qm9B?=
 =?utf-8?B?N2k2MExINVFwVkMxZnMrQ3FpRHl4Y0oyVUZqdG5MM1ozZ29KYWY0Snl6anVv?=
 =?utf-8?B?R1YySnpBbk1KZXNMNmcyOWZhL0lyYk5KR2NmQ0hyQ1ZVamJYNk5NTW1oVWl5?=
 =?utf-8?B?TXRIdWFWenZRSDdMZjJYeW1vaWNkU1pXUmJLWXJTbEtYTWhWTkpSYlB5WStY?=
 =?utf-8?B?UnNqQW1lS1FudENucDM1SmZ5aUFXTlNDODd2Qzh4NmFSN09JdStTUFliOFls?=
 =?utf-8?B?d0d2eVlBd1REeVQ1UWhlQjZtWGZQdTJWM1RrMG1tK2pGVVhNSTZoRCt1K2hY?=
 =?utf-8?B?STN5Wkd0RzEzSVgzRlo1c3VwOTVhbWEzNnhvRmtqT0RjTjJ3bm0zNDFFMk5h?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A26C268D586894DABFEB95E10BD01A2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1ad1f6-5cfc-43a8-ec69-08dc78c21503
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 11:43:35.1059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K5LZ9yg4Z8HEfwGNDJLuylzfdWgPv8cJ+GM3ekocDLmwZpW6enG+fDmo6d0KgW9UXdzNqVs18cJ2PztOgv5R6/m4NVEIYpw7EBtbPHE+rio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8214
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--14.985700-8.000000
X-TMASE-MatchedRID: F7tLedRt7ifUL3YCMmnG4qfOxh7hvX71jLOy13Cgb4/n0eNPmPPe5KWz
	WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2FYJUGv4DL3x+Mk6ACsw4Jp0Koq3EzpuHM4q
	s8hVLF7a5HgWbNPGcGhM8uKszKyqaXNpsQYEVcak5yOdvO+rz38MdI0UcXEHzxSZxKZrfThN6bQ
	veTAnFN2z9EKa36MwE1SQkxzt2Vp8YB2fOueQzj9IFVVzYGjNKcmfM3DjaQLHEQdG7H66TyH4gK
	q42LRYkrKG6ZYXOiw9qhXpGl53Ciyj3HlfLFgR0RlOzZg3f2g1+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.985700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	196913D2C4B0478FCC221F5624D120D9F1C3D37F1319B744F4619D31EF53CE6E2000:8

T24gU2F0LCAyMDI0LTA1LTE4IGF0IDAxOjQzICswMjAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICA+ICtpbnQgbXRrX2dwaHlfY2wyMl9yZWFkX3N0YXR1cyhzdHJ1Y3QgcGh5
X2RldmljZSAqcGh5ZGV2KQ0KPiA+ICt7DQo+ID4gK2ludCBlcnIsIG9sZF9saW5rID0gcGh5ZGV2
LT5saW5rOw0KPiA+ICtpbnQgbWlpX2N0cmw7DQo+ID4gKw0KPiA+ICsvKiBVcGRhdGUgdGhlIGxp
bmssIGJ1dCByZXR1cm4gaWYgdGhlcmUgd2FzIGFuIGVycm9yICovDQo+ID4gK2VyciA9IGdlbnBo
eV91cGRhdGVfbGluayhwaHlkZXYpOw0KPiA+ICtpZiAoZXJyKQ0KPiA+ICtyZXR1cm4gZXJyOw0K
PiA+ICsNCj4gPiArLyogd2h5IGJvdGhlciB0aGUgUEhZIGlmIG5vdGhpbmcgY2FuIGhhdmUgY2hh
bmdlZCAqLw0KPiA+ICtpZiAocGh5ZGV2LT5hdXRvbmVnID09IEFVVE9ORUdfRU5BQkxFICYmIG9s
ZF9saW5rICYmIHBoeWRldi0+bGluaykNCj4gPiArcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICtwaHlk
ZXYtPm1hc3Rlcl9zbGF2ZV9nZXQgPSBNQVNURVJfU0xBVkVfQ0ZHX1VOU1VQUE9SVEVEOw0KPiA+
ICtwaHlkZXYtPm1hc3Rlcl9zbGF2ZV9zdGF0ZSA9IE1BU1RFUl9TTEFWRV9TVEFURV9VTlNVUFBP
UlRFRDsNCj4gPiArcGh5ZGV2LT5zcGVlZCA9IFNQRUVEX1VOS05PV047DQo+ID4gK3BoeWRldi0+
ZHVwbGV4ID0gRFVQTEVYX1VOS05PV047DQo+ID4gK3BoeWRldi0+cGF1c2UgPSAwOw0KPiA+ICtw
aHlkZXYtPmFzeW1fcGF1c2UgPSAwOw0KPiA+ICsNCj4gPiAraWYgKHBoeWRldi0+aXNfZ2lnYWJp
dF9jYXBhYmxlKSB7DQo+ID4gK2VyciA9IGdlbnBoeV9yZWFkX21hc3Rlcl9zbGF2ZShwaHlkZXYp
Ow0KPiA+ICtpZiAoZXJyIDwgMCkNCj4gPiArcmV0dXJuIGVycjsNCj4gPiArfQ0KPiA+ICsNCj4g
PiArZXJyID0gZ2VucGh5X3JlYWRfbHBhKHBoeWRldik7DQo+ID4gK2lmIChlcnIgPCAwKQ0KPiA+
ICtyZXR1cm4gZXJyOw0KPiA+ICsNCj4gPiAraWYgKHBoeWRldi0+YXV0b25lZyA9PSBBVVRPTkVH
X0VOQUJMRSkgew0KPiA+ICtpZiAocGh5ZGV2LT5hdXRvbmVnX2NvbXBsZXRlKSB7DQo+ID4gK3Bo
eV9yZXNvbHZlX2FuZWdfbGlua21vZGUocGh5ZGV2KTsNCj4gPiArfSBlbHNlIHsNCj4gPiArbWlp
X2N0cmwgPSBwaHlfcmVhZChwaHlkZXYsIE1JSV9DVFJMMTAwMCk7DQo+ID4gK2lmICgobWlpX2N0
cmwgJiBBRFZFUlRJU0VfMTAwMEZVTEwpIHx8IChtaWlfY3RybCAmDQo+IEFEVkVSVElTRV8xMDAw
SEFMRikpDQo+ID4gK2V4dGVuZF9hbl9uZXdfbHBfY250X2xpbWl0KHBoeWRldik7DQo+IA0KPiBU
aGlzIGFsbCBsb29rcyB2ZXJ5IHNpbWlsYXIgdG8gZ2VucGh5X3JlYWRfc3RhdHVzKCksIGV4Y2Vw
dCB0aGVzZQ0KPiB0aHJlZS4NCj4gDQo+IFdvdWxkIGl0IGJlIHBvc3NpYmxlIHRvIGNhbGwgZ2Vu
cGh5X3JlYWRfc3RhdHVzKCkgdG8gZG8gbW9zdCBvZiB0aGUNCj4gd29yaywgYW5kIHRoZW4gZG8g
dGhlc2UgY291cGxlIG9mIGxpbmVzIG9mIGNvZGUuDQo+IA0KPiAgICAgICBBbmRyZXcNCg0KUmVm
YWN0b3IgdGhpcyBpbiB2My4gVGhpcyBmdW5jdGlvbiBzdGlsbCB3b3JrcyB3ZWxsIG9uIG15IG10
Nzk4OA0KcGxhdGZvcm0uIFRoYW5rcyBmb3IgdGhpcy4NCg0KU2t5DQo=

