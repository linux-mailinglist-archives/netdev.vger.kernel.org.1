Return-Path: <netdev+bounces-273057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FT9NnLryWml3QUAu9opvQ
	(envelope-from <netdev+bounces-273057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 05:18:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 578BF355006
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 05:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86D3B300360F
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 03:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF4430FF37;
	Mon, 30 Mar 2026 03:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ZAOJs18C";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="A+LnZDZK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E84C1E8332;
	Mon, 30 Mar 2026 03:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774840685; cv=fail; b=a3h423wqof9DvKU4/hgkV51FRm9G0fKoiOknUFfhb5CgnnoLy1iVY8wd2hjZhWprt/wpfdGO/SUtmqTaJjJprV2RoTJHIYoRbhD9jF9jz+nk9oItccjZxENaUzeQH0B+000izoI+MlLqGe+KNN+wtMWzVHT8gxmR7Qi3vKi7/Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774840685; c=relaxed/simple;
	bh=44oFXswf6OMvnoaN1xA5eNHeIyMe9nDAZ+XrFP+3jKo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l0aQ1yz0noxLPEBNF56jZXk2Xzj5ak9cMlioOrxGNbtkvfEwvissTaq4+MNjyESc5UV6C/Mbnju7MurvpA/g9zkdq8VCDKiNGXseMtnde0EfnmOJ598E/xBvLUcd7vm3ae81zPaGhyi2HJwqvJrYmu1snLzNjyLXhj/hx2JJV1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=ZAOJs18C; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=A+LnZDZK; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62TMCZnp2214662;
	Sun, 29 Mar 2026 20:16:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=44oFXswf6OMvnoaN1xA5eNHeIyMe9nDAZ+XrFP+3j
	Ko=; b=ZAOJs18CDVTu2Ke5LEI3UEAVFh6ua6oJHXs8jHPYaAL+3Pzl2jR7ijDgf
	dvsL8vRLj811Y0T9NFvOOexJzMBhXpS2gvqwO2moVnJyNiXszL+5ZkqFaqKk5qkT
	fhDquon9bTpRGTWcvOxpygpjPyNFP8xbNjHj2EJ+6Hs/BWUMpUukWTaX3Haf5v8M
	VcTa848FaDtK4yL0tDwt25TabEyYbTDGua7uc+ZZ27vz7/bczwpQqogctZK2DDGP
	VaV4LGNsl+LGhGxH1SjYiZB5n4o+9ORAkxuOKQh0I+6CdQchbeWNBtnX4aSh/QKV
	58/XEifAalOLEdaNspXi6ipCgzjkA==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11021078.outbound.protection.outlook.com [40.107.208.78])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4d6e2aj1wx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 29 Mar 2026 20:16:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PR21qRP7U4eP2+FSti22GmC0iC+hsGTmu5MpzaLYgIP1uiTdbx9biC8AW0Gdv1AnMiFDCdKdVKXB6yT9Y9s8foZmUVBemXiDaQ21CD+Mq90XH1zlsdCsdOYmCGDooEzqdUF+f2D/L+e/FHixCcLm8+kujkKVrKco5dcPJy0Zz+6uQigQ1JJ2Lh67fimFYP4veWp/10roTU8PMv9YoeovJufLCwCjo9kCdTw/RjLvaRKtWdhKK40rIebNO8oxqIDb/ozr/pYuUbc2umdlIIVhQmDAkl/b4fLFoDjpbC+ZFsflJgf1am16tcI/vd7d8GhuPyhVve94W9D7zDxlkfrQXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44oFXswf6OMvnoaN1xA5eNHeIyMe9nDAZ+XrFP+3jKo=;
 b=w/QzDWsky603Cw9tQXTfQaCLxdAUGEhbMo5+++xfTwZvdvSQ/WKkX61M6gYjMackOvi3tN/icAB1iMPPh8rBkED6owtWMMgogauzpYiOEQEZ7h+2y/K8SuuTHnUkK8auvk5x9u3+54BHIseow1STzxlJkWb31ciHYAIKpYgZ5eSBSrPOxas81N4BvHzNYLbIFBMzlTjBtbGdoBXGyXbiymnybmHIPNkYt6u1BDv2KN799BKZjI5ulXCh5mA8t2CQlZKXk4//90OiQF5Utgke5DL4Jgk9OIYOwsC56rkPBRblmSqEw7sX20UkBjBeo4d/wffgZncqCcIV76M67bofqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44oFXswf6OMvnoaN1xA5eNHeIyMe9nDAZ+XrFP+3jKo=;
 b=A+LnZDZKnmpYXfxbBPwkfviLz4vcSbG3zMjiguolVD0tbOKpEK4a5S1wGzFJWwl4VO0FPhvxO2WENNabzLinipW8mdAr8kNjHsBjPNKQud717NcFFjfEYo9SjNM6HlikDoUhu2eGdZl3uGxdw3+qxBoGxONFK4Bo7mAT9QCnDu2yIWRvKK+3bEhPbqZo0lnffRxLs/Tm2Sws6uml6hDT9IU5NML7Jd1emRUm9XIrD4m3MhLZGSMYhOw7M4zK2oH+8ctLHVbOOVz2IYlC6MliCJVtvIjvg/7q6cv7Pjt1od0YPqJa1fvSwK2N8SnlXx2WxdFWNiYIGSPiDQkKb2jPzQ==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by BY5PR02MB6899.namprd02.prod.outlook.com
 (2603:10b6:a03:234::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 03:16:32 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%3]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 03:16:32 +0000
