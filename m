Return-Path: <netdev+bounces-259369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMP+EpQ+lmmIcwIAu9opvQ
	(envelope-from <netdev+bounces-259369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 23:35:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECCB15AA91
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 23:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FAB630238F0
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 22:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D070B336EFF;
	Wed, 18 Feb 2026 22:34:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020134.outbound.protection.outlook.com [52.101.46.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E13D302742
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 22:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771454080; cv=fail; b=bzw556ZfdPebIpykplqr4IavzfA9sv8GPwFORvOvmhGQ9oCylX+xtWu5dkuCMgKJbkRhwHbjJ/arA0AMW9bs+1QTuvz+K593t1s9oS3TTPI0ZWv0VuboYTe/ZyJqb7wN0dp5kIT/0gs92jD51eQSqFcHbiMZYpdxldI+MfeZ7lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771454080; c=relaxed/simple;
	bh=FUj6mwdOK6ICDLYuPJeqJJMxg5VXYSccNSW4/ty0hr0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GDmg9soP8XHb0iFwy6zCZu3IPh9OhshBqSRIeeTFI901Dk+pOlsOYLQ7SspdvCKAuAMuuLvsRG2xBC+5sxQq52ESYfaOG/bUW6nJ9co1NFlXbhC/7r9+squgGJ9xoZlpc+4A5NR3HrxjYnDUFZku3GmMSV9ijwyeb+VYCHG67Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gib.games; spf=none smtp.mailfrom=gib.games; arc=fail smtp.client-ip=52.101.46.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gib.games
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gib.games
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVEtqfH4cIqkM/4ojNlesgeY3bRFaOngWkv2Xw/TZ9LdkCWtIq9QI0yH0sXV7Jd6UUrF87UNadn9KJadLh4FmiPaC1ZrY9Xtab1bfqFwv9jyPiqLF8S/J3yThIeYwsgLPChF5kZXIWdBHRO+E2OUu0MBg28cAxW9bD3Lgq4CEDKeHfaFlT68aDfD1vLy6rvBe5EEMXLxSppH22JHL4pPukWZQV5gYTwIjLXlx5tNnHlvD582DylOPwcIt+c0cH6P3RiRFZAjhLvXE6hbqLxnhUkWJHMSX/sSkiOla4e1Lh+I1D9deua3fH2L2YsSdneKK7kNWRot/TRW5mPh7aCiSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUj6mwdOK6ICDLYuPJeqJJMxg5VXYSccNSW4/ty0hr0=;
 b=mo8n1cuqWc4AdCAT0bGR+h45jwyT00+UC6c4FAShjVLHXe3AAOsEsL3DhrnTypiaAXBMwrFEylkDbMO01f2mir6by7mGVw6RXRdy1wUSBJzXnh1S6oj41l4wA1HcMR89MUU0lPPd86zR4cU5++jn032ZbgzHFM1Vifrqmbr2a68xEWUmVAOhqrJx5LDMflcCg/uJaDlNEoswBmbxAlxNZP2jzGM8eW8tcsrfGRs1KnzaPrYoDdzKhsBhtAm5cWA1Jx0OYUiRTqET9eUdeW++q79gUCv6qbvaFxtuM02sV3Fu2anxHl7p1n7EOHMXMGQCdnldi1YMHOsnV/hDgBFNmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gib.games; dmarc=pass action=none header.from=gib.games;
 dkim=pass header.d=gib.games; arc=none
Received: from SJ0PR11MB5661.namprd11.prod.outlook.com (2603:10b6:a03:3b9::5)
 by SN7PR11MB7601.namprd11.prod.outlook.com (2603:10b6:806:34a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 22:34:37 +0000
Received: from SJ0PR11MB5661.namprd11.prod.outlook.com
 ([fe80::1aec:2e09:893c:ebc8]) by SJ0PR11MB5661.namprd11.prod.outlook.com
 ([fe80::1aec:2e09:893c:ebc8%5]) with mapi id 15.20.9611.013; Wed, 18 Feb 2026
 22:34:36 +0000
From: Sam Swicegood <sam@gib.games>
To: Kuniyuki Iwashima <kuniyu@google.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>
Subject: RE: [PATCH] nfc: llcp: check skb tailroom before appending TLV
Thread-Topic: [PATCH] nfc: llcp: check skb tailroom before appending TLV
Thread-Index: AQHcoSANsRCI70FuBkK5NUe9exqj5bWJA4cAgAAGw1A=
Date: Wed, 18 Feb 2026 22:34:36 +0000
Message-ID:
 <SJ0PR11MB5661249BD698DF2C4A797439BA6AA@SJ0PR11MB5661.namprd11.prod.outlook.com>
References: <20260218214550.53342-1-sam@gib.games>
 <CAAVpQUBjcsEqhzhCqEn9C+UnJenT+FS2ojKu2Z1y+5ppruJqgQ@mail.gmail.com>
In-Reply-To:
 <CAAVpQUBjcsEqhzhCqEn9C+UnJenT+FS2ojKu2Z1y+5ppruJqgQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gib.games;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5661:EE_|SN7PR11MB7601:EE_
x-ms-office365-filtering-correlation-id: 732d06e9-6b4c-455f-29ac-08de6f3de581
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aVdwNnNUcGpFbUx0VlJnMy90UFoxU1Q0VXd5TFovc3Z1WWRza01yWWl5aFpE?=
 =?utf-8?B?YTc5ZlpWSmxBdWlFNlJpdGtOZG5KeWdueEc1Q0x1SjhIN08xdlpIN3FsdjV5?=
 =?utf-8?B?WjBHZnRqZk5EMXNVWDZFalhWemtCZzhlVzlMMkozTFUzekNrYzVnMEZUNnhk?=
 =?utf-8?B?c3VHUHRCb1pMdU03UEduT2FkKzJBRVBJUGVobHc1ZFFHOURCREY1emF4Tk03?=
 =?utf-8?B?SkcrbU9PV2Q5S2tRMFNoTDhMbi8vRy95U2EwekR4N2RFQVVqcDBNa3hBQ20y?=
 =?utf-8?B?SWNOL2t5QWlWS3p0S09Fc0FMUVBoWjR0OElwa014Y2ZLKzVLNGxDdkNrSW03?=
 =?utf-8?B?MmtneDY2SzdIRlcvRDJxUzByNWppZ2RzMjdSSXh6MGlkSDNBemY5dHV1YkVp?=
 =?utf-8?B?UVd4Ry9IVXAvaExzVzNoaTFCeE5nRXhJRHJZNmtTdnRJWUZDZ1ZQSHhNdDlX?=
 =?utf-8?B?R3lYdURaQkRUV1NGNGhtcjY2bnpTUzNOVXNzOHFCRmVxcFBuZzlTSzVCVWJa?=
 =?utf-8?B?dHRQb1FiRXBtRTh5M1h1VDlEVjV0SStXUWxVbkhhY0ZwYWpXVkRMcy9KbGt1?=
 =?utf-8?B?MXBUUnNJaHQyTk9McDljL1VJY0p6TzM1K1RTdlZvTTJUdUM0bUtlV21MM2ZR?=
 =?utf-8?B?OUFWVS84dTRKQithZlhaaG01VnBSTjFIREp3QTgycjM3eXd5aHlMd0pSQjJo?=
 =?utf-8?B?K3pjWmh6NmpFQXUzbnhOU1Z0NFkxS21PZVFMN1dmeFJiQUVvME1QcFpXS3N5?=
 =?utf-8?B?dElpU3NuOXV4T0RPSjdzNkhvRXkvNDlKYTI2KzBnNmZwdnpXN2xxMjZ4dWNG?=
 =?utf-8?B?UEJFUzlINlVZVGdUOXM4ZWxtVEJNUVVvelBhcldhanVDN2xoMmZFdTB3WExw?=
 =?utf-8?B?U3ZWUTlSa2IwRUxkSDdjbHZ2cU1iNzMvZHdaUGgxbjVHRXNCZXNwcXJNd0dw?=
 =?utf-8?B?WXdTaFJoeHZjUVlGZ2JVdW1tZWpvRW9jNnFuNFQzZld4YVFWamdMSFhkVE5n?=
 =?utf-8?B?aHRhVjI5Mnd5UHd0RTJPWWY3SXZudFpXcURLS0hpK3lRWkVOWE4vK21BNWs3?=
 =?utf-8?B?bDh1a2EvWTd0NWV1Umcxd1hlVWdydi84aENOQ2wzOWhXK2NUbmE1MUZGVjNB?=
 =?utf-8?B?cTh2UXAzV2RvNWN0YitqbUErSitNR1JYZ3hUWTAwOXVhMDh1RFhPYm9vczls?=
 =?utf-8?B?cTRHdDZTMVJYNkR2bFNCTmRqSTh6ajdZL2FINFFjSE5ub3JRUEdMTllmSC8z?=
 =?utf-8?B?RzdCV3B3RTFINUcvWnlHbENvczdjN3Bsajd6NGdaeVFoK3h3enU1Nnk4ZnRh?=
 =?utf-8?B?MXJJaFpPZ2I1R3o5SlZiMGVvZ0RTdXk4THFlMEppL2hMRTEwb2RPbk1adzlR?=
 =?utf-8?B?RWMzdTNybW9aV1dVVEhqeXUycHVoZHhMY1hSeTZ6ajhPMVlGamtNZjIzdGR0?=
 =?utf-8?B?MjEwYU9HMGRNSEx0TnZtNk94bjgxekdrSTZsR3FjRzVXeDVJYVJmNUVobFFn?=
 =?utf-8?B?dEhZNVI4RGtGQkU2YitIcGh5U1pPUEpHdUNIR05GaWtFbm9DdTU2cHp2dURQ?=
 =?utf-8?B?S1ZicXZ3WmJBUnFrYU1TeVl2Y1JQdXBhc0ZiR1FTbS9mWnAxa0hSZkJTbVE4?=
 =?utf-8?B?bDI0UlMxQmJwUkpsdTAyYmhGaGpNZW04U2JYYStUVjlNeGRjcWJXUkx6SEEw?=
 =?utf-8?B?OFUvUWhIaG42TEZOZDNHUWFnN1FIZlMvVEJWd1RBMWZDcFdib2tMV3N0OTh4?=
 =?utf-8?B?T2JIUmVsMVo3OWhkVVMzMEQweWYzZlR5ZFo2VkRVaXdYRkR5YndDdkw0MjAz?=
 =?utf-8?B?aXNxVWZFSDM0bTBTUWMwUEdVTEdKc0NZSG95ZjFaaGVxS1ZOU2FlZUgzbFFJ?=
 =?utf-8?B?clhENEdoeGg4S0xLd00rVUxXVHcrNk5qWHlRUDdsNVJ1YzEwc3FUOWJzOVJ4?=
 =?utf-8?B?Ylozeks5NGxmc21kRWFOV0UwNW8yTGhQVVgxK0hOQ2YrK1dsbEVMRDlmMDQx?=
 =?utf-8?B?Y2JQWlB3bmJIWmZsZlpHV0ZEUHVRditTWjdLYWlVUWhlcmtnQzJoYmo3Z2pN?=
 =?utf-8?B?UTZXZmwwOXMxWG15UHhCZlJDWG5YR2tSeXMwczRPU0dWbTRZR1E3d2F6amti?=
 =?utf-8?B?MTRTc2FrSC9NQS9xVExwS1IrMVBJUmNqbUJxTmxFc3MzSEtkL2tMSjhsOUtL?=
 =?utf-8?Q?q3hx7NFkshedg4i8plNpoTU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5661.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHRBRHQxcmFLSk5VTE9kTnZqTFM0SG0weEtTZ2IrSk1VbFVUdzNOcWhnWHJs?=
 =?utf-8?B?R2dEdmZFWUJ3VWZjUFlaanVkaytYY2JJUSsyT2JmcXZMaVVPUUtmM2Y0YzdQ?=
 =?utf-8?B?Y0pBQWF4N0FsYmZ2NVk5MU5YNktKUXhlOUpFUmhEOC9EYS9xNTVrQVpGaFlE?=
 =?utf-8?B?cnc2M0VQN0JGY1M2Q2RrTDdSaE52T0NDVGU2cWpEZ0x6QlR4UCtxWjZqZDBh?=
 =?utf-8?B?TFllYm5sN1UrU1AxdUIxazVpM2xzNTZFQ3J3K0NiVENjY0VxNVgrMVoxeHVC?=
 =?utf-8?B?ekVXNTBtQ0NYUDQwZE4rK09JOERnVDNBNkxPRDd2ZlFTaS9VMjlRbHdVTlVC?=
 =?utf-8?B?NDh5RTIwbFBMZStoNzlxVWJLMUM4bEh3UjJKZm5hRVA2TG9xbmVGazJXM0JC?=
 =?utf-8?B?REJiZ3lyUllCcldKdXZOOGF3K3FEdnB2dStSdmx2bllOeG9QNmRyTmVJbEEz?=
 =?utf-8?B?c3UvbWZtaEgyVGxKRTVmaVk4SjF5Uno4R0Z2MEhsbUYxbWhzWFIwTktEQnR0?=
 =?utf-8?B?c3FyZWZIejhMTGJTY2pNRGM3bXYxSUVIaXAwNlluY2hXTFhJVWhIZ2UzZ1ov?=
 =?utf-8?B?MXhlMVZBU21JK0JjcFB1RmxYc2Jyb2UzT0JsczJWejJyS2Y2RlRwU3M3UExK?=
 =?utf-8?B?R0tFbzF3d1hjM3FheC9WZ3k5SVB4NEdHSERGK2dEb2FTa1ZYSzZZVnFLdytJ?=
 =?utf-8?B?T0gwM0VRWTZNNzZpQklYUnlSQzRIVmJHVERnamxSNXlqbytXWW1FNG92Uml4?=
 =?utf-8?B?VUhWZlFHK3hUbmhBM21qVnZ2YVdYOE1QRm9COC9DcUgzNDNUajk0WVVFM0dT?=
 =?utf-8?B?UW5lWVZXRTFLSWFiU2Jpb3J6SVlwOUZlbW9VOGFMR1Z0eFJLeGJYVnpCc0dp?=
 =?utf-8?B?S3JxU0Z2QVNHejhuOEZ0RU85REdtMGcrRm9uYitTSFVMRG4vZDQ1bE12c2Zh?=
 =?utf-8?B?WWFBU1pvL1NoaUc4OGtiWXlkamd4QjVMSVh3NmFObnFSeld1RnJHSnFqZGpU?=
 =?utf-8?B?MUxUK3FsTnEvT1AvYjJBdWI3Vm82K0dDL0Z2dndSaHNlSzJxbnI3M1ZpOXRZ?=
 =?utf-8?B?OUNoRDRybE9IL0VQR3pCVUd1RStyWVhjTGRpZkp1SWJKRC9xMUtMR0JwZkxY?=
 =?utf-8?B?QkhQWmxIS1JhT09vMFpielVnSzZldGV5bjNqUzhnVCtLNUprYzNZMGxzRHU2?=
 =?utf-8?B?ODA4YnNrTENzSUxXYnU3SURWcGlyWlQ3c3BRZlQ4bktIMTAxakhhQk5ueGpz?=
 =?utf-8?B?VCt5VmlNa3ZQZXZDUjFHNEREcjBUVkRDdW5saG9YMVBqOUM1T2lINzJZVFBC?=
 =?utf-8?B?Zk1KVEo2TVJVTXM3aXF4eW4wWUJFSnc3YkNHNEVmUCsrRkZGQzk4Tzhob0pj?=
 =?utf-8?B?K2hsU1MyWFZhV1lRc1c4VUlZbGJ2T3NsN1ZFTmtoSFc1VXFWWnU0L1NnZXBs?=
 =?utf-8?B?WVdwNVJGMEFNaGN3WXdRN1ZuQ2tPSDRjWFBtcGZGZDZ5R0lMa2wrUmh5RVZ5?=
 =?utf-8?B?OG8yaFhsOG5ycUozL0JCQnpWdjhZbTFCK1IrWTd3R2l1UEdGMkttUS9naFhs?=
 =?utf-8?B?U2lXNDdQbm5RY1R2RVowNnBmRlc1d0MvYWwvcUoydlhDMEwrVXM1aFRxbEZF?=
 =?utf-8?B?VVNOUjVjMG80aEd6ZDUxdkxRSms5Wkl0N3lsbGVHZjQzSFExT1VFM1JZWmpS?=
 =?utf-8?B?blJXV2RtdGY5NFJ0MU9weVYxaGdtaVViWURQL1VWMFRuVU1DNDdkaUw3d1c5?=
 =?utf-8?B?dmFFeXRPYkNmbDE2TUh2Ny94dVl2Nm5LSSthMExmejBqdks5M3orYzMvL2pz?=
 =?utf-8?B?U01qemVLTmJlaC9iVWtWV0Q0S2Njb1VoRHI1YTRVWEtGY3ovVXlWdWkweTg3?=
 =?utf-8?B?UjFFSkQwWmQwWWV0dVJYR1hlOXJjYmxNQlZGVHpRTDNybVd5OCtheENRcXlm?=
 =?utf-8?B?Sld2cUpLWW5pRi90YVpIR21INDY5d1Z5Wi9rYWJ6MUhtSWJUM3FCajlxNjY4?=
 =?utf-8?B?dWtZcWozVVhIVGZUaWxqc0pycTlTM1A4MUgwMWVRallDOEFJYUYvT1JpV2Rj?=
 =?utf-8?B?cjA1OGJVNXdrVVNpZk9mc2haN1A1ZEtDVmhXcHM3c2trNWJrVUFlVWZoT0xt?=
 =?utf-8?B?cVp3alNPVUJUUUlpWVdMWmkwTEI2dUc1ampCc3NkTDBobms1ZXZjVkwvUWw4?=
 =?utf-8?B?VnZOeVZWT1pCeVJZVUJnSStSM003TFZMRHNPTVk1cHZPekV5aXlEVktGMXdu?=
 =?utf-8?Q?DrUSKhiO3r57jh1YnGRL/qKWJqpBsEIes9oNFbiV2E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: gib.games
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5661.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 732d06e9-6b4c-455f-29ac-08de6f3de581
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2026 22:34:36.7146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84cb50b5-9086-4f56-ae20-767da36a39ef
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jHnGVm3qvFhFlhm3gKTsq94GYnvcsv1uKAUcEwxtm0xHR2TT07EYlfCcEwXKNMyv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7601
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.64 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259369-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[gib.games];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam@gib.games,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.829];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 9ECCB15AA91
X-Rspamd-Action: no action

WWVzLCBib3RoIGN1cnJlbnQgY2FsbGVycyBjb21wdXRlIHNpemUgYW5kIGxsY3BfYWxsb2NhdGVf
cGR1KCkgYWxsb2NhdGVzIGFjY29yZGluZ2x5Lg0KDQpNeSBpbnRlbnQgaGVyZSB3YXMgdG8gbWFr
ZSBsbGNwX2FkZF90bHYoKSBzZWxmLWNvbnRhaW5lZCBhbmQgZGVmZW5zaXZlOg0KaXQgY3VycmVu
dGx5IGFzc3VtZXMgdGhlIHNrYiBoYXMgZW5vdWdoIHRhaWxyb29tIGFuZCB3aWxsIHN0aWxsIGFw
cGVuZA0KZXZlbiBpZiB0aGF0IGFzc3VtcHRpb24gaXMgdmlvbGF0ZWQuIFRoZSBjaGVjayBjb252
ZXJ0cyBhIHBvdGVudGlhbCBvdmVyZmxvdw0KaW50byBhIGNsZWFuIGZhaWx1cmUgYW5kIHJlbW92
ZXMgdGhlIGluLWNvZGUgdG9kbyB0aGF0IGV4cGxpY2l0bHkgY2FsbHMgb3V0DQp0aGUgbWlzc2lu
ZyB2YWxpZGF0aW9uLg0KDQpJZiB5b3XigJlkIHByZWZlciBub3QgdG8gY2hhbmdlIGJlaGF2aW9y
IChyZXR1cm5pbmcgTlVMTCksIEkgY2FuIGltc3RlYWQgcmV3b3JrIGFzIGEgDQpXQVJOX09OX09O
Q0Uoc2tiX3RhaWxyb29tKHBkdSkgPCB0bHZfbGVuZ3RoKSBhbmQga2VlcCB0aGUgZXhpc3Rpbmcg
ZmxvdywNCm9yIGFkanVzdCB0aGUgaGVscGVyIHRvIHJldHVybiBhbiBlcnJvciBjb2RlIGFuZCBo
YXZlIGNhbGxlcnMgaGFuZGxlIGl0IGV4cGxpY2l0bHkuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBLdW5peXVraSBJd2FzaGltYSA8a3VuaXl1QGdvb2dsZS5jb20+IA0KU2Vu
dDogV2VkbmVzZGF5LCBGZWJydWFyeSAxOCwgMjAyNiA0OjA3IFBNDQpUbzogU2FtIFN3aWNlZ29v
ZCA8c2Ftc3dpY2Vnb29kQGdtYWlsLmNvbT4NCkNjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBk
YXZlbUBkYXZlbWxvZnQubmV0OyBrdWJhQGtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOyBo
b3Jtc0BrZXJuZWwub3JnOyBTYW0gU3dpY2Vnb29kIDxzYW1AZ2liLmdhbWVzPg0KU3ViamVjdDog
UmU6IFtQQVRDSF0gbmZjOiBsbGNwOiBjaGVjayBza2IgdGFpbHJvb20gYmVmb3JlIGFwcGVuZGlu
ZyBUTFYNCg0KT24gV2VkLCBGZWIgMTgsIDIwMjYgYXQgMTo0NuKAr1BNIFNhbSBTd2ljZWdvb2Qg
PHNhbXN3aWNlZ29vZEBnbWFpbC5jb20+IHdyb3RlOg0KPg0KPiBsbGNwX2FkZF90bHYoKSBhcHBl
bmRzIFRMViBkYXRhIHRvIGFuIHNrYiB1c2luZyBza2JfcHV0X2RhdGEoKSB3aXRob3V0IA0KPiBm
aXJzdCB2ZXJpZnlpbmcgdGhhdCBzdWZmaWNpZW50IHRhaWxyb29tIGlzIGF2YWlsYWJsZS4NCg0K
VGhpcyBpcyBiZWNhdXNlIGFsbCBjYWxsZXJzIChuZmNfbGxjcF9zZW5kX2Nvbm5lY3QoKSBhbmQN
Cm5mY19sbGNwX3NlbmRfY2MoKSkgY2FsY3VsYXRlIHRoZSBuZWNlc3NhcnkgdGFpbHJvb20gYW5k
IGFsbG9jYXRlIHNrYiB3aXRoIGxsY3BfYWxsb2NhdGVfcGR1KCksIG5vID8NCg0KDQo+DQo+IEFk
ZCBhIHRhaWxyb29tIGNoZWNrIHRvIGF2b2lkIHdyaXRpbmcgcGFzdCBlbmQgb2YgdGhlIHNrYiB3
aGVuIA0KPiBidWlsZGluZyBMTENQIFBEVXMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFNhbSBTd2lj
ZWdvb2QgPHNhbUBnaWIuZ2FtZXM+DQo+IC0tLQ0KPiAgbmV0L25mYy9sbGNwX2NvbW1hbmRzLmMg
fCA1ICsrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvbmV0L25mYy9sbGNwX2NvbW1hbmRzLmMgYi9uZXQvbmZj
L2xsY3BfY29tbWFuZHMuYyBpbmRleCANCj4gYjY1MjMyM2JjMmMxLi4xMGFjYzVkYTk1NGYgMTAw
NjQ0DQo+IC0tLSBhL25ldC9uZmMvbGxjcF9jb21tYW5kcy5jDQo+ICsrKyBiL25ldC9uZmMvbGxj
cF9jb21tYW5kcy5jDQo+IEBAIC0zMDAsOSArMzAwLDEwIEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVm
ZiAqbGxjcF9hZGRfaGVhZGVyKHN0cnVjdCANCj4gc2tfYnVmZiAqcGR1LCAgc3RhdGljIHN0cnVj
dCBza19idWZmICpsbGNwX2FkZF90bHYoc3RydWN0IHNrX2J1ZmYgKnBkdSwgY29uc3QgdTggKnRs
diwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTggdGx2X2xlbmd0aCkg
IHsNCj4gLSAgICAgICAvKiBYWFggQWRkIGFuIHNrYiBsZW5ndGggY2hlY2sgKi8NCj4gKyAgICAg
ICBpZiAoIXBkdSB8fCAhdGx2KQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7DQo+DQo+
IC0gICAgICAgaWYgKHRsdiA9PSBOVUxMKQ0KPiArICAgICAgIGlmIChza2JfdGFpbHJvb20ocGR1
KSA8IHRsdl9sZW5ndGgpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4NCj4gICAg
ICAgICBza2JfcHV0X2RhdGEocGR1LCB0bHYsIHRsdl9sZW5ndGgpOw0KPiAtLQ0KPiAyLjQzLjAN
Cj4NCg==

