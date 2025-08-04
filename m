Return-Path: <netdev+bounces-211569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140E1B1A2CC
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 15:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69AA1637ED
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 13:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA9025DB0D;
	Mon,  4 Aug 2025 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="nqK5jojY";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="c6hLDekq"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADE71E5213;
	Mon,  4 Aug 2025 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754312553; cv=fail; b=Z10gQ+5VdubU2XfsCXc8XAt92nvt/BsR3+b8RIg7OsdVIN/597SsB4PEJ/ipHGDCLjDHHKuS++EM9ayniKZUYF7ota+feCzTxs0AWPY75wR+cyNMxRMGcWkpwspmIViQIaX6vTEPCZPt6cIYHx/LGW5RL7Fr8hMrAI8QpW7NjRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754312553; c=relaxed/simple;
	bh=nhQWAHXTgmMYV3tbv0l8O3peN4YTqKoBuETaNx0N4DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZVt5i4zZUqCglxtOyrSSOWbomwK5jNU+t0Dr+bMb4SF6UhNcH6jPM1W4zrRcS58puXkWD6bFjJ3PSu0Uu5iwpkCNOPhRPQFncjhnFAnjxRhvaXXTxC88dGRF8JZR7PohYM7FcGnVoQ/ADy+uBdUXZ+jmugtVT7F0AJJVi+Os5Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=nqK5jojY; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=c6hLDekq; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 574AgY7B1058478;
	Mon, 4 Aug 2025 15:01:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	su+2YnzJRtTeWm2Tw1QzGmNtyG0aPc7RN0TnkN2d1zg=; b=nqK5jojYxPnxVd6e
	6pbXqX/UNuI1m5euL5MDIiYaMGXUd+laEcOHDDKHAUBIch3P09Pp3xNZ/PhI1gqT
	AQBej9gsmV0HDW3TnQQJyOnMFXN+0HdF6nTBYg3SyRVawTFlH0cTd0CiIpp+GDVR
	Hi0vMnRwtjBlXICOKU7qHp3gA2yNXLYlYPCWw9JXsTSg+98ZhlMjoJYx6tfxvahb
	nguou12p9GcfHmZszDgjjyL6SfSDXqOCvEpb+0FXVPpreCw7kfn92Y9bLTXV6++8
	Dk4MgPW2qXVE05wjd89XyjOoqf2OjA1Jr92hAMnWIQC14QEUE6k1vlEys9P2mMtP
	wf+5rw==
Received: from eur02-vi1-obe.outbound.protection.outlook.com (mail-vi1eur02on2093.outbound.protection.outlook.com [40.107.241.93])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 48971a1vsq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 15:01:52 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+Hd3Bx6sGfYqFQ9Gng9MJllf8wzqwsCgExjH64ddiCRtNA7rarWsxbT4t2eQPIqIHWuD8jV+Y0TSpEFCWilLrjr5UKuNc8FiS5y8kM6HTZeMevmSGUW9fdsoEv/0nZWL4iFUyhVPYKb8FgLxnJas4bV3TBJHgJEYFfTxZAXasQE+Pv14opsKw1qJG/nhrVAgiewu7dudX4pYK9FBunKWbCDgSGe471e58nPnsSpOpO0XDckC6+xOCkfqtZ8rwci9MkqTbX5vsmcXqtr/Rnxf1Urx5Wcb6zkj7HNtanhs5wmHYxO5I7HSM3YfGeUfCgC6K5Jem6dl/+Dehg6sR6mmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=su+2YnzJRtTeWm2Tw1QzGmNtyG0aPc7RN0TnkN2d1zg=;
 b=KV/0xhDDc9U+hUQtm9SJmI/YtZwZdUYY6CoJp2JbRogfZOnoz+r1yAf9fSIb785gMCLQ519xDi9HuujtWJtn6QE/2ryWjdwPyVYjGIUOul8uuO1Uxm9NIwE0Q4j5HKPLxqNz8kqcKXrV3/UMijhSoIGOfB18/Ar8WKP69GwVZEzCGR9oYZ1VxvbxuzdaW+85y78UF9029Ub69ZpUtJVyWR2wB1pPXa5uecyqpxAuK1NY0fwWMt621UvcPqe5wrgm3nhADb4zy/hsuQzc/xeACMRRSSClXoS8Y1GkJU1sPL2ruFtlUR2ehjaXZYmiFqUvSzaAXwCOpyI8ldbUZMBStw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=su+2YnzJRtTeWm2Tw1QzGmNtyG0aPc7RN0TnkN2d1zg=;
 b=c6hLDekq4poiOKA/A2szQeKBXZp66cbUUMwkz+PUSMy+364I9+l2DIV6P3fWOajTfkuV0k31IjhBbt3QIy0Ve9emylWwon0hi7ApScAwAB1Ry/H1TSN+KgdnwnB+xaiYcL4PpxpTZXNDRcPy0FbQspO2SWJuw6sMqhp3he0cuFw=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by PAWP192MB2511.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:4c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.12; Mon, 4 Aug
 2025 13:01:51 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9009.011; Mon, 4 Aug 2025
 13:01:50 +0000
