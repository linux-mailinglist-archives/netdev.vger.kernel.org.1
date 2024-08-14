Return-Path: <netdev+bounces-118308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9871395132E
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 05:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0345284A13
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 03:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382F03BB59;
	Wed, 14 Aug 2024 03:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZmPe6PI6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fe6HJW+d"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D58B3BB48
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 03:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723606822; cv=fail; b=rPcr45t+zkWZoDFkW41TKoxP4WiUclbC9Mbo12Uv4qQx3d/CCAihmU3Y4XDM4Y18NFEd/iBbpYCXIX83L1JjH7hpONBNwOndGMkVW1lsYsCSfZjHtWxbVSFIl7sYbQoJhzTVOLouo/youC4bD22WvgXNAvnALmu7koZnoLdD/MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723606822; c=relaxed/simple;
	bh=ABhYF0eXJxoLB+wtzQolLgskN5VYAi9hP+jCbrI8u5c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sO+9uDkrK1UHbcmq60GHeGaBgL9W3ejizKyr/q8Ia6o7ZD17w++PhTztgLe6QZye/UG+5pFo3oR/UZgFqrxdtshD5FJfbniF/6cS5XmOqdxclV/9Y2kHY/IWsrsR0xx+tdt4/3b7DmMDzjVCzWQUSo2fnpMSRFGkeIRdtXT3dm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZmPe6PI6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fe6HJW+d; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DN980S007439;
	Wed, 14 Aug 2024 03:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=VLhyz+q1Mo1iluqIehwKLp9Hb0iK5UOITOB0EkeDZAk=; b=
	ZmPe6PI6PDY6bfO4xd3G/0FnexhlWu6nLo8rP8DZLFoJwr2G4/zh2/CtkrDfwxxT
	5/yhXwqJ+UFf5sexCBJ0WQLXeehnptxeeTgFm4CUkPrIWK/2ZbdmpdHed3WCgTsr
	MJhBZa1NgAATb18oq6nbWZ8xG9HeN3F8JvbA5oueYVLuUMC78Tfw855jQWTdHyqi
	Kg1zsOhTpc+vgaWIwGT4genTSkLvdcDpJoX4E76+ZYzlUhY6R+8Yndiiju27nHS+
	/CfpqGhZZFNBnavgB0XB9IO2HymCH1SdDxnHs3hTkqZ7DAzbgBkf5Mm2BK2JNQVA
	OCOhbcOXbq+0k+tsC1THgA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wxmcyaad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 03:40:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47E3DTgP010740;
	Wed, 14 Aug 2024 03:40:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn9cyr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 03:40:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CO6fL+h8ms4AMFPPWt8iCC1uqATrK1NvAgcihNfRo1VComJQ5cv7KsYC0b4l2XCnMzPlQwOcOrV99hwKiiqn8KBrjUZoYEPopA5mDZSAZsCfLbSz6KEPBGqS7QC9YIXkCzlkCIp1LAZFGYno2a4bO2MQsFac95As6Ui2JdkSlC03rHHUqqZGzFltF4aU5QPp/HqL6pLxvfUQ6jEsmx37nNwXI0cpeMUnTdyhjnUya8RUQnwR9R2NeZEsJSrBSQO3+X3yFcWmz1GzON/O/cAk4DvY773lFTZgqC3XGX8ym6gA2KvcWS99LCew7ix2LyH2ZzugUxLYPLRWn8K8OvbSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLhyz+q1Mo1iluqIehwKLp9Hb0iK5UOITOB0EkeDZAk=;
 b=Sfn0iSvWboPHFg5/Xveh/QVeoF1v3Y3pdsP07XV/rZWbmMPZS45TUEZuKCqPB6jtSnMoMHlj9GiwbvrMnMurTCI+O9DSzNkD40g1ULb/NOfWi971azO50ODCwCvCgdpAGJsVNcbQd3hFU0ARzEY5Vur9ynYSfUhTIs+25FsSNCHi7z9bcBL6Om7cH0ocAC8L7SpZtdxgN+L7nOEHMGKbL4Qn/YsvmDRGCApSBBauGcnHVmTSLZgLkK2xOiq1zRcfv3/DNL2NCaYVkp+Z3aR0hYm3sqL3J4pgstaQO0k3lkjc9Yg2VeJ6BOzaG00sEuZKeNAisxBIgRVJulJnK7dnLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLhyz+q1Mo1iluqIehwKLp9Hb0iK5UOITOB0EkeDZAk=;
 b=fe6HJW+dcPOrRhSmF2nTv6V1lSUXoOuA2WCCR89+8ffFSuDXKs+tYaip7yYzP6+4oRrzfa0kvZH5+fbfW1ZNSZL3VV8kFOYg5uLgYNE/GcP4DIVhcH5IyKkPuWPvaHGLdeEnqSloV9uEwhnk1d4lQmCB2YR/Fk3f5uEO1/l4cwA=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH3PR10MB7764.namprd10.prod.outlook.com (2603:10b6:610:1ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Wed, 14 Aug
 2024 03:39:59 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86%3]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 03:39:59 +0000
