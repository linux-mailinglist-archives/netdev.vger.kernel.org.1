Return-Path: <netdev+bounces-217061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CC4B3736B
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 21:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C12F1B27ADA
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 19:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D532F6579;
	Tue, 26 Aug 2025 19:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nIyau49K";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c/PbUEOG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C9C2F6186;
	Tue, 26 Aug 2025 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756238032; cv=fail; b=fdZDeeB8rHmIS5N9DOuyyE3/NS+jTohFMBTcUHBRxsuGGiHY4CpEyRsRsAdMPCbXGdj+X6j8i5nb0394kdQTqpUqZMDA9eYn35sEsORLVo0vbgWeXpWOrWRFJ5XvjH9Yln87fxzGQkl5aRr4jOGmGjmnTitA4cDaUjR3PyvsADU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756238032; c=relaxed/simple;
	bh=67beI+oLLw8+msxKyV6D9ZehArH20UoJFNUmOIdZ+6k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rsNNq0dRU3OdwAzhJuSx1eDBPS0nx3EH7ETN4lnnIsbeRHCAFn8Zrf/eBmt7/XM6JfLhVD2AkvpihTMsn8hHj9FTRjHIOlDX/SBmJYpHMkIk6ySHBkOwapqnouqXVZI20nRbrhs1JhPNJ5/oFmfRxCtWVgJHrTSy21dBs6gDWkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nIyau49K; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c/PbUEOG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QItx86013538;
	Tue, 26 Aug 2025 19:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Nyv3eRQuaWMFRRPhNIVJIqZzqkW+1uT6/1qXSGl6NhU=; b=
	nIyau49KTv7YIiYLHStp/DRmgdz9WtWQ06TKsMiVoQCmkcltEtG1+yIzmz44l6tE
	xVygp6JV6jhsLkln+K6BSkdqHF13+Hb4pFDkpZlsqWKsVvd6UNBkrTy6ibTVQjEy
	YLO9sBlq3/+Vmep7lA2jLKKX7ha+wivGh59kNLmATGSFXEVktJ5uLv4vwh6TYHlo
	uKHn9k4wNy2KS4jdb6AREpKMFRQQnj4BlmHJojzHTBCUqE4dToFIwipqA4qEYySD
	uyTr1bvC6HpQ9ETvu1ZPdCJU11U8tEdy5twR8EGc1p0qx9C+bUd+45NfVsmmatHj
	aL1sPryVBSKAf/IDXjnTWA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q58s572m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 19:52:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57QIhHPw005065;
	Tue, 26 Aug 2025 19:52:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43a4mtv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 19:52:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJ3gbE2qjQPIu6iFMzpi+HPY2cSD5VBuQeL//RdGuL3KPdea9QQUyX3O29P6+gy+6pT6RFr5llxGXZZxVrTXIZsCtKMpwem2sErh+zo2LUVN2F6fCW5kH5VFYdQgY45nHJNA196i6jXIXk68Lqq2jpCB3sDV+ZE+ELy0XYzc1VVPArWy9Q5Ml7G7zmtIcVC83uN6YELKLcODCBM/vvrstkgG8urSIvaI2TvFAsoTmYMOlT7ubmujNm64mugMKShwyRVCKZcrp1WrhwjeXgxmcXXBgFaswxUFM8qd4sfej5TX8sFELK8Mxy+WeTWh8PNTgQX0Jaa3Xczwbesydo4lng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nyv3eRQuaWMFRRPhNIVJIqZzqkW+1uT6/1qXSGl6NhU=;
 b=CzRaXMVdUyUsNYFnPeraHC9UBOHOpduxx5ot+y9+AywK9GwTrAsNHzayjLVgMlHX+o9XNP9DmH6upYIsDwvZjARMR7HBoihGGSneBSp4DdyBgZx2SiYdUNCoeWooxdYphb0S7G73omJEYLKgKFaP0oxkn+ExXMdOKcnOrvQFtTXm6VOONbVXtRgT7XCccrteO+si1aoDtbJlLpBujKH8NYDnfOWqwJ+b+PUWtmYaZBkDwIZp9O86ELwRmdkKInc7zAkVmvpKZ/Aa+kazp0KDbHoEuxaTqvZ9w25I9rHpMowcKZjSTVAj1l0HhTV9ePd2zwaos5yKrFx+WnSyjPcFog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nyv3eRQuaWMFRRPhNIVJIqZzqkW+1uT6/1qXSGl6NhU=;
 b=c/PbUEOGzQhCkFXpSBHKwpWADj7WtyAA2A5nEQvodSAGYwKi7NPtpVyHUpkSSlJAJvUyvPrdyLDtOg+gpRiP/zm5GN9+WUeNY4M7qpC3hrOKex7HOQ3DqKAJAghX+CapYPimF4x7oSKzD/ZBqR97VMfz9BmUwI4nUvrA5iR2VgA=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH0PR10MB5819.namprd10.prod.outlook.com (2603:10b6:510:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Tue, 26 Aug
 2025 19:52:33 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.9052.017; Tue, 26 Aug 2025
 19:52:33 +0000
Message-ID: <0395d500-0b8e-4a2b-9dcd-d33df994f581@oracle.com>
Date: Wed, 27 Aug 2025 01:22:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v01 01/12] hinic3: HW initialization
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <helgaas@kernel.org>,
        luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
        Shen Chenyang <shenchenyang1@hisilicon.com>,
        Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
        Shi Jing <shijing34@huawei.com>,
        Meny Yossefi <meny.yossefi@huawei.com>,
        Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Suman Ghosh
 <sumang@marvell.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Joe Damato <jdamato@fastly.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1756195078.git.zhuyikai1@h-partners.com>
 <5f4589c1ab4f6736545a38096ce15b6569733c91.1756195078.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <5f4589c1ab4f6736545a38096ce15b6569733c91.1756195078.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0397.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::13) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH0PR10MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bafc1b6-88fc-4733-905c-08dde4da18f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDhQc1NzRkphclZMdy9oT3EzRmlMWE9aK1hWNjZJRjUxNGZ4c2s1enhqdzE0?=
 =?utf-8?B?R1FycXl0b3dyQ2o4dVFuUXcrK2JvWXJnSklBZUVxRStrcUVDbFRoajVNZUZM?=
 =?utf-8?B?eWVYL2lHZTNmaGlIQTZMdm5PaFpPUWdEbEV5UytoOFIzWmJtL3kraEpZeWhP?=
 =?utf-8?B?c295T3lqVlc3blh4SXgzdDU1U2M4MXlTY3VWMjFRd1FDblBRRlhNSmRCUmNN?=
 =?utf-8?B?VWRJelhjMllDS21IVE9hdlg0M1F0SEYvSEhYYi9zaHVJaHVabCtkVzV1bkFM?=
 =?utf-8?B?QjhYcFpSblFESkhJTzl5TmZXWEJCdEoxNVR6Tm03eVd6ejhZd1lsbWpNaW1S?=
 =?utf-8?B?MnZTc0dxLzhRT1VIK25NMFhFQ3BEOGNiOWFWd2pUWVA1RHE0aUIrbVo2bDdz?=
 =?utf-8?B?Umc1TkdLQ3J0TmJlWW5HL3RlbmFtbjJwR28vQXZHWkIrTjhXRVYvZzVYdVV6?=
 =?utf-8?B?cDhTeUNYMzZVZ3EvUFo5dmtGU1A5a014S0c0ZW85bU1pSDgza1F1WHFNeEZK?=
 =?utf-8?B?dnNsdzZSODdVKzhhSVIzTHpFY05reGV1SGUxcEtqSExxbWN0cW1SU0Nlc1FS?=
 =?utf-8?B?dUU1cUwwYWFSQmY0YVRJUFVZTlA3L0s1N2dmbGxha2pscTRuU3ZvWHJzSXYz?=
 =?utf-8?B?Q3lTbDZERTNrZFJQL2VUS0ZYVHJ2VFpKMUJYdGdkZkRGTzNzMTNORWd6V3NG?=
 =?utf-8?B?NjlDV3BwSVNicFRmeDUzamlZTndSYnNjRDJxaUtSUWxZbUFtYXhIS0prRzlh?=
 =?utf-8?B?dHZ3SFNxSFpNM1grRGFmQjU0dUxCR1d3bnVlUkdOZUpqNlg2Tml5enBhN3dF?=
 =?utf-8?B?Tmk1ZmJLdXIzSlc0bjZQVEg5eWh1VHo4VTZsZXpKbThuSVlNb1hGNlVFWWQ5?=
 =?utf-8?B?SDVTMXRVbnB5MXA4c3BoY3JxbURPY1pJYTliYmZXTldxZngyQldWRlNPbTN6?=
 =?utf-8?B?WGE5Rm96Nnh0NXppNC9iZjF1L0wvWlY5WVRlbXI5ZTlpcG5iOEpIZnpEMVVp?=
 =?utf-8?B?ZVVVSVVCWG5BU3NUVTJzMG9hcnhKM04zMEIzS3d0Qko4bGRxV0tBNlJDUWht?=
 =?utf-8?B?MWxJUU5YUjBseE8zT1JZRDlvbldZOHozTTQ5OHRsRTVDei9uNTF6NkVRTVN0?=
 =?utf-8?B?Ymp2dGdtN01pOUQ2YnJKa1YyclUwUzVUam43YU0rVjVkOWk1ZHpYMm1SOVJQ?=
 =?utf-8?B?MWJxQzU0enR3dlE5R1EyRFNFSXJVZXpja1M5UG9ldnZXNy84NDlCcGh4aTVw?=
 =?utf-8?B?blBVS2NPcWovSEY4Yi9OM2RKSkJQRzFTcDZoWlRRblF3WTFGSDVrbFZMSk80?=
 =?utf-8?B?SGV4N3YxREJVSjBqaU1zdW8yY0RyTlR0MjFFRlRnRGVRVHIzNlVyaXFOUWJz?=
 =?utf-8?B?d3FxZGtOSjFqdkJpZW1RWG5PRkRqT3FxN1Q4aWlBKzdrQlRlZkVya0k0aUJY?=
 =?utf-8?B?MS9NVE9halRXbEl4THZFRmJsT2JxNjh6cGt0cU9NZm1HQ0FUV3hkQ2phS2tR?=
 =?utf-8?B?dzU1Q2xuNHlVK0xZUkRMckR5Z3ZrR2x0L1hpcEJDaWU5ZlEvUjRWaFo3Sk5z?=
 =?utf-8?B?S2sxSDFqRFV1c1RNOEs2WDJiRFN3RkJ2dUNpdHA2K0pnaEdLdDBmM3lrd3VB?=
 =?utf-8?B?Syt1bDFZV1lCYk5sMGV3OExYZHhrRzFwYW1XQmZpRXM3MkJmRThJekd5WDE1?=
 =?utf-8?B?enU2SDY1TjN4ZURiNHhWRFpJRVloVmxTeThJNmpHcG4yZ1BnaXkzZHA0NytI?=
 =?utf-8?B?SjhrRzhkMG1kK1g3OGxma1BveHlWNnIwY3craHBWV1M3TzNjM2M1ejZVL0Jp?=
 =?utf-8?B?OWVrRlN1b2tOb2xQeWI5U0prbmE3c25NbC9GbURuMFM4ZEpkTEFEYkJXa3Bz?=
 =?utf-8?B?QzQzWXBnMXlOdHBKZldYSTdySmRlZkgxY2t5a0Y4SWdkV0QxS2o2VCt0aDJv?=
 =?utf-8?Q?CzoKTEIylRY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUlDZzhwcXNVMTVUTmEwQzZlWTZZOWdEMFc1SDNOVUNYbnQxUEhCT01jalg3?=
 =?utf-8?B?YmJEbkNLdGZZa01hUXgzVkpXbUtOOGdFVUVoWHpSVTJ4TnVDSEpBc09sUmMr?=
 =?utf-8?B?Rjlxb1FmcmhZMFpHV2ZsZlpjOXBrNmthd3oycURaMXhlMmFJanRUYUR6djRN?=
 =?utf-8?B?VXFGWVJqMXgrTDVMQVUwS3R4YWlWaFRhckJyRlg1ZHd2eE1POU9WQ2UzWGM2?=
 =?utf-8?B?Vy95M0txbjR2blNITkxHaWhDdGFtUTNGSG8xdlNwVDlqSmxVMFVEc1F1SElP?=
 =?utf-8?B?ek5rbnFsaW85N2NlclYxa0JmRHV4andDYjR3UllwckhtQkN6UWhmOEQvK1RK?=
 =?utf-8?B?RzUrNTJJdlc3bHNHQmR3Z1F2UHNCYW5CYk9CSmZOaHh3bW5JM3ZDM0puOHdo?=
 =?utf-8?B?bDlUTnlTbjgyelVrSjZLZTY3RDE3TzZSQ1FFbXd3Tm5NK1M1RXRBT1dPdzVL?=
 =?utf-8?B?b0Vzd0I5SlVnTlYyVFplNkFUWHNXaTBXa2ZmUmU1VEw2QjJ3OUdORXZzSWd5?=
 =?utf-8?B?b0Y1VVZWeUdnZjhPZ1lUQlB2amNHeGxoREVqcEhaSG81TmRuZ09sMUlwTkli?=
 =?utf-8?B?UjUwUENsNytyS04rZmF6OTc4eitaYXpXam5jcUdpazVYVTQvZFRYT0JUOTg0?=
 =?utf-8?B?ay9IKzhEcDVTQjhmOTFYcHA1VlltazNrTzNiOUxQWXBReW12ZzNkbjlHMkI0?=
 =?utf-8?B?b25HNVlQREJIQWJhdTZ0TlZvRTRmWG1jMHhvVjc0QVBmd2kwMFlTQUdYaEdU?=
 =?utf-8?B?akNNZ1owRDV3SGZ6OUtzQXMrUG1CRm15dGNPOGtReUlGZVVYWHhWeXBkQUZU?=
 =?utf-8?B?dXU4c2JTLzVON0pyTWJ1MW9obGJCU3J3eHBZU2kveElDUlBRWFhkVUI1SDVy?=
 =?utf-8?B?KzBldllQa0syYVpPTG9ZZWVIQjFwNUV0V2doVHJwRm1LcGxsWXVnOVV5VVlI?=
 =?utf-8?B?eTZyZXVTUVhFYm9aYzQzYytVd3JROWUvNE5PZjBXQTlmVkJUSFZNTXd2V3FT?=
 =?utf-8?B?dkNLR3N5OUZnL3pMRG9pNjdPRm8waXNIeDRkUk1TZVgxUkNBNENwc3g3YVF2?=
 =?utf-8?B?Z3hUd0JYd1JhVzNjQ2dVNEhuMkE3M09sQUs2TTN5bVFTNlJEbEt4eFRIUkQ1?=
 =?utf-8?B?RjJ2NjlVUkVmUVFSZFJkRDh3czVHb3M1ZWF2ekNUaU5pZ1ZENHBiKzdZK2tH?=
 =?utf-8?B?NFRYSlArSDQ5TTN2RWdJaUFRZ0xNQ245WFBraHBsK1UrY2hOWlE3dENIa2E1?=
 =?utf-8?B?UHZUd0xBYlVWNk5rT3BMbU1UQWk0ZmdiUVlOSDkrZHVCTWN0cFVPTDVDM0tW?=
 =?utf-8?B?QmJxRjBBeS9iQ1N1cTZNa2VBUEhkQTZPWjNMajI4ek9nSnZhaTA2MGorR3Zi?=
 =?utf-8?B?NDRXbU5ma2ZhQ29jczZjYnVUMFFsVk50L3FkRFNWOHNramdOZ3BhRGExeHEv?=
 =?utf-8?B?VUl0Y1JVangwellqRWM2QXNjVldZT3dhZlRqNEFKbWpQM1IzaEhHYXYvNU5H?=
 =?utf-8?B?dlJmV3dZNkNEbGNLS0xWUGJ5bWx3ajlyYlV5Y0oxcEhSa3BWVUVCR2wxN1Zu?=
 =?utf-8?B?ZmI0OHFxWXMrNXhYYWx2dWM0UTNQUW9xb0poejZzVnBKakVjbmd5RjcwRWNq?=
 =?utf-8?B?RzV3UFRWczdzSUdFRVlmWS9LaEZFRGZGWnFkQVFGOGZEWDRZcExEZ0RTbkFB?=
 =?utf-8?B?UHJDYmdnZTl0WGkvZFpocnRqbTgxU3hyV3pKbzhIdjU5YXVzYWNqS2lBZU5N?=
 =?utf-8?B?bVJVM24vNVhzdXFGd3E4MjRSRlRtcFN5elE0SldSamhOVGhVMk45MTlTT3Ju?=
 =?utf-8?B?N0d0OW5WRVNwU2JWMllVcGpxdlk0ekkwTVEvdnVsUThQSCtRQ1J4Y1hIQUxQ?=
 =?utf-8?B?ZlU3SW5GU3RWNkUyWWlWQnBObFd0VzlXODdUY1NrcFNPbW9UYm9aY2ZRUXlq?=
 =?utf-8?B?RGU2ZHhDM3NPR2RUbTA5RUdEVnNvNSs4c0l6NGJUa0MzVW9XRisrKzczU3Na?=
 =?utf-8?B?VGVLRWlGSDVvLytPOTZoVXUyMnhDemN2MFBlSDRpL2FxczYzQTRLWnczUDhG?=
 =?utf-8?B?Q3RPNkJWU29lYis0aWMxMzQra1VJditidjdSYndjZWZDcWt6eksxZ293VHRW?=
 =?utf-8?B?dFNxcUNSU0Z3b1lLdDE0WUFXeUVZTFFZdmswd0paOWYzNXlKRmZESFZJYk5u?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BuL7hZHnz8OVi1Oss2axVXw26K82RthRl2ZYw47GaNgbXPC/hw7srcy84C5nqgrUPDqAWQf6CZ4xJ/mo8pvDXgIHxL61HsSjqp7wyNcfs0Szi3E+lxFS4YCw4ifPevJbrkqCGrytHFlCUQHsggEOX5+rFkPo7zFppwgaGUTbXDihKuYHEZk0wrL5rRKm78Qmvspy5sYJ5ZAX/+XNXigc00JvMW7usIlUkiuMmHhcAXbDWpOwpAdbsFqtvDG6s9Hr/zF1z3JgXu4TshhXUaqv+IOiJoRlqU6AUbeKv7KWq46GbQNH9ygc0r+d5UJh2TnltVWFbi3SD+eey90SnJmWfXJdOrZMY0u1aqib+ugCBgFzReIAsAzyvZuxxzyQU3usGdbFlqgYx2vIKZIic8mPm6jzGLtQbcZ8wlWuxbTgzrjeeK5YZwNlx8nTEaM/lRb3Svt6dmw4gLN71/yoSGzmbWxJ8q8shiam+vUgYbszBgVwgc5cWzLOEE/aCFkII3CLxxwKZqByKDt4mXXuQSCPxMfRShxo+xZt5xjLDN58k9s2fTQf5EhA5QVpwhVxvGdIoIOieFW7CBEzl0z2YIJeoNkWfyovaZmUm4UgLBGwxME=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bafc1b6-88fc-4733-905c-08dde4da18f5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 19:52:33.1618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9sr3xURWfOF3O6xfNtNw4GwPJ5QUvl6pLEEMM5x0PSs5zXh8DkFZLoAiRA7E9r8ZRVF55kKC0VduMFUQzEDThDCfoNbpYdKy58Qk43j0090=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508260174
