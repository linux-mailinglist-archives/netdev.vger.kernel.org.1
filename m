Return-Path: <netdev+bounces-239956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 13312C6E64F
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2C6F35C6BF
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 12:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAF7357A2B;
	Wed, 19 Nov 2025 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CD5r8FMg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yGTCN+db"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D1534CFC9;
	Wed, 19 Nov 2025 12:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763554382; cv=fail; b=aYki0yUoYXqSulxK7TkTOHpTsZO/Ab0P2NwQ3dnBY6bZRANm6XJUMZRYAiMyEDHMflVDGFk6lfYpPmxGCRzs/75TqznGXIK1F3G3KZemHZl9/mvTmYjKSFMRM1KXeJG+8OYIm4+4r6QJiKT9rkSmvcLe7fkSUVA0z35Xko1CxZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763554382; c=relaxed/simple;
	bh=x5hukdCB8pMT3F4LJ8P+pk0CBLZfj1zW5j1j8JJS7VM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KaDZe7oPoGetKeWYgmLdomCJNWc+m3GnyeaViD2OgUKONCew1FRX4H3EwgrRJPC8vFhF22p5faEFXsZN1AzMvAAK4m6j+BZelFfYIYCMcrj042rr4wuNDgq4Fz+NrV2pUTZIcyqspwul2T2RNbm6FvRdt/x7dUEXDEDk5WqWIyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CD5r8FMg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yGTCN+db; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJAjUmk001416;
	Wed, 19 Nov 2025 12:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4s7fa5vHCXxiaOUu8oMat5UZFKMMizSBwdP8P66N19U=; b=
	CD5r8FMglbb5XCWhTMPQP7rxrg6RnApx/1n/37rFM/m7YBKpQjHEOKH6U92rUNL9
	cmoc5JZUQ15JzCTLXbrg3RiVpQLmo0yW7AdHu4NteC3uaQpceF2QMGyj/vPm8oTP
	7vWYet/5U3PTid/xQJz1ODCGMfOgXMnhixJWKObhlHJUMPy7cV+Rjgxw2zIkq2l1
	ueqccWLGzrcmtOxwfCneCWbJgvoWUjoUo7gk3iKK2ZsA7E/d94hqjDH65j5PwaVi
	N4oXKVcH7T3MkrtZx3TjsIn5+dtdEDafFqQApDoSSaYx6/JpnuzbRauJGKAexivU
	BFjvoFJ5tTRJGbhfQS1JYw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej8j6wn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 12:12:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJADA31007206;
	Wed, 19 Nov 2025 12:12:10 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010026.outbound.protection.outlook.com [52.101.56.26])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyagqw8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 12:12:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUhIfLPg4uMXMukCuvIx/MxaoZJQMvo2NBXPCBA1kwlwxKRkTuKHYjzii/4gtzdhmavNRpava/Ke58KDfBGA+cYmzRttsPwepNLvUJucqVQFKkTYyz25HwxLVYEfpDp7uL4/6bRkSYw8enoe5cp/xq7iJRZcMeb6SZcg6jnrkooIhmRGpos9WvCr104UTNcQaSH1atcnSv46MILppcymDHepL5+JZBaEi7ukbTiKJHp2sDgS7bzNX9DyCblJq+wVc15IwBJQY8GNSGRLl1wI02yohpUoEU5OKfr5nKNKWf5rWXxmz5V9uqRKIOibWrMxz9+FImZ59RuU3s9BNqoukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4s7fa5vHCXxiaOUu8oMat5UZFKMMizSBwdP8P66N19U=;
 b=T9zqSQhm80+O1xr+2ENVptfTUCZosN+2ajJueYtr+Wloz0ZzuxLp55OoyVwPb9866j5lg0I+KfGdb1iYVyHHZczLwoDzmc1xcQ29ycfAKsS7uCn9IhmndD5+hfM6r5MJIqPSdD4+OkGrE6cneQaaB8KBZy+AaE9DnZZm0NhqusNldXoNt/xG4bVPh0q8LwMjBJumkw8trfglX3yI/jYIEWkcDDNNHG9vHlCA11xjII7NZTG5hXFlgWdDgD8AB595UHp8QJmh00u5C3MlCtb9JwfYlK1FcMqYac6nk/MzzNO+oJiRhjPtxcKoHQI9qTOXtAGOHA2RrznBC2TO69/SQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4s7fa5vHCXxiaOUu8oMat5UZFKMMizSBwdP8P66N19U=;
 b=yGTCN+dbhk1m+YJx/lqoh970J4OKSPoEkGUMzqfi2mdt/ydEGE9f45T9zPTFB7OPdpEN0E8DNub4wjbXS2k/vEtYcKZQorygw8is3iCH2JYh0H1F4ipXF1JNf87vvFmLwo+fAyr+kzcT3ExelL5ceVPivvx/O3TwdfRwsjCSZdk=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CH3PR10MB7680.namprd10.prod.outlook.com (2603:10b6:610:179::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 12:11:57 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 12:11:57 +0000
Message-ID: <2eee6abb-f82b-470c-8d39-15f09ffea3d4@oracle.com>
Date: Wed, 19 Nov 2025 17:41:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [v2, net-next 03/12] bng_en: Add RX support
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
        vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com,
        Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
References: <20251114195312.22863-1-bhargava.marreddy@broadcom.com>
 <20251114195312.22863-4-bhargava.marreddy@broadcom.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20251114195312.22863-4-bhargava.marreddy@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0043.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::17) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CH3PR10MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c01f8d4-4e9b-4bd4-53cc-08de2764d5a0
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Qlc0eUJBVlM3VCtLSDFyTk5jamFyZ1BJdjlPUWtpUXNtZ3dLQUFjRTB5dzhQ?=
 =?utf-8?B?Z3N2L1dIQ0IzN3RBL1JjT0ZwL2NXVTBTTUdUWlprMkRFUG05ZFNTQUJqejM2?=
 =?utf-8?B?OW1DVXFTdzVYODU4R3dsU2p5elNRTHVxakhpNklQOS9FclVlbEFFMkVFZ21N?=
 =?utf-8?B?QkJpUzExNStXMXNDOUFjUENFcWlFWmRrVHFyOUVkYUJNVCtlUnhTQzhxMEhM?=
 =?utf-8?B?TGVMNHB5KzV0VUFDNWpmbE9iNlRPRVVJckwvMTF3QkFqd0libUVxQVFwdzN0?=
 =?utf-8?B?cHZPeTZZYWxJYkVmNkRjWXJOSndrTFFESyt4K2VmdFFyL1p3UUJyRzhCcVZv?=
 =?utf-8?B?NzNZS2s2TlZKVUVyN0dTaGw2RFFRbGZvV0lYNkJ1WTlYdmkwNG9qSnpqenh0?=
 =?utf-8?B?ZWgxQ2FxMUUzMlYxRlRCM1FtQjlVNS93QThnVVUyR3FHRE5WaldtSlhtQXd1?=
 =?utf-8?B?alBjZVpSeE1WR3lUUzYraTMzZVdibXBndHV1cHEyMzVYY2lEUHlQQ1cvTnJu?=
 =?utf-8?B?LzhMcUlkNEZ0TE9aZm9KdDkrcDRyWFdZTU5kZmRMZGJoaHNWd3BqZkR0aXgy?=
 =?utf-8?B?VUx4RXp3MDZzV1hnVG54bkUrVmllNkIrTEtWQ3NMVWZrMmpsekxlK1ZUL0N5?=
 =?utf-8?B?WTFiZ0hxcFlaV0Z0cG1FYWtUM2gzbFZ6OW94K3UwSmdwYVRDMUxNalpVWjQ3?=
 =?utf-8?B?MS85MUw0ejkwd0ZzSXFaNWJYRGhmYnBHWXFjb3pCU2YzQkx0NThwZk1SWDhM?=
 =?utf-8?B?N1NHQU9OUFMrNGdVbW9UZE1ZMWd0MkNqby94R3EwdTZMZFNKVlFQWlMrTEln?=
 =?utf-8?B?OVozdm5xemgwSVhuV2R2Q2lGM2NaVHZ5bjFZK0tGUkJ3b0tRbk1qS0ZoMkxQ?=
 =?utf-8?B?NnhkTE1KR2F1SFdTa0dqMFlNYnBkNllZQlEvcHZvRW1kLy9YazZUNUQ1R0RV?=
 =?utf-8?B?YUhKZm82am4xazZiTlgwRzZ6SnFYcU9pQ2NUaFk1NThkK0JPZzJxc0k5Yjd1?=
 =?utf-8?B?bDhyMlRCS0cxTnpKdVk4TTIyTWtLM2U2UHJycjVtZ2MwVmdvU0NNMnMxVXM0?=
 =?utf-8?B?eWhvUkVkc1k1NjIzdDJpT2lzcG0zNGRyRkhSdW5Ucm16ME5rRTNHQW1mRWpm?=
 =?utf-8?B?Z0dralV0UStGSEdVQ3Nlc0ZjZ1ZCNytCbVYxVFFNOGI4S1NSRWFHWjJIc3lh?=
 =?utf-8?B?SHJLUVdmUU44R3VJZTVnclZmRHd3QXFKd0JESnE3M29TTlkreDlrQXhQcXg4?=
 =?utf-8?B?aG50L0E1U1NFUHVMYk5qOTAzck5GNVc4enNienlXcE9HK2F0NjkvTlQ3dEtu?=
 =?utf-8?B?dWNWdXlYc0EzQ0dWOE9aSjZOSm1xNk03VVNhNEJEUjYwK1FYL3diZkQxSHNs?=
 =?utf-8?B?a2l5STJsdyswenhNS1JORjR1aUd2cytNYjNueE1mT0NWaGZPTW4rU202NUY5?=
 =?utf-8?B?ZnVJTGRDWWM1MGtuOFJVSDh6UG4zZzc2YXlCdGtUT2FZYllWOWt4dHp5Y1Nx?=
 =?utf-8?B?OHp5S2xFckJoZkIzTGdZeTVEMFROZC9QUXZmbk9VN01HUXNBMnN5WFNZN2g1?=
 =?utf-8?B?Vlo3clVyenBzOGRCYlFqZjZ3b0ovaTZwZWZkVGdZNnlhVWozNUxiMy96MFhy?=
 =?utf-8?B?ZTFWN0NNWHlLNkU0b0E1K3ZhbDB4cTE1cW15eWRzTnBaZmcraTN4NVh5Nmhv?=
 =?utf-8?B?U1k3K2xSMUtPUXNyZFRPVTROL0ZHdU1VNVVrZ2lzQzl1Qmo5aExWSHBWZjh3?=
 =?utf-8?B?Wk9FQ0l6YnRYbWlPQ3NDZDBRMkM0WUlmdjdlSjJrSTN4ZTZqZ1pwU2Z4ZTJw?=
 =?utf-8?B?UDJZdDNPSzVwR0hkRVlISjZMQnk4NXJpZFEvY0pIVzEreWlCYTNzclhKcXpz?=
 =?utf-8?B?VmFCY0M5aWwrZ0ZSdXJnVDhPaXBhaDQzY1JzQVg4Q1RxNGIrbk5seThvOFRC?=
 =?utf-8?Q?2wfk/sUrHOev7fXWbUC8hpsdYHj8k4CM?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aTlialVvbWlJTVp3eFVZSWl1d05ESWcydDB1aGRSaHh4dnF1T2JYVUpBQkxS?=
 =?utf-8?B?NGlvNlVRVm1FRGc2bHExR3hyNUNKUW1ZUUFLTEZ6bXZ4eHdWSTMzWHJNMUx0?=
 =?utf-8?B?OXZpYStSNmFySGNJaG16MVhkSmpscnUxc0sxaE5FYXJYazZRWEViTzVOdGFD?=
 =?utf-8?B?MkNwellqeWNCYXFCdm1IRUZmcFIzU21GekRmWWNkNVFzVTUxcE8yQkh4Qndv?=
 =?utf-8?B?SHFkU0pVeHVnMFFBd1BuTHdqejgyNWtKdUdWczRHQkFqclZwK0hUUGFGemFU?=
 =?utf-8?B?cVYwcS9XN0dSWTRUTHhld3daa20wTjhyYXJCVENHZExlOGhUaStteXpkcVcr?=
 =?utf-8?B?VEpXd1o2S0cxR2VBUGcyVGcveVNSTEV4ZG94SmJSVHpxd0pnZ29KY0dqVHRp?=
 =?utf-8?B?a3dGV21RUkwrRi9MTzRPeUZvYm56OS8wTXRiblBVRlpqMnMwT2NkalliY1hH?=
 =?utf-8?B?cGg1ZUNlMFplc1M1SERiK0trN0lneU1QbGxpazVnZUp5bjRaNXdWZFBOYnM3?=
 =?utf-8?B?YTI0bDlUYk5ucTYvUDBNYy9HcGgrSGFYU1RESWpIeDBkajZjUkM5eHVYb1FW?=
 =?utf-8?B?bkt6ZFNzU0Z4aGRIblZIMkJPWDhwSVZoTFZNMDBIS0RnWmp1bklzRUJYLzcv?=
 =?utf-8?B?NXc0RmVvUkxEYmlEMTNmTDFaMFA1Z3RNNm41UHlVK2xWMVZybnhaTi9oWEUz?=
 =?utf-8?B?d0xPTFM2b1NSd2NrVjIrcHowRW1Ebk9oRWpkNktuOUp5WVNyVkdaM1hqTWpu?=
 =?utf-8?B?U1JtSVhhZThhaWVwUDIvV0ptQWRSeHZMcGdBSng1TWxoeVBPYS95NldsTHFt?=
 =?utf-8?B?UTJnbUc2bjBWcVVOOHdGc3Yxbm8xSks0V1hOOUN2ZHd1VXdOMytqdi9tZXBS?=
 =?utf-8?B?UEErR1NadzFmRGRMbElJYTk2ZkZNeis5cHltZWRuSU5ZS2pRL1JSUmdnUWNW?=
 =?utf-8?B?SjJobmxJb3UyYTA3aVQraTU1WlFLQlVaVHZjMVprclRuTnNUQjh2cmZsR0VT?=
 =?utf-8?B?ZmFhem9ZQ3BTZkxjdGRDS0NiWVpscjRBZzV4OWRhMElVZUw4d2xtQmdWaHl5?=
 =?utf-8?B?YkNEak42aTF5OU1wS0EyV2JXTUozbVVSNnNJbDB6NTJzYTJNTzlGOTEwbUVp?=
 =?utf-8?B?K0ZIU2FpWWNTdHNUQlp0eFhqVDkyLzZUcjNZNUNoMTJvQXE0dTkzSVp4Ukgw?=
 =?utf-8?B?Y3BZNWFINlh2WEZJdjdGWCs1NmZFeW5oMVg1ZVoxNThmTDJQdC9iR2hpcXFB?=
 =?utf-8?B?ZXB0YVBUNHpDNng1ejdGMUQvS3VoZGc3QlNmVmtPZGdNc2FiY2twMm82UTNB?=
 =?utf-8?B?aU9qVkptSlY0SkdpNkFKR2xsc3hHZUZoaVJnamNRS0IzMHdVZVRPRHNLV2NF?=
 =?utf-8?B?c2NrVmY0MlY4cHlULy9Va1FJZ0NHbU0zK3MyWjhacldrQWxWQVR6K0tsWTd4?=
 =?utf-8?B?dHJIR0RZcWxKQkQ2Ti83WlZSYlBnQUkvZy90dGQ5UmdUZTNRSDNXQjNJUnRV?=
 =?utf-8?B?RkN6WVVSQnM5QkovcjJ1TkdSM2kxU0lvYTBlZkE1b0xHQU52QVJuY3Bub3My?=
 =?utf-8?B?L3RCejRqMWIxQzVETk1STGpsM2pOS3VNVzMxeEVYSEhtTHJad3FXUlRrVjBE?=
 =?utf-8?B?aHJZaTU3RlVoMkgwNjNwTmVsUVZXTDl4MDg0anFXY2dKVnYvQjN2RXovVW1X?=
 =?utf-8?B?dWN0Nk9EUy81bzZHdXZ5TDdHVWpwTi9aTEpEa25LazBPWlNjVHo2OUgxWmt5?=
 =?utf-8?B?RUd6dkFNbGtWNUNEOGRwVnNYcG9hWWUzOUhuY2lkRGtxK09nV2tiTUE0Lzhp?=
 =?utf-8?B?b0Q0WEVSZXpnMGVpa0dhSXJFSW45UldXVTZ1T3I1dWRtQThxOS9NUDV1ZDFz?=
 =?utf-8?B?K2FuMjhIczNMcjE1SElnQVllMDNxYTlFSS82Z1p6bDR2ZlpTNlVtRkpuMlpx?=
 =?utf-8?B?L2xnWlNwWno3ZnRlMzk5ZCtyQ3BESXBpVCtYVjYxOFRMK0hWMzZ6WmhWdHZR?=
 =?utf-8?B?aW80Zy9Lbi96bm02Z3NHQWozVWxuT1pkV3hVN0hNWjBkbW1KYjgxQXU3Y2lU?=
 =?utf-8?B?czdiTDJRTUYxdFlPbmlDZmN0UHhOZ1FoWlhiUk5JQVlHaHZlZWZTaFFDKzNx?=
 =?utf-8?B?NVh1Y2VGQm84SnVvYlAzZm9XbmR0S3RWMUo3cHl6RldseDVrTWhUdUtzUGF5?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UOTmZKrh40tWnYAx5amFK+xhlQvOvj86oeNmlZ/MP8E4fLb4GM0j3KcNqfddVlSOGaZljNHdL1ROYV4T/bbnZlqka7PCD7ElF1RroSgvG+bVHP5/WY9kxXDwZ3zRb9LRwR864n7iMk3O2UVirSySABudwKFurhYPxOedpZJ3kAR6X3xIFs9al9Cof3xdB/GPPbLAoKgLDD/62H9CQMT+ImBBtrapDF+rKhoOQf9iYlVHdih3ItQZaPbfNoBYA09rh2XcPdInMQJwiIGguIjCkDBJ3SKUXpOjtdLBnC8QTJqOFZiO8YWZbF3Ny5OijR29W8NJRMaHM9+vrKHCfj9winDNfNNIbob0GrNaUipiH+kMqHyX/fC/66a8ao362gpWQEy2kWATnuTCB7gULN/y0Df9AFLnwj6Q5pMCYG4yrhloUveCp4EBSf9zD1nnlhnHrY5J/b0t5fK8HDDxzcxoT2TxFbw34bssh68zuAX9UwH1DBIArjMVAq3qPaVYcyyLasaMkHrwWyODkvx25ANMN/CLvjdoXEn9cc6jTgmP+wxRBfrbDC5f3eDunyCFuQ+Baypc4b/cUowznHewxQVvaDjtEdNz/x1dtObnwtSyR/Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c01f8d4-4e9b-4bd4-53cc-08de2764d5a0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 12:11:57.0522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2VoW9Kpzj8j6sfjkeVwzISYO8nq905s06nweDtowtJc4WYamSovgI3wo/HpCIczvfHQAlMA51OZSa55W1UbyLFhEycJavqIJpzxOigc7O8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_03,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511190096
