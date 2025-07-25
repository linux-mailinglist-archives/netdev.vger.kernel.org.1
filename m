Return-Path: <netdev+bounces-210163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CFCB12364
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 19:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCA51898241
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 17:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281672EFDB5;
	Fri, 25 Jul 2025 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pc5poGjF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t6p2Rre7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A592BDC33;
	Fri, 25 Jul 2025 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466312; cv=fail; b=CzDEdCTK8TW62dQJSwX1Ida4NGPa+5te1EWYEb/13ag188qTA5MpIWwyfErsk7sJZQOeBRvruuYOLZOSkX41PLTA5czQXKyQSKK4yXxqVHDzx41/PzFkBtjLUpj0TqtX69UYkRSQW9PC6jfXjODz+8ztbk9VTpTXlt55fL5dU58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466312; c=relaxed/simple;
	bh=bUG5aA96BsEXV/7Y8Hx0SwSMdxlcYKbpbHISmrBWl+0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CJN4txs/TpEldFzH08yXWVx8gr3706Fg2T6G5iKGSH0zsdXE7Au4QObiU2IpwJcqhSp27M8PNDnEWtkRsIMl/SQBX/dpshuPfmFR8C4xPIMjkaX/q8CucfOLZIi0y+q6mmdMGXdZsjVd3y9sNpFGG0hAoU6LG12mdFF1PxOM3ZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pc5poGjF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t6p2Rre7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PGCDtP007424;
	Fri, 25 Jul 2025 17:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TRhI27b7OQoCGtcaJdzGUtXNBOcuF1aIJymZIpxA8K0=; b=
	pc5poGjFEHEDPOiUymnnkKLW0DeaVP0gWwsxaKRcb/boJ1ke+DTZpKNwh5ryY6Cs
	VWZV1VpXax45QNTPsXNb3nDuwG2E54hxHvApt+ae9qARJfh1QtKoURRh9hnjYrST
	45MS21efjh7UJsXLG10cSOGkFUcmSmjEC2ljkfy6Fxbv6cTP8ltCa4k1kZ7oNota
	5wAwBWZv/Z4b/LqmytI5pY65G41GIOYMcXxxadd+CKtExUVwz8eVCw5uxVr7JZwR
	Yzx4ySC/C3nDCtQzPmY7ry16MRksVaWuHnVGU8pP5BvzCD/msMItO8cc7gImW/KY
	bBMH6N9J5OEds15p2QO8uw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w1k9k15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 17:55:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56PHVnAI010291;
	Fri, 25 Jul 2025 17:55:55 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013043.outbound.protection.outlook.com [40.93.201.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801tdbbk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 17:55:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGrHId8Fic632tcbc0Yg3TDshURwSOfOApC7CFgOkd8VBLFp52S15MGCZb5utXx3X4PaV7NxB2Gan3GVtXDcF/5DZTq+FqWZTEdDJOpondzklggM8OOyzfLWh5kdKJR9qiQ73qmFm6snw4DhD1dxg5e+myMtStlRPmxHBdUvjB49wtwkkuLrlw/WuBeuFaENkAXD+1Rrv64P9wGuIVJEn3jXRM2OoJ0u5JJ0xcBj5DTm337lhyZuDRtV7bEO9Ch8eDeTIZmAjKEZjftYBlish6GEHpQ6QCT2pIfbBxoxxXQgf+9yfrMzaSlTByFFLx9GSfcVRuLDJ7nw9AErltK8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRhI27b7OQoCGtcaJdzGUtXNBOcuF1aIJymZIpxA8K0=;
 b=BkyhOIbqo2nFl4zXPWsU9x+HQAXjnXhahAuJxRWT8k1OKm0j8vyptcWqmhJ8PQdWAgT2EqwvizhZ47oejTDmFmcSr3Gp8EHdMcwu4eSY1EE2A+sG+7oiHdzvcl7ZLpsjhoJwCA5sT6BQwIFDkxZgsNGYr9evwU0e3DJIYrHs7009YF/PS36B9JakaCJyRpYH39wzn4t6DFofR+uU7T5NMM3OmuPAFD+pkq9gELFUegsedO6NcOH77KWjYG0biAvoGlH8igHY95fjvRTtQtmiNCB3vEd1zQU4M+wQhew6g2vmSqNPInsnRE2TlVoMpPQuIrJasibIOIjOcGJq7UyR+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRhI27b7OQoCGtcaJdzGUtXNBOcuF1aIJymZIpxA8K0=;
 b=t6p2Rre7vj3NP9Hudljw8ltHt8bOkBDC5NhUNvxahOaFA9rGD9KjRi5fUfclbgTW4/ffutP6r9UeQ3/kic5WEzSzcTiYMwe6xZkMjRiDeeA+pap6dZWXZIcx5Fq7qnZ+LKMAm3cTuC50AdTsgaaDBJUK9X3bpl3HVKF3l6QibuE=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by IA4PR10MB8277.namprd10.prod.outlook.com (2603:10b6:208:566::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 17:55:51 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 17:55:51 +0000
Message-ID: <1d39a02c-92e6-4ebe-8917-cc7c2ebb70b2@oracle.com>
Date: Fri, 25 Jul 2025 23:25:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 2/5] net: ti: prueth: Adds ICSSM Ethernet
 driver
To: Parvathi Pudi <parvathi@couthit.com>, danishanwar@ti.com,
        rogerq@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        ssantosh@kernel.org, richardcochran@gmail.com, s.hauer@pengutronix.de,
        m-karicheri2@ti.com, glaroque@baylibre.com, afd@ti.com,
        saikrishnag@marvell.com, m-malladi@ti.com, jacob.e.keller@intel.com,
        kory.maincent@bootlin.com, diogo.ivo@siemens.com,
        javier.carrasco.cruz@gmail.com, horms@kernel.org, s-anna@ti.com,
        basharath@couthit.com
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vadim.fedorenko@linux.dev, pratheesh@ti.com, prajith@ti.com,
        vigneshr@ti.com, praneeth@ti.com, srk@ti.com, rogerq@ti.com,
        krishna@couthit.com, pmohan@couthit.com, mohan@couthit.com
References: <20250724072535.3062604-1-parvathi@couthit.com>
 <20250724072535.3062604-3-parvathi@couthit.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250724072535.3062604-3-parvathi@couthit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::17) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|IA4PR10MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: a36eb2bf-21ee-45a8-6040-08ddcba47e42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHo0V1BaWGNyVTZnRzdEdXB0Um9FOERUUW1vczd6NTdYdFExSlpaOU90aUZ1?=
 =?utf-8?B?TVBILzBHRUZXbE1Ub1k3OTQ3Y0x6NmFvemI4UDVJSUpRdEJsK2dnN2pzdzQ2?=
 =?utf-8?B?ajNFdzVMaWhOWmxlK0lDelZaa0t3N1ByalhESjlYb1h2ZjI5aUEwKzlacG9x?=
 =?utf-8?B?a1Z6YTFRWEY0QnNGT0F5aSt6dDl0ankwU0MrRE4xejlMMXd3Q2VvbHA3eXgx?=
 =?utf-8?B?VjY2RDVnMXYzdm5meVRqa2tURjhnSjU3Q0w2SlkxVHBnT05mRkNoam5NR0Jp?=
 =?utf-8?B?SWtLOVVJRzh6aHBFYnpYVjRCQ3JQNFpVeWkyL3p6YVNQN0V6UDlmUVlTMlRQ?=
 =?utf-8?B?TWcwZ2tJV1oyRHQyOUhuNFk5Y3Nka29kUVE2VldOY2RuRWYzY2p6d0Z4LzFX?=
 =?utf-8?B?RWxZRnlwaHRTcEh4VGpORXZKV00rZkZpUHAvbTBXcHZvRmF0RTRvM044YjJs?=
 =?utf-8?B?TlhVV0NjRGRqWk9ONlVFRExjVnh2MEkyUU53ZzZ3K1M3OXZJWnpTU1FJNTNq?=
 =?utf-8?B?VllRaE1GY0VQS2xZZXowaDRRY0tMUkE0ZEcvUFBwMjJKTlllQ3AxQ1pGQ2Vw?=
 =?utf-8?B?bWFwQ21RTHpQK0hUcmVodmJvYzh3UlBjcFBOdm50Z2pFNEMxNXQ0TGQycU94?=
 =?utf-8?B?RU1PQkRpcWJhU2o2RmV5Qkg2dzNacXQvZFByWFFLSlpGa3N4T3JVM3YyWkt4?=
 =?utf-8?B?WWRSMlNxamUrQitUcVF3aFMwK0pKbEpCVDlDWUpPSkY0emdVaFNBMDhzbEFZ?=
 =?utf-8?B?M1VrRDV4MFpPeFFiZjVuNUVTZnIwZ2tVSUJhZllDdXc1TW9mVzVBRGhUR3dR?=
 =?utf-8?B?cEJ0V3Z5SjlyQUR6VEtNT2pKcFVubjJvZ1NNNkJvaGd1eXV4cXlYZHNZREc4?=
 =?utf-8?B?QmZqbEUvc2lOc0kwNUZIZUtrT2NvOThTaEF5Q25Ld0FTZnR6WmJ0VlRhcnJU?=
 =?utf-8?B?b2tRbGJxaCt4VFViZzhYdFZZUkVQb3BnRGQyOFIwYTF4YThJdUtkZmpRNitz?=
 =?utf-8?B?cWIxeVJQNDFCZ2t1M0w5aGVTUVJwNURJRnk5TG5XNG5yT2M2VkgreDJkVU9Y?=
 =?utf-8?B?bjFQMEVDaG1jVjFGS2VNcnl1RzBRaExlVDNNSHJkUXJSdVRUdjh1b0dISWNV?=
 =?utf-8?B?ZlpSNmY5V0ZqOTZtaTJrVWJJVEhmVmlCcFkzRWRvcDI5MURqREk3emRHbk0y?=
 =?utf-8?B?RjlkRlBrOENGL2V0a2lUMEg3SzFzcXJjRVBjdEl3RGFVbmFEQ3ZQZEIzTlZ6?=
 =?utf-8?B?L05ITTh4aUhiYUV5amo5QXh3RTVUcmd2cEI2OHNYVmcxOVFUQ2hiSXphdlBX?=
 =?utf-8?B?cnVpd3pIRlgxUDEvWWUvRVBpQTBhRS8venJGWm85anBrb0xGYWprSm9weE43?=
 =?utf-8?B?MXd2dk1FaisvZ0NHdVBJcVYvQ2tSSi9JL1lmdVNRbllTc2g4LzBJQ3BqTTNZ?=
 =?utf-8?B?QTA0TUtOU1ZyYndES043VVFCNlVZcjhVUXU4V1RST2JnSGMvMTI5dDAxdU4r?=
 =?utf-8?B?Z3F1YmFvR0Yvc2hsWlh6a1VmMVBnMkxsMDNCVG1WNG40ZjBhKzVVSmVUS0lI?=
 =?utf-8?B?QU1tRmg0TG5HQXo0eGllVXc2SFRUb0R5NktiZUU4aHVxMndnSUVjak5rYVF4?=
 =?utf-8?B?Z1p2bDlXeXlQdkQxb1JYVmsrMFFhSVJqWkdEeE1JV3FDcitMNjI5TExHWC9l?=
 =?utf-8?B?VEFsd2thQ1RRVFl0UE40d3BiMUF2Tzk0WkxMaHJUNTdZcXVQTXBwY1N0T3d6?=
 =?utf-8?B?TDdHcW5Ec3hneDVjR05zVVlRT094NFlpM25GbTU4MTB6bmhTVloyT2tMb1Az?=
 =?utf-8?B?Q2c2UERmR0RSTEVSQjFwQUR4U0w5VGRNd3FKWVVVR0xHb0ZWV2NBbnp6ODBO?=
 =?utf-8?B?L3ozN0xqZEtWdzRxTGlFV0VDcm00dW1QRzJ2aUNVWWVzakE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajhKSzFXTXo5S1ZmUUJobUpVN3FyZ0hOSEpDcmNGbVQ3VnlUZWUwdFZsWGpy?=
 =?utf-8?B?Wm02OUVNK2YyL2Uwb2Y4RjZJRzQ4T21jb1hDTHc4RVRVRDd6bFRCZDhCcXU4?=
 =?utf-8?B?QW8rUWx3bFJidEx0ZFhGRDlGeGdsRTE1dS92SDc0MkxSTExsTHRPSktmR2Yr?=
 =?utf-8?B?L011U3FBN016cUZTZ1VXb3BXRmplTnpGVXJJcHg1d0dKZ2NVaUVHWWk4em9Y?=
 =?utf-8?B?SldYRzU1eGVOL0JuQzNtOXU0QkJzTkFXc2xvRFhIeW9NWVJQQWIxTVE2UWJp?=
 =?utf-8?B?S3dJSlVIclIvMUxNU1loWU1mM3c4ODdqc3B5SVpFYVdvTW5uNWpURFRENmxY?=
 =?utf-8?B?UkhKNTBKa25sckZiZUtIS2hBL3ZNOXJuUjF5VEIrUnFPS2xqRUVRVjdBSnRT?=
 =?utf-8?B?STZJNGpsTDB2T3h1ck1QaE16TzRzSjhQN1VGa2ZGUWJGYTh6UXlmU09MRkU3?=
 =?utf-8?B?MFRLMEM1SWRNbDRDYngwUS91QnhjWTVSK29uNHBQTmtGdEZCbVdSRGNGeW1a?=
 =?utf-8?B?d3Ryc3BWV0oxeUdDWW4wSmNHUGlMOFZoN21tbFVIOXcwcTRqeEtOZkxMdkZv?=
 =?utf-8?B?RSs1T0tiQndDK0wrdGZYUGU3elNwc0xiQ0IxMEdhZTNwZnFqVXFIUk1nMVI0?=
 =?utf-8?B?b1VSejV1TXhZNk8yOE9rT0ZSa2wvQWNSWk9OclA5eEpBa3IwSGQxNEltWnp3?=
 =?utf-8?B?VU9Jc1dmaUtNak1pa0tsSHRONEZvL1hVSXNuOUVpZDl3QWtWSi9tcGxKNm9v?=
 =?utf-8?B?QWlTaXM3MkVZMFBZeVNTSkNIc0lteXVnRVp4NXRtSGUzKzNuTnlIb1N2bDJL?=
 =?utf-8?B?L2x5emp1dWNMcUc0aFJIMnk5TEkwVm9pc0Z0Uk0rbnZJa1VrRkROTzFRSFFQ?=
 =?utf-8?B?a2U1dHFHQjV6WVU0MVRObnhSRTZoZGtET21NOWdIN3l0anNGT1JBa3ArNG9r?=
 =?utf-8?B?K0hLZzBWWDhkbS9MWG1DSldJeE5yZ2F3V0dudVFDeis0Z3lUWHBZM1djQmh2?=
 =?utf-8?B?N3pvT2tMM3JvUngyRjl0ZXhjcTI3VkZGMVgyUVFlckxTejR1UEhOUFlxeERn?=
 =?utf-8?B?ckNDV2E2YjJPSmVCNWV1TjRBWFVmZUZybE95OWI3UFlSMUVGOTFwRXM2VG5N?=
 =?utf-8?B?K2h4eitQZmVDM2ZEMUFobUJ6ZE5kRzh3bDBWL3lqM2pqVThLaExmdmxrRVRZ?=
 =?utf-8?B?VTRhd1F4dTN6UEpZd2VMSEgzcUJFTXVvb3RJVjBBUm9kYVpGMXpjL3RoQ0I1?=
 =?utf-8?B?Wmw2S3BOT1lWSzFRcDFVdVFYdkZJZW9aR3pLMVBNR1NYRUlVUWEvRUhzMndZ?=
 =?utf-8?B?c1g0czVJUUFDazk0QjluMThyVWZpa1EyQnZHc2pwVmdldDJIMStCNjRtRFpn?=
 =?utf-8?B?UlhhbUwxWm14N1pPS096TXZvYVYxUkNTQUZmRFVBU3VkYU92K2Q2eHdXTlly?=
 =?utf-8?B?bEEvelBld3VPNWk1NjFRdUxaRzlHdkNmdHByMzlZWVdQRDFHVEg3NTZLa0dh?=
 =?utf-8?B?NG1ZNFRUYkJCYmlRd3plR0tRc3ZMQ1ZQbmorYVV2bDVrMkNYTHI1QnNWQmQw?=
 =?utf-8?B?MkJMZE5Bem1pZUZFVVk0cEVJQjQ4OUhtbnZMeE9UaitDKzZFbklLdEpuRlRj?=
 =?utf-8?B?YjFCUzB3VnhkTmp3MDhhMDIxM2EweG5tTUxFTW03ZThzM2JNb1RTZ0JvU2h4?=
 =?utf-8?B?NVYvL3pmSld2R2dYeEZIV0RGU1ZxTkh4YUxmaEkwSU92MHJIT2ZJN0dPYmpH?=
 =?utf-8?B?K096SXhhVVpyeXhkYjFYNXFoZExobTFKb2lBUVBHY1FuSGN1N2V2RjVtbGti?=
 =?utf-8?B?ZDdGMEw2NlU0aVBKR3QxNXMvZExNUTJnN3BDQ3UzTlpHeTFDTzhjc0Z4MG1u?=
 =?utf-8?B?MGlqVUxnVE15NHFpT1hkaC9FYWltQUtOSUF4V05BN1dTcFAwL0QvajZhNmJH?=
 =?utf-8?B?N0xLM3ZVYi9Nc08yajJIR0VHaVBUcm1ka3JHTFV5SHZad3ByemU4amczQXlK?=
 =?utf-8?B?cGZlUnllTUk3R3poNXE3b2hBeWVSSkswVDBGWC8xbGVCNlZwWlVGeGJWMWVh?=
 =?utf-8?B?MkhlRlFWWitxa1NCU2k5SUdzekRwYzh5RkJ6TklQNXAyeU1lcHkzMXpUVHNE?=
 =?utf-8?Q?DBY+Vln3JRoImwmXCbOcq7ebI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xG6ehrwakpRrOXq5JBY0XwaUYmidXP0FkB1OTljo746YWpK+nBvZAqvozxkmVnheFScwLd3n2FfSHzT1uLoNKTC1mBAHzqpOe8+JBDob/kmu/W8rGXuuo6N2Jw4UgeibpjXrw/se8fHaeRhGroKwzt8nkBEJ2QbWRM0OXs8pHOZnvbYAzIZNW0gdjSVTpSQMkQ3McGYupSBGJ8mwWDCFSt8NQquHEj+Ry1Y0F3rluGZepmASC8OH+PO/wTt8bKRa302jdbfZLeedAawOQ5lG2DLjlG4yLUmQnrbvSmGujIDRbMTlw3j6uO0d4sZzcnwC5PA9Ibfh74Ebv1MzCfF4hE2qqXJIgBI2P5a5NEGzImZoB7/RiExsdqzSA6xXIo3gVgRHrzaNyhuCBdogEiAJjL57/Udm8hFubnosEWUxbwAqdKW30nCOaZCgq1k9BKoYgWeszfQYBJoet47bA8aXsxQea8o711NDnxjmVh20SfI+810Lkpo6EQL7ViKUVBRZD0yIwWbhpETZnLzB9jLBj5Yq1ZcEnIoLPkzmCl66spDzx+NIMMXTG0Om6QT5K+Cdb2eAMPGMLhTfMVBFofXK3d20FWklFtF1x++7TaQosnw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36eb2bf-21ee-45a8-6040-08ddcba47e42
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 17:55:51.3791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jDxWESXDuhT2F8C38lTKG8FsMuQRBi+Khu6q8NWou9q5V4UZyVV5N8kQnPnd9z+0Kcggf2b1r+XAks3dyUp2bxLo0IQQGc+AF7r9OczCggk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250154
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDE1MyBTYWx0ZWRfX5jouh/SUqLVL
 p4VAgAY3rTD+IVpfWQRVgRyv55PPIabURyFFgI1eY/EGbCn/QRMcGXoanuT233G7eyhElbd0xE6
 VkSi/8RVCNd86U/OWFUO+HyO/orcok0U8XyJuiliUxDKAaFLuhPFDc/cBgFfLpCSkB9dQPFz/5k
 rtpJg8R+VwcN4r6FMkvcXcj9cFCStwDYV2WVRb7S3bFlOdWRIXOjOjoZbgnqcsWT9sZnsiQAvaU
 +ub3qiySqT6ZRTNR3YbRLJ9hJfD1mHy6h/g3fhy2mvvIPfIq+p/vPeN+ekCyK5pcrqkppAjOJRD
 PzYHROkOgwZhMm8JUxaeiZptnCpjqCEnL9isMSfkeIVz4X85p9UbH2PJE4yLrJWYv8Z3wy4tMyY
 3fSSMNM14Dn/MixEx2mbGDuMrk5DQe0rfQgFZd7uGmqetXIRGNVDHy6swTVLrz/7u0ZG/pRx
