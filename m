Return-Path: <netdev+bounces-220183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A3BB44A75
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 01:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17D33A493B
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 23:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB79C2DCF65;
	Thu,  4 Sep 2025 23:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Dqd7O6JT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wXPDONjB"
X-Original-To: netdev@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D10A1E487;
	Thu,  4 Sep 2025 23:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757028695; cv=fail; b=U5C2GQugHaqNmJqXk2CYlLXqbmcL4utDMmtztGgkf2+RvhBHkTVq3lorORiPL1/DLiw8y6hdE5kxANGQCQ4uSZTmU5pO09IQvoEbsZr6109Ina9UMbyPs3+LK7wI0oLwmax2Z7a32bjGd68LSQw8oCLE1XH5um/XyXk3cTJlU8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757028695; c=relaxed/simple;
	bh=52BlgnOtB/d7JoMCbOkIqFYah9HlGIIrAXcZ8dWisU4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JdYZCxeLPxhKgcmRHMQow3IRHvJKjesjVN2FqVkCSxqwipKEDo6L2IgJJu28H3YZgbOYhU720vyuPdgZW2WMPhI/NRgKPPEvR+ugSwd1q6nxtMkl+Znb8Jc/UmsVlMFvMH7TVR+WHNAbgq4VJqqIqMYKVJP0Q0UHkbRkgsyT878=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Dqd7O6JT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=wXPDONjB; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757028694; x=1788564694;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=52BlgnOtB/d7JoMCbOkIqFYah9HlGIIrAXcZ8dWisU4=;
  b=Dqd7O6JTrXXxPAdJlopJ7rTkVErW4fP+YJ+XJ2NbCtHiEIP7YIRHuYku
   18IBtYHDrtnvlSlWrs45YGJXhk37njQXjywf02ROZ+FoEcZtp3mdGbF8I
   Rwu3qn2+j+ILgYKPoMw9JXv8JbiSKjb76t4wZXM1vBJryFp05YVyYqvRW
   naNPCugYZ7ps15ib3+NsmJon/tUrnI3GYiP85H5u4j/c3kkuqW4ZWv/jJ
   1qTTLdGAZ0yHTQ9Yu8m8N0E2TqjIn+KpjquCMVIUvg9zjPWSc4mOCZ0Ra
   QweufesC6qcah9mKlWz77+yRle6++92AZuLREVo/b7/Zy1YP3wqOxDGr5
   w==;
X-CSE-ConnectionGUID: 8TJwZ80VR3+bY65b/CnHzQ==
X-CSE-MsgGUID: WBbGEWRwTcGu7PvW1cg86w==
X-IronPort-AV: E=Sophos;i="6.18,239,1751212800"; 
   d="scan'208";a="108002233"
