Return-Path: <netdev+bounces-237274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419A4C48365
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 18:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24F6426300
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86AB2868B5;
	Mon, 10 Nov 2025 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ngn+INxy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lITVp6YO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2DF2882AA;
	Mon, 10 Nov 2025 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762793656; cv=fail; b=fq1/3hgIw71AwVn/elAWuq75CYE0vfR7apgf+8o2tX2wv1EEh39ohjFnIhWFh0dioFzsWX2jAkik8R0oNERyw8y5tFtsvYKfirCV6KYpaYsI1EwSC6c6Jw2aBeEqOHlHApzBpf9TpPn/1rCNt5VbNdfmmAfQkrChFGa/go58CbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762793656; c=relaxed/simple;
	bh=CbapFkICUrN0E/VrXSLfXoueGhSyL9K5k8Tn4W8/gW8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eLJ8jSi2viVL9+CZ+6myVnx9P3LH7w+xuMHDIGfM7KnBxVrewoHxGmWP17UQkN9pLsH73OuLu/UIcQeB/lW+RWDhY/UM9MCOG+dqehgRpm11migvi8Dtr6x7qpbKkIW10uW/TAHorlQus4VDiDG3XFktTyAN/Qt/U29TGtLDS9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ngn+INxy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lITVp6YO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAGei13031236;
	Mon, 10 Nov 2025 16:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MJO2gwMuzLuvk/6Y9rlHvvuZU3frdqRnJ3CUccJn9eY=; b=
	Ngn+INxyl9Uhlv7cPFLW8OBJAkWZuznYsFM535hOb5L4Jax+Odh/bHWQeZNST1HO
	EmgiuJpitqhekHXOWciJXnnUnAC01bdHfiI7O3iULOiyKfO/Zp6mVwWQmb4KFe+u
	eXrFNhVJxOEvH6fwT5pTrNcfmFpsn5ivxSrBxWf9uiwlBMw5uNnDd9YeRNGEWphl
	G+QM71I/6P+gBU2E2Vpnbo3+7yP68rpIsNwEjv0M22ZGGMFQTSD7uDOQD0FQEK4F
	bzref0Kc1B1bcW/fzSL+ncJ6REGz0eeTO+F2ro76yp8RNTpmVn1RXbbTPsawXsTT
	1Hh0q3/r4Nwwt1A1IMSX9w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abks7g12b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 16:51:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAFlblA040013;
	Mon, 10 Nov 2025 16:51:53 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011031.outbound.protection.outlook.com [52.101.52.31])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va8d4rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 16:51:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6Oqr7l8ndWKlt+QT5kvLryw8aB5XtmvN8DRzLbxHGRrys1m1IyPrrQIE42vVGi5cA+wrr4TNI85WjW0nkLIa4L3ucZrZ+Og7XjH9yaxJgf9iGaqTA+xv1vgwd5DK10PhTrhBwXDtlm7BIGo7aEuOZVN85q8U55k7jifqenEeXK2W09FJDPynAeO9ovbhX9xbeN8obtz+lWUQhGJ1tmrtGnSg1JBVVf22TnYCzXDxxsp02ZjV1WZfD6aXvD6rtSyaQZKWKW2PwoZtRZ8CN4qstismYNp8Uy6mxLxydN5FNtdhKKFe6j7kaQwck0nAfNIAqHSPHmsBUbz6RA4LNUYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJO2gwMuzLuvk/6Y9rlHvvuZU3frdqRnJ3CUccJn9eY=;
 b=wP4vFZGPmXnwi16oILSAUJ7QTe3QR56gMEpajCzPsJi5GyZnBHBNmY9cTkgCkohkTAsc7rlJvCXKRftLMk2ASD5++d4HddTZTcEvu94q1fFdcr6JQccFL/1bLSnKw7f5JmaoJHHRSsqx9JNB65F66BTjRajVXvGrzNqFor/lYhAOCZNkQaTdlkYWSTOa25WJJArj5KK9/FeiGytHgBCKMd8Fdpu+OsPbiR9i3guokUh13i8cqjAJ7kh3B4qbEmIHomsDS5BlCeBMA7fRWwGxHdCMi+OVAzazxb53iLx9nFTVxX/HcWBwa6AGUjTLMK58UBRODnwXksjwoqSWX1SHYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJO2gwMuzLuvk/6Y9rlHvvuZU3frdqRnJ3CUccJn9eY=;
 b=lITVp6YOJg8BOixU/dK4UOLEHoanuQJuFqjDyBAwFbCL+ZVLi+WWB+peT5urvCtN0kPNJ57FX5j7yyF22u9mBkvQCmYyqypTqd4W9R2cUdNtgAPZIzIcMifi9DoK7GeH9Bv5VgfmilqPOmI7FJm+TLlSg0cWL/kjYWMPvmd3Gks=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DM6PR10MB4137.namprd10.prod.outlook.com (2603:10b6:5:217::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 16:51:49 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9253.017; Mon, 10 Nov 2025
 16:51:49 +0000
Message-ID: <a29c40ff-7209-4b60-a17f-2aab09318dc1@oracle.com>
Date: Mon, 10 Nov 2025 22:21:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH net-next v4 1/3] net: ti: icssm-prueth: Adds
 helper functions to configure and maintain FDB
