Return-Path: <netdev+bounces-281803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCzdNP2a8Gl3WAEAu9opvQ
	(envelope-from <netdev+bounces-281803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:33:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74140483CF0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63165304D8E8
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437E73FAE12;
	Tue, 28 Apr 2026 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uuq0/E9a"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011009.outbound.protection.outlook.com [40.93.194.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33AA3FA5DE;
	Tue, 28 Apr 2026 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777375154; cv=fail; b=lp8EWa6Ot5E8fjoVKZlf3FR9jXDylI8siZIsXTEuH5mLy1dutoQckzkUpahqopWVfIARiBuzYq5O580JSHBXoWWG5xmkwCxe1HRV6qfo1fE3gb5GHxaAFB9vVqZDE9xzWXDGJnx+Zy8Bo1a7QaE96O+9upz8Am1tX87809X5Jr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777375154; c=relaxed/simple;
	bh=brA7hfodFlvVZXH4gv/l94NDddZvq+gui9jZNqYn5ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c6vYT8MycCaTjmz+EhFZ8RCGYBP2WVFsQGWRHt44LpAUfX3AsDlRvhcLR96RJwmlaH1FwYg1dD6PHZ6u0wfXAau8bnKVnHPcupkCodUf3QSljEu9saeLZQCD7uOPAdNxbZ3f2E0ZKRqSrRB6ejrVI3aV2HAAg6RhpOdFEyAq2cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uuq0/E9a; arc=fail smtp.client-ip=40.93.194.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDfc5296Jm1z606w6wNdgtSIZ+gv5Ho/87V9w1jJH1DrT3g2no7YvrOb93rsmcgpIGt7yZgzS9CSfOQp+1Lzd8cI5Km35aWfoOFZrDsZ4240WNG0Mk9P7q/LIjI91ILOTKK9VHib98emZhZYIfQZWf4Qif2gs7w7OlNIGZ29j82vOhs2BrHtOLB5jP8LCZAmwZy7q3luJpkCk8HOlN4B6bmugJ2IzhVIY0MzDNP4DgEwEHJlVlLq4AILxg3JjpOBwkCJHgA1PQxhLPHYnDPngHhlxYRMNvcBB+C5NVlzYEzqLdfpJa1RiT3Q55zzG7t0sBW93PUcNrbvJQHybSW60w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjsXSEDgz+DAsopriQynm1mzZENGulrOCDCG/Vufeh0=;
 b=cHAvgGNrJ1365FY+nmWt4EQmqmjLWKrVYp8dopS5wp0dc/EybCnq55XjHm04hlGganhvHnCBqsMPvDXi/2NWCGdHyelamaM+TqJsxHVqgwfTngQk2FGYiEIFME38gQ4v5xj4llJC4cjO2/cxJFW38mVCYPnO13RzyOaFaIkoEud16aKN6TqN1EbtMgxSMfF9x0J58b4EjcnvQfU0SNsI68mLcfui8RCZJRWP8FcexonW65xd6hSSg9qpe7vYK8mXFJICBmoR4Ml13Yg9i4G/JLsJCCQ2Um2LOZSfUkaAG+qDC0pkwxmo2UlXSMVjIjWQg2EYJtBo/69UGdT13woeYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjsXSEDgz+DAsopriQynm1mzZENGulrOCDCG/Vufeh0=;
 b=Uuq0/E9auLOtQkw5DKBK7Tt+XcmwCF8URipJL7PA1N27wZvCPo8a5EIEvZx5uDMn6kiGgWcqcRm9yCm5pO33eJU0wkp6FXeD4CIOfXZsuDfZL40vmn05jn17i37FP57PWYAUCmzL/8YBvIPgLGYkKfps4njt8ZX6q9+JiZtAKwZB45sYenj3QJearn3Y/KRsGW9d28H7C1lNQLR25TuHKXkbolbXGMBy99dd9LQQKOcUaMJ1PtBCPelSnoTS4cY7hpwe4UhhN8iPdqwdi2u7Wd3Q8geGbDmBx7f3/dw8qmV/QF2e1WS/WhKu+gkO62vos/d1dE01Xd5nE5W9B0XuNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 11:19:07 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 11:19:06 +0000
Date: Tue, 28 Apr 2026 14:18:55 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Sagarika Sharma <sharmasagarika@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v1 2/2] selftest: net: Add test for TCP flow failover
 with ECMP routes.
Message-ID: <20260428111855.GB571865@shredder>
References: <20260427224243.3499162-1-sharmasagarika@google.com>
 <20260427224243.3499162-3-sharmasagarika@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427224243.3499162-3-sharmasagarika@google.com>
