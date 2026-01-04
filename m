Return-Path: <netdev+bounces-246765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D495CF1118
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 15:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA09F300B999
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 14:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563131F78E6;
	Sun,  4 Jan 2026 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wf9cBzgZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oOBJ9QHu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FE42BCF5;
	Sun,  4 Jan 2026 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767537064; cv=fail; b=Q7ht7ncN7r927CJ0SG/CvfXbI1b80gW3GjoBoyxcvgB57o2GO8F8paUW+CvkJIy902flC0PiwosVy8ieFr7/nX1GZYz5U8xf1HFwje7ak9GxwD7ZuHsugN+SSXuf900ldUHi7GKhnnmQaJn57LQFLdM9oUVbeKDg6jjTVCFi00k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767537064; c=relaxed/simple;
	bh=+h/X45WP2QIz++b8FvXHSFF6hfK0IdmitpbMFXAqkEE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gdu4Z5kY/5W8m5c6x8XzVfgRdYg//Q31PZzOHR3H7zfVpVYxVbiDZpJDc/FU4+N4LMFrPpFq23e1tPqKPr38FH5l1PDaI3kDnBHShTSQ6+zJ6shsjEjENOzKGe0MH3lUtvLR4xbjS8w+tFonE2z0HUALf4E2imV1GJyV54qfurU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wf9cBzgZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oOBJ9QHu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 604DDXSq3370417;
	Sun, 4 Jan 2026 14:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mpo+S9/UrFRysrFQL//BuSUIThHRRZb8WSWQSgo4Gdg=; b=
	Wf9cBzgZXeCGa8OGLpWnHoXYshI35V7vO9y3plMZjbN6eUedVIvo6z0kdiirNsHy
	tXZavzJcVsAuK65Y5PSlKVA7OaAqbKS6h33cQuQcuZl5fqvlu40mumwIutscfZq7
	beJAxngeXsiFl3rdfhHZChhwyRMS8fCSD6dumayxPB4VLvrUh/BlpCVYXAlCM1wp
	VoDkzizYQNIccF6Gpbm9iAgMUD2jOkuBfBUFZUMTFtLZQfVPUU7RjLCkXR0Zg28x
	vHWXcbg7z+mqz2NiT0Y1UENE/YyDqU2QPYX/0D+FmGrr+qBXW1MDCNHI4KJiT54F
	ukX+OycyZImjOCFXBmPEWA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev5qgs15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 Jan 2026 14:30:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 604A3hdo030735;
	Sun, 4 Jan 2026 14:30:25 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013024.outbound.protection.outlook.com [40.93.196.24])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjak4aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 Jan 2026 14:30:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfQA2qFgXc7olZJG8/zUWZdGpjUlAiyCLukUKU4LFGJVSPdtvx93uoQmNhMxMeVpR6zJ4yfGLLLiIcvraU3lvsaEauG7fwmEG82AFGlDQ4dji+krYi73KhPgTmQxG4Yw3UWz3UXB+Zhf4ZOmR6IdGj1RUn+WS24SpwdVeoTOWPEON2woz9r2KF13BwwAuQoVBw01syD+stLeSIxmzDO9H6PqcJY0dTHdfKjY42eCYyxu12IJwQFo7nI25VR370nn4AhSNVm39eUF3VukNW7xRyTAkXAkL+njzVgQXJBfQePF/Fc6S+kt+YIP6ZpsdYpzSY40VBJwlFUttTYJ8bW/eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpo+S9/UrFRysrFQL//BuSUIThHRRZb8WSWQSgo4Gdg=;
 b=XiMRqSwhLDttGw06Rs/UaOsmbyDDy/bWeJICeA5fBKyz20nC9+tqraYEY2ulsg3ZvI4G/0ASvCezTB4+o8ngOw+PWsob7L/qDbt0VOIFPuNW0bbuMC6soWhRQr7unUgI62xmTcdOdXwj3HRokuDH4kiTtasja+TJ69ErwKRFnHkplc5hAYTuuIt7a0VNL9H5IKVukyUeQxjK4TyuMmHL/3aJ97GHqHznbuHqY2/FpRXDai8BixukgchguXatQOjN+ns2OBwnVCKAGWwFIPdW42+3NgNZ5jde9Qdz91jaRX3yqz+7yjKVRuWM3w6quIpIcVqPtEfUB+VnpirlQ1X/tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpo+S9/UrFRysrFQL//BuSUIThHRRZb8WSWQSgo4Gdg=;
 b=oOBJ9QHuNM0j+HEO+rvUuPHhJzoKuSyBaqsgLMXPkkpZxXuN0n31iUpDkYUaavcg6upTyP8XFm75sK68iPS/Wib4AdDM+WriuRRBMWPHUhyrFnH82Uf4BiJAUUVbwoRG6EPMStI/TdN77kADHdRBYfG2zLY+uMGcgwwdgLMeraQ=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SN4PR10MB5544.namprd10.prod.outlook.com (2603:10b6:806:1eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sun, 4 Jan
 2026 14:30:22 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9478.004; Sun, 4 Jan 2026
 14:30:22 +0000
Message-ID: <a5a06220-1245-40c8-a80e-151c1f7a0993@oracle.com>
Date: Sun, 4 Jan 2026 20:00:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] net: phy: realtek: use paged access for
 MDIO_MMD_VEND2 in C22 mode
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
 <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Klein <michael@fossekall.de>,
        Aleksander Jan Bajkowski
 <olek2@wp.pl>,
        Bevan Weiss <bevan.weiss@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1767531485.git.daniel@makrotopia.org>
 <d7053fe51fb857b634880be5dcec253858f01aff.1767531485.git.daniel@makrotopia.org>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <d7053fe51fb857b634880be5dcec253858f01aff.1767531485.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0019.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::30) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SN4PR10MB5544:EE_
