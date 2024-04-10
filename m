Return-Path: <netdev+bounces-86458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B1289EDBA
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 10:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5346C1F22A10
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 08:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94A7154BE7;
	Wed, 10 Apr 2024 08:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lt5jNozI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FP6kNg42"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119C613D607
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 08:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738193; cv=fail; b=GU5U0ResJOVA4/gtRkZqM2qW8g6qkqqaHrCUP+kPbrJ97tmMDQDvamPHeKTK9kHfFvBSkPUqY05IXtTcgMnFUNORh9V34rxTWodfsmSTJv3dQOSh45s1XoZikn4vbn8egRXmS7ejScigAfuqfc5e1LTHWt+3hWZioxP4Wwb8ajg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738193; c=relaxed/simple;
	bh=dGHLDZ9ZeecRE0jc5/9OMSzGxWBdkBgmY4JrHy8Hlcw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TWYu+3UOzeJpwcNMPlkHMSJu2odzg9nUI/Id3YR887Mxjf4jeqNUpnve9VpZvjRTliYs96Cva2UWMhaOfXfZG5SYPbbS1ncYwMH5zyXknD4CzAZekfDqjyih3t1pnuAeYgc2ll2cCqnCgeUyz0jjS32HH220b8qIDpBtwvN84Uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lt5jNozI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FP6kNg42; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43A7jkMC007051;
	Wed, 10 Apr 2024 08:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=6JUMhHpGPdNiuukYKmboZOzykmNx4FLKCrNyL3tuDKM=;
 b=Lt5jNozIYB7KNAF6J79UAs0b6cmguTaMApC1lliNPNQjZzsGDhVGxsI3qcm2U9DNhvRt
 izHz+Bt5+kiIbw8s/25/2S6BOWadL19tX1re5Qho6L1cKZE9vk85aOd4/tl8+ySDXZVY
 UyxLbONgmdZob2Q90czBBkCAkkyxZ/5U7gvvu34b821u0R8U4XjQyTz799hLtrYEyM/e
 NXE2JybAYq6zKq68N5zASeTHVNYwmL99P3G7VXx9IDNnw+NCM2Cjp9Qk7funazcQvFZx
 +AbxJzQPzhJQyD9MNeJ9JAyzqo8QYjvR6byzsThXN4t3Uwng6Bt4fSIZGutOvnhm+RZR gg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxedpv9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 08:36:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43A7PPRR007875;
	Wed, 10 Apr 2024 08:36:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu7trte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 08:36:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgCWLD2psWwQwhV68ysmBHmnIAWinwQPb99zeVQTnrAT4QO+7gP7joTkfEG7T8N+SlgzRDV7rI66yUF8K5vHSuKMz1+QJepRky8AUojSgwQZMaBsCYw3FZFuOBm2962Bnq1Uz4/OVexlrQiirBnOROfFmYtPkOiCq9ubi9cK72S9gx7jieQMWNSZdEIOYZe5tY/fyOzIoeXptiGjf8b/QNDa1MT4kyMCPNe5ImV/NXH+DXA6FLJuBYhQRebk1AGaICc7oR6ZVY/UG6YaAVqeg3hfq57ApUY0KWzyyUT6lsJHNEUjObtsupkxmqkMfux89voIvDB5u7I9jkR8YgXpMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JUMhHpGPdNiuukYKmboZOzykmNx4FLKCrNyL3tuDKM=;
 b=YLFsDKSNlKlflDww/0b3tNZ4IpxgYMPrGUvc1aiSqlZ2BNR1JR20BTgSw8ID++AxvLyrAwTFoo7jF8LG3P6dWbe3YwGnFY5viPnkPDEIAMOiiVsFS0iivr7XRi6L8b9QTU/P1pRDT7ly1gctiZBD0i9OPS7xrACx4mcNY7fDOKElfUa6YVjhb4U2lPIa39CSqV7iufPr+/s+hGgaXNydxG3tXbH9Bskt6DX+NH7l1g9FeKfDt+yWdE0d0lvnnn7IDIpPexYrFxzNRC2YA/d/cgI5PYImdEGNvbnovHm9gVc26sPKdQGrF4Rx7Se3C+cQ4kHIzRezE1CqFsZCbdkjpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JUMhHpGPdNiuukYKmboZOzykmNx4FLKCrNyL3tuDKM=;
 b=FP6kNg42yF+R7tlmLp/PXSdPMjAoLrZ+GxBqrVSJ0tGLED+MRSttL3yZRfvl9XKxNrCmH3gdmlig/BHhaRUSDpYurxKSTH/i4a2XR42hbink7lqk33QqENsHPoRd1/q495S7WZWox4VS0LR08f8bBMtPAUuiwV7YC9JEf73QMNg=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by CO1PR10MB4609.namprd10.prod.outlook.com (2603:10b6:303:91::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 08:36:05 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::40af:fb74:10b1:1300]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::40af:fb74:10b1:1300%5]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 08:36:05 +0000
