Return-Path: <netdev+bounces-288901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLzkI/zECmqa7wQAu9opvQ
	(envelope-from <netdev+bounces-288901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 09:51:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 903D7568212
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 09:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FA203004620
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 07:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28543B52E2;
	Mon, 18 May 2026 07:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="FIGtmQAo";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="V3S19MjA"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1212EBB9E;
	Mon, 18 May 2026 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779089928; cv=fail; b=Ma5Q0uXcNLWCc3FtayQeIEABrcG1jAMCp2YV+TPc+T3R1z4P+thW9vzfM+KquWndDJ5zhpWBLR/OPG7fMQS+wWrx7p8WdQV6lT4bAdWIFSCTOdrwO66l4HwhfE86/rZm6AMPkgI4JyH10N28h8ZAg9s3+RbdljdcfZTv0LpKf80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779089928; c=relaxed/simple;
	bh=PeQqLkWL0zFmTZ5VBHOZiocs91x/7b+8t1TDwOympZ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y+rXJ9xgvk9kx4CBxnriqem7GwgPNlT7imfoWhck40FFu/Frl9lis8ACWVdZ5lRCzQkf2iQHA8W5HL9UzXxAi08ki+hi9e0Rrm0Oe0cWuW9O1W7C35drgiAXYxCoOpeDzqZF1g2owsL0+S3Tf/gSUoqQSuynPB6ijs0uSp9KhgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=FIGtmQAo; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=V3S19MjA; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I4Ns8m2730256;
	Mon, 18 May 2026 09:21:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	5owCi21EMNCjFaAkdRJMpCANu+OAcSDcN+Mo7aOw/4Y=; b=FIGtmQAoaIV+bsJX
	H+asuTA5TZPGNWkwlXYYhOfrn8O/C15vK5bcA/5P9u8ndr9GjpKBb9SttBc7y+zl
	vdfRFg0a6xME2yBm/cTCV4mtNP9B5JY70GR7DF+xqngd4GkOQN6fh38zygoqJd45
	9zPE+bc8DKsuOLuHX0eIAn82pwkY8YT+NtZKf88q4CiGCM5k7wsMq6hH3ncKhtUw
	QDq4IpeC3/BAR5QKduCIWb/jo+VEhHhipneoyGR57/RvSC3fQyKstzhBd9v+Izq9
	+IdJLNjCje3kbgXRGCZBdl4chOSb49YTzP50VeSnFu1gkBESJvio0CAmaAM3QfIG
	epcD2g==
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11022096.outbound.protection.outlook.com [52.101.66.96])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4e7sn9g6vy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 09:21:47 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dV+f4ejuKlxaneKJKqHOhMfoLo6AOx3PemMJHAgbLBFT+k/MShbxJKFv8rRd8gSCa3HZ8du05hDwYxeDa7rN+Q4ufczGzm5kQjwH+16dnpPimAbpxuoysncnqw5ag/lFwLyrZI0CvRcjp30WINUYnSGAGojYIkepYfoIP+ZoTlH9wub8dNmOyuglL/wLeftz1/pgnew5dyBivyiXhV9ImpCJSpuqhuBV4W5X9e/L6LfMseWrdc97xHn3eFRBupkNAvupnaRJWZa/OcZsU2UKJSVGdsIisLutvTnS0HluysZBNsCLRc6SijEyuj4QfPgo5lRSx+9rH3PWzcCIKh3kGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5owCi21EMNCjFaAkdRJMpCANu+OAcSDcN+Mo7aOw/4Y=;
 b=J0OVg7A7ZKnGJE4Z83ZiSAj9BPQwfN2rNXCEiFTLJaPQ2POAbhY0gHxrhVLYEf/APzAL4eYon29pMpS5oO71sm8UJfL2OiplTUaPYjlO27F14ngUqp6I5+GIgmgYN0IHcqnWk2+E2HOSF35gxdgi1mi8VGrSIAIvrN+0NSqSKSn9uR2XczVVdKlXAxn7a7bwEq1fIXkQU92H9sMoFY+U1sBhJBpcB7nAB3f7fs8xBKyyfU2m5tzZOIn/2Gw1PbMOw0lxoQspBglcHYD7xmhYXSWYxu24P0r5Earg7AzvcCQeWDBUq5jgJlFFhN+9h0SgpRFd6nR1mnlim0QHkfEHuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5owCi21EMNCjFaAkdRJMpCANu+OAcSDcN+Mo7aOw/4Y=;
 b=V3S19MjAzITwnW+Z3VqJdL1y/uOOGvOe2kLazzn/nF3dMZkWQvRoYFBNS2HKwsejeHv5Ja5J3qucb6vaeFU2WLeiZfkLHLTMl2t6XIztEjjFzdc8W4uDB33EezqG7qZDxUEAoLX8miO4JD8iDtXw9FrwXNoCWFYOODrAuIR5aO4=
