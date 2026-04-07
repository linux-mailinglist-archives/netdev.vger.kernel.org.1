Return-Path: <netdev+bounces-276102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPkFLDk71WlY3AcAu9opvQ
	(envelope-from <netdev+bounces-276102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:13:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2267F3B23B1
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1942E3018430
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 17:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6F63D2FFC;
	Tue,  7 Apr 2026 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="RM7JPo1d";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="iiSPhjYK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467083CFF60;
	Tue,  7 Apr 2026 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775582005; cv=fail; b=nyB6DKqJ2+7pcoqQj4ND9oNd4VOt9iZslYWfzs8PRPhemEIj/lkEzOsz+lNjwGo0W2zVRGH0jWy193CcP8+A2XPniVuR6V4GiAIALoR/h2cvZ1VqHmRusgmQvFv239SzQnQuf5CHPkbCbgQ/Phd85tIFw1aMVUOLzKz11DipYs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775582005; c=relaxed/simple;
	bh=5NFROCdmuk33adEF0HM4uX2LX6LPw0vyQhv5Gunxc5s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ah7B/d7c4q6ZYlj4kc1GNRnwKSld7IY48XFSb6odyPKBnXoieL3bxUQYYqut3PWWXJXWq//8FYjGZ7T8QHA2+fS+aWW3e220Dt79+2Au1Vh5cDLmXnCHrEkT7K/45Q4LyOeZ7iwe85kdYRfZOQ2rboEmLI9W4l69QIvNgnIYB2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=RM7JPo1d; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=iiSPhjYK; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63798cdD1756725;
	Tue, 7 Apr 2026 10:12:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=5NFROCdmuk33adEF0HM4uX2LX6LPw0vyQhv5Gunxc
	5s=; b=RM7JPo1dB7mVA1mTvNBThJECPWtAhEeNeX6gyPdPWpdI/gx4BBN7GG4Cc
	FV8K7Nhrlhq2SHur3g6MECzgQQszNFk6ot6pbo8LoBcrfPAXMFKixzZDS+VXX4NG
	ujEaGjQkkZ9pkYnAjx1HHKt29BnFT1rTBg+W3VlBsCYbzTE1T4jnzrj63dNt2dVW
	ruLsZisxeChAKHPotHnjk2BRom3+6S7oh469F8Gbz0MjxQHl63477+J7xzyHfhR5
	KQMhtIy0DQHJRMTSQOIw7QRJcZ36M/hnY4Bxc3JvBztLVvlo9HQ4eCi//xNdGAPX
	huM2TUaf6plnuBjvxOHJuN0mceCKw==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020073.outbound.protection.outlook.com [40.93.198.73])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4dcms6a9xr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 10:12:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1kJuzDPBO7Dr3EqEz31T9xdgy7zU4PK7YvRJY7iNVWg8iCZ6PZ6lL/UwWD9/g4jrHAUKOwMRxd391jyyGm+yEuil7pgjE3OvHoehE0kcbOnLMkGp6W9tpU9LawyEXxOwn1Ae5lh/y1oj83fUbqHBOfGRoi0jCHnsIsK44uLGEtZjxVa/TZyHVIkIQgW8NYMdDhhpv7wxl4x4f00+5ikqo69iGO0EwkD7pcZ/zrr0hbxM6M+ECfgA9RMg6KRjIh2GWcUdYnpVJcG92whoPIdY/VWfq+904uyUgqEomX7B9lvAW7wlCj6W56SRuPNP/RtOb2VPWCU2AICvARJPYT+LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NFROCdmuk33adEF0HM4uX2LX6LPw0vyQhv5Gunxc5s=;
 b=SiKiRFnFj/7HkcCPpreM7K3QkaVeV9WjgHrjHwTAGHxxENciQU6eBAJ1vvi7BBujkmMPLWPdaaxZwTLKgBqRpL49VF7V7oy0I73NpHAxvEBf0lF6G7gOLNXKMR+WVGvft1jLjUKAZQjFoz7lG5e9iqYUCK7cinRWYul6OhGbakmpEeFs/I5HLk/94WdnjsrOBX0xAlQSYNP3rshXcBHy4iJfylOTtUqnpL+DHDnDwa96eZWmrF0pIRjrCrzJ/5lbLGLFFR4RBhoS1K1xy2MGTSkXEXvyIFcc+PwqyVfsLt1bQxMl0oz/JjJIwgNkXs+XC2M9DrzV7nWF76v4zpazxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NFROCdmuk33adEF0HM4uX2LX6LPw0vyQhv5Gunxc5s=;
 b=iiSPhjYKghGSX9+Veej6qCw8wrbwFm3xp2QODtuoDurDqpQFrQdo5gBG7dfygRzKOX/CVmjabBpDOPwyWPS7wGl27AKyUhE2CNj0ecUoag5ido3zGutem31XZ0e0TeCEluzYPf9KX1CFW1StlRLUSOUmsPZItwdomQ7Q8ELPu7xLW7RmLuLSM6rsxTdqDdoHqeL1yoZjRQFgedHtZoKIcJpE1N7MPr2sq3+abiC6h9v439j3yRg94qW/YYOsRVo/JpjwPYdrFUiGl9NHvCemm5U4QnOmYayfxlJ83W3U01wp9B6N0jdJ5scM1Ks2mWMRj74gDHDjRTrcL8MINVDHHg==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by SA1PR02MB8656.namprd02.prod.outlook.com
 (2603:10b6:806:1ff::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 17:12:06 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%3]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 17:12:06 +0000
