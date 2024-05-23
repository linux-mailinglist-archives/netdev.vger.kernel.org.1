Return-Path: <netdev+bounces-97749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B028CCFE3
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 12:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 995F2B212F3
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 10:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9F2140E58;
	Thu, 23 May 2024 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Kfnv0LYp";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="dJtJxsGJ"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DF113CF96;
	Thu, 23 May 2024 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458656; cv=fail; b=fuP/LzLcd3ree2ym9hK21DII6GG/oA0E5yu4JQFWM4vTe0T9qMDktWxFJocRqqZtWJpsAOB2rYisn950JfXgq7lx4+r3dvrFH/28m5dQGwblJYJnz1E5QsHqSvlwjzn03MZDFkf9utNNy1gGDUiUHHjez7YOjyqjMa8Y1/8fsOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458656; c=relaxed/simple;
	bh=APuUC9cylmsFGkLdYam+ctmnSWOcb/SELbuMYhX+jC0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f4D1UHHwVtusxGzb+HE3JOT6zclZuIz+GbUnUdvDsNaRB6Ize9zC1zfMvO0orfCjROhRCK+urA1DLURFNw0s5uQ0dNEwwnfzHLHf8DnP6gGcghr71eM6ES9J9vQU9fKlQpeMejsLNqCb7OjcvNQGlsAD2CYpdZVAWUw6Qnd7UUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Kfnv0LYp; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=dJtJxsGJ; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c688aa5218eb11ef8c37dd7afa272265-20240523
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=APuUC9cylmsFGkLdYam+ctmnSWOcb/SELbuMYhX+jC0=;
	b=Kfnv0LYpT/kHCjtA2yaFOGn7WU7twXuYo5yvz2ALM3XcHPJI34LeF3dQ3NFv7X7uChkPZ8fmI1jE+w5zKol5CQccS8v0PVVCveBNghccnFIn9QDRG4JhWYNhFto5G2BhFdXyTXmMm8ZZ2uHRzBO9Uxu2sq7nEkNivpa06sz8oPc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:266e6300-0635-4a63-a04d-ac797bf54093,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:82c5f88,CLOUDID:e0d01f93-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: c688aa5218eb11ef8c37dd7afa272265-20240523
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2036969501; Thu, 23 May 2024 18:03:59 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 23 May 2024 03:03:58 -0700
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 23 May 2024 18:03:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djDj7wAC9LIid7eX9ZntDM1YEtVMjVMkpo4BDa4/ZfraQHfXUYQaY4fT3B7l+8J78by2816t1V4YhaZo5MTn9RIjslHqG+Hsk3iJbdlJMGJBemPvJn7yy7Gm3EWhEcpSyxndvg7zftaQhINA10gw1Il+2Ny34Q842cIaQlBpTILMOkR40oiLWyc9pQ4nPNnWtdsEAwdSg85iqeM9lODFZcrgYmh5GluJ2XX3YlrPZrVJRV0sPTg9UaoszjHJaN/QmUyBkYAH8sU+1nF4dW8swEzZkw2tkz87CkFWNNSjxSDoGnizNLOle06AcR26YSQq7oLPzXUMM/z+qWEuSxizOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APuUC9cylmsFGkLdYam+ctmnSWOcb/SELbuMYhX+jC0=;
 b=A2NppmeIKNy3lVftg5pfs121lVgmsamYQHVTQ/zRLUpDqh5U6s/u+Fkp2Vi3LSHE9lxcdG53EmNO0uZstozATuubBT4nEl20rT0EBYaZowdXUui0CmxgYjW9NondAZfCtkLa59ftxvdPonX9F5OfQ1jYK3PfDzXjOWJfiGMx2dNrKgMZLrPKZowq7+rZy7We/I3jg7aLfH7NruumYdI98T4p5uPk0DATt8zJy7Se5iHsSeARup5nyZUCSdFEQS+K7KfokWk/zbsBpevLdNBT7X2m4DdNb0XSIwln1E+hjKSSPWyV1kZM4IESXV/czR8XEmXZP6FsK18ZRmjn3vSPbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APuUC9cylmsFGkLdYam+ctmnSWOcb/SELbuMYhX+jC0=;
 b=dJtJxsGJBz2irSTibrdldKnXe908XUw1uv73kozRl2FZ1Ehk5KANkt4eaRvvfaQsTDzovv3Tj+LHjly0pE3dpbW7xC/cHCyg2AA8FTBC6Bxw7NIVeMbXF8ALTwkXALCOMVdugx7ZpAe68s+88T1/r912Lbb08yxPa4PIuYJxB00=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by TYSPR03MB7784.apcprd03.prod.outlook.com (2603:1096:400:42a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.16; Thu, 23 May
 2024 10:03:55 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::54f:1c26:8bd1:5824]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::54f:1c26:8bd1:5824%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 10:03:55 +0000
