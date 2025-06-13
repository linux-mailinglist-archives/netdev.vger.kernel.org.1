Return-Path: <netdev+bounces-197341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5CBAD82CE
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 07:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE1F18980FD
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 05:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE449253950;
	Fri, 13 Jun 2025 05:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JDxxjybq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xf+m8Zz6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77D924E4A8;
	Fri, 13 Jun 2025 05:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749794232; cv=fail; b=C2VUwhUux5vajaZEuEeYFmVue+YsroSqs6FfTCmvR8chSIg9c7EzV3vDHlB5xoc5yb03/qO8g513bKR2IVq86QEQuP3MMtcc29OJyFmsGI1qDCjS234upfBz1Wa13syiVE1zwYB/Lb+LkhO1AgMJq2PUheJtC7nJzGWJ6jyjbJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749794232; c=relaxed/simple;
	bh=uEEsCFolmiL2I6Tzgc9UULRXpUXtdAZlct8T6wH/2Zc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p07dK7W4kpsL5WQcuvGezSMafmByzk7ZnIiDMcO94Jr1ZV8APKFM6Kf55PWcGL3d8QXSCNavrDwJLvsFVpOqSR3RD2rj/Io3uX7v9m4NhWwo3bPtYUL+KCJjK2/OJDiaTOnz5XNRy/3pS6L7SQKFpTnGEBsRqxJ2lFkjCZhD2ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JDxxjybq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xf+m8Zz6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CMBu3o020531;
	Fri, 13 Jun 2025 05:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3gT9MVJZoRE+Z3i4sQilj1el0aTdlODI4VpruGyw8jA=; b=
	JDxxjybqKdWX1884ve1DI83pyItxy8Ql+okV0GQ15z3pRsUwR0op2i6+MO9GG1bI
	Jb3MBxmCpLOJEQ/I4prwA/76o9bV5rRLLuFIygGWuRJXbUaZGOg6+zjTKu/gp+jW
	JJMVscFpn9MDkGYbPkldT+mcKpGGXIgpRm/8xOUbOTtb+iaw4A22npLcV7j0ydk3
	0cmTRCobM7TbGt6lDE3NF23T8uPMjofWYKg9ipi38JMoBeBGZfxv67CwQ1oSAu++
	oziMWLzDUS9yPOeSbOQ8ysY1KrFWhKSsPktN2xbbh04F/cWzAim/VCSJAEj0gMfy
	jljTRMnhKGCZSsidNQHpuQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474bufawna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 05:56:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55D3Peio031867;
	Fri, 13 Jun 2025 05:56:01 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazon11011044.outbound.protection.outlook.com [40.93.199.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bvcgb15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 05:56:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzIGkE3H9EJ4wag/8UDzrA80OCr8dXPn7jnImtLDC6rbpqqNlHxvsymeM4+7h3exjsNalbAGL82xTXp33684aX7S+Z1iX1mT3TTbDjtN/CGyvPkHpocB67xmzQDP97rNza3+oFBLMLclXCYAAzqcRtIkjDvrEzVbRpDRonmrDyH2BLIEuvqPwBl99HVylMIOhel+FHohrwjLqv9N+UMvlduM5dmwXlHrY0NGvZgoMqaLwUUsNQxiTGjK5/jTXSjKz9HwZ++9CQjAeLLoATfS0Pry3oZv/cRw/VlEPHZhOwlsVYPbgsyale/6jWIT2pRjLdHhboUL4eF7zCXZfZ9zQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gT9MVJZoRE+Z3i4sQilj1el0aTdlODI4VpruGyw8jA=;
 b=ghVLSnzu7LBz49vvQX1Qdf1Y0A35zXLrAYMcwG18xRkv25/ucWXeIwmqfl8lFniUSxDRTKrJD6tG5e3SrGAz8USukdqkeurar3dbpenpj2+Ne2WJTVlLIqrzIyZQAte6wsTZE/vd+xvKtjd6+0nLUYchCl27x+lbyaBLwjjlFwK2Pr3DNf6CuFukWdaW/pFRMvc7EUqs70DyHumnkhCmk+p563et7wPdvqC0QGtPMTyK8RiYaCpq+mfEXdgQkiyw3DxMYv66eAextYdu7xk8Od15IcDLJYaTo/Kn2gV/4DNF2oF6Ja/wODCYQM7Ff170WSXK9aLRB+Kwrww75TgjcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gT9MVJZoRE+Z3i4sQilj1el0aTdlODI4VpruGyw8jA=;
 b=xf+m8Zz6VmF/E5/00j4ouDoPjUNUzFxSLrqYBKcPd6sNA2tKdkk3iC7nxevtap5VUPIFKzflfN8ohfNCt+zx8qLnHciLNkpe/uOAReB31q2wTDcO0adE+Rb6koeW0JQpq3OWAo6BiCYuSXh99xXzcl85aUYQi6GFoTsK3QlzjXE=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DM4PR10MB6135.namprd10.prod.outlook.com (2603:10b6:8:b6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.29; Fri, 13 Jun 2025 05:55:58 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 05:55:58 +0000
Message-ID: <896d8076-58f8-4aa9-919a-3d6a957ba549@oracle.com>
Date: Fri, 13 Jun 2025 11:25:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v02 1/1] hinic3: management interfaces
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <helgaas@kernel.org>,
        luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
        Shen Chenyang <shenchenyang1@hisilicon.com>,
        Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
        Shi Jing <shijing34@huawei.com>,
        Meny Yossefi <meny.yossefi@huawei.com>,
        Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Suman Ghosh <sumang@marvell.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Joe Damato <jdamato@fastly.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1749718348.git.zhuyikai1@h-partners.com>
 <11e6ee6effb60aa2c5fd79e7e3d59b03632a93f8.1749718348.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <11e6ee6effb60aa2c5fd79e7e3d59b03632a93f8.1749718348.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DM4PR10MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: a91188c3-9a5a-4686-2c05-08ddaa3ef7b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aCtoSXhqdFZVUXp3Wmt0cktCYnNuQ0pXV3JGRy8rOXhabkxWekt5c0h0R1Nl?=
 =?utf-8?B?Q0tXZ2YxRGEwSXhpVEllZWhIbW44QVoyZHFPN3lmbzNEQTMrOHFqMGY5WjJj?=
 =?utf-8?B?QUZmTmkyRzdpSkpFSDY5VkhzSUIzQmJudjZmWk9CMVM5U0xQTFJ6Z3pvd1Zi?=
 =?utf-8?B?RnpMQTh0enArRlk4REdWbmhHOFgzenJnWVFqVG51dnhWSldqK2pJeUgyRUdx?=
 =?utf-8?B?Rm82eFRieVlmemFIdkl0cFJSeHlJVE11bTR0T0RVVjlhZXdqMVNFTkVlYlpm?=
 =?utf-8?B?REVRRVE2MElSQko0UWRJa3BNSlBQZ2JhVjkvaFltWGRuVzdKODl5dWJKZnoy?=
 =?utf-8?B?STAvbmczTFppZjRSSnkxSlAxQnpSV3NER2ZaMzFVVEpnd0pGVkhsS0RXR3Rs?=
 =?utf-8?B?RUg0S1ZEUXdWNEZpaERHSG01bnptL0NoOTZZZzJyUm9FRC8xbysyeGtvOGxI?=
 =?utf-8?B?Rnd4QnR0QmltaEpjdlRwbmFmV2JvaTdYR0hSQkJ4OXVqSnVOaWE0U3l5Z0h2?=
 =?utf-8?B?YU0yYm5zcDB0RGZtYi9SWVRzQ1k2dG1QZUIxNHRidTVNTkhNbnVKUFBVTld2?=
 =?utf-8?B?RkE5WGIzUzMwR1RqekgyRm1ha3ZUakFRUHJjbVBmdEZoMHVtQWEydm5kV3Ez?=
 =?utf-8?B?YmRPek1QVjBaNUFabEtRS2w4ZjJJV1loMUdPMHl2ak53ak9SMVhYNlc2OFFR?=
 =?utf-8?B?eW44d0VMM011ZHQvRUw2aWJhRHhwTFBJczFaNmh0cC9SOXE3WVp5R3ExcXhm?=
 =?utf-8?B?cndjTG0rWndwVHE5VDhSbjNlc1ErbW5XMVJLWUxzckQvNGU4ZXQ4TGVxYjNq?=
 =?utf-8?B?QXhkUUExVTh5cDFsemdpWjJRNzV5ZG1pNmVybE5hRTA1enViTUVLeElhUTBp?=
 =?utf-8?B?VjNjWmhJcU8xUVVRMEZXUWlwUWwyVWE3cVFQcS9xZzFEclRDa1ZGcXpDSU5t?=
 =?utf-8?B?M0kvWjFOSzNOSFhMUU9FODFLaVlsc0VkTmljamZyZDRXakVMQXVOblVkNy9V?=
 =?utf-8?B?cUc1Y1BuVndONERQS1cwb3h6M0o5RWRiR3YxbzllcStTbzROakx3a3Yvb1J0?=
 =?utf-8?B?dXkxendYSXRybHI4bWUrb2dFTTRtT0lLUkwzMkRFUFg4OXN0RGJSd2NFWmFr?=
 =?utf-8?B?YllXRjQ2RFZWNWcvU2RrUXc5akhkR2Y4VVJZUzQzUjcyODlsak1ta1VjYkFi?=
 =?utf-8?B?ZWJBWFJLYzJvbTBDeWxuQUd6bm9ORjN6TCtlNmprMEJsM1loWjBQNjZRaTRi?=
 =?utf-8?B?ZHphZHdOaTZhTTVFUXJzQ2RhYXZRdjBVUVhpdGxxNDVpbUJ4ZFFObkpzS1ZE?=
 =?utf-8?B?TU5QcmRMZHBqQjNHN2NFK0w4d0lSK1BCUmlhTUtMSFhiU3ZYTEY5Y3BpQUxW?=
 =?utf-8?B?SW5TQ0wyM2VWZmNLc0ZEQm95N0JGQnMvSXFZdTVjVS9pNHVzRGtSaDc5RVk0?=
 =?utf-8?B?K2V4aUJUQTJBSzJQRVcrUXpuV0lYSjQyWmd3VDZuVkNNNzlQbit2TFNHTFFK?=
 =?utf-8?B?ZVJsTjByblpPVTc5NXhVWHN2aklpUFE3dElZR01KbXI4dEFpeGYvMC9KSnhV?=
 =?utf-8?B?ZFlOL0M3ZUxULzBsOTdEYzdlYjB5bklxVjRUSmY3SER3UnJUenFCMjZreEMz?=
 =?utf-8?B?c3BkSUVFb1I4YVIyL0hZMXFDS05xaXRUWnZyQlhwaWtrd1JPVWJiSGRNVVNK?=
 =?utf-8?B?UWlJSWpJb00wV1RNK1Jpb1prZlJaNVgwZi85RUtqdkc5bm9Wc2N0TmxEenQ3?=
 =?utf-8?B?d0lWUHZTNTN3anYwOWd5RVhJRTN5a3lYSWpsNlBPREhpTVgxd2FsbmpSNTB6?=
 =?utf-8?B?ZENUYmNLeWloWkFtVkhRdlNHby94UVNEeE9sNk1JRTFYL2FSMzAyVEN6RzNG?=
 =?utf-8?B?YS9MQkJJWUQ0aGVtWHBEdXlJeDcrWThqdWYyZGduZXd5RUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ly9BaU84MmsyNVlTWFcyNzV0L1ZqL25qSHYxNmQ2Z1dZQjUvWmtWWFdMZVpn?=
 =?utf-8?B?R2w2YmM1NElNNE5pdXQ3b01DbVp2TnYydjEvRVFvcFAyMTVjRExWc2l2YXRO?=
 =?utf-8?B?K05kS0tCTFBtQWZGUTFlNHpvWW1XY1ZmZ0RiZSs4QmhzSEhIVHZmbXkrTUt4?=
 =?utf-8?B?d1JDSDFpbXB0REE4Ykh4YmVBZkdxSXAxR2s2U2N1bk4vTUlLM0xyUEgwWTEv?=
 =?utf-8?B?bXptZmc0OFJQeXh1dWR5RFBWemNGVHBERFR1cEMra0I1SzFKWmQxWUwrQVRR?=
 =?utf-8?B?QUdBbmhpTGVVVk9XblVqRXpublhEU3lwS3p2RDJQUmVIdXYwYndPYmVkYTVr?=
 =?utf-8?B?eWpieEY4SEh0eHhzMFBjWUFLaE4vSVVSWHpJSVR2SnM2Z0xqR0FYeE1xQVBt?=
 =?utf-8?B?WDhxdyt6MS85bFo5WStMTkZ0Z2RFQ2dYbVEwOUtCektxamZVQ3FEa0cxZ2tE?=
 =?utf-8?B?WDZaaVJMYWdLRE5kU2E2dFpKV2oreTluTVhvc1JmdUs4UWo5MWlZdlNFOWpH?=
 =?utf-8?B?ZjI0YWFyZXBhQko2UmlydDUvZVNpYitpUm9qUlRZZmFuM3NtdWR4T2ZEaDJH?=
 =?utf-8?B?VUY0NEZ3VkYyejBZOERHazNRWE9oV2FraTVxZmRYYkNYZTBYanJKQ2VBN1Rl?=
 =?utf-8?B?QzBVR3JVQXRIYng3M0VReVZMWm5icEkzeERaYjhZaEVkckxSeW1VQmgvbStx?=
 =?utf-8?B?elJOcE1KQTh0MnFGeWI4WGdEb3JaMlo3YmFoQUtFVUdZTzNSenpOLytjTFNw?=
 =?utf-8?B?RkZnSnhIa1VBOFJrRlJQQmtUN3JvR3B4U3c3bzdYU3A3T2JqRUw4YWtTOHpG?=
 =?utf-8?B?cHlEdmh5V0ZESmU5amVtL1BXc0t1VmwyTVlNa2NGcWVVTjlPTVpWSHRZaWZ0?=
 =?utf-8?B?R3ZZQmFpYzluY3h4ejA3TXR1LzdCQ2FCK1VxbkdJRGNZa0xHZUdzOFQ4WUZl?=
 =?utf-8?B?YlYyc3NqWWMzaWZtSnVsMkFsMnBSY2NqY1RRY1QvNFFXTjlHN1V1elMzRWR4?=
 =?utf-8?B?WmppcC9uNzl6dUVzVG1RU3F4RDNOLzdQZldiTzdUZnFwalJRMW9oMVJjbXhP?=
 =?utf-8?B?VHV5cnFKL2lRL2JCSFA3SHduS3IzWDhLTXdIemhPUlZIemsyQmRSb0t4L3JS?=
 =?utf-8?B?TlA3QXhwbzZZZVRjekZOUVNhNFFidTJodWg2Z3pKUXQ1UFUwSXF5L3ZQUHlT?=
 =?utf-8?B?Ui82N280L1dNQW1aMlhveUIzcmJiM01aQ0tweXUrSUNrcXVXc2RWbUF5Z2ds?=
 =?utf-8?B?SnhKWmE4YXlFMnhsUjFXWkJiSnpXOEFnV2tkY2llM09GSWx4V0ZJNEhmZkxy?=
 =?utf-8?B?d0M4RUJWRFEwWGM2TWVrcHN1d0pTSTR0SDR6b2VmWVdOYUJPTDUzU0pDQWha?=
 =?utf-8?B?aDZrUkQraU5vUmtmYnF6ZFREL0ZvSE5lRXhrM0R3UXVaRE91TDVvLzJpb3Iz?=
 =?utf-8?B?bjc5NEh4RTJMNkhFTlhQSGswYnBKMFNUT1MxUDlQTG5idkN6SGpYOHlRdFZ4?=
 =?utf-8?B?Z3ArWTlZRnpMNDVGdlZOMkVDOHpiQmJkK2RsU3VOQU9mVzBscTB5R09pL0hu?=
 =?utf-8?B?WDdvSWhMQjRGaVRnclFRY001YjN3dnNVM09xTjd6SVR0WTM3OGlxQ2crQkVT?=
 =?utf-8?B?NmhEN0MvcFRuU3M5MjdNakdRM01Rb2tXSVZSWGFXN2xZT0ZsTENHS3J2R3dz?=
 =?utf-8?B?SkRUNUJycDFBNDJ0YWJsRyt4a2dIMlpnbXpZajJzU0cxbm02Z2lvYzUzVzRJ?=
 =?utf-8?B?UENQQWE5OFNWUjFXN0hYdk5iS2w5Y2U2Wlo4UU4xajlGR28vcHdZZmZ3R3pT?=
 =?utf-8?B?OTdpaDh6eXMzeHZLd1lhMVN1OW83TzFpRzMxNytXajNQTEw4SDZMSkdOVWxG?=
 =?utf-8?B?V1VUSzU5OUZ4V2pkSGhidlFPY0VrQzJnSldZOFlaeVVzd3ljaWhYUWFFUEVC?=
 =?utf-8?B?d3VRWmxxWUw1SXRrdUFVblFiaGQ0NjF0N09FK1V5MXVtQjJ0SVZsbEFTVm52?=
 =?utf-8?B?VHY2UDBNWVJ0TzhhcFl0SlJ1RlIvVGQ4elc4Q3VDdWpDTTE1SHNHUkNXdDdB?=
 =?utf-8?B?QW1QUHVVQnQxNXVHQ0Q1bGFKYmJYTEg3ZFFwZVcvYUUrbm5rSm04bm1NMWVx?=
 =?utf-8?Q?RMkSVnLYLHnvFNZ9KaHcRDsPC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OY+AWRydEOulY0yRuMbQxPb6i76pIuYbHeh3hWXJikttaEdIKcmyq8+AK5zWUE/J/yRj94oSeAPZi5XVQzrEw/FWtDfheW4kZVhc0fPQn0952qhgYDeVmGraSZlRl9UBFy5gCk+qFwwTikHHmS8hHWQ/YqZO5BzQEWFOaVVFdN/4m0BWHLvYoszvYPTPhtMiIppyoJ36u3rKiaqBmDYxOQcdDj3pobmr12ICMsjJa6Rvy47txJtukoAInS78dQt2cTTs7oKNJX80MHeyMz03eGvr5tUuzetkFSljcU3BkRb32EetKaNoZaWvKAgDdO4zMvho3fkNftGB3kl8SkQZ99rWrhH90afN3slZZWSPH2iD0S1lkmcyI/xxuenW0sfy4LMLHbxe66WcM4ZoBDfMG7+VZuFu/aufUZAtCrZVwE9jg8W4DC+BkepklnJ+JcqYnHIqPQBPQDi43nrUiTux9pXrysPlCI3DLsARkWMb1Lq3oEsRwqHN+T2zV51wvixQTanzFerytPBC/TTeiq7bOwvY3zyThFLKNLlIf7u4PTuM0M6EjaAvI563ZOwCQq7KRXERxhCbQ3DQtrVvwlVxYFzxW8Vq3WkGk1gR5TouLOQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91188c3-9a5a-4686-2c05-08ddaa3ef7b2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 05:55:58.0955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TryCOfkXF7vCPLVZmYep7p8Ef7+CeUtNr0PMxP79w6LmpxbH5TUMu/AhMbdAkY1zENE4H9B2ML+7+S55L7Gpo1AHlGvdvuQxoPvbIIMJk/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506130042
X-Authority-Analysis: v=2.4 cv=RZGQC0tv c=1 sm=1 tr=0 ts=684bbd72 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=i0EeH86SAAAA:8 a=u7uoXELoAAAA:8 a=WcL0J8WPU_yqhGTEE9oA:9 a=QEXdDO2ut3YA:10 a=07tN73Fy-TQQJT60VmHH:22
X-Proofpoint-GUID: E7VVr3DjHF6HbsCFRDrwvImBy3tvb2_L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDA0MiBTYWx0ZWRfX9g9ErRO4Am8g yuSqb5l8yH1Bzq5drNW15MEMrjYBwBAh20uYE/DAvOMUmjVh1JuK8sO3W8fDLQtMZoS2DmC3Lr7 0ZAnreWTy/rSEOqVnVAA3sqqJwErXW0gl7f4HPtdyBPUpMznglGGa6O0/bfgY7t/KDAsZkYtAr4
 3Tmk+g9JWo7ZbWxV+EVWi0j8FaZrSS5lTzPSg2rke1X6TZto20HoKZqNO9Z3H5Rco9nzghm0t7y NzrUNhpVLQZCzs8Tm74qNJxMCP1u7R/pBv32yjnjAd468PTpLEtq9vgWnS/uNzoU2iD5UCsjvW5 JT4BpPFu7RhYvXfEfcU2Xc98K3EXHRO2PwKRX2stxrUxsrEGsevskXJujXSzlvxY7FqHpVJZ5Az
 x4KS2PLIxrxKx67QvzoN965C5EacyWVjEniLEK1ArOXP2abfNmtHN6rNX5DRYCX59aCcJxhi
X-Proofpoint-ORIG-GUID: E7VVr3DjHF6HbsCFRDrwvImBy3tvb2_L



On 12-06-2025 14:58, Fan Gong wrote:
> This is [2/3] part of hinic3 Ethernet driver initial submission.
> With this patch hinic3 is a valid kernel module but non-functional
> driver.
> 
> The driver parts contained in this patch:
> Mailbox management interface.
> Command queue management interface.
> Event queues, AEQ and CEQ upon which management relies.
> Some of thew IRQ implementation but without full initialization yet.
> 
> Co-developed-by: Xin Guo <guoxin09@huawei.com>
> Signed-off-by: Xin Guo <guoxin09@huawei.com>
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> ---

> @@ -3,7 +3,9 @@
>   
>   obj-$(CONFIG_HINIC3) += hinic3.o
>   
> -hinic3-objs := hinic3_common.o \
> +hinic3-objs := hinic3_cmdq.o \
[clip]
> +
> +static struct hinic3_ceqs *ceq_to_ceqs(const struct hinic3_eq *eq)
> +{
> +	return container_of(eq, struct hinic3_ceqs, ceq[eq->q_id]);
> +}
> +
> +static void ceq_event_handler(struct hinic3_ceqs *ceqs, u32 ceqe)
> +{
> +	enum hinic3_ceq_event event = CEQE_TYPE(ceqe);
> +	struct hinic3_hwdev *hwdev = ceqs->hwdev;
> +	u32 ceqe_data = CEQE_DATA(ceqe);
> +
> +	if (event >= HINIC3_MAX_CEQ_EVENTS) {
> +		dev_warn(hwdev->dev, "Ceq unknown event:%d, ceqe date: 0x%x\n",

typo date -> data

> +			 event, ceqe_data);
> +		return;
> +	}
> +
> +	set_bit(HINIC3_CEQ_CB_RUNNING, &ceqs->ceq_cb_state[event]);
> +	/* Ensure unregister sees we are running. */
> +	mb();
> +	if (ceqs->ceq_cb[event] &&
> +	    test_bit(HINIC3_CEQ_CB_REG, &ceqs->ceq_cb_state[event]))
> +		ceqs->ceq_cb[event](hwdev, ceqe_data);
> +
> +	clear_bit(HINIC3_CEQ_CB_RUNNING, &ceqs->ceq_cb_state[event]);
> +}
> +
[clip]
> +}
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h
> new file mode 100644
> index 000000000000..9110f78892b9
> --- /dev/null
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.h
> @@ -0,0 +1,130 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. */
> +
> +#ifndef _HINIC3_EQS_H_
> +#define _HINIC3_EQS_H_
> +
> +#include <linux/interrupt.h>
> +
> +#include "hinic3_hw_cfg.h"
> +#include "hinic3_queue_common.h"
> +
> +#define HINIC3_MAX_AEQS             4
> +#define HINIC3_MAX_CEQS             32
> +
> +#define HINIC3_AEQ_MAX_PAGES        4
> +#define HINIC3_CEQ_MAX_PAGES        8
> +
> +#define HINIC3_AEQE_SIZE            64
> +#define HINIC3_CEQE_SIZE            4
> +
> +#define HINIC3_AEQE_DESC_SIZE       4
> +#define HINIC3_AEQE_DATA_SIZE       (HINIC3_AEQE_SIZE - HINIC3_AEQE_DESC_SIZE)
> +
> +#define HINIC3_DEFAULT_AEQ_LEN      0x10000
> +#define HINIC3_DEFAULT_CEQ_LEN      0x10000
> +
> +#define HINIC3_EQ_IRQ_NAME_LEN      64
> +
> +#define HINIC3_EQ_USLEEP_LOW_BOUND  900
> +#define HINIC3_EQ_USLEEP_HIG_BOUND  1000

