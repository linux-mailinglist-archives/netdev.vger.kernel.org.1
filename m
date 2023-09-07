Return-Path: <netdev+bounces-32486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FB1797D7C
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 22:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1701C20B43
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 20:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C45C13AEA;
	Thu,  7 Sep 2023 20:41:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E2763A3
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 20:41:56 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2221BCA
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 13:41:52 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387KXwYp031306;
	Thu, 7 Sep 2023 20:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : references : subject : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=A4ddccH1b4z+1PgeFOXmWKMr/jW+MvhMeCUv+FxORQw=;
 b=PTuFM5xI5W7i5vh7e76EV45XnvOl+Bd0Dsh2E2iQ72Ge/qd+U9OOMwPbWUrFfmN/u6tC
 vyHtm30Jm1x4AAuuJ2dpKGGu2vvzpQn2pITlnvl/9QI245E62ddKxzbCqfDyjF7KnIG7
 s4wvWAkWGmOGgj4J0+K9s52eS4LlqvoHpblLFlhJ9UD6sm1ZiJchkJ2vYKU6s20UZHQk
 IewTCaTRgRcQ2b0AjtDGcT2n3jTfM/IMZIT76QlosxloaIFSYmhB+iuomxK2/RKbTYe6
 Cu779Wf0hgMGJnaWK2LNtvnATS8ud/f7pNLF1miOne6ZgJXN3Rz0+2AbKZMjusz1EvgC Ug== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3syng2816c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Sep 2023 20:41:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 387J4s0c009287;
	Thu, 7 Sep 2023 20:41:41 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3syfy0f208-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Sep 2023 20:41:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzY1JswVlxwPNdfwEj/fAyxt6lUnA5kl3hOEMn19j2Q4z0l5fnw9kMAvmPphOqoS1tNdF4pxE7oWKZjepza13ioZSMH18lNbkXPiOCbkM2Yfe2Wb9meYG6Deu7921Ll1YrSCk3tgkJAPJb/Kjvg2h/2zitRHN5RT6mCLwUsUGKL8hWZPiqPQBbWyz9CvJYuMcwhZG3OiWC/uElRUqKdmd4LC2TPerZWHtOJ4VuE/hpfH9m/9nMoILAWfJpW9bg1jQIV1Dd86rvDAsFGve2bvDSSKFNLF/2Oj2C+AwBQKVntFa8u+Jz2Me35wngLiflhe73v9nIcuVJwEeumaQBKAgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4ddccH1b4z+1PgeFOXmWKMr/jW+MvhMeCUv+FxORQw=;
 b=BPigcZYT33DQPrl2McUeXpD0WQg6NvhPL5ZlRn+S4ns7gQnSCycRWvJ13ajcLVg7DaYWw2GzziCgnJXft5qsQO7hpWqDG2aJ3qTepSM7GO8OwZamZUcvvHfHaDNVHPCfTM/gMjYF47fiZP+sxY8CTPJTa4WSokF/u7zr6Sextgno0OeJsYRagbdmo7nK0MM1WTwLAU2w7vwYmvH26Cb7mCkkFNsEGmnYsGmhz6EBDIOX/8jmLGp/nr+Trd2AX30Pn1awlz4oTrQIwiXrrFwADIkxQx6RTBgvvRtWT4kYTBhLhRLk6XxvEj2w9n5gCEGjjL/7rhbR4KzueLFuWs9MmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4ddccH1b4z+1PgeFOXmWKMr/jW+MvhMeCUv+FxORQw=;
 b=SsTaBiwyPo8arAoXA0oKLId9nXWc87NIKKI1WabPwcNPle2Q/wK/bKNdEjlpSmEpscv8uRiXfbXCU9sws+Sl3zPsjfb06blpb/NpL3QMHyLYMOTAhSOvUbrbpfmZR/WyWhHU5Fnfb40uUP7H7lp1HbZYtB2Z27OVerUuS1fgJEk=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CO1PR10MB4449.namprd10.prod.outlook.com (2603:10b6:303:9d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 20:41:39 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9971:d29e:d131:cdc8]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9971:d29e:d131:cdc8%3]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 20:41:39 +0000
Message-ID: <b4eeb1b9-1e65-3ef5-1a19-ecd0b14d29e9@oracle.com>
Date: Thu, 7 Sep 2023 13:41:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: dsahern@kernel.org
Cc: allen.hubbe@amd.com, drivers@pensando.io, jasowang@redhat.com,
        mst@redhat.com, netdev@vger.kernel.org,
        virtualization@lists.linux-foundation.org, shannon.nelson@amd.com