X-Proofpoint-ORIG-GUID: b0BR2PVb_Hcz4IlMU-tkq7OyrJezFU4G
X-Proofpoint-GUID: b0BR2PVb_Hcz4IlMU-tkq7OyrJezFU4G
X-Authority-Analysis: v=2.4 cv=I7xohdgg c=1 sm=1 tr=0 ts=691db41b cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Q-fNiiVtAAAA:8 a=m_Ta7KiqwiRzPEnlPG8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX4/ZQygiY5qB7
 7iQ40Ahn7P4ru+9TihLFdzk6oIwHfkWXNnUhSXPAfS4SexSqU600NbcQbWKq++fltMvPD8bku39
 X3DsXzV0zjdu6u0J8llylU+SF8YJslhu0WWz9fVL7c53VJ58Y94Vbas1HJ/wiSMZnTWlPYzmqH8
 sWhhpXjMu57caKFeA+d7UdgbRDZtl+jc+j6poj1GYT1DBQxEL76tJkLAzqx1zDwHHk1mcApYm4T
 CGeyRg2UsVd7qZM9xiTHgq27hOu1qo2gkr4RWFSXb45XlxXAGuUuSUgMt4w1Z51v3TJxsZ+trBT
 vUpVnps/8ffS6Zvh8wt2oo+yUmtVs4aKWMH0tc/Q79twu3AGVkZEA59TT6kj82/Dd+YNETGcB3r
 nbZHfxlcsbT8e/GZ+0ylsJT9UXBHSg==



