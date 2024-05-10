Return-Path: <netdev+bounces-95251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF3E8C1BDA
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F12DB20BE4
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55459D27D;
	Fri, 10 May 2024 00:57:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BE31391;
	Fri, 10 May 2024 00:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715302647; cv=fail; b=iCtg9GGb4Z4YqoKP5JzUGxS7NRj1CktCh92mSZ6CjwHguRavgYWeQhKM+R2S+Ev/WH+4bG8Fbm9Mx/Q8yLhi29NJ9nvDEw4YDW9J+wuBHzrTF+m+3CBF/wgRJyW+rFnQNEvVNxk6kG6XqihFuRyPKnyYBOU+PLYv4qqKWQiQAZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715302647; c=relaxed/simple;
	bh=6icd0kB3NVKtWJidGS6onPhy94ozUwlDQzPLJhA70BE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c+xzxTbA3qp8ES7o1ecobYsFLMjd7F0IBx/pSh80ahBvl5d5oDuV4rNTCh9skr4WEcuCZkPZGvgWd+IwzhP8XTi1OiNPsoaKKiIEor4GQWIZp58baQYZFICWuHv5B7Uwk4IFEtXjwH4vcdjr7ltvv/y4taCXnohiojrvslNrOLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 449NSvQl024044;
	Thu, 9 May 2024 17:56:33 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3y16w7g3bs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 17:56:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2xgByCad4Q282CWaRSr0M76cJL6YEfbdu6XiOWkc5OuPB6wRYPOLiaDUuK9kGUXu0VRRouzTz5stehWI6jttkdL/JupOpntqD7cVU8aTHIFvo1Px7NhK29j/dvF1hNr/hDL9YneS6If+AwlIQzMEhR9drKWl1SdBp3sqfBMq46R+8lxr/f/xLaCKOKvW35nYmAZqCx3VE31F/lkeImSyOL+87cJfKANQDkaNZRLQhWTQwQ/i+uzB9Au4ZUhlmYEN5Fd3VR5qre+n0K8IiOx5BouQj4t1LFAWxLvuPDx38F6QVO+W/NRQVK/QQ6rNIc4EUmQtkTSz3g2J46Ci0yUtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POzEe3kPXo6dtivb0ZPrs/X5UtDVgq4r/H3F4Rba+TQ=;
 b=oPDhYVxbJLZA/vA6pMwkEP7GHkkUrKK5zOrL+laMmXtGzs9fexUYlUbZTjJZFp3M4VWqluku+XUnwhJsWPGB3wqEFyVd35nqrdfIDtYsVTfzKH93R+C/E3c5jwaMTqwl2ifykXF7ctgrk2P6iGNgl66TAV6DnUL6wh7hTu9O17Lvr0l82KxZueNHgeOawiQhDasgXJgh8hTcmMjg2Yqdas1PS+Bm55G3konVk6kFxRa3EFPxgRSzjrASIJN/4kWiHP18ADN8YqBJ97COzS4UIaeQo1W3qUZ0FIGT9BR3uVpxldCRZS2ixCJtCwCgnSc6NhQF8NHeAOBlWMIPfSjw3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by SA3PR11MB8022.namprd11.prod.outlook.com (2603:10b6:806:2fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Fri, 10 May
 2024 00:56:29 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7544.041; Fri, 10 May 2024
 00:56:29 +0000
Message-ID: <a50018a9-4a59-4fc5-baa9-06b861b36eb0@windriver.com>
Date: Fri, 10 May 2024 11:56:17 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH v4] net: stmmac: move the EST and EST lock to struct
 stmmac_priv
To: Andrew Halaney <ahalaney@redhat.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
        bartosz.golaszewski@linaro.org, horms@kernel.org,
        rohan.g.thomas@intel.com, rmk+kernel@armlinux.org.uk,
        fancer.lancer@gmail.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240509123718.1521924-1-xiaolei.wang@windriver.com>
 <5t4o3ayne7g46rt23lmiz3ksw7zfztbh6tzghojblaicw2zsbu@pv575lrpoltu>
