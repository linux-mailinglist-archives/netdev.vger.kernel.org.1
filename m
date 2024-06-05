Return-Path: <netdev+bounces-101043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8668FD05A
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 16:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0C31C21661
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 14:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC53D2E6;
	Wed,  5 Jun 2024 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="aVlq55SL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A00B19D8A6;
	Wed,  5 Jun 2024 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717596204; cv=fail; b=EF2GB3+tqYfy5YDAWg0Kg+cwSlXp3rj6FsON0Byx5/G7d3Zahsq72+hl/vj3iMISB688F0eAoOp9ZgRSk4u2su11eo1T0C77rPegl8G+05T3tJIFyzo4vvGbNuQargy21qohbRGHTMm9dRPiE/8UT7xesdfzd7MueHD89hptAJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717596204; c=relaxed/simple;
	bh=parNKc90cVzgOFO0WRHWXA4XEVQdQLdxXc8dHQsLOYk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bDMyX+TMZB4OkIovDmPsYERA2AFxgVMul3x+Es0ppat7Cx5e7yOolECz9dJtKgVvs//PS2BUW6/tYjVkZ0JP3YeKVARnWdu3r2WQJX5QPh/oCbH3YFl3ROcX2/btwO970pcHXLEVUShsJldkM2GPU/JRr88IFNFvQgA4XnY4xBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=aVlq55SL; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455DEnrB003943;
	Wed, 5 Jun 2024 07:02:43 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yjrqug9wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 07:02:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6bsWA4nsXbeNn47GVRRQedVkC5CTR5iQrNaVVGDBgw5hpKmXH4pFpNzzJJA3/N3MFc0679ooCAoC/T7VzZv4xkTNcmXEhiZdd7T5SFUxETnicS4yPxjjPWI1iV1/GXWcWITSDOgV4PqWUOjQWb+/WHgcD4jdnTCo/cPuQBgUyyseqlrnqlECqsztMlAy9jhuRPSx2xIW9A5ATkX6rBfiFdchLW7a34eQ4zqYptXJgmjfvQtx9r+UVtzDgJjIgUWIIGl/G6DvQOZLN321c1a4OGkdE/F6eaiBDi0nEeWpiLmPiTsWCn4q0/6zCPQWDngx7CZ152Q1wgGmbsxhYXLjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDlaiUs3VU+WQhubdQXUCcdd4SsQ4qq/Ll35qpZAEHU=;
 b=WqEwCmjG8z1fwtGvoMZ6YKsz/CUdaIncEkGCgO/MX024vtr6lwfgWC/ZUf1OLbQjYDICQKTvfVAVW/nYplpx96s8tMNd1QLqewGLx3pvimMQ7Qr6E8LGlHfa7HP6N3OQ2a1NyOMQ61HR6ULGgZfVXuOCYtal34hlfBHS5ioayoDjq3lDu+PtP7rRahVbUF4ppmT1UWPZkC29iFLC4oKNXYYSjjcf4WVJmtQr0jaut+HbYVfOb9L9ZNe3SLdk9IlQ/+ZTuyXSUuunmCWrd/XkSnrAn/U3W6uiFDxHtABb25wc9MYJPvn3VRKRrTM5H1t8akIXdwaxbRooC+E0PWXR3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDlaiUs3VU+WQhubdQXUCcdd4SsQ4qq/Ll35qpZAEHU=;
 b=aVlq55SLIp/eTaKQxiIXEZxeYYLnHo99pYZXuRs1xaTHe5UKQPzZdzGAapWa2QWV6/7gYZgMOlABxx3qjr4nNJxakpURoFux41qc0PItKLhSn9axZgDFTsIG2wp8oska7of+4yA435WgOnbxzWz2oN8V/KmfRtCkjyuwBQzZLS8=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by LV8PR18MB5656.namprd18.prod.outlook.com (2603:10b6:408:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Wed, 5 Jun
 2024 14:02:39 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%5]) with mapi id 15.20.7633.018; Wed, 5 Jun 2024
 14:02:38 +0000
