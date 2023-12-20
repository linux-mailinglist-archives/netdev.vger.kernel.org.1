Return-Path: <netdev+bounces-59214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDCD819E16
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 12:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5276E1F22229
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 11:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127BC2136F;
	Wed, 20 Dec 2023 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uc3pnNCc";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="bmBqP9ik"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A036249EE
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2d0f4ec49f2b11eeba30773df0976c77-20231220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=sTxvKb8earLSFDL6AqZ/sOYBenXnzM9/xYFrpxrAp+4=;
	b=uc3pnNCcxAAGfcEGXMMXSdWWB3/wNaUwxC7ViYliOfBd2+DRp1B8Rv6qR9ZpT1ikNYMVK9ZcZ51Ldn215NYp6jbTVP9hsWaWgVgwbZtQdwWL2B4wcPaEzQfwj4T8Hs2oyxhAElH85aHNTt0lxVlG7GHSxYsliotnuTFqE6xVsnU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:1e90d55d-2dfb-4026-a59d-3eaa888c078c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:1635fb81-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 50,UGT
X-CID-BAS: 50,UGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2d0f4ec49f2b11eeba30773df0976c77-20231220
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 378698908; Wed, 20 Dec 2023 19:30:28 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Dec 2023 19:30:22 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Dec 2023 19:30:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gv4f5GlUhmv3WS9QNR/EHuJo+TlShGhFyES16GWMxOwLTsdMuQp528c/kegDGtpR3TTNGjq4c0emkI8X1SorCTPiFrAfD+kivYNSs+v4slh9FyBP0iv16NRIUTPLKISYXGtatNZX3yy8nL4v7EzwhoBEA4JzcQdaH3nsm5qfVl/f4+BN3socZB5Bu7KDGrpeqHpc31wxM8Hc6ZuWfgTLdkEoHIbKTjWu29MvebK8cEo/YQO+nXKR9XayO/7V5TXa+O1C+CnohkZVf1/rHejJ4B6eKjTWC8Mrt10A2oenD4wGAPQX6rLTZ2PmhbI7yllDHVzRCnaGDl8p/p9mXoijcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTxvKb8earLSFDL6AqZ/sOYBenXnzM9/xYFrpxrAp+4=;
 b=GHtfDGjILwcSt701lv5YKaeTooTGphTTg/fUnARABKEOlRiqfptAwSiKpR9BA4Cm9OKqI2mtpSMJJHu0uPs+xchZgFpGaBuj0O4LJwgdliXeQY9lc47RN71FLArPYBJTpGcZQ6AQ3ZOPrIHxoBnAk5YkOKGPPS5Y+rIU5DP39DlNu4PbuJg/6t3Zid1HclouQlaD2c0LXyskrtHtoXWmvOV+WKUB2KLRVNX4zhaSnHrtofYAgUSiLyVL58bHBEpAmCHVO4lN8QqP6UNgO7T4Y1m18IrfImAupLsmyN3A4vE1wWCsDCx0+3LjWymorlx7Ov+NfWmR/daxjJP1A39szA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTxvKb8earLSFDL6AqZ/sOYBenXnzM9/xYFrpxrAp+4=;
 b=bmBqP9ik02ysZ4LQpy4hVVzKWxiNL8m3AO3TPekmlR3C2RmWj0s2FQ20wLXeMczhPhB8no2NITsDtwMtbgctHB4rmxu+ZY7I8XMsQLWm7PP1EFenuJFdTkVkuCe/nXPD4WEOZn4R6TmPIJi6Rrp9390y44ZTK70Rbt27FeOTru0=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by SEZPR03MB7629.apcprd03.prod.outlook.com (2603:1096:101:12e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 11:30:20 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::d556:7c13:6e10:9a97]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::d556:7c13:6e10:9a97%4]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 11:30:20 +0000
From: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "dsahern@kernel.org"
	<dsahern@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	=?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>