From: Jon Kohler <jon@nutanix.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, Nikolay Borisov <nik.borisov@suse.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
        David
 Kaplan <david.kaplan@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, "David S.
 Miller" <davem@davemloft.net>,
        David Laight <david.laight.linux@gmail.com>,
        Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Ingo
 Molnar <mingo@redhat.com>, David Ahern <dsahern@kernel.org>,
        Martin KaFai Lau
	<martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend
	<john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
	<haoluo@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet
	<corbet@lwn.net>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Tao Zhang <tao1.zhang@intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH v8 00/10] VMSCAPE optimization for BHI variant
Thread-Topic: [PATCH v8 00/10] VMSCAPE optimization for BHI variant
Thread-Index: AQHcu7pV3UedjV3zP0OQ5WVkkNgi+7XGb7WA
Date: Mon, 30 Mar 2026 03:16:32 +0000
Message-ID: <3B7BF368-4A3A-4853-A7CD-6F17E7982546@nutanix.com>
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
In-Reply-To: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|BY5PR02MB6899:EE_
x-ms-office365-filtering-correlation-id: 729b8ed9-2b31-4796-4a6f-08de8e0abe08
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 VK7aoK08a0WQI3CF3yNY0f/OkeOxSG2WENQVIA2fLfhrsGWwDTNaxx616xWG/GsCbH/GFRpjjFsoY5ZUpGVByIx7z4px8kOwydafppk+DGIt3TIKw1+ujALlEjHF0F8C1JvgbKB3WoRHwa4AXe4GuO+XlkyYgzYph4Vnz53CbxH0a8VS85jTuDyiv6x1/7d90siNudUtEjDFf2vZIBgeTYb7HKXSK/Vsq9ndefaCgoXiBLCRhZ2xzcMCB+PJnFYNWSogtx0DBywtoDQgT2ptNA2JlihUDs8AH1m9V35HpmB8aFOYDpAr/FY55ds7Xm88pcbfv6mMWZ+Jn4VgKNweCObOi7sT0rs2RsWE2heJ85xV8yPwrMBImzIY8mhV5SCPmKHW+Dj/n0JoyFPebHiEUKB4yOL25z2+dugzSSebfDVg6FeaAgh5dnAFwMOPj2Xjpwi7CYhJ8Runc76yNunEKzXXVW9QmXsZ8H0Q7dr00xO/+zvc1PCFaBUfzKw6dX1yob1ZXZhjcZ9NiqhcxiDhb4BNlZPvERR0+xlUmY/Muf4/F3cadntP6wK82vEO7wS3gvKAm59ApQ45jythPc6OlUvTSnTV5hIX71UVzonWUN/CqV6Y+OHOpKo2QcSI9kUYy8HDY2ondvwxIcd7L3At26nncOrIv/qC2R3/NOq9ToMOln4sdOwKain09oC5ToCgDt5p/oS9yibC91iX1E3OU70wGBBqWiKfchhUm07aXhY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGhVbU8zZ1gvV0NETGd1SzN0TmtORnBUWkdlMW5CSnVkLzl1eGFQdS9YM29I?=
 =?utf-8?B?SDVKL1ZFU29sM1lpRnRSaVN2Rjg1WUNiQlNFWHR2MHpmUFdrMnNnU2w1TUJR?=
 =?utf-8?B?aVlRcEVFRnJ3aW8rT0szN3FLOHZxZkhoc2E5OXdlYUxlVlNyL0lSZjJKaG9V?=
 =?utf-8?B?MXh2L1Y3TmJqak9KQzd5WWZpK2dGWHRiV3Baa2l3a1Z4b2RXYU5hZjdva2k1?=
 =?utf-8?B?OFJHOWM3bkMwbUlzM3FpUXV0MjZzT3VYa2tndmlXa3R3Yi9BTG52MmZzMXY5?=
 =?utf-8?B?b3dpNWZGSUNhbFIvNU12TDhRZzJuekhaWlV2WnpoWXBPdUI0TytxYkRGaVhC?=
 =?utf-8?B?VWpsMzNLYm1LOW5JUSt3c2xEQVhMT2xrK2E5VXg3S3RCK1RCL2FsMHJjT0Y1?=
 =?utf-8?B?ZFA5TWMyOExkdGd3YWQ5T3JIRkdiY1BJWkhhRklIY09oTGZaRk1YRWhvN0Z1?=
 =?utf-8?B?SHNuRFNMVndhU0ZjUFhGWlRaRk9PcXZ3cENOM2VhNWVYQzB1WnRaclpGbGtJ?=
 =?utf-8?B?RmZXZWxCdTBBcWNpd3hsOWVBRXRhZWR6Q0gyelk1eTc5VjVNSkMvU3R3ak9E?=
 =?utf-8?B?V2trQXRXRzlMb3hCSnk2cDByWnE4RWNWVlBrcUtZV2VNMnV3cDBOdUEvMjVW?=
 =?utf-8?B?WnJJWUVROUEvMkZGRWRuejZuVGNFa3ZQYlZpSGExckg3bkh0S2MvcjJHWDRx?=
 =?utf-8?B?Zi8yME43bWljVmQyWWRqUjFEM3pqOENRSlRaRXJRVm9FY0dCVXpmamV3V1hn?=
 =?utf-8?B?TkJkVFRRa3ZsUVExazRqUDV6aVVyWi9MQUEyMkg2cGo5QUs1VFZJWEw5djN3?=
 =?utf-8?B?VjRDMlY3U0ltNCtoZVZqVkhZdG04Q2NHSmNhTWxjRnBxWVQ4WG13eFBvSUpX?=
 =?utf-8?B?RlFZai9BQmpveWNMTk5jblF6TDdWVlU2RXVoK1kvd0JkMmZmOWRGbTNSMjUx?=
 =?utf-8?B?OU82Si9TWDhldnMzR3psY3dhdHJhZ1JRbWJWckNWUGpGZkVrTlFJdFZyaEpx?=
 =?utf-8?B?WkFyRW1YUGpRWVRNZVZpdXV1c2t2N1pLVVJlcEhiVVJscTg5Q3RlSFFHR0Vm?=
 =?utf-8?B?NXp6NTRHUzlwTFFSbkc3RlRiNjlSdS8wNGE5cHAwZEoreU9kZm1wLzYrUUNh?=
 =?utf-8?B?ZWdVSDZ0SkVxNjd2bVNUMS85MjhtNG1GQzNKdk14TWQ3dkpvQy9tMTZFOGhV?=
 =?utf-8?B?WVJ5STFDeDZ3aDgrOGZ6WEJ4OFpJV3h3ckhUbWZPdXMvYUdieHZiNUI4ZHUy?=
 =?utf-8?B?Wk1GYUYyVjZJMlpKVzBCNHM2WFJUUW52aWxmK25ZZTFReWhuazRxeTY4d2tq?=
 =?utf-8?B?eGg1YW1YL0YxeXFLZEhjV2dnbytRZ1lrMnBzemw5NVBEZENkM25jRjBlY1RR?=
 =?utf-8?B?cGVESllKYkY2eFpjUXMrWmExakFhQXROUjA0MCtxb0xweDRtdGRhUGlsRWY5?=
 =?utf-8?B?TWFTRTR2Q0dzdVpCTlhpeVhJNHBacUljai8zVDYzZ1FoOUlwSExxSHI5U01S?=
 =?utf-8?B?Tm93czlGVURYKy80UERHZTFkbFFjcUppaWU2VGJKRjA5WUtPNmlYdGwyek1j?=
 =?utf-8?B?SHU4bE1RRVhvWkF0QzJYemtBTlJYWC8xdE5aUG5xV1lBOUJpelE5bEFld0ZV?=
 =?utf-8?B?SmNDSHppdTRKaTJ5TnFOTDBPYm5pbGZVVmZTTncrNGs0VU9wSlkrYzRrK055?=
 =?utf-8?B?cm43OFNDK3BmUzQzaHl4cEQ1eCtIbEMzTzBxazZWNG16NlV1ckdnR0hTL2U2?=
 =?utf-8?B?eDdjMEJlUUJCTzdGbG04WkpXcnJpZURKUkI2cjRWS2FZVklkSnd1Vys2cE5k?=
 =?utf-8?B?UHpFNFRiQXVYMld4MzVma3p4ajZwY1FzVmZ1WWh5RDhvVUlXNFVPdE9PSUlx?=
 =?utf-8?B?ZTZObUhMY204dUY4Q1ZONTV1aTdCVUJIZi9hZ1AxSGVtTExVeHRCZC9pb2Uv?=
 =?utf-8?B?SGdhbk14WDdneVRqWFZka21nVVBzamZ1VElFNjhXbHIxdENwVDAxSjMrVkNy?=
 =?utf-8?B?c2ptQUNJeHpONUJDUTRhSUZTMWJ2NS84TWtmb1RMK0IxN1FCQUNvRlEyZElK?=
 =?utf-8?B?ODZvS2l6RXRNTytuM3RMNW5RR3l2a0lBMndtd3QzY2xYeVhsbEVTRjlCVHo1?=
 =?utf-8?B?UTJmMWR3QjBYaDNTZzBQUU1iL08xaTdjYXIxSTFQWE1UZWtPb2hidmFnWWV6?=
 =?utf-8?B?ZVllc1o3SXNuOSsvbWx3aDNkR3pjditCNmlDNm1kQ3JraktpQ2tLVzBXWWpx?=
 =?utf-8?B?TzBDZUVOcUI3L0RLOEpYWkJhYng4K29XbEFVVW1zUEtBUy9qMnB6TFFVaE80?=
 =?utf-8?B?WE9QdXRIYnRBMm9HSlE1ZVAzY0dYMmRjRC9tQ0NpUzB0Y1paWVB6SjB3eXJm?=
 =?utf-8?Q?GYvRMCefqqATMzZ6DESBisNbFjXO4NrimxUQUH2GcQHRi?=
