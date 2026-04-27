Return-Path: <netdev+bounces-281336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPHRJnFo72lZBAEAu9opvQ
	(envelope-from <netdev+bounces-281336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:45:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F91473ACB
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F02573008D35
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 13:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193BD3CEBA6;
	Mon, 27 Apr 2026 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GrUJwsuC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J3zdkO6l"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6763CE4A3;
	Mon, 27 Apr 2026 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297471; cv=fail; b=skq3ZctEhOvIF4ubnJTpaWgIq0/8qgTdSfTvfA4J+i6DYmypfVPti/IkzlcJKBSWCBEOmAyNAEAxS5EzJZQ1VhT6zUogpViKtoa1V8vCk+ib3HUkhMNdjUAybo+iGZMBFdme37pGXw+5i6VA6WhFdPuP5f1lXduf2g+N+5JO+nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297471; c=relaxed/simple;
	bh=9ncjZ7X4/dbp7f01SHylJpLtkvqBJlLsbbQVVBshs7s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IgAuZbZv4IgtSK2uYLMb2EF6y251lA3wKpuxMKTwL7OMWtrxftkkSBVXsCwuAzFBVcxjgPfpNF8wS5/F8o9LzZFFpc9snHsVRKa33NEZFkK3uZJiJrzxHN2XIrX/sJMKN6EDkw7gkdqtW6Qzor+pgk9OFVD4i0ynymAy9NIfFJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GrUJwsuC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J3zdkO6l; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RCnQMk278387;
	Mon, 27 Apr 2026 13:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wqwwX9fGsGplQvfrkuAGivf0KQ4puiy10QBUfiQ7WkE=; b=
	GrUJwsuCRLlJ7pQ5ouUdZ0wdK7aT7/U7UNteuxWtOACXiqoyTV6JYXU+WMxGoWmJ
	KKaCDhWTcxSTirrCiRIP0u2ejFj3BdkhA1m0KKq6MVrFCPGIBmOHI93vTlrVnnJg
	D/IjkuT3rSDE6rnsug29YCi0kBS9IihV2AWjVj1MA89TAZTiiBCpsEAt8oV6A2ei
	RJa5Rb/Bf/8M0M09idy7VrkroZ1Zq5CFFpa2gmUSF12P9bywIcw4o3cJ6X38poZj
	/xTVGEPs7lFValcHO7dbiB6d0FD1MwWfpeVZwokyu1pt0ohnx7/w1LDck3mML8aw
	5gpp9f+cpfG9u/UIZ5FrGA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4drm1cu4kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 13:44:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63RDfK2H009247;
	Mon, 27 Apr 2026 13:44:09 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4drm2bexmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 13:44:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPU0LqEjZJdFC+uL4Sb+QLKiaCReiFiNGPM3KYU5Op1OryqL5NSue8MmVL/4fEddzoEERt22vw125j4lnM3p+raXyWL8W07nQL9L2vja1HLd7v4tRCYgWPeM4LXKqfU8rn/Npcrjl8wFECUnc7piHK8yRAfIu5Q/89MaD2GKn1DIlvQOlpgbFTkicH8HsRL+WyPNrVUtsy40MMCPDUa/K4EMvw3wAWdUb0b80/atmWL/eK9lfsbJzGWWFqnxWGMReTTDW35LTPxbYPWW3u1o9x2WL+rE6oCAnBIotxy+EYyFgr5P4eV4D3imWnw3nv6IFb7R43ce29/mcVqVuJEqwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqwwX9fGsGplQvfrkuAGivf0KQ4puiy10QBUfiQ7WkE=;
 b=ZAEyeei9jwky3VCO4NEtYNnLvHoYf1FffF6T3p7LafTrCRbNk+EV1b6UbGtCSJofObBzLJC9G33YM8eV9HDxu3kSG2H21lY0rcF4XTIxjeQuCISPg+J5XpkupqCkTCB1kKKcm4DgX0Q0vCFZ01Ewkxuw4SRx+dQMmbDIk35FUI05PEClEgmEaKk54ByFg4zyRGppuRw9FWReHt96TRZe95xS6swYo7ILYjl3Ystg54ltQ4cOKL81CKzcRQZok0ArlUSfiTW2H8AbJYCWH5RHYN5GZEMDovMLfB/L8m90rQO1QsGyNPwGBTnHu+AcYdiFY26zpr2Nu1D1SP372PZbmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqwwX9fGsGplQvfrkuAGivf0KQ4puiy10QBUfiQ7WkE=;
 b=J3zdkO6lPpIqTSvDP/rduwvpFQwKCoctYK0cYjy8pmvTF3BLlsSdAiEs7YiAjPD/cXK9OwgcB8E4cV3T5Xcoyt9wn6zzYY45bHKIBUgDw9sU+/odTCZXrHtNOU0SG3oNp+3TWmwYABHXas/Kl5qVxIiTKFavZ9j6OaLToBfl/mY=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by PH7PR10MB6310.namprd10.prod.outlook.com (2603:10b6:510:1b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 13:44:04 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 13:44:04 +0000
Message-ID: <26ab9c97-1f8b-4638-98fe-aa82cf1afcb7@oracle.com>
Date: Mon, 27 Apr 2026 14:43:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To: Thierry Reding <thierry.reding@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-next@vger.kernel.org
References: <20260427132604.3754048-1-thierry.reding@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260427132604.3754048-1-thierry.reding@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0302.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::8) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|PH7PR10MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: 2efd8427-6fb9-4504-f16a-08dea4630bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	i7POah5GZYhpJg8N9yZBph4pNxI4sK1RhVVncVoScJJ4H/WXn8nnUmdyPb5CpHODASS/6GM1/d4KWYY13G5eyIFzjoyJK0qJcuKo6NLQBmdgducsOZyNnQ6DTW0cnXdsAl55i19zcj6hWHnU3e5VSy6wBtFdNpE8BF/hFxwHvF5aXT38rleMjcL5f9ag310KLamZoPS94/QI6g1+DpIzyFYL6y2v0QGURWZ6Lt1X/9kCErLGBvhH2LZkxS2HGm/EYCLcwVOtwtuJ6jRsFY4r6hPpX9USgAFWIJCMDGpHqd9sYUZ/FlVUybE+Qg+7Ze1kXaVwkYSTn7w168bhzpdt8YFDkQiNYJEUPqC90niBcgvnO4eCuYyWziHiNQNvZT5PkTqszRui4lOby3swf1T5n5bxSRcjxjN5ULxd0s88Mwk9u7ZEWIjajL7egPraVxNZVfjvfypKhCw16owrKpJNW1q47ZeIiRXI5dgMjIkXLyWvWafUsqoXODWKzWXuDsTYi0kW1YWBplgdt2sgWrFAAeXQP3wHmYevkz5YbZeoxAbamTinWUfgMt5UurLuVBmj89xn51/oAa7YiO90Cs3p/EO6PEOkGRp8+LANxbQXdHWZQ8Nk1qzzYJd85ytwh/L/+ftnHABKZzS9xlE9r5ym56K5SawrGoBSeCYUCRIvX9J3h75AlhE1Ik5703yUe44P9HnERWrjI3sv8GA/uzUoarR3JR504ngk+ztgFK2squ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1RpSTMyUDJzbmh6bkloUWV2MERmNFlLdWkxYjJ2UzRHRnpneEdQVitLOFI1?=
 =?utf-8?B?RHQ2VVZXRUgwYTdNVG50a0FpYXlxRE84cmExK2Z2MWVVRU1zSm1ybUMvQ24y?=
 =?utf-8?B?UW5OWE1abHQxYmtwL3lPemNyMXlmWjQ1WkpEbzEvTmhTbGFiK0dzK2lONjcr?=
 =?utf-8?B?dnZlVDlxcUlzOTdxc3hRUWduNWxLYXYxZk1aeGxWckFIMVVmQ0UwblF3cGxz?=
 =?utf-8?B?WXY0UEMzYXMzekkvbitBK1VheXdGYVVpYmtzNE9KcmdMb2diam4vQWZiWDZy?=
 =?utf-8?B?WmdOaDdTS2N3WDlQQkFUNmRMZmdOM3lsRHJKN0FXdHAwcTRTUHgxSXhmOGZD?=
 =?utf-8?B?QzNmdE84am4xcHBNeStxdUlvVTc0OFZ5eUtkdjVWT2w0NUU2Y1FUL3Z0VTZ3?=
 =?utf-8?B?dE9qdExEUGdjazRkc2Q0SzFBc3d6eHZCMmhrbFZLdU5nZFVYTFlWbUhPQlpn?=
 =?utf-8?B?Z2JGTkIwaTR6emUwSHNOT0JEOXlJSFg4cWhwdUV3aWNDN29UQmc0ajYyRDgr?=
 =?utf-8?B?U0lXNUd4c2pHdE1RTitLNVVhL3pRd2ZLS2tEZktleitjWUJrRGRMMzFjV2c4?=
 =?utf-8?B?andMcHVUZ1oxa2lyU2o0d1RpdTN0eFNDWDBiWnRGVTAyYTVMdmI1MTdaQVdM?=
 =?utf-8?B?S1JzNDJ2WmRtQ2J1aUZ4RHczQUFHQlNNZEFsbHhWSTlBRlA1cmFlOHBPUWJB?=
 =?utf-8?B?NnhHcHVheVhlbzFtQVI3MlBCVGpwY1JHaDRHblBDc3k1MFR6VUhLQ3NtOGVT?=
 =?utf-8?B?TGllditHcHYrRWJzY0JScGZRcmtBQzdzVGhnaGJPeERENzFTYjFKNE9LSHhl?=
 =?utf-8?B?M1hZQVVWMDRUbUM1bGM1V2VUcnhSUWVtN3ZWR2ZTcldNRUsrUytUbnplZjZk?=
 =?utf-8?B?d3RGcC9XdUh4YWt4cFZmNDBlV3FzS0tyTkxkVWFKRUxjSDBENFczV1pWenRU?=
 =?utf-8?B?MzRxNU1JcU80Y2o2VHIwMnF6K202S2xSRTdneUFlUmxKZXE2TnN4VW9rbSth?=
 =?utf-8?B?aGEzK09ITi9WOWVGRUZaWHZvajY4aDNoV2V6VjJIeXJCdzJsWlUwMzJIR0Vj?=
 =?utf-8?B?RFFNVm1zakNGODRrWGZ6eXEzT3FINGEyU0xZZGowU2dybmZlUkVnZ2NLN2ty?=
 =?utf-8?B?ZUdiQW40Qjg0WE83dHErSUNCVzIrNWpPOFgxZ284TEJMRytLRjk3UXlCdXpy?=
 =?utf-8?B?aERDMklLdk50YUtsNHVSbEs0dkd3UWFSQXRoNVFBdW5KYWVGNnJkWmdEaXBo?=
 =?utf-8?B?dFpzUVBnU3FXcWRqbUFpcDQwYzhnOFhnbWhqcU5aUDZGaEF1c3A1QnZXRnd6?=
 =?utf-8?B?SWx3MW1WQTg2NjN6eWJ2R3JmWXdHbGR0dDc2SUtONko4aURQYm0ycmdHdExS?=
 =?utf-8?B?RkJSNVlGUGxjZDJZTTlMT1R1M3ozQzROUzFIWWRGN2lReE12b0RHdCtQTGVx?=
 =?utf-8?B?THFNRWFKT2hXbkJKcmJPRGNzY1JuT0drY2VIUm1nd3BTVHFjTTB4aTF4azB0?=
 =?utf-8?B?TTF4anVuQlNRQjh2NkxmNnZGVTZwUjlFNW41NnRqbHcyV1BEZWVVSG5PY0xT?=
 =?utf-8?B?cS9xckVZYzRsTHBORjN5QjlxQjdGY3NaT3d3SlBUTG04T29TUlhoS2haeUdD?=
 =?utf-8?B?Y3UxNUxvc3NKeS9Pd2MwYWtRY1hHSGFHTDRnT3l0dFQyZVpQU0VkNXk1dFZW?=
 =?utf-8?B?QXZiaWNpRENoMGJxeVVxN0dEbGdKcUEwUGkvQWpTeWt0eUpZV0lvZy9BdEVG?=
 =?utf-8?B?ZGxrekZvUnhBeElFaWdvekpqMml2L1FEZy9xWTV0Z3RaMk01LzZuRVBMN0k4?=
 =?utf-8?B?ODhZNUxSbXBlWFhRUW1HNXY3aXQxWU4xcDRoTHpROU04cDJSSVRJeS9HdlE4?=
 =?utf-8?B?WVZxcmR5NWdMUjczZVRac0t2Rld0RjNsUytsd05FcWhSNkF1clNqcmNCbXp1?=
 =?utf-8?B?ZmphYldlZ3ZMd2VKblFtbWF6eitDbjN4MWRwUmVMZE1MRHhOVDRzQTRGWGd2?=
 =?utf-8?B?U2tTZUJvK2U5UG5JN1RoVVNISkc4b3NtVXpWbXFFZEhHaStRb1IwWDM3L3lw?=
 =?utf-8?B?RjlySGRHZ1RqMWNWMlhJMnYrWkM0UVF0ckI1bTA0ODdaQ0dqSlVkaFhRTDNm?=
 =?utf-8?B?UThpMG15clVuVVNVV05ubnMyWXZsb3FNR3hxQXdnS041Nm9DWEJhRU1XcHdE?=
 =?utf-8?B?WEZMcFFBa3l5L1JKSzA4VUdCTGRWV0NacWptblpMaENyS2FUd25OLzFoQ0lu?=
 =?utf-8?B?aFZQYlRsWTZpV2tBT1d3MnBlaTY0citvTnFnemFxeFU2cDcyNitlRmlkc2l0?=
 =?utf-8?B?dXBmSmtnM05nM3A3UG9JczVSdEFmeHlLYnFlM2lPNHBhM1ArMkJHUT09?=
X-Exchange-RoutingPolicyChecked:
	X+cWGSIyOBpEJODr/+ZIT9OkrdZPlmeT1LPNoCRg95dUjUBzJWG9wCQQL2bENzn5tYtIpJI6HcRsZnZUB6aKwNA/h7YwjUNNbbDrNLmqZEUC62cmIppJxlS9dKqLxX9kxcMdpe2Iy8paJj8N6UAX9SdcDbM/zaqEGxXcODmgbrH8B5VV2liMvTLip1IT/PAGyvnbvS5jWUJmTzDjCBinaQob6+bLwNylJpBm7Ja9bkewTubcPJE0K1fIBwItJl+XOuW7Qx34EUHnhYS+AfygPblq3GifpO7PClGa+fycQrtUsfICwtipMmexUekDc4wdIK7vxnTCfn4mMd4D+U3kKA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nw+FV7hEiIWbXyAJn8ttuGR1RkgpACjfIgCXb1n1OGdW+Pk2ueDa53tm9AWpwm9TXy3erDhUEv0ucJh3nHDWTvGGvoZQgvKds0JX+Ln0sjR9wyC54OrfX80/TNaPQrERVBKsNvjt6AS6BiBPYQfspP51+anpxWT8yKstFuhstSpWLPAp37NOTt7XoS8HtNcNszB6dfJszlRfp03MxCt/iSkGaxaFedYPpqfpfzr0oGFzj0TO7KfBzT2W/n/W7N4vTVZyUO+xQxM3DdCE2UoGdafo7PNfWx7SXmlDEPuERK18wK3w9w6ypfnmtb9xPSXd6TWvzGgXDxf8hvNxgrQGTYLzNul5HNW0KbForbyrj8TsdQnfGEkg4NjkYdsQtIw4BlVYZs2IasTyEBLohg2BjfrC1UEaiW4Ck1jMLQcpEYGN8ak5Ib9KilEKlDDW0jICtsaa/NVpHYRpbKK+TV9cKgG0f9wYve38LMqGezc/Vll+jz7MmEFfZmQJ+vWVhkjeoYNOMBGP/4BVkda/o+0mcrgjdrCDDoC+TIFHRX7WaD/HFigzwJwUkS+g5Aq1bBfvxr4aOzwOuPgJuLNoOkAgfu3cKw8/5i3jJOP455ZFnZQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efd8427-6fb9-4504-f16a-08dea4630bac
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 13:44:04.0610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQYHrO1takGS3VaybU28RM17hqRMTnMqw+k+wchcgLZsSRocYglj+zfc+Q/8YNx5RH/vHoDty7rtSTYM2JTx8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6310
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2604270146
X-Proofpoint-GUID: n97VeWgXs0OYyFJAsYyxSRBJYjWqm2g2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE0NiBTYWx0ZWRfX0E0Dpen2Jh5w
 JqG3GXZ0v9jLgDkypVg6ygJpwwfEQ7RRXbhH/U0/QZ5/ciJxv6a/85/VMaHyAU7akMQTinCH0kb
 baxx7hkNTuCTuLa8p08HfEY7ZldoVZrpjJa/6SFWkGuvWW9Vq4rEsWHJPSTsgDotelK1MxRO/SN
 TWhdiEJfaFdwnt7BmoP8GacWEBx/4tr+60PB1aK+u3s52foLB1FsDft8EjCn9SH4XqY5H9fnWPM
 KVWkuZ9qnUqCqancMVnCBJv1vTwB/dQGzF/4zXfkoL/WjHos8cUtgB+UqAmNR6/42JV31Wpd3lF
 fDve9ywVZZ9c7Ox5zpoGqUXvCnrkzElsZ6F3p1S2svBf+mQlrYoe2GuAy2NKys5hfg1MIl4HSgy
 ZtYH76bTQ0DSJSLFv/IFGVAHsDi6FRO5cOlFuU7hpCIGz2VHafr5yqVZSMwK0G81vULsX/yNA91
 5a2j24DylzcZiu/lhvA==
X-Authority-Analysis: v=2.4 cv=I89Vgtgg c=1 sm=1 tr=0 ts=69ef6829 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=Ikd4Dj_1AAAA:8
 a=yPCof4ZbAAAA:8 a=ZhMLo4cG34FQGYeHgXQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: n97VeWgXs0OYyFJAsYyxSRBJYjWqm2g2
X-Rspamd-Queue-Id: 83F91473ACB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281336-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alan.maguire@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]

