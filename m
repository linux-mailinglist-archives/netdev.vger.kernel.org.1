Return-Path: <netdev+bounces-243250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CFFC9C3EF
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 17:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 56FB3341475
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 16:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D33279DC3;
	Tue,  2 Dec 2025 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="SKQFcvc4";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Xu0B4VTv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC7B1F03C5;
	Tue,  2 Dec 2025 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764693645; cv=fail; b=jte9d5rX7pRYAjm9+d+iesHr6+Y2WK/LjDDO+mIiiNGqA6utzF/EzdoEigAhEb3Hq1zOJ5NybK6a/ZKUUiyY/lmNTwaAiI7VvNeHJO9RrqIeqiekKpiwofyxIpPN0+/5XAh0j9R1BNy8tovIomVg81s4cVtqg8QHYwhw0Zjcv0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764693645; c=relaxed/simple;
	bh=oXAd9mT4l+Cn2zTcSnbA2b6aeKeHDOatbDv88CvRd0w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cGLIf0AM5Nyzk4FowFLWouqdN53mFRo8AxlS7zx61MfgwP4T2FYqxjyer44qx2xFsp+ySvT0u7ZirRj/n19rTM0bAOMmYIfSEK1GPpab3Pe+qh4npqxKQ/p1g4FEYs9C86LR5CMbe4/EnfmT+joV8Hmj/2GjRZDtl80PHob0tM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=SKQFcvc4; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Xu0B4VTv; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2EPlf31715415;
	Tue, 2 Dec 2025 08:40:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=oXAd9mT4l+Cn2zTcSnbA2b6aeKeHDOatbDv88CvRd
	0w=; b=SKQFcvc4pOFaBX1GijRqpUgl5L5szAn1/ejbbSaRU/7y1XwKLme0vBb6+
	YFC1YmyzBYJivnXS3GRnr7hqd8MZa+98pDE65eAd9s+mA/e9hoecx4EBx422g5KA
	lXFFkUSxjyfhM817gnF9bq0bc0tclcX3hjbLq3Fh3IW9C4xStSbAUp8mhrA7G01R
	RvIPW/EnjQBmc2sQukLYs+GYq24hEO4CD8id//P4qET8K3KCNB2eHPbo27wn2P0s
	nxT1wqlvhW85hHNOkQsYZOvt0UOZ5ItI2h/mtszxo159FAYJahkUP4WS2+Omgqvp
	m7fq2O/fAwQwp6q6eOmbEhY1LO/CA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022080.outbound.protection.outlook.com [40.93.195.80])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4asrrxshw8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 08:40:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8hvYUwC85eWvsiC1EZTqcKjFueSD+QP/f1XNj8Xh7QD0RJkl9n9xdC/1e/U6YQJ7GNAfwBatfrcmh9vZAJ5eUN8YfUztFG0UPak/X0QkucNfud1neu795wMuBEDSVLokMrpcWOr3az70sbhUf9tB5AaJldHKEgrXbkL5U6MMbi9GFQYCG97W3ZWnhptB6S1cy+zXCEg7O8LzwU3wdE88IZvIZZ+Hv/eIHccZB4tlYfFiHTmfIBxpQq5sfABCA/8MI2bOUC2vEXaAHRc1zs/AAi23FJFL1jDvBBaNeI9mxEdCpM8rA1tUHpqgcrMMbyIkadOrtFc6MFE3a628RaqLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXAd9mT4l+Cn2zTcSnbA2b6aeKeHDOatbDv88CvRd0w=;
 b=uVpjRwBksMnNYTNlLZpoCgc4U2okozhxNC1KbhT3gf7k3D6R0kUyOanbz5zD70hSPnfck9jQl4kLWSRZSwn66P3+37ttutF0Es2avktcIF8HIrht4C/0ov5jIQNoVC+nhyRwFtn4mbW9BszFJ4ys9lfivkbyDGIU0VN4mwX6r8W134wSpDt27OND0BNesB4ZRB4mBWpvHrrPASwo9JzovCqgNgflfcTvSNeRSaNegWJ2Gsam9hmbuub9zDpFPfV2m4SdvTFdBSo7z9PioC6521ALnMUbnGs1bfU87JFJ2mYzOzI9VDNPlwWqlUz7Iw8auZjXAoMtRnMtJ1wHI9nKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXAd9mT4l+Cn2zTcSnbA2b6aeKeHDOatbDv88CvRd0w=;
 b=Xu0B4VTvALN/vZi4koZGSNrHGOa+cLEoVf0plg4Qa7VCjvuvJQUD+ufR+aqoMN2DcdQ05mzOfmXMVippSkEh5zirnb/9PIIfxrcNXWh4aPIG1z50PGiohW3QEBRNP/jJ9wQBaIwZ21xCjaRICMyosm7R8yV8QG0IdyUiEAMs4A9OANB1z79gL43ZbwTk+o6Z49heaGM+hmwRno3HXsMQtmrOgHtaC2HhMjueWqsfqN2MOw1ZkoNFLgeuyTk73X3FCsKQ7IU7xKhOwJoWYqYCNCEDnMi7d1IbBfiyAXHjqYnMZpXCuAWddK+QVEsWktnJlQY892wkgMSE2ShN/O6LXg==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by LV3PR02MB10737.namprd02.prod.outlook.com
 (2603:10b6:408:289::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 16:40:30 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 16:40:30 +0000
From: Jon Kohler <jon@nutanix.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Jason Wang
	<jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/9] tun: correct drop statistics in
 tun_put_user
