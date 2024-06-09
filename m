Return-Path: <netdev+bounces-102111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B41690175A
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 20:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FDFD1C20901
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 18:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E7948CC7;
	Sun,  9 Jun 2024 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fT97ih4w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lmJFEOCF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC70463C7
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717956511; cv=fail; b=NU/H7qJw8dwif+A6ljpu4WZpAElA5T6y+F/u4xHEKBI0gxIJWwrhq+DIVU3fxjwucZTFrURBkp8BB7taRNAsFgR9znYnqIRE543vnL2hvfLiPEPgw8xZLIsU4NwvvARjTdy2vgvwGL/lhyTHyriQaUm2LDiLsNP+bGY/CbRKDQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717956511; c=relaxed/simple;
	bh=7OObb/1JjKMk9MQihNjEsJ+LQUHNUlyONftZASs0M4w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=irpeimwIVFxoKgGzoXu1Q7OS4bfJ93vKrGoMEJYea4IyKSDeCpedBlYzB/JN7tauEhbWZJP07utAQ3FLc6ysXlx5Ja7oB4I8UMD5EoJXE5GC3sDaH7r6uSe1AuyabmI/iA/oN0/CdZJEqeeYVZHocZCwrQOpLjPf0i1XNkFBD50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fT97ih4w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lmJFEOCF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45920RXh002404;
	Sun, 9 Jun 2024 18:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=7OObb/1JjKMk9MQihNjEsJ+LQUHNUlyONftZASs0M
	4w=; b=fT97ih4wCmN++D6svoIdmp1XEr/29JA1O46lvNFPrQEDu122zZ6UUau4z
	Z4lV8CUGocGq3/rU0y23vUqM2moyj68c0fWqgDuO/vA8IiQr+iF5aStPN/DrFOMT
	OdjtwYjTP/A1ZYX2IbYXq0mwii3vVSkp6KLvAnqebCjtG8R2gwXLwURbRM63X285
	h58z4JqjPvc7jRMtPUg8ALI67G9DN67yv3+Lv0ps9PUx64E0yGLMvf3YiENSKF1m
	02K8yoZTgj9VWEHgyDlbh2XcLWfsAG2e99y248R4HV+wt7pJEgxggm+sRBOqvB3Y
	siLRuGjHtRQsKZzJm54bOcRUBa0gQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh1g9cjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Jun 2024 18:08:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 459H2CdE012645;
	Sun, 9 Jun 2024 18:08:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync9udxsg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Jun 2024 18:08:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYDASuHYp6lIFUOGTqyCeQRjz0JaLhIApcpcmHQ76OdcCRaLgzgNSQaPQLXF9k84S4CY96wwTX4hqHZLehUv/CVulifs+vX/ltt5rm2rjmsN1xQUQDk7Bj6UW7wggsWu/zj7ZstVzdH8T+qEJO53CCibx+97GGUAIYpe78EJszmTu0/1fiGbtDrLpjZ45ZP+ASFMwHtBtZwVqreSoYFS9fdllWOUA+v4e6rRzS0IVWw3Qtf9Eno7blzyBpn6XyhQ2XLJRo3XlG98V5cZDdyiYO3u/r4MPm2QNLfsnZ+6NCQHp7SJ0L3kTdafYWbOiiBHNzilMP9J3qTiwChS8HDuVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OObb/1JjKMk9MQihNjEsJ+LQUHNUlyONftZASs0M4w=;
 b=Up7WkSEHc1gpLC5gThB5wEBfTImbphxVJzJ9pOFpy29/JsH7xa6XOr+gOlr3i3IR7+u34OPJFhcXDBIqSDE+U7ZzFN1FoNBKqUMh5v5q8YP4Ow9GSfNel/bm3mgjBH5edO3qEXuiErjO1DBW8gCZqUwYbOosf+25EB0zofqY5LljCdqRQqjN658chSD0A1sX4kw/7XiXRn6m59bz8iHulCp/EvwyI6i+xk9LdIuaSCYH7SWWOd1t9g+26jIVdU8eNUTEeieUiV6Y3RyZGS7AI+GLuYEHlGKQ5XnlRVlPXHuZnf5bDn69b5IVRMGpsTjxdfvjAejAgFsG42lG4IRTRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OObb/1JjKMk9MQihNjEsJ+LQUHNUlyONftZASs0M4w=;
 b=lmJFEOCFREyiEzZB26k6SzUaC9yrCJ8IAg/FgiJB2QFWuvwpgR0YZ1uyAbCQo2Ki4O21vHTpnrQqeso+be/ZA73blShc8LPcDAZz1e/L05Y+Y0yNmm910+Ak/BS+uWSFnFu/LHODg6IEVfwot4qE1BI6gQBvQMGAWUx6/hAbG6U=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SJ0PR10MB7691.namprd10.prod.outlook.com (2603:10b6:a03:51a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.35; Sun, 9 Jun
 2024 18:08:21 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%4]) with mapi id 15.20.7633.036; Sun, 9 Jun 2024
 18:08:21 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        Vegard Nossum
	<vegard.nossum@oracle.com>,
        "oberpar@linux.ibm.com" <oberpar@linux.ibm.com>,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [RFC net-next 1/3] .gitignore: add .gcda files