Date: Mon, 4 Aug 2025 15:01:44 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aJCvOHDUv8iVNXkb@FUE-ALEWI-WINX>
References: <aJBQiyubjwFe1h27@FUE-ALEWI-WINX>
 <20250804100139.7frwykbaue7cckfk@skbuf>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250804100139.7frwykbaue7cckfk@skbuf>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: GV3P280CA0014.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::29) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|PAWP192MB2511:EE_
X-MS-Office365-Filtering-Correlation-Id: ec1b4b60-8aff-438e-3ccf-08ddd35713fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZE04U29ZSnM3SkZYelVrRmlQR0cxOVNNMFpobFVaZ0paN01nVDZHUlpIaGlQ?=
 =?utf-8?B?M2oxeVZ3aHd0WEtiWjZKYmRjVjdiZENndXBaOEczMlR1b1o2S2VNN0FOa05M?=
 =?utf-8?B?TmhjYWw5SU9aakRUcXdYVXJzaW1NOVErSTNhaUFGeFRRNlEvYjBlV25UdXda?=
 =?utf-8?B?ZVUvV0JNR3BYajJCVmRJSDJCQnVKbGlOVWYyYzVhVmJ5Q1FqTEVzN3MzNVg4?=
 =?utf-8?B?TGF4aUQyZDVvQ2N4UG1LbE54bFVHV00yKzlwVUk0M3p1VUVuL2k3dSt4clVG?=
 =?utf-8?B?anpvb052K1NNSEJuMXVvRzgvQVIwVUV2c2JvSXBtaTFWQVQ1UFF5bkZ2SU1r?=
 =?utf-8?B?MzhuOFV5Qmo5cEh0SVRsWVBqeitPN1pNdGFaTEc4SEhudi9MaStYc1BZUlU4?=
 =?utf-8?B?eWZXbE15MThuZ2dLVDY2aDFFV0pNYkphK2FBY2ZVUGNVdU1ESEEycEJIc3py?=
 =?utf-8?B?SklJTTFNaWloOStjSkx5VEFpekIwSEVmdUh4T3c5N080RXBhTlRiMmVhV3VX?=
 =?utf-8?B?WlNKTlo5Nmc2a1IwVmNGUlFYazY1emR4RFBxeUpsYkE1emhDQzgzRXN4L01a?=
 =?utf-8?B?WnZWTXJYZStkR1dmbW1IV3pKUFY0WjB2UmZkQmZtaUVaWjdKYXNXWmJJMWxS?=
 =?utf-8?B?Z0hNS1p6NG4vckJaOHkvV3ZRS3ZLeDMwZURZUmlWdWY2aGczWEt0aE1oRDR4?=
 =?utf-8?B?MHpIZG9EbGMvejlRZ2JoVkxEYU44NTNwaEpET1puc2VpeTlHYS80RnJJUGxm?=
 =?utf-8?B?cHBaZ0tPYVpwaVdtZUQxMzZpNXBFZ1d5dlFUaHR0MjBuWU1PSTlLd1M2YXRH?=
 =?utf-8?B?V1BOeGZINStzUUQ1aCtibkZBZkR0bkxtdWl4ZllkOTdzMjdRbWJ3S1NtOGVv?=
 =?utf-8?B?TW1YT2RmNDVYMmxXZUlIa1BROUF3d243YkZGQkQ3NlpONWN4N3pyZVJRU2ZY?=
 =?utf-8?B?VlpjWWtZdk9PSXFYMXljNVBXWlpQdnNqaDJtMC9uWUNlK0dOb0gvcHVwQnR5?=
 =?utf-8?B?bEpnSC9NWlZTcHJ5alFmUnRJaUJPb2YrZlQ3RmszcmY2ZUNqT0FzUytXcFlj?=
 =?utf-8?B?RlpnNERlRUVOQi9WbWYzZTA5ZERWN3oybG5HVHk1ZHdsalRjY0pHajIwZFk2?=
 =?utf-8?B?cm54dTNYbzhFRFRiZ20yR0hZbFh2VCtsRVVZeU10VkNycEphUStuaW1oQmN4?=
 =?utf-8?B?SS9xd3BwZWJORnpNbmRKRUQ3WnJwVlhYVjNqMU5FdkZta1J4ZUFMTkhyYnhF?=
 =?utf-8?B?Wm9qa0ZCRGpXSW9TM3Y5bWFwTVVvUnlYUEtKSk1ZRkRQb1JhRmx2ZlVrYXo5?=
 =?utf-8?B?Y1kwQ2NZNlBmcTVIMjNBYUhKMzhNelUxRDlkc0hCSXZFSi82MEwwLytVQjVx?=
 =?utf-8?B?ajV0a0kvczM3d21WN3d0N2JoRUJ2NTh5dFM0a21XTm9SajN4SHJSVW1oZGlN?=
 =?utf-8?B?ay8wc2N4Si9jUnFWaUJqWVhBWCs1SFVaaUFucnJtSHdFQ05ETVJnRXczQ2Jn?=
 =?utf-8?B?MU9LdFlwcUFaQXNjUEM2b2c4ajg3SHUvWjBKWE5aellGT2Z0Yjg4OE5MbzlS?=
 =?utf-8?B?Q0syYUtaaXJiNnNNWnhOQ3lGdWVQL3RsdEdWZWFJMGRiN2hqeFd6VEQvNXRz?=
 =?utf-8?B?ZVhTelE1bGE1SDh3Tng0SFM5cXQ0OU9qdVhoSzgxR0NMYm5Tbi9QenRpZTJh?=
 =?utf-8?B?Zk4rUEp5QTFNNjNjSHFib0FMaW9VbDgwM25VTSsxd3AxTkovVmlPZUdaOXBR?=
 =?utf-8?B?MG9McmFGS3J6M3B6Z2VJd2Z4R215RGR6bmV5VytyUXFRMUtVL1BiVFRyWEpZ?=
 =?utf-8?B?UDAxdlZOTko2WTZOZFBSVEwxS2FLa2MzNmFHNUZweWY3MGRHU2ZiU3JXSnRm?=
 =?utf-8?B?NEJ3UDNMTU5xR3lPQ21xWGtKWVBKcTFVblV1amdQOFo4ZHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWowUnViRE5mKzd4ZTlpRm4ycG8xWmdjb2tLVlNoMVpsOG9lTTQzcG90eG5n?=
 =?utf-8?B?ZUVySk8waDJNOTJRWVdBQmtHZEd1UzFxZmh4N0dKb1Q0bDI5OVF5SjhsWHlB?=
 =?utf-8?B?QnRhV0VwMWRUdEMwcWdLZ1Q3WnljUXRpRWR3SE1YMllxSWlGd3RHQTh5QXhY?=
 =?utf-8?B?SkRBc2JTRmo1MTJSazRiK2NNL0dCMzFKM0M2OGFqZjVDMFVIMEdpV3E0ZVdj?=
 =?utf-8?B?NGFIUzhsVGJpZXpMVlBXeC9teDhObGJwQmpSV2FYcE1HdVFhbDdiR2pub3VL?=
 =?utf-8?B?ZzUvTWZiRWEvMnlFdU9UaVVBdWNMKzhSK1RQWHluaXBZTkRySHJ5N0lPc1Rt?=
 =?utf-8?B?TWFqYWRWMXBPRDh3SmlLdlhXeGx5TjR5YXhzNkdrNi9pcHhOZUdSaFQzK2Uv?=
 =?utf-8?B?TjNVQTFTNzduelkxV3J0Y20xUzBzU3plcG02eWNDcVltdG5RNkNVWlhUR2JF?=
 =?utf-8?B?aHV6UG1JNURtTlQwSmRvSnF1Zkw1OHMzWTI3NEV1ajM1Z1ByOTRWdGQwYm8r?=
 =?utf-8?B?R3JLM3NwRkJ0YUs3eVJRNUZ5WXBFcE44Qnd2UEx0bTczN0dJWjI0LzdheDdj?=
 =?utf-8?B?eHNESEQ1cERVakpPTFF6MmZhbDNDMFBHY09LQmxyM2Y2L1VrSlUxM1NGT1N2?=
 =?utf-8?B?RERTUGRIbCtKa1MyVmhmQWs4OTZXRytRdmZxb2JhbGlFbURudW9VUmtOMjVN?=
 =?utf-8?B?VmxiUTRyMGRUb3h1SHpLM2F4cE81RjFSS08wWVVWb2daakNNaXdEZkFQQXUr?=
 =?utf-8?B?MjVqaTRTeThIaXNQaE50SUNBZDhCZStaRFNQanNha1V5a2N1b0l3ZDN5R1py?=
 =?utf-8?B?THUxWTlsTkxNR2N2c3RlMUkxQS9FZlVJaU5relhPUnFaRFBzbkNtQmJWSVVv?=
 =?utf-8?B?c1RUZklVL1VacElycTlJRndyL2pRVXEra1BKNjlRTUZJZStocGRycVlyM2gv?=
 =?utf-8?B?WXl2QUdWYXZ5ZFRtSHFoSWt6RnVaSVg0dFp6ckhFbG1KaUx5S2hRUzZVRzBP?=
 =?utf-8?B?bWhHb3V6NFBJSCsrUHVMcW5qanJrSlFGL2x1bDJVRlpSU3lzTVdSK1ZIOTRj?=
 =?utf-8?B?Uk1nM0VYZUlTcldSckJydVBMMjFtSHQyVmZHSU8xcE5yZE0waTNBbnB0TjBN?=
 =?utf-8?B?Ujl1bFR2WTZseDltUmJGVHdNNDNsa0k2TEt2aXpNVmRFcWFZV2RKdGRBeHIw?=
 =?utf-8?B?Z1loY2dOSjlYZUMzM1NsLzNwZ0ZLSi9URTI5TmlaSlI4U2p0Vk9yUEN2bWRG?=
 =?utf-8?B?ME4yUlE4bHdNTjRjcFAyQnRlVzhBcXVjWVA4SXRvNTZDSk95d2VERjBaRy8y?=
 =?utf-8?B?emQyZDRKMllBNUR1R01jaklUYk1mTlZ4NTcrYTNiK3FOaUdJOTZpSERsNnVX?=
 =?utf-8?B?eUpUUisvQ0dETlRzRjBUN1ZuVlM3aU0wMFBaWE9XaW1QYXBPRG43aFVTNzFn?=
 =?utf-8?B?V05ldjFGc29tNXFPeklYekhqSWZBUEh1RnkrMVR2dlpHOWZHcDVlN05td3hw?=
 =?utf-8?B?bXBqMFpwUFowZWFud2JtdjZTNmk3bVNQVDEyaldLNmlrWmpOSi9NTTBSaERl?=
 =?utf-8?B?YktKVXNIcWxha2x2Nnc4eENyQzZBWHYrV284cVZ3WUFUaEZHV1dMcGFIVmtl?=
 =?utf-8?B?bjVPWU1jRzZFdFNNNWx5US80VWJpWGtYTlZySG9RRGFna1hhL0lzYlhlOHB6?=
 =?utf-8?B?d1J3Q3FXcW9NTmgwRE5WMUE5aHJGamhzUGluYXlKZ0NyOEJOY2JCSUExWm9O?=
 =?utf-8?B?SnMvSUpNRWtOWUJNSm4yenFsdEFOVkVISFJ2QlNKaVNicE9ubzY3LzN4dVF1?=
 =?utf-8?B?UFY2UWROeU5qOHBZUEtaWEU0RVdJOVY4a0xOZXpVK05zSnlpcmNQSmU3aW9I?=
 =?utf-8?B?eStqTXEycjlTRzN4R0FEY3N0dlhGTXFwVnFOU0s5aXA0ZTVwL2NGV3l6MFYx?=
 =?utf-8?B?U3Zzb3ByZ2VJbGw3UXUwUzRXRlNPZmoyZ2kzTEUyZTYxanBsUWQ2akFDM29S?=
 =?utf-8?B?dytYSVIwM2p1TjdSc3h0YTl6YWphNndYUVVtK0REc2d4MUh2ZklpQkZ1Q0My?=
 =?utf-8?B?WUowdVJlOUllY2dxRlFnOVMxNk5JckliT2hIeSttTlFxT1FsQzhjNFpubEdl?=
 =?utf-8?Q?z5gaYPt26iRQrYKmKIqq6eJmu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YA3EKLRUZjIxEGstygevh9RREPCZz32GUhfnUZoq+W/GSROMr2SKfufSlc/c3sAThS+wMFvD0jI/GbNWjICmvl2X869DkSApNBSXfRE4XNrtRZ1fDSquOgIv4yPce4dDq9nG8971iIzGPDUPQSUUMoNZyEyFYZPpMNM8fT36m9j6GhRmSu/gZLPIgsnc6i/8F1HM6X2cl+52jpaJKwhwzqLHDvRaQj0vKBcLBkGccbJSzXXkYeTVrhB3lFCkJz7Ho/8Q7hNtPhFZ/wa5lyJ43Bdwj0ixaobflCw24tqworRgwHD1rO+mLCP2jvwPEJYxMu1tWZRIIoiniQ75xKCyY/FjqyHRnCLO5AOD+btCi4yo4wSYi1aas76McteMesFajKU8DP6dxpivF2M0Uj0aADcvD+Y9JuRVMM+A3sJ1n5a/Sqx5YyvmcywPvOMClOlW8EsfiJ2FFu4zk2EM8k5CZkxujh13ViJgkdhMUpco7Tr0xcrEFd5lRPY/ckzmrgkX5YMU4FIxy3nhjOxOsdQlIhNqhNnowGtaXvLt7vjY2YFwgzc+2jKdB/7CiJap6RchBZlVcyg0w//8twxm1XgTNXils5JC/YhtqlFLbR28O0Jy9XtSkbt9VE469G4Sf1k6
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1b4b60-8aff-438e-3ccf-08ddd35713fe
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 13:01:50.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3C+1Fh9h4Ki2bBpbhFZTiBS5ZjeE0X8H0DFfd1ZJv2CBBnL5uZ3fjlwTdBzSImzB4a3ta3FuPhnmF36/L64kKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP192MB2511
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
X-OrganizationHeadersPreserved: PAWP192MB2511.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=JeO8rVKV c=1 sm=1 tr=0 ts=6890af41 cx=c_pps
 a=9PBua6xsuWuOPIsb3eUxOw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=8gLI3H-aZtYA:10
 a=Lul17N43Lmwq2ur0cH8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jsTyITH8Ev5i3Ltu6_NUKZsqhwlPeTKZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA3MSBTYWx0ZWRfXxo7t8S2LAhRd
 Z41fS8Xd8rMYcq+7XnVSnV8q7Mprfzfw0zNDs5PcS6TqBa3PAeZ96W/+63256vLAwAFl0STibP0
 ToZZqKjfJa2BkYQi2+g1ULLvt7HrVqDKgHdGc1PycTHbM5uNIXiuPssZBlK9ADXY2O+Hvwj99Jl
 AyeYwuuYMzWETOMHziMgvAETFzwhcQg5lCEpPHk3PL/tcJi79k/rFhnAH0OefZDe8DAQ8weS9sK
 DryznmnvhZWyTAKA5+sbleYr2FO+x85F4i3Tot2cO9oEhu4do86W7DaceaEmCE6iPSkqVm1ltl2
 Kqm8xUSLJX2rePbaot5xzHviskDTAgii8HYBeT2lPIdyB/Ipk+ZSoDpa5LFn3g=
