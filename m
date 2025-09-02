Return-Path: <netdev+bounces-219338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65900B4105B
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 00:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25117545127
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 22:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420C4277CB4;
	Tue,  2 Sep 2025 22:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BM9e/NKq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YwvPF4Rg"
X-Original-To: netdev@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329D02777EA;
	Tue,  2 Sep 2025 22:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756853459; cv=fail; b=UfTaxuEM4qZAgufGJm7hnrYxSgNvbDpIVaUjKlfaR+3AV177b4mEYonqQFa16Ud8IrEGIybm7+OPRblHTFTgWyze8vRNf1F1UV4PyEUn4i/h5T8cbp12hpVNi07beNamPcVwZ1sh2j7g5/885Sh1RIM3LoudP0Ol18MkvVykMOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756853459; c=relaxed/simple;
	bh=3Vg4Ll1wYsv6knRHzeDIQA6+s1zsebuF8N1Xuwmtfdk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZY4k0w61CTrF3j4BKoyvw6lb8e3hb1KLGyp2FTRe5i2iQ4fL+oEcHrfWyXEuPMfO49K9ZMWprGh1Rkoa3nFgn3CVIThm0mTShqVDxmZKxcUL5QvBuUGN41A8o20Yk0nwJpUXdlcoA0CGVY2MTgnEz2Kzcj4frU6SIm2dS62ZZ4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BM9e/NKq; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=YwvPF4Rg; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756853457; x=1788389457;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3Vg4Ll1wYsv6knRHzeDIQA6+s1zsebuF8N1Xuwmtfdk=;
  b=BM9e/NKqWUWCHHTE+35fhtIIgRsGTK/j1UHxlBYxs/udpT9QEJL8GOWB
   nmhgf6tFqgaPp6Mut7B8E1C1i717ybfBl4Cpb/MDDRRwqoGLgBpBxXB88
   rlmAjLN14n4q1awQ3qM6aa0xWK9FU2Cnpwg/96h6KZTffSFwQhPKWtMle
   QyLMbbpphne8EtjhylNwNfKZHIJHTY2+cqGc9qmUFOymoZk8Q/ys+41Zy
   N0jgZvldYklVFi9By+lFkonwZ8jDwE7nNUGXXbO6hMiRFk7nqFcAdMOne
   aXa6w3Px+yEBcVhlb2QObMwrwTPWRa2QEKdMrppWCCovIK7yRAXnOi/Rh
   g==;
X-CSE-ConnectionGUID: 1A16GPPPQESYf09B47w27w==
X-CSE-MsgGUID: lFG47sM+TimDZLig6tOq/Q==
X-IronPort-AV: E=Sophos;i="6.18,233,1751212800"; 
   d="scan'208";a="106515216"
Received: from mail-dm6nam12on2056.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([40.107.243.56])
  by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2025 06:50:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRSahWrdV54Yr4mBap/hafRN+pjmMAHlCsBeuA66hUBToq1eV+iSV42jToN81yzhVqfhotP7mCjaUO7lS/ywucrqQRL9C8pKranLVRVT1h613ey/toE5sd6fdmxIx2kOFc1YGpoOugDM9kGVEB7Epu6y5er5iUdQPC8PvygqTWTPow2sY05TwM5+VOzxMtW96fxTcONNtCyqwX0LjQd40PUIlGSSj3MtQICgwQ5yuXmlBmiRD+fGluu4bmMZuCT0sAfJYkybBHNwVbygSsSN+/vEqQff3Eq+Nfx8hZxZ1fQ23TUvau7U/AnyRdTzqpVGxBIOSqUBJ7gJUU5VwdI60w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Vg4Ll1wYsv6knRHzeDIQA6+s1zsebuF8N1Xuwmtfdk=;
 b=aUra54vYXwUbsPALjIf6T8ccYhMFvTQunk84dXg26OdNFhz2uO6L4iOyR/dHz1MpeWBnmiG9RSEaBFXN8rzcpNr1X+F1VSWL1C89zIgnqZGkTqxObd3hOqgvq5nOJuv7QkxLPp7cp5WocYgIJoaOyj1AtVDZkyjXO1SwrAvW/VFsTBeWr9mgU9QtWw3Txo7mH5XxKVsRAUBkIYBT4T+94xAifvfDIOix2y9X+QpBRabLuuFdqp1gRlYAWwd+6rPgdxBd46DErFVPUMDdeMnv5DS9nzUOKr3lJsn/tcNkz1/x+j9OD3ZAqc3wt9/Q/EUKzCl9CeePDhz2ziP8sGGMew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Vg4Ll1wYsv6knRHzeDIQA6+s1zsebuF8N1Xuwmtfdk=;
 b=YwvPF4Rgv9BldK2LtnAN6yg3lW7uQPfOpQ0uNzm+7gQVGqwGBIUKg5sPwlBwGaOKc0KXlA5uk1WpjQiuxFkliGeSM95nudsszx1gMsOt7UlIwy0BkLzGcJD7SprnA+QvkIBKWmY8DoGMrxHDCB1i4JGmMppTu6Ug1WLKWDC5sDw=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by CO6PR04MB7572.namprd04.prod.outlook.com (2603:10b6:303:b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 22:50:53 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.9031.014; Tue, 2 Sep 2025
 22:50:53 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "sd@queasysnail.net" <sd@queasysnail.net>
CC: "corbet@lwn.net" <corbet@lwn.net>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alistair
 Francis <Alistair.Francis@wdc.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2] net/tls: support maximum record size limit
