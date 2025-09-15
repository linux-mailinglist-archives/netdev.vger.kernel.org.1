Return-Path: <netdev+bounces-223181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8FCB58250
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 18:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D653B7F74
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CC6279359;
	Mon, 15 Sep 2025 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="fEa+/nxA";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="hVJJhbPv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBDF278E67;
	Mon, 15 Sep 2025 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954357; cv=fail; b=tEE2+9GWavaxElE9rDHNgTSiQjI9BL+tb4Yj/50ILX06DZEAbU9Rn+m2uJPD7xaSfYq4ejeJ+dIvXG/Jq/puCXWe7IjkbEmQARYr8s6gpAXp41ZjV7yE15hqRRvB0r0x00p5qdtoKnpbRR9EuZrdQ09cp88RrX5sKI60vcr9II8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954357; c=relaxed/simple;
	bh=Hq2949qZoK3AdS0Bca4Rk/GaV/myzXqNXV/ineV+wYM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mntzVFUpV4ydn5HbgMPB+KPYzpoEe70Rr52vw1Dhj/1sG5YMbFVAIBM0M6U2e9CPOuit1mYc5878MyS09eU4wIsl892fgILxa759+VB0Sf2FtRvd6VfJzI0VNJs+cxuCAuLJTOlWNyGdup9j6lrNSnhu829QnEgm3YBtppUND00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=fEa+/nxA; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=hVJJhbPv; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58FGSkuu3137653;
	Mon, 15 Sep 2025 09:39:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=Hq2949qZoK3AdS0Bca4Rk/GaV/myzXqNXV/ineV+w
	YM=; b=fEa+/nxA4ZnJ1ifEZ5NR+MwE7EM3fDtknxxetSX9yInRHOU6qlSi8O2Xb
	Qx65he5mp1fQZF2sRX+/UDR9yauAxKSDod0BlqVPSmgEfU5RtGyFg1qEoMDZrQng
	MuT+c+1RNlLHIoLJyRury4KgQ/ga61ZaCgHFZidU4p9/Rn1kXpo+JYqO5r/3VdUd
	te+vKNJc7zgK6s7ZkVdvnvfkSDN6QMtAteCVrSz73LLU5vb7e+9dYtdkh1vFlGu5
	WqbAIeq3vCCuvkQDW5w5bYqF6lHpSkfaC1YCKURH4U5qeiFJFiIrO/xX/UtHMkfK
	65OEom2XCjuz/W8a2S7ejWgGOz2oQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020088.outbound.protection.outlook.com [52.101.46.88])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 496pby00rh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 09:39:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNVo+2skAgstFKZCxqZS+n195zRsNdJcntwJtnPuZRQAWdo7tU9CPQ/fJxavDjEfIwJQAju93TaTSRFmRfUX11KD6WDj83o6OvLjs8vOU1mIJB8O5zufLzaYmCP9kXnCShVRVvSr82OU+Ib/Fqx8ChBRSAIs2n9dPht7ZMJyh37exZxReTsetjVCJ3Q9lCyHfQJqeQ6yT+pRVsXLJbJKT+PVQWji9Eh8jdV9JFV+/U+nM3pzP8DXSUr9DGyrX32jKtvK9jCQgbh8RnZl1kj1vIhoh6Ia6iakreLorGe+/D2g2PUUuMgDLDntxvQx4C2q0nxZdGbYeXPvfV9xjPXjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hq2949qZoK3AdS0Bca4Rk/GaV/myzXqNXV/ineV+wYM=;
 b=hGwqQEeDZEtMY207g6+NpmqpH3S+2KUkGs6+wvuzPhyY0CW1IeuYAKBU9GIPY+EaEyBKOCrYyGLyojQeE4hsUo/R0xW5hRB6Nnzpz1IcyIA7Xfzbw+xbsFD5B0mopNkwBG4eXTYIZxSNGCCHnsi+qZ84BxWAuY5oAGqpB+jsXk7uJ2UtxPEbwxEzz/7N1Sh69bTdbZ3P8Hqml5L0kQX4otxE0f+cd+dRfeP6MAfkfBDhcIosBHp7XsDa6F+HWJWtwLM9wKM4UKgajarHClIMLcI5HvI8tNxPphmLj3fBjf4TD3jFjl6q0ZABWU2zrt9HtsTAH39qkpmQ97++tV38Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hq2949qZoK3AdS0Bca4Rk/GaV/myzXqNXV/ineV+wYM=;
 b=hVJJhbPvTXs8TBl35CJ410O+eBXbnB3YW+V+bTit/oqJVJcAvSGzMMHetjDSXYY6pmSnOdM7NyY+V0QnDVYuI9gP/MDBDsyJiXJwho+kw6MdcjIociQfXYwBJzrWOlth5wbcg4VE7TGhejt+9Ny6mzkEz1utodenND7f68jx2OQGbKb7GEwkajdkwE1ieFPC8D70Frg1tGgwXpPOD3mwEF+GD2+axFLVei2M638emhl4u5d4MBj9VKiQcjKr3rP1Ax4iKZa72vOqlNAtO7RTBkhvrQjThAyO+s74G9hhAUzPbkz1aqj41LCpDHmD21mARnZcpazFXsJkzMu9mEfB2g==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by CH3PR02MB10341.namprd02.prod.outlook.com
 (2603:10b6:610:20b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 16:39:01 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 16:39:01 +0000
From: Jon Kohler <jon@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] vhost-net regression fixes
Thread-Topic: [PATCH v3 0/3] vhost-net regression fixes
Thread-Index: AQHcJlpH+72B5t9A2UO+1bdDW1Km9rSUcbqA
Date: Mon, 15 Sep 2025 16:39:01 +0000
Message-ID: <A8EB32B8-1AF2-45AA-87A9-4068E405B284@nutanix.com>
References: <cover.1757951612.git.mst@redhat.com>
In-Reply-To: <cover.1757951612.git.mst@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|CH3PR02MB10341:EE_
x-ms-office365-filtering-correlation-id: f28cfe42-5efa-400f-370f-08ddf4766045
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TENZUm5PWWVtRE9BZGwyUlZ5amZ6cS9uRFpQQW5sd0xCREs5MnhOVmMxVzJ2?=
 =?utf-8?B?V0hRNDlkQ29KWkl2QjJzZS9MTHFadWpHd2pldUdzbG5zMUxDT0xjZUU3cXBW?=
 =?utf-8?B?TGJVVHJ2VmlnaFQrdUhWZ2t1c2hGTzZYcVQ3blVKc3FVT2VKNEdJdklNeVdK?=
 =?utf-8?B?YzZHcWJkcTh4RzBRNTZxN0hhcy9RVVNydzNyNlFpcmp2S3EraW1xcE5FVkJv?=
 =?utf-8?B?YUVSZzAzbGZrNHZtTDE4ZVM1MDYzRWZ4MExLd1BLRm8ySUdoeWlldDdHVnpT?=
 =?utf-8?B?aDRQQkNOQWRLb1dlWUZncXVXYVpmMm5SRkFRUDExbmZBUnNaNWdJWE5CYllO?=
 =?utf-8?B?TmYreVNXTUF3R0F0UXhBRDZENTJ6YVdXQkF6aUt2UkZHcEZ2SVArRmp3MzlK?=
 =?utf-8?B?QTFvUWtQUGFaeDhKRHMzUU1JSTJvYkdlZ29aQ2N3SnJhU1RJV2pCVnVJVlRZ?=
 =?utf-8?B?OS90cjdwUUhUTWx4TDlhZU5iM05qYTlBY096Q2FaSExDZ1htWWxIZjMrU0RF?=
 =?utf-8?B?SW5kL3JKcnIzak1iS1lmaXc0S1lJc0NuWjZYSkZPUmVLZkFRQnJzQWEyZmhH?=
 =?utf-8?B?OFVIMkpIdGxyakJiTEVkWGx0K25NZGlNR3JxSlNYNHFTMWEzMUR4NmdFTHAx?=
 =?utf-8?B?NDZwcjZYL1NGTlBudk1uTFN3R2NRVjlIckxGaXdxVVFtTDZmamtwUlFpaXhj?=
 =?utf-8?B?QURxSTk1RHlXZGVXOXlPSXdNTDI0ekxMdzVGYjdmRnVZbkp3RDZ4anM4Z3Uv?=
 =?utf-8?B?eVFSc2xCVnpKN203T25TcnY3YmVUcVRKVVAxQnJTL29PTkFMTThodlh5UVY2?=
 =?utf-8?B?aHJGYUtzbHV3Tk9hTXA3N3d0RHpvYkdJS05KWjNwMVV1NThaMkh4SWY5V1RS?=
 =?utf-8?B?NldzQWdRbzlBZ3R5U2Z6QmlrcGhNaFdLMlFHUTd4WEM5aHIxamNEQy8yMmdQ?=
 =?utf-8?B?N0QrUE1vTHcrZXFKVVlpRTFiVHNtUWVKb3NPb2RXT0svYzlxNS9YaE1qbCtn?=
 =?utf-8?B?bURhWDlqQ3ZnMnNQa2lFZ29SK1VSSXIxV2JaYnBNM0V2U0JKUTl1bU9raHB4?=
 =?utf-8?B?TXNIT1g3bjZZNlc1aktFVnYzVGI3R05sTVZDSTFlMzBNRVJWQTlacXU4WGZQ?=
 =?utf-8?B?OC9yd0tMajY5SHJDdEwxN3p0bjBkMUZRdWNjOXlndU03OTA0dlFNRGlDQm5N?=
 =?utf-8?B?emRiQ1hsNGFDZ0twenh0OHJzQWxRdzhXbkk1K0gwd3IxckZQRnBhL0tCVGlT?=
 =?utf-8?B?ZDN6bkFld3NyUkI4QkVzY0dVRDZhNUpOS1hXZEFkZnpIUUhLaDBuZEE2NTdV?=
 =?utf-8?B?dlRkKzIzUk5XaThRWHJacy9mcG1NYlJBVVFUWkEzRXJmbGFJc3VUZUY3QmtO?=
 =?utf-8?B?VEtQV3NTUUYvWm11YytoT2lvVnZBY1AxNU5aQjg3RU1CazV1UmM0c1Zjbk1h?=
 =?utf-8?B?cmJOK05qUmpMU3lBN2w4UzY4d2pJaWpFb2d3eEtabU5yN1BIRlF6UkxjYW10?=
 =?utf-8?B?TjJpTkljK3o3bFlGVHJJNDVsUjF2M1YyVmhOMXVRVUtKbkQ4eUZXSStuVy9z?=
 =?utf-8?B?NWJ6azhaMmU1VDEyTkI3Zy80aG9IVW1pRnBua3JtSkZxVlBxOCthQXUydm5w?=
 =?utf-8?B?SFc2ZjJhZzF3NHRMTnAxZ240WmFWSXpMTVNUTGtyV2N6eVlpTDJXNlhKRkdI?=
 =?utf-8?B?YVZFV2h4NUxzWkZSNjZ6bWdtRjBYVGd4MWVVbVkrUXFVTjIxWHlycGMrSk1n?=
 =?utf-8?B?ZzUrdTRIbXJ3dE1XQVA5QmhNbTcwNVZ0cHF6eFlRN3ZnT2srNisyUUFWK1hs?=
 =?utf-8?B?bURUU3k1cTM3Vzd3YVg1M1lLRmVJRDRGN3hFMmZCRmxBcHNoNE9OZEFlQTFS?=
 =?utf-8?B?OFNwOEVpK21LTHUwRnBBaXQ1b0xrMWJTWmZvQU9uY0g4ZkZBaWlISEpjSVhh?=
 =?utf-8?B?SmxYd1BCSjZSZWYzWEQwcnNXWU1UdDY4NnZzb3RTbnhDTEw0T1N6aDY0d1ds?=
 =?utf-8?B?cFVlVkxnNEFnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d2ZTbGE0bXdMTDhDRzc1TGlxWGdDWnlnTzZmbVBnRHo0b3NQajNHUkVsdnpt?=
 =?utf-8?B?WFJaZTE0VEJ1WXNFejJqSCtpbjhaMHFqZzgwc1R5c3QvdC9nd1lWVld5RDl0?=
 =?utf-8?B?MmlMMlo3a0sxa2g0dEFUczA4cytIZGJzMUlBWTYwWWwrcTZUTEN3N0JaTDd6?=
 =?utf-8?B?MjJINXdpbzAvMk1kZ0FKRTlTVGlxRkFEalJsMDBtS21yM05nQmFpWHNpcnJ0?=
 =?utf-8?B?YWVzeEJkakhHUGlVdmVTNWJqSU5VbDBZb2JVT3lUYUxiQWV0SHJDMnJxb2tD?=
 =?utf-8?B?RVBseUFYSFJvR3h5cWQwWXZMdmU2MTZVdjIvbUY0Y2Z4YTljY0wzQ2gwU0Zi?=
 =?utf-8?B?bk1uS2I3ckJDWjdMM29RWUtGUTQ2NVMwMkk3S2IyTjFVY1ZMNGZGRUNGNmR6?=
 =?utf-8?B?bGFCWmVaN3JzUFp1bkU1aVh3VnJ4VHhtNENSdSt6bjRCYzJCWGtGV2Z2K3JF?=
 =?utf-8?B?MHY1ZjJmVnlMeHFlQk53SlBjNWlLSU5STE5pWXZkSTUvaFlzRHlhUzdYc0FD?=
 =?utf-8?B?UkhLMXRReXgwcUlKWUM4UnZGczI2eVJGTjJqcm8raXpCVkRMSEt3QlFWZFQy?=
 =?utf-8?B?OWE0VWI3cUdVR2I3azd6bjBnSjF2MzMvU2VUSlZVdUljT0lsRmE2VWhoektt?=
 =?utf-8?B?VTVPNHhvekdxczZLeTRwTXZKOVhsMlBwV0t4MEduekV6SERRbW9FSkRFTm1r?=
 =?utf-8?B?MWhoQUZjZkxNbEFCMklrVllwUGw4c1RJWjc2Rjd2Z1FJZm9QZzNXRlJUQVhC?=
 =?utf-8?B?RjJpU1J5dEdnbkw0bXVuV0dBTHErVXNZaWp3VE5SRmlyS05vc0NReG5YNm1M?=
 =?utf-8?B?blVqTlU2b0VqQUZzWFdTbGl0UENLS1JPeFhiWDFuTjlobllMVHNsL0tSN1lN?=
 =?utf-8?B?aGN0TTZUTGpZa0RsL0pJL3d4WHptN09zTnpBN09LLzlITGhjRTZyYm95czZY?=
 =?utf-8?B?dk9JTkVST1dVNnJYN1Y3SnpYK1NzM1dCdWNSWENhSGlReDNUTDMzcE5Sbnl5?=
 =?utf-8?B?WjNtME11OVl1M3U4Q2RMOVNYVzR6MXR1eDhqeU5RY0M5anJ6RWIzOUppZkpN?=
 =?utf-8?B?NnVPeDNncHVPcU5RbHh1bXFGRkJya1FjejN0RGVZTGE3ZTBGbThiR2E5ZXFR?=
 =?utf-8?B?RVZ3amhWUlg5cGMvMjJ3N2ZTbnpkY1NhaDFXMUZQbExLQjhOcTRoelBXMS9T?=
 =?utf-8?B?aExlOTFlMWZYaWtMbWJmQ2RmbU5FaWFkdHc0N1VpbTRQMGtVSTRDTUhVQ2xp?=
 =?utf-8?B?Rit4OEhuNWwvRytqd2dwZTVrOEppY3cveHVuRW5FR1VuVi85QTREanJRNkxE?=
 =?utf-8?B?bHM3cXJabzNYZk5ydktCbHRnMlZJYjF3TVJkbXVZNlBUejVFU0hwLzBBWWdT?=
 =?utf-8?B?eUljL1MvaUJqU2c5UnZvK09hbzlyYndyZDFuRkg0Ty9uWm82L01oNWdvYTIr?=
 =?utf-8?B?R2Y0U0xHRHRXaXlMUlhvZ1RObjBnZHJBVXFoNjBrdkZZdG8vUFpMbUR0WkM0?=
 =?utf-8?B?RXExeklCSkQrTk5wMU1uVlNaTUt2MTNmbjV0K1VrT08wT3BRYjJGUW0zWGdz?=
 =?utf-8?B?NVduUEQ4amRZbmo5SUZIc0VDTXJveEFLaUtrYUpBWHhIS3J0ME5SRGdvRG92?=
 =?utf-8?B?a051eVRmZ0RGcUZJZnlha2t3ZDMzYmxCZEVBTHhPczEyQjN4Zm1BcXNJbFZi?=
 =?utf-8?B?LzV6WkpsRlRyd3FBbGs0VmtjTWF2S2t4QVEvMVVRNEhGMk1jclJoenJnQUMw?=
 =?utf-8?B?dm1ZdUFTajFzc1JsbkhzeW42ZE9LQ2lXcU1FcXFQWkw1cldORnF4blIrMmdH?=
 =?utf-8?B?MkpScEU3VU9FeU1RZ2RPMG5ZZXpqS0dlMTh3YXJUZWJIL2pGUUh4U3RnSzZ3?=
 =?utf-8?B?Qk1rNG1pd21RQ3Y3RFRnRGp4Yy9MUUZyVVhKQU9Qd1FmaXFoK3FScXJWalBD?=
 =?utf-8?B?dGhxT0F2V3lJU1NzbGhJYUFQWFJIQmV3VnBlWTFoQmVhdXo3L1NoclQ4Z2wx?=
 =?utf-8?B?cWNzVm1yaFJyZVd3WFVwbGhaaHZaaEtEUStqa0lOaCtTaXFyeHVXbHMwaEt3?=
 =?utf-8?B?U0JjODIvdUp3c3R0cG11OCtQMDBYdm5FcUh1dlA2elQxNGNPK2p6NEFxdHNi?=
 =?utf-8?B?c2pvUWszVHVNdGswRmZsbHYzY1g2UzlDVm9BVkVWanlMTXpXNXErNUovSmFT?=
 =?utf-8?B?UGg3aW5Ec205Y3B1a3NGVUUwSlBzV1BUZjdFdVgrcE5CSDNjVUN2TlBPR3lu?=
 =?utf-8?B?MUJaTkFBVHVWUDZiUURoeGV4SmR3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99D96CF752DE8942998CBCBD382F0058@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f28cfe42-5efa-400f-370f-08ddf4766045
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 16:39:01.4923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZeQxG9mMmtWiJdEMOjQvXByyxJsGVmVqo/jT9+v1tqtCPUhXvTGbe31fDBWibvV+drnihWD4sA87c1+EcHa3wTeSrrdoO3hlfTa1ZZSKVU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10341
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDE1OCBTYWx0ZWRfXzpCwyq7MrzDH
 dQ4ZAnYOx8tCBKP84mcSi5tvl9oi/6eEuAGcGKcO7cY3JeGo6/AfwlMib2s5IfR3IorD0boBpaD
 n0ejUJU7v/Y12L1fhQmFJat+OoL/Vz1dCCptorr1l/SppDLvvA0iIzBRUdk4Q/vXNdOL0b1fIZA
 zskC0r0JIIWzcTW0uPGj22HOYn/JfiX4C0tBMtoKyIrNsYFePMEY+MoFhtcBWbVCjUiYDoC1mwU
 J3Tqnh1zFE3exNq9H46FHIKFz0IbWtCC5+VRtRuBh66SBMSscNJF9WTO7PzGJ0q+jgxWEeTbzOe
 MlaQfHQExQ9+fW/IwrFm+xdEwXpmRZl+VFtLDeMAI2WVW8ynplkJ54R9rUMsm0=