X-Authority-Analysis: v=2.4 cv=J6mq7BnS c=1 sm=1 tr=0 ts=68ae1086 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=3qPZYrsp_2_V5KTafvUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: pCJshGyggiLD87wwOrpYsgaa7AwZl6zv
X-Proofpoint-ORIG-GUID: pCJshGyggiLD87wwOrpYsgaa7AwZl6zv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyNyBTYWx0ZWRfXwUj1YGXMxyT+
 M7V4XKPLN1Xgf8qXWtkkjMNVI6cncUApc9wtb98oOnExOnAMAYxvD01JWDUXLgaL8NvIoYGAlS4
 fYvFA9c5IIhPcaRmiVCl3lVgwt1JZ4JyWE2DczSR+odDvfAhY+cuRvhMkE7tfC6/rSOuS4vZsQa
 oRfBtePvcPq57d30Hr5PHlRqzzx1y4nIxLZPzda7eypGGdDimZo1tzLf8kpuPDZvvdxi3KZWGwZ
 BdKQbIIjqAjCt+QIMPOUEuFPFYMHCvW3OMzkNm1x9hQp6iATKTOqVIbsFo/AbjHdD40sjR0klbL
 ouPZxOxdEU+KSKdrL2djLUam8b4CspfkvHEvI7IVGlE+WeoO3waXYVZYQHQ3GCu9j/4T4xhbCty
 fBLVTFNy


