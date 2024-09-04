Return-Path: <netdev+bounces-124907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFB996B5E7
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130DF282427
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1E5188A03;
	Wed,  4 Sep 2024 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="NuMjpgkx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEA2198E7F
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440590; cv=fail; b=T3Qz7uhijBstH+zDBoAmzvGvPitPKSDM8sj6UmQprGBnG8oxnGLBFVyhBMt1e/VjXujwJ8psVrcEvGRQv5RHan7ZvL+of2Y5x327/j+wzbpgzlGwt7LVCeL00GzrJ3XSXFNaCuRiozii7WrS25uukz7ZpUb+yG/sTkOJUruQdZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440590; c=relaxed/simple;
	bh=CLl/YCMZtGRRa73W8ygrMyAU0IGhzmeK+39BcRuwKKU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PJ1emijHzctupwPgHdX3gFuFT7+bUCDsVGd4rEEaVNAqNiBtB11/DQmyfLqT9hHtv4i/jF5Sf4Gp8DSwaFUQCq4ZbdLPs0OJYcN4On6L5tyR6nCN8U1vjHek6c2UvnlY3Q3hvKhtpINeX5tQeUFPnb06ggilr2DgaxpdEgbf/YQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=NuMjpgkx; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4847bvrK016609;
	Wed, 4 Sep 2024 02:02:58 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41e3bsc79e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 02:02:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3jYyY0aaySe4iV3FR2xfQJ5tiLSUv5ACzSGivOcihlPZHJzldWaws1Wl+0uvFshtbRY+/R40Eo8JBXCr8S1euTtyFvLChLIT5JIlrZczcVbQHJvdFTxq4VJ9gfjX7MZdcCPH2rVn3CzjG3393+jBBcxmSGcBMNRnCjZ3SsNHbFysmRovSRYjUhFSt1lyLG28BWWn5nvmxj8OqFznXw4AeNUTRAVgvE5cUujsHyFjQmGPX2IWpqlgCsl7hqu5y2ENt3vH2Lz6OkH3EGn3skRYcp4SUBU3TuP1wlJN3IeOzArN8eidDu2rTzVTSgnDQaDF+CFPqRGYgwCjDZyrghf1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLl/YCMZtGRRa73W8ygrMyAU0IGhzmeK+39BcRuwKKU=;
 b=f8gWKHkS7/oEn58MoDh6j6iu5byD87n/gbkj/I7dvpmnUtgYVLouL0GUDvTDoRkymrUyechipNlZwSgSWhcGu6CR8tzr59otBDlCCcPpemK2/YpHl2F9ctR+MsKVLi6qgakdN3L5NOlxgatfpF7y9v+T+R98nUgIhSJjMa/IG8/+Pz65Zxl8Akc60fNiHheyBrF3ZeMkWqJk+7bFSqJF5QhdjWJLHvq1y6YmpzOsaWidYi4Drunk8EOtbFs+SQ6M0rVAb7tORVqX2Ky5aYoX0fKEvT0m/8kVpvdWLH9Eyzhv7z56OhHnH4r5VIMOJf7+S79rW8y9dt8Dl6XHkTvXVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLl/YCMZtGRRa73W8ygrMyAU0IGhzmeK+39BcRuwKKU=;
 b=NuMjpgkxbE/uUcKe1AavwkknkfhQfTcyxMLi9OeNR73YGyBAhUKCFUpphNxwuUJN0Bg4BdqtAivxgRUWvrpq2Lsc7ZwNP7vG8kcZcAraUSLSmxFVzNSVNMhQxRbEhUQ5Ao7smbhUcm3B+5QpEkn/RxuXBoBqbVmD3THW8tSb5Qc=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by LV3PR18MB5616.namprd18.prod.outlook.com (2603:10b6:408:19b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 09:02:55 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%2]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 09:02:55 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Simon Horman <horms@kernel.org>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>, Jerin Jacob
	<jerinj@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Subbaraya
 Sundeep Bhatta <sbhatta@marvell.com>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers
	<ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt
	<justinstitt@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [EXTERNAL] [PATCH net-next 1/2] octeontx2-af: Pass string literal
 as format argument of alloc_workqueue()
