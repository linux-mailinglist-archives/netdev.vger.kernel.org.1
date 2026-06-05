Return-Path: <netdev+bounces-295631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vAaxBE9cImrDVQEAu9opvQ
	(envelope-from <netdev+bounces-295631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 07:19:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62176645269
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 07:19:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=ZXWWYUPy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295631-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295631-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69115300F149
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 05:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004AD3A9DB9;
	Fri,  5 Jun 2026 05:19:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012048.outbound.protection.outlook.com [52.103.2.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F586175D53;
	Fri,  5 Jun 2026 05:19:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780636746; cv=fail; b=hO/3EdxxGbbSVMbh8uWqbcN4RyzsTUdKj2MGw1fm2P9dylqey7uP3FLiMKKHcT7UXwfPXyEvwyMihQq6A32cs0o9aEDrH5aHrONnL4R0IDBQC2yVHyX1m4KN21uZij1hnx2JLFWx++O1WVsgWtmpQHzWsqITN+pB6TI/2Kj+5Fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780636746; c=relaxed/simple;
	bh=PsM2huVqYJTCi8fhX6R9y0f0pNF7FnEdPvQ0H2EZdIs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wi34o3eaV5ZFuBCzG3LYh8l8mEDbhOuQj1S8DZlpgoFHPhDvRUylt/ToJr8jksBXKTitYyrYp+HDIN+QTsGKa5Hx7OX5HtqO+GOIqOqNbnV0e6KM+pM3UVao4f7s1oX9NfXEuQL5kk0OWtYPNMzNLB+6nCJEOyrceGuq/RtzUgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZXWWYUPy; arc=fail smtp.client-ip=52.103.2.48
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGlOCRvZSvBljSlAT+KuTKMlgVVkLzzbK5c1d7xhW53FelNEtR7EW9/n970PAkOGCPSOnoD0zEcXlfxj2Pt9ai1iEAK9tMqJ4w7pQfR5kQIBfAd8QUE+eA7HuBkFqd5GROhackhnPtT3IeBE31PQCHTir0vTE469wurn4rM1c+Gfx4ML+7vkDbYhxxTzr4PG2bDqrKEl9r6UQqVMhigwz2FAF4yFBeQOGi5v7ufJPO0Qz2uSR4YCgzULyXW5Z7ZPBppmH/FYXQkZj9HuI6cjepVJZBDMXvA2h0HtblEsz7Bu4io4v8Mz/uQx73jHAvNsJs+YZS4g7+GAdXKJDtLmBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZdxHJpwNdd5ANg2ZlCpReLYMZWYgiU8X71JX8kab1I=;
 b=vzqtfOmDGMs1JknEffl6gdDM5bVMFX+/fY4Lwdbyae3pleOqpZiPwUc2qvtnPc9pEwcdUOQhN1ddGMhaKp9G2vV2uSJGUFDgdcBd2SAOt/0xQUzA3UNv/KuppvHuzHjsCacoawzNFvghc+Psyej4Z2KyKoXW8xu+BCR2CIII2REcXW0WRGT6VDW31PqCiHwoRDFsuu1k6glP3sHUeo4Ql7O980tizS9gXiWUzB2Bq0p0/ttsL6sOe75XuzwvxW0wsAHkP+hRr/ySRptQDjMxHPVRwrHOedXPSJxa/4QAx6pGPLTVpanxjbmINnqRauYmnYD+h8/pYcYtaA0Dpbzu8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZdxHJpwNdd5ANg2ZlCpReLYMZWYgiU8X71JX8kab1I=;
 b=ZXWWYUPyVpbLQqDFKy0Nq8oQHR31VLb9jGNcGXfMIsfvDv0fpiLO6eVMB7Q3YJOGscvrm0p/JsDEl8u7jZrtj+PBhbrmfEpQGV2BRg8iQjet4P3dgFr8yBHODjc7EX9jAa0Mq/6OoRNg3btSjiKx8T8RIZyNdT+9HyPFZAeS3AR6XfSE9tpOMZEbIyhOlWcXzhRDovf4q68czIBfHG05uRBuA7K6aWfl8Z14JF3CyjiMQQyqQaVfmR+rnEl4aJePesBGpGniDQFjxUNPuxGohU9lTAObnl0sXVkGSW4T0nGM1aw9Br8/6+9EHXhLpthaP0apz1LPBb2G2O/U7W5bzQ==
Received: from SN7PR19MB6736.namprd19.prod.outlook.com (2603:10b6:806:263::12)
 by DS6PR19MB997434.namprd19.prod.outlook.com (2603:10b6:8:463::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 05:19:04 +0000
Received: from SN7PR19MB6736.namprd19.prod.outlook.com
 ([fe80::4b6c:b84f:b71c:d0a]) by SN7PR19MB6736.namprd19.prod.outlook.com
 ([fe80::4b6c:b84f:b71c:d0a%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 05:19:03 +0000
Message-ID:
 <SN7PR19MB6736BF850FAF84B013000E5F9D112@SN7PR19MB6736.namprd19.prod.outlook.com>
Date: Fri, 5 Jun 2026 09:18:56 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next-next] net: dsa: qca8k: Add support for force mode for
 fixed link topology
To: Jakub Kicinski <kuba@kernel.org>,
 devnull+george.moussalem.outlook.com@kernel.org
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260603-qca8337-force-mode-v1-1-caf7670ffab3@outlook.com>
 <20260605012421.3517532-1-kuba@kernel.org>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <20260605012421.3517532-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0001.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:26::6) To SN7PR19MB6736.namprd19.prod.outlook.com
 (2603:10b6:806:263::12)
X-Microsoft-Original-Message-ID:
 <0fc24d8e-902e-44eb-870a-f6616370e4b4@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR19MB6736:EE_|DS6PR19MB997434:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e68753-54f0-4272-0996-08dec2c1f4d8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|19110799012|8060799015|6090799003|12121999013|24021099003|55001999006|5072599009|41001999006|23021999003|51005399006|37011999003|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VG9uNHkrMWI3N2tKcnU2T2UvUUtwT3hOL0puY0pkR2FMbkJjNlhHNld5VlFY?=
 =?utf-8?B?NE1YdkhOUXd2RERJR3ZjeGtDbWM4cVVOVVFwZUJiV0ZzcTNRdSs3Z2tNUmdh?=
 =?utf-8?B?N1RmQVBTdmZkWFVYNnZvNVlSaTBiUjNaQ3ZjYzlWTEwzSVN2NURFVkNoSWlj?=
 =?utf-8?B?NXp0amtHSytjZHFQY3EzZDdjc2YyV2UyVlhzd2tNTk56UlJOQ1ZTL2s0eHF5?=
 =?utf-8?B?Y1J5K0NHakxabk96QS9VMjduclBOQ0xXMVhadkdkd0h0dkZzWHEwbFVlSVB2?=
 =?utf-8?B?RFMzelU5dElKZWVLWU5XbElKSUk5Z0toQVg3R0NZanBzSlhWSVc2cFlSc1Vz?=
 =?utf-8?B?ZDl0VkF1aERoa2dBUmtBSW5KejZpS29IS3BPV0NYYnM2WjhtWkxqaFo5Tyt4?=
 =?utf-8?B?TFg3TThPYWNFZzIyV05xQjUweHFrWlE5OHpSWlJXQlFCVzcvcXdmME9NSWU1?=
 =?utf-8?B?ZHNmUDU1UXlPa05vRTFsSVdDRG01L0hVVVJVeXduUkJGWHFXTjBkYTY3b2Ex?=
 =?utf-8?B?V1pBM3RXTUVIV0ZTYUp5bWo2QkdxbDFoQW1hOXdNRXRSY0tsaFNHZ0NxQTVU?=
 =?utf-8?B?cVAxWDBDeVZ6bVpLTWlzOFJpbHA0aHdncWlhMXMvUzdOaVl3T09UMWhKdHJp?=
 =?utf-8?B?R0tNamJLd3BGWFRrOU41TXRaYzlpRTY3czdWQk5FMXFJc1N0dy82anRUMjJI?=
 =?utf-8?B?ajhuSTFib0lSeGN4cnE0L0x1VncvaDhhRDlSc2cwUGhmU0s4US8zQjJiNjJC?=
 =?utf-8?B?SlRGVEVUazZwSURDMjlwR1RDWmFFbktLR2dmZ3FscmRDbnRkM1kzaXFRRTJ3?=
 =?utf-8?B?SmpCanE4dms0N0NCOXdvRFlqdFRvdW9YQ01CTWJaSGZpVXRHaXhCRkNuSXlt?=
 =?utf-8?B?YlVWM3RCeGlPRC9uTkI1cUpTcUJBK09QTGoxVWdOWlc0eGtqa3o3ODRxTW94?=
 =?utf-8?B?a2t1S3BqaStJNGxaVjBBY3lOWSszVWVtRnF2TjFCVjhLMDlWQXZyWEU2dUkz?=
 =?utf-8?B?aFlzVFo0bW9ZK2pUeEk2MjFOWjFKOEpYVkVmSmVmSXVJcUQrZFc3S0ZCODda?=
 =?utf-8?B?cGVOeWZvZlRHaU45Z2pZREdXWkxxZXRmTGM0bXlLSGhnbjRUS2ZyRFVPUnEy?=
 =?utf-8?B?Rkw2aC85bXdteDc3NmNFRUNSL1RyRS9JQXNFaUt4SE5GeW5uYVlkVnNLZ1Bs?=
 =?utf-8?B?ajhpVVlnMGViNGVxTW9WWE5ubndUblFHb2xmNno0Y2syb2VoTDZFS1h6M2tr?=
 =?utf-8?B?RmxOK1YvVVFXTDVtQ0R6TEhNRnFlTkExY0NuZ3JaQlE2K1UxV2V2d25uZWpB?=
 =?utf-8?B?Y2dOSGVuSzJtZ1dvVFV5ZUdFNFNXcndENHRoY0JmK1lhTXppSXMzYmZzUUl0?=
 =?utf-8?B?ckRwQjlpZ0FLejNvRlRvNC9zRVBXb2plSEduVFFLVjczc0xPUnM0REJra1Nk?=
 =?utf-8?B?VlRaU1BZbGEyS3lnOVpVdjBGUTZTcVJvdzJ1dnZBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzRDWXV4T1pGN0J0SzFLMWtrNE9uZExBMEJVKzloV1FxMmtQUk5LcGV2MFJV?=
 =?utf-8?B?MWJYUmducHk2MzA1UTJKUVZvNExoN1RHdG9leTdxZkN5MGxIc1pJaEFKeU9n?=
 =?utf-8?B?V1Jkc2RtZWVGOEZNOTl3WENJMnhmb0IrSlpBSERhTzZzLzZ0Ukt5Mmg3YVVI?=
 =?utf-8?B?ejVMMEdHcUJIQU04Um80NkJDYWFYa241MWV5SSszODl4YllYdDNsUU1OY0ta?=
 =?utf-8?B?bDdQb3hOSkVVYWtJTmdsU0IxOTdGRkl5KzUxU2hwNFNZNFVLREZ1VTc5bXhV?=
 =?utf-8?B?N3BnSFdRWkpOcnNoSkR2Z3VlWWdhd1psZ2kybllIYXhrWTRsSkpsQnJzUGs2?=
 =?utf-8?B?QWdaeEVXNWVwT3hMYkZKbExPTTlVTGZrMVI2QkJkSWcwSUdVaXdzRWE2WGZB?=
 =?utf-8?B?SE5DOVJaK2lJODdKaXVWUHFoUDh6d1RDVm03YzU3OUdmTG9Va1RHNUo0RUhm?=
 =?utf-8?B?bzRxTkVEdEtIRGtHY2J3ZENVOEttaldWR21KRnVXUG9zNmRRTmFQMEpkSnBm?=
 =?utf-8?B?ZUgwOGM0eDNnS24wNmJtREZ2cVdEYkg1UG51ZXM3R0dKZlFrS2V3T1VEL0tJ?=
 =?utf-8?B?c1A5ZEE2N2M3cVUzY1E1eUhDcklvUlZnOWVManBnMGJnVklKaFREZGkrQmpv?=
 =?utf-8?B?d3Q4UjRTMjMra3NEQXoxdjZYZ0FCdWtYRFgzNkdKYXF4WFNMcEhSRE51bjI5?=
 =?utf-8?B?M0VXWkpvT3htUGtZVGV5MExhQ0R6aVNxTXMxNHBFSmJmckJaMHpyZ1Rid0JN?=
 =?utf-8?B?YlBueW5SV2czbkdsT1pwVHc3eGRIMXFTY2Y1elJEblVtbzYzM09OQXgyN2RM?=
 =?utf-8?B?MjNiWEMwdm5YaE95UmE1UXN2RThhRktuUFB3b1FCOWdnZCtielM1MWlpSlgz?=
 =?utf-8?B?Ri9oTlJNWlRSclJZek96Q2liSUc5Y2V0WDFCSXVLb3Vva3NUK3JsbnFTbFpZ?=
 =?utf-8?B?dWNsWVBRTWRVRTJ1M0w0SzQrVVlaZ1F1ZzN1ZWtITEorNXJpeU1pVXZhTDBo?=
 =?utf-8?B?TzR6azhvMEhSM3lzdHlsdWJhTFh6d0tLSFNsWlR6Y2xGQ2lTM2dxMmpua3or?=
 =?utf-8?B?a3NiNHpRaGZDR2VwQ0pLRDIxT1dSVjBZTWNyK0hwNGFlL0xHdFdmOEVDbDVZ?=
 =?utf-8?B?UUM4THVBOXJVOERBNXJqMDF4OElkeDlmcG52eitsRFJHZllIK0h4bFVXNkNt?=
 =?utf-8?B?UENmT0RaK1B3eXNRa2VZRUc2d1FVeUVGQTkvbVBFbllVcmpaakF6dHdRb2hX?=
 =?utf-8?B?cGJlVUpvMlgwaDdlM3N5ZlVPSEJtb1hnSnppaGFucEQ2MGwvNnRiZXFnK1A2?=
 =?utf-8?B?cVUwUTlRTWJlS2NoSWtZUUVKdHdyU0FBamt3bWg0MWhjU25SRUJKSlZialBi?=
 =?utf-8?B?K0ZZaElybkMvREpGMXhNWldUTUNhcUtUWHpzQXZSbWJ2aHJiVFZuUkFhNHV2?=
 =?utf-8?B?L3M5ZTRMNGNycEp0MkxYbUlIMHNkU1ViYVUzMkVkR3hFbHpuTVJpdEdPOHRl?=
 =?utf-8?B?bE9nbUpMUGdYVVA0U0xBNk5QTllkS2RvUzZ6SlJ6TWladncvaXprMDZkbG9V?=
 =?utf-8?B?Ymc5blhlOTJibmZhanB0eU1BNXdPRUR1d3N6YzFlUHpnOVF6NlZlNGlQZjdi?=
 =?utf-8?B?aS8vRGFMWFZ0TXVQT2V4dWZlK21KdlpGaktEU0pyT1VqTGRGYWU0M3NjR0Jx?=
 =?utf-8?B?ZHc5Z3pnOU9Sc0dGYkdxTUUrNDZwQnRiV1haRkNiV2FzNUlncDUzeEhuUmFp?=
 =?utf-8?B?dDcxVkdSM3lrVWJ2S0l1VCt5ZTVjQ0Mra1hyUHl6eUl0dGQ4K3l5VTllQ2ZV?=
 =?utf-8?B?MzFDdUxSb04wNUxhWEcxZW1lRi9PcElRUThIYXNOL3NMdTBISW1hR0RPamU0?=
 =?utf-8?B?NXIwMTVGN2Y2U0RvTXVpYi9UNTZtc3VXRCtDMUlLb3RSYnc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e68753-54f0-4272-0996-08dec2c1f4d8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR19MB6736.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 05:19:03.5929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR19MB997434
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295631-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:devnull+george.moussalem.outlook.com@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_MUA_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[george.moussalem@outlook.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[george.moussalem@outlook.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,george.moussalem.outlook.com];
	FREEMAIL_FROM(0.00)[outlook.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62176645269

On 6/5/26 05:24, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
...
> 
> Earlier in qca8k_pcs_config(), reg is overridden for these models:
> 
> 	if (priv->switch_id == QCA8K_ID_QCA8327 ||
> 	    priv->switch_id == QCA8K_ID_QCA8337)
> 		reg = QCA8K_REG_PORT0_PAD_CTRL;
> 
> Since the SGMII force mode configuration uses this same reg variable,
> won't this cause the FORCE_MODE bit for port 6 to be incorrectly written
> to port 0's PAD control register on these specific switches?

I've taken another look at the vendor SDK and this property is always
set on PORT0_PAD_CTRL regardless of whether it's physically wired on
port 0 or 6. I did see it is only set on the QCA8337 version, so I'll
check for that in v2.

> 
>>  	if (val)
>>  		ret = qca8k_rmw(priv, reg,
>>  				QCA8K_PORT0_PAD_SGMII_RXCLK_FALLING_EDGE |
>> -				QCA8K_PORT0_PAD_SGMII_TXCLK_FALLING_EDGE,
>> +				QCA8K_PORT0_PAD_SGMII_TXCLK_FALLING_EDGE |
>> +				QCA8K_PORT_PAD_SGMII_FORCE_MODE,
>>  				val);
> 
> [Severity: High]
> Is FORCE_MODE properly cleared if it was previously set by a bootloader,
> but we don't use outband negotiation and no clock falling edge properties
> are configured?
> 
> If neg_mode != PHYLINK_PCS_NEG_OUTBAND and the clock phase bits are not set,
> val will be 0. This causes the if (val) check to fail, skipping the
> qca8k_rmw() call entirely, leaving FORCE_MODE unchanged in hardware.
> 
> However, if clock phases are configured in the device tree, val will be
> non-zero, and qca8k_rmw() will clear FORCE_MODE. Does this create a
> scenario where clearing this mode unpredictably depends on unrelated clock
> configurations?

No, the default value, as for all documented bits on PORT0_PAD_CTRL, is
0 (disabled) after a reset. So it will be disabled by default and only
enabled if a fixed link is defined in the port node in the DT.

> 
>>  
>>  	return 0;

Best regards,
George