X-Proofpoint-ORIG-GUID: IMHHFcPMnCC4NRIj8fFUqQ82w99de4iI
X-Proofpoint-GUID: IMHHFcPMnCC4NRIj8fFUqQ82w99de4iI
X-Authority-Analysis: v=2.4 cv=JIQ7s9Kb c=1 sm=1 tr=0 ts=6883c52c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=sozttTNsAAAA:8 a=uMrLXzhIAAAA:8 a=C4V8gzkzyXtA8UgNS3oA:9 a=QEXdDO2ut3YA:10
 a=jlbCQfFxfIo9zxDJvpnn:22



On 7/24/2025 12:53 PM, Parvathi Pudi wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> Updates Kernel configuration to enable PRUETH driver and its dependencies
> along with makefile changes to add the new PRUETH driver.
> 
> Changes includes init and deinit of ICSSM PRU Ethernet driver including
> net dev registration and firmware loading for DUAL-MAC mode running on
> PRU-ICSS2 instance.
> 
> Changes also includes link handling, PRU booting, default firmware loading
> and PRU stopping using existing remoteproc driver APIs.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
> ---
>   drivers/net/ethernet/ti/Kconfig              |  12 +
>   drivers/net/ethernet/ti/Makefile             |   3 +
>   drivers/net/ethernet/ti/icssm/icssm_prueth.c | 610 +++++++++++++++++++
>   drivers/net/ethernet/ti/icssm/icssm_prueth.h | 100 +++
>   4 files changed, 725 insertions(+)
>   create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth.c
>   create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth.h
> 
> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
> index a07c910c497a..ab20f22524cb 100644
> --- a/drivers/net/ethernet/ti/Kconfig
> +++ b/drivers/net/ethernet/ti/Kconfig
> @@ -229,4 +229,16 @@ config TI_ICSS_IEP
>   	  To compile this driver as a module, choose M here. The module
>   	  will be called icss_iep.
>   
> +config TI_PRUETH
> +	tristate "TI PRU Ethernet EMAC driver"
> +	depends on PRU_REMOTEPROC
> +	depends on NET_SWITCHDEV
> +	select TI_ICSS_IEP
> +	imply PTP_1588_CLOCK
> +	help
> +	  Some TI SoCs has Programmable Realtime Units (PRUs) cores which can

