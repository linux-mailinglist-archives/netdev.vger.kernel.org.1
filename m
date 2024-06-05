Return-Path: <netdev+bounces-100831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 592A58FC30D
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 07:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1216F2865AF
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 05:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562DF7FBDD;
	Wed,  5 Jun 2024 05:31:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A657347A;
	Wed,  5 Jun 2024 05:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717565504; cv=fail; b=Ie0EIkBWdfmWf2SSj+mjCc867pPY9xgmuZbt7b7jds65g+DLFUkKCKOMUJwb98kUKaT1TSNA/r/a2dnvAu3W0u6mARcps9eWxWYVlbbsGFyHudNKu47sNCNFJyb6ya3qzvWtDqUe/pfPwTuVg4V529TZZRxSb5Qgu0PZ+V4aF6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717565504; c=relaxed/simple;
	bh=TM8/bFYw1D3q4uOXz29OSfd79yHdTxFqanbPaOlaWuA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NxTJNv0nyuvGTuUryKGqYTLMj/BXtxfqyhDx2Yh6amRyz3ZtCMOUMahgBvDzkxAh2uo5rYEtfnAyjHqn9pneepYyWZGgfw0Yr4mElIHyqKZi1FUXcI9j9CC7l+nmzn0Fu/7K8KqSzQyVAXUjHsh7hA3mMCP5oA7qI867iCfe1Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4554e2Vu012003;
	Wed, 5 Jun 2024 05:30:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yftm7upa2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 05:30:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iguG/aNTAnU+mABGqg05ub1FRj8rdVtIb7ERNfGXuENDkrshtHPJe95nvuFRuVlZZ0WWQlbgeDD6NRnujmcaXTD005sj84C7Ul5SNXpwg0cwEiL+esHQYLAxqoeJd3+ALqb8StbCuS0vtaAW93XsuuXGb2azkJp77LiXvtuhulu7wr1cZeUQDZH6OFYTyEgep6VxZ3nsqNqqmNWU2RS8XF7kzJXRNQI93NR46/OcEey2f/FQtapW9H0SKYwsrUm66eQ1pszZ32ucZIE5ASJWARH7QBb0zVyG+fBpKd1UXrmhJCw1kd8QfpSIC8l5VxZkP46NgrfBGjVXwl/o5lndjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eD62/LWjIJD10eorWXF2AZLCGUKtbRT1G73Q3h2DbOA=;
 b=jPLGV17VjLtqb/0lFjnAmiGE7Br8N2TLCzfQ2UnJszMrChhC4ul8wppCSlluFRaJB8Sgdh5A+3I/J4auc1EyXXz5TwvUM8ygU6s74kl4cXZ+z2zVCTFl1r0/030NmP6w/cbVMqg4KVHLwD0ZdGNBdU5ObTEDnqQRvhhsgli0cW6f6Ed/yRzTJXeo/Bx9JPjP7FsYMI0SmMXaq7pX6H5MdnVYxyJ16Ne1Lk4zrWhLgQjo7VDP2BbgqNOC8SHXWdvYDYXvWk064Bi2f6HW7nlNJCoW8GmunAhiKufzClz+unlu8WlOh7ROFHlycrXNXuWEncBdARL+5Zcycqqf+Mr/+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by CY8PR11MB7012.namprd11.prod.outlook.com (2603:10b6:930:54::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Wed, 5 Jun
 2024 05:30:56 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 05:30:56 +0000
Message-ID: <b2243507-764f-4ab6-9ad7-c94076a18316@windriver.com>
Date: Wed, 5 Jun 2024 13:30:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [net v2 PATCH] net: stmmac: Update CBS parameters when speed
 changes after linking up
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
        linux@armlinux.org.uk, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, andrew@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <6c78b634-0e83-42dd-81ce-b36999a1b0ef@moroto.mountain>
Content-Language: en-US
From: xiaolei wang <xiaolei.wang@windriver.com>
In-Reply-To: <6c78b634-0e83-42dd-81ce-b36999a1b0ef@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0199.namprd05.prod.outlook.com
 (2603:10b6:a03:330::24) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|CY8PR11MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: f11739e3-bab6-400d-9ca7-08dc8520ac8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|366007|376005|1800799015|7416005|921011;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dVN3ck1RSnhKaU55aWRTVVk0bXgvZE96Smd4VnNLZUZuaEszVXh1clJVN1E5?=
 =?utf-8?B?WEZId2RCY1Y5cUd0ajJialcvZVhGU1JNeUZRb1Zyb2ZZeHdqRmlqaHBiQWdC?=
 =?utf-8?B?Q0wzSFRKbHcyYlJURWxrcFpyWXVud3V5RmRrYjlPMkJ0S09mK3BrU3U2K2s2?=
 =?utf-8?B?a3pCT3o0MUFobE80aGoyVy9MVWMzNEpSVkYzZVZSVVc3c3hHT3dDUjgxemRX?=
 =?utf-8?B?M21VSUJsL2xHL3FmTnp4K0xxVFJIY2VhWHhiQmJTTVhlWTVlanV0VXB1T1Ji?=
 =?utf-8?B?WXhrRUdtZ2lrcGk4RDIxUHlCOU9yK2xoaFBjUXp4MTd5Rk5ITkJBQklWZHlJ?=
 =?utf-8?B?YjJEaUNVaWxES0NHRnB0ZFJLak9LT0trUTNraEF6MjdocnVLL0xiT1ovSkJL?=
 =?utf-8?B?Z1ROa2pDclMwQVoxZWkzbENUUmRidlVCWDNmOWg4cUhud3RXT29MaVVwK1NO?=
 =?utf-8?B?SFF2ckVnTHRXMmtUTDR2Z1Urc0IvYTdSM2JtaC8rakRYczNiaXI4Q2xRNW51?=
 =?utf-8?B?MTdDdnQxSEU1RVZNUjV5bjBJV09UV2J3MmV1ZDlZRzYyNFp0bE9oOEZOdWxL?=
 =?utf-8?B?RkR4TGJyaVQxS2FTL0o5TEV5bys4QTIwcnFrNXBlWlI3QnFHZXpMNmhTRTha?=
 =?utf-8?B?dUZHUmVKSDUwN0c1QmJxM1AxWXY3cUpSY0JtNEdZbTU5eWplS3Y2V0RWYTBs?=
 =?utf-8?B?UllzQlQ5aStGQmhhU1JDazdZUk5TRWV5T0w5TnZlZFNnanBmRC82dmkvajQ3?=
 =?utf-8?B?MzVJNDdPYU40TlA4VmIzakFTNGY3NEJKNDJrNWF5d1E5ZzUwQTRwVEJPWFM3?=
 =?utf-8?B?TWQ2VFRYTUJkWGNCL1BrNXFtUXA5YnJaTmd1a3hVc09kNjFXSVJpbFhaNy80?=
 =?utf-8?B?SkZTZTVJWTArMUFJVmlSOWZKTWd0QnFXWUM1Lyt3SXFHQnE2WFNMUW5iUjNu?=
 =?utf-8?B?Q2ZSMHppL3pYV1M4dGNlOFZVS2YwMXpoWGF0WHgyamNkbVE4bElKclFzN0pW?=
 =?utf-8?B?UENUU09JdWgvNlc0NzB3ZDZqZmtRdTZmby9UcWlQck9lQjBySDBXZmRXWFlV?=
 =?utf-8?B?ZHhUUjJiWENOc1pBbmpFL0FLRXZueE03YUJWbjZ6WEJHRjRoSVFhc29FUDBJ?=
 =?utf-8?B?NU5WaFErRWpwWUtRWVdUSXNZYUlOdEdEWStQa2V4SDlhZUpIUHV0UldmVUZ4?=
 =?utf-8?B?SzA1dXJucjdBQmVMTGJPMGI0aGg4U2JJdGlsV1Ria1YxdFd0RW5XZnhmNXN0?=
 =?utf-8?B?akJrQXlvVGdrMnU1N2ZCd2FtZkhKK2t4WVlpUjVRc09KU3pIVVg5RXorMDE3?=
 =?utf-8?B?T1NxblpheThMcFZFcjUwYTM3NDFDZnArNjcxMjRjRnNybXpYL2FrVHZCbHJB?=
 =?utf-8?B?OThiWEhSdTNJZEhycCs2a0wvQUh1TTBjWGdZY2pNOWlLaWNOVWRJK3I0Uyt3?=
 =?utf-8?B?ejFJZlJ5RWpWRnBWQm0xdkxuVlFlL0RXc0JFRDUxR2xDSncvSWUwbEpvbTdJ?=
 =?utf-8?B?NFJoRDl2YVhrVDhIdTNBYkJ1Y00rQnVVRXlPYkV6VFV1dDBiOXZteXhkUElw?=
 =?utf-8?B?cEtaZ04valF2R1JGS2xSMVplQWk5dVhqRjgzRVc5bWRETGZHRUIrVmhaSkRh?=
 =?utf-8?B?RDZIcXhIVTFZcUxRVWpZcDBMUWdZa25HUXl5YTgvQUMvb1p4Vlh6OGV0WFI5?=
 =?utf-8?B?RGRSM005b0tHaGd1YnJXNmtENHZEajZENlpMU0FXaEZSeHNMWjFuZXFnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZUtKbVluRS9QVEpBT2dpZlY1Z0ZnTDJpdjJpdVQ3ZVh2K20vQmRsSkJRTWtG?=
 =?utf-8?B?YTRXcDR5Y2JxNTN6enorNGxEYVF1RW85TndQTXV2V0l3cnNKSVl0ODF2TEZJ?=
 =?utf-8?B?QTd2a0h1VWRkRkRuaGJaWXJrQzI5VzNPUi9kSWhCbjl3aG1aVGdDUlN2Umxt?=
 =?utf-8?B?VHVpdGgyUjU2ZHpJWEJCSDkwcG1JVDYvdllOcVM4amRFNWhoNzdhejNtTkEz?=
 =?utf-8?B?aGZLYTk3VlFtRG5ESHZxVWdxTk1DQjBYS0VwUEtPSzdHNm8rN3pqSzZuQk9E?=
 =?utf-8?B?ODN2VHhzQVcxeHpLRHFkSElucEFYRUpEQXFTdlMweHh0QnY3M2dablZTcmVO?=
 =?utf-8?B?dmVNalBmZEc0YVEyamNNRWx0NmVrTmthZUpaUnM4QVcxNGVVUVJqbDF5SkJx?=
 =?utf-8?B?UkkzWEI2ZlNWWmp5VUs4cStIMUxUQnFXZEcxc2ZYVXFHWWc0RW4yYWM2amdl?=
 =?utf-8?B?QWwrTzNwMEJwbldQVGlkRVFzZmZUMlZYODFXY2toMjVJRVA1WS9TeEF2Q2tL?=
 =?utf-8?B?QmVqTVRXNmRHZE9oL2kvTW1YeXlScXc5cG91TzBrNWYyUTlZbzErdnQ2Z2RF?=
 =?utf-8?B?VUc4Z3lzTXNTUlBvMTkyWG91VmZ6VE9TczVyWXhpNUd4VFpqMHVHOGQxTHZi?=
 =?utf-8?B?S0dSbnVjekVLa3Z5RDg5dUxWTUc5NVJNanQ1QzZEUE9Zd3VMQnFGRW1MZGkx?=
 =?utf-8?B?Q1BzSWRrQk1jRDl0UTBmSWVFdTlIbkNQV0hVb0xmbzFqTWY0Yi80QzNGcWQz?=
 =?utf-8?B?WGFuWk9PUEZYZ2d6eGRLeGh1K3h3MS9QeExwS1BJbEFva05SaDI5TGdPZ3FS?=
 =?utf-8?B?b1N3OHcwNmVRTDBhTzNuUU1mWmxLSkovQjhaK1dDa1VEUFVTSGFuL3MvbS9U?=
 =?utf-8?B?UGNqbnZTOFkwRVdZbVI0RXRXQnVqUHZKd1JSbnBhSVIxNWNXRityeks2MkVu?=
 =?utf-8?B?TVdFVkNUL1VhZW95bVZidlZwNGRneDk0RGl6M0lQOFFLaG9reklCY2g1UlR5?=
 =?utf-8?B?NVBhN2RMd0ZQNUhJZmZIU1BxRlh5Ym8rWW5RQUR4TVZ1Rk81UmpMTVZLa3RX?=
 =?utf-8?B?S0V6QXZHM2FWUng5S0RhK1oyUlZEN0pRUTN3YW55RVE4TU14Q3R2cG5BenN6?=
 =?utf-8?B?SEllaFBBUTdzdjVNam1xMU9pUS9QLzRPZVIyTTBRVTc0dysrSGNvZlVrelpI?=
 =?utf-8?B?aEhBNWh2S3Y4cFN2bnpoQ3p0bGEyUHN4YXpQK1prSzZGTTJEaUc1dXVrTkdq?=
 =?utf-8?B?b3NCL091K0xtWEMwMjd2aytqSmZBRGhvdlRQTDVVRFZFZk5rMlN2T3d0cTUr?=
 =?utf-8?B?Q3FJVXN0cUMxZUlybGNQWFJaTjMzUEtuL21TVmJPU2kyQUxZZ2VMd21jUDls?=
 =?utf-8?B?UVREQnBPa3JxUUdPdnZYTHhGaTlTUWg1YXZKZDZXUmxjaUppYzlBKzZtWkdV?=
 =?utf-8?B?aFY5dTF6ZGR5Y1NhTVZPaHl1bEZhSG9CYjdlaEszRXVWa0FTemh0bHRTVFZ2?=
 =?utf-8?B?blFZaUdWaytuc2NoYVN3L3d1Sy9QUjR2cGhnbS9ZN3VtODZQeUNWaGRzRHVn?=
 =?utf-8?B?VjMwa04rNHBuVTJNSDAwUjNYRjQreDNKamtJQ041UzFMaG1rRU1ENVU0TDBu?=
 =?utf-8?B?cnNkWGhDV1QzRTFTZm10dzBSZE1CR0Y5MFVkWE83cm43TnZ4YWg3YUN0eExP?=
 =?utf-8?B?YVNKVHpXSEdVZE56QmhmVmxjb1loTm4ySU91QUo0cUNlVEJuVi8vZm4wVnE5?=
 =?utf-8?B?QmZhRGNNSE0vMGIydEFnM0pTNHh3a1V6UDRuejVNam9neUQxN05jK3I4KzUw?=
 =?utf-8?B?YTd5RWs4TVhlLzI3WVRudTdTRHZaaGV5YlljSXBucFI1dWk0NFNLTXJDTTJt?=
 =?utf-8?B?Wkw3WjVDN1BUQmwxaFIveHlwQWNPaTBaVnRaaGJ2dm1ucnkwa1YzWFprTy9v?=
 =?utf-8?B?RXZvQzBXaG1IK2U1UHhFbWlzWmthK08xZGRyRkRqYUs1OURvTmlWejVGRjFq?=
 =?utf-8?B?U0d2WndhaXVhOStWRGpGM0NGSzE3VCszSnh4NzZCMWdzWDd2a3RCb1h0R25t?=
 =?utf-8?B?RjRsOGY4NDFOdlNnL0xyR0ZCaEQ4aUtOc1QySFZoQVdOM25KdmE0UlBGRk5l?=
 =?utf-8?B?QmdMOFc0ZHg1Zk9nME1ZdlpOeS9GOFd4U3dENENVY1BhNnZxMHQyNCs3MzVI?=
 =?utf-8?B?a0E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11739e3-bab6-400d-9ca7-08dc8520ac8a
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 05:30:56.0981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AfGN/dhILIOLsV2r2v3DHN5QqIyozMv13Q2uWzBMvcC0S5LBlwyeTSh4iSYipi/iS61eMId5wcEUkGX4rLMKCvQCt/dl+mWBzx8+7pNwfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7012
X-Proofpoint-GUID: aPxCNzWQhwhEWO0qqTkLh4VTOdUJj8hE
X-Proofpoint-ORIG-GUID: aPxCNzWQhwhEWO0qqTkLh4VTOdUJj8hE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2405170001 definitions=main-2406050040


On 6/5/24 13:26, Dan Carpenter wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> Hi Xiaolei,
>
> kernel test robot noticed the following build warnings:

Please drop this patch as there are still some questions on this issue

thanks

xiaolei

>
> url:    https://github.com/intel-lab-lkp/linux/commits/Xiaolei-Wang/net-stmmac-Update-CBS-parameters-when-speed-changes-after-linking-up/20240530-141843
> base:   net/main
> patch link:    https://lore.kernel.org/r/20240530061453.561708-1-xiaolei.wang%40windriver.com
> patch subject: [net v2 PATCH] net: stmmac: Update CBS parameters when speed changes after linking up
> config: i386-randconfig-141-20240604 (https://download.01.org/0day-ci/archive/20240605/202406050318.jsyBFsxx-lkp@intel.com/config)
> compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202406050318.jsyBFsxx-lkp@intel.com/
>
> New smatch warnings:
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:3234 stmmac_configure_cbs() error: uninitialized symbol 'ptr'.
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:3234 stmmac_configure_cbs() error: uninitialized symbol 'speed_div'.
>
> vim +/ptr +3234 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>
> 19d9187317979c Joao Pinto   2017-03-10  3194  static void stmmac_configure_cbs(struct stmmac_priv *priv)
> 19d9187317979c Joao Pinto   2017-03-10  3195  {
> 19d9187317979c Joao Pinto   2017-03-10  3196    u32 tx_queues_count = priv->plat->tx_queues_to_use;
> 19d9187317979c Joao Pinto   2017-03-10  3197    u32 mode_to_use;
> 19d9187317979c Joao Pinto   2017-03-10  3198    u32 queue;
> 882212f550d669 Xiaolei Wang 2024-05-30  3199    u32 ptr, speed_div;
> 882212f550d669 Xiaolei Wang 2024-05-30  3200    u64 value;
> 882212f550d669 Xiaolei Wang 2024-05-30  3201
> 882212f550d669 Xiaolei Wang 2024-05-30  3202    /* Port Transmit Rate and Speed Divider */
> 882212f550d669 Xiaolei Wang 2024-05-30  3203    switch (priv->speed) {
> 882212f550d669 Xiaolei Wang 2024-05-30  3204    case SPEED_10000:
> 882212f550d669 Xiaolei Wang 2024-05-30  3205            ptr = 32;
> 882212f550d669 Xiaolei Wang 2024-05-30  3206            speed_div = 10000000;
> 882212f550d669 Xiaolei Wang 2024-05-30  3207            break;
> 882212f550d669 Xiaolei Wang 2024-05-30  3208    case SPEED_5000:
> 882212f550d669 Xiaolei Wang 2024-05-30  3209            ptr = 32;
> 882212f550d669 Xiaolei Wang 2024-05-30  3210            speed_div = 5000000;
> 882212f550d669 Xiaolei Wang 2024-05-30  3211            break;
> 882212f550d669 Xiaolei Wang 2024-05-30  3212    case SPEED_2500:
> 882212f550d669 Xiaolei Wang 2024-05-30  3213            ptr = 8;
> 882212f550d669 Xiaolei Wang 2024-05-30  3214            speed_div = 2500000;
> 882212f550d669 Xiaolei Wang 2024-05-30  3215            break;
> 882212f550d669 Xiaolei Wang 2024-05-30  3216    case SPEED_1000:
> 882212f550d669 Xiaolei Wang 2024-05-30  3217            ptr = 8;
> 882212f550d669 Xiaolei Wang 2024-05-30  3218            speed_div = 1000000;
> 882212f550d669 Xiaolei Wang 2024-05-30  3219            break;
> 882212f550d669 Xiaolei Wang 2024-05-30  3220    case SPEED_100:
> 882212f550d669 Xiaolei Wang 2024-05-30  3221            ptr = 4;
> 882212f550d669 Xiaolei Wang 2024-05-30  3222            speed_div = 100000;
> 882212f550d669 Xiaolei Wang 2024-05-30  3223            break;
> 882212f550d669 Xiaolei Wang 2024-05-30  3224    default:
> 882212f550d669 Xiaolei Wang 2024-05-30  3225            netdev_dbg(priv->dev, "link speed is not known\n");
>
> return;?
>
> 882212f550d669 Xiaolei Wang 2024-05-30  3226    }
> 19d9187317979c Joao Pinto   2017-03-10  3227
> 44781fef137896 Joao Pinto   2017-03-31  3228    /* queue 0 is reserved for legacy traffic */
> 44781fef137896 Joao Pinto   2017-03-31  3229    for (queue = 1; queue < tx_queues_count; queue++) {
> 19d9187317979c Joao Pinto   2017-03-10  3230            mode_to_use = priv->plat->tx_queues_cfg[queue].mode_to_use;
> 19d9187317979c Joao Pinto   2017-03-10  3231            if (mode_to_use == MTL_QUEUE_DCB)
> 19d9187317979c Joao Pinto   2017-03-10  3232                    continue;
> 19d9187317979c Joao Pinto   2017-03-10  3233
> 882212f550d669 Xiaolei Wang 2024-05-30 @3234            value = div_s64(priv->old_idleslope[queue] * 1024ll * ptr, speed_div);
>                                                                                                                ^^^  ^^^^^^^^^^
> Uninitialized.
>
> 882212f550d669 Xiaolei Wang 2024-05-30  3235            priv->plat->tx_queues_cfg[queue].idle_slope = value & GENMASK(31, 0);
> 882212f550d669 Xiaolei Wang 2024-05-30  3236
> 882212f550d669 Xiaolei Wang 2024-05-30  3237            value = div_s64(-priv->old_sendslope[queue] * 1024ll * ptr, speed_div);
> 882212f550d669 Xiaolei Wang 2024-05-30  3238            priv->plat->tx_queues_cfg[queue].send_slope = value & GENMASK(31, 0);
> 882212f550d669 Xiaolei Wang 2024-05-30  3239
> c10d4c82a5c84c Jose Abreu   2018-04-16  3240            stmmac_config_cbs(priv, priv->hw,
> 19d9187317979c Joao Pinto   2017-03-10  3241                            priv->plat->tx_queues_cfg[queue].send_slope,
> 19d9187317979c Joao Pinto   2017-03-10  3242                            priv->plat->tx_queues_cfg[queue].idle_slope,
> 19d9187317979c Joao Pinto   2017-03-10  3243                            priv->plat->tx_queues_cfg[queue].high_credit,
> 19d9187317979c Joao Pinto   2017-03-10  3244                            priv->plat->tx_queues_cfg[queue].low_credit,
> 19d9187317979c Joao Pinto   2017-03-10  3245                            queue);
> 19d9187317979c Joao Pinto   2017-03-10  3246    }
> 19d9187317979c Joao Pinto   2017-03-10  3247  }
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

