Return-Path: <netdev+bounces-100083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEFE8D7CA6
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A472843FD
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 07:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98621487BF;
	Mon,  3 Jun 2024 07:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qz50G6Nt";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="IcXrOF7d"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BCE482D8;
	Mon,  3 Jun 2024 07:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717400508; cv=fail; b=eBrLHqiCSlOjNYyHkrbfXuFoG1kqI+CwS9Jxkjp89C79xKz6+neWBvI24ecJ4L127S9qjvU8ZQE7EzcN3blC9K1oNoh4wG+4G/1tkYwXhn4ZtZtir6UgoYjAw7/FJSzf2TiE7PVfBBY+ySowthChMJEAKOAqWYbF+tvnaFdyLZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717400508; c=relaxed/simple;
	bh=zxHF8r8ISl52P4oMUucVdP34rrhjHqzpH7eAkjQrL04=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y3SFL8jsW7VyrVOauVoWOlVEMhkr7DUbmC9mvVYlan8JU/R87VLRM/0l6xd15dn4JQRRKqeA8ThRLwWMtkreWvbURmhAcetKXaLmY+dCZqrPotEjiuw19lHD4sRVoG7d+rblEYnPbgNYaw9vJ/3qiFqmSbTQNodddyAHP4vhzyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qz50G6Nt; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=IcXrOF7d; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b3ae50fa217c11efbfff99f2466cf0b4-20240603
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=zxHF8r8ISl52P4oMUucVdP34rrhjHqzpH7eAkjQrL04=;
	b=qz50G6NttNGdWecLbYUX9Z8ZhpXu3jREXvAPm5yIUsqRfi6T6xcvQBO7CudXKjFKH/2ZG5FmwkwL03TU2KYGVWCDokcd4W53DrWVfhYgSoCpj7/6CsWii4kB5C+rlEX69q55uTIU821JOKpW7qu3uhNQDbIlMT5kl+xmSz+68KA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:98a22a08-9c74-41f0-9f5a-8c440d1f3842,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:3d73a484-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b3ae50fa217c11efbfff99f2466cf0b4-20240603
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 111270028; Mon, 03 Jun 2024 15:41:34 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 3 Jun 2024 15:41:33 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 3 Jun 2024 15:41:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQuOK+HXJ1uNdp1A32vrss9e3tPaTlL7qEkGnx47czB6j/+TaOxrLaOXyJQ8hH1+tnwBCMp386IRus/M5CPK/AYizCFcNDEJGYSncKQLvzBjwSVscL4hhitrnyH3XVqoyMpX8iNMXdO/04zKvHyhWzrcDdS+PQKbkjPMY9H076QhODXm+ivZy38/DJ/VGezrd1SUt4hnCIPszPBu1OvoTOnoZbiQKGImzq4SMeLp7ACcuQyRHeKykNZwfjVthHOwZ0pJj8TMAeioZu6EWPoy2ZB7NnXiAp+u4mp3BO54CVg3vku5V47FBpljK0+pNBQNTNIL2bM8dgBWxc+ZNDHiWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxHF8r8ISl52P4oMUucVdP34rrhjHqzpH7eAkjQrL04=;
 b=KENRD9rHESHfpWSir7Y95+3ShMjTLqfKfgklbhKKDEhQUxmlpnV1oHxT432NfJ8hQNUjE8mpKMRporWlZ/kU1ymwsutUr3kUVp5UdvCcjDKa0r2JM5cINF41EvXkTeISvrmKGgln8GIuVJ0JpvTGBoIrbWurMSyGTQnizFSXEQX6rx59bnPPtpjgxJriB/kw6irkPh0PthvUBHkpW+/UU0L/aK6sYVlfnludMJa3FlK6FmQdLS3rojcXd4y98vS2DaeKE2cdZrOX0gwJlis2zw2vpkhPVwYFAMJaKz8w0XOsJX/v8HW2o891e9HSeHOJ4dgDYke04AmUUpmNz65tTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxHF8r8ISl52P4oMUucVdP34rrhjHqzpH7eAkjQrL04=;
 b=IcXrOF7dee21M0z/NRBYU1PlHiGSlyI8YLUCEw/dWx1gXiT6alvBWg0OcrH4jyKewZPGqijhgheSnd2oEamYKGrvcx4uU42KAMFhjrKhhgbEZDstQaKl7/eVzDs2q8GJPZL+1nAjOaXWq5Tw8VdCVGiEoEU5d9as6+hG6+Sokjw=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by SEZPR03MB7680.apcprd03.prod.outlook.com (2603:1096:101:127::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.16; Mon, 3 Jun
 2024 07:41:30 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%3]) with mapi id 15.20.7656.007; Mon, 3 Jun 2024
 07:41:29 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "horms@kernel.org" <horms@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux@armlinux.org.uk"
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
Subject: Re: [PATCH net-next v5 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Topic: [PATCH net-next v5 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Thread-Index: AQHaskSsuAYxyIGHGE6fd61psDix3LGy4DGAgALOJ4A=
Date: Mon, 3 Jun 2024 07:41:29 +0000
Message-ID: <c0e197d39b589ce632c949a1278b04f3ecc0a779.camel@mediatek.com>
References: <20240530034844.11176-1-SkyLake.Huang@mediatek.com>
	 <20240530034844.11176-6-SkyLake.Huang@mediatek.com>
	 <20240601125105.GJ491852@kernel.org>
In-Reply-To: <20240601125105.GJ491852@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|SEZPR03MB7680:EE_
x-ms-office365-filtering-correlation-id: 828b39d9-0b4a-4c7e-5b2c-08dc83a094ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?YXZmNE03SUpEZDlzS3FERjl2NUFEVEYyS1hMT0JQL1RFRlQ3V0crSmVyQ0Iv?=
 =?utf-8?B?WVJyYno4QW1xZi9WT2l0UURubzNXM2RVVGNtS2FXeXlmaWVOeEVlWHl1dkVF?=
 =?utf-8?B?MGlrUGxmK2Z2QmJZL1QxS2h3QU5HS0dNeldESTBkTVFwY2JEazVtcnBmaDZY?=
 =?utf-8?B?ZWpxdytpMGZlNTNxdGFiNXR1OWNQMWNTaEh1SGtQQkhHQ1B6UlRiTWxzUnZZ?=
 =?utf-8?B?UjQ1SXoyR1Y3VEtCbEdyMkRNV3FrZUp0amFtTGI0L1c5Y1JxTHAyS090V1ht?=
 =?utf-8?B?SWZ0SnJRS3BJaDRjN05FdVVUZ29sWUhSYklmTVBvTkdpNWhiVUZ4UGNob1hN?=
 =?utf-8?B?MzQrWENQRnBIaHl5MGtLdm5aQ0RJR0JTb08rQnNjMmd0WFEvMGJWN0FPeCtv?=
 =?utf-8?B?amdnZHNSU1lzSG1OUUhPZWZ5ajVWaW40ZUN3Y2VkTzFzSkQrQ3dYam4vT3ZN?=
 =?utf-8?B?RmFoSDJKbXNIbm9VdGRrd2ovdWwySzFyOHM3eUdTRkI0UjdpK29SR3VrSENW?=
 =?utf-8?B?b0Y1RTg4YXRzWjFDM2c1Q0dENDB0RUg3dU1ISTJjM05ZcUMzMFpuZmZBT0ty?=
 =?utf-8?B?WnRRWElSdEJBQW5sdG1Lc0tONHF2blRRbGdtaW95TDV0Q1FSZWFYOHRZRFpj?=
 =?utf-8?B?eE1sMWxhR2cwd0Q2blJSQ1F5MUQ2MzVTaUxWZ290aWdmdG05M09WNjdOREtk?=
 =?utf-8?B?ei9ITjMxVDNOaEMrYmJrVUdLQ1ppNEV2RHNub08zMVF1VkQvNzNKeVBvL2t1?=
 =?utf-8?B?MWZXSUF4S1N2R3VEUlIxMytVSWtKTHNIaHVqQlVuU3g3Zlg4Tzk2b3ovTHFx?=
 =?utf-8?B?NWZ5UWp5K0xHRHJJdDZlUGJidHgxYVl5Rjg0Mk5KemVyTFlGREtrenJVdTVD?=
 =?utf-8?B?emQ2MW80QTFCV2RnQ1FqTEVyQjZCeExVNC83RVBqNHhBT2NPTHp0em5TbFNU?=
 =?utf-8?B?TTlnakQwSlkxd3paTk4wTDh5M25Kem5RWDVodm9DS2hSUTNONmtpNmRIb3ky?=
 =?utf-8?B?TjhSbWFyOWtQT1BkZmZ6a1A1SDZra2MxY0pqK3BwV3grSzhjREU3bEJCOGVv?=
 =?utf-8?B?SHVXZ0NhSXRTdmNMS3d3L1o3c0JGR21LSlR5dzgrdSt1QmxzTWVyMDR0NEtW?=
 =?utf-8?B?NTJNNjlIOEgvcHJqMGs3TVRwc3huR1dXZXJQS0tIUWxRVVJvVFRoc2Z6Mzlq?=
 =?utf-8?B?d1A3OTc5Yk9oUjhYb1RQcVhKaWYzcE9rejBwU0hvc1ljby81c1p6b3JkdXFB?=
 =?utf-8?B?THEvaEF4YnlDcW1HdnlaK1RFV2ZKZlJKMm5EeFBSYk5FMi9qNlREQ1M4dkNM?=
 =?utf-8?B?MGdxTW94OEVKclIzTll2YjVEa0lsSVBiQ1MzbTNRdHdFbC9oWlFzV0pNalZi?=
 =?utf-8?B?dzFhdmoybGR0U3cvNkx4VlduMXNoRzhpVjBVQURsRksyU3N5N0g3Wi9kWmlU?=
 =?utf-8?B?K09SZ1k2QVRwV1hBM3BUeHJLQkNnYXcwNWpXTHErdjVkdUozVy9tVjdiMFB6?=
 =?utf-8?B?R2RYZy9STEtoTGpYelRmUStBYkF1cENWM1liSW1DMG5EUGRhckFtajZ0ZmRJ?=
 =?utf-8?B?MlFFNEkrcHFHZHZpRXFvdHVQUFRBL0p1WFZSQnIzYlhaa0pwZlBnU2ZkTEVl?=
 =?utf-8?B?Y1RSelF0b2gxOEJoTU84cnlxT25jSGRhZVpXQjNTTUQxMlhqK3dPNGErSmhP?=
 =?utf-8?B?bGhKc1lPYXhHelpLVklHMjBpQVJndHVIV1JFYURjQjJjamg1ZHRiUmZaWlBo?=
 =?utf-8?B?TDR2aGg3RmFIT1FpT2Q1TkQrMzVoT3lkTHVhdjRjQnUzak5YUWhudU9YazVL?=
 =?utf-8?B?ZmJlWEUxVTg3MXBqd2I1Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R01XRnVVUWxlRE9TZ3hXbWRxd0tkeFhkVExCNGFNVXhFUGVmVjI4TjBrendN?=
 =?utf-8?B?YzF1b2tJSWh5RHh2ZmZIK2lEVDYyV0xRWkxXdS8xdlA5NldDM2E3SGxoR3Vj?=
 =?utf-8?B?UG1IeDZWOGlucjJwK3JXSlVJb1BYc0craUYwcVRpUXBlNFFBNkE2MDU4Qkpx?=
 =?utf-8?B?NVhwbk9QSlByN1NrejRjM3lrQU96ZEh0NkZmcHR6SVFZNmJidm1aMkx4QWpn?=
 =?utf-8?B?VUxwNnVEM2lydkFsdDJHWXRzaHdVMVVlYjlGSnpvNlQ3M2c4R3pSaU5OdEl6?=
 =?utf-8?B?QWV0c0hrNXMrQWQ3cXhWaE9vV3pSdSsxLy93aTFPWnZjUCt4VDV3RlRyNW1u?=
 =?utf-8?B?Mk93L25udkdZYnAvUGNVbHhDUzNIbjNxUjhuTlVDY0lXbmpjMkQrOHNBWFpV?=
 =?utf-8?B?QUtkdkRXenZQaEZwSElSb1NVV1RPbHA2c3VnVnN5eklxemEwa0Vuakp4Tm1w?=
 =?utf-8?B?aU1XZ01OV1NFU3NpR3lZSWY1aG5VQjg2SGhkaTBLcmJnOTJ6bW9EbDdDc0k3?=
 =?utf-8?B?QnpUTi8yY3NiajMvZE1aT1gvOWNWNWhlbkZQQjZNQUN2Nm00WFRFc3lvNFlV?=
 =?utf-8?B?OUZSMm9ydlpWQ1lNT0JSQ1BqU3BFb1luRUZYS3VxVnhxbFVHRDJIQ1dRVk9z?=
 =?utf-8?B?K1VjYW53dzRIeXk4WmpLbUw3Um52bnBnUFFCT3ZrZTRHYS9YL0wrckNWY2Nw?=
 =?utf-8?B?c2dKOWpibWd2aFdvRG9HUml5aFoya1QzVStkYXc3TStkVUhjVTE2em9SYzdl?=
 =?utf-8?B?c0ZwdFpZbG93SkoxbWRGMVozalRXUHV1M2dSYlI5bWUwRTRHSGhRdkdsNmRU?=
 =?utf-8?B?TFA2bFZnMmNHVHpleWZzamFQZ2E1UGVpakRPTVRYM2VZWnJlb3VlOW5ZQUc4?=
 =?utf-8?B?Uk5MWkxtRDNnOG5IUUpTbVlxU1YwWEFPNWl5WGgvSmUxcDlTSTBKUEt2ZWlU?=
 =?utf-8?B?WFV0ZTVWTHJlbVBvcWlsVm1VUmYzUG0xRDRrb2V0VWxFUUpaRnNVZjYrdG9q?=
 =?utf-8?B?Ump6R1hyS2hjS0JTQm9RYlNqdGxXMnQyYmtldkhaRmlraldyOEZDSjdRK3hH?=
 =?utf-8?B?ZFJxSjFPRjVVRm5vMGJVQmlKMVcvVXRmd3k3NFpudGFmSExnQmVmM0p0Q2dp?=
 =?utf-8?B?cTNGSmxJRXAxUWZGYzZseXVrZnQxY0xHR1RvcGw5SXJsTkQranllM1RwajFC?=
 =?utf-8?B?ekdNWHkxenpqRW1MbGZpNlMwejcxNThXWXF1Y2M2eEdvSjBHeTJMTHRCZ1RV?=
 =?utf-8?B?ck9Qdy80SUtIMnhjeXFrd0FSUHQ4OHliSXpTNG1WZVRuTGk2RjFJOXNSY3Q5?=
 =?utf-8?B?anUyMk1HdXd3SnVvM0NlWUxydjFGYW8xc1l6QXN1eG44TmptTWYwcWJLdGtY?=
 =?utf-8?B?aXAySVRSbmlxVlBtNjducGdCWS9TZ3FqQVNNdlIyVUlBRXB4aFNjbUpOWWF0?=
 =?utf-8?B?MVc4dVJraktoVGt2ZE14d0ZBU285L09EcjU1QXpjMnFaNHlBbkU2RkliN2xI?=
 =?utf-8?B?SE5GZUFaQVpXNjJZYU91a2trMkIvQ3IvcFZOelcvRFdhc0J5T3ZkN3RyVFhZ?=
 =?utf-8?B?TXZWRktZL0VqUmNYSmJCQ1Z6OVgzM1B2bmNmK1dadnFSanJ0YnBGTUdZVDNV?=
 =?utf-8?B?SWtaMDJLV2NNckhNNjV4Ujd1QmVxbHFFYzBnUFhiYlRCenFDZjA4bnFqY1pP?=
 =?utf-8?B?aTh1bER6K2hOeDFRbGhwd1pBNFRqQ3QwanBQKzUwWWRPNDcrRnA1c2Z4cGxv?=
 =?utf-8?B?UHA3WFF2TzdiV0owNDVSNG5tamdra0V4UVQybGd5NVdYOFVsSDFvV0NpdlA5?=
 =?utf-8?B?RjJYT0ZSMlRTdEJyOTZlaEg4RUFlN2JKWGdTdXdZTGIzRWdDSEpKZktMWlR1?=
 =?utf-8?B?Vm9rRDRGb3VtdzJRT1VydkdsVWVZcU1NTHV5R05GenNCOFl2Rm9DV21aUDIw?=
 =?utf-8?B?MHlZYVBhTDNuQkVuZWNKOXlPM2Nqem1QZWc0WGIvdWVlQ01YbjlyYXhaQmFN?=
 =?utf-8?B?aEExWHNvSmd2Qjk3emYyVXJrc3JEakVQWFJNTWNwaERBVFVHS3FwNzFvLzd6?=
 =?utf-8?B?NHNMTTZrUzFxb2pKT2JwcXlsSXV1OHRJbW9FMURrR05JbFpWbFpDNHc4TXh5?=
 =?utf-8?B?MXk5eEFUeDdzYWlncnFWdUhxbmc1V015MWpraHVCa3FmOHdqSWc0M1cwQjBX?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B197A987E6246243B4F4AF5241BCB2DF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828b39d9-0b4a-4c7e-5b2c-08dc83a094ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 07:41:29.6113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RzlhbOuEgt9MnDJovehi3wCP/iQ2mATWHlE4oJbSVLPTkJ6RZdGr+pwc1Gj05h31YJlzjqTpQYNpyBLlAMQgKokKMkj0cGC/4fc3miFbuLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7680

T24gU2F0LCAyMDI0LTA2LTAxIGF0IDEzOjUxICswMTAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgT24gVGh1LCBNYXkgMzAsIDIwMjQgYXQgMTE6NDg6NDRBTSArMDgwMCwg
U2t5IEh1YW5nIHdyb3RlOg0KPiA+IEZyb206ICJTa3lMYWtlLkh1YW5nIiA8c2t5bGFrZS5odWFu
Z0BtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gdjE6DQo+ID4gQWRkIHN1cHBvcnQgZm9yIGludGVy
bmFsIDIuNUdwaHkgb24gTVQ3OTg4LiBUaGlzIGRyaXZlciB3aWxsIGxvYWQNCj4gPiBuZWNlc3Nh
cnkgZmlybXdhcmUsIGFkZCBhcHByb3ByaWF0ZSB0aW1lIGRlbGF5IGFuZCBmaWd1cmUgb3V0IExF
RC4NCj4gPiBBbHNvLCBjZXJ0YWluIGNvbnRyb2wgcmVnaXN0ZXJzIHdpbGwgYmUgc2V0IHRvIGZp
eCBsaW5rLXVwIGlzc3Vlcy4NCj4gPiANCj4gPiB2MjoNCj4gPiAxLiBNb3ZlIG1kMzJfZW5fY2Zn
X2Jhc2UgJiBwbWJfYWRkciBkZXRlY3Rpb24gaW4gcHJvYmUgZnVuY3Rpb24uDQo+ID4gMi4gRG8g
bm90IHJlYWQgUE1CICYgTUQzMl9FTl9DRkcgYmFzZSBhZGRyZXNzZXMgZnJvbSBkdHMuIFdlIHdv
bid0DQo+ID4gY2hhbmdlIHRoYXQgZnJvbSBib2FyZCB0byBib2FyZC4gTGVhdmUgdGhlbSBpbiBk
cml2ZXIgY29kZS4gQWxzbywNCj4gPiByZWxlYXNlIHRob3NlIGFkZHJlc3NlcyBhZnRlciBmaXJt
d2FyZSBpcyB0cmlnZ2VyZWQuDQo+ID4gMy4gUmVtb3ZlIGhhbGYgZHVwbGV4IGNvZGUgd2hpY2gg
bGVhZHMgdG8gYW1iaWd1aXR5LiBUaG9zZSBhcmUgZm9yDQo+ID4gdGVzdGluZyAmIGRldmVsb3Bp
bmcgcHJldmlvdXNseS4NCj4gPiA0LiBVc2UgY29ycmVjdCBCTUNSIGRlZmluaXRpb25zLg0KPiA+
IDUuIENvcnJlY3QgY29uZmlnX2FuZWcgLyBnZXRfZmVhdHVyZXMgLyByZWFkX3N0YXR1cyBmdW5j
dGlvbnMuDQo+ID4gNi4gQ2hhbmdlIG10Nzk4OF8ycDVnZSBwcmVmaXggdG8gbXQ3OTh4XzJwNWdl
IGluIGNhc2UgdGhhdCBvdXIgbmV4dA0KPiA+IHBsYXRmb3JtIHVzZXMgdGhpcyAyLjVHcGh5IGRy
aXZlci4NCj4gPiANCj4gPiB2MzoNCj4gPiAxLiBBZGQgcmFuZ2UgY2hlY2sgZm9yIGZpcm13YXJl
Lg0KPiA+IDIuIEZpeCBjNDVfaWRzLm1tZHNfcHJlc2VudCBpbiBwcm9iZSBmdW5jdGlvbi4NCj4g
PiAzLiBTdGlsbCB1c2UgZ2VucGh5X3VwZGF0ZV9saW5rKCkgaW4gcmVhZF9zdGF0dXMgYmVjYXVz
ZQ0KPiA+IGdlbnBoeV9jNDVfcmVhZF9saW5rKCkgY2FuJ3QgY29ycmVjdCBkZXRlY3QgbGluayBv
biB0aGlzIHBoeS4NCj4gPiANCj4gPiB2NDoNCj4gPiAxLiBNb3ZlIGZpcm13YXJlIGxvYWRpbmcg
ZnVuY3Rpb24gdG8gbXQ3OTh4XzJwNWdlX3BoeV9sb2FkX2Z3KCkNCj4gPiAyLiBBZGQgQU4gZGlz
YWJsZSB3YXJuaW5nIGluIG10Nzk4eF8ycDVnZV9waHlfY29uZmlnX2FuZWcoKQ0KPiA+IDMuIENs
YXJpZnkgdGhlIEhEWCBjb21tZW50cyBpbiBtdDc5OHhfMnA1Z2VfcGh5X2dldF9mZWF0dXJlcygp
DQo+ID4gDQo+ID4gdjU6DQo+ID4gMS4gTW92ZSBtZDMyX2VuX2NmZ19iYXNlICYgcG1iX2FkZHIg
dG8gbG9jYWwgdmFyaWFibGVzIHRvIGFjaGlldmUNCj4gPiBzeW1tZXRyaWMgY29kZS4NCj4gPiAy
LiBQcmludCBvdXQgZmlybXdhcmUgZGF0ZSBjb2RlICYgdmVyc2lvbi4NCj4gPiAzLiBEb24ndCBy
ZXR1cm4gZXJyb3IgaWYgTEVEIHBpbmN0cmwgc3dpdGNoaW5nIGZhaWxzLiBBbHNvLCBhZGQNCj4g
PiBjb21tZW50cyB0byB0aGlzIHVudXN1YWwgb3BlcmF0aW9ucy4NCj4gPiA0LiBSZXR1cm4gLUVP
UE5PVFNVUFAgZm9yIEFOIG9mZiBjYXNlIGluIGNvbmZpZ19hbmVnKCkuDQo+ID4gDQo+IA0KPiBI
aSBTa3ksDQo+IA0KPiBUaGlzIGlzIGEgc29tZXdoYXQgdW51c3VhbCB3YXkgdG8gYXJyYW5nZSBh
IHBhdGNoIGRlc2NyaXB0aW9uLg0KPiANCj4gVXN1YWxseSB0aGUgZGVzY3JpcHRpb24gZGVzY3Jp
YmVzIHRoZSBjaGFuZ2UsIHBhcnRpY3VsYXJseSB3aHkNCj4gdGhlIGNoYW5nZSBpcyBiZWluZyBt
YWRlLg0KPiANCj4gV2hpbGUgdGhlIHBlci12ZXJzaW9uIGNoYW5nZXMgYXJlIGxpc3RlZCBiZWxv
dyB0aGUgc2Npc3NvcnMgKCItLS0iKS4NCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogU2t5TGFrZS5I
dWFuZyA8c2t5bGFrZS5odWFuZ0BtZWRpYXRlay5jb20+DQo+IA0KPiAuLi4NCj4gDQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3BoeS9tZWRpYXRlay9tdGstMnA1Z2UuYw0KPiBiL2RyaXZl
cnMvbmV0L3BoeS9tZWRpYXRlay9tdGstMnA1Z2UuYw0KPiANCj4gLi4uDQo+IA0KPiA+ICtzdGF0
aWMgaW50IG10Nzk4eF8ycDVnZV9waHlfbG9hZF9mdyhzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2
KQ0KPiA+ICt7DQo+ID4gK3N0cnVjdCBtdGtfaTJwNWdlX3BoeV9wcml2ICpwcml2ID0gcGh5ZGV2
LT5wcml2Ow0KPiA+ICt2b2lkIF9faW9tZW0gKm1kMzJfZW5fY2ZnX2Jhc2UsICpwbWJfYWRkcjsN
Cj4gPiArc3RydWN0IGRldmljZSAqZGV2ID0gJnBoeWRldi0+bWRpby5kZXY7DQo+ID4gK2NvbnN0
IHN0cnVjdCBmaXJtd2FyZSAqZnc7DQo+ID4gK2ludCByZXQsIGk7DQo+ID4gK3UxNiByZWc7DQo+
ID4gKw0KPiA+ICtpZiAocHJpdi0+ZndfbG9hZGVkKQ0KPiA+ICtyZXR1cm4gMDsNCj4gPiArDQo+
ID4gK3BtYl9hZGRyID0gaW9yZW1hcChNVDc5ODhfMlA1R0VfUE1CX0JBU0UsIE1UNzk4OF8yUDVH
RV9QTUJfTEVOKTsNCj4gPiAraWYgKCFwbWJfYWRkcikNCj4gPiArcmV0dXJuIC1FTk9NRU07DQo+
ID4gK21kMzJfZW5fY2ZnX2Jhc2UgPSBpb3JlbWFwKE1UNzk4OF8yUDVHRV9NRDMyX0VOX0NGR19C
QVNFLA0KPiBNVDc5ODhfMlA1R0VfTUQzMl9FTl9DRkdfTEVOKTsNCj4gDQo+IG5pdDogTmV0d29y
a2luZyBzdGlsbCBwcmVmZXJzIGNvZGUgdG8gYmUgODAgY29sdW1ucyB3aWRlIG9yIGxlc3MuDQo+
ICAgICAgSXQgbG9va3MgbGlrZSB0aGF0IGNhbiBiZSB0cml2aWFsbHkgYWNoaWV2ZWQgaGVyZSBh
bmQNCj4gICAgICBzZXZlcmFsIG90aGVyIHBsYWNlcyBpbiB0aGlzIHBhdGNoLg0KPiANCj4gICAg
ICBPVE9ILCBJIGRvbid0IHRoaW5rIHRoZXJlIGlzIG5vIG5lZWQgdG8gYnJlYWsgbGluZXMgdG8g
bWVldCB0aGlzDQo+ICAgICAgcmVxdWlyZW1lbnQgd2hlcmUgaXQgaXMgcGFydGljdWxhcmx5IGF3
a3dhcmQgdG8gZG8gc28uDQo+IA0KPiAgICAgIEZsYWdnZWQgYnkgY2hlY2twYXRjaC5wbCAtLW1h
eC1saW5lLWxlbmd0aD04MA0KPiANCj4gPiAraWYgKCFtZDMyX2VuX2NmZ19iYXNlKSB7DQo+ID4g
K3JldCA9IC1FTk9NRU07DQo+ID4gK2dvdG8gZnJlZV9wbWI7DQo+ID4gK30NCj4gPiArDQo+ID4g
K3JldCA9IHJlcXVlc3RfZmlybXdhcmUoJmZ3LCBNVDc5ODhfMlA1R0VfUE1CLCBkZXYpOw0KPiA+
ICtpZiAocmV0KSB7DQo+ID4gK2Rldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGxvYWQgZmlybXdhcmU6
ICVzLCByZXQ6ICVkXG4iLA0KPiA+ICtNVDc5ODhfMlA1R0VfUE1CLCByZXQpOw0KPiA+ICtnb3Rv
IGZyZWU7DQo+ID4gK30NCj4gPiArDQo+ID4gK2lmIChmdy0+c2l6ZSAhPSBNVDc5ODhfMlA1R0Vf
UE1CX1NJWkUpIHsNCj4gPiArZGV2X2VycihkZXYsICJGaXJtd2FyZSBzaXplIDB4JXp4ICE9IDB4
JXhcbiIsDQo+ID4gK2Z3LT5zaXplLCBNVDc5ODhfMlA1R0VfUE1CX1NJWkUpOw0KPiA+ICtyZXQg
PSAtRUlOVkFMOw0KPiA+ICtnb3RvIGZyZWU7DQo+ID4gK30NCj4gPiArDQo+ID4gK3JlZyA9IHJl
YWR3KG1kMzJfZW5fY2ZnX2Jhc2UpOw0KPiA+ICtpZiAocmVnICYgTUQzMl9FTikgew0KPiA+ICtw
aHlfc2V0X2JpdHMocGh5ZGV2LCBNSUlfQk1DUiwgQk1DUl9SRVNFVCk7DQo+ID4gK3VzbGVlcF9y
YW5nZSgxMDAwMCwgMTEwMDApOw0KPiA+ICt9DQo+ID4gK3BoeV9zZXRfYml0cyhwaHlkZXYsIE1J
SV9CTUNSLCBCTUNSX1BET1dOKTsNCj4gPiArDQo+ID4gKy8qIFdyaXRlIG1hZ2ljIG51bWJlciB0
byBzYWZlbHkgc3RhbGwgTUNVICovDQo+ID4gK3BoeV93cml0ZV9tbWQocGh5ZGV2LCBNRElPX01N
RF9WRU5EMSwgMHg4MDBlLCAweDExMDApOw0KPiA+ICtwaHlfd3JpdGVfbW1kKHBoeWRldiwgTURJ
T19NTURfVkVORDEsIDB4ODAwZiwgMHgwMGRmKTsNCj4gPiArDQo+ID4gK2ZvciAoaSA9IDA7IGkg
PCBNVDc5ODhfMlA1R0VfUE1CX1NJWkUgLSAxOyBpICs9IDQpDQo+ID4gK3dyaXRlbCgqKCh1aW50
MzJfdCAqKShmdy0+ZGF0YSArIGkpKSwgcG1iX2FkZHIgKyBpKTsNCj4gPiArcmVsZWFzZV9maXJt
d2FyZShmdyk7DQo+ID4gK2Rldl9pbmZvKGRldiwgIkZpcm13YXJlIGRhdGUgY29kZTogJXgvJXgv
JXgsIHZlcnNpb246ICV4LiV4XG4iLA0KPiA+ICsgYmUxNl90b19jcHUoKigodWludDE2X3QgKiko
ZnctPmRhdGEgKyBNVDc5ODhfMlA1R0VfUE1CX1NJWkUgLQ0KPiA4KSkpLA0KPiANCj4gSWYgdGhl
IGRhdGEgYXQgZnctPmRhdGEgKyBNVDc5ODhfMlA1R0VfUE1CX1NJWkUgLSA4IGlzIGEgMTYtYml0
DQo+IEJpZyBFbmRpYW4gdmFsdWUsIHRoZW4gSSB0aGluayB0aGUgY2FzdCBzaG91bGQgYmUgdG8g
X19iZTE2IHJhdGhlcg0KPiB0aGFuIHVpbnQxNl90IChhbmQgaW4gYW55IGNhc2UgdTE2IHdvdWxk
IGJlIHByZWZlcnJlZCB0byB1aW50MTZfdA0KPiBhcyB0aGlzIGlzIEtlcm5lbCBjb2RlKS4NCj4g
DQo+IEZsYWdnZWQgYnkgU3BhcnNlLg0KPiANCj4gPiArICooZnctPmRhdGEgKyBNVDc5ODhfMlA1
R0VfUE1CX1NJWkUgLSA2KSwNCj4gPiArICooZnctPmRhdGEgKyBNVDc5ODhfMlA1R0VfUE1CX1NJ
WkUgLSA1KSwNCj4gPiArICooZnctPmRhdGEgKyBNVDc5ODhfMlA1R0VfUE1CX1NJWkUgLSAyKSwN
Cj4gPiArICooZnctPmRhdGEgKyBNVDc5ODhfMlA1R0VfUE1CX1NJWkUgLSAxKSk7DQo+ID4gKw0K
PiA+ICt3cml0ZXcocmVnICYgfk1EMzJfRU4sIG1kMzJfZW5fY2ZnX2Jhc2UpOw0KPiA+ICt3cml0
ZXcocmVnIHwgTUQzMl9FTiwgbWQzMl9lbl9jZmdfYmFzZSk7DQo+ID4gK3BoeV9zZXRfYml0cyhw
aHlkZXYsIE1JSV9CTUNSLCBCTUNSX1JFU0VUKTsNCj4gPiArLyogV2UgbmVlZCBhIGRlbGF5IGhl
cmUgdG8gc3RhYmlsaXplIGluaXRpYWxpemF0aW9uIG9mIE1DVSAqLw0KPiA+ICt1c2xlZXBfcmFu
Z2UoNzAwMCwgODAwMCk7DQo+ID4gK2Rldl9pbmZvKGRldiwgIkZpcm13YXJlIGxvYWRpbmcvdHJp
Z2dlciBvay5cbiIpOw0KPiA+ICsNCj4gPiArcHJpdi0+ZndfbG9hZGVkID0gdHJ1ZTsNCj4gPiAr
DQo+ID4gK2ZyZWU6DQo+ID4gK2lvdW5tYXAobWQzMl9lbl9jZmdfYmFzZSk7DQo+ID4gK2ZyZWVf
cG1iOg0KPiA+ICtpb3VubWFwKHBtYl9hZGRyKTsNCj4gPiArDQo+ID4gK3JldHVybiByZXQgPyBy
ZXQgOiAwOw0KPiA+ICt9DQo+IA0KPiAuLi4NCj4gDQo+ID4gK3N0YXRpYyBpbnQgbXQ3OTh4XzJw
NWdlX3BoeV9sZWRfYmxpbmtfc2V0KHN0cnVjdCBwaHlfZGV2aWNlDQo+ICpwaHlkZXYsIHU4IGlu
ZGV4LA0KPiA+ICsgIHVuc2lnbmVkIGxvbmcgKmRlbGF5X29uLA0KPiA+ICsgIHVuc2lnbmVkIGxv
bmcgKmRlbGF5X29mZikNCj4gPiArew0KPiA+ICtib29sIGJsaW5raW5nID0gZmFsc2U7DQo+ID4g
K2ludCBlcnIgPSAwOw0KPiA+ICtzdHJ1Y3QgbXRrX2kycDVnZV9waHlfcHJpdiAqcHJpdiA9IHBo
eWRldi0+cHJpdjsNCj4gDQo+IG5pdDogUGxlYXNlIGNvbnNpZGVyIGFycmFuZ2luZyBsb2NhbCB2
YXJpYWJsZXMgaW4gcmV2ZXJzZSB4bWFzIHRyZWUNCj4gb3JkZXIgLSANCj4gICAgICBsb25nZXN0
IGxpbmUgdG8gc2hvcnRlc3QuDQo+IA0KPiAgICAgIEVkd2FyZCBDcmVlJ3MgdG9vbCBjYW4gYmUg
aGVscGZ1bDoNCj4gICAgICBodHRwczovL2dpdGh1Yi5jb20vZWNyZWUtc29sYXJmbGFyZS94bWFz
dHJlZQ0KPiANCj4gPiArDQo+ID4gK2lmIChpbmRleCA+IDEpDQo+ID4gK3JldHVybiAtRUlOVkFM
Ow0KPiA+ICsNCj4gPiAraWYgKGRlbGF5X29uICYmIGRlbGF5X29mZiAmJiAoKmRlbGF5X29uID4g
MCkgJiYgKCpkZWxheV9vZmYgPiAwKSkNCj4gew0KPiA+ICtibGlua2luZyA9IHRydWU7DQo+ID4g
KypkZWxheV9vbiA9IDUwOw0KPiA+ICsqZGVsYXlfb2ZmID0gNTA7DQo+ID4gK30NCj4gPiArDQo+
ID4gK2VyciA9IG10a19waHlfaHdfbGVkX2JsaW5rX3NldChwaHlkZXYsIGluZGV4LCAmcHJpdi0+
bGVkX3N0YXRlLA0KPiBibGlua2luZyk7DQo+ID4gK2lmIChlcnIpDQo+ID4gK3JldHVybiBlcnI7
DQo+ID4gKw0KPiA+ICtyZXR1cm4gbXRrX3BoeV9od19sZWRfb25fc2V0KHBoeWRldiwgaW5kZXgs
ICZwcml2LT5sZWRfc3RhdGUsDQo+ID4gKyAgICAgTVRLXzJQNUdQSFlfTEVEX09OX01BU0ssIGZh
bHNlKTsNCj4gPiArfQ0KPiANCj4gLi4uDQpUaGFua3MuIEknbGwgZml4IGFsbCBvZiB0aGUgYWJv
dmUgaW4gdjYuDQoNClNreQ0K