Message-ID: <0ff1d6c8-d56d-4f73-b5be-d0ce2a223d28@oracle.com>
Date: Wed, 10 Apr 2024 01:36:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net 3/3] af_unix: Prepare MSG_OOB deprecation.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        kuni1840@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com
References: <22994084-e0a2-4829-b759-73e98418b510@oracle.com>
 <20240410060109.96131-1-kuniyu@amazon.com>
Content-Language: en-US
From: Rao Shoaib <rao.shoaib@oracle.com>
In-Reply-To: <20240410060109.96131-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0349.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::24) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|CO1PR10MB4609:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VzSglO/6g6H3BsL5vQXCkLyqMzLd6bqs7fj2zzh1qrq1wz3T3+y8YJcq1KgXtUb6IJIV0EtdY0fMdQKx1fe2xboCIfATw/92ijoK/Lb/g11XtRLLwiSMYKE5OxZk8tJEBfMnz/Iee1EvwcVBiRujZKveys5810fiA/jR7lkiMjsKCB+ucPPf2QzCfKxMjnYmtxZdBNgoHMrIaLcpexar97prPTpK9fKvkcF90ByeKrY/Ed+TBPJt8N9lFtKRkWFCh9ZvQX5tZjSU3QAzApVtIeDDJb3kH/J/zqZbUYy9+kJK0O1QJpWsTjpBDiaZN9vEn/nhNsfVP0uqm0bI7iGIdA66l0owELFBPQxIwO2evVsM96gYwDD3kq2M6h0wH9ReGYdHSrVbwUjIi5xspeVnEXMj9dsSKG78QEyaSyOchaZSp/vTshJRlFLVssR+C5WwirAVNmxN9jOTWm1ApRv0Zm3XBliy0o+MaEk2g3gj2BLXuBloqO94ksrwKgwB91iVDa/x6HJX8qot1O0sx55CrgrkV9BeRVBXwdXTAMh279De3vv3sP5kDLG0cNUqTI66i/Oy3/6dpzUaqqlLjchcbw2yF/TCxN8GCsuV9Pe+qvVC+guyDzIejraBBAy/lp51OJ07j8hOAs71sSvpg6kgBXafHhaUGVX1RfsM8X1gTI8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VnlYeTBicTJWSXRhTktaUkJqeG43ZC8zdmpSS3k0dG9kVm85cGVsU2IzWU9R?=
 =?utf-8?B?aTg1dUVEOUpBaC9kcUpFQmN6NUhtNzBxZlZjL3BDTkMwL0RkUWRselV5QlNO?=
 =?utf-8?B?U2hvd2pWclZ6ZFRDcHFVT1NyZTFWN1BDM1hPeTlQT2dpdUVGQm0vMlF1UGFW?=
 =?utf-8?B?RFBwYWovSldJY2pSckFQbndpRlRLRlBYOXpxendpMFNIdUxlTmZ1T3FDeWdZ?=
 =?utf-8?B?VzJ1Y1J2Z1FDSXRrbGNRdGREQlZ3clhFRnpnMG5LUmVUVzg4bUtsTElCNVM1?=
 =?utf-8?B?Tkx5cWszNk90ZUdKMU55eit1OWJnMlpZckFXWUw1Y2dOYi9Gc3dmZjJ0b3Zn?=
 =?utf-8?B?eVgveW1MQVNBS3BxS0xEamxTR0RIU3ozWDZxTUZmdTEzV0k2YjdhMGVBVmFk?=
 =?utf-8?B?Lyt5SFcxTXhGSEV3UUZVYSsyeWgveVcyR1hlOGMreTF4NFVZWGxxTjZVeGhn?=
 =?utf-8?B?azAxZHh4M3ZNQVZqMkdHTmNqMTRaczEzMWkyV01yZE1TNG9WZXpITitHbVpN?=
 =?utf-8?B?djBKU0Z1amJkZ09KYU45L3Zkb3cyNWFIY1RjK1FyK2h1MmRpZXdjYm1ieDRi?=
 =?utf-8?B?eWtVeXk5Tmw0Yi9DT3FVcjgweGJ1ejYwbk9EbEhzdm96bU8yRGl3bkszUC9j?=
 =?utf-8?B?V1hoMktwRGFoQjNCYWwrN0hTSEtGVWlpZmlmdVhMQ1VXSWwxSkhlK25JK3lH?=
 =?utf-8?B?ejZSdmhMamdORm5aaUZWVkgreHAyZGdXNXUxRERqMFBIb2JWNTZVYkNmQ1BQ?=
 =?utf-8?B?blZqT0Z6SzNJYldJSU1IZ2RvZXEvOGE1c21nRCtNUjl0SHNFUGpOU1NBckh3?=
 =?utf-8?B?YVBEdnJsSUxBOFF6dkYxRlRxd2RKYi9DU3F1K052THkxRThVZnZjdmRqSDRP?=
 =?utf-8?B?Q2JvRm5zTnJOMVMzYXRjT3F3emdzeG56NHlKVmw0bFJYRm4rd0dmcUlucWtZ?=
 =?utf-8?B?akZRRloxU25uVjJjTDE0eTlBbGxOR3FmOGMwaFF0U1AxL09SejhCTXVVM1Z5?=
 =?utf-8?B?MmVmVzh3K3FLTXJraHcrS3lTR1dPUzQwdnVkSXo4bzBESE9hK0xha0l2MzJj?=
 =?utf-8?B?Qm5YeGlKcGhCVWNkeSt5SUpNQVNRbFZuODdFTDU2ZjZ1dUZjUlJaTHZOQ216?=
 =?utf-8?B?dm1ERHF6Q3VtdHBMUE9aS2RGbThNdndaZjJKUGV0TFB1TzVFTld4d3UxbTho?=
 =?utf-8?B?Rzd1L0l1d0YyL2dnSUJPZ3ZXS2IxMDNuSzB2RGlBVFgyRjNHU3VPdU1DTjNr?=
 =?utf-8?B?YkNKRllLMU5Mbk9DRkE3SG03MFRnZ1Z4VHBxNTVaZmFyVUFOVm80Ni9IZUVy?=
 =?utf-8?B?VStEU2Q4VWt6TW1Zam5VZGExVDVZL2tJQzVnZ1pmZlJCWC9Kc2FDU2RMcFV2?=
 =?utf-8?B?czcwNkVtc2gzeWtwY21LQ3kyZDJ6UmxGUVBkVnNaaGZ3dUZoRG80b2d2THhS?=
 =?utf-8?B?U2ZXQmtmRVVnSmQ1RUYyQUVhN2RsWGgrOTltNTBYWEkrcGoxTTEvempkMUZL?=
 =?utf-8?B?WHBWU1RNck40NmZmQ281YllKbDB5SGFtK0tkWDlhL21WZUViczByMmIrZkp6?=
 =?utf-8?B?VjRUU3NlLzRUcGZ0TTFFamFuUFBXT09zMHdnRHh6d0I2elg0K2VkcWRLQ2NM?=
 =?utf-8?B?clljRnpMQW5leFV0QVBkRnVDdlRPd3lDU292Z2FVSkVvdTF2MzR2ZDh2bzEw?=
 =?utf-8?B?V3g1amhqRU9EakdEdzFUOC9qcVVGZWZyTFBFaDA3UmlINWZ3SThLZmhmNm1k?=
 =?utf-8?B?M2hBMmpkUFB4QTlFblUrcFAxVWVMallXVHFLVG1MWXF4aVZsNzczbDZYMUNT?=
 =?utf-8?B?MEtQYXFycG9VS25aY2NqK0p0Z0wrZVFxUGlzSlhnZld1ejRjcDFVeHZoUmQy?=
 =?utf-8?B?OWNzamd3MW5mNWdQSjVUcGJoeUlHKzdaMU9KcVU5WDVZOE55djd6a2RSV3VI?=
 =?utf-8?B?d1pmRjR1ZFJyNkg3N3FxYklvNUxHcC8wa3Vyek53ZVk4NU1RK2JXYUE1RFJu?=
 =?utf-8?B?VzQ3RXhBci9SbEFGS3p4cWwvb3Y3ekhaQTFYVmI3cVVJYmN4K0lOdEk1UWdC?=
 =?utf-8?B?MW00UHlyOVg5VDR2Y20vMDA2Vk43WE40TlFVdmFpQVQ1UVZ3bElYVTQ0ei9L?=
 =?utf-8?Q?nZ8+tIuJhl/Nzmk1XbOU4ijKx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	V5CoPpWNy1gCV7/zLK9NSxyzg7SNUxuGUh20pqYAJ1KuZl/NF9MVycpHvMqxzScM5cQI5XM0Klx/HOsmbIm3oNRLmEt6WSONNmFNVIFY6yIk3wLF0stsLYgaZCz0bXShSLU31vFQMMBZP0bfqnT3ICDLsq2Ts89VvZKHeZ3PUxGrDeZuqsPwTxDGpmqRDYMMja50AlbTnH85Zo9j9AE7A4Cq6jVWyUD7c8aAE3EUUgT/0YVo8fEdpT9FCq6MiQ0tJuHDrntCj+d58MWfZq98ps0jJ46U5V7ieJgnynvDoAc04oc84NafXyd/7nnjdBppeZCLqPvj99hsTZbiUoafl1reDJFxXPJoOyUvR7H8oPAITOSJoDclcPYbFv47ZAFlcEx/GhbB2T76uw9z4vjxDg1ueHuoc6WP6Bp6KnUhbRxwztarNbzrr/tKmh9BDMEhDAJ8r05R9hDBDVBfhrzbox3HYIn0rjRPr2ZIYIVsIPQk+Fup90Jj8ZjoFUcgCnnbJhy3TdcGFOTDqpksGBzxa8Zl6WxhTSLS2IiNGVCAMX5J6JdXld0E68ZM8tPHQE5zJjPgwXoIcue3/zottCGFurdq1smO62dEk9/1rIPfOeY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836572e5-11c5-4167-98dd-08dc593942d2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 08:36:05.0878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ErpxDihaRxZ3H+j0MraakfG1JSCq1gOJuks6OXN13dOuiGBvOkMQeCN+/GwRpo/v+YnoDEo5ssS9LyPAbQQng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4609
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_03,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=890 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404100061
X-Proofpoint-GUID: 7MonI8DIZRoWj454cZOmZfZJ_8wIcK68
X-Proofpoint-ORIG-GUID: 7MonI8DIZRoWj454cZOmZfZJ_8wIcK68