Thread-Topic: [RFC net-next 1/3] .gitignore: add .gcda files
Thread-Index: AQHauHLAUyRnt0obgUCCy07TLhWslLG/vx8A
Date: Sun, 9 Jun 2024 18:08:21 +0000
Message-ID: <aeb176fa6781f7004b705ddecf1b02744be4f8fb.camel@oracle.com>
References: <20240607003631.32484-1-allison.henderson@oracle.com>
	 <20240607003631.32484-2-allison.henderson@oracle.com>
In-Reply-To: <20240607003631.32484-2-allison.henderson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|SJ0PR10MB7691:EE_
x-ms-office365-filtering-correlation-id: bee1e0cb-ca52-4315-4aaa-08dc88af25a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?SXFRRDFLSFlvYVkvcEVQL1MyREVEMHlMVlhGT090Y1Z5dXUxSTdSMlozekJZ?=
 =?utf-8?B?Zk90bThHTVJWMzIwNmtVYXBUNzd6YkQxcEhwZHlxRGNOL282RzlPK04wSVJO?=
 =?utf-8?B?TjdoV29HZ1BuejdOaTlkQnMrdnV5b1owaXFaSnYvOWpCR28xRlNvcytzcVcr?=
 =?utf-8?B?UGg3eTltbWZWTjV1SmM3dDZEYXBmZEdRUzZnWFh3TFJVKzFoSTZtaVBtS0oy?=
 =?utf-8?B?RVRTV0phdlAxMUhGRml3SC9MaEZyWkNNWXZ1aUYvalkyVEIyZVdnQTFucVhv?=
 =?utf-8?B?QldQTE5JR3Mvd3VOSnJjQUNRWHNyQXZsRit0RWZYTWFXQStzRWNFaG5tYmY3?=
 =?utf-8?B?V1VmZ2JWc3VURVJ6WUNxVFJiWnlHUlcyZWZTL2JIY0VZR0t0RWQyczFKOWFv?=
 =?utf-8?B?WEtOaFF1eVNqamE4Nm1qdU1hNWpwOTdOZWxhTHJHZ2pFRjBHN29sSkdaS3ZN?=
 =?utf-8?B?VFR3L3czUGlVVXBaN1RGdU91bXp5YlJWQVFmOVE3R2dnQkREVEY5cmF4UU52?=
 =?utf-8?B?VlRNUWtuVCtWV1BQYXMvZkxUbnE4WnB2YitRd1BsMGNJbm1vUmhzYkFYTWlh?=
 =?utf-8?B?dWdLRVVHWU45WTJaN2haOVZZL0dQalBUTmcxYkpYcWxXdmxHdTRkTXdlRHE5?=
 =?utf-8?B?cmtHOVJ2MTdhZkVxMUpJREVBa1VVSHJVZlYvQTNkN0hONTNRQmV2QmFuVjJQ?=
 =?utf-8?B?ZDVYYmNjVThkWG8xbEJ2YVhLdE9aYTBvKzU0UC9ValluRHBQYzdwYkZWZ3B4?=
 =?utf-8?B?SU1OaVJKNFZjVFdHSEQ1RzNvb0toTEZ0QVNoL2hLenNLblBOUzRMalZQZG9a?=
 =?utf-8?B?cHNkNWozSS8vbjZUd0ovaVJuYXg3emRqTTJZQWI4T1pkYnM3dHRMaFZRaFAz?=
 =?utf-8?B?MFlzV3g3TXhSem9vNXZrZ0pKQWFJd2pZSVZSK1JLL2pBVXVuNnZCMkdiNWJy?=
 =?utf-8?B?ZnY4V0RuaitJZGJkK0taUm5sbEtQMHVGSmxoQVlFWWcrR1V1Mk9SYkJaeFJL?=
 =?utf-8?B?R1g2Vy9XTzE2bEMyVVJNNUhlQ20wVld0YVBCWTZZbmRmZ0FOdDJ5cnUyQzZ2?=
 =?utf-8?B?TEw4cjU4QjE2TVBBUzV4TkJ3akdFM2dQeVE5SXNLMWU0blNhaGVLZTd3YmFt?=
 =?utf-8?B?R1hLQXVTMnN0Nk9NZ2xPVDBMcUhJYVkyZ0owMnVYeTNpWVdzZGVIcmpTK3dx?=
 =?utf-8?B?RmU3aSt1YVA0c0dRczJvMlF6RnRaMUdoK05laFQvemVBeEdMNkNKSytieFpE?=
 =?utf-8?B?ZVFuTTJDZ3lSQ2RsNWdWV1B5Q0NWWXNuaDVkbkJoaDBLclBPaFhhMnpjdUpy?=
 =?utf-8?B?OTBtNEZ3NnVUZkVmQlhTajRqUDV4OGhReitHcnUyRllEYTFqT00vVGVVUFdC?=
 =?utf-8?B?aWJLaHV5ekNBK2gyYkhYRHM5L3F3NXBsaitSS1IvMGNFSWY4RS9rTUlFeFVX?=
 =?utf-8?B?SHYxN2s5Q0crUnlyb00vVFJid3FjNnVodUlXYkdjblFWcW5KajY5MlBDVE5z?=
 =?utf-8?B?Yjl4d1dCNVFqd2gzdjZnSGh0d0xFaWVYMHN4bWRZQ3g0ZXpmWTl2WGtBNmU1?=
 =?utf-8?B?MGFUMXFEWWpmMjRTTFpwVkZiYTJldU52UU90NWZFVlN5cHdTaEYxMlh4YkFa?=
 =?utf-8?B?bmpCWmo4bzEzZ2hmTXhoeFk2a2pyQS9jZDJxYlZpUHRQajFNY29KcDdZcEly?=
 =?utf-8?B?TzhyZUdWaVV1S2g2R2tPRDJtaEVPV0FsZW0yOFU2MU9WV0QvODlmNk9XSE1U?=
 =?utf-8?B?Y0pFT2pQZGVFcVhZRUExWlhtTFc2Q0pES3E1elZ3UjcvWHZ1NllNVU8xY21m?=
 =?utf-8?Q?BnyVGhQRLsSpYZnOxbUivyzSBcNzpLKIcbzGI=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?d2hzK0ZGOVhlbFJqM01jQTVXYUJEQmU4LzJSLzV0V1BrdFRBanhaQW5ISlRw?=
 =?utf-8?B?TjRNRmQ5V1p4RWw4WC9IcFczeCtUb3NDMjVQTEU2WmwvZWZ4RnRxRVJzWmFq?=
 =?utf-8?B?NDdHaVdHelB4Nys1dlFTdjZZbmVSdVBVT2JUQ2xabG1lZ1l6ZFR6dlh0bGhi?=
 =?utf-8?B?U0pYaHhzYjcyNmh2eFErNGM5SS9FUElqMjZQanRYVi9JT2JJSGYwSlRGUFgz?=
 =?utf-8?B?UVRvb0tHdXVvWjRDQ3Fnd3c1M3l3WWxuVGR0TU9NaGZDandEaFVBN2ZQT1dK?=
 =?utf-8?B?MnFUVlJGaGZqMWNWK25rc0FVMEZnV1ZmeXovSVJWTlJvVFAvODJzU0ViWnV6?=
 =?utf-8?B?S2ozcWcrVWozYmJDOVN1RFVpUTVvOHB2MVVpZ2RIVXRwazlpQjZDRzFKSmR6?=
 =?utf-8?B?NDRQeWFnL21PbytOUngxaDM2YVRiUER6dEFhZEkybFl0cXExWmdNeHZnVk9C?=
 =?utf-8?B?Q2xMSldDc1Q4Wm8zTWdKclAzMG1aQ0xpdFc4YTdhdG1tZEpUTTFKdmJWTUty?=
 =?utf-8?B?ZkJMeVBJc1NqZE9hejlBaC91SjZqN21pendFQ0hzZkVSbjlaS0hxNEhVUzdV?=
 =?utf-8?B?WG1jb1B5eWZGY1M4eUlNNWh1YjJWWTF1ZENDNWtyMHIzV0FoWEthRlR2U0pa?=
 =?utf-8?B?cHNwektsbldJSkFabTJPK05WTHZGMkwyVWE1VE1jbGJiVGFUcWJQeG4vc2tL?=
 =?utf-8?B?cVFUNFdseWZ4Sm1LZnJjaVN0WEtXejkwOXp1YW5LNUttSXhLNlZzc3dDcWtD?=
 =?utf-8?B?dGh0cWxPSDBtaXhDT2cyZGZKQVdqOUxhZUc1VUtpd0dKSi9qSno1b0RxQTJw?=
 =?utf-8?B?bXhkbHRDdk1ZQVp2MUs2NHRXM0xOM2plbWNrN3R0dlhnRXh2Y3ZpcDVvWk5z?=
 =?utf-8?B?NnY2SXlkS2xzbVpKWUd1QXdGdHNYTFFGZ3lTVUVweGptRitkT2FYYmM2d3FH?=
 =?utf-8?B?NXRFWEdsYzA5bWwwdjRiREdPL2ZMRmZLWEFxK0VPL0VHOVFML1VudmM5UDky?=
 =?utf-8?B?aDJSNDhnSzc2dENHb2FKM2NVQ1NpZGhOR1dIN3JyR0hYYXZSUDVTQU51Y3RK?=
 =?utf-8?B?NzUxdkJnUjAxNEtzaStJOXpwRytRSGJKYitZcFhGODhvTFAySFBndU9OOFhh?=
 =?utf-8?B?NXRLVzROVGsrQnJOSXhjRzc1Ym42cUJqOHBXSGx4UkxCUUt1aHBtVUFwbmZa?=
 =?utf-8?B?bHp5dGRMdCtJWTlYdnRZbHc0UGxxenM2eUpUM0IrNnNGR2V6bFlvSGpkY2xz?=
 =?utf-8?B?T3Z0R29SSlAvK2RPMmZrbkxYWmtyMXBlL3pxd1hCdU0wa3hLZkdwTXBVeTd1?=
 =?utf-8?B?TjV0b2pTMzd6YTdrdW5Jem4zZnNuUUJCMmduN3dzSXdyYjdadERpTkpYeGZz?=
 =?utf-8?B?KzcrZ0tuZzR1M2VKb0p6OHBobnZqdlh2Q3c5TW5IZFRsOXVTTlh4R3ZzTGwx?=
 =?utf-8?B?dDh5ZWl6R2VxUFViRXhQRnJ3OFFxZFdrMDZOVDZQL2F2QmdOSEVOWWxuUnZ1?=
 =?utf-8?B?eFNKVmZ3bWtFVVNTaytYOFUrcG9KWWc3T0RGQ3NNTG8yWURLL2wwM3k3TEZt?=
 =?utf-8?B?UjBiMW03L3J0TnNaMUhDUmlaWStaKzJ0RTAyMi9WRTVoWjJFN0JkMHpZNFBP?=
 =?utf-8?B?TmMwRWN0dVlkL2VLZW1oNWQxZ3BhMmkwSFlPazlHT1Ixem50dUJJakMxazJo?=
 =?utf-8?B?U3lCNVZkWDJ2VFlnRVhTL3lueHlhNnBJVmIxcktkZ0p2RFVPWGhaNVdPMlFH?=
 =?utf-8?B?c0ZNVFJUYkI5L2N4UW1wekRuOUp4dkRiNjZJNHVZVWZVZmpvZ29CejdOaFUw?=
 =?utf-8?B?NC8rNzhMZ1BqMEJWd24wV1ZHSUJNei9QZW0zbHFMaWJveGpUVkRVeElnczJK?=
 =?utf-8?B?RmNGV2JHUlFvU2tTTENhdGozcXlCS1Z1U1hNNmdZeXNnZWlsbzV5U2hKSm5O?=
 =?utf-8?B?YWdsQncwajBvVlJrK2NBbWI0eEJEdlFITHNzdm1jT3hweVdQVjhMV3U3QjhW?=
 =?utf-8?B?c0RjaVJLNzJlMkQrVGMwd2tPbjIwdHBnNm53cjBuMCtHZlpNS21mY0VIOGE4?=
 =?utf-8?B?SnZKK2p6ZTFFSVF4NllDbkE4OGRsWGtKWk9DWUJTbXNQeit1Qm84RW4zRWxh?=
 =?utf-8?B?UExDZTRWTzZVWjZ1RFp1alhXaEFuQ2hZVElIQ2lWU1l3VHlUblVodEs2R0tE?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A65836DF7773A14A9D5EAA0A7A5049AF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dNsSi1zS7Dk4qJNXSC5jV8WuWtcQiicCQf1IE2angqfo6ZJhkxENV0vKo73xDf7J4icTZReMu6bjTYX0/Sz0khUKxeFpt6uet0RRZ0DndToCymy7CrLukp6r30WRDPKmpprFkmNC/oKowu9K0CrXyruPdDtHdvWFUl9CGGZzkC/bmJYFYGjo+c8+IP8nMchhCXeZJP+Md1wvpjMxTCzMchWTxmu4LkFZ3OK1q9fGMxmPF7uYFvPKUi994NZTkGFdf+mH7CWN0+Tg2yEvSsC52GLFwwwikMzsBX4uIEqjY8+2gGXSAvKy+9+expTP45x+6ihc9qQm5vQx4OtsAMXJSkBgpdntXCuJsk+xVhE/FuAtnpqUpk451kxDO7PPmFa6KSZyyMegc9lO4OGuHa7G0ps5heL3q4SVUK4Z0X/Rp0cp8JT5YB2wiJxht4gR+BcIE9zKPzYG5Kf48yZUGzVwjgGcTXiIzPSlZWUFTi6Sxl9mzu0yHu0n8ypUldN9HUuXDhGAvBkGCxcTdoqmFqDmi0cSO5sOh0iOUjj3CrSjBiwjRYadohkqeNtj4sC10JqIlFhTDdgAMs4GOdAXeIExxjTooIaloaW5JU0sXytlors=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee1e0cb-ca52-4315-4aaa-08dc88af25a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2024 18:08:21.1472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bHrLxNsiQu4Ik6krxVXfEuLKxJqyUJ6I2ttyVSSgldaBCXGT3h7fyj7a2AM+HTWbZCyx24GtFEzLr7f6Bdpi4CoQRtvGjeKIOYJ1km2zVrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB7691
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-09_14,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406090142
X-Proofpoint-ORIG-GUID: vYVKsmRQZXrqT_QVuT_SLXUmcdx95SV_
X-Proofpoint-GUID: vYVKsmRQZXrqT_QVuT_SLXUmcdx95SV_