On 11/15/2025 1:22 AM, Bhargava Marreddy wrote:
> Add support to receive packet using NAPI, build and deliver the skb to stack.
> With help of meta data available in completions, fill the appropriate
> information in skb.
> 
> Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
> Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
> ---
>   drivers/net/ethernet/broadcom/bnge/Makefile   |   3 +-
>   .../net/ethernet/broadcom/bnge/bnge_hw_def.h  | 201 ++++++
>   .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 111 +++-
>   .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  60 +-
>   .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 573 ++++++++++++++++++
>   .../net/ethernet/broadcom/bnge/bnge_txrx.h    |  83 +++
>   6 files changed, 1010 insertions(+), 21 deletions(-)
>   create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
>   create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
>   create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
> 
> diff --git a/drivers/net/ethernet/broadcom/bnge/Makefile b/drivers/net/ethernet/broadcom/bnge/Makefile
> index f30db7e5f48..1fedd7a0f14 100644
> --- a/drivers/net/ethernet/broadcom/bnge/Makefile
> +++ b/drivers/net/ethernet/broadcom/bnge/Makefile
> @@ -10,4 +10,5 @@ bng_en-y := bnge_core.o \
>   	    bnge_resc.o \
>   	    bnge_netdev.o \
>   	    bnge_ethtool.o \
> -	    bnge_link.o
> +	    bnge_link.o \
> +	    bnge_txrx.o
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h b/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
> new file mode 100644
> index 00000000000..d0b3d4bea93
> --- /dev/null
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
> @@ -0,0 +1,201 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2025 Broadcom */
> +
> +#ifndef _BNGE_HW_DEF_H_
> +#define _BNGE_HW_DEF_H_
> +
> +struct tx_bd_ext {
> +	__le32 tx_bd_hsize_lflags;
> +	#define TX_BD_FLAGS_TCP_UDP_CHKSUM			(1 << 0)
> +	#define TX_BD_FLAGS_IP_CKSUM				(1 << 1)
> +	#define TX_BD_FLAGS_NO_CRC				(1 << 2)
> +	#define TX_BD_FLAGS_STAMP				(1 << 3)
> +	#define TX_BD_FLAGS_T_IP_CHKSUM				(1 << 4)
> +	#define TX_BD_FLAGS_LSO					(1 << 5)
> +	#define TX_BD_FLAGS_IPID_FMT				(1 << 6)
> +	#define TX_BD_FLAGS_T_IPID				(1 << 7)
> +	#define TX_BD_HSIZE					(0xff << 16)
> +	 #define TX_BD_HSIZE_SHIFT				 16
> +
> +	__le32 tx_bd_mss;
> +	__le32 tx_bd_cfa_action;
> +	#define TX_BD_CFA_ACTION				(0xffff << 16)
> +	 #define TX_BD_CFA_ACTION_SHIFT				 16
> +
> +	__le32 tx_bd_cfa_meta;
> +	#define TX_BD_CFA_META_MASK                             0xfffffff
> +	#define TX_BD_CFA_META_VID_MASK                         0xfff
> +	#define TX_BD_CFA_META_PRI_MASK                         (0xf << 12)
> +	 #define TX_BD_CFA_META_PRI_SHIFT                        12
> +	#define TX_BD_CFA_META_TPID_MASK                        (3 << 16)
> +	 #define TX_BD_CFA_META_TPID_SHIFT                       16
> +	#define TX_BD_CFA_META_KEY                              (0xf << 28)
> +	 #define TX_BD_CFA_META_KEY_SHIFT			 28
> +	#define TX_BD_CFA_META_KEY_VLAN                         (1 << 28)
> +};
> +
> +#define TX_CMP_SQ_CONS_IDX(txcmp)					\
> +	(le32_to_cpu((txcmp)->sq_cons_idx) & TX_CMP_SQ_CONS_IDX_MASK)
> +
> +struct rx_cmp {
> +	__le32 rx_cmp_len_flags_type;
> +	#define RX_CMP_CMP_TYPE					(0x3f << 0)
> +	#define RX_CMP_FLAGS_ERROR				(1 << 6)
> +	#define RX_CMP_FLAGS_PLACEMENT				(7 << 7)
> +	#define RX_CMP_FLAGS_RSS_VALID				(1 << 10)
> +	#define RX_CMP_FLAGS_PKT_METADATA_PRESENT		(1 << 11)
> +	 #define RX_CMP_FLAGS_ITYPES_SHIFT			 12
> +	 #define RX_CMP_FLAGS_ITYPES_MASK			 0xf000
> +	 #define RX_CMP_FLAGS_ITYPE_UNKNOWN			 (0 << 12)
> +	 #define RX_CMP_FLAGS_ITYPE_IP				 (1 << 12)
> +	 #define RX_CMP_FLAGS_ITYPE_TCP				 (2 << 12)
> +	 #define RX_CMP_FLAGS_ITYPE_UDP				 (3 << 12)
> +	 #define RX_CMP_FLAGS_ITYPE_FCOE			 (4 << 12)
> +	 #define RX_CMP_FLAGS_ITYPE_ROCE			 (5 << 12)
> +	 #define RX_CMP_FLAGS_ITYPE_PTP_WO_TS			 (8 << 12)
> +	 #define RX_CMP_FLAGS_ITYPE_PTP_W_TS			 (9 << 12)
> +	#define RX_CMP_LEN					(0xffff << 16)
> +	 #define RX_CMP_LEN_SHIFT				 16
> +
> +	u32 rx_cmp_opaque;
> +	__le32 rx_cmp_misc_v1;
> +	#define RX_CMP_V1					(1 << 0)
> +	#define RX_CMP_AGG_BUFS					(0x1f << 1)
> +	 #define RX_CMP_AGG_BUFS_SHIFT				 1
> +	#define RX_CMP_RSS_HASH_TYPE				(0x7f << 9)
> +	 #define RX_CMP_RSS_HASH_TYPE_SHIFT			 9
> +	#define RX_CMP_V3_RSS_EXT_OP_LEGACY			(0xf << 12)
> +	 #define RX_CMP_V3_RSS_EXT_OP_LEGACY_SHIFT		 12
> +	#define RX_CMP_V3_RSS_EXT_OP_NEW			(0xf << 8)
> +	 #define RX_CMP_V3_RSS_EXT_OP_NEW_SHIFT			 8
> +	#define RX_CMP_PAYLOAD_OFFSET				(0xff << 16)
> +	 #define RX_CMP_PAYLOAD_OFFSET_SHIFT			 16
> +	#define RX_CMP_SUB_NS_TS				(0xf << 16)
> +	 #define RX_CMP_SUB_NS_TS_SHIFT				 16
> +	#define RX_CMP_METADATA1				(0xf << 28)
> +	 #define RX_CMP_METADATA1_SHIFT				 28
> +	#define RX_CMP_METADATA1_TPID_SEL			(0x7 << 28)
> +	#define RX_CMP_METADATA1_TPID_8021Q			(0x1 << 28)
> +	#define RX_CMP_METADATA1_TPID_8021AD			(0x0 << 28)
> +	#define RX_CMP_METADATA1_VALID				(0x8 << 28)
> +
> +	__le32 rx_cmp_rss_hash;
> +};
> +
> +struct rx_cmp_ext {
> +	__le32 rx_cmp_flags2;
> +	#define RX_CMP_FLAGS2_IP_CS_CALC			0x1
> +	#define RX_CMP_FLAGS2_L4_CS_CALC			(0x1 << 1)
> +	#define RX_CMP_FLAGS2_T_IP_CS_CALC			(0x1 << 2)
> +	#define RX_CMP_FLAGS2_T_L4_CS_CALC			(0x1 << 3)
> +	#define RX_CMP_FLAGS2_META_FORMAT_VLAN			(0x1 << 4)
> +	__le32 rx_cmp_meta_data;
> +	#define RX_CMP_FLAGS2_METADATA_TCI_MASK			0xffff
> +	#define RX_CMP_FLAGS2_METADATA_VID_MASK			0xfff
> +	#define RX_CMP_FLAGS2_METADATA_TPID_MASK		0xffff0000
> +	 #define RX_CMP_FLAGS2_METADATA_TPID_SFT		 16
> +	__le32 rx_cmp_cfa_code_errors_v2;
> +	#define RX_CMP_V					(1 << 0)
> +	#define RX_CMPL_ERRORS_MASK				(0x7fff << 1)
> +	 #define RX_CMPL_ERRORS_SFT				 1
> +	#define RX_CMPL_ERRORS_BUFFER_ERROR_MASK		(0x7 << 1)
> +	 #define RX_CMPL_ERRORS_BUFFER_ERROR_NO_BUFFER		 (0x0 << 1)
> +	 #define RX_CMPL_ERRORS_BUFFER_ERROR_DID_NOT_FIT	 (0x1 << 1)
> +	 #define RX_CMPL_ERRORS_BUFFER_ERROR_NOT_ON_CHIP	 (0x2 << 1)
> +	 #define RX_CMPL_ERRORS_BUFFER_ERROR_BAD_FORMAT		 (0x3 << 1)
> +	#define RX_CMPL_ERRORS_IP_CS_ERROR			(0x1 << 4)
> +	#define RX_CMPL_ERRORS_L4_CS_ERROR			(0x1 << 5)
> +	#define RX_CMPL_ERRORS_T_IP_CS_ERROR			(0x1 << 6)
> +	#define RX_CMPL_ERRORS_T_L4_CS_ERROR			(0x1 << 7)
> +	#define RX_CMPL_ERRORS_CRC_ERROR			(0x1 << 8)
> +	#define RX_CMPL_ERRORS_T_PKT_ERROR_MASK			(0x7 << 9)
> +	 #define RX_CMPL_ERRORS_T_PKT_ERROR_NO_ERROR		 (0x0 << 9)
> +	 #define RX_CMPL_ERRORS_T_PKT_ERROR_T_L3_BAD_VERSION	 (0x1 << 9)
> +	 #define RX_CMPL_ERRORS_T_PKT_ERROR_T_L3_BAD_HDR_LEN	 (0x2 << 9)
> +	 #define RX_CMPL_ERRORS_T_PKT_ERROR_TUNNEL_TOTAL_ERROR	 (0x3 << 9)
> +	 #define RX_CMPL_ERRORS_T_PKT_ERROR_T_IP_TOTAL_ERROR	 (0x4 << 9)
> +	 #define RX_CMPL_ERRORS_T_PKT_ERROR_T_UDP_TOTAL_ERROR	 (0x5 << 9)
> +	 #define RX_CMPL_ERRORS_T_PKT_ERROR_T_L3_BAD_TTL	 (0x6 << 9)
> +	#define RX_CMPL_ERRORS_PKT_ERROR_MASK			(0xf << 12)
> +	 #define RX_CMPL_ERRORS_PKT_ERROR_NO_ERROR		 (0x0 << 12)
> +	 #define RX_CMPL_ERRORS_PKT_ERROR_L3_BAD_VERSION	 (0x1 << 12)
> +	 #define RX_CMPL_ERRORS_PKT_ERROR_L3_BAD_HDR_LEN	 (0x2 << 12)
> +	 #define RX_CMPL_ERRORS_PKT_ERROR_L3_BAD_TTL		 (0x3 << 12)
> +	 #define RX_CMPL_ERRORS_PKT_ERROR_IP_TOTAL_ERROR	 (0x4 << 12)
> +	 #define RX_CMPL_ERRORS_PKT_ERROR_UDP_TOTAL_ERROR	 (0x5 << 12)
> +	 #define RX_CMPL_ERRORS_PKT_ERROR_L4_BAD_HDR_LEN	 (0x6 << 12)
> +	 #define RX_CMPL_ERRORS_PKT_ERROR_L4_BAD_HDR_LEN_TOO_SMALL (0x7 << 12)
> +	 #define RX_CMPL_ERRORS_PKT_ERROR_L4_BAD_OPT_LEN	 (0x8 << 12)
> +
> +	#define RX_CMPL_CFA_CODE_MASK				(0xffff << 16)
> +	 #define RX_CMPL_CFA_CODE_SFT				 16
> +	#define RX_CMPL_METADATA0_TCI_MASK			(0xffff << 16)
> +	#define RX_CMPL_METADATA0_VID_MASK			(0x0fff << 16)
> +	 #define RX_CMPL_METADATA0_SFT				 16
> +
> +	__le32 rx_cmp_timestamp;
> +};
> +
> +#define RX_CMP_L2_ERRORS						\
> +	cpu_to_le32(RX_CMPL_ERRORS_BUFFER_ERROR_MASK | RX_CMPL_ERRORS_CRC_ERROR)

