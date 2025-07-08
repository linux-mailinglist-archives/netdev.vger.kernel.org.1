Return-Path: <netdev+bounces-204789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAFFAFC11E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 05:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16ACB1AA7C7D
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 03:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7C7211486;
	Tue,  8 Jul 2025 03:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DcDaFq7E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vEECTWPy"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433881E5215;
	Tue,  8 Jul 2025 03:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751943907; cv=fail; b=GrDKeLBh579P+qDv7woWcw6PXhVdlUnfSm94gQwkm/IWjjLyRW11gNZtqzzDFikPG7+1zAzG4gZ3O/0uVPkTU5UJTePcE0VIrwlETygdmkcXpDxttMp9/R2Mi9/q4ADZsghK9SHCAww/XS4HW2qxiXiCM2hRZFyyW/FQlPbPxRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751943907; c=relaxed/simple;
	bh=Pgi33Qhz9RgvYgVgiTlAo/1jfY/7c8/isyv3WKQXxnU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UriDFTkH8t762KB4UtD5KRRVnVbDz7EJQa/grSFScs1ARUUBbHbvCla7vLsWySoIM/Y4F3yxGddDiLm8pE0Ch/EWZLNBpeBv/6umN1fDl1BIsu/Uy0clu3Jo5A9yRPjeVAEmuBIxBS6jdFHmlNjdeF3DVPRllI2vQW1s85e/kGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DcDaFq7E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vEECTWPy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5681ZCYf027482;
	Tue, 8 Jul 2025 03:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rU2MSiu18z1zDHtpfzFrJC4V4NI377HTUmzL/NuE8gQ=; b=
	DcDaFq7EoCQi7R4eSfx+7ERqH5Fqn+NUhoTo97gDIss8yQcwQzvnsKKlyKUsuRfh
	PoCa/5OuDPfdDTaqpcTEvcauwrHATkIYrhjLTtwYFahBzWYBQWSsTs8Cye78r8BU
	J0E1Npn0/QbIsyU8VZv90vrpKbjjvqHZfYVHcf5yA3PLEKIORvuH/fA/Ezxby3gb
	m1cDJZ9vrk2EAYa/ZdMx84sPCfr4T80kcnVyImE9de/OVv9b2ub48o5zhFfnCKwI
	lIg9tTI1fE4rVpIVXyUwU4bfx0WG3pMrsvi06hXsV6wVa5PZna05aN1Az6AQYZeK
	QqhM6IvJZzNVNR0nrsgSYw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47rrgjr53q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 03:04:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5681nnUZ040631;
	Tue, 8 Jul 2025 03:04:52 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg99mvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 03:04:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMD8ul9yxozcRREKws7CaH8u89Kpr6+a1VJufI7/7CqXGQV5GlXVQz9xSJjeHgC49NwCgTWeyQ2VSAbG8Mw0LJ3hUe2nIKId6Acjv8ejBd9v4UZO/xPv2iXuPCEqsELj5AMwYkda0/XlF2VHafV22fAmnirkTELieTKbhPOtGpFGAwCORlz3sWyOO/LnA1EStF3VnITqjEPMp/SAD70A2lbbf6ezCNbbVD1v+HlpuvQvDGXBxLbxO8sPrKjZRnXirxNUPhvB6ZNgVcXsN8Aa62Q3PiZbN1jvKkhsjXs/JT9kKBkoOlnmOZsR420IAd5fDS4LbB9qJDR8wOs7VdfiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rU2MSiu18z1zDHtpfzFrJC4V4NI377HTUmzL/NuE8gQ=;
 b=CkpJH+NdYjodf0N7ppLPAn0OQz2WjxMqlvTKelbOqNVORt2PwRAy1dbTQf7V7djlguEXDtWdOAtBPla+6hQ18jTfVAX25MKzu9mIFuM+ulXLLxencA0YOYMb/vbMpjolTCuyj0MnVKCGasBE5ydFq/5betDxupEDp22rNW30BF2RP2AG/Jxm9+GIVz/mDlCNywOkUiOftcB05OxmewJttPQ9K8WHeX5gJ0HMJ1ECcM6cPceZCBylAd7OQeA7HV6Z3MuC8tojIq+tYG8WKmxDPh1mVIepJzPvy4AJpoN84RwnA3pzWdLGULlQQH1t2B7d2Wjg1hMQRRznPWnrW/DdeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rU2MSiu18z1zDHtpfzFrJC4V4NI377HTUmzL/NuE8gQ=;
 b=vEECTWPyKK2aNNl1Jt7urTsKramGT8jUwoCINoqtUtJ6talbMhU9yQviTCyS7lObOcRXhIyJsp+DKMygqApqU2+xQhQi8LbQUelVWxg2VoKB8+P/5rFvkMoeAf4nuIk7yygYsy4Lys4dcLL+7VF84kf7pnVmgWce6lnus4gIqHI=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Tue, 8 Jul
 2025 03:04:49 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 03:04:48 +0000
