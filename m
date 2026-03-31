Return-Path: <netdev+bounces-273653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIP1OLXXy2mILwYAu9opvQ
	(envelope-from <netdev+bounces-273653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:18:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D3036AD04
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EDDE3094750
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ACD3F9F55;
	Tue, 31 Mar 2026 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bqkS9zi4"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013046.outbound.protection.outlook.com [40.93.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F067364949;
	Tue, 31 Mar 2026 14:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774966445; cv=fail; b=tp6WHC4AdABPfC5hudLr37hVk7AAr41T1hDzoXBK98HWtukUKQlONB4zOtsLNLBk8gFLJFePqEWF4wC6LpUUOq+SO2pYce6MaBFJcXgF+hMYyF9nbEyjj5oN5r1en12jm8pqGEZnhF20qeSDuvTim5d1/FscXBSFa7McCueBNyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774966445; c=relaxed/simple;
	bh=XF/KGoVyGQVRui0MTFFCwiS6DDXOyXt5cNJbBcNSCXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gsucWwDyDXwu1QPxhfzs8uTuNmXp5fU0nW/ofQAPxBP95PZ1spZ+lVDJXVF2JpOLCtSjpwzn+Fl8wlFAyGHoh2G39M61WtmeVQdk7+nFktQDKq8kY49p7hvjKZHffgHB9toW/yHRHEiX+hCq2vgniRX2ubRaeYQRMwluG86Vn/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bqkS9zi4; arc=fail smtp.client-ip=40.93.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZ3ydG46EvchaUtaL3M+w5ZS/GGegiDiNAHZYzbFiCm2Yk9j1NjeBtEu9E6f8W+qyQCwgkvS4rFBGjimCa/te3I2T8bdLazALSYzSzUshSTH3UQNvHrMMhdz7NCjFM7mjU7UmXE3qIE6TilImF5C81vUsVh8TV8fOt6LjFm4SaU2gC512JMjRpeHHDnKZQZpTr4vrRVGTVamPXewgHkorMOtS7D22MpLylN4FHkCuKHDsoBChtYSL1jIijizH1bKdVhJatMSwJZyCazB3wON2UFSqDkCPAhF1+dgnNA0sx4Sf8J4J3hrvCeabbw1VVRA44CVgoRIpg+vS6WWzsxSFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WDBCBL2B9ujEAw9T5YMZRiN7wm6VZvvB3NwewFFiSA=;
 b=heF9HFDZ8j7iajTmlYJ/FSwNjacFuQaoX4yokCbQnTiN4G4wUTh/gxQcKWC6vWpAWMbof2buVN7ujJVlCuJRy1aMJMlJ8jVqEtYITnreHdolIuTkcpUbHWBmXNBZ66Fvt/HZ86SuzcRYllQR9ele8JtPr1uKXoYe9N6LSQLi4771RiPSf6a26j6NqQc2GKCtLPNEV6EAQ4tzeoRuHvej0HJAGrpxtAA+6gIxD+h8is4/DJCwky72X1riLW/icPvctdrF3EfqMbfNgxtqhqKJLp8hFZEO6onpL3pFayWhwEAE0F8m61Y5aE7sTp8mJ+XinYWYNejTzd1YjgrOUMJlzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WDBCBL2B9ujEAw9T5YMZRiN7wm6VZvvB3NwewFFiSA=;
 b=bqkS9zi48elBXJNsw0AJWqjFsPzrLNGwNsf4GouwWM/qC7ylczvwg/oOAjCV8PUelQAuvkzyboxnagemn0hGDv+5YzJWFyTC0wapLN1PKSfRM7Xagoq0LKj9XD6PhZ/CfvncWvWfCDWwpq1ngM3t5FK4isJTK+lvKlLXMFPtzE6lMunTewCC0teN35bIpqS8YCO5hBNUsi50cNpMHIdmMzlAbv7hiYS1kyXGca0E51OKXZ5CCKdZqix6eyvmga4gN4t/tr+2AST/Bi/z06IMOHyH3XCbjNYBd0hZfiVzCHNWsPqi59OvX6hQIy+EXIELy/2RpF0XsXCl0trnBYNkbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 14:13:57 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 14:13:56 +0000
Date: Tue, 31 Mar 2026 17:13:47 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ujjal Roy <royujjal@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>, Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/5] selftests: net: bridge: add tests for
 igmpv3 MRC and QQIC validation