It is used by Oracle products. File bugs and someone from Oracle will 
fix it (most likely me). Oracle has addressed any bugs reported in a 
very timely manner. So in summary the feature is being used and is 
actively maintained.

You can also turn off the feature in your private/closed distro and not 
worry about it.

That is all I have to say on this subject.

Shoaib

On 4/9/24 23:01, Kuniyuki Iwashima wrote:
> From: Rao Shoaib <rao.shoaib@oracle.com>
> Date: Tue, 9 Apr 2024 17:48:37 -0700
>> On 4/9/24 17:27, Kuniyuki Iwashima wrote:
>>> From: Rao Shoaib <rao.shoaib@oracle.com>
>>> Date: Tue, 9 Apr 2024 17:09:24 -0700
>>>> This feature was added because it was needed by Oracle products.
>>>
>>> I know.  What's about now ?
> 
> Why do you ingore this again ?
> 
> If it's really used in Oracle products, you can just say yes,
> but it seems no ?
> 
> 
>>>
>>> I just took the silence as no here.
>>> https://urldefense.com/v3/__https://lore.kernel.org/netdev/472044aa-4427-40f0-9b9a-bce75d5c8aac@oracle.com/__;!!ACWV5N9M2RV99hQ!Nk1WvCk4-rstASn7PUW4QiAejf0gQ7ktNz-AhuB2UHt9Vx7yUVcfcJ82f9XM3tsDanwnWusycGdUfF4$
>>>
>>> As I noted in the cover letter, I'm fine to drop this patch if there's
>>> a real user.
>>>
>>>
>>>> The
>>>> bugs found are corner cases and happen with new feature, at the time all
>>>> tests passed.
>>>
>>> Yes, but the test was not sufficient.
>>>
>>
>> Yes they were not but we ran the tests that were required and available.
>> If bugs are found later we are responsible for fixing them and we will.
> 
> This is nice,
> 
> 
>>
>>>
>>>> If you do not feel like fixing these bugs that is fine,
>>>> let me know and I will address them,
>>>
>>> Please do even if I don't let you know.
>>>
>>
>> The way we use it we have not run into these unusual test cases. If you
>> or anyone runs into any bugs please report and I personally will debug
>> and fix the issue, just like open source is suppose to work.
> 
> but why personally ?  because Oracle products no longer use it ?
> If so, why do you want to keep the feature with no user ?
> 
> 
>>>
>>>> but removing the feature completely
>>>> should not be an option.
>>>>
>>>> Plus Amazon has it's own closed/proprietary distribution. If this is an
>>>> issue please configure your repo to not include this feature. Many
>>>> distributions choose not to include several features.
>>>
>>> The problem is that the buggy feature risks many distributions.
>>> If not-well-maintained feature is really needed only for a single
>>> distro, it should be rather maintained as downstream patch.
>>>
>>> If no one is using it, no reason to keep the attack sarface alive.
>>
>> Tell me one feature in Linux that does not have bugs?
> 
> I'm not talking about features with no bug.  It's fine to have bugs
> if it's maintained and fixed in timely manner.
> 
> I'm talking about a feature with bugs that seems not to be used by
> anyone nor maintained.
> 
> 
>> The feature if used normally works just fine, the bugs that have been
>> found do not cause any stability issue, may be functional issue at best.
> 
> It caused memory leaks in some ways easily without admin privilege.
> 
> 
>> How many applications do you know use MSG_PEEK that these tests are
>> exploiting.
> 
> Security is not that way of thinking.  Even when the bug is triggered
> with unusual sequence of calls, it must be fixed, especially on a host
> that could execute untrusted code.
> 
> 
>>
>> Plus if it is annoying to you just remove the feature from your private
>> distribution and let the others decide for them selves.
> 
> If no one uses the feature that has bugs without maintenance,
> it's natural to deprecate it.  Then, no one need to be burdened
> by unnecessary bug fixes.
> 