X-ClientProxiedBy: FR0P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::7) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BY5PR12MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b659e1-a6e8-4e58-cf08-08dea517f62a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	P7Km8dQcoeEhTWeyvhL5fc4m6pIZw4dSvhBmy0panvBr9YhrJqr67GDzHybGlENgTcdoeoO6uKNoMb2gkCutioA4VIpvskcEHCKHBOEqv3bcycPuHvBOFQ77eOv/5T8o54fVMS/riWae12TMYQiioih/IF5ggiMOwbzNOEfgzKIT2YXsQaVf1w63ts1x9nU0Z3dZtmpMH4OGdlopkRNTjnNjtnqhQQ4TmHzs56z4SKN9mB+krmr5S1E5pko1EmbNcgqfFhqxGYF4891rFee1/gBFTXXAiH/jdmfqy2oOjZm8jsmnxwRogg+fCg7mJ3638Y0WuBydMTzD5T5cUyB962Cm495Ihkj9Sx/iLZLNEiJn9lSlj/Uc/fhA0IdB6YvTBM/x6u7qAET1W9usonvpH0PfYfdifIJ1RvzX5T4olE/VqQ2ckikzxkdGs/moMWy3VqdSU3HoXIwoOJMOrYERXHdkJfeMtPOKa6ZmgpaRsLeGPTpZ7kA9wFZhI1m1X0VJBdgZD0vC9VcUnEdQ4SPSR/Kev0wESQ3AXWQTmzrz/yaH/D3pbsBuQBL8xYtoVAdT8CZP+DpAb0cGP0UxL/ncr4JA35QWbpNllPXcewJw01IQlcJwO/ldSlcxdxpTyad9lE4Kc7/zCh7zqsdfR4SvEM0EyuOBK+D/UgCoQw3Vz9Jq3QjNuooK2yXVYXnJKRrg6sGzAhooaTvCJeo6yvaNr6BlFSFP92quF9QG4vIXLxM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B85jmDssCejxLiQHbSVkxMOrGVfBhI0t28DpmDSItFoAp9N75u94DpYLmY45?=
 =?us-ascii?Q?jdNSFaNbzqkXiqzOFGoZNE9LO65cCF2ghrhY6f19rGa7SS7W3qzYGX5ARvP9?=
 =?us-ascii?Q?/Zjzv/37ktLswqplhGjeNdvYYC59c+T4I0wAMOD5y+MwZ7Xw0wY/rQxEFjyr?=
 =?us-ascii?Q?+HSkPxRHQrGjVotPtPqHt/L3cycEswGt2N86m1RQccvWkMHAAlTR45OFdL23?=
 =?us-ascii?Q?8wb1B7ZFSvdCP5ObTxNp2GIC2u4sJipC9hizxaUDwSvBTkgkg7gVQSSGkYmE?=
 =?us-ascii?Q?e5nxSaYHkbcK0I6QD79wsMW5KEVMRFuMfdAwDgXv7uZBZqClWooOq04AgjRk?=
 =?us-ascii?Q?gFhuxcyIJI6fosEThIA2FZPaQS/J8GJElTDa2+fFkjSMYVYi1TQXhN8o43lU?=
 =?us-ascii?Q?F8To4DPdgkyo5iQYxD72Dx0b2/5ETdUcwMZX5bPSCt2mn+pQZfTO8NWPMs3x?=
 =?us-ascii?Q?/DvKP2kNbFnVr2sI8Yr+og0Y8ZdYXWkLDCdUNHNr7Zjp4CSkAMO/jAekDQDs?=
 =?us-ascii?Q?XASoUCCpnkwJchu0Y99B5aFh2Hzff7h+ZxNRFli2epVG/o1T6jHey3VvAKFt?=
 =?us-ascii?Q?N4ZizthC4vSYbltX7R7UXVb92YbxjBYMIyQ6vp/ereBr0VFfqDZ9vj1E8fzv?=
 =?us-ascii?Q?wHvNY3gbix8l5uN6lReSF7GGqmzfjeOJu6+lAUNf3/D8VEx7zuPoIhSiGGeB?=
 =?us-ascii?Q?mxbcwYUDomX2PaFsewyvUws4aJJ7ZEWplT0ezm7WSbrQUxHUowfkEv7GZ0uS?=
 =?us-ascii?Q?Ca5rH5DwTwWoaXCmCOKaKDRcMw3iNgipnHbAXFqVYDXoC45M74WOcfw5/J/d?=
 =?us-ascii?Q?8b6jlI9B66wPpmcWFjs8Ytes5sbQsrGPzekl42ev33oU3dCBypJWGq/fZ9ni?=
 =?us-ascii?Q?Pog5YRwVox3GVwKOFIZwsYwn52ZfpaCR3u4xar/eDgk4lS8EwtXDLR8DPobP?=
 =?us-ascii?Q?Ey8hZghTPY/oYcNUfOhCsXGBMBC/0n9JNWEf4BsOYj1O7csZr04LU1omLv5o?=
 =?us-ascii?Q?wpgTjaYNJ4ENnMS1oUq0Ev/acPtVPz+kLOvzOrU06hmKH27OCkbPTmNIH6WD?=
 =?us-ascii?Q?9pPpPW/pPYm0LeBaU0j2BZ4Ya1Rl5DVUGm+ywYgrQO69J6Wjdt/haf5FEjTH?=
 =?us-ascii?Q?BB16vp4WNAEsezgvJWqbm+htotdjqvW9zPbEKBPlIOzLQbYysRv7iG5nOiXj?=
 =?us-ascii?Q?YGnyEb29tntfEHoQ1BVd6zNcxpAwIZfnFvG0zBlTfla7P/X7NpSqIkWN5+nN?=
 =?us-ascii?Q?B5URwQXah0hVihNwn1buHoHtrZRWeZM8fMpimbrtn9h67+1sTYKTRMsgXTDA?=
 =?us-ascii?Q?AqvhzNJ7uHA9o4BkVLTACbutkN4LAp5uZuIwtiSX0VMnThZDcP/MsP5jjaqQ?=
 =?us-ascii?Q?qOA7PGYH8SItjVyuqyrNi17LAcdDZ9fpkf9vGbNIm37AISGeFy4A9lWUwmYR?=
 =?us-ascii?Q?FRLHyz8xZONdLw1J8TXi8USujZkvwoT2TrwhdnSqpCCAcZXwSOJsZA79Qhy+?=
 =?us-ascii?Q?hCYz6Umd86egrersZsHDz6XwFPxeB0Lxhe5N7ZI+EChb6USFPZLD1rmX5QhN?=
 =?us-ascii?Q?cW+Br2ZpJfaE1X7PEUzgppBIxdmuZitWfp3TsJKlYM8NgNvSa1lyle36KrV7?=
 =?us-ascii?Q?rC0Yx0Bcr7Sb1cknWI4He+Dx97tpfzfbrUuD0EmC7S0T/5QwX5/n3twKeSjg?=
 =?us-ascii?Q?nIl/UH7NbJ42tSXH3mPQoFSJx09chPJGiIZUdVPAt8b+JahV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b659e1-a6e8-4e58-cf08-08dea517f62a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 11:19:06.8837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFBt2v7XLh9fmEMFLXgaebcADJK33kBsSLMSYHj9OXepuMND7l3A4qR5f3riF4iAa1nu7nh0E/p7kDL6otA2ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