defined twice

> +
> +#define RX_CMP_L4_CS_BITS						\
> +	(cpu_to_le32(RX_CMP_FLAGS2_L4_CS_CALC | RX_CMP_FLAGS2_T_L4_CS_CALC))
> +
> +#define RX_CMP_L4_CS_ERR_BITS						\
> +	(cpu_to_le32(RX_CMPL_ERRORS_L4_CS_ERROR | RX_CMPL_ERRORS_T_L4_CS_ERROR))
> +
> +#define RX_CMP_L4_CS_OK(rxcmp1)						\
> +	    (((rxcmp1)->rx_cmp_flags2 &	RX_CMP_L4_CS_BITS) &&		\
> +	     !((rxcmp1)->rx_cmp_cfa_code_errors_v2 & RX_CMP_L4_CS_ERR_BITS))
> +
> +#define RX_CMP_METADATA0_TCI(rxcmp1)					\
> +	((le32_to_cpu((rxcmp1)->rx_cmp_cfa_code_errors_v2) &		\
> +	  RX_CMPL_METADATA0_TCI_MASK) >> RX_CMPL_METADATA0_SFT)
> +
> +#define RX_CMP_ENCAP(rxcmp1)						\
> +	    ((le32_to_cpu((rxcmp1)->rx_cmp_flags2) &			\
> +	     RX_CMP_FLAGS2_T_L4_CS_CALC) >> 3)
> +
> +#define RX_CMP_V3_HASH_TYPE_LEGACY(rxcmp)				\
> +	((le32_to_cpu((rxcmp)->rx_cmp_misc_v1) &			\
> +	  RX_CMP_V3_RSS_EXT_OP_LEGACY) >> RX_CMP_V3_RSS_EXT_OP_LEGACY_SHIFT)
> +
> +#define RX_CMP_V3_HASH_TYPE_NEW(rxcmp)				\
> +	((le32_to_cpu((rxcmp)->rx_cmp_misc_v1) & RX_CMP_V3_RSS_EXT_OP_NEW) >>\
> +	 RX_CMP_V3_RSS_EXT_OP_NEW_SHIFT)
> +
> +#define RX_CMP_V3_HASH_TYPE(bd, rxcmp)				\
> +	(((bd)->rss_cap & BNGE_RSS_CAP_RSS_TCAM) ?		\
> +	  RX_CMP_V3_HASH_TYPE_NEW(rxcmp) :			\
> +	  RX_CMP_V3_HASH_TYPE_LEGACY(rxcmp))
> +
> +#define EXT_OP_INNER_4		0x0
> +#define EXT_OP_OUTER_4		0x2
> +#define EXT_OP_INNFL_3		0x8
> +#define EXT_OP_OUTFL_3		0xa
> +
> +#define RX_CMP_VLAN_VALID(rxcmp)				\
> +	((rxcmp)->rx_cmp_misc_v1 & cpu_to_le32(RX_CMP_METADATA1_VALID))
> +
> +#define RX_CMP_VLAN_TPID_SEL(rxcmp)				\
> +	(le32_to_cpu((rxcmp)->rx_cmp_misc_v1) & RX_CMP_METADATA1_TPID_SEL)
> +
> +#define RSS_PROFILE_ID_MASK	0x1f
> +
> +#define RX_CMP_HASH_TYPE(rxcmp)					\
> +	(((le32_to_cpu((rxcmp)->rx_cmp_misc_v1) & RX_CMP_RSS_HASH_TYPE) >>\
> +	  RX_CMP_RSS_HASH_TYPE_SHIFT) & RSS_PROFILE_ID_MASK)
> +
> +#define RX_CMP_L2_ERRORS						\
> +	cpu_to_le32(RX_CMPL_ERRORS_BUFFER_ERROR_MASK | RX_CMPL_ERRORS_CRC_ERROR)