Thread-Topic: [EXTERNAL] [PATCH net-next 1/2] octeontx2-af: Pass string
 literal as format argument of alloc_workqueue()
Thread-Index: AQHa/h4m4+tTJF9WJ0KkQjfXEGlN8LJHUX0g
Date: Wed, 4 Sep 2024 09:02:54 +0000
Message-ID:
 <CH0PR18MB433921C8665B267684B5C3FECD9C2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240903-octeontx2-sparse-v1-0-f190309ecb0a@kernel.org>
 <20240903-octeontx2-sparse-v1-1-f190309ecb0a@kernel.org>
In-Reply-To: <20240903-octeontx2-sparse-v1-1-f190309ecb0a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|LV3PR18MB5616:EE_
x-ms-office365-filtering-correlation-id: 24d61090-e999-495b-8b49-08dcccc05d3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QUQ3V3oxbWpkSG94cm56VlFscmhKME5ENXAxanJhYVptdWRuYmUwWXpzaXVy?=
 =?utf-8?B?eENBL3VqbTU0R2hqanpLRWZQSlhOaWFxMXNTN3BTRURQc3poWHd1UjIyUTJl?=
 =?utf-8?B?UTMwa2NjYUk5am1RWjhnaTg3Q0w5cndldFJ3NEp2UjZpN2svMFpYSEpHbDZ3?=
 =?utf-8?B?RXFSS2t5YlU0ZEdoS0Z0REpQQUJnVVFTOTRWZ1FQNmNCTkY1cGpiUi83aUwv?=
 =?utf-8?B?VFlVMnBMV1pZWnAzTWdmMENRZ1BMNDhIV1RjV1o1UEJKa3FmMVdrcEJnV0w1?=
 =?utf-8?B?SWlQYzQ4ZmtjSkU0VUZmOVhNQmtQVlZmelFyWG1TdGdoZmNoUHBlTWlIUmpD?=
 =?utf-8?B?R0ZXM1REUTZManpsYUJRMTFZNlMrTzVta1J4RDZGM01OdVhkelRuR2xwMmdj?=
 =?utf-8?B?MFFKelVVNHhZbG9oK0xNcFQ5WmMrdzNRUEtEUkZsd1FpZGVDazJtbVVMQUM4?=
 =?utf-8?B?MkFUYjZnY0xqZThsWVVFNVQvaFJXczBHNkVvUzdpU1pNeFFnbk4yS1FJaVJU?=
 =?utf-8?B?K3YySTlKbStzSzNZc2pFd29FbmYrNTJRbUZMWDFJY3ErRTVjWVFIby8wdDd5?=
 =?utf-8?B?Tkd5czAwQm5JeVlQVWpINjYxMk5oSmFhb1lEbWZQeHlPbENBMkxJOG9DSkFo?=
 =?utf-8?B?ZjVtYlBPenNJQnhSSFFYdk83WnM3RjlTeGxWeFVpak5TVFFBV1Q0bEpTM1N1?=
 =?utf-8?B?OTAwdXd6K1JwaC9CWTR2MnZhN3ZPWmNTZEFmcGFFb3pGbGF5eUQyT3hwbmxR?=
 =?utf-8?B?emNEMnNHUmN2K0tQWG5hRkVOdWdPbzVEejBLZ2orbVNJZUZSelVpNjVsampo?=
 =?utf-8?B?ekU5RFpGRGNWRjJZKzJlcHdOUkNnNlRqMkJtNjJZei9IajlBMUEzYThXY2Nv?=
 =?utf-8?B?U01NS0tKUDlpREtJNkp5TXYyT0JRbzJvbU5Gdndua2pZaE4vUE1UWEs3b0Nv?=
 =?utf-8?B?UEJiK3JNVW9tUHQzelFvd2pDL1BNM1hQd1IzTGlFUkd4WmR0MStpejlqUTZl?=
 =?utf-8?B?WnNnSkRFLzk2bjFQd2NzU1dOZHhERHZ0NldjZnlJZVQwTXhrc3J2a1hlZ0xa?=
 =?utf-8?B?TDZMdWpNOHRIYnlGT1BJNCsrcmNHdWRnVXNGVWRMa2JRTUxsc0QwTjZxYjRF?=
 =?utf-8?B?SUQ5amlJdmtEc0dhRmwyejZHY2E3aW1ZUXN4Y3N1dlExdU1NUWo0U0lJS2ww?=
 =?utf-8?B?SUVkT3BnNGZzY1pjUFFEZzNJK1NtUW9nYk5teGg1aG0yOUJiM1lWK1JKOTVW?=
 =?utf-8?B?dSttaWpwK3VmdDVMT3dJdWcwUkVNWWl1c1VzWmNjbXE0eFM2TzZyUUNGaHlK?=
 =?utf-8?B?eENQWlMvekxQRlV5eHN0bm56MFhsUmxqVzg2WWFyMzR4R3FiT29FSndrdmhu?=
 =?utf-8?B?SDhidHdvMlJZZE02ejRMM1creXA3RGY2UDlRbFNUanV0YS8velF6R1hqdlRQ?=
 =?utf-8?B?aFFmRmU2WUhFbVhPUXVsdGpzdklORmlkYUFvY3Y5Zm1WK0w2ZFdVeFU2eWRF?=
 =?utf-8?B?aVFoVWs5Y0NLSk5Xb3hOV3pGeHo1RENtM1djMWVUOGZBM3ZqdkM3TWVjVVNW?=
 =?utf-8?B?R3owR01GVjJKSWkwNytwN2U0SVJmc2lDSjUyTHF4RWF0WXpUakRORDJSek0w?=
 =?utf-8?B?WmVPSm1NNEw3UkUzUWI1OGowT21FTUxzV3F3d01hbXRFR1AvSGExK1NQeFhV?=
 =?utf-8?B?Rk1LaVlPN2RSYnhtb2NKaTd4VzhDRis5bzVrNGJKR01UWnd6dGNIeUE0aGUz?=
 =?utf-8?B?VWlzMkZOaEMxeEEzT2JUNGNIWUFYUDFKZmhNQjEzK0s5R3NPWnBiZFo5Yy9M?=
 =?utf-8?B?RkQ1S2hGWVZ0L0hwVlZRT0NWc3dkTGJkN2UyNWdSUFo2MEo2djNSZUMwclpD?=
 =?utf-8?B?RVNCVmFiRWdRSVBhNGdFVDhxa2RrOEVRT3dXdzdqeVJIZ1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WU9FaWVmL1FVZ0xxdmJZdzB5WTdlTXAvWWxxOU1zbWp1NXc5Y1NYajRJNE1h?=
 =?utf-8?B?Q2x0Yi9JQ0NMZURYTjUzUDJwMnYyd1BFWUIycUNUY1FicU5VblV5QlprUmJV?=
 =?utf-8?B?M3JhcWExVE5kaXhPR29PMkZlMlJaQ0ZGUk5LWXJYMHl6R3hoSWs4UEh5MGlh?=
 =?utf-8?B?S1FvZUxrSE1SakcvYS9hRFlobEZQYmp1VTdtZXBVVk1ESUZmZnRlVzJyRGJ5?=
 =?utf-8?B?aUNneGpuZjBEd2kzUnZ5dVpSRjhnTDJSQ2w3UytGenNUWFZxSEFCL2VKUWFV?=
 =?utf-8?B?Mk1WeGtFMGtTWGcvQmJRODFkQW1YSENzRy9NWStpNjd2MU5lZUxOanhOT3F1?=
 =?utf-8?B?WFViNDRncHczMmMwd3h5YXpVKy83M05pRlBTVFQ2MmtKVU9DR24vd2VCcXBY?=
 =?utf-8?B?d2hzNGJNcHNobHVXSUtKeG9KU1RlWDhjdEFyOTlXZWlpdGhjaEVIYWYvNFA1?=
 =?utf-8?B?NHJsTzZKZkhwVTNzaVB3N05uRW9mcGZhZUtGdm1XSGpxblBMa2Izc1ptTTA1?=
 =?utf-8?B?bnVBQ0tOMm1CYzRqeTZqY3Y4cmdnb0w1V1N1UUd2Sk5Tdk1mTm1RU2gyaFdr?=
 =?utf-8?B?WlEvVjNleUNMMXUyZnBKN20xTzJEMFllTzdWS1R5K2d4anpuc2ZSR2VLbVRC?=
 =?utf-8?B?NVpOb2ZGVkpNT2ZsY2dsZE9OWjlITURNU3NuUzZCTGh0cmYwbjR3SG84YzNO?=
 =?utf-8?B?YnFpR0hucWM4djFXT0YyOGt6MWpMMGJvUmRyNE04RGtRYWlTM3Y1bzQ0SGN3?=
 =?utf-8?B?bUNLck9hMWhaMmpEN2ZrYzBvOVFpb1BpRm1LRXRHek5iUFllbkZTVStmUEdK?=
 =?utf-8?B?L1djVzJwMnlYWUc2L01lNlR2ZUNRNzFVTG1GVW40U282QnF6d09STEZiSlFy?=
 =?utf-8?B?NFltNVBWbnd1N3RqaEF3Y0Z6WmpLZmJrWXFUMHE3Z1l3UEV5bk01T2FVcXky?=
 =?utf-8?B?d2JEd3Z2cVlZd1RPUW4zMWRvSjNuRU1aUDBqQUxzUVZzOWEzbml3N0dvZU5y?=
 =?utf-8?B?TGN3Ymhaa1BTT1F1SjI5dkQ4djhIL3hCYzk3WUFJSk1NMXRzaFJMVUFIK3lK?=
 =?utf-8?B?VG0ySEpMVW9IcFFzSUdNQ2ZCdTZLN1FRc2RDWTRJZ3VuSzVDVklTeWI1L0ZO?=
 =?utf-8?B?ZVptNGcrb2dhZmZIMm8rcWcvT0ZDWGNRVlJRNUVqdGU1Tm8vUlgzQVdiUFB4?=
 =?utf-8?B?c0FnaXlwSWxLZnVIUDVCS092bVVDcVg0VldWdUZTMmY3eTg3VU9nYzVtbWF5?=
 =?utf-8?B?elQ5NkRKUGdoV2RBZ3VWT1BUemh1RGZrY0hoZC9oa0tPeURRRlRMMGZYS1Iw?=
 =?utf-8?B?eTBDZjhXV3F5allBT2ZzblhjQjR2c1Jsd0pENGhwNnJENVVIKzc1OStSRTVl?=
 =?utf-8?B?VUVZYU0xR08wN1BwNnBZLzU4ZE52S0c0TkpDMUZWYS9FTmcvZzg3R1ZWdnhE?=
 =?utf-8?B?MGxrZFEzbE5EYUwzOEFBVU5WUWJJWmJOaGNKWlE2S01iUVcxQnVwQUdlT25z?=
 =?utf-8?B?UlVxcHMrWnBRSkZDTXM3OXZaOGNpWmovUkJwamlzcU1PdklJeG0vL2cySmNu?=
 =?utf-8?B?WHhGV2F3OXduZ21ET1dxSStkMkJpWTM4V1h6dnNsb2VBYW92dnlWd0ZQbmpm?=
 =?utf-8?B?UkNUUjF6OGVESTRqY3pEZVpRMzhUVGFhTnptdVByb3pOK0dPbVc0NXkwY3FT?=
 =?utf-8?B?ZUd2Q3drdGJqY29McStzdk1Tb0ZnVFFEYldsYVV0eW9aank4MldNT2xmT2kx?=
 =?utf-8?B?TEIzSlJ6NjRsR3ZiVHU0SEl3MDNhbGUyeDhNT0RXYVJCSlo4RnBZb3Q3UElp?=
 =?utf-8?B?VzVsejJoRkt6RmMyZU9vdkNVdURVVy9YYXZ3cGp3U2ZmUXhISGNxendCYWQx?=
 =?utf-8?B?M2o5RWRzUVdIQWQ0SHJsT1lZMUExLy9vc1pGMldXWHhwb3BtZWhMSnVLWTg0?=
 =?utf-8?B?NFB4SmhvRDVRVEZSNHZNZTZWL0NYUGg3SHIzS3FYZEZvV0QwaGs5WnBqQzh5?=
 =?utf-8?B?aTRIUU5iczk4U2NMeUdxTVVDUStZSC85N21XV3JiQ09qa3hUQVpOdEJyaEN2?=
 =?utf-8?B?TVZSaS9VVzdBMG5ZcmtyMUNsQ2JJc3dzOTZoY3VuS2pxZjZTcUxsOWdRMlZi?=
 =?utf-8?B?VTBiaGhZNDhLb2RCczNXNll2Y20yL0NiUXl3TitzR2pVRGtTZ01ybEY2V2pE?=
 =?utf-8?Q?q80HpYTEGfcZQ82Gs6Ng2g9W83bsOJUphZHYjE0/HG9O?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d61090-e999-495b-8b49-08dcccc05d3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 09:02:54.9342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KFM2up5l3rwVnBWjOttGzPnLS91328zhfc06fUm3uA9csStB0WJreGfyANysEtrLLxzJMUXgqEcJBTfLE2GNhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5616