x-ms-exchange-antispam-messagedata-1: AFRbLb4CxpQmdHBqD45wiAUxmXTwDzV+JD4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53AE5FE5E15E874B924E7876DD998852@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ixxAdouRaLpHuulTO2+Ol5zU5+AREsV7eb7LtUtK/3ubJoX/eY+fH/Y5Xj9Z6nSl58CBWx7WjQz3Pc3rvzPayVo9nzKgYRmPbmmPcMg0oMY3CeL1wmumHnWLjQPZH4aeirh19d6y5iLoJVYrS5pDlgJuihQG2G8H9yTV1Ii1eCftY9CsCV3GH3pOZxxgeLEvd84Xd1IlbrSUpDtw2FtBrkb/JQKDTtCefFVgPPysRiZZp3WZfw8wPzlwyTlwGSeM/3kS0CyzL6xjcpZ9y50ftMznck8+e0akMX4nrJMzJ434ZFmDdWytbtgwvwoBbDDu9Tj6cpFznO6sEb+PmQinow==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729b8ed9-2b31-4796-4a6f-08de8e0abe08
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 03:16:32.2118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hW+QmtRdzj8GBeOsRsys1KcfOWLnhC+7KOC2UAuE1QWdU/kX48cBOaqCr35md9DfJy4xcrgrx0wEZLO7yPkIMBlT8+O1CQ8EFavidfTb5zs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6899
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDAyMyBTYWx0ZWRfX2ibRpvZPgzcQ
 5N9jOluJ6c3MZhd1X6gL5vcIfuvLHwEjmn6Ye/G5cItFQPKdX0OMTXN4YtMWIYJUQmSiBe7ucYF
 8goodmIi9uzseDKjC1Cw8Nmd53v19LZyEsQtoXzslF0qUubxPL9+/K0CwA+2rScY1mbbhPbQQpb
 NHcFFjy3P+I+A7H3ILvdIIjI0V8gefhDGaKWF/6cOVPZOo9M1U57/vbGsqKhKAtYk8Hx+Dl+zGw
 DdDPG6Qx45vHU8qiJtGLSqqK/NJvyjMKQf/hz/l4NXlGvDMo3+ucn+zV7EKL7XJVOeUUkqvXOtj
 ZexKu3p9H5t8trZ7RS4XTkky8IVp2EtVxm6GuomuCB17MreEhRFzbEb8cdPsl1xBv45nQiKAOdn
 ov//RGTTlb9LEbD9pUdVBMSvWRxrO9cSkN4St51AM/B1GVlOxSvrbbz4Ba5vkLCDoHrWDXz1PzL
 6VQbZ1KnlIEgmbJBWQw==