Received: from AS8P192MB2043.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5bf::11)
 by PAXP192MB1607.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:282::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 07:21:44 +0000
Received: from AS8P192MB2043.EURP192.PROD.OUTLOOK.COM
 ([fe80::9f05:d0fe:f10:78e6]) by AS8P192MB2043.EURP192.PROD.OUTLOOK.COM
 ([fe80::9f05:d0fe:f10:78e6%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 07:21:44 +0000
Message-ID: <539202f5-43ba-4938-a9b2-393c1bb3e072@westermo.com>
Date: Mon, 18 May 2026 09:21:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] usbnet: limit max_mtu based on device's hard_mtu
To: Laurent Vivier <lvivier@redhat.com>
Cc: linux-usb@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Stefano Brivio <sbrivio@redhat.com>, linux-kernel@vger.kernel.org
References: <20260119075518.2774373-1-lvivier@redhat.com>
Content-Language: en-US
From: Matthias May <matthias.may@westermo.com>
In-Reply-To: <20260119075518.2774373-1-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZRAP278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::23) To AS8P192MB2043.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5bf::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P192MB2043:EE_|PAXP192MB1607:EE_
X-MS-Office365-Filtering-Correlation-Id: 03530c3c-757f-443b-f51b-08deb4ae1d6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|11063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	4+vpr9GX9DDBsRn0AvunW3qRvMo24lghGZmF1OS5ReDTq2f5CsKbYPgAQtGQ8yE3dL/ilzWtd7pa4+e4a2N2+ew5uDUauEBR/u34qhMPkgU4sDBiqgud+sKkC01C/Fkwz8rbgfVy/mnECukE8R6C8vzQVfiJlES38fEShGOWisFybTPS+m4+VYirhMwEaPvGmyFYdj8vBLIWQu6CJ9p5CFU6OTg6JUtDuTdPGtNcgucCwjcWEPM7O+cSaZatKZ2l+9lRUdLZxR+9/hzfW0LzlFKhESV+Vhmz6FrEzW85XCUDT+eI4fJxpeOXeigm202GnMzOcei7UAC0ADMJCNhFPAGxAPMs3smzYnmL+bLEb4KrOm0lYCfBqnB7SvnvJMq1CZ2IJspOVzFpUqJ9pYccERJaAGn3RUTm7HMMkzhRvlpwb3eV5sgGy5gg9QtwKcktXdWd3/xuByINHO0FvR8owJMCb3iDaeWGdGhXZDox0/yqiorYbT2i1Vy6KVZ4acw1eMD4t3VkwIHoPcmmZS0kyJu9vgmR9ur1A9wbjFUwwE9b81xVR91eJdA5aC2NEWWgdaBswnrAaIoeNh7UBHego9BFAJri7A8oTr8vM8TRl1x7ABKpdiHYM+HB++W9tmfmPh5ssnYQgrCvcGSasFSSxA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P192MB2043.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkxPblQ4UFpyUncxOVhzdVZCNFRJZVRidU5oUHI0Y2lla1E4cnp5ZWFVMk5x?=
 =?utf-8?B?UzFGQ1R5Q2IxMjJuUVphYktyRjhJT2N6SUxxTTBtUzVxSVdRUmRkVUdySUxa?=
 =?utf-8?B?WmJvanhySVlhc1BCc21TUnhXOVpXTmdWS1hCclppOVR6TVdldDVHYWxYYm9l?=
 =?utf-8?B?WXVLNjBOb3dIK3pucHlsMnV1VU9ORUlGS29ReVFFVEhmM1VXQUpEY25VaS9t?=
 =?utf-8?B?ZzBjNGxxd2RtbjJhN3NXVFIycUkwUlNPbkJWWHBYUGlMekF6VVJudHYrUEI1?=
 =?utf-8?B?bkxmMDFyd2NrbWFmd0JtYWFVaC83WTVXZGo4UDRwMlVQNklLUFFLVjN6Qk45?=
 =?utf-8?B?WjA1VFZMQlp3UW9uUjNQaUhwaGJYV2dxUnlXNGdMeHlxRjlTODE1VHF6T282?=
 =?utf-8?B?RSsvVTdQY0dXWjA2VFJLVFpUYkRiYmRiRFkxZ3ZzQlZvczJwNk8yT2pWL0hR?=
 =?utf-8?B?MnBXT1V3K1JEd3l1ajZoYis3M1hHTkptR0ZnRlMyaUYwN3hyOWpVMUdra3pu?=
 =?utf-8?B?Y0NTd2hCS09jRGkrd1hmam10QVdoaUk2NGxTMFdoalQwY0o3eDhxYTBPVkFQ?=
 =?utf-8?B?VE5FdDY1cTk5a2ZuOWsxY0JEN0xlZ1VPeGdwRUNUZGE0U3lpVmJRbG5iRUhz?=
 =?utf-8?B?TUZFRXFLdm5EeVkrN2JZL3ZGeWF2UUZjbVBkK0cvaVo2OXBWekRGQUNhY2Zx?=
 =?utf-8?B?eUxHUm5VMjNvbFBtZ3Q3bVNObDNsdlIzTjFlMDByWXpYZUtsYnlXYzA3cnJP?=
 =?utf-8?B?MWRNWTg2M0I2QXJJcU81UFc4VXQrK0FXRFNhUWZVMUNzcjU1dzBiVzBzYXNE?=
 =?utf-8?B?Z0t5SG4rc1RnaEZEV1FOQTJCTmhQaTlzMjVhcXRybWdaYUI0NHIxRTZJTFB3?=
 =?utf-8?B?cDhnOXVZL0hPMUNNS1NkQ2U3eFFOdTluZWZVWnZMc0lqMzhjUzZOb1E2UDBk?=
 =?utf-8?B?L3FzaktQWU14eG5aU1Y5dXBwWnBPZTVsVlFIRHZYQjZKM01kdnBwWXpMM01t?=
 =?utf-8?B?RnEvdkhzbmFPMXlqZjJTZ0ZMdm1vNGlNbk1NT0dpL0dQRWlVUG9mSG1pS3d5?=
 =?utf-8?B?dWRmZ1d3OGdQbjVYRlRhSDBJbXFSUnVZSXFjLzB6bVhwTjJESXlYRXNlNXVz?=
 =?utf-8?B?emE1d0V1QVlPcG8wOGhsL2V5cGZueDdlMEFWZVNsOGdmRVU0WEk0Wkt3bURX?=
 =?utf-8?B?aGpFaktZdUVPRUxJMTdteHE1LzZlMDlNMGlXWmV6bXdJUEpaVEwzbFNBL3BM?=
 =?utf-8?B?azlsZk53Wms4MkNZTmU2anlHT3hhMllUaVcxSUZ4VXFVWXZhT1NSOTdMWFh6?=
 =?utf-8?B?b1lWZHR1blozY3BoRnR2eWhReUMyR3I4OTh0L3BuWFozbnRLVVYrRmt6MXNn?=
 =?utf-8?B?eXE5cWpYaUFLNmhXZFNrZXFuR1k2SU1QelhPQ0RrTmNxakRnZ1RyYTlJZ2U2?=
 =?utf-8?B?eDE1bmszNmRNQlJkeURzeFBaUm5ncUk4bndkOWl6aWxqaDlYWVNsb2s4UGl2?=
 =?utf-8?B?NWhEN1czTFc0STVBN2hUTVQzUHlQQmFRenJvamIzOWY2bEFrOGtZWFR1bjYy?=
 =?utf-8?B?ZmhkS2lVVmtZVTI2dy9wZ3hBK2ZpQUVTaFdmeGRyRTBrNEZ1TC9WdDRRRldC?=
 =?utf-8?B?MGlBNCtudVpnb3R0WmdoVlRzNXYzNlF4dTZCZHhpN0srOWtRWFZYdEFHeTVk?=
 =?utf-8?B?cStHbGRYOFhmYjZkU0x3Y3dJK3pEWUZrVmRNeFhvZmRCOUprQUJlanNmanJO?=
 =?utf-8?B?ZVB2U09BNlBFOTk2RThER0lWY09VQzJwcWdFUkVLcHJVdjB4KytMOTRCL3I0?=
 =?utf-8?B?SUlPMkZKVUNJR0s3eHBoVnQ4UTlGWU1FT3ZmVEc2VVJXTFZoekFqRjhIYUJk?=
 =?utf-8?B?Q3UwNDBSUTVjQXF6ckFkN1BYSnhQVTgxRlNQdk5xdW4xUjd1bmI5SC9QWjVs?=
 =?utf-8?B?VW0xZ3lqOWF4aWF2aWdlTjhkMWgrN1hhRmQycWNwcTI1MmJPdzZ6VTJET1Ft?=
 =?utf-8?B?OEFEOVZpNzRGM09yTUNmNkowZWVOQ1BldDZqUnVyeVYzUHRwWlp1NTNjSzZV?=
 =?utf-8?B?YnhWSHpKSWVFZTVLT1dWZGRaUzhOVjIycEtxTzIwRm05MHQ4OW9lNzhSOHlZ?=
 =?utf-8?B?aWRiMEc2MDZmMTN2ZnBpeWdvRkZEUlFqV2c2RHFFWXZyeTNCZG1PYUNpZXZK?=
 =?utf-8?B?VkM3QklIeTA4ckk1OWhERjB2OUNNYVpJa0pzdEd1d2RxR2dUc1FabXM0MVY1?=
 =?utf-8?B?djIyNVBLcWtLdWhoZDFrS1V2QXJvMXliMUVCVkNjUGJjekxXN0R1NlNEaTU1?=
 =?utf-8?B?SFRrdzV6ZnZYR0Iybno2YXJYeGk3NXlJbUlZTHlqUkxBUVZyejVMQT09?=