From: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?=
	<Shiming.Cheng@mediatek.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net] net: prevent pulling SKB_GSO_FRAGLIST skb
Thread-Topic: [PATCH net] net: prevent pulling SKB_GSO_FRAGLIST skb
Thread-Index: AQHamXh3SQ+1lKsnl0u0DlYO3sGEgbF/Qx+AgBjXXoCAAfkjAIAKqqeA
Date: Thu, 23 May 2024 10:03:55 +0000
Message-ID: <15675c6e0facd64b1cdc2ec0ded32b84a4e5744b.camel@mediatek.com>
References: <20240428142913.18666-1-shiming.cheng@mediatek.com>
	 <20240429064209.5ce59350@kernel.org>
	 <bc69f8cc4aed8b16daba17c0ca0199fe6d7d24a8.camel@mediatek.com>
	 <20240516081110.362cbb51@kernel.org>
In-Reply-To: <20240516081110.362cbb51@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|TYSPR03MB7784:EE_
x-ms-office365-filtering-correlation-id: 81d9476e-3a28-4feb-aa67-08dc7b0fa83e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Ti9qR1RCWm1ZVk9TNHZwb1dEai9pU2NWKzViOEJOSHI0YzJIbGtJNWtnbnpO?=
 =?utf-8?B?MFlUMTNxRk5HazBBalpta1cxRVprYUhIYXBRV0h0emQ3UVRvU0FCeEZKOFIv?=
 =?utf-8?B?SkYrQU5BREY3TlFHSWhUdlloS2ZPK2RhQ2YrYzc3KzJNS2ZtSHhtNllKcVhF?=
 =?utf-8?B?TGIyMm85Uk9XdElnQytxMFRnRGVFd1l6bmN1cDBFVXVpUU13azZOR041Wm1u?=
 =?utf-8?B?ZGhKYVZuU2JZWTczZDNWSGhvQlJONDBxRTB6QlBnb3FjeDJ4TlpMb1ZnSWNF?=
 =?utf-8?B?OHh1aHZVd3dSNkRSVDF2eTUyWGtmTmR2SXozZkxaMXZrcWlJMG5IUUgydEdP?=
 =?utf-8?B?N3RGRk9OV0lMdGFpVXpkTzBKcW96K3NwbVVBWkVaYnhybjJQM1psc24xQ1FO?=
 =?utf-8?B?M3gwMGp2WXIvczF2dlZHRE1oL0ZGaCt5SzRESURZVFZScmJiZm5LWFRwUVow?=
 =?utf-8?B?MWJ2L0tzYzQwVTVubTN1Tzh5RWpheHlteVpPVERHWUlDbkJENmNjL3pxS05Q?=
 =?utf-8?B?K3dJSmVmdzJQOWNkalZoSS9acUpEbVBONGRKaWQ5L0c3eC95aS9MbUJ4b2Ni?=
 =?utf-8?B?WEt2SGJtS0ZHR3gwbFRWMmZuek4rMmtuSFpETnk0dm5aOHBxUzdLeFN2Y0tn?=
 =?utf-8?B?TmFBdWw5emh1UzYrbGRNNjEwSm45VjRPemVXSkpRb24vdHFPajdXV05pNVc0?=
 =?utf-8?B?aU1XTi9ld0lnUXk0bmdmOWVmd1B4TWg1bld4Z3VTczhtMXF1WEEwZFdLbjdR?=
 =?utf-8?B?VW1aeU85SFhwR1hpdnhlR014K2psRlQ1eGMxZTFESmFXRXAzdkFWamJ0S2FP?=
 =?utf-8?B?cHNyWnBMdXBOOFlXMHVqSURZRC93b2dlbXFVcXFBaGI4ZkI3Ly9QbmtQcGdH?=
 =?utf-8?B?Nk5yWEdZd25ncUNCcWhHdDJQU3E0a1VDT08zblRxa28rQndCckoxcFF1WkRo?=
 =?utf-8?B?azJDRGN4ZWphMHhhU0dqM3UzREV2YW1za0d3VVY0QkZuWWx5QTQrTDVpemxJ?=
 =?utf-8?B?VGFEMkhCY0IwN2cyK3pMTTBsUWtUaXM3TEltbmJwOWYxQ21OUnR4UnMvYllW?=
 =?utf-8?B?NEV4TkUweHJydHFXdEsxWlNKdVFmZkc2YlBNY054cVErRjZremRpeC9mTWdw?=
 =?utf-8?B?ampzZkFIV29IemFPalEzLzNlZk9FZVNyTGVCdUNNbkNUbEc2Rno4bGNteVVh?=
 =?utf-8?B?eGFLaUxlR1lNaldQc3BnNmFNWElZSk5IazJVUUIvVzY5aGtvemdFQjJVZ1dp?=
 =?utf-8?B?UnFObHBSbitzcyt6Q2RzMEhxRVBVdm1PbVFpR1RkU3VMb3pYaUdSSkQ4MjZF?=
 =?utf-8?B?NzdYS3QyZURFVVYrWFp1SjFHLzcxekpyYjh6YWYxYm1tYnJNM0w2NVd6SFh2?=
 =?utf-8?B?STZZRFhKSmE5bUtoNW91TjdXanRrZ05vdTNBWEVrRTk1ZGV1NUFvL0Jta1Ni?=
 =?utf-8?B?QklvYk52Y25IY0RvcTdLa3RpRXdHcGV4a2lhaUI2U29sSU8xMno4WXFiY1FX?=
 =?utf-8?B?Z1UwVlB2VUJzRWFjQWlhU0docndjRCtZK0w3WGp5OFc5VW9wZ2c3VzdhSXFI?=
 =?utf-8?B?UjJlczhNQkxWWXpsSFJOYm9tMWRwTmVhWjJ2QS94NnB5NXRRL2d4d2JVZlNx?=
 =?utf-8?B?b0lURGd6d0lBQWNCNHk4WThZZFFQZFVuUm1SZVRyK2FFTmRDdE1OSk1zMWZE?=
 =?utf-8?B?ZUxaWXY5aTU0MnVzODYwMnJldU9SOVliUjY4R3FjWUoxd0ZVSVR1R2N1N0RD?=
 =?utf-8?Q?2FFu4xPteNBaBXGPkM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEx2K3c4dGwrNTNtMnk1UWtkaFRUYWczVEZVc2tJMzNDdUhERDVCSnJBaDRU?=
 =?utf-8?B?Q01TREo4cThZaDUwZElvcjljc1pPVDM1V0IySkllNFM5eS8vMXF4VzRzYnFE?=
 =?utf-8?B?TS9BNCt5RmQwYlZTUDlRYnVXbVArNDZhQW4rVGtGR1JXaUlvV2plRUtFcU52?=
 =?utf-8?B?aUxsMmF4SXBvWnNNTjF3NnRuUVhpZGZXWW5NOFJXb3hqS1ExY1BXNC9walNw?=
 =?utf-8?B?RmhndFVtZWpqdk91QWx4MGV6ZWR1cnhIN1FIMWE4aStSR1AxWGZRNWpTOHdG?=
 =?utf-8?B?MUFSN1pBQUJRZXl4MkFjZUU5Myt4enUvZVFod3h6OFJGeFJ1UFlyczNBdmg2?=
 =?utf-8?B?TUMva1VORGlZdFl4Y3ZkY2hCUnZVdUF1Wnl4ZlV6dDV4ZWhKQlJhRE0zdGpp?=
 =?utf-8?B?NkFmbHNFZTNsTGlpemYyZ1lhRjg5aDZNNlhNZy9tQStwdDVKMER2SFFtZmpE?=
 =?utf-8?B?NStJSVlaa2dhdHNzRStYOHhSL05IOGpneHduTS8vejV0WHhXSFUwNXpySVpG?=
 =?utf-8?B?WlNBK2xQL3J5cXpTcEJYRGZveW5aWVpGbC9GQWhCODNpa1VQR1JUZ0ExMVhD?=
 =?utf-8?B?UU9tNnZZWlROdksxK0VsZWl4NmhQTGNSSU4yZUJ2bWNKdUF1RGRlREdxK2NV?=
 =?utf-8?B?TmtYRUNNWDhiUTBQTlRVU0tZN0VtNW9SMTZoWU1TblAzM3hmanROOTY3cWV2?=
 =?utf-8?B?L3ZWQmFMMi9qcnVwSk9xbDZNbmZFa01DeGgxbFVDMzhydEtOdnJLWTZYdlND?=
 =?utf-8?B?TkdZWlYxK0tiSWJRenhtRmRUdzRHOTJvQXdUYnJXRXVxRkxwRStQelllK2Jo?=
 =?utf-8?B?MWt5aE1wVlc0dlNadXBVK3lZcjhiZ3I0dGtBaWEvTmVLMk5BN0xrMUJSWTNq?=
 =?utf-8?B?SEJkeGtkcXFyRnAxWDhJU0o4ZFhsc3RDajhYQzRxNHE4bU03QVRJRGpPVVMw?=
 =?utf-8?B?VGFuTGFnZFg5QTg3UERjZDBoaUQ5dDNrZS92THd2VjhMRnp2YSsxQUNzY1Fm?=
 =?utf-8?B?dGwzWGhZdEV1OEo3Uk96WjJmenBxd1ozNlhyVTdFeXBuajA2WWR5N2NzaHF3?=
 =?utf-8?B?ZU5WcERCUlJ3ZEVJTlFDSGluRklDTlYzSnpYMEFyYkVOaExlOXora3ZBaWFs?=
 =?utf-8?B?WjBMYVVuQW0wS3FNQ2hQUEx4bFdwMTRIVWVTNmdweXZtOUZEZGQxd1FGOWtW?=
 =?utf-8?B?NFVsWUZlTWtWMTd5OTBnbjlkb0VqVlpaNytHK0lMSlB1N3hMZFlUZ2w1bGw0?=
 =?utf-8?B?aTBmeVM2clh0WWdhY05ZR0R2RDVzL2pZWWtCYVJGbGJBcTlQQlFxenFORUhE?=
 =?utf-8?B?NEcvQlR3bmM0S3pLaFV5ZXA3bjhscm95OGwvRVJOTTVJSWRsb2xmc2QrMU5O?=
 =?utf-8?B?eFFzNkduYTZYRXJnOVI3T0tPMU5lN1l1Tis4QU1yU0JWNDZLeEkvemNzVjJt?=
 =?utf-8?B?STQyeEk2OFdoMlNaSW9DV3dQYWJtQWN6ZG9pK1FBY3VPYXMvNGV4emF3Rk11?=
 =?utf-8?B?R21DQitTUlZjZ0ZHNW90MXF3WFU2ZmM4Q0xYazBScjZJYVdvNC9BQUlIamFT?=
 =?utf-8?B?MHJ0NWhsM0tpY1VuM1BQbXRxT1QyRGtoZ096T2ZmSzdqOUhaWi9mVFJUdUNh?=
 =?utf-8?B?Vi9KTVVmYlFOY01RWGFwcnpCWkJneDNlR0VmQ0dyQnpGUExnUk14UVFxa1R0?=
 =?utf-8?B?WjhReUowc3JDeENrdTMwd3locENZZzB1UVo2RnJ1a1pCOXZBNnd5dlFkNEk5?=
 =?utf-8?B?aTF6aldMRFI5NXF6SlhDamFOSG5mUkJRbGV2VGZPblE4YXZDaWY1K0JwUndx?=
 =?utf-8?B?cTlNYm5SU0sybVVERm42UUNzUk5Qc0FhR1MzakNEeFgzUU1YdnczckFuWk9u?=
 =?utf-8?B?UVdTMm1sVU5BR3dkcnQrdE00UHZuTmV5OEFLSXoyZFdhd0NLd3VvNHRrdEZm?=
 =?utf-8?B?eTdvQW94VkkvSndveDFTdnQ3THd1Q0xWTUcxckcxSGdILzY3WUNlK3BwcGZ2?=
 =?utf-8?B?VmxEdTlLNE5MTmx1NXM3V2V3WXRyRTduQ1Z1VWdvd0pucndzZWIwMlpiNFBn?=
 =?utf-8?B?TmsyRFNxMFlEZjRxakFOTElsejd3RkRxNmhPOS9OWHN5cEs5eU5RcGJCa04r?=
 =?utf-8?B?S09ka09WdlIzUTBlWEhoSjBPcmlpNHE0T2R5OEZvRm94U2I0MFRVYlNtbE0v?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52C085CF0242DC4AA3BE62358979365D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d9476e-3a28-4feb-aa67-08dc7b0fa83e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 10:03:55.6585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4R46yJ/M75DCbgmMtC6/om9RWT0qFNMEXwKSSKvtiGQses43ZkjMVQIYb+CTeNTJ7UxVzZHANHDpUzf1jdWXIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7784

