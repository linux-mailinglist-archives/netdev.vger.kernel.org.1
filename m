Return-Path: <netdev+bounces-124810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DA196B0A1
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 07:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E2D284FB4
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 05:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1629081AC1;
	Wed,  4 Sep 2024 05:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="JcgwtXoD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C4C7F9;
	Wed,  4 Sep 2024 05:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725428913; cv=fail; b=rqyPx9jlKyK1xs5EPMAnHbfQexlJrJB/HFsxf30WfcFY3OB81LWYPzddBZLz3u+0tZ/1xKsBjbxJ2LpRFWFiZPkLAgh8VpRZq8h02KFRnJvjG/gPGNCxS6RCqQCfJO+qxXxqhD0AghcFwg2DrMKv+aPGB+efXYAp7SPOQGJfCdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725428913; c=relaxed/simple;
	bh=p0PcdfULCRawjS3EpM/YCi6zbmf1/61ixbF31KQxUng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OqqnEC6muIlA5TN48O3uGj6VGIXQcuEzeeX4pJEXCRTN7nIOBuqsoDEZUNS1ZU3s1F9P1zZyT65Ejke/ekaxDzNteWorwXiVmKqfIZj0rn86JoVNC1E9eFrxRBg6KTLTJGhtRmisfv67sbBrcuCOXUpaQBQ11ytwWl1qwNJCjYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=JcgwtXoD; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4842tEba008557;
	Tue, 3 Sep 2024 22:48:13 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41ef6hreqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 22:48:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiOzb/b3BTM2dL7TpuqyMpiJ+5sIpkyUOtKxTEKA+tRN2f7/gUEl+1GUqpoe+42FfSKDgmuC9F803aGVe8zF3grXRrk3vd2vF5CvojkbQXpSMOOU1FteRpxcrbLLDdKsPK5JYpt/b6E3eXkbaw7CppYPpHm/u+cTO7Bsf4Gfq7lpkZ0MMUri+Ao73O2kxoghIakReHjgDJc7DtPGSywvLuuvsitz6HEpIDQxxxZe/JbgYBReQXDkgZVJjyrt/ZjjveR1BG7lKzmwNc4IQbJ+sFmh9HpaoVkiFvV1jCKsbMi8oq42YkHe70hIEbZg29EqDGFozPMzL3ITz/Tn4QoSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0PcdfULCRawjS3EpM/YCi6zbmf1/61ixbF31KQxUng=;
 b=uBWhea/63JLTLzF8b5ROxHAiqZLZqr0qkuk5XplBBrPZ4H02Z5+YXYLN1agImytAJeN+hYY9wtHLVK5C4AjPSitltL5swDWrW0FQhstYCHhOhnwXT44iWyzxa8t1uMRNB3p0THAp98h1HWzY39x5WxD4rYiRDY0haI0z5tqvVdQgxIoEss4sjpUyBZ8Nl9wSkSknTVHthAz1R4sbkxy9u9qlgJdElA3wV2BJHgRMQJd++gV70rmN4YSoEU/vS7fyFeV2dlLZnkch850SD1OEGg+lHWJaqh4E+xmYUCpGtU7l3B5fnEfpdbPzOE1qJqHZDrmwRWv4e3laA2gd11sJow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0PcdfULCRawjS3EpM/YCi6zbmf1/61ixbF31KQxUng=;
 b=JcgwtXoD9qhkK5WvrMVFuxplB9bu37qjiZu1Lk0eoSR9cTP40owm0frX9VBX413DG6yuVPSE81MOmgpE04Gwsh5UyZnVxwDcCNt+SjlaMVu3qqJudTB8LGb5fsCSd2Quewmo+Kt4f64OX0AK49MHpPPkNiciz56OgZnI5G4DD7E=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by BY3PR18MB4756.namprd18.prod.outlook.com (2603:10b6:a03:3cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 05:48:09 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%2]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 05:48:08 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "edumazet@google.com"
	<edumazet@google.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH 1/4] octeontx2-pf: Defines common
 API for HW resources configuration
Thread-Topic: [EXTERNAL] Re: [net-next PATCH 1/4] octeontx2-pf: Defines common
 API for HW resources configuration
Thread-Index: AQHa/f6L5NHCscQT10WHSCMIccIQZbJGJyqAgAD3vdA=
Date: Wed, 4 Sep 2024 05:48:08 +0000
Message-ID:
 <CH0PR18MB43396EE468C12EB47B9E4CC9CD9C2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240903124048.14235-1-gakula@marvell.com>
 <20240903124048.14235-2-gakula@marvell.com>
 <CALs4sv0s0=8Mg-5hQAeLEnTDfwKFy2esp9yFchX0kpPCEciNpA@mail.gmail.com>
