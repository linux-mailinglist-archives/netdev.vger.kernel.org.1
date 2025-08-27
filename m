Return-Path: <netdev+bounces-217227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55801B37E02
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 10:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8FD460C54
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FB033A03B;
	Wed, 27 Aug 2025 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="kVBEzM/L";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="Am10sdY2"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C668A2F1FE7;
	Wed, 27 Aug 2025 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756284099; cv=fail; b=lavhQegH+WEISh3mYUyMaUUit3HhB1NmBUhGGyEVms4SieLgPEKbrBQl1dpEy0NFjQXlTfng0kx3jTHBExn75O7GCg41/M5yugwzI+0FeSuHPVf9Dy4ISitlRrrGm96BhYRIbG46gjCQCYSqEZNtMttKVGYNX1cgu2x99PGS1Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756284099; c=relaxed/simple;
	bh=WjJiaBrCHCrKcSSPQ0rmF8gDBHoCGUGONsZaxQJKQgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dz0XIcqls8cx7urEI5FJxx1vvkNH3JorK/4UPagz9mPtR9oK9F5E+WQLgNNoEAIUddc9tm7BaW7RQDAAUsgcBHP6Ytyt/Y/g5xd8/wYvW2CP6ftCYd/7wT0lRC79fQM4ZGhVT6utdFKLRu41CnXiWHHEvYEWtm+XRB2LKtE18zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=kVBEzM/L; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=Am10sdY2; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57R6C5lJ2120151;
	Wed, 27 Aug 2025 10:41:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	S1/edIvkc4ltIRGFvgFfWz9noKC0zVh4h4mCJWY+Xas=; b=kVBEzM/LcUnq+mfl
	QQ9Ge4sAUs1JPm8i4GBcWay9snEZvvgk0REAKpy1k8q4UQw8m89TvEHfFkKTmbid
	5owbstw4D7g1am70nu7NLpbAgw95DFbdDGLBBNUqcVulcMT5OOHCGor/THPBfJZ7
	FuJqxby3+wYbN8aNHPo2LgPIMZedh455e21T6b3b3B34jIppP36PdbCVwiU95P1u
	pUt4MAvuPFASvQOtQQY4pctmXIAciNWKiM/XlGH7IL2n+/aoVfAeaamrMyXkj3Dc
	L5Zqzqi1DxKx6URfPNhzTwudOK5LhDMcmFpq3ykpxsfYSxcUQWRg9s9F8ll/NO51
	Oi82Fw==
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05on2116.outbound.protection.outlook.com [40.107.20.116])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 48q32ebxrb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 10:41:18 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMBwbkaGHG80RF2V9Bc3lftTJ7pGHHJ9W/DbPczFYZ71YcRP4iOQv7s7Pfg7soElgbHcHokk+yR+jNQ1Sp50fmMgU2vh2MmkqiqMn/crsJK+8iFvJRKiVFv9wIz9l/yjkFR1u3zkO1jBAPMWFHLd97K+xGQKx2gKUJEJpLtE/vgXvcgv/f1JnQFVaHubYWi0U/aUtbS4GtAbo2sue98lunuSPxaSNA5OC9SWbNe9pIorWiEpOxExn7t8euamKzsdri/li26OjMWfeO3qE4acdnjFVbUKPGeSzWTkp9ndH3dy4iQDgwgjuCRLLys6/x/97emEf8+mgV2s62BB/Vxs1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1/edIvkc4ltIRGFvgFfWz9noKC0zVh4h4mCJWY+Xas=;
 b=Cg4sfEjsUfdfgBOhSZKv7dddFA5f61pA1cB9lP+gXLetW0Rs5PVnRFeAvDr4TDVjJoRw6Zn0xKN91kRRyHdoVoVy7wY4+CIDH6WAsP4z/36ZCm8g/H/fjuM1SH+a+IkPOJsC92InQORHME3jnnkmhqhGJPc0ZuNH6YQ3RfYRozDBgKUBqF3SfKDUU0hn8CjXqPeTHtpnZqQCRQKRQGzMJsjHNMZmizsvP42LnsmAIddHUlczR+pTjg9o7KcWWSDv/GRr27bkO1FAFlCCokkUqHBL6y02Tqr2IEfK2dn+qLn36GoJxl1hnWMjPbgoyKLWYhhA5bSRuBQmy1lCSs+aPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1/edIvkc4ltIRGFvgFfWz9noKC0zVh4h4mCJWY+Xas=;
 b=Am10sdY2kRU4Z4UL1Kt3mA2eK2NDNoqoplYdD8/oIra5kimHYDSfw9EVkMxkzBEzwcEXLUQ4OIGYbJzAk4rrB94RfsiyJutblmSveappBrqjDHTRHqWOy1JGtpIeTh3wurpSPz9P1ubuEDBSfRcwzTYwAWqYJthSd0uEuY6MOto=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by VE1P192MB0829.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:161::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 08:41:15 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 08:41:15 +0000