Subject: Inet raw socket IPV4 has IPv4 header but IPv6 does not
Thread-Topic: Inet raw socket IPV4 has IPv4 header but IPv6 does not
Thread-Index: AQHaMzfprRGl+uJAiEyousck8XDpSQ==
Date: Wed, 20 Dec 2023 11:30:20 +0000
Message-ID: <00a151515ed11c2daf8fb54221f2927c7bfe95d0.camel@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|SEZPR03MB7629:EE_
x-ms-office365-filtering-correlation-id: 7bcc0c49-4526-4da4-d6a1-08dc014f0c7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jb3PAfuZyBiKa8k6hLHpwv99jK3cHavsEYa8r9im8IPbw67JSdoKNtJd5u7Yp6wEErM46Qo4xNFsXRP894KwHktjPRTPtIh+Jk6vGXT6UMMvCJDxDEdpmzMXH9JDtCuvGGyLKnQLDo47JQUuOzoZ7STWntBkmAdjgfljsAe2bRy1VIvgTpW6P1bBEmCVs7Xgr4vbFWqIxbZVCt6gyECp2ANBA13BcBDkMCjn9dMbLGlQT18bNHmz79Zmui9mt2xhymZrjqcSJN7svyL4OUH+OgavFbw3+AtYg8fvdsxs/o9cXbSp/Ys9McG2sdJixbdj+FlyGurRZHCb5qn/XAez4N2vtTrrQozmHcmw6KIuqxdLqQkUHTAPwe9a3nALvlm5e+uMgpbqW6mGdXRSkOUloC3NY+bDGVEGmuwYICiTFmhE3AcuvV+yWfW8JBDBTqJ9GAaGzLzA9hbZWHfirGA7NR61Msv/y//N50pquv8x+YLxr4EPlGGeZxJXpmR1K3e9mMXr7W13LGbmj5nGphZXFg+jeE7b/hTDTF1dz6ZjjodkRwGZehe3WEmnFTOQVXGdqXmgUTcxq1111/jQWkA7UW9cKJYKfaPzdUiHH1gvU6FEPlIV4g4LNC+AFrnS8l0ihZARZiD6QJcM5qHW3U5T1Jcxeb3BPi5d0kgkcnEpj94=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(2906002)(41300700001)(86362001)(85182001)(36756003)(122000001)(38100700002)(71200400001)(54906003)(110136005)(66476007)(6506007)(6512007)(66446008)(8936002)(8676002)(6486002)(76116006)(66946007)(66556008)(64756008)(91956017)(4326008)(5660300002)(26005)(83380400001)(2616005)(107886003)(478600001)(316002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckdTcWVobGVLc2NUQ1NrR0lBc1A4eHk4em14cURBbXdadVJwZ0ZDTzk5anJw?=
 =?utf-8?B?ODFoOThRbksvZDRXckRmTU9kbXc2ZnhSbnp0T2xOOHE1VFpsSGppd29EMnZG?=
 =?utf-8?B?QUFHUlplY2dOTTJOYTNWcWx3SUJQMmRRd2x3OEpXZFViYzE3WlBIL1JNbEZE?=
 =?utf-8?B?aWVYUFRXVGJobFgyWXBGelNSMjhiQUx0RVRPNXM0UGZUWkxyeXNCL1EvVFVJ?=
 =?utf-8?B?MU5hbm94WHhMNlp0V3IxQUplVUt6RURDMVg0K3hCUUpicE5GYWhXN0hJelpK?=
 =?utf-8?B?dFJucitLWG5xRlRxelFqVE5ZSnp5N005TWwzRUkyejgwdHBoa3U5dzdvQUZG?=
 =?utf-8?B?N2E2T1F0elU1eGRCQkdGREdWY2NtUDB5Y2R3Z1dMZHBON2xNcmFnQlRzbnU5?=
 =?utf-8?B?QVF4Q3VheEwwNmdFYm8yMmcxWmxncDRxRzl6Q3hkbXlPQ3k5WVdYYi9QMVE0?=
 =?utf-8?B?OTZaL0U1ekpRaU0wZUJhUnZIU1RZYWV2T2ZOYlVJS1FhY3lDMWRZTE9BWC95?=
 =?utf-8?B?ajhLYm1CRzVWb0swUkNrcE5SaUsweXYwempvWEJDRjBycFlBbS9FTDM2SS9D?=
 =?utf-8?B?R3JVa3BrM0F3K2hUTUtpbWJBTEQwN3BmeWRGMFV1cThLTlJrTkVzMDcrRkR2?=
 =?utf-8?B?QmZ5ZnRoUmlOa2I5U0UybU9rRlQ2cnFTMkU4eTRGd095NDBPQVdsdm04UnNC?=
 =?utf-8?B?REVwWmVhV05NNERRdnRWUUIvMGhCV21ZVTlDSTBkOVl4MTBaNXlOTzlieC9Y?=
 =?utf-8?B?NWR1OEFOeDk3OGZmdkFCM3NtajV6V3dablMydi95VlVFYzZIMWpBTys5RDdW?=
 =?utf-8?B?NVkvVFVjVFhtU0xmV0xyUTdJSjNCUGVQQ3BnZWltaDM4ZkxlSDRnRWxUb2pq?=
 =?utf-8?B?UlJGL1M1N3Q4Tzh5aC9hMWpkQ0tRVEZ6S2hHQURPR24vUDdIUHpNdTBISFRE?=
 =?utf-8?B?TmEzTjdnN0lCS2F3ZjRnY1lETFFNMXZFSXVRU0poQTZQRkxKZExEMjZQTmF4?=
 =?utf-8?B?ekhwSFFnSlNyNFpVMEgxRytibmhLWXFtV1podmVVOUdpc3daMHkzNWpIWTdZ?=
 =?utf-8?B?NDF3TEtkdWNuSXY4RkMzeWpJVXdkWWoxZDluWFVEQktZNEZ5QkU5bmwwTHZh?=
 =?utf-8?B?cGFSYllJN3dhRFozNWJjSHQ3QllZOFVXeTI4eVB6d0REaEd6NXozOVpWTzFt?=
 =?utf-8?B?S0ZhM0k3ZHFGK0RZdW96RHFKNTR5b1cyVFIvTzlKUlMvQWNBODZ5THJ0SWs3?=
 =?utf-8?B?K0MyaDlHUXoyUFVJZldScVhBUkRrdktOZ1ZESE1MWEp4N3J5a1VZWXp2Wktt?=
 =?utf-8?B?Zko0Zk5PRXpkblNYQ29JaTY0YkV6RVpiUVRFUklWdVZLbEtlcmhVZDM5Z2Na?=
 =?utf-8?B?M3J5WFhFYTlzYjdybHpFUmI0Ym9aQjlQUGNNY0xJWWxadklDWUl5a1JwcUxG?=
 =?utf-8?B?bWdWVGdYZ0QvQkVEZnVCbmhwYTRPcXNlYmhvMWhxSVlIdk5TWVJMTFJRWHNB?=
 =?utf-8?B?dTZaUUFjS0FHMGhMSWxydTR2cEhnYmFDMFNuMWljRVRJMHFDU2xKVGxibWQx?=
 =?utf-8?B?Ty9Eemt6K3JtTGNod3dkWlNQVEYzMjhxUCtrOTJRUmVadTZUUElOVWEzcG9R?=
 =?utf-8?B?Zzl5dE1tT3V4OWNGYVgzbXcwTVdkcG9SYzhmcTgyQ29rTG1wNCtRYmNwci90?=
 =?utf-8?B?bFRCTXArR0RJSDlTUDViUU1ldTRIb1ZvT3pHczFsNU5PdGc4ekdlNCtlNEUy?=
 =?utf-8?B?djE2a0JwUTRaUnk1TWNzdEhyejg3VnNKNldIV1VXVzgrREpGRDlvMGVXOHBt?=
 =?utf-8?B?YkNna2JibjFzSzhLK2x6SUZHLzVPdFdWb3VYU3JtQUl6VHZzMHYzTGJkbHlE?=
 =?utf-8?B?VDR4UmMyZ2JZSmNKTENtbUtxeHZUdUhmQVRFOHE4TzE5VGt4dTZZdTJKVFho?=
 =?utf-8?B?c3NmMTIwUXplNEVEeFc0MDJsWmoyc3YrelpyNzNpbHltTTFHTlk4OEw0UUg0?=
 =?utf-8?B?MEdmRW5jeFFtbGhHYkt2YUUzeGE1czFwb2FmS3hsYlZRcXlBYmg0Y3d6WnZk?=
 =?utf-8?B?ODZjSGM4dXZrek9xYVF3TWNIYXFEaEcrSFBhVWgzTnRGdjZuN2svd3ZHcmUy?=
 =?utf-8?B?ZTc4ZUJ2dXo2MFlOM2dzM1dxMUtsZ2duRm1ma0Z2R2ZyY2ZXM2t6SGtsZXpM?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1DB12F45150034E9ABEC4D526DB79AD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcc0c49-4526-4da4-d6a1-08dc014f0c7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 11:30:20.3054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jidsiESQrtGta+mg9DiyazMnPdvYKwnyxk9XD7ay93LBCS3fjSaCoiVSJHQejx9gHTxdLr5LuYergWL0TAX/fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7629

