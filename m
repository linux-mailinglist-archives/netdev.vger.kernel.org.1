Return-Path: <netdev+bounces-223999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F86B7D908
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3049B16221C
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 12:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215AB31A807;
	Wed, 17 Sep 2025 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="s1j5At0b"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2B231A802;
	Wed, 17 Sep 2025 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111892; cv=fail; b=BE1bY2RUMOGVS3ux9TX3Ck1qtzzR5Tksx6K8eF0pPd0PxxbNaCpyNY041aOJDvdOrogVBaURi9cdevaM/OPFWXJ3/8UuxvF1Hdg5ads9HtMehpqgb33bAexTAC++LKW6aUeNFEva02gL51zRg9oE9NifIyUQh6PwRr6mZyg+iNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111892; c=relaxed/simple;
	bh=mVt7m/tWHU/0fC0sbHqp3cU7Kz2bJ61ciHr3IaAh078=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WWyydUkA8tnRIxF/v5vHleG1WaJYf3XVZr6t4t0MuNexNBNgIKRmzUNBAYW3+rKrDGsh1UtBNClmbHRgR6ZJE4MSqgmQIbf064BYXSL8myfMXs1cDzFt2B7Tt/vTAjt4mUvwmUrP1wuV2eTxOJYYXJb/psj5p1ewF9HQJ7KpL2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=s1j5At0b; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HC0ARb017177;
	Wed, 17 Sep 2025 05:24:27 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2104.outbound.protection.outlook.com [40.107.93.104])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 497vm1g1n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 05:24:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCiDTpkUXIYXYlQMjCZF5YLsffjRWLE3VZzeHIHw7RoWhxOHbH2unJD8AlBQEjpMgrNwUOuMmPSpWUic7utzcmeDfooMPuBQQlG+zjYHe7MlOQsaKJLRRC7karF2iyIEn3bzWqa150yQK6Cgw1xq5I2oV9IIStEpYe0UDEKM0tP6BaBmk38zQt5TGB1PV3yNIwTCOZS50+h494zry+fFzsMaZHfHhv1yKplOqajjYAoIQ+Yl8/yZrmcXyWnXUIDBci1gryBJ6bHI4CmNr1AUSqv5XZWbLaxE7YxDy+hqDYNLtRS5RcmTJav5IcmWKzYMec1LiUwWRIzqNvLK7SGAtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVt7m/tWHU/0fC0sbHqp3cU7Kz2bJ61ciHr3IaAh078=;
 b=TGJzdnSlw20g5hUm5GFB3BXcM84mR+g22/8y8hXDTkLPUp9o+y+cT8MiyLSupwIAGaGyZBxlTQM4NXtmYwIsE4QhLAXW5B0IJsdqsdS0WO5Indqw4XY+v8wpmU1TI7Nm9Bebw6ql5wJXwlIMYa/pq3AC71v06i9JKI18U+rDe8zZ1Nvgth4vDtrBbqzr5V0PgZWmRhh+gwwSSbQII4/W/HEqNvT3E+PdprDNuRfVTjDUGd8U1ILLtQ7DyYZAgFExaEUuXcSXwIXXYzVhbvNPM6rWz0q4TdW/LtXbUBsyRGIcQK1I1bbsXlAQWFtoL+IL/miO6/hmkj+VQUSpIf8/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVt7m/tWHU/0fC0sbHqp3cU7Kz2bJ61ciHr3IaAh078=;
 b=s1j5At0bfKhTw1hCdy2eSx/dleEfZSO7d6NZSoarEsnISmQVzfJkpdjHjRvh3ImjbYUBCDa8Vd/toLOlKDYaDxZNXG9QSXpAT3KiX9CMK7vAuinLHFWfEjgzlk6QpNnmsBuAVWGNRngk8sgUuA6tdUyWKdi3os/1OajKgfuDinQ=