In-Reply-To:
 <CALs4sv0s0=8Mg-5hQAeLEnTDfwKFy2esp9yFchX0kpPCEciNpA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|BY3PR18MB4756:EE_
x-ms-office365-filtering-correlation-id: da084d28-092a-4fc0-7f10-08dccca5279f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bGJWbFRCUXpSblI5aTdOMW5mbVNHZzhtN1pZSks3MkdpRWcySE9ZU1VWc3ZL?=
 =?utf-8?B?T3g5RUtqNE8zYmoxR1Vsa2prYWxlSXBkb2UxcXVtQ1dIcmhvcVljbDNvQ0ta?=
 =?utf-8?B?VGFpVmJVZnNaY21jRmZIcWdFTUZHbTBDa0VRWnJkNUJ0ZTFJQlE3SW9WUklu?=
 =?utf-8?B?RmhWL1g4ekJyS3YvcVY4dklzSC9HdFA2QUlncC9MMW96YzI4VWY2RmJZemhU?=
 =?utf-8?B?RVZUaGUreDRyVWZoMzhsV09zMTNRTDZWQlBDZDJtazg5L0tVb1A3aitBZU4r?=
 =?utf-8?B?bUd0MEk3SWZ4RDliM0NpSVpYNDFjbys2RkU5N2Vkcit0WXpQU1hFb1g5YTJL?=
 =?utf-8?B?TWRuT3lKUWlXamFFdXhkNGxCR1JqVGhxWUlKeEU2L0E5VHNaSGlSSURDYVhS?=
 =?utf-8?B?K2EwenZ4MXdoMXRPak5wWStEbWJ6MDJtRHc5THltUGpqblpQT2VHZExvK0c0?=
 =?utf-8?B?c3pmcE9reDdYNmV2eUZlQUZGQ1VGU1FaU09jTTVjZjVCQWJUSWRhajZRVG5L?=
 =?utf-8?B?Z3NMRXFuYlhsSnp4dVdrZDJaaUxacXlQZTc1VC9kVzlHRDBqMGNpeGk5dVo2?=
 =?utf-8?B?b3dYVzBLTHFDT0FlNmQ2VitCbXhrd1NZQjNKWG0zU0w0dzZidlFSYTkwaTBM?=
 =?utf-8?B?MFRlNjd5Um5BeG1Ud2RZYnVhNnhnaHlWalZOeTYyd2xiZUs1d3J6aE9jOVht?=
 =?utf-8?B?Y0Y5enNlYWRPK3R6R0VvYjZlY3YrcCs4QjNMUXFLU3FHVGxmQm5GSFdENllF?=
 =?utf-8?B?bys5bTU1UEEvUjVyVXlyaU11OGt4U0Nqd0lJVHBVNnNkRlhjbndGbVZDMmpo?=
 =?utf-8?B?bnJwcjI3UEgzYlNGalFvK2V2UXRhaXF2UVZCS25VQ1BxRXVDbjZKSFYzSnhV?=
 =?utf-8?B?bGpsNmZ2MnRGK3RSMTE3WmNVMUhZYUw2ODlVeWFSWlNna0RHTy96NDcxTVJN?=
 =?utf-8?B?Ui9XOXZUZmRZS1hwM0hTemtlQ050RU12ems4QnhaYWpkRTJ0dXBUa0R0R2g4?=
 =?utf-8?B?K2o5VFMyUHN1aE90bE0xMHJacXpOcWdYTC9UYUNiZUJtditBbzlwK2N5QWxH?=
 =?utf-8?B?RkJrQUk4R1lMMDZMT0lPekZzZmMvTlBxWE1PaDJ3YmlPNmZKUVAxNkFlR1g0?=
 =?utf-8?B?cnh1ejZaN3MxUTNYeERUUk85TGh0UG00eWN4cGdUYjRyN0lnSklZdDZrQk5O?=
 =?utf-8?B?bnNTeEUxcUFrQ2JvRWVyRTErZVpHUy9MMGtTL3NaQXNrOFFISWtGVVk1MERJ?=
 =?utf-8?B?aUV2SFNMbGJBekF3SVcwUm5pZmJoOHVkc2lsZXJLcE5WM2I3Rm1jTGNXOGRn?=
 =?utf-8?B?S1hPeHRnRTk5enFBS2Eyd0lsN3lPR1BsWWRnaCtpRTdRMmxhNjJyaXN2OGJN?=
 =?utf-8?B?aWRzcUtZZUVwbnk3RHh0NEQ2SHVMRHlHMENNRWIyTnJRUEp1K0hHeEMwZWU3?=
 =?utf-8?B?MTJJZGZVMzdqYkd1WjZPNlNQajZvVC9qbC9YMW9oVVhnVkV1NWFZN3FPeTFX?=
 =?utf-8?B?RHpTcjRwZnNZQTVaSUNObklRWE9GaS95VFE2djhTa0FpTmhGaVYvVHgxZmJp?=
 =?utf-8?B?bGRrdjZscHNVMHgzTjZ5a0R4WE9mT0NDS2pCbVFYK09HSzlZb0dkK2tNM2hV?=
 =?utf-8?B?a29VSkR1M3kzYUpFQ0NieDV5d1Nxa0ZwRWk3STE0aXlna1NscG8xWjBHV2NW?=
 =?utf-8?B?bzhOM3lySmdkcVRTV1E1VmRqc2JkclZMRGsrTHkxcG5hbVBUNVVhdVJMd0hq?=
 =?utf-8?B?Um4vejdCMXl6ZlpOVzlpRGFEQUhRN1h2SzV5dWFDc0VUK2Rkb0hRSEFwRTNU?=
 =?utf-8?B?T2tBUCtsOC95V1QzQ0JvSUtpQXlWc3Vlb1kyb0xpdTJodXpKR1liaUVCc2k1?=
 =?utf-8?B?UFRpMHcyVnJWQVQrU0swM2ZiS3NobEd6RXYzb202T3ZkN3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cC9KeEtadEJtekdtaEdYUFo0Vk9YU0kzKzlLSUh2M1lJSTJFbjZQaDhuV1JV?=
 =?utf-8?B?T3VnRnVZbUU1NkY3M3BDTTlPS3RIQUNuVWxQdUpCS2xWd3VLZFRXbWYwYUha?=
 =?utf-8?B?VEtyWnVMcDRpTVRaamtmMzRKaUdsMEM0RGhXREFPSi81UnZ4b3AwdVUxNUNT?=
 =?utf-8?B?bUZFb2JzTzRuTVU5VC9xVXBuVEJhbUZ1VFFUU3JBQmpISjY2bVgwSFJXdW5v?=
 =?utf-8?B?bGhiK2x2a2J2NGdSVFBZVmtwMWFCNzZnUGhVN0NoUlZPd0pKc25xWnA3TnEv?=
 =?utf-8?B?eHpOTDBPNDNxTDNHbTB1dGxUNENWdGtVaEM2cnRkenFwaWZYMk8wWmpYZ2dq?=
 =?utf-8?B?K1hMVzkvN0lnVnRXd3JydmZpVk1GcGE4dnJhV3VQQjBmOGMwS0c4b0w1VFJr?=
 =?utf-8?B?bmtVd0szdFEwNlRTR2RtK2F0U1B4NzZhTk9BZ1piQmJiME5QbUppVXBMSzNM?=
 =?utf-8?B?NkVtdEkvenozS1JValZqNWRuQ1lzc0lxUXgrcnJVUjhycENQeHFtRC9FVUpu?=
 =?utf-8?B?N2lFT2pFMGJZZnpRbStlV3JlZTZqcFpISHNlbUJ6VWo0RmZDTHF4T09tbDlj?=
 =?utf-8?B?UTdHczlaNzdkdnRkWmNUMzN1cDA4b3VQZ2ZRYTdQYS9GTmQwYXdpS1NnUW1h?=
 =?utf-8?B?VTZlSzlPa2pFZkxrVTRTMkZ5RHQ2MEZ6cXNYelBmdmRRN0JubXVsMkNSZGhN?=
 =?utf-8?B?NXY1aGVYcWtFblorVC92c0VVVG8xNkF4dDZVVWdjV2NrNVYrNWxJVWZvSlEv?=
 =?utf-8?B?OUk0UkJQeUhDRlJ3bDJ1WlQ3enJqc2NaNHIzY3RJdTZWbWxoQlhCbmUxeFNW?=
 =?utf-8?B?NkFXNk9LNU84TUoxZGEwbHZXMEwzV2FhVU5McnBVZFdWQ0wzc3dPWHExM1oy?=
 =?utf-8?B?RCtFNTZlanRUYWtpbWtId0p6Y0pMZjNzM09jYmprRjl4WEluazZ2TGFQTFJK?=
 =?utf-8?B?QXBMT0pJT01mVmR5SElVY29ON2ZqNDBERjdhY2FWeG5XUGxMdG51eUErQmxw?=
 =?utf-8?B?ZWdSZW1FUGQ1bEQvKzJQUFJESFRoNzBEQTgzMGNPL00vb2ZmdkNDeW5maEFK?=
 =?utf-8?B?UjRqaGU5UDIvOVZNWWlaTWQrRXRRV2RLSVZha2xJUVNvenJyWHc3dnBjQ2Y1?=
 =?utf-8?B?OG5xTDZNZXlyazIydTFlbDdqTHpHSXFVS2tZZUtWOUIxbVZuYzRVaHpHNWxi?=
 =?utf-8?B?d29ZeTlrYy9tb0NGMWFuQUdjVVFJamxhMTQwekdOdEZqVk9Sb0RjcGZIbmI1?=
 =?utf-8?B?cnZnUzJmc2FWZ0oyUFVySkZzZTZTaCtFNnNiV0ZDL015eEdGNldFWFBLSmds?=
 =?utf-8?B?SXY2M1dQZUZYSXZQSytjUWFnREZpUitOZk9rTEs2OGFianVxVCszcU9yNVVX?=
 =?utf-8?B?VDY3ZGR6NGt4ZmsyUGw2V1RETEZtUEdBVVYxNGZIUDVGeFBxOGx5Wlk0L1J1?=
 =?utf-8?B?aGdZcFRnanZlNktyd2dKQnl4OHEzTERPVXNPaHVMLzQwN0RQTmllYng0aWRM?=
 =?utf-8?B?bmpaV1F5ZHNVajIyMmMwaW5SYzJvRkk4Q0N2OUhKRk1KZExlcUtySDFZYzdX?=
 =?utf-8?B?d1p3K0djYUtNc3dHR3Jyd2VLb3MyQW84UWh1ZEl4d0dSSFFKSFRld296MjEz?=
 =?utf-8?B?NTdsSUlxUFlmbGdnTUFlK1R3OE1DdDJpSzVsQXdwUXRSa2lGYmsrZGhpRTlt?=
 =?utf-8?B?RkQ5clJ6bDk3akNVRUdjSVEyTFdDQ2tPc3FrNE8zVURudEhrUXFsSExPZ1V0?=
 =?utf-8?B?NVRpUjhCNkxVUU1UMmtrcFF3Vi91RjNLa2JrYkJWMDlUYXVWVE9DN2hSZi8w?=
 =?utf-8?B?MXBrTFlPdlJLaWpLMUZ5OTJQNkJ2SEcwUlkvdTBLZzZqbkUwdTBQQ2tqbndu?=
 =?utf-8?B?TW9pdFVoaWtQNU1majZBLzQxU0dHVUw4MUZlMHpYM0FBRmxxcXl6c0NtMEpz?=
 =?utf-8?B?RnNaMEdrejNUNmYwUE1yRHIvdVhHV1ZZdVdYRmVvTGxnQ0xuaitZRHZGM1ht?=
 =?utf-8?B?bVhSRUNIVGNjbTRKN3pnV2I4bDlpb1BTVExBbWxwQzJmS1h5bk5DMnJVRlEv?=
 =?utf-8?B?MkswOVBQMWcvTk5TRTMxU0lkWDB1dzZXdTFlRE1Sa0xDeSsvU2o0MUxrOTg1?=
 =?utf-8?B?a1hpL1ErcEl2b3ppV1FvejNGeFg4ZmZjcXZHbmd0YUwvSFRVclovSlNnZ1hj?=
 =?utf-8?Q?8zt0DAyIrAjMnsjSpqPQ8FUaotd39PEt1j8y0FbmIW/s?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: da084d28-092a-4fc0-7f10-08dccca5279f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 05:48:08.6139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 60X3iQOzRejfCQsDjalZlqx59R7qKNT7lk6lafBj5urZCWO08UT72ecx62aGXf+d/LRRtGy6iHlox3TOrqecxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4756