Message-ID: <b3658a1a-4ab9-4673-8060-22bdeb39a9ce@marvell.com>
Date: Wed, 5 Jun 2024 19:32:26 +0530
User-Agent: Mozilla Thunderbird
Subject: net: ethernet: stmmac: add management of stm32mp13 for stm32
To: Christophe Roullier <christophe.roullier@foss.st.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu
 <joabreu@synopsys.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Marek Vasut <marex@denx.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240604143502.154463-1-christophe.roullier@foss.st.com>
 <20240604143502.154463-8-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <20240604143502.154463-8-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::30) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|LV8PR18MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d5e637-bead-4aef-9bb7-08dc856828a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|7416005|376005|366007|1800799015|921011;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UTRDdWNUUGRWeDlXeUk0YVkrSlpYM3BsZ2ZzNEEvZkU3dDN1N1F0dHBud3lU?=
 =?utf-8?B?SmluRGtLMGVUeStQSHdWaGRnbGNtUkRJMy8vZHU3elJHbXJySlZlTHRHQVlW?=
 =?utf-8?B?ajlmRjIxQnFsYWdtakRmb050MVhVakJZeTVjYWY3QWZBQytpT05MK21QZHRM?=
 =?utf-8?B?dHhnb25zV0FPT0R5M2lOREdDODVzSVI5VDVubGJ6dk5YNFUzcXJwYW9wbFcz?=
 =?utf-8?B?cS9hbWlxNDRiN1VzYndKWThMekRJY1pLUnQ1d0w1RU4wQjlLTk42NEZKcjlY?=
 =?utf-8?B?MlE4dlFzZithSHJ1bHdVTVJ5emRYc2NZcFlKME8ySW1GSkVGTmRRQkVJZmpC?=
 =?utf-8?B?WUhHRzFlMkovejRoYlV6YnErZTd5eG95QmdtUXVoVzR3YnpWcjhOaTdwM3l5?=
 =?utf-8?B?Mm9HakwyMVk3YUptenJkK2RhdTNoeEduTDVUV0plTUJ0WGNjMlk0QUkwUVhY?=
 =?utf-8?B?Qk0xUUtYSEI4amUxZkVzNHdCUVllZkdWVEEvYWc1SEFEdGhpQzI1Q1l4UWpV?=
 =?utf-8?B?VFNRSTJGbHJhNmNqWlpMdnQxL2toVG96V2k2Z3M1anR4TVUzZlMrUnZzMGNh?=
 =?utf-8?B?VlhjZFJiTmVOenZPckd5UWdheDdNcWlFbW1uWUNvNXBZMXZ5VnlMbXhKZGI2?=
 =?utf-8?B?SGlDYTludTZOZjNTQUhxbmg4NFhIc3FhbmFWUkJQNUVUMElPZHB0aXNkQjNj?=
 =?utf-8?B?UHR5ZFg4bWNXQXUwcjBrT1FlV1lBOWlZVVQ5RDZYTVl5KzE4TGhMdndJdGlM?=
 =?utf-8?B?UFhpSHZxbWdrb0VDcGlENndZOS9rT2NsalVudnBmNXB3Y2s3RlNZN1BISS9y?=
 =?utf-8?B?VWNmUWVVRGNRL0xZeFlDb0pXN0ZaMEpuejRmeUczdjE3SmZqY0tpOWI5UWdX?=
 =?utf-8?B?b2h6bENBcVdETjF0cE95VytJVmE4NitSckZ5YS9laVQ4MCsrQlJPTVJGVDlq?=
 =?utf-8?B?cS9mRlcrT21pRTAwYWdxakF4aTJ1ZnNCY09wcURhWVlEbTgwMXFWTlpWRzNq?=
 =?utf-8?B?KzM3WlBBeTFRbzdFSVJnb3JGQysxaGZlQ1BCbWpiQjk2ZmJhWHk2YWtvMDlp?=
 =?utf-8?B?d2lWZ1JVZnJCTGJuMkZhNmVMcW15QjRhRkwyRXh3b1RzVGdPUy8vTFZkcEIw?=
 =?utf-8?B?dlROUFpaSkcyL0tCMlZob3dvbDlRMEN5eGNEOXlxdVdIeGlXQUN5bjdLUWxh?=
 =?utf-8?B?ZUF0Y3hVOHo0bjMxUzdlK1BXWVBiOXlsR21ZcWppUmpiMHY5S0lFOHdQejJj?=
 =?utf-8?B?ekExaFExSHpjbm9nTWc3R0xtMGZRN1NtcFZYa0kvNThqd2RVbFN0Z0ZGWU5E?=
 =?utf-8?B?OHZ5clJMY1I1OXB5N2JLTVpNVm5LNG5jZ0VIK3QrUHk0R1grd1RKRmp3SnQz?=
 =?utf-8?B?d0V0Y2RjeEVsL05zVTJrQmk5TzlpNVdYQTVTQVJwL2NpUVNiSTVVSFRhcmxK?=
 =?utf-8?B?VWJxMEJ0b3JFcis0ekt1OWdzTk9XT0phQ1dzODBLRUloSFFRVlpIMjVMbjg3?=
 =?utf-8?B?bmc3bldtd0cvclNzYndaejZsNzV1VDhkNE82TnR2cGZ4TExyZ0V6b1RTQWJX?=
 =?utf-8?B?ajBtdkpKQVY1SC94NjVrYnl3bVRtSks4dWNVRDRtKzhsbmN6bVcxTVhSK3F6?=
 =?utf-8?B?WHMwN2ozTFJ1S0xKcVpCb0xGUDExRWI1RTVJYUQ0MWh5TXhrNEp1MjBMcUF2?=
 =?utf-8?B?cXNuOEx1dFpHZUIzcFF5KzZRT1VOTnpmUFMxZDM3Y1pvRmpmTndPa3VmMHAz?=
 =?utf-8?B?QWNkMTFQbVRydkVrUmtjWnExc2NyOUhFaWNLTXFUU0ZDcVVoRjJ0NTVxVkI4?=
 =?utf-8?Q?08pmfQFRPT4SZfrZADw9LBS5WwI4xazmE3wos=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V0I3OGwvRElYd2RaN1ZOOUpBUUMrYlhHVVU4NlIzcjgwK1gwdWdHSUdqbjlX?=
 =?utf-8?B?aTI3RHN5ODJIVDl5bit3T2l1cWlqSzdWcm9XbWduSHJlK2hVdDJweVc0RXZx?=
 =?utf-8?B?ekpvdmpFMlhlaitJUmhlZjNmd0N1aU43M0UrNk9BQkRXS3hxOW1QNXlHWTFW?=
 =?utf-8?B?aTZhY1pGNHMvTjdteEM1cXZraXFUVHpKc0J5KzNmU2syRmVnNGRSRmpIakd2?=
 =?utf-8?B?QS8xZVNGaXpmRFV2MkFOUUFrTVNiUDRuM3o3TE95ZTRjWlZHaTlkQjNWTjBP?=
 =?utf-8?B?NmFHQ2JUeTlsNUN0YVlNVkM5Qk8yelUrT1ZEODl3M0hxQzZsdWszWkdkeHJt?=
 =?utf-8?B?WGM4U2pFWUtVWDFZOURoWFNyM3RabXFuMGVlbDNGSXE1TnpwL3RJYmJ6ZmV0?=
 =?utf-8?B?RUtTeXVBQjFpbVBZVTBwaXhjTW5NaVZNYnFiRy9QRU1zUW1TZ3VoM2pnNS8v?=
 =?utf-8?B?cjBBWlNSd0JYaVdvOVlCaG05VmNZMTNYTndZalM1d2JNcG1RSWVSWStCNUxN?=
 =?utf-8?B?VFpLTWdnWUZ5dytNTituYTg4Ym01Q0xPeHlpWWJMRzZyaDNwdVpEdXN6RUIy?=
 =?utf-8?B?WUxYa29UVUZDb1JoUEVQRVB6OWVDaEdxYUowWURFS2hBRWdzc2JaT0srSjBp?=
 =?utf-8?B?Rlp3bllqRFlMRDdJWXdIWjZnSzZTZXpyTkNDUE4zdzJ2c0Y0K2E3dkZSbk95?=
 =?utf-8?B?WFN0ZXBOemRnTitIVGRDbFlPRW9JNW9CTGFhUzJQRnF3c29jSXluNDErTXFO?=
 =?utf-8?B?NlNiTVBnc0NZdVN0UTNRTjJqMEg0UTkwNk1RdzNVL3FOZVBmOVRhZUJENkFL?=
 =?utf-8?B?TzQ1UC9yY0toR0JZSWJZZjM3M0tOL3h6SzVpS2pYdmJjaWdsTlZTWTRkNWor?=
 =?utf-8?B?ZEFVeXJWTmJZdUxncHg3aXMxcVFaY0c4UklYUUNKZlhERnJVY3g2Q3pEZDJo?=
 =?utf-8?B?MGhwWUlhdjMrV3VsYzFqUUUxZE5NdTFDekVHTkI1MisvUFlYS2tqNWd3RDM4?=
 =?utf-8?B?YmxydS9aaU5Wcm1KdU54KzJqcmltdURsT1NrbkVKVFgzaHVGUzZiQkpFd09k?=
 =?utf-8?B?S0Izcy9VV1FXVEkraVBqcEs3eUdOeFFCczVlTWsyU0owbkVwVU9KY2tUQTJ5?=
 =?utf-8?B?eHIweWZPMlJMM0xHNkVkZ3EwM2thb2NjRk9PUHJCUzM0RG1kY1NaSnFZS2VH?=
 =?utf-8?B?bU5qVi8veW5YRzIxUnVnUlR1SERJSDQvMlpTYmJ6NnJOa3BWTWJBcE9GU25R?=
 =?utf-8?B?K2IrRjdnRVNpaWNwZ3RBd0llUTdoOUNBOVkycm1acG5hK1RtQWpKallBenB4?=
 =?utf-8?B?QXVzektxRWJwNkEyQWZucVRhZ2MvaTdlZDAwTDhJUUcrMFl6TUhXdzBVeEEw?=
 =?utf-8?B?ZkRkRm5tYWFjOHVsWkRVM0tKVjBGSzdjeVg2ZS9OSlhyZEJKZWxwbHJSSWNJ?=
 =?utf-8?B?MlNXVmpCZFFnd1N3VkpDbUNrRXJXNG9mZXFDU013MmtOOXgrY0Vab2lMQWVM?=
 =?utf-8?B?YmxOYXpxMzQvRWpqK3I0S1JMZjZTd3lsR2dvQmVVK0xRWkc1Y0c5eE5VTDlQ?=
 =?utf-8?B?WTJ0OE80YnRlQlFOMHRZWWdtL1RkUzhLdzlmbWUyWmRvejduOEVoNUtEMEFO?=
 =?utf-8?B?OVFoWDBSMHY0bmJNY1FueVRIdWU2SGdWV1RRV29vZDFLbFFidkl0dmJ1Y0gv?=
 =?utf-8?B?cWxWZnMrV2FaemorNHl4S2xwZitDRGtKUml0S0I2bnlJSFZGMlhNZVpIUkUr?=
 =?utf-8?B?YjJoQ3VLTE56UWdHc3dpL1N4eWdVS1ViUWVSV1ZmaVFPU1J3VEkyK2VjZ1Vv?=
 =?utf-8?B?OXdwTzIwOUNpM0tEME4rOEowT3lhWUY5ajc4ci9OTDcwUnFTbGlmVE5haHJ1?=
 =?utf-8?B?NjduQzkwMUlwSDA3SVZPbUVSU0YzV3h1RkE2RlhKRzU0M21mNG92UVNlNG9z?=
 =?utf-8?B?VkhoNms2V2doV3FmVDFSalE0Yk5SbjJZaklFc2FCdEFLQ2d5MHBvZHI1M3Aw?=
 =?utf-8?B?ZDBJbnR3bnJlZG9WU3BjZlEySk9YRW5GaTE0dk9hRG0xS0lqYjd3NERNaE96?=
 =?utf-8?B?R1pSQWNwM2VzZXZLalNpb3l6SUs3OWZWa2ExNm41YlR5ZnpORVc5cUlQZzJs?=
 =?utf-8?Q?V15m6GQdNhkl2OENsttrnE6ey?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d5e637-bead-4aef-9bb7-08dc856828a9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 14:02:38.7794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgWV8F8jPL6PhY4f44OGC8OR+b9SZJLaQ05xK/Yc7ebtjeNjsDhndTvH0DZijCUkSJDm93vSBDdL3183J6IBFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5656