redefine

> +
> +#define RX_CMP_HASH_VALID(rxcmp)				\
> +	((rxcmp)->rx_cmp_len_flags_type & cpu_to_le32(RX_CMP_FLAGS_RSS_VALID))
> +
> +#define HWRM_RING_ALLOC_TX	0x1
> +#define HWRM_RING_ALLOC_RX	0x2
> +#define HWRM_RING_ALLOC_AGG	0x4
> +#define HWRM_RING_ALLOC_CMPL	0x8
> +#define HWRM_RING_ALLOC_NQ	0x10
> +#endif /* _BNGE_HW_DEF_H_ */
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> index 8785bf57d82..d7149f098a5 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> @@ -21,6 +21,7 @@
>   #include "bnge_hwrm_lib.h"
>   #include "bnge_ethtool.h"
>   #include "bnge_rmem.h"
> +#include "bnge_txrx.h"
>   
>   #define BNGE_RING_TO_TC_OFF(bd, tx)	\
>   	((tx) % (bd)->tx_nr_rings_per_tc)
> @@ -857,6 +858,13 @@ u16 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr)
>   	return txr->tx_cpr->ring_struct.fw_ring_id;
>   }
>   
> +static void bnge_db_nq_arm(struct bnge_net *bn,
> +			   struct bnge_db_info *db, u32 idx)
> +{
> +	bnge_writeq(bn->bd, db->db_key64 | DBR_TYPE_NQ_ARM |
> +		    DB_RING_IDX(db, idx), db->doorbell);
> +}
> +
>   static void bnge_db_nq(struct bnge_net *bn, struct bnge_db_info *db, u32 idx)
>   {
>   	bnge_writeq(bn->bd, db->db_key64 | DBR_TYPE_NQ_MASK |
> @@ -879,12 +887,6 @@ static int bnge_cp_num_to_irq_num(struct bnge_net *bn, int n)
>   	return nqr->ring_struct.map_idx;
>   }
>   
> -static irqreturn_t bnge_msix(int irq, void *dev_instance)
> -{
> -	/* NAPI scheduling to be added in a future patch */
> -	return IRQ_HANDLED;
> -}
> -
>   static void bnge_init_nq_tree(struct bnge_net *bn)
>   {
>   	struct bnge_dev *bd = bn->bd;
> @@ -942,9 +944,8 @@ static u8 *__bnge_alloc_rx_frag(struct bnge_net *bn, dma_addr_t *mapping,
>   	return page_address(page) + offset;
>   }
>   
> -static int bnge_alloc_rx_data(struct bnge_net *bn,
> -			      struct bnge_rx_ring_info *rxr,
> -			      u16 prod, gfp_t gfp)
> +int bnge_alloc_rx_data(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
> +		       u16 prod, gfp_t gfp)
>   {
>   	struct bnge_sw_rx_bd *rx_buf = &rxr->rx_buf_ring[RING_RX(bn, prod)];
>   	struct rx_bd *rxbd;
> @@ -1756,6 +1757,78 @@ static int bnge_cfg_def_vnic(struct bnge_net *bn)
>   	return rc;
>   }
>   
> +static void bnge_disable_int(struct bnge_net *bn)
> +{
> +	struct bnge_dev *bd = bn->bd;
> +	int i;
> +
> +	if (!bn->bnapi)
> +		return;
> +
> +	for (i = 0; i < bd->nq_nr_rings; i++) {
> +		struct bnge_napi *bnapi = bn->bnapi[i];
> +		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
> +		struct bnge_ring_struct *ring = &nqr->ring_struct;
> +
> +		if (ring->fw_ring_id != INVALID_HW_RING_ID)
> +			bnge_db_nq(bn, &nqr->nq_db, nqr->nq_raw_cons);
> +	}
> +}
> +
> +static void bnge_disable_int_sync(struct bnge_net *bn)
> +{
> +	struct bnge_dev *bd = bn->bd;
> +	int i;
> +
> +	bnge_disable_int(bn);
> +	for (i = 0; i < bd->nq_nr_rings; i++) {
> +		int map_idx = bnge_cp_num_to_irq_num(bn, i);
> +
> +		synchronize_irq(bd->irq_tbl[map_idx].vector);
> +	}
> +}
> +
> +static void bnge_enable_int(struct bnge_net *bn)
> +{
> +	struct bnge_dev *bd = bn->bd;
> +	int i;
> +
> +	for (i = 0; i < bd->nq_nr_rings; i++) {
> +		struct bnge_napi *bnapi = bn->bnapi[i];
> +		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
> +
> +		bnge_db_nq_arm(bn, &nqr->nq_db, nqr->nq_raw_cons);
> +	}
> +}
> +
> +static void bnge_disable_napi(struct bnge_net *bn)
> +{
> +	struct bnge_dev *bd = bn->bd;
> +	int i;
> +
> +	if (test_and_set_bit(BNGE_STATE_NAPI_DISABLED, &bn->state))
> +		return;
> +
> +	for (i = 0; i < bd->nq_nr_rings; i++) {
> +		struct bnge_napi *bnapi = bn->bnapi[i];
> +
> +		napi_disable_locked(&bnapi->napi);
> +	}
> +}
> +
> +static void bnge_enable_napi(struct bnge_net *bn)
> +{
> +	struct bnge_dev *bd = bn->bd;
> +	int i;
> +
> +	clear_bit(BNGE_STATE_NAPI_DISABLED, &bn->state);
> +	for (i = 0; i < bd->nq_nr_rings; i++) {
> +		struct bnge_napi *bnapi = bn->bnapi[i];
> +
> +		napi_enable_locked(&bnapi->napi);
> +	}
> +}
> +
>   static void bnge_hwrm_vnic_free(struct bnge_net *bn)
>   {
>   	int i;
> @@ -1887,6 +1960,12 @@ static void bnge_hwrm_ring_free(struct bnge_net *bn, bool close_path)
>   		bnge_hwrm_rx_agg_ring_free(bn, &bn->rx_ring[i], close_path);
>   	}
>   
> +	/* The completion rings are about to be freed.  After that the
> +	 * IRQ doorbell will not work anymore.  So we need to disable
> +	 * IRQ here.
> +	 */
> +	bnge_disable_int_sync(bn);
> +
>   	for (i = 0; i < bd->nq_nr_rings; i++) {
>   		struct bnge_napi *bnapi = bn->bnapi[i];
>   		struct bnge_nq_ring_info *nqr;
> @@ -2086,16 +2165,6 @@ static int bnge_init_chip(struct bnge_net *bn)
>   	return rc;
>   }
>   
> -static int bnge_napi_poll(struct napi_struct *napi, int budget)
> -{
> -	int work_done = 0;
> -
> -	/* defer NAPI implementation to next patch series */
> -	napi_complete_done(napi, work_done);
> -
> -	return work_done;
> -}
> -
>   static void bnge_init_napi(struct bnge_net *bn)
>   {
>   	struct bnge_dev *bd = bn->bd;
> @@ -2194,6 +2263,8 @@ static int bnge_open_core(struct bnge_net *bn)
>   		goto err_free_irq;
>   	}
>   
> +	bnge_enable_napi(bn);
> +
>   	mutex_lock(&bd->link_lock);
>   	rc = bnge_update_phy_setting(bn);
>   	mutex_unlock(&bd->link_lock);
> @@ -2208,6 +2279,7 @@ static int bnge_open_core(struct bnge_net *bn)
>   
>   	set_bit(BNGE_STATE_OPEN, &bd->state);
>   
> +	bnge_enable_int(bn);
>   	/* Poll link status and check for SFP+ module status */
>   	mutex_lock(&bd->link_lock);
>   	bnge_get_port_module_status(bn);
> @@ -2254,6 +2326,7 @@ static void bnge_close_core(struct bnge_net *bn)
>   
>   	clear_bit(BNGE_STATE_OPEN, &bd->state);
>   	bnge_shutdown_nic(bn);
> +	bnge_disable_napi(bn);
>   	bnge_free_all_rings_bufs(bn);
>   	bnge_free_irq(bn);
>   	bnge_del_napi(bn);
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
> index b267f0b14c1..d13c0c52553 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
> @@ -9,6 +9,7 @@
>   #include <linux/refcount.h>
>   #include "bnge_db.h"
>   #include "bnge_link.h"
> +#include "bnge_hw_def.h"
>   
>   struct tx_bd {
>   	__le32 tx_bd_len_flags_type;
> @@ -174,10 +175,16 @@ enum {
>   #define RING_RX_AGG(bn, idx)	((idx) & (bn)->rx_agg_ring_mask)
>   #define NEXT_RX_AGG(idx)	((idx) + 1)
>   
> +#define BNGE_NQ_HDL_IDX_MASK	0x00ffffff
> +#define BNGE_NQ_HDL_TYPE_MASK	0xff000000
>   #define BNGE_NQ_HDL_TYPE_SHIFT	24
>   #define BNGE_NQ_HDL_TYPE_RX	0x00
>   #define BNGE_NQ_HDL_TYPE_TX	0x01
>   
> +#define BNGE_NQ_HDL_IDX(hdl)	((hdl) & BNGE_NQ_HDL_IDX_MASK)
> +#define BNGE_NQ_HDL_TYPE(hdl)	(((hdl) & BNGE_NQ_HDL_TYPE_MASK) >>	\
> +				 BNGE_NQ_HDL_TYPE_SHIFT)
> +
>   struct bnge_net {
>   	struct bnge_dev		*bd;
>   	struct net_device	*netdev;
> @@ -235,6 +242,9 @@ struct bnge_net {
>   	u32			stats_coal_ticks;
>   
>   	struct bnge_ethtool_link_info	eth_link_info;
> +
> +	unsigned long           state;
> +#define BNGE_STATE_NAPI_DISABLED	0
>   };
>   
>   #define BNGE_DEFAULT_RX_RING_SIZE	511
> @@ -281,9 +291,25 @@ void bnge_set_ring_params(struct bnge_dev *bd);
>   	     txr = (iter < BNGE_MAX_TXR_PER_NAPI - 1) ?	\
>   	     (bnapi)->tx_ring[++iter] : NULL)
>   
> +#define DB_EPOCH(db, idx)	(((idx) & (db)->db_epoch_mask) <<	\
> +				 ((db)->db_epoch_shift))
> +
> +#define DB_TOGGLE(tgl)		((tgl) << DBR_TOGGLE_SFT)
> +
> +#define DB_RING_IDX(db, idx)	(((idx) & (db)->db_ring_mask) |		\
> +				 DB_EPOCH(db, idx))
> +
>   #define BNGE_SET_NQ_HDL(cpr)						\
>   	(((cpr)->cp_ring_type << BNGE_NQ_HDL_TYPE_SHIFT) | (cpr)->cp_idx)
>   
> +#define BNGE_DB_NQ(db, idx)						\
> +	bnge_writeq(bd, (db)->db_key64 | DBR_TYPE_NQ | DB_RING_IDX(db, idx),\
> +		    (db)->doorbell)

no bd here, Pass bd as a macro argument.

> +
> +#define BNGE_DB_NQ_ARM(db, idx)					\
> +	bnge_writeq(bd, (db)->db_key64 | DBR_TYPE_NQ_ARM |	\
> +		    DB_RING_IDX(db, idx), (db)->doorbell)
> +
>   struct bnge_stats_mem {
>   	u64		*sw_stats;
>   	u64		*hw_masks;
> @@ -292,6 +318,25 @@ struct bnge_stats_mem {
>   	int		len;
>   };
>   
> +struct nqe_cn {
> +	__le16	type;
> +	#define NQ_CN_TYPE_MASK           0x3fUL
> +	#define NQ_CN_TYPE_SFT            0
> +	#define NQ_CN_TYPE_CQ_NOTIFICATION  0x30UL
> +	#define NQ_CN_TYPE_LAST            NQ_CN_TYPE_CQ_NOTIFICATION
> +	#define NQ_CN_TOGGLE_MASK         0xc0UL
> +	#define NQ_CN_TOGGLE_SFT          6
> +	__le16	reserved16;
> +	__le32	cq_handle_low;
> +	__le32	v;
> +	#define NQ_CN_V     0x1UL
> +	__le32	cq_handle_high;
> +};
> +
> +#define NQE_CN_TYPE(type)	((type) & NQ_CN_TYPE_MASK)
> +#define NQE_CN_TOGGLE(type)	(((type) & NQ_CN_TOGGLE_MASK) >>	\
> +				 NQ_CN_TOGGLE_SFT)
> +
>   struct bnge_cp_ring_info {
>   	struct bnge_napi	*bnapi;
>   	dma_addr_t		*desc_mapping;
> @@ -301,6 +346,10 @@ struct bnge_cp_ring_info {
>   	u8			cp_idx;
>   	u32			cp_raw_cons;
>   	struct bnge_db_info	cp_db;
> +	u8			had_work_done:1;
> +	u8			has_more_work:1;
> +	u8			had_nqe_notify:1;
> +	u8			toggle;
>   };
>   
>   struct bnge_nq_ring_info {
> @@ -313,8 +362,9 @@ struct bnge_nq_ring_info {
>   
>   	struct bnge_stats_mem	stats;
>   	u32			hw_stats_ctx_id;
> +	u8			has_more_work:1;
>   
> -	int				cp_ring_count;
> +	u16				cp_ring_count;
>   	struct bnge_cp_ring_info	*cp_ring_arr;
>   };
>   
> @@ -377,6 +427,12 @@ struct bnge_napi {
>   	struct bnge_nq_ring_info	nq_ring;
>   	struct bnge_rx_ring_info	*rx_ring;
>   	struct bnge_tx_ring_info	*tx_ring[BNGE_MAX_TXR_PER_NAPI];
> +	u8				events;
> +#define BNGE_RX_EVENT			1
> +#define BNGE_AGG_EVENT			2
> +#define BNGE_TX_EVENT			4
> +#define BNGE_REDIRECT_EVENT		8
> +#define BNGE_TX_CMP_EVENT		0x10
>   };
>   
>   #define INVALID_STATS_CTX_ID	-1
> @@ -455,4 +511,6 @@ struct bnge_l2_filter {
>   u16 bnge_cp_ring_for_rx(struct bnge_rx_ring_info *rxr);
>   u16 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr);
>   void bnge_fill_hw_rss_tbl(struct bnge_net *bn, struct bnge_vnic_info *vnic);
> +int bnge_alloc_rx_data(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
> +		       u16 prod, gfp_t gfp);
>   #endif /* _BNGE_NETDEV_H_ */
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
> new file mode 100644
> index 00000000000..f3e08064add
> --- /dev/null
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
> @@ -0,0 +1,83 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2025 Broadcom */
> +
> +#ifndef _BNGE_TXRX_H_
> +#define _BNGE_TXRX_H_
> +
> +#include <linux/bnxt/hsi.h>
> +#include "bnge_netdev.h"
> +
> +#define BNGE_MIN_PKT_SIZE	52
> +
> +#define TX_OPAQUE_IDX_MASK	0x0000ffff
> +#define TX_OPAQUE_BDS_MASK	0x00ff0000
> +#define TX_OPAQUE_BDS_SHIFT	16
> +#define TX_OPAQUE_RING_MASK	0xff000000
> +#define TX_OPAQUE_RING_SHIFT	24
> +
> +#define SET_TX_OPAQUE(bn, txr, idx, bds)				\
> +	(((txr)->tx_napi_idx << TX_OPAQUE_RING_SHIFT) |			\
> +	 ((bds) << TX_OPAQUE_BDS_SHIFT) | ((idx) & (bn)->tx_ring_mask))
> +
> +#define TX_OPAQUE_IDX(opq)	((opq) & TX_OPAQUE_IDX_MASK)
> +#define TX_OPAQUE_RING(opq)	(((opq) & TX_OPAQUE_RING_MASK) >>	\
> +				 TX_OPAQUE_RING_SHIFT)
> +#define TX_OPAQUE_BDS(opq)	(((opq) & TX_OPAQUE_BDS_MASK) >>	\
> +				 TX_OPAQUE_BDS_SHIFT)
> +#define TX_OPAQUE_PROD(bn, opq)	((TX_OPAQUE_IDX(opq) + TX_OPAQUE_BDS(opq)) &\
> +				 (bn)->tx_ring_mask)
> +
> +/* Minimum TX BDs for a TX packet with MAX_SKB_FRAGS + 1.  We need one extra
> + * BD because the first TX BD is always a long BD.
> + */
> +#define BNGE_MIN_TX_DESC_CNT		(MAX_SKB_FRAGS + 2)
> +
> +#define RX_RING(bn, x)	(((x) & (bn)->rx_ring_mask) >> (BNGE_PAGE_SHIFT - 4))
> +#define RX_AGG_RING(bn, x)	(((x) & (bn)->rx_agg_ring_mask) >>	\
> +				 (BNGE_PAGE_SHIFT - 4))
> +#define RX_IDX(x)	((x) & (RX_DESC_CNT - 1))
> +
> +#define TX_RING(bn, x)	(((x) & (bn)->tx_ring_mask) >> (BNGE_PAGE_SHIFT - 4))
> +#define TX_IDX(x)	((x) & (TX_DESC_CNT - 1))
> +
> +#define CP_RING(x)	(((x) & ~(CP_DESC_CNT - 1)) >> (BNGE_PAGE_SHIFT - 4))
> +#define CP_IDX(x)	((x) & (CP_DESC_CNT - 1))
> +
> +#define TX_CMP_VALID(txcmp, raw_cons)					\
> +	(!!((txcmp)->tx_cmp_errors_v & cpu_to_le32(TX_CMP_V)) ==	\
> +	 !((raw_cons) & bn->cp_bit))