cab it be *HIGH_BOUND ?

> +
> +enum hinic3_eq_type {
> +	HINIC3_AEQ = 0,
> +	HINIC3_CEQ = 1,
> +};
> +
> +enum hinic3_eq_intr_mode {
> +	HINIC3_INTR_MODE_ARMED  = 0,
> +	HINIC3_INTR_MODE_ALWAYS = 1,
> +};
> +
> +enum hinic3_eq_ci_arm_state {
> +	HINIC3_EQ_NOT_ARMED = 0,
> +	HINIC3_EQ_ARMED     = 1,
> +};
> +
> +struct hinic3_eq {
> +	struct hinic3_hwdev       *hwdev;
> +	struct hinic3_queue_pages qpages;
> +	u16                       q_id;
> +	enum hinic3_eq_type       type;
> +	u32                       eq_len;
> +	u32                       cons_idx;
> +	u8                        wrapped;
> +	u32                       irq_id;
> +	u16                       msix_entry_idx;
> +	char                      irq_name[HINIC3_EQ_IRQ_NAME_LEN];
> +	struct work_struct        aeq_work;
> +	struct tasklet_struct     ceq_tasklet;
> +};
> +
> +struct hinic3_aeq_elem {
> +	u8     aeqe_data[HINIC3_AEQE_DATA_SIZE];
> +	__be32 desc;
> +};
> +
> +enum hinic3_aeq_cb_state {
> +	HINIC3_AEQ_CB_REG     = 0,
> +	HINIC3_AEQ_CB_RUNNING = 1,
> +};
> +
> +enum hinic3_aeq_type {
> +	HINIC3_HW_INTER_INT   = 0,
> +	HINIC3_MBX_FROM_FUNC  = 1,
> +	HINIC3_MSG_FROM_FW    = 2,
> +	HINIC3_MAX_AEQ_EVENTS = 6,
> +};
> +
> +typedef void (*hinic3_aeq_event_cb)(struct hinic3_hwdev *hwdev, u8 *data,
> +				    u8 size);
> +
> +struct hinic3_aeqs {
> +	struct hinic3_hwdev     *hwdev;
> +	hinic3_aeq_event_cb     aeq_cb[HINIC3_MAX_AEQ_EVENTS];
> +	unsigned long           aeq_cb_state[HINIC3_MAX_AEQ_EVENTS];
> +	struct hinic3_eq        aeq[HINIC3_MAX_AEQS];
> +	u16                     num_aeqs;
> +	struct workqueue_struct *workq;
> +};
> +
> +enum hinic3_ceq_cb_state {
> +	HINIC3_CEQ_CB_REG     = 0,
> +	HINIC3_CEQ_CB_RUNNING = 1,
> +};
> +
> +enum hinic3_ceq_event {
> +	HINIC3_CMDQ               = 3,
> +	HINIC3_MAX_CEQ_EVENTS     = 6,
> +};
> +
> +typedef void (*hinic3_ceq_event_cb)(struct hinic3_hwdev *hwdev, u32 ceqe_data);
> +
> +struct hinic3_ceqs {
> +	struct hinic3_hwdev *hwdev;
> +
> +	hinic3_ceq_event_cb ceq_cb[HINIC3_MAX_CEQ_EVENTS];
> +	unsigned long       ceq_cb_state[HINIC3_MAX_CEQ_EVENTS];
> +
> +	struct hinic3_eq    ceq[HINIC3_MAX_CEQS];
> +	u16                 num_ceqs;
> +};
> +
> +int hinic3_aeqs_init(struct hinic3_hwdev *hwdev, u16 num_aeqs,
> +		     struct msix_entry *msix_entries);
> +void hinic3_aeqs_free(struct hinic3_hwdev *hwdev);
> +int hinic3_aeq_register_cb(struct hinic3_hwdev *hwdev,
> +			   enum hinic3_aeq_type event,
> +			   hinic3_aeq_event_cb hwe_cb);
> +void hinic3_aeq_unregister_cb(struct hinic3_hwdev *hwdev,
> +			      enum hinic3_aeq_type event);
> +int hinic3_ceqs_init(struct hinic3_hwdev *hwdev, u16 num_ceqs,
> +		     struct msix_entry *msix_entries);
> +void hinic3_ceqs_free(struct hinic3_hwdev *hwdev);
> +int hinic3_ceq_register_cb(struct hinic3_hwdev *hwdev,
> +			   enum hinic3_ceq_event event,
> +			   hinic3_ceq_event_cb callback);
> +void hinic3_ceq_unregister_cb(struct hinic3_hwdev *hwdev,
> +			      enum hinic3_ceq_event event);
> +
> +#endif
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
> index 87d9450c30ca..d1507f845e12 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
> @@ -8,6 +8,48 @@
>   #include "hinic3_hwif.h"
>   #include "hinic3_mbox.h"
>   
> +int hinic3_alloc_irqs(struct hinic3_hwdev *hwdev, u16 num,
> +		      struct msix_entry *alloc_arr, u16 *act_num)
> +{
> +	struct hinic3_irq_info *irq_info;
> +	struct hinic3_irq *curr;
> +	u16 i, found = 0;
> +
> +	irq_info = &hwdev->cfg_mgmt->irq_info;
> +	mutex_lock(&irq_info->irq_mutex);
> +	for (i = 0; i < irq_info->num_irq && found < num; i++) {
> +		curr = irq_info->irq + i;
> +		if (curr->allocated)
> +			continue;
> +		curr->allocated = true;
> +		alloc_arr[found].vector = curr->irq_id;
> +		alloc_arr[found].entry = curr->msix_entry_idx;
> +		found++;
> +	}
> +	mutex_unlock(&irq_info->irq_mutex);
> +
> +	*act_num = found;
> +	return found == 0 ? -ENOMEM : 0;
> +}
> +
> +void hinic3_free_irq(struct hinic3_hwdev *hwdev, u32 irq_id)
> +{
> +	struct hinic3_irq_info *irq_info;
> +	struct hinic3_irq *curr;
> +	u16 i;
> +
> +	irq_info = &hwdev->cfg_mgmt->irq_info;
> +	mutex_lock(&irq_info->irq_mutex);
> +	for (i = 0; i < irq_info->num_irq; i++) {
> +		curr = irq_info->irq + i;
> +		if (curr->irq_id == irq_id) {
> +			curr->allocated = false;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&irq_info->irq_mutex);
> +}
> +
>   bool hinic3_support_nic(struct hinic3_hwdev *hwdev)
>   {
>   	return hwdev->cfg_mgmt->cap.supp_svcs_bitmap &
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
> index 434696ce7dc2..3e191b01f104 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
> @@ -8,6 +8,37 @@
>   #include "hinic3_hwif.h"
>   #include "hinic3_mbox.h"
>   
> +int hinic3_set_interrupt_cfg_direct(struct hinic3_hwdev *hwdev,
> +				    const struct hinic3_interrupt_info *info)
> +{
> +	struct comm_cmd_cfg_msix_ctrl_reg msix_cfg = {};
> +	struct mgmt_msg_params msg_params = {};
> +	int err;
> +
> +	msix_cfg.func_id = hinic3_global_func_id(hwdev);
> +	msix_cfg.msix_index = info->msix_index;
> +	msix_cfg.opcode = MGMT_MSG_CMD_OP_SET;
> +
> +	msix_cfg.lli_credit_cnt = info->lli_credit_limit;
> +	msix_cfg.lli_timer_cnt = info->lli_timer_cfg;
> +	msix_cfg.pending_cnt = info->pending_limt;
> +	msix_cfg.coalesce_timer_cnt = info->coalesc_timer_cfg;
> +	msix_cfg.resend_timer_cnt = info->resend_timer_cfg;
> +
> +	mgmt_msg_params_init_default(&msg_params, &msix_cfg, sizeof(msix_cfg));
> +
> +	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_COMM,
> +				       COMM_CMD_CFG_MSIX_CTRL_REG, &msg_params);
> +	if (err || msix_cfg.head.status) {
> +		dev_err(hwdev->dev,
> +			"Failed to set interrupt config, err: %d, status: 0x%x\n",
> +			err, msix_cfg.head.status);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_flag)
>   {
>   	struct comm_cmd_func_reset func_reset = {};
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
> index c33a1c77da9c..899918cc8011 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
> @@ -8,6 +8,19 @@
>   
>   struct hinic3_hwdev;
>   
> +struct hinic3_interrupt_info {
> +	u32 lli_set;
> +	u32 interrupt_coalesc_set;
> +	u16 msix_index;
> +	u8  lli_credit_limit;
> +	u8  lli_timer_cfg;
> +	u8  pending_limt;

pending_limt -> pending_limit

> +	u8  coalesc_timer_cfg;
> +	u8  resend_timer_cfg;
> +};
> +
> +int hinic3_set_interrupt_cfg_direct(struct hinic3_hwdev *hwdev,
> +				    const struct hinic3_interrupt_info *info);
>   int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_flag);
>   
>   #endif
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
> index 22c84093efa2..5f161f1314ac 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
> @@ -70,6 +70,20 @@ enum comm_cmd {
>   	COMM_CMD_SET_DMA_ATTR            = 25,
>   };
>   
> +struct comm_cmd_cfg_msix_ctrl_reg {
> +	struct mgmt_msg_head head;
> +	u16                  func_id;
> +	u8                   opcode;
> +	u8                   rsvd1;
> +	u16                  msix_index;
> +	u8                   pending_cnt;
> +	u8                   coalesce_timer_cnt;
> +	u8                   resend_timer_cnt;
> +	u8                   lli_timer_cnt;
> +	u8                   lli_credit_cnt;
> +	u8                   rsvd2[5];
> +};
> +
>   enum comm_func_reset_bits {
>   	COMM_FUNC_RESET_BIT_FLUSH        = BIT(0),
>   	COMM_FUNC_RESET_BIT_MQM          = BIT(1),
> @@ -100,6 +114,28 @@ struct comm_cmd_feature_nego {
>   	u64                  s_feature[COMM_MAX_FEATURE_QWORD];
>   };
>   
> +struct comm_cmd_set_ceq_ctrl_reg {
> +	struct mgmt_msg_head head;
> +	u16                  func_id;
> +	u16                  q_id;
> +	u32                  ctrl0;
> +	u32                  ctrl1;
> +	u32                  rsvd1;
> +};
> +
> +struct comm_cmdq_ctxt_info {
> +	u64 curr_wqe_page_pfn;
> +	u64 wq_block_pfn;
> +};
> +
> +struct comm_cmd_set_cmdq_ctxt {
> +	struct mgmt_msg_head       head;
> +	u16                        func_id;
> +	u8                         cmdq_id;
> +	u8                         rsvd1[5];
> +	struct comm_cmdq_ctxt_info ctxt;
> +};
> +
>   /* Services supported by HW. HW uses these values when delivering events.
>    * HW supports multiple services that are not yet supported by driver
>    * (e.g. RoCE).
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
> index 0865453bf0e7..bd6dbe047234 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
> @@ -6,13 +6,163 @@
>   #include <linux/io.h>
>   
>   #include "hinic3_common.h"
> +#include "hinic3_csr.h"
>   #include "hinic3_hwdev.h"
>   #include "hinic3_hwif.h"
>   
> +/* config BAR45 4MB, DB & DWQE both 2MB */

can be missleading BAR45 -> BAR4/5

> +#define HINIC3_DB_DWQE_SIZE    0x00400000
> +
> +/* db/dwqe page size: 4K */
> +#define HINIC3_DB_PAGE_SIZE    0x00001000
> +#define HINIC3_DWQE_OFFSET     0x00000800
> +#define HINIC3_DB_MAX_AREAS    (HINIC3_DB_DWQE_SIZE / HINIC3_DB_PAGE_SIZE)
> +
> +#define HINIC3_GET_REG_ADDR(reg)  ((reg) & (HINIC3_REGS_FLAG_MASK))
> +
> +static void __iomem *hinic3_reg_addr(struct hinic3_hwif *hwif, u32 reg)
> +{
> +	return hwif->cfg_regs_base + HINIC3_GET_REG_ADDR(reg);
> +}
> +
> +u32 hinic3_hwif_read_reg(struct hinic3_hwif *hwif, u32 reg)
> +{
> +	void __iomem *addr = hinic3_reg_addr(hwif, reg);
> +	__be32 raw_val;
> +
> +	raw_val = (__force __be32)readl(addr);
> +	return be32_to_cpu(raw_val);
> +}
> +
> +void hinic3_hwif_write_reg(struct hinic3_hwif *hwif, u32 reg, u32 val)
> +{
> +	void __iomem *addr = hinic3_reg_addr(hwif, reg);
> +	__be32 raw_val = cpu_to_be32(val);
> +
> +	writel((__force u32)raw_val, addr);
> +}
> +
> +static int get_db_idx(struct hinic3_hwif *hwif, u32 *idx)
> +{
> +	struct hinic3_db_area *db_area = &hwif->db_area;
> +	u32 pg_idx;
> +
> +	spin_lock(&db_area->idx_lock);
> +	pg_idx = find_first_zero_bit(db_area->db_bitmap_array,
> +				     db_area->db_max_areas);
> +	if (pg_idx == db_area->db_max_areas) {
> +		spin_unlock(&db_area->idx_lock);
> +		return -ENOMEM;
> +	}
> +	set_bit(pg_idx, db_area->db_bitmap_array);
> +	spin_unlock(&db_area->idx_lock);
> +
> +	*idx = pg_idx;
> +
> +	return 0;
> +}
> +
> +static void free_db_idx(struct hinic3_hwif *hwif, u32 idx)
> +{
> +	struct hinic3_db_area *db_area = &hwif->db_area;
> +
> +	spin_lock(&db_area->idx_lock);
> +	clear_bit(idx, db_area->db_bitmap_array);
> +	spin_unlock(&db_area->idx_lock);
> +}
> +
> +void hinic3_free_db_addr(struct hinic3_hwdev *hwdev, const u8 __iomem *db_base)
> +{
> +	struct hinic3_hwif *hwif;
> +	uintptr_t distance;
> +	u32 idx;
> +
> +	hwif = hwdev->hwif;
> +	distance = (const char __iomem *)db_base -
> +		   (const char __iomem *)hwif->db_base;
> +	idx = distance / HINIC3_DB_PAGE_SIZE;
> +
> +	free_db_idx(hwif, idx);
> +}
> +
> +int hinic3_alloc_db_addr(struct hinic3_hwdev *hwdev, void __iomem **db_base,
> +			 void __iomem **dwqe_base)
> +{
> +	struct hinic3_hwif *hwif;
> +	u8 __iomem *addr;
> +	u32 idx;
> +	int err;
> +
> +	hwif = hwdev->hwif;
> +
> +	err = get_db_idx(hwif, &idx);
> +	if (err)
> +		return err;
> +
> +	addr = hwif->db_base + idx * HINIC3_DB_PAGE_SIZE;
> +	*db_base = addr;
> +
> +	if (dwqe_base)
> +		*dwqe_base = addr + HINIC3_DWQE_OFFSET;
> +
> +	return 0;
> +}
> +
>   void hinic3_set_msix_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
>   			   enum hinic3_msix_state flag)
>   {
> -	/* Completed by later submission due to LoC limit. */
> +	struct hinic3_hwif *hwif;
> +	u8 int_msk = 1;
> +	u32 mask_bits;
> +	u32 addr;
> +
> +	hwif = hwdev->hwif;
> +
> +	if (flag)
> +		mask_bits = HINIC3_MSI_CLR_INDIR_SET(int_msk, INT_MSK_SET);
> +	else
> +		mask_bits = HINIC3_MSI_CLR_INDIR_SET(int_msk, INT_MSK_CLR);
> +	mask_bits = mask_bits |
> +		    HINIC3_MSI_CLR_INDIR_SET(msix_idx, SIMPLE_INDIR_IDX);
> +
> +	addr = HINIC3_CSR_FUNC_MSI_CLR_WR_ADDR;
> +	hinic3_hwif_write_reg(hwif, addr, mask_bits);
> +}
> +
> +void hinic3_msix_intr_clear_resend_bit(struct hinic3_hwdev *hwdev, u16 msix_idx,
> +				       u8 clear_resend_en)
> +{
> +	struct hinic3_hwif *hwif;
> +	u32 msix_ctrl, addr;
> +
> +	hwif = hwdev->hwif;
> +
> +	msix_ctrl = HINIC3_MSI_CLR_INDIR_SET(msix_idx, SIMPLE_INDIR_IDX) |
> +		    HINIC3_MSI_CLR_INDIR_SET(clear_resend_en, RESEND_TIMER_CLR);
> +
> +	addr = HINIC3_CSR_FUNC_MSI_CLR_WR_ADDR;
> +	hinic3_hwif_write_reg(hwif, addr, msix_ctrl);
> +}
> +
> +void hinic3_set_msix_auto_mask_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
> +				     enum hinic3_msix_auto_mask flag)
> +{
> +	struct hinic3_hwif *hwif;
> +	u32 mask_bits;
> +	u32 addr;
> +
> +	hwif = hwdev->hwif;
> +
> +	if (flag)
> +		mask_bits = HINIC3_MSI_CLR_INDIR_SET(1, AUTO_MSK_SET);
> +	else
> +		mask_bits = HINIC3_MSI_CLR_INDIR_SET(1, AUTO_MSK_CLR);
> +
> +	mask_bits = mask_bits |
> +		    HINIC3_MSI_CLR_INDIR_SET(msix_idx, SIMPLE_INDIR_IDX);
> +
> +	addr = HINIC3_CSR_FUNC_MSI_CLR_WR_ADDR;
> +	hinic3_hwif_write_reg(hwif, addr, mask_bits);
>   }
>   
>   u16 hinic3_global_func_id(struct hinic3_hwdev *hwdev)
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
> index 513c9680e6b6..29dd86eb458a 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
> @@ -50,8 +50,24 @@ enum hinic3_msix_state {
>   	HINIC3_MSIX_DISABLE,
>   };
>   
> +enum hinic3_msix_auto_mask {
> +	HINIC3_CLR_MSIX_AUTO_MASK,
> +	HINIC3_SET_MSIX_AUTO_MASK,
> +};
> +
> +u32 hinic3_hwif_read_reg(struct hinic3_hwif *hwif, u32 reg);
> +void hinic3_hwif_write_reg(struct hinic3_hwif *hwif, u32 reg, u32 val);
> +
> +int hinic3_alloc_db_addr(struct hinic3_hwdev *hwdev, void __iomem **db_base,
> +			 void __iomem **dwqe_base);
> +void hinic3_free_db_addr(struct hinic3_hwdev *hwdev, const u8 __iomem *db_base);
> +
>   void hinic3_set_msix_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
>   			   enum hinic3_msix_state flag);
> +void hinic3_msix_intr_clear_resend_bit(struct hinic3_hwdev *hwdev, u16 msix_idx,
> +				       u8 clear_resend_en);
> +void hinic3_set_msix_auto_mask_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
> +				     enum hinic3_msix_auto_mask flag);
>   
>   u16 hinic3_global_func_id(struct hinic3_hwdev *hwdev);
>   
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
> index 8b92eed25edf..7bf0c950e1b5 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
> @@ -38,7 +38,7 @@ static int hinic3_poll(struct napi_struct *napi, int budget)
>   	return work_done;
>   }
>   
> -void qp_add_napi(struct hinic3_irq_cfg *irq_cfg)
> +static void qp_add_napi(struct hinic3_irq_cfg *irq_cfg)
>   {
>   	struct hinic3_nic_dev *nic_dev = netdev_priv(irq_cfg->netdev);
>   
> @@ -50,7 +50,7 @@ void qp_add_napi(struct hinic3_irq_cfg *irq_cfg)
>   	napi_enable(&irq_cfg->napi);
>   }
>   
> -void qp_del_napi(struct hinic3_irq_cfg *irq_cfg)
> +static void qp_del_napi(struct hinic3_irq_cfg *irq_cfg)
>   {
>   	napi_disable(&irq_cfg->napi);
>   	netif_queue_set_napi(irq_cfg->netdev, irq_cfg->irq_id,
> @@ -60,3 +60,136 @@ void qp_del_napi(struct hinic3_irq_cfg *irq_cfg)
>   	netif_stop_subqueue(irq_cfg->netdev, irq_cfg->irq_id);
>   	netif_napi_del(&irq_cfg->napi);
>   }
> +
> +static irqreturn_t qp_irq(int irq, void *data)
> +{
> +	struct hinic3_irq_cfg *irq_cfg = data;
> +	struct hinic3_nic_dev *nic_dev;
> +
> +	nic_dev = netdev_priv(irq_cfg->netdev);
> +	hinic3_msix_intr_clear_resend_bit(nic_dev->hwdev,
> +					  irq_cfg->msix_entry_idx, 1);
> +
> +	napi_schedule(&irq_cfg->napi);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int hinic3_request_irq(struct hinic3_irq_cfg *irq_cfg, u16 q_id)
> +{
> +	struct hinic3_interrupt_info info = {};
> +	struct hinic3_nic_dev *nic_dev;
> +	struct net_device *netdev;
> +	int err;
> +
> +	netdev = irq_cfg->netdev;
> +	nic_dev = netdev_priv(netdev);
> +	qp_add_napi(irq_cfg);
> +
> +	info.msix_index = irq_cfg->msix_entry_idx;
> +	info.interrupt_coalesc_set = 1;
> +	info.pending_limt = nic_dev->intr_coalesce[q_id].pending_limt;
> +	info.coalesc_timer_cfg =
> +		nic_dev->intr_coalesce[q_id].coalesce_timer_cfg;
> +	info.resend_timer_cfg = nic_dev->intr_coalesce[q_id].resend_timer_cfg;
> +	err = hinic3_set_interrupt_cfg_direct(nic_dev->hwdev, &info);
> +	if (err) {
> +		netdev_err(netdev, "Failed to set RX interrupt coalescing attribute.\n");
> +		qp_del_napi(irq_cfg);
> +		return err;
> +	}
> +
> +	err = request_irq(irq_cfg->irq_id, qp_irq, 0, irq_cfg->irq_name,
> +			  irq_cfg);
> +	if (err) {
> +		netdev_err(netdev, "Failed to request Rx irq\n");
> +		qp_del_napi(irq_cfg);
> +		return err;
> +	}
> +
> +	irq_set_affinity_hint(irq_cfg->irq_id, &irq_cfg->affinity_mask);
> +	return 0;
> +}
> +
> +static void hinic3_release_irq(struct hinic3_irq_cfg *irq_cfg)
> +{
> +	irq_set_affinity_hint(irq_cfg->irq_id, NULL);
> +	synchronize_irq(irq_cfg->irq_id);
> +	free_irq(irq_cfg->irq_id, irq_cfg);
> +}
> +
> +int hinic3_qps_irq_init(struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct pci_dev *pdev = nic_dev->pdev;
> +	struct hinic3_irq_cfg *irq_cfg;
> +	struct msix_entry *msix_entry;
> +	u32 local_cpu;
> +	u16 q_id;
> +	int err;
> +
> +	for (q_id = 0; q_id < nic_dev->q_params.num_qps; q_id++) {
> +		msix_entry = &nic_dev->qps_msix_entries[q_id];
> +		irq_cfg = &nic_dev->q_params.irq_cfg[q_id];
> +
> +		irq_cfg->irq_id = msix_entry->vector;
> +		irq_cfg->msix_entry_idx = msix_entry->entry;
> +		irq_cfg->netdev = netdev;
> +		irq_cfg->txq = &nic_dev->txqs[q_id];
> +		irq_cfg->rxq = &nic_dev->rxqs[q_id];
> +		nic_dev->rxqs[q_id].irq_cfg = irq_cfg;
> +
> +		local_cpu = cpumask_local_spread(q_id, dev_to_node(&pdev->dev));
> +		cpumask_set_cpu(local_cpu, &irq_cfg->affinity_mask);
> +
> +		snprintf(irq_cfg->irq_name, sizeof(irq_cfg->irq_name),
> +			 "%s_qp%u", netdev->name, q_id);
> +
> +		err = hinic3_request_irq(irq_cfg, q_id);
> +		if (err) {
> +			netdev_err(netdev, "Failed to request Rx irq\n");

redundant error message, same "Failed to request Rx irq\n" used in 
hinic3_request_irq ?

> +			goto err_release_irqs;
> +		}
> +
> +		hinic3_set_msix_auto_mask_state(nic_dev->hwdev,
> +						irq_cfg->msix_entry_idx,
> +						HINIC3_SET_MSIX_AUTO_MASK);
> +		hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,
> +				      HINIC3_MSIX_ENABLE);
> +	}
> +
> +	return 0;
> +
> +err_release_irqs:
> +	while (q_id > 0) {
> +		q_id--;
> +		irq_cfg = &nic_dev->q_params.irq_cfg[q_id];
> +		qp_del_napi(irq_cfg);
> +		hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,
> +				      HINIC3_MSIX_DISABLE);
> +		hinic3_set_msix_auto_mask_state(nic_dev->hwdev,
> +						irq_cfg->msix_entry_idx,
> +						HINIC3_CLR_MSIX_AUTO_MASK);
> +		hinic3_release_irq(irq_cfg);
> +	}
> +
> +	return err;
> +}
> +
> +void hinic3_qps_irq_uninit(struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_irq_cfg *irq_cfg;
> +	u16 q_id;
> +
> +	for (q_id = 0; q_id < nic_dev->q_params.num_qps; q_id++) {
> +		irq_cfg = &nic_dev->q_params.irq_cfg[q_id];
> +		qp_del_napi(irq_cfg);
> +		hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,
> +				      HINIC3_MSIX_DISABLE);
> +		hinic3_set_msix_auto_mask_state(nic_dev->hwdev,
> +						irq_cfg->msix_entry_idx,
> +						HINIC3_CLR_MSIX_AUTO_MASK);
> +		hinic3_release_irq(irq_cfg);
> +	}
> +}
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> index 497f2a36f35d..035308f18776 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> @@ -24,6 +24,50 @@
>   #define HINIC3_SQ_DEPTH              1024
>   #define HINIC3_RQ_DEPTH              1024
>   
> +#define HINIC3_DEAULT_TXRX_MSIX_PENDING_LIMIT       2
> +#define HINIC3_DEAULT_TXRX_MSIX_COALESC_TIMER_CFG   25
> +#define HINIC3_DEAULT_TXRX_MSIX_RESEND_TIMER_CFG    7