X-Proofpoint-ORIG-GUID: 9nWqLb_JRi57zEIW64EVO_0ov2cjcyHp
X-Proofpoint-GUID: 9nWqLb_JRi57zEIW64EVO_0ov2cjcyHp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01

> Add Ethernet support for STM32MP13.
> STM32MP13 is STM32 SOC with 2 GMACs instances.
> GMAC IP version is SNPS 4.20.
> GMAC IP configure with 1 RX and 1 TX queue.
> DMA HW capability register supported
> RX Checksum Offload Engine supported
> TX Checksum insertion supported
> Wake-Up On Lan supported
> TSO supported
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>   .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 50 +++++++++++++++----
>   1 file changed, 40 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> index bed2be129b2d2..e59f8a845e01e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> @@ -84,12 +84,14 @@ struct stm32_dwmac {
>   	struct clk *clk_eth_ck;
>   	struct clk *clk_ethstp;
>   	struct clk *syscfg_clk;
> +	bool is_mp13;
>   	int ext_phyclk;
>   	int enable_eth_ck;
>   	int eth_clk_sel_reg;
>   	int eth_ref_clk_sel_reg;
>   	int irq_pwr_wakeup;
>   	u32 mode_reg;		 /* MAC glue-logic mode register */
> +	u32 mode_mask;
>   	struct regmap *regmap;
>   	u32 speed;
>   	const struct stm32_ops *ops;
> @@ -102,8 +104,8 @@ struct stm32_ops {
>   	void (*resume)(struct stm32_dwmac *dwmac);
>   	int (*parse_data)(struct stm32_dwmac *dwmac,
>   			  struct device *dev);
> -	u32 syscfg_eth_mask;
>   	bool clk_rx_enable_in_suspend;
> +	u32 syscfg_clr_off;
>   };
>   
>   static int stm32_dwmac_clk_enable(struct stm32_dwmac *dwmac, bool resume)
> @@ -227,7 +229,14 @@ static int stm32mp1_configure_pmcr(struct plat_stmmacenet_data *plat_dat)
>   
>   	switch (plat_dat->mac_interface) {
>   	case PHY_INTERFACE_MODE_MII:
> -		val = SYSCFG_PMCR_ETH_SEL_MII;
> +		/*
> +		 * STM32MP15xx supports both MII and GMII, STM32MP13xx MII only.
> +		 * SYSCFG_PMCSETR ETH_SELMII is present only on STM32MP15xx and
> +		 * acts as a selector between 0:GMII and 1:MII. As STM32MP13xx
> +		 * supports only MII, ETH_SELMII is not present.
> +		 */
> +		if (!dwmac->is_mp13)	/* Select MII mode on STM32MP15xx */
> +			val |= SYSCFG_PMCR_ETH_SEL_MII;
>   		break;
>   	case PHY_INTERFACE_MODE_GMII:
>   		val = SYSCFG_PMCR_ETH_SEL_GMII;
> @@ -256,13 +265,16 @@ static int stm32mp1_configure_pmcr(struct plat_stmmacenet_data *plat_dat)
>   
>   	dev_dbg(dwmac->dev, "Mode %s", phy_modes(plat_dat->mac_interface));
>   
> +	/* Shift value at correct ethernet MAC offset in SYSCFG_PMCSETR */
> +	val <<= ffs(dwmac->mode_mask) - ffs(SYSCFG_MP1_ETH_MASK);
> +
>   	/* Need to update PMCCLRR (clear register) */
> -	regmap_write(dwmac->regmap, reg + SYSCFG_PMCCLRR_OFFSET,
> -		     dwmac->ops->syscfg_eth_mask);
> +	regmap_write(dwmac->regmap, dwmac->ops->syscfg_clr_off,
> +		     dwmac->mode_mask);
>   
>   	/* Update PMCSETR (set register) */
>   	return regmap_update_bits(dwmac->regmap, reg,
> -				 dwmac->ops->syscfg_eth_mask, val);
> +				 dwmac->mode_mask, val);
>   }
>   
>   static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
> @@ -303,7 +315,7 @@ static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
>   	dev_dbg(dwmac->dev, "Mode %s", phy_modes(plat_dat->mac_interface));
>   
>   	return regmap_update_bits(dwmac->regmap, reg,
> -				 dwmac->ops->syscfg_eth_mask, val << 23);
> +				 SYSCFG_MCU_ETH_MASK, val << 23);
>   }
>   
>   static void stm32_dwmac_clk_disable(struct stm32_dwmac *dwmac, bool suspend)
> @@ -348,8 +360,15 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
>   		return PTR_ERR(dwmac->regmap);
>   
>   	err = of_property_read_u32_index(np, "st,syscon", 1, &dwmac->mode_reg);
> -	if (err)
> +	if (err) {
>   		dev_err(dev, "Can't get sysconfig mode offset (%d)\n", err);

Shouldn't we decrement the refcount of np (‎of_node_put‎) before 
returning from this point?

> +		return err;
> +	}
> +
> +	dwmac->mode_mask = SYSCFG_MP1_ETH_MASK;
> +	err = of_property_read_u32_index(np, "st,syscon", 2, &dwmac->mode_mask);
> +	if (err)
> +		pr_debug("Warning sysconfig register mask not set\n");
>   
>   	return err;
>   }
> @@ -361,6 +380,8 @@ static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
>   	struct device_node *np = dev->of_node;
>   	int err = 0;
>   
> +	dwmac->is_mp13 = of_device_is_compatible(np, "st,stm32mp13-dwmac");
> +
>   	/* Ethernet PHY have no crystal */
>   	dwmac->ext_phyclk = of_property_read_bool(np, "st,ext-phyclk");
>   
> @@ -540,8 +561,7 @@ static SIMPLE_DEV_PM_OPS(stm32_dwmac_pm_ops,
>   	stm32_dwmac_suspend, stm32_dwmac_resume);
>   
>   static struct stm32_ops stm32mcu_dwmac_data = {
> -	.set_mode = stm32mcu_set_mode,
> -	.syscfg_eth_mask = SYSCFG_MCU_ETH_MASK
> +	.set_mode = stm32mcu_set_mode
>   };
>   
>   static struct stm32_ops stm32mp1_dwmac_data = {
> @@ -549,13 +569,23 @@ static struct stm32_ops stm32mp1_dwmac_data = {
>   	.suspend = stm32mp1_suspend,
>   	.resume = stm32mp1_resume,
>   	.parse_data = stm32mp1_parse_data,
> -	.syscfg_eth_mask = SYSCFG_MP1_ETH_MASK,
> +	.syscfg_clr_off = 0x44,
> +	.clk_rx_enable_in_suspend = true
> +};
> +
> +static struct stm32_ops stm32mp13_dwmac_data = {
> +	.set_mode = stm32mp1_set_mode,
> +	.suspend = stm32mp1_suspend,
> +	.resume = stm32mp1_resume,
> +	.parse_data = stm32mp1_parse_data,
> +	.syscfg_clr_off = 0x08,
>   	.clk_rx_enable_in_suspend = true
>   };
>   
>   static const struct of_device_id stm32_dwmac_match[] = {
>   	{ .compatible = "st,stm32-dwmac", .data = &stm32mcu_dwmac_data},
>   	{ .compatible = "st,stm32mp1-dwmac", .data = &stm32mp1_dwmac_data},
> +	{ .compatible = "st,stm32mp13-dwmac", .data = &stm32mp13_dwmac_data},
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, stm32_dwmac_match);