Message-ID: <20260331141347.GA1637150@shredder>
References: <f23ed1b3-6321-4e6d-9cda-ec5d34304f3b@blackwall.org>
 <20260330191611.16929-1-royujjal@gmail.com>
 <20260330191611.16929-6-royujjal@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330191611.16929-6-royujjal@gmail.com>
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b1fa18-8acb-4a07-1fd8-08de8f2fbeea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	f4PQNAJ/h/A9z8I9mRj6EjJMwoEvKAAjFy0U6gKYF3r+WqERdt95Jux7DNHdjOLB7XFMz4k3a9pCEvhgiQZYYICR2GcIZjHUo8NeNEG5+/L88zqty9YaOaUdf9/bhy92SfvJ/XeNIdbldEhdR/tFe2HcY+DAUE0VjaFF3SvF6HcTkx89GGWuU4N1yWEdKEcMpZQwbbowMA93RpibQUu1W/LXRDqVZVdEBmESOmte4OR9YhoFO9qAX2+37lAhc5Z8IumQqVOwv8RA5LiSrou6pX2sqKyqxohzynIqCpJ2hPlpL4HFS4YxhWIj3wC8s+liEwSNeEPcGmz1FMXMR0E710zy18wtG/MHxj/jJ91cDUdhZLYEfcFBaL5lgtOwYgcOWuGA2CNM/2eqrlkqlc5dzA4GqImDUBrd7UDSHp7H2aSUNTgN5v58LyCDJBrqgc4e7EL/FTc4PljgOQtHhJmnXBWBMSqDOgROee1WJ2KEZ2A0/wdhSG71V5t1F+yznw2mzL1Q5Q3+LCJ8WVJGAb5tZ4Za+q9XxgjBZ4IGR2UEOvJh9gzNzlX8WCf5pRfnKD2akcf4PvCgpWs+83M+21tinXtpjX+pZ58t11KIsY3kmMA2dnljSHku7WQ7Z3XcZwzEqftBmZXUcw80OhEYlM9t/U2BhxkRC9lN6O5FH+bgpqmC/KZlq9cLCLzQX3xPRrudQ+OMMM29nwdst7BJkiZ1aeJY5v0RF5TZnYeYc+C/PFw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+B1/p2M6orujSncEdj/RddeyZznLJK5YhDoyS+ahflBU0ObAxk61B1LdmAPm?=
 =?us-ascii?Q?Lnc4g0LZqXYiJIhP6SsRNddCbLZxC9xBU7fLZ7Hpfmk2tnB3KpgLizjXE0u8?=
 =?us-ascii?Q?yGjXn/Lxjxzt2pTN4gRsLsdL25rEJxdy7WK1IzJRA9xLfQqnLG/+Zg9Oaq8j?=
 =?us-ascii?Q?fKRBjI2n0pIy2m6J/4nsn7LGu8UHlysZ0Q93FaQeys+qq6RSrFChbdHtWqjy?=
 =?us-ascii?Q?mMil7GPa1pliLkZ0bRvmo9SzoWimxVTctKyKVMZXG+yVx7cTWlIinDrvnhCZ?=
 =?us-ascii?Q?Te8heHU//1Ggf5ByUm/pd/7J5xuByl/aKFoPgl9xvyeV4Fmi0h2ZVFOyaDzB?=
 =?us-ascii?Q?Qns/Ao8Q4jc9Jz3OFS0V0y/whvBfPNp7rjdG7itMVdo+hx60XCFrIQ23papn?=
 =?us-ascii?Q?IEpVupNA36eB2ERwHfs1okHKss/dfCctKTzxDfbqniBzJO0v3IH2ozQ/7DTz?=
 =?us-ascii?Q?HzGos6sDeosauq0ZFxlfEbxsNDcT/czqg9uaCJ0Rd1Np6mMJiml5AhaH4BFo?=
 =?us-ascii?Q?kXNqOSFOmHe8a7tKvUQvkqxgDwoj1In5+qjAMFbp823VOxW9JMUY2WaNOboy?=
 =?us-ascii?Q?5WvuAjgaRSDGEgQRKff43x1zq8lvWIxAnPvqjINE+VLVjjGXFOOq5Rcy7Srv?=
 =?us-ascii?Q?008bKw+IAg69UGjn8mRlroAk4wlB+nXJ90H4dt+nhoZIo9Gowf7Zh4998Qiu?=
 =?us-ascii?Q?VncjTOc0z4pGDF36PNmda179YcDtDdWzYtyaYwZWt8mot0mN7l7AUeYuzMwW?=
 =?us-ascii?Q?nJZdU8yohnCeVET/WJAP6wqJQGDmZaIQO4alVuclOUf5fC7VbYVVMYWv1kmC?=
 =?us-ascii?Q?i9NODNXkQ2vCNFYwacq1IbFG0g5ve9U95ZsZb9UajKoRKxNdr83p7PeGSt8T?=
 =?us-ascii?Q?7qGAoWhn5KLTUiz9N58861NV0po2bKulPSAUW53KG02y1BnXMYNoactBn8AV?=
 =?us-ascii?Q?1gDxEjczmEw0jZj7SkqDrmrUmUii496/0eUymlOp7Rs/JGdpOz06N0urqoDG?=
 =?us-ascii?Q?y4VZKJAq9DIr0TYAXZYMZcrZ9DPDW4ZGZzO1JoJIcv/LATLhqOe3Qb/DUDTR?=
 =?us-ascii?Q?l+hPeF8kvtttPPBKlrP4hETz9MtGzqrKL/SGOoqt61jVoVnGQALD/G2G67OY?=
 =?us-ascii?Q?rTjtKZRIfN5Crfe7Mpc1GTfGL9cCrlOLMwAngcGVkSro903wcUf0bJpXfW9J?=
 =?us-ascii?Q?f+RnfDqgIR+w759UWWnMrCMHW6gJLpyzGaOyj033yPK997hPQsWiK+PdYogp?=
 =?us-ascii?Q?UB9oTBMxFGGCEJsu+Wu1jGzlEgU9+EsezCJHJzwuT2IEg8wCQ5u20yq68s5y?=
 =?us-ascii?Q?4PBG73vtSofSLWVYjN61OBnJrcG2nzCsiz+B8GEMvQffSVjAUW3T0vxh71A2?=
 =?us-ascii?Q?w7yuBOrOv3iSwid17cGlODmqaJujeES8nLMuUEHOgOv4lsldnp3aPqK8402j?=
 =?us-ascii?Q?d34jNsGGUyWDLJeIRxJKvTbrqrGr3NKPgN6SjoO3HBXgs7KBD0JhsVKOmhhX?=
 =?us-ascii?Q?opWVG3jECQ/R0qkQngJPzFeKAqU0DRE1h14TZ02Ss7182dVex1sXHqaCduzv?=
 =?us-ascii?Q?S5QIPmGiG8wStxUtqg5N2/D5G4IQbS85IMNkf7XTa79OXXPLD3kvGNksAStp?=
 =?us-ascii?Q?RfuP6bQ55yqmt7NQrrwqGIV3D5kkWVIvvOdQXe5ZDR6Ds7LLJ/EebYFcCVVV?=
 =?us-ascii?Q?fO96ZHzv07DY9OFhhcAKUooyOh732m7Vx9a6lLqyof1/35FOgxouzVknFOCS?=
 =?us-ascii?Q?qzkwE4OgCA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b1fa18-8acb-4a07-1fd8-08de8f2fbeea
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 14:13:56.4840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5C05CcFiQL0yQ/icbsPvbX6AArNZFx+8okeWE8vyziah8EG5zVCpC1wnrdD/r32pv/08tLcwcI1p5Nc0LRemzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273653-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 61D3036AD04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 07:16:11PM +0000, Ujjal Roy wrote:
> Add bridge selftests that configure IGMPv3 parameters and validate the
> resulting Query packet fields for Max Resp Code (MRC) and Querier Query
> Interval Code (QQIC).
> 
> This also adds helper binary to encode floating-point exponential fields.
> 
> Future extensions may cover corresponding IPv6 cases.

Please cover both IGMPv3 and MLDv2 since the patchset touches both. You
can add the MLDv2 tests in bridge_mld.sh.

Also, I think you can simplify the test by simply matching on the
expected values of MRC and QQIC using tc-u32.

For both IGMPv3 and MLDv2 please test both:

* MRC and QQIC in linear range.
* MRC and QQIC in non-linear range.

And please make sure the new test cases don't add new shellcheck
warnings / errors or it will fail in the CI. You can ignore existing
ones.