Content-Language: en-US
From: wang xiaolei <xiaolei.wang@windriver.com>
In-Reply-To: <5t4o3ayne7g46rt23lmiz3ksw7zfztbh6tzghojblaicw2zsbu@pv575lrpoltu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::27)
 To MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|SA3PR11MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6a88c2-3598-43c2-3947-08dc708c06a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QkpXRXo1SG1ZOU8yaUpvb0toTTVMM1llUzNib0pKVHNYNEpkeCtSUEw1MWt1?=
 =?utf-8?B?NE85cElzeGs5aGNTZ1d1Ym9hdVdhU2RNOHplOUdTY0hSTEdyb2M0eXcrNVhQ?=
 =?utf-8?B?aEoxV1VzYXNWaDhJbTAyei8wcVBGdm5BMS85NUdtTk1reHcwcTFHaDlvNG50?=
 =?utf-8?B?NmJOTTdYT3d3RCtoSHN5eG9uVDdrdThKK3VjU2RMY1VSTjIrSzZCMTltTTRj?=
 =?utf-8?B?L1Axc1NxczdYaE1nNEE1eURMUU5hZ202NmhpVXlOZWRUMjBHOGQ2RmRNUW1m?=
 =?utf-8?B?eTBmUmpneTlkRDFiTUNCc1lneGQ1T3NFMElFdnBPTzNmQnJEVGorNU03S3Rn?=
 =?utf-8?B?aUdJVmsxdms3ckJQMWhDRURHT1p6eTFhTjZseWVwSllCNkgySUVUZElETjAr?=
 =?utf-8?B?T1NwNDZPQVBOZExXQlJtOERBeU4yaXZLMmVkZG5wMWVTY2ZlRTJQU2dpclBs?=
 =?utf-8?B?SHRuL25WektLL2IwZnIrZmYxSnpLZkhjRGVxRERzdjNhOVM0YWY4WVBIZ0F3?=
 =?utf-8?B?TXV5bE5SQ0k1R1hmdkwyUk1VVmtrYXFGcURYbzR3bk8zYkpYVlhzbXFQdUcy?=
 =?utf-8?B?S2c5L0xVbGRnc2dzR0Fib3lBdVgzSUlNZndkeVFHVWdDSXAvZlFOSExQVFdM?=
 =?utf-8?B?czN0SXJFWVRDQlF4bWhvZ0R3TVZEd1FNc0tNcktsdTBjV20yWjFRa1h5RElu?=
 =?utf-8?B?eXN5UEpqZkY5eVlreWl3ckhFRnRxRUt0eWUwOExBLyt5TjZwZno5VlhQTWEv?=
 =?utf-8?B?RjY5b2dYSVp0Wnk2SjNQOHd1OTBhUVFPV1ZvUHRLekdSTXNHVUZsSE45czFB?=
 =?utf-8?B?QXZhdS9MZGRxR3N2ZzdoZW5lbG9DRXJTbFNVMnNVUzVKTW5oK3VlNlUxaGFP?=
 =?utf-8?B?N2Y2OEdrSm8zT0pBa0w5SjVOR1RES1RTZ0FoeVZFekNPS0k5TDhXbWJZVWhU?=
 =?utf-8?B?VWJIZGhEWXlyQVFVbVg1VnVWaUltbWhUNmJqbFoyZlU3V1p3eDZRN2RUK0dB?=
 =?utf-8?B?dVhsRG5aOXdHUWtMQnNGM1I2bk4rc1ltT20vaTY3TTNQeWhjN3lyZ3NmdEZK?=
 =?utf-8?B?VVlwZVJkSXpIbXk0aWplbzhOWHhDYnFnaEw3blR6Nm50UXMrUWNZUDM2Sklo?=
 =?utf-8?B?UFhNb3ZGVkJtSXhrSjl5ZmM1NHpOUm53UkVFc0JRZzBDYnpoRXpsTHJMK0RH?=
 =?utf-8?B?bTRQTFMvYWNYRVIxOTBUSDM2d01JdWljdkFJZVJMbVFwdFhwUC9lU0xRYmZy?=
 =?utf-8?B?U0pmSGMvcEE1c2RuT3ZBdXd2UlJ4UnFBQXJiV25BN044TmlNL21XRDdRMDlq?=
 =?utf-8?B?K0xnWU9uVUxUVWl2RmNTcmpwWjVFQ1VzTS92ZExxVERsSGdjRTRXVFNPMEhF?=
 =?utf-8?B?cU1tdXdrRzJkYnZ3L2hyVVBzbklrakFEeDVMRlZHbENyNG8vQzlyR3JYVVlW?=
 =?utf-8?B?dmRrNWpzay9vNnRYSERtbUJPWjRWQnhESlRseElnTFZ0Z1BvdC92TU05Z28z?=
 =?utf-8?B?aDYza2hwQzVyQjhlRnhCTjJvcUNSN1FTWUs1dXdvYUNaTm84M1dPUUVadmxT?=
 =?utf-8?B?Y2hQQzE2MU83b1ZyYS83Y0plaTZ6Q3RUMVNUbXpLSklDOW9yZklrQWtxUkdP?=
 =?utf-8?B?dnFwR2c3T1MxRk5xYTRocnRoWTZDNC9aaG44dVFuNEsrYWRDd2pzYkl0d3VU?=
 =?utf-8?B?RjYyRmpoR2paMit3OHhaMEdCTEdnZjVIZU5jdDdqR3pRUUJhS3V6bUhnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K1pHMXFvS0JUR01xVCsxcnpkYzBGY01pTFpvSW1WU1pZbzdZYnFUTFVjdElS?=
 =?utf-8?B?VmtoK3lZRlJoc1A1ai9ySlZjTEUveTZWdUN3UkZzYytNc1FYQVFsNG0vYmpx?=
 =?utf-8?B?aFQrOTFMeHg1MnkzM0FHTFlpZlVONVdnTTVHYllmTE91SENjMVBKa1JtelVZ?=
 =?utf-8?B?Y09FaG5DQVc5ZVRwQjdmLy84cDVXNEVxNGxidDFUeDdBdlNpeXE3Y2x5RmdB?=
 =?utf-8?B?ZTlLc0FrS00zc2hYNFQxMDVNNlE2cFVOUGVYQlNnVkxWVWJoc0NXbkZib2NP?=
 =?utf-8?B?MjZCL0xjRW13eUVzbnNSaTlPUkxQNXJSRU00MS9uR012czVsSWVobXZqTkZP?=
 =?utf-8?B?bGhNOEdLak1Yd0ozUGJLeHRWU29oa3RlWjlueWtzODk0Ylh5bDhad1RDbXFL?=
 =?utf-8?B?UTR2L0xuQ1VZZjBYd0RQZE03RUtFczNQSHVFbXhRUDBtc0lzK1JtUmxMSmZx?=
 =?utf-8?B?UHlma0ZENExGeUYraUdSR3E2MkNNL2djaEhLNERYZjhpY3Z4a2p1ZEwzNyt4?=
 =?utf-8?B?cDI0dWlpbzhxRnQ1VC9nNytzc002Z1pubzAyOU41NkJKQnFlRFZmVEJRa3dL?=
 =?utf-8?B?akZIYzZXbWRPb0twaFgyLzdvN043NHRkOC9STmdjYTZUcENMbFdCUUFDb2dj?=
 =?utf-8?B?MFI3UWVCVWg1YU1NS05tK2l3bjFJeTV2L3FHSmxtdTdyZkVXblVwdFV6L2xv?=
 =?utf-8?B?citjenhTQnhjZkFza1dJSzJ3RTdMVm5rOGUzbGx0b1B6VTllNWp5OUJZWkRk?=
 =?utf-8?B?R2drMHE5aVVFOTA5UCtSaWY5VlM1MnM5MGxZQzJ1bmxxSXlIT3gwT3ZzVVc4?=
 =?utf-8?B?QTYyaWY2Yjdya0tiU29sY243UG5WMDRTRTVSR0NjSkhsRk9lcjBXSVh6V0o4?=
 =?utf-8?B?a0xHZUpoak94dWhkVmhiYm4zd3VOSldVdWhmN1kvdVFhejhxem5MZ1FyeTRM?=
 =?utf-8?B?YVBvemdLa0JaVEZwQ0dQWXJIdkNzdUd6b3F2SEhTbGxhQ3NNd2N1K2p3OWpz?=
 =?utf-8?B?R0hBaFdNZFRuL2dRdGxIVHcwMFpQN0FTREV3L29qVEhJVVNKbDBRdGkvdlNj?=
 =?utf-8?B?M3A3YXYyQ3BGUTJEYVRyR1FMU2pSMDFsNFd4UUFPSDNsTllGNHprQlVtUFlv?=
 =?utf-8?B?bzI5a3dBbU11c2JYUEVDeWlLbk1OOTVnaFhZMmxhakx5ZzRYSEZRY0RiZDFt?=
 =?utf-8?B?czRrVXhjODhWcEJ5SWVHQUV2QnhLLzROL3d3RUFvbTY1ajRsTERaQS9jOUVU?=
 =?utf-8?B?Tm0wMkJ0am9RSDExQXJPVnpHazRabEJ6eXVTZ3FFQ2JqbDBKek10MUtjVXNG?=
 =?utf-8?B?T281NGpSU3lSTFRoVEZHL2hlS1owVkJDYWEwdEt4TVBxZWFoWnU0bEdzZFJ0?=
 =?utf-8?B?K0pjZnREZStBcTZyTUthQi9xcVVxTERIaFFxd24wVEhxcDFRUzlTd2dlQzlo?=
 =?utf-8?B?aHNhU3JGNm1GVWhkSENBNlZPV2hreVByN0FmdkVtWjFrT1Jha0xITUhFNFk3?=
 =?utf-8?B?eUt3NUk5R3ZldS9YMDI1THBjVkI4dUR3WE95VTlPZ3Exdk5iMWROWFhjUktk?=
 =?utf-8?B?Mm95RlhocWRnL3VwQWNxOGpQU1pmWUI3QTZ0RFB4d08yWHBXK0lQRzNuMG92?=
 =?utf-8?B?eDBtNGYvQm1WaitVbzlsK0g5NkFxeVdYckhheXZqcENlUGNla2hiMTErWDRT?=
 =?utf-8?B?aE1UZzRaUCtJSWhFZFBTQWErTkVRSUU3NHBEdDdrT0twUkNvNk5Jdzh5MkMx?=
 =?utf-8?B?bEg0L29hUmNxaUtpQnRFY3FGa1crVHRENXd4ckFLbXBDN2FseGkwS0FJMERK?=
 =?utf-8?B?NnFUN2FBc0t4N0dKNlgyR1NLZnZFb0szWVRsZFdsRmdQME1yWVRNV3hxUzN1?=
 =?utf-8?B?VlVOaytnQkFJT2FJTFRXZ25Ld0lzcXd5ZzE0bDB1MXlIRlZPUmUxNTFVbGZq?=
 =?utf-8?B?SkY0K014ZFZpSmpxeUVHWTZjVThRdjM4QVJiTEV4YTJFNWUwcEJYdWw1QUk3?=
 =?utf-8?B?U0pBUlpiaDZNL2R1bXE2cS9kYzRlalF6bFEwQ0R4eHlLK05KN0M1Q0dvR2tQ?=
 =?utf-8?B?SmUxR3g2OUpQbWYvVGMzVk5xN0lDZUxoR0VxVU1nUHdRa21mVjhTUjNjcU53?=
 =?utf-8?B?dnVBOVQyeThpVno1TXlMVktnODk3QWpjVXFLUUFBeGt3eUxhR040MVJMWWJo?=
 =?utf-8?B?TUE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6a88c2-3598-43c2-3947-08dc708c06a1
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 00:56:29.0969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujuFFFVB2QIYBnRwIViTf9r9cHfTEgWHhOg+TtTGg7aDz8CyjEqI5WruJv5X3a1sIav+7YB8PHIzETdwDzSrO89+BHehv2WjVXUXwpPEIog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8022
X-Proofpoint-GUID: kcWBVplpq3KU6HsmU0ID8D34ZzE2CaxC
X-Proofpoint-ORIG-GUID: kcWBVplpq3KU6HsmU0ID8D34ZzE2CaxC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_12,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405100005