Message-ID: <3a6bc28d-dc53-430f-b308-b639276bdc39@oracle.com>
Date: Tue, 13 Aug 2024 20:39:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/4] virtio_ring: enable premapped mode
 whatever use_dma_api
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        virtualization@lists.linux.dev, Darren Kenny <darren.kenny@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>
 <20240511031404.30903-2-xuanzhuo@linux.alibaba.com>
 <8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com>
 <20240813154458-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240813154458-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR12CA0020.namprd12.prod.outlook.com
 (2603:10b6:208:a8::33) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH3PR10MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 96b10b60-b6d0-4e03-84e6-08dcbc12c59d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlQwWmt0bTBZaU1YZXArS2NOMDM5djNRcjY5UFpvK0ZTKzRmY0VXSFAwemdn?=
 =?utf-8?B?ZzdYSzFXdGc1WTRER2tUVCtHR3hJRDk3TU4wVlJJa2ovSDBYTXl0djE1WXFJ?=
 =?utf-8?B?eFZKWEk4akJLd0p6dUJvZWpyMWxlNUdDNEd3Z25rUTduSWhzS0RHQ2NCdEpW?=
 =?utf-8?B?bld6TW01d1Z4Q2dxcXozaVpWOXNXMDY0TXVhaHFMNzlsWGZrN296U2N3YWtW?=
 =?utf-8?B?WDcvT0tsNDBqOGdLT2ZGN1RPNGdWbGlxUHptTHJvcklwWUF2T3k0RmlRMk14?=
 =?utf-8?B?bDk3Y3BKM3Y4RGhJUFNPcitqWjF2UXZRNzR4Ny9BMEJyNHJCVWxyQmxUQk51?=
 =?utf-8?B?Y0FEUTN4SzlVUy9RWFhyb0Y0TE5zd3FGcW5zV1JQNEhUZ2pUOTNwdFBhaTdS?=
 =?utf-8?B?R3pZOXJMejFucmx1d2Rob2l2WUVzaDdwMjNFdENmVDAzSmNmSzhmSFRUN3o4?=
 =?utf-8?B?SFFacG5EeUdLa2o2R05xdGVrcU9xSWJFcTF5NnFFZDEzRDNodjBRcnNxTFEw?=
 =?utf-8?B?RkUvQ2ErVmtlTWlUd0RzTUhqdmRvTnlGNVhRdlJ2cGR0M2VJMnh4K0dTZXlz?=
 =?utf-8?B?R21ZcloyNTRTUkJBTzdQOXJnai85S0p2ZEdyY25OaGpaSHFvM081MFpKREZQ?=
 =?utf-8?B?ZGM3a2JhdllVMEt6aGZkcFZ5MkQ1TWtpMXVHR1dveTB5VlpLaHByQThNL2R0?=
 =?utf-8?B?QTlGZkFDYnVldHkyY3JwT04xVHEvN2NVd0hZSzZoN3A2d1h1MzgwdlR0QmJN?=
 =?utf-8?B?eHBvbngreTJFUTNpYXpJZkl0LzdOUzNMVTJJQmdIVkJ3dHZhU0RRbnRSNEpv?=
 =?utf-8?B?djE0akZMV2JYSE9WZ21TNFlGb09jSGF0K3JBWWR4ajF0MGNqVG1mdnlzcWhE?=
 =?utf-8?B?aW9pQmlkb08xUkJ4UCtqZzB0TVpKOERCY3QvU3hUYVd5OUJOYkxCTksySnZv?=
 =?utf-8?B?VVFMVUNGYjBGSzJzOCtLcFhRU2ZFWjBReDc0NkZCa2lsRkVBUzErTWJsRndv?=
 =?utf-8?B?Qm1ranV4bVVRdzQ0clNZWk9CR1RGbHdDbnFwNk1sV0NDd1VxWmJtQndyMm9Z?=
 =?utf-8?B?UVUxRXNDbnhTcEtralZLcnZFMndsR1o3NWk4WUtROEtFaXpLSlI1YU05WXB0?=
 =?utf-8?B?YVhrR2NBdDI0WVB3Nkp3b2xHNGtycnRwRDkvNjNwQTBlbHRrWDg4UDZEMlFo?=
 =?utf-8?B?TkQ5ekpBUzRTNG1QWVZFaUlJZ3o2NnBCYlhLelg3eS83NXlSclN2bXpGd0Uw?=
 =?utf-8?B?bnRiY0hSVlBQeS9pMUtBeHRaTkhQdHJSUmk5bkd1N1NPaWkyOVRxRmE2MHEv?=
 =?utf-8?B?c1V4cmppU1RjamowbnZkZHNrcEdtcFFMNU5NVzBPVjB3eGNydzNJeHBINHUv?=
 =?utf-8?B?OU1neWlGZFlKc2o3WWJmQWpMVVdWNWlrandKeTBvSkFHSTVEdWxqOTlTYmg1?=
 =?utf-8?B?N3BsdmxVV0JxeGNIQ1dGSTV1S1pGT1I0eHlCQjArWkFOOGt5cXNFczRVZngx?=
 =?utf-8?B?cTVjQjJ2ZDZuWUFXK3hIU2c2d3JHZHlaRUtUQjAzSGV6MmNtRCtiTWlJUlpQ?=
 =?utf-8?B?MFczVWVXRTd4cjlkcit0ZlJYc3lXOXphOXBFV0dsNXNkMnUxZjc2VzVBUlhN?=
 =?utf-8?B?WjJTT0tNWDhjOHdEYjVkTUZwbUFpQ1ZuandGekdnOFQxYzg3S3dZdjFMdE9i?=
 =?utf-8?B?dEZGcWV6Tm5zMFV2QXJGUWN2OFJXRHdMYlJTNS9MekhGbmxvWjl4cHNRUGti?=
 =?utf-8?B?V0dma1hHMEk2NHN2L2ZpdDhaNk10Y1pmUEl2cEw0N3B2bjVXUldmbUovVjYy?=
 =?utf-8?B?L0JPVGhwMThaK1NLcXBaQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUlrenp1d3JjdVRDK2ZROTl2dmFBQk92aFhOSDgvZXpZRENPYnJiV1kzR3BK?=
 =?utf-8?B?T2hkMksrbHdjejJ0K0xxTUwwc25sYUM1RzNLYm4vSjhuaGJaL3FLR0ZsbENF?=
 =?utf-8?B?SmdzWWFWb1hVU1ZnY3V0Q2REcVpJM2Q5dzRhQ3lEdzVsZW9LVnVuOUpUL093?=
 =?utf-8?B?NWcyV3pLTVYyTVlrTHEwL29ySGhpZksrckVLTDc2cE1Qb1EzdTJuTE4rdGJr?=
 =?utf-8?B?RGY3aFZLYmV2Tm9KcG1FNkZGSUU2L0hEelY0b0w3d3lkSVpxRlQxZ1M2OXJN?=
 =?utf-8?B?L012VXNZRHhLQWtDcTdSRWd1RE1MK2FlaERsS1ZXdmJlM3RNbm14ZVJDcmhR?=
 =?utf-8?B?RTFMd0NCRVlMZW92MTNIWDNKTjExejk1bkdBbC9XeTg4cVVZam02a2lTbGRw?=
 =?utf-8?B?eHBYaGhzcnQydGo0SVpOdDI0aG8vWUxoaDVHa3BCWFc4N0FqSGlpNzlnNXZQ?=
 =?utf-8?B?N2tuR2dQeS9KYU81c09rODhVaUpGZEVWdlZVb0ludnNrVEdWNm85SWZ4a0JB?=
 =?utf-8?B?bUhhQnRTKzZFL3ZJa2EwL3ZaVVZvS1lkNmNzMU1KK2w1TTM5R05SS2NSMlUx?=
 =?utf-8?B?NnZ4eVp0L1BCMk9uZ0tELzBMelFRUzFkRC9yODRsUnhRVVdYdFVteDZXV1FZ?=
 =?utf-8?B?cEdBZU83YXk4SDBNQ0FHTDRndmdKZGcrRWhDc1Fld0trT2wyT1pFVnlxaTNo?=
 =?utf-8?B?dGdQTGpqT1hwNExKS3ZiakE3RTlCcncwUXd6SWozSWFwUHN5cG5PSUlPK084?=
 =?utf-8?B?QW5UQ3FoM1pJS1RRd01VblRhdlpURmYyOENkYzQzWDNUcWZCQll0TmVUWDJS?=
 =?utf-8?B?UUl4Y2VUVklGbHhJWHpmckN2Z0w4Q3lqNU1GRWtOYjZiQTNxR1NwekJPWjdk?=
 =?utf-8?B?cis1TG9zYnZGV1ZqSTVnaWVBdmNpbFk3ZEhxUDJYTjBNWXloMzhEUC8yOEhC?=
 =?utf-8?B?M0I4R3lWTU9MdTgzWEJYdzFrS3IyL3ZDNWc5ZVlPVUVSZVRvdENuMVhPMUtx?=
 =?utf-8?B?Y2xDYmJ4eW5QenZGdjBiUzltYXhTem1FUm84cE9mamFIMTlsTTJUWFZFZUIv?=
 =?utf-8?B?K0Q2VXo2MVhxL2daQ1NvdTdDRTVPUkltNkhyZCtJc1RDZGZ2QWdxcW1DQW11?=
 =?utf-8?B?S1FZZENlNmlwNVR6QlQ4NFJTWklrUStySWZCRjVtRGhJbjNGTm1UalVZWlgv?=
 =?utf-8?B?Kzk1L0F0QzJuWnBMVnl6WE12djFSWHQ3Sko0YVdTaVAvT2FveHJ5RmFITXFN?=
 =?utf-8?B?L1BSSnJTbTdpelhEMkVIMzhOUmhsbEVHTDFIT251Rkc5czZhWDNBeXJZNEJN?=
 =?utf-8?B?VmRJejV2cVlWdlJoWFl4QzVaRUlIV1JtamxUdW8wM05pVjRyREpRUTNld1E5?=
 =?utf-8?B?T24yTGVNUjQvNkYrU29YM0w0ZjBnOHRGeUFubGRkMkt2QW1ycnh3N0Fjd2xK?=
 =?utf-8?B?Z1M1TFdkUmRQdTgwZkUzSFRSVDNpbUIwVk9kYTFtS0lUalpJVm9XSlVoa2ly?=
 =?utf-8?B?bFBsNzNxTTFFVU9wTURCMnk5NjNTWDBBZExBSktNREJOVUpEQkJBWlBVUi9x?=
 =?utf-8?B?REJ5dmdZWVUzdlhvcEdPNnVBT3N0ZjVRZ3lUUktkYmVNZG1iam12cEw4L0pH?=
 =?utf-8?B?ZUhSamxxSzRPOFRFYVhRajhSZ2VtenNuUjh0ZDFwVExydFg1SXlRa0NvbmU2?=
 =?utf-8?B?WW1ReWYrZ2w4aS8zUWVDUGZ6REw3NHRySHpENGREOUNqTlhrd005REgyNmlx?=
 =?utf-8?B?c3NCVC81a2NyT1ZzazdDMUtqUWk0emlnbnRTai8yUjlHSXlxUTkxRjBoN3Mz?=
 =?utf-8?B?VWJGWTJMUXlnSXFBMERSb3lJYzJIVmVwMkJKMUovU0xiblgxTlZvZUJYeHBq?=
 =?utf-8?B?enl0bkZrYzl3bXZBTE9idHc3SWRvTUJCQUFrZUVpRjVYK25jQ2ZDREpjMFFQ?=
 =?utf-8?B?VStKU1ZCeWp2Nzg2K1A2K24xUDQvRnBSWHJsaXl5N2RqNk0zeGdOcGVMS2F2?=
 =?utf-8?B?SFBobGVDR2kydmo2aktkQXZWWVh1WG9PYnhBMVpPNlFJSzFnbG5tWHRjR2RN?=
 =?utf-8?B?aHpsTnZvRUh4MzN5ZHVOYkVTaTVuU3liWWFHMW12S09iSE8vcGVjbDBHRHhu?=
 =?utf-8?Q?BISThUbxl4Z96Ikwn6UaGZKHq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o+7NFiW84OVdVshHFrXKzkO07J7f9NZez34uwTYUZsBmjFUx7iqmqigPAceRqrQURkP/Oh2Tazr3ildJNUt5sG/HFdZRBSV2cpZHk+VoFuKoQ6jZvzKfZGf0j+h2RRCisIeU8zezsWdu7v/mYnFCIdEAVtX22JIG7Tt44kCN8VKQx2YCoc5dW/zwgKklsjanuSOo/eLN2Q21CyxSqIXESBtPND0rx6oKsMpMi4tXx/KtM6LS7DX2aYQUMHEE4D3W93RsPSHJwARZmKENwyttz6DL9KN0It0jDlbxFhlLbQMS5gKD5oMKf/NHjXuVYiA7a2KurO8Sso+m63zat1ppHPwgvoGgKxqQHnXiS3ABR+y0ZSyU8uqv/6V+JNcVYpil3VUUHF6YZcx3Ns0j/ZbtGik6V55ZsmdvbJ30qB/hQPNc2jI8ziapm2Vv8Ot37BKA8T2UuWkg4KPaCU5AjhunUGUpbXzwHizrT4ZfLSzuFVnykUf7bSsRsaCaVrgGyu2NALoWLg4mZrYpts2N7Um+iUxSLChSbVAftTFJuG872PIcds2QX/X4uWHk07MU05/Fo82SnVqBNkK3AyVyBCHbzEk7gJD796YwDUeJ1ZcBA4o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b10b60-b6d0-4e03-84e6-08dcbc12c59d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 03:39:59.2046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3P/i5kyqysDmvVzZAXwxnwa9sS9CHh8DA0FL3Yt70n/BSAUYylaXysUov1al5k3pS0HX+/HoqIA4XynEtt9lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7764
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_02,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408140025
X-Proofpoint-ORIG-GUID: RgWOK26szbPzrEejlBN9PLcxA6Zc-xMJ
X-Proofpoint-GUID: RgWOK26szbPzrEejlBN9PLcxA6Zc-xMJ

Hi Michael,

I'll look for someone else from Oracle to help you on this, as the 
relevant team already did verify internally that reverting all 4 patches 
from this series could help address the regression. Just reverting one 
single commit won't help.

   9719f039d328 virtio_net: remove the misleading comment
   defd28aa5acb virtio_net: rx remove premapped failover code
   a377ae542d8d virtio_net: big mode skip the unmap check
   f9dac92ba908 virtio_ring: enable premapped mode whatever use_dma_api

In case I fail to get someone to help, could you work with Darren 
(cc'ed) directly? He could reach out to the corresponding team in Oracle 
to help with testing.

Thanks,
-Siwei


On 8/13/2024 12:46 PM, Michael S. Tsirkin wrote:
> Want to post a patchset to revert?
>

