Return-Path: <netdev+bounces-96570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F4A8C678E
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 15:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3141F235A5
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 13:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0730F127E0A;
	Wed, 15 May 2024 13:40:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6603B79F;
	Wed, 15 May 2024 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715780404; cv=fail; b=YzaB5apQMZL/f6hVyZYaGAQxmlELwSnkzRYxUQWcwZQz9k6OAzSzxUbAO4XTu5QB+GJ5mAT+8tevfxN4XjtiQnj3IfY6+AHd3YAKjyJ8tlC+0kFDyqry0s/CzELzED9ODvPFiyQ4gnYijdJU9shythB/BLaSJUIHPOMD4Dp4GI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715780404; c=relaxed/simple;
	bh=ZjTSlqAWIBqbE3raDKFBwmelYfidi24Up0539WKtP0o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WMcdF/LWJGxkgDWV3/d5OrClzv5qvMPNiFJ7CBHmn93+TZH4K+QGYKEky6rCpv0Z9bKtd+I3BtYJOoqZjsBKzt1ndjmkqgRB4ieAtpJ7G6rvMRY+MMmZQsl2CD1XO804Qjz9gNIZxElvS79x7MOgVqigLE/mB+BcXw/gj86UHB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44F2L8Tj011716;
	Wed, 15 May 2024 13:39:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3y1yc4c802-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 13:39:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5sbVkfpiq4MsBaXU7rUnV7WN4uYPVYvMRizgBBhvdIcROVALlghC/ygrMntjEhwb14xRVofkyCT6p3FvXyidyDLrHwKZUdlOXHUWB/ZenNnYjChZYRZY64E9WzVbPd3F1mCOYJhcIIg6Z4Ib/tPhAUxtiaC8zE4KLoBnwbht3bu31pPG1ULxHPdaCjIaE86fb0EhAz9H8CwzCHoXrPRKLVVCzSh7ExrtjlPoSIi4vTGGM8FLW+n9MB+/dJ+t3QJKtb0QOOj7iDz540nSt//nuhOCdQCJ1sJCcecAEkW35dXUmzmr2eVScJWFv++LRy+J2LAPDf1Hg45PmtiS5dN2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9jLidMo0dM+ZmtzmKYzYTr/xWkkUs6VAy9qhE38aYU=;
 b=HBmuwJaqD4JOOgHzCYUONAyC0lLXC6+jaGCEC3xvchUcd7VBLiFW0nXGx1v6rT6By9mIgznmUrT0MmriIf98Cc+CVUPZya6HQ40OeZtkWfXGg1clvrKAeI2CLLZiRAgovj7PF6XM/V4nDCDwIo8W0qB/pmj5dZ3gqiVY2cvEUvi4++qyVDB4+ewzPeMJqOhsmCVslY/yJ++Mo+xlAKdgsdvAu9K3rfUF7XQLQPHSONr+Ao4VEOkepnkt9DBrkr3HRLOXPQ/UAHggi+H1ENb+QA0HyEoOAPbybME0mcLx5t7xg5gigQ1C3+u+Otbdz0SDToj/w/u7RQy/hHXgKqsU+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH7PR11MB6401.namprd11.prod.outlook.com (2603:10b6:510:1fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 13:39:37 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 13:39:37 +0000
Message-ID: <1f62cb7e-ae5c-4769-989f-269eb2ddf845@windriver.com>
Date: Thu, 16 May 2024 00:39:29 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH] net/sched: Get stab before calling ops->change()
To: Simon Horman <horms@kernel.org>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240509024043.3532677-1-xiaolei.wang@windriver.com>
 <20240510121948.GT2347895@kernel.org>