X-Proofpoint-GUID: jsTyITH8Ev5i3Ltu6_NUKZsqhwlPeTKZ

Am Mon, Aug 04, 2025 at 01:01:39PM +0300 schrieb Vladimir Oltean:
> On Mon, Aug 04, 2025 at 08:17:47AM +0200, Alexander Wilhelm wrote:
> > Am Fri, Aug 01, 2025 at 04:04:20PM +0300 schrieb Vladimir Oltean:
> > > On Fri, Aug 01, 2025 at 01:23:44PM +0100, Russell King (Oracle) wrote:
> > > > It looks like memac_select_pcs() and memac_prepare() fail to
> > > > handle 2500BASEX despite memac_initialization() suggesting the
> > > > SGMII PCS supports 2500BASEX.
> > > 
> > > Thanks for pointing this out, it seems to be a regression introduced by
> > > commit 5d93cfcf7360 ("net: dpaa: Convert to phylink").
> > > 
> > > If there are no other volunteers, I can offer to submit a patch if
> > > Alexander confirms this fixes his setup.
> > 
> > I'd be happy to help by applying the patch on my system and running some tests.
> > Please let me know if there are any specific steps or scenarios you'd like me to
> > focus on.
> > 
> > Best regards
> > Alexander Wilhelm
> 
> Please find the attached patch.
[...]

