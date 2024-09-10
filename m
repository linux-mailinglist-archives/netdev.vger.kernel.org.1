Return-Path: <netdev+bounces-127056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7470B973DD0
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 18:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6EB1F28EBE
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B082D1A08B0;
	Tue, 10 Sep 2024 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hA+JWBuK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sZ6f8KBn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB05167DB7;
	Tue, 10 Sep 2024 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987316; cv=fail; b=kPIW2/fSmG8YFv4wJOl8T3pgnpF9ilWIb8H+17Qotku9Lim46eeInQzeMAcodBRLGf7QiYN5TU4ijMxG6h/WXVyQXAqW4IFOadJxZP0Mzf6R3wzjJHciokI2zrUWcytkXZP5v2I5SWr3c0wO98LcOuWeey+sRIsgvmLrpMAHido=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987316; c=relaxed/simple;
	bh=5td3U/bgKpjj5VPSOJEyi0coay08pqoYOB5+eENacpw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DBGBkpBo5Uygp8m8z7jJCtmbDiSGjQegTWbdxnz7Ss/7JFVgVOMuNI6VtTjnozArrJwvgglX11ZimyHrm9kdoit4HQ/nNTGJDGLtyC4XR9VzneThvUsMcE7cX5xitSxwq6eGgf/KWvji16SfHdGHhgbKk50Hz/xHR8puy0lkhuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hA+JWBuK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sZ6f8KBn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AFtjUv025735;
	Tue, 10 Sep 2024 16:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=xqnE/70djwqggDIXlrl6KzRyvLVMWmkVWFOq0jajPzE=; b=
	hA+JWBuKt+ugBfxseJNCZ21valMJS4sdStKRweIKdNNGcaM3AwCJIJNN3mOWNQpL
	Z15HCMxXGsIv46dOXpy/sBihlrC2d8CTTTtJWIDqz0o5i9ZpcD+DwI+VHIwX3KWp
	SJhkL4LsLonQQzXkDoFUCWBP89rOR+oMPMiJab89K+nGjoFPoVwyduSdPs+MKY2A
	8mN3TdYVtf5VuIB3yB2C0j+75R37G16rkLikoXgxu9aX6uJMl/m9wZNlr5OHCe2p
	Z1urB49G/cLJU1Ude/yz79i8RBhTCliyXU2VQE0oHlMU9pJPBCS0BpY1a1gh0Kio
	cqAVPoZyoMlRm/Zn948ZnQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gevcp5bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 16:55:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48AFU2n4040958;
	Tue, 10 Sep 2024 16:55:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9aa3bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 16:55:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwfSFa+aDuOULQV1ly1Hlk/iBWnRHvlHrGSjNMJ+S0WRXiVGXqhGMVg9B90nAbL7hpuLrYd2Cpz63pJpUF+Udc62gHCASOSr+VReLCFoMy6t//feyNRSDc8WCB5Rhq4vxbZN5W6l3e+QxvbMapRCMeqPJZacSW19+E4VgHSAav4B5C4wfmKoTxiqQde/2scAH3lB8ZmtG+lPqUVCHEpSWNW1Vgrlj/yn0U2qF1E+HCCpqjVfoJiJfDtvu37jP0VnZJYGoWyQfKJFUgbWTReYrOXGyFW3HMneAdlDvxcDfYQ4Wa9bcOkgS+3mKy+WK8gZ7gjmqhRwhEPLGkzHYYFNNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqnE/70djwqggDIXlrl6KzRyvLVMWmkVWFOq0jajPzE=;
 b=EFtQpx+AEDEd4f/lf0p2kYAN02+Z9J+jPBUOJpDpVyTUHArwFswZcYH4cLQksj6TI54GW4T3KpSe1ycTDpC5vpd4PhsClSEDgA14XFsxPR1rS10asONXZXQ2zrx9rc2JlCrcXM+j+NLgaM+XXxqNErC4c3gduxAMRZrIG1F9lWrTW+QdLm/MU/eaWhiuv1CYTVqTSNH+osd8XjvyC0p388PbQW15L6yewXzeBuYTibh+w/lqPriC672n0RL2icDveK1bpQPClp1Uk1o4a2csQST0bqxLISf7OrDs7luYaW91owD6oByudw9vYtA9uWktZdHQoy/43dPrqx6N0yBcvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqnE/70djwqggDIXlrl6KzRyvLVMWmkVWFOq0jajPzE=;
 b=sZ6f8KBnX+go4VcJE0hmMnfevVplkUuTJuNiXRlNS4OIkEk5ODOg3Al3JDyoyUNBexew6Uh2pPMbE7Oasv0mWjNBoaJrlmie7uTAIieq3ibpPtRjGARcql9dbia7tZQQ6Pi1Uz/qLvU5jrYxvpTG/9oTwcnMpLfJ2QLmTdgSfKs=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by BLAPR10MB4833.namprd10.prod.outlook.com (2603:10b6:208:333::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Tue, 10 Sep
 2024 16:55:00 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%6]) with mapi id 15.20.7939.016; Tue, 10 Sep 2024
 16:55:00 +0000