X-MS-Office365-Filtering-Correlation-Id: 3af34d8f-9f39-474c-1c16-08de4b9dcb15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bU8zUHJ3aEFnem8zUTBjdkNrRXQrZmp6RHlmSHlYeWtRcjhBSytPZGVjR2VV?=
 =?utf-8?B?UmJoK0YyWDdodW1ZVUpOd1ZZbmc0TkVmWEdEZXZOZFpYb0hXeEkrbTFkUzdX?=
 =?utf-8?B?K2s5MG1wUHgrTWNSdjEvN0oyN3llRVdPdFZsZ2RFZXJMbXo3ODJUQitlalRt?=
 =?utf-8?B?YlBXRnA5SWlxRFZhTXdhN3JBQU9SN3BCRWx3TnBEZ28wWkt2UmhxZTdnV1pJ?=
 =?utf-8?B?UnFsLzJNNHJEckJWZDdHWXlzVTZLNFNoNVJrZmF2WU0zdGZnb3RMWEhoUU5V?=
 =?utf-8?B?Z1RjYVZjZlo2cXFpMHhPTlNnY2lDRTUrNWR3R09jcEhCa0JaWkNaMTFsanVa?=
 =?utf-8?B?SHB6a1Z0NWNzaXNEVFZGN0YwY0RSK1MyRUhzbVFYNFpLSVVWcDRha3VmUXht?=
 =?utf-8?B?ekwwMDZkUmhScytpeWFiMkQ5czJjbG5jZ2NsY0tMbDBXS3FVM0tsSjlaZHdj?=
 =?utf-8?B?eEs4NjlEcjJ5YThnYURmL24zbzhLTTFtZ3l4aU5HdlgvUWR0N2d3TU5LQ01M?=
 =?utf-8?B?SE1FM0N1bDU1dDd3dHZsK2lPTlpPN3YySjJESnlXUEplNXV0M25mb2ZQS1Jo?=
 =?utf-8?B?cENFOWpMczI2OFg2VGJBVy9oazlwT1RCNWI0VnlReWxmTlNjb2l2eUxlWWIx?=
 =?utf-8?B?dTRMRlp1ejhYcko3MnlMdFJ3VWFnT0R0RTRKZEJLYWpBb3BqZGxYOFVtUHFx?=
 =?utf-8?B?SXFPUFFKeFZ4UHVSaTAvRFlJNWFkUnJjREllSFIwaW9Id2pXNXJNUTk3UEZz?=
 =?utf-8?B?dUltckdsZFkyVENHbUVPWU5RTk9sU3EwekhBaGlHR1dMREgzRFFoV3g5RXp6?=
 =?utf-8?B?YzZpWUlKR2YxVFM2dGh2OGJyVXVlWThTNlhLbE45djV3YUlyUTNtNkVBdlB1?=
 =?utf-8?B?aTgzSWZiT2daWDJnREtaaE5vSHRvVy90cXRCOElyY3VxRkpKemJCUXVXV3l6?=
 =?utf-8?B?WWUvU2JwNjF4RlYzR0oyb2hlN3M1U25VQXZFSWswWkc1eDdqclMvSDJRU0dq?=
 =?utf-8?B?WXhvWjQxcGV1LzJENXYwYUt0M0dTVWtpYi9nMXhrUHVCajg0QlJpRnU2d0Rp?=
 =?utf-8?B?WEZ2TlI4N05VVDdqL3k2TnU5cGg4ZmRVOHJFOUwxN01xTnJSZGEzeEJyM3BS?=
 =?utf-8?B?MXlENWc0bU1NT2NRbDlRWGpUZkhjdVhnbEZIRmEyNW9SYU9SQWtJcWNqVHJE?=
 =?utf-8?B?NUsweDkza2dyYk4zS29vWkJJZlJUT3hXYW93Um1nQXF3MDQxUUlTMHBTeFE1?=
 =?utf-8?B?akEydGl2Z3Z3TkEwR0FqMjZDOG03dlZtcTUyVEYzNlc2ZkYwWC8xbVhOdC9p?=
 =?utf-8?B?cGdCNjJLeVVORG1NdXlPaGEyUE04TDZyVXE2eWw3dk1hSERsbGNHZFBxc1Mv?=
 =?utf-8?B?RFh2aFZDU0twSmY4cnA5T1lXbkJvT1oxWlprV0NJd1FadkMzdGJtbE5NSVJz?=
 =?utf-8?B?aVdVcU03RVI1Y2h5dVZJQjZLSktLZ3JwTjhFc0l2dnpwLzQ3SGV0QmtCMFRE?=
 =?utf-8?B?R1hRejl6VlpFcGV6cXN6RmZta05MR2dwcGxpdEJuanBkZk5acElyNHZQWkFk?=
 =?utf-8?B?bTFjOC9HL3FZMGREYk9LOHI4VXdvc0llQWFSV2MrTmVMNEVOOWViQXlraFBP?=
 =?utf-8?B?RnpwZW9FNjUvZmtYZCszUWhETWFWNCttQW9ZNVk3a0xOUHJpTm1XNjhQb3cv?=
 =?utf-8?B?R3hMV1VXM0VibVdBNE85RHlIZ3lLcDNlT09iejZmRUJXN0hoa1pZTlN4NkVo?=
 =?utf-8?B?ZUZLMW0vUnRtVktTcHFGMmVzcVJCRmVxeVoxY2hWcFlldjBiUHV4TUdlYU1Z?=
 =?utf-8?B?MWpGWmMyeEtEYXVRMVZ0aCs1REF6b25qcUhiMWpFWitOdXorVkI2OG1NaWI2?=
 =?utf-8?B?MlJmTlRMczVyV0x3cGU3VEc3c1hsK2NqMkVaTkxlTXV4YjNVK0ppaGtYbXJ6?=
 =?utf-8?B?Mjg1K2E5d0puU290T1JQZ0xtaUQ0eTZvZWt1VUYyTU5idHZZS2pCbUNFL0tF?=
 =?utf-8?Q?Pb9Hsg+CUABHFLne+fOqZyJyYgageQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmI0VlJ6ZE1BWVhJVkZiYmR5N0J5MTJTZGlIeERLZzJsd3kxSWNRblBMeGp5?=
 =?utf-8?B?T0tLR3d6VVViZ1Y5bGdRK2dLTDZ2L3N5ZTY1bEtHYTVNM1VQenVwY01ocVAz?=
 =?utf-8?B?clFjUnlCVjdIOHFjVXN2RVZMcFNVYTFJSXVsenJCM0RsUzBMaXEvWmJ5ekhz?=
 =?utf-8?B?MklDSElaTW5aMVZuUnZNNjlYWjB6azgvUnp2dkFpb3N5UDM1cC9GeDhBSFdx?=
 =?utf-8?B?YkY3VW1RZ0dDKysxOXllZXlISnE2VVpiNEVXNERZcWhWYWhCaUIvbEU3cUp1?=
 =?utf-8?B?TFpjWklWMmVXVVE5SEtka3hCN2llOTdvcXB4SEpENXdUN1ZDMStJWG10RFMz?=
 =?utf-8?B?RHZoaWxaR0c3Sk5SNjBsUUZGajRNUk9YMlhCMCt6ajNSOUlpcjlhRmpHS0d5?=
 =?utf-8?B?Y2xZa0RxOHhFbHA4bmtaUW5NZDlBeDh6L00zWE9EQ3NKZ3dENi9wYXQ1Z3RO?=
 =?utf-8?B?N2ZjREZjRVRpdzR4VitLY0o3QzJOL1BzT2c5WDBWQlRBTWpHSzNaamlWZTgr?=
 =?utf-8?B?L1J0NHpacmRIMUlWelN5dWp1SkFkeHZRUUw1eGZEOUFrK1ZCaTk1VENZd3Y5?=
 =?utf-8?B?alNkMFJxVlVKZmlhNU5laGUyaGdudUZDNnlXN0ZmcEVUUUQ0VjhMRkVsSCtR?=
 =?utf-8?B?NmJhNUlDS3FEbmNzSXR4eWxDdnlKNTdsNGVrRW52aExCZElaSTRrU0pGR0JC?=
 =?utf-8?B?UEJtdXpUMERBMzh6TDJxYzFFYk14ZHQ0cTIzVERBRTdCTmZzMjd0SVVXbG8w?=
 =?utf-8?B?a09od1ZwdlR6b2k3Sm1mM0RPenZwaVh3VWMzL1M3anJGUHdvam1zK011NFlx?=
 =?utf-8?B?Z1JpS3ViOFVPVzdPZDh5UkNlZlRKWE4wcmRsTGJvM29UNFZSODNpUHZCM094?=
 =?utf-8?B?T1R3VWMrVXlXR1FjUUV5WGlQbGZPNUxvOGhVcktWd0JLVzZwY1RMckQyZ2sr?=
 =?utf-8?B?ZDJpdC80dHN4ZnZXb3pHd1hCZ0NKU3RVMmRrVFdRVW5hYnVFaXBGaFFHd1Vh?=
 =?utf-8?B?T3IweFVSUElZM2NDZXEwdHBiYm1OY0drdVRtSjUwRlFIT1NtbExLQTdWL3NR?=
 =?utf-8?B?YWhtMitzVWR4aEl6QUhIeUNVc3YvcDJyRFcyQ2hMS0FtRHZGN0xiWnIwZFN5?=
 =?utf-8?B?SzE3STdGR3NVbjJTNXNlMWhwc1ZOK3Rpd3R0NTRIUXV5OGUrVC9ZaG50N1pl?=
 =?utf-8?B?L3c1cE5UVHNVV2RDU0NqQ1pBWERRNEV6Z1hPRFBqZldWRU03eEVBR0p1eGtN?=
 =?utf-8?B?SjNBYnhNblkxdWlwSERUZXlQdXNUY2pxN0htK2RJNzM3OU5qdk1EY1RUcDRi?=
 =?utf-8?B?SGpzMHZ5TWZlUC9RUmJxYStGUkNrVmNwSzMrd3RNZW1TMUM1M2llbjlGdzlC?=
 =?utf-8?B?ZTkrek1pZHdNVWErd3JDSDFsb0U3L2xhWGgxZStKQzhkd21wSW5QVi9YT0px?=
 =?utf-8?B?cXBYOGVYc2ZtbGVQQkRpNXNRUkNhTGc0ZWxKUG1tU2Fiemk4U0MwVmh3Z1Ax?=
 =?utf-8?B?alI0djBvdjV2amVTOHdxRzVHa2NmdHE0NDFHV1N1WVp1QXNOY2I2RVEvVGl5?=
 =?utf-8?B?ck8xaURCQ2MzblpBMzdKWFNlNlE4cDJSdjZIbVMwYjAxMUVOZHh6aDdPMGdP?=
 =?utf-8?B?VXliSEJ5eUxtK2lJUzZ4cW5WakR0ZjA3TzcwT2wxbFBsYWxYcStLZC92OGhF?=
 =?utf-8?B?SU5Lcm1qWFNPcDBoc0EyMEthWTU5NThJQkVZNW1GOXBoUW5Zd1R2UTJoU1ln?=
 =?utf-8?B?djl1L2lxTytnNnpTRnFyWFIzZndzSGFMZFozdk9tNUhDZEdQUFU1N05VWmdC?=
 =?utf-8?B?REdjK25MWGUvRkpORWZUbkZoamt2R0lJbUp6bit4Y1VmUXFtUitudUJDVzZC?=
 =?utf-8?B?aFVWQ2pHL1E3ajZYNkl1ZktocERXZ2NkSEorSG1Ta1ZZWUIwZW1TakpYZDRw?=
 =?utf-8?B?NVR4R2RXU3prUlBnWVFHUzl2bXN0dUlxT3duNVRNMUpKWjZvWTRkVkVMai82?=
 =?utf-8?B?aXZUeVFKSFZLYlRaR0xDYjNOcThNd3V4VktHcjEwdUFyYWdMdVdacU9YYUR1?=
 =?utf-8?B?S3JVWFZpTUUvaTA0dm5RYUdFZGp4RFl4M3Z6blpOWUpXNXFOeGk2ekttVlVL?=
 =?utf-8?B?TjZ0SlRrZ2hrcU42RDc1SHJiVUhOTWlZN3dRMVRVUDlBaThGSWtHNDFBWU00?=
 =?utf-8?B?ZFBHRjVmK2FBZ2J5cDhGUEljUXJ3Yzc4NGhoem9sYVdtQXdIbXFnWXVXbDdi?=
 =?utf-8?B?TG9mSDlYaWEzbEh6WWpaN2FLcTUxVnVIV1RXc2ZDU3FnT1N1aS80SjZSaW5G?=
 =?utf-8?B?YWU5V2JSUWgwVU5YdUFicUlPZTc3MGVlQXFPNWV1dkwvWk55V0Vrdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	riazhWwgrtNMUj3OVQFJCEnQPwx9mMIsN/Hh7O5b8WMsZg1bLp17bbvTTHoqKCp1hTosG9ivR5kYX7CtP+FwZqgVd62zcGg1/5Tjx9PcwGOoI6axiAt6OnW3Mi4UkmVjzlyCAsxFCX+IAe1OrnRrCn30Be239R/I8peUftJvzzGdMSGQ1YFt4JpYhSt2tBfAw4ibIhted9XFO+QbrztWxnFxpC0641fQhcx9NXksmMWvrUjrjVXh8zZv6lpDFKwG2VOrqM/Y1XBMJj+WFhdaA1G13ShAu01iXr+rqrLTjpXlGj5gN4ne1XPg69zB7d5pqisWcrpVnO+XHnxhH3GkKM9y1UOPJWSH6Mrv3axbfBDfEy7w29308yK4ZaNOUDXxcikRH9rjXoiFYZNWLZKgu6rARDU2iRgz3xws6FGP7NeyiUlKRc0sEEQ28b4VWP6bISIBSzUuLS/AQG5p0WdaqL/4JGKNtzm3WDyyuJKfCBh8wvSXbFG7ApItivfDA1px025Np6KwulqfrMFYsm0yWHUxco8FcuEZ0ceGl2BuPqUSpyUmf/hLLMJhh4f3gT4cxEkAwpetijiUHXTvX+lsK3B/DAkdJegyA7M/H9iE9hI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af34d8f-9f39-474c-1c16-08de4b9dcb15
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2026 14:30:22.5534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k44OfINxcnTBdON4AGrfbeMRBziSzNnJvkhhSiBhyb6BTPJ3MsDstIp2XzuHxku3JZV8SfuLSinweCv61ibHORQTEKHUtSbFW5SALjz8q4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_04,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601040134
X-Proofpoint-GUID: QT57ROWKunTv44odBXsfmfEfSAQGX7zq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDEzNSBTYWx0ZWRfX9aK5F7KGNNgX
 4c7zOHKawOs0jTQav74KB0L2xBBFHu8hlOQQ4+8lxgVTkueg81qYPRDOzblbrtjKVCCW/UBtTf4
 R/UNmC5bNx8rtz/a6bUnx9fd2mgBDM4ssTDxJs/0Eo05fO/TsVp6t0KlitI1A6XuQsa2APP9/fk
 ge25IMaC2Sg8x1uWPDALZkzVaKwUSAeK40EaoTh/Yly5n8aMjtFp9Azu+84/QQc0lyCPUkXZkIX
 qGpVGr6qdb3Y4ufbmy32OVyES0zc+nfAO+DhAXU5CfmZeFOb+lXGAQA3dvcSUts8mTAgSXSYIZ0
 9SH3XbJV0dXrZwAIzUj3Q4/eG7aF4Z295+ZNmQnMOk8tTmyMmrgpc9sZk3jGKqVdN+00lEnopnO
 +qwPALX7n1A6WpqXNGOob8hteoilxDbWxDYTAJV8Gn3+z1WVr+KpB+oG2rVlnFl2egl8RFWoQOA
 WTmc8lZYBDx3U3hiJoCaetXtMxL+nSVjlc9IT4W0=