On 27/04/2026 14:26, Thierry Reding wrote:
> Hi all,
> 
> After merging the bpf-next tree, today's linux-next build (x86_64_perf)
> failed like this:
> 
>       CC      builtin-trace.o
>     builtin-trace.c: In function ‘syscall_arg__strtoul_btf_enum’:
>     builtin-trace.c:972:27: error: comparison of integer expressions of different signedness: ‘int’ and ‘__u32’ {aka ‘unsigned int’} [-Werror=sign-compare]
>       972 |         for (int i = 0; i < btf_vlen(bt); ++i, ++be) {
>           |                           ^
>       CC      util/btf.o
>     util/btf.c: In function ‘__btf_type__find_member_by_name’:
>     util/btf.c:19:43: error: comparison of integer expressions of different signedness: ‘int’ and ‘__u32’ {aka ‘unsigned int’} [-Werror=sign-compare]
>        19 |         for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
>           |                                           ^
> 
> Caused by commit
> 
>     f7a6b9eaff3e ("bpf: Extend BTF UAPI vlen, kinds to use unused bits")
> 
> I've fixed it up like below, but please fix this in your tree as well.
> 
> Thanks,
> Thierry
> 
> --- >8 ---
> From 4689669414ed7de19a69803714bc04e96fd82618 Mon Sep 17 00:00:00 2001
> From: Thierry Reding <treding@nvidia.com>
> Date: Mon, 27 Apr 2026 12:32:06 +0200
> Subject: [PATCH] perf: Fixup for btf_vlan() API change
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Thanks for the fix!

> ---
>  tools/perf/builtin-trace.c | 2 +-
>  tools/perf/util/btf.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index e58c49d047a2..d22e20a57b70 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -969,7 +969,7 @@ static bool syscall_arg__strtoul_btf_enum(char *bf, size_t size, struct syscall_
>  	struct btf *btf = arg->trace->btf;
>  	struct btf_enum *be = btf_enum(bt);
>  
> -	for (int i = 0; i < btf_vlen(bt); ++i, ++be) {
> +	for (u32 i = 0; i < btf_vlen(bt); ++i, ++be) {
>  		const char *name = btf__name_by_offset(btf, be->name_off);
>  		int max_len = max(size, strlen(name));
>  
> diff --git a/tools/perf/util/btf.c b/tools/perf/util/btf.c
> index bb163fe87767..50d98f3e83bf 100644
> --- a/tools/perf/util/btf.c
> +++ b/tools/perf/util/btf.c
> @@ -14,7 +14,7 @@ const struct btf_member *__btf_type__find_member_by_name(struct btf *btf,
>  {
>  	const struct btf_type *t = btf__type_by_id(btf, type_id);
>  	const struct btf_member *m;
> -	int i;
> +	u32 i;
>  
>  	for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
>  		const char *current_member_name = btf__name_by_offset(btf, m->name_off);


