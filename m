Return-Path: <netdev+bounces-218363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABD1B3C30C
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 21:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E7E1888185
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 19:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6392367BA;
	Fri, 29 Aug 2025 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OghQc/jv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x+rsbt88"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F88221543;
	Fri, 29 Aug 2025 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756495997; cv=fail; b=YPW/ncgJKIRWq/MDZtBnvzEnWdVdXZvOps/wXXCSYjqeqUEkZbCoYwpsMLA7CQqtBRGDbyVerMDb626fslnose6lsnm5/sSP5aCnX894dxrKDxu43cpFOI4XrHjYkoii7FSl9OiaeHCvBov9IOSPF64D8Byr604tkyuauH8paWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756495997; c=relaxed/simple;
	bh=ID0o0oQxoB/xz0Ft10OCgtc7oaBb/LAfiFnkNpx9TBs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HTt47u+FreiQgLA1sXpsb8C47roOiVEMcUgvVhHHDfL5z62YGrgkZf42TtgwkW3EAOeW6Lrh7xixPeGY7l1y6IJATjsY/hide02mdFZPt9ujq438scbN1bV6W1F0bZJOqPnktLsv6uUXYotfjFfq3kSHpe2iRjDttw+f7kRCNZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OghQc/jv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x+rsbt88; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TGgFB8017019;
	Fri, 29 Aug 2025 19:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=byJDmTopH2MyXoqFXnEbqc3JHCiYJUEIfbc1XDKzoas=; b=
	OghQc/jvptqsgiW/z1CSwuiqFIPvEiDUIxj6Ud7qfGX8l41VFo5fggW6cpxV2k62
	lhYXkT1FSduxIxh8SfvxYFCMYLu0UpJ5jobtVMhlO5SHIBE8wSoEdEPNx5gESF6m
	qC+UqQrBCLH2ro6C1Cvwcuc4oNi+F58rh4ByshTYeuAYl0TDni8gnYoIT1e/tpET
	ijp/u6+LAHNxpKvWnAut7ISfDOqrA0s+lg71K86PQE2XpVwezB2phGXTLWWy2RSM
	d5iRJOImNr6KqUKzs0z7oJUMD+kO6CpwdTzw2EHXc8CAx1Xs26DB423muTJXPG1K
	JxlQpY/QP/sHwtuAvd1NEw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q6793448-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 19:32:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57THNd0u014658;
	Fri, 29 Aug 2025 19:32:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q43dgqkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 19:32:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WohwS7SmLYhXezApOABOVdafTQx7SUVJC4T0Afkl6o/1rZmqSF9lTIFMJlUTlyJBmewO0FBq81g0czLnkT0ZF11Ljx4yl9J4GL+NrUP0QW5XGUVaqI1W7KixVhVJPLinHYo0gTpMbITH6vcu/SKuPn/aHwle+wKqy3FeZ4fy9gSvz8HVBxjwOWNinZ6E0F9/Wn01uTzSgv9l1Z5U+Mrvl3mNgYZhdvLAY2w9UWooTvoCgYHVnPVNaBGIHE+GcNhuW2G+ttaC7VxJYWShSEq8+DhkoAaFHGFLaa3T9TgNucvukRaRdhz3Ja+0shLCMVttYjLd8r+MmpkWPhFT70+N+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byJDmTopH2MyXoqFXnEbqc3JHCiYJUEIfbc1XDKzoas=;
 b=d6DycgzBhTeXvXJadS5k5ENThNhjDk6os72jGiRv1jVfgHDpduJvBhsOFFLPL85xulxGvmKC3xEi1Q04YlysrITtPCUtyzT/3VzsKbMENCh2Z4n+QPaaK1zRWhhdaFyF3MSSvld9B3GJGpGGLfN34VRlwR7rXmi4WURtf9HgEecyLSEDXsvojEGAcUDI7FtdJ7dvir/4t0hyuGqISerp4XD3mnTkFwDkefNw2kyYagnsg04MabtBUlnTv7N44gjG5kqJH/TYjyzKGAqkZLwRH/FRbgkWzaNFvoJpRKgzP2BfZbjvZ/J4fL+UagBa0q/tMtBA+lpLOFV20qP7LO+IPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byJDmTopH2MyXoqFXnEbqc3JHCiYJUEIfbc1XDKzoas=;
 b=x+rsbt88DYHJK3XhVPBYLj6Fv0LDtNqHHHDQRyKEo9SoXWvWcF7O8Kt5bpMxp1LKpQZzvQ/b5ELCYvQKt+ZnC4doG3jDt3sVN264VM695Lr5QRKC6bYijeJwyGH5JmVO7ITDhwQqDFhjVZGPpM0P54GRxypdiBFrkbnzfZvcfHs=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CH0PR10MB5132.namprd10.prod.outlook.com (2603:10b6:610:c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 19:32:31 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.9073.017; Fri, 29 Aug 2025
 19:32:31 +0000
Message-ID: <25237d53-a93d-4c1f-a7a4-4b6ed03e10e4@oracle.com>
Date: Sat, 30 Aug 2025 01:02:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v25 1/1] mctp pcc: Implement MCTP over PCC
 Transport