Message-ID: <943f2045-a89e-4d00-958d-e27c22918820@oracle.com>
Date: Tue, 10 Sep 2024 09:55:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com,
        syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
References: <2dd7aea9-93a1-4fbb-91a8-b7f3acd02a60@oracle.com>
 <20240910004829.38680-1-kuniyu@amazon.com>
Content-Language: en-US
From: Shoaib Rao <rao.shoaib@oracle.com>
In-Reply-To: <20240910004829.38680-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0096.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::37) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|BLAPR10MB4833:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d1c6615-888f-4421-ef22-08dcd1b94e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SE1meDNZQUFXdENuUERGd0N2aXlZWHFsbzA4S2gxUmZwMDhRSUJpMEt1Y0tZ?=
 =?utf-8?B?dHV3QUJ5MHB6SE03Z2xCOHc5SlBZMEhHWHJoR0sxaWI2V3hkTmxnKzhBbFp6?=
 =?utf-8?B?MmZHUWtqM0x4NEdBbDIzaVlpeU5PUjhhbXg0UzR1UjBzOG80Sk42ZjNtcHdU?=
 =?utf-8?B?cHBnbHcraGM3SnlOMW4rMnNKQ1V6Z250Z3FDeDNNN3I1eDUreXViQVkzeGF5?=
 =?utf-8?B?eXZQc0ZXWHhzZ1BkbDhVYjdYOUZIY2NSRjczMTV1SENnWDJhT0ozN2VwUEZT?=
 =?utf-8?B?bEJ5NURmSlhqMlRyQUJlSHBWbWMwZmdPWXcxNWp3OVY3Qk0xRTJWaHYyMUxj?=
 =?utf-8?B?Zjdod1dkaXp5RElXcGl6dmMzTXIzQTBSYU5PZWUwUFJKRlovTk1pZzd3aGlH?=
 =?utf-8?B?c1lpNWVGMFZHeE8xcmUydVhQUm11S0daQmNkdjd5UXdMU3BISkdzbWlJVGpE?=
 =?utf-8?B?ZlVXTEYwUERsNks3UkNGNzJRTmlDdTVMUjN6RHpxOGFWbFk3d2Q0K0tHVjFX?=
 =?utf-8?B?NVZqNmJhTmZTZnVvSWhKUkIrT1BLUU56b3pQeWs0MGsyT0pnN2FkUm1oeFR3?=
 =?utf-8?B?MGllaGhybSs1RGlkNFhTc0NaeFNjMUhxMUlnQW85RlEyd2tCdnhMbCt4Zzg2?=
 =?utf-8?B?SW9PbEJldzRZd0s2bmxkbnlpWnM3bzRqSVRvZnYzTm1lZXhsWWU3dmxvSDV1?=
 =?utf-8?B?Q0JWUGNzbzVvNHM1b0xIMXptSEhPRS9CUnR4MS9MZzIxRFhZeTY4ek5IS29l?=
 =?utf-8?B?QStRc1dJSWFxT3EzNzlPQ0dZZnRrellTNjZKWDZJY1FBZVE4UUs0bEFvaHFq?=
 =?utf-8?B?WnF2RUF6R0xyNDh0djFvMXkyejBVVmRlZHdMRnhnRnY0bzVRY1hLQkRpV25V?=
 =?utf-8?B?WGNiSTE3Ynk3Z3IrdkFrRFo3OWY4OXZNa0pwYXl1NWdxWmQ4dnBsNU5LMTQ1?=
 =?utf-8?B?QUdHbzN0RlRyZVlTWUY1TnpFRFFsL1kzRndGSHI4TnF0TWNXekYvVGxNM2wr?=
 =?utf-8?B?Rno4bHBuVjZvOGdlN3I5MVF5RkFmU25iWXA3TVk1L2JBeTNxbmswSEh3R1F0?=
 =?utf-8?B?WjFZQ1Y1aW9LeG5Qc0w4dkxQTWZWeHdtd2lCS1BvU1NVTm9Sa2VBRlNVdHhL?=
 =?utf-8?B?dTFOOS8xV2RXb2pGQUxtRDk2TVpiWVl1NnJXQnYreTlmMUtkUWhhNTArT3Jk?=
 =?utf-8?B?WTJFNDRSdG1KbjJ4VHVjUDFwN1F2eXQxZGFoek9TZWVRMGthZFdNQXEydW84?=
 =?utf-8?B?MjJqNE1nY3R3K1lydHZKRVppVTZQcHZ2bDRBMjJlOW45RktLNmpkMTRnM003?=
 =?utf-8?B?VXA1UmlEYndicm5VVThEdnlIKzJTdUZzekhTZGNXdjc3WGd6Ty91SDZzQ1lW?=
 =?utf-8?B?S1JRY1czM2xpeUZkOEdOd2NtWGl6Q1NIc2pZaVpVU1llcXEwb0ZSZzNaemwr?=
 =?utf-8?B?M0FkRVpQMW1PZEplTVowcHFIL1dxK0hnMjhmZWtiUGtyYnR1dG5BUithUUZl?=
 =?utf-8?B?d2gvR0ZIZnZxOWlWT0hGV3pCZ3d2RGM5RGVVYi9QV3duczlxeVZEekgyMG5S?=
 =?utf-8?B?TytaeThHeUIycllzSmJGNHpVV05kNmZKdnNPL01GUEpXdHlSOUJrUHNncFFV?=
 =?utf-8?B?S0JSMkJaUDVqeDZ6dmV2WXZZY09JV2RXTGZidy9RemJzcG41cDVQYlR5ckxq?=
 =?utf-8?B?QzFQVkR6bmZkbUt2UWNCVlh5TUpkemp2L3JRRk1JMlZQNGpmRXhYZmJ6eHIx?=
 =?utf-8?B?THZuT0pscjZkYTJoSFR4NExFZnRyWEV6WFNkTm5NcnNHQlBBU1dvcXpGOW04?=
 =?utf-8?B?WVFEVlZnWkRMSHIxMStGUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkdIS1lUZURZR1U0RWJ6WTNRZkZUcmc4OGhWR2N4NDRjTGtIRVdZd1BuRG9r?=
 =?utf-8?B?T0ZXOG9TSFVUK3E0cnkwV0pwUDFaUGp4ZEtxT3RBL1hXdnJNaXR2R0x2Vktm?=
 =?utf-8?B?NVh5cUw3cHJTbHJwTXFQZ1NaVFdCbk8zOFBUYUxHNG1IeTkrSVN3eFltR2NZ?=
 =?utf-8?B?aEZIa3VtRTVUU2hwSlRVMHY4Wm1mcVlGbW4rci9KYUZyZmUvdmExYlFoVDBa?=
 =?utf-8?B?Z2VxSDVLWFlORzBXVVFsdzhCc3crSHpGNVRldzU1dUdaTHpLMU92eXhvRGpo?=
 =?utf-8?B?Ykx5UjZIVVRBcXNhdGhEZjdLMjV1TVE1OFE4Mi9UZUJXcFpGcnRFQkJTdDl2?=
 =?utf-8?B?Y09VWTVHdWZUVk5leGtvRHVMWnppRnBoSUhRbERjWUYrSDhVTFZ1YnFWZzFv?=
 =?utf-8?B?WWpaOWFFcHd3U3ZkUjFSR1lyUXA2bTJONTNIaG4wY2hCNXcvNHB2VlpLMyty?=
 =?utf-8?B?eUpmZVd0UkdlWkthUVl1UWxxankzYU1HWGJPUTA1Qy9UNC9DVEdYazRsOUJi?=
 =?utf-8?B?T1g0NDkzdHU5d1NiTElWbXRORjdtOUQ5eEl6UGZVWjUrY2ZtYXFhQjZ6ak1y?=
 =?utf-8?B?UEFhMStVTkEyWXQ1WnlVOXJaQm1aenBUdktKWCtkVWsrbmZYQUk0QzNtYk12?=
 =?utf-8?B?WjVPUkRncENpOGNaQk51ZUdNRUliVHpXL1laR2VCWE9NWmMvQ2RPVjlwR3BH?=
 =?utf-8?B?eHdWT0UwSy8zOXZwaENqdTNrZG1PbTlRQ3NsN3JGRW5BYzJmT21YK0crQ1Uw?=
 =?utf-8?B?SUhxcmhjQm5UN3lhMHRmN1VkRnFsRDIwWEd1ZTk2VGFIR3JOSXJ4ZmNRVDhD?=
 =?utf-8?B?Uk4zSnJlWDYxeW83dzJITVc0N3M5cW8vSnVySkY2VkI5L0JRYUMvVWFGMmpY?=
 =?utf-8?B?Zk1pVFRURUl6TW9LYmJPejVMMTNvZmt0SFZYb2JlT2dzVzMxRGJ1QWNNR2Vj?=
 =?utf-8?B?RkFRWVlNaTMwc1daTEp0dDlJdFBVck11L2gzMnAveE1sb1BVVXF3NkQybm9G?=
 =?utf-8?B?Tmw4eXlyZ2RxZCtSMjBpQzNudE5lMms4SG9UeU8zR2s3MnZpc2FKbnRKNUZ3?=
 =?utf-8?B?QkV0QUM5V1VZalRuTld4QUtuS3BvUFp2eXBNSjBOWU13TlVGL1VBeVFkWGNY?=
 =?utf-8?B?L1RyWVBhRUJZWU5tZmlKL3ZOU2xhc3NHN1RoOXYxSkFaOFl1Qks3TFJ6ZTE3?=
 =?utf-8?B?VHM1bEtjTzRPeFRwNVRFMndhN1plWjQ5ZUVLdERrMG93T2NMcjlMRDYvK00w?=
 =?utf-8?B?NGZiOC9YQU1YTVVHc2xhVXUreHNHZlEvL3hsWHh1bVEwSnBnUkoweWNaeHFM?=
 =?utf-8?B?M3VCc251emdpZ1FGRStaN2phYXRhQlNzRTFHQWs4d1BIQUs1T1hGa0JnelV3?=
 =?utf-8?B?SXJHMkNUd29OUkhQZ1A2TGZyQlMyS3pLNTlic0NrQ09rNDhGVDN2Q2xZL2JH?=
 =?utf-8?B?Qk9jR0ZjakVlcUdGUWM3UEFjUk1Va0hjL1pBM1ZOaUo1S09uZWNBOEdXT0N0?=
 =?utf-8?B?cWpaalJpeDc3cGRRVHFSS2ZBVVNpM2gyb2YwUnpKbGtBNUhoUDVKSUVRbFlN?=
 =?utf-8?B?YjRkNWVNQkVWQTBQbjdJYlNoSUQ0VVZqL2NNd29XNlViNDFJQmhIWFNyV1kv?=
 =?utf-8?B?cTZVUk5pYnNIN2YvaVNaUUNVdnZFZ0MvaGZWdTFZUFhDUmI0aXB5bkxIaDVp?=
 =?utf-8?B?TzlvUzdnNm9OaGhnVDJGTUpZSVhxZ1FOZW1ZT2xjbENHTmM1RndZT1ZHODQw?=
 =?utf-8?B?NFRHUXQreVkrWXFKbm04N3VKWncvYm1HNGQzUlJUSmZPR2FRZG9oSVNqUTZP?=
 =?utf-8?B?cDBWb29acUtiVEp2MmNUTWFFRDJFaFBIdzZ2dUlwY3R0dmg5WHdFcC9JM2M2?=
 =?utf-8?B?dVFBNmVKMjlFWnhibG9DdVl0MHBBajRyenZLSXR6dFYvVEllY2t2VzBITlhN?=
 =?utf-8?B?ZGZGMDYyQ200Q2FKWTNNSGlEOHdvUldYQ2dRN1ZBY0VGN3FFcnRZSWtVVlh6?=
 =?utf-8?B?S1ByNnl1QzJEblRLOGttOVAvWE9BTUtCdGJoeEVlQUdrc0lzMWJDMktmdDc5?=
 =?utf-8?B?QlM4ZGJOV2RwalVMdnJ3d3J3enVLMTYwTGJYOFkwMThXb2FSNVN1RjdMSTd3?=
 =?utf-8?B?RzBZQmsvMXRxRk5rb0o0ZUpjZ3h4NE9SZ3B6N1RwaUZQNjVENmVLaUxqKzlh?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0Mu7YyTwLy1qaLpQ01GmH5QehYiiEa1Bs6dWIZTkeU6i3TWAZYpft1cR8LeJ63kw/nzZ0eu9IgBG628pdncJGI4cJw36fw2yp/OYs9BXIe4gA8zjUm5J/CoJwV6UkZqg5jbOj+xuaBKcjb2aBaQFqIQekCpJTVqD7YDKm1Jimp2FV+b+Ge8fY9MaPf82Bf0cIZiycMo1g2/SdBYwl9hO2jmTaHsn3U3xP6944RTEpi9suFKzQfxqlgJEgT6rqQUAB8ZanSo74jnhedDMnoPgpi0e1GacXNU6iEEcyl+C8TjTzmaqUN1jteM+EoeY5JlGSD89ytSm0moZyVf9xdnEN/wEg5tjk/EsZMIA4sts9ah8HvwXfCF2I17DM/1e34XqPv+kydAvH4MVnPFTw2/+2XYUXIxHLDiHTehnb0LRGJFAJdPexMcafKow2KAJBgJnSyLyql+R6ATwagtkW53qI6dSVvf/rFh3m4PRIX8KNmuL/AyadjEWaqt+MOLFQbpvQxj6kFIoVD+O8gsJH2c70XV2NuTCqWPapgx7J+Ikyfk5kIwJwJgSmc6+2pZV5/ur2wL9JRDjk2Wq7jUz+uAjWL7VEkxbbcZusQrwJYTTPoY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1c6615-888f-4421-ef22-08dcd1b94e9b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 16:54:59.9535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xrr+xqaOZXsqcUrHfJMdTHLZuccqTb27TrqeBwB+WjUkZzlzqKZYvVJLcTPqgixK0Aw3VW0pmOGyUERW7Rgpaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_05,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409100125
