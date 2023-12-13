Return-Path: <netdev+bounces-57039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CB4811B84
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 18:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AC911F215BB
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 17:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08B15473F;
	Wed, 13 Dec 2023 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZL1L2IFw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RUEFf/5h"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D441E8
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 09:46:46 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDER4iR024286;
	Wed, 13 Dec 2023 17:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=BxrstjGco8Ew3sDDfo+rXBZa/Z7mQNkpMqwIERrUhrY=;
 b=ZL1L2IFw2V6MstiW8cvzdlAKEnapFRImouD2FSQFyZfGFy5AkylA4zBGNdOt0q5VD95Q
 INYj5jRnz+Jmcu8bh+1PGl/0EGg6iaiLjeMzzIkpsgHjq1iJV8ecPFB1j6iWNhjEhAj3
 uiag3UJHWZyPYsqEoKRNWH0GiVz4ehzbAwgrieHb2OgcxggxBdd5S0k2GpTy3HJ9NRm8
 kejVKPLyrlCouedk6WsLt4bLrCHmoAmKdv7YkzrNlJaoMVLtQo+b9hBSnropGKot1fvY
 quq36zmymoqD8DAiZgw1Nas9GuCFoZMrxIOrBrlz7Q6CdPlpFvN200p3AQjpqdyLclid 1A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwgn3q3ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 17:46:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDH4HdT012807;
	Wed, 13 Dec 2023 17:46:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep8p71d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 17:46:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPOQ2rW6ilL9JvMbrEq+Kv8jGRUOHXxjqt8iVfeVXJGNanUFupZEOaV8MDyK5QKu09HtK8H1AyxAQBd8S7gF48Y4TzPiupBfpqFO9DUjJ63rZkXUl12rysPMxLDQ5IRjqACrafDBgIyld9YvR43+CpkvGhc15GT8ho15eyYJyKqxJsR/RLfAkTWOb0kU66EUx1OsGucIfqkZpq8sbweFxF+0PctBMD/ZizMv7m2231RcXBOnYqtFvS5ijJHYlJk9v8A/Md3nHYapXD8eIHVKhsKw72YP/hT0thqB/fG6IBDuzbzAZXNybI2UrXo1AGgHte2kwfHoroEE42nOpBqqLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxrstjGco8Ew3sDDfo+rXBZa/Z7mQNkpMqwIERrUhrY=;
 b=OW/tCuccJ2OtGB5IgwtZ2FRbUwozoyID9Awq/gZZI79SQghn7EJGAP5cQfc6VfBmiWym0IMD1O2ANIN+zSX3W3H9snBPL2Fs/l0HdsiMhuLfkoOgLqf3BoH3O37SlkQQrZ4K5iZtcDvvoX+zYG5QlDtgF2Y7fr0loOLNNSgH1u5q2GDn8IAkSJaMG0KxGBLv5K/i+gh5ljZNQjtxECX3wfT1nESI5oQBNvWlDWl20r2ycbF/xWGAnw23o/t60Ht60me1idIXTsirCXoaCp+uy9MUt6AO+4dq0EtaPCbqGvxCGXEjUDSNjNsygsVaSwvw5wsoGik01VEaJ2tH9O8XVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxrstjGco8Ew3sDDfo+rXBZa/Z7mQNkpMqwIERrUhrY=;
 b=RUEFf/5hsycZeMI+fn4zwTsxRUcwy6FBaU+ezuejfNFWy1leVQGLrGdt1ua0DNCvZ3p1n9hL5jO3xMOjB1OPxatQoo57LCo6jyQ9Nr0nFJ1vnJ71o177sblXca0atrchKYeNlmRrIWulyTVXxLWcZ92qtGAdayYf4C7Mg7KO6GQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH0PR10MB4924.namprd10.prod.outlook.com (2603:10b6:610:ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 17:46:35 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee%6]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 17:46:35 +0000