Hi Vladimir,

I’ve applied the patch you provided, but it doesn’t seem to fully resolve the
issue -- or perhaps I’ve misconfigured something. I’m encountering the following
error during initialization:

    mdio_bus 0x0000000ffe4e7000:00: AN not supported on 3.125GHz SerDes lane
    fsl_dpaa_mac ffe4e6000.ethernet eth0: pcs_config failed: -EOPNOTSUPP

The relevant code is located in `drivers/net/pcs/pcs-lynx.c`, within the
`lynx_pcs_config(...)` function. In the case of 2500BASE-X with in-band
autonegotiation enabled, the function logs an error and returns -EOPNOTSUPP.

From what I can tell, autonegotiation isn’t supported on a 3.125GHz SerDes lane
when using 2500BASE-X. What I’m unclear about is how this setup is supposed to
work in practice. My understanding is that on the host side, communication
always uses OCSGMII with flow control, allowing speed pacing via pause frames.
But what about the line side -- should it be configurable, or is it expected to
operate in a fixed mode?

> For debugging, I recommend dumping /proc/device-tree/soc/fman@1a00000/ethernet@f0000/
> (node may change for different MAC) to make sure that all the required
> properties are there, i.e. phy-handle, phy-connection-type, pcsphy-handle.
[...]