Received: from mail-bn8nam12on2055.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([40.107.237.55])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2025 07:31:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGihula0ctdmbgfXWmOaVEbkNKaW5AoC5vRVkespzmWQdhWbU93lYZRuRlFqfNCsCXlsLlxq0irw8Cun8aus7iKsxNMkbcT0AxNsI/Fh8yhq1x/Vis6QorMQPJ73BcRmlVf0AeuLCYfaWg3lkSs//mxhbYg2QRp5xd7Kh/qtBn39nDLvdwMfJAUuZZgWBrkt2p6KnpkkQK58g/8zbgY8nLwqy5imMV0bHvCP+hGDRUZupgUtpWSGiV2Z6W5gATgvi/rr4+Rdth7qPJH9NGywcX+RAPRZ1Qxz1H33PPw/Xp8AalwdTXgbPW8Rkznx8JQuLR1aa9dKOA6fHdh9uky3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52BlgnOtB/d7JoMCbOkIqFYah9HlGIIrAXcZ8dWisU4=;
 b=xi1PIrMHiaw0/0ILlqF8eBOAZiy/SeaT78TAzqUt6IpA3M4rCfG6W9uiln19dx7Zm0DMqO5e2NiPxWuGJI3Tp58HiPKnKC0JDOwJlT9Q+VGt5U4J33tf0GjQiw2G2gj0ebBzRKvUoBL81ROt9d75GNQCO2JYxf9LNDFlY15KBcDhBCo4H0Kn+mPrSW1ET6Moua0kcE5GkmRx4VerAAwfrffm55r7TI/GepYp4+JosmhaoFd9OIFUQExDIKjn/EtxPUcly/jAdgfbbUEXU8fsSgebzPVwKYTYAVbaDqv9Ee/uw8BVAx+/BX0vRq6fFdTcJ3sQhHhjf4in6PoPjU77Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52BlgnOtB/d7JoMCbOkIqFYah9HlGIIrAXcZ8dWisU4=;
 b=wXPDONjBg6DCo9PR9fyqd4pH4l35LNTnZUmCbpgwHKgN363BtawBicr1BP09AJ8UVjRjXvCE6oDz1/wGZH6ABnSaoSpnFbHRmE+qFcJJ4X6sbaTvaa9ckdTt8yCsTbDO03EerPpscyt6gxtXG8HMipIkWeXkiSHXuHGpUZ5vzRU=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by CH2PR04MB6998.namprd04.prod.outlook.com (2603:10b6:610:9c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 23:31:23 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.9031.014; Thu, 4 Sep 2025
 23:31:23 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "sd@queasysnail.net" <sd@queasysnail.net>
CC: "corbet@lwn.net" <corbet@lwn.net>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>, Alistair Francis <Alistair.Francis@wdc.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH v2] net/tls: support maximum record size limit
Thread-Topic: [PATCH v2] net/tls: support maximum record size limit
Thread-Index: AQHcG7sim/DTbd3pdkmC4DloIxkjarSAD9sAgABwvoCAAJ92gIACkIYA
Date: Thu, 4 Sep 2025 23:31:23 +0000
Message-ID: <00d28a79b597128b33b53873597f7ba2808ebbe6.camel@wdc.com>
References: <20250902033809.177182-2-wilfred.opensource@gmail.com>
	 <aLcWOJeAFeM6_U6w@krikkit>
	 <0ba1e9814048e52b1b7cb4f772ad30bdd3a0cbbd.camel@wdc.com>
	 <aLf6j73xSGGLAhQv@krikkit>