X-Exchange-RoutingPolicyChecked:
	qSA+cescxmqJfwI0QphymWgpWQl2qYrKwQeAzPV8btN8RTvLqTyldFk69YUwsoJgQNHs2H80DK4keWKK9fuci1BgDnbsfYZz/ZTB538NIo/G0ymYTduh8H61Pu8gL3KjZ3KM5WtJ4rsFG2D1Zbhu1pIBWy9K3Q0HLlW8J1YCYAAiMc0qGzgdQKQfWaKG7gVx+b4Zrk74L7hCUePMHRA0qAeFNlHNJr9Hol0lCLDC/EKH5lWX5SFoe8M6zVvKwezDe3qPgOvIdmKRzi3o3ICB/1Gh0gx3JyJfguN8F4lSzC3u7Bmy4sK0ACxWhV/G7uPvfYiHEa2h0glmeCO2uCouWA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	skaWXMFcQsI3tJ6hzfOKRXmdYFb6Ia3t4dq1y75STwi3Qi92Y8u9e/z9jsNxkXYC+lKk2ISCuCdU6BSOt5En0dEcsFYEcy3qqP7pvDFdTuBfdUhtFj52ISYy6wQBkmbBvrFmbFC+gGsJEFP40AiQeUrg3ZkXy52Tu0ooobMExH+nnMwfwXb8aI5Jsa9Qjnl7cemxpjgNWavezL6CIP5qSQHAin1Pqjo/u9o1juS9FQwWoEvD+ncGs8v7PdH4Yh7ET1RUhWrazzVcsAy9gqhXTh+cRnWAkNpTmI2dex7DJqd0wNxQ28oHCYsyIFp/Ef89WMgg9yMB4gU3/IPDPbJDjUStFBcUGFpIedShiBMY3+6YFKQ683EbXwE1EX/xD65X1qQhIScagcWAEiCnb5jfT+xW1E0oQsJhUA3WR37VETXo6I37KKQRJ1bFfAHk40vJr728pYXAaJpgWzysGUNfGaneb78LwdnDqAmM2I5Rp4F4/ytJspB8UCL+bSRcfNXUY9NKsr7Ndri5LzDFctZoXTUFSBd+MyfcKRVsBpCiPQ3748lv7PWWg/JMWAwpwkgTF+sFAaYyDHoK5fHF7+mdby/3Dx5/dVk8dM8kqKLbN8cK0KHrDBxMqjg7q+z0/T2+
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03530c3c-757f-443b-f51b-08deb4ae1d6c
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2043.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:21:44.6405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RdHIzOCagk1B+OAguaV1PxYScX+E33dm1dLtA3NEFMw/A8XBrjLnn48Wr4uPGF2umQ2KoGoNX0Fp8jOb7Bp3Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP192MB1607
X-MS-Exchange-CrossPremises-AuthSource: AS8P192MB2043.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 144.2.103.240
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: PAXP192MB1607.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA2OSBTYWx0ZWRfX8W1x8GGTBD8c
 t2+rKWCDQ8WBJy5PV6qE8KTn3vFXDT7c1f3f4czt1R/IR9l4qm6Q5YrucULZpGqPu/IbsWEAVd1
 S0JnUhrQpvGHWuXlON8kS++dmSxSBO3XzEx7AJIaXrPn9eXDoX9CesoktBBw7cfHUkSZYv+P7V3
 OnA+seNNBXSbbTzkEGAdCyjyb6CQsCJMandbpdGkmbyPgCQ+1xnK3656I2m8Z0PWNwv5iXuzZ3p
 bCYK/j/Hmzj0ihhF3DAc0oN6V+vJBMFKLc19tghJk1bw42I2hfPsPdGGm+EF8o5mktnGe8d7jMy
 sM1AyFOF89h9tEglk/PfOTz6e52bAAbhYLHKeiuy7f+AxR8+09VZqgcwtManv5rhFfY0EY6E11D
 6YxQoOskMCf/gwFScWxv04xm/WVnvq52eDgYHkNSzl3/C9UQdHgXwBfS3S8/iE0aEb4TSid0Gu6
 Em7bUOEpw5veU5DS1Og==
