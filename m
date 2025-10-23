Return-Path: <netdev+bounces-232063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 790C6C0071A
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 12:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 396F64E529B
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 10:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9578A30217F;
	Thu, 23 Oct 2025 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HKMhJUWP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UBgPAIID"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D5927FB2B;
	Thu, 23 Oct 2025 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215057; cv=fail; b=SuCaP3QGFkVpVtjE/0tsgfuuSOGytffxymVQ056dErgJkBtC1N69qJRElQsEgxr0tj4ngVdawhS7jA8fYGIaeLET6W7/Gq2qjAJ9S0E6VgG4flTgsqyYxSkE5PkC1uWhojqD1AP1doAai4MvfVobfKR7oglTt8kVdIFodLL+pOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215057; c=relaxed/simple;
	bh=wd/bsTC09qUV1vDBUyRF7MsrbB/LePGzPeMULch5nnE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KDaOXJt6TrZOP9WdXjgn00f9EaGa28jBD45jb92dPWB0g8NgRSEA4vdYz0oExDgGlo1kS4VtsA1XRYldkcKt9x94pWeiUI/WoRZxBWIMrJQBsBkLYcHBRRYQ0B2F1L72FAaTgrKtPH8fsNYk0c4c4XP5k545S6Tg1wzbZbW3YaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HKMhJUWP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UBgPAIID; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NANSYW021148;
	Thu, 23 Oct 2025 10:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=wd/bsTC09qUV1vDBUy
	RF7MsrbB/LePGzPeMULch5nnE=; b=HKMhJUWPmhrxVTNdM8j+YM4XLcTOG2W9Zm
	nUYqZkzwum2C9vR6KwBw2SONllrwsafmlqrdf/psHi9jjc1uipFB5bxxht+y17os
	ByjwGbRxfBRKuNcpzjko3qq541RwBJ4eeoK1HKdBPrXMzvCAkTryYlhXjHtJdOem
	d0FMzXqY4a6NjpJHv2A+6xQR38FqoNp1z6at8R1osgOwOcRKtPh+BU8F7AQxWfx9
	ndXZW//HsRgFVfFMTtgPuVDBuG9xeHr4fuyWejC/82Ylie76PQ+Xy8GAh0WTA2vH
	fLDkUb/ulW83N+ea0C2Ugvyd193PVXujiALJwPyephG4sB9jyiTg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xv3k27ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 10:24:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59N9f954022289;
	Thu, 23 Oct 2025 10:24:05 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bfe9cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 10:24:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjqMsbtyUg9sqjjWRt5Ez8kg83tldTJ+aYiN6DVar9O8XZK7Pinx6P0LCZkN2Kk8Waaz0M/FHiMKfX3dXfDcYZcvTzjlQsZ/bb7MvXyeN/E87QanDwesnWtK0mkqHbs6ewdE+FKBMDWgVMBzziHInylvtzuQINA6xuUM7IHkfvopO7aiWwnLJHbYuGr4hjiaSEfLBHVb8MettR5qZ+yJfr4jySixqGcTmce9YLhAaKsSIGxUdK+seo6N6DuxVWF/Jz2Fex1xbs8pbiWAOkt7dT8YAuJNLBCBuECCpcvwH2t3mn46WZwxDRrZM+w09ep35tapDoiZynOkzU00e16Qhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wd/bsTC09qUV1vDBUyRF7MsrbB/LePGzPeMULch5nnE=;
 b=l5UltbO0caPlwSI5nVYb3dhCnudrnjP6Hy3oScUOZi1m0KPNlNOvcwU30R0/ddzlFhLLxqZ1tlFOlTEutvJiZJt4uyJc/x6GoHhNsBG5fBkfdoFTd5ka47GeaV/tN3QuFCG/r01FXzkTEg718ST8ICYu9rigxSRy2iC1YLhc26AdFLeGKAWhLzTdQJ4Buobt/4dCd5yYEDpRiX7/TaBINjlmt5wYgktbJUzeayyDUxXo3/AnoTCuol7dQfe/6HhJ8rSsFmBXrnWKvndzfIzyP57vga24jhwHgw+/KvVQ0vOUvJy//ILWpaXgwNoKa0bOSshWtmTK3ISYNFqb4phDMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wd/bsTC09qUV1vDBUyRF7MsrbB/LePGzPeMULch5nnE=;
 b=UBgPAIIDxf4FRgxqBtwHa8+iH8uPK87mPshdGN5UdAJwsnwqifz+IB51fWJwVpSZVTgHZJrSW/NFaPPbcbct4iYEKbbG+XCW0Luw4j6pLqWYhGomGCSnWDi9dg370xBVff9hu+MSDsMibMR6/1nwub/Npj5/yVfzN7zK0pBx9NQ=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 CY5PR10MB5961.namprd10.prod.outlook.com (2603:10b6:930:2e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.12; Thu, 23 Oct 2025 10:24:02 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 10:24:02 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "sd@queasysnail.net" <sd@queasysnail.net>
CC: "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] udp: Move back definition of udpv6_encap_needed_key to
 ipv6 file.
Thread-Topic: [PATCH] udp: Move back definition of udpv6_encap_needed_key to
 ipv6 file.
Thread-Index: AQHcRAcmQjo+afI7hkOaZelcPsgqMw==
Date: Thu, 23 Oct 2025 10:24:02 +0000
Message-ID: <4d649240da086bad2abd1367e20a611f273bbdfb.camel@oracle.com>
References: <20251023090736.99644-1-siddh.raman.pant@oracle.com>
		 <aPoAwV8fHvYuC2Md@krikkit>
In-Reply-To: <aPoAwV8fHvYuC2Md@krikkit>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7505:EE_|CY5PR10MB5961:EE_
x-ms-office365-filtering-correlation-id: 692d40ff-c6ff-4cd9-5012-08de121e494d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700021|4053099003;
x-microsoft-antispam-message-info:
 =?utf-8?B?S1VtY1ZYTFhqT2NPb2VaeFNtT2NJOXJWN2NnS0dVeDBORUtwMjhuQ3dIRUZD?=
 =?utf-8?B?K1AwSkZ6M2dGUEVEK3ZnR0NLa2hYYnhTU1YyR3hwVThMR2VTTyt0Qjl5VkZj?=
 =?utf-8?B?bDBZUzdlcjExNytGOEZEeDAzcnAxcGhsUWdnU2cyNnloeW92YmpNNGdMQi9w?=
 =?utf-8?B?eFNlaWI4STNQejREM1pqOTRaQU9TWHljVXFXVnh0SjFDb0o5TUdxc2Y4cThK?=
 =?utf-8?B?aXZ5T0Yxc0xrMWhpSE90djZ5YjBUcjhsa2MxTWsxUUpyYURBOFRYMFBDdlRO?=
 =?utf-8?B?dDVaUUtmM0c2MHpVcUk0Q3NiWGh1VUFLeU5tdkhBZGdvWitzWVpPcFVET25y?=
 =?utf-8?B?eEVIQnRDbW5qWU80NDIzclIyL0o5eGtWNUVYSVBGZURsQy9kd2ZwN1k0Qloz?=
 =?utf-8?B?YnRnYWtQRUVLVmtQZmp1R3BQREZ0clFWdENZOXN1OXhpL01zZFM2LzFPaWIv?=
 =?utf-8?B?bFByZnZIOGhWQ1RHSisza0crU3d6eWxjSUorRU9xOEdiU05WQzdndkFVNXhw?=
 =?utf-8?B?Qys1dHQ2UlcyUDcvL0Q5U3ZuY3NqeXNUVU03MEZVTldEcEY0M1I5anZDMUQ2?=
 =?utf-8?B?SzRFZlhrVGVweGZHbnE5Y08vR0VyYzFnQTZpeVdUYkNUQUl2cFBkbDFWUHZL?=
 =?utf-8?B?dVdPaVM3U3RnRSt0ek9keVVsQlc1ZjU5bjVzdU5kNnZ2YlM3aXlHRFBRQVNn?=
 =?utf-8?B?S0taNHp2TW44OG5EUUtLbmZJQ2c4T0wzb3Jtc1dBNDBvSXJjcWxDZ1JxUW9T?=
 =?utf-8?B?U240MER5WmhXVXJHYkNEQW9ZblVGdTlsMlhIRVZXZExOOEdrYzhCM3Eyb0g1?=
 =?utf-8?B?SHRLdnZkQmVUR1h5bEd0L1Y2a0ozVldSQWhPRVloeHdTTmxBNlVDR0o5Tm5K?=
 =?utf-8?B?eVdVOEdqYis1TmRNYmlIUG5GVEtnaHFZME5kN2JtSlFsdXBtMlZIUERGUUsw?=
 =?utf-8?B?TTdLanJ6b2JwY1BEOExJcUx2UjUyUWozWDdtWFprcWNuQ2NPY00wMHZ6UGwx?=
 =?utf-8?B?OHExRVE2RlhZdkxFV056c1UzYyt0YXZDbEVqd3IyMUpJaHJEQm1zWFdQZnJH?=
 =?utf-8?B?cWVGM1d5enEvcitwOW41NHc1YVBrL3BOYnFTTmh6dFNQTkFJbTVtM210dlNz?=
 =?utf-8?B?VCtFcTFyVW9SVG1RSjR3VFpoQ0xDdExlOFNwalU1TXRCVnpDRTRIUnpxMGdY?=
 =?utf-8?B?V3RzajJlTFY4UlV3MmdYSUlQQklhWFhtWFVCQ3l4YWc0STY0Z0hRMHZxT3Zo?=
 =?utf-8?B?MjlYN1Y0ZFVtTExrQ01YV0JOd1hyNkNnMkcyTXQ3NzAveVVwS3IxMGZ1V2Nh?=
 =?utf-8?B?aGNZQWwwNkpOcS92eUNmdFhpSFZTeUEvZjV1SXNFWGFVeFBzWlNyUmJDcmM1?=
 =?utf-8?B?NHB4b1Z2M3BKWi9yaGtCQVlhQ3hlaGZKY2pabWpDWFNaVnowYUxYeTMxVit6?=
 =?utf-8?B?UHEzbHBKZkc4cjZMcDM3WFM5RDFZdTl0VjNCOFgyLzFZM2J0amVJNHpxUjdl?=
 =?utf-8?B?aURJQXdSNHF5dmV5b0FFVnpjSk5NOFhibG9VSjlxOVQ4OWFRQmJhTVJnMFpa?=
 =?utf-8?B?UXpjZ3N5RVVkMkhQRnZWMUdrS005ekc5YjVYM3dkNWNMTFdLQUYxaHBrSkZO?=
 =?utf-8?B?eEd0VS9jSTFrL1lDdGxXK1d1b0JQaVdEMEhpVld6MllIZlZyRkthNVZ6Y2VQ?=
 =?utf-8?B?dVgrcTJlR25UeGppNUxFQ2NoZEk4cFJ4UFhBN1hJMlVsS0hkbDdUMDl3WHlI?=
 =?utf-8?B?Q0VhVHNKalVxQlNraVBuS2ltMGtXbWRIVkdPdG1kRzJmUXJxc29MN1dpYkFY?=
 =?utf-8?B?V05HNWplYVlueUtLU2RoNitIYWNnODlKR1c3UXZPUkYwVjBQL21wN2pSZ3U0?=
 =?utf-8?B?Q1RxWUZKVDFnbmNlSWR3M0Q1eTcvR055cHQ4dk9LTUZZcmVMTE4ydU83VXdv?=
 =?utf-8?B?V2U5ZGpSMFJOZk95Wkd1cnI3TzVUek9NNVdBNEdUVW1kemZpbXIrc052MnFl?=
 =?utf-8?B?RWFvVmR3L0JUcklvYllDcTd6cjJlODR1MGlzMFlPNWJZM21NREpBT2F6UnhV?=
 =?utf-8?Q?a0fAxw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MW9LejhUSjE5MkhuMWhsT2FWMmJ1WjVzcUtRTUZaaDlqeGdTUktGWk16Q2Rw?=
 =?utf-8?B?WkVQQzlZMWtXMkJUZFN4U1UvaTV6MmF2QXBrUklxVm9jR0FGakh6NXhFSnpT?=
 =?utf-8?B?b3RzUUtlQnpwcVNkTllaMkc1aEt4cmM5ek9VTEM1eVd3cmU2V2xNQ1NIaGt3?=
 =?utf-8?B?VHRJTzdMVzVnQWZSVGxaZUJGV2xSb0tYeEhEbElWTXJmWllNU0xWMDh1eTYx?=
 =?utf-8?B?RFl4endrRTZPZ1VqSGoxeFhjdU5vOERQTS9kQ3FTQ3YzZXk1T21oV0ZRRkxQ?=
 =?utf-8?B?K1FrNXE0bGQrbVIzVURHZlVlY2JxcGo0ajNxNDFMb3ozSDNza3dzT1FFY040?=
 =?utf-8?B?blNIaEd2SnN6bWVqRWNWUjhIY055K0pxWktvdG5VanRnVVI4NzZDR3FJRUhj?=
 =?utf-8?B?NXg0YU5rTmx6OVlJbE9wa3BTWVRHTXF3ancxYVp0NEF1NGhnZ3ZyVWh1cy9n?=
 =?utf-8?B?WUVqK3A2aHR6UDIwVHhaL3dVcVBsSitqMk5IV1RYZllYZXJiRUowR3BidGUy?=
 =?utf-8?B?TjN1RlA0MVBPcXZIZWVaMm9tKzhVSmRGMFVaaENUUE40KzVaMVdvMFBqVGps?=
 =?utf-8?B?eldkQjdGbVJtUmduVmpmbTEydU00TFZZUjQ0MkZUS0w5bjltWDlkVnNiV1Ey?=
 =?utf-8?B?MmQxUFdQbkt1VFYrMGpqdjBPSUxvVXgxTUdGMGNycC9CNkZMMnluZkxhcDNt?=
 =?utf-8?B?bWIxaXVWVFVjME5GZ2Z1U2o0bDcwaTNYamduZVh6VGg3cmxXcTYwNWFFYXhY?=
 =?utf-8?B?bzE2em1jczlOTi9SM3hjenBWbVUxQXl4dUdaYmVTdi9tblVnMEVUQjVYYUxz?=
 =?utf-8?B?cWZwa0N4aFQ1TDR6cEFJNXNYNmlTU2NIZ0diOXp5RHBmMzg2VjZyaEZkUjRE?=
 =?utf-8?B?Y1huMHRSdGlPY1lTeFlYWEZxY2NUVVdyOTM4OVlrRHFkS0lzVUtZZW1adUt4?=
 =?utf-8?B?MFlSTVpZNndGWTJBSGN0QzVFUnNxYjRFZTM2ekJJRTg3Rmhud3pXUGRCTDZ5?=
 =?utf-8?B?MWQxRkF6M3A1ZFVJVXdXNTRRUUdPOENqVkhkUFdOdi9Ud2JmaVZTV3Z2Z3BF?=
 =?utf-8?B?d0dWTnBRWmhwSWxkdVNmOHVPMWRJY0JqSllJV2VWQ3hSK1kxTVBZbmc4Wk1F?=
 =?utf-8?B?SXZKLzlTZkFEcXBLcGFObEpsY0lLZ2x0ZWNIZ2tBOUNCTDRuaXVVRDNPMlky?=
 =?utf-8?B?RVQ0VmxpVDJiaWc4bDZoTHNhYkljRTRYb0NFallYK1BFWEFXK3JES1lBMzVN?=
 =?utf-8?B?V0FjN2E5alpnMVp6cVhPeDYrVG03ZFpPM1RlL1VZRTVYb1NEVVV4cWRJT3R4?=
 =?utf-8?B?aEd1QnVPL0ovdHZNdWNwOXZsY1pGQ2huaDJyd244Um1POXJqanR4dkVUNVE0?=
 =?utf-8?B?Qm4xbFYrdGcveDI1dHFHYjY1T0pPalc2T1BNUCtsU25NLzhVU04zTmw0QnFS?=
 =?utf-8?B?d1RZRjdIUGVxa3k1ZkF3aHp3UFV5bEFMdFFYTXo3elNXMzJHa0JNQVY5dSs2?=
 =?utf-8?B?WklTTDUzOCtPT1M3cTJrYUdnZU14R0lERHNiL2k1ZzZGbDV0WTV0MVVkdjls?=
 =?utf-8?B?N05BN2lkY0grL0Q5ZThMdkdjRnp4a1ZWbjVlU0k5Q2tVTUhMRit5WEk3MDdU?=
 =?utf-8?B?SnZlL2lDamtIYVh4WmVFWWl2SE9hSGtKYmdLKzduUlB0bUNDMStaYXJmT2dO?=
 =?utf-8?B?bmlNaFJFYnZJcnE2TmpYbjlRQmJNT3lldVV1ZVJpc2Zua3hid2Fic2toS3lw?=
 =?utf-8?B?QVZQSm5pTUJDSFRyTjZZbm8xKzlKK0cwc3lCYzFZTFcvRjZSSnRVOHNTd2RI?=
 =?utf-8?B?RU04T1hYa0twdHF2b2lBQkxtTjNvT1ZYdFQ0SnFlNFhsSlVhV3d4T2FMYXYv?=
 =?utf-8?B?OG82VXQxUE1WaENkUzFpK3B5SFlhNnNmckdSRzlUQ3NhMkFiWGoraExUTSs3?=
 =?utf-8?B?OGFaMS9kRXJNaHFGN245SDZCN1kyNVQ1Y1Q2cHNRZVVicDEveXpvZnh4RDRB?=
 =?utf-8?B?KzkyTXQ0VkRWR05kSG54Y3JpODBxd2hPaFcwa3lGNTBxVm52cEcwczNqVTBJ?=
 =?utf-8?B?MEJaTGhvelJ3QjQvYk5MWjlmaFhmOFl5anlNazJ3QURhSjN2dHJkV1hsRzR0?=
 =?utf-8?B?Y1NUcDdPbHZaNDJ6NVJCQi94dGFRNWRLQmpweWhQVkRWU3FNUldOaGwrT2Vk?=
 =?utf-8?B?WTV1RzQ0UVUvMFZ5K1VqamovR3dYYjg5QjNKOHg5TVFJQjBXdHNjTFdyTnB5?=
 =?utf-8?Q?kV6VCZfveeD/sF9XlO/XPDWWFEH4idaYUmS4S5yjUU=3D?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-DKxvxKIhNtOzKpQDXsPx"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v+RWfeN/I+YQrJW8oSie9i/8mMS5x5m+8FnQHVmIS9iVRfCi0gW4X/BQsgljbVHKwPcoRoBHgmY+kAClMtPxRR8zOB7ga2LUKSV1exA1iFRXyF87IFv6S0tTFGL2Pn/c1QVWAAuH4hfad8rAsIA/AYWH0w15JRi07hTAy/F7LIvv1uzAoXPp3oFmlquATdSnpg5kosH4aFHujUwKwQXEO9D22lDXEw/tYEo7rMf1qukcPewqN2ORBls7x7NWZwcpB0ZswawoglFstCMaH5S6gZ6m18WGNn5LvUCb/r4SaMfZXU4b1idmQLMS+TRS9SCXqmTXHChpKLq+c/7IeWOizC5qzyxEkzlgumQixmK4q7S7kuAVCfyYQxEwocuc/9gi2zEw+uxG09b4OQSFfYa5oQhDADZ9nTbCwb+WWRvF/SrmshiSq3UkJZydbl0392rwS8poQmA77oVMcwgBcKoImuVJTYj/g30WNdCF9QqygZ552JlNKA5eGuShwwjf0D5yRiUuLe6kMX/sx14ly4+Pta6Qp+1Kxrlb3WPjZKTpDMHIVYR05SgXrNtisczLYbMl0WlsA0cP0ZY0p8Ykm5rAAcHbBVrpe4LCqekcRktyFe0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692d40ff-c6ff-4cd9-5012-08de121e494d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 10:24:02.1143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wCb1FGn3hHQhNL/4KkCsCgBwRKAvm+4VW5BOq0K5R+8XhoNEHjm77Ab8bnV2QhGz6OoCPn87tJaHH+NsekauZj0tlxWVwh+ynGov1B6/+aE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5961
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510230093
X-Proofpoint-GUID: zSJ7m5mdA58I_PuaciYAO_pcWg-7OtbI
X-Authority-Analysis: v=2.4 cv=bLgb4f+Z c=1 sm=1 tr=0 ts=68fa0247 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=nTEMqNQNurldeBwMQqsA:9
 a=QEXdDO2ut3YA:10 a=8o36YCaDCzsEN16yHLcA:9 a=FfaGCDsud1wA:10 cc=ntf
 awl=host:13624
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MSBTYWx0ZWRfX46D9uOX+LAmJ
 WGnEQo2lyMWQaCQlYD2m72X4VWfO4xt/Scf/up/41IiNNipCO/r6NQUILidnyPRg2UHNXJhvGE6
 1mDthX/TZJ8jBgpMbhzcQakBI6ZA1GAWStFDV4Io4ug0gDGytT5f+4V3FMi9KmgZAzEVzCU64Xp
 5GAfVZRJ20xAfaBJ6p4VxKnamjwyRR/faSzD9yioPsUTLVY8gTaqtNJ2BN32z3gHjXB99TJTYz6
 7+Vhm9d8FKxeXGl8f4OEWucap3Y4C8pDtnskBFqF4n+q5KpGfWnMkYz21d93BexUIo4rCXu5gK3
 ZCM+Yn+oQ9yGq+9wLyEX4oflNfW356Db51zg0k/nwiRazSUaTJO0YF78f5S4mXXj32r2wJ3go/o
 dJzbc4rKcbJ9EYj3BGsFSwAbVSKtVAKS1D6gzHAE1trXYKj3aiU=
X-Proofpoint-ORIG-GUID: zSJ7m5mdA58I_PuaciYAO_pcWg-7OtbI

--=-DKxvxKIhNtOzKpQDXsPx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23 2025 at 15:47:37 +0530, Sabrina Dubroca wrote:
> 2025-10-23, 14:37:36 +0530, Siddh Raman Pant wrote:
> > It makes less sense to remove define of ipv6 variable from ipv6 file
> > and put it in ipv4 file and declare it in ipv6 file, which was done
> > in 3d010c8031e3 ("udp: do not accept non-tunnel GSO skbs landing in
> > a tunnel").
>=20
> It would be good to CC all the authors and reviewers of the patch(es)
> you're mentioning.
>=20
> > So let's move it back to ipv6 file. It also makes the code similar -
> > the key is defined right above the respective enable function.
>=20
> I don't think that works with CONFIG_IPV6=3Dm. The ipv4 code will need
> to access the key via udp_encap_needed().
>=20
>=20
> > Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
> > ---
> > I'm not sure why ipv4 key is exported using EXPORT_IPV6_MOD?
>=20
> So that the ipv6 code can use it via
> udp_encap_needed()/udp_unexpected_gso() when it's built as a module.

Cool, thank you very much for the explanation! That was what I was
missing.

Please ignore this patch then.

Thanks,
Siddh

--=-DKxvxKIhNtOzKpQDXsPx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmj6Aj0ACgkQBwq/MEwk
8iq7sBAAjDutLeZqToDb3bhJ0XBB9FzhRtiGGRRKrEGf8iSwSUufzNoEBcpoKbjo
rlVx+5tlLSCNK/Rq5EaFfg4k6swKxLoMyp2bDl4tLjgjddWUeqiy/CCac2WGPuGa
f26HMcyIwkOoCUwajONwzAl1UK49AtazAPZi7iRlJJyaexsEzfKHMDVI65jKBvGm
RlmpYUlp5LE65vUKO5mpltGC2XG9eF8R4tpX/Klez3GqXhpCf3Xgu19IxN34pFHu
dhKVy/oA3g8zIOHBcRWDdy+VsfA0qvC6NznnvSC5+jHuWubLq02sue1nlF2b8lXL
qRUC5RnZEc1P17lOcIWVAyexzRAMKzEn4eg8gbfAy2CgqQa1v0AfUnwVooxJRbpf
+WyS2b8Lt1dfCjn/cfUozoS09DpRU20bqznq0bqIcC5+t3LDbOjkMlLYVi4//pXF
R2bVtXOnGblux2VrQUo70nMTKBagWCjq/VYYB+baCkLgeE+I6fGanOYd8M1rOMl7
0mvJ0NjmtiIPpSLpMnXrsmZU6tGgIjHs/IfJRQtpaeAvtjzVAm8oOCtw9VCnKkWD
mENKAFJYQ6798WHSaRqbG6ro9QxkBODQ9HUVqkd0I6MXkpDZ7xrMONVS8FlPcPi0
aqVs2ko3xAmMyQ23FMqz3CeFaQ/ymyRkc6s/0sQaL7+cgthtsSY=
=97Nt
-----END PGP SIGNATURE-----

--=-DKxvxKIhNtOzKpQDXsPx--