X-Proofpoint-ORIG-GUID: DwJJv9prsfmTKRPNvPorq6BMLmPPVYAo
X-Proofpoint-GUID: DwJJv9prsfmTKRPNvPorq6BMLmPPVYAo



On 9/9/2024 5:48 PM, Kuniyuki Iwashima wrote:
> From: Shoaib Rao <rao.shoaib@oracle.com>
> Date: Mon, 9 Sep 2024 17:29:04 -0700
>> I have some more time investigating the issue. The sequence of packet
>> arrival and consumption definitely points to an issue with OOB handling
>> and I will be submitting a patch for that.
> 
> It seems a bit late.
> My patches were applied few minutes before this mail was sent.
> https://urldefense.com/v3/__https://lore.kernel.org/netdev/172592764315.3964840.16480083161244716649.git-patchwork-notify@kernel.org/__;!!ACWV5N9M2RV99hQ!M806VrqNEGFgGXEoWG85msKAdFPXup7RzHy9Kt4q_HOfpPWsjNHn75KyFK3a3jWvOb9EEQuFGOjpqgk$
> 

That is a subpar fix. I am not sure why the maintainers accepted the fix 
when it was clear that I was still looking into the issue. Plus the 
claim that it fixes the panic is absolutely wrong.
> 
>>
>> kasan does not report any issue because there are none. While the
>> handling is incorrect, at no point freed memory is accessed. EFAULT
>> error code is returned from __skb_datagram_iter()
>>
>> /* This is not really a user copy fault, but rather someone
>>
>>    * gave us a bogus length on the skb.  We should probably
>>
>>    * print a warning here as it may indicate a kernel bug.
>>
>>    */
>>
>>
>> fault:
>>
>>       iov_iter_revert(to, offset - start_off);
>>
>>       return -EFAULT;
>>
>> As the comment says, the issue is that the skb in question has a bogus
>> length. Due to the bug in handling, the OOB byte has already been read
>> as a regular byte, but oob pointer is not cleared, So when a read with
>> OOB flag is issued, the code calls __skb_datagram_iter with the skb
>> pointer which has a length of zero. The code detects it and returns the
>> error. Any doubts can be verified by checking the refcnt on the skb.
>>
>> My conclusion is that the bug report by syzbot is not caused by the
>> mishandling of OOB,
> 
> It _is_ caused by mishandling of OOB as you wrote in your patch.
> 
>    ---8<---
>    Send OOB
>    Read OOB
>    Send OOB
>    Read (Without OOB flag)
> 
>    The last read returns the OOB byte, which is incorrect.
>    ---8<---
> 

I never said that the panic was caused by the mishandling of the OOB. I 
specifically said it was NOT caused by the mishandling of the OOB.

I don't have time to argue about the fix. I am just disappointed that 
the maintainers accepted a patch that was still being discussed and is 
not the best fix.

Shoaib

> 
>> unless there was code added to disregard the skb
>> length and read a byte.
>>
>> The error being returned is confusing. The callers should not pass this
>> error to the application. They should process the error.
> 