Date: Wed, 27 Aug 2025 10:41:11 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aK7Ep7Khdw58hyA0@FUE-ALEWI-WINX>
References: <20250804134115.cf4vzzopf5yvglxk@skbuf>
 <aJDH56uXX9UVMZOf@FUE-ALEWI-WINX>
 <20250804160037.bqfb2cmwfay42zka@skbuf>
 <20250804160234.dp3mgvtigo3txxvc@skbuf>
 <aJG5/d8OgVPsXmvx@FUE-ALEWI-WINX>
 <20250805102056.qg3rbgr7gxjsl3jd@skbuf>
 <aJH8n0zheqB8tWzb@FUE-ALEWI-WINX>
 <20250806145856.kyxognjnm4fnh4m6@skbuf>
 <aK6eSEOGhKAcPzBq@FUE-ALEWI-WINX>
 <20250827073120.6i4wbuimecdplpha@skbuf>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250827073120.6i4wbuimecdplpha@skbuf>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GV3PEPF00007A8E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::60b) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|VE1P192MB0829:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e911ff-b27b-40dc-5928-08dde5457bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sm1KNG1KOGQ2WjZzeVIwRFc5Zm9zNUQ5TmNDVUtJTTVjQjUwVzUyU0xiR0lH?=
 =?utf-8?B?VDg5aUdsM0JMVzlFQXh3NlN6ZlN4emErajBSSytuWEhiaGlYV3VnVDNVTWtL?=
 =?utf-8?B?Q2Q3blByeUtLb0VLOXUzUFlsVStkYkt6SjFiZUh6RTNqR05uSWNoQW55VVlS?=
 =?utf-8?B?ZUwvaytCblJ4T2ZHNFl5cjErVkkxejI5SDB3eFBTZXpZOUw5TUF2cHN4eVFU?=
 =?utf-8?B?TG9Ec3MzN1grc3Q3cUtHS1pmNjIvUWs0bFljQ2ZEMkUzQXhZNTFKSXp4OU1T?=
 =?utf-8?B?UDdTSlRpazBQYjNzYVFZOTgxTkwrWlh1VXJkbisxY0hlcitxbWRMWEYyYzRG?=
 =?utf-8?B?YS92T09id3BVdFFsSWMwUFNqL05rdWszOVRKeng2TjBkdXJpZXFtRyt3ZktN?=
 =?utf-8?B?ZlRGNVdCWHFtTHo0RUFZRWhSeSsvcFlRcmlwbXp3aEk2eGV0ZkxPWnBTYmVW?=
 =?utf-8?B?ZUVuRkhnMDVmb1FmMktWdGlvcHZqYVNKWnJXVlNmRU5UUEhJeERiNDhUMlhI?=
 =?utf-8?B?TDJOeGczYjA5OUFJQ0RhQkpWR3VJVlNaRU1FY0xZTnpjeFZVVkZyTFVnQWNP?=
 =?utf-8?B?ODR2TWtNZFVmSUFhelNEVk9LaGNPVXEwWlJrdHd4RkQ0Rzl5bHBVckplSGYy?=
 =?utf-8?B?bERCMVhFNWIyZHhjbXRyOWg1amE5anZZZVBOYlMzQUdhdmIrN0Jlb09kdW5D?=
 =?utf-8?B?ZzZrUDdTbldPVzJta0g5cHhmdGZUQUoxV081dGxRckpGMUErcnljZ2lsUFlr?=
 =?utf-8?B?TFl5eThEMHJ2RURkL2YwSWFDYUdWQnVyUXJUU2t2VW9PVkNFaDZLS0hOTGFV?=
 =?utf-8?B?VnBrNFc1MmpYOXJHdU9NQWJRYSttbHVITXhjWWhVTVRlUGVXVlMvMStVYk0x?=
 =?utf-8?B?M3NWWW9jK08yMk1WSWx3WlFVMWoyMzVFVUxwa1NieVZma1E1Ylp2OXZvYjIx?=
 =?utf-8?B?QnUrVjRkUEJuVlpDbmhLbjJTekFDb0hGb1JVZ2g4MjFwQXNxOGgxV0E0NlNU?=
 =?utf-8?B?Vkw4ZWVHb08xVHFhR1pSVlM2LzFYdG8wVUwwdjlNYUIzRjkxTUpUelVOamx2?=
 =?utf-8?B?Wll5b0x1UEFuSWJFb21tdm15TkJicWxSSGVmM09qTmNGUVNLZ1llSkdRRGJ3?=
 =?utf-8?B?U3JyOUFUUFU4VE9aL0VOM0RlSythMFA0bXcyMTFrVUliTnNzL0tsQjV0dngy?=
 =?utf-8?B?Ri84NnNyK25iVFFPbkhibVBtN2JSN1E3Y2REZ2tZcEs2eWY4aHcrL3Bjc3Na?=
 =?utf-8?B?NFh1RjJRWHRRdlg0aUladjRnbzdqWUd4TFJpSFh2bVhCOXliVE5iVlk4YVZG?=
 =?utf-8?B?WVk4MGtpalpJTjEyMFVNUy83dkx1WHVESitCd0J0OWtNOFprdURYRWhRUnFL?=
 =?utf-8?B?cGdOQUdFc3pNUTJUZ2JtdnJSTG1pdEJTa2ovcjRiU2FZVWJ3QzdmNTA4OERj?=
 =?utf-8?B?akJRRjlVeEpqbUZhdHAzRHlmMWdwQmZIYTRNYXVYYk5pZ3R6S3lDSDlLSGlz?=
 =?utf-8?B?TWtkZnNKWXAyRGQ3cS80SDlkWkdOZXpTT25mQnAybXNUYWJSeU1DYnh6bVZ0?=
 =?utf-8?B?SjlDdjdUYzVPalpKbEhxaElPdzFXOVp4dHRvNFZ4alFOVTVaVmkzbDkybUZP?=
 =?utf-8?B?NzVDWndXc0x3Y1ZoQXBVUlpLMTdsQ3VoVURldnZmNUZGNElJcVFZOFNzeVps?=
 =?utf-8?B?Y3l3UzJYQ2tINTdqV2VVbnNITGJqT3BNdUJsVDhLTWhCZjV5T0tEWnFxN0hL?=
 =?utf-8?B?amx2S1ZHbTV2Q0ZvbXhRWUZzbzVqeXREL3laS0lWTGJ5YkkzNjRsbnBUbDlo?=
 =?utf-8?B?NmlJNkp5bUpzMmpIM0Zvc3k1WjMzdDNqSXI5T0dudHh1L0FVSkcrMjAxUW5V?=
 =?utf-8?B?aUo5OWl5WlpCMmFoUjRFMEs5UWZYUGQvd0hiTFdRSU1oME9iNGwxZXRQWG5K?=
 =?utf-8?Q?b9wHr0Ob41Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vndta1k4MUFHSkN0WE5ycHU5TTF1S3VQejRXblNPbXRjcmFNMXFsaWFCR2lW?=
 =?utf-8?B?aTU0NkxBNUdOK25RYTAxOWZLNzhaZ1ozN2x5RzRvemdKMkdYbFhEeFFSZ3Zm?=
 =?utf-8?B?QmpxVUlIWFZQb09Ucno4SVdYckYrWFZTcnNudTVjVnFFa1VVNVozY1ZoQ29V?=
 =?utf-8?B?cXRrUkFIVUZCUzZUMlhPVVB2elUreGgzdXZkS3dIRXduNW1od2hxLzg0SGhp?=
 =?utf-8?B?dElsRE5pd1B1S2M3dDgwdVFKU1hOOEZQL2wzcUo0Rm9xRnh6azJsN3lmNFpm?=
 =?utf-8?B?bzBQaEVYb3NQOE4yb0pyWHdhNkoxYVFrRVlzVUtOTE9UZFliQ3pVT0xaOW5l?=
 =?utf-8?B?aWVQc0tpT2ovSVRKSGlrMm9tRTZLRitlWW1mQW50TlREUk1ZUlJtcWVFNzh3?=
 =?utf-8?B?YzNtNUQ3ZUJvaXBVeWtQNVYwdHVwRWllVTJkN0ZhZWFFczNzZXBoUkhzdmU2?=
 =?utf-8?B?YmszOHpqSkhESzA3ZU1nU255bnpPa1VGZVlhTG40c2YzbEdkeHNKMjkvTE1u?=
 =?utf-8?B?UElacUltUCtCRm54aGowZW5Mbk1RcnZxZyttR2pIK3BUZVJvb0dBNDlBbGNT?=
 =?utf-8?B?Y2d4MkNrcUVvYVFHYk93OUJRZTh6MkwvSm9wMVNBUm1JNUdwQ053dEtoT2tR?=
 =?utf-8?B?SXI3TDdHNGNKSERiOFBKV3ZOOXNvODZFRTJsQ3ZwSW10eVRGeXd0ZGF5Q1JC?=
 =?utf-8?B?M2g5UElvVUJURE1RSUJVdFB1WE5wSXA3cEswQlRZamROSzRLTVR1bytaT0Jh?=
 =?utf-8?B?OG1ubXhXakp6WjVJODJxcnRYUTEzaml0TVpIbGFOQWVMRDRYQUpxMnVxUUhK?=
 =?utf-8?B?UU5OYUhqVU92OHJrQUdyZlYvUmhhKzNkcHVaWkNnNVFOM2NUVDRmNm16V3k2?=
 =?utf-8?B?blR1ZjEvVHc0UHhTeFRjVEFHTmRaQlZZNnc4QUpEOGE0Zy9CeFJGWDV2TDAx?=
 =?utf-8?B?b0RRRHJkKzVDZW94ckRpVWU3NkxOWjJwRCtyWm1xMU5ORHQyaTE3WTRKaWpt?=
 =?utf-8?B?RnVETmVJdzhMN3dDKy9DZ215cmV0OHVDSENYT2lvYk1nQWs5QVdqVGJYSURK?=
 =?utf-8?B?eEx1Lzkvc0VOUitvSUdkTU9oL1kvY0kxNUIwU1h4cDFqblFrY3p0L2lzeWRY?=
 =?utf-8?B?eStXR21PZlc3VTk0MXU1SWVaVzA3K3VybFBXTEJOZG5iUXVXOWhyWUNrRWxm?=
 =?utf-8?B?aUNKTU5uQ2twWDZXN0xudWhTcm8wQnh4UjZRbTkyb2RpcXVlelVDNkhMNnQ1?=
 =?utf-8?B?THdyQnR3YkMyTGd5M1pLMVlvQnFUeFliakJLc3o1U2Q1eWo5Szg5cndEd0lh?=
 =?utf-8?B?TXZZVUFQRmw3bzNqSWVESUZXSGNnc3pLN1lPd3FYelBtbmRUY3VpeFIwNWh6?=
 =?utf-8?B?NVNXanI0UW1QcFprQ0FTQTVVdkc0elZQY084c3E5dUZubUhhWTBDOVE0VVBH?=
 =?utf-8?B?L2JEYUtvSnlCZ0hUOUY2YklpamFJRTZ0aitCZTFYS242cG1Zc0w2OHA0M3lr?=
 =?utf-8?B?NFJKbmxyeG02Nmhya1VLQnNRbVdmNkw4bU1iblRzVldJcXFvMC80eCtlUnVZ?=
 =?utf-8?B?MzJsKzlYTlhVL2xVcnhZc0d3Z3dqeWRJd2p2Q1crOTBBckRTV3NXWUVWSjJu?=
 =?utf-8?B?M2RZQkhzUXlZMDQwbVBLNXhoZjFLS0pmd0RiR0hTUlhUZVd0cmQya05STERo?=
 =?utf-8?B?RlJwMTJCWFVjU3d1WWE3QkJkblRuOUpuRGlGN2pYUndhL0dZOWZOOUtrTWRO?=
 =?utf-8?B?dlBOZVJFdUJLMEVvVzBML0VzRVhvVDd4aXlIaGlRdzc3Um9Ob3o3L3hOWk10?=
 =?utf-8?B?VC9LSjBJNzZ1cVUvOUhBaWJEc3RkNUdacUNjbzYrVUMwaXRTc0psM2NzeXZR?=
 =?utf-8?B?S1B1QVIrRW5rQnFVUlNXZEk3cU9kQUxubDlmK1dNclhQMklPQVQrdEs1a3FK?=
 =?utf-8?B?UWtHRGhGaXBJdXAyNkh1dVpqQXdQNU80N0ppbUdMTlBOVXFwUzMyVkkxaXhH?=
 =?utf-8?B?MmNHVnJXZkJuUC9wL2RtUERLNysrZmRzUWtVNmlRYUlkSDY2bDBVSXY4Rnhx?=
 =?utf-8?B?eTNxQU9aSlJNMWs4KzBIaHZQdUc1cHJ4VHRvV2ZtcmJEc1BDWTVCSEVCeFU1?=
 =?utf-8?Q?Y+VsnPGICn9EtUrec3VuWClI5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aqm3Ayk9jfk5U1AnDsjwaTokLe3CO8YNw+NHLWU6glXweN4vho96dQe77R3d8EQppjXT5WJsRomeASAQzwxwRPrOnmSJqwPB4mWriKhbhA0nZozxnpvmGVYDufhHbHgCuvIJosbowj+CGiz+vfiuzPdr5V1wk5bGIKlqMBJosEq2tIQp1Jn1zlYFf3gDSd2wv66XoWrxzYISdFXQASnniaI9Ba8eHvXPr1tt1L17Ds+SnygyAidYWfqmdm1DGA+eVpf6Qi0yqldzBwtKmRweuwpqC0YmlwOKdb6Pk275Y6QJ6rlgbo0X9j37PMhKiiyPsh1MCq7Hd7T7c+uV2XTZvyRBCtsrCmIg8ndrtxoovTcE9XIIKiiZUA/S9nCku6a9DKNRmtxvdWesVeu8OHo/dtARpoZ4iVH2AR5SRWpyIYyOeedPYbOAs8U2IxVWu/mk/2uiFOUzG6UMjd5APLvMEHg0dAtAtPLRsQvoKVFATGjZqdXFoq/fMZZME7stpeQ8UvG/67tgewIZKBNBF/YUW5SArGZoPoyKmToq+asHvjyeYMsqC8EhCL1OAlq7mS4vaNZ4oOav05q/J1eOJl2Hkzmm7zJoh2ESJST1RB1eL0QHL7UeH9dF9ZYs7r7vh7YH
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e911ff-b27b-40dc-5928-08dde5457bfd
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 08:41:15.2717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X91x8FMOX62iAYNNmVajThXiFfqTnaOVQtoVw+KVbP83UXG5pl5ZGKBxBwt2q8N5MXI49/m9/ko+fx3nXc+okw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P192MB0829
X-MS-Exchange-CrossPremises-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: VE1P192MB0829.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: H3U1uI0qSTQ2qSBsbMATNu_REOgMRHAD
X-Proofpoint-ORIG-GUID: H3U1uI0qSTQ2qSBsbMATNu_REOgMRHAD
X-Authority-Analysis: v=2.4 cv=P+U6hjAu c=1 sm=1 tr=0 ts=68aec4ae cx=c_pps
 a=X+pbzE9IfnmIeJfM3VPqZQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10
 a=kb6Zq_f-WW3Ge5vyytYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDA3MiBTYWx0ZWRfXy8V7pXDWDmD4
 BvyG6ZDsRFjAy1fbU6kNTHgCJcXEAAR2lxUH5QqSIyrQRZOxy226IgV6P1h98aNiMvoUqzdCaNk
 ZowsiV+hW/sGVUVSL/Eb5zP/Wt/hsPXIQjuP9p3hohqA8Jg1sKzN1GkY03dAZfO3mOrS5rj5G1G
 AdiZj52fpum9BRUPGQX71DZA/ZKi3SL0lUi+VEiMuGUgTHAlkf4+mFoiChPOKPYmLq8I7adoy3D
 zEu5q9oBTgdKGV1MWViyHV3vbOqaxP+3+PuUGvQpJaA0KuSlTM8QsU+tVcz5WZrfWVlyllhdYDq
 a+KyjA/IVGWY0hLb9ENNoR4bq7t186ZByIj+8xeQM70im7hSiws5Ixk/AlQHDg=

