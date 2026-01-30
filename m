Return-Path: <netdev+bounces-255141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 92Y7CWWufGmMOQIAu9opvQ
	(envelope-from <netdev+bounces-255141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:13:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF82BAE50
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 98C1C30028FB
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 13:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EE92DC79B;
	Fri, 30 Jan 2026 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="bZ88QVQI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AE18462;
	Fri, 30 Jan 2026 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769778781; cv=fail; b=tXY44KAG0oryEgyolqMg8/cZI6w7RzvV0MKoWjPMo6E0DB/29NJpR38NvcmV9mnP+OIhbxigHkuwt+ojOcxNS9SBcV+gQJoitqUHgXzx8BSZkrMRTEig1dM6QA2gRBtPg8C7lLzKcjfCcRWr/y4ByQiNujGXes260SFCIm1IaNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769778781; c=relaxed/simple;
	bh=lSSDgtlxgM5ny4CvwDE3bz0f49IkkmJxNOYE7Kcr2W8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HVUR7c5riz1JzUGrSo8skobuAv5QWsYAbf2pkaLyycLyypj3L0BbKnNUNK+hYKguX321i6oAFD4THCLxXLdeL7O2YrVz5tCu1KSpG8jm/ewoLNH75/Ej/9lmUQIogCUVccdCV9ezLqZPz1V67jjXQ8z5/8tQNLQ2ObHp8ne+CG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=bZ88QVQI; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60U9tge0367978;
	Fri, 30 Jan 2026 04:58:38 -0800
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020073.outbound.protection.outlook.com [52.101.85.73])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c0tebr9hf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 04:58:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nA+htlmvHbHGb7DVo9RdkQ8o8N4uEeqH0uIAmelKrFTvmcwb6ogvEuwq4QMTSFsi5sdOJbq46YA77r/f0vEyWZp0kYPrGU6U/cvEoOm9mT2Glq8SreqyISTx7eurVC++pGB9A/NfJwjgykPnKKAsXcJfyINPAClKGtH+SmOSFgvoRlsNID/9scCDj21su1Hmny3goyfT1v/bIOnc6GQvWkJYE1NZlbXZ5+a7u+lxTyLS+sXMCt5DD1GaGlqmbQSS8m4Tb6GeHimUpv+M+bJgWJdItOvJH/vnq7yE4qhZKD5omXv0WyAZz/JVsKurMDv9ibgy6lWwOxU5ZiW4x4zNKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSSDgtlxgM5ny4CvwDE3bz0f49IkkmJxNOYE7Kcr2W8=;
 b=v64YSvaEUazWYTqE6ahVJysR8uw+r9akYsPQjmJSDjKYWR/93p2UpwEG+1RMTOPZqQrJn8qTYuwkAaBNr7Sh2D3o/I7cC/egohm3tRqst6C0E5kS5b7BW2ostdBf/kedvAUoFICmSVfpPBx0IiQWeS6YsFUfyZG0ihMslDGCKfndPHLKditVDTzZDgxwQJ3sS7gOaZdI50eUkXghP5AbL7T7ETpFdmDySfb+yBZ7IH4Sqaz/1nLDQ6DfpB0l8MNNXKk2ScQi4KBtLwJBVLmRxrbLXn2rIS1tp70Lo25h8jishhGYZSyymd80kAf+B8pFoyGPBSrUFR9hutlyALy3uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSSDgtlxgM5ny4CvwDE3bz0f49IkkmJxNOYE7Kcr2W8=;
 b=bZ88QVQIEkreLhrxYnMheeSeRO97o1RYsjMCMmrI0PQvoYkL4r+n1FXG8e8msfcvjQ7RHezeH6t+Vy3ilziIgAk209Dqxv0AochQCKEAZmupRrHRzAlDxF7fJYxtCtoOhgyd69WepzYCqsXZ97bUVqek6eXINAXhFajJ7I+wgqM=