typo DEAULT  -> DEFAULT

> +
> +static void init_intr_coal_param(struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_intr_coal_info *info;
> +	u16 i;
> +
> +	for (i = 0; i < nic_dev->max_qps; i++) {
> +		info = &nic_dev->intr_coalesce[i];
> +		info->pending_limt = HINIC3_DEAULT_TXRX_MSIX_PENDING_LIMIT;
> +		info->coalesce_timer_cfg = HINIC3_DEAULT_TXRX_MSIX_COALESC_TIMER_CFG;
> +		info->resend_timer_cfg = HINIC3_DEAULT_TXRX_MSIX_RESEND_TIMER_CFG;
> +	}
> +}
> +
> +static int hinic3_init_intr_coalesce(struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
> +	u64 size;
> +
> +	size = sizeof(*nic_dev->intr_coalesce) * nic_dev->max_qps;
> +	if (!size) {
> +		dev_err(hwdev->dev, "Cannot allocate zero size intr coalesce\n");
> +		return -EINVAL;
> +	}
> +	nic_dev->intr_coalesce = kzalloc(size, GFP_KERNEL);
> +	if (!nic_dev->intr_coalesce)
> +		return -ENOMEM;
> +
> +	init_intr_coal_param(netdev);
> +	return 0;
> +}
> +
> +static void hinic3_free_intr_coalesce(struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +
> +	kfree(nic_dev->intr_coalesce);
> +}
> +
>   static int hinic3_alloc_txrxqs(struct net_device *netdev)
>   {
>   	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> @@ -42,8 +86,17 @@ static int hinic3_alloc_txrxqs(struct net_device *netdev)
>   		goto err_free_txqs;
>   	}
>   
> +	err = hinic3_init_intr_coalesce(netdev);
> +	if (err) {
> +		dev_err(hwdev->dev, "Failed to init_intr_coalesce\n");
> +		goto err_free_rxqs;
> +	}
> +
>   	return 0;
>   
> +err_free_rxqs:
> +	hinic3_free_rxqs(netdev);
> +
>   err_free_txqs:
>   	hinic3_free_txqs(netdev);
>   
> @@ -52,6 +105,7 @@ static int hinic3_alloc_txrxqs(struct net_device *netdev)
>   
>   static void hinic3_free_txrxqs(struct net_device *netdev)
>   {
> +	hinic3_free_intr_coalesce(netdev);
>   	hinic3_free_rxqs(netdev);
>   	hinic3_free_txqs(netdev);
>   }
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
> index e74d1eb09730..e9bfaf81c39b 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
> @@ -4,13 +4,843 @@
>   #include <linux/dma-mapping.h>
>   
>   #include "hinic3_common.h"
> +#include "hinic3_csr.h"
>   #include "hinic3_hwdev.h"
>   #include "hinic3_hwif.h"
>   #include "hinic3_mbox.h"
>   
> +#define MBOX_INT_DST_AEQN_MASK        GENMASK(11, 10)
> +#define MBOX_INT_SRC_RESP_AEQN_MASK   GENMASK(13, 12)
> +#define MBOX_INT_STAT_DMA_MASK        GENMASK(19, 14)
> +/* TX size, expressed in 4 bytes units */
> +#define MBOX_INT_TX_SIZE_MASK         GENMASK(24, 20)
> +/* SO_RO == strong order, relaxed order */
> +#define MBOX_INT_STAT_DMA_SO_RO_MASK  GENMASK(26, 25)
> +#define MBOX_INT_WB_EN_MASK           BIT(28)
> +#define MBOX_INT_SET(val, field)  \
> +	FIELD_PREP(MBOX_INT_##field##_MASK, val)
> +
> +#define MBOX_CTRL_TRIGGER_AEQE_MASK   BIT(0)
> +#define MBOX_CTRL_TX_STATUS_MASK      BIT(1)
> +#define MBOX_CTRL_DST_FUNC_MASK       GENMASK(28, 16)
> +#define MBOX_CTRL_SET(val, field)  \
> +	FIELD_PREP(MBOX_CTRL_##field##_MASK, val)
> +
> +#define MBOX_MSG_POLLING_TIMEOUT_MS  8000 // send msg seg timeout
> +#define MBOX_COMP_POLLING_TIMEOUT_MS 40000 // response
> +
> +#define MBOX_MAX_BUF_SZ           2048
> +#define MBOX_HEADER_SZ            8
> +
> +/* MBOX size is 64B, 8B for mbox_header, 8B reserved */
> +#define MBOX_SEG_LEN              48
> +#define MBOX_SEG_LEN_ALIGN        4
> +#define MBOX_WB_STATUS_LEN        16
> +
> +#define MBOX_SEQ_ID_START_VAL     0
> +#define MBOX_SEQ_ID_MAX_VAL       42
> +#define MBOX_LAST_SEG_MAX_LEN  \
> +	(MBOX_MAX_BUF_SZ - MBOX_SEQ_ID_MAX_VAL * MBOX_SEG_LEN)
> +
> +/* mbox write back status is 16B, only first 4B is used */
> +#define MBOX_WB_STATUS_ERRCODE_MASK      0xFFFF
> +#define MBOX_WB_STATUS_MASK              0xFF
> +#define MBOX_WB_ERROR_CODE_MASK          0xFF00
> +#define MBOX_WB_STATUS_FINISHED_SUCCESS  0xFF
> +#define MBOX_WB_STATUS_NOT_FINISHED      0x00
> +
> +#define MBOX_STATUS_FINISHED(wb)  \
> +	(((wb) & MBOX_WB_STATUS_MASK) != MBOX_WB_STATUS_NOT_FINISHED)
> +#define MBOX_STATUS_SUCCESS(wb)  \
> +	(((wb) & MBOX_WB_STATUS_MASK) == MBOX_WB_STATUS_FINISHED_SUCCESS)
> +#define MBOX_STATUS_ERRCODE(wb)  \
> +	((wb) & MBOX_WB_ERROR_CODE_MASK)
> +
> +#define MBOX_DMA_MSG_QUEUE_DEPTH    32
> +#define MBOX_BODY_FROM_HDR(header)  ((u8 *)(header) + MBOX_HEADER_SZ)
> +#define MBOX_AREA(hwif)  \
> +	((hwif)->cfg_regs_base + HINIC3_FUNC_CSR_MAILBOX_DATA_OFF)
> +
> +#define MBOX_MQ_CI_OFFSET  \
> +	(HINIC3_CFG_REGS_FLAG + HINIC3_FUNC_CSR_MAILBOX_DATA_OFF + \
> +	 MBOX_HEADER_SZ + MBOX_SEG_LEN)
> +
> +#define MBOX_MQ_SYNC_CI_MASK   GENMASK(7, 0)
> +#define MBOX_MQ_ASYNC_CI_MASK  GENMASK(15, 8)
> +#define MBOX_MQ_CI_GET(val, field)  \
> +	FIELD_GET(MBOX_MQ_##field##_CI_MASK, val)
> +
> +#define MBOX_MGMT_FUNC_ID         0x1FFF
> +#define MBOX_COMM_F_MBOX_SEGMENT  BIT(3)
> +
> +static struct hinic3_msg_desc *get_mbox_msg_desc(struct hinic3_mbox *mbox,
> +						 enum mbox_msg_direction_type dir,
> +						 u16 src_func_id)
> +{
> +	struct hinic3_msg_channel *msg_ch;
> +
> +	msg_ch = (src_func_id == MBOX_MGMT_FUNC_ID) ?
> +		&mbox->mgmt_msg : mbox->func_msg;
> +	return (dir == MBOX_MSG_SEND) ?
> +		&msg_ch->recv_msg : &msg_ch->resp_msg;
> +}
> +
> +static void resp_mbox_handler(struct hinic3_mbox *mbox,
> +			      const struct hinic3_msg_desc *msg_desc)
> +{
> +	spin_lock(&mbox->mbox_lock);
> +	if (msg_desc->msg_info.msg_id == mbox->send_msg_id &&
> +	    mbox->event_flag == MBOX_EVENT_START)
> +		mbox->event_flag = MBOX_EVENT_SUCCESS;
> +	spin_unlock(&mbox->mbox_lock);
> +}
> +
> +static bool mbox_segment_valid(struct hinic3_mbox *mbox,
> +			       struct hinic3_msg_desc *msg_desc,
> +			       u64 mbox_header)
> +{
> +	u8 seq_id, seg_len, msg_id, mod;
> +	u16 src_func_idx, cmd;
> +
> +	seq_id = MBOX_MSG_HEADER_GET(mbox_header, SEQID);
> +	seg_len = MBOX_MSG_HEADER_GET(mbox_header, SEG_LEN);
> +	msg_id = MBOX_MSG_HEADER_GET(mbox_header, MSG_ID);
> +	mod = MBOX_MSG_HEADER_GET(mbox_header, MODULE);
> +	cmd = MBOX_MSG_HEADER_GET(mbox_header, CMD);
> +	src_func_idx = MBOX_MSG_HEADER_GET(mbox_header, SRC_GLB_FUNC_IDX);
> +
> +	if (seq_id > MBOX_SEQ_ID_MAX_VAL || seg_len > MBOX_SEG_LEN ||
> +	    (seq_id == MBOX_SEQ_ID_MAX_VAL && seg_len > MBOX_LAST_SEG_MAX_LEN))
> +		goto err_seg;
> +
> +	if (seq_id == 0) {
> +		msg_desc->seq_id = seq_id;
> +		msg_desc->msg_info.msg_id = msg_id;
> +		msg_desc->mod = mod;
> +		msg_desc->cmd = cmd;
> +	} else {
> +		if (seq_id != msg_desc->seq_id + 1 ||
> +		    msg_id != msg_desc->msg_info.msg_id ||
> +		    mod != msg_desc->mod || cmd != msg_desc->cmd)
> +			goto err_seg;
> +
> +		msg_desc->seq_id = seq_id;
> +	}
> +
> +	return true;
> +
> +err_seg:
> +	dev_err(mbox->hwdev->dev,
> +		"Mailbox segment check failed, src func id: 0x%x, front seg info: seq id: 0x%x, msg id: 0x%x, mod: 0x%x, cmd: 0x%x\n",
> +		src_func_idx, msg_desc->seq_id, msg_desc->msg_info.msg_id,
> +		msg_desc->mod, msg_desc->cmd);
> +	dev_err(mbox->hwdev->dev,
> +		"Current seg info: seg len: 0x%x, seq id: 0x%x, msg id: 0x%x, mod: 0x%x, cmd: 0x%x\n",
> +		seg_len, seq_id, msg_id, mod, cmd);
> +
> +	return false;
> +}
> +
> +static void recv_mbox_handler(struct hinic3_mbox *mbox,
> +			      u64 *header, struct hinic3_msg_desc *msg_desc)
> +{
> +	void *mbox_body = MBOX_BODY_FROM_HDR(((void *)header));
> +	u64 mbox_header = *header;
> +	u8 seq_id, seg_len;
> +	int pos;
> +
> +	if (!mbox_segment_valid(mbox, msg_desc, mbox_header)) {
> +		msg_desc->seq_id = MBOX_SEQ_ID_MAX_VAL;
> +		return;
> +	}
> +
> +	seq_id = MBOX_MSG_HEADER_GET(mbox_header, SEQID);
> +	seg_len = MBOX_MSG_HEADER_GET(mbox_header, SEG_LEN);
> +
> +	pos = seq_id * MBOX_SEG_LEN;
> +	memcpy((u8 *)msg_desc->msg + pos, mbox_body, seg_len);
> +
> +	if (!MBOX_MSG_HEADER_GET(mbox_header, LAST))
> +		return;
> +
> +	msg_desc->msg_len = MBOX_MSG_HEADER_GET(mbox_header, MSG_LEN);
> +	msg_desc->msg_info.status = MBOX_MSG_HEADER_GET(mbox_header, STATUS);
> +
> +	if (MBOX_MSG_HEADER_GET(mbox_header, DIRECTION) == MBOX_MSG_RESP)
> +		resp_mbox_handler(mbox, msg_desc);
> +}
> +
> +void hinic3_mbox_func_aeqe_handler(struct hinic3_hwdev *hwdev, u8 *header,
> +				   u8 size)
> +{
> +	u64 mbox_header = *((u64 *)header);
> +	enum mbox_msg_direction_type dir;
> +	struct hinic3_mbox *mbox;
> +	struct hinic3_msg_desc *msg_desc;
> +	u16 src_func_id;
> +
> +	mbox = hwdev->mbox;
> +	dir = MBOX_MSG_HEADER_GET(mbox_header, DIRECTION);
> +	src_func_id = MBOX_MSG_HEADER_GET(mbox_header, SRC_GLB_FUNC_IDX);
> +	msg_desc = get_mbox_msg_desc(mbox, dir, src_func_id);
> +	recv_mbox_handler(mbox, (u64 *)header, msg_desc);
> +}
> +
> +static int init_mbox_dma_queue(struct hinic3_hwdev *hwdev,
> +			       struct mbox_dma_queue *mq)
> +{
> +	u32 size;
> +
> +	mq->depth = MBOX_DMA_MSG_QUEUE_DEPTH;
> +	mq->prod_idx = 0;
> +	mq->cons_idx = 0;
> +
> +	size = mq->depth * MBOX_MAX_BUF_SZ;
> +	mq->dma_buf_vaddr = dma_alloc_coherent(hwdev->dev, size,
> +					       &mq->dma_buf_paddr,
> +					       GFP_KERNEL);
> +	if (!mq->dma_buf_vaddr)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void uninit_mbox_dma_queue(struct hinic3_hwdev *hwdev,
> +				  struct mbox_dma_queue *mq)
> +{
> +	dma_free_coherent(hwdev->dev, mq->depth * MBOX_MAX_BUF_SZ,
> +			  mq->dma_buf_vaddr, mq->dma_buf_paddr);
> +}
> +
> +static int hinic3_init_mbox_dma_queue(struct hinic3_mbox *mbox)
> +{
> +	u32 val;
> +	int err;
> +
> +	err = init_mbox_dma_queue(mbox->hwdev, &mbox->sync_msg_queue);
> +	if (err)
> +		return err;
> +
> +	err = init_mbox_dma_queue(mbox->hwdev, &mbox->async_msg_queue);
> +	if (err) {
> +		uninit_mbox_dma_queue(mbox->hwdev, &mbox->sync_msg_queue);
> +		return err;
> +	}
> +
> +	val = hinic3_hwif_read_reg(mbox->hwdev->hwif, MBOX_MQ_CI_OFFSET);
> +	val &= ~MBOX_MQ_SYNC_CI_MASK;
> +	val &= ~MBOX_MQ_ASYNC_CI_MASK;
> +	hinic3_hwif_write_reg(mbox->hwdev->hwif, MBOX_MQ_CI_OFFSET, val);
> +
> +	return 0;
> +}
> +
> +static void hinic3_uninit_mbox_dma_queue(struct hinic3_mbox *mbox)
> +{
> +	uninit_mbox_dma_queue(mbox->hwdev, &mbox->sync_msg_queue);
> +	uninit_mbox_dma_queue(mbox->hwdev, &mbox->async_msg_queue);
> +}
> +
> +static int alloc_mbox_msg_channel(struct hinic3_msg_channel *msg_ch)
> +{
> +	msg_ch->resp_msg.msg = kzalloc(MBOX_MAX_BUF_SZ, GFP_KERNEL);
> +	if (!msg_ch->resp_msg.msg)
> +		return -ENOMEM;
> +
> +	msg_ch->recv_msg.msg = kzalloc(MBOX_MAX_BUF_SZ, GFP_KERNEL);
> +	if (!msg_ch->recv_msg.msg) {
> +		kfree(msg_ch->resp_msg.msg);
> +		return -ENOMEM;
> +	}
> +
> +	msg_ch->resp_msg.seq_id = MBOX_SEQ_ID_MAX_VAL;
> +	msg_ch->recv_msg.seq_id = MBOX_SEQ_ID_MAX_VAL;
> +	return 0;
> +}
> +
> +static void free_mbox_msg_channel(struct hinic3_msg_channel *msg_ch)
> +{
> +	kfree(msg_ch->recv_msg.msg);
> +	kfree(msg_ch->resp_msg.msg);
> +}
> +
> +static int init_mgmt_msg_channel(struct hinic3_mbox *mbox)
> +{
> +	int err;
> +
> +	err = alloc_mbox_msg_channel(&mbox->mgmt_msg);
> +	if (err) {
> +		dev_err(mbox->hwdev->dev, "Failed to alloc mgmt message channel\n");
> +		return err;
> +	}
> +
> +	err = hinic3_init_mbox_dma_queue(mbox);
> +	if (err) {
> +		dev_err(mbox->hwdev->dev, "Failed to init mbox dma queue\n");
> +		free_mbox_msg_channel(&mbox->mgmt_msg);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static void uninit_mgmt_msg_channel(struct hinic3_mbox *mbox)
> +{
> +	hinic3_uninit_mbox_dma_queue(mbox);
> +	free_mbox_msg_channel(&mbox->mgmt_msg);
> +}
> +
> +static int hinic3_init_func_mbox_msg_channel(struct hinic3_hwdev *hwdev)
> +{
> +	struct hinic3_mbox *mbox;
> +	int err;
> +
> +	mbox = hwdev->mbox;
> +	mbox->func_msg = kzalloc(sizeof(*mbox->func_msg), GFP_KERNEL);
> +	if (!mbox->func_msg)
> +		return -ENOMEM;
> +
> +	err = alloc_mbox_msg_channel(mbox->func_msg);
> +	if (err)
> +		goto err_free_func_msg;
> +
> +	return 0;
> +
> +err_free_func_msg:
> +	kfree(mbox->func_msg);
> +	mbox->func_msg = NULL;
> +	return err;
> +}
> +
> +static void hinic3_uninit_func_mbox_msg_channel(struct hinic3_hwdev *hwdev)
> +{
> +	struct hinic3_mbox *mbox = hwdev->mbox;
> +
> +	free_mbox_msg_channel(mbox->func_msg);
> +	kfree(mbox->func_msg);
> +	mbox->func_msg = NULL;
> +}
> +
> +static void prepare_send_mbox(struct hinic3_mbox *mbox)
> +{
> +	struct hinic3_send_mbox *send_mbox = &mbox->send_mbox;
> +
> +	send_mbox->data = MBOX_AREA(mbox->hwdev->hwif);
> +}
> +
> +static int alloc_mbox_wb_status(struct hinic3_mbox *mbox)
> +{
> +	struct hinic3_send_mbox *send_mbox = &mbox->send_mbox;
> +	struct hinic3_hwdev *hwdev = mbox->hwdev;
> +	u32 addr_h, addr_l;
> +
> +	send_mbox->wb_vaddr = dma_alloc_coherent(hwdev->dev,
> +						 MBOX_WB_STATUS_LEN,
> +						 &send_mbox->wb_paddr,
> +						 GFP_KERNEL);
> +	if (!send_mbox->wb_vaddr)
> +		return -ENOMEM;
> +
> +	addr_h = upper_32_bits(send_mbox->wb_paddr);
> +	addr_l = lower_32_bits(send_mbox->wb_paddr);
> +	hinic3_hwif_write_reg(hwdev->hwif, HINIC3_FUNC_CSR_MAILBOX_RESULT_H_OFF,
> +			      addr_h);
> +	hinic3_hwif_write_reg(hwdev->hwif, HINIC3_FUNC_CSR_MAILBOX_RESULT_L_OFF,
> +			      addr_l);
> +
> +	return 0;
> +}
> +
> +static void free_mbox_wb_status(struct hinic3_mbox *mbox)
> +{
> +	struct hinic3_send_mbox *send_mbox = &mbox->send_mbox;
> +	struct hinic3_hwdev *hwdev = mbox->hwdev;
> +
> +	hinic3_hwif_write_reg(hwdev->hwif, HINIC3_FUNC_CSR_MAILBOX_RESULT_H_OFF,
> +			      0);
> +	hinic3_hwif_write_reg(hwdev->hwif, HINIC3_FUNC_CSR_MAILBOX_RESULT_L_OFF,
> +			      0);
> +
> +	dma_free_coherent(hwdev->dev, MBOX_WB_STATUS_LEN,
> +			  send_mbox->wb_vaddr, send_mbox->wb_paddr);
> +}
> +
> +static int hinic3_mbox_pre_init(struct hinic3_hwdev *hwdev,
> +				struct hinic3_mbox **mbox)
> +{
> +	(*mbox) = kzalloc(sizeof(struct hinic3_mbox), GFP_KERNEL);
> +	if (!(*mbox))
> +		return -ENOMEM;
> +
> +	(*mbox)->hwdev = hwdev;
> +	mutex_init(&(*mbox)->mbox_send_lock);
> +	mutex_init(&(*mbox)->msg_send_lock);
> +	spin_lock_init(&(*mbox)->mbox_lock);
> +
> +	(*mbox)->workq = create_singlethread_workqueue(HINIC3_MBOX_WQ_NAME);
> +	if (!(*mbox)->workq) {
> +		dev_err(hwdev->dev, "Failed to initialize MBOX workqueue\n");
> +		kfree((*mbox));
> +		return -ENOMEM;
> +	}
> +	hwdev->mbox = (*mbox);
> +
> +	return 0;
> +}
> +
> +int hinic3_init_mbox(struct hinic3_hwdev *hwdev)
> +{
> +	struct hinic3_mbox *mbox;
> +	int err;
> +
> +	err = hinic3_mbox_pre_init(hwdev, &mbox);
> +	if (err)
> +		return err;
> +
> +	err = init_mgmt_msg_channel(mbox);
> +	if (err)
> +		goto err_destroy_workqueue;
> +
> +	err = hinic3_init_func_mbox_msg_channel(hwdev);
> +	if (err)
> +		goto err_uninit_mgmt_msg_ch;
> +
> +	err = alloc_mbox_wb_status(mbox);
> +	if (err) {
> +		dev_err(hwdev->dev, "Failed to alloc mbox write back status\n");
> +		goto err_uninit_func_mbox_msg_ch;
> +	}
> +
> +	prepare_send_mbox(mbox);
> +
> +	return 0;
> +
> +err_uninit_func_mbox_msg_ch:
> +	hinic3_uninit_func_mbox_msg_channel(hwdev);
> +
> +err_uninit_mgmt_msg_ch:
> +	uninit_mgmt_msg_channel(mbox);
> +
> +err_destroy_workqueue:
> +	destroy_workqueue(mbox->workq);
> +	kfree(mbox);
> +
> +	return err;
> +}
> +
> +void hinic3_free_mbox(struct hinic3_hwdev *hwdev)
> +{
> +	struct hinic3_mbox *mbox = hwdev->mbox;
> +
> +	destroy_workqueue(mbox->workq);
> +	free_mbox_wb_status(mbox);
> +	hinic3_uninit_func_mbox_msg_channel(hwdev);
> +	uninit_mgmt_msg_channel(mbox);
> +	kfree(mbox);
> +}
> +
> +#define MBOX_DMA_MSG_INIT_XOR_VAL    0x5a5a5a5a
> +#define MBOX_XOR_DATA_ALIGN          4
> +static u32 mbox_dma_msg_xor(u32 *data, u32 msg_len)
> +{
> +	u32 xor = MBOX_DMA_MSG_INIT_XOR_VAL;
> +	u32 dw_len = msg_len / sizeof(u32);
> +	u32 i;
> +
> +	for (i = 0; i < dw_len; i++)
> +		xor ^= data[i];
> +
> +	return xor;
> +}
> +
> +#define MBOX_MQ_ID_MASK(mq, idx)  ((idx) & ((mq)->depth - 1))
> +
> +static bool is_msg_queue_full(struct mbox_dma_queue *mq)
> +{
> +	return (MBOX_MQ_ID_MASK(mq, (mq)->prod_idx + 1) ==
> +		MBOX_MQ_ID_MASK(mq, (mq)->cons_idx));
> +}
> +
> +static int mbox_prepare_dma_entry(struct hinic3_mbox *mbox,
> +				  struct mbox_dma_queue *mq,
> +				  struct mbox_dma_msg *dma_msg,
> +				  const void *msg, u32 msg_len)
> +{
> +	u64 dma_addr, offset;
> +	void *dma_vaddr;
> +
> +	if (is_msg_queue_full(mq)) {
> +		dev_err(mbox->hwdev->dev, "Mbox sync message queue is busy, pi: %u, ci: %u\n",
> +			mq->prod_idx, MBOX_MQ_ID_MASK(mq, mq->cons_idx));
> +		return -EBUSY;
> +	}
> +
> +	/* copy data to DMA buffer */
> +	offset = mq->prod_idx * MBOX_MAX_BUF_SZ;
> +	dma_vaddr = (u8 *)mq->dma_buf_vaddr + offset;
> +	memcpy(dma_vaddr, msg, msg_len);
> +	dma_addr = mq->dma_buf_paddr + offset;
> +	dma_msg->dma_addr_high = upper_32_bits(dma_addr);
> +	dma_msg->dma_addr_low = lower_32_bits(dma_addr);
> +	dma_msg->msg_len = msg_len;
> +	/* The firmware obtains message based on 4B alignment. */
> +	dma_msg->xor = mbox_dma_msg_xor(dma_vaddr,
> +					ALIGN(msg_len, MBOX_XOR_DATA_ALIGN));
> +	mq->prod_idx++;
> +	mq->prod_idx = MBOX_MQ_ID_MASK(mq, mq->prod_idx);

\n before return

> +	return 0;
> +}
> +
> +static int mbox_prepare_dma_msg(struct hinic3_mbox *mbox,
> +				enum mbox_msg_ack_type ack_type,
> +				struct mbox_dma_msg *dma_msg, const void *msg,
> +				u32 msg_len)
> +{
> +	struct mbox_dma_queue *mq;
> +	u32 val;
> +
> +	val = hinic3_hwif_read_reg(mbox->hwdev->hwif, MBOX_MQ_CI_OFFSET);
> +	if (ack_type == MBOX_MSG_ACK) {
> +		mq = &mbox->sync_msg_queue;
> +		mq->cons_idx = MBOX_MQ_CI_GET(val, SYNC);
> +	} else {
> +		mq = &mbox->async_msg_queue;
> +		mq->cons_idx = MBOX_MQ_CI_GET(val, ASYNC);
> +	}
> +
> +	return mbox_prepare_dma_entry(mbox, mq, dma_msg, msg, msg_len);
> +}
> +
> +static void clear_mbox_status(struct hinic3_send_mbox *mbox)
> +{
> +	__be64 *wb_status = mbox->wb_vaddr;
> +
> +	*wb_status = 0;
> +	/* clear mailbox write back status */
> +	wmb();
> +}
> +
> +static void mbox_dword_write(const void *src, void __iomem *dst, u32 count)
> +{
> +	u32 __iomem *dst32 = dst;
> +	const u32 *src32 = src;
> +	u32 i;
> +
> +	/* Data written to mbox is arranged in structs with little endian fields
> +	 * but when written to HW every dword (32bits) should be swapped since
> +	 * the HW will swap it again. This is a mandatory swap regardless of the
> +	 * CPU endianness.
> +	 */
> +	for (i = 0; i < count; i++)
> +		__raw_writel(swab32(src32[i]), dst32 + i);
> +}
> +
> +static void mbox_copy_header(struct hinic3_hwdev *hwdev,
> +			     struct hinic3_send_mbox *mbox, u64 *header)
> +{
> +	mbox_dword_write(header, mbox->data, MBOX_HEADER_SZ / sizeof(u32));
> +}
> +
> +static void mbox_copy_send_data(struct hinic3_hwdev *hwdev,
> +				struct hinic3_send_mbox *mbox, void *seg,
> +				u32 seg_len)
> +{
> +	u32 __iomem *dst = (u32 __iomem *)(mbox->data + MBOX_HEADER_SZ);
> +	u32 count, leftover, last_dword;
> +	const u32 *src = seg;
> +
> +	count = seg_len / sizeof(u32);
> +	leftover = seg_len % sizeof(u32);
> +	if (count > 0)
> +		mbox_dword_write(src, dst, count);
> +
> +	if (leftover > 0) {
> +		last_dword = 0;
> +		memcpy(&last_dword, src + count, leftover);
> +		mbox_dword_write(&last_dword, dst + count, 1);
> +	}
> +}
> +
> +static void write_mbox_msg_attr(struct hinic3_mbox *mbox,
> +				u16 dst_func, u16 dst_aeqn, u32 seg_len)
> +{
> +	struct hinic3_hwif *hwif = mbox->hwdev->hwif;
> +	u32 mbox_int, mbox_ctrl, tx_size;
> +
> +	tx_size = ALIGN(seg_len + MBOX_HEADER_SZ, MBOX_SEG_LEN_ALIGN) >> 2;
> +
> +	mbox_int = MBOX_INT_SET(dst_aeqn, DST_AEQN) |
> +		   MBOX_INT_SET(0, STAT_DMA) |
> +		   MBOX_INT_SET(tx_size, TX_SIZE) |
> +		   MBOX_INT_SET(0, STAT_DMA_SO_RO) |
> +		   MBOX_INT_SET(1, WB_EN);
> +
> +	mbox_ctrl = MBOX_CTRL_SET(1, TX_STATUS) |
> +		    MBOX_CTRL_SET(0, TRIGGER_AEQE) |
> +		    MBOX_CTRL_SET(dst_func, DST_FUNC);
> +
> +	hinic3_hwif_write_reg(hwif, HINIC3_FUNC_CSR_MAILBOX_INT_OFF, mbox_int);
> +	hinic3_hwif_write_reg(hwif, HINIC3_FUNC_CSR_MAILBOX_CONTROL_OFF,
> +			      mbox_ctrl);
> +}
> +
> +static u16 get_mbox_status(const struct hinic3_send_mbox *mbox)
> +{
> +	__be64 *wb_status = mbox->wb_vaddr;
> +	u64 wb_val;
> +
> +	wb_val = be64_to_cpu(*wb_status);
> +	/* verify reading before check */
> +	rmb();
> +	return wb_val & MBOX_WB_STATUS_ERRCODE_MASK;
> +}
> +
> +static enum hinic3_wait_return check_mbox_wb_status(void *priv_data)
> +{
> +	struct hinic3_mbox *mbox = priv_data;
> +	u16 wb_status;
> +
> +	wb_status = get_mbox_status(&mbox->send_mbox);
> +	return MBOX_STATUS_FINISHED(wb_status) ?
> +	       HINIC3_WAIT_PROCESS_CPL : HINIC3_WAIT_PROCESS_WAITING;
> +}
> +
> +static int send_mbox_seg(struct hinic3_mbox *mbox, u64 header,
> +			 u16 dst_func, void *seg, u32 seg_len, void *msg_info)
> +{
> +	struct hinic3_send_mbox *send_mbox = &mbox->send_mbox;
> +	struct hinic3_hwdev *hwdev = mbox->hwdev;
> +	u8 num_aeqs = hwdev->hwif->attr.num_aeqs;
> +	enum mbox_msg_direction_type dir;
> +	u16 dst_aeqn, wb_status, errcode;
> +	int err;
> +
> +	/* mbox to mgmt cpu, hardware doesn't care about dst aeq id */
> +	if (num_aeqs > MBOX_MSG_AEQ_FOR_MBOX) {
> +		dir = MBOX_MSG_HEADER_GET(header, DIRECTION);
> +		dst_aeqn = (dir == MBOX_MSG_SEND) ?
> +			   MBOX_MSG_AEQ_FOR_EVENT : MBOX_MSG_AEQ_FOR_MBOX;
> +	} else {
> +		dst_aeqn = 0;
> +	}
> +
> +	clear_mbox_status(send_mbox);
> +	mbox_copy_header(hwdev, send_mbox, &header);
> +	mbox_copy_send_data(hwdev, send_mbox, seg, seg_len);
> +	write_mbox_msg_attr(mbox, dst_func, dst_aeqn, seg_len);
> +
> +	err = hinic3_wait_for_timeout(mbox, check_mbox_wb_status,
> +				      MBOX_MSG_POLLING_TIMEOUT_MS,
> +				      USEC_PER_MSEC);
> +	wb_status = get_mbox_status(send_mbox);
> +	if (err) {
> +		dev_err(hwdev->dev, "Send mailbox segment timeout, wb status: 0x%x\n",
> +			wb_status);
> +		return err;
> +	}
> +
> +	if (!MBOX_STATUS_SUCCESS(wb_status)) {
> +		dev_err(hwdev->dev,
> +			"Send mailbox segment to function %u error, wb status: 0x%x\n",
> +			dst_func, wb_status);
> +		errcode = MBOX_STATUS_ERRCODE(wb_status);
> +		return errcode ? errcode : -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int send_mbox_msg(struct hinic3_mbox *mbox, u8 mod, u16 cmd,
> +			 const void *msg, u32 msg_len, u16 dst_func,
> +			 enum mbox_msg_direction_type direction,
> +			 enum mbox_msg_ack_type ack_type,
> +			 struct mbox_msg_info *msg_info)
> +{
> +	enum mbox_msg_data_type data_type = MBOX_MSG_DATA_INLINE;
> +	struct hinic3_hwdev *hwdev = mbox->hwdev;
> +	struct mbox_dma_msg dma_msg;
> +	u32 seg_len = MBOX_SEG_LEN;
> +	u64 header = 0;
> +	u32 seq_id = 0;
> +	u16 rsp_aeq_id;
> +	u8 *msg_seg;
> +	int err = 0;
> +	u32 left;
> +
> +	if (hwdev->hwif->attr.num_aeqs > MBOX_MSG_AEQ_FOR_MBOX)
> +		rsp_aeq_id = MBOX_MSG_AEQ_FOR_MBOX;
> +	else
> +		rsp_aeq_id = 0;
> +
> +	mutex_lock(&mbox->msg_send_lock);
> +
> +	if (dst_func == MBOX_MGMT_FUNC_ID &&
> +	    !(hwdev->features[0] & MBOX_COMM_F_MBOX_SEGMENT)) {
> +		err = mbox_prepare_dma_msg(mbox, ack_type, &dma_msg,
> +					   msg, msg_len);
> +		if (err)
> +			goto err_send;
> +
> +		msg = &dma_msg;
> +		msg_len = sizeof(dma_msg);
> +		data_type = MBOX_MSG_DATA_DMA;
> +	}
> +
> +	msg_seg = (u8 *)msg;
> +	left = msg_len;
> +
> +	header = MBOX_MSG_HEADER_SET(msg_len, MSG_LEN) |
> +		 MBOX_MSG_HEADER_SET(mod, MODULE) |
> +		 MBOX_MSG_HEADER_SET(seg_len, SEG_LEN) |
> +		 MBOX_MSG_HEADER_SET(ack_type, NO_ACK) |
> +		 MBOX_MSG_HEADER_SET(data_type, DATA_TYPE) |
> +		 MBOX_MSG_HEADER_SET(MBOX_SEQ_ID_START_VAL, SEQID) |
> +		 MBOX_MSG_HEADER_SET(direction, DIRECTION) |
> +		 MBOX_MSG_HEADER_SET(cmd, CMD) |
> +		 MBOX_MSG_HEADER_SET(msg_info->msg_id, MSG_ID) |
> +		 MBOX_MSG_HEADER_SET(rsp_aeq_id, AEQ_ID) |
> +		 MBOX_MSG_HEADER_SET(MBOX_MSG_FROM_MBOX, SOURCE) |
> +		 MBOX_MSG_HEADER_SET(!!msg_info->status, STATUS);
> +
> +	while (!(MBOX_MSG_HEADER_GET(header, LAST))) {
> +		if (left <= MBOX_SEG_LEN) {
> +			header &= ~MBOX_MSG_HEADER_SEG_LEN_MASK;
> +			header |= MBOX_MSG_HEADER_SET(left, SEG_LEN) |
> +				  MBOX_MSG_HEADER_SET(1, LAST);
> +			seg_len = left;
> +		}
> +
> +		err = send_mbox_seg(mbox, header, dst_func, msg_seg,
> +				    seg_len, msg_info);
> +		if (err) {
> +			dev_err(hwdev->dev, "Failed to send mbox seg, seq_id=0x%llx\n",
> +				MBOX_MSG_HEADER_GET(header, SEQID));
> +			goto err_send;
> +		}
> +
> +		left -= MBOX_SEG_LEN;
> +		msg_seg += MBOX_SEG_LEN;
> +		seq_id++;
> +		header &= ~MBOX_MSG_HEADER_SEG_LEN_MASK;
> +		header |= MBOX_MSG_HEADER_SET(seq_id, SEQID);
> +	}
> +
> +err_send:
> +	mutex_unlock(&mbox->msg_send_lock);
> +	return err;
> +}
> +
> +static void set_mbox_to_func_event(struct hinic3_mbox *mbox,
> +				   enum mbox_event_state event_flag)
> +{
> +	spin_lock(&mbox->mbox_lock);
> +	mbox->event_flag = event_flag;
> +	spin_unlock(&mbox->mbox_lock);
> +}
> +
> +static enum hinic3_wait_return check_mbox_msg_finish(void *priv_data)
> +{
> +	struct hinic3_mbox *mbox = priv_data;
> +
> +	return (mbox->event_flag == MBOX_EVENT_SUCCESS) ?
> +		HINIC3_WAIT_PROCESS_CPL : HINIC3_WAIT_PROCESS_WAITING;
> +}
> +
> +static int wait_mbox_msg_completion(struct hinic3_mbox *mbox,
> +				    u32 timeout)
> +{
> +	u32 wait_time;
> +	int err;
> +
> +	wait_time = (timeout != 0) ? timeout : MBOX_COMP_POLLING_TIMEOUT_MS;
> +	err = hinic3_wait_for_timeout(mbox, check_mbox_msg_finish,
> +				      wait_time, USEC_PER_MSEC);
> +	if (err) {
> +		set_mbox_to_func_event(mbox, MBOX_EVENT_TIMEOUT);
> +		return err;
> +	}
> +	set_mbox_to_func_event(mbox, MBOX_EVENT_END);
> +	return 0;
> +}
> +
>   int hinic3_send_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
>   			     const struct mgmt_msg_params *msg_params)
>   {
> -	/* Completed by later submission due to LoC limit. */
> -	return -EFAULT;
> +	struct hinic3_mbox *mbox = hwdev->mbox;
> +	struct mbox_msg_info msg_info = {};
> +	struct hinic3_msg_desc *msg_desc;
> +	int err;
> +
> +	/* expect response message */
> +	msg_desc = get_mbox_msg_desc(mbox, MBOX_MSG_RESP, MBOX_MGMT_FUNC_ID);
> +	mutex_lock(&mbox->mbox_send_lock);
> +	msg_info.msg_id = (msg_info.msg_id + 1) & 0xF;
> +	mbox->send_msg_id = msg_info.msg_id;
> +	set_mbox_to_func_event(mbox, MBOX_EVENT_START);
> +
> +	err = send_mbox_msg(mbox, mod, cmd, msg_params->buf_in,
> +			    msg_params->in_size, MBOX_MGMT_FUNC_ID,
> +			    MBOX_MSG_SEND, MBOX_MSG_ACK, &msg_info);
> +	if (err) {
> +		dev_err(hwdev->dev, "Send mailbox mod %u, cmd %u failed, msg_id: %u, err: %d\n",
> +			mod, cmd, msg_info.msg_id, err);
> +		set_mbox_to_func_event(mbox, MBOX_EVENT_FAIL);
> +		goto err_send;
> +	}
> +
> +	if (wait_mbox_msg_completion(mbox, msg_params->timeout_ms)) {
> +		dev_err(hwdev->dev,
> +			"Send mbox msg timeout, msg_id: %u\n", msg_info.msg_id);
> +		err = -ETIMEDOUT;
> +		goto err_send;
> +	}
> +
> +	if (mod != msg_desc->mod || cmd != msg_desc->cmd) {
> +		dev_err(hwdev->dev,
> +			"Invalid response mbox message, mod: 0x%x, cmd: 0x%x, expect mod: 0x%x, cmd: 0x%x\n",
> +			msg_desc->mod, msg_desc->cmd, mod, cmd);
> +		err = -EFAULT;
> +		goto err_send;
> +	}
> +
> +	if (msg_desc->msg_info.status) {
> +		err = msg_desc->msg_info.status;
> +		goto err_send;
> +	}
> +
> +	if (msg_params->buf_out) {
> +		if (msg_desc->msg_len != msg_params->expected_out_size) {
> +			dev_err(hwdev->dev,
> +				"Invalid response mbox message length: %u for mod %d cmd %u, expected length: %u\n",
> +				msg_desc->msg_len, mod, cmd,
> +				msg_params->expected_out_size);
> +			err = -EFAULT;
> +			goto err_send;
> +		}
> +
> +		memcpy(msg_params->buf_out, msg_desc->msg, msg_desc->msg_len);
> +	}
> +
> +err_send:
> +	mutex_unlock(&mbox->mbox_send_lock);
> +	return err;
> +}
> +
> +int hinic3_send_mbox_to_mgmt_no_ack(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
> +				    const struct mgmt_msg_params *msg_params)
> +{
> +	struct hinic3_mbox *mbox = hwdev->mbox;
> +	struct mbox_msg_info msg_info = {};
> +	int err;
> +
> +	mutex_lock(&mbox->mbox_send_lock);
> +	err = send_mbox_msg(mbox, mod, cmd, msg_params->buf_in,
> +			    msg_params->in_size, MBOX_MGMT_FUNC_ID,
> +			    MBOX_MSG_SEND, MBOX_MSG_NO_ACK, &msg_info);
> +	if (err)
> +		dev_err(hwdev->dev, "Send mailbox no ack failed\n");
> +
> +	mutex_unlock(&mbox->mbox_send_lock);
> +
> +	return err;
>   }
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
> index d7a6c37b7eff..2435df31d9e5 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
> @@ -9,7 +9,134 @@
>   
>   struct hinic3_hwdev;
>   
> +#define MBOX_MSG_HEADER_SRC_GLB_FUNC_IDX_MASK  GENMASK_ULL(12, 0)
> +#define MBOX_MSG_HEADER_STATUS_MASK            BIT_ULL(13)
> +#define MBOX_MSG_HEADER_SOURCE_MASK            BIT_ULL(15)
> +#define MBOX_MSG_HEADER_AEQ_ID_MASK            GENMASK_ULL(17, 16)
> +#define MBOX_MSG_HEADER_MSG_ID_MASK            GENMASK_ULL(21, 18)
> +#define MBOX_MSG_HEADER_CMD_MASK               GENMASK_ULL(31, 22)
> +#define MBOX_MSG_HEADER_MSG_LEN_MASK           GENMASK_ULL(42, 32)
> +#define MBOX_MSG_HEADER_MODULE_MASK            GENMASK_ULL(47, 43)
> +#define MBOX_MSG_HEADER_SEG_LEN_MASK           GENMASK_ULL(53, 48)
> +#define MBOX_MSG_HEADER_NO_ACK_MASK            BIT_ULL(54)
> +#define MBOX_MSG_HEADER_DATA_TYPE_MASK         BIT_ULL(55)
> +#define MBOX_MSG_HEADER_SEQID_MASK             GENMASK_ULL(61, 56)
> +#define MBOX_MSG_HEADER_LAST_MASK              BIT_ULL(62)
> +#define MBOX_MSG_HEADER_DIRECTION_MASK         BIT_ULL(63)
> +
> +#define MBOX_MSG_HEADER_SET(val, member) \
> +	FIELD_PREP(MBOX_MSG_HEADER_##member##_MASK, val)
> +#define MBOX_MSG_HEADER_GET(val, member) \
> +	FIELD_GET(MBOX_MSG_HEADER_##member##_MASK, val)
> +
> +/* identifies if a segment belongs to a message or to a response. A VF is only
> + * expected to send messages and receive responses. PF driver could receive
> + * messages and send responses.
> + */
> +enum mbox_msg_direction_type {
> +	MBOX_MSG_SEND = 0,
> +	MBOX_MSG_RESP = 1,
> +};
> +
> +/* Indicates if mbox message expects a response (ack) or not */
> +enum mbox_msg_ack_type {
> +	MBOX_MSG_ACK    = 0,
> +	MBOX_MSG_NO_ACK = 1,
> +};
> +
> +enum mbox_msg_data_type {
> +	MBOX_MSG_DATA_INLINE = 0,
> +	MBOX_MSG_DATA_DMA    = 1,
> +};
> +
> +enum mbox_msg_src_type {
> +	MBOX_MSG_FROM_MBOX = 1,
> +};
> +
> +enum mbox_msg_aeq_type {
> +	MBOX_MSG_AEQ_FOR_EVENT = 0,
> +	MBOX_MSG_AEQ_FOR_MBOX  = 1,
> +};
> +
> +#define HINIC3_MBOX_WQ_NAME  "hinic3_mbox"
> +
> +struct mbox_msg_info {
> +	u8 msg_id;
> +	u8 status;
> +};
> +
> +struct hinic3_msg_desc {
> +	void                 *msg;
> +	u16                  msg_len;
> +	u8                   seq_id;
> +	u8                   mod;
> +	u16                  cmd;
> +	struct mbox_msg_info msg_info;
> +};
> +
> +struct hinic3_msg_channel {
> +	struct   hinic3_msg_desc resp_msg;
> +	struct   hinic3_msg_desc recv_msg;
> +};
> +
> +struct hinic3_send_mbox {
> +	u8 __iomem *data;
> +	void       *wb_vaddr;
> +	dma_addr_t wb_paddr;
> +};
> +
> +enum mbox_event_state {
> +	MBOX_EVENT_START   = 0,
> +	MBOX_EVENT_FAIL    = 1,
> +	MBOX_EVENT_SUCCESS = 2,
> +	MBOX_EVENT_TIMEOUT = 3,
> +	MBOX_EVENT_END     = 4,
> +};
> +
> +struct mbox_dma_msg {
> +	u32 xor;
> +	u32 dma_addr_high;
> +	u32 dma_addr_low;
> +	u32 msg_len;
> +	u64 rsvd;
> +};
> +
> +struct mbox_dma_queue {
> +	void       *dma_buf_vaddr;
> +	dma_addr_t dma_buf_paddr;
> +	u16        depth;
> +	u16        prod_idx;
> +	u16        cons_idx;
> +};
> +
> +struct hinic3_mbox {
> +	struct hinic3_hwdev       *hwdev;
> +	/* lock for send mbox message and ack message */
> +	struct mutex              mbox_send_lock;
> +	/* lock for send mbox message */
> +	struct mutex              msg_send_lock;
> +	struct hinic3_send_mbox   send_mbox;
> +	struct mbox_dma_queue     sync_msg_queue;
> +	struct mbox_dma_queue     async_msg_queue;
> +	struct workqueue_struct   *workq;
> +	/* driver and MGMT CPU */
> +	struct hinic3_msg_channel mgmt_msg;
> +	/* VF to PF */
> +	struct hinic3_msg_channel *func_msg;
> +	u8                        send_msg_id;
> +	enum mbox_event_state     event_flag;
> +	/* lock for mbox event flag */
> +	spinlock_t                mbox_lock;
> +};
> +
> +void hinic3_mbox_func_aeqe_handler(struct hinic3_hwdev *hwdev, u8 *header,
> +				   u8 size);
> +int hinic3_init_mbox(struct hinic3_hwdev *hwdev);
> +void hinic3_free_mbox(struct hinic3_hwdev *hwdev);
> +
>   int hinic3_send_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
>   			     const struct mgmt_msg_params *msg_params);
> +int hinic3_send_mbox_to_mgmt_no_ack(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
> +				    const struct mgmt_msg_params *msg_params);
>   
>   #endif
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
> index c994fc9b6ee0..a68d37cc8f2c 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
> @@ -51,6 +51,12 @@ struct hinic3_dyna_txrxq_params {
>   	struct hinic3_irq_cfg      *irq_cfg;
>   };
>   
> +struct hinic3_intr_coal_info {
> +	u8  pending_limt;
> +	u8  coalesce_timer_cfg;
> +	u8  resend_timer_cfg;

extra " " can be remove after u8

> +};
> +
>   struct hinic3_nic_dev {
>   	struct pci_dev                  *pdev;
>   	struct net_device               *netdev;
> @@ -70,13 +76,13 @@ struct hinic3_nic_dev {
>   	u16                             num_qp_irq;
>   	struct msix_entry               *qps_msix_entries;
>   
> +	struct hinic3_intr_coal_info    *intr_coalesce;
> +
>   	bool                            link_status_up;
>   };
>   
>   void hinic3_set_netdev_ops(struct net_device *netdev);
> -
> -/* Temporary prototypes. Functions become static in later submission. */
> -void qp_add_napi(struct hinic3_irq_cfg *irq_cfg);
> -void qp_del_napi(struct hinic3_irq_cfg *irq_cfg);
> +int hinic3_qps_irq_init(struct net_device *netdev);
> +void hinic3_qps_irq_uninit(struct net_device *netdev);
>   
>   #endif
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_wq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_wq.c
> index 2ac7efcd1365..dcab96cdc2bf 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_wq.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_wq.c
> @@ -6,6 +6,109 @@
>   #include "hinic3_hwdev.h"
>   #include "hinic3_wq.h"
>   
> +#define WQ_MIN_DEPTH            64
> +#define WQ_MAX_DEPTH            65536
> +#define WQ_PAGE_ADDR_SIZE       sizeof(u64)
> +#define WQ_MAX_NUM_PAGES        (HINIC3_MIN_PAGE_SIZE / WQ_PAGE_ADDR_SIZE)
> +
> +static int wq_init_wq_block(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq)
> +{
> +	struct hinic3_queue_pages *qpages = &wq->qpages;
> +	int i;
> +
> +	if (hinic3_wq_is_0_level_cla(wq)) {
> +		wq->wq_block_paddr = qpages->pages[0].align_paddr;
> +		wq->wq_block_vaddr = qpages->pages[0].align_vaddr;
> +
> +		return 0;
> +	}
> +
> +	if (wq->qpages.num_pages > WQ_MAX_NUM_PAGES) {
> +		dev_err(hwdev->dev, "wq num_pages exceed limit: %lu\n",
> +			WQ_MAX_NUM_PAGES);
> +		return -EFAULT;
> +	}
> +
> +	wq->wq_block_vaddr = dma_alloc_coherent(hwdev->dev,
> +						HINIC3_MIN_PAGE_SIZE,
> +						&wq->wq_block_paddr,
> +						GFP_KERNEL);
> +	if (!wq->wq_block_vaddr)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < qpages->num_pages; i++)
> +		wq->wq_block_vaddr[i] = cpu_to_be64(qpages->pages[i].align_paddr);
> +
> +	return 0;
> +}
> +
> +static int wq_alloc_pages(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq)
> +{
> +	int err;
> +
> +	err = hinic3_queue_pages_alloc(hwdev, &wq->qpages, 0);
> +	if (err)
> +		return err;
> +
> +	err = wq_init_wq_block(hwdev, wq);
> +	if (err) {
> +		hinic3_queue_pages_free(hwdev, &wq->qpages);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static void wq_free_pages(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq)
> +{
> +	if (!hinic3_wq_is_0_level_cla(wq))
> +		dma_free_coherent(hwdev->dev,
> +				  HINIC3_MIN_PAGE_SIZE,
> +				  wq->wq_block_vaddr,
> +				  wq->wq_block_paddr);
> +
> +	hinic3_queue_pages_free(hwdev, &wq->qpages);
> +}
> +
> +int hinic3_wq_create(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq,
> +		     u32 q_depth, u16 wqebb_size)
> +{
> +	u32 wq_page_size;
> +
> +	if (q_depth < WQ_MIN_DEPTH || q_depth > WQ_MAX_DEPTH ||
> +	    !is_power_of_2(q_depth) || !is_power_of_2(wqebb_size)) {
> +		dev_err(hwdev->dev, "Wq q_depth %u or wqebb_size %u is invalid\n",

could be "Invalid WQ: q_depth %u, wqebb_size %u\n"

> +			q_depth, wqebb_size);
> +		return -EINVAL;
> +	}
> +
> +	wq_page_size = ALIGN(hwdev->wq_page_size, HINIC3_MIN_PAGE_SIZE);
> +
> +	memset(wq, 0, sizeof(*wq));
> +	wq->q_depth = q_depth;
> +	wq->idx_mask = q_depth - 1;
> +
> +	hinic3_queue_pages_init(&wq->qpages, q_depth, wq_page_size, wqebb_size);
> +	return wq_alloc_pages(hwdev, wq);
> +}
> +
> +void hinic3_wq_destroy(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq)
> +{
> +	wq_free_pages(hwdev, wq);
> +}
> +
> +void hinic3_wq_reset(struct hinic3_wq *wq)
> +{
> +	struct hinic3_queue_pages *qpages = &wq->qpages;
> +	u16 pg_idx;
> +
> +	wq->cons_idx = 0;
> +	wq->prod_idx = 0;
> +
> +	for (pg_idx = 0; pg_idx < qpages->num_pages; pg_idx++)
> +		memset(qpages->pages[pg_idx].align_vaddr, 0, qpages->page_size);
> +}
> +
>   void hinic3_wq_get_multi_wqebbs(struct hinic3_wq *wq,
>   				u16 num_wqebbs, u16 *prod_idx,
>   				struct hinic3_sq_bufdesc **first_part_wqebbs,
> @@ -27,3 +130,8 @@ void hinic3_wq_get_multi_wqebbs(struct hinic3_wq *wq,
>   		*second_part_wqebbs = get_q_element(&wq->qpages, idx, NULL);
>   	}
>   }
> +
> +bool hinic3_wq_is_0_level_cla(const struct hinic3_wq *wq)
> +{
> +	return wq->qpages.num_pages == 1;
> +}
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_wq.h b/drivers/net/ethernet/huawei/hinic3/hinic3_wq.h
> index ab37893efd7e..564a9ea6064f 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_wq.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_wq.h
> @@ -67,10 +67,20 @@ static inline void hinic3_wq_put_wqebbs(struct hinic3_wq *wq, u16 num_wqebbs)
>   	wq->cons_idx += num_wqebbs;
>   }
>   
> +static inline u64 hinic3_wq_get_first_wqe_page_addr(const struct hinic3_wq *wq)
> +{
> +	return wq->qpages.pages[0].align_paddr;
> +}
> +
> +int hinic3_wq_create(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq,
> +		     u32 q_depth, u16 wqebb_size);
> +void hinic3_wq_destroy(struct hinic3_hwdev *hwdev, struct hinic3_wq *wq);
> +void hinic3_wq_reset(struct hinic3_wq *wq);
>   void hinic3_wq_get_multi_wqebbs(struct hinic3_wq *wq,
>   				u16 num_wqebbs, u16 *prod_idx,
>   				struct hinic3_sq_bufdesc **first_part_wqebbs,
>   				struct hinic3_sq_bufdesc **second_part_wqebbs,
>   				u16 *first_part_wqebbs_num);
> +bool hinic3_wq_is_0_level_cla(const struct hinic3_wq *wq);
>   
>   #endif


Thanks,
Alok