To: admiyo@os.amperecomputing.com, Jeremy Kerr <jk@codeconstruct.com.au>,
        Matt Johnston <matt@codeconstruct.com.au>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Huisong Li <lihuisong@huawei.com>
References: <20250827044810.152775-1-admiyo@os.amperecomputing.com>
 <20250827044810.152775-2-admiyo@os.amperecomputing.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250827044810.152775-2-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0108.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::11) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CH0PR10MB5132:EE_
X-MS-Office365-Filtering-Correlation-Id: 51bb5e40-7fe2-4bb4-2ee3-08dde732ca0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3BiS2lMTVoxaWFGWVM2aTBNZTczSDdvQ1V4M2JjOGt4U2NpMlByYlczYmxM?=
 =?utf-8?B?c1ZPV2g2Tk9CMk5hMnV2dmJvazdxOThla0toRW1sQ2wyclRNUERNUUtPVHRV?=
 =?utf-8?B?TzNkUVljS1pmckNjb3QyOFEzNFppNnF0NXpiZE9naDFTRVZxVFZFdmJFSjVX?=
 =?utf-8?B?NUJDYnIyVTRrckZRbGwwdlRDZ0xOaC9lVmNVMlpRUXZFV3pqbVVmNGZLUXIz?=
 =?utf-8?B?Y2d3aGxrZFhiQWtIVE9iTjZJRmVqUzRuYk5idm42c1RTNGdMekUxVEJpSzRy?=
 =?utf-8?B?dlVSZ1ZVRE5ySUNMY2pEUkEzengvV3ErL29ZaUxFMlBGWTMvSEZURGtMWXFF?=
 =?utf-8?B?enFuS2ppNmx2bDNhU0hRNEZESkdzOFJFYnd0VFhLRWJkNGNIelBRejNjclc0?=
 =?utf-8?B?OXN4N2IwejRaZ0xNRnVYVVNlUFo1RklhaFNoU2dhMzhvamNYTkM1aUdXSGhK?=
 =?utf-8?B?aG5HRkZadjdXVHljMk1KcVZQQTJRTjRBL0dOQjA1bk9HUEJ5U2ZQY01WWHhW?=
 =?utf-8?B?THNtYUhLTmhQRWMyT3JWL3EwaTIrb0VuMHNBQ3ZRaGIvUGtmcWQ2UmxDWDgz?=
 =?utf-8?B?c00yWFpJeGFFSjFVY291OFEzcUw0L2Y1RERvbjRMaXVlUWRpNVpIeWltdmJt?=
 =?utf-8?B?bnFJY2dPZG5QZkxEL2U2T0kySzl3b25LeE4zc1hsK3hiemRSYjk1bzJBTHpz?=
 =?utf-8?B?UUphMjgvQVpOZnNEYTBBNytXMnBkMEhibEl1ekRnWldObG5udDRRL3UzcVZI?=
 =?utf-8?B?VHArMU56Y3JJZlo5UXZEWnB1bldLT281U2NIU0RSMnd3ODdZakl3b29xcHFY?=
 =?utf-8?B?cmpSTm1BTnNhejRTQmNPeXYxNURmODdaem5jVEMxZ0RnT0NjTHYrd0QxRkZF?=
 =?utf-8?B?c21sbVJpb0JUL2xDTmxUYVhTQlVvbmc0VVc5MkY0TVAwWFBBQVZyM3lLOWdq?=
 =?utf-8?B?VUxkU291bU9ZcmU2WitZS040R1EwVlQ1N05LS3h0MnBrZjFSQ2crTXdQNzkw?=
 =?utf-8?B?NVpxZFpWZDFqek14V2JZTG02aXZYek1jdWpIMDlGSVA1TlRKUTFGUUdwNG1i?=
 =?utf-8?B?RXBXQUJsaFJWMFcrWTZlNUxiMU9TUVlBY1E1dlY1RThmOFNsd0VTTnRTZWo3?=
 =?utf-8?B?REIzQmpGS2UvNHAyUmFMRWlqZWpoODVLSEkwdktDdFVNVnc1QWFoZnV1NUw5?=
 =?utf-8?B?NzA1Y0NIeVNNREhNQmxCelNtTXZ5VVRkQ05ZR2loSllybGNFZmlSMVRzRDNZ?=
 =?utf-8?B?VzBJS0Rkd3p4MnJJVTNFY0Qvc21YVldUUmxVV1lyemhhc2pNTUZTK0k2Tm5F?=
 =?utf-8?B?Z2wra0pVY1d1TjRTZmtNL1hQUnl3RmpTRVBSTGZzajYwUlMrZHl5MkpnbVBT?=
 =?utf-8?B?WjlSQmIyb252U3V0VmxZWUEzZ0FQQjNlbSs3VHhnVU02a0F2RlpBVTNKYzNy?=
 =?utf-8?B?RWs1bEEraDNhdlhCY1BzNERQMmlFQU9xS0RBSWhpblNCSGpMMlBZaWh4TGpV?=
 =?utf-8?B?MmtRVWFsZzE0QkNVYldkY1FEZWIwbThQNXRlSDBPZUh3a25wSjYyajNxRitR?=
 =?utf-8?B?ZysvT28rRWYxZ3FQcjB3WURGWDNWZTlqaEptbC91bGQzSTArdmdqeUF2Y0FK?=
 =?utf-8?B?QW1sc1JMeVhiTFNwQ0JrOEtoYm5OU0JaeTNnQjBQNVN5TGZLOG1RY0t1Smxw?=
 =?utf-8?B?TU1TdVczTERtQm8vWVc1S21QNkZ5dnhMcElRN1gzMUsrYzFpT1hTWG9aWXpO?=
 =?utf-8?B?a0xuL0V1YWg5TmFpRVUyZTkwd0xESmtMaTlzM2JpY1J3U3JqdTVXbmNaKytM?=
 =?utf-8?B?cEIyU1ovRXRUUVpKaWp0V3VnOUE3bDE0OEhGazVOSU4xV3B0YUUxeXBITDU3?=
 =?utf-8?B?YXVmQm9tcVRmOXBMTHA0SFRXemg5ZGlsSTNBY0I1Q2h5VTBEYXVRUWtEL1or?=
 =?utf-8?Q?EvKvzUiWNvA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VURKOUUwb2pSdklRMGFEeG9KMER0NWVlc25KUTlZODBvdVpxK1pLVUQzeEps?=
 =?utf-8?B?Um5FMkN5K25oMFMxbll4SW9IQUxMcWVaUGFoMy9nVzBreHA0T0dHVXMxZ25P?=
 =?utf-8?B?eUFQTEszMU52aHlrMEUzSWRUdnJMNVJxbGQrcFRRRStkOUp5NFhmVitYMllM?=
 =?utf-8?B?bVcveG4yQWd1UWZLcTVicndEemtvc0txempVZG1zZ1d1ZktyVkF0YWJ3dFVU?=
 =?utf-8?B?b3lHb0p2MEJNVmMzWnRMTm1MenRWeFNjSkdXelgyUG0rODR1RUpOSmNSYnRt?=
 =?utf-8?B?Wm1ONGRoZmlsU0hjcmlRR2pKR0xwa3Y1bWhiODZUeGo5dC9NUkN5MmFZU0pZ?=
 =?utf-8?B?bEh3cUtQS2cyMGJtTE8rWWI4RU1ieEoxckxIV2tBc3B0bmZJOHU5L20waWlJ?=
 =?utf-8?B?TVB1N3I1cjIrTUFuSU9RanZwa2QrUzM4d0Q3LzdxaWR1ZStqY0MrK3RUSGpn?=
 =?utf-8?B?TTY2RUkxa2RDeUQza3lkdFU2bjFPZm5IQUZJd1ZsNFBJNTc2cnl4TVQxa1pI?=
 =?utf-8?B?aXNrVVQ4NVJ3RW5BRFVVbWMreFRmaXJPSnZqalVnWkx6SHZ4QURxZUVKTkh6?=
 =?utf-8?B?WmE1THE4Z0VYOWJiOXhuanR4RWR4eGtOenJIVXB2dUJLYUZMVXV4a2hLVGRm?=
 =?utf-8?B?LzNyZFUySDF3S01TNGN1d2l3WEt5SWR4WFdhWTBFUlptczNibVQ5NHp4NTB4?=
 =?utf-8?B?eHNWR2YvQXIzU3h6V3NFa3NDZ3FFK3BVeUdZUGlxMlBlOUh5ZndLQzJkMWVj?=
 =?utf-8?B?L1JnL1JVTWx2UEFpU1ZVTzdGc0lzSTI0MUV0RUhzUmdDYnJrQ3cveVRXSDNJ?=
 =?utf-8?B?cmcydTN0OG40akJqaTZEZTdrSDJ3YUFOWmpkakpHSjlyOUI5OHBBcTBrUXJw?=
 =?utf-8?B?UEROUFNwbkZ5ODJSNUJmSUVwcHNnZTJyOW1uSjRCUDdiMCtDNEliMDMvY3JM?=
 =?utf-8?B?QjYrb2FxaXlpTkk5U3hvOWxGMmFVS09HdHNHekErSU9mMjRFU1pSWlJSYWpL?=
 =?utf-8?B?emlQc08vakRZejkrSFkrODNZMk1RK1l6c0FBVWFvb0x0MWdFMDJwSXM1QWxV?=
 =?utf-8?B?dUlQREJuK3dUTDlhK0N4b0F2SWZCUTZLb0VXaldleEVWRlAxcEFrTkVITGVD?=
 =?utf-8?B?T3lBQmI4cWhXQmFBQi9XMklvTVJ6aDNpT2FjK0xhb2ZDL0JRWGZLRE1Ea1N5?=
 =?utf-8?B?NENSYzFkSDNHU2FWbWJ5czBLVkZmdHRRc1BVa1dDYStzM29lb0t3aWZWdGk1?=
 =?utf-8?B?ajFKYXVZTEdwN0Y2YmY3SS82NDAxSjRHYWpwUFNTQTlyLzdIcXVjVG9aeDZT?=
 =?utf-8?B?TTNLdGR0Q1IyR0NzcHJwMzkzQkxVMDk0VFo5TlFNN1ZLNEpacXZGdWhkRlRi?=
 =?utf-8?B?eDhnMTF2NnFyQTJQbFNRU0lmRTRWbXRvdzg0VDk4R0gxeGp4dFdJblc0dHBF?=
 =?utf-8?B?RStBZ1BnYTFFWjhneFFHaU8xQ0dqUzRsVnFwZTlTRG1BVlNvTXIwSFdqS21X?=
 =?utf-8?B?cjlNdFRsUksyT1ZEci9RNWFYd2Q0VElJd1RjUlQ1MWNIbmJvajhoT1ZUNTVE?=
 =?utf-8?B?NGpvalJaNkh4LzZoZnM5TmxuT0VXazZLdmdEa1hyZ3dFT29iRkNMVHB0NWMw?=
 =?utf-8?B?ZGNTeXZjOHNHbllYaldINmd6bXh5RnBDc1JKMitzdDcweVRrTnRKQmlHUGky?=
 =?utf-8?B?MS8vWXJ2SGF6alZ4bUduUjRwQmpRNklOMzAzWFk4KzFUZlRUSFQ0U1ZjR3Fk?=
 =?utf-8?B?SFA2R0hlWmJkUndrc0ZHaWw4aWpuUjl4MjBrc3RsSkJGSUo0M3h4ZllOdXUr?=
 =?utf-8?B?ZXJXSUNHSktiSTlLcmprUFlraklya1k4Zkt2d05rYXZVOGlFTHcvU1BKT3dY?=
 =?utf-8?B?Y3NUdkJOZ0dZOCsxOW01aVJJK2VUTjk4cnR0S0pxQkt0ZHg5YmNqbHRrMTZI?=
 =?utf-8?B?NXhwKzFZdllkMUhqRGZCMlpPNk9wSUcyRGlKYndrU1kzay8wY09EL05jZ0lO?=
 =?utf-8?B?blhySXI4dHlIelhPZUtickd4UzhhSjdhRFpGR2VoTVVyWVJTdTdQeFJtTkZQ?=
 =?utf-8?B?TDJSNDVpQ211TzBVMkcrVG81SHFzbFU2RUpFOGs5OTBFTE03QzdWS2tRWlhZ?=
 =?utf-8?Q?TcqyuDHrrFp7/lTXN94YyBQcj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f8BETfoSlVT9qswdk05dpPhCo6Z8dbfjrBNrzZEhCeCHB+L1FAMxWFPJWm8EGgnkrfK3pceIZ5d1izGPxrGhW7rwDraE3lIy/3tk81b6XY2Nq7O98E1s8KBTbyrEfRX4smJaWJmAWtP4aZMWVdIJ/Q++IgbRh0RTGi0M5F1HUEurgUz/7gSzn/2xC5lBqoehOZrBiiIH1hL8fTS9vNghqfH8zME4Ug7by6gTPVvFTWnP+nH5KLwhJB9ex6vz714cXBOMgtK7zXuYDRx+6rBOCqvmsNJ+Ifb2MbgRiUiwElgRooiQnpkW9HPhPWSM4yQo0tL/KJWlWevROm5XHNp5HWSsWWjPw6viljOvBSgopupCuPkkX3kBpqS3nTA+NEC2rxjxz9wMc/rGrmin99kVZOcf7EdbBQNUzBVZuJ14TSYtYkZ2pS3+7LDi9w5uTrflKK+xK3+WkQqU3cHN1hYGhoVx7sV9E+PqVTJocyIQx0tds98KzS+JZS33uLfXjJAHtnwPqyqB7GycY6OQ/nC/XV2OuJdP4AD1+hhOAOx/3arfr+dRKCYNreAW4NZ/ZBY5+3PEpO5xs1oaa1Mb/dL31yZN3cmYYHPuqr1TqjmSwaU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51bb5e40-7fe2-4bb4-2ee3-08dde732ca0a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 19:32:31.7354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2uI+lvsiYfxcl/HRetY2TagA2QpnjiWNGDdSA+yGKO1MtnEKGXqLLs/aywLLMg1hYNtNvgwXaeskzBa95QFjmgZ4H/Td//1SFhTTGjuAW5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5132
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508290173
X-Proofpoint-GUID: 7kkB51M7tVowP8hrPtUeFnK_lGnUm7MT
X-Proofpoint-ORIG-GUID: 7kkB51M7tVowP8hrPtUeFnK_lGnUm7MT
X-Authority-Analysis: v=2.4 cv=NrLRc9dJ c=1 sm=1 tr=0 ts=68b2005b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=iGbCS3zQAAAA:8 a=vzhER2c_AAAA:8
 a=yPCof4ZbAAAA:8 a=JfrnYn6hAAAA:8 a=jtIGK69kn0MS3caa9P8A:9 a=QEXdDO2ut3YA:10
 a=oRZS8w7TM5j8Y1SnqK-S:22 a=0YTRHmU2iG2pZC6F1fw2:22 a=1CNFftbPRP8L7MoqJWF3:22
 cc=ntf awl=host:13602
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNSBTYWx0ZWRfX3woltKVNxq0h
 aHxKgZ5AWdOLMLvNGYgvAjsegB5++8PH64oc7hf/5OyRmpifqr9ceed6gb+DL+gL2/jKMrgXmR1
 YyWkYT5tf8R4JMKJZ6k44MIr/Cn8IJsZQiH5nk9LD6MzBeOJakrVbbvW9kdxVXk2VsmoTS1HaC6
 fyzSc7AwfKGHk1kfC8cEj2UEo9envNvQG3axE3H4HuWiiuwmAslNozkLcl1WeT86nRn9OL7IwQz
 9sM3KDWKBYWygdUt7gqhrn++hS64SkBZVC753S3dF1wmTgDn7m8iqdjnS2LfESHEoj98ceBMCcM
 BSk3cC9tdjvnrzfwnbEbXTGxxWvgUqTnfR/eY+c+tloJEaMMU7slwjkwBa6ghvskL7cyRDOOqR7
 IXHHAVIGoNVqj5znvk4a0wMG4YGDhw==



