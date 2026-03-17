Return-Path: <netdev+bounces-268364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOylAF2muGkthAEAu9opvQ
	(envelope-from <netdev+bounces-268364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:54:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 547512A25EF
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF1C63028039
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554B8223702;
	Tue, 17 Mar 2026 00:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iqLhLpuo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oIEv2c8h"
X-Original-To: netdev@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D885721CA02;
	Tue, 17 Mar 2026 00:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773708805; cv=fail; b=WP/BeeH90KxOsbQ76j4noUNTpdj3+YkC5pAFSCUtYqYsvb2JyOaKsvSKIWukNiS8ZoZl3bpW86udesPHxuhyuXQ0FzM4sTGWY4EIVPz1lLuZjYBalZUnUTd2tyxb/toeQJ/KqQJZ1uieOLInYhKldCVqiI/ECNCWOePNfXx9t4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773708805; c=relaxed/simple;
	bh=c+Q4iFmgeK1erKLlVOSgN4BityR3CxLOvBZHU/6PROk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L765dad2U4w5vsjlh8lP58/qGqG6KIz0R2r9neoQ4mc9s/y+iSNFQiosJgMLUnEjQOFnDv91CRDeFx+JWJVSh+HVAbtgUurXZHxwgiVzOIfhgpXxpwSuRCET6CWcgqXmOzDSprJnLa1SbIy5zlKfTv9tgAaIwNbLqybkZ8TCjfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iqLhLpuo; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=oIEv2c8h; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1773708803; x=1805244803;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=c+Q4iFmgeK1erKLlVOSgN4BityR3CxLOvBZHU/6PROk=;
  b=iqLhLpuonL966oFrCdINtY0rPwFsxUT9OpQzU3c3dSLUqSTOCwg60GZD
   /6fBy8h4Z9vbvk37Pahc9o/jhVCtzRbRBVdnosM92t9uTFe5BOe29W/ne
   I88dLvLg7yoFzFWHyVPoH8ZRABc/0E7CMvUCilJ4EGtK2+0kx9OLOTwyL
   JHCZxkCGEkNTLelYxRkPkDw3M/9jT9OgQss19w6RyvDUn5zomEwKORq1e
   nd40IcWEEndliy33z3/BbL/DZTYQVrX6c9kV6CXqfVUJxTq5vu5OmibCV
   lnP1metqEFK1qB6QJkVir8KtdCNwWXGLECLyKCxMLh/UqYnt5kj4rmePv
   g==;
X-CSE-ConnectionGUID: jFKOXeAdTyC6VwvXjhxLtw==
X-CSE-MsgGUID: EP0tNcuQTuea+U/m5OQIrA==
X-IronPort-AV: E=Sophos;i="6.23,124,1770566400"; 
   d="scan'208";a="142231318"
Received: from mail-southcentralusazon11013022.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.22])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Mar 2026 08:53:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brjvEDzM9W1hTj1aN0i5HFU7gUrDe77LqjFiHXPCMflW9qpnOxOc/l6zi+3JXPr79qAVvd0JBJPcCPLNVOsvvJ3gK8NxpO3T4vGSzIh156TWnM/PgN9/da5h5unjFM6eKCQYUcA5VIJ9Mlk5g7/ygPlCuBrw1Tm3aTAkF0e38GlxxNv7rApMV1VM3jYOZpU8/e9ldZ4rImQ5Aez6aPZItpnJvHFdZnXgj3Gvf+/ph7JPDinJb7fcSYSXyUHVkHsU/JIoXPHXdTbXON/OezKXLxEO/im0fWSRIjJ+KX7UGXGXGtzl87TjHrHvb3joHc2rTbmfHdQsdRGV+Wkt2m/peQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+Q4iFmgeK1erKLlVOSgN4BityR3CxLOvBZHU/6PROk=;
 b=DNhN8wtibWLgQa/Trpm8NHr6f2qrEllZDLAWOrc//dTvL8lun61F10NvsPCp5/JZxQvnACbDvcnf9ulWt8E+ZGw+4HskniGQNL4+hTlJmbj1DQ33oA0WQXu+xJyJNR3V+qPAoYC9f/EsdCjAzU5pMdt0+/32MBjqdlu9FagW+dvR9OmgTWcxuoXJrSEW2j55Nz7EivIKsyiXbObD/cOyPHZ0wGQNWQ/jio54N/phqPmu/A7Uh8xUL+ArV0gyUZjTY+6sCBHlW2e7scr2eDsCgk7T7meCgzbTvlrjO0g/MNFtkMcTQ0I0t4HC0LNdq0qwWFC7zeEJ9wPytAksa8wjLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+Q4iFmgeK1erKLlVOSgN4BityR3CxLOvBZHU/6PROk=;
 b=oIEv2c8hTbVceAh73HZ0TNobssHcwQF/bP97rYgVG6+pwG3TE8NyFpwaAwYgKQd0hxFQOl1D/J44Iiwz8QqFvuU5v4bVowq/+U0E3IyGcuM7J2yIT7zTKthD44Ob+8IxiJ6epPBMriHteIBULl5DFUYOX6fyGwuN5Hn2VYhidLU=
