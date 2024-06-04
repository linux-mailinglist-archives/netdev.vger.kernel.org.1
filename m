Return-Path: <netdev+bounces-100534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0D08FB032
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 12:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A541E1F23623
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 10:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0BE1459E0;
	Tue,  4 Jun 2024 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="jP96NOrW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB57E1A286;
	Tue,  4 Jun 2024 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717497659; cv=fail; b=TWPb2QBlsoAYdLUKENha88bmC2XO3umL0f/yvVshytXk387zIWhtbzVfSK3oKec7sAJThqhUbjR7uwfmtYRzIeuDQYuQxbRFy+ZgO15UG0p77AZqAgePLztn9kKbHS0knfdWxKRWR7PEEcp7zjMcOoC0fqv3XwN2fd2KtY7SDPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717497659; c=relaxed/simple;
	bh=7VN+R0f0ZbuMEiLu07/eeR/R+AciXCtqMDyuWjXcHTU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tMDc332zxVvsWvr4krigPwZSs7dAF0hCnGBrMPUZ4tR84sem2GWo5IC0m4qgTM3IlMGsxel52Vn1yIIXL668O8gGIuZfrCG0RvCpiZKaKxxwG8QrvhptGCaEoWYi9JAjf7A0dnE/2944ZlKKjkSzhujZNXSWgsaEFpm5a5egNUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=jP96NOrW; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454ARUVa003926;
	Tue, 4 Jun 2024 03:40:42 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yj167818q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 03:40:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogEgIcNC4AMdEv+Ocur6dbpy92GJa+GKB0CWp1KuFZDrcfzUI0r5FfSdK+ifNc1cRzd6XEt87cUzbE8nlE3EZprBVKsIJ6YeNu0L2Fjar3OXxuW3hT2M6/tqb3BQw4Fo8aIk73sAjv8VZiAT7GZb82PHAaIOwtigLRqc8dkta8wCgYCaSZHCR8JgjjzcTQl48V/4mBfp+eM1P5VoRgpVpyPR+h870L/7PEfS5UR1L3n6wfGydqfAQrftqyhvoLq5lNvxoT9Xjd8thhE0oq+ygXwPNSHFTbQFzBNVPVSVTkRD3cY+6U5u3/2OlN0bciLyn9H4JNi/UJBZZPYj8jWpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VN+R0f0ZbuMEiLu07/eeR/R+AciXCtqMDyuWjXcHTU=;
 b=jZDWnGTUzN/BXPiNY9PSYMBku71mwp1D36GoYD84QSu9RkPrR5xr9+ZR7gRuysJzay/VQlm7PN3iMnLEwURbvXgSIPNad/qySxUAJq7BP2iOlcZdUezft8qBMw5kwy5CuquAUcjlOd0jxbXy4WR2K0y5rnU/B0Qo+K0MC3rfL67g5svkiSXJZUvrYeGEMS4gp/I3FURK1EpukWpVjAFg6Tg4/3ZAwYUgRx01h+4BALuLBFSWEnVkT8PHpp/0s1giC3ydR+IqWAwzyoPz/cMGHD8mBY6QW8udSda/W3AUqosdT+NwXt43NYNmdJEnu7JMiR/LNTLSrq1JFWV9PEUBDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VN+R0f0ZbuMEiLu07/eeR/R+AciXCtqMDyuWjXcHTU=;
 b=jP96NOrWvRbpJoNcThXmGnyfQyajrNTtyVK5dRi3sJfCQlP3BuAuOpSkm/i19SxnWcgv8HRss1HkWMbJ759T8vygrGMxQvUx8qm/07mXOPzOjJykO0EI6Olg2/GFKVbpRPbQGldW5emVgw7YOyeWFoXEiJ174jOdHtz7fYe/fXU=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by PH0PR18MB4704.namprd18.prod.outlook.com (2603:10b6:510:cb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Tue, 4 Jun
 2024 10:40:39 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::e225:5161:1478:9d30%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 10:40:39 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Jacob Keller <jacob.e.keller@intel.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>
Subject: RE: Re: [net-next PATCH v3] octeontx2-pf: Add ucast filter count
 configurability via devlink.
Thread-Topic: Re: [net-next PATCH v3] octeontx2-pf: Add ucast filter count
 configurability via devlink.
Thread-Index: AQHatmukj6WUs9Z8EEmr+lfVbKSamQ==
Date: Tue, 4 Jun 2024 10:40:39 +0000
Message-ID: 
 <BY3PR18MB47072FD89E07CC65B30FD634A0F82@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240530101515.201635-1-saikrishnag@marvell.com>
 <6f4874d9-4233-48cd-8ee3-0576068fbc4c@intel.com>
In-Reply-To: <6f4874d9-4233-48cd-8ee3-0576068fbc4c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|PH0PR18MB4704:EE_
x-ms-office365-filtering-correlation-id: be6bdde6-3b6f-4476-5101-08dc8482c687
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|376005|366007|38070700009|921011;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RnRDZlo0TWV6WmxlTVNDcDBLeVpncGhmcHAvbjYrMTBtU3hiNTVSZ200MVhI?=
 =?utf-8?B?TkdRR2MzN0pxQ1JlSEkrOWJ6QmF2c2FnWmh5c3pLTmdValdCSmpJSStJRE54?=
 =?utf-8?B?dFdGRmpleU5OOU9KREFWQ0RrdDhDazRBS2tHU25Fc3YzT21yL295TlZ4dTAw?=
 =?utf-8?B?aHN5WU9hbEU2NHZWUG5menhJV2RNeXVnTnJBOGRDVzFRVVN4UjNtMW9OcXB1?=
 =?utf-8?B?ODR4OW5RNnpkUnlCa1M1SDJHVDA3QU1hbXZCYkxLZ2RhcHFBV2RSTmtNcVpT?=
 =?utf-8?B?aEdDNkxhcG9OQ1lvd1lBZXRlRm9JQWRaMjkrOEdyWi9tZ3QzUnFLQ3hQcGt4?=
 =?utf-8?B?N0wxd3hoaUYwMjQzWER0d3hSS0tKQUhqQm9zMXA4NHJNYU15SDh4RFllT2pU?=
 =?utf-8?B?Rm11Y3JuNExhYW56OVlBOFp5K2dOU0VQMW5xN3FwRit5RlRJN1BkdVl0Sndt?=
 =?utf-8?B?cVdzVnNMaXo4c2YxamdPbkRCVDFsSFZwZnpieTAxby9VYzZzcXozUG94Z0l3?=
 =?utf-8?B?dE9zS09CdG9UNVR5TEJleGZ1cWpZOC93VVZxZmUzbGIvVGVTZTlWN2IwSGpB?=
 =?utf-8?B?ek41Z3hNazdSQks3UXJsTmRrMkdTKzlNcnJuUlFrTG0xdUZVNXNLWmtGN1dz?=
 =?utf-8?B?MURtNGphR1UrcWh3TTkzRHd0MTI0bDk2eXdWeWlJVVVaTnpId1A0SU1ZR2tx?=
 =?utf-8?B?ZkxMZ0xuU1U4TVRtSytDZmNBUGdISUxERjlIUXBZNVhGUXJ4MTFmTDFSNzhz?=
 =?utf-8?B?ZHhjMG5GMjlYd0JOZUJLTy9Ud0V4ZXNRY21ObmdXUCtUaDgxU3k2bytGU1JU?=
 =?utf-8?B?cWlEQ0xRelZwRFZVUlNtYUJLRW1vNXBpa042d2d1ZHh4VFljOXVhNG4yYmxj?=
 =?utf-8?B?d3NUT3BQTS9PaHpOZVVmcjNva2ZPTEF0eWR0eWlQemNkRXhGcjFuTXRVa1lZ?=
 =?utf-8?B?bzlMWTE4TzQ3RW51RXVjMHhSdzlnN3dOSjZFQWszVGxtbkZ5YWdVWkh1LzdQ?=
 =?utf-8?B?RFlSRHYySXJsdkJicUh1bmgxS0VSL3k5end5N3B1Ti96dW9pQlN5ZEttODBB?=
 =?utf-8?B?dDNBd3U4Z3dabXJoQWdCaTZBK1M3U01lOXo1YThDSmVpRmVJcnVBSnkvMXFH?=
 =?utf-8?B?QmZQaDNPTXNoVzJ6V3FDdllVblM0UUduU3U2OHBtZnV6MUVRazUrODJBdGh4?=
 =?utf-8?B?NzNoY1BOTFJ5WWM1MnBiRm1naDRoV3psc0p3MFJHR0FsVDNLVDFrczg0K3FL?=
 =?utf-8?B?eGlkYUdISjlyUmxrOEJLRUtXeWQ5TmU1ZG1BTTZyRDJabGJkeFFZa1htK09z?=
 =?utf-8?B?cTFJMFUwdVdvcmt3Tlg5bUhqcTZKRHRMdHVGZkF4QTJwUXFwL3ZoUDNiTGhy?=
 =?utf-8?B?VlBtRjVENzRONVp5UjFuS3NYQ1J5VXo4R2IxQjR6NkZGLzFXUjhkUUpKWDV3?=
 =?utf-8?B?QkZoL2lZbG1BZVNPN09ITVloNTNHSzN6TnFvcHBtZGszVklPd3Zjb0FpNWhq?=
 =?utf-8?B?UHZWalRQMW5pODFDNjM3b1VseFdpdVV5YzJIbUdUNDZndVZBa1dmUnllcE9x?=
 =?utf-8?B?UnVZbWZJNi9FR3czZzRkbGNlSzZTU05weUZIUXRqdkcvaFBwODRTM2FJeFFx?=
 =?utf-8?B?bDI2MGFRS1ExYnEzWTM1TE9FMlVURnlnTVZiRktJVGdGeXFCN05Nd3g3cGZq?=
 =?utf-8?B?YmdySDUyZnJ4WjFNWUxwaDlKNnh0WkNWd3Z3OG9UVnVQbGZzMFZYRm5NSWIv?=
 =?utf-8?B?S0Yyb1pBU2dKbkJnQTlncS8vUW1CNWdZU0JyRkNlbEh3eWtjRGJXQjZaa1k0?=
 =?utf-8?B?NTg1bkk5SS9ybW1VbWN0Yy9WYU5JZVBwUDFWMWU3cldneUg0bG00a1JGTEtE?=
 =?utf-8?Q?lxjPScEKLNpKW?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WHplTnU3eU5CVjdkaVA4dzFMcHFCRGtSbTR4MndBcjIwSTZIalpVVUw2QXJh?=
 =?utf-8?B?a0xiM3BmMGtOaWFENjg2QzdKV3poZXFGWEQySVVuMUFOUkRFT0tlUFQ1bE40?=
 =?utf-8?B?WjFlYUIxZi9kMXNFQmpFMXJLbUVjVDlUMmhnRzNrS3MyeFpIalpaa0g2OGR3?=
 =?utf-8?B?OGNRRTROVUFLQmp5eVc2bER1anJ0anNlT1ZwZEo4ck82YmthOEdRNmhGVnFy?=
 =?utf-8?B?c01nVWZHV2ZtYy9TRXQ0WVhGaWhwS05YUjR3bGxXMEo0V0ptbHZUdTBseElL?=
 =?utf-8?B?THI3R1J0cDhjTEl1T2VmRndyM0ovQnhXelBXMmJlWmp6TUJmWlVoTVdjMjd2?=
 =?utf-8?B?OStIWXFXTnJYclUxZVFsOU1GOVBVZkRMSGEwNk1SbTZVb2ZnamkwNkJFNDdT?=
 =?utf-8?B?dG5IOUxqcWE0SnpMN3JnMzFhdXpwY05MblArMDVlQi9iNnlwbUttdXhrSFV5?=
 =?utf-8?B?Q3ZrVFluOHYzaWNKRFBDajBGa2xPRVdVZVY2WEFyMFJVQThJUDIzTWNlOTEz?=
 =?utf-8?B?UkhPS3VlaFczUHl4QlNVMDlxNG41SzlLYkt6VlNyYkNhZTcvWEl4N0lNN0ZV?=
 =?utf-8?B?ckpxZkFjSlFnamZTaDI0b0hmNFRKcFZrdnFOeXNBenhOSllsUm1WNnBLK0lY?=
 =?utf-8?B?WDJ4M1daT2l4a2xhK1RuYmRqSVRxYTVUdmQvNVp4K1JmbWNlNTdIaUh1U01G?=
 =?utf-8?B?VDJpY1EwM3p0ME5NMVB4NGVjRENpOFViZHBGNGI4MDlFTDMrcS9YZzBrLzJC?=
 =?utf-8?B?NFNQVUZ3K00vSlRFclpheHIxdmcwNVEzMVdTVjMwb01IbVZIVzJQME1XZ3Zs?=
 =?utf-8?B?SUlTSjNReGR5MFkvamZ1VUJrN1ZiWmNTSHlpOThSK1Iwa0ZJdnlHNGNFMWZ4?=
 =?utf-8?B?S2ZKcTRZRGtOVFVBVDNPTUd0NjBSNDRkVU5iREgvbUh3R0hWNzUrb3BxeVJZ?=
 =?utf-8?B?NmNFOE9icjQ0cFdnSDNjNy81dS9XSlJrMGZMZlRwcm96VmZ2czBRMzZyRjUz?=
 =?utf-8?B?SGFMWlpKN2NFN1V3d1FDdEZob1Z0S1dQdUtnS3dOUVl1eVlLMTUreVJNdkRX?=
 =?utf-8?B?Y2xuTC9YWUhTeE54TkM5SWVEZmZXRlpJOXZwQkFreHdZTGl6bStoUWVPUzJz?=
 =?utf-8?B?MUFkbkVveG92YVpIMlYyNzE0QUVqMHI1bExFa2ZNOTUxd1FrcVoxWkt1dDdx?=
 =?utf-8?B?c3I3Mm5KWWRNNVlhSGg0d0g2bUR3dGhJd0ozZStLN3YxSDBIUVViaVhMYXFq?=
 =?utf-8?B?YjdNanN1QUxTSmFkcTh2L0ErWm1FWlBWRWRLSFFkUTAzaUlndldOODNUSXRH?=
 =?utf-8?B?QmU4NFJ6Uklta2VsTmk0alpDRUJpQ0x5SUZJYmpzMFNRNVlGenQya01IWURC?=
 =?utf-8?B?R0w1L09Gb3FaenFySVJJZERPQ0xVUjRJeWZWT3NmeXZDd1ljeXZRUmxCWXJw?=
 =?utf-8?B?KzhvaXJZYVFuNktWVzRETnd2QU1DcXJjdjF0V1ZOTllLSDdkZkdwYm9xdUEv?=
 =?utf-8?B?L21IZTQrVFVrc1ZBemlGQ0NJR0FQVEV4SUVnOXJpZ3BaTHNzOHZpUUwrWnFp?=
 =?utf-8?B?NWt6c2c1MWJqQkNWY1BocU9HU204cEhYbzhDcTNqRU42ZVRPMDNtczZ5WUdz?=
 =?utf-8?B?RHNnYVRWWC9BTVNDRXlyaVhyMHptNTYvMVhmbDlNd0VxVSsyTmFpclRmTGZG?=
 =?utf-8?B?Z05YRTZvZkxoZ1A1TFJ1cG5CZ3l6V1lHQVVGRllqL2Q2alVmNlZUSHJkS3cy?=
 =?utf-8?B?bFB3OHVZaEphck1MZXhsV2gxbk8xYVNTellkcXE5dlJlQXYwbHl5Y2xndjNq?=
 =?utf-8?B?RmlPVXE5Yi9ML2dzNzFhMVVLakxSUUVxN2w0VW52R0tyM3VBNlpBRW9vRjJv?=
 =?utf-8?B?d0lGczlpRDJRYnZtVTUyYVdrUFZYL2x2WWJMbXAvQml2UXgvTzNEeWNKNFlt?=
 =?utf-8?B?Z0tSQlpmZ3p2QWNuaElOdmgyNGFOem1TSTIvUE5UWWVwMzFocGdaSzFockdm?=
 =?utf-8?B?dFNSNXVjSnEvd2lLRGEzaS9ldUFNY2oxOW9nMXMyYW1SenRFeG5XTFFPdUQ1?=
 =?utf-8?B?VTgyM0JnOWhPSEZGbTVOQ3IydEI1NHVuT2puZmtqdXAwNU1udzFwZm16NkpV?=
 =?utf-8?Q?TaJkLZqF7Dh/dv0S+7+zzYjo2?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6bdde6-3b6f-4476-5101-08dc8482c687
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 10:40:39.0981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fAjHRj8qQcXlhKU2bdRuwq203qXSDfSbG1OhJqAldSCDDPEYeYkzWXWCi2C0XA+PD81XFso19GK7k3ygcIEFmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4704
X-Proofpoint-ORIG-GUID: FAqpu1MwsfO1GxWMrg09NGn2IqsEGSA6
X-Proofpoint-GUID: FAqpu1MwsfO1GxWMrg09NGn2IqsEGSA6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-04_05,2024-05-30_01,2024-05-17_01

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphY29iIEtlbGxlciA8amFj
b2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KPiBTZW50OiBGcmlkYXksIE1heSAzMSwgMjAyNCAxMjow
OCBBTQ0KPiBUbzogU2FpIEtyaXNobmEgR2FqdWxhIDxzYWlrcmlzaG5hZ0BtYXJ2ZWxsLmNvbT47
IGRhdmVtQGRhdmVtbG9mdC5uZXQ7DQo+IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVs
Lm9yZzsgcGFiZW5pQHJlZGhhdC5jb207DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFN1bmlsIEtvdnZ1cmkNCj4gR291dGhhbSA8c2dvdXRo
YW1AbWFydmVsbC5jb20+OyBHZWV0aGFzb3dqYW55YSBBa3VsYQ0KPiA8Z2FrdWxhQG1hcnZlbGwu
Y29tPjsgSGFyaXByYXNhZCBLZWxhbSA8aGtlbGFtQG1hcnZlbGwuY29tPjsNCj4gU3ViYmFyYXlh
IFN1bmRlZXAgQmhhdHRhIDxzYmhhdHRhQG1hcnZlbGwuY29tPg0KPiBTdWJqZWN0OiBSZTogW25l
dC1uZXh0IFBBVENIIHYzXSBvY3Rlb250eDItcGY6IEFkZCB1Y2FzdCBmaWx0ZXINCj4gY291bnQg
Y29uZmlndXJhYmlsaXR5IHZpYSBkZXZsaW5rLg0KPiANCj4gDQo+IE9uIDUvMzAvMjAyNCAzOjE1
IEFNLCBTYWkgS3Jpc2huYSB3cm90ZToNCj4gPiBBZGRlZCBhIGRldmxpbmsgcGFyYW0gdG8gc2V0
L21vZGlmeSB1bmljYXN0IGZpbHRlciBjb3VudC4gQ3VycmVudGx5DQo+ID4gaXQncyBoYXJkY29k
ZWQgd2l0aCBhIG1hY3JvLg0KPiA+DQo+ID4gY29tbWFuZHM6DQo+ID4NCj4gPiBUbyBnZXQgdGhl
IGN1cnJlbnQgdW5pY2FzdCBmaWx0ZXIgY291bnQgICMgZGV2bGluayBkZXYgcGFyYW0gc2hvdw0K
PiA+IHBjaS8wMDAyOjAyOjAwLjAgbmFtZSB1bmljYXN0X2ZpbHRlcl9jb3VudA0KPiA+DQo+ID4g
VG8gY2hhbmdlL3NldCB0aGUgdW5pY2FzdCBmaWx0ZXIgY291bnQgICMgZGV2bGluayBkZXYgcGFy
YW0gIHNldA0KPiA+IHBjaS8wMDAyOjAyOjAwLjAgIG5hbWUgdW5pY2FzdF9maWx0ZXJfY291bnQg
IHZhbHVlIDUgY21vZGUgcnVudGltZQ0KPiA+DQo+IA0KPiBBIGJpdCBvZiBleHBsYW5hdGlvbiBh
Ym91dCB3aHkgdGhpcyBuZWVkcyB0byBiZSBjb25maWd1cmFibGUgd291bGQgYmUNCj4gdXNlZnVs
LiBXaGF0IGlzIHRoZSBpbXBhY3Qgb2YgbG93ZXJpbmcgb3IgcmFpc2luZyB0aGlzIHZhbHVlPyBQ
cmVzdW1hYmx5DQo+IHlvdSBuZWVkIHRvIGNoYW5nZSB0aGUgTUNBTSB0YWJsZSBzaXplPyBMb3dl
cmluZyB0aGlzIG9uIG9uZSBwb3J0IG1pZ2h0DQo+IGVuYWJsZSByYWlzaW5nIGl0IG9uIGFub3Ro
ZXI/DQo+IA0KPiBJdCBzZWVtcyByZWFzb25hYmxlIHRvIG1lLCBidXQgaXQgaXMgaGVscGZ1bCB0
byBwcm92aWRlIHN1Y2ggbW90aXZhdGlvbnMNCj4gaW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0KDQpB
Y2ssIHdpbGwgYWRkIG1vcmUgaW5mbyB0byBjb21taXQgbWVzc2FnZSBpbiBwYXRjaCBWNC4NCg0K
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBTYWkgS3Jpc2huYSA8c2Fpa3Jpc2huYWdAbWFydmVsbC5j
b20+DQo+ID4gLS0tDQo+ID4gdjM6DQo+ID4gICAgIC0gQWRkcmVzc2VkIHJldmlldyBjb21tZW50
cyBnaXZlbiBieSBKYWt1YiBLaWNpbnNraQ0KPiA+ICAgICAgICAgMS4gRG9jdW1lbnRlZCB1bmlj
YXN0X2ZpbHRlcl9jb3VudCBkZXZsaW5rIHBhcmFtDQo+ID4gICAgICAgICAyLiBNaW5vciBjaGFu
Z2UgdG8gbWF0Y2ggdXBzdHJlYW0gY29kZSBiYXNlDQo+ID4gdjI6DQo+ID4gICAgIC0gQWRkcmVz
c2VkIHJldmlldyBjb21tZW50cyBnaXZlbiBieSBTaW1vbiBIb3JtYW4NCj4gPiAJMS4gVXBkYXRl
ZCB0aGUgY29tbWl0IG1lc3NhZ2Ugd2l0aCBleGFtcGxlIGNvbW1hZHMNCj4gPiAgICAgICAgIDIu
IE1vZGlmaWVkL29wdGltaXplZCBjb25kaXRpb25zDQo+ID4NCj4gPiAgLi4uL25ldHdvcmtpbmcv
ZGV2bGluay9vY3Rlb250eDIucnN0ICAgICAgICAgIHwgMTYgKysrKysNCj4gPiAgLi4uL21hcnZl
bGwvb2N0ZW9udHgyL25pYy9vdHgyX2NvbW1vbi5oICAgICAgIHwgIDcgKy0NCj4gPiAgLi4uL21h
cnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX2RldmxpbmsuYyAgICAgIHwgNjQgKysrKysrKysrKysr
KysrKysrKw0KPiA+ICAuLi4vbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfZmxvd3MuYyAgICAg
ICAgfCAyMCArKystLS0NCj4gPiAgLi4uL2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9v
dHgyX3BmLmMgIHwgIDIgKy0NCj4gPiAgNSBmaWxlcyBjaGFuZ2VkLCA5NSBpbnNlcnRpb25zKCsp
LCAxNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL25l
dHdvcmtpbmcvZGV2bGluay9vY3Rlb250eDIucnN0DQo+IGIvRG9jdW1lbnRhdGlvbi9uZXR3b3Jr
aW5nL2Rldmxpbmsvb2N0ZW9udHgyLnJzdA0KPiA+IGluZGV4IDYxMGRlOTliNzI4YS4uNTkxMDI4
OWI0ZDRlIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vbmV0d29ya2luZy9kZXZsaW5r
L29jdGVvbnR4Mi5yc3QNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL25ldHdvcmtpbmcvZGV2bGlu
ay9vY3Rlb250eDIucnN0DQo+ID4gQEAgLTQwLDMgKzQwLDE5IEBAIFRoZSBgYG9jdGVvbnR4MiBB
RmBgIGRyaXZlciBpbXBsZW1lbnRzIHRoZSBmb2xsb3dpbmcNCj4gZHJpdmVyLXNwZWNpZmljIHBh
cmFtZXRlcnMuDQo+ID4gICAgICAgLSBydW50aW1lDQo+ID4gICAgICAgLSBVc2UgdG8gc2V0IHRo
ZSBxdWFudHVtIHdoaWNoIGhhcmR3YXJlIHVzZXMgZm9yIHNjaGVkdWxpbmcgYW1vbmcNCj4gdHJh
bnNtaXQgcXVldWVzLg0KPiA+ICAgICAgICAgSGFyZHdhcmUgdXNlcyB3ZWlnaHRlZCBEV1JSIGFs
Z29yaXRobSB0byBzY2hlZHVsZSBhbW9uZyBhbGwNCj4gdHJhbnNtaXQgcXVldWVzLg0KPiA+ICsN
Cj4gPiArVGhlIGBgb2N0ZW9udHgyIFBGYGAgZHJpdmVyIGltcGxlbWVudHMgdGhlIGZvbGxvd2lu
ZyBkcml2ZXItc3BlY2lmaWMNCj4gcGFyYW1ldGVycy4NCj4gPiArDQo+ID4gKy4uIGxpc3QtdGFi
bGU6OiBEcml2ZXItc3BlY2lmaWMgcGFyYW1ldGVycyBpbXBsZW1lbnRlZA0KPiA+ICsgICA6d2lk
dGhzOiA1IDUgNSA4NQ0KPiA+ICsNCj4gPiArICAgKiAtIE5hbWUNCj4gPiArICAgICAtIFR5cGUN
Cj4gPiArICAgICAtIE1vZGUNCj4gPiArICAgICAtIERlc2NyaXB0aW9uDQo+ID4gKyAgICogLSBg
YHVuaWNhc3RfZmlsdGVyX2NvdW50YGANCj4gPiArICAgICAtIHU4DQo+ID4gKyAgICAgLSBydW50
aW1lDQo+ID4gKyAgICAgLSBVc2VkIHRvIFNldC9tb2RpZnkgdW5pY2FzdCBmaWx0ZXIgY291bnQs
IHdoaWNoIGhlbHBzIGluIGJldHRlciB1dGlsaXphdGlvbg0KPiBvZg0KPiA+ICsgICAgICAgcmVz
b3VyY2VzIGFnYWluc3QgcG9zc2libGUgd2FzdGFnZSh1bi11c2VkKSB3aXRoIGN1cnJlbnQgc2No
ZW1lIG9mDQo+IGhhcmRjb2RlZA0KPiA+ICsgICAgICAgdW5pY2FzdCBjb3VudC4NCj4gDQo+IFRo
ZSB0ZXh0IGhlcmUgY291bGQgYmUgd29yZGVkIGEgbGl0dGxlIGJldHRlci4gT25jZSB0aGUgcGF0
Y2ggaXMgYXBwbGllZA0KPiB0aGVuIGhhcmQgY29kaW5nIGlzIG5vIGxvbmdlciB0aGUgImN1cnJl
bnQgc2NoZW1lIi4NCj4gDQo+IEkgbWlnaHQgaGF2ZSB3b3JkZWQgdGhpcyBsaWtlOg0KPiANCj4g
IlNldCB0aGUgbWF4aW11bSBudW1iZXIgb2YgdW5pY2FzdCBmaWx0ZXJzIHRoYXQgY2FuIGJlIHBy
b2dyYW1tZWQgZm9yDQo+IHRoZSBkZXZpY2UuIFRoaXMgY2FuIGJlIHVzZWQgdG8gYWNoaWV2ZSBi
ZXR0ZXIgZGV2aWNlIHJlc291cmNlDQo+IHV0aWxpemF0aW9uLCBhdm9pZGluZyBvdmVyIGNvbnN1
bXB0aW9uIG9mIHVudXNlZCBNQ0FNIHRhYmxlIGVudHJpZXMuIg0KPiANCj4gT3Igc29tZXRoaW5n
IHNpbWlsYXIuDQoNCkFjaywgd2lsbCByZS13b3JkIHRoZSB0ZXh0Li4gIGluIHBhdGNoIFY0Lg0K
DQpUaGFua3MsDQpTYWkNCg0K