same bn

> +
> +#define RX_CMP_VALID(rxcmp1, raw_cons)					\
> +	(!!((rxcmp1)->rx_cmp_cfa_code_errors_v2 & cpu_to_le32(RX_CMP_V)) ==\
> +	 !((raw_cons) & bn->cp_bit))
> +
> +#define RX_AGG_CMP_VALID(agg, raw_cons)				\
> +	(!!((agg)->rx_agg_cmp_v & cpu_to_le32(RX_AGG_CMP_V)) ==	\
> +	 !((raw_cons) & bn->cp_bit))
> +
> +#define NQ_CMP_VALID(nqcmp, raw_cons)				\
> +	(!!((nqcmp)->v & cpu_to_le32(NQ_CN_V)) == !((raw_cons) & bn->cp_bit))
> +
> +#define TX_CMP_TYPE(txcmp)					\
> +	(le32_to_cpu((txcmp)->tx_cmp_flags_type) & CMP_TYPE)
> +
> +#define RX_CMP_TYPE(rxcmp)					\
> +	(le32_to_cpu((rxcmp)->rx_cmp_len_flags_type) & RX_CMP_CMP_TYPE)
> +
> +#define RING_RX(bn, idx)	((idx) & (bn)->rx_ring_mask)
> +#define NEXT_RX(idx)		((idx) + 1)
> +
> +#define RING_RX_AGG(bn, idx)	((idx) & (bn)->rx_agg_ring_mask)
> +#define NEXT_RX_AGG(idx)	((idx) + 1)
> +
> +#define RING_TX(bn, idx)	((idx) & (bn)->tx_ring_mask)
> +#define NEXT_TX(idx)		((idx) + 1)
> +
> +#define ADV_RAW_CMP(idx, n)	((idx) + (n))
> +#define NEXT_RAW_CMP(idx)	ADV_RAW_CMP(idx, 1)
> +#define RING_CMP(bn, idx)	((idx) & (bn)->cp_ring_mask)
> +
> +irqreturn_t bnge_msix(int irq, void *dev_instance);
> +void bnge_reuse_rx_data(struct bnge_rx_ring_info *rxr, u16 cons, void *data);
> +int bnge_napi_poll(struct napi_struct *napi, int budget);
> +#endif /* _BNGE_TXRX_H_ */


Thanks,
Alok

