Return-Path: <netdev+bounces-236395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1553C3BBB5
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 15:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F501AA8B3E
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 14:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E073446AF;
	Thu,  6 Nov 2025 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ILkrjtNV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i6nckQ7E"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06495336EDA;
	Thu,  6 Nov 2025 14:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438844; cv=fail; b=WtLnG7im6JYuEF6mL5zV2yYY9x9Rw1gFGeciOFbr34JUVtpmSE7mw803/aaJHIsQupotIXRSqbe6YLm1vB+sDy7a75gXrEIWK4LNm8jT81+gxpkYll5Ijs3CHOfiWUezKtGORa+oMIVQTh/w7DYoHfX70U+6GLJwCvxup3RCPCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438844; c=relaxed/simple;
	bh=enWcgaYkZbRqueT/vWGGNs3yy1nkb+FJPiNPkcMH4Ho=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YPf8QPxyPqbgv9MhP02LpanvPBMIzrZbEnXqS1O6Jfj8tPH38cLusMA3TUl7T4W/sLPt0MgTca1R4vF1dZyq9tLlRE5oL2fj1wsvMGjvdEZMe88DumZWfI/q2a62Oe/ACDkJH32IFYCR0QgTnfM2xcfp91mywPOIMsa34SGT35U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ILkrjtNV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i6nckQ7E; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6C8LBG025043;
	Thu, 6 Nov 2025 14:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=86mPHA/MciG4ZPfB6kZ7lB9EwowrgtxaLYm8GX176PY=; b=
	ILkrjtNVlwa3WTXffNTjK09Z76+0vkkLgZ/KVuTheP0DGDbpAi9RW2f+en5qqzCj
	Uwm72TrzpNOdEZRzIuB5bNuwNHcvyL1TicG53KR8Doc4VRv7k19ce0WRs2p7PeSV
	NDfw9lIF2jCFqYxHeXRZDH5aTMVrvzQLgtVddhT9S9r5eZEbnqJZUhIwcZJG36Jq
	uV6vopTsT52iMIlpyxoisMT85UP7KVljuMRpAQ18RKyB2W8c2YTiLAeihV++qTR3
	sYu/oPrTty98Ps0v0qm3IOpWiuaJvs2zv5pa6Cw3ThsqckFPgl9gAx7ETceKhROr
	3Af4qdzcOw84J5K6iRLvFg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a88akahg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 14:19:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6CRpAR014934;
	Thu, 6 Nov 2025 14:19:53 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nc7g2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 14:19:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sfj+b0/1FmiiBUOANUAozrBUv8o5DKrM1E9hqhQr+dlHwwJRmvGniSWU1fNiKD4mQ5uYUJxDeh6EXBAWrHV4U5tSDoMVb8swND/SH0UUunOeNnlhbg+HKRe/mdc49faRuDJtCNx3TPG77puVg7L3vK8wWAhWC5UrydhQeHVgPXa0U3dR0C7n5VNiMTCQVENQJvhE7LKq8QahwvO8TgFQDz/4Qwr+LQ+X4Zh2Zn0pFtcg+MVuXkWBZQA/VYTr2xX34jEf/hINn/czGgcpL6TDWickHOZLgq+fwMduc1Gr80bYK09WgVuZkeQVwrp53O5ACg6ofWYwZYrFCXfwwX4mSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86mPHA/MciG4ZPfB6kZ7lB9EwowrgtxaLYm8GX176PY=;
 b=rMcXw5DgqhrUlzpqWfF2M3rLuDGAJxT6fkNMXq/tdVThDL3J/kIRwJMffow2G8gzFkkvVO9z0CSnkjtEiHml2xSgpYOC5cjoheXnyxIDqrQmccEygtPom3CjEjWYy5G15+qWnF3oDnv+LUN8SdLowEpMO/FtzOm0xlMQgguBX0KoDXz1urQ8Oi+4HuOgUJmVxrxWePV+XhUTgq71lWc9NviAvmHuPwm0EXeqOOcpHFQ1npAUNMhJCcC0kWav/5PHAqTdF0+9SwRxECJBKxCh6x5N+RCGASlXjvDNRcOnrpd68xdMN7TavRDc9YbXYWlM/YXqmX+UAs2+BC/ZnrCqjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86mPHA/MciG4ZPfB6kZ7lB9EwowrgtxaLYm8GX176PY=;
 b=i6nckQ7EvhlHdlqDzbLI6bAw9vIsQKJ4DsyEvI9rV3HXYXo32ExBEIhQRh0EiAbbEKxXn66z6F58hPdZEo2C69f0EubnBgCBfTf1VqDvRNKsWYWbq/Pg4XMi6vym+hg7rlvHDj3ipDKtO6kvHARX9F1AxsKPVNtJODSbHmztBz0=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by LV3PR10MB7940.namprd10.prod.outlook.com (2603:10b6:408:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 14:19:49 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9253.017; Thu, 6 Nov 2025
 14:19:49 +0000
Message-ID: <2321cbe4-e704-4c19-9d0d-92011f768178@oracle.com>
Date: Thu, 6 Nov 2025 19:49:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH net-next v05 1/5] hinic3: Add PF framework
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>, Markus.Elfring@web.de,
        pavan.chebbi@broadcom.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
        Shen Chenyang <shenchenyang1@hisilicon.com>,
        Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
        Shi Jing <shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>,
        Meny Yossefi <meny.yossefi@huawei.com>,
        Gur Stavi <gur.stavi@huawei.com>
