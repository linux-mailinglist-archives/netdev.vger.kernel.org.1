Return-Path: <netdev+bounces-100484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 226538FAE2A
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 10:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401A51C232A0
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 08:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B03142E6C;
	Tue,  4 Jun 2024 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZrBh17XY";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="oiSLswza"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFC0BA39;
	Tue,  4 Jun 2024 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491492; cv=fail; b=MSoT35MIgLm49rDLhnHg+0VL4jHPzoPaAWtLgaQMb4hx61ETO1bEvLERPZxkIO+vW2ILEpOF60u/yzjJMchUaEIzyK4X/8jAD4I8zDaX4YFVEr14wOKa/nu/2mH+N8ayjxFYhpTsoIfQamBREmx5/vxJ9Rh+VIJjKRbJ0C8kxd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491492; c=relaxed/simple;
	bh=Hqn1lB9cSREsfSyNDbeLG5mgriU/Bx9wek0Vlc22Kqk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kxvMMjY0EqrFi61tSB5DgV9my82RviYGjtoBa79mw80LehuirAP9v0c/eHp6v1R7/MFVOyFzf1t/vSxpGFTl2QYAHJiO5cDd99OxU0P+rlh/Sh+3Hw8MW5jAJkCZ0VPofyCqBnbw/c8mTJ1N8jZh/0cRfkVQTvG5vXienKJOLx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZrBh17XY; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=oiSLswza; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8b27efcc225011efbfff99f2466cf0b4-20240604
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Hqn1lB9cSREsfSyNDbeLG5mgriU/Bx9wek0Vlc22Kqk=;
	b=ZrBh17XY+R3NVqcuJ5Dwd6+Na1EXOl1YOVWSF4k5OTKNNt9XaP2h0ZitJ8GBDLtXWi3bKo9ZmQAeZHVEaPjVbgWneFzz1XPx19206pryDm+CfWUF4ZxIxumj0dAluc/k/sMfK7fzwkz56FdjJkZ0wn2VNqC4QinSPdQ0V05Da6w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:fb9a7eb5-bb0b-4539-ac03-17de4ba8bb15,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:347c9893-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8b27efcc225011efbfff99f2466cf0b4-20240604
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 722788627; Tue, 04 Jun 2024 16:57:59 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 4 Jun 2024 16:57:58 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 4 Jun 2024 16:57:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0et0f9ZYkDyJpTd0FY8/omC9isJCVQ2aCu7JUUbVkRWk0XRHDMLqoCL9Vb3Rl6nJTXL3ylwy4zLdqRX5H50RzAZYBtgDsiQFV0MHMm312mZPPcr1xYe3LvnS+jdeek+sP0mtdtz33I1pWWXX72aKciNhr2NNfInpRb2IWmhuKI/aT3jXBDDvvGUTJe24ZsRQh9W6oioCptT2BXJuUHx46JYJL0Vfctpa1aSh8coB0EKSBwyHdN1FYBKQLOp63PtVyfDrc6IOTeaGjyiFHE2/Vm11JkEWyMG2DSHBwx4W5dQPbVpDKbXyLEdBy+2Nv2lYngxSx7Z4xH7UJ5S1JOmFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hqn1lB9cSREsfSyNDbeLG5mgriU/Bx9wek0Vlc22Kqk=;
 b=lvP6M3gWKvMgyxf9nlpDvo8yJ7Jc+LSinPtDC6Rk+CNcMF+RS4NKjCpIayymlaMvpkxtUstkZl1TA1FKOt0rbQkcJcYmh57xQDzSX/f61GnTN9Xy0Bkb7Yjseggro5fQds91Q/OphH9A/D5HZJIIYgIlFJ/SSj2uFJ6n0r53EdQVJ3NOiN+5aXN83/f1Hc7bm65KhQkwI4CnLX/wILY13vhnd9BXoMUsoaepPldiLDUyymP6W/eFZKa+T4vr+xbh8QH1XnIiUxPIL+gjuO1KzJqhcAVpWW2oIz4CYEZC9SASXfa68FUFqCWJNKNbjn5AsGVQSY5RC2K82NCJlYxKfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hqn1lB9cSREsfSyNDbeLG5mgriU/Bx9wek0Vlc22Kqk=;
 b=oiSLswzazzjwyzQlVIlfMe28It3LeEBCflO0Abpw3+aAYpuCzTCYvyr0g2Rj1CvPICa3182iwchw/2Twv5c8lKWBN64TyEMOuYgREMELS0TjotGuOpRnsUNCb1+adIPpBbTscX+F/N+Cy3WSgHM/cST5d7tU9qNx5TX57kSJ6Q8=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by KL1PR03MB8800.apcprd03.prod.outlook.com (2603:1096:820:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.13; Tue, 4 Jun
 2024 08:57:56 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%3]) with mapi id 15.20.7656.007; Tue, 4 Jun 2024
 08:57:55 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "daniel@makrotopia.org" <daniel@makrotopia.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	=?utf-8?B?U3RldmVuIExpdSAo5YqJ5Lq66LGqKQ==?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next v6 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Topic: [PATCH net-next v6 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Index: AQHatbCSfQp9e/Gy/kieT40tWkycBLG2cEaAgADe6oA=
Date: Tue, 4 Jun 2024 08:57:55 +0000
Message-ID: <b7ee870be0ecee7eacfbd1424356d2e8fe369cec.camel@mediatek.com>
References: <20240603121834.27433-1-SkyLake.Huang@mediatek.com>
	 <20240603121834.27433-6-SkyLake.Huang@mediatek.com>
	 <Zl4cE2yc5MuJSZJ6@makrotopia.org>
In-Reply-To: <Zl4cE2yc5MuJSZJ6@makrotopia.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|KL1PR03MB8800:EE_
x-ms-office365-filtering-correlation-id: afcdc1ba-0978-4339-2467-08dc84746c72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UHE3WC9lYnlDUENDdlBGeDlWMStJeTZ1b2JYY1FkeGVOVldoRm4yOTJIK0J0?=
 =?utf-8?B?T2tFZ0RLdVpqRmNHUnZxQlExYzRaVGtmK2d0Si9DU3U5SVlFekVsRzNid3FT?=
 =?utf-8?B?eVcwZ2thcXZZQTRGWk80cnovdjdMazlIMC9KZ3VTUVRlRjFrN2R6TzVmWXEr?=
 =?utf-8?B?OE1GRjErV0ZSQmJDdmZnWml2VnVtU3lLYys3dzUya0FQWWczZXVIQVZONFYz?=
 =?utf-8?B?WEt1SXM3UkJnZDc2bFJwRUt6THdrOC82RzdQNXA5Z0doWUtjcmZBMlgrRXJo?=
 =?utf-8?B?QzRjV0g1Q1pZS3hBcTVUR1paT0g2WkVsdHdPTFNIZkxqMmV6clErRlBkSTdH?=
 =?utf-8?B?eUQvMjVHUlNNZnRGVE84ekdDYXN1QTdEUXlCTXB4NWZmR1ZQT3F0aVBHakRT?=
 =?utf-8?B?VFY1Uk0zQlF5WkEvZWI3UUxSMkpGeXlEb2FuOHZnMUZLdGk1THQvZUM5MDdy?=
 =?utf-8?B?dFlwcjZrdUVya3VWQWJpVnZYMnBJQWZxNFFsYUMrRUZLWXZtcUp2MUFIM0N5?=
 =?utf-8?B?VzY5bEhKaVRjaS81MUVrUlBtSjJBTDJyNmpsenFncVdqbXBwMldhdlBaZ3ZH?=
 =?utf-8?B?MVVwdmF5NzFhKzlhRWxkQWtrZXF1UHU4Z1AyMW5FZlFIN251SGdNOXkrc3U1?=
 =?utf-8?B?aFF4clo5akluaUQ3YzM3SlRhZjBpKzBDQk03a3hUMG9QQ0VmYTEyUlVuWStW?=
 =?utf-8?B?V0ZGbUtxUkxWaWhqd0szZE1uamtSTmpJaXNldHJCK3NHM2syUWw3aEptK2NB?=
 =?utf-8?B?T3RTQ25BYlhqczZvNkZjNjVnRUFDVjZha3VPUDk2NTVvNlM5SlJ0VXp3SEQ3?=
 =?utf-8?B?MHZVcFpoV2tpMS9DQVg5VThOUC9nQm9ueG5FMTE5WitBclc4MXlzTDdqbGFo?=
 =?utf-8?B?M3BQbVR3VlBRZFJRemk2c3N6a1JuMGVqSzNHWDM1eEUyZkJsejRJdlQvS09O?=
 =?utf-8?B?K3dXZEFzWFFqL3QzZ3JOY3JMa1g5QVpEcHYxSnZzc1Y5dWtqNFdncVpvdWo0?=
 =?utf-8?B?T3liUlBZL0kzNHVrR3d3VUFzNXJqMkt5MU9XNm14T0g0TzR6dG1Bb3lzbTFL?=
 =?utf-8?B?VnE4NlhTdmxiRzYrYVpFcS9KVmdKZWZINEJMQW56NzdnRVdZMHhCQjd2aW84?=
 =?utf-8?B?US9QQ2luQmRBYnJmV096TDRLQWk4Wmp1NmlJbEU1NDc5Tmp5MWp0dzU1MHZo?=
 =?utf-8?B?K1pBS0hzZXd3UjhtSHFLMnpJNlJVMTU2Y2ZOeXZPb2FMUE9teW1EZ1V0c1lk?=
 =?utf-8?B?Z3VyK09xaHErM0NMaWVDNlVqOU44TUdzZGgyci9LbTN4c29aVEhIYWdZWVVq?=
 =?utf-8?B?V1Y5OU1jbkkxTkpwbkxLYzRQZWZnT3pibEFCQ0xPeW4wMStBZzRzQmswdjVk?=
 =?utf-8?B?dTA4T05iS1FYMHk4VFZqQmlweDVITkhvZi94NkdMQUxxUlNNcEZFS0tidGpH?=
 =?utf-8?B?UXZVeEIwcG9jampOc2FnNmd5d2IxRXFBTFVWcjB2ZDI5bW9CRGMwb0FjdG1p?=
 =?utf-8?B?dTl5V2M0d3FzUkVhNkZmUmxqTkxCRm13VzdmMFlZeUUyR3VCSE9xNUd0QUxP?=
 =?utf-8?B?N05jdGlCd3ZvVmU5ZjlUL1NrQzFzZCs2dmtkdS92TVZjeVliSlNWcU5OUGVk?=
 =?utf-8?B?OEUxUW82U2EwVC9JdTJqUVVXcDdzS2hDRzQ1Y3J2NEVHSGtJVDBiaUxQd0dL?=
 =?utf-8?B?ZEtDSklNMDhsaWF6ejF5TGQzL1lzM0c1TzNaQjRFV3B4RFNoL2FOT0JPVG9z?=
 =?utf-8?B?cnd6NGZPYy9vbnVHb21jaTFRVTI0VXZuRW9mMElPQVdTMkErQjVUUmtmaHNL?=
 =?utf-8?Q?bfKDrtSDZuVCHquCy76sAusDVwTv35/jxzpPw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWNEeHFBTktGSzN2MXlzYy9YL1VWNDk4YnRmOUJRYkVTdTY1anZ6NkNDU0Rw?=
 =?utf-8?B?ZXdDS2ptRldhbDZFRndFRXV1YnJiOFFMenFnV3RVaUVkWlV1N2FPa1g3S1kv?=
 =?utf-8?B?RVJjVEUrZ3QxYWRaa0JQUzB3QWpFdjgrdnFsZkJ0Y0VCaEtWZG5LK0hVazU2?=
 =?utf-8?B?WjZ2aGQ5NmVBeVhkdUNBS3JyT0N6VksyVEdIQ2pneEpLbU1SM2VOZnJEWTZZ?=
 =?utf-8?B?bVYzdFpaZ1g1VjltWTU0UW1TQ1ZvbEllM05sMHRDQUdZQ0s3ejJrV1FCT1cz?=
 =?utf-8?B?dnRKQnlXWjNVeSt4ZFZWL3V4R3FxdDgyR2lrSk1NUVIySzlXQi9MZXJtVWNj?=
 =?utf-8?B?UjF5K3pIYk9PMmxIY2wwMnpITXJiMnV2L0JHZnI5Nm4wRy9TVk9yRmRRaktQ?=
 =?utf-8?B?V0ZJQTNQQUFodUxrZ09iTHZLRU8xN0dvY1dhU3FoUms1NnNaeStseEtUMmNX?=
 =?utf-8?B?a2d3ZVZuZVR5amNPTXZyODU3dGFIZXBoekt1SlZJOTkyRlJpS1VUMnI1Q2RF?=
 =?utf-8?B?aWhpcnp6Z1pwVjFJYnhDZlcvN3kzRWxDS2djUFRjdVZYNXlTR1Y5dkt3NHRl?=
 =?utf-8?B?aGtKWVlpOHhoRnBwM0Z3ODZ6N1pEQ2xkdTQvV2JyOCtvT3g1cFRjMGZuSDBC?=
 =?utf-8?B?d2hob0F0MDF4VVdkTFEwT04raEhrVnFpR0NGa3VqaFNtc1NHY3VMOUdtbkVP?=
 =?utf-8?B?OUVFL2FJRGlZK3dGKzlCVEU5ZDFUcjQ0c0owTVlxL2VpU0VNb1FUeHp5cGFN?=
 =?utf-8?B?bGpFd2p4R3pQZFAyRi9YeHVmUENmampiOEsvTlREL25pWWoydTdqUTBhYlI2?=
 =?utf-8?B?bktlZnh3YlFSRmtvc1FZTkx3aDhyQURoSWlzNTZPbjdzVmpxd2tBYll4eXJX?=
 =?utf-8?B?ME40K2xPRURQQlFxN2l4R0p6b3pYWlFkczZPUldGYjhFZHVIUGZvWXE1NW1v?=
 =?utf-8?B?M3REdVlPZ3dkTlpXUE1DUW8vYXoxMTRlOTZYTy9zN2RpK3d2Z1dyRk0wTTBU?=
 =?utf-8?B?SC9qVklqYnp2MFZlZlc0bktlVjB4bWY3amZDU09SZE9Cc2hFQTV3c3prYmdP?=
 =?utf-8?B?ZEd6aUxvREorNWNHZHNBb3FscUZCbk04ek9udEJyendvQU9STm9PcUZWaXZn?=
 =?utf-8?B?WG9WbXl4cmVyRVgvUUp2T01KNytWRzdLd3JIYkJPQ042NGR0VlhBY3k3MERU?=
 =?utf-8?B?dTFtSC85ZC9iNGE4VzFJMkdRNDMyb0NicWpvWFlFeElCbnM1ZWZjOHFRYTJ0?=
 =?utf-8?B?K25WcXJ6dkpwZkM5YlVOWVZLd2FLaGZ4Snd4QTdoQzJXMFFxYytrdzMvSE5V?=
 =?utf-8?B?SzJ4TjRZOU9ZWGNxMmRmQy9YWGlvWFd2Q0tibHg0aUF2T1lEMDdRUERudGZs?=
 =?utf-8?B?T0FMSXRpTXVHb09DV2kvWUdMN2M4SHlMSDJ4Y1NlcjFUNjBEK3VDWExNWDE4?=
 =?utf-8?B?NDRscUxZR1cxSVhhOTlaNCtOdzZESnFFTk9jWjI2OFZLdnptaTZwektQckhH?=
 =?utf-8?B?aVhVYUFIbmZwNEdKU2JndXdsVGxjMGRmZXJWL2VtUXUvYnVKZFJpb1RKNDRD?=
 =?utf-8?B?VXBZTjdIYlhGb3J1UCt1cWRlcG5McGFmWm01M0pvb2hUV1V5VDBVaWw2Qnd6?=
 =?utf-8?B?ZnFzVGVHUXdka0kvNUx1MXBOSERFQ09pWDdlUURnVm1rQkdDTUVvcXBNbHZL?=
 =?utf-8?B?Tnk5VFA4ckhBZzVxcnVZdGM4ZTcwMzJVM3M4OTY2RHYrbmRMdHJtcUNWa0lL?=
 =?utf-8?B?ODRuekYvR2kyWlpaelVLcnEwdlVneHdLVTlBWUdZc3VOd0d1cnc5OFBDTkcv?=
 =?utf-8?B?T3RRekhicys0MFBMU0VlNnl4blF5Z09jK21QcDNSNFUvNmdqdXc4cXNFYjJS?=
 =?utf-8?B?UEhQa1BLOHRnVklzd3lXUlcrUEphdWFXN3FhbzljN1ovOHkvdWs1ak54ZTFB?=
 =?utf-8?B?VXdDYTZzUnhqSW5xb2NtMHRxOFdBamorVjVFV2gvSkt1bXppejJwUVVOUzVH?=
 =?utf-8?B?SWVRalJsNWtFMDVndElGMGJMb1Z4T3NRa1FIRjVwSDYrVDRIOFFXR3hPUTBv?=
 =?utf-8?B?TThQT040S0c3UU1YcEhzeXlEYmJQYkxLNXR4M0Zvd1QxcjBrMzB4VWtJOVJZ?=
 =?utf-8?B?cXFYODJSTWU4Z0xuNGdGREd3SjA3VmVUd1Zsd3FjOVg0b1U1K3dlUDJtSndJ?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9580B0EEF97AED459A0E9F96A3CD3E4B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afcdc1ba-0978-4339-2467-08dc84746c72
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 08:57:55.0241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q5iigEUWpAKoG54gSrtBg0iLNjPw+haXTwJZrG+X1vJG7XnDNtyohGG1TUgYOiAb+C1iTIHKv9lwRDh4w6VHIAQFlTL/qyHn2Gh51ai/NVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8800

T24gTW9uLCAyMDI0LTA2LTAzIGF0IDIwOjQwICswMTAwLCBEYW5pZWwgR29sbGUgd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgT24gTW9uLCBKdW4gMDMsIDIwMjQgYXQgMDg6MTg6MzRQTSArMDgwMCwg
U2t5IEh1YW5nIHdyb3RlOg0KPiA+IEZyb206ICJTa3lMYWtlLkh1YW5nIiA8c2t5bGFrZS5odWFu
Z0BtZWRpYXRlay5jb20+DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IG10Nzk4eF8ycDVnZV9waHlf
Z2V0X3JhdGVfbWF0Y2hpbmcoc3RydWN0IHBoeV9kZXZpY2UNCj4gKnBoeWRldiwNCj4gPiArICAg
ICAgcGh5X2ludGVyZmFjZV90IGlmYWNlKQ0KPiA+ICt7DQo+ID4gK2lmIChpZmFjZSA9PSBQSFlf
SU5URVJGQUNFX01PREVfWEdNSUkgfHwNCj4gPiArICAgIGlmYWNlID09IFBIWV9JTlRFUkZBQ0Vf
TU9ERV9JTlRFUk5BTCkNCj4gPiArcmV0dXJuIFJBVEVfTUFUQ0hfUEFVU0U7DQo+ID4gK3JldHVy
biBSQVRFX01BVENIX05PTkU7DQo+IA0KPiBBcyB0aGUgcGh5IGlzIGFsd2F5cyBjb25uZWN0ZWQg
aW4gdGhlIHNhbWUgd2F5IGludGVybmFsbHkgaW5zaWRlIHRoZQ0KPiBNVDc5ODgNCj4gdGhpcyBj
aGVjayBhbmQgZGVzdGluY3Rpb24gZG9lc24ndCBtYWtlIHNlbnNlIHRvIG1lLg0KPiANCj4gSW1o
byB5b3Ugc2hvdWxkIGFsd2F5cyByZXR1cm4gUkFURV9NQVRDSF9QQVVTRSwgdW5sZXNzIHRoZSBz
YW1lIFBIWQ0KPiBhbHNvDQo+IGV4aXN0cyBpbiBvdGhlciBTb0NzIGFuZC9vciBpcyBjb25uZWN0
ZWQgaW4gZGlmZmVyZW50IGludGVyZmFjZQ0KPiBtb2Rlcy4NCj4gDQo+IEluIGFueSB3YXksIHBs
ZWFzZSBleHBsYWluIHRoaXMgcGFydCB0byB1cywgZXNwZWNpYWxseSBpbiB3aGljaA0KPiBzaXR1
YXRpb24NCj4gZXhhY3RseSB5b3Ugd2FudCB0byByZXR1cm4gUkFURV9NQVRDSF9OT05FIGFuZCBm
b3Igd2hpY2ggcmVhc29uLg0KPiANCiAgQWN0dWFsbHkgaW50ZXJuYWwgMi41R3BoeSBpcyBwbGFu
bmVkIHRvIGJlIGNvbm50ZWN0ZWQgdG8gYm90aCBYRkktTUFDIA0KYW5kIEdNQUMgYXQgdmVyeSBm
aXJzdDogKDIuNUcgc3BlZWQgcmVsaWVzIG9uIFhHTUlJIHBhdGggYW5kDQoxRy8xMDBNLzEwTSBy
ZWx5IG9uIEdNSUkvTUlJIHBhdGgpDQorLS0tLS0tLS0tKyAgICAgICArLS0tLS0tLS0rDQp8ICAg
ICAgICAgfCAgICAgICB8ICAgICAgICB8DQp8IFhGSS1NQUMgfCAgICAgICB8ICBHTUFDICB8DQp8
ICAgICAgICAgfCAgICAgICB8ICAgICAgICB8DQorLS0tLS0tLS0tKyAgICAgICArLS0tLS0tLS0r
DQogICAgICAgIHwgICAgICAgICAgIHwNCiAgICAgICAgfCAgICAgICAgICAgfA0KICAgICAgKEZD
TSkgICAgICAgICB8DQogICAgKy0tLS0tLS0rLS0tLS0tLS0tLSsNCiAgICB8IFhHTUlJIHwgR01J
SS9NSUkgfA0KICAgICstLS0tLS0tLS0tLS0tLS0tLS0rDQogICAgfCAgICAgICAgICAgICAgICAg
IHwNCiAgICB8ICAgICBidWlsdC1pbiAgICAgfA0KICAgIHwgICAgICAyLjVHcGh5ICAgICB8DQog
ICAgfCAgICAgICAgICAgICAgICAgIHwNCiAgICArLS0tLS0tLS0tLS0tLS0tLS0tKw0KICBUaGlz
IHBoeSdzIHJhdGUgYWRhcHRhdGlvbiBpcyBpbXBsZW1lbnRlZCBpbiBGQ00gKGZsb3cgY29udHJv
bA0KbW9kdWxlKSBvbiB0aGUgWEdNSUkgcGF0aC4gU28gbXQ3OTh4XzJwNWdlX3BoeV9nZXRfcmF0
ZV9tYXRjaGluZygpIHdpbGwNCm9ubHkgcmV0dXJuIFJBVEVfTUFUQ0hfUEFVU0UgZm9yIHRoaXMg
cGF0aC4oZm9yIGRldmVsb3BpbmcgcHVycG9zZSkNCiAgSG93ZXZlciwgR01JSS9NSUkgaXMgZGVw
cmVjYXRlZCBsYXRlciBpbiBvdXIgYnVpbHQtaW4gMi41R3BoeQ0KaGFyZHdhcmUgZGVzaWduLiBT
byB5ZXMsIHlvdSdyZSByaWdodC4NCm10Nzk4eF8ycDVnZV9waHlfZ2V0X3JhdGVfbWF0Y2hpbmco
KSBzaG91bGQgYWx3YXlzIHJldHVybg0KUkFURV9NQVRDSF9QQVVTRSBub3cuIEknbGwgY2hhbmdl
IHRoaXMgaW4gbmV4dCB2ZXJzaW9uLg0KDQpTa3kNCg==