Message-ID: <96f8e9d7-6e4c-4f7a-bb66-a3b43e30182a@oracle.com>
Date: Tue, 8 Jul 2025 08:34:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH net] net: thunderx: Fix format-truncation
 warning in bgx_acpi_match_id()
To: Simon Horman <horms@kernel.org>
Cc: sgoutham@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        darren.kenny@oracle.com, linux-kernel@vger.kernel.org
References: <20250706195145.1369958-1-alok.a.tiwari@oracle.com>
 <20250707191644.GC452973@horms.kernel.org>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250707191644.GC452973@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::16) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SJ0PR10MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: 8492719e-df2f-476b-1f06-08ddbdcc32ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDhsbWxSNGZuMVhwaERONHZBNlFITllib1dES3E2ZzY4UGcvcUxBVzgzTGNk?=
 =?utf-8?B?QzZTMnAvb2kwL1lIQVVyZmRQallWRjRodTQrc3BuTUU3UjdXZjd3d2xRQUx5?=
 =?utf-8?B?cXRVOFBhdHdUbFd3RUxxR204bklNY0lySGhOQWFXNVhvbDhaS0R6WTdreito?=
 =?utf-8?B?NENjSGsvM0tvYUZ5dHRiQnRkRTJSWUc2TDEvRUhHbmpRc3NuNjNmZ2phaHJ6?=
 =?utf-8?B?aVJnTWZ4UkdEYjB2TzJkbjN2V1pHdThOcm94NDlDY2lQdENzVzV3R3hwMU9G?=
 =?utf-8?B?Z2hybHlLSmxha0xOTzdVWUVXWkFXOVFhOG9vcE9TbHZsbmtKK3FDcWwva0xk?=
 =?utf-8?B?cktmYnptOVF1K3NiUWozd0pjMFdMSlFFVXJiTkZ4bWhzcVBiL25UOTNNZFpQ?=
 =?utf-8?B?R2RPNXFLYm1BK2EyWlgzVWJZM3h1bEpEeUdTc0tJTmdtb2p5QVl4SUJadjdo?=
 =?utf-8?B?U0tubWt5LzhmTnA3UEd0VTZsTXI2WjhPU3pqaGpzNlRqM2QxVk83Yk9aQ1cv?=
 =?utf-8?B?cUlzd2swTUhzU1I3bHA3eUMvYzBTZnVsVVdTSWd6Q0ZrQjhDdWI3cmQwMng5?=
 =?utf-8?B?S0dCRVAzRmUwTVR4ZWZodlg1TWp4TmdzMUZWVTVYQzZVUXp0TFdrQjhNSTdz?=
 =?utf-8?B?MC9yYUYxRldhY0h5RnFDTnh0N0pvbTRoa0ErYUhydE1uZjdhcCt6MGhMQmt4?=
 =?utf-8?B?dFpocWN2Qk9MQUNuZENDT0lXcGlxMDRJTWVqbFIzdGV0bjBseWh5Rnh5YWs3?=
 =?utf-8?B?R0dxbk9NSzNwRGNNL3d5VHh0NFJiZDhDbmF5c3JVZk56MEpqUG0wN3lLTnJT?=
 =?utf-8?B?MElFQ3dHZ21LVEVGc3FoNWhOb0FvaUU1NURGL2tIWGRLYmtlRFlLdGE1eE1v?=
 =?utf-8?B?QW9GK2VJa2tIc1FYMWVrWDViWjN5aHlrN3FJVk1lZG9aeEJXTzJjMGI0RnV2?=
 =?utf-8?B?Qk1KOFJSekxoL213LzFMSGd3WHJKeU9ySEZKNlBEWEhvcUZUMlZYQVZCTnpo?=
 =?utf-8?B?WlVWalZwaUZWbU00RUtnTW5LRDl4VmFGL0NmSGJJVzV6dXpTeVVNbVJwT2xG?=
 =?utf-8?B?bVpCYmJzVmdNY3RiblJFYXJmSVBPQlFLbC9aRXRDNVRpeklEbno3b1FRQ1FH?=
 =?utf-8?B?eEdnY245R0VIVFJJeW9nekN3WDdlSHk4MHJ2RlhtbStDN29WcXRSRkJtSHBv?=
 =?utf-8?B?VlpORTNhNlo3ZVpRSXVOcjZFS3VuYjZ2cVRUVTM0NDdHazY1RWt0bEhtdEUy?=
 =?utf-8?B?YTRLeW9QZUtBSUJFZjZOOEcvUTMrdEJPVEJuanZ0TDFuc1NkN2c0U2hqQ2No?=
 =?utf-8?B?Zk42QjdpaDY1RmVIaEhJSHRGRjNWdTR6Z0oxNTlyd3dpaDV3TUlrVUxYUUU4?=
 =?utf-8?B?bldiNTFXRmxScXFyRWpkSGxWWkVES09lOVNZV0psQTQ5OXZ3a2RGWmVjUFdH?=
 =?utf-8?B?N3FIL01KQ1ZNTWlEVG91Z0F4Z0l2ZXp5SExmc2tvS1V5dFFjL29aUkFBOWJH?=
 =?utf-8?B?N2hLeUYyVEdlR2JFK085WHRBUGpWOUFyL2gweU9rTWZyaTQwZXVpS2dTZlRp?=
 =?utf-8?B?WmozbHRwaGQ0UzZLaUZhbDh4KzV5SXRxRE1BZ2NtT0M2S09kSlIwUE4wQlRC?=
 =?utf-8?B?czRabk8wblVNaFFVbUVsTklmV3ppODd6S05mZDkxRVE0TjQzSVNwWUpTbW13?=
 =?utf-8?B?UEFEeDhHZytIQ0R2TmpkM2VGS3R0MHBUSFQvT2JUVlVEbEdpdHlVOFpLZXNC?=
 =?utf-8?B?YmVWckEvcmUwQm5QRmMxTnVBdmUwUmJpNXEwRzNseldyN1ZzR2RmYnpzUVdx?=
 =?utf-8?B?WUx6L3djemF6MnpYU1k0VXJmNzhPdndJMGQ4L3dmVTlOQk45K203MVZVMTcr?=
 =?utf-8?B?eFhzS2I2TGJvYzlLeUtUSmJ0VFVGUG42VUY4RWpMVjJnZjJtVis0QUZKbUhN?=
 =?utf-8?Q?UJR5ynkAuvM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTlxTjc4UW1MWlVtQnlqeVV0WHVkcmlqdTlRWGZ1dCtUMHdteXFMcWpzcVd3?=
 =?utf-8?B?QUcxaXQ0dEpQb3RWbmJXTTJYN01KV0RLM09RdWlHaWo0b0oxNlJGVUNMcG94?=
 =?utf-8?B?cjBPNXRYREZHSDBFMG52S3kzRVhkUi8vYzMwdXFHcDY0MTltbjBsMFFlTjZj?=
 =?utf-8?B?TUZIaGQxMm1reGUrQ0Yyc2Yydy82Vm5pNEREbm9Zc0FWMklDT1NhbXdtRVpo?=
 =?utf-8?B?THo1RFU1a1o4NGlpL1Y4bzdWc2pMME9ZalppN25JMlcxdHJ6ZFZJNHdHZndZ?=
 =?utf-8?B?NW80Vit2OUZ6V3FWaTdzWDZ3ZlpGa0RFVjYwZW5KcTFVdldwLzd2NzArZXpn?=
 =?utf-8?B?QTU5QWlhTFNKZm1VQjYyckpDSkg4L0xNVzljOUZ4OXV3bXhyK2dNTnc3SitH?=
 =?utf-8?B?WlFNM2J2WHNKM1IvaVU0dElnSmhJWmRqek1nRzVGVXZPWHUzUXdCdFZkT0k5?=
 =?utf-8?B?a0c5M0NlUVpHZnVySlErNkxHNk8weGdxT3pUT3kyS1dtMUpSYmVDVkJuckVk?=
 =?utf-8?B?eTlnTU4yQjBMK25RWjR6K05lYUthWHlHWmVvTXFiTlNlUHZKQUJ6MWhWZHhV?=
 =?utf-8?B?aGMvTjU1Y1NwM0t0MTBNTXg2V2llUTVNeXpqK0NCYlZXclJSbWdKcDBsdHls?=
 =?utf-8?B?cXRIZVlFZHAzU3cvWThiWlVBUGtiQkNsME5tNi9TMU9rS3duN2Y1d2g5VUVG?=
 =?utf-8?B?MWJDNGRaVjdhZ1RKZGF2bkpyUW9TWWx6RWk4d0lMWmsxVnM0dzY0TmNQYm9s?=
 =?utf-8?B?cDNaODJsUHkwaTNsUkM3a1ZWOEpvOUtLME9EOENUNFJHZVh2VDNyd3pDVnQx?=
 =?utf-8?B?MU5IVGM5WTFDN1lpR3R0NVkzSjZxV2NxSXlEd1ppTElLemdqMVJla3NzWG93?=
 =?utf-8?B?eUw1QmIxUXh1WjNzWjY1VHVqeHdnQWFFdlFDREVPTldFYVc2ZG9ncVFQemt3?=
 =?utf-8?B?SktHNStBaG9BbTBvQnBpRFlRNGpNVzRiNFN5clFNWUFGNjUrOHROaGZrdnZm?=
 =?utf-8?B?TlkyVk95QktVRVhZa2RtUXFEK0NpZmhjYTdCVHIzQitIcjdtWG1GcW9FVnkw?=
 =?utf-8?B?TTlXSE9FRTdxU2hyR0RCTzBLRnJ1YnJxU2dNMVdaWkNlMlNwWjlEa1Y2emRY?=
 =?utf-8?B?YSswWjUrcU5WUlFURUcybzM0a3pWZEZDcDFIclA4MTlobE1iTWROKzRQNnBk?=
 =?utf-8?B?UnlxRGdOR0ZSMTkzM1czK0FtQUJobDZBMWhoTlhYUU9UY0huSW9QcXFpNUZO?=
 =?utf-8?B?cnJQUjJHWHNMOU1LaUxGaWhsTGpDcFFxclZHSkpTeTVHaHYzemxsYzVLYkp6?=
 =?utf-8?B?OWZYSlRsMkJabForNGF1SHFmUkluR01oY1lEV3IvbFE0VTJMeXVKMW1vYTRF?=
 =?utf-8?B?NlE4eWRwSTdOeXhkdFNSa3VpR1Y2WDJTYkpGT1E4WTNMVjEzQ3ZMYSttaG1w?=
 =?utf-8?B?NEx6bjFwOUNMTTBzYm5hY09qaUc0dlR1L2lrZjZab083NjlKVXBPcTBHUWhX?=
 =?utf-8?B?aEVIVE5XbHNjOFFWbDE3NldUVWhPWUJmS3A3WEtQcXRFemh5UFprOHhLR1VY?=
 =?utf-8?B?cmIvUldBRUJQbzhwam9YbmRTdm9rVkJhRG9ZSzBTK2ZJa1ZuSm80ZGRORFRC?=
 =?utf-8?B?Yk1Ba2xuclV4czNWdHJUMWJiZjFZV05HTVNhY1MwZ3lPWHVrcDg0akNnZHV4?=
 =?utf-8?B?WnVQdHBFa2ZNVkk1MlFRRnN0MHJxa0dLd25XbjJiVDRCRlhnQ0lTZDNKMEFP?=
 =?utf-8?B?NllGVTF1RUtlK1N3dU1nN0FSd2VITlNPUGpMTHh4ZlQwM05BTUlsTFo0TnZs?=
 =?utf-8?B?a1doeXZLdUNzdWoxeFVmZjdna3RacHFTM09DaFZNK0o5dmNpQzFHOUg4Y0xB?=
 =?utf-8?B?QmdyYjNENTVQZjJGeDgyUU5JbkI3WEFSSnNCV080Y0xQb0lOdW1OZ0ZmbWZE?=
 =?utf-8?B?aERZK1hDNUQ4ZFc4Undvbml2RUxuZ3ZqZVQ2cEZOQm5KNmthK1l3N3AyRVVl?=
 =?utf-8?B?S2prNGozWVpzWENiZm5mSXRFK1lPZUcwRVZpeUFWeE9ZVjdZSmlPVCtWek5t?=
 =?utf-8?B?MnpjYVpaeThZL3pTVTNOSHhrN2UwSWF5dHJkN1F3OFlXVnNML0tpWjczdkxj?=
 =?utf-8?B?UU5EaTUxbjlCVlQ0dmdiVjM5Q094Y0dDVDY4YWRIQXE3a3ExRG5xQ2JkTlVX?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U0yJR96jj5t9WXwFVFueaHGqZDcWUAEzQjn8OgwaETKGTHDQCxdYOQ01TyM5YtMg7wCpmOWJBmUL+VLB+mje45T/IgJA4CWBgswoY6LR1Np5PbpRKcsHVKnDrgtLWIeIKcpvydG5qU5T1FqUPRZeO2h1PpEzF8QTAMgYWRb4zqB1qQjaODoXrVgFD1jqeJIIt5ZMTJuXa+URlyiu9Pxccg6TfOluKNT8uPU9ZO3RcszMCXJgafLTXAIHdouc48Xlf+AB0WsTsXtD3wMta8SQwiFcai8kNyRGxpuG4G/VR2q6Ksv88yFNyUWqToz9ViGwbphHw5M4AuHEqvxZzl3M8jc6W6zfk7I1jAgyvRF8U4DTew1npBU86hT4cEe89wDfsrYA4m4JsFKzncBRbRnsjJZMhS6que6pcm9aLLhmu8JA7nUmJzaN6ircXs9NdkWKFuQJ20Ck15j5/iN3E2i1/uMHJaQbvwExePVeNNVbIeRSMYdaOjWvkXAEH91S5weUTy1vZzOQyfsakOwTzx+XPUE+2acitpShT1W4n1ONrH1/uqUMmNmXRv5bRgjSPy9c16J9EL5Ah2kh75Q+Ym4KfbdYw+rVyrXuvKbh1aKe7x8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8492719e-df2f-476b-1f06-08ddbdcc32ee
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 03:04:48.8675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcVOsM9mSBOgi4IHApcstOAmcqr9udzid+SLzaDqx5AyAfDXKT1WhPOw7hNOuJakUuDQjjiWSkvS4gq0mgCpE64uj/is1xbMW3m1nIMAOD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_01,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507080023
X-Proofpoint-GUID: O4fxwOXI_flpGjuC3ctFINg_xRPDlwo4
X-Proofpoint-ORIG-GUID: O4fxwOXI_flpGjuC3ctFINg_xRPDlwo4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDAyMyBTYWx0ZWRfX6OkI55smtqfF MCD1TbxIO6Nm9fgAQaZIdatVyKYW/p0KWzLnMwxjjzN7ntdxRZTq/VRcn9mK9tgxSFjs1ge1n7o 3D32lfU1JldhwQseL34F/IdpmPg2+8K7fjSP/O+k1F7opS8b3D8+SGVJFDEAYlN+TdG+lfOaOG8
 0W2vTlAUTieWj+VSmaWPFdw4eJNglRDEeBk4Lpgd8A+b5cXA0XoH6XQK/Gk+7R8RITxxy2kdkaF YzLWOhrpXG03E4Ze/WRR3KdgqyjOBfPW8fTSMdtLGyywnPlx58L8DTaMUg0fItAaDlsz1yBswVZ 2HM2gU0y37LIk8MU98vjcuNoZ4U95HDH1Z4P3f2XGRw1NJvk4lXdkYtUSho9AeDYE8I+AirTf74
 /+/rG19YyciiAncPmVX+KCVDOyH5vJFTShOaIlqJFIRUeAF1rIRXatYnHIDV05uU4+6yZn0n
