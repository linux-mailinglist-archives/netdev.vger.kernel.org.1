Return-Path: <netdev+bounces-194730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7415ACC28A
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657603A3B46
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 09:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD18F19AD89;
	Tue,  3 Jun 2025 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kRnoOfk+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UYXA6V60"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2353C49659;
	Tue,  3 Jun 2025 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748941462; cv=fail; b=gj1aEu8Qa9sGwhBZwAHC75wp+TPcKrPIdkfmb07gyK2vlujSJoF/AtK/sx9QfFZhUyfL+ftBXqYnYozPXi7eJso24YgKzTEe+5Gm9Oz82o9Em3IwKeT2/KL8fVv1lbvENabxErDpxkniLI5rJXKzq2xMzfEnsx/U0frMDr9Yph0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748941462; c=relaxed/simple;
	bh=KRtLH5xkV8KQetlC8T4Lga0lME9RkVpIhsBEWZLFYfE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZIvkUnxD28HioIpy8oVTdpUcGzMANnaLzwyIIxPl2hbkbf34Of0x/lff+r1hYsaWQ101vvGt0sM1akW3V1YgYwXWAWVMDtctpIphw97lo4AcUdQcyVs66Z1luQnIrNSd/B5VJMPuqaUIB7+Zgahc322zQL8/bZfKvT9dohLpNAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kRnoOfk+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UYXA6V60; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5537uCd8008104;
	Tue, 3 Jun 2025 09:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=O2kYJy0IOFHjYaXH8HaWn8CwMXSjw23C0E2ghdpql9Y=; b=
	kRnoOfk+3QA6kbEFlyQinBp0AhA4m6LeJ98oXiGWsJCigT+PnxVE0ZdfkmbrghsC
	zD7Vm1Qx0p8fFWU7HQf6I/tL62Nz6Pw18udU3n2YOEOkTrX3F17X3tb1nW1GPFRJ
	R3pxd8FsMZAYmvxeCgRdgzNT+nJhn3JReLT2MOgc1PgBEFWJ+SJXha4xwoVj9+7t
	mXHIU9fHCdrawyzCkGRxf+2P1keNCFmzNpwvHmmQyoe3XtS4QEXV0cU8zyVMiWnz
	eKUbR536PthQ25HTEMcO7vKUmZA4T6Adh/ssXxMX1UA4dkHo3vXlm7PPwJ31aqaN
	5bB6+GTE+1cyCtmoa3Dxgg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471gwh9b19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Jun 2025 09:04:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55380t15030625;
	Tue, 3 Jun 2025 09:04:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr791n19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Jun 2025 09:04:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZM3XlV0lhqDr8I6ujncz53Kk56EXVeMupEHVyapHOuYeZAoMVK3Y19rJXpTZHBEtGfltuWPnG70zzKUu8zVjFnvrHZie9mXz+t6K3xgACF0L5aP/ByZSEeXgpPufv1pvGd3r27aL3Tpegujq0BbpzauXt4I+VWouqrmCTW6PMaYfrc55zwpdVgRwUNv4QtEko23is0Kd28Gp6xQDXobaYqXsv6qJmirbVn2VE0uvZhF/9ZcFcptuxP2i3GXhIXiPu3BR9MAuL4B0AyGWMEXtiGKw2ifu+L/Vhnxdulkp9xhaxVrkZmSLzxBFdkPKqMcUDyXvNdCn4o5QQwQ1zamVsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2kYJy0IOFHjYaXH8HaWn8CwMXSjw23C0E2ghdpql9Y=;
 b=lBSgLOdmiVW4TwBZ2FKhpEZKVAWbLxaKZ+Zo8l7Cnl5Siv+qVgNKUUonOjVw84Sz1tA20B9HOBqqOa8gtcvtOKLnPpn2X42coGhm24UpImjn7pqekJg71fux4R4WGzcJZ2IHJwa0ptOLGMLgxeNqznVH4mTIykFOptqY/QVurKot3c6amjFf9XHUt9GGQcMzwZNgPhiEJ32q9Ltv3yRd8dIE/0iwqHEft5FjbOGsjvaQhtuEQpMSnbnzAKU3L7554f/ejMWkvMBx88Ano/oXZe15KKjoNgbliRUjfDh7u0Q3QDVkiImqorhVQXIWxYRaevA9AT+FBdsAwQEQPBTyww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2kYJy0IOFHjYaXH8HaWn8CwMXSjw23C0E2ghdpql9Y=;
 b=UYXA6V60EXIZVYw3hON9RktPrs426lRNJlytveFhuuTT9viwwupNHVd+9+5cYMdQrDlkxwJJ4C7hVtlhEa9T1HwV7XnLe3eux7MG6+74uBedAtWXKFQfoumClwFM++OQKMloRUo/5N2FK5Dcd7oQ36xmSVKTN4dl5IgKBOcaXrE=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by IA3PR10MB8420.namprd10.prod.outlook.com (2603:10b6:208:579::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Tue, 3 Jun
 2025 09:04:06 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 09:04:06 +0000
Message-ID: <abb065ab-1923-4154-8b79-f47a86a3d30e@oracle.com>
Date: Tue, 3 Jun 2025 14:33:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gve: add missing NULL check for
 gve_alloc_pending_packet() in TX DQO
To: Bailey Forrest <bcf@google.com>, Eric Dumazet <edumazet@google.com>
Cc: Mina Almasry <almasrymina@google.com>, joshwash@google.com,
        willemb@google.com, pkaligineedi@google.com, pabeni@redhat.com,
        kuba@kernel.org, jeroendb@google.com, hramamurthy@google.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, darren.kenny@oracle.com
References: <20250601193428.3388418-1-alok.a.tiwari@oracle.com>
 <CAHS8izOqWWdsEheAFSwOtzPM98ZudP7gKZMECWUhcU1NCLnwHA@mail.gmail.com>
 <cc05cbf5-0b59-4442-9585-9658d67f9059@oracle.com>
 <bf4f1e06-f692-43bf-9261-30585a1427d7@oracle.com>
 <CANn89iJS9UNvotxXx7f920-OnxLnJ2CjWSUtvaioOMqGKNJdRg@mail.gmail.com>
 <CANH7hM5O7aq=bMybUqgMf5MxgAZm29RvCTO_oSOfAn1efZnKhg@mail.gmail.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <CANH7hM5O7aq=bMybUqgMf5MxgAZm29RvCTO_oSOfAn1efZnKhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|IA3PR10MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d63289-d9f8-4494-25ff-08dda27d97b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekJ0VXhVMXZXSk1xVDRCRlg3NnZEeGVqUEthMEZFNkpWTjdkaFZFYWl3QURB?=
 =?utf-8?B?K1RwNnJkdjBTNjd3RTdiSllPMGZXaldrbXpOQ3lNQm42UVl4d3l0eHhvcEhD?=
 =?utf-8?B?OUlkWE1FaGlHdDZXU2lpWVExRk1icWZ5V3h4M1lXb01qbDJNNldVRHhpR2pG?=
 =?utf-8?B?K1hDMTZtKzMweFplNjJPK216RUttamZHQVROeVdGNC9pbVB1dFNOcHBMSlhR?=
 =?utf-8?B?M2dGa2lFUm8yZW1VUUNMbHRMTXlmaFdwcWJtREc1WTAvS1Y1ZHg2dm96Z2RG?=
 =?utf-8?B?RmdhUGhKTUM3dFBMOTM1NVMxNjBXaDlLNS9FNk9uUERyN0w1WmZQWmg2aVJD?=
 =?utf-8?B?OTBpc3BNRk4zZHZRSmNyZExhRVl5Z3VOTGpMakJ0TXpFN3pxOUxEenRMMmJu?=
 =?utf-8?B?cXduOWl1R214ZFFiY3NOOFlZa0xPejFlK0wrT1hIRFZEUUxLM3I5Q2JNeDl6?=
 =?utf-8?B?NUpiVjFiN2pDc1pZUW9qdDNXLzJ5aG5xaFlFMXo2T1VwQ1AyU2R4YVNyV1U4?=
 =?utf-8?B?NW52NHF6bHJCbnYrbUdXQVlTb3hsZzI2ajhITUFiekVNNVVYVkh1RnVDeHpM?=
 =?utf-8?B?cS9ROHhCMWdPdk9ITUwzdmRCcDZUYTY0VXpoYWJ0d0R4RUpzSTYxYTZwTmZX?=
 =?utf-8?B?U1d3OTNjY2RDZVRBMFdKaFJVQ2E3bEYrbW9HMDJuU2s3SXVsbDJrMlFYRjlo?=
 =?utf-8?B?MnpZYnZTYlpFbkNCbWtsRUJCUjRaenU2T3NBNG5BdnBMU3BzM2g3MzBMckhM?=
 =?utf-8?B?S2Rjb0YybERLYXM1SXI1bzRoR2xDWnF4elViRFEvWm1oWmx2dVNJQ3VpZ1Ar?=
 =?utf-8?B?TEhoOGRCc1lXeUMyRkFnV0t3MjI4ZkZsem04WTJVUC93Uk8zT1VBN1BXaGw1?=
 =?utf-8?B?S2l6OHQ0RmNjdlYyMDgvVjN0ZTdpenRuUHZ4V25Qc3VMZzlBRXRuL05OVGh2?=
 =?utf-8?B?d2EwT3hhN1ZaSTJQY2h5SnZwWVVUYll1Z1dWYTZhY25zRkNzZSs3SUgwWEk0?=
 =?utf-8?B?akI4NGtMOHFWRmRMeEE0aWhmYTk2Zktmb3loTGZBN0VjdGlid2x4YkNFbFI5?=
 =?utf-8?B?eE8yb0s5OU9Yc25pa0ZvLzM5RnZ2SytiZVhtS2xxbDRDT1lDK09mNVNkK0JC?=
 =?utf-8?B?eUpwRWl5Y3BPM3ZtcHZrWVA2OWljS2g1czRlTDExTjJJMldMbjU2V1VhT3lo?=
 =?utf-8?B?SzFCK29TM1ZTWUxtazdCTWxnYlR0TmZkb2I5dHFCeXp3VkpUTU5GZGVIbVdU?=
 =?utf-8?B?dXl3clFLMmJPaTZlTXB2QW9qSXdQMktVQ1R5eHBlRWI4V0tCSldrc3ZUT1hp?=
 =?utf-8?B?U0gzU0lTQ1V2dk1qQXBGc0hSV01ib3poZVk3aUY0eEx3aFNsKy9pbFM5WUVB?=
 =?utf-8?B?ZnlDMnFwOWQ2dEVUcDZmOFFjN3luTmk5LzlUMnhhZW93WG1QZGxNWGtFTmRI?=
 =?utf-8?B?MHZRR01WU2ZhVUhlSVdFa2d5dGRqeHZPOXFzY3Rzcm1CVjRacmJmSzN0cWVV?=
 =?utf-8?B?eHUxeW0yUi9tNDJROFJXZTNvc0hRMXNwcmRzem9LRkowMmk5b20xS3Z2Ukd3?=
 =?utf-8?B?bjhJUkl6TjI0N1ZtZFJRcUxIaDJURFNKcm1MUWtXQ01WQUFjUE1vSmsxUElh?=
 =?utf-8?B?eDA0a0NZSUVnMFRUVndtYkVScTI1OUsxV3YrS29TeDEwdHNSb2RiQ0MyODlK?=
 =?utf-8?B?T0ozOTBLdGxUSVVHTkhoeENwRTAyVUdUKzA0bHNibXJOVlpHbHduZmU5T3pz?=
 =?utf-8?B?QzY0bHFFK25BanUwdlhhOVI3ZlhvU05ZVjRYeWV2TGVVcFhrS1JrQkZ4Z2Rk?=
 =?utf-8?B?Smg2ZHppQUdIWGtpTHphZUNtV3AxSDBpZ2Y0M2VvQnZZd2ZxQlJSWUwrUldn?=
 =?utf-8?B?UjcrRUhDdkZoL1RxOW55TS8vN0NYNk9vOTJXVjBKK2FLMGk3Z0xTbmZBZ1BB?=
 =?utf-8?Q?HbTLr2gLwIM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VCtUMUhKMmc4dHJRVUVUUlgyNGEweUF5YVh1UXhPVDAwdTIyRjl3cWNRcFJn?=
 =?utf-8?B?c09HcDRDVFBjM1hnenpCWHd6aHB1alowR29NMWRPd0VnWlg2VlRaVEt0ZTcx?=
 =?utf-8?B?alVRRVdWRGlkZTgxODlKempnRnVKTGF4V0twaXh1UHY4aUhCcGdiQnIySFli?=
 =?utf-8?B?aTlHMU9zOG5ZN3ZPZ0UwbDlzeGdLM21jMVR0U0t6cnhvWHFudzdBaFRMYXNj?=
 =?utf-8?B?VXJ6c1NtK1kvejlkZS9sclVkZ3VDaGc3R3RpNWh2UWFxNk5QWjZRdmU5N3BH?=
 =?utf-8?B?cTIzT2RWVWIrcmVNYzIxbW94Y1pIeUZvVjN6bDV1ZUFheG1xc0hkNmpDejNE?=
 =?utf-8?B?UzJSTmNSU2JOM3d2NTRjTmx5L1RvQjFYeTY0bVpSL3FvZjZyL1ZWZTZkVmov?=
 =?utf-8?B?M3dOQlRUZWtWVVl1dHY2R1hwNnYwbUJHSDBSdHNKUmk5ZEltYW9aQ1RmZ2VW?=
 =?utf-8?B?R3paMlVJWW1yLzNTNHR5dkk2blJ3TExEY0FPOGE2WnB1T29wSE80N2NzNm1j?=
 =?utf-8?B?cHFYRFVKdjdOQzJWMEVaRWRQOXRXMjdFUHZ6WXZHUWtxZzEyK01TU1RwYjVC?=
 =?utf-8?B?bjB3SCtyZmJvSnoyTUVURTlucFdhNlNsTEZHdk1pSDk3WUV3ZS9VaXBsNFRG?=
 =?utf-8?B?N2Y3dURsUXMwZ0trVnVlcUVtWTh6VUxrTm14L21XWXByTTBoM2x4Sm1HMWRu?=
 =?utf-8?B?ZWFudFZMMHBlemI3S0dBSFl0UXN0OEh4YXZTK1NySnJtREVpTUE3bkE5M1ov?=
 =?utf-8?B?ZzJqZU1OcnRvYVRZcGc4bHN6YzRNTTFuckozTHZmT1RkaHh2S04rZjdGRUtV?=
 =?utf-8?B?bXJRa0RVc205eVdwK3R2cDJ1WWVFcjJmSXFHMDVDOU1nbmROV25ubTNkK0I3?=
 =?utf-8?B?dlpPRG5LbWQzQWdtV2dLbHAzRCtaY0pjcFJNVDlqaEo3TDJtV2ZQK0o5c25N?=
 =?utf-8?B?K3N3TEhjYUxnemxZUEEzamNkbTh1SEhJSHVRdlREamZPaytBZk9hRzZXVjA2?=
 =?utf-8?B?SDc1eVhiRk1HempoTytOM3lNTCtENmNtTldNRDdvc3NYNXZ0OTFoUEdTMU9F?=
 =?utf-8?B?SE5tNVdEWmI5VUg4SVFmQXhTM25JQXhvMGk0R1h2VkU3bzc1U09yVWowQno3?=
 =?utf-8?B?bk5ta3lnZm1lSGcrZjdTa1RZN1haZ1ovSHR3c2I0WkFYMlJZL2hhZEMrNlFa?=
 =?utf-8?B?cDdwQlF3U0lONVBYK3RlamtHYnlueFllb2hVbnBscnF4Nlk1TG5sNjVoc094?=
 =?utf-8?B?WFZvYVpwYTRlUTJpalJzNUVSZkRtK0xlMUw3SWNka2hDVFZPU0dHNzNCeExw?=
 =?utf-8?B?Rzd0d3NEdGozalZseEhiQnQwVzlsYlJ0a3ptc01Ybi8zV1BGTmI5cmhCaGNw?=
 =?utf-8?B?RjE4Mm04cUJmd0JTdDFDd3NrdW80MGNjcms2Mmp3MGxCWVU1Mk90RytMNmJF?=
 =?utf-8?B?STRyVGxxSDhlNWxNWmdSTnN0YUozZGpqUGxOc2hQNGp6TzBlb1QxbTVJeFIx?=
 =?utf-8?B?dTRPcDBQbHo3UkRZNGpmdjZkVDI5d1NzSDc4ZEQwWjNPSWh3TDhhNmtlOWVK?=
 =?utf-8?B?TDQxYWxjaHJPU1F1K1N5cDlQSmpiVENDOCt2Qy90eFpUR2VjRStwVExIZytO?=
 =?utf-8?B?UE5zWHZnRlhhaXFSc2QyT0hlWEprQmo3UUxzSTNFZGg4OTZpVDlBTHVEL1dj?=
 =?utf-8?B?M0t4WVVGM2ROeHlydGQ2aVozZlBKUEV4ZW1DQ3VxRXpSZDJIa0ZFdEtOMW0y?=
 =?utf-8?B?cTZSSm9xK2daeEZSSXFGd1F4bzBoQ1hyMG5vb0F1b1VEa1N6T0paU0kzOVFP?=
 =?utf-8?B?Tjdud0VlQTRXRHhmU2RzSmkrNmttM0lKRmtzL2xPYTh2YlpoQ1Jxd1o5SXo1?=
 =?utf-8?B?MnMzdlRVNWNBSlluVmlXMkx6dSsrU2plS2ZmbDdIdWlrcU0wWVppUDIyTzNh?=
 =?utf-8?B?ZjNpUTBUeVdmL1llS1J1T1NwZzF3ZzUzSFBDalVpYTlINUJENWpIOVJtSi9m?=
 =?utf-8?B?dUhLQmp4YXdzeERGTHdqSDdJOFRzb2NSdnV5b2h3Y1JVNmR4RnFmUXJZYytt?=
 =?utf-8?B?c00wWTlSWTZ2SnEzWGtSVWlLSmZlUVlKWjVLNjhVbWVNSXhtNHRBN3R3b1dB?=
 =?utf-8?B?RVJrTTkyY1NqRENoS3ppbkoyK0xsK0dOZW1LSUFhRWxDT1VNbHdmM2E3K2Y3?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GEqZKUcKM6+CdYsJOKNlzTL/l0Kd8NtvSAIWezPXzN3tnEseAHis7f99ERIRDs6QnNFLatLazLT9leoVh3EM8ikL4WEL5HWfJtF2cVAxvaMzCuxAJTruExSHW7jDcKgFd9tBMeaclrnlaS19fjYkWMSdj10fdZXL4t/XcBx98UtbfQ2ci6DR3ilTtRJ9oieCj00cfRhczcen6EXTEjpIa52UKg68ct8gHunhiw2Q6W5iZtW9ZWHzwNGqllsb/AwQ3KuHi6qTj74nbhohESF+NnVkRDAatKdO/K2umS2j5HgGnCg72/csxCTaOxE+if/X2sYpVjJ/TCv5WJ1xEo0pcxyoX5WWoIOD+GXdQO6wr6zNVo6veqvuxf4NEa6z+yPK55wd4bKuN08Q1cIhgSPIuiOngmoO5J9vQtldSK4dxZdG3K/OP3mz3L7QvTp+M9zozscjxqqi5iWpN27e1Ya6qFaVK6MJbNoRZcNPzgpKJOxcDvsle93bZyr5ky1dBFNyElWN2K3VA6lAbsc3oRcHyl4QtZl060q6J1A7/syAy/wVp/QM7Hp7lvvSID33xnU9+22kDL3GYsZ6qqXkJssd7IxZM/B/R43vvSMO37B2WQc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d63289-d9f8-4494-25ff-08dda27d97b7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 09:04:06.4181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vlu6oIvhgMeODpn/reNApfcs24oPPWl6NoGWqyHbom8vDkf5sJQIbkeHSmNWq7oly2B1is4Ktz6ogvpdMaH0ft89r1b8/FveWTfugMaPaLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8420
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506030078
X-Authority-Analysis: v=2.4 cv=Wu0rMcfv c=1 sm=1 tr=0 ts=683eba89 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=6fB-T6evCAH0wOkjOGMA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 cc=ntf awl=host:14714
X-Proofpoint-GUID: FGKk7eaqqFaGFuG5ekXKEUkMQULOWzcL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDA3OCBTYWx0ZWRfXyMw4eiogICW7 fLTreIRzCJh23gGYxfBP7xOe12prtsgoVrJqeNrmmvnTeD8VBLV7GK8gU94yxXgQ8saIHbY/TRa PtZf/VUVqvTvEE5xRyp8DpLtqhBeXDS+Lb7bN/NqljORkKDe1ua3rbro4bEebESWNPUuvMO2+O1
 nMVulgzsRMwSXrC+8f5X4YQra69qdJ9JcruT1eVVWZyytl9Zj8FSWcMLxPzSRLHk8uMvINBKC81 Vsn2FTjC5Ylg5m6NOwpJkrQbOcr5eKKLHOt3QO++9+4E7PwiGuVGBQbwS9L32KuvJjGJ7YJOIe0 7CswUNCk3/957/eD+i6hIl1RoZdAYXxqjziIR8tDI44Vvz+0tghJPwS9mzG58tJXaZz2AF3IZLv
 noJSIWxsH1V4LQTaCJYNEROgZvwkRHlmLjT7Qqvgt2bmwoqVUFAMhPHeP8Fx+4+62jtUkDcD
X-Proofpoint-ORIG-GUID: FGKk7eaqqFaGFuG5ekXKEUkMQULOWzcL

Hi Bailey,

On 03-06-2025 00:54, Bailey Forrest wrote:
> Hi Alok,
> 
> I think this patch isn't needed. gve_tx_add_skb_dqo() is only called
> after checking gve_maybe_stop_tx_dqo(), which checks that
> gve_alloc_pending_packet() will not return NULL.


Thank you for the clarification,

Even so, I felt it could be a bit misleading for developers and tools. 
But if you believe the patch isn't required,I completely understand.
In that case, I kindly request you to provide your NACK on the [PATCH 
net v2] mail thread for formal tracking,
so that other developers can also be aware of the reasoning and 
understand the context.

Appreciate your time and feedback!


Thanks,
Alok