References: <29db10bca7e5ef6b1137282292660fc337a4323a.1683907102.git.allen.hubbe@amd.com>
Subject: Re: [PATCH] vdpa: consume device_features parameter
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <29db10bca7e5ef6b1137282292660fc337a4323a.1683907102.git.allen.hubbe@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:510:23c::29) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CO1PR10MB4449:EE_
X-MS-Office365-Filtering-Correlation-Id: 28be031b-0b5f-4e21-086b-08dbafe2d655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	m0ufMsAxtYp5h1jb+sLG1bB74VWZd93fdVIRzBGDiEJPV2KHcBq7E0fE/luI91rAnWaEA5attPRKmO5SclyvxlrY3tsFvdWy2vNEtDbguM8I824Llym7DgHwuvvYrXo2asD1xu/thSmdpJXRSn8B6WAAbd3K6lhJPtemc8zsNlxdQx/9L2vvOsj4R22PAZbuH2lPbfyFXTyiNRw1srjCKCrZ5gLG74lPLyAdvBU695L3I6NGMcbspOoPSoiuMWJzuFWdeH2ozEckqOmlPFO9wUK3F1uVoMVUkWKHV9VQXKxu0vAeFucRxng/d9+t7Y0YK6jUqKpC5BSxxdxWZwd1/jCAr5QjMUT0rP4MpRgj6pYXrRPT/azM8OGz0eYV2DZPIID4IrBMbbO8PxBV6F1cceYvZR3VTGCuED/1GxlA3icIdSghG00vN/gInjszlNKIxcZvTwnnWFP/eD4bvrtdCWaCb0abuNN8srvWxTZy1TsG3pipFHqLAa4U9x9m2czdJA6jjdkqGPrw39YCuACt3VjKfXCsC/9TiBPeRW3Hat92OCAvq5eHdG/eZfQKjLhhAznsGATMMP/j/Uh5Hs7tfm7RRu7kW1QDOrY3cXFOCZFe7uo8JI8AKvXOhEkM7M9Tt2kazmLGGW0gYLkSSQ+JCA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(186009)(1800799009)(451199024)(86362001)(31696002)(36756003)(38100700002)(478600001)(2906002)(53546011)(36916002)(6506007)(316002)(4326008)(6486002)(8936002)(8676002)(6512007)(5660300002)(41300700001)(66556008)(6916009)(31686004)(66946007)(26005)(66476007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WWpMRnR5MUJoNmpQZ3g4bFg1MGkvZEJncWtZTHloOUZXZDVNRTdIOWdYZ1NM?=
 =?utf-8?B?bXBUTnlDNUg0YXMxRXJTSEx4cVR1K0ZucXJ0TlpCVksxc2ZKUnpKc0VrbG9i?=
 =?utf-8?B?MEx5OXNaWVFlUUM5Wm1YTjVEYUhRV3greldjbGxwOEZyNkJ6K1BESkgwTG5y?=
 =?utf-8?B?OTlQNHo2S0FNZFlCMHhZamUzMnZyZVlTZUJqdWEvTjNmdGlGSDdjenZPZ2VG?=
 =?utf-8?B?Yk1sRzliRkhFS1QwUVcrNy91Um1JL0dRTVc1NVFwTnBod1NaUTlkU2JLVE1m?=
 =?utf-8?B?Q0d6QS9pYnRySUFEMldNaEU0eWpxWXdNNW94endkUDhQdWhZcjFqNXRJRWZR?=
 =?utf-8?B?ZWYyTFA1L3VOTWJCQ29EajAyUGRibmZjNzFmc0cybjN3ZlZ0VEpaWUY4OE1z?=
 =?utf-8?B?RkZoL2dsN3NuckdVbk5JTDBxQ29YbWtpMm9lOFBZcEd0a3ZXZmxVUU1RQkVU?=
 =?utf-8?B?ZFFhMmVNajhVd0RiOUJOdytkQ1BISnJhbGRzK3R2Y0NwNGNoblc2eWRwNmZL?=
 =?utf-8?B?dmtlLzZOem9SeDA0RTAyaEpOWHZRZllhazk4RDVka1ZrQnZwTmRjdzMrekxW?=
 =?utf-8?B?bVIvWENuRFZWODVnZVM4STFOQ1BUQ01OcUZlc3pJQ1QyOFZMNlVUTk5td21r?=
 =?utf-8?B?N2puTHJvMGtBZ0RwUnhSZVE5SGRVYVhKOEE5M1lFMVIrOURKNFJRbU42b1JJ?=
 =?utf-8?B?dmhwR2w5VjdTaW1VZGMxTXFCVUxNS25ybE00MFc4ajZrOGgwWXlqeURseXd4?=
 =?utf-8?B?di9mT3NJdzUxQnMzaXY2N0pWZ0ZRSnBOY3hERmY3aWx5Z2xqSjQwZy92TEpz?=
 =?utf-8?B?dmZqSExhK21HN0wzenRyRUVwTXFSdmgwV2c5Z2kydWUvSTZYRWhPaXVJT01M?=
 =?utf-8?B?WnhsNmVRV3V0V01Pamt5bUNkeVV0U1pXVnZOaUxjTVF0Q0x0VTNFbGw3WnM1?=
 =?utf-8?B?NkEwTnFSZCtIbjBhSnlFQlVIaTdsT2R3Zm5qMGgzaEJMS3pUQ3ZRbCtPdDQx?=
 =?utf-8?B?S05vS2tvODdaN3lZcXYxWlRXc255WUlrZGNpbi9EYzFVRDhqVVV1ckt2YjZ5?=
 =?utf-8?B?alRHWVdIamJNbFQ5N0dYRzNLcmFWcGRlcXlmOEk1UVIwdmV6djJKQk1YYkgv?=
 =?utf-8?B?MmFXNFJxa0hBei9pb1ZJZFVLYnk4MXYycEFSY0toczVYRWtwRjFaMUlsU2dr?=
 =?utf-8?B?Q3dYd3lzemZpTEdBZHMxR2gxeVRnRUtTMTlLQWR2ZlNjWkp1dzFKeFpCeGdX?=
 =?utf-8?B?MDJmVjR5N0Z6L0FEaTFlSTVWSVgrZVRlMXhwSHh6Y0FrcGVKb2FienFEb3k1?=
 =?utf-8?B?ZXF5ZG5nWFN1eTRCM1JuOWIrV284Qk9KQUk5Ny9ab1h5djdCOG9aSmhGMGFq?=
 =?utf-8?B?czZEdUxIZkVqajJQcTZ5R25OMUZKOFBRTHhHSkJhek9tT2hrNHEzVTQ1cXJ4?=
 =?utf-8?B?M1JLTk9RMEdSRkRsMEI0R3NZRExDOWhCQ3NKVU4rVUswT3VYcTZkOE9GWFRj?=
 =?utf-8?B?YlVseXZnTDBqQW5tV1RPNGJJZjBnd0hhdnR1cjZTbzh2YTN4eGR1TERYRnpT?=
 =?utf-8?B?dWRGR3lValQvNm9HaUJzbjRjeUxKZ0tBdE0vTlJXTDFhOFdtN2lxcUZtQlp6?=
 =?utf-8?B?cFd3UjZWRjJBNlYxQldZdEJIQndyNWQ2RS96akhVNFhOSzRBRC8yQTM5YTBi?=
 =?utf-8?B?TlJoVU5hMjY3ZkxFUG9uZkZEMTVFaDBNVnI4NWRWRlJJbStsNVEwV1hiOTZX?=
 =?utf-8?B?bnFscEdUdTJBdXByWlZFdVMxRTZhb3FjMG41dW5SajFyNDJNaXpzU1R5cjZz?=
 =?utf-8?B?NStaWE92VDkxaE5YaTZHeTVSenhKUnFRKytFK2gzajZCUUdrUnN6SHBscXhp?=
 =?utf-8?B?VnZxN0krN2NaWHFZVkg5RGtYWGNGY2ptNCt5QUxZZ3dHczhYbDVEUitVelMv?=
 =?utf-8?B?NTkreWtNWmJ1NjZpSmxSQWc1RVlON1RvSm5PakNZbVRhQ3ErZVVGZzk0UFNC?=
 =?utf-8?B?aWEremlydmp3MWZ0RDU0UzFJaHI2Rm8yZ1hGWVJleS9oQm1lM0djUUNWRnpH?=
 =?utf-8?B?VVo2ZTFDT0dHNTFjekhLUEJjNjNCVFNOaE12TENpWFQ1WG1lbmJ0SWx6T3py?=
 =?utf-8?Q?KwB4VnQgG7PfWZIPQft03B9UE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?ZTFtVHpUSWowL2tla2RGSGVCRTQ5VnAzdFRySXU5empyUzNUUGQ4Y1A3TUtU?=
 =?utf-8?B?V0N1Q2NuVTBLNitaZi9nWkUzeWl0UytiV0pwSUd3QUZvUlRRT202MjZ2bVI3?=
 =?utf-8?B?N0hnSnFUYXVMM0phS1g4U3hOT2NFWmROVFdGdDdiQ0VRUGxXbjhIU0xlek8z?=
 =?utf-8?B?QTVLVHhUTERFNVRxYXUyY2cxSy9NeHdqWW85cFVPdy8zMkVVazNwNGFGUERu?=
 =?utf-8?B?eDdiM1NtM3V5UG9rU2hYcUxsTGpSYmlNNFluc1ZJNmJBNk9vOFRsa202NE1H?=
 =?utf-8?B?alNOQWVwbmdnWGswV21CZnk2MHM4TGp6MDIyZlJoTUdqcnNXQmtWRHM1cml4?=
 =?utf-8?B?Nkc0eE4rYmIxb0gwRk9aYWFFQnh6MmpwRXUwb1AwSnczRmtCWWc4SFAyZGJy?=
 =?utf-8?B?ekc0MkZxdHBGVEZBSDRVZndZQVUzU1VOQ0hwSmtFYUlPc09RUUdlZWhCVHBo?=
 =?utf-8?B?Tnp5Ym4vQ0lzaW4yUm8zYUVVdEhEOGVsOUlVQXZNRVkwWUJobDFDQjlaS1FI?=
 =?utf-8?B?cm15M3hmZ2ZJNEpXUzRDcGxmZG84WXlkUFQ0d0xmTktKL09pM09rMldEV0th?=
 =?utf-8?B?M0RJa1l5bFNJNDhsMTJsdEJpdUxod0pzWU5TbUFYMFBNVURmMHp4RVZvYk41?=
 =?utf-8?B?STZvaEZVbW9yaXBoU0ttWFRoS2xsMm9HUFk5YU1mT09tSG5tQmkvRlZxcU5X?=
 =?utf-8?B?Y25SekJuUithRjJWU3RmZkVQdnpwQkZOeThydm5hb0pOOXZLSTUvVW0wQnRZ?=
 =?utf-8?B?b0ZXNE5YQVhvSnlHbFlaN3BRVnp2dkE2Rm96eWJpRzFTNmFXY2tINW4yVm8y?=
 =?utf-8?B?ZkgwMmFmaEtmbElDSExTNHBmSll5dGowZG5UZnBZWDR1Y3BXcktWQWFIaENn?=
 =?utf-8?B?R0JOK1BGYjd1ZTJQNXZUSGswSTV5dmxwbEZFUDNPSFl0UDZuWHBWOFA5ZHBL?=
 =?utf-8?B?a0d5K0kySG00bHk4UXRHYXRMTUdqWDM3cHBwU0FuQUZNZ2RRUTQvWnlhQlFa?=
 =?utf-8?B?ZUxEcmxpZUVjUE5hdjUvaVZqR21VQjNYK2FqeUoyUlhreGFDK0Y2dGRQQWgy?=
 =?utf-8?B?VE95THlWRkRNdnR6SzdxdEhyRTg0U3pEY0FKemRFYURzaXhuRzI3YTFTNDE1?=
 =?utf-8?B?OGlDck1Qa0FiVkdjTWtMSVhidHp5aUxHZk5Ta1BUZjVRakp3dGRiOVAva0dw?=
 =?utf-8?B?UnZPUXgvOE9LWmVORHJFQkNFOWxtM3NSZHlUWjFoY3RGYWRSem9jWGhSRTIx?=
 =?utf-8?Q?L/jkXXy77XETpUN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28be031b-0b5f-4e21-086b-08dbafe2d655
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 20:41:39.8209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glPSwyavKsqo09A4j44jh7FOBb+VF027KfwwGbho2a8tQtRzK9F8kyw9TIYGgCJ0exm4kQ70jdHgdg3iiRit4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4449
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070183
X-Proofpoint-GUID: Y6bBMsZj8BVMWEAmsTFLLfYfZY2iN-CF
X-Proofpoint-ORIG-GUID: Y6bBMsZj8BVMWEAmsTFLLfYfZY2iN-CF
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David,

Why this patch doesn't get picked in the last 4 months? Maybe the 
subject is not clear, but this is an iproute2 patch. Would it be 
possible to merge at your earliest convenience?

PS, adding my R-b to the patch.

Thanks,
-Siwei


On Sat, May 13, 2023 at 12:42 AM Shannon Nelson <shannon.nelson@amd.com> 
wrote:
 >
 > From: Allen Hubbe <allen.hubbe@amd.com>
 >
 > Consume the parameter to device_features when parsing command line
 > options.  Otherwise the parameter may be used again as an option name.
 >
 >  # vdpa dev add ... device_features 0xdeadbeef mac 00:11:22:33:44:55
 >  Unknown option "0xdeadbeef"
 >
 > Fixes: a4442ce58ebb ("vdpa: allow provisioning device features")
 > Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
 > Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>

 > ---
 >  vdpa/vdpa.c | 2 ++
 >  1 file changed, 2 insertions(+)
 >
 > diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
 > index 27647d73d498..8a2fca8647b6 100644
 > --- a/vdpa/vdpa.c
 > +++ b/vdpa/vdpa.c
 > @@ -353,6 +353,8 @@ static int vdpa_argv_parse(struct vdpa *vdpa, int 
argc, char **argv,
 > &opts->device_features);
 >                         if (err)
 >                                 return err;
 > +
 > +                       NEXT_ARG_FWD();
 >                         o_found |= VDPA_OPT_VDEV_FEATURES;
 >                 } else {
 >                         fprintf(stderr, "Unknown option \"%s\"\n", 
*argv);
 > --
 > 2.17.1
 >


