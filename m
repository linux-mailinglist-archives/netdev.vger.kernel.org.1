Return-Path: <netdev+bounces-268389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGO4CUe0uGmtiAEAu9opvQ
	(envelope-from <netdev+bounces-268389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:54:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 298B42A2A92
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 38C0A3010779
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747A833F392;
	Tue, 17 Mar 2026 01:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WK1Ne+wz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Fc7PWzpV"
X-Original-To: netdev@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE9E344D9D;
	Tue, 17 Mar 2026 01:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773712448; cv=fail; b=RTi9RAWXTSI5BJDmccB037FBETTHRo4Stl5Os34xpuDlua4FkRalCriO6nqEBm0gGa5ML2dFNKeNVC3HE0P6SJmFlyzkOwQLDINxl/XnUDZQFQB04l9x6aMj0GmN0pVWFTdPGNnUOZg2Xxxk4qUUprI2VEAHf7cYUejymKDIvp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773712448; c=relaxed/simple;
	bh=zHa8eGBFZWVpw7LdIB5+e6FMQSESCa4iqe9DlklP0FA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P5GwiLf4r2C5hOmNTSu7UtssmAvxLZTn0AoOS2H0cAT6gnr356jV1hlRTjB6AQnAuG6G+NJmnsCxE9TEIq/gbtwFTxi2p22foYwUasAs+aWneWC8rNPyxtceuwgP0SmXBkr3JQDzJj3bTuDTocvBX7TbkeJs1BHh74dHFxPeyPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WK1Ne+wz; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Fc7PWzpV; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1773712446; x=1805248446;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zHa8eGBFZWVpw7LdIB5+e6FMQSESCa4iqe9DlklP0FA=;
  b=WK1Ne+wzk74KzeUazknWDp+HYGYHyxHnb1KDs/wm+RX1R7w5oOmJ03LO
   b7kzE//gZCGjSy60m3+C38hvNseS/Z+nHyX82Lq2jsa36zlq2Jwd9J8Kd
   iZst90LuqobNnS1nOmHDWSUknJOdZop5vU6mHzwgNk+6U1FfDdz6fDJeN
   xNk/EQMBfbVS2XyZxl2/h17JmTAB0EUP/BCYlrFRybBFBgVX5RTB98Z0o
   xpc7d4gbXUPAwWoJ8YArlDuYHV+NIIVt//t/vgtre2l8iRd/dLnKxdSOh
   SnH1Ox8NtSJgXYXab3U8ow38YqRyOT6Pg+qTa1g0qUFiLeUFVzVnE8QrO
   w==;
X-CSE-ConnectionGUID: RwBFsDBzSay33ZysdpNHFg==
X-CSE-MsgGUID: iowCfq6JR9qkfK/5jUGVsQ==
X-IronPort-AV: E=Sophos;i="6.23,124,1770566400"; 
   d="scan'208";a="141649134"
Received: from mail-southcentralusazon11013031.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.31])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Mar 2026 09:54:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXzeN8OiKLMsJ2/oXKzqygjmfsQV6U6mEfY/1zegpoRl5oIF2jJh0QU4DIryDY8g0zxW77F4crn80BNNcPok126jzuO3z52AJgdVskES99Op+WYOXQMKykTKDQW/4SOvLWGgc7zK+eW6n3sji0TpV/h7i2rLGck+Al4uu7GGovzIBOBfD1H74UIcqhPQo7sETxkYs4qGmeksJE9xth6w+m1ZQ1zMiChk4uf7yZjfcZfHSoHmWmIru0o73YiixgNwj6g67fN3TsqzOu6UXz4H3KuP8CfJOFn0t2ZhpY5Eq+ppSiHjeCpGQ3nUuoFLur8A5wQ0c/gn8gwLlyFbgwiAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHa8eGBFZWVpw7LdIB5+e6FMQSESCa4iqe9DlklP0FA=;
 b=aYTWN93IHwdxn8iT9OrLMjDkN8DnGjOeP2jGbc2XOtzHhzzrQtQCgp3LEoJIfhLbxYGHDe7iEDQfggSQue8X1L0cumHVhdeapr2p8srB5p2JV5OcIOspdJ9fC/LjOs4eUXzjB8bf6p+1vtFEUOmX9IywaaJqbi1VJciqkNV+iSK9NKgB/ozxbuD9+mRHJFIBVD6JX1vFb9WGzmLlzrDaiz71S+Z/rNdpaYm4nEe98OuoC5gL2UcCTZfzG7j76F5xfbZVpdjeng9gBG2w9d5ZarW4+d7hSKhN+LPIMytA1K7R/NJzpetN+1MxvkSQzaimILUFcDO1EejTm7pPm5On9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHa8eGBFZWVpw7LdIB5+e6FMQSESCa4iqe9DlklP0FA=;
 b=Fc7PWzpVbhNDPXkIRUOCX8qb5BtS6kiyuq5l03n9n2KGo7nQMM5yjD/0nN4gT/W1kzMsRhw8Ta6o8gegDvJzNa8tNwsKU8L3nBhqitAd8HGG6wNY+kan91grMJQclBghhwnOtOQ+5gJdMsf4+1XNG+XssFUU5JEJTyHufJqQrlM=