RGVhciBkYXZlbSAmIGRzYWhlcm4sDQpXaGVuIHVzaW5nIGluZXQgcmF3IHNvY2tldCwgSSBmb3Vu
ZCB0aGF0IGlwdjQgYW5kIGlwdjYgYXJlIGluY29uc2lzdGVudA0KdGhhdCBJUHY0IGhhcyBhbiBJ
UCBoZWFkZXIgYnV0IElQdjYgZG9lcyBub3QgaGF2ZS4gd2Ugd291bGQgbGlrZSB0bw0KcmVwb3J0
IHRoaXMgaXNzdWUgYW5kIHdhbnQgdG8ga25vdyBpZiBpcHY2IHNob3VsZCBiZSBtb2RpZmllZCB0
byBrZWVwDQpJUCBoZWFkZXIgc2FtZSBhcyBpcHY0IGRlc2lnbi4NCg0KDQpJc3N1ZSByZXBvcnRl
ZDogc2hpbWluZy5jaGVuZ0BtZWRpYXRlay5jb20NCg0KSW4gaW5ldCByYXcgc29ja2V0LCBhcHAg
Y2FuIGdldCBwYXlsb2FkIGFuZCB0aGUgaXAgaGVhZGVyIGluIHVzZXINCnNwYWNlLCB3ZSBjYW4g
c2VlIGluIGZ1bmN0aW9uIHJhd19yY3YgdGhhdCBza2ItPmRhdGEgcG9pbnRzIHRvIHRoZSBpcA0K
aGVhZGVyIHdpdGggc2tiX3B1c2guDQpJbiBpbmV0NiByYXcgc29ja2V0LCBhcHAgY2FuIG9ubHkg
Z2V0IHBheWxvYWQgd2l0aG91dCBpcHY2IGhlYWRlciBpbg0KdXNlciBzcGFjZSwgd2UgY2FuIHNl
ZSBpbiBmdW5jdGlvbiByYXd2Nl9yY3YgdGhhdCBza2ItPmRhdGEgcG9pbnRzIHRvDQp0aGUgaWNt
cHY2IGhlYWRlciB3aXRob3V0IHNrYl9wdXNoLg0KIA0KKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioNCklQVjQNCklu
IGluZXQgaXB2NCByYXcgc29ja2V0LCBhcHAgY2FuIGdldCBwYXlsb2FkIGFuZCB0aGUgaXAgaGVh
ZGVyIGluIHVzZXINCnNwYWNlLCB3ZSBjYW4gc2VlIGluIGZ1bmN0aW9uIHJhd19yY3YgdGhhdCBz
a2ItPmRhdGEgcG9pbnRzIHRvIHRoZSBpcA0KaGVhZGVyIHdpdGggc2tiX3B1c2guDQppbnQgc29j
a2ZkID0gc29ja2V0KEFGX0lORVQsIFNPQ0tfUkFXLCBJUFBST1RPX0lDTVApOw0KUGluZyBpY21w
IElwdjQgd2l0aCBpcGhkcu+8mg0KNDUwMDU0MDAwMDMyMWU4MzQ4ODg4YWFhODViYjAwNTllZDAy
Mjg5YzRhMmM4MTY1MDAwMGVmZjQwMDAwMDEwMTExMjEzMTQNCjE1MTYxNzE4MTkxYTFiMWMxZDFl
MWYyMDIxMjIyMzI0MjUyNjI3MjgyOTJhMmIyYzJkMmUyZjMwMzEzMjMzMzQzNTM2Mw0KNDUwMDU0
MDAwMDMyMWU4MzQ4ODg4YWFhODViYjAwYTdkZDAyMjg5ZDRiMmM4MTY1MDAwMGEwMWU0MDAwMDAx
MDExMTIxMzENCjQxNTE2MTcxODE5MWExYjFjMWQxZTFmMjAyMTIyMjMyNDI1MjYyNzI4MjkyYTJi
MmMyZDJlMmYzMDMxMzIzMzM0MzUzNjM3DQoNCmludCByYXdfcmN2KHN0cnVjdCBzb2NrICpzaywg
c3RydWN0IHNrX2J1ZmYgKnNrYikNCnsNCi4uLg0KICAgICAgIG5mX3Jlc2V0X2N0KHNrYik7DQog
DQogICAgICAgc2tiX3B1c2goc2tiLCBza2ItPmRhdGEgLSBza2JfbmV0d29ya19oZWFkZXIoc2ti
KSk7DQogDQogICAgICAgcmF3X3Jjdl9za2Ioc2ssIHNrYik7DQogICAgICAgcmV0dXJuIDA7DQp9
DQoNCioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqDQpJUFY2Og0KSW4gaW5ldDYgcmF3IHNvY2tldCwgYXBwIGNhbiBv
bmx5IGdldCBwYXlsb2FkIHdpdGhvdXQgaXB2NiBoZWFkZXIgaW4NCnVzZXIgc3BhY2UsIHdlIGNh
biBzZWUgaW4gZnVuY3Rpb24gcmF3djZfcmN2IHRoYXQgc2tiLT5kYXRhIHBvaW50cyB0bw0KdGhl
IGljbXB2NiBoZWFkZXIgd2l0aG91dCBza2JfcHVzaC4NCmludCBzb2NrZmQgPSBzb2NrZXQoQUZf
SU5FVDYsIFNPQ0tfUkFXLCBJUFBST1RPX0lDTVBWNik7DQpUaGUgYmVsb3cgZGF0YSBpcyBpY21w
djYgUkEgbW9uaXRvcmVkIGJ5IHJhd3NvY2tldCBhbmQgaXQgZG9lc24ndCBoYXZlDQppcGhkcjoN
Cjg2MDA0OTA0RkYwMDA3MDgwMDAwMDAwMDAwMDAwMDAwMDEwMTAwMDAwMDAwMDAuLi4NCg0KaW50
IHJhd3Y2X3JjdihzdHJ1Y3Qgc29jayAqc2ssIHN0cnVjdCBza19idWZmICpza2IpDQp7DQouLi4g
DQogICAgaWYgKGluZXQtPmhkcmluY2wpIHsNCiAgICAgICAgICAgaWYgKHNrYl9jaGVja3N1bV9j
b21wbGV0ZShza2IpKSB7DQogICAgICAgICAgICAgICAgICBhdG9taWNfaW5jKCZzay0+c2tfZHJv
cHMpOw0KICAgICAgICAgICAgICAgICAga2ZyZWVfc2tiKHNrYik7DQogICAgICAgICAgICAgICAg
ICByZXR1cm4gTkVUX1JYX0RST1A7DQogICAgICAgICAgIH0NCiAgICB9DQorICAgLy8gaXB2NiBz
a2ItPmRhdGEgc2hvdWxkIGJlIHBvaW50ZWQgdG8gaXB2NiBoZWFkZXIganVzdCBsaWtlIGlwdjQu
DQorICAgc2tiX3B1c2goc2tiLCBza2ItPmRhdGEgLSBza2JfbmV0d29ya19oZWFkZXIoc2tiKSk7
IA0KICAgIHJhd3Y2X3Jjdl9za2Ioc2ssIHNrYik7DQogICAgcmV0dXJuIDA7DQp9DQoNCg0KVGhh
bmtzDQpMZW5hDQogDQo=