Some TI SoCs have Programmable Realtime Unit (PRU)

> +	  support Single or Dual Ethernet ports with help of firmware code running

with the help of firmware code running

> +	  on PRU cores. This driver supports remoteproc based communication to
> +	  PRU firmware to expose ethernet interface to Linux.

ethernet -> Ethernet

> +
>   endif # NET_VENDOR_TI
> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
> index cbcf44806924..93c0a4d0e33a 100644
> --- a/drivers/net/ethernet/ti/Makefile
> +++ b/drivers/net/ethernet/ti/Makefile
> @@ -3,6 +3,9 @@
>   # Makefile for the TI network device drivers.
>   #
>   
> +obj-$(CONFIG_TI_PRUETH) += icssm-prueth.o
> +icssm-prueth-y := icssm/icssm_prueth.o
> +
>   obj-$(CONFIG_TI_CPSW) += cpsw-common.o
>   obj-$(CONFIG_TI_DAVINCI_EMAC) += cpsw-common.o
>   obj-$(CONFIG_TI_CPSW_SWITCHDEV) += cpsw-common.o
> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> new file mode 100644
> index 000000000000..375fd636684d
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> @@ -0,0 +1,610 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* Texas Instruments ICSSM Ethernet Driver
> + *
> + * Copyright (C) 2018-2022 Texas Instruments Incorporated - https://urldefense.com/v3/__https://www.ti.com/__;!!ACWV5N9M2RV99hQ!KJSw49T9tFMkKlUCkufdpPMrYbxZqO8afwgd1oNYrR_r0dienongkVB3K8jc1UDBehhE_eMQGHAGYrvO9wPpJQ$
> + *
> + */
> +
> +#include <linux/etherdevice.h>
> +#include <linux/genalloc.h>
> +#include <linux/if_bridge.h>
> +#include <linux/if_hsr.h>
> +#include <linux/if_vlan.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/net_tstamp.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_mdio.h>
> +#include <linux/of_net.h>
> +#include <linux/platform_device.h>
> +#include <linux/phy.h>
> +#include <linux/remoteproc/pruss.h>
> +#include <linux/ptp_classify.h>
> +#include <linux/regmap.h>
> +#include <linux/remoteproc.h>
> +#include <net/pkt_cls.h>
> +
> +#include "icssm_prueth.h"
> +
> +/* called back by PHY layer if there is change in link state of hw port*/
> +static void icssm_emac_adjust_link(struct net_device *ndev)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct phy_device *phydev = emac->phydev;
> +	bool new_state = false;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&emac->lock, flags);
> +
> +	if (phydev->link) {
> +		/* check the mode of operation */
> +		if (phydev->duplex != emac->duplex) {
> +			new_state = true;
> +			emac->duplex = phydev->duplex;
> +		}
> +		if (phydev->speed != emac->speed) {
> +			new_state = true;
> +			emac->speed = phydev->speed;
> +		}
> +		if (!emac->link) {
> +			new_state = true;
> +			emac->link = 1;
> +		}
> +	} else if (emac->link) {
> +		new_state = true;
> +		emac->link = 0;
> +	}
> +
> +	if (new_state)
> +		phy_print_status(phydev);
> +
> +	if (emac->link) {
> +	       /* reactivate the transmit queue if it is stopped */
> +		if (netif_running(ndev) && netif_queue_stopped(ndev))
> +			netif_wake_queue(ndev);
> +	} else {
> +		if (!netif_queue_stopped(ndev))
> +			netif_stop_queue(ndev);
> +	}
> +
> +	spin_unlock_irqrestore(&emac->lock, flags);
> +}
> +
> +static int icssm_emac_set_boot_pru(struct prueth_emac *emac,
> +				   struct net_device *ndev)
> +{
> +	const struct prueth_firmware *pru_firmwares;
> +	struct prueth *prueth = emac->prueth;
> +	const char *fw_name;
> +	int ret;
> +
> +	pru_firmwares = &prueth->fw_data->fw_pru[emac->port_id - 1];

If emac->port_id == 0, this will index at -1

> +	fw_name = pru_firmwares->fw_name[prueth->eth_type];
> +	if (!fw_name) {
> +		netdev_err(ndev, "eth_type %d not supported\n",
> +			   prueth->eth_type);
> +		return -ENODEV;
> +	}
> +
> +	ret = rproc_set_firmware(emac->pru, fw_name);
> +	if (ret) {
> +		netdev_err(ndev, "failed to set PRU0 firmware %s: %d\n",

Hardcoded PRU0 in Logs, what if PRU1

> +			   fw_name, ret);
> +		return ret;
> +	}
> +
> +	ret = rproc_boot(emac->pru);
> +	if (ret) {
> +		netdev_err(ndev, "failed to boot PRU0: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * icssm_emac_ndo_open - EMAC device open
> + * @ndev: network adapter device
> + *
> + * Called when system wants to start the interface.
> + *
> + * Return: 0 for a successful open, or appropriate error code
> + */
> +static int icssm_emac_ndo_open(struct net_device *ndev)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	int ret;
> +
> +	ret = icssm_emac_set_boot_pru(emac, ndev);
> +	if (ret)
> +		return ret;
> +
> +	/* start PHY */
> +	phy_start(emac->phydev);
> +
> +	return 0;
> +}

Thanks,
Alok