T24gVGh1LCAyMDI0LTA2LTA2IGF0IDE3OjM2IC0wNzAwLCBhbGxpc29uLmhlbmRlcnNvbkBvcmFj
bGUuY29tIHdyb3RlOg0KK2NjIENodWNrIExldmVyLCBQZXRlciBPYmVycGFybGVpdGVyLCBWZWdh
cmQgTm9zc3VtLCByZHMtZGV2ZWwNCj4gRnJvbTogVmVnYXJkIE5vc3N1bSA8dmVnYXJkLm5vc3N1
bUBvcmFjbGUuY29tPg0KPiANCj4gVGhlc2UgZmlsZXMgY29udGFpbiB0aGUgcnVudGltZSBjb3Zl
cmFnZSBkYXRhIGdlbmVyYXRlZCBieSBnY292Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVmVnYXJk
IE5vc3N1bSA8dmVnYXJkLm5vc3N1bUBvcmFjbGUuY29tPg0KPiBSZXZpZXdlZC1ieTogQWxsaXNv
biBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+DQo+IFJldmlld2VkLWJ5
OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
QWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+DQo+IC0tLQ0K
PiDCoC5naXRpZ25vcmUgfCAxICsNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS8uZ2l0aWdub3JlIGIvLmdpdGlnbm9yZQ0KPiBpbmRleCBjNTlk
YzYwYmE2MmUuLjhmZjFiNDEzOGM1NiAxMDA2NDQNCj4gLS0tIGEvLmdpdGlnbm9yZQ0KPiArKysg
Yi8uZ2l0aWdub3JlDQo+IEBAIC0yNCw2ICsyNCw3IEBADQo+IMKgKi5kd28NCj4gwqAqLmVsZg0K
PiDCoCouZ2Nubw0KPiArKi5nY2RhDQo+IMKgKi5neg0KPiDCoCouaQ0KPiDCoCoua28NCg0K