Thread-Topic: [PATCH net-next v2 3/9] tun: correct drop statistics in
 tun_put_user
Thread-Index: AQHcXkBHgxbxcUh05ki00EQys3zq4LUI/hgAgAWaF4A=
Date: Tue, 2 Dec 2025 16:40:30 +0000
Message-ID: <F48BA9F9-7E15-49B3-896A-5AE367DAD060@nutanix.com>
References: <20251125200041.1565663-1-jon@nutanix.com>
 <20251125200041.1565663-4-jon@nutanix.com>
 <willemdebruijn.kernel.1c90f25a9b9a9@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1c90f25a9b9a9@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|LV3PR02MB10737:EE_
x-ms-office365-filtering-correlation-id: c6c479e9-01d4-4c31-746c-08de31c18183
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aXp3N1phYmxPUjNpUjZ2ejU0eTRXM3NNdmVyVjJFeWtxZHY4WTEvMW01NzZG?=
 =?utf-8?B?WVJUOU9zc2YwczVrVFZxd2dGTTVrN21pNGRhZVFVZDdOZ1ZGODZRdWtmOGJN?=
 =?utf-8?B?UGY3N3doWFVnZmdFWEdnKzFSdTBJYUllemxaTlcxdEYyOXE5bEpNREVPS3BU?=
 =?utf-8?B?NDM5VDJrbFhGbEZUeXA4SzUxTUNta0prcmdUTGo1blQ1SU8yc0ZFbVdnUEph?=
 =?utf-8?B?OWVnMmtVbjVIYjdDTXRlVFZJZmFnTWNTZ24yM05mMWh3Q3E5U0FJbTBPL0RK?=
 =?utf-8?B?bUt0enBETW01Si90alk5b1pOcHNYeEJUUjJjMEc2Tk80VVA4eTFHeFB6MUt1?=
 =?utf-8?B?UXQzWkRxR1dDT05jZ1VBWENuM2lZU2lEeXBmVkVqWUJDbDJpeGhEdC9XYUwx?=
 =?utf-8?B?bFpuQmc1OGpndExxV3FkckdBeGdtNFJKamhwUTVYV0ZQUWk4MzVabnNUZDN2?=
 =?utf-8?B?YTNDcFRSQlVKVEh2LzBMNlMwWC9GNDE2YS9NZ2diQUFUc0YzSXBBZWNiQ2JL?=
 =?utf-8?B?UWtuUmI0d1ZHdW1uTjRkekxRTlVrRDBBK3J5WmpGV3l6TlpYRzNYdmFZaTF3?=
 =?utf-8?B?Rk5INkpCajN5dXNHSnRNOUVMYkZMbGI1NVMzWkhkMWg4dXRQRnZrWWNQWkY4?=
 =?utf-8?B?WFRDSmV5NzkvUnJLQlFwZGFCR3kxdlNWOElVVFdSSlRSUEZpdWQ5eDNIaUd2?=
 =?utf-8?B?U1ZyZHJ2bFpwZlBNOGk0eU5HSXkzcTNic2Zxd2lDdytkNVhrUUZ5YmN0UzNv?=
 =?utf-8?B?cHYvZ2ttN21iUTA3KzV0V2NtVUtzeG1KWHJRZGFuN2F2VkUrWlRKQVIyYllM?=
 =?utf-8?B?VGVFaWt5Y3J1ZmFFamp1eUtKLy9rVnRMbG1xTFRnVnB4ZFFjNkhWcWlWdURI?=
 =?utf-8?B?Y0dFT2FQZFJLci8yU1lIMTN3S1Jlb1cvQjBvMjRYUkpkT0QzQ2owSEQ3VFJZ?=
 =?utf-8?B?Q2RyZnFZcVZPRTd1N25qMkF3dnJTVnA2MG56QmYxMWkyVnhCdnVqOUNQZHY1?=
 =?utf-8?B?bDE3K0pJbVVGTzMxWU8wWVVyNnI5aDZ2QlhOZlV1MEFoaW1LN09hbWd0SEtp?=
 =?utf-8?B?NFNoSnFnN3VzRDJoa2JjcHd3U3pKVlVLbG9ob1hyMURPaWpNeUV0OHhVc29F?=
 =?utf-8?B?UTdnL1BlUjg3bGxpQytiWWRYcWpnSFVyeVhMRWFZaGJpWVdlbTJ5WHV3ZWUz?=
 =?utf-8?B?UE5iMDlLWHlXeHVZMUZYdmhuUzNmNVh2TlVFQlZUSmwxUStjTWRxRWdZd25R?=
 =?utf-8?B?eUhYcDVTQ2h5K1RRTlQxclBDc2N6UGJ3ODVLZzJVdllKWVU5QW5naUQxVitk?=
 =?utf-8?B?KzQ5Y05XbGxJcnp5aWlkSjc0SnhxTDJ2QjJ4SlNKTTRFRXE0dDVUbzN3Z0tj?=
 =?utf-8?B?WmRVN2xpWFl0cDFOR3UwNjNEYlBwdm5jSDZqbGk3ZUtXTFp5QnBaWXFVQUxo?=
 =?utf-8?B?ZTBVTDZ2b254NEdWcDBDc0syOE9xelQ0Vnhzd1g3MEFoUkVLVVBYSE9CM2Qv?=
 =?utf-8?B?MlBmMkdLdFBTK1o4S2JMS1V1Sy96UXU4RHoyL1p5TzRsblFsT1l0SkRWOVpS?=
 =?utf-8?B?NkZRblMxUXFRNktTNndPMWR0SmtoWDh6QWZlczY5K3F5cmhyUmRibWtRZ0JY?=
 =?utf-8?B?MzB5VXZOWE1WK1QyRVM3cG9PVlVFUmozT05tczZDZnZIYm5kU0syS3UvcFpm?=
 =?utf-8?B?MllxZTFVcGRWd0J1TU02WFV3dmE5Qm5hWXd0OVc2bHkvdkJmb0llWncrMnFN?=
 =?utf-8?B?dWo1VjRFYWtaOHc2Mk9FSERFZE1ReU55bUlSbHpPSWZjcC9jQnA1b0V1ZlJI?=
 =?utf-8?B?eGpLNEExNWhDVEFSTk9wZm13Z0lTZXVIT3RGVVh2T2p6WG1RMitXNXU0aVg2?=
 =?utf-8?B?ZE1rZmlBQkVWYTFTanp4cmx5cndnUWQ4ZVNnY1pQaEZEaThQTEFoc1BWMW5t?=
 =?utf-8?B?bWxPQUV4RTBldHlxaURyNXFwRGlpWFFJRTdBUGFVZDkybmdlMjJwTHpxRGNn?=
 =?utf-8?B?Wm5VSk85U2hlT2IvUzNkR1l0cTJTUFl2L3hlL3FmQnNlakY4b20yTmhrQlA5?=
 =?utf-8?Q?Ww2T/f?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a0UrWXlVUXZQVE1BOURHZnU0YTZvVmRpTUFNdVZ1U000MWZnNmgyYjNPNTIr?=
 =?utf-8?B?djZWajBQdXFyU083YVFsdHVmVjl3blRRdGN5SkJqeDV3a0JPRElnbndUK0FJ?=
 =?utf-8?B?dGNGcGxXL1diNEpFQzlGTDZTL24vcW4xeHlNYWlOMU16czN1cHh5SkpabXVz?=
 =?utf-8?B?QjdFTXZoaFpoY2Vzd3FEdUtuYXRTRk9pNUxRMWcrT2lKWXJ0alNQa0J5dll5?=
 =?utf-8?B?QWw2TldVMlM3N0xYV29GN0RFQzF4aGVWZkxGOWZlWThkM1UvWFdmWm1GbTAv?=
 =?utf-8?B?VVBQdFFBUmpWTmxQYVRWWE1IRFpwOW8vQkFacE9hUnMxbWx4ZXBQMmlNcmRM?=
 =?utf-8?B?WFgwRFVhYnRPdysyQ0orZ01SbVV6MFdJUjB1V3U5M29Uc1RhVHIrbVhjZ0dT?=
 =?utf-8?B?LzNQYWFCVHgzOHN5YklwOTc0VEg1b09FR3FCdFJLK09QVURCYXppOTR0ZE92?=
 =?utf-8?B?akZMczJ1aVpRSEZlcWR1VWJYZ1VmbXZKWUNrZ0hjU01vbTF3Qk51YjArcnBX?=
 =?utf-8?B?UUFNM3BNaWRjRHRNZkt6TDlHVHdybmF0d2RHaGhwMlU5WGJpQ3FVUXVNK0Ns?=
 =?utf-8?B?TUJ4MGkzMzBhbXdJdmtvVDFKa2F0K3QzdkZhN09lTVA0NnFwNVFGL2Z1V2Q5?=
 =?utf-8?B?RmdjaG1OaUZITHk3Zk5BS0Q3R3MxVk9vMVVZVlRacERvTEhIOXk1NmhXWkhU?=
 =?utf-8?B?dnkzUFN2TVhoLzJtNFFJKzByWStVZ3VlazQyWnJtZXJJMVM3eUZmU0RwazVJ?=
 =?utf-8?B?NVc5cFd4RU1JQ1BqMEVNYjdGb0ZtL1k4cnJkN2RicUpQekRvVnl6a3JOUVBE?=
 =?utf-8?B?bzdmc1cvRGRhQXdGMmdRK25yb1FEL1oxSTJsVnRWVm1qK3NlTW4xeFhGVy9D?=
 =?utf-8?B?WENndEVCcVcyYjIrWDFPb2NpWXZMQllCOE9EcGluanZZV3NDOHlvRmcvR1Bi?=
 =?utf-8?B?L3F6YmlRRjBiYzUxRWs5RjNWR3N4a2ZRQ255N0thd21vVy92WnUyMk5QdDUw?=
 =?utf-8?B?UGpwUXJ3L3NPK1pHZ2VXV0EzYVZ3NU9VZkJzQVVNM0xaMEFFNGwxN1kvbTlu?=
 =?utf-8?B?RXp1TmRaSmh0YUJSTmVlZEJvdUhPWkpLODEyUjh5MTZDZ0dsWUk5anVhaWV6?=
 =?utf-8?B?Y0hIWXhGZFJOdy9ySFVja2hGdWVXZVltRkFwdGlFWm9SdnVaWUN6RU50UCth?=
 =?utf-8?B?ektSVTNBckN3SHVZYkhHbVIwQVZJa2dobUNLVUx0M2hxb0tjaUJrSGIxcVBx?=
 =?utf-8?B?NHFlY2JLNU5UV2lqdkUzVmZwWHcwSVFIZURsUUNEaVF3SWdoWWJxMjJ6RHph?=
 =?utf-8?B?eG5lODVwMDlaZ1JsMWFyNFp6WTdrUDBCRnFXSFFhY1FUd2NEMjQ2bzVvanJh?=
 =?utf-8?B?ZDQvUzBYRHltdnlwNWwxcDR1YmZUbGIxMnh3K0JFQ0ZQR2tjVHdGQ0UzUDk1?=
 =?utf-8?B?M0M1OUFCSGNLMFZTMjZLVlY4Z0JEWGNRYlpWRWVkUTZ1UE5PaXNYWmVRSDJB?=
 =?utf-8?B?RDJwcE82c3MzdUJaVXFFa01NcVRUTlBMdUlaRnpnVVlHZHVocHZPOGVPWTc1?=
 =?utf-8?B?aHVHS215QzQ3MHNBa2ViU1cwMXZValJQY09JZzNDY1JKMWRXK0pkb1MrT0Zw?=
 =?utf-8?B?L1BKYzVCdEVhaVNrc01wWStodlFwRGVLeUJwbUlYSjdIYXRNdmJDb09IeHFj?=
 =?utf-8?B?VHgwcFV1TUM0NTAvTGFIWkxsckJ6VWR4U0JrQmN1Q0RuNHExb2EwelNWMm1m?=
 =?utf-8?B?dVI0b1p5UE1lU1N6Q0M3bUpGeGRsRDVZZ1o2NEpZSERaUDY1UEc2eUhBSXFH?=
 =?utf-8?B?UWNGYUQvN2ZSWWo5UGhNYVd1akJwSm5HbmhSMW01N3VqaTBkbFBJVnRZdG5i?=
 =?utf-8?B?N0gwaGQrc0JVZEIrZlBZcXFtaTMzY09ZQWRTNUppTlAwOXdoSDFOQTBkRm5z?=
 =?utf-8?B?NUthTDBFbjBtbFNIV0huL1U1NjdLdHFXbG5xZjRZbnI4dnNqNGtoeFdMWUVB?=
 =?utf-8?B?OFZVVnp1Mk9hVFhnZHByaHYrQVpocURpWUg4MkgxUzEvTnhqNVFzTlVNOWVt?=
 =?utf-8?B?YXQwNktERXMrSG1jbUJQSGlXWHRkVmdOZnZwUUlCdnhPdFhZUlYyY0dRNlVo?=
 =?utf-8?B?a0lIeHI4QzFVVGZ0TDZydHpCOEpWLzR2RlU3OXFzc3V6UWI4aGc4dzRMU0RC?=
 =?utf-8?B?ZkdUZXZJbDdVSndsSTNsa2hDWEdRVklvbElocTduU2dZbnltcjgxY0NDa0k5?=
 =?utf-8?B?YklYOWtKMUhSejVnTVJvTkpFNlVnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75D911D37FF59E45A63611E563CF2824@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c479e9-01d4-4c31-746c-08de31c18183
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 16:40:30.3898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGCKJYfXDn6FHzu4rk3d4uvpojegV/l0awcqOZl8MkRZT4NlT1oxQSeg068kgplCk6+1GjFnzCeBVUxcTA27M3iDYuLtughUqb/vAtM7KsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10737
X-Proofpoint-ORIG-GUID: MpvHZCkmm4JOUeeY2PHTeQTpN49lYn27
X-Authority-Analysis: v=2.4 cv=HboZjyE8 c=1 sm=1 tr=0 ts=692f1681 cx=c_pps
 a=mu652P9qVXFiHaHDVbjfEQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=64Cc0HZtAAAA:8 a=P6n6ZJdCnh6Nh9ZTRPMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDEzMiBTYWx0ZWRfXzs7JKlOEdG+t
 qAFrPkz37s1PeXUG5uYixmn+3+bppq4oK4/UjR6NT4TJf6WRabEHgSk7+Q3++W4THeoqzxqEpfI
 dzhSwT8NltUtIBxHd6rGvTLj7mtQWPPVA+G/w6OHIwUR6q8AfAFtG/n0vux8vHjXwppP40upC00
 Hg/spRqFOcAeZeO8/1wlmEt9L+KIePxYdb4xC+QWpDrRY5ud/OpaanR0e9AKEX0Z1MbAGacxq1K
 XHEHX8tIWw/r7i1YYqCOScqTHASSlTT3zZDQ/InQPX/JeqSFtibxazcn6vjRtR1JVstPk2JqelX
 wIKhsG7tbNrdvM4/diQH1DQXNkZLmNPpLuRKfLhr/9dw8LM3i9a0LV3q+xeTQ/Zd+ABHfRm3Uer
 0eXyo2HheSWLUUq+0ZRoj9GahyRIVw==