I decompiled the running device tree. Below are the excerpt from the resulting file:

    /dts-v1/;

    / {
        soc@ffe000000 {
            fman@400000 {
                ethernet@e6000 {
                    phy-handle = <0x0f>;
                    compatible = "fsl,fman-memac";
                    mac-address = [00 00 5b 05 a2 cb];
                    local-mac-address = [00 00 5b 05 a2 cb];
                    fsl,fman-ports = <0x0b 0x0c>;
                    ptp-timer = <0x0a>;
                    status = "okay";
                    pcsphy-handle = <0x0d 0x0e>;
                    reg = <0xe6000 0x1000>;
                    phy-connection-type = "2500base-x";
                    sleep = <0x10 0x10000000>;
                    pcs-handle-names = "sgmii", "qsgmii";
                    cell-index = <0x03>;
                };

                mdio@fd000 {
                    fsl,erratum-a009885;
                    compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
                    status = "okay";
                    #address-cells = <0x01>;
                    #size-cells = <0x00>;
                    reg = <0xfd000 0x1000>;

                    ethernet-phy@7 {
                        compatible = "ethernet-phy-id31c3.1c63";
                        phandle = <0x0f>;
                        reg = <0x07>;
                    };
                };
            };
        };
    };

Let me know how I can assist further -- do you need any additional information from my side?


Best regards
Alexander Wilhelm

