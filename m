Return-Path: <netdev+bounces-104618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0E590D974
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3021C21CD2
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3650274070;
	Tue, 18 Jun 2024 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="pk1lkHEV";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="j7/k5UiA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89653433AB;
	Tue, 18 Jun 2024 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718728795; cv=fail; b=YH99AbgmOqwagZWiA2A0qM+q7EWYnkL2xmcypc2VY0TiQ+Vru8WQxsezWs5AwbVSGfMUGFZCMhUn0wD8kMweW2Quz7jTFFMg9ltt71icSFDMZr0GwvEW4jMhTyL35Ef2WZQ/pSfpR8OxY2hpDv1xxPEwP7ZXax9tnnYUXO4XBmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718728795; c=relaxed/simple;
	bh=rxfkGE6b63lesPJPKgPJMCmXaCwOWDnOd/2XF6IIkug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LeDtI25+8Ncr6oytAUg33W5Cr68vDm4uUSRLhCbZVDscS12Ga7pDaKfJyDhMyK7+vambAw019xgvj2cRTJIRRMGsGHY3NkgpdWzkq4ClWU5WSSP5ALe9Mmk1NxHt8Wx0TNWlC82494Gpq3qTK++j4lMhu+NYhEp7PDvDRkCkIB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=pk1lkHEV; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=j7/k5UiA; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I8JprK030552;
	Tue, 18 Jun 2024 09:39:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=rxfkGE6b63lesPJPKgPJMCmXaCwOWDnOd/2XF6IIk
	ug=; b=pk1lkHEVRBP2ibRswMUCSpvi8jmm4lKIeM+9uFa2cq3BLaj4vcwrcKQoh
	rVkYVTPFq6qZ27GcOHcRalzIFKSKsuDhTsiyqW1iJjT/UUZoBEDlnxqSTkfFMzb1
	y+hAEOGkRFc8l6ipLdfKasuv4gCjLAaZ78yR5E0CspS2p4NBq54Ipy31GZGiWcga
	6E6eUp1oy5DE069yTZDaV3RVmdMC9/YmlbBEllCMwSLQWXBzUJWR1VBM8h9ps1Tf
	8jSnM+14eOxbTzREob6HSu867lqF+OJGelALfUFjYnlbBMIw4g34fEovNWt9dk+Q
	PFMuq8EMN+51PRwVrBAGLiwXZZSNg==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3ys6v5x0x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 09:39:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzpkNUWle8MIagbPKoiZvW76fbC343vcdnXPlSPzHGD4eIbkPzHigzVdMrxkHW02+os+E/NanUGLkXjmWIo1VfYY5HhfsFnA+61YR8PzUGPaTjpZgzVdbDZKQDSk+ZBPDKdOS0U/uLRHTEx1hwSn0oTGer16qBjhAfsB1QQsoj5IR0WEYTMS4L53Z3bgVYIBAZOoPm+UUCPxv4P7lg29+3NPYkJvELGX9Y0ek52P0Q2EFw/qxCqE2t76gkM3XoOanNt/fuCH5w7hjOfYFTuXvSz/Gd3fOvuXv7czzSstdfjO6j0Lu6zuNlv7CYCz7auTES6jFp1lF8Nk1WSJY50CEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxfkGE6b63lesPJPKgPJMCmXaCwOWDnOd/2XF6IIkug=;
 b=XU3QoA01AnAFmkgWQYlPIWiPHRs3pSWX3l02Uf92/Yeo+MFB/zBRf4/DEmVxK3Jd0Q3YrNn+axT4OeZs+GN/g402FKkRgaQjrldoHix82SyWf1bIzPDhQE4Hq/Xl43pQHcmDP1xvuydjh6szbkOm+GYeS/K4lZeXxRN66SN+/uh5gaHQWTJ6wc3+40NWvcPDtJryXZeh26cA2RUjNP8gOyL1LKGwhm2SZrgO2QWtQWxZfVLFd9egT7OmujrSNOAINkAmTNUPk3Cx3F/KonJ+hsmdykRqtvqgz7z6jKxraYidVr9sOYC6Iq0YVpuc2ymH5k5XlYNR8cv/IilxrcvBig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxfkGE6b63lesPJPKgPJMCmXaCwOWDnOd/2XF6IIkug=;
 b=j7/k5UiAVSK9xpuotSqHk739JgXxewRKe038/M3jBbUgyqe9AM9pcba66GT9qO1P2349AlvitNCZERt5ku6KOdRxhjDFXw+oLe/yqSwBSuPp8PelJQoWSVaQ+/PQHAsusqnB6tJRTLdk9YL/uz13mn+mZg1/s9rC3IJTLpLiAxKCVIjbUCuYaCzKoIA0vH/kHHFzn255tq040Br1r2Of1tWF77Ks/gPYmTsRmIgs4G6oI9/v3to6ZwXByR2OGen2jIciF93yjyuibq6lKOLGtBfS4xud3SpgGnPSg2sTJ6p/Vvko88XyWv5rfBg4xAlj8gQTSB76upetdQJLdznLpA==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by LV8PR02MB10096.namprd02.prod.outlook.com
 (2603:10b6:408:181::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 16:39:40 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 16:39:40 +0000
From: Jon Kohler <jon@nutanix.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Larysa Zaremba
	<larysa.zaremba@intel.com>
Subject: Re: [PATCH] enic: add ethtool get_channel support
Thread-Topic: [PATCH] enic: add ethtool get_channel support
Thread-Index: AQHawZcrbaLWefPNP0aAi0Gu7Ms7PbHNs7oAgAAFRIA=
Date: Tue, 18 Jun 2024 16:39:40 +0000
Message-ID: <2CB61A20-4055-49AF-A941-AF5376687244@nutanix.com>
References: <20240618160146.3900470-1-jon@nutanix.com>
 <51a446e5-e5c5-433d-96fd-e0e23d560b08@intel.com>
In-Reply-To: <51a446e5-e5c5-433d-96fd-e0e23d560b08@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|LV8PR02MB10096:EE_
x-ms-office365-filtering-correlation-id: 82f88bbd-5fcb-482c-da12-08dc8fb53fc4
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|366013|7416011|1800799021|376011|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?M1pvTkE2VldNalBZNndDMlhpZTVxRDZna1NhdktWcDNuTC93SW5UMmo0dXd3?=
 =?utf-8?B?ZE5YcGpqTUxabVJSSE1PSXd2aTRpSi9qUzVabFFaK1ZpRU9ZL0tqTEx1QUVS?=
 =?utf-8?B?T0VkY0drSW4vbDdITCtMc3Z3aGV3cE1RYlZJMnE3TGMxVUV1RkNoWGVuNmxo?=
 =?utf-8?B?bCtxVU9JQ05ZWXNNY1AyUitmUkkxOTl3ZlF6QVJZdlNJanpJYnZvRXloM0wr?=
 =?utf-8?B?M2NwOFQrQ0txMTczYVlIa2VQKzlQNWRJN3NtMUwrQUt4REZSc0tYSVo5UG40?=
 =?utf-8?B?eXV6ZGtvSmRWT254aDZPOHNuVnZZYjBOcG1ITkRpMy93d0pZV0UxUUFOVUp4?=
 =?utf-8?B?UDdFYnpvNHVuOTBRdnhKcFVKdE1tTnFVVFc3UnJtUC9PNEFZRHo4RzRsVVdp?=
 =?utf-8?B?RkdlTlN5Vm15aTZubmtzaEcydGk0WktQT0NEV0FuSW14L3NjT2Q5M0Y0OXRR?=
 =?utf-8?B?S0RYejdTRWV5M0JmYU81RkFuRDRocjNnb1ArY2tCNmo3cHc0M2hVaWJRcjAv?=
 =?utf-8?B?V3ZEMmF4WTEveHlJWDZnbGJzMk9VSmFpNTVTQm9na3IzTVlmc01lK3Y2S0Qw?=
 =?utf-8?B?NlRDeDNQNHEvZzVpeDIxdlBPWFNMbG5IVkZkSmU3WnZFeHM1V3ZHSmx6c05J?=
 =?utf-8?B?eVcwVDk5VG5hVmRHTFVaVmUyU3RmbEtST1BMbE4vV001VmRhOEo5MXhrUERC?=
 =?utf-8?B?b3NwQ0VsYmtTMWZuSWVSRUQydnF3bkNYTlFjam56TG9HM2hSaHNMN2xQMjI0?=
 =?utf-8?B?Q2F3amx5SktHc09sZVdzWXpCWFdXSWVnR3F3MTZFNTBGQ0ZPdjFYMVBpSHh1?=
 =?utf-8?B?dUZ6L3ZMcVNLQ0R3djA0NlM2STF5NG5qdXpaMzI4NXlxZ3BoR2JzdXVpMEJM?=
 =?utf-8?B?YnMzNjVFUkpZblhVSkFBNEpOTXRhTmlUWVpNRXJJUjdvbzNDMWFSYnpDQlJH?=
 =?utf-8?B?bGFUUXNlbnMyaGFiNllwaDFKK2ZWTXpUMlFyVWIxZmQ4QjBBMGtuZ2lGZHdx?=
 =?utf-8?B?ZnFDREJlbXdBUENxdzc3MDlkOC91d3YxT1JtU0JiSHVyOThkbFhicHY2T1Qx?=
 =?utf-8?B?R0NiY0dnMlI3cDVDRjNyTzBLanNtVHROWStKVm5BY3B0T0tSRDRHT1ZwdFFs?=
 =?utf-8?B?b2pURXlqYlRzRTVkZWN0RVd5VlUrMlJNckYwQTdLdk4zdkMrd21ZT0hoM2di?=
 =?utf-8?B?aFpjaHl3SitTOVEvelo3ckR6ZXhSSmY0TDdBOGZFWTBVVXFXVDI0dXYzZUtG?=
 =?utf-8?B?OUhtNEZRaVFZbytDVFRTaFRVRnBweVpveDRVVHEzQkVsNUxyRVV2aG1tcU0v?=
 =?utf-8?B?YmN3a3pya3dqbGZJMHlHM1dCM1FXZTRPaDNIOUNLWGxTNHNjZ3FUc2w4OEVD?=
 =?utf-8?B?ZE9LbTNvQ3l0STFyTjBnL0lXMnlpdDBNOTVBd21vOWRmQUt1bGljVHdDTVdl?=
 =?utf-8?B?aWRTaEVreG9qeWFSQ1JVQ2FmME5xc2tXeHlrdUkreDl0VEhBVnc4cktBV1A0?=
 =?utf-8?B?WU9YU3JNbDlvdGRFUFBDQis0RjNJcXVJSVR6SEtLajdQa2JKZnM4bVpldERE?=
 =?utf-8?B?T1hMbnlqdDBzSlZPbGNITHgrRkZWRTZDQVNpaGdHQ2hHL2czN2VzeXRsbnB5?=
 =?utf-8?B?bjU0YzNxUDRSVDNZMTVjZ2ZNQ21iWkViOVUwcEtMZE9TVEJHWkE3UnVSa0Y4?=
 =?utf-8?B?S3NPRjAwREViL0pUTmJjdVFEM0ZJQzdGK3hTNGVFaWRSNHBYbm5GVTVDekVR?=
 =?utf-8?B?NkFla3pPNll5VVIyRzZhSEc3N09aVVA5OG8xbWk3aWZqL1BwL2Fjb2NSdTNJ?=
 =?utf-8?Q?zSuXXvXgkCo6GSMvS27l9o311rBC8Ktl/k6gE=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WkZPTmREdG85S2NvYkNuUzhEakJMTlIvWDVXczhjdFBPQ3EzVDRCVzNlc3Rx?=
 =?utf-8?B?aHVGVkQ3QlRpNUVTS0Q5dHFVeWlHSUJ3L2ZibEhEa2tmaFhUZXBocGpwTGRG?=
 =?utf-8?B?NW5jRWtSVG43ZzNaZUhseWI3YzNDcE1TV1dGRjdLdGE4RWdwMWNlMTZjcUhS?=
 =?utf-8?B?T1E5ZXg1MVNwMlZLekp3VzBJQWV5bEhlcTVyWExFMEp3K0VLN2NPNExnMDQx?=
 =?utf-8?B?Y0hGNHIvVVEyV1k4UmtjclYwMEdUeEUzcGU1aVhrMk1aSlR5MDIzVXNOamZa?=
 =?utf-8?B?NVh6ZzZIbU9Hcm5jSjNVaDdoN0RWTDM5eWxPeDA0aFF2V0NTTGk2QTMyY2NN?=
 =?utf-8?B?OGhSUEl5VGFOV3dySk0wTlpQQzBKVFc3SW5TTWg5bUt1OWRtRUJkSjJpZHpZ?=
 =?utf-8?B?YmFMYUVNL2xIREhjZTdMTXVrSWV2SThua1c5NHd5WmxEL1JZdllJenVoNUc4?=
 =?utf-8?B?cFV5ZkdaUzdDcGZQcVpOb0c1bzVBUlNtWHV5allsV2pjbkRpS0FnM2R6SVR1?=
 =?utf-8?B?RTRSZXlaV3dXZXJxMHcraDNjLzR0bm5uTHkrR2hsVCs5S3ZGVDlvRU5YeGJU?=
 =?utf-8?B?azFwK0MxWlAvQUFaSGJQUjBYQkRIcnhLS2ZGMmhTRWJ4SGw5eVprQkV0c0Ev?=
 =?utf-8?B?MDlVWVU1bDBYa1Q2OElWK2hkaldjQ3phTnMwdWRBVWNmaGNVRzNLa3ZldnFk?=
 =?utf-8?B?dWs2c1BnL1pkaFgxTFMraVBndnJEZzMrZStvbGloWDVsMjNLMXRxbU5iSGRP?=
 =?utf-8?B?Q0JLQ0JXVjRtYWNCZmhYeGlMak5lS2E0YVl3VHczZ2E0dXNtbUZKSyttZExy?=
 =?utf-8?B?OVczdE5weW1tdkdHWGVFNitkQmwxUXc4NDJ2QVNtL1ZTd0FiNlBsRmxPQ0Fa?=
 =?utf-8?B?eU5UMzNOZ3QzSlRRSW9KSjZ0QVNheGFtc0FtSUNHaUh6MXhRS3lweEtoRi9v?=
 =?utf-8?B?MmhSeGxRMkxCdW1QZEVpcU9aT0lBbGNFQUJqSk1zZy9YYXpaVzJhcWJrQ1hk?=
 =?utf-8?B?ZDQyejdpK2V0dE9jS1ZxYmlRc3hPWk5yWkc4YkxWOFJ1RDlobFBsWlhmU2xP?=
 =?utf-8?B?eW1MTDBEVTRBRGtFUG14aWUxdDZOcCs0WGU3OFFmTEVnMlFJYXRPK1VaSE9J?=
 =?utf-8?B?RzNzN3ByTzI2ZEtjT0xsSzY5VGFIb3JxbmIrcWlhTnVpbm80ME40MkpWd3R1?=
 =?utf-8?B?WGZrOWZsbkp1eUE2TUltNEFYaVJLTVJSSmY0TXNiT0psTWdBdUFOaE9WQllU?=
 =?utf-8?B?c2lXTkRyZVVNQ2JDT0RBWDlWaFVkU1d6TlhoTzUzalZLRzU1Lyt6VHE2Z3Ry?=
 =?utf-8?B?STRJK2VOcmtleGx2SW45TVhCS1Ixa0QrSlVXcUFsTmV2Q0Z2M21OeGJaSklK?=
 =?utf-8?B?R2NScWxhaGlvNEVONkQzLzlaMnVaWFcvdU5nTGpWREFtaGZSc05ldStYdnVJ?=
 =?utf-8?B?dDBxL04zTzhLVzhqcW5IOEZHNng5djEwbjRUc1RvTFRRUjJRWjUybmVrSU8w?=
 =?utf-8?B?dSs2T2ZJeVBKaVY4dE9BTUVjS01YbHY5Ynk5WHVGbnpEcE0vQXBJdjVsZXhG?=
 =?utf-8?B?TVhvQ3d6cXVkZkpvVThoaG94cjBZY3FwcmxEczJMbWR0enN2M2ZRWHkrcThG?=
 =?utf-8?B?MHhyVHQzQXJGMUVTRENQMEZQVEpTdjBUK01XUXNkb0NTR1Nud1Q0aG5IU0pr?=
 =?utf-8?B?OFUvUlkvUUNnK1lCWm9menlueVVUYVdUeTZjRFE4U1hoNDBhamNIbDdrQm43?=
 =?utf-8?B?SmlycnJtSDMxZUVxcXFVU1QrV05jbU15SHF3eGo2blhBZXF4WWpHdVBhSE16?=
 =?utf-8?B?MElaZzNtMmNMSFE5ZzZJSUZiU01XV1U0WmkwRmw0N2trdEl1bGd0aXlPQVFJ?=
 =?utf-8?B?cFNxZHpLRFVKazU1SkFpU2lFN0Z5eDU5cmNSdmtuTHlQT0VLcUVyZm5iL1JG?=
 =?utf-8?B?bFpIeDhKYmlUZXlha2J6dldOV3dQMWVWTU44OHpZRXYxZVVzRjE4WUttakNi?=
 =?utf-8?B?dUtqZVhwOElPZUYwK1VZWW9nWjlvUkU3Ulh2eit0cmlmT3BpNnBmS3ZWUXB5?=
 =?utf-8?B?eGNXL24wcE1ycXdIYkN3QjdFME9FaUlkVDRMVHJDblF1R2YxbjRwVVBGUGsx?=
 =?utf-8?B?L0lRT28rZmo3b0g3RVVlVDRZQXFacGMreHpVYjdHeG5YQXZES010ZGNCb0NE?=
 =?utf-8?B?cmhvdUh1TVd2QllSaEdwTXhHY09LRXdodUl5WWt6NzlkTVFFR2pYK2ZRbWpP?=
 =?utf-8?Q?y3QlBHNi/dQAuuOwwil0h3531nqwbbky8Ah44oIbFo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <271C1D9A5246DB4EBB54129C55478FFF@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f88bbd-5fcb-482c-da12-08dc8fb53fc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 16:39:40.1210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x+sByVTQDTF3PpkWsgyG6TBWOM7EvjJVGOpQwsT+W+zfMmt5w/aLaIrfyDfRMyp5Q9z1zk8ZeRWFMEL8yME+TKddY9InZNk495qFkxAI5q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10096
X-Proofpoint-GUID: 3XcxeJoXgUBUOGlwG1wk-vLj4qkC_kvG
X-Proofpoint-ORIG-GUID: 3XcxeJoXgUBUOGlwG1wk-vLj4qkC_kvG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gSnVuIDE4LCAyMDI0LCBhdCAxMjoyMOKAr1BNLCBQcnplbWVrIEtpdHN6ZWwgPHBy
emVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gIS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+
IENBVVRJT046IEV4dGVybmFsIEVtYWlsDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+IE9uIDYv
MTgvMjQgMTg6MDEsIEpvbiBLb2hsZXIgd3JvdGU6DQo+PiBBZGQgLmdldF9jaGFubmVsIHRvIGVu
aWNfZXRodG9vbF9vcHMgdG8gZW5hYmxlIGJhc2ljIGV0aHRvb2wgLWwNCj4+IHN1cHBvcnQgdG8g
Z2V0IHRoZSBjdXJyZW50IGNoYW5uZWwgY29uZmlndXJhdGlvbi4NCj4+IE5vdGUgdGhhdCB0aGUg
ZHJpdmVyIGRvZXMgbm90IHN1cHBvcnQgZHluYW1pY2FsbHkgY2hhbmdpbmcgcXVldWUNCj4+IGNv
bmZpZ3VyYXRpb24sIHNvIC5zZXRfY2hhbm5lbCBpcyBpbnRlbnRpb25hbGx5IHVudXNlZC4gSW5z
dGVhZCwgdXNlcnMNCj4+IHNob3VsZCB1c2UgQ2lzY28ncyBoYXJkd2FyZSBtYW5hZ2VtZW50IHRv
b2xzIChVQ1NNL0lNQykgdG8gbW9kaWZ5DQo+PiB2aXJ0dWFsIGludGVyZmFjZSBjYXJkIGNvbmZp
Z3VyYXRpb24gb3V0IG9mIGJhbmQuDQo+PiBTaWduZWQtb2ZmLWJ5OiBKb24gS29obGVyIDxqb25A
bnV0YW5peC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9jaXNjby9lbmlj
L2VuaWNfZXRodG9vbC5jIHwgMTggKysrKysrKysrKysrKysrKysrDQo+PiAgMSBmaWxlIGNoYW5n
ZWQsIDE4IGluc2VydGlvbnMoKykNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9jaXNjby9lbmljL2VuaWNfZXRodG9vbC5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvY2lzY28v
ZW5pYy9lbmljX2V0aHRvb2wuYw0KPj4gaW5kZXggMjQxOTA2Njk3MDE5Li5lZmJjMDcxNWIxMGUg
MTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9jaXNjby9lbmljL2VuaWNfZXRo
dG9vbC5jDQo+PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9jaXNjby9lbmljL2VuaWNfZXRo
dG9vbC5jDQo+PiBAQCAtNjA4LDYgKzYwOCwyMyBAQCBzdGF0aWMgaW50IGVuaWNfZ2V0X3RzX2lu
Zm8oc3RydWN0IG5ldF9kZXZpY2UgKm5ldGRldiwNCj4+ICAgcmV0dXJuIDA7DQo+PiAgfQ0KPj4g
ICtzdGF0aWMgdm9pZCBlbmljX2dldF9jaGFubmVscyhzdHJ1Y3QgbmV0X2RldmljZSAqbmV0ZGV2
LA0KPj4gKyAgICAgIHN0cnVjdCBldGh0b29sX2NoYW5uZWxzICpjaGFubmVscykNCj4+ICt7DQo+
PiArIHN0cnVjdCBlbmljICplbmljID0gbmV0ZGV2X3ByaXYobmV0ZGV2KTsNCj4+ICsNCj4+ICsg
Y2hhbm5lbHMtPm1heF9yeCA9IEVOSUNfUlFfTUFYOw0KPj4gKyBjaGFubmVscy0+bWF4X3R4ID0g
RU5JQ19XUV9NQVg7DQo+PiArIGNoYW5uZWxzLT5yeF9jb3VudCA9IGVuaWMtPnJxX2NvdW50Ow0K
Pj4gKyBjaGFubmVscy0+dHhfY291bnQgPSBlbmljLT53cV9jb3VudDsNCj4+ICsNCj4+ICsgLyog
ZW5pYyBkb2Vzbid0IHVzZSBvdGhlciBjaGFubmVscyBvciBjb21iaW5lZCBjaGFubmVscyAqLw0K
Pj4gKyBjaGFubmVscy0+Y29tYmluZWRfY291bnQgPSAwOw0KPiANCj4gbXkgdW5kZXJzdGFuZGlu
ZyBpcyB0aGF0IGVmZmVjdGl2ZSBSeCBjb3VudCBpcyBjb21iaW5lZF9jb3VudCtyeF9jb3VudCwN
Cj4gYW5hbG9nb3VzIGZvciBUeA0KDQpUaGFua3MgZm9yIHRoZSBxdWljayByZXZpZXchDQoNCkxv
b2tpbmcgdGhyb3VnaCBob3cgb3RoZXIgZHJpdmVycyBkbyB0aGlzLCBJIGRpZG7igJl0IGdldCBh
IHNlbnNlIHRoYXQNCmFueSBvdGhlciBkcml2ZXJzIHdlcmUgc3RhY2tpbmcgcnhfY291bnQgKyBj
b21iaW5lZF9jb3VudCB0b2dldGhlci4NCg0KQWxzbywgZW5pYyBhbmQgdGhlIHVuZGVybHlpbmcg
Q2lzY28gVklDIGhhcmR3YXJlIGFwcGVhcnMgdG8gYmUgDQpmYWlybHkgc3BlY2lmaWMgdGhhdCB0
aGUgcXVldWVzIHRoZXkgcHJvdmlzaW9uIGF0IHRoZSBoYXJkd2FyZSBsZXZlbCBhcmUNCmVpdGhl
ciBSWCBvciBUWCBhbmQgbm90IGEgdW5pZmllZCByaW5nIG9yIHNvbWV0aGluZyB0byB0aGF0IGVm
ZmVjdC4NCg0KSSB0b29rIHRoYXQgdG8gbWVhbiB0aGF0IHdlIHdvdWxkIG5ldmVyIGNhbGwgYW55
dGhpbmcg4oCYY29tYmluZWTigJkgaW4NCnRoZSBjb250ZXh0IG9mIHRoaXMgZHJpdmVyLg0KDQo+
IA0KPiBhbmQ6DQo+IHVhcGkvbGludXgvZXRodG9vbC5oOjU0NzogKiBAY29tYmluZWRfY291bnQ6
IFZhbGlkIHZhbHVlcyBhcmUgaW4gdGhlIHJhbmdlIDEgdG8gdGhlIG1heF9jb21iaW5lZC4NCg0K
SSBzYXcgdGhhdCwgdGhvdWdoIEkgZGlkIHNlZSBhIGZldyBvdGhlciBkcml2ZXJzIHRoYXQgYWxz
byBkbyBjb21iaW5lZF9jb3VudCA9IDANCmJyb2FkY29tL2JueDIsIGdvb2dsZS9ndmUsIGlibS9p
Ym12bmljLCBhbmQgdGkvY3Bzdw0KDQpJIGFsc28gZGlkbuKAmXQgc2VlIGFueW9uZSBzcGVjaWZp
Y2FsbHkgc2V0dGluZyBpdCB0byAxIHRvIGNvbXBseSB3aXRoIHRoZSB1YXBpIGhlYWRlcg0KeW91
IHBvaW50ZWQgdG8uDQoNCkkgZGlkIGNoZWNrIG5ldC9ldGh0b29sL2NoYW5uZWxzLmMgLT4gY2hh
bm5lbHNfZmlsbF9yZXBseSBhbmQgdGhlcmUgaXMgbm90DQphbnkgaGFuZGxpbmcgdGhlcmUsIG9y
IGFueXdoZXJlIGVsc2UgaW4gY2hhbm5lbHMuYyB0aGF0IHdvdWxkIHByZXZlbnQgdGhlDQp1c2Fn
ZSBvZiBjb21iaW5lZF9jb3VudCA9IDAuDQoNCldpdGggdGhpcyBwYXRjaCwgSSBzZWUgdGhlIGZv
bGxvd2luZyBldGh0b29sIG91dHB1dCB3aGVuIGhhcmR3YXJlIFJYL1RYIGFyZSBib3RoDQpzZXQg
dG8gMQ0KDQojIGV0aHRvb2wgLWwgZXRoMA0KQ2hhbm5lbCBwYXJhbWV0ZXJzIGZvciBldGgwOg0K
UHJlLXNldCBtYXhpbXVtczoNClJYOiA4DQpUWDogOA0KT3RoZXI6IG4vYQ0KQ29tYmluZWQ6IG4v
YQ0KQ3VycmVudCBoYXJkd2FyZSBzZXR0aW5nczoNClJYOiAxDQpUWDogMQ0KT3RoZXI6IG4vYQ0K
Q29tYmluZWQ6IG4vYQ0KDQojIGRtZXNnfGdyZXAgLWkgZW5pYw0KWyA4LjI5NjEyN10gZW5pYyAw
MDAwOjM1OjAwLjA6IHZOSUMgTUFDIGFkZHIgMDA6MjU6YjU6MDA6ODg6MGUgd3EvcnEgMjU2LzUx
MiBtdHUgMTUwMA0KWyA4LjI5NjEzMV0gZW5pYyAwMDAwOjM1OjAwLjA6IHZOSUMgY3N1bSB0eC9y
eCB5ZXMveWVzIHRzby9scm8geWVzL3llcyByc3Mgbm8gaW50ciBtb2RlIGFueSB0eXBlIG1pbiB0
aW1lciAxMjUgdXNlYyBsb29wYmFjayB0YWcgMHgwMDAwDQpbIDguMjk2MTM0XSBlbmljIDAwMDA6
MzU6MDAuMDogdk5JQyByZXNvdXJjZXMgYXZhaWw6IHdxIDEgcnEgMSBjcSAyIGludHIgNA0KWyA4
LjI5NjI5OV0gZW5pYyAwMDAwOjM1OjAwLjA6IHZOSUMgcmVzb3VyY2VzIHVzZWQ6IHdxIDEgcnEg
MSBjcSAyIGludHIgNCBpbnRyIG1vZGUgTVNJLVgNClsgOC4zMDA0NTNdIGVuaWMgMDAwMDozNTow
MC4xOiB2TklDIE1BQyBhZGRyIDAwOjI1OmI1OjAwOjg4OjFlIHdxL3JxIDI1Ni81MTIgbXR1IDE1
MDANClsgOC4zMDA0NTZdIGVuaWMgMDAwMDozNTowMC4xOiB2TklDIGNzdW0gdHgvcnggeWVzL3ll
cyB0c28vbHJvIHllcy95ZXMgcnNzIG5vIGludHIgbW9kZSBhbnkgdHlwZSBtaW4gdGltZXIgMTI1
IHVzZWMgbG9vcGJhY2sgdGFnIDB4MDAwMA0KWyA4LjMwMDQ1N10gZW5pYyAwMDAwOjM1OjAwLjE6
IHZOSUMgcmVzb3VyY2VzIGF2YWlsOiB3cSAxIHJxIDEgY3EgMiBpbnRyIDQNClsgOC4zMDE0NDRd
IGVuaWMgMDAwMDozNTowMC4xOiB2TklDIHJlc291cmNlcyB1c2VkOiB3cSAxIHJxIDEgY3EgMiBp
bnRyIDQgaW50ciBtb2RlIE1TSS1YDQpbIDguMzE4Njk5XSBlbmljIDAwMDA6MzU6MDAuMCBldGgw
OiByZW5hbWVkIGZyb20gYWh2MA0KWyA4LjM1OTI1Nl0gZW5pYyAwMDAwOjM1OjAwLjEgZXRoMTog
cmVuYW1lZCBmcm9tIGFodjENClsgMTUuMTc3NjU1XSBlbmljIDAwMDA6MzU6MDAuMCBldGgwOiBM
aW5rIFVQDQpbIDE1LjE5Mjk3MV0gZW5pYyAwMDAwOjM1OjAwLjEgZXRoMTogTGluayBVUA0KDQpU
aGFua3MgYWdhaW4sDQpKb24NCg0KPiANCj4+ICsgY2hhbm5lbHMtPm1heF9jb21iaW5lZCA9IDA7
DQo+PiArIGNoYW5uZWxzLT5tYXhfb3RoZXIgPSAwOw0KPj4gKyBjaGFubmVscy0+b3RoZXJfY291
bnQgPSAwOw0KPj4gK30NCj4+ICsNCj4+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGV0aHRvb2xfb3Bz
IGVuaWNfZXRodG9vbF9vcHMgPSB7DQo+PiAgIC5zdXBwb3J0ZWRfY29hbGVzY2VfcGFyYW1zID0g
RVRIVE9PTF9DT0FMRVNDRV9VU0VDUyB8DQo+PiAgICAgICBFVEhUT09MX0NPQUxFU0NFX1VTRV9B
REFQVElWRV9SWCB8DQo+PiBAQCAtNjMyLDYgKzY0OSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
ZXRodG9vbF9vcHMgZW5pY19ldGh0b29sX29wcyA9IHsNCj4+ICAgLnNldF9yeGZoID0gZW5pY19z
ZXRfcnhmaCwNCj4+ICAgLmdldF9saW5rX2tzZXR0aW5ncyA9IGVuaWNfZ2V0X2tzZXR0aW5ncywN
Cj4+ICAgLmdldF90c19pbmZvID0gZW5pY19nZXRfdHNfaW5mbywNCj4+ICsgLmdldF9jaGFubmVs
cyA9IGVuaWNfZ2V0X2NoYW5uZWxzLA0KPj4gIH07DQo+PiAgICB2b2lkIGVuaWNfc2V0X2V0aHRv
b2xfb3BzKHN0cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYpDQo+IA0KDQo=