X-Authority-Analysis: v=2.4 cv=ZuTg6t7G c=1 sm=1 tr=0 ts=69c9eb13 cx=c_pps
 a=EX0Xkmt19mXnrP5bPG/VDQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=oenKYiqTAAAA:8 a=64Cc0HZtAAAA:8 a=6JjWZc09UD0GG1RPIS8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: yoZjOFQb3TLodDJIEFm8wPgcdbi1wDDp
X-Proofpoint-GUID: yoZjOFQb3TLodDJIEFm8wPgcdbi1wDDp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nutanix.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nutanix.com:s=proofpoint20171006,nutanix.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-273057-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jon@nutanix.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nutanix.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 578BF355006
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gT24gTWFyIDI0LCAyMDI2LCBhdCAyOjE24oCvUE0sIFBhd2FuIEd1cHRhIDxwYXdhbi5r
dW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gdjg6DQo+IC0gVXNlIGhl
bHBlciBpbiBLVk0gdG8gY29udmV5IHRoZSBtaXRpZ2F0aW9uIHN0YXR1cy4gKFBldGVyWi9Cb3Jp
c292KQ0KPiAtIEZpeCB0aGUgZG9jdW1lbnRhdGlvbiBmb3IgZGVmYXVsdCB2bXNjYXBlIG1pdGln
YXRpb24uIChCUEYgYm90KQ0KPiAtIFJlbW92ZSB0aGUgc3RyYXkgbGluZXMgaW4gYnVnLmMgKEJQ
RiBib3QpLg0KPiAtIFVwZGF0ZWQgY29tbWl0IG1lc3NhZ2VzIGFuZCBjb21tZW50cy4NCj4gLSBS
ZWJhc2VkIHRvIHY3LjAtcmM1Lg0KPiANCj4gdjc6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Iv
MjAyNjAzMTktdm1zY2FwZS1iaGItdjctMC1iNzZhNzc3YTk4YWZAbGludXguaW50ZWwuY29tDQo+
IC0gcy9UaGlzIGFsbG93cy9BbGxvdy8gYW5kIHMvVGhpcyBkb2VzIGFkZHMvVGhpcyBhZGRzLyBp
biBwYXRjaCAxLzEwIGNvbW1pdA0KPiAgbWVzc2FnZSAoQm9yaXNsYXYpLg0KPiAtIE1pbmltaXpl
IHJlZ2lzdGVyIHVzYWdlIGluIEJIQiBjbGVhcmluZyBzZXEuIChEYXZpZCBMYWlnaHQpDQo+ICAt
IEluc3RlYWQgb2Ygc2VwYXJhdGUgZWN4L2VheCBjb3VudGVycywgdXNlIGFsL2FoLg0KPiAgLSBB
ZGp1c3QgdGhlIGFsaWdubWVudCBvZiBSRVQgZHVlIHRvIHJlZ2lzdGVyIHNpemUgY2hhbmdlLg0K
PiAgLSBzYXZlL3Jlc3RvcmUgcmF4IGluIHRoZSBzZXEgaXRzZWxmLg0KPiAgLSBSZW1vdmUgdGhl
IHNhdmUvcmVzdG9yZSBvZiByYXgvcmN4IGZvciBCUEYgY2FsbGVycy4NCj4gLSBSZW5hbWUgY2xl
YXJfYmhiX2xvb3AoKSB0byBjbGVhcl9iaGJfbG9vcF9ub2ZlbmNlKCkgdG8gbWFrZSBpdA0KPiAg
b2J2aW91cyB0aGF0IHRoZSBMRkVOQ0UgaXMgbm90IHBhcnQgb2YgdGhlIHNlcXVlbmNlIChCb3Jp
c2xhdikuDQo+IC0gRml4IEtjb25maWc6IHMvc2VsZWN0L2RlcGVuZHMgb24vIEhBVkVfU1RBVElD
X0NBTEwgKFBldGVyWikuDQo+IC0gUmViYXNlZCB0byB2Ny4wLXJjNC4NCj4gDQo+IHY2OiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUxMjAxLXZtc2NhcGUtYmhiLXY2LTAtZDYxMGRkNTE1
NzE0QGxpbnV4LmludGVsLmNvbQ0KPiAtIFJlbW92ZSBzZW1pY29sb24gYXQgdGhlIGVuZCBvZiBh
c20gaW4gQUxURVJOQVRJVkUgKFVyb3MpLg0KPiAtIEZpeCBidWlsZCB3YXJuaW5nIGluIHZtc2Nh
cGVfc2VsZWN0X21pdGlnYXRpb24oKSAoTEtQKS4NCj4gLSBSZWJhc2VkIHRvIHY2LjE4Lg0KPiAN
Cj4gdjU6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTExMjYtdm1zY2FwZS1iaGItdjUt
Mi0wMmQ2NmU0MjNiMDBAbGludXguaW50ZWwuY29tDQo+IC0gRm9yIEJISSBzZXEsIGxpbWl0IHJ1
bnRpbWUtcGF0Y2hpbmcgdG8gbG9vcCBjb3VudHMgb25seSAoRGF2ZSkuDQo+ICBEcm9wcGVkIDIg
cGF0Y2hlcyB0aGF0IG1vdmVkIHRoZSBCSEIgc2VxIHRvIGEgbWFjcm8uDQo+IC0gUmVtb3ZlIHJl
ZHVuZGFudCBzd2l0Y2ggY2FzZXMgaW4gdm1zY2FwZV9zZWxlY3RfbWl0aWdhdGlvbigpIChOaWtv
bGF5KS4NCj4gLSBJbXByb3ZlIGNvbW1pdCBtZXNzYWdlIChOaWtvbGF5KS4NCj4gLSBDb2xsZWN0
ZWQgdGFncy4NCj4gDQo+IHY0OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUxMTE5LXZt
c2NhcGUtYmhiLXY0LTAtMWFkYWQ0ZTY5ZGRjQGxpbnV4LmludGVsLmNvbQ0KPiAtIE1vdmUgTEZF
TkNFIHRvIHRoZSBjYWxsc2l0ZSwgb3V0IG9mIGNsZWFyX2JoYl9sb29wKCkuIChEYXZlKQ0KPiAt
IE1ha2UgY2xlYXJfYmhiX2xvb3AoKSB3b3JrIGZvciBsYXJnZXIgQkhCLiAoRGF2ZSkNCj4gIFRo
aXMgbm93IHVzZXMgaGFyZHdhcmUgZW51bWVyYXRpb24gdG8gZGV0ZXJtaW5lIHRoZSBCSEIgc2l6
ZSB0byBjbGVhci4NCj4gLSBVc2Ugd3JpdGVfaWJwYigpIGluc3RlYWQgb2YgaW5kaXJlY3RfYnJh
bmNoX3ByZWRpY3Rpb25fYmFycmllcigpIHdoZW4NCj4gIElCUEIgaXMga25vd24gdG8gYmUgYXZh
aWxhYmxlLiAoRGF2ZSkNCj4gLSBVc2Ugc3RhdGljX2NhbGwoKSB0byBzaW1wbGlmeSBtaXRpZ2F0
aW9uIGF0IGV4aXQtdG8tdXNlcnNwYWNlLiAoRGF2ZSkNCj4gLSBSZWZhY3RvciB2bXNjYXBlX3Nl
bGVjdF9taXRpZ2F0aW9uKCkuIChEYXZlKQ0KPiAtIEZpeCB2bXNjYXBlPW9uIHdoaWNoIHdhcyB3
cm9uZ2x5IGJlaGF2aW5nIGFzIEFVVE8uIChEYXZlKQ0KPiAtIFNwbGl0IHRoZSBwYXRjaGVzLiAo
RGF2ZSkNCj4gIC0gUGF0Y2ggMS00IHByZXBhcmVzIGZvciBtYWtpbmcgdGhlIHNlcXVlbmNlIGZs
ZXhpYmxlIGZvciBWTVNDQVBFIHVzZS4NCj4gIC0gUGF0Y2ggNSB0cml2aWFsIHJlbmFtZSBvZiB2
YXJpYWJsZS4NCj4gIC0gUGF0Y2ggNi04IHByZXBhcmVzIGZvciBkZXBsb3lpbmcgQkhCIG1pdGln
YXRpb24gZm9yIFZNU0NBUEUuDQo+ICAtIFBhdGNoIDkgZGVwbG95cyB0aGUgbWl0aWdhdGlvbi4N
Cj4gIC0gUGF0Y2ggMTAtMTEgZml4ZXMgT04gVnMgQVVUTyBtb2RlLg0KPiANCj4gdjM6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTEwMjctdm1zY2FwZS1iaGItdjMtMC01NzkzYzI1MzRl
OTNAbGludXguaW50ZWwuY29tDQo+IC0gcy94ODZfcHJlZF9mbHVzaF9wZW5kaW5nL3g4Nl9wcmVk
aWN0b3JfZmx1c2hfZXhpdF90b191c2VyLyAoU2VhbikuDQo+IC0gUmVtb3ZlZCBJQlBCICYgQkhC
LWNsZWFyIG11dHVhbCBleGNsdXNpb24gYXQgZXhpdC10by11c2Vyc3BhY2UuDQo+IC0gQ29sbGVj
dGVkIHRhZ3MuDQo+IA0KPiB2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MTAxNS12
bXNjYXBlLWJoYi12Mi0wLTkxY2JkZDljM2E5NkBsaW51eC5pbnRlbC5jb20NCj4gLSBBZGRlZCBj
aGVjayBmb3IgSUJQQiBmZWF0dXJlIGluIHZtc2NhcGVfc2VsZWN0X21pdGlnYXRpb24oKS4gKERh
dmlkKQ0KPiAtIHMvdm1zY2FwZT1hdXRvL3Ztc2NhcGU9b24vIChEYXZpZCkNCj4gLSBBZGRlZCBw
YXRjaCB0byByZW1vdmUgTEZFTkNFIGZyb20gVk1TQ0FQRSBCSEItY2xlYXIgc2VxdWVuY2UuDQo+
IC0gUmViYXNlZCB0byB2Ni4xOC1yYzEuDQo+IA0KPiB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvci8yMDI1MDkyNC12bXNjYXBlLWJoYi12MS0wLWRhNTFmMGUxOTM0ZEBsaW51eC5pbnRlbC5j
b20NCj4gDQo+IEhpIEFsbCwNCj4gDQo+IFRoZXNlIHBhdGNoZXMgYWltIHRvIGltcHJvdmUgdGhl
IHBlcmZvcm1hbmNlIG9mIGEgcmVjZW50IG1pdGlnYXRpb24gZm9yDQo+IFZNU0NBUEVbMV0gdnVs
bmVyYWJpbGl0eS4gVGhpcyBpbXByb3ZlbWVudCBpcyByZWxldmFudCBmb3IgQkhJIHZhcmlhbnQg
b2YNCj4gVk1TQ0FQRSB0aGF0IGFmZmVjdCBBbGRlciBMYWtlIGFuZCBuZXdlciBwcm9jZXNzb3Jz
Lg0KPiANCj4gVGhlIGN1cnJlbnQgbWl0aWdhdGlvbiBhcHByb2FjaCB1c2VzIElCUEIgb24ga3Zt
LWV4aXQtdG8tdXNlcnNwYWNlIGZvciBhbGwNCj4gYWZmZWN0ZWQgcmFuZ2Ugb2YgQ1BVcy4gVGhp
cyBpcyBhbiBvdmVya2lsbCBmb3IgQ1BVcyB0aGF0IGFyZSBvbmx5IGFmZmVjdGVkDQo+IGJ5IHRo
ZSBCSEkgdmFyaWFudC4gT24gc3VjaCBDUFVzIGNsZWFyaW5nIHRoZSBicmFuY2ggaGlzdG9yeSBp
cyBzdWZmaWNpZW50DQo+IGZvciBWTVNDQVBFLCBhbmQgYWxzbyBtb3JlIGFwdCBhcyB0aGUgdW5k
ZXJseWluZyBpc3N1ZSBpcyBkdWUgdG8gcG9pc29uZWQNCj4gYnJhbmNoIGhpc3RvcnkuDQo+IA0K
PiBCZWxvdyBpcyB0aGUgaVBlcmYgZGF0YSBmb3IgdHJhbnNmZXIgYmV0d2VlbiBndWVzdCBhbmQg
aG9zdCwgY29tcGFyaW5nIElCUEINCj4gYW5kIEJIQi1jbGVhciBtaXRpZ2F0aW9uLiBCSEItY2xl
YXIgc2hvd3MgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQgb3ZlciBJQlBCDQo+IGluIG1vc3QgY2Fz
ZXMuDQo+IA0KPiBQbGF0Zm9ybTogRW1lcmFsZCBSYXBpZHMNCj4gQmFzZWxpbmU6IHZtc2NhcGU9
b2ZmDQo+IFRhcmdldDogSUJQQiBhdCBWTWV4aXQtdG8tdXNlcnNwYWNlIFZzIHRoZSBuZXcgQkhC
LWNsZWFyIGF0DQo+IFZNZXhpdC10by11c2Vyc3BhY2UgbWl0aWdhdGlvbiAoYm90aCBjb21wYXJl
ZCBhZ2FpbnN0IGJhc2VsaW5lKS4NCj4gDQo+IChwTiA9IE4gcGFyYWxsZWwgY29ubmVjdGlvbnMp
DQo+IA0KPiB8IGlQZXJmIHVzZXItbmV0IHwgSUJQQiAgICB8IEJIQiBDbGVhciB8DQo+IHwtLS0t
LS0tLS0tLS0tLS0tfC0tLS0tLS0tLXwtLS0tLS0tLS0tLXwNCj4gfCBVRFAgMS12Q1BVX3AxICB8
IC0xMi41JSAgfCAgIDEuMyUgICAgfA0KPiB8IFRDUCAxLXZDUFVfcDEgIHwgLTEwLjQlICB8ICAt
MS41JSAgICB8DQo+IHwgVENQIDEtdkNQVV9wMSAgfCAtNy41JSAgIHwgIC0zLjAlICAgIHwNCj4g
fCBVRFAgNC12Q1BVX3AxNiB8IC0zLjclICAgfCAgLTMuNyUgICAgfA0KPiB8IFRDUCA0LXZDUFVf
cDQgIHwgLTIuOSUgICB8ICAtMS40JSAgICB8DQo+IHwgVURQIDQtdkNQVV9wNCAgfCAtMC42JSAg
IHwgICAwLjAlICAgIHwNCj4gfCBUQ1AgNC12Q1BVX3A0ICB8ICAzLjUlICAgfCAgIDAuMCUgICAg
fA0KPiANCj4gfCBpUGVyZiBicmlkZ2UtbmV0IHwgSUJQQiAgICB8IEJIQiBDbGVhciB8DQo+IHwt
LS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tfC0tLS0tLS0tLS0tfA0KPiB8IFVEUCAxLXZDUFVf
cDEgICAgfCAtOS40JSAgIHwgIC0wLjQlICAgIHwNCj4gfCBUQ1AgMS12Q1BVX3AxICAgIHwgLTMu
OSUgICB8ICAtMC41JSAgICB8DQo+IHwgVURQIDQtdkNQVV9wMTYgICB8IC0yLjIlICAgfCAgLTMu
OCUgICAgfA0KPiB8IFRDUCA0LXZDUFVfcDQgICAgfCAtMS4wJSAgIHwgIC0xLjAlICAgIHwNCj4g
fCBUQ1AgNC12Q1BVX3A0ICAgIHwgIDAuNSUgICB8ICAgMC41JSAgICB8DQo+IHwgVURQIDQtdkNQ
VV9wNCAgICB8ICAwLjAlICAgfCAgIDAuOSUgICAgfA0KPiB8IFRDUCAxLXZDUFVfcDEgICAgfCAg
MC4wJSAgIHwgICAwLjklICAgIHwNCj4gDQo+IHwgaVBlcmYgdmhvc3QtbmV0IHwgSUJQQiAgICB8
IEJIQiBDbGVhciB8DQo+IHwtLS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS18LS0tLS0tLS0tLS18
DQo+IHwgVURQIDEtdkNQVV9wMSAgIHwgLTQuMyUgICB8ICAgMS4wJSAgICB8DQo+IHwgVENQIDEt
dkNQVV9wMSAgIHwgLTMuOCUgICB8ICAtMC41JSAgICB8DQo+IHwgVENQIDEtdkNQVV9wMSAgIHwg
LTIuNyUgICB8ICAtMC43JSAgICB8DQo+IHwgVURQIDQtdkNQVV9wMTYgIHwgLTAuNyUgICB8ICAt
Mi4yJSAgICB8DQo+IHwgVENQIDQtdkNQVV9wNCAgIHwgLTAuNCUgICB8ICAgMC44JSAgICB8DQo+
IHwgVURQIDQtdkNQVV9wNCAgIHwgIDAuNCUgICB8ICAtMC43JSAgICB8DQo+IHwgVENQIDQtdkNQ
VV9wNCAgIHwgIDAuMCUgICB8ICAgMC42JSAgICB8DQo+IA0KPiBbMV0gaHR0cHM6Ly9jb21zZWMu
ZXRoei5jaC9yZXNlYXJjaC9taWNyb2FyY2gvdm1zY2FwZS1leHBvc2luZy1hbmQtZXhwbG9pdGlu
Zy1pbmNvbXBsZXRlLWJyYW5jaC1wcmVkaWN0b3ItaXNvbGF0aW9uLWluLWNsb3VkLWVudmlyb25t
ZW50cy8NCj4gLS0tDQo+IFBhd2FuIEd1cHRhICgxMCk6DQo+ICAgICAgeDg2L2JoaTogeDg2L3Zt
c2NhcGU6IE1vdmUgTEZFTkNFIG91dCBvZiBjbGVhcl9iaGJfbG9vcCgpDQo+ICAgICAgeDg2L2Jo
aTogTWFrZSBjbGVhcl9iaGJfbG9vcCgpIGVmZmVjdGl2ZSBvbiBuZXdlciBDUFVzDQo+ICAgICAg
eDg2L2JoaTogUmVuYW1lIGNsZWFyX2JoYl9sb29wKCkgdG8gY2xlYXJfYmhiX2xvb3Bfbm9mZW5j
ZSgpDQo+ICAgICAgeDg2L3Ztc2NhcGU6IFJlbmFtZSB4ODZfaWJwYl9leGl0X3RvX3VzZXIgdG8g
eDg2X3ByZWRpY3Rvcl9mbHVzaF9leGl0X3RvX3VzZXINCj4gICAgICB4ODYvdm1zY2FwZTogTW92
ZSBtaXRpZ2F0aW9uIHNlbGVjdGlvbiB0byBhIHN3aXRjaCgpDQo+ICAgICAgeDg2L3Ztc2NhcGU6
IFVzZSB3cml0ZV9pYnBiKCkgaW5zdGVhZCBvZiBpbmRpcmVjdF9icmFuY2hfcHJlZGljdGlvbl9i
YXJyaWVyKCkNCj4gICAgICB4ODYvdm1zY2FwZTogVXNlIHN0YXRpY19jYWxsKCkgZm9yIHByZWRp
Y3RvciBmbHVzaA0KPiAgICAgIHg4Ni92bXNjYXBlOiBEZXBsb3kgQkhCIGNsZWFyaW5nIG1pdGln
YXRpb24NCj4gICAgICB4ODYvdm1zY2FwZTogUmVzb2x2ZSBjb25mbGljdCBiZXR3ZWVuIGF0dGFj
ay12ZWN0b3JzIGFuZCB2bXNjYXBlPWZvcmNlDQo+ICAgICAgeDg2L3Ztc2NhcGU6IEFkZCBjbWRs
aW5lIHZtc2NhcGU9b24gdG8gb3ZlcnJpZGUgYXR0YWNrIHZlY3RvciBjb250cm9scw0KPiANCj4g
RG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9ody12dWxuL3Ztc2NhcGUucnN0ICAgfCAxNSArKysr
LQ0KPiBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCB8ICA2
ICstDQo+IGFyY2gveDg2L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDEgKw0KPiBhcmNoL3g4Ni9lbnRyeS9lbnRyeV82NC5TICAgICAgICAgICAgICAgICAgICAgICB8
IDM0ICsrKysrKystLS0tDQo+IGFyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmVzLmggICAg
ICAgICAgICAgIHwgIDIgKy0NCj4gYXJjaC94ODYvaW5jbHVkZS9hc20vZW50cnktY29tbW9uLmgg
ICAgICAgICAgICAgfCAgOSArKy0NCj4gYXJjaC94ODYvaW5jbHVkZS9hc20vbm9zcGVjLWJyYW5j
aC5oICAgICAgICAgICAgfCAxMyArKystLQ0KPiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wcm9jZXNz
b3IuaCAgICAgICAgICAgICAgICB8ICAxICsNCj4gYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMg
ICAgICAgICAgICAgICAgICAgICAgfCA3NiArKysrKysrKysrKysrKysrKysrKy0tLS0tDQo+IGFy
Y2gveDg2L2t2bS94ODYuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDQgKy0NCj4g
YXJjaC94ODYvbmV0L2JwZl9qaXRfY29tcC5jICAgICAgICAgICAgICAgICAgICAgfCAxMSArLS0t
DQo+IDExIGZpbGVzIGNoYW5nZWQsIDEyNyBpbnNlcnRpb25zKCspLCA0NSBkZWxldGlvbnMoLSkN
Cj4gLS0tDQo+IGJhc2UtY29tbWl0OiBjMzY5Mjk5ODk1YTU5MWQ5Njc0NWQ2NDkyZDQ4ODgyNTli
MDA0YTllDQo+IGNoYW5nZS1pZDogMjAyNTA5MTYtdm1zY2FwZS1iaGItZDdkNDY5OTc3ZjJmDQo+
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0tICANCj4gVGhhbmtzLA0KPiBQYXdhbg0KDQpUZXN0ZWQg
dGhlIHY3IG9mIHRoaXMgc2VyaWVzIHdpdGggNi4xOC55IGFuZCBvbmUgb2Ygb3VyIHBlcmZvcm1h
bmNlDQpzdWl0ZXMsIHdoZXJlIHdlIGhhZCBwcmV2aW91c2x5IGJpc2VjdGVkIGEgc2lnbmlmaWNh
bnQgcmVncmVzc2lvbiB0bw0KdGhlIGVuYWJsZW1lbnQgb2YgdGhlIFZNU0NBUEUgbWl0aWdhdGlv
bi4gVGhpcyBwYXJ0aWN1bGFyIHN1aXRlIGxvb2tzDQphdCBzeW50aGV0aWMgcGVyZm9ybWFuY2Ug
dXNpbmcgS1ZNIHZpcnR1YWxpemVkIFdpbmRvd3MgZ3Vlc3RzLg0KDQpMb25nIHN0b3J5IHNob3J0
LCB0aGlzIHN1aXRlIHRyaWVzIHRvIGRlcml2ZSB3aGF0IGVuZCB1c2VyIGV4cGVyaWVuY2UNCndv
dWxkIGJlIGluIHRoZXNlIHZpcnR1YWwgbWFjaGluZXMgd2hpbGUgcGVyZm9ybWluZyBhIHN0YW5k
YXJkaXplZCBzZXQNCm9mIHN5bnRoZXRpYyB0YXNrcyBvbiByZWFsIGFwcHMuDQoNClZNU0NBUEUg
aGl0cyBlc3BlY2lhbGx5IGhhcmQgd2hlbiBlbmFibGluZyBXaW5kb3dzIEhWQ0ksIHdoaWNoIGRy
aXZlcw0KYSBtdWNoIGhpZ2hlciBWTUV4aXQgY291bnQsIGFsbCBlbHNlIGVxdWFscy4gDQoNClRl
c3RlZCBvbiBhbiBJbnRlbCBYZW9uIDY0NDRZIChTUFIpDQoNClRMRFIsIHdlJ3JlIHJlYWxseSBo
YXBweSB3aXRoIHRoZSByZXN1bHRzLiBUaGUgZm9sbG93aW5nIHdhcyB3aXRoIA0KSW50ZWwgTUJF
QyAqZW5hYmxlZCosIHNvIGV2ZW4gd2l0aCB0aGF0IHNwZWVkdXAgKGFuZCBkcmFzdGljIHJlZHVj
dGlvbg0KaW4gVk1FeGl0cyksIHRoaXMgb3B0aW1pemF0aW9uIG1ha2VzIGEgc2lnbmlmaWNhbnQg
ZGlmZmVyZW5jZS4NCg0KLSBDUFXigJFyZWFkeSB0aW1lIGRyb3BzIH43MCAlIGFjcm9zcyBhbGwg
c3RlYWR54oCRc3RhdGUgYW5kIGxvZ+KAkW9uIG1ldHJpY3MNCndpdGggdGhpcyBzZXJpZXMsIGlu
ZGljYXRpbmcgbW9yZSBlZmZpY2llbnQgY29udGV4dCBzd2l0Y2hpbmcgZXZlbg0KdGhvdWdoIG92
ZXJhbGwgaHlwZXJ2aXNvciBDUFUgcmlzZXMgfjE0ICUgKHN0ZWFkeSkgdG8gfjEyICUgKG1heCku
DQpCYXNpY2FsbHksIHdlJ3JlIGdldHRpbmcgbW9yZSBhY3R1YWwgd29yayBkb25lLg0KLSBSZWFk
L3dyaXRlIElPUFMgaW5jcmVhc2UgYnkgfjE44oCTMzcgJSBhbmQgMTTigJMyMCAlIHJlc3BlY3Rp
dmVseSwgd2hpbGUNCmF2ZXJhZ2UgSU8gbGF0ZW5jeSByZW1haW5zIGxhcmdlbHkgdW5jaGFuZ2Vk
IG9yIHNsaWdodGx5IGxvd2VyIGluDQpzdGVhZHkgbWV0cmljcy4NCi0gUG93ZXIgY29uc3VtcHRp
b24gZmFsbHMgNeKAkzExICUgaW4gZXZlcnkgY2F0ZWdvcnkNCi0gTG9naW4gdGltZXMgaW1wcm92
ZSBieSA04oCTNiAlIG9uIGF2ZXJhZ2UuDQotIEFwcGxpY2F0aW9uIHN0YXJ04oCRdXAgdGltZXMg
YXJlIGdlbmVyYWxseSBiZXR0ZXIgKFdvcmQsIEV4Y2VsLA0KUG93ZXJQb2ludCwgT3V0bG9vayks
IGVzcGVjaWFsbHkgT3V0bG9vayBtYXggdGltZSBkcm9wcyA2NyAlLCBhIGNsZWFyDQp3aW4gZm9y
IGVuZOKAkXVzZXIgZXhwZXJpZW5jZS4NCg0KVGVzdGVkLUJ5OiBKb24gS29obGVyIDxqb25AbnV0
YW5peC5jb20+DQoNCg==

