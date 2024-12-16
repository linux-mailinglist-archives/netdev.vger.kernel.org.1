Return-Path: <netdev+bounces-152353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3DC9F3901
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 19:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8877C1883CD5
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89C920767D;
	Mon, 16 Dec 2024 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="M7HTB8jx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5458A206F13;
	Mon, 16 Dec 2024 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734373885; cv=fail; b=hqbUW/1ccMECfgt9+VPSdcEiWqUQ6W8ofaPICZG5cpnbUn2Nr50LsIg8t049h4K9HfeRY0S1z6LrsT2DazDR4OEl6/jAVqkSmLGXTjKQ07naNj7umNARou/r7vqz9tnc4P/fv7gMMim17jUA3ZJbADRAiqPnLp77kNrU09XurQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734373885; c=relaxed/simple;
	bh=ztOLIsbiF6yNmra5nLWmo16bkTs5S7kggY27HHzI5zQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kaD6tszKOSgeoVtT33B/IwsUsID0gP0VXstxK/NxFYKOGafgKIjIV/4OXdtG4btgBI+fAtgHAVP/asfvMpG8N2O7SkkhoDQrFeiScgys8faB091+XtJR0MwRq6G3RtGtlp8p3tf+rSTj4lvnGq28WKmZu3hPhYQSPcKpj/6Bb2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=M7HTB8jx; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGFwt7t031030;
	Mon, 16 Dec 2024 10:31:10 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43jqau0apw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 10:31:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=notDYVIz7/u0X/Sod/TzonyAcBFbsX3gb9XhO7a3+av4gCVkfPaGAyys/m+BYCEIXb7OCLo+XVt2qYXzDjj6qHIZzDY4b9+IceSd80sGSG8CDPzacxjqXH7/Eu0svCZJhVv9C0mbBiTwPhlwKu6rci6XvT4eI0x3sgrHJfr1Jvh6ZIGjkz44iaPpD54PV/P0/7AkHBkEq3rGZ/fGT/ANMLvFE388nqpS2WqRhaAwQkDylmcnLm07y9LdL10Tf9A6AsXLJH6RJ9C6cHVwx0OEsWZPwqIU4ZMWLcGIbbpQT1r93g1eiNMbt/aTxlzCiSF/1H5IjtPgXcmeVX3H1EIcSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztOLIsbiF6yNmra5nLWmo16bkTs5S7kggY27HHzI5zQ=;
 b=MccWJU12TUKa8QewL+tczEx0sX2xpbRGR7P17ye4Iv6u7Gok6xyI8c1pQ5JdRc/OKlO+SmlkkzU0TebxqYzZUXc+T+xDmrfvfeefiN2up6oneEwJKcy8DyBKTcVKAoBB4A/7IVGnq+T5uQoGFKkUwz1j+Y0LF3yeDAx4ygBUByfCqKKHgoyCnUhPDBi1l7e/vTuOgj+k7L8LE0BCPymVTQaJ+90In5pePQMVPYduXa8quT6wgKtth8cV56I5AOoAHmcAJA7bd9ymUUTzg0uZl3V7xh94SJQZWwXAGwm67klvBQON2AbQA5b4tVG1a/KrXefxQF8TN2jKtm6VzZ7ukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztOLIsbiF6yNmra5nLWmo16bkTs5S7kggY27HHzI5zQ=;
 b=M7HTB8jxYX0Dfq7fjVHP2oCuDvKMSUnZkAlnTP6a9YsIPYHXigWGltWILTKo4JGKC6jsEy1WTLJat/GjS3X2DFDckby4uFYQ+K6RO8RR4wpvvSdNeKqopp3MQMjRHZU4/bQZ3EfuqOO9FT4jcPomfiycDwHRRhiOg0pF1KF0454=