X-Authority-Analysis: v=2.4 cv=XYGJzJ55 c=1 sm=1 tr=0 ts=686c8ad5 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=nDGyuGEt-dMBVDX8:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=KhaVWU6-6cxH9EYoM7IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10



On 7/8/2025 12:46 AM, Simon Horman wrote:
>>    drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1434:23: note:
>> directive argument in the range [0, 255]
>>      snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
>>                           ^~~~~~~
>>    drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1434:2: note:
>> ‘snprintf’ output between 5 and 7 bytes into a destination of size 5
>>      snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
>>
>> compiler warning due to insufficient snprintf buffer size.
>>
>> Signed-off-by: Alok Tiwari<alok.a.tiwari@oracle.com>
> Thanks Alok,
> 
> I agree this is a good change.
> 
> However, by my reading the range of values of bgx->bgx_id is 0 - 8
> because of the application of BGX_ID_MASK which restricts the
> value to 3 bits.
> 
> If so, I don't think this is a bug and it should be targeted at net-next.
> With a description of why it is not a bug.
> 
> Conversely, you think it is a bug, then I think an explanation as to why
> would be nice to add to the commit description.  And A fixes tag is needed.

Thanks Simon,
It is compile warning, We can target it for net-next.

I will resend it with [PATCH net-next]

Thanks,
Alok