On 8/27/2025 10:18 AM, admiyo@os.amperecomputing.com wrote:
> From: Adam Young <admiyo@os.amperecomputing.com>
> 
> Implementation of network driver for
> Management Control Transport Protocol(MCTP)

it is Management Component Transport Protocol (see DMTF spec).

> over Platform Communication Channel(PCC)
> 
> DMTF DSP:0292
> https://urldefense.com/v3/__https://www.dmtf.org/sites/default/files/standards/documents/*__;Lw!!ACWV5N9M2RV99hQ!JkW80M1xGJjvaXd72o192mqV0uzOu511ibGTz-JCtmbsM_IrpuZ0jJeeQFOug5UHp8fNY1dX2Lk0_hPUUY__KokwgtE$
> DSP0292_1.0.0WIP50.pdf
> 
> MCTP devices are specified via ACPI by entries
> in DSDT/SDST and reference channels specified

SDST -> SSDT

> in the PCCT.  Messages are sent on a type 3 and
> received on a type 4 channel.  Communication with
> other devices use the PCC based doorbell mechanism;
> a shared memory segment with a corresponding
> interrupt and a memory register used to trigger
> remote interrupts.
> 
> This driver takes advantage of PCC mailbox buffer
> management. The data section of the struct sk_buff
> that contains the outgoing packet is sent to the mailbox,
> already properly formatted  as a PCC message.  The driver
> is also responsible for allocating a struct sk_buff that
> is then passed to the mailbox and used to record the
> data in the shared buffer. It maintains a list of both
> outging and incoming sk_buffs to match the data buffers