X-Proofpoint-GUID: MFF9Aw50buP4W-azt0vkQlshSgok8gHU
X-Proofpoint-ORIG-GUID: MFF9Aw50buP4W-azt0vkQlshSgok8gHU
X-Authority-Analysis: v=2.4 cv=MtFiLWae c=1 sm=1 tr=0 ts=6a0abe0b cx=c_pps
 a=YwV1dbZ4NCcMRCVFBFAcsw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=WQ4YJ39tjzx_Hbm9pN5v:22
 a=p0WdMEafAAAA:8 a=pNgXkJcRAAAA:8 a=20KFwNOVAAAA:8 a=-i4I5E_jAAAA:8
 a=F_gvssytOtQCGReap8EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=tKe0A8swS_RTMQ4Dt1Wu:22 a=YQreJwxzuLcQAHRr27xt:22
X-Rspamd-Queue-Id: 903D7568212
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[westermo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[westermo.com:s=270620241,beijerelectronicsab.onmicrosoft.com:s=selector1-beijerelectronicsab-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[westermo.com:+,beijerelectronicsab.onmicrosoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288901-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[urldefense.com:url,westermo.com:mid,westermo.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kern.info:url];
	REDIRECTOR_URL(0.00)[urldefense.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthias.may@westermo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 19/01/2026 8:55 am, Laurent Vivier wrote:
> The usbnet driver initializes net->max_mtu to ETH_MAX_MTU before calling
> the device's bind() callback. When the bind() callback sets
> dev->hard_mtu based the device's actual capability (from CDC Ethernet's
> wMaxSegmentSize descriptor), max_mtu is never updated to reflect this
> hardware limitation).
>
> This allows userspace (DHCP or IPv6 RA) to configure MTU larger than the
> device can handle, leading to silent packet drops when the backend sends
> packet exceeding the device's buffer size.
>
> Fix this by limiting net->max_mtu to the device's hard_mtu after the
> bind callback returns.
>
> See https://urldefense.com/v3/__https://gitlab.com/qemu-project/qemu/-/issues/3268__;!!I9LPvj3b!H-nIZIscCCh_2FnbJInagPxXTe0XcNu58-8k3NqGYKRdDy8LBOBjWiTIc1E-cC2wnv91MtZrak2pu7K-4cU$  and
>      https://urldefense.com/v3/__https://bugs.passt.top/attachment.cgi?bugid=189__;!!I9LPvj3b!H-nIZIscCCh_2FnbJInagPxXTe0XcNu58-8k3NqGYKRdDy8LBOBjWiTIc1E-cC2wnv91MtZrak2pq4lrvZI$
>
> Fixes: f77f0aee4da4 ("net: use core MTU range checking in USB NIC drivers")
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> Link: https://urldefense.com/v3/__https://bugs.passt.top/show_bug.cgi?id=189__;!!I9LPvj3b!H-nIZIscCCh_2FnbJInagPxXTe0XcNu58-8k3NqGYKRdDy8LBOBjWiTIc1E-cC2wnv91MtZrak2p8csXaww$
> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> ---
>   drivers/net/usb/usbnet.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index 36742e64cff7..1093c2a412d9 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -1821,9 +1821,12 @@ usbnet_probe(struct usb_interface *udev, const struct usb_device_id *prod)
>   		if ((dev->driver_info->flags & FLAG_NOARP) != 0)
>   			net->flags |= IFF_NOARP;
>   
> -		/* maybe the remote can't receive an Ethernet MTU */
> -		if (net->mtu > (dev->hard_mtu - net->hard_header_len))
> -			net->mtu = dev->hard_mtu - net->hard_header_len;
> +		if (net->max_mtu > (dev->hard_mtu - net->hard_header_len))
> +			net->max_mtu = dev->hard_mtu - net->hard_header_len;
> +
> +		if (net->mtu > net->max_mtu)
> +			net->mtu = net->max_mtu;
> +
>   	} else if (!info->in || !info->out)
>   		status = usbnet_get_endpoints(dev, udev);
>   	else {

Hi Laurent

This change was backported to 6.6.* and caused a regression with wwan 
devices via USB when using a mux.

Tested on a Quectel EM12 running the firmware 
EM12GPAR01A21M4G_01.300.01.300.

Tue May  5 09:49:35.638 2026 kern.info kernel: [   10.819620] qmi_wwan 
1-1.2:1.4: cdc-wdm0: USB WDM device
Tue May  5 09:49:35.638 2026 kern.info kernel: [   10.829601] qmi_wwan 
1-1.2:1.4 cellular0: register 'qmi_wwan' at usb-fsl-ehci.0-1.2, WWAN/QMI 
device, 6a:c3:49:88:47:b1
Tue May  5 09:49:35.638 2026 kern.info kernel: [   10.840579] usbcore: 
registered new interface driver qmi_wwan

The parent interface (we renamed it "cellular0") requires an MTU of 1504 
(4 bytes overhead from the muxer).
The actual wwan0, wwan1 interfaces have an MTU of 1500.

With this change it's no longer possible to set an MTU of 1504 on cellular0.

BR
Matthias