> +static int db_area_idx_init(struct hinic3_hwif *hwif, u64 db_base_phy,
> +			    u8 __iomem *db_base, u64 db_dwqe_len)
> +{
> +	struct hinic3_db_area *db_area = &hwif->db_area;
> +	u32 db_max_areas;
> +
> +	hwif->db_base_phy = db_base_phy;
> +	hwif->db_base = db_base;
> +	hwif->db_dwqe_len = db_dwqe_len;
> +
> +	db_max_areas = db_dwqe_len > HINIC3_DB_DWQE_SIZE ?
> +		       HINIC3_DB_MAX_AREAS : db_dwqe_len / HINIC3_DB_PAGE_SIZE;
> +	db_area->db_bitmap_array = bitmap_zalloc(db_max_areas, GFP_KERNEL);
> +	if (!db_area->db_bitmap_array)
> +		return -ENOMEM;
> +
> +	db_area->db_max_areas = db_max_areas;
> +	spin_lock_init(&db_area->idx_lock);
> +
> +	return 0;
> +}
> +
> +static void db_area_idx_free(struct hinic3_db_area *db_area)
> +{
> +	kfree(db_area->db_bitmap_array);

db_bitmap_array allocation was done via bitmap_zalloc().
is it ok to use kfree? or bitmap_free

> +}
> +
>   static int get_db_idx(struct hinic3_hwif *hwif, u32 *idx)
>   {
>   	struct hinic3_db_area *db_area = &hwif->db_area;
> @@ -125,6 +273,15 @@ void hinic3_set_msix_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
>   	hinic3_hwif_write_reg(hwif, addr, mask_bits);
>   }
>   
[clip]
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_pci_id_tbl.h b/drivers/net/ethernet/huawei/hinic3/hinic3_pci_id_tbl.h
> new file mode 100644
> index 000000000000..7d60bd45ad1b
> --- /dev/null
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_pci_id_tbl.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. */
> +
> +#ifndef _HINIC3_PCI_ID_TBL_H_
> +#define _HINIC3_PCI_ID_TBL_H_
> +
> +#define PCI_VENDOR_ID_HUAWEI    0x19e5

kernel already has PCI_VENDOR_ID_HUAWEI in <linux/pci_ids.h>

> +#define PCI_DEV_ID_HINIC3_VF    0x375F
> +
> +#endif
Thanks,
Alok