In-Reply-To: <aLf6j73xSGGLAhQv@krikkit>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|CH2PR04MB6998:EE_
x-ms-office365-filtering-correlation-id: 058c7d40-02bf-495e-44e8-08ddec0b2941
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M2ZiL3prQmdKZFdSVlBnZFRReGxacm9GQ3ArKzJ4bFVLMkhETFZQbDdVd2Yz?=
 =?utf-8?B?RFM4WmJ5WGxiMUthR0ZncUkzalM3TkZseWpMR0NSa0FuUmNJaUgzMHR2NHVR?=
 =?utf-8?B?bzVxOHV4SnNzaEpFSWR6QWxPaE5qK0tiZjA0MTN2N3VtcjdnTTdjQkVGWitx?=
 =?utf-8?B?M3U3bGFUQnc0Z25JVWR1OE1zZ3hHdTVkdXVTbjQ4T2Y5c3l1eWd5a3B2Mlhw?=
 =?utf-8?B?c1V3c0w0UUR6NURPRGRaUzYrNm9MM1ArNW5jSERreDh3VDBmVkxoTUlDTCtI?=
 =?utf-8?B?ZjlGNFl2QlpNeEVpU1hHU0UvdWFkRklXdlRRWm44V0ZuUEZzY1VxWDFiTG1t?=
 =?utf-8?B?cnhlSkwyVFdYcFpOWUw3WmdNUWkvdWFjWElUaUFsM2dMbG9wb1JPZnNmNmFJ?=
 =?utf-8?B?ZlpuT2NPSWJ0eDJkL0pGdVNQeVZMbXBTQmx3cHhpU0M4VXVieTg3dVducm9F?=
 =?utf-8?B?ejlOVVZzOXB5N2x5elVwNkdqbmhjeDNHNFBoRG1VbjN4NXlIUGZUWEVyUWVm?=
 =?utf-8?B?N3MvTDNaM3NCTnZKeHdDK3FZZ1lBV1pYZ244d1gyYW1sYXFXWUoxVy9IMS9h?=
 =?utf-8?B?RnZMVkEyd2xVbHZCUm9sVDA1eGNpT2ZuMkRJaDk1eUppT0hBZzZZQmtPbmZq?=
 =?utf-8?B?ZXZ3UlY2bU9QOHV5TmlQaHBXbEtZdk5mK09OUkRCM2tJSkx6aDZSTmxOYjZL?=
 =?utf-8?B?K2tSSFN5QW9YYzJHQ0FtenNJWkVhWmE5U1Nudk9uUlNnZXFwTENUTjRJYWxs?=
 =?utf-8?B?bnlsOFJSeDllVXJCUGFJZDN6SzF5V2xJZEkyQlRVTysvNU50cEk2Uy9pOTVS?=
 =?utf-8?B?TjM3NUlHRUl1R1lVWGwrR3hoM3N3RDMyRnI4Y2dOajhTU08zYWxPNUZ3RW5D?=
 =?utf-8?B?ZWxOTThpZFhhZnRGRXVscTZ1YVlwNno2RkYwMDErbFl0eWg0VWZzWWpHSUFQ?=
 =?utf-8?B?MW81ZjlMN1dHRDZ6dlRWb0V2d3BlYkd4a05Nd3FYYzdIclpKQ1diUmZsRGdq?=
 =?utf-8?B?OStycWxaYWVoSFRSd3VQMEpibjE1RlZEdTgrd0xSVUtwVkR4NCtvb2o0REU0?=
 =?utf-8?B?MCtUMkU4OGxnS28rSVBmdjNqRExKSXJPU3JqazJzalo4K2VBNXNiNjF6NVd0?=
 =?utf-8?B?Rml2bC9ncjg5c3JlekpJSmNlWnAyY09VUGdaNm9jQU15V0UyeWt3RHUrY0lQ?=
 =?utf-8?B?b2RmS0g2RzlMYkdwaWMyVHJxSElTZm8xcXNLOC9LY2FaK0djdmUwVXEzOUox?=
 =?utf-8?B?U2NRMGd4WWc0eG4yWVZ4QVZwcUlIaC9FOFFWckdvWmxqQWdRVUwxbk5WQW1q?=
 =?utf-8?B?WThUNjRYejJ3Ulg5L24zdDVaam5xc05GbUJSTmcvSmJHeGV4a3QzNExtQmVC?=
 =?utf-8?B?N09mdG5RdUVaSFBiWkQvaVJ2TS9EMDdPdnUvZ2wrSC94TXhlQVNUYStDRjFW?=
 =?utf-8?B?S2duaXpMeDM0NENBb1hYNlY0WWlsTkFFVlk3am9tTHBDQUhYY2VRRzNkRDBY?=
 =?utf-8?B?OURIT1d6MWZUS2ErbVdZNGFMeXlTaEtjVXZZNGpaSndTbUxFRUdXT2g0VkND?=
 =?utf-8?B?eG8xQ0h2YTNtOTVqbTFjUjJ4Z0R4Nnc5czNld3Y1MUNYdmNSSDU0MmdlR0k2?=
 =?utf-8?B?NDNkb1RUMUpQZlNWUkxqVDJ5NU1zcEd5YzY3OHpRY1dVaGhLWEpzb09sZUJB?=
 =?utf-8?B?UldraDRkUFU3djJLYS8vZmFzcW0zeEh0SmJpaGgzeFVLZEJwNTA1dThKMGpl?=
 =?utf-8?B?Y1l1aFlVYjRKR0ppVEJ4UjRGUGlMS2NvLzJqN1VJY1pTRlorWE85QktUYjM3?=
 =?utf-8?B?Nk1Ud25YU3NINjVXYzBkNHl4b0tLZTFGNFJpS0FrTjBFQWdqMEZDR3EyTFJU?=
 =?utf-8?B?Nk5heHFvdDV0YUNLbFhEYmthZ3BIQmFremNyZHZJTzIyenQxbkZMdFpXK0dZ?=
 =?utf-8?B?RVpTQzJraDBTWEdkWlVpaXlvZy9JNGZoSE9iWTJjQTZxd1VxQ3E4MXIvVzNK?=
 =?utf-8?Q?AOT6vgUlRL1Rddm8a0PP/L88+Oarhw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L1ZJOXNMaUJYMjZyWVhEdGhFZ2toVjJVTW5KbzJXK3pzL1pqUndGL2NtUEJN?=
 =?utf-8?B?Smk1NDExSzlHd3BYeGRDSE1LMWVPeUpHakErRXAwdlVOYWF5aDdPZDNrYXQw?=
 =?utf-8?B?NEhWTGl0eXpPWHBZOHoxZHZqTDZOdW5rMHROZ0t2Q3ExSVJrYkE2S3UyRXpP?=
 =?utf-8?B?aW5JY3FhemhpL2VsVXkrZmlVVzZTdFM1R3BYQzZmUHpkb1pRaWNWRHR4VDcr?=
 =?utf-8?B?TDZtdmhkVmV4RWNuWVlPalRwV2dycWFYbkYvZjdxSHBoeXpNbEJBZVVjb3Zj?=
 =?utf-8?B?M3ZabVVzSFZxTVZJMFpoa255QjR0T3FGUzljZ1NRbUhHOHJhT2s5UTRMYVIx?=
 =?utf-8?B?dWk0aWE1ek1RbnFrU0EzeGh4Q20xVk83dXcrQm5IY3lnSHRWOVRpcFJYY1JN?=
 =?utf-8?B?MUpJYzVwMGxQSW5FQUIvWUs3NHkxekpQbFZ3dVdtd2JDNWh3cGtoN2QxcU00?=
 =?utf-8?B?NDBSbEtJNFVaVWo3b01rNXZJSXMwYms4dGZiU1NVNDJTNmRUNWRnVjVDMmpk?=
 =?utf-8?B?NWJqZXgzUEFwODBjcjZzOWdnUGcwZnVCaDgybGo4VWVrTklZWTdEa24wUWpC?=
 =?utf-8?B?SVQ3Z0t3VVdwZ2xuc2x0eTQ3RUY0Q1R3NHZGV1lIMWJrMG05R3M2cC9tWXM1?=
 =?utf-8?B?bWY4dGMrNWZtYjZYaWdkK1E2cy9ORU9wS0p0K0NFS0ZRTkZKKzZrbDRnb3pJ?=
 =?utf-8?B?aHBVYXM3TzF3MFpVWUZyUmtwZFU5ZXZEV0ZJSlAwZEo2MkR1RUNRTjQ1TjBJ?=
 =?utf-8?B?Q3V0UmJtS1dVSzluZUF0UmJGOFdSQmZHdDJHTUUydGVPMjBsNnhUdVFNbnYw?=
 =?utf-8?B?QkU3aHBWMzl4eG0rVEpieFpSSjFORmxIaENGbWZWaThrZkoxVGN2Z2VhR0ZE?=
 =?utf-8?B?cVJBbTI0bSt2WVVmaHp1aHVqQW8xRWNYekY1eEltY2JXZ2dkRG04SHc1RkM5?=
 =?utf-8?B?aTVTL0Q5a252eW9xc2RGcjRmRUg4MUFtMm5ZbTdFc3R0WHZGTU1HNmV3eENR?=
 =?utf-8?B?b2ZwcFdRS29WeHl3V1dLMjREeXFDRlZFaXYyWVFMNFIza3pobjhVWWNrbEFI?=
 =?utf-8?B?TTZodmNtdTJPbmgvRTNSTHE4YnpGMXVVOEdFYVdqUkZiT0pyT3FrZEZsTlFT?=
 =?utf-8?B?OXB2L3I4RUtVbkQxQ0RpWVVLUmpPZWUwbGxzMG1kcHpTOS96dDRmUWxsalVS?=
 =?utf-8?B?bEd0Z1VueHZKQVV5VHhUMnBhZEVDeEpYR0ZsSTlqa1hUTnczQ1YxZ3Ywekl0?=
 =?utf-8?B?cDRmSWNxL0JpN3Rzc1hheHNxajZKZ0QvZkd3QTZjaFI2eE9EUGZrdnNGVVdn?=
 =?utf-8?B?dms0OFhiWmFNd1NUUHhxTDFobG9OSzl6d08xUkp6U01BTVlJdmJGREJ6QWp5?=
 =?utf-8?B?NmlablZZaHExMm1HdTFBL3dQaDNiaHZ4ZXQyWHBka0RQL21PNWwrV3RSVVkw?=
 =?utf-8?B?bDJ0TVdjd0gvOVArZXdoTVFwWXcrK3Bpa3RRRnZKTDEwb1VmSHIwczVOTVAy?=
 =?utf-8?B?cHJpNnBsUk82bWMreDVCeFJxU3JaMUQ5K24zRFNOeFV3K0RkUFFXUDBjblhU?=
 =?utf-8?B?R3R1YUVGbjczeVBoTHk0MForL2hCcUxjVVhWeUVualByUG52eS9jQUx3cGZt?=
 =?utf-8?B?dEwrcHNPZ044aUNlWEFmWnVPWjU1NE8wY3JRODZVdGx3cWRQTkcyT3JCUUlv?=
 =?utf-8?B?NzhPREw1VmRORldCcVFpZWtqaXJXbUt5aXhVTjlxelk2WkVWVU9ZQWhyeDg4?=
 =?utf-8?B?NG5MaGNEcEpaMFZRUFVaaGc2UGpwRDVMMjJzUzFWR2x1cHNTdWxidGVTbUR4?=
 =?utf-8?B?QXQwZHM2clJxa1duR3JsN2JpMlozK1Y1WTFTZGhGNjIzeGhKcmd0VS8wMzkr?=
 =?utf-8?B?V2NVTXlnaUN3WU5wd2NEVU9oU1NQd01NY1ZhaUxSbm5IL1ZNdXhkMXlqWU5J?=
 =?utf-8?B?NEVoam9KYkZjTVBrb3RoQzFvYW80VlZDbk92YmZiZjU3Tm91bkhWekZyWGZh?=
 =?utf-8?B?Zmw3ZmpHMGIwYm11MXp2U3F3S2ZxUTVzbEdXdHRsa2w0dUZ3VGc5TkNFaE1B?=
 =?utf-8?B?YytFYWV6dVBFZmlpVWZVOVJsdUo5dFdWK1FQUW1RRGpxaDMvZUN5MTI0MnB4?=
 =?utf-8?B?ME5vSUgxMjhlN0FRV2xXTjRvR1NrYVhTMHB1SU96SW12TU5aR2wxMUFIbERl?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41A92E1725CBD54BA6272C3A4EAA8A56@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rK9fOsUr+7nkd7MKV5wEDk7p1ajKe4118rn4w94y132XmIjuSMvyNZRzT1UIq+ECxnr0OUVIks9TWywk5Bs2Qsa49gbdS+rd3htiQxxTg/vEQNPcps3FYFzOLRKFoGymP/SX61YAIQwcZkXCcqEwQTms18oMwWIYcM/uy8ThfFxVIWjt4KY7hlR8X6l4SOEX35SKf9Bfu3opPsT2bsaqLp9x5g8tcXSWQW2rcAfONFm3gqbEi1Obk5XhyqAYmfi4NVFsgnFhBk30+tXgv/VysevIzXGzjTZi7nCXReaqjz87kiXy6wG2y+GM7BeTvzkUxvAwdER08Bt4I2mkgZ56XtzyX52G3k5OiSmM4knvI60VK2dPmIDwJimwhCvyjwY830rqILfiV6Lf+ueD3UczCdM/J6iFzqT/L3BKBIAe+zT1tbOo5Z+9QQIeFVRbINa7GFAVEwirRsCxjJQUrm2+LSaoEJdoRrpRxv+e7cIZFjfo8+w4KNEHR27AMmTfYfu0Vz8u0foGBP7f/fqhCJ2V1OeOV4pvrYZ6tfQFJ3Lwn3v+5fcKEQAdSZsNa1x2hiCXdZCFQ8yEmWIB4bi3qkWBP65dtp6q+nBdD0nuEb1NYPm1uuWLiQwtJy4cEwzTacZF
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 058c7d40-02bf-495e-44e8-08ddec0b2941
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 23:31:23.6845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dm3fcQrzElKmPW7T1GKS7yOvGYlkrGbb0JjIwg9vePcSVDs3KyyESm0ivyIkWYR1Qinyraq7jXHYHwmNBUfspw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6998