Received: from BY3PR18MB4721.namprd18.prod.outlook.com (2603:10b6:a03:3c8::14)
 by BN9PR18MB4329.namprd18.prod.outlook.com (2603:10b6:408:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 18:31:05 +0000
Received: from BY3PR18MB4721.namprd18.prod.outlook.com
 ([fe80::dfc:5b62:8f30:84db]) by BY3PR18MB4721.namprd18.prod.outlook.com
 ([fe80::dfc:5b62:8f30:84db%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 18:31:05 +0000
From: Shinas Rasheed <srasheed@marvell.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani
	<hgani@marvell.com>, Sathesh B Edara <sedara@marvell.com>,
        Vimlesh Kumar
	<vimleshk@marvell.com>,
        "thaller@redhat.com" <thaller@redhat.com>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "kheib@redhat.com"
	<kheib@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "einstein.xue@synaxg.com"
	<einstein.xue@synaxg.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew
 Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Satananda Burla <sburla@marvell.com>,
        Abhijit Ayarekar
	<aayarekar@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH net v2 2/4] octeon_ep: remove firmware
 stats fetch in ndo_get_stats64
Thread-Topic: [EXTERNAL] Re: [PATCH net v2 2/4] octeon_ep: remove firmware
 stats fetch in ndo_get_stats64
Thread-Index: AQHbT5BbLTFKg7qCGEezo9Uzl3uELLLo8eqAgAA3iBA=
Date: Mon, 16 Dec 2024 18:31:05 +0000
Message-ID:
 <BY3PR18MB4721878201E1B93AFB29367EC73B2@BY3PR18MB4721.namprd18.prod.outlook.com>
References: <20241216075842.2394606-1-srasheed@marvell.com>
 <20241216075842.2394606-3-srasheed@marvell.com>
 <Z2A7+7dzyNDAgsmj@lzaremba-mobl.ger.corp.intel.com>
In-Reply-To: <Z2A7+7dzyNDAgsmj@lzaremba-mobl.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4721:EE_|BN9PR18MB4329:EE_
x-ms-office365-filtering-correlation-id: 8770b1b4-9090-4ee9-54c5-08dd1dffcd86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U1ZTUUwzVkdxK00xeEFqdjhTY3YwMHpKWm9pMjA4dGp2enJKK25ucEMxR2FH?=
 =?utf-8?B?bmZBOE44bTlVSzVGdFcrT2haWEhTVWxzMGVMNUJORHRkZDJENERnNU5RYXls?=
 =?utf-8?B?NU5DRVkzUXFWY0xhVUdmRnhwa0ZaaGYxTGZ6L1NhME8vWG8xejdjeUQwdC92?=
 =?utf-8?B?UDZmcC9pbzF3MS9Vb09hTXdMT2xzdGpQMEZHMFFUVDhtQXF2TEMvOTd3Sm5r?=
 =?utf-8?B?eGhXeEVCZEl4bmI1QUNQemg2TVo0VDdLNnY4b2dNSEFVRkU0dmdRSko4Y0pt?=
 =?utf-8?B?MmI1VDhlTkZITnpIVlJzYlRJd3V1QklYTnJrM0ZReldHUmN0eEhZTFJ1ZXRU?=
 =?utf-8?B?Mml3c2JNeXJlSDZ6K3dUeFllR1daWENSSE0zK04yUkc4dWE1NythREY5VjJv?=
 =?utf-8?B?MVE3UW9Xd2VRdlpKRlJ1ZjF6clVCNnhJWEo4dXp4ZDYvbXhncmV0VVFpTmlL?=
 =?utf-8?B?TUs0RUhxQmJqT3RpWU9qWTgzbmZOVnI5NDM5dnpNRnh6RTRvdG9oMW9nU2sw?=
 =?utf-8?B?SkZaYTRidk9JWFpmSVdLYWtjMVh4aHhBU1lIRERSdm1tUzVmMGZrZDNnaURN?=
 =?utf-8?B?MXpDanpMK25iNmZRY05rSXlSWDI2Tk1kS1cwRWRab1VKUjZWY2NUQStTNVpQ?=
 =?utf-8?B?NGlta0I2Vkk4d0FzNTdtOUNxN3U0cjBVY2FYTjJNSzV5S0FvQ29sMXVLQ2hD?=
 =?utf-8?B?VDI1Ymx1UzJpa1hVaFlUeks5bEpLNUtKZUVMZjlQcncwc2lKbW5mK3BWblZp?=
 =?utf-8?B?alFqUTdFeVV6dnVNaEh3TEJtWjZoN2REUzFEU0JHSXp1QytUYXlnZGNwdElU?=
 =?utf-8?B?aW5kZmgzcTFiMmxBb3BQWkpJYzBHZW5iMXdsTFNyakJJU3dyTEZBQ21EbEln?=
 =?utf-8?B?RnJnLyt5aEh1dEZhNThMSFI1MWQyK09pUjdXWWlvaFZRYVFCMGhrZFBYL2JX?=
 =?utf-8?B?NVNKZ3g4QTYrQitxRTlpQndvV3R6ell3cGtRYXFZcGs4WE4wd0dmY28wcVBa?=
 =?utf-8?B?SElWemR0em5jNzgyS3NRL0c3Q2U2MlUwdng2SFVzb2xwNFRDaUhPQUl4WHJh?=
 =?utf-8?B?L1NHaDBHVTZYLzlNVm1TZkdVcmZuZ1YzRWt1WUVPM3BzTGd0SUllZk5MY1ZN?=
 =?utf-8?B?ZkEzL1dxNHNwNHVkcG1KZ2FlTUtlY252R3RQOUt3cy9sRXZWRTlURFNRU0Rz?=
 =?utf-8?B?aTdKbVZmQnFjMzVFOFJPTG1wWEoycXlmK2JUVWR5cFhOZS9wM1VjcnQwQlp0?=
 =?utf-8?B?SHFoQkpuUjhvVmVzRWNTYzFEdFF6ZU52bUZsSDdmUU1yWDd2QWtxNDdPd0x0?=
 =?utf-8?B?aVlzNDBpSkc0RmwzWUFDZU4yd2xab0V5bDhuVGxZTlZHVUFpME9lZFAzb2ph?=
 =?utf-8?B?Mk9zdUtoMmdMVXdPK29PYWdDbnUvYzFRMUREMi9nK2l0MkE1TFJSa09sTTdz?=
 =?utf-8?B?TGg4SVU0bXNGVGIvZnhDN2R3d01STVBNNVl6cVVoSm01L3o2TWk3dk5tbUds?=
 =?utf-8?B?QUQveVVUQ3JMY0twblFNcnBFbE9SWnU2YkxDa1hVUEdRaktXUDBIZlk2dXha?=
 =?utf-8?B?ZmZ0UGVOQ3JxRmN0ZjEzbEl4ZU9vd2FCend4WWdWSTBtdlRxcEIxWWlSR3FD?=
 =?utf-8?B?VGMvcG15MkdYMTUwcDd1cEgwSzJqMVVFUlNRbU9UUXlNakI2ZmwydUJJdmE1?=
 =?utf-8?B?dmdPVld1S3l1K3VGMm9YNUN6cEdwVzIzOXNmd0toWXFGUS9PRVN5OFNkMVdU?=
 =?utf-8?B?aGFoZmppS2hzUVlGYzBhMjhCYTlJTHdLVXB6VGx5cVNKOHk1N2tSbmx3SWZr?=
 =?utf-8?B?VENPQm5SaFp6eGE3ZnlsL1dTMkdLSmJ1dUk2QTlRcmVIM1lUeGV2cG53Q1FT?=
 =?utf-8?B?a2VRQmhBOVVIYzlpV3BHV01qTVpHU1gxcGpHaTFsTndlaWYzbERNMTZLODVB?=
 =?utf-8?Q?ZpBx3mpJRC/4PzGKD9rxuL44fM5Wj1pJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4721.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ellWT1BGcituaXNjb0lKUDcrZHFENUJOcFlhUGlHSkM4TXh1NkorQ3hkSHdQ?=
 =?utf-8?B?TG5WRjk2UTNxQUovenhJWnpaMjJqZ1hFODZvbSt2S0VCMTUxVDV4Y3I1MGQw?=
 =?utf-8?B?eDNFZk9lRDRYRkp4WHhHQnJsVEJFUG9wU21SS2JVbnl4Rzl4eXNHU3k4cWZz?=
 =?utf-8?B?VmxoSGszcmZVKzB3WmtUaSs3Z1JPZEFjNnZXY1pET3ZzcU0yUER1S3pCVUxv?=
 =?utf-8?B?UURaNC9nbTZKcEpybXBybTVWQVRMUlBlUW9SZHYvd3V3NDBQb2xUMEhORTVr?=
 =?utf-8?B?am5KRG9teFRNVFU5M0N6Q21KMU5vZTBHd0VUMUJBRkNJaW14TkhYUVRONk5O?=
 =?utf-8?B?ZkREN0J0T3RaOUw5MHNsdTRuKzUya3hMRVBsREJDbUQ2NzJOR2FlT041Z2Fw?=
 =?utf-8?B?MHpRTHFsUGlGb05odHdBazZyVVF1N0k2UUdaWEdZSld3UlZ5UElXV1kzbm5X?=
 =?utf-8?B?Ykp2alhsMWdLNTVNYTlYTHR2SE1hc3ZtSm9FNTVoRk9ncXBGSWtjZE1vWVRm?=
 =?utf-8?B?elRDT09najlETzRvT0cxbzVmcTRYR2pwM3VTSzVUOVJmOFFqNWEwMkE4REl5?=
 =?utf-8?B?MjcvblJMSm5nYkswRHUzdmMzVm5rYkdVZkxMeHY0NXo2dDJnWjJtSFI1VUJW?=
 =?utf-8?B?WEVwaVRsY1poWUdQZitVVTROS0hXNzhRNUVqS0ZCbExRZHZFTHZva1pXbHNW?=
 =?utf-8?B?ektuMWpDbXR3THBoZ3VPV0x0STRSNXErOHpQUFVqWGdQTTNYclhvQ0Fodll1?=
 =?utf-8?B?MlRQQi9HOUZwSUY5RG12NVlWMnBPMHNzSnMrRDRkdFhLamhwNVU5U0dXWDFu?=
 =?utf-8?B?SWxKSFF2ZWR4YmxwRHJPekxxdlFqNzBSc01iYTI5Z0dURDk5KzFQU2dNenZ1?=
 =?utf-8?B?bHgvVklkNWNWcXBBMTROUm5QOVVMSnFMR1krTGpXeUc3K3dwZDIwRm1xZ2sy?=
 =?utf-8?B?TEp1c1AxYWFnUDEvRi9yYXVXWW5ZQ3cyT1l6Y1VOYUQwN2g1TEFuOVpjSmNC?=
 =?utf-8?B?TnVxcFlEZ2Z1S2tzSXFCaXJ0ZGUxQVVrbnFyRlA4UXVpR2VrdlltZW1jKzYz?=
 =?utf-8?B?UjdYT3lLNlRwaWl1SmEvY3hJVTJqcGVUREZlUWFVR0szTFhJUFlVWmZ0STNx?=
 =?utf-8?B?RzJTM1ZmUm9BT0RuL2ZqbExYSUQvc3J6OGZFR1g2T0Y3dGRtMzNDSGxEMVMv?=
 =?utf-8?B?SGxCVktUSll5ekZNdUdySmlEdHdVOWJEKzhKR2NYNTBJWCt3T3ZLcForanZa?=
 =?utf-8?B?T01objJHVzkzck1zQ29Fd001aTBvdFg2NW1EdENNNml2SzFDUGdqT2Z3OHZ4?=
 =?utf-8?B?dE5Fc2RHbjRGS3k0Z1dGeThMcVhkeXNUc1BENEY5Slg2NXRyeUhtTTdPdnVP?=
 =?utf-8?B?MmU3VTYzbU91MldoZ3RMU2lrRWhqeVZiTmE2NFNWdzludXNYZHM3VnVUT0k1?=
 =?utf-8?B?WXpxam04cUJGL1JRc0NHM2pNNzVhUXhSZkc5N251aW9CZ05SaGpzK2JFVGZM?=
 =?utf-8?B?Y0hoNWREN3JvU0ZJVmEyRW5tT3NZNVRIVFVYNGJUSG5kMkM2aUxjQmlUTnZr?=
 =?utf-8?B?S2E0N2o1TEtucyttY1Byd3VrSkNiZTY5eG1ncjB0bzJUd2dFejc2T04ybFJm?=
 =?utf-8?B?a3lsNlBnWFpucHRTM2J0bGZMT0prelBkVlJpUUdYUHlsaWUzMEhUVGpXVE8z?=
 =?utf-8?B?VElGbnlWVk5Lcmw0bVlmeE50cnpZK0pUV0RsQlZVdHFaZnZFU0tBQnZSZnh2?=
 =?utf-8?B?aGwyM1Y0TC9lZXBPYiszKzlkZ0Frbmk3RHNrUkdoWWhsN2Vpb2E1U25lblBv?=
 =?utf-8?B?SWRWTHU5MUV4NjVwSzJVZUx5cjdzSjJzazNBQnNZTFF6N0RyUVJPb3NSb0JR?=
 =?utf-8?B?UmtPazJzdGEzdUgwUWU1S3hZSXR0MkpMSWJQUzR3WU9tb1RzNlYwU3M5cFNp?=
 =?utf-8?B?MUxhcGdzdmh1UkxIU1ZGRE1BU2x4ODhyN0g4ckdDcGhZaklWQmJQY3VweGZG?=
 =?utf-8?B?d0ZmeVNqc1hRYmJZaGFXNEFoRzBNNDYvQ25OQXFyS0xkVjdSbW5DbUMzVkVk?=
 =?utf-8?B?eUpqNUN6RE9pcmpXSGowRWlxa2tjQ1FVK1JidEJ5TVBZTUFYL2Z2L1lRS3c5?=
 =?utf-8?Q?EL/Sb0PQpvmygBiEAC9GalKAQ?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4721.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8770b1b4-9090-4ee9-54c5-08dd1dffcd86
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 18:31:05.7968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JHjHfzKxDr5e1S+LXCgPyST5rdL8pkOF0Y7ittfKtgHkyEYihUrfw0wYgJG8/6WvXHlk7IWp1Cs4F5yCvFzf+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4329
X-Proofpoint-GUID: ret1wdgef26_I9vk3KQ2mj_Zj2b68ma7
X-Proofpoint-ORIG-GUID: ret1wdgef26_I9vk3KQ2mj_Zj2b68ma7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

SGkgTGFyeXNhLA0KDQoNCj4gT24gU3VuLCBEZWMgMTUsIDIwMjQgYXQgMTE6NTg6NDBQTSAtMDgw
MCwgU2hpbmFzIFJhc2hlZWQgd3JvdGU6DQo+ID4gVGhlIHBlciBxdWV1ZSBzdGF0cyBhcmUgYXZh
aWxhYmxlIGFscmVhZHkgYW5kIGFyZSByZXRyaWV2ZWQNCj4gPiBmcm9tIHJlZ2lzdGVyIHJlYWRz
IGR1cmluZyBuZG9fZ2V0X3N0YXRzNjQuIFRoZSBmaXJtd2FyZSBzdGF0cw0KPiA+IGZldGNoIGNh
bGwgdGhhdCBoYXBwZW5zIGluIG5kb19nZXRfc3RhdHM2NCgpIGlzIGN1cnJlbnRseSBub3QNCj4g
PiByZXF1aXJlZA0KPiA+DQo+ID4gRml4ZXM6IDZhNjEwYTQ2YmFkMSAoIm9jdGVvbl9lcDogYWRk
IHN1cHBvcnQgZm9yIG5kbyBvcHMiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoaW5hcyBSYXNoZWVk
IDxzcmFzaGVlZEBtYXJ2ZWxsLmNvbT4NCj4gPiBAQCAtMTAxOSwxMCArMTAxMyw2IEBAIHN0YXRp
YyB2b2lkIG9jdGVwX2dldF9zdGF0czY0KHN0cnVjdCBuZXRfZGV2aWNlDQo+ICpuZXRkZXYsDQo+
ID4gIAlzdGF0cy0+dHhfYnl0ZXMgPSB0eF9ieXRlczsNCj4gPiAgCXN0YXRzLT5yeF9wYWNrZXRz
ID0gcnhfcGFja2V0czsNCj4gPiAgCXN0YXRzLT5yeF9ieXRlcyA9IHJ4X2J5dGVzOw0KPiA+IC0J
c3RhdHMtPm11bHRpY2FzdCA9IG9jdC0+aWZhY2Vfcnhfc3RhdHMubWNhc3RfcGt0czsNCj4gPiAt
CXN0YXRzLT5yeF9lcnJvcnMgPSBvY3QtPmlmYWNlX3J4X3N0YXRzLmVycl9wa3RzOw0KPiA+IC0J
c3RhdHMtPmNvbGxpc2lvbnMgPSBvY3QtPmlmYWNlX3R4X3N0YXRzLnhzY29sOw0KPiA+IC0Jc3Rh
dHMtPnR4X2ZpZm9fZXJyb3JzID0gb2N0LT5pZmFjZV90eF9zdGF0cy51bmRmbHc7DQo+IA0KPiBJ
IGRvIG5vdCBzZWUsIGhvdyBpdCBpcyBhIGZpeCB0byByZW1vdmUgc29tZSBmaWVsZHMgZnJvbSBz
dGF0cy4gSWYgdGhpcyBpcyBhDQo+IGNsZWFudXAsIGl0IHNob3VsZCBub3QgZ28gdG8gdGhlIHN0
YWJsZSB0cmVlLg0KPiANCj4gPiAgfQ0KPiA+DQoNClRoZSBmaXggcGFydCBvZiB0aGlzIHBhdGNo
IGlzIHRvIHJlbW92ZSB0aGUgY2FsbCB0byBmaXJtd2FyZSB0byByZXRyaWV2ZSBzdGF0cywgd2hp
Y2ggY291bGQgYmxvY2sgYW5kIGNhdXNlIHJjdSByZWFkIGxvY2sgd2FybmluZ3MuDQpUaGUgZmll
bGRzIHRoYXQgYXJlIHJldHJpZXZlZCBieSB0aGlzIHN0YXRzIGNhbGwgY2FuIGJlIG5lZ2xlY3Rl
ZCBmb3IgdXNlIGNhc2VzIGNvbmNlcm5pbmcgdGhlIERQVSwgYW5kIHRoZSBuZWNlc3Nhcnkgc3Rh
dHMgYXJlIGFscmVhZHkNCnJlYWQgZnJvbSBwZXIgcXVldWUgaGFyZHdhcmUgc3RhdHMgcmVnaXN0
ZXJzLiBIZW5jZSwgd2h5IHRoZSBjb2RlIGlzIHJlbW92ZWQuDQoNCg==