X-Rspamd-Queue-Id: 74140483CF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281803-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 10:42:23PM +0000, Sagarika Sharma wrote:
> From: Kuniyuki Iwashima <kuniyu@google.com>
> 
> Without the previous commit, TCP failed to switch to alternative
> IPv6 routes immediately upon carrier loss.
> 
> It would persist with the dead route until reaching the threshold
> net.ipv4.tcp_retries1, leading to unnecessary delays in failover.
> 
> Let's add a selftest for this scenario to ensure TCP fails over
> immediately upon a carrier loss event.
> 
> Before:
>   TEST: TCP IPv4 failover                                             [ OK ]
>   TEST: TCP IPv6 failover                                             [FAIL]
> 
> After:
>   TEST: TCP IPv4 failover                                             [ OK ]
>   TEST: TCP IPv6 failover                                             [ OK ]
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Sagarika Sharma <sharmasagarika@google.com>

Thanks for the test. LGTM. A couple of nits below.

[...]

> diff --git a/tools/testing/selftests/net/tcp_ecmp_failover.sh b/tools/testing/selftests/net/tcp_ecmp_failover.sh
> new file mode 100755
> index 000000000000..f857d5db84d8
> --- /dev/null
> +++ b/tools/testing/selftests/net/tcp_ecmp_failover.sh

[...]

> +
> +test_ipv4
> +test_ipv6

Maybe squash something like [1]? I ran the test without the first patch
and I get:

# ./tcp_ecmp_failover.sh 
TEST: TCP IPv4 failover                                             [ OK ]
TEST: TCP IPv6 failover                                             [FAIL]
# echo $?
0

[1]
diff --git a/tools/testing/selftests/net/tcp_ecmp_failover.sh b/tools/testing/selftests/net/tcp_ecmp_failover.sh
index f857d5db84d8..8b7a2d82c442 100755
--- a/tools/testing/selftests/net/tcp_ecmp_failover.sh
+++ b/tools/testing/selftests/net/tcp_ecmp_failover.sh
@@ -205,5 +205,10 @@ test_ipv6()
 	cleanup
 }
 
+require_command socat
+require_command tcpdump
+
 test_ipv4
 test_ipv6
+
+exit "$EXIT_STATUS"