On 5/10/24 1:02 AM, Andrew Halaney wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> Hey Xialei Wang,
>
> Some nitpicky comments below :)
>
> On Thu, May 09, 2024 at 08:37:18PM GMT, Xiaolei Wang wrote:
>> Reinitialize the whole EST structure would also reset the mutex lock
>> which is embedded in the EST structure, and then trigger the following
>> warning. To address this, move the lock to struct stmmac_priv,
>> and move EST to struct stmmac_priv, because the EST configs don't look
>> as the platform config, but EST is enabled in runtime with the settings
> s/as/at/
>
>> retrieved for the TC TAPRIO feature also in runtime. So it's better to
>> have the EST-data preserved in the driver private date instead of the
> s/date/data/
>
>> platform data storage. We also need to require the mutex lock when doing
> s/require/reacquire/
>
> So in this patch you are:
>
> 1. Pulling the mutex protecting the EST structure out to avoid
>     clearing it during reinit/memset of the EST structure
> 2. Moving the EST structure to a more logical location
>
> In my opinion this would make sense in two patches, and the former patch
> would have a:
>
>      Fixes: b2aae654a479 ("net: stmmac: add mutex lock to protect est parameters")
>
> above your Signed-off-by:. Please at least consider adding the Fixes tag!
>
> Otherwise, this change seems good to me.
I will split it into two patches and send a new version