X-Proofpoint-ORIG-GUID: QT57ROWKunTv44odBXsfmfEfSAQGX7zq
X-Authority-Analysis: v=2.4 cv=cePfb3DM c=1 sm=1 tr=0 ts=695a7982 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=CTo1m2wuHQWF0zf0j1AA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13654



On 1/4/2026 6:42 PM, Daniel Golle wrote:
> +static int rtl822xb_read_mmd(struct phy_device *phydev, int devnum, u16 reg)
> +{
> +	int oldpage, ret, read_ret;
> +	u16 page;
> +
> +	/* Use Clause-45 bus access in case it is available */
> +	if (phydev->is_c45)
> +		return __mdiobus_c45_read(phydev->mdio.bus, phydev->mdio.addr,
> +					  devnum, mmdreg);
> +

mmdreg is not defined.

> +	/* Use indirect access via MII_MMD_CTRL and MII_MMD_DATA for all
> +	 * MMDs except MDIO_MMD_VEND2
> +	 */
> +	if (devnum != MDIO_MMD_VEND2) {
> +		__mdiobus_write(phydev->mdio.bus, phydev->mdio.addr,
> +				MII_MMD_CTRL, devnum);
> +		__mdiobus_write(phydev->mdio.bus, phydev->mdio.addr,
> +				MII_MMD_DATA, mmdreg);
> +		__mdiobus_write(phydev->mdio.bus, phydev->mdio.addr,
> +				MII_MMD_CTRL, devnum | MII_MMD_CTRL_NOINCR);
> +
> +		return __mdiobus_read(phydev->mdio.bus, phydev->mdio.addr,
> +				       MII_MMD_DATA);
> +	}
> +
> +	/* Use paged access for MDIO_MMD_VEND2 over Clause-22 */
> +	page = RTL822X_VND2_TO_PAGE(reg);
> +	oldpage = __phy_read(phydev, RTL821x_PAGE_SELECT);
> +	if (oldpage < 0)
> +		return ret;
> +
> +	if (oldpage != page) {
> +		ret = __phy_write(phydev, RTL821x_PAGE_SELECT, page);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	read_ret = __phy_read(phydev, RTL822X_VND2_TO_PAGE_REG(reg));
> +	if (oldpage != page) {
> +		ret = __phy_write(phydev, RTL821x_PAGE_SELECT, oldpage);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return read_ret;
> +}

Thanks,
Alok

