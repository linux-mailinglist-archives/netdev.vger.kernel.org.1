Return-Path: <netdev+bounces-290616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDwzL5BzD2r4MQYAu9opvQ
	(envelope-from <netdev+bounces-290616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 23:05:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FE15AC020
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 23:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29D1D3037BCB
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 21:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF7432C92D;
	Thu, 21 May 2026 21:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gNptqgbu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eOy9rRSk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DE2330D28;
	Thu, 21 May 2026 21:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779397381; cv=fail; b=gSy83rna1L0wvoP5Ed4k3aL34Ob9AaVNzegQObcfjlu1wXyTR/F0Eq6nE5D0omHa3Qh2pNl3m9FHJoo34Zsp//GQIdEOi1ecqSzivEOsD3QlvA8qRKgdTqtLFQ3kfakEEp+IxXFNdvzTQ+AabBFUkF9Sw/PEi++h1Vb3uYBTf5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779397381; c=relaxed/simple;
	bh=dgDDRoEsMJdOHL4Hz6TLovA/xhboGDwYJiM0cf6/tWo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k86m3gTrEllif6fyShtm8cUbCKokrfBDMW3Z4g8eZuWCpDKOzqR9RS2X/DLuiznbnIx2JTV9WV+qIC6bxUpZTq7Jze5XXLZ8UAduHY4u+LFAbkIvzJz55pCu1HMHS1Q4z8f3rjNuu+DpZdp7kPTd0Bq7SWTN44LfdeMlspUs0oQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gNptqgbu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eOy9rRSk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LJfVbO3300693;
	Thu, 21 May 2026 21:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7DZAAzIJEHCUGIbMdE5ehjx5vP+wnBcyTDT9skwyFvs=; b=
	gNptqgbugQZZ4iog9qFT8/qENvsbQkGKugDCq9P41s4t3weL0QtRSC+6IvjtGkXL
	s+fnATyp203ZyXb+4TW5HUOUV3WKCFX8pd+7NWc1A1pRZ8ncvRixYoer0TP2D/sF
	COAKzw5evybyMz5QaQA1r8HEnVj7f+AzTKTuWcQDN8hKG8zjEBbbPN/gCRWHgp+2
	CQK/AWUnapg4ISsJbEWhPVwm8L6b1ue8vJOLn2Z8WiV22krbXRJpHu7A4ldQXxvh
	WZzskw0NVBfE4n3SWHLqlQ22mXGzUIp+u+M54gONHfxVDeLp8OaI8hC2mUg0vAxC
	aRAQaQnaEA0pz274usuDow==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h2shw27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 21:02:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64LKxl8H022602;
	Thu, 21 May 2026 21:02:52 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e84efne2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 21:02:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZrXIYOAoc4NBITr2k5QFLLlfXjkQaWsOJc1UrsmrquXEzcKl/vJjFn0u0fLrVZ+aNJe3OHDUXW1k01mQDc7B7wK7JeitXUpjDhHIgswSZKKHrRFKTbvLNnm/7/OdhwmHa5i6+muTQFbFTxwoeKmbO63fkVf7X7XHEP5QnE6cbsgbh5hEsRfwnLV5taarKBRbV1Bdp5wc7rrgAnT9fza6wdxzSDAjLDz81QIQGizmUFKQ7wEvELQQIcDqfGc1R78qwN7YeAoapDoK+UUaTjcMVyUXvLe1Ipa+W23vviXeCsieUzQ8hhXPKPovQz8vvbRlM006MFmh6NbbAdyfhDCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DZAAzIJEHCUGIbMdE5ehjx5vP+wnBcyTDT9skwyFvs=;
 b=OXi3fxg3buE9sdqd5i7mmyKrDMjnk8y8Xwf7m7JC5islIfhePKxMH52kWiFhJn4o7w+9I7Y+8cwgdiVGNEaob7MOqPCCEdB1rzelGWRfORAymEv/Eq1C1x6m28qSE9J9kvYnFbloS4XcwAWhEbYocWmmGLLpF1m0ugkyPzfXqGs6XcjQxU4FzYsqLBPu14YA6P7ezaBim0WEfXzzpWNR/+eo+Oi1Du4j6hM11dObzA2XK5yS/MGhif2TkHaT5eA50Q70mW1eaAHrKtJBpgEHvZY2tyF17ma+h4Eu6oAZ9TC62OMITzTi9B3v8wYRBLluQmWG7r1nffsrx5vTFcmdSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DZAAzIJEHCUGIbMdE5ehjx5vP+wnBcyTDT9skwyFvs=;
 b=eOy9rRSkZcmM4nSizoDf/wnOceZPAP0KbliO4qJYzHgcmq6wFl9U7kAMrtXD1EjA5xek47PVuNoNlQztKtJEIbjEDcrZ3PTZDYG9v6YCip7e3+85lk5nDmhvb4SiPiN01xZVxp1LCU+XktNJ444E5XuUgkuu1mabipOSAG2ETG8=
Received: from BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23)
 by MW4PR10MB6369.namprd10.prod.outlook.com (2603:10b6:303:1ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 21:02:46 +0000
Received: from BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83]) by BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 21:02:45 +0000
Message-ID: <525ef370-d0d7-4b6a-a338-328824f5b018@oracle.com>
Date: Thu, 21 May 2026 14:02:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tun: free page on build_skb failure in tun_xdp_one()
To: Weiming Shi <bestswngs@gmail.com>, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com, pabeni@redhat.com,
        kuba@kernel.org, edumazet@google.com, xmei5@asu.edu,
        linux-kernel@vger.kernel.org, Si-Wei Liu <si-wei.liu@oracle.com>,
        mst@redhat.com
