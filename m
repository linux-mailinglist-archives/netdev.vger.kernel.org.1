Return-Path: <netdev+bounces-266931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WE0ZMgFlsmntMAAAu9opvQ
	(envelope-from <netdev+bounces-266931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 08:02:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F29226E23F
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 08:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35B8A301E98C
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 07:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF973AB283;
	Thu, 12 Mar 2026 07:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pfalNs/9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UjAuDNzS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413922D8773;
	Thu, 12 Mar 2026 07:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773298941; cv=fail; b=IT8MlDdhRDg5TPl2+jmxDuBHGeaMzNt0IIxIvImBhOfqekOPF/Y0HKn2hdz8eLrVi380w8hkmZl+C1QzknvBelBz6jP6KPhXtj3UmvcciLTkQxYKiKQsYnOBsla+EyRnqTn2V6PBJ8/N0lb2VOYSSfC+WDd7UH/Y1dtWPwND+Z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773298941; c=relaxed/simple;
	bh=dYYd3BqWzCfzXI8w+iDpDEJnPlDlNasTRpvW3m6fqes=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pf0XIUbiq0JpR+tQYvIIGhgNBvPmNZ5y1FnVQcr2tx/26c90Mtow7Q6+jGEiro6efAcp+LXhU/inDcv8EfdWMMn082cZIVUWv/Ekx2uXbCUbyb9k09/3VN8FwY5eyEFs13Nf+zrgGAOPEVwDmvL50PrT0o4j+gLYz8gCvQz/8O0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pfalNs/9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UjAuDNzS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C2dcm7107659;
	Thu, 12 Mar 2026 07:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=iccEkeBoI1+vQRHHrIq5FQUgQ3Y8oCahy2F6vZmXe3w=; b=
	pfalNs/9VzIVaGt+QdpJ4OHN3NdZ2iqBRwlTAY8m2qtmoCqAmTpDihzwNaTa1aze
	4zCBY7rl6KTD7QhsZPMpNT/hjNC5+PkmNJVk1IRvJf88iryeg7Ip0QUAfLvlZ1nb
	mTHqkFlSXQ9ZKRzPyyMr9clFrrv2Jvo2ajSOY+IDGhLChLTyeDnuNDCgoUa5I51s
	2fI5RrBbhIdNqiPI5eKgoLXjGkvipEm9J5rmkFqA1AUBfvVNA3DxVxm6Dos/QzbE
	daAufKviri4bEO040Z6FhhUbN8CAkJ8uhvY/e9SDyCpfuCqnvF9BZrefFw+yPOYp
	qp8zrhsH7HTov3t1UGoTCg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cuh4kgc2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 07:02:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62C5kTe4033162;
	Thu, 12 Mar 2026 07:02:07 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012034.outbound.protection.outlook.com [40.107.200.34])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cuh5dmqns-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 07:02:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4MtzB7UFALf3o60K9FiM+I7+RMn7GUeT3J+ZpbDU/wvGgyV3F0poyJSZu2HpJa78VxOD6uXfC/oerwSFOV1nIuuXd+9jUB9/WHyk8rwIGOKueHLaibwntJCJ/sOsMSY3dzvIH3T0sAVw7i91WDSjVjt/KSYdxLzWwnsOshs7N/TH/72FyYahZ3wmDatWfLnJvbbi/by5vZdot8cWmwd1fTfYOopPp6/tyYkaVBjBGoWN1sZgC4wFcsxAFpeWX/z6Ck/YqsqXUUwmX3X77M1FyA0eUHkQcDm/1hIgK4e5xGh4hsdzkIe8f9nL9qiP6712CVLZre8RK7TgCXt/8fu/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iccEkeBoI1+vQRHHrIq5FQUgQ3Y8oCahy2F6vZmXe3w=;
 b=KTOYdwXf0xDPXsFKko/pFtO46I3SLpEZc2xu9mffwHJoci8hbdye/1wUPOwn30bX70A3oTsPXvFye6ku2t+sHCzodz6zdFB0/5c2UkEDnnxLZXQWtEt4swqQZqP2m+K/AMR+VN8bdVoRIhVWtyEw1ZXKlweOlMWF7XKL4ZfxRTuhOApV0twnZbOtrbslXjEPDStsAG0t/EtFgHqz+pK8MUL5BKB/PK03IdZ+UXMeh6VykzVP+IwCEiLShvYi6N/6cpjhB4MOSvtRE1Yos8xak/wy49ce/8FuBLOCm9k70h/aXsX97OCwFAE5STm5vMMoeNKbm4UtLwGDJBboqUwfSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iccEkeBoI1+vQRHHrIq5FQUgQ3Y8oCahy2F6vZmXe3w=;
 b=UjAuDNzSVaXviQjn7dVkR3La2lWM10YH6W0ZR+LnV/8CPvkXpUz31CFQHHnpKPoj66Nz6mGcCzZauWnS8WwDuvC4+pUh/hwTjZLBw6vjFA+8cVb0HMdZNHN+p6AQTfcwLFuSKcQCrqArFb1sroAeVhEvivJ9nTRzeZC5tICi3UE=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SA1PR10MB6415.namprd10.prod.outlook.com (2603:10b6:806:25a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 07:02:03 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::619b:1264:c089:7e90%6]) with mapi id 15.20.9678.020; Thu, 12 Mar 2026
 07:02:03 +0000