Am Wed, Aug 27, 2025 at 10:31:20AM +0300 schrieb Vladimir Oltean:
> Hi Alexander,
> 
> On Wed, Aug 27, 2025 at 07:57:28AM +0200, Alexander Wilhelm wrote:
> > Hi Vladimir,
> > 
> > One of our hardware engineers has looked into the issue with the 100M link and
> > found the following: the Aquantia AQR115 always uses 2500BASE-X (GMII) on the
> > host side. For both 1G and 100M operation, it enables pause rate adaptation.
> > However, our MAC only applies rate adaptation for 1G links. For 100M, it uses a
> > 10x symbol replication instead.
> > 
> > We’re exploring a workaround where the MAC is configured to believe it’s
> > operating at 1G, so it continues using pause rate adaptation, since flow control
> 
> Why at 1G and not at 2.5G?

Good point. Actually it is 2.5G, but the source code does not really
differentiate between them. All register configurations are the same for both 1G
and 2.5G.
[...]

> To be crystal clear, are you talking about the T1023 FMan mEMAC as being
> the one which at 100M uses 10x symbol replication? Because the AQR115
> PHY also contains a MAC block inside - this is what provides the MACsec
> and rate adaptation functionality.

Exactly that is what our hardware engineer measured.

> And if so, I don't know _how_ can that be - in mainline there is no code
> that would reconfigure the SerDes lane from 2500base-x to SGMII. These
> use different baud rates, so the lane would need to be moved to a
> different PLL which provides the required clock net. Or are you using a
> different kernel code base where this logic exists?