To: Parvathi Pudi <parvathi@couthit.com>, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, danishanwar@ti.com, rogerq@kernel.org,
        pmohan@couthit.com, basharath@couthit.com, afd@ti.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, pratheesh@ti.com,
        j-rameshbabu@ti.com, vigneshr@ti.com, praneeth@ti.com, srk@ti.com,
        rogerq@ti.com, krishna@couthit.com, mohan@couthit.com
References: <20251110125539.31052-1-parvathi@couthit.com>
 <20251110125539.31052-2-parvathi@couthit.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20251110125539.31052-2-parvathi@couthit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::15) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DM6PR10MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: ca9e2e64-2791-4bf5-c576-08de20797130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTRNRzR0Z0pZQThJWXJsVDVlRmI4aERUV3NJb01zRTlyblUvMjZxOTJ1TzFR?=
 =?utf-8?B?MHlURG1jM2dWM29RT0NFVnJvbmYxT2V6cUhQcVV2b0N0dVlkMGZJa1hjS09x?=
 =?utf-8?B?aWl2dzU1dzJ5MW1WWUMrWDZGVUhQUUUyaTNxZmVtS1N6WmxSdGs3a2orbmI3?=
 =?utf-8?B?M1o2N1pxTE5kRGk0c2ZraEExS3pVbDlPckxwVUk2UnBVZ0YyR2hZQm03YmtG?=
 =?utf-8?B?M29BLzBzZndjY3VCUXErdHdwMnZ1VXB5aFhUQTlPWEowUzYwRFFiWUVaVnAr?=
 =?utf-8?B?SitvMUZTdkpjMnhJUU4zNVBRcVlSV3BpTTd5YTlYL0lqT2dMZGFnZDAxTnp3?=
 =?utf-8?B?ZjRzdUhOdFpZenhMS1d0Z0lEYXRtRUNTN1c1bmEzNmRvN1N0YjlIaHpCbUZM?=
 =?utf-8?B?cEowZmUwL0x6WnJVVWV1ZnY0aGw5ZFpvSkk0czZ6OWU3QUZxbkVEMFZuUU5M?=
 =?utf-8?B?WXZhT1g1MlBVQ2ExdjhoWlMzSjZHYm04YkRvZWtGZlhhbFZpaHVydkF6SFl0?=
 =?utf-8?B?eFh6cWsrcTdLcitieU94ejc1bTZsb0VKTnhSdE1BdHpBZjAzZHNFV3lqanRh?=
 =?utf-8?B?YmZvT3BIVm8vQU1Kdk9JSDRnWVBQM2hpU0QyWFF5Vk9MN2dXdnVoVTBaanNh?=
 =?utf-8?B?VkN4ME8ySllKeFFnT2dNd0FZU1d0aEZHMXRGZWVOYUprU3kwZVJEV0lGREt3?=
 =?utf-8?B?eDBIa3RLdEFGL1owVWI5MkhpWnRqMkhQTU1HL2ZtbHNUaU5jdHlyUit3WU1l?=
 =?utf-8?B?OVliTVV3cVJad3psMUxPaEliZUl2WkZPQTRlMnNaeGNidkVmWmlDbk1pMWhm?=
 =?utf-8?B?Q3paWUxXSENnS2pYOWxxcFZkT3ZvNEhmYkdES3hQTEdpTkhSNHIreXdBRW0z?=
 =?utf-8?B?L3A1WmtYckw5Y0FKMFNOd0FIQTFld05yT25lYk5vY0s3WGU5MzJSVnNqTUxo?=
 =?utf-8?B?RXFESmVjMkFGUFBYN3UrUllqTlJpWklFVjNoQUdzcVdTdUptTUpUM3AyRnFw?=
 =?utf-8?B?SUJRa1BEaElHY1hkRlpkVk1LRTBXMmpHbDFheU1KbmFpRUtVVldnaVBkZXZF?=
 =?utf-8?B?V3EyV1lxc0Y5NmhzSE5IcER0aEUzRHN0UGVsN2tQa1p6Y3k0alBLWVJDWHlm?=
 =?utf-8?B?YTBhNzZ1R0ZiUWMvSlFVT3lGd3ZrSTZwM2NTaDE2ZFhxV210NUFiSjl6Q2Vm?=
 =?utf-8?B?VVMyeUp4enpaTHJFekFRL3FDTkQwN2tRNzNRcVZGdGd5TVdXTzcrWTN1UzBl?=
 =?utf-8?B?eGowT0VzcEExM05uMVk1Kzk5ZDB0bW0vM2FVWno3dDQ1c0F1SlRkNCtZSmZW?=
 =?utf-8?B?Z2RRK2w1UmlyVVBSSjg2V2llUnFRZlh6TDIxMWlhTHlPd1Q0UjRSeTNWeDN3?=
 =?utf-8?B?UXJFd1JlWHgybHJ5Y1NMSk9sakptcDc5VGd2UkpVV0VaMHZrSkZMUTlZYWNa?=
 =?utf-8?B?Y2dSZ3NRZ2tybkJ3M09SN21hckFSTk9ZUDRRNDRFVkp4c3BQVUZkUGF1RW84?=
 =?utf-8?B?ZVBHNktsMTBSb25XMkhRNEQxVTdOaEI5akFpdmowTXp0NDg3dUVtS3ByU0Qr?=
 =?utf-8?B?U2lSRVdURklHdE1Oa1RMUW9OZTFrOTJsTXF5NUhDQ2VrRXlWVFg3eElSUldv?=
 =?utf-8?B?aTAxUDdUcUdDb3lYN0RYUm8vZ0lHeW5sSGVHa2dNRlE2THNwaytBaEtHd2U4?=
 =?utf-8?B?MCtta1FtYmNBUkRoRnhZWFh5OG1yTVhnU2NzcXptZ1hGalIwY1BsNmcrckMr?=
 =?utf-8?B?MUlDcWJVK3dPUXdEVWoxMjRhbTRGUURiRm1IdzdVdFdUS0lyVm9UZmU5bHNj?=
 =?utf-8?B?eUNlT1JFSDlSZjFXVGlPQXBGY2R2MWI0R1pGVGFNRWRPVVNpbEo2YkFJTEsw?=
 =?utf-8?B?NU4vbjJmMGZZRGRUNDcwRGU5enVnOXRCU20rRmNNTGNYV3YwUzErMStOMVlH?=
 =?utf-8?B?d05uclNhcENDZDB0UjdTNzhrNUdnS1JOdWlXWkhYcHpoT1lMdG84eWkvTXpO?=
 =?utf-8?Q?9J/oUnM3KSukIOdDXtBTu6AYwxRFMQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUpBWmFPamxVR012aFJxSlFsenJrYlRhWFJEQmk5OW0yeXVyMnlhR2Y3ZEl0?=
 =?utf-8?B?bjRwcE9MbWs2QzlaWStZNi9wZ1o2dHFLQTZ0UHduRTREelhkSG1KbEE3RFVZ?=
 =?utf-8?B?UWN1bnFaSG5XSjcvdC9VbDBJejBOV29yRkM5Y29PaGErUjBlSUcvL0pzejhQ?=
 =?utf-8?B?ZHVvdHJpUVZJNysrZi8ralhiTmp1VzlEYkM5VXJnV0hHODlsL3BQbWh2TUpP?=
 =?utf-8?B?U1h0VnJJckdpWE1WYWFWOHBOa1RaUEZzUzBHVGRxSjNGOU5KWEhtT2p5bHdK?=
 =?utf-8?B?dkRBU05iN2d6ZktmdFhEdzNuOTNTeGhWMUNlQmVkMVFrc3QweVJidllmb2Na?=
 =?utf-8?B?UTlOQU16Qy9TeHpLcHVySzU3dlhPN05YSytpRkpmTmVPekwrYjE0dWJ4ZzV6?=
 =?utf-8?B?Q3lId2xzQWF4ZjRiZlF5N0Z2ck55bUo1dXFYQkR4MW9ibjlzTVkrVTF2U2h3?=
 =?utf-8?B?N3NqSnFvelIvekRnQjFRYmlBa0Y5UEZ2SzJIKzY2M2hCdDFLdkwvdkpGeGFV?=
 =?utf-8?B?NWw0bVlrU1lrS1hkUkVSaW9wTzhBR3hyc01vMzV0VnpMVTQ3L2FjcG5UM3Ex?=
 =?utf-8?B?bjFhNmVNUGl0YkRweVY4MEswQXJXNlhOaUlGZXBkcGZYVnkwK0Q2OGg4NFZT?=
 =?utf-8?B?L29FT1ZKMy9pOGwvRVdUQ0hZL0R6VGpQQndFajFleG82YXdpb01TemFwZkVI?=
 =?utf-8?B?aE54amZMTHpmNyswS01vczBnN1E1ZUhmdmgzZEJNbFhnNHY1VkQxNTZ3UFdT?=
 =?utf-8?B?WEJsS0lBQUF3eDg0c0dHQUJZUVkwbGhBejNDVEE2eVkvSkpJMmgrdnJSUHNJ?=
 =?utf-8?B?Z2hsYnlsaVJzVUZNMjAvdDk3ZVF2ZkZrNzhUT1Mvb00vcWphK2VoVXdjQ28y?=
 =?utf-8?B?ZGtlTU5mNnlWTnFuSUtLYTlIUWhlcEJZUDZTcDVMQ0dpTFdUclBDSEVIeUNk?=
 =?utf-8?B?WGVKUG5rQWM4ajVYdk0vT05RRFZ5VzgzU1VhUEgvanhBak5yM3VqakNoaFJN?=
 =?utf-8?B?cXlzbnIrYnI0YWRHWW1nYXNKd1RtV0M2eUtYNzIycFlGWnNKTnVad25YaWhs?=
 =?utf-8?B?V3d3UDRrZUE0bEFzaS9weTJkdytNQldTa1gzaWJaWGxwMlE3d0laSlE5Z2w3?=
 =?utf-8?B?UitDbW1TeFFrQnBRU0NXOEh6MmVwN0xpRDd3SW4rRlRVY1NBWis4bG5ORFdu?=
 =?utf-8?B?R2xBaS96c3dkODhJeHpaazlMZHg2dlM5Z1FiM2o0S1hHZnIranl5QTVGa3Z0?=
 =?utf-8?B?Unk5WlFlN3hXeVcxdzhtRGowQ3ByaExRSkZ2NTZ3WXBMZjlTck93Z3dkVXMv?=
 =?utf-8?B?WENhUTliNVBHanpJaStzNEVaOEJtV0lJS29zUjZjd0thNVdzbUQxZnRNdExM?=
 =?utf-8?B?NjBXVUJHWXRzTTBWUkhoK1ZpZ2hmdnNQVHlnbHNWS05Kb0RPSXNJcksrUzNw?=
 =?utf-8?B?bDEraVBvZUFRTnBSNDFJeEUzamJxL2JtekVwc2c2N1cydkhIdnlla3k3SGFQ?=
 =?utf-8?B?ODJwNTk3RWllb01qc1BxRlZLM0szeFlmazZDSmpyZWFMclBFWWE4Q3lBRFFq?=
 =?utf-8?B?OFhmOHh2SWtWN1YyRXBVWDk2bGZaYXNkNGZPaGtvM0hvbm1ZOFpVRGJVVnlC?=
 =?utf-8?B?QkEyT1FqRmlVd0FBenRERUJVUk1XK1ZCc0hITExkSzV3eUhRUDd2aHJGWUxF?=
 =?utf-8?B?VnQ0Wmc5cTlUTXQ1eWU4ZUEzQ25lN3FqTUR3UXF2NmlDTXdOQzN4N24wWVZ6?=
 =?utf-8?B?REVHQ3BKbnZ0bnlBWmRHWDNYcThWcTZJcjhGU0laeUlqRUVuWHJEWkJvVER3?=
 =?utf-8?B?MThybVVUK1B0SXorbHZNYlNMcGNhdmFMOWZmMS9XdTBEVUFxRWpYWVVMRXBN?=
 =?utf-8?B?OTE5aWZTY25FLy91WTdBbVFwRmdreE92UnhYVXh4cnF6dU1uYmNweEpDSm1v?=
 =?utf-8?B?UkRYQnhoL0ZxUER1L0RXczlVYk11MGhFUVArV0MzUnhUbFNkOGhNMExIbFZ2?=
 =?utf-8?B?V3ZWcUsxMi9lVnBoMWVua3JTNXZRWnl5NTFPN2tlL1UrQVZkWU1ITC9GbjlZ?=
 =?utf-8?B?c2J3ejJRU244UkV1TlRRd3MrNDQvdXJhaDVFVTA5RlpZek53NjBuUUFBYXlU?=
 =?utf-8?B?MUNva0pEd0syVndBUHVoeEJORjNlcGdhSlhydDBram9TS0NsdnozS0tsT09k?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E3Nv9dHOdL4zbWNHr7ZtDDpqrzefOrupJmNuGLQLCQvWuJBsbb/9w4VUSKKsZGSXEaoWj23rebd5X0BLNWK34n5kOeE6WKfXNMvDYstNtJKhLR/ADdnIzbwYai6tAjDbWePdyri2BV6k1e86jzGP64rg7pa9fjmvuTHcZ/XfR9oBSIzAVa4Rl20C0m1NFWikuBaFew5rEXiiOxGNUQTKuYA8jnoXIcTh49IkVohL0X9Kd9G6C2vrKBPiwvTNgH4ubXDFiBOW7GIJufYXOjUsZ1b8SxdghzOI0RamtMeaEYIEL8BmEYFdmRxLl93VlbBkrvirfImx36zWmwHDS/t57XMmpqCRkiBnMJMmLFeyP96QYrVSgXncbQ/uAQ9HKFSmo9BsdZurckVNUIPtG8ftPjc+uohQzxYC1ehFgDKdXUUCt3OyOFFiB1GQQ6Knpn+yGd8oZMvLXoyHdf9jqZ59+kaSvGpZzrYHfdR7KNna7WRPZKuTGvh6YfhqdI0mPNgyjrj+nCRm3xrM8CM/FcZ7U9Lq1hTUpa8Ui2GGbpAqeCwOpU3NQig2nVAjFvrfq/bbjAkg6xZMXIjPYvd1F3MK0OUYna08kAtEU2rsXRTJL1M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9e2e64-2791-4bf5-c576-08de20797130
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 16:51:49.7687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UE0uIuVXQaEm1yfLmiu0jFBIFt7HNkM94ZwPkPj6ujqx2zVYEAVJxis/ZIDvMwIUQVkUAROv/awuIfmyWyadgdKf8wipTGASmZTlLlkZ2aQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4137
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100142
X-Proofpoint-GUID: GxT5dcBBBD3UIXpihg-Gm5ZaZ8tI5v5u
X-Authority-Analysis: v=2.4 cv=L7cQguT8 c=1 sm=1 tr=0 ts=6912182a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=sg61sOus1j_vrEyYoUEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0MSBTYWx0ZWRfX8RJIVlB5hcfc
 mWAYmjdNFBKYBuNVnlE/ncK5z75iX8UYJcC4OlhLk/Dc8wKXY0HwSFJoKfV8wxKL7IiRaSVqEpB
 gmr0Q1jgTq4zPUT5f45oVYvzjgt4+MZOaoHPxqvDs6NQxkqI/4JEwiQZgLObFzkwW8juZhWapXl
 eUISpM+TmtoiCPodBKZjv1NCnLTEMOFfjQlNgQQDMbYvesyPBcOXJ6pE2wd15kQDSAaP169qvZ4
 7c4kLRixgLcTb5uOi8MV0VNFn6okLgpwgzz26RpEHSd5RwcAL8s/2rIeQnI6+V4YroU5VTffpA/
 6Qhmt4r6oHlnCDoQyVabf7vpKlgLkNLBN1UHYFPcq9mEpYwLHa55aOXjiYGC/4baIrhAh3pBVQS
 va03EXuxc6cm60JFKy5J0iXKV3TQLA==