Received: from MN6PR18MB5466.namprd18.prod.outlook.com (2603:10b6:208:470::21)
 by CHAPR18MB927687.namprd18.prod.outlook.com (2603:10b6:610:2f5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.6; Fri, 30 Jan
 2026 12:58:36 +0000
Received: from MN6PR18MB5466.namprd18.prod.outlook.com
 ([fe80::bf0a:4dd:2da5:4ab2]) by MN6PR18MB5466.namprd18.prod.outlook.com
 ([fe80::bf0a:4dd:2da5:4ab2%4]) with mapi id 15.20.9587.004; Fri, 30 Jan 2026
 12:58:36 +0000
From: Vimlesh Kumar <vimleshk@marvell.com>
To: Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Sathesh B Edara <sedara@marvell.com>,
        Shinas Rasheed
	<srasheed@marvell.com>,
        Haseeb Gani <hgani@marvell.com>,
        Veerasenareddy Burru
	<vburru@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Satananda Burla <sburla@marvell.com>,
        Abhijit Ayarekar
	<aayarekar@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH net v1 1/2] octeon_ep: avoid compiler and
 IQ/OQ reordering
Thread-Topic: [EXTERNAL] Re: [PATCH net v1 1/2] octeon_ep: avoid compiler and
 IQ/OQ reordering
Thread-Index: AQHccLlQ3GvyfvdkTUyVidEYACbE+7U42zwAgBEqDZCAIOjOEA==
Date: Fri, 30 Jan 2026 12:58:36 +0000
Message-ID:
 <MN6PR18MB54667119674AC692ED7EF978D39FA@MN6PR18MB5466.namprd18.prod.outlook.com>
References: <20251219072955.3048238-1-vimleshk@marvell.com>
 <20251219072955.3048238-2-vimleshk@marvell.com>
 <eed3d1c1-7b7d-4aea-a816-2046cfa88529@redhat.com>
 <MN6PR18MB54664C5630DDD9D2D1380495D382A@MN6PR18MB5466.namprd18.prod.outlook.com>
In-Reply-To:
 <MN6PR18MB54664C5630DDD9D2D1380495D382A@MN6PR18MB5466.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: pabeni@redhat.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR18MB5466:EE_|CHAPR18MB927687:EE_
