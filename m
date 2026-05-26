Return-Path: <netdev+bounces-291563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CN1BZRHFWqLUAcAu9opvQ
	(envelope-from <netdev+bounces-291563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:11:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE855D186E
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 283673036777
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 07:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EFD3C4B76;
	Tue, 26 May 2026 07:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DSp6HRjm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bkcDr/WS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8865D3AB47B;
	Tue, 26 May 2026 07:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779779379; cv=fail; b=HOD/dBp41ErL6K5Df1azY9N8mwQIioa5oJ7UCO9WlSPKAIQtX6/GIQuMRjIlg76GgUvSWV1MxsoueKV7AVkh9THNn72TeMjqkSraXvIsgI0wqzwiFT4Q63ymasV81xZkb7G1IVGkk3RhO1DTf6+hvcjA7wge5lWMIyDToiXvx5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779779379; c=relaxed/simple;
	bh=dQJ+u752MqM2fANPh8Oq/nTmgemJ8kEBHuO+ZmSDJc4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z9yRIw3R+AaNuPJaI83Io3vFixb80/fOa2ko6+sVePs4Gfw+wBoebsadv0+IZUeA4saps2YGnKu9HCsy48eCRtPVjbstIkMTGFq9FPcsesQENAeNLf0HuQ1m0m5Djx3jreSerhnfThR8J6itTUTeXNtcuhXqW57BZjTk7ici2J0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DSp6HRjm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bkcDr/WS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PNlmlP3090428;
	Tue, 26 May 2026 07:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=B/GmHROUwKyT1dQBAg20oAvOZ92QwE7ODj7UNhqnX5Q=; b=
	DSp6HRjmHwCRPQjhJ5fG+iZH+dZWJ+dahVug+E0nNWoHO6Ch9wrM/MqwcuNU9l/Y
	gB+eDZGSchXQPrPK89DHJqUx/1Dy2Hc4eepicA6tqcgt6YZxG4qBoPKQqSA8Akg0
	o99BfDGLjjxlsOGUbWx6qHCl3GDTxVDuFtTjpQ6TzqNY6q3RUPD9QeCRNok4vMFY
	kmyT9UgqYnzB8DeMznBNc+8Ceaaly77Xidb36E++9cJs66XaY+0oKBxGmb4Yh613
	H9jdE9LDQSqQqpSmYZx2i0RkpY9kbv/l1TqjXPEM4H20885ACzzAGG25ARfOIwf0
	ixpmOyHD9cKvIBs9j8gr6Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eb4sq36ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 07:09:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64Q74pNj036213;
	Tue, 26 May 2026 07:09:21 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ec08mu2ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 07:09:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irPGGe6Vr8z5/Ycc21QXVmIGzDDkIXiuRvuUfR+zi2g2WtTgIxBx+3XM46AzxLbSxVzvwW1G+yYhpyNDZYp294TR/LfKsvZcmMrbCvqdf4JXlMu/wzlAKkfN8Z7cOghBzMo9Mjz2vNpLEEcJ3K/xO7lKKkvZrPG813Shv0uOqVRzRncqJNSyoX9Qh91TLtk6jRVfFFhykOebh7stkwmuitt7CqpBXUpa404zbajZLmv9QVLjVkdhYnKYIpWTWiRQgn7a7MedEwU9ab/zmEwznQzayd90q0h7ULcQUTfL0Y3yQuYs8X/kQv6sJF5JYtN5JNZpsm478g3VRNfwZngMxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/GmHROUwKyT1dQBAg20oAvOZ92QwE7ODj7UNhqnX5Q=;
 b=RBW0StkItmRm+QEOqmlbkB5Jp0wWLZCKzkCZpDmasjLwU2ZlSvsMA78b/6FbON+b+2/dlBmG2lygoKibT/hpHyUYUA0wt2ZsGah2eAUe+WwHKk61nNpfjnF7ry6XmAnfmkZDQ/K7ZIOoEo8VPOHBugPHHa12L2ILl2KX5hyw900skRgJy9bTrJYOEQY4aDuqCnpon6UzJJ6rLTp9hL2LiWGpUu906uyFwaSNP+NdiJNIwoAiTMoj+8QngfW1AudNOeU7WU5+VoGeyKtrkFrx2WLoQZr/JWWkbQT08WX4vN6sJ5cz6efZ22CXtkdDOl2KqH7fggwXew8hBgqq0pRz8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/GmHROUwKyT1dQBAg20oAvOZ92QwE7ODj7UNhqnX5Q=;
 b=bkcDr/WSnfrbfCR4OqfN2XHaWvPeGCXwxb6vc+pGN5lEAsCtklSVlLHXi17QpNz+N8O/pF2VDc2ioqKf9ulGPSNKDj3UuwyGX0ZRV+/AB3yizMmMRXkujMoMkpxN8X/IIoCM0TKaH1ympsnVkQNtbHEk7Ps6R8zOVszYVKFmmuc=
Received: from IA0PR10MB7667.namprd10.prod.outlook.com (2603:10b6:208:48a::13)
 by SJ0PR10MB4654.namprd10.prod.outlook.com (2603:10b6:a03:2d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 07:09:18 +0000
Received: from IA0PR10MB7667.namprd10.prod.outlook.com
 ([fe80::d970:9174:bcc4:9b75]) by IA0PR10MB7667.namprd10.prod.outlook.com
 ([fe80::d970:9174:bcc4:9b75%4]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 07:09:18 +0000
Message-ID: <1db5457b-53db-425d-b001-f3fa93a763ea@oracle.com>
Date: Tue, 26 May 2026 12:39:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: tg3: guard napi_disable and
 pci_disable_device calls
To: Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Yury Murashka <yurypm@arista.com>
Cc: mchan@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAPzpGcTMARhkcdt46bV=nWWx+AD5dX2ztWCEEx_4y2V=D-1THg@mail.gmail.com>
 <CALs4sv3D5n7pciO_1G+XjxNi-YSdM98t2hTHVM7b=c4Dpa06ng@mail.gmail.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <CALs4sv3D5n7pciO_1G+XjxNi-YSdM98t2hTHVM7b=c4Dpa06ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::16) To IA0PR10MB7667.namprd10.prod.outlook.com
 (2603:10b6:208:48a::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7667:EE_|SJ0PR10MB4654:EE_
X-MS-Office365-Filtering-Correlation-Id: ffbc8d64-d459-40c0-b894-08debaf5b3c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6RV+PYMChLbCKFFEQl5KcWVUnR51ZIgrYzlBjz3sfH+4Ph6zgTx+9kfPcwcWOS0rs99i4oMyk6aAkK2eT77uLIGjx7c1hf/YU9YZYqjA1wmfH96waVEhStjR0h3HlGnnIMVjP92k/E5BxPTsxziBwMvBDc22c9fTtHjJVBOXMf/SLZ72+oKfgg+L2ejSE3i0xa0nNXbmIVaQOm/TTmYDLGysAp/xhFqVkWo/FMwDOOGAInIMlmU1YDv7sgjnaYQaHzZizZymzDN6QyqrY/eMljBhFDuVrx07cWKK/2ahR8z3Bh0CSfUCzzERZOVamasGO12OMPeau3/RUtjINfwTkQFElkJLw7oDGbmnRlF3umup5BWYwcPQ/fdwmjluWizVpB2IwGg62GJNArKVusAvhPFP+PrPd+Na6lQpr2zn6vfXiq3oYdm1tAlUtxQbYLdudjclMKUFpjdfPGvYn3ClHWaC2X8rOPTGdQavy6l/qTpmciltmBeQOrWJNzUuOAZ9za5sbSf8EH3hgITmVr8t9YH8yFNLt7lssgikLr9b8VcOmWrrfyN7bkApleQOnQ1mQlTtB2uEZRf9QVJ5qD1utn608hCVtlbO6TuXKwBbAhMMUMnO222L2bTqXfRH2pv/KF4mNkhOwuYm0oKl0kfQiG0GXx2779zYqcRO0HPC3zOTvnGjyH8kpTVfmR54mnVH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7667.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzNnVEU0bTV4ZTdGZUFKTkZYc1N6ZzVvRHBnbTlydVZxczBqcmhHdHBWMU9G?=
 =?utf-8?B?U3ZlS2lBeGtSRW1oWFRPaVdxSUhWcTY4YXJwQWlaeXczTnVWZkhhaHRmc1l5?=
 =?utf-8?B?NmJWZXFQaDRGRjMrRjVINjhKcXJleXJkdzMvSG8zLytZcGxiVjVtMHpIRzBs?=
 =?utf-8?B?bVpDQ3pSVDdkYm1Vd0dqWXlYSTVpdXF6dTRFM1JFYlo4YWhrYXkzNFU0MWdo?=
 =?utf-8?B?eThnUEpWcDVxbjhUMTdXa3VzZ3d6K3JzRk9aTzRtQWt2Tmd4WkZYUU0vL08v?=
 =?utf-8?B?ZVlhdzBNQlh6czdCaWVlWTAwVUdzZG5SQ1lJMkVaRmYwaGpVREVuM3MxcGcw?=
 =?utf-8?B?eERaK0xtWFVRMDBsQ1RaRTEvNU9RTkFVQ3M5QXV4TmhORDJiVlhQQ1NLY1dK?=
 =?utf-8?B?SkhNWEZhb1FZc3RmNUVJT3BGdmhLYVA5M3c0aDlBU0t5Rzc0cnZKVEtOTjZu?=
 =?utf-8?B?MnFUVUtpVXg0blJuckN2eEZjL3FnMytUaTZKRVVGdlJBRmFSMmFoRFZ2UUVt?=
 =?utf-8?B?cGx1RjNtLzc4eHhlMkt3c0lpODhrZVdaakpoN1o1RHdBUTdZeUNOMnFzYm4r?=
 =?utf-8?B?T0FVRnVwM1hsNG85b2VkTGZUZy92cXUzVG1UYWtPbTI1dmxOMGhobVhyY25Q?=
 =?utf-8?B?NmtXOEN5MmZkdFBWOGpZSHJTM1VwaTRKVnhWNnBhVGp4Qk5CMzAxeFFYSjdv?=
 =?utf-8?B?MTFCcXdqeE5SZkk3MG96VEcvWXJ5M09ubFRBNFFFUzdZTGdiZ25GVmo1TWpO?=
 =?utf-8?B?eFZLWEhia0RWcXgzQ2YxSWNqeXY4NEJLZVN2cjhFYllKbWZCRm5WLzdyU1Bq?=
 =?utf-8?B?M1hESXcvN3J4d2JxNFFCYkY3c2tSTjdyVEtuZGg2akFWMkc3SDVDUFJBMjRF?=
 =?utf-8?B?Sm1Pc2hqVFJDVHA0SFZNN1RtbFcvMGY4R1Z3UmZraXMyaFY3Z1ZXVmZNb1Zu?=
 =?utf-8?B?MlZ6QzI4Q3RuZit1UXh6eVZBeVNZanY3NnJLT2lEblkrZmFmQ2toNjZNWVpy?=
 =?utf-8?B?MGxQMVdtVCtSNGNPRUhnRDNpOEVNU2NxdFo5L1VGTWViU2pDTDN6b1Z1WGlM?=
 =?utf-8?B?Q2ovQkRidVNCaGdkSzhaNDZGNE9tbitVd1hUQVduY1E2TEtEZzBDSkZnazdt?=
 =?utf-8?B?Wm1kMnN3SDdlV2tIV0gxb21xcEVoZnBCWmgzQnN4RHhhWWhpdm9EZjVmTEJX?=
 =?utf-8?B?WWxicU5ZQmNCL3NRUktWM2VFQlBEN2F1ejREOEFNZUdLUm5LZytpV3J2U0Nl?=
 =?utf-8?B?VDhKY2EzR2hQd0lhOUZzU0dReDFMVnZtOUI0UXJlNVJabCtJL2ZDR2sxYzhp?=
 =?utf-8?B?OVZ0eDBmeHo4Z2lmRk9XTUpINVZSUGtVTkNqSHo3eUFXL2xnMWxkcSsycCta?=
 =?utf-8?B?UkxVYW9aMjRwRkJyMWhGcDRiZGp1Z1NZOWU3NTRrS01Veld0eEhuaEZRdytM?=
 =?utf-8?B?cXVyelYxTHZmNTRYUGFiTHIvWHliNUdhQWxsdU1jR3E4aVg5M1ZnUXdoK3I2?=
 =?utf-8?B?Nk5ldUtSdHhyTWd4THA1R0xXQmhlbkl5M01HTThBaStSNHRnWC9jczFFeU44?=
 =?utf-8?B?eXNvblhsTmIwVjFDdU13ZGJmbyszOElXNUVDaUVGUmFjUlFRUHY2emlDYVJy?=
 =?utf-8?B?RjNKUnBCVUtoOWordzF5ZElHcDA0a1FWSU51NUUyRWVUZTM3Q05CYXJTWi9R?=
 =?utf-8?B?S3VsZCtrZ2ZkWmpnNVBqWVpwTEZ1OTF4NXhXRlNHMmlaVzB2MUp3OU13bVFG?=
 =?utf-8?B?ZlpJNHFYa1pMTEViRnhoaEF6RE9pakpocWN0aUVHQ0VhTFV5VnQyWFZjTXFW?=
 =?utf-8?B?WVhKdFdpcjJHOEwxZC94NkRjMmlxZnBnaEF6Y1RWWEJsNlA4U3Vmbm9uR25P?=
 =?utf-8?B?UVVsVGlsVUdRalg1cGNpV3BXSjdqb3JKWUNRcHFHbG10Nlh1U24vY3hZVU5u?=
 =?utf-8?B?aExIdldpUXl4OE5CeGlUOGE5L2l4SmF3aTdub0lBTzhQTi9GR20rL2VpM0tN?=
 =?utf-8?B?TFNkZTNFaXNJbnpqbzkzakVqZzRSclFPUXUxSkhVOFE3N2czSldXeU5ISlVJ?=
 =?utf-8?B?akxicG1hMWZQRTZJTFArVjgrV3RDVXFmbE1Tc09GVTI1QmlkdXF6NStsVVRp?=
 =?utf-8?B?VUVjOUNGNmtkUUszaHpHeWNLSW9UMlBzSTBjQlp5UUNWZERlZk9jeE1ydlQv?=
 =?utf-8?B?YUxZTFF5RGFESUtxbDBvUCt4S2hjNmlCVFFpMTNGRlhUVjZwNkk5b0ZXcERp?=
 =?utf-8?B?Z1BrRlFOS055UjI0djRiUnhTdFFsVVNES01LT3BZYjUzOThaVXR4NlZEaEVz?=
 =?utf-8?B?ejZhV3BBa2x4M3pCZGZ3ZTgyZ3NkME1Zc1pFdFJ0WDJCN1drMlltUEFIMWU1?=
 =?utf-8?Q?soBFQlzm39FZ1ugE=3D?=
X-Exchange-RoutingPolicyChecked:
	XhycV03CCXUU0XF3mq/p8lqE6zf+O5tKWKkofKxvECNeemywKWcT2lrgHkheTfVJNfkNGXl9KKqetcS6CW/Ll+tCOexnFkSSDE3zNVuXQLudw4CJST8xMer7OosZYGZUjGemhXVYz29lvW4cVDEN3oWMe6m7nK/9NuMaieASPVkE+pJIle6r+aFU6X3VW7XYYG9tZ+J6BX8VMY/t0T5kJqbSr8DWm90rGgf7ACfHY2W+6VJrYprPflLU3P9pIMty9mMX53NgTSX/DMZB/jibH0tQntj2Mis6lRWV2wMUX4nQCIoGSxrgPbDPYd8v43a130bOLZRENDOsF9fuGGCE9A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8w8jfMokCW4+F3bQ1hO1PLgeTR06G9yn32jc080uf5BABWiJrUWqtW3Ig29eAHr/1qYEpnohYcJ/3mns/DnuS4edvN6eV28vMDOdWyTSetj4bZHMSrV6qcyXoWEeAbY9CkXYM1Am+Ay6H9kOJmx1ImtKB2S9cq0R46apie3iq8st/H817B09Mmp7uc3+cldfcWVXK5mmx3AxMktNMw6iobY9n8w08EuP67DI6XEBBQuXBKGm788O+ezzwzD8+Vm4nPw/eznEVca5akWDLgz0Rnxa6KVPhklHBYJW+jBvrUOmoghBWnJmXFPK763Cg1hVPX3Tvvva9oZ6Ofmi6k3BtAStZZK3BgVGfCnJdH1f2xrSHQ3QDjpVTt1WvmLJGWFN2bL0Thqr5mDUHdoUD1K+falvFj6rP6RSLtE7MfTE97mWoOVrVPDe9F7se7FUPV30POwQwsWw8TaV+mwUwALrLSE13dxEXJietnf4BsJpqWPdG3e7daP63owVxQKgUbMhj1d0R76wesVSpfQPKGK78Me9dtBLUYrjxon00qbivtiX47M5T5sWCFR6S6KlMQPuvZelCJfAA9QhHVgVCMDg431t8i7DzE5YYCWbqa1mtrw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbc8d64-d459-40c0-b894-08debaf5b3c3
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7667.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:09:18.1121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjhg8raqxdqNe/+XWMhd4oAC9yDg4I5OsY94sh4nLnGczXMbc1EOeuaypSkSji+1Z8Ip04ZUYs44kXABEEifCchYmFzHiYmlxGpLCXw7HA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605260060
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA2MCBTYWx0ZWRfX2P0lWmJV1vp4
 jZSsN+nGeu3t+xmczAYI2DF0OjhCSONELu3EGOkpKe7lYBNUhWd1E+Y8d+54tZC+4CoKr2rblW8
 L+HnQIQY4U20Cm46RPy1aWcUdIxMHtwmVb918VV+60Fz719T46mv2Is0jm7vaqKFGUWHB6zLlvy
 ScMOMwvpKgaLsyaXFx8TfKDlnVmsXhoIdTEycGIKI9qw5WMytxkkEE9rXypD22KpctCmStzMGun
 xoM3j6NcQX7UwILqC/QBcEVQcimJLv19pE4FerRnUucJACsotTLNS2aACzO8Nmi/OURhr+7xKt0
 l91zMP8IrT4LttyJ7OBQwZ2PqlLUjtxHmdh44D3JvvpJQHp0lHtgbGXejkKbG8XCBUOp+InBtXV
 MRkofgnSEt76NnFSx/npMkyDLfKEhYgfEd0+/eStORC9j0x6jrAqc0fdqZjfoeq0LgH4KZg2rQG
 YmuJrXM8wmQ7dbX/IXMlh0nH/vJ3bk0cg3nJ/7yg=
X-Authority-Analysis: v=2.4 cv=eNYjSnp1 c=1 sm=1 tr=0 ts=6a154722 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=n2GhSfulAAAA:8
 a=Q-fNiiVtAAAA:8 a=I6audKnBLOTdyUneZYkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=9NqWk_7B-uqI6kdQTXIl:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12300
X-Proofpoint-ORIG-GUID: JWiy_u-Pw3mKeygaUT3IotYrMnrTOUOC
X-Proofpoint-GUID: JWiy_u-Pw3mKeygaUT3IotYrMnrTOUOC
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291563-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,broadcom.com:email,oracle.onmicrosoft.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6BE855D186E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/26/2026 9:07 AM, Pavan Chebbi wrote:
> On Mon, May 25, 2026 at 3:19 PM Yury Murashka <yurypm@arista.com> wrote:
>>
>> During PCIe hot-plug events, uncorrectable errors can be reported and
>> AER recovery for the tg3 device is initiated by the AER kernel driver.
>> The tg3_io_error_detected function is the AER error recovery handler.
>>
>>  From tg3_io_error_detected, we call tg3_netif_stop->tg3_napi_disable->
>> napi_disable and return PCI_ERS_RESULT_NEED_RESET on non-fatal error.
>> We expect that during AER recovery tg3_io_slot_reset and tg3_io_resume
>> will be called. But AER error recovery can fail. For example, when one
>> of PCIe devices on the same bus reports PCI_ERS_RESULT_NO_AER_DRIVER.
>> As a result, tg3_io_slot_reset and tg3_io_resume are not called, PCIe
>> device is disabled and NAPI is disabled (pci_disable_device and
>> napi_disable are called from tg3_io_error_detected). Then we can try to
>> disable PCIe link and napi_disable will be called again:
>>
>>    napi_disable+0x1b/0x1b0
>>    tg3_napi_disable+0x89/0xa0 [tg3]
>>    tg3_netif_stop+0x37/0xe3 [tg3]
>>    tg3_stop+0x30/0x160 [tg3]
>>    tg3_close+0x2a/0x60 [tg3]
>>    __dev_close_many+0xad/0x130
>>    dev_close_many+0xb2/0x190
>>    unregister_netdevice_many_notify+0x19d/0xa00
>>    unregister_netdevice_queue+0xf8/0x140
>>    unregister_netdev+0x1c/0x30
>>    tg3_remove_one+0xaa/0x150 [tg3]
>>    pci_device_remove+0x42/0xb0
>>    device_release_driver_internal+0x19c/0x200
>>    pci_stop_bus_device+0x85/0xb0
>>    pci_stop_bus_device+0x2c/0xb0
>>    pci_stop_bus_device+0x2c/0xb0
>>    pci_stop_and_remove_bus_device+0x12/0x20
>>    pciehp_unconfigure_device+0x9f/0x160
>>    pciehp_disable_slot+0x67/0x100
>>    pciehp_handle_presence_or_link_change+0x77/0x350
>>
>> This is not expected by napi_disable and a thread can be locked in
>> napi_disable forever. We have pcierr_recovery to cover a similar issue,
>> but for fatal errors. We cannot reuse this flag because it is reset in
>> tg3_io_resume, but it is not called when AER recovery fails.
>>
>> Similarly, if an AER error is reported and tg3_io_error_detected calls
>> pci_disable_device, a subsequent device removal via tg3_remove_one or
>> tg3_shutdown will call pci_disable_device again for the already-disabled
>> device.
>>
>> Add a napi_enabled flag to struct tg3 to track whether napi_enable has
>> been called. Guard tg3_napi_disable() so it returns early if NAPI was
>> not previously enabled. Also guard pci_disable_device() calls in
>> tg3_remove_one() and tg3_shutdown() with pci_is_enabled() to avoid
>> disabling an already-disabled device.
>>
>> Fixes: b45aa2f6192e ("tg3: Add EEH support")
>> Signed-off-by: Yury Murashka <yurypm@arista.com>
>> ---
>>   drivers/net/ethernet/broadcom/tg3.c | 14 ++++++++++++--
>>   drivers/net/ethernet/broadcom/tg3.h |  1 +
>>   2 files changed, 13 insertions(+), 2 deletions(-)
>>
> 
> LGTM.
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> nit: The revision-change log for the patch is missing..

It seems this patch addresses two separate issues in the AER recovery flow:

NAPI enable/disable state handling
PCI device enabled/disabled state handling

Would it make sense to split this into two patches?

Thanks,
Alok


