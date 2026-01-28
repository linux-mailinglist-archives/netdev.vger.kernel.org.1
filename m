Return-Path: <netdev+bounces-254435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEvaElFxemlI6QEAu9opvQ
	(envelope-from <netdev+bounces-254435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:28:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDEAA87BE
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACCA8301626B
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 20:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019EF33123B;
	Wed, 28 Jan 2026 20:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="YFHEqlMH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF302EE617;
	Wed, 28 Jan 2026 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632078; cv=fail; b=TA3UGR5D/6BguMOnNGg+wJ2cdJAvZlRj5r2YKqx3eUzKMG9JOptPD/z80lhUIBLZ16oqYz26yo9QBpbvGoKbkjiNxGxST0r96trP42wc4ka37sXh1U9H+wH0wSPumS6q2FaKGrAu+YwYRQiEueWKYHACkkxR69tW7czloSWbsBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632078; c=relaxed/simple;
	bh=0fFEDUiZe45rBqqzuKJ+9dWGNl4gBXFb4XULP02ibAA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=Vc8VvHHPT5DG3CAx9mbJBNNEq2gZ6c6QajMfNIbNo/z1GwM+vcPUG3wwRC3upQNDZ29lkZy7rBesFSL3JVb52BCi7r+E9LgZFaoibzMy5k9EK0Dpy6XkFY32upSy7rBJiVWZOFGaR/xjP3HqCfj2OOdAnj50YaTLR/kCp1QmG7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=YFHEqlMH; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SJEsHg627148;
	Wed, 28 Jan 2026 12:27:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=xC2LcGjN5SPCVnUUaFdfjLzed4ggk93W0CPi5NTWvUk=; b=YFHEqlMHSwSZ
	yGBI/poDSzetw+DvBpIz1mrS9TbotkeDTqHQK0lYtcO+KckbRcjb9N/Y4Be+cX7S
	b+5LFTctneoyXLDUUdh08IDgIfJ8wayIPF0CZIb61qasehroMKX6fEHRvEgckgpL
	tfA9scvugHzMXNoMf3QQ5ZWzRkKxiW8Cz6QiWXuS98XhKar9QRUE6Dv5sYvbGrr4
	fYkMJO0OdNQYxA1dve9EmxpWReNR8jWo9Z3iLH7v56bMka/Y2+3qjRoQdD2JDr3V
	3NX2x4oCGonvm2cxjL/hmUxpXSTGWbMhoE+AMgCr4NiybpJtmiX/a0uvcFxyy3L5
	V0V8JysGng==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012010.outbound.protection.outlook.com [52.101.48.10])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4byrbk8wey-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 12:27:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdfocmXcPb1o6jgUZD4u+8rOeAD/vhrPnS2om5FtP9sTndLVhbF/U98B5YuxlgkKsFi1oYv8SrP1ru9ghSKOPjnSAyPVxX3NkLN2WkjxBY6esdC1b9hXY+86rLs8egSKl7C2kjjlibGWaRLsnzRerlidCZL77VKoPORPfvt27Rnx6Yc61Wi38Iwwp4X7wL/fUP5AX+W9e9sk6o5o1bXRoZ+VY3b/ws47vdqU76ZqBUx1stHXL2hP/Z12ksopcM+X7y7bRaeCTlx5WvsSgzSh9LdyQ2fjMtZf1ss3gFoidzcspodMlXtVfFM57GbD6Ho5YfDkU8i/M+B/PuLYb2mx0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APmFQIK9nKg6YkqynORsfjUUz4/far+OZ+jbFdfMp98=;
 b=H1PeKovdUVDggA4yI+AlTMU+5+GP0g35kUx3rrV4vlAhCGQ8IWsEyTBDOuMrOdiK1MlL5BVUpMwW1hHvhc+OmH9iNmKmPTF5ktmofzl9/DxIIZWg2HyCXfDUvGEUblNO6Xd6431VvEw79b2WDxoLLMpdmWpYdOxu9wLMQhxDyel6d1tDFlwXwvQNWC8LgEcDk9G4CEML2yBsgXFF+OCUVKQ7r21/g1yDO8I4+xyHosrtsXNGeHAmweLORhvDilSBW4p4Ks8iRedAyjSDDtStjDJ69SSFQFqzowtcptI5FXyOr1+HGQOMt31nogB1q7HXbVzb5MYbR6iFh8gAQOFlEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BLAPR15MB3889.namprd15.prod.outlook.com (2603:10b6:208:27a::11)
 by DS0PR15MB6205.namprd15.prod.outlook.com (2603:10b6:8:159::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 20:27:39 +0000
Received: from BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044]) by BLAPR15MB3889.namprd15.prod.outlook.com
 ([fe80::d5d7:f18c:a916:6044%5]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 20:27:39 +0000
Message-ID: <559206f7-6fa1-4326-ba85-ae8ca405f71c@meta.com>
Date: Wed, 28 Jan 2026 12:27:30 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] virtio_net: add page_pool support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>,
        netdev@vger.kernel.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20260106221924.123856-1-vishs@meta.com>
 <20260107032738-mutt-send-email-mst@kernel.org>
 <ecda097e-e3cc-47c4-aad3-61f6af950a71@meta.com>
 <20260128151944-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Vishwanath Seshagiri <vishs@meta.com>