Content-Language: en-US
From: wang xiaolei <xiaolei.wang@windriver.com>
In-Reply-To: <20240510121948.GT2347895@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:404:14::19) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|PH7PR11MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c0ad75-9ea1-45b1-64ac-08dc74e47688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cHNLYWc2VHBpY0pLR0l5L2h4dEljanlFaGYrOTl4YUNGUHJiNGhkZU85ZnBL?=
 =?utf-8?B?aUxna2xkY3JEZm5BOHFoZGdWQy9BdjFtN3N0T2ZoUVZORTk3OEVTRDhvTjY5?=
 =?utf-8?B?M2hEZWQxd1MzRmVuc1gzejFrZklKVXJpNEVvUWo2cGEvcFRFRC8rSm0rc2Nt?=
 =?utf-8?B?WG9vczQ5TklBSHAyMkQwOGVGR0NXQzBpL1BjV04rdFplTUd1a09WRG00aTZw?=
 =?utf-8?B?QmhWM1ZaL29rYWFZeFlxZmFOUXk4S04vSmxKcGZ6aUFmdWxOUm9lenhwZUFl?=
 =?utf-8?B?elB2ZU1EQkN4TkdaUGN2elM2MHFidjRWN1ozVlJMbnVxNEtyV0pUZEgxV21h?=
 =?utf-8?B?VVN4NGU5QnFTTFU4eGtFQWdiNzZpcWcxUm5Bd01jMEhzMjlhNVd6ZHZtaHcw?=
 =?utf-8?B?U1FNUXpzbDl0bkpKTzdPQXhDSHdIVk5EMFU4dG80M2Z4TlZ0LytTVWRiV3lO?=
 =?utf-8?B?R0N0bUYxVTFDY0V6S1kwaFJnbTAxVy9kdVdRLy9Hc3phTkROYnRHSUozS2Rr?=
 =?utf-8?B?VEh0VzNITVNFcVJkclRpSFZwZGdjQkRjNDFOSG1WQkQyWkRIbmdZUzFmZEVJ?=
 =?utf-8?B?RmNwbldiOE9sbU96NzV2MWhJejhXeHRSa0draHE2ZHVENkp6bDJJa05kb1Nt?=
 =?utf-8?B?YzFWVGZEaU11SU5SNytrVHdza2FCM0lhcDRabXlINXg2SVM3aVpnamZXSVJI?=
 =?utf-8?B?cXUwc1Q0YnF0RGVtYjQvTjlTUHNNbHV1M3IvbmFVRC9PRkxwMklrb1djNzFS?=
 =?utf-8?B?cERCOWdadUo0TGRJUjJ6SjZ6dk4vbXhlSXk1dWxUcDdwOFhKZElOVHAyUjZR?=
 =?utf-8?B?OU9Qa0R4Nmpoak5GUkpNNENxK1BYd0tEajBZTHVFdk9XRWJrZGI0SmZ2dXNh?=
 =?utf-8?B?d1QzeXJzUTAzV0l1OE1aM0lWT0ZmSVhkNzNBd21jZ2t5Si8wbTlGenA2SVlJ?=
 =?utf-8?B?MWpKS2FZdzg3UCtQRU5xdlJXVmxVY3ppMk5saE1vTE14cSt0RWpqdE4ySkpt?=
 =?utf-8?B?Y2h6Z082ckFIMGQzUlZDZVVYdFY5Ynhkc3BjYnBMTE9qVDNNd3Q3VkNBa3Ri?=
 =?utf-8?B?SzFCclJPbjFxb0d1VWVPMzRndkQ2ejBXbXVYM1A1cG05SnRZMFB1ZWszekNK?=
 =?utf-8?B?UEMzSU9Rb1pnY0hBVjgvbmVjL2orUGhFMk5zbTZ5UDJYdzRkdTVXeHpHSElt?=
 =?utf-8?B?UnF0VDVMV0hadWJzZkZSYUNFZVNEOStKekRuemcrNkI3YnBJYkpITzhkdGhy?=
 =?utf-8?B?dGRIcW5Ua2szMFpLS1l6bzUzV3VmSHhLZXkrbW51OFNKeGhzemZNUEs0S0lO?=
 =?utf-8?B?NFRnWkhqMFVMVHFETGFPaVpmZEJaalRYQndqSkZXdVMvYzVhZjUyZUxZRUZS?=
 =?utf-8?B?N3gzVC8vMnJlK25WOWJ5L0hqZGw2bE9vQjdrQ3hzS2E0Q05sanFGdU11SnRP?=
 =?utf-8?B?UWlQU0Z5R0RQa1BoVmNvL1pvYlQvODYveTArakVQTFhxZmFZcWxKTUNZOHdZ?=
 =?utf-8?B?SE15bDUyZXhmakMwZVowb0FFbjVJRmJVOStjU2grb05rOUxKU3ljRzFxaUlh?=
 =?utf-8?B?bDhnKzBuNVl2RFZ2c2U0eVYweWZuVzdaQ3loNFhoQlpvWGN5RnRlZHF1UXF4?=
 =?utf-8?B?d2Z4YzRMSlRHT2V1M2pkUjBLWkxDUUY3K2tTTmJGZFEyR0kzV28xMTFZNjd4?=
 =?utf-8?B?U2hUYnFYcVBrV0UwUEdKNjV3T2NXWTRsQzdiTC9Va2ZWcHRudm95TmNBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NjVHQXlJTndlbVdXclpwSlhmTmJaYlZKaXF4cTEzdlQ2a2dYT1VZTCtweHow?=
 =?utf-8?B?MTNSOFRzZlhKSHhVaFI5WTNNbUc0MWI2aUhUcHF0eW9xM1B4Y1ZJd3pTTWFD?=
 =?utf-8?B?b1pVNDViOHNLcWEvdG12VG5aTFpDdVc1MVduNW1vOEh1bituZWZIV3FtaFdB?=
 =?utf-8?B?UzRydGZnYWZ1b1JEZXgyb1ZySnJYWnhCM0hLa1RjbHYwc05GbVAvNzRucmg1?=
 =?utf-8?B?eEVJSnkzQk4zZG5rd29lOFRzWWdqZUs0dU1HZ1c1ZXRhNlkyZ3pRVCs2Yzcy?=
 =?utf-8?B?b2NnTllnOGxZakQzNElmSlV4UFlIVHlyeWxFWlMxdXVVWDNha253TzZ6NDNC?=
 =?utf-8?B?bWI4RElMdjJvUXJPc2V1bkFya0lPOTN6UGVlWktlVERyMXU0YUZTeC9PRGdR?=
 =?utf-8?B?eG1tTjl0L081azhmSXFFS0RFUCs5cTBwS3Nvcm1zYlVrYjljMFhIZWZEajc4?=
 =?utf-8?B?dWora1pqWDhieldRM056UmR2UGwvZ214aENOaW56MldkN21XeURTYjJScU1J?=
 =?utf-8?B?dXdSZlFIbVI0eDI3Zi9hRittcEYvUDJDY29UT1BXZ1l1YVc5WnlFdWJlR0ds?=
 =?utf-8?B?eEtCOVluQ0dJdU5nMWJQM3c1UE9UYXIxekhGbld6Q2tmQklTRC9lMlFBWi9X?=
 =?utf-8?B?K0k2Z1g1eFZ3TWJRdHdpYjNqa1hwVU9mSFNubUtXeDNveC82L21sSzVMM1Nw?=
 =?utf-8?B?a3dsaWNuK21aWEVpVHZnRkpsbEloa3p4M0dVWmh4dC9pYTRGL2tuRytJTE5z?=
 =?utf-8?B?TTc3S243eUZBZnhvM3A0eTI5MUp2MW1LMlh3TVVWczZ2SElONFIra3U0dlgw?=
 =?utf-8?B?MW5KVE0zbWg2NVpEWFRvMFp5anA5OUpqWUJRQ2ppZjYrR21yaGZpNEtrbjRT?=
 =?utf-8?B?bXQ5OUphb1BBck5qTkRQZnYvUGhqRy9TdUV1TVF2bWNOZkJmWGZkcFR2eVQx?=
 =?utf-8?B?RTNhWEg2SXlnNzdPb05hQzQ4QjVoUUF2SkM3M2ljOXI5QXk0Vk5sTVp6OHZS?=
 =?utf-8?B?dWpFeE5xckNnV2M4ZkZURlBlL3JRUVU3eG90OG9jZGE5bU80bFJRMmM5ME5w?=
 =?utf-8?B?ek8vTFAyM1h1c1BVN0JaaEJ2TDgvQ1VQc3JIYnkzeWRRaDQ0L1Q1NWRVVHlB?=
 =?utf-8?B?T3E4cFZDaGVJNXZjRG9Pd25Ja2JzblJBSXNpWElDeHlLakdOUGJjMTk5VzZ1?=
 =?utf-8?B?MWdvL3BHWDVFV1krbWJoTW5BYmI2RzFRZ3d5VzZyQ2Z3NFBiaDc2ZmZZL21z?=
 =?utf-8?B?ak1tOWtlZndQQjVxV1V2Vi9vM3FKNlN3L2dZL3FmL1U1MUVzT3NyYVNhK082?=
 =?utf-8?B?MC9udHpyRkhLYnRkUVhpeTdJOFFRdzZjSkQvOVRqb2owbFkrV3AreExTa1g2?=
 =?utf-8?B?dU4yL1BzajdVNTBidHRuRVdEME9WcHAwNkpiUUJwc0ZGM3RZWkg5eUdsMnFD?=
 =?utf-8?B?YS9EdGpncElBOXc3R3hTTkMxQS9LOEdGbEJvcnJuMzdrS2tEaFRoVEZjTjNh?=
 =?utf-8?B?SzJPb1BZMFNmbnVHVnBRdlNjdXNzMnhmdmVLdWNLMTM4YUFpTzFCcmx0bVZW?=
 =?utf-8?B?WVhpRiszTlhCRThJOENoL0ZDK29xSHM0dnh3c3M4R3NPZHZaOXQyQko0QlpH?=
 =?utf-8?B?ZkdQU3R6anFLTkNka0liTS9SeUwvY1VBbklDQ3F1NXVHd1NSZUovRU1sdFlm?=
 =?utf-8?B?dnRZaE91dTNOdTBKR0QxcW9pTmNaQ1A4b0tRM25WWTNmb0N0UG43ckd2eDhU?=
 =?utf-8?B?OTNuS3VOdEZmNnZFTVQ0N1BPRWhJZmJJejZhRUJyVWJMdUN3Rm1qQVpWSUVr?=
 =?utf-8?B?Q2RrNTJpbjZxdkMzWFIwelI0cmJkRlB3cmJKWGNHZzBUZlp6M3c2ZThKYUF1?=
 =?utf-8?B?N29MUTExMWlOVmdueEVQYTFreGhEVWVQd3Q4WUxZU3dYQklLZk43YXhVeDVN?=
 =?utf-8?B?V1JFUldSL3lXVkdSN2RzeGFjODlxSFBZZUR3c0FWSlpyZ3huMDNVKzRtVmhP?=
 =?utf-8?B?LzliZUZEaUF4eGlIamhOZk9qRHY2bFFrMHBJZGRGMkRockpTM1VCMVVRTHZF?=
 =?utf-8?B?V2lnTHM1bkk5T21QV3FMK244VGVxNzBvS2s2TWlyV2lMdGxoc3NrbTljeWxN?=
 =?utf-8?B?ZUVRMDlaandDMXE2TmV2Q0ZGaW4yTWVYa3hYUmxNUVFPU0MrZk9GaWNVNURQ?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c0ad75-9ea1-45b1-64ac-08dc74e47688
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 13:39:37.3612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAacqIwZz+BfhcVwV3p+6EIRy2VeiIQNwjoicK9nFEKE9BQ4vBMITe7T3ggLWPty1fQfTemu6T0U0+Y33tjbX6nDLNeI/oHV31ImAlRqBXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6401
X-Proofpoint-GUID: T4-Q4wsfrETjNnSsIzLDDx-suxbGcQtZ
X-Proofpoint-ORIG-GUID: T4-Q4wsfrETjNnSsIzLDDx-suxbGcQtZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405150095