Message-ID: <16a9632e-02b7-371a-c81c-84dcc002718d@oracle.com>
Date: Wed, 13 Dec 2023 17:46:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 2/2] ss: pretty-print BPF socket-local storage
Content-Language: en-GB
To: Quentin Deslandes <qde@naccy.de>, netdev@vger.kernel.org
Cc: David Ahern <dsahern@gmail.com>, Martin KaFai Lau
 <martin.lau@kernel.org>,
        kernel-team@meta.com
References: <20231208145720.411075-1-qde@naccy.de>
 <20231208145720.411075-3-qde@naccy.de>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20231208145720.411075-3-qde@naccy.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0023.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::9) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH0PR10MB4924:EE_
X-MS-Office365-Filtering-Correlation-Id: b179241a-b27f-4f74-572d-08dbfc03734f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JbBdRAaBYNfKoweouaC+XuZARGCjm7VqHxL4ZTnfabRfh5AIZcr8GHAA0qE6e3QiENFiNFTNdlTOeVaEcwy2pi0mXtAeHN8Joq1q8ijJp/zBG17AmK8/zg/jBJBLav/iweYZvnlm0RK0kHbdCXdwcpfTxT9kFMm3j1CO10nM0j7IMkgd2pRgXCAF468+vozs6bA1vBHj2bD/UcyeQoHDI5CAUYXYkodWXdPSwlSL9i8DoUASuCybEt3CDONfZpyXRz18AgtoPWG/dPaXky4PranG93VV+fY3bo8IMhcvdZLgnHMwm0CP4Kip9d8d9Eu8MrWq6zDLsprV9wB0eP8ZLbr+f/+rp6Nuvq0OeMGxUcBblHCng/rGWV9Aj7BEhx8hMhcWkE/zJh9rINFn+ORmRwWow23l28daPS6rgV/UjAVPwlZucnIXfA823NqSGNP7J7DQyEjZqomw9kZQ2PIJ26Dqr0dRIRXjZfs1zOQniGtlmS53dUlFLEb7Wx5erR7nJPJ17sNthsHiR01x1jS4P3JyDaX6J67MTIiXqd23tQCn5zpEhPqCAKgsRf9sBictUv7jUIfhorqt43dKF8eslZXB+wi/hKSj0O3KaeDm8WfEKRvEFSNYdC5Yhu6LfvwEUZK7Oi865DLfchF3TWhxVQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(44832011)(6506007)(53546011)(2616005)(38100700002)(6512007)(8936002)(5660300002)(4326008)(8676002)(41300700001)(2906002)(6486002)(6666004)(478600001)(54906003)(316002)(66556008)(66946007)(66476007)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SE13Q0ZTUmt0SG0xUVdwSlQ1TTdWYU5kbXhnc3dsWEZWTlRWY2RYQUMvaU82?=
 =?utf-8?B?SUpZQk4vSjI4UzBhVWMvbzllT3AwTk01SUVPejVWbGxEZVp0S0ZnYk5SUU9p?=
 =?utf-8?B?bUh1elh0WmE4bmV5WlBsZEx4NFVxeStkbFhWRUpBaHdGdWNWa3NhdE5iWHlC?=
 =?utf-8?B?cVRUTTVqREtxckFlQ2ljb3FxZlk2SjE0aGprTDA3QVd3eXRTRjVxRFdKMmFv?=
 =?utf-8?B?U0JFQ0Y0WU0wdHZyNU9Nais3c0J1bm84QmRiVnI5bk9NNWFHc0NtaFNwYm9Z?=
 =?utf-8?B?K2Ryek0yZldGeXRrbHpnZjNkTTYyN1JzTWhXUEVHbjJhRmFjRjdscWNPM1pH?=
 =?utf-8?B?WUtjZGo5U1JYQy9XakNNWkhVdDQvRmxuTkx1OElaVkJyUytnb2R3RHN4WWRL?=
 =?utf-8?B?RGJOanVScUw3UHNJaVF1WkV5ZjAxSUlucy9JMktBV3RIZkw1bGk0cldFc0dV?=
 =?utf-8?B?N0N1N281MDN0M0hjR0NFdWxiWmlHanpoZ0U3K3N0RCtvWmsvcUY5aHB3azNP?=
 =?utf-8?B?ZXdyakYwdnV1MzZub2p1S3N5SnJHVDBadWlFSFZmdy85dDJlR3oxM1ZHNWVU?=
 =?utf-8?B?a1JzSEdDOWkvR2NBUTlPT0JsQzNybjk5N0Rxdm5oMG9WMFNDU3VYc0E1cUhq?=
 =?utf-8?B?RXAxeXdCbUc3dzMrZ0lOeGF5NDFJbW5vRGxWQWY0R1JuVWttVmVzSDdJdkV5?=
 =?utf-8?B?aWRsS21yZmtHZ0ZTRE40TnBIRW9FR01FaW15OVVldFlYNmdaZG11Q3hmaHJS?=
 =?utf-8?B?YVBEazZhdDZzOWNkSWdZZE9xQkxTWU9JSW4xYzkvRHB0MzVTVWlwNlFwbVF3?=
 =?utf-8?B?VlQ0a1N5bnZwcFo5ZzBuTFVsdXphY0pQWFRIVXo0THA4TXpTeWNwMjhvVTVa?=
 =?utf-8?B?ZndaODhMWDE5KzhVdEJqbXFvYk1UQ2Z6dUZaNjZhRXRLaXBQSGpqVk9vVGtH?=
 =?utf-8?B?ZHVZR1V5c09FazQrcjRIZ01RWFZHbUFFUmRLYTNUZ3hKbkprZy9iRUZtaXlH?=
 =?utf-8?B?NUt1cmVzdUowajc0RWFObXlQWnZoNlVsYlJRMkNjRzlCNWVJV3dpYWh1a2Nm?=
 =?utf-8?B?UWYyY3QyT3VuM0UxeXZ2RmZDdzE5UnJ0Uy8vdVpFNUxZU2lmNGk5eHZCak44?=
 =?utf-8?B?Y043U2RvQlBUZVJCdDlrRWtjSCtmR1l0Y2prZUEvVnhzeldqdEh0LzMvbG1h?=
 =?utf-8?B?WmxvV2RRcWIvMnAvMVVtb0xFUGlFcW1GQ0J6bWU3TitaeFQ4dFBxakpVb2RF?=
 =?utf-8?B?UUNMSWxCeFhDYnNZVDNQdHp3d3FLbVc1aDZQeitkV1I0N0lvdExoMFcwOGtR?=
 =?utf-8?B?RXZ4RS9WZjlhZlJsVGZLWTVzcVRrV04yQWxCYmp1eThRQUV0WllBR2FDeXBZ?=
 =?utf-8?B?NjBUN3JONVVoYng3WlBrRWtsVi9PQUpFanZYcmV2Q2QvN1BrRlBzN3p6ZzlP?=
 =?utf-8?B?dFg4VzFzTlplQ2hpZDhpeGw4UmcxSmQ4Q25LdUFISEROU2g2dWliSGM0ZHpp?=
 =?utf-8?B?MlRxZGp4KzVCR3NQb0t2R0Z2Q21yUmlJZ045cjg2WmwvMm1jRWlNTW5NWFR4?=
 =?utf-8?B?ekxIam5TdWlabGZSVEZTblI3TEtXMFREZWJ5cmUyN3NSYUN4ODFZSGNFakg5?=
 =?utf-8?B?ai84Z3FIWksza2NXcHNjSlNVTTA4UWNUTVpxdngvcGljNXlUV3pTNXduSldV?=
 =?utf-8?B?bXVkSXBya0tSMjBmekpDOFVuWWMzY25VYUNrbEg5aUozaDJBVmJsUHJMbmtO?=
 =?utf-8?B?TkM4VDh3THQ1Tkl3Vld5Qjg2b054cW5MdnRUWEltRnAvMXYyUG9jMUxaV0kw?=
 =?utf-8?B?TFRUeUlxNjlZWE1UODQzWlRaVFFzc214MUZiYVRpWi9NQkhiTHkvVDVXQXM5?=
 =?utf-8?B?NHRuQTJWZ0pWU013Um0zd2lVMEhsZklBQTNyMzNERnBPaW5FTjZ3bi9ycFN4?=
 =?utf-8?B?aUtuOGlIODJrbG15ckV6NElmQmlJTWo3WktEc1djMmVjZ0xWdXkvWEdRQjlo?=
 =?utf-8?B?NkdUTlFlQnMzT2RIanpaNkVCZ1l1Ty9NVmo2U0dQVlNmOG15NmlBVXF2bW1s?=
 =?utf-8?B?dmRVWFVFY3Jtakx4c0NpcjUvNGVxVDBlSDhidFZOZGI5Rk1EdmVjNXRNaERn?=
 =?utf-8?B?K2E4S3FBWGNEdFgzaEdQWDZQQ25SL0czcW15ekQzbzV2VUVOUUtKQmZLSDBt?=
 =?utf-8?Q?X/uM5tD/SLyfohOiM0XDSVU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dGThwhtkopkqWHsbcbbhb15ZAVhDART+9PGiAuo7tqkfN1J+HelV8ltHMgxcRk18jW6sSvgA9MJLZFpJZy1m7wJ+jKal9ClmBe7qTs1jrdvFtlpDas+qKKxonS+1K0BL9/ZR/TzOFNCLrODG6WqPObRXbDQBELGbttUj2rSWS9ZgBMflIrIp+RFfsg8earW4Dz1T82XRIfHX3cMg59jdLNAVJoKsHEYp/w6G0sPbr2zAEUtuZC4k6vVXAErXdmjzG9dDyppLPTVClnZTJWpnVqMYxq1X8vklxBIqZDIZcHYjKQD4lVkjU8o/W0oOj7Kfcq5IFpog7v8VJS9F9kBjbUMMzC1CDS1BQiXqPcHa1k1CMbFSt97QUdje3b43iia5tF1d4U0OwfX1kzs9lXdx8re3SJhpmv+BNo5KYYzRTtgmC53oSY6j4Z1uzrk5q7LcqqDZPhJJ7hgETkAOzn8zW9uvplEU9xHP/nCcMBPZb2pX2RJoDKFhGyRA8ofdONVwAw4Mh1E0s+ugRRe1W4jKBSAv7ie4tCrp/PTtkaOo9tP9D/ZwE0HNdbXOguydkTodI7Wz12kdmkXDca67OtDqIfZaT/IcXBzCaXiH43MoYwQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b179241a-b27f-4f74-572d-08dbfc03734f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 17:46:35.3961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikfVBjsjyS5fOiaHRTxw3YmYAW8bi17+6zJfTJNxGLB3zVpWu8sdDbkQ8j4Z9BS08Fv3Uzx59jmY75u+3yGcyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4924
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_11,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312130127
X-Proofpoint-ORIG-GUID: RbS94txGlA0kN-K_yOyNadX9KqFGXPbU
X-Proofpoint-GUID: RbS94txGlA0kN-K_yOyNadX9KqFGXPbU

