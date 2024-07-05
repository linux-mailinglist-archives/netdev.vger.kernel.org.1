Return-Path: <netdev+bounces-109436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 567AB92878C
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8090B24172
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 11:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FA0148844;
	Fri,  5 Jul 2024 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="VLepuhz0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F081482F2;
	Fri,  5 Jul 2024 11:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720177979; cv=fail; b=ghMbsxeyPeArZbEwey5wn2Z71DdVwbpTA36Hb8auGe51Y0DHs03Z7VyXRQt0qkCzr+Bnm+Y4pI+3ML6VpjmKDwW88UcuHGrPjSHZiVV/W9qE3pkFnrpIy8HBrrhKr3Eo1o8l5jPkHAhVmdZh1FA5dapjnrDmzkrHL22GplbEZPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720177979; c=relaxed/simple;
	bh=gcvoDbRd7FpJ7zY6I1Arxz2t+d4GlkvnlWRCd/6phv8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=VOQqSbGupW1V0RAOV6A6AqGaqBn2jYjoOxlMC1g6TrWwch4dVccTcFo4UQzdVgQc8htL0LYaRDZsWXwFBBRY7e/paafaKdjKxjissenPH5Vqhim0aFKedRlu8QVO+V5Evza1eVXmy+4AG6hR9qzV+SD0/SHZoEyn6KJH9rEO0Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=VLepuhz0 reason="signature verification failed"; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464NkmBU003330;
	Fri, 5 Jul 2024 04:12:49 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 405s2ebjpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 04:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOihDpCGha45w/LCnwxMHlugLzwIuygPVjpaNcdmWmz8m8eC/n9uLzmbib/BqfzWpbVl7eLTzIlxeeWkehuXBCAQTds0q4WP7UbJmfl/3jlmzLdFxnZzMw02I5488MH0Nwp7Dy7GMH9p5LYvW4PNBmsIBBTMcs/rHP2ls7sk6V1FUzyIaFCOPt/+gOrt5xJwt7d97xWCkFnIJcnbb7+ak+qRX5C7UXAtwwsYKAlP1pVtp4+y6S6u+8aWg4kLjEnz5UfPQMxha/i4voHPfY4SzJfTJ9g0obgBAL2y8I8UUv60ORJUX5dPgMV5tB7X5QnVhCLdg2jDs7ddtNYEZglUew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lre2zWFvPzXY4z4wuTB5dJl/uRQ6HUrQHVLX0kbViDk=;
 b=Y0ehIL/UJa/PUtZV/upODXVozY6/m9sG7XHG6b1Uin7tWYiinQ+0IL044rxcP4n0FecNGNzQW+dAjG2cVSwNrRD2cbtRXQM6rhznMfIAa3ZVssolfzBc7BXsxI2AtKoH88gjd9e88AyYMBbCSggPixqCci8lp5KgnvoalRNMFAmgpHsBbhBL3LkjGgixPraseXaR9aZxd7x9O8/cLBq6qLurq4msX1NWH8GPP49mGEgTV7Lw2XpPdcJ/R8hSqvY6o2+SGLTGPRZs7ApQOpQ91KK1kEsGW81oAC3pbD/IPYQEWOwqot/V59gMmJfX85ZJ6+06AupzyophgcV4xpyo5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lre2zWFvPzXY4z4wuTB5dJl/uRQ6HUrQHVLX0kbViDk=;
 b=VLepuhz0OcGUqe2O1aFaBCYkfgmP0tG1Y34pC4g8RDYXuk/kGG5U+ZLnzN21ch3lNwY/Ul+PYwhewepTHY4IcEZ020+lsPnfF7VnNwKdvIACpAlYqWvsuVYRw5r9I8qyPI5lXwvJWX51REuIF2sXtMXhjrw+fY/XNR7E2bJSdfA=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by MW3PR18MB3627.namprd18.prod.outlook.com (2603:10b6:303:5c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 11:12:46 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 11:12:45 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v7 00/10] Introduce RVU
 representors
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v7 00/10] Introduce RVU
 representors