X-Proofpoint-GUID: H-M3mM9Bq96X9AcjFRGCZDwd2T6Vbqfk
X-Proofpoint-ORIG-GUID: H-M3mM9Bq96X9AcjFRGCZDwd2T6Vbqfk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_07,2024-09-04_01,2024-09-02_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFNpbW9uIEhvcm1hbiA8aG9y
bXNAa2VybmVsLm9yZz4NCj5TZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMywgMjAyNCA5OjU3IFBN
DQo+VG86IFN1bmlsIEtvdnZ1cmkgR291dGhhbSA8c2dvdXRoYW1AbWFydmVsbC5jb20+OyBMaW51
IENoZXJpYW4NCj48bGNoZXJpYW5AbWFydmVsbC5jb20+OyBHZWV0aGFzb3dqYW55YSBBa3VsYSA8
Z2FrdWxhQG1hcnZlbGwuY29tPjsNCj5KZXJpbiBKYWNvYiA8amVyaW5qQG1hcnZlbGwuY29tPjsg
SGFyaXByYXNhZCBLZWxhbSA8aGtlbGFtQG1hcnZlbGwuY29tPjsNCj5TdWJiYXJheWEgU3VuZGVl
cCBCaGF0dGEgPHNiaGF0dGFAbWFydmVsbC5jb20+DQo+Q2M6IERhdmlkIFMuIE1pbGxlciA8ZGF2
ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldA0KPjxlZHVtYXpldEBnb29nbGUuY29tPjsg
SmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pDQo+PHBhYmVuaUBy
ZWRoYXQuY29tPjsgTmF0aGFuIENoYW5jZWxsb3IgPG5hdGhhbkBrZXJuZWwub3JnPjsgTmljaw0K
PkRlc2F1bG5pZXJzIDxuZGVzYXVsbmllcnNAZ29vZ2xlLmNvbT47IEJpbGwgV2VuZGxpbmcNCj48
bW9yYm9AZ29vZ2xlLmNvbT47IEp1c3RpbiBTdGl0dCA8anVzdGluc3RpdHRAZ29vZ2xlLmNvbT47
DQo+bmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGx2bUBsaXN0cy5saW51eC5kZXYNCj5TdWJqZWN0
OiBbRVhURVJOQUxdIFtQQVRDSCBuZXQtbmV4dCAxLzJdIG9jdGVvbnR4Mi1hZjogUGFzcyBzdHJp
bmcgbGl0ZXJhbCBhcw0KPmZvcm1hdCBhcmd1bWVudCBvZiBhbGxvY193b3JrcXVldWUoKQ0KPlJl
Y2VudGx5IEkgbm90aWNlZCB0aGF0IGJvdGggZ2NjLTE0IGFuZCBjbGFuZy0xOCByZXBvcnQgdGhh
dCBwYXNzaW5nIGEgbm9uLQ0KPnN0cmluZyBsaXRlcmFsIGFzIHRoZSBmb3JtYXQgYXJndW1lbnQg
b2YgYWxsb2Nfd29ya3F1ZXVlKCkgaXMgcG90ZW50aWFsbHkNCj5pbnNlY3VyZS4NCj4NCj5FLmcu
IGNsYW5nLTE4IHNheXM6DQo+DQo+Li4uL3J2dS5jOjI0OTM6MzI6IHdhcm5pbmc6IGZvcm1hdCBz
dHJpbmcgaXMgbm90IGEgc3RyaW5nIGxpdGVyYWwgKHBvdGVudGlhbGx5DQo+aW5zZWN1cmUpIFst
V2Zvcm1hdC1zZWN1cml0eV0NCj4gMjQ5MyB8ICAgICAgICAgbXctPm1ib3hfd3EgPSBhbGxvY193
b3JrcXVldWUobmFtZSwNCj4gICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXn5+fg0KPi4uLi9ydnUuYzoyNDkzOjMyOiBub3RlOiB0cmVhdCB0aGUgc3RyaW5nIGFz
IGFuIGFyZ3VtZW50IHRvIGF2b2lkIHRoaXMNCj4gMjQ5MyB8ICAgICAgICAgbXctPm1ib3hfd3Eg
PSBhbGxvY193b3JrcXVldWUobmFtZSwNCj4gICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXg0KPiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAiJXMiLA0KPg0KPkl0IGlzIGFsd2F5cyB0aGUgY2FzZSB3aGVyZSB0aGUgY29udGVu
dHMgb2YgbmFtZSBpcyBzYWZlIHRvIHBhc3MgYXMgdGhlIGZvcm1hdA0KPmFyZ3VtZW50LiBUaGF0
IGlzLCBpbiBteSB1bmRlcnN0YW5kaW5nLCBpdCBuZXZlciBjb250YWlucyBhbnkgZm9ybWF0IGVz
Y2FwZQ0KPnNlcXVlbmNlcy4NCj4NCj5CdXQsIGl0IHNlZW1zIGJldHRlciB0byBiZSBzYWZlIHRo
YW4gc29ycnkuIEFuZCwgYXMgYSBib251cywgY29tcGlsZXIgb3V0cHV0DQo+YmVjb21lcyBsZXNz
IHZlcmJvc2UgYnkgYWRkcmVzc2luZyB0aGlzIGlzc3VlIGFzIHN1Z2dlc3RlZCBieSBjbGFuZy0x
OC4NCj4NCj5Db21waWxlIHRlc3RlZCBvbmx5Lg0KPg0KPlNpZ25lZC1vZmYtYnk6IFNpbW9uIEhv
cm1hbiA8aG9ybXNAa2VybmVsLm9yZz4NCj4tLS0NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFy
dmVsbC9vY3Rlb250eDIvYWYvcnZ1LmMgfCA0ICsrLS0NCj4gMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvYWYvcnZ1LmMNCj5iL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L21hcnZlbGwvb2N0ZW9udHgyL2FmL3J2dS5jDQo+aW5kZXggYWM3ZWUzZjM1OThjLi4xYTk3
ZmI5MDMyZmEgMTAwNjQ0DQo+LS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rl
b250eDIvYWYvcnZ1LmMNCj4rKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVv
bnR4Mi9hZi9ydnUuYw0KPkBAIC0yNDc5LDkgKzI0NzksOSBAQCBzdGF0aWMgaW50IHJ2dV9tYm94
X2luaXQoc3RydWN0IHJ2dSAqcnZ1LCBzdHJ1Y3QNCj5tYm94X3dxX2luZm8gKm13LA0KPiAJCWdv
dG8gZnJlZV9yZWdpb25zOw0KPiAJfQ0KPg0KPi0JbXctPm1ib3hfd3EgPSBhbGxvY193b3JrcXVl
dWUobmFtZSwNCj4rCW13LT5tYm94X3dxID0gYWxsb2Nfd29ya3F1ZXVlKCIlcyIsDQo+IAkJCQkg
ICAgICBXUV9VTkJPVU5EIHwgV1FfSElHSFBSSSB8DQo+V1FfTUVNX1JFQ0xBSU0sDQo+LQkJCQkg
ICAgICBudW0pOw0KPisJCQkJICAgICAgbnVtLCBuYW1lKTsNCj4gCWlmICghbXctPm1ib3hfd3Ep
IHsNCj4gCQllcnIgPSAtRU5PTUVNOw0KPiAJCWdvdG8gdW5tYXBfcmVnaW9uczsNCj4NCj4tLQ0K
PjIuNDUuMg0KDQpUZXN0ZWQtYnk6IEdlZXRoYSBzb3dqYW55YSA8Z2FrdWxhQG1hcnZlbGwuY29t
Pg0KDQo=