outging

> 
> When the Type 3 channel outbox receives a txdone response
> interrupt, it consumes the outgoing sk_buff, allowing
> it to be freed.
> 
> Bringing the interface up and down creates and frees
> the channel between the network driver and the mailbox
> driver. Freeing the channel also frees any packets that
> are cached in the mailbox ringbuffer.
> 
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
> ---
>   MAINTAINERS                 |   5 +
>   drivers/net/mctp/Kconfig    |  13 ++
>   drivers/net/mctp/Makefile   |   1 +
>   drivers/net/mctp/mctp-pcc.c | 367 ++++++++++++++++++++++++++++++++++++
>   4 files changed, 386 insertions(+)
>   create mode 100644 drivers/net/mctp/mctp-pcc.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bce96dd254b8..de359bddcb2f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14660,6 +14660,11 @@ F:	include/net/mctpdevice.h
>   F:	include/net/netns/mctp.h
>   F:	net/mctp/
>   
> +MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
> +M:	Adam Young <admiyo@os.amperecomputing.com>
> +S:	Maintained
> +F:	drivers/net/mctp/mctp-pcc.c
> +
>   MAPLE TREE
>   M:	Liam R. Howlett <Liam.Howlett@oracle.com>
>   L:	maple-tree@lists.infradead.org
> diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
> index cf325ab0b1ef..f69d0237f058 100644
> --- a/drivers/net/mctp/Kconfig
> +++ b/drivers/net/mctp/Kconfig
> @@ -57,6 +57,19 @@ config MCTP_TRANSPORT_USB
>   	  MCTP-over-USB interfaces are peer-to-peer, so each interface
>   	  represents a physical connection to one remote MCTP endpoint.
>   
> +config MCTP_TRANSPORT_PCC
> +	tristate "MCTP PCC transport"
> +	depends on ACPI
> +	help
> +	  Provides a driver to access MCTP devices over PCC transport,
> +	  A MCTP protocol network device is created via ACPI for each
> +	  entry in the DST/SDST that matches the identifier. The Platform