Thread-Topic: [PATCH v2] net/tls: support maximum record size limit
Thread-Index: AQHcG7sim/DTbd3pdkmC4DloIxkjarSAD9sAgABwvoA=
Date: Tue, 2 Sep 2025 22:50:53 +0000
Message-ID: <0ba1e9814048e52b1b7cb4f772ad30bdd3a0cbbd.camel@wdc.com>
References: <20250902033809.177182-2-wilfred.opensource@gmail.com>
	 <aLcWOJeAFeM6_U6w@krikkit>
In-Reply-To: <aLcWOJeAFeM6_U6w@krikkit>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|CO6PR04MB7572:EE_
x-ms-office365-filtering-correlation-id: 1016a229-6edb-4391-ae8a-08ddea732bc3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dGFZZFdOVjg2TGdFL2VTTWVabUpsWEVFc0MzUkNaUGVDckYxemtEVzFBSmpV?=
 =?utf-8?B?Q2tsRGwyRVN0MjFnNFdmbWFCeHN3RVYyd2FxV2RVdVBIZlpFZGQ1VTUrQWVQ?=
 =?utf-8?B?SmdCV250TDNRNENOcko2UXJXVGEyQ1pPWFRTSnFsVEx4NGRjZmZJd2ROeFFm?=
 =?utf-8?B?TnZ6WFJSaW02dDZxdGZMNlRGSGpDRlRZa2VrRFkzUVRNdW9PQUZWK0hqT3Ji?=
 =?utf-8?B?UUxUYzM1Z3NLdkhYbkY2NUd2em5QWk5FK0pqZU1CenQ2MnkxL1MwOFJUZWFw?=
 =?utf-8?B?d05KdkJyNXNnUStWa3NOK2VnUElpemhOa0lvV2laUCtGVTJrVGJLTmNZNS9t?=
 =?utf-8?B?QU1DRE80UXhtOTlTakZzRlNxWXBOMFVXTWVXSnkweVZoZ2hVVFVuTU1vYkl3?=
 =?utf-8?B?WGpiTXJFclBnZThwSmNHck5nK0JweG5hd3dDdGVEWEp1czJnTkQvRnM3ZXBm?=
 =?utf-8?B?a0pFUjJycDlEcUFYMmVHNTJQY1JVdmtHSVJhZXFraEQvUHBIYWZGdUFjOTFH?=
 =?utf-8?B?YkY3VExIWkR1c3c3TG5LcnI5RnhYR2xMSXREaFBLUEhqMkZyL1RlWUFFcGZL?=
 =?utf-8?B?S0hlSDNDbHhJSWpGZGh6YytqQ3B3aUNUR0JkRkRpUGFNUDloNmp4aXRxWjBP?=
 =?utf-8?B?R29wbXZhNFBHL0VYWlZHbmd0UUdOR2Q0WFRjaXM1bUFEb0Z2N1ZJVTdxTlM1?=
 =?utf-8?B?M0FpY3ZvdHovUmRNZUUwa3BmaSsvbmE2REI4cDBraEFpS0N4Smp5cXQrU1dL?=
 =?utf-8?B?bVk4cTFMQlFvb1BOMUZTRVdJaDJ1SGNDRCtZK3BhZVM0NUYxcDYwSnlZN3B1?=
 =?utf-8?B?VjlYR2dWQ2RLZHN1b09vN1FReG9LZ1NpSkhvTjZQVXpZTDkwUDBXR05ESnlj?=
 =?utf-8?B?c1NlUTJuenlqSmNQay9HaStpQ05QYzBuWUZWUFJ6NUN2azkwM2NTMDFiQlg0?=
 =?utf-8?B?bXYwOXF1RUhKbGFOV3M3WUk5SThXVDdjM2o1K1NYU255T2dtVXE0bmdDSU01?=
 =?utf-8?B?TFVTR1hJZTVkUVowaWFQWlI2SndCWVFTZGlMejVyNzB5bXlndmt0WE8vaFVh?=
 =?utf-8?B?bEwyTExDMXYwRXNuRFQrclhPbTBqNG51S0pUNktNeUhVeFViM04rU2x4ZmZO?=
 =?utf-8?B?RnB5N3VwVzRjYVBlTEphNmNGcStMYW4zZk4wcmxvbXlhd3k2YmZSZjlaR21X?=
 =?utf-8?B?NXhJMitaSHF0Szk5elRuK3RrUDk3ZjRicXZySEUwNy9QWVo4R1FlODBNSEJw?=
 =?utf-8?B?ekFBSktaMUNaamNZRnljUi9wcmFEVDVNelVsMzh5N3NBMDJ0Nk44TEdDU1Qy?=
 =?utf-8?B?aVdGeXF0Y2d3NzkxcHY4SDBZeTRoZSswMHliOWl4aXNLaUdrb0lCd0xKbklT?=
 =?utf-8?B?eW10azlYMUVVT1V4OWUrR3JPK25OL2JlQ1ZkR1V3MDZuak5xeWpVSDNLbnpQ?=
 =?utf-8?B?cXpuVW5wZ3hSb0hWU3hPbnVYSk5nOUFaekxkU05rS00vdWkzVHdsTWxmTXNM?=
 =?utf-8?B?bUdjeUNmeThBYmFOcHJpVmNyMDIxZ21OdEp0K0xOdUdVUlNTUmdHY1dMZnlD?=
 =?utf-8?B?WnZPMkZoMGxVbG93d3pvNkRlSEFic3YrdklDbmU1UGtDRmJqZDFZeFVtYVI1?=
 =?utf-8?B?Wk1TWENZSlFPaERscWF5NnZPLzNFMXBCbjR0bU9jaE1wK0grc2xhQzJya2Zh?=
 =?utf-8?B?UFRqOElhUmhOYjBGYkEvSVh0TDJxWlpxQm0vWVBGeTI4RlJmbEU3TjZxT2JB?=
 =?utf-8?B?QzZ4VXltaWJvTVFUNWRiTklCQjltVkVGWUhKUDIxVkVtOFZZYlZYcFU1MFdp?=
 =?utf-8?B?TXdEdjBucW56amcrcWhLZ3RIcWNzQnJOK3p0VGF1cnpOay9yZnN6b1lSZ0ZI?=
 =?utf-8?B?dHdoU0dESm45MExCMS9HU1N5d1ZIRlVjalVaSzRFT2MvVFdPcVU5Z2xvWFd4?=
 =?utf-8?Q?OAFXfBsj3Eg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWhJck5jOFdSUzAzUmxNUmZZcW1EL3NPTitaYkZaVjBLQkFvNEJuNUNTa2Nr?=
 =?utf-8?B?a01TVTFSaFFuNDE0U2RkWjVMTlRTVTc2YStpNUFiWmF1L3I4a3luSEIrQVZo?=
 =?utf-8?B?Wk5nUXZNWk5HSDllMi9jTGJKL2RhQ0ZYMjVtNWRNWGdXVGxTY05hTjdGOGNV?=
 =?utf-8?B?eDBBQW5tRDNQVnE4WThyalhGeW5iaC9UL0lLbW04a3hNWkloeGRTMCtuYytv?=
 =?utf-8?B?UExsbFNtQ21iM2RmSXVobVpsRWVuclpRcjBIdDFmVzFtR0ErNGFxSFdQWklr?=
 =?utf-8?B?MnFBdWR2R1JKVUFkQ0p4UTY4N0g4eWFRRW5oTkVmNmdPUEwvY0cvb0c1Vm9H?=
 =?utf-8?B?RjBGakFrTEZTazlTZ2QrRW9CSEZTb1p0WW9jbmphOFpQeDhzZ20xc3lVSmIv?=
 =?utf-8?B?SkY1QXhEWUxqaW12d1UyS3Yxd2hWOWhvMEpWamFPa21wc3Vva2FnS1hobHQw?=
 =?utf-8?B?YmVhc283dEhVTGRIS3kra3lEUDJ2VmpZK0g3MXRkRmlwMy9FM3hUTnVuSW5s?=
 =?utf-8?B?MUlUWjRSZXZTTi9Yb1N3QmxmVGphT1FZRytYVStqaGFvamlVOW45L0hON3kv?=
 =?utf-8?B?SWt0cHdha3FYaSs5bmFSUlBmVHRRTG5GR0t0Q0FLR2VXUnM2bUJLTjlONk90?=
 =?utf-8?B?UStqbGt3Mk52T1B4elJ1cEd4cTVkSTlqZjZ5c0NCaFFsWmN1ZGQ4NHgrTWNr?=
 =?utf-8?B?Sm1zN3EvTE1zanh5dlpqT1RpanBpZTU3Tm56VHZqTlRiL0haMmdKQ2QxWlYw?=
 =?utf-8?B?SzNiYXc0MkNyRUlFWStONmpxaWNsSUQ3VEZXdURBMlhwMWNpK0lHSldzZ2RX?=
 =?utf-8?B?TTc3L1ArY2QrKzA2M0tHNGJqelMzbEYyNGc5d1BremhidXFmT3BJeUlYd2hV?=
 =?utf-8?B?cGxLRTMyTGo5UXg3dGJaajRYMWZQYlFaY1ZlakZKOVZHRi9rbzVFZFZqdmVM?=
 =?utf-8?B?OXM0K2w5ZFhoM21IOFpvdjVuMFp1YjdqZ29xTHY3Q0k4a2lIajViUUtGdXBE?=
 =?utf-8?B?NGFueXdvQlg0VFhxeUhTbndDVlY4N3ZDUHpVajhncVpZVTB3c3E0eUJNd2pj?=
 =?utf-8?B?c1Z4TVl4c3h5VW1QZy9vblVmNTZxWmF4eGFCbCsvZ0hYbnpxUG9taTlwb041?=
 =?utf-8?B?QUJ6VWFZK3YxTW8yR3pSVHBBd1ZQUDBtTWIxeGhFaGZmQlpRc0V5d2NWbkp0?=
 =?utf-8?B?Tm1ZSlJSVk90cU5EZVc5bUkrU0hVa3hhMHZuR2Q3S2xGbGZoeExocy9jTDJV?=
 =?utf-8?B?b2JpQVA5czM3cHRYSVQ5dytTSHhJT1ltUXNIYXZVVUNtdnJ0N2g4NlJiRTdk?=
 =?utf-8?B?RTB1SGJETG5VaUErTm9HNGgyTzlIZmtUSkRlakV1NGQyVFB2NTNaZWtUc0tZ?=
 =?utf-8?B?ZHUya3BZTHFQODNWZVczdjV5MHc0alI5V1FKVTB0V0s5NHBlbDlBanVWK2hk?=
 =?utf-8?B?c1NUUU1QN0luUVFHbTBLMGJhN2N3d0sycUQrSEpjeGxHanVwQzZOVks2TEZi?=
 =?utf-8?B?U2VHbm01c3E0eHVpbzRzRGhILzFnb1pYOUFCaFhaZ3dXSndMV1JRTjVWbE13?=
 =?utf-8?B?SHdscDBBbk9nWmtneGphU1hNcjVWaEt6dWZqVFZNY1FOSXJxQ0JSRkdNa1h4?=
 =?utf-8?B?VzR6T3BNaWtnKzFVWGdDdUxndldEQkhhNTBjYXU4dFRmcnMxcnBhNXFOeW5F?=
 =?utf-8?B?OGpuaXg3bkhOMGtCNXNPbGdwa1BFYkRFRzFodHhETFlnVk9rdS9aNWJpZUVz?=
 =?utf-8?B?c3JVQUdhRjZPWDlBMG5Wc2M2VEcrcWVVVVo2b3RVcStrMC9EbU5STlVUSmxP?=
 =?utf-8?B?M1dvM1RwYmNjSW80UTNiVDVjZmY5N1pvNkp6R1FLWitxMjhxV1ZZdkFiWWU3?=
 =?utf-8?B?ZktwdWg0YkhEczhIUDlWT2xERklKZnJ5ajJQeGlkc2IrU01XZHhWMUZaSWtO?=
 =?utf-8?B?VHRBdWdOVXkwWFZFWm9yN1FBOWFNbEU2Q1UvY251WmMzRVhVLzlyL0E1b2ND?=
 =?utf-8?B?c1IvSGdYTjlqam5mTEtqZERtUGpUb212TmVGQTdzWWYwMHBCKzZ6WERNeURu?=
 =?utf-8?B?RHFmMDArZmtRa1BoSVVaNDBVY3hKcWZUbmxGU3JMK0pZeFhIbThWOFI3VFZO?=
 =?utf-8?B?bDdRRk5oNjlEZ2YxazBMS0pDa054V0JyNUprRFdMbGxaVWRCZG1RWDcyMmV2?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8D2E66CE3A6B8429B4A71057367E5CA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vlpJSt3ClSsaqnXceHfm08axs6as4sDQP31RVSLVLsugiERefTZM9fm4CFTG9DVPNCSmkbxjJNI8kmrDCUsw7/Mk6mX2fvQrxkEH3fnZi3FAqL4uur7vrBeOUv437gwnLZjWX8kJriO3pP5un+y2eaupMY4MNV1/ROuJF4g0zNYVqK+1KfQRUaYxxgTH0liKdHZrmKyznXDjKVQ4WDUj7Du4/BW19xHI6UzfY6ekzdfXTB1R5FGspHgbWeGtHGqwkbtJdazhD6Lgy2YgsvKamyky7/nnY3F9OxjJO3ZrDCW7ObZGbxe9J0mRcP32s6u27Hd2GiCP/fAk3+ghDt3jjzPDtJ/G0/fgJ8uJ9ZleGUDZAla3OeadTaMldeCPmQUw2woPRVrYaU4A/RostoZx2L+6iwjO94YAXyZPXOMZP97jSEDBA3QAO+wO4ptUqQXO0pgYHuthfIMMyw4TwT3uFODnGI68WJXBDz1xtpOOBglZsXZrWN9Azi8kNZ8tYt8ExOpQCPI009XzSh5UoI47W40Lff7IwWBqMNha7XaUYH/yUWsYgW59yHPYDjKUqyzLBMXVv27gx/8tu+dIQWw7oYBTP3yl/Ibbg5WPjVB3WJrJIAiCcguTpL+KHM/0+pYJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1016a229-6edb-4391-ae8a-08ddea732bc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 22:50:53.2802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JdJMCdG1Pwmc6YycPs0Mp5/uqKw3rmmuz6D+IrhIBzWplpPNZw5XPQx00fj6QMcs0WA8CBNVbgKsQYhf4mLBhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7572