Thread-Index: 
 AQHayWAH5wurYZD5Kk24R5BnL2IOPLHk2TOAgAA9MfCAARqVAIAAaaaAgAE+z4CAACeOcA==
Date: Fri, 5 Jul 2024 11:12:45 +0000
Message-ID: 
 <CH0PR18MB4339666BBD106C2EEF590E57CDDF2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240628133517.8591-1-gakula@marvell.com>
 <ZoUri0XggubbjQvg@mev-dev.igk.intel.com>
 <CH0PR18MB4339D4A85FA97B2136BF7E1CCDDD2@CH0PR18MB4339.namprd18.prod.outlook.com>
 <ZoZL7Hc5l3amIxIs@mev-dev.igk.intel.com>
 <CH0PR18MB4339C05B5CC43E7005F2D469CDDE2@CH0PR18MB4339.namprd18.prod.outlook.com>
 <Zoev+zu3WXyPZ8Hv@mev-dev.igk.intel.com>
In-Reply-To: <Zoev+zu3WXyPZ8Hv@mev-dev.igk.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|MW3PR18MB3627:EE_
x-ms-office365-filtering-correlation-id: 969077fe-15f8-4d2b-5184-08dc9ce365bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?aGZSM0xoQmhHTEl4WlFoUHdoUkhjdnJXVmJTSGsxSUlIaXAvUDBDR2lmYnNC?=
 =?utf-8?B?TTlBRm9SbVB5Z0NWM05Cdm9IRzJSVnJ5TWhNdHVZbmRkazgzQW8zWkFDY21N?=
 =?utf-8?B?c09TaTlDSjVLYzBqdHdxM2R4WlR3aVFFZGNKT2tGMXRUeVR4b1krQXE2K09M?=
 =?utf-8?B?Q05zSzJGL2lTN2pBSUZ4MWczckJzbnJQNGR5L3VVSDROUm9mMk5mZ292V2lw?=
 =?utf-8?B?VGFsZzcveVE1WWEyWEg2aFNxL0hYUk5kVThENVQ4UnJ6VUxjMlVzWithZnFl?=
 =?utf-8?B?OG9qc3RzVE5RQ2M3TVFTMFRRQlpOSUpDK3ExT0w5TlVMWGdMSmhsaDNTck16?=
 =?utf-8?B?U25NdjlTelZYWjd3NlF0UkFDVUVLQ3hadDBRYXVIeGsxQU44ZG8ySlJ1QmtR?=
 =?utf-8?B?cHpOZ2s1dWdIOGZLTDhoS3ZFUSt3akZHem1jenlyOGRteVgrUXZiSjlpbXVy?=
 =?utf-8?B?SFZoTmhhZHdDUksrcEg3Z0tpYjNaKzlPM0tqUzBkZ1lPNjdnZUNpUUkzTlZY?=
 =?utf-8?B?QVAwcVRLRElHQ0hCQmFYWXptNzFxK0RtZURXcW00SjVBQk1RVnZhcFJmTXp4?=
 =?utf-8?B?NStubEVZK1hGb1Y2anFjVVQvOE43NXhHMlFKdDNzWTk5aEpsR3NRVks2SHRk?=
 =?utf-8?B?MkhHVS9hL0hjaE9NV3dVbmFBdlNDTHRTMU9TdTFDa05jdEJGbCtFQitkVXlO?=
 =?utf-8?B?MGM5RDdPTFNtcCtkcnN4ZGJRQlBKbUtIR1Y1ck9hSzh2a1AvRWQ1NnhVNGRv?=
 =?utf-8?B?SVhINnFwYjdyeVVtMXFQbnhvY0V6ekZiTDlSS08xQ3UrTlk1dWZoSElOTmc3?=
 =?utf-8?B?RHpSN3plS0NXelFYVzMvdWhoajRodlcwZHhYdU1ZQVRsaHEvaHVUakh5ODYy?=
 =?utf-8?B?Mm5LbG9kL2x5ZTgwazFoSU9wRjdCZDIvZTNjMTNpYUdMazRETHZURWxoSlFa?=
 =?utf-8?B?RmtaMHNQZ0UwVVZLQmhMNUVqSWQyM0lKVnBTRUQxSEZad1BtNG1TSXFRZUI0?=
 =?utf-8?B?TkxzL1NGS1h3akdGQ1ZaK3FqR2VoNE1IeXVMQndUdkc0V1dPcHkrekxobXdS?=
 =?utf-8?B?ektoNUFCSnpIL0FQaHFubGxkMkZXUmJRQU1Haldzc3BMNlNEd3N3Zi9ZR3M4?=
 =?utf-8?B?UEp0NVdkS2Q1K1lJK0wyR2gzRGJMVmU5VW5SdksyL0I0ZmlLUU9TZTlEb3lj?=
 =?utf-8?B?MUdpOFRVMEdJNTZDYVhwQTYyMit0Y3BjaTVmMmptNnBSbERaNkIrRzl3TzNP?=
 =?utf-8?B?alA1Z3F4cmRscVQ3aGd4eHBOeWlha2xGK3hYbjRQRW9mNXZtVVViUXVrUUVw?=
 =?utf-8?B?TW9DQ0hreVpKWDVUaytXYnZNdFBrMUFpakMrUkFHSEZTRFhJcjMzb0lzUEgx?=
 =?utf-8?B?ZXgwL3pIMUVuRG5PalpKTko4d3RIdGxjQ2JLbGR6VHNLTTlPVVIyV2x1WW5B?=
 =?utf-8?B?WEU1MU92Wk02SDBMeklJUm03V1pkQ3hpeHY1dmJMZlBNb2NUMkViM04zdUNO?=
 =?utf-8?B?YW5oRkxQVWowT2JOalJzSlhVU1NtM2VlQjdRdkRVQzhxS2tPTU16RVJ0dXZE?=
 =?utf-8?B?R0M4dGUrQWdFL0tMNnRpSm4rTTBrYmtWemxuMVA2dnFtRm1oUmJPR1ZMbDgw?=
 =?utf-8?B?dU15cE9PTnRlbU5DaG9QQzRnKzFrTERJdGpIMHRMVjlJOVAvQjV4S3k2OWVr?=
 =?utf-8?B?OUYxVG1qREZOSko4c0RRYmFtWkJ0NzVtOVhFamx3aXY4MjhSblJJVUJPRHZW?=
 =?utf-8?B?QU1ZT2lJVS9VMUhNdUE4UC92WFVNTEFpa2hWUTJmd1Q2U3QwbklmRXh3T0hB?=
 =?utf-8?B?UGpZL1lZOXprZXZBdWxpZjNvQXVINE9XZVVrLzVJdXJ6MXVFU2FxdnE1UU04?=
 =?utf-8?B?bTV1bXZBY0FRRTRBdzBBd2FnQjJGY1Q3WTlaSmR3RUY0QUE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bU9xSWVKNi9KS2VKajJXTWhrekQ1MWZpb3hRd0l2d1RvTGljdXNvcmRJVTla?=
 =?utf-8?B?NHFJK1hMallGa3lQYnd4bEE1MExaT2NFak5BbXBVRGJmQUZYQjdPV2pXWTlo?=
 =?utf-8?B?ZktEekNWWVdmOGUrdThmUTl4VVd0eDUwVWFyQXlObGM1S0pQaWpCeGUwR01H?=
 =?utf-8?B?WnJGZ3h1R0JkZ3pVamp4VHQzWHhCUisySnlpYTFVUzhOUUVjbU5KbXVSd2Zw?=
 =?utf-8?B?Y3ZEeUxrMkVhUzhTTm9iSkRkZDQveE1Ydno3bCtOVXE4ZUdDcm5rMDZvWXFH?=
 =?utf-8?B?YmtXN2FBbU11SEF1TllyRlluUXBqb204aDRrOVdtL2t6c0M3Y2FnL1lDZ0d0?=
 =?utf-8?B?d25BdzdSV3NMOEVMaGk5TW5yMk5kdzFuTDR5WS9NczFZR2I4VW9STnZOQmtp?=
 =?utf-8?B?ZFJ6LzM1UWNPa01KbGRjUEhDQ095N3B3eHRWbGJqdWRnZlVzU202aFFhRk5h?=
 =?utf-8?B?M09OcFdZVjl5S1VPK08wWE94OW1Zekszam5rcjdEZTZsdUtXUjhZRkRDakc0?=
 =?utf-8?B?dmJVaFg5d294aUtROFcrSS9mMjFYb0F2WEdESXBta0xOMERlKzBGMnhGMWdw?=
 =?utf-8?B?QkpEVHNZTi9mNnFUNDNYYWp0b2prL2VEZXJ1Q3dCWVA1aElramZmdWsrUVBJ?=
 =?utf-8?B?Tm9pcDEwaEw5SHNlam51enBVRlJJMUR2aWFlWmdXOTVjL2JUcUdSYU84VXZq?=
 =?utf-8?B?RUhmcnZQeis5SDhVUjl6U3JNTE9yZjdsU3NmMnVUWlZLK24vVEt2cTEwNm5Z?=
 =?utf-8?B?RFZVVUpRNEJvZXdoWVlKVE4xUmZqZGIxa0V6T0J6WTR4NUU3SkpqME5xR0RI?=
 =?utf-8?B?Z2RpVzdUeEttUTA5eFZmdjNFUGpZUGtETXQvSUgwSjRrVVZkN3IyREN5THJp?=
 =?utf-8?B?cWlaeDlUUWhpODNqbk96VUJoOWRBR20ycmtsa1RTUitvbGw1SUtlblZwNmh6?=
 =?utf-8?B?WlRtWWd0WTFFS0EwTEttWkhkZmd0blNIL2tFZU1sRU5qMUtXU2o2SUJ2WWcx?=
 =?utf-8?B?TzBHZVFFNmpxZ05pRjBxbnZwUDZBNTZhMDlEN1VUUUVieGxicTJxeFYrc2Ji?=
 =?utf-8?B?ZUxnZUtoVWwvVnNjSkNSbEVTV0hidC8vVDY4ZUNTcTEzQ2hmUXNHMGNmQmRV?=
 =?utf-8?B?ZSsrVE5jWFpUL0kyeG1jYzFGQ0Q3OHowWDhLYzRPSjhYbWNhb3F2VFhpN1ds?=
 =?utf-8?B?a2grSU0zSThISUhvQ2dXTTNTSTVrS3hTQ3BuRGovbUFqanNwY05VNWFxZTVl?=
 =?utf-8?B?dTVLN1UvZ3YxYXAxTVU5WU1OOHY2R2d4MWtUZjl1REJiRnJwSEpndjNrOW9U?=
 =?utf-8?B?RDNHU0huajlxZ1dKRDhDWmdPT0QrRERORnpIKzljMlkvSC8xaGNQRkcyNkl3?=
 =?utf-8?B?OU9zcG9DL2hnMjNvM0dWZndZUlo4SjZkVTA0bVQzaGhzNnVFTUxsNWJrdXYx?=
 =?utf-8?B?ZlYxSVlDSTlVdHRhbi9IQnNIZU50dm9oMWl4WkFqMTVsbHBmL0t0cUkyZ25E?=
 =?utf-8?B?ZDFNdlJmbHplbHlBOXQrcFJjbmVyY2VwWFVRMU90RlhSM2hRL0dRUU55ZjEw?=
 =?utf-8?B?OTVGM3Ivd0FJUGpCcHhLN08xRWw5YmZZTDRMNDZkY2djQUZtdkYvaEE3djNZ?=
 =?utf-8?B?aUc3c09YQUF4Wmpia2UzVVFpUnoyQ0pMUVdFSFBhaFdrbG9PRStUSU5DU0Z6?=
 =?utf-8?B?TmVTTmZEQ0toeTRZZzg0dXcyMkZXNGNlUnBJUmt1R0gzQml3Uk9UOHFqbk93?=
 =?utf-8?B?VGVNR01aRFhsZ2hHNWZxVExZNGJuNmowMmVCU2FPcGlkRURTV1I4S2M2bnpP?=
 =?utf-8?B?S2JSeHdYak9Wb3NvRXA5djV6RGNpOTByRld2eUZ0QVd6Y28rUlBMZjh6d3M0?=
 =?utf-8?B?S3FsZ3BiVDFXUThKQytvY3QvNEdWaVR4R2d3dCtFeXdRbmlhN0Qva1BKczA4?=
 =?utf-8?B?YlZVN2R0RUhmQnVuVUptMFRuTDZ5bWdVL0trQXVnTE53ZTU1NlFiRHUvUDhV?=
 =?utf-8?B?MUJpdXk2S3FCSDhsb1hVOGtXVWt4SHlNVXIzbE1CMlI3UlFndGVhbnFVaUdj?=
 =?utf-8?B?NlUrc0ppSkc1Vi9mWmdGS3J1U2VBU3ptdDJqYy9kWDlCYmhtem9aNzBDNUJn?=
 =?utf-8?B?Z2d5YnVqZHBaZm82a3JzOWU1K3VZck4yazU0OFRncWlXeTlCbnpxL1FoQXJN?=
 =?utf-8?Q?ZZZ54wSDdX0NEpJc0qsteloJ3OZrPFL1c7u5fZICMoe8?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 969077fe-15f8-4d2b-5184-08dc9ce365bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 11:12:45.8099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XKYC1qi44zO/mb3iG1RQxes88e+Q0OaYJjjmlgDqon8a3g7X5OtDLfD/ww+eLtC9vNjhelye6kr9zNu/RV77vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3627
