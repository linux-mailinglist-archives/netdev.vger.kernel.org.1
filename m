Return-Path: <netdev+bounces-287479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHnYONE5BGoqFgIAu9opvQ
	(envelope-from <netdev+bounces-287479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:44:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8027C52FD8E
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2AB10301AECE
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 08:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F25338F651;
	Wed, 13 May 2026 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wnc.com.tw header.i=@wnc.com.tw header.b="Ea68s25Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=WNCM365.onmicrosoft.com header.i=@WNCM365.onmicrosoft.com header.b="ulvjrKlr"
X-Original-To: netdev@vger.kernel.org
Received: from seg02.wnc.com.tw (seg02.wnc.com.tw [211.75.124.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5313DF00D;
	Wed, 13 May 2026 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=211.75.124.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661837; cv=fail; b=podG8F7YGxrAq61tn9DdghwHLUlxfRaT1Lfxw9Ao/B9LI0pD4nA6AjHubtnrpGF+9+3+aeExWtfRN4Dw9y1abEKL/UX5p3JBb4a85j879xPZvq4ll3jE8ugsV1/ogoi9d2mZmnCnez7rlM81tYRCPPBIXk8QbPYefNuNda5R8BQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661837; c=relaxed/simple;
	bh=KcLja1uK2SChufArG0IOo12RYG518me73Ax8/tdet88=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fJW8LVqFxc9nLCG5fhRiO0fVVmuuUF5CwDH93Z0iFvy/ayTqPHO8z6ifS4QG9qA1E54HT9Y76rfZx3co44yIoXcdVTWU4gXOcE1hp8SRMroLxzeds24ESTqspPeKl0rJa7OYo4TP+YrR7kEYoXu6+rU05MWrMmuTWHUIyL0bNjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wnc.com.tw; spf=pass smtp.mailfrom=wnc.com.tw; dkim=pass (1024-bit key) header.d=wnc.com.tw header.i=@wnc.com.tw header.b=Ea68s25Y; dkim=fail (1024-bit key) header.d=WNCM365.onmicrosoft.com header.i=@WNCM365.onmicrosoft.com header.b=ulvjrKlr reason="signature verification failed"; arc=fail smtp.client-ip=211.75.124.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wnc.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wnc.com.tw
X-UUID: 22862b7a4ea711f1827585c6d5df5b9f-20260513
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wnc.com.tw; s=WistronNeWeb;
	h=MIME-Version:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=fwCUCPLeVnAOArBYAeoGi9AZk13y/8Nrekt98lh3iX8=;
	b=Ea68s25Yht5B5db0JBKnuF/RtSGdPMcOyc/I5DrEtlOOrQmC1rul8m/D/hxyZLdtijUDUbeBNXYEssq6RZXFEeJg7UJGI5uB+zncJF6XJiuono9v8K8lWR78FUo+NGBX6MCWv2Ornt4JWakPgUu3WRRED3jW3s/g+JU19+W1Fw4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:60689907-9adf-44b6-ab9a-6dd898c5b76a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:5,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:4eb2c643-11c5-46fd-96b8-8ddde212c99a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|110|111|836|865|888|898,TC:0,Con
	tent:0|14|50,EDM:-3,IP:nil,URL:0,File:2|127,RT:0,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:0,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: 785E44C90E4723070C7FCA46B8248363
X-UUID: 22862b7a4ea711f1827585c6d5df5b9f-20260513
Received: from twwebmail.wneweb.com.tw [(172.16.101.149)] by seg02.wnc.com.tw
	(envelope-from <tim.jh.chen@wnc.com.tw>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1719160280; Wed, 13 May 2026 16:38:37 +0800
Received: from T1HQEX32.wneweb.com.tw (172.16.101.149) by
 T1HQEX32.wneweb.com.tw (172.16.101.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 May 2026 16:37:51 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (40.93.129.122) by
 T1HQEX32.wneweb.com.tw (172.16.101.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 May 2026 16:37:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldB2DCpyEaRQoxSXWkc9Llxe/5uZsvtSWasH8I7EptGJw1OksRwdLFRScbcGI7b0RXCMGcHQjrdx1elVVlFa53sEVMGuclryMZo5JwKbH8kzdyArWhLE4/hWZPaCRdToXPQYu5kwjNcEVuZgTqPN0jGjTB46Be3iVEn2ILgLru8hui3Bh4UkAfAeod1vzDBlf2d4RyHT4xyKXu8K/J3T0zdoqAQRJMyDBqTx5KwRzeLw2eT2DIN/W5/AdWgOTflYrsoul07PnAQ4oRYU4sEysq/OojOchPxeJaoFt3R1zAXoL7+kJFS3LjivjjcqVB2IIvNv1bh8R7CGukVLvTNJOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vv/ja6/DqmSzWC7Z8mbe34OsFNBvv+WMvXwsZlPRPUo=;
 b=XxvltLBxv7lSRWg1Ekvb350e4nDKWEmGuFjnp6P0yc+BT1K8zj163XZ7FyZ/b6WMcKvfgKoUUm1HUpSFNySTIubBytcDB1rPozQbnNCOmrTCnvTOZbmRp1mhI3GQknzXiQAvlFoeZsVfH00+MeyZUCXP2cXe5i81P+E1zHA7dmkAWgPkUtnUJTlB9szCilkN43TgXAv6SkYu+L91IDh+DDrMUSf5btLe1XKinVDFaHCb6kQ0xFVg5akcNCwIMiOY4yFiWK+krQ37jyqt6dRUysHqBdR9u9R4126Yiz0sZKoeJbVMEABZaSLfGFtQIUYf1KAQXPvYsJgJvlU4Jk4NTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wnc.com.tw; dmarc=pass action=none header.from=wnc.com.tw;
 dkim=pass header.d=wnc.com.tw; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=WNCM365.onmicrosoft.com; s=selector2-WNCM365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vv/ja6/DqmSzWC7Z8mbe34OsFNBvv+WMvXwsZlPRPUo=;
 b=ulvjrKlrtmliYsNpx15coO1CQe6h3HwMk54RebmYn4sG5g7RhKU9Yu8/2KzEreHR2TCSDDBKbby3Jk+Z2g9QYiF8pqfzZPsW7s7c9ZOV2U09/79oOj3hrUTyvgozKq4AMJnXEB/u3Nb801IY406Z/f9Rgejv+zvqung6QRenbkg=
Received: from TYZPR02MB5232.apcprd02.prod.outlook.com (2603:1096:400:72::7)
 by SI2PR02MB6104.apcprd02.prod.outlook.com (2603:1096:4:1f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 08:37:49 +0000
Received: from TYZPR02MB5232.apcprd02.prod.outlook.com
 ([fe80::1bcb:74be:ca6c:32f9]) by TYZPR02MB5232.apcprd02.prod.outlook.com
 ([fe80::1bcb:74be:ca6c:32f9%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 08:37:48 +0000
From: =?big5?B?VGltIEpIIENoZW4os6+kr8JFKQ==?= <Tim.JH.Chen@wnc.com.tw>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "chandrashekar.devegowda@intel.com" <chandrashekar.devegowda@intel.com>,
	"haijun.liu@mediatek.com" <haijun.liu@mediatek.com>,
	"ricardo.martinez@linux.intel.com" <ricardo.martinez@linux.intel.com>,
	"loic.poulain@oss.qualcomm.com" <loic.poulain@oss.qualcomm.com>,
	"ryazanov.s.a@gmail.com" <ryazanov.s.a@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: wwan: t7xx: fix race between TX thread and system PM
 suspend
Thread-Topic: [PATCH] net: wwan: t7xx: fix race between TX thread and system
 PM suspend
Thread-Index: AQHc4rEYd4Hmj8wiV0Cb4VgPh/ckqg==
Date: Wed, 13 May 2026 08:37:48 +0000
Message-ID: <TYZPR02MB5232A8C6A2BA56226D97CF4A90062@TYZPR02MB5232.apcprd02.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wnc.com.tw;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR02MB5232:EE_|SI2PR02MB6104:EE_
x-ms-office365-filtering-correlation-id: 187bbde8-3a06-4f11-8e13-08deb0cae9b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|6049299003|366016|376014|42112799006|1800799024|19092799006|11063799003|18002099003|56012099003|38070700021|8096899003|4053099003;
x-microsoft-antispam-message-info: z0HrPl/tgIcjtB/mx4VfJRNOWWODy+KTWVKtBd2/LIYZPbIN9cyfy5GdsllwIw9DhbpQkpUatMqyIaPNBbqcV0DExw6XznRakZdbvFyTnK4AwLD/FCkwpDTp1cUQfvz/ph7CmpcubOVRX6PpVDD+85nGfMbfcT6Z8d0jRNtbYbHUsyFOFw6bfVBqPZZI+RGFCSNHkXLghwuTqP/IGKHDeDSjKekxybREkU4Qwrba2DxIc3MkcYWonGIPPLXgyaAHupuTktDXlyYmOaKENqnOo2rdWCefnU/goHUDWNS6wW0e86l0UfsZrLZ4te/3v8QXLJqStbT/gqYkOiPbrx1kbigd9sOafuhrpHnytbevAjv2hW7QJ7M1BUl8PVKopEXIMqbs0Iu1xt6QlDOx/QnTzwjZlxdZMpsGX7l1CbNJHl8VGC3rspXii1YRRzM4i+GILbk+C65HPekyeTEdoXoDuUvs49bNJslGjpcfv36vb8v927eKbV4youNHn2fw0L+3FJ6LQ3IWq3QJsyTJhJQNBKoIm+dMnx7MGkEEQCPW+5VFGPfRvttO+YgM+3PNXUwj8RcAaMZxbWhci58x6LK3foNsTbzXYfsmBRRpy+0BF5Ryz4pNp684nNr3UoWAklZCgus/sMPfUERjUAkxRDcVNQHb9YxZzb98ntQleXdVf+DevKk2bdzSaUBpmORsRuQouRtOz6tivmTloKQW7r5FfMjtE4NIu3mOW9GZVCcjP8ADUHzMXebSbwUZvVUj5YTE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5232.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(366016)(376014)(42112799006)(1800799024)(19092799006)(11063799003)(18002099003)(56012099003)(38070700021)(8096899003)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?RTNhTTlhaHFuWUt5em8wWkVNSUpaRU9kc3lCMEZWMUFSU0xxR2RZa0k2TkdQV3Iy?=
 =?big5?B?NDNEd3MrU3E1WXE0YlVxQXpGNTNyWWpjdW93ZkFYM0h0N1gxWHdrWmJ4Y3JKVXlK?=
 =?big5?B?eG1tMkJtOGpuK29nL1IybTA3NEVMbzRsNFBsTUNwWDg0cDJLTjBtUTVPZE5IRWdq?=
 =?big5?B?MHFjNVVjdnpmR3FmQUV1Q2lZV1JWNFc4NEtxbXBuQnZCZ3NNMzUwV3Npbk9Qcitu?=
 =?big5?B?NUQwS3ZBc1lyU0dOUzhRUURQdXEwNFBxL01yV3NsaGpIejlKaFNzdzMwOW4wOStO?=
 =?big5?B?ZU44MjhHSFpvcWJ5NmFEWVRsVHRRRnppM0ZSYzJ1NWJYV2tsTWt4RHJBOFliOXBt?=
 =?big5?B?aHJCR3BCa2JmRko0WHlnS3hFVm9LYmZITVFGeEtMTnpoanhuVmM0VlV0allOanI3?=
 =?big5?B?anZGK1krQXB2bSs5cjFKeGY1OEJ3bjhxVHhFL3JrSzhIMTR4OUwzQk15bzZQdnJs?=
 =?big5?B?bG5MYXNLYy9XQ1F1cThubnRaWHliMUoydVJnTjBwNW1wb1Biay90UE5BYnVtaUY0?=
 =?big5?B?QVo0SXdVVVhFZUxnV21rbk5jK2x6a1NIY2I5TUdXRkJjam4yRXcrclVlNzJmZElL?=
 =?big5?B?Sit1bm5idG1RUXBYNVNWQTFhYUszMTZhTStoV1hqcjdkbWYwUGxSY09NM2xLVE5C?=
 =?big5?B?NE16UjVwdTBETTJVY0lvRmdOWVdlaXZxR3ZyUkJtYVBGb1Q3eUNrUndKRU45MHRa?=
 =?big5?B?NGxCTFU2eEk3aTdIWHhvYjRTeWNRdXBjVVRKMCtOdmRpMjMvZmFUdlkzVktHU25p?=
 =?big5?B?clVFd2ZjdXdhQmIyK0VhYmtySzcrOHRaOFVIanhaekQwb0h1VGpIS3lBSmZxWi96?=
 =?big5?B?Y1MvL3RRZFkwdXozTENDZTRpRVd0Vk5ucmNJcDk4dEROanhWbk1IdkpVQ1FOeGti?=
 =?big5?B?cDcwMUNZanh6T0JtMFhNZ0wwNUlLUGFCZThSR3RsL2ZuZ0t1VlRhQWZESW16R2xO?=
 =?big5?B?RGYvc09JVk1WQVAzUUp1KzZzcFpzVy83Z216V2RWczdKSlpubUc5SmdScWdrbmZk?=
 =?big5?B?ZG5md0dRUldhNVRWSTBJTnVOb0M3K2RlNnlXZE0xQlB2NHoydFZSRlpKSDVHbU9s?=
 =?big5?B?TVVPT3N3cHBkQzE4SEszOUpPdEFkVGVZRWtoZjV1Z3UzUEFoQ2RLZkNDeUt2NS93?=
 =?big5?B?UXhZaExuamExMW5GWndTRk5MUEdhUnFBaTExbk1IRkdRcWZ5QmhSMmZuVStEckQ2?=
 =?big5?B?S0Q0enhWaEt3NXg0Qi9hSWp3Y1pqTkViVGdiaGhnNWl4dnkwcEtMa0JpNzRmZU81?=
 =?big5?B?aGl6T0M1QkRQSDFEaFJ0eUZBalVHZCt4MW05VlZuZDlSTlc3Y25ZR2ZkM3BYSW1M?=
 =?big5?B?T1NDeDA3MS9LTHFXaWEvVXdxNDBUQzJ2ZjFxSHh3c25sSzZGV0xyNnQwcEhwRkVp?=
 =?big5?B?Q2pUalFsZ0UzNG9SWXNZcEJZNXZuRFRjeG84L2xGeXNlQjFKREk1MjRsMmw0cTFv?=
 =?big5?B?MjVab0o5eis5empNY1dNL3ByRllrc0liQzBMV1VwNzBTQlB4UHRabnF0YWJGdzE5?=
 =?big5?B?eUt6TDB3OGZ6RnA4dyt1ZGlidUM5aGNub0UvRy9Sc3czOWVBZlJvODhFaFRDN0Nh?=
 =?big5?B?R3JJWE0zdWFYZWgvV3FEN1QwSmJPeitMUnVodDFIUWlBTTdROFNDcklMRXJrOXRR?=
 =?big5?B?NDkyOXF5Z3VJbWl1aUw5aHA5Q0h4ayt4T29aYWxkODE4K1pydXFPTmNwbzVsK0Fk?=
 =?big5?B?V1ZHK01DdkdwUFZ1QXVnQncwRXQ2SGsrNzR5MzhwaVR5YVlWMmhYME1sYkdDYkJX?=
 =?big5?B?US82YW9ZWVdaUkpsS01kSEN2TzA1ZXVhVldPeE5JVHBPWUhuWEQwU2RuSDJRREdL?=
 =?big5?B?L3F3Q3hpdk5LM0lNNktpYWFiM3NhbHdSYW5vNlQrdTg2VThYTlU4cmtYM2ZDTE5J?=
 =?big5?B?Ynp1T2ZxUGRzREtHWU8yV1JJTkcxRXRXc0lENjI2NlZtYnI4NHVIZUw1TThDOUls?=
 =?big5?B?cktCRnJTNmUzd0VrYm1aWW9uN081RUsyWEhnUkZyKzgwbEM0TFpJOVZ6NnRXaHRG?=
 =?big5?B?UXBLZ1U1OHF3WmhKNWlHTkgvSFcxU1V3R3RyWXBUMmRNTWlIa29vVmY3amdFcHJD?=
 =?big5?B?NjhoTmZFVnZUcER5QzRaQ2lnK3BDN1k4TXFLcHJaUjFqWjlVeHpiRUx3TmdhRTc3?=
 =?big5?B?Tk0yd2R5QWlZVTd3YjMvQ2lWbjhVaGcrckZXWi9lY21HbjRXczlqb3BwYURwOFZl?=
 =?big5?B?cHJpS1l1TEJKUXFVMVF0QlJBT3Nwdz09?=
Content-Type: multipart/mixed;
	boundary="_004_TYZPR02MB5232A8C6A2BA56226D97CF4A90062TYZPR02MB5232apcp_"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VQYAkTXP16s8vwrsDE1p6dyUn2GNBsaHGt1aeZR64IlT7OUATOm1syj2+1A8NCBYeKdmVV72X6nQtP6r/mOGixEwrCG9PpfwaNkxiWHK0E2+XJrSZomG6+UXrvdclzgOTfPlOCbXxz8U6b+DCq/xQMSW+d5eCMhKLToYqubGPjHSGSaoQYJmO/TsACrA4Wx1BEuOUpQD6crNFuyxJdUFEJNSQUewhnSpV4e7fF+0SEHA53cBnqciN7vNxu2gwFPYGNnWdEQyiG2M31KONwkWA5n2IUwnbMGzkQKarvAVoIpqBisQ+Pn4fbT5cLB+BSANRqzqmjF9UWlAC96r7TNZOw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NzEsUyveRW+sN8SYdqz0ANDYbQy2hOClgUg23oIgD2PMOObJ4qOfEFZ9Pk/IAdqeQbkvB1y3BSpebErGW20gcQPZvDUkNBb7trhl5syNj6HPkDsXLz9RR5vSv60gWVpWdTk+jZI6v4YzQhj7PbfxsC1y00EV6cyc9XlF5+100CtU5UyLLjrEnuXMuxezFhWzOiugaPOPQBENLJA64qZeKcRV9i3icsMk8SaOsCSLf5ba6oESaUnNjaI1LphLPzn3+gpSM84JFv5oE8TvV5SOk+/8C4TBduTOtN6H6EPy9Uhp3x+4TEE3dj9bqwZ+BXWUKoboueCStbXWiUkfEp6+5ipOUVVOkj553NhZ3wVj+vL0KMxdMQjgAcGPOhDfyihnvGLudZZwkgaCma+YtCnUmoGrVno7rbROW42fO9D0Dln+YSEKchZCoGYruPEKvH/RSEEhRysaz92IYLj8NgGfyMHvVhDSriNDiiFECAklbBSs6i9sTEckq2jIrcCJ4aNqFjrWoLzA/Vs+3CoRBzT+sgDJn/54HZ6aDronNC0aejO0ZZPirwsCzvb8oDb52tOH/mA9iuunVL51TlDIp1R3EQSAE5OYtYjAf96XjAN7CfGBGq6VQTGBqFJtI/mKWv4T
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5232.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 187bbde8-3a06-4f11-8e13-08deb0cae9b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 08:37:48.3398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5e7e27a9-756f-49ba-a3ae-72aba10a316e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bY5srg+b1mCEI2+gmDj24e4qB1Y1GeP5LzieaFx/9x/bm+cCLMBTkdBHb4wKiwZHx1O+bjhi58PXX2wPBMoH3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB6104
X-OriginatorOrg: wnc.com.tw
X-Rspamd-Queue-Id: 8027C52FD8E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[wnc.com.tw:s=WistronNeWeb];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287479-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,TYZPR02MB5232.apcprd02.prod.outlook.com:mid];
	DMARC_POLICY_ALLOW(0.00)[wnc.com.tw,quarantine];
	TO_DN_SOME(0.00)[];
	DKIM_MIXED(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	R_DKIM_REJECT(0.00)[WNCM365.onmicrosoft.com:s=selector2-WNCM365-onmicrosoft-com];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[wnc.com.tw:+,WNCM365.onmicrosoft.com:-];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Tim.JH.Chen@wnc.com.tw,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,mediatek.com,linux.intel.com,oss.qualcomm.com,gmail.com,davemloft.net,kernel.org,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

--_004_TYZPR02MB5232A8C6A2BA56226D97CF4A90062TYZPR02MB5232apcp_
Content-Type: multipart/alternative;
	boundary="_000_TYZPR02MB5232A8C6A2BA56226D97CF4A90062TYZPR02MB5232apcp_"

--_000_TYZPR02MB5232A8C6A2BA56226D97CF4A90062TYZPR02MB5232apcp_
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64

RGF0ZTogV2VkLCAxMyBNYXkgMjAyNiAwOToyMTo0MCArMDgwMA0KU3ViamVjdDogW1BBVENIXSBu
ZXQ6IHd3YW46IHQ3eHg6IGZpeCByYWNlIGJldHdlZW4gVFggdGhyZWFkIGFuZCBzeXN0ZW0gUE0N
CiBzdXNwZW5kDQpNSU1FLVZlcnNpb246IDEuMA0KQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBj
aGFyc2V0PVVURi04DQpDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0DQoNCldoZW4gc3lz
dGVtIHN1c3BlbmQgaXMgdHJpZ2dlcmVkIHdoaWxlIHRoZSBEUE1BSUYgVFgga3RocmVhZA0KKHQ3
eHhfZHBtYWlmX3R4X2h3X3B1c2hfdGhyZWFkKSBpcyBydW5uaW5nLCBhIGRlYWRsb2NrIGNhbiBv
Y2N1cg0KbGVhZGluZyB0byBhIENQVSBzb2Z0IGxvY2t1cC4NCg0KVGhlIHJvb3QgY2F1c2UgaXMg
dHdvLWZvbGQ6DQoNCjEuIHQ3eHhfZHBtYWlmX3N1c3BlbmQoKSBjYWxscyB0N3h4X2RwbWFpZl90
eF9zdG9wKCkgd2hpY2ggb25seSBzdG9wcw0KICAgdGhlIFRYIHdvcmstcXVldWUgaXRlbXMgKGJ5
IGNsZWFyaW5nIHR4cS0+cXVlX3N0YXJ0ZWQgYW5kIHdhaXRpbmcgb24NCiAgIHR4cS0+dHhfcHJv
Y2Vzc2luZykuIEl0IGRvZXMgTk9UIHNpZ25hbCB0aGUga3RocmVhZCBhbmQgZG9lcyBOT1QNCiAg
IHVwZGF0ZSBkcG1haWZfY3RybC0+c3RhdGUsIHdoaWNoIHN0YXlzIERQTUFJRl9TVEFURV9QV1JP
Ti4NCg0KMi4gVGhlIGt0aHJlYWQncyBzdGF0ZSBndWFyZCAobGluZTogImlmIC4uLiBzdGF0ZSAh
PSBEUE1BSUZfU1RBVEVfUFdST04iKQ0KICAgaXMgb25seSBjaGVja2VkIGF0IHRoZSB0b3Agb2Yg
ZWFjaCBsb29wIGl0ZXJhdGlvbi4gSWYgdGhlIHRocmVhZA0KICAgYWxyZWFkeSBwYXNzZWQgdGhp
cyBndWFyZCwgaXQgcHJvY2VlZHMgdW5jb25kaXRpb25hbGx5IHRvIGNhbGwNCiAgIHBtX3J1bnRp
bWVfcmVzdW1lX2FuZF9nZXQoKSChWCB3aGljaCB0cmllcyB0byBhY3F1aXJlIHRoZSBQTSBzcGlu
bG9jaw0KICAgYWxzbyBoZWxkIChvciBjb250ZW5kZWQpIGJ5IHRoZSBzeXN0ZW0gUE0gc3VzcGVu
ZCBwYXRoLg0KDQpUaGUgcmVzdWx0IGlzIGEgc3BpbmxvY2sgZGVhZGxvY2sgb2JzZXJ2ZWQgYXM6
DQoNCiAgd2F0Y2hkb2c6IEJVRzogc29mdCBsb2NrdXAgLSBDUFUjTiBzdHVjayBmb3IgMjZzISBb
ZHBtYWlmX3R4X2h3X3B1XQ0KICBSSVA6IF9yYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9yZQ0KICBD
YWxsIFRyYWNlOg0KICAgIF9fcG1fcnVudGltZV9yZXN1bWUrMHg1Yi8weDgwDQogICAgdDd4eF9k
cG1haWZfdHhfaHdfcHVzaF90aHJlYWQrMHhjNCBbbXRrX3Q3eHhdDQoNClRoZSBjb25kaXRpb24g
cmVxdWlyZXMgQVNQTSBMMSBlbmFibGVkIG9uIHRoZSBlbmRwb2ludCAod2hpY2ggZXh0ZW5kcw0K
dGhlIHRpbWUgcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldCgpIGhvbGRzIHRoZSBQTSBsb2NrIGR1
cmluZyBMMS4yDQpsaW5rIHJldHJhaW5pbmcpIGFuZCBodW5kcmVkcyBvZiByZXBlYXRlZCBzdXNw
ZW5kL3Jlc3VtZSBjeWNsZXMgdG8NCnRyaWdnZXIgcmVsaWFibHkuDQoNCkZpeCBieSB0aHJlZSBj
b29yZGluYXRlZCBjaGFuZ2VzOg0KDQotIEluIHQ3eHhfZHBtYWlmX3N1c3BlbmQoKTogaW1tZWRp
YXRlbHkgc2V0IHN0YXRlIHRvIERQTUFJRl9TVEFURV9QV1JPRkYNCiAgYWZ0ZXIgc3RvcHBpbmcg
dGhlIFRYIHF1ZXVlLCB0aGVuIGNhbGwgd2FrZV91cCgpIHNvIGFueSBzbGVlcGluZyB0aHJlYWQN
CiAgcmUtZXZhbHVhdGVzIHRoZSB3YWl0X2V2ZW50IGNvbmRpdGlvbiBhbmQgc3RvcHMuDQoNCi0g
SW4gdDd4eF9kcG1haWZfcmVzdW1lKCk6IHJlc3RvcmUgc3RhdGUgdG8gRFBNQUlGX1NUQVRFX1BX
Uk9OIGJlZm9yZQ0KICByZS1lbmFibGluZyB0aGUgVFggcXVldWVzLCBzeW1tZXRyaWMgd2l0aCB0
aGUgc3VzcGVuZCBjaGFuZ2UuDQogIFdpdGhvdXQgdGhpcyB0aGUga3RocmVhZCB3b3VsZCBuZXZl
ciB3YWtlIHVwIGFmdGVyIHJlc3VtZS4NCg0KLSBJbiB0N3h4X2RwbWFpZl90eF9od19wdXNoX3Ro
cmVhZCgpOiBhZGQgYSBzZWNvbmQgc3RhdGUgY2hlY2sNCiAgaW1tZWRpYXRlbHkgYmVmb3JlIHBt
X3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoKSB0byBjbG9zZSB0aGUgVE9DVE9VDQogIHdpbmRvdyBi
ZXR3ZWVuIHRoZSB3YWl0X2V2ZW50IGd1YXJkIGFuZCB0aGUgcG0gY2FsbC4NCg0KVGVzdGVkOiBu
byBzb2Z0IGxvY2t1cCBvYnNlcnZlZCBvdmVyIDUwMCsgc3VzcGVuZC9yZXN1bWUgY3ljbGVzIHdp
dGgNClNJTSByZWdpc3RlcmVkIGFuZCBBU1BNIEwxIGVuYWJsZWQgKHByZXZpb3VzbHkgdHJpZ2dl
cmVkIGluIDwgMzAwKS4NCg0KRml4ZXM6IDA1ZjdlODlhYiAoIkxpbnV4IDYuMTkiKQ0KU2lnbmVk
LW9mZi1ieTogVGltIEpIIENoZW4gPHRpbS5qaC5jaGVuQHduYy5jb20udHc+DQotLS0NCiBkcml2
ZXJzL25ldC93d2FuL3Q3eHgvdDd4eF9oaWZfZHBtYWlmLmMgICAgfCAzICsrKw0KIGRyaXZlcnMv
bmV0L3d3YW4vdDd4eC90N3h4X2hpZl9kcG1haWZfdHguYyB8IDMgKysrDQogMiBmaWxlcyBjaGFu
Z2VkLCA2IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3d3YW4vdDd4
eC90N3h4X2hpZl9kcG1haWYuYyBiL2RyaXZlcnMvbmV0L3d3YW4vdDd4eC90N3h4X2hpZl9kcG1h
aWYuYw0KaW5kZXggN2ZmMzNjMWQ2Li4zMTVhNzdlMjQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25l
dC93d2FuL3Q3eHgvdDd4eF9oaWZfZHBtYWlmLmMNCisrKyBiL2RyaXZlcnMvbmV0L3d3YW4vdDd4
eC90N3h4X2hpZl9kcG1haWYuYw0KQEAgLTQxMiw2ICs0MTIsOCBAQCBzdGF0aWMgaW50IHQ3eHhf
ZHBtYWlmX3N1c3BlbmQoc3RydWN0IHQ3eHhfcGNpX2RldiAqdDd4eF9kZXYsIHZvaWQgKnBhcmFt
KQ0KICAgICAgICBzdHJ1Y3QgZHBtYWlmX2N0cmwgKmRwbWFpZl9jdHJsID0gcGFyYW07DQoNCiAg
ICAgICAgdDd4eF9kcG1haWZfdHhfc3RvcChkcG1haWZfY3RybCk7DQorICAgICAgIGRwbWFpZl9j
dHJsLT5zdGF0ZSA9IERQTUFJRl9TVEFURV9QV1JPRkY7DQorICAgICAgIHdha2VfdXAoJmRwbWFp
Zl9jdHJsLT50eF93cSk7DQogICAgICAgIHQ3eHhfZHBtYWlmX2h3X3N0b3BfYWxsX3R4cSgmZHBt
YWlmX2N0cmwtPmh3X2luZm8pOw0KICAgICAgICB0N3h4X2RwbWFpZl9od19zdG9wX2FsbF9yeHEo
JmRwbWFpZl9jdHJsLT5od19pbmZvKTsNCiAgICAgICAgdDd4eF9kcG1haWZfZGlzYWJsZV9pcnEo
ZHBtYWlmX2N0cmwpOw0KQEAgLTQ1MSw2ICs0NTMsNyBAQCBzdGF0aWMgaW50IHQ3eHhfZHBtYWlm
X3Jlc3VtZShzdHJ1Y3QgdDd4eF9wY2lfZGV2ICp0N3h4X2Rldiwgdm9pZCAqcGFyYW0pDQogICAg
ICAgIGlmICghZHBtYWlmX2N0cmwpDQogICAgICAgICAgICAgICAgcmV0dXJuIDA7DQoNCisgICAg
ICAgZHBtYWlmX2N0cmwtPnN0YXRlID0gRFBNQUlGX1NUQVRFX1BXUk9OOw0KICAgICAgICB0N3h4
X2RwbWFpZl9zdGFydF90eHJ4X3FzKGRwbWFpZl9jdHJsKTsNCiAgICAgICAgdDd4eF9kcG1haWZf
ZW5hYmxlX2lycShkcG1haWZfY3RybCk7DQogICAgICAgIHQ3eHhfZHBtYWlmX3VubWFza19kbHFf
aW50cihkcG1haWZfY3RybCk7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd3dhbi90N3h4L3Q3
eHhfaGlmX2RwbWFpZl90eC5jIGIvZHJpdmVycy9uZXQvd3dhbi90N3h4L3Q3eHhfaGlmX2RwbWFp
Zl90eC5jDQppbmRleCAyMzZkNjMyY2YuLmQ1YTViZWZlYyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
bmV0L3d3YW4vdDd4eC90N3h4X2hpZl9kcG1haWZfdHguYw0KKysrIGIvZHJpdmVycy9uZXQvd3dh
bi90N3h4L3Q3eHhfaGlmX2RwbWFpZl90eC5jDQpAQCAtNDYwLDYgKzQ2MCw5IEBAIHN0YXRpYyBp
bnQgdDd4eF9kcG1haWZfdHhfaHdfcHVzaF90aHJlYWQodm9pZCAqYXJnKQ0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBicmVhazsNCiAgICAgICAgICAgICAgICB9DQoNCisgICAgICAg
ICAgICAgICBpZiAoZHBtYWlmX2N0cmwtPnN0YXRlICE9IERQTUFJRl9TVEFURV9QV1JPTikNCisg
ICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KKw0KICAgICAgICAgICAgICAgIHJldCA9
IHBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoZHBtYWlmX2N0cmwtPmRldik7DQogICAgICAgICAg
ICAgICAgaWYgKHJldCA8IDAgJiYgcmV0ICE9IC1FQUNDRVMpDQogICAgICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gcmV0Ow0KLS0NCjIuMjUuMQ0K

--_000_TYZPR02MB5232A8C6A2BA56226D97CF4A90062TYZPR02MB5232apcp_
Content-Type: text/html; charset="big5"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dbig5">
<style type=3D"text/css" style=3D"display:none;"> P =
{margin-top:0;margin-bottom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
Date: Wed, 13 May 2026 09:21:40 +0800</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
Subject: [PATCH] net: wwan: t7xx: fix race between TX thread and system =
PM</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp;suspend</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
MIME-Version: 1=2E0</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
Content-Type: text/plain; charset=3DUTF-8</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
Content-Transfer-Encoding: 8bit</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
When system suspend is triggered while the DPMAIF TX kthread</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
(t7xx_dpmaif_tx_hw_push_thread) is running, a deadlock can occur</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
leading to a CPU soft lockup=2E</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
The root cause is two-fold:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
1=2E t7xx_dpmaif_suspend() calls t7xx_dpmaif_tx_stop() which only =
stops</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;the TX work-queue items (by clearing txq-&gt;que_started and =
waiting on</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;txq-&gt;tx_processing)=2E It does NOT signal the kthread and =
does NOT</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;update dpmaif_ctrl-&gt;state, which stays =
DPMAIF_STATE_PWRON=2E</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
2=2E The kthread's state guard (line: &quot;if =2E=2E=2E state !=3D =
DPMAIF_STATE_PWRON&quot;)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;is only checked at the top of each loop iteration=2E If the =
thread</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;already passed this guard, it proceeds unconditionally to =
call</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;pm_runtime_resume_and_get() =A1X which tries to acquire the PM=
 spinlock</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;also held (or contended) by the system PM suspend =
path=2E</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
The result is a spinlock deadlock observed as:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; watchdog: BUG: soft lockup - CPU#N stuck for 26s! =
[dpmaif_tx_hw_pu]</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; RIP: _raw_spin_unlock_irqrestore</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; Call Trace:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; __pm_runtime_resume+0x5b/0x80</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; t7xx_dpmaif_tx_hw_push_thread+0xc4 [mtk_t7xx]</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
The condition requires ASPM L1 enabled on the endpoint (which extends</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
the time pm_runtime_resume_and_get() holds the PM lock during L1=2E2</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
link retraining) and hundreds of repeated suspend/resume cycles to</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
trigger reliably=2E</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
Fix by three coordinated changes:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
- In t7xx_dpmaif_suspend(): immediately set state to =
DPMAIF_STATE_PWROFF</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; after stopping the TX queue, then call wake_up() so any sleeping =
thread</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; re-evaluates the wait_event condition and stops=2E</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
- In t7xx_dpmaif_resume(): restore state to DPMAIF_STATE_PWRON before</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; re-enabling the TX queues, symmetric with the suspend =
change=2E</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; Without this the kthread would never wake up after resume=2E</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
- In t7xx_dpmaif_tx_hw_push_thread(): add a second state check</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; immediately before pm_runtime_resume_and_get() to close the =
TOCTOU</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; window between the wait_event guard and the pm call=2E</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
Tested: no soft lockup observed over 500+ suspend/resume cycles with</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
SIM registered and ASPM L1 enabled (previously triggered in &lt; =
300)=2E</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
Fixes: 05f7e89ab (&quot;Linux 6=2E19&quot;)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
Signed-off-by: Tim JH Chen &lt;tim=2Ejh=2Echen@wnc=2Ecom=2Etw&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
---</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp;drivers/net/wwan/t7xx/t7xx_hif_dpmaif=2Ec &nbsp; &nbsp;| 3 +++</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp;drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx=2Ec | 3 +++</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp;2 files changed, 6 insertions(+)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif=2Ec =
b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif=2Ec</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
index 7ff33c1d6=2E=2E315a77e24 100644</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif=2Ec</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif=2Ec</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
@@ -412,6 +412,8 @@ static int t7xx_dpmaif_suspend(struct t7xx_pci_dev =
*t7xx_dev, void *param)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; struct dpmaif_ctrl *dpmaif_ctrl =3D =
param;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; t7xx_dpmaif_tx_stop(dpmaif_ctrl);</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; dpmaif_ctrl-&gt;state =3D DPMAIF_STATE_PWROFF;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; wake_up(&amp;dpmaif_ctrl-&gt;tx_wq);</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; =
t7xx_dpmaif_hw_stop_all_txq(&amp;dpmaif_ctrl-&gt;hw_info);</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; =
t7xx_dpmaif_hw_stop_all_rxq(&amp;dpmaif_ctrl-&gt;hw_info);</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; t7xx_dpmaif_disable_irq(dpmaif_ctrl);</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
@@ -451,6 +453,7 @@ static int t7xx_dpmaif_resume(struct t7xx_pci_dev =
*t7xx_dev, void *param)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; if (!dpmaif_ctrl)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return 0;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; dpmaif_ctrl-&gt;state =3D DPMAIF_STATE_PWRON;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; t7xx_dpmaif_start_txrx_qs(dpmaif_ctrl);</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; t7xx_dpmaif_enable_irq(dpmaif_ctrl);</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; t7xx_dpmaif_unmask_dlq_intr(dpmaif_ctrl);</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx=2Ec =
b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx=2Ec</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
index 236d632cf=2E=2Ed5a5befec 100644</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx=2Ec</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx=2Ec</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
@@ -460,6 +460,9 @@ static int t7xx_dpmaif_tx_hw_push_thread(void =
*arg)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if =
(dpmaif_ctrl-&gt;state !=3D DPMAIF_STATE_PWRON)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; continue;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ret =3D =
pm_runtime_resume_and_get(dpmaif_ctrl-&gt;dev);</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (ret &lt; 0 =
&amp;&amp; ret !=3D -EACCES)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; return ret;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
--</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; =
font-size: 11pt; color: rgb(0, 0, 0);">
2=2E25=2E1</div>
</body>
</html>
<!--type:html--><!--{-->"<hr>
This email and any attachments are intended for the sole use of the named =
recipient(s) and may contain confidential, proprietary, privileged or =
copyrighted information=2E If you are not the intended recipient, please =
delete immediately=2E Do not read, copy, or forward this email or any =
attachments=2E
<hr>"
<!--}-->
--_000_TYZPR02MB5232A8C6A2BA56226D97CF4A90062TYZPR02MB5232apcp_--

--_004_TYZPR02MB5232A8C6A2BA56226D97CF4A90062TYZPR02MB5232apcp_
Content-Type: application/octet-stream;
	name="0001-net-wwan-t7xx-fix-race-between-TX-thread-and-system-.patch"
Content-Description: 0001-net-wwan-t7xx-fix-race-between-TX-thread-and-system-.patch
Content-Disposition: attachment;
	filename="0001-net-wwan-t7xx-fix-race-between-TX-thread-and-system-.patch";
	size=4009; creation-date="Wed, 13 May 2026 08:21:58 GMT";
	modification-date="Wed, 13 May 2026 08:36:35 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3NDEyODg1ZmQzYjFkYTg2ZDBmZGMyM2U5YTQ4YWY0YjZkNTJjMzcwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaW0gSkggQ2hlbiA8dGltLmpoLmNoZW5Ad25jLmNvbS50dz4K
RGF0ZTogV2VkLCAxMyBNYXkgMjAyNiAwOToyMTo0MCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIG5l
dDogd3dhbjogdDd4eDogZml4IHJhY2UgYmV0d2VlbiBUWCB0aHJlYWQgYW5kIHN5c3RlbSBQTQog
c3VzcGVuZApNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJz
ZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKV2hlbiBzeXN0ZW0gc3Vz
cGVuZCBpcyB0cmlnZ2VyZWQgd2hpbGUgdGhlIERQTUFJRiBUWCBrdGhyZWFkCih0N3h4X2RwbWFp
Zl90eF9od19wdXNoX3RocmVhZCkgaXMgcnVubmluZywgYSBkZWFkbG9jayBjYW4gb2NjdXIKbGVh
ZGluZyB0byBhIENQVSBzb2Z0IGxvY2t1cC4KClRoZSByb290IGNhdXNlIGlzIHR3by1mb2xkOgoK
MS4gdDd4eF9kcG1haWZfc3VzcGVuZCgpIGNhbGxzIHQ3eHhfZHBtYWlmX3R4X3N0b3AoKSB3aGlj
aCBvbmx5IHN0b3BzCiAgIHRoZSBUWCB3b3JrLXF1ZXVlIGl0ZW1zIChieSBjbGVhcmluZyB0eHEt
PnF1ZV9zdGFydGVkIGFuZCB3YWl0aW5nIG9uCiAgIHR4cS0+dHhfcHJvY2Vzc2luZykuIEl0IGRv
ZXMgTk9UIHNpZ25hbCB0aGUga3RocmVhZCBhbmQgZG9lcyBOT1QKICAgdXBkYXRlIGRwbWFpZl9j
dHJsLT5zdGF0ZSwgd2hpY2ggc3RheXMgRFBNQUlGX1NUQVRFX1BXUk9OLgoKMi4gVGhlIGt0aHJl
YWQncyBzdGF0ZSBndWFyZCAobGluZTogImlmIC4uLiBzdGF0ZSAhPSBEUE1BSUZfU1RBVEVfUFdS
T04iKQogICBpcyBvbmx5IGNoZWNrZWQgYXQgdGhlIHRvcCBvZiBlYWNoIGxvb3AgaXRlcmF0aW9u
LiBJZiB0aGUgdGhyZWFkCiAgIGFscmVhZHkgcGFzc2VkIHRoaXMgZ3VhcmQsIGl0IHByb2NlZWRz
IHVuY29uZGl0aW9uYWxseSB0byBjYWxsCiAgIHBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoKSDi
gJQgd2hpY2ggdHJpZXMgdG8gYWNxdWlyZSB0aGUgUE0gc3BpbmxvY2sKICAgYWxzbyBoZWxkIChv
ciBjb250ZW5kZWQpIGJ5IHRoZSBzeXN0ZW0gUE0gc3VzcGVuZCBwYXRoLgoKVGhlIHJlc3VsdCBp
cyBhIHNwaW5sb2NrIGRlYWRsb2NrIG9ic2VydmVkIGFzOgoKICB3YXRjaGRvZzogQlVHOiBzb2Z0
IGxvY2t1cCAtIENQVSNOIHN0dWNrIGZvciAyNnMhIFtkcG1haWZfdHhfaHdfcHVdCiAgUklQOiBf
cmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUKICBDYWxsIFRyYWNlOgogICAgX19wbV9ydW50aW1l
X3Jlc3VtZSsweDViLzB4ODAKICAgIHQ3eHhfZHBtYWlmX3R4X2h3X3B1c2hfdGhyZWFkKzB4YzQg
W210a190N3h4XQoKVGhlIGNvbmRpdGlvbiByZXF1aXJlcyBBU1BNIEwxIGVuYWJsZWQgb24gdGhl
IGVuZHBvaW50ICh3aGljaCBleHRlbmRzCnRoZSB0aW1lIHBtX3J1bnRpbWVfcmVzdW1lX2FuZF9n
ZXQoKSBob2xkcyB0aGUgUE0gbG9jayBkdXJpbmcgTDEuMgpsaW5rIHJldHJhaW5pbmcpIGFuZCBo
dW5kcmVkcyBvZiByZXBlYXRlZCBzdXNwZW5kL3Jlc3VtZSBjeWNsZXMgdG8KdHJpZ2dlciByZWxp
YWJseS4KCkZpeCBieSB0aHJlZSBjb29yZGluYXRlZCBjaGFuZ2VzOgoKLSBJbiB0N3h4X2RwbWFp
Zl9zdXNwZW5kKCk6IGltbWVkaWF0ZWx5IHNldCBzdGF0ZSB0byBEUE1BSUZfU1RBVEVfUFdST0ZG
CiAgYWZ0ZXIgc3RvcHBpbmcgdGhlIFRYIHF1ZXVlLCB0aGVuIGNhbGwgd2FrZV91cCgpIHNvIGFu
eSBzbGVlcGluZyB0aHJlYWQKICByZS1ldmFsdWF0ZXMgdGhlIHdhaXRfZXZlbnQgY29uZGl0aW9u
IGFuZCBzdG9wcy4KCi0gSW4gdDd4eF9kcG1haWZfcmVzdW1lKCk6IHJlc3RvcmUgc3RhdGUgdG8g
RFBNQUlGX1NUQVRFX1BXUk9OIGJlZm9yZQogIHJlLWVuYWJsaW5nIHRoZSBUWCBxdWV1ZXMsIHN5
bW1ldHJpYyB3aXRoIHRoZSBzdXNwZW5kIGNoYW5nZS4KICBXaXRob3V0IHRoaXMgdGhlIGt0aHJl
YWQgd291bGQgbmV2ZXIgd2FrZSB1cCBhZnRlciByZXN1bWUuCgotIEluIHQ3eHhfZHBtYWlmX3R4
X2h3X3B1c2hfdGhyZWFkKCk6IGFkZCBhIHNlY29uZCBzdGF0ZSBjaGVjawogIGltbWVkaWF0ZWx5
IGJlZm9yZSBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KCkgdG8gY2xvc2UgdGhlIFRPQ1RPVQog
IHdpbmRvdyBiZXR3ZWVuIHRoZSB3YWl0X2V2ZW50IGd1YXJkIGFuZCB0aGUgcG0gY2FsbC4KClRl
c3RlZDogbm8gc29mdCBsb2NrdXAgb2JzZXJ2ZWQgb3ZlciA1MDArIHN1c3BlbmQvcmVzdW1lIGN5
Y2xlcyB3aXRoClNJTSByZWdpc3RlcmVkIGFuZCBBU1BNIEwxIGVuYWJsZWQgKHByZXZpb3VzbHkg
dHJpZ2dlcmVkIGluIDwgMzAwKS4KCkZpeGVzOiAwNWY3ZTg5YWIgKCJMaW51eCA2LjE5IikKU2ln
bmVkLW9mZi1ieTogVGltIEpIIENoZW4gPHRpbS5qaC5jaGVuQHduYy5jb20udHc+Ci0tLQogZHJp
dmVycy9uZXQvd3dhbi90N3h4L3Q3eHhfaGlmX2RwbWFpZi5jICAgIHwgMyArKysKIGRyaXZlcnMv
bmV0L3d3YW4vdDd4eC90N3h4X2hpZl9kcG1haWZfdHguYyB8IDMgKysrCiAyIGZpbGVzIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3d3YW4vdDd4eC90
N3h4X2hpZl9kcG1haWYuYyBiL2RyaXZlcnMvbmV0L3d3YW4vdDd4eC90N3h4X2hpZl9kcG1haWYu
YwppbmRleCA3ZmYzM2MxZDYuLjMxNWE3N2UyNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd3dh
bi90N3h4L3Q3eHhfaGlmX2RwbWFpZi5jCisrKyBiL2RyaXZlcnMvbmV0L3d3YW4vdDd4eC90N3h4
X2hpZl9kcG1haWYuYwpAQCAtNDEyLDYgKzQxMiw4IEBAIHN0YXRpYyBpbnQgdDd4eF9kcG1haWZf
c3VzcGVuZChzdHJ1Y3QgdDd4eF9wY2lfZGV2ICp0N3h4X2Rldiwgdm9pZCAqcGFyYW0pCiAJc3Ry
dWN0IGRwbWFpZl9jdHJsICpkcG1haWZfY3RybCA9IHBhcmFtOwogCiAJdDd4eF9kcG1haWZfdHhf
c3RvcChkcG1haWZfY3RybCk7CisJZHBtYWlmX2N0cmwtPnN0YXRlID0gRFBNQUlGX1NUQVRFX1BX
Uk9GRjsKKwl3YWtlX3VwKCZkcG1haWZfY3RybC0+dHhfd3EpOwogCXQ3eHhfZHBtYWlmX2h3X3N0
b3BfYWxsX3R4cSgmZHBtYWlmX2N0cmwtPmh3X2luZm8pOwogCXQ3eHhfZHBtYWlmX2h3X3N0b3Bf
YWxsX3J4cSgmZHBtYWlmX2N0cmwtPmh3X2luZm8pOwogCXQ3eHhfZHBtYWlmX2Rpc2FibGVfaXJx
KGRwbWFpZl9jdHJsKTsKQEAgLTQ1MSw2ICs0NTMsNyBAQCBzdGF0aWMgaW50IHQ3eHhfZHBtYWlm
X3Jlc3VtZShzdHJ1Y3QgdDd4eF9wY2lfZGV2ICp0N3h4X2Rldiwgdm9pZCAqcGFyYW0pCiAJaWYg
KCFkcG1haWZfY3RybCkKIAkJcmV0dXJuIDA7CiAKKwlkcG1haWZfY3RybC0+c3RhdGUgPSBEUE1B
SUZfU1RBVEVfUFdST047CiAJdDd4eF9kcG1haWZfc3RhcnRfdHhyeF9xcyhkcG1haWZfY3RybCk7
CiAJdDd4eF9kcG1haWZfZW5hYmxlX2lycShkcG1haWZfY3RybCk7CiAJdDd4eF9kcG1haWZfdW5t
YXNrX2RscV9pbnRyKGRwbWFpZl9jdHJsKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3d3YW4v
dDd4eC90N3h4X2hpZl9kcG1haWZfdHguYyBiL2RyaXZlcnMvbmV0L3d3YW4vdDd4eC90N3h4X2hp
Zl9kcG1haWZfdHguYwppbmRleCAyMzZkNjMyY2YuLmQ1YTViZWZlYyAxMDA2NDQKLS0tIGEvZHJp
dmVycy9uZXQvd3dhbi90N3h4L3Q3eHhfaGlmX2RwbWFpZl90eC5jCisrKyBiL2RyaXZlcnMvbmV0
L3d3YW4vdDd4eC90N3h4X2hpZl9kcG1haWZfdHguYwpAQCAtNDYwLDYgKzQ2MCw5IEBAIHN0YXRp
YyBpbnQgdDd4eF9kcG1haWZfdHhfaHdfcHVzaF90aHJlYWQodm9pZCAqYXJnKQogCQkJCWJyZWFr
OwogCQl9CiAKKwkJaWYgKGRwbWFpZl9jdHJsLT5zdGF0ZSAhPSBEUE1BSUZfU1RBVEVfUFdST04p
CisJCQljb250aW51ZTsKKwogCQlyZXQgPSBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KGRwbWFp
Zl9jdHJsLT5kZXYpOwogCQlpZiAocmV0IDwgMCAmJiByZXQgIT0gLUVBQ0NFUykKIAkJCXJldHVy
biByZXQ7Ci0tIAoyLjI1LjEKCg==

--_004_TYZPR02MB5232A8C6A2BA56226D97CF4A90062TYZPR02MB5232apcp_--