Received: from CO1PR04MB8300.namprd04.prod.outlook.com (2603:10b6:303:157::22)
 by SA1PR04MB8782.namprd04.prod.outlook.com (2603:10b6:806:378::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Tue, 17 Mar
 2026 00:53:04 +0000
Received: from CO1PR04MB8300.namprd04.prod.outlook.com
 ([fe80::a603:6dfb:1d4b:b36a]) by CO1PR04MB8300.namprd04.prod.outlook.com
 ([fe80::a603:6dfb:1d4b:b36a%6]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 00:53:07 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "sd@queasysnail.net"
	<sd@queasysnail.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Alistair Francis <Alistair.Francis@wdc.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [RFC net-next 1/3] net/tls_sw: support randomized zero padding
Thread-Topic: [RFC net-next 1/3] net/tls_sw: support randomized zero padding
Thread-Index: AQHcr4k7hso1zcbGlUqlU5NbBiJDT7WseAsAgAGpkICAA9A1AA==
Date: Tue, 17 Mar 2026 00:53:07 +0000
Message-ID: <9e9f6eb89ba95e9fbb764e2807420e98b566bf37.camel@wdc.com>
References: <20260309054837.2299732-2-wilfred.opensource@gmail.com>
		<20260309054837.2299732-3-wilfred.opensource@gmail.com>
		<abQOGm6BqAE5eEln@krikkit> <20260314073919.2f92b966@kernel.org>
In-Reply-To: <20260314073919.2f92b966@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR04MB8300:EE_|SA1PR04MB8782:EE_
x-ms-office365-filtering-correlation-id: dbbb2308-1cbf-4faf-d9d4-08de83bf8dcb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|19092799006|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 yPlhzmoJ0AC9/kB9l2u893zLa3MPwRwogA3DJ2tkYgs6656M+rhyJelnB2LcEvGxO9JrdCqscB74toqlZYiNQyI30KFI5o+r9OYz8rVttlzCizN3yyassAYk1yt2Ab4iGVuVLDXXzVatBWC2CZp83Wwq1D9GH/grfFJdPBrwQhh0dcwk8QrvqibDbrUEn++Oz+F/Iaw1W7IocJ/vacbclu3cBauSw1zdaFl8NuFFJlCONk0ZmyRJGtyQo1j2kSu9Y2uIj+MEu1kfV9NqB1pqCGtzx4C3gt2XzAz8XtYlSceAL53XfHzd5VTIZYkRbBZfXI0Q5D36+cRZ9ZyAOpQA0GszZ2Wcf9Dg7m4fn+dfMVsivvDGq+JfLh4fpRu7Q2MlzlgkcjJWAofEEvyTwwETLSTZQT/gSYASp592Q/Ucdx3scLjnQ8SqgtN5p/LKyUrgCCY3fDf6NZGhoOyZKgjRvHVRS7GjwUcceg+qZ45VOUBfWzan8OZWTbsCkt31crQGglHlAo8fUAUv0Xr/u7u0a0DBZ3KOExQhy2fRdJXC43DTPCjQ2pd7vb2EyVMzHo+3DS/Ysq4Ls6wQDuBwZ+F4GZqSB1/4008Lno25clfQCOvfpJCGfdoVwPtWzB5RvQz5u1d0/j25rZmRfdolgJeV7o3Xxb1RoiUNSfyaoWp74ejAugHhKjOpMei4ziPaXd/KLhNOvBd9zO48AEtwJO/jECW1yE8OG853pyE21czIEGnB9lvVkT8dwzNcnkPHS+fHU+V8Au6RKvm9IOoofqgchIB6cMzxq/9wgl4nA+GxORY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR04MB8300.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(19092799006)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NnI2S2xLeHVlT2hiZkNjRElOQmZwL1JQV3lDeitITDRvTWJ5MzVTeHRHWk4r?=
 =?utf-8?B?bFhza0REVVhEd2dNSUtPZ0FJc21vYnFrdHJtbzk3OCtTbko0TUc5RENtR2VN?=
 =?utf-8?B?ZjdyazY0QWNXbGd1ektmS3RMVlN6TDQybE1aUzF1NWtKc0N1eGthRjBVbzRy?=
 =?utf-8?B?WWUwMGJJZ3VicU8vOUo2K3JNSWRqcFFaODBzWUJKYk9JT3FmRktCWTQyakM1?=
 =?utf-8?B?a2o1bDIyMzlNSjNOYTh5WGpoOGJSKy9lcnZLR1U4Tk1heXVBQ2ZsallyWkFz?=
 =?utf-8?B?TW13eXRhM0lqRTlrUEdmejRZVVNEaUpSZmVzekVucklPclNTNDFxdmxQQnR3?=
 =?utf-8?B?Q3I3cTRqVnZYam1qZkpJZnR6ZjRwQkgwTDJyWjFNbGRaOW01dGFxUGtlbi9o?=
 =?utf-8?B?V1VCKzFQZTRaYURHZkcrdkZRVUtlOXgzKzZtZjJ3N3hBaUlCUzVBY3NZemht?=
 =?utf-8?B?N1NyaG0waGtacXJPclEvTlFSTlNBcnlJVmJySzJLU0tPL1JKeUNGc2pJUElR?=
 =?utf-8?B?UWgydmxKLytFNi9hb1RIVnhXQk5kTnZIb3BJc0hDcEJ6ZHJUMEp3NmkvcWRq?=
 =?utf-8?B?Ykh4YUlKRWlHdFNhVGpocFdJNCtRNm42cERkQ3EycE1lUGROWStFeUNVc1pk?=
 =?utf-8?B?VFJ5cDlNWUF5czZEY0dmektNbXlxQ2NES01INFlOa1ZzK1AySGp5dkRHanBM?=
 =?utf-8?B?dUxnZXlPdTFVa0NoV05Xc1NneEFyTlV6eFpOd3FQUmt0T09LOTlacGRicXpi?=
 =?utf-8?B?ZHBrUGp1Q0FiMkp3VVBDWjJwVDFjKzkvR2s3azV5MDJMUGxhL0JYUDdNS3BT?=
 =?utf-8?B?UHYycVhZcDI2Ykp1ZjNaR09lakJ2U2hQeE9haW9Ia3ZEcmFaWmlEZXlWcjdO?=
 =?utf-8?B?WlJjVWtVNlJUY3hGQVVSZStmYjlWZzJiZFBZS1NvZXprSjFsbkR2dFd3UFpP?=
 =?utf-8?B?NkZjU0ZoYlNTbjRMSUo4U3dKMmtHeERncmFrMkpOSVBrZ3NlMWd5UVJ3VjhJ?=
 =?utf-8?B?R2hDRDhkVkQwR1ZXQnFtbFRWVjhtRStCMkNScUYwOFNFRGF2ZmhiRzliMUVi?=
 =?utf-8?B?T2NCTlk3NUw5QmpGMzRHdzhXQ2tRT1FNd3I1THVTRStWcVF1L0ZobzV6cStC?=
 =?utf-8?B?Zzh3bEZ4NXZwdFpubndXQmlRUkVVTjZaQlZWb1RQcjVsc2lrb0ROZUVycGxR?=
 =?utf-8?B?TFNrZHRQZ0o3emJsWmlXclpnT1J6Z2M5S3psbXlqUktDNURVNDk2bkhLK2xR?=
 =?utf-8?B?REpCMHNSOTBId0tWQXV3M2RXWG1wOUlYYVZnN3RsQXlvN2VNZitNNG5vTjBt?=
 =?utf-8?B?UUhGV09nOHd6TVpEcEdmZldHSTl2UWs3NHhjN3RtaHlzVGhOZnF2U01mbXEv?=
 =?utf-8?B?OTVZNmJlS0NvRDRHdE1XK1JLVUZ4ZVJiWTNWY0ZsMGxsT0xIMmdXYlRKTkV2?=
 =?utf-8?B?Rk9xeHVBNHMzQUV1TzIyNXdDaHVPSWV4RkFoYmNNTFBnWTRDc3ROVlBlbW5J?=
 =?utf-8?B?UTZJdy8wMU9XR2toSDlic2RuUHByU0U1cE9iamFhODBqTnpwZmxyYTRINFd4?=
 =?utf-8?B?U1dVVEE3V3IyMktHeTRpUVJVOU02L1BaVldqaGl3dkphbHlkL0NMS0FwblYx?=
 =?utf-8?B?bms3Z29WYmJJMlhtTDdsUkk1dDlGQnhuTmhyd0RPV2tHaHJpbkhNdG95RGZu?=
 =?utf-8?B?TnJ6RFFHTjIrWXdsNWx6WDhsYS9oUFNOZnZZdFM4aEh5UURLRzlYUHNUYnNV?=
 =?utf-8?B?MGlsZ05iTGh0NzY0dzdiNlBoRnFuNTk3anEzTUFwZkNKd0dXd3loQ0s3Q051?=
 =?utf-8?B?aThaZTFSTWprc2dhVEU0VjhhRU1vWEcwTVVlZ3QxY3JnUStrSFpXK1EzbVVL?=
 =?utf-8?B?QVo4US9WVGNYWVZpOThLLzZPZmFCLzg3TWxuQ1pyYWhkUTZyZzhIazl4b1Q3?=
 =?utf-8?B?a0FnNjZKKzlLQW9MT2laZHE3VXZPZEs4MndSRE52U3pqWXhuV1c5RG92dU1z?=
 =?utf-8?B?aS9kUVJqb0hTdTNsUkNoZHpDNUtiSUZnbU9rZTBpOWZiaWlXKyt4UjVTaVg2?=
 =?utf-8?B?K0h6clIwY0g1bFk0VTFrVFZ3TE9qdGFva0JIdnJtMUcvdHJ1L2FTb052c3FM?=
 =?utf-8?B?LzlwV1luc1R3TytQUVE3NDJ2SFhkR1o5SWtoVTZJVGw5Q01aYlF0T2RiY25t?=
 =?utf-8?B?NUo3Rk9WUkc4Q3FPd3dhc3FIRjhZRVpJd0Ezdy9ZM1hyLzhXb0hxYVczSTN1?=
 =?utf-8?B?eFdpMkhmeER0TGhtZlIxcmxXQVFmNGZwOW0wQ0VZeHZOSU5mM0x3WG1qRWNo?=
 =?utf-8?B?am5MREFHVGQ3Umo1K0xkcC9pc1BuejdjbTVXbUtGZEFZZGJNTk9FWnFkdnNy?=
 =?utf-8?Q?KpsesWCA8kz4mtQU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD3A1FBCAC5F184EAC10D9E03DF65B09@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	wL6KdGrxlZZi6vJ8G0IgPvuog4c+/fuT2lK3XoYJSAM7fJ7azwLVxuTEi/KFBtLEBtJhY7/Lj0E5Xv/NPIIlIllb3e0+hLNnZDwhoZk7wTQG3u5gYJXzmOHGYb+y8z2AbPbyuQBx6PG5bGXz3bsTaKr4Sk2SMPeUW6n/TuRJSyxIxtjOc12XGGr1+mnhmz24Lg08S/fO6fNiSHwOzo2mdIlwH4FGCi3PhYiF7a4QnsdqCOYYXtjvlXz4K0+BI/8IyoqAQ490natRVXk+V34n1Y1f4tk3Jw2gw568CbngNbGIitKiyeu1d8YkEsG7fCutpoHI2hqH2EB1hUkAw9DcEQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MOkDZT6Yt7BygpnbhixO2HZPSQUYfgkzh78Dy6yaVt+1wSf/Khfv0JyzsQHZ1/2X9Wxg8WorvlL8/uQuZm7ARfPJrc78n3XBAiDtKM5g5iuPRMRAzRV2Xx6Ze8y6G5/xBahdk0OaaAANYGcpMRKTIem3KqLV6y9mlKLR2hQIvTs1JkVpbQ3nbF9ubXqk5mWFoDlf/unBG7r2ygFjLA2aRM/uEFld1FU0EXYLBdCE67raydrClJfFAGccQfbH0v7cMsx05FZDExrG15wb+7SMgreVLJNmKBbITNSTYbHXmNPLJucT5IjabekA8gvZn3X/8tL5zS0Mt3yeK8Y5MicU4GgGQB9Jn7z8kzauMGj/k+RlDTGMYOPEWu5jyZGJX1izpe5O2kA68N2SkLMboTArzbkYhmOQr+YzvLWNBv1VH292Jtf3G+8qX+JUgzEOa6y0kDDp/iPzAvyziEZh88W3hbqwB3F6heDUmJQ+zlAATXrOeL9Ho4x2zKSNBvl9nq8+s+yvyqoTQC9A2+08i/5m0XMLZ4lJfBrlYRkq1u3t6W0BGu7OkTE2CZl0BMD+Vx5b6OSnYKO+Rtzp0zd/GOuca2bPCM6LAPjfuYZvVoIWl+DaVb/aRQhsAhyu0hQ8O173
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR04MB8300.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbb2308-1cbf-4faf-d9d4-08de83bf8dcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 00:53:07.3834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FVeIrPTaXvUkuPeAABSnvTQ9D17NIjtd1k8tHNDC8Zlo/VqDOwxb8xzVuYWKpDgsxYdAn3QhpeptppohDdT4ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8782
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-268364-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lwn.net,kernel.org,davemloft.net,vger.kernel.org,gmail.com,queasysnail.net,wdc.com,redhat.com,linuxfoundation.org,google.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[wilfred.mallawa@wdc.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ietf.org:url,sharedspace.onmicrosoft.com:dkim,wdc.com:dkim,wdc.com:email,wdc.com:mid]
X-Rspamd-Queue-Id: 547512A25EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gU2F0LCAyMDI2LTAzLTE0IGF0IDA3OjM5IC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gRnJpLCAxMyBNYXIgMjAyNiAxNDoxNjoxMCArMDEwMCBTYWJyaW5hIER1YnJvY2Egd3Jv
dGU6DQo+ID4gMjAyNi0wMy0wOSwgMTU6NDg6MzYgKzEwMDAsIFdpbGZyZWQgTWFsbGF3YSB3cm90
ZToNCj4gPiA+IEZyb206IFdpbGZyZWQgTWFsbGF3YSA8d2lsZnJlZC5tYWxsYXdhQHdkYy5jb20+
DQo+ID4gPiANCj4gPiA+IEN1cnJlbnRseSwgZm9yIFRMUyAxLjMsIGt0bHMgZG9lcyBub3Qgc3Vw
cG9ydCByZWNvcmQgemVybyBwYWRkaW5nDQo+ID4gPiBbMV0uDQo+ID4gPiBSZWNvcmQgemVybyBw
YWRkaW5nIGlzIHVzZWQgdG8gYWxsb3cgdGhlIHNlbmRlciB0byBoaWRlIHRoZSBzaXplDQo+ID4g
PiBvZiB0aGUNCj4gPiA+IHRyYWZmaWMgcGF0dGVybnMgZnJvbSBhbiBvYnNlcnZlci4gVExTIGlz
IHN1c2NlcHRpYmxlIHRvIGENCj4gPiA+IHZhcmlldHkgb2YgdHJhZmZpYw0KPiA+ID4gYW5hbHlz
aXMgYXR0YWNrcyBiYXNlZCBvbiBvYnNlcnZpbmcgdGhlIGxlbmd0aCBhbmQgdGltaW5nIG9mDQo+
ID4gPiBlbmNyeXB0ZWQNCj4gPiA+IHBhY2tldHMgWzJdLiBVcGNvbWluZyBXZXN0ZXJuIERpZ2l0
YWwgTlZNZS1UQ1AgaGFyZHdhcmUNCj4gPiA+IGNvbnRyb2xsZXJzDQo+ID4gPiBpbXBsZW1lbnQg
VExTIDEuMy4gV2hpY2ggZnJvbSBhIHNlY3VyaXR5IHBlcnNwZWN0aXZlLCBjYW4gYmVuZWZpdA0K
PiA+ID4gZnJvbSBoYXZpbmcNCj4gPiA+IHJlY29yZCB6ZXJvIHBhZGRpbmcgZW5hYmxlZCB0byBt
aXRpZ2F0ZSBhZ2FpbnN0IHRyYWZmaWMgYW5hbHlzaXMNCj4gPiA+IGF0dGFja3MgWzJdLg0KPiA+
ID4gDQo+ID4gPiBUaHVzLCBmb3IgVFgsIGFkZCBzdXBwb3J0IHRvIGFwcGVuZGluZyBhIHJhbmRv
bWl6ZWQgbnVtYmVyIG9mDQo+ID4gPiB6ZXJvIHBhZGRpbmcNCj4gPiA+IGJ5dGVzIHRvIGVuZC1v
Zi1yZWNvcmQgKEVPUikgcmVjb3JkcyB0aGF0IGFyZSBub3QgZnVsbC4gVGhlDQo+ID4gPiBudW1i
ZXIgb2YgemVyb8KgIA0KPiA+IA0KPiA+IEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyB0aGUgcmlnaHQg
YmVoYXZpb3IuIEkgZXhwZWN0IHRoYXQgYSB1c2VyIHRoYXQNCj4gPiBlbmFibGVzIHplcm8tcGFk
ZGluZyB3b3VsZCB3YW50IF9ldmVyeV8gcmVjb3JkIHRoZXkgc2VuZCB0byBiZQ0KPiA+IHBhZGRl
ZCwNCj4gPiBhbmQgdGhlaXIgcGF5bG9hZCBpcyBnb2luZyB0byBiZSBzcGxpdCBpbnRvIGhvd2V2
ZXIgbWFueSByZWNvcmRzDQo+ID4gdGhhdA0KPiA+IHJlcXVpcmVzLiBUaGlzIGNvdWxkIG1lYW4g
dGhhdCBkYXRhIHRoYXQgd291bGQganVzdCBmaXQgaW4gYSByZWNvcmQNCj4gPiB3aWxsIGdldCBz
cGxpdCBpbnRvIG9uZSBmdWxsICsgb25lIHZlcnkgc21hbGwgcmVjb3JkLg0KPiA+IA0KPiA+IEFz
IGl0IGlzLCBpZiBJIHJlcGVhdGVkbHkgY2FsbCBzZW5kIHdpdGggTVNHX01PUkUgdG8gbGV0IGt0
bHMgY2h1bmsNCj4gPiB0aGlzIGZvciBtZSwgemVyby1wYWRkaW5nIGhhcyBubyBlZmZlY3QuIFRo
YXQgZG9lc24ndCBzZWVtIHJpZ2h0Lg0KPiA+IA0KPiA+IERvZXMgdGhhdCBtYWtlIHNlbnNlPw0K
PiANCj4gT3IgbWF5YmUgeW91IGNvdWxkIHJlZmVyIHRvIGV4aXN0aW5nIGltcGxlbWVudGF0aW9u
cyBvZiB0aGlzIGZlYXR1cmUNCj4gaW4gdXNlciBzcGFjZSBsaWJzPyBUaGUgcGFkZGluZyBmZWF0
dXJlIHNlZW1zIHNsaWdodGx5IG5lYnVsb3VzLCANCj4gSSB3YXNuJ3QgYXdhcmUgb2YgYW55b25l
IGFjdHVhbGx5IHVzaW5nIGl0LiBNYXliZSBJIHNob3VsZCBhc2suLi4NCj4gYXJlIHlvdSBhY3R1
YWxseSBwbGFubmluZyB0byB1c2UgaXQsIG9yIGFyZSB5b3UgY2hlY2tpbmcgYSBib3g/DQoNCkZv
ciB1cGNvbWluZyBXRCBoYXJkd2FyZSwgd2Ugd2VyZSBwbGFubmluZyBvbiBpbmZvcm1pbmcgdXNl
cnMgdG8gdXNlDQp0aGlzIGZlYXR1cmUgaWYgYW4gZXh0cmEgbGF5ZXIgb2Ygc2VjdXJpdHkgY2Fu
IGJlbmVmaXQgdGhlaXIgcGFydGljdWxhcg0KY29uZmlndXJhdGlvbi4gQnV0IHRvIGFuc3dlciB5
b3VyIHF1ZXN0aW9uLCBJIHRoaW5rIHRoaXMgZmFsbHMgbW9yZQ0KaW50byB0aGUgImNoZWNraW5n
IGEgYm94Ii4uLg0KDQpJJ20gaGFwcHkgdG8gZHJvcCB0aGlzIHNlcmllcyBpZiB0aGVyZSdzIG5v
dCBtdWNoIGFkZGVkIHZhbHVlIGZyb20NCmhhdmluZyB0aGlzIGFzIGFuIGF2YWlsYWJsZSBvcHRp
b24gZm9yIHVzZXJzLg0KDQo+IA0KPiBTZWNvbmQgcXVlc3Rpb24gLSBkbyB3ZSBhbHNvIG5lZWQg
dG8gc3VwcG9ydCB6ZXJvLWJ5dGUgcmVjb3Jkcw0KPiAoZW50aXJlDQo+IHJlY29yZCBpcyBwYWRk
aW5nKSB0byBwcmV2ZW50IHRpbWluZyBhdHRhY2tzPw0KDQpUaGF0J3MgYSBnb29kIHBvaW50LCBh
bHRob3VnaCBpdCBpcyBub3QgbmVlZGVkLCBoYXZpbmcgaXQgY291bGQgYmVuZWZpdA0KaW4gdGlt
aW5nIGF0dGFja3MuIEFzIFJGQzg0NDYgWzFdIHB1dHMgaXQsIA0KIlRoaXMgcGVybWl0cyBnZW5l
cmF0aW9uIG9mIHBsYXVzaWJseSBzaXplZCBjb3ZlciB0cmFmZmljIGluIGNvbnRleHRzDQp3aGVy
ZSB0aGUgcHJlc2VuY2Ugb3IgYWJzZW5jZSBvZiBhY3Rpdml0eSBtYXkgYmUgc2Vuc2l0aXZlLiIN
Cg0KSSBjYW4gbG9vayBpbnRvIHRoYXQgaWYgd2UgYXJlIGdvaW5nIGFoZWFkIHdpdGggdGhpcyBz
ZXJpZXMuLi4NCg0KUmVnYXJkcywNCldpbGZyZWQNCg0KWzFdIGh0dHBzOi8vZGF0YXRyYWNrZXIu
aWV0Zi5vcmcvZG9jL2h0bWwvcmZjODQ0NiNzZWN0aW9uLTUuNA0K