References: <cover.1762414088.git.zhuyikai1@h-partners.com>
 <ef0ccf58f3c32c16a21ac83e8159a529bc87c2d8.1762414088.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <ef0ccf58f3c32c16a21ac83e8159a529bc87c2d8.1762414088.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0314.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::6) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|LV3PR10MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: d0640aee-1818-4de1-b640-08de1d3f8b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGpMd2JJeVhTMDNQTG40K3F2d1kxMzhZTVB3QjYyYkY3WnF6NkI0Q0M4UnMy?=
 =?utf-8?B?QXNSck13Wld0WWVlenBpbUZyTm1XSWNFeTRxcktUNnRtRFNkQkc4NUMzdGdM?=
 =?utf-8?B?c3BVeVdpUnVwbTRYYmVET2g2NlBOQ1pGUjVGVnJzRlVrN2J2d29aSGtmV3Ez?=
 =?utf-8?B?ZnlORWJSaXpCN25qc0xQSWhuc1Q2dExQK0o2Z25jek9PMG9zdHhrWHRJeUUy?=
 =?utf-8?B?Z1VtUGx1TzhEbjEvT3M3ai9KSERoaExLeElyaEdVWUpWclZxTTRKSVU0VVRO?=
 =?utf-8?B?M05wZ2w0ZVdsZldua0Q1dStnd1NtdVgyZnBVN2tRQ1hLeHlRTnlvRW1PN0hu?=
 =?utf-8?B?ajJlWEhzQTlHbXdKd3BDeUFDaEdadTIzdVYvQ0hzUmhwZGgyaTg3cWgxYzhH?=
 =?utf-8?B?S3VyRGQ2bDU0WTBsY3NzWlR2MlFKUk1BWEUwZ1U1WGNUUktYcCsxR2hKTUlG?=
 =?utf-8?B?L0VxSnZHMkFadzdHVjBKZElhUGZpNlZyOGluVnhuS0htOHBzWFhxTDZLWHRT?=
 =?utf-8?B?bkhxQ3NyTC8zdTZsWit6dmRSR3dObWlHWnpvLyt0MG5ZVXlCbUVQZHUxa2Y0?=
 =?utf-8?B?alBYbnBWMHdYcktud3ZzSW9YRjBmajlIdnA1eEVaOUZHNWVLb3NxUnpZN2U4?=
 =?utf-8?B?V29HZFQ1aFVRSVhzOENtSllVNnBWWG9ERlNYVkV1RVM1ZHJjS3J3a0treFNU?=
 =?utf-8?B?cHVMVFJQd0NWRUNRcStUTFFRdUpyNGNRdlhGajFWejhCOXc4ZHVRWkJ0aEht?=
 =?utf-8?B?WmpzV1JiS21ZREZwQ0RZR0xkT0RFQVM1aGozcHY5VTJpVm5BT2tQYlhBaDVR?=
 =?utf-8?B?TVFCNk5CMUlORVN4RzUzNkF5ZEhlbUZhY3N2akFtdVM1L2VWUjVYSFN2RXZD?=
 =?utf-8?B?a2JCWkQzTDE5ZUxtOWVwbVI2dHNrNUZXK0I2WWc5T0gyOG1wT1NnVW5ZVjBi?=
 =?utf-8?B?VC9XTGs3cndZK0haOVNueWRIcVA0ckwvckJkejZpV2dueXZkY01JMkYxa0tL?=
 =?utf-8?B?cjlFZ0dQd1NYQzVxcHduV2NQU005L2Uya0ljNDVZVUU4azMySmw4cmo2aVVj?=
 =?utf-8?B?VktJbU9xMzVsWFRCa2FQd1lTTHJ5YVNxdmNyTW9UZHl5Z3Y4YUxydUIzdWdI?=
 =?utf-8?B?VWRVUFdodmkzMjVBeUptcC9GZmF0YjcyT1hLRGRpb05iL2lzUU1RWkpRTjFU?=
 =?utf-8?B?NkFtSkliaFlFdnZESGlmbzJObjdENjd0RkFlRVlpRTRaMy9NNzFycmNGNzhN?=
 =?utf-8?B?WitNbjdxTVRGN3VLUmNFeFNjQnliTnJGMVkyenk2UVFxOWVheFEvRGsrNVRa?=
 =?utf-8?B?RjIzT0lHRmhwallRVFJMWEhCQURUMVF0V2I5SHJ2OFQyVjVKWUF1aFN4dnla?=
 =?utf-8?B?SjBuanlEb2ZLclVMT0sycWovWFQvVHRsMkJaMjNDS0l3WFhSd3MvT1ZVaUow?=
 =?utf-8?B?ZVp4Tmhzbk5Pbmpuanl5bmhQNWZQUzRYdEl0TU14NlNUU0ZFY2VTYzcxcHFx?=
 =?utf-8?B?ekFMOE00TGp1eUd4WkhscmUwN3BBSXI5UkwxS0l1dVFQM0pEMEJIa0ExY25R?=
 =?utf-8?B?TWdrYW16TnhWSTI5cDh4WDkwdFBxbzJoeWhZTWJNd1Q0bWZxbDlLNVBtTW4x?=
 =?utf-8?B?RWt6SlVUaE5hSWIrdVBGNmgrSk1NTGFXcDEvQmxKLzZaQmhFT0xFOWhnY0xF?=
 =?utf-8?B?NHlJRldoNnBubHJudXB4NmQxRFFDSUl0dGtuNTBFVURMMEcwR0FXN1V0UTJR?=
 =?utf-8?B?ZU10bGQzQVc0YWdMWkJRa2tQZDZ5R3plb2FEK0RISHRRcktRVW4rdVphWG41?=
 =?utf-8?B?RjBJMFluK05wOGt1TDBZamtXRzJvUnZwZzE4Uy9GdHR1KzY5QXAwL1BuS0hR?=
 =?utf-8?B?cEdDbFlUbnhwMDRpc0IvV3pKZGFqbE05d3BwNmRMUFpsbnRjRnR4eXNVaE1H?=
 =?utf-8?B?cEJrUXo2QXErakQ0QStYYUFKbVZwTE4wTnc2MjZFUEdKMjhmQmkreE9WZXlr?=
 =?utf-8?Q?yHGfQtIN8fUs6jzCQ7Amtq8dEh3hoo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YStEY3VKeGtUOEQ4YnRCVDlLV2s4WCtMc2RTYTA4NW1QdXU2YWdncGtHK1Nt?=
 =?utf-8?B?OCtzWEVrY1lKTElXTm9yNjNxVGN5cUlWaWxRZUg3d1p2Ti9FQWJxdlZNQnJP?=
 =?utf-8?B?eEpOTm9UTWwrUE9DLzNBeWxhT243OWl6L1k5UXdiaDg3NnFVVUxCZUJNNFFU?=
 =?utf-8?B?SFphclZ3cUlLMk9KdzdTa29Ud3dvMjJyMFpRMGF1TUcrL2t4NFZlRlVVZTlk?=
 =?utf-8?B?aVQrU0ZkcWRNd3RNWURsc0E2Q01rZU4vOTQvblhIRW9BOXNiL1lnUUJmSUhm?=
 =?utf-8?B?NVJXTlcxSjlHRVY3dzFCdHJuak5nbW5FZFc1V0FFRDI5ZU1LTENrNWFTMUox?=
 =?utf-8?B?WEFLcmxNRmw2MmRXNit2Z0FFVGVwYXl4SGRTZllrb3VqcXo3ZjI4MDdtRjh2?=
 =?utf-8?B?K0xFeDhUbjRTOTFUUXZhWXAycXVUdnNSd2pNajJGRncvc1R0MHkwRkdRUGty?=
 =?utf-8?B?MnpYSUdKK3YyVHlVVjFLQzlGUS9rRVVGT0FzbllIZkhPem9wWDRPeXBidGMw?=
 =?utf-8?B?RS9LUlhtQjNqK3cxM1hsSEFNTTI0WkJxT2I3ZjJpL0hGUFZmeDNQNS9hYkZs?=
 =?utf-8?B?d3dLUy85aEZpYVphMXNPTTExMGM5ZDNOV3ZVdXJxYlRYWmxnQitQbWRHZ1RE?=
 =?utf-8?B?S0lOQ28rNmhSUzMxK0xKekFjNW1Hcks2ODFTL3h4UU8wdEJVNWREbDhDZE5I?=
 =?utf-8?B?VWJiQ2RXUHgvZ0xPVDhKck1oUHJVTC9yanNsZmE4N3lNekZFMTU3OUxsTGht?=
 =?utf-8?B?bURDU1JlQU52ODI5ZlQ0NnJlMU43QVlhL0liODM5eUxqaVMxVGtnbThzeExK?=
 =?utf-8?B?MmkvS0xyM2U3U2QzT1hVbElacEc0L3BJWHJQcTI5TE8vL2wrN2NiYlNRenli?=
 =?utf-8?B?dFBZdEZTSENsbUp3cE44ZllpTCswcmt2OGxNWFc4Szh1c3N0eGVHOXlXdUg3?=
 =?utf-8?B?SkY1K0t2U3NHZkdta2UzU1NDc0I1V01KNVc3bzcxZDU5TkxZRTNQYU5GRDFG?=
 =?utf-8?B?OTF1Qmt6aDk3S2NCV2dmbE1MMWFSNWFjOW9GeG4rZHRadlJ4OEloOTM3NURK?=
 =?utf-8?B?T1prSTJzOE44WlFkVVZwOWFiQitvTzh5RGFOcUJHT0ZmNjRhY0k1MUJ3NWMy?=
 =?utf-8?B?V09VOVc1OERZSEpYWENYZFhpZkFNQ1kvK0toaG5jRlhTYW5tbnNVNHg1UlQ5?=
 =?utf-8?B?bkNGelpQUnRhNExiaVU1Y1hXQ3RTT1BmRjhHSmh6Sy9NNXQ3clhhRW9SWGJi?=
 =?utf-8?B?c0Exa2Q5NHB1SDBVNzdZZlJpeFhJQk1mQkwvdFNJUjNlZHVpTUpjV3JXc04z?=
 =?utf-8?B?VWFsaFN4ZGZGdGtoUXkxTWN5bDBJRlJIcy9MQno4bTljR1FDUkl3ZVhDcm1L?=
 =?utf-8?B?aHp6NFI3WC9VOFpCRjV2NklYSGhPM0pTWVZOWHk0L25mbU5ZdlNlTXFhRStP?=
 =?utf-8?B?YjJ0VlJWYlpTLzZmM2tIa3VmQUlWSzFadk5oNVhJNThYKzFTQUdxNXczQmJl?=
 =?utf-8?B?b0MydUpFMTFXTjJtTUg4VW9qb2t5SFZMTmczcmxlc3p6SzNKazlxdnorTzEz?=
 =?utf-8?B?M0lKRDE0NXJzekJrdlNBUEJkTVdIMXc5bUNYUEREMjFwbUdDZ1ZGSzA5UElL?=
 =?utf-8?B?RjlPN3FsRHhPT2MxZkhLa0Njd2ZrTVRmYld3MTQ4aXV6RGdyL0lJRGtsakk5?=
 =?utf-8?B?TXFEN3hxc0hvWU1TbkU4bm81RC95bktCZGFYbHRhd1lCNWRBT2JsT2htZUNC?=
 =?utf-8?B?YkwzdVdVWDFkY0xFaWpyamJTeUsvM3phQUlmVGl3dStzNmdIMnZpZGI2a0Y3?=
 =?utf-8?B?ZnkxV3ZhRlZUNi9SL2NnREtJQkVsUkoveE9mdmpFM1hGVmNCS2dmWGU1WnRT?=
 =?utf-8?B?S0FBZVI3ZnR1a1NRbDVJSnQ1dHl5YS9sYitnMlloQXpYUm5YakFySDc4Qjkw?=
 =?utf-8?B?MW0xN3FVU004SnY0aklxZjNSRkNKSGxJVEljelpjeTRIWnhITHFLdEV3WG9I?=
 =?utf-8?B?N0ZoSDRZbmpaYVpaVzYxYkFJK2RwNVdoaytzdDl5SitESnBFMEJhYm9CL2ps?=
 =?utf-8?B?amRRRHJKcEtVdHN4YWVTL1JmZmFIeksyeGRrTkJpRmZwcTZONXVwMjNjTjBN?=
 =?utf-8?B?SlVkcUh0TGN5aVhNY04xcmZucEV0TmE3R1VaMy9kN2N0WVgrdWUzR1hIR3Jh?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+7RzNEGAy1L9o7ZP7zRrYZ2ZkfeX1Jf5NjMrzdfY54Rg897bXnweUSzlqII9chxeSKtmEMV7rjE8SYp50f4ZqEYujQVqF++KbRVt/ayQIwLwrahohFjfADn3nOx5qRv0p4YsjzH726oy5eSQNt70gI1kdV+E41alodSDYFp2rM3S9+f0UY0LymzO8iEPoPO6y1Kwmhm7Hx+aQp6umHjqMKLiqOT1k1nMBoJMthbPt3z+LO4i+edTq9IPmDiqyYpm/IxpRxAKti+BSeB0NtXf9Bz9OuLqqPFyqjFpoqhaoK85XE+u5l45fod1wIwBpG2s6RpmgUlX5Xgkh6p48KMEvhag+35DZPmPPYLmfEfAbyKIlByBR1rfy2uaQevLA7ZQUfnE1BA8W97JDFYf53cKV9egSv/pYSLt4cUtmXClGc/yH7tZIp7Qf5NlTP9Qf5POf+7At3v4cWrK+eSHnZQ8hJlwX/v66XNwdzubAlj5V76A8/FLzuyK/e+je+Xccr7W/enxmoYIv6g2ZsOAdzR82jA+3HVmN/OkfSNr63nO3WaPYW4nT40RLx57HhZx0z2VvraYdb6OAu0brWgNEkSApbxvAVPjJkhYM/4nl/ViiXc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0640aee-1818-4de1-b640-08de1d3f8b6c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 14:19:49.4898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqqBCwH2y2rgmvTlSjAG1si6V1mANtz57Uz8jlVepMAdHUaQUMHBWBzuj/imIfwR0z+1KVSKKCEhRVU0uJY8dC7gjdTwx+Aey9RRXogylEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7940
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060113
X-Authority-Analysis: v=2.4 cv=LsGfC3dc c=1 sm=1 tr=0 ts=690cae89 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NKU6vsyuSyQFUzYIt94A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: SuW88eQ_rGl7lv22vdNJUjcw38XI21bB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEwOSBTYWx0ZWRfX5nHr/TWkGvpB
 75Hm9y9zGkTd3G5iNr+8DwEXiWWo9ZQz7YYTRhQIRmieobjyvDjwS9pXEkrpRinblwoA4UFFgNU
 dWox/ASd0pcGcwVBLGxgqYXWlw7QeqwiYbDO3T28g7ZQ2SrTJ2tNLsUtufLoQ/8Er0UE+QKgKCH
 OzwNTbTcKMi11BfEy2k9N8DvK010ugGHI7mX9BHuC9w6cjio2sEdYAgjDppbmcALiXuGx3s+VZZ
 5CO+rQuSvMUIaDMfiyw99tss280J1MRDLKKf7lemsDkrhNS9BQce4w7DRRwdeUrn/gt+pT4cPW/
 PATKKuewTxdn5Cc+NBQmvaIQ9mplXctQ9/PfOv22ZOoZusdbVa3tyHkVnORSCVJ8ijEktRaycBZ
 mQgPuIPiQaGtUrmvVd8CpHDX5fuHDw==