X-Proofpoint-GUID: 3IUOShtklpKQKHftgpgfwr29UnRiv5a4
X-Proofpoint-ORIG-GUID: 3IUOShtklpKQKHftgpgfwr29UnRiv5a4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_03,2024-09-03_01,2024-09-02_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBhdmFuIENoZWJiaSA8cGF2
YW4uY2hlYmJpQGJyb2FkY29tLmNvbT4NCj5TZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMywgMjAy
NCA4OjI3IFBNDQo+VG86IEdlZXRoYXNvd2phbnlhIEFrdWxhIDxnYWt1bGFAbWFydmVsbC5jb20+
DQo+Q2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGt1YmFAa2VybmVsLm9yZzsNCj5kYXZlbUBkYXZlbWxvZnQubmV0OyBwYWJlbmlAcmVkaGF0
LmNvbTsgamlyaUByZXNudWxsaS51czsNCj5lZHVtYXpldEBnb29nbGUuY29tOyBTdW5pbCBLb3Z2
dXJpIEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwuY29tPjsNCj5TdWJiYXJheWEgU3VuZGVlcCBC
aGF0dGEgPHNiaGF0dGFAbWFydmVsbC5jb20+OyBIYXJpcHJhc2FkIEtlbGFtDQo+PGhrZWxhbUBt
YXJ2ZWxsLmNvbT4NCj5TdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbbmV0LW5leHQgUEFUQ0ggMS80
XSBvY3Rlb250eDItcGY6IERlZmluZXMgY29tbW9uDQo+QVBJIGZvciBIVyByZXNvdXJjZXMgY29u
ZmlndXJhdGlvbg0KPg0KPk9uIFR1ZSwgU2VwIDMsIDIwMjQgYXQgNjoxMeKAr1BNIEdlZXRoYSBz
b3dqYW55YSA8Z2FrdWxhQG1hcnZlbGwuY29tPg0KPndyb3RlOg0KPj4NCj4+IC0NCj4+ICAgICAg
ICAgLyogQXNzaWduIGRlZmF1bHQgbWFjIGFkZHJlc3MgKi8NCj4+ICAgICAgICAgb3R4Ml9nZXRf
bWFjX2Zyb21fYWYobmV0ZGV2KTsNCj4+DQo+PiBAQCAtMzExOCwxMSArMzE0MSw4IEBAIHN0YXRp
YyBpbnQgb3R4Ml9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwgY29uc3QNCj5zdHJ1Y3QgcGNp
X2RldmljZV9pZCAqaWQpDQo+PiAgICAgICAgIGlmICh0ZXN0X2JpdChDTjEwS19MTVRTVCwgJnBm
LT5ody5jYXBfZmxhZykpDQo+PiAgICAgICAgICAgICAgICAgcW1lbV9mcmVlKHBmLT5kZXYsIHBm
LT5keW5jX2xtdCk7DQo+PiAgICAgICAgIG90eDJfZGV0YWNoX3Jlc291cmNlcygmcGYtPm1ib3gp
Ow0KPklzbid0IHNvbWUgb2YgdGhpcyB1bndpbmRpbmcvY2xlYW51cCBhbHJlYWR5IG1vdmVkIHRv
IHRoZSBuZXcNCj5mdW5jdGlvbj8gTG9va3MgbGlrZSBkdXBsaWNhdGUgY29kZSB0byBtZS4NCk5v
LiBJZiB0aGUgb3R4Ml9wcm9iZSAoKSBmYWlscyBpbiBhbnkgb2YgdGhlIGZ1bmN0aW9uIGFmdGVy
ICIgb3R4Ml9pbml0X3JzcmMoKSIgZnVuY3Rpb24gY2FsbC4NClRoZW4gYmVsb3cgY29kZSBjbGVh
bnVwIHRoZSByZXNvdXJjZXMgYWxsb2NhdGVkLg0KPg0KPj4gLWVycl9kaXNhYmxlX21ib3hfaW50
cjoNCj4+ICAgICAgICAgb3R4Ml9kaXNhYmxlX21ib3hfaW50cihwZik7DQo+PiAtZXJyX21ib3hf
ZGVzdHJveToNCj4+ICAgICAgICAgb3R4Ml9wZmFmX21ib3hfZGVzdHJveShwZik7DQo+PiAtZXJy
X2ZyZWVfaXJxX3ZlY3RvcnM6DQo+PiAgICAgICAgIHBjaV9mcmVlX2lycV92ZWN0b3JzKGh3LT5w
ZGV2KTsNCj4+ICBlcnJfZnJlZV9uZXRkZXY6DQo+PiAgICAgICAgIHBjaV9zZXRfZHJ2ZGF0YShw
ZGV2LCBOVUxMKTsNCj4+IC0tDQo+PiAyLjI1LjENCj4+DQo+Pg0K