Message-ID: <02404926-b420-4c3f-8c60-bb09277adf38@oracle.com>
Date: Thu, 12 Mar 2026 12:31:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 10/10] bng_en: add support for ethtool -S
 stats display
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
        vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com
References: <20260310144044.21672-1-bhargava.marreddy@broadcom.com>
 <20260310144044.21672-11-bhargava.marreddy@broadcom.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20260310144044.21672-11-bhargava.marreddy@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::16) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SA1PR10MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d9c099-e720-41bb-59ef-08de8005435a
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 LxKarrfI5pBvKx7vJunEbhdJMOrqMscAdrfdAEE29Z/GPJHztwSeZiGsWEhxGFHUhIIMh9s75IJACZul+NfBkeTW5dOXtZKEyP+fILyq/CvRKn3b6g90OIEVI+pHNPGr1J2AZdwJDMTQ45put0baBT60Td4kqmjsnSZ3yFB9ZtLYYZcnZKKxYv80K1sj5niRJNFj/QUcU+et8Mfr2uFPT7YpjoUkG9WtcM1+TZ91lIwDRnX1AHGn6LkGpS0QLDXE7uKP7MNEZh6IAGILp6a6bvsEu+XQ1EWkoS9h1uIwI5dNLMLsVxRnN/ZFyQ5MhZXYro+Awveh1vmw0PJH/YWU0SLcAVKc2stvEv8TZmpqiUc/wszGW1w7VIID8nuR0wx+nkPjZw8rIHPzVW9Dhf+5DnvIdTpQPbt5/lIDXjnvl0v/XbhqIM2PIbQr1NjdUJRpL8F7gqJYbJnY6r174ZgcqdxYHYXZIinsXepIffY4+pQ6OwdiDyjQYVA3rh5A/eh2YOt3No/stCi1nYhqwd23zOSGSEwxAZH269Uw8wz6E+mY4WU1+KU0YAWsbLzVopTIPuzJxlGyKMo5OvXF4N9Gxr+oPXJZdtzsnHBsorONM/B4Gx/buVUDK7YtgQqj8JiHaSKjuswP5dTaPTYm9uOMJdhAAax2y+QpsUDaVi72oAwoY8oabXphxeZaNcIEDTgdKCHYRNbBC2xGgCwgqz+sohGP1+rjX7QgOA/KhnsF9Wo=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RWx3STVGVDdxdHlGT1c0M3ZGQmtNZ213N1MyWElRMmczK3ZTemNWM2ZzMmx3?=
 =?utf-8?B?U2ZoeDBJT0V3cFE4UGpTbFNlRVd1RVJ4ejFiZFpvRnVpc1BZNHBZY3RRL0Ew?=
 =?utf-8?B?SDJWcXdhU0wxcEhUejEySzkyZndabE9QdWZtV0lXbFdUQjhuVVZwSkJMUVA0?=
 =?utf-8?B?NElsdUh4MXNBMjdCN2p6WWlKZXhLTk10c0ZXRXJZbzZqN202djdpYnA4RG9r?=
 =?utf-8?B?TjRUQzFSN3VzT2hVSVh6RFdHS2JmZEt5L1huMFl1bXJIODRVWGJwVDYvbnZq?=
 =?utf-8?B?bm5KTW5SN2duUlRMR2ZTczd0V1NmTlVXTVdXQnlmS2RDN2Fla0NpVHJrcW9G?=
 =?utf-8?B?U2w3R3hnc3dmV2ZiL0FtS1Izci9Fa282NTl0eGFEVFg5dS9UMWd6SDNTLzdu?=
 =?utf-8?B?S0xiam5mNXFIQm43MHBTMVRVQWNGUkxyem1Ub0VMdTZnL1pDSnE2SURPdWE4?=
 =?utf-8?B?TXRuME45Nk9vbmhoNXBqdGt1KzFzSjd1UHdmTU9nNWJOeXZLeU9tR1NPK1Nl?=
 =?utf-8?B?UDhzTE04Njc0RDgzMWdSeWFPeWQ0RFBhb2FHcmozcUNOY2NVa0pkbWJxdnl1?=
 =?utf-8?B?WHVhM2FlRGJ0ZDFEMDNUbW5ZMGFYRWY5ZTN2czJkWVg4a09VZ3pCTGdNZS85?=
 =?utf-8?B?bSt0WjQ0d2dFSkkzNktCNzRPMnVxUEdIVkwveXNCVjdIZjMzbkNaemxtOXM0?=
 =?utf-8?B?VXVCQnJySlhRcU9CUzhHcjNLVDhBaGkyYm5vUXJRZXFua1M5OGxiRGh5RGVr?=
 =?utf-8?B?UUFQeGtDTzRMQ3FuY08wb2gxZ3J0NzE2bmVYdk45T0pSQXJvVUlyRDVFc0RJ?=
 =?utf-8?B?OGNydWVlV0tkdkpMMythRldONlRLbU5HcWZkYytXMUxnaGRMVi9PajkzZUFI?=
 =?utf-8?B?UnVsRGNtUnNSdmY2WVVCeVM3MERJMFJMVXRuZ1NXRzFBK3Fscm5sY09MWktt?=
 =?utf-8?B?c0pTWExjNENVZzVSaXRzRDRwT2lVWkhEdHJGNWpHajN4ODlHckdMZk9zc3Z6?=
 =?utf-8?B?a0twQmtLa2JwbHJNSjRYZzdkUnZERGY1OXdNb1BSMGcydllNczVQK3FoTVlm?=
 =?utf-8?B?YUcxbnE1RHRhOFNWUWNEZ0VIeDVmWFFDL29paTdzMEd5Q2xDak9FRm5VcXNj?=
 =?utf-8?B?cjNDbDVQZUlaUEZZS0JVWTg4YUdQZWR0Wk51clFBeW5NbDRBZ2diNGM0eGdi?=
 =?utf-8?B?dEdFb0F0WFRGZSsrNlNxUHp4ZmhFMExuN2NhWnhOSGR5UzRUakJHNm9teTBu?=
 =?utf-8?B?SllYRTU2RkUvN0lic3RkNUZmeUlUUlVBN3RYTDUxOFNvSzdBYm5wQm14ZThz?=
 =?utf-8?B?UXJIV1ZVbFhkT0dVWEJsQUdwZkJqemNaZnRwbTg1dHExRHcwMGcyY2lMVk5M?=
 =?utf-8?B?TU8rU1FCWSttY0xxc3pUcVBTWjhWdXNNdjBpVEczLytTcnZUaHhDcnZGWEdX?=
 =?utf-8?B?aC9nTWlpNFhDN0FLanNmWGk2UnM1bWx1NURiSlNJUmtUbk02cWpNWmtRd0Fi?=
 =?utf-8?B?U3lXZWNBL1U4N0g5aU11ZkZKODVBWVdaeWpyd1NkRXc3ZjFLTXk0bXZLVzNK?=
 =?utf-8?B?SXFFa1hjY2NwNk9LUkltVDVYekdSWmc1cjlIb3ZvZVFmSUtMYUlFaVUrdTJU?=
 =?utf-8?B?V1JrQ3lTQit1YklKS2NSZGhMckFUM0JYT2JHaFMwMmU1a3JBQ2kralFMT0Zs?=
 =?utf-8?B?VUJ5ZE5xVDl5NGVJam43WS9LZTBrREl5SWhNV1MyZmNWV2d0cDBBcHNmZlph?=
 =?utf-8?B?VllrR0swZ2ZrMzNlNVJUcHA2TWZhSmZvdDRzNnp1UFRvUkx5UlpWTmRja0hQ?=
 =?utf-8?B?RCszcjE0UkREZEtSeFl5TytyYk85QVdCWkhsaVl4RHpDc0ZUZ2dCTCsxdVN2?=
 =?utf-8?B?b241UFg3a0NCL0dxd29tWWF6dExTSmFhb2pHSDA5TG5XYTRKc0ZLSjhFYjZF?=
 =?utf-8?B?YjJGUHpkN1ZkYXdMYmpCN256UFpRKzdhNFVhTWxBZ1pvWXRVNU4rNGdETmQy?=
 =?utf-8?B?MGRvYm9VTjc3N2tpSEYyeGRxRjl2OE52RU9LeURaelhpL1JJMWZJYkJ0RlFx?=
 =?utf-8?B?U0lqR0dzSW5EUERDcC9zTlhtQlc1TzVmVnhKRGViUi9BSTYyb2FIOUZSS3Ro?=
 =?utf-8?B?OHdWQUNpMHk5SDNCaE1wS3ZMYjQ0NGNHdi84ZkdYNnRDN3dMbTZENzkwTFFL?=
 =?utf-8?B?YnJ4djdTNk85U2EzNS9uQWQ5c0hHZE16SGF2elp4cWs3UUQrTHhtM1NmdFVy?=
 =?utf-8?B?MXltdGk2MFRoUnpZM0oyeVJhbUk4K0hxcjllaHMxb2taNTJDU1lRS2hWaHEv?=
 =?utf-8?B?bkZqWXVKNytuVnFYa2p6aVBrelZoVjRka281UjU2NnVXcC9rV1IvZz09?=