X-Proofpoint-ORIG-GUID: GxT5dcBBBD3UIXpihg-Gm5ZaZ8tI5v5u


> +static int icssm_prueth_sw_insert_fdb_entry(struct prueth_emac *emac,
> +					    const u8 *mac, u8 is_static)
> +{
> +	struct fdb_index_tbl_entry __iomem *bucket_info;
> +	struct fdb_mac_tbl_entry __iomem *mac_info;
> +	struct prueth *prueth = emac->prueth;
> +	struct prueth_emac *other_emac;
> +	enum prueth_port other_port_id;
> +	u8 hash_val, mac_tbl_idx;
> +	struct fdb_tbl *fdb;
> +	u8 flags;
> +	u16 val;
> +	s16 ret;
> +	int err;
> +
> +	fdb = prueth->fdb_tbl;
> +	other_port_id = (emac->port_id == PRUETH_PORT_MII0) ?
> +			 PRUETH_PORT_MII1 : PRUETH_PORT_MII0;
> +
> +	other_emac = prueth->emac[other_port_id - 1];
> +
> +	if (fdb->total_entries == FDB_MAC_TBL_MAX_ENTRIES)
> +		return -ENOMEM;
> +
> +	if (ether_addr_equal(mac, emac->mac_addr) ||
> +	    ether_addr_equal(mac, other_emac->mac_addr)) {
> +		/* Don't insert fdb of own mac addr */
> +		return -EINVAL;
> +	}
> +
> +	/* Get the bucket that the mac belongs to */
> +	hash_val = icssm_prueth_sw_fdb_hash(mac);
> +	bucket_info = FDB_IDX_TBL_ENTRY(hash_val);
> +
> +	if (!readw(&bucket_info->bucket_entries)) {
> +		mac_tbl_idx = icssm_prueth_sw_fdb_find_open_slot(fdb);
> +		writew(mac_tbl_idx, &bucket_info->bucket_idx);
> +	}
> +
> +	ret = icssm_prueth_sw_find_fdb_insert(fdb, prueth, bucket_info, mac,
> +					      emac->port_id - 1);
> +	if (ret < 0)
> +		/* mac is already in fdb table */
> +		return 0;
> +
> +	mac_tbl_idx = ret;

If ret == -1 mac_tbl_idx wraps to 255 silently.

> +
> +	err = icssm_prueth_sw_fdb_spin_lock(fdb);
> +	if (err) {
> +		dev_err(prueth->dev, "PRU lock timeout %d\n", ret);

wrong var ret print.
return ret or err here ?

> +		return ret;
> +	}
> +
> +	mac_info = icssm_prueth_sw_find_free_mac(prueth, bucket_info,
> +						 mac_tbl_idx, NULL,
> +						 mac);
> +	if (!mac_info) {
> +		/* Should not happen */
> +		dev_warn(prueth->dev, "OUT of FDB MEM\n");
> +		return -ENOMEM;
> +	}
> +
> +	memcpy_toio(mac_info->mac, mac, ETH_ALEN);
> +	writew(0, &mac_info->age);
> +	writeb(emac->port_id - 1, &mac_info->port);
> +
> +	flags = readb(&mac_info->flags);
> +	if (is_static)
> +		flags |= FLAG_IS_STATIC;
> +	else
> +		flags &= ~FLAG_IS_STATIC;
> +
> +	/* bit 1 - active */
> +	flags |= FLAG_ACTIVE;
> +	writeb(flags, &mac_info->flags);
> +
> +	val = readw(&bucket_info->bucket_entries);
> +	val++;
> +	writew(val, &bucket_info->bucket_entries);
> +
> +	fdb->total_entries++;
> +
> +	icssm_prueth_sw_fdb_spin_unlock(fdb);
> +
> +	dev_dbg(prueth->dev, "added fdb: %pM port=%d total_entries=%u\n",
> +		mac, emac->port_id, fdb->total_entries);
> +
> +	return 0;
> +}
> +
> +static int icssm_prueth_sw_delete_fdb_entry(struct prueth_emac *emac,
> +					    const u8 *mac, u8 is_static)
> +{
> +	struct fdb_index_tbl_entry __iomem *bucket_info;
> +	struct fdb_mac_tbl_entry __iomem *mac_info;
> +	struct fdb_mac_tbl_array __iomem *mt;
> +	u8 hash_val, mac_tbl_idx;
> +	u16 idx, entries, val;
> +	struct prueth *prueth;
> +	s16 ret, left, right;
> +	struct fdb_tbl *fdb;
> +	u8 flags;
> +	int err;
> +
> +	prueth = emac->prueth;
> +	fdb = prueth->fdb_tbl;
> +	mt = fdb->mac_tbl_a;
> +
> +	if (fdb->total_entries == 0)
> +		return 0;
> +
> +	/* Get the bucket that the mac belongs to */
> +	hash_val = icssm_prueth_sw_fdb_hash(mac);
> +	bucket_info = FDB_IDX_TBL_ENTRY(hash_val);
> +
> +	ret = icssm_prueth_sw_fdb_search(mt, bucket_info, mac);
> +	if (ret < 0)
> +		return ret;
> +
> +	mac_tbl_idx = ret;
> +	mac_info = FDB_MAC_TBL_ENTRY(mac_tbl_idx);
> +
> +	err = icssm_prueth_sw_fdb_spin_lock(fdb);
> +	if (err) {
> +		dev_err(prueth->dev, "PRU lock timeout %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Shift all elements in bucket to the left. No need to
> +	 * update index table since only shifting within bucket.
> +	 */
> +	left = mac_tbl_idx;
> +	idx = readw(&bucket_info->bucket_idx);
> +	entries = readw(&bucket_info->bucket_entries);
> +	right = idx + entries - 1;
> +	icssm_prueth_sw_fdb_move_range_left(prueth, left, right);
> +
> +	/* Remove end of bucket from table */
> +	mac_info = FDB_MAC_TBL_ENTRY(right);
> +	flags = readb(&mac_info->flags);
> +	/* active = 0 */
> +	flags &= ~FLAG_ACTIVE;
> +	writeb(flags, &mac_info->flags);
> +	val = readw(&bucket_info->bucket_entries);
> +	val--;
> +	writew(val, &bucket_info->bucket_entries);
> +	fdb->total_entries--;
> +
> +	icssm_prueth_sw_fdb_spin_unlock(fdb);
> +
> +	dev_dbg(prueth->dev, "del fdb: %pM total_entries=%u\n",
> +		mac, fdb->total_entries);
> +
> +	return 0;
> +}
> +
> +int icssm_prueth_sw_do_purge_fdb(struct prueth_emac *emac)
> +{
> +	struct fdb_index_tbl_entry __iomem *bucket_info;
> +	struct prueth *prueth = emac->prueth;
> +	struct fdb_tbl *fdb;
> +	u8 hash_val, flags;
> +	u8 mac[ETH_ALEN];
> +	u16 val;
> +
> +	int ret;
> +	s16 i;
> +
> +	fdb = prueth->fdb_tbl;
> +	if (fdb->total_entries == 0)
> +		return 0;
> +
> +	ret = icssm_prueth_sw_fdb_spin_lock(fdb);
> +	if (ret) {
> +		dev_err(prueth->dev, "PRU lock timeout %d\n", ret);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < FDB_MAC_TBL_MAX_ENTRIES; i++) {
> +		flags = readb(&fdb->mac_tbl_a->mac_tbl_entry[i].flags);
> +		if ((flags & FLAG_ACTIVE) && !(flags & FLAG_IS_STATIC)) {
> +			/* Get the bucket that the mac belongs to */
> +			memcpy_fromio(mac, FDB_MAC_TBL_ENTRY(i)->mac,
> +				      ETH_ALEN);
> +			hash_val = icssm_prueth_sw_fdb_hash(mac);
> +			bucket_info = FDB_IDX_TBL_ENTRY(hash_val);
> +			flags &= ~FLAG_ACTIVE;
> +			writeb(flags,
> +			       &fdb->mac_tbl_a->mac_tbl_entry[i].flags);
> +			val = readw(&bucket_info->bucket_entries);
> +			val--;
> +			writew(val, &bucket_info->bucket_entries);
> +			fdb->total_entries--;
> +		}
> +	}
> +
> +	icssm_prueth_sw_fdb_spin_unlock(fdb);

\n

> +	return 0;
> +}
> +
> +int icssm_prueth_sw_init_fdb_table(struct prueth *prueth)
> +{
> +	if (prueth->emac_configured)
> +		return 0;
> +
> +	prueth->fdb_tbl = kmalloc(sizeof(*prueth->fdb_tbl), GFP_KERNEL);
> +	if (!prueth->fdb_tbl)
> +		return -ENOMEM;
> +
> +	icssm_prueth_sw_fdb_tbl_init(prueth);
> +
> +	return 0;
> +}

Thanks,
Alok