should be DSDT/SSDT ?

> +	  communication channels are selected from the corresponding
> +	  entries in the PCCT.
> +
> +	  Say y here if you need to connect to MCTP endpoints over PCC. To
> +	  compile as a module, use m; the module will be called mctp-pcc.
> +
>   endmenu
>   
>   endif
> diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
> index c36006849a1e..2276f148df7c 100644
> --- a/drivers/net/mctp/Makefile
> +++ b/drivers/net/mctp/Makefile
> @@ -1,3 +1,4 @@
> +obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
>   obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
>   obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
>   obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
> diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
> new file mode 100644
> index 000000000000..c6578b27c00c
> --- /dev/null
> +++ b/drivers/net/mctp/mctp-pcc.c
> @@ -0,0 +1,367 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * mctp-pcc.c - Driver for MCTP over PCC.
> + * Copyright (c) 2024-2025, Ampere Computing LLC
> + *
> + */
> +
> +/* Implementation of MCTP over PCC DMTF Specification DSP0256

DSP0256 vs DSP0292 mismatch

> + * https://urldefense.com/v3/__https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf__;!!ACWV5N9M2RV99hQ!JkW80M1xGJjvaXd72o192mqV0uzOu511ibGTz-JCtmbsM_IrpuZ0jJeeQFOug5UHp8fNY1dX2Lk0_hPUUY__EEa7amg$
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/if_arp.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/platform_device.h>
> +#include <linux/string.h>
> +#include <linux/skbuff.h>
> +#include <linux/hrtimer.h>
> +
> +#include <acpi/acpi_bus.h>
> +#include <acpi/acpi_drivers.h>
> +#include <acpi/acrestyp.h>
> +#include <acpi/actbl.h>
> +#include <net/mctp.h>
> +#include <net/mctpdevice.h>
> +#include <acpi/pcc.h>
> +
> +#define MCTP_SIGNATURE          "MCTP"
> +#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
> +#define MCTP_MIN_MTU            68
> +#define PCC_DWORD_TYPE          0x0c
> +
> +struct mctp_pcc_mailbox {
> +	u32 index;
> +	struct pcc_mbox_chan *chan;
> +	struct mbox_client client;
> +	struct sk_buff_head packets;
> +};
> +
> +/* The netdev structure. One of these per PCC adapter. */
> +struct mctp_pcc_ndev {
> +	struct net_device *ndev;
> +	struct acpi_device *acpi_device;
> +	struct mctp_pcc_mailbox inbox;
> +	struct mctp_pcc_mailbox outbox;
> +};
> +
> +static void *mctp_pcc_rx_alloc(struct mbox_client *c, int size)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct mctp_pcc_mailbox *box;
> +	struct sk_buff *skb;
> +
> +	mctp_pcc_ndev =	container_of(c, struct mctp_pcc_ndev, inbox.client);
> +	box = &mctp_pcc_ndev->inbox;
> +
> +	if (size > mctp_pcc_ndev->ndev->mtu)
> +		return NULL;
> +	skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
> +	if (!skb)
> +		return NULL;
> +	skb_put(skb, size);
> +	skb->protocol = htons(ETH_P_MCTP);
> +	skb_queue_head(&box->packets, skb);
> +
> +	return skb->data;
> +}
> +
> +static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct sk_buff *curr_skb = NULL;
> +	struct pcc_header pcc_header;
> +	struct sk_buff *skb = NULL;
> +	struct mctp_skb_cb *cb;
> +
> +	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, inbox.client);
> +	if (!buffer) {
> +		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
> +		return;
> +	}
> +
> +	spin_lock(&mctp_pcc_ndev->inbox.packets.lock);
> +	skb_queue_walk(&mctp_pcc_ndev->inbox.packets, curr_skb) {
> +		skb = curr_skb;
> +		if (skb->data != buffer)
> +			continue;
> +		__skb_unlink(skb, &mctp_pcc_ndev->inbox.packets);
> +		break;
> +	}
> +	spin_unlock(&mctp_pcc_ndev->inbox.packets.lock);
> +
> +	if (skb) {
> +		dev_dstats_rx_add(mctp_pcc_ndev->ndev, skb->len);
> +		skb_reset_mac_header(skb);
> +		skb_pull(skb, sizeof(pcc_header));
> +		skb_reset_network_header(skb);
> +		cb = __mctp_cb(skb);
> +		cb->halen = 0;
> +		netif_rx(skb);
> +	}
> +}
> +
> +static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct mctp_pcc_mailbox *box;
> +	struct sk_buff *skb = NULL;
> +	struct sk_buff *curr_skb;
> +
> +	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
> +	box = container_of(c, struct mctp_pcc_mailbox, client);
> +	spin_lock(&box->packets.lock);
> +	skb_queue_walk(&box->packets, curr_skb) {
> +		skb = curr_skb;
> +		if (skb->data == mssg) {
> +			__skb_unlink(skb, &box->packets);
> +			break;
> +		}
> +	}
> +	spin_unlock(&box->packets.lock);
> +
> +	if (skb)
> +		dev_consume_skb_any(skb);
> +}
> +
> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
> +	struct pcc_header *pcc_header;
> +	int len = skb->len;
> +	int rc;
> +
> +	rc = skb_cow_head(skb, sizeof(*pcc_header));
> +	if (rc) {
> +		dev_dstats_tx_dropped(ndev);
> +		kfree_skb(skb);
> +		return NETDEV_TX_OK;
> +	}
> +
> +	pcc_header = skb_push(skb, sizeof(*pcc_header));
> +	pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
> +	pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
> +	memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
> +	pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
> +
> +	skb_queue_head(&mpnd->outbox.packets, skb);
> +
> +	rc = mbox_send_message(mpnd->outbox.chan->mchan, skb->data);
> +
> +	if (rc < 0) {
> +		skb_unlink(skb, &mpnd->outbox.packets);
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	dev_dstats_tx_add(ndev, len);
> +	return NETDEV_TX_OK;
> +}
> +
> +static void drain_packets(struct sk_buff_head *list)
> +{
> +	struct sk_buff *skb;
> +
> +	while (!skb_queue_empty(list)) {
> +		skb = skb_dequeue(list);
> +		dev_consume_skb_any(skb);
> +	}
> +}
> +
> +static int mctp_pcc_ndo_open(struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev =
> +	    netdev_priv(ndev);
> +	struct mctp_pcc_mailbox *outbox =
> +	    &mctp_pcc_ndev->outbox;
> +	struct mctp_pcc_mailbox *inbox =
> +	    &mctp_pcc_ndev->inbox;
> +	int mctp_pcc_mtu;
> +
> +	outbox->chan = pcc_mbox_request_channel(&outbox->client, outbox->index);
> +	if (IS_ERR(outbox->chan))
> +		return PTR_ERR(outbox->chan);
> +
> +	inbox->chan = pcc_mbox_request_channel(&inbox->client, inbox->index);
> +	if (IS_ERR(inbox->chan)) {
> +		pcc_mbox_free_channel(outbox->chan);
> +		return PTR_ERR(inbox->chan);
> +	}
> +
> +	mctp_pcc_ndev->inbox.chan->rx_alloc = mctp_pcc_rx_alloc;
> +	mctp_pcc_ndev->outbox.chan->manage_writes = true;
> +
> +	mctp_pcc_mtu = mctp_pcc_ndev->outbox.chan->shmem_size -
> +		sizeof(struct pcc_header);
> +	ndev->mtu = MCTP_MIN_MTU;
> +	ndev->max_mtu = mctp_pcc_mtu;
> +	ndev->min_mtu = MCTP_MIN_MTU;
> +
> +	return 0;
> +}
> +
> +static int mctp_pcc_ndo_stop(struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev =
> +	    netdev_priv(ndev);
> +	struct mctp_pcc_mailbox *outbox =
> +	    &mctp_pcc_ndev->outbox;
> +	struct mctp_pcc_mailbox *inbox =
> +	    &mctp_pcc_ndev->inbox;
> +
> +	pcc_mbox_free_channel(outbox->chan);
> +	pcc_mbox_free_channel(inbox->chan);
> +
> +	drain_packets(&mctp_pcc_ndev->outbox.packets);
> +	drain_packets(&mctp_pcc_ndev->inbox.packets);
> +	return 0;
> +}
> +
> +static const struct net_device_ops mctp_pcc_netdev_ops = {
> +	.ndo_open = mctp_pcc_ndo_open,
> +	.ndo_stop = mctp_pcc_ndo_stop,
> +	.ndo_start_xmit = mctp_pcc_tx,
> +
> +};
> +
> +static void mctp_pcc_setup(struct net_device *ndev)
> +{
> +	ndev->type = ARPHRD_MCTP;
> +	ndev->hard_header_len = 0;
> +	ndev->tx_queue_len = 0;
> +	ndev->flags = IFF_NOARP;
> +	ndev->netdev_ops = &mctp_pcc_netdev_ops;
> +	ndev->needs_free_netdev = true;
> +	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
> +}
> +
> +struct mctp_pcc_lookup_context {
> +	int index;
> +	u32 inbox_index;
> +	u32 outbox_index;
> +};
> +
> +static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
> +				       void *context)
> +{
> +	struct mctp_pcc_lookup_context *luc = context;
> +	struct acpi_resource_address32 *addr;
> +
> +	if (ares->type != PCC_DWORD_TYPE)
> +		return AE_OK;
> +
> +	addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
> +	switch (luc->index) {
> +	case 0:
> +		luc->outbox_index = addr[0].address.minimum;
> +		break;
> +	case 1:
> +		luc->inbox_index = addr[0].address.minimum;
> +		break;
> +	}
> +	luc->index++;
> +	return AE_OK;
> +}
> +
> +static void mctp_cleanup_netdev(void *data)
> +{
> +	struct net_device *ndev = data;
> +
> +	mctp_unregister_netdev(ndev);
> +}
> +
> +static int mctp_pcc_initialize_mailbox(struct device *dev,
> +				       struct mctp_pcc_mailbox *box, u32 index)
> +{
> +	box->index = index;
> +	skb_queue_head_init(&box->packets);
> +	box->client.dev = dev;
> +	return 0;
> +}
> +
> +static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
> +{
> +	struct mctp_pcc_lookup_context context = {0};
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct device *dev = &acpi_dev->dev;
> +	struct net_device *ndev;
> +	acpi_handle dev_handle;
> +	acpi_status status;
> +	char name[32];
> +	int rc;
> +
> +	dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
> +		acpi_device_hid(acpi_dev));
> +	dev_handle = acpi_device_handle(acpi_dev);
> +	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
> +				     &context);
> +	if (!ACPI_SUCCESS(status)) {
> +		dev_err(dev, "FAILURE to lookup PCC indexes from CRS\n");

FAILURE to lookup -> failed to lookup

> +		return -EINVAL;
> +	}
> +
> +	snprintf(name, sizeof(name), "mctpipcc%d", context.inbox_index);