T24gV2VkLCAyMDI1LTA5LTAzIGF0IDEwOjIxICswMjAwLCBTYWJyaW5hIER1YnJvY2Egd3JvdGU6
DQo+IDIwMjUtMDktMDIsIDIyOjUwOjUzICswMDAwLCBXaWxmcmVkIE1hbGxhd2Egd3JvdGU6DQo+
ID4gT24gVHVlLCAyMDI1LTA5LTAyIGF0IDE4OjA3ICswMjAwLCBTYWJyaW5hIER1YnJvY2Egd3Jv
dGU6DQo+ID4gPiAyMDI1LTA5LTAyLCAxMzozODoxMCArMTAwMCwgV2lsZnJlZCBNYWxsYXdhIHdy
b3RlOg0KPiA+ID4gPiBGcm9tOiBXaWxmcmVkIE1hbGxhd2EgPHdpbGZyZWQubWFsbGF3YUB3ZGMu
Y29tPg0KPiA+IEhleSBTYWJyaW5hLA0KPiA+ID4gQSBzZWxmdGVzdCB3b3VsZCBiZSBuaWNlICh0
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvdGxzLmMpLCBidXQNCj4gPiA+IEknbQ0KPiA+ID4g
bm90IHN1cmUgd2hhdCB3ZSBjb3VsZCBkbyBvbiB0aGUgIlJYIiBzaWRlIHRvIGNoZWNrIHRoYXQg
d2UgYXJlDQo+ID4gPiByZXNwZWN0aW5nIHRoZSBzaXplIHJlc3RyaWN0aW9uLiBVc2UgYSBiYXNp
YyBUQ1Agc29ja2V0IGFuZCB0cnkNCj4gPiA+IHRvDQo+ID4gPiBwYXJzZSAoYW5kIHRoZW4gZGlz
Y2FyZCB3aXRob3V0IGRlY3J5cHRpbmcpIHJlY29yZHMgbWFudWFsbHkgb3V0DQo+ID4gPiBvZg0K
PiA+ID4gdGhlIHN0cmVhbSBhbmQgc2VlIGlmIHdlIGdvdCB0aGUgbGVuZ3RoIHdlIHdhbnRlZD8N
Cj4gPiA+IA0KPiA+IFNvIGZhciBJIGhhdmUganVzdCBiZWVuIHVzaW5nIGFuIE5WTWUgVENQIFRh
cmdldCB3aXRoIFRMUyBlbmFibGVkDQo+ID4gYW5kDQo+ID4gY2hlY2tpbmcgdGhhdCB0aGUgdGFy
Z2V0cyBSWCByZWNvcmQgc2l6ZXMgYXJlIDw9IG5lZ290aWF0ZWQgc2l6ZSBpbg0KPiA+IHRsc19y
eF9vbmVfcmVjb3JkKCkuIEkgZGlkbid0IGNoZWNrIGZvciB0aGlzIHBhdGNoIGFuZCB0aGUgYnVn
DQo+ID4gYmVsb3cNCj4gPiBnb3QgdGhyb3VnaC4uLm15IGJhZCENCj4gPiANCj4gPiBJcyBpdCBw
b3NzaWJsZSB0byBnZXQgdGhlIGV4YWN0IHJlY29yZCBsZW5ndGggaW50byB0aGUgdGVzdGluZw0K
PiA+IGxheWVyPw0KPiANCj4gTm90IHJlYWxseSwgdW5sZXNzIHdlIGNvbWUgdXAgd2l0aCBzb21l
IG1lY2hhbmlzbSB1c2luZyBwcm9iZXMuIEkNCj4gd291bGRuJ3QgZ28gdGhhdCByb3V0ZSB1bmxl
c3Mgd2UgZG9uJ3QgaGF2ZSBhbnkgb3RoZXIgY2hvaWNlLg0KPiANCj4gPiBXb3VsZG4ndCB0aGUg
c29ja2V0IGp1c3QgcmV0dXJuIE4gYnl0ZXMgcmVjZWl2ZWQgd2hpY2ggZG9lc24ndA0KPiA+IG5l
Y2Vzc2FyaWx5IGNvcnJlbGF0ZSB0byBhIHJlY29yZCBzaXplPw0KPiANCj4gWWVzLiBUaGF0J3Mg
d2h5IEkgc3VnZ2VzdGVkIG9ubHkgdXNpbmcga3RscyBvbiBvbmUgc2lkZSBvZiB0aGUgdGVzdCwN
Cj4gYW5kIHBhcnNpbmcgdGhlIHJlY29yZHMgb3V0IG9mIHRoZSByYXcgc3RyZWFtIG9mIGJ5dGVz
IG9uIHRoZSBSWA0KPiBzaWRlLg0KPiANCkFoIG9rYXkgSSBzZWUuDQo+IEFjdHVhbGx5LCBjb250
cm9sIHJlY29yZHMgZG9uJ3QgZ2V0IGFnZ3JlZ2F0ZWQgb24gcmVhZCwgc28gc2VuZGluZyBhDQo+
IGxhcmdlIG5vbi1kYXRhIGJ1ZmZlciBzaG91bGQgcmVzdWx0IGluIHNlcGFyYXRlIGxpbWl0LXNp
emVkIHJlYWRzLg0KPiBCdXQNCj4gdGhpcyBtYWtlcyBtZSB3b25kZXIgaWYgdGhpcyBsaW1pdCBp
cyBzdXBwb3NlZCB0byBhcHBseSB0byBjb250cm9sDQo+IHJlY29yZHMsIGFuZCBob3cgdGhlIHVz
ZXJzcGFjZSBsaWJyYXJ5L2FwcGxpY2F0aW9uIGlzIHN1cHBvc2VkIHRvDQo+IGRlYWwNCj4gd2l0
aCB0aGUgcG9zc2libGUgc3BsaXR0aW5nIG9mIHRob3NlIHJlY29yZHM/DQo+IA0KR29vZCBwb2lu
dCwgZnJvbSB0aGUgc3BlYywgIldoZW4gdGhlICJyZWNvcmRfc2l6ZV9saW1pdCIgZXh0ZW5zaW9u
IGlzDQpuZWdvdGlhdGVkLCBhbiBlbmRwb2ludCBNVVNUIE5PVCBnZW5lcmF0ZSBhIHByb3RlY3Rl
ZCByZWNvcmQgd2l0aA0KcGxhaW50ZXh0IHRoYXQgaXMgbGFyZ2VyIHRoYW4gdGhlIFJlY29yZFNp
emVMaW1pdCB2YWx1ZSBpdCByZWNlaXZlcw0KZnJvbSBpdHMgcGVlci4gVW5wcm90ZWN0ZWQgbWVz
c2FnZXMgYXJlIG5vdCBzdWJqZWN0IHRvIHRoaXMgbGltaXQuIiBbMV0NCg0KRnJvbSB3aGF0IEkg
dW5kZXJzdGFuZCwgYXMgbG9uZyBhcyBpdCBpbiBlbmNyeXB0ZWQuIEl0IG11c3QgcmVzcGVjdCB0
aGUNCnJlY29yZCBzaXplIGxpbWl0Pw0KDQpJbiByZWdhcmRzIHRvIHVzZXItc3BhY2UsIGRvIHlv
dSBtZWFuIGZvciBUWCBvciBSWD8gRm9yIFRYLCB0aGVyZQ0Kc2hvdWxkbid0IG5lZWQgdG8gYmUg
YW55IGNoYW5nZXMgYXMgcmVjb3JkIHNwbGl0dGluZyBvY2N1cnMgaW4gdGhlDQprZXJuZWwuIEZv
ciBSWCwgSSBhbSBub3QgdG9vIHN1cmUsIGJ1dCB0aGlzIHBhdGNoIHNob3VsZG4ndCBjaGFuZ2UN
CmFueXRoaW5nIGZvciB0aGF0IGNhc2U/DQoNClsxXSBodHRwczovL2RhdGF0cmFja2VyLmlldGYu
b3JnL2RvYy9odG1sL3JmYzg0NDkjc2VjdGlvbi00DQo+IA0KPiBIZXJlJ3MgYSByb3VnaCBleGFt
cGxlIG9mIHdoYXQgSSBoYWQgaW4gbWluZC4gVGhlIGhhcmRjb2RlZCBjaXBoZXINCj4gb3Zlcmhl
YWQgaXMgYSBiaXQgdWdseSBidXQgSSBkb24ndCBzZWUgYSB3YXkgYXJvdW5kIGl0LiBTYW5pdHkg
Y2hlY2sNCj4gYXQgdGhlIGVuZCBpcyBwcm9iYWJseSBub3QgbmVlZGVkLiBJIGRpZG4ndCB3cml0
ZSB0aGUgbG9vcCBiZWNhdXNlIEkNCj4gaGF2ZW4ndCBoYWQgZW5vdWdoIGNvZmZlZSB5ZXQgdG8g
Z2V0IHRoYXQgcmlnaHQgOikNCj4gDQpIYSEgR3JlYXQhIFRoYW5rcyBmb3IgdGhlIGV4YW1wbGUu
IEkgYW0gbm90IHRvbyBmYW1pbGlhciB3aXRoIHRoZSBzZWxmDQp0ZXN0cyBpbiB0aGUga2VybmVs
LiBCdXQgd2lsbCB0cnkgdG8gaXQgZm9yIHRoZSBuZXh0IHJvdW5kLg0KDQpUaGFua3MsDQpXaWxm
cmVkDQo+IA0KPiBURVNUKHR4X3JlY29yZF9zaXplKQ0KPiB7DQo+IAlzdHJ1Y3QgdGxzX2NyeXB0
b19pbmZvX2tleXMgdGxzMTI7DQo+IAlpbnQgY2ZkLCByZXQsIGZkLCBsZW4sIG92ZXJoZWFkOw0K
PiAJY2hhciBidWZbMTAwMF0sIGJ1ZjJbMjAwMF07DQo+IAlfX3UxNiBsaW1pdCA9IDEwMDsNCj4g
CWJvb2wgbm90bHM7DQo+IA0KPiAJdGxzX2NyeXB0b19pbmZvX2luaXQoVExTXzFfMl9WRVJTSU9O
LA0KPiBUTFNfQ0lQSEVSX0FFU19DQ01fMTI4LA0KPiAJCQnCoMKgwqDCoCAmdGxzMTIsIDApOw0K
PiANCj4gCXVscF9zb2NrX3BhaXIoX21ldGFkYXRhLCAmZmQsICZjZmQsICZub3Rscyk7DQo+IA0K
PiAJaWYgKG5vdGxzKQ0KPiAJCWV4aXQoS1NGVF9TS0lQKTsNCj4gDQo+IAkvKiBEb24ndCBpbnN0
YWxsIGtleXMgb24gZmQsIHdlJ2xsIHBhcnNlIHJhdyByZWNvcmRzICovDQo+IAlyZXQgPSBzZXRz
b2Nrb3B0KGNmZCwgU09MX1RMUywgVExTX1RYLCAmdGxzMTIsIHRsczEyLmxlbik7DQo+IAlBU1NF
UlRfRVEocmV0LCAwKTsNCj4gDQo+IAlyZXQgPSBzZXRzb2Nrb3B0KGNmZCwgU09MX1RMUywgVExT
X1RYX1JFQ09SRF9TSVpFX0xJTSwNCj4gJmxpbWl0LCBzaXplb2YobGltaXQpKTsNCj4gCUFTU0VS
VF9FUShyZXQsIDApOw0KPiANCj4gCUVYUEVDVF9FUShzZW5kKGNmZCwgYnVmLCBzaXplb2YoYnVm
KSwgMCksIHNpemVvZihidWYpKTsNCj4gCWNsb3NlKGNmZCk7DQo+IA0KPiAJcmV0ID0gcmVjdihm
ZCwgYnVmMiwgc2l6ZW9mKGJ1ZjIpLCAwKTsNCj4gCW1lbWNweSgmbGVuLCBidWYyICsgMywgMik7
DQo+IAlsZW4gPSBodG9ucyhsZW4pOw0KPiANCj4gCS8qIDE2QiB0YWcgKyA4QiBJViAtLSByZWNv
cmQgaGVhZGVyICg1QikgaXMgbm90IGNvdW50ZWQgYnV0DQo+IHdlJ2xsIG5lZWQgaXQgdG8gd2Fs
ayB0aGUgcmVjb3JkIHN0cmVhbSAqLw0KPiAJb3ZlcmhlYWQgPSAxNiArIDg7DQo+IA0KPiAJLy8g
VE9ETyBzaG91bGQgYmUgPD0gbGltaXQgc2luY2Ugd2UgbWF5IG5vdCBoYXZlIGZpbGxlZA0KPiBl
dmVyeQ0KPiAJLy8gcmVjb3JkIChlc3BlY2lhbGx5IHRoZSBsYXN0IG9uZSksIGFuZCBsb29wIG92
ZXIgYWxsIHRoZQ0KPiAJLy8gcmVjb3JkcyB3ZSBnb3QNCj4gCS8vIG5leHQgcmVjb3JkIHN0YXJ0
cyBhdCBidWYyICsgKGxpbWl0ICsgb3ZlcmhlYWQgKyA1KQ0KPiAJQVNTRVJUX0VRKGxlbiwgbGlt
aXQgKyBvdmVyaGVhZCk7DQo+IAkvKiBzYW5pdHkgY2hlY2sgdGhhdCBpdCdzIGEgVExTIGhlYWRl
ciBmb3IgYXBwbGljYXRpb24gZGF0YQ0KPiAqLw0KPiAJQVNTRVJUX0VRKGJ1ZjJbMF0sIDIzKTsN
Cj4gCUFTU0VSVF9FUShidWYyWzFdLCAweDMpOw0KPiAJQVNTRVJUX0VRKGJ1ZjJbMl0sIDB4Myk7
DQo+IA0KPiAJY2xvc2UoZmQpOw0KPiB9DQo+IA0K