On 08/12/2023 14:57, Quentin Deslandes wrote:
> ss is able to print the map ID(s) for which a given socket has BPF
> socket-local storage defined (using --bpf-maps or --bpf-map-id=). However,
> the actual content of the map remains hidden.
> 
> This change aims to pretty-print the socket-local storage content following
> the socket details, similar to what `bpftool map dump` would do. The exact
> output format is inspired by drgn, while the BTF data processing is similar
> to bpftool's.
> 
> ss will use libbpf's btf_dump__dump_type_data() to ease pretty-printing
> of binary data. This requires out_bpf_sk_storage_print_fn() as a print
> callback function used by btf_dump__dump_type_data(). vout() is also
> introduced, which is similar to out() but accepts a va_list as
> parameter.
> 
> COL_SKSTOR's header is replaced with an empty string, as it doesn't need to
> be printed anymore; it's used as a "virtual" column to refer to the
> socket-local storage dump, which will be printed under the socket information.
> The column's width is fixed to 1, so it doesn't mess up ss' output.
> 
> ss' output remains unchanged unless --bpf-maps or --bpf-map-id= is used,
> in which case each socket containing BPF local storage will be followed by
> the content of the storage before the next socket's info is displayed.
> 

this is great! one small idea below, but

> Signed-off-by: Quentin Deslandes <qde@naccy.de>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  misc/ss.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 145 insertions(+), 12 deletions(-)
> 
> diff --git a/misc/ss.c b/misc/ss.c
> index f979b61d..6051b694 100644
> --- a/misc/ss.c
> +++ b/misc/ss.c
> @@ -51,8 +51,13 @@
>  #include <linux/tls.h>
>  #include <linux/mptcp.h>
>  
> +#ifdef HAVE_LIBBPF
> +#include <linux/btf.h>
> +#endif
> +
>  #ifdef HAVE_LIBBPF
>  #include <bpf/bpf.h>
> +#include <bpf/btf.h>
>  #include <bpf/libbpf.h>
>  #endif
>  
> @@ -136,7 +141,7 @@ static struct column columns[] = {
>  	{ ALIGN_RIGHT,	"Peer Address:",	" ",	0, 0, 0 },
>  	{ ALIGN_LEFT,	"Port",			"",	0, 0, 0 },
>  	{ ALIGN_LEFT,	"Process",		"",	0, 0, 0 },
> -	{ ALIGN_LEFT,	"Socket storage",	"",	1, 0, 0 },
> +	{ ALIGN_LEFT,	"",			"",	1, 0, 0 },
>  	{ ALIGN_LEFT,	"",			"",	0, 0, 0 },
>  };
>  
> @@ -1039,11 +1044,10 @@ static int buf_update(int len)
>  }
>  
>  /* Append content to buffer as part of the current field */
> -__attribute__((format(printf, 1, 2)))
> -static void out(const char *fmt, ...)
> +static void vout(const char *fmt, va_list args)
>  {
>  	struct column *f = current_field;
> -	va_list args;
> +	va_list _args;
>  	char *pos;
>  	int len;
>  
> @@ -1054,18 +1058,27 @@ static void out(const char *fmt, ...)
>  		buffer.head = buf_chunk_new();
>  
>  again:	/* Append to buffer: if we have a new chunk, print again */
> +	va_copy(_args, args);
>  
>  	pos = buffer.cur->data + buffer.cur->len;
> -	va_start(args, fmt);
>  
>  	/* Limit to tail room. If we hit the limit, buf_update() will tell us */
>  	len = vsnprintf(pos, buf_chunk_avail(buffer.tail), fmt, args);
> -	va_end(args);
>  
>  	if (buf_update(len))
>  		goto again;
>  }
>  
> +__attribute__((format(printf, 1, 2)))
> +static void out(const char *fmt, ...)
> +{
> +	va_list args;
> +
> +	va_start(args, fmt);
> +	vout(fmt, args);
> +	va_end(args);
> +}
> +
>  static int print_left_spacing(struct column *f, int stored, int printed)
>  {
>  	int s;
> @@ -1213,6 +1226,9 @@ static void render_calc_width(void)
>  		 */
>  		c->width = min(c->width, screen_width);
>  
> +		if (c == &columns[COL_SKSTOR])
> +			c->width = 1;
> +
>  		if (c->width)
>  			first = 0;
>  	}
> @@ -3392,6 +3408,8 @@ static struct bpf_map_opts {
>  	struct bpf_sk_storage_map_info {
>  		unsigned int id;
>  		int fd;
> +		struct bpf_map_info info;
> +		struct btf *btf;
>  	} maps[MAX_NR_BPF_MAP_ID_OPTS];
>  	bool show_all;
>  	struct btf *kernel_btf;
> @@ -3403,6 +3421,22 @@ static void bpf_map_opts_mixed_error(void)
>  		"ss: --bpf-maps and --bpf-map-id cannot be used together\n");
>  }
>  
> +static int bpf_maps_opts_load_btf(struct bpf_map_info *info, struct btf **btf)
> +{
> +	if (info->btf_value_type_id) {
> +		*btf = btf__load_from_kernel_by_id(info->btf_id);
> +		if (!*btf) {
> +			fprintf(stderr, "ss: failed to load BTF for map ID %u\n",
> +				info->id);
> +			return -1;
> +		}
> +	} else {
> +		*btf = NULL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int bpf_map_opts_add_all(void)
>  {
>  	unsigned int i;
> @@ -3418,6 +3452,7 @@ static int bpf_map_opts_add_all(void)
>  	while (1) {
>  		struct bpf_map_info info = {};
>  		uint32_t len = sizeof(info);
> +		struct btf *btf;
>  
>  		r = bpf_map_get_next_id(id, &id);
>  		if (r) {
> @@ -3462,8 +3497,18 @@ static int bpf_map_opts_add_all(void)
>  			continue;
>  		}
>  
> +		r = bpf_maps_opts_load_btf(&info, &btf);
> +		if (r) {
> +			fprintf(stderr, "ss: failed to get BTF data for BPF map ID: %u\n",
> +				id);
> +			close(fd);
> +			goto err;
> +		}
> +
>  		bpf_map_opts.maps[bpf_map_opts.nr_maps].id = id;
> -		bpf_map_opts.maps[bpf_map_opts.nr_maps++].fd = fd;
> +		bpf_map_opts.maps[bpf_map_opts.nr_maps].fd = fd;
> +		bpf_map_opts.maps[bpf_map_opts.nr_maps].info = info;
> +		bpf_map_opts.maps[bpf_map_opts.nr_maps++].btf = btf;
>  	}
>  
>  	bpf_map_opts.show_all = true;
> @@ -3482,6 +3527,7 @@ static int bpf_map_opts_add_id(const char *optarg)
>  	struct bpf_map_info info = {};
>  	uint32_t len = sizeof(info);
>  	size_t optarg_len;
> +	struct btf *btf;
>  	unsigned long id;
>  	unsigned int i;
>  	char *end;
> @@ -3539,8 +3585,17 @@ static int bpf_map_opts_add_id(const char *optarg)
>  		return -1;
>  	}
>  
> +	r = bpf_maps_opts_load_btf(&info, &btf);
> +	if (r) {
> +		fprintf(stderr, "ss: failed to get BTF data for BPF map ID: %lu\n",
> +			id);
> +		return -1;
> +	}
> +
>  	bpf_map_opts.maps[bpf_map_opts.nr_maps].id = id;
> -	bpf_map_opts.maps[bpf_map_opts.nr_maps++].fd = fd;
> +	bpf_map_opts.maps[bpf_map_opts.nr_maps].fd = fd;
> +	bpf_map_opts.maps[bpf_map_opts.nr_maps].info = info;
> +	bpf_map_opts.maps[bpf_map_opts.nr_maps++].btf = btf;
>  
>  	return 0;
>  }
> @@ -3549,8 +3604,23 @@ static void bpf_map_opts_destroy(void)
>  {
>  	int i;
>  	
> -	for (i = 0; i < bpf_map_opts.nr_maps; ++i)
> +	for (i = 0; i < bpf_map_opts.nr_maps; ++i) {
> +		btf__free(bpf_map_opts.maps[i].btf);
>  		close(bpf_map_opts.maps[i].fd);
> +	}
> +}
> +
> +static const struct bpf_sk_storage_map_info *bpf_map_opts_get_info(
> +	unsigned int map_id)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < bpf_map_opts.nr_maps; ++i) {
> +		if (bpf_map_opts.maps[i].id == map_id)
> +			return &bpf_map_opts.maps[i];
> +	}
> +
> +	return NULL;
>  }
>  
>  static inline bool bpf_map_opts_is_enabled(void)
> @@ -3590,10 +3660,63 @@ static struct rtattr *bpf_map_opts_alloc_rta(void)
>  	return stgs_rta;
>  }
>  
> +static void out_bpf_sk_storage_print_fn(void *ctx, const char *fmt, va_list args)
> +{
> +	vout(fmt, args);
> +}
> +
> +#define SK_STORAGE_INDENT_STR "    "
> +
> +static void out_bpf_sk_storage(int map_id, const void *data, size_t len)
> +{
> +	uint32_t type_id;
> +	const struct bpf_sk_storage_map_info *map_info;
> +	struct btf_dump *dump;
> +	struct btf_dump_type_data_opts opts = {
> +		.sz = sizeof(struct btf_dump_type_data_opts),
> +		.indent_str = SK_STORAGE_INDENT_STR,
> +		.indent_level = 2,
> +		.emit_zeroes = 1
> +	};
> +	struct btf_dump_opts dopts = {
> +		.sz = sizeof(struct btf_dump_opts)
> +	};
> +	int r;
> +
> +	map_info = bpf_map_opts_get_info(map_id);
> +	if (!map_info) {
> +		fprintf(stderr, "map_id: %d: missing map info", map_id);
> +		return;
> +	}
> +
> +	if (map_info->info.value_size != len) {
> +		fprintf(stderr, "map_id: %d: invalid value size, expecting %u, got %lu\n",
> +			map_id, map_info->info.value_size, len);
> +		return;
> +	}
> +
> +	type_id = map_info->info.btf_value_type_id;
> +
> +	dump = btf_dump__new(map_info->btf, out_bpf_sk_storage_print_fn, NULL, &dopts);
> +	if (!dump) {
> +		fprintf(stderr, "Failed to create btf_dump object\n");
> +		return;
> +	}
> +
> +	out(SK_STORAGE_INDENT_STR "map_id: %d [\n", map_id);
> +	r = btf_dump__dump_type_data(dump, type_id, data, len, &opts);
> +	if (r < 0)
> +		out(SK_STORAGE_INDENT_STR SK_STORAGE_INDENT_STR "failed to dump data: %d", r);
> +	out("\n" SK_STORAGE_INDENT_STR "]");
> +
> +	btf_dump__free(dump);
> +}
> +
>  static void show_sk_bpf_storages(struct rtattr *bpf_stgs)
>  {
>  	struct rtattr *tb[SK_DIAG_BPF_STORAGE_MAX + 1], *bpf_stg;
> -	unsigned int rem;
> +	unsigned int rem, map_id;
> +	struct rtattr *value;
>  
>  	for (bpf_stg = RTA_DATA(bpf_stgs), rem = RTA_PAYLOAD(bpf_stgs);
>  		RTA_OK(bpf_stg, rem); bpf_stg = RTA_NEXT(bpf_stg, rem)) {
> @@ -3605,8 +3728,13 @@ static void show_sk_bpf_storages(struct rtattr *bpf_stgs)
>  			(struct rtattr *)bpf_stg);
>  
>  		if (tb[SK_DIAG_BPF_STORAGE_MAP_ID]) {
> -			out("map_id:%u",
> -				rta_getattr_u32(tb[SK_DIAG_BPF_STORAGE_MAP_ID]));
> +			out("\n");
> +
> +			map_id = rta_getattr_u32(tb[SK_DIAG_BPF_STORAGE_MAP_ID]);
> +			value = tb[SK_DIAG_BPF_STORAGE_MAP_VALUE];
> +
> +			out_bpf_sk_storage(map_id, RTA_DATA(value),
> +				RTA_PAYLOAD(value));
>  		}
>  	}
>  }
> @@ -6000,6 +6128,11 @@ int main(int argc, char *argv[])
>  		}
>  	}
>  
> +	if (oneline && (bpf_map_opts.nr_maps || bpf_map_opts.show_all)) {
> +		fprintf(stderr, "ss: --oneline, --bpf-maps, and --bpf-map-id are incompatible\n");
> +		exit(-1);
> +	}
> +

I guess it would be possible to provide oneline output if we used
compact-mode + omit-zeros BTF data dumping. Did you try that or is the
output just too cluttered?

>  	if (show_processes || show_threads || show_proc_ctx || show_sock_ctx)
>  		user_ent_hash_build();
>  