X-Proofpoint-ORIG-GUID: DWRzqg4devHmiLHaq6AqxgCLV_yy-BqC
X-Proofpoint-GUID: DWRzqg4devHmiLHaq6AqxgCLV_yy-BqC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_06,2024-07-05_01,2024-05-17_01



>-----Original Message-----
>From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>Sent: Friday, July 5, 2024 2:04 PM
>To: Geethasowjanya Akula <gakula@marvell.com>
>Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org;
>davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
>Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
><sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
>Subject: Re: [EXTERNAL] Re: [net-next PATCH v7 00/10] Introduce RVU
>representors
>
>On Thu, Jul 04, 2024 at 01:=E2=80=8A48:=E2=80=8A23PM +0000, Geethasowjanya=
 Akula wrote: > > >
>>-----Original Message----- > >From: Michal Swiatkowski
><michal.=E2=80=8Aswiatkowski@=E2=80=8Alinux.=E2=80=8Aintel.=E2=80=8Acom> >=
 >Sent: Thursday, July 4, 2024 12:=E2=80=8A45
>PM=20
>On Thu, Jul 04, 2024 at 01:48:23PM +0000, Geethasowjanya Akula wrote:
>>
>>
>> >-----Original Message-----
>> >From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> >Sent: Thursday, July 4, 2024 12:45 PM
>> >To: Geethasowjanya Akula <gakula@marvell.com>
>> >Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
>> >kuba@kernel.org; davem@davemloft.net; pabeni@redhat.com;
>> >edumazet@google.com; Sunil Kovvuri Goutham
><sgoutham@marvell.com>;
>> >Subbaraya Sundeep Bhatta <sbhatta@marvell.com>; Hariprasad Kelam
>> ><hkelam@marvell.com>
>> >Subject: Re: [EXTERNAL] Re: [net-next PATCH v7 00/10] Introduce RVU
>> >representors
>> >
>> >On Wed, Jul 03, 2024 at 02:=E2=80=8A34:=E2=80=8A03PM +0000, Geethasowja=
nya Akula
>> >wrote: > >
>> >> >-----Original Message----- > >From: Michal Swiatkowski
>> ><michal.=E2=80=8Aswiatkowski@=E2=80=8Alinux.=E2=80=8Aintel.=E2=80=8Acom=
> > >Sent: Wednesday, July 3,
>> >2024 4:=E2=80=8A14 PM On Wed, Jul 03, 2024 at 02:34:03PM +0000,
>> >Geethasowjanya Akula wrote:
>> >>
>> >>
>> >> >-----Original Message-----
>> >> >From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> >> >Sent: Wednesday, July 3, 2024 4:14 PM
>> >> >To: Geethasowjanya Akula <gakula@marvell.com>
>> >> >Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
>> >> >kuba@kernel.org; davem@davemloft.net; pabeni@redhat.com;
>> >> >edumazet@google.com; Sunil Kovvuri Goutham
>> ><sgoutham@marvell.com>;
>> >> >Subbaraya Sundeep Bhatta <sbhatta@marvell.com>; Hariprasad Kelam
>> >> ><hkelam@marvell.com>
>> >> >Subject: [EXTERNAL] Re: [net-next PATCH v7 00/10] Introduce RVU
>> >> >representors On Fri, Jun 28, 2024 at 07:05:07PM +0530, Geetha
>> >> >sowjanya
>> >wrote:
>> >> >> This series adds representor support for each rvu devices.
>> >> >> When switchdev mode is enabled, representor netdev is registered
>> >> >> for each rvu device. In implementation of representor model, one
>> >> >> NIX HW LF with multiple SQ and RQ is reserved, where each RQ and
>> >> >> SQ of the LF are mapped to a representor. A loopback channel is
>> >> >> reserved to support packet path between representors and VFs.
>> >> >> CN10K silicon supports 2 types of MACs, RPM and SDP. This patch
>> >> >> set adds representor support for both RPM and SDP MAC interfaces.
>> >> >>
>> >> >> - Patch 1: Refactors and exports the shared service functions.
>> >> >> - Patch 2: Implements basic representor driver.
>> >> >> - Patch 3: Add devlink support to create representor netdevs that
>> >> >>   can be used to manage VFs.
>> >> >> - Patch 4: Implements basec netdev_ndo_ops.
>> >> >> - Patch 5: Installs tcam rules to route packets between represento=
r and
>> >> >> 	   VFs.
>> >> >> - Patch 6: Enables fetching VF stats via representor interface
>> >> >> - Patch 7: Adds support to sync link state between representors an=
d VFs
>.
>> >> >> - Patch 8: Enables configuring VF MTU via representor netdevs.
>> >> >> - Patch 9: Add representors for sdp MAC.
>> >> >> - Patch 10: Add devlink port support.
>> >> >>
>> >> >> Command to create VF representor #devlink dev eswitch set
>> >> >> pci/0002:1c:00.0 mode switchdev VF representors are created for
>> >> >> each VF when switch mode is set switchdev on representor PCI
>> >> >> device
>> >> >
>> >> >Does it mean that VFs needs to be created before going to
>> >> >switchdev mode? (in legacy mode). Keep in mind that in both
>> >> >mellanox and ice driver assume that VFs are created after chaning
>> >> >mode to switchdev (mode can't be changed if VFs).
>> >> No. RVU representor driver implementation is similar to mellanox
>> >> and ice
>> >drivers.
>> >> It assumes that VF gets created only after switchdev mode is enabled.
>> >> Sorry, if above commit description is confusing. Will rewrite it.
>> >>
>> >
>> >Ok, but why the rvu_rep_create() is called in switching mode to
>> >switchdev function? In this function you are creating netdevs, only
>> >for PF representor? It looks like it doesn't called from other
>> >context in this patchset, so where the port representor netdevs for VFs=
 are
>created?
>> >
>> RVU representors for PF/VFs are created when switchdev mode is set, simi=
lar
>to the bnxt and nfp drivers.
>> rvu_rep_create() will create representors based on rep_cnt (which
>> include both PFs and VFs count)
>>
>
>Sorry, I don't understand now. You wrote in previous message that VFs shou=
ld
>be created after switchdev mode is enabled. Now you are writting that they=
 are
>created based on rep_cnt (so assuming VFs have been created before).
>
>What is the correct order?
># echo 1 x > sriov_numvfs
># devlink dev eswitch set pci/0000:ca:00.0 mode switchdev or # devlink dev
>eswitch set pci/0000:ca:00.0 mode switchdev # echo 1 x > sriov_numvfs
>
>or you can create VFs before and after? From looking at the drivers code it
>looks like driver bnxt supports that.
Actually, we support VF creation before and after representor creation.=20
Representor will not able send or receive any traffic untill corresponding =
representee
is created.
>
>I am not familiar with nfp and bnxt driver but based on code in current ke=
rnel
>version it looks like nfp creates representor when switching mode only for
>physical and PF types, VF representor type is created when the VF is creat=
ed.
>Bnxt support VF representor creation before and after switching mode. In i=
ce
>port representors are created during VFs creation only.
>
>I am not against your solution, only pointing that it can lead to some pro=
blems.
>
Thanks for sharing the information.

Geetha.

>Thanks,
>Michal
>
>> Thanks,
>> Geetha.
>>
>> >Thanks,
>> >Michal
>> >
>> >> >
>> >> >Different order can be problematic. For example (AFAIK) kubernetes
>> >> >scripts for switchdev assume that first is switching to switchdev
>> >> >and VFs creation is done after that.
>> >> >
>> >> >Thanks,
>> >> >Michal
>> >> >
>> >> >> # devlink dev eswitch set pci/0002:1c:00.0  mode switchdev # ip
>> >> >> link show
>> >> >> 25: r0p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
>> >mode
>> >> >DEFAULT group default qlen 1000
>> >> >>     link/ether 32:0f:0f:f0:60:f1 brd ff:ff:ff:ff:ff:ff
>> >> >> 26: r1p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
>> >mode
>> >> >DEFAULT group default qlen 1000
>> >> >>     link/ether 3e:5d:9a:4d:e7:7b brd ff:ff:ff:ff:ff:ff
>> >> >>
>> >> >> #devlink dev
>> >> >> pci/0002:01:00.0
>> >> >> pci/0002:02:00.0
>> >> >> pci/0002:03:00.0
>> >> >> pci/0002:04:00.0
>> >> >> pci/0002:05:00.0
>> >> >> pci/0002:06:00.0
>> >> >> pci/0002:07:00.0
>> >> >>
>> >> >> ~# devlink port
>> >> >> pci/0002:1c:00.0/0: type eth netdev r0p1v0 flavour pcipf
>> >> >> controller
>> >> >> 0 pfnum 1 vfnum 0 external false splittable false
>> >> >> pci/0002:1c:00.0/1: type eth netdev r1p1v1 flavour pcivf
>> >> >> controller
>> >> >> 0 pfnum 1 vfnum 1 external false splittable false
>> >> >> pci/0002:1c:00.0/2: type eth netdev r2p1v2 flavour pcivf
>> >> >> controller
>> >> >> 0 pfnum 1 vfnum 2 external false splittable false
>> >> >> pci/0002:1c:00.0/3: type eth netdev r3p1v3 flavour pcivf
>> >> >> controller
>> >> >> 0 pfnum 1 vfnum 3 external false splittable false
>> >> >>
>> >> >> -----------
>> >> >> v1-v2:
>> >> >>  -Fixed build warnings.
>> >> >>  -Address review comments provided by "Kalesh Anakkur Purayil".
>> >> >>
>> >> >> v2-v3:
>> >> >>  - Used extack for error messages.
>> >> >>  - As suggested reworked commit messages.
>> >> >>  - Fixed sparse warning.
>> >> >>
>> >> >> v3-v4:
>> >> >>  - Patch 2 & 3: Fixed coccinelle reported warnings.
>> >> >>  - Patch 10: Added devlink port support.
>> >> >>
>> >> >> v4-v5:
>> >> >>   - Patch 3: Removed devm_* usage in rvu_rep_create()
>> >> >>   - Patch 3: Fixed build warnings.
>> >> >>
>> >> >> v5-v6:
>> >> >>   - Addressed review comments provided by "Simon Horman".
>> >> >>   - Added review tag.
>> >> >>
>> >> >> v6-v7:
>> >> >>   - Rebased on top net-next branch.
>> >> >>
>> >> >> Geetha sowjanya (10):
>> >> >>   octeontx2-pf: Refactoring RVU driver
>> >> >>   octeontx2-pf: RVU representor driver
>> >> >>   octeontx2-pf: Create representor netdev
>> >> >>   octeontx2-pf: Add basic net_device_ops
>> >> >>   octeontx2-af: Add packet path between representor and VF
>> >> >>   octeontx2-pf: Get VF stats via representor
>> >> >>   octeontx2-pf: Add support to sync link state between representor=
 and
>> >> >>     VFs
>> >> >>   octeontx2-pf: Configure VF mtu via representor
>> >> >>   octeontx2-pf: Add representors for sdp MAC
>> >> >>   octeontx2-pf: Add devlink port support
>> >> >>
>> >> >>  .../net/ethernet/marvell/octeontx2/Kconfig    |   8 +
>> >> >>  .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
>> >> >>  .../ethernet/marvell/octeontx2/af/common.h    |   2 +
>> >> >>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |  74 ++
>> >> >>  .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
>> >> >>  .../net/ethernet/marvell/octeontx2/af/rvu.c   |  11 +
>> >> >>  .../net/ethernet/marvell/octeontx2/af/rvu.h   |  30 +-
>> >> >>  .../marvell/octeontx2/af/rvu_debugfs.c        |  27 -
>> >> >>  .../marvell/octeontx2/af/rvu_devlink.c        |   6 +
>> >> >>  .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  81 ++-
>> >> >>  .../marvell/octeontx2/af/rvu_npc_fs.c         |   5 +
>> >> >>  .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   4 +
>> >> >>  .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 464 ++++++++++++
>> >> >>  .../marvell/octeontx2/af/rvu_struct.h         |  26 +
>> >> >>  .../marvell/octeontx2/af/rvu_switch.c         |  20 +-
>> >> >>  .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +
>> >> >>  .../ethernet/marvell/octeontx2/nic/cn10k.c    |   4 +-
>> >> >>  .../ethernet/marvell/octeontx2/nic/cn10k.h    |   2 +-
>> >> >>  .../marvell/octeontx2/nic/otx2_common.c       |  56 +-
>> >> >>  .../marvell/octeontx2/nic/otx2_common.h       |  84 ++-
>> >> >>  .../marvell/octeontx2/nic/otx2_devlink.c      |  49 ++
>> >> >>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 305 +++++---
>> >> >>  .../marvell/octeontx2/nic/otx2_txrx.c         |  38 +-
>> >> >>  .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
>> >> >>  .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  19 +-
>> >> >> .../net/ethernet/marvell/octeontx2/nic/rep.c  | 684
>> >> >> ++++++++++++++++++ .../net/ethernet/marvell/octeontx2/nic/rep.h
>> >> >> ++++++++++++++++++ |
>> >> >> 53 ++
>> >> >>  27 files changed, 1834 insertions(+), 227 deletions(-)  create
>> >> >> mode
>> >> >> 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
>> >> >>  create mode 100644
>> >> >> drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>> >> >>  create mode 100644
>> >> >> drivers/net/ethernet/marvell/octeontx2/nic/rep.h
>> >> >>
>> >> >> --
>> >> >> 2.25.1
>> >> >>