That is the problem I'm trying to understand. I've also not seen any code that
changes that. I'm using OpenWRT v24.10.0 with default kernel v6.6.73. The only
patches applied are the ones you've provided to me.

> Also, I don't understand _why_ would the FMan mEMAC change its protocol
> from 2500base-x to SGMII. It certainly doesn't do that by itself.
> Rate adaptation is handled by phylink (phylink_link_up() sets rx_pause
> unconditionally to true when in RATE_MATCH_PAUSE mode), and the MAC
> should be kept in the same configuration for different media-side speeds.
> 
> Could you print phy_modes(state->interface) in memac_mac_config(), as
> well as phy_modes(interface), speed, duplex, tx_pause, rx_pause in
> memac_link_up()? This is to confirm that the mEMAC configuration is
> identical when the PHY links at 1G and 100M.

Sure. I set speed on host connected to the DUT. Here are the logs:

Started with 2.5G:

    fsl_dpaa_mac: [DEBUG] <memac_mac_config> called
    fsl_dpaa_mac: [DEBUG] * phy_modes(state->interface): 2500base-x
    fsl_dpaa_mac: [DEBUG] <memac_link_up> called
    fsl_dpaa_mac: [DEBUG] * mode: 0
    fsl_dpaa_mac: [DEBUG] * phy_mode(interface): 2500base-x
    fsl_dpaa_mac: [DEBUG] * memac_if_mode: 00000002 (IF_MODE_GMII)
    fsl_dpaa_mac: [DEBUG] * speed: 2500
    fsl_dpaa_mac: [DEBUG] * duplex: 1
    fsl_dpaa_mac: [DEBUG] * tx_pause: 1
    fsl_dpaa_mac: [DEBUG] * rx_pause: 1