X-Proofpoint-GUID: MpvHZCkmm4JOUeeY2PHTeQTpN49lYn27
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTm92IDI4LCAyMDI1LCBhdCAxMDowN+KAr1BNLCBXaWxsZW0gZGUgQnJ1aWpuIDx3
aWxsZW1kZWJydWlqbi5rZXJuZWxAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IEpvbiBLb2hsZXIg
d3JvdGU6DQo+PiBGb2xkIGtmcmVlX3NrYiBhbmQgY29uc3VtZV9za2IgZm9yIHR1bl9wdXRfdXNl
ciBpbnRvIHR1bl9wdXRfdXNlciBhbmQNCj4+IHJld29yayBrZnJlZV9za2IgdG8gdGFrZSBhIGRy
b3AgcmVhc29uLiBBZGQgZHJvcCByZWFzb24gdG8gYWxsIGRyb3ANCj4+IHNpdGVzIGFuZCBlbnN1
cmUgdGhhdCBhbGwgZmFpbGluZyBwYXRocyBwcm9wZXJseSBpbmNyZW1lbnQgZHJvcA0KPj4gY291
bnRlci4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogSm9uIEtvaGxlciA8am9uQG51dGFuaXguY29t
Pg0KPj4gLS0tDQo+PiBkcml2ZXJzL25ldC90dW4uYyB8IDUxICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tDQo+PiAxIGZpbGUgY2hhbmdlZCwgMzQgaW5zZXJ0
aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC90dW4uYyBiL2RyaXZlcnMvbmV0L3R1bi5jDQo+PiBpbmRleCA2OGFkNDZhYjA0YTQuLmUwZjVl
MWZlNGJkMCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbmV0L3R1bi5jDQo+PiArKysgYi9kcml2
ZXJzL25ldC90dW4uYw0KPj4gQEAgLTIwMzUsNiArMjAzNSw3IEBAIHN0YXRpYyBzc2l6ZV90IHR1
bl9wdXRfdXNlcihzdHJ1Y3QgdHVuX3N0cnVjdCAqdHVuLA0KPj4gICAgIHN0cnVjdCBza19idWZm
ICpza2IsDQo+PiAgICAgc3RydWN0IGlvdl9pdGVyICppdGVyKQ0KPj4gew0KPj4gKyBlbnVtIHNr
Yl9kcm9wX3JlYXNvbiBkcm9wX3JlYXNvbiA9IFNLQl9EUk9QX1JFQVNPTl9OT1RfU1BFQ0lGSUVE
Ow0KPj4gc3RydWN0IHR1bl9waSBwaSA9IHsgMCwgc2tiLT5wcm90b2NvbCB9Ow0KPj4gc3NpemVf
dCB0b3RhbDsNCj4+IGludCB2bGFuX29mZnNldCA9IDA7DQo+PiBAQCAtMjA1MSw4ICsyMDUyLDEx
IEBAIHN0YXRpYyBzc2l6ZV90IHR1bl9wdXRfdXNlcihzdHJ1Y3QgdHVuX3N0cnVjdCAqdHVuLA0K
Pj4gdG90YWwgPSBza2ItPmxlbiArIHZsYW5faGxlbiArIHZuZXRfaGRyX3N6Ow0KPj4gDQo+PiBp
ZiAoISh0dW4tPmZsYWdzICYgSUZGX05PX1BJKSkgew0KPj4gLSBpZiAoaW92X2l0ZXJfY291bnQo
aXRlcikgPCBzaXplb2YocGkpKQ0KPj4gLSByZXR1cm4gLUVJTlZBTDsNCj4+ICsgaWYgKGlvdl9p
dGVyX2NvdW50KGl0ZXIpIDwgc2l6ZW9mKHBpKSkgew0KPj4gKyByZXQgPSAtRUlOVkFMOw0KPj4g
KyBkcm9wX3JlYXNvbiA9IFNLQl9EUk9QX1JFQVNPTl9QS1RfVE9PX1NNQUxMOw0KPiANCj4gUEkg
Y291bnRzIGFzIFNLQl9EUk9QX1JFQVNPTl9ERVZfSERSPw0KDQpBcmUgeW91IHNheWluZyBJIHNo
b3VsZCBjaGFuZ2UgdGhpcyB1c2UgY2FzZSB0byBERVZfSERSPw0KDQpUaGlzIG9uZSBzZWVtZWQg
bGlrZSBhIHByZXR0eSBzdHJhaWdodCBmb3J3YXJkIOKAnEl04oCZcyB0b28gc21hbGzigJ0gY2Fz
ZSwNCm5vPyBPciBhbSBJIG1pc3JlYWRpbmcgaW50byB3aGF0IHlvdeKAmXJlIHNheWluZyBoZXJl
Pw0KDQpIYXBweSB0byB0YWtlIGEgc3VnZ2VzdGlvbiBpZiBJ4oCZdmUgZ290IHRoZSBkcm9wIHJl
YXNvbiB3aXJlZA0Kd3JvbmcgKG9yIGlmIHdlIG5lZWQgdG8gY29vayB1cCBhIGJyYW5kIG5ldyBk
cm9wIHJlYXNvbiBmb3IgYW55IG9mDQp0aGVzZSkNCg0KSm9uDQoNCj4gDQo+PiArIGdvdG8gZHJv
cDsNCj4+ICsgfQ0KPj4gDQo+PiB0b3RhbCArPSBzaXplb2YocGkpOw0KPj4gaWYgKGlvdl9pdGVy
X2NvdW50KGl0ZXIpIDwgdG90YWwpIHsNCj4+IEBAIC0yMDYwLDggKzIwNjQsMTEgQEAgc3RhdGlj
IHNzaXplX3QgdHVuX3B1dF91c2VyKHN0cnVjdCB0dW5fc3RydWN0ICp0dW4sDQo+PiBwaS5mbGFn
cyB8PSBUVU5fUEtUX1NUUklQOw0KPj4gfQ0KPj4gDQo+PiAtIGlmIChjb3B5X3RvX2l0ZXIoJnBp
LCBzaXplb2YocGkpLCBpdGVyKSAhPSBzaXplb2YocGkpKQ0KPj4gLSByZXR1cm4gLUVGQVVMVDsN
Cj4+ICsgaWYgKGNvcHlfdG9faXRlcigmcGksIHNpemVvZihwaSksIGl0ZXIpICE9IHNpemVvZihw
aSkpIHsNCj4+ICsgcmV0ID0gLUVGQVVMVDsNCj4+ICsgZHJvcF9yZWFzb24gPSBTS0JfRFJPUF9S
RUFTT05fU0tCX1VDT1BZX0ZBVUxUOw0KPj4gKyBnb3RvIGRyb3A7DQo+PiArIH0NCj4+IH0NCj4+
IA0KPj4gaWYgKHZuZXRfaGRyX3N6KSB7DQo+PiBAQCAtMjA3MCw4ICsyMDc3LDEwIEBAIHN0YXRp
YyBzc2l6ZV90IHR1bl9wdXRfdXNlcihzdHJ1Y3QgdHVuX3N0cnVjdCAqdHVuLA0KPj4gDQo+PiBy
ZXQgPSB0dW5fdm5ldF9oZHJfdG5sX2Zyb21fc2tiKHR1bi0+ZmxhZ3MsIHR1bi0+ZGV2LCBza2Is
DQo+PiAmaGRyKTsNCj4+IC0gaWYgKHJldCkNCj4+IC0gcmV0dXJuIHJldDsNCj4+ICsgaWYgKHJl
dCkgew0KPj4gKyBkcm9wX3JlYXNvbiA9IFNLQl9EUk9QX1JFQVNPTl9ERVZfSERSOw0KPj4gKyBn
b3RvIGRyb3A7DQo+PiArIH0NCj4+IA0KPj4gLyoNCj4+ICAqIERyb3AgdGhlIHBhY2tldCBpZiB0
aGUgY29uZmlndXJlZCBoZWFkZXIgc2l6ZSBpcyB0b28gc21hbGwNCj4+IEBAIC0yMDgwLDggKzIw
ODksMTAgQEAgc3RhdGljIHNzaXplX3QgdHVuX3B1dF91c2VyKHN0cnVjdCB0dW5fc3RydWN0ICp0
dW4sDQo+PiBnc28gPSAoc3RydWN0IHZpcnRpb19uZXRfaGRyICopJmhkcjsNCj4+IHJldCA9IF9f
dHVuX3ZuZXRfaGRyX3B1dCh2bmV0X2hkcl9zeiwgdHVuLT5kZXYtPmZlYXR1cmVzLA0KPj4gIGl0
ZXIsIGdzbyk7DQo+PiAtIGlmIChyZXQpDQo+PiAtIHJldHVybiByZXQ7DQo+PiArIGlmIChyZXQp
IHsNCj4+ICsgZHJvcF9yZWFzb24gPSBTS0JfRFJPUF9SRUFTT05fREVWX0hEUjsNCj4+ICsgZ290
byBkcm9wOw0KPj4gKyB9DQo+PiB9DQo+PiANCj4+IGlmICh2bGFuX2hsZW4pIHsNCj4+IEBAIC0y
MDk0LDIzICsyMTA1LDMzIEBAIHN0YXRpYyBzc2l6ZV90IHR1bl9wdXRfdXNlcihzdHJ1Y3QgdHVu
X3N0cnVjdCAqdHVuLA0KPj4gdmxhbl9vZmZzZXQgPSBvZmZzZXRvZihzdHJ1Y3Qgdmxhbl9ldGho
ZHIsIGhfdmxhbl9wcm90byk7DQo+PiANCj4+IHJldCA9IHNrYl9jb3B5X2RhdGFncmFtX2l0ZXIo
c2tiLCAwLCBpdGVyLCB2bGFuX29mZnNldCk7DQo+PiAtIGlmIChyZXQgfHwgIWlvdl9pdGVyX2Nv
dW50KGl0ZXIpKQ0KPj4gLSBnb3RvIGRvbmU7DQo+PiArIGlmIChyZXQgfHwgIWlvdl9pdGVyX2Nv
dW50KGl0ZXIpKSB7DQo+PiArIGRyb3BfcmVhc29uID0gU0tCX0RST1BfUkVBU09OX0RFVl9IRFI7
DQo+PiArIGdvdG8gZHJvcDsNCj4+ICsgfQ0KPj4gDQo+PiByZXQgPSBjb3B5X3RvX2l0ZXIoJnZl
dGgsIHNpemVvZih2ZXRoKSwgaXRlcik7DQo+PiAtIGlmIChyZXQgIT0gc2l6ZW9mKHZldGgpIHx8
ICFpb3ZfaXRlcl9jb3VudChpdGVyKSkNCj4+IC0gZ290byBkb25lOw0KPj4gKyBpZiAocmV0ICE9
IHNpemVvZih2ZXRoKSB8fCAhaW92X2l0ZXJfY291bnQoaXRlcikpIHsNCj4+ICsgZHJvcF9yZWFz
b24gPSBTS0JfRFJPUF9SRUFTT05fREVWX0hEUjsNCj4+ICsgZ290byBkcm9wOw0KPj4gKyB9DQo+
PiB9DQo+PiANCj4+IHNrYl9jb3B5X2RhdGFncmFtX2l0ZXIoc2tiLCB2bGFuX29mZnNldCwgaXRl
ciwgc2tiLT5sZW4gLSB2bGFuX29mZnNldCk7DQo+PiANCj4+IC1kb25lOg0KPj4gLyogY2FsbGVy
IGlzIGluIHByb2Nlc3MgY29udGV4dCwgKi8NCj4+IHByZWVtcHRfZGlzYWJsZSgpOw0KPj4gZGV2
X3N3X25ldHN0YXRzX3R4X2FkZCh0dW4tPmRldiwgMSwgc2tiLT5sZW4gKyB2bGFuX2hsZW4pOw0K
Pj4gcHJlZW1wdF9lbmFibGUoKTsNCj4+IA0KPj4gKyBjb25zdW1lX3NrYihza2IpOw0KPj4gKw0K
Pj4gcmV0dXJuIHRvdGFsOw0KPj4gKw0KPj4gK2Ryb3A6DQo+PiArIGRldl9jb3JlX3N0YXRzX3R4
X2Ryb3BwZWRfaW5jKHR1bi0+ZGV2KTsNCj4+ICsga2ZyZWVfc2tiX3JlYXNvbihza2IsIGRyb3Bf
cmVhc29uKTsNCj4+ICsgcmV0dXJuIHJldDsNCj4+IH0NCj4+IA0KPj4gc3RhdGljIHZvaWQgKnR1
bl9yaW5nX3JlY3Yoc3RydWN0IHR1bl9maWxlICp0ZmlsZSwgaW50IG5vYmxvY2ssIGludCAqZXJy
KQ0KPj4gQEAgLTIxODIsMTAgKzIyMDMsNiBAQCBzdGF0aWMgc3NpemVfdCB0dW5fZG9fcmVhZChz
dHJ1Y3QgdHVuX3N0cnVjdCAqdHVuLCBzdHJ1Y3QgdHVuX2ZpbGUgKnRmaWxlLA0KPj4gc3RydWN0
IHNrX2J1ZmYgKnNrYiA9IHB0cjsNCj4+IA0KPj4gcmV0ID0gdHVuX3B1dF91c2VyKHR1biwgdGZp
bGUsIHNrYiwgdG8pOw0KPj4gLSBpZiAodW5saWtlbHkocmV0IDwgMCkpDQo+PiAtIGtmcmVlX3Nr
Yihza2IpOw0KPj4gLSBlbHNlDQo+PiAtIGNvbnN1bWVfc2tiKHNrYik7DQo+PiB9DQo+PiANCj4+
IHJldHVybiByZXQ7DQo+PiAtLSANCj4+IDIuNDMuMA0KDQoNCg==