X-Exchange-RoutingPolicyChecked:
	wO0v0NKCBUTH7Q8xakJTpwWTMGbew2Lt8GRyIEWBMwmGmPCx/iT72mjnG0GjQEbJowSw+OAI+IHsmoJ4cUpYwx2BtdTjQ1M+0AJ3UBuyrlS5S2lOxdPbuANUj+keWgCxITXy5gGFnwRIkMNdoR09/i3Bz6AjZ93GLzgXkkDSbpAOdvlZLp2MWr/uwCppqm8mbxOfJvjSa8sYxqqAKOnteK0n14s3kU4PmXW7fCX+WJIwHWKe4ATUoN3s5MDIqoHenZR3hHtOmedDKNS4v7Lot4ZpeIYJEngxFw+ZMZUAc0ldD8C2c4IAQmXqd6MxHztHz2+qcC/IezOtMnLE+MBNKw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RoMxJy7M2SnYJAY+DLMGNZNopCrIocJFSTa8tRlhL4wAsp1RzV6RFqcdk19iBBOS3QoUhP0HEH63tLkKqe04nJGBNyenIKk4/J+vYrXk/biyK2x2QciAa+Yhb4A7Lqx0xVKFatc+Cl24HcFzXShGJTs14QxrKPn52IobK6xJnqNdPZi8hTiLxMtElZ5TrKbFJXS0uCiPeErQo3sd3BxJnRL3gPJ+h+JYjPt+l1ZctcGYRGFXYcHIXTK9T2q6TcdczGTCDqhS1GNoTcDynM3bvqfCK97PXluv5Nj5ZyL5vyiJMH3pMI9tqR3t3YwCIl8RjT0xX6MjOciRu7EEBedk/viYXrtKG54a1osM8P8uzYbDmTBH+wF03XnkBrL4nrbX6d1TKqxLEzlhPo8nQH4Z88Dl7Skm0f05IlN6j8f9Q6C4nNyIqZKpUF+TP7Arjh4NHZxZAf8PSdVtF1ZXkGhkFMwJmQUts3GkHQPM2/BnPhMxtLO6SzHPwQGBwnNLMsQjGjOpjz69IGmcaZmzk1Go+C6LvlINmEtipHVEmrMvAH0/LvDTCfDgnuaY8BhKtXBEIrX42i71ivTDmm+JpuL8ITwfdn8eSoHw7N91BXkQ7R4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d9c099-e720-41bb-59ef-08de8005435a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 07:02:03.4965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rv0YH25lt5JMSZLoBp0Fcy5Tqh8v9yf9AUxhmLFTO/6EQEe1ZRZibyB2bkyGurUvq3jR4JTPPWdOitvBRIJ3RZkzPNpUn33PM3UJehbxZ7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6415
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603120054
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA1NCBTYWx0ZWRfX46nJudM0owO3
 T2LU95XrnVnK0B3keN287RFSnolb04h1S0pLOX8CuniK2eNV7lKjCQc98X8sY8DAyLR0SumAtT8
 FBWfkXUv1h/NFATQaN3jdpWxhOWxL2FwbVwxMhUpS4AmNucrfoeLNuaLwIj+LXrM0F+xSMrLLTu
 xa9NAw/B22LvygMbmLQzsKBJuPFJKYQYtZo9XhgE3EtcrCAYfpzkRinFM2MzfpoiY3PLH+ZoF3Q
 S15M/39y7uMG4XFpu2yDG4jbjFPDIh8AgVCAV2NS7Vu5QzNvkAEf9d18F6eXoEhJSM8jzD2zCMr
 wHTcKcClKO26WJjxMBL9GR+3CTowipSdX3472gicRMLYVvMI3TG+LKOQfwtTpNEHiwzDYJJLCgx
 3Y84V1LAG6l8AlHCvp/KYZl7Uf+QZuyGyPk72aFZBwEprpKcZ/N5wUa8WD3bEdSSFhGA9csVdzu
 IvblCR0waEKaObvntBA==
X-Proofpoint-GUID: Y_yNy2dwHBE_fXdE6ITOJZdSjTS2I4Ih
X-Proofpoint-ORIG-GUID: Y_yNy2dwHBE_fXdE6ITOJZdSjTS2I4Ih
X-Authority-Analysis: v=2.4 cv=Ob2VzxTY c=1 sm=1 tr=0 ts=69b264f0 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8
 a=TqGvS9rje9JslPHGuNEA:9 a=QEXdDO2ut3YA:10
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-266931-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,oracle.com:email,oracle.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3F29226E23F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/10/2026 8:10 PM, Bhargava Marreddy wrote:
> +static bool is_tx_ring(struct bnge_dev *bd, u16 ring_num)
> +{
> +	u16 tx_base = 0;
> +
> +	if (!(bd->flags & BNGE_EN_SHARED_CHNL))
> +		tx_base = bd->rx_nr_rings;
> +
> +	if (ring_num >= tx_base && ring_num < (tx_base + bd->tx_nr_rings))
> +		return true;
> +	return false;

what about just ?
	return (ring_num >= tx_base && ring_num < (tx_base + bd->tx_nr_rings));

> +}


Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Thanks,
Alok