Set to 1G:

    fsl_dpaa_mac: [DEBUG] <memac_link_down> called
    fsl_dpaa_mac: [DEBUG] <memac_link_up> called
    fsl_dpaa_mac: [DEBUG] * mode: 0
    fsl_dpaa_mac: [DEBUG] * phy_mode(interface): 2500base-x
    fsl_dpaa_mac: [DEBUG] * memac_if_mode: 00000002 (IF_MODE_GMII)
    fsl_dpaa_mac: [DEBUG] * speed: 2500
    fsl_dpaa_mac: [DEBUG] * duplex: 1
    fsl_dpaa_mac: [DEBUG] * tx_pause: 1
    fsl_dpaa_mac: [DEBUG] * rx_pause: 1

Set to 100M:

    fsl_dpaa_mac: [DEBUG] <memac_link_down> called
    fsl_dpaa_mac: [DEBUG] <memac_link_up> called
    fsl_dpaa_mac: [DEBUG] * mode: 0
    fsl_dpaa_mac: [DEBUG] * phy_mode(interface): 2500base-x
    fsl_dpaa_mac: [DEBUG] * memac_if_mode: 00000002 (IF_MODE_GMII)
    fsl_dpaa_mac: [DEBUG] * speed: 2500
    fsl_dpaa_mac: [DEBUG] * duplex: 1
    fsl_dpaa_mac: [DEBUG] * tx_pause: 1
    fsl_dpaa_mac: [DEBUG] * rx_pause: 1


Best regards
Alexander Wilhelm