T24gVHVlLCAyMDI1LTA5LTAyIGF0IDE4OjA3ICswMjAwLCBTYWJyaW5hIER1YnJvY2Egd3JvdGU6
DQo+IDIwMjUtMDktMDIsIDEzOjM4OjEwICsxMDAwLCBXaWxmcmVkIE1hbGxhd2Egd3JvdGU6DQo+
ID4gRnJvbTogV2lsZnJlZCBNYWxsYXdhIDx3aWxmcmVkLm1hbGxhd2FAd2RjLmNvbT4NCj4gPiAN
Cj4gPiBEdXJpbmcgYSBoYW5kc2hha2UsIGFuIGVuZHBvaW50IG1heSBzcGVjaWZ5IGEgbWF4aW11
bSByZWNvcmQgc2l6ZQ0KPiA+IGxpbWl0Lg0KPiA+IEN1cnJlbnRseSwgdGhlIGtlcm5lbCBkZWZh
dWx0cyB0byBUTFNfTUFYX1BBWUxPQURfU0laRSAoMTZLQikgZm9yDQo+ID4gdGhlDQo+ID4gbWF4
aW11bSByZWNvcmQgc2l6ZS4gTWVhbmluZyB0aGF0LCB0aGUgb3V0Z29pbmcgcmVjb3JkcyBmcm9t
IHRoZQ0KPiA+IGtlcm5lbA0KPiA+IGNhbiBleGNlZWQgYSBsb3dlciBzaXplIG5lZ290aWF0ZWQg
ZHVyaW5nIHRoZSBoYW5kc2hha2UuIEluIHN1Y2ggYQ0KPiA+IGNhc2UsDQo+ID4gdGhlIFRMUyBl
bmRwb2ludCBtdXN0IHNlbmQgYSBmYXRhbCAicmVjb3JkX292ZXJmbG93IiBhbGVydCBbMV0sIGFu
ZA0KPiA+IHRodXMgdGhlIHJlY29yZCBpcyBkaXNjYXJkZWQuDQo+ID4gDQo+ID4gVXBjb21pbmcg
V2VzdGVybiBEaWdpdGFsIE5WTWUtVENQIGhhcmR3YXJlIGNvbnRyb2xsZXJzIGltcGxlbWVudA0K
PiA+IFRMUw0KPiA+IHN1cHBvcnQuIEZvciB0aGVzZSBkZXZpY2VzLCBzdXBwb3J0aW5nIFRMUyBy
ZWNvcmQgc2l6ZSBuZWdvdGlhdGlvbg0KPiA+IGlzDQo+ID4gbmVjZXNzYXJ5IGJlY2F1c2UgdGhl
IG1heGltdW0gVExTIHJlY29yZCBzaXplIHN1cHBvcnRlZCBieSB0aGUNCj4gPiBjb250cm9sbGVy
DQo+ID4gaXMgbGVzcyB0aGFuIHRoZSBkZWZhdWx0IDE2S0IgY3VycmVudGx5IHVzZWQgYnkgdGhl
IGtlcm5lbC4NCj4gPiANCj4gPiBUaGlzIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgcmV0cmlldmlu
ZyB0aGUgbmVnb3RpYXRlZCByZWNvcmQgc2l6ZQ0KPiA+IGxpbWl0DQo+ID4gZHVyaW5nIGEgaGFu
ZHNoYWtlLCBhbmQgZW5mb3JjaW5nIGl0IGF0IHRoZSBUTFMgbGF5ZXIgc3VjaCB0aGF0DQo+ID4g
b3V0Z29pbmcNCj4gPiByZWNvcmRzIGFyZSBubyBsYXJnZXIgdGhhbiB0aGUgc2l6ZSBuZWdvdGlh
dGVkLiBUaGlzIHBhdGNoIGRlcGVuZHMNCj4gPiBvbg0KPiA+IHRoZSByZXNwZWN0aXZlIHVzZXJz
cGFjZSBzdXBwb3J0IGluIHRsc2hkIGFuZCBHbnVUTFMgWzJdLg0KPiA+IA0KPiA+IFsxXSBodHRw
czovL3d3dy5yZmMtZWRpdG9yLm9yZy9yZmMvcmZjODQ0OQ0KPiA+IFsyXSBodHRwczovL2dpdGxh
Yi5jb20vZ251dGxzL2dudXRscy8tL21lcmdlX3JlcXVlc3RzLzIwMDUNCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBXaWxmcmVkIE1hbGxhd2EgPHdpbGZyZWQubWFsbGF3YUB3ZGMuY29tPg0KPiA+
IC0tLQ0KPiA+IMKgRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL3Rscy5yc3QgfMKgIDcgKysrKysr
DQo+ID4gwqBpbmNsdWRlL25ldC90bHMuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqAgMSArDQo+ID4gwqBpbmNsdWRlL3VhcGkvbGludXgvdGxzLmjCoMKgwqDCoMKgwqDCoMKgIHzC
oCAyICsrDQo+ID4gwqBuZXQvdGxzL3Rsc19tYWluLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgMzkNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiA+IMKgbmV0
L3Rscy90bHNfc3cuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA0ICsrKysN
Cj4gPiDCoDUgZmlsZXMgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gDQpIZXkgU2FicmluYSwNCj4gQSBzZWxmdGVzdCB3b3VsZCBiZSBuaWNlICh0b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9uZXQvdGxzLmMpLCBidXQgSSdtDQo+IG5vdCBzdXJlIHdoYXQgd2UgY291
bGQgZG8gb24gdGhlICJSWCIgc2lkZSB0byBjaGVjayB0aGF0IHdlIGFyZQ0KPiByZXNwZWN0aW5n
IHRoZSBzaXplIHJlc3RyaWN0aW9uLiBVc2UgYSBiYXNpYyBUQ1Agc29ja2V0IGFuZCB0cnkgdG8N
Cj4gcGFyc2UgKGFuZCB0aGVuIGRpc2NhcmQgd2l0aG91dCBkZWNyeXB0aW5nKSByZWNvcmRzIG1h
bnVhbGx5IG91dCBvZg0KPiB0aGUgc3RyZWFtIGFuZCBzZWUgaWYgd2UgZ290IHRoZSBsZW5ndGgg
d2Ugd2FudGVkPw0KPiANClNvIGZhciBJIGhhdmUganVzdCBiZWVuIHVzaW5nIGFuIE5WTWUgVENQ
IFRhcmdldCB3aXRoIFRMUyBlbmFibGVkIGFuZA0KY2hlY2tpbmcgdGhhdCB0aGUgdGFyZ2V0cyBS
WCByZWNvcmQgc2l6ZXMgYXJlIDw9IG5lZ290aWF0ZWQgc2l6ZSBpbg0KdGxzX3J4X29uZV9yZWNv
cmQoKS4gSSBkaWRuJ3QgY2hlY2sgZm9yIHRoaXMgcGF0Y2ggYW5kIHRoZSBidWcgYmVsb3cNCmdv
dCB0aHJvdWdoLi4ubXkgYmFkIQ0KDQpJcyBpdCBwb3NzaWJsZSB0byBnZXQgdGhlIGV4YWN0IHJl
Y29yZCBsZW5ndGggaW50byB0aGUgdGVzdGluZyBsYXllcj8NCldvdWxkbid0IHRoZSBzb2NrZXQg
anVzdCByZXR1cm4gTiBieXRlcyByZWNlaXZlZCB3aGljaCBkb2Vzbid0DQpuZWNlc3NhcmlseSBj
b3JyZWxhdGUgdG8gYSByZWNvcmQgc2l6ZT8NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bmV0L3Rscy5oIGIvaW5jbHVkZS9uZXQvdGxzLmgNCj4gPiBpbmRleCA4NTczNDAzMzhiNjkuLmM5
YTM3NTlmMjdjYSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL25ldC90bHMuaA0KPiA+ICsrKyBi
L2luY2x1ZGUvbmV0L3Rscy5oDQo+ID4gQEAgLTIyNiw2ICsyMjYsNyBAQCBzdHJ1Y3QgdGxzX2Nv
bnRleHQgew0KPiA+IMKgCXU4IHJ4X2NvbmY6MzsNCj4gPiDCoAl1OCB6ZXJvY29weV9zZW5kZmls
ZToxOw0KPiA+IMKgCXU4IHJ4X25vX3BhZDoxOw0KPiA+ICsJdTE2IHJlY29yZF9zaXplX2xpbWl0
Ow0KPiANCj4gTWF5YmUgInR4X3JlY29yZF9zaXplX2xpbWl0Iiwgc2luY2UgaXQncyBub3QgaW50
ZW5kZWQgZm9yIFJYPw0KPiANCj4gSSBkb24ndCBrbm93IGlmIHRoZSBrZXJuZWwgd2lsbCBldmVy
IGhhdmUgYSBuZWVkIHRvIGVuZm9yY2UgdGhlIFJYDQo+IHJlY29yZCBzaXplLCBidXQgaXQgd291
bGQgbWF5YmUgYXZvaWQgZnV0dXJlIGhlYWQtc2NyYXRjaGluZyAid2h5IGlzDQo+IHRoaXMgbm90
IHVzZWQgb24gdGhlIFJYIHBhdGg/Ig0KQWggZ29vZCBwb2ludCwgSSB0aGluayB0aGlzIG1ha2Vz
IHNlbnNlLg0KPiANCj4gDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9uZXQvdGxzL3Rsc19tYWluLmMg
Yi9uZXQvdGxzL3Rsc19tYWluLmMNCj4gPiBpbmRleCBhM2NjYjMxMzVlNTEuLjEwOThjMDFmMjc0
OSAxMDA2NDQNCj4gPiAtLS0gYS9uZXQvdGxzL3Rsc19tYWluLmMNCj4gPiArKysgYi9uZXQvdGxz
L3Rsc19tYWluLmMNCj4gPiBAQCAtODEyLDYgKzgxMiwzMSBAQCBzdGF0aWMgaW50IGRvX3Rsc19z
ZXRzb2Nrb3B0X25vX3BhZChzdHJ1Y3QNCj4gPiBzb2NrICpzaywgc29ja3B0cl90IG9wdHZhbCwN
Cj4gPiDCoAlyZXR1cm4gcmM7DQo+ID4gwqB9DQo+ID4gwqANCj4gPiArc3RhdGljIGludCBkb190
bHNfc2V0c29ja29wdF9yZWNvcmRfc2l6ZShzdHJ1Y3Qgc29jayAqc2ssDQo+ID4gc29ja3B0cl90
IG9wdHZhbCwNCj4gPiArCQkJCQkgdW5zaWduZWQgaW50IG9wdGxlbikNCj4gPiArew0KPiA+ICsJ
c3RydWN0IHRsc19jb250ZXh0ICpjdHggPSB0bHNfZ2V0X2N0eChzayk7DQo+ID4gKwl1MTYgdmFs
dWU7DQo+ID4gKw0KPiA+ICsJaWYgKHNvY2twdHJfaXNfbnVsbChvcHR2YWwpIHx8IG9wdGxlbiAh
PSBzaXplb2YodmFsdWUpKQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiArCWlm
IChjb3B5X2Zyb21fc29ja3B0cigmdmFsdWUsIG9wdHZhbCwgc2l6ZW9mKHZhbHVlKSkpDQo+ID4g
KwkJcmV0dXJuIC1FRkFVTFQ7DQo+ID4gKw0KPiA+ICsJaWYgKGN0eC0+cHJvdF9pbmZvLnZlcnNp
b24gPT0gVExTXzFfMl9WRVJTSU9OICYmDQo+ID4gKwnCoMKgwqAgdmFsdWUgPiBUTFNfTUFYX1BB
WUxPQURfU0laRSkNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKwlpZiAoY3R4
LT5wcm90X2luZm8udmVyc2lvbiA9PSBUTFNfMV8zX1ZFUlNJT04gJiYNCj4gPiArCcKgwqDCoCB2
YWx1ZSA+IFRMU19NQVhfUEFZTE9BRF9TSVpFICsgMSkNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsN
Cj4gPiArDQo+ID4gKwljdHgtPnJlY29yZF9zaXplX2xpbWl0ID0gdmFsdWU7DQo+ID4gKw0KPiA+
ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gwqBzdGF0aWMgaW50IGRvX3Rsc19zZXRz
b2Nrb3B0KHN0cnVjdCBzb2NrICpzaywgaW50IG9wdG5hbWUsDQo+ID4gc29ja3B0cl90IG9wdHZh
bCwNCj4gPiDCoAkJCcKgwqDCoMKgIHVuc2lnbmVkIGludCBvcHRsZW4pDQo+ID4gwqB7DQo+ID4g
QEAgLTgzMyw2ICs4NTgsOSBAQCBzdGF0aWMgaW50IGRvX3Rsc19zZXRzb2Nrb3B0KHN0cnVjdCBz
b2NrICpzaywNCj4gPiBpbnQgb3B0bmFtZSwgc29ja3B0cl90IG9wdHZhbCwNCj4gPiDCoAljYXNl
IFRMU19SWF9FWFBFQ1RfTk9fUEFEOg0KPiA+IMKgCQlyYyA9IGRvX3Rsc19zZXRzb2Nrb3B0X25v
X3BhZChzaywgb3B0dmFsLCBvcHRsZW4pOw0KPiA+IMKgCQlicmVhazsNCj4gPiArCWNhc2UgVExT
X1RYX1JFQ09SRF9TSVpFX0xJTToNCj4gPiArCQlyYyA9IGRvX3Rsc19zZXRzb2Nrb3B0X3JlY29y
ZF9zaXplKHNrLCBvcHR2YWwsDQo+ID4gb3B0bGVuKTsNCj4gPiArCQlicmVhazsNCj4gDQo+IEFk
ZGluZyB0aGUgY29ycmVzcG9uZGluZyBjaGFuZ2VzIHRvIGRvX3Rsc19nZXRzb2Nrb3B0IHdvdWxk
IGFsc28gYmUNCj4gZ29vZC4NCj4gDQpva2F5LCBJIHdpbGwgYWRkIHRoYXQuDQo+IA0KPiA+IGRp
ZmYgLS1naXQgYS9uZXQvdGxzL3Rsc19zdy5jIGIvbmV0L3Rscy90bHNfc3cuYw0KPiA+IGluZGV4
IGJhYzY1ZDBkNGUzZS4uOWY5MzU5ZjU5MWQzIDEwMDY0NA0KPiA+IC0tLSBhL25ldC90bHMvdGxz
X3N3LmMNCj4gPiArKysgYi9uZXQvdGxzL3Rsc19zdy5jDQo+ID4gQEAgLTEwMzMsNiArMTAzMyw3
IEBAIHN0YXRpYyBpbnQgdGxzX3N3X3NlbmRtc2dfbG9ja2VkKHN0cnVjdCBzb2NrDQo+ID4gKnNr
LCBzdHJ1Y3QgbXNnaGRyICptc2csDQo+ID4gwqAJdW5zaWduZWQgY2hhciByZWNvcmRfdHlwZSA9
IFRMU19SRUNPUkRfVFlQRV9EQVRBOw0KPiA+IMKgCWJvb2wgaXNfa3ZlYyA9IGlvdl9pdGVyX2lz
X2t2ZWMoJm1zZy0+bXNnX2l0ZXIpOw0KPiA+IMKgCWJvb2wgZW9yID0gIShtc2ctPm1zZ19mbGFn
cyAmIE1TR19NT1JFKTsNCj4gPiArCXUxNiByZWNvcmRfc2l6ZV9saW1pdDsNCj4gPiDCoAlzaXpl
X3QgdHJ5X3RvX2NvcHk7DQo+ID4gwqAJc3NpemVfdCBjb3BpZWQgPSAwOw0KPiA+IMKgCXN0cnVj
dCBza19tc2cgKm1zZ19wbCwgKm1zZ19lbjsNCj4gPiBAQCAtMTA1OCw2ICsxMDU5LDkgQEAgc3Rh
dGljIGludCB0bHNfc3dfc2VuZG1zZ19sb2NrZWQoc3RydWN0IHNvY2sNCj4gPiAqc2ssIHN0cnVj
dCBtc2doZHIgKm1zZywNCj4gPiDCoAkJfQ0KPiA+IMKgCX0NCj4gPiDCoA0KPiA+ICsJcmVjb3Jk
X3NpemVfbGltaXQgPSB0bHNfY3R4LT5yZWNvcmRfc2l6ZV9saW1pdCA/DQo+ID4gKwkJCcKgwqDC
oCB0bHNfY3R4LT5yZWNvcmRfc2l6ZV9saW1pdCA6DQo+ID4gVExTX01BWF9QQVlMT0FEX1NJWkU7
DQo+IA0KPiBBcyBTaW1vbiBzYWlkIChnb29kIGNhdGNoIFNpbW9uIDopKSwgdGhpcyBpc24ndCB1
c2VkIGFueXdoZXJlLiBBcmUNCj4geW91DQo+IHN1cmUgdGhpcyBwYXRjaCB3b3Jrcz8gVGhlIHBy
ZXZpb3VzIHZlcnNpb24gaGFkIGEgaHVuayBpbg0KPiB0bHNfc3dfc2VuZG1zZ19sb2NrZWQgdGhh
dCBsb29rcyBsaWtlIHdoYXQgSSB3b3VsZCBleHBlY3QuDQo+IA0KVGhpcyBpcyBhIGJ1ZyEgSSBt
aXNzZWQgYWRkaW5nIHRoYXQgaHVuay4NCj4gQW5kIHRoZSB0aGUgb2ZmbG9hZGVkIFRYIHBhdGgg
KGluIG5ldC90bHMvdGxzX2RldmljZS5jKSB3b3VsZCBhbHNvDQo+IG5lZWQgc2ltaWxhciBjaGFu
Z2VzLg0KPiANCk9rYXksIHdpbGwgYWRkIGluIFYzLg0KPiANCj4gSSdtIHdvbmRlcmluZyBpZiBp
dCdzIGJldHRlciB0byBhZGQgdGhpcyBjb25kaXRpb25hbCwgb3IganVzdA0KPiBpbml0aWFsaXpl
IHJlY29yZF9zaXplX2xpbWl0IHRvIFRMU19NQVhfUEFZTE9BRF9TSVpFIGFzIHdlIHNldCB1cCB0
aGUNCj4gdGxzX2NvbnRleHQuIFRoZW4gd2Ugb25seSBoYXZlIHRvIHJlcGxhY2UgVExTX01BWF9Q
QVlMT0FEX1NJWkUgd2l0aA0KPiB0bHNfY3R4LT5yZWNvcmRfc2l6ZV9saW1pdCBpbiBhIGZldyBw
bGFjZXM/DQpZZWFoIEkgdGhpbmsgc291bmRzIGJldHRlciwgd2lsbCBhZGQgZm9yIFYzLg0KDQpU
aGFua3MgZm9yIHRoZSBmZWVkYmFjayENCg0KUmVnYXJkcywNCldpbGZyZWQNCg0KDQo=