Received: from SA1PR04MB8303.namprd04.prod.outlook.com (2603:10b6:806:1e4::17)
 by MN2PR04MB6687.namprd04.prod.outlook.com (2603:10b6:208:1e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 01:53:51 +0000
Received: from SA1PR04MB8303.namprd04.prod.outlook.com
 ([fe80::8719:e407:70e:f9e1]) by SA1PR04MB8303.namprd04.prod.outlook.com
 ([fe80::8719:e407:70e:f9e1%6]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 01:53:44 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>, Alistair Francis <Alistair.Francis@wdc.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "sd@queasysnail.net"
	<sd@queasysnail.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"edumazet@google.com" <edumazet@google.com>, "horms@kernel.org"
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC net-next 1/3] net/tls_sw: support randomized zero padding
Thread-Topic: [RFC net-next 1/3] net/tls_sw: support randomized zero padding
Thread-Index:
 AQHcr4k7hso1zcbGlUqlU5NbBiJDT7WseAsAgAGpkICAA9A1AIAAAviAgAAE4YCAAAKEgIAABpqA
Date: Tue, 17 Mar 2026 01:53:44 +0000
Message-ID: <64cb821cc09226155059807cb0bcdbc51ae8d0d6.camel@wdc.com>
References: <20260309054837.2299732-2-wilfred.opensource@gmail.com>
		<20260309054837.2299732-3-wilfred.opensource@gmail.com>
		<abQOGm6BqAE5eEln@krikkit>	<20260314073919.2f92b966@kernel.org>
		<9e9f6eb89ba95e9fbb764e2807420e98b566bf37.camel@wdc.com>
		<20260316180355.37d45785@kernel.org>
		<8f29d43fc1fd7e6feec4c24131eb2c0292a8c0fd.camel@wdc.com>
	 <20260316183023.2fb38d84@kernel.org>
In-Reply-To: <20260316183023.2fb38d84@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR04MB8303:EE_|MN2PR04MB6687:EE_
x-ms-office365-filtering-correlation-id: 9b04e9b6-a941-4040-43a8-08de83c805c4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|7416014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 4occargzQdYe3m7K1i3et0CcVt9bi9/zl9X/VWxxnn3/BLmlOf31BCzf8aKFbIkbAi/Jm+lARHSX1sldP+pGOu4Vaxwm5F/HLf+orm08t+mCCtn079vuH285AeftdBIrlx2l8+G/5BE5W4VkbfHUoG0PXHx2yTYv3e2ZLP0bMNzRwj9FSpHG1wL1xSNgBDXj88K54RNbfGeOMlWWbuurdnUQoSYtuoM/6lboBQPYWQ3RZnoY0VAM21VWc+fpQ+1UJmWG2FpdkteBZf+kBds4GswLwuo3xQoGsC+SeDnHLXKH8gVIYUY57f8ggXhpkKYyfhc44kuZZM5ZmteOqCmTwmbX2nL6SNtmuyAXEh5eLAwFmCs3pvK1XMtdmKc4zxBXihzNqffPoUfMaHeGEu8g7gmriyesGcRzSPY0OWwcsRwofCxnTbGTQk2b4Psk8dIEu+OQpXKRNEucXLSUqjg+TdJ/DO3Om0SratHQhBKZDC9AqW5CwAElWgoxr9W910jcMkj7GKt9GVyLUQCmjOZgwctHrA37Af+y84HfvfJMxkZjhVXwOe2RsMZBdUnQap3Wq+uJaw8WWzWM6dyCPmIrTkEGA7o2B4+ttD1Gt7V2Qw+wL+/rPgbZeNddegRx2nBMk8HrcGhD6Kn5lesS6s8fGMXQ/1ofq0nhf6dSIEgQEjR7rodaEi2vlF6QmUCFf4F8TKV1aQsHRyRbdMoMoTGNEr97dDQwrXJvW1U3g90IuY+OTCmwd1vxLzc+ATAdYmHHqNtZ17hbXxc39B8iugjoIDVQl5Ops7DmKyvvXzWufR4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB8303.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXhQbmxRK3JCMkM5bXVZemFocTdlckFHVkFFeXVVR1l0TEVmR2JQRTdKZG5q?=
 =?utf-8?B?L3JSSUhvb3I5Rm1idTFEYUpPMXVmU1RIbEZCVzdrTDhXcHJ0S2FoMEp0aHZq?=
 =?utf-8?B?Y25oRnZNVGF3anJ5Mi9qM240TE1qWHJRbXQxTFoxazB1VnJyNEtneE9tc3U1?=
 =?utf-8?B?SnRubGhTMTRBRGVKYWxLWm8wTWl5WEYyUDlkQlNrL1R2eHRaTzF5b1ZUWnhF?=
 =?utf-8?B?ZDhpdWxvY1cvNDNZUVZRVkYrV1U2MGVBenJXMzdWQ0lMN0RzaWNOQWpDQlha?=
 =?utf-8?B?bSt4UWhzc0JCMnpqb3QwZ2M0Z0FZLzVWaWN0QUlXdDdzT1pyb3VpL1k0c0Fy?=
 =?utf-8?B?UWMzTEdjU2Z1YTd2WUZjQngwTW9Ta21CSGJvV29wTnB6dmp0ZGtETUFuM2Y1?=
 =?utf-8?B?MW4vTTQrUXd3YWFDYnVHWWF6dzlqemFNSTMwK0JYTHlLSFhlYy9lcXc3WitY?=
 =?utf-8?B?MklEK1pWdGtPQ1BWV1hCOXJhQ0ViSTdrYVU4ZjIvcEJVcFhiczduZXJQSU9r?=
 =?utf-8?B?YmpYUlNoamczdmQ0VW85eDlZKzl6U0lGRWRJNTVqdk9PZVVXMXNJSjl5UzRu?=
 =?utf-8?B?ZEQ3NWM0WCtDN3pQZG9nWSs4dUdxK0ZkR2kvUTRPUnpVTllMN2JHY3NnaWVU?=
 =?utf-8?B?S2FKSWNNUmFTVjVEZkdUQmVHNUp5cEl2c1JBRUdtWmlnazJDd1pwcnhPd3NI?=
 =?utf-8?B?TCt2R2huUjVRWldRbE9tV3FaUHQvSVpRVkVrcUx0dXRCZFhDV0xSOHhaRWo1?=
 =?utf-8?B?cnlnNjZYSCtsd3FFNFh0ZkFCa2NGRXo4a3grNHN0VUdkUzJHL1NWdHFpaHZt?=
 =?utf-8?B?MWRnWGxpeWtSL1pFcTEyUU4vRHpkaFFGTU9tMlVTUXRUN0xWMjVqRWlnR1RY?=
 =?utf-8?B?UjJTOFlzTitPaUN2Q3JKbU9QWUFENzV2emtyUythQW5VT2hrNTUyNVU3dVRD?=
 =?utf-8?B?aFM2L05mZVQzSGtZV1ZaQ2VwR3lndVFNN2JVSXN4NnQwUFdjYkVjbzhTT3Vr?=
 =?utf-8?B?YzlXMWVCd09XbDdFZnJRRE9iSHNDK0c4eDR6dlFmTm55K3IyZUhCbGgvMVUz?=
 =?utf-8?B?UWFsMUhRQ3hkbGc3YUpMaW9zSVFTakxyYUo1WmFsY0tuTXdZUXhUb0d1V0hl?=
 =?utf-8?B?b211eDlNT09CWU5JOW1CcW0vNURramx5MlprTExWZVV1UHVEWU95OW1Pd0Rv?=
 =?utf-8?B?U0NVc0JRb21IVHhqdVhJUnJaT2d3a1JidkpzbGhzdnVqUGthUnljQWZkZEZX?=
 =?utf-8?B?VGRGS0pqeFB4NS81elE0cjFjWCt1Rmk3RVpiQVFNNy9iZ3RTMVQ2QlVWRGpw?=
 =?utf-8?B?aFp1bFo0cDExbEJCU2EvdTlVSWIwZyswYlhmbWRwVXZlWU1aeUx1c1FTQzRX?=
 =?utf-8?B?bVk4YUpKdmlvQ2ZudXZSbFNTeTZET0VQZkRreUVQTitJL1FYL2pQMDVkd1dV?=
 =?utf-8?B?Ti9TcVFybnJ3RWFWTXhPU0Fuamd3VlIyVjVzdVVEdDNhNlBGK25YMDU3K2Iw?=
 =?utf-8?B?dnpGanNjQm5jNE1qQnpkK3Bydlp4UllwckJ3allrdm02czhvdDQrSHJKN2lQ?=
 =?utf-8?B?aXFrblJScjRhaGppT1FBSlZBd0txbGl0TTc3aWRRTTgzdTJMYlNmUGxwUmJo?=
 =?utf-8?B?Qy8xb05nVmg4a2NlZk1DL3Vzc0VLb25OMUkvdHdMTU1BdStZOGgwdWc4b2dN?=
 =?utf-8?B?am1uMzlYZUg1NHlRY2svYmkzU0VoMDJNVmVlT1JyUXZOR1JtTHBpSGszQTV2?=
 =?utf-8?B?VUU0dkpGRmMyMWhHajVsUHdlTlBqK1owalNuTTdLamVmQnR6bUVlVERlZUM5?=
 =?utf-8?B?em9jNnVhaDg0YW52aHhlS2JMTkZ5WUJjWmNCYk5PaVFaaXFycEtYR1JZUkd4?=
 =?utf-8?B?UkU0UkRoL0NjeGV3OFFCcFZOY0Z5eXd2YjhsZnZvS0QrNDBycXNyQ2tuNElI?=
 =?utf-8?B?R1JiUit5M0hnRENKMWxXVDhFVXl2VGcwZDJ4cTlvV2NvbTFWVU82YmNUbTlo?=
 =?utf-8?B?TmtOWUFzQmZEVVlBWC9yNkFETWVhYW9qZ3NCZTM3ckh2RWRZN1NKa01NNUVE?=
 =?utf-8?B?NmNKaEhNaXFvZlBlQ2p6WC9nY0VNMkNudG1tdXIyUmxiMnVoMmdTMzNoTEtp?=
 =?utf-8?B?cmZ3b21xa3djRHNvTEt0V0Qybk1tNnNCdmFZZDJPOW5VK1p6SHhpd3hLbGhz?=
 =?utf-8?B?aHdBZm12emREZE5iQ1duYWQ3Nnd5ZkNNMmJpbGxDQ3RSYTVzTWtxQ0VUd3l3?=
 =?utf-8?B?enJheW16UG1RVGZWWnJ4cnFpS0hkb3hwMlBNeGR4V0dVSU9JWi9XVVBhVFlM?=
 =?utf-8?B?bzZXSzFKcXBsdUpMbVZGOUp3WGFHUmEvQU9aTVNwRHhXUWNxRjZPT3VMV28r?=
 =?utf-8?Q?F9Tcp4rCeunbjA0c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDF6D59EE785A043A7DED1638A9CFE53@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Rbs9kTq7+cgg4zOy0DDjsFNthAWrq0EXsjq9XExowjPUelSYxNcKsfxbZWLEXu7MhU0yxTxdKKspP9Dap4ARtmdq8pQlukM+p8rCmYtjf4kel8Na2pkz4LnKtDz81rejnUZeGaAZ+4AXnU1LglZHeOP1kQudVeUPhE8DjopyYbomqpQoafDSDRMDMjTGD0Q3EIoHCj/D3VOedy8lJzuIO4cpNmA4Sbt+xgmgFBPgfLJ7KqLN/FUnXUFxEXypF3VHewPM7W3khfgcMVjRZCgafyLj71vrqgXTJTbyfHys5ILFqurmTeklCP/aMJGazXUFKg4MUihZkCBYDJdtELB3Iw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xivpAW7jicWMvhfSLBHP+LXLbdCZzk5JaKSsMHhMVFN5fsEfzAWXt2stKPa4ZXpU7+ZO79mni7IM8NnRpJA3oDyOPHamm7vCqX2fr/yQmnCJDE74xGTwP52ht1wQFyxqTd82ZOIQi9jlYMxVw/bf3iWz5ak/3q//KW57YedOqi/ip8Bxavg2sibBSRoFi5jVHDZogIFe2WAaoC/+uegVwM2JSauv8ITKwaEf7mXk8qgokPThXGgibjKgvvRp9ocXoAjIEu3Og7PRPyVG0qAW48aG6dVR4smL790Cmhv51eT/GsANagKPvoQvDnS2spaHgSkY2AA8HTLUYU5KJLUPOXEZxyjBtL6/xiiiKGZm8tsem5WbkFhbaprUu0OgvBWLDgH13uktRRlbajtBi/QXMACRwF25Msr994h6TF4QLude83wdRZhHXPwTBRZ+TOMTJaWMAqwafY5nzS04Ai1Ubem5XkshKCbFRmxjijNK+zuS8l2kC2H/9DZZefWwFNYjtIxhPaItnUQ9AVD8OBP2jHI6rvONBm4jIzdVS/whAMELukHfpnnbFtdR5IsRHAh4A/jmh5z9VYrx0ex51twOhSFTKZCeSOUuIlvuQJzHnQo+RaAC6HLdnnNVBs1ZEnSf
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB8303.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b04e9b6-a941-4040-43a8-08de83c805c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 01:53:44.6064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fJtDu0iRoWfQdAt5vFr+u38NSyrOyy/3y/WzDkm7uMcbWBLDs2OMYIczjp/rBNwe2yTRC6SLfFeiH4ZA0atZng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6687
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-268389-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lwn.net,kernel.org,wdc.com,davemloft.net,vger.kernel.org,gmail.com,queasysnail.net,redhat.com,linuxfoundation.org,google.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[wilfred.mallawa@wdc.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,wdc.com:dkim,wdc.com:mid]
X-Rspamd-Queue-Id: 298B42A2A92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gTW9uLCAyMDI2LTAzLTE2IGF0IDE4OjMwIC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gVHVlLCAxNyBNYXIgMjAyNiAwMToyMToxMiArMDAwMCBXaWxmcmVkIE1hbGxhd2Egd3Jv
dGU6DQo+ID4gT24gTW9uLCAyMDI2LTAzLTE2IGF0IDE4OjAzIC0wNzAwLCBKYWt1YiBLaWNpbnNr
aSB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgMTcgTWFyIDIwMjYgMDA6NTM6MDcgKzAwMDAgV2lsZnJl
ZCBNYWxsYXdhIHdyb3RlOsKgIA0KPiA+IMKgWy4uLl3CoCANCj4gPiA+ID4gDQo+ID4gPiA+IEZv
ciB1cGNvbWluZyBXRCBoYXJkd2FyZSwgd2Ugd2VyZSBwbGFubmluZyBvbiBpbmZvcm1pbmcgdXNl
cnMNCj4gPiA+ID4gdG8NCj4gPiA+ID4gdXNlDQo+ID4gPiA+IHRoaXMgZmVhdHVyZSBpZiBhbiBl
eHRyYSBsYXllciBvZiBzZWN1cml0eSBjYW4gYmVuZWZpdCB0aGVpcg0KPiA+ID4gPiBwYXJ0aWN1
bGFyDQo+ID4gPiA+IGNvbmZpZ3VyYXRpb24uIEJ1dCB0byBhbnN3ZXIgeW91ciBxdWVzdGlvbiwg
SSB0aGluayB0aGlzIGZhbGxzDQo+ID4gPiA+IG1vcmUNCj4gPiA+ID4gaW50byB0aGUgImNoZWNr
aW5nIGEgYm94Ii4uLg0KPiA+ID4gPiANCj4gPiA+ID4gSSdtIGhhcHB5IHRvIGRyb3AgdGhpcyBz
ZXJpZXMgaWYgdGhlcmUncyBub3QgbXVjaCBhZGRlZCB2YWx1ZQ0KPiA+ID4gPiBmcm9tDQo+ID4g
PiA+IGhhdmluZyB0aGlzIGFzIGFuIGF2YWlsYWJsZSBvcHRpb24gZm9yIHVzZXJzLsKgIA0KPiA+
ID4gDQo+ID4gPiBJJ20gbm90IG11Y2ggb2YgYSBzZWN1cml0eSBwZXJzb24sIGFuZCBtYXliZSBT
YWJyaW5hIHdpbGwNCj4gPiA+IGRpc2FncmVlDQo+ID4gPiBidXQgSSBmZWVsIGxpa2UgaXQncyBn
b2luZyB0byBiZSBoYXJkIGZvciB1cyB0byBkZXNpZ24gdGhpcw0KPiA+ID4gZmVhdHVyZQ0KPiA+
ID4gaW4gYSBzZW5zaWJsZSB3YXkgaWYgd2UgZG9uJ3Qga25vdyBhdCBsZWFzdCBvbmUgcG90ZW50
aWFsIGF0dGFjaw0KPiA+ID4gOlPCoCANCj4gPiANCj4gPiBUcmFmZmljIGFuYWx5c2lzIGlzIHRo
ZSBhdHRhY2sgdmVjdG9yIHdlIGFyZSB0cnlpbmcgdG8gbWl0aWdhdGUNCj4gPiBhZ2FpbnN0DQo+
ID4gd2l0aCB6ZXJvIHBhZGRpbmcsIHdoaWNoIFRMUyBpcyBzdXNjZXB0aWJsZSB0byBbMV0uIEkg
dGhpbmsgdGhlDQo+ID4gaGFyZA0KPiA+IHBhcnQgaXMgZGVjaWRpbmcgdGhlIHBhZGRpbmcgcG9s
aWN5IGFuZCBiYWxhbmNpbmcgaXQgc3VjaCB0aGF0IHdlDQo+ID4gaGF2ZQ0KPiA+IHNlbnNpYmxl
IHBlcmZvcm1hbmNlLg0KPiA+IA0KPiA+IFRoaXMgc2VyaWVzIGFkZHMgcmFuZG9tIHBhZGRpbmcg
dG8gcmVjb3JkcyB3aXRoIHJvb20sIGEgc3Ryb25nZXINCj4gPiBwb2xpY3kNCj4gPiBJIHRoaW5r
IHdvdWxkIGJlIHRvIHBhZCBhbGwgcmVjb3JkcyB0byBtYXggcmVjb3JkIHNpemUgbGVuZ3RoLiBC
dXQNCj4gPiB0aGF0DQo+ID4gYWRkcyBhIG11Y2ggaGlnaGVyIHBlcmZvcm1hbmNlIG92ZXJoZWFk
LiBGb3IgY29udGV4dCwgd2hlbiB0ZXN0aW5nDQo+ID4gTlZNZQ0KPiA+IFRDUCtUTFMgd2l0aCA0
SyB3cml0ZXMgd2l0aCBhIHJlY29yZCBzaXplIGxpbWl0IG9mIDRrLCB3ZSBvYnNlcnZlZA0KPiA+
IGENCj4gPiA1MCUgcmVkdWN0aW9uIGluIElPUHMgb24gdGhlIGZpeGVkIG1heCByZWNvcmQgcGFk
IHBvbGljeSBhcyBvcHBvc2VkDQo+ID4gdG8NCj4gPiB0aGUgcmFuZG9tIHBhZGRpbmcgcG9saWN5
IGZyb20gdGhpcyBzZXJpZXMuDQo+IA0KPiBTb3JyeSwgSSByZWFsaXplZCB3aGVuIGkgaGl0ICJz
ZW5kIiB0aGF0IEkgcGhyYXNlZCBteSBwcmV2aW91cw0KPiBtZXNzYWdlDQo+IHBvb3JseS4gV2hl
biBJIHNheSAicG90ZW50aWFsIiBJIG1lYW4gc29tZW9uZSBhY3R1YWxseSBwcmVzZW50aW5nIGEN
Cj4gUG9DDQo+IGFuZCBhIENWRSBpcyBpc3N1ZWQgZm9yIGl0LiBIYXZlIHdlIHNlZW4gYW55IG9m
IHRob3NlPw0KDQpBaCByaWdodCwgSSBoYXZlbid0IHNlZW4gYW55IFBvQy9DVkVzIHdoaWNoIGNv
dWxkIGRpcmVjdGx5IGJlIGFkZHJlc3NlZA0KYnkgemVybyBwYWRkaW5nLg0KDQpXaWxmcmVkDQo=

