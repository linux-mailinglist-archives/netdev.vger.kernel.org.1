Return-Path: <netdev+bounces-268735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMKwJcu1uWnJMQIAu9opvQ
	(envelope-from <netdev+bounces-268735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 21:12:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE682B2090
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 21:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A4549301BFB5
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 20:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE2337D132;
	Tue, 17 Mar 2026 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g9vHrTYQ"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011066.outbound.protection.outlook.com [40.93.194.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C4C37C0FD;
	Tue, 17 Mar 2026 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773778373; cv=fail; b=fGKlgp3IeRk7XDM/uoA7GQFmjuMq+u0OvVuvABZ+OhXfGuDg6od2B7uzn6hgcGgNO0eQjmYI7aWSTm+Z9TzJ7CKyuCUqVAUOfqJMtyrVmI20ktOVlPuLRlq47LokigQwTFBKnug17QcvDpin95S09Nn+tN4iQU9ej/JHFUZDiTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773778373; c=relaxed/simple;
	bh=oKIJYJr6S3Iz2Kg+TRCZNPydIHZlbyBVzuzlhDtcmm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z+6ri318dv7KmrIkMCbvstNTRvXbEDkeK6aVT+hj2FMVSe2CjUpzMttUrAguDRwmt/UtJQOy3FBB327ZMFPWelsqpLUjLXDfr0iRqcTd/0PFTg8MJjimYKoK9C1rAtw1BLz6sjuIlfavjWhUDjCrrzIakbHciv1BT52OZF0Bp7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g9vHrTYQ; arc=fail smtp.client-ip=40.93.194.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlAynzwo4S2qoFM2b0QHfLD5GNFhE7rvvpyVmjKE3aP1JKtuEMwiO1V7tRdxKpIGyFGqGi3oWCknZxnePuaCIuTuptfDdmqxC+Vij8IURxSvgKe2SGVqI8UEIAXJP396UobvF1kpBsFwzrUEh5qaQtQ6lmMQOEMRWnUxHA+vVUT2q9jTi8VNpKYHUQRRN5EbKvloRA++YNVO7ODn0vdTb5kf22+dH3rrP6vi0YHcVOQAfI3JdrH2P+PjqzQFwj+4pb7f6E9ac2Rq/ko9bJ3gLkVkQ1Lo0L51a7MGA1zvD+fsCmToxagdA/X+Jv93XUVROc84d/Eve8bmp076SMzEpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBOvaLVGnOWRvR8XahRbpBz1S5j6HR9gOdkjLj1aD6w=;
 b=pJU30eXjldbZuWh+EAA0ZORr5+vxJq+UsxEtqjju6yaRqU1na03mAAjTOge5ssYyetHcVTYc1TbLHmHG2Ic5MidnrtSY+jwGdUpPcUmvMOH8CncvhesmyhqA1uMp7gJQ/QE+roSS2h1QZCwDismS5mOzQ6hz6L9OJqIBz++twjHT4++74STOjO80H8r3HAzRY26FrZKJkNqLrgahqmDTbDuZQOPt81rOnecLznCXLElURbIpCr5f/lTbxTlWgp78g9vlby7NPfwrnn9JaxJ/jIe9tlOV39xKj0vxgeqGcrnScz89UvmULVBWK6t2vY5MWQjvk2O7gWNc+ngUvM5NXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBOvaLVGnOWRvR8XahRbpBz1S5j6HR9gOdkjLj1aD6w=;
 b=g9vHrTYQQAqI7qR5lq5eNj4uImIcYAKW1LDUN0+yeYVMysdFMT4os89U7xI0HnudpP9kHB8yVeeNrTJA5fs0dBcoz2YjkKTyTg9s4Y8KDW3nXwhPURtf1UAf7j++djvpGBkGszq7F5GFQW5Fs+K2+RYwV8hW8pCKODMBWOpKbMoJ4AUA8BjpbLWD2Hdiaiz2w7uSxA5zuwvdgwZ3kcPMHwdLnf5qS20zv1PoY3xSqH9v85mdpRcnmH9LzXgNAziK6FNdqi0oFCCY8TfgljaoTEhk71Kz7Gid5BijQ58tzJKxnl6Lftxe3TbuzK2lRMoQDEPVQ0vcFUDJL1ftBNOV+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7906.namprd12.prod.outlook.com (2603:10b6:510:26c::10)
 by CY8PR12MB7362.namprd12.prod.outlook.com (2603:10b6:930:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 20:12:48 +0000
Received: from PH0PR12MB7906.namprd12.prod.outlook.com
 ([fe80::adae:c781:7ee5:e467]) by PH0PR12MB7906.namprd12.prod.outlook.com
 ([fe80::adae:c781:7ee5:e467%3]) with mapi id 15.20.9723.010; Tue, 17 Mar 2026
 20:12:48 +0000
Date: Tue, 17 Mar 2026 22:12:36 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org,
	Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10 net-next v3] ipv6: prepare headers for ipv6_stub
 removal
Message-ID: <20260317201236.GA3581148@shredder>
References: <20260317140141.5723-1-fmancera@suse.de>
 <20260317140141.5723-5-fmancera@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317140141.5723-5-fmancera@suse.de>
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To PH0PR12MB7906.namprd12.prod.outlook.com
 (2603:10b6:510:26c::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7906:EE_|CY8PR12MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b48205e-52b4-4992-35da-08de84618ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Mj0Hm0ToOjD3xsd+dyuQ+oZ6GV/2eSwBjemJjMMXYhjW4bjRewwZvUE1/j7Ic4AYoRuXaC7Yr5pipSYCVyCwhNkKyVzvGFQt8J53lkLMTcpcPoVt+mGzY+BUmI1ZDhw5jWnTn++rvde13ApvADdpdFhyWo3EWz0VAnIqWqcRn+BPcM7Crah3qHQLIXSxeqEJe3QFSYtFtRE4ijkj4hvpu9bE15MA+1R3h88N8Jxp8ViykJQEgoS6Fjh9Ys0aId+efPWtsK7ILoTl0f1atjETLjYhxngyHWpCLLbOP3n6sMO9X9TQETpDf55dDrk8k1FmPLC7Sn7Y1DxL0K4vG0cvVHTdjW3tmD882CA6xWvGDE67zsqHZbH5M3RSeDXPqPaWKNwoM+qFXGQTYuxaBJDey/cA/lr3raVATCpkI5rqsl+8+lQs9rOOsLzOGfu2VVrJ8esobYqrTJdCfSFVHwyQN7vlVZ6hvmPEmQHGhe44SKw771kj87thGmPuxXmPoXmDieU7CabSboAvW4a4IapAoZwxg52kLhF1eYkhKa3CGj3VOTrDbv13SV3tnzTYK8W83tVDZ0U3ivihi64rZE4W/H2FnJwfb2OkfAXXRHRfmBCbJHc2G4vf/MjRJ4U5p1/pGkE/ytR08ZdGnK/oMucWHYOHewBh2GO8DzaiWlziXwcnN3tjW/dXCXhnPc4lX07ctIwbJSjZhilnooHn4B26fYSOdnATpq62EQSE0r5XP5w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7906.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KrFeMeOYtW7vYoZrzcccur4nvxiQL95EpI9PuPsnO66A57hJJRzcaDjKX2GV?=
 =?us-ascii?Q?ZT7xauoSmujNQlxEeMmtn9meYR7HGH+AQXoJqX1yvo3dfHiFZxA8XRdfAcU0?=
 =?us-ascii?Q?ZFQE8TZpYr1PIclFD0mlLXCC5BGXH3uKpU+90BTez0i1RvVokB9D2PH6DTun?=
 =?us-ascii?Q?pBTrcFLwqKSPpkm9ZKTvPHRIDUHUSY2V6TsojaqI6lVCUhgzpA0T65UlTCec?=
 =?us-ascii?Q?ycWvQKP8rsJqgozY9uQ1MAnjoomAcRO0//sDp+FHtSc6vJA4oXEpMKp5SzA7?=
 =?us-ascii?Q?xZ7gmu9pXR3H0HSmRA3gXpzpfg7w7TMy0IzOId5s7ZDoOuykecnYB+eSNTc7?=
 =?us-ascii?Q?AbuDubYWqQnq1HY/hdoXJjq+l/gxFxb5kni61fKiA2/cXuL6Jmn/3zzQeQyi?=
 =?us-ascii?Q?N2r0lM+hCEJNHVzNuoPZBTvkmly5k+BgLC0RDv32M7yORe+YbNSVE+OWu9d7?=
 =?us-ascii?Q?BDGJkkH/ik/vQD9JcbRqgG9UItDHWvdTZ72ERwNwfNqAI3Xi2wAWM+Paw071?=
 =?us-ascii?Q?k+q37rRdbzN1QTzfmo1PgMDVfNlcIIFrxLOaAVjSQT/PuV2h3KHIWc2NwYzx?=
 =?us-ascii?Q?2tll3NuzzCa0rd1YMBpYeMAP7r/e5Fo/4oy+wN9d9mvPjNmjCym7wcxJfPU7?=
 =?us-ascii?Q?iJVEtz5Gl5hgNiyHOqddn1zZvZVPRXWy1HYJ4Y3AltsjEGWWq7VZMwKcRwUM?=
 =?us-ascii?Q?oR6N3q4auCaYyOYXfuGQZKLQqRTL9g9EoqWUqVj+PGUHrAcVrHUHH4Wb04Wm?=
 =?us-ascii?Q?3JPvkI9e0mNXmKOBlf4NwDR6HQ1B22OXAcs0m/dswBC8cguN7am+eF0J7kHP?=
 =?us-ascii?Q?fJzYB2zBly73+UzqW7FeJreb2Q/1jYNk5lSIqYfP/8mn7mJ6wWHqvgAvcCtV?=
 =?us-ascii?Q?xJZK5rBCcDO4AlNA9cxSk4/aGCM9WqZ9TfH+HmAyP5DU97O7exkSXNiCpDdO?=
 =?us-ascii?Q?O2H5VqfDaw97Z34wOJvab+fiWKIybHMdwpvPT4k7A9mR8LhKMT7tHeHoWIwa?=
 =?us-ascii?Q?X9GGHfYLlNmAwuzesd27bXzgr1ovMZFMcqVWXdJZyXkw0qquHfgGJiAC3QRr?=
 =?us-ascii?Q?dCR0MF1lUtsfjPbvNxuyY4MiN4Rl7yHKI2y6I8/xwS4Sz2YV8KlL8c4YWJUX?=
 =?us-ascii?Q?tnmiu6jmpOnTtEWCN/RNjUIq9JdcQ8O2yg2d/VZAvqMUmn6hTWDZ4Dy0peRr?=
 =?us-ascii?Q?wuhyzk3k347TWOyVseMx1XO8tVDiq6a4QBHKC09OCD+B9GukhYBdrHZQDgA4?=
 =?us-ascii?Q?UtgSMw8RFx8kMoBNq7DQp348I3lMuTgw7a2Vl/F7ApRdNYg/+8SEqKtV3KAa?=
 =?us-ascii?Q?Yf5IMZ0DV3CXaBoyIWsH+Nm8JxUO2Js5jxsUjDiPGm2ZlVj3lQnPS/A8oF6z?=
 =?us-ascii?Q?5fnbR8Ydjbd8iz7h1fF6NEkxAsrihMiUBDfieWgt46HpzW5dkVg9XZBP6hXM?=
 =?us-ascii?Q?rEnmWBraRikVSNktXUK/d/VodmuzLJFgm5eTTqJDthd9EYiUXUKTgNifYiy9?=
 =?us-ascii?Q?2Tfj1zEEsVTh63cESxw3LzoLllbSEq8O/n8VJIdU3R/zOwXLdkJFZc7zLK2l?=
 =?us-ascii?Q?oxGGM3iFDukTL/TUaey54Ay3qWcs7wWORlQawKwZI8Qku45wAfnU7f8LlGhE?=
 =?us-ascii?Q?VBhMFidugxijThag1+7Wtj3Y5fLE4aIhJC/MZfNlPEVQy3pR2StIzeAGG+Zp?=
 =?us-ascii?Q?jk88J3r7KUWOs+z02RE/2vNRtAHzeyyMplc31ufFEsjV0S76m7QQmYgiJMhI?=
 =?us-ascii?Q?0gJAgFpfSA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b48205e-52b4-4992-35da-08de84618ec4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7906.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:12:47.8306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRnKiw70aFOUDnsaz/XKOIVvq5STQA82glWpUa/GgN8R4iR/lPeTkUcBu1Q59utxz7hRBt4wC2yElXwzYB2iiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7362
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268735-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8EE682B2090
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 03:01:00PM +0100, Fernando Fernandez Mancera wrote:
> diff --git a/include/net/ndisc.h b/include/net/ndisc.h
> index d38783a2ce57..6152401f29f1 100644
> --- a/include/net/ndisc.h
> +++ b/include/net/ndisc.h
> @@ -69,6 +69,12 @@ struct prefix_info;
>  
>  extern struct neigh_table nd_tbl;
>  
> +#if IS_ENABLED(CONFIG_IPV6)
> +#define ipv6_get_nd_tbl() (&nd_tbl)
> +#else
> +#define ipv6_get_nd_tbl() NULL
> +#endif

What is the reason for converting code that is dependent on CONFIG_IPV6
to use ipv6_get_nd_tbl()?