On 5/10/24 11:19 PM, Simon Horman wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Thu, May 09, 2024 at 10:40:43AM +0800, Xiaolei Wang wrote:
>> ops->change() depends on stab, there is such a situation
>> When no parameters are passed in for the first time, stab
>> is omitted, as in configuration 1 below. At this time, a
>> warning "Warning: sch_taprio: Size table not specified, frame
>> length estimates may be inaccurate" will be received. When
>> stab is added for the second time, parameters, like configuration
>> 2 below, because the stab is still empty when ops->change()
>> is running, you will also receive the above warning.
>>
>> 1. tc qdisc replace dev eth1 parent root handle 100 taprio \
>>    num_tc 5 map 0 1 2 3 4 queues 1@0 1@1 1@2 1@3 1@4 base-time 0 \
>>    sched-entry S 1 100000 \
>>    sched-entry S 2 100000 \
>>    sched-entry S 4 100000 \
>>    max-sdu 0 0 0 0 0 0 0 200 \
>>    flags 2
>>
>>    2. tc qdisc replace dev eth1 parent root overhead 24 handle 100 taprio \
>>    num_tc 5 map 0 1 2 3 4 queues 1@0 1@1 1@2 1@3 1@4 base-time 0 \
>>    sched-entry S 1 100000 \
>>    sched-entry S 2 100000 \
>>    sched-entry S 4 100000 \
>>    max-sdu 0 0 0 0 0 0 0 200 \
>>    flags 2
>>
> Hi Xiaolei Wang,
>
> If this is a fix, targeted at the net tree, then it should probably have
> a Fixes tag here (no blank line between it and other tags).
>
>> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
>> ---
>>   net/sched/sch_api.c | 20 ++++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
>> index 60239378d43f..fec358f497d5 100644
>> --- a/net/sched/sch_api.c
>> +++ b/net/sched/sch_api.c
>> @@ -1404,6 +1404,16 @@ static int qdisc_change(struct Qdisc *sch, struct nlattr **tca,
>>        struct qdisc_size_table *ostab, *stab = NULL;
>>        int err = 0;
>>
>> +     if (tca[TCA_STAB]) {
>> +             stab = qdisc_get_stab(tca[TCA_STAB], extack);
>> +             if (IS_ERR(stab))
>> +                     return PTR_ERR(stab);
>> +     }
>> +
>> +     ostab = rtnl_dereference(sch->stab);
>> +     rcu_assign_pointer(sch->stab, stab);
>> +     qdisc_put_stab(ostab);
>> +
>>        if (tca[TCA_OPTIONS]) {
>>                if (!sch->ops->change) {
>>                        NL_SET_ERR_MSG(extack, "Change operation not supported by specified qdisc");
> I am concerned that in this case the stab will be updated even if the
> change operation is rejected by the following code in the if
> (tca[TCA_OPTIONS]) block, just below the above hunk.
>
>                  if (tca[TCA_INGRESS_BLOCK] || tca[TCA_EGRESS_BLOCK]) {
>                          NL_SET_ERR_MSG(extack, "Change of blocks is not supported");
>                          return -EOPNOTSUPP;
>                  }
> ...

Well, that makes sense, I will research further

thanks

xiaolei

>
> --
> pw-bot: under-review