x-ms-office365-filtering-correlation-id: e451f39a-4e61-4f14-9693-08de5fff4808
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TXc1SmpxQ2tmbzhubmZNbnJxdXRuZitMZ0Z4ZHRGM01WNlZweUsramFrMkRD?=
 =?utf-8?B?Y0tGWDFXemNJbGV0bVhuWnpaOXNsYnFNODZHMUk4Y3krUmhlOExadkVjTnhM?=
 =?utf-8?B?eUhpNHM2Wmo0eE8ydUN0WnFXZmd0OWQveGdINllVSGRVWGx2TUI3dWhEMHZK?=
 =?utf-8?B?M3RvVGNkclQycjJUTmxGdW55dzVUNFk1VFROM3VONmR4b2MvM1VzY3g4RG5h?=
 =?utf-8?B?dGllanVlVFl3QjBsY0ZkY1VGZjZsWHdBWUJ5aHpkdkErem5FUFR0eUlYalRh?=
 =?utf-8?B?WWhsckVQbldTc2dub1lTRXZvQnVIb1Y4Qm55K25mblZoTnp1ZjhXNTdaVmpI?=
 =?utf-8?B?ZWdOYklVdUh0SU1RTEdWdldtdXV3SGJKeUd0ZzJNRDZwdm9yRDNyNmdTUXdB?=
 =?utf-8?B?dTBnQktQNXV4M3M5Rk9GOCtFWDI0alZVeFh0SkgvNGtHOFRvOTdtaHRiTXhC?=
 =?utf-8?B?bmhRQUUwWFQwOFVYeW1reEFpU1g0ZVU4bndOUTJJdzYrSGFwNnEzTzJXdkNk?=
 =?utf-8?B?cWFPamNuUUJUcndCTWFYYlNVRlY3bTVlU0RVUlU4cFlxb0d1aVRNSDA1V2lX?=
 =?utf-8?B?MGRZblpBR2tNWkwrYnVncitPeVV2M2pRN3JGeWFWWkRmMFBDVGxOOVVyQm5V?=
 =?utf-8?B?aXl3OHM4RDMwSGc4NEhRRU9oZ2RyWXh1ZzQ5a29uK1gzOUVEd3hpckJOekpi?=
 =?utf-8?B?R0kzQ2kyMERMMVJGdFlaNi9LdlByVFB0czJRZkNadFBnSWVFTU5scmtUTHh6?=
 =?utf-8?B?eHIwR0xKUkFxTldkNlFVZVNuVktMT2ZoWm1TK2pSRGZOaHZmWDRxODVPS1c4?=
 =?utf-8?B?VjNCc3BjV1VRcVROK0FtaGxTZGRyalRJcW1GOWFZTHg3WmtwUGZJcGhBdWZ6?=
 =?utf-8?B?K2VPUjEwL0hlWWl2ZFR5YnFmWHpib0lPa3cyeXUvNDlMRnY5bFJGNUxYL2ZW?=
 =?utf-8?B?MWQ4bVlhbWdjZGhxSVcvcnlNWnBLcklxVmdqUVhDa01PbjlGWVUrSGdXTWRp?=
 =?utf-8?B?NENGd2N2WTdrejZLYUQxaThFejVHZWFyZ1BxSTZjNDFjd29VL080S1FVTDhu?=
 =?utf-8?B?YWxGWDZ5Q2YzNWZuSWhCSDBjSXhaU3dHbVNIYk5yTnFjYjdRUFpYOVdzZ0pv?=
 =?utf-8?B?UlRYNFRuM0l1MUtsOUZQd1Irdk1VbkdNMjQ1dDhXVUFjNndjRDBpeHhyT284?=
 =?utf-8?B?KzI1Zi94bDcvWEIxbFVSVUdWYjJvMW1VMk95em5pVDRRM3ZkTGJwRmRrWDA4?=
 =?utf-8?B?VmlWTExYN0IrY2I4eHlhUVh5YVlRSmdSbmRlMEg3TVBBU0x6Rmc2RFNTWVBi?=
 =?utf-8?B?ZmxTV1dPMEdZVFQwRG05dVZHQWRDRFNnaktVSnBiZEZrUzZXT3lZN1lGY1Z2?=
 =?utf-8?B?aWVoTkgrQWdDRnJlUlpHZ1grSWhEK2hsZ3RmM3RQUjBDRFNSejJZRjkvaG9Y?=
 =?utf-8?B?NG5oYm5BSWVva2hRdFVXM3gyQkwvaWlCc2lxSHJXRkEvRmttM05zT2dSenJn?=
 =?utf-8?B?VGluekltY2E0dUR4bUxWajVoVzBsOWd3R2E1cTlLaXJJR1VLdE5Pa2tQa1VY?=
 =?utf-8?B?Sy8vQjNPNnNubHBpc3BFQUVNbEpxTlRaNmw4THArNFV6WS9Jb0FzdFUyMzcr?=
 =?utf-8?B?L3owUlhnaE1JbEh2YVI1bWppMEZoRFA0WUlKVlVad3k0VkEvTEdvRG5hbk9X?=
 =?utf-8?B?c1FLV0hsbjdSMGcwZ2lScjJoeWtXL2RNYXNGR0RqeURzOGxHUU5LN1d2VTh3?=
 =?utf-8?B?NVl0TEpiOSt3TUxxM0NTY0IyOUJ6Nmd0SUx1TTB6MEtNUE43bWlNS3JRL1BF?=
 =?utf-8?B?dm5kclRJb1BZcDNiOWd5ZXIzMmcwRHlIRG13RGRSZFBkVmJqT3VTdWdXQnZy?=
 =?utf-8?B?L1I1TnBqQU9aSkZTRDd2U0ttODdtV29Ga1J1WW5YelhCcElCY2FuazlRaDNW?=
 =?utf-8?B?UEF5VXBhYmpaTklmSUJ2YVFYdnJ2QkhEdFpQUG5EQ3ZKWTU1ZHpBRXpGMUYr?=
 =?utf-8?B?TndORFVXZVoyU0E2NVN1VnVFUTVTVytnQ0VGNURNRmxhQ3JsNTk4REJhclUv?=
 =?utf-8?B?dTgxNHZPOTN0TGY0UXpIUHRQdkE0clczTTU0aUJHNWVvSGRLZWNnSUlaQ0lw?=
 =?utf-8?B?MkxWMWFwcGZqM1YwRVlITjUvTU5KRXR6V2ZEMFYwK1JHMFdXZ2NkVkE0RUxP?=
 =?utf-8?Q?/zIT+6pwXVZUMZuWtNRzXn8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR18MB5466.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGgrRTdXOHUwNkdTZ0QxTnF0RFpRQkxWYVhIcURrYUhOQU1FZUd1VkxnQkE0?=
 =?utf-8?B?UDZ4NDZGOVc1NGtQSGQwYWdoT1BVZUx0WWVjcXVDcnAzM0pqSElkdmkvem9s?=
 =?utf-8?B?aG4rOWJUb08vdVdOTWYwQWpMWTZKOS9DbzIrQXkzaHRHRXd2c0dBbTI3SmZC?=
 =?utf-8?B?aTlVV1ptM0dVMGFuODZNOXVGRzhGTzZqRVBIV1lIWG9LMUFvYUx6U1ZveUpv?=
 =?utf-8?B?RUVzZFhKWktuaVhYci9mK1lId3BXcFd0ajRHRTZXZXdVaGhwRWYraWZCaysw?=
 =?utf-8?B?Yjk0SzRWenIyYXpPY2xlNXg4dUc1UU80MS9pTitTVUZiSno0ZjhwYTFuNkNY?=
 =?utf-8?B?dUV0dXV6dXE4aVFkalJHekpsYnRSOEhEdHpVWVZBVWxXVzEvaTUxZXVwVGxP?=
 =?utf-8?B?YnNnaU9hdEo4bkN0dlpqQlpTZ1VBUWdCTm1pclNkQ2p0MHRIRk9tbnRkZnYr?=
 =?utf-8?B?Z09pT25YTVdWWlZYQ2wrWjdQOGlXVnpkdFo0elFEYU4wZnRxbGpFczFIb0ln?=
 =?utf-8?B?TnF1eGgrRXQyVU1TV2JGRFkyT3hVOXFXM2FTenJtc0dnbklsdktOZVYwQmov?=
 =?utf-8?B?LzQvVEFFeVJ5dm0xN1A1UWFEeVJUdlJJaTAySkczb0hGOG0ydUJJMmxyYVBI?=
 =?utf-8?B?SW52YUI3U3JrSU9EQ1I4Y2E5bkFTTmdxRmRxYUt4dlBCM0dvU3VIanFRL1Mr?=
 =?utf-8?B?SWF5aGYxKzFPTEZkT0NGOXVYRllNU2R0TFAvc1FjZHY2cjFaRlk4NFA5bG1Z?=
 =?utf-8?B?SFRpSkF5dGdNWWRMMUlyR2p2aFN6ZFg1M2xkU3N3QmRvVE1jOG9SRWdxY2No?=
 =?utf-8?B?YkQwTVptZ0JlK3d3TUtvMVdzNDkvWlVncWsveHlWeXlKVDZiWVpLYW9DZndw?=
 =?utf-8?B?SmZFTFlVNUJaVnBsU1hObXJKMEpZbU00dGFzQ1FWL1orOGRyZlFJTmJmT081?=
 =?utf-8?B?eHQrbTdpTm9EWWFnS2RWald3VEJkSzZSM2w2TTVPWUw3V2oxLzVsNmJ4NHV2?=
 =?utf-8?B?QXpPL1kxMUc5NmRNTGNEcnJqenkyK0I4bmltMUI4YzViUnUvTmRCMHRzeGlN?=
 =?utf-8?B?TURDdWJEM1QyUkdpNCtXdFl2QzArbW9RNU1xZGpxdG5zMUlwVkN1dzdhVk5y?=
 =?utf-8?B?cUV3eEpWQUl0ZWQ4TnBRb0V1M0hYSVVheEF5ZzFHZTJRT0xUanhMZnVWQlJx?=
 =?utf-8?B?UDNweU1yU2pEQmVIUnM5cDFjbjJKNmNyaVFVSkxXUlphNG5ZTWRySWcvSzdC?=
 =?utf-8?B?MDFBMVErL0xoTkw0ZTNxdHVVakhCdEI0dXFvZVpQTUc0RzBTQjFtaEVJREJs?=
 =?utf-8?B?Y3lUa1prZS9kNStzbHFSTTdVNklrUzVxQlZ4aXBDZyt0THpmQ2hRSTR5NkpU?=
 =?utf-8?B?YkpsaWxVcVJEdldmSzJHMURjK1JidTl0aWVwSGVVejcwMFp4MFJ3QmtpVFBH?=
 =?utf-8?B?NDhGc3c1Z1JxcVJFSTBHRmVucmtFcC85RHJ1QUpGaXlZdys3Rzhva1NHTDlJ?=
 =?utf-8?B?RUpVazdTVnhKV0RXUHdOd1dodUhoMHpVQnhXZDVwNVdaYWZrVlJEc1lsUW1m?=
 =?utf-8?B?aFNPcDg5SE5yOUphU1FwbVYxMk15K1Fjc1ZkcE5xMWVKUEI4TEIvbzR0eko4?=
 =?utf-8?B?ZUZVZFJ5b1pEMUF2VitGSi91QTZpdXE3NVFCbWlMdGYwVDVtTWRXWE5CdGJB?=
 =?utf-8?B?aEpDb3BEZi93c0NTTTNRRXhBZnIxT1YrVVVTSCs4VjVBT29BcERFTUZLSmR6?=
 =?utf-8?B?Znltc3UrQ2lCVC9LZTRscDRQdkhUSkFDNVQ2SDlZQWd1SEJ5SCszTUxzRVpO?=
 =?utf-8?B?MUNmRTcvL0JadGpyck9kYVAxeFJMb2JWckUyZVJKcXZzM2dRUGZuUTV0dXZH?=
 =?utf-8?B?bzhPSkZnNnBKc1JKQy9ZYjB6dmExRTdnakp5RVlueUZMTzlUckVSZm5obnh1?=
 =?utf-8?B?angrOTkvZUt5SE1PM1Z0Z1ZiMm45WTBEUXRONEd0MHhKc3NmckJXZGdFS1hC?=
 =?utf-8?B?R25xZXpKTFdqNngxVU9ibWF0dklOcWJXaXRJYUc0b1NscFVRQ25IMjBNaUhj?=
 =?utf-8?B?WVJPZHhPN2RyUmR2VDN0aFViQ0p5QUhSV0JSWmZzS3FBMTlIZVNmOENRNmkv?=
 =?utf-8?B?a3R1MnRHamFOY3pFN2ROWEwxb05zNWhKcUdxYVErZ0lhL2NnZmhKdEtYUXpB?=
 =?utf-8?B?amFLTDZqZjMrT3JvYTMxai9QZXRQVkNKdEJVcHNQdUZ6dGpWbng5c0djNkRk?=
 =?utf-8?B?VEs5RDJ5SXYxTUx2Sms5MTdrUGgxNytIQ2R2N2piSWlyQVNLZEo1TUs2Njg2?=
 =?utf-8?Q?oLO616jSfR+o9KtFxB?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN6PR18MB5466.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e451f39a-4e61-4f14-9693-08de5fff4808
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 12:58:36.2566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +TlGUefyl9YQMv6DGOrdVOjhdfMvGlQ8KS80I/mRKZSY1u8Y3exJqwZSzhYpzcsppvRFydzClzTooEviP+0yFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR18MB927687
X-Authority-Analysis: v=2.4 cv=fc2gCkQF c=1 sm=1 tr=0 ts=697caafe cx=c_pps
 a=n24abkD4YvNTwWi8vj4pqw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=J1Y8HTJGAAAA:8
 a=1XWaLZrsAAAA:8 a=7Cb5CqFw8F6bGotzHgcA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-GUID: aPJtW6yNIKxKlq5X3L0OjFUpvt23KmUB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEwNSBTYWx0ZWRfX1GPGaI6dFr2B
 reswEUB6NslgS5oBud4GmwcwR+yb66B2VUo5ZGGHUDkQPYYcDXkPJxGXp7mlwrRmRsAvzUkFFH8
 rR86TQvXHf6ksNswHDm9ApUFUoSpjouwthlvZ826TYYUwQoYs7ViDEmExdA4HZSI6QpE233nmAA
 HovXEqt9ziqHNqkf89v0VdqFgjZsv6UD0UIVAjl16KeWYAxNfIEZ8bLhzDuovg/fMZ3PSqd3dJS
 ajCIwVpU87pC2pqNkLS0aGd/qg/koQJz14EGq4JsusJt69cYCt3OQ/X6CoxobU+h6yJkhyxelbN
 KengpKxsVF01ae8+Ha1P8OmgEDSqz+N+cz4kiZwZO17x/xEgMVhEaC6618cHBZ8rPDoBhsG9tbJ
 JgUFnKxm6zYzXMN7+HlYiN06UgFBej+IDDH82D14f5tnqKUD4CyA7FSXpILNOPbhpDfRTgbH5nE
 buN0xM+brf9TQDo9OmQ==