In-Reply-To: <20260128151944-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::22) To BLAPR15MB3889.namprd15.prod.outlook.com
 (2603:10b6:208:27a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR15MB3889:EE_|DS0PR15MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c3ce32d-0ce4-43bf-d906-08de5eabae34
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YkRSb3FpWHBwbGxMRWt1RHQzUm96U05GWkx3OUEyT04xT0FkZ3k1TEw2a1Vv?=
 =?utf-8?B?L2Fhb1NzZTlKQ2tDN3JLNUN4MHVJbGQ3am5lOGZHL1JPQnlMcC9RRnlobGx4?=
 =?utf-8?B?NFNyWTMyMmZ5SzM1bzFOQjRKcHNQUDR5ODJnS3p0NlFWd3BHWVJVdzN0Z0RZ?=
 =?utf-8?B?UlI0a1NYQkgvYTV4ZGlrcEF6SlFJUm5zMzROQzNyUXNNeDBVT25aVU0xNWVq?=
 =?utf-8?B?Y1JsalhBNFI3VjlTUFdvaUJneStTMWF1bVRjcTYvTFVNaVJ2MXo4RkIvYzA0?=
 =?utf-8?B?MHZpQnE1RnFaQVFRVzNvTGhhNzNLNlVYUzlFQ3J1N0t2VHFWQm4ybkt3dnJJ?=
 =?utf-8?B?RzJISzdoUTJEOHRidlpkQ0pITkJIbm1JdkNZNHB5VElCNlVIRzJiMEZmd2h4?=
 =?utf-8?B?bFFLbDZTMlJwMS9MNUJURGhLeE05QWRkalZ4a0RhVFhHcTMzUWdZbi9UaXMv?=
 =?utf-8?B?aHdST2d0dWRxV1EyUjZ5WUxKYUJIK2VnNkExZWVqN1dKYTRQbXRTMGx6U0FC?=
 =?utf-8?B?WlhFSW1IbVRYVW9LTytoclhxNHNRcUV4VUo0d1FKc3IrbkFSWmQrVlV4eFQ1?=
 =?utf-8?B?dGk5Vjl5bnhGVzNzVVRzckhkcGdVakYzbWVTTUVPSlhUUENuYUl0MW13TS9D?=
 =?utf-8?B?ajExSEd0eDV3RUFTQ0Fmcjd0MHRGa3BDUU1YNVg0N3dvZlQrSkV2eUhIMUgx?=
 =?utf-8?B?L2k0NXBiR2xoN2pnaTRaaFRoRENQdithaDZWb2JkMlJjejF4TStSdTVaZHpo?=
 =?utf-8?B?ZFdPRC9FWDJUSjNRNVRiK08wbEhrSGpEMkhpVjh3ZjJZend1ZVNCajI5YWR3?=
 =?utf-8?B?L0RDeHlPbnhYakxxS0FXV3lJdGJKSEtzL1BidkVRTkh0K3ZUSGhhMnRJSm5D?=
 =?utf-8?B?b21PVmVJc0JYcEQvTTlnMjdLaUd4ZTRkTkYwemxGc1YvbDhlYjZJSTdjTE9K?=
 =?utf-8?B?L214ZjRCdVlZMHZjVjdETVQ0a1NhMzVhU0tESVJjR2I3cnF1TUtEV2Y0MkF3?=
 =?utf-8?B?V3hta3RLdHRUOFpQdlpHMEczMlR6M3pJQXZmYlQ3dkpoMm9lSXp0RGZHalpl?=
 =?utf-8?B?dis5d3JETDFyRGVnRS9YQWdXOUVaeTRKMmpMNm9FR2ZxdmpvL2NITFNtczFa?=
 =?utf-8?B?M3RZRDcxYTNDczM0UmZ5RWlRdkhuTC9SS2Z6cFNpRTNoWVhMdWZmeFdmdlVJ?=
 =?utf-8?B?Y0I5bGpGNmRicTdmZDBEZ0xGczRqSDh4MmZ2OVNWM29SemNZalhXakFORisr?=
 =?utf-8?B?Wk9FT2s5Q2ZQZmgrU2F0N2JFNmxtSCtJZW15Wk94YzVwMXJ6cU1pQ0F6R0NZ?=
 =?utf-8?B?blJUdjhrTzFZR2tRWk1laklJRE83eitIR2hYdnhmcHY4alh5M3RPbGRvSnpU?=
 =?utf-8?B?Yy9rNUVCQ09vSUVhWURCK3I2ZFptUGVpTTB3TEE1WHFjK21sZkkvZnBJOGhi?=
 =?utf-8?B?S1NyM2JFWENxTHFVZTh0M0Urckt1ZTkwNVJ1RjF4RzRQQUV6VVNuajRFSVpV?=
 =?utf-8?B?bHdYQTVaZFZ3dkhYbzVuTmxmakdCRWRkV1llcWFuOTZrdWU1Mk5hUW5NOHhq?=
 =?utf-8?B?b3FrcnFSNlFGellEWW9Yc3NZS2xJaG03dnI0bThIYy9yVk9IWnNJZmpNK05x?=
 =?utf-8?B?R3B0U3BFMkFnWXArVFNhUkRGOWNrY0QvdVJLclduZjM0aWQxSDNmN25sYWt0?=
 =?utf-8?B?VEhwZ1dJY2VJSzBZendWdzFYQVBRdXI3dWI0MjZoVzRLd0JrZ2hVbEE5cVRM?=
 =?utf-8?B?WUZFQmdZU284YUVheVQyc0hTR2I5SlhSVk9TY2NwVjRxaDQvL3pEUEY3SkZp?=
 =?utf-8?B?YkN5anU2bVpXaXVqUmZFenFPYlBwL1RYL0NINXRUNDlTN2RZQk9peTNqU2FO?=
 =?utf-8?B?UXYxbHZHbElSMFhWbE05UG1wa2xqTi9iRTVYYWhHRDhXK1JGNExpbWtoUnpx?=
 =?utf-8?B?ZVBmMjQzenVCbzV5elVtNS9ydm9DcElxcERPbHdjWVFCZllBY2U3T3FlY3dw?=
 =?utf-8?B?OTUxT2VvV3ZiRk5sVUxRZXcrRGsrN00rQXQzVlVVV1hkdmZ3MzgrN3lrOVg1?=
 =?utf-8?B?TzYrTjZsL2tZMms1NkxUZ1psUTI1ZUptSzh5N0lUYzdXRnVmRnpsMWZEOWRZ?=
 =?utf-8?Q?9PdI=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR15MB3889.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TjBicVBCbG9ua0UrdUtwejIxZVFLNXo0T21ucWVQNlZWbVF1OFZNYW5mdGZJ?=
 =?utf-8?B?OHFHbkF1Y2ZqRExpVlhLYXJQZWEwbTkyY29TUm10ZnF4N2FEQVNadHdCNUNi?=
 =?utf-8?B?UzV5Z0FESDBqZ1p1eTNkbVBnV3NzT01qczdWMjI3dGhkcytZMlZpejlkT2ZV?=
 =?utf-8?B?ZGpoYTJtQVNabk1YT2xmUVlVaVFSMmo3a2FrMThhVHVTMWp6dFlpN21KaFFy?=
 =?utf-8?B?UWlMNUhwT1VIRlRKOTVOVVEwTVpPR2VlTmgxeVovWi96NjQxS3FnS2hUalVX?=
 =?utf-8?B?SFN0RkdYQjhvQmx5WHdxbHltaWtGaHNwNm9ENFVtMEhac202ZkVEYjdzd2JN?=
 =?utf-8?B?cHpyb2dJUTQxTmxzL2RWT1ZzRVpxYzFZdUJVUnpYWENFQUNpZmVrUGt3Q3ZH?=
 =?utf-8?B?ZlJpNW5kR3UxbEJ6OFRBQjZCREtyTGFvMUVicDB4MjVKcTZhMERFR21ncnk2?=
 =?utf-8?B?YUhEdEZVY3lIekhSV2RPWFlGYWFQbGJOZ0s0SmhVamxsRjhaZVBOM2s5U2xz?=
 =?utf-8?B?UVFFRFgyNURGZHBWN011K3ZoR0ROWFhEeUR1YUoxUnNUMHRXNHFnU1Y5cENx?=
 =?utf-8?B?Mys3dGwvVkhIK2pKSTdnTzdJMTRsMExRYUpkRURGWHUwOTA2eUpFb1pJeURR?=
 =?utf-8?B?WEltTVhPUzZVRVFjOHh5bTc1UEdJbkVHTytTM3FMdVoyc2ZJdWU5TTVWTEls?=
 =?utf-8?B?bGtIN21GQ2UzQ0p6a0ptSU9LMXB6Qkg1dnJIZUxQTHdIK3FWYWk2V3RsM3VL?=
 =?utf-8?B?cWFxQ3AxdVl2ME1QZm5kR21ZOVd4WkZzeG9sUVhXOWR0aTA2RGJhYmc2S1Ru?=
 =?utf-8?B?ZWNwMWNQcTZLWHEzQnVXMzJHcXA2WnJyeWJvbUs4c2I1d3lNTFprYkE0WDND?=
 =?utf-8?B?b1cxNk90Q3o3MHN6TUY1NGpSSWpuMkdVMGxiYnh5TVF3UkNRM1JJZmZ2T1k2?=
 =?utf-8?B?UEJCRGtYa2RMTlhoQlNVYk1KbnFkQUxCWGEyV3RjRHlqcjhMWTNkb2NXOFFq?=
 =?utf-8?B?L1JrQ21qeGhnYzl6aXdqZktXbmhwOVhHL1JuM2dueVdDd0F2clBjcnQ5S2wv?=
 =?utf-8?B?c1V4L0dwY0VEeGdDMHVKVHRoOUtUQTgwRk80V0M3Z29zTjBOdC84VXF0dWlM?=
 =?utf-8?B?V21aK0NaUHg4ZnpLM2RqN1hQOGVVcjB4ZlNvaTZPNU9MTHdqOUZ1bnhUckE4?=
 =?utf-8?B?OFZLRC9KcXVGdnh2bWQrUFIxV3ZaTEVYOGF6R3hSdUZoWkhBeFUyNk9nUm0r?=
 =?utf-8?B?NXFtZ0VKUU9iM1hzZlhyUFR5dzRFY3dkcm5zTmZNL0xENE5TRHNIeU5VRVZG?=
 =?utf-8?B?TCtkQWduNFBuYm9nalExQmtGdUo5b0d6dStQQUJTWkl2bUx6UWo0TE95Qnpq?=
 =?utf-8?B?L0lweHQ0RTdIVU1UcHU5N2JZczJ2M0xtamtUWGsvbzFadmpzcmd0STdxcmhM?=
 =?utf-8?B?SkMzNThvOWR3RTlUNkJvRmFQamRTdFFQZUNiMncycGxZNDlaeUtFVGlONEhp?=
 =?utf-8?B?dGt5NzdBNWI4cE94bGxqVkEyTEUxN3FHZFJ6QklPLzNKMXczdjRWOEQ4OWUz?=
 =?utf-8?B?dVl5UW9xQmlzUTJ5OWp5a01mUnNSSmgvbDRWR3pZNmw0cVM0MGhEaXlLZEw1?=
 =?utf-8?B?NVRxZ05vK0xQUFlXL04rYUVTcDNwU3pXcndwWDRCbEtBQnAxWnFSV0ZmWk45?=
 =?utf-8?B?RGk2TnlLdC82Z2pRZUlQK3ZFMHI5R2FKYXBGZ2FMajFYalRqdDh2VGF3THQz?=
 =?utf-8?B?TmdXZ2NvazBpM0hud0Y0Q3F5SW5tRmhuYWlOSzNNcEZNSEN3bTYzVEFDWVcx?=
 =?utf-8?B?RmdsQkhucFlrM3F0VWNyQmIvY2hEaTRVL054T291R25yU3N2ZTVWNWJFQTJN?=
 =?utf-8?B?SHJFNGxKcSs2ZVVFL01jODl5WTRxR1loSHJIZ3RGWStNSGhoOExBbHRuWDAr?=
 =?utf-8?B?b3NxSnhGZ2NUenRFYkRxM2xGd2RWcFVmUERPczJXbElLcDRFSjZTbUlOT2Vo?=
 =?utf-8?B?L0hmRmRkYnM0M2x2WFZtVk5WYzNoRElEcFAwUkZBbHc0dVVVT3FFNmZTN1Vv?=
 =?utf-8?B?Qk91VzVHVFY5bllzeFhxZjJQRjdwbFlCME9PNWo1eTZCTHZ5UFVJQVJraGsz?=
 =?utf-8?B?ejNjRzQ0KzRIM3VZM09EdHhYb1NYWUVHRENGejlxTmJ6eGVva2c4TkFoSDJJ?=
 =?utf-8?B?Tk5MckJoVHBGWTFxazllR3ZtcmN1ekYraWI3UmRwYmtHM09sdmgydjdDejBi?=
 =?utf-8?B?ZGh2VjV2UUF1N3l6MElsemRndVVibVBjZFl6WUdXbzJ4bXRPaDIyd24zaytx?=
 =?utf-8?B?R0h4a2N1dWFMNDIvVjNNNzRXTGRKRE55OFV1RXZXTVp6ZmhJVnhXQzRML2wv?=
 =?utf-8?Q?XJrSYJcSt4MyaSZU=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3ce32d-0ce4-43bf-d906-08de5eabae34
X-MS-Exchange-CrossTenant-AuthSource: BLAPR15MB3889.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 20:27:39.0354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5cloACk0vHaX81LUIG5dtYsgGMXzWCK3KYKA2BACD23RiO3woeZRqDtDHQ4IIkJc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6205
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: o1u0MwxNbLVKHJQD1FjYh5ft9lcRGyZC
X-Proofpoint-GUID: o1u0MwxNbLVKHJQD1FjYh5ft9lcRGyZC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDE2OSBTYWx0ZWRfXyw4VxAk02rzV
 iPS2bJRL0Z2JtEK4zYWQBU6oTCg1knF6y57CjKq7X++vWQ0fIwYsTTpSTA6V3JkSarNm0zcJ4bt
 uTaSkZ1gQN/zeBbR/6zNB3UAIbD7tMx1Q+2cNAl0aXheJIDf1T3VXwtVetm6OPxBDWaCj/6IG9d
 az2IBSErRaAt5EsOjGt5Gnq1MuGy8wsRjCwSPnS/X2u42iVnECCcoIotQdXgR6sWhJPaf3FhcaW
 a4F6x7pyJaiBaxRF1a0UWbN+IOyLPBW9gwUGTfn6y4qSP5EID4ZjXFr8oqXf4Xv6u0zHfDtaqQV
 Q71YIOnDplGw7T+MLn6p7cDB2KNnCBsGl219m0bDtfoqJJ5Ic4c2xANNSOnrq12GA6lOQJ1d79r
 if2qDaVb9+hrog5sVE/VQKCtrkmNv4bNTBembMZhwJot1xwKvYiz0T/QcZi+IsGBsxDJjKU8Poc
 d6b229z0gwZGUQDOmbg==
X-Authority-Analysis: v=2.4 cv=Q7ffIo2a c=1 sm=1 tr=0 ts=697a713f cx=c_pps
 a=vtur6dA+JiXx+GD1nKNobw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iaFi8TtKhGdbX_SpOFsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-254435-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:mid,meta.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BEDEAA87BE
X-Rspamd-Action: no action



On 1/28/26 12:19 PM, Michael S. Tsirkin wrote:
> >=20
> On Wed, Jan 07, 2026 at 09:23:46PM -0800, Vishwanath Seshagiri wrote:
>> On 1/7/26 12:28 AM, Michael S. Tsirkin wrote:
>>> On Tue, Jan 06, 2026 at 02:19:22PM -0800, Vishwanath Seshagiri wrote:
>>>> Introduce page_pool support in virtio_net driver in order to recycle
>>>> pages in RX buffer allocation and avoid reallocating through the page
>>>> allocator. This applies to mergeable and small buffer modes.
>>>>
>>>> The patch has been tested using the included selftests and additional
>>>> edge case scripts covering device unbind/bind cycles, rapid interface
>>>> open/close, traffic during close, ethtool stress with feature toggling,
>>>> close with pending refill work, and data integrity verification.
>>>
>>>
>>> Yay! thanks for working on this!
>>> Could you share perf data please?
>>> After all, page pool is an optimization.
>>
>> Thanks! I'll add benchmark numbers in v2 of the patch.
>=20
> This never came, or did I miss it?

It is ready, I will send it today! Had some personal stuff come up in
the middle.

>=20
>> Beyond performance, page pool support is pre requisite for enabling
>> memory provider based zero copy implementations in virtio_net such as
>> devmem TCP and io-uring ZCRX. These features require the driver to use
>> page pools for buffer management. I'll update the cover letter to make
>> this motivation clearer.
>>
>>>
>>>
>>>> Vishwanath Seshagiri (2):
>>>>     virtio_net: add page pool support for buffer allocation
>>>>     selftests: virtio_net: add buffer circulation test
>>>>
>>>>    drivers/net/virtio_net.c                      | 246 +++++++++++++++=
---
>>>>    .../drivers/net/virtio_net/basic_features.sh  |  70 +++++
>>>>    2 files changed, 275 insertions(+), 41 deletions(-)
>>>>
>>>> --=20
>>>> 2.47.3
>>>
>=20