thanks
xiaolei
>
> Thanks,
> Andrew
>
>> this initialization.
>>
>> DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>> WARNING: CPU: 3 PID: 505 at kernel/locking/mutex.c:587 __mutex_lock+0xd84/0x1068
>>   Modules linked in:
>>   CPU: 3 PID: 505 Comm: tc Not tainted 6.9.0-rc6-00053-g0106679839f7-dirty #29
>>   Hardware name: NXP i.MX8MPlus EVK board (DT)
>>   pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>   pc : __mutex_lock+0xd84/0x1068
>>   lr : __mutex_lock+0xd84/0x1068
>>   sp : ffffffc0864e3570
>>   x29: ffffffc0864e3570 x28: ffffffc0817bdc78 x27: 0000000000000003
>>   x26: ffffff80c54f1808 x25: ffffff80c9164080 x24: ffffffc080d723ac
>>   x23: 0000000000000000 x22: 0000000000000002 x21: 0000000000000000
>>   x20: 0000000000000000 x19: ffffffc083bc3000 x18: ffffffffffffffff
>>   x17: ffffffc08117b080 x16: 0000000000000002 x15: ffffff80d2d40000
>>   x14: 00000000000002da x13: ffffff80d2d404b8 x12: ffffffc082b5a5c8
>>   x11: ffffffc082bca680 x10: ffffffc082bb2640 x9 : ffffffc082bb2698
>>   x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000000001
>>   x5 : ffffff8178fe0d48 x4 : 0000000000000000 x3 : 0000000000000027
>>   x2 : ffffff8178fe0d50 x1 : 0000000000000000 x0 : 0000000000000000
>>   Call trace:
>>    __mutex_lock+0xd84/0x1068
>>    mutex_lock_nested+0x28/0x34
>>    tc_setup_taprio+0x118/0x68c
>>    stmmac_setup_tc+0x50/0xf0
>>    taprio_change+0x868/0xc9c
>>
>> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
>> ---
>> v1 -> v2:
>>   - move the lock to struct plat_stmmacenet_data
>> v2 -> v3:
>>   - Add require the mutex lock for reinitialization
>> v3 -> v4
>>   - Move est and est lock to stmmac_priv as suggested by Serge
>>
>>   drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  3 +
>>   .../net/ethernet/stmicro/stmmac/stmmac_main.c | 18 +++---
>>   .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 30 +++++-----
>>   .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 58 +++++++++----------
>>   include/linux/stmmac.h                        |  2 -
>>   5 files changed, 56 insertions(+), 55 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
>> index dddcaa9220cc..e05a775b463e 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
>> @@ -261,6 +261,9 @@ struct stmmac_priv {
>>        struct stmmac_extra_stats xstats ____cacheline_aligned_in_smp;
>>        struct stmmac_safety_stats sstats;
>>        struct plat_stmmacenet_data *plat;
>> +     /* Protect est parameters */
>> +     struct mutex est_lock;
>> +     struct stmmac_est *est;
>>        struct dma_features dma_cap;
>>        struct stmmac_counters mmc;
>>        int hw_cap_support;
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index 7c6fb14b5555..0eafd609bf53 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -2491,9 +2491,9 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
>>                if (!xsk_tx_peek_desc(pool, &xdp_desc))
>>                        break;
>>
>> -             if (priv->plat->est && priv->plat->est->enable &&
>> -                 priv->plat->est->max_sdu[queue] &&
>> -                 xdp_desc.len > priv->plat->est->max_sdu[queue]) {
>> +             if (priv->est && priv->est->enable &&
>> +                 priv->est->max_sdu[queue] &&
>> +                 xdp_desc.len > priv->est->max_sdu[queue]) {
>>                        priv->xstats.max_sdu_txq_drop[queue]++;
>>                        continue;
>>                }
>> @@ -4528,9 +4528,9 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>>                        return stmmac_tso_xmit(skb, dev);
>>        }
>>
>> -     if (priv->plat->est && priv->plat->est->enable &&
>> -         priv->plat->est->max_sdu[queue] &&
>> -         skb->len > priv->plat->est->max_sdu[queue]){
>> +     if (priv->est && priv->est->enable &&
>> +         priv->est->max_sdu[queue] &&
>> +         skb->len > priv->est->max_sdu[queue]){
>>                priv->xstats.max_sdu_txq_drop[queue]++;
>>                goto max_sdu_err;
>>        }
>> @@ -4909,9 +4909,9 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>>        if (stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv))
>>                return STMMAC_XDP_CONSUMED;
>>
>> -     if (priv->plat->est && priv->plat->est->enable &&
>> -         priv->plat->est->max_sdu[queue] &&
>> -         xdpf->len > priv->plat->est->max_sdu[queue]) {
>> +     if (priv->est && priv->est->enable &&
>> +         priv->est->max_sdu[queue] &&
>> +         xdpf->len > priv->est->max_sdu[queue]) {
>>                priv->xstats.max_sdu_txq_drop[queue]++;
>>                return STMMAC_XDP_CONSUMED;
>>        }
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
>> index e04830a3a1fb..a6b1de9a251d 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
>> @@ -68,13 +68,13 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>>        nsec = reminder;
>>
>>        /* If EST is enabled, disabled it before adjust ptp time. */
>> -     if (priv->plat->est && priv->plat->est->enable) {
>> +     if (priv->est && priv->est->enable) {
>>                est_rst = true;
>> -             mutex_lock(&priv->plat->est->lock);
>> -             priv->plat->est->enable = false;
>> -             stmmac_est_configure(priv, priv, priv->plat->est,
>> +             mutex_lock(&priv->est_lock);
>> +             priv->est->enable = false;
>> +             stmmac_est_configure(priv, priv, priv->est,
>>                                     priv->plat->clk_ptp_rate);
>> -             mutex_unlock(&priv->plat->est->lock);
>> +             mutex_unlock(&priv->est_lock);
>>        }
>>
>>        write_lock_irqsave(&priv->ptp_lock, flags);
>> @@ -87,24 +87,24 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>>                ktime_t current_time_ns, basetime;
>>                u64 cycle_time;
>>
>> -             mutex_lock(&priv->plat->est->lock);
>> +             mutex_lock(&priv->est_lock);
>>                priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
>>                current_time_ns = timespec64_to_ktime(current_time);
>> -             time.tv_nsec = priv->plat->est->btr_reserve[0];
>> -             time.tv_sec = priv->plat->est->btr_reserve[1];
>> +             time.tv_nsec = priv->est->btr_reserve[0];
>> +             time.tv_sec = priv->est->btr_reserve[1];
>>                basetime = timespec64_to_ktime(time);
>> -             cycle_time = (u64)priv->plat->est->ctr[1] * NSEC_PER_SEC +
>> -                          priv->plat->est->ctr[0];
>> +             cycle_time = (u64)priv->est->ctr[1] * NSEC_PER_SEC +
>> +                          priv->est->ctr[0];
>>                time = stmmac_calc_tas_basetime(basetime,
>>                                                current_time_ns,
>>                                                cycle_time);
>>
>> -             priv->plat->est->btr[0] = (u32)time.tv_nsec;
>> -             priv->plat->est->btr[1] = (u32)time.tv_sec;
>> -             priv->plat->est->enable = true;
>> -             ret = stmmac_est_configure(priv, priv, priv->plat->est,
>> +             priv->est->btr[0] = (u32)time.tv_nsec;
>> +             priv->est->btr[1] = (u32)time.tv_sec;
>> +             priv->est->enable = true;
>> +             ret = stmmac_est_configure(priv, priv, priv->est,
>>                                           priv->plat->clk_ptp_rate);
>> -             mutex_unlock(&priv->plat->est->lock);
>> +             mutex_unlock(&priv->est_lock);
>>                if (ret)
>>                        netdev_err(priv->dev, "failed to configure EST\n");
>>        }
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
>> index cce00719937d..222540b55480 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
>> @@ -918,7 +918,6 @@ struct timespec64 stmmac_calc_tas_basetime(ktime_t old_base_time,
>>   static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
>>                                     struct tc_taprio_qopt_offload *qopt)
>>   {
>> -     struct plat_stmmacenet_data *plat = priv->plat;
>>        u32 num_tc = qopt->mqprio.qopt.num_tc;
>>        u32 offset, count, i, j;
>>
>> @@ -933,7 +932,7 @@ static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
>>                count = qopt->mqprio.qopt.count[i];
>>
>>                for (j = offset; j < offset + count; j++)
>> -                     plat->est->max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
>> +                     priv->est->max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
>>        }
>>   }
>>
>> @@ -941,7 +940,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>>                               struct tc_taprio_qopt_offload *qopt)
>>   {
>>        u32 size, wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
>> -     struct plat_stmmacenet_data *plat = priv->plat;
>>        struct timespec64 time, current_time, qopt_time;
>>        ktime_t current_time_ns;
>>        bool fpe = false;
>> @@ -998,23 +996,25 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>>        if (qopt->cycle_time_extension >= BIT(wid + 7))
>>                return -ERANGE;
>>
>> -     if (!plat->est) {
>> -             plat->est = devm_kzalloc(priv->device, sizeof(*plat->est),
>> +     if (!priv->est) {
>> +             priv->est = devm_kzalloc(priv->device, sizeof(*priv->est),
>>                                         GFP_KERNEL);
>> -             if (!plat->est)
>> +             if (!priv->est)
>>                        return -ENOMEM;
>>
>> -             mutex_init(&priv->plat->est->lock);
>> +             mutex_init(&priv->est_lock);
>>        } else {
>> -             memset(plat->est, 0, sizeof(*plat->est));
>> +             mutex_lock(&priv->est_lock);
>> +             memset(priv->est, 0, sizeof(*priv->est));
>> +             mutex_unlock(&priv->est_lock);
>>        }
>>
>>        size = qopt->num_entries;
>>
>> -     mutex_lock(&priv->plat->est->lock);
>> -     priv->plat->est->gcl_size = size;
>> -     priv->plat->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
>> -     mutex_unlock(&priv->plat->est->lock);
>> +     mutex_lock(&priv->est_lock);
>> +     priv->est->gcl_size = size;
>> +     priv->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
>> +     mutex_unlock(&priv->est_lock);
>>
>>        for (i = 0; i < size; i++) {
>>                s64 delta_ns = qopt->entries[i].interval;
>> @@ -1042,33 +1042,33 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>>                        return -EOPNOTSUPP;
>>                }
>>
>> -             priv->plat->est->gcl[i] = delta_ns | (gates << wid);
>> +             priv->est->gcl[i] = delta_ns | (gates << wid);
>>        }
>>
>> -     mutex_lock(&priv->plat->est->lock);
>> +     mutex_lock(&priv->est_lock);
>>        /* Adjust for real system time */
>>        priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
>>        current_time_ns = timespec64_to_ktime(current_time);
>>        time = stmmac_calc_tas_basetime(qopt->base_time, current_time_ns,
>>                                        qopt->cycle_time);
>>
>> -     priv->plat->est->btr[0] = (u32)time.tv_nsec;
>> -     priv->plat->est->btr[1] = (u32)time.tv_sec;
>> +     priv->est->btr[0] = (u32)time.tv_nsec;
>> +     priv->est->btr[1] = (u32)time.tv_sec;
>>
>>        qopt_time = ktime_to_timespec64(qopt->base_time);
>> -     priv->plat->est->btr_reserve[0] = (u32)qopt_time.tv_nsec;
>> -     priv->plat->est->btr_reserve[1] = (u32)qopt_time.tv_sec;
>> +     priv->est->btr_reserve[0] = (u32)qopt_time.tv_nsec;
>> +     priv->est->btr_reserve[1] = (u32)qopt_time.tv_sec;
>>
>>        ctr = qopt->cycle_time;
>> -     priv->plat->est->ctr[0] = do_div(ctr, NSEC_PER_SEC);
>> -     priv->plat->est->ctr[1] = (u32)ctr;
>> +     priv->est->ctr[0] = do_div(ctr, NSEC_PER_SEC);
>> +     priv->est->ctr[1] = (u32)ctr;
>>
>> -     priv->plat->est->ter = qopt->cycle_time_extension;
>> +     priv->est->ter = qopt->cycle_time_extension;
>>
>>        tc_taprio_map_maxsdu_txq(priv, qopt);
>>
>>        if (fpe && !priv->dma_cap.fpesel) {
>> -             mutex_unlock(&priv->plat->est->lock);
>> +             mutex_unlock(&priv->est_lock);
>>                return -EOPNOTSUPP;
>>        }
>>
>> @@ -1077,9 +1077,9 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>>         */
>>        priv->plat->fpe_cfg->enable = fpe;
>>
>> -     ret = stmmac_est_configure(priv, priv, priv->plat->est,
>> +     ret = stmmac_est_configure(priv, priv, priv->est,
>>                                   priv->plat->clk_ptp_rate);
>> -     mutex_unlock(&priv->plat->est->lock);
>> +     mutex_unlock(&priv->est_lock);
>>        if (ret) {
>>                netdev_err(priv->dev, "failed to configure EST\n");
>>                goto disable;
>> @@ -1095,17 +1095,17 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>>        return 0;
>>
>>   disable:
>> -     if (priv->plat->est) {
>> -             mutex_lock(&priv->plat->est->lock);
>> -             priv->plat->est->enable = false;
>> -             stmmac_est_configure(priv, priv, priv->plat->est,
>> +     if (priv->est) {
>> +             mutex_lock(&priv->est_lock);
>> +             priv->est->enable = false;
>> +             stmmac_est_configure(priv, priv, priv->est,
>>                                     priv->plat->clk_ptp_rate);
>>                /* Reset taprio status */
>>                for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
>>                        priv->xstats.max_sdu_txq_drop[i] = 0;
>>                        priv->xstats.mtl_est_txq_hlbf[i] = 0;
>>                }
>> -             mutex_unlock(&priv->plat->est->lock);
>> +             mutex_unlock(&priv->est_lock);
>>        }
>>
>>        priv->plat->fpe_cfg->enable = false;
>> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
>> index dfa1828cd756..8aa255485a35 100644
>> --- a/include/linux/stmmac.h
>> +++ b/include/linux/stmmac.h
>> @@ -117,7 +117,6 @@ struct stmmac_axi {
>>
>>   #define EST_GCL              1024
>>   struct stmmac_est {
>> -     struct mutex lock;
>>        int enable;
>>        u32 btr_reserve[2];
>>        u32 btr_offset[2];
>> @@ -246,7 +245,6 @@ struct plat_stmmacenet_data {
>>        struct fwnode_handle *port_node;
>>        struct device_node *mdio_node;
>>        struct stmmac_dma_cfg *dma_cfg;
>> -     struct stmmac_est *est;
>>        struct stmmac_fpe_cfg *fpe_cfg;
>>        struct stmmac_safety_feature_cfg *safety_feat_cfg;
>>        int clk_csr;
>> --
>> 2.25.1
>>