X-Proofpoint-GUID: SuW88eQ_rGl7lv22vdNJUjcw38XI21bB


> +
> +void hinic3_sync_time_to_fw(struct hinic3_hwdev *hwdev)
> +{
> +	struct timespec64 ts = {};
> +	u64 time;
> +	int err;
> +
> +	ktime_get_real_ts64(&ts);
> +	time = (u64)(ts.tv_sec * MSEC_PER_SEC + ts.tv_nsec / NSEC_PER_MSEC);
> +
> +	err = hinic3_sync_time(hwdev, time);
> +	if (err)
> +		dev_err(hwdev->dev,
> +			"Synchronize UTC time to firmware failed, errno:%d.\n",

what about "failed, err=%d\n" ?

> +			err);
> +}
> +
>   static int get_hw_rx_buf_size_idx(int rx_buf_sz, u16 *buf_sz_idx)
>   {
>   	/* Supported RX buffer sizes in bytes. Configured by array index. */
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
> index 304f5691f0c2..c9c6b4fbcb12 100644
>   
>   	err = hinic3_mapping_bar(pdev, pci_adapter);
> @@ -331,8 +362,24 @@ static int hinic3_probe_func(struct hinic3_pcidev *pci_adapter)
>   	if (err)
>   		goto err_unmap_bar;
>   
> +	if (HINIC3_IS_PF(pci_adapter->hwdev)) {
> +		bdf_info.function_idx =
> +			hinic3_global_func_id(pci_adapter->hwdev);
> +		bdf_info.bus = pdev->bus->number;
> +		bdf_info.device = PCI_SLOT(pdev->devfn);
> +		bdf_info.function =  PCI_FUNC(pdev->devfn);
> +
> +		err = hinic3_set_bdf_ctxt(pci_adapter->hwdev, &bdf_info);
> +		if (err) {
> +			dev_err(&pdev->dev, "Failed to set BDF info to fw\n");
> +			goto err_uninit_func;
> +		}
> +	}
> +
>   	return 0;
>   
> +err_uninit_func:
> +	hinic3_func_uninit(pdev);
>   err_unmap_bar:
>   	hinic3_unmapping_bar(pci_adapter);
>   
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> index 6d87d4d895ba..a7c9c5bca53a 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> @@ -130,6 +130,7 @@ static int hinic3_sw_init(struct net_device *netdev)
>   {
>   	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
>   	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
> +	u8 mac_addr[ETH_ALEN];
>   	int err;
>   
>   	nic_dev->q_params.sq_depth = HINIC3_SQ_DEPTH;
> @@ -137,16 +138,29 @@ static int hinic3_sw_init(struct net_device *netdev)
>   
>   	hinic3_try_to_enable_rss(netdev);
>   
> -	/* VF driver always uses random MAC address. During VM migration to a
> -	 * new device, the new device should learn the VMs old MAC rather than
> -	 * provide its own MAC. The product design assumes that every VF is
> -	 * suspectable to migration so the device avoids offering MAC address
> -	 * to VFs.
> -	 */
> -	eth_hw_addr_random(netdev);
> +	if (HINIC3_IS_VF(hwdev)) {
> +		/* VF driver always uses random MAC address. During VM migration
> +		 * to a new device, the new device should learn the VMs old MAC
> +		 * rather than provide its own MAC. The product design assumes
> +		 * that every VF is suspectable to migration so the device

susceptible ?

> +		 * avoids offering MAC address to VFs.
> +		 */
> +		eth_hw_addr_random(netdev);
> +	} else {
> +		err = hinic3_get_default_mac(hwdev, mac_addr);
> +		if (err) {
> +			dev_err(hwdev->dev, "Failed to get MAC address\n");
> +			goto err_clear_rss_config;
> +		}
> +		eth_hw_addr_set(netdev, mac_addr);
> +	}
> +
>   	err = hinic3_set_mac(hwdev, netdev->dev_addr, 0,
>   			     hinic3_global_func_id(hwdev));
> -	if (err) {
> +	/* Failure to set MAC is not a fatal error for VF since its MAC may have
> +	 * already been set by PF
> +	 */
> +	if (err && err != -EADDRINUSE) {
>   		dev_err(hwdev->dev, "Failed to set default MAC\n");
>   		goto err_clear_rss_config;
>   	}
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
> index cf67e26acece..b4e151e88a13 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
> @@ -82,10 +82,27 @@ static struct hinic3_msg_desc *get_mbox_msg_desc(struct hinic3_mbox *mbox,
>   						 enum mbox_msg_direction_type dir,
>   						 u16 src_func_id)
>   {
> +	struct hinic3_hwdev *hwdev = mbox->hwdev;
>   	struct hinic3_msg_channel *msg_ch;
> -
> -	msg_ch = (src_func_id == MBOX_MGMT_FUNC_ID) ?
> -		&mbox->mgmt_msg : mbox->func_msg;
> +	u16 id;
> +
> +	if (src_func_id == MBOX_MGMT_FUNC_ID) {
> +		msg_ch = &mbox->mgmt_msg;
> +	} else if (HINIC3_IS_VF(hwdev)) {
> +		/* message from pf */
> +		msg_ch = mbox->func_msg;
> +		if (src_func_id != hinic3_pf_id_of_vf(hwdev) || !msg_ch)
> +			return NULL;
> +	} else if (src_func_id > hinic3_glb_pf_vf_offset(hwdev)) {
> +		/* message from vf */
> +		id = (src_func_id - 1) - hinic3_glb_pf_vf_offset(hwdev);
> +		if (id >= 1)
> +			return NULL;

hard coding id >= 1, is only one VF supported?

> +
> +		msg_ch = &mbox->func_msg[id];
> +	} else {
> +		return NULL;
> +	}
>   
>   	return (dir == MBOX_MSG_SEND) ?
>   		&msg_ch->recv_msg : &msg_ch->resp_msg;
> @@ -409,6 +426,13 @@ int hinic3_init_mbox(struct hinic3_hwdev *hwdev)
>   	if (err)
>   		goto err_destroy_workqueue;
>   
> +	if (HINIC3_IS_VF(hwdev)) {
> +		/* VF to PF mbox message channel */
> +		err = hinic3_init_func_mbox_msg_channel(hwdev);
> +		if (err)
> +			goto err_uninit_mgmt_msg_ch;
> +	}
> +
>   	err = hinic3_init_func_mbox_msg_channel(hwdev);

is hinic3_init_func* second init for PF and
VF executes both calls, is that correct?

>   	if (err)
>   		goto err_uninit_mgmt_msg_ch;
> @@ -424,8 +448,8 @@ int hinic3_init_mbox(struct hinic3_hwdev *hwdev)
>   	return 0;
>   
>   err_uninit_func_mbox_msg_ch:
> -	hinic3_uninit_func_mbox_msg_channel(hwdev);
> -
> +	if (HINIC3_IS_VF(hwdev))
> +		hinic3_uninit_func_mbox_msg_channel(hwdev);
>   err_uninit_mgmt_msg_ch:
>   	uninit_mgmt_msg_channel(mbox);
>   

Thanks,
Alok