T24gVGh1LCAyMDI0LTA1LTE2IGF0IDA4OjExIC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+ICBPbiBXZWQsIDE1IE1heSAyMDI0IDA5OjAyOjM1ICswMDAwIExlbmEg
V2FuZyAo546L5aicKSB3cm90ZToNCj4gPiA+IE9uZSBvZiB0aGUgZml4ZXMgeW91IHBvc3RlZCBi
cmVha3MgdGhlDQo+ID4gPiANCj4gPiA+ICAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L3Vk
cGdyb19md2Quc2gNCj4gPiA+IA0KPiA+ID4gc2VsZnRlc3QuIFBsZWFzZSBpbnZlc3RpZ2F0ZSwg
YW5kIGVpdGhlciBhZGp1c3QgdGhlIHRlc3Qgb3IgdGhlDQo+IGZpeC4gIA0KPiA+IA0KPiA+IERl
YXIgSmFrdWIsDQo+ID4gU29ycnkgZm9yIGxhdGUgcmVzcG9uc2UuDQo+ID4gQXMgd2UgZG8gbm90
IG1ha2Ugc2VsZnRlc3QgYmVmb3JlLCBJIHRyeSB0byBidWlsZCBhIHRlc3QgZW52aXJvbm1lbg0K
PiBhbmQNCj4gPiBjb3N0IHRpbWUgdG8gYXBwbHkgc3VkbyBhY2Nlc3MgcmlnaHQgaW4gb3VyIGNv
bXBhbnkgc2VydmVyLg0KPiANCj4gUGxlYXNlIHJlYWQ6DQo+IA0KaHR0cHM6Ly9naXRodWIuY29t
L2xpbnV4LW5ldGRldi9uaXBhL3dpa2kvSG93LXRvLXJ1bi1uZXRkZXYtc2VsZnRlc3RzLUNJLXN0
eWxlDQo+IA0KPiBEZXBlbmRpbmcgb24geW91ciBzZXR1cCBzdWRvIG1heSBub3QgYmUgbmVlZGVk
Lg0KPiANCj4gPiBOb3cgaXQgYmxvY2tzIHRvIGdlbmVyYXRlIHhkcF9kdW1teS5icGYuby4gQ291
bGQgeW91IHBsZWFzZSBnaXZlDQo+IHNvbWUgZ3VpZGxpbmUNCj4gPiBhYm91dCB0aGUgc2NyaXB0
IHRlc3Qgc3RlcD8gVGhhbmtzLg0KPiANCj4gSW5zdGFsbCBjbGFuZyBhbmQgcnVuIG1ha2U/IFBs
ZWFzZSBzaGFyZSBzb21lIG91dHB1dHMgb3IgbW9yZQ0KPiBkZXRhaWxzLA0KPiBJJ20gbm90IHN1
cmUgd2hhdCB0aGUgcHJvYmxlbSBpcw0KPiANCj4gPiBDb3VsZCB5b3UgZ2l2ZSBtb3JlIGluZm8g
YWJvdXQgdGhlIGZhaWxlZCBzaXR1YXRpb24/ICANCj4gPiBJcyBpdCB0aGlzIGZpeCAiW1BBVENI
IG5ldF0gbmV0OiBwcmV2ZW50IHB1bGxpbmcgU0tCX0dTT19GUkFHTElTVA0KPiBza2IiDQo+ID4g
ZmFpbGVkPw0KPiA+IFdoaWNoIGNhc2UgaXMgZmFpbGVkPw0KPiANCj4gVGhlc2UgYXJlIHRoZSBy
ZXN1bHRzLCBhcyBmYXIgYXMgSSBjYW4gdGVsbDoNCj4gDQo+IA0KaHR0cHM6Ly9uZXRkZXYtMy5i
b3RzLmxpbnV4LmRldi92bWtzZnQtbmV0L3Jlc3VsdHMvNTczMjAwLzI0LXVkcGdyby1md2Qtc2gv
DQo+IA0KPiA+IElzIGl0IHBvc3NpYmxlIHRoYXQgdGhlIHRlc3QgY2FzZSBoYXMgaXNzdWU/DQo+
IA0KPiBFbnRpcmVseSBwb3NzaWJsZSwgeWVzLg0KDQpEZWFyIEpha3ViLA0KVGhhbmtzIHlvdXIg
Z3VpZGVuY2UuDQpJIGhhdmUgc2V0IHVwIHRoZSB0ZXN0IGVudmlyb25tZW50IGFuZCBwYXJ0IG9m
IHRlc3QgY2FzZXMgY291bGQgcGFzcy4NCg0KVGhlIHByb2JsZW0gbm93IGlzIHRoZSBldGh0b29s
IGluIHVidW50dSBjYW4ndCBzdXBwb3J0ICJyeC1ncm8tbGlzdCINCmFuZCAicngtdWRwLWdyby1m
b3J3YXJkaW5nIiBhbHRob3VnaCBpdCBpcyB1cGRhdGVkIHRvIHZlcnNpb24gNi43IGZyb20gDQpo
dHRwczovL21pcnJvcnMuZWRnZS5rZXJuZWwub3JnL3B1Yi9zb2Z0d2FyZS9uZXR3b3JrL2V0aHRv
b2wuIA0KDQpUaGVyZSBpcyBhbm90aGVyIHZlcmlzb24gaW4gDQpodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9uZXQv
ZXRodG9vbC4NCiBXZSBkb3dubG9hZCB0aGUgc291cmNlY29kZSBidXQgZG9uJ3Qga25vdyBob3cg
dG8gY29tcGlsZSBmb3IgdWJ1bnR1IGFzDQpubyAuL2NvbmZpZ3VyZSB0aGVyZS4NCg0KSXMgaXQg
dGhlIG9uZSB3ZSBzaG91bGQgdXNlPyAgSWYgeWVzLCBjb3VsZCB5b3UgcGxlYXNlIHNob3cgbWUg
aG93IHRvDQpjb21waWxlIGFuZCBpbnN0YWxsIHRoaXMgZXRodG9vbD8NCg0KQmVsb3cgYXJlIG15
IHRlc3QgcmVzdWx0IHdpdGggY3VycmVudCBldGh0b29sIG5vdzoNCg0KSVB2NA0KTm8gR1JPICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBvaw0KZXRodG9vbDogYmFkIGNvbW1hbmQg
bGluZSBhcmd1bWVudChzKQ0KRm9yIG1vcmUgaW5mb3JtYXRpb24gcnVuIGV0aHRvb2wgLWgNCkdS
TyBmcmFnIGxpc3QgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmFpbCAtIHJlY2VpdmVkIDEw
IHBhY2tldHMsDQpleHBlY3RlZCAxDQouL3VkcGdyb19md2Quc2g6IGxpbmUgMjMxOiByeC11ZHAt
Z3JvLWZvcndhcmRpbmc6IGNvbW1hbmQgbm90IGZvdW5kDQpHUk8gZndkICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGZhaWwgLSByZWNlaXZlZCAxMCBwYWNrZXRzLA0KZXhwZWN0ZWQg
MQ0KVURQIGZ3ZCBwZXJmICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVkcCByeDogICAgIDc3
IE1CL3MgICAgNjMwMjQNCmNhbGxzL3MNCnVkcCB0eDogICAyMDk5IE1CL3MgICAgMzU2MDMgY2Fs
bHMvcyAgMzU2MDMgbXNnL3MNCnVkcCByeDogICAgIDg5IE1CL3MgICAgNzMwMTEgY2FsbHMvcw0K
dWRwIHR4OiAgIDIwOTAgTUIvcyAgICAzNTQ1OSBjYWxscy9zICAzNTQ1OSBtc2cvcw0KdWRwIHJ4
OiAgICAgODIgTUIvcyAgICA2Njc5OSBjYWxscy9zDQp1ZHAgdHg6ICAgMjEwMCBNQi9zICAgIDM1
NjIxIGNhbGxzL3MgIDM1NjIxIG1zZy9zDQouL3VkcGdyb19md2Quc2g6IGxpbmUgMjM5OiByeC11
ZHAtZ3JvLWZvcndhcmRpbmc6IGNvbW1hbmQgbm90IGZvdW5kDQpVRFAgR1JPIGZ3ZCBwZXJmICAg
ICAgICAgICAgICAgICAgICAgICAgdWRwIHJ4OiAgICAgNDcgTUIvcyAgICAzOTA1Mg0KY2FsbHMv
cw0KdWRwIHR4OiAgIDE2NTQgTUIvcyAgICAyODA1OSBjYWxscy9zICAyODA1OSBtc2cvcw0KdWRw
IHJ4OiAgICAgNzEgTUIvcyAgICA1ODEwMiBjYWxscy9zDQp1ZHAgdHg6ICAgMTkzMiBNQi9zICAg
IDMyNzc0IGNhbGxzL3MgIDMyNzc0IG1zZy9zDQp1ZHAgcng6ICAgICA4NSBNQi9zICAgIDY5OTc2
IGNhbGxzL3MNCnVkcCB0eDogICAyMDk0IE1CL3MgICAgMzU1MjQgY2FsbHMvcyAgMzU1MjQgbXNn
L3MNCi4vdWRwZ3JvX2Z3ZC5zaDogbGluZSAyNDQ6IHJ4LWdyby1saXN0OiBjb21tYW5kIG5vdCBm
b3VuZA0KR1JPIGZyYWcgbGlzdCBvdmVyIFVEUCB0dW5uZWwgICAgICAgICAgICBmYWlsIC0gcmVj
ZWl2ZWQgMTAgcGFja2V0cywNCmV4cGVjdGVkIDENCi4vdWRwZ3JvX2Z3ZC5zaDogbGluZSAyNTE6
IHJ4LXVkcC1ncm8tZm9yd2FyZGluZzogY29tbWFuZCBub3QgZm91bmQNCkdSTyBmd2Qgb3ZlciBV
RFAgdHVubmVsICAgICAgICAgICAgICAgICAgZmFpbCAtIHJlY2VpdmVkIDEwIHBhY2tldHMsDQpl
eHBlY3RlZCAxDQpVRFAgdHVubmVsIGZ3ZCBwZXJmICAgICAgICAgICAgICAgICAgICAgdWRwIHJ4
OiAgICAgNDUgTUIvcyAgICAzNzA3NQ0KY2FsbHMvcw0KdWRwIHR4OiAgIDEwNzAgTUIvcyAgICAx
ODE0OSBjYWxscy9zICAxODE0OSBtc2cvcw0KdWRwIHJ4OiAgICAgNTUgTUIvcyAgICA0NTM5NiBj
YWxscy9zDQp1ZHAgdHg6ICAgMTA3MCBNQi9zICAgIDE4MTU5IGNhbGxzL3MgIDE4MTU5IG1zZy9z
DQp1ZHAgcng6ICAgICA1NSBNQi9zICAgIDQ1MDMyIGNhbGxzL3MNCnVkcCB0eDogICAxMDc1IE1C
L3MgICAgMTgyMzMgY2FsbHMvcyAgMTgyMzMgbXNnL3MNCi4vdWRwZ3JvX2Z3ZC5zaDogbGluZSAy
NjM6IHJ4LXVkcC1ncm8tZm9yd2FyZGluZzogY29tbWFuZCBub3QgZm91bmQNClVEUCB0dW5uZWwg
R1JPIGZ3ZCBwZXJmICAgICAgICAgICAgICAgICB1ZHAgcng6ICAgICA0NSBNQi9zICAgIDM3NDQw
DQpjYWxscy9zDQp1ZHAgdHg6ICAgMTA2NSBNQi9zICAgIDE4MDc4IGNhbGxzL3MgIDE4MDc4IG1z
Zy9zDQp1ZHAgcng6ICAgICA3MCBNQi9zICAgIDU3NTEyIGNhbGxzL3MNCnVkcCB0eDogICAxMDY2
IE1CL3MgICAgMTgwOTEgY2FsbHMvcyAgMTgwOTEgbXNnL3MNCnVkcCByeDogICAgIDY4IE1CL3Mg
ICAgNTU0MzIgY2FsbHMvcw0KdWRwIHR4OiAgIDEwNjcgTUIvcyAgICAxODExMCBjYWxscy9zICAx
ODExMCBtc2cvcw0KDQpUaGFua3MNCkxlbmENCg==