mctp_pcc%d ?

> +	ndev = alloc_netdev(sizeof(*mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
> +			    mctp_pcc_setup);
> +	if (!ndev)
> +		return -ENOMEM;
> +
> +	mctp_pcc_ndev = netdev_priv(ndev);
> +
> +	/* inbox initialization */
> +	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
> +					 context.inbox_index);
> +	if (rc)
> +		goto free_netdev;
> +
> +	mctp_pcc_ndev->inbox.client.rx_callback = mctp_pcc_client_rx_callback;
> +
> +	/* outbox initialization */
> +	rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->outbox,
> +					 context.outbox_index);
> +	if (rc)
> +		goto free_netdev;
> +
> +	mctp_pcc_ndev->outbox.client.tx_done = mctp_pcc_tx_done;
> +	mctp_pcc_ndev->acpi_device = acpi_dev;
> +	mctp_pcc_ndev->ndev = ndev;
> +	acpi_dev->driver_data = mctp_pcc_ndev;
> +
> +	/* ndev needs to be freed before the iomemory (mapped above) gets
> +	 * unmapped,  devm resources get freed in reverse to the order they
> +	 * are added.
> +	 */
> +	rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_PCC);
> +	if (rc)
> +		goto free_netdev;
> +
> +	return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
> +free_netdev:
> +	free_netdev(ndev);
> +	return rc;
> +}
> +
> +static const struct acpi_device_id mctp_pcc_device_ids[] = {
> +	{ "DMT0001" },
> +	{}
> +};
> +
> +static struct acpi_driver mctp_pcc_driver = {
> +	.name = "mctp_pcc",
> +	.class = "Unknown",
> +	.ids = mctp_pcc_device_ids,
> +	.ops = {
> +		.add = mctp_pcc_driver_add,
> +	},
> +};
> +
> +module_acpi_driver(mctp_pcc_driver);
> +
> +MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
> +
> +MODULE_DESCRIPTION("MCTP PCC ACPI device");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");

Thanks,
Alok