References: <20260521163312.1479805-2-bestswngs@gmail.com>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20260521163312.1479805-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::11) To BN0PR10MB5109.namprd10.prod.outlook.com
 (2603:10b6:408:124::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_|MW4PR10MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b305798-235c-42ab-46b3-08deb77c4e54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	H4xhAy2QtbSvT/W7i7O3FnJMarhkacKDzdHpxpvEhLO12+STmLsp+3BBI6wgRSwPNn6OOF2tAn84GWs6hHqqMjyHtVOkSw1g26NCui2X+Kwq4Tbt2yXU2n6c26ykYVgtQCErRiqs4QAMc3oFoIgXeux7r4xy2YnYPkXCmM7axU0n3qPP2EpvWLmAtUTXAdkzxrp0AVR/2WRHEnPxx9l/rfa8q8rbqRfPmFPh1iUzVIa8n8dgU4CBbR9FerwtCmXlvQ2/4sMjiAE9C/BENXFFGD+nFZTHsFx6SqWiDnu1JAZeaQghrFGFEfQDcMjm3m2LQZjY9tIbdPwVyg7RaS2sJM/vIMI6L74jO3ZVZEzUiSqNS68UWVkNG0OFbYr64LcR/00e+XT3AN3fRv4IMMuLhueQJzDxiy9tf7l0A2rywEpECZR0o12I39QduxTUEmIyhpdrhSc+H2BqwxMIpH1ITH3SleM9sKuHguwmuw3cKNipceYFD6ATcDsdx8vAezGPlH0K6MqIUykLIUXXgUPOrH3t2tbrzeFT6ZXPXjB0zLtzdrrVSnc4+ZQQfhScULTr3D6hzqAOdhjvoEO3wNEGETsGr8NZqy9zxWXK+MXMu5EbgZ0z9z3bXdttdb8CNBnSgZcdhxvXH0BTuWFldsAQ1A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5109.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akNVNExqaU92MFpxRkgxUlExMWtwQ0luOVI4SmJWT1h0a1VuaGlBemlaY3Mr?=
 =?utf-8?B?RlpJdlNhVGdhNXI1NlYySHRTTURxNUNaTEQ0Lzc2ZHRNNFNRNDM2WjhRNTFD?=
 =?utf-8?B?SldRUHdUZ3RRc29TRjNXRTRxM0x1VlBQbTJqaktnRFFXNE9WQU9FcC9OS1RU?=
 =?utf-8?B?bG1ib0hvUG8xUURLWC9MKzFSL1dCR1Q5ODF1NGE1ZW9UaUpxRVZiUGVXRmFs?=
 =?utf-8?B?K1BrUnUvNVNqODA2bmFZcjRlY0RyS2syU2ExWFlxeXlLMlQvQ0wvYktZbUVS?=
 =?utf-8?B?T0g0SEFEZHFFV0ZHQ3hvNmY4VHhNbWl4cS9GTkV4UVBZRnNLZ0doRHk2UTRj?=
 =?utf-8?B?bzlrZXBEREFMTmVNbURGZHZkNnFwL0NBVjRRYWVpajgrYXlIZDFUUXNOMEpS?=
 =?utf-8?B?Umt5Z2g4U1dZQzFIZHduclFialRIS1VJM1lWdGczOGVoL1BXNVcycnhva0lE?=
 =?utf-8?B?OWkvaFZYT3Rwc3lpYTVVVVQvb3kwOGFkTlZZUkhqY1BGakhLdURjbmtnRHM0?=
 =?utf-8?B?Wkc2MXd2em13dFNEOFQ2M3dSRHpzcXZUODhXMWMxSFVwK3FPUExQMGo1enJs?=
 =?utf-8?B?cHAvZ0wwUmFNa0YrU2owb1VhUTN0LzNoYmlIenBlOVJpallwbC9zdUpRRnBN?=
 =?utf-8?B?Z2lEMktJTm5NdEZ1WGp2M2FuRGNRT3QxNXN3QXA3SllwTm5nMlR3SWtUUHp4?=
 =?utf-8?B?SURnR2ZzcGFBN3BIY2ltcEE0MHVXenc4MkQwekRXZFhHcC9xMyszaXpLRnpW?=
 =?utf-8?B?K0ZXalpBeXFDYjE0NUNaTVowRnVsS0U5ZHN3ZUE0S01KUUQzcTIyWlFaczlY?=
 =?utf-8?B?cDhvOTRJbkJ4Ly85M2lYdmNuS2lDbzNPdDJvUWFOUnpsUy9meUVpb25kWC85?=
 =?utf-8?B?eEVHdk92ek9jcE1LMm9YOThxc0RVWUJhaVJyQ2F4OGZLcEw4Y3pHdjNWT2Yz?=
 =?utf-8?B?QTRjYUR1bWdYRjhCSDdwYjE0cmRtUVpZNzdSSlR5MFQrT05jenhiQ1lHQmd3?=
 =?utf-8?B?dWxpR1VGeVBtdEhnd0NuYzl6Nlk5eElRMVdicDlBWVJ3cTNiay9Zb0RmNjBo?=
 =?utf-8?B?RG1STlF2bVgzM2VRb3Z6N0dyQ05tNkpzS25JODhzNzFMRDRVaHRMTzRYbnBC?=
 =?utf-8?B?MjI0aC95UktHL1RRUFZrWHNYMUViMk9lNzVkTk1uVCtYb29zY2JvelVqTG5R?=
 =?utf-8?B?ay9INWxlMDBEQTBzNitxNE4vbkNvSDlFbm1lanAzM1diWnBuREIyZ09NSHFW?=
 =?utf-8?B?bHdNMXI4T2F6R201YkVMWlZXMHIxTEtETm9rMjB4clp5cVhhRHgvSjBtWC9F?=
 =?utf-8?B?dFNJblBLT1FNN2JHRnZrZ2FaYW9hdU00dTZXYjdWOHR2OVRLdWNETVprUlI3?=
 =?utf-8?B?VHVBOGFHbXQ0akc4b1kwc05JOC9abUNmaWJsMWRMMlZHWmdUUVU2VXNpakg2?=
 =?utf-8?B?amJjUkNIREEvRkdDSnNpUm5Ic3RaOWxBVVFWRDlHM3BSenlGend0bzJ6aVkw?=
 =?utf-8?B?dHY1TkdrQXUrc0g0WlRIODVuQk05czhvS3ZJVTNzK1FiUER0a0tWbm56WEIy?=
 =?utf-8?B?a2lSMVh0aEtZazlYWlBUTFNDdVBaTGF3M1RpdkRqWFE0UFdhZGVrZjF2emdI?=
 =?utf-8?B?WUEvUWdJNGl0NXN1aHRYUFBmMzZEc3l0Q0d5L0tSaHNEWVBDMElvc05xa1pm?=
 =?utf-8?B?ekdQNUFZTFNrQUxiYUZHdkp1UUJqMVFzVTMwTERCdjRsbVFxdDZPWTh5M1R4?=
 =?utf-8?B?ZFBoZkFEYWlHVEVZY1laNTBnVDltZXhhVVZLNEZQVGI0Z2NHNGQzL0dGQVRv?=
 =?utf-8?B?bHgzRzR6U1lGWHg0WDNTVDhzUFVDNHpaeXNwdkdUTFJnWDdzd0dwMGlYM1M0?=
 =?utf-8?B?VEJ0NUpGWnNZLzRxOE9BK2hWQWZiU0k3eWlvVkMzd05hU0xteHM1VzNKdzdr?=
 =?utf-8?B?TWJRZUFvbEt5ZGRhb2dORzJaM09TcFVzeHpwZU9FZ3ZuL3c1ZnhYUEdndUIv?=
 =?utf-8?B?Vk8ydDdSd2FQaEozSGsrdXJncHVYVHNpWFBkc2w1UTJpNlB6SURtMWRzTElG?=
 =?utf-8?B?bjJVRmFDczFQZ3p1WXdsSjJOc1ExRWtuNHVNZUJBQTFlQmhVd3RuWmpnUGk3?=
 =?utf-8?B?QWh6OVVnOWF3b3JmRGJpTWdxMWdTRXo1MXhwYjQyWGRSRU04VS9tMHlJTm0y?=
 =?utf-8?B?aG1HSEY2dmthODVNcmVIYkpNVXhyejRPcldnbmIzTXI1d0tMWSs4U244OWlO?=
 =?utf-8?B?RCsvV21QaGJsS2hGTDhzaFA5M0tQNk9XOEV0RVlJbEs5UWkrOFRRd2RlTUxG?=
 =?utf-8?B?UnJoWmRZKzdKK01pbURkSnZTTjFaVjU0Y3ZabzY1eUtWbXdYeDJkUT09?=
X-Exchange-RoutingPolicyChecked:
	Wc8Ec6vsxvHozt5IImatlq89WMLgszsCOF36IomDYsR7ToQS36POvPhtLamdauwMJLi7QSaHNTNE5uDZN0z14UKfrr+gTWCEwfadCLHkmD0mmsK+ETA9VKdLAk3OU/2Z1BV387OT4I9f0maqEFhVi8npKyDpGSCWNeJe/0trELZjeb2uR3JzNAXXt4fieJWQyj5Q2obWiXeVZ4EBihwMbhFZLrbBgal84h71aGFmdm0V+vvKpFD+J+FlJDjwbUT9HhIn1ANBFroST4ExmXJJ1plE/D7dWrF9h733MhWHVb/xpKW6hB68RuZKf1cbaka8E7OPuR6oRo1aJPtWi4wFJg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8BRWZNnTks2ObUZ1Nf5pyZwgTnuTThbySZtaj/bVgnLWm+eZibaD0h270rFc3zmbzK91ARbb8c7noJ3G9kbRQX0mMSKhsfxNcHVsFYGvIhJuf0Bb0X1VCNj+AEDUgC3NfKyG2vTqIFLdDSwgpW5EtJFzGI+gQ9SZcCsgeB/cvC5/2jH5SXADl99Xxr+JoMjjzK5dTbQFeVATnGTzrciTZgDRN/dOaVKmos9yK+5t43vIGda1Cjh6iLL/qABZ1dP/dPGc8AncedeVMiswmkMWycdE1F9GqkW0pRsgO3BY4QXJcSIdt5FVktnL8U+TzALEiokBumOR8IPc45rrV+4HZLmwJZ4KX+WZClqrUZA6GdxY6yRSZrUrk5C/wZGjZgI9p138mRtxI4HOG35S69Y6PztJJYT76hfSfJ36k7xXgHgu8IDxDKp5aRKXs74u/REuCjYtRf21umIvudi+SSyBiFuJz9p1Iuv4XK5vDu8h/1rEYWyg+UPQQJeQoE7bQn1O7TROKYI3jUzKKlhU3fyQVAsM2rTdew31mHLDNn9UmY2CyQhCCyscd6JsjOidE2Re1OwxfQPlj/eo+TozMesC7R40YzXGc1SlcVLbuMecNk8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b305798-235c-42ab-46b3-08deb77c4e54
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5109.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 21:02:45.1962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s5p7HBFo+RvCklGwEAtwVbHad11Y1t4WuYKBJngIZoGMs61+ZCU0/Ty5mWw6oeTHLuJBlLnGpvUNv9tY9hEOqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605210211
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDIxMSBTYWx0ZWRfXyWNjYs5TkhDz
 FGi72m6trzX2f0aK89UyDswyl8ZqFn5kmIejwXgebQlM6PaXU47nE9Js7frKUC4cjSxK/gxp9gQ
 tgLtOTbn0PX2pU/xaW1NZI4Ly54cKtIF6BmgqX+1lAojKupvltwkd2ZMBLWH0GSFFLBGrjmzBP6
 CNdUfFKQzbv/5ZKhRkTio69Kuv3FG4qt/5HFEX7WzXL/zu5zDARnqAAuSSn3kKkRUoFJ6e+MHJc
 LkcGyGRM41zNa/nRPdmktWZUKv//C0zZrNbOJx6QIOZzb6jQuhPFc/YLDvxbVosVgMZsy0ItRCu
 chccD5qHZLLjzOho5//wjfjBhEwRd+OL7nA7Tyn13AYLddn/lqF0zyOGuGDPE8hk8m+18WHG1FX
 dNgPIoSmuNd/lTZhM69e5sAR0L5PipJB+soPjMd8x7TeTTkTU5sja59zN8GHqevwSd6bpicCef/
 RgZpY/72S61WOoRSTtL2XNexrGv7w0220vS3d0JQ=
X-Proofpoint-ORIG-GUID: TfHH96nXShcxWBMlg_CW5rxgPj8oXZ0r
X-Authority-Analysis: v=2.4 cv=dc6wG3Xe c=1 sm=1 tr=0 ts=6a0f72fc b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=DhAuANW8suTSEI8WxXYA:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13839
X-Proofpoint-GUID: TfHH96nXShcxWBMlg_CW5rxgPj8oXZ0r
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-290616-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,kernel.org,google.com,asu.edu,vger.kernel.org,oracle.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email,oracle.com:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim,asu.edu:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongli.zhang@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 34FE15AC020
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026-05-21 9:33 AM, Weiming Shi wrote:
> When build_skb() fails in tun_xdp_one(), the function sets ret to
> -ENOMEM and jumps to the out label, which returns without freeing the
> page that vhost_net_build_xdp() allocated for the frame. As with the
> short-frame rejection path, tun_sendmsg() discards the per-buffer error
> and still returns total_len, so vhost_tx_batch() takes the success path
> and never frees the page. Each build_skb() failure in a batch leaks one
> page-frag chunk.
> 
> Free the page before taking the error path, matching the put_page() the
> other error exits of tun_xdp_one() already perform.
> 
> Fixes: 043d222f93ab ("tuntap: accept an array of XDP buffs through sendmsg()")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  drivers/net/tun.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index b183189f1853..39e9f3390c91 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2437,6 +2437,7 @@ static int tun_xdp_one(struct tun_struct *tun,
>  build:
>  	skb = build_skb(xdp->data_hard_start, buflen);
>  	if (!skb) {
> +		put_page(virt_to_head_page(xdp->data));
>  		ret = -ENOMEM;
>  		goto out;
>  	}

The bug fix applies to both TAP and TUN.

TAP has a single patch, while TUN has two separate patches. I'm not sure which
approach is better.

[PATCH net] tap: free page on error paths in tap_get_user_xdp()
https://lore.kernel.org/netdev/20260521163230.1478627-2-bestswngs@gmail.com

[PATCH net] tun: free page on short-frame rejection in tun_xdp_one()
https://lore.kernel.org/all/20260520160020.375349-2-bestswngs@gmail.com

[PATCH net] tun: free page on build_skb failure in tun_xdp_one()
https://lore.kernel.org/netdev/20260521163312.1479805-2-bestswngs@gmail.com/


The bug fix looks good to me.

Reviewed-by: Dongli Zhang <dongli.zhang@oracle.com>

+ Michael and Si-Wei for FYI regarding vhost as well.

Thank you very much!

Dongli Zhang