Received: from CO1PR18MB4747.namprd18.prod.outlook.com (2603:10b6:303:ea::11)
 by CH0PR18MB4292.namprd18.prod.outlook.com (2603:10b6:610:d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 12:24:22 +0000
Received: from CO1PR18MB4747.namprd18.prod.outlook.com
 ([fe80::412f:1737:b585:89d6]) by CO1PR18MB4747.namprd18.prod.outlook.com
 ([fe80::412f:1737:b585:89d6%5]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 12:24:22 +0000
From: Sathesh B Edara <sedara@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Satananda
 Burla <sburla@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        Haseeb Gani <hgani@marvell.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>,
        Shinas Rasheed <srasheed@marvell.com>
Subject: RE: [EXTERNAL] Re: [net PATCH v2] octeon_ep: Clear VF info at PF when
 VF driver is removed
Thread-Topic: [EXTERNAL] Re: [net PATCH v2] octeon_ep: Clear VF info at PF
 when VF driver is removed
Thread-Index: AQHcJwuV4VH+kPfQl0+VdezhIoOWVbSXReUAgAAHRaA=
Date: Wed, 17 Sep 2025 12:24:22 +0000
Message-ID:
 <CO1PR18MB47473C9867B184DDDB51E1C5D817A@CO1PR18MB4747.namprd18.prod.outlook.com>
References: <20250916131225.21589-1-sedara@marvell.com>
 <20250917115542.GA394836@horms.kernel.org>
In-Reply-To: <20250917115542.GA394836@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4747:EE_|CH0PR18MB4292:EE_
x-ms-office365-filtering-correlation-id: f0851a07-5f35-4cde-0c47-08ddf5e52206
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NWVIb21NcVJBMi9QcXJCaFFQblluL0tDQVFYV1VlRDVsTW9zSUZUaVQ1c3JM?=
 =?utf-8?B?UUoxMWJFK1NNaTFmakJENnNsTGlNcTY5Z05GSzB6YkYxbU1BVzJvL2Nod0J6?=
 =?utf-8?B?TThsQ05uN0VwZ3hJVTJQWEZqV29lNXlDdmt0ZVlOOHkwOUFHckN2d1EyaE1x?=
 =?utf-8?B?cUlGeWgvSERydkNXdVNLdTVhYzVqMlR4dGluTDg3MWZmcDBuREEzSldlMjR3?=
 =?utf-8?B?MGc2M1dRR2VXcENhR0U2S3IyRTF6bTlRcEJXV08xMmhYeUJyS1hhdGw5Ly9Q?=
 =?utf-8?B?Wlg4enhjUHhrU1B6VHYxeEdDVDBJbmZhYXdSUUp2TEVNeTJVODlaOXg5RGpP?=
 =?utf-8?B?MFdZbDl1d25QU201UEMrUzIzOUtrY2g2RmY5TTM1Y0NkUVBQS2pBbjh2a2xx?=
 =?utf-8?B?Kzd5TllsSEhleVVoNm5NaXpTWFkyeStWZ0NYN0tNdWhyZWM1aG05SVdNVnBH?=
 =?utf-8?B?OHBFVkVNZTJjRzdtRXhVQnh2R3QxTjB2TzZKanBnSURpd3VvQmVDbG9LR2hL?=
 =?utf-8?B?K1luRmNCWEpVTXQ5T0wyUVByYU9XQVJZUytoL3c4bEUrOUFUaENLU2FXTUFy?=
 =?utf-8?B?aDBHa1lFWkw1MUgvNE5ra0MraFZVNlVsKzE5bFZJenBDSjN3ZUxjZnc5UUs2?=
 =?utf-8?B?Q3BXMzJhazFxLzNuY3pIT2trOVowdjdadDF2Vis5MWE4V2NHQzkyK1NrVm40?=
 =?utf-8?B?bitkMDNnQXZXUkp6WUluM0VuNEhMRld3TG9QazVnbHcxNzY0T2lkMWNYNzlo?=
 =?utf-8?B?S0loYkk2UFdXRHZCTFFRaGpFZFhkQjJTRkJHNWdWVytLM0R5TzlRMHdZeGJo?=
 =?utf-8?B?ZUhvM0FYWmtNYkxuRVpaWnhmd2JtVDVwNFNINlgvenhkbGZFK1h1dFVKa0xt?=
 =?utf-8?B?RUNKWFZBdGVRdi83S2dKRFZpR0ZPNU13WjM5L0RYUUlOaG5UVE1pbGRvS0pJ?=
 =?utf-8?B?R1V3cTRjanU3UnFjam1yZGhDQVlsUjRqMWdwVi9WbjZkMXNJTkwwZkNBWHJ6?=
 =?utf-8?B?QTAyQkNFRWtCelNFaWVEV0VmVlZyZzQzMXNyK3k4bE1TR2xlZ29ZSHM4WVRy?=
 =?utf-8?B?dXFHUGtQRm5PSTU5TWZDYjdLdTRXRkJaT09wbTE3WGFUc1RjZFJSeDdkdmtR?=
 =?utf-8?B?MWlSWFBHL1A3b1ZZTlpxeHI2cXBrTXlLOUxsUnltZ2ZPdUpFZHJUQXA2RHZn?=
 =?utf-8?B?a3pTOWx2bXFWWC9zSkZ4K3JtYnE4V3N2QjV5SlFpeUJ4UUhpYWVZbDlGSXU2?=
 =?utf-8?B?aWxtRmZlc2VYSS9JUVUzZG9VM1NTNXdBN0FSZnNTTDFoNjhkd01sdnZwemFk?=
 =?utf-8?B?NW9wazRrVG5MbTVZTEdLQThtVTZIYUJzaVlPYUkwb2xkMU5aSi9MUUVSYW05?=
 =?utf-8?B?Y0JXVTB4K0RISk9WTU5OczRIanZreUk2U1U4VzNoWDVXdy9tMENaK055UlpE?=
 =?utf-8?B?cFp2YS9vWGxqbldETUNScnJUWjRVOGI3dHRtV0VYa1d1Zm10Ukx2TCsrNDlj?=
 =?utf-8?B?bmNKOG1QTWJnajR6eUVNc1JrRVRIOGFJSDNvUW9ZTzZ1UTBMT2V5S2JMRk9T?=
 =?utf-8?B?RTdWZERxSDRFUm1BRHczR3JFdDVzNmJJeTVJLzBDR3d0d0ZSdDlYQ1AvTVRR?=
 =?utf-8?B?WmdSN242L0dhVFBNV0F4N3RFZnQzbUtXWlJPdXhKVk5XUlZIT2ZJQmw2a09S?=
 =?utf-8?B?b0lGWWJoNjM0azBDUXlSNGxBQXJtSXlTVFh1UlFzVHRyQVFWejcxWEJ2YkFN?=
 =?utf-8?B?WjUyMkdsUld1SHR1NHh1azVVVGVvdnN6N3g2SiswVzJZbWxZZ0pBL242dVZa?=
 =?utf-8?B?SmZWQURNSmxqUVl1RDUvQW56THdYemxPYWNNZTQyRTN6S2Fnc2NjMWcrYm9I?=
 =?utf-8?B?YlkzUG1CVVI4WVJlbTM2RWV5M2szN2l0ZkJEVmg2YXI1dDkxNDBTSVgwclBB?=
 =?utf-8?B?OHhiTGREVGprc2pzcW9RM1l3N1o1OVJVeHBKeWR5b2VMU0ZUZ1d4b0ZKeGhy?=
 =?utf-8?B?SWxmOG5Ud0pnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4747.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TE80STZYaU5aRnkxMnREREc1WTJUSVltbDNLMmNpYS9UUXYrQ1pzeXRIRlhN?=
 =?utf-8?B?YkJjVkFqTmwzTXVaVDNHbVJIWU9lMkZnM211M1NNV3pYM04zeC9zQkozOHdN?=
 =?utf-8?B?aVJHQWdTVWViNmNtNnZkTUNkdHVjU2ovSS9pVUpSUW1kR1Jndmd0dDB6V3Vp?=
 =?utf-8?B?dGVqVkFqeGlYTm9vczB6a0E4bnhpVnNzMkpHZ1JwUGRoYUhsM2ovNGdwazBm?=
 =?utf-8?B?TFd3anhKWURSTnp5ZHVkM0NiVzBaUksxdkhNSFRnTm9mZjZmNzlPbEZONVVq?=
 =?utf-8?B?cmNlbWVaeUVxak00WG9xekdHUU9JVnpiNDBiTFFIaE53aThRTENLd1RhZVFE?=
 =?utf-8?B?emNqdWhodG1HZExFaWloM0JUN0R6NXZCL3pHZ2JpanI1UkJtbmVrcURrRDhq?=
 =?utf-8?B?ZkNHWk8wYUxlQkpySGl2a2diNVppbWd6Y01zTExMUmtqU1VxaFBlU3VTOVZp?=
 =?utf-8?B?SHZXRWt1TWI4YS9ZTVQ2N3dkV2VVYkxFaTZabUpMT0N1K1dRQWMweGlpR3FE?=
 =?utf-8?B?YWhvSVBrZldmNTdkZVRCdENTbDVRWFVGQWg3ZGs3NjM0UTNtT283NHFUTFRi?=
 =?utf-8?B?M2FlRWkzb1F0T0hmZE0zUGlONGQ0WHVvcDlqc09aSTNSZzh3UGFmVkdvdnJR?=
 =?utf-8?B?dWtxcTlHSFR3RlYwRlFPN2duMVBrbE1GNEtCTE5JZEVJaDVlYWp0OVVaK0la?=
 =?utf-8?B?NmtpNzBJOFFqdEdWTWxmNHRhb3ZzYzZBYmY2dng4Rkc4eWdNZyt6Uks2OXdh?=
 =?utf-8?B?UW9rUmxDVTZ5dkt3UC9KbGVzc3VvVEc1QkFnY2I2b1N4S0dISEY1VzBJNkVJ?=
 =?utf-8?B?NHRzbmp6ZldtVDB2NU45cjBQOS9jT3A0dmlyM0pPUDlFTlI0RGVrM0RVNnBS?=
 =?utf-8?B?QkdxRzFEanlJOCt6TFNUdTExdzJrVkl6U3d6UVdhN0pHRWp4OFJsc2NEeU5p?=
 =?utf-8?B?bWVmR1BvSStWQVgyMjdaUkRxMGxBNytwQW9yank2aHpNN2RzS2ZoMlU0RitD?=
 =?utf-8?B?Mm9pWTFLTDIwYUUzUjUvc0JzMWMreDJFdGFQaHNjajdaOVJ5dE9nQ3JEbkov?=
 =?utf-8?B?b0lGQ0ZSci9SY1ltZ3M0RS9wd0xxQkkxd0h4SzRWV29UUUpnaUN0MEcyOTcv?=
 =?utf-8?B?VlUxTjZBTW5tc1QvZUg3anhLSHpQOTA4RW41ZXBoTGJmV3UzdU1rZWtORDkz?=
 =?utf-8?B?MWxvNERPc1JwdEFsRlllZWduRUtzYU9qbzVlYjNITTNBbnYwUzdTZmcyVDdo?=
 =?utf-8?B?SVdpckpqZVlKRS9YUk9hQkdva3JBMFVFTEU1d2c5WENNZ3FiRHRlOGpoLzVF?=
 =?utf-8?B?M2V3MWNXbytoSzZVNEdPL2VsYUs4L3ZidUpBOUJETndvK2JNc3RDOFFmOENN?=
 =?utf-8?B?Lys0OWJuNW1KZHZ3NnNPd0tJWmhGWmJJRVhxSTlYTGVLNG05UXl4TDVlcjBh?=
 =?utf-8?B?YlgwcjVidlFLTVpkeUtNbld4RE1RNjFsSGhXRDdqbGI5UXVmNHNYbm01dHA1?=
 =?utf-8?B?dnFsSVRtbVhiV2RTZEMrWk5OZjhIbkNjQzN3M3YzdjRacXdHMWw0bHpQYjVV?=
 =?utf-8?B?NVZ5ZFQ2SlAxbEdSK09QbUt0ZUJDV2U0Zjk3Y0F4OFdONEUwY1B0Mk9iSHdo?=
 =?utf-8?B?WVFjcFdWTFdXazZSRDZ5aG8wVVlML2FzYmVjYUhDQmc1WlNONG43UDFnYndi?=
 =?utf-8?B?VzFhMzZnUmdNNHBkNWNUeDdVSXBxVkFXSDd2djVwQ29CWFhyYllLamFONVJy?=
 =?utf-8?B?cXdFb3djTTU2NWtKM1UyR2F2R3ltTzJZMHNUOWlScUdvK1g0dFNQWGRvUUJs?=
 =?utf-8?B?UTlzL1Y4VHlZeWxRaVh0SE5GVDZtSWZUdEZPcnZRMVNuM0ZPRlBiZTFiK0tR?=
 =?utf-8?B?eW51VXFzQ25xL3drb0FZV1IxNitxZEhsNGFYbDZJRzlQK0dSL2FwaWRQSkdi?=
 =?utf-8?B?d1lkUFlyZm8rS1hjSXRSSE5nUllBSDA1U2xrem9tcWJIOUw0eXBJT0dBcThW?=
 =?utf-8?B?enE3UEJKZVVBU3k4WFNvblBLK0QyaTh1bGxTQkxMcE9kUVlXYXBqbUVvbG1I?=
 =?utf-8?B?SjJDVm0reGRwVlB5d0VnS0ZSdjBlZU81REkxSlpycU5BSDdwRjhJMHZUNUc0?=
 =?utf-8?Q?xHeA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4747.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0851a07-5f35-4cde-0c47-08ddf5e52206
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 12:24:22.3469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aVy75qeyxQIYfcqjtLxwp3tpSuwAVtWmmtdKXo6okUYMTwo3B1OfVQeqjSeVyA9xAQ0MI0Chhk4CGKQK2OjQlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4292
X-Authority-Analysis: v=2.4 cv=UY9RSLSN c=1 sm=1 tr=0 ts=68caa87b cx=c_pps a=lLx7hvauRx8h/FN40cw3Kw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=gGoeOEQUT3d02rphfykA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDExNyBTYWx0ZWRfX3vsKhsQWqSeT vc+IBwVghdWORABtCjISLhs0xn5SbaZRqpG44iWbn0wNitdvacghQiMSu18B+LIrWbK2aCTfarI YL9W3QMvW3wTGmekHWcirdEZNkRHKywGSwAMarsi+93DPCpTzCtlA7+AOq4kRuk8xITJikMcTMk
 EUZULc7+V6+7RRNk1m5TDwEvkLcOBVv0Gq/tWv1h35A/lW/pH4QWd/BtMqFjxAo5Dfmg/9BEX9c lryXQ88N/6vxEH5s08+bhrc+YPbmpL+k+qpUmogGj9LJ+HjE+mXJONhby3he/NIWRqKrOEqYWJd eblN62ZRuDJbWR2mu4G2BpBQbefA575RejN0W1Vi7hSnnmQv/gMI+Y6Nhkn1oVFammiguEUstiY MglLFQU0
X-Proofpoint-GUID: hwTwckCKEoBkmH_FbqBgccRpj8-fARD0
X-Proofpoint-ORIG-GUID: hwTwckCKEoBkmH_FbqBgccRpj8-fARD0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01

DQo+IE9uIFR1ZSwgU2VwIDE2LCAyMDI1IGF0IDA2OjEyOjI1QU0gLTA3MDAsIFNhdGhlc2ggQiBF
ZGFyYSB3cm90ZToNCj4gPiBXaGVuIGEgVkYgKFZpcnR1YWwgRnVuY3Rpb24pIGRyaXZlciBpcyBy
ZW1vdmVkLCB0aGUgUEYgKFBoeXNpY2FsDQo+ID4gRnVuY3Rpb24pIGRyaXZlciBjb250aW51ZXMg
dG8gcmV0YWluIHN0YWxlIFZGLXNwZWNpZmljIGluZm9ybWF0aW9uLg0KPiA+IFRoaXMgY2FuIGxl
YWQgdG8gaW5jb25zaXN0ZW5jaWVzIG9yIHVuZXhwZWN0ZWQgYmVoYXZpb3Igd2hlbiB0aGUgVkYg
aXMNCj4gPiByZS1pbml0aWFsaXplZCBvciByZWFzc2lnbmVkLg0KPiA+DQo+ID4gVGhpcyBwYXRj
aCBlbnN1cmVzIHRoYXQgdGhlIFBGIGRyaXZlciBjbGVhcnMgdGhlIGNvcnJlc3BvbmRpbmcgVkYg
aW5mbw0KPiA+IHdoZW4gdGhlIFZGIGRyaXZlciBpcyByZW1vdmVkLCBtYWludGFpbmluZyBhIGNs
ZWFuIHN0YXRlIGFuZA0KPiA+IHByZXZlbnRpbmcgcG90ZW50aWFsIGlzc3Vlcy4NCj4gPg0KPiA+
IEZpeGVzOiBjZGUyOWFmOWU2OGUgKCJvY3Rlb25fZXA6IGFkZCBQRi1WRiBtYWlsYm94IGNvbW11
bmljYXRpb24iKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFNhdGhlc2ggQiBFZGFyYSA8c2VkYXJhQG1h
cnZlbGwuY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXM6DQo+ID4gVjI6DQo+ID4gICAtIENvbW1p
dCBoZWFkZXIgZm9ybWF0IGNvcnJlY3RlZC4NCj4gDQo+IEhpLA0KPiANCj4gSSBmZWVsIHRoYXQg
SSBtdXN0IGJlIG1pc3Npbmcgc29tZXRoaW5nIHRlcnJpYmx5IG9idmlvdXMuDQo+IEJ1dCB0aGlz
IHBhdGNoIHNlZW1zIHRvIGJlIGEgc3Vic2V0IG9mIHRoZSBvbmUgYXQgdGhlIGxpbmsgYmVsb3cu
DQo+IA0KWW91J3JlIGFic29sdXRlbHkgcmlnaHQg4oCUIGFwb2xvZ2llcyBmb3IgdGhlIGNvbmZ1
c2lvbi4gSSBtaXN0YWtlbmx5IHNlbnQgdGhlIHdyb25nIHBhdGNoIGFuZCBzbyBtYXJrZWQgaXRz
IHN0YXRlIGFzICdOb3QgQXBwbGljYWJsZScuDQogUGxlYXNlIGRpc3JlZ2FyZCB0aGlzIHBhdGNo
Lg0K