From: Jon Kohler <jon@nutanix.com>
To: Jim Mattson <jmattson@google.com>
CC: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "x86@kernel.org"
	<x86@kernel.org>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "H. Peter Anvin"
	<hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        David Kaplan
	<david.kaplan@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Borislav
 Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter
 Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel
 Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, KP
 Singh <kpsingh@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
	<davem@davemloft.net>,
        David Laight <david.laight.linux@gmail.com>,
        Andy
 Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar
	<mingo@redhat.com>, David Ahern <dsahern@kernel.org>,
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
	<linux-doc@vger.kernel.org>,
        "chao.gao@intel.com" <chao.gao@intel.com>
Subject: Re: [PATCH v9 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Thread-Topic: [PATCH v9 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Thread-Index:
 AQHcwwErFlQg+3SY+ESVBJhvwP0HBLXNpDMAgAAL3QCAABg4gIAAFRcAgAAG7YCAABVlAIAAAcUAgAADFICAAAHLAIAAC7aAgAAhTwCAABjVAIAD1aqAgAG4fACAAAG4gIAABzWA
Date: Tue, 7 Apr 2026 17:12:06 +0000
Message-ID: <FAA31092-E1CA-4D79-8CEC-3DB0F6F1C792@nutanix.com>
References: <20260403213445.xzb4rxbfbg5un7li@desk>
 <CALMp9eSXfJvR=PHtttbqm3q3nH436T1eH4YdpVqxQeP-cxEPsA@mail.gmail.com>
 <20260403231608.zopnhnypdclzqlx7@desk>
 <CALMp9eT2vJBdLPY2uBYrPgVrhS_aYmfGfdXe6MZXG_gyryLHVA@mail.gmail.com>
 <20260403233329.fb2ppifgwm3um6ny@desk>
 <CALMp9eTpsenqsWjzmpXLEubn9uNjgZgzgrMwtZ72HDuV_2xgfg@mail.gmail.com>
 <20260404002149.wtayv6a64vzuppgp@desk>
 <CALMp9eSqgL5q-MY1xpjqR5oRn5_cb=mfEhNFWusNneS=Mx8UMg@mail.gmail.com>
 <20260404034954.t7iapenzvhdpagxp@desk>
 <CALMp9eR70eE2U63gzNzTiic0PqJVGv3CBBuVUOVbi3nqbWKZkQ@mail.gmail.com>
 <20260407163943.y6tkh26z2rfktn3y@desk>
 <CALMp9eTA3cXxuOT4dq=6y1hx52gPH1ywwTEmPQ5-fA-vz6r3VQ@mail.gmail.com>
In-Reply-To:
 <CALMp9eTA3cXxuOT4dq=6y1hx52gPH1ywwTEmPQ5-fA-vz6r3VQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|SA1PR02MB8656:EE_
x-ms-office365-filtering-correlation-id: 9bca6a6a-5b50-4f69-5d59-08de94c8cb77
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 U0S/B0PwJVOCvgEqVBmqU4aLaPsZFWj+o5AbHYI7SHuhFa7YWd5jQ9ArhSNS/1suJhnlAfwsJq2YgVmINvGBFCWXTQmOq0B6vpmw0UE19eCrXee03DzdzJg9gnm6gawVKg5IwurdjPBi46YRyQwPqBGgWhk9t4YGdTM15HbpkfOkh0LtwmXKAaFYK3rb4Y9YGQMwlosmsSClvjxw4RMAzQkSaC/ZwaBUaz5GuLUbPHk5tfHM27zp01zAUs4whIM8nP7pLd0YkF0hxk/RwpyYk0Yggt+wX+wBuu8R2TC787+4E/PygiUGbmIRlSvTOTMBq2bXReOcbEd/mcZd3vysM7K1ICOD5/Txn9o3cWWyacTGJx2k2AhyxG29tdgXTcG2PR89y/RJIKhglgxurnM8TY0emGjN7ah1nILkXM4sqZcjJeqc2b1bZYR4Hin6YIdTrncvZr9mMjbMxFzb9Dx7v81rZQO9lKiykRKPYzOThvHz5AMRwsoxguHvnkjMxSQkSv4x4ZoiplbUGc+9mVGOPS1itBtiVmHeZLnJ9L/tjeHZlXauWlZIMIPqlM9tfg14gfqpUG8C/pzOAHUtP3nIWP/Ttf3O3ILljL0r4CxYEb5kPJ0PodeZJv57+3JBHPcOxYWL/oGV53WEIny/0i0DlT5KKWn2WnoYk8fG0k6LhDrdv+ANl9Evp5hDlntMwusigvs7wsn5/AGGQwBWQF+Hg9s8vGdaJ643N22TtY7A34559/zierhCbIfDDPiaV689psIIwza6G3p8YaaNlrNY/dEOSkGye/0WPLLkpb/rm5c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QURUb2dqclZOZDdaMkRtS1dtWkk5YmFVSmpSVjZLOXBQM3VPRG5rSXNLdi9r?=
 =?utf-8?B?NFdsd2tEUkFMeDNjeGNkbHRuY3NPd1lJcWtQVXRjMy9TZ0Y4QUFRNlRmaXlR?=
 =?utf-8?B?WDJkQWcwVG15ekdCS3lLNk5RWndnTFVtWXVDSkZZUTFITkxRZS9TL0hpNmdl?=
 =?utf-8?B?TVZUUjVYS3BxMXdDV1hLMHBwa0EvTXFSYndtWm9qOVdKakVCOXlvK085M0Zk?=
 =?utf-8?B?T0pIK0FVeENMYTh1dDlzMjMrdDV0TFYwRVRWS3M1MWdPZldzOGF3RlM4djFU?=
 =?utf-8?B?MUZJV3gzV08rY1ZWdGNUTGorNXJVZ0xLdk5ITkZ3emw4ZmJZakVEL0x3ZWFB?=
 =?utf-8?B?TkxpSGNkRVZtSXFpZUEvajdwWVlPS0NXOUZSUnNrTDR0c2hLd09PUUx1T2hY?=
 =?utf-8?B?ZVBHWGw2SkpjU0kwVFdVVFpuYWFHeFFKd1R2NEVqSDgxd2ljUTZJOVJqazRv?=
 =?utf-8?B?RnBFSVJrMTJvbHRGc09MdjZqT095M0o0Zy9peFBLc3oyRlppdUtZTVVySnNl?=
 =?utf-8?B?MGxkbk00QkxYYmdIVUdhZVRLZjB4UGhrdmowMm0rdzZhMHN6SndsT28vMkFN?=
 =?utf-8?B?NTBaQWJLTHRQOWFPZzErRHFYbXU4Kzk3QkhRaWZqbk1yWVJKck5SVjd5ZVdF?=
 =?utf-8?B?Ky9nZkRGSXRUUGJRZEhEaDZjSFBqQ2FEOXI0bDYxWFVrSERYR1hUSWJpSmJH?=
 =?utf-8?B?NlJuNWdodVNiakdKdmZYSVUyYXkrSzlPbUJ2alJrZEdwWm5yekZmYkxnMUts?=
 =?utf-8?B?Q3NtZ20xWHRwa1E3YkJhMCsxNEJURmlQR2JWTGVIQ0wvSGNzY2ZiNEpPd1o5?=
 =?utf-8?B?eFAwU2F4L1lWSmZYcW1nWmxBRlJQSEdYWU5vQ21zamdNM2hERU1XakZiTld3?=
 =?utf-8?B?RFRhQmVvbG5MNjFwS3ZCamJDYnFlN05sL2E4MWtwSGUzV0d1SUlYeHRrVHYv?=
 =?utf-8?B?YTRqa1c1NlYzZGlJWXAvZFZuRnU5cGhrSnVjR2V3cmo3dDhzaXJWeXFmbjNM?=
 =?utf-8?B?QTQ2ZmI5NyszbFo3VUZsL2YxQnNFenhnNlRwai9GYTMrcktkRHZPTGRMMEZS?=
 =?utf-8?B?YmltSStSek9iYzJlUkJwb3E5QUtMMCtCYUhyRGcvblRnM1g2eHY2cG5nZlRG?=
 =?utf-8?B?aVI4NWN1V2IxUEVHYUt0aVJEN2pRRmlGWnhVc1dmemNaRDFKV002UHRTcUs1?=
 =?utf-8?B?QzdsdW1janQ4aStzRTEvbHJlNnRwQ0xaOFJPNm1TNGwwU2NtRzJyWTQ5QThE?=
 =?utf-8?B?QVpPVGZYL2E1Vml6U0U0bWxTdnVlZ3VOVk95ODJueXZQM3ZRZmFvcFBOdlNt?=
 =?utf-8?B?aGhwRlNLK0dCNFBXLzV1MmwzbEpiWVJzVC84Y1NLQ01FYTFqUDJMUXlDbmRF?=
 =?utf-8?B?Y3BVYkJGcWcxWnFvb25nU0F2TTRlTWZYVlUzTGd4Uy9JUVl2c1NnZjA0TDk5?=
 =?utf-8?B?ckVxckthbVdHRXdiRVNUUHdXVnczMzJWelRQR2FYak5MRW5VTEdnODUxaWtY?=
 =?utf-8?B?a2dOMW1FU28zZ1lVUW1IMUJVTFJFY0RsUU5qdkpLS3h2ZjM2RGhHT1Exdm5B?=
 =?utf-8?B?cmxjY0JFbU8wbnZPaW80clM5WmI2T2dWTHlaQ0R6eGdsQWZxeCtrSHNHUkll?=
 =?utf-8?B?TnFiR01SaklGS1BqRDFlV0NYdUxGYzhvZVFwZ3BXSHc0ZVJkdk85bG1tUXBI?=
 =?utf-8?B?elZiM2hTVHhkMkFXVzJ0bzU5Rk9uMDllNy9VMnBjcGxkMERaU0wycFY5bE1n?=
 =?utf-8?B?YlltemRMaHZrOWxXL2NKdkJjSDArMnlBYm9ZWEdNNkEwZjVpUDMvQkVFWHps?=
 =?utf-8?B?ZXRTT1d1WHFsSnNhMnIyZTI4Y1hvMU5hQTkrTVVvUFZmK3ZsbHg0dEliYmR2?=
 =?utf-8?B?SllDcXpNekVaZkVnK055YTFVc1Q2VjFFYm5BUU82dVdYK3JHSkZjSXhqQ1ZD?=
 =?utf-8?B?UUtTSjFIaytidHJ4MlVCM3UvL1UrSlcyWDl6QnlrSUxFTkdVanplOXptSzFn?=
 =?utf-8?B?c21LVVpqaWJ2aEhTRHFTQ3hJKzREWEQ1cXIxY0tLRThXdjAwVjZkSzBrOGtL?=
 =?utf-8?B?RDhXcm1UeG9aMlp6VGlaOFFLdjdFYjRzenk5RXJUaTVtQkM2MVdrcGdFMEhp?=
 =?utf-8?B?S3V4cUdMcDZSNEFDSWZDbWtJSzFhb2JvWjFPcGlrOU9iVWJncUIyM0Z6eEZF?=
 =?utf-8?B?NlJNcDZFaXY2c2RuNWFNQm1KMXZXenZ0VW4zK2JucUxBTEgwY2xiV2tGcTF3?=
 =?utf-8?B?NGpSK1dqaHdzanJHbVdYNGo2bFllVU1xc2lpTVZOc1U5akpXOWVCOEpwaVhB?=
 =?utf-8?B?VFNQN1lZWlltdlE0K1ZzcE90dWd1TEVld3Jqa1E2UFhqdnZpOEF1RFFYTW1q?=
 =?utf-8?Q?tXoSPS7BzSsWArnQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A233D2E4F8817D448C083ABD15719DD1@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	jSUXuVaJJR4l+xxAMQJtGtYn9vCn3hjBvbFFll3uh39rPDvnxPYfNw8V9bZAglnpDSfa0uxWKGTzftfGs1zxJ0eyPH2R1OcG3o2FvoUCxsuqbtxeSZVhPdqoHVbiz0ZfRVq4+B6Qeyj/K7+VGBhJ1xpHskFDu8iEWl+Kz1h+z8mcdlv7yufAfKEcyaBg2MAjyLQjFQ+hW1bxItO/3qUERCZmhlEvT341fyZUR7dOMKVQnGpS2UtvYLufuLInxxoSG3FSwpyq9OvgSgH0/cDskEVtGZVWAgFpOvyV7olL/kJoA3kNEj2lZJzBt5wJYejPsQNwi2giXfTbsAk9DDWr3g==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bca6a6a-5b50-4f69-5d59-08de94c8cb77
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 17:12:06.1075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5i8rXfRojVifGFEIPlvJEeMcsPQnd2a6L3Wbu/FC1aE/J7oBr3aTZdHS8dbwXUr66f3rjLiNJMvZAmc8aHAv9WQKP5hG3v0SzX3LHrg1ezA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8656
X-Proofpoint-ORIG-GUID: usUWWB5RmQlb1l3Jpw2kEI1eJxxwu4hQ
X-Authority-Analysis: v=2.4 cv=MaRcfZ/f c=1 sm=1 tr=0 ts=69d53ae8 cx=c_pps
 a=XGteBKPvimVCBgpwGHxg/w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22 a=1XWaLZrsAAAA:8
 a=QyXUC8HyAAAA:8 a=Z4fkGGyZb4KzYHDMY-0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE1NCBTYWx0ZWRfX50AsBnv7mEZa
 IoP1Vd6cJygdt8CPlxDLFnL20u/Obwe8D4ImbaWg/TcDPE8hq38yGfQ+0pXBYT32m40pGzAx+Jl
 984dGgyteegVdKqHRRwcoBHp2TnRllFFdH+05H5UsuqY18S0wHEskJrNQfHUg5oKtT7zOkQdCLC
 7ij24ofpFRFSSFxDlCiBSa1fQ6fD3g0kVsyv6EpplIpd3Osn/9/mtzOpSh1D38P4Aa2ClPM0Q5d
 yh44bpWUHrWP2pJs3/idp3WqM3Vr8ufP3BudC5gCtdgxd4qznlFf9XmwPuERJmBDA/s57+bX4SK
 VBtKvE0wnqKJTWgkJ8ged03ZYJrOQPu5JSwPf+rhJyk/AzlemNOPdxdTVhKchqhKKXYOuqL2L38
 Zp6UW8Q3N1Pse7Z/t67UkWfir7eNUuF3LaGoiiZ1Uy6xKTVLX/0j5+wDvsiz6U4aTk5ZBGoekEM
 7q1mCdmHJuCwWiHYajw==
X-Proofpoint-GUID: usUWWB5RmQlb1l3Jpw2kEI1eJxxwu4hQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_04,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nutanix.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nutanix.com:s=proofpoint20171006,nutanix.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-276102-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,suse.com,zytor.com,amd.com,google.com,alien8.de,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jon@nutanix.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nutanix.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2267F3B23B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gT24gQXByIDcsIDIwMjYsIGF0IDExOjQ24oCvQU0sIEppbSBNYXR0c29uIDxqbWF0dHNv
bkBnb29nbGUuY29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgQXByIDcsIDIwMjYgYXQgOTo0MOKA
r0FNIFBhd2FuIEd1cHRhDQo+IDxwYXdhbi5rdW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb20+IHdy
b3RlOg0KPj4gDQo+PiBPbiBNb24sIEFwciAwNiwgMjAyNiBhdCAwNzoyMzoyNUFNIC0wNzAwLCBK
aW0gTWF0dHNvbiB3cm90ZToNCj4+PiBZZXMsIGJ1dCB0aGUgZ3Vlc3QgbmVlZHMgYSB3YXkgdG8g
ZGV0ZXJtaW5lIHdoZXRoZXIgdGhlIGh5cGVydmlzb3INCj4+PiB3aWxsIGRvIHdoYXQncyBuZWNl
c3NhcnkgdG8gbWFrZSB0aGUgc2hvcnQgc2VxdWVuY2UgZWZmZWN0aXZlLiBBbmQsIGluDQo+Pj4g
cGFydGljdWxhciwgbm8gS1ZNIGh5cGVydmlzb3IgdG9kYXkgaXMgcHJlcGFyZWQgdG8gZG8gdGhh
dC4NCj4+PiANCj4+PiBXaGVuIHJ1bm5pbmcgdW5kZXIgYSBoeXBlcnZpc29yLCB3aXRob3V0IEJI
SV9DVFJMIGFuZCB3aXRob3V0IGFueQ0KPj4+IGV2aWRlbmNlIHRvIHRoZSBjb250cmFyeSwgdGhl
IGd1ZXN0IG11c3QgYXNzdW1lIHRoYXQgdGhlIGxvbmdlcg0KPj4+IHNlcXVlbmNlIGlzIG5lY2Vz
c2FyeS4gQXQgdGhlIHZlcnkgbGVhc3QsIHdlIG5lZWQgYSBDUFVJRCBvciBNU1IgYml0DQo+Pj4g
dGhhdCBzYXlzLCAidGhlIHNob3J0IEJIQiBjbGVhcmluZyBzZXF1ZW5jZSBpcyBhZGVxdWF0ZSBm
b3IgdGhpcw0KPj4+IHZDUFUuIg0KPj4gDQo+PiBBZnRlciBkaXNjdXNzaW5nIHRoaXMgaW50ZXJu
YWxseSwgdGhlIGNvbnNlbnN1cyBpcyB0aGF0IHRoZSBiZXN0IHBhdGgNCj4+IGZvcndhcmQgaXMg
dG8gYWRkIHZpcnR1YWwgU1BFQ19DVFJMIHN1cHBvcnQgdG8gS1ZNLCB3aGljaCBhbHNvIGFsaWdu
cyB3aXRoDQo+PiBJbnRlbCdzIGd1aWRhbmNlLiBJbiB0aGUgbG9uZyB0ZXJtLCB2aXJ0dWFsIFNQ
RUNfQ1RSTCBjYW4gYmVuZWZpdCBmdXR1cmUNCj4+IG1pdGlnYXRpb25zIGFzIHdlbGwuIEFzIHdp
dGggbWFueSBvdGhlciBtaXRpZ2F0aW9ucyAoZS5nLiBtaWNyb2NvZGUpLCB0aGUNCj4+IGd1ZXN0
IHdvdWxkIHJlbHkgb24gdGhlIGhvc3QgdG8gZW5mb3JjZSB0aGUgYXBwcm9wcmlhdGUgcHJvdGVj
dGlvbnMuDQoNCldvdWxkIHdlIGhhdmUgdG8gd2FpdCBmb3IgdmlydHVhbCBTUEVDX0NUUkwgdG8g
Z2V0IHRoaXMgb3B0aW1pemF0aW9uPw0KDQpPciB3b3VsZCB0aGF0IGJlIGEgZnV0dXJlIGVuaGFu
Y2VtZW50IHRvIG1ha2UgdGhpcyBtb3JlIHByZXNjcmlwdGl2ZT8NCj4gDQo+IEkgZG9uJ3QgdGhp
bmsgaXQncyByZWFzb25hYmxlIGZvciB0aGUgZ3Vlc3QgdG8gcmVseSBvbiBhIGZ1dHVyZQ0KPiBp
bXBsZW1lbnRhdGlvbiB0byBlbmZvcmNlIHRoZSBhcHByb3ByaWF0ZSBwcm90ZWN0aW9ucy4NCj4g
DQo+IFRoaXMgaXMgYWxyZWFkeSBhIHByb2JsZW0gdG9kYXkuIElmIGEgZ3Vlc3Qgc2VlcyB0aGF0
IEJISV9DVFJMIGlzDQo+IHVuYXZhaWxhYmxlLCBpdCB3aWxsIGRlcGxveSB0aGUgc2hvcnQgQkhC
IGNsZWFyaW5nIHNlcXVlbmNlIGFuZA0KPiBkZWNsYXJlIHRoYXQgdGhlIHZ1bG5lcmFiaWxpdHkg
aXMgbWl0aWdhdGVkLiBUaGF0IGlzbid0IHRydWUgaWYgdGhlDQo+IGd1ZXN0IGlzIHJ1bm5pbmcg
b24gQWxkZXIgTGFrZSBvciBuZXdlci4NCg0K

