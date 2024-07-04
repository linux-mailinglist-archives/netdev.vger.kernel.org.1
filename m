Return-Path: <netdev+bounces-109223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BA3927775
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 15:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4686285A66
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 13:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BFA1AEFFE;
	Thu,  4 Jul 2024 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="MEgJ4luo"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EC41AED5E;
	Thu,  4 Jul 2024 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720100925; cv=fail; b=Up1xVge0lmmlBfSIzb6FbBUeAtWgJuIosW3dGmtj1Q1OnqhAxbuYR95zPHVkh9CR0CYw3rKQhQpjibkUkt8hYEaz+7JHmNJuVt1WbVxxoJsPkJbqJEAj/MpkmoHCfNHfD2nHjO1RxmKRRcILlJSCWwSiaY1gS3ZXPkbqFRisMkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720100925; c=relaxed/simple;
	bh=N4RS1A9+QewG3sTM2nglrvEQRP4k6s+vCiRofs+OEAQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=CY2EAwELvArXRKqbMvI5lSHOMRyujp6HHhG+vNYT04mv1khADbxPt93KsB2eq62KEKBtnCENC00FOma8RYOcCs6Kgd3iyNxBgvl3FfxgxjdSmd/j5axW+0LELqOxOfdmxxh5Rs1D0PDxBtCHXwXBTNh6YUS/mN4+NKd1SnBE69w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=MEgJ4luo reason="signature verification failed"; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4649IgmM007482;
	Thu, 4 Jul 2024 06:48:28 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 405s01rx0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 06:48:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLYc+g1Y1KaNFuR0lTA4183i6x9PJ22028jEf8MPIa/Hco9AXmXu0/qNVvrGSzkiTEWO+xb4St2WS7KR5sVXTPseEkZbl1/BbLr5o7Iz2dz/Q0btJ6mqJRLzPICUXCDr56uIwsS5fmeR52SCkEHfwemx6UemhLiLvSg4xK2Gz1mLi9jbD+bDOk/VbVunmIlP8cjM+HJAXwOa97ZTySPGi2BLI/pjAmFoCOxndqMCJjXHFrh0CRA9396tnuQN+aJ8Y2xcSlX2a2Bcq3dM9yGlJFXeWVPP5ZvFBNh0D6/W7ND1adzvFaHJfyFiRNmy6KAr6Tx0ROI+WCcwF0J8wU5wRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LLYFLRkOnHHqeZp12C98xoh1DXf7U0RSDJg2qTvfr4=;
 b=n/h8xHQOhRzXdqSfDCvKffxFWgFyfMAwBEajYqRJZ2WOM0+XiISK56nqBILfWd2RgBbU4xGAUybEi/c536C+A6AOzdlqPsFNWSAFNZPyFpTS8X+8O6VzVzJc1x6nmU6ftqA1CHtQuDoJDIiOaYIq8yKkVHggbp+C7y4vsucNRw6xtRKYmO4PdfXl5RUX76qL9s8DAN4SApzg+8pc/px7NyGipIVZIFm4dgYAv7iOqv32uWdPLyi1GUZEEKJergM9v0VK/m+u6UIvZfnBq+jFCkndO/hb0bEOKgShupbBmOam3dcjqacZ1RH049K49Rgssjg4hkTA0ujxnp9YRyDrZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LLYFLRkOnHHqeZp12C98xoh1DXf7U0RSDJg2qTvfr4=;
 b=MEgJ4luoyc4TYuU80HsEdHHoJIYo64vtMS9KM+ydAUbmh92H339ZG5UfVkBO3HEkzSy0MiwPhR+JGsHJkuVbTiy8S8z6DO8b8ZmdDkmCBstM901SvxBb/AYtVlrheuIuK4hUmNeXDMUVR3gCnD0sJ8fU2c5nAwlI2yz+XrMDYfQ=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by CH0PR18MB4131.namprd18.prod.outlook.com (2603:10b6:610:e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 13:48:24 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 13:48:23 +0000
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
Thread-Index: AQHayWAH5wurYZD5Kk24R5BnL2IOPLHk2TOAgAA9MfCAARqVAIAAaaaA
Date: Thu, 4 Jul 2024 13:48:23 +0000
Message-ID: 
 <CH0PR18MB4339C05B5CC43E7005F2D469CDDE2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240628133517.8591-1-gakula@marvell.com>
 <ZoUri0XggubbjQvg@mev-dev.igk.intel.com>
 <CH0PR18MB4339D4A85FA97B2136BF7E1CCDDD2@CH0PR18MB4339.namprd18.prod.outlook.com>
 <ZoZL7Hc5l3amIxIs@mev-dev.igk.intel.com>
In-Reply-To: <ZoZL7Hc5l3amIxIs@mev-dev.igk.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|CH0PR18MB4131:EE_
x-ms-office365-filtering-correlation-id: f1bcae5c-f149-433c-5a27-08dc9c2ff924
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Q2M0aVdVa3BWM0ZFVTI1Y05jYnZnVC9aSWJUcmpUcFloQzlLR3VMdU5ZeGda?=
 =?utf-8?B?V0ZST281QW5FYTRCaFpvWEV3S0gzL1ZUU1hpdFVSdi9XR2dzVE1EUnpCSU13?=
 =?utf-8?B?dlBKc1Fob0J6NUt0d1d2M2dkY3N4cDVzNmhZd2JCQkxWQnh3SzFJMmNmVnZ1?=
 =?utf-8?B?ejlmdmJNQ1g5ZC9oQkFhVUhSeTBGWFZVSmh0QklzK0ZTR3lYNEpybHRkWjgz?=
 =?utf-8?B?eGpteGlNTzNWOVErQXc0eUZiaGE0azg4MERGSnYrdmhuenl0WkladkhPR05J?=
 =?utf-8?B?YS82RUQzSithMVl0SlljdU5qTGJQcHZVTWJVUG5jaWpITS80bkJkVWVKemZX?=
 =?utf-8?B?UXo1dWQrejRJOFhVN0QzbUdGUDZCK2pjNU9UMUJCTHkyMzBKMUluQ0JCbXQr?=
 =?utf-8?B?Nms1TG5HUngybTRWbnR4UVp2a1hVTVFya01vaG9rbXo4V2NWSE53RnZoRWZ3?=
 =?utf-8?B?WmVySlNoYUppMnhuRnpDVVVybk9mN0pzRDVnNldZenBveFVpeXZFNVZRamk1?=
 =?utf-8?B?YVU5aHQzRVova1pRWk1mUm1HQU9KQW9xMllWckxIbTFBNzFIZDkwTlExc2t1?=
 =?utf-8?B?NXZtUXVyZXFMcVVKNVVQOUdjOEh5Z2tjN3BxN1gwSGZnbmt6aytZL2FKK2JO?=
 =?utf-8?B?R24xOVZGR2UxNlo0SkplSW03dlpZdlJBU0lrbU1zeHJTZ0xxeWc4cUdXd2tL?=
 =?utf-8?B?WDhGTHJtNmtPdGFpUk90ZTdVMzIzZlAvSG5oYVBQbVMyR3pBK29PenI5cmdT?=
 =?utf-8?B?RTFHeG5KVVl3U0JpS2VTQ0d2TTJ6V0tWaUpMVFpIdGgrVm1nWEpZZkdJNUFX?=
 =?utf-8?B?Nm9ybkR5S3lLK3BPa2RXeHBNUnkvQWc1bHBqV2NtT3lHcFYxcjVaMmxmM2NS?=
 =?utf-8?B?Nm03UW8zWFZKM3pzZ2VhMlVEN2orWGVmYVhhcWw4a2Fsb1hTZ01Zc1hwQ3F3?=
 =?utf-8?B?a29mZmlZQjY0Mi8xcEszVVkvK3ozb3JJOHZ6SmlRZFFFbENtSHpxeVkrRVVu?=
 =?utf-8?B?THRMa2RKUEdlY3hqYXp3WkdNU0RLUUpIR1BaclV2clRRV3hNRFRpeHdxUjQr?=
 =?utf-8?B?T2FEZFRMQ0FzZnZqUFA3R0NUSzlxRjZvVXB3Z0Z0RUhLVjBXOXBLUWtIcTJF?=
 =?utf-8?B?UXVGWVQrZHJSaFFOT0xyRVZxSXJKa2ZPSGJnSEJ0RDZKNkZZc1NjWWYyMUdr?=
 =?utf-8?B?eSs4UEVDRThpZ2N3cWdrVCtYelNFakVyU1lEdDMyWnh5b3VMcmhyOEFJeTJs?=
 =?utf-8?B?UWtKVDhBa3E5ZHNCVVdyemxHSzEwTEpuSHU4d0hITlZ6aERoQVNZbHRJd0sy?=
 =?utf-8?B?TUQrTGI0bGkyalB0UmI5aDJxaittTjkwZUFRbzBwa09pOEt5endpbzNjM0la?=
 =?utf-8?B?T3BLL1RNWXF2cklFcHBHUWhZUkJHWjBDeUFjR0tCNHNHSGVEMXFYTjg3T0F4?=
 =?utf-8?B?N2xzdTUxTjdQcUtPanUvdE1xcDQ3WnBoUlZmU2Z0eXkySEpNTENEaGN3R3Vl?=
 =?utf-8?B?MDllMW5qUGZYMm91bFNHZndGdU1EWVVZSE9yeUV2aDRKT0RnNXNLWWptMGVp?=
 =?utf-8?B?LzlUZUtLSzQ2WjRZajNud2VuTFVQRVN4WC9YZ2U4Yi9naVZDNWpWTnpCKy9K?=
 =?utf-8?B?TmlWS1hnYW1YVFNpRWVkaDZ6K2NEN2I5SWJ5WTExN1NPTUVqQm5VUGUrUi9w?=
 =?utf-8?B?S290bEhSdEI5VXlsRHYrc3BWTWhWaTkvZjlkOTZmS01hWnh3ODZWNi9EQWJJ?=
 =?utf-8?B?dHZJa1NEWk9neEo0eEVKdXVqU1RKVEY1VUNQZjcxMytpbncrbndnejBrcC9o?=
 =?utf-8?B?SEZsZDVUdHcyUDUvWVJGY2tjNlg1TGxmTURjT09CbzQ2bWhZdnFMREtMYTZw?=
 =?utf-8?B?ai9taVpiWlRQQWZucFEwMWorY1N2YXZJN2J2a2JRdExMS0E9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RndjMEV0SHA3eER6VDRHRndjT1VnQ0N4Y0pVbUNKYW5ZZjRsUGpMTlJiVkRy?=
 =?utf-8?B?SmpubWhvd3Zjc0s4OGJhcXdOajN4NWp1Rzk5RVc5UVBnN2UrQWtxRWdRajhp?=
 =?utf-8?B?ZDJzVURJaFhVdmJxTnp2M3FNK1NzRmY2Z1dUVHVBN3FNS1FUSlhvZVQwZmhv?=
 =?utf-8?B?cVU4ZmNDR0wxdVFSTFozSGtjRkI5SU81VjJIL3gvejVwSUcwWFlDYU8yREND?=
 =?utf-8?B?N3lVN081NXh5alk4MXkwTmRzVUdWdjE4M21zd0pkcFY4WVlhSlBMNkt5TE5W?=
 =?utf-8?B?SEE1MUsvbUpRUTZlVWNJM21FU2ZwcENBdGVxVTNyQXVKcXlmcm9sY05QZTB2?=
 =?utf-8?B?QmdwcWdhdnRzdDNpaFdoaFUrczQyQU1Jc0JBOWhHcGVCc2pYMklPdU1IaDQ2?=
 =?utf-8?B?VEV6d240UEk4eUZ2ZkVraWJKa0VHdVp5QVhoUjl2ZjcyYUhET3lDNVhRdUdJ?=
 =?utf-8?B?MVZ5UFhmQVk1aGRNMlQ2VkF1bGdsZVNrdFdQMzJ4bnBDNlZLVTVxSzQyQUxL?=
 =?utf-8?B?cVR6aGpMcU1lZXNOaWZReVpyQ3RHTFdvK1RudkE1S3dKNkRDMWt5YlZhb0F6?=
 =?utf-8?B?RlRRbjlyajY5SG0xOG9GMi9UUkprUm9BcnlCWVdLUk1NR2pnS2E3cUZpd3B5?=
 =?utf-8?B?d3dxek4xMVpYWWZ2VVBIWisvT0N5enMvRDBpR1RGZTB0NFR6ZHFrZ3hObkdU?=
 =?utf-8?B?Y1h6eDY3TEVvdE9tNk1MZkpsT1hMSWI4NzEvRDhXbkxDaGlNMnQrZllabXEv?=
 =?utf-8?B?aHZad1h3MjN4WnczZVlVcUNZSzkzSXZRU1hLcmdWU0cvaVpZL05aSERvWUV4?=
 =?utf-8?B?WEI4TkFEZUJtcmQzMmUwT2pteFJBVHVtdGFWamFXN1hTeXlaOVFFM0lzUjZ4?=
 =?utf-8?B?Wjk4ZUEyU2ROVkltL1RWYVd2ZXpnVGNvSlJrb2tYQ0ovWU1QSUVQVk1UOXdm?=
 =?utf-8?B?a0p2M3RSZG9ickV3K01zdzdPR0VZOFNkeUhYaytORXozWHlWWDMwOGdzUkoz?=
 =?utf-8?B?UmFKeGR6TVB6ZlR6RGNsZzZJZFRPUmNoZXBzR2RyUDhLaDNmV1orRnVKRk9G?=
 =?utf-8?B?OU1iVkV1a3pKUGlHQ05NL1dtb2FRS0VWT1FGbGhWcS93N0kzb2xtNk8yayt6?=
 =?utf-8?B?ZG5PdVhIZkVadnl1ZjV2cUk5T3crUFdjN0NCc2w4TkwyVytyQTVpSXhleFcz?=
 =?utf-8?B?TnpFa3FpTmlKOThWWmhURWpOWFlkUnN3WUw1YTExcUhyNUVRM2ZiVGVYSU85?=
 =?utf-8?B?SWsvTS9JdjQ5RzM3QVFXRTBUOXhKM2NaNTVKOU44NGF1dElaeS9sVldWRVFZ?=
 =?utf-8?B?QVE0WUdYWVRMdXFHVEhTNm5qdFZRNENVZm9yb3pFL2xHZHhYMSthQkdLM2Nr?=
 =?utf-8?B?dGNRN0ZhL0hCSTBvNTlPQkZQR2NrRVRYdEFWU2EyOGpmNThoV3FMTldPaWcz?=
 =?utf-8?B?cEhzdVAxR00ydXV6Sm9CaDk3WXVLV0RXQkM4cXpPUlA2NmZCcHlCRmNaZC8w?=
 =?utf-8?B?cnZhd0IzZ3pvTVd0SHE0WmhGZDBvNzIvaFU5YVJtZVl5ZzMzNTZva2JEWmxn?=
 =?utf-8?B?MWVJbkRTdXhiR2hPblBiYjgzU0NhNzhBWGJtZVNtSENUc3Q5UldvaFlhcFRi?=
 =?utf-8?B?d0E4NkhQYmFOTHgxNTFkU0VlRk1sQm5GdHdYWUtxVVBQMFNtVU1QZklybm14?=
 =?utf-8?B?SXVaNStuMG1GU2t4dUk4SnpUNzFabWNtQ0ZNbW5jb3IzbzNNbUFUbExoN1F5?=
 =?utf-8?B?RFZwdlFJakxjOXpPZHlOOXk0VmEzdkVaZ1I5ZCt0VUh3ZjVnbHE3ZTFzUGdo?=
 =?utf-8?B?QlA5QkpqaG1TVUhaTUIzZC96ODVFRFZuSk1pcGwzWmt0SGQ3aG8rc3VuSm15?=
 =?utf-8?B?MVJla0ZGTDhnNW54c2VqY0Nma3ZkZXJraEpnNnIzc20yazJpQUs3Z0tYZVE5?=
 =?utf-8?B?ekVZd1d4WnNSdFZZRXlvTkphTWNiNTRYRTdiVzB6TGJmaHlDeEkyUjNlTWox?=
 =?utf-8?B?aUR4QkY4K3Jjdk1sWHBKYm96TEFURWVLV3lXcGhLTEt4Q2FXdHdaU0E5R3Vi?=
 =?utf-8?B?dE9oSUgrcTJ1dzBzMkJQazloZ3d4U3hmNVpKdXUrU2FaMGtLTGZvMHJiTzZp?=
 =?utf-8?Q?7tQ4=3D?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bcae5c-f149-433c-5a27-08dc9c2ff924
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 13:48:23.6537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Or9CYfQ7QfKce/ClEeVtjt6cDySKIBLOJhJINCfvHdtYLUamg7tJpqy/sThG8wsT75d2x8VIDz0QC/Zt6wyjAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4131
X-Proofpoint-GUID: -umOkYBVCmVdvfnPyN0dh0jaoUIkgoQZ
X-Proofpoint-ORIG-GUID: -umOkYBVCmVdvfnPyN0dh0jaoUIkgoQZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_10,2024-07-03_01,2024-05-17_01



>-----Original Message-----
>From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>Sent: Thursday, July 4, 2024 12:45 PM
>To: Geethasowjanya Akula <gakula@marvell.com>
>Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org;
>davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
>Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
><sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
>Subject: Re: [EXTERNAL] Re: [net-next PATCH v7 00/10] Introduce RVU
>representors
>
>On Wed, Jul 03, 2024 at 02:=E2=80=8A34:=E2=80=8A03PM +0000, Geethasowjanya=
 Akula wrote: > >
>> >-----Original Message----- > >From: Michal Swiatkowski
><michal.=E2=80=8Aswiatkowski@=E2=80=8Alinux.=E2=80=8Aintel.=E2=80=8Acom> >=
 >Sent: Wednesday, July 3, 2024 4:=E2=80=8A14
>PM=20
>On Wed, Jul 03, 2024 at 02:34:03PM +0000, Geethasowjanya Akula wrote:
>>
>>
>> >-----Original Message-----
>> >From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> >Sent: Wednesday, July 3, 2024 4:14 PM
>> >To: Geethasowjanya Akula <gakula@marvell.com>
>> >Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
>> >kuba@kernel.org; davem@davemloft.net; pabeni@redhat.com;
>> >edumazet@google.com; Sunil Kovvuri Goutham
><sgoutham@marvell.com>;
>> >Subbaraya Sundeep Bhatta <sbhatta@marvell.com>; Hariprasad Kelam
>> ><hkelam@marvell.com>
>> >Subject: [EXTERNAL] Re: [net-next PATCH v7 00/10] Introduce RVU
>> >representors On Fri, Jun 28, 2024 at 07:05:07PM +0530, Geetha sowjanya
>wrote:
>> >> This series adds representor support for each rvu devices.
>> >> When switchdev mode is enabled, representor netdev is registered
>> >> for each rvu device. In implementation of representor model, one
>> >> NIX HW LF with multiple SQ and RQ is reserved, where each RQ and SQ
>> >> of the LF are mapped to a representor. A loopback channel is
>> >> reserved to support packet path between representors and VFs.
>> >> CN10K silicon supports 2 types of MACs, RPM and SDP. This patch set
>> >> adds representor support for both RPM and SDP MAC interfaces.
>> >>
>> >> - Patch 1: Refactors and exports the shared service functions.
>> >> - Patch 2: Implements basic representor driver.
>> >> - Patch 3: Add devlink support to create representor netdevs that
>> >>   can be used to manage VFs.
>> >> - Patch 4: Implements basec netdev_ndo_ops.
>> >> - Patch 5: Installs tcam rules to route packets between representor a=
nd
>> >> 	   VFs.
>> >> - Patch 6: Enables fetching VF stats via representor interface
>> >> - Patch 7: Adds support to sync link state between representors and V=
Fs .
>> >> - Patch 8: Enables configuring VF MTU via representor netdevs.
>> >> - Patch 9: Add representors for sdp MAC.
>> >> - Patch 10: Add devlink port support.
>> >>
>> >> Command to create VF representor
>> >> #devlink dev eswitch set pci/0002:1c:00.0 mode switchdev VF
>> >> representors are created for each VF when switch mode is set
>> >> switchdev on representor PCI device
>> >
>> >Does it mean that VFs needs to be created before going to switchdev
>> >mode? (in legacy mode). Keep in mind that in both mellanox and ice
>> >driver assume that VFs are created after chaning mode to switchdev
>> >(mode can't be changed if VFs).
>> No. RVU representor driver implementation is similar to mellanox and ice
>drivers.
>> It assumes that VF gets created only after switchdev mode is enabled.
>> Sorry, if above commit description is confusing. Will rewrite it.
>>
>
>Ok, but why the rvu_rep_create() is called in switching mode to switchdev
>function? In this function you are creating netdevs, only for PF represent=
or? It
>looks like it doesn't called from other context in this patchset, so where=
 the
>port representor netdevs for VFs are created?
>
RVU representors for PF/VFs are created when switchdev mode is set, similar=
 to the bnxt and nfp drivers.
rvu_rep_create() will create representors based on rep_cnt (which include b=
oth PFs and VFs count)=20

Thanks,
Geetha.

>Thanks,
>Michal
>
>> >
>> >Different order can be problematic. For example (AFAIK) kubernetes
>> >scripts for switchdev assume that first is switching to switchdev and
>> >VFs creation is done after that.
>> >
>> >Thanks,
>> >Michal
>> >
>> >> # devlink dev eswitch set pci/0002:1c:00.0  mode switchdev # ip
>> >> link show
>> >> 25: r0p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
>mode
>> >DEFAULT group default qlen 1000
>> >>     link/ether 32:0f:0f:f0:60:f1 brd ff:ff:ff:ff:ff:ff
>> >> 26: r1p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN
>mode
>> >DEFAULT group default qlen 1000
>> >>     link/ether 3e:5d:9a:4d:e7:7b brd ff:ff:ff:ff:ff:ff
>> >>
>> >> #devlink dev
>> >> pci/0002:01:00.0
>> >> pci/0002:02:00.0
>> >> pci/0002:03:00.0
>> >> pci/0002:04:00.0
>> >> pci/0002:05:00.0
>> >> pci/0002:06:00.0
>> >> pci/0002:07:00.0
>> >>
>> >> ~# devlink port
>> >> pci/0002:1c:00.0/0: type eth netdev r0p1v0 flavour pcipf controller
>> >> 0 pfnum 1 vfnum 0 external false splittable false
>> >> pci/0002:1c:00.0/1: type eth netdev r1p1v1 flavour pcivf controller
>> >> 0 pfnum 1 vfnum 1 external false splittable false
>> >> pci/0002:1c:00.0/2: type eth netdev r2p1v2 flavour pcivf controller
>> >> 0 pfnum 1 vfnum 2 external false splittable false
>> >> pci/0002:1c:00.0/3: type eth netdev r3p1v3 flavour pcivf controller
>> >> 0 pfnum 1 vfnum 3 external false splittable false
>> >>
>> >> -----------
>> >> v1-v2:
>> >>  -Fixed build warnings.
>> >>  -Address review comments provided by "Kalesh Anakkur Purayil".
>> >>
>> >> v2-v3:
>> >>  - Used extack for error messages.
>> >>  - As suggested reworked commit messages.
>> >>  - Fixed sparse warning.
>> >>
>> >> v3-v4:
>> >>  - Patch 2 & 3: Fixed coccinelle reported warnings.
>> >>  - Patch 10: Added devlink port support.
>> >>
>> >> v4-v5:
>> >>   - Patch 3: Removed devm_* usage in rvu_rep_create()
>> >>   - Patch 3: Fixed build warnings.
>> >>
>> >> v5-v6:
>> >>   - Addressed review comments provided by "Simon Horman".
>> >>   - Added review tag.
>> >>
>> >> v6-v7:
>> >>   - Rebased on top net-next branch.
>> >>
>> >> Geetha sowjanya (10):
>> >>   octeontx2-pf: Refactoring RVU driver
>> >>   octeontx2-pf: RVU representor driver
>> >>   octeontx2-pf: Create representor netdev
>> >>   octeontx2-pf: Add basic net_device_ops
>> >>   octeontx2-af: Add packet path between representor and VF
>> >>   octeontx2-pf: Get VF stats via representor
>> >>   octeontx2-pf: Add support to sync link state between representor and
>> >>     VFs
>> >>   octeontx2-pf: Configure VF mtu via representor
>> >>   octeontx2-pf: Add representors for sdp MAC
>> >>   octeontx2-pf: Add devlink port support
>> >>
>> >>  .../net/ethernet/marvell/octeontx2/Kconfig    |   8 +
>> >>  .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
>> >>  .../ethernet/marvell/octeontx2/af/common.h    |   2 +
>> >>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |  74 ++
>> >>  .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
>> >>  .../net/ethernet/marvell/octeontx2/af/rvu.c   |  11 +
>> >>  .../net/ethernet/marvell/octeontx2/af/rvu.h   |  30 +-
>> >>  .../marvell/octeontx2/af/rvu_debugfs.c        |  27 -
>> >>  .../marvell/octeontx2/af/rvu_devlink.c        |   6 +
>> >>  .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  81 ++-
>> >>  .../marvell/octeontx2/af/rvu_npc_fs.c         |   5 +
>> >>  .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   4 +
>> >>  .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 464 ++++++++++++
>> >>  .../marvell/octeontx2/af/rvu_struct.h         |  26 +
>> >>  .../marvell/octeontx2/af/rvu_switch.c         |  20 +-
>> >>  .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +
>> >>  .../ethernet/marvell/octeontx2/nic/cn10k.c    |   4 +-
>> >>  .../ethernet/marvell/octeontx2/nic/cn10k.h    |   2 +-
>> >>  .../marvell/octeontx2/nic/otx2_common.c       |  56 +-
>> >>  .../marvell/octeontx2/nic/otx2_common.h       |  84 ++-
>> >>  .../marvell/octeontx2/nic/otx2_devlink.c      |  49 ++
>> >>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 305 +++++---
>> >>  .../marvell/octeontx2/nic/otx2_txrx.c         |  38 +-
>> >>  .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
>> >>  .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  19 +-
>> >> .../net/ethernet/marvell/octeontx2/nic/rep.c  | 684
>> >> ++++++++++++++++++ .../net/ethernet/marvell/octeontx2/nic/rep.h  |
>> >> 53 ++
>> >>  27 files changed, 1834 insertions(+), 227 deletions(-)  create
>> >> mode
>> >> 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
>> >>  create mode 100644
>> >> drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>> >>  create mode 100644
>> >> drivers/net/ethernet/marvell/octeontx2/nic/rep.h
>> >>
>> >> --
>> >> 2.25.1
>> >>