X-Authority-Analysis: v=2.4 cv=ePoTjGp1 c=1 sm=1 tr=0 ts=68c8412a cx=c_pps
 a=XrAAyJxZ/W28UfFUt0AM7g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=mjddQKk4ToQmFwEE7k4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: AD5pN_eFXmosvss0Rs1wVJbhhqJ0TlSK
X-Proofpoint-GUID: AD5pN_eFXmosvss0Rs1wVJbhhqJ0TlSK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_06,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gU2VwIDE1LCAyMDI1LCBhdCAxMjowM+KAr1BNLCBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+ICEtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KPiAgQ0FVVElPTjog
RXh0ZXJuYWwgRW1haWwNCj4gDQo+IHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIQ0KPiANCj4gDQo+IFR3byByZWdyZXNz
aW9ucyB3ZXJlIHJlcG9ydGVkIGluIHZob3N0LW5ldC4NCj4gVGhpcyBpcyBiYXNlZCBvbiBhIHBh
dGNoc2V0IGJ5IEphc29uLCBidXQgd2l0aA0KPiBwYXRjaCAyIGZyb20gaGlzIHNlcmllcyBzcGxp
dCB1cCBhbmQgbWFkZSBzaW1wbGVyLg0KPiANCj4gTGlnaHRseSB0ZXN0ZWQuDQo+IEphc29uLCBK
b24gY291bGQgeW91IHBscyB0ZXN0IHRoaXMgYXMgd2VsbCwgYW5kIHJlcG9ydD8NCg0KRm9yIHRo
ZSBpb3RsYiBiaXQgKHBhdGNoIDIvMyk6DQpUcmllZCB0aGlzIG91dCBvbiBhIDYuMTYgaG9zdCAv
IGd1ZXN0IHRoYXQgbG9ja2VkIHVwIHdpdGggaW90bGIgbWlzcyBsb29wLA0KYXBwbGllZCB0aGlz
IHBhdGNoIGFuZCBhbGwgd2FzIHdlbGwuDQoNClRlc3RlZC1ieTogSm9uIEtvaGxlciA8am9uQG51
dGFuaXguY29tPiANCg0KPiANCj4gDQo+IEphc29uIFdhbmcgKDIpOg0KPiAgdmhvc3QtbmV0OiB1
bmJyZWFrIGJ1c3kgcG9sbGluZw0KPiANCj4gTWljaGFlbCBTLiBUc2lya2luICgxKToNCj4gIFJl
dmVydCAidmhvc3QvbmV0OiBEZWZlciBUWCBxdWV1ZSByZS1lbmFibGUgdW50aWwgYWZ0ZXIgc2Vu
ZG1zZyINCj4gIHZob3N0LW5ldDogZmx1c2ggYmF0Y2hlZCBiZWZvcmUgZW5hYmxpbmcgbm90aWZp
Y2F0aW9ucw0KPiANCj4gZHJpdmVycy92aG9zdC9uZXQuYyB8IDQ0ICsrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRp
b25zKCspLCAyNCBkZWxldGlvbnMoLSkNCj4gDQo+IC0tIA0KPiBNU1QNCj4gDQoNCg==