X-Proofpoint-ORIG-GUID: aPJtW6yNIKxKlq5X3L0OjFUpvt23KmUB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_01,2026-01-29_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255141-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim,lunn.ch:email,davemloft.net:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vimleshk@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1AF82BAE50
X-Rspamd-Action: no action

SGkgQCdQYW9sbyBBYmVuaScsDQoNCklzIG91ciByZXBseSBhZGVxdWF0ZSBvciBkbyB3ZSBuZWVk
IHRvIG1ha2UgYW55IG90aGVyIGNoYW5nZXM/IA0KDQpSZWdhcmRzLg0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpbWxlc2ggS3VtYXINCj4gU2VudDogRnJpZGF5LCBK
YW51YXJ5IDksIDIwMjYgNzo1NiBQTQ0KPiBUbzogJ1Bhb2xvIEFiZW5pJyA8cGFiZW5pQHJlZGhh
dC5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiBDYzogU2F0aGVzaCBCIEVkYXJhIDxzZWRhcmFAbWFydmVsbC5jb20+OyBTaGlu
YXMgUmFzaGVlZA0KPiA8c3Jhc2hlZWRAbWFydmVsbC5jb20+OyBIYXNlZWIgR2FuaSA8aGdhbmlA
bWFydmVsbC5jb20+Ow0KPiBWZWVyYXNlbmFyZWRkeSBCdXJydSA8dmJ1cnJ1QG1hcnZlbGwuY29t
PjsgQW5kcmV3IEx1bm4NCj4gPGFuZHJldytuZXRkZXZAbHVubi5jaD47IERhdmlkIFMuIE1pbGxl
ciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMNCj4gRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xl
LmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+Ow0KPiBTYXRhbmFuZGEgQnVy
bGEgPHNidXJsYUBtYXJ2ZWxsLmNvbT47IEFiaGlqaXQgQXlhcmVrYXINCj4gPGFheWFyZWthckBt
YXJ2ZWxsLmNvbT4NCj4gU3ViamVjdDogUkU6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCBuZXQgdjEg
MS8yXSBvY3Rlb25fZXA6IGF2b2lkIGNvbXBpbGVyDQo+IGFuZCBJUS9PUSByZW9yZGVyaW5nDQo+
IA0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBQYW9s
byBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+DQo+ID4gU2VudDogTW9uZGF5LCBEZWNlbWJlciAy
OSwgMjAyNSA5OjQ1IFBNDQo+ID4gVG86IFZpbWxlc2ggS3VtYXIgPHZpbWxlc2hrQG1hcnZlbGwu
Y29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsNCj4gPiBsaW51eC0ga2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiA+IENjOiBTYXRoZXNoIEIgRWRhcmEgPHNlZGFyYUBtYXJ2ZWxsLmNvbT47IFNo
aW5hcyBSYXNoZWVkDQo+ID4gPHNyYXNoZWVkQG1hcnZlbGwuY29tPjsgSGFzZWViIEdhbmkgPGhn
YW5pQG1hcnZlbGwuY29tPjsNCj4gPiBWZWVyYXNlbmFyZWRkeSBCdXJydSA8dmJ1cnJ1QG1hcnZl
bGwuY29tPjsgQW5kcmV3IEx1bm4NCj4gPiA8YW5kcmV3K25ldGRldkBsdW5uLmNoPjsgRGF2aWQg
Uy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYw0KPiA+IER1bWF6ZXQgPGVkdW1h
emV0QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsNCj4gPiBT
YXRhbmFuZGEgQnVybGEgPHNidXJsYUBtYXJ2ZWxsLmNvbT47IEFiaGlqaXQgQXlhcmVrYXINCj4g
PiA8YWF5YXJla2FyQG1hcnZlbGwuY29tPg0KPiA+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQ
QVRDSCBuZXQgdjEgMS8yXSBvY3Rlb25fZXA6IGF2b2lkIGNvbXBpbGVyDQo+ID4gYW5kIElRL09R
IHJlb3JkZXJpbmcgT24gMTIvMTkvMjUgODoyOSBBTSwgVmltbGVzaCBLdW1hciB3cm90ZToNCj4g
PiA+IFV0aWxpemUgUkVBRF9PTkNFIGFuZCBXUklURV9PTkNFIEFQSXMgZm9yIElPIHF1ZXVlIFR4
L1J4IHZhcmlhYmxlDQo+ID4gPiBhY2Nlc3MgdG8gcHJldmVudCBjb21waWxlciBvcHRpbWl6YXRp
b24gYW5kIHJlb3JkZXJpbmcuDQo+ID4gPiBBZGRpdGlvbmFsbHksIGVuc3VyZSBJTyBxdWV1ZSBP
VVQvSU5fQ05UIHJlZ2lzdGVycyBhcmUgZmx1c2hlZCBieQ0KPiA+ID4gcGVyZm9ybWluZyBhIHJl
YWQtYmFjayBhZnRlciB3cml0aW5nLg0KPiA+DQo+ID4gUGxlYXNlIGV4cGxhaW4gd2h5IHN1Y2gg
X09OQ0UoKSBhbm5vdGF0aW9uIGFyZSByZXF1aXJlZCwgYW5kIHdoYXQNCj4gPiBjb3VsZCBiZSBy
ZW9yZGVyZWQgb3RoZXJ3aXNlLg0KPiA+DQo+ID4gSSBkb24ndCB0aGluayB0aGV5IGFyZSBuZWVk
ZWQsDQo+ID4NCj4gDQo+IFdlIHVzZSBSRUFEX09OQ0UgYW5kIFdSSVRFX09OQ0UgQVBJcyBpbiB0
aGUgZGF0YSBwYXRoIHRvIHByZXZlbnQgdGhlDQo+IGNvbXBpbGVyIGZyb20gb3B0aW1pemluZyBv
ciByZW9yZGVyaW5nIHJlYWQvd3JpdGUgb3BlcmF0aW9ucy4NCj4gVGhlIEFQSXMgYXJlIHVzZWQg
dG8gYWNjZXNzIFJYIGFuZCBUWCBxdWV1ZSBjb3VudGVyIGZpZWxkcyB0aGF0IGFyZSBzaGFyZWQN
Cj4gYmV0d2VlbiB0aGUgT2N0ZW9uIGhhcmR3YXJlIGRldmljZSBhbmQgaXRzIGRldmljZSBkcml2
ZXIuIFRoZXNlIEFQSXMgZW5zdXJlDQo+IHRoYXQgdGhlIGRyaXZlciBhbHdheXMgcmVhZHMgdGhl
IG1vc3QgY3VycmVudCB2YWx1ZXMgZnJvbSB0aGUgaGFyZHdhcmUgZm9yDQo+IHZhcmlvdXMgUlgg
YW5kIFRYIGNvdW50ZXIgZmllbGRzLiBBZGRpdGlvbmFsbHksIHRoZXkgcHJldmVudCB0aGUgY29t
cGlsZXIgZnJvbQ0KPiBvcHRpbWl6aW5nIG9yIHJlb3JkZXJpbmcgcmVhZC93cml0ZSBvcGVyYXRp
b25zIG9uIHRoZXNlIGNvdW50ZXIgZmllbGRzLg0KPiANCj4gPiAvUA0KDQo=

